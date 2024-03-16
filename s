<div>
<div>&nbsp;</div>
</div>
<div>
<div dir="auto">
<p>In the world of web development, creating robust and scalable applications often involves building APIs. In this article, we will discuss how to build APIs with Express and MongoDB.<strong><br></strong></p>
<h4>Intended audience</h4>
<p>This article is written for developers who are familiar with basics of javaScript, http methods and MongoDB, and looking to grasp the fundamentals of API development.</p>
<p>&nbsp;</p>
<h2><strong>Prerequisites</strong></h2>
<p>Before we start, make sure you have the following installed:</p>
<ul>
<li>
<p>Node.js 20.6.0</p>
</li>
</ul>
<div><hr></div>
<div>
<div>
<div>&nbsp;</div>
<div data-component-name="SubscribeWidget">&nbsp;</div>
</div>
</div>
<h2><strong>I. Setting Up Your Project</strong></h2>
<div id="&sect;i-setting-up-your-project"></div>
<p>Create a new directory for your project and navigate into it by opening the terminal and type:</p>
</div>
<div dir="auto">
<pre class="language-markdown"><code>mkdir my-app
cd my-app
code .</code></pre>
<p>Initialize your project:</p>
<pre class="language-markdown"><code>npm init -y</code></pre>
<p>Now install the dependencies that we need in this project:</p>
<pre class="language-markdown"><code>npm install express mongoose nodemon</code></pre>
<br>
<ul>
<li>
<p><code>express:</code>&nbsp;is a framework for Node.js. It simplifies the process of building robust web applications by providing a set of features for routing, handling HTTP requests and responses, and managing middleware.</p>
</li>
<li>
<p><code>mongoose:</code>&nbsp;is an ODM (Object Data Modeling) library for MongoDB and Node.js. It provides a way to interact with MongoDB using a schema-based approach (we will talk about it more later).</p>
</li>
<li>
<p><code>nodemon</code><strong>:</strong>&nbsp;A utility that helps in development by automatically restarting the Node.js application when file changes are detected.</p>
</li>
</ul>
<p>To use ES6 modules instead of Commen.js. update your&nbsp;<code>package.json</code>&nbsp;file to include the&nbsp;<code>"type"</code>&nbsp;field set to&nbsp;<code>"module"</code>:</p>
<pre class="language-javascript"><code>{
  "type": "module"
  // ... (other fields remain unchanged)
}
</code></pre>
<br>
<p>Node.js now supports the built-in .env file, but you need to add this to your package.json file to be able to use it:</p>
<pre class="language-javascript"><code>{
  // ... (other fields remain unchanged)

  "scripts": {
    "start": "node --env-file=config.env app.js",
    "server": "nodemon --env-file=.env --quiet app.js"
  }
}
</code></pre>
<br>
<div><hr></div>
<h2><strong>II: Creating the server</strong>&nbsp;</h2>
<p>Create a file named&nbsp;<code>app.js</code>&nbsp;or any name you like and set up your server:</p>
<pre class="language-javascript"><code>// app.js

import express from 'express';
const app = express();
const port = process.env.PORT || 3000

app.use(express.json());

app.get('/', (req, res) =&gt; {
  res.send('Hello, this is your Express API!');
});


