Session.setDefault 'sessionData', {}

class Replay
  constructor: (data) ->
    data = Session.get('sessionData') if not data
    @aboutYou = ko.observable(data.aboutYou).extend({ rateLimit: 1000 })
    @color1 = ko.observable (data.color1 || '#fff')
    @color2 = ko.observable (data.color2 || '#fff')
    @color3 = ko.observable (data.color3 || '#fff')
    @load = (thisData) =>
      @aboutYou thisData.aboutYou
      @color1 thisData.color1
      @color2 thisData.color2
      @color3 thisData.color3
    @randomColor = -> '#'+Math.floor(Math.random()*16777215).toString(16)
    @randomizeColor1 = => @color1(@randomColor())
    @randomizeColor2 = => @color2(@randomColor())
    @randomizeColor3 = => @color3(@randomColor())
    @events = ko.computed =>
      thisData = ko.toJS(@)
      Session.set 'sessionData', thisData
      thisData

class Control
  constructor: (vm) ->
    that = this
    actions = ko.observableArray()
    canPlay = true
    @recording = ko.observable true
    updateVM = (index) ->
      action = actions()[index]
      if action and canPlay
        vm.load action
        $('#h-slider').slider('value', index)
        Meteor.setTimeout (-> updateVM(index + 1)), 500

    @play = ->
      canPlay = true
      @recording false
      updateVM(0)
    @reset = -> actions.clear()
    @stop = =>
      canPlay = false
      @recording false

    @record = -> @recording true

    vm.events.subscribe (data) =>
      if @recording()
        actions.push data

    $('#h-slider').slider
      min: 0
      max: 0
    actions.subscribe ->
      $('#h-slider').slider 'destroy'
      $('#h-slider').slider
        min: 0
        max: actions().length - 1
        slide: (event, ui) ->
          that.stop()
          action = actions()[ui.value]
          vm.load action if action
    @prev = ->
      $('#h-slider').slider('value', $('#h-slider').slider('value') - 1)
      that.stop()
      action = actions()[$('#h-slider').slider('value') - 1]
      vm.load action if action

    @next = ->
      $('#h-slider').slider('value', $('#h-slider').slider('value') + 1)
      that.stop()
      action = actions()[$('#h-slider').slider('value') + 1]
      vm.load action if action

Template.replay.rendered = ->
  vm = new Replay()
  ko.applyBindings vm, document.getElementById('replay')

  ko.applyBindings new Control(vm), document.getElementById('collapseOne')
