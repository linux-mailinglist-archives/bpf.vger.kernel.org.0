Return-Path: <bpf+bounces-54230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E1A65BB7
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB217AE33D
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AD11CEAA3;
	Mon, 17 Mar 2025 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bc3pb2ol"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4DB1DE3CB;
	Mon, 17 Mar 2025 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234308; cv=fail; b=AVSYHdnfb8uAwI8q8i7zQCCKcIEqLADH87Z2vaOA5SoMKEy0ekNHu+/icas7hj8slEh1RYeU9MXmXFqhU3EO4YcosuwpLZutVaah9PlmzizWQBDe900OB2AKToTjOdq/azCcyHT1EG1XdHGIXrzuRN8b7TdxSKUFhc0EQfEZqAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234308; c=relaxed/simple;
	bh=//GU+Q7PBMuQSzr7l+95noi5N2tjn49kWBgwaxJJdRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VtGYAjW/oRclNgRg7AUThnER21DFZzEwK4wWJjjWPVKkcSyBtBI8gMUwDaDFyvR7Jk5tNnrBCFUvopytIDgKYkpQPxNucSwKEA/TgQtMdlvHAYnYTX8AVMO3ZVqMVH/tRSO+KkyDNEyJGkSlnu7sS0aXJwQav9nrlwIlaDsQzmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bc3pb2ol; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEvVncOXxiakIGa4bUGKY4i+ndYUY+uqpo/zvZ0HP/Nhc07TFs/nd8n2iQ3XmcwzGSweR0i0FX4jEsSfsAYf12FWQ+aydVpkUn/kx7KEt7XlQSffJHVje0CAobBEKiYQPX3p3fREEKyBQ46R2DZtn1lSHe+tCHNw60+/vJBUu1PCv8xMPJz4BvttP47xM6s8wX4GP68iMUqeKzyjw4ZhZ7QVIzc3cTVzNjuF1fvVpyYe2xZobYriGi00puIIyEX63Op1WD0BKBYl+Is9JcGZlFvZeFryTCJbHrPoZdTDCIyZe7INfe6/DcPsP4X0ZC/lLhNnJK5n+9t1GL0cuqgpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTPdVY+xW6m2z4POLwgWDAV5mCoL8t0DAx6Nq/zjj+I=;
 b=EJmZ/Cvpnxs9vyszep7YeVdgp2OY588Wvc/gs5dl8dgSGTAO6YHak7owzwQxH1b2vzvLlE1Tj5zkERwJk2u/ma55HqbAW2cwtUYGQV76GLW+x7ZCe68iiUtxOPqpZNhXPY1fG8oVZENuEL8yWY9AzJpiKsY4mR++YweWT71Y87yzXYVbUPpkHBYa+7VFaCGJPA7fJG5COLDDoGzdQAmKg06vmU5PNWMnjRFSxW+J3VOdBXTIeP83OlsRLUgL/tYBcatzz4fRlzfGXgyoXyJlNdvTgTL9vVeU7P1jzlz3hTcO3ud/5YMqjqYOku4QbrF0qCPl5RocX4RUQPNEQMg/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTPdVY+xW6m2z4POLwgWDAV5mCoL8t0DAx6Nq/zjj+I=;
 b=Bc3pb2olrmK32Nelad11ZzsMfFOl9T+jy3qxt7/avTXQjc6qPr75UA2j/RyQ2MQDIvH4o3iCzOf7IbyXrUo5vtfcSFG5VRnTTc70dbfmp0aAj3oJqAeFzYecfiIapQDD7hoaVlJH3m8XJtHlVfbLFilPpjeHdf51YG5JF7ADaLbQMyK/Oyyqz7Pk+OJVL6O8AEQ8A5EyQv19HOngM9k4XKPso3rRcuJTtQc3N1HJ1GOj3zHMQyxYIcQEapgxuRfc5rVQDzz7CrUea22MHtwU7DnA8RE8mtKZMTh5XmfS/YZaLA+b72J8gz8joGONjJvLed5+NdbRSMHxtar7cyIlGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Mon, 17 Mar
 2025 17:58:21 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:58:20 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()
