Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4B65CCA6
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 06:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjADFrm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 00:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjADFri (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 00:47:38 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A6112A8B;
        Tue,  3 Jan 2023 21:47:37 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3043BGQp021141;
        Tue, 3 Jan 2023 21:47:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=vBYstzPsgq5w+NlGMk+BRmiFhIS6f6bRMhma/PoYuiE=;
 b=FQBWZCtukJcov9nmtyJ7XMTQtyPscxJfOWkfscy9oz6fWBRDsTPnPZb/DHxFZZ1XgmO0
 YmzIT9oc9yXYUm4W8RmYdzDmHgwyC3AnSnzItRz4oJh7YJj0f3SUXFCWNodoZ9+3ulAn
 VVrkRiMIsIcce9JWYVVmZhFJHtBRKy8xJ0L9ovrPW8pDWgvOdFvuDNqnWVOilZTOO0XS
 6aOipQVK11o7+bHeaO+sZjoi5+uxJBTpudc/hY8UGpCQOZzzVarH9cjhKgLyZqqhr/A7
 qz6uwkLrIDYSoKguKLtWz5UW5JdfP5FK9niZ9bwGVctObvib7vLctcgvYGZvBzFE5G5L OA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mvwv0j1ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 21:47:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rccz60ZeCpoMATnfpajwXt2PzqyZ6mVIfB7couhJOGMD8OiiZhrCQAfc653BedK/Mj3OCwBP30JsOsn0iCUtypKwKeZbe74SIHd2K1Dk7ASJGuWabsJrkmO+8Nm8ZiwVfOT/WdV6qUAtORHDSAq+4FqkdX1iO0XMybUyOnHk67OCZkxliU+nMrLiJ4C8Ob09qgOhP3KFh3rPjejY+M0d/BbG95gPKHfXVvGdroXYlnQ94WaSYvSprV0fZNHO4AebgVTmC+0Qp54mYAzsHqX9OlZZA1D8MnfK5HCAItLzdtVc/EV11O3POmikx5aElRLuXmqbZd/wie8x+jH+bB1nEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEI/+eVmjymp0rk1Aron9uBLmXKJY+rzHwkcTh4Vnwg=;
 b=IJohw5DxYpZVBomM/mKlSAjkZrDIUfrnKGQ9qpM4+zJtZQsq/k296QVfqxRtFn648viwatj3hucdb68tzpu2os53WzAc9RptIfwByiLBJqYoi3CNCIDurXGwcXlMRVhOvHU6LaCKqaAp5adwQVnfAxTOsiw5i7+6kAAoWfG7Ot0bgbnfKN8QycNKHHft3D6B2JNZsOibB07eVE4Vx1X1w8rCWgoV4pE3A99kUyovQ98KuArfV6Liq9c965+Z63ZYjv1b4G5N7dp4LevEo3ySkoz/HRBnGalCmzgjoei4hSkCYz20q7H2f3FLRPcowjndhdU9k1ABMIUI6VWQfqlhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3163.namprd15.prod.outlook.com (2603:10b6:5:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 05:47:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 05:47:13 +0000
Message-ID: <44be9647-0208-beaf-130d-92a036c95d04@meta.com>
Date:   Tue, 3 Jan 2023 21:47:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: WARNING in __mark_chain_precision
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hao Sun <sunhao.th@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CACkBjsaXNceR8ZjkLG=dT3P=4A8SBsg0Z5h5PWLryF5=ghKq=g@mail.gmail.com>
 <Y6C36gvJ2JnwKm3X@google.com>
 <CAEf4BzbY8SDL04W_3Vot6iiYu69Lqg9W9aMCp26+RwLBh6C_0g@mail.gmail.com>
 <ba5aacc8-7e10-e20a-936b-f3f81d7fcf03@meta.com>
 <CAEf4BzY-DMVEpy+mPTObEO56E7=fzqab8zW_4JyBeyGtTqqcXg@mail.gmail.com>
 <29B647B3-174A-4BE7-9E0E-83AE94B0EADF@gmail.com>
 <04c66278-b044-98e4-2861-218bd159bd15@meta.com>
 <CB67D529-B384-4B1C-AC01-DD99D4F6DEA5@gmail.com>
 <CAADnVQKy48LPz=f6XSHv84tZb7MFp8PrWrk3AxJLKwJR0tL=nA@mail.gmail.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAADnVQKy48LPz=f6XSHv84tZb7MFp8PrWrk3AxJLKwJR0tL=nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:40::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3163:EE_
X-MS-Office365-Filtering-Correlation-Id: cc40d875-e65c-4552-aafc-08daee17212d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJvoPyfjLWO5Z2ongFRXKj9E9T2Q1kmZ0/REGGxeykLO6EP4X6sC7Ky7BPdRRhPWM1MpjkoL3vg9HWMsg2Pp26Yh8Ej0Q093XhKuqv1bm6jRd7xYoeRVF8fXwbcPNEXYsxmzcO8v1C452tmjbYiX2a6KsH1sLn1fXd7piAl+ME9HlgYvuha4oOQO4UPGtsIAEfkP4OAXptTxx25qqbND+SrlcjPXVjU/N968E2wkp2fqhJ9DZzTvqSiivxu22KFuMaeYacFgErVdmWMgHB7Lzh+mfeeg+enA9ZZON2DbGTVA0/ohiELYqNNecxdN+84y39e47bL9n3BjKSe6cv0ygyLP/1n/ffX6uf9c35d7TfUAj0d/EvfkxzoXSAp6vn/zf+y1B6EAu9ivWJpYucrdTQd62xagpagpNF4OmdtkRpOYhihk1ibIdepvqunwbcThBlntDj4mRvjyQOz8StTlp8t4TyNPtyxBRLaVDAZuiyfO6KMY1fC6RGSxIsAOwc43R6KvYuZq0iCfSSivH0spsv24V0rdTY+JnsD867+SE3wbh9mRGv48UUtiwHe9uhzMRwME2WRFQ+m0+HezSWwIkq+0b27G8uT3IrTOnYB0KBtHHo/++UMFzkH76u+pFAiIRT10z0tcwG6CrV4WZuvgk1Kuq/PiEpmFRWWOWXayCDuTupznsWaMUChyMaY93SeVV6Q1986DKDTEpRQhP+rqiDgvL7ozvXgPFcrl99CDydf7jl4dKH7A2eI+2tKWDAMNjC3MuOHOUq1qI0pSL1zX1xTOenFIwiteKvnRsAodnjc2RXUuruFGT7v6jo41TFa6fkqMgCe9tA/eW/lRxYneXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(54906003)(110136005)(38100700002)(316002)(8936002)(66946007)(41300700001)(8676002)(66556008)(36756003)(66476007)(4326008)(6512007)(966005)(86362001)(31696002)(2616005)(83380400001)(6486002)(478600001)(6506007)(53546011)(186003)(2906002)(31686004)(5660300002)(7416002)(10126625003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmRVdEkxWmg0RDEram5JSHkwWW9sWThoa3VyTDBFUWVSUmtJcjAxbjFQNFpY?=
 =?utf-8?B?YlhOWXZQdlJzQ2hVMFc1SVBEcW9lUnMrcXhLQ1E5VExGL05FM0U3aTY1a2l2?=
 =?utf-8?B?OEFUa1ZndUtNZnNYVmpMb215YWg0ek1RYU00UnZjNEcrYlR4K0lzSVp4YVlr?=
 =?utf-8?B?cVlUUEZLNUpTbU1MczFCb0liODAvbVd5YjFQazhqUUN5QW9lbDRTZG9Ub1l2?=
 =?utf-8?B?VHN3UFpLSVZWaFUvaGFLUTN2YXE2Z3UranhVRHZWK3RBT1UwOGtYbHA2OHFS?=
 =?utf-8?B?aGpydHpIOTdaWGtLWlJzc2hOcXNTRUNLTTBmRitTY0FJdmlLcTZwSXlPWURM?=
 =?utf-8?B?OWZrdjFBUWlHMVNEcDJlZHg5QXVBMmVZbjhkUkZJWGFFTnVXK005bkFsSXRk?=
 =?utf-8?B?dTV0UHJ4TVV6SXRoQnFNVUJtWHd6UnBLcVpZQjcxQlEraG4ybWkzaXpsK1l2?=
 =?utf-8?B?Z2Zad2Y2bFJDcFY1cGFobFBpUVUrR3FFNWRHNXpIZFR6aFhsN3RzV3VNWnow?=
 =?utf-8?B?WjlKQ0g0MTVncWkveWlzZDM3Vkl6ejc4RHBHWkVzcFNXamhhKzgyc0k5dXAx?=
 =?utf-8?B?bSt0N21GWkczQlZpZXJrdFJIWHJXQ3ZNa2JiM0dHck5qR05PKzRkU1ZPcVRT?=
 =?utf-8?B?akY4cURyRXFwUEU3Qmc2cGhPYjErSTV4S1cvREFJcWFCdG0vRFVxandQSTBN?=
 =?utf-8?B?UTgxR0l6dmhLNkw5ZGNCYlRUZ1B5czRPckZwblN5YVRvVklKcFpRWGNqUnlO?=
 =?utf-8?B?cFEyRXVoek1qczNCZHBXOG13WGNkbzdJNSttWi8vOVRMOTNraGx1VFE2RlU5?=
 =?utf-8?B?STZZUGNmam1KQzk1MlVDWnY5NjVSVUVkMXdRQjZOOTNOMDllczNGVW1tNVBw?=
 =?utf-8?B?V2Z5QUNjQ21xVitxVDZ0d0NXUmx0MmFRS0ZPemZKSWxQSG1VN1ozdmw1ZnF0?=
 =?utf-8?B?cmV6eUhNRXJGZ0YvV1N2NzYyOEVwaW9peTRraHNIdm92VFNsTTQxZHRDSkRU?=
 =?utf-8?B?YjBpRDlWeldWWTJocGZidUxSdkVqZUQ4ZWxSd0xqMXl1OXIvbjJ2alJLbVJH?=
 =?utf-8?B?eCtYbUV1eVVPbXFhZFVSb0VZZHhJVUZvQzE1QzJQZ1cxSWowS2VZbEJKQWJ6?=
 =?utf-8?B?bWxrRi9TdHNjT3VhOXA5cjR0ZU5vOGZhRzBMOURGdE5TM096a2d1Y3ptRHAr?=
 =?utf-8?B?bmdveTA2YlVHUjRYV2hOU3dHdVdCbHBjb0tLU05yc0RRdUNja3V1MitDdTB3?=
 =?utf-8?B?YTRKSjEwL0ViTGxtY1BGb2ZVN2N1UFRlaDUrOEVzTE1YK2dRZTEydnVDS3RW?=
 =?utf-8?B?V29wU3RFQUZEdC8rUW5rT05jSm8xbUR0eXk2dzdlb1JOWFVJZTVDMlFWbjlB?=
 =?utf-8?B?UmhTcTZRZTJVbXZZcE9RUGlSa3JlWGM3cDJCZGNTMFlQMTd3ZXRXZEdzZmtk?=
 =?utf-8?B?RlVmUjRlb0tHa3dCOHVrMU1HcFNqNnNPUy9jMmxBbWpaVW5xZWo1MmhPeHVj?=
 =?utf-8?B?dTgyb0E5RlBBYmM3dHBtK1l2RmtSL0xRazFVUGlKV1FuZmpiUkxibko2TFBM?=
 =?utf-8?B?WUROOUNBVTNYcHpETWJGZjZOSWhwVkp4ak5QV1dwS3Y5S0JreEhBQ0xPYTQw?=
 =?utf-8?B?b2xtQzNVZWFoRUdxekZDMWpvcUFINkFpanNidlpNc1NHVXJBVWswZGFCK0Qr?=
 =?utf-8?B?UFEwL2xtclcyZ1p1NkpEZkFPQ1JKQU9yRGZLZW9nWk9rSkpORG9hM0Rxd0dw?=
 =?utf-8?B?U1NRVmRPRUc3V2MvVU1EcFdHQTN3TTlmdkVxMEF2RmplWHB1b1pWSnBIN1NN?=
 =?utf-8?B?ejlCTHczT3pVVTdvby9aNldnUGFqWC9EcFBKSWoxZll0aHliSmc2ZGdocG9P?=
 =?utf-8?B?ODgxRU9FbkVhaGNBaGdjMGhkMXZkM2VhclFWdkhSdWNZT1JJTjd0bC9pcTd3?=
 =?utf-8?B?Q2RtRUFlT2paWStSbXlFRFJ0cGJsR0FFdWVWWlBLaTZmY1JRNXQ2Vmtld3Fy?=
 =?utf-8?B?c1BTajI3V1g4RVNJTFZYODA2TER4cEQ1L2gxb2FZMk53M3ZPUnJZNzVUQm9i?=
 =?utf-8?B?bmMzRzV4d01EMG0yQkt0VTd5ZDUyWjVGeDBMY2M0TXZ3enlxSmk0MzA2anNZ?=
 =?utf-8?B?c3ZGUEl2ckgrOXBYaURqL1huMHpRbSs2bjE2NWRnTEZ6aDI1M2MwQ1d1YjVJ?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc40d875-e65c-4552-aafc-08daee17212d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 05:47:13.6208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBnZB/2Hb/2F2gsJkLS0oMQjethO6eiHf5EIuysKirMVQ/lfRZBtyZS6qE4iBcqX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3163
X-Proofpoint-GUID: H9pCuR2NW6ND828_7-iuGQDQK3ayYk0Z
X-Proofpoint-ORIG-GUID: H9pCuR2NW6ND828_7-iuGQDQK3ayYk0Z
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_02,2023-01-03_02,2022-06-22_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/3/23 10:27 AM, Alexei Starovoitov wrote:
> On Mon, Jan 2, 2023 at 1:42 AM Hao Sun <sunhao.th@gmail.com> wrote:
>>
>>
>>
>> Yonghong Song <yhs@meta.com> 于2023年1月2日周一 03:20写道：
>>>
>>>
>>>
>>> On 12/30/22 1:44 AM, Hao Sun wrote:
>>>>
>>>>
>>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> 于2022年12月30日周五 06:16写道：
>>>>>
>>>>> On Tue, Dec 27, 2022 at 9:24 PM Yonghong Song <yhs@meta.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 12/20/22 4:30 PM, Andrii Nakryiko wrote:
>>>>>>> On Mon, Dec 19, 2022 at 11:13 AM <sdf@google.com> wrote:
>>>>>>>>
>>>>>>>> On 12/19, Hao Sun wrote:
>>>>>>>>> Hi,
>>>>>>>>
>>>>>>>>> The following backtracking bug can be triggered on the latest bpf-next and
>>>>>>>>> Linux 6.1 with the C prog provided. I don't have enough knowledge about
>>>>>>>>> this part in the verifier, don't know how to fix this.
>>>>>>>>
>>>>>>>> Maybe something related to commit be2ef8161572 ("bpf: allow precision
>>>>>>>> tracking
>>>>>>>> for programs with subprogs") and/or the related ones?
>>>>>>>>
>>>>>>>>
>>>>>>>>> This can be reproduced on:
>>>>>>>>
>>>>>>>>> HEAD commit: 0e43662e61f2 tools/resolve_btfids: Use pkg-config to locate
>>>>>>>>> libelf
>>>>>>>>> git tree: bpf-next
>>>>>>>>> console log: https://pastebin.com/raw/45hZ7iqm
>>>>>>>>> kernel config: https://pastebin.com/raw/0pu1CHRm
>>>>>>>>> C reproducer: https://pastebin.com/raw/tqsiezvT
>>>>>>>>
>>>>>>>>> func#0 @0
>>>>>>>>> 0: R1=ctx(off=0,imm=0) R10=fp0
>>>>>>>>> 0: (18) r2 = 0x8000000000000          ; R2_w=2251799813685248
>>>>>>>>> 2: (18) r6 = 0xffff888027358000       ;
>>>>>>>>> R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
>>>>>>>>> 4: (18) r7 = 0xffff88802735a000       ;
>>>>>>>>> R7_w=map_ptr(off=0,ks=156,vs=2624,imm=0)
>>>>>>>>> 6: (18) r8 = 0xffff88802735e000       ;
>>>>>>>>> R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0)
>>>>>>>>> 8: (18) r9 = 0x8e9700000000           ; R9_w=156779191205888
>>>>>>>>> 10: (36) if w9 >= 0xffffffe3 goto pc+1
>>>>>>>>> last_idx 10 first_idx 0
>>>>>>>>> regs=200 stack=0 before 8: (18) r9 = 0x8e9700000000
>>>>>>>>> 11: R9_w=156779191205888
>>>>>>>>> 11: (85) call #0
>>>>>>>>> 12: (cc) w2 s>>= w7
>>>>>>>
>>>>>>> w2 should have been set to NOT_INIT (because r1-r5 are clobbered by
>>>>>>> calls) and rejected here as !read_ok (see check_reg_arg()) before
>>>>>>> attempting to mark precision for r2. Can you please try to debug and
>>>>>>> understand why that didn't happen here?
>>>>>>
>>>>>> The verifier is doing the right thing here and the 'call #0' does
>>>>>> implicitly cleared r1-r5.
>>>>>>
>>>>>> So for 'w2 s>>= w7', since w2 is used, the verifier tries to find
>>>>>> its definition by backtracing. It encountered 'call #0', which clears
>>>>>
>>>>> and that's what I'm saying is incorrect. Normally we'd get !read_ok
>>>>> error because s>>= is both READ and WRITE on w2, which is
>>>>> uninitialized after call instruction according to BPF ABI. And that's
>>>>> what actually seems to happen correctly in my (simpler) tests locally.
>>>>> But something is special about this specific repro that somehow either
>>>>> bypasses this logic, or attempts to mark precision before we get to
>>>>> that test. That's what we should investigate. I haven't tried to run
>>>>> this specific repro locally yet, so can't tell for sure.
>>>>>
>>>>
>>>> So, the reason why w2 is not marked as uninit is that the kfunc call in
>>>> the BPF program is invalid, "call #0", imm is zero, right?
>>>
>>> Yes, "call #0" is invalid. As the code below
>>>
>>>> /* skip for now, but return error when we find this in
>>> fixup_kfunc_call */
>>>>   if (!insn->imm)
>>>>   return 0;
>>>
>>> The error report will be delayed later in fixup_kfunc_call().
>>>
>>> static int fixup_kfunc_call(struct bpf_verifier_env *env, struct
>>> bpf_insn *insn,
>>>                              struct bpf_insn *insn_buf, int insn_idx,
>>> int *cnt)
>>> {
>>>          const struct bpf_kfunc_desc *desc;
>>>
>>>          if (!insn->imm) {
>>>                  verbose(env, "invalid kernel function call not
>>> eliminated in verifier pass\n");
>>>                  return -EINVAL;
>>>          }
>>>
>>>
>>>> In check_kfunc_call(), it skips this error temporarily:
>>>>
>>>> /* skip for now, but return error when we find this in fixup_kfunc_call */
>>>>   if (!insn->imm)
>>>>   return 0;
>>>>
>>>> So the kfunc call is the previous instruction before "w2 s>>= w7", this
>>>> leads to the warning in backtrack_insn():
>>>>
>>>> /* regular helper call sets R0 */
>>>> *reg_mask &= ~1;
>>>> if (*reg_mask & 0x3f) {
>>>>       /* if backtracing was looking for registers R1-R5
>>>>       * they should have been found already.
>>>>       */
>>>>       verbose(env, "BUG regs %x\n", *reg_mask);
>>>>       WARN_ONCE(1, "verifier backtracking bug”);
>>>>       return -EFAULT;
>>>> }
>>>
>>> The main triggering the backtrack_insn() is due to
>>>
>>>                          } else {
>>>                                  /* scalar += pointer
>>>                                   * This is legal, but we have to
>>> reverse our
>>>                                   * src/dest handling in computing the range
>>>                                   */
>>>                                  err = mark_chain_precision(env,
>>> insn->dst_reg);
>>>                                  if (err)
>>>                                          return err;
>>>                                  return adjust_ptr_min_max_vals(env, insn,
>>>                                                                 src_reg,
>>> dst_reg);
>>>                          }
>>>
>>>
>>> unc#0 @0
>>> 0: R1=ctx(off=0,imm=0) R10=fp0
>>> 0: (18) r2 = 0x8000000000000          ; R2_w=2251799813685248
>>> 2: (18) r6 = 0xffff888100d29000       ;
>>> R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
>>> 4: (18) r7 = 0xffff888100d2a000       ;
>>> R7_w=map_ptr(off=0,ks=156,vs=2624,imm=0)
>>> 6: (18) r8 = 0xffff888100d2ac00       ;
>>> R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0)
>>> 8: (18) r9 = 0x8e9700000000           ; R9_w=156779191205888
>>> 10: (36) if w9 >= 0xffffffe3 goto pc+1
>>> last_idx 10 first_idx 0
>>> regs=200 stack=0 before 8: (18) r9 = 0x8e9700000000
>>> 11: R9_w=156779191205888
>>> 11: (85) call #0
>>> 12: (cc) w2 s>>= w7
>>> last_idx 12 first_idx 12
>>> parent didn't have regs=4 stack=0 marks: R1=ctx(off=0,imm=0)
>>> R2_rw=P2251799813685248 R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
>>> R7_rw=map_ptr(off=0,ks=156,vs=2624,imm=0) R8_w=map_ptr(off=0,ks=2396,v0
>>> last_idx 11 first_idx 0
>>> regs=4 stack=0 before 11: (85) call #0
>>> BUG regs 4
>>>
>>> For insn 12, 'w2 s>>= w7', w2 is a scalar and w7 is a map_ptr. Hence,
>>> based on the above verifier code, mark_chain_precision() is triggered.
>>>
>>> Not sure what is the purpose of this test. But to make it succeed,
>>> first "call #0" need to change to a valid kfunc call, and second, you
>>> might want to change 'w2 s>>= w7' to e.g., 'w9 s>>= w7' to avoid
>>> precision tracking.
>>>
>>
>> The purpose is not to make the test "succeed", the verifier temporarily
>> skips the invalid kfunc insn "call #0", but this insn triggered a warning
>> in backtrack_insn(), while it is supposed to reject the program either
>> due to insn#12 32bit ptr alu or insn#11 invalid kfunc.
>>
>> Maybe something like the bellow, after applying the patch, the reproducer
>> is rejected:
>>
>> func#0 @0
>> 0: R1=ctx(off=0,imm=0) R10=fp0
>> 0: (18) r2 = 0x8000000000000          ; R2_w=2251799813685248
>> 2: (18) r6 = 0xffff88817d563000       ; R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
>> 4: (18) r7 = 0xffff888171ee9000       ; R7_w=map_ptr(off=0,ks=156,vs=2624,imm=0)
>> 6: (18) r8 = 0xffff888171ee8000       ; R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0)
>> 8: (18) r9 = 0x8e9700000000           ; R9_w=156779191205888
>> 10: (36) if w9 >= 0xffffffe3 goto pc+1
>> last_idx 10 first_idx 0
>> regs=200 stack=0 before 8: (18) r9 = 0x8e9700000000
>> 11: R9_w=156779191205888
>> 11: (85) call #0
>> 12: (cc) w2 s>>= w7
>> last_idx 12 first_idx 12
>> parent didn't have regs=4 stack=0 marks: R1=ctx(off=0,imm=0) R2_rw=P2251799813685248 R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0) R7_rw=map_ptr(off=0,ks=156,vs=2624,imm=0) R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0) R9_w=156779191205888 R10=fp0
>> last_idx 11 first_idx 0
>> regs=4 stack=0 before 11: (85) call #0
>> regs=4 stack=0 before 10: (36) if w9 >= 0xffffffe3 goto pc+1
>> regs=4 stack=0 before 8: (18) r9 = 0x8e9700000000
>> regs=4 stack=0 before 6: (18) r8 = 0xffff888171ee8000
>> regs=4 stack=0 before 4: (18) r7 = 0xffff888171ee9000
>> regs=4 stack=0 before 2: (18) r6 = 0xffff88817d563000
>> regs=4 stack=0 before 0: (18) r2 = 0x8000000000000
>> R2 32-bit pointer arithmetic prohibited
>> processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4a25375ebb0d..abc7e96d826f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2743,6 +2743,9 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
>>                          *reg_mask |= sreg;
>>          } else if (class == BPF_JMP || class == BPF_JMP32) {
>>                  if (opcode == BPF_CALL) {
>> +                       /* skip for now, should return error when we find this in fixup_kfunc_call */
>> +                       if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && insn->imm == 0)
>> +                               return 0;
> 
> 
> Makes sense to me. Please submit as an official patch
> with s/return 0/return -ENOTSUPP/
> Also 'skip for now' isn't quite correct here.
> In check_kfunc_call() it's correct, since invalid kfunc with imm==0
> could be eliminated during dead code elimination,
> but since we're walking this insn here in backtrack_insn
> the dead code elimination is not going to kick in.
> So it's surely invalid kfunc call if we see it in backtrack_insn.
> The comment should probably be something like:
> /* kfunc with imm==0 is invalid and fixup_kfunc_call will catch
> this error later. Make backtracking conservative with ENOTSUPP. */

Do we have the same issue if we have
    call #1 <or some valid kfunc>
instead of
    call #0
?
