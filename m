Return-Path: <bpf+bounces-54037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A8AA60DD0
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ADF17AEDDA
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3011F418C;
	Fri, 14 Mar 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UbnAsQGA"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657A1F239B;
	Fri, 14 Mar 2025 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945770; cv=fail; b=piFY8zLjHBrqralZGiWoYaxuFmHzWKoPKRzwjL5me1u9WZp5mtbjl9E/t1kyqANH/W3zEAagtaGQNPlnYJz2M9ywLs36tOTpUNBZWu6oepSu35E27lXQtdvYBwbF9jiJSQ70/J4HHvzjiEAmbPw59Za0x+pVcb/311/wZN/gczY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945770; c=relaxed/simple;
	bh=WkGodVuQcYvOugyWCBMeFXpHN74cb6jdrTxbpVS7r60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jcj9hz2h5IhouRQUQujZHJ/B+jFohHCi7VtYPz/o8FswHlqSFdkkMVR6OYGbQhPsOeCFr/2FI0QBCe0F65kT/js5DHGcQqRUtrIC+wbhxRPF2p/FQ5c5POI2/T1F9nN6IrEwctXKTlfUpaYlr2R1y3GMwyYDzM/G5XI/Suhzrvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UbnAsQGA; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu6IqvQnRXwUvfmL8Rr06k+fz4BqdXzpuvbaeBk4T4VC3pYXSKf9u9512IHQb5dZdmNZGB5rC/dbQRq6lAYC2lp1diKnyUavESkjmeZNlHGZnolgpx5LMOnoMYpixwD/506bGJzUprMgYgoy6oimuHVh//CmGk3HXc6sB/UMxj8EO1iY5It6PXfPc39GpaTZAU2RJ0G4dTpGqWt6t5Drk0VevtlHV4TLimAkBySI9F0Am0IXjZ7JWJWyTXIUC3S9615rtXwygaDUZEErqsWqZudoIyxS3RNDz0kZSJ+2hnVyHWOLmPuTrBknwLsnARb6Pxw9dh1SUx9cIFTyhuo/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gz5mnrPVymvN08Ipaw5GDyV8d9ebpS82xi3qU+raYI=;
 b=EB7+2mJDRaOKiOewsQ+aT1JVb+PIJfTaQKvVNBpGcYclGiaeqSP7m5GRJEU6b3ZU/H0K5dVYrsHKMyfWjjSoUsoxVPBqHBKqP+0VhZYLWoY9V/fwpNltMJH7KSJxigcsBHyEYle8m2hcJkYRzKroeYKZhwTptv4e7jzInLx4IEhHRfGdjd7DLZ+whiViDjFnnBahNwFsymnzwpHNvAJ6Y6wlTwF0W2upe9T9lro3mOLbqX2TC0pkhKnZjU/6OZGuXXTD7/fPPHL/43lnslY6jSiNnz+PpWjmy+2t3q0pmcdsCBMZ3tEF+5FYqGCCLFkH9uD7d54YRYfNpvcDBiI/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gz5mnrPVymvN08Ipaw5GDyV8d9ebpS82xi3qU+raYI=;
 b=UbnAsQGAjjsQ2nSULuzuaI55syav9irG5tukw2NkAPITjiiIFvEew/xfLBPDkJpT5fnSmTvRivGo+P5ZUTkzHjlqWxo3uRcvu8lnl3Yw/0OpKQUF8aUL1eslU10c0ofvUPUx6+WpZzQ7Iry+uTY8/00s4XaCZceM0EMCTSNqHrwle6wQzxlB7exnl4DUfL+/vj0c01h2fTjhkbAUIB8S8Ac0GjVOEeTaOMzv+3we1x4wqGlmUpqRnlpqV7T1VQrgVXwO04/JGFe2ZvkFhsCqqBXdZlcX+dBRKk34juiU0IJcJ6ue3Jy+7o0/CmQuRzf6V0zYPDjASbI1Uov8HjOAeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 09:49:26 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Fri, 14 Mar 2025
 09:49:26 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] sched_ext: idle: Introduce scx_bpf_select_cpu_and()
