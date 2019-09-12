//
//  SubVCOne.swift
//  FDMPageViewDemo
//
//  Created by FDM on 2019/9/11.
//  Copyright © 2019 发抖喵. All rights reserved.
//

import UIKit

class SubVCOne: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("one")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ClickoOne")
    }
}
