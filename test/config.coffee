"use strict"

Uuid = require 'node-uuid'


module.exports = {
  db:
    connectionString: 'http://localhost:8091'
    bucket: 'default'
  doc:
    id: Uuid.v4().toString()
    content:
      message: 'Hello World!'
}