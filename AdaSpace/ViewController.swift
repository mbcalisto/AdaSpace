//
//  ViewController.swift
//  AdaSpace
//
//  Created by Mateus Calisto on 10/08/22.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
    @IBOutlet weak var lbnome: UILabel!
    
    var posts: [Posts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chamarAPI{(posts) in
            print("posts: \(posts[0].content)")
        }
    }
    
    private func chamarAPI(completion: @escaping ([Posts]) -> ()){
        let url = URL(string: "http://adaspace.local/posts")!
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            print("response: \(String(describing: response))")
            print("error: \(String(describing: error))")
            
            guard let responseData = data else {return}
            
            do{
                let posts = try JSONDecoder().decode([Posts].self, from: responseData)
                completion(posts)
                DispatchQueue.main.sync {
                    self.posts = posts
                }
                
                print("name: \(posts)")
                
            }catch let error{
                print("error: \(error)")
            }
        }
        task.resume()
    }
    
}


