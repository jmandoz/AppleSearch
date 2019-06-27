//
//  AppleItemController.swift
//  AppleSearchNew
//
//  Created by Jason Mandozzi on 6/27/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import UIKit

class AppleItemController {
    
    //creating our query to conform to this url below
    //https://itunes.apple.com/search?term=nickelback&media=music
    
    static let baseURL = URL(string: "https://itunes.apple.com")
    
    static func fetchAppleItemFor(term: String, completion: @escaping ([AppleItem]?) -> Void) {
        guard var url = baseURL else {completion(nil); return}
        
        url.appendPathComponent("search")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let searchTermQuery = URLQueryItem(name: "term", value: term)
        //term=\(term)
        //term=nickleback
        
        let medaiQuery = URLQueryItem(name: "media", value: "music")
        //media=music
        
        //at the end of these two QueryItems
        //search?term=\(term)&media=music
        
        components?.queryItems = [searchTermQuery, medaiQuery]
        
        guard let finalURL = components?.url else {completion(nil); return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("oh snap the search didn't work \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil); return}
            
            do {
                let decoder = JSONDecoder()
                let topLevelJSON = try decoder.decode(TopLevelJson.self, from: data)
                
                completion(topLevelJSON.results)
                
            } catch {
                print("error decoding data yo")
                completion(nil)
                return
            }
        }.resume()
        
    }
    
    static func fetchImageFor(appleItem: AppleItem, completion: @escaping (UIImage?) -> Void) {
        let urlForImage = appleItem.imageURL
        URLSession.shared.dataTask(with: urlForImage) { (data, _, error) in
            if let error = error {
                print("Error fetching the image data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("something didn't fetch properly")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
