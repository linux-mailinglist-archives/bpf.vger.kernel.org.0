Return-Path: <bpf+bounces-47434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304819F95B6
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F37188EB9C
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A6321C19B;
	Fri, 20 Dec 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NVXvoQhG"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1806221C9F9;
	Fri, 20 Dec 2024 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709318; cv=fail; b=etSsQuXmTQMT8bjtmBYmB97uBqctIYhX/kdRhKSQjkfLspJ9twSlhBUaw/CUmL+/28GiO2P5cSZH0JfcbvVe3WLB7w200Rd02Eb+8f/4CKaIj7vJP+ymKPLi41it5xam02PKKyXCZbHbdgOGJvLWECEr9IpEEAW4F/mmiZLIl9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709318; c=relaxed/simple;
	bh=ESQcF1i56YYgYIeb0Crfwv/4aAPjSVs3lWR2OU4E74Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+nJPYUJ8H+eIVx9/OGZspwJkDuFh0zMXce9aH0GLTaDbyLcpW+Z0Nax1KR+IUEqFw8F32PLSqCMmoAnF7w9+XoBNMu23zVpfqiHq69v4ZPu0hokVtf9maPcuaTnPrBm1pb1zIuKedlUaAS0nO9ZIfJ7/wNYmgdX5LIfpuaen2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NVXvoQhG; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvk7al2RushLuGtQev1Z9iqRGzRdshakp36fR5rbNv+ruvOBYYAnWDtfxobeHSSPuTjKlLlTY1QtqbmeQxhr1a0UAm2WIDH6ys7WXa/Rm6pTuiZwaszQTw4v5rb+G/CqEEG1KwilOQq07cVx8Kk+DWGicBclUthQyildVBh8AelUjQZhkQIKdQhj3hThRYTkjxY70+EdAXedPaGCZ1YwF52Wlp8NQ1e6VBMssU0xMjQAubhhssUvJB5dsA1SBDNQAMaPDeGl1e5vmWm2hKI6O8EnlJBAyaKCQlFdKYEHRs8tTBf5KB06GhjVawtQyKGtwi8EWcrN/ABWEefwI7WEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRXrXTMMNrCTkmDj6IgGD9v4tudpGN3CU+dmB3C8qxw=;
 b=m6UqioeSpQHbN7WIyzVyVY4fg/4G/GPRNCfITMowJ0jRox4LiBYoYW6P8nrFUZOkbakPpfWC7zzZYIHaNGP35q/kSkImrGO4EMEvSMeoJczFawCqNySxVfyIdg8pEUW6CwimkVuj6qcGH1Ore4ZAUXgMhjvVJpscBoaVLNDpaiGiSJ/+UirDWTF200UH/8z1K84uFDbCpvvcwcFg7qBnzwWeFn2OGcrOjYJLlSdH+BpmD98IRMpjH9Scrhnax49S3EoHd1xne/wCGUZ97juldV2E9f7CBDy+Qw9/0ZH/NRralqoBxhvKC7LLr4tdhSBKVUDLEGDQ8Wl8Dg3Fjz1Rbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRXrXTMMNrCTkmDj6IgGD9v4tudpGN3CU+dmB3C8qxw=;
 b=NVXvoQhGhbVapnGeV7/qSwlUT5Gpm0rAdT9vywlZBtrPn6osH/Dd+lAaMDnKrudQ6VLXHo7FTaE8SDr9INIsMUm0G/fDhs5TEBy2P1IplNdiASsCfFtHMeiv0K7LLOabcLKBjReBZ9suIyQRT3rRGKHtO2XgVchmqjRNYxEddAx7dvVdzLlpfNZ90J+Pd/2n5uXtkb3Fo/E2Dvnyb5X3AqLXRl4EmCkhQTblnqp2kmg+vncWZfGYWTqNG+J59devo+ZxqKvHBV4y2GYnJUuA9mm5yaIJkDuAQ3fm+DW8reQVDEbyTl1s9yjFgGfHYvyofWHH1jd3opkRgaUjCxqwvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 15:41:54 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 15:41:54 +0000
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
Subject: [PATCH 09/10] sched_ext: idle: Get rid of the scx_selcpu_topo_numa logic
Date: Fri, 20 Dec 2024 16:11:41 +0100
Message-ID: <20241220154107.287478-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220154107.287478-1-arighi@nvidia.com>
References: <20241220154107.287478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 84759d9e-8b26-4019-ac6e-08dd210cd443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KcD5cu/jPtBfWeM2ezQWpQvqL1cupNsTgQ7Uv435zfGjJaiYYhqFIOdH58/T?=
 =?us-ascii?Q?OjGEQ0A4IeiXetVSUOYFbrg5PS327sgUVRF35uFQWK4D9Hcn/0Zov0o9Gr/B?=
 =?us-ascii?Q?4chqBmRCPjmQE6rrStYuAEGAxNSCUXW7RaqwHxObTJpNluOAM7+GYtdpqQxb?=
 =?us-ascii?Q?2Pd1iwKA750+bbzkFq8yRp1+nM0HegocyFVVgULcCg9J4f6M7vtfWq5VvIGt?=
 =?us-ascii?Q?n0NFtM7tW3X+Yb2DQpgDTF7867iYCiG5eoyFp++xxAEoAzNr8ZaL5LrKM9X4?=
 =?us-ascii?Q?S8Km31Kay8W8fsdjCO0oWOWuYVKYF6g2yknXNqdD6A6qPL1rKuZT9L+KQUQJ?=
 =?us-ascii?Q?slDoXwrhN2IrBESz9EVYFHvcWNTrkjKsMpc72Ez60TQbaqp8h11V3Ad6kQI8?=
 =?us-ascii?Q?NJtGy7A8y6r7Fgy/7zXFBd1BB3ZIIxuN92AOjCJF10hPEqURX9GAiHZDMpWP?=
 =?us-ascii?Q?juHe+f8okRghSN0zN7tGaxP4GE1Ak3LpxDG7c/lX/h/N52nzxeGxk61nmrIx?=
 =?us-ascii?Q?3x2EK1ssnAcON2Yn4GTY1vcrI+9DlTqNt68ne7V1D+uU72IR/zMss3gLapwH?=
 =?us-ascii?Q?26DuhRCO92vko2hoIDFXQ9wbIBgW5Mx2QE6B7CILK064+AV7TLTTGKbHs7Mr?=
 =?us-ascii?Q?m+gXW+S+xGFSpdLwG6j+BDmdekLOy2oYN6zhJAB0JcbTVuxpk9sPmMmZw10m?=
 =?us-ascii?Q?UWkOd026zuDICWWzoSoNmWjt5j8qNJ7yFNuJLDc0OgwMwu3XyIndMxuZtOcM?=
 =?us-ascii?Q?Xyp4rhVKh4B9/2V66lr83nwT6nKbj9fHlyaeqkAVf0lwTBMeqeP0Lh6dpnfu?=
 =?us-ascii?Q?jWcTnNR6U1Dzbv5VwoxCAqFdqjMd8ZpYC2B5GMlZ+LurXIir8oPic+v+tXfi?=
 =?us-ascii?Q?Oo8scr6yArNTfQDL+SZjDzfsy/QQB+CNseFwI5rOwrQ546vzAkcwpV77ldYH?=
 =?us-ascii?Q?HTEF05k/b0G3DUsg4teLehz4XgqkVmtccrFeeUb+cHsF9u5nusgm6caowsXm?=
 =?us-ascii?Q?eHaqkNLHBYhb5zE3U0jeHQ25D0Pe6pWrscJWm7E1iVt7hyxGi2n155W/hJl8?=
 =?us-ascii?Q?629DTG9bjYZV9NlSrFaTZ8mh5+G3TIJ7L1VRF827OYc3oZgRZXAo/PS5ENA8?=
 =?us-ascii?Q?TdXfVdgxNJK7orVyAednBSCEbnTsxdwrZv3Mx9L4cjtFuww+Xs8/fLMF5ao3?=
 =?us-ascii?Q?HOTCzelPOQc3CQlDoMlUjiA7XTzPrWbIb6UZywBQVYabjHRTuNtbvQb7zp96?=
 =?us-ascii?Q?cVOvyMAJdTayUzSUwIP+QGvZTTTvSidpc0SXVpFWm13ZHWE8XQuOQUYmoM8D?=
 =?us-ascii?Q?ZfSVngEqdHwEzaVPqojj9q/dIcwd91jO9c/j9orbydMN1onvbvlPsZJ1zMMP?=
 =?us-ascii?Q?2ljq69wBfi2bzFXBldBQs1hHFh/O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DHGkQnc31vquAvFuNh+eH8hX5ybufk/0UdV4HzxyrKuyqO6ApsHNprFoDIVa?=
 =?us-ascii?Q?j5IifzQIsveN/Tp+7jdHE8fq7/76T+gQjnUsbpAm2P4LlnFk5XFMuqHi2+73?=
 =?us-ascii?Q?ksZKBgR3cT3Vpq3MQjiQm78e9tWtBDZcyvFy9q+uEmem8a0sAPs+1Hm735qz?=
 =?us-ascii?Q?QxkfkKip4wST41Jmy3FWit4j9Y9Xl0FFtAy6GcdAw+p/YtLJNEsWhKD5affK?=
 =?us-ascii?Q?VMUD93m6lxLTJudXJxXUacZfSUntcvWY34AtbocNgRqevSnjUlBS/NDAtz6K?=
 =?us-ascii?Q?wN+nSzlCICpyMl8L8VoJKRO9qK9VeXdlH0zZlnpW1GXwuPzP4WjgdUZJQmO8?=
 =?us-ascii?Q?Ncg2o5i6b1HONAKJKWiy7bhAlVJjCpj26HCd54ppjLyopjJKxD/S05hz9lIh?=
 =?us-ascii?Q?esFGG44NgLNRWf4KS204f2ErMckvCR63bNZOxxMIMsx0LDp9l8R+BzFx2aYf?=
 =?us-ascii?Q?RYXDxC+qQzTPCeJZ5N2MxaB1cmY2mO0wE33XyUoA7/y+zEzEHnUaNg9M/aHh?=
 =?us-ascii?Q?oM+BR9iO0o3/3IIBE7i6m9BsyE07kBAgPYcJ3HppcHbZgGLi6iOIeL17nQ6t?=
 =?us-ascii?Q?hRoFNkEP3D543JsHkTJvj58nCvaIJU8A/TnuNO4jsIZZ1DlbcPOV8DsNx1dt?=
 =?us-ascii?Q?RxKKFwntp39vFpVIYLsQTwAe0Z5Fpc+Imzp34/iVKlHZ11gBdwP1ZZKrPUS/?=
 =?us-ascii?Q?wwOTKtZPY03xANYjYEZXN25mGh9lQNP446gFGDKi97NZp4ClzgOI1WormPyn?=
 =?us-ascii?Q?YArcfrvf1EpELJAeJDE/ltpYL5iyE4ycasHgZxTm2dO2JYiHexvZzdO1W1Ep?=
 =?us-ascii?Q?UmUPQzlAVsIk2sYW7QpU1JEWddCaYX+Nf9d4xovi9VreXLd3GwgG25r3iaTY?=
 =?us-ascii?Q?GMUTQvf4k+ntX8dhPsmwVxkjZtfPtABVTqMFwL594GOIHnp3/qUJN1wTWO6s?=
 =?us-ascii?Q?UKY35/UQTiMFjkP3+RzoL6oGz2XKVOHMxJbST90Tm18t78MmPSjteV5MnBAj?=
 =?us-ascii?Q?CXkklDuYfy3P7N/YnVA+MQWRmrcoS5gNFJEjsP42Gc410xWOpOX11in8IrVX?=
 =?us-ascii?Q?EWaAUJOXe92rWyIK6I749NXi/Miik3qzwQp+RJhhJGp4DefVBjGnMO8V1Emr?=
 =?us-ascii?Q?j+YAUIp/UTU0IU8ml2LpIq9sNUzIlNf6o9xGRYygtBrI2yjTDltACMxlbgaH?=
 =?us-ascii?Q?54dhe1hM+b8mv9egfjMeUfy78e80AEF9HExdDt6zMe7hCEpwdot4qqPMYnxb?=
 =?us-ascii?Q?nA/LfJIYUgGkX3aS3rCrh6w7fY94G0XoSoW3D0WdfH0Gddkdv1j/ULRid42Y?=
 =?us-ascii?Q?Ls3hvm09J8IV6bo6NTXLxDIkGizcap1jDJsbxLlo2AEvqlPELhK8imcVEQFm?=
 =?us-ascii?Q?c6cXjV/6voIfDZo4iZCaFqEKud8ncPaFBV9GioJx/fAzkuXGy2Vb9Z2M9r9a?=
 =?us-ascii?Q?dmgqRsRQv4CQnIg+X/DLjGrVuI+XjEiSuRI2+yGQdU8sR/Sw7wPM59BJXTGx?=
 =?us-ascii?Q?XS/imxXZBqcHCiN/w6cWs+XfVzeP31UofVBhMtvjx7pkKupSfQfvfq43hFq5?=
 =?us-ascii?Q?28LdrNtfQKbZvnx6J7b/pyyrjwGaC7tEyHYlLx8Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84759d9e-8b26-4019-ac6e-08dd210cd443
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:41:54.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpp+A6B9T/4sbj26auVp7EAfTNqYgqLPRv5cTiPrJ2tPh1qIu2wyu4wZ/A6GkO+ULqY+B/WJXpTQG9mS8pR/BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

