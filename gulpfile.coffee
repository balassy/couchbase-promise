Gulp = require 'gulp'
Coffee = require 'gulp-coffee'
Coffeelint = require 'gulp-coffeelint'
RunSequence = require 'run-sequence'
Del = require 'del'
Mocha = require 'gulp-mocha'

sourceFiles = ['./src/**/*.coffee', '!node_modules/**/*']
outputFolder = './lib'


Gulp.task 'clean', ->
  Del([outputFolder], { force: true })


Gulp.task 'compile', ->
  Gulp.src(sourceFiles)
    .pipe(Coffee())
    .pipe(Gulp.dest(outputFolder))


Gulp.task 'lint', ->
  Gulp.src(sourceFiles)
    .pipe(Coffeelint())
    .pipe(Coffeelint.reporter())


Gulp.task 'test', ->
  require 'coffee-script/register'
  Gulp.src('test/**/*.coffee', { read: false })
    .pipe(Mocha({reporter: 'spec'}))


Gulp.task 'build', ->
  RunSequence('lint', 'clean', 'compile')
