//
//  Board.swift
//  Chessboard
//
//  Created by Banu Antoro on 6/20/16.
//  Copyright © 2016 Banu Desi Antoro. All rights reserved.
//

import UIKit

class Board: UIView {

 
    var yPos = Int()
    var xPos = Int()
    
    var blocks = [[Block]]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for i in 0...7 {
            var blockRow = [Block]()
            for j in 0...7 {
                let rect = CGRect(x: CGFloat(i*Int(self.bounds.width/8)), y: CGFloat(Float((7-j)*Int(self.bounds.width/8))), width: self.bounds.width/8, height: self.bounds.width/8)
                let uiview = Block.init(frame: rect)
                if ((i+j)%2) == 0 {
                    uiview.backgroundColor = UIColor.brownColor()
                } else {
                    uiview.backgroundColor = UIColor.yellowColor()
                }
                blockRow.append(uiview)
                self.addSubview(uiview)
            }
            blocks.append(blockRow)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func refreshIcon(datas: [String]) {

        for items:String in datas {
            let poss = items.componentsSeparatedByString(",")
            let ascii = Character(poss[1]).unicodeScalarCodePoint()
            yPos = Int(ascii) - 97
            xPos = Int(poss[2])! - 1
            
            if Character(poss[0]).unicodeScalarCodePoint() < 96 {
                
                let origImage = UIImage(named: poss[0].lowercaseString)
                let tintedImg = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                blocks[xPos][yPos].icon.image = tintedImg
                blocks[xPos][yPos].icon.tintColor = UIColor.lightGrayColor()
                
            } else {
                blocks[xPos][yPos].icon.tintColor = UIColor.blackColor()
                blocks[xPos][yPos].icon.image = UIImage.init(named: poss[0])
                
            }
            
        }
        
    }
    
    func clearBoard() {
        for i in 0...7 {
            for j in 0...7 {
                blocks[i][j].icon.image = nil
            }
        }
    }
    
}

class Block: UIView {
    
    var icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        icon = UIImageView.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        icon.image = icon.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        addSubview(icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension Character
{
    func unicodeScalarCodePoint() -> UInt32
    {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }
}

