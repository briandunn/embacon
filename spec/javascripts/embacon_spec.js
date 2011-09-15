(function() {
  describe('Url', function() {
    beforeEach(function() {
      return window.Url = function(url) {
        var fold, keyVal, matches, paramMap, params, _i, _len, _ref;
        matches = url.match(/\?([\w=&.]*)/);
        if (matches === null) {
          return {
            params: {}
          };
        }
        params = matches[1];
        paramMap = {};
        fold = function(k, v) {
          return paramMap[k] = v;
        };
        _ref = params.split('&');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          keyVal = _ref[_i];
          fold.apply(null, keyVal.split('='));
        }
        return {
          params: paramMap
        };
      };
    });
    return describe('params', function() {
      beforeEach(function() {
        return this.params = function(urlString) {
          return (new Url(urlString)).params;
        };
      });
      it('is a map of key to value', function() {
        return expect(this.params('?foo=bar&baz=qwux')).toEqual({
          foo: 'bar',
          baz: 'qwux'
        });
      });
      return it('is empty when there are no params', function() {
        var url;
        url = 'http://embacon.heroku.com/index.json';
        return expect(this.params(url)).toEqual({});
      });
    });
  });
  beforeEach(function() {
    return this.addMatchers({
      toInclude: function(expectedObject) {
        var key, value;
        for (key in expectedObject) {
          value = expectedObject[key];
          if (this.actual[key] !== value) {
            return false;
          }
        }
        return true;
      }
    });
  });
  describe('embacon', function() {
    var callbackUrl;
    callbackUrl = 'http://embacon.heroku.com/index.json';
    return describe('when a text field is focused', function() {
      beforeEach(function() {
        this.fixtures = [];
        return this.fixtures.push(this.input = $('<input>', {
          type: 'text',
          size: 20
        }).appendTo('body').focus());
      });
      afterEach(function() {
        var fixture, _i, _len, _ref;
        _ref = this.fixtures;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          fixture = _ref[_i];
          fixture.remove();
        }
        return $("head script[src^='" + callbackUrl + "']").remove();
      });
      return describe('and I embacon', function() {
        it('turns the cursor into a watch', function() {
          Bacon.embed();
          return expect(this.input.css('cursor')).toEqual('wait');
        });
        describe('requests', function() {
          beforeEach(function() {
            Bacon.embed();
            return this.embedTag = $("script[src^='" + callbackUrl + "']");
          });
          it('by injecting a script tag', function() {
            return expect(this.embedTag.length).toBe(1);
          });
          return it('as much bacon as will fit', function() {
            return expect(Url(this.embedTag.attr('src')).params).toInclude({
              size: '20'
            });
          });
        });
        describe('when the server responds', function() {
          beforeEach(function() {
            var callbackName;
            Bacon.embed();
            this.embedTag = $("script[src^='" + callbackUrl + "']");
            callbackName = Url(this.embedTag.attr('src')).params.callback;
            this.bacon = 'Rump shoulder shankle';
            return eval("" + callbackName + "('" + this.bacon + "')");
          });
          it('fills the text field with bacon', function() {
            return expect(this.input.val()).toBe(this.bacon);
          });
          it('removes the script tag', function() {
            return expect(this.embedTag[0].parentNode).toBe(null);
          });
          return it('restores the cursor style', function() {
            return expect(this.input.css('cursor')).toEqual('auto');
          });
        });
        describe('and I embacon the same field again', function() {
          beforeEach(function() {
            return Bacon.embed();
          });
          return it('does not fetch bacon', function() {
            return expect($("script[src^='" + callbackUrl + "']").length).toBe(0);
          });
        });
        return describe('and I embacon another text field', function() {
          return it('embacons the new field', function() {});
        });
      });
    });
  });
}).call(this);
