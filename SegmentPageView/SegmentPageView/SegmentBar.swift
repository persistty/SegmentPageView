//
//  SegmentBar.swift
//  SegmentPageView
//
//  Created by jm on 16/5/11.
//  Copyright © 2016年 persist. All rights reserved.
//

import UIKit

private struct InnerConst {
    static let SegmentHeight: CGFloat = 50
    ///分隔线的高度
    static let LineHeight: CGFloat = 1
}
class SegmentBar: UIView {
    private var selectButton: UIButton?
    private var buttonWidth: CGFloat = 0
    private var lineLeftConstrain: NSLayoutConstraint!
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexColor: 0x007de3)
        return view
    }()
    
    var selectTagCallBack: ((index: NSInteger) -> Void)?
    ///当前选择的Index
    var selectedIndex: NSInteger = 0 {
        didSet {
            setButtonStatus(oldValue, newIndex: selectedIndex)
        }
    }
    
    init(titles: [String]) {
        super.init(frame: CGRectZero)
        setUI(titles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 设置按钮相关的状态
    private func setButtonStatus(oldIndex: NSInteger, newIndex: NSInteger) {
        let oldButton = viewWithTag(6000 + oldIndex) as! UIButton
        let newButton = viewWithTag(6000 + newIndex) as! UIButton
        oldButton.selected = false
        newButton.selected = true
        
        if oldIndex != newIndex {
            lineLeftConstrain.active = false
            
            lineLeftConstrain = NSLayoutConstraint(item: lineView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: buttonWidth * CGFloat(newIndex))
            lineLeftConstrain.active = true
            
            lineView.layoutIfNeeded()
        }
    }
    
    private func setUI(titles: [String]) {
        backgroundColor = UIColor.whiteColor()
        var lastView: UIButton?
        buttonWidth = UIScreen.mainScreen().bounds.size.width / CGFloat(titles.count)
        for title in titles {
            let btn = createButton(title)
            btn.tag = 6000 + subviews.count
            btn.addTarget(self, action: #selector(btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            addSubview(btn)
            if subviews.count == 1 {
                selectButton = btn
            }
            
            //setting btn top equal superview
            let topConstraint = NSLayoutConstraint(item: btn, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0)
            topConstraint.active = true
            
            //setting left constraint
            let leftConstrain: NSLayoutConstraint
            if let view = lastView {
                leftConstrain = NSLayoutConstraint(item: btn, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: 0)
            } else {
                leftConstrain = NSLayoutConstraint(item: btn, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0)
            }
            leftConstrain.active = true
            
            //setting width
            let widthConstrain = NSLayoutConstraint(item: btn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: buttonWidth)
            widthConstrain.active = true
            
            //setting height
            let heightConstraint = NSLayoutConstraint(item: btn, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1, constant: 0)
            heightConstraint.active = true
            
            lastView = btn
        }
        
        addSubview(lineView)
        let buttomConstraint = NSLayoutConstraint(item: lineView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        buttomConstraint.active = true
        
        lineLeftConstrain = NSLayoutConstraint(item: lineView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0)
        lineLeftConstrain.active = true
        
        let widthConstrain = NSLayoutConstraint(item: lineView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: buttonWidth)
        widthConstrain.active = true
        
        //setting height
        let heightConstraint = NSLayoutConstraint(item: lineView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: InnerConst.LineHeight)
        heightConstraint.active = true
        
        selectedIndex = 0
    }
    
    func btnClick(btn: UIButton) {
        selectedIndex = btn.tag - 6000
        
        if let callBack = selectTagCallBack {
            callBack(index: selectedIndex)
        }
    }
    
    //MARK: - 通过title快速创建按钮
    private func createButton(title: String) -> UIButton {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setTitle(title, forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(hexColor: 0xbebebe), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(hexColor: 0x222222), forState: UIControlState.Selected)
        btn.titleLabel!.font = UIFont.systemFontOfSize(15)
        btn.backgroundColor = UIColor.clearColor()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
}
