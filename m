Return-Path: <bpf+bounces-50779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A90A2C79B
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 16:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B38188AD24
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C701EB1A7;
	Fri,  7 Feb 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D76Dx9t7"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129C1EB1BC;
	Fri,  7 Feb 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738943060; cv=fail; b=rsyretB1oPqOcKbZgxNM7Si7z2zqyUh/teif3tNrfCeHU5eIs6Rn0Jml3ZCWJCBTLhuiriy6ljS/rmxgqmyaLGhhbe+D4cOYVaXLRIIE/wCVIu6SEhqKvuoK+ULnWieQEpe4XJXZtKaH1K0zIcxlY/J/RyIAG2K27zXiv8G26Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738943060; c=relaxed/simple;
	bh=Q8jDRl5nJhSBAWhNjjQxydqMYyF63gRSr2twXRHVGiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J7KB5MX3znN+5dODWtVSWUuYl6Ez9gPOxD22YQFiJRwQMuEjTZAQp/ul2IIaE1a6Mi7fy4urfak5/bQqYGXrhbM+bBoLPcfGNRviaie7OQsfL7w1AuQHrij9ecC8Iv37ZAz7BC9g82qGpckCceVOOzMP8YPXu5OjQyLiyU6/r4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D76Dx9t7; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVNMk1y/XwNI2XcLNrhV30zwl9Mi/Rg4AWMQb7dkb6+C5wPXFPugKC1zMjN+tz3R8ioSakDXsRf2mJLbY6b2d78doD25Sjbi/psqhqm9zCLzSR7HWF0SyGveoiyJhXTAWqgy0U5FRjpBsWV0iGZKKsdRsh5NDQpIuEGdUoVmCZHO7HMaa8rx030VBXOeBBuXRT7zi+FzLCy27MeviP6SThjl0lH5xwE9XzetGBLnq3K+JbkifCBtGgFTGva/Lqbks+DxGD/vR90Tbp+0jCZKJOOxSpPsyYMR9nBpiAlYWICXdjhfc9EULkeHsr52BwDwo43JB+s+ifmf+zhp6YaXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4UjQRSYQSZjtNR07ZXuR2aAZLU/PbSyZRRJevlvozs=;
 b=g+uhKLn8KFDWMBFnFnLVrBFCx6KRzY3gr1ITJL8dsEOpvhU46v3YiPGh6Gnh8gdkk5+pkVH1eyBi9DNalfAC6WzyYWn3Oz1b0djULyfjjQ/hGrrAmxHFyvnzjbnOok/ozMvbqKjrrrzS6QtgqiRzzn/CGlS+ag0z0Cr2bjXBEgkiNe7lqTd90sATJvBj3zhMDo5x4rJfnuk9KdrUW0/7EbaWmRtvYFRHDSfsj70ifsD59/6JepfUzDPdw3cOwXAX+ApIXlue1PwGx6gFAKPFwRysy1W+Nv1ROy6Bab7GWJPmQPMqTsUcSigz35mYMJhdnuPard9ryt1VugXw0apcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4UjQRSYQSZjtNR07ZXuR2aAZLU/PbSyZRRJevlvozs=;
 b=D76Dx9t7jU7oNSKTYhKal474vqk+WnxVZ3+wto9sQP8NxkYEIhZ3c0ZyQPTXLUFZggBUy8FwSoMWxmlzd0dGi34/5WLZ6e864+mrQZAV4urfIN3uJR0wgFzJBodStqVTWRSNK9ihP38Bah2Asz5ivRbf4+w6GlC1LRImF9f/tOOE3mtWH/5hihKVmlwzvTVKH2BgOfvyFnkuqkg2vIoSpZlPRlB1e3WxLyjrr40/DHbl6PMWUcE+/f89t8kpXrvtQJN5JzscRawRq62BEf+2r22ekPFHdOUcyB3QvQA6pE0EKP3ots1uymwwVleZYB2aj3JgGKKFFgFSdZFPHVIYBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 15:44:12 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 15:44:12 +0000
Date: Fri, 7 Feb 2025 16:44:07 +0100
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
Subject: Re: [PATCH 1/5] sched/topology: Introduce for_each_numa_node()
 iterator
