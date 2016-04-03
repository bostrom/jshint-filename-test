# Possible jshint bug

The files in this repository contain ```console.log```s and
undefined variables. The ```.jshintrc``` file defines
global ```"undef": false``` and ```"console": true``` rules for
all files in the project, which ignores the undefined variables
but complains about the ```console.log```s.
An ```"override"``` is configured for files matching
```src/app/**/*.js``` enforcing ```"undef": true``` on those files.

Using this configuration jshint should display ```console``` errors for
all files, ```undef``` errors for ```src/app/main/js/main.js```
but no ```undef``` errors for ```app/index.js```.

## Demo

The following commands shows that the ```--filename``` option
doesn't have the desired effect when passing the file over ```STDIN```.

### Check version

```
$ jshint --version
jshint v2.9.1
```

### Linting index.js passing file as argument

```
$ jshint --verbose src/index.js
src/index.js: line 0, col 0, Bad option: 'console'. (E001)

1 error
```

Works as expected.

### Linting index.js passing file over STDIN

```
$ jshint --verbose --filename src/index.js - < src/index.js
/Users/bostrfr/Projects/Learning/jshint-filename/src/index.js: line 0, col 0, Bad option: 'console'. (E001)

1 error
```

Works as expected.

### Linting main.js passing file as argument

```
$ jshint --verbose src/app/main/js/main.js
src/app/main/js/main.js: line 0, col 0, Bad option: 'console'. (E001)
src/app/main/js/main.js: line 1, col 1, 'console' is not defined. (W117)
src/app/main/js/main.js: line 1, col 13, 'main' is not defined. (W117)

3 errors
```

Works as expected.

### Linting main.js passing file over STDIN

```
$ jshint --verbose --filename src/app/main/js/main.js - < src/app/main/js/main.js
/Users/bostrfr/Projects/Learning/jshint-filename/src/app/main/js/main.js: line 0, col 0, Bad option: 'console'. (E001)

1 error
```

**Unexpected result!** The ```"overrides"``` configuration doesn't seem to have any effect in this case!
