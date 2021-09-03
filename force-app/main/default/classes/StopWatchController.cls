public with sharing class StopWatchController {
    public WorkingWatch__c workingWach {get; set;}	//作業時間オブジェクト
    public String calculateTime {get; set;}			//計測時間（秒）
    public String resultMessage {get; set;}			//登録結果メッセージ
    
    //商談選択リスト
    public List<SelectOption> opportunitySelectOptions{
        get{ 
            List<Opportunity> OpportunityList = [SELECT id, name FROM Opportunity LIMIT 100];
            List<SelectOption> opportunitySelectOptions = new List<SelectOption>();
            for(Opportunity o : OpportunityList){
                opportunitySelectOptions.add(new SelectOption(o.id, o.name));
            }
            return opportunitySelectOptions;
        }
    }
    
    //コンストラクタ
    public StopWatchController(){
        //変数初期化
        this.workingWach = new WorkingWatch__c();
        this.calculateTime = '0';
        this.resultMessage = '';
    }
    
    //登録
    public void register(){
        this.workingWach.CalculateTime__c = this.calculateTime;
        try{
            insert this.workingWach;
            this.resultMessage = '登録しました。';
        }catch(DmlException e){
            for (Integer i = 0; i < e.getNumDml(); i++) {
                this.resultMessage += e.getDmlMessage(i) + '\r\n';
            }
        }
        this.workingWach = new WorkingWatch__c();
    }
}