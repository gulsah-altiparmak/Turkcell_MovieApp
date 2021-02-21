//
//  MovieListModel.swift
//  UICollectionInsideUITable
//
//  Created by Gulsah Altiparmak on 20.02.2021.
//

import Foundation
public class MovieListModel: Codable{
    var popularMovies : [Result]?
    var releaseDateMovies : [Result]?
    var revenueMovies : [Result]?
    var primaryReleaseDateMovies: [Result]?
    var orginalTitleMovies : [Result]?
    var voteAverageMovies:[Result]?
    var voteCountMovies:[Result]?

    
}