Message-ID: <Z6YqRw_DJ-Czply8@gpd3>
References: <20250206202109.384179-1-arighi@nvidia.com>
 <20250206202109.384179-2-arighi@nvidia.com>
 <Z6WEllH4yvzkWCYG@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6WEllH4yvzkWCYG@thinkpad>
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: f57a1ba3-5f44-4553-09d4-08dd478e44c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l6P62/D4XOBa4pjQ36Wd772m5VONpNfEPVIqfIggMlgPi94EgbbEyjjjj50v?=
 =?us-ascii?Q?9PqnRoggTXtQ6r8lfYaaNTcT88OSv52cGzkZxXINySP0hLFz/rK5+c5DDA8Z?=
 =?us-ascii?Q?NDX1r8w+/q0eg+rL3UAHPFJ7DtfgSsDqaeWzOtWiajEqOH1uWec+iQg1emHN?=
 =?us-ascii?Q?oVYy7Gh0PQUzekAYcBRGb8CSjiJfS6Rl78ZFMxY7d+e5DSUZpGkvs9bPM5GG?=
 =?us-ascii?Q?cFTL1SzZmBI5ZIqJWPKDOPhnIRTw1GIvUs7jKcU/R30pxyP1DEfoPvO3Sqin?=
 =?us-ascii?Q?ecawZ/mdoqjv4vF+fiCCpWiNKMfwzTEPgSIzDazQjhYOS39hySO7ckoNI7Ae?=
 =?us-ascii?Q?cXIgJwqUYbTOWI1dDg3by6bMxSfC7089PqFGxN+PBt2/MDwVoxDQsRKW78Uk?=
 =?us-ascii?Q?pteMb6p5ak4Rw3PKiZ53QN4YfqK11cDPik6yRwpzzn5D+po0O8tPBThvpd0T?=
 =?us-ascii?Q?Bd0ME3TgmY7BPt0MNXYsz7p/upPGuoSdUzv7GFeyawHygqPQj2bhrQsw+fxv?=
 =?us-ascii?Q?wOmK1Wpy4zLKRdFPZ667flASZR6vYTiRvfBQL3gnBPUtMxWHBGnMl95UjUcm?=
 =?us-ascii?Q?LLYeQCamDx9LxNspn/XVH9v3zlOTWy1JUQlxUZ2HACZaz3j2ddJ63vZMOx60?=
 =?us-ascii?Q?fPjS97CVKU2DHZOn9cMWBtY9V7mi3K//vupH5yaP1II77B0dYcyBoU8tBq9q?=
 =?us-ascii?Q?hfeIWQQEaUDuB8yOAGFYNltNM/66GoGZ3jk15zcYLxS6KPx35FKgUNTzrX09?=
 =?us-ascii?Q?VkpTw0zGOX96WlfeTJnsVIm2hB4+2ShuAC+L7TAvboOgxsUv3qBpBRcbLTNh?=
 =?us-ascii?Q?cbOsys40IMrhe80ybreihdyGl4uTVxUA0pKIR6DUMNe/6ucO6dwSIfsWy3bT?=
 =?us-ascii?Q?iEwcLX4ApJEOSeCVRagi3UCV49DQFOGjT3T8/eb3ZfW7cnOA5T29EDvSeIBT?=
 =?us-ascii?Q?FK7KRHWRqeemJ1uqGtskHuYhn4u4Yshv3vgt/nqQ/E3/Lk2wTANC6w8gF3gW?=
 =?us-ascii?Q?7ygrD5yTFSktNQQtxffvESLCEwQtQakXPeo9qsHB/cX1NnHZji3+qequlMiU?=
 =?us-ascii?Q?7rP6a6L0LIcDZCwE7xvHc2qnZ9z4bFPV88/72dozW4FoHm7bJsDigBtiR/ZG?=
 =?us-ascii?Q?9YJkd3YDunY1DoyB2qEv++ZOXDu5V7xzzPNKH+gSHTVm0UMXkyvlLunvQCWB?=
 =?us-ascii?Q?YVVikjlq/FQhMpTAMO1D9AqIsu2u8Y3YImbS6pxSM86d13gKYNIvUTMcFfZ8?=
 =?us-ascii?Q?9ySzXGcfzzKS6f3QRQRCE5FvqQIVO9oNK5at/hbyYOjnAqjrqYYL09w56Aut?=
 =?us-ascii?Q?eLgnpoa5P6DRlo3WozkqGJQfJ9JhceK8yKzFUXbqc6fAQFMt8PqxpS2KizYn?=
 =?us-ascii?Q?yqDabk+pTpQnSR9XnjnRh3e2D/4R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vTFhhDsq0eUPM13cJ73VeAWYefuOZ44PaCclzOCOPE+cI/FvQXF8DdRD22C9?=
 =?us-ascii?Q?8iYJDHCM0Y53VBdZhip9Sw1pLLbTIsiEssSrexCttKpWpivPfvpk+EIWaj4y?=
 =?us-ascii?Q?Bn0C3/4HZbY4U72UmE55Bd1buVpSBMN8KALWiYJzKsHSFKiGZ2Kzl/PYlKOz?=
 =?us-ascii?Q?PPNeOZQRSzVmiOdMytS5u+iiEK35OtpM6IZL2VIBVekTxVqPdXhkoPmZ773/?=
 =?us-ascii?Q?7v0rn+LBckQHikUfBnYBEta2hld14wodb5wjywp1Ef8caZ64atGRErmPn3N7?=
 =?us-ascii?Q?/WKZJWh3EmwDzEX0YPFcCeWuktb8NJJVsSO5qBkPWfC+Uzd9hYOftjqAvPod?=
 =?us-ascii?Q?0fkCK5Hkz9Z6sbDGEyc69RvRIgYXUV06nQkXdDjxtFg7qZ9GMhDQzmJ91gM3?=
 =?us-ascii?Q?IVPTxWlfNt4Pzl6B1JE7vXrhJonb9VA2PYLPfa5XYsyMXg0ofCw+hVnla8Vp?=
 =?us-ascii?Q?IPBPpGAwyn/9vb3HnnhzlLCNcYa00bj948OTC348UAF+2TsDS2az+aFMbgLe?=
 =?us-ascii?Q?3DCi38vrDq3itUtEBXEsKh6erEB8dcaEwPxu+pQudgUK0ySWhfcB+pvcjthF?=
 =?us-ascii?Q?jq+byHxlVx+ak7x1HFCtZmdqPip2WzX9YQqpNEyBHynVyH/cVtn5VZgZwtLP?=
 =?us-ascii?Q?C4lTHaG89GPwhlzAcGnqO1ArIwCMBM6KLM4UOSy5l88JwrAhmVqT88Yj3TIz?=
 =?us-ascii?Q?ssDz7nJzgXSMuGmCvO+07nH6qnL8LO6w2xjzISxqHNqjli8PNO14qNmCtex6?=
 =?us-ascii?Q?VlUHA5filGjIlIPVuYr/gcpzIDOQ7j7kIu3epJ17M6Cwmn8hDYpo9KL+nnz7?=
 =?us-ascii?Q?23IfstkpOerkHv7XPPEEAkWw/F7mmXm/IwgAsW0h0649GPeV+lqu9gXkZbdG?=
 =?us-ascii?Q?uG/cOV8TieZx57gYGQXJhklSocOOcwFejf4w2GaGyM2G0/dYq25QFcqBGi0r?=
 =?us-ascii?Q?XHFGzmCxUiqedjLjCVEeNMpDkCZUhEQfXa4F/ZgVWXDFK25+PFsphtVkqlWR?=
 =?us-ascii?Q?MvLcjG+sNZ15Z+12StZDxulBvaSupw+drgoorbNfXRTsBepXxmk9mrdKSbg0?=
 =?us-ascii?Q?qTusTn+nVvf0UrHhjWv+YrBB1qyK8AHD9XQhrHMSJWEsFO8i4ZQsaxVMWuYQ?=
 =?us-ascii?Q?yjEXSzraxret2v3YUhrlIm1xKNEUF9BlWOrNGxZ5qIEPQEtg7W/+lM11vVTL?=
 =?us-ascii?Q?JxUn+aoz8x7GiB/qX+kPj3Gm0Pfh9KoxPByTAYOjBl34dVt+ikiAMvIb+t/O?=
 =?us-ascii?Q?kyh5z74a65Uk07Trxlp4q6B9KGqyTMTlfbfDNaFGYpoXgujkd3EQuh6S5Gpf?=
 =?us-ascii?Q?PU7IiaOu8f/tybuHkICKZR/zcXkNKFg2v9JtC5GT5ikgzmuFCmhiHjl3Keyt?=
 =?us-ascii?Q?ZhvvfIZjlXDEWJE4mObGoRwGjwL8w3jG7ThaFbstQAF5DwmlONjp2y9HqQyP?=
 =?us-ascii?Q?DnsaIAtW9PWmGRYs0eBWKBVcXQIVgfPeADB8pdicu31bbubi/xj4fVgmNk1z?=
 =?us-ascii?Q?ZqYMgM37O588NXHzREGEiTi4NtVnsCuIZW+4OcS/Rfo+FRIpQK8k773hV3MO?=
 =?us-ascii?Q?ZS/nEpoT5mVgdTh2u10dtNANfPT8vqZyw7NQJvTK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57a1ba3-5f44-4553-09d4-08dd478e44c2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:44:12.3699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUW/jDXw4x6BiKDfbuIsNbUdMzLTtrT5qoRIwRd9YKpPD/B7jrCxhzTatVoPb+cfP4OSZiD22mWVvTxWLw06Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911

