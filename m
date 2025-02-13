Return-Path: <bpf+bounces-51449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA354A34A7B
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FADD173029
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D0F2222BA;
	Thu, 13 Feb 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QtcBGyal"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA919AD93;
	Thu, 13 Feb 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464341; cv=fail; b=CBoHaRkjIdz56LHvkrdsDJJqyK6LztbVOJHmFf+Q7vSiY8oLDF/CHYVhKWPWfjKLdyCiMo436tx7NDTm01QufWtPFezGpKgoXAj6wpJSvWRZ0NgBDbnM14hu508x8jIxkxgvUvCosDGQ58VLXyrmo6bt9PYydhlnDW7iz06Z3Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464341; c=relaxed/simple;
	bh=xG5HICpx2QRDHkWvzdVlLeJQwJ52jgy0S2XO2HjIRXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gbUAs+NhUFOGPPT3hbUdrvQDeABC6lZNIjLOYLmdcyxkDcZX+b9qYuABagtVXnCpdxV3splbXP9Kks73lCccnRGLnkBIyPEyix62urb3XNrFumU4/GNBCmNNTqxUZUdOCGXJnTOSHsy2RfkV0jhrvc1p7dQpjhT8WwrrHFLGKfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QtcBGyal; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zd5NRlvyduVMp1vlS/3P5eIT5AlJrm5HLppu49G7nXVM//vE42fWPqBEm3obgXWCg2JRE5Pwo/qwtT4YqmNncKQzFt7exm2Jkqne749uP/SnHycnYYEo8oNDclNIH6NH7y2j8pbVrBhy7LWOtzR8Mrl6gq6xGnN2HOqxeEgLpFHyDP9hFMvo6EI3bzUZ+6FpQXMRtDw6xOb+GdYwO4q4L+QGEB3f1zFGpGWAO3ekGfkqtTwpZHI4bVzroikxJaBp94JLqhth7z2awJms4zIOTiNDqNury5p5xCloS5cFw8rb+OjPWAVeOuUv5ir6P/IVLDh2S0+4YdxMFBpBHXL8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHzw6qoGzWu2iaxSDVdqLGSNFKYB9uu+fQcOGn9XR9c=;
 b=hhud6Rnfqvz+84liTC9BgopirzLPGNeQNqVpEGiJYmJb+j4DfBALNpPPSppyTP6FzYBzzFsU9hnYJISHsY3zcvXl+pcgoix5beMf4nBnPSpKL1SyEZFqA2STaeaUMrZCXKSx0vzwmSUp4biUMX7JPTHxpjOZ3SFoHIrhHDTb8YEma0bnpsYckI87LJiQY2IUvTYYh/sq1i641uquSYAwoxsvVi971OmNdK0Pz/P8TXvZKP0hUrlvXmnNUq0kq+bgSoZYMBupOUX5uYGj8D7LSghUqJkFZB34IdjP5VlC0aXoiP0efgk9K4MOZhseHy0bMWrcMOF/CEcHAST0ZDT2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHzw6qoGzWu2iaxSDVdqLGSNFKYB9uu+fQcOGn9XR9c=;
 b=QtcBGyal406/UPwZ04POT8oOjdEzKdbsZBBk6TSGKYX1EsLzX5fCPl34C34is8zqJwI104Lq9SRdlxRQQw6lL330UAC9FpKWRtYipnXsqwEiNIrB9N4y+y9hqPeZnLmr7oiHQlBCewrqNxDWutjIN7cKQU8hGkf9y5sq+MU55OJN+53dMl6asRmzd04MjYp4b+RRVbk46hmljia5DoSpqvAYG3JNTaAuWn0m5BbYmeP7gm6KGufGvGDwE1qtAcweNGDoXCHCZT72F8+bAQWx96QKLvVN9RFOGjD30WPqyeaYkMkq2vnYkojfG2wBfBUnW4/04wX6QyPnn1Kht4nGhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 16:32:17 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 16:32:17 +0000
