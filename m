Return-Path: <bpf+bounces-51149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E98A30E57
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 15:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE23166A6C
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513382505DE;
	Tue, 11 Feb 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EcFFnKJM"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BF2505C3;
	Tue, 11 Feb 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284458; cv=fail; b=T1pzlpmys1Amlwao+xN1oqRj8boTkLIrsLT63/iw12kRjhKidSxXMkw3rG+RkR4751nNiE5sb5fskpZvAW9EcDCMa8mqmKISAs9B9Y31/znJnX+rVYZ8nLGq/CTkJY1SAqJ0fhRhZkxkvA/r1cBB/CGVUwgbgdJ8cglf6LemjHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284458; c=relaxed/simple;
	bh=T8U3B/ejAKb9UrfUM2X6/LlRSm7GrK+9HYPBiGg5v40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X8mweNQONhleUaettY/mx9XGk63l1pSxeFsqLIMksc8a5Q+izyVZxLyLOVE/uQj1bW1uOEwZlgX6UNdSZcEevLuMriwkz+kKF/qvQqVkCvb1iJnL7ljF1nQFVrQs47eARCoFHg1ZUiZ49nSnaIRe0/9FN3K04HBXvbaEK+aL7wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EcFFnKJM; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vg+I0e9fI1C5MYrX0PLygJ3PjS//ocfT7pQ4syVBrT1q1II4LKkqlTLmNJKFEjkHdu1S1LfciJ1nMOjv5mdf6yDX5rNUMl55eHZjSYQkFAJOK+ogdl1FY9LfKx65aa0+G/9keuZDnsV/HP7si8NNljOCOu3DH2rH9MEGJVPWS3BTLfSq/ASmxh9YXsuVIQ5AGckq8X0gPU1VvpJV+a8dJe1SHWcQIowMcx7L+gUQu8PllUMxuzM2VbP9rHi4xRUzZQ6X902QbVEj2t9WyzCRlDgC6gvRS24JAJAtel8jS/Ep0eQwfMTb1NA5OtP/EJyKVM7bbLcNi2k7hxHps+8L6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQ/5Uj0WK2keHFDCm4YG2J+mU5hQsrpJE3UnoeMc1jM=;
 b=uNeeZ4beM6ARSnTvkbNlbMoLJdnSrh9IBi1mO+haIdjmXk9s6CLQy5ttbiERH/kbf90qBgF6u2l5YyBr/3OZT5HPbV27mpTwjaguhTwZG963iAauYVimHd2LSxO7So9p5J7rthlbpPWxA1JGyWo8uqPFjUc7XombyoK2peP+T7LTuYID0ZUyASqszog8JwCM6105kqtLxTTBZSH/hlppsSpVUybT4JVHqn5+HLe8X8i3bQNMjWG8vALIDFrQzCMAPoLJUsVWwjYymYXXlXn3DPyNaSCwfGkNEiuTWyitnePI/pg9pMEGTL/1CQ3j0cM/FnVZSJ3ESwvt9L5i8Lb47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ/5Uj0WK2keHFDCm4YG2J+mU5hQsrpJE3UnoeMc1jM=;
 b=EcFFnKJMQdatcvq0tfYJuLyDfdRYpd3z/JzcrF2hp+qKOYhE4RC/vcxvuN45jfsu4BWj8jbIk87OdgTotgi5YmzJnpBqgJfLyvhHTOACqbyhxQg/FGtjLcBBBNFR9QgWNkM8cDbSgYYA8464U/MzUSurwAAyZIzOYi1ro049wlTdLpDl1Zf7ngHg64Vpn6jtFpOnfMFsvuqdyszbC6Rxm6jjnhTNHc7XTDoF8exZF1WjQOcn39b7cwC3NDX422NWq9PMC6CPgmL4HZvEIk3l+Ja0dNJky6KD8txTRET2v761f3V7KUFgC0NV8XSyd7FHb40d7LJw9XpwBoYaAFs7pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 14:34:11 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 14:34:11 +0000
