class OctreeNode
    attr_accessor :children, :x_start, :x_end, :y_start, :y_end, :z_start, :z_end, :data
    # Construct node with x, y, and z ranges to represent a cube in 3-space
    def initialize(x_start, x_end, y_start, y_end, z_start, z_end)
        @x_start = x_start
        @x_end = x_end
        @y_start = y_start
        @y_end = y_end 
        @z_start = z_start
        @z_end = z_end
        @children = []
        @data = []
    end

    # Create 8 children nodes for node by dividing into 8 sub cubes
    def create_children
        x_mid = (@x_start+@x_end)/2.0
        y_mid = (@y_start+@y_end)/2.0
        z_mid = (@z_start+@z_end)/2.0
        @children << OctreeNode.new(@x_start, x_mid, @y_start, y_mid, @z_start, z_mid)
        @children << OctreeNode.new(@x_start, x_mid, @y_start, y_mid, z_mid, @z_end)
        @children << OctreeNode.new(@x_start, x_mid, y_mid, @y_end, @z_start, z_mid)
        @children << OctreeNode.new(@x_start, x_mid, y_mid, @y_end, z_mid, @z_end)
        @children << OctreeNode.new(x_mid, @x_end, @y_start, y_mid, @z_start, z_mid)
        @children << OctreeNode.new(x_mid, @x_end, @y_start, y_mid, z_mid, @z_end)
        @children << OctreeNode.new(x_mid, @x_end, y_mid, @y_end, @z_start, z_mid)
        @children << OctreeNode.new(x_mid, @x_end, y_mid, @y_end, z_mid, @z_end)
    end

    # Check if a point is in the section of 3-d space represented by the node
    def contains_point?(point)
        @x_start <= point.x && point.x <= @x_end && 
        @y_start <= point.y && point.y <= @y_end && 
        @z_start <= point.z && point.z <= @z_end 
    end

end