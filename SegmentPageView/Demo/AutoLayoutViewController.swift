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
        view.backgroundColor = UIColor.white
        
        let test1 = Test1ViewController(nibName: "Test1ViewController", bundle: Bundle.main)
        test1.title = "新闻娱乐"
        
        let test2 = Test2ViewController(nibName: "Test2ViewController", bundle: Bundle.main)
        test2.title = "消息中心"
        
        let test3 = Test3ViewController(nibName: "Test3ViewController", bundle: Bundle.main)
        test3.title = "新浪微博"
        
        //用AutoLayout的方式
        let segmentView = SegmentPageView(currentVc: self)
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentView)
        
        let hConstraintArray = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[segmentView]-0-|", options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: ["segmentView": segmentView])
        NSLayoutConstraint.activate(hConstraintArray)
        
        let vConstraintArray = NSLayoutConstraint.constraints(withVisualFormat: "V:|-64-[segmentView]-0-|", options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: ["segmentView": segmentView])
        NSLayoutConstraint.activate(vConstraintArray)
        
        segmentView.viewControllers = [test1, test2, test3]
    }
}
