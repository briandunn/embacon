(function() {
  var Bacon;
  Bacon = {
    injectScript: function(url) {
      var script;
      script = document.createElement('script');
      script.type = 'text/javascript';
      script.src = url;
      return document.getElementsByTagName('head')[0].appendChild(script);
    },
    embed: function() {
      this.target = document.activeElement;
      this.cursor = this.target.style.cursor;
      this.target.style.cursor = 'wait';
      return this.scriptTag = this.injectScript("http://embacon.heroku.com/index.json?size=" + this.target.size + "&callback=Bacon.fill");
    },
    fill: function(baconIpsum) {
      this.target.value = baconIpsum;
      this.target.style.cursor = this.cursor;
      return this.scriptTag.parentNode.removeChild(this.scriptTag);
    }
  };
  window.Bacon = Bacon;
}).call(this);
