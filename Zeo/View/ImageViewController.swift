//
//  ViewController.swift
//  Zeo
//
//  Created by Umar Farooq on 10/04/25.
//

import UIKit

class ImageViewController: UIViewController {
    
   
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    // ViewModel responsible for fetching and caching images.
    let imageDataViewModel = ImageViewModel()
    
    // ViewModel providing layout configuration details
     let imageCollectionLayoutViewModel = ImageCollectionViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchImages()
        configureLayout()
    }
    
    // Configures the collection view’s data source and registers the cell NIB.
    private func configureCollectionView() {
        imageCollectionView.dataSource = self
        let nib = UINib(nibName: "ImageCell", bundle: nil)
        imageCollectionView.register(nib, forCellWithReuseIdentifier: ImageCell.identifier)
    }
    
    
    // Asynchronously fetches images from the API and reloads the collection view on the main thread.
    private func fetchImages() {
           Task {
               await imageDataViewModel.fetchImages()
               
               await MainActor.run {
                   if let error = imageDataViewModel.lastError {
                       displayErrorAlert(error)
                   } else {
                       imageCollectionView.reloadData()
                   }
               }
           }
       }
    
    private func displayErrorAlert(_ error: Error) {
        let message = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            self.fetchImages() // Retry loading images
        }))
        present(alert, animated: true)
    }
    
    
    // Configures the layout of the collection view
    private func configureLayout() {
          imageCollectionView.layoutIfNeeded()
          guard let layout = imageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
          layout.configureLayout(
              for: imageCollectionView.bounds.width,
              itemsPerRow: imageCollectionLayoutViewModel.itemsPerRow,
              spacing: imageCollectionLayoutViewModel.spacing
          )
      }

    // Updates the layout when the device orientation changes
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.configureLayout()
        })
    }
}
