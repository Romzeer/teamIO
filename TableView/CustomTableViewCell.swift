//
//  CustomTableViewCell.swift
//
//  Created by Romzeer on 08/02/2018.
//  Copyright © 2018 Romzeeer. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

 
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dateView: UILabel!
    var test: String?
    
  
    let session = URLSession.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    


    
func populate(news: News) {
    
        author.text = news.author
        title.text = news.title
       
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: news.publishedAt) {
           
            dateFormatter.dateFormat = "MMM d, yyyy"
            let newDate = dateFormatter.string(from: date)
            dateView.text = newDate
        }
        
        else {
            let currentDate = Date()
            dateFormatter.dateFormat = "MMM d, yyyy"
            let newDate = dateFormatter.string(from: currentDate)
            dateView.text = newDate
        }
    }
    
}
