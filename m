Return-Path: <bpf+bounces-47425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADE19F9597
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0920916CBA5
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99602218EA7;
	Fri, 20 Dec 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D/jThXvq"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D01754B;
	Fri, 20 Dec 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709284; cv=fail; b=lCitAi9nqeiO5L3v8Nn9F4y+Ccovf60d85jvBs2Fqe8/EcikpuioivFJPbrqRklDdj8w63oXMAKFDOxuZnT0C8nWTrMtl2Vdeqd5tdH4tq73CqAwZCBY4c5viue2O5w/OmgG0zln8iI58i/DP1TIEazaKzOldIIvxiK7DK24NDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709284; c=relaxed/simple;
	bh=otwZANr0+BJIaii1aka+FG7Uo/lDfoYu2K69Qlcvydk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VJ/VbyTt6stgFqrR3Hy0szM4c7/kFDRm9TRrJLw2XxMh1NzEienjhLcBl7krns8QbPdkO6Q4exOykKl1NkDluxdNt0E8iQAbNjQFVkgM3z2kaGIKB8WHy6Tkcm1t1cZL8hT7JmeCx8Iha0soAlLzXj1Sqi4QbfwGpvDev0o3l58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D/jThXvq; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED4IIgadxgc2g/BqTGwNCklt6D14zWgE66/MMHemIzxF6M55r4nbSU3oEu+9Kch4pQvax7L6TpDxHYHktYlfypwWV4mtpot+RlIQ0K7AypbGR+5AznHd5jIms7brIFCWxmdxTNg7iFTrSAdnsuUHsYzs6Q2mO1jURXVXPj2mAATUX0CimEyaHEpzuUv5vui3tG1sT7KctPBNnem0YKAwPiOX4G6yr+NmOThELBHw6w7U8W5K9SQO1nyeP6tWWMYrCCMK7jhxyMc+0mis7qjpy6B5VSOsfwJShrgz8qDsSOV2K+9brc5qedso47OsEuJras9Ck88BlgEegyTkx+B5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klT9Uj0bFDR4Tn3bUacmpWSK9LCqXBVgsp87v1Mbrrw=;
 b=NFuG5pZbkwJww8Inpax2ILb3AdhxAjNY6cPnrCvFGF5KTZPQy+UfJp0VYKYRxeGqCpJ1PthZMMxvSR2BE8DLjDg1xXhRObUAZddN7WrN8DaFILqYanv5KTTQ/8+ZgrxGVDT58vgDai+FOqLgJVCgFGp1TINMVLHzxAYDH7dKXYwc8p6ZWHRJV1AVaZyoxqvXVw64HBax3WXr9u4dVV2VBGOP7pDLZ50z4o11exKJ/4NdDE6PS73UZX/B87M6O4yV2bMW7zK86fbUOZqjOS84kKeAOFowzK8h/90VSuo/nqfhaxo41fw8UpuSakpTIsM0vovlnJtELSoM/734c4G0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klT9Uj0bFDR4Tn3bUacmpWSK9LCqXBVgsp87v1Mbrrw=;
 b=D/jThXvqjJnmnmM8X4sa3xI8TxgL/AeVgCCrEts4H/J9bT8BjcGLZ6KfSPnU+9Fo7vUdLk9ZKZIj1gf4YXPkAKuwyBorRzwcocvTORjeMn10UqF5536uXQBup1C/v7OjBJ+kHDtWU/ne6ueZGOysdm7RXZTOQTAOPajscQe36t/C1vIdVkuPxNg7kMNHTfafryQHhHe3+k9PkBWcCMXwz9B/t4mhuJ/wD/eVx1SfE14h4Ed/SPzGHeXLIlFpIgjFwozvKvMmnuLYZPlfReVRw/9KAAx7zxpRa8r0uKGzo2fK0Vu8Ze4ObC69ASSzRR8Ss76JveCkjHVxU7coeE7RNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Fri, 20 Dec
 2024 15:41:15 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 15:41:15 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v8 sched_ext/for-6.14] sched_ext: split global idle cpumask into per-NUMA cpumasks
