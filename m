Return-Path: <bpf+bounces-53608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66164A572A1
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AE33B7FE3
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE46D21ADD1;
	Fri,  7 Mar 2025 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="grXJN2Jl"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61901A2381;
	Fri,  7 Mar 2025 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377918; cv=fail; b=YZhJmY9OVcgiSIC1KSDy+67aH4/S4fELq7pr9eA0jAoVcKFmYRRtndyUpv/LWkB/Y+aIPCmB2RLtM5DeVOzx/y1lh+vpS8U0kB8CT8p3hxEw0fXGSJUqnd8G2OKXRIvXsbihY2uo38GG5AosblPW/kPUhCSogthnwy+rsWESV2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377918; c=relaxed/simple;
	bh=TPFXmaQ48JbN5lXbzhXc0Id9Pitzq0flepwgzKpidKo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ow8Lr11+tF4R8BWUO10FHzBBnw2t1EUgGwJfn9tW267m3h0gPujobpPXhm/Cj31toTi0LKmSTu0x9uYLi/BiTfUKADCWdOpZHZDdsVxvDH1N5aOWAqISmn+x7j5huhfPvDv/oNOW2dR2yC3TzZtJI3hKOlNX0ruwF8lWqEg8YR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=grXJN2Jl; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAC7b7WtCjzFHBub7+3Zt7n3EvbGPaAm3QpQV5wgYIjnn5H+XyF1+r9x6gn9XW+vqeWMvHwWwZ6QAUzeIs2MXLLKr1RW0cqYR/E4oQn5ayvZ9QfIyIhUAyHssVQm5bcUstCkh7oBZMZ4Du20Z7QXFgWiI9ITmv4fs7rsqQKqzkpYxV7QQIdKttShWJsaMzKvp2hBpUnMaDOvCdE5fyI2HDRmTbuM4jYhil8XAkWuuBlMk/Um5eJ+QV9aZB9SGXinfaGjeS4Gx4tgdUJSpHFXAJFa1Aa/wHSLVyFrq312L36UTthzY3sAPWahxJm/UYM1EwL582yXjn+yjX+iL3JFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NuM8gn7wGemcQqWMQajNLpCFgX0VhE76/WldqGAiHg=;
 b=Kb5wR6naPOWovKJrZtRYVRSRTrIXL8lml7h5hKrllQRiOSAldl/0BYkWdrvFdSKdsV3ep63HcfbHkGyKhcMBM81aMNwOmhSjILkxPEDmmoxZvWZbOONWqVj1t0GMN5GgLdKfXFxCP/ImGn97LCPVg9ExgpMqlC5fFrlHIXvBS7eYTpG3o12tHc686bmn5fbSlJCYhelAHIsKIINxVd9Dw7b9OZZ8kiXjUyvndM9VWcZCfa+koPdigXyR3vuL1jwRh68SWIg94WhdsCNx99LJw9KwTM+FpY5K2PFfIC+fcuZEMuN0S/RAQcwupjxslOIxPqtLn0nwdeLF93a3ctougw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NuM8gn7wGemcQqWMQajNLpCFgX0VhE76/WldqGAiHg=;
 b=grXJN2JlAPUhqF71kxTC1fpz1cIgrSsllGyxfw9Cn3hiipHHMEkYgwbko7N6T41pR6yt7hCIawbhI57H39/ZnKMSzoL+fY68uGmos4RcnwyCHqNns+R8rKRvb7gTC19JyN9FcR/+C16NbBRYwKQTqzWXupTExu32vxJqSmVLsw0DpkfeNhq1S8fhjQMStPzOIDOi1NCWMD2ETXhTr9kACRDassDQTJpcIPcCAKUXPYZZ6svcnBRy0udQ56XLm/CcT91qDdLjqWQPJUcUf1F4z4l9G4TmUY5+e7lz57wp/oVqdxIRunoO5KuY4cRO277vRiUIL0+q/zICiKi3ERUY9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 20:05:14 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:05:14 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 sched_ext/for-6.15] sched_ext: Enhance built-in idle selection with allowed CPUs
