( function(){
	var injectScript = function(url, onload) {
		var head = document.getElementsByTagName('head')[0], 
		script = document.createElement('script')
		script.type = 'text/javascript'
		script.src = url
    if(onload)
      script.onload = onload 
		head.appendChild(script)
	}
  insert = function(text) {
    var $active = $(document.activeElement)
    $active.val($active.val() + text)
    $active.css({cursor: 'auto'})
  }
	injectScript("http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js", function() {
		$(document.activeElement).css({cursor: 'wait'})
    injectScript('http://embacon.heroku.com/index.json?callback=insert&' + Math.floor(Math.random()*99999), function() {})
	})
})()

