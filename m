Return-Path: <bpf+bounces-60056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A4FAD21B2
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622E8188EF56
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8569021B8F5;
	Mon,  9 Jun 2025 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KKUflZIq"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516C11A2380;
	Mon,  9 Jun 2025 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481169; cv=fail; b=Xj5rIKjKGQxsijmtO07yivRLIyy4qRAi0lh3dkidpe1i9YD9o7BoR+LQww33UN6evxU9eTKE5jt/y/wEbe568EGs1qWUOYxM8MxZK48uLk9vugtXmBOb9D+ulGAnB4kh20xtoodhVa8vUBY5pDTmoZVEiH2Qvnnh5WPFe2IIsVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481169; c=relaxed/simple;
	bh=Xgx/dPfVS+Tkzxi3CaWGdOyCIJe70pIQDr2I5eF6M04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVM/VER79bucCBrkELg/lJ1mQ29Deydr8G0RzT58N9kawkK9OXp9s16aIYuZEeg9iXAY0c3sd4f/Aoa31u9fSJB++DaKyvAppysK/omBfPY2+uDi8bI7HkghiL2w4qijOrbvTOJ13So3ClnPlDC294XBtAcYZIDmf7bMMXYJYLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KKUflZIq; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VG5z9/48ZOCtd42vqIEBkgOQiNpASleTP6LyyTgeKsQdItZYtfJTNugcVL+mV4VbzvsbYMrGjkw9F0B1vVXzvP8mTTQbLboKwvCvpqE7ljlzZXRsCsGvn8BzA32ALWwJ1uRo+0vzWpiz2Eci6KQcsuPJ7ycmoYF1PQ/+cASkxcvYiJVTfzwrG7+ol4PhbedEw6AUivQKts0xT1h54D8Bn1dWtpO+Ek27fM61O0DTXV1gRs+19o4LmbxItlwW8KPMYyz7xv4mapqS64K/7/v/cuCdH8gTmTtJPYkI7IvzYAX1g+TFgx7gH5Vm9TGaoDvGyTknf9N6QARz6BdAdJYuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZmdD+pOnRRieqlX3rygkvIpgIXGt0BMPDG4T0Q4HmY=;
 b=RfA6XhroCgdaz6vpgPIbPsEnZVOihZhxzM/31h4I80Qb8IcV63+uhzN+qrfHzglDplO6XfRORuxedrj1PWkNs4GRllsGMPcP2B9X/gsjQ05t1anOnEXfIRyNhfSNqbIMD0fxnSoyhjGblRj8m5xFle/FKD3eouKyIGqPCn476EyIeIR4vcJjhNQf7tShl4LFaj9jOmYOMx4l4SXeiKhiFIm30J9r3Zllzuq8xTZoDqSY+0fWoM8xV/rwrf+Vxla69Bytf1MdAQ+sSGzAMIpZlWBVft1mgFbnEvNR3ul9TMfMkpx0gzGBp1vdw/PCBriSFJEYpIHNMY607ttITzcUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZmdD+pOnRRieqlX3rygkvIpgIXGt0BMPDG4T0Q4HmY=;
 b=KKUflZIqExlQkCypAuB/c1vEYPdUj/ZwuBrNVAxb2uTXgd5ukcOKg/FaFvtgQcUpsQ7SPcdQgbA9PIttaary8S+1ma7Wbe6r6ls1HkRCe5kMNEMKzEIQrES+pYGhAXZ3hLkzRP+AbhUvg+E5pWK5FyNjl9MvqZcujJtMLNWN3qXiAxphv4fPNTir38LQ8MFhy/0QwRxLYS4tIt8uJXEoOlhynmOLmGv2eHaM8ugIEDy0pWlqRkDaCxAjDeeowflFPQnTzJoWVEiWFGqjeXwoc/XGEgOVg/iqlS1dGuKT6SdFuKvXsBqhvhiMEtQS9iHEra+fCanrG+nBEGRynnvpvg==
Received: from SJ0PR05CA0097.namprd05.prod.outlook.com (2603:10b6:a03:334::12)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 14:59:24 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::72) by SJ0PR05CA0097.outlook.office365.com
 (2603:10b6:a03:334::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.10 via Frontend Transport; Mon,
 9 Jun 2025 14:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 14:59:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:59:03 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:59:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 07:58:57 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Simon Horman
	<horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 03/12] net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
