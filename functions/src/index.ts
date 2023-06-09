import * as admin from "firebase-admin"
import * as logger from "firebase-functions/logger"
import * as functions from "firebase-functions/v2"

admin.initializeApp()

export const makeJobTitleUppercase = functions.firestore.onDocumentWritten("/users/{uid}/jobs/{jobId}", (e) => {
  const change = e.data
  if (change === undefined) {
    return
  }
  const data = change.after.data()
  if (data === undefined) {
    // If the document has been deleted, do nothing
    return
  }
  const uppercase = data.title.toUpperCase()
  // If the title is already uppercase, do nothing (prevents an infinite loop)
  if (uppercase == data.title) {
    return
  }
  // else, write back to the same document
  logger.log(`Uppercasing ${change.after.ref.path}: ${data.title} => ${uppercase}`)
  return change.after.ref.set({title: uppercase}, {merge: true})
})
