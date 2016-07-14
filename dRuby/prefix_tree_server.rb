require '../lib/prefix_tree'
require 'drb/drb'

URI="druby://localhost:5858"

FRONT_OBJECT = PrefixTree.new
DRb.start_service(URI, FRONT_OBJECT)
DRb.thread.join