fs = require 'fs'
path = require 'path'

class Task
    constructor: (@task) ->

    # Returns the priority, if any.
    priority: () ->
      @task.match(Task.priority_regex)?.toString()?.trim()

    # Retrieves an array of all the @context annotations.
    contexts: () ->
      ctx = @task.match(Task.contexts_regex)
      if ctx
        c.trim() for c in ctx

    # Retrieves an array of all the +project annotations.
    projects: () ->
      proj = @task.match(Task.projects_regex)
      if proj
        p.trim() for p in proj

    # Retrieves the date.
    date: () ->
      try 
        @task.match(Task.date_regex)[1]
      catch err
        return

    #
    overdue: () ->
      if @date is undefined
        return
      else if @date < new Date()
        true
      else false

    # Gets text of todo without priorities, contexts, projects, or dates
    text: () ->
      @task.replace(Task.priority_regex, "").
        replace(Task.contexts_regex, "").
        replace(Task.date_regex, "").
        replace(Task.projects_regex, "")

    # TODO Compare to other task priority

    # The regular expression used to match contexts.
    @contexts_regex = /(?:\s+|^)@\w+/g

    # The regex used to match projects.
    @projects_regex = /(?:\s+|^)\+\w+/g

    # The regex used to match priorities.
    @priority_regex = /^\([A-Za-z]\)\s+/

    # The regex used to match dates.
    @date_regex = /([0-9]{4}-[0-9]{2}-[0-9]{2})/

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
      console.log @path
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
root.Task = Task
root.TodoList = TodoList
