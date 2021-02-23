//
//  UIOperations.swift
//  UICollectionInsideUITable
//
//  Created by Gulsah Altiparmak on 23.02.2021.
//

import Foundation
import Lottie
class UIOperations {
    let animationView = AnimationView()
    func  splashGradientLayer(view:UIView,gradientLayer:CAGradientLayer) {
     
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 248.0/255.0, green: 189/255.0, blue:97.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 248.0/255.0, green: 189/255.0, blue:97.0/255.0, alpha: 1.0).cgColor,
           
            UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0).cgColor
        ]
        
        
        gradientLayer.startPoint = CGPoint(x: 0,y: 0)
        gradientLayer.endPoint = CGPoint(x: 1,y: 1)
        view.layer.addSublayer(gradientLayer)
    }
    func splashAnimation(view:UIView,animationTitle:String)  {
        animationView.animation = Animation.named(animationTitle)
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
   
}
var imageCache = NSCache<AnyObject,AnyObject>()
extension UIImageView{
    func load(urlString:String){
        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage{
            self.image = image
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
             
            }
            
        }
    }
}
