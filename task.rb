require 'colorize'
class Task 
    attr_accessor :title, :description, :status, :id
    def to_s
        "Title: #{@title} \nDescription: #{@description} \nStatus: #{@status} \nID: #{@id}".colorize(:blue)
    end
    def update_task(id)   
        task = "ID: #{id}, Title: #{self.title}, Description: #{self.description}"
        File.open("./db/#{id}.txt", 'w') { |file| file.write(task) }
        puts "Task updated".colorize(:green)
    end
    def create_task
        id = list_tasks.length + 1
        task = "ID: #{id}, Title: #{self.title}, Description: #{self.description}, Status: #{self.status}"
        File.open("./db/#{id}.txt", 'w') { |file| file.write(task) }
        puts "Task created".colorize(:green)
    end
    def list_tasks
        files = Dir["./db/*"]
        if files.length > 0
            files
        else
            []
        end
    end
    def list 
        files = Dir["./db/*"]
        if files.length > 0
            files.each do |file|
                puts File.read(file).colorize(:blue)
            end
        else
            puts "No tasks found".colorize(:red)
        end
    end
    def delete_task(id)
        if File.exist?("./db/#{id}.txt")
            File.delete("./db/#{id}.txt")
            puts "Task deleted".colorize(:green)
        else
            puts "Invalid task id".colorize(:red)
        end
    end
    def get_task
        puts "Please enter task id"
        id = gets.chomp
        if File.exist?("./db/#{id}.txt")
            puts File.read("./db/#{id}.txt").colorize(:blue)
        else
            puts "Invalid task id".colorize(:red)
        end
    end
    def complete_task
        puts "Please enter task id"
        id = gets.chomp
        if File.exist?("./db/#{id}.txt")
            task = File.read("./db/#{id}.txt")
            task = task.split(', ')
            task[3] = "Status: completed"
            task = task.join(', ')
            File.open("./db/#{id}.txt", 'w') { |file| file.write(task) }
            puts "Task completed".colorize(:green)
        else
            puts "Invalid task id".colorize(:red)
        end
    end
end   