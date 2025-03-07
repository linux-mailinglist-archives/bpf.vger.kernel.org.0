Return-Path: <bpf+bounces-53614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69336A572AD
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCA71794B7
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC605256C7D;
	Fri,  7 Mar 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XolBcwG9"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C52561CC;
	Fri,  7 Mar 2025 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377962; cv=fail; b=SwynGMt+CLIuGsEgAE9Ibbf6R+UzblyxmkI3fm/idfVwARTsGBmDXd+MpqBTgEQWltiOssChlEVwx897XnUEBeFt0GfruFECF0Tt5XNPUBW+7eZ/OF4ooWvgMxzHeQ+ZEiuG4MYXCnNXROcSCKKmi4AFiCWiiwMJqqjljpREtSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377962; c=relaxed/simple;
	bh=QFOV/iYcA0eBiUgZs8+7I8sEB0YNuViofplXbWoQM2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EyqSM4i1gv9GcWfnCjchC8mhiRImLF0FvSQhq4cVV33HKr7iUDzVnXvuNBWfdn+yTddGqU2vFz5MwXQ2jK6mGJFZ66wavrx887Lh3soZixd0PFiLfCxRiCGA+VGEk29VziH3aEVFjQCukFb1CL3u8HL7dyycpMXZyNWOY86quj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XolBcwG9; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw/FNmadp8tCGA0JkPPnIE6KSKWFfvYVrPn8P/2JBLOmHeeL/cjD9EICzK+HZdXU8nBSlxzb44ikFqi9Xf8Fm9/ZFs1qVmJ2GlHu+xC9vQIKlli3M+vIzoiU6/FQrjPzUsBl7VldPJrk4LBhQaLH7okOhzrZv7tJPcWJIFQdzH49g6mRoWMv3JIKnb6EhYP+izXfOarHrPcIEhSfVKxd9qIkUI34qMNX8kdoHhpEm0Kap34ja1oYY8UU4aSMdOzWPZMa3zBkt3vnGyrnaBNTp9XJXSX1KTs9V2fw1ag1OK2MfWfcL39+fNLqJ9ya+jU1v5eD7xsHuPiVrCUBlGhBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9wI1AjZGLOOPZAg6jZqGG2vMCy3+klhu596EqDnDPY=;
 b=SSuC3az+AQu8BeCtFysDof1UVz4uEbZlepW8dUEW738jYUGdvJRvBQircD7FzrWuNltkDBR/QtYw5+oSK5ctqpAefcJMWPSzM0sH0ygJKFx7xNmJukgMctCGWSxIrk72egC80quGAJdLL29dyvh8LXD1E372SFjpQIcAAbdjrQt5OsJx/FRXuaSupWwvRL75s6Md/SYti8OhHYkBv2bG4wYciLcq5KASpNSfEyYGjJp5YrXEBhQ7MgjC9rWgkAC7+T8I2d3VDEaRmuMXVqx1VaxcyL2jai3cgYrEwu1RPS5Ml9LTnFIyFTuDNvyI0MsFhsOzDHzl+hlZSio1irWcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9wI1AjZGLOOPZAg6jZqGG2vMCy3+klhu596EqDnDPY=;
 b=XolBcwG9h0BGt0M7uASBUva7TGr0Np9iUx/DIxyZUQD/dN7p+qhCjFj4WP8xxQGIWoym12lCEmhgOBi/TQrivv3mSdNBxY7r2JXCuNLNMxFRgbNsrQGfZX5bZMHWBIaP5X/ZrHiTSnkT4ic0iYNPD62rQ3YFL+fczIwgww1tAgzJWN/337ki9Y0+jd9k4mUhQPVi9ydAKZ5ci2ds4mD9slkcjzBP8TsWR7sD5laoX185u2+dl1mUFjuYTDH2GrRF1+/8NaoKq8FnPrZfooMWqhUxug/pZZcJWwvaYbZltIi0prnmAsbm2RYLBLso+bw+Dn6sPmqETuyZ3V2sH4vmeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 20:05:57 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:05:57 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()
