Return-Path: <bpf+bounces-51151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FA9A30EB0
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 15:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208CF18878C1
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4998E22DFAB;
	Tue, 11 Feb 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6o3g3ti"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9231F2367;
	Tue, 11 Feb 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285125; cv=fail; b=ETaecpfCsNLeYzO0UBj4t0zSUDZJN5zPnyQLhnjbNLtRil5EIP0YydsbKm0m/dHdRt7YB/zo31J9BX9o+cr94SiU9PQtC5lL5M3kwOO/5uZnPUBJgJOolJBd7FYCHVubjbEp0vEw+5VM39hTXNoUwyrPuFB/NCjou/+ewE+tfUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285125; c=relaxed/simple;
	bh=udsg0Zv8ux7d0TtCFteMb76Ia3++uqfn+H0bKrRJVWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dKnH0KJ6aEe44SJ5Ft+piit1zn/kT0qeQ0dllShTfgCAkEnsKsfZzyGbZ3gYMHDDv681IO9GTV20FJUwVgxQjMBWmja8/MbFnLUsQkerDpRD/wBYLm/ax96XiMeDxdQDC34mxnMXTxfXTX6jTEVMtjz71mzAuV/NqrYjsiOTI6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X6o3g3ti; arc=fail smtp.client-ip=40.107.102.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLS4/oCG+BxPbmTXRMh2ciykBSuRUopwOOqk9HxHhW2XznjHPlLVcvSfkCgg9q8rYUwK4KH2wF3o/xwvjOsNkclarhl8TeMIbEKMVONC+MZ2WLgQva+vGKCKs1UtCObjLvIRx7YAvxrJAkg/mPVOHCjPnC7UvZ+zrNgkZsQQBRbp4VLtwF5fO9qBtErtyCV7y7ZTzsZRdeSS0Q97xXY8DBf8TNoLSm7z4NO7AaAC67bFhNpfDScaa4ebRX4AonjX0DELfGlylD/DPkwQphQFSNSrnUCEPmWbSTCoyCC/uosN0eHtAPHKSE+IuQgWqaZaw0OkaacmGaxiX/MlCd5F1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDuoJG2cl0HqdNgGVwEUKhgY421DgGbcfa2U6G/w7H4=;
 b=T1RRqC7ARkFuABdNXP/qOi+1ImQhss6odkctpKRk8G8BxeBTvPlDglMwCkpkEZUH2SkV4MZiWXley/j9ZSR9j43TcpJp4b8g6ijxMSBrf4l9cohUIznQ2pFVUUz1y3F7XQblv2/B8GM62bvmwd19FcpKDY8iltPg81vXcpj2rerFCWtSAjBCiRyYOR3XDsidDw3n4VhhrpuPyfw2QrY4Ku6xLnyuYVA1FDmrtHqUNR+x8PSXM7l9iJ8W1RdFTuLZ5YZKB7neBkDyV1GOcsGhd1DQyz912MVbWT1vameqeu5QHRMEv8hNsKS2hPDbyaJwHrpg0XuHqtbOfm6QvK+A7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDuoJG2cl0HqdNgGVwEUKhgY421DgGbcfa2U6G/w7H4=;
 b=X6o3g3tia8ld07EIFpycXqtb9tUiUhximnjU65nkxTM2h4zliQU0bFL2pS6oD/zcZvt/gAg8VIR8mI+VIV0PogZ+bsj5LiVUtK+u53bMFj6mSFBdNcgoKOuMERG1MyhPvsvLlxWg+4oZw1iWSHTrlU5RHBkRi/YBB16m/aP3hqymFqP2CAdTT+3NF96Pg3rPfcBj3O2Ez3oVAR+B1EnxyJyFZVWuqmLSXi1unsq1zIVasPHcyX4L9ZeWoqVO+GhkUlmLZY7Cn+/i19vfHOvCEu2OMhFMIc4ZMrBIgXv7Q45MUSWWsNuPppsDww0OjjyUKkGMz9r671glWNk5mWfbpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 14:45:21 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 14:45:21 +0000
