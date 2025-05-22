Return-Path: <bpf+bounces-58765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF2AC161C
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E79D505B3D
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F882609D2;
	Thu, 22 May 2025 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Km/dDxAr"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B361259C9E;
	Thu, 22 May 2025 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950192; cv=fail; b=Zkgauyib1LqmHaWu+9fHuwCHmur6be9WQsjwi2eSuJNFn3frPJZcLBkljTaGwtHCjAzz3HYsrmDUJsiaw6yM4NMLl0Vidb99X/ur37Jn+K2SmTLl0L0sS0HBN2Jl+nz9Q8XZdvcf7uEEgIedteTlCXMwEZvEA3tn18vcN8t1Yfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950192; c=relaxed/simple;
	bh=nXJ8Ql8zZQntpmr5uUknBZBBe5BjijiDJmq1gClUY7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfnGGV+ODb4yMs91EmkDNu+/4t3JsL6t38iyDP7/7OAfBwMSFLhbD1sWHo6BWgW/ctskb5/oZ/ZZk1B+6Vxpq+VOJfXfyTXRzlYWjjdHd4Gup3V53HCWy1+ZkhEGks6c/msHllJKoAQY4QOrnOfXsE37IcbUlo8RjfCdLyukP/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Km/dDxAr; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlCDjJTQxtA2IHXpONrGZC85ygbTgZYGov+ctLR49CsWQwpDaMWeZ+2OB5wjIqWG5BVbFTfxMJM4qVx45SLOZTIodyp0idBdmXzSyJhe4mc5fjcVM3H84XQD2UqffGUDJJt17He5ImCOY48bYDpPwQflNUho10Ati/euvotuJxYGOjbx606w1zUQ5pMslOcRrmk5yeuD7wQpGBjHHuLjbO1TqEWyJ8rmb/RnDhRhixFXFyXRTDdMxS67mUkR3TT2kdXjwgcgxxfjAvy8d4OlO3tsXaiRcp5a9OjBDeV/Ll0k7fRscsvmHDSleEoYh0tCfen9pnkybbIh9/lSQM4d5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK8Vryf2D4TbYkL0X8enSibLD0M57YIPclqjKjSHW/Q=;
 b=QfMwXNvJKHj07bo4cR8JZZ6Z3hJXR+/vNF0ksXDUQS4PlEnzVA0pgW6GzpVU56imdS8wQKL4+Y5a5M4M/ZoDC8SfViLhC4rwQZrefb8CUJWwigaOJOBBLizFLDhaYwcesSZ54K5xk9RHC2YCDw4PgLn6Sn+5Ha1IwG23FFIFwg0KkRRWPTvDflK0OJuwwaDgVg+6cMD6DwDDvHzkz2KCAvRUwMaSQ5p6oc9J26sN43v4W9h9dAgBjymmquI15Ul3H5d2B+sPVEuQv3h8wflhIQR6oDiIRzQ4jHq4KyYhymgP+LwOh1aKuSbU32sxlw3d/nALF/bu6nQtYBzQRxDq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK8Vryf2D4TbYkL0X8enSibLD0M57YIPclqjKjSHW/Q=;
 b=Km/dDxArYmpRJwgXNggLEpqkrTZidqz5MIWALm09FbXh6rKM6ZkV3uktKVR9eEjL5S5iwX71bLi71GScBtQn67IF5Zspp85MV8uhGKbXYDBLtqfJ7bFqnSKb+IE8al6mFm9DeKyiYqPhrg+ZfCnEw3zCgXWqOPrUtVcwuXMND8nTWiz/YjvQaK5kQapuozN+VUcn+DKz2VILmNhaCHlA2+cVaeQlQatxfzFI1CpDcS4P0IuiPO95Lwg5ZAAfzgE8AOkvx74J2d6okh0foLrEHQWEtl9mZln615xpIJz7MWofXDYVk8l2tISCZHlVwZYPynSkD3CrfhrxtLaqu9uO5A==
