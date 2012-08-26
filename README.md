## Installation

		npm install todotxt-coffee

## Loading Tasks 

		{TodoList} = require ('todotxt-coffee')

		# Instantiate list of Tasks
		tasks = new TodoList(["(A) stop +p +c", "@c @b blah +c"])

		# Load tasks from done file
		tasks = new TodoList("/Users/jwilliams/Dropbox/todo/done.txt")

## Querying Individual Tasks

		task.contexts() 	# => ['@context1', '@context2']	
		task.date()				# => 'YYYY-MM-DD'
		task.priority()		# => "(A)"
		task.projects()		# => ['+project', '+project2']
		task.properties() # => ['due:1234', 'note:345']
    task.raw()				# => "Full text of task"

## Querying Todo Lists
		
		tasks.byContext('@context')
		tasks.byPriority("A")
		tasks.byProject('+project')


