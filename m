Return-Path: <bpf+bounces-47579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BC19FBA4C
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 08:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B041918854A8
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A2A18DF60;
	Tue, 24 Dec 2024 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AU0bQpty"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13D8F66;
	Tue, 24 Dec 2024 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735026899; cv=fail; b=XvaxTirbir7K6gevq1kd3CLv/uK3v8GvhH9JnAr8AGHhD9zPldtifuqN8CDwkm3C+ibwatB0EdjsG+r3+M0ysA0JoAvfa/8ciLdGGCObhCUPH97lGu7EDN5AgXPY+P9GXHmH0190HclmCYD+ukFPkoe2LEm1bgA6OlJZFBMXrbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735026899; c=relaxed/simple;
	bh=eAKxL1Q/wcSsInm2B/nCCGqudX0X2DUUoMJ/PUy7Lrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FWWVPdJun4nV8ZkFztFD7+y4gVkckcSTZYdLZoU4UVfbx743Cf31/atspjwP9dZo1jsaWFsU2YXKXuxEijvNHGyJTlzHwO4X0Ab8LoS6dHSO1mfrEzHanQTrboc0WExIFOQBgNfXiYLaR56888CVxBDPni0sD3rw/zUCTnX2RhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AU0bQpty; arc=fail smtp.client-ip=40.107.100.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj65Vnd+KEcHKvcMioIDdHrCNh+Ur0RZVgevj0ztydOFe8e6H0ElzpCf3QHqMAmcw4uo8304RQUQROLaC3hPAi/WOcWK455Ai134UXB2brKVXN5eZ3gMR6v3WHxPLnq/npCY6GBrD6igxT/hjTrHr+UgKRZL4ijCHz4WL7FN+C2IDcNnZE1asvuiycQtxWwdNXWtFDjmTMXhMQP+WxIPLDgcq7s2aWdnHBlJqBFISrUg0dEEQ2fJgYC/wJ0QxAID79yGLRWyelTgeFQBJTEpWd2XTSbkJPb7hQ2e1HYMIDi6yFqXaMgPfqsRefpMzdgzkgV0wg370p0KBnWyZsRgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3P9rYAyb/iKGWO5VibL7VjJi8ilI/0Z+iQh0q5ECVE=;
 b=q5xY4mQYIXvzo0aHP5ZBSdyO6rIBYiqGRcU5GjSSvi7EsjpHaW4J38sDPFVjS6Nfcyvmr7oZFyD+nybPJQ9gDwuncyebYWeJD6pNo1fYZ08Ko6CyA3GRbV1+0JWtHULVd4PSoKR8cgwB62fpa9o0CkQ6zZRPQX75GkqvgvE0IecrHTgUDt7GPDS9HnJdHAoQNgp3X8cvQSOaoGAsNhKiG3b7EATEhk4Lv+KFicIpPgWBFyyOE0PYvwFYhhimWYyv1syRS7RthCokexQe4gV2wMxScUxKEwnC7HjMNFINKS/CFbm8fvdrGd5qHhtkhK6OEm8HIMNggST8C4MAHSL+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3P9rYAyb/iKGWO5VibL7VjJi8ilI/0Z+iQh0q5ECVE=;
 b=AU0bQptynkpEeU1A6HKnq160Fddz8YZhprGkL05K1cn2nwc+mMK7xdOZ2CKG3Vf6EBsUHbTbzu8PJKPKTKv5PuXJASASF8DkJNGFymUnm6+VPV+1FTR9fe0b+tp0OubbDbln+JsPvY0o1kmFKD6u35jb5Jox5hI5vOTa/XP8W/J5ClO1wY7pdEUZUo5gU83G57NcbIr7Azw0ilexcgECEqjRWuYPNdkJc41QPKk7JMfIFcFpX4kM4uSG2JQXFkixtKgL2xjE3QYCXM8HdqibM353v+OfT/X4HgWPfnFbSYImR5zwzSFhs7lSEYWZgDP+EDTEMGHMqhU3NjlUXUrIAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Tue, 24 Dec
 2024 07:54:49 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 07:54:49 +0000
Date: Tue, 24 Dec 2024 08:54:40 +0100
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
Subject: Re: [PATCH 01/10] sched/topology: introduce for_each_numa_hop_node()
 / sched_numa_hop_node()
