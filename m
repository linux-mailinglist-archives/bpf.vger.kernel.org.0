Return-Path: <bpf+bounces-50850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1BBA2D4EA
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 09:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DCA1628AF
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 08:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9741A2C11;
	Sat,  8 Feb 2025 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QEbMZmpA"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7BC522F;
	Sat,  8 Feb 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739004446; cv=fail; b=pG92JT0Zu0rJl/fI6hlDr+ycDOFGao8/RK9HMQiI1lrv03skvHIG/JVESaMnQZw3MC0w02aQKoUBhXwHWxDKkSkPhc7WlS7suJTWRJeqpqepUkads8eU5HM1KWjCJqgLbP4GuqENrx4J+R4dhAiJAgoD7KllILutAD8zs0hQPk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739004446; c=relaxed/simple;
	bh=Ep7kvDN+tQoH2ifjKCoGiKPUM/J9nH8zE5cgSMTCCro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DKSXltRlXMLG0bksOjcPAlRiIUMx2+Hj1UXZyIKpqQXYBNx5Eyesyd5r+qDzMgPRS9BLNteyAsSF+ayaHCz9ufjNA7VQz7V9oAIOw3YONMKIqsUepT7B8OZCn4FE1DxFrp+bv5jQMlYTwDZcFoKG3/rIC72xU4FMINUR0mLB+sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QEbMZmpA; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/BjEfSPCX9lIv1tMcNgk2f64MQ/x0MtAWVUPBNj2YoLH0xpLUBLh4c5t9mZ8677TfDCaA2KTzn0z8UCCMUrv9Li+ecHNve8WIx+FDcTknACvpab4eIwWpm9bAkIxaIurX+ydyFappgytLrfXpPj7eOWjCJn6bX/jdnmP721EwOZyax6hhSJ20pGDSgTEPCcRv3ZTFZzafLI8IFbmwEUl+5mkG5CR0vi/nSdO6M3RSL8rjeSl/4qaAEhkQxQQedgFY6MJMKwc7i/GTniMKpkZut9tVlQQSXbh+zjUSxjHSjsMVq3G5s2Luu4Xz3ONaQdOa412om/GJiAklN+fso6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2gT7SgpUm3Ea0OeSsqaVyE0SOyaSiJmQrOyanCrvpE=;
 b=RLKfBtY5bGcqR1s434ZQ2RdvwnxYm8Q0ddjiKl9nWUmmWKGx4thG2EcoIVK+q8zmb9BtNADvUwAMLjWLftK93VyPTQ5d0o7szN1h48r5dB+0wJsXEMrku/qYXGWELZ9N6vl/AZVPCFvQmD5tYSJXB7AQ+LQ59Tovp2oKbN1+tnhTXFGsLv0x5q/FZpWqFuCaBGR8KfIGgxdR8MJD/4XtskgEOl2yr6dqIeczP8db1srCK1u6N+J9BubCt8cJtNE5tn8rznSxzIgP2tCByyx1tva6HhmZkjmh4BHyuE90mQP7ohFW8AIGTmiYSpSCUcJndtknlpSg4q+yub5zx6XuIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2gT7SgpUm3Ea0OeSsqaVyE0SOyaSiJmQrOyanCrvpE=;
 b=QEbMZmpAoMWqnE/zFrNB5E9YdXltUwy05+9Dcyw/hxo7AbAFIe3cSm8nDOPZ6Zd43/EqjjY62WBhNzfjA24u0tIjhJrqr75DXm1tkzMV39JPYbjfo7BDKJNLLax70aKHyxE/Z7ZxnjVXU0wE2C1T8ilUhdQ+c9GJawTLq4Z275h5LOJxcdheEJdK4yKg2HyxgjIvqxReeee3UxNUFqAuylVJOVXRoqFRrEPJutaq+YUNDLlMX5P4B0XCbw/DronAG3SJnLpSmpMsiadSSK0VdxqtC94WcJpVQpYJY+FERsuhQzY9BnPhVppT+XIJHdynDnhCnQOY3kxwF31LmXAspA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sat, 8 Feb
 2025 08:47:20 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.010; Sat, 8 Feb 2025
 08:47:19 +0000
