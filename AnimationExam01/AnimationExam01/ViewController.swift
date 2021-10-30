//
//  ViewController.swift
//  AnimationExam01
//
//  Created by jh on 2021/10/28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func rotateBtn(_ sender: Any) {
        
        bellAnimation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    func bellAnimation(){
        for i in 1...8{
            
            UIView.animate(withDuration: 0.5, delay: Double(i) * 0.5, options: .curveEaseInOut, animations: {
                if i % 2 == 0 {
                    
                    self.imageView.transform = .init(rotationAngle: -1/(1.5 + 0.3 * Double(i)))
                }else {
                    self.imageView.transform = .init(rotationAngle: +1/(1.5 + 0.3 * Double(i)))
                }

            }, completion: nil)
            
        }
        
        UIView.animate(withDuration: 0.5, delay: Double(8) * 0.5, options: .curveEaseInOut, animations: {
                self.imageView.transform = .init(rotationAngle: 0)
            }, completion: nil)
    }
}

