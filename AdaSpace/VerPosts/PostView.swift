//
//  ViewController.swift
//  AdaSpace
//
//  Created by Mateus Calisto on 10/08/22.
//

import UIKit
import CoreData


class PostView: UIViewController {
    //colocar uma tableview
    @IBOutlet weak var tableView: UITableView!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    var posts: [PostsCodable] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        chamarAPI { (posts) in
            print("posts: \(posts[0].content)")
            self.posts = posts
        }
        title = "Posts"
        tableView.delegate = self
        tableView.dataSource = self

    }

    
    private func chamarAPI(completion: @escaping ([PostsCodable]) -> ()){
        let url = URL(string: "http://adaspace.local/posts")!
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            print("response: \(String(describing: response))")
            print("error: \(String(describing: error))")
            
            guard let responseData = data else {return}
            
            do{
                let posts = try JSONDecoder().decode([PostsCodable].self, from: responseData)
                completion(posts)
                DispatchQueue.main.sync {
                    self.posts = posts
                }
                
                print("name a: \(posts)")
                
            }catch let error{
                print("error: \(error)")
            }
        }
        task.resume()
    }
    
}

extension PostView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentPosts = self.posts[indexPath.row]
        performSegue(withIdentifier: "postCelula", sender: currentPosts)

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "postCelula",
            for: indexPath
        ) as? CellPosts else {
            return UITableViewCell()
        }

        let workout = self.posts[indexPath.row]
        cell.nomePost.text = workout.content.description
        return cell
    }
}


