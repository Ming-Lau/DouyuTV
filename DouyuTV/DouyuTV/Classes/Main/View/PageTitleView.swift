//
//  PageTitleView.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/24.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit
private let kScrollLineH :CGFloat  = 2
class PageTitleView: UIView {
        var titles : [String]
    //MARK: - 懒加载
        lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    lazy var scrollLine : UIView = {
       let scrollLine  = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    //MARK:- 自定义构造函数
    init(frame: CGRect , titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension PageTitleView{
    func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        setuiTitleLables()
        setupBottomLineAndScrollLine()
    }
    //MARK: - 添加标题
    private func setuiTitleLables(){
        let lableW : CGFloat = kScreenW / CGFloat(titles.count)
        let lableH : CGFloat = frame.height - kScrollLineH
        
        let lableY : CGFloat = 0
        for(index,title) in titles.enumerated(){
            let lable = UILabel()
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16)
            lable.textColor = UIColor.darkGray
            lable.textAlignment = .center
            
            let lableX : CGFloat = CGFloat(index) * lableW
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            scrollView.addSubview(lable)
        }
    }
    //MARK: - 添加底部滑动线与边线
    private func setupBottomLineAndScrollLine(){
        //底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.darkGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: kScreenW, height: lineH)
        addSubview(bottomLine)
        
        //添加滑动线
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x:0 , y: frame.height - kScrollLineH, width: kScreenW/CGFloat(titles.count), height: kScrollLineH)
    }

}
