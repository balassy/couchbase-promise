# couchbase-promise

> A promise-based asynchronous library for Couchbase and node.js.

The [Official Couchbase Node.js Client Library](https://www.npmjs.com/package/couchbase) provides only callback functions to handle the result of the asynchronous operations. This `couchbase-promise` library wraps those callback functions with [Bluebird](https://www.npmjs.com/package/bluebird) promises to provide a convenient, promise-based interface.

[![Build Status](https://travis-ci.org/balassy/couchbase-promise.svg?branch=master)](https://travis-ci.org/balassy/couchbase-promise) [![Build status](https://ci.appveyor.com/api/projects/status/fmu0995508qv0q3b?svg=true)](https://ci.appveyor.com/project/balassy/couchbase-promise) [![NPM version](http://img.shields.io/npm/v/couchbase-promise.svg)](https://www.npmjs.com/package/couchbase-promise) [![Downloads](http://img.shields.io/npm/dm/couchbase-promise.svg)](https://www.npmjs.com/package/couchbase-promise)

[![NPM](https://nodei.co/npm/couchbase-promise.png?downloads=true)](https://nodei.co/npm/couchbase-promise/)

## Usage

First, install `couchbase-promise` as a dependency:

```shell
npm install --save couchbase-promise
```

Then, reference it in your code file:

```javascript
var Repository = require('couchbase-promise');
```

Initialize the repository with the connection string and the name of the bucket you want to connect to:

```javascript
Repository.init('http://localhost:8091', 'default');
```

Use the static methods of the `Repository` class to manage documents stored in your Couchbase database directly by their document identifiers:

- `createAsync`
- `existsAsync`
- `getAsync`
- `replaceAsync`
- `deleteAsync`

You can also use the `getViewAsync` method to query a document by a view.


## Limitations

 - As a static class, currently supports only one connection string and one bucket.
 - The views are always updated before reading data from them (`stale` not configurable yet).

> **Tip**: If you find anything that limits the usage of this library for you, feel free the post a new [issue](https://github.com/balassy/couchbase-promise/issues) and describe it.