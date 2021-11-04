# StudyProject30
iOS 개발 스터디

## 첫번째 class

09.24 - FlickrSearch (https://github.com/soapyigu/Swift-30-Projects/tree/master/Project%2020%20-%20FlickrSearch) 이미지 fetchAPI

collectionVC의 flowLayout에 대하여 공부 - 3xN의 collectionView 만들기 (https://ggasoon2.tistory.com/17).

requestAPI에 대해 공부 - seachBar의 검색 키워드에 대하여 FlickerImage API를 호출하여 3xN collection에 이미지 불러오기 

apiKey에 대하여. apiKey는 config에 저장하고, git ignore로 깃에 업로드 되지 않도록. (https://ggasoon2.tistory.com/18).


## 두번째 class

10.01 - URL Session에 대하여 공부. 

Session의 Configuration 파라미터 값.
1. configuration의 값을 갖지 않는 기초적인 session인 shared 싱글톤 세션
2. Default값의 configuration을 갖는 session은 shared 세션과 상당히 비슷하지만 delegate를 통해 데이터를 점진적으로 불러올 수 있음.
3. Ephemeral session은 캐시나 쿠키, credentials(신원증명?)을 디스크에 기록하지 않음.
4. Background session은 앱이 실행중이지 않을 때도 백그라운드에서 컨텐츠를 업로드하거나 다운로드할 수 있게 해줌.    
---



- dataTask가 resume()으로 시작하는 이유 - URLSessiond의 dataTask는 suspend() 상태로 시작하기 때문. 

- suspend 상태에서는 네트워크 트래픽이 생성되지 않으며 시간 초과의 영향을 받지 않고, 다운로드 작업은 이후 resume으로 진행 가능.

- response의 값이 없을 때 completion(nil) 반환 -> nil값이 들어왔을 때를 구분하여 프로세스 처리

- status 값으로 https://datatracker.ietf.org/doc/html/rfc7231#section-6.3.1 참고 (rfc 공식문서)

- response의 값이 없을 때 completion(nil) 반환 -> nil값이 들어왔을 때를 구분하여 프로세스 처리
---

### Git API를 활용하여 git 아이디를 검색하면 follower를 나타내주는 간단한 검색 어플 제작.



1. 초기화면

<img width="481" alt="1" src="https://user-images.githubusercontent.com/37135479/135764110-643bcdb4-b896-4f27-859e-a38ba7adb2b7.png">

2. 검색 성공시 팔로워의 profile image와 git id를 tableVC로 표현

<img width="481" alt="2" src="https://user-images.githubusercontent.com/37135479/135764119-732447a3-c507-4d21-8d43-c5a0bc6c0ec0.png">

3. URLsession의 response가 nil인 상황 (git id가 없을 때)

<img width="481" alt="3" src="https://user-images.githubusercontent.com/37135479/135764123-58988ea2-a8a6-4d56-8c58-53c4339634ef.png">

4. URLsession에서 json model로 리턴되는 data의 count가 0일 때 (follower가 없을 때)

<img width="481" alt="4" src="https://user-images.githubusercontent.com/37135479/135764128-9969b33e-5d09-4b7f-bb62-250ca51b31cb.png">


## 세번째 class
10.28 - Animation에 대해 공부

Animation의 생성 조건  
1. 시작점 위치
2. 종료점 위치
3. 진행 소요 시간  
---

Animate함수를 이용하여 종이 움직이는 애니메이션 제작.   

![ezgif com-gif-maker (1)](https://user-images.githubusercontent.com/37135479/139529536-c83fd9ae-a5f7-48d9-9748-e170fc68e7e7.gif)

- 회의록 노션일지  https://nutritious-scowl-1e3.notion.site/10-28-7191dea0909a440db051c7f1f9be9f86


- 다양한 애니메이션 참고 사이트  https://github.com/ameizi/awesome-ios-animation

---

Animation의 구현에 너무 많은 작업을 요구한다면 디자이너가 쉽게 제작가능한 gif로 대체가 가능하다.
하지만 gif를 많이 넣게되면 앱이 무거워지는 현상이 발생한다. 그것을 대체하기 위해 lottie 채택 가능  

airbnb에서 제작한 gif 대체 'lottie' 라이브러리
https://github.com/airbnb/lottie-ios  



## 네번째 class

11.04 - Kingfisher에 대해 공부, 라이브러리에 대한 고찰

- 회의록 노션일지  https://nutritious-scowl-1e3.notion.site/11-04-a8267a5e65ff457b9af3fa06cf071ca2