Date: Fri, 20 Dec 2024 16:11:32 +0100
Message-ID: <20241220154107.287478-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::16) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: c3893bb9-d1cd-4cf6-339b-08dd210cbd42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J1DuDGZPUerDjdvNm4VK9R7PT3ml9gX98QVF0jmgReciKJDXk+zZkATqtOjU?=
 =?us-ascii?Q?JJRI7phi2DdoQ+aiLsJXYtcn4aDE86hBv11Fpx5RDw528bi0kHoCZhTqRQM1?=
 =?us-ascii?Q?IngAYYcrYAstwT7qlrEIRHwd7usPTo5aPon7EP0fUoQp6A3n0SYnkxftfUrI?=
 =?us-ascii?Q?qNXrAfnneob43Vbb43Z5L48Tnb2auBbghze76Bi674fFehcf7/n7Gh4Lvlbf?=
 =?us-ascii?Q?7NJ9GZAvoItKdxHW1Vfn2IvnxGkGCbSFP+g4eUdR9Iy49VuLdJE3FPHaMVKa?=
 =?us-ascii?Q?EZoQgdlGw8f7tj+8X5h0GSb57soRZhLEDqr0Md4zzhlF2U/s4C7xoi49syM4?=
 =?us-ascii?Q?pgFZafH+LIeTsZIY3QwxZeD6gn5gLkOvD21EwQnkR1X2C+oKj8sZlNX2ik60?=
 =?us-ascii?Q?kkIDnMc0CSmmHXRpOhCjotABR4yuHWFBXZI8O8P7KQd0+N2ki0s4jV1GAHKb?=
 =?us-ascii?Q?Q5/WDN0p3ESTRH2f6Uy9dU2V1YdLJNtM2ZW/tmdF43kouU85CElKFCQu8W79?=
 =?us-ascii?Q?xdLWFqeElrcMApEWoeJtVNbe7gerD7dGaBq2wUZ+IVUH4lNUqgH0baWU6fZM?=
 =?us-ascii?Q?x62nFyV7sAtTon1w2PUhB619At4ywniB/hiGrknZkmvcRofVFz7zrGnxt7rc?=
 =?us-ascii?Q?rR3KVl8TDeboNL0wibGpuebSS6v7Go+splblrO3x4iOQpRwXRK9x/HEHVbvJ?=
 =?us-ascii?Q?oPO4RS1rOZbMnHUKxpxCS9zmyhKZQRBhanIWu1hWKmjD/jha9SRatKaEPrmW?=
 =?us-ascii?Q?t0+I7GdVo/pBWEkM536maebCvNjAky56eGsAYwD2rkMOBifdIA0XJk3Z++Km?=
 =?us-ascii?Q?BLJajlZARLyIieCe5nsqcG8uvBhPKL+OKjuAX6XXYNQI7sekEq/2/zn8HlHC?=
 =?us-ascii?Q?uvmJ5BqpAo/Ogjw7U7OQmpPr1iPN7REAoAgAObYG+4aATfKCszYlWStqbgf0?=
 =?us-ascii?Q?Ot3c8exxZoZ67ijmLTuG8QDqiwspu974bzdqAYrMsCIjfVe/SBS2xQ67r/GO?=
 =?us-ascii?Q?jmbhIa/NYHX3oZeYAZDdAQjmmqX5Zf1l653PYE5XQoiExpYlkdx2Mk0k5e3H?=
 =?us-ascii?Q?cTGFv58p3u+1MNa71T6tUZoTZP+Fl17zjVNQDBsGuHUKfFa7Y2roCVlhWJpM?=
 =?us-ascii?Q?d4BCXPJybMNgyMQa4h6TprMMW2JRF7OpdDntsfulCnypU9FQ62h1J0ZXXf05?=
 =?us-ascii?Q?/SiJLKl4Zm86QyK/3nXppZBxMDr5J5u8/+DWKI//yAg6U1DhDuWtUwSXcvMh?=
 =?us-ascii?Q?e2dYUh3ZF4+3qRQODI1sFe1Hwo8vSEB9AnGjlwCj3JbHXHSvAI+IfxmysYNr?=
 =?us-ascii?Q?IWIw1Fe6Wd6oWW5qGP1cmMThnD0RElc+IHuXF9wmRulqjMdec/9I9lH2xH+t?=
 =?us-ascii?Q?fn4oCbs78F1ls8B5zWXE3T9C3lwz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LbYIPToeUHOfwaWhJucrsZHu/YPiBbX0b4ElDsmpgDQLvmmK+3LlAGUpUk9O?=
 =?us-ascii?Q?xT5g7mdlD5zZV8iS9LM4T1eJgdAIDvvuW+31J6LU1qTt/M7u+D61t6Cnu+nN?=
 =?us-ascii?Q?vZxe7KhD+9ZT1vLox8H+nMJsKNatXsutf/+qVRQkFMy03gCgBGoKZY2l78Nx?=
 =?us-ascii?Q?1T4IOpm443RIN20m7BPDMnVq8TI50rGQikyHHkdk7jqV9de4dGoEiiFCg3Oi?=
 =?us-ascii?Q?P8XwQ6r9pOTH1Lj85AeSl8WdzFlrFnQcXkr9cVFDVtsGa3vpD4Hs+bQQ7Bvr?=
 =?us-ascii?Q?NkC9G8OINBPQ2gVq8gFoUQX9ya7Z4XgnhVC1WxcnWO5EbPM4/eMX/7olfSBS?=
 =?us-ascii?Q?InpxUS5za4bJZ0qdz6cto1K5pi3PSPu3AYeOEPjmFWVI8uQIZoLuEUWDTW0L?=
 =?us-ascii?Q?xOJbYd8W8ffGvG51f8Rppqn6mlvDIIJFJI6zTqPN5WzMUFTTft9dN1qfKHqL?=
 =?us-ascii?Q?Dy3nfas10jlWurxMK/kDxEogxZdJWW2itDVHyFs71b8l586eHF4CoBQLCxnQ?=
 =?us-ascii?Q?n7avn+/ZKGhsunbe106LAODjJ8QQOwAHnGdvJZhyoNIL16VGfWG4d6A9MkaV?=
 =?us-ascii?Q?yjJFJmAALzRxIY6QiRB1QTAv7u/g5xjfWMAcgj76vJkkgQFrmyC/uaGKvB6/?=
 =?us-ascii?Q?YsCzfnMv4N7ctjxZdNeIdCcIuwsxf8X0SSSWR43QLFmyrykBrp6E7YwPFzE9?=
 =?us-ascii?Q?Uu8mUGnWA8SycBMq1F5xLgMx/yhi0+o+O9EiyOKaJjmG7mgSPn/UesImo5s1?=
 =?us-ascii?Q?CwjDJoSNdyVj/rX+xfOIGOKg94a4S53WZwW21pvtfW+1cr9gKBt/j1mr2PlC?=
 =?us-ascii?Q?aFiSvS4C0Ot8Vg2MFwdBla2J9fzLmbCA577h3WHDpI7ReHfDC7iWrkQbIDyK?=
 =?us-ascii?Q?6mVUM+jyKrrDR9oXbgvK77qbbAmfjq4/gzD56Ni2m6D/lisqKNMfZ57ppGw8?=
 =?us-ascii?Q?pyddABYOv5RkVdcst8wq+Xqy+oaTY+SihACY5QoLud3Xg7X2mv59OuQEE0HY?=
 =?us-ascii?Q?iDof78tbicCOBcsLEfbyzL6pjT+PQHsl6ZjBvwErHd2JxKzKW6oDHZ0Iz8Ng?=
 =?us-ascii?Q?YBMoGDu68PWI9aFj2FtHEZJGctU+LCyjkCGZrLIm40Bw2xlPXTRESN8GjL7S?=
 =?us-ascii?Q?hng49H0dg+ViExdbdy5VuHThNgRunkisePRa9S/BqBo84qAYRVHMgkGS1CkX?=
 =?us-ascii?Q?fSQIjzYFAnpr2au9V6iC/A2RK0GnXrPAlLnQbC885J7giY6JPaXcM9jogjMg?=
 =?us-ascii?Q?xXFtgVJCGr4XFh8nt4Nrw4cu5OwAmIXQW99168/gQ3zHXclEVR6kMAw1Iuuz?=
 =?us-ascii?Q?99qfjyEjfiZ6++3OENQSKWDDVzz5jHSvFNHm2Rv+JMpzSvSTvuIhhELMVuYN?=
 =?us-ascii?Q?UqGLP76TtGP5r8Qza9HKWsCcs/fFh9KS5vZvbjwOEquJ94DMjFzDcebfPr2R?=
 =?us-ascii?Q?IE/uDV67WjSjH4L8udFlRdR1o4G0VG9tfrrKef/s67iBHrqZXevyZOMG6ph7?=
 =?us-ascii?Q?E2vpCa+6GiwZIdMugAGjeDUpWI+YkFoAnSSVPkvB15sCxaTitHL9k5QUn/rc?=
 =?us-ascii?Q?9Tz5tlWBTi1mwQUA8DN5Tmi7QPe3zcKv3SfiCttK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3893bb9-d1cd-4cf6-339b-08dd210cbd42
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:41:15.6298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4SzuDHHU4czxa38qqom34Xut4mcJ/PkXiT5eXZgYx1ZtPzTDkfoxv++7Geg8Bsk8VeQfU5LMTnVhFKtqY5Z+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238

