//
//  AuthorVC.swift
//  MVVMTask
//
//  Created by iRam Technologies Pvt. Ltd. on 21/10/20.
//

import UIKit
import Network

class AuthorVC: UIViewController, AuthorsDataDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var authorTableView: UITableView!

    //MARK:- Variables and Instances
    let monitor = NWPathMonitor()
    private(set) var authorViewModel: AuthorViewModel?
    fileprivate var searchModel = [Item]()
    fileprivate var page = 1
    
    fileprivate var authorModel = [Item]() {
        didSet {
            authorViewModel = AuthorViewModel(data: authorModel)
            authorsData.items = authorViewModel?.data
            DispatchQueue.main.async {
                self.authorTableView.reloadData()
            }
        }
    }
    
    let authorsData = AuthorsDataList()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //stackApi()
        authorsData.delegate = self
        searchBar.delegate = self
        authorsData.tableView = authorTableView
        authorTableView.delegate = authorsData
        authorTableView.dataSource = authorsData
        authorTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkCheck()
    }
    /// Lifecycle methods end here
    
    ///Check network connetion
    func networkCheck() {
        monitor.pathUpdateHandler = { [self] path in
        if path.status == .satisfied {
            fetchApiData()
        } else {
            DispatchQueue.main.async {
                self.showAlert(title: "Connection Error", message: "Please check your network connection.")
            }
        }
        print(path.isExpensive)
    }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    ///custom alert
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
          message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
        }))
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    ///Delegate method
    func getData() {
        fetchApiData(page: page, isLoading: false)
    }
    
    ///Fetch data from the API
    func fetchApiData(page: Int = 1, isLoading: Bool = true){
        guard let url = URL(string: "https://api.stackexchange.com/questions?site=stackoverflow&page=\(page)") else { return }
        let task = URLSession.shared.authorModelTask(with: url) { data, response, error in
            if let data = data {
                self.authorModel += data.items
                self.searchModel += data.items
                self.page += 1
                DispatchQueue.main.async {
                    self.authorTableView.reloadData()
                }
            }
        }
        task.resume()
    }
}

extension AuthorVC: UISearchBarDelegate {
    
    //MARK:- SearchBar delegate method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        let searchList = searchModel.filter({$0.owner.displayName.uppercased().contains(searchText.uppercased())})
        
        if searchText == "" {
            authorModel = searchModel
        }else {
            if searchList.count > 0 {
                authorModel = searchList
            }else{
                authorModel = []
            }
        }
    }
    
    ///cancel button for SearchBar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        authorModel = searchModel
        view.endEditing(true)
    }
    
    ///dismiss the keyboard when done is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
