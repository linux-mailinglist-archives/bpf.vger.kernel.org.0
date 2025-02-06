Return-Path: <bpf+bounces-50692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 042DCA2B34E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 21:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5501669A1
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 20:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442961D88D7;
	Thu,  6 Feb 2025 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r9WssNsm"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E71D6DBF;
	Thu,  6 Feb 2025 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873308; cv=fail; b=mw8+UqvUragsDwson7puh++rob1f8ouEJoObkeIDNpZ0JIMvFcF+OCLWcDoqCBBwHnSYLgSj/441Bzv76FAM/miJtAXdTMrOQkNEdqkJKYjY8c4Aq987x38M7bVc8XUTFJzIyFvs1m5+UX+I97saYCCnDFy65eK1/vjDPkXfbW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873308; c=relaxed/simple;
	bh=4KKf1PGCiOadWOWrEekrpAV8LWE4UxVYvoraeAmePpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ai8DdSsKhaNaYb5nSf1suFoyXFRYVJiTDsWri4dHnOVor9RVZuaAm4hUdNC3085r1TgIu81/GEcdCakVJprrmXddkUfysN39XJYrd4C0ENGipaGXxlJJWg1MtHamFYjB2VXJLrm4sakIw7tXnUTElaOdgSamifGP7YXYxgn3bdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r9WssNsm; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlrTiLp85FPlCd0IzcKyM3/mxRI0xsZnIumOrNpZya+axV0jULhVFhbaFZreV5oTP3e7p7SYd0jn9wNrk8HTXUM0GWjCF2F68bCnsOeW6X0p1bMDKCYAPPC7VYL6ledw+mh+kOMDs1v++KGFZL2fW7RtgT5lGTk3YhPAb3RyGwt5oWDmIwWfA3/DfIY1+3B1iSLcXij0jsmg2ca2/+2qFOOyWec+xkLRn/GSrWS0w9zlaZWhcIJSQdKH9WpYt6cP6Fv0hP44hh05kMwzJPTX8CIZ1xwr15fSlvVIyvuR5JdzP2PwD3OKFhxjoT2V22D9AVhxuM0hDT5woXnj/VwSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h3/imPYeugGLGjqlch/mf4pSavgICGPxzKjg2B/cYo=;
 b=kvmcdNcQu5CVSNBR2G17k01m8kCthF8OcY2gIIc8okHlSAT6OmLlIkVziB+UNwKMhYbzX0m1e2F6E0emcscq8Ij1g6VNirnBxn6XPO884/8oEcDhO4w9MAd7P9Ehl/wCKdQmuh6gg4V6Ub2qnsuhQvN5yaIvVqCBLmB766hjis8gHpvZO0b7qTlAzZs1SxbNssZdAfQEBlh+MSPajET+cMKg6frYPRcpmVZim6BspnPX7gcUlRCUJe9HJYLc19O2YtpXpGS9Z2uRQepfOUnd+yBshnJzAyyJPabw+WZBfuXZ6Lbzk32kSWCt3CbLg8lYH04sQgVst2nuKBAmsqmLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h3/imPYeugGLGjqlch/mf4pSavgICGPxzKjg2B/cYo=;
 b=r9WssNsmgOg3Cru0PMNrdc0W6i54VBQ/GNSpueqkrT76LhPDvYlmpeVwXmnX8ii7HDeHfNEOWc5jpTKZyF+sAifdWKwX+u8HmcdxhJTlC7UzGlo4ZJbq8B3XZXKd2aT6oeHZtnunurGGjOCvnZRXVxFjT+XrDa+I+TeJLYBG6w3T8cSvH59Ig63qQ/5XNY8Sb0tT2Nj9P3O4T/nb/cuvRJ4eWYQdP2WXwsQM5IMQ388r1qNyzR0vtfCXs8amsGiG0ilL53sM4aJVuvFEdyLohwxlheXh6b2hsK+tU43duK9o9CsVBY2ikHomezgcPN3XDjFeEIAyYmAfJPw7V3QcOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 20:21:45 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 20:21:43 +0000
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
Subject: [PATCH 2/5] sched_ext: idle: Introduce SCX_OPS_BUILTIN_IDLE_PER_NODE
Date: Thu,  6 Feb 2025 21:15:32 +0100
Message-ID: <20250206202109.384179-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206202109.384179-1-arighi@nvidia.com>
References: <20250206202109.384179-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cb2d73-b83b-441b-f090-08dd46ebdf44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A7OncEm2WFpC0SfRsko+jfTjB2zuYqsPGZHHVoMp5021DJQ8YyNH1clXzfRD?=
 =?us-ascii?Q?C4xsjOmihXovQUlmRaN3acl1grzJU3haiBh6GTvVjenMVUB9WSNt13m/i4Lp?=
 =?us-ascii?Q?Wo+dcKS4i/vbQNRUMpH/x0CjmZbROoDV1CJgdXj23ibnyhmDAOTJ91uHhXIb?=
 =?us-ascii?Q?uFycUIh/hfNXeNszfTlrjUruKYqilGlJKzVwBl81GiUDkPvlupIUmwRv7KTc?=
 =?us-ascii?Q?peH4sY1D0rHdT6iLiP5wQCgWDNEY1QA6OUAp104O+sHGhhMwUvoO1nnkmgO9?=
 =?us-ascii?Q?LgsK/0QfBBXbCJ+PcmoY1Igh2vk9juHvhYhPK44F7T/iYU2lj0TYVPQ0vKgz?=
 =?us-ascii?Q?eqsOOzC5zs52ME8tVR9MxpqnvKWsJVu1ftvaIsN3QbXZ70dWcclFDV7oZsuy?=
 =?us-ascii?Q?2GWh9mfC9/BLBLyiLJKNkCrLHxyBuFLXnHFchXIUMnDwGkb53Qxtsi4Iv7AA?=
 =?us-ascii?Q?4AP0FWZaTTSajkpGhFSrKdA9ngkEzsUEJyv9vuNEwGmX1dKDkmyB8CrHFq/b?=
 =?us-ascii?Q?jS+gK0gwbwI9d/sC6r2XIRdQELJNgotNbPXGrac3AatghCj9NzOUWT6vonU5?=
 =?us-ascii?Q?7Ad5nMxvaYArtnKvIESKn4u5pYHLC/YpfPftndWal+LlZl3XUWydgaUQs/xs?=
 =?us-ascii?Q?Sr3lm2dV7E4Qb6Qit5If4FVSLkocUtwTXGTEgtztzv2YtUyzCafceVXPiq9c?=
 =?us-ascii?Q?FS8Jk1Ot81dd+BqJlQIyylHer+0WwAW8r426PBVjiiPmze2f3NnD9bdBrU+t?=
 =?us-ascii?Q?EpQf8eN7nBs4PXblf5lKyt2C9fqZzVDSbjfEWXdVQEYZGivVHBRdjcfIgcuO?=
 =?us-ascii?Q?99Ks8gBFCIhDocrfFSdH3N0rRqNvsa6Fdg/8arVKVM/Nan/+Pr6lNIZHu4Vt?=
 =?us-ascii?Q?YWFl+rjXJuEzvKajU+TlyTfl56jQ4Vu8aZGl/qWjz8fUzXfoUhTBYg9GSW2+?=
 =?us-ascii?Q?HQ1T5AVyuzCz+gEuv+cPnYJNmun9T+bLJzEa6DV+wRS28WvOX/cqt6DDnbhD?=
 =?us-ascii?Q?J3+b+iwfLyEqh17amnEVIPNvdtgbmTe0JinaOq3jTTTldw6JMFPZudQ5VSRJ?=
 =?us-ascii?Q?W2Xzu4eGfDX8536gWrEogdedjdIWlSOTAy/vorTZ8451wFCEXMSD0b+bXjXo?=
 =?us-ascii?Q?c+v/bDWpR+FfTogQj8hm53dlxBnixUaIa5GDD6Lb4nNsR5k1WGICSKGdNUaY?=
 =?us-ascii?Q?IuXcWGMXCP4ww3V2CeisrruJqf4lshW4gcpJquhBoQB3fk/m9egCOiDrhnno?=
 =?us-ascii?Q?2fxnNz20vvy7CGlEOkz8xJentRe3oIyFapvnQLA6BCgeRpyODyI1ol0BDXn6?=
 =?us-ascii?Q?7B6UH8XsZFcVY41JhvIYBCOhRi8tewy36ns2vwjEpT9RX2rWOSrz1CEA80zH?=
 =?us-ascii?Q?iRwRwhneM+nCYLwhcNVMypixAG9L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BqTVji3mOo6+gtWYPypsYPK6Fs7EPMucT4cVJOmxJHQpPdoI5j7GLYmVQMpa?=
 =?us-ascii?Q?L+PzU3G9GRDnC0IORLwjmANeHn2+0Rlv9Gz/KlaeLpz+eGGhv6EcDLFDigwL?=
 =?us-ascii?Q?M5z/BGuBBE9VaDYl2uVCbvf0Xzh2Mw2Ls0KPV2NkF1LeL2SRHUUsR+2VraPo?=
 =?us-ascii?Q?ixwvzP+pFGBhlah1+Yg6cEfWU88z67xfOkX4JuqFAWNKCc8dGhnptosM+T4+?=
 =?us-ascii?Q?anPVlbEn4nGRlHnChyUEyj8PI+Uip6uu+/nW7a5pVeQWAJtAmB4USGwBx6m+?=
 =?us-ascii?Q?/UrRf0U4P3ch7vjj7v0Pji4gsO3aFYTryw/346hCPB7FV1RkjSDQTpPB2v1f?=
 =?us-ascii?Q?SVuSnwe5oupTvHLmix4t/389cuql67eh+9qtloikswsjQBat0q7p/jzi4Mpa?=
 =?us-ascii?Q?bjyLdh6vkusrXSKAU4R6WD+Vpb6OURAXtn2gqxVkUhBw4JmAQBaMJwbEHaAY?=
 =?us-ascii?Q?wgsGluv/i3kax4W78FODXlgAbmwWzJkrlxjEqFrWrrfQC/yQdz4TkawrkEQJ?=
 =?us-ascii?Q?5e3fQIAmHl3/40W8NQp/A0tU5+LIgOOF0e1Yp79LufgLF6Sxc1nPHmmDz67m?=
 =?us-ascii?Q?wAO9EJ7h6hC51Yy8ob6yeOm/SvADK+yWA+/6Jf9jStQC+bvslhptvZQNnVqp?=
 =?us-ascii?Q?nlu4GYVXTXWraaJolb10TWj9MllbDQFsG8CBOtfTHdZaD0Ix3UyBxESzoQgQ?=
 =?us-ascii?Q?lKq+J9wbHGHw3US5HCNOTnucSKr3hrRhVbnX3LxHLfwfsbFfX1do9wF9mCmZ?=
 =?us-ascii?Q?AJDUjf1aC4ZLu0AjqUey8OIPaZXKNIKPO8Nm9Wom3CMTZQMFrdOmlYNOxjRF?=
 =?us-ascii?Q?XF/jNlt/LiE2N5Kq/wTDIvVbT48MQdPhtU3nc5zVW0jnjgNCLiWwyGDstdHb?=
 =?us-ascii?Q?xn10Oo78Z0AuVVS2wHQzBba2I0s/NyDBfVvtaXailOy0hElnN1TXMINcFepu?=
 =?us-ascii?Q?0mLUDiISJtRjFvLNh46hvXcAGGTisU7mzDJkHlNzBHeUBpQtUZUpr5BIMGzn?=
 =?us-ascii?Q?y/Q5sZ70UEFTNz9ckVq/YAGzBAQ5kh9Jo6o6jDbtEZsRRlSgpthqRNGnm+y1?=
 =?us-ascii?Q?FqelRiATaPmKW9g2wOvzzj2OmR21cWlTiXLoOZsjO/EqJScLX8aqi32TLu81?=
 =?us-ascii?Q?8Pk/nkhbvbLPwYaMrtZ9I2f3qDcrePO9gOuF2iYYnNGKYJDtgOTuXTUmWnDP?=
 =?us-ascii?Q?l/UYZoswjJYzZzLM/R0/8x9s9C/JqJ9ZUpsNwnh36sQv77AT72C8CY7JqRHw?=
 =?us-ascii?Q?as3NfWTh7lkOb+Gut9tDEyzpadD+e4vaN0FzbqVmPil5a+8dQ1GMDVcgfA5m?=
 =?us-ascii?Q?rWBbguv2276jFj9YQbwMOj1DdT5d+cPNGOBtoZCX9LdATqWdEIKTtQjz3xxn?=
 =?us-ascii?Q?oX1zXpBAg3PN9dV0yUarCK81xFWeCEyEjdTdjiafp7DVik6LrVQr9enPnKyn?=
 =?us-ascii?Q?KP5e6oiE616LdDFFus4j8OUo3R8hx4XIbeuf/6L+gJZplM4iJwCZHUVZ+qOZ?=
 =?us-ascii?Q?DKR/W37YOjfhsoLw1h7q6mTqQZu5wzcF42lisowis7BNc56Tufk4bfe4DpTJ?=
 =?us-ascii?Q?d4SNjj0KnonpOJ3xSf7Tte+3m+XjA9KPeWnmeMha?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cb2d73-b83b-441b-f090-08dd46ebdf44
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 20:21:43.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiOQDleQdujeisN8gnsaeTg7lfjojjrkSnrJNouFhsGUfSlQK7HJFnl5w3pjEHYVdU/BheL/DjxT8fvU4SiKdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

