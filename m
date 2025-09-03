Return-Path: <bpf+bounces-67257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0A2B41A84
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2223F564BCE
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04955274FDB;
	Wed,  3 Sep 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VDz5hoW/"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A81B3935;
	Wed,  3 Sep 2025 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893030; cv=fail; b=uAUQIprN893cFtuBiLiNYA4K7VkHWeOElgXxJJRqiitt695BkCYbChmRTarEvfQ5HG/bh06EVab3hSGxtOSV+Qqd920B3hpp3AwSR2Ii9jPzYHtCJk3DYPcocHlJqAFp6WmBlFQOQfJxlfARAjpz3AH90ckUvUSDnvKeV+6qn0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893030; c=relaxed/simple;
	bh=G7xuHvO1l2/o1z44+V/WrXCyLnopFQTXomoozYI/7wI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OzGR/A/fUdt11puJxVrEXs6rEQaucV/tEpaB0GfUjXOptJs3uN9JatH0yeSImHfdcLBwuOgWu3nD/OmxA1Kj8F5xUV5ER1J0yw7nCK02ziNKS2ZNoLkrZGp8JUHEOvQ6y3eiiEcxHjU+Uhx6Uhui+eZHnLH6bEJDr02M643U0Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VDz5hoW/; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvUCFKuxUsvhBTnGslXG6aMVYYOPJwcFu4pT7wUGxO3yTBXr5jq536VpKwBuEmnEPw2CG10omZLjOuNOutMGcNgLEY56T3JlpuFYW0qlorQGVXd1lWn6N27ruTVV2cuyJ6ivI7VXRgErZYSzvkZ31Zc4Hl1riEuXUjmIaGT/M4nqNOGloBZsxq3sIlvPVyTvlptg7BEX89oLewRx5SlOZFkSgYKdRUt+6v+nrMxzrWzNu08L3oh3tmgMxiydp3zVjGJHoUqIIv1fyRVxiFWU79jsYLnl/c3asWQ9+iUWSraKvb2bZvBrDdNG2S7QzjYhakp0LEPGsWQLy4ivfCcgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=med7YW+Db9Vgbl2dzImv5JRzllDllB5dGoBtHjC1qBA=;
 b=nMF5LLQofT4b7GowMK12SbYZvaAGmqC/xv7JfsfzyDCsJeWSmr12BcnPlmIgzWOrpg7AyK9Suv/rz/+nO+x19n/FetReLhfDj4RtMlfyOLf4+nhVueL4AyMpmE0kow8Assl1gr0lwZmNwvmua3krV78ERFynl14CYsggr//P9MpWBCj70XT1k1/cRaabxi+hcPDrwuzF8ebBiynffsRn6FpIm4jRo4s87pYHigvWTBxoB4MEvgKFuUYMLFBy1KgjpBxe6EmBs+CyzEHXNI+hFdNjrTq/UzOhxslXEqcTl7DRJ0mKjC0z1Mxg3vu1u0Dh4+Ovk/RShAdZ+YELQDh0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=med7YW+Db9Vgbl2dzImv5JRzllDllB5dGoBtHjC1qBA=;
 b=VDz5hoW/W+6iC2kJA1nCv61T6bbWgBnmw4Dw4xD7xoEsUaztU4RhRNX4Z2bKPs1iJFio4iZjw3jUjbLp+lw4F/yba26KHHju0eBHLG4Rvn43OoTSRkHHu6kNMUmK7oqDTLhHedqcqPhzp9gcw/IRi01NmqUk3ouJHUDItLpHDWiD68pOC10pts/r/xW7SdTJE1on5IMhipTcQ46Y05TBzF5WdGPdDIyoUtFqCd1MRbdi8BXqEMkdTroxGC5/46nsP5KguBdbzoJyTQClAJbXosrRYZBseC3fxew2dO6ijcdlESilCaEUew+06wS8q/dTMN+U57D7LVOxpl0dVd71zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:50:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:50:22 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v8 sched_ext/for-6.18] Add a deadline server for sched_ext tasks
