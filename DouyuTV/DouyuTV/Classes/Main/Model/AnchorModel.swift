//
//  AnchorModel.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/31.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间ID
    var room_id: Int = 0
    //封面
    var vertical_src : String = ""
    //手机1还是电脑0
    var isVertical : Int = 0
    //房间名字
    var room_name : String = ""
    //主播昵称
    var nickname : String = ""
    //观看人数
    var online : Int = 0
    //所在城市
    var anchor_city :String = ""
    
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
