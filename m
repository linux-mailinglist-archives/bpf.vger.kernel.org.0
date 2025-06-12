Return-Path: <bpf+bounces-60480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A86AD771A
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36793A4BC1
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8992C3774;
	Thu, 12 Jun 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oulq2TD3"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF9E29AB16;
	Thu, 12 Jun 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743306; cv=fail; b=DqY5N057E8+IcZc9GxrTk7F/0SWHRMrhN7e3hp9Mlml2U8Ndbno2yu8goHfgq+0J62dqVfC3Ptp/u8wUXx02I7293nLM2fxACYWBNPQdbaouo44xPCFWVsi+bdJByOSHY6df3dcO7I1RS1HC5T5smQEwBfVJcqxJOFQ71GIpzqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743306; c=relaxed/simple;
	bh=IgPRg2Z6oPvS5AnDgfyZfrLCEfntAHIivx4D4Z0if20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHNywL0J5vGpbFBNWs2uzSDViBppWIPP8FpGcp3xAR1hws/e/cPOl+PUthvcFzmLq677nrToKDe6M/p8PZ5dGjpr2InZ/1G0G+FwgCwJt5O7UpxNmTPopb25PrPcXQGJTl9nClCL02zFQrLaLzwDawjcuqG0vw2Gt6hNqK1cI3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oulq2TD3; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNCy0XXgTN1JBJ4F+xe3YlirazgHZdK9FIEfa3flqjJtINpaviVvSoz5QDn9VpRtitPMUFZzJyTD6WRvkTKEzWEH9Vu4YIm4NbS6+zoVp3iTCNodHsgfxV+PxIZckKWc25dcUwdla6EXdNjzJ1D2s1IUFWMVTkAQTrMWsuZyQeq+ZvUHIEhwWUSuMVLHgn1kbDBVddGWkZgqeNSi/kypyfQfUjBMyJF3b1fXfpoVzW6fAqJ9A6ODhq1eRk+ix95T+mI+RDoQGIfRSXXTcQSX6dAyh/pYnaQvXq8xEnl1Kfs24HQPFPDRhZ8CEDE5aVghFd1rdAh8xsFcu/Bsuizjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eZS3AV9PNli/fxdufttwlf/CrH7qfP7WTjeuTTH4kM=;
 b=jrBCsi3Ht5nHsBb7BcxxN/F4MqfOkOtAB/uRxlaNIP6nkoJk/V1IilLVIuz8NqFygf6OBgRbGpbdjb64AwKuyGHLnfdZNGmJ1zwLgV+qQ0X7PAovWfbwohqq/qHFt4eSK6Nn1S5f1pVlP+wMTBTam7llBVFECMe+Vr3HP4THcVGS8N42N9Pwl9v2yRFLKmsfw93wbBwv7u1N09ZlZYtEwHgdv3/BGV20tkTZlkLPniNTo8P49Hzr/VxOB6M18Uk7X/kbNyxvN+prsBmtZ6BqTPXpqZkFSXQOlrr0HlDSE5Gjg213p+RPNZfuetU18WfCySDb+zS9VVSbEaMH7yQG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eZS3AV9PNli/fxdufttwlf/CrH7qfP7WTjeuTTH4kM=;
 b=Oulq2TD34hM6r43dVSGhIL0mypIIdVW6B98oNSbkRbdTyiAK75VYF0n0Xio0kHWcrXVyPbm+Cc6ijDh8vRJj07de1YY/dZaIorkHm3eLErJS/QJ2v2IaTREGw88fhg4Gfofhq8k0HoBGY10v/EfzhqqG73Hl7XbIo7rAigMzwO5xRayWVYyYgav6rl4nxcDfsAs8LiIPHSJ/o3Y/4t7omK09PEV7bBAh5Et5TCUsC11pjcQK557zoCHcqBfq3RvyZmy+5yBQUB4DD3tHIfm4wUvU4hrW8P8nsFwijO/IDx6TwtD91TcSFH8veUYtpWeSjGBrGU31LCTZt7VQZdWDww==