Hi Yury,

On Thu, Feb 06, 2025 at 10:57:19PM -0500, Yury Norov wrote:
> On Thu, Feb 06, 2025 at 09:15:31PM +0100, Andrea Righi wrote:
...
> > @@ -261,6 +267,29 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
> >  }
> >  #endif	/* CONFIG_NUMA */
> >  
> > +/**
> > + * for_each_numa_node - iterate over NUMA nodes at increasing hop distances
> > + *                      from a given starting node.
> > + * @node: the iteration variable, representing the current NUMA node.
> > + * @start: the NUMA node to start the iteration from.
> > + * @visited: a nodemask_t to track the visited nodes.
> 
> nit: s/nodemask_t/nodemask

The type is actually nodemask_t, do you think it's better to mention
nodemask instead?

> 
> > + * @state: state of NUMA nodes to iterate.
> > + *
> > + * This macro iterates over NUMA nodes in increasing distance from
> > + * @start_node and yields MAX_NUMNODES when all the nodes have been
> > + * visited.
> > + *
> > + * The difference between for_each_node() and for_each_numa_node() is that
> > + * the former allows to iterate over nodes in no particular order, whereas
> > + * the latter iterates over nodes in increasing order of distance.
> 
> for_each_node iterates them in numerical order. 

Oh yes, much better. :)

> 
> > + *
> > + * Requires rcu_lock to be held.
> > + */
> 
> Please mention complexity here, which is O(N^2). 

