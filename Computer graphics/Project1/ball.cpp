#include <iostream>
#include <windows.h>
// GLEW
#define GLEW_STATIC
#include <GL/glew.h>

// GLFW
#include <GLFW/glfw3.h>
#include <GLFW/Shader.h>
// glm
#include <glm\glm.hpp>
#include <glm\gtc\matrix_transform.hpp>
#include <glm\gtc\type_ptr.hpp>

#include <math.h>
#include <vector>

using namespace std;

// Function prototypes
void key_callback(GLFWwindow* window, int key, int scancode, int action, int mode);
void Prepare(vector<GLfloat> &vertices, vector<GLuint> &faces, GLuint &VBO, GLuint &VAO, GLuint &EBO);
vector <GLfloat> add_trian(vector<GLfloat> &vertices, vector<GLuint> &faces, int loop_i);
void grow_trian(vector<GLfloat> &vertices, int loop_i, vector<GLfloat> curR_mark, GLuint len_v);
// Window dimensions
const GLuint WIDTH = 800, HEIGHT = 600;



// The MAIN function, from here we start the application and run the game loop
int main()
{
	// Init GLFW
	glfwInit();
	// Set all the required options for GLFW
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
	glfwWindowHint(GLFW_RESIZABLE, GL_FALSE);

	// Create a GLFWwindow object that we can use for GLFW's functions
	GLFWwindow* window = glfwCreateWindow(WIDTH, HEIGHT, "LearnOpenGL", nullptr, nullptr);
	glfwMakeContextCurrent(window);

	// Set the required callback functions
	glfwSetKeyCallback(window, key_callback);

	// Set this to true so GLEW knows to use a modern approach to retrieving function pointers and extensions
	glewExperimental = GL_TRUE;
	// Initialize GLEW to setup the OpenGL Function pointers
	glewInit();

	// Define the viewport dimensions
	glViewport(0, 0, WIDTH, HEIGHT);

	glEnable(GL_DEPTH_TEST);

	Shader ourShader("vertex.basic", "fragment.basic");



	// Set up vertex data (and buffer(s)) and attribute pointers

	GLfloat InitV[] = {
		0.5773503f, 0.5773503f, 0.5773503f, //1.0f, 0.0f, 0.0f, //0
		0.5773503f, 0.5773503f, -0.5773503f,  //1.0f, 0.0f, 0.0f,//1
		0.5773503f,  -0.5773503f, 0.5773503f,  //1.0f, 0.0f, 0.0f,//2
		0.5773503f,  -0.5773503f, -0.5773503f,  //1.0f, 0.0f, 0.0f,//3
		-0.5773503f,  0.5773503f, 0.5773503f,  //1.0f, 0.0f, 0.0f,//4
		-0.5773503f, 0.5773503f, -0.5773503f,  //1.0f, 0.0f,0.0f,//5
		-0.5773503f, -0.5773503f, 0.5773503f,  //1.0f, 0.0f,0.0f,//6
		-0.5773503f, -0.5773503f, -0.5773503f//,  1.0f, 0.0f,0.0f//7
	};
	GLuint InitF[] = {  // Note that we start from 0!
		0, 1, 3,
		0, 2, 3,
		4, 7, 5,
		4, 7, 6,
		0, 5, 1,
		0, 5, 4,
		2, 7, 3,
		2, 7, 6,
		0, 6, 2,
		0, 6, 4,
		1, 7, 3,
		1, 7, 5
	};

	vector <GLfloat> vertices(InitV, InitV + sizeof(InitV) / sizeof(InitV[0]));
	vector <GLuint> faces(InitF, InitF + sizeof(InitF) / sizeof(InitF[0]));


	GLuint VBO, VAO, EBO;

	glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	// Game loop
	int i_loop = 0;
	//DWORD start = timeGetTime();
	int temp = 1;
	GLuint len_v = vertices.size();
	vector <GLfloat> curR_mark(faces.size());
	while (!glfwWindowShouldClose(window))
	{
		// Check if any events have been activiated (key pressed, mouse moved etc.) and call corresponding response functions
		glfwPollEvents();

		// Render
		// Clear the colorbuffer
		glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		glEnable(GL_DEPTH_TEST);


		// Be sure to activate the shader

		ourShader.Use();


		// Create transformations
		glm::mat4 model(1.0);
		glm::mat4 view(1.0);
		glm::mat4 projection(1.0);
		model = glm::rotate(model, (GLfloat)glfwGetTime() * 3.0f, glm::vec3(0.5f, 1.0f, 0.0f));
		view = glm::translate(view, glm::vec3(0.0f, 0.0f, -3.0f));
		// Note: currently we set the projection matrix each frame, but since the projection matrix rarely changes it's often best practice to set it outside the main loop only once.
		projection = glm::perspective(45.0f, (GLfloat)WIDTH / (GLfloat)HEIGHT, 0.1f, 100.0f);
		// Get their uniform location
		GLint modelLoc = glGetUniformLocation(ourShader.Program, "model");
		GLint viewLoc = glGetUniformLocation(ourShader.Program, "view");
		GLint projLoc = glGetUniformLocation(ourShader.Program, "projection");
		// Pass them to the shaders
		glUniformMatrix4fv(modelLoc, 1, GL_FALSE, glm::value_ptr(model));
		glUniformMatrix4fv(viewLoc, 1, GL_FALSE, glm::value_ptr(view));
		glUniformMatrix4fv(projLoc, 1, GL_FALSE, glm::value_ptr(projection));

		//DWORD now = timeGetTime();

		if (temp < 6) {
			if (i_loop == temp * 100) {
				temp++;
				len_v = vertices.size();
				curR_mark.clear();

				vector <GLfloat> temp = add_trian(vertices, faces, 99);
				curR_mark.insert(curR_mark.end(), temp.begin(), temp.end());
			}
			else if (temp > 1) {
				grow_trian(vertices, 99, curR_mark, len_v);
			}
			i_loop++;
		}


		Prepare(vertices, faces, VBO, VAO, EBO);
		// Draw container
		glBindVertexArray(VAO);
		glDrawElements(GL_TRIANGLES, faces.size(), GL_UNSIGNED_INT, 0);
		glBindVertexArray(0);


		// Swap the screen buffers
		glfwSwapBuffers(window);
		Sleep(60);
	}
	// Properly de-allocate all resources once they've outlived their purpose
	glDeleteVertexArrays(1, &VAO);
	glDeleteBuffers(1, &VBO);
	// Terminate GLFW, clearing any resources allocated by GLFW.
	glfwTerminate();
	return 0;
}

