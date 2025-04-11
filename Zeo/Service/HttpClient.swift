//
//  HttpUtility.swift
//  Zeo
//
//  Created by Umar Farooq on 10/04/25.
//

import Foundation

final class HttpClient {
    
    // Singleton instance of HttpClient.
    static let shared: HttpClient = HttpClient()
    
    // Private initializer to prevent instantiation from outside the class.
    private init() {}
    
    // Generic method to handle HTTP GET requests and decode the response.
    func get<T: Decodable>(url: URL, responseType: T.Type) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            // Perform the network request.
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noData
            }
            
            // Handle status code validation.
            guard 200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }
            
            // Decode the response data into the expected type.
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            // Propagate any error that occurs during the request or decoding.
            throw NetworkError.decodingError
        }
    }
}
