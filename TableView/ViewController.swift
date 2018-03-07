//
//  ViewController.swift
//  TableView
////

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateView: UILabel!
    @IBOutlet weak var TrumpBtn: UIButton!
    @IBOutlet weak var bitcoinBtn: UIButton!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var tableView: UITableView!
    // var news : [String : [[String:Any]]]?
    private var listNews: [News] = []
    private var news: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let colors = Colors()
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        TrumpBtn.layer.cornerRadius = 5
        TrumpBtn.layer.borderWidth = 1
        TrumpBtn.layer.borderColor = UIColor.orange.cgColor
        bitcoinBtn.layer.cornerRadius = 5
        bitcoinBtn.layer.borderWidth = 1
        bitcoinBtn.layer.borderColor = UIColor.orange.cgColor
        tableView.dataSource = self
        tableView.delegate = self
        getNews(param: "google")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bitcoinTap(_ sender: Any) {
        self.listNews.removeAll()
        getNews(param: "bitcoin")

    }
    
    @IBAction func trumpTap(_ sender: Any) {
        self.listNews.removeAll()
        getNews(param: "trump")
    }
    
    
    
    func getNews(param: String?) {
        let session = URLSession.shared
        let task = session.dataTask(with: URL(string:
            "https://newsapi.org/v2/top-headlines?q=" + param! + "&apiKey=6907f86a013d4230b72551b672b8d76f")!) {
                (data, res, error) in
                guard let responseData = data else {
                    print("Error: did not receive data")
                    
                    return
                }
                guard error == nil else {
                    
                    return
                }
                
                //let decoder = JSONDecoder()
                do {
                    
                  let liste = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]

                    if let listeNews = liste!["articles"] as? [[String: Any]] {
                        for article in listeNews {
                            if let model = News.init(json: article) {
                                //print(model)
                                self.listNews.append(model)
                                
                                
                            }
                        }
                    }
                    DispatchQueue.main.async { // Correct
                        
                        self.listNews = self.listNews.sorted(by: {
                            $0.publishedAt.compare($1.publishedAt) == .orderedAscending
                        })
                        self.tableView.reloadData()
                    }
                   
                    
                    
                } catch {
                    print("error trying to convert data to JSON")
                    print(error)
                }
        }
        task.resume()
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        let news = listNews[indexPath.row]
        
        cell.populate(news: news)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewsViewController {
            destination.news = listNews[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 138.0 / 255.0, green: 58.0 / 255.0, blue: 185.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 251.0 / 255.0, green: 173.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}



