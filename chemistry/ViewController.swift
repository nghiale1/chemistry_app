//
//  ViewController.swift
//  pthh
//
//  Created by Nghia on 01/10/2021.
//
import UIKit

class ViewController: UIViewController{

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func bth(_ sender: UITapGestureRecognizer) {
        print("oke")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "VIEW_CBPTHH") as? CanBang_ViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

