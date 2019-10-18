require_relative "./tree.rb"
require_relative "./node.rb"

def select_best_active active
  active.min_by(&:distance_to_end)
end

def process node, current
  node.activate!
  node.prev = current
end

SEED = [
  [" "," ","*"," "," "," "].map.with_index { |v, c| Node.new(r: 0, c: c, v: v)},
  [" ","*","*"," ","*"," "].map.with_index { |v, c| Node.new(r: 1, c: c, v: v)},
  [" "," "," "," ","*"," "].map.with_index { |v, c| Node.new(r: 2, c: c, v: v)},
  [" "," ","*","*","*"," "].map.with_index { |v, c| Node.new(r: 3, c: c, v: v)},
  [" ","-","*"," "," "," "].map.with_index { |v, c| Node.new(r: 4, c: c, v: v)},
  [" "," ","*","B"," ","A"].map.with_index { |v, c| Node.new(r: 5, c: c, v: v)}
]

no_solution = false

tree = Tree.new(SEED)
puts "Processing maze:"
tree.print

# set distance should be in the node processing
start = tree.get_node_from_value "A"
finish = tree.get_node_from_value "B"

current = start
tree.set_distances_to_start current
tree.set_distances_to_end finish

current.activate!

loop do
  current.lock!
  tree.nearby(current).each {|node| process(node, current)}

  break if current === finish || no_solution
  no_solution = true if tree.active == []

  current = select_best_active(tree.active)
end

until current.prev.nil? || no_solution do
  current.v = "•" if current.v == " "
  current = current.prev
end

puts "Solution found:"
tree.print unless no_solution
puts "Hey, don't try to trick me. This maze has no solution!" if no_solution

puts "Processed nodes"
tree.print_processed
