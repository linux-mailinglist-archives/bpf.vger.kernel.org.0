Return-Path: <bpf+bounces-53611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8258A572A8
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CCB3B7F82
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E1F204C2A;
	Fri,  7 Mar 2025 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dq07eFeb"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6592561A9;
	Fri,  7 Mar 2025 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377940; cv=fail; b=qQdbhjqBgv862BXRZZXEdJFm2EAo819wJ6rsGYQPNLGMgf12kEYjLWVnVqqHY4iD+FgVy6ZAhPQbp4tzQxPCtY0jhMu61zoF+A7O0ZBm/BYolW1hL4cGfiuU1ypzhuibSU/iNtnxWd1Lf8fsLIF9nFg7lkq1r8Qq9mSCFFVyRuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377940; c=relaxed/simple;
	bh=/GhLnLOCdmMJ0U1HO805kp559ADOxkw5/gGfVLjQAws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s2UPhZLZwqcgYvwCA5Vsho1loY++vPugmc2ia/AP1dlioHwuYaXRy5UNXyKngwarmV9DC7VvN407JAVOxFU7xLJm8DSqaQD+FhMzz0pF5nZtcShZNQWaM4czdLFRAsc3Mi7hsmtqimpz0yXBq3ln93AjdmEOyjqw7AZq6EO5y00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dq07eFeb; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en2PMsTnO5kl7Zle7QvfaEIc1EvAHir58EuCGA/lIn1UzzVmDwNampA/6qwRCicMCIVMCOB+aDOVvhCY3lUsTyMy3OBaJlf61+uDUCMQ2Dqf67fNsKkYBj4WRJxWju9gcsE9TmWZH4m0by/fp++ANYA6z+ZU6MWNlkFBA0tawTsaupn0zveFSkeyaeGVPVKeNPvwUXxJ/OlK2yZehH+cE5VHJOGhUKPdTbGDuDi2CnYEVJ27FL1b4wK/ZyknPbHXazadrdtRhKGGnJWLjnI9DtVMqk8eLjgAMTws+xuDx5SKPBQqJMbPFabs9f2QZwvrA9HstKMtPqhJVzNxmW0XIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsyEIjBQW5rnBIkr4w2LptpsXbn0z6KciEOIeaSFzGA=;
 b=sSsvaCgrL591IveeBFZNXoZjn74QbdJEcYlytzBlXss0gdTXq1qBrkBWlWHffMMBvgA/BrrthS8kG26N9hIvSivX35zXMPpy2bHz6VKPqamtrFPCkTmsTMpgu0Rg41nRdIVLNsDRVY/AjQQSBwjulDpksq0W70e2JODpoLcqo89aFMJWRVi122TLlYfcH4w1Bze6uXjNUV/BZrqZftuPNp8rTRKxVWd7YnhJEdTpdyabD+s7CIsGQj7hWpfDXipK5DYemRIvMtx9MV2BXstBanqec+RnCy7X9Yd9XtTAL8UI+0udqkkVtpz5rm3J3qUnFMpMEZ1ofRTZQ50gXPKwng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsyEIjBQW5rnBIkr4w2LptpsXbn0z6KciEOIeaSFzGA=;
 b=Dq07eFebUDNLMA8lXBx5fTcc4ni8tc18rQvotc1Tcj79QY8g2UTak7GVPyTxf0U/VjcurNvhkmFtJda/czJ1hqKrNwZQO5w2/E1VRgVy3xMypgKZR7lTZn7EPXQMIfq4XBUsAtmJ+fgTLKXxzrPNz9RHfOPlNESbv4foIFk1OcU+fH16uhWnvQi22weJYDR3yRlLogjhrjeQkxcE7kVqoNSh0mvOdTmpoJs9ziz/ghBbUYxDPIGV4URxRg2hZ930eiQ2B+1lMBsSrY6kcMwWTwN4xCy1sz9GnJPDdEksGEIl/3ZzA5RnC7B+NHiKH2h87BoOLeVc2gAxjRY0DDF44w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 20:05:33 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:05:33 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] sched_ext: idle: Introduce the concept of allowed CPUs
