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
}
class SegmentBar: UIView {
    private var selectButton: UIButton?
    private var buttonWidth: CGFloat = 0
    private var lineLeftConstrain: NSLayoutConstraint!
    private var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.blueColor()
        return view
    }()
    
    ///按钮的背景颜色
    var buttonBgColor = UIColor.clearColor()
    ///按钮正常状态的文字颜色
    var buttonTitleNormalColor = UIColor.blackColor()
    ///按钮选中状态的文字颜色
    var buttonTitleSelectedColor = UIColor.blueColor()
    ///按钮文字的字体
    var buttonTitleFont = UIFont.systemFontOfSize(15)
    ///线的颜色
    var lineColor = UIColor.blueColor()
    ///线的高度
    var lineHeight: CGFloat = 1
    
    
    var titles = [String]() {
        didSet {
            setUI(titles)
        }
    }
    var selectTagCallBack: ((index: NSInteger) -> Void)?
    ///当前选择的Index
    var selectedIndex: NSInteger = 0 {
        didSet {
            setButtonStatus(oldValue, newIndex: selectedIndex)
        }
    }
    
    //MARK: - 更新LineView的位置
    func updateLineViewPosition(offset: CGFloat, scrollViewWidth: CGFloat) {
        lineLeftConstrain.active = false
        
        let constant = (offset / scrollViewWidth) * buttonWidth
        lineLeftConstrain = NSLayoutConstraint(item: lineView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: constant)
        lineLeftConstrain.active = true
        
        lineView.layoutIfNeeded()
    }
    
    //MARK: - 设置按钮相关的状态
    private func setButtonStatus(oldIndex: NSInteger, newIndex: NSInteger) {
        let oldButton = viewWithTag(6000 + oldIndex) as! UIButton
        let newButton = viewWithTag(6000 + newIndex) as! UIButton
        oldButton.selected = false
        newButton.selected = true
    }
    
    private func setUI(titles: [String]) {
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
        
        lineView.backgroundColor = lineColor
        addSubview(lineView)
        let buttomConstraint = NSLayoutConstraint(item: lineView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        buttomConstraint.active = true
        
        lineLeftConstrain = NSLayoutConstraint(item: lineView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0)
        lineLeftConstrain.active = true
        
        let widthConstrain = NSLayoutConstraint(item: lineView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: buttonWidth)
        widthConstrain.active = true
        
        //setting height
        let heightConstraint = NSLayoutConstraint(item: lineView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: lineHeight)
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
        btn.setTitleColor(buttonTitleNormalColor, forState: UIControlState.Normal)
        btn.setTitleColor(buttonTitleSelectedColor, forState: UIControlState.Selected)
        btn.titleLabel!.font = buttonTitleFont
        btn.backgroundColor = buttonBgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
}
