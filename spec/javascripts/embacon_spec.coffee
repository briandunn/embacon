describe 'Url', ->
  beforeEach ->
    window.Url = (url) ->
      matches = url.match(/\?([\w=&.]*)/)
      return {params: {}} if matches == null
      params = matches[1]
      paramMap = {}
      fold = (k, v)->
        paramMap[k] = v
      fold(keyVal.split('=')...) for keyVal in params.split('&')
      params: paramMap
  describe 'params', ->
    beforeEach ->
      @params = (urlString)->
        (new Url(urlString)).params
    it 'is a map of key to value', ->
      expect(@params '?foo=bar&baz=qwux').toEqual foo: 'bar', baz: 'qwux'
    it 'is empty when there are no params', ->
      url = 'http://embacon.heroku.com/index.json'
      expect(@params url).toEqual {}

beforeEach ->
  @addMatchers
    toInclude: (expectedObject)->
      (return false unless @actual[key] == value) for key, value of expectedObject
      true

describe 'embacon', ->
  callbackUrl = 'http://embacon.heroku.com/index.json'
  describe 'when a text field is focused', ->
    beforeEach ->
      @fixtures = []
      @fixtures.push @input = $('<input>', type: 'text', size: 20).appendTo('body').focus()
    afterEach ->
      fixture.remove() for fixture in @fixtures
      $("head script[src^='#{callbackUrl}']").remove()
    describe 'and I embacon', ->
      it 'turns the cursor into a watch', ->
        Bacon.embed()
        expect(@input.css 'cursor').toEqual 'wait'
      describe 'requests', ->
        beforeEach ->
          Bacon.embed()
          @embedTag = $ "script[src^='#{callbackUrl}']"
        it 'by injecting a script tag', ->
          expect(@embedTag.length).toBe 1
        it 'as much bacon as will fit', ->
          expect(Url(@embedTag.attr('src')).params).toInclude size: '20'
      describe 'when the server responds', ->
        beforeEach ->
          Bacon.embed()
          @embedTag = $ "script[src^='#{callbackUrl}']"
          callbackName = Url(@embedTag.attr('src')).params.callback
          @bacon = 'Rump shoulder shankle'
          eval "#{callbackName}('#{@bacon}')"
        it 'fills the text field with bacon', ->
          expect(@input.val()).toBe @bacon
        it 'removes the script tag', ->
          expect(@embedTag[0].parentNode).toBe null
        it 'restores the cursor style', ->
          expect(@input.css 'cursor').toEqual 'auto'
      describe 'and I embacon the same field again', ->
        beforeEach ->
          Bacon.embed()
        it 'does not fetch bacon', ->
          expect($("script[src^='#{callbackUrl}']").length).toBe 0
      describe 'and I embacon another text field', ->
        it 'embacons the new field', ->
