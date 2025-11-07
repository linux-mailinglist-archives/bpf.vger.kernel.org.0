Return-Path: <bpf+bounces-73950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 426FBC3F7E8
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 11:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7C094F5ECD
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 10:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97059320CBF;
	Fri,  7 Nov 2025 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="loOy/frR"
X-Original-To: bpf@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F631A04F;
	Fri,  7 Nov 2025 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511448; cv=fail; b=ZQH6PPOhnntg3x0pzvtRI0ABtEiVtBC1JNLZM1LnGcylr60WrxIcYg+XVPCeWM+Pb1jvxRGqzD69CoJOi36Iglm6oxjUU5LOk0KIomLXBhadKq+zHGUqoM9MbjnjfVKZv7V6e3Df6d+HQucqNVitAWPrB6Be1GlPp0PXQDKoKEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511448; c=relaxed/simple;
	bh=qIQOcIZQ6yFKzrEQOmWqhEjRX9AQDwC8lliuaP1RQ/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqxvOW4dkQbeYFrzcxl3X8L3u+ErGnNqV/I4RrztN2eYnXOqpEfYxRC/Zz+DQb2QehHlscdoay+b5QcVL0pCcnTHpQijhFq87qnUsQunI0Rz0+ruysCyXU9Uh1+DHvaSp+OshXyK15KptdYYyDHGL9p+o2e0TwigmwSit3C0B8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=loOy/frR; arc=fail smtp.client-ip=40.93.198.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRiZftQuBZzhhBtyJQv7ezo4nzinfiHZ8VJh40sALWd2G2HbVuusI11mrUr3zlNerVW87RZvEvKxtN0pLVWYh1nedxZwHPjyVotJ9U2QYuMGKiyzUmlRFm9MJMYPGVwo7SWigAiewVQHkXQaWllKIW4Su/qQF1eW61wBGxjfzfcyogR5Lb/K9Rm+RF3dgHFK0ECxn+m6rzNTxM0ah6LFm879T81b740T1Uowp/iXJJpliS4eSnBn9ZvGWnD+j8ecH4nAhHaEPHgLD0tRY1UuE1Z1TDD84ql8+D7MpLe6D5Mx07UjR+3uCF6xmKFtTNrpWLq78DBiTafqM/t9CN4+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9fIS60WSA8Msu5O4rsL9/A/R6KcFaPCpozKsTYF5Sc=;
 b=bcKz8PclFde8Hr+RLZTGKN3GgPAq4ndXhlr1tb0gk929zapovU0qy2j4lz80LM9bNShzA/QKGc1bVgpSNCj/S9cN5Vr496IWfktD6HPTRBkllDsK6U7PULU2/sPcr7cAMUEmTBAtiEnOTpmvl8/cI18kfG1iSFUYR5b5x8f/z0sL9skVbg4xYBhq0NTZB7dKObqNzeEh/JBdsjmgDEUQcyFQZWGhtsebA9ejHW2XQcJudjw2v7IpPPSYJ6nqXOQTa5o/aSuJVoIBcvAs0F+tWPy1bsDB/8d5j5Rhcek8y0sgBPQGaO9vPHvRCkMW3rmf4YA6vUcAXkKIpVbWokTGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9fIS60WSA8Msu5O4rsL9/A/R6KcFaPCpozKsTYF5Sc=;
 b=loOy/frRbuqasbIxoh0kC263nhBBpy4Nev1H8VpzKFWkD3S4Jj4Xybw2WUT0MYEyNKokC12fGwN/Gpg8xj3E/L0OkSdcJsw1BQGZp/Ioo2tzt1/I/BVEP48t2CTze7z4hmtNRy6bboyXzs/den/zh0FVBRH3M19JEFd62dF97INLUM9lNPdYdVN1ey9LeWGUY1Ba9FpNMS435rkziNFWC5neyoRHDcHw9ORko8l72hRFXwXexnEHZ/FFJv1zFCs70QXMjkgHXK7EAZhYHshPrVumJTVC8/01sEtIGyHYHTUKb2OohlnnuI8OFGoujyNBlsrIINt9pSKAC746L/XDCQ==