app.listen(port, () =&gt; {
  console.log(`Server is running on port ${port}`);
});</code></pre>
<h2><strong>Let's break down each part:</strong></h2>
<ol>
<li>
<p>Importing Express:</p>
<pre class="language-javascript"><code>import express from 'express';</code></pre>
<p>This line imports the Express.js framework</p>
</li>
<li>
<p>Creating Express Application:</p>
<pre class="language-javascript"><code>const app = express();</code></pre>
<p>This creates an instance of the Express application.</p>
</li>
<li>
<p>Defining the Port:</p>
<pre class="language-javascript"><code>const port = process.env.PORT || 3000;</code></pre>
<p>This line sets the port number for the server. It checks if there's a <code>PORT</code>&nbsp;environment variable set (commonly used in hosting environments like Heroku), and if not, it defaults to port 3000.</p>
</li>
<li>
<p>Middleware:</p>
<pre class="language-javascript"><code>app.use(express.json());</code></pre>
<br>
<p>This line uses the built-in middleware&nbsp;<code>express.json()</code>&nbsp;to parse incoming JSON requests. This middleware is responsible for parsing the request body when the content type is JSON, making it accessible through&nbsp;<code>req.body</code>.</p>
</li>
<li>
<p>Handling a Route:</p>
<pre class="language-javascript"><code>app.get('/', (req, res) =&gt; { res.send('Hello, this is your Express API!'); });</code></pre>
<p>This code defines a route for handling HTTP&nbsp;<code>GET</code>&nbsp;requests to the root path '/'. When a&nbsp;<code>GET</code>&nbsp;request is made to the root path, it sends the response 'Hello, this is your Express API!'.</p>
</li>
<li>
<p>Listening for Requests:</p>
<pre class="language-javascript"><code>app.listen(port, () =&gt; { console.log(`Server is running on port ${port}`); });</code></pre>
<p>Finally, this line starts the Express server and listens on the specified port. The callback function (optional) logs a message to the console once the server is successfully running.</p>
</li>
</ol>
<p>let&rsquo;s run our application:</p>
<pre class="language-markdown"><code>npm run server</code></pre>
<br>
<p>Now visit&nbsp;<strong><a href="http://localhost:3000/" rel="nofollow ugc noopener">http://localhost:3000</a></strong>&nbsp;in your browser, and you should see the "Hello, this is your Express API!" message.</p>
<div><hr></div>
<h2><strong>III: Connect to Database</strong></h2>
<p>Now navigate to&nbsp;<a href="https://www.mongodb.com/atlas/database" rel="nofollow ugc noopener">MongoDB Atlas</a>&nbsp;to create a database and get the URI string. If you don't know how to create a database in&nbsp;<strong>MongoDB Atlas</strong>, read this&nbsp;<a href="https://open.substack.com/pub/abedalrhman/p/setting-up-a-database-on-mongodb?r=2ri4wh&amp;utm_campaign=post&amp;utm_medium=web&amp;showWelcome=true" rel="nofollow ugc noopener">article</a>&nbsp;to get it. I have explained all the steps in detail.</p>
<p>after getting the URI string, create a new directory and name it&nbsp;<code>config</code>, inside&nbsp;<code>config</code>&nbsp;directory create a file and name it&nbsp;<code>db.js</code></p>
<p>now copy this code to&nbsp;<code>db.js</code>&nbsp;file</p>
<pre class="language-javascript"><code>// db.js
import mongoose from "mongoose";
export async function connectDB() {
  try {
    const conn = await mongoose.connect(process.env.MONGO_URI);
    console.log(`MongoDB connected to ${conn.connection.host}`);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}
</code></pre>
<p><strong>Let&rsquo;s explore what this code does:</strong></p>
<ol>
<li>
<p>Importing Mongoose:</p>
<pre class="language-javascript"><code>import mongoose from 'mongoose';</code></pre>
<p>This line imports the Mongoose library for MongoDB interactions.</p>
</li>
<li>
<p>Exporting<strong>&nbsp;</strong><code>connectDB</code>&nbsp;Function:</p>
<pre class="language-javascript"><code>export async function connectDB() {}</code></pre>
<p>This code creates an asynchronous function named <code>connectDB</code>. This function will be used to establish a connection to the MongoDB database, we exported it for use in other parts of the application.</p>
</li>
<li>
<p>Connecting to MongoDB:</p>
<pre class="language-javascript"><code>const conn = await mongoose.connect(process.env.MONGO_URI);</code></pre>
<p>The function uses <code>mongoose.connect</code>&nbsp;to connect to the MongoDB database. It takes the MongoDB connection URI from the environment variable&nbsp;<code>MONGO_URI</code>. The&nbsp;<code>await</code>&nbsp;keyword is used to wait for the connection to be established.</p>
</li>
<li>
<p>Logging Successful Connection:</p>
<pre class="language-javascript"><code>console.log(`MongoDB connected to ${conn.connection.host}`);</code></pre>
<p>If the connection is successful, a log message is printed indicating that the MongoDB connection is established, along with the host information.</p>
</li>
<li>
<p>Handling Connection Errors:</p>
<pre class="language-javascript"><code> catch (error) { console.error(error); process.exit(1); }</code></pre>
<p>If an error occurs during the connection attempt, it is caught in the <code>catch</code>&nbsp;block. The error is logged, and the process is exited with an exit code of 1, indicating an error.</p>
<p>&nbsp;</p>
</li>
</ol>
<p>now in&nbsp;<code>app.js</code>&nbsp;file import&nbsp;<code>connectDB</code>&nbsp;function from&nbsp;<code>config/db.js</code>&nbsp;file and run it:</p>
<pre class="language-javascript"><code>// app.js 
import { connectDB } from './config/db.js' ;
connectDB()</code></pre>
<p>now let&rsquo;s create models for our database, create a new directory, and name it&nbsp;<code>models</code>, inside&nbsp;<code>models</code>&nbsp;directory create a file and name it&nbsp;<code>courseModel.js</code>.</p>
<p>now copy this code to&nbsp;<code>courseModel.js</code>. file</p>
<pre class="language-javascript"><code>import mongoose from "mongoose";
const courseSchema = mongoose.Schema(
  { name: String, tags: Array },
  { timestamps: true }
);
export const Course = mongoose.model("Course", courseSchema);</code></pre>
<p>in this snapshot, we define the Mongoose Schema named <code>courseSchema</code>. The schema specifies the structure of documents within the 'Courses' collection in MongoDB. It defines two fields:</p>
</div>
<div dir="auto">
<ul>
<li>
<p><code>name</code>: A field of type String.</p>
</li>
<li>
<p><code>tags</code>: A field of type Array.</p>
</li>
</ul>
<p>The second parameter&nbsp;<code>{ timestamps: true }</code>&nbsp;adds automatic timestamp fields&nbsp;<code>createdAt</code>&nbsp;and&nbsp;<code>updatedAt</code>&nbsp;to the documents.</p>
<p>The last line creates a Mongoose model named 'Course' based on the defined schema (<code>courseSchema</code>). Like the previous example, this model is a constructor function that allows you to create, read, update, and delete documents in the MongoDB 'Course' collection. The model is then exported for use in other parts of the application.</p>
<p>The Mongoose model 'Course' can be used to interact with MongoDB and perform CRUD operations on 'Course' documents.</p>
<div><hr></div>
<h2><strong>IV. Handling Routes</strong></h2>
<p>Now create some basic routes for your API.</p>
<h3>GET Request</h3>
<p>Update your <code>app.js</code>&nbsp;file and add a&nbsp;<code>GET</code>&nbsp;route</p>
<pre class="language-javascript"><code>app.get("/api/v1/courses", async (req, res) =&gt; {
  const courses = await Course.find();
  res.json(courses);
});
</code></pre>
<p><strong>Let's break down each part:</strong></p>
<ol>
<li>
<p><strong>Route Definition:</strong></p>
<pre class="language-javascript"><code>app.get('/api/v1/courses', async (req, res) =&gt; {}</code></pre>
<p>This code defines a route for handling HTTP <code>GET</code>&nbsp;requests at the path&nbsp;<code>'/api/v1/courses'</code>. The callback function, which takes&nbsp;<code>req</code>&nbsp;(request) and&nbsp;<code>res</code>&nbsp;(response) parameters, will be executed when a&nbsp;<code>GET</code>&nbsp;request is made to this endpoint.</p>
<p><br>The&nbsp;<code>async</code>&nbsp;keyword is used because all Mongoose methods are asynchronous operations (it returns a promise). Using&nbsp;<code>await</code>&nbsp;ensures that the code waits for the database query to complete before moving on to the next line.</p>
</li>
<li>
<p><strong>Fetching Courses from MongoDB:</strong></p>
<pre class="language-javascript"><code>const courses = await Course.find();</code></pre>
<p>Inside the route handler, it is used <code>await Course.find()</code>&nbsp;to retrieve all documents from the 'Course' collection in MongoDB. The&nbsp;<code>await</code>&nbsp;keyword is used to wait for the asynchronous operation to complete.</p>
</li>
<li>
<p><strong>Sending JSON Response:</strong></p>
<pre class="language-javascript"><code>res.json(courses);</code></pre>
<p>Once the courses are retrieved from the database, the route handler responds with a <strong>JSON</strong>&nbsp;representation of the courses using&nbsp;<code>res.json(courses)</code>. This sends the retrieved courses as a JSON response to the client making the&nbsp;<code>GET</code>&nbsp;request.</p>
</li>
</ol>
<p><strong>To make it less boring 😅, we now use Postman as ClientSide to display the results of requests from the database</strong></p>
<p>to show the result of this router we need tho&nbsp;<a href="https://www.postman.com/" rel="nofollow ugc noopener">Postman</a>, Postman is an application that&nbsp;<strong>allows us to test APIs utilizing a graphical user interface</strong>.</p>
<p>There is more than one option for using Postman, we will choose the easiest one by adding an&nbsp;<a href="https://marketplace.visualstudio.com/items?itemName=Postman.postman-for-vscode" rel="nofollow ugc noopener">extension</a>&nbsp;to VS code editor, go to this&nbsp;<a href="https://marketplace.visualstudio.com/items?itemName=Postman.postman-for-vscode" rel="nofollow ugc noopener">link</a>&nbsp;and install it on your device, after installing it, this icon will appear in the sidebar:</p>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0395ae0d-8ca0-43ce-89ad-c4ba832618c1_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0395ae0d-8ca0-43ce-89ad-c4ba832618c1_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0395ae0d-8ca0-43ce-89ad-c4ba832618c1_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0395ae0d-8ca0-43ce-89ad-c4ba832618c1_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0395ae0d-8ca0-43ce-89ad-c4ba832618c1_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0395ae0d-8ca0-43ce-89ad-c4ba832618c1_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/0395ae0d-8ca0-43ce-89ad-c4ba832618c1_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:174012,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
<ol>
<li>
<p>click on the Postman icon</p>
</li>
<li>
<p>then click on&nbsp;<strong>New HTTP Request:</strong></p>
</li>
</ol>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fff52435c-f45c-4230-9875-1d24a3aaea49_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fff52435c-f45c-4230-9875-1d24a3aaea49_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fff52435c-f45c-4230-9875-1d24a3aaea49_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fff52435c-f45c-4230-9875-1d24a3aaea49_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fff52435c-f45c-4230-9875-1d24a3aaea49_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fff52435c-f45c-4230-9875-1d24a3aaea49_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/ff52435c-f45c-4230-9875-1d24a3aaea49_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:195790,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
<ol start="3">
<li>
<p>select the HTTP method (here we need to choose&nbsp;<code>GET</code>)</p>
</li>
<li>
<p>type the path to the endpoint (here&nbsp;<a href="http://localhost:3000/api/v1/courses" rel="nofollow ugc noopener">http://localhost:3000/api/v1/courses</a>)</p>
</li>
<li>
<p>click on Send to make a request</p>
</li>
</ol>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F401cbbd0-b1fa-4853-a4da-6b315af47c40_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F401cbbd0-b1fa-4853-a4da-6b315af47c40_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F401cbbd0-b1fa-4853-a4da-6b315af47c40_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F401cbbd0-b1fa-4853-a4da-6b315af47c40_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F401cbbd0-b1fa-4853-a4da-6b315af47c40_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F401cbbd0-b1fa-4853-a4da-6b315af47c40_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/401cbbd0-b1fa-4853-a4da-6b315af47c40_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:200333,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
<p>the result is an empty array because we haven&rsquo;t added anything until now:</p>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fb8603ed2-d1f9-4cf8-9102-b7702050376c_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fb8603ed2-d1f9-4cf8-9102-b7702050376c_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fb8603ed2-d1f9-4cf8-9102-b7702050376c_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fb8603ed2-d1f9-4cf8-9102-b7702050376c_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fb8603ed2-d1f9-4cf8-9102-b7702050376c_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fb8603ed2-d1f9-4cf8-9102-b7702050376c_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/b8603ed2-d1f9-4cf8-9102-b7702050376c_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:201084,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
<h3>POST Request</h3>
<div id="&sect;post-request">
<div>&nbsp;</div>
</div>
<p>Previously we added the <code>GET</code>&nbsp;route, so now let&rsquo;s add the&nbsp;<code>POST</code>&nbsp;route, back to&nbsp;<code>app.js</code>&nbsp;file and add a&nbsp;<code>POST</code> route</p>
</div>
<div dir="auto">
<pre class="language-javascript"><code>app.post("/api/v1/courses", async (req, res) =&gt; {
  const course = await Course.create({
    name: req.body.name,
    tags: req.body.tags
  });
  res.json(course);
});
</code></pre>
</div>
<div dir="auto"><strong>Let's break down each part:</strong>
<ol>
<li>
<p><strong>Route Definition:</strong></p>
<pre class="language-javascript"><code>app.post('/api/v1/courses', async (req, res) =&gt; {}</code></pre>
<p>This code defines a route for handling HTTP<strong>&nbsp;</strong><code>POST</code>&nbsp;requests at the path&nbsp;<code>'/api/v1/courses'</code>. The callback function, which takes&nbsp;<code>req</code>&nbsp;(request) and&nbsp;<code>res</code>&nbsp;(response) parameters, will be executed when a&nbsp;<code>POST</code>&nbsp;request is made to this endpoint.</p>
</li>
<li>
<p><strong>Creating a Course in MongoDB:</strong></p>
<pre class="language-javascript"><code>const course = await Course.create({
  name: req.body.name,
  tags: req.body.tags
});
</code></pre>
<br>
<p>Inside the route handler, it uses&nbsp;<code>await Course.create(...)</code>&nbsp;to create a new document in the 'Course' collection in MongoDB. The data for the new course is taken from the request body (<code>req.body</code>). The&nbsp;<code>await</code>&nbsp;keyword ensures that the operation is asynchronous, and it waits for the creation to be completed before proceeding.</p>
</li>
<li>
<p><strong>Sending JSON Response:</strong></p>
<pre class="language-javascript"><code>res.json(course);</code></pre>
<p>Once the course is created, the route handler responds with a JSON representation of the created course using <code>res.json(course)</code>. This sends the created course as a JSON response to the client making the&nbsp;<code>POST</code>&nbsp;request.</p>
</li>
</ol>
<p>now let&rsquo;s make a POST request on Postman:</p>
<ol>
<li>
<p>select a&nbsp;<code>POST</code>&nbsp;request</p>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4c4edac1-8b05-4eb9-88c3-db349de19409_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4c4edac1-8b05-4eb9-88c3-db349de19409_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4c4edac1-8b05-4eb9-88c3-db349de19409_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4c4edac1-8b05-4eb9-88c3-db349de19409_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4c4edac1-8b05-4eb9-88c3-db349de19409_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4c4edac1-8b05-4eb9-88c3-db349de19409_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/4c4edac1-8b05-4eb9-88c3-db349de19409_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:216936,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
</li>
<li>
<p>move to&nbsp;<code>Body</code>&nbsp;tab</p>
</li>
<li>
<p>select&nbsp;<code>raw</code></p>
</li>
<li>
<p>choose a&nbsp;<code>JSON</code></p>
</li>
<li>
<p>then type data for the course you need to create</p>
</li>
<li>
<p>click on&nbsp;<code>Send</code></p>
</li>
</ol>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4fd43c7b-1eea-4ad6-ad83-3e58be9aca49_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4fd43c7b-1eea-4ad6-ad83-3e58be9aca49_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4fd43c7b-1eea-4ad6-ad83-3e58be9aca49_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4fd43c7b-1eea-4ad6-ad83-3e58be9aca49_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4fd43c7b-1eea-4ad6-ad83-3e58be9aca49_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4fd43c7b-1eea-4ad6-ad83-3e58be9aca49_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/4fd43c7b-1eea-4ad6-ad83-3e58be9aca49_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:222718,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
<p>Now let's make a&nbsp;<code>GET</code>&nbsp;request to make sure our data is stored, and YES we&rsquo;ve succeeded 🥳</p>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F30111d4e-b96f-4b5c-9105-d77e10b310d1_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F30111d4e-b96f-4b5c-9105-d77e10b310d1_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F30111d4e-b96f-4b5c-9105-d77e10b310d1_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F30111d4e-b96f-4b5c-9105-d77e10b310d1_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F30111d4e-b96f-4b5c-9105-d77e10b310d1_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F30111d4e-b96f-4b5c-9105-d77e10b310d1_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/30111d4e-b96f-4b5c-9105-d77e10b310d1_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:242035,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
<h3>PATCH Request</h3>
<div id="&sect;patch-request">
<div>
<div>&nbsp;</div>
</div>
</div>
<p>Now imagine that we need to modify the previous course, so let&rsquo;s add the&nbsp;<code>PATCH</code>&nbsp;route, back to&nbsp;<code>app.js</code>&nbsp;file and add a&nbsp;<code>PATCH</code>&nbsp;route:</p>
<pre class="language-javascript"><code>app.patch("/api/v1/courses/:id", async (req, res) =&gt; {
  const course = await Course.findByIdAndUpdate(req.params.id, req.body, {
    new: true
  });
  res.json(course);
});
</code></pre>
<br>
<p><strong>Let's break down each part:</strong></p>
<ol>
<li>
<p><strong>Route Definition:</strong></p>
<pre class="language-javascript"><code>app.patch('/api/v1/courses/:id', async (req, res) =&gt; {}</code></pre>
<br>
<p>This code defines a route for handling HTTP&nbsp;<code>PATCH</code>&nbsp;requests at the path&nbsp;<code>'/api/v1/courses/:id'</code>. The&nbsp;<code>:id</code>&nbsp;is a route parameter, and it allows the route to handle&nbsp;<code>PATCH</code>&nbsp;requests for a specific course identified by its ID.</p>
</li>
<li>
<p><strong>Updating a Course in MongoDB:</strong></p>
<pre class="language-javascript"><code>const course = await Course.findByIdAndUpdate(req.params.id, req.body, {
  new: true
});
</code></pre>
<br>
<p>Inside the route handler, it uses&nbsp;<code>await Course.findByIdAndUpdate(...)</code>&nbsp;to find and update a document in the 'Courses' collection in MongoDB. The&nbsp;<code>req.params.id</code>&nbsp;is used to identify the course by its ID, and&nbsp;<code>req.body</code>&nbsp;contains the data to be updated. The&nbsp;<code>{ new: true }</code>&nbsp;option ensures that the updated document is returned after the update operation.</p>
</li>
<li>
<p><strong>Sending JSON Response:</strong></p>
<code>res.json(course);</code>
<p>Once the course is updated, the route handler responds with a JSON representation of the updated course using&nbsp;<code>res.json(course)</code>. This sends the updated course as a JSON response to the client making the&nbsp;<code>PATCH</code>&nbsp;request.</p>
</li>
</ol>
<p>Let's test if we've done the job correctly, make a&nbsp;<code>GET</code>&nbsp;request, and copy the course ID we need to update based on:</p>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F433c780c-e08c-4240-a562-203fb8f6ad7f_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F433c780c-e08c-4240-a562-203fb8f6ad7f_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F433c780c-e08c-4240-a562-203fb8f6ad7f_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F433c780c-e08c-4240-a562-203fb8f6ad7f_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F433c780c-e08c-4240-a562-203fb8f6ad7f_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F433c780c-e08c-4240-a562-203fb8f6ad7f_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/433c780c-e08c-4240-a562-203fb8f6ad7f_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:260306,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
<p>grab this ID and put it with a&nbsp;<code>PATCH</code>&nbsp;request, make any update you like on the&nbsp;<strong>Body</strong>&nbsp;tab (in this image we change the name and tags)</p>
<ol>
<li>
<p>select a&nbsp;<code>POST</code>&nbsp;request</p>
</li>
<li>
<p>add the ID on the URL</p>
</li>
<li>
<p>move to&nbsp;<strong>Body</strong>&nbsp;tab</p>
</li>
<li>
<p>type the data you need to update</p>
</li>
<li>
<p>click on&nbsp;<strong>Send</strong></p>
</li>
</ol>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ffd4a3b77-03ca-4579-ba19-e51dff6b1d5f_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ffd4a3b77-03ca-4579-ba19-e51dff6b1d5f_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ffd4a3b77-03ca-4579-ba19-e51dff6b1d5f_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ffd4a3b77-03ca-4579-ba19-e51dff6b1d5f_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ffd4a3b77-03ca-4579-ba19-e51dff6b1d5f_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ffd4a3b77-03ca-4579-ba19-e51dff6b1d5f_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/fd4a3b77-03ca-4579-ba19-e51dff6b1d5f_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:286965,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
<p>Now let's make a&nbsp;<code>GET</code>&nbsp;request to make sure our data is updated:</p>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5caea587-373b-467b-814b-920fa2f38b47_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5caea587-373b-467b-814b-920fa2f38b47_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5caea587-373b-467b-814b-920fa2f38b47_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5caea587-373b-467b-814b-920fa2f38b47_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5caea587-373b-467b-814b-920fa2f38b47_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5caea587-373b-467b-814b-920fa2f38b47_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/5caea587-373b-467b-814b-920fa2f38b47_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:243429,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
<h3>DELETE Request</h3>
<div id="&sect;delete-request">
<div>
<div>&nbsp;</div>
</div>
</div>
<p>finally what about if we went to delete the previous course, so now let&rsquo;s add the&nbsp;<code>DELETE</code>&nbsp;route, back to&nbsp;<code>app.js</code>&nbsp;file and add a&nbsp;<code>DELETE</code>&nbsp;route:</p>
<pre class="language-javascript"><code>// app.js
app.delete("/api/v1/courses/:id", async (req, res) =&gt; {
  const course = await Course.findByIdAndDelete(req.params.id);
  res.json(course);
});
</code></pre>
<br>
<p><strong>Let's break down each part:</strong></p>
<ol>
<li>
<p><strong>Route Definition:</strong></p>
<pre class="language-javascript"><code>app.delete('/api/v1/courses/:id', async (req, res) =&gt; {}</code></pre>
<br>
<p>This code defines a route for handling HTTP&nbsp;<strong>DELETE</strong>&nbsp;requests at the path&nbsp;<code>'/api/v1/courses/:id'</code>. The&nbsp;<code>:id</code>&nbsp;is a route parameter, allowing the route to handle DELETE requests for a specific course identified by its ID.</p>
</li>
<li>
<p><strong>Deleting a Course in MongoDB:</strong></p>
<p>&nbsp;</p>
<pre class="language-javascript"><code>const course = await Course.findByIdAndDelete(req.params.id);</code></pre>
<p>Inside the route handler, we use&nbsp;<code>await Course.findByIdAndDelete(...)</code>&nbsp;to find and delete a document in the 'Courses' collection in MongoDB. The&nbsp;<code>req.params.id</code>&nbsp;is used to identify the course by its ID.</p>
<p>&nbsp;</p>
</li>
<li>
<p><strong>Sending JSON Response:</strong></p>
<pre class="language-javascript"><code>res.json(course);</code></pre>
<p>Once the course is deleted, the route handler responds with a JSON representation of the deleted course using <code>res.json(course)</code>. This sends the deleted course as a JSON response to the client making the&nbsp;<code>DELETE</code>&nbsp;request.</p>
</li>
</ol>
<p>Again let's test if we've done the job correctly, perform a&nbsp;<code>GET</code>, and copy the course ID we need to delete based on:</p>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5a429e24-cd60-47dd-8424-be4247eebae7_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5a429e24-cd60-47dd-8424-be4247eebae7_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5a429e24-cd60-47dd-8424-be4247eebae7_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5a429e24-cd60-47dd-8424-be4247eebae7_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5a429e24-cd60-47dd-8424-be4247eebae7_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5a429e24-cd60-47dd-8424-be4247eebae7_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/5a429e24-cd60-47dd-8424-be4247eebae7_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:260306,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
<p>grab this ID and put it with a&nbsp;<code>DELETE</code>&nbsp;request</p>
<ol>
<li>
<p>select a&nbsp;<code>DELETE</code>&nbsp;request</p>
</li>
<li>
<p>add the ID on the URL</p>
</li>
<li>
<p>click on&nbsp;<strong>Send</strong></p>
</li>
</ol>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0a68d9cc-ac23-46ca-8ce3-15c70f300fe4_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0a68d9cc-ac23-46ca-8ce3-15c70f300fe4_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0a68d9cc-ac23-46ca-8ce3-15c70f300fe4_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0a68d9cc-ac23-46ca-8ce3-15c70f300fe4_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0a68d9cc-ac23-46ca-8ce3-15c70f300fe4_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0a68d9cc-ac23-46ca-8ce3-15c70f300fe4_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/0a68d9cc-ac23-46ca-8ce3-15c70f300fe4_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:258176,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
<p>Now let's make a&nbsp;<code>GET</code>&nbsp;request to make sure the course is deleted:</p>
<div><a href="https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fbed1c141-a49b-487a-b54c-37459f573603_1570x984.png" target="_blank" rel="nofollow ugc noopener" data-component-name="Image2ToDOM">
<div><img class="sizing-normal" src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fbed1c141-a49b-487a-b54c-37459f573603_1570x984.png" sizes="100vw" srcset="https://substackcdn.com/image/fetch/w_424,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fbed1c141-a49b-487a-b54c-37459f573603_1570x984.png 424w, https://substackcdn.com/image/fetch/w_848,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fbed1c141-a49b-487a-b54c-37459f573603_1570x984.png 848w, https://substackcdn.com/image/fetch/w_1272,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fbed1c141-a49b-487a-b54c-37459f573603_1570x984.png 1272w, https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fbed1c141-a49b-487a-b54c-37459f573603_1570x984.png 1456w" alt="" width="1456" height="913" loading="lazy" data-attrs="{&quot;src&quot;:&quot;https://substack-post-media.s3.amazonaws.com/public/images/bed1c141-a49b-487a-b54c-37459f573603_1570x984.png&quot;,&quot;srcNoWatermark&quot;:null,&quot;fullscreen&quot;:null,&quot;imageSize&quot;:null,&quot;height&quot;:913,&quot;width&quot;:1456,&quot;resizeWidth&quot;:null,&quot;bytes&quot;:201091,&quot;alt&quot;:null,&quot;title&quot;:null,&quot;type&quot;:&quot;image/png&quot;,&quot;href&quot;:null,&quot;belowTheFold&quot;:true,&quot;topImage&quot;:false,&quot;internalRedirect&quot;:null}">
<div>&nbsp;</div>
</div>
</a></div>
<p>in this article, we embarked on a journey to explore the fundamentals of building APIs with Express.js, a powerful and widely used framework for Node.js. Starting with the essential setup of a project using Node.js and the installation of necessary dependencies like Express, Mongoose, and Nodemon, we delved into the process of creating a basic server with routing capabilities.</p>
<p>We took a step-by-step approach, covering key aspects such as connecting to a MongoDB database using Mongoose, defining data models, and implementing CRUD (Create, Read, Update, Delete) operations through various HTTP methods (GET, POST, PATCH, DELETE).</p>
</div>
</div>
