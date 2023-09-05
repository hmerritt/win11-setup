
echo "Setting up Node.js with yarn"


#  Nvm install
nvm install 20.3.1
nvm use 20.3.1
refreshenv


# Yarn
corepack enable
corepack prepare yarn@stable --activate
yarn set version stable


# Global installs
npm -g i tsc nx


refreshenv

