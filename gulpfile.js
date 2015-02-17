var gulp = require('gulp')
  , coffee = require("gulp-coffee")
  , coffeelint = require("gulp-coffeelint")
  , runSequence = require('run-sequence')
  , del = require('del');

var sourceFiles = ['./src/**/*.coffee', '!node_modules/**/*'];
var outputFolder = './lib';


gulp.task('clean', function () {
  del([outputFolder], { force: true });
});


gulp.task('compile', function () {
  gulp.src(sourceFiles)
    .pipe(coffee())
    .pipe(gulp.dest(outputFolder));
});


gulp.task('lint', function () {
  gulp.src(sourceFiles)
    .pipe(coffeelint())
    .pipe(coffeelint.reporter());
});


gulp.task('build', function () {
  runSequence('lint', 'clean', 'compile');
});