Date: Fri, 14 Mar 2025 10:45:38 +0100
Message-ID: <20250314094827.167563-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314094827.167563-1-arighi@nvidia.com>
References: <20250314094827.167563-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:a03:331::29) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 126d1b91-c84f-4e00-4187-08dd62dd81ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IhQPKofA9nL38uNaEgVyEaRc0NkBecvyW9kiYiUTtBUA/mslc8t/Zzww0e4c?=
 =?us-ascii?Q?aJjhLDFx/Eec1IxPSpvuIFG17MV1jog/cCaH7fwAGKDhvqSquZK+OkCYzB6f?=
 =?us-ascii?Q?rfszU0bYjV/NLvbm/PI+nokodU36/2nbH1p37nIrYY0CYxjHkN9TB6R9WHdD?=
 =?us-ascii?Q?EPOy9m/020iQAXiadZo+JmsfP6+jITpDWPngZc/Po4ljQJbI0u8aJ6OR5570?=
 =?us-ascii?Q?iywht1fB0QpB9HARaLdJnmpHXypg+6no4QywYZZOlS9txcVGd8SdmIUYtTCI?=
 =?us-ascii?Q?+swXYSyvsNMV+gu8pxATlY8sPhRY7+oNFRj/71B76Ga6XjhGHyvSew7ngU7O?=
 =?us-ascii?Q?Xglx953NuAK7ha4Hfx8VGhkNrZz3dU3Lgvq9IVW6zpnM7VI4eZi1h1WcThfU?=
 =?us-ascii?Q?SVybkEyreFgsw3moA+hkKr79VsDfNMqTRHBN9bzr7sWznU+528ad5t9aOS+a?=
 =?us-ascii?Q?M+kPGSrWdQFY4Vl3svh27d1ZE/rwJ0B9tSQji4Hf3gddRGk977YglaS8NQOW?=
 =?us-ascii?Q?wY7ZgIE1Eo84l7vBPuFML6e/U153oEoQy6g8KhFT08l4aLY1efeoJbHR/X60?=
 =?us-ascii?Q?cYGAf6YhlbpBUv3apTr8JzkJfsyUK2gkzLQIVAdm23AduTOZrlPM8xZXVcZc?=
 =?us-ascii?Q?j4Fzw6WNaOaZzyrLiCwUWTW9YfnnAfDBm1kH4SoTzCPXYBcHbNK2cT2dhTrF?=
 =?us-ascii?Q?bol9f9FSPycjllm/Ni/9muTOSrcKNQEVZwjq6u3sspv31mpeoSxWifbH/DwY?=
 =?us-ascii?Q?VZqoqlh8XkBKGMLhCPhFLsWCWbGFdN70pF3LUcEqIY8TNnWaFtjykH5vPwch?=
 =?us-ascii?Q?VR4Egt4LOSSR7ggvoxgemEF/kJNj5qXZNVVE4OvOtv8acYryQbSFHvtsWutt?=
 =?us-ascii?Q?YTgy1UAezjtrLTO0tt9xlqD/K66MuvjrYBmatEMUF2/BQeegTAVxhreNNDDs?=
 =?us-ascii?Q?t4W5TnMo9Xnwk0gfcOH2nE6ETowQHtTdKnplWjhSOHknu6/qfeje5sW8Xi3j?=
 =?us-ascii?Q?G8F9yabHiiqqBNogcEVfr2KcTPJQX2tmJPYqqbbe7wvcGWyI8jrOt+qLO+Hj?=
 =?us-ascii?Q?SAvY/4V2V3u+aXRfFP3yJnyRqfyL2Tqq6mZW39FDdpcos3BG+GHdfzHkz+Mn?=
 =?us-ascii?Q?8Ap0bjp9rlwCiUunBB9Z6YzJceS63nch2GrEy01taNI8fgiJ2BIBb9EsS7yo?=
 =?us-ascii?Q?Qm46NawmvFh0ODr2d8KU+K17m4P3VEw58jaf+KxyY2JWsynL5hEd/zdOP8G5?=
 =?us-ascii?Q?/9EW+ByVNI/hURWSjmBecTfYMwDc4JcsLTz3MHtObjYGh+51039HfH4C0EI7?=
 =?us-ascii?Q?SMZdWWSYNDhwD4ji6w7Mn7cxoKsWTL6nGMAUtqXD16v1vampYHlegfoYPqkC?=
 =?us-ascii?Q?k0ltMYchl+G6In4YYs+Ui5qzu3Iy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oLsTwtPjghIphSw3LhkWSy+uwsMTwsthLSIEzNGVfbVXIHMKm5BYtpzTi0iI?=
 =?us-ascii?Q?hn2d6MyirkwW5/FhIkGWwysLukggDDtbGZZ0m5O9SSTG7oYhW0sk2DPb2O3E?=
 =?us-ascii?Q?qGZHtFAoScpuAcoNnRvnM9Qog2gdEa5o5YaY5IpRZq132chqw0npuY0tuqg0?=
 =?us-ascii?Q?ZsXy2hbNcxVvmhc+RBLkxCOwS1Msk4KauUhxvsH+NjZ596w8j2rlpe94X2M2?=
 =?us-ascii?Q?6TDg7RT5SQB/M3j3t416bmBZso77lnG8sw963i56afGRMRwOwAk/PRjpneb3?=
 =?us-ascii?Q?AcLA/Qut0XcAK8j2EFTBwYw+mbt1Std41fY/Y+6eLMPclcm1d39aKKwld6KB?=
 =?us-ascii?Q?8F/jutmSi9RrfwqurnTFxjXqdLznvK2TtcKVhpIqSf0K981yrw5efPpv5iHE?=
 =?us-ascii?Q?rECUfee+WzI21yTiS2MDKFYRIpVd+ap/sfMBlzlNH3JQeJB9CfB4GNSF+q96?=
 =?us-ascii?Q?x03ua7hPTYelyfhtKATRGb1UGRtxdbyuyge8NT4W9SUI9NJCn3cByBEqj/Sx?=
 =?us-ascii?Q?DWLRqtZCm4V9D9oYlSfc56bi0NlSU6oj2CNnZG+5OHn8fmvztYLXNhUTCoDy?=
 =?us-ascii?Q?hmHWg4xWybjA8xWaAVUYWBXa+alpLRr4dkgJCUxk++CSuDfsLXSRYctNZ5I3?=
 =?us-ascii?Q?WcfPfZuxyyc45ko55B950i7NHnXOyL1aZ6zVncdSRifZpTDFu0RWPQD4LfRm?=
 =?us-ascii?Q?mpCxDElgL6k8chEeuqCQWaypmC8eL3O5cpv+XlHkwPXS3Wa7KZ7Ra8gilXi4?=
 =?us-ascii?Q?y0fDMXODtuS0SpCsuWTdirEVjJk5eJ2Tz4VCHX3lSJ50HVsg5IxMdJ9SZcG4?=
 =?us-ascii?Q?SiJsJiR3wnEt7vLGQe8FEHZP1hm78wwmjp2xHHi4QX/2ytH4PxBO/rQrtslB?=
 =?us-ascii?Q?EGcf3cnu2TL5k4wgJjIzUIe0hG/1T1eRFOt24GNH7xfuRqljns8FGdfqGS/x?=
 =?us-ascii?Q?GZ0xoh7ABXughgI8XudGz9zDzfYxu4M5JxymKUMX2WfQ6vDDr1q00nDkxTRM?=
 =?us-ascii?Q?oIzTQLviJA1iN8C1Gp1L/hidNh5jJADpsFJWbv0W7PUry3DkLVElFHfvGTmJ?=
 =?us-ascii?Q?IajOfVejDBPhwCayXHkfEICcygNRIi5d8cYijnQ9P1BIkTZM1wIk4D5/spej?=
 =?us-ascii?Q?L53eaBJ3p7hs7QAjIjl2ZVQIv5OiynoxhtPUwvFKo4LqnsReGX2svvdgyWEV?=
 =?us-ascii?Q?f90BlcVWXAWkKqUNIBed7r+l7cQCDB/y7YefUuUphcVVvcLbOC+pZu/3syPz?=
 =?us-ascii?Q?eC9bafsgzC3hnyyVWbe+MPQSYtwFgLaanGYF+wKl2vOl9kfHoDuiOm7/Ar0o?=
 =?us-ascii?Q?vE8mx8nK9vHSlEwpBjxYwhCyXDuhBbyqccIZkCDC8HEpBP4g+kNKyoorps6k?=
 =?us-ascii?Q?AaTPUOM7iVYaf5isleEcVeEvazWUEPwsuHLn3hw+C80knNvVfth3KWzc3ayH?=
 =?us-ascii?Q?kS1S3BymWZS3jwT0Q4oUMQHQqCM/yQ0TB0l6zZD5tEVongNNXC9RuG9NlP/D?=
 =?us-ascii?Q?9L7HnmFbfrZ7p/9Jn3rzNXDkkdzcibno05Pmht4+INXRr8WdNi0jXbZVL6bS?=
 =?us-ascii?Q?NteucQ7ve5iKWFXhRtWDqX5QI33AnEP37a/nXvBB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126d1b91-c84f-4e00-4187-08dd62dd81ee
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:49:26.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1O7xxk9CkdTOmlKQRD1gr9578A9jxc916yU/0KgYidcdZNQudaEkDTldBjloZ1DPiHcr4oibKHqpOCJhXwAmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431

