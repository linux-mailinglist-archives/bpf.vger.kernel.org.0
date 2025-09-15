Return-Path: <bpf+bounces-68373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C6AB57018
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 08:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E712F18994D0
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 06:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28F527780E;
	Mon, 15 Sep 2025 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XLpWrbav"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782E10FD
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757916871; cv=fail; b=f6UOTe6PJv/zql3zZaJO31j8+b6nGI9tIQvlHfkAGuDK5MetV5rJI3Byradda33K271sB5G+Jm+66t6Fr2wFbSSxtPLXheeBAzOaWYB9eFmfPLAnafwqq7hVG/rSWdSLpNDTRnI064QbVsF51zJT8dqvMD3MEY0O1n438GOZAAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757916871; c=relaxed/simple;
	bh=o92QTdZuarsoO9Dzvu2xIEjjXhqllXDerbYBaahh2Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iaF8gQ1K/ekDZmXbWI8Tl8QDnSCrOZq+SNddA7MSBccBpBkZgEDs++z9FAwpT7XgGwIrOk8Lh55z4Y8C+VBWbqzl/ln0JxxBDF6X63uXR7Emr8TrqbNSSVOppWrmoHc2UAsJrSmuX6Jinw2wNftKyZfK4L9iFAxVCNl12wzrfrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XLpWrbav; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dlsb26DlanA/JTm4uk0k06Pt4rc/tePXRFjEstSltIvzwQ2u0o8mhk9xyQz5LB/uYUbjH8zvY57kmwnifi+CkZQwY72hMwn6p9kxKmKixVc2KDr05vmbQZlzgvX+Xk6beCTNElNaRvWZgX+wylPFYLQxifprAkmZsaaAsn3ij1C8P7z0Io8QummvvowVNLrdXZZtxZYkduDTfYS3kBIdzwKi6q+TKIV6gTt7yn4SM3l5wSqHj4LEq778WoMg1+7LlsRSDGAC8zUMY/WcY1Y0yk+0o3NV6uLZ7Z4l9vI/pTzLQvp10VHpfYXFA0Z0wkvGBisClhjDZLGs2LeQQMkILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyVWI9dnPj7R7ciSGo/DrX9p4X1pTI/EKDa2L9omrv8=;
 b=tVmBh3At84DTfcLgn/nOjeg1f9CUQ3aqEQ9jG87lGaczg7IHzIzjOWRC/Na9EcSwGfmaerpi73M6k+yOb3NI4UufMWPAqHEw8ZB6hAVGhBZ8wJK7BLqVbTP/1+hTlam/jK7dfJHkaSXNKZn3K8AlasyMIP3oAimq7hNx2I44N5rlpgLD0XufvcpUN/rbYBoTJfwXp/bCmfk7VfFM+X/Y8LGGJAbPTE+okwidLLKRt/N4jy6OCwaFeNTAN5o3ieBmEVdGikvtFe9dxXmRSNmgRFE/efOZMMdOlK4dB2oK/YvaXi7dvPxjzCRyJDYDG/BXnWrewWejkYqIeIH/+ibzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyVWI9dnPj7R7ciSGo/DrX9p4X1pTI/EKDa2L9omrv8=;
 b=XLpWrbavoUSOAAeJoQR/gZaVT9n5Zzyej5nE60SvteiTY3IDedT3voAfrf0Ny6FKqDV4XXl3QYbQaH/Y19b/UdmCK9DzBv+w/hc6zGKYJLvhzx0iEKSXEAbIo2LIeObD1/5GFtHUD1sRCwK7ZqBrsY7bpln0Yy1TUWCmu8Y+2nrZ8KW6qlf9wiqyAXWxGus6NBFGAPzyryn1+IZD5NZANNhqHFjwEGfBaHU8vLf4H9FwHomiQjaNjSw4b7sQ42eWtWtpxXAr7ChM8TAMNAwG5N1dEvTjnYkquK2AsqOageGADI8PQiGaE/dicv94pWCaCHkx6o7z0bN6G++Kb180eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 06:14:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 06:14:24 +0000
Date: Mon, 15 Sep 2025 08:14:18 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
	kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Add support for KF_RET_RCU flag
