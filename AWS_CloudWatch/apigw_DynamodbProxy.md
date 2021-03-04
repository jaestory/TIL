# DynamoDB Proxy하는 API Gateway 구성

- DynamoDB에 저장된 데이터를 조회하는 API Gateway를 구성할 때, API Gateway에서 직접 Data Source로 DynamoDB를 선택할 수 있다.
- Lambda를 Proxy하는 것보다 비용이 저렴하다는 부분에서 가장 큰 장점이 있고, Managed Service를 사용하는 만큼 리소스 용량 등에 대한 부하로 인한 장애에서 상대적으로 자유롭다.
- 설정하는 방법은 AWS Blog에 상세하게 나와있다.
  - https://aws.amazon.com/blogs/compute/using-amazon-api-gateway-as-a-proxy-for-dynamodb/
  - 관련한 Terraform 배포 스크립트는 주말을 활용하여 Blog에 포스팅할 예정
- 이 때, 주의할 점은 Response Mapping Template과 Request Mapping Template을 제대로 구현하는 부분
  - 확인해보니 Request Mapping Template의 경우, undefined 또는 null에 대한 처리가 잘 안되는 것으로 보인다.
  - 이 부분은 추가 확인이 필요함.
