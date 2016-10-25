//
//  PageContentView.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/25.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit
private let collectionViewIdenfier = "collectionViewIdenfier"

protocol PageContentViewDelegate  : class {
    func pageContentView(pageContentView : PageContentView , progress : CGFloat , sourceInde : Int ,targetIndex : Int)
}
class PageContentView: UIView {
    //MARK: - 定义属性
    var childVcs :[UIViewController]
    weak var delegate : PageContentViewDelegate?
    //是否调用滚动的代理方法
    var isUseScrollDelegate : Bool = false
    
    weak var persentVc: UIViewController?
    var startOffsetX : CGFloat = 0
    //MARK: - 懒加载
    lazy var collectionView : UICollectionView = {[weak self] in
        //创建流水布局
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //创建collectionView
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.bounces = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewIdenfier)
        
        return collection
    }()
    
     init(frame: CGRect , childVCs:[UIViewController],persentVC:UIViewController?) {
        self.childVcs = childVCs
        self.persentVc = persentVC
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension PageContentView{
    func setupUI() {
        //将自控制器添加到父控制器中
        for child in childVcs{
            persentVc?.addChildViewController(child)
        }
        //添加collectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
//MARK: - 数据源
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewIdenfier, for: indexPath)
        //移除之前的所有试图
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.bounds
        childVc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
//MARK: - collection代理
extension PageContentView : UICollectionViewDelegate{
    //滑动结束
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isUseScrollDelegate {
            return
        }
        //滑动的进度
        var progress :CGFloat = 0
        //当前的视图
        var sourceIndex :Int = 0
        //滑动目标视图
        var targetIndex :Int = 0
        let scrollViewW = scrollView.bounds.width
        //判断滑动方向
        let currentOffsetX = scrollView.contentOffset.x
        if currentOffsetX > startOffsetX {//向左
            //计算滑动进度
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //滑动完毕
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{//向右
            progress = 1-(currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            targetIndex = Int(currentOffsetX/scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            //滑动完毕
            if startOffsetX - currentOffsetX == scrollViewW {
                progress = 1
                sourceIndex = targetIndex
            }
        }
        //将计算结果传递出去
//        print("p=   \(progress)    s=   \(sourceIndex) t=  \(targetIndex)")
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceInde: sourceIndex, targetIndex: targetIndex)
        
    }
    //开始滑动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isUseScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
}
//MARK: - 处理点击头部的滚动
extension PageContentView {
    func setScrollCollectionView(currentIndex : Int) {
        //禁止代理
        isUseScrollDelegate = true
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offSetX , y: 0), animated: false)
        
    }
}