= Overview =

As discussed during the sched_ext office hours, using a global cpumask to
keep track of the idle CPUs can be inefficient and it may not scale really
well on large NUMA systems.

Therefore, split the idle cpumask into multiple per-NUMA node cpumasks to
improve scalability and performance on such large systems.

Scalability issues seem to be more noticeable on Intel Sapphire Rapids
dual-socket architectures.

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

I've repeated the same test on a DGX-1 (40 physical cores, Intel Xeon
E5-2698 v4 @ 2.20GHz, 2 NUMA nodes) and I didn't observe any measurable
difference.

In general, on smaller systems, I haven't noticed any measurable
regressions or improvements with the same test (parallel kernel build) and
scheduler (scx_simple).

Moreover, with a modified scx_bpfland that uses the new NUMA-aware APIs I
observed an additional +2-2.5% performance improvement in the same test.

NOTE: splitting the global cpumask into multiple cpumasks may increase the
overhead of scx_bpf_pick_idle_cpu() or ops.select_cpu() (for schedulers
relying on the built-in CPU idle selection policy) in presence of multiple
NUMA nodes, particularly under high system load, since we may have to
access multiple cpumasks to find an idle CPU.

However, this increased overhead seems to be highly compensated by a lower
overhead when updating the idle state (__scx_update_idle()) and by the fact
that CPUs are more likely operating within their local idle cpumask,
reducing the stress on the cache coherency protocol.

