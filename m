Return-Path: <bpf+bounces-47581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F809FBA6E
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 09:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B726116500E
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633F318D643;
	Tue, 24 Dec 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P1b0fIkq"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5A450FE;
	Tue, 24 Dec 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735028326; cv=fail; b=bFQ93XbX1OptY4cpgJAfk81uWxveK0kCJJYRbSzFeMCjUF7wqQ/yRV954x+UHS7tWEMGQS2pUghUFeYgFcUrf21wU4NbfMJp+kveErrUJHG/Nr4lTZXVWpqyPldnmXTGt12KoAVO3eHlpWebfNqTRJhcsDqV1JGh4lVXyJ2cHA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735028326; c=relaxed/simple;
	bh=8H8f2Q6UCpyAsVHgvOYFl6wSKoqvYrazd+cFDT6UWXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KBF1hBJSIIE3IW/auiythEzx0LMJ6c16nXm6tZNWJASYpM4XpyHUYP3HNhUeTaFtV6Iux7dthjUHFnFu+VWRsytKtaN54CZ0flA7so5198I4Ef6oGEUmTnviJfPHsfAIFW5nMPT8j2tvcVJDZmWHsuOVP16lLxyoZB4lThvb7Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P1b0fIkq; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZITujXX0JnFflMqijdt7eHB/Pc04woLygcFlVaMlnURy7MdtAuM4cueXU1I+wIZVwtedX40h/oCu6Hscx3T4YhpGiNKG/d2IArMTe+DPuutp9Reo3Fl/9I4zqF30hnpZJ7q1TgXTKIk/MZHf86biTHSQnI/eJiIkqH2AnJ+IeZpL5bZ1Jcm1TpjKWcgMB94WFs6O8A/l2YYCcA5/4jYnwYZB2AuDpW+tutACckO6JCrYiVAgaX6TV+dfuK+dOKmKQRqQ/3zVZNDPytQA9727ghNNndlcsCuDqr/9LnDhiihMBNqoEEcovVfoVky1FJK9vJmOT0j1uwO49ghLS5vBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXKiyd+cU+MtRYpuYsOo8vNF06Vme8292IVEk3Mi7cs=;
 b=VJ+bH5GmaqQR8JA0BLLmMrqPOzi8tEGf7mYot23g+zSh0Oq2o7VYLKrZJAI9K5cWjkqLShYJw31yxrv6zfA/AJ2Rw2gqRe1Jm4b8RYy7FQvI5U8vurYtGSBSizdyhNsusdMtMjVw2MmQsBtW7zF2GC5GsMwCMZW3wAVt2rHmZz/oUsUOF3UpchNVNxrtvmmUtCq9KZDHEFH4OrQODSPlQNnmX6ihGw85jkLhpSpCgN2K0SLHs9DadV73mQlGW7TycjaRX5CsnCRe+rzs3fqRFieJa+bsg5F5MNvt204LQs2jglTh9B9tOTGF1IoJNNC3ZyWiDw5NGFAz5Ahgm54UeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXKiyd+cU+MtRYpuYsOo8vNF06Vme8292IVEk3Mi7cs=;
 b=P1b0fIkqkV0jvCEBs6O2nKR4EjyS27sAwJD0VcfhJoNOn6kOfL877vxiNlsnI4TIP5Q1rwcopDFVMoo9K8vxbDeVc2wUOOQfqa+p4twKmxTQk/0RkmYF7pE0eianpK/PEhL61cX/ftoPX6Lu1Rzd59FZ/aeWeH1d8PShhuZUOpc1ym+opFfz3SxPhYZwU54FHpBHUgBwHBFuCNNg2eOmTIN7DQ3TRLorc3OlSo8BxHeFCKqh3i2X40fr1nFuSJSsHmPoohCQ2I+oKm1GuDwkbx+xa3/OkTfbOCjtOnK4GVnqcRqezYoXxi87uDtlqi4hAHHN++4WvoKS3v+HGUOPRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 08:18:32 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 08:18:31 +0000
