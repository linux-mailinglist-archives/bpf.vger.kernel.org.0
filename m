Return-Path: <bpf+bounces-53499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D869A554EC
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 19:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA1716853F
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAAF26FD99;
	Thu,  6 Mar 2025 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UvccZV2T"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03C26FA60;
	Thu,  6 Mar 2025 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285588; cv=fail; b=vEt+We/MtfBRkgJhnSVEpr3sy/DhOpUyO7yHBEcqrTz+2NYIcO4RaXUF+XOIqEI5b/uFOykRJqr196h+OrP5OWxdHcftDOrNeBRC9WfKTGzokZjQ/1nKr1GgDnZp7Bxq1YbwSfI+yVVwErKx1hk8UwogfUvZ+mbXnOeCo7yzrFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285588; c=relaxed/simple;
	bh=00sHlZCf6iqrGOIu8pfKh8vx5EjdyRDbHc5h1m4Zerc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0IlfRcHJwUoxKy1k5pOcmkNunHtgRyMUtPltnNel5utkxRahCQ7k2f3WBXIS4wev+hM1uZ/8DIf5tLIA4aOpKMhO/z0KtdWkHGTY51bRo3aohPVew9tbbPTvDGt9Vo1vZvvgdbhmjtNdvcFnLv90MGrl09/yX/sBu+25mdfyOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UvccZV2T; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDvwssFc7W73AjnV9EmbPMJ3eEex/bYcBvT1CwvHkXnxZTEV9yQsBTtTyD489+rg30WMUwTGp/7GXR+A7jUwcyP/3dVU6JDMDhR7QYnPKIKPSxoCWEg3VUGt015uZksDjaE1LO+PSpFqrUmmZ5hTglFicao1NloSL0eXeg6cqHbR71BTe5oB9BRIiqp+x3krpWas5WGcH65GSxNTSGbXTUimjpEJW5CFaxGtmrjLVsEVwB/qzagrOhz5g0w/0exAC9xbXs7L6E2mYGPMWpTvbrxTPysR13BUDtcEstgUkYISCSuN3s76HZnr66gPmbCEu4rxhTVEyNhcOWxGLk1JUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsVgMAHZ1W9k5bsv/WYH1Fxw448bogbm1zptvH2MLEI=;
 b=VbOcvT1hEkUc2klZFf1KxSDzUu7HmTdrtRvJPee+Q5ENnmkQRQSXVp4lE6qJrBrnUfdvPS28vrhFlMPskCNus9voZ+R8JTWFqLrxryiRmWw+iGThN7Gbq6Cxn/52HTy79VTKj1KAYb8YhCyWJARsX1A00930Iel00mqW/2JxFOlvnQiGRfL3HxDUQiYVk/ImWNCQ2/mzPg8Va+l/hAee8lo/wyGZ+mZtJ/NagM8akXA3pBZVUMaP6GHg4D/TvoXx2W2+wSdtNidNsiKAOKRZgmcPSayoAnU6K009ljRvQ8DtrEgwk6yMkn2h2HPsTSgB4ZUx0I5nPPMxZ0KEH/YRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsVgMAHZ1W9k5bsv/WYH1Fxw448bogbm1zptvH2MLEI=;
 b=UvccZV2TMTlhM2vZeglbKI+lc4Xf7qiWKu2BMJ/mqjw7Niavg5goevW6pM94QmwbdelE2pZkpaG46e89RbQ78vlsS82UD0zNnGFoHpPdQSpUBoWHwWeD3ZbWqDY0+GoG0+YHRwJIURaDrrrpEui5q9SBd3Lw9NyUCtpsCS30dQOBIDsXwwoscQMdlUtcg68jiM5H4spF8tRdg9xivWd08uY2VUYXT8PCCUkRj1+WRQx3+7koJMmaoIvXEtDquYQcWgNiLBkpH0YSw6sOv9ip/l7NpiKkhJEJOF+Xpiekw0Mx8JF/HQIMGZUi1wo5uIHNJcuA/4GPBgqyg7YtcWg/Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 18:26:22 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:26:22 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sched_ext: idle: Introduce scx_bpf_select_cpu_pref()
