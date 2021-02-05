extends Control


func init(memo, tranid, total, trandate):
	$HBoxContainer/memo.set_text(memo)
	$HBoxContainer/tranid.set_text(tranid)
	$HBoxContainer/total.set_text(total)
	$HBoxContainer/trandate.set_text(trandate)
