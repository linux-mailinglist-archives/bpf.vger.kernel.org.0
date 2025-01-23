Return-Path: <bpf+bounces-49575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB10A1A489
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 13:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEB5188B07B
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2828320E707;
	Thu, 23 Jan 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g3w6vqrM"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F191C5F33;
	Thu, 23 Jan 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737636375; cv=fail; b=LSdcbaO3R486OIYVN82D1AoD29gsH3U14UxovHCbgC0Afif+gd0bieDFjdyO/vMiMtrL4n/gcAAEZS2EbWwHg2bXwE1w363y4R/R6n118fg7f7hl99YNhtVojhl5bGNq2FG01W5uDHzuMHaKM1qIw8E8E4Zpyme1D/14q555fyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737636375; c=relaxed/simple;
	bh=1m3ht3OTt78cohEpel3o5P48e3uWbJ/1smakXia4sBY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p67kAuoe6pGwz9m2gPjhGKK4ke1QEFLUInAs86k8aN2F8iTlg2UkrbpDI4GKqlhvgP8fJPm5kfagKzzB+ty40xNOQdM1cwl8nhjWGJLXwCUYoQdBRVk1LDXFPWgRvrZ3E4MVmID10ev7Qh8+tAgei31UXYNcxHQRxnsNmCId+I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g3w6vqrM; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2HGBYKvrGQJNC0Pp8ESNdga51PWgxQL1x9QIA7askb5ecfopUYGP9t/MQN2UbT2Nz39APVLR2AKluwNu2dP8P54X+KIEPAHP3Qbv1xVy635lPRzbIc0fiwVGphtX12QUlsiGoZ0RirJw+2JK899FePOubdv87qhutJ76XZeyLMhJYsVPnAphGuwOQqE7IdFj2iO7RJjB/17WjqjbN1GfUjsM3iAZV4GQlfmzDI3pZDYlbmth/gpfcM8Rq9C37ruxUe8Jea7EQfw0dk/L+FBatRUkqveorr5MgdSZeQCbW05bCAY0ofZcqWt43Tf8G9wkhSRXIJJNZ0Zxygn4GRHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTDswFvSH1Pc4jxdp0H4nlT5mTIuSlzCFVLIsyXTnkg=;
 b=kYrB4U789hiPScfSZmKzCDPt26ATGNxs4oNQYFLI0Jc9Xy7SjbhMkEYxaQLdFRXq2VEJqALizM+F6YdDC/mglXGr9H3HDKAsd5ll8FP2PAjWex9FQIu+XEOac+vTXw6dEkZJZbpQ9thGqJ7w1Zs027pbJ3tlxh5107f7XHi9Qn1m81vbjfGcKIp2HMVWtlvjnQF9i43xIqZrkMNpTekgWiXPD++0YimFISLvRUIUtyAM/GM9yDY7UUh0QICJgMI09hvh9ZUCtC2LD1YQYG8nhioSY6lHACqtn7zjxCJsdRBChWq5b+2CsrabHRtObgbJU8ImQIk6TzvvPg34KOXHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTDswFvSH1Pc4jxdp0H4nlT5mTIuSlzCFVLIsyXTnkg=;
 b=g3w6vqrM6J3Gs0IWCYUQBH40bQwTbfZOQgDSx5rXwNKcUuQOzIYu4oKtVCxUnZeMg5rDhKY2tj0gBjcrULF2mgUUNhAtSap1B/ITOdE2Ui5xiVe7qCfNMorJU7cn97FvuZXgIoQV4UKPUch/3q3aOrK6FxzSQ78VRKbvWbmFbtopkWtf48UCLSStyBlC+smzu8BoVphC7j+HodrVoShN7BJV5iRJxNaCnXgkAOnTDF+aAU31CXHKksaP/jd9iqBMFn6NIcHF3/GpA1SZkX8yuyFKTnBABeyU9lTb+hccOYHJyEhwkh7FVxS/9IWOeihOTx7cn9f/Q4yby9bqwHplrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 12:46:10 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 12:46:10 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.14] selftests/sched_ext: Fix enum resolution
