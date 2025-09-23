Return-Path: <bpf+bounces-69352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839DBB9531A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0D23B6934
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773F630FF36;
	Tue, 23 Sep 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NyLRsjjW"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A19258CF9;
	Tue, 23 Sep 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619006; cv=fail; b=KfTWR1SGnC0RFSCb4Vblfpn3NGr/eE/c3S2vVB+H2uBr6Lnleh7f9W6OCSk7ZjNpA1VqZds8+lbBY8D0mjPyF0vd36Qo8DZ9nCfKTxdVc/MDVMGVSEtW8YXQH8QS3hk12Ebh0UDPn56bRLJnsx7DKqOb3FmPT7rTlBBOJ4Nx74Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619006; c=relaxed/simple;
	bh=Nfh6mNEKWfU2XlGDT9UkdCPLMJSgJ3MQvV8WerXSWfc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NK5QiwjDampjTPD70j+FSlsnRlRzgxtia6GCLKPo/CBK/LyLxxdpZERCShyc8XZdZBxF2Kzumbji52uVUcd3iKi9ZxfHWGgUZHHRNPxixyAEGwYjnzIrOylnvY4wy38WXLZyasizgGMC7odAErBp0lVgQiiMAjy30zTE4y/2PXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NyLRsjjW; arc=fail smtp.client-ip=40.93.196.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2veRzrSJfJT17cx9Gsfz3kVyKAN7x0W5FlMiHx9piCTPNCjvgt+fQmaXTC0DIkM9JqMNKOTytMaekj2Cw3x2KCw4ELz1Wt3nT+a1slzaarNqBvJ4FTadGfWvsgndDJUQG6a0Y1O4AW+wNhcqUIF/hX5k1TsvqjAFAnKuVpAPQCwO5UrNe4PMY04xJ/V3pDHWd7MD62RVMeak74qIUw1cv0kqIUfXM+aq85tjdjZ53OFqJOl3p1/Zuu/j/7VR8Iwne/RAMchiEjdEFYdGKn2sl2w24pafhkN61DoTLhO+dsYECFGbhXOo+b1KS84YXcPRGKDRuMvKigSOTAnSw5e8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtpp7/Uv/gtCUNBj5CIzWogr+l3iRmGOxDv2mffZXQY=;
 b=x+75sCLdYSKDl2AtlsfBisb/vvBmhf75uIiQiR5XQ03e/gf8rQj1FZT393kmBf3qked7d53HanbiXGY3Pn60DEtWF1sVFmHCfyNcY+GUQCOtHBzwGlO9sgsBJUsbFwPOV8o4ChkAgx+7tsSgJ4buCp1ieGi1C0U4SZziHmpJoWPIoglGsMfovCGSGR8zZDgQR/UtHiq2W1jFnyy7zqGzFwpqL3vMIt2iLe4u/m8SCyzepgndPfohVNCKUXFclD8/NU5YgmdmzQCDkYWhuD50e21FZxe6xe8oYLlaru87IvTzQpLAmk2l3NL/9me69VyAE9V99dQwqBGFlpuK9al8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtpp7/Uv/gtCUNBj5CIzWogr+l3iRmGOxDv2mffZXQY=;
 b=NyLRsjjW6LeHBK4goQppwwxHPoFZ1ZRcD1GIJvKAxQl9IabHbB8sMZZhobqiGM/VxgKNjnOJyqauq5CqUYm9jlRZFJGam1gzYfDcYXokZePkPHRlPpAUyI2vSHhkyRw8SUmsTW60gw4saFodNb5tbck1S8A2ehJ8ar5vPNUsHhdLQdi//tHj/Z8/+q4XvBZ2Ny9+nqaUu/NqShubOrSdtloqEBQsCU0Q8FGyMZE0/KtP0Kid+gAEnC99gPGIpn92i9r97oIsd7FUKpa3oCcFMR2Sp+k4mEcEYYijSMhp9Q5uG+03xIX3JisACSmIwwsWRrCG9nR8rel8ybJc9Knc2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 09:16:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 09:16:40 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Verify RCU protection in scx_bpf_cpu_curr()
