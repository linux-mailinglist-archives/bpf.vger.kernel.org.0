Return-Path: <bpf+bounces-59446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCEFACBA9E
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 20:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB36A7AC0B7
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A85C226883;
	Mon,  2 Jun 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ef22N/3S"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E045695;
	Mon,  2 Jun 2025 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887290; cv=fail; b=IiiYDuPEpwROdCPrm0wTTVVaqY3Joxd+SRb68PIGQT+ypp0IsY7nRZmwwzvcKEYmfitoONIurats4NyTIPRa6wqw0488+BcfxOCuEd0ERvyjVE4C7DN37ryW5lf9PawOMxZfHHkH1xpOyR9JhSRrH7iwcL1uP/GFXGTjCqElfWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887290; c=relaxed/simple;
	bh=ql/qzIIdBgUFL+F5yd+Cdwm20NgpxJ+4bjNVTcCsSwA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nXs4LNJYPRRtCIAc6Wk+hlJOcw7/2f3HeGfp2hFik1eYQgtGj9buSgfJweJp5JXYWYjUgcuP4PfXeNsJccG8K8fWQUtGJyohck01sjgQtD+oysBJnQxu19+YSqgfSZ8WTvwZO/0yDmGmq4Yrs5Im13t1h6gbDv8DL90j/v8Gsy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ef22N/3S; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiGSvEW/4AuWK/u0HhlTzAYNWAksR4zQNyWHGesJqnJn6cz8tUDaSkedKFM6sN7RSyos2spxWdDqFmIKcUbJSAYgrc2UeJyiEbiE3vleDwBAf9Oppuca9BexsSppPfdzAX53eELAbh603NvULc8cBNSE8PpBOt3B1t8pSZtl69GKHg/qNI+D3jI99XiNkMpfUQRBdG2f6xVtb+9OGtHi5BBX5n8u52EoQVwuuW95KkzFnWP32kOH0dvtHmnNCz/HsM8qxAO5teGtjETlII4jnqDRlk67xpharOF54eF38YIgsxM4l/l6R+c+LaesSSRfdngw1y+INlDzuExSctlz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9fH1DXQBekrVGqnp0n3VI0rs6lqGnKiSmCtbBbuYtM=;
 b=i8NdIEAB/etLGvihUazlg7LwnxHUC1dkvV6oViQO/E9PMXD5Qof4b0l1Ke3PsJF8xDHaXhFEG0hkyJT/ojgrc2KF0/xLAapRttqrhpR1UJW2xlOVYHXb848rNImtLgVcgXZs0rvr5j1WkDLjvLdUM+83V0hn6E4bAL87flF9ql6QrKb+yM6gEqW1pjSjOl57NvqsMCD61Y732OjNds2IFa3TOVCxXTa7ohkFj9F1T3ZiXRBd7GNzgHaHyKE6SlxhFcIek0r+zx9gtwrm4Uwo8ok4EHqUa7CRUITPIuj1VUrsm8nqTN3wwJEsPmED0MXs1B0Tf90vieW7ZbsjlXH1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9fH1DXQBekrVGqnp0n3VI0rs6lqGnKiSmCtbBbuYtM=;
 b=ef22N/3SOg3MOYB62tITK6gALusJoJlnvdhOxToJlK11QY7E1Gl9KoM4VDczcCMYzb25V9cYGbqVACraYrsRF2Bc5s4HqxKU0BRwIyoMeQVET1R018eBnYb099GnX9XmHdutP0daNAgchIkNFb9xL51SMK7JC38BNGN+VTOq7FTMYmn2lglWx8b/V1vafZzTzzUZo9z4uwTkyGc2RKGwI1b2g70bUBKpSVvfF3/L2+zr8CuFxszf+0AqkkTGhaHZAqE/cB2/kkS6NviEaeDUgv4erFW3y5DF2JsUd4m9We5uUrMZ6yfSKgCmUZyjDfMqFKovd6TgsIzTs1Hpj9CUow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 2 Jun
 2025 18:01:24 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 18:01:22 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org