Date: Mon, 17 Mar 2025 18:53:29 +0100
Message-ID: <20250317175717.163267-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317175717.163267-1-arighi@nvidia.com>
References: <20250317175717.163267-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8787cb-eaca-4a78-247e-08dd657d4d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y1HdvHTZZ5ZQJqLAW+q4ttYNnGXnyEH2bWL/0iSb/cwaBT6nmZ8H7b1p318h?=
 =?us-ascii?Q?tXhSbE1Idj1bzYKUQYsDuz5sspuVQIXzbDSPenytb9viWQJTmFa08G1Q3kYn?=
 =?us-ascii?Q?6D/Aq/bEZLadfyUWl4HE1fYIHtmbX3HYoOSpp31XKQKojJfGSoXnBxhH/+G9?=
 =?us-ascii?Q?xHjG5zdX31SEaEPMtHfBRL/m8ilBN4au/n47FK3Y4vmHh8W37C0g6sfm9qnp?=
 =?us-ascii?Q?kVkWNz6H3LyWArTn71nzbW+kQBhtAV4fuBi93bAU6GZEetILC6d907PL3FVZ?=
 =?us-ascii?Q?Ne8nBzEegNn3/8QQApNStgrdP+VRo5H9uKGShi2FMPIhrPEg8QJhXWf5eMs5?=
 =?us-ascii?Q?Sv1TDmSHIY04NTG/tUNZN2/6GBB+eWKh0aFZVWFcXQLPVctvbF8kxKRFve9S?=
 =?us-ascii?Q?E/q9peSUfgklSTueiJSDSZlFqJ4KiI/LnMHRorXnfkYWwoKqbrWGZRBSntGi?=
 =?us-ascii?Q?+yURFsMWLSQXBa9ggt4C7xUd3bey78YYdj8H9NzcbW7CZd0W8Nht4gLfAlgL?=
 =?us-ascii?Q?PgXMSYKRLyG+s77LiHetK6CPOmGsNEjijiao8XjK8TXE4aCkU/l9IhYOvos/?=
 =?us-ascii?Q?3JFBa2iLCCfyoSWlDLtRNfBW3GHWjFfbpogzLgqIHf+cw89D+wuylGRTOs/g?=
 =?us-ascii?Q?LFhlEOq3rEwfK7Ytqxo2ms4sdkAzbZ+oYW5LmpkD8Xv3c8jMhXZIRxfDhWDi?=
 =?us-ascii?Q?ofunVexDeoDOvOUkbq1DgYW/5tbkBlUCfj80QboqZFBM1QysPK6G+KiCVQHv?=
 =?us-ascii?Q?+mHyOVAmkMRegRVryWDHsrOsA3gxO/+s5fk+qAmX/k1JyUGOUJ1n8FWOB4jm?=
 =?us-ascii?Q?I7s0p6fzD/8AiFeU6D/HZaNp7l700kzLmQIYYc2eFzf5q/BAE5uk0F9v2haj?=
 =?us-ascii?Q?yQXgVJPB2Rb66PzNcppJqwimiu6yU1Ycjh5Bwyv4lIcke5yIqWkd2zfA+WLG?=
 =?us-ascii?Q?cfpAPlHgIInKFvP+CGPj6ZJNDpoecc5jNXP8p0p3Fyj1B5J2cfojvrV/cDZ0?=
 =?us-ascii?Q?qxj4yYKLHQ+prv6IEz6jVpFWyC6HcY6ene6klDy+dwa2GuIqc3jQl6SeQnCT?=
 =?us-ascii?Q?oNHFnUbJDJiJHt7JC78aUfdFF3K8C/3U2Qg4rUa31+/FlWyiS4PyQSdhdZsf?=
 =?us-ascii?Q?O9VC5yALWwg9wXcmEj6HuZtNZAHq+X6DzbBG54WOA/N0XzwlnMDyTPVnxn4e?=
 =?us-ascii?Q?t3Yy71uz1FcMg0Oa/wdcJJOhBpI3ag4/JyKG48Cn+cnBkHao6UXzN85+lPHA?=
 =?us-ascii?Q?oQtClQOAYL4dwzC5aDZNidJLStwbwPq0lExBgG/t65ZvxoCc7h9/CF68t/0k?=
 =?us-ascii?Q?WqSGbkYtOU8I+rklSHdQ5wGHy9rkU7v3nh7Maf0BC0bl8InIVGyDYEl3lZkT?=
 =?us-ascii?Q?H1sXxCu2kSQBF85OAH8NghJVSqqz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?puJsmNQP+0zCaB/Kzr3dM34kSS5Mr9wqzvWVSBhjNbzI8728Ojh6aOnRr5ej?=
 =?us-ascii?Q?leTgw70VTyXSTA/vbRuB5v0eE7uTqjUWxRLQu/1RVlskHfLlw7Ym8wWwRg+k?=
 =?us-ascii?Q?lhEHsFN4BVz/ADhvDN8vKf+Y250kUM7smfGspn33XB0gN7se5lFoM8An210q?=
 =?us-ascii?Q?zR/FozRGpV4wEwktzejrjbR/m4hfePC7SkagTR5tajt9CZnbAF0/3YrM3J02?=
 =?us-ascii?Q?J5r3iIGmZGPBfToQqW/gmR71U0YyEVy/5Z1XRnVbwafVoLvj4+qBCF3AD6KR?=
 =?us-ascii?Q?HvECH3jyA3XB13wPqOgFXib66PgVKu5M+JIahefY0c3zyL4wnB32XCLIYaC6?=
 =?us-ascii?Q?T2VVrM3dnjvTMwX7hKeYFJHuoHWENox9UeTKzyJ842vpxVuZoyv46Qc22feu?=
 =?us-ascii?Q?zSGQq2Ll2RR/2poPqyeUloP1sm/mR6xeJ+/P623imS/U2RnXkMY+liaQsWPB?=
 =?us-ascii?Q?xKMXRJ5zbgVXbw+4e0OvsEsQB8qLhTZ5lkl6Bjr72q67V4E0bueCvEDjlfLM?=
 =?us-ascii?Q?nni2WSmPXmXbDpdUA1ZH7L6K8mQxiKb9GsN0B7ED7pmtpnCRz4lHmdlguIfX?=
 =?us-ascii?Q?EKRCt1D63vDeU+vcvnuaJTDmNWtcdtmmavVkDdKqMCzFDHaJXFMA3grM1t2h?=
 =?us-ascii?Q?TBKYW6uIcb41R+Su8MKTCBv4T8bX9duiSPzr6HPLT8MPkMuSrOsB2c+CaO6P?=
 =?us-ascii?Q?y6ojDH4hWHH47U/ItCsY8hj4STrC78CoShfPbIIgwO36P1oZRFQK4My54ZJZ?=
 =?us-ascii?Q?wz7Gi6fuy+krW9/bpW3HLDypZpiSO36cQK3mFRRqS3+Xvu6mq3iqkirWrWw4?=
 =?us-ascii?Q?FPlcnNnCmWR5waKyTEirYHYG5Eiz3SI9DBxSo6okw2Hngt8oCLul1GIgMc6p?=
 =?us-ascii?Q?ucAzE936BzzslfR/Yqyyrl8Um3Idir8QfzbzCO6qJ+AuWtou5A/7fYX4wXWW?=
 =?us-ascii?Q?0WTaFY3yexRFeEEU+RxEnv0aE7cOgw+qh2397yb4y1B3lcXNpOXDmitJqFip?=
 =?us-ascii?Q?xaUvaTGJmzVzMExUoY+wXdRef7IvgL0pZwHtBxG+6M4rbzXg9AjPKq+MeZV6?=
 =?us-ascii?Q?QP14jV6AE8sYKXZgh+6+LrEQIBhVET5n6ve8RUm4rvBHzFNs7PGQHhK3FpRc?=
 =?us-ascii?Q?VPTMcuvjktPEIClcBka7ZxTtvn6APlLqRk28CsGf9373aStGZC1wwvg3z7d2?=
 =?us-ascii?Q?Ju/x6GT08G4NzKM099wHQG2nZMgpusYv7P4h858dJ0yyuxq9r6A6cCbt1nsH?=
 =?us-ascii?Q?Y7++1Kb5SUoDeQeCkUswtL40u0p8n/IgvDceb67TWp6gVylNNYLtcOEpOLa9?=
 =?us-ascii?Q?xTfsXVmBZAYlL6W8tTBHvbiUaDIXC9el6KPE/Lc+pnsKmphBcmwgg+suekYE?=
 =?us-ascii?Q?AYNotjLhQ8DZCvCOD+FuiqdkX2QbiQ3SsNluhCeuZnQwdyCP1NMernAkbfJ2?=
 =?us-ascii?Q?I414rNh+MPe24wqDjd6oBtJVOi8LnetaPqOdF97Vzp046dovZTq+d8cuiNcE?=
 =?us-ascii?Q?wUJO9+yeJVKe4pQFKmDUHjoo8DMAnmCqdO41q8n4uHzldInN2pTc7jcqj/9W?=
 =?us-ascii?Q?8Tu7961wvfNRhpOdTuIgSg936ujyWoCouQ5YLu2a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8787cb-eaca-4a78-247e-08dd657d4d69
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:58:20.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+e/SK165xQ4zMgOBj1S1hv077GtIoAOyA15L3iohxaxJCetU8zkcuwdZTFoLTjlHBckZO2SA4R7G/cPslJ38Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

