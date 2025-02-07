Return-Path: <bpf+bounces-50812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A5A2D027
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506A1188E271
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD531CD1E4;
	Fri,  7 Feb 2025 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r+L0sEC4"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C81C75E2;
	Fri,  7 Feb 2025 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965332; cv=fail; b=KI55qxs4kJlVR5UZpCOByOf7sXy7VvhLBFYy6u7/jWgfo1s9i9qo19/Po7jJD1zPKMz3VLCvlag86QrBgRD4o+uWGrxXp9cg/VgzfYoDbcL4wFENJkhaY/TP/ZP/TqSHQhTYCXe33DSUvbo/iXewKuRSS9Z9zMWkSoVmM6DodAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965332; c=relaxed/simple;
	bh=P4idOmbF8e0YTWj3XtlGfP4/rfdYMC6ASFSJPWC0H84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FK5tD24kj2pbErXBzg1O3f3RWy5ikJBo8/JSmXxIudWCV6+TRQvt6yFFwVWoFwcMzjiwjg9GNq5HiaMCfHMtCqJjhzjPfJEvxx5NTSKRfl3Kh0SxhanJeRlRfmu377RYlfdRWnRTr2ZflUZ88k4qgwi2ZtsFn3VOX0g99fw/Or8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+L0sEC4; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNdjTlrAJ68/fn6ScBGDcZJ8i9wAO17axy/i4q9NKqTAjJN/K3p/sa693q7Awcf9HhOfmnCiWlDo+KG1BIpyc925cVtI1ySmBG8eDeI8VdPj0sQSLIcT0OAIVrY9/WeYcswbrqzIVYmTyZ86TxuFmdX6OkBRMHgRFGtAHr/tiQBfMMXb2vG+wyg9i5d9d3mcF+p+s7SL8FA7QrOoJOkF7v7DO81EVG6mx9qU4bFca6vSMD3eSkDLAFA9zRhT2nr1yQpBwRN4Z4/HCOA0hTPa3NnqTrXOCfhiHN1bZ+f4U45F7zLGAntT/8mt7R3sGU5ohvblI9U0pShPOAS5wkwsXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRyeW9kbuGQFethqpm1ZUijSFK/SA63ynh//xvU++qU=;
 b=Hd6Y7UT9cPNHjxSHgBK2/9nR2V1Epvw8U5w1I82bOMvEfcpdOL1eBQ/1So6mZ1qCnVdy9FrxmFrbvjcfqY+7XNpcsAy6L9iFZt+eMn0oLajmOUlIBnFRRgW6oDETYfwi7oPkqc9REIBv7cybZEAwcLZO70MqgCNg1VyOmI6ZbJO3tD+1y6yJYBn+by/L2Qd/tEVou/g4yb+mHJJ91w88w701jxvdZJtLDbpXjVVOzjI1yOxixJdhne1Th1u0dMa0zPfBQwMytDGOMA1Ix3HIkB8O0Pv3KpwxJljqxSlbKhYfL4jFoXUAUYUJEqQyO+4g+c54B2f4lR9CpJxy5Akj1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRyeW9kbuGQFethqpm1ZUijSFK/SA63ynh//xvU++qU=;
 b=r+L0sEC4jzGxCAtj92BRNfcxH2ObxzX4TYO5zAXsuZAyyJ7D3aFc5AOPeGZkh3pdnple4bhreXGeJHApJkcvgkt0xhP5Mh3MMeeHyDathW5Pk3aDzAZqTPOuiEUZldOasbrWieuu/SSJ1TA+6P5f9B8CO/r7KsVzEFmFLUWUx9cb9HM7qlE2KRvKeK379mqFyGEUw/DccgnlZ/exqJDnqdiNVhQ9dDrToDOITdLNo+O4Tz6nk8Gbi3vBwduamSzyQ3vMBuS80mH1eoA18AEh4v4+w02txSljnQ8t0Ip1frC8BrjBWcg+fum96P6HeDUZI4xdnoqTQ8kG+aKZZNmkbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Fri, 7 Feb
 2025 21:55:23 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 21:55:22 +0000
