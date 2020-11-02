const express = require('express');
const router = express.Router();

const beatController = require('../controllers/beat-controller');

router.get('/', beatController.getBeat);
router.post('/', beatController.postBeat);
router.get('/:beatId', beatController.getBeatDetail);
router.put('/:beatId', beatController.putBeat);
router.delete('/:beatId', beatController.deleteBeat);

module.exports = router;