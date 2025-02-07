Return-Path: <bpf+bounces-50806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71CFA2CEDF
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FD816CAEA
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41701DC04A;
	Fri,  7 Feb 2025 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iowgXcp2"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204BE1D6193;
	Fri,  7 Feb 2025 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962710; cv=fail; b=TFCrHjgSKcOJ/y6NOaRY+TAEHxQ4dxEz+OyobadTaF5Z3c48zdGmq9DVj0J0v0tWCAK5cxCn3x6wDbuvYmSsYBrovzDZ8xiQF5iVQ8nGr8l/ahv1bzaBGPQtmdJ90pLomIyUy82jHmOM7vOMd/CXySx2pKA5y9yWAhbl1tECwWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962710; c=relaxed/simple;
	bh=vhJSlCLyUCZAwqWjgv3YeTWmabLIV9SytmPIcBf6bl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DOpRLnw+R1wwyDl6Lx0qek0OlBiC/ZA7SQ0WTY+yjH9Y+yUzH/Hm9N4OkNlzA3pIzpv2kAXy7PrFm55Bv7NH6CA+WkMuVL5Sm225yY8OVpWEBHX5+xlkqqLSCJKN1FH1tRxwx1kbzfEgYKGQsIorMRDVLC6kmejKiVrlBjEbAUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iowgXcp2; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voEEQW/kxNc2N4lXuITDrqwYRm+O2UT3lNtm5reF2smsrPFfDD395coIEMoDC4K+2W5Cqxpg6UpLEJBtVYY76b4gPhzadVz8wljNfBa4NCg+EUe+V3nd2+xNzA/kQs6BkMRtHpzRv2F61NgRsmba9Nt1cAedq+EVrGH1qbKWbg8UOdGdOvS+PSduB3bc7ohxNQRNooisgut8Yxnc+GdkhIKG4RGd5rD+glZDGWue8w8es5px/sLnEAIgtPRDR0O0207D+AYz00/XWQ8Ji1Q/QSh+T8nG33DVay33psM9xMvf8eRhBI5SWTAksmVemymdz4qx6hn5ZT/DFrFAedm89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n54boQg5TK+GwNXu96pP/LAtDrvsAvbwDGt4DvK65sM=;
 b=B8mEFnDq165YrmsLcSjYOdC4KyH0zhcHBwLsawi9p6qVMDLBPNTxeGIcyHSFYBsIdK3tfn+AX76Sg/RmtRNEI27Su59yd0GuuJ8GpoyhPfrzlydiZGZiNki76clBJBw/j6+Nc4IBLcIOgU9hdOwDDmNOQVyv3hg+sj6KQERe7i06artrEUhb7IS6AI8f3pfm1RLSUxnUcJgJsn1xuYcbNdHNVOOntp0u/mtSfgQjqdVhXsL8JyalIaL1zLaVldfHD3FGYiIeApOkjiMfLz5hQygMO9+OlgQkEchpFWrp9vvF+jnYcNu9DZf5SSxQ88CxxZyoFwl4h0vubQtEgh5CeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n54boQg5TK+GwNXu96pP/LAtDrvsAvbwDGt4DvK65sM=;
 b=iowgXcp2nLqAOvVwIvGD6P5xT9Npyhl6GFALlpIz/HIYbScZ0bASqDy1K/MP84bXAk10eDrG8omVX5yLOltJDAOku0EmMFGb7eBIfWJ60tBBc9Lu7MtWZFwLLUtDT19YqCd4Xys3gJrMT0yYQhryby44fn86A5VN4SH3iq54b5aS9dgVGOMCipQRsrBfjSAi8Sltg89IHlxKR2mlFJCaBZGR2qCzTzsojdYpkk3amR1oAwJivZJQYksff1JF6DUq/tl7Ugny3pKjCi5rDeF/BpeD0jQmFo7qEQ6rMgQb7zZiQQJxDzo9XfhoudPcdiPkqXvzdo8ljYTZ9wHy1aWiyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 21:11:44 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 21:11:44 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] sched_ext: idle: Introduce node-aware idle cpu kfunc helpers
