'use strict'

const express = require('express')
const app = express()
const msg = require('gulp-messenger')
const chalk = require('chalk')
const Twig = require('twig')
const _ = require('lodash')
const xsltproc = require('node-xsltproc')
const libxslt = require('libxslt')
const libxmljs = require('libxmljs')
const fs = require("fs")

var twig = Twig.twig;

// This section is optional and used to configure twig.
app.set('twig options', {
    strict_variables: false
});

app.set('port', (process.env.PORT || 3000))
app.use(express.static(__dirname + '/public'))  // static directory


app.get('/', (req, res) => {
    res.redirect('xml');
});


app.use('/xml:search?', function (req, res) {


    var searchParam = req.query.search;
    console.log('search :', searchParam);


    var stylesheetStr = fs.readFileSync('public/xml/countries-4.xsl', 'utf8');
    var stylesheetObj = libxmljs.parseXml(stylesheetStr);
    var stylesheet = libxslt.parse(stylesheetObj);
    var docStr = fs.readFileSync('public/xml/countries-4.xml', 'utf8');
    var docObj = libxmljs.parseXml(docStr);

    libxslt.parse(stylesheetStr, (err, stylesheet) => {
        var params = {
            search: searchParam
        };

        // 'params' parameter is optional
        stylesheet.apply(docStr, params, (err, result) => {
            // err contains any error from parsing the document or applying the stylesheet
            // result is a string containing the result of the transformation
            res.send(result)
            //console.log(result)
        });
    });

    //res.sendFile(__dirname + '/public/xml/countries-4.xml');
});

// lets startup this puppy
app.listen(app.get('port'), () => {
    msg.log('\n')
    console.log(chalk.cyan('Server Started ' + new Date()));
    msg.log('\n')
    const serverInfo = chalk.yellow(`http://localhost:${app.get('port')}`);
    msg.success('=', _.pad(`Application Running On: ${serverInfo}`, 80), '=')
})
