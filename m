Return-Path: <bpf+bounces-47585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AF39FBB39
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 10:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A162166B1F
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2111ADFEB;
	Tue, 24 Dec 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OepVQPOY"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F804D5AB;
	Tue, 24 Dec 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735032785; cv=fail; b=MPz7BMVysLVsa0N2ykTdl5pm+7Oqstu8adL8OwzbPxotoFfiKi4Q+BqV+p2n3jn5RhB0M6iu8tufSBKoxzz4Sx2vKs8q9tQCkZCLVwPNNKFeJH7hkJL+kxUwqbDDXgeboaVZkZzZPAxrSD/BufMjBP4XNt/hSF76PDJP2XXygRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735032785; c=relaxed/simple;
	bh=DmNzJdIgkUKxue+0eF22FkseZdE1hVHZo8DVrawD+vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=awAMTrObVsINznEG7uvufqKGuDm5W1v29SSEK2PiIjwNkXlx88fkw2I0DLsx14Px2WoNu2srBjA+WpAoMNSPjTk69Lmc61aW1skaLW9wHI93rfYMq7wfsr4S2Me4i7gCNujDqc0ouQe6Cg9k75BP9Sg4jsTsyH9oya3jc5gSLsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OepVQPOY; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7ULfVXEQco9XoQ1DcHWbmpKAJvZlHjTUHuowwPFYRJ4hZcDxnz3z2+ezUY844FFmNdE+YEZXt8ct2DUVe4JgjX5nomTTNj4XbDf8BBXO+KTyFM5tnQRu8DJ6v8YuU21UFOJL3/Mc7LOt3KbSR8E1RyyhY4pyASkL9ufpGwdQ+DwJUo2eut8ZGHOLuvwCQW8UcjvRLaRD+XsbWmP35LJ34IwG7/ch56V9pfrNSRivjzvccehk39kYLzttWQrVegvLk1ZnBSztHU9U1P6iLeGG6Lm5keX9lWPx+4ldFMS3v5IcquXJ4V2/3J5ltaYHIMKUz6TOmcUr0REhDKK5wcfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym6g/8DUCt+roUVnNxFHKFwJaK+Rd+umVxTyGDovhg8=;
 b=bx5/1HtrhVIZu8+ipoRqgyHBdffJbPUYQlQ6UPjYR3GYwxNY3gWP3I1AKkGu2WjIeet57DHHi2HuQ8WmSNB8Z1gu8bLGu7I1nU3/mWgdNhxsIJAo1aWkPZ2iZnldygE2oHIuKeOakbazbbX3zY3ByVBQmh8MV/QJ9rX92DFs6uHu4V5al5RVZjUWs1cpVVQHxoCnxfrs10IxH8Pln4aGhfhs5JWvyIkbSZnu/ty6l/bCmzpkN5k+JnGtGX8q/a1z/kPEkFoq4Fui9ttt6L/wrEgvcqdeL/UQsC5OtEhMA7eARIf1cTxtLSiqKnMu2/rAH/oPw/mfRypxKrBS1oOj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym6g/8DUCt+roUVnNxFHKFwJaK+Rd+umVxTyGDovhg8=;
 b=OepVQPOYkqO2Y55rPv/i3JTTKPd9fSE0yU9lLJz87uKoWBJajQ6tSSAY6tlWyCquSSRlRh9C57rCR0e0OThypgKFOJvpwzx+trTQexl0JKFe37/U4CkZ13T8TiJ9RU67b2aTKRwGZhz+Sdd3wYWrvc/x8hfQw+8uyCwFLfHPp8Nh+MhzrRQk5ueBpMv0rb5c/zxFVfKOTHFdXpCyjRkoywoDtfqx7CqF8BPqVqk7CVa3PraYGD2k+K+43j9CnR07HjL1ha/7FMn677OPDASsdHMJ0fjhO5RRj2ynHVUjeao1NeM7jdFCc0eHKGi36qQAQBcJnwrR80rTQakHRNQSYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Tue, 24 Dec
 2024 09:32:55 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 09:32:54 +0000
