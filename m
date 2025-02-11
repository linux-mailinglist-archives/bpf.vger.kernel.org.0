Return-Path: <bpf+bounces-51114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2896A304B1
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 08:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E706188AC03
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 07:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4F61EE01A;
	Tue, 11 Feb 2025 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hJ8TY2yE"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB81E3DF7;
	Tue, 11 Feb 2025 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739259710; cv=fail; b=S/xPKt4UPwcEVFznWbe6j8LQ5HHMAL28IvqXnYzs9qGzqYVgz6snOwCqOtNLlAexTWntNmGsjtwo23iY1nsatN6AOrbFYI66bdcS2ntZxkvEvFkxKsIsH8+sJzKloALV6A2UcCgEn+1O3o+0w81uDzzcA0s7bKlmmyK6mPK8u2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739259710; c=relaxed/simple;
	bh=0lVT7UOdsYGfvvzNc9JUdPG5VUfrbPJ4RYsfakbDGnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rVcMgDzlX9Ewu6ip/l1+Lps7YsBGcPMCzFfr+e5AIM7qzFIiM6DlRWWHpVvJVo9NRmfwJ1x+JPrzCFco5i5oEPUh8SAmOSH9/E0FkVOC0Aw0tdrNVZgFFfB2HLsLHAzArthSgFydknaTgibOUPDNKn+cgU4ZvZXQ9sC05l9NC4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hJ8TY2yE; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dkysp7Z9G+6flpj3ss3VSDSETfWXfWrimG53WyaKdh8vUJBrVKcnbmsOo3Q2Tno8hVuk1rno2uCh+J6cEPQEIdEP6jRm/BS/lUPal97LNR17MjCuYDgTtlH/sOa5G+ekBIdc+T4voX0kHBRHLu7FzENIFwKpMe4jQUVEJ3j1Hsbyvm+kAqQCy1xFMbEJhHJGOJ7Glg5223X/dYKM2PkWo47bTaWlC89RB2Y/+Yl387myK4Mz3fsCNXw7Mxvko3yZUIHKmTeMMkkZyhhAp97pIyrfFaJPEhGnIgn78izot2ZExDMjZovcTV5+TpfbRkqR/3zuhLQ1HDsROy/jAvXVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56mhihjLOQWWgvktdaElcIvW+rv1OhZZSjzaiTonlaw=;
 b=p1XqoO55rgswt+FQslc0Ljy1MhSJroOKWOEut5ok/ex1i68gMHR0y/S2LHKBX/J/PRKDJY/J0ExdTzL0n76YGnRnpMM2YMtSo73BZkhE9kchh0pqM6nKUssuIUH5wh9xpysZRzWglE0INioM5ljy9ef/x6GQuoZMaySuBunLDNljNFl1CKpkQgz8T4jQAAVbWwBhRWQxSOSHD9FBn5Tzds5Iw2qCXvnUJat7pl1GikR0TOpIZUunNeuuT553TaarG9nuPVKNDM7YCyp4kzo17kqk3w2V0XWPibRsatJUB/43TAXOFR08UldXIm/ApP85hQag/Cm/p7JknbjGF1T7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56mhihjLOQWWgvktdaElcIvW+rv1OhZZSjzaiTonlaw=;
 b=hJ8TY2yENRljmA98W2oshgaWr1N+3z91xKLg4inBBnSTdKb9In94R6AOWFqLxhY8oRG71UzwVO1+lnu+mo+vESMFQCUrJNk0EoIViNzh+pP5ZLB16ODGWwe2ETxJ2GP/Hpu8bzngXf3XZjsl392/siPOIh32vfWCIrL/cAbm0rzDkrzDpy6e+y9/pxiWEfx2Jj7o0siJtpItvYDYwKsRj86J9lzrKPHElJ2PK4WT1xbQ/rO84T3hBJeqf+56+uvPZZVfwCvY+o1oPsB5c8fwc6oG7oSuRstDOUMw1eYxOlpYedhasV2ZAnoSnsHXyjbjP9eREVz1K5xa+Yh0d5Ip+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 07:41:45 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 07:41:45 +0000
