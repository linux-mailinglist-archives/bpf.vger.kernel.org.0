Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D467F65CDF7
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 09:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjADICE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 03:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjADICD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 03:02:03 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5B5E032
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 00:01:59 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3046m9eZ005406;
        Wed, 4 Jan 2023 00:01:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=LM+Kc8YipNfUyB7HX7W1jQOr9ZbCpWamdJVSPNZKPpY=;
 b=MSkSRe4YtQBqW+86FEHbW/cBXJa2Z4FlNuS6jhZx7wiI+WOpQuxINttXDi3u3ttw180J
 RmFxS+U8lt7ElmxiKIfm9GTQU/GcEIh1lQIGxcr68sm7YB7+HaqNuGD308Z9YyBQaBy5
 0PyntlbnE0iVLemAqpdou5qJBUkK6+TlyWziGobiN3+jn95WPMVpSxfKZx9oGklJqYOR
 mTx6O6vySkowYNc+anVbHAN4Pc2EkRWypd0JzDnGfV5qz8AeEHaYp35A2Rf29iaMkDqP
 w45NQ2873jPSn+es5UtLll7nb/axRakBXGr+NQFErJvdMB6rZYUPrQqTwJuGThGO2cTy gA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mw2bp91m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 00:01:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imxHYtqUVO/vJ2MHVT19/s+tSkNliDRpxwXN6fqZa1uKE7OXZFxpXAjQBIAuNEH/gQ+FDXWT7DgiK0ynA4uZnSLBzyvW7MA5rew0cVdXWGR7T0VFOd3vlGFa2MPQlQUPpvIN/VCGIKzMn00XshMgsgSOxN1wU2+/2NApbLroOA5+MnX/C5XG+PfWAecTKK+6UsWmXAjHjZUgQNgEe72fsixJu1I28dN1CqAqyp7PX4JjbEf4Jaxd6gUxKWsM+b45ryLs9Dlpy/VzX+RpG5Gfl44qYXkzhcDF1wyVgXkEBX4dH9OqYfW0SkTwTXPzCeUnzCFA/nB6uIVL5+6fysRP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LM+Kc8YipNfUyB7HX7W1jQOr9ZbCpWamdJVSPNZKPpY=;
 b=kxdZbu+cHR78rmhP4pG198RHKm2oXCcn0KTAlOXiGvw6rAZirMCqrIQxDSbIxJ8lVfRow0SEexk8xVL9EGHCQ8SWDfDy8FMuwHrEkq0SqcWmhhjp/zLCumZKiRnjH4IZsJbOB8tz6fsTHzujpYpaSdXtGmdAVbwEc4tDJiS3bn+RtN/tW1W8P1MGnKXMDQBXZWujHaI/zmBjebJMOvnrRCnCAMrCjpsp3zw5teLWMItjZdMIM6gAVQAtpVbBEF2w4EpfAAHVLEEhAfd4eipKzkAzy3ckKfX4VEjVOaP+q9GC9UJb9o7tONQ6S2sfjx3a6OmfCBJgEM9lsYC5C3JPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH2PR15MB3542.namprd15.prod.outlook.com (2603:10b6:610:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 08:01:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 08:01:18 +0000
Message-ID: <ff6473d8-c640-267e-c0f7-a92ce747c888@meta.com>
Date:   Wed, 4 Jan 2023 00:01:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [bpf-next v3 2/2] selftests/bpf: add test case for htab map
Content-Language: en-US
To:     Hou Tao <houtao1@huawei.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20221219041551.69344-1-xiangxia.m.yue@gmail.com>
 <20221219041551.69344-2-xiangxia.m.yue@gmail.com>
 <c41daf29-43b4-8924-b5af-49f287ba8cdc@meta.com>
 <CAADnVQLE+M0xEK+L8Tu7fqsjFxNFdEyFvR4q3U1f1N1tomZ2bQ@mail.gmail.com>
 <ac540d41-4ac3-4d70-39e8-722e3fb360cd@meta.com>
 <CAMDZJNV_J-LmxxzX5DMGHQLm6WyYqG2GAMHb=WZvBG_y1rUOYg@mail.gmail.com>
 <323005b1-67f6-9eec-46af-4952e133e1c4@meta.com>
 <dc658ded-719f-17bd-9166-e335a86150a6@huawei.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <dc658ded-719f-17bd-9166-e335a86150a6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CH2PR15MB3542:EE_
X-MS-Office365-Filtering-Correlation-Id: 7728a2e6-b511-4b63-3b02-08daee29dc25
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saQn52jfOJmfQW9jUqlwBwCcfShuFI9dGoDGy0fnRrmsz15EojMnBxoXLXeaMKUCUZAEmZl5obOjpkj9taAC3WTYklPfhlbObVdctDKDkwjdSbpvs8GD0lqcUJCHVrYZYtL5vCo93rD7r/QYkOty9hQv81ClmvdFWSGfErf+bB5DYi0VN4aMzVT6D6JGZzvFvUfjY/HynpLZJa61n8ZbxtRIQjyGW4ujMtbjhIyZypjeRq19nhVlSOZfOoeCzP8xPB8911+I6fhI90Okfiv4+or50n4utpQXisvl/WNdNWhZ0nBPR0KsGbAGSFohLifFU2z8Hdhtp/Z2d7qBdgUpsv4qKOvO8qgjLMrLfaxF6Vu+nikftGJ5YsWolyCLsTindNBJxlXLcHdFn7IKWuQeauKoHHLEs1uDRRujiiDkW/fZKtRC57+pylrV0SzuLf/N3sW6yTOE2iie6JiRi0itYZIJf4YY3kUy86Fp99rtakxelZgzKwp7cQMxQvWFrVbwI3xOR6GA6hAo/djqrR2JmQ7GJkZ1vte5YeT3T5MmCudp89bDe2edg4h+1afWdTIWpex6mCdDgSHKx5+uQmv02oRsEIA7KwXnSxySGLP8X3w7RDwD+C7/WAxwj0O9WNpHusOoIQJg3r51pJKJLiqyqU64d0r3F5XYop/hje89G4Zbb+VaoEpHUOhyIk2oa9U9cOrW0DBAAJWKVMUCiQ5XdU+r9N6sVbTk0bYn+69rAjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(41300700001)(8936002)(4326008)(66946007)(5660300002)(8676002)(7416002)(316002)(54906003)(110136005)(2906002)(31686004)(66556008)(53546011)(6486002)(6506007)(478600001)(6666004)(66476007)(2616005)(86362001)(31696002)(186003)(83380400001)(6512007)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2w3NGJsbjNxL1FIcm1SanphajZic2FSSmxaaXJxc245VFlHaTB0VDVPTlI1?=
 =?utf-8?B?cHpmMWd5M2hpQzFMb1BpeTYydmJrNDBzcE55b0lHM2h4Vi9IVUE5S3RlTWNN?=
 =?utf-8?B?SFFVNWNWYlR4MHNhRW9tSk9GVnZCaHJFaktzN2o5aEFTbjZNKzZCaVFjSHho?=
 =?utf-8?B?VGJUTWpLQ1lUSUZnbW1vR2lMSWlocHlYajNrUWNoQlpmQ2xwaVViVDFWbFdX?=
 =?utf-8?B?NzRhelNsSnc2SUVRU00zTFFja1ZJUllQTGo3SWplK1R5MlAwaW1vN2pVcGNE?=
 =?utf-8?B?bDZvZnBSdEdEUllTaUVvZVNRVnZRNVl2MVdreWZMN3dZVjNwV3crM3M2U20w?=
 =?utf-8?B?Zm5mT2I2Q1IwanJyT2xTWCtyQ1luTVdvQTg5aW1SZDJjVm1HWlQvb3U3NVlI?=
 =?utf-8?B?UU5RTitMVUg5RzVrTVU2d1dmNmRHWW1pT3BycWFCbEd2VzFvOXdMSHJldU5l?=
 =?utf-8?B?RWJtaDgxOU5ZejgvZGhTbjFWVVVjcG8rakxydXBoS0s0YTNHVnQxbUxNNGZU?=
 =?utf-8?B?RVJ3M2g0NE9uajJEKzlwR3JsZUtNMHU0QXJRdXoxSjRzeHArS3dieko0dEVp?=
 =?utf-8?B?TmpDd0ltRzRQc2c5a1hpa0dwVVNHeDY1Y0Fkd3U4RVhHTjBXdHdxdlQrb2xJ?=
 =?utf-8?B?cXdFaFBUWnVCUG9mVnJxVTh2RmlaMUJFbllKZ0pUTGZ6NlR3SVU2ZjI2YVZp?=
 =?utf-8?B?TFJKeVhqczVQaXNDQTlqYVNPYVVoQ0pwRGl4TlFJNFpkVUdwcVVFTGthVSs2?=
 =?utf-8?B?SDhsWWhjZklxM1R3Z29JVlBJb3BjeHJQR1lJRDRlZnduaDRlUGdZbDN4SUhi?=
 =?utf-8?B?cmFKL242NDR0OVpnVTYyVTVWVGVid0dpeVJ2dGxEb3d2STRKSnVuc0w4blNW?=
 =?utf-8?B?MUk2ckFoTEQxeWEvUEQ2Tzh6d1JXRlhyWENJMEd1U1htekZlanZLbyt5YTcr?=
 =?utf-8?B?aU94ZlAzU0wwSGZ2Tm8ydGUrdDRMcHpQdi9CdVh4ay9hSUJyUDJzTlR1S3VG?=
 =?utf-8?B?eUlrcHZORXQ5azRUU0ZSclM1M1dxbkxsZVpKRUNNayt6bmZIU2h3bXJ0dS9k?=
 =?utf-8?B?NVlsUEJiMU5POEkwNGNldlk4L0VjUDNlWWpWakxCZVBIYlJIOWpnQWgwaWcw?=
 =?utf-8?B?bTJqTVV2ZmxYTzYxeitPbXNUUXpwRG5EbWNyYXZnbm85MHJlWjNVdk0xT3JN?=
 =?utf-8?B?VHJoeVg4ZDNBUkRCZlo2OWhBYWkzM05vdzN1a09HOGVINURGMnZCOWZhR1Nu?=
 =?utf-8?B?a283L0VyOGNqL25aQnMyVys0N1RSWjhlcHpabnQxZXpoQWRVdnhnL1BJcy9P?=
 =?utf-8?B?a2MwMktlL3JjS29mdVBnc2JRdlgrOVpsckpuYitmUWd0TzcxODJzdDQrMjY3?=
 =?utf-8?B?VWdPbHZ4YUg5WVFmMlNnQnFDeWZUcmFXT2VnOXRlSEVMWlc3aThmR0ZsVmlT?=
 =?utf-8?B?NkQzNzBiNUlLVUJ1bG1hbTU2ZmI5NThlRE9xaXI4KzBWRUZEaHRIS2RkRjdM?=
 =?utf-8?B?WW84SThleW8yU3pMQmZFellXVnRTNFZlWFpTYktCdVZpUFBDNlJVTnFzV1ov?=
 =?utf-8?B?ZjNITy9UcVJCdTd0dTFXZWtwUjBsbkplTHRmNk5NT3l3SG1QZ3FRVDJHNGQ2?=
 =?utf-8?B?b1ovaHZjRjc0bjhzRngzV0hPNS9XWG9adG5rYlZyQmxsNUREMStvSGxXK1Bq?=
 =?utf-8?B?VDUxNHJQYkcrSHlOQzVqWkhuY3paZGFyUlN6aHI2N3psNVludjEvaXZkZTZP?=
 =?utf-8?B?TDZHWmUvZjEzYXU1ZWZtSERrYmYvUUlreU5sWHBSaWpTaXZqcDQ2K1FmNUh1?=
 =?utf-8?B?aW1KK25kK0hFUVhETjFWMk9CdUozYVB1cHlnQUdISFkxN2IvT0pPY2tXdFMx?=
 =?utf-8?B?cElycFVleHpscUdKOXN4MjhvNU5acmlQZ2dBTXBwQ1hRaU1PM21UUTdQQm50?=
 =?utf-8?B?dVlSZEdMd0JpOG1hMHB3Y2M0cW41K1hWSFBuUUpTeUVQRkJhb0FLb3ozZWZH?=
 =?utf-8?B?c2pLQXVmbzdvancvSU1aMDJpdldsUTVoQy9STDMxczlOSjg3TFNHMklGaTZC?=
 =?utf-8?B?NEpoenB5TmVFWWNYemo3SzdxR1c3NHZrTkM3MTV4OU5CTXNqaHlyNXV6YjFv?=
 =?utf-8?B?Vkx1ZDJoM0Fma1NQVTZmNEdEcllEd25xMkpqUkN5M1VqZzloNmxyQ0l4cGlY?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7728a2e6-b511-4b63-3b02-08daee29dc25
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 08:01:18.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RCdAZa7nv6oE6DDMHjsTPH2ZwYYnSAy7hM1LEXsPF15kDKvO5HiL4ItLHnRcenY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3542
X-Proofpoint-GUID: BD-YPlr76u78D0g790o-EmWE8DucDZBw
X-Proofpoint-ORIG-GUID: BD-YPlr76u78D0g790o-EmWE8DucDZBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_04,2023-01-03_02,2022-06-22_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/3/23 11:51 PM, Hou Tao wrote:
> Hi,
> 
> On 1/4/2023 3:09 PM, Yonghong Song wrote:
>>
>>
>> On 1/2/23 6:40 PM, Tonghao Zhang wrote:
>>>    a
>>>
>>> On Thu, Dec 29, 2022 at 2:29 PM Yonghong Song <yhs@meta.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/28/22 2:24 PM, Alexei Starovoitov wrote:
>>>>> On Tue, Dec 27, 2022 at 8:43 PM Yonghong Song <yhs@meta.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 12/18/22 8:15 PM, xiangxia.m.yue@gmail.com wrote:
>>>>>>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>>>>>>
>>>>>>> This testing show how to reproduce deadlock in special case.
>>>>>>> We update htab map in Task and NMI context. Task can be interrupted by
>>>>>>> NMI, if the same map bucket was locked, there will be a deadlock.
>>>>>>>
>>>>>>> * map max_entries is 2.
>>>>>>> * NMI using key 4 and Task context using key 20.
>>>>>>> * so same bucket index but map_locked index is different.
>>>>>>>
>>>>>>> The selftest use perf to produce the NMI and fentry nmi_handle.
>>>>>>> Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
>>>>>>> map syscall increase this counter in bpf_disable_instrumentation.
>>>>>>> Then fentry nmi_handle and update hash map will reproduce the issue.
> SNIP
>>>>>>> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>>>>> b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..d394f95e97c3
>>>>>>> --- /dev/null
>>>>>>> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>>>>> @@ -0,0 +1,32 @@
>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>> +/* Copyright (c) 2022 DiDi Global Inc. */
>>>>>>> +#include <linux/bpf.h>
>>>>>>> +#include <bpf/bpf_helpers.h>
>>>>>>> +#include <bpf/bpf_tracing.h>
>>>>>>> +
>>>>>>> +char _license[] SEC("license") = "GPL";
>>>>>>> +
>>>>>>> +struct {
>>>>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>>>>>> +     __uint(max_entries, 2);
>>>>>>> +     __uint(map_flags, BPF_F_ZERO_SEED);
>>>>>>> +     __type(key, unsigned int);
>>>>>>> +     __type(value, unsigned int);
>>>>>>> +} htab SEC(".maps");
>>>>>>> +
>>>>>>> +/* nmi_handle on x86 platform. If changing keyword
>>>>>>> + * "static" to "inline", this prog load failed. */
>>>>>>> +SEC("fentry/nmi_handle")
>>>>>>
>>>>>> The above comment is not what I mean. In arch/x86/kernel/nmi.c,
>>>>>> we have
>>>>>>       static int nmi_handle(unsigned int type, struct pt_regs *regs)
>>>>>>       {
>>>>>>            ...
>>>>>>       }
>>>>>>       ...
>>>>>>       static noinstr void default_do_nmi(struct pt_regs *regs)
>>>>>>       {
>>>>>>            ...
>>>>>>            handled = nmi_handle(NMI_LOCAL, regs);
>>>>>>            ...
>>>>>>       }
>>>>>>
>>>>>> Since nmi_handle is a static function, it is possible that
>>>>>> the function might be inlined in default_do_nmi by the
>>>>>> compiler. If this happens, fentry/nmi_handle will not
>>>>>> be triggered and the test will pass.
>>>>>>
>>>>>> So I suggest to change the comment to
>>>>>>       nmi_handle() is a static function and might be
>>>>>>       inlined into its caller. If this happens, the
>>>>>>       test can still pass without previous kernel fix.
>>>>>
>>>>> It's worse than this.
>>>>> fentry is buggy.
>>>>> We shouldn't allow attaching fentry to:
>>>>> NOKPROBE_SYMBOL(nmi_handle);
>>>>
>>>> Okay, I see. Looks we should prevent fentry from
>>>> attaching any NOKPROBE_SYMBOL functions.
>>>>
>>>> BTW, I think fentry/nmi_handle can be replaced with
>>>> tracepoint nmi/nmi_handler. it is more reliable
>>> The tracepoint will not reproduce the deadlock(we have discussed v2).
>>> If it's not easy to complete a test for this case, should we drop this
>>> testcase patch? or fentry the nmi_handle and update the comments.
>>
>> could we use a softirq perf event (timer), e.g.,
>>
>>          struct perf_event_attr attr = {
>>                  .sample_period = 1,
>>                  .type = PERF_TYPE_SOFTWARE,
>>                  .config = PERF_COUNT_SW_CPU_CLOCK,
>>          };
>>
>> then you can attach function hrtimer_run_softirq (not tested) or
>> similar functions?
> The context will be a hard-irq context, right ? Because htab_lock_bucket() has
> already disabled hard-irq on current CPU, so the dead-lock will be impossible.

Okay, I see. soft-irq doesn't work. The only thing it works is nmi since 
it is non-masking.

>>
>> I suspect most (if not all) functions in nmi path cannot
>> be kprobe'd.
> It seems that perf_event_nmi_handler() is also nokprobe function. However I
> think we could try its callees (e.g., x86_pmu_handle_irq or perf_event_overflow).

If we can find a function in nmi handling path which is not marked as
nonkprobe, sure, we can use that function for fentry.

>>
>>>> and won't be impacted by potential NOKPROBE_SYMBOL
>>>> issues.
>>>
>>>
>>>
>> .
> 