With the introduction of scx_bpf_select_cpu_and(), we can deprecate
scx_bpf_select_cpu_dfl(), as it offers only a subset of features and
it's also more consistent with other idle-related APIs (returning a
negative value when no idle CPU is found).

Therefore, mark scx_bpf_select_cpu_dfl() as deprecated (printing a
warning when it's used), update all the scheduler examples and
kselftests to adopt the new API, and ensure backward (source and binary)
compatibility by providing the necessary macros and hooks.

Support for scx_bpf_select_cpu_dfl() can be maintained until v6.17.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst         | 11 +++---
 kernel/sched/ext.c                            |  3 +-
 kernel/sched/ext_idle.c                       | 18 ++-------
 tools/sched_ext/include/scx/common.bpf.h      |  3 +-
 tools/sched_ext/include/scx/compat.bpf.h      | 37 +++++++++++++++++++
 tools/sched_ext/scx_flatcg.bpf.c              | 12 +++---
 tools/sched_ext/scx_simple.bpf.c              |  9 +++--
 .../sched_ext/enq_select_cpu_fails.bpf.c      | 12 +-----
 .../sched_ext/enq_select_cpu_fails.c          |  2 +-
 tools/testing/selftests/sched_ext/exit.bpf.c  |  6 ++-
 .../sched_ext/select_cpu_dfl_nodispatch.bpf.c | 13 +++----
 .../sched_ext/select_cpu_dfl_nodispatch.c     |  2 +-
 12 files changed, 73 insertions(+), 55 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 0993e41353db7..7f36f4fcf5f31 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -142,15 +142,14 @@ optional. The following modified excerpt is from
                        s32 prev_cpu, u64 wake_flags)
     {
             s32 cpu;
-            /* Need to initialize or the BPF verifier will reject the program */
-            bool direct = false;
 
-            cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &direct);
-
-            if (direct)
+            cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+            if (cpu >= 0)
                     scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+                    return cpu;