Date: Sat, 8 Feb 2025 09:47:15 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: idle: Per-node idle cpumasks
Message-ID: <Z6caE43btbZZthiw@gpd3>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-6-arighi@nvidia.com>
 <Z6aJjTFNJKjDfG77@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6aJjTFNJKjDfG77@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: dc453a8f-772f-4045-590d-08dd481d328b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KYeqU+xY8IpgatVZYlsiJYRkeJg7kB+fV7TpfcK4ED8xhwxMZQ7WrDvIoYwe?=
 =?us-ascii?Q?IhHFr9GVbU/W32CzkzoiAWGofFe0z4Y1Ceu+qu2qhZLwF2BUvghTPJCNd5Mz?=
 =?us-ascii?Q?iN25NJwpyjoyETkBuNqYCizBp9+Px0TMMuDgmY8B4EyQ9WTSVzAZvXXrSnEz?=
 =?us-ascii?Q?kkEv9ZueWTTV3gvWtcePOUYIHmlwcSxT9QItU1UiYVQdMwcwl26/LNU8tuLC?=
 =?us-ascii?Q?x9I1tl1nOXClDl5Fd797uCn7k1YpQ9l3aIbLl1BxcjZDNwBKiA/ba2hRIBfY?=
 =?us-ascii?Q?i/e5NVcYRWwXobZ8MUtnvs1wNu2uC0Nxq0i+KPTenBwOR+3yuBQEEP7zgaNV?=
 =?us-ascii?Q?h7zip57C+Rk90qYpUpif57z9N5xqc8D99hSK54kdGs/sijkmetogeYuarWD8?=
 =?us-ascii?Q?I6mrmaKqu/QPDGATM95IE+Ub+A9bn6MHrxBgDMmR+on6Q82GXwiJkGNSQnI1?=
 =?us-ascii?Q?joyDRe/dQmYIza0nWZN7Y7pDDeOH/KH/hj7lq2Rds/ocazdlPpGiDhtXwtby?=
 =?us-ascii?Q?gT4QAro87m8Hwv82LROAv+xg0zWxnSzTanm4GgR5AQIXdBxs93bgUPzEfeaL?=
 =?us-ascii?Q?wIRQxjfXDYMyw5N5c7PLkTiimn9vp3ELnl8VqgK7dph/2VmxNrHDxUxMOPEn?=
 =?us-ascii?Q?Bi1Y/Oy2lYd/8fwzJJS2vqyb57uv0xl+BUPtJ0cSoKavJuFrHMFAGBQ37gj9?=
 =?us-ascii?Q?1NaCsfgSSsWvQtZsAGxvk0jr4jq0TxeR7e156TZIz7uGb/nBfeM9esUDwfec?=
 =?us-ascii?Q?oHmlMAD5fi89zNtz+eNz3qJk2qga5Z7xysYhBipaCLaLpyt+JtMG43whzemE?=
 =?us-ascii?Q?cdr/ud+53o6cJ0hh4WK1PWthC53c5TA1IDMoDSqHiD5ojSoGW1sPJ71+Tt4c?=
 =?us-ascii?Q?Czv73YIGwTfI21G1UiJ5RytJK/D2//GEoEZF6E6OKfDt4W0Hhge0BgB8DQYK?=
 =?us-ascii?Q?1Tmv7AWylhc0XTpyfT35XWUU/tvRi5GpPTKoDZIrseC/9IobAcsFZBjtvACG?=
 =?us-ascii?Q?zaZQ1VIXgAhV1S9BG+W69jA9UJqIsYnHLCXZqqs33JsRjYx2K3TSpfh5NkqJ?=
 =?us-ascii?Q?FYCq6Yn1lFBxosTVOYwn72yVWoThe7CKx2CtUlQmdiDYVZfLcSZhGDYltabl?=
 =?us-ascii?Q?KABekrqyoEsl3Vf0OcPEnTU11dH6kS6FO87CxrPtrgGDt0SKk+QpQpPt0Yfi?=
 =?us-ascii?Q?xCM3niUUNK8Bx1etFkLqFMPWhOrqZio9LOZ/WK6OUuZeU8Qw/xHF0HDPlwte?=
 =?us-ascii?Q?uDekQzxqCTN3CXAuvANtA/Dre+YTs5SjUv804V5UTUgyItMBuH6YzLxLx6Dm?=
 =?us-ascii?Q?8b4g8lQCZvnLCFGonel0zljHrI862C55vpclQUbVSPwrZwzgi3IuwCUDgTXJ?=
 =?us-ascii?Q?Hm/JQ3MBov1FQ5qNuDQ/D6HTuyb3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4IU4ZJRt/ljRgcasTjomCj4x4Dd52Omn8gCKxMzYRXoaLdrNq/PBsE5aIMGl?=
 =?us-ascii?Q?ZIOUjQUyuC0hihDDBm0s5EXtHKnydKCBWGhz3JX3MQh57cd+szNRmGh5SQk0?=
 =?us-ascii?Q?G3MvaX5K3WfjuY8ccpwkrGYCowGGhCQPmpOMGU3uONCt8HelNznJIBVKIjsB?=
 =?us-ascii?Q?7WDgzlFEkv35Jmyl9cgep6hnxg3aftvSjRR6dgkTa3xrZYXy4HAyU8mYaqbJ?=
 =?us-ascii?Q?MttRJef0/BbpnyhwtP4cjsLFG3Ih/quzAYHpNi5hDVXhSE5m0v8Re0d5svJx?=
 =?us-ascii?Q?SkTtMxdL8w68PMgr/GxvvQWf3f6Th2y0XR+lQ631gA2txrVCiDLt81pftCrp?=
 =?us-ascii?Q?6IknSgevN6mLoGpRyiIlMhMkzvRkTJNgDHK7WFrHHnbNQRcsxsCS37mq+ZCj?=
 =?us-ascii?Q?AXUCYQVNon3O4mN4wxD0aYkQTK3Em+LeipBi/ADwVBoQ1AFsrhUEAbJdJcjp?=
 =?us-ascii?Q?wCWqEJHzKYb1ufuvLTpwDoyOuyfypBw1y6cTwKUcHdiiVuQixBpPnnyVGaOr?=
 =?us-ascii?Q?MqMRBKNLJP9Xyua+yOC/zb7zTV/zLSQFChxtacP+OwMHdgNiJgFfpCvE0spm?=
 =?us-ascii?Q?uxGarqoTmpkjeiDkhmkxzuQt3IIgfDFuUcgqBcUteXSm5o8k1RXpFN+HodHt?=
 =?us-ascii?Q?VoRQCnMEOusEkyHDOKzOq0w6GL5P/p5WUea8qD4gzvmEQZKhWETVJXzLYymM?=
 =?us-ascii?Q?4W0RU29P2iZeYSHsqcjL/VQH80+T647XKAG+Z7J+YVsn4mR+ZwqjNmIb3QRZ?=
 =?us-ascii?Q?c2NWKO9OWyhtRfYAuQAlcKpTiSyBQQRrJ0sMRUrdqKOptLSG7wsN8/HfsIbr?=
 =?us-ascii?Q?KYIDXHf8yUJc52JEwikAVOwvZxnwlGQu2U4zuMnl1Q0gfWZk9MwYK1T13P93?=
 =?us-ascii?Q?JjvgVvqdLaFspfhUkEBkFebo9esU82dbixze8A0gQ9FAAU0xy7gfVwN2MiVd?=
 =?us-ascii?Q?OzCEBf6nnuPK6ZZpztnhMyjHj3QpwD0vrxFK9Et4sVx3mG8RScU2UhGAhxQg?=
 =?us-ascii?Q?m5a13VqBq0Sf6Fm4f0con+wt7WSagMb3RAvNnKmb+RnoxIZ3Ck5IhzwJIOLI?=
 =?us-ascii?Q?qegbw4ogTvhoX0jLwRxch+CLRBSo3bdUsBp8y5G/AAFliNkmeyeiaCtcu5y1?=
 =?us-ascii?Q?bWQbL9IivOXfVN4jvQ2NcLnU8L7Q42d8bA7YB72CSMyInZOmp+QPzn/BOB2Y?=
 =?us-ascii?Q?e9eWI05+n0vup+RGmTjC+LdEZb6wuClcaUwC3jTV3pzHEVvrAMRnelvFHi6S?=
 =?us-ascii?Q?sCyqcWGFocbhprMdClPptK2lYqx3K50ofhCYaBdev08OlQ3kNE6a8Q08Nqzu?=
 =?us-ascii?Q?01BfLvYraj0FZSb8DztE6j5BvnOXSB6C89rd2zZ9WAl88c3OZ3kiHPO6s8z1?=
 =?us-ascii?Q?FMaiHhUoBye+H4XCwDCQa8BGfQrIouBJglvyTBFgchTw89PuVEVezenF35iY?=
 =?us-ascii?Q?d6hpPsw5txMnXfswNb+Y8NovWEs6TQCBCIUt7yriT6tOwiNE5yu0Ahqz6hnV?=
 =?us-ascii?Q?Qs9bT6kUgbAbCot5m36ndPmOl7D/Kn1o8IRBqkHrlwV2pb0QNRzt7GLvh6dz?=
 =?us-ascii?Q?jo1yr+Ee0yDIpxW5kiMhldAj737BrW6U0BkB97Tr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc453a8f-772f-4045-590d-08dd481d328b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 08:47:19.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSRY+KG10T5YzM4Q+Nu7aiRXUg/f4/Lb6hgEyd0sAfP/BL3rPO+47zgIvgKgJAhHnuxtX6QMtloPcCy6eJoymg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290

