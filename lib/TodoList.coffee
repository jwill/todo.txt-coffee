fs = require 'fs'
path = require 'path'

class TodoList
  constructor: (args) ->
    @list = []
    if args instanceof Array
      @path = null
      
      for item in args
        if (item.constructor.name is 'String')
          @list.push(new Task(item))
        else if (item instanceof Task)
          @list.push(item)
    else if args.constructor.name is 'String'
      @path = args
      # If path doesn't end in .txt, default to todo.txt
      @path=path.join(@path,'todo.txt') if @path.substr(-4) isnt '.txt'

      # Read list of files, create todos from them
      lines = fs.readFileSync(@path).toString().split '\n'
      for line in lines
        if (line isnt '')
          @list.push(new Task(line)) 


  path: () -> 
    @path

  byPriority: (priority) ->
    task for task in @list when task.priority() == "("+priority+")"

  byContext: (context) ->
    l = []
    for task in @list
      ctx = task.contexts()
      if (ctx and context in ctx)
        l.push task
    l 

  byProject: (project) ->
    l = []
    for task in @list
      proj = task.projects()
      if (proj and project in proj)
        l.push task
    l 


root = exports ? this
root.TodoList = TodoList
