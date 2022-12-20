#!/bin/bash

install_packages() {
    if [[ $1 -eq 0 ]]
    then
        npm i
    else
        yarn
    fi
}

setup () {
    # create folders
    mkdir building management gateway statue

    # create env
    ## building
    cd ./building
    git clone https://github.com/phatnguyen1006/MS_DragonWharfMgmt_BE_Building.git
    mv MS_DragonWharfMgmt_BE_Building/* ./
    rm -rf MS_DragonWharfMgmt_BE_Building
    echo -e "PORT = 8002\n\
    MONGO_URI = mongodb+srv://dragonwharf:dragonwharf@building.gc7pqvw.mongodb.net/DragonWharf?retryWrites=true&w=majority"\
    >> ./.env
    install_packages $1

    ## turn back $root
    cd ..

    ## management
    cd ./management
    git clone https://github.com/phatnguyen1006/MS_DragonWharf_Management.git
    mv MS_DragonWharf_Management/* ./
    rm -rf MS_DragonWharf_Management
    echo -e "PORT = 8001\n\
    MONGO_URI=mongodb+srv://dbGis:khongbiet@cluster0.8vvd2ak.mongodb.net/?retryWrites=true&w=majority\n\
    SECRET_TOKEN=99f4c27f77ff15ca508d7bcf61fb7088dac21f54d0572559183442bed47dec69\n\
    SECRET_TOKEN_REFRESH=9463c4cf5ee1a684559042d2949caccc81b708d3afc0f0fbcb4fc97eb2d99fc2\n\
    EXPIRE_TOKEN=1d\n\
    EXPIRE_REFRESH_TOKEN=2d"\
    >> ./.env
    install_packages $1

    ## turn back $root
    cd ..

    ## statue
    cd ./statue
    git clone https://github.com/phatnguyen1006/MS_DragonWharfMgmt_BE_Statue.git
    mv MS_DragonWharfMgmt_BE_Statue/* ./
    rm -rf MS_DragonWharfMgmt_BE_Statue
    echo -e "PORT = 8003\n\
    BASE_PROTOCOL=http\n\
    BASE_IP=localhost\n\
    BASE_PORT=8000\n\
    BASE_NODE=statue\
    " >> ./.env
    install_packages $1

    ## turn back $root
    cd ..

    ## gateway
    cd ./gateway
    git clone https://github.com/phatnguyen1006/MS_DragonWharfMgmt_BE_GateWay.git
    mv MS_DragonWharfMgmt_BE_GateWay/* ./
    rm -rf MS_DragonWharfMgmt_BE_GateWay
    echo -e "PORT = 8000\n\
    MANAGEMENT_NODE_URL=http://localhost:8001\n\
    BUILDING_NODE_URL=http://localhost:8002\n\
    STATUE_NODE_URL=http://localhost:8003"\
    >> ./.env
    install_packages $1

    ## turn back $root
    cd ..

    echo "********** FINISHED SETUP **********"

}

PS3='Please enter your lib management (type 1 or 2): '
options=("NPM" "Yarn")
select opt in "${options[@]}"
do
    case $opt in
        "NPM")
            echo "You chose choice NPM";
            setup 0;
            break;
            ;;
        "Yarn")
            echo "You chose choice Yarn";
            setup 1;
            break;
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
