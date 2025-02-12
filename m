Return-Path: <bpf+bounces-51279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 618CBA32C7E
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE003AB2B5
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49B25D536;
	Wed, 12 Feb 2025 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sgqEAet4"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C02C25C70B;
	Wed, 12 Feb 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379053; cv=fail; b=krGfhIdBL1P5gS5C9fqXtEKPyiFZtHOYKBgLSBzCfmM5Iv+6RbZTAxTWBNEBA9RlH6F8MiZyWufrjU1+IrMtZziJscxNKdyxafoUhGIZ4nz3/r/+9f8FeOVIBLv+CBQ0iuOW+qICAKQvbZVxm3+bGRuBs5OIWHi7PKasucyieJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379053; c=relaxed/simple;
	bh=04dPPtQbMM/HGKNhFKkxWQWrMJhfleU24vXfMbfD37M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rU/VVQMYa6uoqTETecHhuPJfSv6jOkAS99D4oChed6NBdu/s0+zAGGdFrUpx0o8/ax6QHcWfC6caEPaCQST3abn8JRIQ8hEo07sDK3I/80CjCp32GxjGSDry7X/Nfm7Ac1NaQabSw0BVtiW3hm5df3XEnRGz5XmTAbNnO6gQuY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sgqEAet4; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjBCV9hcew8OQJUjM5oN8bYYQGOVqpSc4l1Db/HWbXPy3xC/hsPWWS8TvxCeZfif4KhDdMNdBA/mV/BTJ8LICheLoYB9gAMS4EqwnzFN3JLTxaJyir3EYOg2G9qWF6dWufOkO2RJ6Cmu0nv6LrnnLGW5PEyKsMoGxcf19AfZfeeWvv2nTt2jaXb/0z7ifkPq0rMgeZwb+4JlN3ph/ASadHaGGNhJ/1vj/aNZy1NB6fvFGIUDZf8uibEr4yL6msMjhLgCvCkiGPR0322Lv3BsTnWm/GwlgRNG6PYiZTJoARQmrQ/FyeF/LA2zgQHsTvnPs3LrhZVmU2C5juULzuwP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOaX4B2ONZ+x2cyilRPxet4WzDZ9q3DdTklTuiRTqGg=;
 b=Ndl/iJCSHTrY+VdAgvdv8hU9icJawzy7GcLT7qKlacAdKjJ1aWMqKuYrbybLh4tt06GpCbUjpNavL6LBJ+RG0Flg09h3R7tcT46ED7DVsoXtrjKORA6gteayAt6EaTOKI7ktRWWUEDgMEwws/5/IR2nYkRtqqgcRH5P7wk4up8KZ3VKIHD6Tb/oIoYwm6K69ISNVnFslphzzJepRmTENm40pLxi9ynvArTOvWX30y7qlk7pgjkRJzIny8GhNV6EmRt5XqcsJkt59fYaSxqXicNw+5VIvEjtZ/JKOXg4QLk0At8DQp1rQudM/sbhIihcSJxFgF+Npwuh/lcFIpJzISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOaX4B2ONZ+x2cyilRPxet4WzDZ9q3DdTklTuiRTqGg=;
 b=sgqEAet44jcbgefDdpUFjxETldM1a/ztPo1g6Rx2D2HsqOUCwtncYk/8/W84nT0R33o5p/SXtrvPWCAJNv5l6mLR35rW1oWNagRj2dhkn1LfRcFVkLc1EWJfgkyp45HsaFAtO2eIsUlTfewLiWF1T0y51I2qQOLj3aHA2tlDH+Mo0sg1DLbLbN+JPMTQ0TRH0hnLC0M4AjhDIz3YonW4w6T/bXr1NjJMP8w0HMbO5IuJ8D2ZLdqy//xoxX6x/UCvrUvKmG///s332TvrfzrNx4r4dQU8nRBMmPxIcZsAhP41eKP4YavU+vrZCaRb8V4yR+uEeteqfvN/4oO4x5I8qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 16:50:49 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 16:50:48 +0000
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
	Joel Fernandes <joel@joelfernandes.org>,
	Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 5/7] sched_ext: idle: Introduce SCX_OPS_BUILTIN_IDLE_PER_NODE
