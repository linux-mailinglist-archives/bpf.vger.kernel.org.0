Return-Path: <bpf+bounces-60723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7601BADB36D
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E391882FFA
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE000266F16;
	Mon, 16 Jun 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yb9nn3GM"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4FE14F98;
	Mon, 16 Jun 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083369; cv=fail; b=WqtsGmtGv0DXBeaYB4KoeHk2B5i0mt6B776Clj3fDQDNdBMybSp/DKwmdS3y1oIIUh3VP4WY2rPPtfpmMhIG9KGcs5tP4lejDuYmHyb9pA1FW5FaHrfd9yyGF60jCpIhiqVgTIj3LpT9QF4N0SetOfBW1W5DZEvCyxnvmFGfTt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083369; c=relaxed/simple;
	bh=udq+3o5ZtYamRoeM1huBcSpYT2n1uJTiwgb8yhgZkg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJ6gwvk8/m7A5FjjY0UQM+ZsXo4+/3qTg0N/BJTGTyebRjplLBr47v+gbVs1jH+hUlHpu3+4o4MFR8GSX3nzS03xAwwy3Wi1NLefTZR6731G32MR29wSPatadlo5mCedNQr39dvX7dLQN43N8bqsJZVxUTVso0AoVfNK0JzvRsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yb9nn3GM; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMDqPs069IA7saXSAh2UShxRmsyd+aV73lDiCyRsoB5NjJVmqYdsXmpnWEbIINInLv5ZgIL7+qTJOtcRgoGL5HdYe+Jq9gpD8IOUHQEIeRDitsdiCUOnUtTbLmwWmpsZ2qmB240x137j6D+B71SnnW/8qu8KBgHzaOKMKhKSqthdaqZNrHuDzMCYGXSpAByVX09VUM353+sMzUGGfLwsAqs65OhWAwsFjal7W7Ow6f9ABK8UTvxGoE8v6MwmU/i7sLqIlV8vcrVunzUbhgPiyWkVd446N8A07skorYxuHEgCpJ4BFDwHucfbXtUbOei2xwZneMJYKhuPm+EQhKuGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsH3dcWUuviSyLvD16PIq0Dl8w+NXzoh610l+FCu6N4=;
 b=g5o3agqKNFmaxSMz7vlpifUmby0IyW/KnscCE7xHFYto7t8CUHg56tSjcMG/43D6B/FqebTEmYc8y0t7K5Gka9wrqKftUdiN0Ihp7G5+rzBPB3nMimCExilPnhG2kpJ0b5IsX2hAMDUz7jkQLizGqYFhpk5JAAJyFCF7/h1O6WwrAizxbwqKGkQYoUKs/+/G1gb8vE2tccBOC+fy0yTvmGAvRoxTTj3HnDSipLz83GHe74Sc8FftgmdnPpgL+Ea6lvE8OPQpse5u36FqaWZ/a7icgJah3aPSA2IsbkkpH4wypawlPgWVdvXv6tEtIA9Kx3cVMR4zec68BdvO5vHAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsH3dcWUuviSyLvD16PIq0Dl8w+NXzoh610l+FCu6N4=;
 b=Yb9nn3GMs/SUFWfdsvzCbHGIbe4/+xQCMO6EmIkq94ihqJa7ABVdiXcTi36ILXrmZgvHkEidGy6k/2y7ya0WM+CDNeR7CNzioMWsqP/lLEJ4ZRLMjjJQd5xE/ahqfJdPcOVugAHx8/I6OP0p64S7zQFpwiQVnDvuPTDNgB2mwBsX5UplJLIuQOaM4R0hXNgtSaXwQZ4UEz1zTOSBMi5zJuhEzRFXssKi73drGT6A/WFnOGjZy6CJIW/Lk+3tWnrynvmOKTudJmPvEtydmtSqCeHpnDkUR2u1n8ykmyEe7IdRzV6gR4nGv+rc9GBbZaPZlC6ZLFjWFs58miay6JrtVg==
Received: from CH0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:610:b1::17)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 14:16:03 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::b7) by CH0PR13CA0012.outlook.office365.com
 (2603:10b6:610:b1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 14:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:16:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:15:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:15:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:15:40 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v6 07/12] net/mlx5e: SHAMPO: Separate pool for headers