Date: Wed,  3 Sep 2025 11:33:26 +0200
Message-ID: <20250903095008.162049-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a0d202-a88e-46c8-3324-08ddeacf4ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zy7QepfzMk5TLKTD80tgE/REsxv26C+TA6LAm5pDU1dgjUJrq3AYOT+4yXYe?=
 =?us-ascii?Q?3Z56OJBfZ4v1xiuvowy7SVuIIxQ+MSyijAQV9BcKTiK4CitsI+EvR5TYlK82?=
 =?us-ascii?Q?fYID3hpVcoYUdf+nBeMzhM0ft07dwyqUo2c6bEweaQm90cNeuavd1n4KJBcY?=
 =?us-ascii?Q?PaIuQlqbEOnTX6TvSKkZ4jnaCu2zEhFDrTbWuo+KmxvoiiYRzY4qmynvjWpp?=
 =?us-ascii?Q?JtBMudJsSEiMHszJ2dr+vGbiLe8XUET1agQ/Wle3UuboZOFF6Y5yOh0X1UaI?=
 =?us-ascii?Q?XCneRfKaF0B2goO7eGh8rhDBYRZiJrL1gf6IjfTd/iEylWwi48D4sihxUNo/?=
 =?us-ascii?Q?uSJh43YpBdMtH+wPIzQzOOJY7psOUDWLZEtkT2zc1W/tV9SFLJzqkS2H7LbY?=
 =?us-ascii?Q?kmWPFljm/KqQ+LvZyqmhYTGTaotfJNGa8RxbdlO6MNo5dA0TlVh2Sc2yrqvl?=
 =?us-ascii?Q?w1XFBatb3HYALTM0PM06+RCiItz6bmYx9ttCkJwIokF9DYPlWZIX0EPW5rPS?=
 =?us-ascii?Q?oOgD7SUSIo2qK3Q9DLHHDx5q0vWyyQtP0cIARCNgU0G9w/GmM9COzFO/O0MO?=
 =?us-ascii?Q?mtWFz3uK/ixijQePU5JRtf9/aq7LbwJTxvJOpWq7n7JZum4WCAOTrwB/LovI?=
 =?us-ascii?Q?XqdoyG+pTkv38U2P9mhiZ93PmUpivh/0FFNpDEK1UkupUSdEDj1Le78lCK4Q?=
 =?us-ascii?Q?6kiT9wCBtQEozuBNUjm7SmWrbu2BXwrGBVlzsmK1LqRNctKdWuoMdgS5ipyX?=
 =?us-ascii?Q?98tdk2yiU6+hJicygHnbpzZ/KvuMdKfi7jmEDd4IVGssNRuKlKWbsusR7R+Z?=
 =?us-ascii?Q?bZdvBiGWLoxcCTUUDcF3Inu7xpS0y7VmiDGrmd907XM+iPLX3aQWfdCpaBfE?=
 =?us-ascii?Q?M9k255uLEtZm0mZ56xHaRj1+NUD2hE5UGEMkFzz1uYYE1NnOljgyUBRHkvl6?=
 =?us-ascii?Q?78I86AHK8baZqXcD7Anf7YpmYxuwO08PcgzL08RzKCt2oyzga18BjCeH/cCT?=
 =?us-ascii?Q?n5lalC3nC6ffmXcOXy1Yc8Ru5TGZ01+Bq3/5e4jartthv/RZ6J/UAFcbHVR0?=
 =?us-ascii?Q?lUQ7wn5Zbnty5VzNRKEskE2OVpFuR3LybIjUSOoBk6zXso9lTgdxDaHS8/ju?=
 =?us-ascii?Q?KR7eQqlmnKRpotzswGSi9Nl7MrenPL1V41vTMJSJ2AoBclufZGJT8T/YfYhQ?=
 =?us-ascii?Q?0Wu3qs/7E9YgnWksXLvj86oZHK8766d+/0zc+Y+YoSytP/TyD2+XXNlsCyqj?=
 =?us-ascii?Q?J/LptvXNPZIgMxfXk+RJKUuXKqIFMo0pDK9QUYW7OCQ7wl+C+JILE9m2ScSq?=
 =?us-ascii?Q?JMgm5kGtRE784IgWZZVSVaAROTZ1FEZRe0SsndZVrWOsoaGZ/7NiZ4T2+HWN?=
 =?us-ascii?Q?+BgCF0oHHSrsEXViUjHO1q2jcGtBTHq1cYlpbNfCMKPtx9n5rx9EltoFN1s6?=
 =?us-ascii?Q?prOTdK1EWQFZxaKdKjYrzfx3T+vhft8YqPbn/hlE+Qqk1k4lZdiCr8z/NAWh?=
 =?us-ascii?Q?ezIM1pL8U/hbH/8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HgTUFM+hltKss/GfMvJlBb5+x8JvaPzr76RfHJva0qm/SdIK3gizjLxBzCHl?=
 =?us-ascii?Q?AWrqyFHkSunZXN1fXf0OpGeJILPI2SRt28KfGHXBkkgeoVJW3w8mD1wfA//L?=
 =?us-ascii?Q?CeqiNMrK0bm6YkutND7CzLWmx+C2GvPIxWY6n431BcU3raGtWa3Af7G/Zj6X?=
 =?us-ascii?Q?a4jrwviejy2znSSITWZMfbE+hpNLHgKogjgyqayjm6ml5tlrl48BkNrbNZV2?=
 =?us-ascii?Q?ijoP13rI49Ls4neUWtbBt2DS9YLZfQDeKLeD2ZbkRkTfpuvP/mhQPaAdTcfC?=
 =?us-ascii?Q?24IFdncBMklzm9S1y9gM/sbEY7fbMnYNp3k02yX5x4fYrxPxC9fkUUxY2Tf+?=
 =?us-ascii?Q?ydMlcdAiSIYLGp53gir6oMksyw+DoYEnynKGKa1+OaKlUlu8NNUbiivus3UK?=
 =?us-ascii?Q?wRvrOGdqBNwiiP5YojFeH8MLrnWbQEyU2lr9QqMPKONwLCZ84UXLbPpGRysZ?=
 =?us-ascii?Q?oXijA2if0fpgUmlILPwMu6aFBiSUyflep2C1/goe/7Dgnt+J9ezqdBmrJXoe?=
 =?us-ascii?Q?3Pf29P5mmlt8MCt9UlEOralfimbYHRI50KCkj+XtRErvwseg/aaTYgz9KD1B?=
 =?us-ascii?Q?40pGO3XBc2LmtZCBF6hcZB20n8lQA+FPX0QBz6aHLxXX0VEbckCeFThTvXzw?=
 =?us-ascii?Q?mIbuVK/g3O81kq38kZ9Upft3k6CQtsA4OOLN6nZZFyDjOLnw38ePZs50KUzO?=
 =?us-ascii?Q?3+HRUw1JjCho9QCVFrqUYsFngqFoUNSGfVbESNqPwyWwnQbMSQ2O628Bf5BA?=
 =?us-ascii?Q?QvOcBpWRvzBjIhUJhKdB2w9Qe6VJOu2Z3P2boV7mg3qzg7bqJ6H8uVwWmQEy?=
 =?us-ascii?Q?+dTeIjf8OWj9UeBbMU5AyfY39P6yklewKKNMOVLxTUpAMHHS98sM6GgwXxmy?=
 =?us-ascii?Q?2zfxWHk6RPpIihKTzzAGCwbJPy4ZBr0sW+9t8iErgtyYRzUm3eOuLtpYSAPt?=
 =?us-ascii?Q?TCQ4JZbhrsXaOXREg1LyUOLV2TbtVzObbrvs4xep1+RkPtIsgMVGG4FkqZB2?=
 =?us-ascii?Q?QBX36OfsxsaFR+CFc3eJPnJdyEg4GrNCrNnpRdjbQx+TFFKdIae9nWpqS4rt?=
 =?us-ascii?Q?GbknuH6FsEpNiKH0WtHN68aINofKof28ioOzm7AT6Jr4US+5hTVa8j9ufTbD?=
 =?us-ascii?Q?cUDTh92fL1m20PNmZhAbOsEH6zsEiVKqTfKFVO8zGKmdtb9QYfcCWX/sQTav?=
 =?us-ascii?Q?8K4IV3FelRSUC88cYFY59KyQlFBD6emXiKAu+IL4+BavEUa1NuHWlNctAmG4?=
 =?us-ascii?Q?bP/PXkuhAC2oweYxn0kfQz2VuqhWPBHSDHbbH1htwZkjTYqPhpjTYlT33nAV?=
 =?us-ascii?Q?RBDbOOJCB3gHFWrS09gqy7WMU2ImFjqAYEd7q5OMloB5+rQdyEXgzuD4rinF?=
 =?us-ascii?Q?Gq+icH58SfLbbTr96hD+pRWRBshV+fp7s/ezrIFVGUBrbGBUoRavLT1LdjCM?=
 =?us-ascii?Q?jNht+fsIjemsRvyRGG4YOlZxxeNnTuviA6AlfLjGQoD+Dn9/ecpbYWYN9hOP?=
 =?us-ascii?Q?WHQujEPEfohsmxmWRwK5687M/92yx+492Yd+mJjxBwhQd4BCJwNoAl9IrRH7?=
 =?us-ascii?Q?JTZM84nxFL9greW0U9UTEBhFxB1Hshu6XmLHHFOI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a0d202-a88e-46c8-3324-08ddeacf4ced
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:50:22.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JT+ZyIYMRWqckzItTSsWCvvJHzlLS0so7cEE4xYsw+TysqIgCUNJ0eC71VIUedpeV2jniUPnzSj+BJtid0oY7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