Date: Fri,  7 Mar 2025 21:01:08 +0100
Message-ID: <20250307200502.253867-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307200502.253867-1-arighi@nvidia.com>
References: <20250307200502.253867-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:254::34) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: cd785b2f-76aa-4723-36bf-08dd5db37917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q79CWXoP3h/MIXB97CPLxEcSYVbDV34kyRUT0DlcJBoD2VJd7LiMLOnXRtjv?=
 =?us-ascii?Q?ZckYGiaH0y1w/UYD6VSf7BqQXqAht5fRc0XG2ZolCeJQeGdcDGiQluKLHYcE?=
 =?us-ascii?Q?/aKkV3+yJoDXEkP7nU1uz/GuPd+Gdl3KczKXl+vwQmrfxYYlWVnr41WZt/h7?=
 =?us-ascii?Q?iFBcBeiWKiuwLFeb6Fsp4tm3ZGLtktsJ7aSQ0SC0wbdwwNzWiZ5HamWiffPe?=
 =?us-ascii?Q?t68ct3Z6WNwqKBNEh/0loIPMxMhzWt1WkldPqeZENHAFTvKhMSOC1UFpoc5u?=
 =?us-ascii?Q?pk6c6ImY3Q9Is6VO1BbcWrJcZGp1wU7t+99NZJ40ntGu0xYCKX/yiTi/SU/4?=
 =?us-ascii?Q?PZxtJdyejNWCSGkKDLR0hSwTcr9aiSTI/xH4JOUNZRJi5Oop86xAU3VEYLgH?=
 =?us-ascii?Q?cdh2aAF0DqY8Jys8qBdSVmS+DKRRUg0hqQvhFbwQF9dUZ8JtRJKT8v2EJdVf?=
 =?us-ascii?Q?1jbH/FV8Z7zVo/M93Ue2+zXxqCsg2BcPzYjRF0OfUawlZIFmQeEV7jqfOa0O?=
 =?us-ascii?Q?WcAS4QzS3/BXvA+955Te9+pFluKjjjOvwet7aTXe/0s/L0owxjcCoSeN9ZxC?=
 =?us-ascii?Q?NhPY2vtEZQl00hESFfhMjqytGJdKDUvch7QaUOizslXqml3A7BbQAYR/jOeM?=
 =?us-ascii?Q?nd358sKvA5L2x2I2tjaZK3B1ASENjpXFn28UVEq21KZNhbX0wCqvPbE5bVdn?=
 =?us-ascii?Q?KNXzkq9ycpThKC3I99ppyRfOpBOmLQujjrjknCpRoc0ekzKOzGe9oNsJSdR8?=
 =?us-ascii?Q?MotJkHKOuzOpiiyViey8ufYmIPTeBYZbYI5qXF32zejB6or0TMFicWK5plCD?=
 =?us-ascii?Q?v2ORXHChMgHANmv5OA6J4mz075/iZXNEUGVoN0MLjWZ/8uEJJ9T96sRR19nW?=
 =?us-ascii?Q?Xj8IfcJEzniPHme3p6EGUEpHolMWwai2jIiNePguwaF7V7xO4MmSsREus6NU?=
 =?us-ascii?Q?is2eUoN6f5Bt1f84fFes4gaihX5OnmTNCsH+p/e00suRQd4v6v5hu9+0YdWP?=
 =?us-ascii?Q?+dk27fOs+OJBb90AHUq23nMYD5iP/vZpBOHkkBIKkfUHhpT6wX5zqKXhN5Sx?=
 =?us-ascii?Q?qyGQ4J3oS9XGUHRPXH2NDm0Ij+zldltgZElAtJ5B245+8NdyhhpjUNYqJZgD?=
 =?us-ascii?Q?BdCJxmFovED97r48kLC0FNMrJBP8JEscrhpf8ucDVgbrcvWY15l18hBbRPcS?=
 =?us-ascii?Q?uP4u/cQMvNiOtZhfS8YQYpdqO+p5gFA2sqU9HuJTRzne/1MZCw1vYRch2ENR?=
 =?us-ascii?Q?UJSv5iy9j3xpt2xNc2IDqdTDDBpU3kXXFdRhiXEaewyQWiYU3oSjwhzLqh9T?=
 =?us-ascii?Q?reslHF7L5SR4INsdjbVH7rZryZ/jIJk9uAmg7FlbqwfZyvTN5YJ0nKXzdeCm?=
 =?us-ascii?Q?NlavGXjq7bHe1R8uK2A2TKgYX41G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wrGt9gponf+/k3NmR3EXK2u9xC34QFf3AXlgoB2LY3HbOtcMoPioElZgVQQa?=
 =?us-ascii?Q?Co1kcOhJHpE1uSAQ8FNhjTHCBeU7RXL0HBCZNaC0G9EGOdkrBOG66mxk62HA?=
 =?us-ascii?Q?FWPpQkdXe3Z7bkGnjkyIbWyH1Bv1q46uYLQbaDp+FATu7y0okWv2xRbVq7xW?=
 =?us-ascii?Q?R5Y6lrfcIuwgf+p9l/bSizxUJ60n55RRw0ouV5aHaM+BY34/T7j3We2f9r8w?=
 =?us-ascii?Q?jkAzPrySEvnghP3gOk097KUrMtckKz8Qsv0VIXVdN7z27Azu6vJugcfRAXwd?=
 =?us-ascii?Q?DupuuiWHsUXaRIWyUtOsWa+TSq2GaVGPa6gC88Aux2v0bPRhrT/AQ37GsNDR?=
 =?us-ascii?Q?xlTaKQU35tkRCtu8yGEEi2dGh2kS0NWr+daRctQJtzzDHxy+lh3StFVco9Ve?=
 =?us-ascii?Q?QsPVA97ytYB1WCkL2VvMQNc5jhGPJDeDis3vT+5A6Pvtet4QA6a2UHUwf6z+?=
 =?us-ascii?Q?lOxc7ICz63ArnPzRk+GW248XMub9ZwOBTxX3hocK3fEtefoSYbs/LmURTsUV?=
 =?us-ascii?Q?0q80jdaVkvsQhAQrohyrepI+KFy26hvmpo6Q5cKw+VbY/rFvGbaeU/Ntktnt?=
 =?us-ascii?Q?lY3bD7H6wTtHb64h4rnpbxEOyhDbKXP/s8BrXdedvATK64rMlWYbgEAMaaXA?=
 =?us-ascii?Q?PP3Lnl+CQELZEOYvhgXKbjUEhGta5joktWLexs2SJpK3VTQY0l9ubxzEbCzb?=
 =?us-ascii?Q?BBefswsqbgqDJrCN/0eAq/ws9LT9L3v/KAfo4a47tIXpIFtYuCboQNMVw6J6?=
 =?us-ascii?Q?fiud81DkX7uTUY2aEvulaE9dLSeqTPx058mGWsuXxUTTngpwHcy04ceuasn6?=
 =?us-ascii?Q?waRYcaI+7vlLt53KtUuDBbO+uxJQ4XIx2uNZAQZ93BqOEripPUhIpyr30sh1?=
 =?us-ascii?Q?k9NBKm/lJ/ZborDDzSmnQuzv3D076hPGjn9tOJ8fsUPMWSXkhFWtrD3gB8f5?=
 =?us-ascii?Q?7n9mG0SLTgPkQZ6c73poNup9lSCO2WLZvyyCdvfLm9OCmjsnrekWynZSoTyj?=
 =?us-ascii?Q?RP+XbpdIVkh7Ge1LZ/VQ0OoWZcXbW4bn6KrgJzkkiaAikCxJOCa/3OR/4crJ?=
 =?us-ascii?Q?XKDrxszGvrrUquJ+F6duHeOjt4cSttHL5l5ue1PwLYlNRCBbhCX//vTZs82R?=
 =?us-ascii?Q?xBtiRkw8+pDMan4joiASGd+uBjISvSQOmFUfvRBrsyycmxYGD3xY7hTv7W76?=
 =?us-ascii?Q?f9YksZJbA5SLsARCEb/K3zJtyI/8bhD/KmwaZI7xEDaxq6NxbceGygsF7xse?=
 =?us-ascii?Q?cj/vbtqrGd62kInLymgeXNsyC38nf55OOwl44oz//egpnMSdpANsbFufExq3?=
 =?us-ascii?Q?nhY/Na/m+ApKphkQ+/wpIB1BhjnogvFDi7AfvQSZISANa4Pst3+HOWn+fiML?=
 =?us-ascii?Q?SxxUW7k9NWyXsq0ZuCsapVGOWwQKkqNSF1NIbwvxeH9sBXR6ESsyZ9h0Vf3/?=
 =?us-ascii?Q?hZgxsigleLWHT7oggoNEKQD14UnZki3C/HNj5roNZFV/ZVXFPZQbqkmd6SUN?=
 =?us-ascii?Q?Ph+O9A6KOKgrTK7y1OABeGFdwupLYb9zfavUgEOpVizvZ9VJ1QE0PpbBRLmw?=
 =?us-ascii?Q?i4JatbGX1TFn6afrJ6wxDpLgRxHCMDA/9tMXrAPC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd785b2f-76aa-4723-36bf-08dd5db37917
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:05:56.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNHSom7yNntVTRJuSF0Fg12YjKlRZ7SDf+gseO3Vb8v5FkdZHqBv/GrzeY4AF5wPv7xRTMHBngUsxj4A0RBF+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554

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
index 0993e41353db7..a3abdbf682681 100644
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
+            cpu = scx_bpf_select_cpu_and(p, p->cpus_ptr, prev_cpu, wake_flags, 0);
+            if (cpu >= 0)
                     scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+                    return cpu;