Ok. Will also add a comment to describe why it's O(N^2).

> 
> > +#define for_each_numa_node(node, start, visited, state)				\
> > +	for (node = start;							\
> > +	     node != MAX_NUMNODES;						\
> > +	     node = sched_numa_node(&(visited), start, state))
> 
> Please braces around parameters.

Ok.

> 
> 'node < MAX_NUMNODES' is better. It will cost you nothing but will give
> some guarantee that if user passes broken start value, we don't call
> sched_numa_node().

Good point.

> 
> What about:
>         start = -EINVAL;
>         foe_each_numa_node(node, start, visited, N_ONLINE)
>                 do_something(node);
> 
> Whatever garbage user puts in 'start', at the very first iteration,
> do_something() will be executed against it. Offline node, -EINVAL or
> NUMA_NO_NODE are the examples.

So, my idea was actually to use start == NUMA_NO_NODE for all the cases
where the starting node doesn't matter, for example when calling
scx_bpf_pick_idle_cpu(), that doesn't have a prev_cpu context.

Should we implicitly fallback to for_each_node() when
start == NUMA_NO_NODE? And if it's complete garbage maybe just break and
never execute do_something(node)?

> 
> > +
> >  /**
> >   * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
> >   *                          from a given node.
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index da33ec9e94ab2..e1d0a33415fb5 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2183,6 +2183,48 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
> >  }
> >  EXPORT_SYMBOL_GPL(sched_numa_find_nth_cpu);
> >  
> > +/**
> > + * sched_numa_node - Find the NUMA node at the closest distance from
> > + *		     node @start.
> > + *
> > + * @visited: a pointer to a nodemask_t representing the visited nodes.
> > + * @start: the node to start the search from.
> 
> Maybe just 'node' The 'start' is only meaningful in the caller. Here
> we don't start, we just look for a node that is the most nearest to a
> given one.

Ok.

> 
> What if NOMA_NO_NODE is passed?

We could return the first non-visited node in numerical order. And still
fallback to for_each_node() from for_each_numa_node() when
start == NUMA_NO_NODE.

> 
> > + * @state: the node state to filter nodes by.
> > + *
> > + * This function iterates over all nodes in the given state and calculates
> > + * the distance to the starting node. It returns the node that is the
> > + * closest in terms of distance that has not already been considered (not
> > + * set in @visited and not the starting node). If the node is found, it is
> > + * marked as visited in the @visited node mask.
> > + *
> > + * Returns the node ID closest in terms of hop distance from the @start
> > + * node, or MAX_NUMNODES if no node is found (or all nodes have been
> > + * visited).
> > + */
> > +int sched_numa_node(nodemask_t *visited, int start, unsigned int state)
> 
> The name is somewhat confusing. Sched_numa_node what? If you're looking
> for a closest node, call your function find_closest_node().
> 
> We already have numa_nearest_node(). The difference between this one
> and what you're implementing here is that you add an additional mask.
> So, I'd suggest something like
> 
>  int numa_nearest_node_andnot(int node, unsigned int state, nodemask_t *mask)
> 
> Also, there's about scheduler her, so I'd suggest to place it next to
> numa_nearest_node() in mm/mempolicy.c.

