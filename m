Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B403642FEEE
	for <lists+bpf@lfdr.de>; Sat, 16 Oct 2021 01:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhJOXhQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 19:37:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57822 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232515AbhJOXhQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Oct 2021 19:37:16 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FK8xIb010600;
        Fri, 15 Oct 2021 16:35:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mXocl0tGhcamdY+T1Ka5DYLoB5rbqlzbZLIvcqmV+tc=;
 b=S2JFYTVLvbZgPj1PMzESptxKa6uRfXPueLD3/9H5OfTF/Wrs7/XiE4FOSUcs9nudU6fM
 8ivqcifk7Ze3FbAisbDbGYUnaGFzTBmD6SrzDaV6dCnDC2nxpkR8UsmgPelBkI44/75f
 NAWyedBclC7w3iU1MNA31Z1N2qN167vXE40= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bqfpw1fqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 16:35:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 15 Oct 2021 16:35:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meFVM7RjSWOjXMi5SVlWqZWuzYHkm8Yv/BmDwM1fYRixCOMakzO7XL8X5bchBZI9bd3M1Xxx50azC9tJzzmZrEXtVPG/6jeE+pphqBRprqPJb4wQArw50ewhlgIzam0wCyaUZvBlY62TMO6YWEHp/wCtLq1JVbgNzm5Xvto51kmP6+TcY8NVSK1/nxxOC9qpaEFHhcENzd5yNIJfpn0VGKVg6Qqnugdwt8uEjXyEQXQSPFR3rNAi7oy2882ByZY+9HTochdL8amQ1c6xRbEa32DyepDz1wsc4KRzH5fRJ0k3vE8qO4xSWxBLdC1mqmjEck0hHN/+erZq7d4lT7yCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXocl0tGhcamdY+T1Ka5DYLoB5rbqlzbZLIvcqmV+tc=;
 b=lh7KD2dURNJGm0dYvw5rdjMVuo0W1F9TmaQj6LImTrBXYwkWwsP+rbP1YnuVwy08fvhQoSqKZ2R+EImrgTFsoSaqxpx4nArMQ039AvjCWeM+Jh8m4fxnBf6kHZCp1dplpIgY/zQaFbUmU5rUhiPsut+vmAP3CUqr75oncanU7JQYCNNvC7sZLWkwTlzyQ3BVziUwyp9TWkxyd1a0AklF553/AZpOTGDx95dZj/CfaVKHk03gdNGpn0gjW+HwSkEs2aKnq93pDzYxL4+p8LqrFFWbWkxAlIJvUHaJ4W19nGQoVvcDfOHFd4Yn5fWC9IkGzfrnANTpQpBYxBIV3VCcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR15MB4271.namprd15.prod.outlook.com (2603:10b6:805:eb::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Fri, 15 Oct
 2021 23:35:05 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::24b3:adef:9e0:a96a]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::24b3:adef:9e0:a96a%7]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 23:35:05 +0000
