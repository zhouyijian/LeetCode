//
//  ViewController.swift
//  ONTest
//
//  Created by 周一见 on 2020/3/16.
//  Copyright © 2020 周一见. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1..<8 {
            let n: Int = Int(pow(10, Double(i)))
            let start: TimeInterval = Date.init().timeIntervalSince1970
            var sum: Int = 0
            for j in 0..<n {
                sum += j
            }
            let end: TimeInterval = Date.init().timeIntervalSince1970
            print("10^\(i): \(end - start)s")
        }
        
    }

    
    func binarySearch<T: Comparable>(arr: [T], target: T) -> Int? {
        //查找 l...r 前闭后闭区间的元素
        var l = 0
        var r = arr.count - 1
        var index: Int?
        while l <= r {
            let mid = l + (r - l) / 2
            if arr[mid] == target {
                index = mid
                break
            } else if arr[mid] < target {
                r = mid - 1
            } else {
                l = mid + 1
            }
        }
        return index
    }

}

