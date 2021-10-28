Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C0843EA4B
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 23:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhJ1VRb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 17:17:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30592 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230404AbhJ1VRa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 17:17:30 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SJv9TV006728;
        Thu, 28 Oct 2021 14:14:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=MHzH/AZ7+ScKx8Baa98UIdq6Dk1Zi6E8rQkttWlhZHo=;
 b=nLK0SOrnJeuNfPIavrsPQOnvG1WDKme4sKEFYOpOsXJjdcEE4fitjcnVTBO2VN+XgklA
 jxEuefMXuivAsfOxH2Blc5WYG+aZwhMUOtDRRixVAYEEbVOwARQORPXEsCqxrQ6ZgOY1
 ZSm1Uw/rcIBNzT44Phq9VCuSY7GRTgkXmK4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c02fdghf5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 14:14:50 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 28 Oct 2021 14:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+z9U7QMb/n/wEQFx3HmZ33f8fTCjBgPvnSIoVtHVC5V3uqY+RHp+zvIm4G+1fa+xR7dfZa1E8xUfSavfb6vaqaYrOL1waw10hHjUMGvjvvg87eqAJOnrQePkdOKw4ECJopb4PIp5rspclWJAiBv8lZWQ8Dlq0UVwtC3pSbiJkKacH+1yQEQ6fXqX7nrYzU5f6JtnudRPY6idKhpu6YDke0SOwxxD0vWzoo0U7cBABuHZ8OWch8tTRS2atI6bDeAymZpz5k/FHAQWk5t8gGMsKMELYFd88rXyKC2sUoZhWxU/4OAmuP7SKmTgrQNaokp7Tf+jqVKVq3uZXWjBibOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHzH/AZ7+ScKx8Baa98UIdq6Dk1Zi6E8rQkttWlhZHo=;
 b=CqpJq6hj403rkbhHukmJDHiZkDr0qf/IimCnByDWi830Q6vP5HXgq6O+AFbDl4sgOHYg7W1RjEnQOkXIQcT5l9cswlj/KbyG9Cqszl6AFc/f77L/s1TNnN844dNPlQNlWK2/n0oiFgZu2kAzb4DcVl75MMTwu56YJwnwj4M+So5HVp/ZgF/RhGRnhn8DjsZA5svt2cLJVP3PL2v5P9I/V2IjEw7IlnIzUnsfZ+OzWsYua5yNZKm3YlN1JAvDClpLzdRYfQAV11H/q5qC2OFYXNVXs4qAv+5LV/hzLrkrGz2Vos3K9w3+1iqPPkSrP6WhhDH88ENPoucRF1KLfFRHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4371.namprd15.prod.outlook.com (2603:10b6:806:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 21:14:46 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%7]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 21:14:46 +0000
