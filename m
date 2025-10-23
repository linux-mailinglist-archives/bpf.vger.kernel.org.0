Return-Path: <bpf+bounces-71942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFB4C020CE
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAFEE4F2C6B
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F46A332907;
	Thu, 23 Oct 2025 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jbF6Q316"
X-Original-To: bpf@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377003328F5;
	Thu, 23 Oct 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232283; cv=fail; b=i5Y733ImGr5HpzxAhksbnI4tpdDeDKxYc2L9TgG29E354iasHzWp7frefKj9iSyGUANN3aZlOeDFDDfI2bhCU7K4SCH34KQeubmkXq1B22pX5USUsF4QfT+k188ybe1ateIDqxVg/9dgPaszLfy7XSriJkYYHIvDZMBFMhGpHBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232283; c=relaxed/simple;
	bh=/STAJqtrA7JBaRf6C7/QTSkE/k0N5zieJkT9+5pw/u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nD94+HdGB0kvX9eojiDotqjN5eLnmsy91l1MbcztdN6Cqd+RVwmQ6OWEI/CsxnVZVfnJezcZ+u+irgMWT3/73lSLBTN4R6EwE0AlfcsZLjbkZog6IRo1c9CfQ+9wTrriie3lHgBlhQb5ws1JgcljY1FFOYeSZi+WCAe3b19vbs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jbF6Q316; arc=fail smtp.client-ip=40.93.198.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nibig1Zg/H66keAwxgV7f0K2vLVos8CEQomtv+9KlU0zR29t5xF9G1Zu2sgSoXI4rAy4kqbH/Zg4890nSJpIzaZzn/Q5EvSpaStw85OkLF6bvK3WbWwD/ijEErxvrFPxavZ2m8/R7335wdjIzyxAF+jZb+Xd7ZEz7qg2S0oKxq7JhE6Gtn3bnfCFXyqlQw99JTo3NuI85vduB5MbXhvquZRIfcECM3tS8NgDh0wKS3BaN8v8sJ31udbGhEw8R0KgfcPZ9HjJGIrQkJD+TaR+YaICafahzvHK+pp2w7nQBKm67JLtvcwSR7MehD5qBXIZnLST57wpWzB5VRivbkibgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IBZKK2rJsGHiVF07AmmZRncq4t8IbHa8QXAqQ8vMWA=;
 b=Y+20QF0CzZL5UPvwF+vAEhggb0cMFaIEANF2lOLA+3+0+ToGiqRq4/JY8qciOCWL21g4hBYPYGysNBGUPBG39gTfWj/mlwcZOOHVrUKaWmVQ/VbEKKJcO/mDOMHftpByCFjs5G/v6wtKmYP6rblRSqddkIUgrEUPI7LYXp5d9q3CxJjO6PRPrKUEOOXPUlffUyPCwu4MYFQqSi/IUjN13DzoV0rKU9fKhm/6Vj9AEOLIp4D3oQ085sQNRme3L1kRCcCA68sNKvQl1BXLVsCYG8gP6zwOo6M0Gdc2KqymxzCc3zpHnrgEE5UDhvSFLGoUbZdmmZbS1sJjHuGyUCmtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IBZKK2rJsGHiVF07AmmZRncq4t8IbHa8QXAqQ8vMWA=;
 b=jbF6Q316QXq9Hwlb7l+iz84r1SuJd469JwekWCjHu3WNPvIWVQfdcXGcrEohCrFoxHKk2SBdN6Sj5vnXOmkPmRbS6L/8X4rkJkVBu4R8FEuBx9SAQs2eUMr8Tzx+HMW6rW6Ko2l5nrHN23W6u4GI+RSoaI27EIp6teVujZxFLz8YpIgQR5krLrjkTj4J0rpYW3hQ8rzx0ji6IgvAu58Lye/LSRG90biDF09cn2ckqGpkdV/uoMBpvtIruCu1hNmzdRXSweoOK79OnZNOuAcmT38KS9oDAedHKFg18K8izshDpYr27zrjSebUrY8mSbynetgmgW8B/046PbEVapJvfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 15:11:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:11:18 +0000
Date: Thu, 23 Oct 2025 17:11:09 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] selftests/sched_ext: Add test for sched_ext
 dl_server
