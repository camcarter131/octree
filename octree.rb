require_relative 'octree_node'

class Octree
    attr_reader :root
    # Tree is initialized with the root representing the cube of length 1 containing all n points
    def initialize
        @root = OctreeNode.new(0.0,1.0,0.0,1.0,0.0,1.0)
        # height of octree
        @height = 5
        build(@root)
    end

    # Creates octree with leaf nodes/buckets of desired size
    def build(node)
        if (node.x_end - node.x_start) <= 1.0/(2**(@height-1))
            return 
        else
            node.create_children
            node.children.each { |child| build(child) }
        end
    end

    # Puts points into buckets by populating data attribute of leaf nodes
    def add_point(point, node)
        if node.children.length == 0
            node.data << point
            return
        else
            node.children.each do |child|
                if child.contains_point?(point) 
                    add_point(point, child) 
                    break
                end
            end
        end
    end

    # Finds num closest points by going into bucket and doing a naive closest points on all points in bucket
    def closest_points(point, num, node)
        if node.contains_point?(point)
            if node.data.length > 0
                return node.data.sort_by { |data_point| data_point.distance_to(point: point) }.first(num)
            else
                node.children.each do |child|
                    if child.contains_point?(point) 
                        return closest_points(point, num, child)
                    end
                end
            end
        end
        return
    end
end





    