Date: Mon, 16 Jun 2025 17:14:36 +0300
Message-ID: <20250616141441.1243044-8-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616141441.1243044-1-mbloch@nvidia.com>
References: <20250616141441.1243044-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 578f584f-769e-47d8-2821-08ddace05319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AIJJVyV28BMTqFZavNp7sNov0RauTwkczaZtLjel6ESAXhMyqs2iSfD+nI3n?=
 =?us-ascii?Q?nfgDA/LUkDB7dbWTj+MIUmgJmIBgEE2u5A4bDJ4Jay7plMFAv37Xg731Wr1W?=
 =?us-ascii?Q?K0qLHeU/D8fr1S+dHdL9Jq8GVXiZsvm/Dtggpe/UkbGgx9RYsTmKxh8fnXIB?=
 =?us-ascii?Q?MZpL1xSh9ovsWLq+nfZuWLMiu87La6RL+d2e4uzktmBSOE/4PIXvKgiTfKuV?=
 =?us-ascii?Q?MSQ3nsn3BipuQqAXyzefHbwRhUoj8W/dGNXAAGT7lL3QCIgSKIjQUv9D4d8T?=
 =?us-ascii?Q?4OhCrWlzdZltq8T9GxgBDlAYxmO1AMU956pcHB3kOe0+eDf0WrHdaAXpwR88?=
 =?us-ascii?Q?sXBgzMFMecEJWdMirOgh8fbmBWlOPQkU0b4WiQXJj1HnDtTpg/d/vg+Ec+Af?=
 =?us-ascii?Q?ItXNUvWWg1hPV7CEvLGvS9MEiJtj6J6iNhPF7edUmcIDraRfL+I9KxBvaE2e?=
 =?us-ascii?Q?lRvbhPfEpCWuDM96YEtXDDxHN+mKvg97pAY7eBf+N1UFgcLFojTFVu7Mef/Q?=
 =?us-ascii?Q?jdBnukY6gLUeQxDhQXFVco7cwoT4/hqNaOOHTCC8KCZ2XTE4cyTmQ1LyZZNH?=
 =?us-ascii?Q?2HXYxkG7sQJ2L2mnmdrpFL2NQ/Uw1UIkRANV7AVMFaaHHiT4p+hPfi62Y38r?=
 =?us-ascii?Q?T7bU0ewDYkZuB+pt2V9Ss9bBJvFdNzX2uFQmaWylPu72tNWw2+w3GYubzSC6?=
 =?us-ascii?Q?xbtaIUqESLBEQAKW50gZiuXAhr7amxe7/I2mCVJMXmZSoYg8HvRsReuSWMeK?=
 =?us-ascii?Q?wUTBKbiEiq7Zv9iIxnEVsh6UwP/vvIjlZtSzcsRaxWmoC122u5flAcNsNKnt?=
 =?us-ascii?Q?X6GKLF7Eqa6Vu7wpU7P3XjBePWNFqlmtie33uT25SR0/mNs723lymV1hQtq3?=
 =?us-ascii?Q?JFliPTpVqh5foHp80rTkJJuau73ufNTGu/UC6miw3vmeHb7YukdpxC2TJ/6k?=
 =?us-ascii?Q?MaxK+DTUsamwenGs2buBgWHJ4BScDM6JH94WNL7vLU7cHPyLtB/SdEzqPu0E?=
 =?us-ascii?Q?7o5fIbH3+B9GDfjpdt1tNKYM45BDDmuJAd6UJ1+q6Kd2S2lB6utSXqwCVZGE?=
 =?us-ascii?Q?5EKC1kfMvjW94bzHMKkav/8fIpkSYcDvXmhMiBQnpNpZ9GyGC7wOmaemfkcW?=
 =?us-ascii?Q?YzgisSvJM263pj4lGYbCLnIUAV2ZOsNeBsClcPawcyzjWxpdDsVH6QzNrKHs?=
 =?us-ascii?Q?F0IyG5x+WEDOOkV+t9QMFWWxJTfPNZ9iAs/QFTWby13XHB7Si4XHTchr/ACm?=
 =?us-ascii?Q?gSzsBk2z6fEgc0RrYYIjeUeyruCiqkNhDnEI20m1SN8jgOOifRHW4uhKIwrb?=
 =?us-ascii?Q?V+9tT5ImsLqiYG0FaDoMSaw/jrNOAyWcrRuGdRUVKCNUXeU8vOpQI+BoreRd?=
 =?us-ascii?Q?Dl5PyXI4WfWjcUt0SvjtTnVHOX2EUzkTE8PhHo9OxizzMHCfrDh6dcfZKwcl?=
 =?us-ascii?Q?RxhFAT599vgT47pV/LLCJ79CYb/QwWme0zk7bp35KvMJc7M9J/Q03H5ONEk8?=
 =?us-ascii?Q?xA99lKL8054LdYdKtDN/LspYkNznXtJzJdKg?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:16:02.1809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 578f584f-769e-47d8-2821-08ddace05319
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

From: Saeed Mahameed <saeedm@nvidia.com>

