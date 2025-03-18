#!/usr/bin/env node
// A simple hacky way to get all runtime dependencies installed in the image
// https://github.com/Ylianst/MeshCentral/issues/5779

const { execSync } = require('node:child_process');
const fs = require('fs');
const path = require('path');
const re = new RegExp(/modules\.push\('([a-z0-9_\-@\/]+@[\d.]+)'\)/, "g");

// get meshcentral version from package.json
const packageJson = JSON.parse(fs.readFileSync(path.join(__dirname, './package.json'), 'utf8'));
const meshcentralVersion = packageJson.dependencies['meshcentral'];

const file = fs.readFileSync(path.join(__dirname, './node_modules/.pnpm/meshcentral@' + meshcentralVersion + '/node_modules/meshcentral/meshcentral.js'), 'utf8');
const matches = file.matchAll(re);
for (const match of matches) {
    console.log("> Adding " + match[1]);
    execSync(`pnpm add ${match[1]}`, { stdio: 'inherit' });
}
