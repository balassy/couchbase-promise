Colors = require 'colors'
Couchbase = require 'couchbase'
ViewQuery = Couchbase.ViewQuery
Promise = require 'bluebird'
Schema = require './schema'

'use strict'

# Source: https://github.com/couchbase/php-ext-couchbase/blob/master/example/couchbase-api.php
CouchbaseConstants =
  COUCHBASE_KEY_ENOENT: 0x0d    # LCB_KEY_ENOENT: The key does not exist.


class Repository
  @cluster

  @bucket

  @init: (connectionString, bucketName) ->
    Schema.validateConnectionString(connectionString)
    Schema.validateBucketName(bucketName)

    @cluster = new Couchbase.Cluster connectionString
    @bucket = @cluster.openBucket bucketName, (err) ->
      if err?
        console.error "Repository error: Failed to connect to the '#{bucketName}' bucket on the Couchbase cluster: #{connectionString}".red.bold
        process.exit 1
      else
        console.log "Successfully connected to the '#{bucketName}' bucket on the Couchbase cluster #{connectionString}".green


  @close: ->
    console.error 'Repository error: The bucket must be opened before, please call init!' if !@bucket
    @bucket.disconnect()


  @existsAsync: (docId) =>
    Schema.validateDocId(docId)

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
    Schema.validateDocId(docId)

    new Promise (fulfill, reject) =>
      @bucket.get docId, (error, result) ->
        if error?
          reject error
        else
          fulfill result.value


@getRangeViewAsync: (designDocumentName, viewName, RangeStart, RangeEnd) =>
    Schema.validateDesignDocumentName(designDocumentName)
    Schema.validateViewName(viewName)
  

    new Promise (fulfill, reject) =>
      query = ViewQuery.from(designDocumentName, viewName).range(RangeStart, RangeEnd, true).stale(ViewQuery.Update.BEFORE)
      @bucket.query query, (error, results) ->
        if error?
          reject error
        else
          fulfill results


  @getViewAsync: (designDocumentName, viewName, key, options) =>
    Schema.validateDesignDocumentName(designDocumentName)
    Schema.validateViewName(viewName)
    Schema.validateKey(key)


    new Promise (fulfill, reject) =>
      query = ViewQuery.from(designDocumentName, viewName).key(key).stale(ViewQuery.Update.BEFORE)
      if options query = ViewQuery.from(designDocumentName, viewName).key(key).stale(ViewQuery.Update.BEFORE).options
      @bucket.query query, (error, results) ->
        if error?
          reject error
        else
          fulfill results


  @createAsync: (docId, docContent) =>
    Schema.validateDocId(docId)

    new Promise (fulfill, reject) =>
      @bucket.insert docId, docContent, (error, result) ->
        if error?
          reject error
        else
          fulfill null


  @replaceAsync: (docId, docContent) =>
    Schema.validateDocId(docId)

    new Promise (fulfill, reject) =>
      @bucket.replace docId, docContent, (error, result) ->
        if error?
          reject error
        else
          fulfill null


  @deleteAsync: (docId) =>
    Schema.validateDocId(docId)

    new Promise (fulfill, reject) =>
      @bucket.remove docId, (error, result) ->
        if error?
          reject error
        else
          fulfill null


module.exports = Repository