Date: Fri, 7 Feb 2025 22:55:18 +0100
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
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 2/6] sched/topology: Introduce for_each_numa_node()
 iterator
Message-ID: <Z6aBRs3STxI7DzYk@gpd3>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-3-arighi@nvidia.com>
 <Z6Z_S6UDg80LUQEi@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6Z_S6UDg80LUQEi@slm.duckdns.org>
X-ClientProxiedBy: FR0P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca3dd1c-45a4-4660-f0a4-08dd47c21f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W6qoIK5HqpNrNKLI59vAZMSD0OKP0vqlUkiBZcGh94Td3xS1P562G22I8Ark?=
 =?us-ascii?Q?zqEUUWcztl69oLhXLs5A8eW1Bw1s7/Xvj5eKnkSIL5iBaqEg0VtB2Lmf8sTY?=
 =?us-ascii?Q?0yGj+SHZtdhmgZU4OdlzWcR/TnHjRnTsNzQ1kbKQUntCkIm7t/k+tCrfD9Rn?=
 =?us-ascii?Q?sioKMNKcdGgfSnwC/jQxjBAvFXGKY3kFYLbjHi/E+XD68khOKEkKNvPJquQe?=
 =?us-ascii?Q?caUme04Vq31StzFCeMyKvWERjhmWvI7PG2uGs9b7frPqPOVBxw9u0LY+D4ng?=
 =?us-ascii?Q?m0mf4VVRgD80vB+4ySjYXxCg0AEOlO6f/MxWgIYi2A51UhJf2LvtaUugL+C2?=
 =?us-ascii?Q?mrbnSfvrgSAw4aYeMcS1Em/CZbw1nBCzV7Ny45lI5HbhxRa7ikdDIg4glMWC?=
 =?us-ascii?Q?pqfF+6CXHjJhcBgFB5FP4zABlNGmrOV48UmmcT64qzTGs2wfE4u4PLPla3Se?=
 =?us-ascii?Q?EaPyCHsQeJhKCFD4+BIo6cq8Lb9Fu3DQoOhxSuHw6pq6QNABzy0vzQWL0Ja6?=
 =?us-ascii?Q?EkEf11vXCD+41Xk5b5+1dEAbgulIeWfEhlTkl+J0cFwZXxaEDFEaIHu1SRWx?=
 =?us-ascii?Q?fnSqiqPUfKOTuHMIa4zCIT2hk0ubmf3HYlYY5f/DwIgCKJWg8L0kPFBMjZ14?=
 =?us-ascii?Q?tIowO0At76hZKUAMTh0HE/InFDvOxjp01uX0k2+WAodZ85J3v2RbnrHrS725?=
 =?us-ascii?Q?qb4XRNaLvffolhKlt3kbquB4BZhK2VDFny4w9yc2+OcWnxkzd34lsoNKPIq/?=
 =?us-ascii?Q?V5rrp9Gk6rW2S6cBkdlk7KU3SaxWP3aF/Psl3jMYuZEoG59UHZCpdbIOsMDT?=
 =?us-ascii?Q?I3oiI+Km3m4SGz7l/TtDvejJwEprN+d5WtXopFht9MqJU7OpGlAc5Oun3Clb?=
 =?us-ascii?Q?jj7rPhKEfIyiFKnGrFFmMBTV8Gfe8GCWw5w3x30s7LT24U5C1FL+ZkAYR3ei?=
 =?us-ascii?Q?RG6LlvA5bIdmNCwVK/Qtw0z9PchVRsda2T++lRHffkwj1IWbU3300VrjjS5s?=
 =?us-ascii?Q?SsnoBAA4sncNCk36pH5XnO2ZgwdyeUhxtRDtFpm+nIOxGy1NRVR+PMXxz7kE?=
 =?us-ascii?Q?EmvrEqgx0jATHebiEy5O0K/erC1OaUAVn+/z8GQcRHK4cjHE/FR3karRg6ow?=
 =?us-ascii?Q?klaPh8ulSiGkOz2y2steN0SK4Sm6Q+i1HE0WlZp1vZqaLQ7UCiZiSSocSznp?=
 =?us-ascii?Q?f4tdD4OD6MfsN71I+qlK68ZYUD2xZbGf5G0CN6Kg1cOATgAz8fbKlF4oe+H6?=
 =?us-ascii?Q?wh26tnw937thMRq9/xxc0pz9w0OVaDT+FVdqKp95ytDh0X72177sTF71FouM?=
 =?us-ascii?Q?QkZ99DZOADh1oJYD732zl5t/fe4JuzPJwjoZvw4YQXUxyBehztm26mtUnljS?=
 =?us-ascii?Q?Ml33sope17p84Ktw2w0XcA1vUshR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DgwdCJgT64mwaZ3h+MgbsYvR8uJ8L9e6vcMfIPRmP5GP2r7Bq82M+RLijT8r?=
 =?us-ascii?Q?jrUo4kE/YJIEB7jc00YhqfZ5hS9HIW7mzPSttuMXguJvd+c/gV2XCNUKedYS?=
 =?us-ascii?Q?uFIiS00J3JH+i2VfoHx2AB3WcM8q1Ql8TOTt/J9N4PaHg3Bm5aceR/vzx533?=
 =?us-ascii?Q?OTrlh144TOCYHNyDB0bO0L4uKLpyTaJd3vJseJ8nNJWmy/ubdENYdxTqQAsr?=
 =?us-ascii?Q?nQG9LQHR1S2MqdWW+qi/g208xdui/2+zVs7nfpfslO/Vnq6Ro6b3bwW1cJ14?=
 =?us-ascii?Q?y7dI0v6sEq2cnol1q5UV/V6eDE3Prfj4ENBMBUNUWfrqP6wvgpbm/qI0lIVH?=
 =?us-ascii?Q?yS3yqv4NHewvL1u0swjaWOeukQ214ZHzvJLCBjf3l2i5zig+epVqJ9Rodkgz?=
 =?us-ascii?Q?eFfAN8u6wNlOWsuy7JINlzowFn7hzjOKIp3f9Br/iG6UQoZH1mZGw4K9Hn4a?=
 =?us-ascii?Q?canIbauPGtnpZTPHTmNnBAl6p/dumpqC1cfYu0vpv8Hatv6c/9fIg2Gh2fLU?=
 =?us-ascii?Q?l4kmG+jEyJUBEyGXDk6LajFaCL4KB5PT9+gfksIYgAlHM4dGMf0A5cukoQel?=
 =?us-ascii?Q?QAcSwjLqudS08BfY1P8fL9xOdg393V0dL0tkwQGR7R9fFOhYHC0n+DRvUmrc?=
 =?us-ascii?Q?hH0tMHwHAFdtTUsE/Kk/vfdjyemWxYQ7kx6d13RbBG+ZlL1+ZXpfrkdIrQ0o?=
 =?us-ascii?Q?kSiWgNQLR7qia1wuuPQ7j2jlhIRqMVtOjpkcMmAYnZQdgSLmgCIYdTdJdyj0?=
 =?us-ascii?Q?Kx2V/mqNLnWP0TFSlreVKvrlsm15dTlHYAQebAzKYCXgmZIsN6lyLqHXSYcn?=
 =?us-ascii?Q?qMPHpqMOzfYC+WoX1Mof5mQ0DdcnSdm6OzMnXgCMnSzwejUw6fVgAeScD8B4?=
 =?us-ascii?Q?BVo7yLaNi8lMOtwUrf8fOC9cUkqgq7OKrFt9+lJXHQxUPrfAJdvJyd9p7p8d?=
 =?us-ascii?Q?SwfipM7knBmzppr72OktyhCJn2BFoJ5tNapRcOwDtXABoUqZ8nSbOxpYe4k6?=
 =?us-ascii?Q?+54S9mq4RU24kMla4xbU816fbBT0VgBhjNdpO+wFQDCIuQffU7olA7YcgxAN?=
 =?us-ascii?Q?i/Vg9vY0RtzbhoRnTU/ZSr11LKrMgbHw9L88mX1gMWxXFHi8Q9b7ttibF3YL?=
 =?us-ascii?Q?59NA5cy4Gj/w/FnBhqqDtGtNowqf7fS6Z9L1kA3lk33rZRGBAMvek57g2xU8?=
 =?us-ascii?Q?+EXxfSDEEr7i+19SrkRynYWENhBP47N2cnhTzWP08f8wK47elu8fFwAFaTVs?=
 =?us-ascii?Q?XRl2EGGrcjSFkNslEtcbIM0aaS3jjLdf5OzU6WHrrS1JqqdNBjGZ3FWqr1Y8?=
 =?us-ascii?Q?cNbNJH2YAf5vrvHjfntJD1xXGOSXpU6MUy9LGNQvP5hZkHRg5ZdoaSJPI/UQ?=
 =?us-ascii?Q?3gyPak5dwh0RZFigaLCe0+du391EuT2K378nJrNJUvJrtqAdXBLdqWZlm2+p?=
 =?us-ascii?Q?WKrYpImin4SmDlZm7Jj/Wk7wYm0sLyH3wbx67Md8QdJg6RYKVuuwaeJZ88F5?=
 =?us-ascii?Q?QqcBAdnBxVYn9n+zwgtk7LCE+d9uxGQxh0WSxC58oTF/j/zVuq55NthF6YRg?=
 =?us-ascii?Q?gX5mgudpXyNGQcXqNZZOPgfOBDOvpHqq1RL1zbuy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca3dd1c-45a4-4660-f0a4-08dd47c21f06
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 21:55:22.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFcBx3uBpnriTSBnN4WNlexVO3eEaG4CFZrLvaKIszmeXwEZWSjjWElu1l++Gi11od5/th/ceauWeS/aeDxZwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803