Date: Fri,  7 Feb 2025 21:40:53 +0100
Message-ID: <20250207211104.30009-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207211104.30009-1-arighi@nvidia.com>
References: <20250207211104.30009-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 376eac06-7325-4b9c-c1a1-08dd47bc0620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?COxE1tCQsC8qn4rIjfJ2Od/VUePHJXWXTz24wP64HQ169LP6ML6fE27YgvKf?=
 =?us-ascii?Q?OsHXOZmMUTW1W9qffDlJAl152P5sKiW4nOcDQY/Gk8/iBX44sUUHL04XkHCt?=
 =?us-ascii?Q?7sNmYGfIGtsrHDvYjtSNpZ93m7qXt1dKKgL019acPDVQLNNHujIBzOKb2/41?=
 =?us-ascii?Q?5lTYXn9/w8pZTA1AHAJWyJDWPqZUCwIZDBOP2zkuRuvelaFveKf+GuSo/OOj?=
 =?us-ascii?Q?zZXyWKBQV7s4KN7rUMUFAiB4Lz0E9xZbGXQ/QSA8isBUL/YMEJzrxBzny8ZA?=
 =?us-ascii?Q?nC4KxKoSV5NJ/cacF1l/5H+o8pbsNkFF5o40LSZRLXpxWn1m7MjiJDYAQ82u?=
 =?us-ascii?Q?ykL79UHcM9xQiTonWRwYeW4bPmmQrbK2LgAdgIcD2kEBxW8mtk7bxKtm6INa?=
 =?us-ascii?Q?MV4KOupcAIRXZvYbbGeQkMmu3w65V9L4o5VD4qLekPJvkYE8zrj+sf2pgrDi?=
 =?us-ascii?Q?3rKLs6Us0o/EHjHyxR9hka7QAYopzGSsqGmBN/t+WtsZp9t4yuE8cFsIAzta?=
 =?us-ascii?Q?mbVujVaI1IK7J1OUmB3/9x9shXfKLgcBKwXU0RTqBOCITHHWrZfFRAjyXUs+?=
 =?us-ascii?Q?OaB1vvvz24FX2U9CW6jfB+nt/D9jsLj5fvvDueS/HYzxBIKofFLjYbnkQvdf?=
 =?us-ascii?Q?17SxUidaEgRCxGQ/KV2dFUce3Yds4rwGF59OllIklt7BY0P4Bz14OVfgjVw+?=
 =?us-ascii?Q?sd6lcqiILy1Px1YzPnJugdzsrzMLG6CSii7Hv788hKG4gyz1wm9vAcvo04zv?=
 =?us-ascii?Q?vMTo3gb/sOT4MzvenDOm+j5691tzHldFaHpaXoq2t1YUP8amaDhAmU63MTYQ?=
 =?us-ascii?Q?tbLpwkrVdWq5ATWhWzEDZRYDMyd5LxapFhleQEDxlYpJBX6/S1QTS91g8h+K?=
 =?us-ascii?Q?kmyOJFX5/rgwxWNgkRFRU9MPJlNL5Hu0pSs5cklC1x61G5JESqam1R9fcOZv?=
 =?us-ascii?Q?zzvnyp+qGNDMtBFsheCI1NtOIUBNo/kqytDkOYr7neJEvan0GMpZ3qQ1ZSYQ?=
 =?us-ascii?Q?JMBSqa4ym+3/2iyTQ9eDAvgqTQbARm1b4NYarC45bLdHrPQsavdH73MrzSH4?=
 =?us-ascii?Q?eAdRPb4T92BFM8DdRyx+lLFksu46Wvt3lUjBda5Ub4jrSukSGWv/Yq6/5Tgx?=
 =?us-ascii?Q?wOk1GDd9M317KrWVV4hotZK155TpgMNuGCYLYyBTFbO6tll5HdQgXSSQlMAV?=
 =?us-ascii?Q?gNWuwxkbuLpDBe84ELdUHMlJtkDWIy8DuNyb2fZWFNDXgTFLrk0Mc73GLDos?=
 =?us-ascii?Q?dc5wxIY1vBPZzknfLQnrCajiF0v5/SjnY8ySNt8RXU/2n2Njce6tsEQEUo8C?=
 =?us-ascii?Q?Thh10dl6wCJg+W4mxmWCa0PzD27Fc3m52GhsSs6cS/Mr6uaNve0KKqfnRT0Q?=
 =?us-ascii?Q?jMd3J6ZRAmTtxDuiTl3vs+2G3/0x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Np9Ll9F8Aat1ZKC1bS/ftmPJDfFHq/rftZgAwoJA0NmpJG9xSY8p+4ExP4+r?=
 =?us-ascii?Q?/4dqnJN5c76Bzep6AIdgRWtlYFHlan9Shyf53NP9GC57h/cAUV6OZMkwNh36?=
 =?us-ascii?Q?opQn6b/qA4w1uXpHmB3IbypZKgDdeKLDTVcn6YyC+xzOzbuGl7KwYHan8/4h?=
 =?us-ascii?Q?C08zu5KjLlNU3QfXZF5an8STNBpkz0QY/97EmpqNtAkIz29wxihhgwEDSl2x?=
 =?us-ascii?Q?iWtjHI3HZywSOs9fU1VKmUDh4eBvhcaapywuVXCQ/H5SHFWz2Rflm1ogYVeY?=
 =?us-ascii?Q?8n/UmQ2Xvgvlf4aXcE50LlqbX36VGKb0B3FnQZJ2wH6ipd0NaETyp7OSQBRR?=
 =?us-ascii?Q?iUSas1P6CF/WbYqUK1VZqf6S/V/ggSlPhKP3SEGm2Nx40UUjCH8ZIoAtEs5m?=
 =?us-ascii?Q?/mlIrVQxEsKSu9lbNMsoAbX3raa2QAgbIKlbUFZPHcwyfsFgldy9RiUZpiZ1?=
 =?us-ascii?Q?co2pie/hXavxDBrbBVhXjZA1agVXkVUORTy8hJKPWsWzU0u237aXwoFm19+L?=
 =?us-ascii?Q?3ZvWNr6dmub9WhzOM6Tu6CJsMYLPE/zwUx0/OxE1H6wDSIIsbSyiZgQxXgga?=
 =?us-ascii?Q?AmT6qgSaEftiJWI+17GbKNOkViAIkHyhbd8CMfbI4IgdHV2H6v/PRVsVSEWY?=
 =?us-ascii?Q?SHfAGMSmAU6P27GbseXRQroD3zLen5VxNH+UzxYyfqUe6J5qyOuFN0fMZ5Rl?=
 =?us-ascii?Q?ZzzC2du7ZI+0UAVKcqPAIGayGS+XLslSkCOD92Q0wvdgJHWDM9aW95mRsVGL?=
 =?us-ascii?Q?Mv0yEHg0jkVbyjscRNSn346bxxTJ2LjwjVuyW3Jem9imau6EF+de32sxVuaL?=
 =?us-ascii?Q?9RixhOKAE3kxuKSN57TlGCt1zpK20wAkcSlUj47M9OqmZVXiYt+Lm7AKoSKy?=
 =?us-ascii?Q?VystYeibFFtTlpf/aQw6qFuIrogcxirph58y9LuEsj7O1r9aDEo8nmZiV8Df?=
 =?us-ascii?Q?cKfP9N2yKdfe19RgVNuXUh1ZKV0AF4vZZ/5hNAJ6+IfcGpwUHmMZ0Caf8ZjR?=
 =?us-ascii?Q?X+9eiiq1FnHsXyuRMklFhWgn5JYYaWuUIS2bDkZEYWwBDnR4uaNdeoHne0Wx?=
 =?us-ascii?Q?pnOrNu9+UTx8qMCw0jzhz9oMO2KjaA9dD0vlu3TCrNOIbY4ZmtRjCwZZEXeN?=
 =?us-ascii?Q?311qKAVPnpeLLm/fLnye8QFv4MhUkzAI0fVSjJkc04n3yVpa4GISbreDEUMi?=
 =?us-ascii?Q?WuOKOvqsw/WDSJBPqAU6tOaJ9DyEw7IkXTy7NgIaIi5ol6hFFVUiGRVf30BK?=
 =?us-ascii?Q?M/ts+7vL+6VIiQDfWR8o+FWSsaPidocexRMVRlt4Xuyn6GBgm6baZxLTjRmv?=
 =?us-ascii?Q?BfwwAI9HXlFpJ0JAL6Q/eEpk8KKNfoUAffUfGekj52gr4ZfUmdTar7GsXvgg?=
 =?us-ascii?Q?fLmx2NZhbHoNLeOTEVH3jLZNgTGNgUPToHEDj2tVtRhaQ1UiiN4q5qfPdvD/?=
 =?us-ascii?Q?6yACFIAF4XyIsCtVtb9nCpbuKVdmfc4APEfiL36XbyuLJx/JeP03fWj2ljKF?=
 =?us-ascii?Q?4h82o5m/158xhe4qNkt1V0CqkWnFTQhOu3uw9tPGQXYd0lLK/geTo4rlY6WM?=
 =?us-ascii?Q?trDpDGxHwke58uqWRSXdXE5574XgMgakbiQeqe0D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376eac06-7325-4b9c-c1a1-08dd47bc0620
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 21:11:44.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3ssZN7YO9YLbFZ/WWg6yXO4PKjbujraDCNMKgyM3KY8mQoXqZFCfJG8kPE4BROfCXr+9usfMveUWzFnc56f/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

