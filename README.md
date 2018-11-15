# SegmentPageView
##
SegmentPageView是一个swift开发类型网易新闻左右Tag切换的控件

## Features
###
- [x] 用AutoLayout的方式
- [x] 用Frame的方式
- [x] 自定义控件

## Requirements
* iOS 8.0+
* Swift 3.0
* Xcode 8.0+

## Usage
直接把SegmentPageView文件夹拖到项目里面就可以<br/>
![](https://github.com/persistty/SegmentPageView/blob/master/SegmentPageView/gif.gif)
<br/>
1.用AutoLayout的方式
```swift
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
```
2.用Frame的方式
```swift
let segmentView = SegmentPageView(currentVc: self)
segmentView.frame = CGRect(x: 0, y: 64, width: view.bounds.size.width, height: UIScreen.main.bounds.size.height - 64)
view.addSubview(segmentView)
segmentView.viewControllers = [test1, test2, test3]
```

3.自定义控件
```swift
let segmentView = SegmentPageView(currentVc: self)
segmentView.translatesAutoresizingMaskIntoConstraints = false
segmentView.segmentBar.backgroundColor = UIColor.lightGray //操作条的背景颜色
segmentView.segmentBar.buttonTitleNormalColor = UIColor.black //操作条文字正常的颜色
segmentView.segmentBar.buttonTitleSelectedColor = UIColor.green //操作条文字选中的颜色
view.addSubview(segmentView)
```