With the introduction of separate per-NUMA node cpumasks, we
automatically track idle CPUs within each NUMA node.

This makes the special logic for determining idle CPUs in each NUMA node
redundant and unnecessary, so we can get rid of it.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 93 ++++++++++-------------------------------
 1 file changed, 23 insertions(+), 70 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 013deaa08f12..b36e93da1b75 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -82,7 +82,6 @@ static void idle_masks_init(void)
 }
 
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
-static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 
 /*
  * Return the node id associated to a target idle CPU (used to determine
@@ -259,25 +258,6 @@ static unsigned int numa_weight(s32 cpu)
 	return sg->group_weight;
 }
 
-/*
- * Return the cpumask representing the NUMA domain of @cpu (or NULL if the NUMA
- * domain is not defined).
- */
-static struct cpumask *numa_span(s32 cpu)
-{
-	struct sched_domain *sd;
-	struct sched_group *sg;
-
-	sd = rcu_dereference(per_cpu(sd_numa, cpu));
-	if (!sd)
-		return NULL;
-	sg = sd->groups;
-	if (!sg)
-		return NULL;
-
-	return sched_group_span(sg);
-}
-
 /*
  * Return true if the LLC domains do not perfectly overlap with the NUMA
  * domains, false otherwise.
@@ -329,7 +309,7 @@ static bool llc_numa_mismatch(void)
  */
 static void update_selcpu_topology(struct sched_ext_ops *ops)
 {
-	bool enable_llc = false, enable_numa = false;
+	bool enable_llc = false;
 	unsigned int nr_cpus;
 	s32 cpu = cpumask_first(cpu_online_mask);
 
@@ -348,41 +328,34 @@ static void update_selcpu_topology(struct sched_ext_ops *ops)
 	if (nr_cpus > 0) {
 		if (nr_cpus < num_online_cpus())
 			enable_llc = true;
+		/*
+		 * No need to enable LLC optimization if the LLC domains are
+		 * perfectly overlapping with the NUMA domains when per-node
+		 * cpumasks are enabled.
+		 */
+		if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
+		    !llc_numa_mismatch())
+			enable_llc = false;
 		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
 			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
 	}