Add the following kfunc's to provide scx schedulers direct access to
per-node idle cpumasks information:

 int scx_bpf_cpu_to_node(s32 cpu)
 const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
 const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
 s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed,
				int node, u64 flags)

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c                  | 121 +++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |   4 +
 tools/sched_ext/include/scx/compat.bpf.h |  19 ++++
 3 files changed, 144 insertions(+)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 4b90ec9018c1a..260a26c6cb0b8 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -686,6 +686,33 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 /********************************************************************************
  * Helpers that can be called from the BPF scheduler.
  */
+
+static int validate_node(int node)
+{
+	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is disabled");
+		return -EOPNOTSUPP;
+	}
+
+	/* Return no entry for NUMA_NO_NODE (not a critical scx error) */
+	if (node == NUMA_NO_NODE)
+		return -ENOENT;
+
+	/* Make sure node is in a valid range */
+	if (node < 0 || node >= nr_node_ids) {
+		scx_ops_error("invalid node %d", node);
+		return -EINVAL;
+	}
+
+	/* Make sure the node is part of the set of possible nodes */
+	if (!node_possible(node)) {
+		scx_ops_error("unavailable node %d", node);
+		return -EINVAL;
+	}
+
+	return node;
+}
+
 __bpf_kfunc_start_defs();
 
 static bool check_builtin_idle_enabled(void)