Received: from SN7PR04CA0038.namprd04.prod.outlook.com (2603:10b6:806:120::13)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 12 Jun
 2025 15:48:19 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::e4) by SN7PR04CA0038.outlook.office365.com
 (2603:10b6:806:120::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Thu,
 12 Jun 2025 15:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:48:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 08:47:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 08:47:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 12
 Jun 2025 08:47:49 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Mina Almasry
	<almasrymina@google.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v5 08/12] net/mlx5e: Convert over to netmem
Date: Thu, 12 Jun 2025 18:46:44 +0300
Message-ID: <20250612154648.1161201-9-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612154648.1161201-1-mbloch@nvidia.com>
References: <20250612154648.1161201-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b1552b-2132-4cba-0e2f-08dda9c88d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NhAF8SzvEjQixmLpIX804k1CcATG4OWTnYIKJrI2KDDAB3IdIkr/qSWGZaNC?=
 =?us-ascii?Q?qMCOLA9tN5WL9YQQy4BZ/3tHkUR3ADvsvrRN3bTjMoNEory++Q2T/TQFUWXR?=
 =?us-ascii?Q?BD77AFsr86M8+DUWmocCg429ux09zA4Gsv7o/Uk2B1t0L8zAUZI0s9YKkJUX?=
 =?us-ascii?Q?0HIWyAP7aMAvRoZV/e+kOo2n3ButSz6Xvs9h/BeOT+qX59sDQFAEt4jvK0Vw?=
 =?us-ascii?Q?34el/qlVkgTRrf2dl4NCWgc4QBK+18e0S8+ffQ8rWTyDffVFpkJcvNOVdyI1?=
 =?us-ascii?Q?HWsQp06k0HwitqmH3iSw8wZujzqk7Y/63Cf0xWokQNm9zYiUBnlPo0jZOrBL?=
 =?us-ascii?Q?iAaNAODEXgSiIyonKs8X8BNWTvBdT6uWctW+RaOhrrew0vUacAy2bIsfGhTU?=
 =?us-ascii?Q?PvNxYYY3Bais04++jxrIF+G2DiVfCOicUkOU+W9tg7x1unmlOiZUCT7Nfmsm?=
 =?us-ascii?Q?efp4himeMbWrvn9gNEM0qY3SNunJpJaWNC9AXAl8PTI632937bHipqfg4hsL?=
 =?us-ascii?Q?4A9EtMuuX4eliD2d0ZA3dKtd4BMOWwUjvTwh1kukhojQaauWZ5lxlhiVreUt?=
 =?us-ascii?Q?Ji4RXz3hATo5UwTVn3SP495G7Vq4N354s+9zamVrsKImpPXobD88AaSMZu72?=
 =?us-ascii?Q?fuPgmPJ5AIrS85uFxKJkH/IvgigAhVUpnIF3W5x73m1gOMg6mI1TzPNtB/rW?=
 =?us-ascii?Q?kbfuoP/XKwwGkFPbTwx1F+5y6lCnJByuXjVP4VCfvHxlxUmk1yb0dOVdxaYs?=
 =?us-ascii?Q?Z0iql3SxH8zsTRxzh9NSy7fscv70jiPkhfKUy8lrdBN/j6i9xleo85NOnFvL?=
 =?us-ascii?Q?zyhBzkb8YWJnHm8wct443TtDIAnMsx+UqnkUNFAo/KzU3YbwPzHNvgCXmaP9?=
 =?us-ascii?Q?/NyRQiw4pBJ3zk/t3MAfuaGlZPcDlejWca42zt51kvNhIETMIvfSQ89w7W22?=
 =?us-ascii?Q?n/b6cbaILISpgdenCkP4LjI6x1KYfuZttq601hJOEeBUvqZyucA1KodvLIPk?=
 =?us-ascii?Q?kN22IHSHCUQgCXcbe1sG3yIBx9NylpE49aOsjlROeoc6VBjt+/TA4HR8Ha0w?=
 =?us-ascii?Q?GeUBCBb4l3aV77SHlojy08ztSQdjHgpdilKmHAbn4bM3x9sn8xMYiDMPZTlB?=
 =?us-ascii?Q?TjrZdIzoihfTpAZ2wbM+3SiP5k1g8vtBNkPX4jCtvH30Ja/A1bQD08AXsLXi?=
 =?us-ascii?Q?0FiqKN4tHTHryqEysUZkJeLuOwfVLkoZGYMcuOx9QP3NStpajt+jH4KzcWkb?=
 =?us-ascii?Q?32o8eearGHNPLsc8xmNhj+ycX81cYFiYbkxplEikIyGonFg4R9kfxx05m6dD?=
 =?us-ascii?Q?Ue5U0Xd+aDIw0Rx4qNK8uRcWIH5QXQaZsSHVgbvqH46LMcY6BchJVgBDN3eJ?=
 =?us-ascii?Q?QZaOKQNjfZM+yeFqADl97kR5TVyhNWRKV/UbdZ4pMmyiW0fb2HVL55QuepE2?=
 =?us-ascii?Q?mgJZHKJ6ikQSR51z1Yxb68VAbK0REpag2avdgPJCfC3afHLzqjJ5rwa5Im/p?=
 =?us-ascii?Q?xfqInqiQRwuYhSiSwZmgqZlXFoqa9n2+CP9A?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:48:18.1255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b1552b-2132-4cba-0e2f-08dda9c88d20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351