Date: Thu,  6 Mar 2025 19:18:06 +0100
Message-ID: <20250306182544.128649-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306182544.128649-1-arighi@nvidia.com>
References: <20250306182544.128649-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 5660757b-cfe8-47aa-383d-08dd5cdc6572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rs0wBoSDl7nbiD/cpZ8d96mvA8Sorp72chioBgYmV7LyhRlVOdD1n3GbkEQS?=
 =?us-ascii?Q?jq86Yo6z0pqD4RHtat8DBgjCB5Act2d+MnD4ohJZQqcitcBemnX+8QAdFJu1?=
 =?us-ascii?Q?wexYaJ3NW7gL+9/83kxLrSAAtUZmIwXZxCKj/DbPanVPCKlicCsEfEwGQdlT?=
 =?us-ascii?Q?2bKeMAnWf6HuAFanQiEJiZhBNhgk7jIs4atN8Ny6qDSXHwxy5WIFIYEu4wbn?=
 =?us-ascii?Q?UhqhAoha4Zw41CvEHrNMA4TLnVockyR4m39fGNGG5Xb+b+OE1UIyftmijsjn?=
 =?us-ascii?Q?Tg1Hjnqh2se8KdFCW/vF1Ncv5ajaldR3zUQ9BqNCh+nmu//AjBq9r4pGZZxS?=
 =?us-ascii?Q?tQ9mqHMfcdC1U0z/aXABQwQy77JXC0mh3P2Mw0L0IujsAw9uYr57dIl2jnnt?=
 =?us-ascii?Q?Ekl+yLLq/GOtdo1GGDTpZ+WFudX42e7lDaLUDMq7durfJdL6gclkbqstbAmH?=
 =?us-ascii?Q?3WecvYnlUe4YoYRkBfak0FfBIVRZYEvgUf+9TiZJD26APYUCYvHTtiHPNWN9?=
 =?us-ascii?Q?WEm0Ev2Ncz8/poX96qmfVHVdNiCxC2ZsxsN950LBS0WKr3CNWhf51+aHdJx4?=
 =?us-ascii?Q?1xuzbxYdGvOfi64A6GHkifLIdquB5FbV9OXwpXj96NPvSHKI6zYGUcBZ8l+M?=
 =?us-ascii?Q?hjmhNd5IaHCmk6p5gPd/CAcFbgtKiui36VBqWZKhWOGJmJGx7W7IJwjjzBmu?=
 =?us-ascii?Q?lnd1jxRfG9COVZJChwtWXgV+d1F/QPPMK8Jfd5DVvTRaPJHxqxl+KP4YhHkX?=
 =?us-ascii?Q?VYv9wim2GI8JO5ow5XWzyapSMotmxRsPftBgXVzlBo0FJIPtMOkxac5Xwfm/?=
 =?us-ascii?Q?d/mt9w6jGOn5RqiKOVZ6IoqWTGiRa+6jS8fbijQq04vXv22qeQ82EQWqW5IG?=
 =?us-ascii?Q?LMZiTc59NwkJscfUstiRTVsCTtqReD5jybM+UD15WoFPP8VTBqdJZWKbM9cx?=
 =?us-ascii?Q?cQYsbNSoB0/5rtd04cpEu1KTJLMyygGTf4I3Xokk8rAUDyucMLLEK3MT431y?=
 =?us-ascii?Q?J8hUXqJrrAwFT7YwES2/fWc5KbKRMtvOtHGr1JmMrj+I0PfnhloT/QH9+2h+?=
 =?us-ascii?Q?sWMvfaZly8RVE9Q787ewJLNJpQn8nzVsCiVaVe+ePv7ANXAZnGX3zW0SCW0B?=
 =?us-ascii?Q?Yx5aNdgi06bb7+o+FoiTtbuBv+OSxO8NfTh+kJlVY9yQIOLMUkcPxbOlbZcK?=
 =?us-ascii?Q?0WH/kQG11lYB0ANi4BKo951meIu1Kx/EXxi5XZnFKMM4hTNx05iMPYr4almt?=
 =?us-ascii?Q?lIsVWjX+bCAPso8KgMVmngP/p8jY41ABzobevNdr48DOECNR0C0KE64LXMim?=
 =?us-ascii?Q?5vz7rtPXa514z38fESbFAJLtlwFLEARa72rjcHCNWkCmWcPPFKGvFcumLJnz?=
 =?us-ascii?Q?I3LzKx1ECz03fx69s0ZlCM8qzaRm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WHCJDhdZ5iN4A0UhcUWnNPe1oW+dfEGXfyVdcKvqu7VXqOm/XAzqKfdgAtAH?=
 =?us-ascii?Q?gdbT6vZBNlsIQXF9YLozl57rsLsFCejbVOa1zz/l+uRWKBIwC0KX6j3jvrhJ?=
 =?us-ascii?Q?FnneyWOrALdSUL+dL4b8CgXB7AOv9W/T+rGJdVF76dKykGYvlqzfiaY2dQhJ?=
 =?us-ascii?Q?nspd530j+NCu6BiQ2zuE2u8shYPqgPPCJX+BMo2UsM9WH8aoGmIjsqOAEFs4?=
 =?us-ascii?Q?zmq4RmaEHztUNE0tSEWrNQ5owbtt59HQRJOKoWYoUKz+3yrbcMW0YF244HKa?=
 =?us-ascii?Q?1rYJGKnq9C6cPPLybeABxdPJWwICkMlnKnoh6oX0uB02javQ5Uq+zu/UXAvm?=
 =?us-ascii?Q?FJcRMWMlPz3AplHnSFONUbB8Cd1aj0XwzDzQb4tYvLUQ09a89c/bB+Q7dSQ7?=
 =?us-ascii?Q?+nKVaiwXNV/poysotbQ3h7l9l2FG7RJkIj6+4dCTI959LqIb9sx7HxJF8Hgm?=
 =?us-ascii?Q?n+2Lnt1rhiVawMkV2CMBf+vItJcCHEVopavS+0bW1pofTRf/Ai49W7IXOszE?=
 =?us-ascii?Q?5GWaNgsNG/JQnn/dwG0LWhABrgM4Lk2mMrRxsKmVrPiMrHeoS/nvQSqy+oGD?=
 =?us-ascii?Q?UyIUxxoIIRBTe+4fpclZIO5ZY3q9I8qmyFHM98QL8lrhee5um11IgxM6DhaA?=
 =?us-ascii?Q?DrswB7VQztQxkkuhgYOwHoER472MqKkyyB4oPzOJcBzdF1Mhbyt0sgV+Zmdc?=
 =?us-ascii?Q?BGEV1v89IoSL1izEFbuF6c0XbAAlwZ/1Iup8+j39U0C7K5sfuBPxNBnaRsa4?=
 =?us-ascii?Q?rcJufyRrCIPoe4bhQb4361hB7d4ks+HBGfXML2q7/vSiZiumvHDjjzc3GOia?=
 =?us-ascii?Q?ZlMlOuLE4Aqmo3pwadGdZ8pb7k7iHdZ+u1icteTR9qf3Udbc9sJ6yL10hpOA?=
 =?us-ascii?Q?j5R0bixTmWtyt3L+keHZJ29QmjNHNPJYrkem0U8Y1h2KBswPC2W0SWRiupbB?=
 =?us-ascii?Q?LNTgdZgqcqDsrDtemOSlshrckLb7YuWCuB0wf/1wyLlIHNn9OWqDea9dj4z8?=
 =?us-ascii?Q?xHj0n5lagxr9WKH2IPDf8gzeqc9Kvt9mN+bBj5uPoCoKgkR0BvMMSeZIPPFb?=
 =?us-ascii?Q?k4pjZjTDavK4SOU8UvbFTbkRFIHE6ngiGZpvVrlsAj/QNZbWjHiliIOFXSkg?=
 =?us-ascii?Q?NXowWPIRPG8gg58rEyrIyFWoMgm5IWWf61SsuYmD9dRbQlzQ3Vi6RAH8+0I5?=
 =?us-ascii?Q?p0VQAaK2b0+C6QZoEU5DEKFxzAfvSWtQdMsiLSrDWD26JH5RsIuHewLC8FZP?=
 =?us-ascii?Q?E4rr0l01ywIjdhUtu61Zr/olMqjpL+9kGoT1UwwPBCOOYASyI2alXQ0faB6Z?=
 =?us-ascii?Q?821lLx8r2POG9Y2TvNQnYsJ6A4M76uOzl6n6RGz/ZH1P9JFArSxNEqajrwOX?=
 =?us-ascii?Q?lNtwa5AClIAbORq/5EpfAXU9uFpBRQ1ofyO36u/aa/fDonEBxEGXEbgX3vD3?=
 =?us-ascii?Q?ul4oMt/HYoItR+Ls28tQiU1ipjZge1fKqWwk2vxHdO39VYURAqoTqTBK5ssd?=
 =?us-ascii?Q?MailJsQNPQHdEW8BwLILn+L3oPr8dunRhhHO7vTQurp+9UhnXpkxMtvM/M3U?=
 =?us-ascii?Q?Fl1LRL3Qo/sHaySgHYUMr94aWM/nEUUYu/dNKbEr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5660757b-cfe8-47aa-383d-08dd5cdc6572
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:26:22.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQS1zLXvsqly7GdA3QAMaPTmWkLJ0ofUnfngg7EmVQwypjEveFMBcki9oPEfAMrpkfbdUFO467/qBrlbxgzlkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

