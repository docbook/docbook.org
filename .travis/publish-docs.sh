#!/bin/bash

set | grep TRAVIS

if [ "$TRAVIS_REPO_SLUG" == "$GIT_PUB_REPO" ]; then
    echo -e "Setting up for publication...\n"

    cd $HOME
    git config --global user.email ${GIT_EMAIL}
    git config --global user.name ${GIT_NAME}
    git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/${GIT_PUB_REPO} gh-pages > /dev/null

    if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
        echo -e "Publishing docs...\n"

        ROOT=/home/travis/build/$TRAVIS_REPO_SLUG

        cd gh-pages
        rsync -ar --delete --exclude .git --exclude .travis --exclude .travis.yml --exclude build.gradle --exclude build --exclude gradle.properties --exclude .gradle --exclude .gitignore $ROOT/ ./

        if [ "$GITHUB_CNAME" != "" ]; then
            echo $GITHUB_CNAME > CNAME
        fi

        git add --all .
        git commit -m "Successful travis build $TRAVIS_BUILD_NUMBER"
        git push -fq origin gh-pages

        echo -e "Published docbook.org to gh-pages\n"
        if [ "$GITHUB_CNAME" != "" ]; then
            echo -e "... at $GITHUB_CNAME"
        else
            echo -e "... not published to a top-level domain"
        fi
    else
        echo -e "Publication cannot be performed on pull requests.\n"
    fi
fi
