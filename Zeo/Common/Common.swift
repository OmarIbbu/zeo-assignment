//
//  Common.swift
//  Zeo
//
//  Created by Umar Farooq on 10/04/25.
//

import Foundation

// Network-related errors
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknown(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Failed to parse the response."
        case .serverError(let code):
            return "Server returned an error with status code \(code)."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

// App configuration related errors
enum AppConfigError: Error {
    case configFileNotFound
    case decodingFailed
}

extension AppConfigError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .configFileNotFound:
            return "Configuration file could not be found."
        case .decodingFailed:
            return "Failed to decode the configuration file."
        }
    }
}

// API endpoint construction
struct ApiEndpoint {
    // Construct the flickrImagesURL based on app config
    static var flickrImagesURL: URL? {
        let config = AppConfig.shared
        let urlString = "\(config.baseURL)\(config.photoFeedsPath)?format=\(config.contentType)&nojsoncallback=\(config.noJsonCallback)"
        return URL(string: urlString)
    }
}
