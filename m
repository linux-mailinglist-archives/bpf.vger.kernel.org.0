Return-Path: <bpf+bounces-54039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF32A60DD7
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB40117BA89
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361161F3BAD;
	Fri, 14 Mar 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IkpTlegp"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7691F236B;
	Fri, 14 Mar 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945788; cv=fail; b=eQbrfIpUcwHeBS2MTKdY9z5VraVEdYmBgM2MzqCH5AREj1mfTpZxH3SM/O4aGl2H89Hy5estlHLfk8LpN908YpdiMfd/gzOrPRaOqrjvpxhEf0xwFFLnEveYpBh1qVK8HUcxUIp7ZUFxHR+tGYtiDRcd6drSr74+0QISbQO8bQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945788; c=relaxed/simple;
	bh=2z2tl6EGi0Fkp+AOarwDWTm6SH+nMXLI4PoENK3cf2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0whWku3Qr/MG/ofKmFwL9O/Onjapj3RjOHFdTxmaL1Tp2C2nWp5fsYcn9qjfi1xzM4K/cdkJGE/REE0U0IVJ65T4GIgnczIE28AT7GacThiyD7pPimTXMfAMK/2rSnmRDuEB2XxMvsuZSnasMmqLu/YZiJx101iMqm8iFTS4nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IkpTlegp; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzklExXiqKrULfeCoh6XOMBHNyNJ+YZ3EtPzL/aQIhV/h7/VcQ3hbK1+/AnT1w5nO9JTmZeB9Ck/CfC8o7ki0Kecw3hU9IBvaD25p91Z4FS2iC0vmfmwhUepuKVbJ2mXbHwJcHPjUqbu8h8wlCQAbJ/LWxQ4zTQGreK7ScJD7Puw8WigrudUdc+wll+lG4GkTFo6KEZZTFUh/G4tXpcxAorx6ZNbKiJZsEzR387pDZsYktVJiFf+Fj8LupzYP0X2lzecsy0KGzQ+AnYuXjP50Q0wFdgRJAkPXQOpn8X2W55sG0iN9Hp5lFyaJX2D4jKrdlhwLMDsVe/b+vp/pTJYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbrcSYpYfXxpoYSv8bqXb1Cw0q/XhBW9hmEoKDk2yz0=;
 b=ZGoW/gwgJkJNoRfgqAer/WaKkVEIBMRlu8UNTf/bIZP7rLMKwXP017mBwVu+wUFFKEBHyAM+GnigsEmWtbcmWstJl/eI9qjUpSNCFRbyVbIOoANj/5BRfNtsSimBYcgPV1gIEO70u9q2khc2rxeeK1GqUwfucQjxz6ZfCu4/NC/2RvmogvRgFuPodR07CWwTTKvJGKRO1RDUZpXVC9nkp2xMtuO+mFGVZi0sbIpxpFLkgH4VNVr3k1rUNVJeBLZSADVas193120ZmmbvDi/Fh87C70UpUtUq1r9PwEZgnud0heWHyuqIu3E2KnY+JnAMe26C/YahjPBPIjGV9QbIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbrcSYpYfXxpoYSv8bqXb1Cw0q/XhBW9hmEoKDk2yz0=;
 b=IkpTlegp+tgCCbQruqeLYPWVpvrBd+engqa6u+YNive8CHs+tsOIMDrsB82jCVxXCOcNJ3fV3AiV0wbAfbuqcL736kd4VV1lqDM5H+I+Zy941CWjjbIw8yjAPysA5lucZLBHb/fDTZ0r38r7xlNdWxQ0Zx2z3iot72iipuoXxQfxTovXRlnlBYZyHJW1+pZs+tx77F9AF6VaO1ElPY6+0XkyYr/t/LT0C7ZT1USK73eGeea0XqdgR3ZhNhH54IQSBtu9OJkN7K9v2Tocw3K/vaC9eUVF2sgzSOPCcxToTL0sxd/IUnL/WT3CJ9QKaOPO00RLcWppdWxSnoWTa8jUww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 09:49:43 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Fri, 14 Mar 2025
 09:49:43 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()
