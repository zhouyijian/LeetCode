//
//  ViewController.swift
//  ListNode
//
//  Created by 周一见 on 2020/6/12.
//  Copyright © 2020 周一见. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var node = ListNode.init(1)
        let head = node
        for i in 1..<5 {
            let node2 = ListNode.init(1 + i)
            node.next = node2
            node = node2
        }
        
        let s = Solution()
        s.printList(head)
        let newhead = s.reverseList(head)
        s.printList(newhead)
        
    }


}

