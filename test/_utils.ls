{query} = require '..'
require! [acorn, assert]
{map, all, is-type} = require 'prelude-ls'

p = (input, {unwrap-exp-state=true, unwrap-program=true} = {}) ->
  res = acorn.parse input
  res2 = if unwrap-program then res.body.0 else res
  res3 = if unwrap-exp-state and res2.type is 'ExpressionStatement' then res2.expression else res2
  if res3.type is 'ObjectExpression'
    for prop in res3.properties
      prop.type = 'Property'
  res3

extract = (options, input) -->
  if is-type 'Object', input
    input
  else
    res = p input, options

q = (selector, code, locations = false) ->
  query selector, (acorn.parse code, {locations})

deep-equal = (actual, expected) ->
  type-actual = typeof! actual
  type-expected = typeof! expected
  assert.strict-equal type-actual, type-expected, "typeof actual and expected do not match: #type-actual, #type-expected"
  switch type-actual
  | 'Array'   =>
    assert.strict-equal actual.length, expected.length, "array length not equal: #{ JSON.stringify actual}, #{JSON.stringify expected}"
    for x, i in actual
      deep-equal x, expected[i]
  | 'Object'  =>
    for key, val of actual when key not in <[ start end ]>
      deep-equal val, expected[key]
  | otherwise => assert.deep-equal actual, expected, "primitive value not equal: #actual, #expected"

eq = (answers, selectors, code, unwrap-exp-state = true, unwrap-program = true, loc = false) ->
  assert code, 'no code given'
  answers = [].concat answers
  selectors = [].concat selectors

  for selector in selectors
    results = q selector, code, loc
    extracted-answers = (map (extract {unwrap-exp-state, unwrap-program}), answers)
    try
      deep-equal results, extracted-answers
    catch
      console.log extracted-answers
      console.log results
      throw e

module.exports = {eq, p, q}
