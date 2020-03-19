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
        var array = [0,1,1,2]
        print(removeDuplicates(&array))
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
}

