//
//  ViewController.swift
//  LeetCodeChart
//
//  Created by 周一见 on 2020/3/26.
//  Copyright © 2020 周一见. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let leet = LeetCode()
        print(leet.threeSum([0,0,0,0]))
    } 

    
    ///242 有效的字母异位词
    //给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
    func isAnagram(_ s: String, _ t: String) -> Bool {
        var dic = Dictionary<Character, Int>.init()
        for c in s {
            if dic[c] == nil {
                dic[c] = 1
            } else {
                dic[c]! += 1
            }
        }
        var dic2 = Dictionary<Character, Int>.init()
        for c in t {
            if !dic.keys.contains(c) {
                return false
            }
            if dic2[c] == nil {
                dic2[c] = 1
            } else {
                dic2[c]! += 1
            }
            if dic2[c]! > dic[c]! {
                return false
            }
        }
        if dic != dic2 {
            return false
        }
        return true
    }

    ///202. 快乐数
    /*
     编写一个算法来判断一个数是不是“快乐数”。

     一个“快乐数”定义为：对于一个正整数，每一次将该数替换为它每个位置上的数字的平方和，然后重复这个过程直到这个数变为 1，也可能是无限循环但始终变不到 1。如果可以变为 1，那么这个数就是快乐数。
     */
    func isHappy(_ n: Int) -> Bool {
        var set = Set<Int>()
        var n2 = n
        return isHappy2(&n2, &set)
    }
    
    private func isHappy2(_ n: inout Int, _ set: inout Set<Int>) -> Bool {
        if n == 1 {
            return true
        }
        if set.contains(n) {
            return false
        }
        set.insert(n)
        var atr = Array<Int>()
        
        while n > 0 {
            atr.append(n % 10)
            n /= 10
        }
        var sum = 0
        for i in atr {
            sum = sum + i * i
        }
        n = sum
        return isHappy2(&n, &set)
    }
    
    ///290. 单词规律
    /*
     给定一种规律 pattern 和一个字符串 str ，判断 str 是否遵循相同的规律。

     这里的 遵循 指完全匹配，例如， pattern 里的每个字母和字符串 str 中的每个非空单词之间存在着双向连接的对应规律。

     示例1:

     输入: pattern = "abba", str = "dog cat cat dog"
     输出: true
     */
    func wordPattern(_ pattern: String, _ str: String) -> Bool {
        let strAry = str.split(separator: " ")
        if strAry.count != pattern.count {
            return false
        }
        var dic: [Character: Substring] = [:]
        var dic2: [Substring: Character] = [:]
        for (index, c) in pattern.enumerated() {
            let subStr = strAry[index]
            if dic[c] == nil {
                dic[c] = subStr
            }
            if dic2[subStr] == nil {
                dic2[subStr] = c
            }
            if dic[c]! != subStr || dic2[subStr]! != c {
                return false
            }
        }
        return true
    }
    
    ///205. 同构字符串
    /*
     给定两个字符串 s 和 t，判断它们是否是同构的。

     如果 s 中的字符可以被替换得到 t ，那么这两个字符串是同构的。

     所有出现的字符都必须用另一个字符替换，同时保留字符的顺序。两个字符不能映射到同一个字符上，但字符可以映射自己本身。

     示例 1:

     输入: s = "egg", t = "add"
     输出: true
     示例 2:

     输入: s = "foo", t = "bar"
     输出: false
     */
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            return false
        }
        var tAry: [Character] = []
        for c in t {
            tAry.append(c)
        }
        var dic: [Character: Character] = [:]
        var dic2: [Character: Character] = [:]
        for (index, c) in s.enumerated() {
            let subStr = tAry[index]
            if dic[c] == nil {
                dic[c] = subStr
            }
            if dic2[subStr] == nil {
                dic2[subStr] = c
            }
            if dic[c]! != subStr || dic2[subStr]! != c {
                return false
            }
        }
        return true
    }
    
    ///451. 根据字符出现频率排序
    /*

     给定一个字符串，请将字符串里的字符按照出现的频率降序排列。

     示例 1:

     输入:
     "tree"

     输出:
     "eert"

     解释:
     'e'出现两次，'r'和't'都只出现一次。
     因此'e'必须出现在'r'和't'之前。此外，"eetr"也是一个有效的答案。
     示例 2:

     输入:
     "cccaaa"

     输出:
     "cccaaa"

     解释:
     'c'和'a'都出现三次。此外，"aaaccc"也是有效的答案。
     注意"cacaca"是不正确的，因为相同的字母必须放在一起。
     */
    
    func frequencySort(_ s: String) -> String {
        var dic: [Character: Int] = [:]
        for c in s {
            if dic[c] == nil {
                dic[c] = 1
            } else {
                dic[c]! += 1
            }
        }
        var keys = Array(dic.keys)
        keys.sort { (c0, c1) -> Bool in
            dic[c0]! > dic[c1]!
        }
        var str = ""
        for c in keys {
            let count = dic[c]!
            for _ in 0..<count {
                str.append(c)
            }
        }
        return str
        
    }
}

