Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD3243A960
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 02:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhJZApj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 20:45:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23928 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234876AbhJZApj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 20:45:39 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMiWTe011856
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 17:43:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=eFxX5ST9sO3RNJ80SBIsQYd/YB2OmitZX3OjyiWV2rc=;
 b=PxaYCjPULYBVbeTHejpaEEfEk4WNO6ellS/quIf03aOXlh/eL8yqOPS58C80/kStUAxY
 HpsmIesfKWGiP/Eqlj5vcbIB78um+wXHbSUbt0LN73L+nyp7ZAdvRmSnc7fpqLK0vlTM
 AbPAgyRPi+YN2OkWDfvO1T/HDoyXJExSmRs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4e7s57e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 17:43:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 17:43:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E50e9Ymf+RP7syCcWQpMp9y/8jg8RwoAqUon5KbnJBkEFvILzCyOqUAuuAOkFKKantzOfTxkKLMuH79lH12YTKWtbOq2P5ro2icQ0tG/eZ5qXhbzbPBL00k0Xs4vDZxD9ewGLExsBIDphlzdQx38kwa+QWX7CxuEDtOlYOenJUaTFqp/KPXXKEDZprrt/8drx1AvFNkrw5KY5gwzvu3gzleLtCamSg/n+NYPf7kjokzrxVRZFJYYdIhY3F4Klm1uzd5iR4MIG8wQUpBynPkZGjtGHDhpWWKqhKRzO5MKl4KK7GVIJuUaS0P7CrwYXRdfsrmO55rLY2RgUgTT0cmisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFxX5ST9sO3RNJ80SBIsQYd/YB2OmitZX3OjyiWV2rc=;
 b=NiQgRzDVFsOJ1WOI3s7PGaVNZtoXbSOPTIQ2aJZu0f0/syHEXmgbjcEsFdsRZmca16086pqlbptPuEnWwUbJibOzTwiVQE/dMvS1Rrr5/1FxNVxACOvcXMVfyuV88SdcHbWSYFfepykqebQfJ3ZAkK7GsLumvcED1uP0cqUKd7RithVYfWeSO971zpYsAiGmYxLnerVtnL1gCn+EU9+ivkGDocOHdxpiEoElTqkwrW3CcJI8CLQePuj+jLbxp8iocBK9+aruIv5kv7PUm5ozXd7XzAgaSKGhGNbaQvoZ+MZ1kekwsaonmrZ7JOvyHAqRSIpv12s7L+rvlrcZr7H34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4822.namprd15.prod.outlook.com (2603:10b6:806:1e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 00:43:10 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 00:43:10 +0000
Date:   Mon, 25 Oct 2021 17:43:07 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
CC:     <bpf@vger.kernel.org>, <Kernel-team@fb.com>
Subject: Re: [PATCH v5 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20211026004307.34v3uwvnouaazlfa@kafai-mbp.dhcp.thefacebook.com>
References: <20211022220249.2040337-1-joannekoong@fb.com>
 <20211022220249.2040337-2-joannekoong@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211022220249.2040337-2-joannekoong@fb.com>
X-ClientProxiedBy: MW4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:303:6a::21) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a892) by MW4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:303:6a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20 via Frontend Transport; Tue, 26 Oct 2021 00:43:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4770e9f6-eb35-403b-bdb2-08d998199577
X-MS-TrafficTypeDiagnostic: SA1PR15MB4822:
X-Microsoft-Antispam-PRVS: <SA1PR15MB48229A3CFFC8E6BE5CFDCB15D5849@SA1PR15MB4822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vaxbSNx0OSp0PGNA1eTgufUHCCHShoM/SDbeH3/0ZfX485tWymiHlfH1bZvFz+Jyjfca1teBAUucfivtcxdIp1nKnaz97wp82jWxOOeLt0XRp7pOkWMxEMXQQJSpVu43j/j+wo+TtmM0Iyy9Ulo+dD2WCbp4DjkRxpOAOfOh9ucUxnuFiRL59aewSYKViS5qM0h9iL3MxH8Lnh65VGn2qsKfdGdH5itSEP+rl+7D7pg7zkfR02b09ppp7WTiLLxcofuZ56cH9K2b7cNX0CJqzpMtwxRWLF4JyuGoGCAOYYAAlAGIAU0cBFcoQ/qatNNEDsfNB14kOvN0SD+demuhe5NF1fnkV2/njA8xV1jpx78xS+fVJgWr28ddCUnN/Ip6IRnN11pAn6zEWXD/1lqPBR5P6wYNZUSRVkcVyN71GMECDkuBPSUEhR8i2VItMbU9By8+QS2YmQKl5SfsqS3IYiWNaQ9kjcng272XIYYRcIUUyotoxSfmDoWzGXhBLIWITNds7tw1WEMpDGR75UBoxK2eN3PLFq8/aMes8N1zdLsWFJiyxYb3G2e6p9RB5dZ7t9srwX7vj50+prRR7nTk+2ZzdA2eYQ0GMXoPpeusQNmwZMeigtcblAU+y0JrtE1HGuU9let2Qzln3uWyNSJ2+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(6862004)(38100700002)(508600001)(5660300002)(52116002)(2906002)(7696005)(4326008)(186003)(8936002)(6636002)(83380400001)(66476007)(8676002)(86362001)(9686003)(66946007)(6506007)(55016002)(316002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rLGcqn/HBUDentMGri2lvh1l4PlMWxtJlF76jilri29ATX32DJSG0tvTr41o?=
 =?us-ascii?Q?hbmTd+VKMczySk3IlSUHZfj0Zexg0oPkzbeRmnTbdGrVDERP0oqvhXp6NBRA?=
 =?us-ascii?Q?ssWJiy7KQNI4V9HctpGsRuCv9gQLPBTfE3+GOuAb9hBK+rnj56XopHxnh1PT?=
 =?us-ascii?Q?MDM0pO+lqA1Xb+FzGMIEuAtIEskER5UvmNTC7Y7pxjdqygsRgL9knS9oFL7g?=
 =?us-ascii?Q?pQFvZv5/Vjr4tjcgIcMmuc9C7y2T+oxZ30OZf+W0d3Np1VNQfP8kbjvpy+tY?=
 =?us-ascii?Q?fJz6yqoUIg9vVwiFhXKmGoujqcfYTCkm5A31heAeOSJa731ApcYXWUbI9R7D?=
 =?us-ascii?Q?VmJKjz3Pi61dxa2YF3LIWCjE7hrqe2e0T1L+/Y4K9GwciYcVRJZZf3tTRttW?=
 =?us-ascii?Q?8t+R3VaV+SweTgdYjnvSEYzRFfct/zpA8oBjvTDmRWmM0zPe7YKKNzhPN9rV?=
 =?us-ascii?Q?9FrdotI95bJdLvGOBaZJr7SRnfgqSKyUxMWCCbecqdJxHJIAfEapBYvqiBEW?=
 =?us-ascii?Q?dbVFhpwFyUTMRJDnfH0uiaoPOTAPGi0tNgkBw0oaEkOLmqlfa+ka4rOZ738q?=
 =?us-ascii?Q?yRCLBOO8jnBDeWSVB6mHqvzPtCeuE2pCF86FImrMWfcJd8+sPqcP/upVMlb2?=
 =?us-ascii?Q?2UfRrQMCEU9SCgCLV8+gsMVuTYsHPsN49gvmiGqRd7yHd5Q1hglQpqv+v1Un?=
 =?us-ascii?Q?2hUxLvGEXMhHbUJ16OBpJo9OZDkvPJkVQey/b7FmimV2scBTc/8kHOqGNOWA?=
 =?us-ascii?Q?OD3PdCCBzfzUQpjbivOvO6KAQkRFsXYnoDjXRXtHHjMRVxHmm6ptLPnHEAgE?=
 =?us-ascii?Q?kI9HhpY5nK+8SzY047+nT6zfNdIdRLMfv9aT455tci2YJ3bmVw9ImO4ojBJj?=
 =?us-ascii?Q?0dFgDSkZCHwJS5dFqlfJTutrJgmEv09y9XCfTdFH2IwA2ruVtV5JnSTGNQ3z?=
 =?us-ascii?Q?GhsE/t6tr6n0wt33kVE3tF/5OwedTsJ6xdKrwWKq3GcQZaTTZH+Dz00ygKRu?=
 =?us-ascii?Q?8pELIWG3VwFXEq9VjzqbS+dmKL/42aeg6u3stLJJlSoks8jJxidnDuROkiNk?=
 =?us-ascii?Q?J7ujCOpDQFYkOTNeiujs36sBnMzwone11w1LwSJBUwpOqkEq9jKyUlv3tqtO?=
 =?us-ascii?Q?CiIE33MBytmh+Ngrm8OIbSMobTie8oisyflGgJfxOyLHFlcvqF4VFn0tsbwe?=
 =?us-ascii?Q?LGTUEvk6fFBm7dcCSM+AkaGjCpAhQbdMMs4iYHTvFxtX6wWI18IjyFhy7uty?=
 =?us-ascii?Q?5u38Feoq+/MEiUWf3NIwkhtqSzfMnpLDVuaSvkxvv0THt6Zc3MlYAa2yhN4B?=
 =?us-ascii?Q?Q1h+XXbxD6+VRYfKalfySkUbr/aqlZZfGmXDy4SAmbyg5tWdZi4D6SHYx06m?=
 =?us-ascii?Q?5sX7kB/Xrl7KqBbFXKOsw474v7tQ35WV6FevS8nfuAGWjbSMFS1q/MlRrtUN?=
 =?us-ascii?Q?MLHyjRg9w3qpCLhBtqHnZ5NOgxH6kmdM8GE8L9SYJK8FlUsMIqF8bfR3WxX/?=
 =?us-ascii?Q?iorLiSMM5oRbE0HbGeiFY8bGZTnhqfrytwPIlo1JW+19jevOmpViSNl73v+y?=
 =?us-ascii?Q?sLQ+2gYnw8j0AgTpeCtTC0jXxQnPN2xw2DQU6o1k?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4770e9f6-eb35-403b-bdb2-08d998199577
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 00:43:10.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h36voWJHB4a6KhhqINmoQNZ1QiuXB4V4wdQchuqGTCP/MudFFs7y9RE0/2hhbwGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4822
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: cMeaik0vNa29EvRBfp-BtxWaC5WxFJfN
X-Proofpoint-GUID: cMeaik0vNa29EvRBfp-BtxWaC5WxFJfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 22, 2021 at 03:02:45PM -0700, Joanne Koong wrote:
>  union bpf_attr {
>  	struct { /* anonymous struct used by BPF_MAP_CREATE command */
>  		__u32	map_type;	/* one of enum bpf_map_type */
> @@ -1274,6 +1281,7 @@ union bpf_attr {
>  						   * struct stored as the
>  						   * map value
>  						   */
> +		__u64	map_extra;	/* any per-map-type extra fields */
It needs a check to ensure map_extra is 0 for other maps.

>  	};
>  
>  	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 7f33098ca63f..cf6ca339f3cd 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -7,7 +7,7 @@ endif
>  CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
>  
>  obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
> -obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
> +obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>  obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
>  obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
> diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
> new file mode 100644
> index 000000000000..0887f768ca6d
> --- /dev/null
> +++ b/kernel/bpf/bloom_filter.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +
> +#include <linux/bitmap.h>
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/err.h>
> +#include <linux/jhash.h>
> +#include <linux/random.h>
> +
> +#define BLOOM_CREATE_FLAG_MASK \
> +	(BPF_F_NUMA_NODE | BPF_F_ZERO_SEED | BPF_F_ACCESS_MASK)
> +
> +struct bpf_bloom_filter {
> +	struct bpf_map map;
> +	u32 bitset_mask;
> +	u32 hash_seed;
> +	/* If the size of the values in the bloom filter is u32 aligned,
> +	 * then it is more performant to use jhash2 as the underlying hash
> +	 * function, else we use jhash. This tracks the number of u32s
> +	 * in an u32-aligned value size. If the value size is not u32 aligned,
> +	 * this will be 0.
> +	 */
> +	u32 aligned_u32_count;
> +	u32 nr_hash_funcs;
> +	unsigned long bitset[];
> +};
> +
> +static inline u32 hash(struct bpf_bloom_filter *bloom, void *value,
> +		u64 value_size, u32 index)
inline is not needed.

Alignment is off also.

./scripts/checkpatch.pl --strict ...
 
CHECK: Alignment should match open parenthesis
#174: FILE: kernel/bpf/bloom_filter.c:30:
+static inline u32 hash(struct bpf_bloom_filter *bloom, void *value,
+               u64 value_size, u32 index)

Same for a few other places.

> +{
> +	u32 h;
> +
> +	if (bloom->aligned_u32_count)
> +		h = jhash2(value, bloom->aligned_u32_count,
> +			   bloom->hash_seed + index);
> +	else
> +		h = jhash(value, value_size, bloom->hash_seed + index);
> +
> +	return h & bloom->bitset_mask;
> +}

[ ... ]

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
Comparing with v4, it is using max_entries to mean number
of values instead of bits and also not exposing
BPF_BLOOM_FILTER_BITSET_SZ macro to calculate the number of bits.
just want to ensure it is the intention in v5 since I don't see it
in the change log.

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
> +	bloom = bpf_map_area_alloc(sizeof(*bloom) + bitset_bytes,
> +					  numa_node);
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
