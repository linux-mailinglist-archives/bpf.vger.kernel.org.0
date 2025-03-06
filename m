Return-Path: <bpf+bounces-53498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F523A554EA
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 19:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92317A56AE
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B265026B088;
	Thu,  6 Mar 2025 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="px9oXQui"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2D269CF1;
	Thu,  6 Mar 2025 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285583; cv=fail; b=Uer5ysL/vcBaCgH2t7JBZFYJ1N+Ojxlc0QXi2rxiy0FMurfsDnhhsdQoiZae6keDLMZJBWPOeUO3ULFRQjsE82JqcRMH+3oo8ZUVEeMPvZj2VTSESRmaq1u9MkgjcAuENWuX/JbJHFyyN7C7C4IvpO94+UV/vq78Ee62DzXzUHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285583; c=relaxed/simple;
	bh=5jiWaqBqrPiv/in+dAH/eO4Mis12V+lX/uFhnp9WwbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dxo8mjZmbJ/pmH0oQqdiuUZUfyLj0Cj/5Uzxey0DEuSyY5LGlq2whvWy19s0o9M0dwvkTLnmAkOjiDrhc4zqutotCqzafpdJv97yRoaj3SiSN6WFA8X5KhUvAEouoP++WOSWg96g0mwKh9QYNYqc6NPJ45IasmlnjbISd5rj9uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=px9oXQui; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0TT2M9LppHoLkDyijDi9gFAF5clpZ/h+CuyItK4XHiAmy2ZF1+LYXahv4A0j8oFOragIO/+rIGi+sS58CjV6HsoHEyQtsNt7+XJsexz8NQaJ84WS4XOEMwA7JPyjKLMO1bxTLaWgwmO7dyPGRF2QUQ1or283XDDzv5tTbTPGA+/ObgDch6spRCaT+zJYP5I3FMK8tAyumMdDbL8A3ripGXn4xcQhI5Awz97o7fqmoQWg4QPvtdLXk4Eai8gih1QSjw7ku1195r9EFGPx9BTI/qv8ACskHFYIUhSjzDzjQ2Z/atz89jkUHRjw8picYFSSeYLerkIG6jn3VNqJ+oyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giYADNXTv+kDfjvPJ+8gf/jIrDOn7b1dtGdLC0YZako=;
 b=QwVkxq1WTbXGIMNad8vjKsC1hODNV9rrOIdmMYI1Mzx5HAdEN6u/91ToIL16AxQhXX8UcL5sVkZGsIJulel9PAxYH53Vwzx7YhgsWRfGUZAh+styqzqjumqc5htcO8qdGqpsyRAt71b8pK+F10fOT5kphQJ2a3iQLAJadAngGFNacbxdxT0AvYc8uMrzoqNVT+xYCOStd3Dkxulbu1RFFfWthEIQGMWYfeVj1UfqNpJ5ZR86GexwIk1/YFNmJGg43ngVw3amZomIAovmQJc0xyA3B2LqZyDy60oZ1vg7PVUFyCZknygMz8YeNv+7CI0Ier9QwBUdz2lIc9fM8qxEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giYADNXTv+kDfjvPJ+8gf/jIrDOn7b1dtGdLC0YZako=;
 b=px9oXQui5Bi99Q7o0VZjLBwGvLsEUb5mgGbXPRR03X1Pahe4zssVRE0u5//cBcRVItqVf2U34hfg+Nb31Iwiw68n1PD7NNX19cL0TCbFBEmFoOH48en3Y9i+x1KmI0VQ4Ah+fkvd2xNdjQttUdhM9mtfEuKwj+gDkuDKcpnTyJVHQ+CdCgZueOMr+Oe9/odJudTit5wOojz9REUz3GtDxkWjD2MQ0XpQRKJXRFJn48+eGC5ouBK+IzdSPbWCz6Bpx8z4Lq9teUf5X5MqCMjppOkuS+k6zZknBjJy8V726iFUZrdwALKqpT/9Wf5X46jZuE1/7sMKLIxlM58yuTAKoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 18:26:17 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:26:17 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] sched_ext: idle: Introduce the concept of preferred CPUs
