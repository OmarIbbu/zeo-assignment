//
//  ImageCache.swift
//  Zeo
//
//  Created by Umar Farooq on 10/04/25.
//

import UIKit

// Protocol defining the image caching interface. Here I am using Dependency Inversion Principle
protocol ImageCaching {
    func getImage(for key: String) -> UIImage?
    func setImage(_ image: UIImage, for key: String)
}

// Singleton class that handles in-memory image caching
final class ImageCache: ImageCaching {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    private let accessQueue = DispatchQueue(label: "com.zeo.imagecache", attributes: .concurrent)
    
    // Private initializer to prevent external instantiation
    private init() {
        cache.countLimit = 100           // Max 100 images
        cache.totalCostLimit = 50 * 1024 * 1024 // 50MB
    }
    
    // Retrieves an image from the cache for a given key
    func getImage(for key: String) -> UIImage? {
        var image: UIImage?
        accessQueue.sync {
            image = cache.object(forKey: key as NSString)
        }
        return image
    }
    
    // Stores an image in the cache with a specific key
    func setImage(_ image: UIImage, for key: String) {
        accessQueue.async(flags: .barrier) {
            self.cache.setObject(image, forKey: key as NSString)
        }
    }
}
