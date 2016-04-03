# Possible jshint bug

The files in this repository contain ```==``` comparisons and
undefined variables. The ```.jshintrc``` file defines
global ```"undef": false``` and ```"eqeqeq": true``` rules for
all files in the project, which ignores the undefined variables
but complains about the ```==```s.
An ```"override"``` is configured for files matching
```src/app/**/*.js``` enforcing ```"undef": true``` on those files.

```
{
  "undef": false,
  "eqeqeq": true,
  "overrides": {
    "src/app/**/*.js": {
      "undef": true
    }
  }
}
```

Using this configuration jshint should display ```==``` errors for
all files, ```undef``` errors for ```src/app/main/js/main.js```
but no ```undef``` errors for ```app/index.js```.

## Demo

The following commands shows that the ```--filename``` option
doesn't have the desired effect when passing the file over ```STDIN```.

Commands can be run by running the ```test.sh``` script.

### Check version

```
$ jshint --version
jshint v2.9.1
```

### Linting index.js passing file as argument

```
$ jshint --verbose src/index.js
src/index.js: line 1, col 24, Expected '===' and instead saw '=='. (W116)

1 error
```

Works as expected.

### Linting index.js passing file over STDIN

```
$ jshint --verbose --filename src/index.js - < src/index.js
/Users/bostrfr/Projects/Learning/jshint-filename/src/index.js: line 1, col 24, Expected '===' and instead saw '=='. (W116)

1 error
```

Works as expected.

### Linting main.js passing file as argument

```
$ jshint --verbose src/app/main/js/main.js
src/app/main/js/main.js: line 1, col 22, Expected '===' and instead saw '=='. (W116)
src/app/main/js/main.js: line 1, col 15, 'main' is not defined. (W117)
src/app/main/js/main.js: line 1, col 30, 'main' is not defined. (W117)

3 errors
```

Works as expected.

### Linting main.js passing file over STDIN

```
$ jshint --verbose --filename src/app/main/js/main.js - < src/app/main/js/main.js
/Users/bostrfr/Projects/Learning/jshint-filename/src/app/main/js/main.js: line 1, col 22, Expected '===' and instead saw '=='. (W116)

1 error
```

**Unexpected result!** The ```"overrides"``` configuration doesn't seem to have any effect in this case!


## Workaround

Changing the ```"overrides"``` matching pattern to ```"**/src/app/**/*.js"```
will again match the main.js file in the above case.

```
{
  "undef": false,
  "eqeqeq": true,
  "overrides": {
    "**/src/app/**/*.js": {
      "undef": true
    }
  }
}
```
