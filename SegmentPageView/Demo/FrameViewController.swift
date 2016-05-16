//
//  FrameViewController.swift
//  SegmentPageView
//
//  Created by jm on 16/5/16.
//  Copyright © 2016年 persist. All rights reserved.
//

import UIKit

class FrameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Frame"
        view.backgroundColor = UIColor.whiteColor()
        
        let test1 = Test1ViewController(nibName: "Test1ViewController", bundle: NSBundle.mainBundle())
        test1.title = "新闻娱乐"
        
        let test2 = Test2ViewController(nibName: "Test2ViewController", bundle: NSBundle.mainBundle())
        test2.title = "消息中心"
        
        let test3 = Test3ViewController(nibName: "Test3ViewController", bundle: NSBundle.mainBundle())
        test3.title = "新浪微博"
        
        //用frame的方式
        let segmentView = SegmentPageView(currentVc: self)
        segmentView.frame = CGRect(x: 0, y: 64, width: view.bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 64)
        view.addSubview(segmentView)
        segmentView.viewControllers = [test1, test2, test3]
    }
}
