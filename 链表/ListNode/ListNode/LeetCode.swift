//
//  LeetCode.swift
//  ListNode
//
//  Created by 周一见 on 2020/6/12.
//  Copyright © 2020 周一见. All rights reserved.
//

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func printList(_ head: ListNode?) {
        var node = head
        while node != nil {
            print("\(node!.val) -> ")
            node = node?.next
        }
        print("nil")
    }
    
    
    //反转一个单链表。
    ///206. 反转链表
    func reverseList(_ head: ListNode?) -> ListNode? {
        var pre:ListNode? = nil
        var cur = head
        while cur != nil {
            let next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        return pre
    }
    
    ///203. 移除链表元素
    /*
     删除链表中等于给定值 val 的所有节点。
     */
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        let dumHead: ListNode? = ListNode.init(0)
        dumHead?.next = head
        var cur = dumHead
        while cur?.next != nil {
            if cur?.next!.val == val {
                cur?.next = cur?.next?.next
            } else {
                cur = cur?.next
            }
        }
        return dumHead?.next
    }
    
    ///24. 两两交换链表中的节点
    /*
     给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。

     你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。
     */
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let dumHead: ListNode? = ListNode(0)
        dumHead?.next = head
        var cur = dumHead
        while cur?.next != nil && cur?.next?.next != nil {
            let node1 = cur?.next
            let node2 = node1?.next
            let next = node2?.next
            
            node2?.next = node1
            node1?.next = next
            cur?.next = node2
            cur = node1
        }
        
        return dumHead?.next
        
    }
    
    ///237. 删除链表中的节点
    /*
     请编写一个函数，使其可以删除某个链表中给定的（非末尾）节点，你将只被给定要求被删除的节点。
     */
    func deleteNode(_ node: ListNode?) {
        if node != nil {
            node?.val = (node?.next?.val)!
            node?.next = node?.next?.next
        }
    }
    
    ///19. 删除链表的倒数第N个节点
    /*
     给定一个链表，删除链表的倒数第 n 个节点，并且返回链表的头结点。

     示例：

     给定一个链表: 1->2->3->4->5, 和 n = 2.

     当删除了倒数第二个节点后，链表变为 1->2->3->5.
     说明：

     给定的 n 保证是有效的。

     进阶：

     你能尝试使用一趟扫描实现吗？
     */    
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dumyHead = ListNode(0)
        dumyHead.next = head
        
        var p: ListNode? = dumyHead
        var q: ListNode? = dumyHead
        
        for _ in 0...n {
            q = q?.next
        }
        
        if q == nil {
            let newHead = head?.next
            head?.next = nil
            return newHead
        }
        
        while q != nil {
            p = p?.next
            q = q?.next
        }
        
        let delNode = p?.next
        p?.next = delNode?.next
        delNode?.next = nil
        
        return dumyHead.next
    }

}
