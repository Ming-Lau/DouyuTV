//
//  NSDate-Extension.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/31.
//  Copyright © 2016年 刘明. All rights reserved.
//

import Foundation
extension NSDate{
    class func getCurrentTime()->String{
        let nowDate = NSDate()
        let noDataS = nowDate.timeIntervalSince1970
        return "\(noDataS)"
    }
}