Date: Thu, 23 Jan 2025 13:46:06 +0100
Message-ID: <20250123124606.242115-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: a4545811-14b1-4a2d-67ca-08dd3babe9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z+/jvbimq5vW4JcxwX3r6tocSh4oN0tLl+8LVtFTQWVJi/glnKV3Y1e6mPWp?=
 =?us-ascii?Q?fRZYpBq3TBQ5SwoMXf1mbTpID3U9dpnZkK/K3ObnnSGLGMAfrR1LmMe+yGlU?=
 =?us-ascii?Q?kHOkMQ3OKz/JifFq9INL76cofNExOVhecA3lcVTLarenqOnOsnU62lFeUcCE?=
 =?us-ascii?Q?9U3UmwT8d2NdxA7yff5/Ewyh1SwmK/oRbeu+jO9HfSWmlhzml8EiEIdF7mNv?=
 =?us-ascii?Q?4U37FFCxdLepBSEEZ3utH5ngDEuiO4S76HjG1bYmp9puLcGrtxHRuz3iFYUJ?=
 =?us-ascii?Q?Kj0hvbObyztYDJRcsCSGk4g7+s9uQDhRpgjSWA2fObJ5h77Wf2cgCVSVZREX?=
 =?us-ascii?Q?H61QRziS0GY/3Vtqu6sZA2Xoa8h8X1B1/vUdVwGG5vUNM+t98xMI4b7rZlbz?=
 =?us-ascii?Q?JgYlkvCTARK24R9bKdHpU2YJ4ml86sjH/h7v0BBKJ3I4e0s5l5AtFrlaTFcA?=
 =?us-ascii?Q?ygCwGuhkxe58DuQCK+krrRvsswM473sO0mUCrGvZKAGbvDzCusxPbc+apkkP?=
 =?us-ascii?Q?2xZN/HBiZpa1pYx/sfk6qzYf77URcvMkwp7i1fRg/UhPL4dUHKX5Gr1ZiXLq?=
 =?us-ascii?Q?ZYRahzA2LhHFHRvBoR6qCZbXKcp1UpJGQBFHwAgbhl9D2VePCDMl3w3sCYKN?=
 =?us-ascii?Q?5+F8tcq8PwDkhaJvaKpX7N6ZM+pU/XxF7+BgYHxikWWvEsnAQLwfxgTjQDbA?=
 =?us-ascii?Q?rCjI8v9uaz1/eB1UdZAgBM1OnUaiSKhjomI83dXZSQP69CcRzTnyGc9v8f6f?=
 =?us-ascii?Q?CM7ppshBcB1AOrlXlb3xhNsDUZGDYIzIbpD8MUWb/JBmoKtlMT2NnazzMjt4?=
 =?us-ascii?Q?ORTCJ1lnDLREpx0/rfe4vS+JKvIJt90bKi6QedbG2u2npmw2KIrNP8ESN8Si?=
 =?us-ascii?Q?o+KRooT5x5PKJcyjT+RkjsO1okbX+8FeFk0MasQULkgwTx8OCko2pafcT29g?=
 =?us-ascii?Q?KOuyCb3y1BfM9InnGUr2VNqzR27nfl6Fv50GN67I6kHi4ccxnVGhXhciJEPN?=
 =?us-ascii?Q?sjffjtGJajnCan4XSOj265rRcdbTL2lN8Z7QXKZyKLWDQyiDxaOtk5KKS1t4?=
 =?us-ascii?Q?4lTb1RzHLVqAbuFAII+rJNO/C7J/iTKO93N7qfPeh/YGmu9GqXJZEbIET+c6?=
 =?us-ascii?Q?KH8hnwlb0FJOSLQgyOkcISMNR3Y+FUH4jQjiPXM8D0TOXEFIOQPO3cVfpDeH?=
 =?us-ascii?Q?lukh4C11DtvoOBukIsJofKWHlNYTyWJTNdrNUJVe+PepMABBSyIS58GJj/Bl?=
 =?us-ascii?Q?3XssWr5YyreavkDSYoizinARfqxZBr3Ivh8Oo1ziaovd+pBIx4YZiHtzC2QL?=
 =?us-ascii?Q?Y36FI3giaxdBd78suWyjcc9xVOyP9GAXWK0Om8loSBbFgqolc88wBJ6Lc7Yn?=
 =?us-ascii?Q?oHQK9o2hnFcEDXJGFlK6PjDGp6lt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gQpstTBhZAvSXeu2cLgNuBXbCCbBKX6n4VGEGIPftgR8kICZde/kjCvtmoPF?=
 =?us-ascii?Q?Whcu96oWQpwMvqBKWClZ4CxXTg+bvrV2qi7bDQLKw0Vr8fytHKryG9rQ6ntG?=
 =?us-ascii?Q?mCsylwKxadRREgUNp8EryKk5qFlBiGWexK7BLPkwa0G8rO0tjH2VAjtBdebO?=
 =?us-ascii?Q?5fRQe/lnMnSd/xDA4EDlXLr3r67mDy1t5MhJ4v/OOFv01JvAVTxXVa1Z8E0+?=
 =?us-ascii?Q?AfebwqEn6l0thJqog3948eadfXotsUDoJ9xxuCqRL0FDoOje+hbWH6cIAgo3?=
 =?us-ascii?Q?yKEVUNKIa7yls1Yn31xASaD3JKEvG7eWgyK5LwmtO5kVDV7+DkIpNbcYFqJa?=
 =?us-ascii?Q?8olarrcdDIq3EHH5YGdWHnN5gWV9WwTnlvNjP8cY1lgMIzQ2NdSObNpbE3bg?=
 =?us-ascii?Q?LDw0A1loehvsyssLIWS3OE2L/f1S2yeSavLi8Tw+1QiKaOl2gM3NIiWmUQoC?=
 =?us-ascii?Q?BiOtlFX6Kx7/AJr1eUDX+ZXQ81T00x6DwGFOJZQXRHcEPrZ+dg99IROLVtcA?=
 =?us-ascii?Q?jowCXi9GvgiLH40CJq0wdJj5TiGrMXZXTwum5jNxFc7eo6CUN7qShaBUFWrG?=
 =?us-ascii?Q?WdxghWyk2I9Y+RpuTnis7vuq2QXBvusiSLAz49Zo0rKU9PxtTQsP4QFw7gxt?=
 =?us-ascii?Q?HqXZF2JK17NikSAmJS8ZH0jmP/gP4yHbu+QqK7d+EvzMn6K0DOJ7RiImgqju?=
 =?us-ascii?Q?nDAVVyiSpzV55SxbCjdGMHL7ibUlVwxyf3Gs4FulSYhIx0e09EFWVj5/jRsg?=
 =?us-ascii?Q?chR4b+izVEV+HTtdHM6jEkYbkv9hqBgwd0WZteL8khmT0hdvziJd4D1Yw4R4?=
 =?us-ascii?Q?MRS9+7yeGH+n7HuPWwu5aGVa7EOazBKqsdfn5Hw2uTf+JqRl/mTb7G4MBG+3?=
 =?us-ascii?Q?81wgEnI9rjoBNdC2beGvGAaNeOb4vp6ZmlHLCCJLuQ7adFQ2sM8Xb97z4Bte?=
 =?us-ascii?Q?uCNqCQHRusMThlXcYy1lBFIpPjU0/UVvUE7HyOp8YW8D3GM7ETG7YshE4Is+?=
 =?us-ascii?Q?1pNq+GrdM3POF5PWm4XgEkRQgMAIk40FFu42PG1+esl8AG7Rz2h1RggNPzgv?=
 =?us-ascii?Q?w5CkS7vShldmqsYTtWd08Y/99AsYVySPPYG3LZsIKath7wHjVvuyrsEB6bZm?=
 =?us-ascii?Q?jSv8XHSVdE03i/55Mz5ZU1SfiHXDnqOO5d1Uheyx/oVTQgEtv61lwH/Bf9FI?=
 =?us-ascii?Q?MsQygeqzbv+73pXppC9LWmBu7GAqTVNAFtKQSnYI/flim7A7MMuePFxtjnjI?=
 =?us-ascii?Q?SuFQCcD1CMVd4Jl5wfhXFftPJ5twSZVQDs9TuF4VDnn4yutBSDM+UJ0HbAD2?=
 =?us-ascii?Q?lmlLgbSCRn+peYKa3jBqGadTaukNypoRAYwHIVK7+ZQcbmG/9I4GHwqEqCWb?=
 =?us-ascii?Q?hADeI1NLsmuuonsibvIwqW1GPfH+TDP/rX5BwyGQ7Wm140L/O6S/QfNwtHZt?=
 =?us-ascii?Q?8P2W9x99Ul2BM7jpATcF4SGtmrbcBpsw4V32bC64jnP+byiAc8g+SRCYMkel?=
 =?us-ascii?Q?Eq+AvX4Vr6eQ/XueO90Mik5M2HkuCHezOWORUt7FQPgoG97IXuA00Agpw2MV?=
 =?us-ascii?Q?sdnHRpoS/6YRDcs5Ti0694O8N8hy5ggbtkkdKpEd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4545811-14b1-4a2d-67ca-08dd3babe9f0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 12:46:10.9499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEexFf8RhrA3gDpcBXRPoyFmCMUL83gr2+YjiS+xMK7LhvL/UcLthPLLqatO3RgIkTSbu3r+gMHYV92hUajknQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

