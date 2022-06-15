//
//  AlbumTableViewCell.swift
//  iTunesSearch
//
//  Created by Karl Pfister on 6/4/22.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var albumArtworkImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var songCountLabel: UILabel!
    
    override func prepareForReuse() {
        albumArtworkImageView.image = nil
    }
    
    func updateView(for album: Album) {
        guard let imagePath = album.albumImagePath else {return}
        NetworkController.fetchAlbumImage(with: imagePath) { [weak self] result in
            switch result {
            case.success(let albumArt):
                DispatchQueue.main.async {
                    self?.albumArtworkImageView.image = albumArt
                    self?.albumNameLabel.text = album.title
                    self?.songCountLabel.text = album.trackCount <= 1 ? "\(album.trackCount) song" : "\(album.trackCount) songs"                }
            case .failure(let imageError):
                print(imageError.errorDescription!)
            }
        }
    }
}
