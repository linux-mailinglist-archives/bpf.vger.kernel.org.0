Return-Path: <bpf+bounces-50934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF4A2E671
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 09:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3ABD188AB16
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C111BEF71;
	Mon, 10 Feb 2025 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MxJU0LU+"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AAC1B85D6;
	Mon, 10 Feb 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176130; cv=fail; b=ZuLS4QRkTsFk/diwDM0Hb40LoQhVTp14LBA6lC93mF8l937c9lBeHct6cCgSUu/34WNfDiH+VIoKFFOzjnQmY4RZ/bUjlDr9cknrJ3lHIthuDhKwn1OvkWprL2kA/Dy4qLFZ0NL+kE/PPB6qGQ9ri353UuN068kRH4X7mEVJ62I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176130; c=relaxed/simple;
	bh=Mx88ICnsjwYYZNwyDFsQPJz4Dgu6b8x925lBWJFOXPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HHZAqBzWX0o/pI2fp8ubkfGTF3cr6f2T19Y+rjfWV0d1alboK/ZQvqYsIYhe7Nh6s+peFNZnw7t0SrXbt9jI8wJQQSWH3HQYLuf982o4HqqGEfzR/RQ8539RU0LK8zwMV/adf7+Q5C1Wu+9h+udX7aYWCucQ2MeExXP3JtaTlPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MxJU0LU+; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjAEdL6/Xu34EFlmv6NUGXK2PBJdXCnna1GDDAhQvEYDjVhQ4jc5BCrVJMbWyrKAccRACXLDcC7ImE1u5Ti5ikhVGMj8VicpcwDJTZLyKmS9m+nCXTIyhW4XMH9C9SAGaSJGAfqcrLB+jvNRzxt/y7a44gXGdP9D5cbc06RYLow8nua23gbmnp+nAKnBdiUg1v/IY59RqbH9j7ShiL+avgGxqQwoLxwv1k7W2vf5WuSPV7sQB5pXZQJZjx5wXOCjb5w5vPU2O08hPFth0TmjTx/2V21bcjTVnoGBFNeCJhXFfwhJECqjLLjMuisVj8bpNzDJ6tz7y+XF76M4UO0W9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwbDY8y+RO2tORbpHCLf+c5uFqf/7UGboXG2RAxBdE4=;
 b=y72QxRVuz+fuD1wKRu+oSCT+/ant2U1AzXjoA+ROlKcgDsAcG0p31ZnJfdS1YxrqFAZ4SSEt7sJ49/jGZU8B+MH8fOL9a6h892oZdeKTXzB1+Xv7MoyQZFOuKPO37cU0UZaE1gwSVCV8n7aqGfgLZ8ZEaNdypK1lWokf6WTnvDTjxijKoqFGtZM9cNczK65BtYw4mcTM6ZMbDfjJmG0shdE4tYR6ujP95Yzre1mumekXT1j/B4rymC3J6LBvvCNkcY1L7TvtJg7yqmcAAqmBc02bTTlrnd/O+UbdlNKWgLw2xkabcJQnenBX/LZra/DQj++wFhfnyB6NWv2Qn1xHSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwbDY8y+RO2tORbpHCLf+c5uFqf/7UGboXG2RAxBdE4=;
 b=MxJU0LU+yn5t9zhfAX9ndHNSlN65fkcEv1WyKPE7+jGkb7H9Pvp1DUbUEYachTvbxQ/7tNbXn/7D/QLjBghMQ+eMhOtUEfGTz14ybLFQMUE/ex4LM0h/ct5eH9nHFy9oiAyZS/DZLXGVB00b2ZZf8JatQWIzB6BVhXBO8+AicFIJDJ6bLb4PMU+4/DUxXResIwBKS6Q3uBaPpIscc5tqu7KM1J/5sTA5oixvolq5dk8c6vB2+podpiSeqRf1yBAyrreZd96gUSRj3G+JzniYe2TEtFGaJR/bVxLx/mY8ozb164MVvhwynclA1Kk1k0uo69rVnCOrqXvsc7WyP01oRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 08:28:45 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 08:28:45 +0000
Date: Mon, 10 Feb 2025 09:28:36 +0100
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
Subject: Re: [PATCH 1/6] mm/numa: Introduce numa_nearest_nodemask()
Message-ID: <Z6m4tEoiUBNBmIjV@gpd3>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-2-arighi@nvidia.com>
 <Z6joYmcjyT8eY32H@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6joYmcjyT8eY32H@thinkpad>
