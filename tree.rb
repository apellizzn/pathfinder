class Tree
  attr_accessor :data, :start, :finish

  COORD = [[0,-1],[0,1],[1,-1],[1,0],[1,1],[-1,-1],[-1,0],[-1,1]]

  def initialize(data)
    self.data = data
  end

  def active
    data.flatten.select(&:active)
  end

  def nearby(node)
    COORD.map {|coord| get(node.r + coord[0], node.c + coord[1]) }.compact.select(&:available?)
  end

  def get_node_from_value value
    data.flatten.select{|n| n.has_value? value}.first
  end

  def get(r, c)
    out_of_range = r < 0 || r >= data.count || c < 0 || c >= data[0].count
    out_of_range ? nil : data[r][c]
  end

  def print
    data.each do |row|
      printable_row = row.map do |column|
        column.v
      end.join(" | ")
      puts "| " + printable_row + " |"
    end
    puts "\n"
  end

  def print_processed
    data.each do |row|
      printable_row = row.map do |column|
        column.locked || column.active ? "P" : " "
      end.join(" | ")
      puts "|" + printable_row + "|"
    end
    puts "\n"
  end
end
