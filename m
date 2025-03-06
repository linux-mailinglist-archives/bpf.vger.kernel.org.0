Return-Path: <bpf+bounces-53497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A09A554E2
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 19:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8B5188B879
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C66426BDB5;
	Thu,  6 Mar 2025 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="enUAZ9Uq"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D12926B2AD;
	Thu,  6 Mar 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285572; cv=fail; b=OP6O/eyzzSZfxCAWp/7HboIj2ChztY4VlmFjPDxhXkfkHAZrQ+BeSDo88l0WXxFc4A8Orkh355vh0mFIOe5zykSYFzLpPjBlObC2biP2Yp7vS4AtoR4cBVAvuL7DZXZEWwaFRTNWsMjhsCjn0FGLKSEQN8umz46fF4dk0BtzjSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285572; c=relaxed/simple;
	bh=LZMv5srYSfXpVdnHh3ECFQR6G2sqKOPRi3fPqjgzXrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qP4vgbgkzVxHcIK7h7ggNjwGWRkHyaToo95SixXN1MYIH22GbpH2o+2XfQeFKygqnOghAeRfC+NL3uRSx8J5KmjD/k5DM3Eee+vtsxJxV7qUb1GPPFChOGcT7jBqPyne3Rn+d0y3cKnY3k+8KjhOab+ezneRE1tc74ybyX+6fuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=enUAZ9Uq; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnykJbQD+9XRuJMEebbITzRhndQiEnNZG2IOzoBNSIZL7mq+kvVOCh2XlrSqIz9UrACGSxduwgJZcWwDD0xN2pRiEGRFvmIRUUoBRw3OCoUE/ET2rOs+Xp3i+e9TBfDE2gp3YxBYqEw4FqHEVA+XBxNIJHjM1GwBXye7LnYYNNchB2Gyizm4yz45YkNEBbWmIM9MBmriJG0yyoxHs/TYCHdgViLsOKh/QUECGCZjcgolwt8tRd/bcuT+RuCZeUCD7kxHZcVUn8mum7QHEwCMFxG/uMaqyH11pPk/BcmUveaeKe/qULkRUlyW5GupAsQXhI3qcma5MrT6KrCH97475A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCGu5N0lsnzCz8FIYttM56vGucMJOruAWAl4c96NA+0=;
 b=c49GPrHcpszIB340Ytryb0/0u978AKiGR8OzBaH+XK1sAGQksVBoJxU+KSfqh9uUVe3h/ZuSLRod9VYEwC7APGpqCmSGSpRysoavcs18PyOsk7Z8x+w4WSqGtT+a9bwfJfMCowDEIVgCyz72a492YbOqm9nnmRWdjg9BZERuSsb7ZPHAcewjoqzG3heCah9V6VObQsyrlBtMOE3CB6ZnDcMyT7tbJLvVdQtRx+bTjs96ZMqt6kfx/BdnxZxn0MEpKfIss4UiGjkF6ycGC86acBH/KK0f2XLRDiZIDunJ2aWCKF1WHFg1bMLnhfTk385bhc6ylNd4n/viKDjlEkd9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCGu5N0lsnzCz8FIYttM56vGucMJOruAWAl4c96NA+0=;
 b=enUAZ9Uq70rzHApqvxfmVtvtYOUgwbbxp1J4DKIyBu1zX4Hy+FCSmmmuLXh2FhJvvSQQHETdL26fTDvxH7T05U9j3V2HoAvAWyskBpw8vOrjmQD49qKlwGazgqIbWIQuO4zYQPM0Ez8dPiRh2CCw6marw5JJYmlOpxdEsh1Z4JXo+K2Gnf1LcIXb8dyEBGXOXEH+Hl4BZgZWS8LXCuwLwU9DVgGqKzbEZt8bJ9/8Zl9XX+Lbv+YrVRZ+cbZpSM8ZLEO4sMkgqbt+O1KG/iBoD507DvQKuY3vqxvnkJdwAe1rICZnsoZtQnJjhYreZ5MBkfaHeXvmS5lZu4pE88Eq6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 18:26:08 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:26:08 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] sched_ext: idle: Honor idle flags in the built-in idle selection policy
