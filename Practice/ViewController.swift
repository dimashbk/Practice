//
//  ViewController.swift
//  Practice
//
//  Created by Dinmukhamed on 28.01.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
 
    
    
    @IBOutlet weak var table: UITableView!
    var postArr = [Post]()
    let networkManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
//        obtainPost()
        table.delegate = self
        table.dataSource = self
        
        networkManager.obtainPost { [weak self] (result) in
            switch result{
            case .success(let posts):
                self?.postArr = posts
                DispatchQueue.main.async {
                    self?.table.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
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
    

