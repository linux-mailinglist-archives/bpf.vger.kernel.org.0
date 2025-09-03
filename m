Return-Path: <bpf+bounces-67307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 194CDB4248F
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17462189FFA8
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB053148BF;
	Wed,  3 Sep 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XFlxBqiZ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829531352A;
	Wed,  3 Sep 2025 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912262; cv=fail; b=FEjfvELHwlqFOdIbnf2qI510pcBJ2KQUM+dKzhJ/KNjQ3a2dq5fXRIli9VqrRVqK9t4KC0CL/yRI7885m7HrA62dz9459luFkHsJ3DuedupRVOJXQR9LkM1oOlLT1u/P+QxcqqEfanJ5wRKgPKZezbd20v35+knQPdzCtL81Les=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912262; c=relaxed/simple;
	bh=1vB02g2xjF6xqUD75ln4wJZM5sfUQKs0dwLhQCd/G80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=llD0jj5m/lDDE30P+nUMT9IZoHA7ISM2/NIk1Af46w5vWqYqMFd5MC2lEBWCxu9jYLXxEV6crtp85MR6m9x6xgcbJ1kesN9L7mbYDsnK91fY5fCjZUQQH7mARUhUrkxMFLAGBvEqjNkP073ktWrX1sxLgjd5KW43sg91MPdvQFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XFlxBqiZ; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpHtSV5dMKV9Y+4ar0D2pp6HktCwIg0OH0iJVjbrpg26I0/bWC0f62KMYJWfKCPptSRxgMGIq0NXmOyF8MJ0jTUuzF037k/UZHZcr9xK2wSUkftzjBpmiofqEcd9ZXiC9AdaMuO46j3z5R5xiXucvn4UDp00uPSt0Zjr0x74yL0KGRE9xQOxAWp7hXT6tGkLkWBNjh8RRjbek/w4pCwC9J5dEtxVBvbVQ3OjOMqVzlBBTRccis8TrHi11GfY8xC4k70MKF6UFJBeL59qI1oGbg3abeCEW/fbjzuMp3W26Er5a9jx+JxNWVmoOIITIaonzgp7Clfk4+67ZkLU4povyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8asg0t9dib+gl/la2MJdbPgXrEH5Bis2+8URG1OP9Ps=;
 b=jCFfgiF79tcZjN9Ha76pffIcC2siIlfE4e6MGBOQebwDFrm21mrSGZZpDbm5etlqmWA/gtKfkZlsC31/w0OVfegMAXugBWDd6PyKBkj3XmBFDfs+P+rLXyibO3qOiYIOPf5ig0B/GuLTxtw4CknbLOMfZxpX9olDVlswws6Tj17gxH30raVcyN0EFKgjnE1ESMXXgO5wZ6EVom/j70Owd0WBr5VRMeDAyUNkNppaqRlaJzy968GmQYzJxB84S3kaTgEdDsoIjF2hxpskcMfkI014Z77mo+IJAS30fqHxsRmIlqBXTZhAezM2ZV5LvHCHhsIEfw6gh4YAt3jpZ693JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8asg0t9dib+gl/la2MJdbPgXrEH5Bis2+8URG1OP9Ps=;
 b=XFlxBqiZhzeod2WRf4NI58fyf57LEIvIDU2yGwW/SWSd1kPJCqzxCwc0sehPAobGuvLSfEhtq5gesNWqyqFwnqne6kyFShFL7GUxvnyvxHCwOH1iE7sXKgQBdF26/1Fjfz6WSZ0FoDSIR33yDhlLSGFxf+USJnIjm0orIqItB4xZLiYOFcNZlWrFqvZm4mNrf9gIR25tXML2h6loG7UWyn0AJJk6osoSZI8JYR7tichwg6iqZGQ1WL40JjxiE3aEVj5TGztbs0FiKxRd+LtVTDeuM+8TiKHZChbpSOeB2bB5Z6Nyb8odsJ1Pdd6WUK6m1K7rIdvKGrrLWGLx/JHncA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 15:10:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 15:10:56 +0000
