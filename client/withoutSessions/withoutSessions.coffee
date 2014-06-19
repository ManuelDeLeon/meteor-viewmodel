vm = new ViewModel
  firstName: ''
  lastName: ''
  fullName: -> @firstName() + ' ' + @lastName()
  enterDisabled: -> !@firstName() or !@lastName()


Template.withoutSessions.helpers
  first: -> vm.firstName()
  last: -> vm.lastName()
  fullName: -> vm.fullName()
  enterDisabled: -> vm.enterDisabled()

Template.withoutSessions.events
  'input #inputFirst': -> vm.firstName $('#inputFirst').val()
  'input #inputLast': -> vm.lastName $('#inputLast').val()