Date: Tue, 24 Dec 2024 09:18:28 +0100
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
	Valentin Schneider <vschneid@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] sched_ext: Introduce per-node idle cpumasks
Message-ID: <Z2puVLPsfKtAqpTl@gpd3>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-8-arighi@nvidia.com>
 <Z2ozISbYmWPj7VNA@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2ozISbYmWPj7VNA@yury-ThinkPad>
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b65776-b321-41db-60e5-08dd23f38d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fpZJbtV31W85PZI/zVQe21OQsJIhLfegtoJZp6rmBhigdSQL81kQyXE1oZaa?=
 =?us-ascii?Q?WBllpL+rr1CToaH5rvZ+Xvm80ROxHzPDXg9/ba3BigfINhaUfU4thy9QAzAL?=
 =?us-ascii?Q?BqDrZfxw5Eqc586T6HuUprk2XhLJy0V50x91yeUCkm/KpK8MLfw12ACFf971?=
 =?us-ascii?Q?NK3vVTvtL/91g+S/covjaXnuA1ZYYyteTMYb4pyWfwn10iyp6vwGLs5BcPRX?=
 =?us-ascii?Q?xq0dSgVf4dIuD3m5bvFZKd7ZbTSrQRa6CMGoSTEZqNYASdevfSqhMamSO6GN?=
 =?us-ascii?Q?Dyeie/+x4OtHH51YGb1/dH6d1nxpxFK76DxY9Uhv08qa9bXmeDzlneiq9HNx?=
 =?us-ascii?Q?ZPqkQaCm8q/iD4TfpAJKAdBnT1lMEZp1dXuKO2MpR6aTjpVenLQx3X6sIVjW?=
 =?us-ascii?Q?akwyqlPhr4IaXyqQpdSh8LeaU4hAmHIOIM2exatQVobGvZJo42dQ1LRt86G8?=
 =?us-ascii?Q?AtPNDvA4MN2mSN9eSbPxRom6BYxXtu3nBeSQj78VpFytB1+uupfS6Dh5Ckq5?=
 =?us-ascii?Q?KCTWhWo18GdXklhORF+oAR1unVxDYSAnu1CTrmBOU3ll/Cq0ntEH8FsAnE0Z?=
 =?us-ascii?Q?ixzINL0872wswjJaRPfbjdWWC2q2RjKz9NYJWxfZeHKRa0IIgoOOelzRukxI?=
 =?us-ascii?Q?WgKXBnxm++H0m88lj1zyBQ2pPmg+jOvhInn9YqCpAF3fDqxZmBIWKYF2wGm4?=
 =?us-ascii?Q?fo8iB6HB4cWqG0ghroN9wLKVNVhZj951w84AShT8bO0u52jykUdfZiHRfZiV?=
 =?us-ascii?Q?1xo4hrHO+8rrdqDySQvVipSqlU2HfgaBlREte5hgN3R3l2BfDN8TaZjGWW83?=
 =?us-ascii?Q?cDQRh7fR7vvg77iOojTZzFJTHZCtujQbR0fGC8VR0aRi+vWQX3J+Eum+Aejb?=
 =?us-ascii?Q?n9pUQpVcCzmY1y9tlsbTXrJ/3W4jqlEISmFp5D2tuapiGxlQGhNs9pBplrfB?=
 =?us-ascii?Q?lMBQZmIIPebmDpbXMAffBDlWwqCy3D6O/D+3ZCa0KR54hKTnVgWAZ7pOZ9Zq?=
 =?us-ascii?Q?griz3pxJ9x0zXaIgMPtpVz/3JsuXtIOXk5EyRUX63Is9bFQXR+3+3Xc4OOWN?=
 =?us-ascii?Q?G4gLPy1iJ9iX0LXez3o3T6DbYZeXJ9lQI8MIXavNh9kuFMqbLtl2gLZYuHeO?=
 =?us-ascii?Q?k/o8a6hX65+if5WtopY1vdrdadAUf0kQ0M0omR3RueWj+GO8KvkGwilRpgAJ?=
 =?us-ascii?Q?oNF+GXmnQcGvhpA/oF7aO5ZK7LhSOkHeBKXYgP0oBlFGZMhwjJ5ebKPNmFJ1?=
 =?us-ascii?Q?7uUKwTeWUxk7jFN6PeeIn9pBE+QYy6C6XDg8tV7Lvb6luB/qOL02T3wKTXGV?=
 =?us-ascii?Q?SDHHK80hxfw+9oVU7G7HWYiE415apYRtpi/zjHPGu5Dvzwy75LoLr3h6EYaK?=
 =?us-ascii?Q?ST7AGEWyp/w5/bLgwH9j+S95xWHW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HfbHMWj6F48vJZmV7oz4jgQggNjFvghWUY25SV6aBjOlbT4Wmlxnccw1cBSb?=
 =?us-ascii?Q?GKsBU3OPnP+iDP3yx4m4OYy2zVzUMKKHk2BLkQaSHwhwzWoCva+4abQkiziA?=
 =?us-ascii?Q?ypJmvkhA5W/Mo2KCzYsVyksQasxAmVbVN6VeSzOWR1p4Y/vz/tOGS+prdHRi?=
 =?us-ascii?Q?DRiIklPlGtdqUvx5LL+v1En9Q5NPDapWPrIP4r7zXoG6P4bO9e836TUfpQuE?=
 =?us-ascii?Q?Hg4Vz4ds/2W8QyvtXJpae5ZIzuEpPtxIUKgWlm4IeObDxUCsMotuQFgaeT2Q?=
 =?us-ascii?Q?FA0qqAmgummhu9M7Q4jTFKG+OX3+iNwKAa5qh3s+1/xwS+vJcwEtk5UDzlgV?=
 =?us-ascii?Q?FyEfqczFyh8b1ciwakiJj19W5nhgbaaRlmMFur0rQzNjgWf4eOsDDuJGWaIL?=
 =?us-ascii?Q?IHIyTZcWwCRWET2eMl0S2UtrRPYZIXl/53tDpPBx0evowNPweHk/8xgYTcUE?=
 =?us-ascii?Q?q7K076WDEHNahuz/qTXesclWNmWtLYUQ7PTZ6LKkBX21S+ykfU7VsVUiZwwx?=
 =?us-ascii?Q?TBjkyDGSLXszxITKxSvlj2Q2I5JywBOcN6PEveMBv2oEDoNAs+zOBc4ano7G?=
 =?us-ascii?Q?+54217Wkpgy0xi1XhviSNz5TW3pEElEh/iQwbWEcFv2qVnFlADntbUbDXRM8?=
 =?us-ascii?Q?bt7Gj/qpoIDFTIdcjvNNCljLiLfjHOWau4alSB9fBx8tVcJt3AyqA2PNW22j?=
 =?us-ascii?Q?KhEXdKZiIEfB/LkOYQV7UYE8t1WkNhPlqYghqyzZ8Vgh0FyLyA8Betq19ZJe?=
 =?us-ascii?Q?p64Jy8olPYRWZVhA23Le55UbSmjZrMd+eNe8o66P82Jxg1O7aVOKq6PDiJSC?=
 =?us-ascii?Q?BemCwAH+olZn8g71RS6sOiWYpDK/m5eRQ57k6hk4W0zyWhe9l+lCvedl7bRJ?=
 =?us-ascii?Q?aabOoXDOOfmyoh5n+pGsr/9LZKvCjUT2cNr2kuobRTNpBWdO3/5BRh6uz+oA?=
 =?us-ascii?Q?L+qvkEsJXxZJcLO8MN+HlZqzA3iwawE5oymCul4qElOYkmE4sngKSf4VvN7E?=
 =?us-ascii?Q?f3JLCPK6xorGTNJqavF7CxnrHTGX93nvTFuIDEnz8HySiu+aIHnt+p6b3SFW?=
 =?us-ascii?Q?JXtI0wdzE70XLy4qqCRmtxLDdxLme/CXtqsRAttch3LQUsPdzW65250IEctG?=
 =?us-ascii?Q?0MTjby9J9vEYLNSatNnxJh3dQok73xDPJYAZ8ajaca32G/k0CUZIIFq2bZa8?=
 =?us-ascii?Q?I+muqYC6Bj3nh5qfTwZna5L7OiT1sN3e6mXOXU1CFm1qGEOf5iuNzfSr7Xon?=
 =?us-ascii?Q?crsBqBbGwauAh048qaGLriPrZZj1k7ZkLsEhIxeMrbpAoIf2REykVJ+0FKy0?=
 =?us-ascii?Q?84A7d/dF8GdNNULW//aVfWWpo4lhrTSNTqJsuliahgfsPfO3QzrzdxI0oJkI?=
 =?us-ascii?Q?EdjBpq1wAO3S+moa9XkGSF72AtGLxA+VdNh4BWS5OY6lz7gqy5h1ZDKeV2kh?=
 =?us-ascii?Q?C0TiKbZsrwNGoEaaBMuDOh2HVN5oU6zsCnpOgiBUAYf33d235b3R2uQZgiTc?=
 =?us-ascii?Q?7hQ9+Nzs6ngI+65t8bpbPvWsim75+0v9c9wMe0AkXubGnRCS3ch2Vay5uvL4?=
 =?us-ascii?Q?cYn1RY3jUIeihisr4h/ij/cV9RWX2rwu05JjDskf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b65776-b321-41db-60e5-08dd23f38d9d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 08:18:31.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6pNoaVmF+vXf0SSDYqU1it/8HJz8wFzxFYZzm1ncfx9e/bdE8bJOvXnr7w5eF8GyAkvW+6kks7axbTH7zy+2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245