Allow allocating a separate page pool for headers when SHAMPO is on.
This will be useful for adding support to zc page pool, which has to be
different from the headers page pool.
For now, the pools are the same.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 43 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 41 ++++++++++--------
 3 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 581eef34f512..c329de1d4f0a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -716,7 +716,11 @@ struct mlx5e_rq {
 	struct bpf_prog __rcu *xdp_prog;
 	struct mlx5e_xdpsq    *xdpsq;
 	DECLARE_BITMAP(flags, 8);
+
+	/* page pools */
 	struct page_pool      *page_pool;
+	struct page_pool      *hd_page_pool;
+
 	struct mlx5e_xdp_buff mxbuf;
 
 	/* AF_XDP zero-copy */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a81d354af7c8..5e649705e35f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -41,6 +41,7 @@
 #include <linux/filter.h>
 #include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 #include <net/page_pool/types.h>
 #include <net/pkt_sched.h>
 #include <net/xdp_sock_drv.h>
@@ -746,6 +747,11 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
 	bitmap_free(rq->mpwqe.shampo->bitmap);
 }
 
+static bool mlx5_rq_needs_separate_hd_pool(struct mlx5e_rq *rq)
+{
+	return false;
+}
+
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params,
 				struct mlx5e_rq_param *rqp,
@@ -754,6 +760,7 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				int node)
 {
 	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
+	u32 hd_pool_size;
 	u16 hd_per_wq;
 	int wq_size;
 	int err;
@@ -781,8 +788,34 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	rq->mpwqe.shampo->hd_per_wqe =
 		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
 	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
-	*pool_size += (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
-		     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+	hd_pool_size = (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
+		MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+	if (mlx5_rq_needs_separate_hd_pool(rq)) {
+		/* Separate page pool for shampo headers */
+		struct page_pool_params pp_params = { };
+
+		pp_params.order     = 0;
+		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pp_params.pool_size = hd_pool_size;
+		pp_params.nid       = node;
+		pp_params.dev       = rq->pdev;
+		pp_params.napi      = rq->cq.napi;
+		pp_params.netdev    = rq->netdev;
+		pp_params.dma_dir   = rq->buff.map_dir;
+		pp_params.max_len   = PAGE_SIZE;
+
+		rq->hd_page_pool = page_pool_create(&pp_params);
+		if (IS_ERR(rq->hd_page_pool)) {
+			err = PTR_ERR(rq->hd_page_pool);
+			rq->hd_page_pool = NULL;
+			goto err_hds_page_pool;
+		}
+	} else {
+		/* Common page pool, reserve space for headers. */
+		*pool_size += hd_pool_size;
+		rq->hd_page_pool = NULL;
+	}
 
 	/* gro only data structures */
 	rq->hw_gro_data = kvzalloc_node(sizeof(*rq->hw_gro_data), GFP_KERNEL, node);
@@ -794,6 +827,8 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	return 0;
 
 err_hw_gro_data:
+	page_pool_destroy(rq->hd_page_pool);
+err_hds_page_pool:
 	mlx5_core_destroy_mkey(mdev, rq->mpwqe.shampo->mkey);
 err_umr_mkey:
 	mlx5e_rq_shampo_hd_info_free(rq);
@@ -808,6 +843,8 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 		return;
 
 	kvfree(rq->hw_gro_data);
+	if (rq->hd_page_pool != rq->page_pool)
+		page_pool_destroy(rq->hd_page_pool);
 	mlx5e_rq_shampo_hd_info_free(rq);
 	mlx5_core_destroy_mkey(rq->mdev, rq->mpwqe.shampo->mkey);
 	kvfree(rq->mpwqe.shampo);
@@ -939,6 +976,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 			rq->page_pool = NULL;
 			goto err_free_by_rq_type;
 		}
+		if (!rq->hd_page_pool)
+			rq->hd_page_pool = rq->page_pool;
 		if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
 			err = xdp_rxq_info_reg_mem_model(&rq->xdp_rxq,
 							 MEM_TYPE_PAGE_POOL, rq->page_pool);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 84b1ab8233b8..e34ef53ebd0e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -273,12 +273,12 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
 
 #define MLX5E_PAGECNT_BIAS_MAX (PAGE_SIZE / 64)
 
-static int mlx5e_page_alloc_fragmented(struct mlx5e_rq *rq,
+static int mlx5e_page_alloc_fragmented(struct page_pool *pool,
 				       struct mlx5e_frag_page *frag_page)
 {
 	struct page *page;
 
-	page = page_pool_dev_alloc_pages(rq->page_pool);
+	page = page_pool_dev_alloc_pages(pool);
 	if (unlikely(!page))
 		return -ENOMEM;
 
@@ -292,14 +292,14 @@ static int mlx5e_page_alloc_fragmented(struct mlx5e_rq *rq,
 	return 0;
 }
 
-static void mlx5e_page_release_fragmented(struct mlx5e_rq *rq,
+static void mlx5e_page_release_fragmented(struct page_pool *pool,
 					  struct mlx5e_frag_page *frag_page)
 {
 	u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
 	struct page *page = frag_page->page;
 
 	if (page_pool_unref_page(page, drain_count) == 0)
-		page_pool_put_unrefed_page(rq->page_pool, page, -1, true);
+		page_pool_put_unrefed_page(pool, page, -1, true);
 }
 
 static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
@@ -313,7 +313,8 @@ static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
 		 * offset) should just use the new one without replenishing again
 		 * by themselves.
 		 */
-		err = mlx5e_page_alloc_fragmented(rq, frag->frag_page);
+		err = mlx5e_page_alloc_fragmented(rq->page_pool,
+						  frag->frag_page);
 
 	return err;
 }
@@ -332,7 +333,7 @@ static inline void mlx5e_put_rx_frag(struct mlx5e_rq *rq,
 				     struct mlx5e_wqe_frag_info *frag)
 {
 	if (mlx5e_frag_can_release(frag))
-		mlx5e_page_release_fragmented(rq, frag->frag_page);
+		mlx5e_page_release_fragmented(rq->page_pool, frag->frag_page);
 }
 
 static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
@@ -584,7 +585,8 @@ mlx5e_free_rx_mpwqe(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi)
 				struct mlx5e_frag_page *frag_page;
 
 				frag_page = &wi->alloc_units.frag_pages[i];
-				mlx5e_page_release_fragmented(rq, frag_page);
+				mlx5e_page_release_fragmented(rq->page_pool,
+							      frag_page);
 			}
 		}
 	}
