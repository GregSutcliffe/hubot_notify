module.exports = (robot) ->
  robot.router.post "/hubot/irc", (req, res) ->

    msg = req.body.message

    robot.logger.info "IRC message recieved."

    room = '##gwmngilfen'
    message = "gwmngilfen: #{msg}"

    robot.messageRoom room, message

    res.writeHead 200, {'Content-Type': 'text/plain'}
