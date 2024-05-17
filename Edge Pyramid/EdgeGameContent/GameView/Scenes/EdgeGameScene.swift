import Foundation
import SpriteKit
import SwiftUI

enum SwipeDirection {
    case up, down, left, right
}

class EdgeGameScene: SKScene {
    
    var level: LevelItem! {
        didSet {
            if levelLabel != nil {
                makeLevelZone()
            }
        }
    }
    
    private var pauseBtn: SKSpriteNode!
    private var restartBtn: SKSpriteNode!
    private var bonusTimeBtn: SKSpriteNode!
    
    private var bonusTimeCountLabel: SKLabelNode!
    private var levelLabel: SKLabelNode!
    private var timeLabel: SKLabelNode!
    private var creditsLabel: SKLabelNode!
    
    private var chainBlockNodes: [SKSpriteNode] = []
    private var chainBlockNodesPositions: [String: (Int, Int)] = [:]
    private var swipeDirection: SwipeDirection? = nil
    
    private var gamePassed = false {
        didSet {
            isPaused = true
            NotificationCenter.default.post(name: Notification.Name("GAME_WIN"), object: nil, userInfo: nil)
        }
    }
    
    private var timeGame = 10 {
        didSet {
            timeLabel.text = "TIME: \(timeGame)"
            if timeGame == 0 {
                isPaused = true
                NotificationCenter.default.post(name: Notification.Name("LOSE_GAME"), object: nil, userInfo: nil)
            }
        }
    }
    
    private var gameTimer = Timer()
    
    private var bonusTimeCount = UserDefaults.standard.integer(forKey: "bonus_time") {
        didSet {
            UserDefaults.standard.set(bonusTimeCount, forKey: "bonus_time")
        }
    }
    
