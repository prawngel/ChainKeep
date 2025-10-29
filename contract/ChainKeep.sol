// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title ChainKeep - Simple notes manager (public/private flag)
/// @author
/// @notice Beginner-friendly smart contract to store notes on-chain
contract ChainKeep {
    uint256 private nextId;

    struct Note {
        uint256 id;
        address owner;
        string content;   // <-- store ciphertext if you want privacy
        bool isPublic;    // if true anyone can read via getNote; if false only owner can call getNote
        bool deleted;     // soft delete flag
        uint256 createdAt;
        uint256 updatedAt;
    }

    // note id => Note
    mapping(uint256 => Note) private notes;

    // owner address => their note ids
    mapping(address => uint256[]) private ownerNotes;

    // Events
    event NoteCreated(uint256 indexed id, address indexed owner, bool isPublic);
    event NoteUpdated(uint256 indexed id, address indexed owner);
    event NoteDeleted(uint256 indexed id, address indexed owner);
    event NoteVisibilityChanged(uint256 indexed id, address indexed owner, bool isPublic);

    modifier onlyOwnerOf(uint256 id) {
        require(notes[id].owner == msg.sender, "not note owner");
        _;
    }

    /// @notice Create a new note
    /// @param content the note content (plaintext or ciphertext)
    /// @param isPublic whether the note should be readable by others (true) or restricted to owner (false)
    /// @return id the id of the newly created note
    function createNote(string calldata content, bool isPublic) external returns (uint256 id) {
        id = nextId++;
        Note storage n = notes[id];
        n.id = id;
        n.owner = msg.sender;
        n.content = content;
        n.isPublic = isPublic;
        n.deleted = false;
        n.createdAt = block.timestamp;
        n.updatedAt = block.timestamp;

        ownerNotes[msg.sender].push(id);

        emit NoteCreated(id, msg.sender, isPublic);
    }

    /// @notice Read a note. If the note is private, only the owner can read it.
    /// @param id the note id
    /// @return owner address of the note owner
    /// @return content note content (may be ciphertext if you encrypted client-side)
    /// @return isPublic visibility flag
    /// @return createdAt timestamp
    /// @return updatedAt timestamp
    function getNote(uint256 id)
        external
        view
        returns (
            address owner,
            string memory content,
            bool isPublic,
            uint256 createdAt,
            uint256 updatedAt
        )
    {
        Note storage n = notes[id];
        require(!n.deleted, "note deleted");
        require(n.id == id, "note not found");

        if (!n.isPublic) {
            require(n.owner == msg.sender, "private note");
        }

        return (n.owner, n.content, n.isPublic, n.createdAt, n.updatedAt);
    }

    /// @notice Update a note's content. Only owner can update.
    /// @param id the note id
    /// @param newContent new content string (can be ciphertext)
    function updateNote(uint256 id, string calldata newContent) external onlyOwnerOf(id) {
        Note storage n = notes[id];
        require(!n.deleted, "note deleted");

        n.content = newContent;
        n.updatedAt = block.timestamp;

        emit NoteUpdated(id, msg.sender);
    }

    /// @notice Change a note's visibility (public/private). Only owner.
    /// @param id the note id
    /// @param makePublic new visibility
    function setVisibility(uint256 id, bool makePublic) external onlyOwnerOf(id) {
        Note storage n = notes[id];
        require(!n.deleted, "note deleted");

        n.isPublic = makePublic;
        n.updatedAt = block.timestamp;

        emit NoteVisibilityChanged(id, msg.sender, makePublic);
    }

    /// @notice Soft-delete a note. Only owner.
    /// @param id the note id
    function deleteNote(uint256 id) external onlyOwnerOf(id) {
        Note storage n = notes[id];
        require(!n.deleted, "already deleted");

        n.deleted = true;
        n.updatedAt = block.timestamp;

        emit NoteDeleted(id, msg.sender);
    }

    /// @notice Get the list of note IDs owned by a user (includes deleted notes)
    /// @param user the address
    /// @return array of note ids
    function listNoteIds(address user) external view returns (uint256[] memory) {
        return ownerNotes[user];
    }

    /// @notice Convenience: count of notes owned by user (including deleted)
    function notesCount(address user) external view returns (uint256) {
        return ownerNotes[user].length;
    }
}
