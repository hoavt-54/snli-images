~/python3 ../train_simple_vte_model.py --train_filename=../../datasets/snli_1.0/snli_1.0_train_filtered.tokens --dev_filename=../../datasets/snli_1.0/snli_1.0_dev_filtered.tokens --vectors_filename=../../../pre-wordvec/glove.840B.300d.txt --img_names_filename=/mnt/8tera/claudio.greco/flickr30k_resnet101_img_names.json --img_features_filename=/mnt/8tera/claudio.greco/flickr30k_resnet101_img_features.npy --model_save_filename=checkpoints/simple_vte/vsnli_train
~/python3 ../eval_simple_vte_model.py --model_filename=checkpoints/simple_vte/vsnli_train --test_filename=../../datasets/snli_1.0/snli_1.0_test_filtered.tokens --img_names_filename=/mnt/8tera/claudio.greco/flickr30k_resnet101_img_names.json --img_features_filename=/mnt/8tera/claudio.greco/flickr30k_resnet101_img_features.npy --result_filename=results/simple_vte/vsnli_train_to_vsnli_test
~/python3 ../eval_simple_vte_model.py --model_filename=checkpoints/simple_vte/vsnli_train --test_filename=../../datasets/SICK/VSICK2/VSICK2.tokens --img_names_filename=/mnt/8tera/claudio.greco/flickr8k_resnet101_img_names.json --img_features_filename=/mnt/8tera/claudio.greco/flickr8k_resnet101_img_features.npy --result_filename=results/simple_vte/vsnli_train_to_vsick2
~/python3 ../eval_simple_vte_model.py --model_filename=checkpoints/simple_vte/vsnli_train --test_filename=../../datasets/SICK/VSICK2/difficult_VSICK2.tokens --img_names_filename=/mnt/8tera/claudio.greco/flickr8k_resnet101_img_names.json --img_features_filename=/mnt/8tera/claudio.greco/flickr8k_resnet101_img_features.npy --result_filename=results/simple_vte/vsnli_train_to_difficult_vsick2
