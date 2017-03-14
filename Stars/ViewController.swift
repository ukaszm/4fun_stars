//
//  ViewController.swift
//  Stars
//
//  Created by Łukasz Majchrzak on 30/12/2016.
//  Copyright © 2016 Łukasz Majchrzak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = self.view as? StarsView else { return }
        view.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