Provide a new kfunc, scx_bpf_select_cpu_and(), that can be used to apply
the built-in idle CPU selection policy to a subset of allowed CPU.

This new helper is basically an extension of scx_bpf_select_cpu_dfl().
However, when an idle CPU can't be found, it returns a negative value
instead of @prev_cpu, aligning its behavior more closely with
scx_bpf_pick_idle_cpu().

It also accepts %SCX_PICK_IDLE_* flags, which can be used to enforce
strict selection to @prev_cpu's node (%SCX_PICK_IDLE_IN_NODE), or to
request only a full-idle SMT core (%SCX_PICK_IDLE_CORE), while applying
the built-in selection logic.

With this helper, BPF schedulers can apply the built-in idle CPU
selection policy restricted to any arbitrary subset of CPUs.

Example usage
=============

Possible usage in ops.select_cpu():

s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
		   s32 prev_cpu, u64 wake_flags)
{
	const struct cpumask *cpus = task_allowed_cpus(p) ?: p->cpus_ptr;
	s32 cpu;

	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, cpus, 0);
	if (cpu >= 0) {
		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
		return cpu;
	}

	return prev_cpu;
}

Results
=======

Load distribution on a 4 sockets, 4 cores per socket system, simulated
using virtme-ng, running a modified version of scx_bpfland that uses
scx_bpf_select_cpu_and() with 0xff00 as the allowed subset of CPUs:

 $ vng --cpu 16,sockets=4,cores=4,threads=1
 ...
 $ stress-ng -c 16
 ...
 $ htop
 ...
   0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
   1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
   2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
   3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
   4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
   5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
   6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
   7[                         0.0%]  15[||||||||||||||||||||||||100.0%]

