class Node
  EMPTY = " "

  attr_accessor :r, :c, :v, :lock, :prev, :d
  attr_reader :d

  def initialize(opts)
    @r = opts[:r]
    @c = opts[:c]
    @d = opts[:d]
    @v = opts[:v]
    @prev = nil
  end

  def available?
    !lock && (v == EMPTY || v === "B")
  end
  def to_s
    "Node(#{r}, #{c}, #{v})"
  end
end
