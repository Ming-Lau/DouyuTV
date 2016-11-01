//
//  AnchorGroup.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/31.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    //保存anchor
    lazy var anchorArray : [AnchorModel] = [AnchorModel]()
    //房间列表
    var room_list : [[String:NSObject]]? {
        didSet{
            for dict in room_list!{
                anchorArray.append(AnchorModel(dict: dict))
            }
        }
    }
    //组名
    var tag_name : String = ""
    //图标
    var icon_name :String = "home_header_normal"
    override init() {
        
    }
    
    init(dict:[String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
