#!/bin/bash

clear

setEnv(){

    #=================================================================================================
    #Create a virtualenv with the name $venv
    #=================================================================================================

    echo Virtualenv folder name:
    read venv

    python3 -m venv $venv
    source $venv/bin/activate

    #=================================================================================================
    #Upgrade pip and install Azure requeriments for DevOps
    #=================================================================================================

    python3 -m pip install --upgrade pip

    pip3 install keyring
    pip3 install artifacts-keyring --pre

    source token.sh

    #=================================================================================================
    #Ask for the token and create a new login in enerBIT DevOps
    #=================================================================================================

    #echo $token
    echo "[global]
    extra-index-url=https://$token@$repo" > $venv/pip.conf

    #=================================================================================================
    #Install requeriments including ECC
    #=================================================================================================

    python3 -m pip install --upgrade pip
    python3 -m pip install -r requeriments.txt

}

echo Setting the environment

#=================================================================================================
#Check for token.sh file
#=================================================================================================

FILE=token.sh
if [ -f "$FILE" ]; then

    setEnv

else 

    echo Error: create a $FILE file as the next template: "\n" repo="YourAzureRepo" "\n" token="YourToken"

fi
