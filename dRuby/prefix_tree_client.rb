require 'drb/drb'

SERVER_URI="druby://localhost:5858"
DRb.start_service

prefix_tree = DRbObject.new_with_uri(SERVER_URI)
puts "There is Prefix Tree"
puts "You may use several commands to work with it. Please, type"
puts "add - to add new word in the tree"
puts "include - to check is the tree already has specific word or not"
puts "list - to see words in the tree"
puts "save - to save the tree in the file"
puts "load - to load the tree from the file"
puts "save_zip - to save the tree in the zip-file"
puts "load_zip - to load the tree from the zip-file"
command = gets.chomp
case command
  when "add"
    puts "please, type the word which you want to add"
    word = gets.chomp
    prefix_tree.add word
    puts "word #{word} is added in the tree"
  when "include"
    puts "please, type the word whose presence in the tree you want to check"
    word = gets.chomp
    if prefix_tree.include? word
      puts "word #{word} is present in the tree"
    else
      puts "word #{word} is absent in the tree"
    end
  when "list"
    puts "please, type the prefix if you want to search words started with specific prefix or press enter if you don't"
    prefix = gets.chomp
    if prefix
      puts prefix_tree.list prefix
    else
      puts prefix_tree.list
    end
  when "save"
    puts "please, enter the name of file"
    filename = gets.chomp
    prefix_tree.save_to_file filename
    puts "file #{filename}.txt is successfully saved"
  when "load"
    puts "please, enter the name of file"
    filename = gets.chomp
    puts prefix_tree.load_from_file filename
  when "save_zip"
    puts "please, enter the name of file"
    filename = gets.chomp
    prefix_tree.save_to_zip_file filename
    puts "file #{filename}.zip is successfully saved"
  when "load_zip"
    puts "please, enter the name of file"
    filename = gets.chomp
    puts prefix_tree.load_from_zip_file filename
  else
    puts "there is unknown command, please, try again"
end