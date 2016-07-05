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
end