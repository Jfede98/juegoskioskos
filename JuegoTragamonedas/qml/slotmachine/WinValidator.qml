import Felgo 3.0
import QtQuick 2.0

Item {
  id: winValidator


  // field to memorize lines that won
  property var currentLines

  // property to hold index of currently visible line
  property int visibleIndex


  // define winning lines
  WinningLine {
    id: line1
    visible: false
    image.source: "../../assets/Line1.png"
    color: "#ff0000"
    positions: [
      {reel: 0, row: 1},
      {reel: 1, row: 1},
      {reel: 2, row: 1}
    ]
  }

  WinningLine {
    id: line2
    visible: false
    image.source: "../../assets/Line2.png"
    color: "#00ff00"
    positions: [
      {reel: 0, row: 0},
      {reel: 1, row: 0},
      {reel: 2, row: 0}
    ]
  }

  WinningLine {
    id: line3
    visible: false
    image.source: "../../assets/Line3.png"
    color: "#0080ff"
    positions: [
      {reel: 0, row: 2},
      {reel: 1, row: 2},
      {reel: 2, row: 2}
    ]
  }


  // Timer to alternate display of multiple winning lines
  Timer {
    id: showTimer
    interval: 1000
    onTriggered: {
      if(currentLines.length > 0) {
        var index = (visibleIndex + 1) % currentLines.length
        showLine(index)
        showTimer.restart()
      }
    }
  }

  // validate if player won on the slot machine
  function validate(machine) {
    currentLines = []
    var winAmount = 0

    if(line1.validate(machine)) {
      currentLines.push(line1)
      winAmount += line1.winAmount
    }
    if(line2.validate(machine)) {
      currentLines.push(line2)
      winAmount += line2.winAmount
    }
    if(line3.validate(machine)) {
      currentLines.push(line3)
      winAmount += line3.winAmount
    }

    // increase player credit by total win amount
    scene.creditAmount += winAmount

    // return true if player has won on at least 1 line
    return currentLines.length > 0
  }

  // reset validator for new game
  function reset() {
    showTimer.stop()
    hideLines()
  }

  // shows lines that won
  function showWinningLines() {
    if(currentLines.length > 0) {
      // show first line and start timer to alternate display of winning lines
      showLine(0)
      showTimer.start()
    }
  }

  // shows a specific line
  function showLine(index) {
    if(index < 0 || index >= currentLines.length)
      return

    hideLines()
    currentLines[index].visible = true
    visibleIndex = index
  }

  // hides all lines
  function hideLines() {
    line1.visible = false
    line2.visible = false
    line3.visible = false
  }

}
