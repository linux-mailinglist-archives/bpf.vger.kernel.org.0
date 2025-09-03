Return-Path: <bpf+bounces-67273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF297B41AA8
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A556814A4
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6212F8BC0;
	Wed,  3 Sep 2025 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jGGZnQ2s"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E02F7441;
	Wed,  3 Sep 2025 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893081; cv=fail; b=PSlgSsEhbvjjapbZar6YOvwvmgKmjsPw3FP+pRmRuiLJoqoghShzjHL8MHw9b6e9eq7Vgxcpwhd7yzI/ObHpuQwdGK+M9IXPaV7w/1kN9v/yJxzYnPj330lPKWjNYOuFRG2D37Kuusqub8fcsexCUso+ja56gJflZr/UTW34+ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893081; c=relaxed/simple;
	bh=l3TsVfLRCckkrVbW14MdDEkRNEFz0H6Yrab3zRW5rJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m0SEz4tQjbPjKWg51QZ2SkAIS/x0zIK+qH2iPJHLJ3eSi5RiZNIBFcvxeDjOPLkAdV5f76bHhA4l/eAE2QXz6B52dF4zCeO94QJozRv+5sQf7ucK5kFQC37ubKuZieabUSpK8tL/mGyUrDOwxiVJb9nejj2NSI+P/k2I0h5cebE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jGGZnQ2s; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShjN8G7CsuC+P8AQT9xxcy04KBcqgGiyBVQsLpGFIryLoXaQKCTWFixjxcAT4u6ILDa89b5LV6GK9qg6+y468kgerL7fXqkodry9UpHIhLX91LlmgV6cqkPQhJNMyzql4aCv5gZ9WKf+yAS8ViI01RtLcDueyQXrZbs1MsWQeP+zqVfkZUggdj7cnGCzziaqtAjt8aq3iINU0bc8rP3puMM5p4qtSFrTjng4ZDx3B++X1Q1GOgnJKSyOTeC8UloLu0WliENZ1pMAoyAU0q/IFSgsJemWuqx21nE+ua8mW9U47bqHlSh/zme5eD/PW4xsuuFtm4LY/EAhivFl8RUfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rU+gG3kf5qbbPl1MkSKFfrn1fYuO/+/jtdSDJHiWA8=;
 b=AYK/56f+Unsh4ihocoA14FHgpD8EVpfwLaEETuJnZEUj+w3/zDJDXeSHkr7QEfxcYvEdeUbaE/OKahBvy4sCB7GbPvDFDijbSqSIyz1wCA7nH3dS52Zyd42vd+whCvKh89VFBJgqz6qTV3zM1WBnOHeYYmQJMrYbCbMjSnVd3Lda7L3MFt8vdhemzGr2dFySC/45JJqav3aH8uW6f2CWmpKHB58A34OTXUSJEvQLhFWgTJdn2QoIivrVVp6Vgx6FrpUuADIlUfeLMqwLbgAtlwMCGxRAzOTrfHiJBGrKAsTojL+l8vAZwqYrz7wcLyRgjSpHd3RL9P8O03M6YcHxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rU+gG3kf5qbbPl1MkSKFfrn1fYuO/+/jtdSDJHiWA8=;
 b=jGGZnQ2s8uB5PMFTQF6Tbd16pKlZeQHUGjCkfi/Bayr6rQXZ9n5Nt8TsqkuFoqiRBJOL6m6u/q//hIy5OFCJQymStUPjTwuOgcijwKtlqGvfDeCaf8LiKmgAN0K1MUgl+uxQ+fEcSDPzh2f7rULDLa4ll9WGwaB2iDVUeHroqG88zA5yUH0TG1uX/f4NglhrxT5inPe5mXqjUB0bgfDRleJ1WPcz+pIWultTot/3wCCh3HdOoiszESf1Wc0GZ+R/9E0HWMZewHmCLbr0pqZD04KdvBIQ7Rc0XRkV/Iye2aAHaI5zCCAXjj/aj7z0HFKYcHfp2U8i6DweOY9peAUdvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:51:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:51:16 +0000
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
Subject: [PATCH 16/16] selftests/sched_ext: Add test for DL server total_bw consistency
Date: Wed,  3 Sep 2025 11:33:42 +0200
Message-ID: <20250903095008.162049-17-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0375cf-c3dc-43eb-f43e-08ddeacf6d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3gOCaDcFQkJ2fiRWqTOwqoIgX2hf6/FBCUk8/wjSx64OJSzGLckNVPA5ZX7G?=
 =?us-ascii?Q?VcBnZ8KepR1lXsuQzP8bjUMAxU/mSzsP7sL/S5KYcbK35xMiKqBWeHWzs4es?=
 =?us-ascii?Q?xC6o8FNUbx9VLAbwc5efyVEGryFjBUexgycy4rloraM1A/JwIpSsEjztGmLb?=
 =?us-ascii?Q?QcwFjCXXItoiFyYDDMhQ+qeSyC/9EOha13fa4PhJPTjRxk7VrUux7/d+vZyj?=
 =?us-ascii?Q?+iCUALEw3A+tpek3wBkKKUfcilT0jnmGfMzGt+DAGRaWjg6NBN7U8w6tkqUS?=
 =?us-ascii?Q?EUPG9MJ4+h+tvRTB5VhocITJ8uPW6zSiGcff6B4FzG5y1q18wxg6ypLFCunk?=
 =?us-ascii?Q?hG78hg1DPrUHnXN0QwTYDtIXm1rgx9L7AouaxOCJbEu7WBTH8PumtS+56dUF?=
 =?us-ascii?Q?681m8DiB4HDnbra/EcxDv76TuYy/NCUqjynHGsgvsbpN0eDVvHNRr07Ij1Im?=
 =?us-ascii?Q?G9sad08FGZuGuncPCI2RFw4XfMf/lGzHfjAAjXsGvldYVEkTTiJUZsXitnHX?=
 =?us-ascii?Q?VOuDTsLN5XOZXPs9U5crpPRHoYp4P2tGHqMe8zVGxohvYNLiRAoeRVhd3D7O?=
 =?us-ascii?Q?a8ZE7UrwKbcZcDEtXJuhtQ/UN6akNzz/6IAe5sQ4klFmo09dUiBONP2vq9jK?=
 =?us-ascii?Q?4iQlJ2fdDOPdxESgAoIPEJ94V3XukuiKkUTy2oS1tAdUBImpk4Z6YDOErOBk?=
 =?us-ascii?Q?xKRfLt/Ix7lHuiSuZeMPjxi0wIBOPEpfGBDErBK4PK+1GUvtnkDz3wi3cEvD?=
 =?us-ascii?Q?iwSWDtXemDUHpX4TTaS+Mfalgv9xfhDfCFB6ND2QJlr25Eq+l3kRcsXkIG1n?=
 =?us-ascii?Q?ME9s9zKpBIzMwOLzt4PzAUHuN6OMy1+GdQEQJ+XKoRWeWkIMPRl4D0xbFnWw?=
 =?us-ascii?Q?sy2ALo0nROLqAZp0fIncOnrloPDDtxhEzZPo9pvAtFESZZVgeMWfPh4KQ8uV?=
 =?us-ascii?Q?9WhyEQQOr0bun97ioiGrgzLD1y7FGzMe1HgRQpG1Z2Cl8LOqyERUlbvBPfqp?=
 =?us-ascii?Q?wrEjOPKBs2LMF2cRfKYR86DuAZew0aUk4xkk7QAXv8UUXJhI0r0lGBERr6YI?=
 =?us-ascii?Q?vH/wRDK5dy/cQCvSVbH3bmyVAO4ON1jvJKUfdGCFN+Y51SdbWMDiI7fLfysm?=
 =?us-ascii?Q?vjqE1eIB2A7bRUsqoBnhRLDCjmUdpQRYNIfOnOkDjAjUgguE8ZLqS0XZQDsf?=
 =?us-ascii?Q?U/OJSwczy7hZ1bd82E7YDm16qXOe9uCqxyFiV2Lp7k/GOrdfwN0pF255EC2u?=
 =?us-ascii?Q?yhswi9L/wvbiKPw3gjBN0HeCbYzh3uZM2n+kag42E3aZdQcPg5IVK4+bMKxH?=
 =?us-ascii?Q?D0A/6zBr5llN2i6wuJFWhuYfFyhUiayRZ27H26GudSaxXllvd0N8Gldmh8Je?=
 =?us-ascii?Q?VF5v5QD8AkF17mdoO40MtH6wZe+6cP5GvUYoL116bhpAFMTsTdkZxOe9jETb?=
 =?us-ascii?Q?apzPpN2MgqF4VoUZq1H3EExDKG5UcOUQEdYDYwvuzxxF4hMEIeQTjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m0qf9+Wvpk1IbR7KHLTuLXDIe+cdr4hSxnmnRojYc9ODnLeRxnjrlKJQXORa?=
 =?us-ascii?Q?NT8O0Im2i9zuiPzyPVja08B1NdTkQFqZ9iM9QX7/7BTsQlnsw0IGfJwGTgqh?=
 =?us-ascii?Q?W84Uuq45hVnSP8BdzjV+/ThneEAmY9zleMiMv1R4qEU+MtQurxlbOoIyQg3I?=
 =?us-ascii?Q?OcNEIM5ss6B76FSTHH64Z6oy5TNJjlGCizZQCohP7+/Tbp2lTDhXviz9avPc?=
 =?us-ascii?Q?7olOmXSgUIrvdyLsSI5yxQ246ZS/gouJ76m1Ik00pja0CT5LCq6gOQfaFD+J?=
 =?us-ascii?Q?P2LdW95JDtxVc2wIWcge0ApXAQQSw4AYwF+KGmyTvN4qNPf6UTHWhiq3+rD7?=
 =?us-ascii?Q?p+IBE6jy2loZnGu3FFc3wi9h1QToT9VsnPDtJR6XG7lWvLTbXZx9Fi2oa3Kf?=
 =?us-ascii?Q?kuZL12fCeH1ZUU+5ctqDNMGUu/u67A6VyA8RaDlak84DGukC7XXNj4gHtK/j?=
 =?us-ascii?Q?26mx/RJ6IZPemTKJYIAIGjhGCo5TTrrjkILdEAxZAczB67BTtuoYBhBFihkn?=
 =?us-ascii?Q?AsUxXoLez/59amQzUoP8ewrR41h4diRsdn8kpxgFlbiqK4E762m3806FT6Zr?=
 =?us-ascii?Q?8d5GqQbDQ6paBr5bldoTAjRdG5FJu3PqtpiK6ES5tFScLUSK7+liJG+Kwx7V?=
 =?us-ascii?Q?FGv2X45VCygwCd2b6mKqVTW/IoSd4I2NsPQq5tmfCJ3D9QHTJaYruTIl7BEl?=
 =?us-ascii?Q?B23xSE1PT+ngqjAsOGFfn0VqHYi4fDEM4pxUQ11ec2Yt8UPBzezohPHpEAgO?=
 =?us-ascii?Q?H5VHh2umhktQDF+4Wsyz7P/pQaONqNeMhfs5kOHf9QXfQMPyC+G5Fowac12I?=
 =?us-ascii?Q?8Iqi34nM/05tQagfa3eRoJm8UmuDb1aeE1nvdjDnJapLdLUa7SZeDuExStTO?=
 =?us-ascii?Q?P1U50H32OS5xa/4ApNLS5DWzpI/dabSMZknP3RryMLLDdOr570/sQQa3f421?=
 =?us-ascii?Q?Tb72a84OR6sGwzwrPsqzcag8d17mz7gg34M545uXspSL6F6l1jwSslFO7tje?=
 =?us-ascii?Q?o5RzQWt1tcvTIIZ1hzOGo/oIjPf1bCG++wr9+yoi0+hZDhXix871oyh2NH89?=
 =?us-ascii?Q?jS9Ac/PzlsfqWDQSiZbsJVi7k5Dfj4IrNlrlb2Hc84mJvUIsnqO4cj8QSUAb?=
 =?us-ascii?Q?mAd1dLY38QwGWpXG1oae0ySCWwbOlSNOMm7f1EhzVnUv9uxX08aPxkELN1RP?=
 =?us-ascii?Q?tguHNsdu1SCcFD+tdqteqoufVvWH8Ky7zEv9L+SpmbBfR2/l4+FnD3wpqkmr?=
 =?us-ascii?Q?fr5xItqKgCatdbwwJl3b2dTfgC1zhWzUYsnn9zOz446i7Xui4Qt3q3SESOkE?=
 =?us-ascii?Q?M0fVyIgiZcBzEFd2rfJ2eXHUl0dSCyikay+QylNHP89tR7BkSLdNHuNKvBXI?=
 =?us-ascii?Q?hcCrybVOpk5xMOaose6k3AmZHPqj17asy5X27lSIR0kBgCt0gN0v128BBPb6?=
 =?us-ascii?Q?U34GFRsB+kadZ9uYqdchuJcbXiDbUTG/9ZyKy8dzJwMYmjvC68UBc9IthIiy?=
 =?us-ascii?Q?A2TmEKKKL9YuFHgO67wacd8kNiPqLhUctDkKvzc+7b+T3ELDEjVb3oBJhxZu?=
 =?us-ascii?Q?cokflJqM+jvjoChCjR4AEQma2xCGRol7iqxDhzNE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0375cf-c3dc-43eb-f43e-08ddeacf6d00
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:51:16.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3JnciYJ91j2LA9W5Gj6ePcvSrvt4texNctISD+TOMIXSPEmNHt8a9CQDUhi6ss/4CaxxAWnzuyjTsv93wIDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