Received: from BL0PR0102CA0020.prod.exchangelabs.com (2603:10b6:207:18::33) by
 CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.10; Fri, 7 Nov 2025 10:30:40 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:207:18:cafe::1f) by BL0PR0102CA0020.outlook.office365.com
 (2603:10b6:207:18::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 10:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Fri, 7 Nov 2025 10:30:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 02:30:25 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 7 Nov 2025 02:30:24 -0800
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 7 Nov
 2025 02:30:18 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [RFC 2/2] xdp: Delegate fast path return decision to page_pool
Date: Fri, 7 Nov 2025 12:28:46 +0200
Message-ID: <20251107102853.1082118-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107102853.1082118-2-dtatulea@nvidia.com>
References: <20251107102853.1082118-2-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: dedf7ff1-dae5-4c51-7186-08de1de8b276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xq611W5P3m+BEiv+ZsiM1NwCTdiaAUtc2TAxhyWHv3IAqK+kfW+jYoRV4ZOZ?=
 =?us-ascii?Q?ybTa3xoAs+1EFc9wqfmDhaQ/2+bE1WQKotytG+IbRK/qnTkKL6oKvrI9SDSO?=
 =?us-ascii?Q?gaU+FPHu32QB1pDF16+wdwAtg2W4RRoexd/I6upSScrgzym0U5E8/0IAKOl+?=
 =?us-ascii?Q?LryohBaO6zNEEWN5udNG0CTTnAqGIwKL0Cr4BHqPI8sa8qbWrp77dV1MarwH?=
 =?us-ascii?Q?pci3z/cCLQ/AX/69y9FGJPE6pZa3y95sLHSuJJSEkDclLACQJD5cdhYEH058?=
 =?us-ascii?Q?CEyNKORoU+99GgFwQvuwOVUYApYgnLLw+bAWRP92CYCdI5MzMpFsj+LjAQrB?=
 =?us-ascii?Q?apvwXHyGJyw+k6JNZ30/R6fxjCW8dT9BeehUpqt+9ByKoA4bAymDM1XlHC79?=
 =?us-ascii?Q?iofMy2DnU+LFgAvDlMO8/7vt0wiuHjXaQxforZbxJ0mMOqSizcVtXgkJyeWM?=
 =?us-ascii?Q?aO7z86nC9MoSKmBJ8YorVm24Ejm0Er9dAzB3b9qTgh2AuE8He8eBTPoDjeUo?=
 =?us-ascii?Q?5JNd2dLMNDlNkr4eH6G9rGsBXC4+QoBgJQSTU0kj70CY8lxiAFFyVDEVaHXd?=
 =?us-ascii?Q?C6Fa8NmblLJ8AVE0l5q8577sn6AT2yYut6bWzM8SdP+cN0F5Dct/lLo8BaSX?=
 =?us-ascii?Q?Qu6f20szcH2ITr7x4nwMXFw/XqpgSfZ+7ESxxIg//H0E0ctcCMEIm+e5zqot?=
 =?us-ascii?Q?prHwk3o+wWHhFYTp5zXWY0RgKTEOJcEPrlVyfF48fO+I0KaWlBstQEX1PbVC?=
 =?us-ascii?Q?ia9U4hC/bJ64aTbaDk9QLXEKRVAdbwC+15W6raGAHprX8y7BXBN3MzF6J5sU?=
 =?us-ascii?Q?1bFmX2DbEzDeDQlDQjZ4/jKZeL7CItmCF+ozt01QKdPVUxhTgSWkaCCDTiuU?=
 =?us-ascii?Q?l6V1UQ8voeBpHnKq5KaIIoJ1s+kEFAuFGTttyedwTD+9rR9mONC5FXAb0iVy?=
 =?us-ascii?Q?P51FLslajR8zpXP8vkq7g1NE3AhV3Bxi/Qqyjjblg9dd8VVAY5IXhdN/WsuK?=
 =?us-ascii?Q?h/7ncQv0nPy2KgLmwd+7kl4SLYTSpV910NXKkondFLaH0iHaWBtcFU/fnRau?=
 =?us-ascii?Q?YzErxwra3wTaLj9CGh2mZ54XjvCRBV4fDHVAIT0ZXtLRrpXiN7QXUC2Anovx?=
 =?us-ascii?Q?GGQVsrVDx9YwC1xAA1E00jyDBiSFCat63zkofa9NHtfWe0MKaVthXEXPcq1H?=
 =?us-ascii?Q?qEisrLLUNiUVQ6JB3Gl40IJrsCc5kGzGvjgm2o5tXvp84ykrOj8s87aAGNXb?=
 =?us-ascii?Q?Xb69FgXkRczFpJKID1pqeXxSJefUikgj7Ryfe7NOGIjcPGOmFrZnOFb2vGOH?=
 =?us-ascii?Q?0Hzs3jxUYt25xGd1xJkah7+nAFtW4z7dQnpemrBMQ2uvbZYqQsk6YB9+3gfv?=
 =?us-ascii?Q?9hrBnA2PNKsv/lk2EyWtpgBf9S23yRxh89/bL+wt4VdnPL9tGOyldRsZ8fzW?=
 =?us-ascii?Q?qfergSM4dN+vL/Jk0RYqIOpubeu0sTADlYxgP3hW/V5pCugNKwvmZHuKX+Uq?=
 =?us-ascii?Q?XoQiW5Ru1gb49V/r4YY9ECzrYgrwySOko9sQxUDZ4pw9aT+mVy1A10YatThh?=
 =?us-ascii?Q?9vbewB32aKz3LVi9Gp5ykgbZI2hcQpevZc4VT8qN?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:30:39.5233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dedf7ff1-dae5-4c51-7186-08de1de8b276
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249

XDP uses the BPF_RI_F_RF_NO_DIRECT flag to mark contexts where it is not
allowed to do direct recycling, even though the direct flag was set by
the caller. This is confusing and can lead to races which are hard to
detect [1].

Furthermore, the page_pool already contains an internal
mechanism which checks if it is safe to switch the direct
flag from off to on.

This patch drops the use of the BPF_RI_F_RF_NO_DIRECT flag and always
calls the page_pool release with the direct flag set to false. The
page_pool will decide if it is safe to do direct recycling. This
is not free but it is worth it to make the XDP code safer. The
next paragrapsh are discussing the performance impact.

Performance wise, there are 3 cases to consider. Looking from
__xdp_return() for MEM_TYPE_PAGE_POOL case:

1) napi_direct == false:
  - Before: 1 comparison in __xdp_return() + call of
    page_pool_napi_local() from page_pool_put_unrefed_netmem().
  - After: Only one call to page_pool_napi_local().

