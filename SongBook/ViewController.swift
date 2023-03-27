//
//  ViewController.swift
//  SongBook
//
//  Created by Ali Can Kayaaslan on 27.03.2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    
    var product = [ArtistResults]()
    var genre = "rock"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setInitViews()
        loadJSONData()
    }
    
    private func setInitViews () {
        productTableView.delegate = self
        productTableView.dataSource = self
    }
    
    private func loadJSONData() {
        
        AF.request("https://itunes.apple.com/search?=media=music&term=\(genre)")
            .response { response in
                print("Response Data \(response)")
                
                let json = try? JSONDecoder().decode(Product.self, from: response.data!)
                self.product = json!.results
                self.productTableView.reloadData()
            }
        
    }


}

extension  ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseidentifier", for: indexPath) as! ProductTableViewCell
        
        if product.count > 0 {
            do {
                let productData = product[indexPath.row]
                
                cell.productImageView.image = try UIImage(data: Data(contentsOf: URL(string: productData.artworkUrl60)!))
                cell.trackNameLabel.text = productData.trackName as! String
                cell.artistNameLabel.text = productData.artistName as! String
                cell.countryLabel.text = productData.country as! String
                
            } catch {
                print("Error!")            }
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

