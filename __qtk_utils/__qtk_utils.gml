#region Utility Macros
    #macro END }
	#macro ITEM ___item
	#macro INDEX ___i
	#macro WITH_COLLECTION var ____col = 
	#macro FOREACH_LIST_ITEM var ____col_type = "LIST"; for (var INDEX = 0; INDEX < ds_list_size(____col); INDEX++) { var ITEM = ____col[| INDEX]
	#macro FOREACH_ARRAY_ITEM var ____col_type = "ARRAY"; for (var INDEX = 0; INDEX < array_length(____col); INDEX++) { var ITEM = ____col[| INDEX]
	#macro FILTER_ITEM { if (____col_type == "LIST") { ds_list_delete_value(____col, ITEM); } else if (____col_type = "ARRAY") { array_delete(____col, array_get_index(ITEM), 1); } --INDEX; continue; }
	#macro NOT_IMPLEMENTED function() { show_error("[ERROR]: Function Is Not Implemented", false); }
#endregion

function ds_list_delete_value(_list, _value_to_delete) 
{
	var _index_to_remove = ds_list_find_index(_list, _value_to_delete);
	if (_index_to_remove != -1) 
	{
		ds_list_delete(_list, _index_to_remove);
	}
}

function ds_list_filter(_list, _predicate) 
{
	var _filtered_list = ds_list_create();
	for (var _i = 0; _i < ds_list_size(_list); _i++)
	{
		var _item = _list[| _i];
		if (_predicate(_item, _i)) 
		{
			ds_list_add(_filtered_list, _item);	
		}
	}
	
	return _filtered_list;
}

function ds_list_foreach(_list, _function) 
{
	for (var _i = 0; _i < ds_list_size(_list); _i++)
	{
		var _item = _list[| _i];
		_function(_item, _i);
	}
}
