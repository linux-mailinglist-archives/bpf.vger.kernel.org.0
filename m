Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E13C45785D
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 22:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhKSVxX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 16:53:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53158 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230193AbhKSVxW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Nov 2021 16:53:22 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJKZ0Zs030725;
        Fri, 19 Nov 2021 13:50:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BWz1q/6KZ9xI8datG0/JBCCIq5h+qDLUFIdk2FrcqJg=;
 b=UEeLXnzg8Yuz6Qmg0Uoop7h6Buq1zxxCSZpKBpsS0mFQguiFWDZ32s3JWG2HtcyIdOCm
 80PiSrjA9812nVejwW9mGVky08hlVU9ZDr1ngfR+PqQrJoMXiw8Wzw8V/0kh8SrSjkuR
 qNQdFc3VM9aHRtDGfipmIHM8YTuYzQLew7c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cek36rfc0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Nov 2021 13:50:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 19 Nov 2021 13:50:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P74B5f9Z9zE3XI3190indBej0lo1HxqImbrbFzD3mm6C5c0KF9EJBPxXkh62c6uZ48HfRIlul7+7Jw7nh8KdJEg+XPR/dUtzrLs9SjlllPxWjJ6Fz/lXFjCtiGFjgui2T3DVWw37f0p9H6zhv1uKPrI/V4SI6pqZHbHJK2eb4xoHVWzREv089wD4bngx9G2ejDISEnpL+FFKWZOnqO6sNNE1XthveGZ7tIGv06y/V7+9qJMVr2J8D/IdqBcXUJKKvd7Qw+uGYdLMN0h9nkgbUTGIrOEyVdK7BwFpzJMo5iVyioxXm6qxgYPqXZSpdnTfJ0Hq2F4O+3h+gR1+y/5+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWz1q/6KZ9xI8datG0/JBCCIq5h+qDLUFIdk2FrcqJg=;
 b=NhqJaUyspbbswJGCCsMqVgBiM9OZBLFg91C+U1UdlwERiuCNsti6B5XCCv0uGhwTqVZ4bYhXOiiRqdpCFY3yLSIC+kLazSmoApxw0/nlZW+mpBIaoy1a0MRv0NggsSRCiJF6SK/qimVILbN/fmCW8nsiBF00789Mmd/xwOMBbOlKCaqBdDWaWXasI7oqawyIsLPBur6kjuviealVs4d8mMIoNbQTpueB0ZR7J4wHCTYNrRbkHZTwzS7XWhynn2ENOIW14Pb+JIvKxLbtmiB6+pP01zd+RVDRmB3jCaqlGcPchMw47Z/ChreFbvC2o8pu+++i1BtY/BNe+v/Rc5N72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR15MB2237.namprd15.prod.outlook.com (2603:10b6:805:24::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 21:50:17 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b%9]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 21:50:17 +0000
Message-ID: <27fadae0-8d60-7e64-aa3b-939957a1c45b@fb.com>
Date:   Fri, 19 Nov 2021 13:50:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH bpf-next 1/3] bpf: Add bpf_for_each helper
Content-Language: en-US
From:   Joanne Koong <joannekoong@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
References: <20211118010404.2415864-1-joannekoong@fb.com>
 <20211118010404.2415864-2-joannekoong@fb.com>
 <CAEf4BzZV-n9uSM1kDONLfn0jLz50OkjXqy=avZ2oE4dhxVm9gQ@mail.gmail.com>
 <9cf25708-c878-65db-0dfd-a76e83fe9e39@fb.com>