From: Saeed Mahameed <saeedm@nvidia.com>

mlx5e_page_frag holds the physical page itself, to naturally support
zc page pools, remove physical page reference from mlx5 and replace it
with netmem_ref, to avoid internal handling in mlx5 for net_iov backed
pages.

SHAMPO can issue packets that are not split into header and data. These
packets will be dropped if the data part resides in a net_iov as the
driver can't read into this area.

No performance degradation observed.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 105 +++++++++++-------
 2 files changed, 63 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index c329de1d4f0a..65a73913b9a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -553,7 +553,7 @@ struct mlx5e_icosq {
 } ____cacheline_aligned_in_smp;
 
 struct mlx5e_frag_page {
-	struct page *page;
+	netmem_ref netmem;
 	u16 frags;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index e34ef53ebd0e..2bb32082bfcc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -273,33 +273,32 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
 
 #define MLX5E_PAGECNT_BIAS_MAX (PAGE_SIZE / 64)
 
-static int mlx5e_page_alloc_fragmented(struct page_pool *pool,
+static int mlx5e_page_alloc_fragmented(struct page_pool *pp,
 				       struct mlx5e_frag_page *frag_page)
 {
-	struct page *page;
+	netmem_ref netmem = page_pool_dev_alloc_netmems(pp);
 
-	page = page_pool_dev_alloc_pages(pool);
-	if (unlikely(!page))
+	if (unlikely(!netmem))
 		return -ENOMEM;
 
-	page_pool_fragment_page(page, MLX5E_PAGECNT_BIAS_MAX);
+	page_pool_fragment_netmem(netmem, MLX5E_PAGECNT_BIAS_MAX);
 
 	*frag_page = (struct mlx5e_frag_page) {
-		.page	= page,
+		.netmem	= netmem,
 		.frags	= 0,
 	};
 
 	return 0;
 }
 
-static void mlx5e_page_release_fragmented(struct page_pool *pool,
+static void mlx5e_page_release_fragmented(struct page_pool *pp,
 					  struct mlx5e_frag_page *frag_page)
 {
 	u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
-	struct page *page = frag_page->page;
+	netmem_ref netmem = frag_page->netmem;
 
-	if (page_pool_unref_page(page, drain_count) == 0)
-		page_pool_put_unrefed_page(pool, page, -1, true);
+	if (page_pool_unref_netmem(netmem, drain_count) == 0)
+		page_pool_put_unrefed_netmem(pp, netmem, -1, true);
 }
 
 static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
@@ -359,7 +358,7 @@ static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
 		frag->flags &= ~BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
 
 		headroom = i == 0 ? rq->buff.headroom : 0;
-		addr = page_pool_get_dma_addr(frag->frag_page->page);
+		addr = page_pool_get_dma_addr_netmem(frag->frag_page->netmem);
 		wqe->data[i].addr = cpu_to_be64(addr + frag->offset + headroom);
 	}
 
@@ -500,9 +499,10 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 			       struct xdp_buff *xdp, struct mlx5e_frag_page *frag_page,
 			       u32 frag_offset, u32 len)
 {
+	netmem_ref netmem = frag_page->netmem;
 	skb_frag_t *frag;
 
-	dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
+	dma_addr_t addr = page_pool_get_dma_addr_netmem(netmem);
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len, rq->buff.map_dir);
 	if (!xdp_buff_has_frags(xdp)) {
@@ -515,9 +515,9 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 	}
 
 	frag = &sinfo->frags[sinfo->nr_frags++];
-	skb_frag_fill_page_desc(frag, frag_page->page, frag_offset, len);
+	skb_frag_fill_netmem_desc(frag, netmem, frag_offset, len);
 
-	if (page_is_pfmemalloc(frag_page->page))
+	if (netmem_is_pfmemalloc(netmem))
 		xdp_buff_set_frag_pfmemalloc(xdp);
 	sinfo->xdp_frags_size += len;
 }
