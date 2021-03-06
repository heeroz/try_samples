@Grapes([
	@Grab("org.jclouds:jclouds-all:1.1.1"),
	@Grab("org.jclouds:jclouds-allblobstore:1.1.1")
])
import org.jclouds.blobstore.BlobStoreContextFactory

def ctx = new BlobStoreContextFactory().createContext("transient", "identity", "credential")

def containerName = "sample1"

def store = ctx.blobStore
store.createContainerInLocation(null, containerName)

//Blob の作成
def blob = store.newBlob("test")
//内容の設定
blob.setPayload("abc")

//Blob の put
store.putBlob(containerName, blob)

//Blob の get
def b = store.getBlob(containerName, "test")

println "${b} - ${b.payload} - ${b.payload.rawContent}"

print "payload = "
b.payload.writeTo(System.out)

ctx.close()
