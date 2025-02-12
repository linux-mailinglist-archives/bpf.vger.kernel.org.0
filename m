Return-Path: <bpf+bounces-51280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99601A32C7D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A897916A7CD
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFDC25E444;
	Wed, 12 Feb 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RdGaC1Tb"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FE52580EC;
	Wed, 12 Feb 2025 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379059; cv=fail; b=r7oJvxNf2SX9Hvtx5MjXZX+RYJ74xbTM/gwsQkgAif2VZZu3qO3bpp1AyDKhk4CysoRJu//JLR2tHK8BL4+rh2zMn3jc2Fu+dBctDuu+ulNrOxAgM4YLxArgzl0SCf+FF8WIg+3DMVeffD33RkzBt6ZhdtlMw4E714838rz2Tqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379059; c=relaxed/simple;
	bh=oZ81eUIzJS5mZgkro+qqIuV98/tlongbiJtJMLh1kcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Quwyv4QH/ytDOcLb0rcYpCxJwSi1S3bdZHUsXKJpDy8IxIL9Jzeodde9c+OyJK2cHY6pd/VX+yBxBEeOuw89Fpm/e6tZWN4aJbrc1Y7o1glBw1oXS/jTLXZkYE+dcf8ms8GjQdIICPfy7ZpuyppMTa9XrnK1eFV51yc443NuYro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RdGaC1Tb; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6+lYl4RqsY5B5o1/P4pygkmoAloCRGRoluanp/ffrhNjrB6f8DsFW2NTBDcAVmHdDAWAxmSYq6W5+MCuuTYgZtxufkgu9VyK1gKLfXV8MKTVkbrbGtSH/hVzGp1/W+A1tPXIGWcjvq7W9ebCsrU/M3PJ3HTxkjV4ZFSv7s4eIfRfzGO+G2phiEyCOu02OisMvqYhr079ouVcIZr8OTM6RLfLfVc3ItC791XJa/tDPdhiTVrh4k3kwATf2lbwOuIWW/tY/3Iu4lrQ+MWOjfahJsttkBxAQmd3+hpJWIP5QLMpt2JQK6dybkEHl2XkjikHmGpbB4OIJlMhkDhYd1EAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyvpzcQVe55C96kGVpMYkj+FT1OyiGFdsx1rhNS6yH0=;
 b=yoHLgFmjYbtvG0r2cPH+3RlTKxPhKIpe2ETtKEFE4s/RfUGN9mTdA6PS5fb4UmcApUo2MsIEsMC+WxOQVGSlTbmETFZ1YKtTfzFC9FZu2desuOGuE0M0r5xz5ZxOHXT3csvrLxW1DH+k2KvbtdnEU2+X758qpkI+oZxW+NaZwKaW8XKpfVbEiyEFLfXPdmv8DSRUtKK6uHuzx9NTTfHi0rJ0b86ZtnpYG4nVHL4OpYP3wmMQSqHE9/3KI509LsChWYGS+ieCMx6OcOyz3obFYNqZczjuUtLMGAfTx80KXQLgX0L5O+IZQobQGgyKEGKk74xKikR40XPq4RAsV+oY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyvpzcQVe55C96kGVpMYkj+FT1OyiGFdsx1rhNS6yH0=;
 b=RdGaC1TbURS6EGELHEfGjbP1SH7N2o0sgiAmeGl+fIJrD/U0jmlcWggIDrLsibbfn+2ONkZzcvy4FWIjhBnUIE+wUET1PqVaQLIrQJes3FJTpRbjekuTvBHL8booE5Ut1ztB0oH3FFIYAAh8oev7lswCIQOX2KlXHKVui/njYtTiYc3nbRBZNu8x3Y2gPI1UVFOmiOyvV40y8xCJf4UpRUIfg3HusAaG/lpn9vNGFerKn1e+DfSAZuZ9JgtJjoABLiLD+6rI9sdkVvVxTE+WCs+3+OQVVOpTxjXnOq4y/bGi7kZSnBVYtZ2W9Jpr9oDp66fxQGTpeGfLS0kaZ1Kc9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 16:50:52 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 16:50:52 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 6/7] sched_ext: idle: Per-node idle cpumasks
