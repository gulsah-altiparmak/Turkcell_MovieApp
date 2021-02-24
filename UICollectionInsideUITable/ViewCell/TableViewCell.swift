//
//  TableViewCell.swift
//  UICollectionInsideUITable
//
//  Created by Gulsah Altiparmak on 19.02.2021.
//

import UIKit
import Alamofire
protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: CollectionViewCell?, index: Int, didTappedInTableViewCell: TableViewCell)
   
}
class TableViewCell: UITableViewCell {
    static var sender : Result?
    weak var cellDelegate: CollectionViewCellDelegate?
    var popularMovies = [[Result?]]()
   
    
    var row = 0
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        if popularMovies.isEmpty{
            for item in Constants.sortValue{
                self.getMovieList(sort: item)
             }
            collectionView.reloadData()
        }
     
       collectionView.delegate = self
        collectionView.dataSource = self

    }

    func getMovieList(sort:String) {
       
            let url = Constants.baseUrl + "discover/movie"
        let params = [ "api_key":Constants.apiKey, "language":"en-US" ,"sort_by": sort,"include_adult":"false","include_video":"true","page":"1"]
        AF.request(url,method:.get,parameters:params).responseJSON{  res in
                  if (res.response?.statusCode == 200){
                    let movieList = try? JSONDecoder().decode(MovieList.self, from: res.data!)
                    
                    self.popularMovies.append((movieList?.results!)!)
                
                    
                  }
        }
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
   

    func configure()  {
      
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
        row = indexPath.item
        print("\(indexPath.row)  \(collectionView.tag) \(indexPath.item)")
        if !(popularMovies.isEmpty){
            let item = popularMovies[collectionView.tag][indexPath.item]
        
            cell.image.contentMode = .scaleAspectFit
            cell.title.text = item?.title
            cell.descriptionLabel.text = (String((item?.voteAverage!)!))
           // cell.configure(with:(item))
            if  item?.posterPath != nil {
                cell.image.load(urlString: (Constants.imageBaseUrl + ((item?.posterPath)!)) )
            }else{
                cell.image.load(urlString: Constants.defaultImage)
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
        TableViewCell.sender = popularMovies[collectionView.tag][indexPath.item]
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "MovieDetail") as! MovieDetail
        
        print("I'm tapping the \(indexPath.item)")
        print("sender : \(TableViewCell.sender)")
        
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
       
    }

        func collectionView(collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

}


