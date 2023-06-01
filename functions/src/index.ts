/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import * as admin from "firebase-admin"
import * as functions from "firebase-functions/v2"

//import {onRequest} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";

// https://github.com/firebase/firebase-tools/issues/1532
if (admin.apps.length === 0) {
  admin.initializeApp()
}

// export const helloWorld = functions.https.onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

export const makeJobUppercase = functions.firestore.onDocumentWritten("/users/{uid}/jobs/{jobId}", (e) => {
  const change = e.data;
  if (change === undefined) {
    return
  }
  const data = change.after.data()
  if (data === undefined) {
    // If the document has been deleted, do nothing
    return
  }
  const uppercase = data.title.toUpperCase()
  // If the title is already uppercase, do nothing
  if (uppercase == data.title) {
    logger.log(`Skipping /users/${e.params.uid}/jobs/${e.params.jobId}: ${data.title}`)
    return
  }
  // else, make uppercase and update document
  logger.log(`Uppercasing /users/${e.params.uid}/jobs/${e.params.jobId}: ${data.title} > ${uppercase}`)
  return change.after.ref.set({title: uppercase}, {merge: true})
})


export const deleteAllUserJobs = functions.https.onCall(async (context: functions.https.CallableRequest) => {
  const uid = context.auth?.uid
  if (uid === undefined) {
    // Show how strong TS type safety is
    throw new functions.https.HttpsError("unauthenticated", "You need to be authenticated to perform this action")
  }
  const firestore = admin.firestore()
  const collectionRef = firestore.collection(`/users/${uid}/jobs`)
  const collection = await collectionRef.get()
  logger.debug(`Deleting ${collection.docs.length} docs at "/users/${uid}/jobs"`)
  // transaction version
  await firestore.runTransaction(async (transaction) => {
      for (const doc of collection.docs) {
          transaction.delete(firestore.doc(`/users/${uid}/jobs/${doc.id}`))
      }
  })
  // normal version
  // for (const doc of collection.docs) {
  //     await firestore.doc(`/users/${uid}/jobs/${doc.id}`).delete()
  // }
  logger.debug(`Deleted ${collection.docs.length} docs at "/users/${uid}/jobs"`)
  return {"success": true}
})
