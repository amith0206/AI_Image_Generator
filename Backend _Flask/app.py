from flask import Flask, request, Response
import requests
import logging

app = Flask(__name__)

engine_id = "stable-diffusion-v1-6"
api_host = "https://api.stability.ai"
api_key = "your-api-key"

logging.basicConfig(level=logging.INFO)

@app.route('/generate-image', methods=['GET','POST'])
def generate_image():
    try:
        text = request.args.get('text', '')

        response = requests.post(
            f"{api_host}/v2beta/stable-image/generate/core",
            headers={
                "Authorization": f"Bearer {api_key}",
                "Accept": "image/*"
            },
            files={"none": ''},
            data={
                "prompt": text,
                "output_format": "webp",
            },
        )

        logging.info(f"API response status code: {response.status_code}")
        logging.info(f"API response body: {response.text}")

        if response.status_code != 200:
            logging.error(f"Non-200 response: {response.text}")
            return Response("Error: Non-200 response", status=response.status_code, content_type='text/plain')

        image_data = response.content
        logging.info(f"Image data: {image_data}")

        return Response(image_data, status=200, content_type='image/webp')

    except Exception as e:
        logging.error(f"Error: {str(e)}")
        return Response(f"Error: {str(e)}", status=500, content_type='text/plain')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='8080')
