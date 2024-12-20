Return-Path: <bpf+bounces-47429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B909F95A2
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F4A188E49E
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C7521A45D;
	Fri, 20 Dec 2024 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OP51xZhc"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD04721A440;
	Fri, 20 Dec 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709298; cv=fail; b=Kw7zJbiwn4oONKWFdtNsVCMrox6PXFF0GW2aHnOC2zOI/HmIyHsRge58eYNXyyWyH4NXR6USWzQgWZuAEwGUo4oxRpcSdtxg4p7+YtIs34faOkSz3XMzUxVs3d2nfe/GeBeWwc2kTIt1+cb/U/WjhXCRM/M8myIq2IB1IMl1qdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709298; c=relaxed/simple;
	bh=KxRf734fvK6ZCQI4T3agHnNBNKtAxK+yTuBXzUj6Ok0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fKud2rQa0EySsoedbwtbC+e98fOMx3tTKEpHCaOck+a9i8a/EXl0YZec/pSKPenyLfkk46RplFEwNaDqPq2OXlK3XtzNllghxximZs3JMoKjwnZxsSpVqO5kl8r4IVW5mwDNuDasAE+y/DzXvhEjK7k50CBL24Yo5mZabSrgXpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OP51xZhc; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrT9WlLgLQSmAE2P9uZtf8e58wLTVpt6DmqCjnnZl6ea3ImugK9vm2BZvmp+PqOPW/sjjitoFzDfvlI3R97gjpdGzN9p5thA25qCpQ4La9aab7CdV4VtLuVZBzml4a/0dL+PY40ukJ8bSVEv3Cc0wuYgb1lb5UddT/jndwYBQByGar2bEKec8XwCj8aDDV12l2rMCGkg4Qc1YdwJkVmUDvN8j6k2GqmFtA6GK2iHhhFoUhdeiOKK17rgV8PmyPktvJhuCw+BmXNFkOThdbfLpQDZhGg4YgAueGlOH9WQCVtuwXEEUJmR3HgNpZJYunlT4mWBtk96PET0k64sN7zdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCBF3M6WWXNz4Ul2aZjpCiD52jYPCmU4fJP70kG7xLE=;
 b=gD6/jSBGBAV4kqewYuUh+YQjUjJkK3qzMJSm5+M1yj2QTgKeshHAVTIgmqWkyI/kv/zH+Ed1T1cZ3Di7SDdb9IuOUr5qW6rpLQO+1unhONy2SBxe7+ekqcg0S6Ld5/gLje2Cd94BypPu1yM/A0ELJDz5h+H/NiTt5o7WInNLo+C26Nz2exAXgfbP7vGzvWLo0Cp9L2Tt7twKdYeYm0T8YcC77T0ZdikAh25MqqNggEIO4Er7b92SvLUCzMUxUQ0T0vrXAku/2wO/E8o6YyJTRp1JdTdvKL+yBIC1LKkrH9lxlt6P6KHzNT9B59fhi4H4djaMTxuIWjnHHDfYmeaBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCBF3M6WWXNz4Ul2aZjpCiD52jYPCmU4fJP70kG7xLE=;
 b=OP51xZhc3fXq0mklOetK4ctvV9xEka92GE/aRjOgVuyE38k/wzQ/ViTNuwpMqOqMjLvcNkMbsEYSHFkmMKZE3AxiPU0/DjJcUzxraBUYitYpV2XXJPE1E8a9Ox2SV4v/6WeN5YaKYQU7z3gCQElIPS/0oHSTN5ydrl0075ujhEPq3kuReA5H6qgxal2yWWt95VpsaQvRvN8k1k6V0YVB+BB7MWQgY5PpoMDeGNZ+8b+A8ddhzrBgYFvI5wwPEZbwZux5NbH63I3FhZv0cVDd0wBiYWOM9+EgsgUUHI1WFjEQ7LqwSLQ46BthqfK/+F9sX+pw6fh9fHWkfeqMY9mr1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 15:41:33 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 15:41:33 +0000
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
Subject: [PATCH 04/10] sched_ext: idle: use assign_cpu() to update the idle cpumask
Date: Fri, 20 Dec 2024 16:11:36 +0100
Message-ID: <20241220154107.287478-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220154107.287478-1-arighi@nvidia.com>
References: <20241220154107.287478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 7589d7e6-fe88-47c8-5d77-08dd210cc7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qsCe0AmByE1qvZKGKGLptHhW0PwkFH6L/Y/A5NtNTezapk4n9QqoIRch4EVj?=
 =?us-ascii?Q?SsUHBzFk4VhXbYHAuxQEB+Z7ht8xbSjYw2uUIZY8wE/DU48tHX0ske/o+X2V?=
 =?us-ascii?Q?4ZNRZ06iUy2I+uF8fXQHPMB0xeqj9qSWvOFnfVpeIXXC/RNxZ7YlB++lCPqm?=
 =?us-ascii?Q?YwzhR5LJZq8PFEVR/c6AWwRl05r+JxGrmlOXBprpJfypZbJBjMQs0/FQKBfR?=
 =?us-ascii?Q?84v94c8OD7VLFq2NL3Qom0FFw1UgAmbvy9W1c+vgWftTaGfTvDZ5rL3qZ76H?=
 =?us-ascii?Q?VyG4A4nrSXWa9rlocGSFteC+idML12SwrOx/oYCrKw0TMZ8FvOMhtNxtvRyn?=
 =?us-ascii?Q?8vW5ig9802lvc6B68QJ05C+isHqfd+/l+tJGkts8EtF/hshJvxawiKpcdYP+?=
 =?us-ascii?Q?4wwHXUzlOaYlOMk3foCYTM3RefRLFIKAk/J9xiLmtcoplybWGgfgnyOX3g1F?=
 =?us-ascii?Q?rJZtu2Ih8nWkWgHOeSyUkparrug+QymnpZ1xUf+UkwtqycJG/JTWPrX2b7gi?=
 =?us-ascii?Q?Bt9RF19BcrOzgqaj4HRbsYAt4XP8G1q3511K4jrrMGU/SOgJzY7DyPFpmJQI?=
 =?us-ascii?Q?oZtfqxk6j61EMFAXVfONUxdIwr8tJ3NKfv/RVptAT9FBwed7ha1li8R0YzuZ?=
 =?us-ascii?Q?rlOkSz5Jp1nccbdMhhp6ob22HNRj8kY/hlkg5kpDFp7u/96GD5UFE5V4mEm1?=
 =?us-ascii?Q?U8jHI2GuLFIZpnHAmom7UucqZMmC2yPIutODspOo/VaGUCdjATrvfo6bcP75?=
 =?us-ascii?Q?bpKTgYIAfIco9FWrZRYMcOVRPBbh1DE2Po7s2ssi5MUE7iUhXn+F4LMY8sMX?=
 =?us-ascii?Q?e6U2Z3l2bOGRJ038QMIjsRogSI5ncx6o9H8apcNPXQW2o+ossJYh/KW4alah?=
 =?us-ascii?Q?Vz6a/WLpbdojkminDOoe60MBpeDpd2BbH13C/2jVu9aNxKXwriWa6Xrhmq3i?=
 =?us-ascii?Q?MbL487VB1QYqorTu7xQ5L4h91wzGhbLD1erBfMKBLLF6JznlA3Djdq2wr3LV?=
 =?us-ascii?Q?ghbz4SEfyg2nH8R4RA+yziStSdDDDdpTZqV+OWbsU18a02xfAL0jJgt/xpAY?=
 =?us-ascii?Q?16josCPjkyeToQ9y+PMo5XXXgnmsvfeGlugwW7M8WluLPZP5o0YFmmAobYuY?=
 =?us-ascii?Q?HiJOwnHrFVAzCVdS4lMu9nOgF/McO4KyzbRYSni/0Rs51iqO6FkdnN9YXu6o?=
 =?us-ascii?Q?IuPxkOQLIPGuKnCjUcAPy7nm/Dfi7gUQkhwV+J2dEV44mxP5rcxYqtVdRY/U?=
 =?us-ascii?Q?IuzpPb7gS+fTrSSvaTLxecGd1yqB2G35UgUlx2mV5gd0KePsT978EohfUIkj?=
 =?us-ascii?Q?FbnELQIBrqzL9LWAswWezJv2lOwdKHwQN7r1U+PRBg8JwzwwEAIRklk7V5UL?=
 =?us-ascii?Q?332Br9wD0u2C4cjQUR/0/5cAjuvO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1FZ6Z3KBGTETWqMS6MEqLtKStLhqDsNSx4dAA4NcOAvaL48cz4CrRaYVenfA?=
 =?us-ascii?Q?nR1XX7BzKd1QVN4CURDQa6p8udQQXsVkGoIspH6HSxrJmLo3l+VhyUihYX5E?=
 =?us-ascii?Q?sA/jBV0PHhLEkoDkqffHSUD6bx4sF0YB8bubRqwDQu7KvH4Speu+swVT0BZC?=
 =?us-ascii?Q?HTFbfylWoi8falq6o7HQy6Lnearq6O091v1cNeVDO+GV54w7JbG60pIzxaE9?=
 =?us-ascii?Q?MOW2t3kW16jz4/yaq9i6dH35UdfP2UsjFtQqTolNKnkk9wcrOLS0k7xnZoDG?=
 =?us-ascii?Q?dXNWKPbI9CfHq9dr7u/cKtfJozBO3K6Rz0CA6bJpC0tlLVA/fNmLDR7kToDU?=
 =?us-ascii?Q?nrSMkuhrxR9vOVvuR9RIvTLbbFlmhexPab7hjAyyZw8crhkTfUnK17+VZpQ6?=
 =?us-ascii?Q?zHdI4K9tUEJ+y17R0F1vPLRkizWOjYFh1RGgtA598QignJOMuGvz2gWD782Y?=
 =?us-ascii?Q?a7s2OajwWrpjn3I2S5mE1UQqW+xsCWVqatxQZ+JAImH3U/Nn5rgn1tAfD4gj?=
 =?us-ascii?Q?U/jylVxpOeaKc+4v+9ENGin44M0BmNLX5e9pl9A1RIyvPJHdIlAwX3OCnXex?=
 =?us-ascii?Q?Cv5E7kyN9NkQPLX0XIg34EsGLCRsIXGpg5HCrAOJSbymavlW2D+CcIe40pOa?=
 =?us-ascii?Q?I69fFYHlSCKCkj+U7+z6hUrMS3RS5q6zycf5PcLFjDi1HLWCKZcC4v7ZMNQB?=
 =?us-ascii?Q?UO75fqhYzhFdXVb7YowhBWmsA319txeY0CyASQ7A9WV0Y5kvwChEvkoxhNg+?=
 =?us-ascii?Q?aseWm+3CqihHSStnfyk5vZLw9URSGnpW9kKEdr4AIAGM2wrpoiQKweGoNMmM?=
 =?us-ascii?Q?EaDtBidtlUayPJCiWprdeAQSTZ2XvFnb3v6kNmzSRniivrSFL+l19DoF0KvN?=
 =?us-ascii?Q?CIegT2zC/lrGRscCQOmCP/J3L3HNoU5+Gy+g8N2Cr4n9EoriY0RRri6IKR6P?=
 =?us-ascii?Q?Owzts8AzwbRea2Pv2yUMkOaVBxyQg3VRah6cVl/sn0ri9ASQb387Z0BoQyv5?=
 =?us-ascii?Q?MTTcahgM3WrGuEIEEatuYe6jmV7XBDMUKsa0xcipPYm/AHE1wVIrLnkQaS/T?=
 =?us-ascii?Q?tq1inyAHcPulh0R6mE7KzKQfGpNuViFetqQo7wucLk1X4fwasKRWJ1ZFOFYT?=
 =?us-ascii?Q?Al3m96K6uQQKaIF3TAirCpIVsDF6kZBFX6xV9H1PmyBOkfmLr6AhE5iA/sax?=
 =?us-ascii?Q?BlZWO22ZEfzyYx6yX7+9uOZsgmf4kXaVlkVbhxVL1vD/mpmSJYQmLCJb4uKi?=
 =?us-ascii?Q?haqnDgV5YhveDByn5pwYN7U34xKMOtVs2Qe5jtr3mTzrU/wFcpT+qy7K8XTO?=
 =?us-ascii?Q?30bVSEODwhJpDZQVxKkLttZxISx5dbD9JCgrAJAJcR4/Zb/wVXIADuqFju6g?=
 =?us-ascii?Q?L1OddMGZ6x7//zHwHwR2zY7MVsJoC6WIWSMxS1mECj4EKuEtcgZ8YZYfguQ2?=
 =?us-ascii?Q?TjyOXMwffjVQIm8yaJBb1SzWsKrWbPdqJMw4aGSIwyzZt2wc6Fw63m4utbuD?=
 =?us-ascii?Q?ro8v5NuLcuEDvh2SGQjvLemHryQDD3FydMVNjipXHluHT4lov8QM0+6GQfhm?=
 =?us-ascii?Q?0hrwMuK2KXDvXLvyHfb/WLa2d5SgEq0RpYJ+VrQd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7589d7e6-fe88-47c8-5d77-08dd210cc7c0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:41:33.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6w4SSc/mgfm8Xa5u8/Z0I7YWBk61xa3PBjWXKTMdBwxUf0IHRa+5uSZ0MZlnsgN5cNMB5v2LCfveNqZITfjrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

Use the assign_cpu() helper to set or clear the CPU in the idle mask,
based on the idle condition.

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 0e57830072e4..dedd39febc88 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -460,10 +460,7 @@ void __scx_update_idle(struct rq *rq, bool idle)
 			return;
 	}
 
-	if (idle)
-		cpumask_set_cpu(cpu, idle_masks.cpu);
-	else
-		cpumask_clear_cpu(cpu, idle_masks.cpu);
+	assign_cpu(cpu, idle_masks.cpu, idle);
 
 #ifdef CONFIG_SCHED_SMT
 	if (sched_smt_active()) {
-- 
2.47.1


