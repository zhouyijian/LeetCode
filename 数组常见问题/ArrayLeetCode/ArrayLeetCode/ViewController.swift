//
//  ViewController.swift
//  ArrayLeetCode
//
//  Created by 周一见 on 2020/3/18.
//  Copyright © 2020 周一见. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let str = "a"
        let str2 = "a"
        let leetcode = LeetCode()
        print(leetcode.minWindow(str, str2))
    }

    ///283 移动零
    //给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
    func moveZeroes(_ nums: inout [Int]) {
        var i = 0
        var j = nums.count - 1
        
        while i < nums.count && nums[i] != 0 {
            i += 1
        }
        j = i + 1
        while j < nums.count {
            if nums[j] != 0 && i != j{
                nums.swapAt(i, j)
                i += 1
            }
            j += 1
        }
    }
    
    ///27 移除元素
    //给定一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var valNum = 0
        var i = 0
        var j = nums.count - 1
        while i <= j {
            if nums[j] == val {
                j -= 1
                valNum += 1
            } else {
                if nums[i] == val {
                    nums.swapAt(i, j)
                    j -= 1
                    valNum += 1
                }
                i += 1
            }
        }
        
        return nums.count - valNum
    }
    
    ///26删除排序数组中的重复项
    //给定一个排序数组，你需要在 原地 删除重复出现的元素，使得每个元素只出现一次，返回移除后数组的新长度。
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var i = 0
        var j = 1
        
        while j < nums.count {
            if nums[j] > nums[i] {
                nums[i + 1] = nums[j]
                i += 1
            }
            j += 1
        }
        if nums.isEmpty {
            return 0
        } else {
            return i + 1
        }
        
    }
    
    ///80删除排序数组中的重复项 II
    //给定一个排序数组，你需要在原地删除重复出现的元素，使得每个元素最多出现两次，返回移除后数组的新长度。
    func removeDuplicates2(_ nums: inout [Int]) -> Int {
        var index = 0
        if nums.count < 3 {
            return nums.count
        }
        var repeatNum = 1
        for i in 0..<nums.count {
            if repeatNum < 2 {
                if i > index {
                    if nums[i] == nums[index] {
                        repeatNum += 1
                    }
                    if index + 1 < nums.count {
                        nums[index + 1] = nums[i]
                        index += 1
                    }
                }
            } else {
                if nums[i] > nums[index] {
                    repeatNum = 1
                    if index + 1 < nums.count {
                        nums[index + 1] = nums[i]
                        index += 1
                    }
                } else {
                    repeatNum += 1
                }
            }
        }
        return index + 1
    }
    
    ///75 颜色分类
    //给定一个包含红色、白色和蓝色，一共 n 个元素的数组，原地对它们进行排序，使得相同颜色的元素相邻，并按照红色、白色、蓝色顺序排列。
    //此题中，我们使用整数 0、 1 和 2 分别表示红色、白色和蓝色
    //利用三路快排，扫描一遍数组即可完成排序
    func sortColors(_ nums: inout [Int]) {
        var zero = -1 // 0...zero 的元素全为0
        var two = nums.count //two ... nums.count 的元素全为2
        var i = 0 //zero+1...i-1 的元素全为1
        while i < two {
            if nums[i] == 2 {
                two -= 1
                nums.swapAt(i, two)
            } else if nums[i] == 0 {
                zero += 1
                nums.swapAt(zero, i)
                i += 1
            } else {
                assert(nums[i] == 1)
                i += 1
            }
        }
    }
    
    ///88. 合并两个有序数组
    //给你两个有序整数数组 nums1 和 nums2，请你将 nums2 合并到 nums1 中，使 num1 成为一个有序数组。
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        if n <= 0 {
            return
        }
        if m <= 0 {
            nums1 = nums2
            return
        }
        var i = m - 1
        var j = n - 1
        var k = m + n - 1
        while j >= 0 {
            if i < 0 || nums2[j] > nums1[i] {
                nums1[k] = nums2[j]
                j -= 1
                k -= 1
            } else {
                nums1[k] = nums1[i]
                i -= 1
                k -= 1
            }
        }
    }
    

}

