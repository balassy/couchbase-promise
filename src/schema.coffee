Joi = require 'joi'

module.exports =

  validateFunction: (value) -> Joi.assert value, Joi.func().required()

  validateConnectionString: (value) -> Joi.assert value, Joi.string().required(), 'Repository error: The connection string is missing!'

  validateBucketName: (value) -> Joi.assert value, Joi.string().required(), 'Repository error: The bucket name is missing!'

  validateDocId: (value) -> Joi.assert value, Joi.string().required(), 'Repository error: The document ID is missing!'

  validateDesignDocumentName: (value) -> Joi.assert value, Joi.string().required(), 'Repository error: The design document name is missing!'

  validateViewName: (value) -> Joi.assert value, Joi.string().required(), 'Repository error: The view name is missing!'

  validateKey: (value) -> Joi.assert value, Joi.string().required(), 'Repository error: The key is missing!'