2) napi_direct == true && BPF_RI_F_RF_NO_DIRECT
  - Before: 2 comparisons in __xdp_return() + call of
    page_pool_napi_local() from page_pool_put_unrefed_netmem().
  - After: Only one call to page_pool_napi_local().

3) napi_direct == true && !BPF_RI_F_RF_NO_DIRECT
  - Before: 2 comparisons in __xdp_return().
  - After: One call to page_pool_napi_local()

Case 1 & 2 are the slower paths and they only have to gain.
But they are slow anyway so the gain is small.

Case 3 is the fast path and is the one that has to be considered more
closely. The 2 comparisons from __xdp_return() are swapped for the more
expensive page_pool_napi_local() call.

Using the page_pool benchmark between the fast-path and the
newly-added NAPI aware mode to measure [2] how expensive
page_pool_napi_local() is:

  bench_page_pool: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
  bench_page_pool: Type:tasklet_page_pool01_fast_path Per elem: 15 cycles(tsc) 7.537 ns (step:0)

  bench_page_pool: time_bench_page_pool04_napi_aware(): in_serving_softirq fast-path
  bench_page_pool: Type:tasklet_page_pool04_napi_aware Per elem: 20 cycles(tsc) 10.490 ns (step:0)

... and the slow path for reference:

  bench_page_pool: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
  bench_page_pool: Type:tasklet_page_pool02_ptr_ring Per elem: 30 cycles(tsc) 15.395 ns (step:0)