Date: Wed, 12 Feb 2025 17:48:12 +0100
Message-ID: <20250212165006.490130-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212165006.490130-1-arighi@nvidia.com>
References: <20250212165006.490130-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::16) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6b118e-0bbc-48c4-30f3-08dd4b8566fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kIrIL2yNjgJ0NLKHHLR4gkF8gXI+ulvI5HzB/fQDPNlE/9HxhrzwV4BAf9mv?=
 =?us-ascii?Q?2tlz/CEMOh2HhAtsCdKoJS9Cyhe9hKKZF+d+fBIeW7WRiNw/Gtv81pZxEQma?=
 =?us-ascii?Q?xLGzD0J6FLLMTxCRSxbk5GWkTCey7ddWXc2XHiVBIS2C88MXPgdF432TxZjG?=
 =?us-ascii?Q?sFLEEVM1jstHQbZxtmdmWTg6b8c5sys00KlZA6xxqlCau1k9V1FMQxSDewMv?=
 =?us-ascii?Q?MxYxagFH88WFsk63n1u26BUidc0Kx2DgyUd2nRWr92yxDB39oY2cGgVr10C5?=
 =?us-ascii?Q?20LXXSVn5A/b/srAN77gs/oTvqnxISGPQ+xE04HQeeDlBzrPSxPrhNcVgnce?=
 =?us-ascii?Q?0bpKRyKd0rShx+ca9xaLO4mUXqtjXA+P2PIsgBRODf2kVhOf74r5xDlN3Wd2?=
 =?us-ascii?Q?q266m0h3LKqkKNXQ9sg8vViNPH4LnBKaGFqZ41chbkrU5BmB6SsnypXbj8b/?=
 =?us-ascii?Q?EN/qfwEcSwTePu05r0mmsr612mwtreAvUPSBml/AZrLxToGvvonV5v0UUdSF?=
 =?us-ascii?Q?M9II5LFrP9LwBqY31gulLFCjLlv1XpOJhKOOnxR+SUw4iW2i7qy0vR8dBMxv?=
 =?us-ascii?Q?8ZawMebgsYpdD3tSaJlOWqynQxfZLIKvdGoNAsniN+wagvnyn907xOsIxayy?=
 =?us-ascii?Q?kAqX6VS948bAST/2c1RvkdcIm5H+N/SU4YWXQ7bAj6wZ1H2ma2miQlrY8Lja?=
 =?us-ascii?Q?nixGacBHKDBZuDttguloB9J1uQmNpZOdfCzQYRzJHn1ecs4LUaAIYqQIaE2I?=
 =?us-ascii?Q?BwfOCe62qchV7yeVUVyyIX7ksq+HB1BOrkjws9Ab1zHUYgjqPODGGWD2C+RZ?=
 =?us-ascii?Q?qY9USf2lZkCjRqBdenU3VCzdslFCXHoIJmqK6quDy8WGQrla+n9vHplEkONa?=
 =?us-ascii?Q?GjPvrYdALec7a3G+QhT6MWDMRtbEvCgNJX1d0hm4k14PP4ifUT88bBYyQp71?=
 =?us-ascii?Q?7v7KuGh2/jZ481Rl0FjRA+CSexHO+hsns/3qTyOC/Y/WQxrGHicXGGz3wNhj?=
 =?us-ascii?Q?RbIvTnuxuybp4FdIv0aWhw/ZrNe+uqC4d9oKnAG5gxo0dRkdQ933ioxVEhFD?=
 =?us-ascii?Q?2zPnSfMOEC6ZtSgwtNa2x7odVzZpOPwrKpogTJNL/YD4c+mKiO3cKfwu+i0y?=
 =?us-ascii?Q?9Bk5wwe+NwuwDhv8rpqvaMroAhZsnCEyGE4ImeeV1zUnDHutJotHkMnG/4UL?=
 =?us-ascii?Q?sE8/QHjKR8wr90QrjLCIyJHwRBnfIVuz1Lyp4TsZE/9CbdpZ3aC6k9vqEB2q?=
 =?us-ascii?Q?K/CfMRHYoXOU+lJqMW64xXj1oSXuZxS1ntVbcNBZA37viujPnwb/fxucwizJ?=
 =?us-ascii?Q?Tqb6hVMZ+/vsPOXwYiGjyJgJwOIFxNyBNd3jwEu+FhaMEzwyqSkEgKCVNQqc?=
 =?us-ascii?Q?Q4llxVKOPH8M/XlzTO+gzQWVCfFZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LKAyRHrLODENqdiX9IABkxifAKd5XQA4QAOnd6K0AkK7ACt0c0SRd+UZA7gk?=
 =?us-ascii?Q?nv1NyusEhztSlpO6QplSmjZ2lT+LX7Wd8pbBLB0EophrdBGXuFxAQJdD2XlU?=
 =?us-ascii?Q?9j37pw5942awaxscKssa6ZTwrFEfL0/1bJoB0cW8nyxoYvV1Knf70cn5lAlX?=
 =?us-ascii?Q?NFpstkCLwoFV8P4OQBOkj5tM5ED18E0yKj8NNXMAl6jS8uql4P+Dwgy1nmcz?=
 =?us-ascii?Q?xGwkbdkkNfldG/o/TzaPIEMjPCCbcz++/vbw6tTnxohFiysVqsnjJr9L4Ofx?=
 =?us-ascii?Q?nd54gRY5dPgie+7y828G7jTvVn/Yj7HmJYTlshXpVprMR0sm7XM/OW0Gxyn2?=
 =?us-ascii?Q?2jynRTErwGKge/xbxg6TEQmyYgbyBDs3DHWYpiHztLT5lhUByECQ5VwVkQWW?=
 =?us-ascii?Q?amXw2g9xrAVnyimgY2RbkLb2QOYjjZobDpGDW+rsYqwEr4yFnTDps2XFgiHq?=
 =?us-ascii?Q?Ornm56D8b0dEyWPc3A03pZ6ShxKNwomhFsgusU8czOaf5p1P3F/KPM6uVUSx?=
 =?us-ascii?Q?hs1nUrPbti+GBry4DPd5zWcoP8bi7pf09kgkNXzIGwiIH27GRasFw1QGoFL5?=
 =?us-ascii?Q?+tahA16otP9rvSrHytUoUdxupDTZHmjZzPeAdQl03CSmOYH1hoRj6rSTqZ7U?=
 =?us-ascii?Q?siu5Qp0Y2d94UGPpssmCBz4My/PjiNR8hJbnHp2cUV7aW0WqefUGOgk2pdZK?=
 =?us-ascii?Q?KaiYFOI/6ED2e6YP5bif8AWoLfoo4zIY1+GMih5XGJE1mOx2CMp4dhxVjnsQ?=
 =?us-ascii?Q?x051JJ5FW1q2zrfVZfpAl43MT7IWjC21G/M8ir/9Q2TU1Kp0dSD6Ji+8ISEI?=
 =?us-ascii?Q?XP4KN78VW2xTTxqpvhIOlw67Tzx0d+3uG6dsctTh2DCunz4iCHqIUAC19LSd?=
 =?us-ascii?Q?L8c7YYoAunsjtcd84Wn4/WtlDzA9Jt4wCBjzXNAOdVxbCy1ArHwhAPZi2r61?=
 =?us-ascii?Q?qrvXCDvHB0DitWjSyIKujHgmw4WeDqayqOzcoGrZaR8+Vs0k7z16DCtxLV9u?=
 =?us-ascii?Q?CS0LfWqmCxnQNr0UJAKqtfUs1z8GSSrhHb+QqZMrzVdEqXB5JaFDZTC374Ht?=
 =?us-ascii?Q?HJl3UrSD3SkPAM32RP40sRNwKOLqO1qd3qn/jz4vN/Hmqoq0nMjQKnaa/M50?=
 =?us-ascii?Q?0NsPdevrVaqpQz7q8dttL99EV1qKnGVekGMYdBntdJ1iZUHfnywRd9MET3dd?=
 =?us-ascii?Q?6hbSGIjJkxDqcbbVAw2qyGvAhoELbiAY9A6qINSLaLMWRD9+PxqaTEOx/O4N?=
 =?us-ascii?Q?4s66uZ6DeOEpdkBmUxLhCme99bZSmCVe+0x92A6TvHgChGhEHlA11CzECE/u?=
 =?us-ascii?Q?U2KNRt7d9n7ItvK58Xf6B8xTLPSD43WU+MCkmGFSG9MsrI/AyFC0hLuNI98V?=
 =?us-ascii?Q?UNF47gQ4J1Xx3zYkwcNZ4yeTkIReSoPLWz9q7ZeS5/0WTRBt82Vu8CLqCHQz?=
 =?us-ascii?Q?wCvc6YMPEi5H5si+nVyvhx/s71fvyioeVMtLCC4NGk22qyDnWxuonV3JM4BL?=
 =?us-ascii?Q?pXkq0/qvQE+ocUbKGwO4CUJ94SCcHZ+kQlFg0adFm53+wlfQQz8w0StrwNTP?=
 =?us-ascii?Q?Fjf52kceSgzsfaUE99jWM51dITWh9rQ2i83NRkh+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6b118e-0bbc-48c4-30f3-08dd4b8566fb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:50:48.8446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaS9/5JF7O7OlGY/ERzvxhsa4zmxHLXL9E6RtiiEvt4IvrxGl90tLjPOJATOmbIkGOZ5SSECDmy08yQuP0KCZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

