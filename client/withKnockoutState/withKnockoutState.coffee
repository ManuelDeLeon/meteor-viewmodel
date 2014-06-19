Session.setDefault 'loginData', {}

class KnockoutVM
  constructor: ->
    data = Session.get 'loginData'
    @firstName = ko.observable data.firstName || ''
    @lastName = ko.observable data.lastName || ''
    @fullName = ko.computed => @firstName() + ' ' + @lastName()
    @hasFirstAndLast = ko.computed => @firstName() and @lastName()
    ko.computed => Session.set 'loginData', ko.toJS(@)

Template.withKnockoutState.rendered = ->
  ko.applyBindings new KnockoutVM(), document.getElementById('form')
