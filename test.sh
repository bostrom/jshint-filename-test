#!/bin/bash

jshint --version

echo "\$ jshint --verbose src/index.js"
jshint --verbose src/index.js

echo "\$ jshint --verbose --filename src/index.js - < src/index.js"
jshint --verbose --filename src/index.js - < src/index.js


echo "\$ jshint --verbose src/app/main/js/main.js"
jshint --verbose src/app/main/js/main.js

echo "\$ jshint --verbose --filename src/app/main/js/main.js - < src/app/main/js/main.js"
jshint --verbose --filename src/app/main/js/main.js - < src/app/main/js/main.js

