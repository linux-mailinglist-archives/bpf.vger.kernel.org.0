Return-Path: <bpf+bounces-71400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2884BF1B4B
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1E418A317D
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD3131E102;
	Mon, 20 Oct 2025 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FkmpLDC2"
X-Original-To: bpf@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CF30214F;
	Mon, 20 Oct 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969037; cv=fail; b=IJ40f9HTrInPjCQTXpjV7YUp0a3UYG7aNoFKZowlsoR4Hp7Udv9bUnXdxorRJjmoJYn3ORBHNgUp+iAi4Zr1JLDS4nGp/i3s+mH+PHz7KnBl7Olo5LLQpzJueELkL0LyCGpUqnr9IykKTPLMGznKmPV6zMcWRnjmSBT26xVgnIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969037; c=relaxed/simple;
	bh=8mSWDP+o2XnHDmm2L/pXKQckgAZOQvNj2BL33zoMW8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klAPIxqeMR6b9eI/3kzgBr3eCJ7B30V1E+89MHf5XjtA59OtP+/SJYXdpFvYQf7TWSUx1G3MjTmiXmoChz865Fv6l3h3gGlgeuh+RjIYvdPKTGQssGkc5W0yyoSsasX58NWB4QPtwoe/YaZI+bdbqSr9rxOsBNkwyBpM+KLH9Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FkmpLDC2; arc=fail smtp.client-ip=52.101.57.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xthqNCzS7IA/3YNjj0DGhNU7kGDdOpD9hASYyNlNRK0Qd5c6PiZt1UI9muCgcXyog35JPq8t1twhhmvA+A3l6sSJzE++4VBRA62TaodhUC7G0A37rTCGFZgtKSc2YMY/muopCxVqPqAOaH5kQo7aL75l70vB/XxSIN3p24LCzdpgFZeggQlxDfIyB6t44FClHjVTSwNCtRwx2cGUKfh59T3uUnu1odbFPi7ToF73pAr802Gcg1Mid5oWDjL82LL4ipp3OWqAbGeBc76QcLOGHpaq1lqhXpWeiYc1knETfRudr2Z5fUe2BMf4jEKUCP4MiesCf2GaQNDhUxn0/mbcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fzuc0BOtKKqrJGaAF0QWqQWtNt9pULMz8A9ag/4mCl0=;
 b=re0t6zIANr04xvnW7/Z0ByFOt4P6dtQEPyXuQEVxmukD7wrVV+9dFstgikDzDzjlYtxC2jWCCRHYz6xgQ0Muld59AczZ5pFcVP8wGpOm+NnFmpstmRMjhG0aq/WJdnk1Lqtk84A64wZHy1ojWK8aCDiQphgElkywgO2H49elHYX10TcD5CfMMATK2gL3pyKAxMcU+ZkkHyNOeTuOeAUD665PkyPWusDBejuMAQR0NOqTEc8qv16JI+IApMnptG9BwGNroXkD5BbPszXEyrUe63Y+a2E0CWPqOC12t5M8nA2UY8yB9+il583RpyKIpVmFTEBssL6t/mZaLDLzdlepWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fzuc0BOtKKqrJGaAF0QWqQWtNt9pULMz8A9ag/4mCl0=;
 b=FkmpLDC24T2JC0sY1pr6NMjvIO293s1mp3L4bEjlsjsV+30XfvMfHZd0jcyZYz/C08+x3IGk0dwiPTxBDvNpUbZ7GG9zwkcxYwz04nUWr+o8qUuTfWLj5lR0qzZaE0c0/M+e/akeJGmOwI0g6eUgmtVai0CQDr9ntBN689MmOjGGjaudZ4Cvgli+hmsqWjqetdV6lekAdQ8MrYAeoH9hUiIqbp49VSWrm56skpm/KIzcO9lVGxjauTRGc4UYyE7mMb328rOjcUWaPNalwItR/iBgtTymk1LpVUwurcautN9W8Nn4gCgkVi8pgYqwl422D8/uV45ReRQfYOisuGZHBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 14:03:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 14:03:49 +0000
