
import groovy.xml.StreamingMarkupBuilder

def xml = "<root><a><value>123</value></a><b><value>test</value></b></root>"

def doc = new XmlSlurper().parseText(xml)

println doc.getClass()

//c 要素の追加
doc.appendNode {
	c("abc")
}

//属性の追加
doc.b.@id = "no1"

//要素の置換
doc.b.value.replaceNode { n ->
	item(type: "data") {
		value("test data")
	}
}

//a 要素の削除
doc.a.replaceNode {}

def builder = new StreamingMarkupBuilder()

//文字列でXML取得
def xmlString = builder.bind{
	mkp.yield doc
}

println xmlString
