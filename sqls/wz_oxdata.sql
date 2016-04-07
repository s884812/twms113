SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `wz_oxdata`
-- ----------------------------
DROP TABLE IF EXISTS `wz_oxdata`;
CREATE TABLE `wz_oxdata` (
  `questionset` smallint(6) NOT NULL DEFAULT '0',
  `questionid` smallint(6) NOT NULL DEFAULT '0',
  `question` varchar(200) NOT NULL DEFAULT '',
  `display` varchar(200) NOT NULL DEFAULT '',
  `answer` enum('o','x') NOT NULL,
  PRIMARY KEY (`questionset`,`questionid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wz_oxdata
-- ----------------------------
INSERT INTO `wz_oxdata` VALUES ('1', '1', '在副本地勢高的地方棲息的魔龍，是遠距離與近距離攻擊的怪物.', '魔龍只有近距離攻擊.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '2', '火獨眼獸, 風獨眼獸, 冰獨眼獸是長相類似的怪物，這之中只有火獨眼獸有2個眼睛.', '全部都只有 1個眼睛.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '3', '乘著掃把飛行的巫婆可以向遠處的角色射出強力的魔法光線.', '巫婆是近距離攻擊的怪物.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '4', '乘著掃把飛行的巫婆對於神聖屬性魔法的抵抗力很弱.', '巫婆對於神聖屬性魔法很弱.', 'o');
INSERT INTO `wz_oxdata` VALUES ('1', '5', '礦山殭屍與殭屍比的話，殭屍的等級比較高', '兩個的等級皆為 57', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '6', '飛行的蝙蝠就像飛鼠般的掛在天花板上.', '不休息繼續飛行.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '7', '就像在黃金海灘或熱帶沙灘可以看見的花蟹一樣，紅螃蟹偶爾會跳躍攻擊.', '雖然長得像花蟹一樣但也會跳躍攻擊.', 'o');
INSERT INTO `wz_oxdata` VALUES ('1', '8', '藍獨角獅是會冰凍攻擊的怪物.', '為冰凍屬性攻擊，弱點為不死屬性的怪物.', 'o');
INSERT INTO `wz_oxdata` VALUES ('1', '9', '長得像可愛的海龜一樣的烏龜有著強力的遠距離攻擊.', '烏龜為遠距離攻擊型的怪物.', 'o');
INSERT INTO `wz_oxdata` VALUES ('1', '100', '赤龍為龍類怪物中唯一會遠距離攻擊的.', '赤龍與冰龍皆會遠距離攻擊.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '101', '主要棲息在沼地的黑鱷魚是比土龍等級還高的怪物.', '黑鱷魚(等級 52), 土龍(等級 45).', 'o');
INSERT INTO `wz_oxdata` VALUES ('1', '102', '在勇士之村周圍可以看到土龍，他是龍的進化種，特徵為遠距離攻擊.', '只能近距離攻擊無法遠距離攻擊.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '103', '在冰原雪域登場的所有怪獸，對於火屬性魔法的抵抗力都很弱.', '黑吉拉卡,黑企鵝對於神聖屬性很弱', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '104', '怪物短牙海豹若遭受攻擊的話會與頭上的小海豹分離，然後一起攻擊.', '小海豹無法分離.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '105', '等級 100的地獄巴洛古不會中毒魔法的毒.', '特徵是會使毒魔法變得無效，但對神聖魔法很弱.', 'o');
INSERT INTO `wz_oxdata` VALUES ('1', '106', '乘著掃把飛行的巫婆是不死怪物.', '巫婆雖然對神聖屬性魔法很弱，但是不是不死怪物', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '107', '吃了炸蝦道具後，狩獵活跳蝦會更容易抓到.', '與炸蝦無關.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '108', '斧木妖是樵夫沒有將斧頭拔出，所以含著恨而誕生的怪物.', '傳說為樵夫把斧頭釘在上面後離開，所以含著恨而重新出生', 'o');
INSERT INTO `wz_oxdata` VALUES ('1', '109', '哈利波特和妙麗是男女朋友.', '哈利波特和妙麗只是朋友.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '110', '狼人若遭到攻擊會召喚自己的分身並攻擊.', '狼人沒有分身', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '111', '在童話村登場的鬼怪中，綠色鬼怪可使用蕎麥蒟蒻來召喚.', '綠色鬼怪 - 蕎麥蒟蒻', 'o');
INSERT INTO `wz_oxdata` VALUES ('1', '112', '在童話村登場的鬼怪中，藍色鬼怪可使用豬肉串來召喚.', '藍色鬼怪 - 穀茶', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '113', '在童話村登場的鬼怪中，黃色鬼怪可使用穀茶來召喚.', '黃色鬼怪 - 豬肉串', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '114', '楓之谷內最弱的怪物為 \'菇菇仔\'.', '最弱的不是菇菇仔而是蝸牛.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '115', '在動物森林中的狐狸與浣熊額頭貼著樹葉.', '兩隻怪物皆在額頭貼著樹葉.', 'o');
INSERT INTO `wz_oxdata` VALUES ('1', '116', '抓住上海郊外的鴨子的話可獲得潛水鞋.', '不是潛水鞋而是可獲得鴨蛋.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '117', '英文APPLE的意思是柳丁.', 'APPLE的意思是蘋果.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '118', '2014年世界杯冠軍是巴西隊.', '巴西隊已經被淘汰囉.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '119', '機器貓小叮噹最愛的食物是銅鑼燒. ', '抓到山羊的話可獲得白羊角.', 'x');
INSERT INTO `wz_oxdata` VALUES ('1', '120', '人類的五官包括手.', '五官是眉眼耳鼻口.', 'x');
INSERT INTO `wz_oxdata` VALUES ('2', '1', '村莊商店雖然有賣單邊銀色耳環但沒有賣紫水晶耳環.', '紫水晶耳環可在弓箭手村商店中購買.', 'x');
INSERT INTO `wz_oxdata` VALUES ('2', '2', '在商店購買 100%卷軸時雙手武器卷軸比單手武器卷軸還貴.', '雙手武器卷軸與單手武器卷軸的價錢一樣.', 'x');
INSERT INTO `wz_oxdata` VALUES ('2', '3', '魔法森林武器商店中只有販售長杖卷軸與短杖卷軸.', '也有販售耳環用卷軸.', 'x');
INSERT INTO `wz_oxdata` VALUES ('2', '100', '炸蝦道具只能向水世界的雜貨商人安納斯購買.', '其他地方沒有販售', 'o');
INSERT INTO `wz_oxdata` VALUES ('2', '101', '青銅弓箭與鋼鐵弓箭可透過弓箭手村的比休斯來製作.', '比休斯只能製作青銅弓箭.', 'x');
INSERT INTO `wz_oxdata` VALUES ('2', '102', '製作提煉石的時候最花錢的提煉石就是星石.', '黑暗水晶要50000楓幣，最貴', 'x');
INSERT INTO `wz_oxdata` VALUES ('2', '103', '為了在未裝備的道具上使用卷軸必須要習得 \'神匠之魂\' 技能才行.', '必須要習得神匠之魂技能才能在為裝備的道具上使用卷軸 .', 'o');
INSERT INTO `wz_oxdata` VALUES ('2', '104', '怪物卡在物品欄一格中最多可重疊至100個.', '可重疊至1,000個.', 'x');
INSERT INTO `wz_oxdata` VALUES ('2', '105', '攻擊速度快的木精靈槍可向特產販售員百鳥警官購買.', '可向特產販售員百鳥警官購買木精靈槍.', 'o');
INSERT INTO `wz_oxdata` VALUES ('2', '106', '製作魔法師手套紅守護手套時需要的動物皮革總共有 60張.', '需要動物皮革 60張，魔法森林的艾德郎會幫忙製作.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '1', '暖爐是為了能在寒冷的冬天讓房裡變暖和，而在裡面放入火來使用.', '暖爐也可以用來烤地瓜或熱食物.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '2', '植物的莖是根部吸收水份移動的通路.', '植物從根部吸收的水分藉由莖來移動.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '3', '發光的物體稱作 \'光源\'.', '火, 陽光, 螢光等都屬於光源.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '4', '太陽是從東邊升起的.', '答對了!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '5', '物體上發出光芒時出現亮與暗的階段稱做 \'明暗\'.', '好好表現明暗的話可以感受到該對象的立體感, 量感.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '6', '國家的 3元素為國民, 主權, 國防', '不是國防而是領土.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '7', '花花公子是指喜歡花錢的人.', '是指用情不專一的人.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '8', '夏季因為冷氣而得的病為冷房病.', '室內外的溫差為 5°C為最洽當.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '9', '漫畫海賊王的魯夫是吃了神奇膠囊才有了特殊能力.', '漫畫海賊王的魯夫是吃了惡魔果實才有了特殊能力.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '10', '狗是人類最忠實的好朋友.', '答對了!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '11', '汗有能將體內的廢物向外排出、調節體溫及保護皮膚的作用.', '適當的流汗是好的.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '12', '夏季家中室內外溫差約5度是最適當的.', '溫差5度以上的話很容易會得冷房病.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '13', '夏季吃太多冰冷食物的話有可能會使消化能力下降.', '若吃冰冷食物，體內的熱氣容易不足.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '14', '緊張時手裡出汗的原因為血壓上升、體溫升高.', '身體在發燒時流汗的話可以退燒.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '15', '綠巨人浩克生氣時會變得巨大.', '綠巨人浩克變得巨大力量會更強.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '16', '西瓜是水份很多的水果.', '西瓜內還有90%以上的水份.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '17', '夏天的夜晚比冬天長.', '夏天的夜晚比冬天短.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '18', '新楓之谷是很多小朋友喜愛的遊戲.', '是很多小朋友共同的回憶.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '19', '新楓之谷目前最新的職業是隱月.', '答對囉!就是隱月.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '20', '衣食住是指人類活著必要的衣服, 飲食, 玩樂.', '衣食住是指衣服, 飲食, 家.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '21', '加熱空氣的話空氣的體積會縮小.', '加入空氣的話空氣的體積會增加. 空氣的體積會根據溫度而不同.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '22', '顏色的 3要素中  \'明度\'是指顏色明亮與混濁.', '顏色明亮與黑暗稱作明度，清澈與混濁稱為彩度.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '23', '吸血的蚊子為雄性.', '吸血的蚊子為雌性, 雄性蚊子一般是吃植物的脂液(樹液).', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '100', 'NBA是世界職業籃球最高殿堂.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '101', '青銅器時代為櫛紋陶器, 新石器時代為無紋陶器.', '櫛紋陶器為新石器, 無紋陶器為青銅器.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '102', '我國的新石器時代始於 B.C 8000年間.', '部落族長代表部落，開始了農耕與畜牧.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '103', '五月天團員一共有5個人.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '104', '寫出名偵探福爾摩斯與他的朋友華生的故事的作者為阿瑟·柯南·道爾.', '1891年以短篇開始發表福爾摩斯系列.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '105', '狼人在月圓之夜會變身.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '106', '諾貝爾獎共分為物理學, 化學, 生理ㆍ醫學, 文學, 和平, 經濟學6個部門來頒獎', '諾貝爾獎在 1901年首次舉行，共分為6個部門來頒獎.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '107', '蜘蛛人可以發射蜘蛛絲飛簷走壁.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '108', '在海邊生長的海星因為長得像星星所以英文為 \'Starfish\'.', 'Starfish為海星的意思.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '109', '在太陽系裡，土星與海王星中間的行星為天王星.', '太陽-水星-金星-地球-火星-木星-土星-天王星-海王星-冥王星', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '110', '夏天下雨後變涼爽的原因是因為 固體→液體→氣體(吸熱反應) .', '是因為 固體→液體→氣體:吸熱反應.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '111', '動物在冬天睡覺稱為冬眠，在夏天睡覺稱為夏眠.', '進行夏眠的動物有玉筋鱼, 海參, 瓢蟲等.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '112', '颱風的名字是由各國家分別提出10個，總140個；共分為5組。每組28個.', '颱風名字是由各國家分別提出後命名.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '113', '蚊子吸人或動物血的原因是為了獲得動物性蛋白質.', '因為面臨即將到來的產卵期的雌性為了獲得動物性蛋白質.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '114', '中暑時喝綠豆湯很好.', '中暑時若喝綠豆湯可以降低身體的熱.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '115', '酒後絕對不能開車.', '喝酒不開車.開車不喝酒.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '116', '英文字母共有26個.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '117', '山上因為氣壓低的緣故，要比在平地用更高溫度才能煮開開水.', '在山頂上以低溫煮水來煮飯的話，容易煮不熟.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '118', '周星馳演過上海灘賭聖.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '119', '籃球之神Michael Jordan的Michael是姓，Jordan是名', 'Jordan是姓，Michael是名', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '120', '中秋節與端午節, 春節被稱為我國三大佳節.', '三大佳節為端午節,春節,中秋節.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '121', '新楓之谷遊戲中的熱鍵是預設好的不能變動.', '熱鍵可以重新設定.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '122', '本土綜藝天王是LOCALKING吳宗憲.', 'LOCALKING就是吳宗憲.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '123', '卜派吃番茄也能變身.', '卜派吃菠菜才能變身.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '124', '在海裡生活的蝦子與其他的魚貝類不同，腦是在尾巴上的.', '蝦子的腦是在頭上.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '125', '紅茶種類中有種 \'錫蘭紅茶\'. 這裡的錫蘭是一個盛產紅茶的印度村莊名字.', '錫蘭是斯里蘭卡的地名', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '126', '攀登至珠穆朗瑪峰最高峰的日本人田部井淳子，是靠著吃壽司一邊克服酷寒一邊征服山頂的.', '流傳是吃泡菜鍋克服嚴寒的.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '127', '幻獸師能使用大象的能力.', '幻獸師能使用豹熊鷹貓四種動物的能力.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '128', '2014年金曲獎最佳男歌手是周杰倫.', '2014年金曲獎最佳男歌手是林俊傑.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '129', '河馬的汗是紅色的', '河馬的汗為紅色是因為河馬會分泌出一種黏膩的紅色分泌物', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '130', '汗比眼淚更鹹.', '眼淚更鹹.汗中有 99%是水，眼淚成分有 98%是水', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '131', '撲克牌共有3種花色.', '撲克牌共有黑桃紅心方塊梅花4種花色.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '132', '使用白棋子與黑棋子來決勝的圍棋是在圍棋盤上進行的遊戲. 那麼圍棋盤上交點的個數為 361個.', '19 x 19 = 361.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '133', '打麻將相公的時候不能胡牌.', '麻將規定：相公的時候不能胡牌.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '134', '餵食狗狗太鹹的食物，狗狗會容易生病.', '寵物吃太鹹的食物容易得皮膚病，和內臟方面的疾病.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '135', '冬天比夏天更容易發生高血壓.', '因為天氣冷血管收縮壓力變高.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '136', '美國的代表股票價格指數為 \'道瓊指數\'.', '在道˙瓊斯指數中共同發表每日發表的4種股票價格平均指數', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '137', '英國因鴉片戰爭勝利而佔領的香港在1997年回歸中國.', '1997年 7月 1日結束 155年的殖民統治回歸中國.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '138', '冰淇淋最早是由中國製作的.', '最早是在5世界時作為中國皇帝甜點的冰果.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '139', '印刷術發明後最早使用印刷發行的報紙為德國的 \'Flug-blatt\'.', '德國新聞Flug-blatt是最早的印刷報紙.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '140', '小叮噹的耳朵是被老鼠咬掉的.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '141', '被譽為世界大師的梵谷, 保羅˙高更等皆為後期印象派畫家.', '梵谷, 保羅˙高更等皆為後期印象派代表畫家.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '142', '德國魏格納所主張的大陸飄移說中，所提出的有一個大陸出現指的是 \'聯合古陸\'.', '聯合古陸意思是一個很大的大陸.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '143', '世界最早的電腦是美國賓夕法尼亞大學所製作的Eniac.', 'Eniac是在1946年最早被製作出的電腦.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '144', '小叮噹的妹妹叫做技安妹.', '小叮噹的妹妹叫做小叮鈴.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '145', 'animation有活著的意思，他的語源是Anima.', '可以看見感覺各個圖片連續的移動.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '146', '江南大叔PSY紅遍全球的舞蹈叫做霹靂舞.', '江南大叔PSY紅遍全球的舞蹈叫做騎馬舞.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '147', '桃園三結義是指劉禪.關羽.張飛義結金蘭的故事.', '桃園三結義是劉備.關羽.張飛三人.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '148', '同花順打的贏Full House.', '撲克牌牌型中，同花順比Full House大.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '149', '母蟬有著特別的發聲器所以可以發出很高的聲音.', '公蟬有特殊的發聲器所以可以發出很高的聲音.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '150', '紫禁城在上海.', '紫禁城在北京是知名古蹟.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '151', '忍者龜的師傅是一隻老鼠.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '152', '企鵝不會冬眠.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '153', '韓文(訊民正音)是在1446年被創造出來的.', '創造完成的時間是1443年，並於1446年出版.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '154', '朝鮮末年與韓國最早簽訂通商條款的是美國.', '最早簽訂的江華島條約是因為日本而強制簽訂的.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '155', '地球公轉一圈需要365天.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '156', '日本最高的山是富士山.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '157', '世界第7大不可思議中的其中一個是法老王的金字塔側面與底面全部都是正三角形.', '側面是三角形，底面是四角形.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '158', '恐龍的名字經常會加上sauros， sauros的拉丁語有 \'恐怖\',\'可怕\'的意思.', 'sauros的拉丁語有大蜥蜴的意思.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '159', '以巨大白鯨與亞哈故事為背景描繪的是法國小說白鯨記', '白鯨是美國小說家 H.Melville的作品.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '160', '法國的象徵動物是公雞.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '161', '法國的著名小說小王子的作者是安托萬·德·聖-埃克絮佩里.', '本名 : Antoine Marie Roger De Saint Exupery', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '162', '1993年在法國出現繪有小王子的鈔票.', '正面是安托萬·德·聖-埃克絮佩里的肖像, 背面畫有\'小王子\'的可愛角色', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '163', '製作dos,window等的 MS(micro soft)的創辦人為 史蒂芬˙霍金博士.', 'micro soft公司的創辦人是比爾蓋茲.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '164', '聖經中帶領大家渡過紅海的人叫做宙斯.', '聖經中帶領大家渡過紅海的人叫做摩西.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '165', '台灣最高的山是阿里山.', '台灣最高的山是玉山.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '166', '選舉時根據心情或狀況的變化更換政黨或候選人的不透明投票稱為不投票.', '稱為浮動票.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '167', '媽祖是保護漁民的神明.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '168', '馬是站著睡覺的其中一種動物，長頸鹿也和馬一樣站著睡覺.', '長頸鹿跟馬都是站著睡覺.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '169', '2014年是馬年.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '170', '太陽系中最大的行星是金星.', '最大的行星是木星.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '171', '變色龍如果戴上眼罩身體就無法變換顏色', '變色龍是用眼睛看周邊的顏色來改變顏色的.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '172', '鯊魚的牙齒不論怎麼掉了或斷裂還是會繼續長出來', '鯊魚會繼續長出牙齒.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '173', '貓咪沒有眉毛,也沒有睫毛', '眉毛與睫毛都有.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '174', '人的一生中就算掌紋改變了，指紋是不會變的', '指紋不會變.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '175', '郵票的周圍的鋸齒狀是為了方便撕開郵票.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '176', '蝸牛沒有牙齒', '蝸牛也有牙齒.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '177', '金魚可以向後游.', '鰭在構造上無法向後游.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '178', '公雞可以下蛋.', '因賀爾蒙異常而變中性化的公雞是有可能會產下未成熟的蛋.', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '179', '蜉蝣有嘴巴.', '因為生命短，消化器官退化，所以沒有嘴巴.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '180', '有測量辣味的單位.', '關於辣椒的辣味，南韓國際性的基準稱為 SHU(Scoville Heat Unit).', 'o');
INSERT INTO `wz_oxdata` VALUES ('3', '181', '感受到恐怖的話體溫會下降.', '感受到恐怖時因為交感神經體溫會上升.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '182', '按照大多數國家和地區的風俗，結婚戒指一般應該戴在左手中指上.', '按照大多數國家和地區的風俗，結婚戒指一般應該戴在左手無名指上.', 'x');
INSERT INTO `wz_oxdata` VALUES ('3', '183', '長頸鹿跟人的頸骨數一樣.', '兩個的頸骨都是7個.', 'o');
INSERT INTO `wz_oxdata` VALUES ('4', '1', '攻擊藥水在3分鐘內可以提升物理攻擊力10.', '物理攻擊力3分鐘內上升5.', 'x');
INSERT INTO `wz_oxdata` VALUES ('4', '2', '在魔法森林雜貨店購買藍色藥水的話，比起其他村莊便宜，用8楓幣就可購買1個藥水.', '在魔法森林雜貨店中可以便宜購買藍色藥水.', 'o');
INSERT INTO `wz_oxdata` VALUES ('4', '3', '喝下速度藥水的話5分鐘內會增加移動速度.', '3分鐘內會增加移動速度.', 'x');
INSERT INTO `wz_oxdata` VALUES ('4', '4', '喝下魔力藥水的話 5分鐘內會增加魔力 10.', '魔力在3分鐘內會增加 5.', 'x');
INSERT INTO `wz_oxdata` VALUES ('4', '5', '喝下枯木樹液的話5分鐘內魔法攻擊力增加 10.', '魔法攻擊力在5分鐘內增加 10.', 'o');
INSERT INTO `wz_oxdata` VALUES ('4', '6', '吃下暴龍之肉的話 5分鐘內會增加物理防禦力100.', '物理防禦力在 5分鐘內增加 100.', 'o');
INSERT INTO `wz_oxdata` VALUES ('4', '7', '喝下暴龍之血的話 5分鐘內會增加物理攻擊力 10.', '物理攻擊力在 5分鐘內會增加 5.', 'x');
INSERT INTO `wz_oxdata` VALUES ('4', '8', '只要喝下1個超級藥水就能100%恢復 HP與 MP.', '超級藥水可恢復全部的 HP,MP', 'o');
INSERT INTO `wz_oxdata` VALUES ('4', '9', '玩具城裡販售的藥丸比起其他藥水來說，可以持有更多.', '一格可持有 100個藥水，但因藥丸體積較小所以可持有150個.', 'o');
INSERT INTO `wz_oxdata` VALUES ('4', '10', '楓之谷世界中有可以治療所有狀態異常的藥.', '有可治療所有狀態異常的萬能療傷藥.', 'o');
INSERT INTO `wz_oxdata` VALUES ('4', '100', '喝下命中藥水的話 5分鐘內命中率會增加 100.', '命中率在 5分鐘內增加 100.', 'o');
INSERT INTO `wz_oxdata` VALUES ('4', '101', '喝下敏捷藥水的話3分鐘內迴避會增加 100.', '迴避在 3分鐘內會增加 100.', 'o');
INSERT INTO `wz_oxdata` VALUES ('4', '102', '黃昏之露可使 MP恢復 5000 ', '使MP恢復 5000 ', 'o');
INSERT INTO `wz_oxdata` VALUES ('4', '103', '清晨之露可使 HP恢復 4000 ', '使MP恢復 4000 ', 'x');
INSERT INTO `wz_oxdata` VALUES ('4', '104', '24小時路邊攤, 珍, 拜倫, 哈娜, 豪素夫, 米斯級等都有販售礦泉水.', '維多利亞港的珍沒有販售礦泉水.', 'x');
INSERT INTO `wz_oxdata` VALUES ('4', '105', '疼痛舒緩劑只可從地球防衛本部特派所中購買.', '疼痛舒緩劑只有在開發的特派所有販賣.', 'o');
INSERT INTO `wz_oxdata` VALUES ('4', '106', 'NPC妖精克莉爾在天空之城武器商店裡.', '妖精克莉爾在天空之城雜貨商店裡.', 'x');
INSERT INTO `wz_oxdata` VALUES ('4', '107', '好吃的黑輪與各種蔬菜串成的黑輪竹串可以提升 MP 500.', '黑輪(竹串)可以恢復 MP250.', 'x');
INSERT INTO `wz_oxdata` VALUES ('4', '108', '日式炒麵(雙份)比起日式炒麵可多提升魔法攻擊力 10 .', '雙份日式炒麵比起日式炒麵5分鐘可提升更多的魔法攻擊力.', 'o');
INSERT INTO `wz_oxdata` VALUES ('4', '109', '比起章魚燒在5分鐘可提升更多攻擊力的加量章魚燒價格貴 2倍.', '章魚燒:2000楓幣 , 加量章魚燒: 4200楓幣', 'x');
INSERT INTO `wz_oxdata` VALUES ('4', '110', '中華拉麵,豚骨拉麵,海鮮粥可恢復所有 HP.', '可恢復所有 HP.', 'x');
INSERT INTO `wz_oxdata` VALUES ('4', '111', '販賣拉麵,中華拉麵的廚師 NPC的名字為元泰 .', '拉麵廚師元泰販售各種拉麵.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '1', '勇士村 \'與安卓思共舞\'任務只有 1轉過的角色才能完成.', '沒有轉職也能執行任務.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '2', '完成維多利亞港 \'珍與黑肥肥\' 任務的話可從珍那裡得到頭盔防禦卷軸.', '不是頭盔防禦卷軸而是可獲得武器卷軸 1個.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '3', '墮落城市組隊任務在有其他隊伍進行任務時無法入場.', '其他組隊在進行任務時無法入場.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '4', '墮落城市的離家少年阿勒斯的父親是奇幻村一般桑拿房的泰實夫.', '阿勒斯的父親是弓箭手村的長老斯坦.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '5', '完成約翰的粉紅花籃任務的話可從約翰那獲得螺絲 30個.', '從約翰那獲得螺絲30個.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '6', '地鐵站 服務員販賣的工地 B1,B2,B3 入場費全部為 2000楓幣.', 'B1-500楓幣,B2-1200楓幣,B3-2000楓幣', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '7', '墮落城市組隊任務的等級限制為 Lev20~Lev30 .', '等級限制為 21~30 .', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '8', '與安卓斯共舞\'的蓋新家任務要有人氣度 5以上才能進行.', '只有人氣度 10 以上的角色才可進行.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '9', '製作薩比特拉瑪的返老還童藥任務可獲得星石與月石.', '非薩比特拉瑪要求道具的情況可獲得月石.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '10', '墮落城市組隊任務總共有5個階段.', '總共 5個階段都要完成才行. 也有bonus舞台.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '11', '野外地圖也可能會有NPC存在', '野外地圖也可能會有NPC存在', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '12', '完成拿錯的藥草的任務時獲得 EXP 500.', '獲得500經驗值後完成.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '13', '\"菇菇寶貝\"伺服器創的角色，也可以在\"雪吉拉伺服器\"玩', '角色無法跨伺服器玩', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '14', '捉到培利堤安可獲得任務材料記憶的碎片', '可從馬堤安那獲得', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '15', '組隊任務的任務總共有 9個階段，必須要由 6位組成隊伍才行.', '等級限制為 35~50.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '16', '完成弓箭手村中 \'瑪亞與奇怪的藥\'任務的話可從瑪亞那獲得 \'褐色斗笠\'.', '可從瑪亞那獲得褐色斗笠.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '100', '楓之谷遊戲畫面左上角小地圖，不能關掉.', '左上角小地圖可以關掉.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '101', '任務地圖忍耐森林總共由 5個階段組成.', '製作減肥藥 製作返老還童藥 ', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '102', '雜貨店購買的道具\"雞蛋\"作用是送NPC增加友好度.', '\"雞蛋\"作用是拿來恢復HP.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '103', '泰實夫任務所需的特製烤鰻魚材料為猴子的香蕉,風獨眼獸之尾巴,肥肥頭.', '特製烤鰻魚中沒有猴子的香蕉', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '104', '任務地圖沉睡森林總共由 7個階段組成.', '沉睡森林總共由 7個階段組成', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '105', '為了完全完成妖精羅雯和詛咒的娃娃任務，需要的詛咒的娃娃個數為 2千3百個.', '各需要100個,200個,400個,600個,1000個', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '106', '完成與安卓斯共舞\'的蓋新家任務時會隨機獲得武器強化卷軸(10%).', '與安卓斯共舞\'的蓋新家任務的獎勵可選擇職業別.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '107', '完成與安卓斯共舞\'的蓋新家任務需要的材料中的\'地契\'可從冰獨眼獸那獲得.', '地契可從風獨眼獸那獲得 ', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '108', '神術士不是楓之谷的職業.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '109', '小地圖中顯示為\"紅色圈圈\"代表的是其他玩家', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '110', '玩家可以在自由市場PK', '自由市場無法PK', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '111', '等級 50以上可執行的任務為新手外全職業皆可執行的任務.', '從等級 55開始新手外的全職業皆可進行', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '112', '為了提煉黑暗水晶，必須要完成部分任務才行.', '任務中必須要完成亞凱斯特和黑暗水晶任務才行', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '113', '皮奧資源回收任務的獎勵為休閒椅.', '坐在休閒椅上的話每 10秒恢復 HP 50.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '114', '[伊卡路斯的滑翔翼] 任務中完成 [好無聊] 任務只有等級 32以上的角色可執行.', '必須完成先行任務\'好無聊\'任務才行.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '115', '必須要完成妖精維英給的 [幫忙寫作業]任務中的 [伊卡路斯的熱氣球]任務才可執行.', '只有等級10以上的角色才可進行[伊卡路斯的滑翔翼]任務.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '116', '抓到魔女怪物[巫婆]的話就可獲得任務戰利品中其中的一個魔女草葉子.', '攻擊魔女的話可獲得魔女草葉子.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '117', '完成NPC邪摩斯給的 [爲復活準備]任務的話人氣度會下降 -2 .', '獲得鞋子相關卷軸人氣度會下降.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '118', '[封印住神秘危險之力的儀式 1]任務所需道具為冰獨眼獸給的涼爽的氣息 33個.', '冰獨眼獸給的道具為冷漠的氣息.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '119', '為了進行[大海的遇難者]任務必須要擁有 SES請求救援信才行.', '必須要擁有怪物掉寶的 SOS請求救援信才行.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '120', '[有關轉職的指導]任務中坤出的問題共 5題.', '總共猜對 3題的話可以進行至下一階段.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '121', '自由女神像是英國送給美國的禮物.', '自由女神像是法國送給美國的禮物.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '122', '著名畫家徐悲鴻以擅長畫龍而聞名.', '著名畫家徐悲鴻以擅長畫馬而聞名.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '123', '中秋節的時候大家都愛吃粽子.', '端午節的時候大家都愛吃粽子.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '124', '人體最大的解毒器官是肝臟.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '125', '完成秀茲的興趣任務的話可以獲得獎勵氧氣筒.', '秀茲的興趣任務的獎勵為經驗值與氣泡.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '126', '狗狗熱的時候用舌頭散熱.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '127', '組隊任務 \'月妙的年糕\'\'要等級 10以上才可參加.', '月妙的年糕任務限制等級為 10以上.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '128', '古希臘古羅馬神話中的諸神裡面，被稱為愛神的是邱比特.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '129', '組隊任務 \'月妙的年糕\'若與弓箭手村公園的 NPC 托尼對話的話可入場.', 'NPC 達爾利.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '130', '魔王巴洛古困難模式遠征隊員最多可至6名.', '魔王巴洛古困難模式遠征隊員可 6名 ~ 15名一起.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '131', '菇菇王國的公主名字為 \'菲歐拉\'.', '菇菇王國的公主名字為 \'菲歐娜\' .', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '132', '怪物生存戰:未開放地區可使用等級為 25 ~ 35.', '怪物生存戰:未開放地區可使用等級為 25 ~ 30.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '133', '想成為名譽地鐵站服務員話必須消滅堆積灰塵的站台的怪物 5,000隻.', '消滅堆積灰塵的站台的怪物 10,000隻以上的話可獲得名譽地鐵站服務員勳章.', 'x');
INSERT INTO `wz_oxdata` VALUES ('5', '134', '墮落廣場的 \'赫一\'說想成為歌手.', '墮落廣場的 \'赫一\'的夢想是成為歌手.', 'o');
INSERT INTO `wz_oxdata` VALUES ('5', '135', '在奈特的金字塔中消滅怪物 50,000隻以上可成為法老的守護者.', '與模式無關在奈特的金字塔消滅怪物 50,000隻以上的話可獲得法老的守護者勳章.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '1', '為了2次轉職收集來黑珠子 30個的話可獲得 \'英雄證書\'道具.', '英雄證書是 2次轉職的所需道具.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '2', '新手等級10時可選擇戰士, 魔法師, 弓箭手, 盜賊, 海盜中其中一個職業.', '魔法師在等級8時可轉職.', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '4', '新手初次轉職的話可獲得技能點數 1點.', '新手轉職的話可獲得技能點數 1點.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '5', '為了4次轉職， 已3次轉職的角色等級須達到 120以上才行.', '從120以上考 4次轉職.', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '6', '魔法師可使用可瞬間移動的 \'瞬間移動\'技能.', '魔法師可使用瞬間移動.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '7', '隱身術為盜賊的技術，可隱藏自己的樣子並攻擊怪物.', '以隱藏的樣子無法攻擊怪物.', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '100', '槍騎兵的 \'武神招來\' 技能全部學系使用的話最多可增加 HP, MP各 60%.', '精通大師的情況各增加 60%.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '101', '使用弓箭的射手技能中 \'穿透之箭\'全精通的話會增加 180% 傷害.', '穿透之箭全部精通的話會增加 180%的傷害.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '102', '盜賊在跳躍的狀態可使用發射飛鏢的技能 \'lucky seven\'.', '盜賊在跳躍的狀態可使用 \'lucky seven\'技能.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '103', '新手為了轉職為盜賊而去的地方為 \'盜賊基地\' .', '為了轉職而去的地方為 \'盜賊基地\' .', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '104', '使用弓箭的射手的轉職順序為 [弓箭手 →獵人→ 遊俠→神射手] .', '以 [獵人→遊俠→箭神] 順序轉職.', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '105', '使用短劍的盜賊的轉職順序為 [盜賊→俠盜→神偷→夜使者] .', '以 [盜賊→俠盜→神偷→夜使者]  順序轉職.', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '106', '楓幣炸彈是可使掉落在地上的錢爆發並攻擊附近敵人的技能.', '使掉落在地上的錢爆發並施以傷害.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '107', '暗殺者的 \'風魔手裏劍\' 技能消耗3個飛鏢後可射出大飛鏢.', '消耗3個飛鏢後會發射貫穿敵人的大飛鏢.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '108', '使用神偷的 \'落葉斬\'技能的話一定機率可使怪物死亡.', '一定機率可使怪物暈眩.', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '109', '想學習龍騎士的 \'龍咆哮\' 技能的話 \'龍之獻祭\'技能等級需5 以上.', '龍之獻祭\' 技能需3以上.', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '110', '想學習遊俠的 \'箭雨\' 技能的話 \'龍神閃\' 技能等級需3 以上.', '致命箭\' 技能等級需5 以上.', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '111', '普利斯特的 \'聖光\' 技能可攻擊多數敵人.', '最多可攻擊 6隻怪物.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '112', '就算普利斯特的 \'喚化術\' 技能成功，怪物的基本能力值也不會有變化.', '基本能力值不會有變化.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '113', '想使用遊俠的 \'替身術\' 技能的話需1個召喚石.', '沒有召喚石也可使用.', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '114', '受到巫師的 \'冰風暴\' 技能攻擊的話一定時間內會結冰.', '命中時冰雷屬性外的怪物結凍的話，一次無法攻擊6隻以上.', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '115', '新手技能 \'恢復\'的再次使用等待時間為 15分鐘.', '經過10分鐘後可再次使用.', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '116', '武打動作英雄狂狼勇士登場日為 2009年 7月 9日', '狂狼勇士在 2009年 7月 9日初次登場.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '117', '狂狼勇士為了發動連環吸血技能須累積 50連環以上才行.', '累積30連環時可發動.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '118', '新手技能疾風之步的再次使用等待時間為 60秒.', '使用疾風之步後為了再次使用需等待 1分鐘才行.', 'o');
INSERT INTO `wz_oxdata` VALUES ('6', '119', '狂狼勇士的騎寵名字為 \'提提阿那\'.', '狂狼勇士的騎寵為狼 \'柳虎\'.', 'x');
INSERT INTO `wz_oxdata` VALUES ('6', '120', '戰鬥衝刺技能存在使用命令.', '戰鬥衝刺的存在命令為 \'-> ->\' .', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '1', '初次創角連線後會從 [楓之島]開始.', '楓之谷第一次開始的地方是 [楓之島].', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '2', '初次創角時會擲骰子. 此時合計 STR,DEX,INT,LUK的所有分數為 24分.', '合計為 25分.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '3', '新楓之谷中見到的第一個 NPC為 \'莉納亞\'.', '新楓之谷中見到的第一個 NPC為 \'希娜\'.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '4', '使用各村莊的計程車時尚未轉職的新手優惠價格只需支付 100楓幣就能搭乘.', '新手只需支付 50楓幣就能使用計程車.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '5', '在墮落城市中可買到藥水與卷軸的藥局名字為 \'明藥局\' .', '在墮落城市中可購入藥水等物品的場所為 \'明藥局\'.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '6', '在村莊內幾乎沒有 HP時從高處掉落也不會死.', '在村莊內若消耗全部的 HP時也會死.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '7', '為了入場隱密之地需要等級10以上轉職過的角色.', '無等級限制、任誰都可進入.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '8', '青蛙是兩棲動物.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '9', '海邊地圖黃金海灘中賣藥水的小姐名字為 \'拜倫\'', '藥水商人 NPC的名字為 \'拜倫\'.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '100', '人類的性別是由Y染色體決定的.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '101', '鯊魚是屬於淡水魚類.', '鯊魚是屬於海水魚類.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '102', '2次轉職等級過 31以上時轉職的情況無法獲得bonus  SP+1.', '轉職時都可獲得bonus SP.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '103', '老虎，獅子，貓在動物分類上都屬於貓科.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '104', '在水世界的動物園中總共有 4隻怪物.', '巴洛古, 雪吉拉, 白狼, 緞帶肥肥, 肥肥總共有5隻怪物.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '105', '鯨魚島的 NPC納努克帶著 4隻哈士奇.', '帶著褐色, 黑色, 灰色哈士奇.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '106', '椰子樹林地圖鯨魚島地圖中的鯨魚額頭貼著OK蹦.', '兩隻全部都在額頭貼OK蹦.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '107', '太公的渡船地圖中太公的魚竿上黏著 1片葉子.', '雖然總共黏有 3片但魚竿上只黏有1片.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '108', '愛奧斯塔 93樓的不倒翁能手 2拿著錘子.', '其他不倒翁能手拿著其他的工具.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '109', '往水世界的愛奧斯塔地下去的話會出現水中地圖.', '水世界是與愛奧斯塔連接在一起的地圖.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '110', '為了創設公會需要有 100萬楓幣.', '一定要有150萬楓幣才能創設公會.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '111', '公會的人員數最多可至 30名.', '公會人數最多可至 100名.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '112', '為了使公會人員從 10名增加至 15名需要 50萬楓幣.', '公會人員從 10名增加至 15名需要 50萬楓幣.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '113', '公會公告只有會長可使用.', '會長與副會長皆可使用公會公告功能.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '114', '解除公會的情況需要消耗 20萬楓幣.', '只有會長可解除公會，需20萬楓幣.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '115', '為了創造公會標誌需 500萬楓幣.', '透過NPC 蕾雅可創造公會標誌.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '116', '創造公會與公會標誌的負責 NPC為海拉格.', '公會標誌的負責NPC為蕾雅.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '117', '在村莊裡的 \'榮譽殿堂\'可確認公會排行.', '在榮耀之石\' 可確認公會排行.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '118', '任務提醒中最多可登錄 5個任務.', '最多登錄5個任務可即時確認.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '119', '公會對抗戰加上獎勵階段總共有 6個階段.', '總共有 7個階段.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '120', '公會對抗戰的背景的舊王國名字為 \'魯碧安\'.', '是威廉的古堡城.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '121', '水世界是與天空之塔地下連接在一起的水中地圖.', '透過艾納斯 → 天空之塔 → 天空之塔 B2可前往.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '122', '在水世界中每10秒會減少 HP.', '沒有氧氣筒或空氣瓶道具的話每 10秒會減少 HP.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '123', '水世界的大海的遇難者 NPC名字為 \"魯賓遜克魯斯\".', '是魯賓遜.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '124', '童話村的七南七誠兄弟的哥哥為七南.', '七誠是哥哥，七南是弟弟.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '125', '使用外掛時可能會在第1次被永久限制.', '只要使用一次外掛就可能成為永久限制.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '126', '透過NPC \'篤伊\'可向其他玩家寄送包裹. 使用費為 50,000楓幣.', 'NPC篤伊, 使用費為 5,000楓幣.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '127', '弓箭手村裡的世界之旅導遊名字為 \'秀匹奈爾\' .', '世界之旅導遊為 \'史匹奈爾\'.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '128', '弓箭手村副本入口的警衛 \'魯克\'右手拿著槍.', '魯克是左手拿著槍.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '129', '勇士村的 NPC \'義安\'的父親是 \'布魯斯\'.', 'NPC 義安的父親是布魯斯沒錯.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '130', '在東方岩石山II的 NPC的名字為 \'劍士轉職教官\'.', '在東方岩石山ⅱ的 NPC 名字為溫斯頓.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '131', '海怒斯出現的地圖名字為 \'海怒斯的深海洞穴\'.', '為\'海怒斯洞穴\'.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '132', '在地球防衛總部的羅威草原的葛雷元老拿著魔杖.', '不是羅威草原而是克嵐草原.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '133', '雙色染髮只可在夜市的美容室進行.', '雙色染髮只可在夜市的美容室進行.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '134', 'NPC妙斯在水世界動物園裡 .', 'NPC妙斯在水世界動物園裡 .', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '135', '寄送包裹後過 24小時對方就會收到.', '12小時候對方就會收到.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '136', '娃娃魚的叫聲和嬰兒哭聲很像.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '137', '色澤鮮豔度高的野生蘑菇最好不要採食，有毒的可能性很大.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '138', '鳥類中壽命最長的是鸚鵡.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '139', '海豚是屬於哺乳類動物.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '140', '荷蘭又稱為風車之國.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '141', '《白雪公主》的作者是格林兄弟.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '142', '台灣最南的縣是屏東縣.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '143', '燕窩主要是由燕子的口水做成的.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '144', '馬鈴薯發芽後是有毒不能食用的.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '145', '大發明家愛迪生小時後砍了爸爸的櫻桃樹.', '小時後砍了爸爸的櫻桃樹的人是華盛頓.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '146', '蠟筆小新的妹妹叫做小葵.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '147', '世界三大宗教不包括道教.', '世界三大宗教是基督教、回教以及佛教.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '148', '粽子是韓國人發明的.', '粽子是中國人發明的.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '149', '瑪迦提亞村莊的人形機器人的名字為休曼諾伊德B.', '瑪迦提亞村莊的人形機器人的名字為休曼諾伊德A.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '150', '結婚小鎮的文月花右手拿著手機.', '平常是拿著拐杖, 有時候會拿出手機來看.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '151', '西遊記中孫悟空的武器是金箍棒.', '答對囉!', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '152', '商城中販賣的裝備道具可使能力值上升.', '現金裝備道具不會使能力值上升.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '153', '蒙特鳩協會長為卡森, 卡帕萊特協會長為麥德.', '卡森與麥德各自擔任蒙特鳩與卡帕萊特協會長.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '154', '楓之谷訊息中最多可邀請 2位朋友進行對話.', '楓之谷訊息包含本人總共可有 3位進行對話.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '155', '封印道具1週限使用1次，可解除.', '透過詢問顧客中心1週可使用1次.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '156', '沒找到快遞道具的話會在 10天後消失.', '快遞道具的保管期限為 30天.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '157', '卡蜜拉說他很怕猶塔的肥肥農場的肥肥盔甲.', '卡蜜拉怕的是緞帶肥肥.', 'x');
INSERT INTO `wz_oxdata` VALUES ('7', '158', '童話村的燕子從小就被道公餵食仙桃與仙湯所以變得很聰明.', '因為仙桃與仙湯所以童話村的燕子變得很聰明.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '159', '瑪迦提亞城的琪妮是妖精與人類的混血.', '瑪迦提亞城的琪妮是妖精與人類的混血.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '160', '瑪迦提亞城的雜貨商人哲利也有販售寵物飼料.', '可向瑪迦提亞城的雜貨商人哲利購買寵物飼料.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '161', '墮落城市所有的懸賞海報都有被撕過毀損的樣子.', '盜賊的村莊墮落城市沒有一張完整的懸賞海報.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '162', '童話村的樂夫穿著可看見肚臍的衣服.', '可向童話村的樂夫確認美麗的肚臍.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '163', '快遞員篤伊鞋子的顏色為褐色.', '快遞員篤伊穿著美麗褐色的鞋子.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '164', '勇士村的倉庫王老闆是獨眼.', '去勇士村的話可以看到獨眼王老闆.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '165', '在弓箭手村瑪亞的家前面有一個紅色郵筒.', '瑪亞的家前面有一個可愛的紅色郵筒.', 'o');
INSERT INTO `wz_oxdata` VALUES ('7', '166', 'NPC 羅亞拿著的 3個氣球中最大的是紅色的.', '羅亞拿著的 3個氣球中最大的是藍色的.', 'x');
INSERT INTO `wz_oxdata` VALUES ('8', '1', '世界盃第1屆比賽在義大利舉行.', '第1屆比賽在烏拉圭，義大利是第 2回比賽.', 'x');
INSERT INTO `wz_oxdata` VALUES ('8', '2', '世界盃每 2年就舉辦一次.', '每4年舉辦一次.', 'x');
INSERT INTO `wz_oxdata` VALUES ('8', '3', '南極不會出現北極熊.', '北極熊生活在北極.', 'o');
INSERT INTO `wz_oxdata` VALUES ('8', '4', '2002年 韓,日世界盃為第 17屆世界盃.', '韓,日 世界盃為第17次比賽.', 'o');
INSERT INTO `wz_oxdata` VALUES ('8', '5', '足球為 11名選手的比賽，籃球為 6名選手的比賽', '籃球為 5名選手的比賽.', 'x');
INSERT INTO `wz_oxdata` VALUES ('8', '6', '奧林匹克的五環旗中亞洲代表亞洲的顏色為黃色.', '五環旗中黃色象徵亞洲.', 'o');
INSERT INTO `wz_oxdata` VALUES ('8', '100', '台灣也是位於赤道上的國家', '台灣沒有位於赤道上，台灣位於北回歸線上.', 'x');
INSERT INTO `wz_oxdata` VALUES ('8', '101', '網球中的大滿貫是指 美國公開賽法國公開賽,澳洲公開賽,溫布頓全部包攬的意思.', '包攬4大國際比賽稱為大滿貫.', 'o');
INSERT INTO `wz_oxdata` VALUES ('8', '102', '在高爾夫中比擊球數少進1個球時為博蒂,少2個球時為老鹰球, 少3個球時為三振.', '少進3球時稱作信天翁.', 'x');
INSERT INTO `wz_oxdata` VALUES ('8', '103', '童話故事三隻小豬，最後小豬都被大野狼吃掉了.', '三隻小豬把大野狼趕跑了.', 'x');
INSERT INTO `wz_oxdata` VALUES ('8', '104', '在一場比賽進了3球的選手在足球裡稱作hat trick ，在冰上曲棍中稱作 triple.', '冰上曲棍也稱作hat trick.', 'x');
INSERT INTO `wz_oxdata` VALUES ('8', '105', '世界著名的死海位於埃及.', '死海位於約旦和巴勒斯坦交界.', 'x');
INSERT INTO `wz_oxdata` VALUES ('8', '106', '跨欄比賽中無論男女皆為 110m.', '女子為 100m 男子為 110m.', 'x');
INSERT INTO `wz_oxdata` VALUES ('8', '107', '在足球中進行自由球時至少要距離對方踢球選手最少 9.15m 以上才行.', '進入9.15m內的話會被警告.', 'o');
INSERT INTO `wz_oxdata` VALUES ('8', '108', '游泳被指定為奧運正式項目是在 1896年 第1屆奧運.', '從1900年 第2屆奧運起被指定為正式項目.', 'x');
INSERT INTO `wz_oxdata` VALUES ('8', '109', '88首爾奧運中南韓獲得全體第 5名.', '88首爾奧運中南韓獲得全體第 4名.', 'x');