+            }
 
-            return cpu;
+            return prev_cpu;
     }
 
     /*
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a3c7c835ba857..5614a2f7e8dbb 100644
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
index 1977b1368da7f..e127aab4a286b 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -855,26 +855,16 @@ __bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
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
index 16e38b46807fd..9b830f17b6380 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -47,7 +47,8 @@ static inline void ___vmlinux_h_sanity_check___(void)
 }
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
-s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
+s32 scx_bpf_select_cpu_dfl(struct task_struct *p,
+			   s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym __weak;
 s32 scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
 			    s32 prev_cpu, u64 wake_flags, u64 flags) __ksym __weak;
 void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 9252e1a00556f..2f43b3fa16b73 100644
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
+		__cpu = scx_bpf_select_cpu_and((p), (p)->cpus_ptr,		\
+					       (prev_cpu), (wake_flags), 0);	\
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
index 2c720e3ecad59..3117f3ab2ff52 100644
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
+	cpu = scx_bpf_select_cpu_and(p, p->cpus_ptr, prev_cpu, wake_flags, 0);
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
index e6de99dba7db6..6ad01dd5b34ab 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -54,16 +54,17 @@ static void stat_inc(u32 idx)
 
 s32 BPF_STRUCT_OPS(simple_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 {
-	bool is_idle = false;
 	s32 cpu;
 
-	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
-	if (is_idle) {
+	cpu = scx_bpf_select_cpu_and(p, p->cpus_ptr, prev_cpu, wake_flags, 0);
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
index a7cf868d5e311..6b9d1cd0bb948 100644
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
+	scx_bpf_select_cpu_and(p, p->cpus_ptr, 0, 0, 0);
 
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
index 4bc36182d3ffc..172c0cd339947 100644
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
+	cpu = scx_bpf_select_cpu_and(p, p->cpus_ptr, prev_cpu, wake_flags, 0);
+
+	return cpu >= 0 ? cpu : prev_cpu;
 }
 
 void BPF_STRUCT_OPS(exit_enqueue, struct task_struct *p, u64 enq_flags)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
index 815f1d5d61ac4..42e344bc9e743 100644
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
+	cpu = scx_bpf_select_cpu_and(p, p->cpus_ptr, prev_cpu, wake_flags, 0);
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


