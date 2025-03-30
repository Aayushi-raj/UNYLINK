const admin = require("firebase-admin");
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const dotenv = require("dotenv");

dotenv.config();

// Initialize Firebase Admin SDK
const serviceAccount = require("./serviceAccountKey.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Firebase Authentication Middleware
const verifyToken = async (req, res, next) => {
  const token = req.headers.authorization?.split(" ")[1];
  if (!token) return res.status(401).json({ message: "Unauthorized" });

  try {
    const decodedToken = await admin.auth().verifyIdToken(token);
    
    // Restrict to SRM email IDs
    if (!decodedToken.email.endsWith("@srmist.edu.in")) {
      return res.status(403).json({ message: "Only SRM emails are allowed!" });
    }

    req.user = decodedToken;
    next();
  } catch (error) {
    return res.status(403).json({ message: "Invalid token!" });
  }
};

// Protected Route Example
app.get("/protected", verifyToken, (req, res) => {
  res.json({ message: "You have access!", user: req.user });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
// Signup API
app.post("/signup", async (req, res) => {
    const { email, password, name } = req.body;
  
    // Only allow SRM email IDs
    if (!email.endsWith("@srmist.edu.in")) {
      return res.status(400).json({ message: "Only SRM email IDs are allowed!" });
    }
  
    try {
      const user = await admin.auth().createUser({
        email,
        password,
        displayName: name,
      });
  
      res.status(201).json({ message: "User registered successfully!", user });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });
  
  // Login API
  app.post("/login", async (req, res) => {
    const { email, password } = req.body;
  
    try {
      const userRecord = await admin.auth().getUserByEmail(email);
      
      // Generate Firebase JWT token
      const token = await admin.auth().createCustomToken(userRecord.uid);
  
      res.json({ token });
    } catch (error) {
      res.status(400).json({ message: "Invalid credentials!" });
    }
  });
  