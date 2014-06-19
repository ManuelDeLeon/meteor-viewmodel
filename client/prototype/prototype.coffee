vm = new ViewModel
  first: ''
  last: ''
  fullName: -> @first() + ' ' + @last()
  enterDisabled: -> !@first() or !@last()


Template.prototype.created = ->
  vm.addHelpers('prototype')

Template.prototype.rendered = ->
  vm.addEvents()