Date: Thu,  6 Mar 2025 19:18:05 +0100
Message-ID: <20250306182544.128649-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306182544.128649-1-arighi@nvidia.com>
References: <20250306182544.128649-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0735d3-247c-452c-4a79-08dd5cdc6272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7lAtmtMq+82sU/31FhgpNkQwObx/43e4mkFHxXJv5++vo29eYg76VvoIrf7S?=
 =?us-ascii?Q?NcYaSjt4aViRuf8Qz4EXFxpInIqarJ962WsEMA9Y3incv4dMRct7Z/QsrBaS?=
 =?us-ascii?Q?YxrPi6wvpe2Jbw/ZfFi1xZ7OW0YURsJRDs8+TcG8Ce3uxlqOnlFJdCSD98UM?=
 =?us-ascii?Q?U+v7mOECp3pDMgJ6xKsCypPI7iHFzn/J0O9A4BkA7ndYaLl2o3nUuV9Q8iKY?=
 =?us-ascii?Q?KyFxwejekiMxRbpCe5Q/IrH3xJRTuIxfJJupbyrDouSdPQchIzhBf7r7hcXE?=
 =?us-ascii?Q?uEcCKrCOREsJBsO+qXe8XhzV4xZlhqK0YvID0Krh+YvTQwymqTZfytH0yjDe?=
 =?us-ascii?Q?TR7AN/LvNZKtS7ygTrWKLESJplZQJqM90pQfAib73Ip6Jerj9ShGBII75tAj?=
 =?us-ascii?Q?R+SzfBVy9LDhXVgYrYeukT09x/BLkbVPwIaFao/JJ8enSgDiE5u1rycTG1q9?=
 =?us-ascii?Q?dPWnc0UjpWUUN9XdLIJXfsS9YYsFFrHV0aCQdpELi1NlmEk809oqWYrnlXNS?=
 =?us-ascii?Q?jJNtNmc9OWq/0JMyCGPRwkmqBj0u/RvixCK/bvciw6t9LHfuQ/9fWR69Lm0Z?=
 =?us-ascii?Q?dVACcyEYsMJQar5Aty9jE5YiY2uwJ+PI3c5SYWxzsn9uLLD2pGkYi5pzmZU1?=
 =?us-ascii?Q?D3hArSdr/RXhxx9a7pZq6HKIuVDKzKVpatN01jlFsZj8HQBItWEEHI201UHU?=
 =?us-ascii?Q?71rn+ouB0I3QQJT3U2at/Lm4UDB2KgZNYZDHwwB5/j5FuzGh18tq4YEw2G5O?=
 =?us-ascii?Q?fyTYkbxaQbtBXwPNl18JwqJ2NflrU4Rc0ewCQnwVWnAM2dF4BeXTRdjqlEjk?=
 =?us-ascii?Q?p0re7KpRw1iksgeOqS8Z3x4Z63EPggNdnFHCfhi1YPW4NtCbH4bgi4ibuW4+?=
 =?us-ascii?Q?3q4i5Zup/IoHqfxgKsRfFu6o54GaKBFYYiMmjEyURdrDhOcxARj+hW6j9KLU?=
 =?us-ascii?Q?k+DPvL5lz20yKKGcts7TXcadFEHzhvS83v78+UYgoM5kqe8xV81xdCESW5YH?=
 =?us-ascii?Q?7g+gbLwRU85/xn5KWCKN2uOFrf+LhJK2Nb1p9NmkuiYohR4Fk4ICc/6t855D?=
 =?us-ascii?Q?2GQFAvhaz6IocbuOTJy2z7Fh0kfKnHk/+gVnu0NlV1Z9DE/cAkmbP8m2S7Hf?=
 =?us-ascii?Q?RkUURd5E1/ndVS4y0O1rEhMG9rYGXF03p/81ggRmlX4YKHMORSiL4kjBbm73?=
 =?us-ascii?Q?oKQUCdIO/rmPfW9rx+s8CM+j4U3lH9Hv5sjkoGaP//Cc7HHS9YQ+NpKMScFa?=
 =?us-ascii?Q?yV67qLtTLd62EVRu4wTQ3qlyRAF3k0HESFDor5h8tBO5NEmz2CdgmeZB1m1Y?=
 =?us-ascii?Q?bbZtlTu7r1lKev8ke138kDTLZHuO/LGgr5DtxCCo8YY7RsgF+RLChyuwzvgy?=
 =?us-ascii?Q?loWLGXry7tNPFE0db+koxXD3fqG8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yUhR0dn6ncRufcNszSvqPR7BR5ecqB/goPeY3YCXgsfMStunfTZxpAVsB/ty?=
 =?us-ascii?Q?amGPcCLwbDnPhvlyRW2AXGdBF/UI8TP44xKK6CMnieVaKZ3wF3ldsIG8dTap?=
 =?us-ascii?Q?wfBxg1C7rKmaiW7Vn73OOXl9BYD6mdB4HGbgwFyCUnxJRfv7MXlUL3wYh8EG?=
 =?us-ascii?Q?rSNyca/rmWKkqMCqSahrRvGC5KUspa8a2G8N/WsE0E5OIZjgvEMf5dR6Gdqw?=
 =?us-ascii?Q?yu+dQAUqgPUsSanp+SOOUXhfrcih3ovQPxn57wWH0b+2/3HG3ErTd4AgS7PA?=
 =?us-ascii?Q?CLi4gysIglHcPUMNBjr3t5EZ7m5eEyxsTJa4xPTFenxCNtySb8foI4nwX1iy?=
 =?us-ascii?Q?8Gldf5r3kmmhElmx+lIA6yDNExec5YqI4CBVswdqQ38XHNYWsZ/SesmMkPbn?=
 =?us-ascii?Q?fptB44opvCuBwiBljUG7SCwJAgP5HA0LLCst8OwLes+ARal00FWfPTJvJygg?=
 =?us-ascii?Q?iFrI80tShhnPNxvEaHvhEpAfcJOaVypOBEVCBHiAdVVl9UtvhJItiTVO+3C1?=
 =?us-ascii?Q?VY6oGEJkr+CQaxXGZ6VdtsMm0W2oowfSOLtIjRO2o5LWfNyb0A38Kydsqg4+?=
 =?us-ascii?Q?iCP7NjfsFEN1A21Sho1vaGjfV5+fBb/o90EoE+D/1cSwuLJIokLmk/UoR3YU?=
 =?us-ascii?Q?vDydcQXeDiOau2RUmRL6kU+KlqZCRsFUNlOWEXIC7qv/EoNvEsaChDrti0bi?=
 =?us-ascii?Q?p10x1QXUjjDrfbL5lNPPFK/D5g2mudyPL1Pfh532uw/vmVsCs7ge8iklMEH4?=
 =?us-ascii?Q?OrYT8qVys8UtEoqdIGHihfcQJKFOd57Oa6O1qQf+3Cci2hLSkyjrp71LtKAu?=
 =?us-ascii?Q?/qk5x7nOfkEIil5jcstjVbV3F5k8rBX4/a2ZYXUeGw4rqSzzkcBT2Pofi3WB?=
 =?us-ascii?Q?u4PLegGF07VUjBAImHaqdmV6F3UejoaISR7QfEPUWVsC+tI2sMcBaJaJ18w0?=
 =?us-ascii?Q?eZ3FQYiQjsr80fHALYZYWUo9WSuMLMeqbyTFv/boz0Ws2Ku6dFpr/HhCk8SC?=
 =?us-ascii?Q?CpEp5AtCsqoI2tKmviSuMmuABbTF/TBxPb+LFqMMCNsIohWdt8M2zGb8pt2G?=
 =?us-ascii?Q?chLMHe0/kd3K8AAnQ7Qa2qOAINF7gDqbYDm8HuOH48vExqyMJWATvJiNtZ4Y?=
 =?us-ascii?Q?NffZlQhoFtB58kIFKHyNBobvTPwSdMOq50hDITH09hA2tuGUOnWqaf6oi457?=
 =?us-ascii?Q?jBGBCbj3HfpbNF7pf+0YoM25+ijiCyfFw/cJa/lM9jtNd+PDaMe3YV9NMmhD?=
 =?us-ascii?Q?2p9ymQI4O2Ek0tAUnygJE8fzhWN0zpU6q8gIJg9SgwGuq9GOxJIIWo5zjFIn?=
 =?us-ascii?Q?JBMG1jIgK9fYEEfq8VO1sJt6HXRxa4VnjKkLVZU7fmWMXdpcy6948fkbL1pW?=
 =?us-ascii?Q?vKOkjqyKS2wbHbE8fx7j41U2QDyQGp5lTHRerffp5yJhSVJLKGClublK3rG2?=
 =?us-ascii?Q?MDZR1RdyLugCNfUtrStpvp0hynvqwtGmN2DgMnF886Uq10NqL1/8om1/cB86?=
 =?us-ascii?Q?1OGERChR+aaHdKOp6cWrvy5d7AGF7Kwtv8rJx7+6PhEWGf3QFQnguSNpEbSe?=
 =?us-ascii?Q?9f0jdLIZTTvxd++jDRTlj6EnDut+CeNrTsntapeH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0735d3-247c-452c-4a79-08dd5cdc6272
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:26:17.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgWN2OX5ScoEKjvLT8ZdZkgD9iPRUQSiLGKefGW6zO46x5kGyJcP8T5fLNbmEW5YmeRiXyMuxUGUEgnAj8KRTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

