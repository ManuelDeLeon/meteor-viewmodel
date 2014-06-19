class @ViewModel
  constructor: (obj) ->
    dependencies = {}
    values = {}
    addProperty = (p, value, that) ->
      that[p] = (e) ->
        dep = dependencies[p] || dependencies[p] = new Deps.Dependency()
        if arguments.length
          if values[p] isnt e
            dep.changed()
            values[p] = e
        else
          dep.depend()
        values[p]
      values[p] = value

    addProperties = (propObj, that) ->
      for p of propObj
        value = propObj[p]
        if value instanceof Function
          that[p] = value
        else if typeof value is 'object'
          addProperty p, value.value, that
        else
          addProperty p, value, that

    addProperties obj, @

    addHelper = (name, tempName, that) ->
      Template[tempName][name] = -> that[name]()

    @addHelpers = (tempName) =>
      for p of obj
        addHelper p, tempName, @

    getElement = (value) ->
      if value
        if typeof value is 'object' and value.target
          elem = $(value.target)
      elem

    addEvent = (name, value, that) ->
      elem = getElement(value)
      return if not (elem and elem.length)
      if elem.prop('type') in ['text', 'textarea', 'password']
        if typeof value is 'object' and value.returnKey
          returnKey = value.returnKey
        event = value.valueUpdate || "keypress cut paste input"
        Deps.autorun -> elem.val that[name]()
        elem.bind event, (ev) ->
          newValue = elem.val()
          if returnKey and 13 in [ev.which, ev.keyCode]
            returnKey(ev)
          that[name] newValue if that[name]() isnt newValue

    @addEvents = =>
      for p of obj
        value = obj[p]
        if not (value instanceof Function)
          addEvent p, value, @

      that = @
      $('[data-bind]').each ->
        elem = $(this)
        if not elem.data('bound')
          elem.data('bound', true)
          bind = elem.data('bind').split(':')
          if bind[0] is 'value'
            prop = $.trim(bind[1])
            Deps.autorun -> elem.val that[prop]()
            elem.bind "keypress cut paste input", ->
              newValue = elem.val()
              that[prop] newValue if that[prop]() isnt newValue

    @extend = (newObj) => addProperties newObj, @