Return-Path: <bpf+bounces-51440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EFEA34AA1
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2183ABA5F
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0DA271278;
	Thu, 13 Feb 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dNqNK1VW"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BFD26983B;
	Thu, 13 Feb 2025 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463609; cv=fail; b=RwYgGNnEWs9RbYwURMim7+MLbpPrUh3AwdC2bGAQ7g7Eyu8rC1I/qpgWCMXBiRru4YqPa9MQckTWv1XYgWzV/MlvL0V+YWFwlLq8yB2d607uJXyKe93xaXdoRqKL7urLNxHdz4FuAGC05y+/ZnCqMSeS2ymhvo3bHsv9XhEtnNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463609; c=relaxed/simple;
	bh=4ictYMlziRCp6L8II/fXXpUdnkWHudBEG0c/Aw362jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NBfOr93rdzds2WuhG8ejMQL9jKd8GxcMJlfHPNkbh7hPIulkqQZWrPhMNxmgiRA/xMitSuc5LCTOG9yG5FtZxA6XkLCfczuh4kDn2eri10jQjt6sUu077xaRUZxLDwWx/hjVGYJX3hGuhrtbP0QDKYhgbtlPQQj14T9mYEky660=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dNqNK1VW; arc=fail smtp.client-ip=40.107.101.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wR0kKpx42ifTWa9paN7iZh7HG5WqVTTb1dgemR9THzGtrP+Nf5+jWfiN8ti562//1BIVvWR7pbytpdeUKQDnoLZOzqcZknBJEB5R+uFvVUAxeoPtIhc9XnabCNG8JAwyOTMF8UVj+aUX99YXsm84Z2YEXyTi9+HPADL2QHbZd032QMRt+32Vekf0/61Kgz16jz+vhIZMc8U8pJdko7AuqJm+7bsgSQwQ0xlUDqYx/2EFOghTlMBXL82J7Kgdqhy3PO5lNf76eBj22wkhpmzW476O6+SuVieUzAthe0Kt+01sHD8Jqm+QumonIVY225a44EsQnfiyvcv7s4CMmvgzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=091fYQ1YOhYq20dGze67J0ib65qrsRoNX2OsBHxNiOA=;
 b=MDDqq+kh2QRYiEAawn3UPbF7DuuKSdcMhJ6pbaXnOLhRxjl0d5SVbcjUjLrvg24L6x5gqpleh0ImfIzDXf+J9ROSrC6+x8DuqL46Pi7MgWKmL4qwPL+o99tRQOaO4NdHpx7BCPaZq5ix5neqnfzFfyFD7JF20Ojdd7n6//V2IEtDe/p2aEWfU+8GvUEeT8V87Tb/nY61d3h+wS555hhJR0nBEvlIyPSi7yAcuZzmUjV7YnhVJJsV16go2/zrwr8rIa1Khy699DLrfLr/Kwn5ryqRtWTC0Wa2i+0bgJty4wbFW7zktFaqLH7n1Jte9wiWWAVQc+4eF2EUV33VyM8fWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=091fYQ1YOhYq20dGze67J0ib65qrsRoNX2OsBHxNiOA=;
 b=dNqNK1VW79mjJ1RMAlCBJRCazJXoJQ7uB9GdvyFpuwKucGdF61yuVAvdu5x+iPWhqnnZzVnCxySAs0x2/2gYYV7RCOCUNHNONhhRNDGIP6zI1h0dgsbhGOw5DpyxzNbMrUfSSxatfSp6XwYwHfz3i7+Q2bUWAnFiJSLTKNtLdUE532cV2RBy75aAV5ghlpM90uIV9LOx6igm1Ri7pZk90VE/CBKBKNcOJXDdGbr2I4K+I6hXaq0RAiaVBpcEIvQ/cQpTOX7LSRHt9YlTaiWQsBxJrg511z/oeacyL5ynjSin9u94O3oXzFQqg8aexrE3GwjSO2ewHLXh7sarQ9PhrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 16:20:02 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 16:20:02 +0000
Date: Thu, 13 Feb 2025 17:19:58 +0100
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
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/numa: Introduce nearest_node_nodemask()
Message-ID: <Z64brsSMAR7cLPUU@gpd3>
References: <20250212165006.490130-1-arighi@nvidia.com>
 <20250212165006.490130-3-arighi@nvidia.com>
 <Z64WTLPaSxixbE2q@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z64WTLPaSxixbE2q@thinkpad>