Date: Tue, 23 Sep 2025 11:16:34 +0200
Message-ID: <20250923091634.118240-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: d954bfca-4ae6-4d44-33ea-08ddfa81e79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?20e/FXh57rpG383sXZh/SSReb7Avq0oxGR3CQe4Q6WNt1qneS0XVhyuR5XTv?=
 =?us-ascii?Q?LU8NWPFGc5vPWTSIRppeDsNp5cMK78sKlYlUr/u407cqFZH3AtFr0LCkcGjW?=
 =?us-ascii?Q?ch63EKZVxB/ncIUpPhhOtf8wzj38iwPhN7h0oLYL5R8dPgTXiHJjCmNJdg1B?=
 =?us-ascii?Q?aMFYjLDwy1ETAwoyY1DWXNqk8ebeYo3IXLesZvJi5V0lH3CV6irausMx7Evr?=
 =?us-ascii?Q?U3QieQXYgZ5YD+eZvwNBSv4NY1fd1qNUOsRW76f2YY+HBAiGS273RRbHH27s?=
 =?us-ascii?Q?Vda+xKIdVFZAhgr/6qdS4dU7l33SRCKwwVtNWawJFPTv6RkkxbSDYerU6sav?=
 =?us-ascii?Q?FoZTP1lMaPL6pY9MWujEgrxJ3ab4WMa5unRWbf6Su3fk04NJYk6JHQ1mIVQj?=
 =?us-ascii?Q?0LSf6IrYiqexjE241xhMDk6fzrpEOkDpM8xTMzAPTcuhEf4VEuN74t5QwLZX?=
 =?us-ascii?Q?O/YldGpP0ZdjjznWe9nfnWoFZW5Oh/iVrApDG0Pzt6QxsSJuLNbz+p7pzbxh?=
 =?us-ascii?Q?gvgvgla9hEPKLznJONnl6H3ZL21/jCKAP+At1TT8V+ezaju4P2v9Io+Filtl?=
 =?us-ascii?Q?R6NDwGoQegUPP2HM5WR7fFfNSfHTpdgcn2lZMpb3XrSgkUgOz2PbGkpDH9kn?=
 =?us-ascii?Q?yzAfWZ/Ua9ziV5kDuaENN0YKK+awFzCrhAMdezJIH6JLXnj5JuSjCp8/CSnY?=
 =?us-ascii?Q?39ee5pSLl7PkmTQi9oy+pbdb3f2xhYkc1m0hKtOzJkCmUH9YBpQ7CVZ/HNCv?=
 =?us-ascii?Q?JJ6G/Ebl60JJKaR897J02k+Jnv9tetorRWbOvu0IOkjPWoMW441syOM8okVo?=
 =?us-ascii?Q?T2wwZiO2UuGFb2OOs24B8jHQDh9ilaPFngHjQgKxFcqmXnoDaBJ4rEajkk4s?=
 =?us-ascii?Q?m5omhVtfCF56GUpGX/4dFDzZ9GzqtGUJlBDjen4FIWTrVk3q0Qj1VIqSJU5x?=
 =?us-ascii?Q?dPGCjL4b8TsDndYY6jTtV/kRp4WyQI+OWmBJhO6kihHXUWT17jSRmieGYW5+?=
 =?us-ascii?Q?YOeLgEzL/jAhmXN03m3HR4StQ6oZ4jOMDj4cGxDwilrHKGq5PdEXZXBb/6H8?=
 =?us-ascii?Q?ULF9cFb+sRbVATJza3+ELhHva5UlHoNpF3heHkFpJBT+q1KyeFaLMPDvNX4u?=
 =?us-ascii?Q?FNgG+d/N0QXRvxPv5OyGGpfdHDfws+1I6WBBg7wJtgjnf22qdMRmLLAaknGq?=
 =?us-ascii?Q?LFeP5DsAJ+8xak/pGvyFLcwuFO3G84BTMPXZWvEpjfY442geeTAzhwhnZsSr?=
 =?us-ascii?Q?QYPQhMOKBmHoc91LCkhF52N32LeT9RU2SedwCpsnj/6cKFnj47SrDC7/i61V?=
 =?us-ascii?Q?i7S1pyynSssrYugOgBUcbjGCknfIZlkm6c4Te3MIoMpxHvWnX2YG0XeXBSH1?=
 =?us-ascii?Q?YizVw+yw3/0DnIv9wpmDl61W0O/LOBeIXc29hEAd1G6Escz3NY2bx+BQMbwS?=
 =?us-ascii?Q?PWiDl8jPCYs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q1NhSK5LQaV/YBbp49D9hMR2rNLg77CMqFwzcwgLpPRoVzodETyicWj4WG27?=
 =?us-ascii?Q?r81sLzu9IK9fK1JHj3z0Q6yh4+d6yFRcBg5txgyQmkOGVju3rC4QOSWVD9vN?=
 =?us-ascii?Q?akTXHgVThxiijIC5nbrY1DFPa3FZYA2X/HtdYbO61JLQ8aTblP4+WU3Ayqo2?=
 =?us-ascii?Q?8q8B64/FScmghBw/Hsw7YFm95d8RLd8AKaT1KchYxqoUOmIX5jCRex1my6n9?=
 =?us-ascii?Q?x+stY6cM9wr/L57FffIMM47dWOciAVJQpfFYcvlNsWYmqI+KlZyjNBVmejHR?=
 =?us-ascii?Q?bKfN+JCjycdhsswKxh6IqYy5e8LwzHdqNm//RVnE602ENF00/ELBMJnxrJRD?=
 =?us-ascii?Q?f+trssxp708JCKN1kT0igIvBzxAcciIzLkMFrIbPR33wqiafLNEJK7reRkdV?=
 =?us-ascii?Q?MgpvyVDyWOCm40zj5WZ5KXoWZL6BwNKVSdeMuAQ+BETYeZVAdoyfHxPgbA4s?=
 =?us-ascii?Q?BQBe8P2/bpQQDSPzxYNssOhjo3y27sUHu6tGZIDPHmKKxF/qeV6wFLC5MRt5?=
 =?us-ascii?Q?lwcrywM4hbH8aqMWU6Jo4zfOhdGAtNIWeB4isZSiyQxtkLNEf05UctwVcVUy?=
 =?us-ascii?Q?jUtsfTBOXnUfAP6zaPUKsBu1esYAidvwgEsEiVtKbqlmDf4zoPnP0Zut27i7?=
 =?us-ascii?Q?kMegX8KTp3WK+lpEQOwViCLy3rLOa8yqe66ukydS5FoEntAJbuLN7Z3FXFZH?=
 =?us-ascii?Q?CH6s8BIfLjsPCpAg5DNkkudG2XOQGpUJAgfTZZiRvvGK2Y9JzYbZyHbGL4+S?=
 =?us-ascii?Q?y9yCVG+0JVAiKm9iCUXG4IUhy500gK6FjJlrZmWszM8ugl2whyTVHDaQs2bo?=
 =?us-ascii?Q?0lGeg+Z+OoXyWxWAUQ0PJZkZnWw9fjZxOzjSvynMLHmH4cL66/eSdX3RdS/D?=
 =?us-ascii?Q?Jf0dEdrGUs9aqgM6zsk9v+699HmxweYXk2eqVNq2MoIJEMowTsXMKeaJuz5y?=
 =?us-ascii?Q?EG5YswlA8Z7ev68wqvvJLJR6Fr2R6PcWk4uUAtIn3J70/M5U37jO/Ekkwo7L?=
 =?us-ascii?Q?aFXOUW3qjBOwr7caDLy/pW7oxW1cOCoP1VmV2oTqYvifY9R8l/dAETcYnSJ7?=
 =?us-ascii?Q?S2O4JCY/17Y2lK8Q0CApSbSNjhvx/Xwl2FQbc2hSWpEf7G1qHk1UFameRJQ2?=
 =?us-ascii?Q?CLN5GIsa0iGw8gozEdZyFv7NtOabzF3Bae2tLXiUK60Asxgwb86g5Nr7bx8j?=
 =?us-ascii?Q?j6YASF6kmZ/cYp4lUVzbkaUAaDbEjXqmYEaWaPR17B+dNwsPCneUoxnguaIV?=
 =?us-ascii?Q?4rmUhTkH/FsLR+CGtbQZ+alXjAdH8ctIdWwTiQLaTyatZnsjz4+9SSR6yo6e?=
 =?us-ascii?Q?uncly/umwOVmkbHfXuJ5HaPjWywEaqDvozTNenSJ4uHXMIBBetzf5rpd08gc?=
 =?us-ascii?Q?Ij4rRrP29aAXgqf1M42NYaH3OU4Y125gcF4bZEnCsmGlObOT6VXu3zKEMLk2?=
 =?us-ascii?Q?hBMoZBy+P/pEAV2XoPXclmxTFz99StidhDb5LlnWZbNg7T0tjFZjvr0U1CCn?=
 =?us-ascii?Q?vzncQEDmVi3S+hZaxn8S28KaeApj1E0m/8WQzGwvkuGlgB/0Qrr6ZDl6gBPa?=
 =?us-ascii?Q?Cv+6B9TA7zeusOjRzCIUMY2s6VGyVKLb/rUKprXT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d954bfca-4ae6-4d44-33ea-08ddfa81e79a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 09:16:40.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qF2q6z6CwhXcBxHuEXD7A/w1UV8/Ax3hG2TR+XqL40w7HhtcgF2ZdI8hcGcBFtCOVhsdUSM3fYTLCkY0oPFcaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405

