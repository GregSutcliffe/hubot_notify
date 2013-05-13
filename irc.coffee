module.exports = (robot) ->
  robot.router.post "/hubot/irc", (req, res) ->

    msg = req.body.message

    room = req.body.room
    user = req.body.user
    message = "#{user}: #{msg}"

    robot.messageRoom room, message

    res.writeHead 200, {'Content-Type': 'text/plain'}
    res.end()
