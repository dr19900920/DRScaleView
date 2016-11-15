//
//  ViewController.swift
//  NEOScaleView
//
//  Created by dengrui on 16/11/15.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit

private let kNEOScaleCell = "kNEOScaleCell"
private let kNEOScaleCellHeight: CGFloat = kScreenHeight * 0.5

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kNEOScaleCell)
        tableView.rowHeight = kNEOScaleCellHeight
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    fileprivate lazy var dataSource: Array<String> = ["table", "collection"]
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kNEOScaleCell, for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.textColor = UIColor.random()
        cell.backgroundColor = UIColor.random()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc: UIViewController?
        if indexPath.row == 0  {
            vc = NEOCardTableViewController()
        } else {
            vc = NEOCardCollectionViewController()
        }
        present(vc!, animated: true, completion: nil)
    }
    
}