Date: Tue, 11 Feb 2025 08:41:41 +0100
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
Message-ID: <Z6r_NZui9GibrQHY@gpd3>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-6-arighi@nvidia.com>
 <Z6ju7vFK5TpJamn5@thinkpad>
 <Z6owBvYiArjXvIGC@thinkpad>
 <Z6r9H6JukZi19dQP@gpd3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6r9H6JukZi19dQP@gpd3>
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 161fd2ac-a91a-4219-56a4-08dd4a6f88e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VnHow1ACbV5V1iUA03ht3vPQ73B2PbfsKRqTfHXjCL1+EFEGpXOSZCnB3xAB?=
 =?us-ascii?Q?r/I7MWGq0BZ/7/2+LoS5Xsk+VECXCMxpZX153AwNlsHH79v9jDgJSbVp+ofo?=
 =?us-ascii?Q?v9DV8Yakzo2pWyCtl6J9pD3qb+tFQAVaNUQhtPP60mWVvREtcr0Rx6L9k5Yj?=
 =?us-ascii?Q?e6i+53lSjXyOlnmmPFFsr3qaUCj2hJC9Z+HI3cN9LWSGX73d8hBjRKmA6V6T?=
 =?us-ascii?Q?uoPeYnD2WAxNu+YL6103ieloltdpxxciReZ9ROylVonwY6hWsUgHv80ze8GV?=
 =?us-ascii?Q?yOIS9bl6FMQ34okS28TwlNY7FUNsvS6MZFk41f65vKgFjWtBPyCuouj11L2/?=
 =?us-ascii?Q?RnwRqgBVvGv2hWFx3Qh6qOCo29EDewavHdcBbQN+sk+ednODl8V4WhCjUOCr?=
 =?us-ascii?Q?fbk5OYYHDKVhGQJV62qaxj8dAtXPLepup32zvjaFLsS44FrfylUIOcqnovu1?=
 =?us-ascii?Q?OD7kx81DCh+RP9O3ONEXK2P67vSwcpQPVSVKOSOr/vpQx4/pCOC2xAc3tWb1?=
 =?us-ascii?Q?aMBI0emfWyEkl9mW1nQFVnSk4Pc30GxJNbW2MhlElDUHqKur8klp2vi4Xxst?=
 =?us-ascii?Q?t79koqL/cVbjJAGrOV/Zryy2uV9R7B4noy5e+R935A3B4ksBxjTVlhgyovwb?=
 =?us-ascii?Q?FlFGFZI6wGtsZU5wtqKf4irPrOeFkY14tHim+Klb0ZK4BDrc5zv19hnk0Ekb?=
 =?us-ascii?Q?Pp+dpL7DrPFJ9ZWrPLfcMvQ/I1jMohBoSKSMeYkha1Y0R7f1nKQt93rOeB2v?=
 =?us-ascii?Q?QXnKsUovqwGxWfRxGzueigP9pcn0d7kJfIDu5hzIqdYRQ0TkyVnsallN2o1q?=
 =?us-ascii?Q?7UJxUdd4f3sElNzYAWpO0HBhiGufYqynePgCq+ff2khJPsttqbVKwwCJ4+g9?=
 =?us-ascii?Q?LcliaphO66yiQzh0A/1mcLoPMBUaTtzOSWJmB+Umz5vzQpYEbtll6IDwTE2L?=
 =?us-ascii?Q?kIWHAJJWF8Fdk492YLup7tsQnwehXtHvao6QSsjRwrMVYWaesYoQdlRoSYeB?=
 =?us-ascii?Q?3t45rol77O/p/ASjVj3SBOF/7WohCCCd8NVIFWOwy5jfbQkkHn1fMTyD6wuZ?=
 =?us-ascii?Q?dEj5iAWLApfOoqmqDq8sc2eA5LyCxZuHwPPpE2ER5txNta/YMA6VMtM0NRdV?=
 =?us-ascii?Q?tc+IxSeyFXBndiHPb6XWc6RIFniBRdT/FrwXqc5CbEtpXHjiE59+oWHpXkt9?=
 =?us-ascii?Q?2klDG0q++Ems7jUZvBrBAlg1Z9h9ROf5w4JsQiwW3W3eAwaWO+JSuPVukDCz?=
 =?us-ascii?Q?1hbnofCk722LayEgWK+QQ3RMLI8dMY1HBla/wrkcXRp7XDqa4u+55Fg3GzTs?=
 =?us-ascii?Q?loVfdJKVGcnG2H/AiApe/g/TVt1ku0s6z7NSoDPqZ8X0pEj/AjVWS+A2lDm2?=
 =?us-ascii?Q?lh7plu3asjOVdby1W2b07ZZyoLFd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K6X/6JE+1ZFTd9razYXivcWNSBDYicoC/JyuL8F9JU5ckL0XNEIoq3KjOVqA?=
 =?us-ascii?Q?bwPyO4G5ZRqVJSpJOSOlydhl0KqKTHaKfYTCcxpyyaQWPMjJIbK9Ja5wNFjt?=
 =?us-ascii?Q?wVIDMbfFH7/W+eJki099mn/EULqhRTH9YbaUzM0qeHaBy10DDegH3BLIwBYn?=
 =?us-ascii?Q?aMv/aai0P6Gdu3M8F1n2E1B6XFJP5PJ0ZonwpStZT1ermEl9pHICyDjrVzG0?=
 =?us-ascii?Q?iPi3D1hAshhpkTPCZ5L95xYzjjoWz5RiLPOMT1XryHjLs1DInfNSyqXZDg+A?=
 =?us-ascii?Q?JbcP3PWN3V0dLj38YT0PUUF4r8eVayoFgA2o+WXd9ir6xbXwpNgLv9ts6ADB?=
 =?us-ascii?Q?xZiZ1WxoVUwsAD9qFoPo4TwQNznCol5Xj0A0eC6KVNpbFVx+HwUdbyqutR3B?=
 =?us-ascii?Q?3Xn264v+zzACGeqLu61G9MemdZ/oh2UH9/rw0WtHW/6ga5XjeAy6SkkV4ayV?=
 =?us-ascii?Q?9otjpyGesiC3LK41BdPzd6wWE36nilCW/TMnRk78I0gw5bIjk3U7+QVNtjWr?=
 =?us-ascii?Q?R8skgDlBGIN9WegIg2BcJPvHNV9kQ09ULmsP54RozBK1UBzOLxTS8bxvRyKl?=
 =?us-ascii?Q?a5aD/kKpxzMcDB7FjVjahoVm58J0/3wXO5W1mvIY+GHzFRLsg67Gt/lQM2ES?=
 =?us-ascii?Q?BWwQsurFKFtxqBy8+mkIlYt0nRurDoTv9LIjMxH5hGUOyVmPXeTMY8jwItGO?=
 =?us-ascii?Q?hYTA4Vh7ounAdF4Q38/o+No6NKnV7D6en1iRC7iUipuXzS42LHFiCNqh/yRG?=
 =?us-ascii?Q?WaA0oSWJGxxj0b42LeH7XfAH2OlePTsQel9d4iFSkwKVerC9fB7faTlgqY6E?=
 =?us-ascii?Q?6MAk9nm2byvtMIurcNIKzRVZeTlVOUORLr7aDfEENFW+IHNsphNrAD96bAok?=
 =?us-ascii?Q?kImvzjhJR9vM2dhxKOscf0j+wGmOnXQAxC56p8E4zAz2CUzA+R95NxlOFq2d?=
 =?us-ascii?Q?fQeUCII6LEVbjJ7aC752L5FlKzRPJP+2PjALj1WyhwpFvYjpvWSg14KSnoLX?=
 =?us-ascii?Q?Cx489PorVuUc3n2ZBQnGpbHfDwRLeEiGIiF4HwYTr43vNwOehjkH3HDtJdSt?=
 =?us-ascii?Q?hPgPwaYm0ChEZBld38tdySl7t9kjM12lpLPOysMSPqubyculpZMEGBHVJpY9?=
 =?us-ascii?Q?jo90nUqAL+WjgBBhPZvBFFPMADWn2XuhLdr5Kf9jKpTVzKacxuNPO3QBx0SH?=
 =?us-ascii?Q?AFlQmJhdSsbfJBivhnOaIM1tr2dc1aqZB9rHsWrpHCXvOY1cP+vSGZFx86yq?=
 =?us-ascii?Q?jYjEabLtVySFEsxl5r/IoGDCRyX4t5t+CvkRpNOafYHChsQC5EaqIFPAQVGF?=
 =?us-ascii?Q?TALy1VakHZUogxH7aWBk6cSKJYrQhauPh+m6oZcdbUid1HUyc/Ymd0RnoUwb?=
 =?us-ascii?Q?14KiqcttJlsCAUo5qVlUQoLUXd6dW1Yjm5BP588c22D2XN0ura8wTpMWYVLu?=
 =?us-ascii?Q?Zifh6R0JhabisiOnqm/mfI5y5GM9tGtSNZNhpcH5evDbwXSClxlE4oh3Ma39?=
 =?us-ascii?Q?4PxH8V2NAW8d/wfhFjhoQG/RBa972pmcY36BpA73z7YF0jF/mR8nYTCTGdsF?=
 =?us-ascii?Q?UUEvu9xlDPYq0WJH4p6WuOouPPGXCGeBMYTUFHDh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161fd2ac-a91a-4219-56a4-08dd4a6f88e6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 07:41:45.6066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp4Tg/uUYqiZxE/jZMaRj7YRLzKMdQqIrDCAFqzih5OVT/nDfWIFey4YgJyd3MxAgZyChLraBXbaxZ5sM1Mnaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870

On Tue, Feb 11, 2025 at 08:32:51AM +0100, Andrea Righi wrote:
> On Mon, Feb 10, 2025 at 11:57:42AM -0500, Yury Norov wrote:
> ...
> > > > +/*
> > > > + * Find the best idle CPU in the system, relative to @node.
> > > > + */
> > > > +s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> > > > +{
> > > > +	nodemask_t unvisited = NODE_MASK_ALL;
> > 
> > This should be a NODEMASK_ALLOC(). We don't want to eat up too much of the
> > stack, right?
> 
> Ok, and if I want to initialize unvisited to all online nodes, is there a
> better than doing:
> 
>   nodemask_clear(*unvisited);
>   nodemask_or(*unvisited, *unvisited, node_states[N_ONLINE]);
> 
> We don't have nodemask_copy() right?

Sorry, and with that I mean nodes_clear() / nodes_or() / nodes_copy().

-Andrea

