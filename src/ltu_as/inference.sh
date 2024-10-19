#!/bin/bash

# Define the directory paths
DIR1="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls"
DIR2="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls/vicuna"
DIR3="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls/vicuna_ltu"
DIR4="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls/vicuna_ltuas"

# Dropbox URLs for downloading ZIP files
DOWNLOAD_URL_VICUNA="https://www.dropbox.com/scl/fo/mjn5wdnc1j67kkhbu0j9d/h?rlkey=anna5roa7netrmkjjm8p2hvyy&dl=1"
DOWNLOAD_URL_LTU="https://www.dropbox.com/scl/fo/wzw72e9e88x6nfd94zwi7/h?rlkey=9izvxo6eegww5qfkukz2bhdch&dl=1"
DOWNLOAD_URL_LTUAS="https://www.dropbox.com/scl/fo/254wkiknythx5vlenic3j/h?rlkey=zzneclei6tmagbxhqlewkj7l3&dl=1"

# Function to check and create directory
check_and_create_dir() {
    if [ ! -d "$1" ]; then
        echo "Directory $1 does not exist. Creating now."
        mkdir -p "$1"
        echo "Directory $1 created."

        # Download and unzip based on directory
        case "$1" in
            "$DIR2")
                echo "Downloading vicuna ZIP file..."
                TEMP_ZIP="${1}/vicuna.zip"
                wget -O "$TEMP_ZIP" "$DOWNLOAD_URL_VICUNA"
                ;;
            "$DIR3")
                echo "Downloading vicuna_ltu ZIP file..."
                TEMP_ZIP="${1}/vicuna_ltu.zip"
                wget -O "$TEMP_ZIP" "$DOWNLOAD_URL_LTU"
                ;;
            "$DIR4")
                echo "Downloading vicuna_ltuas ZIP file..."
                TEMP_ZIP="${1}/vicuna_ltuas.zip"
                wget -O "$TEMP_ZIP" "$DOWNLOAD_URL_LTUAS"
                ;;
        esac

        if [[ ! -z "$TEMP_ZIP" ]]; then
            echo "Download complete. Unzipping..."
            unzip "$TEMP_ZIP" -d "$1"
            rm "$TEMP_ZIP"
            echo "Unzip complete."
        fi
    else
        echo "Directory $1 already exists."
    fi
}

# Check and create directories
check_and_create_dir "$DIR1"
check_and_create_dir "$DIR2"
check_and_create_dir "$DIR3"
check_and_create_dir "$DIR4"

create_symlink() {
    if [ ! -L "$2" ]; then
        if [ -f "$1" ]; then
            ln -s "$1" "$2"
            echo "Symbolic link created from $1 to $2"
        else
            echo "Source file $1 does not exist, cannot create symbolic link."
        fi
    else
        echo "Symbolic link $2 already exists."
    fi
}

# Define the source and target files for the symbolic links
SOURCE_FILE1="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls/vicuna/pytorch_model-00001-of-00002.bin"
TARGET_FILE1_LTU="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls/vicuna_ltu/pytorch_model-00001-of-00002.bin"
TARGET_FILE1_LTUAS="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls/vicuna_ltuas/pytorch_model-00001-of-00002.bin"
SOURCE_FILE2="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls/vicuna/pytorch_model-00002-of-00002.bin"
TARGET_FILE2_LTU="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls/vicuna_ltu/pytorch_model-00002-of-00002.bin"
TARGET_FILE2_LTUAS="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls/vicuna_ltuas/pytorch_model-00002-of-00002.bin"

# Create symbolic links for vicuna_ltu and vicuna_ltuas
create_symlink "$SOURCE_FILE1" "$TARGET_FILE1_LTU"
create_symlink "$SOURCE_FILE1" "$TARGET_FILE1_LTUAS"
create_symlink "$SOURCE_FILE2" "$TARGET_FILE2_LTU"
create_symlink "$SOURCE_FILE2" "$TARGET_FILE2_LTUAS"

DOWNLOAD_URL="https://www.dropbox.com/scl/fi/ryoqai0ayt45k07ib71yt/ltuas_long_noqa_a6.bin?rlkey=1ivttmj8uorf63dptbdd6qb2i&dl=1"

TARGET_DIR="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls"
TARGET_FILE="${TARGET_DIR}/ltuas_long_noqa_a6.bin"

if [ -f "$TARGET_FILE" ]; then
    echo "File already exists: $TARGET_FILE"
else
    mkdir -p "$TARGET_DIR"

    wget -O "$TARGET_FILE" "$DOWNLOAD_URL"
    echo "Download complete. File saved to $TARGET_FILE"
fi

DOWNLOAD_URL="https://www.dropbox.com/scl/fi/ir69ci3bhf4cthxnnnl76/ltu_ori_paper.bin?rlkey=zgqin9hh1nn2ua39jictcdhil&dl=1"

TARGET_DIR="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls"
TARGET_FILE="${TARGET_DIR}/ltu_ori_paper.bin"

if [ -f "$TARGET_FILE" ]; then
    echo "File already exists: $TARGET_FILE"
else
    mkdir -p "$TARGET_DIR"

    wget -O "$TARGET_FILE" "$DOWNLOAD_URL"
    echo "Download complete. File saved to $TARGET_FILE"
fi

mkdir -p /n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/eval_data/

FILE_URL="https://www.dropbox.com/scl/fo/juh1dk9ltvhghuj0l1sag/h?rlkey=0n2cd5kebzh8slwanjzrfn7q6&dl=1"
wget -O download.zip "$FILE_URL"
unzip -n download.zip -d /n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/eval_data/  # -n option to not overwrite existing files
rm download.zip
FILE_URL="https://www.dropbox.com/scl/fo/o91k6cnwqft84tgmuotwg/h?rlkey=6bnjobvrbqbt4rqt3f1tgaeb8&dl=1"
wget -O download.zip "$FILE_URL"
unzip -n download.zip -d /n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/eval_data/  # -n option to not overwrite existing files
rm download.zip

DEST_FILE="/n/holyscratch01/glassman_lab/Users/zhentingqi/my_projects/audio/pretrained_mdls/large-v1.pt"

if [ ! -f "$DEST_FILE" ]; then
    wget -O "$DEST_FILE" "https://www.dropbox.com/scl/fi/r7sfa5y2kh7nc8lpmdv9a/large-v1.pt?rlkey=ffc8abmxjy69vxairb336mkhq&dl=1"
else
    echo "File already exists: $DEST_FILE"
fi

python inference_gradio.py