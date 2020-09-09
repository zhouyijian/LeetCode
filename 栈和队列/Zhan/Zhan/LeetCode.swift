//
//  LeetCode.swift
//  Zhan
//
//  Created by 周一见 on 2020/6/14.
//  Copyright © 2020 周一见. All rights reserved.
//

import Foundation

class Solution {
    func numSquares(_ n: Int) -> Int {
        var queue: [[Int]] = []
        queue.append([n, 0])
        
        var visited = Array<Bool>.init(repeating: false, count: n + 1)
        visited[n] = true
        
        while !queue.isEmpty {
            let ns = queue.removeFirst()
            let num = ns[0]
            let stp = ns[1]
            
            var i = 1
            var sq = num - i * i
            while true {
                if sq < 0 {
                    break
                } else if sq == 0 {
                    return stp + 1
                }
                if !visited[sq] {
                    queue.append([sq, stp + 1])
                    visited[sq] = true
                }
                
                i += 1
                sq = num - i * i
            }
        }
        fatalError("some rong")
    }
}
