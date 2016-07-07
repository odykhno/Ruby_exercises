require "spec_helper"

describe PrefixTree do
  before :each do
    @prefix_tree = PrefixTree.new
  end

  describe "#new" do
    it "takes no parameters and returns a PrefixTree object" do
      expect(@prefix_tree).to be_an_instance_of PrefixTree
    end
  end

  describe "#add and #include?" do
    before do
      @prefix_tree.add "card"
    end
    describe "add provided string in the tree" do
      it "provided string is present in the tree" do
        expect(@prefix_tree.include?("card")).to be true
      end
      it "not provided string is not present in the tree" do
        expect(@prefix_tree.include?("car")).to be false
      end
      it "not provided string is not present in the tree" do
        expect(@prefix_tree.include?("cardy")).to be false
      end
    end
  end

  describe "#list" do
    before do
      @prefix_tree.add "card"
      @prefix_tree.add "table"
      @prefix_tree.add "cardigan"
      @prefix_tree.add "tabl"
      @prefix_tree.add "tabloid"
      @list = @prefix_tree.list
      @list_pref = @prefix_tree. list "tabl"
    end
    describe "if there is no provided prefix" do
      it "returns list of words with 5 or more then letters" do
        expect(@list.size).to eq(3)
      end
      it "should contain words with 5 or more then letters" do
        expect(@list).to include("table", "cardigan", "tabloid")
      end
      it "should not contain words with less then 5 letters" do
        expect(@list).to_not include("card")
      end
    end
    describe "if there is provided prefix" do
      it "returns list of words with 5 or more then letters started with provided prefix" do
        expect(@list_pref.size).to eq(2)
      end
      it "should contain words with 5 or more then letters started with provided prefix" do
        expect(@list_pref).to include("table", "tabloid")
      end
      it "should not contain words with less then 5 letters" do
        expect(@list).to_not include("tabl")
      end
    end
  end

  describe "#save_to_file" do
    before do
      @prefix_tree.save_to_file "test"
    end
    it "create only one file with provided name" do
      expect(Dir.glob(File.join(File.expand_path(""), "test.txt")).length).to eq(1)
    end
    after do
      File.delete("test.txt")
    end
  end

  describe "#load_from_file" do
    before do
      @prefix_tree.add "table"
      @prefix_tree.save_to_file "test"
    end
    it "saved file contains only provided words" do
      @from_file = @prefix_tree.load_from_file "test"
      expect(@from_file).to include("table")
      expect(@from_file.split(",").size).to eq(1)
    end
    after do
      File.delete("test.txt")
    end
  end

  describe "#save_to_zip_file" do
    before do
      @prefix_tree.save_to_zip_file "test"
    end
    it "create only one file with provided name" do
      expect(Dir.glob(File.join(File.expand_path(""), "test.zip")).length).to eq(1)
    end
    after do
      File.delete("test.zip")
    end
  end

  describe "#load_from_zip_file" do
    before do
      @prefix_tree.add "table"
      @prefix_tree.save_to_zip_file "test"
    end
    it "saved file contains only provided words" do
      @from_file = @prefix_tree.load_from_zip_file "test"
      expect(@from_file).to include("table")
      expect(@from_file.split(",").size).to eq(1)
    end
    after do
      File.delete("test.zip")
      File.delete("test_unpacked.txt")
    end
  end

end