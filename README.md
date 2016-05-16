# SegmentPageView
##
SegmentPageView是一个swift开发类型网易新闻左右Tag切换的控件

##Features
###
- [x] 用AutoLayout的方式
- [x] 用Frame的方式
- [x] 自定义控件

##Requirements
* iOS 8.0+
* Xcode 7.0+

##Usage
直接把SegmentPageView文件夹拖到项目里面就可以<br/>
![](https://github.com/persistty/SegmentPageView/blob/master/SegmentPageView/gif.gif)
<br/>
1.用AutoLayout的方式
```
let test1 = Test1ViewController(nibName: "Test1ViewController", bundle: NSBundle.mainBundle())
test1.title = "新闻娱乐"
        
let test2 = Test2ViewController(nibName: "Test2ViewController", bundle: NSBundle.mainBundle())
test2.title = "消息中心"
        
let test3 = Test3ViewController(nibName: "Test3ViewController", bundle: NSBundle.mainBundle())
test3.title = "新浪微博"
        
//用AutoLayout的方式(用其他第三方布局库也可以)
let segmentView = SegmentPageView(currentVc: self)
segmentView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(segmentView)
        
let hConstraintArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[segmentView]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["segmentView": segmentView])
NSLayoutConstraint.activateConstraints(hConstraintArray)
        
let vConstraintArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[segmentView]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["segmentView": segmentView])
NSLayoutConstraint.activateConstraints(vConstraintArray)
        
segmentView.viewControllers = [test1, test2, test3]
```
2.用Frame的方式
```
let segmentView = SegmentPageView(currentVc: self)
segmentView.frame = CGRect(x: 0, y: 64, width: view.bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 64)
view.addSubview(segmentView)
segmentView.viewControllers = [test1, test2, test3]
```

3.自定义控件
```
let segmentView = SegmentPageView(currentVc: self)
segmentView.translatesAutoresizingMaskIntoConstraints = false
segmentView.segmentBar.backgroundColor = UIColor.lightGrayColor() //操作条的背景颜色
segmentView.segmentBar.buttonTitleNormalColor = UIColor.blackColor() //操作条文字正常的颜色
segmentView.segmentBar.buttonTitleSelectedColor = UIColor.greenColor() //操作条文字选中的颜色
view.addSubview(segmentView)
```