Message-ID: <aPpFjfgws9os8jQm@gpd4>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-14-arighi@nvidia.com>
 <67335454-6657-42d2-bf98-d1df1b58baa6@arm.com>
 <aPY_YHK-oWZp0KK1@gpd4>
 <664c2c34-1514-421f-b3e4-3aec1139f8e3@arm.com>
 <83c8989c-bd9b-4eed-8372-e280c80a93f5@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c8989c-bd9b-4eed-8372-e280c80a93f5@arm.com>
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 20424ecf-e3e2-46bf-3cc3-08de12466a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Ng3mE9INCPLiV9XBqMbcH1Sli6lUMpIJLMMvWkwKa14HRSc6X6yFSe8J3HF?=
 =?us-ascii?Q?yNCLZcTvMJUNGELRTy+tG/2J48QqWcQ+T8IoXA+hMONmUXKn38PGYgO4TTOa?=
 =?us-ascii?Q?UNHl7zXJTLp4NlP8Wlz/6dsQXdpR7nPYszgpPm0mRI3jCkWxoIuGnscTr4Pv?=
 =?us-ascii?Q?9bEE6NIlqrEnEUj5Zh2QfSDV1OT8UqGI3h77HcKQOI3fLvTb/4mSX1s6FS6B?=
 =?us-ascii?Q?cE9C66c9oN+GrvSkZSJ2p6lwqratc1DYc6sr4Et+nX1q/FZFO8N7x4Cnxmrs?=
 =?us-ascii?Q?9UBlVrZNVfw6W1hFsteauUehaBKcdwVTL4gkO5KVb95CDn9q249lWpDw9BC5?=
 =?us-ascii?Q?SvbjpQ/i0TnMyqWXfQWMupFGu7d2lr1pVIV5frSOIvBREgtRjRPMwJt34jmo?=
 =?us-ascii?Q?JQgzl20+7uW4cFXn+OuOoz3+TgHPQHcjsfCKn3gELBKr+SO/2iqDxm6bS0cu?=
 =?us-ascii?Q?kxOEZhUSX8n9114OwM7ZBFooYdV3Vre2RC9TP6hLQDJoSFYLCd/haT+njFsd?=
 =?us-ascii?Q?YiOaWGfWrzPhl0EFTWPEIOeWcurJK6Mlx8QB3V81suLio3Ou5YH5SqaWppw+?=
 =?us-ascii?Q?S738j4DkvqaVrF9PbnZctdNs7+FD4E4G49NvBpDI3EbL7wbOdMRm8dyP2N8R?=
 =?us-ascii?Q?/YELLY0tXOxdJ5UC/BTCxg0cyYONGvHLj6ycsIxpuGEfTeFsBh+JYs/S5c36?=
 =?us-ascii?Q?6oFmSCe8Yhrq6tCoOD7B/a9s3yifB4sS77SfgsP97wgURer3P6iWrPAEKFnV?=
 =?us-ascii?Q?lWUiA4okfmBC4dCuv1bomPPQ6neANo3xjiVv2qhZYO4mkVZ6qhQcuJxaGO7P?=
 =?us-ascii?Q?za5Npjw3PFPaMJwwxwS06b1E+cAHE09RlYNM4j48bgcvMDs9isUcgHgDM8a0?=
 =?us-ascii?Q?HO28ayVh2Vos+d4ytmrRrwofTuvEffZUGctAS6ekfJCkK1rM2IZCdOBp0k6L?=
 =?us-ascii?Q?mrzpZdAB5qk95FXhXTomA2n2t+mgz3pc5KBF748t9l2Pz38ELrNwDs8OvbTQ?=
 =?us-ascii?Q?2HirHnzTLZ1TTqQaC2Z2jHDfZ4sQ/CUZE9YqVRb4j6g557ybgIpj4jlR/h62?=
 =?us-ascii?Q?spjcO5QofcijDs1jRGCf4CTGd7s4et0WqNQLdGlVuRTFLQpuOQBlZqhF6iUh?=
 =?us-ascii?Q?nw0xr5Qn8HEqUW9yyIfzmM6SZMidvmcZNzKReSIeKlsAeBWdRpJCRRvbz//g?=
 =?us-ascii?Q?i+5oR7LMIdXEe9uF9s1SUoXsJoUKP73nXT+sEkl0m2Iez+0+MI7IiNjuJivh?=
 =?us-ascii?Q?4cuncE7GYXEC1+XqQXcVz7Ad8V+FvH19AQyF1X86+U5yTDRF1fgU2Ch4U/D+?=
 =?us-ascii?Q?NxZMJ+eGI5mtaIM/u6mrCDCKtwCLZdXrrhPJ7KKCNEMD3ywvVc6Vf5ZVCZS9?=
 =?us-ascii?Q?yYxfQwiM+jB+ckGHz9iiQid6cv6wP4EzyeFIgBhjk3UF7aM/F6HN2MzMZ/bD?=
 =?us-ascii?Q?qDRSgaBohi+8HbZPk+IdPInDKD4OHwqB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TOkhYHJLfkEZnTZBPYZ+AdxV3CwSFHW01a3X7ylR4YtbbYSDoYR+o57otx3c?=
 =?us-ascii?Q?rNiOuUkiQpPYBPQIXr8hgX1EogLS3wogudh/mKED/JjbkTMakaarRIBKPz0u?=
 =?us-ascii?Q?Ih3ILvmCQpNGzlQ+ojjPQJSIYfBDPkf2hZKwRfSB/Rap8s/lJ4goD0qmAoup?=
 =?us-ascii?Q?Tq2tTPndeqtuFO9wW7JDBj/ZFxTuamuIEl4QZBPYWIGkX/XjZTStMLRoZuq2?=
 =?us-ascii?Q?fmeLNvRDeJiIa2A3vi6tTyBTkzqSVOYf/xyNAhxxs6nN+ONSh5fn8h4rNVlm?=
 =?us-ascii?Q?ojW5ggg78SveZvISvwoOKXq1VIUDxBsj3zGmBQjyjLa1tLdER6g9nw5eahgj?=
 =?us-ascii?Q?C2iJfNKduLC/3pkwCpUoJkPEykfcdf6UQhHa2KR6yeJ6hayMKrJ8JsnYCF/Z?=
 =?us-ascii?Q?1431i+VF2Fb+t5HTQ/AzOLTT8x9w8fDvCzQVBiAYjBacy2O2rZqF8RpPpNFE?=
 =?us-ascii?Q?+vHSmEYkvHkIzX8YGjviRy9K/mJqeoRFNl7bByUtF5jMcfwmm+7svYGhtfut?=
 =?us-ascii?Q?y9yiIhi99yw+YeG48XN2Wzk8wxSs1i8lvi6ldoBj8DSxCZVski0y56z4QHZr?=
 =?us-ascii?Q?QZ3lC6+t8SIv+CBy2qnMqez5tZ78e+CuzgmAKJYYf1AbMjGv4R2enfPSjZkT?=
 =?us-ascii?Q?5uFUmenqj4+Rx9NV92Oa4Dz/1MPvtNnlL1Xf7VZ9ACHsp4FS+mUVcbnKVuOk?=
 =?us-ascii?Q?kzoDREM4uE5YGIhYlxkBtUDT8EkyYKRyJCdEG1uNJAsz2cnSeve+MBsUSE6i?=
 =?us-ascii?Q?VN3SNG9cLrOA3HknGbCtNYoY9bhTGIRZR8rg+92Pjw/f4Hhpamc48lRPW9Pi?=
 =?us-ascii?Q?Ea336cJyblEfbCtE9iCH46QtelvEspXsxdZdaosHqtTFtxPiePBf9CQNAorS?=
 =?us-ascii?Q?uUT2wXZuy/mCUgKsDMrXxb2JFP3KcHUu7Dql7Bbb/17sLVJiIOuSvx9ptJQr?=
 =?us-ascii?Q?7jGaBxLXQ0nP85/QHtKDZ8lzFIJxIV+s93NoqFHevOfmN2x5IBJK3TbT0Di3?=
 =?us-ascii?Q?Q1cegaoN8so+lcNsT3nC//0C+6PY46jag7s1Bv6wixqyT3Vzw1dkkwIFCqqF?=
 =?us-ascii?Q?8KPkYpbQ1UwiN9F6gghCPZnbe8nEJLGVijcxwT2rNbDB5SUSC7e7xzTitbXw?=
 =?us-ascii?Q?8gi1Gt3jc6RW6Bb8MLBwi5KKGcybpXakpqtiEJZFXD9NOw2WAWMjaCzrcBnp?=
 =?us-ascii?Q?zdwiphUA8iVkawQKCA9V9xbqaKKP2yPf9FHn2200RQLKGmY4vjPtCatMbeDA?=
 =?us-ascii?Q?yrt2ayxSWTLeEbYRUnPefzTIhNhAKgmIlJ4T5ZIDtIvdZExS7OT/Z4inIDYd?=
 =?us-ascii?Q?W7oQTVihmTc5o4rRY1LPrzGiT2evNErdj3Si+Kvt9j9RBkteoLRsNoo/CcOV?=
 =?us-ascii?Q?U83PUqrMDsrXB166WQvQayAbj6aYyOGAyfCqUkBSS90fFeh2MLz6tAhwfM3s?=
 =?us-ascii?Q?bmtaGAzL84gAI4CRwmT55hfSB8N8JrquC53nbEU2N0Tc0bs7Lj30LLEi0Dg4?=
 =?us-ascii?Q?wWAEzc8SZ045JqKeXCakZGTPywr+MNaHqHLFaJN9yj9jxO68Fu1/5ltdy2wL?=
 =?us-ascii?Q?Lg6MNUgY+DfH2Rp9UJSGXItIGIYy1VMafLlmMRBG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20424ecf-e3e2-46bf-3cc3-08de12466a4a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:11:17.9059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BRasIZ3xMrJvvs2H4tlKNjXghy8XpjVHwwWPJMQKZ72Eq5hC8ZKSNESiCSkUVAes4TAcq7I82DlcgkP71Hj2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473

