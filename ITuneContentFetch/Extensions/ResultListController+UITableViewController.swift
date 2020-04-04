//
//  ResultListController+UITableViewController.swift
//  ITuneContentFetch
//
//  Created by Bharatraj Rai on 4/4/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit

extension ItunesMediaController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return resultList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ItunesDataTableViewCell else { return UITableViewCell()}
        cell.delegate = self
        cell.itunesTermModel = resultList[indexPath.section][indexPath.row]
        let isFavorite = cell.itunesTermModel?.isFavorite ?? false
        cell.accessoryView?.tintColor = isFavorite ? .red : .lightGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         let label = UILabel()
         label.text = "Please enter search text above..."
         label.textColor = .lightGray
         label.textAlignment = .center
         label.font = UIFont.boldSystemFont(ofSize: 18)
         return label
     }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
          return resultList.count == 0 ? 200 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        label.backgroundColor = .lightBlue
        let mediaType = resultList[section][0].kind?.capitalized
        label.text = (mediaType?.count ?? 0 > 0) ? mediaType : ""
        label.textColor = .darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
