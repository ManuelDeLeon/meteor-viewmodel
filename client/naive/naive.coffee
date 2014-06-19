updateFullName = ->
  first = $('#inputFirst').val()
  last = $('#inputLast').val()
  $('#fullName').text "Hello #{first} #{last}"

  if first and last
    $('#buttonEnter').removeAttr 'disabled'
  else
    $('#buttonEnter').attr 'disabled', 'disabled'

Template.naive.events
  'input #inputFirst, input #inputLast': -> updateFullName()