@@ -528,27 +528,29 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buff *skb,
 		   u32 frag_offset, u32 len,
 		   unsigned int truesize)
 {
-	dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
+	dma_addr_t addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	u8 next_frag = skb_shinfo(skb)->nr_frags;
+	netmem_ref netmem = frag_page->netmem;
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
 				rq->buff.map_dir);
 
-	if (skb_can_coalesce(skb, next_frag, frag_page->page, frag_offset)) {
+	if (skb_can_coalesce_netmem(skb, next_frag, netmem, frag_offset)) {
 		skb_coalesce_rx_frag(skb, next_frag - 1, len, truesize);
-	} else {
-		frag_page->frags++;
-		skb_add_rx_frag(skb, next_frag, frag_page->page,
-				frag_offset, len, truesize);
+		return;
 	}
+
+	frag_page->frags++;
+	skb_add_rx_frag_netmem(skb, next_frag, netmem,
+			       frag_offset, len, truesize);
 }
 
 static inline void
 mlx5e_copy_skb_header(struct mlx5e_rq *rq, struct sk_buff *skb,
-		      struct page *page, dma_addr_t addr,
+		      netmem_ref netmem, dma_addr_t addr,
 		      int offset_from, int dma_offset, u32 headlen)
 {
-	const void *from = page_address(page) + offset_from;
+	const void *from = netmem_address(netmem) + offset_from;
 	/* Aligning len to sizeof(long) optimizes memcpy performance */
 	unsigned int len = ALIGN(headlen, sizeof(long));
 
@@ -685,7 +687,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		if (unlikely(err))
 			goto err_unmap;
 
-		addr = page_pool_get_dma_addr(frag_page->page);
+		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 
 		for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
 			header_offset = mlx5e_shampo_hd_offset(index++);
@@ -796,7 +798,8 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 		err = mlx5e_page_alloc_fragmented(rq->page_pool, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
-		addr = page_pool_get_dma_addr(frag_page->page);
+
+		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 		umr_wqe->inline_mtts[i] = (struct mlx5_mtt) {
 			.ptag = cpu_to_be64(addr | MLX5_EN_WR),
 		};
@@ -1216,7 +1219,7 @@ static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
 	u16 head_offset = mlx5e_shampo_hd_offset(header_index) + rq->buff.headroom;
 
-	return page_address(frag_page->page) + head_offset;
+	return netmem_address(frag_page->netmem) + head_offset;
 }
 
 static void mlx5e_shampo_update_ipv4_udp_hdr(struct mlx5e_rq *rq, struct iphdr *ipv4)
@@ -1677,11 +1680,11 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 	dma_addr_t addr;
 	u32 frag_size;
 
-	va             = page_address(frag_page->page) + wi->offset;
+	va             = netmem_address(frag_page->netmem) + wi->offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
 				      frag_size, rq->buff.map_dir);
 	net_prefetch(data);