Date: Mon, 9 Jun 2025 17:58:24 +0300
Message-ID: <20250609145833.990793-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609145833.990793-1-mbloch@nvidia.com>
References: <20250609145833.990793-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 31fd67c6-79c3-4f18-1451-08dda7663901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uZO51XMHVKixU+H1dep4LZB2DmjPgLBsp3HaHKHnLHaOUj1gatoqWm2IU/jq?=
 =?us-ascii?Q?CLMNQ2Ct4O/yP5ZUGMTfe2AxaPio5q0RAQEpVsnOc4iNyUgRy4dnCb9m5lVu?=
 =?us-ascii?Q?nE8Quxs3r4+aQIN+XZwRaXxdpDpDauYb8AMARN3WNN9Jbhw8izRL+ZE16SnV?=
 =?us-ascii?Q?d6YLxCsradYVLvc/Jz1bMgdufoS/f16/jTmhvvXYZNpCyoWfuJ9m+KHapuaP?=
 =?us-ascii?Q?8BmktsjgSIRJxFwvEArmMluIbSiJXS4kqongwIp52LwPvfauYNwzVkmBxmXR?=
 =?us-ascii?Q?NyyGnhIIM5sRJ6mj69eCizFxzK9RNaL/Q/tD+eaILHWd8Z+hp6aB1UtmXJg2?=
 =?us-ascii?Q?CSUtWHgkaK0b54jfIMgHhnH7vTeYapnaaNQs6R5C0fYADZCrtmKab606c5Yh?=
 =?us-ascii?Q?oROpRt5jWN4dlpCDJisPfx9YrOad5e6BegWfyCqndn41TKV3fqUeE0L85fgD?=
 =?us-ascii?Q?KH81xiddeSJ6VeQ4IwLbL1w4XhJavYs/3iJq9iuGTQJ0UZn2765e74v0ingw?=
 =?us-ascii?Q?k+L14Jttj6ZNTwDEHPGdscfxe3EBmuERWkYSXNrgQlwUQVLU+ygtIXmkxIKy?=
 =?us-ascii?Q?COn4KFG4bgqjul264xkKpoplRai9lpHP6iYH0s2gw032STcZcmjXvvbskhm+?=
 =?us-ascii?Q?9sRH+gEkgjoCfiNAbqGxIF1HH5ymSTAswAfDdGnkEyCgWchR0Emg77W6V5/n?=
 =?us-ascii?Q?t5ifc1by6iID1NRYq1R62npI+90PISbXiqg5WEbFa6NmkgJLe0WyzRq5JvCy?=
 =?us-ascii?Q?P3saGHKe52DqzLX3qHL7aCTumx0MdhrTXq9Vmj2mjkB0YLbI997n9Q3Dcs84?=
 =?us-ascii?Q?iaBI2OkGfmguUC0q3Pmcsq6VIoA4omc/wHAtBd9AN5uI/q3Bd5SchPlvKEau?=
 =?us-ascii?Q?oEmvsD4OYrYo4nJNdOjyAT3vxqg/FHUFag+eVZmAOsrBoaAwdSGSJTK9LCJu?=
 =?us-ascii?Q?FJLm41SWiFim4WhRV1rRZTmQMK1fCmlC6peALuB3N6FXAzTQyNmrLEO8piQT?=
 =?us-ascii?Q?qByyGZC7CYijRqe8PKdTYUDPvMb0ZTOkhnTVlbx9bMeY8gb5cccr8dW1+iDQ?=
 =?us-ascii?Q?h5weX+NQSrZv6JXftKK28wNlggQfSFko198smZX/oWQhLgI5NwRClBxegUpW?=
 =?us-ascii?Q?vpOwF/oyxtQChoOnHOy+ZkzESanGJyKUXj42/5YcgLUqW61TmHtoFFF2FTNa?=
 =?us-ascii?Q?UurZ9o4t82L6xO2PssGpn0du8xvModx5Y586GjWgyQBw+0PS/zt7cEn0RyFZ?=
 =?us-ascii?Q?zAXtmPcR+keKLJVMJjOQBAuXsCLwOzMj/fU0aXqfiZx8/6AnWoLkYZ1kDY59?=
 =?us-ascii?Q?iarO8oPa5JHNPrZR2o2r0l2pbc6/mOpWsT/W57TfSk6Jy1MihV6nwkMNxB3U?=
 =?us-ascii?Q?yGv8dlJqSbU3R0p0k4cViVhK57g15kMT1garZu6HFhX8xTTX81dZLlYt56Ld?=
 =?us-ascii?Q?QRCpIfzu7b7yYot9OhDyfoefzEPsruYb88aXPQiWvq1oJ7t0cMaol3n97mzQ?=
 =?us-ascii?Q?2ToxMIGllByRK9NMAtqXO4umcVJhQ7tOgqG/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:59:23.9976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fd67c6-79c3-4f18-1451-08dda7663901
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196

