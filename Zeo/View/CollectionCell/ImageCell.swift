//
//  FlickrCollectionViewCell.swift
//  Zeo
//
//  Created by Umar Farooq on 10/04/25.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static let identifier = "ImageCell"
    
    @IBOutlet weak var flickrImageView: UIImageView!
    
    // Sets the image asynchronously using the provided view model and index
    func setImage(imageDataViewModel: ImageViewModel, index: Int) {
        // Set the placeholder image first
        flickrImageView.image = UIImage(named: "placeholder")
        
        // Use a Task to call async fetchImage
        Task { [weak self] in
            guard let image = await imageDataViewModel.fetchImage(for: index) else { return }
            
            await MainActor.run {
                // Set the image on the main thread
                self?.flickrImageView.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        flickrImageView.contentMode = .scaleAspectFill
        flickrImageView.clipsToBounds = true
    }
    
}
