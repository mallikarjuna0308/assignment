//
//  FavouriteVC.swift
//  MVVMTask
//
//  Created by iRam Technologies Pvt. Ltd. on 21/10/20.
//

import UIKit

class FavouriteVC: UIViewController {
   
    
    //MARK:- Outlets
    @IBOutlet weak var FavouriteTableView: UITableView!
    @IBOutlet weak var favLbl: UILabel!
    
    //MARK:- Variables and Instances
    var favouriteData = FavouriteAuthorsData()
    
    //MARK:- View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
                                        
        if favouriteAuthors.count == 0 {
            FavouriteTableView.isHidden = true
            favLbl.isHidden = false
        } else {
            favLbl.isHidden = true
            FavouriteTableView.isHidden = false
            FavouriteTableView.dataSource = (favouriteData as UITableViewDataSource)
            favouriteData.favouriteAuthors = favouriteAuthors
            FavouriteTableView.reloadData()
            FavouriteTableView.tableFooterView = UIView()
        }
    }/// Lifecycle ends here
}