So the impact is small in the fast-path, but not negligible. One thing
to consider is the fact that the comparisons from napi_direct are
dropped. That means that the impact will be smaller than the
measurements from the benchmark.

[1] Commit 2b986b9e917b ("bpf, cpumap: Disable page_pool direct xdp_return need larger scope")
[2] Intel Xeon Platinum 8580

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/veth.c     |  2 --
 include/linux/filter.h | 22 ----------------------
 include/net/xdp.h      |  2 +-
 kernel/bpf/cpumap.c    |  2 --
 net/bpf/test_run.c     |  2 --
 net/core/filter.c      |  2 +-
 net/core/xdp.c         | 24 ++++++++++++------------
 7 files changed, 14 insertions(+), 42 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3046142cb8e..6d5c1e0b05a7 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -975,7 +975,6 @@ static int veth_poll(struct napi_struct *napi, int budget)
 
 	bq.count = 0;
 
-	xdp_set_return_frame_no_direct();
 	done = veth_xdp_rcv(rq, budget, &bq, &stats);
 
 	if (stats.xdp_redirect > 0)
@@ -994,7 +993,6 @@ static int veth_poll(struct napi_struct *napi, int budget)
 
 	if (stats.xdp_tx > 0)
 		veth_xdp_flush(rq, &bq);
-	xdp_clear_return_frame_no_direct();
 
 	return done;
 }
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a..877e40d81a4c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -764,7 +764,6 @@ struct bpf_nh_params {
 };
 
 /* flags for bpf_redirect_info kern_flags */
-#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
 #define BPF_RI_F_RI_INIT	BIT(1)
 #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
 #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
@@ -1163,27 +1162,6 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 				       const struct bpf_insn *patch, u32 len);
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
 
-static inline bool xdp_return_frame_no_direct(void)
-{
-	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
-
-	return ri->kern_flags & BPF_RI_F_RF_NO_DIRECT;
-}
-
-static inline void xdp_set_return_frame_no_direct(void)
-{
-	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
-
-	ri->kern_flags |= BPF_RI_F_RF_NO_DIRECT;
-}
-
-static inline void xdp_clear_return_frame_no_direct(void)
-{
-	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
-
-	ri->kern_flags &= ~BPF_RI_F_RF_NO_DIRECT;
-}
-
 static inline int xdp_ok_fwd_dev(const struct net_device *fwd,
 				 unsigned int pktlen)
 {
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..2a44d84a7611 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -446,7 +446,7 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
 }
 
 void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
-		  bool napi_direct, struct xdp_buff *xdp);
+		  struct xdp_buff *xdp);
 void xdp_return_frame(struct xdp_frame *xdpf);
 void xdp_return_frame_rx_napi(struct xdp_frame *xdpf);
 void xdp_return_buff(struct xdp_buff *xdp);
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 703e5df1f4ef..3ece03dc36bd 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -253,7 +253,6 @@ static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 
 	rcu_read_lock();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
-	xdp_set_return_frame_no_direct();
 
 	ret->xdp_n = cpu_map_bpf_prog_run_xdp(rcpu, frames, ret->xdp_n, stats);
 	if (unlikely(ret->skb_n))
@@ -263,7 +262,6 @@ static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 	if (stats->redirect)
 		xdp_do_flush();
 
-	xdp_clear_return_frame_no_direct();
 	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8b7d0b90fea7..a0fe03e9e527 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -289,7 +289,6 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 	local_bh_disable();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	ri = bpf_net_ctx_get_ri();
