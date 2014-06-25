//
//  ViewController.swift
//  FifteenPuzzle
//
//  Created by Chris D'Angelo on 6/24/14.
//  Copyright (c) 2014 Chris D'Angelo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var boardBackground = UIView(frame: CGRectMake(0, 0, 300, 300))
    var boardGame = Board(rows: 4, columns: 4)
    let frameBuffer: CGFloat = 10.0
    let pieceBuffer: CGFloat = 2.0
    var viewsForPieces: PieceView[] = []
    
    init(coder aDecoder: NSCoder!)  {
        super.init(coder: aDecoder)
        viewsForPieces = generateViewsForAllPieces(boardGame)
    }
    
    var sizeOfSquare: (width: CGFloat, height: CGFloat) {
    get {
        var width = (boardBackground.frame.size.width - frameBuffer * 2 - pieceBuffer * (CGFloat(boardGame.columns) - 1.0)) / CGFloat(boardGame.columns)
        var height = (boardBackground.frame.size.height - frameBuffer * 2 - pieceBuffer * (CGFloat(boardGame.rows) - 1.0)) / CGFloat(boardGame.rows)
        
        return (width, height)
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
                println(boardGame)
        
        // put background square on board
        boardBackground.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(boardBackground)
        boardBackground.center = self.view.center;

        // put squares on screen
        let empty = boardGame.empty
        for row in 0..boardGame.rows {
            for col in 0..boardGame.columns {
                if !(row == empty.row && col == empty.col) {
                    // Draw on screen with gesture recognizer
                    let theView = viewsForPieces[row * boardGame.rows + col]
                    boardBackground.addSubview(theView)
                    
                    theView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapButton:"))
                    println(boardGame.pieces[col * row])
                }
            }
        }
        
        

    }
    
    func tapButton (tap: UITapGestureRecognizer) {
        
    }
    
    func getOriginForPiece (column: Int, row: Int) -> (CGFloat, CGFloat) {
        var x = frameBuffer + pieceBuffer * CGFloat(column) + CGFloat(column) * sizeOfSquare.width
        var y = frameBuffer + pieceBuffer * CGFloat(row) + CGFloat(row) * sizeOfSquare.height
        
        return (x, y)
    }
    
    func getFrameForPiece (column: Int, row: Int) -> CGRect {
        let (x, y) = getOriginForPiece(column, row: row)
        let (width, height) = sizeOfSquare
        
        return CGRectMake(x, y, width, height)
    }
    
    func generateViewsForAllPieces (board: Board) -> PieceView[] {
        var peiceViews = Array<PieceView>()
        
        for row in 0..board.rows {
            for col in 0..board.columns {
                if col == board.columns - 1 && row == board.rows - 1 {
                    // last row, we're done
                    break
                }
                
                println("board = \(board)")
                println("board pieces = \(board.pieces)")
                
                let piece = boardGame.pieces[row * board.rows + col]
                let labelText = piece.pieceName
                 println("piece = \(piece)")
                println("piecename = \(piece.pieceName)")
                println(labelText)
                let pieceView = PieceView(frame: getFrameForPiece(col, row: row), labelText: labelText, boardPiece: piece)
                
                peiceViews.append(pieceView)
            }
        }
        
        return peiceViews
    }

}
