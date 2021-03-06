@HeaderUI = flight.component ->
  @attributes
    switch: 'a.switch-market'
    market: 'p > span.market'
    vol: 'span.vol'
    amount: 'span.amount'
    high: 'span.high'
    low: 'span.low'
    sound: 'input[name="sound-checkbox"]'

  @refresh = (event, ticker) ->
    @select('vol').text("#{ticker.volume} #{gon.market.base_unit.toUpperCase()}")
    @select('high').text(ticker.high)
    @select('low').text(ticker.low)

  @after 'initialize', ->
    @select('market').text("#{gon.market.base_unit.toUpperCase()}/#{gon.market.quote_unit.toUpperCase()}")

    @on @select('switch'), 'click', ->
      @trigger 'switch-market'

    @on document, 'market::ticker', @refresh

    if Cookies.get('sound') == undefined
      Cookies.set('sound', true, 30)
    state = Cookies.get('sound') == 'true' ? true : false

    @select('sound').bootstrapSwitch
      state: state
      onSwitchChange: (event, state) ->
        Cookies.set('sound', state, 30)

    $('header .dropdown-menu').click (e) ->
      e.stopPropagation()
