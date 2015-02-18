"use strict"
assert = require 'assert'

suite 'First', () ->
  suite 'Second', () ->
    test 'Test if runs', () ->
      assert.equal 1, 1
