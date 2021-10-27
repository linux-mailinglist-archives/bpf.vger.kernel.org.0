Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6707443C0FE
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 05:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbhJ0DwH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 23:52:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42548 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239183AbhJ0DwG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Oct 2021 23:52:06 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QHIfTC007661;
        Tue, 26 Oct 2021 20:49:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=HULEuGV4r6fmc1WXhOaJxI8zEnhLEP3Lc+xDz955z30=;
 b=DubSN48/wTQdcPAfVb2vr70eks1iaqJQLB2yONHnNxcDg65PSRAOPljOj7zje7bgMXLS
 EQ6PP44AAAZqsFa/sXDkfFnqEZXhUYZGA7K/luhqle4FQ6n7ptROo6J4lxPH1kcHeASW
 /tb/kEXGvgQ4uxdQh/584hJYDE8EVP1arOk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bxny4bpgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Oct 2021 20:49:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 26 Oct 2021 20:49:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLzBV34ce6Q7V8sXa7N4ijE8kMf7afao/9Ml+YBx+Lt8OtP0B7IhlJCZ5vFBgkOYIy8/mj0EFmk7j2B4lvZzaISjNcldHjG5r+k5EcPElCznk6KCVp21rbjSHjLicq3p23EwyJgXlI6F/h7ayLkl0dCVoxKqnYsY+RMK9CtgYKJ6Tj+KCT949MUCVKWk0TykmV+Whm7nLHV5bi7iXQ37RoNWR3F7xfwk4F5qm7mBlZvk7RC85ZFXMiClSGF8s8uzzheKPSscpH5zG85xuMkHuMv8PbDblqNZfO12VPQ8+mXgYEsk+m25L/y70wiHVSyTHlaiwtx/Whx3M9cr4ENQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HULEuGV4r6fmc1WXhOaJxI8zEnhLEP3Lc+xDz955z30=;
 b=LAtFhW9G2XlhT0y76LyBO/3JGch+0+bmk3LelwEjufuQnBHDeJTNcREJQmCEakceKjHzmQ1PjZliyUCgf0zBwOKZeGKr7VKBi/8DzMJvUL5J8/m0fumBDCSCAdyGcfbElD7QyXC45sKb3Vf9pvWULX9O5jPCwxA2fmY5P6AwP0ov1mDVhVbsDg846x378tk+IXMrGvsrDHIgZRzmbZNNaPhqgochBykdLxt6Q0DHCD+yIoP5sm7Fp/EISfTgWCrdXRr/CW8B4KWYfBV9IUpqRw8bUMoUQLjDUTDWj+hfjRrgodGqiiBrXNqBVhBzNAhHD5dUG+H8sBhdWemlbWhP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from MW3PR15MB3980.namprd15.prod.outlook.com (2603:10b6:303:48::23)
 by CO1PR15MB4811.namprd15.prod.outlook.com (2603:10b6:303:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 03:49:38 +0000
Received: from MW3PR15MB3980.namprd15.prod.outlook.com
 ([fe80::517a:2932:62df:1075]) by MW3PR15MB3980.namprd15.prod.outlook.com
 ([fe80::517a:2932:62df:1075%3]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 03:49:38 +0000
Subject: Re: [PATCH v5 bpf-next 4/5] bpf/benchs: Add benchmark tests for bloom
 filter throughput + false positive
To:     Joanne Koong <joannekoong@fb.com>, <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, <andrii@kernel.org>
References: <20211022220249.2040337-1-joannekoong@fb.com>
 <20211022220249.2040337-5-joannekoong@fb.com>
From:   Andrii Nakryiko <andriin@fb.com>
Message-ID: <4c92fd62-ab88-3dac-ce90-5e00b1c62dd7@fb.com>
Date:   Tue, 26 Oct 2021 20:49:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211022220249.2040337-5-joannekoong@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:303:dd::20) To MW3PR15MB3980.namprd15.prod.outlook.com
 (2603:10b6:303:48::23)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:2103:b2:4e6a:72dd:1ddf] (2620:10d:c090:400::5:8f40) by MW4PR03CA0315.namprd03.prod.outlook.com (2603:10b6:303:dd::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Wed, 27 Oct 2021 03:49:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35b1e8b9-84dc-46c5-71a7-08d998fcccae
X-MS-TrafficTypeDiagnostic: CO1PR15MB4811:
X-Microsoft-Antispam-PRVS: <CO1PR15MB48114C5A6B6587BCCB28BFF3C6859@CO1PR15MB4811.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /I2nHmdXf0mKx25hYoYOSoyzmdlXuUkJynNbkZoPu8MTu1jW8joVz+3qpcRPWZm3OaT3EIWt3YEcX68M0jJ27fKYWWXjHA3vx97uOsVtVu7g99KF4/+YBtC72HRxCcVPsc4ftag9ZGeHoCq3crlEwi6DNh1QWQ9+guaM9yrAjMb1Mt3Kzd5W9O/HK28/X5Mr6p/nZQOam31Wz5DEYqiiBgVWh8ggkfGNG9V/2zc3BHqmMMIzFGZR17prYw/rtNLx5kkeolzAg4CRSRHC36geZ46zQyO3hdfe2G/kFt4TtOhRQFf0dp0F81u7eIwWju/8rTk7+Jfw5CoBTT5j/w5sfIwhA46QU4ojt2z4lJq9HNBa6VF9g1wYPqKxQsisFjEcpXOMYM2Y8gqMyD7/Je6NqmI4Sg7bQV9KKMpJn6UIOX7UgDbrKYbao7eqaK/SOVMj4xIArlwPPoqXGkIbM4dcztkJR4bl+mKOa1tDqROvhN6HL0De/DcQ11jvRaOztT7F3cnyEPTpMW7mTQa2IcsrFbKSzE8pfsA/C0mbPzUQ7/3NKUAiojaBOEV3jEjr35miDj2jd3teiTnnhNrJWur5CHnAUB6ztV8N3HFeqOgZoW3vhqxeITFueypuIVDoRvgO/jZLMObQ4aOH+i6oHPvp+APx2vi1fPZ3CB2dL81K4mkCUMihlFx+VKF5y+8YQAmsUO1oTz5NeUOD6rSNov8yXnU8wo/D1xBuJbCkod04TmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3980.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(508600001)(8676002)(316002)(66946007)(31686004)(66476007)(66556008)(38100700002)(86362001)(53546011)(5660300002)(2616005)(83380400001)(31696002)(6486002)(186003)(4326008)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG5SVjcwQXM2TXQyRzA4amdEczluNTVyVVVBTnBvb2U4VDVoLzFuOTVobEp4?=
 =?utf-8?B?Z0lvRDB4alpzdWpXTkVBK3hlZU9WVXVYSVNLU0g3YVJUVHgxQVJjVFAzVjll?=
 =?utf-8?B?ZGY1c1o0SGJUT2tpRERUQ2oyU2ZDRVdjTUlGM1JKMWdRR3gvV003NmFHdjh2?=
 =?utf-8?B?b3o2dlQyRkc4S1RSMFdYMGNUWWhPc2VYcVpidTZScWtNZGllbzRVcC9jc1Vp?=
 =?utf-8?B?RmJJZE9rdWM1UGNULzdvcXVUQXBZdGR0eUY2M0loaisrdC9POUlEVW5EM2Q1?=
 =?utf-8?B?ZzBtTjJ6N0xwTWp1eHpBM3piSU0xakYyLzFHUERzc2lzLzZ3RjZzZmRPUkZk?=
 =?utf-8?B?MkYxUThTQVY3blQ5aDhoNVRJRDVXL3o4VkhHWEE4OEpZZmNsaXlTVE91MFdW?=
 =?utf-8?B?QVFGRjBzdGM5QXhQWjB6ZEYxeTk3c0RHcXpPTEcyY2FZQ1ZnOTIrNkhtdU5X?=
 =?utf-8?B?YkMrYUtRNHNwa25ERjJzYTJWNFcvNUFjOVpmYXhIT1Q2d2FtZUpmbFFHc2dm?=
 =?utf-8?B?U08yQk03TERiUlBtOFBqazkySURiVnBGY3QyaFNZVzBBclprbEg2elVMYnFS?=
 =?utf-8?B?czVucTIzRTV0TnhoWDlkbjExcmIyeU0yNEFMN3VVRjlkalJwdkNjNGdSQVVn?=
 =?utf-8?B?dlZHSTVTMlJVeG9od3k4c2p4V3V3TEZiRjRmaWwwM2pZMHdKSmVQTk9SK3dI?=
 =?utf-8?B?WjZmTE5ha1pQSFlJa2pZbXp1L1lSblNvcEt1TDVrbFR2WjlJdXpoZWVYbmR1?=
 =?utf-8?B?Ulg2WG1YemkwVmFvQlQ4MjJxVUxhRlFhRVN5VTQza3pPdEN4WHAyUFpuaGt6?=
 =?utf-8?B?b1NNKzJuVk8rbGlwK1hoN0JoZWhtK2h4a0w5SVg4a3hFanpBUUlhc1I4dHJW?=
 =?utf-8?B?bndNZTkwMTVWUmZ2VTB0U2s3V1IyNlNVMUhLazFMWUJvY3p2azhmUG9BRDIr?=
 =?utf-8?B?RkhEeHlXaVR1d1djZGlPUERLVlFIcEpaL1J4SDFqckFaUkVreVhtTWk2a3JN?=
 =?utf-8?B?R09xRWdZUlowZm1McXVDSFJjL0lPMXQ3cUNUTHhvaUJ6UFlXbW9pVkZCUVZP?=
 =?utf-8?B?aHNDU0ZHY1I0QkRXMkE3ejF0MGY5SFluekpyMEZqRjBBS2p4U2Y0M3htOVdy?=
 =?utf-8?B?SVdwSjdyVXUwTDZlM1pVcDB6S1gzdy9WMC9TWUZoaHZmT20xOUtXYmxKMGdJ?=
 =?utf-8?B?OFBkeVFNNzFSZUZnTVNZeC9zbmJFY21wNHlxUXA3Sm9hVkhLQXJwRVVMYk5H?=
 =?utf-8?B?aElza3NDTnZWbUVudTlyVmxwL2ZNNjNxNHFyeEVsWTRyVEdtNEVuTHJ2OXFK?=
 =?utf-8?B?YUN1OGxmUzd3ZVVrWlNKbVI1OUtZd3l0RndIRGI3Y2JHQno2MmZVZ0pwRWFr?=
 =?utf-8?B?RWNiQVBIODY3RzRQYUR1M0NWbHJMUHFIRXdkaDh2Y3NSOEN6ZnUzMTFocERl?=
 =?utf-8?B?cUJteks3aFh6cXVJejhuYWZqZGVXcTBEQ2M4QjZuZ3FUNzNnNGo3S2tpZFVT?=
 =?utf-8?B?STVZYW40V1hNRUdnZTQ4aTZvdE94c1MzeHd3bGVjOXRiZk0rN1hMa3ZWUHIy?=
 =?utf-8?B?VGdTOVdNY0YwUUY1d2UwdHcwZEdJM1h0UEg1dkNTVlJtK1hwR3hKcmdta2Zp?=
 =?utf-8?B?dTI4ZjA1Q1NqR3B6SHpQRjZSQ0xBOThRWnZDQnJRVGc4RzRJWGp2ekozMWY4?=
 =?utf-8?B?M1JoSW1KMXQxR1p3Z3VkeWFvSm82cVRFcmpGYWtiVTNCdGFOK1hIL2pSOXZ1?=
 =?utf-8?B?OEtHRHNSdkRRdm9MR0JHN0lZNTdEVjdtSjNYSy8vMHMyMkpGNC9GZTZxbUhK?=
 =?utf-8?B?TGpKYURpci8rYjBHcDZaUG1HSTQ4bU1oVUhOQzNjK1dFL24rQWZZbGFzQkVz?=
 =?utf-8?B?azdUQ0dqb2FJSWtUQ3NNUG5jZ0FpcDRjZXNXSWxGalNjNFdMZFd2d1JlU1BY?=
 =?utf-8?B?VE5nczdDWFBteUVlYm11VzlUb2I0cnd0b2lwcVlobVcrQXNTVDlseVJYc1hk?=
 =?utf-8?B?ZmVDQkdIclNmWDVRck91REpQRzBKUjk4M2dsQ1kwMmVxM1NsU1M4ZXBnNUV4?=
 =?utf-8?B?b09xV1ZENmxDYlZCMEFQMXN1ZnduWDd2dzN1ZE1CS3NpeGxhRW1aeGVtRkho?=
 =?utf-8?Q?bkLKBMu4uLUSIlZjcpeUsAXMY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b1e8b9-84dc-46c5-71a7-08d998fcccae
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3980.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 03:49:38.4224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbrfn05irooThGRtp0P2RoOG4GZlhe9EUU0d+PsY4DlP5NqpUKmIUa55G2/fzIoZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4811
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: KaKzL0f1FbDne7tbBkU8VnDYdC00Wo0y
X-Proofpoint-GUID: KaKzL0f1FbDne7tbBkU8VnDYdC00Wo0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110270020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 10/22/21 3:02 PM, Joanne Koong wrote:
> This patch adds benchmark tests for the throughput (for lookups + updates)
> and the false positive rate of bloom filter lookups, as well as some
> minor refactoring of the bash script for running the benchmarks.
>
> These benchmarks show that as the number of hash functions increases,
> the throughput and the false positive rate of the bloom filter decreases.
>  From the benchmark data, the approximate average false-positive rates for
> 8-byte values are roughly as follows:
>
> 1 hash function = ~30%
> 2 hash functions = ~15%
> 3 hash functions = ~5%
> 4 hash functions = ~2.5%
> 5 hash functions = ~1%
> 6 hash functions = ~0.5%
> 7 hash functions  = ~0.35%
> 8 hash functions = ~0.15%
> 9 hash functions = ~0.1%
> 10 hash functions = ~0%


Can you please post update/lookup benchmark results just for reference? 
Maybe pick 8 byte and, don't know, 64 byte value sizes? Just for the 
history, because not everyone is going to run benchmarks to see for 
themselves.


> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>   tools/testing/selftests/bpf/Makefile          |   6 +-
>   tools/testing/selftests/bpf/bench.c           |  37 ++
>   tools/testing/selftests/bpf/bench.h           |   3 +
>   .../bpf/benchs/bench_bloom_filter_map.c       | 420 ++++++++++++++++++
>   .../bpf/benchs/run_bench_bloom_filter_map.sh  |  28 ++
>   .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
>   .../selftests/bpf/benchs/run_common.sh        |  48 ++
>   .../selftests/bpf/progs/bloom_filter_bench.c  | 153 +++++++
>   8 files changed, 695 insertions(+), 30 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
>   create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
>   create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
>   create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_bench.c
>

[...]


> +SEC("fentry/__x64_sys_getpgid")
> +int bloom_hashmap_lookup(void *ctx)
> +{
> +	__u64 *result;
> +	int i, err;
> +
> +	__u32 index = bpf_get_prandom_u32();
> +
> +	for (i = 0; i < 1024; i++, index += value_size) {
> +		if (index >= nr_rand_bytes)


this if seems wrong. If you allow index to go all the way to 2500000 - 
1), then you'll be reading value_size-1 bytes past rand_vals. Verifier 
doesn't complain because there is quite  a lot of space for percpu_stats 
after that, but it's a bug. Just drop the if condition and always do the 
index masking and it should be ok.


> +			index = index & ((1ULL << 21) - 1);
> +
> +		if (hashmap_use_bloom) {
> +			err = bpf_map_peek_elem(&bloom_map,
> +						rand_vals + index);
> +			if (err) {
> +				if (err != -ENOENT) {
> +					error |= 2;
> +					return 0;
> +				}
> +				log_result(hit_key);
> +				continue;
> +			}
> +		}
> +
> +		result = bpf_map_lookup_elem(&hashmap,
> +					     rand_vals + index);
> +		if (result) {
> +			log_result(hit_key);
> +		} else {
> +			if (hashmap_use_bloom && count_false_hits)
> +				log_result(false_hit_key);
> +			log_result(drop_key);
> +		}
> +	}
> +
> +	return 0;
> +}
