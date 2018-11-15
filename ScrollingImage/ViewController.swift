//
//  ViewController.swift
//  ScrollingImage
//
//  Created by Kevin Yu on 11/14/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

import UIKit
import ImageScrollView

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: ImageScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.image = UIImage(named: "ultimatecake.png")
        self.scrollView.imageView.contentMode = .scaleAspectFit
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.scrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapAction() {
        if (self.scrollView.tag == 0) {
            self.scrollView.image = UIImage(named: "meowTheMagnificent.jpg")
            self.scrollView.tag = 1
        }
        else {
            self.scrollView.image = UIImage(named: "ultimatecake.png")
            self.scrollView.tag = 0
        }
    }

}

