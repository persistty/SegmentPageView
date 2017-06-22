//
//  SegmentPageView.swift
//  SegmentPageView
//
//  Created by jm on 16/5/11.
//  Copyright © 2016年 persist. All rights reserved.
//

import UIKit

class SegmentPageView: UIView {
    private weak var currentVc: UIViewController!
    
    ///分段导航条
    private(set) var segmentBar: SegmentBar = {
        let segmentBar = SegmentBar()
        segmentBar.backgroundColor = UIColor.white
        segmentBar.translatesAutoresizingMaskIntoConstraints = false
        return segmentBar
    }()
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    ///显示控制器的数组
    var viewControllers = [UIViewController]() {
        didSet {
            makeUI(currentVc)
        }
    }
    ///选择的tag的index
    fileprivate var selectedIndex: NSInteger = 0 {
        didSet {
            choiseView(index: selectedIndex)
            choiseTag(index: selectedIndex)
        }
    }
    
    init(currentVc: UIViewController) {
        super.init(frame: CGRect.zero)
        self.currentVc = currentVc
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 布局界面
    private func makeUI(_ currentVc: UIViewController) {
        var titles: [String] = [String]()
        for vc in viewControllers {
            titles.append(vc.title!)
            currentVc.addChildViewController(vc)
        }
        
        segmentBar.titles = titles
        segmentBar.selectTagCallBack = { [weak self] index in
            self?.selectedIndex = index
        }
        addSubview(segmentBar)
        let topConstraint = NSLayoutConstraint(item: segmentBar, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let leftConstrain = NSLayoutConstraint(item: segmentBar, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        leftConstrain.isActive = true
        
        let rightConstrain = NSLayoutConstraint(item: segmentBar, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        rightConstrain.isActive = true
        
        let heightConstrain = NSLayoutConstraint(item: segmentBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        heightConstrain.isActive = true
        
        scrollView.delegate = self
        addSubview(scrollView)
        
        let topConstraint2 = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: segmentBar, attribute: .bottom, multiplier: 1, constant: 0)
        topConstraint2.isActive = true
        
        let leftConstrain2 = NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        leftConstrain2.isActive = true
        
        let rightConstrain2 = NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        rightConstrain2.isActive = true
        
        let buttomConstraint = NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        buttomConstraint.isActive = true
        
        selectedIndex = 0
    }
    
    private func choiseView(index: NSInteger) {
        let vc = viewControllers[index]
        let vcView = vc.view!
        
        if scrollView.viewWithTag(6500 + index) != nil {
            return
        }
        vcView.tag = 6500 + index
        vcView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(vcView)
        
        let topConstraint = NSLayoutConstraint(item: vcView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let leftConstrain = NSLayoutConstraint(item: vcView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: scrollView.bounds.size.width * CGFloat(index))
        leftConstrain.isActive = true
        
        let widthConstrain = NSLayoutConstraint(item: vcView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)
        widthConstrain.isActive = true
        
        let heightConstrain = NSLayoutConstraint(item: vcView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0)
        heightConstrain.isActive = true
    }
    
    ///切换tag
    private func choiseTag(index: NSInteger) {
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.size.width * CGFloat(index), y: 0), animated: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.size.width * CGFloat(viewControllers.count), height: scrollView.bounds.size.height)
    }
}

extension SegmentPageView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        segmentBar.selectedIndex = index
        selectedIndex = index
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentBar.updateLineViewPosition(offset: scrollView.contentOffset.x, scrollViewWidth: scrollView.bounds.size.width)
    }
}
