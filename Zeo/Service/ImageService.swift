//
//  Resource.swift
//  Zeo
//
//  Created by Umar Farooq on 10/04/25.
//

import UIKit

// A concrete implementation of APIClientProtocol that fetches public images from Flickr's API.

struct ImageService: APIClientProtocol {
    
    private let httpClient: HttpClient
    
    private let cache: ImageCache

    
    // Initializes the API client with an optional `HttpClient`, allowing dependency injection (useful for testing).
    init(httpClient: HttpClient = .shared, cache: ImageCache = ImageCache.shared) {
        self.httpClient = httpClient
        self.cache = cache

    }
    
    
    // Fetches public images from Flickr's API
    func fetchImages() async throws -> Images {
        guard let url = ApiEndpoint.flickrImagesURL else {
            throw NetworkError.invalidURL
        }
      return try await httpClient.get(url: url, responseType: Images.self)
    }
    
    
    // Loads an image from a URL, using the cache if available
    func loadImage(for urlString: String) async -> UIImage? {
        if let cachedImage = cache.getImage(for: urlString) {
            return cachedImage
        }

        // Validate the URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return nil
        }

        do {
            
            // Fetch image data from the network
            let (data, _) = try await URLSession.shared.data(from: url)

            if let image = UIImage(data: data) {
                cache.setImage(image, for: urlString)
                return image
            } else {
                print("Failed to create image from data")
            }
        } catch {
            print("Error downloading image: \(error.localizedDescription)")
        }

        return nil
    }
}
