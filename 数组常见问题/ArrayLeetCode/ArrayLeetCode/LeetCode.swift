//
//  LeetCode.swift
//  ArrayLeetCode
//
//  Created by 周一见 on 2020/3/21.
//  Copyright © 2020 周一见. All rights reserved.
//

import Foundation
class LeetCode {
    ///215. 数组中的第K个最大元素
    //在未排序的数组中找到第 k 个最大的元素。请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        assert(!nums.isEmpty)
        var l = 0
        var r = nums.count - 1
        var nums2 = nums
        let index = partition(&nums2, &l, &r, k)
        return index
    }
    
    private func partition(_ nums: inout [Int], _ l: inout Int, _ r: inout Int, _ k: Int) -> Int {
        let p = partition(&nums, l, r)
        if (k - 1) == p {
            return nums[p]
        } else if (k - 1) < p {
            var r2 = p - 1
            return partition(&nums, &l, &r2, k)
        } else {
            var l2 = p + 1
            return partition(&nums, &l2, &r, k)
        }
    }
    
    private func partition(_ nums: inout [Int], _ l: Int, _ r: Int) -> Int {
        var j = l
        var i = l + 1
        //取nums[l] 为标定点
        //l+1...j < nums[l], j+1..<i >= nums[l]

        let rangeIndex = Int.random(in: l...r)
        nums.swapAt(l, rangeIndex)
        let now = nums[l]
        while i <= r {
            if nums[i] < now {
                i += 1
            } else {
                j += 1
                nums.swapAt(i, j)
                i += 1
            }
        }
        nums.swapAt(l, j)
        return j
    }
    
    ///167. 两数之和 II - 输入有序数组
    /*
     给定一个已按照升序排列 的有序数组，找到两个数使得它们相加之和等于目标数。

     函数应该返回这两个下标值 index1 和 index2，其中 index1 必须小于 index2。

     说明:

     返回的下标值（index1 和 index2）不是从零开始的。
     你可以假设每个输入只对应唯一的答案，而且你不可以重复使用相同的元素。
     */
    //思路一：从左往右用i遍历一遍数组，用二分查找法查找i右侧是否存在 target - numbers[i]
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var indexs: [Int] = []
        for i in 0..<numbers.count {
            if let index = erFenSearch(numbers, i, i + 1, r: numbers.count - 1, target) {
                indexs = [i + 1, index + 1]
            }
        }
        return indexs
    }
    
    private func erFenSearch(_ numbers: [Int], _ i: Int, _ l: Int, r: Int, _ target: Int) -> Int? {
        if l > r {
            return nil
        }
        let mid = l + (r - l) / 2
        let lookNum = target - numbers[i]
        if numbers[mid] == lookNum {
            return mid
        } else if numbers[mid] < lookNum {
            return erFenSearch(numbers, i, mid + 1, r: r, target)
        } else {
            return erFenSearch(numbers, i, l, r: mid - 1, target)
        }
    }
    
    //思路二：对撞指针，一个i指向最左，一个j指向最右。因为数组是有序的，如果现在二者之和小于 target，右移i，大于y左移j，直到等于返回对应ij。
    func twoSum2(_ numbers: [Int], _ target: Int) -> [Int] {
        var i = 0
        var j = numbers.count - 1
        while i < j {
            let sum = numbers[i] + numbers[j]
            if sum == target {
                return [i + 1, j + 1]
            } else if sum < target {
                i += 1
            } else {
                j -= 1
            }
        }
        return []
    }
    
    ///209. 长度最小的子数组
    //给定一个含有 n 个正整数的数组和一个正整数 s ，找出该数组中满足其和 ≥ s 的长度最小的连续子数组。如果不存在符合条件的连续子数组，返回 0。
    func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
        //取滑动窗口l...r，即找出最短的组合
        var l = 0
        var r = -1
        var sum = 0
        var res = nums.count + 1
        
        while l < nums.count {
            if r + 1 < nums.count && sum < s {
                r += 1
                sum += nums[r]
            } else {
                sum -= nums[l]
                l += 1
            }
            if sum >= s {
                res = min(res, r - l + 1)
            }
        }
        if res == nums.count + 1 {
            return 0
        } else {
            return res
        }
        
    }
    
    ///3. 无重复字符的最长子串
    /*
     给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。

     示例 1:

     输入: "abcabcbb"
     输出: 3
     解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
     */
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        var maxStr = String()
        var curStr = String()
        for c in s {
            while curStr.contains(c) {
                curStr.remove(at: curStr.startIndex)
            }
            curStr.append(c)
            if curStr.count > maxStr.count {
                maxStr = curStr
            }
        }
        return maxStr.count
    }
    
    
    /// 76. 最小覆盖子串
    //给你一个字符串 S、一个字符串 T，请在字符串 S 里面找出：包含 T 所有字母的最小子串。
    func minWindow(_ s: String, _ t: String) -> String {
        var tDic: [Character: Int] = [:]
        var minStr: Substring = ""
        for c in t {
            if tDic[c] != nil {
                tDic[c]! += 1
            } else {
                tDic[c] = 1
            }
        }
        var l = 0
        var r = -1
        var stDic: [Character: Int] = [:]
        for c in tDic.keys {
            stDic[c] = 0
        }
        var stCount = 0
        var minCount = s.count + 1
        while l < s.count {
            let rIndex = s.index(s.startIndex, offsetBy: r + 1)
            let lIndex = s.index(s.startIndex, offsetBy: l)
            if rIndex < s.endIndex && stCount < t.count {
                r += 1
                let rc = s[rIndex]
                if tDic.keys.contains(rc) {
                    stDic[rc]! += 1
                    if stDic[rc]! <= tDic[rc]! {
                        stCount += 1
                    }
                }
            } else {
                let lc = s[lIndex]
                if tDic.keys.contains(lc) {
                    stDic[lc]! -= 1
                    if stDic[lc]! < tDic[lc]! {
                        stCount -= 1
                    }
                }
                l += 1
            }
            if (stCount >= t.count) && (r - l + 1 < minCount) {
                let lIndex2 = s.index(s.startIndex, offsetBy: l)
                let rIndex2 = s.index(s.startIndex, offsetBy: r)
                if lIndex2 < s.endIndex {
                    let range = lIndex2...rIndex2
                    minStr = s[range]
                    minCount = r - l + 1
                }
            }
        }
        
        return String(minStr)
    }
}
