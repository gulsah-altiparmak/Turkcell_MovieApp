//
//  MovieDetail.swift
//  UICollectionInsideUITable
//
//  Created by Gulsah Altiparmak on 23.02.2021.
//

import UIKit
import Cosmos
import TinyConstraints
class MovieDetail: UIViewController {
    var movie:Result?
    let gradientLayer = CAGradientLayer()
    lazy var cosmosView:CosmosView = {
        var view = CosmosView()
        view.settings.updateOnTouch = false
        view.rating = ((movie?.voteAverage ?? 0.0)/2)
        view.settings.filledImage = UIImage(named: "fillStar")?.withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = UIImage(named: "emptyStar")?.withRenderingMode(.alwaysOriginal)
        view.settings.totalStars = 5
        view.settings.starSize = 17
        view.settings.starMargin = 3.3
        view.settings.fillMode = .precise
        return view
    }()
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var posterImage: UIImageView!
   
    let ui = UIOperations()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        movieTitle.text = movie?.title
        if movie?.releaseDate != "" {
            movieReleaseDate.text = movie?.releaseDate
        }else{
            movieReleaseDate.text = "00-00-0000"
        }
      
        let point = CGPoint(x: -15, y: 60)
        view.addSubview(cosmosView)
        cosmosView.centerInSuperview(offset: point, priority: .defaultHigh, isActive: true, usingSafeArea: true)
        
        
       
        movieOverview.text = movie?.overview
       
        if  movie?.backdropPath != nil {
            posterImage.load(urlString: (Constants.imageBaseUrl + ((movie?.backdropPath)!)) )
        }
        else if movie?.posterPath != nil{
            posterImage.load(urlString: (Constants.imageBaseUrl + ((movie?.posterPath)!)) )
        }
        else{
            posterImage.load(urlString: Constants.defaultImage)
        }
        
      
    }
    

}
