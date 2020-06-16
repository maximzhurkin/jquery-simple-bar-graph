$(document).ready ->
	$('#graph-first').simpleBarGraph
		data: [
			{ key: 'Monday', value: 120 },
			{ key: 'Tuesday', value: 96 },
			{ key: 'Wednesday', value: 46 },
			{ key: 'Thursday', value: 58 },
			{ key: 'Friday', value: 64 },
			{ key: 'Saturday', value: 108 },
			{ key: 'Sunday', value: 91 }
		]
		rowsCount: 5
		height: '200px'
		rowCaptionsWidth: '16px'
		barsColor: '#0074D9'
		popups: false

	generateRandom = () ->
		return [
			{ key: '01', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '02', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '03', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '04', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '05', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '06', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '07', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '08', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '09', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '10', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '11', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '12', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '13', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '14', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '15', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '16', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '17', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '18', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '19', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '20', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '21', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '22', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '23', value: Math.floor((Math.random() * 100) + 20) },
			{ key: '24', value: Math.floor((Math.random() * 100) + 20) }
		]
	
	$('#graph-second').simpleBarGraph
		data: generateRandom()
		rowsCount: 8
		height: '200px'
		rowCaptionsWidth: '24px'
		barsColor: '#3D9970'
	
	$('[data-action=random]').click ->
		$('#graph-second').simpleBarGraph
			data: generateRandom()
			rowsCount: 8
			height: '200px'
			rowCaptionsWidth: '24px'
			barsColor: '#3D9970'
			delayAnimation: 15
		return
	return