Message-ID: <Z2powPXbWlZqzU6r@gpd3>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-2-arighi@nvidia.com>
 <Z2nTkshW2sUmNLVA@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2nTkshW2sUmNLVA@yury-ThinkPad>
X-ClientProxiedBy: FR4P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d65b7e-6b8d-467d-300d-08dd23f03d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jMtl6y3o+VnWwX3TF6OfB4m51zYuLlfrRhbAB9wadM0r4EDpZiZ4rcSmaJTR?=
 =?us-ascii?Q?CFQB53WFkwTXCWameGinGcmns5m+CSRgwrvi+9SAlZfykWlfA79vSCG0RUuk?=
 =?us-ascii?Q?xxY2qgJvKyXYwkpYluJJUj5TwiUHviRWwLn8fx++9NaVj7b8f5EegJjMzKyu?=
 =?us-ascii?Q?NPD3ysAwLWooUHJt/DEcZVmZasRzXhkWl6FQ1Cs83pnkYr9s4q4IhDaIkdwr?=
 =?us-ascii?Q?Rs08YbYQtxyBOXsp/rhneCgyaUYFK+9Rb3kRhKicZTvqwpqlYX7PyuBl9pVO?=
 =?us-ascii?Q?i/Cml6RqjuKtPPxPG387BT9QWofz10pywMNX4ZmL/asZX/Ks7/Li7I6jLtJw?=
 =?us-ascii?Q?LrXz7tpWVlqaZo9hwXEnDh47jjp7a4mkqqgBpdPDffmyYDKnPc6V2li/2V5h?=
 =?us-ascii?Q?pWHph1J/JltqZd0HKeQK6IrVXmyp0qdMcpXyRL5wCrpUqDHq7hrX3I9FyE8o?=
 =?us-ascii?Q?yu2OE8MSxTbxNurHsnvsvJs+Q3ZVgprVDNa0OjfAUMY+skTnl8ktgshgsYYp?=
 =?us-ascii?Q?Qvjcwxu9pKNOWrO/qr6wHEgc67gCYx9szwy2Oqk5sru+4r5HhvPne93uwyZJ?=
 =?us-ascii?Q?FK/tH5JqUp2XmvhUciVLdlyKcyqUHfIc+EEzEpwgCeTw8iWUxKZtJ7CGV9GE?=
 =?us-ascii?Q?oF0z0UVzUIq7vws+7ed5OtQzp9wNvdjVgktXSv3y3N8Xt0YgSgLVu0xur5WH?=
 =?us-ascii?Q?DZ+dZwZBd3lWKEEXhjP4rbd+9YlKJ/VD8g1q808Fh1eF8y6nDHDSNo4O4wKh?=
 =?us-ascii?Q?I1xnS47jDa9fP+gq6P0GMGP9QEr5ra5dqs2bJWwjL5A1T3qgobe5Cfb8G1FU?=
 =?us-ascii?Q?+5SQLs4CUxfbBV2C6IDzxLBFc4f7vhqzZEwq1QsAva597nKWVJQZUzhwJ00h?=
 =?us-ascii?Q?24rgoYos8jUyqkECpSYP543yh0uzhzjwzf6g/mzBLW6O9PyXwmTIpKnAOnue?=
 =?us-ascii?Q?Vhg0+PEfPpOagA8PJlCh+jqWCgqK+HTKOPFzY7viL6UZqQZ0ZCHBUdtSHzVI?=
 =?us-ascii?Q?F9K4I+PBPQryQlAi6m4uz1VFwjkqup5iNZxTAEy14NMdQkMv9YSDljj5IC0A?=
 =?us-ascii?Q?ttEVAg+ZAPKXftKtMfYULqfXAdkMnpaU8z/i0VbPhKVASFiUf2Xubda8ABOw?=
 =?us-ascii?Q?13f7eMXatRebC5NGC23lh2H/SmsVfzrnr+rbvqYcvAz0VzTGrmtBOihDuJNY?=
 =?us-ascii?Q?kgyddF2M88omhgAcY+mw468R/d0/M8CRmsJaAuFu1IkBl6fk3/eBB94JxLOo?=
 =?us-ascii?Q?GVAGNQy5CS3QgGnrdi6QR0IvsGa5/ns2qAfbrljv9mFJAHNgjD8l2JMkSKtN?=
 =?us-ascii?Q?5MIT8Aox73UcyyMrnAkV50rjCAMNdBAg+zfwqv8fPyvv+KMVeRP5qMuTUAjG?=
 =?us-ascii?Q?/IlSbKksthsBcePfvrQVe/8el48P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IIzW37uDp0gxlOyvGKuiyuRLyzAxawNUQVpDzMnJ3bxyOyGJRVcZ8/NkhoyZ?=
 =?us-ascii?Q?yDTu6yCWG7gH2XwtBfICbVf7lSzsw0N9hIC301t5EaSKZSIkVIAStLKKcG5h?=
 =?us-ascii?Q?oRthfxyFYSa9xFNbbFHPOcAlXc4CD8tPOifUa43CplJvxMWd7UUR5QGGqW6R?=
 =?us-ascii?Q?5SY5DGXDkLAUIvNTClgGPVqbS5PwXRDqb4DBjH8ccC9x5K07I4i5UICTELAJ?=
 =?us-ascii?Q?kqH8Rp2W03UfDt3CTcspw8T5Py6eHGntvTDeWfZ617FlwLNAF9qhUtqa9lZf?=
 =?us-ascii?Q?rQuWttCJy3vtHFBIF70wN9kI0PGeXYnrBGBVnYrvxwAiibFBdbQUbrrWQ9Qt?=
 =?us-ascii?Q?5kS0Un5x3M5UK++5w5HmMTqnP7PLYlY2neTcBbiGjHOtIyY/Zaita2TcVR/+?=
 =?us-ascii?Q?a/ztLiQCiT82BGsbi/aAqKTxz/zDy2HGh+87dl/sezoHr3mnS4dvX/BCxHUg?=
 =?us-ascii?Q?yEIxonf3L8ix0YCfbQmcIbw0gzV0ib39cn8poVPpyB2NwotobgqAazSoKuQ5?=
 =?us-ascii?Q?acM1/a/XyWibiiXRtIr2pbgBYNx/o38FTVYNR8RnHQeTMBEzrWvA+QFH6MZB?=
 =?us-ascii?Q?0jY1HqNW8jxP+TGOpgymB4ut/SUsxVNNbtwC4dHhKLknXLH6fMZsnydvu2ao?=
 =?us-ascii?Q?k/Ejsd9LNGkv72qnz8BU1y/6K6NllbCNL2twZb6hDAepsblV7TV4p01AkA8Z?=
 =?us-ascii?Q?5ilaMEeDXrTNEz3ZxZvGKplcZJfcG8Q8zn6drSwZoRCAjHgAg3Im7Z7U2waD?=
 =?us-ascii?Q?JF7em4/+jJ64uV/ZlSV5rF7M3bwwVj4ARvd2R0XrBoPpQfpm/VIvhU+qezLz?=
 =?us-ascii?Q?e9dh5QvmAm5qoh75KBueD1k71ux0ptMxFQxZA6ZLBi7+mpk8Q8ArUN0DOA38?=
 =?us-ascii?Q?8sMJIbfNhSEltpswlBf0RXsi3/FcNkN7VMDcXFJ9RusmLDClQg50cJ2HEFR1?=
 =?us-ascii?Q?dtEi6XRzqCCdyoCuWfXd7MHswjayYniTt4A4SbtHT05vuzFnrT8Buyk+nqEu?=
 =?us-ascii?Q?VrbPl1Y6IZuJRZcyWBCdDDBqWHkY1klL3Sb/JrGs5mtJjOXneJASl17Ho0kU?=
 =?us-ascii?Q?unHgHceO3ePFMLGZxFnBV4KzaT2EJ/iVvo9SH0J3BODoyBlioQtqj77d1bm2?=
 =?us-ascii?Q?o2hRPXSozvV4sk8fAkKR30t1mjz3W+VF+DAWg5dI534ihYkaWJrHC25PLA52?=
 =?us-ascii?Q?G3ZiOEoMQZXJi3aDCzyqWtwCSPHjWq7sjlanMyANxUT8V8eUO6d0PwlhS+aS?=
 =?us-ascii?Q?TIJDq3kgxzF7CSf4QAZ4vOW2KiVZZ7gDFOQcRdV/9YpPQ/xa8It5aIEL8VO5?=
 =?us-ascii?Q?SW1TiSl3UwKhKY5oxfnPrRhUXBp/zViiHWRg8i+sHAFC0be/WS/nKzmnjzaE?=
 =?us-ascii?Q?gCsblFs3dizK6f+6SriHC9+LosHs+JyxVVjLTjeI/4BqzEK33rcaSRRdbc/7?=
 =?us-ascii?Q?kFGt35CNAEfaUrlLyC2VEEqTrUrEGS0JEAdJohi0AqJ7HIygxbG2Oei/hK76?=
 =?us-ascii?Q?2bV44dgiZgK5qtUKX5IjFO0oWuwOs4LuG/dh3iWlJ2WzJIy0GUY2Jl0qmYew?=
 =?us-ascii?Q?BdfmVrYZmANkRd4jt4+hjtS/z4vdCsavVWTXzUoR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d65b7e-6b8d-467d-300d-08dd23f03d75
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 07:54:48.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afDvsohwQw+JNGKQ1RiqkTz0dqE8dFEtrXlnWcRGYJekZIP+J/7ICwoIqN7W985FWueVZmU+2DBfzmQmKQocBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975

