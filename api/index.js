const fs = require('fs');
const path = require('path');

module.exports = (req, res) => {
  const url = process.env.SUPABASE_URL || '';
  const key = process.env.SUPABASE_KEY || '';
  let html = fs.readFileSync(path.join(__dirname, '../index.html'), 'utf8');
  html = html.replace('<head>', `<head><meta name="supa-url" content="${url}"><meta name="supa-key" content="${key}">`);
  res.setHeader('Content-Type', 'text/html; charset=utf-8');
  res.setHeader('Cache-Control', 'no-store');
  res.end(html);
};
