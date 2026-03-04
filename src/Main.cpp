#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <iostream>


int main() {
    // 1. Initialize GLFW
    if (!glfwInit()) return -1;

    // 2. Create a windowed mode window and its OpenGL context
    GLFWwindow* window = glfwCreateWindow(800, 600, "Hello OpenGL World", NULL, NULL);
    if (!window) {
        glfwTerminate();
        return -1;
    }

    // 3. Make the window's context current
    glfwMakeContextCurrent(window);

    // 4. Load OpenGL function pointers via GLAD
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        return -1;
    }

    // 5. Loop until the user closes the window
    while (!glfwWindowShouldClose(window)) {
        // --- RENDER HERE ---
        // Set the 'clear' color (R, G, B, Alpha)
        glClearColor(0.1f, 0.4f, 0.1f, 1.0f); // Dark Green
        
        // Clear the screen with that color
        glClear(GL_COLOR_BUFFER_BIT);

        // Swap front and back buffers
        glfwSwapBuffers(window);

        // Poll for and process events
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}
