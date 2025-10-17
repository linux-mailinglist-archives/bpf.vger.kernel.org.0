Return-Path: <bpf+bounces-71248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C30BEB520
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5482A580E6C
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF1F2C0F7F;
	Fri, 17 Oct 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hMDVnFr5"
X-Original-To: bpf@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7D2E1F00;
	Fri, 17 Oct 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727638; cv=fail; b=YCLL33TO21rSKs7pAV4mtjWhBHd9mYU1j30PLw7r+Z0c56qsek/i3fky7E+uwTspP+Zxe2guuKh6lGNEAx4KuQNn2SVmoRcRvrpJ3Bx+Fy1oD0MLedKDX+dKO2nZFpYE1n3Z+Re5TIePLbLPnplsThL4prSqcKqkn/v05iKSH04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727638; c=relaxed/simple;
	bh=zUZemO9FkLIFln5KRB3e7C3uQ8FizYcQGFTqFJa6iSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tRHsZbtKv3W1T+uzFx/w0nBigqljPbfw+3GPB5cdGrXEqhbKihrb2VqjwVBIVvPgOh8quZHS9pGGyFQFFNGfHpom2rfBSdqq8LMPqzRaHtgdIxsMMOoyDY3vHgnGLIHk6zuneUAvF5SQJo/gbpdC2H/tCj2vNhqGxaNmD/v6qw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hMDVnFr5; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+Lm06ZBjAH5uxvSOs0lymOQWi2++XJCnKIunV5DcbZk6POofExCUvUZfXoUclD0rEpEjR3b+dQKyaulLFxQdVeZOHXD39JOtL3U1nTGvwWR5dd++1YR1OCPKC5cdi3Q6S3PEJUnFgmn6lpZSjdmqCfBzTRIy4UYAtl8SSLjvGM2KMqfN7Z4wrgEZQ6C2r5W4SaNg9ENLEAKufQog84ijaxh1elTqZRvpenLfsAKtHf+eSWrOdG656dqUrzhCfa6TpGxtq7uWy/tjC1W0d/QjHIxwL+nTJtf7vnJViTMOsv/N1ibVBYoHKUi90VeWDYyYHph1R3cm4tNTvq1ASfmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn2gfb1NHcU+Nzjjf4LiXUG96xQRSY429bLFgt/gvRA=;
 b=fzS26DOp9EyygLjlB7K/sbK87TYIQcalzEbzmdKdLBWauvfqtCy8L6wO/qIeRISAo+NKDq+iwc54I6VYcn9vx3xTl1JXWEBAMtGF9fPPn/TbD+QDdKpHstlqenjrDYwk/9S3IWJJ6FxqDU7WjMAKsxC29ra2i0P5PX1L/xvN097ALW3FRnYmgX3la4OyUX9BV9MO9iXNqpLZ+J394uIzkOCovinXHPqROE31MqzslV0epZDhWBYqfMrwV/vAP9CqgfPlCPfQfo5/tgs0cMtEIqK+Z8nJ8RQ1egLllhrO6RbuDI3KWZ0TXngDlYBBufkpeK35YyLYF/GUQR+ATMu+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn2gfb1NHcU+Nzjjf4LiXUG96xQRSY429bLFgt/gvRA=;
 b=hMDVnFr5V1sS2vOctKHOw9KtQN3cO3wsmDycFuCpJoZpTGx/rJwvTBlTsz/Bid8FtTl1nCSaTcAedDY3UTL9JdmjWN4ycs+TfET2lc9j71wKQmOtXMOfp27yMo4Li/i+QUdb+bD0Wfu3sC96v/IYyUHJ5OYMBTCrAUEe/IluWKbmwCuerCUzG89ZDXIgHRKl+vZ5t0IJCtORcmkLU2eIgiJoT7zbiE6YGdD7CJVeHMcWT9Sg4zYVn/q6UatgFeNaKomWQXqYym69nibpzA/nNuIN9YCt0xrlbv3f0jPz7S5EWTHVAspsbDHA2KI1vI/3PY0x9F+is80L71CAyUWxhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 19:00:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 19:00:12 +0000