All scx enums are now automatically generated from vmlinux.h and they
must be initialized using the SCX_ENUM_INIT() macro.

Fix the scx selftests to use this macro to properly initialize these
values.

Fixes: 8da7bf2cee27 ("tools/sched_ext: Receive updates from SCX repo")
Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
Closes: https://lore.kernel.org/all/Z2tNK2oFDX1OPp8C@slm.duckdns.org/
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 .../testing/selftests/sched_ext/create_dsq.c  | 10 ++++----
 .../selftests/sched_ext/ddsp_bogus_dsq_fail.c |  7 ++++--
 .../sched_ext/ddsp_vtimelocal_fail.c          |  7 ++++--
 .../selftests/sched_ext/dsp_local_on.c        |  1 +
 .../sched_ext/enq_last_no_enq_fails.c         | 10 ++++----
 .../sched_ext/enq_select_cpu_fails.c          | 10 ++++----
 tools/testing/selftests/sched_ext/exit.c      |  1 +
 tools/testing/selftests/sched_ext/hotplug.c   |  6 +++--
 .../selftests/sched_ext/init_enable_count.c   | 25 ++++++-------------
 tools/testing/selftests/sched_ext/maximal.c   |  7 ++++--
 tools/testing/selftests/sched_ext/minimal.c   | 10 ++++----
 tools/testing/selftests/sched_ext/prog_run.c  | 10 ++++----
 .../testing/selftests/sched_ext/reload_loop.c |  9 +++----
 .../selftests/sched_ext/select_cpu_dfl.c      |  7 ++++--
 .../sched_ext/select_cpu_dfl_nodispatch.c     |  7 ++++--
 .../selftests/sched_ext/select_cpu_dispatch.c |  7 ++++--
 .../sched_ext/select_cpu_dispatch_bad_dsq.c   |  7 ++++--
 .../sched_ext/select_cpu_dispatch_dbl_dsp.c   |  7 ++++--
 .../selftests/sched_ext/select_cpu_vtime.c    |  7 ++++--
 19 files changed, 88 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/create_dsq.c b/tools/testing/selftests/sched_ext/create_dsq.c
