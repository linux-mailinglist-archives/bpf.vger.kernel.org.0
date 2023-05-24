Return-Path: <bpf+bounces-1147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C263370EBB6
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 05:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACF828118C
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 03:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8A15B2;
	Wed, 24 May 2023 03:13:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C0EC2
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 03:13:06 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448ABE9;
	Tue, 23 May 2023 20:13:05 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NLaglm026939;
	Tue, 23 May 2023 20:12:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=sLbe+XRRyJ6N+eZpUT6jXv0f4wCZxIvQalngL9yzxH0=;
 b=JcdmPSRAoeCg8xV9+D2Os+2CRQZ7RHUdQKNQ6nzZO8AuHU/ZS+iCDD/SwNg51TsTOMtv
 8HtYGw/kzQiC5JwaY0Y3Z1xYJLn/ImrxmX4WajtSJC3TzPEc9EbexBbLCs+K+TKK+oWn
 u7dNcAdVmxGF9oxkNZKYPprmI7a7L8yxSEts6zGW9SoxYPsyuQ/O+lLgClytX+1OYU7C
 3noE/xRvRx4WAzW8eogUi97pJPqH33n1XWtKd59rlN8dN+f1PgFTQTyzJ39Gg9Sbs4jd
 Nvv+Cula7drb9JCFWum/foZQxakMKQZTHQ7F9vwKyjapSh/1fhwQSWFhprmYYvbuYlPp 7g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qs5j49p2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 May 2023 20:12:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/UQYg2r/IedCSR/ZvHobp7+wMspJbT0mUY7qo6GQRf7NidSyfD09HbTk8IsztVZWh4tpfPcyiMcoS+p8AWrUEIQXeDfIgWFiFyMo8+fmQV2L59sYeS5mTDlOcqtoOf1lNdUcg5bv0IDbwW5+9BaXlfsEg5lOED+REJxt1Thecg1y+/pJPPBwtuN4M1zm2RMmEaslFFi+x6auS04KntDuGHpKS2bR5Trtmh8LE0AA0ojGfg2CfVkt+lhbm1/oo352+UyBYHJzwaO1mZFDOzLkJ1XhbD/lvAJtmzQ0xrLgHyIF+uNhrYfiOtdUbY6NQHytMLRUG5cSt8vJd/R5J69Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLbe+XRRyJ6N+eZpUT6jXv0f4wCZxIvQalngL9yzxH0=;
 b=NOYCVSg5rVjqGJeKT5VAnaPcAqFLEVe5l9JlgY8zFHx4RAmTsy9mEpUrj15DrJs157S+nmmxRFha2iZyWpCm7ZhB1CWZKe398k16qTTKpgkvffghWfcViTVRtvgYZUnXn9eGhD7DnYZMfaYhYyIb0klg2S3IY9FwWQlxzCVWJEd7kdWt8w8Fy0oUxfF53jFahzd4brXfENlPSDNm2Zm+aQ/+jb6IPebznZvrHl0KiKwNhVHe6traYet7VawpioQFQFPuJSHqMEie+rqz71hcKVNQ111eBrzVeJPYju8no5gbdAShakG3KkSpnLCXAtj2ypZl2o1TSqkmKXytDTxFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB5993.namprd15.prod.outlook.com (2603:10b6:8:189::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 03:12:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 03:12:36 +0000
Message-ID: <3c029fae-cb42-5a75-2858-7b8fc56a8769@meta.com>
Date: Tue, 23 May 2023 20:12:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] [v2] bpf: fix bpf_probe_read_kernel prototype
 mismatch
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Delyan Kratunov <delyank@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230523194930.2116181-1-arnd@kernel.org>
 <20230523194930.2116181-2-arnd@kernel.org>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230523194930.2116181-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5cf81b-8b60-4efa-1021-08db5c04b94a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Qb2z61s0sVBT56ZyZB7hIRVqLAuZ0U9uMoFl/MqyLdyBIrTm4Pidj0QJhVfvVE7gdgfdtn2V/CbUMmwQmUPN5chA1kh8TJufj6u1L1uZuiufmbxVu8u+K/UApq0KnUgj5vN3GoakRuJ1LvchQgsrpSk/cB3B+5UjobCm15Z+7eE5YjbYJ4WdyeWjRlDSEhz+VFo8gdAqVAuo81lSfjLJzzQobtdk60NINaPEPexvs5/Pw7I2LtHpHq2LbqEboInuyeNRegnSbtC+C4/JMiUVnE7ij+iTjuRXjQQa5wA4oUzuhR5wIN1Kw4TecKOo+YoibabUK+YYSsZD0yIMfdd8fMPOYmW/EZLr+zfVhaz/FqzYCcXJ14lNL/p3auVRWWqKkJ8ctmbdkQi7q3i5yrU76m9+MfiE4Wcn/WAjUGgKvPuyolT6p3X0rsdqjIvlzWKeQByZYdaiXdbGIkKYODKt91TmnMJlHV2FqI9xr4WtV81dm8hfhVHfOBA0TYRVHldksRKPm/ICCprMnMQizx+mBeddHrGvVg1qa4jdNqdoqvPGJMs2Ppwb99bXDC0ZxmskCbQZVUvMps80HyOuaNV/R+D086G85Xg0C/7LrTk1zZgY70msEqaYCcnuT5g3ROs7RqnAjCfEfKewyQe0/JoSuA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(6512007)(6506007)(53546011)(7416002)(2906002)(2616005)(36756003)(186003)(83380400001)(38100700002)(316002)(6666004)(66946007)(66556008)(66476007)(4326008)(86362001)(41300700001)(6486002)(54906003)(110136005)(478600001)(31696002)(31686004)(8676002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WU9VZG52c1N0K2htemlBVjhZNWkya29XcmxMOThuNG5BNFVoSnA2ZndUcU1Y?=
 =?utf-8?B?T1pCT3RNYzhZcjlvTDBpdTA4TUxVZURwRUErQW5DWFN4QmFsUjJNM3Ewend3?=
 =?utf-8?B?aFBVVk5wQkdyU2pvUEhQM3JRQzIzdlg2NExLNEF6RlF0M21Hd2s5OGdiNS8y?=
 =?utf-8?B?QmRLbkFCeVdzc3VUTUsxRjZiUXVFWTlNWEs3MjVUMHdjR1JWTm9CWHBSTGI5?=
 =?utf-8?B?ZEtON09nNmphNFowdU9LVGxGOGVOL1paUDVBSWFaUThpTE83WHh4cDZhYXFv?=
 =?utf-8?B?Vi9wblk3b0pydVNGMXV0NjNOeno1R08ycXl4eWhwNC9ncUZKbUR6Um90NWNp?=
 =?utf-8?B?bk1DVE9pT3puTzhQc0VRbEV3ZmxPa2Y1dm5hRHdFMGdscWR1cE5oZFc2ak9D?=
 =?utf-8?B?NVluWlgzSmJDc2lGRzZNUXZKWmNZWDdBU3kvWCt5Nmw1b2Z1dVo2eHJDcDJ5?=
 =?utf-8?B?RHM1VGFMcDFvV1laWlEwMGVpbWZpQzIvb1h5eFIxNis0a082cGd0aGxMUy9C?=
 =?utf-8?B?ZG1wN2hoZ3VTaXMzZ0d0UGNRbEN5YTdxQUVIekhYZWxicU9SWlBCd3ByVTln?=
 =?utf-8?B?blpVRjI4c05xK3JMdFZpc0hPSnp6dVgyVDhabFlqaDA0ak10MSt0MktucDZl?=
 =?utf-8?B?YmtmYkoreVlXM2Q2ZGtmNEVhUUMwRCtsV0RQRW5GbFdqK1pZb21nMUxFaU55?=
 =?utf-8?B?NTBlRjB4RW9YbzVXTllLcFZ6SGc0OU5lQlc3elBCcG8rdENrbThQYXBNMzQ2?=
 =?utf-8?B?aEQ0TTJPMllxVUZmalZ6Zm0wOTBQbWtRdlNveUlhc2dvVHBXalArUzVOdzgr?=
 =?utf-8?B?UzlucWhMOW15NEJDZnRnVDBsYXJ3NVFTVmRyLzR1Z01UUHJ0OHJXVUJibytV?=
 =?utf-8?B?MDE5dkZWcHhidElNRG5aUU5obWVOaDI5eWsyTEI4aG1ZQ2k2Wncrd3paZS9Q?=
 =?utf-8?B?RWFQNVhkR1J3aGE2aVliMEdDdjRqQStQdE9oc0lBNFRVeU1Lb0tFbWNteU45?=
 =?utf-8?B?ODNsQ1F5cnpJNzFpWE5KZkViTHFOdXhTTmxGK2MwZklFMmEyblFzbVc1TjJV?=
 =?utf-8?B?bjUrSnZkbmtPRktWdC9ybDkzLzVHRUl3MElhNGVpVERKbnhXWUpqOU1tMDR4?=
 =?utf-8?B?a2o4NldXQ3lYYnQwODZ6dlF2QUdtaUVCY0haWUFEWThUSGNTaTZlSGh0b01t?=
 =?utf-8?B?OXN6Z1dwOVhtb3hqYUJsMVA1OGltYldkeDhWVFY3RDd5SHBrR0M1Z1FzWTFW?=
 =?utf-8?B?WHIxZVJVVWRneXlaZ1dQZ1AwQ3hUN2RYeVhUYkNCdWRqenFGM1FVUkcvd05r?=
 =?utf-8?B?a0dBREZsenhYckRpQ2tscXZMVXZTL2VKMWN0OTJXdjVkWE51bzIrQWZkWXdQ?=
 =?utf-8?B?MFEvUEtQVElDWlEzbGptMXU5T2VTMWorN1pHeGJWblJVRTlKVk9uenVEWDJo?=
 =?utf-8?B?cnhxWFpJZm9KTGJBckZ5MmlUbVdoaURIK2NFSk4zcncyejJOMC84ZXh3MXJZ?=
 =?utf-8?B?L25wM2tHQTZTYUhuNFhkaUd3ZklEbTJodFBBUEpWR3pxMlNWdXYxUUdMQllt?=
 =?utf-8?B?QUZTTTBUYzdZS0QybnNxQy9tMStUakQzUXNGU1ZMYlFYOUNtUEFBcEpyWjd2?=
 =?utf-8?B?Z1RuVXorMGRLRklteEg1ZExjQ1ZkdG9pN3BWYlRUWVJpd1hGQ0NLeEh3aTIr?=
 =?utf-8?B?cHQvMXF2QmU2UzFWSEFTMVJ3azJ5NjE1a2JLR1VONU5zbjI0c09nbmhBbEJR?=
 =?utf-8?B?eTUrYTRsQzE1ZlM4WVpuWUsvdG5sREhoUGl4VGtNd3FjVkx3eEh1bXJGZEI2?=
 =?utf-8?B?dzJWbk56Z1hlYXQrYk9QUUFZV05XeU1PS2ZpOWswLy9uRFRKa3RvU3FyQTY2?=
 =?utf-8?B?M3YrTTdSUkpuV2VENjRSTGZ3ZEZSbUZwME1RSzR0RWIvdXF6QStmSjNjVmw1?=
 =?utf-8?B?T1JVUnJNdFBNblB0Y2RMNys4RWxNdG9BSXpQWkpvb3NwYnVJR05INDB6LzRS?=
 =?utf-8?B?aGh1WDVRdGpyc1d6NnJzT3RUNUZtUWdGOUpraVF5N01lbTQzb0NZaWxEaTJZ?=
 =?utf-8?B?c2Q0dDFuT1djbG1jaEdaMGZ6MUJTL1BpMUR0cjR2bklqRmJxR004ZDZqSHRp?=
 =?utf-8?B?MzkwelNmRHN6SmxLTmI3M21OVElkdys4R2lybjZlbGU5SjhNUlROWUs4Qkxr?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5cf81b-8b60-4efa-1021-08db5c04b94a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 03:12:36.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnR0KnXPuafu3phslPWv5eUdH12keiFmi6Q4fA8jdvXLxSmgqCfqnnSWc1oeBg3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5993
X-Proofpoint-GUID: i5dQz8konZHkIWhjuXPsM-jmujpu5s-b
X-Proofpoint-ORIG-GUID: i5dQz8konZHkIWhjuXPsM-jmujpu5s-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_16,2023-05-23_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/23/23 12:43 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> bpf_probe_read_kernel() has a __weak definition in core.c and another
> definition with an incompatible prototype in kernel/trace/bpf_trace.c,
> when CONFIG_BPF_EVENTS is enabled.
> 
> Since the two are incompatible, there cannot be a shared declaration
> in a header file, but the lack of a prototype causes a W=1 warning:
> 
> kernel/bpf/core.c:1638:12: error: no previous prototype for 'bpf_probe_read_kernel' [-Werror=missing-prototypes]
> 
> Change the core.c file to only reference the inner
> bpf_probe_read_kernel_common() helper and provide a prototype for that.
> 
> Aside from the warning, this addresses a bug on 32-bit architectures
> from incorrect argument passing with the mismatched prototype.

Could you explain what is this '32-bit architectures ... incorrect 
argument passing' thing?

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> --
> v2: rewrite completely to fix the mismatch.
> ---
>   include/linux/bpf.h      | 2 ++
>   kernel/bpf/core.c        | 9 ++++++---
>   kernel/trace/bpf_trace.c | 3 +--
>   3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 36e4b2d8cca2..6a231ec61a87 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2619,6 +2619,8 @@ static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
>   }
>   #endif /* CONFIG_BPF_SYSCALL */
>   
> +int bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr);
> +
>   void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
>   			  struct btf_mod_pair *used_btfs, u32 len);
>   
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0926714641eb..e7f0d5f146fa 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -35,6 +35,7 @@
>   #include <linux/bpf_verifier.h>
>   #include <linux/nodemask.h>
>   #include <linux/nospec.h>
> +#include <linux/bpf.h>
>   #include <linux/bpf_mem_alloc.h>
>   #include <linux/memcontrol.h>
>   
> @@ -1635,11 +1636,13 @@ bool bpf_opcode_in_insntable(u8 code)
>   }
>   
>   #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> -u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
> +#ifndef CONFIG_BPF_EVENTS
> +int bpf_probe_read_kernel_common(void * dst, u32 size, const void *unsafe_ptr)

void * dst => void *dst

>   {
>   	memset(dst, 0, size);
>   	return -EFAULT;
>   }
> +#endif
>   
>   /**
>    *	___bpf_prog_run - run eBPF program on a given context
> @@ -1931,8 +1934,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>   		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
>   		CONT;							\
>   	LDX_PROBE_MEM_##SIZEOP:						\
> -		bpf_probe_read_kernel(&DST, sizeof(SIZE),		\
> -				      (const void *)(long) (SRC + insn->off));	\
> +		bpf_probe_read_kernel_common(&DST, sizeof(SIZE),	\
> +			      (const void *)(long) (SRC + insn->off));	\
>   		DST = *((SIZE *)&DST);					\
>   		CONT;
>   
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 2bc41e6ac9fe..290fdce2ce53 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -223,8 +223,7 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto = {
>   	.arg3_type	= ARG_ANYTHING,
>   };
>   
> -static __always_inline int
> -bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
> +int bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
>   {
>   	int ret;
>   

