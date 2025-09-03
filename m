Return-Path: <bpf+bounces-67262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 687CEB41A91
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43B91BA5170
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9A42F0C7E;
	Wed,  3 Sep 2025 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cqJ1BuqO"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C8A2EFDB1;
	Wed,  3 Sep 2025 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893042; cv=fail; b=WGoZPd59BTmnqRyfQn6skcxI4dkS0bZi/8K2lmkkAGqK6N+KdJ7z7BSewvlCz1L32YhVUqjvSU+gQ/qjxBc2hEMWThT1Buh5rCZJLtmSSKlZ8b86nKx6rQyztgd+IrERkR0ZVj3b0IRSfs5qeJXdNwistA5jaI2wGwXAdECcriI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893042; c=relaxed/simple;
	bh=b6ld1pZNaQnsWsdPQhl/ch/lU1dDfNlnJyLvFdGb4wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d6s4bICCo2Q5ZP+mCr+9WZySOKXgTy5e29zgLTk2ViZMF2rAM0PPlfl75RBw/1qVgi9JIcPjt1aPl+QegXd6dVChbDe4MX/6/yhX2PRYk2zbwnH4690FnxReRu7nKMFeF4qxzVaL9Vum6V8C3sxfoxMU1cgNGn13fGv7mxSQ0yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cqJ1BuqO; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu4C6fQ7kGnfTSkD2AVRiL+lutre/9skgDh4QvPaS9lp3zlSMniclLWU2MdkTEerMzH8JoX1CeXBgeG9n/ppGzSQaRWX8yPQZLPk27fgxWJM4mfmBHEHB7h7iBoY2V+KjfpBkpW245gTb5J5YsSd45EoagoXpW5LLEDW9w18KrbI8o8XEuIPbubLvq7uynDO9X8YKSwHmzv4wveMB0hqC3XUdKFYYZptOMV+zJvWxc+L65U3zRnEzROUk+e6JlsodPWZN8+EP1gorbcrV3cYDI4X5KKAVT0nwbNBGvjruN8sW65z+85aq3M7C3vGHlutSDl8uChIgoyBsAmjNAtfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMpBwDnbqQfS+sxOINKCMexzjrIRqXr4Hufws/PWNds=;
 b=EZ/15eC8rC4Y+N9o3kh3vwGxnXuzvE27+ia2bKJwqKl7xaFYG1iGYx9Q40iWEBorrOCkYkBYf2b+yOnwDytZkbxZtRLwT3sWE6OUAH+3ovBwfvJgc/jqcwNvgBXgWD2uPfBpEk7/7/XZvODGrixBzzmlHhQoXoZRRJW9wDSI2fFgGtuAmBP2I1edw+aOWjWrar7APRqQniC/cR+EX7vZX5YqqbvKb6b51q+JEhy2OJQJxSlaHJAOZp2CWtP6fnVJdAhF77i8rsdghlnUbWouO20MbD2yDF3FEtm7QQ5H1MjdW7Wr6G0MkKLp05MUBSA+nfxcZXewUeHNtnE281uZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMpBwDnbqQfS+sxOINKCMexzjrIRqXr4Hufws/PWNds=;
 b=cqJ1BuqOhqxXdDCN+zAMHXPPTW1pbZVGPY858O5G5veUqBpZy3wLDRQlDIUA8iDQMwso2PJumjKFO4F6GwlBqjCMXBqfyod+hN08PIlfElA9x2UM018gQRFGqmxMDH8nh02O63vztTsFKIdX399lB75VRLCJjKK9YdOxGdfD3MRXZvMKoIwTAJWPLRmQTr71PZs/QLev6E03nDjCApwEE9IJDU5sj+95PHUZzDELXj+z6XSmNPWc3Micwb09YrBJn+JjQ8h8KOX6YomHS9SziDTfJrizzFZ3+hgpmrMDSoQrgmAVQ0JrwoKaJaxWC340hvhijvUcqtdOdMD2b8ZjnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:50:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:50:39 +0000
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
Subject: [PATCH 05/16] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Date: Wed,  3 Sep 2025 11:33:31 +0200
Message-ID: <20250903095008.162049-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b819ad-9020-4e95-254c-08ddeacf56aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P8L1aEBI/7CHQQoBSxncATlutDyDkuSYNSWalWp6uNaFYZDxrOBk8nZ2aVBZ?=
 =?us-ascii?Q?V6zaqmDhkiDCz5+O+opnu7aSZPyJjKiOjYpicz8aS8a7jf2lBLWuWN652Qck?=
 =?us-ascii?Q?S1NfAjHVOAa3NIFMWHGiLEdEb0xTCsi9pyIuRVOK6O24xYIDJ68aGZN6CbPv?=
 =?us-ascii?Q?gIs9JnnkFrGEP3bQ57rrnYz5RY8kOJXlH79Or8J0KkqUeF8WxMNr88DncTpQ?=
 =?us-ascii?Q?5Hc0CXmp1C+HUvT+CocPH7rSmuz88rUaoRicsbQmH2HYjiMmfjVEs1RDI9O3?=
 =?us-ascii?Q?4xQg1zzGTPgelI5DiOVwE346Mjvld9BDpdANWD/HUIAJF20K9AdeVNPA94B/?=
 =?us-ascii?Q?i8WYaCWdzAr/gAKHOrApDjxEkCEVc5VJcMPad4Kg7rJFO6Urjv+17L0Qvz4i?=
 =?us-ascii?Q?7zRYT/taFJqgf5bGAysHiSDQxRj3CqxurYLIGXW2i3pl51UuueWbnsGOYtYU?=
 =?us-ascii?Q?oQBz5eciReIA2mHNw72QeF/G7hLcduacyHTB8t7cUl3th1Lh/LfZcndX/A8k?=
 =?us-ascii?Q?I40Y2V5Bm8HfSTvWjoFBQmnleKWzQzPfbXeOQiVIYkSk93cWBvqJexrEfl7q?=
 =?us-ascii?Q?0R2B5+WJMDsFIKTy2sUp5QqkSai0+npsXWJDK+rqMYdPKF+AYvw2tjLMCyM6?=
 =?us-ascii?Q?g8Bkfy1PXpaV+IZkHLRZRC1PJQpjT3W/MfbJAoz1ABT1iTQZ829h8O7APMB8?=
 =?us-ascii?Q?RiYDg4/6GjISJcs3lj0jji9VcBRhKoQNJausLgceT5yFDeXyOYIWScZ548th?=
 =?us-ascii?Q?Y3QuVJZoKbmBD4wvpKYCdCapspOGBQf43v/dG5RFekEduSB432j7NyNASHMw?=
 =?us-ascii?Q?NVpjlY2oe6zX6NcmOxc7jsJHCQ++wr3rtzmx2U9uj4M9cQPQVXGVR3BMe16Y?=
 =?us-ascii?Q?MVQzsS34ITS+Rn13xRbnxls5EUePV2YDyXGV+FGGRHvtOpEF1nM5ZacvrU+I?=
 =?us-ascii?Q?NYbuRHQcfseeegjRMMv8tKiKm7fVUThMvNONR7WetYcDuXQ5Ajp554+kFyez?=
 =?us-ascii?Q?JoBmubTIMYZMsUzAWaR9jommqLfbPl828heSeqpIEa3CQKm4dSPmWK9a2CU0?=
 =?us-ascii?Q?FytKnGX54BByaG8aZm+4abUfGP/Pu8r2ueORlzJerfnXQDprA1yOM8qI+1Ti?=
 =?us-ascii?Q?oN9fEWDq8Oark/TYqiDKHtYvVVzNlgCY2PT+41iUto0P3/OS3nQC6HKDDu5X?=
 =?us-ascii?Q?qSPtVlzDPGLLVcpLZOkxn6LWj0sQAVniU4StyBJpZVbP37hkkyvqPogwQ0l7?=
 =?us-ascii?Q?AHKGJSJBKCDK4+vxFJPjHJHGLIBHHa4/4X0lNPrjBVFnzKW4CHwjYcn0Wl/I?=
 =?us-ascii?Q?1DBdk0tRlTmDyqwJfJPWF1r9zp1myImQH7wowSlU2mYkYRmVsEwQpCt0skpy?=
 =?us-ascii?Q?qAnCe/UiXb6RMDooTzIkmdn8Bv8SL0q6+I3bEU7IlUyrHAyg33kcOgmAqCyq?=
 =?us-ascii?Q?7sjU24BMmXcgGpGrlQqkFlawEwZkDiBJdwzn9KEFY9myyISAp9Rh/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/I7RTVW1jGwmUc3/nhkBXgjY1elejqH/+RdL7a8KMUO6Zkv8XrPxWcuPpRpU?=
 =?us-ascii?Q?FxOLiK8+HaaVcIr6EQgTfemCCW4cyUfgzl611jcGxQeafnrRyOP8yx08+S6A?=
 =?us-ascii?Q?Hbg/fzWu5gOdhaCk+KBYJn8GjwsfdreheAglAqC1E8usfWJryyJrb5tmLr4n?=
 =?us-ascii?Q?nUFcW1U09kossJVhM5Sjr0zrdKA8Oa1uVUwKEPUwMzgUzpiE9uTUuQKKbq5h?=
 =?us-ascii?Q?yjfk9RHIIuwmFrfeEpynt145whXKuQN7zo7MsWv0WqGxjGyg4hW6nCodNiCR?=
 =?us-ascii?Q?A+JCWf6JorTvCvn54BV3dqX4QIBysLtrDqf9s/Nj/S402Cm7S/UiTA0G/bhS?=
 =?us-ascii?Q?t+44/7nE5LRtJ5zplGV3ai5a/d8PwnCoNvlNM5WFPu8PyXt5awqEXwEa5QD0?=
 =?us-ascii?Q?lXAX4fmiIb7mrGk/DEzCZkVqvnrcypim0yQJr4kfBYvGGfaYOnZy/kXiQhof?=
 =?us-ascii?Q?cy/SwCE7lHX9Ajf+q+60XBGZYOVY+q/6lw/zqh+D78YbRr0hhE+w2TBftHF0?=
 =?us-ascii?Q?47iFpfMRUM6r9jOj/YlA2ffh6gCZFmKzU9QsAaZKRywwybKew82AarJNCDgq?=
 =?us-ascii?Q?F4qA3o7IW3puOjZG8ewcJC/clpaKWZc+2LYVaRNAUeaQPfKEU5HnJXKci9Xn?=
 =?us-ascii?Q?DOBpSQlqW8jJEFti6rp/U1dqykuX6W5bJakVpjtws12zffNKYNF6MMoGn5Tm?=
 =?us-ascii?Q?z1cneW9ZJgwXFmx+1orE7f8qcFtAQAk9ajWGItBM/8d1Cmil+2VzTCCVqpct?=
 =?us-ascii?Q?M+AqcnziKmeVESPho+zRR5KtsYl9VX7SWNWblaVFUs4DoCLArzqF44Hl9rAL?=
 =?us-ascii?Q?+1sx8/FSSxvWz+0JGdR9+uV/jMfG19gqunMa+uBl64WWv/ELbK6szsPgTPVE?=
 =?us-ascii?Q?5oIHdlu2TRVd1cAAgEM5dB0kotFeDab1ol3uZL778ilZCddHJ71yI7MNyH0z?=
 =?us-ascii?Q?9MPh3tbAf+cy3kmSyQ0KDxkgFug5ef1YQ63DvgLPTaMvTlmENvRdc9/JRMP4?=
 =?us-ascii?Q?743bsTIAC1Gz2HUiP3pFPKOs+4jK2XQUakyor+SqLSkVBy45oz6kwjpU5l+x?=
 =?us-ascii?Q?MxcvNfVf5EJyI7BFdXPfcjRC9TyP+C6eeRe0FLrvmhFwDNtjd7Fp7UbCAVeW?=
 =?us-ascii?Q?p/y8Sqhdtxt58RNBX19MhTPGddn1v03jWdj153WjqBqNZhBIn2y9zSBwAF0b?=
 =?us-ascii?Q?6YLAA/mv9Qls9YkTV/ZYaDGJVXr3GziieTfqk6M+LtH4wZ+1gJLUWaue0KkL?=
 =?us-ascii?Q?9DyErgmmb+UDtsVjcCvEli940EzHAP5uEDmc2n1gEEDKtvhnJXDE8EHSNK3e?=
 =?us-ascii?Q?02TgZTMvLgh1e1vF+MoBGRj4z5ZD4Qs9NDATI2xi6/Hi076ZHSq0H0wBzNi/?=
 =?us-ascii?Q?bxYuJeHvLxRSl000kDZcEOg5tTQ3vIni/3O+zOCJbRSyecc8nU2zH1soUdbS?=
 =?us-ascii?Q?52o+zUZ7/AD9aWjVJZ4tTThwN7Zy3/tShMH17/Jk/RhyQ2iIQd2R/oaVi/mP?=
 =?us-ascii?Q?/e7tfow9PAQykKnF0m4ygjfka3HN/baK7T9rBt2c9PQLQL8MZqTy5tlzlWVh?=
 =?us-ascii?Q?CkMcJSuNFxQ1O6ySOYxzybyh0KjHvEYeZOo0E1kx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b819ad-9020-4e95-254c-08ddeacf56aa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:50:39.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGALg1y/PwZOQ868kiHEeqLMm1C0wJTwQxYx0uqGyuZvQFrJK35ZRl2zYdX7vkYaT8tEbIExGPgjvGbS8sGzyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

From: Joel Fernandes <joelagnelf@nvidia.com>

Hotplugged CPUs coming online do an enqueue but are not a part of any
root domain containing cpu_active() CPUs. So in this case, don't mess
with accounting and we can retry later. Without this patch, we see
crashes with sched_ext selftest's hotplug test due to divide by zero.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3c478a1b2890d..753e50b1e86fc 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1689,7 +1689,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	cpus = dl_bw_cpus(cpu);
 	cap = dl_bw_capacity(cpu);
 
-	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
+	/*
+	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
+	 * root domain containing cpu_active() CPUs. So in this case, don't mess
+	 * with accounting and we can retry later.
+	 */
+	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
 		return -EBUSY;
 
 	if (init) {
-- 
2.51.0