Date: Fri,  7 Mar 2025 21:01:02 +0100
Message-ID: <20250307200502.253867-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e90503-7c82-4644-d438-08dd5db35fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?78pun84x+i9oSK4pKXugEI0aWSqU1LyxNf9zG+ifxWa0EaVNolJkxAKkP6S7?=
 =?us-ascii?Q?QZnRD9A6OCsU5TNbUlmLtj3+PCUcpaCEu5JAeQitDfDZKz+y25lL1glEMdiS?=
 =?us-ascii?Q?VfCGRlaxSKm2rSXfbb3UldHkQevjgGLVijRi4X5wJnwwRZvzSQQjQ4L4J50L?=
 =?us-ascii?Q?+oadO7byRiGjikYT/Y0LkMHTMg6So2WZInBaD8JyVzHTscrhWMffFW5NaIjL?=
 =?us-ascii?Q?FK4DEKRAgylXraWcxkAvywwcCFp19GmGogxEH5j9iUT5g1cEk9WS9axgLzsx?=
 =?us-ascii?Q?oMOOJ61vIa1FGLkw2S0yu39AxSNARff3fWXL5SEZglZi8aqpnrN6wZG6DYyA?=
 =?us-ascii?Q?qnjVnlIckBbyKrte5akR4JaJYEUzDDqPuhSa+KER/RJXjz7ExQ++muBvTXI9?=
 =?us-ascii?Q?GvCYBNFVFm2rTUFbuuV1d2fU1PV/N/cIikOVswlMZn9GphhnU6hwLJcsV48G?=
 =?us-ascii?Q?F5urYZUxRuOkXopB+b9TrIExtpIb3ip+xUzkAz8sGoyvOplycobMR0ZhgVaq?=
 =?us-ascii?Q?QccMNhS37hiGxUunJrsKQbLDfIZqwWYrJV0s1MYdpca6JvzdzH+cqQ8hDR49?=
 =?us-ascii?Q?qVuEFoq5f2kq+vxlYmf1sZpLmfZBZc2OKC7RXgQ4vo5yT+/P30tqFqieDT8/?=
 =?us-ascii?Q?DwlMIVxXQqs8kizKVPKEnMU0fT/uC3cU/sm0aQKKYPVzL4wiJDxT2dagCD2G?=
 =?us-ascii?Q?/QGC9GUTHES2sXbrkZl/2WWNV/0J0YzJp20/NzdSmOiMdCMrbOmpiC35g7I1?=
 =?us-ascii?Q?cSQqU6E59YYnvTDaJwLaIuSEzA7MP5lSfsPi9VmWda/VMH+dfuANRJcYfQN3?=
 =?us-ascii?Q?AxOISWEYTz5aZwI7RCr6v+3ygXWR033B4QBOWu4cZd17KKbMhON67ce5tzzk?=
 =?us-ascii?Q?rtCly9H6AA9yu/jF9/abOmh0JWaw7lEkottN70T3WQfYYZ/SMTr+9tM3qKm9?=
 =?us-ascii?Q?TkBzt8S+fop5MOGoRhXfwyn5DPB7cq//1JvMna/M+YwSwWPfs7wcrFa55WoL?=
 =?us-ascii?Q?qmi5/N8Ca9pWBanctFw9DUfgmgZ5FAqSdP0z1Hv/fNG/0sAq+5/U+4v5KpJa?=
 =?us-ascii?Q?KXmMn5hHwLf0zGFiSYD+k5sae+jtbfwwKzNFweMeQPipZgbQwg+YtTF/7gOP?=
 =?us-ascii?Q?WTekmKSKApAOOfgzKRvilzYgrs32el2JvqDH9kYLq4t3tVjgs/5R6kOjmnHl?=
 =?us-ascii?Q?I3FCJDyezKtjudzBYxJ84MjlEzH/fESiXGje8oRQMJT7Wv+xTLZIoEHFhM6u?=
 =?us-ascii?Q?rJQQ68ClmTj769Rcpc72nhE+hZl8st2KyuPG339pdtcLPH2Fm41npgu4VLhL?=
 =?us-ascii?Q?2DNkjRrUNfnt12niAO4XUZmcHR2gRcGfDHnx8oMK6qCUz/51tNgi/8o+eEyc?=
 =?us-ascii?Q?biHMp++3Z7bT5QI7/mjOOOx22wIS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YPnyWxhZWAE8dQGloxMy6lrNcvxRNJAHSHgxterKemXLXAKwvJ6W0ytgqz8+?=
 =?us-ascii?Q?5s9jzWX7feMm73uz7ujMsV1g7ddo86dkhy0D5yxUqNFuhZT4hLWQYciK7dal?=
 =?us-ascii?Q?Hti6L5HZFtk8+MffdPKvFdeQe3IdH1qO8j2S3Sg1p77jvyaHYAKmZIThReLe?=
 =?us-ascii?Q?ZiGtXgkAZZv0gpOBtfQdc2LIUQDxbDlpJKJjPUeEEFxLklhVgsYUnuGv53Qn?=
 =?us-ascii?Q?tCwL3UHUCUlaTKgkjNbQhfIi9cWD+CGCj1heBkr0vstScbkQxaBQzXSRYd1G?=
 =?us-ascii?Q?1vhxHqxRUUpeO6JxCS4joMxLQ1OlSxfr0rJdoC1wKxNR4Kvb6GnESDxmQwSF?=
 =?us-ascii?Q?lXOZlpCjXJLLnuTeVAXXSISh8l1pviov8e4Uy2+ttoRijOdIcFuLIBmmcTfQ?=
 =?us-ascii?Q?ig4Qs+/eVbO3kcrEPDjh9IHh6pb80QAllzVUKGC97ZZOsLJybtpH0xCdHw7p?=
 =?us-ascii?Q?FsA9mCgQKM8Nm59wVzvSBDkYnV99U8NQfQE7Y7u6noO1+Y/CZYQxl6NoMox9?=
 =?us-ascii?Q?b7Os3lX8CvxiZH+yiFd6AgrrIJa47vABbYTKR+2u3YRFeVVMEHQmfm6S8pZy?=
 =?us-ascii?Q?Jd4vDO7RoFKuZLH0T0KJvtgfdNNBJ/ZFoTGL36T2RTZnva6EdOil6aTt+igP?=
 =?us-ascii?Q?0zygg7qWoeLQevEaYu5fCVbxhipianENs1smOB4zrlMrAmqH7ypXQfVZr15L?=
 =?us-ascii?Q?YplvViG1YI/8Fy9JoE9O70qUv463pB3GegrcZAj6ZbLHDUt0Y/GNfT/P0xIO?=
 =?us-ascii?Q?WtAOtrlY9xi4JujeW/s6OwBx3I56hVuL5ssinzqNt8nx9AV7BIYDobbaOIb1?=
 =?us-ascii?Q?wwv1rW8ZkJVgzHhYhSkW7mu829WPC2Wt5hQ+ahEi2cR2eKDatle7GKDMl9Ax?=
 =?us-ascii?Q?DoX83edMMG1rdU57hD1rGiZWQAP7GyxHrClx7rqT/58OLV7xQx9vknptTSKu?=
 =?us-ascii?Q?RIHftwq4lHmKPbwsUtTuube5kL/vEuX89/IwaN5OEv8n8spEyKO96cVpadWU?=
 =?us-ascii?Q?1w6IfcfLF3C4O7ERg4Iq2vyUdp2X0fo1y+c0ji4h85pxrFWNF3LhCBVg9r+4?=
 =?us-ascii?Q?PlhgS7xP+VfV9RHWKoaSwx/2XJLP3IbEO4PMDKRvWF16BglBbyNXXMYzTijp?=
 =?us-ascii?Q?qBq+zhLTXmElYxp5IUaYcb+xAco6vq+cEO+/YY5UomytHwQYfQHNqbG//62s?=
 =?us-ascii?Q?+WbgJSumKHUJmfgteNwUYzM5evOQvyvQkzyDOY5ZB5DLjZhTQMxmn3zpqhJQ?=
 =?us-ascii?Q?PBvfE4SkxEath9usP6IT1YzVs7bnxd7VlkwEMyy4ioMHjB+7o3+HUCcxV5Ax?=
 =?us-ascii?Q?t23u0jSSzycJciSmbFn2ADACViOBMM6193O7K09BBExs4xQpSWvo4i7hv8hq?=
 =?us-ascii?Q?CVnrZEPbZF7dDje9CA/454YXGDfQD+BZcUz9bXX/3DyTDED+frDsEF7nQks8?=
 =?us-ascii?Q?PdCAqHI+NlLF55iftcN6l2AGdt020bEyA4mJrSyaDN/VdMUeqH7uXj+i25zx?=
 =?us-ascii?Q?dcIt0pGTuwKUpIgRKgwYT7iQdcic48UFnzUs0BGk7ZfGsXbs+7asP5jhugUN?=
 =?us-ascii?Q?F5ZQUv0XNkoJ05wg9xpmZBrCrzXC+JunQT799mfg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e90503-7c82-4644-d438-08dd5db35fc6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:05:14.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QApK+dHrAl2HSbM5dYD/Kk0X/3F7EjlDDV+KcPs+gHXIrCqbEp2KGaO4DYLaIRkXnswIcuTTLS+p9Nu9URCcFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554