Subject: [PATCH v2 00/10] Add a deadline server for sched_ext tasks
Date: Mon,  2 Jun 2025 14:00:56 -0400
Message-ID: <20250602180110.816225-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::19) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8bfb89-2503-4645-6bce-08dda1ff7bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s9WDBvvHWbWFKkUxBhYH6T2sSfKyP7svZDDE7LlEX2DAa9DZmshtfbYAV/h/?=
 =?us-ascii?Q?K4QCip6g/Cu/3NnOgGTpe65uUpx5xX/Kv7IoKrpB8io/igOnRcl4XnnfRcs8?=
 =?us-ascii?Q?ssPV9DQ/TuPTBSHkKBdLJZL0DYAIiwaJxFv2K4aH0vbvMEnh+aM/95VZq4Bj?=
 =?us-ascii?Q?C0OTa6XR+ephJ8hfrwOWwGxyZflaHb4iufpK5JWkhnMImpYgMcOLG9+fEwsm?=
 =?us-ascii?Q?F+QB+w6821hlfmt+7/kFBIS2jLK+NNMIeu2u4VIKOT4z6okqHGC91KQaNud+?=
 =?us-ascii?Q?8zxlk6eSiBdmm8eJx1TYhkXTaLwIeY++4hZ4wTcA1L1TfCy/13gXCnU8fGOD?=
 =?us-ascii?Q?TA3k8PpIADaWSAHMYU9wSd5mb9HN6/2akrG4xS49i7vQvmT62JEbbsmlTOvM?=
 =?us-ascii?Q?qQXaBl/GMTnFXYIaTavrQFttmwtHXsDRX0dPFxk7N8VRYni9dWCoq9hVFTgf?=
 =?us-ascii?Q?t12L92Ra36+KuIOb+eXwPKuzHrV1pvFyw32mSbE5jR3rzb8mDtlSnZQUWdEN?=
 =?us-ascii?Q?Rfw6JcLC3DqsTRlaFaJ91+u4jwtpq/FB4YJI0UkOT34CKPvT77ukPrN4tWBu?=
 =?us-ascii?Q?HD2XxrN+FK+ZNh3z2Zjk1DcdocrfOdjlxUEkl6Khl+EvsbplYT6MLk+To5/r?=
 =?us-ascii?Q?BLmq6NKiEbiInHpIri2CO9Eq0QDfwgiZxLsI+B0kcuSGxzCoHJF7+VjZKHzd?=
 =?us-ascii?Q?RXnqHpuhs+EvfLUWL1afzVnyQTe7QbVf1Ps/o4FdCj1uiAU29Y/5IpeLW++X?=
 =?us-ascii?Q?Jl+YnjlWtArMFJBZvbmXf13e4Og/m55mXUTaTIPxnSiEe/Vntd3FhH6SsuqB?=
 =?us-ascii?Q?FSKAaM3o7PsCSi7cfU/YvQvEwGNIxThJIyeRze9UzFWuy0zrN6thXeFUxVp1?=
 =?us-ascii?Q?1vnQ9SacFAu18tfayrydPy/FxsOK/NWTO5Qf8omRtRrl/Nntj1CkNg6STuHf?=
 =?us-ascii?Q?qD/NKqU7OHkmHdjSFVBJyxnZWtt186GJ3Rxh+lbGZU/aousP2x+C9x/+TlYd?=
 =?us-ascii?Q?9xAk9U5EVA1+odhBLa9jYPWwscXZHd7K0l0mcmqYtw9j2gpMBFCu8iM0/Gdt?=
 =?us-ascii?Q?+uBA/s1VawkPtNre0FDglNeDOkBw8hhMbco6dauZQRtTRGGaBud67h9e0w1E?=
 =?us-ascii?Q?UzwqjJzdVlklMEiU8IYp7BUSut3ekLhnMOVwFndoq2/CqbrBK2dLVOgmcaZ+?=
 =?us-ascii?Q?z1bde1psJT1pwJWGpYQ60OSAgjkI53rzKxtpUpnS92HYRdNDXeTcmlakYpkq?=
 =?us-ascii?Q?076eHX4AFcY1sqiZTLA6ycDS267ROQ2fo3TnNgTsCMV5mgtiBj7byOjoR3eX?=
 =?us-ascii?Q?rEcck6dmLRnLA3tZ5/AGJkgiOhrYYJY3cmRf0or5I8ehKcMY427y4jctwkb1?=
 =?us-ascii?Q?IAgAMFD577EA+JiYmq5Oy2R1XHRmpYRlsuRPuup2ZI7SYeY4jo0Pt9m5jKMd?=
 =?us-ascii?Q?I4LVj13/TKk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6i3YYrrCxEFH/+cWNkbnFgvldpWbywBFfhcRZJuDpVqyr+gYK3V8Iup2RRFm?=
 =?us-ascii?Q?UtENxphwW+m8pRfZX74sLIt4/9UmyYABPqvczyrL97CF9J/eBp2mRo4BDROK?=
 =?us-ascii?Q?mGoqeYIhnMnGcu6R7q5lPhiLStRwnbZGIAZpeR1NOkmrFWom7luBRoZczwvS?=
 =?us-ascii?Q?gFwYbyK/2EPd4c3x7pNa1bo7QYxp01mmHB+BrZqiHteTKHz9cVvm8ExS9N/C?=
 =?us-ascii?Q?BUbcZ+xfZFaZgH7wd5T9jFn+iTd9X3zbxupCgzbB1b+UeoZb6+54RtXjtZGh?=
 =?us-ascii?Q?qXgVP+44IrsQKdtXIi+n1EFrUw5Qjt/wBUG6WTIMaBPpuaHs4oZtDzQ/dYpR?=
 =?us-ascii?Q?zKeFqNPV+0K5/+2yyoEJrRnJTntKemBBFuOPdnkQl5HJZg7XBFUSDYs6gBP/?=
 =?us-ascii?Q?lGO9s8kd6YHN8gEfghVQTxEy/hJw3cZvuNLKypoF2G6jUqghiYn8C8SdibMc?=
 =?us-ascii?Q?8DuKyCmvQdDgjjC/daWWjjNvjAb/f1ajPfB/QiW8hoelNWt5XTbJpdIyiHdc?=
 =?us-ascii?Q?lQkWWakEhVPaxNzANZMUNo3m+3GXNM8LKgA7Z9rgv7NqVDfJ0oftU7JDW07a?=
 =?us-ascii?Q?tG7LbxDnnv7hdprv0wuGMFBIuG0RKuYxZ2t6pqPXWfwSSXD1KAh+apxSfOcN?=
 =?us-ascii?Q?eu3s6pm3JSOw81kEVrhhQpCyP0io3WozbSspvQglY3l5MxbiIuLIzbX3ElUX?=
 =?us-ascii?Q?nMmc8F5M/6+KGQFcgjUcz946hFc1F+39pH6Bh5XDrOo8cwzG69undllbho75?=
 =?us-ascii?Q?8mJF4xSdgBuk6fnZG8kS3hHAJq+Dut0RB2mnyWYztIch9BJ5OxLGu/0QuBD1?=
 =?us-ascii?Q?SebcIEhIXHmh1AyMx71og4XBNiB/kaFaiIIfph6fgtb99KE3WfKS6Dy5YFl3?=
 =?us-ascii?Q?64dDotIu7+4iAgDqlTu56V4h8BnuOF/NdXrxjE15obE8//ECeRa+JcTeJEYu?=
 =?us-ascii?Q?82ONwsp68Mq2Cy/J83Roa7YgMeSTa3nF1HzWpEmJryqmTK1v/ttcIuIrLULN?=
 =?us-ascii?Q?1vKpGo/hnoOeVBCWOxpBbn6Z0Qw3eBR4mBHzWLIyPFdohwz0N4ZPvkJvlMPD?=
 =?us-ascii?Q?Wf213COhDrEk96eoNzPIXKXoi+X0niwhCW03ipIJr3KGIu/XvPo6ha2y2JDU?=
 =?us-ascii?Q?F0fOhIs0WPWA0ZTTAMZewAf6H5QTUXnxJjdc5oVAAHZO+suOI7McbhjTx742?=
 =?us-ascii?Q?Wnha8dnUTgsDSGfoKiMCVtYW/KCZENubaqotIYvspETlxF8T975z2fsSgMrl?=
 =?us-ascii?Q?4E8jWbXxriMs9q/3sDJGKKewTsDcVUEi2acputlZie/Skq9Brd3xHbXtvJDk?=
 =?us-ascii?Q?H2q/5oxt4cenjCYlscdmYthXfR7Hru9mj+QSTabUpxw2JZuksLoor+21r4Lj?=
 =?us-ascii?Q?RkE9Esf0coNrAxLZgyLp+jUrmeSHTYGvUBcDnoNZ92WAQJOsfn4j3n/LI0+x?=
 =?us-ascii?Q?zE5B6mk7AhkZ1P9s214Cw16YBCgP7qntkTIdMm70GSijIUBGrn+8k8xQr15r?=
 =?us-ascii?Q?CvlZ4dvSlEQDi0mp15mMnwbWX4lgpdV0NlOZdGs1CP2RYbKFTKbl9EqIYaJD?=
 =?us-ascii?Q?aoK9RyWxeFWu0UAP31DVmlL/sB4VswLcLMVt7akW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8bfb89-2503-4645-6bce-08dda1ff7bb7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 18:01:22.2728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2xZQfnDHupwlTSxH6zB2Ltq8fNV9sQ56PkYInQkByNwN1tAl8ZXYMUD9aRKXqkn73ksGqcO0sNqRkmQ+tZ/ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683

