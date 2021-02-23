//
//  ViewController.swift
//  UICollectionInsideUITable
//
//  Created by Gulsah Altiparmak on 19.02.2021.
//

import UIKit

class ViewController: UIViewController {
    let gradientLayer = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        let ui = UIOperations()
        ui.splashGradientLayer(view: view,gradientLayer: gradientLayer)
        ui.splashAnimation(view: view,animationTitle: "splashScreen3")
        timer(time: 3.0)
    }

    func timer(time:Double) {
        Timer.scheduledTimer(withTimeInterval: time, repeats: false) { (timer) in
            self.performSegue(withIdentifier: "dashboard", sender: nil)
        }
    }

}

