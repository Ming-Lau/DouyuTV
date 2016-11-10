//
//  CollectionBaseCell.swift
//  DouyuTV
//
//  Created by 刘明 on 16/11/1.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    //昵称
    @IBOutlet weak var nameLable: UILabel!
    //图片
    @IBOutlet weak var iconImage: UIImageView!
    //在线人数
    @IBOutlet weak var onLineBtn: UIButton!
    var anchor :AnchorModel?{
        didSet{
            guard let anchor = anchor else {
                return
            }
            //设置在线人数
            var onLineStr : String = ""
            if anchor.online >= 10000 {
                onLineStr = "\(anchor.online/10000)万在线"
            }else{
                onLineStr = "\(anchor.online)在线"
            }
            onLineBtn.setTitle(onLineStr, for: .normal)
            //设置名字
            nameLable.text = anchor.nickname
            //icon
            let url = URL(string: anchor.vertical_src)
            iconImage.kf.setImage(with: url)
        }
    }
}
