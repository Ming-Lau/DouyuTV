//
//  CommendViewController.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/31.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit
private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3*kItemMargin)/2
private let kItemH :CGFloat = kItemW*3/4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH :CGFloat = 50
private let kNormalCell  = "kNormalCell"
private let kPerttyCell  = "kPerttyCell"
private let kHeader  = "kNHeader"
private let kCycleViewH = kScreenW * 3 / 8
class CommendViewController: UIViewController {
    //MARK: - viewModel
    lazy var commendViewModel : CommendViewModel = CommendViewModel()
    fileprivate lazy var cycleView : HomeCycleView = {
        let cycleView = HomeCycleView.homeCycleView()
        cycleView.frame  = CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    //MARK: - 懒加载
    lazy var collectionView : UICollectionView = {[unowned self] in
       let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        //collection
        let collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        //设置size随父控件拉伸
        collection.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collection.showsVerticalScrollIndicator = false
        //注册cell
        collection.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCell)
        collection.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPerttyCell)
        collection.dataSource = self
        collection.delegate = self
        //注册heder
        
        collection.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeader)
        return collection
    }()
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
}
//MARK: - 网络请求
extension CommendViewController{
    func loadData() {
        commendViewModel.requestData {
            self.collectionView.reloadData()
        }
    }
}
//MARK: - 布局
extension CommendViewController{
    func setupUI() {
        //添加collection
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH, 0, 0, 0)
    }
}
extension CommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return commendViewModel.anchorGroup.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = commendViewModel.anchorGroup[section]
        
        return group.anchorArray.count
    }
    //内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = commendViewModel.anchorGroup[indexPath.section]
        let anchor = group.anchorArray[indexPath.item]
        var cell = CollectionBaseCell()
        
        
        if indexPath.section == 1 {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyCell, for: indexPath) as! CollectionPrettyCell

        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCell, for: indexPath) as! CollectionNormalCell

        }
        cell.anchor = anchor
        return cell
        
    }
    //头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let herderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeader, for: indexPath) as! CollectionHeaderView
        herderView.group = commendViewModel.anchorGroup[indexPath.section]
        return herderView
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kItemH)
        
    }
}
