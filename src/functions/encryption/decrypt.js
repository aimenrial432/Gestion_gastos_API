//Funcion que desencripta la tarjeta cuando los datos estan encriptados
const crypto = require('crypto');

function decrypt(encrypted_message, encrypt_method, key, iv) {
    var decryptor = crypto.createDecipheriv (encrypt_method, key, iv);
    return decryptor.update (encrypted_message, 'base64', 'utf8') + decryptor.final('utf8');

}

module.exports.decrypt = decrypt;