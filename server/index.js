//import { Configuration, OpenAIApi } from "openai";

const http = require('http');
const express = require('express');
const axios = require('axios');
var cors = require('cors')
const openAI = require('openai');


const configuration = new openAI.Configuration({
  apiKey: process.env.OPENAI_API_KEY
});
const openAIAPI = new openAI.OpenAIApi(configuration);

const app = express();
var bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(cors({
  origin: '*'
}));

// Starting both http & https servers
const httpServer = http.createServer(app);

httpServer.listen(7342, () => {
  console.log('HTTP Server running on port 7342');
});

/****************** Test Route *********************/
app.get('/test', proof);

function proof(request, response) {
    response.send("Hi I am working. What do you need.");
}

app.post('/plan', generatePlan);
async function generatePlan(request, response) {
    var data = request.body;
    var prompt = data.prompt;
    console.log(prompt);
    
    //make call to openAI's API to get the json and return this
    try {
        const completion = await openAIAPI.createChatCompletion({
          model: "gpt-3.5-turbo",
          messages: [{"role": "user", "content": prompt}],
          temperature: 0.6,
        });
        response.setHeader('Access-Control-Allow-Origin', '*');
        response.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
        response.statusCode = 200
        console.log(completion.data.choices[0].message);
        response.send(completion.data.choices[0].message.content);
      } catch(error) {
        // Consider adjusting the error handling logic for your use case
        if (error.response) {
            console.error(error.response.status, error.response.data);
            response.setHeader('Access-Control-Allow-Origin', '*');
            // // Request methods you wish to allow
            response.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
            response.statusCode = 500;
            response.send("error");
        } else {
            console.error(`Error with OpenAI API request: ${error.message}`);
            response.setHeader('Access-Control-Allow-Origin', '*');
            response.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
            response.statusCode = 500;
            response.send("An error occurred during your request");
        }
      }
}

// app.get('/plan', generatePlan);
// async function generatePlan(request, response) {
//     var prompt = request.params.prompt;
//     var data = request.body;
    
//     //make call to openAI's API to get the json and return this
//     try {
//         const completion = await openAIAPI.createChatCompletion({
//           model: "gpt-3.5-turbo",
//           //prompt: prompt,
//           messages: [{"role": "user", "content": prompt}],
//           temperature: 0.6,
//         });
//         response.setHeader('Access-Control-Allow-Origin', '*');
//         response.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
//         response.statusCode = 200
//         console.log(completion.data.choices[0].message);
//         response.send(completion.data.choices[0].message.content);
//       } catch(error) {
//         // Consider adjusting the error handling logic for your use case
//         if (error.response) {
//             console.error(error.response.status, error.response.data);
//             response.setHeader('Access-Control-Allow-Origin', '*');
//             // // Request methods you wish to allow
//             response.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
//             response.statusCode = 500;
//             response.send("error");
//         } else {
//             console.error(`Error with OpenAI API request: ${error.message}`);
//             response.setHeader('Access-Control-Allow-Origin', '*');
//             response.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
//             response.statusCode = 500;
//             response.send("An error occurred during your request");
//         }
//       }
// }

