//
//  HomeViewController.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/24.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit
private let kPageTitleH : CGFloat = 40
class HomeViewController: UIViewController {
    //MARK: - 懒加载pageTitle
        lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusH + kNavgationBarH, width: kScreenW, height: kPageTitleH)
        
        let titles = ["推荐","游戏","娱乐","趣玩"]
       let titleView = PageTitleView.init(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    lazy var pageContentView :PageContentView = {[weak self] in
        //Frame
        let contentH = kScreenH - kStatusH - kNavgationBarH - kPageTitleH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusH+kNavgationBarH+kPageTitleH, width:kScreenW , height:contentH)
        //childVCs
        var childVCs = [UIViewController]()
        childVCs.append(CommendViewController())
        for _ in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVCs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, persentVC: self)
        contentView.delegate = self
        return contentView
    }()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }

}
//MARK: - UI
extension HomeViewController{
     func setUpUI(){
        //不需要调整内边距
        automaticallyAdjustsScrollViewInsets = false
        setupNavgationBar()
        
    }
    private func setupNavgationBar(){
        //设置左侧按钮
        let btn = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        //设置右侧按钮
        let size = CGSize(width: 40, height: 40)
        let historyBtn = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let serchBtn = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeBtn = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyBtn,serchBtn,qrcodeBtn]
    }
}
//MARK: - PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
        pageContentView.setScrollCollectionView(currentIndex: selectedIndex)
    }
}
//MARK: - PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate{
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, sourceInde: Int, targetIndex: Int) {
        pageTitleView.setTiele(progress: progress, sourceIndex: sourceInde, targetIndex: targetIndex)
    }
}
