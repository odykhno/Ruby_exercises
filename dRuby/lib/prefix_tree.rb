require './prefix_tree/prefix_tree_node'
require 'rubygems'
require 'zip'
require 'drb/drb'

URI="druby://localhost:5858"

class PrefixTree
  def initialize
    @root = PrefixTreeNode.new ""
    @list_of_words = []
  end

  attr_accessor :list_of_words

  def add key
    key_ar = key.split("")
    current_node = @root
    key_ar.each do |k|
      current_node.children[k] = PrefixTreeNode.new k if current_node.children[k].nil?
      current_node = current_node.children[k]
    end
    current_node.is_key = true
    current_node.let_count = key_ar.size
  end

  def include? key
    search_result = search_prefix key
    is_kye_absent = search_result[1]
    current_node = search_result[0]
    return false if is_kye_absent
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
    @list_of_words
  end

  def save_to_file filename
    list if @list_of_words.empty?
    File.open(filename +".txt", 'w'){ |file| file.write @list_of_words }
  end

  def load_from_file filename
    output = File.open(filename + ".txt", 'r'){ |file| file.read }
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
    File.delete(filename + ".txt")
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

  private
  def search_prefix prefix
    prefix_ar = prefix.split("")
    current_node = @root
    flag = false
    prefix_ar.each do |key|
      if current_node.children[key].nil?
        flag = true
        break
      else
        current_node = current_node.children[key]
      end
    end
    [current_node, flag]
  end

  def search current_node = @root, prefix = ""
    current_node.children.keys.each do |elem|
      if current_node.children[elem].is_key
        if current_node.children[elem].children.empty?
          final_word = prefix + current_node.children[elem].key
          @list_of_words.push(final_word) if current_node.children[elem].let_count >= 5
        else
          final_word = prefix + current_node.children[elem].key
          @list_of_words.push(final_word) if current_node.children[elem].let_count >= 5
          search current_node.children[elem], final_word
        end
      else
        final_word = prefix + current_node.children[elem].key
        search current_node.children[elem], final_word
      end
    end
  end
end

FRONT_OBJECT = PrefixTree.new
$SAFE = 1
DRb.start_service(URI, FRONT_OBJECT)
DRb.thread.join