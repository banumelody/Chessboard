//
//  ViewController.swift
//  Chessboard
//
//  Created by Banu Antoro on 6/20/16.
//  Copyright © 2016 Banu Desi Antoro. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var board = Board()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        board = Board.init(frame:CGRect(x: 0, y: 0, width:self.view.bounds.width, height: self.view.bounds.width))
        
        view.addSubview(board)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func refreshButtonAction(sender: AnyObject) {
        
        board.clearBoard()
        
        Alamofire.request(.GET, "http://mobile.suitmedia.com/bl/chess.php", parameters: [:])
            .responseString { response in
                
                let data = response.result.value
                var possitions = data!.componentsSeparatedByString("<br/>")
                possitions.removeLast()
                
                self.board.refreshIcon(possitions)

        }
        
    }

}