Date: Mon, 20 Oct 2025 16:03:41 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 04/14] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aPZBPQpRHm977Fno@gpd4>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-5-arighi@nvidia.com>
 <aPYFv6YcxqWez8aK@jlelli-thinkpadt14gen4.remote.csb>
 <aPY7O7NNs2KyKpb-@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPY7O7NNs2KyKpb-@gpd4>
X-ClientProxiedBy: ZR0P278CA0073.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c5395a-ec88-4d89-4ab6-08de0fe17e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W/ER0RdcXSQHAhCpybsQFv35drw8ZukNC2XGLwkUAwBGxeuvcPcUmvbZeVM6?=
 =?us-ascii?Q?Sq+yAnqK+MD7fDTOQuLqa2vqG9QzmhcrwhfochUV9klA5B2sad8GoYEQabe8?=
 =?us-ascii?Q?CTjczS4Me7Hi9HxmHNf6iMjvwhvgQn3eJOuUMGjwqB7rxO4/3yaioMTWkpbJ?=
 =?us-ascii?Q?hOBEmU2HbYsfqOkzhYKoTLU70yQqamU5y/giP7D9IVA2ltjSwOVeGdYHhl6q?=
 =?us-ascii?Q?FeQuUo8JdhkRSx1oKnCknp2gVmkoerbJRP72q9OkuYo904spL5o0hQikAwsZ?=
 =?us-ascii?Q?8PN4j40kKhyAyR2hSvsojgELuEgB6uzOGdxmNF0q+ESgoSsr6lTqu1OYSmzs?=
 =?us-ascii?Q?IAvt5ZJMcmM3cbEUa7c1+tUvxOe6ch4wkSZ7073ILKu7nEpSxidn0liQbwwz?=
 =?us-ascii?Q?jV86l6bnDPHXgn6YtTz2j3CrNQ5I3RzyfljPxnVvaohrJb5HrUXdWVqMWjie?=
 =?us-ascii?Q?1m1wkL6vzWk0F+ZB75uERAH81JPNWw7wJumR6blybiveywaFpADHGyxeA1/p?=
 =?us-ascii?Q?In49NRDaOgxFm4NnK6IU9uMx/4NJrE/EgvxNjbkgZu1Q2ndhVTJq3KuoGyIW?=
 =?us-ascii?Q?fwtG9cSj0ndhr6484SddZvXk8dwzmu/ie434fpfQj/o+3LyfFWOn4qNi+OZ2?=
 =?us-ascii?Q?BCFbEbNnXsLEtUqIklHotFQnzibL7K9y6RuXHZkeSSBfIbXUupE3cPBhseUg?=
 =?us-ascii?Q?Yuf4ZGRQ31Cs/2Vj6vBrXI/0oRp1PFeQyKl6QTNblR+SftaRhZoNsIBiYzje?=
 =?us-ascii?Q?LScfmaoDJLpiedwywxRH2VsE7bRljKiQT/nbutG1S5kJs8BSCLiUcK/9FrMw?=
 =?us-ascii?Q?lnMjDHDxpgwKBjZgesu9F3pB86S7HFlkhK3zXm7/dPkyUKU1ZPUVtb24vDQ1?=
 =?us-ascii?Q?6AZQQjTIrWy9UT5KNDQH4sU4UaxVDuHpLXdSFCG/Pw5rPIZ3jQwitVpb9nf0?=
 =?us-ascii?Q?AfIoO1aKHWe+EjmuDKqxuYOmLIRDoHamsUEsTyzRSL/c9YXsUdIHHH1Q5n5u?=
 =?us-ascii?Q?Nll8Rnrk9hScHEdK1bPflSVLaE3JkUuX4jPGO1qbYButk3u5wWsrUrVgWuQl?=
 =?us-ascii?Q?ZksqTfo2b4uYe/jums700ZaznJybZYKJgHsQWRb12mOOcxlkqeGYxF/y7+8j?=
 =?us-ascii?Q?liO5W5TZalitgCVe1UTEsL/UTDUa4c3t0SZhf6WiDnX+LSsSCwZy6+zAbdhp?=
 =?us-ascii?Q?+cHZSuAlPo4RAlKnAVo8sb+QUvwZmSujBgfMpW0JGqObzerR/f5pHiIXeGcY?=
 =?us-ascii?Q?UanMadZTfJ5yipRb2DOIuSpz3NFegBj8y7JL1anmzFbFldMfWKVs5CBQCXcX?=
 =?us-ascii?Q?1FV1A+hVnQnDgoeVs/TeXHtVufoHWOWMyDPDnJ+V/Ld0I+z8zf3iGtMBih/B?=
 =?us-ascii?Q?BEIabEYY5TcuyJchqSUyjphict1GaO8eV/VaBKW5ngsiLH2w9Q2iFGVbdHKx?=
 =?us-ascii?Q?COy4C/OP4vUxM7+E23Ppg82hgQuoUXWk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bWa2RvsuqpS+Ie6g7uffGgmFXRdKGKC0zvcNO7IdRxBI1JohS+UrXOr+V52o?=
 =?us-ascii?Q?OTUHCDkujwzn/S4K2Z3MoRIekOb3+oq57y2Fmg62cnDuS+bWRsSbxqoBo/jN?=
 =?us-ascii?Q?75XdDkeo/XfMm9T9EEjPttbfuk7CM1JGmyHtb59Qnd0XNkgF+hQ5YfEdNQBa?=
 =?us-ascii?Q?EnmgQz1YsYX1Sn6jRo9UHF+0iFDT5BsqnpZwzHLnoDhwUo4sHo9jU5mOte47?=
 =?us-ascii?Q?EDayZGWUMhZz3X2yYpjdo5S9jtQQOlbn4nOMrYBROWaELtlVt7VQHI5YCP6d?=
 =?us-ascii?Q?dnqT4yC3nPzW/b6s3fWaDv1bFI0D8/qY3o03nRSOp9byEeRuyu31yjPtLjG9?=
 =?us-ascii?Q?okOMaxQow5qW0T5kLEcflnUTlJw0Fsl4YBgggMedH5ZoEHTSKVRLy3jezKwM?=
 =?us-ascii?Q?HHG/9bUx+Ai3MES/IIHghtHEDL3+TnFYZ3ctcbw/el31sm61WmE3qDluw0aD?=
 =?us-ascii?Q?rnP44adp2KXY9Xl1McG6w6sI+7aDN4nyS7v8MFv61H1mIuq8bAGsVspvXLBW?=
 =?us-ascii?Q?PDBHUIJnMjEz0IXo/WQMP8P7tSlvJKIgS/PK/nbG4X44A9oFoK1kFjLuOYr9?=
 =?us-ascii?Q?B6iF8eSFe+hed4fVSUo9COIZrw/53lv8dpof/3FNrHpJKVQT9DVqMOfRzxhx?=
 =?us-ascii?Q?KtSqPVvBJXTiVgaZkZdlyktWGZ4qNz4dk/fPUWYPCcz3/Moh0bSZ9uF7WOVQ?=
 =?us-ascii?Q?zG2nKZpGOdmju/S7y6Cq319JSYS5LqjVzGlWGZdyr/E0Bxmp1S2hi9FKsTmQ?=
 =?us-ascii?Q?5q9X6HBQ+LHAzTJ9Ba7Tf24Z8vtF8hxtYUmRniI+jCOb8KvQ4BvABxDtQo53?=
 =?us-ascii?Q?j4LE7WHq1o9K5ygoq0La9PNMfAzmGepBzjZ5Q7HiMA4u1d4h56hPVx6onLBw?=
 =?us-ascii?Q?PbwBDmf0eVnW/i45+rU57DkrTXpb35PQvBa5Bxk8yRqrC2X7jPshnSEtk2Ja?=
 =?us-ascii?Q?aSYt8bjmPDlOp6aRanzqB7L+qbKgCC2O4zAbyl0pe1cc5ndNq7R+HN1Ey8NZ?=
 =?us-ascii?Q?YIZkdlHjaRckMhF9HzPDQ2WkvgHaY8djVUUIpe7ykVcY1J7Hpcds5PrRd7/G?=
 =?us-ascii?Q?rOCuLBvQ7XxBTTBilk66rKEEY/HV59ZoobNypkdDk92GpobONkzmFDeQmtvs?=
 =?us-ascii?Q?/VqjaGsoD99ICrDnGRk2PwuUI/sVw5NFhW5HMcjmojwvZ/+MZYVosDezxzXH?=
 =?us-ascii?Q?tRdmo0EzgzFoMF3a/DNgmmpzoWb03uB+S40y9o1TfbWQWl3D1CBDbERDu9ZL?=
 =?us-ascii?Q?flp5esZwbUyzV40XJSMahuEUzxWa6dBAOoaLIWmiZgm95Ins0L8+ha7YOPzq?=
 =?us-ascii?Q?FA9Zl9/UbjfZHRzRZMLc/x/8f2ZijzsZoPeem7ihNhj/oGLqeusJVgEquea+?=
 =?us-ascii?Q?xcIpjhMCw/s/sIsLC30PALkrfTE2Ho2XXJqlSpD+rFJ3xrA3nSmiPqPOZtej?=
 =?us-ascii?Q?ZFb3GZWKTzBoyoNDQcan15At6Veb0h/E9EZiOO6BkBxpnSLJNBBQJjIGc0DJ?=
 =?us-ascii?Q?XGbsoB5nSoBqNYls4dLy6n+bK4ckos8FzRMak/6HR0/3u8PBsHVdQyj2UIfh?=
 =?us-ascii?Q?reT2DpfjNzCgr0LYkdrY671eavqa2bgtXYtUVHIr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c5395a-ec88-4d89-4ab6-08de0fe17e27
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:03:49.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTZ5S0aJnaws4C/89dJenPglpoZOpYH7WbM4/I5R7hQyuL2ceSAZjq6WKPY+xWMRYSWvOdbpcHmzQC2QNg1UDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187

