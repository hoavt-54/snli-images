~/python3 ../train_simple_te_model_relu_h.py --train_filename=../../datasets/snli_1.0/snli_1.0_train_filtered.tokens --dev_filename=../../datasets/snli_1.0/snli_1.0_dev_filtered.tokens --vectors_filename=../../../pre-wordvec/glove.840B.300d.txt --model_save_filename=../checkpoints/simple_te_model_relu_h/snli_train
~/python3 ../eval_simple_te_model_relu_h.py --model_filename=../checkpoints/simple_te_model_relu_h/snli_train --test_filename=../../datasets/snli_1.0/snli_1.0_test_filtered.tokens --result_filename=../results/simple_te_model_relu_h/snli_train_to_snli_test
~/python3 ../eval_simple_te_model_relu_h.py --model_filename=../checkpoints/simple_te_model_relu_h/snli_train --test_filename=../../datasets/snli_1.0_test_hard.tsv --result_filename=../results/simple_te_model_relu_h/snli_train_to_snli_test_hard
~/python3 ../eval_simple_te_model_relu_h.py --model_filename=../checkpoints/simple_te_model_relu_h/snli_train --test_filename=../../datasets/snli_1.0_test_wrong_image_formatted.tsv --result_filename=../results/simple_te_model_relu_h/snli_train_to_snli_test_wrong
~/python3 ../eval_simple_te_model_relu_h.py --model_filename=../checkpoints/simple_te_model_relu_h/snli_train --test_filename=../../datasets/snli_1.0_test_hard_wrong_image_formatted.tsv --result_filename=../results/simple_te_model_relu_h/snli_train_to_snli_test_hard_wrong
