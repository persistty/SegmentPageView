//
//  ViewController.swift
//  SegmentPageView
//
//  Created by jm on 16/5/13.
//  Copyright © 2016年 persist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SegmentPageView"
        view.backgroundColor = UIColor.whiteColor()
        
        let test1 = Test1ViewController()
        test1.title = "新闻娱乐"
        
        let test2 = Test2ViewController()
        test2.title = "消息中心"
        
        let test3 = Test3ViewController()
        test3.title = "新浪微博"
        
        let segmentView = SegmentPageView(viewControllers: [test1, test2, test3], currentVc: self)
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentView)
        
        let hConstraintArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[segmentView]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["segmentView": segmentView])
        NSLayoutConstraint.activateConstraints(hConstraintArray)
        
        let vConstraintArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[segmentView]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["segmentView": segmentView])
        NSLayoutConstraint.activateConstraints(vConstraintArray)
        
        segmentView.selectedIndex = 0
    }
}