Date: Thu,  6 Mar 2025 19:18:04 +0100
Message-ID: <20250306182544.128649-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306182544.128649-1-arighi@nvidia.com>
References: <20250306182544.128649-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0121.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::6) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: b20749fd-dd61-44a8-f5bb-08dd5cdc5d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xg+8NHJDOd1fPpeVL/R+7mX7v7fAnSelnxHamH9PBTJ48tZndUJjfXjCNecy?=
 =?us-ascii?Q?WFRRLHFhVvp5lgBT0ecZ0iWrUpo0dLYcKu0pperqe6zm3qS5ulp10TMloy2o?=
 =?us-ascii?Q?Vw8DP8EFCuIivtpKITqtN7uuP/03wvwesHCn93v29YGNF5BREJSQc1nQx2a2?=
 =?us-ascii?Q?hnOj6gDOHbdV/Es0nzQ2sQfKcZTPayOIvJlAGaMxxdyEzTn/fEZIN3MQMaVK?=
 =?us-ascii?Q?U9IvcdSAROJpJe/nzueSguEPdGzQ6SrPi0rtIAp0HDwQbz6Y1OQBCodMdZiX?=
 =?us-ascii?Q?E6rs43lAiWl7OrE7bWrn+6fnpXk1ORIx8/b9yJhyFINSArX/0BKLJ9JpCcUp?=
 =?us-ascii?Q?ciPzs6617F9A64fzRXIyP9cZMW62ZR0RslNkPu6nW4RKgzGgKTuvOdACnkOM?=
 =?us-ascii?Q?4c4OwJoYwcKt8/x5SCDD9sV9YwkEvCiGQgvSxWZw6ccPQSPmMaED4UjxiZAL?=
 =?us-ascii?Q?TbXE8zhFFuJAmcVeNnihyEubLUd67MfJyzMu4zSLR54JsUVYSbGaN8RERbdh?=
 =?us-ascii?Q?4XqhIGuDhqghfK1jCcpjUwlo8A/jlQD08U/cSXx8YtXJxnJ5tZh/4OQdHqLv?=
 =?us-ascii?Q?1qHM/dlcSzQ8yfdhSKimfH5AeTI5IVtHAx+yAurOtY4OBFcsiHAxe3MveblE?=
 =?us-ascii?Q?ToXsXcxMz2JPrHx05O6ysHowHbS6ERbUx0dNvggWpqRqektwmf1jsEyQzgt1?=
 =?us-ascii?Q?k2Aq/yBXUL/7AIHx3+XOsbXA+/ph7S5gZDW/EkgJTHGShxpu4ocs61yE2jJM?=
 =?us-ascii?Q?Vs9n/CEL8GpelEz1AMxLfIm2eqxRZb+MHXh0ULmxtAxSylRyR8PA/7d9ek98?=
 =?us-ascii?Q?kqGzTGrdtzqiBj6aRjB5bnQRGRhqbGR5pYWXMsqbp60nm83IocC6dLKgk3Bu?=
 =?us-ascii?Q?32HunGGLRw6emyO+Gw6JtplhOIr1F0i5Th76MSP/PJSMZGR1kzfyBlwKd3xC?=
 =?us-ascii?Q?kR/43fuUc3uz5TIT7TgfaUDOz4xpbgKP7yXE30GtIV5KfMQ6OOUtGYpWz0aD?=
 =?us-ascii?Q?UIPpZ+pi482ruv8Y0Kfqi58iHo/ug3wVnCs8P59VBlNhPEmbgE1h6IzMF/OY?=
 =?us-ascii?Q?rsVUfMoqGqHJWh2JN2N9rMII0J7/iCctCjFf6DxxQKR0arHj9CRmjTap2hDV?=
 =?us-ascii?Q?IewGTazYCtwp9nTZBZ+fhlevix8ie3puJ6iuAEqoMUvmFXnSRwE/0qyvG86v?=
 =?us-ascii?Q?HJUI7xeoEc7oL88SUE/5NvYYoATHSzBreE81xZ6ccHVLRxK30ULNwsip+buQ?=
 =?us-ascii?Q?TQ06REjqH9Yfahpybx2I4H/+a3FR7fLFZqoWpyqRdKjgnKjz1N5OeXoA+Ix3?=
 =?us-ascii?Q?meyntnMsYpFoOWFMAxI5kaMXg1tyE6V2QWZGKjN0Y1EqqAdCMH12Z774aQJf?=
 =?us-ascii?Q?iAc7xqXFxdaGYPqbV9qtHixNGbi4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jVBj0yj2q1M33Y5HLze8ax8jhKUX7cgEZpzCn/f2+D7BKPdud3jLttspA4rW?=
 =?us-ascii?Q?xPmbKZY+WHOBIBkPTkSnlDiBZFu2oukqDlPgUF1CFLo2ZCzXxFiitghFcXMX?=
 =?us-ascii?Q?pDwDapKuvKvsfuQ5No3yXsW31+u6RBvzlwloF43nSH2oUOUn4Mpw1oPPCQR3?=
 =?us-ascii?Q?ai4/dOo+pXF7Kk9JN3V6LNr+PLfAkXbVQRRfnTsgbM7lqezOh2uS6xr6gpTt?=
 =?us-ascii?Q?BA5K+BjdXXRovXvKio6MPVmG9oOHr6yLtZage4k9NNkCXyTuNQyE8+UJTu3S?=
 =?us-ascii?Q?epNuUp+qSjLgzp2MqR3q7+HnkusI6oY+YnVnje66TfzbRZmXbRD3kuZmF93Y?=
 =?us-ascii?Q?RmXYQNRQViKa7OHIew31cXtXihICNAqKTh0HxDmItBuy9dEA8HsdNymzt/No?=
 =?us-ascii?Q?O8rnSsjTyR4hwzFi7Gvaoledsg/T2jnL78VuANt8KDcAGYoJm67h2XQ428KG?=
 =?us-ascii?Q?heYfzVCIO+FTNx4/RQ9fjep+n+zjIW7X92oZArx5cOdTAHVn9FBkQ8C0/xXg?=
 =?us-ascii?Q?UVpIBMFhZCT1LknpHXpDFYakLXOfLn77uoTrofWsT08oQqYfqYWoaxFzRGdb?=
 =?us-ascii?Q?UaMhK6xDfo4y58MVTvuyEtsyv2aU72RgLWMm9/vSqb7BJlQfG+6wO+wp5DCi?=
 =?us-ascii?Q?kRyQo2gBVE4WsXwL/1BVhLZZNhH9WNXiGOv4rfjI1/4BbTbQqSMI4C+A0rKc?=
 =?us-ascii?Q?c8OBIUgcp42v5x/35dUATjl1sSVKUHq9BDLBI9epp9gmZoJz9vYkYKFzFR3B?=
 =?us-ascii?Q?aOc6TA9z7RtwRtscnSZ39EOfIZnan1x2xTptyk1a0cTLUaDcV2UuQnmQSTZU?=
 =?us-ascii?Q?fIvlBHfGJIxJBtAr5Y43+xijUUagZvGsfyZUL5Nw6wXF9W3z3/2xmA/Dt8ht?=
 =?us-ascii?Q?IPdRZ81mJiv23l+yBB6FsXmn6cIzU4Q9n08g9DsmicAIkx49TcAtv4+E7Lk5?=
 =?us-ascii?Q?Z73CcP3n3l37JS6ddSjyrDe+UM/QcougWi0dAdf4yZDOo80yxy8+wMV+Afui?=
 =?us-ascii?Q?X9ofFThtk6IQUp71yiqf7plewCsKjj4XWuWqYdu/Vv2rrcpowyEHtArr6jI7?=
 =?us-ascii?Q?LqqMrFe9VxInzU6jL7zGduDRTmrcwnM/MKnPcRMCSRsB4ravRzRL3Pu80Z3G?=
 =?us-ascii?Q?sgh/KXzdf1o8i192f5+7CqyzOWd44kNk/4xGPRpGIlNSWZBtCzwvk8UqzUdX?=
 =?us-ascii?Q?WBKUlx+O7emNFjEKJ0B80JsMgL9/kLjElhPSzoHfyF2oqwQiWe1PNNidKqpX?=
 =?us-ascii?Q?0SJAyqkDCHAt/EgcBHV9Y/vSQnIVe/TmAlMjkrrTSyE1tRPIeSs/CkXvb2sT?=
 =?us-ascii?Q?SObQrT046tVHTAIUzkNMkw70ZG3Zglif/bbdnx2XWRV7L4o3FgUVKOPBdCxJ?=
 =?us-ascii?Q?tsfLfff5K6hivaJj8tejO1mI8uPmB2PzJV7aVgJhAJMXXz0HSnn+chj3GXTz?=
 =?us-ascii?Q?svXcoDRs6HrkqTx08OVUnwOTsQgPbA+FugTvWizrvN3xMlpeFUG4bO7Yuf+D?=
 =?us-ascii?Q?6mhr1W+d4pQ7elyTEYHSUMzn0SBngFiqFQUUrbNn0LO2fNfrJdMj7Ulx9JuH?=
 =?us-ascii?Q?WH5lYNgNnk+rVe9qBe9kBrf3zL5BoF7+x2UyEt3R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20749fd-dd61-44a8-f5bb-08dd5cdc5d18
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:26:08.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQ1S2wRIm1ayGc66+Wm58B2qJof2GkqvmnqmEe31vVM2Wc0MjdC9DJmFSrTRTY3UPC5ReHsjl3QPp4LcgI53YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