From: Saeed Mahameed <saeedm@nvidia.com>

Drop redundant SHAMPO structure alloc/free functions.

Gather together function calls pertaining to header split info, pass
header per WQE (hd_per_wqe) as parameter to those function to avoid use
before initialization future mistakes.

Allocate HW GRO related info outside of the header related info scope.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 135 +++++++++---------
 2 files changed, 66 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 5b0d03b3efe8..211ea429ea89 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -638,7 +638,6 @@ struct mlx5e_shampo_hd {
 	struct mlx5e_frag_page *pages;
 	u32 hd_per_wq;
 	u16 hd_per_wqe;
-	u16 pages_per_wq;
 	unsigned long *bitmap;
 	u16 pi;
 	u16 ci;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ea822c69d137..3d11c9f87171 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -331,47 +331,6 @@ static inline void mlx5e_build_umr_wqe(struct mlx5e_rq *rq,
 	ucseg->mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
 }
 
-static int mlx5e_rq_shampo_hd_alloc(struct mlx5e_rq *rq, int node)
-{
-	rq->mpwqe.shampo = kvzalloc_node(sizeof(*rq->mpwqe.shampo),
-					 GFP_KERNEL, node);
-	if (!rq->mpwqe.shampo)
-		return -ENOMEM;
-	return 0;
-}
-
-static void mlx5e_rq_shampo_hd_free(struct mlx5e_rq *rq)
-{
-	kvfree(rq->mpwqe.shampo);
-}
-
-static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, int node)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-
-	shampo->bitmap = bitmap_zalloc_node(shampo->hd_per_wq, GFP_KERNEL,
-					    node);
-	shampo->pages = kvzalloc_node(array_size(shampo->hd_per_wq,
-						 sizeof(*shampo->pages)),
-				     GFP_KERNEL, node);
-	if (!shampo->bitmap || !shampo->pages)
-		goto err_nomem;
-
-	return 0;
-
-err_nomem:
-	bitmap_free(shampo->bitmap);
-	kvfree(shampo->pages);
-
-	return -ENOMEM;
-}
-
-static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
-{
-	bitmap_free(rq->mpwqe.shampo->bitmap);
-	kvfree(rq->mpwqe.shampo->pages);
-}
-
 static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
 {
 	int wq_sz = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
@@ -584,19 +543,18 @@ static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq
 }
 
 static int mlx5e_create_rq_hd_umr_mkey(struct mlx5_core_dev *mdev,
-				       struct mlx5e_rq *rq)
+				       u16 hd_per_wq, u32 *umr_mkey)
 {
 	u32 max_ksm_size = BIT(MLX5_CAP_GEN(mdev, log_max_klm_list_size));
 
-	if (max_ksm_size < rq->mpwqe.shampo->hd_per_wq) {
+	if (max_ksm_size < hd_per_wq) {
 		mlx5_core_err(mdev, "max ksm list size 0x%x is smaller than shampo header buffer list size 0x%x\n",
-			      max_ksm_size, rq->mpwqe.shampo->hd_per_wq);
+			      max_ksm_size, hd_per_wq);
 		return -EINVAL;
 	}
-
-	return mlx5e_create_umr_ksm_mkey(mdev, rq->mpwqe.shampo->hd_per_wq,
+	return mlx5e_create_umr_ksm_mkey(mdev, hd_per_wq,
 					 MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE,
-					 &rq->mpwqe.shampo->mkey);
+					 umr_mkey);
 }
 
 static void mlx5e_init_frags_partition(struct mlx5e_rq *rq)
@@ -758,6 +716,35 @@ static int mlx5e_init_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
 				  xdp_frag_size);
 }
 