Add the new scheduler flag SCX_OPS_BUILTIN_IDLE_PER_NODE, which allows
scx schedulers to select between using a global flat idle cpumask or
multiple per-node cpumasks.

This only introduces the flag and the mechanism to enable/disable this
feature without affecting any scheduling behavior.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      | 21 +++++++++++++++++++--
 kernel/sched/ext_idle.c | 33 +++++++++++++++++++++++++--------
 kernel/sched/ext_idle.h |  6 ++++--
 3 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8a9a30895381a..0063a646124bc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -125,6 +125,12 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_SWITCH_PARTIAL	= 1LLU << 3,
 
+	/*
+	 * If set, enable per-node idle cpumasks. If clear, use a single global
+	 * flat idle cpumask.
+	 */
+	SCX_OPS_BUILTIN_IDLE_PER_NODE = 1LLU << 4,
+
 	/*
 	 * CPU cgroup support flags
 	 */
@@ -134,6 +140,7 @@ enum scx_ops_flags {
 				  SCX_OPS_ENQ_LAST |
 				  SCX_OPS_ENQ_EXITING |
 				  SCX_OPS_SWITCH_PARTIAL |
+				  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 				  SCX_OPS_HAS_CGROUP_WEIGHT,
 };
 
@@ -3344,7 +3351,7 @@ static void handle_hotplug(struct rq *rq, bool online)
 	atomic_long_inc(&scx_hotplug_seq);
 
 	if (scx_enabled())
