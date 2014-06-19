class @KnockoutVM
  constructor: ->
    @firstName = ko.observable ''
    @lastName = ko.observable ''
    @fullName = ko.computed => @firstName() + ' ' + @lastName()
    @hasFirstAndLast = ko.computed => !!@firstName() and !!@lastName()

Template.withKnockout.rendered = ->
  ko.applyBindings new KnockoutVM(), document.getElementById('form')
