//
//  NetWorkTools.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/31.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit
import Alamofire
//请求类型
enum MethodType{
    case GET
    case POST
}
class NetWorkTools {
    class func requestData(type : MethodType , URLString: String ,parameters : [String : Any]?=nil ,finishedCallBack : @escaping ( _ result:Any )->()){
        //获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else{
                print(response.result.error)
                return
            }
            finishedCallBack(result)
        }
    }
}