Date: Tue, 24 Dec 2024 10:32:48 +0100
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
Subject: Re: [PATCH 10/10] sched_ext: idle: Introduce NUMA aware idle cpu
 kfunc helpers
Message-ID: <Z2p_wI_YpG2Jlf3C@gpd3>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-11-arighi@nvidia.com>
 <Z2oG9-AS-2OwB7Ib@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2oG9-AS-2OwB7Ib@yury-ThinkPad>
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: e7223d6c-c386-4c1c-9b21-08dd23fdf196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gutg8SRkiPNcwCIEilIUz4fvDCZfXiDmBwxDCZRNklBiXbSCi/j+ELprOBGC?=
 =?us-ascii?Q?6G6ccrGepR4AXPqaIItvWFBoO5RN2137FMFF2d2EHyiphcVB+Fb6dDB4xG7y?=
 =?us-ascii?Q?udocRSwQvCCn27ipKtKtGnv4ZV5va7LI9cGmD5crtFrUtLqDyVJji59gv4o5?=
 =?us-ascii?Q?CDdhohWUPuhZJi4ZwHphS8MNyOZsHAA3e09TuoWkep/K+P6N78sz9iZpXBT9?=
 =?us-ascii?Q?UUXQwm0jb7DCrTW19I0Qc+8KEtKGnGBbdh1pfaVcBeRVt46U2WmnloVJAX1G?=
 =?us-ascii?Q?lYgxeXHehKItUi/fHw1K/g1teSCvHinPPNCL5G2P9uvDd2vk96WmMPyAEj6d?=
 =?us-ascii?Q?M/EiExWkwoyid7jUdBb20e8gH8KlFskaqfK8S3QxWrT7Kenp6ut5DFknPszx?=
 =?us-ascii?Q?qOUEEwJ03Ww25tGG+0/ApOZTqIkDe22aL+BBplPRACuQ/77uRz/VJSHZQPVe?=
 =?us-ascii?Q?+HdnZvIEbbjZ8T9Eck8AA0h1nJ1jLH/VZm1myWMwI+55qUFSL6UyZI7g0yMw?=
 =?us-ascii?Q?iclrmXLJ19auT7iXMf3HxSagurYSkA4iF89d2xOeevkrJo9iKRNUQn+iLAuM?=
 =?us-ascii?Q?3q1n2OFb/1/De7ZbYluSm4FcBsNZWjcuBc4bF8QL41hLzCn/mKIF4zItlEMQ?=
 =?us-ascii?Q?voLsooecA6wXk/p7+0deckjitdT+P2T6Gq4jqDjbubF0lYXQi+Kh2+rO6T5c?=
 =?us-ascii?Q?hh8DSpz55Qk6eA2d1L08+72Kugwm9kFyrD3+Qls2azgeurb5fsVmE6KJUSlW?=
 =?us-ascii?Q?ty6YltNqNa3T0ahsaZMyqlSfgTuIpG1s+HIHmKLIAzfgRsiLN1/inPK+48tP?=
 =?us-ascii?Q?GoK5nH2w6uLCRI770tFObueCqNcovmH48kbJVKkk8UMNmWlTdBmg7btdlXs0?=
 =?us-ascii?Q?lG+nGgiCoWEKCqMm95sB22jYi2jHuPemYgcLOGARDWKuEqsVMqtb2pKkSpk1?=
 =?us-ascii?Q?TgK9fuTb8hwGtpbQ17b/U8m/aoQpDtb7YeuSUKzjJY6NK6ps197HR9hlzDcy?=
 =?us-ascii?Q?wOATdb3ntxA6tJzbIqRIS9yrBOQ4Di/WL7WHCzR2K2pjPJhhD2K0VENGpZG6?=
 =?us-ascii?Q?axnOudyzosC7qqnOi31CDeUb22q7cidaWe7EbsCv3jGSvCW+PfeZp/VIQBpK?=
 =?us-ascii?Q?YM3mfbP7s33QNwvRtYMFb0OPDz5zTXW3HIMLWSz39xt0GTufDXsYYNw4aXzb?=
 =?us-ascii?Q?3dnN7di1qy9dunMi67s2qyRRZLz8pyRxVlyGczAhn2aazk3kux5t59HOUmvV?=
 =?us-ascii?Q?jsLFzQh++wWDvQ1puYbsZNv4O7gxAV4gjfvTYFEidlVdPZG58jzuYu5hb1TG?=
 =?us-ascii?Q?7UklpLQBbHvJEiS5S2lDqteD6BX5WQY2+5gtPWTMRY34ni2f9ST8twQxT6VQ?=
 =?us-ascii?Q?D0ozKCRzSqqEtQQiQk9v3FtFRt99?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zjrcWFLNxnqDl2qfXZs9xIeEKESsNsY2HVzMEprFNxfz6+rguoya8ao43Avv?=
 =?us-ascii?Q?OApgH39HeiRStMIFYOiwz9cGpKVKIOdj7rOa6y/FKMbQGoqMhgaMS9NhiwbM?=
 =?us-ascii?Q?3LtCIc2HEa06DulRG7CAjedOgEWQhdhNK3whvp+6XzpG7sOUiZpJo4RP1Nuq?=
 =?us-ascii?Q?jYY7X23vYvPoQoiU9LL/g9HOD+ToH+HqohQ+N9jMlB0QZ0gX02yq8GAeolJg?=
 =?us-ascii?Q?yymcMdjtiXDtUwUjbRhacOFxYSKs6fwk5Pjql0zYdR11xHC6tD5zRBqZ18lg?=
 =?us-ascii?Q?U/+QQDTTOTMwsuu+6cbq1esyolfxkPzGZo3MIR1YchT2TQPH6dEdPtnl5/FK?=
 =?us-ascii?Q?YHEZKFNAfK0wzUqZlHufx5Mb4S43unT/teejfaq+eRNzCIcxI++stWJITi1t?=
 =?us-ascii?Q?6oE2xUQK1dOTjGNNNemOlIDS5rujt/vDz9YrXtgeZuxN7jDg4HxvTC3OHNrP?=
 =?us-ascii?Q?1ZB0e/4B6Cagr3RwJjBAaZHcpWTr85cMR1tDipRUdGTAWpdLAWruALNau/CS?=
 =?us-ascii?Q?HNrWU/I7m3Gbjfz2k+8MHxsOMwy2mBG3OENwSHgKmeup2fBHn7XZP1G8UQns?=
 =?us-ascii?Q?HStjKNd7gM90gEyQ1I2HfbATSddYaz/QOZ9Hbnk/u3jWyfyxLtVDNsfBswXw?=
 =?us-ascii?Q?f//gpFrh5pfVMvKlai2e9WGi1fCgrJoObs1yw57h9kfU5TyIeAB2N2LnhtSS?=
 =?us-ascii?Q?1wghPA8Fc27QWdJDXz8x6e0xce20aFvSAs/Esc7Mvs7r9vBO/QO3N54dNVmL?=
 =?us-ascii?Q?yFVff8CfN9EfLoVOCbeBzK1wZzUwIZRw01ZPl32cF+/cIA8xAAT58Iq/KOcX?=
 =?us-ascii?Q?s1Afwpie9RV9y7SOHyzE3vvrUwb3nGXKEM1hexYjDiO/rsZ52TwTTnSuOueW?=
 =?us-ascii?Q?ULofHmluKnXt2RAUjGyzro6QNaMoTS4TwDKc20i/dHP+bxvY4psEoxcnn2Ad?=
 =?us-ascii?Q?b36pJMUOuEx33kmRzl1oB0ETvkV/9ndaEWpQYSmRPWPsgef/wj4ggw4cDzmd?=
 =?us-ascii?Q?zPCZvjCoKuE9iEYv5TA58JdW4IXixmDF7+yD+KYhFSVlxJoeLyA6nvXuOy2h?=
 =?us-ascii?Q?M8DManWWNI3x7XsID9/cKwc2C8PmF923DzXEUpjeZZJn2Ykkq2uSJuvJrQ5d?=
 =?us-ascii?Q?/tSr6YRChOabP5WAcchu/u/99gcAjD8iFF39SNiaDCyXY7NtG6GXGACMFnad?=
 =?us-ascii?Q?BB27l2eKEhQ7QAeryX2TUkTfkvfYZ199uVtn6Z4wG0HNDtuMQ+sIP5uQH+al?=
 =?us-ascii?Q?wyH1vSOfWcIRw3DmZQjyTkxskJUZPzvVJMMTIBGCNg86O64+HWZgug/g/+Mr?=
 =?us-ascii?Q?LgjEqPtMyuzJpzrZiXR/8lIIQgLds9w11LCZCluXZ2fsbWwp3ab2h+FmcIIX?=
 =?us-ascii?Q?TveHSDyzHrJNZG8Y0eJjs2X0Qof7eueRji/DTECW/glMKTPlbFZTGKZdTmko?=
 =?us-ascii?Q?hhGmzAHYeBPK67RUE1QqRP3ab2vNDNBa6Vi2dgoqF0IHJDVkp9G8/ATLmxhP?=
 =?us-ascii?Q?Gr8GuknXT1vj6DTazpUQ5imIgk+kO1qkVOtG+ODmEktLozmFt66moJjt5HbL?=
 =?us-ascii?Q?hXiPQqvu489JCVyvslXdw9DLCIdWjghv+GFnwDqO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7223d6c-c386-4c1c-9b21-08dd23fdf196
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 09:32:54.5742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xDbrI/s3vLaThiyIB0NDMlBBQz50CNVLGLf+Co/CDwtOT2G+Mhe3ADhVByNMunN3GTUaytxtBzR4jeKUVFBig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853