Many scx schedulers define their own concept of scheduling domains to
represent topology characteristics, such as heterogeneous architectures
(e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
specific properties (e.g., setting the soft-affinity of certain tasks to a
subset of CPUs).

Currently, there is no mechanism to share these domains with the built-in
idle CPU selection policy. As a result, schedulers often implement their
own idle CPU selection policies, which are typically similar to one
another, leading to a lot of code duplication.

To address this, extend the built-in idle CPU selection policy introducing
the concept of allowed CPUs.

With this concept, BPF schedulers can apply the built-in idle CPU selection
policy to a subset of allowed CPUs, allowing them to implement their own
scheduling domains while still using the topology optimizations of the
built-in policy, preventing code duplication across different schedulers.

To implement this introduce a new helper kfunc scx_bpf_select_cpu_and()
that accepts a cpumask of allowed CPUs:

s32 scx_bpf_select_cpu_and(struct task_struct *p,
			   const struct cpumask *cpus_allowed,
			   s32 prev_cpu, u64 wake_flags, u64 flags);

Example usage
=============

s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
		   s32 prev_cpu, u64 wake_flags)
{
	const struct cpumask *dom = task_domain(p) ?: p->cpus_ptr;
	s32 cpu;

	/*
	 * Pick an idle CPU in the task's domain.
	 */
	cpu = scx_bpf_select_cpu_and(p, dom, prev_cpu, wake_flags, 0);
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
new helper scx_bpf_select_cpu_and() and 0xff00 as allowed domain:

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

With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across all
the available CPUs.

ChangeLog v1 -> v2:
  - rename scx_bpf_select_cpu_pref() to scx_bpf_select_cpu_and() and always
    select idle CPUs strictly within the allowed domain
  - rename preferred CPUs -> allowed CPU
  - drop %SCX_PICK_IDLE_IN_PREF (not required anymore)
  - deprecate scx_bpf_select_cpu_dfl() in favor of scx_bpf_select_cpu_and()
    and provide all the required backward compatibility boilerplate

Andrea Righi (6):
      sched_ext: idle: Honor idle flags in the built-in idle selection policy
      sched_ext: idle: Refactor scx_select_cpu_dfl()
      sched_ext: idle: Introduce the concept of allowed CPUs
      sched_ext: idle: Introduce scx_bpf_select_cpu_and()
      selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
      sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()

 Documentation/scheduler/sched-ext.rst              |  11 +-
 kernel/sched/ext.c                                 |  13 +-
 kernel/sched/ext_idle.c                            | 243 +++++++++++++++------
 kernel/sched/ext_idle.h                            |   3 +-
 tools/sched_ext/include/scx/common.bpf.h           |   5 +-
 tools/sched_ext/include/scx/compat.bpf.h           |  37 ++++
 tools/sched_ext/scx_flatcg.bpf.c                   |  12 +-
 tools/sched_ext/scx_simple.bpf.c                   |   9 +-
 tools/testing/selftests/sched_ext/Makefile         |   1 +
 .../testing/selftests/sched_ext/allowed_cpus.bpf.c |  91 ++++++++
 tools/testing/selftests/sched_ext/allowed_cpus.c   |  57 +++++
 .../selftests/sched_ext/enq_select_cpu_fails.bpf.c |  12 +-
 .../selftests/sched_ext/enq_select_cpu_fails.c     |   2 +-
 tools/testing/selftests/sched_ext/exit.bpf.c       |   6 +-
 .../sched_ext/select_cpu_dfl_nodispatch.bpf.c      |  13 +-
 .../sched_ext/select_cpu_dfl_nodispatch.c          |   2 +-
 16 files changed, 405 insertions(+), 112 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.c

