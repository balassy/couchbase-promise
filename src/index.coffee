Colors = require 'colors'
Couchbase = require 'couchbase'
ViewQuery = Couchbase.ViewQuery
Promise = require 'bluebird'

'use strict'

# Source: https://github.com/couchbase/php-ext-couchbase/blob/master/example/couchbase-api.php
CouchbaseConstants =
  COUCHBASE_KEY_ENOENT: 0x0d    # LCB_KEY_ENOENT: The key does not exist.


class Repository
  @cluster

  @bucket

  @init: (connectionString, bucketName) ->
    console.error 'Repository error: The connection string is missing!' if !connectionString
    console.error 'Repository error: The bucket name is missing!' if !bucketName

    @cluster = new Couchbase.Cluster connectionString
    @bucket = @cluster.openBucket bucketName, (err) ->
      if err?
        console.error "Repository error: Failed to connect to the '#{bucketName}' bucket on the Couchbase cluster: #{connectionString}".red.bold
        process.exit 1
      else
        console.log "Successfully connected to the '#{bucketName}' bucket on the Couchbase cluster #{connectionString}".green


  @existsAsync: (docId) =>
    new Promise (fulfill, reject) =>
      @bucket.get docId, (error, result) ->
        if error?
          if error.code == CouchbaseConstants.COUCHBASE_KEY_ENOENT
            fulfill false
          else
            reject error
        else
          fulfill true


  @getAsync: (docId) =>
    new Promise (fulfill, reject) =>
      @bucket.get docId, (error, result) ->
        if error?
          reject error
        else
          fulfill result.value


  @getViewAsync: (designDocumentName, viewName, key) =>
    new Promise (fulfill, reject) =>
      query = ViewQuery.from(designDocumentName, viewName).key(key).stale(ViewQuery.Update.BEFORE)
      @bucket.query query, (error, results) ->
        if error?
          reject error
        else
          fulfill results


  @createAsync: (docId, docContent) =>
    new Promise (fulfill, reject) =>
      @bucket.insert docId, docContent, (error, result) ->
        if error?
          reject error
        else
          fulfill null


  @replaceAsync: (docId, docContent) =>
    new Promise (fulfill, reject) =>
      @bucket.replace docId, docContent, (error, result) ->
        if error?
          reject error
        else
          fulfill null


  @deleteAsync: (docId) =>
    new Promise (fulfill, reject) =>
      @bucket.remove docId, (error, result) ->
        if error?
          reject error
        else
          fulfill null


module.exports = Repository