Message-ID: <aMeuunTYM8c6jp1m@gpd4>
References: <20250915024731.1494251-1-memxor@gmail.com>
 <20250915024731.1494251-3-memxor@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915024731.1494251-3-memxor@gmail.com>
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb35be6-7445-4db5-0658-08ddf41f1e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RifWF48AVYxT6Rb47KrLwuKvheemHP0N9WrveGek8axRdzPkfkVMe2XZEquv?=
 =?us-ascii?Q?tIxQP0vIiirQuVP2FGTGEvY8ilV1rsTtIbQQ9mcC9nNuWdxvGWEbw1nPOZLo?=
 =?us-ascii?Q?Gq3NUmRotj4bMdLiC+Am8AY8RcgZZEoHrdHsDKtg3gohpkfjzBw9u3TWWYQB?=
 =?us-ascii?Q?d+2reymJ62hpJH+FE3fAxupAjqjFv4WeQ7Ba8CDUOLEDSy2Two36dd9oKdw8?=
 =?us-ascii?Q?pWzAoKjRetWH3SzyGIlxt6966RdJc6x2/aJn9fNefsVTtnIUGocBlCB4aXV3?=
 =?us-ascii?Q?6K/xlg4hUFq8HLTqU9QYuOd2dCRsx9UHWrnSqcHNCNEkvynpwVQESErGmyYK?=
 =?us-ascii?Q?p2N2rlUL4IhVCOV3s68z0PNOGdfUAyWPqp9rYbfDKOPdP9KAjq0BIgR8veLJ?=
 =?us-ascii?Q?K1EWJEDMinqshPCU6rsWqTNBcFt69jNvT36cYMqCip6NpDA5CsfWTH7XIqK5?=
 =?us-ascii?Q?ojnZkQohFu5VUuVxlydMRpT9dxc8x5VUw4l6vXsi8UXpbSqP8sndfMMD7Zc9?=
 =?us-ascii?Q?M1Yq6OqdC2HdmyipSXDS9deV7A30sq7xn3uQMVmmK8A4neV3UXKt0KP9cF51?=
 =?us-ascii?Q?Bfvx1jTse4sgCBmYRslellC962oQAdvnxTKyDJOda1OVpD8liHiXiP6wwOpb?=
 =?us-ascii?Q?w84tbfNRmQFbxQGRbgIFM3/7UjN9AE1sPUrfCBHLXNZbmnGvzdoME9VOLdLZ?=
 =?us-ascii?Q?RyPeyxYkNY9jPZmpl6Tq9KHuP5wHVH1H5+E7WXJc0XplXPDE3XZ93g9kFqE7?=
 =?us-ascii?Q?E2D6UD3CM/nEn09wOjItL3i4sIW13sZUeKse1/uos5Zy88GcLPlcqwuPAz7b?=
 =?us-ascii?Q?zQc1DBc5KKIJnPJgh/kg1BJ9W6elpOWnTf7+ap4Nhsxiaqrnd8VroAkv47lQ?=
 =?us-ascii?Q?d4RmID0KiqQbJcfwQVoHLuh5UNVRq/Um74n+31h0xL95NBjNt2NG2e/KDtbg?=
 =?us-ascii?Q?JHF1Zhf1YGWekYw69hgE55QWk7ZLNgX045qQsyEznpVAxLiUPRrF09e1K1KQ?=
 =?us-ascii?Q?+E82neNL4lyF5ruvE1CMMz3oOl4pCQZzQpL4ZvAK5BmfC4qsbbiEG/ew0GJP?=
 =?us-ascii?Q?D2Aexnbgi3fCFAFaafdW/z8H+Y6Xxr0SyiLQb6D4rh4tk4zVEkEMW57F+GCr?=
 =?us-ascii?Q?ZBeRUoaGGSVWo20C2IXER1tje4ccf/K1Wmp53Pib5adY5wMn3Fq7/FiectwY?=
 =?us-ascii?Q?b1sxLuDKFsLrLnKkoJxU3dSWfJum1EAA8SEtql/xgG8d6Z5dJKOXiy9Y+0qv?=
 =?us-ascii?Q?rt+kEgLswWDauy5TxcOJubXOFmdsa6PhWfLzscrtt/NuGP3paDUXTk6Z94m8?=
 =?us-ascii?Q?RxC9v0+9rdQfE6D1iPzM9ZlkaZIGUpSSQEw4NbD/7zD1iHQ5vPfKKCLB1wBq?=
 =?us-ascii?Q?ihuskCsQlz685FUHdi3peJ0C32XFRvG138Nqr9LP4lKSQeKL3ubJK605vYtE?=
 =?us-ascii?Q?12DkA4tm9qA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y/GcjdEby1egKXqVnq4B6OEBwA9hP6WK4bXzd4QILBw19DNqmO6imZHMwyy9?=
 =?us-ascii?Q?ZUL75B0t0HI9zZKJs/Oc1EZlToPN8veQ/dezYRxui/tBc34fEMzEOCWCSFuN?=
 =?us-ascii?Q?8J1GKpYONn7MK0y+U/bOWcFiZPhZSa3/pnmiopjQpilN7mCx2IOGMDziy5zB?=
 =?us-ascii?Q?uCfhWXOV8mBC3aC0ijiGTEjmY0acUVeWVz1IbbVJh5P2g1agcko5io6r9sW6?=
 =?us-ascii?Q?IpooANHLHBql76wIXIpJy099Gkvy021kYWzZ08YvI8KI88FYvO4Oe5EQRzsG?=
 =?us-ascii?Q?hlz9xQQj05NyZ9/WqrFKh8IHDf/l1F71Dcs0aYEKUxD0fVT5z/rcDzO9CnS2?=
 =?us-ascii?Q?jFZR06HDznttfA/gqIjzJGXcAJjJLHUlZhrzvwWflzrIa1iiSni/y/eEd5nK?=
 =?us-ascii?Q?sqjuOvb38jmZb7Z27aki/E4DZRwouIwOHoeXTfguDln5gwJuiZuCf+XB7cnd?=
 =?us-ascii?Q?D2tANyczOHHTOWOrKYEgCthba4qCu6qKtkPX+NfZRaAZYoq3gPAqXqDsydgm?=
 =?us-ascii?Q?BZcqN0J1sV5fY2oQh71NTm0IgXtMg7z5GVqQrsP+Zi7k876/EfAQS3m91EuC?=
 =?us-ascii?Q?9Q6nylS/sYkEDLhH/a0pEd3WnWs5f7sNzT7dmuZ/AWDopbw63n60oO2Z3Py4?=
 =?us-ascii?Q?dimNhyTvVN3TFBw7o2XfTmkk7Axuuwuql8sUSDWoF07IxlIpLIuPjnt3J8C8?=
 =?us-ascii?Q?gFQNeC6zAKdhnC6k+siaaF5sGmAN6ZDgJ/VVafoJ1Jmqlruf5a0k1rugRbQf?=
 =?us-ascii?Q?vV9XJBwFU7nzEUrz/Urrqv7+z7l8l6rxDAGoEhq91tn4CnPisWb6APfCMArg?=
 =?us-ascii?Q?g0L5o5wZYf2/NTPebvgVALIUDoaSg7CcAkDMLA8RRhVwBmboASkNrFeY6Wd0?=
 =?us-ascii?Q?JsC36u2/RAKWHqqgrbLIoPD5MagdZfIjN4YBSd0FAp+uSjcdyqWdObjt3EVB?=
 =?us-ascii?Q?LDv0QC6GyJOJXD5bsf4OVJF22LXAJzEFtsPxEO+sC13h7H7z3viJ/ZUGj10Y?=
 =?us-ascii?Q?wWJ00x9of+LwTeFZtlZuPGExTkXrayYtM47tL1jvEBWFwmTSlCBzYwZ30CKu?=
 =?us-ascii?Q?sco3pGy041BHBd+AhQS+apZJmwSEWQeK5ZURO68inr1k/we7w9IGOnXhRt43?=
 =?us-ascii?Q?hD/ommvUMUO51fd9/c0j6en95g09bD3lMafW6ZCDQg3z4K16aW7SIBsUzBkd?=
 =?us-ascii?Q?Y+za5l5rpeyBB7xtsCsf57Y7fF9s0+aCK5h0Ld42udk8/U7x9yZ+eF7+Fk4P?=
 =?us-ascii?Q?jyIdZZn0iVjdxoX8Zihaw7sNGntbM07oZ9bJt1KY2A1xiExGLF5oCma44n8K?=
 =?us-ascii?Q?25AGS4FMnZZQ+TjB88RxrxBoa+PPmEpE67dTX0c7uhCh32J6PYddP5/tXR2g?=
 =?us-ascii?Q?3fDw8lUDd89RBTMSWylHniowEzD/iBftZkw3Jtth6VD0KIlqu3F/4N2jfbcD?=
 =?us-ascii?Q?ucqQDwwcPQyIoOqbIM2Z2i3iX13sPCmBajbr7bt4NWUTPzZ/Nq7Jp/5DcRoI?=
 =?us-ascii?Q?uHC5ZKvK4QKDHvaXraDgN8gyhSXl6qTW6kLavOAwYHsOXidcySAVvLKmFD9H?=
 =?us-ascii?Q?YVpNW6DLUZn3GcJjv57V4XlQ7kPIJMIcBzNVDINs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb35be6-7445-4db5-0658-08ddf41f1e43
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 06:14:24.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J29L2qNUkpa68p3+SvHijiDy7N8NNZXPg6U173W4i9hfPdjws2/dJH4QEJ6pZlEDILRdFy3w6xROYzdBM9bsSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629

