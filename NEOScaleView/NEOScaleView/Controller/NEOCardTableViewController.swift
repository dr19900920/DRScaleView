//
//  NEOCardTableViewController.swift
//  ProjectDemo
//
//  Created by dengrui on 16/11/15.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit

private let kNEOCardTableViewCell = "kNEOCardTableViewCell"
private let kNEOCardCellHeight = kScreenHeight * 0.6

class NEOCardTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.gray
        view.addSubview(tableView)
        
        let btn = UIButton(frame: CGRect(x: 20, y: 30, width: 50, height: 50))
        btn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(UIColor.random(), for: .normal)
        view.addSubview(btn)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewDidScroll(tableView)
    }
    
    @objc
    private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        let nib = UINib(nibName: "NEOCardTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: kNEOCardTableViewCell)
        tableView.rowHeight = kNEOCardCellHeight
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension NEOCardTableViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kNEOCardTableViewCell, for: indexPath) as! NEOCardTableViewCell
        cell.backgroundColor = UIColor.random()
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let viewHeight = scrollView.height + scrollView.contentInset.top
        let viewHeight = kScreenHeight
        for itemCell in tableView.visibleCells {
            let cell = itemCell as! NEOCardTableViewCell
            let y = cell.centerY - scrollView.contentOffset.y
            let p = y - (viewHeight * 0.5)
            let scale = cos(p / viewHeight * 1.2) * 0.95
            UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                cell.cardView!.transform = CGAffineTransform(scaleX: scale, y: scale)
            }, completion: nil)
        }
        
    }


}
