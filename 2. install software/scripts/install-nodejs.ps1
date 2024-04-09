
echo "Setting up Node.js with yarn"


#  Nvm install
nvm install 20.8.0
nvm use 20.8.0
refreshenv


# Yarn
corepack enable
corepack prepare yarn@stable --activate
yarn set version stable
yarn plugin import interactive-tools


# Global installs
npm -g i tsc nx


refreshenv

