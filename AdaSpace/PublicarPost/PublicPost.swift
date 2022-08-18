//
//  PublicPost.swift
//  AdaSpace
//
//  Created by Narely Lima on 17/08/22.
//

import UIKit
import Foundation

class PublicPost: UIViewController  {

    @IBOutlet weak var lbWritePost: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func savePost(_ sender: Any) {
        makePostRequest()
        self.dismiss(animated: true)
    }
    @IBAction func cancelPost(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func makePostRequest(){
        guard let url = URL(string: "http://adaspace.local/posts") else {
            return
        }

        let BearerAuth = "lga0KoqHPS+RbX83Hzj6NA=="
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(BearerAuth)", forHTTPHeaderField: "Authorization")

        let posts = lbWritePost.text

        request.httpBody = posts?.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("sucesso: \(response)")
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}
