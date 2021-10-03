# StudyProject30
iOS 개발 스터디

## 첫번째 

class) 09.24 - FlickrSearch(https://github.com/soapyigu/Swift-30-Projects/tree/master/Project%2020%20-%20FlickrSearch) 

collectionView의 FlowLayout과 (https://ggasoon2.tistory.com/17).

requestAPI에 대해 공부. 그리고 apiKey는 config에 저장하고, git ignore로 깃에 업로드 되지 않도록 수정. ( https://ggasoon2.tistory.com/18 ).


## 두번째 

class) 10.01 - URL Session에 대하여 공부. 

Session의 Configuration 파라미터 값.
1. configuration의 값을 갖지 않는 기초적인 session인 shared 싱글톤 세션
2. Default값의 configuration을 갖는 session은 shared 세션과 상당히 비슷하지만 delegate를 통해 데이터를 점진적으로 불러올 수 있음.
3. Ephemeral session은 캐시나 쿠키, credentials(신원증명?)을 디스크에 기록하지 않음.
4. Background session은 앱이 실행중이지 않을 때도 백그라운드에서 컨텐츠를 업로드하거나 다운로드할 수 있게 해줌.

dataTask가 resume()으로 시작하는 이유 - URLSessiond의 dataTask는 suspend() 상태로 시작하기 때문. 

suspend 상태에서는 네트워크 트래픽이 생성되지 않으며 시간 초과의 영향을 받지 않고, 다운로드 작업은 이후 resume으로 진행 가능.

Git API를 활용하여 git 아이디를 검색하면 follower를 나타내주는 간단한 검색 어플 제작.


<img width="481" alt="1" src="https://user-images.githubusercontent.com/37135479/135764110-643bcdb4-b896-4f27-859e-a38ba7adb2b7.png">
1.초기화면

<img width="481" alt="2" src="https://user-images.githubusercontent.com/37135479/135764119-732447a3-c507-4d21-8d43-c5a0bc6c0ec0.png">
2. 검색 성공시 팔로워의 profile image와 git id를 tableVC에 표현

<img width="481" alt="3" src="https://user-images.githubusercontent.com/37135479/135764123-58988ea2-a8a6-4d56-8c58-53c4339634ef.png">
3. URLsession의 response가 nil인 상황 (git id가 없을 때)

<img width="481" alt="4" src="https://user-images.githubusercontent.com/37135479/135764128-9969b33e-5d09-4b7f-bb62-250ca51b31cb.png">
4. URLsession에서 json model로 리턴되는 data의 count가 0일 때 (follower가 없을 때)