Hi Yury,

On Mon, Dec 23, 2024 at 01:18:10PM -0800, Yury Norov wrote:
> On Fri, Dec 20, 2024 at 04:11:33PM +0100, Andrea Righi wrote:
> > Introduce for_each_numa_hop_node() and sched_numa_hop_node() to iterate
> > over node IDs in order of increasing NUMA distance from a given starting
> > node.
> > 
> > These iterator functions are similar to for_each_numa_hop_mask() and
> > sched_numa_hop_mask(), but instead of providing a cpumask at each
> > iteration, they provide a node ID.
> > 
> > Example usage:
> > 
> >   nodemask_t hop_nodes = NODE_MASK_NONE;
> >   int start = cpu_to_node(smp_processor_id());
> > 
> >   for_each_numa_hop_node(node, start, hop_nodes, N_ONLINE)
> >   	pr_info("node (%d, %d) -> \n",
> >   		 start, node, node_distance(start, node);
> 
> This iterates nodes, not hops. The hop is a set of equidistant nodes,
> and the iterator (the first argument) should be a nodemask. I'm OK with
> that as soon as you find it practical. But then you shouldn't mention
> hops in the patch.
> 
> Also, can you check that it works correctly against a configuration with
> equidistant nodes?

Ok, and yes, it should mention nodes, not hops.

> 
> > Simulating the following NUMA topology in virtme-ng:
> > 
> >  $ numactl -H
> >  available: 4 nodes (0-3)
> >  node 0 cpus: 0 1
> >  node 0 size: 1006 MB
> >  node 0 free: 928 MB
> >  node 1 cpus: 2 3
> >  node 1 size: 1007 MB
> >  node 1 free: 986 MB
> >  node 2 cpus: 4 5
> >  node 2 size: 889 MB
> >  node 2 free: 862 MB
> >  node 3 cpus: 6 7
> >  node 3 size: 1006 MB
> >  node 3 free: 983 MB
> >  node distances:
> >  node     0    1    2    3
> >     0:   10   51   31   41
> >     1:   51   10   21   61
> >     2:   31   21   10   11
> >     3:   41   61   11   10
> > 
> > The output of the example above (on node 0) is the following:
> > 
> >  [   84.953644] node (0, 0) -> 10
> >  [   84.953712] node (0, 2) -> 31
> >  [   84.953764] node (0, 3) -> 41
> >  [   84.953817] node (0, 1) -> 51
> > 
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  include/linux/topology.h | 28 ++++++++++++++++++++++-
> >  kernel/sched/topology.c  | 49 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 76 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/topology.h b/include/linux/topology.h
> > index 52f5850730b3..d9014d90580d 100644
> > --- a/include/linux/topology.h
> > +++ b/include/linux/topology.h
> > @@ -248,12 +248,18 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
> >  #ifdef CONFIG_NUMA
> >  int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node);
> >  extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops);
> > -#else
> > +extern int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state);
> > +#else /* !CONFIG_NUMA */
> >  static __always_inline int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
> >  {
> >  	return cpumask_nth_and(cpu, cpus, cpu_online_mask);
> >  }
> >  
> > +static inline int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state)
> > +{
> > +	return NUMA_NO_NODE;
> > +}
> > +
> >  static inline const struct cpumask *
> >  sched_numa_hop_mask(unsigned int node, unsigned int hops)
> >  {
> > @@ -261,6 +267,26 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
> >  }
> >  #endif	/* CONFIG_NUMA */
> >  
> > +/**
> > + * for_each_numa_hop_node - iterate over NUMA nodes at increasing hop distances
> > + *                          from a given starting node.
> > + * @__node: the iteration variable, representing the current NUMA node.
> > + * @__start: the NUMA node to start the iteration from.
> > + * @__hop_nodes: a nodemask_t to track the visited nodes.
> > + * @__state: state of NUMA nodes to iterate.
> > + *
> > + * Requires rcu_lock to be held.
> > + *
> > + * This macro iterates over NUMA nodes in increasing distance from
> > + * @start_node.
> > + *
> > + * Yields NUMA_NO_NODE when all the nodes have been visited.
> > + */
> > +#define for_each_numa_hop_node(__node, __start, __hop_nodes, __state)		\
> 
> As soon as this is not the hops iterator, the proper name would be just
> 
>         for_each_numa_node()
> 
> And because the 'numa' prefix here doesn't look like a prefix, I think
> it would be nice to comment what this 'numa' means and what's the
> difference between this and for_each_node() iterator, especially in
> terms of complexity.

