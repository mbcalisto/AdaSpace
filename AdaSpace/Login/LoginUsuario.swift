//
//  Login.swift
//  AdaSpace
//
//  Created by Narely Lima on 16/08/22.
//
import UIKit
import Foundation

class LoginUsuario: UIViewController, URLSessionDelegate {

    @IBOutlet weak var lbEmailLogin: UITextField!
    @IBOutlet weak var lbPasswordLogin: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        sendUser(self)
    }

    @IBAction func sendUser(_ sender: Any) {
        loginUsuario()
    }

    func loginUsuario(){
        guard let url = URL(string: "http://adaspace.local/users/login") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let username = lbEmailLogin.text
        let password = lbPasswordLogin.text

        let loginString = String(format: "%@:%@", username!, password!)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")


        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let _ = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}
