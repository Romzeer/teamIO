//
//  News.swift
//  TableView
//
//  Created by Romzeer on 05/03/2018.//

import Foundation

struct News: Decodable {
    
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    
    
//    var dictionary: [String: Any] {
//        return [
//            "Auteur": author,
//            "Titre": title,
//            "Description": description,
//            "Url": url,
//            "Image": urlToImage,
//            "Date": publishedAt
//        ]
//    }
    
    init?(json: [String : Any]) {
        guard let auteur = json["author"] as? String,
            let titre = json["title"] as? String,
            let descr = json["description"] as? String,
            let lien = json["url"] as? String,
            let image = json["urlToImage"] as? String,
            let date = json["publishedAt"] as? String
            else {
                return nil
        }
        
        self.author = auteur
        self.title = titre
        self.description = descr
        self.url = lien
        self.urlToImage = image
        self.publishedAt = date
        
        
        
    }
    
    
}


