//
//  FlickrViewModel 2.swift
//  Zeo
//
//  Created by Umar Farooq on 10/04/25.
//

import UIKit

// Protocol defining the interface for fetching images from a Flickr-like API
protocol APIClientProtocol {
    // Asynchronously downloads images and returns Images
    func fetchImages() async throws -> Images
    // Asynchronously fetches an image for a given URL string
    func loadImage(for urlString: String) async -> UIImage?
}


// ViewModel responsible for handling image data and caching logic

final class ImageViewModel {
    
    private let resource: APIClientProtocol
    private(set) var images: [Image] = []
    private let cache: ImageCache
    var lastError: NetworkError?

    
    init(resource: APIClientProtocol = ImageService(),cache: ImageCache = .shared) {
        self.resource = resource
        self.cache = cache
    }
    
    // Fetches image data from the API and updates the images array
        func fetchImages() async {
            do {
                let response = try await resource.fetchImages()
                self.images = response.items
            } catch let error as NetworkError {
                self.lastError = error  // Expose the error to the ViewController
            } catch {
                self.lastError = .unknown(error)  // Handle other types of errors
            }
        }
        
    
    // Returns the URL string of an image at a specific index
    func getImageURL(for index: Int) -> String? {
        guard images.indices.contains(index) else { return nil }
        return images[index].media.url
    }
    
    
    // Fetches an image for a given index
     func fetchImage(for index: Int) async -> UIImage? {
         guard let urlString = getImageURL(for: index) else { return nil }
         return await resource.loadImage(for: urlString)
     }

}
