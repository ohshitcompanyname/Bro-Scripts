# Description:
#   I'm not entirely sure where the door is,
#   can you help me find it
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   there's the door - Thanks Jon
#
# Author:
#   tarebyte


module.exports = (robot) ->
  robot.respond /where's the door?/i, (msg) ->
    imagery = msg.match[3]

    doorQueries = ['doors', 'open doors', 'wide open doors']
    query = doorQueries[Math.floor(Math.random() * doorQueries.length)]

    msg.http('http://ajax.googleapis.com/ajax/services/search/images')
      .query(v: "1.0", rsz: '8', q: doorQueries.random)
      .get() (err, res, body) ->
        images = JSON.parse(body)
        images = images.responseData.results
        msg.send msg.random images
