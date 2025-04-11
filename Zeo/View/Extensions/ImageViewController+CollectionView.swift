//
//  ViewControllerExtension.swift
//  Zeo
//
//  Created by Umar Farooq on 10/04/25.
//

import UIKit

extension ImageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageDataViewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCell.identifier,
            for: indexPath
        ) as? ImageCell else {
            return UICollectionViewCell()
        }
        
        // Always reset image to placeholder before loading
           cell.flickrImageView.image = UIImage(named: "placeholder")
           
        // Load the actual image if the URL is valid
        if let _ = imageDataViewModel.getImageURL(for: indexPath.row) {
           cell.setImage(imageDataViewModel: imageDataViewModel, index: indexPath.row)
        }
              
        return cell
    }
    
}


// Configures the layout for the collection view
extension UICollectionViewFlowLayout {
    func configureLayout(for collectionViewWidth: CGFloat, itemsPerRow: CGFloat, spacing: CGFloat) {
         let totalSpacing = (itemsPerRow - 1) * spacing
         let itemWidth = (collectionViewWidth - totalSpacing) / itemsPerRow
        
        // Set the item size and spacing properties
         self.itemSize = CGSize(width: itemWidth, height: itemWidth)
         self.minimumInteritemSpacing = spacing
         self.minimumLineSpacing = spacing
     }
}