On Mon, Dec 23, 2024 at 08:05:53PM -0800, Yury Norov wrote:
> On Fri, Dec 20, 2024 at 04:11:39PM +0100, Andrea Righi wrote:
> > Using a single global idle mask can lead to inefficiencies and a lot of
> > stress on the cache coherency protocol on large systems with multiple
> > NUMA nodes, since all the CPUs can create a really intense read/write
> > activity on the single global cpumask.
> > 
> > Therefore, split the global cpumask into multiple per-NUMA node cpumasks
> > to improve scalability and performance on large systems.
> > 
> > The concept is that each cpumask will track only the idle CPUs within
> > its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
> > In this way concurrent access to the idle cpumask will be restricted
> > within each NUMA node.
> > 
> > NOTE: if a scheduler enables the per-node idle cpumasks (via
> > SCX_OPS_BUILTIN_IDLE_PER_NODE), scx_bpf_get_idle_cpu/smtmask() will
> > trigger an scx error, since there are no system-wide cpumasks.
> > 
> > By default (when SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled), only the
> > cpumask of node 0 is used as a single global flat CPU mask, maintaining
> > the previous behavior.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> 
> This is a rather big patch... Can you split it somehow? Maybe
> introduce new functions in a separate patch, and use them in the
> following patch(es)?