-		scx_idle_update_selcpu_topology();
+		scx_idle_update_selcpu_topology(&scx_ops);
 
 	if (online && SCX_HAS_OP(cpu_online))
 		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
@@ -5116,6 +5123,16 @@ static int validate_ops(const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	/*
+	 * SCX_OPS_BUILTIN_IDLE_PER_NODE requires built-in CPU idle
+	 * selection policy to be enabled.
+	 */
+	if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
+	    (ops->update_idle && !(ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE requires CPU idle selection enabled");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -5240,7 +5257,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			static_branch_enable_cpuslocked(&scx_has_op[i]);
 
 	check_hotplug_seq(ops);
-	scx_idle_update_selcpu_topology();
+	scx_idle_update_selcpu_topology(ops);
 
 	cpus_read_unlock();
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index cb981956005b4..a3f2b00903ac2 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -14,6 +14,9 @@
 /* Enable/disable built-in idle CPU selection policy */
 DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
+/* Enable/disable per-node idle cpumasks */
+DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
+
 #ifdef CONFIG_SMP
 #ifdef CONFIG_CPUMASK_OFFSTACK
 #define CL_ALIGNED_IF_ONSTACK
@@ -204,9 +207,9 @@ static bool llc_numa_mismatch(void)
  * CPU belongs to a single LLC domain, and that each LLC domain is entirely
  * contained within a single NUMA node.
  */
-void scx_idle_update_selcpu_topology(void)
+void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 {
-	bool enable_llc = false, enable_numa = false;
+	bool enable_llc = false, enable_numa = false, enable_idle_node = false;
 	unsigned int nr_cpus;
 	s32 cpu = cpumask_first(cpu_online_mask);
 
@@ -237,13 +240,21 @@ void scx_idle_update_selcpu_topology(void)
 	 * If all CPUs belong to the same NUMA node and the same LLC domain,
 	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
 	 * for an idle CPU in the same domain twice is redundant.
+	 *
+	 * If SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled ignore the NUMA
+	 * optimization, as we would naturally select idle CPUs within
+	 * specific NUMA nodes querying the corresponding per-node cpumask.
 	 */
-	nr_cpus = numa_weight(cpu);
-	if (nr_cpus > 0) {
-		if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
-			enable_numa = true;
-		pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
-			 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
+	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) {
+		enable_idle_node = true;
+	} else {
+		nr_cpus = numa_weight(cpu);
+		if (nr_cpus > 0) {
+			if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
+				enable_numa = true;
+			pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
+				 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
+		}
 	}
 	rcu_read_unlock();
 
@@ -251,6 +262,8 @@ void scx_idle_update_selcpu_topology(void)
 		 str_enabled_disabled(enable_llc));
 	pr_debug("sched_ext: NUMA idle selection %s\n",
 		 str_enabled_disabled(enable_numa));
+	pr_debug("sched_ext: per-node idle cpumask %s\n",
+		 str_enabled_disabled(enable_idle_node));
 
 	if (enable_llc)
 		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
@@ -260,6 +273,10 @@ void scx_idle_update_selcpu_topology(void)
 		static_branch_enable_cpuslocked(&scx_selcpu_topo_numa);
 	else
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
+	if (enable_idle_node)
+		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
+	else
+		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
 }
 
 /*
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 7a13a74815ba7..d005bd22c19a5 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -10,19 +10,21 @@
 #ifndef _KERNEL_SCHED_EXT_IDLE_H
 #define _KERNEL_SCHED_EXT_IDLE_H
 
+struct sched_ext_ops;
+
 extern struct static_key_false scx_builtin_idle_enabled;
 
 #ifdef CONFIG_SMP
 extern struct static_key_false scx_selcpu_topo_llc;
 extern struct static_key_false scx_selcpu_topo_numa;
 
-void scx_idle_update_selcpu_topology(void);
+void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
 void scx_idle_reset_masks(void);
 void scx_idle_init_masks(void);
 bool scx_idle_test_and_clear_cpu(int cpu);
 s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags);
 #else /* !CONFIG_SMP */
-static inline void scx_idle_update_selcpu_topology(void) {}
+static inline void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops) {}
 static inline void scx_idle_reset_masks(void) {}
 static inline void scx_idle_init_masks(void) {}
 static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
-- 
2.48.1