With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across
all the available CPUs.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       |  1 +
 kernel/sched/ext_idle.c                  | 41 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f42352e8d889e..343f066c1185d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -465,6 +465,7 @@ struct sched_ext_ops {
 	 * idle CPU tracking and the following helpers become unavailable:
 	 *
 	 * - scx_bpf_select_cpu_dfl()
+	 * - scx_bpf_select_cpu_and()
 	 * - scx_bpf_test_and_clear_cpu_idle()
 	 * - scx_bpf_pick_idle_cpu()
 	 *
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 549551bc97a7b..c0de7b64771d4 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -914,6 +914,46 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	return prev_cpu;
 }
 
+/**
+ * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p,
+ *			    prioritizing those in @cpus_allowed
+ * @p: task_struct to select a CPU for
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @cpus_allowed: cpumask of allowed CPUs
+ * @flags: %SCX_PICK_IDLE* flags
+ *
+ * Can only be called from ops.select_cpu() if the built-in CPU selection is
+ * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
+ * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ *
+ * Returns the selected idle CPU, which will be automatically awakened upon
+ * returning from ops.select_cpu() and can be used for direct dispatch, or
+ * a negative value if no idle CPU is available.
+ */
+__bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+				       const struct cpumask *cpus_allowed, u64 flags)
+{
+	s32 cpu;
+
+	if (!ops_cpu_valid(prev_cpu, NULL))
+		return -EINVAL;
+
+	if (!check_builtin_idle_enabled())
+		return -EBUSY;
+
+	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
+		return -EPERM;
+
+#ifdef CONFIG_SMP
+	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, cpus_allowed, flags);
+#else
+	cpu = -EBUSY;
+#endif
+
+	return cpu;
+}
+
 /**
  * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
  * idle-tracking per-CPU cpumask of a target NUMA node.
@@ -1222,6 +1262,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
 
 BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index dc4333d23189f..6f1da61cf7f17 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -48,6 +48,8 @@ static inline void ___vmlinux_h_sanity_check___(void)
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
+s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
 void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
-- 
2.48.1


