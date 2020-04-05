//
//  ResultListController.swift
//  ITuneContentFetch
//
//  Created by Bharatraj Rai on 4/3/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit

class ItunesMediaController: UITableViewController {
    
    var resultList = [[ItunesMediaModel]]()
    var favoriteItuneList = [ItunesMediaModel]()
    let cellId = "CellID"
    let searchController = UISearchController(searchResultsController: nil)
    var timer: Timer?
    var mediaTypes = [MediaType.Book.rawValue, MediaType.Album.rawValue, MediaType.Coached_audio.rawValue, MediaType.Feature_movie.rawValue, MediaType.Interactive_booklet.rawValue, MediaType.Music_video.rawValue, MediaType.Pdf_podcast.rawValue, MediaType.Podcast_episode.rawValue, MediaType.Software_package.rawValue, MediaType.Song.rawValue, MediaType.Tv_episode.rawValue, MediaType.ArtistFor.rawValue]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupNavigationBar()
        initializeTableView()
    }
    
    func setupSearchBar() {
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func initializeTableView() {
        tableView.register(ItunesDataTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.separatorColor = .mainTextBlue
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "iTunes Catalog"
        navigationController?.setupNavigationalController()
    }
    
    func getDataFromiTunes(searchText: String) {
        let urlString = Service.shared.baseUrlString + searchText
        guard let url = URL(string: urlString) else { return }
        Service.shared.getDataFromApi(url: url, resultType: ItunesResult.self) { [weak self] (resultModelList, error) in
            if let err = error {
                print("error occured while fetching the data", err)
                return
            }
            self?.mergeWithFavoriteList(resultModelList)
        }
    }
    
    func mergeWithFavoriteList(_ resultModelList: ItunesResult?) {
        resultList = []
        if let iTunesModelList = resultModelList?.results, iTunesModelList.count > 0 {
            mediaTypes.forEach { (mediaType) in
                let filteredFavoriteiTunesList = favoriteItuneList.filter{ $0.kind == mediaType}
                let filteredList = iTunesModelList.filter{ $0.kind == mediaType}
                let uniqueMediaItem = Array(Set(filteredFavoriteiTunesList + filteredList))
                if uniqueMediaItem.count > 0 {
                    resultList.append(uniqueMediaItem)
                }
            }
        } else if favoriteItuneList.count > 0 {
            mediaTypes.forEach { (mediaType) in
                let filteredFavoriteiTunesList = favoriteItuneList.filter{ $0.kind == mediaType}
                if filteredFavoriteiTunesList.count > 0 {
                    resultList.append(filteredFavoriteiTunesList)
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func retainFavoriteiTunesData(_ modifiedItuneModel: ItunesMediaModel) {
        let filterList = favoriteItuneList.filter { $0.kind == modifiedItuneModel.kind && $0.trackId == modifiedItuneModel.trackId }
        if modifiedItuneModel.isFavorite == true, filterList.count == 0 {
            favoriteItuneList.append(modifiedItuneModel)
        } else if modifiedItuneModel.isFavorite == false, filterList.count > 0 {
            favoriteItuneList.removeAll {$0.trackId == modifiedItuneModel.trackId}
        }
    }
}

extension ItunesMediaController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false, block: { [weak self] (_) in
            self?.getDataFromiTunes(searchText: searchText)
        })
    }
}

extension ItunesMediaController: ItunesDataTableViewCellDelegate {
    func didClickOnMediaGetButton(cell: UITableViewCell) {
        guard let selectedIndexPath = tableView.indexPath(for: cell) else { return }
        let itunesTermModel = resultList[selectedIndexPath.section][selectedIndexPath.row]
        let artistId = itunesTermModel.artistId ?? 0
        if let appURL = URL(string: "https://itunes.apple.com/lookup?id=\(artistId)") {
            UIApplication.shared.open(appURL) { success in
                if success {
                    print("The URL was delivered successfully.")
                } else {
                    print("The URL failed to open.")
                }
            }
        } else {
            print("Invalid URL specified.")
        }
    }
    
    func didClickOnFavoriteButton(cell: UITableViewCell) {
        guard let selectedIndexPath = tableView.indexPath(for: cell) else { return }
        let itunesTermModel = resultList[selectedIndexPath.section][selectedIndexPath.row]
        let isFavorite = itunesTermModel.isFavorite ?? false
        resultList[selectedIndexPath.section][selectedIndexPath.row].isFavorite = !isFavorite
        retainFavoriteiTunesData(resultList[selectedIndexPath.section][selectedIndexPath.row])
        tableView.reloadRows(at: [selectedIndexPath], with: .fade)
    }
}

class IndentedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}