Received: from DM6PR06CA0060.namprd06.prod.outlook.com (2603:10b6:5:54::37) by
 SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Thu, 22 May 2025 21:43:03 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:5:54:cafe::fc) by DM6PR06CA0060.outlook.office365.com
 (2603:10b6:5:54::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 21:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.4 via Frontend Transport; Thu, 22 May 2025 21:43:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 14:42:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 14:42:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 14:42:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 06/11] net/mlx5e: SHAMPO: Separate pool for headers
Date: Fri, 23 May 2025 00:41:21 +0300
Message-ID: <1747950086-1246773-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 3130c1a1-9a10-4538-3d6e-08dd9979a0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jv10ckktp/YnC1G8n7c8RKo4zDfi7zx1DbV5vDqHXuSlwZqxxdEV0NTUWEGv?=
 =?us-ascii?Q?JpacCEub1f1Io79RW/NHAS6dGtv27ry4K3BVk3oAdKwLbjRAch3gmP3uny2K?=
 =?us-ascii?Q?kv5cWZLRIbB3iGGxH769tiQTwtzbeH6/LQsrruJ2WoFNEJ+XyMbDMHlRt6p2?=
 =?us-ascii?Q?TqXvJooo25D/qfSxYfUeggzjs8nvIZ1E0ohqpJHdQSYpaaVRn+MKmCobHY7H?=
 =?us-ascii?Q?5tiqTC/C0I6Bksnhcwe+Io44fIMCcyW3xSp0zKXhHE3AW9rGmtg0EOYvZhIe?=
 =?us-ascii?Q?WOq6rdEyFGZOxe41t7Jexe3hIFY/GLjILJ4PJDZifZgczVt+1ctYwNWMdl/Z?=
 =?us-ascii?Q?DL/hz2gBUIgV25yxiNEda/QVsuf2lSr6v2ocF82mvbF5vI40lLVCVIuVnUq7?=
 =?us-ascii?Q?/s3ut3fIe9XlsIhi57iE1GH+ssYwhPZV8QmYKGqvcUnag9/LTPQknDcmzoqo?=
 =?us-ascii?Q?d4nriM4oHw0frtU5zpHdt6RvLVHpz3xfttwuqAUoDifarlWgbZhZBCvIo7dY?=
 =?us-ascii?Q?lRYFXpMXwVoYPR7x/XyYF04FOKtjXoUtxW2zEg4CWp0KeRZ64DJAUmJT8Ge5?=
 =?us-ascii?Q?DGbKN1zRHTx5npoFG2QOhyW16Um2okn1NUCHnSc7bA/dEL7BOUdJhWEoaj64?=
 =?us-ascii?Q?AU38uIvcNkGgDT30XRg61L0UkmGNPk28llNOVSLdR5xHYgEIXG24GLkTmIUp?=
 =?us-ascii?Q?qO6IMkF8bQxSWyien6KBzSm1Y7Pp2NUdkEbAiA1AoAh5YY09agQFzXZxLKsO?=
 =?us-ascii?Q?spPZRP+xSjtt9P6gchX4U0YfS/u2jAgH3PeS7naD4URx6YgsLx2Q4tlja2h8?=
 =?us-ascii?Q?rGbeokalacErwoQqLV/aOeTX/0Q/rf+jll6j6nbR0r1DstlEyaZ77s4tZWLM?=
 =?us-ascii?Q?5mnd5kzPte0vpVcgoI5HjaM3JrdcrNZYjKk9NYATZN7d1xbpWWLK+au9hRop?=
 =?us-ascii?Q?yBaWGaN+WVpnohE1kRFpkj0P+0b5ZuA6UZoTuT0QcAcCL4ufnCrCs81i3lkk?=
 =?us-ascii?Q?GjXs3z+tco/fcGS4RZMHyM59AKbo5y/7HdQHJX7cW7ufGnmPKMJmPtoGfWOw?=
 =?us-ascii?Q?T6dLUX65a+QbJTcusj5VQsQbiFTIzGT0nLt3BJqXNk98+uzlDgMM6SOuZZcO?=
 =?us-ascii?Q?/zQjOJBiWGwA8+hL9yVP+Nz7F1LaGIvCUotMq9zvA8JKZnUDPJMaGabL4l0O?=
 =?us-ascii?Q?eq3Us8lkrmTBo7NhBvA+RyUKUqKyGLk3aVZzbDyc0zb5DD7FQOv1nyJYcFbP?=
 =?us-ascii?Q?y6IEXWMEJ2oEZfV0ZlFq9xNuQFlrdNFB7+L7TVhPKjfws6uuPK3VBxhiktbR?=
 =?us-ascii?Q?fuHqLEf8QwvfxsV1bVfjMl56eiFVtW7TLdYyl59apJ8mZGVCPF0xhm3SKWY8?=
 =?us-ascii?Q?8BXA4Ota6vqxgp8hIfJ6agbcM50RQW4osAPefuEMRUCoLSWGyrFlgxQA/ue1?=
 =?us-ascii?Q?Jz1B2WkPiWTlkoW7nO0jgQpXmKEKEReIyxQso2b+FZqHuqtnqtaCeiAHd5ng?=
 =?us-ascii?Q?vvm1DQIURSnqULJ+TvP74Mi79nLc5KeDGfqG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:43:02.4856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3130c1a1-9a10-4538-3d6e-08dd9979a0e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342

