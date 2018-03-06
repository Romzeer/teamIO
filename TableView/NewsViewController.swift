//
//  NewsViewController.swift
//  TableView
//
//  Created by Romzeer on 06/03/2018.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var authorView: UILabel!
    @IBOutlet weak var descrView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var news: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorView.text = news?.author
        descrView.text = news?.description
        titleView.text = news?.title
        
        let imageUrl = URL(string: (news?.urlToImage)!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageUrl!)
            DispatchQueue.main.async {
                self.imageView?.image = UIImage(data: data!)
            }
        }



        // Do any additional setup after loading the view.
    }

   

}
