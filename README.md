# 🏨 Mughal's Online Hotel Reservation

A modern full-stack web application that allows users to add, manage, and review hotel listings. Built using Node.js, Express, MongoDB Atlas, Cloudinary, and Passport.js with MVC design architecture. Inspired by platforms like Airbnb, with additional user profile and map features.

## 🌟 Features

- MongoDB Atlas cloud-based database
- Full MVC architecture (Models, Views, Controllers)
- Secure authentication with Passport.js
- Session management with `express-session`
- Input validation using Joi
- Multer + Cloudinary for image uploads
- Add/Edit/Delete listings (auth-protected)
- Review system with ratings and comments
- User profile management
- Map integration using Mapbox
- EJS templating for dynamic frontend rendering
- Responsive UI using Bootstrap 5

## 🛠️ Tech Stack

| Layer      | Technologies                     |
|------------|----------------------------------|
| Frontend   | HTML, CSS, EJS, Bootstrap        |
| Backend    | Node.js, Express.js              |
| Database   | MongoDB Atlas                    |
| Auth       | Passport.js, express-session     |
| Validation | Joi                              |
| Uploads    | Multer, Cloudinary               |
| Maps       | Mapbox                           |

## 🔒 Authentication & Authorization

- User Sign Up / Sign In / Logout
- Only logged-in users can:
  - Add listings
  - Edit/delete their own listings
  - Post reviews
- Route protection using custom middleware

## 📦 Installation

```bash
git clone https://github.com/your-username/mughals-hotel-reservation.git
cd mughals-hotel-reservation
npm install
add .env file cloudinary mongodbatlasurl and secret etc
now node index.js


 This project uses Jenkins for automated deployment.
   Testing webhook auto-trigger!
Testing webhook 2.0