-
-	/*
-	 * Enable NUMA optimization only when there are multiple NUMA domains
-	 * among the online CPUs and the NUMA domains don't perfectly overlaps
-	 * with the LLC domains.
-	 *
-	 * If all CPUs belong to the same NUMA node and the same LLC domain,
-	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
-	 * for an idle CPU in the same domain twice is redundant.
-	 */
-	nr_cpus = numa_weight(cpu);
-	if (nr_cpus > 0) {
-		if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
-			enable_numa = true;
-		pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
-			 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
-	}
 	rcu_read_unlock();
 
 	pr_debug("sched_ext: LLC idle selection %s\n",
 		 enable_llc ? "enabled" : "disabled");
-	pr_debug("sched_ext: NUMA idle selection %s\n",
-		 enable_numa ? "enabled" : "disabled");
 
 	if (enable_llc)
 		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
 	else
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
-	if (enable_numa)
-		static_branch_enable_cpuslocked(&scx_selcpu_topo_numa);
+
+	/*
+	 * Check if we need to enable per-node cpumasks.
+	 */
+	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
+		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
 	else
-		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
+		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
 }
 
 /*
@@ -405,9 +378,8 @@ static void update_selcpu_topology(struct sched_ext_ops *ops)
  *
  * 5. Pick any idle CPU usable by the task.
  *
- * Step 3 and 4 are performed only if the system has, respectively, multiple
- * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
- * scx_selcpu_topo_numa).
+ * Step 3 is performed only if the system has multiple LLC domains that are not
+ * perfectly overlapping with the NUMA domains (see scx_selcpu_topo_llc).
  *
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
@@ -416,7 +388,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
 	const struct cpumask *llc_cpus = NULL;
-	const struct cpumask *numa_cpus = NULL;
 	int node = idle_cpu_to_node(prev_cpu);
 	s32 cpu;
 
@@ -438,13 +409,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * CPU affinity), the task will simply use the flat scheduling domain
 	 * defined by user-space.
 	 */