On Mon, Oct 20, 2025 at 03:38:12PM +0200, Andrea Righi wrote:
> On Mon, Oct 20, 2025 at 11:49:51AM +0200, Juri Lelli wrote:
> > Hi!
> > 
> > On 17/10/25 11:25, Andrea Righi wrote:
> > > From: Joel Fernandes <joelagnelf@nvidia.com>
> > > 
> > > Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > root domain containing cpu_active() CPUs. So in this case, don't mess
> > > with accounting and we can retry later. Without this patch, we see
> > > crashes with sched_ext selftest's hotplug test due to divide by zero.
> > > 
> > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > ---
> > >  kernel/sched/deadline.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > index 4aefb34a1d38b..f2f5b1aea8e2b 100644
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -1665,7 +1665,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> > >  	cpus = dl_bw_cpus(cpu);
> > >  	cap = dl_bw_capacity(cpu);
> > >  
> > > -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> > > +	/*
> > > +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> > > +	 * with accounting and we can retry later.
> > 
> > Later when? It seems a little vague. :)
> 
> Yeah, this comment is actually incorrect, we're not "retrying later"
> anymore (we used to do that in a previous version), now the params are
> applied via:
> 
>   ext.c:handle_hotplug() -> dl_server_on() -> dl_server_apply_params()
> 
> Or via scx_enable() when an scx scheduler is loaded. So, I'm wondering if
> this condition is still needed. Will do some tests.

Looks like I can't reproduce the error with the hotplug kselftest anymore
(and it was happening pretty quickly).

Then I guess we can drop this patch or maybe add a WARN_ON_ONCE(!cpus) just
to safe?

Thanks,
-Andrea

