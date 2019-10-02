require_relative "./tree.rb"
require_relative "./node.rb"

SEED = [
  [" "," "," "," "," "," "].map.with_index { |v, c| Node.new(r: 0, c: c, d: nil, v: v)},
  [" "," ","|"," ","B"," "].map.with_index { |v, c| Node.new(r: 1, c: c, d: nil, v: v)},
  [" "," ","-","-","-","-"].map.with_index { |v, c| Node.new(r: 2, c: c, d: nil, v: v)},
  [" "," "," "," "," "," "].map.with_index { |v, c| Node.new(r: 3, c: c, d: nil, v: v)},
  [" ","A"," "," "," "," "].map.with_index { |v, c| Node.new(r: 4, c: c, d: nil, v: v)},
  [" "," "," "," "," "," "].map.with_index { |v, c| Node.new(r: 5, c: c, d: nil, v: v)}
]

tree = Tree.new(SEED)

start = tree.get(4, 1)
start.d = 0
start.lock = true
tree.set(start)
current = start

processed = [start]

loop do
  current = processed.shift
  found = current.v === "B"
  break if found
  processed = processed + tree.nearby(current).map do |node|
    node.d = current.d + 1
    node.prev = current
    node.lock = true
    tree.set(node)
  end
end

until current.prev.nil? do
  current.v = "•" if current.v == " "
  tree.set(current)
  current = current.prev
end
tree.print
