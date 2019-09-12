//
//  FDMPageView.swift
//  FDMPageViewDemo
//
//  Created by FDM on 2019/9/11.
//  Copyright © 2019 发抖喵. All rights reserved.
//

import UIKit

typealias segmentedItem = (JXSegmentedView,Int) -> Void
typealias segmentedDidScroll = (JXSegmentedView,Int, Int,CGFloat) -> Void

class FDMPageView: UIView {
    
    private var contentScrollView = UIScrollView()
    private var indicator = JXSegmentedIndicatorLineView()
    private var segmentedView = JXSegmentedView()
    
    private var didSelectedItem:segmentedItem?
    private var didClickItem:segmentedItem?
    private var didScrollClickItem:segmentedItem?
    private var didScroll:segmentedDidScroll?
    
    ///title控件   -修改属性记得reload
    var segmentedDataSource = JXSegmentedTitleDataSource()
    ///控制器数组
    var controllerAry:Array<UIViewController>?
    ///标题数组
    var titleAry:Array<String>?
    ///主控制器
    var target:UIViewController?
    ///标题b高度
    var titleHeight:CGFloat = 44
    ///线的风格
    var lineStyle: JXSegmentedIndicatorLineStyle = .lengthen
    ///选中的页面
    var index:Int = 0
    
/**  ====================================================================================================
     初始化
            func initWithJXPagingView(target:UIViewController,titleArray:Array<String>,controllerArray:Array<UIViewController>)
     刷新控件
            func reloadView()
     点击选中或者滚动选中都会调用该闭包
            func pageViewDidSelected(_ item:@escaping segmentedItem)
     点击选中的情况才会调用该闭包
            func pageViewDidClick(_ item:@escaping segmentedItem)
     滚动选中的情况才会调用该闭包
            func pageViewDidScrollClick(_ item:@escaping segmentedItem)
     滚动时会调用该闭包
                    segmentedView: JXSegmentedView -
                    leftIndex: 正在滚动中，相对位置处于左边的index -
                    rightIndex: 正在滚动中，相对位置处于右边的index -
                    percent: 从左往右计算的百分比 -
            func pageViewDidScroll(_ item:@escaping segmentedDidScroll)
     添加一个页面在最后
            func addControllerForLast(controller:UIViewController,title:String)
     重新添加所有页面
            func addAllController(titleArray:Array<String>,controllerArray:Array<UIViewController>)
     删除某个页面(仅有一个页面时不能删除)
            func removeControllerWith(Index index:Int)
 
     ====================================================================================================  */
}

extension FDMPageView{
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard self.target != nil else {return}
        layoutPageView()
    }
    
    ///布局
    private func layoutPageView(){
        segmentedView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.titleHeight)
        contentScrollView.frame = CGRect(x: 0, y: self.titleHeight, width: self.frame.width, height: self.frame.height - self.titleHeight)
        contentScrollView.contentSize = CGSize(width: self.frame.width * CGFloat(controllerAry!.count), height: self.frame.height - self.titleHeight)
        
        for i in 0...self.controllerAry!.count - 1{
            let vc = self.controllerAry![i]
            vc.view.frame = CGRect(x: CGFloat(i) * self.frame.width, y: 0, width: self.frame.width, height: self.frame.height - self.titleHeight)
        }
        
        segmentedDataSource.reloadData(selectedIndex: index)
    }
}

//MARK:- Init
extension FDMPageView{
    
    ///初始化JXPagingView
    func initWithJXPagingView(target:UIViewController,titleArray:Array<String>,controllerArray:Array<UIViewController>){
        
        self.target = target
        self.titleAry = titleArray
        self.controllerAry = controllerArray
        
        //DataSource
        segmentedDataSource.titles = titleArray
        segmentedDataSource.isTitleColorGradientEnabled = true
        
        //Indicator
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.lineStyle = lineStyle
        
        //SegmentedView
        segmentedView.delegate = self
        segmentedView.dataSource = segmentedDataSource
        segmentedView.indicators = [indicator]
        self.addSubview(segmentedView)
        
        //contentScrollView
        contentScrollView.backgroundColor = .clear
        contentScrollView.isPagingEnabled = true
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.scrollsToTop = false
        contentScrollView.bounces = false
        target.automaticallyAdjustsScrollViewInsets = false
        if #available(iOS 11.0, *) {
            contentScrollView.contentInsetAdjustmentBehavior = .never
        }
        segmentedView.contentScrollView = contentScrollView
        self.addSubview(contentScrollView)
        
        //addVC
        for vc in controllerArray{
            target.addChild(vc)
            contentScrollView.addSubview(vc.view)
        }
    }
}

//MARK:- Other
extension FDMPageView{
    ///刷新控件
    func reloadView(){
        layoutPageView()
        segmentedView.reloadData()
    }
    
    ///添加一个页面在最后
    func addControllerForLast(controller:UIViewController,title:String){
        controllerAry?.append(controller)
        titleAry?.append(title)
        target?.addChild(controller)
        contentScrollView.addSubview(controller.view)
        segmentedDataSource.titles = titleAry ?? []
        reloadView()
    }
    
    ///重新添加所有页面
    func addAllController(titleArray:Array<String>,controllerArray:Array<UIViewController>){
        for vc in controllerAry!{
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
        for vc in controllerArray{
            target?.addChild(vc)
            contentScrollView.addSubview(vc.view)
        }
        
        titleAry = titleArray
        controllerAry = controllerArray
        segmentedDataSource.titles = titleAry ?? []
        reloadView()
    }
    
    ///删除某个页面
    func removeControllerWith(Index index:Int){
        guard controllerAry!.count > 1 else {return}
        controllerAry![index].view.removeFromSuperview()
        controllerAry![index].removeFromParent()
        controllerAry?.remove(at: index)
        titleAry?.remove(at: index)
        segmentedDataSource.titles = titleAry ?? []
        reloadView()
    }
}

//MARK:- Block
extension FDMPageView{
    ///点击选中或者滚动选中都会调用该方法
    func pageViewDidSelected(_ item:@escaping segmentedItem){
        self.didSelectedItem = item
    }
    
    ///点击选中的情况才会调用该方法
    func pageViewDidClick(_ item:@escaping segmentedItem){
        self.didClickItem = item
    }
    ///滚动选中的情况才会调用该方法
    func pageViewDidScrollClick(_ item:@escaping segmentedItem){
        self.didScrollClickItem = item
    }
    ///滚动时会调用该方法
    func pageViewDidScroll(_ item:@escaping segmentedDidScroll){
        self.didScroll = item
    }
}

//MARK:- Delegate
extension FDMPageView:JXSegmentedViewDelegate{
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int){
        self.index = index
        if self.didSelectedItem != nil {
            didSelectedItem!(segmentedView, index)
        }
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int){
        if self.didClickItem != nil {
            didClickItem!(segmentedView,index)
        }
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int){
        if self.didScrollClickItem != nil {
            didScrollClickItem!(segmentedView,index)
        }
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat){
        if self.didScroll != nil {
            didScroll!(segmentedView,leftIndex,rightIndex,percent)
        }
    }
}