From: Joel Fernandes <joelagnelf@nvidia.com>

Add a new kselftest to verify that the total_bw value in
/sys/kernel/debug/sched/debug remains consistent across all CPUs
under different sched_ext BPF program states:

1. Before a BPF scheduler is loaded
2. While a BPF scheduler is loaded and active
3. After a BPF scheduler is unloaded

The test runs CPU stress threads to ensure DL server bandwidth
values stabilize before checking consistency. This helps catch
potential issues with DL server bandwidth accounting during
sched_ext transitions.

[ arighi: small coding style fixes ]

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile   |   1 +
 tools/testing/selftests/sched_ext/total_bw.c | 281 +++++++++++++++++++
 2 files changed, 282 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index f0a8cba3a99f1..d48be158b0a1b 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -184,6 +184,7 @@ auto-test-targets :=			\
 	select_cpu_vtime		\
 	rt_stall			\
 	test_example			\
+	total_bw			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
diff --git a/tools/testing/selftests/sched_ext/total_bw.c b/tools/testing/selftests/sched_ext/total_bw.c
new file mode 100644
index 0000000000000..740c90a6ceab8
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/total_bw.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test to verify that total_bw value remains consistent across all CPUs
+ * in different BPF program states.
+ *
+ * Copyright (C) 2025 Nvidia Corporation.
+ */
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <pthread.h>
+#include <scx/common.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "minimal.bpf.skel.h"
+#include "scx_test.h"
+
+#define MAX_CPUS 512
+#define STRESS_DURATION_SEC 5
+
+struct total_bw_ctx {
+	struct minimal *skel;
+	long baseline_bw[MAX_CPUS];
+	int nr_cpus;
+};
+
+static void *cpu_stress_thread(void *arg)
+{
+	volatile int i;
+	time_t end_time = time(NULL) + STRESS_DURATION_SEC;
+
+	while (time(NULL) < end_time)
+		for (i = 0; i < 1000000; i++)
+			;
+
+	return NULL;
+}
+
+/*
+ * The first enqueue on a CPU causes the DL server to start, for that
+ * reason run stressor threads in the hopes it schedules on all CPUs.
+ */
+static int run_cpu_stress(int nr_cpus)
+{
+	pthread_t *threads;
+	int i, ret = 0;
+
+	threads = calloc(nr_cpus, sizeof(pthread_t));
+	if (!threads)
+		return -ENOMEM;
+
+	/* Create threads to run on each CPU */
+	for (i = 0; i < nr_cpus; i++) {
+		if (pthread_create(&threads[i], NULL, cpu_stress_thread, NULL)) {
+			ret = -errno;
+			fprintf(stderr, "Failed to create thread %d: %s\n", i, strerror(-ret));
+			break;
+		}
+	}
+
+	/* Wait for all threads to complete */
+	for (i = 0; i < nr_cpus; i++) {
+		if (threads[i])
+			pthread_join(threads[i], NULL);
+	}
+
+	free(threads);
+	return ret;
+}
+
+static int read_total_bw_values(long *bw_values, int max_cpus)
+{
+	FILE *fp;
+	char line[256];
+	int cpu_count = 0;
+
+	fp = fopen("/sys/kernel/debug/sched/debug", "r");
+	if (!fp) {
+		SCX_ERR("Failed to open debug file");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		char *bw_str = strstr(line, "total_bw");
+
+		if (bw_str) {
+			bw_str = strchr(bw_str, ':');
+			if (bw_str) {
+				/* Only store up to max_cpus values */
+				if (cpu_count < max_cpus)
+					bw_values[cpu_count] = atol(bw_str + 1);
+				cpu_count++;
+			}
+		}
+	}
+
+	fclose(fp);
+	return cpu_count;
+}
+
+static bool verify_total_bw_consistency(long *bw_values, int count)
+{
+	int i;
+	long first_value;
+
+	if (count <= 0)
+		return false;
+
+	first_value = bw_values[0];
+
+	for (i = 1; i < count; i++) {
+		if (bw_values[i] != first_value) {
+			SCX_ERR("Inconsistent total_bw: CPU0=%ld, CPU%d=%ld",
+				first_value, i, bw_values[i]);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static int fetch_verify_total_bw(long *bw_values, int nr_cpus)
+{
+	int attempts = 0;
+	int max_attempts = 10;
+	int count;
+
+	/*
+	 * The first enqueue on a CPU causes the DL server to start, for that
+	 * reason run stressor threads in the hopes it schedules on all CPUs.
+	 */
+	if (run_cpu_stress(nr_cpus) < 0) {
+		SCX_ERR("Failed to run CPU stress");
+		return -1;
+	}
+
+	/* Try multiple times to get stable values */
+	while (attempts < max_attempts) {
+		count = read_total_bw_values(bw_values, nr_cpus);
+		fprintf(stderr, "Read %d total_bw values (testing %d CPUs)\n", count, nr_cpus);
+		/* If system has more CPUs than we're testing, that's OK */
+		if (count < nr_cpus) {
+			SCX_ERR("Expected at least %d CPUs, got %d", nr_cpus, count);
+			attempts++;
+			sleep(1);
+			continue;
+		}
+
+		/* Only verify the CPUs we're testing */
+		if (verify_total_bw_consistency(bw_values, nr_cpus)) {
+			fprintf(stderr, "Values are consistent: %ld\n", bw_values[0]);
+			return 0;
+		}
+
+		attempts++;
+		sleep(1);
+	}
+
+	return -1;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct total_bw_ctx *test_ctx;
+
+	if (access("/sys/kernel/debug/sched/debug", R_OK) != 0) {
+		fprintf(stderr, "Skipping test: debugfs sched/debug not accessible\n");
+		return SCX_TEST_SKIP;
+	}
+
+	test_ctx = calloc(1, sizeof(*test_ctx));
+	if (!test_ctx)
+		return SCX_TEST_FAIL;
+
+	test_ctx->nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (test_ctx->nr_cpus <= 0) {
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* If system has more CPUs than MAX_CPUS, just test the first MAX_CPUS */
+	if (test_ctx->nr_cpus > MAX_CPUS)
+		test_ctx->nr_cpus = MAX_CPUS;
+
+	/* Test scenario 1: BPF program not loaded */
+	/* Read and verify baseline total_bw before loading BPF program */
+	fprintf(stderr, "BPF prog initially not loaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(test_ctx->baseline_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable baseline values");
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load the BPF skeleton */
+	test_ctx->skel = minimal__open();
+	if (!test_ctx->skel) {
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	SCX_ENUM_INIT(test_ctx->skel);
+	if (minimal__load(test_ctx->skel)) {
+		minimal__destroy(test_ctx->skel);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	*ctx = test_ctx;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct total_bw_ctx *test_ctx = ctx;
+	struct bpf_link *link;
+	long loaded_bw[MAX_CPUS];
+	long unloaded_bw[MAX_CPUS];
+	int i;
+
+	/* Test scenario 2: BPF program loaded */
+	link = bpf_map__attach_struct_ops(test_ctx->skel->maps.minimal_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	fprintf(stderr, "BPF program loaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(loaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values with BPF loaded");
+		bpf_link__destroy(link);
+		return SCX_TEST_FAIL;
+	}
+	bpf_link__destroy(link);
+
+	/* Test scenario 3: BPF program unloaded */
+	fprintf(stderr, "BPF program unloaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(unloaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values after BPF unload");
+		return SCX_TEST_FAIL;
+	}
+
+	/* Verify all three scenarios have the same total_bw values */
+	for (i = 0; i < test_ctx->nr_cpus; i++) {
+		if (test_ctx->baseline_bw[i] != loaded_bw[i]) {
+			SCX_ERR("CPU%d: baseline_bw=%ld != loaded_bw=%ld",
+				i, test_ctx->baseline_bw[i], loaded_bw[i]);
+			return SCX_TEST_FAIL;
+		}
+
+		if (test_ctx->baseline_bw[i] != unloaded_bw[i]) {
+			SCX_ERR("CPU%d: baseline_bw=%ld != unloaded_bw=%ld",
+				i, test_ctx->baseline_bw[i], unloaded_bw[i]);
+			return SCX_TEST_FAIL;
+		}
+	}
+
+	fprintf(stderr, "All total_bw values are consistent across all scenarios\n");
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct total_bw_ctx *test_ctx = ctx;
+
+	if (test_ctx) {
+		if (test_ctx->skel)
+			minimal__destroy(test_ctx->skel);
+		free(test_ctx);
+	}
+}
+
+struct scx_test total_bw = {
+	.name = "total_bw",
+	.description = "Verify total_bw consistency across BPF program states",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&total_bw)
-- 
2.51.0


