require "spec_helper"

describe PrefixTreeNode do
  before :each do
    @prefix_tree_node = PrefixTreeNode.new "key"
  end
  describe "#new" do
    it "takes one parameter and returns a PrefixTreeNode object" do
      @prefix_tree_node.should be_an_instance_of PrefixTreeNode
    end
  end
  describe "#key" do
    it "returns the correct key" do
      @prefix_tree_node.key.should eql "key"
    end
  end
end