On Mon, Dec 23, 2024 at 04:57:36PM -0800, Yury Norov wrote:
> On Fri, Dec 20, 2024 at 04:11:42PM +0100, Andrea Righi wrote:
> > Add the following kfunc's to provide scx schedulers direct access to
> > per-node idle cpumasks information:
> > 
> >  const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> >  const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> >  s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed,
> > 				int node, u64 flags)
> >  int scx_bpf_cpu_to_node(s32 cpu)
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext_idle.c                  | 163 ++++++++++++++++++++---
> >  tools/sched_ext/include/scx/common.bpf.h |   4 +
> >  tools/sched_ext/include/scx/compat.bpf.h |  19 +++
> >  3 files changed, 170 insertions(+), 16 deletions(-)
> > 
> > diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> > index b36e93da1b75..0f8ccc1e290e 100644
> > --- a/kernel/sched/ext_idle.c
> > +++ b/kernel/sched/ext_idle.c
> > @@ -28,6 +28,60 @@ static bool check_builtin_idle_enabled(void)
> >  	return false;
> >  }
> >  
> > +static bool check_builtin_idle_per_node_enabled(void)
> > +{
> > +	if (static_branch_likely(&scx_builtin_idle_per_node))
> > +		return true;
> 
> return 0;
> 
> > +
> > +	scx_ops_error("per-node idle tracking is disabled");
> > +	return false;
> 
> return -ENOTSUP;

Ok.

> 
> > +}
> > +
> > +/*
> > + * Validate and resolve a NUMA node.
> > + *
> > + * Return the resolved node ID on success or a negative value otherwise.
> > + */
> > +static int validate_node(int node)
> > +{
> > +	if (!check_builtin_idle_per_node_enabled())
> > +		return -EINVAL;
> 
> So the node may be valid, but this validator may fail. EINVAL is a
> misleading error code for that. You need ENOTSUP.

Ok.

> 
> > +
> > +	/* If no node is specified, use the current one */
> > +	if (node == NUMA_NO_NODE)
> > +		return numa_node_id();
> > +
> > +	/* Make sure node is in a valid range */
> > +	if (node < 0 || node >= nr_node_ids) {
> > +		scx_ops_error("invalid node %d", node);
> > +		return -ENOENT;
> 
> No such file or directory? Hmm...
> 
> This should be EINVAL. I would join this one with node_possible()
> check. We probably need bpf_node_possible() or something...

Ok about EINVAL.

About bpf_node_possible() I'm not sure, it'd be convenient to have a kfunc
for the BPF code to validate a node, but then we may also need to introduce
bpf_node_online(), or even bpf_node_state(), ...?

This can be probably addressed in a separate patch.

> 
> > +	}
> > +
> > +	/* Make sure the node is part of the set of possible nodes */
> > +	if (!node_possible(node)) {
> > +		scx_ops_error("unavailable node %d", node);
> 
> Not that it's unavailable. It just doesn't exist... I'd say:
> 
> 	scx_ops_error("Non-existing node %d. The existing nodes are: %pbl",
>                       node, nodemask_pr_args(node_states[N_POSSIBLE]));
> 
> > +		return -EINVAL;
> > +	}
> 
> What if user provides offline or cpu-less nodes? Is that a normal usage?
> If not, it would be nice to print warning, or even return an error...

I think we're returning -EBUSY in this case, which might be a reasonable
error already. Triggering an scx_ops_error() seems a bit too aggressive.

> 
> > +
> > +	return node;
> > +}
> > +
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
> > +	else
> > +		node = NUMA_FLAT_NODE;
> > +
> > +	return node;
> > +}
> > +
> >  #ifdef CONFIG_SMP
> >  struct idle_cpumask {
> >  	cpumask_var_t cpu;
> > @@ -83,22 +137,6 @@ static void idle_masks_init(void)
> >  
> >  static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
> >  
> > -/*
> > - * Return the node id associated to a target idle CPU (used to determine
> > - * the proper idle cpumask).
> > - */
> > -static int idle_cpu_to_node(int cpu)
> > -{
> > -	int node;
> > -
> > -	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> > -		node = cpu_to_node(cpu);
> > -	else
> > -		node = NUMA_FLAT_NODE;
> > -
> > -	return node;
> > -}
> > -
> >  static bool test_and_clear_cpu_idle(int cpu)
> >  {
> >  	int node = idle_cpu_to_node(cpu);
> > @@ -613,6 +651,17 @@ static void reset_idle_masks(void) {}
> >   */
> >  __bpf_kfunc_start_defs();
> >  
> > +/**
> > + * scx_bpf_cpu_to_node - Return the NUMA node the given @cpu belongs to
> > + */
> > +__bpf_kfunc int scx_bpf_cpu_to_node(s32 cpu)
> > +{
> > +	if (cpu < 0 || cpu >= nr_cpu_ids)
> > +		return -EINVAL;
> > +
> > +	return idle_cpu_to_node(cpu);
> > +}
> > +
> >  /**
> >   * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
> >   * @p: task_struct to select a CPU for
> > @@ -645,6 +694,28 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  	return prev_cpu;
> >  }
> >  
> > +/**
> > + * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
> > + * per-CPU cpumask of a target NUMA node.
> > + *
> > + * NUMA_NO_NODE is interpreted as the current node.
> > + *
> > + * Returns an empty cpumask if idle tracking is not enabled, if @node is not
> > + * valid, or running on a UP kernel.
> > + */
> > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> > +{
> > +	node = validate_node(node);
> > +	if (node < 0)
> > +		return cpu_none_mask;
> 
> I think I commented this in v7. This simply hides an error. You need to
> return ERR_PTR(node). And your user should check it with IS_ERR_VALUE().
> 
> This should be consistent with scx_bpf_pick_idle_cpu_node(), where you
> return an actual error.

I think I changed it... somewhere, but it looks like I missed this part. :)
Will change this as well, thanks!

> 
> > +
> > +#ifdef CONFIG_SMP
> > +	return get_idle_cpumask(node);
> > +#else
> > +	return cpu_none_mask;
> > +#endif
> > +}
> > +
> >  /**
> >   * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
> >   * per-CPU cpumask.
> > @@ -664,6 +735,32 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
> >  	return get_idle_cpumask(NUMA_FLAT_NODE);
> >  }
> >  
> > +/**
> > + * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
> > + * per-physical-core cpumask of a target NUMA node. Can be used to determine
> > + * if an entire physical core is free.
> 
> If it goes to DOCs, it should have parameters section.

Ok.

> 
> > + *
> > + * NUMA_NO_NODE is interpreted as the current node.
> > + *
> > + * Returns an empty cpumask if idle tracking is not enabled, if @node is not
> > + * valid, or running on a UP kernel.
> > + */
> > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> > +{
> > +	node = validate_node(node);
> > +	if (node < 0)
> > +		return cpu_none_mask;
> > +
> > +#ifdef CONFIG_SMP
> > +	if (sched_smt_active())
> > +		return get_idle_smtmask(node);
> > +	else
> > +		return get_idle_cpumask(node);
> > +#else
> > +	return cpu_none_mask;
> > +#endif
> > +}
> > +
> >  /**
> >   * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
> >   * per-physical-core cpumask. Can be used to determine if an entire physical
> > @@ -722,6 +819,36 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
> >  		return false;
> >  }
> >  
> > +/**
> > + * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
> > + * @cpus_allowed: Allowed cpumask
> > + * @node: target NUMA node
> > + * @flags: %SCX_PICK_IDLE_CPU_* flags
> > + *
> > + * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
> > + * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
> > + * was found.
> 
> validate_node() returns more errors.
> 
> > + *
> > + * If @node is NUMA_NO_NODE, the search is restricted to the current NUMA
> > + * node. Otherwise, the search starts from @node and proceeds to other
> > + * online NUMA nodes in order of increasing distance (unless
> > + * SCX_PICK_IDLE_NODE is specified, in which case the search is limited to
> > + * the target @node).
> 
> Can you reorder statements, like:
> 
> Restricted to current node if NUMA_NO_NODE.
> Restricted to @node if SCX_PICK_IDLE_NODE is specified
> Otherwise ...
> 
> What if NUMA_NO_NODE + SCX_PICK_IDLE_NODE? Seems to be OK, but looks
> redundant and non-intuitive. Why not if NUMA_NO_NODE provided, start
> from current node, but not restrict with it?

The more I think about NUMA_NO_NODE behavior, the more I'm convinved we
should just return -EBUSY (or a similar error). Implicitly assuming
NUMA_NO_NODE == current node seems a bit confusing in some cases.

Moreover, BPF already has the bpf_get_numa_node_id() helper, so there's
no reason to introduce this NUMA_NO_NODE == current node assumption.

> 
> > + *
> > + * Unavailable if ops.update_idle() is implemented and
> > + * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
> > + * not set.
> > + */
> > +__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
> > +					   int node, u64 flags)
> > +{
> > +	node = validate_node(node);
> 
> Hold on! This validate_node() replaces NO_NODE with current node but
> doesn't touch flags. It means that scx_pick_idle_cpu() will never see
> NO_NODE, and will not be able to restrict to current node. The comment
> above is incorrect, right?

Yes, the comment is incorrect, the logic here was to simply replace
NUMA_NO_NODE with current node, the restriction is only determined by
SCX_PICK_IDLE_NODE.

However, as mentioned above, I think we should just get rid of this
NO_NODE == current node assumption, this is yet another place where it adds
unnecessary complexity and it makes the code harder to follow.

Thanks,
-Andrea

