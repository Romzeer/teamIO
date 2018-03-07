//
//  NewsViewController.swift
//  TableView
//
//  Created by Romzeer on 06/03/2018.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var authorView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var news: News?
    var defaultUrl = URL(string: "https://increasify.com.au/wp-content/uploads/2016/08/default-image.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors = Colors()
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        textView.layer.cornerRadius = 3
        
        authorView.text = news?.author
        titleView.text = news?.title
        textView.text = news?.description
        
         let imageUrl = URL(string: (news?.urlToImage)!)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl!) {
                    DispatchQueue.main.async {
                        self.imageView?.image = UIImage(data: data)
                    }
                }
                else {
                let data = try? Data(contentsOf: self.defaultUrl!)
                    DispatchQueue.main.async {
                        self.imageView?.image = UIImage(data: data!)
                    }
                }
            }
    }
}


