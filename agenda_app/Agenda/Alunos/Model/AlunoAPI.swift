//
//  AlunoAPI.swift
//  Agenda
//
//  Created by Jefferson Oliveira de Araujo on 22/02/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import UIKit
import Alamofire
//import CoreData

class AlunoAPI: NSObject {
    
    // MARK: GET

    func recuperarAlunos(completion: @escaping() -> Void) {
        AF.request("http://localhost:8080/api/aluno", method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                if let response = response.value as? [String:Any] {
                    guard let listaAlunos = response["alunos"] as? [[String:Any]] else { return }
                    
                    for aluno in listaAlunos {
                        AlunoDAO().salvarAluno(dicionarioAluno: aluno)
                    }
                    completion()
                }
                print(response.value)
                break
            case .failure:
                print(response.error)
                completion()
                break
            }
        }
    }
    
    // MARK: PUT

    func salvarAlunosServer(parameters: [[String:String]]) {
        guard let url = URL(string: "http://localhost:8080/api/aluno/lista") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "put"
        let json = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = json
        request.addValue("aplication/json", forHTTPHeaderField: "Content-Type")
        AF.request(request)
    }
    
    // MARK: DELETE
    
    func deletarAluno(id: String) {
        AF.request("http://localhost:8080/api/aluno/\(id)", method: .delete).responseJSON { (response) in
            switch response.result {
            case .failure:
                print(response.error)
                break
            default:
                break
            }
        }
    }
}