Date: Wed, 12 Feb 2025 17:48:13 +0100
Message-ID: <20250212165006.490130-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212165006.490130-1-arighi@nvidia.com>
References: <20250212165006.490130-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3aad55-87e0-4a93-dcad-08dd4b85695a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h1NiGlmtPfAkjQGaKROaeu5s2HQSp6x1+P1VmjG5rwOr3QCYJg+sULq9jO7F?=
 =?us-ascii?Q?ti2j78HxnkDrwHGYqT7pXY0HtQUoF4aBphEanem0q0j+wRUMA1l+vO7YHsXa?=
 =?us-ascii?Q?SZq41e1DRqFpIVkUZyyr6jemAA7JTOavr8hc3h0FwM5uas9Sn8hWUTBKd5Ys?=
 =?us-ascii?Q?ce6/KVFmlNQWPwnNzU7ZjKTt/AeQco0EEXf/dmKG/IJE6O7Wo6cvh7bajL8b?=
 =?us-ascii?Q?B3d842c/JAj4dSuUpIPDItWf2DFY6zF32vgwFJphHrTc1D3lHIbnuolGmQlv?=
 =?us-ascii?Q?JaKQ00ltWXmoA9VSHL9/wqjqq8J7tbh1UhqXiinKG2rNa/bnDMHiXomc1gR0?=
 =?us-ascii?Q?EWxaxbDx4xMj7YZgz81PbKDp4gBW3DQf4FNiF4xf7iSNDgRRHcjqcMjtRqIZ?=
 =?us-ascii?Q?PNbmd0gDlihGMuCOfTDtORUdg0x5Uyiu9Jxf6/kX/NZhKjzFpLyxZHCeuksl?=
 =?us-ascii?Q?jtroxT0FBPfLWGJBNqbUORxZLfs3jbCV8cZqy1Mok+8yUnjQHxelpvI+GojW?=
 =?us-ascii?Q?M9RSoTu7ELH4aCGCZBbB3mnyElsuCorRvQ3ewyjkZCP3dNLZeFki612+zS3n?=
 =?us-ascii?Q?gx71WJXSLzN85NsHqegf/f5gx9DzevEyPGfDJetzFD1IzuhPtsBxHThOa9q2?=
 =?us-ascii?Q?IyBNCtk/hKOif+jVAZaSy1RRUiqvA8skWpye1cOgNSz+TSe16DE6cPc6AK7g?=
 =?us-ascii?Q?RR0AdH+Vqau1JQOHyWaWbDG7/Y6ojxgFAdZuz8EGnYeMcBsP7LoQLzyZw+NO?=
 =?us-ascii?Q?E/7vrymDZaP90apvqZQye6d6O7svE+yhsbb9tU6kcAJLP4qYOuMoUz10x7FA?=
 =?us-ascii?Q?0tJodfkyK8yc56FoMxRsSADTj7FVxVg0wEeaMiicmTVYIGkhTEp0A87WSFl3?=
 =?us-ascii?Q?Wsm0wmKAb1W0wM02/cTxwfeX92jLSs00++t1gm4Ah3Q/xtfcMIefTZzty8kx?=
 =?us-ascii?Q?cRHTLlpTxgICqVvMFI6fnPpJjkwPbyGkQXAzukYfA9ZvmFgyiqFxgx5KHkKy?=
 =?us-ascii?Q?pYpM9kt5fV1hBFF2QHRU5Vt5v8k6tjjGygkMFYtqJlkTC4mB7RBgFzqUCkxj?=
 =?us-ascii?Q?9OUXAYtmiI9nRyqxO24O3c+MEJaJLw50G3HjwLjtmAEIZI5MdjOHCvaT7gqZ?=
 =?us-ascii?Q?ExIYyON9biWUUjIoMUSSG+8v1D20bxvDMH4JeCaovbySg7c8az9X7sdFw3Jh?=
 =?us-ascii?Q?q1K/2m8fgBQKUB00NJLxtV5s/fkkTxeYTh19ys9C2LNMZQZ9hL0nVIskOVac?=
 =?us-ascii?Q?vrEf4NKWCj8233M9AorSZyyJHP4Ry9Z2sjv1n+Nrd2tfdqCePJra0iEbLoLg?=
 =?us-ascii?Q?wtcXXylEc+cCEBOCNxnJrk1hOrvmSvOs/cUk4ARY6t4hR4pSOWiwELaO3/Mg?=
 =?us-ascii?Q?8gziHcdU+h7gAidTDTXweJzhJ9LE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L5OpwT5J/EMzTigUTBwPP5I0f0GQe8Q1euU09WZRaK/bwupiLyFd3DMFk/67?=
 =?us-ascii?Q?tZGiSjuobjxfixAm2txy1pGHT8TWkhtFmq5/DEsYu26myQmtf3Pf6NO5ASZ3?=
 =?us-ascii?Q?Tf3VppAB7cfabIhZ8QMHBmPoUUucMJh2TGpyYzMnap3M5hUBjP/KFjCnulyu?=
 =?us-ascii?Q?pU2LRDelg16A2Ad63IVTIGGVWyfLrLm1/bAdTvcggHIyzHjH9ObrUC8CZwwy?=
 =?us-ascii?Q?GW7gGVsLHdCPdzTj/LX6ujrzksX8h+C4ch97e7v15knq+l75Kj00KctJkfMI?=
 =?us-ascii?Q?DAoi8QoMhcChAlhmEUDnTkaJe9+1h86OZ9mxMw/TjpwfsU/DRYQ0IDudNDkz?=
 =?us-ascii?Q?YlTY2pCLrmD6vv6Glw9N1LP7sA/tMMB2N9Z3siup9NAJxsxRXU5Wvau2pAaT?=
 =?us-ascii?Q?uLUxS2cifwoHAy0aJ+X4W2W+yJu3PLMk9FpHY86z9oVzrxdBi1g0MtkHgtcm?=
 =?us-ascii?Q?mC7wp7rZbnCu05C9jWYV7pUKYFDYtKKFR9T0oPAjC3FaQ9DlFjnLrkcH0xVv?=
 =?us-ascii?Q?xPVqnEYnu3KthJU94C0iDHHofWuHL+a4ayUzzAfs8HWPwlWQXf+qVE8FcmvA?=
 =?us-ascii?Q?qmqlkZJuI9nqsD6CGRQWpuKl6VX8aJzjF1+wEcB6Fv8WOcPtFQSTp/VCWTt1?=
 =?us-ascii?Q?W4skFJUBcWSVm0+/6N9wzI0UGdEgZ9CWwZCkUXlPXVNQbXfGFLYCDGDj8qAK?=
 =?us-ascii?Q?sXwRtJXlgRPjTPLZsKIf1jBWLKaL6lSUKKkBfyqhWbgVtpBYRucl3f55piF1?=
 =?us-ascii?Q?/1+Vo+5bd2x9WUCH9j4hQkVyk00Ypon8CCcXyvOqfs8p7s6UyNrpeDMWZkYP?=
 =?us-ascii?Q?V/mgoaJtykdbUHk8fA7S93FewsoOCEAXTswwz4yJrZ0rDO6rZMmsdFIOHqqV?=
 =?us-ascii?Q?n93lx10PaQuTXilD5qoxiw1qLGQ89LbZc0fI+A1wHMC0mPK15avl1HAx9fY1?=
 =?us-ascii?Q?jnLIvu+MXnAh5hMNKpIu9frZBkwTukF5KeCaCTKM7NyYP19EPEKWp4eJJUvJ?=
 =?us-ascii?Q?W+Q8tlDihEhCFar3Oggd6uOqwSOd/LnouCvCNjQ13EEdhU3xcm+twxYOXHYH?=
 =?us-ascii?Q?vXDAFUN/OagDxLFb78t8D9DesFrmjdjiU1QlyBvuu73RiaWxwJqLsRyqL2M9?=
 =?us-ascii?Q?YN3lpNHeE56YkR1zju8CwQBHR2Tn4e0ZSzErDCtsYFBLEvKweYCM2nKp0Tz0?=
 =?us-ascii?Q?eYAM2RiuBPyvbm6C0WSm5jv9IkCVc023isKxkF1Kg9s48qFN/QUvhSU/5oNw?=
 =?us-ascii?Q?iY6van7Qvrha4fYg+UR+duzB2+07BY9NqmSzptcn6CMsUxzqI+k35QFOIywU?=
 =?us-ascii?Q?tB9fuFd9Eu3PJrKuLglE2vMyC/zMaG2jyTAbvEldLYghYwnjrFoWhmc4lc13?=
 =?us-ascii?Q?UyUvLnnsyJEwLW5/jxBMfRxoZnOgWdTKNEfXsFlucvPCwDqAplBTSIaGpf42?=
 =?us-ascii?Q?YyoK8z81PSBk+5+PlCK61+D/QcAgT2Akx2BWiWlkfD7rdMUkyoJFvTYKindP?=
 =?us-ascii?Q?7NoedWGxnBj2zSe1DwdC8/mzsEIUROqtuhyZ8hfmvF2qOUQGA3xgPg6SdEn2?=
 =?us-ascii?Q?nCxUv715cUeE8KdS741+pmBm+Ua4giBAMBkQk6hD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3aad55-87e0-4a93-dcad-08dd4b85695a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:50:52.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 563B0MHFQQD1BFsCJUfndBpDeRd1iEpgjE0D4q/EKY889KLYJnq43irboUH3e3+EqOqMmUMZOw8PgnxLFhAZhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

