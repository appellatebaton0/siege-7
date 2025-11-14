class_name ShopEntry extends PanelContainer

@export var data:ShopData
@export var upgrade:Upgrade

@onready var PAY := $MarginContainer/VBoxContainer/PAY
@onready var GET := $MarginContainer/VBoxContainer/GET

var symbols:Dictionary[String, String] = {
	"money": "$0, ", 
	"hydrogen": "0H, ",
	"helium": "0He, ",
	"oxygen": "0O, ",
	"carbon": "0C, ",
	"neon": "0Ne, ",
}

func _ready() -> void:
	for child in get_children():
		if child is Upgrade:
			upgrade = child
			break
	
	var pay_text = "PAY "
	for element in data.cost.keys():
		if data.cost[element] > 0:
			pay_text += symbols[element].replace("0", str(data.cost[element]))
	PAY.text = pay_text.left(len(pay_text) - 2)
	
	GET.text = "GET " + upgrade.get_desc

func _on_buy_pressed() -> void:
	
	for element in data.cost.keys():
		if Global.get(element) < data.cost[element]:
			return # IF POOR, FAIL.
	
	upgrade.upgrade()
	
	for element in data.cost.keys():
		Global.change_contents(element, -data.cost[element])
