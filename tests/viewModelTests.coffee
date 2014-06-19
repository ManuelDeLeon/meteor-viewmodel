if Meteor.isClient
  describe "KnockoutVM", ->
    it "fullName concats first and last", ->
      vm = new KnockoutVM()
      vm.firstName 'A'
      vm.lastName 'B'
      chai.assert.equal vm.fullName(), 'A B'

    it "hasFirstAndLast true with first and last", ->
      vm = new KnockoutVM()
      vm.firstName 'A'
      vm.lastName 'B'
      chai.assert.equal vm.hasFirstAndLast(), true

    it "hasFirstAndLast false with first", ->
      vm = new KnockoutVM()
      vm.firstName 'A'
      chai.assert.equal vm.hasFirstAndLast(), false

    it "hasFirstAndLast false with last", ->
      vm = new KnockoutVM()
      vm.lastName 'B'
      chai.assert.equal vm.hasFirstAndLast(), false