From: Saeed Mahameed <saeedm@nvidia.com>

Allocate a separate page pool for headers when SHAMPO is enabled.
This will be useful for adding support to zc page pool, which has to be
different from the headers page pool.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 37 ++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 41 +++++++++++--------
 3 files changed, 59 insertions(+), 23 deletions(-)

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
index a81d354af7c8..9e2975782a82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -750,12 +750,10 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params,
 				struct mlx5e_rq_param *rqp,
 				struct mlx5e_rq *rq,
-				u32 *pool_size,
 				int node)
 {
 	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
 	u16 hd_per_wq;
-	int wq_size;
 	int err;
 
 	if (!test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
@@ -780,9 +778,33 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	rq->mpwqe.shampo->key = cpu_to_be32(rq->mpwqe.shampo->mkey);
 	rq->mpwqe.shampo->hd_per_wqe =
 		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
-	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
-	*pool_size += (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
-		     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+	/* separate page pool for shampo headers */
+	{
+		int wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
+		struct page_pool_params pp_params = { };
+		u32 pool_size;
+
+		pool_size = (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
+				MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+		pp_params.order     = 0;
+		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pp_params.pool_size = pool_size;
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
+	}
 
 	/* gro only data structures */
 	rq->hw_gro_data = kvzalloc_node(sizeof(*rq->hw_gro_data), GFP_KERNEL, node);
@@ -794,6 +816,8 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	return 0;
 
 err_hw_gro_data:
+	page_pool_destroy(rq->hd_page_pool);
+err_hds_page_pool:
 	mlx5_core_destroy_mkey(mdev, rq->mpwqe.shampo->mkey);
 err_umr_mkey:
 	mlx5e_rq_shampo_hd_info_free(rq);
@@ -808,6 +832,7 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 		return;
 
 	kvfree(rq->hw_gro_data);
+	page_pool_destroy(rq->hd_page_pool);
 	mlx5e_rq_shampo_hd_info_free(rq);
 	mlx5_core_destroy_mkey(rq->mdev, rq->mpwqe.shampo->mkey);
 	kvfree(rq->mpwqe.shampo);
@@ -887,7 +912,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		if (err)
 			goto err_rq_mkey;
 
-		err = mlx5_rq_shampo_alloc(mdev, params, rqp, rq, &pool_size, node);
+		err = mlx5_rq_shampo_alloc(mdev, params, rqp, rq, node);
 		if (err)
 			goto err_free_mpwqe_info;
 
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
2.31.1