Date: Fri,  7 Mar 2025 21:01:05 +0100
Message-ID: <20250307200502.253867-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307200502.253867-1-arighi@nvidia.com>
References: <20250307200502.253867-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 66085a62-fcea-4813-9f2d-08dd5db36b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5NGydfYkPxKzX5N5MrQUnwzDce5pbWR6WTuRVLzmpcijE+U206QT7UgiCWhx?=
 =?us-ascii?Q?iULSrIbsL6lXH2SDAdzB32Elttme8szoh7yiUWg63m+R8gSmMtlMBWG+JpO5?=
 =?us-ascii?Q?hZk7346kHIjcP1EDEOcLeeO3UUA1Ibs+xCky50LnZmamzTTXtnYIMNa27Pbf?=
 =?us-ascii?Q?qI8ZFCVlLM26y3wXPv1eJBSmhjNcIAu7eBS8Qn7g/VCk0l3+RGneHbzTbTdC?=
 =?us-ascii?Q?zIwCvjNU+7DDf+mW7JOtSssFv7VOcwjO8QGjQX3E9I79e+Gw8teHtB7UBCuo?=
 =?us-ascii?Q?dxsbYtlLKPZGjYBMujBYUqSkMo7RZF32dnoJfgM1y5UWK0KA+RrAjIq/emM+?=
 =?us-ascii?Q?0joZGco1Mc1+YYiKFqglMZnnICc7JHvNrJuE6UnujFE6hkcMv/b+noae6Uhg?=
 =?us-ascii?Q?aIqjXYL6W+/bHDxo8F7rptSQv6Wp87ZjjAgfbVHu+XDwmT0zHtxOlXs1ybAm?=
 =?us-ascii?Q?UjIlaPIrBABOUSRHzsBeHqkkXt8HMU2vmk44OY/hobofRAWAtZMsi4PkAZiZ?=
 =?us-ascii?Q?c7ffqlq3i4FPGdkgQmrxIVP8RCBzvUrDNqbXxsMTWM5a4zdVeAd9f4/B3waQ?=
 =?us-ascii?Q?foQ1Cgp2jwJEA1ZgDrDLvY1SYSg7n9BFfX/N+d6I/wzHDyzAqLcSdH2HbHrS?=
 =?us-ascii?Q?pxPrKtm67xA5t3LLTPOvyt33FpSbSYECUWrhrDRI2LLisxoAQlR4SaSlSik0?=
 =?us-ascii?Q?uPBOug97krWjWhYq1olAVZceBEDDsCMQCF1qnBmhPrafYLxanaPplllcLEDA?=
 =?us-ascii?Q?8NC80ouxWEzKhjj7OzPQMQbN1xT2wnR23zq+QRDAmBX5urKZX7q6iVqyHNIW?=
 =?us-ascii?Q?5T2ZVkOUJMjrbtAzsIp+kOGlvsMcik9U/cuw9UWT8Wiig/OrXGVb6i4/0/oj?=
 =?us-ascii?Q?XSxCK3u/Ca8P6W37TzubDU045i0a0ouN362eX1m/UB0Q8/mXEzVOKR0WcMqr?=
 =?us-ascii?Q?kHt/1Z9LU5tDI7tHJS6k6KV0JIXDRRfBWblS5jr9FQ99LLLeKE1mQyGchjFt?=
 =?us-ascii?Q?UlY06gIsWGNWXeFPKd3uNMVmuHKQNvO/bJm2zFGnLpTt9xk4g+WKEH2fFfIT?=
 =?us-ascii?Q?Z9pMyFbfSWxHc3/ayaGhZt9JJ+XFhI6Z2jBigv5iGTnLkznzPal51K/sjPJr?=
 =?us-ascii?Q?Qn0whjmp9xxdNXVeuhqGr7bLvmw9aNtL5mNwhz6GdSWKKMiQuQY5hQF4PMmA?=
 =?us-ascii?Q?gs+78Uo2N33N3N6NE00ADnAHJAGVnlzDskBsPbv8+yxXxfZAG45QpgINoPHF?=
 =?us-ascii?Q?ImoU4JGY+lZmRlB0vbAT29GSq62B6EhyIkDXjxpvBuuOFlYHAJF6nIbZm/Tf?=
 =?us-ascii?Q?ZPrt256RLIm9xA5pOvBOCkejAY9WHq+OifvX9S+uSgft/pPoY3J16JXEcS6o?=
 =?us-ascii?Q?/xQFZoxB6okY6WnV3TRlHchUu8ks?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/VWtixpCzcibF/lwAwszn/+oVE3HAfwWSsQnDxGvd48AnDTE+2uKzqhbtqKl?=
 =?us-ascii?Q?KQWEShGAgEPts8tentELFUZ20FWWz6GOtgYiP8jpazJvEBg6vjOffdAa8wuX?=
 =?us-ascii?Q?FGJrQasOBwcW359sitM0XzyFf5txOPvwW2P0HbSo5Jsvg17cO4Abf64ROInY?=
 =?us-ascii?Q?jghuNhold2G9AFxEd/TPoWO+P0Qedwvwmtu9KCO1/P5vfgAcc02eYI72solo?=
 =?us-ascii?Q?VfUeCKcGjFn00hTrNOJwqSTOdq+K7duhyDNxZWhsCz5hyBe0a3Ax9+BP/Mte?=
 =?us-ascii?Q?ujFYFM3ItUrJCVZiHRbAUvhgsTTIUUmPgRSRqHTGcpAGLBcSvO2DvrWlGFBP?=
 =?us-ascii?Q?KI81ZtV+Ol+lYuHJglL863O29ZUawN5/e8NPEZvRk6TyvCw/ysRmOCqcqS+E?=
 =?us-ascii?Q?UAK7oeSuCXds+BHFJTgmePI9fBmO4UnukX9pwYUYbehxvQiMkFQ8u1D1h5hK?=
 =?us-ascii?Q?r7b5RRLXv4iOeb97Jgk+hcunCmmqO+qq45E/qe6BTBpEhGBB3OuHbf87A2c8?=
 =?us-ascii?Q?1Qx0VvsE7EJAjFApBU8K/VXv8JvRcPKUOIHAtsEL+QowiS+/4F6MWGpmEf/Y?=
 =?us-ascii?Q?ER4BYjPQYbl3fgo/BqOpwq7p4xMa9KvXtpQrSf06+gYxxwtl6hpkFLHIC1v6?=
 =?us-ascii?Q?RjMCuRzRfkvHJdhkhvUwZ3jf/sBKYqJqqbOjbZEFqpkD+A1wOCB0UcG6zhbl?=
 =?us-ascii?Q?GSlHYB6RZkrH8YmTiXxoX96VMdLqVwEASt2GSoMq4BIMB0QgOq/ij1YWIDnY?=
 =?us-ascii?Q?NkKU+wrCpesvtKZ4hMVlOtOpaAPqw/j8du6d/95X0gPIZG3i0K2x94xB/6Qz?=
 =?us-ascii?Q?z8rbHmmXbUb2lBsTWW9IHEZ6V/jnfVkT4OO4KGjax0HkSDEqPZ/zH0GRJKuF?=
 =?us-ascii?Q?fwz/TmHrpHDfbOuWA9E+c/+rFWcwhBsbkYocMaKOGLV7HYbO8qzvGNnUf1E4?=
 =?us-ascii?Q?4NAbrUIiYJAwVA4A/O46jINpBLb9dZa+3vXz7wT0d5jTtkH/ryz/atTtqb3D?=
 =?us-ascii?Q?ZCnbGVBvm2+oN9N/ea9ND7e8PoBurGEXYcJ+JOBBBP0cNgt4n3CnAT2FH322?=
 =?us-ascii?Q?nnHLT7SOLDqPdscOMGU4MIsoZG5XPT/qeSoPPByU78JG3CfDII+fr1fyMoTl?=
 =?us-ascii?Q?CmI+EOJkWnFbKE10sddlmpwL70j76J0cW9RcDnlo3hiFrg9VGQIz2fAbFjMG?=
 =?us-ascii?Q?D/XhguEDnaJQKQWNXQQDADKwCBC+oZA3/Aw8xHmxIDYMg+raecJciSCrVVZP?=
 =?us-ascii?Q?izrsdhG8wnP29gbJH6L5F/yVkvZAZpssUaq1DI4vN6Sw4DuEL6oeTeONlu4z?=
 =?us-ascii?Q?ZnqZCnMYgCPlLuJIxiWb+dwmQnT15DVaLqRZo9ZkHVw4KN5PLOven4kkPrpD?=
 =?us-ascii?Q?VpMOw0rl+caJM/fh/To7AG/xWaX4Wx679yOUt3myKXWcjDVBhY3VveDaDoVP?=
 =?us-ascii?Q?S9zw96JaiDDpO7ttg5FcgFpG3tAA6TyXPoyA7w0yjUsVOTZ7Zd/9bFwS50Rl?=
 =?us-ascii?Q?NxeNj6NhVECwuiRu0glqjK9RbSXhMTufkpbW8mhdT3mFI+UQXdpU/4WXQ9oG?=
 =?us-ascii?Q?Mf7aNmT8L+2LACDqbqdrz3yHh5hbcBEkWORnu6uo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66085a62-fcea-4813-9f2d-08dd5db36b5c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:05:33.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jfol53BTkdqJzDgxTJkkp5T0CGdIqkPctAFhGLCzcz0CkZGsT9+EOq9Lakpu66bTpJe9iwBjGrkQHhN2Nzd0EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554

