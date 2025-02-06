Return-Path: <bpf+bounces-50695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE47DA2B354
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 21:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34D6188A826
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED0A1DE2C8;
	Thu,  6 Feb 2025 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DM5E+IU0"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC41D63EF;
	Thu,  6 Feb 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873322; cv=fail; b=dE3gFQzjTjDRlwsnRBtzHCxEq2r3Nn+stpCiEgI7QEGnThvtsfbgSPjiirlEGmoX75JQNg3nEFR6RiqHh02+Rwkw0RcBK3AT31jY32bacfqbvpKBmgXn13teKl2bDnTniLQ3SHQPA7QPXnBewyfb9AgHiyaf0RUFldQqASomm+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873322; c=relaxed/simple;
	bh=TU3NVUWMT45iqe2mi+fik+KRO7gLqGfn6Ne4Li7r2t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amHtV+XE7lDcJ65w3vJIfSK9YtZs23QI4Cc6xNzLyOYGHdcyklWcezmRZqPlUdGTAVbXv8h/mf+6d5liA2pn1Ov34+nTkuqx8rQMJQp5eH5PPSc0sapVh4XKMu7w7P0opPtnm+j35t62wD1Sv6Bdb4vVTO2SsintSpCx6rdbzmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DM5E+IU0; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K53fo3H6AD/K8sf2IRW628fNhSJWf4dzWuJE2LikzEwmUr/dHiU1GlNbTHdBYjjJIk8o22exFwcU235xnyEdyhACk/Hdb0zgNFI67kW3FXCN6Yy2s/cnQjyCNrqCW78b8EsTfSpd0azUPBZy7fnqAq+E/SwmK0szBjdqkCEtLBYcWLYcB3mSzoTFm1Eh+YaMnFVoHqzipj75Mnef1IM0eCmL5/8qwzJ0JFOkkljekK+nccQ7UlfbbcbR+UpQUK0i3mMdtYr6gGn1+uQKcyiQGcgL7dOQITrekEfVa8g7EgyOSbJ8LQprrqRkSs01H7z7qtaETcHrWCYxM1dcXD+h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNZ9SgfTIOBekP7Ta8ISsriQMYU051E7pneOg0Pv8do=;
 b=MxNoS4VkuvXC+PYoJ6yDGkrWaaDYHYzihIkJCYrav1fKaHDCwk4FhaohbBvdybbmrPifUovQjV+XPyoYSsXQWy8bR1X+JkO/HFfg8cgHAsV+1pW5K6UU+iUSrnEfQzP3kqqMXWyDFK7d68OEitK1iS6foxLU3ZOixk4fvzbPxZblPK5k3GTxXThRuTDfuqKo1PCDZoaFK6/ljILqMUODUTAAFDObSGGJXqN6TsQmwtsCoV8lVuXJ+t+FTHP8votNLVSneCb4o6gyN+UJFgSUxgqSK6JVTAhEz0/jy1CFavvW9iY2k2sVYZp1dx9cblqmKT/snaAPKBKyv1zJVLxucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNZ9SgfTIOBekP7Ta8ISsriQMYU051E7pneOg0Pv8do=;
 b=DM5E+IU0I5lC8m6xta6LsQNZXmZOzOUG0fFBR524xe7IYX90TLarBzurAUXAaD8moRYRi7FmEj8QEVyjWrF2LhoUgjOlaLjTFs75wGXwtBOQlXo70vmEmMrXImcVJwj7PeuJ/kRMoEE7qtpO08e3tX4lNsciltx6a3iOY2cJGGEsMatfQiDQAF9y9YdKdG8VkSfZzMi3Nu0QEWQaC5oXiCbmw7OxEZKpzYKcJK9SWZAcdr05A6zo24pjjO8Nj/oNrPuN+3JQ4SUottjjPqMtLESwO2qgMNGA6nqneuhh36wIThOPCkPSLgwIdbyLAsxHqLiyjMEmNsbkm3nTl980Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 20:21:56 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 20:21:56 +0000
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
Subject: [PATCH 5/5] sched_ext: idle: Introduce node-aware idle cpu kfunc helpers
Date: Thu,  6 Feb 2025 21:15:35 +0100
Message-ID: <20250206202109.384179-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206202109.384179-1-arighi@nvidia.com>
References: <20250206202109.384179-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7e23e9-5343-4e29-b743-08dd46ebe6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UfPBTjZcfoMLB3ryoKo2cyp9CzG05QFjq1zN8FA4XHGWczFwY2uqEzoMi+XL?=
 =?us-ascii?Q?hCwjp7/kKdwOa3TmqmINRclb5f1+Uh+I/Iwjxk2ZF+6sEUJQu3XR7CHc+/Ii?=
 =?us-ascii?Q?YCM5KRlZxgJUtd5C/+xeBiEekct/xWOoWlR3BLguzYU9YTsx2Su8LN7JBQ5Z?=
 =?us-ascii?Q?Z85hZ5aCm4TniAsU+NT0DDqYrB7PYlKdCownhBybSjAiitI8gS8ACaX/kFRu?=
 =?us-ascii?Q?F7NpfOFay62EHl1fV27sThlyUD06ncoyauDItYI1cd6k6yUi+Bbd+xhWXyR1?=
 =?us-ascii?Q?hRLh1L2A/ziJWetTtg91PqU8BQACtRxPY8vo2jqIwDIF/uwYMG/T6Pfpg0U0?=
 =?us-ascii?Q?sk8YotqOcWVyflGwVZVb8qZYA6sc4zSWMbxPIEl0U9WRSnIpgqwmd6523ahx?=
 =?us-ascii?Q?Cte0h5x4yrD9Bz3MD+Y+aNNsTGr/rZA1YqNappAUmN7GjSelYM6TPx6h2Qbg?=
 =?us-ascii?Q?37EWxEqcDqtyHvKdmKDXH/hf1HG5qrWuzUFtHFmQl+PBAmL0+FVZ/9OgOi/f?=
 =?us-ascii?Q?qdr0zcE5V2RzjCayGqlnqeW+TZVSC/LnomM3tBdHSJf3h16Wi+qWppg0gomz?=
 =?us-ascii?Q?3LgV/ZxT3kGii2U8GenD69Pz1jAC5jeFeNc9/SkuHsla/3e/pPGqqIUb8MqF?=
 =?us-ascii?Q?NX0Ah4bxjY1YTt4uvXnbGp4HVHkU0lnhR5AwstSswgYgSr4Ujf27EJnVgwyB?=
 =?us-ascii?Q?FtjzJQ1sSKyug6uO9EYLk10Bu9k7KAGa48EDeHZQUfX57QKOFnDhqd/FosU0?=
 =?us-ascii?Q?vt1xRM0UEPySxvbcKmCd5m1Tvae89BKLgi7fvTMgz4gmRtwxI7i9Cp0yig4n?=
 =?us-ascii?Q?K9qXvLH3QzIVI8++qoK+Wiysw0z+LWMiL2kvg7CsZb7u9RRvvUA49+ZVWdfe?=
 =?us-ascii?Q?e/HIEuyHBDgXh+0X7yQRPxQBotwaDme1a/fltoRMHRzQIHaqY7MBJb3YqKZH?=
 =?us-ascii?Q?E8yU2wA40LuOxwHYQgVtwv6PTIe2iHXs3b0eQtwimQekefymJRspegBFJBVP?=
 =?us-ascii?Q?5sdnWRO1Mb7gWDOA8XxKK6sfE/bf5mKHjc9Ih3/V32lcnCI4Zs4oOz/8eBFj?=
 =?us-ascii?Q?Kr1viY5gtOBXOrkkw8iEVbS2cycJLF9mlUO8UMcxOlU0LKE34Vtvw64ksu3L?=
 =?us-ascii?Q?VlAVZeuDG1TudcAFCpsvnuSHGSmFcDISsbaJeLYD7KUiQQTu8u/kQVpigMWy?=
 =?us-ascii?Q?RKUgFmOMJE4s0NnV2bGVy4rHeasXlei4/6y4byPQsP3r44FMW6fd6ZPw0oFg?=
 =?us-ascii?Q?7hm749RUUCyf/HjBi7ONwtV2uyuBMwm6q6mgKFh0JwV9VaN4exbtEEyWNdp8?=
 =?us-ascii?Q?UztrFy5HNWPw2eUo9dFBOSwQU3hlR1WYdIaY3WQsz6RwhRjf+blqPGqHcP6b?=
 =?us-ascii?Q?uC8y7uHfOmiQ8+SqNx3ki/HAP1ru?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UH74RttUBk648+rbl92RhBcu3Kqxv7RRt4uBo9wRUcbFHot+Bi2X2Oc+k8HA?=
 =?us-ascii?Q?pDJPY6nRYsM8+8AzlgdRrzTTz8T8vN4fmjI/4l7G3QNknMVOccG8BW6MRVa7?=
 =?us-ascii?Q?kgfT0y78AqcqEZvW9j4RU0GPaX0h7bolTLC29STL2qmj31OuAOKcEva302ss?=
 =?us-ascii?Q?mOMregCAtX030aFu2jd1KmoTSS7cPEfUxEML/1EETzSNBMfemouiWf/ZMqkD?=
 =?us-ascii?Q?hk82euoQik/wpVaYcLuqN5dJ7q3T2ba12VzAAMjT2DR0cUuwr8tn8opPJLoo?=
 =?us-ascii?Q?vk1i410SPTzDyVbbI/xZT57w2FlYA4ecgkJuHZbJapTikxQzJwcSp5i1psqM?=
 =?us-ascii?Q?FFgDe3vjhE5YzFZuWixUNmY1Mruc1jm1AKZpDha6xPY4Bw2qXt9r9vCvtcJ8?=
 =?us-ascii?Q?EiDqv+apWJqR56XVenRhhI2uH8bLq526WpUbFNxSuokcT9D5itwA96Py83Ir?=
 =?us-ascii?Q?8yNBPdApVjQUkT3fajK2zKLQCrd3WRnr/BHs7uZesNj6xM2sKDQU+eavrp5K?=
 =?us-ascii?Q?lLh45ndrRrhNwaJc8OnN1jfmzga5d2on72bPN0ls+L4Yb1WN1Lu3SabXM5nU?=
 =?us-ascii?Q?FoQJqiRqhVVbRSSSKibjqaZEQN/3mlfmvVmutm0rmpk5O9OK1DZ11Nk0TXwG?=
 =?us-ascii?Q?z8AYYH1OV9qD61/t/faFUY76Qkbrkk2tk1cs+h9sta4fXSCz+eCcl/wTZ7pt?=
 =?us-ascii?Q?X2QQ3dae2YV7LKrri4vI4UFyGYL4w0tUwRXVoqMnDFz4VBB9T/HcsjptwBK6?=
 =?us-ascii?Q?Eb2bB8rVpCierzTsOwyylB7w45VnYEQjZhX+WoqDocFuKn2KsCQeiqaHLF6I?=
 =?us-ascii?Q?FV7Xdo3Lw/eEZFpJTrXboqYKSFSgi6HfG3WynFc1AHvJnJHgNoinaqri/F7N?=
 =?us-ascii?Q?cXNdAYMpG2mzyONi8NWDZf8beBP17h+YRe3ehafrfsEzcW6kXce+tojmAegR?=
 =?us-ascii?Q?OnlzpWLze1+fP0SgYV3T1m79bC6gzpSEjUJ3Dh6GH7t4Z30dqMlDWkHwBIDJ?=
 =?us-ascii?Q?3L4Btfij0A+Q8LvC/IDllauQDDC5HzAka8WED/FKHrSWvrqLQrTNj5Sec++T?=
 =?us-ascii?Q?0zaxvmMe4lBIEc8U/p4Nl74HzjNVjVnYCRFs6aG/1P4My+J0H5kqoiyLlFPj?=
 =?us-ascii?Q?PkIOdOicfS18vyexz+6B5IMRP4rWCMifnZocVcBZXKPdlpw0Yjbw75OAbzcc?=
 =?us-ascii?Q?MBL5teC942HlungArWsRcCcZVEW3pQoAFoknXfLzn6ROvDZ5N0NiKJu4eNwB?=
 =?us-ascii?Q?LjqNxbVnA9gi7+3gOpOmBqJPk7KNAvNzGTQcdx15qRG3kh0HmIw5HcldQbkV?=
 =?us-ascii?Q?Hy9Vh/j/YrcmsnvCfpgMwcBT5gC9wIX8M0FdCPzNaj4RGsquvUtd6Nwy4plE?=
 =?us-ascii?Q?Ky41spdUtpGQsXjTjtrY6aj3XgR5UpGTlm9Ca+rsscQXOvBJmpDHbiR+AS+B?=
 =?us-ascii?Q?Yf3eO4CZBRdfy0onSkTadNmJNVRUxRA/8s1hW9LL7kVV4kNwyHPX7uigSLG/?=
 =?us-ascii?Q?nKQc5pr/YVnMOiSD9WXr2va7EWpbc486b2+6vncytWT0K7o+1HtY4WEsqelm?=
 =?us-ascii?Q?nMfDsj+abVHl4e2DlDK40RBproRyE3TLC84rC1mz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7e23e9-5343-4e29-b743-08dd46ebe6c0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 20:21:56.1619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4p33+xBrFV2ZMolzzpp7viY+MBNSMPbDT8+9di4Tj5M/oOioo2DRmKpQtQ4eY4b9KTu7Wa2jCqhf0lyRAMKjSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663

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
index 0deef6987f76e..df8cd76c86fdd 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -680,6 +680,33 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 /********************************************************************************
  * Helpers that can be called from the BPF scheduler.
  */
+
+static int validate_node(int node)
+{
+	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is disabled");
+		return -ENOTSUPP;
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
@@ -691,6 +718,21 @@ static bool check_builtin_idle_enabled(void)
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
@@ -723,6 +765,27 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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
@@ -747,6 +810,31 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
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
@@ -811,6 +899,35 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
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
@@ -874,10 +991,14 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
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


