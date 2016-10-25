//
//  UIBarItem-Extension.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/24.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
    //扩充类方法
//    class func createItem(imageName:String , highImageName : String, size : CGSize)->UIBarButtonItem{
//        let btn = UIButton()
//        btn.setImage(UIImage(named:imageName), for: .normal)
//        btn.setImage(UIImage(named:highImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
//        return UIBarButtonItem(customView: btn)
//        
//    }
    //便利构造函数
    convenience init(imageName:String , highImageName : String, size : CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
        self.init(customView: btn)
    }
}
