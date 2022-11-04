Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610BE618E54
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 03:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKDChl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 22:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKDChj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 22:37:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA1BE15
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 19:37:38 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3NKfjn015939;
        Thu, 3 Nov 2022 19:37:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=2W62ssrFcFFx+4B7cNA8wFNa0Kq8uev/VQdwM5wFJ2Y=;
 b=jdEx25PrBqPts96SDem6KWf4rjNkGtrh9Dw2pfvrRZvc7SS7EeV+1FrdkTY5Bjrl5CpD
 Ir2JIihU24lxtDZNCRnyJ5PNT1TOZ/5ZIr3m85EkdBOYuTtVandrFwJJffmgxutV1aFz
 Xrj6XtLZYsFeDgua/zdk+upmytzJmCYjglsZobT9fRrZWNPu0/Gu6XJRSqpk5Rsb4X5E
 MARYIBUYBCS4t4Lr4vwQWfR3wFviW2GJApGts6BiykHdWB/+mfHxaRCBn9XwaKIOZAbZ
 tIQSB1iA9+wUh+ATbkmqH9FBu//gDL8Ciaj8EsqrAi6xmP6eT/DJEu6ojBX6iXjzIJ05 Dg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmph2shxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 19:37:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vyw/PBXOQUhlcs9BAs0qpia1pv1j4PVMCyHNbRZfLJTVh6rH4ktoeONKf94mkQxSglOx3wwyrwsvmzYApp8hqK4ZFG8zL+auDyV5Ss1lnG/n8OCwJ0OxUT42o9P5nvDDxVjzntR9yODGAUKkQqn0MqZndo47w39eEOnKugP9mNKODWJQbruUfRZAJKcEwJXNVdRLmKywk+zhMMQQctbLvyj4rTBeBvrbcedehPTsLY7B9JxsSfjc893emJVj6ajF4bvlllEEo2+x+F9rlwvHejzDlFxSI1/qb+Z6k4upkZi7Lf1wRO2L1QcPN+pOR7RseNp3/Uv8R7rToXAwnISVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W62ssrFcFFx+4B7cNA8wFNa0Kq8uev/VQdwM5wFJ2Y=;
 b=ntzdJe5RfGoEGQ6pmVhzmycHcE1XeRftZ+7d9rVV0WXAaOHGPWmPbvSGGQkUzMaHljf7R/rIgbk3zLphBbBVh8iz0A2PkwP4wUuN/Vy6RHG1xkdMphximt2t4SzdUqusNJ2VXga3Y/J1P8CEwFH2WsHohDEZtEQs3Qh4KmNrbmw5at88g2LJ6Ev1Gc1K/gsCpqM6AnlBN+7IQlNEP3Y5vwYPVT7jV+KCH0WTOMHJmhUTf0oU3ksOG3B6LJZAKl+1UwvHCqChnwLqA2Y1QFALSisrRSd31+mneYAZLWuZDUf7Zfbs2bpGAsuaqZlEKzWIM8BwuaBeapX3YQEaZb9kmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3166.namprd15.prod.outlook.com (2603:10b6:208:fd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Fri, 4 Nov
 2022 02:37:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 02:37:19 +0000
Message-ID: <0c3df9fe-8085-55f6-6205-30e5366d6e33@meta.com>
Date:   Thu, 3 Nov 2022 19:37:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next 2/5] bpf: Add bpf_rcu_read_lock/unlock helper
Content-Language: en-US
To:     Alexei Starovoitov <ast@meta.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072113.2322563-1-yhs@fb.com>
 <20221103221800.iqolv5ed2muilrgq@apollo>
 <d9e7c760-a581-8633-f41a-3e5d122ffc9c@meta.com>
 <2eb74220-7e73-7316-8739-44e5117a8b59@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <2eb74220-7e73-7316-8739-44e5117a8b59@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB3166:EE_