Yes, it's quite big unfortunately. I've tried to split it more, but it's
not trivial to have self-consistent changes that don't break things or
introduce unused functions...

> 
> > ---
> >  kernel/sched/ext.c      |   7 +-
> >  kernel/sched/ext_idle.c | 258 +++++++++++++++++++++++++++++++---------
> >  2 files changed, 208 insertions(+), 57 deletions(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 148ec04d4a0a..143938e935f1 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -3228,7 +3228,7 @@ static void handle_hotplug(struct rq *rq, bool online)
> >  	atomic_long_inc(&scx_hotplug_seq);
> >  
> >  	if (scx_enabled())
> > -		update_selcpu_topology();
> > +		update_selcpu_topology(&scx_ops);
> >  
> >  	if (online && SCX_HAS_OP(cpu_online))
> >  		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
> > @@ -5107,7 +5107,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
> >  
> >  	check_hotplug_seq(ops);
> >  #ifdef CONFIG_SMP
> > -	update_selcpu_topology();
> > +	update_selcpu_topology(ops);
> >  #endif
> >  	cpus_read_unlock();
> >  
> > @@ -5800,8 +5800,7 @@ void __init init_sched_ext_class(void)
> >  
> >  	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
> >  #ifdef CONFIG_SMP
> > -	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
> > -	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
> > +	idle_masks_init();
> >  #endif
> >  	scx_kick_cpus_pnt_seqs =
> >  		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
> > diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> > index 4952e2793304..444f2a15f1d4 100644
> > --- a/kernel/sched/ext_idle.c
> > +++ b/kernel/sched/ext_idle.c
> > @@ -10,7 +10,14 @@
> >   * Copyright (c) 2024 Andrea Righi <arighi@nvidia.com>
> >   */
> >  
> > +/*
> > + * If NUMA awareness is disabled consider only node 0 as a single global
> > + * NUMA node.
> > + */
> > +#define NUMA_FLAT_NODE	0
> 
> If it's a global idle node maybe 
> 
>  #define GLOBAL_IDLE_NODE	0
> 
> This actually bypasses NUMA, so it's weird to mention NUMA here.

Ok.

> 
> > +
> >  static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
> > +static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
> >  
> >  static bool check_builtin_idle_enabled(void)
> >  {
> > @@ -22,22 +29,82 @@ static bool check_builtin_idle_enabled(void)
> >  }
> >  
> >  #ifdef CONFIG_SMP
> > -#ifdef CONFIG_CPUMASK_OFFSTACK
> > -#define CL_ALIGNED_IF_ONSTACK
> > -#else
> > -#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
> > -#endif
> > -
> > -static struct {
> > +struct idle_cpumask {
> >  	cpumask_var_t cpu;
> >  	cpumask_var_t smt;
> > -} idle_masks CL_ALIGNED_IF_ONSTACK;
> > +};
> 
> We already have struct cpumask, and this struct idle_cpumask may
> mislead. Maybe struct idle_cpus or something?

Ok, I like struct idle_cpus.

> 
> > +
> > +/*
> > + * cpumasks to track idle CPUs within each NUMA node.
> > + *
> > + * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
> > + * from node 0 is used to track all idle CPUs system-wide.
> > + */
> > +static struct idle_cpumask **scx_idle_masks;
> > +
> > +static struct idle_cpumask *get_idle_mask(int node)
> 
> Didn't we agree to drop this 'get' thing?

Hm... no? :)

