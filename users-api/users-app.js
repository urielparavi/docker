const express = require('express');
const bodyParser = require('body-parser');
const axios = require('axios');

const app = express();

app.use(bodyParser.json());

app.post('/signup', async (req, res) => {
  // It's just a dummy service - we don't really care for the email
  const email = req.body.email;
  const password = req.body.password;

  if (
    !password ||
    password.trim().length === 0 ||
    !email ||
    email.trim().length === 0
  ) {
    return res
      .status(422)
      .json({ message: 'An email and password needs to be specified!' });
  }

  try {
    const hashedPW = await axios.get(`http://${process.env.AUTH_ADDRESS}/hashed-password/` + password);
    // const hashedPW = 'dummy text'
    // since it's a dummy service, we don't really care for the hashed-pw either
    console.log(hashedPW, email);
    res.status(201).json({ message: 'User created!' });
  } catch (err) {
    console.log(err);
    return res
      .status(500)
      .json({ message: 'Creating the user failed - please try again later.' });
  }
});

app.post('/login', async (req, res) => {
  // It's just a dummy service - we don't really care for the email
  const email = req.body.email;
  const password = req.body.password;

  if (
    !password ||
    password.trim().length === 0 ||
    !email ||
    email.trim().length === 0
  ) {
    return res
      .status(422)
      .json({ message: 'An email and password needs to be specified!' });
  }

  // normally, we'd find a user by email and grab his/ her ID and hashed password
  const hashedPassword = password + '_hash';
  // Our first approach
  // const response = await axios.get(
  //   `http://${process.env.AUTH_ADDRESS}/token/` + hashedPassword + '/' + password
  // );
  const response = await axios.get(
    // In Kubernetes, auto-generated environment variables like AUTH_SERVICE_SERVICE_HOST are created automatically
    // by the system for each service. These variables provide the internal IP addresses and ports of services within the 
    // cluster. This simplifies service communication by automatically setting up environment variables for DNS resolution
    // and direct communication between services.
    // The name of the envirnment variable come from our service's name, so if for example our service name
    // was 'exmaple-service', the auto-generated environment variable will be 'EXAMPLE_EXAMPLE_SERVICE_HOST',
    // and if the service's name was 'example', the auto-generated environment variable will be 'EXAMPLE_SERVICE_HOST'
    `http://${process.env.AUTH_SERVICE_SERVICE_HOST}/token/` + hashedPassword + '/' + password
  );
  // const response = { status: 200, data: { token: 'abc ' }};
  if (response.status === 200) {
    return res.status(200).json({ token: response.data.token });
  }
  return res.status(response.status).json({ message: 'Logging in failed!' });
});

app.listen(8080);
