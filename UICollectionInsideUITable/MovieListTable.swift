//
//  TableViewController.swift
//  UICollectionInsideUITable
//
//  Created by Gulsah Altiparmak on 19.02.2021.
//

import UIKit
import Alamofire
class MovieListTable: UITableViewController{
    
    var arr: [Result]? = []
    /*var popularMovies : [Result]? = []
    var releaseDateMovies : [Result]? = []
    var revenueMovies : [Result]? = []
    var primaryReleaseDateMovies : [Result]? = []
    var orginalTitleMovies : [Result]? = []
    var voteAverageMovies : [Result]? = []
    var voteCountMovies : [Result]? = []
    var movieViewModel : MovieListModell?
   */
    let baseUrl = "https://api.themoviedb.org/3/"
    let apiKey = "dfa1447aa22cc51e7d90fd37215329fe"
    let sortValue = ["popularity.desc","release_date.desc","revenue.desc", "primary_release_date.desc","original_title.desc","vote_average.desc","vote_count.desc"]
    let sortTitle = ["Popular","Release Date","Revenue","Primary Release"]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
      // getMovieList(sort: "popularity.desc")
     
      // var movies = MovieListModell()
    
    
    }
    
    /*func getMovieList(sort:String,movieViewModel:MovieListModell, completionHandler: @escaping (MovieListModell) -> ()) {
       
            let url = self.baseUrl + "discover/movie"
            let params = [ "api_key":self.apiKey, "language":"en-US" ,"sort_by": sort,"include_adult":"false","include_video":"true","page":"1"]
        AF.request(url,method:.get,parameters:params).responseJSON{ [self] res in
                  if (res.response?.statusCode == 200){
                    let movieList = try? JSONDecoder().decode(MovieList.self, from: res.data!)
                    self.arr = movieList?.results
                    switch sort {
                    case "popularity.desc":
                        self.movieViewModel?.popularMovies = movieList?.results
                        self.popularMovies=movieList?.results
                    case "release_date.desc":
                        self.movieViewModel?.releaseDateMovies = movieList?.results
                        self.releaseDateMovies = movieList?.results
                    case "revenue.desc":
                        self.movieViewModel?.revenueMovies = movieList?.results
                        self.revenueMovies = movieList?.results
                    case "primary_release_date.desc":
                        self.movieViewModel?.primaryReleaseDateMovies = movieList?.results
                        self.primaryReleaseDateMovies = movieList?.results
                    case "original_title.desc":
                        self.movieViewModel?.orginalTitleMovies = movieList?.results
                        self.orginalTitleMovies = movieList?.results
                    case "vote_average.desc":
                        self.movieViewModel?.voteAverageMovies = movieList?.results
                        self.voteAverageMovies = movieList?.results
                    case "vote_count.desc":
                        self.movieViewModel?.voteCountMovies = movieList?.results
                        self.voteCountMovies = movieList?.results
                    default:
                        print("hata")
                    }
                    completionHandler(movieViewModel)
                  }
        }
    }
 */
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sortTitle.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "header")
        
            cell?.textLabel?.text = sortTitle[section]
    
        cell?.textLabel?.font = UIFont (name: "Verdana", size: 20)
        cell?.contentView.backgroundColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
     
        cell.configure()
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let tableViewCell = cell as? TableViewCell  {
            tableViewCell.collectionView.tag = indexPath.section
        }
   

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 365
     
    }
}
/*struct MovieListModell: Codable{
    var popularMovies : [Result]?
    var releaseDateMovies : [Result]?
    var revenueMovies : [Result]?
    var primaryReleaseDateMovies: [Result]?
    var orginalTitleMovies : [Result]?
    var voteAverageMovies:[Result]?
    var voteCountMovies:[Result]?

    
}
*/
