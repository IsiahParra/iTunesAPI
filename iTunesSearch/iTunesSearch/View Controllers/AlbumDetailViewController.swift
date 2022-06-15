//
//  AlbumDetailViewController.swift
//  iTunesSearch
//
//  Created by Karl Pfister on 6/4/22.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    @IBOutlet weak var albumArtworkImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var trackListTableView: UITableView!
    
    var album: Album?
    var tracks: [Track] = []
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        trackListTableView.dataSource = self
    }
    
    func setUpViews() {
        guard let album = album else {
            return
        }
        albumNameLabel.text = album.title
//        albumArtworkImageView
        guard let albumImagePath = album.albumImagePath else {return}
        NetworkController.fetchAlbumImage(with: albumImagePath) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.albumArtworkImageView.image = image
                }
            case .failure(let error):
                print("Theres been an error fetching the image", error.errorDescription!)
            }
        }
        
        NetworkController.fetchTracks(with: "\(album.albumID)") { result in
            switch result {
            case .success(let tracks):
                DispatchQueue.main.async {
                    self.tracks = tracks
                    self.trackListTableView.reloadData()
                }
            case .failure(let error):
                print("There has been an error getting the tracks", error.localizedDescription)
            }
        }
        
    }
    
}
 
extension AlbumDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let track = tracks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath)
        cell.textLabel?.text = track.title
        cell.detailTextLabel?.text = "\(track.trackTimeMillis ?? 0)"
        return cell
    }
    
    
}
    

