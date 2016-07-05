require "spec_helper"

describe PrefixTree do
  before :each do
    @prefix_tree = PrefixTree.new
  end

  describe "#new" do
    it "takes no parameters and returns a PrefixTree object" do
      @prefix_tree.should be_an_instance_of PrefixTree
    end
  end

  describe "#add" do
    before do
      @prefix_tree.add "card"
    end
    describe "add provided string in the tree" do
      it "provided string is present in the tree" do
        @prefix_tree.include?("card").should be true
      end
      it "not provided string is not present in the tree" do
        @prefix_tree.include?("car").should be false
      end
      it "not provided string is not present in the tree" do
        @prefix_tree.include?("cardy").should be false
      end
    end
  end

end