X-ClientProxiedBy: FR4P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: d44b1757-6560-4df5-ca62-08dd49aceedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I4zJXzkS53alhm8fVC+/8bRja5Uqr1VubYfOLE/b7QSI3c4kq/ke+/D2Sl8e?=
 =?us-ascii?Q?A/kZrwNocwhi5kLrKQBqailHchHDdJbA59kjI3z/m+rgvHoiHkh8q5Rzuqmv?=
 =?us-ascii?Q?wlEKjHktbBKmvr92+gDwoQjwEIPG4AsX1pS2rzF/Twl0ljxxfFG97EBuz7j0?=
 =?us-ascii?Q?2edR5CbLwLPmo8itvd5GUD8x7oydHBhenO/zx+nF7Ul0fJqbUhFTbu5ZnvDl?=
 =?us-ascii?Q?kItBn5SfU2gUqgDE272TeSEYRoGngRDA8RDZX7RNs9cIfAMMzdDV3u6TkkvZ?=
 =?us-ascii?Q?XDT2G/9w37IfQksmROtHnCj9mqVdFn1rbAfd6TG7mgz/DZ6pFReEO4cuUg/d?=
 =?us-ascii?Q?g56XhTG0HvEpKCqy8Htygw46gbTLVJsvTGmZjRBG5MC6G1jV6kZGfv/kAz6B?=
 =?us-ascii?Q?sO7mqaFyN9wBTBXhQKI/WCSCvgFubl7OObEM7JG3ClvhDu7keMb2OFrLKeOZ?=
 =?us-ascii?Q?bfEUD+Q2t/b2kjJzsqUr6wXK/hhb8gVXZMKeHCEiJRfW9YaVdsQZrQzOwJPI?=
 =?us-ascii?Q?lM/BHbF2Pz/sdFNzBaOzakLZT9t+fEVUPMjItocd1rptdHN2xkltovXCqICM?=
 =?us-ascii?Q?Bw9G7RmJdv51k7CEgE5aVTUCAsNDhfiHOEVao7iTivjrqPa9skN2k6pUPvva?=
 =?us-ascii?Q?OYWsV1B+xc8kNSivgitEvrZ2ANlZRa2tVkI8jY6ehSenRy2/t6ZnjCHHW1EY?=
 =?us-ascii?Q?MWp79b6d1+nVrfzy1zGJXG0HQu/fBiDQNVU8EYcyAXRj81UnLTHTnVkfO190?=
 =?us-ascii?Q?TtsVIVN1930qG8NnB/sPj7Dn9wtE9lz11v0szDlQGv3XQcU4M7z3n1GS7fjs?=
 =?us-ascii?Q?Wx+p1r7P9yAOteBwTXQbnPeQYu03LWQu3fy9qv8r0E89DwBHIu/VktANe0fj?=
 =?us-ascii?Q?7hJNnv5t/oJDAL6YrNQ+ntRDhw5p+HSHXDySVdYCk/L6HxkrtV+1a9O0jTJW?=
 =?us-ascii?Q?1WMpbn2zzCgQ1+wmNgEkCIsNcVElVEyRPpFsFVLvV0K4H1DPxb9aJY049GY0?=
 =?us-ascii?Q?o90yUaw08c8hhSlI4rp414CId/OifLqKPMECJOC8upgYuGHuaglfESivqxCr?=
 =?us-ascii?Q?P2kiX1r6Sp7pcjnmLZTWHkYZPyglVUhJVqqmXpd6AJzFQntlKXWcK1nN5U2A?=
 =?us-ascii?Q?ZdftisNAyiVEVkgROdvvrVoq2bOXFFusXs2XWU4RBAAJQwYCazzPSsy/QM9Z?=
 =?us-ascii?Q?Vv5fN2FWAu7a+O/b/IF6Amuc+eJWs0NosFIxSnM4G1idhAmlunr8lqWvTA9Z?=
 =?us-ascii?Q?QcIkHG/OB2XEG3Gnvk5dinsz4xO2r9UimjCe6JDoPe9tVoUsh2Vz6rdfHddX?=
 =?us-ascii?Q?l/gXF3yaB/4lBIYalH6HyUBN7H2mghWiD1so9y2BiPqNLRhSWdTNSQc3UO6I?=
 =?us-ascii?Q?ALArF1np1XCStkgIH0PpyWgc5Jg/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LowUXd9UJ3dBOE6XORnETVOjjHKMEEKHNUkH34XGSF+ENzh9ZlNiTWUZYW6T?=
 =?us-ascii?Q?Z3wpX4qGkn5oyjfjTMfSr0azOMJy83QUNKGmGC+j5bcW6NXRyRDLSXXA+Nhs?=
 =?us-ascii?Q?nWPYqCZQz3DA1LVg3XuAQIHVu8LHcOdgtrbEctKJHwhFck5TVsUW9UENnsv0?=
 =?us-ascii?Q?WE7FQ3LyE4nVKXRxtYCYrd24WqkfeopqOBm1D/I1nqUoJ7GEKCwp1R9LNYRM?=
 =?us-ascii?Q?MDVl/wOWu4hyitMToO8yzIUKeU4lTpuDHcVB//gP2VKYmK4SsakW1F8c4SrG?=
 =?us-ascii?Q?eXn2nsNxzEDd572YxZ3KVO9uxMn+GAuel4ceMeZqH9Q6KZTNmCZw0ybq2dhh?=
 =?us-ascii?Q?xPwO8b0b80MmYS58QR/H7vcRWgjmzd9ohR0ekhkCwb1wtCFElEqFu3e4Esyh?=
 =?us-ascii?Q?/23sNMQuqjOaYei5KsVsYM/2ESBQ9ez05xPZL/tuF+3zWc/insj4oiW0n5kl?=
 =?us-ascii?Q?bySVx4OKHI96678ejZGQd9oZ+XZ6JdXOVC7vgLDT2gsPiYn1EEt1QysXGbhQ?=
 =?us-ascii?Q?ZkA0CefaXau821tj0m0wi3FDQfWjzMvNZP3ojBgKHLhHMNbyB+h99BGSnhyM?=
 =?us-ascii?Q?ANnMOFmbfWJ0QimMh/BADdZlSShiW2aKJgKX1n8NY7Yy4eRp8AkvPb3B3vZW?=
 =?us-ascii?Q?jzAzCpGT3CrfQVBYLpy/vr4O565Tiebe1BeuY3op8XsC2V3V/fSMYIU06q/w?=
 =?us-ascii?Q?YQAK3v+7oR4zYGrr3lmMjzWeUM0DUmCzq7akaSMdQ6JPIQodWtOn09Wq6IkA?=
 =?us-ascii?Q?OMOyLz5dc/Vq5EmYSJQC8ndf+OI3yjO1lEI9Bvm2lglR8R9J4Koi0Pj2QV8J?=
 =?us-ascii?Q?og0Kq05aHFtU6iolevnUEgCXR63aojSxHhLyhz71VZs0nZm/uk0G/IjCr28z?=
 =?us-ascii?Q?JeEArndEEcKHnEzcQUNURoM4OchGaEqeXwgwwgRtbhIYTFD/j4o8tvwiDeVT?=
 =?us-ascii?Q?ncKVdY/i5JDa5wN56BwfSFQzqBenBfyxmvNmnC2CuJJZtRLrm8kwmSDXO7MA?=
 =?us-ascii?Q?gvFgw2eBkUANmK1tyO3LZdDMZBs1LjGWBC1b3xTbWUE+2qT5P4O3FgaGSewB?=
 =?us-ascii?Q?TtvLKbjk08J9suLemWor5eUODgq9xCoJl2CEQSLnhLf0BeiNVkCeXV8BMuUw?=
 =?us-ascii?Q?K6HgnRtoxoYrm/YNFQFn0aEMmHJLzROssqJaD9V0rnWYqTnocWQ4kt8cEt5k?=
 =?us-ascii?Q?H8BZTVTjLKfbTL+PMkgtqWz++pWMI0n9RHJSkHDmjPF8xiGFBC/v4HvWU1Gk?=
 =?us-ascii?Q?n7wFJ32rxGCkpm/af22JB29l/hhLa/g3ji2WF8IkETMYV6TCQKIiDRiTZuba?=
 =?us-ascii?Q?k/0JLsd6TtGIYct6OTGDp7I56wBcdsO1YhtpOuj0X7JG5qAxuvwJqZJN/4k8?=
 =?us-ascii?Q?F1IBxvSn8iBzh8h05KoVTYw44D6EyqHF7Sykgfy4OdbeGceuLuPH3bjn+zlT?=
 =?us-ascii?Q?DNQ8BD11SAZzjTWJ0WsQ2zYVfe5UjW1ZkspOPzFlRbehZEviar/Q6UxXTY6W?=
 =?us-ascii?Q?Bm0I+pdeZpXyhh+PpWDr+QLBFluCQc810xCy2McmTdM1wPKAcD7PYxKGZuII?=
 =?us-ascii?Q?/q9+KaJKa0MFw4c48C2h+xO6wpUmDbmPA6qdGdLK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44b1757-6560-4df5-ca62-08dd49aceedd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 08:28:44.9763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSPQ5Yr0EmwkjcXrZeRPVtmqiETD4OYoJuROvWI/3oO5QwQFiAIuzOcgS633N0h6GEXn3O0he1xLuP9F9A4Xlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423

