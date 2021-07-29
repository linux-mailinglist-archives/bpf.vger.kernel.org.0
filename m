Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C570B3DA963
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhG2Qu3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 12:50:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55914 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229556AbhG2Qu2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Jul 2021 12:50:28 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TGjFpT006918;
        Thu, 29 Jul 2021 09:50:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BcpE5jWcnVVb6i0X8FSQDcnAgp8QX4u/vSTMbfuzXlM=;
 b=nIzqqLwAJyR6i7o/Gz+cT/dPkZ99uq/B3lBXStwg2fI0rAVOpB7Nv/NOgLBqmLyOhemY
 Ibojk3xNgjHk1aZXYCMi8uWJKn0K2/Cp5G+yRPracqYcRAk+oYFyLw7dKLiEL2aBOc8N
 64CLkYwSykus+Pujb9Y0Gt7Dd+rQTyFSkgI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3vrt9px1-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 09:50:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 09:50:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5zGJ8aPsD+ZDnGKzIQNRIGsrToha2nyVGeipGZaqPz0/lT6sd3oDeGxQQsrm/d2+ecRm3FcjdKf5eYr9FsThxPbp+n4aIm/u8oHw0zDuiOi8WeniPZqHopMLyGff5yXtAtMOfCA+VKGqGGIxTyFJTsJxO58pdszq3CSkyGht5ckZQOrwIVTbZH0YXed+d/4WW1O5cMpp4xMQBHCvZEiRvQ53j3maSqPuCnRJqwrxbcRwnisIUCzOiMYc0qlwwiP7tAqOTSU3tMThAuATm9TK+R/xkNkRoMz83xm5I4/zgd1ysU+FCky8K/mLp++jvlho/UYDnFStk6XDMV4AvqA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcpE5jWcnVVb6i0X8FSQDcnAgp8QX4u/vSTMbfuzXlM=;
 b=KMMwrW3mQjSrbD0t6BnWpKrloc0oa7wLxblJrEbM/Xe6EBXQLY5aHH9HfL9ogNmmuMlZl8qa5NPknbh/TTRqpEEHweX5GDtkxef5kVtEO5PeHN+67NnhqlV/Zb8hbS2XIUnfFe7zdukisTaI/7kHj4lg2Pr2CjIbF8Xs85Fc40yZl1kzdShLPEyEExCr26Y+A9AtFlXyRkubAZ2d24+0MTXlT9f+YQ4gCHMpvDTUpXeqCJmW8yQpNEoYiXzgzdUyECtag2kIfvDM6M+FJrES6IsIoxYufmwYmIcRW6mckr6AMT1VjHx4Xrnn58dUare78Aepdt24QZ1yY62mGnwL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4707.namprd15.prod.outlook.com (2603:10b6:806:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Thu, 29 Jul
 2021 16:50:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 16:50:01 +0000
Subject: Re: [PATCH v2 bpf-next 01/14] bpf: refactor BPF_PROG_RUN into a
 function
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-2-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <92ed2fb3-6a69-415e-ca5e-fc516e38c60d@fb.com>
Date:   Thu, 29 Jul 2021 09:49:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210726161211.925206-2-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::11d1] (2620:10d:c090:400::5:81b5) by BYAPR11CA0078.namprd11.prod.outlook.com (2603:10b6:a03:f4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 16:50:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d03d62fd-c7ed-4902-e670-08d952b0e7ea
X-MS-TrafficTypeDiagnostic: SA1PR15MB4707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4707380D29C78C1FF9D7E39DD3EB9@SA1PR15MB4707.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioOPhHTgWPupUfjNCX76+lbrJiaIgahPx7fAnUPAQAOHLF2x+qT4B6CISiFs8dj8i+wchKnxN1R4P8EKAofEPBDHw0nz6P0EnrIoL02c6vNh+o+56t7ffuG1WJ7GHqECHR//k7AV/o0IiTzqOD4+6SkNLjZmv/dH0dQ+PelQlb9Q9Fd46ZI3eJh8EDwgBUjEzR7oOnVRxIhJ2lq5nX51/tsix6CefhRe+oqA6kJ/SdvDcYmhNTLIRt8/LXUVkmuEI0bULwgDkWJIYwuo8bsuCgvqk3tUzpD2iO4cimZkTutn3xoGriKiYWCwT3iQ5ZPgTCM2sSYB3t57GckTKWZnlmI05/HLh6UcfhKTBTfXvb8jlo8Shj4It5flxbEmyDnKZb1wWeYpdxXW7dTgsHQDPkFLnCjcrhvu7O0lI/rcpO/+A80Hvd1GiWWOpGomXS9LoqrJjv4JHhoLoirjaAgMNzzGV/pLjwJxuDbhN9hFFndgyGV9VVflLZSL+T22vBjJ5/lFezCSlxt17EF2xj51dCDgmjpQ0npgA169Vtkbi3w5Uv6nEwkVWeabf5o+MyO0fsu7pJb5i+8VwFTXyaG3CY7g/CJCo9poOicgwLkR3AxoJsM7lGy2AW5/E71Ppcuyuw1DK3YE6ILu3FHvSHMTrBL6fLo7ZSgAKneKo33Z/XdZYwljbJJ4fimrtC3331bN3akVTINaqC+5aXQWsFPQUUdD9Ew1AwbfbV1rCgQSPdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(86362001)(52116002)(2616005)(8936002)(36756003)(83380400001)(31696002)(508600001)(38100700002)(31686004)(5660300002)(6486002)(66556008)(66476007)(66946007)(53546011)(316002)(8676002)(186003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SktyYXRVUGkyc3lPeUF6OEhJUDNBdjV6cGVzV2w3azUyT2xFbk5OWU94WjNR?=
 =?utf-8?B?QU1UbzMzZ2lUanNpYVljZ2lwZWV2MnRrTm90M2NGbFRwKy9PTHpnZHNrUW1v?=
 =?utf-8?B?VFJ2Sk5zRE54dW9JUEIwckVmaGpjYno4eDJoK29VQVBNZHVoQzB4SEtqSi85?=
 =?utf-8?B?ZEJtZ29QVFQ5MWZVMmo4bE5lV1NEaFFkQis4NkVOdFVyQWE3K1BHL012SDhK?=
 =?utf-8?B?bkNRd1VsUnMwTXlrMDdiS3F1ZTlydldPd1JpTEowNUZYdVBEcExpbmlIU0RJ?=
 =?utf-8?B?ZmM3MFpjMUNwOHc2eGRwNjNqMWNqL3U4UHVXdy9JZE9abHo5RTJSbWpkSmpr?=
 =?utf-8?B?aTBkajVldHhseURBUFJqeHBoMkNhQkpNNjI5bXM5b1RUMi9iREswT3JuV1BK?=
 =?utf-8?B?K0hzQWRJbHhBRURFeG9BRTUvSDdLYUw2UTlmUlFOU0xMZWRpeGlPUDRZTWhv?=
 =?utf-8?B?MVJhS29NUlI5R0RXR1UyUWhXY2VybnoxL283dDZBQmJuZzJUOFlSU2NlUTc2?=
 =?utf-8?B?YUVyMTFZOURscm96WDFya1FYbUlOVUpZRnlaSE9GSFNBdDY3ZGRXQWc3SU04?=
 =?utf-8?B?SGE2VnpuSzJ2aFBQdDh0UWhGTXkzVjFDaTdTSmFNcDhjalVnWC9XL0lrMzBx?=
 =?utf-8?B?enhvQ0JqQUhYTUV6NVNGU253Q1ZOdi9uWGoxeFA2aDRQOEhlRjVJblo4VUpW?=
 =?utf-8?B?MjlDaloxWEoyaWNJUUJGakpFVlRwOUJEOElNMm85OHpMKytWL1pESzh6UlAz?=
 =?utf-8?B?RnlpcURiZmhuTFVpRnYwUHBtV0t1Zk1mL0dWakR2UlRiRFQ2dXVSOWUxT0Zt?=
 =?utf-8?B?QkQyTGVkQXRCbjltK1RuQjJjQlE2Vjlmd0M1TXNPMTQzd2crVjVkeU0wVXZO?=
 =?utf-8?B?b0d4by9FWDVxeUpYaVVlSUpkc0l2NmR1RTBITWxVVTdOcmFwOXl2cjFuTTBR?=
 =?utf-8?B?OG1uMEorQndWbFhESCtNZytEOUFmSDJ2WjB5ZlViRklMT1lzS0xZSDQvSGUv?=
 =?utf-8?B?MTVZTkVQbXRkNS9LSDVPb1F4RWNncGNPRGdia3QwckNhN3ZvbGZnR3JjbDZt?=
 =?utf-8?B?bWFGbUpZRXlLRDMxU083YmJKcUdXQTlmQTZtWklFeDM5R2RKZXlkY1BMUGti?=
 =?utf-8?B?WXk0Zk5maW80alNYUjNoeWF1NVFrZzIrajV6b0VoYmlIeXFzdzEyUHQvVGh5?=
 =?utf-8?B?NWlEOUtyS2FlV2lSK2hDM2NpV3I3TFBnbWcvcVYzK2E4Z2JkUExCbm56R0Yr?=
 =?utf-8?B?NE0wUTAwdVM4cjlsWThTUFFMWHY1UWRKSEg1b0piVjJ2aWcyUXN4MTd6RE5X?=
 =?utf-8?B?VmplWDlGSGRJdkM3dVRaeTVnUTNiZVNwMVp0L1R3RGwvaklLb1BXbFpNMGlH?=
 =?utf-8?B?a01tT1VRdXJGVkFLS3ZpYlVNLzBCZVYwSkxrSTJQcUUwWi9naHRWRzBaMUtQ?=
 =?utf-8?B?YTgrVTVtVHpHVng4ZVc0Mm9wakIrT1gzazJHcVpDOURENUZXR014RklPMUUy?=
 =?utf-8?B?WkFJRUI1ZUFlRngwRGtaUEFWVThvZytUMkhnOWRlcjlML1l4VlM1b1VUeFAx?=
 =?utf-8?B?cUZ5c1pVd2JOVEtWRUxERXBNSEowZGpRbWRJU2dRREtIRHpFVU1jQVEyYkVD?=
 =?utf-8?B?NkJHcHZPUDlnNUtnZlYxMFdVZDNJbTN0eW82VWk5bHR0OHVoV0lNOGtZVlls?=
 =?utf-8?B?Y1Q1amJ5dmdwRTJRd0RtMFp6bGJYU2I1cTE5ZldNNklsUDNFWVU0bjFKcFZS?=
 =?utf-8?B?aEtxOFVIVjZzSFYvWFRFZWJFR2tDeGJkdU9sMHlTNXNjZFpldVJRR2VhZXhh?=
 =?utf-8?Q?Gd68+3oC7hYX3dfvMpixdjVyhKRWdd7NpaAwk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d03d62fd-c7ed-4902-e670-08d952b0e7ea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 16:50:01.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzPGejskPKNHzsbHAAh4q9qL16EaYEC0t/Upu2lJRpbNplRfbtpdqBbQYo5IGoce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4707
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: HZ139Cu5fDrNUp0yEYiewdp3i2n3CRVo
X-Proofpoint-GUID: HZ139Cu5fDrNUp0yEYiewdp3i2n3CRVo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_14:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/26/21 9:11 AM, Andrii Nakryiko wrote:
> Turn BPF_PROG_RUN into a proper always inlined function. No functional and
> performance changes are intended, but it makes it much easier to understand
> what's going on with how BPF programs are actually get executed. It's more
> obvious what types and callbacks are expected. Also extra () around input
> parameters can be dropped, as well as `__` variable prefixes intended to avoid
> naming collisions, which makes the code simpler to read and write.
> 
> This refactoring also highlighted one possible issue. BPF_PROG_RUN is both
> a macro and an enum value (BPF_PROG_RUN == BPF_PROG_TEST_RUN). Turning
> BPF_PROG_RUN into a function causes naming conflict compilation error. So
> rename BPF_PROG_RUN into lower-case bpf_prog_run(), similar to
> bpf_prog_run_xdp(), bpf_prog_run_pin_on_cpu(), etc. To avoid unnecessary code
> churn across many networking calls to BPF_PROG_RUN, #define BPF_PROG_RUN as an
> alias to bpf_prog_run.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   include/linux/filter.h | 58 +++++++++++++++++++++++++++---------------
>   1 file changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index ba36989f711a..e59c97c72233 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -585,25 +585,41 @@ struct sk_filter {
>   
>   DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
>   
> -#define __BPF_PROG_RUN(prog, ctx, dfunc)	({			\
> -	u32 __ret;							\
> -	cant_migrate();							\
> -	if (static_branch_unlikely(&bpf_stats_enabled_key)) {		\
> -		struct bpf_prog_stats *__stats;				\
> -		u64 __start = sched_clock();				\
> -		__ret = dfunc(ctx, (prog)->insnsi, (prog)->bpf_func);	\
> -		__stats = this_cpu_ptr(prog->stats);			\
> -		u64_stats_update_begin(&__stats->syncp);		\
> -		__stats->cnt++;						\
> -		__stats->nsecs += sched_clock() - __start;		\
> -		u64_stats_update_end(&__stats->syncp);			\
> -	} else {							\
> -		__ret = dfunc(ctx, (prog)->insnsi, (prog)->bpf_func);	\
> -	}								\
> -	__ret; })
> -
> -#define BPF_PROG_RUN(prog, ctx)						\
> -	__BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nop_func)
> +typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
> +					  const struct bpf_insn *insnsi,
> +					  unsigned int (*bpf_func)(const void *,
> +								   const struct bpf_insn *));
> +
> +static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
> +					  const void *ctx,
> +					  bpf_dispatcher_fn dfunc)
> +{
> +	u32 ret;
> +
> +	cant_migrate();
> +	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
> +		struct bpf_prog_stats *stats;
> +		u64 start = sched_clock();
> +
> +		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> +		stats = this_cpu_ptr(prog->stats);
> +		u64_stats_update_begin(&stats->syncp);
> +		stats->cnt++;
> +		stats->nsecs += sched_clock() - start;
> +		u64_stats_update_end(&stats->syncp);
> +	} else {
> +		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> +	}
> +	return ret;
> +}
> +
> +static __always_inline u32 bpf_prog_run(const struct bpf_prog *prog, const void *ctx)
> +{
> +	return __bpf_prog_run(prog, ctx, bpf_dispatcher_nop_func);
> +}
> +
> +/* avoids name conflict with BPF_PROG_RUN enum definedi uapi/linux/bpf.h */
> +#define BPF_PROG_RUN bpf_prog_run
>   
>   /*
>    * Use in preemptible and therefore migratable context to make sure that
> @@ -622,7 +638,7 @@ static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
>   	u32 ret;
>   
>   	migrate_disable();
> -	ret = __BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nop_func);
> +	ret = __bpf_prog_run(prog, ctx, bpf_dispatcher_nop_func);

This can be replaced with bpf_prog_run(prog, ctx).

>   	migrate_enable();
>   	return ret;
>   }
> @@ -768,7 +784,7 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
>   	 * under local_bh_disable(), which provides the needed RCU protection
>   	 * for accessing map entries.
>   	 */
> -	return __BPF_PROG_RUN(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
> +	return __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
>   }
>   
>   void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog);
> 
