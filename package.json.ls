name: 'grasp-squery'
version: '0.2.1'

author: 'George Zahariev <z@georgezahariev.com>'
description: 'Grasp query backend using css style selectors'
homepage: 'http://graspjs.com/docs/squery'
keywords:
  'grasp'
  'query'
  'squery'
  'ast'
  'selectors'
  'javascript'
  'css'
  'search'

files:
  'lib'
  'README.md'
  'LICENSE'
main: './lib/'

bugs: 'https://github.com/gkz/grasp-squery/issues'
licenses:
  * type: 'BSD'
    url: 'https://raw.github.com/gkz/grasp-squery/master/LICENSE'
  ...
engines:
  node: '>= 0.8.0'
repository:
  type: 'git'
  url: 'git://github.com/gkz/grasp-squery.git'
scripts:
  test: 'make test'

dependencies:
  'prelude-ls': '~1.1.0'
  'grasp-syntax-javascript': '~0.1.0'

dev-dependencies:
  LiveScript: '~1.2.0'
  mocha: '~1.8.2'
  istanbul: '~0.1.43'
  acorn: '~0.4.2'
