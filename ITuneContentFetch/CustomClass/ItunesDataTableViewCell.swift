//
//  ItunesDataTableViewCell.swift
//  ITuneContentFetch
//
//  Created by Bharatraj Rai on 4/3/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit

/**
 ItunesDataTableViewCellDelegate protocol has been created to notify is there is any actions in table view cell
*/

protocol ItunesDataTableViewCellDelegate: class {
    func didClickOnFavoriteButton(cell: UITableViewCell)
    func didClickOnMediaGetButton(cell: UITableViewCell)
}

/**
 ItunesDataTableViewCell Custom class has been created to dispay the required objects for itunes catalog.
*/

class ItunesDataTableViewCell: UITableViewCell {
    
    weak var delegate: ItunesDataTableViewCellDelegate?
    
    var itunesTermModel: ItunesMediaModel? {
        didSet {
            trackLabel.text = itunesTermModel?.trackName
            genreLabel.text = itunesTermModel?.primaryGenreName
            setupThumbnailImage()
            iTunesLinkButton.addTarget(self, action: #selector(handleItunesLink), for: .touchUpInside)
        }
    }
    
    let trackLabel: UILabel = {
       let label = UILabel()
        label.text = "Track"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .mainTextBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
         label.text = "Genre"
         label.font = UIFont.systemFont(ofSize: 15)
         label.textColor = .highlightColor
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
        
    let thumbnailImageView: CustomImageView = {
         let imageView = CustomImageView()
         imageView.image = UIImage(systemName: "airplane")
         imageView.contentMode = .scaleAspectFill
         imageView.clipsToBounds = true
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
    
    let favoriteButton: UIButton = {
        let uibutton = UIButton(type: .system)
        uibutton.setImage(UIImage(systemName: "star"), for: .normal)
        uibutton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        uibutton.addTarget(self, action: #selector(markAsFavorite), for: .touchUpInside)
        uibutton.tintColor = .black
        return uibutton
    }()
    
    let iTunesLinkButton: UIButton = {
        let uibutton = UIButton(type: .system)
        uibutton.setTitle("Get", for: .normal)
        uibutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        uibutton.backgroundColor = .blue
        uibutton.layer.cornerRadius = 5
        uibutton.tintColor = .white
        uibutton.translatesAutoresizingMaskIntoConstraints = true
        return uibutton
    }()

    let favoriteButtonFill: UIButton = {
        let uibutton = UIButton(type: .system)
        uibutton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        uibutton.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        uibutton.addTarget(self, action: #selector(markAsFavorite), for: .touchUpInside)
        uibutton.tintColor = .black
        return uibutton
    }()

    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = itunesTermModel?.artworkUrl100 {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(thumbnailImageView)
        thumbnailImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        thumbnailImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let stackView = UIStackView.init(arrangedSubviews: [trackLabel, genreLabel])
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -60).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        iTunesLinkButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iTunesLinkButton)
        iTunesLinkButton.leftAnchor.constraint(equalTo: genreLabel.leftAnchor).isActive = true
        iTunesLinkButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5).isActive = true
        iTunesLinkButton.widthAnchor.constraint(equalToConstant: 45).isActive = true

        
        let favoriteButton = UIButton(type: .system)
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        favoriteButton.addTarget(self, action: #selector(markAsFavorite), for: .touchUpInside)
        favoriteButton.tintColor = .lightGray

        accessoryView = favoriteButton
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func markAsFavorite() {
        delegate?.didClickOnFavoriteButton(cell: self)
    }
    
    @objc func handleItunesLink() {
        delegate?.didClickOnMediaGetButton(cell: self)
    }
    
}
