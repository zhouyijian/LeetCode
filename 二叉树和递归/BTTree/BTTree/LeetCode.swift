//
//  LeetCode.swift
//  BTTree
//
//  Created by 周一见 on 2020/6/15.
//  Copyright © 2020 周一见. All rights reserved.
//

import Foundation


public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class Solution {
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        } else {
            return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
        }
    }
    
    func minDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        } else {
            if root?.left != nil && root?.right != nil {
               return min(minDepth(root?.left), minDepth(root?.right)) + 1
            } else if root?.left == nil && root?.right == nil {
                return 1
            } else if root?.left == nil {
                return minDepth(root?.right) + 1
            } else {
                return minDepth(root?.left) + 1
            }
        }
    }
    
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        _ = invertTree(root?.left)
        _ = invertTree(root?.right)
        swap(&root!.left, &root!.right)
        return root
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return isSymmetric(root, root)
    }
    
    private func isSymmetric(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
        if left == nil && right == nil {
            return true
        } else if left == nil || right == nil {
            return false
        }
        return left!.val == right!.val && isSymmetric(left?.right, right?.left) && isSymmetric(left?.left, right?.right)
    }
    
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        guard let root2 = root else {
            return false
        }
        if root2.left == nil && root2.right == nil {
            return root2.val == sum
        }
        if hasPathSum(root2.left, sum - root2.val) {
            return true
        }
        if hasPathSum(root2.right, sum - root2.val) {
            return true
        }
        return false
    }
    
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        var res: [String] = []
        
        if root == nil {
            return []
        }
        if root?.left == nil && root?.right == nil {
            res.append("\(root!.val)")
        }
        
        let left = binaryTreePaths(root?.left)
        for i in left {
            res.append("\(root!.val)->\(i)")
        }
        let right = binaryTreePaths(root?.right)
        for i in right {
            res.append("\(root!.val)->\(i)")
        }
        
        return res
    }
    
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        if p!.val < root!.val && q!.val < root!.val {
            return lowestCommonAncestor(root?.left, p, q)
        } else if p!.val > root!.val && q!.val > root!.val {
            return lowestCommonAncestor(root?.right, p, q)
        } else {
            return root
        }
    }
    
    func lowestCommonAncestor2(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        if contains(root?.left, p) && contains(root?.left, q) {
            return lowestCommonAncestor2(root?.left, p, q)
        } else if contains(root?.right, p) && contains(root?.right, q) {
            return lowestCommonAncestor2(root?.right, p, q)
        } else {
            return root
        }
    }
    
    private func contains(_ root: TreeNode?,_ node: TreeNode?) -> Bool {
        if node == nil || root == nil {
            return false
        }
        if node!.val == root!.val {
            return true
        }
        return contains(root?.left, node) || contains(root?.right, node)
    }
}