Using a single global idle mask can lead to inefficiencies and a lot of
stress on the cache coherency protocol on large systems with multiple
NUMA nodes, since all the CPUs can create a really intense read/write
activity on the single global cpumask.

Therefore, split the global cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on large systems.

The concept is that each cpumask will track only the idle CPUs within
its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
In this way concurrent access to the idle cpumask will be restricted
within each NUMA node.

The split of multiple per-node idle cpumasks can be controlled using the
SCX_OPS_BUILTIN_IDLE_PER_NODE flag.

By default SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled and a global
host-wide idle cpumask is used, maintaining the previous behavior.

NOTE: if a scheduler explicitly enables the per-node idle cpumasks (via
SCX_OPS_BUILTIN_IDLE_PER_NODE), scx_bpf_get_idle_cpu/smtmask() will
trigger an scx error, since there are no system-wide cpumasks.

= Test =

Hardware:
 - System: DGX B200
    - CPUs: 224 SMT threads (112 physical cores)
    - Processor: INTEL(R) XEON(R) PLATINUM 8570
    - 2 NUMA nodes

Scheduler:
 - scx_simple [1] (so that we can focus at the built-in idle selection
   policy and not at the scheduling policy itself)

Test:
 - Run a parallel kernel build `make -j $(nproc)` and measure the average
   elapsed time over 10 runs:

          avg time | stdev
          ---------+------
 before:   52.431s | 2.895
  after:   50.342s | 2.895