Date: Wed, 3 Sep 2025 17:10:53 +0200
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
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>
Subject: Re: [PATCH 05/16] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aLhafcdtmW6s-ydD@gpd4>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-6-arighi@nvidia.com>
 <aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: ZR2P278CA0018.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 8284dfa9-a6fc-494c-fc95-08ddeafc1549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nXnrAxGRocOtt/nVYHemdlebR1HRgJBK7XaYzq/3rX30C60TZWw139g8bdwf?=
 =?us-ascii?Q?Oht46kY2af+GcPkJ1O30eaHAOr4DEFVeJ92bAelChgr8uZOrERxMz5l5nyzt?=
 =?us-ascii?Q?Ic1vHFmK8SRcQbHMVAkbkEAtFIqESWxBjCQ2CvHTUQW4yePVz9OxMfaacbi3?=
 =?us-ascii?Q?R/SKGAf9jbdMK+ZC4d3gpuR7uu22ejOl+MskKgzR1wEpka64qmTxBAr+lPMu?=
 =?us-ascii?Q?QorGYjOcXnF5UoJaP00UjEhSTf8E5hnRU93TdWKri2I3G+uYVK+vHpcN5YUR?=
 =?us-ascii?Q?TXC11jt1Z/U//stz5eHP73+dICCPol9bNNwlNGqpxhxEi/ObcpwaBKkIo/yE?=
 =?us-ascii?Q?XwgL7srQ+lVbsJGQVf8zzcfmj5exT8FW/IAeXdrLbY/GEM+6lPqMEeiPDfL6?=
 =?us-ascii?Q?xEBm5iI52wA3K+rllN8Gpu1sCiB4tXjUAs3vzdPa+4/YOrKvNA6mQFvkRix2?=
 =?us-ascii?Q?2yICJeaf43p7/JvmBqsmGQ31m8Y2p8kDEn8IwPMCg5t6XCr6QRQdOyOM4DFV?=
 =?us-ascii?Q?p3AHdtPwrxx444TIXKjwdAmZpYFxMVx0tnWfhsiVPeNDyeyJGe4ndoq679op?=
 =?us-ascii?Q?EpVNJD437smTcsAWHAxehoRttWo7nAo9hgT4qYgpTgKYZ5UI+IGsdIXi3ISc?=
 =?us-ascii?Q?/rCbPjbp8NcpKrkL86yFahJoerD1p710vNzC6fc41BiMvpCaE4kZvUaeGnpz?=
 =?us-ascii?Q?rvygH2seXWTsUjwt5hn9EgIjnRSDGPn8OrLerMJtfXSef0caNWNZdt8ndA2J?=
 =?us-ascii?Q?ZFacZ5KxDIzmz8EjYF8LDfrWM6Hzlf+Mj/u5Bc/sW8RbqYPRfQDe9ZJ/N+/H?=
 =?us-ascii?Q?2KyJcxUlVXSD+SHOONiO/mS7dcyUDBAkFRwffwepzOMGVIz0bUwD7YQy1KoP?=
 =?us-ascii?Q?nzyT49/VH4C79q/La2hiAyiQcuUgBozJSQ7ZHkeSFLV0Y9Qb2Oj4aE8DH7eK?=
 =?us-ascii?Q?ANPuqGP6dG++77Tp8UEMH3qXx8Jk0ggqQUUPvNZA2ZPuFNzYcr8T0VzYk0UB?=
 =?us-ascii?Q?Uz3QDOcuNO+jYKJoeFBdjkcxgIzjl0UnK7f3msuXzkLFgdY/krB6LGu/0eP0?=
 =?us-ascii?Q?H2vwz2LsAp1Ei+X6ookc5J4eAvczsnemaPX/WInx+xZYSbODg/Msso8YlcTj?=
 =?us-ascii?Q?aRworUXlkbuwzUB43pyCEh9oYjjHqqv8XnGti0atSulEtw8qgLA9q+XlncG0?=
 =?us-ascii?Q?Y+VjhyGYBOU42n1I7u4z2sa2sJ+lEQXA2aTp4IFFcHcJe7nGfzMN+PjM02MY?=
 =?us-ascii?Q?Rb2Wx4x/AWkgfCl5YERXz4pNBbqv3T/QhJGSHY5qy0reKbQ43aITwPqWKa8W?=
 =?us-ascii?Q?aplZ8Wxmu1eRnHTSa3Oy1M+c+5N7D6kxJoafJPSsIqUX8Asogqo/ze8qK+6S?=
 =?us-ascii?Q?ABpM19Ky0eDOCJc4TwauqPObKpSevQ0Z6kSgaV19wtDIOZiaVv3JuMqbZK7J?=
 =?us-ascii?Q?BNRJSD3HJnU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UE/XbYZtSbkpplck17wHbi2gM3e6m0ZjB8BJcJPaLuDROlX2b2Aq0vBQLnJc?=
 =?us-ascii?Q?PELMtHeL6Sd/dd/xZx0Y/nizy/viz0JwDHk6gffMTbCO0vofGPS6ZlcX8VRQ?=
 =?us-ascii?Q?jpTuCtPXItS95xD1vt8/OM74l4/ghW+fqUFxQERvNCDYKskeGmYGF8I8Bmdn?=
 =?us-ascii?Q?l6Wc0hhY0Y06b0XXdSVQq4w9C+w2XLEbR58JeOwGi7I/YR2eYGj6Ad08RdTb?=
 =?us-ascii?Q?mB9sZTnIX2TVPYFc7aSMsAkPZlxX2dKZp/Xq2JBvDjy4YwwYHFCkcu1o023E?=
 =?us-ascii?Q?aVb/yoaONPh24+ocrLtyLLl5/v/UfCJpaQITYvjNVqgv5fyi5DfYm3IVf4/Q?=
 =?us-ascii?Q?n1gvaxm8xyGbhS/raXslSFjFU1BCdUD9747IGCEeVjrI3bKoxPO40VA5iUF+?=
 =?us-ascii?Q?dTc0UhErZa1oPxO3KOu8+SlspK7HzgSzeQGiIxCu9wEX9zv4j+JddNqbsvC+?=
 =?us-ascii?Q?gUPXj1BqLWJg+7EOBZtKpssXkar1JZViPu6P/SVy+8Uc24pAknHu3/mieC7A?=
 =?us-ascii?Q?2AI7jse4sVVHRqU2ApUrs9t2+mczv5oZXm5xEbHeRIeu3dYRViW8nf6jMKdQ?=
 =?us-ascii?Q?WNcsUszqGniNUvqHm4O4uMI8zr82ukxk3vENAfuSS5Kc3OAsBT/K3s7nSCXe?=
 =?us-ascii?Q?NALG6WBgWGyuth8CSqyaIJlqs7/yOv9agw00ouyhtuByl746c6x6TYuWthRg?=
 =?us-ascii?Q?fBfnrRQEUicM0KYC/CC/eSUKXWvh94RgnsUfnGaTV9Sr85IrmX2MJKnD8YMu?=
 =?us-ascii?Q?XhEQI6lDufz1jxhS7Fb5lZoZXfWoLfI/NxO7Gs+BVDX/gKY6d5atAwoQ82rj?=
 =?us-ascii?Q?G08hL0Orli2KpDDIQSafF+dovoh6BDHMDZGdUzjaJ7/wKQxglnjZ/bR6uARa?=
 =?us-ascii?Q?LX7B8AfS4ETR8aqwOScUkoouDW8gpEriz6RsWqQVdGrb4iWH9fbyNVT6MUcL?=
 =?us-ascii?Q?VdY16cDVDqyas79GMHAq6wJWNpa71z5WU5v7lT3gv5UkmQzvn9iDiBo1bGbj?=
 =?us-ascii?Q?YdAXYa4p696fodt2D3e6LdemMZqqSwjTTsilN0F9Rd5ZJAURsZmXBnqgGM9p?=
 =?us-ascii?Q?dfdx+WnxmosnNKxEPgcrmBX6WcirJhEoQzVBmkD6KvfcCsOYrVaYhVL4FIdm?=
 =?us-ascii?Q?65O+3bSBzSPzSFaraOUQQgqLn2u0Ts5RS3f4DcsbeUKpr2odAKSm5dEQjhBV?=
 =?us-ascii?Q?P15eXH1gRKukCJ7joowfUQ05WWrQJ2s9pjfe9A9Uh9+jHT1i8Ax4oVSrVehW?=
 =?us-ascii?Q?8e+6vwT7dO4/qDRxY2kQ0abxgx4evbR+4eunz4KtmaNY69DyYFkGygp+2T+v?=
 =?us-ascii?Q?IRRZzHUGgYMrJFJxiwNNV5ZMdi+eiPgoztYrFTklvj6eHZWeids/6tsPUoM7?=
 =?us-ascii?Q?d3rq6EObF8Lbt1H+QHjmejzJPKrCwsZkDJjWYW9DFDFaTgAgcbJ5v5Cs0cAq?=
 =?us-ascii?Q?wqvdIY3b5BewE/DU8bTZ7PckxudDE4TvcxHqGjn4WWCugu+DeKiTMCuM8IDq?=
 =?us-ascii?Q?qP0yB/My9OTPUR3oT7g7YooY7M+rCl3ak52Oqu8UZrAuWudcKd2KC3VyZ+f0?=
 =?us-ascii?Q?yL5UsOpG3sNS4f7SeU4CYqRFiH/Q1PANTceQfjht?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8284dfa9-a6fc-494c-fc95-08ddeafc1549
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:10:56.8070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0qmXBFjfCb/VPxM2AIHf8zIVBAgmd3Qa75pZF3X6QUt8veN2P2aRHgw9SdPPwBut3MzlEyCp94N9MjoFgcYlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462