Date: Fri, 17 Oct 2025 21:00:03 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aPKSMxlGsKvxsCq8@gpd4>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
 <aPJjXBifYNbXY0bI@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPJjXBifYNbXY0bI@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: ea47aaa0-5c3a-487a-3ff9-08de0daf66b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?710IKQicDqUpiU28Icqv3PFQ6mHKTwhiTRgestZhM5dsoquGqLq5HBsfdh3i?=
 =?us-ascii?Q?Mz6x/iKdddrmgzAVloE2D4KODygmdlRbL+HpdUZvnXNzZYBwBA0qsg4hM4ph?=
 =?us-ascii?Q?SN3SMkbsShyzkKsr06/BOAGpJNufdKLYHlorVD+OLTDoZzKcD+CrBZRXlIWx?=
 =?us-ascii?Q?5RkjtMNsOskG+i1Iqq9EPZpownmcSXLk50SOzUTnJg7mZ7EcbQetM3WwMkEC?=
 =?us-ascii?Q?UAIL7aUAEAwbqHcZSO9+Mun7Dz7q3iMnmHIxYialqjL+mFmTnoDuwd+wigyN?=
 =?us-ascii?Q?TnBiNZng8rojzaHXm2Q2x92qsJvjQGLLqDsRie5oD+HbuaVRDTzv8MdgKnIj?=
 =?us-ascii?Q?FsWQpqBvX9HXcEWf7JOJMySkJhzkon53z3Zgm5vnVmM+bogZhxCMV49M9ID1?=
 =?us-ascii?Q?A31rVJNeMOw/kco5hFNoylPCapmXSkYT85BmLD00aUiuHQr4iOYMLuW7iGYi?=
 =?us-ascii?Q?ExD8bwu1ic/9J5m/v03fNUHPWCf6DLOL5nX6Wr9HudhQoTE2EP09DRFKDRyL?=
 =?us-ascii?Q?0YXBfNcKXJopP0xFqR4nVhUIm+T79iDjZy1ObQfxtoibIBQdK0u/xrBr9sfO?=
 =?us-ascii?Q?5Vw1T29DjkuFpH4wOt8ZTfb729Xse/saxycJewiOtDPyvIhykBIU5yvK2ycI?=
 =?us-ascii?Q?vhs9xFoWIjewAx283lS5Q0LiP4Etp7qFZe8PyuG/cdyoSNH5QbOXLDbbKOtE?=
 =?us-ascii?Q?t/CZa6jDk6Kx/VxJHjnSTq+46/pVcggkG7SG4D4rzv7bgBhdLvNmHC7nXn/L?=
 =?us-ascii?Q?h/QCyIPusFFEwNdZWRb3okFdGAaqVO/jHgnKkK+NVYXI/DT99e2rw2RaIGsq?=
 =?us-ascii?Q?PDOrcZ8tcnVQPVl3UAsw97jjkVxtAHM3avkGHLi+4Zc8JlUu9jW0ysDPDZro?=
 =?us-ascii?Q?JJD5fxsd39rwr6Ak1KSnOrNYjLiuCT8DfVyOHUBUwgiJq89/j6UO1xoqYh6v?=
 =?us-ascii?Q?A1QzRhmkINdEUeAr1SGzD0Vl9mOsIDcVlgKnxLhN4LgBM+vivG0FsMN4MV+T?=
 =?us-ascii?Q?XtIVr2dSIRNsGOM5vtJNbOYJB/2s2A9cbaXO+FBsuFFj5KGNqz2OKZs5dKC8?=
 =?us-ascii?Q?QLtruCH4QHGmvfk10lkZxijiuMcOfvhKfHbzbZxLiO65DMA3J9iCdqDFbT4I?=
 =?us-ascii?Q?NIGyGWw2VccKGQUzvOAqW5ZzJa4I169QfY0U9M8tCXUevVZX8DC8efzLGr1o?=
 =?us-ascii?Q?fqOgF9M0b9Exbb0pK5coZfzZnovX7tHU35QePlHtnFZ63/TGRmbVLYgHQjKI?=
 =?us-ascii?Q?z6pGDIxCV27/nyd3Tit3uUWt0yZhQ6Pf0Nk5VbvUCzO/L0rm4K/6yKEDmLqZ?=
 =?us-ascii?Q?x+Qo/AnUCZXurbT7HOtt50gcnAiJmGsOtZdQP0kLPvDu80OOEZb8TithdCuX?=
 =?us-ascii?Q?MBfN7QYx1Br/DPPPnJ+25YUXByWcde3BZfEZdwdHvBB1oHM2IPbwjrrgwts/?=
 =?us-ascii?Q?6kNobei7gZntjo/B7Ed29VZqdRnbW8Gw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o3OeoeuehF0O4oGsyXWFcuLTtCdAzvMP/xShgXEaxuOkiLnEsASQPsAuwedG?=
 =?us-ascii?Q?I6KvWBNeL9QtKJJTA6RBV98pXHhgdAUa82agY41YJlt5ufOvK2RMKoNNQGHw?=
 =?us-ascii?Q?+0aluYV7Srtpb+IuwIMHDAcvbSR+dkLw7np69K9XGvDJs3RkCDcxLGoqAqzc?=
 =?us-ascii?Q?idlgHGNfigW+ZxqcD/NnEhSQAXPXFVhU1yD7IddunP47Zxv1ALdBxSWVhIMA?=
 =?us-ascii?Q?XUQeI7lkVuJE2pzinJE+heQ3cL7gtYH6k0QQjHw0JwvP58pJsXEpIfIvHLHk?=
 =?us-ascii?Q?NbiOAFvk5c5Fir+MFrFpJ6+4i817viy9c4DLoWjx6X4pfy/pb0kAApHZfByz?=
 =?us-ascii?Q?Ru/AN2f9TAB68sP6CRv0HK1KYDhKqU/Kzjq81H9+FwPVG8Wyn9fQnYPvLs6L?=
 =?us-ascii?Q?ZRdd8/we2QDwU2ScQuK68YZhtp1Eo/VS9m0ekdVxuncC3i5czBpOh17z2rhw?=
 =?us-ascii?Q?bFFKS4tIGp86lMJ8Pw3BCa7xmk1AVjtVUKfbWT9LU6iwpLp7u8DmDjJbdI2H?=
 =?us-ascii?Q?TV2Ff2YWPgRlCfAIV1DxHGHMk8rJVFRLWtHC4j8Farc1Rhk2dHJi+ChJ2YxD?=
 =?us-ascii?Q?lqUnR0ziakIKZu2Se8pEf17Cj38fUowUaIrm37/orW7ZYpbcQ7tO4DPc+CP+?=
 =?us-ascii?Q?/5L085DAOz3AFOwi9pdfIsEphtIVg7MHOS3/deVc9KDi9Vty1D8AXNj4wIh0?=
 =?us-ascii?Q?zcfCs8HTjFXxuij+56G/q6GYlzjF56e0qnrtYKkdl5K3zo/9WjBMEQw+j91l?=
 =?us-ascii?Q?7KY/e6VQLQrZ0OaTACCQI4Th2j4x3RDkdFDOu3kMFsTfiob8R8FAYb8BIaR/?=
 =?us-ascii?Q?epk3FAdyooTtg76Qs/j0L4EBs1nWAJUaMQoLZVEgrV9BvDp1j9gJxUhxiPAH?=
 =?us-ascii?Q?xe0wfhljWWVifDJRtr40DpCbEGCrRSAOeBZNTzhZBsJxbXlDgYK+aPKvDb2t?=
 =?us-ascii?Q?GLFa+2fVul4rl6rg3eWwfStdPnH7dbJCu13u60NN3pxvCyM1dElaUw3tLoZ0?=
 =?us-ascii?Q?amQC+3IDP1p9yiwtfXjkavlcxaWnhbdZhiUTsIIJgNMTMdo1demT6KoAKtxD?=
 =?us-ascii?Q?fmghJQwgxdQV0ZPyIFnNUdzCU72uhA3W82V6NsdHI9AdlB4ejZPODXiOSnf2?=
 =?us-ascii?Q?AJC5r8a9+nXW3am58hJL2t5CrjscFB5GXA3K3lRiIYpUmQ1MYJMCTLA4PwIO?=
 =?us-ascii?Q?lQr2uSkuoq124NoqzAIUfSaRq4SZ5J+XIL+FXbcVG+erghAycJJYcOOCsM2M?=
 =?us-ascii?Q?lyl8acaCrI9Tzotz7IgWEHVcsZVn6FBqu+Oa1JffENpfhzO+cPRScPtztC+A?=
 =?us-ascii?Q?Kl8bNucmL3BtI1IAeGH6FxUnWJfQl8EwKPGiAFpvQmHGojZb6rxQr1kFHx/m?=
 =?us-ascii?Q?b057LwPG3ou6O3e3+ZKu7FP38LvgrtQYuO3qT/CrWLoFZob2gMA05Jg60sdN?=
 =?us-ascii?Q?ZVT027mXtCPJiGK3c2VcKcs1lS2/WFfah3RAEbzWl6SWxORnNPGIroIsapaD?=
 =?us-ascii?Q?mu8Hb80Rp+nGnD+VXwyDFyN3FaUvN8BlSgR5Sf0J/pBDS3j0L35Eo688hwNH?=
 =?us-ascii?Q?sF4s9gU0npZH41LA0pbsQyRbJhnEWa5lVk5mgtj6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea47aaa0-5c3a-487a-3ff9-08de0daf66b2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 19:00:12.8897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfrxzTlUpCcTv6nkMXdzQ1b+If1Fz/tANy90ufL4bMMjKT+99ljU5H4oPPCvjD9NPSP+hntrTxYltPu1oB22ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926

On Fri, Oct 17, 2025 at 05:40:12AM -1000, Tejun Heo wrote:
> On Fri, Oct 17, 2025 at 11:25:53AM +0200, Andrea Righi wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > sched_ext currently suffers starvation due to RT. The same workload when
> > converted to EXT can get zero runtime if RT is 100% running, causing EXT
> > processes to stall. Fix it by adding a DL server for EXT.
> > 
> > A kselftest is also provided later to verify:
> > 
> > ./runner -t rt_stall
> > ===== START =====
> > TEST: rt_stall
> > DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
> > OUTPUT:
> > TAP version 13
> > 1..1
> > ok 1 PASS: CFS task got more than 4.00% of runtime
> > 
> > [ arighi: drop ->balance() now that pick_task() has an rf argument ]
> > 
> > Cc: Luigi De Matteis <ldematteis123@gmail.com>
> > Co-developed-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> I don't see anything preventing this to come after patch 11 so that all
> sched_ext changes are at the end. Am I correct? That'd make applying the
> patches easier. All the debug and deadline changes can be applied to
> sched/core and I can pull that and apply sched_ext changes on top.

Oh yes, we can definitely move this one. I'll reorder the patches.

Thanks,
-Andrea