= Conclusion =

Splitting the global cpumask into multiple per-NUMA cpumasks helped to
achieve a speedup of approximately +4% with this particular architecture
and test case.

The same test on a DGX-1 (40 physical cores, Intel Xeon E5-2698 v4 @
2.20GHz, 2 NUMA nodes) shows a speedup of around 1.5-3%.

On smaller systems, I haven't noticed any measurable regressions or
improvements with the same test (parallel kernel build) and scheduler
(scx_simple).

Moreover, with a modified scx_bpfland that uses the new NUMA-aware APIs
I observed an additional +2-2.5% performance improvement with the same
test.

[1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_simple.bpf.c

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                   |   1 +
 kernel/sched/ext_idle.c              | 276 ++++++++++++++++++++++-----
 kernel/sched/ext_idle.h              |   4 +-
 tools/sched_ext/include/scx/compat.h |   3 +
 4 files changed, 229 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c3e154f0e8188..129e77a779d3c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -789,6 +789,7 @@ enum scx_deq_flags {
 
 enum scx_pick_idle_cpu_flags {
 	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
+	SCX_PICK_IDLE_IN_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
 };
 
 enum scx_kick_flags {
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 59b9e95238e97..d028fa809fe1d 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -18,25 +18,61 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_CPUMASK_OFFSTACK
-#define CL_ALIGNED_IF_ONSTACK
-#else
-#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
-#endif
-
 /* Enable/disable LLC aware optimizations */
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
 
 /* Enable/disable NUMA aware optimizations */
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 
-static struct {
+/*
+ * cpumasks to track idle CPUs within each NUMA node.
+ *
+ * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not enabled, a single global cpumask
+ * from is used to track all the idle CPUs in the system.
+ */
+struct scx_idle_cpus {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} idle_masks CL_ALIGNED_IF_ONSTACK;
+};
+
+/*
+ * Global host-wide idle cpumasks (used when SCX_OPS_BUILTIN_IDLE_PER_NODE
+ * is not enabled).
+ */
+static struct scx_idle_cpus scx_idle_global_masks;
+
+/*
+ * Per-node idle cpumasks.
+ */
+static struct scx_idle_cpus **scx_idle_node_masks;
+
+/*
+ * Return the idle masks associated to a target @node.
+ *
+ * NUMA_NO_NODE identifies the global idle cpumask.
+ */
+static struct scx_idle_cpus *idle_cpumask(int node)
+{
+	return node == NUMA_NO_NODE ? &scx_idle_global_masks : scx_idle_node_masks[node];
+}
+
+/*
+ * Returns the NUMA node ID associated with a @cpu, or NUMA_NO_NODE if
+ * per-node idle cpumasks are disabled.
+ */
+static int scx_cpu_node_if_enabled(int cpu)
+{
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return NUMA_NO_NODE;
+
+	return cpu_to_node(cpu);
+}
 
 bool scx_idle_test_and_clear_cpu(int cpu)
 {
+	int node = scx_cpu_node_if_enabled(cpu);
+	struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
@@ -45,33 +81,38 @@ bool scx_idle_test_and_clear_cpu(int cpu)
 	 */
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smts = idle_cpumask(node)->smt;
 
 		/*
 		 * If offline, @cpu is not its own sibling and
 		 * scx_pick_idle_cpu() can get caught in an infinite loop as
-		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
-		 * is eventually cleared.
+		 * @cpu is never cleared from the idle SMT mask. Ensure that
+		 * @cpu is eventually cleared.
 		 *
 		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
 		 * reduce memory writes, which may help alleviate cache
 		 * coherence pressure.
 		 */
-		if (cpumask_intersects(smt, idle_masks.smt))
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
-		else if (cpumask_test_cpu(cpu, idle_masks.smt))
-			__cpumask_clear_cpu(cpu, idle_masks.smt);
+		if (cpumask_intersects(smt, idle_smts))
+			cpumask_andnot(idle_smts, idle_smts, smt);
+		else if (cpumask_test_cpu(cpu, idle_smts))
+			__cpumask_clear_cpu(cpu, idle_smts);
 	}
 #endif
-	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
+
+	return cpumask_test_and_clear_cpu(cpu, idle_cpus);
 }
 
-s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+/*
+ * Pick an idle CPU in a specific NUMA node.
+ */
+static s32 pick_idle_cpu_in_node(const struct cpumask *cpus_allowed, int node, u64 flags)
 {
 	int cpu;
 
 retry:
 	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
+		cpu = cpumask_any_and_distribute(idle_cpumask(node)->smt, cpus_allowed);
 		if (cpu < nr_cpu_ids)
 			goto found;
 
@@ -79,7 +120,7 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 			return -EBUSY;
 	}
 
-	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
+	cpu = cpumask_any_and_distribute(idle_cpumask(node)->cpu, cpus_allowed);
 	if (cpu >= nr_cpu_ids)
 		return -EBUSY;
 
@@ -90,6 +131,78 @@ s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		goto retry;
 }
 
+static s32 pick_idle_cpu_from_other_nodes(const struct cpumask *cpus_allowed, int node, u64 flags)
+{
+	static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
+	nodemask_t *unvisited = this_cpu_ptr(&per_cpu_unvisited);
+	s32 cpu = -EBUSY;
+
+	preempt_disable();
+	unvisited = this_cpu_ptr(&per_cpu_unvisited);
+
+	/*
+	 * Restrict the search to the online nodes, excluding the current
+	 * one.
+	 */
+	nodes_clear(*unvisited);
+	nodes_or(*unvisited, *unvisited, node_states[N_ONLINE]);
+	node_clear(node, *unvisited);
+
+	/*
+	 * Traverse all nodes in order of increasing distance, starting
+	 * from @node.
+	 *
+	 * This loop is O(N^2), with N being the amount of NUMA nodes,
+	 * which might be quite expensive in large NUMA systems. However,
+	 * this complexity comes into play only when a scheduler enables
+	 * SCX_OPS_BUILTIN_IDLE_PER_NODE and it's requesting an idle CPU
+	 * without specifying a target NUMA node, so it shouldn't be a
+	 * bottleneck is most cases.
+	 *
+	 * As a future optimization we may want to cache the list of nodes
+	 * in a per-node array, instead of actually traversing them every
+	 * time.
+	 */
+	for_each_node_numadist(node, *unvisited) {
+		cpu = pick_idle_cpu_in_node(cpus_allowed, node, flags);
+		if (cpu >= 0)
+			break;
+	}
+	preempt_enable();
+
+	return cpu;
+}
+
+/*
+ * Find an idle CPU in the system, starting from @node.
+ */
+s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
+{
+	s32 cpu;
+
+	/*
+	 * Always search in the starting node first (this is an
+	 * optimization that can save some cycles even when the search is
+	 * not limited to a single node).
+	 */
+	cpu = pick_idle_cpu_in_node(cpus_allowed, node, flags);
+	if (cpu >= 0)
+		return cpu;
+
+	/*
+	 * Stop the search if we are using only a single global cpumask
+	 * (NUMA_NO_NODE) or if the search is restricted to the first node
+	 * only.
+	 */
+	if (node == NUMA_NO_NODE || flags & SCX_PICK_IDLE_IN_NODE)
+		return -EBUSY;
+
+	/*
+	 * Extend the search to the other nodes.
+	 */
+	return pick_idle_cpu_from_other_nodes(cpus_allowed, node, flags);
+}
+
 /*
  * Return the amount of CPUs in the same LLC domain of @cpu (or zero if the LLC
  * domain is not defined).
@@ -302,6 +415,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
+	int node = scx_cpu_node_if_enabled(prev_cpu);
 	s32 cpu;
 
 	*found = false;
@@ -359,9 +473,9 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		if (!cpumask_empty(idle_masks.cpu) &&
-		    !(current->flags & PF_EXITING) &&
-		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
+		if (!(current->flags & PF_EXITING) &&
+		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
+		    !cpumask_empty(idle_cpumask(cpu_to_node(cpu))->cpu)) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
 				goto cpu_found;
 		}
@@ -375,7 +489,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		/*
 		 * Keep using @prev_cpu if it's part of a fully idle core.
 		 */
-		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		if (cpumask_test_cpu(prev_cpu, idle_cpumask(node)->smt) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu)) {
 			cpu = prev_cpu;
 			goto cpu_found;
@@ -385,7 +499,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * Search for any fully idle core in the same LLC domain.
 		 */
 		if (llc_cpus) {
-			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
+			cpu = pick_idle_cpu_in_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -394,15 +508,19 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * Search for any fully idle core in the same NUMA node.
 		 */
 		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			cpu = pick_idle_cpu_in_node(numa_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
 
 		/*
 		 * Search for any full idle core usable by the task.
+		 *
+		 * If NUMA aware idle selection is enabled, the search will
+		 * begin in prev_cpu's node and proceed to other nodes in
+		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -419,7 +537,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	 * Search for any idle CPU in the same LLC domain.
 	 */
 	if (llc_cpus) {
-		cpu = scx_pick_idle_cpu(llc_cpus, 0);
+		cpu = pick_idle_cpu_in_node(llc_cpus, node, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -428,7 +546,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	 * Search for any idle CPU in the same NUMA node.
 	 */
 	if (numa_cpus) {
-		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		cpu = pick_idle_cpu_in_node(numa_cpus, node, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -436,7 +554,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
 	if (cpu >= 0)
 		goto cpu_found;
 
@@ -450,30 +568,54 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	return cpu;
 }
 
+/*
+ * Initialize global and per-node idle cpumasks.
+ */
 void scx_idle_init_masks(void)
 {
-	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
-	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+	int node;
+
+	/* Allocate global idle cpumasks */
+	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.cpu, GFP_KERNEL));
+	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.smt, GFP_KERNEL));
+
+	/* Allocate per-node idle cpumasks */
+	scx_idle_node_masks = kcalloc(num_possible_nodes(),
+				      sizeof(*scx_idle_node_masks), GFP_KERNEL);
+	BUG_ON(!scx_idle_node_masks);
+
+	for_each_node(node) {
+		scx_idle_node_masks[node] = kzalloc_node(sizeof(**scx_idle_node_masks),
+							 GFP_KERNEL, node);
+		BUG_ON(!scx_idle_node_masks[node]);
+
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->cpu, GFP_KERNEL, node));
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->smt, GFP_KERNEL, node));
+	}
 }
 
 static void update_builtin_idle(int cpu, bool idle)
 {
-	assign_cpu(cpu, idle_masks.cpu, idle);
+	int node = scx_cpu_node_if_enabled(cpu);
+	struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
+
+	assign_cpu(cpu, idle_cpus, idle);
 
 #ifdef CONFIG_SCHED_SMT
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smts = idle_cpumask(node)->smt;
 
 		if (idle) {
 			/*
-			 * idle_masks.smt handling is racy but that's fine as
-			 * it's only for optimization and self-correcting.
+			 * idle_smt handling is racy but that's fine as it's
+			 * only for optimization and self-correcting.
 			 */
-			if (!cpumask_subset(smt, idle_masks.cpu))
+			if (!cpumask_subset(smt, idle_cpus))
 				return;
-			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_or(idle_smts, idle_smts, smt);
 		} else {
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_andnot(idle_smts, idle_smts, smt);
 		}
 	}
 #endif
