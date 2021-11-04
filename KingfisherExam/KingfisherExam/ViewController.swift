//
//  ViewController.swift
//  KingfisherExam
//
//  Created by jh on 2021/11/04.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func fetchGifImage(_ sender: UIButton) {
        let url = URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/GIF/1.gif")
        imageView.kf.setImage(with: url)
        imageView.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = .systemGray6
        // Do any additional setup after loading the view.
    }


}