X-ClientProxiedBy: FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::13) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a606c97-60f8-4f86-0fee-08dd4c4a44cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?72PdwnZUUPY2yN8w9k8Zq/zmGdjooGN0WX8O1mlHehiFyaUBrhu8mMh4URlD?=
 =?us-ascii?Q?BAGgTQwfpDBAS43dXGwGk1pJvu/0RS3hRnbPjYRI/ZeicUtRnCMuGSn7BPyn?=
 =?us-ascii?Q?RT3hz5ZHttGrDIDJRJJa6LPiwJglJvRWZC/pRXpxQfDlrU1UhKfkmKgiZCdM?=
 =?us-ascii?Q?32gGQLYrP0BNd67TFDeJ1bKmsvUplmvsuKadHpCBlSzZUro/5pJM5MRDqLzW?=
 =?us-ascii?Q?lGo/DYES1BXKc9/ezlC4c2oteCQ2IywzxhwGShVX3ubWC+WpeVhPZ3bZUn3u?=
 =?us-ascii?Q?IhlvTMdJfqycwjL45tfzUfvpY0r7DQ4zBJk+39vbIGDrhdarZQqIYrZhapgX?=
 =?us-ascii?Q?pW+TkaW/Ty6756xezzOonsHrjUUh8zZg6GTxlIi5W+x4U/5lqPoaKDCjyEoT?=
 =?us-ascii?Q?1Sz/VCNlNHVTXrROhrrqmAGwT4QWACJLXmcKiA298eqE+CgpF5to0W5o8S6m?=
 =?us-ascii?Q?/5606/X5oOXNzzAGXOaR3WhyDRuS0Oc8Vq4zf9xaq9+r61b8fXd1f1XEWyHG?=
 =?us-ascii?Q?7QOWteJ1hWYwQ3wz4HydLgqdWjKOSOj6ci0dPNBUfISOc/AvS1ybwU851lX8?=
 =?us-ascii?Q?2KGrDOTwbqxCVMQ0aFNZpSr7iUJ2Mv2m9eOheYXqgmf5f3uDperMWCXRLCKc?=
 =?us-ascii?Q?lbP3nbSN1l64njLif6ihb2F/WgSjStWaJIEE38fIld8iZyfJQi6ZhGca4NdI?=
 =?us-ascii?Q?w+NyT5UlAXpIgh3/z5/HrcrXVC5VsfGjJCunWUghtKCUP0Rwjdpf45VqxHX3?=
 =?us-ascii?Q?cpmHJO69bAdgvBl8OWZWF9npnwrdYy7oh44EOw1HbGgnmG8TZK1zi+/l5uIF?=
 =?us-ascii?Q?ap+i13qJyTkH9GMs8OOMsRZp6G3jNYtPGRtB5nhBED6gbT0Q0mblsquMskX1?=
 =?us-ascii?Q?sWpPx/o50xaAe5VDN5j+O6NMoWf4KLiNXZZ0mq98GY184A90EYdwo7D3UOrp?=
 =?us-ascii?Q?x8S27WaKVI+JxldnuMIFI1OTHfCUb9odVP+QlM/qer7LLzGRfsEoBr5/S5W2?=
 =?us-ascii?Q?iyMEhBMZvwTfiG24htC+ew9UuiLHUX/oDedDCC8gEjP0S6tejiEgIk/J2mdL?=
 =?us-ascii?Q?HCn5eioYY9PInM4acdsZFbR3D8+NrMIcGgOfzssttEuvu0dCXGDOaaBipa9L?=
 =?us-ascii?Q?P8ljkGiuysuDGXKgbuIBSrIedPTtiNls110G/HWpdCGL+nV0Duf0EqP0URLU?=
 =?us-ascii?Q?WXbYydBZpcLgz4aBKXUTdllYlb8oA6gBK4bVgv9Zzonk4gaMFO/5jkZqwbF2?=
 =?us-ascii?Q?/3XXS2FER2jPK71yZTP/5aNs/KJ2ZprojOY4u5mLDGFtpt+AT7LS3NpKHME7?=
 =?us-ascii?Q?dcAUnk9SKJ9HpAY7W02RGrWJELhyI38FDXDGUVnfmvJbro9kLVMDfO5FPOPY?=
 =?us-ascii?Q?xzk+t2YNddyOrPt3f4PVikkeL2QE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zf+Q/0IPGpTd5DfY5H1OCYX6sXau1hF5Jq1OWihc8qzzTMBKvqD1tlvC7qh+?=
 =?us-ascii?Q?UtsRJUwkIN897Gbm2PizM4+G/gQpRqlW1Xe20fUHFGeGi1UKvyEi2B5cqsM0?=
 =?us-ascii?Q?dCalKYl7OzWcjsMAS9CFcQ/clP65MM62KB3R/73lZzwpmFh0oUzCDHP4em0N?=
 =?us-ascii?Q?58YtkXd+eYyvoklZfnrld7FPSal4HVBaBUbahsasX9Neyx0i+XngpSzRh32t?=
 =?us-ascii?Q?ZTrDzBNVxG0YgxynV7Ppk7/dU1T19uAwvh70bhEl+gyFKbKdC1W32PeY13Cu?=
 =?us-ascii?Q?LOosvpkmbBAg+9N9FOT2ow0p/b4A3+LKOfMMVdAeWG/NCsA9zMs8h4HFo1fv?=
 =?us-ascii?Q?d44UrBqRfJKOLLCk4gnq+kgEsFfmajsToraxw96R/jrOD+lD3Na471DEELz1?=
 =?us-ascii?Q?YpaTTsKX/PRJKA6fKoQqJ3oMS0VII1IB7LOS5yiKuuuI2WrSUli6QDHUGBm2?=
 =?us-ascii?Q?jJnOjZ0f5KcwN0QKTX4FtAcba/COUmsRdVF1DseXIklBO+SyZEuSPEKYwv31?=
 =?us-ascii?Q?/919uol8GUso8f4/EpwLO0NwJ9QylfpndXTFO7qoGR3OOmKz7vsnZisossZw?=
 =?us-ascii?Q?uOOnesaQAKWd4SpRgkjiG0W7Gl6sWDCDfTVbCphE9z8IZn1Fqjn6vpeqOJkJ?=
 =?us-ascii?Q?o5O9cE4ggmc7OjgcpXxhJXAIdab6haQEHjRnkRedzxbiJ8aOdoA+6CS/5OSM?=
 =?us-ascii?Q?oz07Df4OUfLBYD1ya7PJiH1nzDgFVpw+5kAWt2KtGTPlFp8T/b7jsq/2CO8B?=
 =?us-ascii?Q?tNNGSKIKhalA2/on0kKQlla8+SLwd4FS1rH9eVWxBoTy+H9yqER3/QBrJ773?=
 =?us-ascii?Q?6w+PjlD8ZxZjWafTyIeP6QV4Jy4tVyvkbbpxJ9AdwN/nSd4OMA9+7ZVBAWTk?=
 =?us-ascii?Q?4DmbOlzD/VRmmNm3HgpluC+qLUlOqfafZ/aMn1qh2bfOXBnlL9h5i0cf6r6s?=
 =?us-ascii?Q?FyjEFl6OBdiJCP+g1c2nxq0CDWnFSKRCzO6w0quw2J9C3q0m03LfO2yYcsa8?=
 =?us-ascii?Q?DyAk5sNlwTa2iZuaVMW/RUqkBNuVyn1ptee4MsU9Brc1Fw2fKa25RuFY/joL?=
 =?us-ascii?Q?1lksHgmCIhAhgNA8htioAb/uK3gfpF5GCvo3qhRPYLpJMpsZIqaPYqyqED0y?=
 =?us-ascii?Q?O2gvCxk9TsYPeMKm1X3Kz55Ue9mMADx0LibfCNPuTB8P8m0HvL572uON/hJi?=
 =?us-ascii?Q?CIJzgF1L0H5xZD8Nv/cvN5rRvROUsdsyydDvZo/6EzFCuVP0oYqKshFQcQ0t?=
 =?us-ascii?Q?pZI/udhru+2eX+z0Rr7cfXwzDMLDLj8v0y/GnOBr2Wda+YYIPoKThyB1cCGq?=
 =?us-ascii?Q?TuLo6b+GSCG+xBj1iBTL0cJ+nM2OR0krFECC9xmfzVjXKg7Ptre5f4HsOyUf?=
 =?us-ascii?Q?C/7IKw1NJureSIa0pRP/WObcqYu1CWsnSeP3DOVtiOTgZ4pcqFBxH6PGJ528?=
 =?us-ascii?Q?A/ZHUELJz4Yv7fNXwmbA1ntT0shGYT84ccf6foDph/JRsUdVZF0SgEVFbOGB?=
 =?us-ascii?Q?mRWabPHk5X6hh3TRQSlgXWYkIrbewQrCcQSeij1RBOzd1iQC7g9Vr10ByJqU?=
 =?us-ascii?Q?Kxrj22R7qJmJT7ZnCmZ3mr4R+jqrTPRSnty5SEUi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a606c97-60f8-4f86-0fee-08dd4c4a44cc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:20:02.3352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jg39kh3kr0rdsnFBvZqnvNe78D4RLo7OSazZj8Eraz5vjNQHTxtpBy0MOR02ruEXrzYckocTW7jrKMYTkAbsLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058

