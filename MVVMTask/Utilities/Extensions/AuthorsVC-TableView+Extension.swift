//
//  AuthorsVC-Extension.swift
//  MVVMTask
//
//  Created by iRam Technologies Pvt. Ltd. on 22/10/20.
//

import UIKit
import SkeletonView

extension AuthorsDataList: UITableViewDelegate, SkeletonTableViewDataSource {
   
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return "AuthorCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = items?.count
        return count ?? 0
    }
    
    //MARK:- TableView DataSource methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorCell") as! AuthorTableViewCell
        
        cell.authorLbl.text = items?[indexPath.row].owner.displayName
        cell.tagLbl.text = items?[indexPath.row].tags.joined(separator: ", ")
        
        if favouriteAuthors.contains(where: {$0.owner.displayName == cell.authorLbl.text}) {
            cell.checkboxBtn.setImage(UIImage(named: "checked"), for: .normal)
        }else{
            cell.checkboxBtn.setImage(UIImage(named: "unchecked"), for: .normal)
        }
        
        cell.checkboxBtn.tag = indexPath.row
        cell.checkboxBtn.addTarget(self, action: #selector(checkboxBtnTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    //MARK:- TableView Delegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AuthorTableViewCell
        
        if favouriteAuthors.contains(where: {$0.owner.displayName == cell.authorLbl.text}) {
            cell.checkboxBtn.setImage(UIImage(named: "checked"), for: .normal)
        }else{
            cell.checkboxBtn.setImage(UIImage(named: "unchecked"), for: .normal)
        }
        
        cell.checkboxBtn.tag = indexPath.row
        cell.checkboxBtn.addTarget(self, action: #selector(checkboxBtnTapped(sender:)), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let items = items else{return}
        if (indexPath.row == items.count - 1){
            tableView.tableFooterView?.isHidden = false
            delegate?.getData()
        }else{
            tableView.tableFooterView = nil
        }
    }
    
    ///Store the selected cell data
    @objc func checkboxBtnTapped(sender:UIButton){
        let index = sender.tag
        guard let item = items?[index] else{return}
        
        if favouriteAuthors.contains(where: {$0.owner.displayName == item.owner.displayName}) {
            favouriteAuthors.remove(at: favouriteAuthors.firstIndex(where: {$0.owner.displayName == item.owner.displayName}) ?? 0)
        }else{
            favouriteAuthors.append(item)
        }
        tableView?.reloadData()
    }
}
