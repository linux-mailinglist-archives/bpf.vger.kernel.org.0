Return-Path: <bpf+bounces-60720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E95BDADB35D
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693301889301
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8665D21D3F5;
	Mon, 16 Jun 2025 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MxvkMENj"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606F31FBCB2;
	Mon, 16 Jun 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083340; cv=fail; b=qi6pXyNMYRU0zAcq3o/hLPlKuTdEjIoh9e46c61yLah1VZHnvLFRz7xrH+OXCGAoqAfBvuhB3MlDg7v/NIayFC2w5fm7vUF9a9Z5jndl/Y4MRk8ZkgANsEBZodLDJur1fngztJjn5DBxJCq0F7gOQnJAFw02rdi4DrAR05jnxSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083340; c=relaxed/simple;
	bh=Xgx/dPfVS+Tkzxi3CaWGdOyCIJe70pIQDr2I5eF6M04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbuXHUs2t9VIqAO0jtXj8nHibq0aYtZqyp4P8gm0WdHeRGjGVQutQL4Jk3IJB6lZjw1td0VdPlB9rWVTAId5v6cQWIHW2RxlabAh1VKUDOMx0diSuctyWNtQlKbcpNC2J0dgPuV/ab+4Z6d65Dy1ywbb8+Di+BncEU9BJvXHy3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MxvkMENj; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dH3cuhOs2hkBEF6RTrqUKMRrWykzAT8WgeJ5Iy01ZEPESSq98kJ89aR8nmCglJ8UibX2+VTkgWo2A+3WxzJtJG/rleS113JQd3jRB8SpYA/1n2YYTV5grcJekzhYPH5AyUytNWTJbv0npcSFdoB3eWb/TLzg5lyp6m4CByJCj6bbhQJNTPWlZKfy5UmjA+QuMlOYTVoqdahM9yzHOsAYPHpjFgF80eGPt69pWPJRYTpxAuQ9sNPvkP219lsUvp04u1ePt4fdAjfd3TjELE3F54PjAuH4/OK/z0nktD4Dv9be7zXPcVe5JdHlCpUodtAspPiTnKHlfOSX7cGgMFpJ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZmdD+pOnRRieqlX3rygkvIpgIXGt0BMPDG4T0Q4HmY=;
 b=wOOTbhEzcc0PnqMzOzkvQbBE2K+BNn0t2y+tWrswAzzZ3oEeJZ0er0tD6DgtKJcnAcJ17VOiMMpmdWAX+sOjMnV5r7OK4Y/3lrbCDcckc8U3pU2C1lB7cqhCP0wZsGZyTrwJngdMOl7SCSiLp5IwFYE2fE9g4m5Bk1zs2ifjA4qUqSJYkdc9VwP1Qsj6dkjCNrSN+H40gyQlWBJAdPNcexRDGK7G+GibSmCRb4SLyV0DzDu7IX3cMYNw52Hn7AGeLbJSHQYmGqp8qA9mt6pG0xbKMTd4MT2X5eW68gjG8cyK2pcev0h28t0wvr1f8YObBnrJXmuKNETzXyC+pk3odg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZmdD+pOnRRieqlX3rygkvIpgIXGt0BMPDG4T0Q4HmY=;
 b=MxvkMENjdSPgLlWv/H9BmR0RXZl1tuIgBLlJVCntoY+Y4JKHd8jdB/4s2peteuki5Bl9M09Dcji5wAIGoNPxXQ5aAuMrfI+OkbK7XycOYIrqcoePStmnoklsaclkHzBEx8RQG1R9JbkjljUdhXHwc+vKQxrRs8kZK0jeqrvkOKQSy1JtiwR67fHUEEbLuozIUlp7ScjX3GVV/OZb42c6FoegJ1kJAkeubAYgjMpIPjl9bG5SZ0jkKFQodjPWNUwtLhB2An+M4jgoeN8yab90BzR+JCLolvK9JYx81ZzG1tv5P39O8ZwESKpUQGOinJynVsaL9NP74mBW2K+3ILNA0A==