Provide a new kfunc that can be used to apply the built-in idle CPU
selection policy to a subset of preferred CPU:

s32 scx_bpf_select_cpu_pref(struct task_struct *p,
			    const struct cpumask *preferred_cpus,
			    s32 prev_cpu, u64 wake_flags, u64 flags);

This new helper is basically an extension of scx_bpf_select_cpu_dfl().
However, when an idle CPU can't be found, it returns a negative value
instead of @prev_cpu, aligning its behavior more closely with
scx_bpf_pick_idle_cpu().

It also accepts %SCX_PICK_IDLE_* flags, which can be used to enforce
strict selection to the preferred CPUs (%SCX_PICK_IDLE_IN_PREF) or to
@prev_cpu's node (%SCX_PICK_IDLE_IN_NODE), or to request only a
full-idle SMT core (%SCX_PICK_IDLE_CORE), while applying the built-in
selection logic.

With this helper, BPF schedulers can apply the built-in idle CPU
selection policy to a generic CPU domain, with strict or soft selection
requirements.

In the future we can also consider to deprecate scx_bpf_select_cpu_dfl()
and replace it with scx_bpf_select_cpu_pref(), as the latter provides
the same functionality, with the addition of the preferred domain logic.

Example usage
=============

Possible usage in ops.select_cpu():