Date: Tue, 11 Feb 2025 15:45:15 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: idle: Per-node idle cpumasks
Message-ID: <Z6tie5F-AkGkiV74@gpd3>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-6-arighi@nvidia.com>
 <Z6ju7vFK5TpJamn5@thinkpad>
 <Z6owBvYiArjXvIGC@thinkpad>
 <Z6r9H6JukZi19dQP@gpd3>
 <Z6r_NZui9GibrQHY@gpd3>
 <Z6sddk2otmAVrfcb@gpd3>
 <Z6tciKa58iqWZ3eM@thinkpad>
 <Z6tf3Rn0pamy3g1_@gpd3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6tf3Rn0pamy3g1_@gpd3>
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 73175de0-3674-4339-fdc5-08dd4aaab592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y3Ll+zdspKDdw9PBehFiGBNxhQqlmW0iyXvQkmzqG05VEexVIel3f+8hO0vX?=
 =?us-ascii?Q?nYQPhVpyBP7fI8sW1mjvfP5mNoZXU2dETDuDV3viYUd6qzvSJR3lb9f5c1/t?=
 =?us-ascii?Q?UszZ7xNlgqCXfsvjM4bvZyEPgOwnNNHSm7fUPKZ4AB73TS59VKbwfWZL9lzN?=
 =?us-ascii?Q?BD2aPDS0Fe/AxFFKPzmUeKmpowtMHMihSjWSe41JGC6Hmayi/hR43QGWoIud?=
 =?us-ascii?Q?Oe7hniaEIt9eyjkz+z54AxROqYwXv6aUg9Kc00gjR01F+YdAqJB/x9hmIdZI?=
 =?us-ascii?Q?MzCl+JQ9ZCGrAkgwZJYc8aZfhIA5DyZfDOJ4hapmY/qvAYcUoc16RaDaRi1a?=
 =?us-ascii?Q?8Bvtzc+cMh9r5AmFQg6IvnHzt/h3siRnNgzJemyrQ6o7CcxALTQe09iImr7o?=
 =?us-ascii?Q?Sc8RwctlPUtAAIrFdDrdgLqsP1F6pFRM8LXSNtjwwnYTSefIuaOtedum8OQL?=
 =?us-ascii?Q?B7IruNk6aEHZ22zCWVsyEpBmMQYLmxIa2KEbNais8X60Snt8sqJrNwd7r0UD?=
 =?us-ascii?Q?yBhK5r7C/Nw0WDvOiligjsu2cYLywu30YCjX0WUlPlYwRaMpOMCJqzrnupcS?=
 =?us-ascii?Q?K12USitBHcliwDaR0pl90NtX1FUhO/0Ei+XhXdgmcdVvtI0EjB8+Q/RERNsT?=
 =?us-ascii?Q?XSZe+Itkq+U4ATfoed22t+rAL2s1hNQHaexW1aibNVApcvmtGrYHWdLhB1Ih?=
 =?us-ascii?Q?AVPFP9nGTh0+KEvQ88hFvTaefyDq29mB5wgep4FkCBTiDxJrgty1yI1hS1lg?=
 =?us-ascii?Q?QwatnxWnWfySWTQuo7IG6tdhFV9SqpabP7GcXjKZxS52G620jnyZtA38ahTy?=
 =?us-ascii?Q?pNLRZGw0+ds+ggQ2onQ+pQoOn3HoyJb5fRdk7ZKdYrmMqUZ1jc9hG89hjB+d?=
 =?us-ascii?Q?2s3p95w1N5i6fv9/JAJ9SZC6O2vYLc4oIdxb9gTcyIL3RdNxY8aNKrC9je05?=
 =?us-ascii?Q?zilm/OL0YbFJlRsTIwBUOiYqOHFxdoudfMiIZ0/oKdMPh0Nvq47wnEkOiFDn?=
 =?us-ascii?Q?numBh8tyLBxLT14DKCt4Mo2ZdBtfqVZaz0At9U6f8PjybdS8hHnaxqiBw0Rh?=
 =?us-ascii?Q?xBMLGpmbHhUigsH7GrYWxJ/nRHtbqRXKZe+M1p76fieHzTh+NYZ1lLyBYLqz?=
 =?us-ascii?Q?y3yApitIdnWAsndJQxSn8Hfb2DZx7ABN7cJAWosEsSN7i1pG5Bzv8K7EhUmo?=
 =?us-ascii?Q?Y5mmfuStzHKDVDnNTqjzMGIKUS6G80/uSugZ1OWL6Oz982SJrn8AekagZwyK?=
 =?us-ascii?Q?3/b4l0ad6ttxs5RqTuj9lRPzhp+lZEaKTItEJTWuzA4D/AUqc/rJTB2XlYQs?=
 =?us-ascii?Q?JlpMFIXMKn5MtfIvZ0hEDZGuHq1Q7WFFf6B1Xvn2oRWKWubQizMa7jHNs3NU?=
 =?us-ascii?Q?UKLyyqhm/8+/GV1WzJtp6tmrd0gJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PdU52cm7VxhCwlr3pixxCem9kQkYAipuchrOMpgIDLfz+TzBF0YDU2/p1ubt?=
 =?us-ascii?Q?NPqELCZD3pCoruDk2WjOO33II/46nHit4KAp0bT8xsh17e/qbIxXUQiKYZnt?=
 =?us-ascii?Q?q8rpCCXYZgxOmtbNbGPhBTRNvQPrEcDOVlts/lL+RvnjIBenmxHYx4uwcxu/?=
 =?us-ascii?Q?CcSh0FuYyZ0elEo2edGMqLAc8C4WvtBcRiHa74EVtTyIgJ7ki0pN3x4quF+c?=
 =?us-ascii?Q?eI/ErdK5hSznFeq77D3S8itYIn+rwP866X8rIgf6TlY6EFj7gsqq2g00d24M?=
 =?us-ascii?Q?7IVWKuau/iXwB3hSd3kAl3kg3lLgRKmkOSi2n+N9r7xKUv4PwrDw8YFyaF1p?=
 =?us-ascii?Q?30hbVKb2yPCj1w0GGaGqLMj6sh+6K/4WyXL5fGb+Co25IKIdHaVMK/1vrAKB?=
 =?us-ascii?Q?Gqct2n2OzX7Qtge9PX/9VGwxKtdntyKy/LYCn8DOAJf0HCEIgjvbTLv55DBT?=
 =?us-ascii?Q?A+UIMbx+LmF4QzQZnjI6cAZnH2iK9EDLznzpfnOEzqJNG2jsk5c35S/QMHKs?=
 =?us-ascii?Q?2NceIPy6JNJUADJkO+xo9yWTsoK+SYTWc5oCz+ZgRr7LdpaEvimXszY2RU8w?=
 =?us-ascii?Q?US2ozccXKVUP/q9ukRQaUr+ZsfwrUng9ltP2+hnCaGcdvsZJ1Ti3mF3vNE2w?=
 =?us-ascii?Q?bPjwOPgtwG/GQ8uD88TYUlWJFN98nCJrOj+yfmve3CWP8gsZADegGrih08Vw?=
 =?us-ascii?Q?teu8KG9jl1BD+5ynBmR+DgiaISU5E9y0xWpVmNiwQF32ZiMa76BNNf0+cNL2?=
 =?us-ascii?Q?UYrYpQmkAGnkFnFBWtEbxdcRgdQF7IwhIjwwK5ctqD5uGEz1hzLM20ePesRj?=
 =?us-ascii?Q?jMJWCTHdz3Pkt0tdzyqWmIXs7r69oAms9l6VpxWg+AdPVjhGDr1IYKyZiJQM?=
 =?us-ascii?Q?4YoKMgLWVLblO3MKabs9/c+mkT/hXdxWVzPEvablWXu2zguOGR5shC9EE7LB?=
 =?us-ascii?Q?PnzSqEVuWnzahYT7+NVbkx0S0/CD7Rq4qtafzJwzwVzCo+SKTBQ7frGPkfZ4?=
 =?us-ascii?Q?sL9nHIBsVNLrARqOG225ZWPG/FkyEr1brHnuEMI3b/xJxa479NfJBicrtF3c?=
 =?us-ascii?Q?/oUkTy/qvdGYXzem8pgzboIzLE4a1+Lj90EHJ0tmp2FcBIHqVt06uYy8eOo7?=
 =?us-ascii?Q?jikcq95drm6Cvq7vMnXCikIHdO7EwYlsxPGUuyqI/87fJcSVeXWaNg7hTWM8?=
 =?us-ascii?Q?jIxlAAcjbzkSNySwzqsoyWVfRf4stzHbqnzYzLAiTpyCbXyzjda1hhuBQHSW?=
 =?us-ascii?Q?onnzp/yePoNDd8SIRSa1pdQr+IsyUAzYON/rO4oucU3YcnioNE3QqvVDIVI4?=
 =?us-ascii?Q?qspNhzlUyfmKLyafAVwJUsixVFsNxjIxZ/iiheOkRYB2scNSG3T5vK+29jnH?=
 =?us-ascii?Q?geHfw+bX/OQjJfLvO3rmiRcmABUahtzO7XyMVHzNalooobQl9Cp/e5p5fFMW?=
 =?us-ascii?Q?9UYdVTozrZ8NQGg6WWjltKZe//9Ub4y8euG9L/4H/xEpo6/Z699ORNPYd55C?=
 =?us-ascii?Q?HEiPS8HDryLKC/ikxuytrmVNQ5aPvUq94VoVsqUJzGW+PlKYiVPzF9o1l+li?=
 =?us-ascii?Q?e4pgxW+tHdY+i0XVDIVKubITk58uRdOnQjX8n5y/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73175de0-3674-4339-fdc5-08dd4aaab592
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 14:45:21.0406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKkD0/7nFrledudXmpUA9Q0mJnlKQu5cgt7H+av68sCCjcRsiKHiVvj1qkLS4HajG903tG/lso74tkHGinmo5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