index fa946d9146d4..d67431f57ac6 100644
--- a/tools/testing/selftests/sched_ext/create_dsq.c
+++ b/tools/testing/selftests/sched_ext/create_dsq.c
@@ -14,11 +14,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct create_dsq *skel;
 
-	skel = create_dsq__open_and_load();
-	if (!skel) {
-		SCX_ERR("Failed to open and load skel");
-		return SCX_TEST_FAIL;
-	}
+	skel = create_dsq__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(create_dsq__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.c b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.c
index e65d22f23f3b..b6d13496b24e 100644
--- a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.c
+++ b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.c
@@ -15,8 +15,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct ddsp_bogus_dsq_fail *skel;
 
-	skel = ddsp_bogus_dsq_fail__open_and_load();
-	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	skel = ddsp_bogus_dsq_fail__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(ddsp_bogus_dsq_fail__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.c b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.c
index abafee587cd6..af9ce4ee8baa 100644
--- a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.c
+++ b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.c
@@ -14,8 +14,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct ddsp_vtimelocal_fail *skel;
 
-	skel = ddsp_vtimelocal_fail__open_and_load();
-	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	skel = ddsp_vtimelocal_fail__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(ddsp_vtimelocal_fail__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.c b/tools/testing/selftests/sched_ext/dsp_local_on.c
index 0ff27e57fe43..e1f2ce4abfe6 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.c
@@ -15,6 +15,7 @@ static enum scx_test_status setup(void **ctx)
 
 	skel = dsp_local_on__open();
 	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
 
 	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
 	SCX_FAIL_IF(dsp_local_on__load(skel), "Failed to load skel");
diff --git a/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c b/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c
index 73e679953e27..d3387ae03679 100644
--- a/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c
+++ b/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c
@@ -15,11 +15,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct enq_last_no_enq_fails *skel;
 
-	skel = enq_last_no_enq_fails__open_and_load();
-	if (!skel) {
-		SCX_ERR("Failed to open and load skel");
-		return SCX_TEST_FAIL;
-	}
+	skel = enq_last_no_enq_fails__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(enq_last_no_enq_fails__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
index dd1350e5f002..a80e3a3b3698 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
@@ -15,11 +15,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct enq_select_cpu_fails *skel;
 
-	skel = enq_select_cpu_fails__open_and_load();
-	if (!skel) {
-		SCX_ERR("Failed to open and load skel");
-		return SCX_TEST_FAIL;
-	}
+	skel = enq_select_cpu_fails__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(enq_select_cpu_fails__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/exit.c b/tools/testing/selftests/sched_ext/exit.c
index 31bcd06e21cd..9451782689de 100644
--- a/tools/testing/selftests/sched_ext/exit.c
+++ b/tools/testing/selftests/sched_ext/exit.c
@@ -23,6 +23,7 @@ static enum scx_test_status run(void *ctx)
 		char buf[16];
 
 		skel = exit__open();
+		SCX_ENUM_INIT(skel);
 		skel->rodata->exit_point = tc;
 		exit__load(skel);
 		link = bpf_map__attach_struct_ops(skel->maps.exit_ops);
diff --git a/tools/testing/selftests/sched_ext/hotplug.c b/tools/testing/selftests/sched_ext/hotplug.c
index 87bf220b1bce..1c9ceb661c43 100644
--- a/tools/testing/selftests/sched_ext/hotplug.c
+++ b/tools/testing/selftests/sched_ext/hotplug.c
@@ -49,8 +49,10 @@ static enum scx_test_status test_hotplug(bool onlining, bool cbs_defined)
 
 	SCX_ASSERT(is_cpu_online());
 
-	skel = hotplug__open_and_load();
-	SCX_ASSERT(skel);
+	skel = hotplug__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(hotplug__load(skel), "Failed to load skel");
 
 	/* Testing the offline -> online path, so go offline before starting */
 	if (onlining)
diff --git a/tools/testing/selftests/sched_ext/init_enable_count.c b/tools/testing/selftests/sched_ext/init_enable_count.c
index 97d45f1e5597..0f3eddc7a17a 100644
--- a/tools/testing/selftests/sched_ext/init_enable_count.c
+++ b/tools/testing/selftests/sched_ext/init_enable_count.c
@@ -15,22 +15,6 @@
 
 #define SCHED_EXT 7
 
-static struct init_enable_count *
-open_load_prog(bool global)
-{
-	struct init_enable_count *skel;
-
-	skel = init_enable_count__open();
-	SCX_BUG_ON(!skel, "Failed to open skel");
-
-	if (!global)
-		skel->struct_ops.init_enable_count_ops->flags |= SCX_OPS_SWITCH_PARTIAL;
-
-	SCX_BUG_ON(init_enable_count__load(skel), "Failed to load skel");
-
-	return skel;
-}
-
 static enum scx_test_status run_test(bool global)
 {
 	struct init_enable_count *skel;
@@ -40,7 +24,14 @@ static enum scx_test_status run_test(bool global)
 	struct sched_param param = {};
 	pid_t pids[num_pre_forks];
 
-	skel = open_load_prog(global);
+	skel = init_enable_count__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+
+	if (!global)
+		skel->struct_ops.init_enable_count_ops->flags |= SCX_OPS_SWITCH_PARTIAL;
+
+	SCX_FAIL_IF(init_enable_count__load(skel), "Failed to load skel");
 
 	/*
 	 * Fork a bunch of children before we attach the scheduler so that we
diff --git a/tools/testing/selftests/sched_ext/maximal.c b/tools/testing/selftests/sched_ext/maximal.c
index f38fc973c380..c6be50a9941d 100644
--- a/tools/testing/selftests/sched_ext/maximal.c
+++ b/tools/testing/selftests/sched_ext/maximal.c
@@ -14,8 +14,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct maximal *skel;
 
-	skel = maximal__open_and_load();
-	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	skel = maximal__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(maximal__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/minimal.c b/tools/testing/selftests/sched_ext/minimal.c
index 6c5db8ebbf8a..89f7261757ff 100644
--- a/tools/testing/selftests/sched_ext/minimal.c
+++ b/tools/testing/selftests/sched_ext/minimal.c
@@ -15,11 +15,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct minimal *skel;
 
-	skel = minimal__open_and_load();
-	if (!skel) {
-		SCX_ERR("Failed to open and load skel");
-		return SCX_TEST_FAIL;
-	}
+	skel = minimal__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(minimal__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/prog_run.c b/tools/testing/selftests/sched_ext/prog_run.c
index 3cd57ef8daaa..05974820ca69 100644
--- a/tools/testing/selftests/sched_ext/prog_run.c
+++ b/tools/testing/selftests/sched_ext/prog_run.c
@@ -15,11 +15,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct prog_run *skel;
 
-	skel = prog_run__open_and_load();
-	if (!skel) {
-		SCX_ERR("Failed to open and load skel");
-		return SCX_TEST_FAIL;
-	}
+	skel = prog_run__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(prog_run__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/reload_loop.c b/tools/testing/selftests/sched_ext/reload_loop.c
index 5cfba2d6e056..308211d80436 100644
--- a/tools/testing/selftests/sched_ext/reload_loop.c
+++ b/tools/testing/selftests/sched_ext/reload_loop.c
@@ -18,11 +18,10 @@ bool force_exit = false;
 
 static enum scx_test_status setup(void **ctx)
 {
-	skel = maximal__open_and_load();
-	if (!skel) {
-		SCX_ERR("Failed to open and load skel");
-		return SCX_TEST_FAIL;
-	}
+	skel = maximal__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(maximal__load(skel), "Failed to load skel");
 
 	return SCX_TEST_PASS;
 }
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.c b/tools/testing/selftests/sched_ext/select_cpu_dfl.c
index a53a40c2d2f0..5b6e045e1109 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.c
@@ -17,8 +17,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct select_cpu_dfl *skel;
 
-	skel = select_cpu_dfl__open_and_load();
-	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	skel = select_cpu_dfl__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(select_cpu_dfl__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
index 1d85bf4bf3a3..9b5d232efb7f 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
@@ -17,8 +17,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct select_cpu_dfl_nodispatch *skel;
 
-	skel = select_cpu_dfl_nodispatch__open_and_load();
-	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	skel = select_cpu_dfl_nodispatch__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(select_cpu_dfl_nodispatch__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch.c
index 0309ca8785b3..80283dbc41b7 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch.c
@@ -17,8 +17,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct select_cpu_dispatch *skel;
 
-	skel = select_cpu_dispatch__open_and_load();
-	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	skel = select_cpu_dispatch__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(select_cpu_dispatch__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.c
index 47eb6ed7627d..5e72ebbc90a5 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.c
@@ -15,8 +15,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct select_cpu_dispatch_bad_dsq *skel;
 
-	skel = select_cpu_dispatch_bad_dsq__open_and_load();
-	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	skel = select_cpu_dispatch_bad_dsq__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(select_cpu_dispatch_bad_dsq__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.c
index 48ff028a3c46..aa85949478bc 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.c
@@ -15,8 +15,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct select_cpu_dispatch_dbl_dsp *skel;
 
-	skel = select_cpu_dispatch_dbl_dsp__open_and_load();
-	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	skel = select_cpu_dispatch_dbl_dsp__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(select_cpu_dispatch_dbl_dsp__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.c
index b4629c2364f5..1e9b5c9bfff1 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_vtime.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.c
@@ -15,8 +15,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct select_cpu_vtime *skel;
 
-	skel = select_cpu_vtime__open_and_load();
-	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	skel = select_cpu_vtime__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(select_cpu_vtime__load(skel), "Failed to load skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
-- 
2.48.1


