class Node
  EMPTY = " "

  attr_accessor :r, :c, :v, :locked, :prev, :active, :distance_to_end, :distance_to_start

  def initialize(opts)
    @r = opts[:r]
    @c = opts[:c]
    @v = opts[:v]
    @prev = nil
    @active = false
    @distance_to_end = nil
    @distance_to_start = nil
  end

  def has_value? value
    v == value
  end

  def activate
    @active = true
  end

  def lock!
    raise "You cannot proccess an inactive node! :(" unless @active
    @active = false
    @locked = true
  end

  def set_distance_to_end r_end, c_end
    @distance_to_end = distance(r, c, r_end, c_end)
  end

  def set_distance_to_start r_start, c_start
    @distance_to_start = distance(r, c, r_start, c_start)
  end

  def available?
    !active && !locked && (v == EMPTY || v === "B")
  end

  def to_s
    "Node(#{r}, #{c}, #{v})"
  end

  private

  def distance r, c, r_node, c_node
    Math.sqrt((r - r_node).abs ** 2 + (c - c_node).abs ** 2 )
  end
end