On Thu, Oct 23, 2025 at 04:01:59PM +0100, Christian Loehle wrote:
> On 10/20/25 15:21, Christian Loehle wrote:
> > On 10/20/25 14:55, Andrea Righi wrote:
> >> Hi Christian,
> >>
> >> On Mon, Oct 20, 2025 at 02:26:17PM +0100, Christian Loehle wrote:
> >>> On 10/17/25 10:26, Andrea Righi wrote:
> >>>> Add a selftest to validate the correct behavior of the deadline server
> >>>> for the ext_sched_class.
> >>>>
> >>>> [ Joel: Replaced occurences of CFS in the test with EXT. ]
> >>>>
> >>>> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> >>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >>>> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> >>>> ---
> >>>>  tools/testing/selftests/sched_ext/Makefile    |   1 +
> >>>>  .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
> >>>>  tools/testing/selftests/sched_ext/rt_stall.c  | 214 ++++++++++++++++++
> >>>>  3 files changed, 238 insertions(+)
> >>>>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
> >>>>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
> >>>
> >>>
> >>> Does this pass consistently for you?
> >>> For a loop of 1000 runs I'm getting total runtime numbers for the EXT task of:
> >>>
> >>>    0.000 -    0.261 |  (7)
> >>>    0.261 -    0.522 | ###### (86)
> >>>    0.522 -    4.437 |  (0)
> >>>    4.437 -    4.698 |  (1)
> >>>    4.698 -    4.959 | ################### (257)
> >>>    4.959 -    5.220 | ################################################## (649)
> >>>
> >>> I'll try to see what's going wrong here...
> >>
> >> Is that 1000 runs of total_bw? Yeah, the small ones don't look right at
> >> all, unless they're caused by some errors in the measurement (or something
> >> wrong in the test itself). Still better than without the dl_server, but
> >> it'd be nice to understand what's going on. :)
> >>
> >> I'll try to reproduce that on my side as well.
> >>
> > 
> > Yes it's pretty much
> > for i in $(seq 0 999); do ./runner -t rt_stall ; sleep 10; done
> > 
> > I also tried to increase the runtime of the test, but results look the same so I
> > assume the DL server isn't running in the fail cases.
> > 
> 
> FWIW the below fixes the issue and also explains why runtime of the test was irrelevant.

Ah, good catch Christian! this makes sense to me, I'll also run some tests
on my side with this applied and I'll include it in the next patch series.

> I wonder if we should let the test do FAIR->EXT->FAIR->EXT or something like that,
> the change would be minimal and coverage improved significantly IMO.

I agree, running a couple of rounds of fair->ext seems reasonable to me and
it can potentially trigger more issues in advance.

Thanks,
-Andrea

> 
> -----8<-----
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c5f3c39972b6..ed48c681c4c2 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2568,6 +2568,8 @@ static void dl_server_on(struct rq *rq, bool switch_all)
>  
>         err = dl_server_init_params(&rq->ext_server);
>         WARN_ON_ONCE(err);
> +       if (rq->scx.nr_running)
> +               dl_server_start(&rq->ext_server);
>  
>         rq_unlock_irqrestore(rq, &rf);
>  }
> 