Date: Thu, 13 Feb 2025 17:32:13 +0100
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
Subject: Re: [PATCH 3/7] sched/topology: Introduce for_each_node_numadist()
 iterator
Message-ID: <Z64ejV9BvcN_mMXh@gpd3>
References: <20250212165006.490130-1-arighi@nvidia.com>
 <20250212165006.490130-4-arighi@nvidia.com>
 <Z64XpKDZ0GQ673Eq@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z64XpKDZ0GQ673Eq@thinkpad>
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf2882e-4fb9-4abb-3f96-08dd4c4bfabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cJ54i6RfxeCEJswq/j8KkWwT1X4QumFBpJAXzWGifzORjjHsUTCh5gQt9LJd?=
 =?us-ascii?Q?rDRgwF4ygnwDj+3Pt/0OD0P0WUTzDYJSgoDT7LL+ugFvIpoaVGSrdUrvPQpC?=
 =?us-ascii?Q?rEpICyQ1MYYu39elR1bp1ls1ZZnw5+t0nT6uuoSzw1VxTI28QL8dQqumqlr4?=
 =?us-ascii?Q?7aTBhnKYvVhD68Im6ONsu52G/BYJ5Gu2PN46jaxZIiCmj6jD8pM1P+j52C/C?=
 =?us-ascii?Q?1EFfNOGUeLs2kUclEljlj4uft9UBhXoBDUNDCHtQzo+QT3eCVg9Qs8ej9ZBT?=
 =?us-ascii?Q?2KhnxOjVHkRxn+GuTRFrUAFw/ofNShX1CBooWMYzdZjmiDc2xV6h03EKagvz?=
 =?us-ascii?Q?M2n1QBha7Zv0s+6IHTvHBSp1HUeyI9yt3BnQgtznc175kHoLDcPN3w0XoL0J?=
 =?us-ascii?Q?9cfoN9/jfiBlK/o7Uwll6CTG/1bN+6S7burY3owv3eQO9dCxt9tXgUI7eqxj?=
 =?us-ascii?Q?Ykhr+rCeE7PyL3oS/RXp3H233yujD+5Zsqsid+6SuwdMdXubmy04ON4GmMBt?=
 =?us-ascii?Q?0oDi3kPosUt0dFTicyfu4cKaDf9yrLqcUKAKpSARK2371iBAmr4AWgabdOVl?=
 =?us-ascii?Q?acSB7Z9oglnxt+FvZ5oQcukvO7XOyZA5yCi29zNA0WcuUQ+NdRgK0BKrwqhe?=
 =?us-ascii?Q?PSxDMfZQWAnhNWZ/GOANgImtqbNCI3BNZC9SVd8Z4MgStmGG/20rYcenM8Ar?=
 =?us-ascii?Q?TofhPUZsn/XNgpBnIWg2Dy/8x3FTFfsfY8n9uF0xwfEDkRIBJPp212IUNK+S?=
 =?us-ascii?Q?NsmoPUrs6G7BY98K3vNdKsXTs2v+uMbb3Vc8xwLCKXIy4iTFC5fBQO906uv7?=
 =?us-ascii?Q?XrnGn6dQkq6VTerpsYeT35UUunJcpCp0gDVIjuPs1eb8UsGEJ4Uyd6HVDLRr?=
 =?us-ascii?Q?TojT0bTWfq2/P0dJlpOmWDq2BbgI75ynNGTLOODu+nScN18eG6Qkjwu7sHlP?=
 =?us-ascii?Q?n+YqecGxHANl8owgO7cZW79cnbBCNUoueP2Yk+eAYtWVAmUgLIrGxTIxT0pY?=
 =?us-ascii?Q?lBcTFxtjqjF4DNj9yyUxKuWD8Hw1fyDyVCrw9dlpViK1VkWlqdexRaSEHzwl?=
 =?us-ascii?Q?gJ9+l3fP8nLuWi0ndIf4/X7vJvusFwa/f6RORL31j847MtNnd6mpyllJuB4h?=
 =?us-ascii?Q?eip7Ax8qhv/GBgdWL8OhSCBKLBETBNe8TfHQKGodeLkDfRTOGxnyCKRsTPL9?=
 =?us-ascii?Q?rW8MRbxyVZO4CbOJqcoYT8B1fsZVSdFdnfYgffvVh21he/8lcm6CvDQ2ZYeO?=
 =?us-ascii?Q?KbRd25X7LjuzQxkqhmnolZZkgXPw6XNyHE4pZBLu8dL9SwOrBm/qsjexibXw?=
 =?us-ascii?Q?sbm9VEJzwU9XW7lo8ezrqly9rz0B1mCD8PAdZHwOcYOh+Z3TZf87kjUeMgla?=
 =?us-ascii?Q?iXW7x4yCzPdZvyfQynB01G4SR0O9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SF03+NuTUHeVxf7bUvZPBaxJ3S4cr+zADgITuSI+PNssBgD0FCwGGzO04rLK?=
 =?us-ascii?Q?/rzFlUXowJ0OGtg77murYYsyJGqlsHUWHFPJHW2nakCdEC337B1M1saKUZyk?=
 =?us-ascii?Q?ebjm1kZpb2vDJw8C+u5QKVjtKTEagsaHVP+mVhKmjxq1ALoZAT+45B/lnk2b?=
 =?us-ascii?Q?vyMCqgmeXfpfFPPL4EeE3b54egz0oIMcrnlitrBKWnU8oV/m6CfWJweuctaW?=
 =?us-ascii?Q?6doxBkNby8e1CTZLypQjkjYHa3wTJf0CNbVNTEfEPzlj6tLj51HhaV5cdVP8?=
 =?us-ascii?Q?4VLbOHd4gm3JjyTyXB5nYiG96EMc2C3E9cKUsJoPYH0EyYdQXykWKGydT6VV?=
 =?us-ascii?Q?v8cEgjLh9iKbdW21WSMf+WXUccmbia18ZrmNFl/Ny5rdgT8w9DoBIgK3SgCW?=
 =?us-ascii?Q?a7oE8KFrQVbpGZeV1KH8ZBED0ntaV/gn1sC7FqEVdooFzITJ+iFmVo54vtRw?=
 =?us-ascii?Q?iEODBdT2TRzQm4KB+jR7JIDwoCDwTmWYZFD3QfSW4aZ1OVfNgEA3RL5gZbJx?=
 =?us-ascii?Q?RXC8zNgZLdILS/pE5oX2mwo5GldDxZOip4Wuv9vJDac/KrvLzmpXRZgTn6GE?=
 =?us-ascii?Q?YVrj+C4W2ToTBtOW2AJT2VSo6/6RmVs3YQspoatiU7sqkqWdzrM/0GNl4aA4?=
 =?us-ascii?Q?Bb/yjaM2uCIik39AHJc1E7Z2EROZSqIk99YeiEezxk9oxHmDngykZU8Pvcvf?=
 =?us-ascii?Q?s5wy0h8qyuBFd3ctAOwvKDG/LCjS21hV8kSrKUEqKY4pMQ7qcdyMkcHnTnUd?=
 =?us-ascii?Q?e7K2SaEYYjznJEV8HUHNjIKOF8zDXb8wkmuqxOOb7UQLZCMn1RdrrI25jGFM?=
 =?us-ascii?Q?Gg2ReuCxj3OdeQ1EFV7bfJPjdt5V/HGrwU0ejyuxNyUMYoKxIa1veQxb2o8x?=
 =?us-ascii?Q?DXQpNNXXNYIM8BgYdzSbVii53YP2C2prOEJAj8OJ2nHTV/ol0vrwH9MPWsUB?=
 =?us-ascii?Q?sF0eGmNko6bWIeb2On7RZtt3rDb6VV4Ivv4bI17y9CzOF3Cwlzvwy1gvIbNP?=
 =?us-ascii?Q?6oYEv2LomxyuA6ReWYIpGXlduxPG2Y+mQBqcFBxk8mXWvE3wIKspwhAeXul8?=
 =?us-ascii?Q?f2UoHclxYG0E/8yUz3SZlO26Ip3RmLjDQIVYWrV5EPWlj48LlZQdQAwzx8sU?=
 =?us-ascii?Q?cCv8js5vcIgMvExWveog9AHT5tVCK3hGWCGjuKJ0FtAwG/pz/NnKjicIyPHe?=
 =?us-ascii?Q?as5HBscQg64dIwauXT35pe6USvEjkOy8CRx1hJl/TWUeKxuNXfCF5QmqaHBr?=
 =?us-ascii?Q?CysCxYE6RYHE1cKinrLEsaQcHJX4FWwKCBjrmwp4V5YfQD2rCt98vdWXNld9?=
 =?us-ascii?Q?frDYFm8IMg98QPtCXkosXcWKcpg7T5w53CLBaTGsjUJcWL0h6hSo5GO7On/i?=
 =?us-ascii?Q?609XW9MrpJkdzFC1SwN5lW0/pEXsQBvKD0/KHiufNOLrQy+uLQlipPKLKbXf?=
 =?us-ascii?Q?UTlSN1O6h/eeno/gu1xzqdj3FVqvNYnnufH625nIMnl+cnGq4OwfMPnhM09x?=
 =?us-ascii?Q?747SGf0+F8JEiKJx0j/SF8sql1UoOqWnnDkXHhuvKSq3fLqrS5+Al/UU/HsY?=
 =?us-ascii?Q?acd0lZ2ASszATrdsbIdfZOTwxK7zh0Rnk42ax8CS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf2882e-4fb9-4abb-3f96-08dd4c4bfabc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:32:17.1555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjM8DyKP7ZRuBf42YQoBZ0RTNMjVOtV+W7pm90AwlPB2k1E0+RZ+BpMP/OmLdwHkmGFvOA8XBDhmSN6IzSJZAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575

