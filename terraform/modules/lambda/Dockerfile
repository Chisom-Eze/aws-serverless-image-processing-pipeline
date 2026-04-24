FROM public.ecr.aws/lambda/python:3.11

# Install zip + dependencies
RUN yum install -y zip

WORKDIR /var/task
COPY requirements.txt .
RUN pip install -r requirements.txt -t /var/task

COPY handler.py /var/task

CMD ["handler.lambda_handler"]