Many scx schedulers define their own concept of scheduling domains to
represent topology characteristics, such as heterogeneous architectures
(e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
specific properties (e.g., setting the soft-affinity of certain tasks to
a subset of CPUs).

Currently, there is no mechanism to share these domains with the
built-in idle CPU selection policy. As a result, schedulers often
implement their own idle CPU selection policies, which are typically
similar to one another, leading to a lot of code duplication.

To address this, introduce the concept of allowed domain (represented as
a cpumask) that can be used by the BPF schedulers to apply the built-in
idle CPU selection policy to a subset of preferred CPUs.

With this concept the idle CPU selection policy becomes the following:
 - always prioritize CPUs from fully idle SMT cores (if SMT is enabled),
 - select the same CPU if it's idle and in the allowed domain,
 - select an idle CPU within the same LLC domain, if the LLC domain is a
   subset of the allowed domain,
 - select an idle CPU within the same node, if the node domain is a
   subset of the allowed domain,
 - select an idle CPU within the allowed domain.

If the allowed domain is empty or NULL, the behavior of the built-in
idle CPU selection policy remains unchanged.

This only introduces the core concept of allowed domain. This
functionality will be exposed through a dedicated kfunc in a separate
patch.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |   2 +-
 kernel/sched/ext_idle.c | 128 +++++++++++++++++++++++++++++-----------
 kernel/sched/ext_idle.h |   3 +-
 3 files changed, 97 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8c9f36baf7dfd..1e9414ffeff01 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3395,7 +3395,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 	} else {
 		s32 cpu;
 
-		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
+		cpu = scx_select_cpu_dfl(p, p->cpus_ptr, prev_cpu, wake_flags, 0);
 		if (cpu >= 0) {
 			p->scx.slice = SCX_SLICE_DFL;
 			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 4f8a6e46a37a4..9469bf41fd571 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -46,6 +46,11 @@ static struct scx_idle_cpus scx_idle_global_masks;
  */
 static struct scx_idle_cpus **scx_idle_node_masks;
 
+/*
+ * Local per-CPU cpumasks (used to generate temporary idle cpumasks).
+ */
+static DEFINE_PER_CPU(cpumask_var_t, local_idle_cpumask);
+
 /*
  * Return the idle masks associated to a target @node.
  *
@@ -391,6 +396,21 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
 }
 
+static const struct cpumask *
+task_allowed_cpumask(const struct task_struct *p, const struct cpumask *cpus_allowed, s32 prev_cpu)
+{
+	struct cpumask *allowed;
+
+	if (cpus_allowed == p->cpus_ptr || p->nr_cpus_allowed >= num_possible_cpus())
+		return cpus_allowed;
+
+	allowed = this_cpu_cpumask_var_ptr(local_idle_cpumask);
+	if (!cpumask_and(allowed, p->cpus_ptr, cpus_allowed))
+		return NULL;
+
+	return allowed;
+}
+
 /*
  * Built-in CPU idle selection policy:
  *
@@ -403,50 +423,83 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
  *     branch prediction optimizations.
  *
  * 3. Pick a CPU within the same LLC (Last-Level Cache):
- *   - if the above conditions aren't met, pick a CPU that shares the same LLC
- *     to maintain cache locality.
+ *   - if the above conditions aren't met, pick a CPU that shares the same
+ *     LLC, if the LLC domain is a subset of @cpus_allowed, to maintain
+ *     cache locality.
  *
  * 4. Pick a CPU within the same NUMA node, if enabled:
- *   - choose a CPU from the same NUMA node to reduce memory access latency.
+ *   - choose a CPU from the same NUMA node, if the node domain is a subset
+ *     of @cpus_allowed, to reduce memory access latency.
+ *
+ * 5. Pick any idle CPU within the @cpus_allowed domain.
  *
- * 5. Pick any idle CPU usable by the task.
+ * If @cpus_allowed is NULL, the task is allowed to run on any CPU.
  *
  * Step 3 and 4 are performed only if the system has, respectively, multiple
  * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
- * scx_selcpu_topo_numa).
+ * scx_selcpu_topo_numa) and their domains don't overlap.
+ *
+ * If %SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled, the search will always
+ * begin in @prev_cpu's node and proceed to other nodes in order of
+ * increasing distance.
+ *
+ * Return the picked CPU if idle, or a negative value otherwise.
  *
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
  */
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
+s32 scx_select_cpu_dfl(struct task_struct *p, const struct cpumask *cpus_allowed,
+		       s32 prev_cpu, u64 wake_flags, u64 flags)
 {
-	const struct cpumask *llc_cpus = NULL;
-	const struct cpumask *numa_cpus = NULL;
-	int node = scx_cpu_node_if_enabled(prev_cpu);
+	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
+	const struct cpumask *allowed;
+	int node;
 	s32 cpu;
 
+	preempt_disable();
+
+	/*
+	 * Determine the allowed scheduling domain of the task.
+	 */
+	allowed = task_allowed_cpumask(p, cpus_allowed, prev_cpu);
+	if (!allowed) {
+		cpu = -EBUSY;
+		goto out_enable;
+	}
+
+	/*
+	 * If @prev_cpu is not in the allowed domain, try to assign a new
+	 * arbitrary CPU in the allowed domain.
+	 */
+	if (!cpumask_test_cpu(prev_cpu, allowed)) {
+		cpu = cpumask_any_and_distribute(p->cpus_ptr, allowed);
+		if (cpu < nr_cpu_ids)
+			prev_cpu = cpu;
+	}
+	node = scx_cpu_node_if_enabled(prev_cpu);
+
 	/*
 	 * This is necessary to protect llc_cpus.
 	 */
 	rcu_read_lock();
 
 	/*
-	 * Determine the scheduling domain only if the task is allowed to run
-	 * on all CPUs.
-	 *
-	 * This is done primarily for efficiency, as it avoids the overhead of
-	 * updating a cpumask every time we need to select an idle CPU (which
-	 * can be costly in large SMP systems), but it also aligns logically:
-	 * if a task's scheduling domain is restricted by user-space (through
-	 * CPU affinity), the task will simply use the flat scheduling domain
-	 * defined by user-space.
+	 * Consider node/LLC scheduling domains only if the allowed cpumask
+	 * contains all the CPUs of each particular domain and if the
+	 * domains don't overlap.
 	 */
-	if (p->nr_cpus_allowed >= num_possible_cpus()) {
-		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-			numa_cpus = numa_span(prev_cpu);
+	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
+		const struct cpumask *cpus = numa_span(prev_cpu);
+
+		if (cpus && !cpumask_equal(cpus, allowed) && cpumask_subset(cpus, allowed))
+			numa_cpus = cpus;
+	}
+
+	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
+		const struct cpumask *cpus = llc_span(prev_cpu);
 
-		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
-			llc_cpus = llc_span(prev_cpu);
+		if (cpus && !cpumask_equal(cpus, allowed) && cpumask_subset(cpus, allowed))
+			llc_cpus = cpus;
 	}
 
 	/*
@@ -484,7 +537,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
-			if (cpumask_test_cpu(cpu, p->cpus_ptr))
+			if (cpumask_test_cpu(cpu, allowed))
 				goto out_unlock;
 		}
 	}
@@ -529,7 +582,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(allowed, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto out_unlock;
 
@@ -577,12 +630,14 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 * in prev_cpu's node and proceed to other nodes in order of
 	 * increasing distance.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
+	cpu = scx_pick_idle_cpu(allowed, node, flags);
 	if (cpu >= 0)
 		goto out_unlock;
 
 out_unlock:
 	rcu_read_unlock();
+out_enable:
+	preempt_enable();
 
 	return cpu;
 }
@@ -592,7 +647,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
  */
 void scx_idle_init_masks(void)
 {
-	int node;
+	int i;
 
 	/* Allocate global idle cpumasks */
 	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.cpu, GFP_KERNEL));
@@ -603,14 +658,19 @@ void scx_idle_init_masks(void)
 				      sizeof(*scx_idle_node_masks), GFP_KERNEL);
 	BUG_ON(!scx_idle_node_masks);
 
