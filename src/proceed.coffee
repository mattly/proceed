module.exports = proceed = (initial) ->
  context = {}

  setter = (callback) ->
    (keys...) ->
      (err, result...) ->
        if err then return callback(err)
        context[keys[idx]] = arg for arg, idx in result when keys[idx]
        callback(err, result...)

  steps = []
  last = -> steps[steps.length - 1]

  next = (err) ->
    if err then return steps.pop()(err)
    nextFn = steps.shift() or ->
    if nextFn instanceof Array then join(nextFn, next)
    else exec(nextFn, next)

  exec = (fn, done) ->
    if steps.length is 0 then fn() else fn(done)

  join = (arr, done) ->
    count = 0
    decr = ->
      count -= 1
      if count is 0 then done()
    for fn, idx in arr
      count += 1
      fn(decr)

  stack = (callback) ->
    stack.push(callback)
    stack

  stack.push = (fn) ->
    steps.push (next) ->
      if next
        next.set = setter(next)
        fn.apply(context, [next])
      else
        fn.apply(undefined, undefined, context)
    stack

  stack.push(initial)

  stack.join = (fn) ->
    if last() instanceof Array then last().push(fn)
    else steps.push([steps.pop(), fn])
    stack

  stack.tap = (fn) ->
    steps.push (next) ->
      fn.apply(context)
      process.nextTick(next)
    stack

  process.nextTick(next)

  stack