Date: Fri, 14 Mar 2025 10:45:40 +0100
Message-ID: <20250314094827.167563-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314094827.167563-1-arighi@nvidia.com>
References: <20250314094827.167563-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c735432-b4d0-4445-b3b9-08dd62dd8bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1yXPsYRRRFeiKKdKz4jcr4okmkanJedVGj98nO35Op+NCZQWL/73qjJu60TE?=
 =?us-ascii?Q?+dPyyTSosYimC2OhqJTB/pKJHEVzN2VxdeNOEiSKZBF+R6t7V/H1s0iAkfjt?=
 =?us-ascii?Q?antPxzsABil7+r0ehLWnhcaqyLlWZ138DX4P7Q6wSC1SbiE3C8SHX2lHca5y?=
 =?us-ascii?Q?Wu0jZfVbq2VxRS0aNcvuzqy9hqJ9kOos9OChbrRU6IihRsGpZqdLEratG6S+?=
 =?us-ascii?Q?+b0oiCLZ5TfI9ec/jTiQM/YEC3XYXHhIRuCGXBD6MCkSJHR3EzdoOrskXdst?=
 =?us-ascii?Q?G60Unjl+afFzctTsKaC+T/vs/wEzIIklr/h+24qThBJsZezwiiRrrXLIBIIm?=
 =?us-ascii?Q?BunD9H4wOkmWc2KiZHPIMZLhLMszTbOH/OlX2kG34moDeYlAgn9o/H80q3JI?=
 =?us-ascii?Q?sWabEycnpBEuz1zaVDZX09yqCKybb5bMsajVmG+/Vc/kt0Mm1Ov+d5tCfnMg?=
 =?us-ascii?Q?xg/eswKOjXqqdJvNP4ht7TkgWyyg8EDs5ffIxKRTo4WaEkfKifCjKGLzTd9v?=
 =?us-ascii?Q?90wx5srQoN5lx0xIM7DEVmgRhNhSTevitXubRcvi4jqJQDDRjB9aDRMVB1WB?=
 =?us-ascii?Q?GKaG20AjxjtvK2IZANQzGlmk6UO/ORMI2f6/h2FjrfV+fqEo1yIRUeg46Xsp?=
 =?us-ascii?Q?j1awVALBJw0URlm9Ld5BDvXTLhnQ8t6sR8/J1CX9U4wvEcVqn0ImCx+5rwGE?=
 =?us-ascii?Q?u/mywi1L6C1LezuPkb0jAxId0ruoS7lpkf4EXQvipFNAbxnfjyYoZClOWlRq?=
 =?us-ascii?Q?jSDmx6GmCSmAdIhO+dYBUU5BaoU5cIZoPflZgVi3fMVctiRc+NEN+x7/t1hC?=
 =?us-ascii?Q?+8pk4OAANEH+PgtobbgiZ3JlujUe4m5lKR6RUxx2cXT+u/h8bPFL4awJG1zD?=
 =?us-ascii?Q?BJOnQRm+lbVNZhvMiuRLr21ngPPosFzZ6QtETzawKkunWKq31DwDNEOCM+nh?=
 =?us-ascii?Q?JpSXb7ociY0nAGegCxnswxubGoH5qlbdsGO/FRz5H5GY2J8296LoT9OxRdPL?=
 =?us-ascii?Q?KD5ADA7QLCP70g+shDPssHFr81YsKLchvBVZrpJyu6PH0cSMnbkTyjyJO2WZ?=
 =?us-ascii?Q?iQWS8blpBqPXaStsrdquWCYQMpttcEnJ+qcS/7NIeVrYTQGGmDrYauF323G3?=
 =?us-ascii?Q?5bnvCcLmRx5h8HWm7gKUQI6dUmjpW1RpMCW2ZTzV1IXa3BurJ2AfH9BpcwSE?=
 =?us-ascii?Q?sfysFBW4Ua3NvK/Na6qIHB1cnVJ9Z/iSCdCe7U6f3B64YFMVSv88C6QPjIxu?=
 =?us-ascii?Q?uiSPa/JEc3hk+mYvU4jlET4TSB0n5HWKdJw1dXDYJNaaqyHLO/7k/4Yrn6Vx?=
 =?us-ascii?Q?OAuM1DCGA3qZuFFzsbf7pxU6+E6qU6ObBp2brUNCIpsvOC6HpITL3r13OqHJ?=
 =?us-ascii?Q?HzkYJ/DJDcLsMPPjUnPFKqoA0NSP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zGfmi4pUsbBcI9+mzTesTr37vu4OwYXaq1qLmayQbYNqnaDjDE+lguoD/mA0?=
 =?us-ascii?Q?jFTjXxWvao9PLFhfi/JUgneI34tsKv+/iNexZKUJxACzmCe5TCu//lwqV1vj?=
 =?us-ascii?Q?AO/pGRBoaFXiVFVu6ZR9zQLoMd3GbQDTyfrL6+iHVB2s1Y5lP14MqZFSOX2M?=
 =?us-ascii?Q?nzP7QPQpNBHP9rOB2d0kDJKq1BD1b1XNc4sgD957STX/FboJ0ob749S14czK?=
 =?us-ascii?Q?VqxNeAjBlsH/jFQz23vBBOuNSCJRtPCiPKSsGtqf5HJjJmRinjys//ivpP9+?=
 =?us-ascii?Q?51zib6PbWRbzP0QkKs+MZc5N1GZEmHmqm6aHUhenOb3B5vErAYw2HLYWSraM?=
 =?us-ascii?Q?qDZhdx6BlZTdNtS4Ld3805HH0sYPeCW7f1FGA7oOquLRtKifOlTyGZ99L+0k?=
 =?us-ascii?Q?ZWLkgUV0VS52jZyZAOGy88rsSFjyD8VEoR0xj+O3mp6z6bip+BLQNWJuUFwE?=
 =?us-ascii?Q?tI9fsQFFwkO5Diw8n2WRsCfpMgcD6kNUAzxUjpxEHQDI4ILRoPFMPZBmbXqr?=
 =?us-ascii?Q?MX0+7NMZBYsfs+3iI2J0mIing+qWQ7MN/1mGGT09GfusFaSQQoCSVDY+XqvL?=
 =?us-ascii?Q?lVY00mN548lYfeXH2WogTa1QWuD8U/WdDJ/LPh+cKxoiIHpH22NUUM2hYw4O?=
 =?us-ascii?Q?+AaGbSOOi1cCMSzKWTVqMsNcgpzjP4NOl0T4hfAmhPWcANen88BW08YtI7yL?=
 =?us-ascii?Q?J+iMq7xqLGQvcIoWzHnFgFTGY+K/NJe/cn8ixouanXCZuC3Qw+DXjhnbC4O+?=
 =?us-ascii?Q?SC/l3plooZd8MdEwyYrsjzK/7YSfKgOfBebESr7Hd5wra6awLOIeOfQARsUq?=
 =?us-ascii?Q?7m7EHRcdYX6ku0jGG+vwB2Ymi0XgJvXz+34LS182eF7L/uWMXugWgFZZtbh2?=
 =?us-ascii?Q?+pnfl0kUnl6CneUL9jrSNHWycJn/KIsj0LXCw8GjGKdCyYmcACDJ4psYrXcZ?=
 =?us-ascii?Q?whkvVvx3iwZ/ATRU7NmJBVBzeoxct5n8cF3zoVHgEdr3y7VAnxufmuFA4Hwk?=
 =?us-ascii?Q?gFeCbVC6QRrsa3/3jhdm1lEO69KJKuw4pTW0/piHbDv4+xmmPuRo6FnxUs/x?=
 =?us-ascii?Q?vVmyXBHNmdZ23MHBedIOJZJUtn9j+0N2o8BMZeCAPeUJ6CE2AUTxQzz29CYl?=
 =?us-ascii?Q?Ex3ksYiGpvO2tu3IqSCZTNIyqwDgSdi3egMQmN85Ca504BwmNqIS4o096ubb?=
 =?us-ascii?Q?/Q6YQEzvzq8/sE+Z2gkND5lETRSaJeONB04/CwExeLoUaCYTjBCA3HXzO7Pf?=
 =?us-ascii?Q?JvlWXtycqlHDYhzVVbhND9L0imUQU7tkGrL4gz8sNcNpRDx+jREDTa/Wjmen?=
 =?us-ascii?Q?MckoPTXf7ZQeZdmNJLiptgoNxcskpMJElLucwmEM/MIe2F11P+FHunODbt7A?=
 =?us-ascii?Q?JFe+SQHcUw4mgS6/fE+q+KM+swquwaozaTYJ62R8Q/cWxwXJut4IZAhsUGj3?=
 =?us-ascii?Q?jE4Hcf1x0oJNJbaO4hz4iqq0zk4N3uIung30T4EeTN8xqFzRCiJa0lKAWN+n?=
 =?us-ascii?Q?rTIL+F0IXMroC5Cze53e9fXbR2X8LBzAeU1/rhhVQZ8fSOkwWrSvGbcssSYR?=
 =?us-ascii?Q?3vCMNZDfqOyojw0W1QtPl0TYIbG7Y4L1icWYjYAB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c735432-b4d0-4445-b3b9-08dd62dd8bf4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:49:43.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23cq3Td+3Rj8LsD3DIjsTuYCio0A682UbqdOL2DuwO909rNupx6FWtubkDGx4bONAIWY2WEs1nW9HWjiySe+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431

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
index c0de7b64771d4..2fc5e7972eed1 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -872,26 +872,16 @@ __bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
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


