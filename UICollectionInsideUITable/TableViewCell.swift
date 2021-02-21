//
//  TableViewCell.swift
//  UICollectionInsideUITable
//
//  Created by Gulsah Altiparmak on 19.02.2021.
//

import UIKit
import Alamofire
class TableViewCell: UITableViewCell {
    let imageBaseUrl = "https://image.tmdb.org/t/p/w300"
    let apiKey = "dfa1447aa22cc51e7d90fd37215329fe"
    let baseUrl = "https://api.themoviedb.org/3/"
    let defaultImage = "https://www.abprojeyonetimi.com/wp-content/uploads/2018/03/Movie-Night.jpg"
    var popularMovies = [[Result?]]()
    //var releaseDateMovies : [Result]? = []
    //var revenueMovies : [Result]? = []
    //var primaryReleaseDateMovies : [Result]? = []
    //var orginalTitleMovies : [Result]? = []
    //var voteAverageMovies : [Result]? = []
    //var voteCountMovies : [Result]? = []
    var movieViewModel = MovieListModell()
    let sortValue = ["popularity.desc","release_date.desc","revenue.desc", "primary_release_date.desc"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        if popularMovies.isEmpty{
            for item in sortValue{
                self.getMovieList(sort: item,movieViewModel: movieViewModel  ,completionHandler: { [self] (res) in
                    
                    movieViewModel = res
                   
                 })
             }
        }
     
       collectionView.delegate = self
        collectionView.dataSource = self
  
      
      
    }
    
  
   
    func getMovieList(sort:String,movieViewModel:MovieListModell,  completionHandler: @escaping (MovieListModell) -> ()) {
       
            let url = self.baseUrl + "discover/movie"
            let params = [ "api_key":self.apiKey, "language":"en-US" ,"sort_by": sort,"include_adult":"false","include_video":"true","page":"1"]
        AF.request(url,method:.get,parameters:params).responseJSON{  res in
                  if (res.response?.statusCode == 200){
                    let movieList = try? JSONDecoder().decode(MovieList.self, from: res.data!)
                    
                    self.popularMovies.append((movieList?.results!)!)
                /*  switch sort {
                    case "popularity.desc":
                        self.movieViewModel.popularMovies = movieList?.results
                        //self.popularMovies=movieList?.results
                    case "release_date.desc":
                        self.movieViewModel.releaseDateMovies = movieList?.results
                        self.releaseDateMovies = movieList?.results
                    case "revenue.desc":
                        self.movieViewModel.revenueMovies = movieList?.results
                        //self.revenueMovies = movieList?.results
                    case "primary_release_date.desc":
                        self.movieViewModel.primaryReleaseDateMovies = movieList?.results
                      //  self.primaryReleaseDateMovies = movieList?.results
                    case "original_title.desc":
                        self.movieViewModel.orginalTitleMovies = movieList?.results
                       // self.orginalTitleMovies = movieList?.results
                    case "vote_average.desc":
                        self.movieViewModel.voteAverageMovies = movieList?.results
                      //  self.voteAverageMovies = movieList?.results
                    case "vote_count.desc":
                        self.movieViewModel.voteCountMovies = movieList?.results
                    //    self.voteCountMovies = movieList?.results
                    default:
                        print("hata")
                    }*/
                    
                    completionHandler(movieViewModel)
                  }
        }
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
  
    func configure()  {
        collectionView.reloadData()
       collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: false)
        let flowLayout = UICollectionViewFlowLayout()
     
            flowLayout.itemSize = CGSize(width: 355, height: 290)
      
        
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.scrollDirection = .horizontal
        self.collectionView.setCollectionViewLayout(flowLayout, animated: false)
        
    }

}



extension TableViewCell : UICollectionViewDelegate ,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "big", for: indexPath) as! CollectionViewCell
        
        if !(popularMovies.isEmpty){
            var item = popularMovies[collectionView.tag][indexPath.row % 20]
            
            cell.image.contentMode = .scaleAspectFit
            cell.title.text = item?.title
            cell.descriptionLabel.text = (String(describing: item?.voteAverage!))
           // cell.configure(with:(item))
            if  item?.posterPath != nil {
                cell.image.load(urlString: (imageBaseUrl + ((item?.posterPath)!)) )
            }else{
                cell.image.load(urlString: defaultImage)
            }
          
        }
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
          let pageFloat = (scrollView.contentOffset.x / scrollView.frame.size.width)
          let pageInt = Int(round(pageFloat))
          
          switch pageInt {
          case 0:
              collectionView.scrollToItem(at: [0, 0], at: .right, animated: false)
          case 16:
              collectionView.scrollToItem(at: [0, 0], at: .left, animated: false)
          default:
              break
          }
      }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sender = popularMovies[indexPath.section][indexPath.row]
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
struct MovieListModell: Codable{
    var popularMovies : [Result]?
    var releaseDateMovies : [Result]?
    var revenueMovies : [Result]?
    var primaryReleaseDateMovies: [Result]?
    var orginalTitleMovies : [Result]?
    var voteAverageMovies:[Result]?
    var voteCountMovies:[Result]?
}