Many scx schedulers define their own concept of scheduling domains to
represent topology characteristics, such as heterogeneous architectures
(e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
specific properties (e.g., setting the soft-affinity of certain tasks to
a subset of CPUs).

Currently, there is no mechanism to share these domains with the
built-in idle CPU selection policy. As a result, schedulers often
implement their own idle CPU selection policies, which are typically
similar to one another, leading to a lot of code duplication.

To address this, introduce the concept of preferred domain (represented
as a cpumask) that can be used by the BPF schedulers to apply the
built-in idle CPU selection policy to a subset of preferred CPUs.

With this concept the idle CPU selection policy becomes the following:
 - always prioritize CPUs from fully idle SMT cores (if SMT is enabled),
 - select the same CPU if it's idle and in the preferred domain,
 - select an idle CPU within the same LLC domain, if the LLC domain is a
   subset of the preferred domain,
 - select an idle CPU within the same node, if the node domain is a
   subset of the preferred domain,
 - select an idle CPU within the preferred domain,
 - select any idle CPU usable by the task.

Moreover, introduce the new idle flag %SCX_PICK_IDLE_IN_PREF, that
enforces strict selection within the preferred domain. Without this
flag, the preferred domain is treated as a soft constraint: idle CPUs
outside the preferred domain can be considered if the preferred domain
is fully busy.

If the preferred domain is empty or NULL, the behavior of the built-in
idle CPU selection policy remains unchanged.

This only introduces the core concept of preferred domain. This
functionality will be exposed through a dedicated kfunc in a separate
patch.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                   |   3 +-
 kernel/sched/ext_idle.c              | 142 ++++++++++++++++++++-------
 kernel/sched/ext_idle.h              |   3 +-
 tools/sched_ext/include/scx/compat.h |   1 +
 4 files changed, 111 insertions(+), 38 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5cd878bbd0e39..a28ddd7655ba8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -807,6 +807,7 @@ enum scx_deq_flags {
 enum scx_pick_idle_cpu_flags {
 	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
 	SCX_PICK_IDLE_IN_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
+	SCX_PICK_IDLE_IN_PREF	= 1LLU << 2,	/* pick a CPU in the preferred domain */
 };
 
 enum scx_kick_flags {
@@ -3396,7 +3397,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		bool found;
 		s32 cpu;
 
-		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0, &found);
+		cpu = scx_select_cpu_dfl(p, NULL, prev_cpu, wake_flags, 0, &found);
 		p->scx.selected_cpu = cpu;
 		if (found) {
 			p->scx.slice = SCX_SLICE_DFL;
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 16981456ec1ed..9b002e109404b 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -46,6 +46,11 @@ static struct scx_idle_cpus scx_idle_global_masks;
  */
 static struct scx_idle_cpus **scx_idle_node_masks;
 
+/*
+ * Local per-CPU cpumasks (used to generate temporary idle cpumasks).
+ */
+static DEFINE_PER_CPU(cpumask_var_t, local_idle_cpumask);
+
 /*
  * Return the idle masks associated to a target @node.
  *
@@ -403,52 +408,80 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
  *     branch prediction optimizations.
  *
  * 3. Pick a CPU within the same LLC (Last-Level Cache):
- *   - if the above conditions aren't met, pick a CPU that shares the same LLC
- *     to maintain cache locality.
+ *   - if the above conditions aren't met, pick a CPU that shares the same
+ *     LLC, if the LLC domain is a subset of @preferred_cpus, to maintain
+ *     cache locality.
  *
  * 4. Pick a CPU within the same NUMA node, if enabled:
- *   - choose a CPU from the same NUMA node to reduce memory access latency.
+ *   - choose a CPU from the same NUMA node, if the node domain is a subset
+ *     of @preferred_cpus, to reduce memory access latency.
+ *
+ * 5. Pick a CPU within @preferred_cpus.
  *
- * 5. Pick any idle CPU usable by the task.
+ * 6. Pick any idle CPU usable by the task.
  *
  * Step 3 and 4 are performed only if the system has, respectively, multiple
  * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
- * scx_selcpu_topo_numa).
+ * scx_selcpu_topo_numa) and their domains don't overlap.
+ *
+ * If %SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled, the search will always
+ * begin in @prev_cpu's node and proceed to other nodes in order of
+ * increasing distance.
+ *
+ * Return the picked CPU with *@found set, indicating whether the picked
+ * CPU is currently idle, or a negative value otherwise.
  *
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
  */
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags, bool *found)
+s32 scx_select_cpu_dfl(struct task_struct *p, const struct cpumask *preferred_cpus,
+		       s32 prev_cpu, u64 wake_flags, u64 flags, bool *found)
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
-	int node = scx_cpu_node_if_enabled(prev_cpu);
+	int node;
 	s32 cpu;
 
 	*found = false;
 
+	/*
+	 * If @prev_cpu is not in the preferred domain, try to assign a new
+	 * arbitrary CPU in the preferred domain.
+	 */
+	if (preferred_cpus && !cpumask_test_cpu(prev_cpu, preferred_cpus)) {
+		cpu = cpumask_any_and_distribute(p->cpus_ptr, preferred_cpus);
+		if (cpu < nr_cpu_ids) {
+			prev_cpu = cpu;
+			node = scx_cpu_node_if_enabled(prev_cpu);
+		}
+	} else {
+		node = scx_cpu_node_if_enabled(prev_cpu);
+	}
+
 	/*
 	 * This is necessary to protect llc_cpus.
 	 */
 	rcu_read_lock();
 
 	/*
-	 * Determine the scheduling domain only if the task is allowed to run
-	 * on all CPUs.
-	 *
-	 * This is done primarily for efficiency, as it avoids the overhead of
-	 * updating a cpumask every time we need to select an idle CPU (which
-	 * can be costly in large SMP systems), but it also aligns logically:
-	 * if a task's scheduling domain is restricted by user-space (through
-	 * CPU affinity), the task will simply use the flat scheduling domain
-	 * defined by user-space.
+	 * Consider node/LLC scheduling domains only if the preferred
+	 * cpumask contains all the CPUs of each particular domain and if
+	 * the domains don't overlap.
 	 */
-	if (p->nr_cpus_allowed >= num_possible_cpus()) {
-		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-			numa_cpus = numa_span(prev_cpu);
+	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
+		const struct cpumask *cpus = numa_span(prev_cpu);
+		const struct cpumask *pref = preferred_cpus ?: p->cpus_ptr;
 
-		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
-			llc_cpus = llc_span(prev_cpu);
+		if (!cpumask_equal(cpus, pref) && cpumask_subset(cpus, pref))
+			numa_cpus = cpus;
+	}
+
+	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
+		const struct cpumask *cpus = llc_span(prev_cpu);
+		const struct cpumask *pref = preferred_cpus ?: p->cpus_ptr;
+
+		if (!cpumask_equal(cpus, pref) && cpumask_subset(cpus, pref))
+			llc_cpus = cpus;
 	}
 
 	/*
@@ -486,7 +519,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
-			if (cpumask_test_cpu(cpu, p->cpus_ptr))
+			if (cpumask_test_cpu(cpu, preferred_cpus ?: p->cpus_ptr))
 				goto cpu_found;
 		}
 	}
@@ -523,6 +556,20 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 				goto cpu_found;
 		}
 
+		/*
+		 * Search for any full-idle core in the preferred domain.
+		 *
+		 * If the node-aware idle CPU selection policy is enabled
+		 * (%SCX_OPS_BUILTIN_IDLE_PER_NODE), the search will always
+		 * begin in prev_cpu's node and proceed to other nodes in
+		 * order of increasing distance.
+		 */
+		if (preferred_cpus) {
+			cpu = scx_pick_idle_cpu(preferred_cpus, node, flags | SCX_PICK_IDLE_CORE);
+			if (cpu >= 0)
+				goto cpu_found;
+		}
+
 		/*
 		 * Search for any full-idle core usable by the task.
 		 *
@@ -531,9 +578,11 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
-		if (cpu >= 0)
-			goto cpu_found;
+		if (!(flags & SCX_PICK_IDLE_IN_PREF)) {
+			cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
+			if (cpu >= 0)
+				goto cpu_found;
+		}
 
 		/*
 		 * Give up if we're strictly looking for a full-idle SMT
@@ -571,6 +620,20 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 			goto cpu_found;
 	}
 
+	/*
+	 * Search for any idle CPU in the preferred domain.
+	 *
+	 * If the node-aware idle CPU selection policy is enabled
+	 * (%SCX_OPS_BUILTIN_IDLE_PER_NODE), the search will always begin
+	 * in prev_cpu's node and proceed to other nodes in order of
+	 * increasing distance.
+	 */
+	if (preferred_cpus) {
+		cpu = scx_pick_idle_cpu(preferred_cpus, node, flags);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
 	/*
 	 * Search for any idle CPU usable by the task.
 	 *
@@ -579,9 +642,11 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 * in prev_cpu's node and proceed to other nodes in order of
 	 * increasing distance.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
-	if (cpu >= 0)
-		goto cpu_found;
+	if (!(flags & SCX_PICK_IDLE_IN_PREF)) {
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
 
 	cpu = prev_cpu;
 	goto out_unlock;
@@ -599,7 +664,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
  */
 void scx_idle_init_masks(void)
 {
-	int node;
+	int i;
 
 	/* Allocate global idle cpumasks */
 	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.cpu, GFP_KERNEL));
@@ -610,14 +675,19 @@ void scx_idle_init_masks(void)
 				      sizeof(*scx_idle_node_masks), GFP_KERNEL);
 	BUG_ON(!scx_idle_node_masks);
 
