//
//  CollectionHeaderView.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/31.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
//MARK: - 控件属性
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    var group : AnchorGroup?{
        didSet{
            titleLable.text = group?.tag_name
            icon.image = UIImage(named: group?.icon_name ?? "home_header_hot")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