+static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, u16 hd_per_wq,
+					 int node)
+{
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+
+	shampo->hd_per_wq = hd_per_wq;
+
+	shampo->bitmap = bitmap_zalloc_node(hd_per_wq, GFP_KERNEL, node);
+	shampo->pages = kvzalloc_node(array_size(hd_per_wq,
+						 sizeof(*shampo->pages)),
+				      GFP_KERNEL, node);
+	if (!shampo->bitmap || !shampo->pages)
+		goto err_nomem;
+
+	return 0;
+
+err_nomem:
+	kvfree(shampo->pages);
+	bitmap_free(shampo->bitmap);
+
+	return -ENOMEM;
+}
+
+static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
+{
+	kvfree(rq->mpwqe.shampo->pages);
+	bitmap_free(rq->mpwqe.shampo->bitmap);
+}
+
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params,
 				struct mlx5e_rq_param *rqp,
@@ -765,42 +752,52 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				u32 *pool_size,
 				int node)
 {
+	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
+	u16 hd_per_wq;
+	int wq_size;
 	int err;
 
 	if (!test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 		return 0;
-	err = mlx5e_rq_shampo_hd_alloc(rq, node);
-	if (err)
-		goto out;
-	rq->mpwqe.shampo->hd_per_wq =
-		mlx5e_shampo_hd_per_wq(mdev, params, rqp);
-	err = mlx5e_create_rq_hd_umr_mkey(mdev, rq);
+
+	rq->mpwqe.shampo = kvzalloc_node(sizeof(*rq->mpwqe.shampo),
+					 GFP_KERNEL, node);
+	if (!rq->mpwqe.shampo)
+		return -ENOMEM;
+
+	/* split headers data structures */
+	hd_per_wq = mlx5e_shampo_hd_per_wq(mdev, params, rqp);
+	err = mlx5e_rq_shampo_hd_info_alloc(rq, hd_per_wq, node);
 	if (err)
-		goto err_shampo_hd;
-	err = mlx5e_rq_shampo_hd_info_alloc(rq, node);
+		goto err_shampo_hd_info_alloc;
+
+	err = mlx5e_create_rq_hd_umr_mkey(mdev, hd_per_wq,
+					  &rq->mpwqe.shampo->mkey);
 	if (err)
-		goto err_shampo_info;
+		goto err_umr_mkey;
+
+	rq->mpwqe.shampo->key = cpu_to_be32(rq->mpwqe.shampo->mkey);
+	rq->mpwqe.shampo->hd_per_wqe =
+		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
+	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
+	*pool_size += (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
+		     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+	/* gro only data structures */
 	rq->hw_gro_data = kvzalloc_node(sizeof(*rq->hw_gro_data), GFP_KERNEL, node);
 	if (!rq->hw_gro_data) {
 		err = -ENOMEM;
 		goto err_hw_gro_data;
 	}
-	rq->mpwqe.shampo->key =
-		cpu_to_be32(rq->mpwqe.shampo->mkey);
-	rq->mpwqe.shampo->hd_per_wqe =
-		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
-	rq->mpwqe.shampo->pages_per_wq =
-		rq->mpwqe.shampo->hd_per_wq / MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
-	*pool_size += rq->mpwqe.shampo->pages_per_wq;
+
 	return 0;
 
 err_hw_gro_data:
-	mlx5e_rq_shampo_hd_info_free(rq);
-err_shampo_info:
 	mlx5_core_destroy_mkey(mdev, rq->mpwqe.shampo->mkey);
-err_shampo_hd:
-	mlx5e_rq_shampo_hd_free(rq);
-out:
+err_umr_mkey:
+	mlx5e_rq_shampo_hd_info_free(rq);
+err_shampo_hd_info_alloc:
+	kvfree(rq->mpwqe.shampo);
 	return err;
 }
 
@@ -812,7 +809,7 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 	kvfree(rq->hw_gro_data);
 	mlx5e_rq_shampo_hd_info_free(rq);
 	mlx5_core_destroy_mkey(rq->mdev, rq->mpwqe.shampo->mkey);
-	mlx5e_rq_shampo_hd_free(rq);
+	kvfree(rq->mpwqe.shampo);
 }
 
 static int mlx5e_alloc_rq(struct mlx5e_params *params,
-- 
2.34.1


