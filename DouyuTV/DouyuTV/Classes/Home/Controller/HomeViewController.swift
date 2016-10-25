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
    private lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusH + kNavgationBarH, width: kScreenW, height: kPageTitleH)
        
        let titles = ["推荐","游戏","娱乐","趣玩"]
       let titleView = PageTitleView.init(frame: titleFrame, titles: titles)
        return titleView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        view.addSubview(pageTitleView)
    }

}
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
