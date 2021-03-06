
var mongoose = require('mongoose');

var UserSchema = new mongoose.Schema({
	name: String
});

var CommentSchema = new mongoose.Schema({
	content: String,
	created_date: Date,
	user_id: mongoose.Schema.ObjectId
	//以下でも可
	//user_id: {}
});

CommentSchema.virtual('user')
	.get(function() {
		return this['userobj'];
	})
	.set(function(u) {
		this.set('user_id', u._id)
	});

var BookSchema = new mongoose.Schema({
	title: String,
	isbn: String,
	comments: [CommentSchema]
});

BookSchema.method({
	//Comment の関連 User を復元する処理
	restoreUser: function(userList) {
		var ulist = {};

		userList.forEach(function(u) {
			ulist[u._id] = u;
		});

		this.get('comments').forEach(function(c) {
			c['userobj'] = ulist[c.user_id];
		});
	}
});

mongoose.model('User', UserSchema);
mongoose.model('Book', BookSchema);

exports.createConnection = function(url) {
	return mongoose.createConnection(url);
};