= References =

[1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_simple.bpf.c

ChangeLog v7 -> v8:
 - patch set refactoring: move ext_idle.c as first patch and introduce more
   preparation patches
 - introduce SCX_PICK_IDLE_NODE to restrict idle CPU selection to a single
   specified node
 - trigger scx_ops_error() when the *_node() kfunc's are used without
   enbling SCX_OPS_NODE_BUILTIN_IDLE
 - check for node_possible() in validate_node()
 - do node validation in the kfunc's (instead of the internal kernel
   functions) and trigger scx_ops_error in case of failure
 - rename idle_masks -> scx_idle_masks
 - drop unused CL_ALIGNED_IF_ONSTACK
 - drop unnecessary rcu_read_lock/unlock() when iterating NUMA nodes

ChangeLog v6 -> v7:
 - addressed some issues based on Yury's review (thanks!)
 - introduced a new iterator to navigate the NUMA nodes in order of
   increasing distance

ChangeLog v5 -> v6:
 - refactor patch set to introduce SCX_OPS_NODE_BUILTIN_IDLE before
   the per-node cpumasks
 - move idle CPU selection policy to a separate file (ext_idle.c)
   (no functional change, just some code shuffling)

ChangeLog v4 -> v5:
 - introduce new scx_bpf_cpu_to_node() kfunc
 - provide __COMPAT_*() helpers for the new kfunc's

ChangeLog v3 -> v4:
 - introduce SCX_OPS_NODE_BUILTIN_IDLE to select multiple per-node
   cpumasks or single flat cpumask
 - introduce new kfuncs to access per-node idle cpumasks information
 - use for_each_numa_hop_mask() to traverse NUMA nodes in increasing
   distance
 - dropped nodemask helpers (not needed anymore)
 - rebase to sched_ext/for-6.14

ChangeLog v2 -> v3:
  - introduce for_each_online_node_wrap()
  - re-introduce cpumask_intersects() in test_and_clear_cpu_idle() (to
    reduce memory writes / cache coherence pressure)
  - get rid of the redundant scx_selcpu_topo_numa logic
  [test results are pretty much identical, so I haven't updated them from v2]

ChangeLog v1 -> v2:
  - renamed for_each_node_mask|state_from() -> for_each_node_mask|state_wrap()
  - misc cpumask optimizations (thanks to Yury)

Andrea Righi (10):
      sched/topology: introduce for_each_numa_hop_node() / sched_numa_hop_node()
      sched_ext: Move built-in idle CPU selection policy to a separate file
      sched_ext: idle: introduce check_builtin_idle_enabled() helper
      sched_ext: idle: use assign_cpu() to update the idle cpumask
      sched_ext: idle: clarify comments
      sched_ext: Introduce SCX_OPS_NODE_BUILTIN_IDLE
      sched_ext: Introduce per-node idle cpumasks
      sched_ext: idle: introduce SCX_PICK_IDLE_NODE
      sched_ext: idle: Get rid of the scx_selcpu_topo_numa logic
      sched_ext: idle: Introduce NUMA aware idle cpu kfunc helpers

 MAINTAINERS                              |   1 +
 include/linux/topology.h                 |  28 +-
 kernel/sched/ext.c                       | 727 ++----------------------
 kernel/sched/ext_idle.c                  | 931 +++++++++++++++++++++++++++++++
 kernel/sched/topology.c                  |  49 ++
 tools/sched_ext/include/scx/common.bpf.h |   4 +
 tools/sched_ext/include/scx/compat.bpf.h |  19 +
 7 files changed, 1068 insertions(+), 691 deletions(-)
 create mode 100644 kernel/sched/ext_idle.c