@@ -529,15 +671,36 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 		if (do_notify || is_idle_task(rq->curr))
 			update_builtin_idle(cpu, idle);
 }
+
+static void reset_idle_masks(struct sched_ext_ops *ops)
+{
+	int node;
+
+	/*
+	 * Consider all online cpus idle. Should converge to the actual state
+	 * quickly.
+	 */
+	if (!(ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)) {
+		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->cpu, cpu_online_mask);
+		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->smt, cpu_online_mask);
+		return;
+	}
+
+	for_each_node(node) {
+		const struct cpumask *node_mask = cpumask_of_node(node);
+
+		cpumask_and(idle_cpumask(node)->cpu, cpu_online_mask, node_mask);
+		cpumask_and(idle_cpumask(node)->smt, cpu_online_mask, node_mask);
+	}
+}
 #endif	/* CONFIG_SMP */
 
 void scx_idle_enable(struct sched_ext_ops *ops)
 {
-	if (ops->update_idle && !(ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
+	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))
+		static_branch_enable(&scx_builtin_idle_enabled);
+	else
 		static_branch_disable(&scx_builtin_idle_enabled);
-		return;
-	}
-	static_branch_enable(&scx_builtin_idle_enabled);
 
 	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
 		static_branch_enable(&scx_builtin_idle_per_node);