On Thu, Feb 13, 2025 at 11:02:44AM -0500, Yury Norov wrote:
...
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> 
> Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

Ok.

> 
> > ---
> >  include/linux/topology.h | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/include/linux/topology.h b/include/linux/topology.h
> > index 52f5850730b3e..932d8b819c1b7 100644
> > --- a/include/linux/topology.h
> > +++ b/include/linux/topology.h
> > @@ -261,6 +261,36 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
> >  }
> >  #endif	/* CONFIG_NUMA */
> >  
> > +/**
> > + * for_each_node_numadist() - iterate over nodes in increasing distance
> > + *			      order, starting from a given node
> > + * @node: the iteration variable and the starting node.
> > + * @unvisited: a nodemask to keep track of the unvisited nodes.
> > + *
> > + * This macro iterates over NUMA node IDs in increasing distance from the
> > + * starting @node and yields MAX_NUMNODES when all the nodes have been
> > + * visited.
> > + *
> > + * Note that by the time the loop completes, the @unvisited nodemask will
> > + * be fully cleared, unless the loop exits early.
> > + *
> > + * The difference between for_each_node() and for_each_node_numadist() is
> > + * that the former allows to iterate over nodes in numerical order, whereas
> > + * the latter iterates over nodes in increasing order of distance.
> > + *
> > + * This complexity of this iterator is O(N^2), where N represents the
> > + * number of nodes, as each iteration involves scanning all nodes to
> > + * find the one with the shortest distance.
> > + *
> > + * Requires rcu_lock to be held.
> > + */
> > +#define for_each_node_numadist(node, unvisited)					\
> > +	for (int start = (node),						\
> > +	     node = nearest_node_nodemask((start), &(unvisited));		\
> > +	     node < MAX_NUMNODES;						\
> > +	     node_clear(node, (unvisited)),					\
> > +	     node = nearest_node_nodemask((start), &(unvisited)))
> 
> the 'node' should be protected with braces inside the macro, the start should
> not because you declare it just inside. Also, the 'start' is a common word,
> so there's a chance that you'll mask out already existing 'start' in the scope.
> Maybe __start, or simply __s?

Right, will also fix this (good thing I needed to send a new version
anyway, because the test robot found a build bug). :)

Thanks!
-Andrea

