//
//  PageTitleView.swift
//  DouyuTV
//
//  Created by 刘明 on 16/10/24.
//  Copyright © 2016年 刘明. All rights reserved.
//

import UIKit
private let kScrollLineH :CGFloat  = 3
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView , selectedIndex : Int)
}
//MARK: - 定义常量
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)
class PageTitleView: UIView {
        var titles : [String]
    var currentIndex :Int = 0

    
    weak var delegate :PageTitleViewDelegate?
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
    lazy var titleLables : [UILabel] = [UILabel]()
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
            lable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            lable.textAlignment = .center
            
            let lableX : CGFloat = CGFloat(index) * lableW
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            scrollView.addSubview(lable)
            titleLables.append(lable)
            //添加手势
            lable.isUserInteractionEnabled = true
            let taps = UITapGestureRecognizer(target: self, action: #selector(self.lableTap(tap:)))
            lable.addGestureRecognizer(taps)
        }
    }
    //MARK: - 添加底部滑动线与边线
    private func setupBottomLineAndScrollLine(){
        //底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: kScreenW, height: lineH)
        addSubview(bottomLine)
        //获取第一个lable
        guard let firstLable = titleLables.first else {return}
        firstLable.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        //添加滑动线
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x:firstLable.frame.origin.x , y: frame.height - kScrollLineH, width: kScreenW/CGFloat(titles.count), height: kScrollLineH)
    }

}
    //MARK: - 点击事件
extension PageTitleView{
    @objc func lableTap(tap : UITapGestureRecognizer){
        //拿到点击的lable
        guard let lable = tap.view as? UILabel else {return}
        //如果点击的是同一个lable直接返回
        if lable.tag == currentIndex {return}
        //拿到之前被选中的
        let oldLable = titleLables[currentIndex]
        //改颜色
        oldLable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        lable.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        //保存当前选中的
        currentIndex = lable.tag
        //滚动条位置
        let scrollLineX = CGFloat(lable.tag) * scrollLine.bounds.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
       //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
//MARK: - 接收contentView传过来的数据
extension PageTitleView{
    func setTiele(progress : CGFloat , sourceIndex : Int , targetIndex : Int) {
        //拿出两个lable
        let sourceLable = titleLables[sourceIndex]
        let targetLable = titleLables[targetIndex]
        //移动滑块
        let moveS = targetLable.frame.origin.x - sourceLable.frame.origin.x
        let moveX = moveS * progress
        scrollLine.frame.origin.x = sourceLable.frame.origin.x + moveX
        //文字颜色渐变
        let tempColor = (kSelectColor.0-kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2-kNormalColor.2)
        sourceLable.textColor = UIColor(r: kSelectColor.0-tempColor.0*progress, g: kSelectColor.1-tempColor.1*progress, b: kSelectColor.2-tempColor.2*progress)
        targetLable.textColor = UIColor(r: kNormalColor.0+tempColor.0*progress, g: kNormalColor.1+tempColor.1*progress, b: kNormalColor.2+tempColor.2*progress)
        currentIndex = targetIndex
    }
}
