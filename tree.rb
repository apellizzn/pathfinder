class Tree
  attr_accessor :data

  def initialize(data)
    self.data = data
  end

  def nearby(node)
    [
      get(node.r, node.c - 1),
      get(node.r, node.c + 1),
      get(node.r - 1, node.c),
      get(node.r - 1, node.c + 1),
      get(node.r - 1, node.c - 1),
      get(node.r + 1, node.c),
      get(node.r + 1, node.c + 1),
      get(node.r + 1, node.c - 1),
    ].compact.select(&:available?)
  end

  def get(r, c)
    out_of_range = r < 0 || r >= data.count || c < 0 || c >= data[0].count
    out_of_range ? nil : data[r][c]
  end

  def set(node)
    data[node.r][node.c] = node
  end

  def print
    data.each do |row|
      printable_row = row.map do |column|
        column.v
      end.join(" | ")
      puts "|" + printable_row + "|"
    end
    puts "\n"
  end
end
