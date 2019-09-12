//
//  SubVCTwo.swift
//  FDMPageViewDemo
//
//  Created by FDM on 2019/9/11.
//  Copyright © 2019 发抖喵. All rights reserved.
//

import UIKit

class SubVCTwo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("two")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ClickoTwo")
    }
}
