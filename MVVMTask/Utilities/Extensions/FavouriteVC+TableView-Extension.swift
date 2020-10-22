//
//  FavouriteVC-Extension.swift
//  MVVMTask
//
//  Created by iRam Technologies Pvt. Ltd. on 22/10/20.
//

import UIKit

// MARK: - UITableView DataSource
extension FavouriteAuthorsData: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = favouriteAuthors?.count
        return items ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! FavouriteTableViewCell

        cell.authorLbl.text = favouriteAuthors?[indexPath.row].owner.displayName
        cell.tagLbl.text = favouriteAuthors?[indexPath.row].tags.joined(separator: ", ")
        return cell
    }
}
