//
//  WiFiViewController.swift
//  LED Controller
//
//  Created by Nick Protonentis on 3/24/20.
//  Copyright © 2020 Nick Protonentis. All rights reserved.
//

import UIKit
import WebKit

class WiFiViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://192.168.1.1")
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func refreshPage(_ sender: Any) {
        webView.reload()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