sched_ext tasks currently are starved by RT hoggers especially since RT
throttling was replaced by deadline servers to boost only CFS tasks. Several
users in the community have reported issues with RT stalling sched_ext tasks.
Add a sched_ext deadline server as well so that sched_ext tasks are also
boosted and do not suffer starvation.

A kselftest is also provided to verify the starvation issues are now fixed.

Link to v1: https://lore.kernel.org/all/20250315022158.2354454-1-joelagnelf@nvidia.com/

Changes in v2:
 - Fixed a hang related to using rq_lock instead of rq_lock_irqsave.
 - Added support to remove BW of DL servers when they are switched to/from EXT.

Andrea Righi (1):
  selftests/sched_ext: Add test for sched_ext dl_server

Joel Fernandes (9):
  sched: Add support to pick functions to take rf
  sched: Add a server arg to dl_server_update_idle_time()
  sched/ext: Add a DL server for sched_ext tasks
  sched/debug: Fix updating of ppos on server write ops
  sched/debug: Stop and start server based on if it was active
  sched/debug: Add support to change sched_ext server params
  sched/deadline: Clear the defer params
  sched/deadline: Add support to remove DL server bandwidth
  sched/ext: Relinquish DL server reservations when not needed

 include/linux/sched.h                         |   2 +-
 kernel/sched/core.c                           |  19 +-
 kernel/sched/deadline.c                       |  85 +++++--
 kernel/sched/debug.c                          |  96 ++++----
 kernel/sched/ext.c                            | 108 ++++++++-
 kernel/sched/fair.c                           |  15 +-
 kernel/sched/idle.c                           |   4 +-
 kernel/sched/rt.c                             |   2 +-
 kernel/sched/sched.h                          |  13 +-
 kernel/sched/stop_task.c                      |   2 +-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 213 ++++++++++++++++++
 13 files changed, 502 insertions(+), 81 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

CC: Joel Fernandes joelagnelf@nvidia.com
CC: Ingo Molnar mingo@redhat.com
CC: Peter Zijlstra peterz@infradead.org
CC: Juri Lelli juri.lelli@redhat.com
CC: Vincent Guittot vincent.guittot@linaro.org
CC: Dietmar Eggemann dietmar.eggemann@arm.com
CC: Steven Rostedt rostedt@goodmis.org
CC: Ben Segall bsegall@google.com
CC: Mel Gorman mgorman@suse.de
CC: Valentin Schneider vschneid@redhat.com
CC: Tejun Heo tj@kernel.org
CC: David Vernet void@manifault.com
CC: Andrea Righi arighi@nvidia.com
CC: Changwoo Min changwoo@igalia.com
-- 
2.43.0