Enable passing idle flags (%SCX_PICK_IDLE_*) to scx_select_cpu_dfl(),
to enforce strict selection criteria, such as selecting an idle CPU
strictly within @prev_cpu's node or choosing only a fully idle SMT core.

This functionality will be exposed through a dedicated kfunc in a
separate patch.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |  2 +-
 kernel/sched/ext_idle.c | 41 ++++++++++++++++++++++++++++++-----------
 kernel/sched/ext_idle.h |  2 +-
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index debcd1cf2de9b..5cd878bbd0e39 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3396,7 +3396,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		bool found;
 		s32 cpu;
 
-		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, &found);
+		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0, &found);
 		p->scx.selected_cpu = cpu;
 		if (found) {
 			p->scx.slice = SCX_SLICE_DFL;
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 15e9d1c8b2815..16981456ec1ed 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -418,7 +418,7 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
  */
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *found)
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags, bool *found)
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
@@ -455,12 +455,13 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
 	 */
 	if (wake_flags & SCX_WAKE_SYNC) {
-		cpu = smp_processor_id();
+		int waker_node;
 
 		/*
 		 * If the waker's CPU is cache affine and prev_cpu is idle,
 		 * then avoid a migration.
 		 */
+		cpu = smp_processor_id();
 		if (cpus_share_cache(cpu, prev_cpu) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu)) {
 			cpu = prev_cpu;
@@ -480,9 +481,11 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
+		waker_node = cpu_to_node(cpu);
 		if (!(current->flags & PF_EXITING) &&
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
-		    !cpumask_empty(idle_cpumask(cpu_to_node(cpu))->cpu)) {
+		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
+		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
 				goto cpu_found;
 		}
@@ -521,15 +524,25 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		}
 
 		/*
-		 * Search for any full idle core usable by the task.
+		 * Search for any full-idle core usable by the task.
 		 *
-		 * If NUMA aware idle selection is enabled, the search will
+		 * If the node-aware idle CPU selection policy is enabled
+		 * (%SCX_OPS_BUILTIN_IDLE_PER_NODE), the search will always
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto cpu_found;
+
+		/*
+		 * Give up if we're strictly looking for a full-idle SMT
+		 * core.
+		 */
+		if (flags & SCX_PICK_IDLE_CORE) {
+			cpu = prev_cpu;
+			goto out_unlock;
+		}
 	}
 
 	/*
@@ -560,18 +573,24 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 
 	/*
 	 * Search for any idle CPU usable by the task.
+	 *
+	 * If the node-aware idle CPU selection policy is enabled
+	 * (%SCX_OPS_BUILTIN_IDLE_PER_NODE), the search will always begin
+	 * in prev_cpu's node and proceed to other nodes in order of
+	 * increasing distance.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
 	if (cpu >= 0)
 		goto cpu_found;
 
-	rcu_read_unlock();
-	return prev_cpu;
+	cpu = prev_cpu;
+	goto out_unlock;
 
 cpu_found:
+	*found = true;
+out_unlock:
 	rcu_read_unlock();
 
-	*found = true;
 	return cpu;
 }
 
@@ -810,7 +829,7 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		goto prev_cpu;
 
 #ifdef CONFIG_SMP
-	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
+	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0, is_idle);
 #endif
 
 prev_cpu:
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 68c4307ce4f6f..5c1db6b315f7a 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -27,7 +27,7 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node
 }
 #endif /* CONFIG_SMP */
 
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *found);
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags, bool *found);
 void scx_idle_enable(struct sched_ext_ops *ops);
 void scx_idle_disable(void);
 int scx_idle_init(void);
-- 
2.48.1