The analogy you pointed out was with get_parity8() which implements a pure
function, so we should just use parity8() as "get" is implicit.

This case is a bit different IMHO, because it's getting a reference to the
object (so not a pure function) and we may even have a put_idle_mask()
potentially.

Personally I like to have the "get" here, but if you think it's confusing
or it makes the code less readable I'm ok to drop it.

> 
> > +{
> > +	if (node == NUMA_NO_NODE)
> > +		node = numa_node_id();
> > +	else if (WARN_ON_ONCE(node < 0 || node >= nr_node_ids))
> > +		return NULL;
> 
> Kernel users always provide correct parameters. I don't even think you
> need to check for NO_NODE, because if I as user of your API need to
> provide current node, I can use numa_node_id() just as well.
> 
> If you drop all that sanity bloating, your function will be a
> one-liner, and the question is: do you need it at all?
> 
> We usually need such wrappers to apply 'const' qualifier or do some
> housekeeping before dereferencing. But in this case you just return
> a pointer, and I don't understand why local users can't do it
> themself.
> 
> The following idle_mask_init() happily ignores just added accessor...

Ok, makes sense. I'll drop the sanity checks here.

> 
> > +	return scx_idle_masks[node];
> > +}
> 
> > +
> > +static struct cpumask *get_idle_cpumask(int node)
> > +{
> > +	struct idle_cpumask *mask = get_idle_mask(node);
> > +
> > +	return mask ? mask->cpu : cpu_none_mask;
> > +}
> > +
> > +static struct cpumask *get_idle_smtmask(int node)
> > +{
> > +	struct idle_cpumask *mask = get_idle_mask(node);
> > +
> > +	return mask ? mask->smt : cpu_none_mask;
> > +}
> 
> For those two guys... I think you agreed with Tejun that you don't
> need them. To me the following is more verbose:
>         
>         idle_cpus(node)->smt;