+            }
 
-            return cpu;
+            return prev_cpu;
     }
 
     /*
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 343f066c1185d..d82e9d3cbc0dc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -464,13 +464,12 @@ struct sched_ext_ops {
 	 * state. By default, implementing this operation disables the built-in
 	 * idle CPU tracking and the following helpers become unavailable:
 	 *
-	 * - scx_bpf_select_cpu_dfl()
 	 * - scx_bpf_select_cpu_and()
 	 * - scx_bpf_test_and_clear_cpu_idle()
 	 * - scx_bpf_pick_idle_cpu()
 	 *
 	 * The user also must implement ops.select_cpu() as the default
-	 * implementation relies on scx_bpf_select_cpu_dfl().
+	 * implementation relies on scx_bpf_select_cpu_and().
 	 *
 	 * Specify the %SCX_OPS_KEEP_BUILTIN_IDLE flag to keep the built-in idle
 	 * tracking.
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index e7aee9aa4841c..4813f1cc8e950 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -888,26 +888,16 @@ __bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
 #endif
 }
 
-/**
- * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
- * @p: task_struct to select a CPU for
- * @prev_cpu: CPU @p was on previously
- * @wake_flags: %SCX_WAKE_* flags
- * @is_idle: out parameter indicating whether the returned CPU is idle
- *
- * Can only be called from ops.select_cpu() if the built-in CPU selection is
- * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
- * @p, @prev_cpu and @wake_flags match ops.select_cpu().
- *
- * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
- * currently idle and thus a good candidate for direct dispatching.
- */
+/* Provided for backward binary compatibility, will be removed in v6.17. */
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
 #ifdef CONFIG_SMP
 	s32 cpu;
 #endif
