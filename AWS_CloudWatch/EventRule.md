# CloudWatch Event Rule

- 일정 기간마다 실행되는 Batch Job을 구성하기 위해 CloudWatch의 Event Rule을 사용하였다.
- Batch Interval이 짧다면, 끊김없이 Running되는 서버에서 Batch가 실행되도록 해야 되지만,  
  1시간 Interval인데 새로운 서버를 띄울 필요가 있을까라는 의문과 함께 Lambda 기반의 Event Rule을 구축하였다.
- CRON Expression으로 간단하게 Batch Job을 구성할 수 있고, Lambda외에도 Kinesis, SQS 등의 Resource와의 연동이 편하다는 장점이 있다.
- 단, Cron Job까지도 AWS Resource에 의존성을 갖게된다는 단점은 있으나 인프라 구성과 설계에서 비용 효율화는 놓칠 수 없는 부분이니 적당하게 Cloud Resource를 사용하는 것은 필요하다고 판단된다.
