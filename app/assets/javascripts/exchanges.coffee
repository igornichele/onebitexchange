$(document).ready ->
  $('#source_currency').change ->
    $('#exchange_form').submit()

  $('#target_currency').change ->
    $('#exchange_form').submit()

  timeout = null
  $('#amount').keyup ->
    clearTimeout(timeout)
    timeout = setTimeout((->
      $('#exchange_form').submit()
      return
    ), 500)
 
  $('form').submit ->
    if $('form').attr('action') == '/convert'
      $.ajax '/convert',
          type: 'GET'
          dataType: 'json'
          data: {
                  source_currency: $("#source_currency").val(),
                  target_currency: $("#target_currency").val(),
                  amount: $("#amount").val()
                }
          error: (jqXHR, textStatus, errorThrown) ->
            alert textStatus
          success: (data, text, jqXHR) ->
            $('#result').val(data.value)
        return false;

  $('#inverter').click ->
    source = $("#source_currency").val()
    $("#source_currency").val($("#target_currency").val())
    $("#target_currency").val(source)
    $('#exchange_form').submit() if $('#amount').val()
    return false;