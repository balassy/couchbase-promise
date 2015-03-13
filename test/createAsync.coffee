"use strict"

Chai = require 'chai'
ChaiAsPromised = require 'chai-as-promised'
assert = Chai.assert
Repository = require '../src'
Config = require './config'

Chai.use(ChaiAsPromised)


suite 'createAsync', () ->
  suiteSetup ->
    Repository.init Config.db.connectionString, Config.db.bucket

  suiteTeardown ->
    Repository.close()

  test 'Should return null', ->
    promise = Repository.createAsync Config.doc.id, Config.doc.content
    assert.eventually.isNull promise
