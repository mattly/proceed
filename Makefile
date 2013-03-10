REPORTER ?= dot

test: test-unit

test-unit:
	@NODE_ENV=test \
	  ./node_modules/.bin/mocha \
	  --compilers coffee:coffee-script \
	  --reporter $(REPORTER)

package.json:
	coffee package.coffee > package.json

index.js:
	coffee src/proceed.coffee > index.js

clean:
	rm -f index.js
	rm -f package.json

.PHONY: test test-unit clean