+	printk_deferred_once(KERN_WARNING
+			"sched_ext: scx_bpf_select_cpu_dfl() deprecated in favor of scx_bpf_select_cpu_and()");
+
 	if (!ops_cpu_valid(prev_cpu, NULL))
 		goto prev_cpu;
 
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 6f1da61cf7f17..1eb790eb90d40 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -47,7 +47,8 @@ static inline void ___vmlinux_h_sanity_check___(void)
 }
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
-s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
+s32 scx_bpf_select_cpu_dfl(struct task_struct *p,
+			   s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym __weak;
 s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
 void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 9252e1a00556f..f9caa7baf356c 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -225,6 +225,43 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
 	 scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) :			\
 	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
 
+/**
+ * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu().
+ * We will preserve this compatible helper until v6.17.
+ *
+ * @p: task_struct to select a CPU for
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @is_idle: out parameter indicating whether the returned CPU is idle
+ *
+ * Can only be called from ops.select_cpu() if the built-in CPU selection is
+ * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
+ * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ *
+ * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
+ * currently idle and thus a good candidate for direct dispatching.
+ */
+#define scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle)		\
+({										\
+	s32 __cpu;								\
+										\
+	if (bpf_ksym_exists(scx_bpf_select_cpu_and)) {				\
+		__cpu = scx_bpf_select_cpu_and((p), (prev_cpu), (wake_flags),	\
+					       (p)->cpus_ptr, 0);		\
+		if (__cpu >= 0) {						\
+			*(is_idle) = true;					\
+		} else {							\
+			*(is_idle) = false;					\
+			__cpu = (prev_cpu);					\
+		}								\
+	} else {								\
+		__cpu = scx_bpf_select_cpu_dfl((p), (prev_cpu),			\
+					       (wake_flags), (is_idle));	\
+	}									\
+										\
+	__cpu;									\
+})
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 2c720e3ecad59..0075bff928893 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -317,15 +317,12 @@ static void set_bypassed_at(struct task_struct *p, struct fcg_task_ctx *taskc)
 s32 BPF_STRUCT_OPS(fcg_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 {
 	struct fcg_task_ctx *taskc;
-	bool is_idle = false;
 	s32 cpu;
 
-	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
-
 	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
 	if (!taskc) {
 		scx_bpf_error("task_ctx lookup failed");
-		return cpu;
+		return prev_cpu;
 	}
 
 	/*
@@ -333,13 +330,16 @@ s32 BPF_STRUCT_OPS(fcg_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake
 	 * idle. Follow it and charge the cgroup later in fcg_stopping() after
 	 * the fact.
 	 */
-	if (is_idle) {
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+	if (cpu >= 0) {
 		set_bypassed_at(p, taskc);
 		stat_inc(FCG_STAT_LOCAL);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+
+		return cpu;
 	}
 
-	return cpu;
+	return prev_cpu;
 }
 
 void BPF_STRUCT_OPS(fcg_enqueue, struct task_struct *p, u64 enq_flags)
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index e6de99dba7db6..0e48b2e46a683 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -54,16 +54,17 @@ static void stat_inc(u32 idx)
 
 s32 BPF_STRUCT_OPS(simple_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 {
-	bool is_idle = false;
 	s32 cpu;
 
-	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
-	if (is_idle) {
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+	if (cpu >= 0) {
 		stat_inc(0);	/* count local queueing */
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+
+		return cpu;
 	}
 
-	return cpu;
+	return prev_cpu;
 }
 
 void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
index a7cf868d5e311..d3c0716aa79c9 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
@@ -9,10 +9,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-/* Manually specify the signature until the kfunc is added to the scx repo. */
-s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
-			   bool *found) __ksym;
-
 s32 BPF_STRUCT_OPS(enq_select_cpu_fails_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
@@ -22,14 +18,8 @@ s32 BPF_STRUCT_OPS(enq_select_cpu_fails_select_cpu, struct task_struct *p,
 void BPF_STRUCT_OPS(enq_select_cpu_fails_enqueue, struct task_struct *p,
 		    u64 enq_flags)
 {
-	/*
-	 * Need to initialize the variable or the verifier will fail to load.
-	 * Improving these semantics is actively being worked on.
-	 */
-	bool found = false;
-
 	/* Can only call from ops.select_cpu() */
-	scx_bpf_select_cpu_dfl(p, 0, 0, &found);
+	scx_bpf_select_cpu_and(p, 0, 0, p->cpus_ptr, 0);
 
 	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
index a80e3a3b3698c..c964444998667 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
@@ -52,7 +52,7 @@ static void cleanup(void *ctx)
 
 struct scx_test enq_select_cpu_fails = {
 	.name = "enq_select_cpu_fails",
-	.description = "Verify we fail to call scx_bpf_select_cpu_dfl() "
+	.description = "Verify we fail to call scx_bpf_select_cpu_and() "
 		       "from ops.enqueue()",
 	.setup = setup,
 	.run = run,
diff --git a/tools/testing/selftests/sched_ext/exit.bpf.c b/tools/testing/selftests/sched_ext/exit.bpf.c
index 4bc36182d3ffc..8122421856c1b 100644
--- a/tools/testing/selftests/sched_ext/exit.bpf.c
+++ b/tools/testing/selftests/sched_ext/exit.bpf.c
@@ -20,12 +20,14 @@ UEI_DEFINE(uei);
 s32 BPF_STRUCT_OPS(exit_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
-	bool found;
+	s32 cpu;
 
 	if (exit_point == EXIT_SELECT_CPU)
 		EXIT_CLEANLY();
 
-	return scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &found);
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+
+	return cpu >= 0 ? cpu : prev_cpu;
 }
 
 void BPF_STRUCT_OPS(exit_enqueue, struct task_struct *p, u64 enq_flags)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
index 815f1d5d61ac4..4e1b698f710e7 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
@@ -27,10 +27,6 @@ struct {
 	__type(value, struct task_ctx);
 } task_ctx_stor SEC(".maps");
 
-/* Manually specify the signature until the kfunc is added to the scx repo. */
-s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
-			   bool *found) __ksym;
-
 s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
@@ -43,10 +39,13 @@ s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_select_cpu, struct task_struct *p,
 		return -ESRCH;
 	}
 
-	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags,
-				     &tctx->force_local);
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+	if (cpu >= 0) {
+		tctx->force_local = true;
+		return cpu;
+	}
 
-	return cpu;
+	return prev_cpu;
 }
 
 void BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_enqueue, struct task_struct *p,
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
index 9b5d232efb7f6..2f450bb14e8d9 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
@@ -66,7 +66,7 @@ static void cleanup(void *ctx)
 
 struct scx_test select_cpu_dfl_nodispatch = {
 	.name = "select_cpu_dfl_nodispatch",
-	.description = "Verify behavior of scx_bpf_select_cpu_dfl() in "
+	.description = "Verify behavior of scx_bpf_select_cpu_and() in "
 		       "ops.select_cpu()",
 	.setup = setup,
 	.run = run,
-- 
2.48.1