On Fri, Feb 07, 2025 at 12:30:37PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Feb 07, 2025 at 09:40:52PM +0100, Andrea Righi wrote:
> > +/*
> > + * cpumasks to track idle CPUs within each NUMA node.
> > + *
> > + * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled, a single global cpumask
> > + * from is used to track all the idle CPUs in the system.
> > + */
> > +struct idle_cpus {
> >  	cpumask_var_t cpu;
> >  	cpumask_var_t smt;
> > -} idle_masks CL_ALIGNED_IF_ONSTACK;
> > +};
> 
> Can you prefix the type name with scx_?
> 
> Unrelated to this series but I wonder whether we can replace "smt" with
> "core" in the future to become more consistent with how the terms are used
> in the kernel:
> 
>   struct scx_idle_masks {
>           cpumask_var_t   cpus;
>           cpumask_var_t   cores;
>   };
> 
> We expose "smt" name through kfuncs but we can rename that to "core" through
> compat macros later too.
> 
> > +/*
> > + * Find the best idle CPU in the system, relative to @node.
> > + */
> > +s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> > +{
> > +	nodemask_t unvisited = NODE_MASK_ALL;
> > +	s32 cpu = -EBUSY;
> > +
> > +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> > +		return pick_idle_cpu_from_node(cpus_allowed, NUMA_NO_NODE, flags);
> > +
> > +	/*
> > +	 * If an initial node is not specified, start with the current
> > +	 * node.
> > +	 */
> > +	if (node == NUMA_NO_NODE)
> > +		node = numa_node_id();
> > +
> > +	/*
> > +	 * Traverse all nodes in order of increasing distance, starting
> > +	 * from @node.
> > +	 *
> > +	 * This loop is O(N^2), with N being the amount of NUMA nodes,
> > +	 * which might be quite expensive in large NUMA systems. However,
> > +	 * this complexity comes into play only when a scheduler enables
> > +	 * SCX_OPS_BUILTIN_IDLE_PER_NODE and it's requesting an idle CPU
> > +	 * without specifying a target NUMA node, so it shouldn't be a
> > +	 * bottleneck is most cases.
> > +	 *
> > +	 * As a future optimization we may want to cache the list of hop
> > +	 * nodes in a per-node array, instead of actually traversing them
> > +	 * every time.
> > +	 */
> > +	for_each_numa_node(node, unvisited, N_POSSIBLE) {
> > +		cpu = pick_idle_cpu_from_node(cpus_allowed, node, flags);
> 
> Maybe rename pick_idle_cpu_in_node() to stay in sync with
> SCX_PICK_IDLE_IN_NODE? It's not like pick_idle_cpu_from_node() walks from
> the node, right? It just picks within the node.
> 
> > @@ -460,38 +582,50 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
> >  
> >  void scx_idle_reset_masks(void)
> >  {
> > +	int node;
> > +
> > +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
> > +		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->cpu, cpu_online_mask);
> > +		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->smt, cpu_online_mask);
> > +		return;
> > +	}
> > +
> >  	/*
> >  	 * Consider all online cpus idle. Should converge to the actual state
> >  	 * quickly.
> >  	 */
> > -	cpumask_copy(idle_masks.cpu, cpu_online_mask);
> > -	cpumask_copy(idle_masks.smt, cpu_online_mask);
> > -}
> > +	for_each_node(node) {
> > +		const struct cpumask *node_mask = cpumask_of_node(node);
> > +		struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
> > +		struct cpumask *idle_smts = idle_cpumask(node)->smt;
> > -void scx_idle_init_masks(void)
> > -{
> > -	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
> > -	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
> > +		cpumask_and(idle_cpus, cpu_online_mask, node_mask);
> > +		cpumask_copy(idle_smts, idle_cpus);
> > +	}
> 
> nitpick: Maybe something like the following is more symmetric with the
> global case and easier to read?
> 
>   for_each_node(node) {
>         const struct cpumask *node_mask = cpumask_of_node(node);
>         cpumask_and(idle_cpumask(node)->cpu, cpu_online_mask, node_mask);
>         cpumask_and(idle_cpumask(node)->smt, cpu_online_mask, node_mask);
>   }
> 
> >  }
> >  
> >  static void update_builtin_idle(int cpu, bool idle)
> >  {
> > -	assign_cpu(cpu, idle_masks.cpu, idle);
> > +	int node = idle_cpu_to_node(cpu);

Ok to all of the above.

> 
> minor: I wonder whether idle_cpu_to_node() name is a bit confusing - why
> does a CPU being idle have anything to do with its node mapping? If there is
> a better naming convention, great. If not, it is what it is.

Maybe scx_cpu_to_node()? At the end it's just a wrapper to cpu_to_node(),
but from the scx perspective, so if NUMA-awareness is not enabled in scx,
it'd return NUMA_NO_NODE.

Thanks,
-Andrea

