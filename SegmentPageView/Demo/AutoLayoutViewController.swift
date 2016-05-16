//
//  AutoLayoutViewController.swift
//  SegmentPageView
//
//  Created by jm on 16/5/16.
//  Copyright © 2016年 persist. All rights reserved.
//

import UIKit

class AutoLayoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "AutoLayout"
        view.backgroundColor = UIColor.whiteColor()
        
        let test1 = Test1ViewController(nibName: "Test1ViewController", bundle: NSBundle.mainBundle())
        test1.title = "新闻娱乐"
        
        let test2 = Test2ViewController(nibName: "Test2ViewController", bundle: NSBundle.mainBundle())
        test2.title = "消息中心"
        
        let test3 = Test3ViewController(nibName: "Test3ViewController", bundle: NSBundle.mainBundle())
        test3.title = "新浪微博"
        
        //用AutoLayout的方式
        let segmentView = SegmentPageView(currentVc: self)
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentView)
        
        let hConstraintArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[segmentView]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["segmentView": segmentView])
        NSLayoutConstraint.activateConstraints(hConstraintArray)
        
        let vConstraintArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[segmentView]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["segmentView": segmentView])
        NSLayoutConstraint.activateConstraints(vConstraintArray)
        
        segmentView.viewControllers = [test1, test2, test3]
    }
}