-	for_each_node(node) {
-		scx_idle_node_masks[node] = kzalloc_node(sizeof(**scx_idle_node_masks),
-							 GFP_KERNEL, node);
-		BUG_ON(!scx_idle_node_masks[node]);
+	for_each_node(i) {
+		scx_idle_node_masks[i] = kzalloc_node(sizeof(**scx_idle_node_masks),
+							 GFP_KERNEL, i);
+		BUG_ON(!scx_idle_node_masks[i]);
 
-		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->cpu, GFP_KERNEL, node));
-		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->smt, GFP_KERNEL, node));
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[i]->cpu, GFP_KERNEL, i));
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[i]->smt, GFP_KERNEL, i));
 	}
+
+	/* Allocate local per-cpu idle cpumasks */
+	for_each_possible_cpu(i)
+		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_idle_cpumask, i),
+					       GFP_KERNEL, cpu_to_node(i)));
 }
 
 static void update_builtin_idle(int cpu, bool idle)
@@ -829,7 +899,7 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		goto prev_cpu;
 
 #ifdef CONFIG_SMP
-	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0, is_idle);
+	return scx_select_cpu_dfl(p, NULL, prev_cpu, wake_flags, 0, is_idle);
 #endif
 
 prev_cpu:
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 5c1db6b315f7a..386bde7e8ee3e 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -27,7 +27,8 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node
 }
 #endif /* CONFIG_SMP */
 
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags, bool *found);
+s32 scx_select_cpu_dfl(struct task_struct *p, const struct cpumask *preferred_cpus,
+		       s32 prev_cpu, u64 wake_flags, u64 flags, bool *found);
 void scx_idle_enable(struct sched_ext_ops *ops);
 void scx_idle_disable(void);
 int scx_idle_init(void);
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 35c67c5174ac0..f9c06079b3a86 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -120,6 +120,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 
 #define SCX_PICK_IDLE_CORE SCX_PICK_IDLE_FLAG(SCX_PICK_IDLE_CORE)
 #define SCX_PICK_IDLE_IN_NODE SCX_PICK_IDLE_FLAG(SCX_PICK_IDLE_IN_NODE)
+#define SCX_PICK_IDLE_IN_PREF SCX_PICK_IDLE_FLAG(SCX_PICK_IDLE_IN_PREF)
 
 static inline long scx_hotplug_seq(void)
 {
-- 
2.48.1