@@ -697,6 +724,21 @@ static bool check_builtin_idle_enabled(void)
 	return false;
 }
 
+/**
+ * scx_bpf_cpu_to_node - Return the NUMA node the given @cpu belongs to
+ */
+__bpf_kfunc int scx_bpf_cpu_to_node(s32 cpu)
+{
+#ifdef CONFIG_NUMA
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	return idle_cpu_to_node(cpu);
+#else
+	return 0;
+#endif
+}
+
 /**
  * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
  * @p: task_struct to select a CPU for
@@ -729,6 +771,27 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	return prev_cpu;
 }
 
+/**
+ * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
+ * idle-tracking per-CPU cpumask of a target NUMA node.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is
+ * not valid, or running on a UP kernel. In this case the actual error will
+ * be reported to the BPF scheduler via scx_ops_error().
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
+{
+	node = validate_node(node);
+	if (node < 0)
+		return cpu_none_mask;
+
+#ifdef CONFIG_SMP
+	return idle_cpumask(node)->cpu;
+#else
+	return cpu_none_mask;
+#endif
+}
+
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
  * per-CPU cpumask.
@@ -753,6 +816,31 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 #endif
 }
 
+/**
+ * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the
+ * idle-tracking, per-physical-core cpumask of a target NUMA node. Can be
+ * used to determine if an entire physical core is free.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is
+ * not valid, or running on a UP kernel. In this case the actual error will
+ * be reported to the BPF scheduler via scx_ops_error().
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
+{
+	node = validate_node(node);
+	if (node < 0)
+		return cpu_none_mask;
+
+#ifdef CONFIG_SMP
+	if (sched_smt_active())
+		return idle_cpumask(node)->smt;
+	else
+		return idle_cpumask(node)->cpu;
+#else
+	return cpu_none_mask;
+#endif
+}
+
 /**
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
  * per-physical-core cpumask. Can be used to determine if an entire physical
@@ -817,6 +905,35 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 		return false;
 }
 
+/**
+ * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
+ * @cpus_allowed: Allowed cpumask
+ * @node: target NUMA node
+ * @flags: %SCX_PICK_IDLE_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
+ *
+ * Returns the picked idle cpu number on success, or -%EBUSY if no matching
+ * cpu was found.
+ *
+ * The search starts from @node and proceeds to other online NUMA nodes in
+ * order of increasing distance (unless SCX_PICK_IDLE_IN_NODE is specified,
+ * in which case the search is limited to the target @node).
+ *
+ * Always returns an error if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set, or if
+ * %SCX_OPS_BUILTIN_IDLE_PER_NODE is not set.
+ */
+__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
+					   int node, u64 flags)
+{
+	node = validate_node(node);
+	if (node < 0)
+		return node;
+
+	return scx_pick_idle_cpu(cpus_allowed, node, flags);
+}
+
 /**
  * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
  * @cpus_allowed: Allowed cpumask
@@ -880,10 +997,14 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_idle)
+BTF_ID_FLAGS(func, scx_bpf_cpu_to_node)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_idle)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 7055400030241..7dd8ba2964553 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -63,13 +63,17 @@ u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
 u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
 void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
 u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
+int scx_bpf_cpu_to_node(s32 cpu) __ksym __weak;
 const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
 void scx_bpf_put_cpumask(const struct cpumask *cpumask) __ksym __weak;
+const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
+const struct cpumask *scx_bpf_get_idle_smtmask_node(int node) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
 void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
 bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
+s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 50e1499ae0935..caa1a80f9a60c 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -130,6 +130,25 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
 	 scx_bpf_now() :							\
 	 bpf_ktime_get_ns())
 
+#define __COMPAT_scx_bpf_cpu_to_node(cpu)					\
+	(bpf_ksym_exists(scx_bpf_cpu_to_node) ?					\
+	 scx_bpf_cpu_to_node(cpu) : 0)
+
+#define __COMPAT_scx_bpf_get_idle_cpumask_node(node)				\
+	(bpf_ksym_exists(scx_bpf_get_idle_cpumask_node) ?			\
+	 scx_bpf_get_idle_cpumask_node(node) :					\
+	 scx_bpf_get_idle_cpumask())						\
+
+#define __COMPAT_scx_bpf_get_idle_smtmask_node(node)				\
+	(bpf_ksym_exists(scx_bpf_get_idle_smtmask_node) ?			\
+	 scx_bpf_get_idle_smtmask_node(node) :					\
+	 scx_bpf_get_idle_smtmask())
+
+#define __COMPAT_scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags)		\
+	(bpf_ksym_exists(scx_bpf_pick_idle_cpu_node) ?				\
+	 scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags) :		\
+	 scx_bpf_pick_idle_cpu(cpus_allowed, flags))
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.48.1


