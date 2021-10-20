Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FC84342A3
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 02:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJTAsy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 20:48:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16628 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229602AbhJTAsx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 Oct 2021 20:48:53 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JKfJmV014369;
        Tue, 19 Oct 2021 17:46:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=l0+1OygvlSGWhEHai+2vIgUNlTlSfidQ+vwN1JpnOA8=;
 b=Z6OG53FwbYluGR3cK6uDZdEaebvxDsC32nAJNO8gdqLl+k0cY4Wh9ub81pSqT67dHlNK
 YljiIrVkx6n1M8ntGcg4s1afj+lbLpGk1VeCRAU0t2TiZYAGOMvr5UyP78FRyvlQtH00
 TYg9vl8O97zaTyYV+VTefAlk1VtYO0OQo7s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bt4rdhmw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 19 Oct 2021 17:46:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 19 Oct 2021 17:46:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M75AEQ5B56rXGFxm5v4dVQQ4/Nu5fQPj9N4D2Gn2V2L8PGDps7h6K8GD/bh88RMbDh2KADgU3uWA14K51aFeZpCSRA31Z+TTT86G/5E9gJqlOLNlFln3onPtgX6HxplZuC+1ksjSKa1ZhXOb6GiVB7jkCiqZ+RZ7QmPogVVVHIlzuobZd04LVrIE/6FMH6bQo14MTiX5jya08M9HwzupswCZdvgxAI6/cirGgZlN/DhTIAcJV/6Ovef/WD0BltCBYWJ0euZofpGqOUiWfpRweH2LUV3IjUZMGu/GXRB87Jy+XNkDBHbJl6m39eI8eREJw8x2Zb6aJ2bdgfM8xNueJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0+1OygvlSGWhEHai+2vIgUNlTlSfidQ+vwN1JpnOA8=;
 b=HV77fBPhyYiVxetvK6/EHCapuUc4sCSwmCMtV3Oqlaz3G7iLFCaR6OIPCLx03oQMkpywtvdm7deX1o+ZlRGm6x6xScm0ecZF2bT/r399J33OqPlJxCfNoaIJO6oDKUK8qLjvGhCirCUxj56FB6s8hy4MvlF7+H4UFkX3wZ11nKa2K5LslKSjCzRNgMju08rE17KAArz+2cEW3OcpD56hZP4tM/2feq6oOy+U5vm9aOaQYdPINdMp6E6lXVp67K0zEwAQAEMhfnX4RbUf/gk5sWqiOpWGntoL/iweq83cjXUqozie/gcof8zjwTihKMf9AgYMy7ByTZRzY/GnxWDYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA1PR15MB4981.namprd15.prod.outlook.com (2603:10b6:806:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 00:46:37 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::24b3:adef:9e0:a96a]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::24b3:adef:9e0:a96a%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 00:46:37 +0000
Message-ID: <427ddb04-f528-7381-22c3-994068ad5b7e@fb.com>
Date:   Tue, 19 Oct 2021 17:46:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH bpf-next v4 4/5] bpf/benchs: Add benchmark tests for bloom
 filter throughput + false positive
Content-Language: en-US
From:   Joanne Koong <joannekoong@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-5-joannekoong@fb.com>
 <9eb52022-2528-c2a8-62a8-25dfda4c0908@fb.com>
 <CAEf4Bzanj_rGR4Y1iQB=TLb8ud3m9_W6JEQx9sW=auFMV3QGRg@mail.gmail.com>
 <02a28958-0015-e1cf-84a5-cb7d5717fdaf@fb.com>
