# What is an apropriate way to craft a disambiguated jsonp callback name?
Bacon =
  injectScript: (url) ->
    script = document.createElement 'script'
    script.type = 'text/javascript'
    script.src = url
    document.getElementsByTagName('head')[0].appendChild script

  embed: ->
    @target = document.activeElement
    @cursor = @target.style.cursor
    @target.style.cursor = 'wait'
    @scriptTag = @injectScript "http://embacon.heroku.com/index.json?size=#{@target.size}&callback=Bacon.fill"

  fill: (baconIpsum) ->
    @target.value = baconIpsum
    @target.style.cursor = @cursor
    @scriptTag.parentElement.removeChild @scriptTag

window.Bacon = Bacon
