describe 'PictureToUnjumbleController', () ->
  controller = null

  $scope = {}
  $rootScope = null
  $q = null
  deferred = null

  submissionHandler = 
    handleSubmissionFor: jasmine.createSpy('submissionHandler::handleSubmissionFor')
  optionsGenerator = 
    generateOptionsFor: () ->
      deferred = $q.defer()
      deferred.promise
  routeParams = 
    categoryId: 37

  beforeEach module('app')

  beforeEach inject ($controller, _$q_, _$rootScope_) ->
    $rootScope = _$rootScope_
    $q = _$q_
    controller = $controller 'pictureToUnjumbleController', 
      $scope: $scope
      $routeParams: routeParams
      submissionHandlerService: submissionHandler
      optionsGeneratorService: optionsGenerator
    return

  describe 'when the options are returned', () ->
    beforeEach () ->
      spyOn(controller, 'jumbleAnswer').and.callThrough()
      deferred.resolve 
        answer: 
          label: 'Nganyja?'
      $rootScope.$apply()

    it 'should jumble the answer', () ->
      expect(controller.jumbleAnswer).toHaveBeenCalled()