In-Reply-To: <02a28958-0015-e1cf-84a5-cb7d5717fdaf@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR15CA0025.namprd15.prod.outlook.com
 (2603:10b6:300:ad::11) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c8::14a5] (2620:10d:c090:400::5:9d0c) by MWHPR15CA0025.namprd15.prod.outlook.com (2603:10b6:300:ad::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 20 Oct 2021 00:46:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee8f616e-7e63-4944-464a-08d993631248
X-MS-TrafficTypeDiagnostic: SA1PR15MB4981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4981751CB82487D7CA2DB85AD2BE9@SA1PR15MB4981.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgaizEIDC7NEnCY4UMRF85Uh/c3kke6QJYYuBDQgk0Zip3RinLoFcrrlB3+J4dtKF1ft9W+b5r8+3RbicvhBEFO5BbAevOANRxLgBylJEbXxwkemFSuoWXKAoPeSgSA03YMOVSJkbD1A5p3eeoRJPdhIXkT79WEkXxHqYnvXeP+ihRR1xrUnv9j8YcR6fI035amPErH5MjlD4rbnilQHWSc26qy4jRpbwXnbc1UAand9RgRkOGxJBmUUiH7gWdKR0srA+LC5YG7kl5j6UMZ2Q9HqUZo2aCyh1uMgsXNSjskKYC8xHuGyHfWYCsvIi3+X3OOtLbvUsFc11I33aSGWOZYakUNWivdlVEuMmVBHRHBprFnGwkwvuP/FK8O1YOT8ycJk7Vhcvk4bEckZSRIFcHjPcRXZWTRlvokU/TOb7KWuT6rYiwItAf/FCjWFldxL56uqwupA0w6aK4PTu6Hb/cdoHNZj8WH0Y4myXun4+RhY1ZYbdziCZ3c5gh7eYtMS58I6ZM0PczcJa16MwF4mpGPKy6cxJYpaMl5L37YUfyqthqY7FW7v7mfIrpzR5MTFQhuBJuah5a9bbebbmY3UwZRPHpwtjVzp819ZdGZyxmzIvEitpW3489dhy0RrjcWaOpQdptoUthDrTNBjkqEyg9lE3F6v1JTFXbR4dpzqpzr2cC4fMnF5i3K+neXEV2uKQHY0g0AoPqG/Wg8feHa2rwVfdkYQsxbD8rxyofeyDaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(8936002)(316002)(66476007)(66946007)(31686004)(36756003)(6916009)(86362001)(6486002)(83380400001)(38100700002)(2906002)(66556008)(4326008)(54906003)(5660300002)(8676002)(508600001)(2616005)(31696002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTcxWXRnTmJjNnJoVUdjZndZWFpXTlZUc1JKeU4yNVZzbExxL0Y4Qkk3ZlhP?=
 =?utf-8?B?OG9YVHBTWXNBOThiR1I4alRpdVBYVGJyVUN3VlA5Q0lIL290VElMMXlYdDdS?=
 =?utf-8?B?UHNVdndPcGQ2dnhlUlVnZ2dmWFJZN0VLVlZuOTh4K29GRGx0Z25qV3hrcDBS?=
 =?utf-8?B?R2ZZOVpkcDQrOENoamtKR0o5QmphdEdLemljNmhVeWRKbWxMN0s2UnNiUGNU?=
 =?utf-8?B?ZUJIN25SSDBRNnRyNm9tcUt3aTZaaVRaMlkzUStHN0tHU0pQT3pPOXdtem5m?=
 =?utf-8?B?bVpZcHJzaCtaUnQyR2g0d0ducnVrTXA0T0k0NWJXY1JpcUIxdjloYWNTY2xw?=
 =?utf-8?B?QldHMmVaNHpLdm56SjRoMW1yUEQ4TThUT1QyeEdJL0FhWUV5NXJHdkwwNnNR?=
 =?utf-8?B?STdrSTg5Sk0yTENWSlk3Z2xhejBZVHJ0aDBZTGVJWnIxa3haMk5nRVZXZ3gv?=
 =?utf-8?B?MDlJcUIwZFhtNFpNZW43Q1IxbW1hbkhIZ2E3RzFzZEtDN3VFaG0rR1FOZG9l?=
 =?utf-8?B?bm8vQVd4ajVKVWMveDg3Y05JUUovdG16UmdjSDJuMEVnd1c3TmNKMWx5eWZn?=
 =?utf-8?B?bktvVFlJR1VmZ0JvSnV5YTdRdVJuZFdONytvaC94QmtDa3VOK3ErMlZiR0Y5?=
 =?utf-8?B?RkJsRWxsMXh0elY5Z2IzWjBRUjdVQTV1WGZucVN6TWY2Qy93Yyt3MTRXdUQ0?=
 =?utf-8?B?YUU5dW1kOXNmSGV6bjdpWTFveDB1Z0ZlZThNeUFITS9lNEYwUTNxb3pBbThq?=
 =?utf-8?B?RERKUHFZeTJXc25Jc0p6K0VMa0VteTVCVDE5eWk5NHpDVnlqUDNjVTNIUzk5?=
 =?utf-8?B?L044bEFHWXpwYkE3eERYaG9VVzc1RjA1dGdsNHpmU2NDT1lXYXVQSlFsaWFn?=
 =?utf-8?B?eUxtYWtQK1UxTU9HQ1N0WUI3aUNyMThXdEdwZXJLbnpaeWFkSDVIMWVvb1E0?=
 =?utf-8?B?VzRtdnc0MFRNMDRpOW1PWUROSXVicUJBV3NzUGl2bWtuWFpCNW1hczlSSlFY?=
 =?utf-8?B?dWdVS0loVXJFQXptOXFva1c4REFuTExuTXlJakp1bG5GRnc5K2oyYS9lc3Uy?=
 =?utf-8?B?a1c3b1dWYlFYQjVHQ2hocDJ2eEtxUW9QdnVNZ1daZ05KUXJUUTRMYWQ1RnRr?=
 =?utf-8?B?NVNCOXRUQjRjRTNacmJHYXRmR0dhSllNbytmRGR2MlQySUl5RTE2bHVxWjZW?=
 =?utf-8?B?MHBiSWxMZXcwcE1ObzNLczVNTUp0R0hWNnFtRzdiSG1vSGJmamUzNnZzQ3BP?=
 =?utf-8?B?cHpVRWhNeERabGVJOEpCU1ZlWE9ObUR4WnBrUzMzbm9hemNnTzQxM2pDaElV?=
 =?utf-8?B?ZkQreFkxcVA5bFJHeFQ5Vjd5cEhKSUFFQ05OVUZ2dUJHT3VkN1BDVWtBbXZ3?=
 =?utf-8?B?Mjg3My94eDA3QmNESnMwWEsydEgvQVB4OXZLWjlDYklyakhxaTFjTnlDQlZm?=
 =?utf-8?B?ZE5IanpJWktsRHBocG9ZbFZUN1c4Sm50V0dRWkUvVmpBb2t0OFNzaUROMHRp?=
 =?utf-8?B?TUpPN3ladGhHZHBocmlWb1ZGbnZkN1dFYTlGbGREN2plNzEwMVFiUEdIcEdX?=
 =?utf-8?B?UnBXK3Q1Q2xJY09UNmJTVktTV1VWaE5GUUlQSU5ub0l6WkFQQ2RETzdFYVJH?=
 =?utf-8?B?aDF3OS9MMXlSWUxJZUh5aHdBOFZ5dlhzait6dWlTazRwT0s3TzFzdUtsSlEz?=
 =?utf-8?B?Znk1RkFWVlRnUm45ajdmUm51dldmSURrZWhPZ1lJREF1bXJ3V2pmbndoY3hi?=
 =?utf-8?B?SFFSaVhLNTJmVWFmNUtGRU1kTjhYMVF1TVJZSHI1NGUyY3dpbzZEdlYyVFN0?=
 =?utf-8?B?cmJTMGlGQ1NjRis0dVcvUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8f616e-7e63-4944-464a-08d993631248
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 00:46:37.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8OmOOyevg0PVVYxiSUai66gYStdN2nuHVpHrTXemxRQ/l07+825JRbNKhIv1XS1V2Vk1p+JsYR29l5F2G964A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4981
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 40oFcPY27nQWA7h_5HbWK_CroeGkx3xT
X-Proofpoint-ORIG-GUID: 40oFcPY27nQWA7h_5HbWK_CroeGkx3xT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/15/21 4:35 PM, Joanne Koong wrote:

> On 10/8/21 7:54 PM, Andrii Nakryiko wrote:
>
>> On Wed, Oct 6, 2021 at 3:37 PM Joanne Koong <joannekoong@fb.com> wrote:
>>> On 10/6/21 3:21 PM, Joanne Koong wrote:
>>>
>>>> This patch adds benchmark tests for the throughput (for lookups + 
>>>> updates)
>>>> and the false positive rate of bloom filter lookups, as well as some
>>>> minor refactoring of the bash script for running the benchmarks.
>>>>
>>>> These benchmarks show that as the number of hash functions increases,
>>>> the throughput and the false positive rate of the bloom filter 
>>>> decreases.
>>>>   From the benchmark data, the approximate average false-positive 
>>>> rates for
>>>> 8-byte values are roughly as follows:
>>>>
>>>> 1 hash function = ~30%
>>>> 2 hash functions = ~15%
>>>> 3 hash functions = ~5%
>>>> 4 hash functions = ~2.5%
>>>> 5 hash functions = ~1%
>>>> 6 hash functions = ~0.5%
>>>> 7 hash functions  = ~0.35%
>>>> 8 hash functions = ~0.15%
>>>> 9 hash functions = ~0.1%
>>>> 10 hash functions = ~0%
>>>>
>>>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
>>>> ---
>>>>    tools/testing/selftests/bpf/Makefile          |   6 +-
>>>>    tools/testing/selftests/bpf/bench.c           |  37 ++
>>>>    tools/testing/selftests/bpf/bench.h           |   3 +
>>>>    .../bpf/benchs/bench_bloom_filter_map.c       | 411 
>>>> ++++++++++++++++++
>>>>    .../bpf/benchs/run_bench_bloom_filter_map.sh  |  28 ++
>>>>    .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
>>>>    .../selftests/bpf/benchs/run_common.sh        |  48 ++
>>>>    tools/testing/selftests/bpf/bpf_util.h        |  11 +
>>>>    .../selftests/bpf/progs/bloom_filter_bench.c  | 146 +++++++
>>>>    9 files changed, 690 insertions(+), 30 deletions(-)
>>>>    create mode 100644 
>>>> tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
>>>>    create mode 100755 
>>>> tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
>>>>    create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
>>>>    create mode 100644 
>>>> tools/testing/selftests/bpf/progs/bloom_filter_bench.c
>>>>
> [...]
>
>>>> +
>>>> +SEC("fentry/__x64_sys_getpgid")
>>>> +int prog_bloom_filter_hashmap_lookup(void *ctx)
>>>> +{
>>>> +     __u64 *result;
>>>> +     int i, j, err;
>>>> +
>>>> +     __u32 val[64] = {0};
>>>> +
>>>> +     for (i = 0; i < 1024; i++) {
>>>> +             for (j = 0; j < value_sz_nr_u32s && j < 64; j++)
>>>> +                     val[j] = bpf_get_prandom_u32();
>>>> +
>>> I tried out prepopulating these random values from the userspace side
>>> (where we generate a random sequence of 10000 bytes and put that
>>> in a bpf array map, then iterate through the bpf array map in the bpf
>>> program; when I tried implementing it using a global array, I saw
>>> verifier errors when indexing into the array).
>>>
>>> Additionally, this slows down the bench program as well, since we need
>>> to generate all of these random values in the setup() portion of the
>>> program.
>>> I'm not convinced that prepopulating the values ahead of time nets us
>>> anything - if the concern is that this slows down the bpf program,
>>> I think this slows down the program in both the hashmap with and 
>>> without
>>> bloom filter cases; since we are mainly only interested in the delta 
>>> between
>>> these two scenarios, I don't think this ends up mattering that much.
>> So imagine that a hashmap benchmark takes 10ms per iteration, and
>> bloom filter + hashmap takes 5ms. That's a 2x difference, right? Now
>> imagine that random values generation takes another 5ms, so actually
>> you measure 15ms vs 10ms run time. Now, suddenly, you have measured
>> just a 1.5x difference.
> Yeah, you're right - in this case, the calls to bpf_get_prandom_u32()
> are time-intensive enough to have a measurable impact on the 
> difference. I
> guess we could say that the delta is a conservative lower bound 
> estimate -
> that this shows the bloom filter is at least X% faster on average,
> but I agree that it'd be great to get a more accurate estimate of the
> speed improvement.
>
> What do you think about expanding the benchmark framework to let the
> user program control when an iteration is finished? Right now, every 
> iteration
> runs for 1 sec, and we calculate how many hits+drops have occurred within
> that 1 sec. This doesn't work great for when we need to prepopulate 
> the data in
> advance since we don't know how much data is needed (eg 1 million entries
> might be enough on some servers while on other more powerful servers, 
> it'll
> finish going through the 1 million entries before the timer is 
> triggered -
> one option is to keep reusing the same data until the timer triggers, but
> this runs into potential issues where the hits/drops stats can overflow,
> especially since they monotonically increase between iterations); we 
> could err
> on overpopulating to make sure there will always be enough entries, but
> then this leads to irritatingly long setup times.
>
> A more ideal setup would be something where we prepopulate the data to
> 1 million entries, then in each iteration of the benchmark go through the
> 1 million entries timing how long it takes to run through it with vs. 
> without
> the bloom filter. This also leads to slightly more accurate results 
> since now
> we also don't have to spend time logging each hit/drop in the 
> corresponding
> per-cpu stats. I'm thinking about this mostly in the context of the bloom
> filter, but maybe having this option of running benchmarks this way 
> could be
> useful for other maps in the future as well.
>
> What are your thoughts?
>
Andrii and I had a great discussion about this offline and in the next 
revision
(aka v5), the values will be prepopulated ahead of time and recycled. We
don't have to worry about hits/drops overflowing u64; a u64 is large enough
to handle this
>
>>
>> But it's ok, feel free to just keep the benchmark as is.
>>
> [...]
>
