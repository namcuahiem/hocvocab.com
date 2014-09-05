json.post_id @post.id
json.exact @exact_translations do |translation|
	json.start translation.start
	json.end translation.end
	json.words translation.words
	json.meaning translation.meaning
	json.author translation.user.username
end

json.related @related_translations do |translation|
	json.start translation.start
	json.end translation.end
	json.words translation.words
	json.meaning translation.meaning
	json.author translation.user.username
end