On Thu, Feb 13, 2025 at 10:57:00AM -0500, Yury Norov wrote:
> On Wed, Feb 12, 2025 at 05:48:09PM +0100, Andrea Righi wrote:
> > Introduce the new helper nearest_node_nodemask() to find the closest
> > node in a specified nodemask from a given starting node.
> > 
> > Returns MAX_NUMNODES if no node is found.
> > 
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> 
> Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

Ok.

> 
> > ---
> >  include/linux/numa.h |  7 +++++++
> >  mm/mempolicy.c       | 32 ++++++++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> > 
> > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > index 31d8bf8a951a7..e6baaf6051bcf 100644
> > --- a/include/linux/numa.h
> > +++ b/include/linux/numa.h
> > @@ -31,6 +31,8 @@ void __init alloc_offline_node_data(int nid);
> >  /* Generic implementation available */
> >  int numa_nearest_node(int node, unsigned int state);
> >  
> > +int nearest_node_nodemask(int node, nodemask_t *mask);
> > +
> 
> See how you use it. It looks a bit inconsistent to the other functions:
> 
>   #define for_each_node_numadist(node, unvisited)                                \
>          for (int start = (node),                                                \
>               node = nearest_node_nodemask((start), &(unvisited));               \
>               node < MAX_NUMNODES;                                               \
>               node_clear(node, (unvisited)),                                     \
>               node = nearest_node_nodemask((start), &(unvisited)))
>   
> 
> I would suggest to make it aligned with the rest of the API:
> 
>   #define node_clear(node, dst) __node_clear((node), &(dst))
>   static __always_inline void __node_clear(int node, volatile nodemask_t *dstp)
>   {
>           clear_bit(node, dstp->bits);
>   }

