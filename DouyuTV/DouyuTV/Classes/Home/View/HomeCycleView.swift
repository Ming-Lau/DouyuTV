//
//  HomeCycleView.swift
//  DouyuTV
//
//  Created by 刘明 on 16/11/10.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit
private let kCycleCell = "kCycleCell"
class HomeCycleView: UIView {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCell)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
}
extension HomeCycleView{
    class func homeCycleView() ->HomeCycleView{
        return Bundle.main.loadNibNamed("HomeCycleView", owner: nil, options: nil)?.first as! HomeCycleView
    }
}
extension HomeCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCell, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.blue : UIColor.red
        return cell
        
    }
}
