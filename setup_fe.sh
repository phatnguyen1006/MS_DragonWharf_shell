#!/bin/bash

# create folders
mkdir client admin

# Client Services
cd client
git clone https://github.com/huyvouit/dragon-whaft.git
mv dragon-whaft/* ./
rm -rf ./dragon-whaft
yarn

# reset to root folders
cd ..

# Admin Services
cd admin
git clone https://github.com/NgaNT01/dragon-wharf-admin.git
mv dragon-wharf-admin/* ./
rm -rf ./dragon-wharf-admin
yarn

# reset to root
cd ..

# finish
echo -e "******** FINISH SETUP WEBSITE ********"
