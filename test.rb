require './lib/prefix_tree'

pr_tr = PrefixTree.new
pr_tr.add "hello"
pr_tr.add "aim"
pr_tr.add "help"
pr_tr.add "air"
pr_tr.add "table"
pr_tr.add "hell"
puts pr_tr.include? "air"
puts pr_tr.include? "taxi"
puts pr_tr.include? "hell"
puts pr_tr.include? "word"
puts pr_tr.include? "help"
puts pr_tr.include? "tab"
puts pr_tr.list
puts pr_tr.list "jam"
puts pr_tr.list "tab"
puts pr_tr.list "ain"
pr_tr.add "flower"
puts pr_tr.list
puts pr_tr.list
pr_tr.save_to_file "prefix_tree_1"
puts "from file"
puts pr_tr.load_from_file "prefix_tree_1"
pr_tr.save_to_zip_file "prefix_tree_7"
puts "from zip"
puts pr_tr.load_from_zip_file "prefix_tree_7"
puts pr_tr.load_from_zip_file "prefix_tree_2"