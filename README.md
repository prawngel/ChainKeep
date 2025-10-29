# 🧾 ChainKeep

> A simple and beginner-friendly Solidity smart contract that allows users to create, manage, and store **public or private notes** directly on the blockchain.

---

## 📘 Project Description

**ChainKeep** is a decentralized notes manager built using **Solidity**.  
It lets users create, view, and manage notes that are stored permanently on-chain.  
Each note can be marked as **public** (viewable by anyone) or **private** (accessible only to its creator).  

It’s a great learning project for anyone starting with Solidity, smart contracts, or decentralized applications (dApps).

---

## 🚀 What It Does

- Allows users to **create notes** stored on the blockchain.
- Supports **public** and **private** visibility modes.
- Enables users to **update**, **delete**, and **change visibility** of their notes.
- Keeps a **timestamp** of when each note was created and updated.
- Provides a way to **list all note IDs** owned by a user.

All data is stored on-chain, so it’s tamper-proof and transparent — perfect for learning how decentralized data storage works.

---

## 🧩 Features

✅ Create new notes with a public/private flag  
✅ View note details (owner, content, visibility, timestamps)  
✅ Edit or update note content  
✅ Change visibility (make public/private anytime)  
✅ Soft delete notes (mark as deleted but still traceable)  
✅ Retrieve all your note IDs  
✅ Beginner-friendly and fully commented Solidity code  

---

## 🌐 Deployed Smart Contract

**Network:** Celo Sepolia Testnet  
**Contract Name:** `ChainKeep`  
**Contract Address:** [`0x9f9c7917ed52844Faa350407105E2300c857591b`](https://celo-sepolia.blockscout.com/address/0x9f9c7917ed52844Faa350407105E2300c857591b)

You can explore it directly on **BlockScout** to see contract details, transactions, and source code.
<img width="1280" height="720" alt="image" src="https://github.com/user-attachments/assets/8d32752b-0060-4ae0-b015-db0b0d201cb2" />

---

## 💡 How It Works

1. **Deploy** the contract using Remix or Hardhat.  
2. **Interact** with it using MetaMask on the **Celo Sepolia Testnet**.  
3. Use functions like:
   - `createNote(string content, bool isPublic)`
   - `getNote(uint256 id)`
   - `updateNote(uint256 id, string newContent)`
   - `setVisibility(uint256 id, bool makePublic)`
   - `deleteNote(uint256 id)`
   - `listNoteIds(address user)`

---

## ⚙️ Tech Stack

- **Solidity** `^0.8.20`
- **Celo Sepolia Testnet**
- **Remix IDE / Hardhat**
- **BlockScout** for contract verification

---

## 🔐 Privacy Tip

All data on the blockchain is public — even private note contents are technically visible.  
If you need **real privacy**, you can:
- Encrypt your notes **client-side** before saving them, and  
- Store only the encrypted text (ciphertext) on-chain.  

This way, only the creator with the correct decryption key can read the actual content.

---

## 📜 License

This project is licensed under the **MIT License** — feel free to use, modify, and learn from it!

---

## ✨ Author

**ChainKeep Smart Contract**  
Built with ❤️ for learners and Web3 builders.

---
