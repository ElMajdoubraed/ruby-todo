require "./task.rb"
puts "Program started"
puts "Please enter your operation name"

def run_program
    puts "\n"
    commands = <<~List 
        ------------------------------------------
        | enter 'list' to list all tasks         |
        | enter 'create' to create a new task    |
        | enter 'delete' to delete a task        |
        | enter 'get' to get a task              |
        | enter 'update' to update a task        |
        | enter 'complete' to complete a task    |
        | enter 'exit' to exit the program       |
        ------------------------------------------
        List
    puts commands.colorize(:yellow)

    command = gets.chomp
    puts "\n"
    case command
    when 'list'
        Task.new.list
        run_program
    when 'create'
        task = Task.new
        puts "Please enter task title"
        task.title = gets.chomp
        puts "Please enter task description"
        task.description = gets.chomp
        task.status = "incomplete"
        task.create_task
        run_program
    when 'delete'
        puts "Please enter task id"
        id = gets.chomp
        task = Task.new
        task.delete_task(id)
        run_program
    when 'get'
        task = Task.new
        task.get_task
        run_program
    when 'update'
        puts "Please enter task id"
        id = gets.chomp
        if File.exist?("./db/#{id}.txt")
            task = Task.new
            puts "Please enter task title"
            task.title = gets.chomp
            puts "Please enter task description"
            task.description = gets.chomp
            task.update_task(id)
        else
            puts "Invalid task id".colorize(:red)
        end
        run_program
    when 'complete'
        task = Task.new
        task.complete_task
        run_program
    when 'exit'
        puts "Program exited".colorize(:green)
    else
        puts "Invalid command please try with valid command".colorize(:red)
        run_program
    end
    
end

run_program