@@ -679,11 +681,10 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
 		u64 addr;
 
-		err = mlx5e_page_alloc_fragmented(rq, frag_page);
+		err = mlx5e_page_alloc_fragmented(rq->hd_page_pool, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
 
-
 		addr = page_pool_get_dma_addr(frag_page->page);
 
 		for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
@@ -715,7 +716,8 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		if (!header_offset) {
 			struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
 
-			mlx5e_page_release_fragmented(rq, frag_page);
+			mlx5e_page_release_fragmented(rq->hd_page_pool,
+						      frag_page);
 		}
 	}
 
@@ -791,7 +793,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	for (i = 0; i < rq->mpwqe.pages_per_wqe; i++, frag_page++) {
 		dma_addr_t addr;
 
-		err = mlx5e_page_alloc_fragmented(rq, frag_page);
+		err = mlx5e_page_alloc_fragmented(rq->page_pool, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
 		addr = page_pool_get_dma_addr(frag_page->page);
@@ -836,7 +838,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 err_unmap:
 	while (--i >= 0) {
 		frag_page--;
-		mlx5e_page_release_fragmented(rq, frag_page);
+		mlx5e_page_release_fragmented(rq->page_pool, frag_page);
 	}
 
 	bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
@@ -855,7 +857,7 @@ mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index)
 	if (((header_index + 1) & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) == 0) {
 		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
 
-		mlx5e_page_release_fragmented(rq, frag_page);
+		mlx5e_page_release_fragmented(rq->hd_page_pool, frag_page);
 	}
 	clear_bit(header_index, shampo->bitmap);
 }
@@ -1100,6 +1102,8 @@ INDIRECT_CALLABLE_SCOPE bool mlx5e_post_rx_mpwqes(struct mlx5e_rq *rq)
 
 	if (rq->page_pool)
 		page_pool_nid_changed(rq->page_pool, numa_mem_id());
+	if (rq->hd_page_pool)
+		page_pool_nid_changed(rq->hd_page_pool, numa_mem_id());
 
 	head = rq->mpwqe.actual_wq_head;
 	i = missing;
@@ -2004,7 +2008,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
 		net_prefetchw(page_address(frag_page->page) + frag_offset);
-		if (unlikely(mlx5e_page_alloc_fragmented(rq, &wi->linear_page))) {
+		if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool,
+							 &wi->linear_page))) {
 			rq->stats->buff_alloc_err++;
 			return NULL;
 		}
@@ -2068,7 +2073,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 				wi->linear_page.frags++;
 			}
-			mlx5e_page_release_fragmented(rq, &wi->linear_page);
+			mlx5e_page_release_fragmented(rq->page_pool,
+						      &wi->linear_page);
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
@@ -2077,13 +2083,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
 			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
-			mlx5e_page_release_fragmented(rq, &wi->linear_page);
+			mlx5e_page_release_fragmented(rq->page_pool,
+						      &wi->linear_page);
 			return NULL;
 		}
 
 		skb_mark_for_recycle(skb);
 		wi->linear_page.frags++;
-		mlx5e_page_release_fragmented(rq, &wi->linear_page);
+		mlx5e_page_release_fragmented(rq->page_pool, &wi->linear_page);
 
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
-- 
2.34.1