@@ -545,12 +708,7 @@ void scx_idle_enable(struct sched_ext_ops *ops)
 		static_branch_disable(&scx_builtin_idle_per_node);
 
 #ifdef CONFIG_SMP
-	/*
-	 * Consider all online cpus idle. Should converge to the actual state
-	 * quickly.
-	 */
-	cpumask_copy(idle_masks.cpu, cpu_online_mask);
-	cpumask_copy(idle_masks.smt, cpu_online_mask);
+	reset_idle_masks(ops);
 #endif
 }
 
@@ -610,15 +768,21 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
  * per-CPU cpumask.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an empty mask if idle tracking is not enabled, or running on a
+ * UP kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 {
+	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
+		return cpu_none_mask;
+	}
+
 	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
 
 #ifdef CONFIG_SMP
-	return idle_masks.cpu;
+	return idle_cpumask(NUMA_NO_NODE)->cpu;
 #else
 	return cpu_none_mask;
 #endif
@@ -629,18 +793,24 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
  * per-physical-core cpumask. Can be used to determine if an entire physical
  * core is free.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an empty mask if idle tracking is not enabled, or running on a
+ * UP kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 {
+	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
+		return cpu_none_mask;
+	}
+
 	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
 
 #ifdef CONFIG_SMP
 	if (sched_smt_active())