Date: Tue, 11 Feb 2025 15:34:05 +0100
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
Message-ID: <Z6tf3Rn0pamy3g1_@gpd3>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-6-arighi@nvidia.com>
 <Z6ju7vFK5TpJamn5@thinkpad>
 <Z6owBvYiArjXvIGC@thinkpad>
 <Z6r9H6JukZi19dQP@gpd3>
 <Z6r_NZui9GibrQHY@gpd3>
 <Z6sddk2otmAVrfcb@gpd3>
 <Z6tciKa58iqWZ3eM@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6tciKa58iqWZ3eM@thinkpad>
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6dc7c8-9496-47b3-6e66-08dd4aa92609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zi1Drcc9FibBJrsGnVyiW7rQMWI33GO2BOKx8gm15bqIS2XyLqRUN2yIFwB1?=
 =?us-ascii?Q?FVb5oRMsegcMYd9ZGj3ogbeQbXIjrey7LgkbMaL7BIwRaKmB7vkgg/lqwAwV?=
 =?us-ascii?Q?gbs/Ifc8f56VlhaHAFbxAeJBm7FHbd6FxWs3kXHUSe4R6QVFOeIYHQxsQFmt?=
 =?us-ascii?Q?XkJ1bT1+ZVeRQjsKfON1Vtmsog+V1RZwxW5sxIBhGG4gvFYUYuLFRgIK9Anj?=
 =?us-ascii?Q?7S5YpTMy3w29A2ejsZ18ptCOGYyJYluZUpcMKoOqZzFqEkabN+VCQ/pOodMt?=
 =?us-ascii?Q?+0396w+/OwrdOSzwPmnXZRjXN7yKygW+H9UnmZ9YNvQ8pQ55CZ3hjrLUU2V5?=
 =?us-ascii?Q?+b0TMUB+BmRbPreb/HGEDV85OZ+a89U/ybyqBsjD3LMWxW1547frPZbR7EsN?=
 =?us-ascii?Q?9bQyroEPM/otkRDecv3P+La0olxyNithDymLcI+pBlpICECkULdXHTOtie8G?=
 =?us-ascii?Q?7/FDEA1D3sgCyaONwOd07K+YuP/B15GgA4+QyhJMgdJ+iNEryhule6yeDA8q?=
 =?us-ascii?Q?K/zQ7SQwKutGQoP0xASR9t4Id9rV+JeWEps9ymmP7HlwVp8S2Fst2F17pQ/H?=
 =?us-ascii?Q?4W4l0VzBlpkLWiE6bdnxDmeSbVBO6A8lsgalZJiIwQ1fb+2/Y4T7TBuCmxlA?=
 =?us-ascii?Q?DDM2tCDSSB2OjLIoL5kvzgeBAvLcCdtnvGTSsuddDmcqmbY5nxuul6cE3aI/?=
 =?us-ascii?Q?3gpTz9SyRcahGL8yHN6qbqlsE1sQP7roZMc3pT+BNQC90FgW521K23rMzE4o?=
 =?us-ascii?Q?GFNUq+liI5b4H+7I2zOJrEGqudyERZw/S3Rw/C3jFMj36BvHnlnwgeUKlcAs?=
 =?us-ascii?Q?T8l1+rXDZ3MG76Aao/mp2cLk+Ikk9a9d0tePeQEImbsNiiz0T/Jr7VX2Nw7V?=
 =?us-ascii?Q?mN5yWnFYJdF/B97F3OO9q4MWShfA4dWxwY50GdSh8GLHTK7MA9AHEqMJr+TB?=
 =?us-ascii?Q?zOySOToj8aw+DBDEIUaQvbz+FpOElNfK/lc22sGIpSloExcyLMnqZ762Fsma?=
 =?us-ascii?Q?aZJr17KSGcRX15njDlIk6qZrBhxv1BYaPqdwcpSuD9ub7sh0UV/gdDQqUiZu?=
 =?us-ascii?Q?O+SdavKnjGPDc/Bz7DlmLQE/zGsbwYoRe+76s1VXI+vUVuNwbPfDAJyFhfvM?=
 =?us-ascii?Q?l9tpXxNV57EYupOAT0amHzkwnWv+0EzJgn/MDHq08yG07hBejaCEAD+3sk+Y?=
 =?us-ascii?Q?/wd7krMkU45O/nA/NbFJOY2o5FNK1Dc39jZMLPuK5eR60riTIJo0JAE0w5gy?=
 =?us-ascii?Q?87lAK6P15ICH8XWsLgGT/1jP77C7pia4zbPYj6cw89TnBqofwE77wC8QFvZ6?=
 =?us-ascii?Q?V5wMQnaD41yaUBZqgxxLu5F1nikru8in7UxJoMeZIGqlWha2h343bvHZlPxF?=
 =?us-ascii?Q?wrqQ80Y4Pl/phq5fsOCM2IsCYOnP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7pu7gEa9cWctPxakRJb1Jqb4gEhId0nCPACu8OvcmeT0w5a+txc+RiAOHx3O?=
 =?us-ascii?Q?foFs+NOwBRUaJOaDiQtYZpQJ/xmjBaq/J3J6FDXZoKo3MI10aek2xloelcBi?=
 =?us-ascii?Q?rLOPubTu48kGXpPPnsYyoCACrcNrOTvXAOY73uCGe84you3ojnQEEmzMzPyx?=
 =?us-ascii?Q?+uyjh8l6EOsc+GmmayoD1k4/hT1Z/86f+SePXaYMKpX1eKgkJBOzyuOHo+NS?=
 =?us-ascii?Q?Qxcn28hAzE3lxDnstalF8fbcDvC7P9Kq8CSdsrCWscgTwdOy4v2Qn3DffA+n?=
 =?us-ascii?Q?elEIYPZ9BKgt3qvDVX2/F38+cmrd69uppjbs4DKGTf9A/hXlkOMWtPYvxwMO?=
 =?us-ascii?Q?X+9KAmoE07Zy9cgbV6HJulJxRfNcg6QZAlWsGBddyF+k6yoJDUQFG14wc5XM?=
 =?us-ascii?Q?5zHpr9USZdSg9bQ4I8iAKx467ZrJhU7U6KmYylTlD8MTt5jarAXBF+huwjSo?=
 =?us-ascii?Q?KGnWeb0xBoSxh2Ng2nKAHFA2H6UQCwQSbTEh8pG7lcRb7++BR4+g+GtAJR7U?=
 =?us-ascii?Q?y1kLVOKJW1Mlb2zB+iAwING4Oux45p9ViH3iIjVXcJjQ/WgjX9hJHYD2JD8R?=
 =?us-ascii?Q?K9dInmLAriG6oY1pFsiuYJUDBYwGg2ayocPDyx6weUBIk525Fhau3f+f88F7?=
 =?us-ascii?Q?AMcq7bcDqNT0VDv944lVgWJlB0e93I+x69rk+RwDav1sCjrc4a3r2sD3a3HV?=
 =?us-ascii?Q?ngbnIwRO0MYdW8f01n977aBjxZG3+8n6y7x167/gh8NzYOIhxS5cW9YSk7r8?=
 =?us-ascii?Q?H0htn98yytIyCjBNiFik2mBKk7tnRNfKyt/QVGAxt9vphF1BpDwrb69q4+bd?=
 =?us-ascii?Q?4/LjnZrk9kELcirDwVyLv6f1c2YQNOaxlLEmpG61IJq3w4VJXmO5Rx96/X1i?=
 =?us-ascii?Q?4sqgRFr62PIzZ5+zx9hD6n/9RHBouVQj6E50W9a24KboVbi8eaZFW7g0fRKZ?=
 =?us-ascii?Q?FEd69+7DHZkBmzqC5olEhfPR9Eu1j5xt1CY00F6KRQVxrXp1g7a8jx2+8wNq?=
 =?us-ascii?Q?DfZy+qi5gabqVygt23B57VQ4a0uGh5Q+EmyWBrpEmF+ydJb5trJgdC0Ugqyp?=
 =?us-ascii?Q?VfS1LxvhALySQtIW/JbnJs3jd+1mdcoYMqpyK3saIRGgFKGzGhm3riQevBeI?=
 =?us-ascii?Q?hCE+b/XAhd/QZgl0DKqec6j1iFXmzfl+DttTY0wUHrxIQeedIoYtrStGTbDt?=
 =?us-ascii?Q?QqSxpekWxy7ymECA9Wo8UbML8QKKXmRU2mETHAGuCYLWCysIT5rFYvQ043XU?=
 =?us-ascii?Q?TK4jffWmnY10lyOB1v6Sab9icxi9zeIu/J8SX5Y/nJILTXhgLJtKSNwY/xRa?=
 =?us-ascii?Q?BYqjsgaC6l4xNJGwZwLsYGSKM2MNaalTGUslXnX5+CFscMjchiWk1h6Dc7AC?=
 =?us-ascii?Q?Fo7mtSQ/og7cwmkizrVnhMYPXgk2b0UMqjutq992KqMaU7Wbs7/FHIiE358C?=
 =?us-ascii?Q?pVlzIIJfp2OmZfeHe3h1PaaV3mVbyEgCj5MGkBnz+x0UNuXU//dt6xic5DY8?=
 =?us-ascii?Q?NtJkLbJ9+VI2jkAk+VmTX+tPu9lgvaPLDXve0O3+3sYL25q//RKA3Mw/T1od?=
 =?us-ascii?Q?Di+/VtiwBQ3MN/LX/3Xb9GKWT2yyMcIwimq+qUeV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6dc7c8-9496-47b3-6e66-08dd4aa92609
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 14:34:11.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EYMZ4B1aoCkvAn6BLQ5tC7D/Ih3EqSDpst4ZFjFQZu/sziz5ijs/cw3mxIec6O4BwACG/qzxYm5vyS7RAMlTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950

