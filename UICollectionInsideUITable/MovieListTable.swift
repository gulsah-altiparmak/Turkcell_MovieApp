//
//  TableViewController.swift
//  UICollectionInsideUITable
//
//  Created by Gulsah Altiparmak on 19.02.2021.
//

import UIKit

class MovieListTable: UITableViewController{
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none

    }
 

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Constants.sortTitle.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "header")
        
        cell?.textLabel?.text = Constants.sortTitle[section]
    
        cell?.textLabel?.font = UIFont (name: "Verdana", size: 20)
        cell?.contentView.backgroundColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
      
        cell.cellDelegate = self
        cell.configure()
       
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let tableViewCell = cell as? TableViewCell  {
            tableViewCell.collectionView.tag = indexPath.section
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = TableViewCell.sender
        performSegue(withIdentifier: "gotoMovie", sender: item)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoMovie"{
            let destination = segue.destination as! MovieDetail
            destination.movie = sender as! Result
            print("Table sender: \(TableViewCell.sender)")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 365
     
    }
}
extension MovieListTable: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: CollectionViewCell?, index: Int, didTappedInTableViewCell: TableViewCell) {
     
        performSegue(withIdentifier: "gotoMovie", sender: TableViewCell.sender)
        
    }
}


