//
//  AuthorVM.swift
//  MVVMTask
//
//  Created by iRam Technologies Pvt. Ltd. on 21/10/20.
//

import UIKit
import SkeletonView

var favouriteAuthors = [Item]()

class AuthorViewModel {
    var data: [Item]?
    
    init(data: [Item]?) {
        self.data = data
    }
    
}

protocol AuthorsDataDelegate {
    func getData()
}

class AuthorsDataList: NSObject {
    
    var items : [Item]?
    var delegate : AuthorsDataDelegate?
    var tableView : UITableView?
    
}
