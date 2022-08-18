//
//  CadastroUsuario.swift
//  AdaSpace
//
//  Created by Narely Lima on 11/08/22.
//

import UIKit
import Foundation

class CadastroUsuario: UIViewController {

    @IBOutlet weak var lbNomeCadastro: UITextField!
    @IBOutlet weak var lbEmailCadastro: UITextField!
    @IBOutlet weak var lbSenhaCadastro: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cadastro"
    }

    @IBAction func sendRequest(_ sender: Any) {
        makePostRequest()
        self.dismiss(animated: true)
    }
    @IBAction func buttonCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }

    func makePostRequest(){
        guard let url = URL(string: "http://adaspace.local/users") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "name": lbNomeCadastro.text,
            "email": lbEmailCadastro.text,
            "password": lbSenhaCadastro.text
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

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

