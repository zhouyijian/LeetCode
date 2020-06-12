//
//  LeetCode.swift
//  LeetCodeChart
//
//  Created by 周一见 on 2020/3/29.
//  Copyright © 2020 周一见. All rights reserved.
//

import Foundation
class LeetCode {
    ///1. 两数之和
    /*
     给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

     你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

     示例:

     给定 nums = [2, 7, 11, 15], target = 9

     因为 nums[0] + nums[1] = 2 + 7 = 9
     所以返回 [0, 1]
     */
    //第一个思路是把数组先排序，再运用双指针窗口，时间复杂度 O(NLogN)
    //第二个思路利用哈希字典随机访问下标的复杂度为O(1)，维护一个字典，key 为 nums 的元素，值为该元素下标
    //随后遍历该数组，查找当前元素在字典中是否有对应的 target - now，没有的话将当前元素加入字典，继续查看下一个元素
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dic = Dictionary<Int, Int>()
        for (index, num) in nums.enumerated() {
            let key = target - num
            if let index2 = dic[key] {
                return [index2, index]
            } else {
                dic[num] = index
            }
        }
        fatalError("No solution!")
    }
    
    ///15. 三数之和
    /*
     给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。

     注意：答案中不可以包含重复的三元组。
     示例：

     给定数组 nums = [-1, 0, 1, 2, -1, -4]，

     满足要求的三元组集合为：
     [
       [-1, 0, 1],
       [-1, -1, 2]
     ]
     */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 {
            return []
        }
        let sortNums = nums.sorted {$0 < $1}
        var i = 0
        var indexs: [[Int]] = []
        while sortNums[i] <= 0 && i < nums.count - 2 {
            if i > 0 && sortNums[i] == sortNums[i-1] {
                i += 1
                continue
            }
            var l = i + 1
            var r = nums.count - 1
            while l < r && l < nums.count && r > 0 {
                let a = sortNums[i]
                let b = sortNums[l]
                let c = sortNums[r]
                if a + b + c == 0 {
                    indexs.append([a, b, c])
                    while l + 1 < nums.count && b == sortNums[l + 1] {
                         l += 1
                     }
                     while r - 1 > 0 && c == sortNums[r - 1] {
                         r -= 1
                     }
                    l += 1
                    r -= 1
                } else if (b + c) > -a {
                    r -= 1
                } else {
                    l += 1
                }
            }
            
            i += 1
        }
        return indexs
    }
    
    ///454. 四数相加 II
    /*
    给定四个包含整数的数组列表 A , B , C , D ,计算有多少个元组 (i, j, k, l) ，使得 A[i] + B[j] + C[k] + D[l] = 0。

    为了使问题简单化，所有的 A, B, C, D 具有相同的长度 N，且 0 ≤ N ≤ 500 。所有整数的范围在 -228 到 228 - 1 之间，最终结果不会超过 231 - 1 。
 */
    func fourSumCount(_ A: [Int], _ B: [Int], _ C: [Int], _ D: [Int]) -> Int {
        var dic = Dictionary<Int, Int>.init()
        for c in C {
            for d in D {
                dic[c + d, default: 0] += 1
            }
        }
        
        var times = 0
        for a in A {
            for b in B {
                let cd = 0 - a - b
                if dic.keys.contains(cd) {
                    times += dic[cd]!
                }
            }
        }
        return times
    }
    
    ///49. 字母异位词分组
    /*
     给定一个字符串数组，将字母异位词组合在一起。字母异位词指字母相同，但排列不同的字符串。

     示例:

     输入: ["eat", "tea", "tan", "ate", "nat", "bat"]
     输出:
     [
       ["ate","eat","tea"],
       ["nat","tan"],
       ["bat"]
     ]
     */
    
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var dic: [String: [String]] = [:]
        let a: Character = "a"
        let aAS = a.asciiValue!
        for str in strs {
            var count: [UInt8] = Array<UInt8>.init(repeating: 0, count: 26)
            for c in str {
                let sub = Int(c.asciiValue! - aAS)
                count[sub] += 1
            }
            var subStr = ""
            for c in count {
                subStr += "\(c)"
            }
            if !dic.keys.contains(subStr) {
                dic[subStr] = [str]
            } else {
                dic[subStr]!.append(str)
            }
        }
        return Array(dic.values)
    }
    
    ///447. 回旋镖的数量
    /*

     给定平面上 n 对不同的点，“回旋镖” 是由点表示的元组 (i, j, k) ，其中 i 和 j 之间的距离和 i 和 k 之间的距离相等（需要考虑元组的顺序）。

     找到所有回旋镖的数量。你可以假设 n 最大为 500，所有点的坐标在闭区间 [-10000, 10000] 中。

     示例:

     输入:
     [[0,0],[1,0],[2,0]]

     输出:
     2

     解释:
     两个回旋镖为 [[1,0],[0,0],[2,0]] 和 [[1,0],[2,0],[0,0]]
     */
    
    func numberOfBoomerangs(_ points: [[Int]]) -> Int {
        var res = 0
        for (i, a) in points.enumerated() {
            var dic: [Int: Int] = [:]
            for (j, b) in points.enumerated() {
                if i != j {
                    let disNum = dis(a, b)
                    dic[disNum, default: 0] += 1
                }
            }
            for k in dic {
                res = res + k.value * (k.value - 1)
            }
        }
        return res
    }
    
    private func dis(_ a: [Int], _ b: [Int]) -> Int {
        return (a[0] - b[0]) * (a[0] - b[0]) + (a[1] - b[1]) * (a[1] - b[1])
    }
    
    
    ///219. 存在重复元素 II
    /*
     给定一个整数数组和一个整数 k，判断数组中是否存在两个不同的索引 i 和 j，使得 nums [i] = nums [j]，并且 i 和 j 的差的 绝对值 至多为 k。
     示例 1:

     输入: nums = [1,2,3,1], k = 3
     输出: true
     示例 2:

     输入: nums = [1,0,1,1], k = 1
     输出: true
     示例 3:

     输入: nums = [1,2,3,1,2,3], k = 2
     输出: false

     */
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        if k == 0 {
            return false
        }
        var set = Set<Int>()
        for (index, i) in nums.enumerated() {
            if set.contains(i) {
                return true
            } else {
                if set.count < k {
                    set.insert(i)
                } else {
                    set.remove(nums[index - k])
                    set.insert(i)
                }
            }
        }
        
        return false
    }
    
    ///220. 存在重复元素 III
    /*
     给定一个整数数组，判断数组中是否有两个不同的索引 i 和 j，使得 nums [i] 和 nums [j] 的差的绝对值最大为 t，并且 i 和 j 之间的差的绝对值最大为 ķ。

     示例 1:

     输入: nums = [1,2,3,1], k = 3, t = 0
     输出: true
     示例 2:

     输入: nums = [1,0,1,1], k = 1, t = 2
     输出: true
     示例 3:

     输入: nums = [1,5,9,1,5,9], k = 2, t = 3
     输出: false
     */
    
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        if k == 0 {
            return false
        }
        var set = Set<Int>()
        for (index, i) in nums.enumerated() {
            
            if set.contains(i) {
                return true
            } else {
                if set.count < k {
                    set.insert(i)
                } else {
                    set.remove(nums[index - k])
                    set.insert(i)
                }
            }
        }
        
        return false
    }
}
