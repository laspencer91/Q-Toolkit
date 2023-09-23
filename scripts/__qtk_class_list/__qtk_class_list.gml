function QList() constructor
{
	__list = ds_list_create();
	
	Add = function(_item) 
	{
		ds_list_add(__list, _item);
		
		return self;
	}
	
	Delete = function(_item) 
	{
		ds_list_delete_value(__list, _item);	
	}
	
	FindValue = function(_item) 
	{
		var _item_index = ds_list_find_index(__list, _item);
		
		if (!_item_index) return undefined;
		
		return ds_list_find_value(__list, _item_index);
	}
	
	/// @desc Clears the list.
	Clear = function()
	{
		ds_list_clear(__list);	
	}
	
	/// @desc Iterates each element of the list.
	/// @param {Function} _function Function to run on each item. The item and index of the item are passed to it.
	ForEach = function(_function)
	{
		for (var _i = 0; _i < ds_list_size(__list); _i++)
		{
			var _item = __list[| _i];
			_function(_item, _i);
		}
	}
	
	/// @desc Filters the current list IN PLACE. A new list is not returned.
	/// @param {Function} _predicate Function to run. Elements that pass the predicate are retained.
	Filter = function(_predicate)
	{
		for (var _i = 0; _i < ds_list_size(__list); _i++)
		{
			var _item = __list[| _i];
			if (!_predicate(_item, _i)) 
			{
				Delete(_item);
				--_i;
			}
		}
	}
	
	Size = function() 
	{
		return ds_list_size(__list);
	}
	
	static toString = function() 
	{
		var _build_string = array_create(Size());
		
		ForEach(function(_item, _index) {
			_build_string[_index] = _item;
		});
		
		return string_join(", ", _build_string);
	}
	
	GetList = function()
	{
		return __list;	
	}
}