Add the new scheduler flag SCX_OPS_BUILTIN_IDLE_PER_NODE, which allows
BPF schedulers to select between using a global flat idle cpumask or
multiple per-node cpumasks.

This only introduces the flag and the mechanism to enable/disable this
feature without affecting any scheduling behavior.

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                   | 21 ++++++++++++++++++--
 kernel/sched/ext_idle.c              | 29 +++++++++++++++++++++-------
 kernel/sched/ext_idle.h              |  4 ++--
 tools/sched_ext/include/scx/compat.h |  3 +++
 4 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c47e7e2024a94..c3e154f0e8188 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -138,6 +138,12 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_ENQ_MIGRATION_DISABLED = 1LLU << 4,
 
+	/*
+	 * If set, enable per-node idle cpumasks. If clear, use a single global
+	 * flat idle cpumask.
+	 */
+	SCX_OPS_BUILTIN_IDLE_PER_NODE = 1LLU << 5,
+
 	/*
 	 * CPU cgroup support flags
 	 */
@@ -148,6 +154,7 @@ enum scx_ops_flags {
 				  SCX_OPS_ENQ_EXITING |
 				  SCX_OPS_ENQ_MIGRATION_DISABLED |
 				  SCX_OPS_SWITCH_PARTIAL |
+				  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 				  SCX_OPS_HAS_CGROUP_WEIGHT,
 };
 
