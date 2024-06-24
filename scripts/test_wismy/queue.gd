class_name Queue
extends Node

var queue = []

func push(item):
	queue.push_back(item)

func pop():
	return queue.pop_front()
