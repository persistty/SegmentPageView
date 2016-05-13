//
//  SegmentPageView.swift
//  SegmentPageView
//
//  Created by jm on 16/5/11.
//  Copyright © 2016年 persist. All rights reserved.
//

import UIKit

class SegmentPageView: UIView {
    private var viewControllers: [UIViewController]!
    private var segmentBar: SegmentBar!
    
    ///选择的tag的index
    var selectedIndex: NSInteger = 0 {
        didSet {
            choiseView(selectedIndex)
        }
    }
    private(set) var scrollView: UIScrollView = UIScrollView()
    
    init(viewControllers: [UIViewController], currentVc: UIViewController) {
        self.viewControllers = viewControllers
        super.init(frame: CGRectZero)
        makeUI(currentVc)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 布局界面
    private func makeUI(currentVc: UIViewController) {
        var titles: [String] = [String]()
        for vc in viewControllers {
            titles.append(vc.title!)
            currentVc.addChildViewController(vc)
        }
        
        segmentBar = SegmentBar(titles: titles)
        segmentBar.translatesAutoresizingMaskIntoConstraints = false
        segmentBar.selectTagCallBack = { [weak self] index in
            self?.selectedIndex = index
            self?.choiseTag(index)
        }
        addSubview(segmentBar)
        let topConstraint = NSLayoutConstraint(item: segmentBar, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0)
        topConstraint.active = true
        
        let leftConstrain = NSLayoutConstraint(item: segmentBar, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0)
        leftConstrain.active = true
        
        let rightConstrain = NSLayoutConstraint(item: segmentBar, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0)
        rightConstrain.active = true
        
        let heightConstrain = NSLayoutConstraint(item: segmentBar, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 40)
        heightConstrain.active = true
        
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        let topConstraint2 = NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: segmentBar, attribute: .Bottom, multiplier: 1, constant: 0)
        topConstraint2.active = true
        
        let leftConstrain2 = NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0)
        leftConstrain2.active = true
        
        let rightConstrain2 = NSLayoutConstraint(item: scrollView, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0)
        rightConstrain2.active = true
        
        let buttomConstraint = NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        buttomConstraint.active = true
    }
    
    private func choiseView(index: NSInteger) {
        let vc = viewControllers[index]
        let vcView = vc.view
        
        if scrollView.viewWithTag(6500 + index) != nil {
            return
        }
        vcView.tag = 6500 + index
        vcView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(vcView)
        
        let topConstraint = NSLayoutConstraint(item: vcView, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1, constant: 0)
        topConstraint.active = true
        
        let leftConstrain = NSLayoutConstraint(item: vcView, attribute: .Left, relatedBy: .Equal, toItem: scrollView, attribute: .Left, multiplier: 1, constant: scrollView.bounds.size.width * CGFloat(index))
        leftConstrain.active = true
        
        let widthConstrain = NSLayoutConstraint(item: vcView, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1, constant: 0)
        widthConstrain.active = true
        
        let heightConstrain = NSLayoutConstraint(item: vcView, attribute: .Height, relatedBy: .Equal, toItem: scrollView, attribute: .Height, multiplier: 1, constant: 0)
        heightConstrain.active = true
    }
    
    ///切换tag
    private func choiseTag(index: NSInteger) {
        scrollView.setContentOffset(CGPointMake(scrollView.bounds.size.width * CGFloat(index), 0), animated: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width * CGFloat(viewControllers.count), scrollView.bounds.size.height)
    }
}

extension SegmentPageView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        segmentBar.selectedIndex = index
        selectedIndex = index
    }
}