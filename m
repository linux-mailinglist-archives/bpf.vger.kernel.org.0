Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEF73D5151
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 04:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhGZB7a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Jul 2021 21:59:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62596 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231205AbhGZB73 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 25 Jul 2021 21:59:29 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q2cduE028228;
        Sun, 25 Jul 2021 19:39:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ae7BeH+nL9WJ4GsTu0UIXk6uQqPby7U5komtBWQ1ma8=;
 b=D6h2wtwlumpHYlQoNQXemHzbEZA4ajjTWp+oHCXysqQLBc2Dmt94S6VaSHgv3QvVIYb/
 k9aom9ZQyfxyh1CZi1XenET2H/XMHMu2Za+BHirvAG2qoPNKlEI1hUAyki3vxb7r5xQo
 XMwNVK1+6VI1OGotYxKVZafps0gMEm28+yI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a0fyy70cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 25 Jul 2021 19:39:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Jul 2021 19:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkhjbKECtTntonZ4VY8saRt1w7EpWn5FM30kdqwCkDCPeEtD/zRLqRL8E0k1pbVnqgDBGZFWmQZgOGg7rTdmT1BXhz9Uq+c6fAG3rweIJFZxrTxXxaF1pWU9NOhYhOktlCfYrKUQrbZC+sTggLkbRvh6YT+zxtZa1XhNIovz5Pj+diRsKjLkgiH9KTe9wj5s4W8JXZui/mOyID8FBUzgufM19SyzikrJw8jakCKsRb978an37h/z8QaapnP1w+bZ4LrHZG6/AhTOBIT+FwkCfJwR+/aoJV+7L58kTagW60wFyAhnHbCq2bmXR8Et8xZoO5Pb+STKtkSzgtGd1Ah3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae7BeH+nL9WJ4GsTu0UIXk6uQqPby7U5komtBWQ1ma8=;
 b=bQGCNjylXVS0JZXtKb7ABGeCIygkzmOGihlSTrP4DIYMbAQ71eVJbHH05akqFvWc9UDXPF4kavB5xfQPfiXHp7zw296OZ+KlhGSalg+jepONY+niCbVGSbVRgTa2VZ0U3ErQLSy2QfUlhbkQzh90BZY9fafNrmXIXBkS2tBQ/xBU7fRmFj8Jl+6u57/4qc612uA5WUSTwJ/9dmS1yurNdU19nVyTTdVsiYh/JsglYGTDA3JAweFsFbgUcj5fyadk0MjB0o278M8S7e7kfECTLYrnnTogZNCEVortx6FysQajcNpas6/+lwUG21cq3CkAcJLsaehT/Hra6sCRTQMtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4223.namprd15.prod.outlook.com (2603:10b6:806:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 26 Jul
 2021 02:39:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 02:39:55 +0000
Subject: Re: Prog section rejected: Argument list too long (7)!
To:     Vincent Li <vincent.mc.li@gmail.com>
CC:     <bpf@vger.kernel.org>
References: <a1ae15c8-f43c-c382-a7e0-10d3fedb6a@gmail.com>
 <CAK3+h2z+V1VNiGsNPHsyLZqdTwEsWMF9QnXZT2mi30dkb2xBXA@mail.gmail.com>
 <8af534e8-c327-a76-c4b5-ba2ae882b3ae@gmail.com>
 <7ba1fa1f-be6-1fa2-1877-12f7b707b65@gmail.com>
 <441e955a-0e2a-5956-2e91-e1fcaa4622aa@fb.com>
 <CAK3+h2w=CO8vvo_Td=w08zKxfko1DA96xk4fvCXvUA1wLZvOMA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e1a2904f-1b43-e1a8-e20d-0449798274bb@fb.com>
Date:   Sun, 25 Jul 2021 19:39:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <CAK3+h2w=CO8vvo_Td=w08zKxfko1DA96xk4fvCXvUA1wLZvOMA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: MW4PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:303:8e::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10b9] (2620:10d:c090:400::5:cf4) by MW4PR03CA0058.namprd03.prod.outlook.com (2603:10b6:303:8e::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Mon, 26 Jul 2021 02:39:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a2cb1bd-a88a-46d8-0c81-08d94fdea6f5
X-MS-TrafficTypeDiagnostic: SN7PR15MB4223:
X-Microsoft-Antispam-PRVS: <SN7PR15MB42233FA5A97A74BA84F53586D3E89@SN7PR15MB4223.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKe1sRzw/Lu2J8Tcqtq82+5pMuwyxT/jgUp0eUVwjPVB/0lkHG3ISIR+8yKlfwXVASQMAdU7RdxHK8mKe0eH1Lt40iqXqyz5JMIKwunZ/Em3adIsuygesFMNOhzKxOGZj7B9TkWa59poEeZw7vueVO0PLafiAYK/rT8sxAqbpESgvPw7X/DT54gsTu36BpDRJ5EyENY/j57pgol5BIQ/gfZMFTETan9xW2ekL6cTjWXrZR3UI6G6Pzre3cSogZ7lR8q6gfnXlS+lkKszJ8Uz8EKSyPWXIXmd2B5qfuHKh4h0JN+AM9QQlbtYZUO4eGk6/U7BYHq1IgEXCMeIUfb4bIL1PKcl7MFb7x2pPyRWQ4+4BhV1JpVk+X7YKVz99R9Ut//pPy14yCmqq/6u6fimx9urfxI4rcAd8Mks/7kyoeAB8qpPmxCSARlkJVnkSoflThaQvjpNJxwFwNYb/jeSZJpOW2e+S6ThVEivq1y+FwiQGc+xgbSRWkUEaGIuLiZaMORmHMO5Gf4hJPXqKKTQMv9GmQmqFeiKceDDOr7q29pepDdewO6psTRCPfEPhqaFpErMFNwlqVMSxNnO+4vCn85Gqp/DtuJiYsRsM5tC2rvIGademfoNf0iDYDCBPcV0/z+a+StBqu1Hg75j0xvuYFAbZHiX94rxTsv4uzxogNAZWYzSSyUY9OGkYoz8kC4W4UCGYRtVI04ZFHHPjzv8bloeaOjLUXZKJfxgghMEXqZVb0MmN26XS9MjBQ2KTKNH+srwQ7wG1EEsBc7bSF4e5JyUNt6yXdSIiBWp6GBb4Ne9o3bu4OCW1eod+QiilGoR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(6486002)(83380400001)(86362001)(8676002)(66946007)(186003)(53546011)(36756003)(4326008)(6916009)(2906002)(8936002)(31696002)(38100700002)(52116002)(478600001)(316002)(5660300002)(966005)(2616005)(66556008)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW0rUGpxUWxkYjV1TUdwdU1ZVXZyenF6V1RmclFiT29oM0syK0xwR2RuMDBJ?=
 =?utf-8?B?cG9GWWpCU0ZBcFV6UFVnbUNEQXNiOXRlSFd0aFV4clByYi82MkplRFI3K0hO?=
 =?utf-8?B?MVZ5Yk9lSG1TWGZkbS9adnowTmx4NVYwb3I0ZUhMZlZIeVZnTXNTcWt4bldL?=
 =?utf-8?B?ZjFGRTdsUjFIa3V5RHlUUGFwRFd3Z08wR1NDY3BSRHdQeE9hR1ZBU2tPcFFR?=
 =?utf-8?B?UzNEQ1VvUmZNTHQ2Nlprd2g4TkpaRmZvYWRsUlZJWjIrRmRHSFVTcVpXOExr?=
 =?utf-8?B?K3J4VU45NUJpTWhOcHlIejNmOThEWEVkN2RFNzdxUm1lVUkrTFVuYmRqcUNw?=
 =?utf-8?B?c3djM0d1TG5veVNPbUxtQWNwVkh0K0x6KzBpRjMxS056SHRKZHF6bURrM2xI?=
 =?utf-8?B?R3FEZUZnanJLZUNvUjYxSE1nbzlYMjZqTXlyY1k1THMzVS9kMkFRc1IzdWJj?=
 =?utf-8?B?dFMyeEpKL0hXMmQ3dExSYzU2ekxyeXhzQVdlZE5POUtXcFVKWndqT2VBaVhq?=
 =?utf-8?B?SWVDMk9UNGI3MElmZkxBOEQxSlhLcXc2TFlEbUhWWlNrQWFPRXlFUUpaUE02?=
 =?utf-8?B?bEZvODFaQks2eHRFQVkxSHJxZC9PMUFNMHRSaVFGdzJSR1h3MlgrdERZUmcy?=
 =?utf-8?B?UWgxbmNhYXBnbDQwck15VzdORUZOYitlSTN6MjlmTXg3WUs0c2xuK01iWjVW?=
 =?utf-8?B?MDBEVTc1QkhQVjBwRVlEWnFRQUk0RStGTi9HY2hXaDdaMEVSbnJWdmc3dW5i?=
 =?utf-8?B?KzN0V1Z2Wm9CY0NXSUphTXJqSzBQVlV4a0JYM3hpK2prMnEvZk9oaFExVVRN?=
 =?utf-8?B?TDQ3Tmx5VVZWVzJ5eDR0c2JuM2cxdVFvNVl6RVRBWWIwam9GRVdEQWZTOW9K?=
 =?utf-8?B?TGxpcHJuQ1RnY3BjaGx1QU5kU2dCNXRNUHNMMWc2LzMzT3Nubzd5bVVLT0N5?=
 =?utf-8?B?Y2hoa2lqRXorVDdwdDd1bHNYSzdwNjdCWUVMQW52Q3Mxc0lJeWx5VlIwaTYw?=
 =?utf-8?B?c0huOU9VOEczWlMrNXhNSmtzaGlhYTdkdU13YUh1aGg4dmtGSk5CV3lYdDdP?=
 =?utf-8?B?TVNSVktwdDFGZlM4ZDFrdTMvZHhEM0tJT0JvbkF2S1VyZGRjckRmWDBPUXYz?=
 =?utf-8?B?bGdBSk5GaCtMMjM2d3IxaHFHY2dRYS9kaUZ6VnVpbDVqd1lPSWxSeFcwWmky?=
 =?utf-8?B?cVROVFhSMnR5eWtOZ1d1SUFtTUZkMXJwV0pOT0ltUW12d1B2cFpEbEdYeUJt?=
 =?utf-8?B?bzFlQnBTcUI0MUYwTGp6blNXWmdlSHZzcldIUlhyUjB4R1ltNmdTUHBOa002?=
 =?utf-8?B?MjNIVnVnV1JWdHkweW5LeUhLVjFhYjR3cTVZNHJ2eHZHTHhoQWFKR0tqakpx?=
 =?utf-8?B?R2h6MWFhYTVzYzBmYzdwekptQWJ2NGtZQkZzR0VRVHJwQjZzTW84Q2Yvdk5B?=
 =?utf-8?B?ZHlIOHpwaC9PTDFpYVMxZDRDTzlaMWdjYWtaUms1NTNPY2k5cXRNbkxDNFBK?=
 =?utf-8?B?SDVNdTdDZHZlelBabHRSQ0RwRHdtVkltSU9Gcm9NZ2hhdm1ablVCblpGZ25I?=
 =?utf-8?B?QjJTT1p5UWJCWWdUSk42SWxWMUZtU3RQYlJkQW9GVURCNEYvU1JSZFRnUEEx?=
 =?utf-8?B?eVNuMHJXQSt1YmFlQVMwSW5YdDUzMTZIM3lCd0J0L2xjSjNjcFVDMTFIRTFV?=
 =?utf-8?B?RVNEUSt3blJuWFBNaVpHZ2dJWEF3WWJHMlpncnVMa3JsYmx4WTZ3eVN0M2JU?=
 =?utf-8?B?UzU0ZDV2TURENlNQWERMMG94VHdSRDdSRU92cEVZMTdUay9LU1NiL2Y2enlU?=
 =?utf-8?B?UEFvazZTN3RwM1ovRVpXQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2cb1bd-a88a-46d8-0c81-08d94fdea6f5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 02:39:55.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfLT75+hA1AmiYU8ETRuRlK/mnBBCXtEmA61pJCDR4o2GHJhUbc3z0VfOXZaleRk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4223
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: HRzwBbqR0s_-YAQHB3VSJWgMYdX8Zhgf
X-Proofpoint-GUID: HRzwBbqR0s_-YAQHB3VSJWgMYdX8Zhgf
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-25_08:2021-07-23,2021-07-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260014
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/25/21 6:14 PM, Vincent Li wrote:
> On Sun, Jul 25, 2021 at 6:01 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 7/25/21 8:22 AM, Vincent Li wrote:
>>>
>>>
>>>
>>> On Sat, 24 Jul 2021, Vincent Li wrote:
>>>
>>>>
>>>>
>>>> On Sat, 24 Jul 2021, Vincent Li wrote:
>>>>
>>>>> On Fri, Jul 23, 2021 at 7:17 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>> Hi BPF experts,
>>>>>>
>>>>>> I have a cilium PR https://github.com/cilium/cilium/pull/16916 that
>>>>>> failed to pass verifier in kernel 4.19, the error is like:
>>>>>>
>>>>>> level=warning msg="Prog section '2/7' rejected: Argument list too long
>>>>>> (7)!" subsys=datapath-loader
>>>>>> level=warning msg=" - Type:         3" subsys=datapath-loader
>>>>>> level=warning msg=" - Attach Type:  0" subsys=datapath-loader
>>>>>> level=warning msg=" - Instructions: 4578 (482 over limit)"
>>>>>> subsys=datapath-loader
>>>>>> level=warning msg=" - License:      GPL" subsys=datapath-loader
>>>>>> level=warning subsys=datapath-loader
>>>>>> level=warning msg="Verifier analysis:" subsys=datapath-loader
>>>>>> level=warning subsys=datapath-loader
>>>>>> level=warning msg="Error filling program arrays!" subsys=datapath-loader
>>>>>> level=warning msg="Unable to load program" subsys=datapath-loader
>>>>>>
>>>>>> then I tried to run the PR locally in my dev machine with custom upstream
>>>>>> kernel version, I narrowed the issue down to between upstream kernel
>>>>>> version 5.7 and 5.8, in 5.7, it failed with:
>>>>>
>>>>> I further narrow it down to between 5.7 and 5.8-rc1 release, but still
>>>>> no clue which commits in 5.8-rc1 resolved the issue
>>>>>
>>>>>>
>>>>>> level=warning msg="processed 50 insns (limit 1000000) max_states_per_insn
>>>>>> 0 total_states 1 peak_states 1 mark_read 1" subsys=datapath-loader
>>>>>> level=warning subsys=datapath-loader
>>>>>> level=warning msg="Log buffer too small to dump verifier log 16777215
>>>>>> bytes (9 tries)!" subsys=datapath-loader
>>
>> The error message is "Log buffer too small to dump verifier log 16777215
>> bytes (9 tries)!".
>>
>> Commit 6f8a57ccf8511724e6f48d732cb2940889789ab2 made the default log
>> much shorter. So it fixed the above log buffer too small issue.
>>
> 
> Thank you for the confirmation, after I remove 'verbose' log, indeed
> the problem went away for kernel 5.x- 5.8, but the
> "Prog section '2/7' rejected: Argument list too long.." issue
> persisted even after I remove the "verbose" logging
> for kernel version 4.19, any clue on that?

No, I don't.

You need to have detailed verifier log. In verifier, there are quite
some places which returns -E2BIG.

> 
> 
>>>>>> level=warning msg="Error filling program arrays!" subsys=datapath-loader
>>>>>> level=warning msg="Unable to load program" subsys=datapath-loader
>>>>>>
>>>>>> 5.8 works fine.
>>>>>>
>>>>>> What difference between 5.7 and 5.8 to cause this verifier problem, I
>>>>>> tried to git log v5.7..v5.8 kernel/bpf/verifier, I could not see commits
>>>>>> that would make the difference with my limited BPF knowledge. Any clue
>>>>>> would be appreciated!
>>>>
>>>> I have git bisected to this commit:
[...]
