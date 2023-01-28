//
//  ViewController.swift
//  Practice
//
//  Created by Dinmukhamed on 28.01.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
 
    
    
    @IBOutlet weak var table: UITableView!
    let sessionConf = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    var postArr = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        obtainPost()
        table.delegate = self
        table.dataSource = self
    }
    
    
    func obtainPost(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else
        {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let strongSelf = self else { return }
            if let data = data, error == nil{
                guard let posts = try? strongSelf.decoder.decode( [Post].self, from: data) else{
                    return
                }
                strongSelf.postArr =  posts
                print(posts.count)
                DispatchQueue.main.async {
                    strongSelf.table.reloadData()
                }
            }else{
                print("hui")
            }
            
        }.resume()
    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return postArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let post = postArr[indexPath.row]
            cell.textLabel?.text = post.title
            cell.detailTextLabel?.text = post.body
            return cell
        }
        
        
    }
    

