#!/usr/bin/env node
// A simple hacky way to get all runtime dependencies installed in the image
// https://github.com/Ylianst/MeshCentral/issues/5779

const { execSync } = require('node:child_process');
const fs = require('fs');
const path = require('path');
const re1 = new RegExp(/(modules|passport)\.push\(('[a-z0-9_\-@\/.,' ]+')\)/, "g");
const re2 = new RegExp(/var modules = \[('[a-z0-9_\-@\/.,' ]+')\]/, "g");

// get meshcentral version from package.json
// const packageJson = JSON.parse(fs.readFileSync(path.join(__dirname, './package.json'), 'utf8'));
// const meshcentralVersion = packageJson.dependencies['meshcentral'];

const file = fs.readFileSync(path.join(__dirname, './node_modules/meshcentral/meshcentral.js'), 'utf8');

const matches1 = file.matchAll(re1);
for (const match of matches1) {
    for (const pkg of match.slice(-1)[0].split(',')) {
        const pkgt = pkg.trim().replace(/'/g, '');
        console.log("> Adding " + pkgt);
        execSync(`pnpm add ${pkgt}`, { stdio: 'inherit' });
    }
}

const matches2 = file.matchAll(re2);
for (const match of matches2) {
    for (const pkg of match.slice(-1)[0].split(',')) {
        const pkgt = pkg.trim().replace(/'/g, '');
        console.log("> Adding " + pkgt);
        execSync(`pnpm add ${pkgt}`, { stdio: 'inherit' });
    }
}