Hi Kumar,

thanks for looking at this! Comment below.

On Mon, Sep 15, 2025 at 02:47:30AM +0000, Kumar Kartikeya Dwivedi wrote:
> Add a kfunc annotation 'KF_RET_RCU' to signal that the return type must
> be marked MEM_RCU, to return objects that are RCU protected. Naturally,
> this must imply that the kfunc is invoked in an RCU critical section,
> and thus the presence of this flag implies the presence of the
> KF_RCU_PROTECTED flag. Upcoming kfunc scx_bpf_cpu_curr() [0] will be
> made to make use of this flag.

I'm not sure we actually need two separate annotations, I can't think of a
case where KF_RCU_PROTECTED would be useful without also having KF_RET_RCU.

What I mean is: if the kfunc is only meant to be called inside an RCU
critical section, but doesn't return an RCU-protected pointer, then we can
simply add rcu_read_lock/unlock() internally in the kfunc. And for kfuncs
that take RCU-protected arguments we already have KF_RCU.

So it seems sufficient to have a single annotation that implements the
semantic "this kfunc returns an RCU-protected pointer".

What do you think?

Thanks,
-Andrea

> 
>   [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.loehle@arm.com
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  Documentation/bpf/kfuncs.rst | 13 +++++++++++--
>  include/linux/btf.h          |  1 +
>  kernel/bpf/verifier.c        |  7 +++++++
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 18ba1f7c26b3..7d1b7009338b 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -346,10 +346,19 @@ arguments are at least RCU protected pointers. This may transitively imply that
>  RCU protection is ensured, but it does not work in cases of kfuncs which require
>  RCU protection but do not take RCU protected arguments.
>  
> +2.4.9 KF_RET_RCU flag
> +---------------------
> +
> +The KF_RET_RCU flag is used for kfuncs which return pointers to RCU protected
> +objects. Since this only works when the invocation of the kfunc is made in an
> +active RCU critical section, the usage of this flag implies ``KF_RCU_PROTECTED``
> +flag automatically. This flag may be combined with other return value modifiers,
> +such as ``KF_RET_NULL``.
> +
>  .. _KF_deprecated_flag:
>  
> -2.4.9 KF_DEPRECATED flag
> -------------------------
> +2.4.10 KF_DEPRECATED flag
> +-------------------------
>  
>  The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
>  changed or removed in a subsequent kernel release. A kfunc that is
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 9eda6b113f9b..97205b8a938c 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -79,6 +79,7 @@
>  #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
> +#define KF_RET_RCU      ((1 << 16) | KF_RCU_PROTECTED) /* kfunc returns an RCU protected pointer, implies KF_RCU_PROTECTED */
>  
>  /*
>   * Tag marking a kernel function as a kfunc. This is meant to minimize the
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index aa7c82ab50b9..f1cc602ed556 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12342,6 +12342,11 @@ static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  	return meta->kfunc_flags & KF_RET_NULL;
>  }
>  
> +static bool is_kfunc_ret_rcu(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	return meta->kfunc_flags & KF_RET_RCU;
> +}
> +
>  static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *meta)
>  {
>  	return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_lock];
> @@ -14042,6 +14047,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  
>  			if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
>  				regs[BPF_REG_0].type |= PTR_UNTRUSTED;
> +			else if (is_kfunc_ret_rcu(&meta))
> +				regs[BPF_REG_0].type |= MEM_RCU;
>  
>  			if (is_iter_next_kfunc(&meta)) {
>  				struct bpf_reg_state *cur_iter;
> -- 
> 2.51.0
> 