Hi Yury,

On Sun, Feb 09, 2025 at 12:40:15PM -0500, Yury Norov wrote:
> On Fri, Feb 07, 2025 at 09:40:48PM +0100, Andrea Righi wrote:
> > Introduce the new helper numa_nearest_nodemask() to find the closest
> > node, in a specified nodemask and state, from a given starting node.
> > 
> > Returns MAX_NUMNODES if no node is found.
> > 
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  include/linux/nodemask_types.h |  6 +++++-
> >  include/linux/numa.h           |  8 +++++++
> >  mm/mempolicy.c                 | 38 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 51 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/nodemask_types.h b/include/linux/nodemask_types.h
> > index 6b28d97ea6ed0..8d0b7a66c3a49 100644
> > --- a/include/linux/nodemask_types.h
> > +++ b/include/linux/nodemask_types.h
> > @@ -5,6 +5,10 @@
> >  #include <linux/bitops.h>
> >  #include <linux/numa.h>
> >  
> > -typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
> > +struct nodemask {
> > +	DECLARE_BITMAP(bits, MAX_NUMNODES);
> > +};
> > +
> > +typedef struct nodemask nodemask_t;
> >  
> >  #endif /* __LINUX_NODEMASK_TYPES_H */
> > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > index 3567e40329ebc..a549b87d1fca5 100644
> > --- a/include/linux/numa.h
> > +++ b/include/linux/numa.h
> > @@ -27,6 +27,8 @@ static inline bool numa_valid_node(int nid)
> >  #define __initdata_or_meminfo __initdata
> >  #endif
> >  
> > +struct nodemask;
> 
> Numa should include this via linux/nodemask_types.h, or maybe
> nodemask.h.