X-MS-Office365-Filtering-Correlation-Id: cead8ed0-0c77-4004-7629-08dabe0d7eac
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olhbMVC+jmppvRax6CM7kRU0ynlfUyQjtJeDc8n0gnqGGUjjdqUDrhYG0AP9opcofa0Vn5LXHObnmOEfyDf8FMEduLSdnbHN9RX12+f1sQssLqW3osPgIz7ebgw/lSwBPS8s6vo6cjvXkVawEYmZFBVvgc+W2D8Lj46ktfcNSEPYAS5xOMDu8rRYBT2Rc0MxNFYc8vYc1z5NpioVh5M4emhaKmWpyYEolXGmQEZMp/KJJNLJpeFNDjkhL9Mz5Rzxu7pGabGAj1JNmPhy4ttCmomNIflaEueivjOzZg0uC9p73os8R2yjjilywbmbHpOB+QeGnFPCocA1nKruYUYlYd6BUW/7RX+9HwNYa4jIhLDjSs5LaQykFZh+wLMfaIYyHLOXr/sVBWaWF31VOZSBvJEqzdXSWeow2yvQpSUmWgVuOTO0N4lan3J69aldp6wAagKvl/bEtObWe4S1tV0Y5axITaCh3t7aCEEHWbrwBCE/EGuoZCIfVxPxo+lTKy9LwTMs6TXaMATO5bOBdflQvu2s7FotyCIAM3DHw0bXskiH9qlBAu0u9dzOp8iEyvmZhnNZzXGrdF2uK68+ESr6BMre7Xp3nC6EwCoLowl02XAQaIAgC3+PycwxjhKDJ9QWjmDaFXqIOf9WedBouv24/G6Cc3WogdGtlzwT1gYnNJJ+PrdeguryYVSBjDVYmsntuC1aT4/OYMrLF7XNCtCeD+9zkvfiC8x2IzS6Dr8sTtDOAwApt/IZc9XQtXuPbnCOf1uqj2CbPzmcaU9Kcy+30fCgoVcckMhtsWvv2RG1Sc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(6486002)(478600001)(31686004)(316002)(6666004)(54906003)(110136005)(38100700002)(2616005)(6506007)(86362001)(31696002)(41300700001)(53546011)(66946007)(66556008)(66476007)(6512007)(8936002)(2906002)(36756003)(5660300002)(8676002)(4326008)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2pkU2k3UUNGSTV4ZmMyeFNrNkd6M1pDMjBWbG1DTU5UUnZmYVlyMFBtRFg5?=
 =?utf-8?B?SkNLZ2JQdGR1b1VNM0JvbEdhVW9WUWNHdnJvRUloWmE0cEZvTGYvb096bEx6?=
 =?utf-8?B?Z2ZMS3FlYitGODEwbXlDMUpZc09vOXRLMVJMS0pMN0tYNHJnNFVaSk8rRC9m?=
 =?utf-8?B?QTN6ak5oaWZlcUdmOGJJK1lGWFJTU01hTGs2a3YwYW5FK0svMXNOSWwvbzF6?=
 =?utf-8?B?citXNGU0UVpoRW5raUplRnNsRUNhd29tYnkvak1LMXErWURCLzNxOTJndmJ5?=
 =?utf-8?B?OXdjdHY0ZkFFbkVGNmlFR3owM2hZNmcrNklicGRtYkNoRHlTb3UwN0pFbHBJ?=
 =?utf-8?B?a016MGpBME9Pb2RPT05GSUpLNXBqWG0ya0JZYkoxRlpITGNtU29uQjdWSDZh?=
 =?utf-8?B?cXZJOE5aQnJvSS9CNGlpWCs4L2xnWVhDNUpSa0xuazM0RXRPR2JpRzFNQndO?=
 =?utf-8?B?ZzV3Um1naEJSVWYyNG9yaDQ0eTBEVUNMYnFQc0RLRFVnMkRscE1VUXdQSjJY?=
 =?utf-8?B?S05lMndrZXZoSTZQWnFmTUk3bHBmbEM1a05GVzJDangrRmJKQ3JiZjd0TVpB?=
 =?utf-8?B?cTNzb1BzNXFxUmsxWi95ekhWR0g0QTVRU05reGsySEFZUEJBbFFOUy9VTSsv?=
 =?utf-8?B?Z3FSWkhPS3RrSGt3S1V6bmE0UWk2MXpWWm1nQmlHMDNvdXE2ZmhSWHlQNEpa?=
 =?utf-8?B?WVBjSjVJTVEzTWNHWmd0VVJzSGFBRnF3dFU2YnRQUTJnMTRGVzc1QVVIS2NP?=
 =?utf-8?B?d0ZsL3ZGOHdaY1B2ZitLdml5VFBSUWZYUFpjNzF3d2RJT2VvMkJtbDNQb1U1?=
 =?utf-8?B?TEEvUjdFc3BRcCt5N0dIdmZ1Q3Yrd2NpTElwR1BpUU1ocGd2NW5DZ3QxMWx1?=
 =?utf-8?B?cVpMclJFWHlpL3hQV1BvMXhSNEJKbW5MRTlNOHJnUkh1YStvbmk4d3o0Wjcz?=
 =?utf-8?B?cndLczM3TDZHamxiWkJJeXpieTBiRDVqbHBlV2tjR2gxaTE0UStPRU84Z08x?=
 =?utf-8?B?L0ZvZHZiYVVnWU50VFV6NSt3a01GT1NLbW9FelhjK1JVR205akpYSmMxMkd2?=
 =?utf-8?B?KzZBWW50NHpFTFBCMnRpYSs1S2NwL2RyU0tQT0lGTmFTemhqSjM3anRxdFl3?=
 =?utf-8?B?dnFSMkhWQUd6TEdnNnE1YzNGV1pQVlZidUVnZDBoV0dpWmxjNk1RUFJMQ2Zv?=
 =?utf-8?B?YmJNN2VsTldaSkxuVUhrSGJIRUVCclBodVhQTXVzSVYyTExNQm81TGJWUEFo?=
 =?utf-8?B?cTRSY2lobTBOdHQvU3hrRWFJenpwYnR6VzZaeHhmbW5BRjlVcUpwYytpVGFi?=
 =?utf-8?B?MXhXY1BjcnJiemQrWVprNXYzTE5YUTJ5OStLcnpNdHQyU1IyTzhNeWthM0JC?=
 =?utf-8?B?T0QyNjZpMDJTb2Q3QTMvSC9nYnpzdmJQTDlTZVNuY0FHcEE0eWVTUFRKOFlQ?=
 =?utf-8?B?djdaN2xTQTN3bnUxeXptV3I2a0ZxWFlwbnNBRzN2VUZDZDdDUG51YVpJNnZD?=
 =?utf-8?B?a3hkWXU4eVgzdkYzb2grSkpidjJpcGU4dFFueUl5Unl0UkVEZWZPRGwwK0Fl?=
 =?utf-8?B?cXd5ejlyOGNHMUVsK2hRbzAwclgrUE53eGpEeFY1MGdsa0FlM0NncUZTZ3Zw?=
 =?utf-8?B?TXlDS05yc2dma0tQWW9rNitnNmRNUGUwZDdkUDJjeit1VlVQQ1QyODhxbzdn?=
 =?utf-8?B?T2huMnEvZFl5TFdWWHpJU3NuYThFNGY4OVF3bmlLZ0N1Ryt2TGZJc1FsbTRj?=
 =?utf-8?B?bmY2WnA0ZzU2anFYRHQ5R3QxeEY4ZjJmYlBtVksvVHhpRnhYMXhXcUIzZm9N?=
 =?utf-8?B?R01GSDhyK1VkbzNINkpjN09TR0hBUjk5UzNkRmNOU3prNUNhNmpzbkpCZUZr?=
 =?utf-8?B?WjRFdlE0RUpxUy9FTjdUc0MyL092REVpRVFzbVVKczdCczN3Zzhua25NdE1U?=
 =?utf-8?B?eW90cDdiWjlCWXZOOGcvZGltdkZjMXVxRkVKVCtmai9ndWtObnRONEpmVzRY?=
 =?utf-8?B?b3RTbk12aXNmU3BoaXdhdnhXT1d0dW0xMjlmSlU0andDU3J6QmM3MktVWWI4?=
 =?utf-8?B?NExVcHgrSUdEb1FQSEtFWmhMSCtURjIyQ3V0ZDRKYnl2SkwwUGZ4elJTUC9S?=
 =?utf-8?B?MmpmTTlkVEZ5NEdobnYzWVBmV2pISnhIMGtTZ216MVFQL09sNFBtRnhzckFU?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cead8ed0-0c77-4004-7629-08dabe0d7eac
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 02:37:19.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iyf6sR7BYfaWh5DuJo0LD39uXTBRt8liQnK7jIexwgK8sgOla4bpxrHkZs6WZEMF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3166
X-Proofpoint-GUID: 7-0-__0b2b123Huyz_hwOlYPK0rnd0Qt
X-Proofpoint-ORIG-GUID: 7-0-__0b2b123Huyz_hwOlYPK0rnd0Qt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/3/22 6:04 PM, Alexei Starovoitov wrote:
> On 11/3/22 5:30 PM, Yonghong Song wrote:
>>>> index 94659f6b3395..e86389cd6133 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -5481,6 +5481,18 @@ union bpf_attr {
>>>>    *        0 on success.
>>>>    *
>>>>    *        **-ENOENT** if the bpf_local_storage cannot be found.
>>>> + *
>>>> + * void bpf_rcu_read_lock(void)
>>>> + *    Description
>>>> + *        Call kernel rcu_read_lock().
>>>> + *    Return
>>>> + *        None.
>>>> + *
>>>> + * void bpf_rcu_read_unlock(void)
>>>> + *    Description
>>>> + *        Call kernel rcu_read_unlock().
>>>> + *    Return
>>>> + *        None.
>>>>    */
>>>
>>> It would be better to not bake these into UAPI and keep them unstable 
>>> only IMO.
>>
>> rcu_read_lock/unlock() are well known in kernel programming. I think
>> put them as stable UAPI should be fine. But I will reword the
>> description to remove any direct reference to kernel functions.
> 
> tbh I also feel that kfunc is better here.
> Sooner or later we will need srcu_read_lock,
> then rcu_read_lock_task_trace, etc.
> bpf shouldn't be a burden to RCU.

Okay, I will kfunc then.
