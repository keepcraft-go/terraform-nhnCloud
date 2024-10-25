# Terraform으로 NHN Cloud 인프라 작성

## 프로젝트 개요
이 프로젝트는 Terraform을 사용하여 클라우드 인프라를 자동으로 배포하고 관리하는 과정을 교육으로 다룹니다. 
기본적인 내용을 바탕으로 테라폼 언어와 작성법을 익히고 마지막으로는 모듈까지 사용하고 2개의 리전에 모듈을 활용하여 간단하게 동일한 구성을 생성하는 실습을 구성합니다. 
코드로 인프라를 정의하고, 효율적이고 일관되게 클라우드 환경을 설정할 수 있는 과정을 다룹니다. 주요 클라우드 서비스 제공자를 대상으로 실습할 수 있으며, 이 예제에서는 NHN Cloud를 사용합니다.

## 사용 방법 
* 사전 요구 사항
  - 테라폼을 자신의 환경에 맞게 설치합니다.
  - https://developer.hashicorp.com/terraform/install?product_intent=terraform 

## 주요 구성 요소 
![image](https://github.com/user-attachments/assets/02b62531-b72d-4a70-9af4-a5c5d5779232)

* VPC
* Subnet
* 인스턴스
## 파일 구조
```plaintext
└── environment
    ├── dev
    │   ├── network.tf
    │   ├── provider.tf
    │   ├── terraform.tfstate
    │   ├── terraform.tfstate.backup
    │   └── variables.tf
    └── modules
        ├── compute
        │   ├── datasource.tf
        │   ├── main.tf
        │   └── variables.tf
        └── vpc
            ├── main.tf
            ├── outputs.tf
            └── variables.tf

```

## 상위 구조

- **environment**: 환경별 설정을 관리하는 디렉터리입니다. 이 예제에서는 `dev` 디렉터리가 개발 환경을 위한 설정을 포함하고 있습니다.
- **modules**: 모듈화된 리소스를 위한 디렉터리로, 재사용 가능한 구성 요소들을 포함하고 있습니다. `compute`와 `vpc`로 나뉘어 있으며, 각각 컴퓨팅 리소스와 네트워크 리소스를 정의합니다.

---

## dev 디렉터리

`dev` 디렉터리는 개발 환경에 대한 설정을 담고 있으며, 파일들의 역할은 다음과 같습니다:

- **network.tf**: 개발 환경의 네트워크 리소스를 정의하는 파일로, `vpc` 모듈을 호출해 네트워크 구성을 관리할 수 있습니다.
- **provider.tf**: 사용할 클라우드 공급자를 설정합니다.
- **terraform.tfstate 및 terraform.tfstate.backup**: 현재 인프라 상태를 추적하고, 변경 사항을 관리하는 파일입니다.
- **variables.tf**: 개발 환경에서 사용되는 변수를 정의한 파일입니다. 예를 들어, 리전, VPC ID, 서브넷 ID 등의 변수가 포함될 수 있습니다.

---

## modules 디렉터리

모듈들은 특정 기능을 수행하는 리소스의 집합으로, 프로젝트 내 여러 환경에서 재사용할 수 있도록 구성되었습니다.

### compute 모듈

```plaintext
├── compute
│   ├── datasource.tf
│   ├── main.tf
│   └── variables.tf




## 기타 정보 
NHN Cloud에서 테라폼을 사용하기 위해서는 NHN Cloud에서 제공하는 테라폼 가이드를 참고하여야 하며, 그 외 기본 테라폼 관련 정보를 학습하기 위해서는 테라폼의 공식 문서를 참고는 것이 좋습니다. 