@@ -3409,7 +3416,7 @@ static void handle_hotplug(struct rq *rq, bool online)
 	atomic_long_inc(&scx_hotplug_seq);
 
 	if (scx_enabled())
-		scx_idle_update_selcpu_topology();
+		scx_idle_update_selcpu_topology(&scx_ops);
 
 	if (online && SCX_HAS_OP(cpu_online))
 		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
@@ -5184,6 +5191,16 @@ static int validate_ops(const struct sched_ext_ops *ops)
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
 
@@ -5308,7 +5325,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			static_branch_enable_cpuslocked(&scx_has_op[i]);
 
 	check_hotplug_seq(ops);
-	scx_idle_update_selcpu_topology();
+	scx_idle_update_selcpu_topology(ops);
 
 	cpus_read_unlock();
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index ed1804506585b..59b9e95238e97 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -14,6 +14,9 @@
 /* Enable/disable built-in idle CPU selection policy */
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
+/* Enable/disable per-node idle cpumasks */
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
+
 #ifdef CONFIG_SMP
 #ifdef CONFIG_CPUMASK_OFFSTACK
 #define CL_ALIGNED_IF_ONSTACK
@@ -204,7 +207,7 @@ static bool llc_numa_mismatch(void)
  * CPU belongs to a single LLC domain, and that each LLC domain is entirely
  * contained within a single NUMA node.
  */
-void scx_idle_update_selcpu_topology(void)
+void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 {
 	bool enable_llc = false, enable_numa = false;
 	unsigned int nr_cpus;
@@ -237,13 +240,19 @@ void scx_idle_update_selcpu_topology(void)
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
+	if (!(ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)) {
+		nr_cpus = numa_weight(cpu);
+		if (nr_cpus > 0) {
+			if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
+				enable_numa = true;
+			pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
+				 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
+		}
 	}
 	rcu_read_unlock();
 
@@ -530,6 +539,11 @@ void scx_idle_enable(struct sched_ext_ops *ops)
 	}
 	static_branch_enable(&scx_builtin_idle_enabled);
 
+	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
+		static_branch_enable(&scx_builtin_idle_per_node);
+	else
+		static_branch_disable(&scx_builtin_idle_per_node);
+
 #ifdef CONFIG_SMP
 	/*
 	 * Consider all online cpus idle. Should converge to the actual state
@@ -543,6 +557,7 @@ void scx_idle_enable(struct sched_ext_ops *ops)
 void scx_idle_disable(void)
 {
 	static_branch_disable(&scx_builtin_idle_enabled);
+	static_branch_disable(&scx_builtin_idle_per_node);
 }
 
 /********************************************************************************
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index bbac0fd9a5ddd..339b6ec9c4cb7 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -13,12 +13,12 @@
 struct sched_ext_ops;
 
 #ifdef CONFIG_SMP
-void scx_idle_update_selcpu_topology(void);
+void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
 void scx_idle_init_masks(void);
 bool scx_idle_test_and_clear_cpu(int cpu);
 s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags);
 #else /* !CONFIG_SMP */
-static inline void scx_idle_update_selcpu_topology(void) {}
+static inline void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops) {}
 static inline void scx_idle_init_masks(void) {}
 static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
 static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index b50280e2ba2ba..d63cf40be8eee 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -109,6 +109,9 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_SWITCH_PARTIAL							\
 	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_SWITCH_PARTIAL")
 
+#define SCX_OPS_BUILTIN_IDLE_PER_NODE						\
+	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE")
+
 static inline long scx_hotplug_seq(void)
 {
 	int fd;
-- 
2.48.1


