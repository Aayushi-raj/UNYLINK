const express = require("express");
const admin = require("../firebase"); // Firebase setup file
const router = express.Router();

// 🟢 **Signup Route**
router.post("/signup", async (req, res) => {
    const { name, email, password } = req.body;

    // ✅ Restrict signup to SRM email IDs
    if (!email.endsWith("@srmist.edu.in")) {
        return res.status(400).json({ message: "Only SRM email IDs are allowed!" });
    }

    try {
        // Create user in Firebase
        const userRecord = await admin.auth().createUser({
            email,
            password,
            displayName: name,
        });

        res.status(201).json({ message: "User registered successfully!", uid: userRecord.uid });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Error creating user" });
    }
});

// 🟢 **Login Route**
router.post("/login", async (req, res) => {
    const { email, password } = req.body;

    try {
        // Firebase automatically handles authentication via Flutter frontend
        res.status(200).json({ message: "Login handled by Firebase Auth in Flutter." });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Login failed" });
    }
});

// 🟢 **Protected Route**
router.get("/protected", async (req, res) => {
    const token = req.header("Authorization");

    if (!token) return res.status(401).json({ message: "Access Denied" });

    try {
        // Verify Firebase Token
        const decodedToken = await admin.auth().verifyIdToken(token);
        res.status(200).json({ message: "You are authenticated!", user: decodedToken });
    } catch (error) {
        res.status(400).json({ message: "Invalid Token" });
    }
});

module.exports = router;