In-Reply-To: <9cf25708-c878-65db-0dfd-a76e83fe9e39@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0270.namprd04.prod.outlook.com
 (2603:10b6:303:88::35) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c083:1409:25:469d:91d7:d5f8] (2620:10d:c090:500::3:eb0b) by MW4PR04CA0270.namprd04.prod.outlook.com (2603:10b6:303:88::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Fri, 19 Nov 2021 21:50:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23e93405-119a-4c9c-cbb3-08d9aba69318
X-MS-TrafficTypeDiagnostic: SN6PR15MB2237:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2237270009C788426CB20888D29C9@SN6PR15MB2237.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Me/js4pQ1U3upZPZp15gS3CQTSdQwvCDYMvG+j0RoOlPui1o3BYOT8zXt0ptekpJTpVPybjDglsORmiO6T1fntJeEevRnZeBoNNcAGwtT3tBjKkUZDLjxWyIymreUJNudyrnNSGsP5DVUgo/VNCPh9cfpsOcbQ5+Pm7jMR7EmrZHCVugS3+4c4sPE4owBDochiaA/3g93+eBpkIIG2vMX0vM38AX2U6byn1GNk6dfo97z+idLylszVUsyW97MVjjAyqbq/q8Fl9EAbYjp41r84PR+vbpVIbEf5dvPzwvw6dJwZzd5cdby9R2KXSkj9xq9oTqdM++O1RrwBEr9sDJ72Bm688TMlue9Diy9Tvk5SxraKUEb3+6nWqP3s0S3pMzjvkdnlodbYQiYtB7Zn0iRkxV3le8M1766knz/IAr5ag1IXEaB7/ebD8/BAoSWH2N8QHUDjMeHobnjNqlGSs2w+unYCIl2QfiBbesO5ze5RH2Uq28+wk4RV7VQvNT1JkhuN32I9811h0r3FsyFwIhQK++t9pwjKgjrCv1QA98DxC+dAbJ+maUASPHcOpSJNJQOuwbXtfAZJdwi3DYrMyrWr4o7dXDHQHui2cSMp4TgMFfz1V0+Nzzt/eCHupRWCZah4fruC1gKRvtaN/bDtW2sCbvHS5EW14MVhEGf6BAZtZZeIvcQtjTuDIg06HAiUVmRs3RgN4RPcyFbY5TVdwJ/gqOQyuhRg2tSDbhoDMAPOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(86362001)(8676002)(53546011)(83380400001)(36756003)(2616005)(5660300002)(2906002)(6916009)(66946007)(66476007)(66556008)(316002)(508600001)(31686004)(6666004)(4326008)(6486002)(38100700002)(8936002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGtsbFVUbkdCWFZnSEY3c09NL29ZZEdNV0daWjFIeWpKcU96bHd3azBOaFNT?=
 =?utf-8?B?dHZXS1YvYjhKY2RrT2VHdEdxVU5GQW8yK2kvQjBFTDcwMUR6RS9KbFkzNlk3?=
 =?utf-8?B?c0JlR09LeW11N2tTZkRzL0lSdVRuRmNLSU1PbzI3Y291MTdldXh4UnBBQXMr?=
 =?utf-8?B?djNhTzROUk1veElJMEZRVE9Dd1VHUDZBdjRMVzFlVFpOalNmYlY2Y2s5YWc0?=
 =?utf-8?B?QkVaaG8wWk1tUzFtMThzanp0RnhzajdtMWk0QVVWQ001WTBxTGhMWGJBUmh1?=
 =?utf-8?B?SXNXc0cvT2ZRZkdFUlBjTks2bElaU0k1czBsWGYrUFhVQlc3V3FvbllJeDNN?=
 =?utf-8?B?blM3WDNJZGNVNnJtaHE2UXdwODlpU1NRaEN5anFkYktoT0lxNTlWY29KZjJP?=
 =?utf-8?B?dktjU3ZHOTRjU2dTeFlnZmJsRFByNnloSlJSRkNKUXY3SGpKMDM4Nk1pZWhT?=
 =?utf-8?B?YzZJWHNMSFhsVjZvcVJDbCtTVEpuV0pzeUpIbGh4cUlJWXp2ckxmVWlrdHNE?=
 =?utf-8?B?VjJVRHg4ckJPR044SE9UeGN0bXkwV0JOMlh0MDhWWHp1MjNQMVJWNVB4R3lP?=
 =?utf-8?B?b1Q2dzlTQVpGTGVMdlVxc3pGcWNQdTBVNnJDSWF5TlJ5WkZOVjFxV2s2YUZY?=
 =?utf-8?B?N2dIanJkUXRycTJRUUNMaVlFRGJFb05aVkhueWs1U0pQVnkveEVGTFMzRVJR?=
 =?utf-8?B?NmlmRlBlUG5DK1BtMDBWdlJvb3lTZTdodlp5cjQzUVB6YmtjMGRLT2lZZVgy?=
 =?utf-8?B?Ymp1Vlc4SUdYTmFZekdFZEpTa0tRRnExU09hbHd5NXhPV0g3NjF0V21wdG12?=
 =?utf-8?B?elJyL2ZGalhaNE1qUEdoQjdzMG1aSmNzcU9hVUdrNlB3d1RqWXVZcldjcU9O?=
 =?utf-8?B?T1RyaDJHYnpsSTJ6MjdpM2QvRWsrSElmVDRMRnpBYXBUeEtnZ1QvMDhGNGZE?=
 =?utf-8?B?bjVlZHNVZnk5UWoySzZsUnpxY3BTc3FLdkM3OHBWK25jWW81eTROZU9DWDhp?=
 =?utf-8?B?MERHcy85QmxLS1JtWmxhMWNGSEIzWnh6TjNUT2xRL1ljN0ZFeHlObzVkQzU5?=
 =?utf-8?B?eDNJS3JsMjRCS2k5LzBTSDAzaDNPUGtvRmZ3cnhwUkY2TVJpL015QzJNNGFN?=
 =?utf-8?B?Y1BNUDF5dWlTdDFUc1FiaXlsZE5hVkM1MTNNZXQ1ZDhkZ1NhZkFlNTlhcE1P?=
 =?utf-8?B?TFZZelgybWdhSXRKTjgxM25LWDdJeVl2TklPcytyYkxvOUZjbXZEclUrUGRG?=
 =?utf-8?B?UllRTm1UbVRwOGRuT21aTU4vMnhaZlJPS1BRQnVaQ1hYb1lVMkZDWnJtNE0v?=
 =?utf-8?B?TU94aDlxQnovRzhEcTZoZlVieGU1Yy9vbEloaUdaT2RpRy9WZ1VXbStoVjk5?=
 =?utf-8?B?RkJRUk1Sa1lVaC9laTZVb1VUSjFYbHY5Wi9UQjNBSW4wM2tjUlVFNWltN0pO?=
 =?utf-8?B?YkdBZkhKMUhkV2FSRm1BNFBHczk4M3RJaXYvelBuOVFOMzNTWFZkWGF6RjhI?=
 =?utf-8?B?ZVF3cTFoZnhTVWtYbjQvczd6cncrSzZ2K0o3OEJSUU8yNEZWeU1CUXNhSFAr?=
 =?utf-8?B?RXdObmlpQ0ZmYitkN2dOMG1lNGJpNEg2azlEbnRTTXlQTG5ycm85eFZScmkx?=
 =?utf-8?B?TG45ZVF3azRZMENsSWQxV2hKWjNQMGZPYmRtTFR1WWVIOEtiM3ZSTHp0NE04?=
 =?utf-8?B?R0lmVzFjb2NoVHRXUlZvUDZTazdKR1d1M3Vmbjg2b29lWCtjWUtWRlZQUjZD?=
 =?utf-8?B?NW9lSzA3bnVRWjVOZGtMcEZBemlTSXorMG81TU43UXpVM1UxMnJReGJMTkRF?=
 =?utf-8?B?TDBHckxmT2drMzYwdGhRMkFSNWZ3N1N5ZktSQWs3U09CSkxhOUZ4d3BueHdK?=
 =?utf-8?B?MFo2aXN2SnkrR2xEbjl2c0x4TnFvN09QUk9BaVhrU25KQWpFQzkyUFYzZWpO?=
 =?utf-8?B?UmFCUDFqV0diWEhMd2g0eExiQy9rOWJtVU9zREZ0ZGhCd1FUdUNEN1pYNjlv?=
 =?utf-8?B?blBFN0dlSGlXaXZ3dWpXTWJNMjhTeGRCTFcybHRmRVNnblB2czJKQlZMakNT?=
 =?utf-8?B?S2RhbE1Yb3JmalF4Sm5ZQTNCZEtlcjNSK2ptY0UvbFhpQ091N1RETmhsSG1M?=
 =?utf-8?B?dDNnbVg1SWZmS1JIcjVsQ0dRa3JDRm5oQ2hiVmVwcm01aWxHc1QvZ0lkT1lC?=
 =?utf-8?Q?u1Kuo7IvLN2CsWlDehiQF6EJ1lsZU2BkCqYCJDX4P7xt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e93405-119a-4c9c-cbb3-08d9aba69318
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 21:50:17.2473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+EYQEvgX2xMpM1T6yKCIJ23EUl/gAYREhSyaW4zWQejyQ4WUI3XMA+X70016Y1dUUqeNs8HrdICUZyQO9HzSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2237
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: pZ-pRsiElVoFqbD3M1zOSBFszJ8KUvBM
X-Proofpoint-GUID: pZ-pRsiElVoFqbD3M1zOSBFszJ8KUvBM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_15,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111190115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/18/21 7:23 PM, Joanne Koong wrote:

> On 11/18/21 12:14 PM, Andrii Nakryiko wrote:
>
>> On Wed, Nov 17, 2021 at 5:06 PM Joanne Koong<joannekoong@fb.com>  wrote:
>>> This patch adds the kernel-side and API changes for a new helper
>>> function, bpf_for_each:
>>>
>>> long bpf_for_each(u32 nr_interations, void *callback_fn,
>>> void *callback_ctx, u64 flags);
>> foreach in other languages are usually used when you are iterating
>> elements of some data structure or stream of data, so the naming feels
>> slightly off. bpf_loop() for bpf_for_range() seems to be more directly
>> pointing to what's going on. My 2 cents, it's subjective, of course.
>>
> Ooh, I really like "bpf_loop()"! I will change it to this for v2.
>>> bpf_for_each invokes the "callback_fn" nr_iterations number of times
>>> or until the callback_fn returns 1.
>> As Toke mentioned, we don't really check 1. Enforcing it on verifier
>> side is just going to cause more troubles for users and doesn't seem
>> important. I can see two ways to define the semantics, with error
>> propagation and without.
>>
>> For error propagation, we can define:
>>    - >0, break and return number of iterations performed in total;
>>    - 0, continue to next iteration, if no more iterations, return
>> number of iterations performed;
>>    - <0, break and return that error value (but no way to know at which
>> iteration this happened, except through custom context);
>>
>> Or we can make it simpler and just:
>>    - 0, continue;
>>    - != 0, break;
>>    - always return number of iterations performed.
>>
>>
>> No strong preferences on my side, I see benefits to both ways.
> This is already enforced in the verifier (as Yonghong mentioned as well)
> in prepare_func_exit() -
>           if (callee->in_callback_fn) {
>                   /* enforce R0 return value range [0, 1]. */
>                   struct tnum range = tnum_range(0, 1);
>
>                   if (r0->type != SCALAR_VALUE) {
>                           verbose(env, "R0 not a scalar value\n");
>                           return -EACCES;
>                   }
>                   if (!tnum_in(range, r0->var_off)) {
>                           verbose_invalid_scalar(env, r0, &range,
> "callback return", "R0");
>                           return -EINVAL;
>                   }
>           }
> The verifier enforces that at callback return, the R0 register is 
> always 0 or 1
>
>>> A few things to please note:
>>> ~ The "u64 flags" parameter is currently unused but is included in
>>> case a future use case for it arises.
>>> ~ In the kernel-side implementation of bpf_for_each (kernel/bpf/bpf_iter.c),
>>> bpf_callback_t is used as the callback function cast.
>>> ~ A program can have nested bpf_for_each calls but the program must
>>> still adhere to the verifier constraint of its stack depth (the stack depth
>>> cannot exceed MAX_BPF_STACK))
>>> ~ The next patch will include the tests and benchmark
>>>
>>> Signed-off-by: Joanne Koong<joannekoong@fb.com>
>>> ---
>>>   include/linux/bpf.h            |  1 +
>>>   include/uapi/linux/bpf.h       | 23 +++++++++++++++++++++++
>>>   kernel/bpf/bpf_iter.c          | 32 ++++++++++++++++++++++++++++++++
>>>   kernel/bpf/helpers.c           |  2 ++
>>>   kernel/bpf/verifier.c          | 28 ++++++++++++++++++++++++++++
>>>   tools/include/uapi/linux/bpf.h | 23 +++++++++++++++++++++++
>>>   6 files changed, 109 insertions(+)
>>>
> [...]
>>> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
>>> index b2ee45064e06..cb742c50898a 100644
>>> --- a/kernel/bpf/bpf_iter.c
>>> +++ b/kernel/bpf/bpf_iter.c
>>> @@ -714,3 +714,35 @@ const struct bpf_func_proto bpf_for_each_map_elem_proto = {
>>>          .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
>>>          .arg4_type      = ARG_ANYTHING,
>>>   };
>>> +
>>> +BPF_CALL_4(bpf_for_each, u32, nr_iterations, void *, callback_fn, void *, callback_ctx,
>>> +          u64, flags)
>>> +{
>>> +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
>>> +       u64 err;
>>> +       u32 i;
>>> +
>> I wonder if we should have some high but reasonable number of
>> iteration limits. It would be too easy for users to cause some
>> overflow and not notice it, and then pass 4bln iterations and freeze
>> the kernel. I think limiting to something like 1mln or 8mln might be
>> ok. Thoughts?
>>
> I see the pros and cons of both. It doesn't seem that likely to me 
> that users
> would accidentally pass in a negative u32 value. At the same time, I 
> don't think
> limiting it to something like 1 or 8 million is unreasonable (though 
> it might require
> the user to read the documentation more closely :)) - if the user wants to
> do more than 8 million loops then they can call the loop helper 
> multiple times
>
> As a user, I think I'd prefer u32 where I'd automatically know the 
> limit is 2^32 - 1,
> but either approach sounds good to me!
>
> [...]
>>>   static int set_timer_callback_state(struct bpf_verifier_env *env,
>>>                                      struct bpf_func_state *caller,
>>>                                      struct bpf_func_state *callee,
>>> @@ -6482,6 +6503,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>>                          return -EINVAL;
>>>          }
>>>
>>> +       if (func_id == BPF_FUNC_for_each) {
>>> +               err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
>>> +                                       set_for_each_callback_state);
>>> +               if (err < 0)
>>> +                       return -EINVAL;
>>> +       }
>>> +
>> we should convert these ifs (they are not even if elses!) into a
>> switch. And move if (err < 0) return err; outside. It will only keep
>> growing.
> Sounds great, I will do this in v2!
>> [...]
(resending this email to the vger mailing list because it didn't go 
through the first time)