Received: from CH0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:610:e6::23)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 14:15:34 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::4a) by CH0PR03CA0288.outlook.office365.com
 (2603:10b6:610:e6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Mon,
 16 Jun 2025 14:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:15:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:15:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:15:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:15:18 -0700
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
Subject: [PATCH net-next v6 04/12] net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
Date: Mon, 16 Jun 2025 17:14:33 +0300
Message-ID: <20250616141441.1243044-5-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 726a3fc4-ddb0-43e4-aab6-08ddace04290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tqYtNpD6IvubCtjVneyoSg8PHBKeBVrih8g5Zmqg52gofrUDW0oyCU7iJV7o?=
 =?us-ascii?Q?y0bcj8cE9iHfGM2U+u/SwvDTy01OfVP/uLxvidm5RgVgv8yanrsc/bWwoNGG?=
 =?us-ascii?Q?PcLTmkaXWBHdVDQQGKivsYGzWGUOdgK2h2H3twijIGKKQKscsI/W05cliRRx?=
 =?us-ascii?Q?Ve+F1sr312/jtMeMkEQoeUu+gwuiFHLD7s+dCyXt9yFoluvwISrU7YbX1gQu?=
 =?us-ascii?Q?WCY16/zkQFnkgNLNYFiVM9FbVko6tN8O6yuP6jqvxbXjSTzE5/YoVgVpJL37?=
 =?us-ascii?Q?P8F2DR9/K4JWjYpPchb0YXrS2+qBl6HZVcjVQuchBr5UQl/6cB3aaMjjHqrg?=
 =?us-ascii?Q?5SsEvbUP4nx/FLNLAW5gpvY0tXtE718TD8Hu2hMS20y/AA5fJesk1cDMs6lE?=
 =?us-ascii?Q?MHymvnlTLDV7C8kt+O0ynSxLurK7bLCrqVa9PrMlvzjMMnV0f6+pvvhxgOAu?=
 =?us-ascii?Q?TwBFBj4YqVY6eiNpSrUA3eWRLsi6a+7dCgOVcn1weJN9040rK2xckI6LiTag?=
 =?us-ascii?Q?nVACkkM413kC7ItEYKvifcTKta5otBz5R8L4qxdt8gxth0W7KGq98pLM6SFT?=
 =?us-ascii?Q?Q/jh8Q/JQp/DBC4vWda/+cGEeSILD73D03di/gV80/xJYBl+HSPIzINvMtPE?=
 =?us-ascii?Q?zfXQWqWB6++wjpDwnQxByz4tY+XC1+eEMSQtuhcPx/w6T+qzHOoTR7KJ8Lg1?=
 =?us-ascii?Q?UD+tKOX6NpEUblvcfcaUnkJZQCjJiH7EzY8pRqIgCVcKss1kpSpCMWaCBnhp?=
 =?us-ascii?Q?AN8wPxYUqiutHlKaM8MydlggW1oKoQCahWIyLYtiJwWjTairDYZRN5drx5DL?=
 =?us-ascii?Q?VRDJow2e9kr8LYQpTCqKESSdhDS/QteM8Gq1SF2Fs/RiDST/BfcTPM5iE9Fr?=
 =?us-ascii?Q?58xk6rhV2fqYQqKCECwhxRQYeXu+UY4zEbe782pu6xYzISZQIH294Xm3tAFZ?=
 =?us-ascii?Q?hx9zCsUlldSvJvFJ/89GRuHOpJ62TM2GNdYcBoCKmuqyzIchg/Uuz+PZD+Rc?=
 =?us-ascii?Q?u7tmxr+uEu2zzaPN7FhgEi5T3k/xg54pe4YR+aXmguP2ggVHBEJ7i8PlkaDs?=
 =?us-ascii?Q?o+ZrtxinOtg3rw857owFRgetnyYe431BdgvS5JabXN8ECUp2HG5KDNxEFzye?=
 =?us-ascii?Q?+QMVoMeVKHaceswaKselBNrzbEwj403ETMwlkABpHog7H0mv/MDMNihHZnH4?=
 =?us-ascii?Q?ibDR8kmDxsckl2scyJo4oEsm6UrHNqJ0R/UTmJZzk+awO/TZLTArZxF2PFqY?=
 =?us-ascii?Q?HE3WYaczKVnrcXhOe2eeruvopsB84oI26q7UfzpUTMYn7htRp7p7R5Z9uOWW?=
 =?us-ascii?Q?KfJfnT/NSX4OHKU+MpKLwMau9GxKBx5ciLrUVDt03V/4HfNvNkzeg7U5vp0t?=
 =?us-ascii?Q?ed2lWuZGbvu6Wou70VBpEPV7z+kWTNTbB7dmFlkjSb3D4K9mbY1U8LIm7V8b?=
 =?us-ascii?Q?lnHGtdPbLqpLoTt+UjFMfjj2LWkU4+v5SXDW4tW4uOu0BsvdZHV4nhFP3Dxe?=
 =?us-ascii?Q?JKoIEG5k7o0qH1dlLqbxzbasL9dnGj1kfcm3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:15:34.4120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726a3fc4-ddb0-43e4-aab6-08ddace04290
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570

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


