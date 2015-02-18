# Example

This sample shows how you can use the [couchbase-promise](https://github.com/balassy/couchbase-promise) NPM package in your node.js application.

The application executes the following operations in this order:

1. Connects to the `default` bucket of the Couchbase server running on `http://127.0.0.1:8091`.
2. Generates a new, unique document identifier (GUID) with the `node-uuid` library.
3. Creates a new document with the generated identifier and with a simple content.
4. Checks whether the document exists in the database (yes).
5. Reads back the document and displays its content (success).
6. Deletes the document (success).
7. Checks whether the document exists in the database (no).
8. Tries to read back the document (fail).
9. Displays an error message.

