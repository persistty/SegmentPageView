//
//  SegmentBar.swift
//  SegmentPageView
//
//  Created by jm on 16/5/11.
//  Copyright © 2016年 persist. All rights reserved.
//

import UIKit

class SegmentBar: UIView {
    private var selectButton: UIButton?
    private var buttonWidth: CGFloat = 0
    private var lineLeftConstrain: NSLayoutConstraint!
    private var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    ///按钮的背景颜色
    var buttonBgColor = UIColor.clear
    ///按钮正常状态的文字颜色
    var buttonTitleNormalColor = UIColor.black
    ///按钮选中状态的文字颜色
    var buttonTitleSelectedColor = UIColor.blue
    ///按钮文字的字体
    var buttonTitleFont = UIFont.systemFont(ofSize: 15)
    ///线的颜色
    var lineColor = UIColor.blue
    ///线的高度
    var lineHeight: CGFloat = 1
    
    
    var titles = [String]() {
        didSet {
            setUI(titles: titles)
        }
    }
    var selectTagCallBack: ((NSInteger) -> Void)?
    ///当前选择的Index
    var selectedIndex: NSInteger = 0 {
        didSet {
            setButtonStatus(oldIndex: oldValue, newIndex: selectedIndex)
        }
    }
    
    //MARK: - 更新LineView的位置
    func updateLineViewPosition(offset: CGFloat, scrollViewWidth: CGFloat) {
        lineLeftConstrain.isActive = false
        
        let constant = (offset / scrollViewWidth) * buttonWidth
        lineLeftConstrain = NSLayoutConstraint(item: lineView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: constant)
        lineLeftConstrain.isActive = true
        
        lineView.layoutIfNeeded()
    }
    
    //MARK: - 设置按钮相关的状态
    private func setButtonStatus(oldIndex: NSInteger, newIndex: NSInteger) {
        let oldButton = viewWithTag(6000 + oldIndex) as! UIButton
        let newButton = viewWithTag(6000 + newIndex) as! UIButton
        oldButton.isSelected = false
        newButton.isSelected = true
    }
    
    private func setUI(titles: [String]) {
        var lastView: UIButton?
        buttonWidth = UIScreen.main.bounds.size.width / CGFloat(titles.count)
        for title in titles {
            let btn = createButton(title)
            btn.tag = 6000 + subviews.count
            btn.addTarget(self, action: #selector(btnClick(btn:)), for: UIControlEvents.touchUpInside)
            addSubview(btn)
            if subviews.count == 1 {
                selectButton = btn
            }
            
            //setting btn top equal superview
            let topConstraint = NSLayoutConstraint(item: btn, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            topConstraint.isActive = true
            
            //setting left constraint
            let leftConstrain: NSLayoutConstraint
            if let view = lastView {
                leftConstrain = NSLayoutConstraint(item: btn, attribute: .left, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
            } else {
                leftConstrain = NSLayoutConstraint(item: btn, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
            }
            leftConstrain.isActive = true
            
            //setting width
            let widthConstrain = NSLayoutConstraint(item: btn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonWidth)
            widthConstrain.isActive = true
            
            //setting height
            let heightConstraint = NSLayoutConstraint(item: btn, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)
            heightConstraint.isActive = true
            
            lastView = btn
        }
        
        lineView.backgroundColor = lineColor
        addSubview(lineView)
        let buttomConstraint = NSLayoutConstraint(item: lineView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        buttomConstraint.isActive = true
        
        lineLeftConstrain = NSLayoutConstraint(item: lineView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        lineLeftConstrain.isActive = true
        
        let widthConstrain = NSLayoutConstraint(item: lineView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonWidth)
        widthConstrain.isActive = true
        
        //setting height
        let heightConstraint = NSLayoutConstraint(item: lineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: lineHeight)
        heightConstraint.isActive = true
        
        selectedIndex = 0
    }
    
    func btnClick(btn: UIButton) {
        selectedIndex = btn.tag - 6000
        
        if let callBack = selectTagCallBack {
            callBack(selectedIndex)
        }
    }
    
    //MARK: - 通过title快速创建按钮
    private func createButton(_ title: String) -> UIButton {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle(title, for: UIControlState())
        btn.setTitleColor(buttonTitleNormalColor, for: UIControlState())
        btn.setTitleColor(buttonTitleSelectedColor, for: UIControlState.selected)
        btn.titleLabel!.font = buttonTitleFont
        btn.backgroundColor = buttonBgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
}
