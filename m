Return-Path: <bpf+bounces-71196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E85BE7DB7
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD518567398
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890152D661D;
	Fri, 17 Oct 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ATq6fuJh"
X-Original-To: bpf@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75A25A324;
	Fri, 17 Oct 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693696; cv=fail; b=UMzUPnYIEAum4Piw/ydOf3rRCgp77DJVi2lGL4lmnUss7/KKDIimssBxVP+PU/tO2Un8iCGoajJpdfQ9Fa8E8rDOxSWUGJ8pn0HMJPXXC5X/3j//xc0rd/Wn6BGsxuv03cfQbiDkwJoNkVj8/U2HzxyMiHQ0H44F9jRJwzXVHlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693696; c=relaxed/simple;
	bh=wofDI3jrH5OrGWat/4MpSvHHSBzDcDpzljlE9YhAQXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYERqIztcv65gpI7L5sU6WnSuB/3CQAfgN72rrSqR2BR1cdDz3OmExXF57Ubg41vhBLHC7x89vIiTPaMK709w7ENlPKG/ZTBFaBWdELiXh0QXhkdJLQAOd+50lq89+g2Yo0T2lEz5NP3SxLlMGj6AMt7P9QjvE2TuGuenyZG23Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ATq6fuJh; arc=fail smtp.client-ip=40.93.198.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1jMTL73qccvacV2DlyY40XM+1mQHUCx4bi2jLxOtEMmKk73txZWN2/6tDI6PxfksJ1u95+1pvGnm554FReurqfA54erSfUdDb62ALMQsxDrN3lyfYzZMjE5gnL/q4dlyDvy/LKpGfP6Ab+stLHqRSGglrmCjj7ezDKACcIhQ9unlob9zKVg6VjjpxdwcpU3sVTTeWuvmVxhs6RiPe56mHp8vlg7rT+Tjlv3WiNP2RJBgNwwc7R/ynXMsaRI/+haDiZaOg+uQwZ3fGEsoPa1BQiG2cWsOXBvdNzo8muCRPrqLLc7BNvd2v4aj/cFaFnEsB88cU4p3s0jwSqMwThWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7mWF40118ds1sm1RT+DFgiPKKZJcvbibyjXLAIKdR8=;
 b=v+8HH7E3L4mtR84uiJ0tRwXdZPZdTT6TLv6Xknrc2tz1sBytduSHqu+hjtYdzuLICWB0l6qmjv0642U32fJ6sk1F4VW69qSBJcEm+iFjaSPsmumx1fuiULxSOZ951OEP3qffGYt+quCbcjkO4PC8zTkBtCdoLPRzQG/kvYLvPQleMWPpEMA6Gz/1zwsQYTTlNwGsorAWavLW1jIMekTlWf6Ee5uF/zluOHotiINtTPCH+WwG2VA90zZHnlBx8PgkRAuy5rjuStx5vRoN/KVcaIFWOuQBi9J4ZO3MOVsug51OAlpqglvQIh8Jrr/aU8v8qeiKi+cEVtjJBtLekwUDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7mWF40118ds1sm1RT+DFgiPKKZJcvbibyjXLAIKdR8=;
 b=ATq6fuJh4aYaz1483BpeEM26fp9LmJdOeG87fk1yBA0dMf77ts0BoUMOGsIkcz4i7qdQAFCByIKuaAjov1T46L7ayFjXg3NMKWxx7PmCeUxdRxelw7AuomgdabwpNIrss0Xt1sRrev25tQhKGOcJgzjMGtytix3ydZ1Aw7phXBrXxGsbbEs7Mfj2H7cvOEx8lAKmNKBizLSKYAOBFWvoI5l4a99qJFFTahOeMfANpon09xK3YmWH4r9VwWuCds8exLksKxqdGVhhj/Af00P9sOl4jSlz0X4MBPz8QXP4wjU4L26LZp/9znfGMip/L9K4e8G5alhhkIol0hTE/L4LZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Fri, 17 Oct
 2025 09:34:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:34:36 +0000
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
Subject: [PATCH 14/14] selftests/sched_ext: Add test for DL server total_bw consistency
Date: Fri, 17 Oct 2025 11:26:01 +0200
Message-ID: <20251017093214.70029-15-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:180::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d3b9a6-b6dd-4e41-378a-08de0d6062cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HAdbL1qp2nOAC1bZ/bmDa7QAVWr4jj1ATD3OD/wBY7Mm6ZGvl26WPZ5uNBFZ?=
 =?us-ascii?Q?tQQvdZU2ItvH4cil3tTFN6xAXTneayEY79vOrlwRN+0Y7shxtf+MK6UGhLvg?=
 =?us-ascii?Q?4Q2m7hQLlw+Rmhl5Wot8QhYMKRldvdDZb4wGid8nGLOSxjoGA5hgmUXXKzDv?=
 =?us-ascii?Q?aTiLVjZT+AFi8IjMRQ3330OkrJBGSbd7hA6c1hzNThVYgWJxLGTIRkyphhmZ?=
 =?us-ascii?Q?o4PbhY+Q39djw15gAIzjcsaRVSsw9w6LgJF0RcmIYrFw5NOXuhpM1zO73nwC?=
 =?us-ascii?Q?4Uket5c6SsxW9oHzLZ4eFU5JzOuxXkSVR4Tm9Hk75z0FD8W1IAuC2Lq2aVTW?=
 =?us-ascii?Q?NmPTXzO4HcyZlEOYymO607iP5T/uiZikzWKEwYJA5wBLY7z/1Slv0mcBOAJv?=
 =?us-ascii?Q?7I2JPEsFNF/6H0+SDpFIjY8bobi4FcBwV0b7WgoJdSPwGlioSbT3wdIlCJWK?=
 =?us-ascii?Q?ykb/rXTdBYMkQUBkl/CCgp8x6+PiOSnCOsAu71OyfyD0Dsjt5YPx7H+u7akg?=
 =?us-ascii?Q?xbDc+eL9k789fuvqXrwOh6bgMdxuS/lH/2/Jo7ujmwY1CwhTz4NOVmkH7QBm?=
 =?us-ascii?Q?wb5e4vR/h525oP6UPETPv3xa3TcceukKgmc+MGh9IZ+aENNVA3p7GMyfI7hn?=
 =?us-ascii?Q?y+DBr6vvucRqAafmU97eh8Ke9K+juF6vxpkrNhc1U60s+Br2dZlEIFlGzpk3?=
 =?us-ascii?Q?GcPxPXwTxpjKK624vQqNyfPyROTqiguDbdBqb645seH5UmzBH6WaIvGxbFlj?=
 =?us-ascii?Q?glyPr+5XfQhKjIW7TYbxzlbQ+dwDlMRRXoVbIpKQG5AUc726hM90xjkbs1jT?=
 =?us-ascii?Q?jxYDpuzrC8cbot7I3G08CRYO9fgyovX//SwmD6L0CXhX58a5ZnB3oBkEKCKT?=
 =?us-ascii?Q?l6m+uSgPF4IXH4KH4m+neLjvQaDxK2kwNfTl0GPm+U34haP3gqQPZF+UBJSn?=
 =?us-ascii?Q?DttfTs6ny95zxPhuXnNvBfrpiWRrs88SAI/x3wdHDzl94ET12cWn5DSALjTV?=
 =?us-ascii?Q?YcIK0M4iS54ehkKM7DXqg33mvQt1cSbMWq2CRA+WDUK7UHEX84HkoiuYJXnO?=
 =?us-ascii?Q?sjPXsRKHwujDIko3MM4Lmy3T977hcCvJ+IeBcCerwtVT/qjgPYQYLY/i2ucu?=
 =?us-ascii?Q?stMliuWPzybQ0NNo7BzWL//l5Dp6Y/XcG/Uagttoz4ZNvOawdlw6cDGPWViY?=
 =?us-ascii?Q?stIcW/Tj0i8Pi+41pLjptepgEhxRtydEj2nmIjX6Yoh+sGudU3VeGf8C3xa6?=
 =?us-ascii?Q?9fSgXsEnC1uiI+8Vs8KbcSPBunb+B1hBkLTk9+ojaKtQUZC5s2jOzKkhaG+8?=
 =?us-ascii?Q?YOFzR4GBNYGuB5Zm+KMxzRXn9rg3LENQRZesoEI2jhz+PMWU1+bilLOjsuCT?=
 =?us-ascii?Q?Ysnv1Xmna9opAkPwq5w7TGa+3F8zW7mKgZZqNMH72DtVzN+kdURlN07DV8bX?=
 =?us-ascii?Q?7d/D5ck6OFWNUxUyLojJcGT/fLZ/WJ/Jpqv3zmaXbijlZ0vZB2qpKBav/aib?=
 =?us-ascii?Q?Ra8o5ZDW/VhKAjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/bVgysrAUN74abM04Z4+cOnqnjIr5iEN/Pvcnp1xJxBNik3LGfaKt7AHZmSc?=
 =?us-ascii?Q?e+qijeGyCLQrRJa3IBuNstK4JVbPMknycQmMv84W2liwfjX62HGElC2LkXj/?=
 =?us-ascii?Q?JsRqzJaTZA4CATVLaHVxTic2QF7PvMC7w7dSThQ0uJqcuae4BxaerN8tUOLa?=
 =?us-ascii?Q?e9kfLLi0ItBROno3vTiJflOITtYq4MX0SPiw0talrwtd4PMv8pOhbtj69G0G?=
 =?us-ascii?Q?XrbTPLFYyf8YjYdyYkHY+qDhM9tO3iH5sPPE1fKAmYdyeDOmro+BRVfnAOCw?=
 =?us-ascii?Q?7ed1giQBqyucqTph8a4QIZ8hvKJP1RgM26r0cFoZ7RORiO8d0A9Ya5jbZz2r?=
 =?us-ascii?Q?NB621xuM6IlJmz0nOAYRXmbGYGKhCVaiey14v+0pOz/DYPOoEpGz/wYuOL4q?=
 =?us-ascii?Q?hcrTLgB9Pnehl5a/GWOtp/ZS2P+ZSxSRoK1Pbm72dtyxwOcCnFZDwSY0e5+D?=
 =?us-ascii?Q?ELHnNwznIeAKOHatDYFKPnJJVr9y05Oga50OWdmBtO0HHl5N6xUgdB+iNgCF?=
 =?us-ascii?Q?3zWHZqJTJBgC6iB1EL88rwpHuunloCJIrhkCF+30BqVuRkD5TY5MijniQiJ2?=
 =?us-ascii?Q?lKlqIcNMi3P3MEwBBvTDrAATwE6XJXEQCCGrH24Ul4khBaRLjD/KLaRTBVX/?=
 =?us-ascii?Q?FEQ/k6izPE7s8Qi6dxr2KN2SqFKuibWTsS0EQid/XBGOyelOG8n6jFt+N7t8?=
 =?us-ascii?Q?5djIKd0LDl9UITgLIn9BsJRN7+7t/xtQAdZVgF1dVlRufldcuZmXIe4zI9l7?=
 =?us-ascii?Q?bSFwPe5W+qzVb68iwUPR/bXPvVlv8BnHTr7h8fLws9Iqw4iAT77C7QOjlXWj?=
 =?us-ascii?Q?zmpPVAtqXQqbXNm1UKQzybOUlHohSiSINQ8lTIlWRXXO2R4JG9y0HUHphUDh?=
 =?us-ascii?Q?cr+/rwi1b9KDDFlFyYi7k0VXRZg23d/VgJgCkDDdkRndemO3KbpveOPZ3yVM?=
 =?us-ascii?Q?69VUa5yMLozpQg25sH3Ea9yyvECWAsEBJd0kThM2ZebaY8o/Ndf1t0sj5f2d?=
 =?us-ascii?Q?oD8UutnmGcFcMNtCXPATgZvroA+pV6eXDr5ZWlbk7jnFKSMgUy3VoNHekuJu?=
 =?us-ascii?Q?AEweP0VgSeJ2qKrljWDqQdJKLl4lbeSNJRak3qNnkVgPrJxyaZXxtirG6F/K?=
 =?us-ascii?Q?dXK7rRFuWgwaoshfvauBHRF+VzoB+YarlV0JlEijKh+f09ySlzZ05H14Hl44?=
 =?us-ascii?Q?EhJp9oQVDXfid+ygqqkJZc6KIRFbuzGfDwRB9cyT8+8of3v6w/FqKpXZHM+7?=
 =?us-ascii?Q?1alXJCb14AMXEuQdyNFHUCvfGKG4m8kAVYL+KOmX00ekipz2cqmdD62ErFPk?=
 =?us-ascii?Q?yhHqvYbZifHJ7MuMCCy2NO6zdoZ+MR/DXJno3xjLSVWyLVWD/KVaZgbYh6Y/?=
 =?us-ascii?Q?etbVF4feV1b7rRsz+tRWdO/ElhlxKPcmarDc53LW/wNiIiS+3P2dylaTT87T?=
 =?us-ascii?Q?tqqGqlvVZbDNRnKQ7UUSMrTk6uX34stq1yN+1GaHrsX33lhpO32+2nld1GwO?=
 =?us-ascii?Q?4xfzsUBqvcfEJ7qNMlPOzGzYBSEwCRctZkK4zDo3Uv1lFLVPTK/8BOjIQeX7?=
 =?us-ascii?Q?tsbyyBbwFCeUv3o17hNLtt4hux4yh+8QI+sl3Wsg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d3b9a6-b6dd-4e41-378a-08de0d6062cc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:34:36.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLt8vFAs7Xj+QZvfW4wBG3ETAdRNiSl4KeyzRYuXasWTUxOfR2LJlIeBrzwoMihnebF+iPMsc8BcTxK9EduTxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317

