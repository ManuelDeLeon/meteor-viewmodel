Session.setDefault 'firstName', ''
Session.setDefault 'lastName', ''
Session.setDefault 'fullName', ''

Template.withSessions.created = ->
  Deps.autorun ->
    first = Session.get 'firstName'
    last = Session.get 'lastName'
    Session.set 'fullName', "#{first} #{last}"

Template.withSessions.helpers
  first: -> Session.get 'firstName'
  last: -> Session.get 'lastName'
  fullName: -> Session.get 'fullName'
  enterDisabled: ->
    first = Session.get 'firstName'
    last = Session.get 'lastName'
    not (first and last)

Template.withSessions.events
  'input #inputFirst': -> Session.set 'firstName', $('#inputFirst').val()
  'input #inputLast': -> Session.set 'lastName', $('#inputLast').val()