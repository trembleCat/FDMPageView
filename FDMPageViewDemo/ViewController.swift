//
//  ViewController.swift
//  FDMPageViewDemo
//
//  Created by FDM on 2019/9/11.
//  Copyright © 2019 发抖喵. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let subVCArray = [SubVCOne(),SubVCThree(),SubVCTwo()]
    var titleArray = ["one","three","two"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let page = FDMPageView()
        page.frame = CGRect(x: 100, y: 100, width: 300, height: 500)
        page.initWithJXPagingView(target: self, titleArray: self.titleArray, controllerArray: self.subVCArray)
        self.view.addSubview(page)
    }
}