Makes sense, and I agree that mm/mempolicy.c is a better place for this.

> 
> > +{
> > +	int dist, n, min_node, min_dist;
> > +
> > +	min_node = MAX_NUMNODES;
> > +	min_dist = INT_MAX;
> > +
> > +	/* Find the nearest unvisted node */
> 
> If you name it properly, you don't need to explain your intentions in
> the code. Also, at this level of abstraction, the 'visited' name may
> be too specific. Let's refer to it as just a mask containing nodes
> that user wants to skip for whatever reason. 

Ok.

> 
> 
> > +	for_each_node_state(n, state) {
> > +		if (n == start || node_isset(n, *visited))
> > +			continue;
> 
> Nah.
> 
> 1. Skipping start node is wrong. The very first call should return
> 'start' exactly. Then it will be masked out, so the traversing will
> move forward. 
> 2. This should be for_each_node_state_andnot(n, state, mask).
> 
> This way you'll be able to drop the above condition entirely.

Yeah, I agree, I'll revisit this, also considering the comments above.

> 
> > +		dist = node_distance(start, n);
> > +		if (dist < min_dist) {
> > +			min_dist = dist;
> > +			min_node = n;
> > +		}
> > +	}
> > +	if (min_node != MAX_NUMNODES)
> > +		node_set(min_node, *visited);
> 
> Is it possible to set the 'visited' bit in caller code? This way we'll
> make the function pure, like other bitmap search functions.
> 
> Would something like this work? 
> 
> int numa_nearest_node_andnot(int node, unsigned int state, const nodemask_t *mask);
> #define for_each_numa_node(node, visited, state)			                      \
> 	for (int start = (node), n = numa_nearest_node_andnot(start, (state), &(visited));    \
> 	     n < MAX_NUMNODES;					                      \
>              node_set(n, (visited)), n = numa_nearest_node_andnot(start, (state), &(visited)))
> 
> One other option to think about is that we can introduce numa_nearest_nodemask()
> and use it like this
> 
>   nodemask_t nodes;
> 
>   nodes_complement(nodes, node_states[N_ONLINE];
>   for_each_numa_node(node, unvisited)
>         do_something();
> 
> Where:
> 
> int numa_nearest_nodemask(int node, const nodemask_t *mask);
> #define for_each_numa_node(node, unvisited)			                      \
> 	for (int start = (node), n = numa_nearest_nodemask(start, &(unvisited));    \
> 	     n < MAX_NUMNODES;					                      \
>              node_clear(n, (visited)), n = numa_nearest_nodemask(start, &(visited)))

I like the numa_nearest_nodemask() idea, I'll do some experiemnts with it.

Thanks!
-Andrea

