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

  describe "#add" do
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
      @list = @prefix_tree.list
    end
    describe "if there is no provided prefix" do
      it "returns list of words with 5 or more then letters" do
        expect(@list.size).to eq(2)
      end
      it "should contain provided words exactly" do
        expect(@list).to include("table", "cardigan")
      end
      it "should not contain words with less then 5 letters" do
        expect(@list).to_not include("card")
      end
    end

  end

end