Sorry Yury, can you elaborate more on this? What do you mean with
inconsistent, is it the volatile nodemask_t *?

> 
> >  #ifndef memory_add_physaddr_to_nid
> >  int memory_add_physaddr_to_nid(u64 start);
> >  #endif
> > @@ -47,6 +49,11 @@ static inline int numa_nearest_node(int node, unsigned int state)
> >  	return NUMA_NO_NODE;
> >  }
> >  
> > +static inline int nearest_node_nodemask(int node, nodemask_t *mask)
> > +{
> > +	return NUMA_NO_NODE;
> > +}
> > +
> >  static inline int memory_add_physaddr_to_nid(u64 start)
> >  {
> >  	return 0;
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 162407fbf2bc7..1e2acf187ea3a 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -196,6 +196,38 @@ int numa_nearest_node(int node, unsigned int state)
> >  }
> >  EXPORT_SYMBOL_GPL(numa_nearest_node);
> >  
> > +/**
> > + * nearest_node_nodemask - Find the node in @mask at the nearest distance
> > + *			   from @node.
> > + *
> > + * @node: the node to start the search from.
> > + * @mask: a pointer to a nodemask representing the allowed nodes.
> > + *
> > + * This function iterates over all nodes in the given state and calculates
> > + * the distance to the starting node.
> > + *
> > + * Returns the node ID in @mask that is the closest in terms of distance
> > + * from @node, or MAX_NUMNODES if no node is found.
> > + */
> > +int nearest_node_nodemask(int node, nodemask_t *mask)
> > +{
> > +	int dist, n, min_dist = INT_MAX, min_node = MAX_NUMNODES;
> > +
> > +	if (node == NUMA_NO_NODE)
> > +		return MAX_NUMNODES;
> 
> This makes it unclear: you make it legal to pass NUMA_NO_NODE, but
> your function returns something useless. I don't think it would help
> users in any reasonable scenario.
> 
> So, if you don't want user to call this with node == NUMA_NO_NODE,
> just describe it in comment on top of the function. Otherwise, please
> do something useful like 
> 
> 	if (node == NUMA_NO_NODE)
> 		node = current_node;
> 
> I would go with option 1. Notice, node_distance() doesn't bother to
> check against NUMA_NO_NODE.

Hm... is it? Looking at __node_distance(), it doesn't seem really safe to
pass a negative value (maybe I'm missing something?).

Anyway, I'd also prefer to go with option 1 and not implicitly assuming
NUMA_NO_NODE == current node (it feels that it might hide nasty bugs).

So, I can add a comment in the description to clarify that NUMA_NO_NODE is
forbidenx, but what is someone is passing it? Should we WARN_ON_ONCE() at
least?

> 
> > +	for_each_node_mask(n, *mask) {
> > +		dist = node_distance(node, n);
> > +		if (dist < min_dist) {
> > +			min_dist = dist;
> > +			min_node = n;
> > +		}
> > +	}
> > +
> > +	return min_node;
> > +}
> > +EXPORT_SYMBOL_GPL(nearest_node_nodemask);
> > +
> >  struct mempolicy *get_task_policy(struct task_struct *p)
> >  {
> >  	struct mempolicy *pol = p->mempolicy;
> > -- 
> > 2.48.1

Thanks,
-Andrea

