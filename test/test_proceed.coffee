assert = require('chai').assert

proceed = require('../src/proceed')

describe "flow control", ->
  counter = undefined

  waitIncr = (len=0) ->
    (callback) ->
      counter += 1
      setTimeout(callback, len)

  nextIncr = waitIncr()

  beforeEach ->
    counter = 0

  it "runs the stack in series", (done) ->
    proceed(nextIncr)
      .push(nextIncr).push(nextIncr)
      .tap(-> assert.equal(3, counter))
      .push(nextIncr).push(nextIncr)
      .tap(-> assert.equal(5, counter))
      .push(done)

  it "runs joins in parallel", (done) ->
    start = Date.now()
    proceed(waitIncr(20))
      .join(waitIncr(50))
      .join(waitIncr(30))
      .tap(-> assert.equal(3, counter))
      .tap(-> assert.closeTo(Date.now() - start, 50, 10))
      .push(done)

describe "contexts", ->
  setter = (theVal) ->
    (callback) -> callback(undefined, theVal)

  it "exposes the context to the stack contenxts", (done) ->
    proceed((c) -> setter(41)(c.set('val')))
      .push((c) -> setter(42)(c.set('val')))
      .tap(-> assert.equal(@val, 42))
      .push(done)
