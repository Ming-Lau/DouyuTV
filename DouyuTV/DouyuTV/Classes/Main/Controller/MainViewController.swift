//
//  MainViewController.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/24.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc(storyBoardName: "Home")
        addChildVc(storyBoardName: "Live")
        addChildVc(storyBoardName: "Follow")
        addChildVc(storyBoardName: "Profile")
    }
    
    private func addChildVc(storyBoardName : String){
        //1.加载storyboard
        let childVc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        
        //2.添加到tabbar上
        addChildViewController(childVc)
    }
}
