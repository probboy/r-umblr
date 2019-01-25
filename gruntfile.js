//The "wrapper" function
module.exports = function(grunt) {
  
	//Project and task configuration
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),

		/**
		* Grunt Sass
		* Compile Sass to CSS using node-sass
		* https://www.npmjs.com/package/grunt-sass
		*/
		sass: {

			options: {
				sourceMap: false
			},
			dist: {
				files: {
					'public/css/styles.css' : 'public/scss/styles.scss'
				}
			}
		},

		/**
		* Grunt Contrib Watch
		* Monitor files and excute tasks
		* https://www.npmjs.com/package/grunt-contrib-watch
		*/
		watch: {
			sass: {

				files: [
					'public/scss/**/*.scss'
				],
				tasks : [
					'sass'
				]
			},
			// scripts: {

			// 	files: [
			// 		'public/js/*.js'
			// 	],
			// 	tasks : [
			// 		'uglify'
			// 	]
			// }
		},

		/**
		* Grunt Contrib Uglify
		* Minify JavaScript files
		* https://www.npmjs.com/package/grunt-contrib-uglify
		*/
		// uglify: {
		// 	my_target:{
		// 		files: {
		// 			'js/scripts.js' : ['node_modules/jquery/dist/jquery.js', 'public/js/scripts.js']
		// 		}
		// 	}
		// }


	});

	//Loading Grunt plugins and tasks
	require('load-grunt-tasks')(grunt);

	//Custom tasks
	grunt.registerTask('default', ['sass','watch']);

};
