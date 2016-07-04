require 'rubygems'
require 'zip'

class PrefixTreeNode
  def initialize key, is_key = false
    @key = key
    @children = {}
    @let_count
  end

  attr_reader :key
  attr_accessor :children, :is_key, :let_count

end

class PrefixTree
  def initialize
    @root = PrefixTreeNode.new ""
    @list_of_words = []
  end

  attr_accessor :list_of_words

  def add key
    key_ar = key.split("")
    current_node = @root
    for i in 0...key_ar.size
      if current_node.children[key_ar[i]].nil?
        current_node.children[key_ar[i]] = PrefixTreeNode.new key_ar[i]
      end
      if i == key_ar.size-1
        current_node.children[key_ar[i]].is_key = true
        current_node.children[key_ar[i]].let_count = key_ar.size
      end
      current_node = current_node.children[key_ar[i]]
    end
  end

  private
  def search_prefix prefix
    prefix_ar = prefix.split("")
    current_node = @root
    for i in 0...prefix_ar.size
      if current_node.children[prefix_ar[i]].nil?
        flag = true
        break
      else
        current_node = current_node.children[prefix_ar[i]]
      end
    end
    [current_node, flag]
  end

  def search current_node = @root, prefix = ""
    current_node.children.keys.each do |elem|
      if current_node.children[elem].is_key
        if current_node.children[elem].children.empty?
          final_word = prefix + current_node.children[elem].key
          if current_node.children[elem].let_count >= 5 then @list_of_words.push(final_word); end
        else
          final_word = prefix + current_node.children[elem].key
          if current_node.children[elem].let_count >= 5 then @list_of_words.push(final_word); end
          search current_node.children[elem], final_word
        end
      else
        final_word = prefix + current_node.children[elem].key
        search current_node.children[elem], final_word
      end
    end
  end

  public
  def include? key
    search_result = search_prefix key
    is_kye_absent = search_result[1]
    current_node = search_result[0]
    if is_kye_absent then return false; end
    current_node.is_key ? true : false
  end

  def list prefix = ""
    search_result = search_prefix prefix
    is_kye_absent = search_result[1]
    current_node = search_result[0]
    @list_of_words = []
    if prefix == ""
      search
    elsif !is_kye_absent
      search current_node, prefix
    else
      @list_of_words.push("Prefix #{prefix} is absent in Prefix Tree")
    end
    puts @list_of_words
  end

  def save_to_file filename
    if @list_of_words.empty? then list; end
    File.open(filename +".txt", 'w'){ |file| file.write @list_of_words }
  end

  def load_from_file filename
    output = File.open(filename + ".txt", 'r'){ |file| file.read }
    puts output
  end

  def save_to_zip_file filename
    if File.file?(filename + ".txt")
      puts "Zip file with name #{filename}.zip is already exists"
    else
      save_to_file filename
      Zip::File.open(filename + ".zip", Zip::File::CREATE) do |zipfile|
        zipfile.add(filename + ".txt", filename + ".txt")
      end
    end
  end

  def load_from_zip_file filename
    if File.file?(filename + "_unpacked.txt")
      puts "Zip file with name #{filename}.zip is already unpacked"
    else
      Zip::File.open(filename + ".zip") do |zip_file|
      zip_file.each do |entry|
        entry.extract(filename + "_unpacked.txt")
      end
    end
    load_from_file filename + "_unpacked"
    end
  end
end

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
pr_tr.list
pr_tr.list "jam"
pr_tr.list "tab"
pr_tr.list "ain"
pr_tr.save_to_file "prefix_tree_1"
puts "from file"
pr_tr.load_from_file "prefix_tree_1"
pr_tr.save_to_zip_file "prefix_tree_7"
puts "from zip"
pr_tr.load_from_zip_file "prefix_tree_7"