s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
		  s32 prev_cpu, u64 wake_flags)
{
	const struct cpumask *dom = task_domain(p) ?: p->cpus_ptr;
	s32 cpu;

	/*
	 * Pick an idle CPU in the task's domain. If no CPU is found,
	 * extend the search outside the domain.
	 */
	cpu = scx_bpf_select_cpu_pref(p, dom, prev_cpu, wake_flags, 0);
	if (cpu >= 0) {
		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
		return cpu;
	}

	return prev_cpu;
}

Results
=======

Load distribution on a 4 sockets / 4 cores per socket system, simulated
using virtme-ng, running a modified version of scx_bpfland that uses the
new helper scx_bpf_select_cpu_pref() and 0xff00 as preferred domain:

 $ vng --cpu 16,sockets=4,cores=4,threads=1

Starting 12 CPU hogs to fill the preferred domain:

 $ stress-ng -c 12
 ...
    0[|||||||||||||||||||||||100.0%]   8[||||||||||||||||||||||||100.0%]
    1[|                        1.3%]   9[||||||||||||||||||||||||100.0%]
    2[|||||||||||||||||||||||100.0%]  10[||||||||||||||||||||||||100.0%]
    3[|||||||||||||||||||||||100.0%]  11[||||||||||||||||||||||||100.0%]
    4[|||||||||||||||||||||||100.0%]  12[||||||||||||||||||||||||100.0%]
    5[||                       2.6%]  13[||||||||||||||||||||||||100.0%]
    6[|                        0.6%]  14[||||||||||||||||||||||||100.0%]
    7|                         0.0%]  15[||||||||||||||||||||||||100.0%]