On Tue, Feb 11, 2025 at 03:34:11PM +0100, Andrea Righi wrote:
> On Tue, Feb 11, 2025 at 09:19:52AM -0500, Yury Norov wrote:
> > On Tue, Feb 11, 2025 at 10:50:46AM +0100, Andrea Righi wrote:
> > > On Tue, Feb 11, 2025 at 08:41:45AM +0100, Andrea Righi wrote:
> > > > On Tue, Feb 11, 2025 at 08:32:51AM +0100, Andrea Righi wrote:
> > > > > On Mon, Feb 10, 2025 at 11:57:42AM -0500, Yury Norov wrote:
> > > > > ...
> > > > > > > > +/*
> > > > > > > > + * Find the best idle CPU in the system, relative to @node.
> > > > > > > > + */
> > > > > > > > +s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> > > > > > > > +{
> > > > > > > > +	nodemask_t unvisited = NODE_MASK_ALL;
> > > > > > 
> > > > > > This should be a NODEMASK_ALLOC(). We don't want to eat up too much of the
> > > > > > stack, right?
> > > > > 
> > > > > Ok, and if I want to initialize unvisited to all online nodes, is there a
> > > > > better than doing:
> > > > > 
> > > > >   nodemask_clear(*unvisited);
> > > > >   nodemask_or(*unvisited, *unvisited, node_states[N_ONLINE]);
> > > > > 
> > > > > We don't have nodemask_copy() right?
> > > > 
> > > > Sorry, and with that I mean nodes_clear() / nodes_or() / nodes_copy().
> > > 
> > > Also, it might be problematic to use NODEMASK_ALLOC() here, since we're
> > > potentially holding raw spinlocks. Maybe we could use per-cpu nodemask_t,
> > > but then we need to preempt_disable() the entire loop, since
> > > scx_pick_idle_cpu() can be be called potentially from any context.
> > > 
> > > Considering that the maximum value for NODE_SHIFT is 10 with CONFIG_MAXSMP,
> > > nodemask_t should be 128 bytes at most, that doesn't seem too bad... Maybe
> > > we can accept to have it on the stack in this case?
> > 
> > If you expect calling this in strict SMP lock-held or IRQ contexts, You
> > need to be careful about stack overflow even mode. We've got GFP_ATOMIC
> > for that:
> >      non sleeping allocation with an expensive fallback so it can access
> >      some portion of memory reserves. Usually used from interrupt/bottom-half
> >      context with an expensive slow path fallback.
> > 
> > Check Documentation/core-api/memory-allocation.rst for other options.
> > You may be interested in __GFP_NORETRY as well.
> 
> I know about GFP_ATOMIC, but even with that I'm hitting some bugs.
> Will try with __GFP_NORETRY.

...which is basically this (with GFP_ATOMIC):

[   11.829079] =============================
[   11.829109] [ BUG: Invalid wait context ]
[   11.829146] 6.13.0-virtme #51 Not tainted
[   11.829185] -----------------------------
[   11.829243] fish/344 is trying to lock:
[   11.829285] ffff9659bec450b0 (&c->lock){..-.}-{3:3}, at: ___slab_alloc+0x66/0x1510
[   11.829380] other info that might help us debug this:
[   11.829450] context-{5:5}
[   11.829494] 8 locks held by fish/344:
[   11.829534]  #0: ffff965a409c70a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x60
[   11.829643]  #1: ffff965a409c7130 (&tty->atomic_write_lock){+.+.}-{4:4}, at: file_tty_write.isra.0+0xa1/0x330
[   11.829765]  #2: ffff965a409c72e8 (&tty->termios_rwsem/1){++++}-{4:4}, at: n_tty_write+0x9e/0x510
[   11.829871]  #3: ffffbc6d01433380 (&ldata->output_lock){+.+.}-{4:4}, at: n_tty_write+0x1f1/0x510
[   11.829979]  #4: ffffffffb556b5c0 (rcu_read_lock){....}-{1:3}, at: __queue_work+0x59/0x680
[   11.830173]  #5: ffff9659800f0018 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0xd7/0x680
[   11.830286]  #6: ffff9659801bcf60 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x56/0x920
[   11.830396]  #7: ffffffffb556b5c0 (rcu_read_lock){....}-{1:3}, at: scx_select_cpu_dfl+0x56/0x460

And I think that's because:

 * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
 * watermark is applied to allow access to "atomic reserves".
 * The current implementation doesn't support NMI and few other strict
 * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.

So I guess we the only viable option is to preallocate nodemask_t and
protect it somehow, hoping that it doesn't add too much overhead...

-Andrea