Ok.

> 
> > +
> > +static void idle_masks_init(void)
> > +{
> > +	int node;
> > +
> > +	scx_idle_masks = kcalloc(num_possible_nodes(), sizeof(*scx_idle_masks), GFP_KERNEL);
> > +	BUG_ON(!scx_idle_masks);
> > +
> > +	for_each_node_state(node, N_POSSIBLE) {
> > +		scx_idle_masks[node] = kzalloc_node(sizeof(**scx_idle_masks), GFP_KERNEL, node);
> > +		BUG_ON(!scx_idle_masks[node]);
> > +
> > +		BUG_ON(!alloc_cpumask_var_node(&scx_idle_masks[node]->cpu, GFP_KERNEL, node));
> > +		BUG_ON(!alloc_cpumask_var_node(&scx_idle_masks[node]->smt, GFP_KERNEL, node));
> > +	}
> > +}
> >  
> >  static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
> >  static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
> >  
> > +/*
> > + * Return the node id associated to a target idle CPU (used to determine
> > + * the proper idle cpumask).
> > + */
> > +static int idle_cpu_to_node(int cpu)
> > +{
> > +	int node;
> > +
> > +	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> > +		node = cpu_to_node(cpu);
> 
> Nit: can you just return cpu_to_node(cpu). This will save 3 LOCs

Ok.

> 
> > +	else
> > +		node = NUMA_FLAT_NODE;
> > +
> > +	return node;
> > +}
> > +
> >  static bool test_and_clear_cpu_idle(int cpu)
> >  {
> > +	int node = idle_cpu_to_node(cpu);
> > +	struct cpumask *idle_cpus = get_idle_cpumask(node);
> > +
> >  #ifdef CONFIG_SCHED_SMT
> >  	/*
> >  	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
> > @@ -46,33 +113,37 @@ static bool test_and_clear_cpu_idle(int cpu)
> >  	 */
> >  	if (sched_smt_active()) {
> >  		const struct cpumask *smt = cpu_smt_mask(cpu);
> > +		struct cpumask *idle_smts = get_idle_smtmask(node);
> >  
> >  		/*
> >  		 * If offline, @cpu is not its own sibling and
> >  		 * scx_pick_idle_cpu() can get caught in an infinite loop as
> > -		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
> > -		 * is eventually cleared.
> > +		 * @cpu is never cleared from the idle SMT mask. Ensure that
> > +		 * @cpu is eventually cleared.
> >  		 *
> >  		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
> >  		 * reduce memory writes, which may help alleviate cache
> >  		 * coherence pressure.
> >  		 */
> > -		if (cpumask_intersects(smt, idle_masks.smt))
> > -			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
> > -		else if (cpumask_test_cpu(cpu, idle_masks.smt))
> > -			__cpumask_clear_cpu(cpu, idle_masks.smt);
> > +		if (cpumask_intersects(smt, idle_smts))
> > +			cpumask_andnot(idle_smts, idle_smts, smt);
> > +		else if (cpumask_test_cpu(cpu, idle_smts))
> > +			__cpumask_clear_cpu(cpu, idle_smts);
> >  	}
> >  #endif
> > -	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
> > +	return cpumask_test_and_clear_cpu(cpu, idle_cpus);
> >  }
> >  
> > -static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> > +/*
> > + * Pick an idle CPU in a specific NUMA node.
> > + */
> > +static s32 pick_idle_cpu_from_node(const struct cpumask *cpus_allowed, int node, u64 flags)
> >  {
> >  	int cpu;
> >  
> >  retry:
> >  	if (sched_smt_active()) {
> > -		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
> > +		cpu = cpumask_any_and_distribute(get_idle_smtmask(node), cpus_allowed);
> >  		if (cpu < nr_cpu_ids)
> >  			goto found;
> >  
> > @@ -80,15 +151,57 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> >  			return -EBUSY;
> >  	}
> >  
> > -	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
> > +	cpu = cpumask_any_and_distribute(get_idle_cpumask(node), cpus_allowed);
> >  	if (cpu >= nr_cpu_ids)
> >  		return -EBUSY;
> >  
> >  found:
> >  	if (test_and_clear_cpu_idle(cpu))
> >  		return cpu;
> > -	else
> > -		goto retry;
> > +	goto retry;
> > +}
> 
> Yes, I see this too. But to me minimizing your patch and preserving as
> much history as you can is more important.
> 
> After all, newcomers should have a room to practice :)

