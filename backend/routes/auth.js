const express = require("express");
const { auth, db } = require("../firebaseAdmin");

const router = express.Router();

// Middleware to verify Firebase ID Token
async function verifyToken(req, res, next) {
  const token = req.headers.authorization;
  if (!token) return res.status(401).json({ error: "Unauthorized" });

  try {
    const decodedToken = await auth.verifyIdToken(token);
    req.user = decodedToken;
    next();
  } catch (error) {
    res.status(401).json({ error: "Invalid Token" });
  }
}

// Route: Get User Data
router.get("/user", verifyToken, async (req, res) => {
  try {
    const userRef = db.collection("users").doc(req.user.uid);
    const userDoc = await userRef.get();
    if (!userDoc.exists) return res.status(404).json({ error: "User not found" });

    res.json(userDoc.data());
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// Route: Logout (Optional)
router.post("/logout", async (req, res) => {
  res.json({ message: "Logged out successfully" });
});

module.exports = router;