-	for_each_node(node) {
-		scx_idle_node_masks[node] = kzalloc_node(sizeof(**scx_idle_node_masks),
-							 GFP_KERNEL, node);
-		BUG_ON(!scx_idle_node_masks[node]);
+	for_each_node(i) {
+		scx_idle_node_masks[i] = kzalloc_node(sizeof(**scx_idle_node_masks),
+							 GFP_KERNEL, i);
+		BUG_ON(!scx_idle_node_masks[i]);
 
-		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->cpu, GFP_KERNEL, node));
-		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->smt, GFP_KERNEL, node));
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[i]->cpu, GFP_KERNEL, i));
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[i]->smt, GFP_KERNEL, i));
 	}
+
+	/* Allocate local per-cpu idle cpumasks */
+	for_each_possible_cpu(i)
+		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_idle_cpumask, i),
+					       GFP_KERNEL, cpu_to_node(i)));
 }
 
 static void update_builtin_idle(int cpu, bool idle)
@@ -825,7 +885,7 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		goto prev_cpu;
 
 #ifdef CONFIG_SMP
-	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
+	cpu = scx_select_cpu_dfl(p, p->cpus_ptr, prev_cpu, wake_flags, 0);
 	if (cpu >= 0) {
 		*is_idle = true;
 		return cpu;
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 511cc2221f7a8..977f49905f2c7 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -27,7 +27,8 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node
 }
 #endif /* CONFIG_SMP */
 
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags);
+s32 scx_select_cpu_dfl(struct task_struct *p, const struct cpumask *cpus_allowed,
+		       s32 prev_cpu, u64 wake_flags, u64 flags);
 void scx_idle_enable(struct sched_ext_ops *ops);
 void scx_idle_disable(void);
 int scx_idle_init(void);
-- 
2.48.1


