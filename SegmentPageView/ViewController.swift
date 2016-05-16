//
//  ViewController.swift
//  SegmentPageView
//
//  Created by jm on 16/5/13.
//  Copyright © 2016年 persist. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    static let CellIdentifier = "TableViewCell"
    var dataArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TableView"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: ViewController.CellIdentifier)
        
        dataArray.append("使用AutoLayout的方式")
        dataArray.append("使用Frame的方式")
        dataArray.append("自定义操作条")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ViewController.CellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let vc: UIViewController
        switch indexPath.row {
        case 0:
            vc = AutoLayoutViewController(nibName: "AutoLayoutViewController", bundle: NSBundle.mainBundle())
        case 1:
            vc = FrameViewController(nibName: "FrameViewController", bundle: NSBundle.mainBundle())
        case 2:
            vc = CustomBarViewController(nibName: "CustomBarViewController", bundle: NSBundle.mainBundle())
        default:
            vc = AutoLayoutViewController(nibName: "AutoLayoutViewController", bundle: NSBundle.mainBundle())
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