Message-ID: <02a28958-0015-e1cf-84a5-cb7d5717fdaf@fb.com>
Date:   Fri, 15 Oct 2021 16:35:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH bpf-next v4 4/5] bpf/benchs: Add benchmark tests for bloom
 filter throughput + false positive
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-5-joannekoong@fb.com>
 <9eb52022-2528-c2a8-62a8-25dfda4c0908@fb.com>
 <CAEf4Bzanj_rGR4Y1iQB=TLb8ud3m9_W6JEQx9sW=auFMV3QGRg@mail.gmail.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <CAEf4Bzanj_rGR4Y1iQB=TLb8ud3m9_W6JEQx9sW=auFMV3QGRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:300:ef::26) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c1::16a0] (2620:10d:c090:400::5:b49) by MWHPR22CA0016.namprd22.prod.outlook.com (2603:10b6:300:ef::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 23:35:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17f29bac-a032-446d-c2f7-08d990346ab8
X-MS-TrafficTypeDiagnostic: SN6PR15MB4271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB42710C49EA343272ADD93338D2B99@SN6PR15MB4271.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZOcvscMVXCuj8nFQm1oyw6uP4oRPjUDkUPLaXBdFYsYvuKdcTnq3mBwDJ/BSJSYxmCOWVNDc/U+YNr3EXpH7PdNOQ2Ds0MqJHLG31sGgv6Sp4pNPhQ+Ac5LwgYUMc2HVkHqavp5Jgy7/iTSOVY3XEZ9sBqJnpepEuNFb4DMo5Yqwbk7l8Y2IcF4o6qaaBNTYIZLkcmne8P2GUESPLIFEIugcsHf5thZltOXfcEgDEd5j/pSN7OJAchdmMctsy9jYtiAuQ3Gek4QvLC02U8Y9cBrMzHi8SuIIWXtuWpK+E8W9wXv5TjBIt0KCNFVzE3yIHTytyZtU0i2308+ms4ehMEi/OcrrbnkBI6rB+rkkRwhA6XGSzWopG6VL8ns8l8yU6AmfNmo9ekdbcP2hahQEbwURJlxair4MqmXBm0kjWOpO6NiuBACDDGLIsMZteP4gVT3kv2XL5K8p2kN6e5j4RTOBCUlhcVGInldVrJsteVDdD0zpZPMdEMaOYafmkd9pAFr3r/Aa9a6qoHZWkHfnG2dUZU6qJZ0gunQR5Q19mulglpNt8xTChuQqMT/BDgO0oWiX6LFgQYRUHlQgjg7Kp8XCIvb+ZnHY6aTEDDWiw26/S8Yoqjv5gAk/fSIA1V2ZqEHF2gYWzANwEr4v1A4S6pO+sSOvZeV+DJ/d+hH4dZS9JCugHiy72nEHXxMF88EoADvZVtn1Z9c/7077tIe0QYwoUnQBFEI911i/Lx4k6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(36756003)(4326008)(86362001)(31696002)(8676002)(5660300002)(53546011)(508600001)(316002)(83380400001)(66556008)(6486002)(66946007)(66476007)(54906003)(2616005)(2906002)(31686004)(6916009)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndFRGJsSUxySGYxa0xhZFhKcG4yVXVXOVN3Y0xITy9PcE1nSFB6bG1mSFlL?=
 =?utf-8?B?SzNtQTFVL1hLeHFaTCtERHVDWWdSYkZ3b1NyNUZieFEzaFo2OEdwengrVThE?=
 =?utf-8?B?RzRnTktQRGorWjdwb3pnY0ZUdlExcithWUpmcytxRm9yaWlCNDBYWENXMGlI?=
 =?utf-8?B?OVNYQytvUHlrV1Nqb01SN3dJQ2pXcFJma0trUnFHVndNQ2gwV2pDRWhnMFNn?=
 =?utf-8?B?QWo4M1FGaWNlQjZqUVc1NE1iVmladDZ3QnF2UFJDUHBnRzAyWlFWWHlsQWNP?=
 =?utf-8?B?cWxkcTIyL0pscVdJZjM0b0M4V2c2Ri8xS3pzSWFXTmxmQUM4TVVVbnZ6QUQ5?=
 =?utf-8?B?L2lCdFdjUlkyZU4wcEJlUlMraDlzRkRDRHU1K0s1K0EzVnl2WnNjU1hPQXRm?=
 =?utf-8?B?Q2VRZ0lxZG41ZGY0RThPSEM1NG9vS3RsWlA4bkVCSHpjaksxTDJpazBrK2ZD?=
 =?utf-8?B?RWtGV1ZhQmJpbFRKdDZaMnFHVlkrOG9rNkdMb3d2WVpuejhHcmh5ZFdTYzRE?=
 =?utf-8?B?ZTNIdk5sL1gzSm5RNnM0bE5lOTk1OUxSRHFMOEErWjZmd3NMaGc5K2JFM21k?=
 =?utf-8?B?NklFRllLZ3Y0ZEhObGxmdlVXR1pSWU9ZelJiTGwzSXZzZ2ZwQjB4RVJEWEd6?=
 =?utf-8?B?ZmhlRUNlVy9iQStGbWF5U2lHZStJTTJzSmZ1MlV3VllrMGUrcThnc2NiMVpY?=
 =?utf-8?B?QTNUTzJaT0J6RzZBd1JQRzNIN09uR21WUXZ5N1NNRFhxQUx6NzkwZ3A5MzJ2?=
 =?utf-8?B?YVpZb0J1c3AyWDlFWCtpNlNrSkZKYWx4R1crekY4aWIxWWgvVjdCMHk2R2V5?=
 =?utf-8?B?blUzcHdrblVPczJDVVN0R3NmbStCVkt5eU1aRjkzSzZxWXNDODRwb2x0S0R2?=
 =?utf-8?B?MUJUcmVOSWFzQXJSeGpGMDRjQ0ZMTHp2Z3hPcU54Vi83bWV1VmxaRVBJTGZS?=
 =?utf-8?B?dUd5RjlwUzI5NjlwYmhHUlUvSFdNNWJ1Z1dhQ0RJUmhld1U0em9SM2FaSFg3?=
 =?utf-8?B?MFBFYWdXZTlSMUEyam9MRjhReUZMMWRERGZoWE5rZE1xcjVKQmgraXRlTDB2?=
 =?utf-8?B?bUdobG92Y1p3aUk2Q0JaT0pqaytlSDM4WWlIbzM0a0htcnh4dnppZkxsMEVl?=
 =?utf-8?B?dHI1MGtjR2swa1R4RU5zVFd1R0h4NklxSTRwNXZ1S1FwYnBWZENSU2U1c2M3?=
 =?utf-8?B?N2J5OC9KSFJKYm0vZFk0dlVLK1NjcDZOYjR3VmNkdThXVXArZWdxVVV2RVA0?=
 =?utf-8?B?Y2ZQMkdKK1RMcm90b3RmY1lTVEYxd2o0VlBlT3ZoVkppRVMzTitKMzBMTWFw?=
 =?utf-8?B?U3lzWmx1ZjlqTTJic2FCYkhGYkR2R3FIYmYzbFp1UGo4QkZLMmovdUUydUlp?=
 =?utf-8?B?REFFZFBQNWVFMlJPSDdPR3FpWnk1NmhscHpHRG04R1BkNFNONzYrbnNKME5k?=
 =?utf-8?B?RWlOa2JEUGZnZmdva3ZQZklQcHU1VlpkQXhGaVBlOEZPVzgrMzhYaWhVMHZu?=
 =?utf-8?B?SjRTRTF6VmRnc3F5ZlQ3cnQyN2V5SGJWbmZpaUpHL1VnY2F4L21Hd1MwNVZV?=
 =?utf-8?B?ODRlLzhwalVya2M5ZzlkcHljb21BQUE4SFJFOExJODhSSEJVL28yWEwvc0Fv?=
 =?utf-8?B?aVV4ZG9VdkdJSXlFcllLZW90SWZFeXlwRk1MSy9jKzVvR1FhK3MvNlNTSnlO?=
 =?utf-8?B?aE91aDFhd1dpSlZtVjBVSy8wUlVGY3UrRmZXMmZtSVlUNUR2RStNb2RKUktI?=
 =?utf-8?B?OEFseTNZNEhJMFdGRTYrb0lzdW9ZUDRveDFWbkxzVXpObndpTW1jaVE1RHdS?=
 =?utf-8?B?bFZPWkhoUUZGbUtDTVV0dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f29bac-a032-446d-c2f7-08d990346ab8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 23:35:05.3734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgYXA8fJFYgPpTMSPHnrffu2PQBeJ9Z9x/kIMQEfo+DbeAm8uo/xzKomjbKYkP7OEQh2W7oB8ykDF9MpGJFL4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB4271
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: MDRSmfpGTJNYARwjZFYhYcoGkqjkDVTD
X-Proofpoint-GUID: MDRSmfpGTJNYARwjZFYhYcoGkqjkDVTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_07,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110150143
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/8/21 7:54 PM, Andrii Nakryiko wrote:

> On Wed, Oct 6, 2021 at 3:37 PM Joanne Koong <joannekoong@fb.com> wrote:
>> On 10/6/21 3:21 PM, Joanne Koong wrote:
>>
>>> This patch adds benchmark tests for the throughput (for lookups + updates)
>>> and the false positive rate of bloom filter lookups, as well as some
>>> minor refactoring of the bash script for running the benchmarks.
>>>
>>> These benchmarks show that as the number of hash functions increases,
>>> the throughput and the false positive rate of the bloom filter decreases.
>>>   From the benchmark data, the approximate average false-positive rates for
>>> 8-byte values are roughly as follows:
>>>
>>> 1 hash function = ~30%
>>> 2 hash functions = ~15%
>>> 3 hash functions = ~5%
>>> 4 hash functions = ~2.5%
>>> 5 hash functions = ~1%
>>> 6 hash functions = ~0.5%
>>> 7 hash functions  = ~0.35%
>>> 8 hash functions = ~0.15%
>>> 9 hash functions = ~0.1%
>>> 10 hash functions = ~0%
>>>
>>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
>>> ---
>>>    tools/testing/selftests/bpf/Makefile          |   6 +-
>>>    tools/testing/selftests/bpf/bench.c           |  37 ++
>>>    tools/testing/selftests/bpf/bench.h           |   3 +
>>>    .../bpf/benchs/bench_bloom_filter_map.c       | 411 ++++++++++++++++++
>>>    .../bpf/benchs/run_bench_bloom_filter_map.sh  |  28 ++
>>>    .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
>>>    .../selftests/bpf/benchs/run_common.sh        |  48 ++
>>>    tools/testing/selftests/bpf/bpf_util.h        |  11 +
>>>    .../selftests/bpf/progs/bloom_filter_bench.c  | 146 +++++++
>>>    9 files changed, 690 insertions(+), 30 deletions(-)
>>>    create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
>>>    create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
>>>    create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
>>>    create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_bench.c
>>>
[...]

>>> +
>>> +SEC("fentry/__x64_sys_getpgid")
>>> +int prog_bloom_filter_hashmap_lookup(void *ctx)
>>> +{
>>> +     __u64 *result;
>>> +     int i, j, err;
>>> +
>>> +     __u32 val[64] = {0};
>>> +
>>> +     for (i = 0; i < 1024; i++) {
>>> +             for (j = 0; j < value_sz_nr_u32s && j < 64; j++)
>>> +                     val[j] = bpf_get_prandom_u32();
>>> +
>> I tried out prepopulating these random values from the userspace side
>> (where we generate a random sequence of 10000 bytes and put that
>> in a bpf array map, then iterate through the bpf array map in the bpf
>> program; when I tried implementing it using a global array, I saw
>> verifier errors when indexing into the array).
>>
>> Additionally, this slows down the bench program as well, since we need
>> to generate all of these random values in the setup() portion of the
>> program.
>> I'm not convinced that prepopulating the values ahead of time nets us
>> anything - if the concern is that this slows down the bpf program,
>> I think this slows down the program in both the hashmap with and without
>> bloom filter cases; since we are mainly only interested in the delta between
>> these two scenarios, I don't think this ends up mattering that much.
> So imagine that a hashmap benchmark takes 10ms per iteration, and
> bloom filter + hashmap takes 5ms. That's a 2x difference, right? Now
> imagine that random values generation takes another 5ms, so actually
> you measure 15ms vs 10ms run time. Now, suddenly, you have measured
> just a 1.5x difference.
Yeah, you're right - in this case, the calls to bpf_get_prandom_u32()
are time-intensive enough to have a measurable impact on the difference. I
guess we could say that the delta is a conservative lower bound estimate -
that this shows the bloom filter is at least X% faster on average,
but I agree that it'd be great to get a more accurate estimate of the
speed improvement.

What do you think about expanding the benchmark framework to let the
user program control when an iteration is finished? Right now, every 
iteration
runs for 1 sec, and we calculate how many hits+drops have occurred within
that 1 sec. This doesn't work great for when we need to prepopulate the 
data in
advance since we don't know how much data is needed (eg 1 million entries
might be enough on some servers while on other more powerful servers, it'll
finish going through the 1 million entries before the timer is triggered -
one option is to keep reusing the same data until the timer triggers, but
this runs into potential issues where the hits/drops stats can overflow,
especially since they monotonically increase between iterations); we 
could err
on overpopulating to make sure there will always be enough entries, but
then this leads to irritatingly long setup times.

A more ideal setup would be something where we prepopulate the data to
1 million entries, then in each iteration of the benchmark go through the
1 million entries timing how long it takes to run through it with vs. 
without
the bloom filter. This also leads to slightly more accurate results 
since now
we also don't have to spend time logging each hit/drop in the corresponding
per-cpu stats. I'm thinking about this mostly in the context of the bloom
filter, but maybe having this option of running benchmarks this way could be
useful for other maps in the future as well.

What are your thoughts?


>
> But it's ok, feel free to just keep the benchmark as is.
>
[...]