scx_bpf_cpu_curr() has been introduced to retrieve the current task of a
given runqueue, allowing schedulers to interact with that task.

The kfunc assumes that it is always called in an RCU context, but this
is not always guaranteed and some BPF schedulers can trigger the
following warning:

  WARNING: suspicious RCU usage
  sched_ext: BPF scheduler "cosmos_1.0.2_gd0e71ca_x86_64_unknown_linux_gnu_debug" enabled
  6.17.0-rc1 #1-NixOS Not tainted
  -----------------------------
  kernel/sched/ext.c:6415 suspicious rcu_dereference_check() usage!
  ...
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x6f/0xb0
  lockdep_rcu_suspicious.cold+0x4e/0x96
  scx_bpf_cpu_curr+0x7e/0x80
  bpf_prog_c68b2b6b6b1b0ff8_sched_timerfn+0xce/0x1dc
  bpf_timer_cb+0x7b/0x130
  __hrtimer_run_queues+0x1ea/0x380
  hrtimer_run_softirq+0x8c/0xd0
  handle_softirqs+0xc9/0x3b0
  __irq_exit_rcu+0x96/0xc0
  irq_exit_rcu+0xe/0x20
  sysvec_apic_timer_interrupt+0x73/0x80
  </IRQ>
  <TASK>

To address this, mark the kfunc with KF_RCU_PROTECTED, so the verifier
can enforce its usage only inside RCU-protected sections.

Note: this also requires commit 1512231b6cc86 ("bpf: Enforce RCU protection
for KF_RCU_PROTECTED"), currently in bpf-next, to enforce the proper
KF_RCU_PROTECTED.

Fixes: 20b158094a1ad ("sched_ext: Introduce scx_bpf_cpu_curr()")
Cc: Christian Loehle <christian.loehle@arm.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 37d9eff3fab5b..838bdc09baa1f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6576,7 +6576,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_RET_NULL)
-BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_RET_NULL | KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_RET_NULL | KF_RCU_PROTECTED)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
-- 
2.51.0


