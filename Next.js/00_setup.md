# Next.js Project Setup하기

## System Requirement

- Node.js 10.13 or later
  - Node Version 12.14.1
  - 2021년 2월 27일 기준 Node.js LTS는 14.16.0

## Setup

```
# Automatical Setup
npx create-next-app
yarn create next-app

# Manual Setup
npm install next react react-dom
yarn add next react react-dom
```

### Package Manager를 YARN으로 선택한 이유

- 속도 : NPM3보다 패키지 설치 속도가 빠름
- JSON Format을 사용하지 않음
- 오프라인 모드가 가능함
- 패키지의 중복 설치 우려 해소
- 안전성
- 신뢰성

#### Mac OS에서 YARN 설치하기

```
brew install yarn
```

출처 : [Next.js Official Website](https://nextjs.org/docs/getting-started)
