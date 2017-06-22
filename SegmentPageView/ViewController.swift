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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.CellIdentifier)
        
        dataArray.append("使用AutoLayout的方式")
        dataArray.append("使用Frame的方式")
        dataArray.append("自定义操作条")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.CellIdentifier, for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc: UIViewController
        switch indexPath.row {
        case 0:
            vc = AutoLayoutViewController(nibName: "AutoLayoutViewController", bundle: Bundle.main)
        case 1:
            vc = FrameViewController(nibName: "FrameViewController", bundle: Bundle.main)
        case 2:
            vc = CustomBarViewController(nibName: "CustomBarViewController", bundle: Bundle.main)
        default:
            vc = AutoLayoutViewController(nibName: "AutoLayoutViewController", bundle: Bundle.main)
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