Passing %SCX_PICK_IDLE_IN_PREF to scx_bpf_select_cpu_pref() to enforce
strict selection on the preferred CPUs (with the same workload):

    0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
    1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
    2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
    3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
    4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
    5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
    6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
    7[                         0.0%]  15[||||||||||||||||||||||||100.0%]

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       |  1 +
 kernel/sched/ext_idle.c                  | 60 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  2 +
 3 files changed, 63 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a28ddd7655ba8..8ee4818de908b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -465,6 +465,7 @@ struct sched_ext_ops {
 	 * idle CPU tracking and the following helpers become unavailable:
 	 *
 	 * - scx_bpf_select_cpu_dfl()
+	 * - scx_bpf_select_cpu_pref()
 	 * - scx_bpf_test_and_clear_cpu_idle()
 	 * - scx_bpf_pick_idle_cpu()
 	 *
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 9b002e109404b..24cba7ddceec4 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -907,6 +907,65 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	return prev_cpu;
 }
 
+/**
+ * scx_bpf_select_cpu_pref - Pick an idle CPU usable by task @p,
+ *			     prioritizing those in @preferred_cpus
+ * @p: task_struct to select a CPU for
+ * @preferred_cpus: cpumask of preferred CPUs
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
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
+__bpf_kfunc s32 scx_bpf_select_cpu_pref(struct task_struct *p,
+					const struct cpumask *preferred_cpus,
+					s32 prev_cpu, u64 wake_flags, u64 flags)
+{
+#ifdef CONFIG_SMP
+	struct cpumask *preferred = NULL;
+	bool is_idle = false;
+#endif
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
+	preempt_disable();
+
+	/*
+	 * As an optimization, do not update the local idle mask when
+	 * p->cpus_ptr is passed directly in @preferred_cpus.
+	 */
+	if (preferred_cpus != p->cpus_ptr) {
+		preferred = this_cpu_cpumask_var_ptr(local_idle_cpumask);
+		if (!cpumask_and(preferred, p->cpus_ptr, preferred_cpus))
+			preferred = NULL;
+	}
+	prev_cpu = scx_select_cpu_dfl(p, preferred, prev_cpu, wake_flags, flags, &is_idle);
+	if (!is_idle)
+		prev_cpu = -EBUSY;
+
+	preempt_enable();
+#else
+	prev_cpu = -EBUSY;
+#endif
+
+	return prev_cpu;
+}
+
 /**
  * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
  * idle-tracking per-CPU cpumask of a target NUMA node.
@@ -1215,6 +1274,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
 
 BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_pref, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index dc4333d23189f..a33e709ec12ab 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -47,6 +47,8 @@ static inline void ___vmlinux_h_sanity_check___(void)
 }
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
+s32 scx_bpf_select_cpu_pref(struct task_struct *p, const struct cpumask *preferred_cpus,
+			    s32 prev_cpu, u64 wake_flags, u64 flags) __ksym __weak;
 s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
 void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
-- 
2.48.1


