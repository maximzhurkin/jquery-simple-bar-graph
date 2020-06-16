(($) ->
	methods =

		init: (elements, options) ->
			if $(elements[0]).find('.simple-bar-graph').length
				$.each $(elements[0]).find('.simple-bar-graph__bar'), (index) ->
					$(this).css
						'height': '0%'
					return
				setTimeout (->
					methods.render(elements, options)
					return
				), $(elements[0]).find('.simple-bar-graph__bar').length * options.delayAnimation + 100
			else
				methods.render(elements, options)
			return
		
		render: (elements, options) ->
			maxValue = methods.getMaxValue(options.data)
			columnsWidth = (100 / options.data.length).toFixed(3).slice(0, -1) + '%'
			rowsHeight = (100 / options.rowsCount).toFixed(3).slice(0, -1) + '%'
			rowStepValue = (maxValue / options.rowsCount);
			# prepare html rows and columns
			rows = methods.getRows(options.rowsCount, rowsHeight, rowStepValue, maxValue)
			columns = methods.getColumns(options.rowCaptionsWidth, options.height, options.data, maxValue, columnsWidth, options.barsColor, options.popups, options.delayAnimation)
			# create main container
			graph = $('<div/>', class: 'simple-bar-graph')
			# append rows and columns
			graph.append(rows)
			graph.append(columns)
			# render graph
			$(elements[0]).html(graph)
			# execute bars height enter animation
			$.each $(elements[0]).find('.simple-bar-graph__bar'), ->
				$(this).height $(this).data('height')
				return
			return

		getMaxValue: (data) ->
			maxValue = 0
			$.each data, (index, element) ->
				if element.value > maxValue then maxValue = element.value
				return
			return maxValue
		
		bindBar: (bar) ->
			bar.hover (->
				$(@).addClass 'simple-bar-graph__bar--active'
				return
			), ->
				$(@).removeClass 'simple-bar-graph__bar--active'
				return
			return

		getRows: (rowsCount, rowsHeight, rowStepValue, maxValue) ->
			rowsIterator = rowsCount - 1
			# create top row
			rows = $('<div/>',
				class: 'simple-bar-graph__rows').append(
					$('<div/>',
						class: 'simple-bar-graph__row'
						css: 'height': rowsHeight).append(
							$('<div/>',
								class: 'simple-bar-graph__value'
								text: maxValue)))
			# loop rows
			while rowsIterator > 0
				currentValue = parseInt(rowStepValue * rowsIterator * 10) / 10
				rows.append(
					$('<div/>',
						class: 'simple-bar-graph__row'
						css: 'height': rowsHeight).append(
							$('<div/>',
								class: 'simple-bar-graph__value'
								text: currentValue.toString())))
				rowsIterator--
			# add null row
			rows.append(
				$('<div/>',
					class: 'simple-bar-graph__null').append(
						$('<div/>',
							class: 'simple-bar-graph__value'
							text: 0)))
			return rows
		
		getColumns: (rowCaptionsWidth, height, data, maxValue, columnsWidth, barsColor, popups, delayAnimation) ->
			columnsIterator = 0
			# create columns container
			columns = $('<div/>',
				class: 'simple-bar-graph__columns'
				css:
					'padding-right': rowCaptionsWidth
					'height': height)
			# loop data columns
			while columnsIterator < data.length
				# equal columns height
				columnHeight = (data[columnsIterator].value / maxValue * 100).toFixed(3).slice(0, -1) + '%'
				# create column
				column = $('<div/>',
					class: 'simple-bar-graph__column'
					css: 'width': columnsWidth)
				# create bar
				bar = $('<div/>',
					class: 'simple-bar-graph__bar'
					css:
						'height': '0%'
						'-webkit-transition-delay': "#{columnsIterator * delayAnimation}ms"
						'-moz-transition-delay': "#{columnsIterator * delayAnimation}ms"
						'transition-delay': "#{columnsIterator * delayAnimation}ms"
					'data-height': columnHeight)
				if barsColor then bar.css('background-color', barsColor)
				# append popup to column
				if popups
					bar.append(
						$('<div/>',
							class: 'simple-bar-graph__popup'
							text: data[columnsIterator].value))
				# add hover event for bar
				methods.bindBar(bar)
				# append bar to column
				column.append(bar)
				# append caption to column
				column.append(
					$('<div/>',
						class: 'simple-bar-graph__caption'
						text: data[columnsIterator].key))
				# apend column in columns container
				columns.append(column)
				columnsIterator++
			return columns

	jQuery.fn.simpleBarGraph = (options) ->
		options = $.extend({
			data: []
			rowsCount: 5
			height: '300px'
			rowCaptionsWidth: '16px'
			barsColor: ''
			popups: true
			delayAnimation: 20
		}, options)
		methods.init @, options
		return

	return
) jQuery