-	if (p->nr_cpus_allowed >= num_possible_cpus()) {
-		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-			numa_cpus = numa_span(prev_cpu);
-
+	if (p->nr_cpus_allowed >= num_possible_cpus())
 		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
 			llc_cpus = llc_span(prev_cpu);
-	}
 
 	/*
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
@@ -507,15 +474,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				goto cpu_found;
 		}
 
-		/*
-		 * Search for any fully idle core in the same NUMA node.
-		 */
-		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu(numa_cpus, node, SCX_PICK_IDLE_CORE);
-			if (cpu >= 0)
-				goto cpu_found;
-		}
-
 		/*
 		 * Search for any full idle core usable by the task.
 		 *
@@ -545,17 +503,12 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			goto cpu_found;
 	}
 
-	/*
-	 * Search for any idle CPU in the same NUMA node.
-	 */
-	if (numa_cpus) {
-		cpu = pick_idle_cpu_from_node(numa_cpus, node, 0);
-		if (cpu >= 0)
-			goto cpu_found;
-	}
-
 	/*
 	 * Search for any idle CPU usable by the task.
+	 *
+	 * If NUMA aware idle selection is enabled, the search will begin
+	 * in prev_cpu's node and proceed to other nodes in order of
+	 * increasing distance.
 	 */
 	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
 	if (cpu >= 0)
-- 
2.47.1


