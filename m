Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD465DACC
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 17:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbjADQ4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 11:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbjADQ41 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 11:56:27 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98FD4768E;
        Wed,  4 Jan 2023 08:52:06 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304Cdm3r009644;
        Wed, 4 Jan 2023 08:51:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=tcmRlgM46uOELEv5FEyn+iXg5retNIv0HLVj3jq3WhA=;
 b=mX+zzFe0ljxbRDTWCo2k+mhsbi6eDwI8yLyJhVU4anEP9cWyyNpHtQWBRBk4Mc8tjQj4
 DV1x6S6yN19bkjk3VR40uTqhr0eCL2rtIXaNWHr/TdBgCH7OBPv9VyOTX58vM09HAYBz
 Wwe8XdX/3Md+IlW5NcD8r3SLaiqbdjKaTkH8KW9jwXuGOT0mnXID2IBve5cTpER3dyXk
 VYRJPBNut9585C7hashbh/neoobsZSSXWUSBKHzTIyaM3WtcjS0adaUymmawTw+iieMi
 HtAO4j4PYtHVWyDqAPnCMwhCNrTLluwVWU9R0R3xJWqK61Et2VgAWESAX+/IrsYpXUfc EQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mvwv0n7s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 08:51:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEk0r85dVYTRWxLJVHe+cpQdXzsCgrjY8WtiP8R84vS13nI/3QnVzqApR9Mj+FK1lEAQIY7MggeJx4k9CzGhZpf+HO05nuKlrPIKYioC6rznoukN/cXCPs7c1+qRBGXQ1vczbXwQTkxfshyiweWm6UdAHiUS/s1kOCFftHV/YVXyEsHrjjDOtqkOeK7PjPD9Uyhy+Ce+cRHW/bajdSjbzvm4o2HYvQDXJd1SMANEkt2BDz1FzvIAFnhxULgO2z8jD1tdKEKAciRsKiZasocMPY6nHZo8Oz0Gx8c5yiuMadibXFLabF9s90FzVPAlu/cvpLW1iQpCLJVhN8KyB5eNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtlg5MM6n16OcLLShnzxiND24IsyKRajcwsvIjj9G4A=;
 b=Na7FtHUsr9xX99kFe+WIs0KWdFXpXOCsDyMsEAY8bS7kXCYeJDoue5v1JNtqDD+yrQcWg4Hku+BQyjBMpcG62dOW/JMLH+61+7eS3oH2jVQMVdzQcUWiW8DK1CAcXEXplhZcLyMM9kiQlI+I79b1L84iNdU4C9Ku/1qHIfSoyPqTpCkXmTfq5kAqAEyYMUFg7guTD5DpDsaIPBdDt91/NSlQWGLG+Dk+jQlbk5kwH+4XSY48nfF0m4aF9YvjafUcQP6+pFPXoVQT4Mt/WdXVB/5jmXyvf6jSWzf8tgawg9Pefomcz/M8ooAHBEd5ePkEqzilik4oUjI0Y1i52cUqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1291.namprd15.prod.outlook.com (2603:10b6:3:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 16:51:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 16:51:41 +0000
Message-ID: <7137c191-49c6-7f57-95bc-ee15c7af3c28@meta.com>
Date:   Wed, 4 Jan 2023 08:51:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: WARNING in __mark_chain_precision
Content-Language: en-US
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
 <44be9647-0208-beaf-130d-92a036c95d04@meta.com>
 <0A63A5B8-DD57-4A8E-BC40-EF112F691E6A@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <0A63A5B8-DD57-4A8E-BC40-EF112F691E6A@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR15MB1291:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9e22b5-9239-4b18-7c94-08daee73f46f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rccnJhgKxjgDQnfQ8fBv4JZhIkELcxfxoRnHJZb2e0m3lfUCwYdGskr418wdkwRpXiCMU5MkvlQj+xsisP73Kqts/9EFoC82wQW45PFcxJE+DVTmnG6bJJT3zV2qKnYOEITsWDghtAJsOyIrpiz3bIA/XFEVkRCxxSQp3wO1AA0oAkFyToP6KtZc9O9QE/DJOX8EKL81FfOkPk/+ngkiYh0xPAY2XPrdEFj3NpUUTLCKSRBCeMb2V5OVwTBEwPxSzIopAYnaIdQbNNnzWkcXPz7DKGn4g4Hc01VGtLvC47EHAfdpVVzDUjeK8u8VKtyhBTaetN//SfOAKUuss11H0sHeOwkL6Q2zdoMDU41U/FrDNnA7Q+NXh/dMm5psIhIgyjkzTJxqz7iuNJH/RLNeAVZjAMfC7jSmjtPs8zvkuvIkrXMw+IL8Z3+efT0ro8xt//N7mizXECrBghQzfVdTRKEfX50dTcJ6ilG+BrZqAncy6hM9CM+vCHPM1w686NsnLx6DUcy4QiZjIhuIVmKvvmd4q1mTUtjfNfeQvGi+3YJVxKO1EMkkXIUwtzgd3frnkWSHGU9Rd8ur8c8gzSWy+9no/WkepBkuySUg1F/IYJ8uMHpOv2Y3oSKcfAFd/RT9OwJtLGePQijGG0FIH8wNJ96mU1yX8rUDOSWa0Ixtjgk1KsFQiSo8ABO8IxpVDT3HNCdcgbg3T6ogTo5Pe9U9fK8CWKuPh3t4j3ghrDPMyoRTBUHG08QiA2myOvHIZYO8YuvtWDkJDHM0fRFv8xOwb/YyhyJHXCH7iHQDLpIpYB1kiZYtYlwvbkBXnoAC+KQKYfCPsHHbVw8JTvQu9SW9sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(7416002)(5660300002)(2906002)(30864003)(8936002)(4326008)(41300700001)(8676002)(478600001)(66556008)(316002)(54906003)(6916009)(66946007)(31686004)(966005)(66476007)(6486002)(186003)(53546011)(2616005)(6512007)(6666004)(6506007)(83380400001)(38100700002)(31696002)(86362001)(36756003)(10126625003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDJ4TnNqVzJwcVdMclBLUUk5MXZXV2hiKzA5YWRDdWxyUmx4STdPZzlyR2tP?=
 =?utf-8?B?M29mYmxTUk9RU3pRMlpvcUtRa0xaTEtqWXhzdzNBWnpmcDVTRkxCZitCOGx4?=
 =?utf-8?B?Sm1vNUk0VW43dzRhR1Ruc3pDL3BVWGZRVHp6ZXAydEo0eHF1MGQvbnBWVTh0?=
 =?utf-8?B?b2pHRlFSeFAxZjhOSjBvWjlYdmEvWWlleHFKM2dDYktlVEh4bDNkY2FkdGVX?=
 =?utf-8?B?aDZNQVlJaE9KWUVXMHpGei9wZ0xxZ2VORUFKMnJkdzRodU0yNjFxZ3pmdlgx?=
 =?utf-8?B?WEo3VG10Y3dvWEIzdzBGZE02c2lPcnAyWEJaZ1owNlE4Z0JNclVLQW9paHRw?=
 =?utf-8?B?THU1UjZhWmQ1S3Q2ZG5ZSmFNK05KeVlLdG9NVEFFYVZBbExLVTRrY21JZEs3?=
 =?utf-8?B?UkRTdnYzOTBUQ0JUKy9tUnU3TzhDdXJoZm9oenRldGdwZmMzcms2cnR3SjRN?=
 =?utf-8?B?OFNGU3VPNEZ0L2l5YkdxK2xoaXVRLzFWVUJBUlBuVEpGN1JXNjh5cks1NUNn?=
 =?utf-8?B?bFdzbjVSaVUwL3FPeXJOamlWYzMxSUNUdFhiUDA5M1ZVWXlVZGs2amJ5MWlR?=
 =?utf-8?B?dkE2YUNYZHhQVW1HbWMyZmZtNkIwYVdHM2s5ZTNWUnNuMTAzcEtBM1FQOTZU?=
 =?utf-8?B?REptR2wvS3JGWFU1ZCs0cTJFajdKK1hNOFpOU2ZDbWY3YVc5NmQyR3psUS83?=
 =?utf-8?B?WWMyM092dlh6TldOZTNSeVJrSVJuK0xGQUU2Y2pGazBzQ0hzcmhzTjE4a0tm?=
 =?utf-8?B?cWVHOU1UZGR5NnFZa1h2Zno2SUd0ci9IMEtaMHI3VlVsd1lVZHNxdzhEbnJF?=
 =?utf-8?B?Skx6WTliVGVqZTFIU1F6OGoydHdBUnhabkNJL1VlaWF0UVY0Y2ZSanE5SVhs?=
 =?utf-8?B?TndJbXRHOTFxOU1sNXRGMVROSjhsSTVFdkhqS3dnVE9abHpqWG5vNkMwSUE2?=
 =?utf-8?B?MjhFWHNYWE5EUllWSkorTjFRYTc5czE4VWU4NVhOSytHV1lqNy8vSlJMSFlr?=
 =?utf-8?B?bUFDVlM4OWQvVGhzWXhaOW56RlZtdlBWOTRab2VQeldVNDdQL20wQ2JGVGp5?=
 =?utf-8?B?a1FsRzE0MTlvT0RrOUZNQ0tUdWR3SHMva3dEc0lkRjR1dTRySWpSY08wdzZt?=
 =?utf-8?B?S0d4OFV5d0NrSTlFODZzVGc3VDNwTnppdi9XWkJGamNVOWtqdXY4a3VkRE9Z?=
 =?utf-8?B?emZYbVQ1UXZheklWeWxTdWVJOXFRL05oQ0NEVzQ5bU5QM2JQRjk3cXBBVVBJ?=
 =?utf-8?B?RjkzVXJUREZSTEZrQzJpY2ZYNXhWWi9qd3FhQ2piMDQzZDErbjJTS0lBbzR0?=
 =?utf-8?B?ZWhGclhLcVpsbTFMY3hwOWxiT0grc0RqeG5XSmFVU2k5anB5aWpWc0tiVzRB?=
 =?utf-8?B?K3JXTHZkZGhLSGE2QVBBVjlOZm93V0dnZXJPUWZqVTViTVhBR0Q5UnJTZGZ3?=
 =?utf-8?B?RkF4cHVtU1pPelJpRllVcnNJZ2lqM1dYYm9LTFlmSW9Ybk9Na2pIM3NKcTB2?=
 =?utf-8?B?dVI3L0hQQTdjTEh1TnptTjhLQWdjeFEvN3RrOTlCYTIwRThVM2sydno0Zlg3?=
 =?utf-8?B?YXJmVm9ZMlJDR0FGdXpXZEplM0I0SFFERk5tRnlOeHI4cmZsU1NlcVE0allt?=
 =?utf-8?B?R0tUWEpCN0ZEQ0xkZGU0QVZVM3hqTDRqNmVUZG15YVdZcmJ0QnIvTDRTZ0NN?=
 =?utf-8?B?ZXlhRkNnMjA4NVBhREI1OTd2V0R6djlBNWwvVmM5cHJyRWJGRGlSbm9EY2pu?=
 =?utf-8?B?b2pVTVVob0RSTndmK2FyTEVFWHNZUFRFMEVwRGhuWG9DNE1sc2E4SGxDMnp0?=
 =?utf-8?B?WVZxQjlMbW1RdndaZ0JSajdQbWVNTzlGU2RBQWZjcjAwU1puZjJJcTBVSWxx?=
 =?utf-8?B?M0NLRG1JbGZLUFR0dUZXcFZKVlVkNmlONkNBM1R0QVJxN3NuL1dEdXVDdkFB?=
 =?utf-8?B?anBOR2VBNytZSHllOXpsbzRwWDc4OVZHNmxxa3hHT0d2cUh0enhBUW9lWUVI?=
 =?utf-8?B?WXJ0MFdObzVZdnU2bVpnd1lpeldxYzhJeTVNaGprWk5jQXI0bzZ6aFFvZXZO?=
 =?utf-8?B?QTVQV1NMbzlocDBUQU1ueVM0d0t5Q2lWZ2U3Qy9lbjBlYUxIN1l6SERGdHpw?=
 =?utf-8?B?eWxiTE9nbDBGUjlJc3MvcSswMW5nWVhNZlZWaGJ6SGdQZHhUVlB3OGsyVEdB?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9e22b5-9239-4b18-7c94-08daee73f46f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 16:51:41.7661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7/WgDdvBhZyuJrEOAB/0+/haQH6daYIsD2A9+Mt5+PRG4ZC+YXvweEI/FDAR825
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1291
X-Proofpoint-GUID: UiPCa2-hhNEjDo0ZE42zvxgj6QVqbcUu
X-Proofpoint-ORIG-GUID: UiPCa2-hhNEjDo0ZE42zvxgj6QVqbcUu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/4/23 12:52 AM, Hao Sun wrote:
> 
> 
>> On 4 Jan 2023, at 1:47 PM, Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 1/3/23 10:27 AM, Alexei Starovoitov wrote:
>>> On Mon, Jan 2, 2023 at 1:42 AM Hao Sun <sunhao.th@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> Yonghong Song <yhs@meta.com> 于2023年1月2日周一 03:20写道：
>>>>>
>>>>>
>>>>>
>>>>> On 12/30/22 1:44 AM, Hao Sun wrote:
>>>>>>
>>>>>>
>>>>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> 于2022年12月30日周五 06:16写道：
>>>>>>>
>>>>>>> On Tue, Dec 27, 2022 at 9:24 PM Yonghong Song <yhs@meta.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12/20/22 4:30 PM, Andrii Nakryiko wrote:
>>>>>>>>> On Mon, Dec 19, 2022 at 11:13 AM <sdf@google.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 12/19, Hao Sun wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>>> The following backtracking bug can be triggered on the latest bpf-next and
>>>>>>>>>>> Linux 6.1 with the C prog provided. I don't have enough knowledge about
>>>>>>>>>>> this part in the verifier, don't know how to fix this.
>>>>>>>>>>
>>>>>>>>>> Maybe something related to commit be2ef8161572 ("bpf: allow precision
>>>>>>>>>> tracking
>>>>>>>>>> for programs with subprogs") and/or the related ones?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> This can be reproduced on:
>>>>>>>>>>
>>>>>>>>>>> HEAD commit: 0e43662e61f2 tools/resolve_btfids: Use pkg-config to locate
>>>>>>>>>>> libelf
>>>>>>>>>>> git tree: bpf-next
>>>>>>>>>>> console log: https://pastebin.com/raw/45hZ7iqm
>>>>>>>>>>> kernel config: https://pastebin.com/raw/0pu1CHRm
>>>>>>>>>>> C reproducer: https://pastebin.com/raw/tqsiezvT
>>>>>>>>>>
>>>>>>>>>>> func#0 @0
>>>>>>>>>>> 0: R1=ctx(off=0,imm=0) R10=fp0
>>>>>>>>>>> 0: (18) r2 = 0x8000000000000          ; R2_w=2251799813685248
>>>>>>>>>>> 2: (18) r6 = 0xffff888027358000       ;
>>>>>>>>>>> R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
>>>>>>>>>>> 4: (18) r7 = 0xffff88802735a000       ;
>>>>>>>>>>> R7_w=map_ptr(off=0,ks=156,vs=2624,imm=0)
>>>>>>>>>>> 6: (18) r8 = 0xffff88802735e000       ;
>>>>>>>>>>> R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0)
>>>>>>>>>>> 8: (18) r9 = 0x8e9700000000           ; R9_w=156779191205888
>>>>>>>>>>> 10: (36) if w9 >= 0xffffffe3 goto pc+1
>>>>>>>>>>> last_idx 10 first_idx 0
>>>>>>>>>>> regs=200 stack=0 before 8: (18) r9 = 0x8e9700000000
>>>>>>>>>>> 11: R9_w=156779191205888
>>>>>>>>>>> 11: (85) call #0
>>>>>>>>>>> 12: (cc) w2 s>>= w7
>>>>>>>>>
>>>>>>>>> w2 should have been set to NOT_INIT (because r1-r5 are clobbered by
>>>>>>>>> calls) and rejected here as !read_ok (see check_reg_arg()) before
>>>>>>>>> attempting to mark precision for r2. Can you please try to debug and
>>>>>>>>> understand why that didn't happen here?
>>>>>>>>
>>>>>>>> The verifier is doing the right thing here and the 'call #0' does
>>>>>>>> implicitly cleared r1-r5.
>>>>>>>>
>>>>>>>> So for 'w2 s>>= w7', since w2 is used, the verifier tries to find
>>>>>>>> its definition by backtracing. It encountered 'call #0', which clears
>>>>>>>
>>>>>>> and that's what I'm saying is incorrect. Normally we'd get !read_ok
>>>>>>> error because s>>= is both READ and WRITE on w2, which is
>>>>>>> uninitialized after call instruction according to BPF ABI. And that's
>>>>>>> what actually seems to happen correctly in my (simpler) tests locally.
>>>>>>> But something is special about this specific repro that somehow either
>>>>>>> bypasses this logic, or attempts to mark precision before we get to
>>>>>>> that test. That's what we should investigate. I haven't tried to run
>>>>>>> this specific repro locally yet, so can't tell for sure.
>>>>>>>
>>>>>>
>>>>>> So, the reason why w2 is not marked as uninit is that the kfunc call in
>>>>>> the BPF program is invalid, "call #0", imm is zero, right?
>>>>>
>>>>> Yes, "call #0" is invalid. As the code below
>>>>>
>>>>>> /* skip for now, but return error when we find this in
>>>>> fixup_kfunc_call */
>>>>>>   if (!insn->imm)
>>>>>>   return 0;
>>>>>
>>>>> The error report will be delayed later in fixup_kfunc_call().
>>>>>
>>>>> static int fixup_kfunc_call(struct bpf_verifier_env *env, struct
>>>>> bpf_insn *insn,
>>>>>                              struct bpf_insn *insn_buf, int insn_idx,
>>>>> int *cnt)
>>>>> {
>>>>>          const struct bpf_kfunc_desc *desc;
>>>>>
>>>>>          if (!insn->imm) {
>>>>>                  verbose(env, "invalid kernel function call not
>>>>> eliminated in verifier pass\n");
>>>>>                  return -EINVAL;
>>>>>          }
>>>>>
>>>>>
>>>>>> In check_kfunc_call(), it skips this error temporarily:
>>>>>>
>>>>>> /* skip for now, but return error when we find this in fixup_kfunc_call */
>>>>>>   if (!insn->imm)
>>>>>>   return 0;
>>>>>>
>>>>>> So the kfunc call is the previous instruction before "w2 s>>= w7", this
>>>>>> leads to the warning in backtrack_insn():
>>>>>>
>>>>>> /* regular helper call sets R0 */
>>>>>> *reg_mask &= ~1;
>>>>>> if (*reg_mask & 0x3f) {
>>>>>>       /* if backtracing was looking for registers R1-R5
>>>>>>       * they should have been found already.
>>>>>>       */
>>>>>>       verbose(env, "BUG regs %x\n", *reg_mask);
>>>>>>       WARN_ONCE(1, "verifier backtracking bug”);
>>>>>>       return -EFAULT;
>>>>>> }
>>>>>
>>>>> The main triggering the backtrack_insn() is due to
>>>>>
>>>>>                          } else {
>>>>>                                  /* scalar += pointer
>>>>>                                   * This is legal, but we have to
>>>>> reverse our
>>>>>                                   * src/dest handling in computing the range
>>>>>                                   */
>>>>>                                  err = mark_chain_precision(env,
>>>>> insn->dst_reg);
>>>>>                                  if (err)
>>>>>                                          return err;
>>>>>                                  return adjust_ptr_min_max_vals(env, insn,
>>>>>                                                                 src_reg,
>>>>> dst_reg);
>>>>>                          }
>>>>>
>>>>>
>>>>> unc#0 @0
>>>>> 0: R1=ctx(off=0,imm=0) R10=fp0
>>>>> 0: (18) r2 = 0x8000000000000          ; R2_w=2251799813685248
>>>>> 2: (18) r6 = 0xffff888100d29000       ;
>>>>> R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
>>>>> 4: (18) r7 = 0xffff888100d2a000       ;
>>>>> R7_w=map_ptr(off=0,ks=156,vs=2624,imm=0)
>>>>> 6: (18) r8 = 0xffff888100d2ac00       ;
>>>>> R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0)
>>>>> 8: (18) r9 = 0x8e9700000000           ; R9_w=156779191205888
>>>>> 10: (36) if w9 >= 0xffffffe3 goto pc+1
>>>>> last_idx 10 first_idx 0
>>>>> regs=200 stack=0 before 8: (18) r9 = 0x8e9700000000
>>>>> 11: R9_w=156779191205888
>>>>> 11: (85) call #0
>>>>> 12: (cc) w2 s>>= w7
>>>>> last_idx 12 first_idx 12
>>>>> parent didn't have regs=4 stack=0 marks: R1=ctx(off=0,imm=0)
>>>>> R2_rw=P2251799813685248 R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
>>>>> R7_rw=map_ptr(off=0,ks=156,vs=2624,imm=0) R8_w=map_ptr(off=0,ks=2396,v0
>>>>> last_idx 11 first_idx 0
>>>>> regs=4 stack=0 before 11: (85) call #0
>>>>> BUG regs 4
>>>>>
>>>>> For insn 12, 'w2 s>>= w7', w2 is a scalar and w7 is a map_ptr. Hence,
>>>>> based on the above verifier code, mark_chain_precision() is triggered.
>>>>>
>>>>> Not sure what is the purpose of this test. But to make it succeed,
>>>>> first "call #0" need to change to a valid kfunc call, and second, you
>>>>> might want to change 'w2 s>>= w7' to e.g., 'w9 s>>= w7' to avoid
>>>>> precision tracking.
>>>>>
>>>>
>>>> The purpose is not to make the test "succeed", the verifier temporarily
>>>> skips the invalid kfunc insn "call #0", but this insn triggered a warning
>>>> in backtrack_insn(), while it is supposed to reject the program either
>>>> due to insn#12 32bit ptr alu or insn#11 invalid kfunc.
>>>>
>>>> Maybe something like the bellow, after applying the patch, the reproducer
>>>> is rejected:
>>>>
>>>> func#0 @0
>>>> 0: R1=ctx(off=0,imm=0) R10=fp0
>>>> 0: (18) r2 = 0x8000000000000          ; R2_w=2251799813685248
>>>> 2: (18) r6 = 0xffff88817d563000       ; R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
>>>> 4: (18) r7 = 0xffff888171ee9000       ; R7_w=map_ptr(off=0,ks=156,vs=2624,imm=0)
>>>> 6: (18) r8 = 0xffff888171ee8000       ; R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0)
>>>> 8: (18) r9 = 0x8e9700000000           ; R9_w=156779191205888
>>>> 10: (36) if w9 >= 0xffffffe3 goto pc+1
>>>> last_idx 10 first_idx 0
>>>> regs=200 stack=0 before 8: (18) r9 = 0x8e9700000000
>>>> 11: R9_w=156779191205888
>>>> 11: (85) call #0
>>>> 12: (cc) w2 s>>= w7
>>>> last_idx 12 first_idx 12
>>>> parent didn't have regs=4 stack=0 marks: R1=ctx(off=0,imm=0) R2_rw=P2251799813685248 R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0) R7_rw=map_ptr(off=0,ks=156,vs=2624,imm=0) R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0) R9_w=156779191205888 R10=fp0
>>>> last_idx 11 first_idx 0
>>>> regs=4 stack=0 before 11: (85) call #0
>>>> regs=4 stack=0 before 10: (36) if w9 >= 0xffffffe3 goto pc+1
>>>> regs=4 stack=0 before 8: (18) r9 = 0x8e9700000000
>>>> regs=4 stack=0 before 6: (18) r8 = 0xffff888171ee8000
>>>> regs=4 stack=0 before 4: (18) r7 = 0xffff888171ee9000
>>>> regs=4 stack=0 before 2: (18) r6 = 0xffff88817d563000
>>>> regs=4 stack=0 before 0: (18) r2 = 0x8000000000000
>>>> R2 32-bit pointer arithmetic prohibited
>>>> processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
>>>>
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 4a25375ebb0d..abc7e96d826f 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -2743,6 +2743,9 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
>>>>                          *reg_mask |= sreg;
>>>>          } else if (class == BPF_JMP || class == BPF_JMP32) {
>>>>                  if (opcode == BPF_CALL) {
>>>> +                       /* skip for now, should return error when we find this in fixup_kfunc_call */
>>>> +                       if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && insn->imm == 0)
>>>> +                               return 0;
>>> Makes sense to me. Please submit as an official patch
>>> with s/return 0/return -ENOTSUPP/
>>> Also 'skip for now' isn't quite correct here.
>>> In check_kfunc_call() it's correct, since invalid kfunc with imm==0
>>> could be eliminated during dead code elimination,
>>> but since we're walking this insn here in backtrack_insn
>>> the dead code elimination is not going to kick in.
>>> So it's surely invalid kfunc call if we see it in backtrack_insn.
>>> The comment should probably be something like:
>>> /* kfunc with imm==0 is invalid and fixup_kfunc_call will catch
>>> this error later. Make backtracking conservative with ENOTSUPP. */
>>
>> Do we have the same issue if we have
>>    call #1 <or some valid kfunc>
>> instead of
>>    call #0
>> ?
> 
> Seems no. If that happened, then, it’s another bug. Because as Andrii commented,
> the prog should be rejected due to !read_ok before backing track to the kfunc
> call. In this particular case, the invalid kfunc call is skipped without marking
> Regs as uninitiated so the verifier incorrectly backtrack to that invalid call.

Make sense. Thanks for double checking!