Hm... nodemask_types.h needs to include numa.h to resolve MAX_NUMNODES,
Maybe we can move numa_nearest_nodemask() to linux/nodemask.h?

> 
> > +
> >  #ifdef CONFIG_NUMA
> >  #include <asm/sparsemem.h>
> >  
> > @@ -38,6 +40,7 @@ void __init alloc_offline_node_data(int nid);
> >  
> >  /* Generic implementation available */
> >  int numa_nearest_node(int node, unsigned int state);
> > +int numa_nearest_nodemask(int node, unsigned int state, struct nodemask *mask);
> >  
> >  #ifndef memory_add_physaddr_to_nid
> >  int memory_add_physaddr_to_nid(u64 start);
> > @@ -55,6 +58,11 @@ static inline int numa_nearest_node(int node, unsigned int state)
> >  	return NUMA_NO_NODE;
> >  }
> >  
> > +static inline int numa_nearest_nodemask(int node, unsigned int state, struct nodemask *mask)
> > +{
> > +	return NUMA_NO_NODE;
> > +}
> > +
> >  static inline int memory_add_physaddr_to_nid(u64 start)
> >  {
> >  	return 0;
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 162407fbf2bc7..1cfee509c7229 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -196,6 +196,44 @@ int numa_nearest_node(int node, unsigned int state)
> >  }
> >  EXPORT_SYMBOL_GPL(numa_nearest_node);
> >  
> > +/**
> > + * numa_nearest_nodemask - Find the node in @mask at the nearest distance
> > + *			   from @node.
> > + *
> 
> So, I have a feeling about this whole naming scheme. At first, this
> function (and the existing numa_nearest_node()) searches for something,
> but doesn't begin with find_, search_ or similar. Second, the naming
> of existing numa_nearest_node() doesn't reflect that it searches
> against the state. Should we always include some state for search? If
> so, we can skip mentioning the state, otherwise it should be in the
> name, I guess...
> 
> The problem is that I have no idea for better naming, and I have no
> understanding about the future of this functions family. If it's just
> numa_nearest_node() and numa_nearest_nodemask(), I'm OK to go this
> way. If we'll add more flavors similarly to find_bit() family, we
> could probably discuss a naming scheme.
> 
> Also, mm/mempolicy.c is a historical place for them, but maybe we need
> to move it somewhere else?
> 
> Any thoughts appreciated.

Personally I think adding "find_" to the name would be a bit redundant, as
it seems quite obvious that it's finding the nearest node. It sounds a bit
like the get_something() discussion and we can just use something().

About adding "_state" to the name, it'd make sense since we have
for_each_node_state/for_each_node(), but we would need to change
numa_nearest_node() -> numa_nearest_node_state((), that is beyond the scope
of this patch set.

If I had to design this completely from scratch I'd probably propose
something like this:
 - nearest_node_state(node, state)
 - nearest_node(node) -> nearest_node_state(node, N_POSSIBLE)
 - nearest_node_nodemask(node, nodemask) -> here the state can be managed
   with the nodemask (as you suggested below)

But again, this is probably a more generic discussion that can be addressed
in a separate thread.

> 
> > + * @node: the node to start the search from.
> > + * @state: the node state to filter nodes by.
> > + * @mask: a pointer to a nodemask representing the allowed nodes.
> > + *
> > + * This function iterates over all nodes in the given state and calculates
> > + * the distance to the starting node.
> > + *
> > + * Returns the node ID in @mask that is the closest in terms of distance
> > + * from @node, or MAX_NUMNODES if no node is found.
> > + */
> > +int numa_nearest_nodemask(int node, unsigned int state, nodemask_t *mask)
> 
> Your only user calls the function with N_POSSIBLE:
> 
>   s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
>   {
>         nodemask_t unvisited = NODE_MASK_ALL;
> 
>         if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
>                return pick_idle_cpu_from_node(cpus_allowed, NUMA_NO_NODE, flags);
> 
> 
>         for_each_numa_node(node, unvisited, N_POSSIBLE)
>                 do_something();
>   }
> 
> Which means you don't need the state at all. Even more, you don't
> need to initialize the unvisited mask before checking the static
> branch:
> 
>   s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
>   {
>         nodemask_t unvisited;
> 
>         if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
>                return pick_idle_cpu_from_node(cpus_allowed, NUMA_NO_NODE, flags);
> 
>         nodes_clear(unvisited);
> 
>         for_each_numa_node(node, unvisited)
>                 do_something();
>   }
> 
> 
> If you need some state other than N_POSSIBLE, you can do it similarly:
>         
>         nodemask_complement(unvisited, N_CPU);
> 
>         /* Only N_CPU nodes iterated */
>         for_each_numa_node(node, unvisited)
>                 do_something();

Good point. I think we can implicitly assume N_POSSIBLE and if we need to
filter only a certain state in the future, we can enforce that via the
nodemask.

> 
> 
> > +{
> > +	int dist, n, min_dist = INT_MAX, min_node = MAX_NUMNODES;
> > +
> > +	if (node == NUMA_NO_NODE)
> > +		return MAX_NUMNODES;
> > +
> > +	if (node_state(node, state) && node_isset(node, *mask))
> > +		return node;
> 
> This is correct, but why do we need this special case? If distance to
> local node is always 0, and distance to remote node is always greater
> than 0, the normal search will return local node, right? Is that a
> performance trick? If so, can you put a comment please? Otherwise,
> maybe just drop it? 

Yeah we can probably just drop it, I don't it gives much benefit in terms
of performance. And the special optimiation case of searching only in one
node can be managed already by the caller via SCX_PICK_IDLE_IN_NODE.

> 
> > +
> > +	for_each_node_state(n, state) {
> > +		if (!node_isset(n, *mask))
> > +			continue;
> 
> for_each_node_state_and_mask(n, state, mask)
> 
> Or if you take the above consideration, just
>         for_each_node_mask(n, mask)       

Ok, that's much better.

Thanks,
-Andrea

