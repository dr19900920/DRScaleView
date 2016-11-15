
//
//  NEOCardCollectionViewController.swift
//  NEOScaleView
//
//  Created by dengrui on 16/11/15.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit

private let lineSpacing: CGFloat = 45
private let kCardCollectionViewCell = "kCardCollectionViewCell"

class NEOCardCollectionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.random()
        // Do any additional setup after loading the view.
        view.addSubview(collectionView)
        
        let btn = UIButton(frame: CGRect(x: 20, y: 30, width: 50, height: 50))
        btn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(UIColor.random(), for: .normal)
        view.addSubview(btn)
    }
    
    @objc
    private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate lazy var collectionView: NEOCollectionView = {
        let collectionView = NEOCollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), itemSize: CGSize(width: kScreenWidth * 0.6, height: kScreenHeight * 0.5), lineSpacing: lineSpacing, margin: self.view.center.x - kScreenWidth * 0.3, scale: 0.4)
        collectionView.backgroundColor = UIColor.random()
        let nib = UINib(nibName: "NEOCardCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: kCardCollectionViewCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension NEOCardCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCardCollectionViewCell, for: indexPath) as? NEOCardCollectionViewCell
        
        return cell!
        
    }
    
}