How about renaming this iterator for_each_node_by_distance()?

> 
> Also you don't need underscores in macro declarations unless
> absolutely necessary.

Ok.

> 
> > +	for (int __node = __start;						\
> 
> The __node declared in for() masks out the __node provided in the
> macro.

Ok will fix this.

> 
> > +	     __node != NUMA_NO_NODE;						\
> > +	     __node = sched_numa_hop_node(&(__hop_nodes), __start, __state))
> > +
> >  /**
> >   * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
> >   *                          from a given node.
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 9748a4c8d668..8e77c235ad9a 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2185,6 +2185,55 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
> >  }
> >  EXPORT_SYMBOL_GPL(sched_numa_find_nth_cpu);
> >  
> > +/**
> > + * sched_numa_hop_node - Find the NUMA node at the closest hop distance
> > + *                       from node @start.
> > + *
> > + * @hop_nodes: a pointer to a nodemask_t representing the visited nodes.
> > + * @start: the NUMA node to start the hop search from.
> > + * @state: the node state to filter nodes by.
> > + *
> > + * This function iterates over all NUMA nodes in the given state and
> > + * calculates the hop distance to the starting node. It returns the NUMA
> > + * node that is the closest in terms of hop distance
> > + * that has not already been considered (not set in @hop_nodes). If the
> > + * node is found, it is marked as considered in the @hop_nodes bitmask.
> > + *
> > + * The function checks if the node is not the start node and ensures it is
> > + * not already part of the hop_nodes set. It then computes the distance to
> > + * the start node using the node_distance() function. The closest node is
> > + * chosen based on the minimum distance.
> > + *
> > + * Returns the NUMA node ID closest in terms of hop distance from the
> > + * @start node, or NUMA_NO_NODE if no node is found (or all nodes have been
> > + * visited).
> 
> for_each_node_state() returns MAX_NUMNODES when it finishes
> traversing. I think you should do the same here. 

Ok.

> 
> > + */
> > +int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state)
> > +{
> > +	int dist, n, min_node, min_dist;
> > +
> > +	if (state >= NR_NODE_STATES)
> > +		return NUMA_NO_NODE;
> 
>  -EINVAL. But, do we need to check the parameter at all?

numa_nearest_node() has the same check (returning -EINVAL), it seems sane
to do this check here as well to prevent out-of-bounds access to
node_states[state].

> 
> > +
> > +	min_node = NUMA_NO_NODE;
> > +	min_dist = INT_MAX;
> > +
> > +	for_each_node_state(n, state) {
> > +		if (n == start || node_isset(n, *hop_nodes))
> > +			continue;
> > +		dist = node_distance(start, n);
> > +		if (dist < min_dist) {
> > +			min_dist = dist;
> > +			min_node = n;
> > +		}
> > +	}
> 
> This is a version of numa_nearest_node(). The only difference is that
> you add 'hop_nodes' mask, which in fact is 'visited' nodes.
> 
> I think it should be like:
> 
>  int numa_nearest_unvisited_node(nodemask_t *visited, int start, unsigned int state)
>  {
>         for_each_node_andnot(node_states[state], visited) (
>                 ...
>         }
>  }

Makes sense. I'll change this and at this point I'll move this code to
mm/mempolicy.c, close to numa_nearest_node().

Thanks!
-Andrea