@@ -1731,10 +1734,10 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 	frag_page = wi->frag_page;
 
-	va = page_address(frag_page->page) + wi->offset;
+	va = netmem_address(frag_page->netmem) + wi->offset;
 	frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
 				      rq->buff.frame0_sz, rq->buff.map_dir);
 	net_prefetchw(va); /* xdp_frame data area */
@@ -2007,13 +2010,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
-		net_prefetchw(page_address(frag_page->page) + frag_offset);
+		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
 		if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool,
 							 &wi->linear_page))) {
 			rq->stats->buff_alloc_err++;
 			return NULL;
 		}
-		va = page_address(wi->linear_page.page);
+
+		va = netmem_address(wi->linear_page.netmem);
 		net_prefetchw(va); /* xdp_frame data area */
 		linear_hr = XDP_PACKET_HEADROOM;
 		linear_data_len = 0;
@@ -2124,8 +2128,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			while (++pagep < frag_page);
 		}
 		/* copy header */
-		addr = page_pool_get_dma_addr(head_page->page);
-		mlx5e_copy_skb_header(rq, skb, head_page->page, addr,
+		addr = page_pool_get_dma_addr_netmem(head_page->netmem);
+		mlx5e_copy_skb_header(rq, skb, head_page->netmem, addr,
 				      head_offset, head_offset, headlen);
 		/* skb linear part was allocated with headlen and aligned to long */
 		skb->tail += headlen;
@@ -2155,11 +2159,11 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		return NULL;
 	}
 
-	va             = page_address(frag_page->page) + head_offset;
+	va             = netmem_address(frag_page->netmem) + head_offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, head_offset,
 				      frag_size, rq->buff.map_dir);
 	net_prefetch(data);
@@ -2198,16 +2202,19 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 			  struct mlx5_cqe64 *cqe, u16 header_index)
 {
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
-	dma_addr_t page_dma_addr = page_pool_get_dma_addr(frag_page->page);
 	u16 head_offset = mlx5e_shampo_hd_offset(header_index);
-	dma_addr_t dma_addr = page_dma_addr + head_offset;
 	u16 head_size = cqe->shampo.header_size;
 	u16 rx_headroom = rq->buff.headroom;
 	struct sk_buff *skb = NULL;
+	dma_addr_t page_dma_addr;
+	dma_addr_t dma_addr;
 	void *hdr, *data;
 	u32 frag_size;
 
-	hdr		= page_address(frag_page->page) + head_offset;
+	page_dma_addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
+	dma_addr = page_dma_addr + head_offset;
+
+	hdr		= netmem_address(frag_page->netmem) + head_offset;
 	data		= hdr + rx_headroom;
 	frag_size	= MLX5_SKB_FRAG_SZ(rx_headroom + head_size);
 
@@ -2232,7 +2239,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		}
 
 		net_prefetchw(skb->data);
-		mlx5e_copy_skb_header(rq, skb, frag_page->page, dma_addr,
+		mlx5e_copy_skb_header(rq, skb, frag_page->netmem, dma_addr,
 				      head_offset + rx_headroom,
 				      rx_headroom, head_size);
 		/* skb linear part was allocated with headlen and aligned to long */
@@ -2326,11 +2333,23 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	}
 
 	if (!*skb) {
-		if (likely(head_size))
+		if (likely(head_size)) {
 			*skb = mlx5e_skb_from_cqe_shampo(rq, wi, cqe, header_index);
-		else
-			*skb = mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe, cqe_bcnt,
-								  data_offset, page_idx);
+		} else {
+			struct mlx5e_frag_page *frag_page;
+
+			frag_page = &wi->alloc_units.frag_pages[page_idx];
+			/* Drop packets with header in unreadable data area to
+			 * prevent the kernel from touching it.
+			 */
+			if (unlikely(netmem_is_net_iov(frag_page->netmem)))
+				goto free_hd_entry;
+			*skb = mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe,
+								  cqe_bcnt,
+								  data_offset,
+								  page_idx);
+		}
+
 		if (unlikely(!*skb))
 			goto free_hd_entry;
 
-- 
2.34.1


