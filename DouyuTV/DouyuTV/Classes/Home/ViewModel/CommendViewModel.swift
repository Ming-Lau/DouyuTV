//
//  CommendViewModel.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/31.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit

class CommendViewModel{
    lazy var anchorGroup :[AnchorGroup] = [AnchorGroup]()
    lazy var hotGroup : AnchorGroup = AnchorGroup()
    lazy var prettyGroup:AnchorGroup = AnchorGroup()
    
}
//MARK: - 请求
extension CommendViewModel{
    func requestData( _ finishedCallBack : @escaping ()->())  {
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        let dgroup = DispatchGroup()
        
        //推荐0
        dgroup.enter()
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime()]) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else{return}

            self.hotGroup.tag_name = "推荐"
            self.hotGroup.icon_name = "home_header_hot"
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.hotGroup.anchorArray.append(anchor)
            }
            dgroup.leave()
        }
        
        //颜值1
        dgroup.enter()
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",parameters: parameters) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else{return}
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchorArray.append(anchor)
            }
            dgroup.leave()
        }
        //请求2-12游戏数据
        dgroup.enter()
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:parameters ) { (result) in
            //扒最外层
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else{return}
            for dict in dataArray{
               let group =  AnchorGroup(dict: dict)
                self.anchorGroup.append(group)
            }
            dgroup.leave()
        }
        dgroup.notify(queue: DispatchQueue.main) { 
            self.anchorGroup.insert(self.prettyGroup, at: 0)
            self.anchorGroup.insert(self.hotGroup, at: 0)
            finishedCallBack()
        }
    }
}