Date:   Thu, 28 Oct 2021 14:14:24 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
CC:     <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <Kernel-team@fb.com>
Subject: Re: [PATCH v6 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20211028211424.m5y4kafaulvgke54@kafai-mbp.dhcp.thefacebook.com>
References: <20211027234504.30744-1-joannekoong@fb.com>
 <20211027234504.30744-2-joannekoong@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211027234504.30744-2-joannekoong@fb.com>
X-ClientProxiedBy: MWHPR22CA0018.namprd22.prod.outlook.com
 (2603:10b6:300:ef::28) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:e99c) by MWHPR22CA0018.namprd22.prod.outlook.com (2603:10b6:300:ef::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 21:14:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cea27e1-11d1-4bad-4c3f-08d99a57f7e5
X-MS-TrafficTypeDiagnostic: SA1PR15MB4371:
X-Microsoft-Antispam-PRVS: <SA1PR15MB43715F382D0FE1FEDAC075A5D5869@SA1PR15MB4371.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpEB4I+0Gij9EzAcbQP6HXBl7zkSSIU+UCfFVZZvTgwH9fPWkoyo3mxIxFhplLucO+MJRoswy7LUT3wzCBIGhYOykStHw9E4WH2gq3CiikaCvwbzbWTt4EhYKEl2S5vrbJKomt5+mBsnYrBTpHKaSOfOOZ/4yTm7ztBqwQqVCLKUR9/dSELuq2dqP9odpCktHyUHRIiSq7YmHKkroHNs/kjW9ULZRTRPVEErimnGWUKMkx4fiXi1fZ9sB5GBPycqBU346Kfjs5uvZrpmmkIKdz+9T2DWTI4QENrhNESmKMY6ZPahIJoN2sZ91rcmzP+Azr5ffZh5FdBOBx/rYFsfxYlguWDmIuq2qw9uUL9Ap8wCjudOMYjQ2AvpHIlJeLtUNQ12lB/i/mgJCY37LOlOrVX0E53iUG7zNv4jXmNmxH4NreCnoce43wOAoX0v0OcxEvKmuEcJyC1Q5iOoQBydx9Mgy8tpSSINS0hGZAUInk5/AyZsbiBy2CURFdcA9JOHNfBm+i0BlbRYMBORK0loVQZOnEu4FnyMlHrG4aqlAPdmgAm+WFNCGsDdhUAo9d/5jz059w4U47d4dCCs1Ae/jHhCdev8gTtPSjTzGFgC2yzijQdwDNSHfi2eSawfN70qePCBz73EeJXZCVDveq0KCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(2906002)(186003)(9686003)(6636002)(1076003)(55016002)(508600001)(5660300002)(6666004)(4326008)(316002)(6862004)(6506007)(7696005)(8936002)(8676002)(66476007)(66556008)(66946007)(52116002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NY5ttzw0Ofis9KMhcU1onuy3TyB3BidmoYCsYJZ+vB9awjrEwSawjATlvYL4?=
 =?us-ascii?Q?/Na390gW/xXdhCZcLah6LyLVABk7rtklGgLyyoEXRXgwDkgGcHk7/c/eS2LB?=
 =?us-ascii?Q?KECnYaGQv4sre480BNtMvhVcdORnlqj8pmfI/m8PjhIC5cwmITsmneEMcEsk?=
 =?us-ascii?Q?AgAoa47ZAPZ6iMDbxJtrCSzagNH0OBgzgsz9B2GyZXlvm7+Lq43oqoY4XXVz?=
 =?us-ascii?Q?c8AFHIU4cTtUZ/oinIMGOzs5TyqZFRYT3ca9VOYZX+XNUJOYHLj2aRmsxb7Z?=
 =?us-ascii?Q?b+DF6NiygZxnWKY3S23KXDQLH1KiIZ071oFCafI+JtdJ8bJiPdfZnxfg6cVC?=
 =?us-ascii?Q?8vTdRLYxa0mQ/Njp+yAFXXct2inuo06NtpHHw0Y44tn+TmxxUurshQlTDatj?=
 =?us-ascii?Q?DZQwR5uJtskitQ0YEJIMmMa3+7hrNj1eQt9yJz0hoUn0b+2O6n7rhat3xjpc?=
 =?us-ascii?Q?cpiTVF25Rik9ItX9a12V1JgLmTCqTLABVeqdxs56r2FpJHgi5wTxdgLH4jud?=
 =?us-ascii?Q?F8FKdchBKg1c3qObagEn45CbrnVBjIBxyFOwR3j91xuVpgFb1wosYya6pefj?=
 =?us-ascii?Q?iYC+P4eyPQRPDcsa0vAaciKzMrKP9cv7FHTQZi0+2VrXOMPTqis6Evd6J3Cc?=
 =?us-ascii?Q?1fb7I7XISukFbBSPVfl4dYaZJ58GrtuQVQsNSkpHBop0OI/0PRmLVX2d+Jg5?=
 =?us-ascii?Q?9nYRVFQMey2b1UhELAPYlaVvXdfMn3RmPkMzfWDvHqbeT3vl0yqj8REukWNz?=
 =?us-ascii?Q?OXyxSVczsAYp2LZiFEbstX+1PjYdS59PJfkVVIFCrSDsiukhFhfLxYE16T6a?=
 =?us-ascii?Q?8TRHBg06uSVMKMRhHXlErANJ+l2o0y1jUopZ6rtldIL3iSbqY9XUrcifOnGJ?=
 =?us-ascii?Q?qu1KwsZ7jO3a53D+QnetegsoHGohd39YFUcKe+gXxlMoHhgyjX+lO7ymth9F?=
 =?us-ascii?Q?6ofwOmtVYzvmqBknBm+uzyLFRmkVlH3XEK3NykNx0kTPAyZgrMcu0lxhk0tF?=
 =?us-ascii?Q?VxSArV/zYRPM3aAoxiIAPcZR+P1F4nhhu3LDmeamRmW7aBs3Atsw0ysSwJIS?=
 =?us-ascii?Q?V1YMGf5rRIo4hD5XKwPicmVcklSbtqLaYXbz5FouxLvTF4Zwx96zDeiWSCjr?=
 =?us-ascii?Q?wBxVJs3DucCd26R65GUy0FUQ22R46rLyzZKCLVmS5XTf7K1+4udLI4kMzy/9?=
 =?us-ascii?Q?zr1SdRSp/JcCUeF+4X/GJN5RT/JyKZsN/7HI+e61KYOpaqm7mOfciS2qYOrY?=
 =?us-ascii?Q?oH66LWScGIlrO20gGtvHW7M4+EWv7u43w8sbUTKRvsVtSgH6+JYkDEK3SbZL?=
 =?us-ascii?Q?g1rBj9He0IrrzjtdklMaJaXdocxUHTXqCr8sB5wYnYVGmH4LKpb3UjKMtRwv?=
 =?us-ascii?Q?hjF0lDt8wPCkw1do1SVq1k/bQPoOgD6Bk9vOHDcaNqB2bvHn3A0SLXtWX/KW?=
 =?us-ascii?Q?xIA96sYSQ26TUHTm+S8DIuMH31hvGuohjin031awqai763RAHZGltSerBD/G?=
 =?us-ascii?Q?h9246fNVi1HbTq6PPNvbFQ9Fp+m2FXAMP8ZVfRzoJ6HmHjWrmYTz7d1TkTI9?=
 =?us-ascii?Q?/NytvVxDpfl9v8DEpGrHgZJKfTYX1AmqnpChqblR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cea27e1-11d1-4bad-4c3f-08d99a57f7e5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 21:14:46.4474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOAQw3s9C6IZczQThjl0hxndDtsOWujJcm7FMiNO7dDii36YvLSyNT1PrKzRxQw3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4371
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: A5DIPNYPaW0akmiN9PQMBaf8Y9YcYeez
X-Proofpoint-ORIG-GUID: A5DIPNYPaW0akmiN9PQMBaf8Y9YcYeez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_05,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110280111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 27, 2021 at 04:45:00PM -0700, Joanne Koong wrote:
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 31421c74ba08..50105e0b8fcc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -169,6 +169,7 @@ struct bpf_map {
The earlier context is copied here:

	struct bpf_map *inner_map_meta;
#ifdef CONFIG_SECURITY
        void *security;
#endif

>  	u32 value_size;
>  	u32 max_entries;
>  	u32 map_flags;
> +	u64 map_extra; /* any per-map-type extra fields */
There is a 4 byte hole before the new 'u64 map_extra'.  Try to move
it before map_flags

Later in this struct. This existing comment needs to be updated also:
	/* 22 bytes hole */

>  	int spin_lock_off; /* >=0 valid offset, <0 error */
>  	int timer_off; /* >=0 valid offset, <0 error */
>  	u32 id;
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index 9c81724e4b98..c4424ac2fa02 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -125,6 +125,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STACK, stack_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
>  #endif
>  BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
>  
>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c10820037883..8bead4aa3ad0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -906,6 +906,7 @@ enum bpf_map_type {
>  	BPF_MAP_TYPE_RINGBUF,
>  	BPF_MAP_TYPE_INODE_STORAGE,
>  	BPF_MAP_TYPE_TASK_STORAGE,
> +	BPF_MAP_TYPE_BLOOM_FILTER,
>  };
>  
>  /* Note that tracing related programs such as
> @@ -1274,6 +1275,13 @@ union bpf_attr {
>  						   * struct stored as the
>  						   * map value
>  						   */
> +		/* Any per-map-type extra fields
> +		 *
> +		 * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the
> +		 * number of hash functions (if 0, the bloom filter will default
> +		 * to using 5 hash functions).
> +		 */
> +		__u64	map_extra;
>  	};
>  
>  	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
> @@ -5638,6 +5646,7 @@ struct bpf_map_info {
>  	__u32 btf_id;
>  	__u32 btf_key_type_id;
>  	__u32 btf_value_type_id;
There is also a 4 byte hole here.  A "__u32 :32" is needed.
You can find details in 36f9814a494a ("bpf: fix uapi hole for 32 bit compat applications")

> +	__u64 map_extra;
>  } __attribute__((aligned(8)));

[ ... ]

> +static int peek_elem(struct bpf_map *map, void *value)
These generic map-ops names could be confusing in tracing and
in perf-report.  There was a 'bloom_filter_map_' prefix in the earlier version.
I could have missed something in the earlier discussion threads.
What was the reason in dropping the prefix?

> +{
> +	struct bpf_bloom_filter *bloom =
> +		container_of(map, struct bpf_bloom_filter, map);
> +	u32 i, h;
> +
> +	for (i = 0; i < bloom->nr_hash_funcs; i++) {
> +		h = hash(bloom, value, map->value_size, i);
> +		if (!test_bit(h, bloom->bitset))
> +			return -ENOENT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int push_elem(struct bpf_map *map, void *value, u64 flags)
> +{
> +	struct bpf_bloom_filter *bloom =
> +		container_of(map, struct bpf_bloom_filter, map);
> +	u32 i, h;
> +
> +	if (flags != BPF_ANY)
> +		return -EINVAL;
> +
> +	for (i = 0; i < bloom->nr_hash_funcs; i++) {
> +		h = hash(bloom, value, map->value_size, i);
> +		set_bit(h, bloom->bitset);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pop_elem(struct bpf_map *map, void *value)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static struct bpf_map *map_alloc(union bpf_attr *attr)
> +{
> +	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
> +	int numa_node = bpf_map_attr_numa_node(attr);
> +	struct bpf_bloom_filter *bloom;
> +
> +	if (!bpf_capable())
> +		return ERR_PTR(-EPERM);
> +
> +	if (attr->key_size != 0 || attr->value_size == 0 ||
> +	    attr->max_entries == 0 ||
> +	    attr->map_flags & ~BLOOM_CREATE_FLAG_MASK ||
> +	    !bpf_map_flags_access_ok(attr->map_flags) ||
> +	    (attr->map_extra & ~0xF))
> +		return ERR_PTR(-EINVAL);
> +
> +	/* The lower 4 bits of map_extra specify the number of hash functions */
> +	nr_hash_funcs = attr->map_extra & 0xF;
nit. "& 0xF" is unnecessary.  It has just been tested immediately above.

> +	if (nr_hash_funcs == 0)
> +		/* Default to using 5 hash functions if unspecified */
> +		nr_hash_funcs = 5;
> +
> +	/* For the bloom filter, the optimal bit array size that minimizes the
> +	 * false positive probability is n * k / ln(2) where n is the number of
> +	 * expected entries in the bloom filter and k is the number of hash
> +	 * functions. We use 7 / 5 to approximate 1 / ln(2).
> +	 *
> +	 * We round this up to the nearest power of two to enable more efficient
> +	 * hashing using bitmasks. The bitmask will be the bit array size - 1.
> +	 *
> +	 * If this overflows a u32, the bit array size will have 2^32 (4
> +	 * GB) bits.
> +	 */
> +	if (check_mul_overflow(attr->max_entries, nr_hash_funcs, &nr_bits) ||
> +	    check_mul_overflow(nr_bits / 5, (u32)7, &nr_bits) ||
> +	    nr_bits > (1UL << 31)) {
> +		/* The bit array size is 2^32 bits but to avoid overflowing the
> +		 * u32, we use U32_MAX, which will round up to the equivalent
> +		 * number of bytes
> +		 */
> +		bitset_bytes = BITS_TO_BYTES(U32_MAX);
> +		bitset_mask = U32_MAX;
> +	} else {
> +		if (nr_bits <= BITS_PER_LONG)
> +			nr_bits = BITS_PER_LONG;
> +		else
> +			nr_bits = roundup_pow_of_two(nr_bits);
> +		bitset_bytes = BITS_TO_BYTES(nr_bits);
> +		bitset_mask = nr_bits - 1;
> +	}
> +
> +	bitset_bytes = roundup(bitset_bytes, sizeof(unsigned long));
> +	bloom = bpf_map_area_alloc(sizeof(*bloom) + bitset_bytes, numa_node);
> +
> +	if (!bloom)
> +		return ERR_PTR(-ENOMEM);
> +
> +	bpf_map_init_from_attr(&bloom->map, attr);
> +
> +	bloom->nr_hash_funcs = nr_hash_funcs;
> +	bloom->bitset_mask = bitset_mask;
> +
> +	/* Check whether the value size is u32-aligned */
> +	if ((attr->value_size & (sizeof(u32) - 1)) == 0)
> +		bloom->aligned_u32_count =
> +			attr->value_size / sizeof(u32);
> +
> +	if (!(attr->map_flags & BPF_F_ZERO_SEED))
> +		bloom->hash_seed = get_random_int();
> +
> +	return &bloom->map;
> +}
