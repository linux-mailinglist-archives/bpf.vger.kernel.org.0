Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFDC3E9BE9
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 03:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhHLBYE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Aug 2021 21:24:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64090 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229948AbhHLBYE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Aug 2021 21:24:04 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C1C2Hb030368;
        Wed, 11 Aug 2021 18:23:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Aw1g98iBvd3zAhxda3F/mUPp+svkVWJESH6r8nx9y5s=;
 b=bi7VWvZvzyAWmOzw2JdLqlpaNYrX0iR3iBcACxIroQUJzQT0onZjfcSbKhc9TavFzTgg
 7edzXfBrA+b05yZWFf9djYQzSDT27SeJLTqDdYibkPgY9C3NJYzhnu/+AEfOkqLt02H4
 d+2AbPgnWbvC7WpJQOKPH6A1f8ixHfRuzXU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3abyqx0w68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 18:23:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 18:23:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbnrnZvgYjeWZZXvd19wCCSRhog1ZvE0lITospl/OWAG2wLHfbCx6TZfx8sre6SBMJiHN1FxPrv201RyelJOnXOsSOAzArJMFJIyQPyphOQfyZA/dxzclpzyBf32KEwoY551L6ZnrD7gaE0sCArA4BzL0zK2gAn1YmVBbb4XFjbruQGaxZjwdIArolRWgbOSo5SpRf1m1PVsKBP1tOe/VZRg8TYY9wAh7sBor0SMyCx8ICH06tie1sbxvgamakEx2M84WixVyg9jUj7c6nuRtHAs0Cb9cmZNwzs9GG+5Yj5BJSuoQQ18NJSHYKZ+dXTPEdvPUp0cUsfu8xCKiuVqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw1g98iBvd3zAhxda3F/mUPp+svkVWJESH6r8nx9y5s=;
 b=Poks8APqF3CESCLSMkoUABCmnrJNt2wCme20lTvVKa0rPVsZp89J4cr7gbjpplLQAPvMbMBO7v+GpvLWk3CM2CtSwI6qvbKo3SB0DS6qdF77AJRj4+gP/SEXL0+8gg5speSHPqwnp0T8mV1+dPOp4KoG0AxODkHLAou9rJoAiruaVxDVxECabb+wd6WlJcMAY+wllG2jB536FsHpP0Q0QsEnzxVlPLaOJgERaFlK7Uh2mPo6UbmR9ApWARxDESsh/ZrVul8blAcUBlW1DnuMiKW5YNV6eFbuYl0colBcGrcXUuKe8YYMQcpPDLJ7PIGnsRAcUljl+eeqbUAR7d8A8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: lambda.lt; dkim=none (message not signed)
 header.d=none;lambda.lt; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2286.namprd15.prod.outlook.com (2603:10b6:805:1f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 12 Aug
 2021 01:23:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4415.016; Thu, 12 Aug 2021
 01:23:33 +0000
Subject: Re: R11 is invalid with LLVM 12 and later
To:     Paul Chaignon <paul@cilium.io>
CC:     <bpf@vger.kernel.org>, Martynas Pumputis <m@lambda.lt>
References: <20210809151202.GB1012999@Mem>
 <a40405b0-3856-9d15-f973-ffae2e853384@fb.com>
 <d1054971-0cd5-5698-c895-f412d1b47bb2@fb.com> <20210811165446.GA30403@Mem>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <48b75f06-cd5b-532d-33cd-6910fbe239f1@fb.com>
Date:   Wed, 11 Aug 2021 18:23:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <20210811165446.GA30403@Mem>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1a7b] (2620:10d:c090:400::5:b81f) by SJ0PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:33f::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.7 via Frontend Transport; Thu, 12 Aug 2021 01:23:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93ba71f8-0775-44d9-b197-08d95d2fcce4
X-MS-TrafficTypeDiagnostic: SN6PR15MB2286:
X-Microsoft-Antispam-PRVS: <SN6PR15MB22860C17DBEC55C1BF192FF9D3F99@SN6PR15MB2286.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwy2Jya3FklFJIHdWie/L8rWGXVlj4LzEbTa7w5QSuED0uaQnCUkGYkYdMY6ZJnpDKCUcqOb6DM5/JXAwTDG4+omn48lp9Qt8s+Dr4i8mJ7WlLyDVdvjJEaZqGIZIn1GjXVCPmP5vN98L//ZnX23WjkZpIRLLzUJ16fOkl5FCdUrOZaBjpdnUQCD7a/A5hiSUYqyfq+kF0s56WSTcz6vGTPvuCn2/3nzb8xdw5zo89xSTYd+MtqZJLJ44zw6LcHb7eQpVSUYhYGZXd+MokjFpM32hVWYiIT5Vra6aAMbW+CoIQ+fhkpVHCesOxi6dW4canaeUvTtFcbKNS0aNBhCY69WvQzvJOGY1ZgAcFcnk0GUoVzwVqPoj6aDHj+UMbaSwjGC2NtaJ6lf1jnUJTCsUNJU8fusR8z28/vvFZjbRNGTimcARRxDKQlYws2UEtVRO90Gy1GENK9gS0xXTbyS+eVnrHSexX7w5qwTdqBL+lps3APWdFCsg1xp6z7Sv5voZnKUwAV1KkCooyJXEkrMAap+DTbB723s6wAmGtI0mFobExIgNnH08nHqTi5hqrERTaaaMtMnLvmMBXxP1ZLKLaOQdKysZm/kwXmgDotSUUzu0eVofUizpNfnmkCirnIvRooKJN64h20tMpUw3zUIhCmXAa2CzX1Sq6uNCXDl3+EeSwfsnsp7IEbfLE/4mWYEjpy77uy0fIQdvPcWWXKRA7ABN6Gn77CDHYLjrowAy91LLWV34ERWOtvXV/pjBv20qUP7T9UbICYuY3plCTZNRKGjB/2wm0yTuPMs/BhdmpGst0Id5+dxgV7p47eboROf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(2906002)(38100700002)(966005)(6916009)(66946007)(53546011)(66476007)(31696002)(5660300002)(4326008)(31686004)(66556008)(36756003)(478600001)(52116002)(6486002)(8676002)(316002)(186003)(86362001)(8936002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXNOQXNjMnBjUEpCZ2xIcm44SlNRU2FGeEZPMTlwc3BSdUNvNU8rSVhDelFj?=
 =?utf-8?B?S2o4Q0xiZHQ4Q2luTG5TVmlLTmZrYlR0eFBhcXp5QXRmcVJtdEM1K1FEYnp1?=
 =?utf-8?B?MXU0L0hoUytqRE1IbzVaM0kxWmVnUnBmVllLTjBRdU9NVGxkN1pROGNkb0Z4?=
 =?utf-8?B?QU04UG85NTM3c1hJcUpUZDlMWCt1elEyTEtyK0tGbXlKaGwvbzlXRE83Lysz?=
 =?utf-8?B?MitXR1daaEhxY0pVNDAwaktRQmZXMGFycTJpdWkyN0xSTHFKaTNSd004SXBj?=
 =?utf-8?B?NWgwQ3RDajFQamJKeHVIZmltUm9xZkNUcmI1TG5sZVBVcGxXZWpMaUdIZjhr?=
 =?utf-8?B?eGRHY01FSXVyRUFFdUk4SUVLL2pPWmdMSWg4M0FFZnBlVGJtOC9pZ1RoYTM3?=
 =?utf-8?B?MjluQmZIVkk5c1d5YlpEaHdBOWJWdCsrcDl6dGZxNk1FUGhDQnNDWmVCbFVE?=
 =?utf-8?B?Tm5pdS9lZTFXOUJkQ29sRDc1NXN3endLMGtjSHRSR3BYQWpBMnlOT0xmdEpp?=
 =?utf-8?B?RjE0WTJ6MXJTTE9xM2ZtYjJjMFBJdWFIQXoxSjFlaWxWUmFDclp2eFQ4Wm80?=
 =?utf-8?B?K1p4ZzJWdnBxZHZqWjFWbm1oM3h6eDY1R2pDQk1sYVRYa2paTEZNWjlRdWxW?=
 =?utf-8?B?RXFOM0d4MU1QSzlnQ0tnSktjZ2dSU0VQMnhCbjUwK1NCOXo1ZjV0eHpwamNx?=
 =?utf-8?B?cGdYYVhDU3lrOVg2eENaaVlVaGJYQ2pxZ1dlUmV1Nzc5QTR5aUJzODl0UWZU?=
 =?utf-8?B?eEtXNXluU2ZmS3EzcWgxN3o0UU93U29qMDB3MjFhamVRalNqUTR2MVlkUkR4?=
 =?utf-8?B?MkNqZisvTElTemd1cnIrSE5jMk9aZUl6Ymc2MnRWYlVFSFR2cTVjcVBmQUpW?=
 =?utf-8?B?SjBpc01OVjIxam9aelJZQS9FZm9oKzY1YncxUmxrME42VzlLK1F1M2UzV2RC?=
 =?utf-8?B?V0w4YUpXbFFCSzdxakdNOTNRbElzSVNVL0NtaU9Fb3VNZmRtZUJNYjZ5Tjd1?=
 =?utf-8?B?Ump1S044RjJkWk1Scms5eUZYVW80OG1wWlUxU2VNbnZ3U3hJZEVueHdLL0lI?=
 =?utf-8?B?S3EwUlB4QW8rcjE0UUYyRVBEV2xGNFRXbWtxN1c5ak5WbjJ3ZnEvZnVOTTda?=
 =?utf-8?B?TStiQStkdDRMeG9JcW9CVnRPdkl2eHoyUUZCQXVFdEVVajA4c05iWEFmcGpN?=
 =?utf-8?B?Q3pQdmhpbkxBNGFCQzNXUVJQS29yZWxRcWxrMVZ6MlphNVcxUm9XS2ZJZXNV?=
 =?utf-8?B?Vm1XNVVUaGcwV3BPZDhBL2RPNWFPenZYYVdrWGFydndGUFV5azVLZEpCVHgv?=
 =?utf-8?B?cE12cU1KSktnOW8wRHNEdjcrQ0JiUVErZWl2Z1czS2J2VmtiWnlmTUlCdFZC?=
 =?utf-8?B?Qk44NXVjRGZZUHo1MnFtd212U3BOdWZSOWJaZkJuODg2eXpVYVgrRkRaN2ha?=
 =?utf-8?B?eGFnb0RoVnZkeU1yTmRzTlIvQWtDR2pFWFNzZHphall6UE1tSUJKSnpuQUE3?=
 =?utf-8?B?dDNJRWU1MjhJZHZzQ0xnNFA5UTd1aGJ3dGZzUmI0N29VSzZZVSs3TGtjVTFP?=
 =?utf-8?B?RjAyYjQzVGpudnZzNXhiN1BlU0srZHk4bjhpMnFqUFlkNU1Jemw1T0FlWUJQ?=
 =?utf-8?B?MzVjTmpCdlpCT2hGQ2NiQ1VyN2x6dWZORlZRcUlkWEtkOXJUT2x6dGZ5U3BM?=
 =?utf-8?B?UHZTUjZqWEM1dTZRYXlxQngxVDdDT25jN2dDVzAxaDdSYUFybVZpMngrbmZo?=
 =?utf-8?B?ajg2QnBPVlhZQUttdHZOaGVNbmcrZ0w0UnRLcjU4SUJkTjZZZU83QmNqMjN5?=
 =?utf-8?B?bEFuTkI0Vno2ZWlJTU0xQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ba71f8-0775-44d9-b197-08d95d2fcce4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 01:23:33.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /N7ykPCFbbEJN9uDEybd9GJ6zZvmdSKFjiW1KGVHPTr1GKLz6C0EuM6y2AMIxuZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2286
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: IYvdr7-14irMZhNmOwi5FutHKNbWDzvj
X-Proofpoint-ORIG-GUID: IYvdr7-14irMZhNmOwi5FutHKNbWDzvj
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_08:2021-08-11,2021-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/11/21 9:54 AM, Paul Chaignon wrote:
> On Mon, Aug 09, 2021 at 11:31:48PM -0700, Yonghong Song wrote:
>> On 8/9/21 3:53 PM, Yonghong Song wrote:
>>> On 8/9/21 8:12 AM, Paul Chaignon wrote:
> 
> [...]
> 
>>>> LLVM 12.0.1 and latest LLVM sources (e.g., commit 2b4a1d4b from today)
>>>> have the same issue. We've bisected it to LLVM commit 552c6c23
>>>> ("PR44406: Follow behavior of array bound constant folding in more
>>>> recent versions of GCC."), but that could just be the commit where
>>>> the regression was exposed in Cilium's case.
>>
>> The above commit is indeed responsible. With the above commit,
>> the variable length array compile time evaluation becomes conservative.
>> For cilium function dsr_reply_icmp4 in nodeport.h
>>    const __u32 l3_max = MAX_IPOPTLEN + sizeof(*ip4) + orig_dgram;
>>    __u8 tmp[l3_max];
>>
>> I didn't try to compile with/without the above commit, the following
>> is the thesis.
>>
>> Before the above commit, llvm evaluates the expression
>>    MAX_IPOPTLEN + sizeof(*ip4) + orig_dgram
>> and concludes that l3_max is a constant so tmp can be allocated
>> on stack with fixed size.
>>
>> With the above commit, llvm becomes conservative to evaluate
>> the expression at compile time. So above l3_max becomes a
>> non-constant variable and tmp becomes a variable length
>> array. Since it becomes a variable length array, the
>> hidden stack pointer "r11" is used and this caused a problem
>> in verifier.
>>
>> To workaround the issue, simply define "tmp" with
>>     __u8 tmp[68];
> 
> Thanks Yonghong!  I've tested this workaround on the Cilium codebase
> with all of our tested configurations.  I'm not seeing this R11 issue in
> this BPF program or anywhere else anymore.

That is great!

> 
>> But that is not for from user experience. I guess we can do:
>>    1. for BPF target, let us still do aggressive constant folding
>>       in compile time in clang, basically restores to pre-commit-552c6c23
>>       level for BPF programs.
>>    2. provide an error message if r11 is generated in final code.
>>
>> Will come back to this thread once I got concrete patches. Thanks!
> 
> I'm happy to run any patch you have through the Cilium CI if that helps.

Thanks for testing. Could you help try whether the patch 
https://reviews.llvm.org/D107882 can fix the problem or not?
You might need to add -Wno-gnu-folding-constant to silence
array size constant folding warnings.
If this indeed fix the cilium, could you add a comment
to the above llvm patch?

> 
>>
>>>>
>>>> -- 
>>>> Paul
>>>>