sched_ext tasks can be starved by long-running RT tasks, especially since
RT throttling was replaced by deadline servers to boost only SCHED_NORMAL
tasks.

Several users in the community have reported issues with RT stalling
sched_ext tasks. This is fairly common on distributions or environments
where applications like video compositors, audio services, etc. run as RT
tasks by default.

Example trace (showing a per-CPU kthread stalled due to the sway Wayland
compositor running as an RT task):

 runnable task stall (kworker/0:0[106377] failed to run for 5.043s)
 ...
 CPU 0   : nr_run=3 flags=0xd cpu_rel=0 ops_qseq=20646200 pnt_seq=45388738
           curr=sway[994] class=rt_sched_class
   R kworker/0:0[106377] -5043ms
       scx_state/flags=3/0x1 dsq_flags=0x0 ops_state/qseq=0/0
       sticky/holding_cpu=-1/-1 dsq_id=0x8000000000000002 dsq_vtime=0 slice=20000000
       cpus=01

This is often perceived as a bug in the BPF schedulers, but in reality they
can't do much: RT tasks run outside their control and can potentially
consume 100% of the CPU bandwidth.

Fix this by adding a sched_ext deadline server as well so that sched_ext
tasks are also boosted and do not suffer starvation.

Two kselftests are also provided to verify the starvation fixes and
bandwidth allocation is correct.

This patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-dl-server

Changes in v8:
 - Add tj's patch to de-couple balance and pick_task and avoid changing
   sched/core callbacks to propagate @rf
 - Simplify dl_se->dl_server check (suggested by PeterZ)
 - Small coding style fixes in the kselftests
 - Link to v7: https://lore.kernel.org/all/20250809184800.129831-1-joelagnelf@nvidia.com/

Changes in v7:
 - Rebased to Linus master
 - Link to v6: https://lore.kernel.org/all/20250702232944.3221001-1-joelagnelf@nvidia.com/

Changes in v6:
 - Added Acks to few patches
 - Fixes to few nits suggested by Tejun
 - Link to v5: https://lore.kernel.org/all/20250620203234.3349930-1-joelagnelf@nvidia.com/

Changes in v5:
 - Added a kselftest (total_bw) to sched_ext to verify bandwidth values
   from debugfs
 - Address comment from Andrea about redundant rq clock invalidation
 - Link to v4: https://lore.kernel.org/all/20250617200523.1261231-1-joelagnelf@nvidia.com/

Changes in v4:
 - Fixed issues with hotplugged CPUs having their DL server bandwidth
   altered due to loading SCX
 - Fixed other issues
 - Rebased on Linus master
 - All sched_ext kselftests reliably pass now, also verified that the
   total_bw in debugfs (CONFIG_SCHED_DEBUG) is conserved with these patches
 - Link to v3: https://lore.kernel.org/all/20250613051734.4023260-1-joelagnelf@nvidia.com/

Changes in v3:
 - Removed code duplication in debugfs. Made ext interface separate
 - Fixed issue where rq_lock_irqsave was not used in the relinquish patch
 - Fixed running bw accounting issue in dl_server_remove_params
 - Link to v2: https://lore.kernel.org/all/20250602180110.816225-1-joelagnelf@nvidia.com/

Changes in v2:
 - Fixed a hang related to using rq_lock instead of rq_lock_irqsave
 - Added support to remove BW of DL servers when they are switched to/from EXT
 - Link to v1: https://lore.kernel.org/all/20250315022158.2354454-1-joelagnelf@nvidia.com/

Andrea Righi (6):
      sched_ext: Exit early on hotplug events during attach
      sched/deadline: Add support to remove DL server's bandwidth contribution
      sched/deadline: Account ext server bandwidth
      sched/deadline: Allow to initialize DL server when needed
      sched_ext: Selectively enable ext and fair DL servers
      selftests/sched_ext: Add test for sched_ext dl_server

Joel Fernandes (9):
      sched/debug: Fix updating of ppos on server write ops
      sched/debug: Stop and start server based on if it was active
      sched/deadline: Clear the defer params
      sched/deadline: Return EBUSY if dl_bw_cpus is zero
      sched: Add a server arg to dl_server_update_idle_time()
      sched_ext: Add a DL server for sched_ext tasks
      sched/debug: Add support to change sched_ext server params
      sched/deadline: Fix DL server crash in inactive_timer callback
      selftests/sched_ext: Add test for DL server total_bw consistency

Tejun Heo (1):
      sched/deadline: De-couple balance and pick_task

 include/linux/sched.h                            |   2 +
 kernel/sched/core.c                              |  17 +-
 kernel/sched/deadline.c                          | 152 +++++++++---
 kernel/sched/debug.c                             | 161 ++++++++++---
 kernel/sched/ext.c                               | 175 ++++++++++++--
 kernel/sched/fair.c                              |   4 +-
 kernel/sched/idle.c                              |   2 +-
 kernel/sched/sched.h                             |  15 +-
 kernel/sched/topology.c                          |   5 +
 tools/testing/selftests/sched_ext/Makefile       |   2 +
 tools/testing/selftests/sched_ext/rt_stall.bpf.c |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c     | 214 +++++++++++++++++
 tools/testing/selftests/sched_ext/total_bw.c     | 281 +++++++++++++++++++++++
 13 files changed, 968 insertions(+), 85 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