From: Joel Fernandes <joelagnelf@nvidia.com>

Add a new kselftest to verify that the total_bw value in
/sys/kernel/debug/sched/debug remains consistent across all CPUs
under different sched_ext BPF program states:

1. Before a BPF scheduler is loaded
2. While a BPF scheduler is loaded and active
3. After a BPF scheduler is unloaded

The test runs CPU stress threads to ensure DL server bandwidth
values stabilize before checking consistency. This helps catch
potential issues with DL server bandwidth accounting during
sched_ext transitions.

[ arighi: small coding style fixes ]

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile   |   1 +
 tools/testing/selftests/sched_ext/total_bw.c | 281 +++++++++++++++++++
 2 files changed, 282 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index c9255d1499b6e..2c601a7eaff5f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -185,6 +185,7 @@ auto-test-targets :=			\
 	select_cpu_vtime		\
 	rt_stall			\
 	test_example			\
+	total_bw			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
diff --git a/tools/testing/selftests/sched_ext/total_bw.c b/tools/testing/selftests/sched_ext/total_bw.c
new file mode 100644
index 0000000000000..740c90a6ceab8
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/total_bw.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test to verify that total_bw value remains consistent across all CPUs
+ * in different BPF program states.
+ *
+ * Copyright (C) 2025 Nvidia Corporation.
+ */
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <pthread.h>
+#include <scx/common.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "minimal.bpf.skel.h"
+#include "scx_test.h"
+
+#define MAX_CPUS 512
+#define STRESS_DURATION_SEC 5
+
+struct total_bw_ctx {
+	struct minimal *skel;
+	long baseline_bw[MAX_CPUS];
+	int nr_cpus;
+};
+
+static void *cpu_stress_thread(void *arg)
+{
+	volatile int i;
+	time_t end_time = time(NULL) + STRESS_DURATION_SEC;
+
+	while (time(NULL) < end_time)
+		for (i = 0; i < 1000000; i++)
+			;
+
+	return NULL;
+}
+
+/*
+ * The first enqueue on a CPU causes the DL server to start, for that
+ * reason run stressor threads in the hopes it schedules on all CPUs.
+ */
+static int run_cpu_stress(int nr_cpus)
+{
+	pthread_t *threads;
+	int i, ret = 0;
+
+	threads = calloc(nr_cpus, sizeof(pthread_t));
+	if (!threads)
+		return -ENOMEM;
+
+	/* Create threads to run on each CPU */
+	for (i = 0; i < nr_cpus; i++) {
+		if (pthread_create(&threads[i], NULL, cpu_stress_thread, NULL)) {
+			ret = -errno;
+			fprintf(stderr, "Failed to create thread %d: %s\n", i, strerror(-ret));
+			break;
+		}
+	}
+
+	/* Wait for all threads to complete */
+	for (i = 0; i < nr_cpus; i++) {
+		if (threads[i])
+			pthread_join(threads[i], NULL);
+	}
+
+	free(threads);
+	return ret;
+}
+
+static int read_total_bw_values(long *bw_values, int max_cpus)
+{
+	FILE *fp;
+	char line[256];
+	int cpu_count = 0;
+
+	fp = fopen("/sys/kernel/debug/sched/debug", "r");
+	if (!fp) {
+		SCX_ERR("Failed to open debug file");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		char *bw_str = strstr(line, "total_bw");
+
+		if (bw_str) {
+			bw_str = strchr(bw_str, ':');
+			if (bw_str) {
+				/* Only store up to max_cpus values */
+				if (cpu_count < max_cpus)
+					bw_values[cpu_count] = atol(bw_str + 1);
+				cpu_count++;
+			}
+		}
+	}
+
+	fclose(fp);
+	return cpu_count;
+}
+
+static bool verify_total_bw_consistency(long *bw_values, int count)
+{
+	int i;
+	long first_value;
+
+	if (count <= 0)
+		return false;
+
+	first_value = bw_values[0];
+
+	for (i = 1; i < count; i++) {
+		if (bw_values[i] != first_value) {
+			SCX_ERR("Inconsistent total_bw: CPU0=%ld, CPU%d=%ld",
+				first_value, i, bw_values[i]);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static int fetch_verify_total_bw(long *bw_values, int nr_cpus)
+{
+	int attempts = 0;
+	int max_attempts = 10;
+	int count;
+
+	/*
+	 * The first enqueue on a CPU causes the DL server to start, for that
+	 * reason run stressor threads in the hopes it schedules on all CPUs.
+	 */
+	if (run_cpu_stress(nr_cpus) < 0) {
+		SCX_ERR("Failed to run CPU stress");
+		return -1;
+	}
+
+	/* Try multiple times to get stable values */
+	while (attempts < max_attempts) {
+		count = read_total_bw_values(bw_values, nr_cpus);
+		fprintf(stderr, "Read %d total_bw values (testing %d CPUs)\n", count, nr_cpus);
+		/* If system has more CPUs than we're testing, that's OK */
+		if (count < nr_cpus) {
+			SCX_ERR("Expected at least %d CPUs, got %d", nr_cpus, count);
+			attempts++;
+			sleep(1);
+			continue;
+		}
+
+		/* Only verify the CPUs we're testing */
+		if (verify_total_bw_consistency(bw_values, nr_cpus)) {
+			fprintf(stderr, "Values are consistent: %ld\n", bw_values[0]);
+			return 0;
+		}
+
+		attempts++;
+		sleep(1);
+	}
+
+	return -1;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct total_bw_ctx *test_ctx;
+
+	if (access("/sys/kernel/debug/sched/debug", R_OK) != 0) {
+		fprintf(stderr, "Skipping test: debugfs sched/debug not accessible\n");
+		return SCX_TEST_SKIP;
+	}
+
+	test_ctx = calloc(1, sizeof(*test_ctx));
+	if (!test_ctx)
+		return SCX_TEST_FAIL;
+
+	test_ctx->nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (test_ctx->nr_cpus <= 0) {
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* If system has more CPUs than MAX_CPUS, just test the first MAX_CPUS */
+	if (test_ctx->nr_cpus > MAX_CPUS)
+		test_ctx->nr_cpus = MAX_CPUS;
+
+	/* Test scenario 1: BPF program not loaded */
+	/* Read and verify baseline total_bw before loading BPF program */
+	fprintf(stderr, "BPF prog initially not loaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(test_ctx->baseline_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable baseline values");
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load the BPF skeleton */
+	test_ctx->skel = minimal__open();
+	if (!test_ctx->skel) {
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	SCX_ENUM_INIT(test_ctx->skel);
+	if (minimal__load(test_ctx->skel)) {
+		minimal__destroy(test_ctx->skel);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	*ctx = test_ctx;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct total_bw_ctx *test_ctx = ctx;
+	struct bpf_link *link;
+	long loaded_bw[MAX_CPUS];
+	long unloaded_bw[MAX_CPUS];
+	int i;
+
+	/* Test scenario 2: BPF program loaded */
+	link = bpf_map__attach_struct_ops(test_ctx->skel->maps.minimal_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	fprintf(stderr, "BPF program loaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(loaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values with BPF loaded");
+		bpf_link__destroy(link);
+		return SCX_TEST_FAIL;
+	}
+	bpf_link__destroy(link);
+
+	/* Test scenario 3: BPF program unloaded */
+	fprintf(stderr, "BPF program unloaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(unloaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values after BPF unload");
+		return SCX_TEST_FAIL;
+	}
+
+	/* Verify all three scenarios have the same total_bw values */
+	for (i = 0; i < test_ctx->nr_cpus; i++) {
+		if (test_ctx->baseline_bw[i] != loaded_bw[i]) {
+			SCX_ERR("CPU%d: baseline_bw=%ld != loaded_bw=%ld",
+				i, test_ctx->baseline_bw[i], loaded_bw[i]);
+			return SCX_TEST_FAIL;
+		}
+
+		if (test_ctx->baseline_bw[i] != unloaded_bw[i]) {
+			SCX_ERR("CPU%d: baseline_bw=%ld != unloaded_bw=%ld",
+				i, test_ctx->baseline_bw[i], unloaded_bw[i]);
+			return SCX_TEST_FAIL;
+		}
+	}
+
+	fprintf(stderr, "All total_bw values are consistent across all scenarios\n");
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct total_bw_ctx *test_ctx = ctx;
+
+	if (test_ctx) {
+		if (test_ctx->skel)
+			minimal__destroy(test_ctx->skel);
+		free(test_ctx);
+	}
+}
+
+struct scx_test total_bw = {
+	.name = "total_bw",
+	.description = "Verify total_bw consistency across BPF program states",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&total_bw)
-- 
2.51.0


