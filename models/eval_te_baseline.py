import atexit
import json
import os
import pickle
import random
from argparse import ArgumentParser

import numpy as np
import tensorflow as tf
from tensorflow.core.protobuf import saver_pb2

from dataset import load_te_dataset
from logger import start_logger, stop_logger
from train_te_baseline import build_te_baseline_model
from utils import batch

if __name__ == "__main__":
    os.environ["PYTHONHASHSEED"] = "0"
    random_seed = 12345
    random.seed(random_seed)
    np.random.seed(random_seed)
    tf.set_random_seed(random_seed)
    parser = ArgumentParser()
    parser.add_argument("--test_filename", type=str, required=True)
    parser.add_argument("--model_filename", type=str, required=True)
    parser.add_argument("--result_filename", type=str, required=True)
    args = parser.parse_args()
    start_logger(args.result_filename)
    atexit.register(stop_logger)

    print("-- Loading params")
    with open(args.model_filename + ".params", mode="r") as in_file:
        params = json.load(in_file)

    print("-- Loading index")
    with open(args.model_filename + ".index", mode="rb") as in_file:
        index = pickle.load(in_file)
        token2id = index["token2id"]
        id2token = index["id2token"]
        label2id = index["label2id"]
        id2label = index["id2label"]
        num_tokens = len(token2id)
        num_labels = len(label2id)

    print("-- Loading test set")
    test_labels, test_premises, test_hypotheses = load_te_dataset(args.test_filename, token2id, label2id)

    print("-- Restoring model")
    premise_input = tf.placeholder(tf.int32, (None, None), name="premise_input")
    hypothesis_input = tf.placeholder(tf.int32, (None, None), name="hypothesis_input")
    label_input = tf.placeholder(tf.int32, (None,), name="label_input")
    dropout_input = tf.placeholder(tf.float32, name="dropout_input")
    logits = build_te_baseline_model(
        premise_input,
        hypothesis_input,
        dropout_input,
        num_tokens,
        num_labels,
        None,
        params["embeddings_size"],
        params["train_embeddings"],
        params["rnn_hidden_size"]
    )
    saver = tf.train.Saver(write_version=saver_pb2.SaverDef.V1)
    with tf.Session() as session:
        saver.restore(session, args.model_filename + ".ckpt")

        print("-- Evaluating model")
        test_num_examples = test_labels.shape[0]
        test_batches_indexes = np.arange(test_num_examples)
        test_num_correct = 0

        for indexes in batch(test_batches_indexes, params["batch_size"]):
            test_batch_premises = test_premises[indexes]
            test_batch_hypotheses = test_hypotheses[indexes]
            test_batch_labels = test_labels[indexes]
            predictions = session.run(
                tf.argmax(logits, axis=1),
                feed_dict={
                    premise_input: test_batch_premises,
                    hypothesis_input: test_batch_hypotheses,
                    dropout_input: 1.0
                }
            )
            test_num_correct += (predictions == test_batch_labels).sum()
        test_accuracy = test_num_correct / test_num_examples
        print("Mean test accuracy: {}".format(test_accuracy))