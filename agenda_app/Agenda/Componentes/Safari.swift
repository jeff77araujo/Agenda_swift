//
//  Safari.swift
//  Agenda
//
//  Created by Jefferson Oliveira de Araujo on 23/02/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import UIKit
import SafariServices

class Safari: NSObject {
    
    func abreWeb(_ alunoSelecionado: Aluno, controller: UIViewController) {
        if let urlDoAluno = alunoSelecionado.site {
            
            var urlFormatada = urlDoAluno
            
            if !urlFormatada.hasPrefix("http://") {
                urlFormatada = String(format: "http://%@", urlFormatada)
            }
            
            guard let url = URL(string: urlFormatada) else { return }
            let safariViewController = SFSafariViewController(url: url)
            controller.present(safariViewController, animated: true, completion: nil)
        }
    }

}