-	xdp_set_return_frame_no_direct();
 
 	for (i = 0; i < batch_sz; i++) {
 		page = page_pool_dev_alloc_pages(xdp->pp);
@@ -352,7 +351,6 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 			err = ret;
 	}
 
-	xdp_clear_return_frame_no_direct();
 	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 	return err;
diff --git a/net/core/filter.c b/net/core/filter.c
index 16105f52927d..5622ec5ac19c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4187,7 +4187,7 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
 	}
 
 	if (release) {
-		__xdp_return(netmem, mem_type, false, zc_frag);
+		__xdp_return(netmem, mem_type, zc_frag);
 	} else {
 		if (!tail)
 			skb_frag_off_add(frag, shrink);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9100e160113a..cf8eab699d9a 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -431,18 +431,18 @@ EXPORT_SYMBOL_GPL(xdp_rxq_info_attach_page_pool);
  * of xdp_frames/pages in those cases.
  */
 void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
-		  bool napi_direct, struct xdp_buff *xdp)
+		  struct xdp_buff *xdp)
 {
 	switch (mem_type) {
 	case MEM_TYPE_PAGE_POOL:
 		netmem = netmem_compound_head(netmem);
-		if (napi_direct && xdp_return_frame_no_direct())
-			napi_direct = false;
+
 		/* No need to check netmem_is_pp() as mem->type knows this a
 		 * page_pool page
+		 *
+		 * page_pool can detect direct recycle.
 		 */
-		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
-					  napi_direct);
+		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
 		break;
 	case MEM_TYPE_PAGE_SHARED:
 		page_frag_free(__netmem_address(netmem));
@@ -471,10 +471,10 @@ void xdp_return_frame(struct xdp_frame *xdpf)
 	sinfo = xdp_get_shared_info_from_frame(xdpf);
 	for (u32 i = 0; i < sinfo->nr_frags; i++)
 		__xdp_return(skb_frag_netmem(&sinfo->frags[i]), xdpf->mem_type,
-			     false, NULL);
+			     NULL);
 
 out:
-	__xdp_return(virt_to_netmem(xdpf->data), xdpf->mem_type, false, NULL);
+	__xdp_return(virt_to_netmem(xdpf->data), xdpf->mem_type, NULL);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame);
 
@@ -488,10 +488,10 @@ void xdp_return_frame_rx_napi(struct xdp_frame *xdpf)
 	sinfo = xdp_get_shared_info_from_frame(xdpf);
 	for (u32 i = 0; i < sinfo->nr_frags; i++)
 		__xdp_return(skb_frag_netmem(&sinfo->frags[i]), xdpf->mem_type,
-			     true, NULL);
+			     NULL);
 
 out:
-	__xdp_return(virt_to_netmem(xdpf->data), xdpf->mem_type, true, NULL);
+	__xdp_return(virt_to_netmem(xdpf->data), xdpf->mem_type, NULL);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);
 
@@ -542,7 +542,7 @@ EXPORT_SYMBOL_GPL(xdp_return_frame_bulk);
  */
 void xdp_return_frag(netmem_ref netmem, const struct xdp_buff *xdp)
 {
-	__xdp_return(netmem, xdp->rxq->mem.type, true, NULL);
+	__xdp_return(netmem, xdp->rxq->mem.type, NULL);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frag);
 
@@ -556,10 +556,10 @@ void xdp_return_buff(struct xdp_buff *xdp)
 	sinfo = xdp_get_shared_info_from_buff(xdp);
 	for (u32 i = 0; i < sinfo->nr_frags; i++)
 		__xdp_return(skb_frag_netmem(&sinfo->frags[i]),
-			     xdp->rxq->mem.type, true, xdp);
+			     xdp->rxq->mem.type, xdp);
 
 out:
-	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type, true, xdp);
+	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type, xdp);
 }
 EXPORT_SYMBOL_GPL(xdp_return_buff);
 
-- 
2.50.1


