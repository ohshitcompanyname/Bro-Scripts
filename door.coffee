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
#   bro where's the door?
#
# Author:
#   tarebyte


module.exports = (robot) ->
  robot.respond /where's the door?/i, (msg) ->
    doorQueries = ['doors', 'open doors', 'wide open doors']
    door = doorQueries[Math.floor(Math.random() * doorQueries.length)]

    imageMe msg, door, (url) ->
      msg.send url

# Rip from imageMe
imageMe = (msg, query, animated, faces, cb) ->
  cb = animated if typeof animated == 'function'
  cb = faces if typeof faces == 'function'
  q = v: '1.0', rsz: '8', q: query, safe: 'active'
  q.imgtype = 'animated' if typeof animated is 'boolean' and animated is true
  q.imgtype = 'face' if typeof faces is 'boolean' and faces is true
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(q)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData?.results
      if images?.length > 0
        image  = msg.random images
        cb "#{image.unescapedUrl}#.png"
