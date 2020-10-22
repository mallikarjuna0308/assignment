//
//  Model.swift
//  MVVMTask
//
//  Created by iRam Technologies Pvt. Ltd. on 21/10/20.
//

import Foundation
// MARK: - Model
struct Model: Codable {
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

// MARK: - Item
struct Item: Codable {
    let tags: [String]
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case tags, owner
    }
}

// MARK: - Owner
struct Owner: Codable {
    let displayName: String
 
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        
    }
}

// MARK: - Helper functions for creating encoders and decoders
func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}

// MARK: - URLSession response handlers
extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func authorModelTask(with url: URL, completionHandler: @escaping (Model?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

