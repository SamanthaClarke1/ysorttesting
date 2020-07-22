extends KinematicBody2D

func _ready():
	pass

var toggle = false
func _input(event):
	if Input.is_action_just_pressed("ui_up"):
		toggle = !toggle
		VisualServer.canvas_item_set_sort_children_by_y(self.get_rid(), toggle)
		$Label2.text = "visualserver sorting "
		if toggle: $Label2.text += "enabled"
		else: $Label2.text += "disabled"
	if Input.is_action_just_pressed("ui_down"):
		for temp in ["Sprite2", "Sprite3"]:
			if get_node(temp):
				$Label.text = "unparented"
				print(get_node(temp).position)
				get_node(temp).position += self.position
				reparent(get_node(temp), get_parent())
				print(get_parent().get_node(temp).position)
			else:
				$Label.text = "parented"
				print(get_parent().get_node(temp).position)
				reparent(get_parent().get_node(temp), self)
				get_node(temp).position -= self.position
				print(get_node(temp).position)

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