On Fri, Feb 07, 2025 at 11:46:51AM -1000, Tejun Heo wrote:
> On Fri, Feb 07, 2025 at 09:40:49PM +0100, Andrea Righi wrote:
> > +/**
> > + * for_each_numa_node - iterate over nodes at increasing distances from a
> > + *			given starting node.
> > + * @node: the iteration variable and the starting node.
> > + * @unvisited: a nodemask to keep track of the unvisited nodes.
> > + * @state: state of NUMA nodes to iterate.
> > + *
> > + * This macro iterates over NUMA node IDs in increasing distance from the
> > + * starting @node and yields MAX_NUMNODES when all the nodes have been
> > + * visited.
> > + *
> > + * The difference between for_each_node() and for_each_numa_node() is that
> > + * the former allows to iterate over nodes in numerical order, whereas the
> > + * latter iterates over nodes in increasing order of distance.
> > + *
> > + * This complexity of this iterator is O(N^2), where N represents the
> > + * number of nodes, as each iteration involves scanning all nodes to
> > + * find the one with the shortest distance.
> > + *
> > + * Requires rcu_lock to be held.
> > + */
> > +#define for_each_numa_node(node, unvisited, state)				\
> > +	for (int start = (node),						\
> > +	     node = numa_nearest_nodemask((start), (state), &(unvisited));	\
> > +	     node < MAX_NUMNODES;						\
> > +	     node_clear(node, (unvisited)),					\
> > +	     node = numa_nearest_nodemask((start), (state), &(unvisited)))
> > +
> >  /**
> >   * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
> >   *                          from a given node.
> 
> Bikeshedding: Maybe this has already been argued back and forth but I find
> the distinction between for_each_node() and for_each_numa_node() way too
> subtle. I wouldn't suspect that they are doing different things when
> glancing through their usages in isolation. Can we add *something* to the
> name that indicates that this is iteration by distance? The next one uses
> "hop" which is fine, "_by_dist" can be fine too, or even "_from_nearest". I
> don't really care which but let's make the name clearly signal what it's
> doing.
> 
> Thanks.

How about for_each_node_state_by_dist()? It's essentialy a variant of
for_each_node_state(), as it also accepts a state, with the only difference
that node IDs are returned in increasing distance order.

-Andrea

