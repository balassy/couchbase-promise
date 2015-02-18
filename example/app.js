var Repository = require('couchbase-promise');
var Uuid = require('node-uuid');

var connectionString = 'http://localhost:8091';
var bucketName = 'default';

var docId = Uuid.v4().toString();
var docContent = { message: 'Hello World' };

console.log('Application start.')

Repository.init(connectionString, bucketName);

Repository.createAsync(docId, docContent)
  .then(function(){
    console.log('Document created with ID=' + docId);
    return Repository.existsAsync(docId);
  })
  .then(function(exist){
    console.log('Document exists after create? ' + exist);
    return Repository.getAsync(docId);
  })
  .then(function (docContent) {
    console.log('Reading back the created document:');
    console.dir(docContent);
    return Repository.deleteAsync(docId);
  })
  .then(function () {
    console.log('Document deleted.');
    return Repository.existsAsync(docId);
  })
  .then(function (exists) {
    console.log('Document exists after delete? ' + exists);
    console.log('Trying to read the deleted document...');
    return Repository.getAsync(docId);
  })
  .then(function (docContent) {
    // This 'then' should never execute!
    console.log('Reading back the deleted document:');
    console.dir(docContent);
  })
  .error(function (error) {
    console.log('Failed! Error = ' + error);
  })
  .done(function(){
    console.log('Done.');
    process.exit(0);
  });

console.log('Application end.');