-		return idle_masks.smt;
+		return idle_cpumask(NUMA_NO_NODE)->smt;
 	else
-		return idle_masks.cpu;
+		return idle_cpumask(NUMA_NO_NODE)->cpu;
 #else
 	return cpu_none_mask;
 #endif
@@ -707,7 +877,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 	if (!check_builtin_idle_enabled())
 		return -EBUSY;
 
-	return scx_pick_idle_cpu(cpus_allowed, flags);
+	return scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
 }
 
 /**
@@ -730,7 +900,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 	s32 cpu;
 
 	if (static_branch_likely(&scx_builtin_idle_enabled)) {
-		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
+		cpu = scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
 		if (cpu >= 0)
 			return cpu;
 	}
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 339b6ec9c4cb7..68c4307ce4f6f 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -16,12 +16,12 @@ struct sched_ext_ops;
 void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
 void scx_idle_init_masks(void);
 bool scx_idle_test_and_clear_cpu(int cpu);
-s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags);
+s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags);
 #else /* !CONFIG_SMP */
 static inline void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops) {}
 static inline void scx_idle_init_masks(void) {}
 static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
-static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
 {
 	return -EBUSY;
 }
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index d63cf40be8eee..03e06bd15c738 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -112,6 +112,9 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE						\
 	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE")
 
+#define SCX_PICK_IDLE_IN_NODE \
+	__COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", "SCX_PICK_IDLE_IN_NODE")
+
 static inline long scx_hotplug_seq(void)
 {
 	int fd;
-- 
2.48.1