    private var credits = UserDefaults.standard.integer(forKey: "paunts") {
        didSet {
            UserDefaults.standard.set(credits, forKey: "paunts")
        }
    }
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 1335, height: 750)
        backGame()
        makeUIInterface()
        
        gameTimer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimerFunc), userInfo: nil, repeats: true)
        
        if level == nil {
            level = gameLevels[13]
        }
        makeLevelZone()
        
        let swipeRecognizer = UIPanGestureRecognizer(target: self, action: #selector(swipeBlockRecognieze))
        view.addGestureRecognizer(swipeRecognizer)
    }
    
    @objc private func gameTimerFunc() {
        if !isPaused {
            timeGame -= 1
        }
    }
    
    @objc private func swipeBlockRecognieze(sender: UIPanGestureRecognizer) {
        if !isPaused {
            let translation = sender.translation(in: view)
                    
            if sender.state == .ended {
                if abs(translation.x) > abs(translation.y) {
                    if translation.x > 0 {
                        swipeDirection = .right
                    } else {
                        swipeDirection = .left
                    }
                } else {
                    if translation.y > 0 {
                        swipeDirection = .down
                    } else {
                        swipeDirection = .up
                    }
                }
                
                if let _ = swipeDirection {
                    moveChainBlock()
                }
            }
        }
    }
    
    private var currentMoveBlockPos: CGPoint? = nil
    
    private func moveChainBlock() {
        if currentMoveBlockPos != nil {
            let nodeBlocks = nodes(at: currentMoveBlockPos!)
            for node in nodeBlocks {
                if node.name?.contains("chainblock") == true {
                    moveChainBlockWithSwipe(node: node)
                }
            }
        }
    }
    
    private func moveChainBlockWithSwipe(node: SKNode) {
        let chainBlockPos = chainBlockNodesPositions[node.name!]!
        switch swipeDirection {
           case .up:
                if chainBlockPos.1 - 1 >= 0 && level.gameFieldData.obstacles[chainBlockPos.1 - 1][chainBlockPos.0] != 1 {
                    chainBlockNodesPositions[node.name!] = (chainBlockPos.0, chainBlockPos.1 - 1)
                    moveBlock(node: node)
                }
           case .down:
                if chainBlockPos.1 + 1 < level.gameFieldData.obstacles.count && level.gameFieldData.obstacles[chainBlockPos.1 + 1][chainBlockPos.0] != 1 {
                    chainBlockNodesPositions[node.name!] = (chainBlockPos.0, chainBlockPos.1 + 1)
                    moveBlock(node: node)
                }
           case .left:
                if chainBlockPos.0 + 1 < level.gameFieldData.obstacles[0].count && level.gameFieldData.obstacles[chainBlockPos.1][chainBlockPos.0 + 1] != 1 {
                    chainBlockNodesPositions[node.name!] = (chainBlockPos.0 + 1, chainBlockPos.1)
                    moveBlock(node: node)
                }
           default:
                if chainBlockPos.0 - 1 >= 0 && level.gameFieldData.obstacles[chainBlockPos.1][chainBlockPos.0 - 1] != 1 {
                    chainBlockNodesPositions[node.name!] = (chainBlockPos.0 - 1, chainBlockPos.1)
                    moveBlock(node: node)
                }
       }
       swipeDirection = nil
    }
    
    private func moveBlock(node: SKNode) {
        let chainBlockPos = chainBlockNodesPositions[node.name!]!
        let x = (size.width / 1.5 + 90) - CGFloat(60 * (chainBlockPos.0 + 1))
        let y = (size.height + 500) / 2 - CGFloat(60 * (chainBlockPos.1 + 1))
        let moveAction = SKAction.move(to: CGPoint(x: x, y: y), duration: 0.3)
        node.run(moveAction)
        checkGameIsPassed()
    }
    
    private func checkGameIsPassed() {
        var group: [String: [(Int, Int)]] = [:]
        for (k, value) in chainBlockNodesPositions {
            let key = k.components(separatedBy: "_")[0]
            let list = group[key]
            if list == nil {
                group[key] = []
            }
            group[key]!.append(value)
        }
        
        for (_, chains) in group {
            let chainsBlock1 = chains[0]
            let chainsBlock2 = chains[1]
            let chainBlock1X = chainsBlock1.0
            let chainBlock1Y = chainsBlock1.1
            let chainBlock2X = chainsBlock2.0
            let chainBlock2Y = chainsBlock2.1
            if (chainBlock1X + 1 == chainBlock2X || chainBlock1X - 1 == chainBlock2X || chainBlock1X == chainBlock2X) && (chainBlock1Y + 1 == chainBlock2Y || chainBlock1Y - 1 == chainBlock2Y || chainBlock1Y == chainBlock2Y) {
                gamePassed = true
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        currentMoveBlockPos = location
        
        let objects = nodes(at: location)
        
        guard !objects.contains(restartBtn) else {
            NotificationCenter.default.post(name: Notification.Name("RESTART_GAME"), object: nil, userInfo: nil)
            return
        }
        
        guard !objects.contains(pauseBtn) else {
            pauseGame()
            return
        }
        
        guard !objects.contains(bonusTimeBtn) else {
            useBoosterTime()
            return
        }
    }
    
    func restartGame() -> EdgeGameScene {
        let newGameEdgeScene = EdgeGameScene()
        newGameEdgeScene.level = level
        view?.presentScene(newGameEdgeScene)
        return newGameEdgeScene
    }
    
    private func pauseGame() {
        isPaused = true
        NotificationCenter.default.post(name: Notification.Name("PAUSE_GAME"), object: nil, userInfo: nil)
    }

    func contunueGame() {
        isPaused = false
    }
    
    private func useBoosterTime() {
        if bonusTimeCount > 0 {
            bonusTimeCount -= 1
            timeGame += 5
        }
    }
    
    private func backGame() {
        let backGame = SKSpriteNode(imageNamed: UserDefaults.standard.string(forKey: "background") ?? "game_main_back")
        backGame.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backGame.size = CGSize(width: size.width, height: size.height)
        addChild(backGame)
    }
    
    private func makeLevelZone() {
        makeGameBoard()
        drawObstacles()
        drawBlockChains()
        levelLabel.text = "LEVEL: \(level.levelNum)"
        timeGame = level.time
    }
    
    private func makeGameBoard() {
        for x in 1...level.gameFieldData.obstacles[0].count {
            for y in 1...level.gameFieldData.obstacles.count {
                let x = (size.width / 1.5 + 90) - CGFloat(60 * x)
                let y = (size.height + 500) / 2 - CGFloat(60 * y)
                let backNode = SKSpriteNode(imageNamed: "block_empty")
                backNode.size = CGSize(width: 60, height: 60)
                backNode.position = CGPoint(x: x, y: y)
                addChild(backNode)
            }
        }
    }
    
    private func drawObstacles() {
        for (yIndex, yRow) in level.gameFieldData.obstacles.enumerated() {
            for (xIndex, xItem) in yRow.enumerated() {
                if xItem == 1 {
                    let x = (size.width / 1.5 + 90) - CGFloat(60 * (xIndex + 1))
                    let y = (size.height + 500) / 2 - CGFloat(60 * (yIndex + 1))
                    let obstacleNode = SKSpriteNode(imageNamed: "block_obstacle")
                    obstacleNode.size = CGSize(width: 60, height: 60)
                    obstacleNode.position = CGPoint(x: x, y: y)
                    obstacleNode.name = "obstacleNode_\(yIndex)_\(xIndex)"
                    addChild(obstacleNode)
                }
            }
        }
    }
    
    private func drawBlockChains() {
        for (xPos, yPos) in level.gameFieldData.chainBlocks {
            let x = (size.width / 1.5 + 90) - CGFloat(60 * (xPos + 1))
            let y = (size.height + 500) / 2 - CGFloat(60 * (yPos + 1))
            let chainBlock = SKSpriteNode(imageNamed: "block_chain")
            chainBlock.size = CGSize(width: 60, height: 60)
            chainBlock.position = CGPoint(x: x, y: y)
            chainBlock.name = "chainblock1_\(xPos)_\(yPos)"
            addChild(chainBlock)
            chainBlockNodesPositions[chainBlock.name!] = (xPos, yPos)
        }
    }
    
    private func makeUIInterface() {
        bonusTimeBtn = SKSpriteNode(imageNamed: "b_time")
        bonusTimeBtn.size = CGSize(width: 140, height: 130)
        bonusTimeBtn.position = CGPoint(x: size.width - 100, y: 90)
        addChild(bonusTimeBtn)
        
        let bonusTimeCountBg = SKSpriteNode(imageNamed: "level_item_bg")
        bonusTimeCountBg.size = CGSize(width: 50, height: 60)
        bonusTimeCountBg.position = CGPoint(x: size.width - 170, y: 60)
        bonusTimeCountBg.zPosition = 3
        addChild(bonusTimeCountBg)
        
        bonusTimeCountLabel = SKLabelNode(text: "\(bonusTimeCount)")
        bonusTimeCountLabel.position = CGPoint(x: size.width - 170, y: 50)
        bonusTimeCountLabel.fontName = "IndicoRegular"
        bonusTimeCountLabel.fontSize = 28
        bonusTimeCountLabel.zPosition = 4
        bonusTimeCountLabel.fontColor = UIColor(red: 86/255, green: 6/255, blue: 11/255, alpha: 1)
        addChild(bonusTimeCountLabel)
        
        pauseBtn = SKSpriteNode(imageNamed: "pause_btn")
        pauseBtn.position = CGPoint(x: 80, y: size.height - 60)
        pauseBtn.size = CGSize(width: 90, height: 100)
        addChild(pauseBtn)
        
        restartBtn = SKSpriteNode(imageNamed: "restart_btn")
        restartBtn.size = CGSize(width: 90, height: 100)
        restartBtn.position = CGPoint(x: size.width - 80, y: size.height - 60)
        addChild(restartBtn)
        
        let levelBack = SKSpriteNode(imageNamed: "level_title_bg")
        levelBack.position = CGPoint(x: size.width / 2, y: size.height - 60)
        levelBack.size = CGSize(width: 200, height: 100)
        addChild(levelBack)
        
        levelLabel = SKLabelNode(text: "LEVEL 1")
        levelLabel.position = CGPoint(x: size.width / 2, y: size.height - 70)
        levelLabel.fontName = "IndicoRegular"
        levelLabel.fontSize = 28
        levelLabel.fontColor = UIColor(red: 86/255, green: 6/255, blue: 11/255, alpha: 1)
        addChild(levelLabel)
        
        let timeBack = SKSpriteNode(imageNamed: "time_back")
        timeBack.position = CGPoint(x: size.width / 2 - 300, y: size.height - 70)
        timeBack.size = CGSize(width: 200, height: 80)
        addChild(timeBack)
        
        timeLabel = SKLabelNode(text: "TIME: 10")
        timeLabel.position = CGPoint(x: size.width / 2 - 300, y: size.height - 80)
        timeLabel.fontName = "IndicoRegular"
        timeLabel.fontSize = 28
        timeLabel.fontColor = UIColor(red: 86/255, green: 6/255, blue: 11/255, alpha: 1)
        addChild(timeLabel)
        
        let creditsBack = SKSpriteNode(imageNamed: "time_back")
        creditsBack.position = CGPoint(x: size.width / 2 + 300, y: size.height - 70)
        creditsBack.size = CGSize(width: 200, height: 80)
        addChild(creditsBack)
        
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.position = CGPoint(x: size.width / 2 + 340, y: size.height - 70)
        addChild(coin)
        
        creditsLabel = SKLabelNode(text: "\(credits)")
        creditsLabel.position = CGPoint(x: size.width / 2 + 270, y: size.height - 85)
        creditsLabel.fontName = "IndicoRegular"
        creditsLabel.fontSize = 38
        creditsLabel.fontColor = UIColor(red: 86/255, green: 6/255, blue: 11/255, alpha: 1)
        addChild(creditsLabel)
    }
    
}

#Preview {
    VStack {
        SpriteView(scene: EdgeGameScene())
            .ignoresSafeArea()
    }
}