checkpatch.pl is bugging me. :)

But ok, makes sense, I'll ignore that for now.

> 
> > +
> > +/*
> > + * Find the best idle CPU in the system, relative to @node.
> > + *
> > + * If @node is NUMA_NO_NODE, start from the current node.
> > + */
> 
> And if you don't invent this rule for kernel users, you don't need to
> explain it everywhere.

I think we mentioned treating NUMA_NO_NODE as current node, but I might
have misunderstood. In an earlier patch set I was just ignoring
NUMA_NO_NODE. Should we return an error instead?

> 
> > +static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> > +{
> > +	nodemask_t hop_nodes = NODE_MASK_NONE;
> > +	s32 cpu = -EBUSY;
> > +
> > +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> > +		return pick_idle_cpu_from_node(cpus_allowed, NUMA_FLAT_NODE, flags);
> > +
> > +	/*
> > +	 * If a NUMA node was not specified, start with the current one.
> > +	 */
> > +	if (node == NUMA_NO_NODE)
> > +		node = numa_node_id();
> 
> And enforce too...
> 
> > +
> > +	/*
> > +	 * Traverse all nodes in order of increasing distance, starting
> > +	 * from prev_cpu's node.
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
> > +	for_each_numa_hop_node(n, node, hop_nodes, N_POSSIBLE) {
> > +		cpu = pick_idle_cpu_from_node(cpus_allowed, n, flags);
> > +		if (cpu >= 0)
> > +			break;
> > +	}
> > +
> > +	return cpu;
> >  }
> >  
> >  /*
> > @@ -208,7 +321,7 @@ static bool llc_numa_mismatch(void)
> >   * CPU belongs to a single LLC domain, and that each LLC domain is entirely
> >   * contained within a single NUMA node.
> >   */
> > -static void update_selcpu_topology(void)
> > +static void update_selcpu_topology(struct sched_ext_ops *ops)
> >  {
> >  	bool enable_llc = false, enable_numa = false;
> >  	unsigned int nr_cpus;
> > @@ -298,6 +411,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  {
> >  	const struct cpumask *llc_cpus = NULL;
> >  	const struct cpumask *numa_cpus = NULL;
> > +	int node = idle_cpu_to_node(prev_cpu);
> >  	s32 cpu;
> >  
> >  	*found = false;
> > @@ -355,9 +469,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  		 * piled up on it even if there is an idle core elsewhere on
> >  		 * the system.
> >  		 */
> > -		if (!cpumask_empty(idle_masks.cpu) &&
> > -		    !(current->flags & PF_EXITING) &&
> > -		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
> > +		if (!(current->flags & PF_EXITING) &&
> > +		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
> > +		    !cpumask_empty(get_idle_cpumask(idle_cpu_to_node(cpu)))) {
> >  			if (cpumask_test_cpu(cpu, p->cpus_ptr))
> >  				goto cpu_found;
> >  		}
> > @@ -371,7 +485,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  		/*
> >  		 * Keep using @prev_cpu if it's part of a fully idle core.
> >  		 */
> > -		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
> > +		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask(node)) &&
> >  		    test_and_clear_cpu_idle(prev_cpu)) {
> >  			cpu = prev_cpu;
> >  			goto cpu_found;
> > @@ -381,7 +495,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  		 * Search for any fully idle core in the same LLC domain.
> >  		 */
> >  		if (llc_cpus) {
> > -			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
> > +			cpu = pick_idle_cpu_from_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
> >  			if (cpu >= 0)
> >  				goto cpu_found;
> >  		}
> > @@ -390,15 +504,19 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  		 * Search for any fully idle core in the same NUMA node.
> >  		 */
> >  		if (numa_cpus) {
> > -			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
> > +			cpu = scx_pick_idle_cpu(numa_cpus, node, SCX_PICK_IDLE_CORE);
> >  			if (cpu >= 0)
> >  				goto cpu_found;
> >  		}
> >  
> >  		/*
> >  		 * Search for any full idle core usable by the task.
> > +		 *
> > +		 * If NUMA aware idle selection is enabled, the search will
> > +		 * begin in prev_cpu's node and proceed to other nodes in
> > +		 * order of increasing distance.
> >  		 */
> > -		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
> > +		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, SCX_PICK_IDLE_CORE);
> >  		if (cpu >= 0)
> >  			goto cpu_found;
> >  	}
> > @@ -415,7 +533,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  	 * Search for any idle CPU in the same LLC domain.
> >  	 */
> >  	if (llc_cpus) {
> > -		cpu = scx_pick_idle_cpu(llc_cpus, 0);
> > +		cpu = pick_idle_cpu_from_node(llc_cpus, node, 0);
> >  		if (cpu >= 0)
> >  			goto cpu_found;
> >  	}
> > @@ -424,7 +542,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  	 * Search for any idle CPU in the same NUMA node.
> >  	 */
> >  	if (numa_cpus) {
> > -		cpu = scx_pick_idle_cpu(numa_cpus, 0);
> > +		cpu = pick_idle_cpu_from_node(numa_cpus, node, 0);
> >  		if (cpu >= 0)
> >  			goto cpu_found;
> >  	}
> > @@ -432,7 +550,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  	/*
> >  	 * Search for any idle CPU usable by the task.
> >  	 */
> > -	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
> > +	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
> >  	if (cpu >= 0)
> >  		goto cpu_found;
> >  
> > @@ -448,17 +566,33 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  
> >  static void reset_idle_masks(void)
> >  {
> > +	int node;
> > +
> > +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
> > +		cpumask_copy(get_idle_cpumask(NUMA_FLAT_NODE), cpu_online_mask);
> > +		cpumask_copy(get_idle_smtmask(NUMA_FLAT_NODE), cpu_online_mask);
> > +		return;
> > +	}
> > +
> >  	/*
> >  	 * Consider all online cpus idle. Should converge to the actual state
> >  	 * quickly.
> >  	 */
> > -	cpumask_copy(idle_masks.cpu, cpu_online_mask);
> > -	cpumask_copy(idle_masks.smt, cpu_online_mask);
> > +	for_each_node_state(node, N_POSSIBLE) {
> > +		const struct cpumask *node_mask = cpumask_of_node(node);
> > +		struct cpumask *idle_cpu = get_idle_cpumask(node);
> > +		struct cpumask *idle_smt = get_idle_smtmask(node);
> > +
> > +		cpumask_and(idle_cpu, cpu_online_mask, node_mask);
> > +		cpumask_copy(idle_smt, idle_cpu);
> 
> Tejun asked you to use cpumask_and() in both cases, didn't he?

Ah! My bad, I missed this change during the last rebase. Will fix it.

-Andrea

