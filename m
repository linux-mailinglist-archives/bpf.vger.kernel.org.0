Return-Path: <bpf+bounces-67260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE2AB41A8B
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1143356506E
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5EC2E8DEE;
	Wed,  3 Sep 2025 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JdjDQdy+"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CD2E7BD8;
	Wed,  3 Sep 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893036; cv=fail; b=lm5QLoUMyWT1xpBa8gMslB4aLpdZJgaT0EtfDDHM6h9cuTVlcGEgwwkSlk7QnSrH9z/l9T/EYOfN8It23LTcfnZ4Er8cJRYfyRb7x85KrKyg4mL+FSBZZ8Y+FsqGDn6ZIpnFHCgmpvk7QZcg23fI88732ryqAwJNVFjMcV9gvuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893036; c=relaxed/simple;
	bh=fpyEYlvs370SQ774pmoZm/0fAKJt2lU5c+WFVMUaGcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i129O5mdmCVxs20XivF1hmmuspd9mNwZdxhlGRNCgzfd5Lj8Gbvf4rzKEfV02JNA3LPaQoH0qusHoW03Gu0zl0bvk2R5x0oqTHIcjThT6AWrsZAffdIFtffHmlRSWus349l7iJyGjArwl5vVPyFbdVezf7pRWfa6nPXL3BH7exs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JdjDQdy+; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3TdCQQhlmvZP4i/FCkNWxwlw1fWmj7p63f26W+x8hXzd81uZOOJ8aUdII1Pfkjlx/N0OJiFR75ZMQaY3dLB7UuC0VY+207MWy8TGL4hwNt1UyBRznIA64nfJFhHUL5qbiOJ1I/J6qMyxyC8JfAc2PPoJ6AckgE+WAivB/Ryum1Pi0TP9cgPO+BpOAUsOUAlpdaraHQoLRoZnFBUWnSANpV+KXyLaXCOo17e3evcRcPBxVBl1uj4WRM0pqNY2AzHi6meDxEJSqV/FvntOM0wnCJbpuHSC7vLs0tNNEcmzdS274XaozV7xEdsWUkf9Fl3FChPDgVFXWfxy7q3da5IoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaDf3WHmPJP9WF/Yrh/bHmAaZxdN5HdPjoEzNyWJzts=;
 b=ummfzjZs4wU+EbEqf6B2C8KnX5Xn4tJOR32ZdO9yct1+R5TydB4HtkY+fnXHaNI4mEbzUmw8bEKa5SPO0bvx3tzXhWNQdfga77LXTO8IlNdNRKOXb4pobV8Mkx6ys7wmh0zRJARUz02gVieT/9NoFFBQryhxDZ7U7TZLH4fJgNMcpYtFukGfLi8RSvAAVxbmr+NXbxqtJ55NAfoDY+yXtVbwD10Tq6F5njGnsdKRE+rOKmy03QcvrxAW1LajJlumpFJ7oGaTclDx3wXn2LJzh5uu4T8ROX2OCmP8VHDiPC9CW2CyZEA8hB06iknrx+C3L/9ZfvOaOfargwIjHXCz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaDf3WHmPJP9WF/Yrh/bHmAaZxdN5HdPjoEzNyWJzts=;
 b=JdjDQdy+q9bQi7w3dhba/3KBZRbnBGq3PxsVhol8M+Ym/+lLOyoU2jWDNkmqHf94QpmToSGaR1l8yHnCNSfmHvfg2OFX6kObT82BmCVTdvsxJV/vfQDS+jKK9GFUll6zEV2RA+M+m6ENT8F+8DAnDmRVaKpupoTERwRKkqsNrxNE/KwoDT0aXohkCLR64eK1PrciE4yV9v6omWOBgNcDtW1asUyrS1pzBxHIPJ6BNzfZW4lQ45PcKdP0m1CQvoXzDA+2gRyQghtq4Fab9wQC3KfofxuZxyBFcg/RBF8GJw1cXb67TUWBdQYa2YXwju1XKjTYzYS/nENQeN4i2fEtIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:50:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:50:32 +0000
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
Subject: [PATCH 03/16] sched/debug: Stop and start server based on if it was active
Date: Wed,  3 Sep 2025 11:33:29 +0200
Message-ID: <20250903095008.162049-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: e31d818f-5a87-47de-a77d-08ddeacf52b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DC3gUBS9vMmkjHp7WQh88hGi6JCrpWa3P2WMar7+wsouRhIYKFhotI0EZ6KD?=
 =?us-ascii?Q?lL/RRrM59sSllOHURvLfwlvC4UrQ1LXcV35ipZNmfF0H1s6hbU8w2XEZZv1x?=
 =?us-ascii?Q?WxPJtzUQWyA352nDgHP2lTcQgUvpuN1+0hBCAOm0mflDLPu/H01lbBdilomU?=
 =?us-ascii?Q?+Fm67lpJFRw+8C6SJlJMOdDh2eFD5HVUBjVmWDwrUJEJROGkdnE+vODP38QI?=
 =?us-ascii?Q?E0RCdflOs4NoV0nTuBrN9S6ivALy0VNaxVprPWZDw1RsCxGFG272H3wj3Sv0?=
 =?us-ascii?Q?ceHYoQVBr7/D00Nl9dkapu9em0cXibbkc0BELMMIlMp2zrmR/BAotXR0e3NR?=
 =?us-ascii?Q?z20/NMwLR4RpOUHpW5LN1F+AierJv9gAL/zBgofcXnaOqzfWuIoqh5/1BP9w?=
 =?us-ascii?Q?an+2r2zR4V3/oNHV7ii8qFlYJvPPdkkgNUN2SGMB0xMaXxbo5Db2j5iGbDIH?=
 =?us-ascii?Q?gJddQ3/Qwc4SKc9awPnZw6X1nHFwjFgK+DDmrwGASPS/iXKSQKsKEC59H2x5?=
 =?us-ascii?Q?RZtaX3T1BJta1aZaBHvFEepogEdEFRYd2Uk5VoDq8n/ldfWoBw/Vw/I2CJcj?=
 =?us-ascii?Q?SvllkUNDWlDA5s0f6D08Y7oWJ2QzmkL9vkBDQG4nFdRN2wC9FYNyPIn13ryt?=
 =?us-ascii?Q?675DNM/7ukxqFWSdC3YImlLntR7DNs2JnoqXgNZGqozwDi9awULM87kx81G5?=
 =?us-ascii?Q?rxOTKqd7xSG+EqsgfF8XES51i8/FAHSKqvA8/wp8x2kjchC7WdS0P8XxTTSy?=
 =?us-ascii?Q?vXM+YuNT5TYiuGkLUbClymOMdA3qIUYMRErw/lriaGSvHUtWiV6F+Q1/tokz?=
 =?us-ascii?Q?vX5Ne1jLAX1OKuGxkm9h1ICFFcwn/DjJmL77+hnRpC/P9E6OvJ1oz8QW5Ztf?=
 =?us-ascii?Q?+Y32peF2+nP7d8ayKcSXYQvTvaFPGu20YOloGT6i0I//NYQ2nMMK7fxhMx/T?=
 =?us-ascii?Q?THouAxDhEXzmuknHjIrHewoKKcLCkYBwy90plMZj4LDzmeJeM/rlUhCZueba?=
 =?us-ascii?Q?FCZsP7zJvuHEF0Y3o8WK9iuJHBrdGjrtsjvWNJ2Gnx9QFBHy6Cw1p/v2xbJV?=
 =?us-ascii?Q?66qO/nb0wWq5ZmhnSABAWGqrRa41i38NX7uxDK7wthiw9431Zr8kB8izGyJy?=
 =?us-ascii?Q?kEyOsQRJdCayaEKbtmREFCl5lUPqKfuWtLJuLgksX+HymEbBrr9Y+5pXyL1e?=
 =?us-ascii?Q?p1JW8K05CdSukVZI3AsAouFz3J+D6VvWdL4whjRiZcdFG50eVVPJZd1hYnOI?=
 =?us-ascii?Q?oR4vs5KfisxdkHL9AIeoHM6SXLqTsNA7NuBecR+zziYOQ4cnS9seam44jt3F?=
 =?us-ascii?Q?KT+RToHaU7hyuh1D7LuXwWetAsy7awiki06f2OnRjV8nN9xGQUOv54TmErOB?=
 =?us-ascii?Q?PabqU5Z2GLsD2sHYbKEC/Ygbfae+vHyt8LkkzTMaPimBPQJeK4X3t0zT2zrN?=
 =?us-ascii?Q?NqChVOYKJZt46Kj0pWTWs451XpthIXAlv5Apa6uCzHq33238Sq6TFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yh+O41HmsGzxIAvSdaeuVFacvmDC7Tn6++poZdd8GDydBRbYdkVU/Sb4z1Oc?=
 =?us-ascii?Q?F2BoJ7GanU7efVd+s9fsDRCvy4ba3Jj5j0BzuxYcndQVKqwA87DswEG1bkgQ?=
 =?us-ascii?Q?Wc/U2azPS4tKx2G4FcRIIG/4oh+4LVn1x4URS9FTI8czw5wV3j5zU5/6xKNe?=
 =?us-ascii?Q?SuxuwVvxXYP7XrPDfzIQ2AZhuOcROFJfSGqOXUNDIhHhKnByLKAwUhNLSpuN?=
 =?us-ascii?Q?i24BFiBtAGPNKrnLgnEWAkZ+zSt3wRdT4YTCwwmzNpfEL8aPUqb8lAaCOsMz?=
 =?us-ascii?Q?MzKv6bYK2zxTfOFrzBXP8FcC3LcLkFaVWt0qcLpXheOMW4t/uDZUW2QuQwoH?=
 =?us-ascii?Q?9Uaq16D18qG+Gcr7aA9KgETequYTQv4rVucIHYWneYhjNhS2x0fgQSGvdU4S?=
 =?us-ascii?Q?dOlcXzaJDtoC+8cGzEaJqwViVU5DIgvtc1s6OZRG2VhZnZpDJMUXlZ67RQC/?=
 =?us-ascii?Q?1Hx/huyJZBbFqypA7+WTpe9T4rXFc9rdAl4ldtQyoh0ogXHfypQcaYTkyjES?=
 =?us-ascii?Q?vxwXVGXKR2UyH5w7KD4NlMGY7dxgn54QK8rCG/imxLNLiObYiBCzVG2ujt5p?=
 =?us-ascii?Q?ND49OfjGoh6dKo1jsOmI3q9aF4Q14Z2WSf0wMXIGlcajyA2h4L6QcqQqOGm1?=
 =?us-ascii?Q?56xPZcjaZfwq5TzAvxM8fIOFhsdEl+ITRx4R7p2kVNWCe7v3tejV9TQMJuUe?=
 =?us-ascii?Q?KAMUMrTA298w8yFvFFonhINNKn4RTOhBLnU8zcNTUGw/lrdf15NYSFMpiddR?=
 =?us-ascii?Q?UOb0y93WPyHMM93gFRS5FN++4YasW3XSBAustPunSsZYz5ryHtuPzpaOXVr6?=
 =?us-ascii?Q?mM6JdeBsxCx5WEFgq/vd2Qqd2kfHFfPkYCQve0lG3Kd5wir7Vs5YciCU/WG4?=
 =?us-ascii?Q?GQEzRO4slwAK5djYCi0f7Nmr19y9NCY1X8X6RlzMH2j7K2RsCddvYvI8x8hJ?=
 =?us-ascii?Q?DLHR/4OBT0QzsHDVEhup1muQZmBb2jmvEtyZs9RHf8NYrBadtPhvwsoQg4Bn?=
 =?us-ascii?Q?vKo2QRcc6jMMreSx1yxEmW/ERVnuF+CiLIx3vQrs2YcXpUCPRlKh9AAqLqsI?=
 =?us-ascii?Q?bYYONIjnQSQRh2+YtA6yViyfi6e1BpE4WMPBDhw5ag6XAEVMbhd2ZGFcDg+I?=
 =?us-ascii?Q?smZXfYWDz90f3eeQSkV8UxpyWKmCli4kYAWtbr/a62q6TdoTTU/gc4DTbPF0?=
 =?us-ascii?Q?RNBtfgdNlRo7waYkmtikZ/16H8+BCArAVcuyD7vsX+4nB0UGtr98WLJ21ldH?=
 =?us-ascii?Q?pvKvVrbzWM/4a8a30V3A4pyv4bU5BapxObiUklWsJXzHWSIAkuCpdaihxKEv?=
 =?us-ascii?Q?01Fr5Umw03NJhT8IHYJTCJeMLVa3+8NvWEFlzcMrA6FufmhL7BACC5tEXDoN?=
 =?us-ascii?Q?0dNW9uRmNjcgmqVWGYcyVGbLq2L9vnbywCzKT8PrVwARh6cKIzkjsLahLbLR?=
 =?us-ascii?Q?/ibfWQMRgNJXHIxB4dHNYvceRvund010gX1d+zfUUmnSQysB4wO5m2Pgh2/+?=
 =?us-ascii?Q?9tBCulDT65aQIOawI5Oz32OYrD4B1yZmaHmALnnR0NOMH+0vMgQTmgfp00ej?=
 =?us-ascii?Q?zJ1gffVu9vsPquPGiz/wxTD5uuUs+VI1sM2aVk0D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31d818f-5a87-47de-a77d-08ddeacf52b6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:50:32.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEy3mujh0iPEwQVjI4BE9keLzNsLLZ2+xF5x1JfbYiYLaOEby+Oo47/LhHTDINfhsmcTaa//XnmZIWbRktdBlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

From: Joel Fernandes <joelagnelf@nvidia.com>

Currently the DL server interface for applying parameters checks
CFS-internals to identify if the server is active. This is error-prone
and makes it difficult when adding new servers in the future.

Fix it, by using dl_server_active() which is also used by the DL server
code to determine if the DL server was started.

Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index dbe2aee8628ce..e71f6618c1a6a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		return err;
 
 	scoped_guard (rq_lock_irqsave, rq) {
+		bool is_active;
+
 		runtime  = rq->fair_server.dl_runtime;
 		period = rq->fair_server.dl_period;
 
@@ -376,7 +378,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		if (rq->cfs.h_nr_queued) {
+		is_active = dl_server_active(&rq->fair_server);
+		if (is_active) {
 			update_rq_clock(rq);
 			dl_server_stop(&rq->fair_server);
 		}
@@ -387,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (rq->cfs.h_nr_queued)
+		if (is_active)
 			dl_server_start(&rq->fair_server);
 
 		if (retval < 0)
-- 
2.51.0


