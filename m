Return-Path: <bpf+bounces-71195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355A9BE7D45
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2424D189A2FF
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AD0313539;
	Fri, 17 Oct 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SsOxLj5v"
X-Original-To: bpf@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAD2D63EF;
	Fri, 17 Oct 2025 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693675; cv=fail; b=sueNkIfDXecppg0ZP9p7xvzN9iN19FbH5jtRiipDu/5zKTM4JoKduRnqEMaJJDdgzHhmG5iVkeRNLMUXKbPm0WW9K+8uJNIktTrFwjYExl3Wryyk4h5fH6Am1AL1IX5R3kdzHs/b6mXlJlTKOlxSGjPgItmFtliv4nINUFenOzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693675; c=relaxed/simple;
	bh=T6pqArtkWI5W7o8d0q2S+5Aa6lGjzeY4nVJaEXsDKIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oqICqjDC8cbsV5OIc3iiQIuffg0QfctAjY+394nIMTfmGVheld0WqUEIo7UBb8ZZbmEs9A2fiqYNlfKCnExJmVTVn5iurMVZ4xAItJ0q8kUrEvKnnQ0HrSaVGgT9CIQHLXlMXngtnxWT6c5iJeZNOgmaFwDyFifQo3cz0mFzNzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SsOxLj5v; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKFZY5dC+Tw7hcamTy6GYOO85F0o1+6XN+u+KUhLVbDj3Z0maZvC+ZoOpngywhAx4lv3XDERUXefKAfoGTAq/w140gkWp3nyMARpWndU6ZnMOM5y/fzVeiOOSMoNoNX30v/NYiJWLG/leO/4OTBsK4exCV6VbaEEgQp++RnKwAPBNhT4lhjSIhTVvOOIZ1cn+CJ6uc7YDIs882CJgjmuh+XYOPceR1uNmYdglUWz4BW7wIhEWUj172u7hAJ36yCpUYgxxExkniTOY0xfjTJssJRpznMzl/pLhvm/KAaXGAP3Bi1Vuu3W9My1aHCAZVHDfGdyOevsAAWsYYmU7UQzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqRvDZt7+gJkoa7q8PoeenUURUvg8ZYbtFMr8tvuQYY=;
 b=vMTtB+VJXhrVNI3XTHBA4tScEvkAVrsSgg5oyT0GniWoJAY5Lglbe+XBz+VtrXZaXtx7Cw6a2zMRjzVjQFK8czs0zEDoMzEtSepA4JEg1KLKOfmxExE6I6oaFPuu17thbrN3iv+o8qgR6mz1pn+CdemJKV8vHmBJIP34xrq6/+WaXqsEAN6m6DsI0K9H+eufdBRmo3Y3ckir7fT/SdxBqtHFDHRI27ed5747nR+DhWD/3h2BjUZJHyw2eA1AFkYKnEhv61XbeeSXYPw3aF//c/tFbssMbQUITYq3FKzhH+JFaPZSdygSYA4z1IDIaJPJYlq471dsWGmCNimxP72f+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqRvDZt7+gJkoa7q8PoeenUURUvg8ZYbtFMr8tvuQYY=;
 b=SsOxLj5vSe8TppeVgubJnDicH1soRYLJZGZVl+HiNX+N0+aSl9Vww6EAotLvQv+lnZzF+AsmZLOAcTrmEd2/RyubG8eQJi7u+5frjNIEnkSVzmJGdmlQJ121sX9M5j6qi6DzVJ9zQbwnXrNu2TfnKAFy9RjdjgWpzUs2OexHpG0DBNQXtsBj0tfPzWI7MOsjhxfkXfyXnugOu5mvUQg2VIYDjMdtP1/a6xrcJiy0MUKbU933zrbBeoN4UtZRgyJDZYqN7xRdMWd1H495YrrEK2MrcIJiHPMuOY/9LihrScVGfwh8+z742/rCZ6f00LY68I8uCA2th6aHo1umVAU2bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:34:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:34:30 +0000
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
Subject: [PATCH 13/14] selftests/sched_ext: Add test for sched_ext dl_server
Date: Fri, 17 Oct 2025 11:26:00 +0200
Message-ID: <20251017093214.70029-14-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: be190654-9b32-4f16-6d8e-08de0d605f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yYFiAQCE2K8TX0Ar4HHyn+suDeiQ50SW8I3TFN7zFHCGS0Ojxez8BummTtoW?=
 =?us-ascii?Q?L6jvDVApGFj/Rk4XxeD9xJjjHZnYMTyaxyseB67A1tha34RtULLoZpnKbvjp?=
 =?us-ascii?Q?HmWSVKenY5mLk9J3GlUAVZR4OQjkvOSnt9/824F1iOMzE2C8xHrinAfZjXUw?=
 =?us-ascii?Q?eq+YYukc3qGcDycwDqYpr5/8JULRQc/oBzaIFBvjDFdLhY+y322ax1CtLcEG?=
 =?us-ascii?Q?s0Rk4dON/Zb6ul7rg7wwCpDZy7EasKWtCeI62I1w8cXafyggdDomLlxGH4TC?=
 =?us-ascii?Q?7yFw8EZ80wVyYmy8Tnc/yUzon/gQrYs4RfEJEDKqG8ttI38fnQ3/GeYTBlEK?=
 =?us-ascii?Q?9lRvbLg6mRquweaeGG4vvJIB4vrckJ4bJWwZCoORQKKMLoUIj89WFr2h+SNN?=
 =?us-ascii?Q?oZOAuzanEnFvsg9GU5E4XWjE3LmzUfmL6j31eiPVQCEQHiCcDaV6gQU7UL47?=
 =?us-ascii?Q?XUIFFe5w0/PUyhl8N/6BULnbHH2tL98pbzkndKlb3VzEXCeQxyfA63Q9TpV5?=
 =?us-ascii?Q?y87orex8ok3CyEvU6R6cqmTwV8l5NA8NYSlXkMnxKlzXgxjcbDfjl3x3tWky?=
 =?us-ascii?Q?Z3xJHlp+DK2li/u1LUHI7Vb4l37Up+NFSTx8ju8kYWbBGHbszzIr7koIevkB?=
 =?us-ascii?Q?AvLGS65WqhNO5JX//mao5ue64MkMKJPBSKSdHkZ1cqlC4UBJDq/s2xvNxoSa?=
 =?us-ascii?Q?c51MMXrbO36DP5fTlMUqGfrP1w9sgt0XVMUaJN/7xCYrG/2Bno8Kp+tXJv6t?=
 =?us-ascii?Q?yyEsexgmsFj5MgY0k/YAUoJu0GTLCQNZ+jkvRlSXb4GLmgB34Qlxvr7l2zmD?=
 =?us-ascii?Q?mMy+yk3YMY0ELpa+wPHG4Dc5YgSEIuezs5JRDCBlgQyCIVPrW9vmDPXOQs39?=
 =?us-ascii?Q?dScahqBrs1E1im6yNfoPax1D3wgMhuZ9awfmDmDMrvdrT9u6FFKJ9vEyt0uO?=
 =?us-ascii?Q?SaqbTUn75kdxSJrfXczK5k8wLTSyh/MD5ys+hXO9rvL7CGnocNKx49Et2XFj?=
 =?us-ascii?Q?leArWGm1m8yKfhtNLZ4sx/UKgwiQela20RkmFjel3OSkzJgzLifdNrNTjunN?=
 =?us-ascii?Q?vlhTPY80nDlb52kD4Ts86hLngWDNUY+LYpK8AqQ60s5N8Ho6MpbWZVAC3nnN?=
 =?us-ascii?Q?hbfCkzZpZCnXLQ+U0qt1F8RYYKiymGfs4FrKFR1E1HgX9wjcFM79omrCpa5g?=
 =?us-ascii?Q?h566DP2ANqG+jn5eLF58G4PHJ5z1j3HwUBX98467s9TFS/dkIFG+q/Ob+eeL?=
 =?us-ascii?Q?mjZFCRnXHTfcfF3oX3GEM4yvhqnNAcvDTugrVhchXqyO6kjUHqkWwjzPCXxV?=
 =?us-ascii?Q?Uy2k+/ZekZkpXMMrKpRekXA3QTA8I5NQ184v0lTCvGUkNlqXrc7Hpv7bf2qH?=
 =?us-ascii?Q?ac+mD0DEMWreOCd5rQY4eisqyP5C+KAF1MeDSXhW44O2R9Sw/B5xt4Pspd4+?=
 =?us-ascii?Q?HF8/aJeLqbLFYSl762poriRjuiV9XSv+buvhhDiO07UXlEiMFmkyONu0ELBi?=
 =?us-ascii?Q?zlWUDMTzJdu07uY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8lxMDawrM94cIYaIvuTmFV/mc7HbfnKtspPmNPzzJBPvYuZ5Y5XtfkYLB3lE?=
 =?us-ascii?Q?U/IXOCaoQcYbcbS5NN/u9CQNguRSBeVtoNg+ms9KnLlQOsvM1Zjl4BBnrpto?=
 =?us-ascii?Q?d8l31GLJjvJ0eg8rmPJE8vmsQR59txQPOaPqDRKOvI7ztxlCxinU+nIKn2rB?=
 =?us-ascii?Q?ztcr6xHElU/caWvAddQ6qDdUWNvn28teWZ9FRYrvDdTLUekiPJwLAPJQWJ0d?=
 =?us-ascii?Q?/SYFrGzJeUWwuPsotDpcHsQJ2a+MbYhhr188haCKw0QtN3b9fgfVM6GfbtAv?=
 =?us-ascii?Q?ekV8nEN3BbcrNN6JSLHDNjv3goq+l4g5prkS7c6GCRGZ8Yv9yRO3kBZQ8eCZ?=
 =?us-ascii?Q?+nuIT5xCU46r95HGypa0jxsfmAgBfBVQphrMTAi1g8nhPqJNbMrVYf2MTWTo?=
 =?us-ascii?Q?dIhf9Nszctrj4TuW519nL/1VzoXOGVpux39/7P870EFG00fqH2JEVQ91+KtI?=
 =?us-ascii?Q?myYqElTYRFQxoawH2AAXHY6mDeV+SZIX7uMnObeZvoQgrsEsFguJmm3Ryjk0?=
 =?us-ascii?Q?gvQSTzDPLXJustO4kIP7Dp6cDKFp+jwZDTzFqljARY4HFK9HH/odgXMLqW3Z?=
 =?us-ascii?Q?rXP/sFkhQ6yZyvtM3A2+gkviRSsSTCU5AuSLTt4Ae9cDAHUq/Z2Gku89y8Mp?=
 =?us-ascii?Q?eM/HnXP5AAW6KKoKV/0zB3QfcMmCHmtOKaRjzuZ6Duwx4gVGzMxdK+6qEae/?=
 =?us-ascii?Q?1i12UlfEW/+zwNwEyx+65+PdwL5yIcppmR3eiYrC3G+v8bu5cFLi5ZU2+fxx?=
 =?us-ascii?Q?r8hmi06mdivcDlhfRnwCPsp4ZnPEckutaRSFhnuU9QnqtQZNAngFsFtCz/XH?=
 =?us-ascii?Q?o9X02fndQDD8JES2XzMz+5jyaZyZmgF6IyCYLVsIVy0ktpsMj+cdaYrTy+Ed?=
 =?us-ascii?Q?qAICz/fSbChqKTsJSvZLMKp4F8rDbKF5i+rCNSL/PG9S4TYqKa40vvpyFNY7?=
 =?us-ascii?Q?UMJZACkJHOC91kpe+TL7w+syKfg6PCEX46g4V9pZxmgmwqrjM4YFRmoRc3cv?=
 =?us-ascii?Q?CNNBzCzN+t8/FAjibmbi8UeazwZ5SUIUzw8Nr+5v9I/t1rKg2p5/v6KyTTg+?=
 =?us-ascii?Q?xihGqb81D9qGc/wmFN1Fww8ZRc2D6DjSIezCeFMXepTQnSnx3P6sPlIgsKpl?=
 =?us-ascii?Q?1bnzjA/eg+GY4+M2QTz5LwlKsCX/d4+H/h2xp0PZuek6l0VJTEKo2SnzqAQU?=
 =?us-ascii?Q?l1cguRi0Jn0/VzkAvu2WGThGSvkLKkoHPRsMOLbK+PGg8E5xqClI4RfjmRYq?=
 =?us-ascii?Q?QRkRJdpgr5BZ011hbH7Nm+3WMr24ETc3ADdWKGtGJzJMg4oGDapiaTKnHK+U?=
 =?us-ascii?Q?22InIfx5GQkEgpBW6JFt1FAOt4wjuo42TgHl4+8AqWNNAEmhgkU9GrepVpCt?=
 =?us-ascii?Q?lVfbepq7fe7mP3KLadM3tANSzXKuT7REU+UmGfy1VaZPkvfR/Wna0gBxkHFA?=
 =?us-ascii?Q?6CZlv1tMpQ0dpp0a5NmfcE5nZ2ZJ8jjG8Sk+Rj6x6AwUTXVfo8xkOEtjlx9n?=
 =?us-ascii?Q?1feEdCIPnzD9SylLGUn58lRUpfDNZBjLVasdtsvCLDM2SZaXoWRi0TdCpjkl?=
 =?us-ascii?Q?VYMrY3JWRW0j+dbmdO6Rb+npAP2SmZenI3YJxv8X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be190654-9b32-4f16-6d8e-08de0d605f4f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:34:30.2480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WE4zy4pEr57Io/dQovmP5qIkHmttPlIemjmIKhg90xbLgRWnKe81JGsC4EvlS8d2oEw1zDTUSjUqlBjuZvWNWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

