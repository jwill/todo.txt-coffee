util = require "util"
require 'coffee-script'

{TodoList} = require('./TodoList')
a = new TodoList(["(A) stop", "@c @b blah"])

console.log a
console.log a.byContext('@b')