On Tue, Feb 11, 2025 at 09:19:52AM -0500, Yury Norov wrote:
> On Tue, Feb 11, 2025 at 10:50:46AM +0100, Andrea Righi wrote:
> > On Tue, Feb 11, 2025 at 08:41:45AM +0100, Andrea Righi wrote:
> > > On Tue, Feb 11, 2025 at 08:32:51AM +0100, Andrea Righi wrote:
> > > > On Mon, Feb 10, 2025 at 11:57:42AM -0500, Yury Norov wrote:
> > > > ...
> > > > > > > +/*
> > > > > > > + * Find the best idle CPU in the system, relative to @node.
> > > > > > > + */
> > > > > > > +s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> > > > > > > +{
> > > > > > > +	nodemask_t unvisited = NODE_MASK_ALL;
> > > > > 
> > > > > This should be a NODEMASK_ALLOC(). We don't want to eat up too much of the
> > > > > stack, right?
> > > > 
> > > > Ok, and if I want to initialize unvisited to all online nodes, is there a
> > > > better than doing:
> > > > 
> > > >   nodemask_clear(*unvisited);
> > > >   nodemask_or(*unvisited, *unvisited, node_states[N_ONLINE]);
> > > > 
> > > > We don't have nodemask_copy() right?
> > > 
> > > Sorry, and with that I mean nodes_clear() / nodes_or() / nodes_copy().
> > 
> > Also, it might be problematic to use NODEMASK_ALLOC() here, since we're
> > potentially holding raw spinlocks. Maybe we could use per-cpu nodemask_t,
> > but then we need to preempt_disable() the entire loop, since
> > scx_pick_idle_cpu() can be be called potentially from any context.
> > 
> > Considering that the maximum value for NODE_SHIFT is 10 with CONFIG_MAXSMP,
> > nodemask_t should be 128 bytes at most, that doesn't seem too bad... Maybe
> > we can accept to have it on the stack in this case?
> 
> If you expect calling this in strict SMP lock-held or IRQ contexts, You
> need to be careful about stack overflow even mode. We've got GFP_ATOMIC
> for that:
>      non sleeping allocation with an expensive fallback so it can access
>      some portion of memory reserves. Usually used from interrupt/bottom-half
>      context with an expensive slow path fallback.
> 
> Check Documentation/core-api/memory-allocation.rst for other options.
> You may be interested in __GFP_NORETRY as well.

I know about GFP_ATOMIC, but even with that I'm hitting some bugs.
Will try with __GFP_NORETRY.

Thanks,
-Andrea