Add a selftest to validate the correct behavior of the deadline server
for the ext_sched_class.

[ Joel: Replaced occurences of CFS in the test with EXT. ]

Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 214 ++++++++++++++++++
 3 files changed, 238 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5fe45f9c5f8fd..c9255d1499b6e 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -183,6 +183,7 @@ auto-test-targets :=			\
 	select_cpu_dispatch_bad_dsq	\
 	select_cpu_dispatch_dbl_dsp	\
 	select_cpu_vtime		\
+	rt_stall			\
 	test_example			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
new file mode 100644
index 0000000000000..80086779dd1eb
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
+ *
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops rt_stall_ops = {
+	.exit			= (void *)rt_stall_exit,
+	.name			= "rt_stall",
+};
diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
new file mode 100644
index 0000000000000..e9a0def9ee323
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <linux/sched.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "rt_stall.bpf.skel.h"
+#include "scx_test.h"
+#include "../kselftest.h"
+
+#define CORE_ID		0	/* CPU to pin tasks to */
+#define RUN_TIME        5	/* How long to run the test in seconds */
+
+/* Simple busy-wait function for test tasks */
+static void process_func(void)
+{
+	while (1) {
+		/* Busy wait */
+		for (volatile unsigned long i = 0; i < 10000000UL; i++)
+			;
+	}
+}
+
+/* Set CPU affinity to a specific core */
+static void set_affinity(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	if (sched_setaffinity(0, sizeof(mask), &mask) != 0) {
+		perror("sched_setaffinity");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Set task scheduling policy and priority */
+static void set_sched(int policy, int priority)
+{
+	struct sched_param param;
+
+	param.sched_priority = priority;
+	if (sched_setscheduler(0, policy, &param) != 0) {
+		perror("sched_setscheduler");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Get process runtime from /proc/<pid>/stat */
+static float get_process_runtime(int pid)
+{
+	char path[256];
+	FILE *file;
+	long utime, stime;
+	int fields;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	file = fopen(path, "r");
+	if (file == NULL) {
+		perror("Failed to open stat file");
+		return -1;
+	}
+
+	/* Skip the first 13 fields and read the 14th and 15th */
+	fields = fscanf(file,
+			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
+			&utime, &stime);
+	fclose(file);
+
+	if (fields != 2) {
+		fprintf(stderr, "Failed to read stat file\n");
+		return -1;
+	}
+
+	/* Calculate the total time spent in the process */
+	long total_time = utime + stime;
+	long ticks_per_second = sysconf(_SC_CLK_TCK);
+	float runtime_seconds = total_time * 1.0 / ticks_per_second;
+
+	return runtime_seconds;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct rt_stall *skel;
+
+	skel = rt_stall__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static bool sched_stress_test(void)
+{
+	float cfs_runtime, rt_runtime, actual_ratio;
+	int cfs_pid, rt_pid;
+	float expected_min_ratio = 0.04; /* 4% */
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	/* Create and set up a EXT task */
+	cfs_pid = fork();
+	if (cfs_pid == 0) {
+		set_affinity(CORE_ID);
+		process_func();
+		exit(0);
+	} else if (cfs_pid < 0) {
+		perror("fork for EXT task");
+		ksft_exit_fail();
+	}
+
+	/* Create an RT task */
+	rt_pid = fork();
+	if (rt_pid == 0) {
+		set_affinity(CORE_ID);
+		set_sched(SCHED_FIFO, 50);
+		process_func();
+		exit(0);
+	} else if (rt_pid < 0) {
+		perror("fork for RT task");
+		ksft_exit_fail();
+	}
+
+	/* Let the processes run for the specified time */
+	sleep(RUN_TIME);
+
+	/* Get runtime for the EXT task */
+	cfs_runtime = get_process_runtime(cfs_pid);
+	if (cfs_runtime != -1)
+		ksft_print_msg("Runtime of EXT task (PID %d) is %f seconds\n",
+			       cfs_pid, cfs_runtime);
+	else
+		ksft_exit_fail_msg("Error getting runtime for EXT task (PID %d)\n", cfs_pid);
+
+	/* Get runtime for the RT task */
+	rt_runtime = get_process_runtime(rt_pid);
+	if (rt_runtime != -1)
+		ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_runtime);
+	else
+		ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
+
+	/* Kill the processes */
+	kill(cfs_pid, SIGKILL);
+	kill(rt_pid, SIGKILL);
+	waitpid(cfs_pid, NULL, 0);
+	waitpid(rt_pid, NULL, 0);
+
+	/* Verify that the scx task got enough runtime */
+	actual_ratio = cfs_runtime / (cfs_runtime + rt_runtime);
+	ksft_print_msg("EXT task got %.2f%% of total runtime\n", actual_ratio * 100);
+
+	if (actual_ratio >= expected_min_ratio) {
+		ksft_test_result_pass("PASS: EXT task got more than %.2f%% of runtime\n",
+				      expected_min_ratio * 100);
+		return true;
+	}
+	ksft_test_result_fail("FAIL: EXT task got less than %.2f%% of runtime\n",
+			      expected_min_ratio * 100);
+	return false;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+	struct bpf_link *link;
+	bool res;
+
+	link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	res = sched_stress_test();
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	bpf_link__destroy(link);
+
+	if (!res)
+		ksft_exit_fail();
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+
+	rt_stall__destroy(skel);
+}
+
+struct scx_test rt_stall = {
+	.name = "rt_stall",
+	.description = "Verify that RT tasks cannot stall SCHED_EXT tasks",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&rt_stall)
-- 
2.51.0