// Is called whenever a key is pressed/released via GLFW
void key_callback(GLFWwindow* window, int key, int scancode, int action, int mode)
{
	if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
		glfwSetWindowShouldClose(window, GL_TRUE);
}

void Prepare(vector<GLfloat> &vertices, vector<GLuint> &faces, GLuint &VBO, GLuint &VAO, GLuint &EBO)
{
	glGenBuffers(1, &EBO);
	glGenVertexArrays(1, &VAO);
	glGenBuffers(1, &VBO);
	// Bind the Vertex Array Object first, then bind and set vertex buffer(s) and attribute pointer(s).
	glBindVertexArray(VAO);

	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat)*vertices.size(), &vertices[0], GL_STATIC_DRAW);

	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLfloat) * faces.size(), &faces[0], GL_STATIC_DRAW);

	// Position attribute
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), (GLvoid*)0);
	glEnableVertexAttribArray(0);
	// Color attribute
	glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), (GLvoid*)(3 * sizeof(GLfloat)));
	glEnableVertexAttribArray(1);

	glBindVertexArray(0); // Unbind VAO
}

vector <GLfloat> add_trian(vector<GLfloat> &vertices, vector<GLuint> &faces, int loop_i) {

	GLint face_num = faces.size() / 3;
	GLint vertex_num = vertices.size() / 3;
	vector <GLfloat> new_vertices(9 * face_num);
	vector <GLuint> new_faces(9 * face_num);
	vector <GLfloat> curR_mark(3 * face_num);
	double loop = loop_i;
	GLfloat alpha = 0.5;
	for (int i = 1; i <= face_num; i++)
	{
		GLfloat curRadius = 0;
		// first
		for (int k = 0; k < 3; k++)
		{
			new_vertices[9 * (i - 1) + k] = alpha* vertices[3 * faces[3 * (i - 1)] + k] + (1 - alpha) *vertices[3 * faces[3 * (i - 1) + 1] + k];
			curRadius = curRadius + new_vertices[9 * (i - 1) + k] * new_vertices[9 * (i - 1) + k];
		}
		curRadius = sqrt(curRadius);
		curR_mark[3 * (i - 1)] = pow(1 / curRadius, 1.0 / loop);


		// second
		curRadius = 0;
		for (int k = 0; k < 3; k++)
		{
			new_vertices[9 * (i - 1) + 3 + k] = alpha* vertices[3 * faces[3 * (i - 1) + 1] + k] + (1 - alpha)*vertices[3 * faces[3 * (i - 1) + 2] + k];
			curRadius = curRadius + new_vertices[9 * (i - 1) + 3 + k] * new_vertices[9 * (i - 1) + 3 + k];
		}
		curRadius = sqrt(curRadius);
		curR_mark[3 * (i - 1) + 1] = pow(1 / curRadius, 1.0 / loop);


		// third
		curRadius = 0;
		for (int k = 0; k < 3; k++)
		{
			new_vertices[9 * (i - 1) + 6 + k] = alpha* vertices[3 * faces[3 * (i - 1) + 2] + k] + (1 - alpha)*vertices[3 * faces[3 * (i - 1)] + k];
			curRadius = curRadius + new_vertices[9 * (i - 1) + 6 + k] * new_vertices[9 * (i - 1) + 6 + k];
		}
		curRadius = sqrt(curRadius);
		curR_mark[3 * (i - 1) + 2] = pow(1 / curRadius, 1.0 / loop);


		new_faces[9 * (i - 1)] = faces[3 * (i - 1)];
		new_faces[9 * (i - 1) + 1] = vertex_num + 3 * (i - 1);
		new_faces[9 * (i - 1) + 2] = vertex_num + 3 * (i - 1) + 2;

		new_faces[9 * (i - 1) + 3] = faces[3 * (i - 1) + 1];
		new_faces[9 * (i - 1) + 4] = vertex_num + 3 * (i - 1) + 1;
		new_faces[9 * (i - 1) + 5] = vertex_num + 3 * (i - 1);

		new_faces[9 * (i - 1) + 6] = faces[3 * (i - 1) + 2];
		new_faces[9 * (i - 1) + 7] = vertex_num + 3 * (i - 1) + 2;
		new_faces[9 * (i - 1) + 8] = vertex_num + 3 * (i - 1) + 1;

		faces[3 * (i - 1)] = vertex_num + 3 * (i - 1);
		faces[3 * (i - 1) + 1] = vertex_num + 3 * (i - 1) + 1;
		faces[3 * (i - 1) + 2] = vertex_num + 3 * (i - 1) + 2;

	}
	vertices.insert(vertices.end(), new_vertices.begin(), new_vertices.end());
	//faces.clear();
	faces.insert(faces.end(), new_faces.begin(), new_faces.end());
	return curR_mark;
}


void grow_trian(vector<GLfloat> &vertices, int loop_i, vector<GLfloat> curR_mark, GLuint len_v) {
	GLint ver_num = (vertices.size() - len_v) / 3;
	for (int i = 0; i < ver_num; i++) {
		for (int k = 0; k < 3; k++) {
			vertices[len_v + 3 * i + k] *= curR_mark[i];
		}
	}

}