import Felgo 3.0
import QtQuick 2.0
import "slotmachine"

GameWindow {
  id: gameWindow

  // You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"

  activeScene: scene

  // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
  // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
  // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
  // this resolution is for iPhone 4 & iPhone 4S
  width: 927
  height: 1648

  Scene {
    id: scene

    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 640
    height: 1060

    // properties for the game
    property int betAmount: 4 // amount to bet per line
    property int creditAmount: 400 // player credit for gambling

    // fill game window with background
    Rectangle {
      anchors.fill: scene.gameWindowAnchorItem
      color: "#8A2E73"
    }

    Juegoslot{
        id: slotMachine
        x: 173
        y: 415
        defaultItemHeight: 73
        defaultReelWidth: 106
        z: 1
    }

    Image {
      id: watermark
      anchors.fill: scene
      source: "../assets/watermark_bg.png"
    }




    Image {
        id: maquina
        source: "../assets/frame.png"
        width: 430
        height: 540
        x: 120
        y: 250
    }







    // configure top bar
        TopBar {
          id: topBar
          width: scene.gameWindowAnchorItem.width
          anchors.top: scene.gameWindowAnchorItem.top
          anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
        }

        // configure bottom bar
        BottomBar {
          id: bottomBar
          width: scene.gameWindowAnchorItem.width
          anchors.bottom: scene.gameWindowAnchorItem.bottom
          anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter

          // link signals to handler functions
          onStartClicked: scene.startSlotMachine()
          onAutoClicked: scene.autoPlaySlotMachine()
          onIncreaseBetClicked: scene.increaseBetAmount()
          onDecreaseBetClicked: scene.decreaseBetAmount()
          onMaxBetClicked: scene.maxBetAmount()
        }

        // increase bet
        function increaseBetAmount() {
          // prevent bet changes while start button is active (machine is running)
          if(bottomBar.startActive)
            return

          // increase bet amount to next bigger step
          if (betAmount < 5 && creditAmount >= 5)
            betAmount = 5
          else if (betAmount < 8 && creditAmount >= 8)
            betAmount = 8
          else if (betAmount < 10 && creditAmount >= 10)
            betAmount = 10
          else if (betAmount < 15 && creditAmount >= 15)
            betAmount = 15
          else if (betAmount < 20 && creditAmount >= 20)
            betAmount = 20
        }

        // decrease bet
        function decreaseBetAmount() {
          // prevent bet changes while start button is active (machine is running)
          if(bottomBar.startActive)
            return

          // decrease bet amount to next smaller step
          if (betAmount > 15 && creditAmount >= 15)
            betAmount = 15
          else if (betAmount > 10 && creditAmount >= 10)
            betAmount = 10
          else if (betAmount > 8 && creditAmount >= 8)
            betAmount = 8
          else if (betAmount > 5 && creditAmount >= 5)
            betAmount = 5
          else if (betAmount > 4)
            betAmount = 4
        }

        // set maximum bet
        function maxBetAmount() {
          // prevent bet changes while machine is started
          if(bottomBar.startActive)
            return

          // set bet amount to maximum affordable available step
          if(creditAmount >= 20)
            betAmount = 20
          else if(creditAmount >= 15)
            betAmount = 15
          else if(creditAmount >= 10)
            betAmount = 10
          else if(creditAmount >= 8)
            betAmount = 8
          else if(creditAmount >= 5)
            betAmount = 5
          else if(creditAmount >= 4)
            betAmount = 4
        }

        // auto play slot machine
        function autoPlaySlotMachine() {
          // switch active state of auto button
          bottomBar.autoActive = !bottomBar.autoActive
          if(bottomBar.autoActive)
            startSlotMachine()
        }

            // start slot machine
        function startSlotMachine() {
            if(!slotMachine.spinning && scene.creditAmount >= scene.betAmount) {
              bottomBar.startActive = true

              // reduce player credits
              scene.creditAmount -= scene.betAmount

              // start machine
              var stopInterval = utils.generateRandomValueBetween(500, 1000) // between 500 and 1000 ms
              slotMachine.spin(stopInterval)
            }
        }

        function spinEnded() {
          bottomBar.startActive = false
          if(bottomBar.autoActive)
            startSlotMachine()
        }

  }
}