On Wed, Sep 03, 2025 at 04:53:59PM +0200, Juri Lelli wrote:
> Hi,
> 
> On 03/09/25 11:33, Andrea Righi wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Hotplugged CPUs coming online do an enqueue but are not a part of any
> > root domain containing cpu_active() CPUs. So in this case, don't mess
> > with accounting and we can retry later. Without this patch, we see
> > crashes with sched_ext selftest's hotplug test due to divide by zero.
> > 
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  kernel/sched/deadline.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 3c478a1b2890d..753e50b1e86fc 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1689,7 +1689,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> >  	cpus = dl_bw_cpus(cpu);
> >  	cap = dl_bw_capacity(cpu);
> >  
> > -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> > +	/*
> > +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> > +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> > +	 * with accounting and we can retry later.
> > +	 */
> > +	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
> >  		return -EBUSY;
> >  
> >  	if (init) {
> 
> Yuri is proposing to ignore dl-servers bandwidth contribution from
> admission control (as they essentially operate on the remaining
> bandwidth portion not available to RT/DEADLINE tasks):
> 
> https://lore.kernel.org/lkml/20250903114448.664452-1-yurand2000@gmail.com/
> 
> His patch should make this patch not required. Would you be able and
> willing to test this assumption?

I'll run some tests with Yuri's patch applied and dropping this one (and we
may also need to drop "[PATCH 10/16] sched/deadline: Account ext server
bandwidth").

Thanks,
-Andrea

