github = 'github.com/mattly/proceed'
tags = 'util functional callbacks fluent promises'.split(' ')
info =
  name: 'proceed'
  description: 'fluent flow control without the boilerplate'
  version: '0.0.1'
  author: 'Matthew Lyon <matthew@lyonheart.us>'
  keywords: tags
  tags: tags
  homepage: "https://#{github}"
  repository: "git://#{github}.git"
  bugs: "https://#{github}/issues"

  devDependencies:
    # deal with it
    'coffee-script': '1.6.x'
    # test runner / framework
    mocha: '1.8.x'
    # assertions helper
    chai: '1.4.x'

  scripts:
    # preinstall
    # postinstall
    # poststart
    prepublish: "make index.js"
    # pretest
    test: "make test"

  main: 'index'
  engines: { node: '*' }

console.log(JSON.stringify(info, null, 2))

