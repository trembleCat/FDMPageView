//
//  SubVCThree.swift
//  FDMPageViewDemo
//
//  Created by FDM on 2019/9/11.
//  Copyright © 2019 发抖喵. All rights reserved.
//

import UIKit

class SubVCThree: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("three")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ClickoThree")
    }
}
