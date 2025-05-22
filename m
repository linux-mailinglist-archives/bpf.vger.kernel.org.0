Return-Path: <bpf+bounces-58763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528F2AC1611
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEB41C025CF
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF78925DD1A;
	Thu, 22 May 2025 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f0ahD5w2"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C8259483;
	Thu, 22 May 2025 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950184; cv=fail; b=pj4cvKS6rL5jUZZeKEB9WZVskQifzpYpy8BTJIgn1GeVi/ddOaJJpTegZjV/25L2XwCuuosFdfsqpE2moBrzaXdHL59SJcTiKYjiztaj5wCMMSzdXDad1NB3/vvYvqUGK2MRvPI7wFZkGhmahL0HExa2Oc4qD9mrcvjgCciIDXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950184; c=relaxed/simple;
	bh=c0eQsJWDyzwlFtH4YGlkvRU3VSdMDrjEoPqhr6jOeus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1dXaNFDg7ce5lfAaIjziegiETkyhiN7gfquLD7+81jabeIofTptl9il9f11EbmIZXAPmwrVGtYDti9pFHrFIR18djgvd3A71ef9bh7l+uR5fRzWt3j8K0XzDRaBb8EeLiSTy0LFSrQwyOvyvdYqBtrYT5xqd2rbW9SoAXMmwJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f0ahD5w2; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pw97w6VY4VvdlEAzbzzCwAjpxyAz3Ty/QaCnTQUmsSVyGW4+Vo4BS8ThXztTNkItCgmHw6BiuEIFk8JydfqpuZ6OkR+uJM/DKs5W2p8pi2SLE1qSzpkEkrjmr+ubnsWU5uqGom/xitWxS2DkAolizGDFvTpT6Q5uxZjFa0nJimeCknxD/F8Pjzj1T+vwI57LjrTBYHPUdrwgMzA18Ubjga8yT21GARBzeYcV7J8//Cg+7Xq1fuZvf2Lp2aNqfYJ2fz6Z9Rv0Zi8SwrLgDKEBZxbsdn7kWqOjWdxkDd+NdJ7HmQKy5GhwNW0QLnafPjV0HKPkZGJdY3qBYetlIfMTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJadao//XGOysnubDZtc9hUZL1nlxO6VBUwvBU/zVUs=;
 b=UyjuB+EFzNGUqjADLL1hxUCoSnCWoaGMBYlk5tVQRvhbOr4HUmSSiGCkTo+5rcttHGBNpd6j/KgI7sZg0yZg6rpipwiuEigIvcwClxjLBWRjekTiYDEq8aosp+BXoF7UAzGLoyKKtyx6037UTowjm3tDpEjPCOV46vo3J9TiVtmYCGeY7I7Vgq1GIlzMYKXWywV9bq10G8CLOUCVU+Od38Ir+aIjTU7wFX8z/2husA3ULkvQ/tURNlu0slBdF8Efo4bSG101bZ+HgW0yRRhKh31XYo6wYiiDppisQsJK2ZXza4yuLwjw2vYPINxKex3j0Dy/pLVv8vNp/+W8XsieQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJadao//XGOysnubDZtc9hUZL1nlxO6VBUwvBU/zVUs=;
 b=f0ahD5w2dVLaIJkRvO43yh9I+AKDHf1LZgzxRczDYgO3J3Wuee9Av9nzKjFfWJ5OM1NSYTv9n4kotP39eN/QU/5P4oddWHDTndzPxDv0n577QBNw3KHPJ+KZVdSkwN++eqiYHJGyEQvmWKHJLijHp3nHppY8T/92LAO1ZIRHxxUX8Oev534ymyXT2hgyBLEIFhj4kDYs010iohl8jW3HfnZbbLhkt3AYp5dQBnAg2buwmeH6zUxb80LumMbrCBfQJEwUqVvgnK7iRd10zGaF5tFycTFG+w2N7U9xtKOnPchmy4q8XHZcREpMYOSZNDehGzOJG2hEwqk5RRGR94GlHQ==
Received: from CH5P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::24)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Thu, 22 May 2025 21:42:58 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1f2:cafe::bf) by CH5P221CA0008.outlook.office365.com
 (2603:10b6:610:1f2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 21:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.4 via Frontend Transport; Thu, 22 May 2025 21:42:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 14:42:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 14:42:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 14:42:36 -0700
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
Subject: [PATCH net-next V2 05/11] net/mlx5e: SHAMPO: Improve hw gro capability checking
Date: Fri, 23 May 2025 00:41:20 +0300
Message-ID: <1747950086-1246773-6-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f98e7f3-1abd-4545-8878-08dd99799e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?61ObhC7kxDU9Px1uQ7FfO20lGETV+egvtcnrMSQXecRR4fj1OZRsxd48VX13?=
 =?us-ascii?Q?zU+4pZXWBlQJ2TOUj+TtqfAzJAEseFsEjkMa9bw1yq1lpPHYBPnbv/R695vs?=
 =?us-ascii?Q?li/+CmNThRYzpNmfPAoSrsFU5kNJjB6u2JYeWmtA1/wYabk7ePm5OArZoHCh?=
 =?us-ascii?Q?Wf5ubqDkBnNasSh4yjumHTysmCUtrsDZ69s6d+HmxGRI/BGOHx3vxmEfGvt6?=
 =?us-ascii?Q?H6qw8xpJ4W8wTjVfrg8WmvIhU+DaMFnLk2VxaQ4RLYFBrFcs+o8dkLwxhfVX?=
 =?us-ascii?Q?d7jyEW4RnMhvSr0XaGtHfvRV3kpK5pNOWo61SaHgX8ZmiAhy/St3q58z9Opu?=
 =?us-ascii?Q?yXM5nPiAfRLwgDUqK2xMN9KzjyouW9O8OKpcJqjB4+qngpuwgP5JhNtZxT8f?=
 =?us-ascii?Q?JK04GY9K1agLnR2XcOriVhiIOYze2kxh7CysTiGf56Pg9qRZ3JNy7we0HmyK?=
 =?us-ascii?Q?18NDYqa2r8OGJNDnjF2ec5c+gxRPiE7htVB/H5B0ROshqo1BkXSlNLaBGxXu?=
 =?us-ascii?Q?AiIzrXL+R2hYzpMUcVjb7xDpj96w5EStaCnK419uWbxpLAcaoMc2JSvRwHV7?=
 =?us-ascii?Q?H+5xm9QvcCbrlAWkesNTL8t3riP36OiNzDuB/dUdE8YAN5hlGyTiQF8esJ0h?=
 =?us-ascii?Q?gSkSjoR4jskrBbQoR62+A1trI9/0ajd2Hb6Yk4gGovR5gDKlluNBfuKGogZI?=
 =?us-ascii?Q?+W11XLTPJlVKGKvqcozwv82crqW1tHxh9+KgcrQhrd59a6jg0BD7AxxJIrvm?=
 =?us-ascii?Q?Tn3kc+Z96cP639HsK3RvYqOwkM0D695dedkivS1Pd968/jjGvED2rwpm3THB?=
 =?us-ascii?Q?1lnXy8gLahKh/6uUvBf9c7g/hiS09doCMF1Y4vPD6YqKWVSWvvD6A4V6Vkbm?=
 =?us-ascii?Q?mqrAV9PAOWeAotKzbtHZROSVGu6PV/zurgckc/PZ6DTqdN3YL4O5fQsOdtsc?=
 =?us-ascii?Q?PLPg9o0in4fKlGxw9bLt7pXRfvYM2JjMnhcR7QtuNvL6olOa6YeVMgbJna1H?=
 =?us-ascii?Q?zqq9QPM3uoNtb1AD/eU+I+KzxeQtIRckQ8JM8iX5/5XYtVRSqOO9T2XNdKes?=
 =?us-ascii?Q?fWGRxZ2vPyDqFCLCy2FMRBfoA4Uger8QLV1Zx2EMZgf4Dl/N5FhDBNsAvW2v?=
 =?us-ascii?Q?jPF2qUzNLI1btc7Q30n3E2IFVPH6fPDm46l+e/oRXwH2PMtYa4rOmuCNoLKN?=
 =?us-ascii?Q?Q8/HteWeOAORR94JaqEsAhkpLVazrXcWk0xTsTauO3/waU2gUFcmiiAxdUiE?=
 =?us-ascii?Q?GStgVxVp88saiYxIYQwjquKYQj0aPYJlZZaxp7bO+HtC/6T8NBDR5//oN5c0?=
 =?us-ascii?Q?GuYZiOdWn4riVP867NGvP2SQ+g/+VyBIPG8mI26j1BXKGOk8gemb2i1s/biy?=
 =?us-ascii?Q?FdzlVjHJMnDqoCqCMvj9T5m85C/S560ncF6FpOVomXUMEJJ+BzFgmf8Z31d7?=
 =?us-ascii?Q?96mxRdV/BP59lifz2ULWxcS4WW49lCyCgr1C5FTiqcZ2vI5DzZvAJaC+Zedo?=
 =?us-ascii?Q?Po/p0OgiDol+VxVXNDRLxBLtAINHmSUXBViY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:42:57.6002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f98e7f3-1abd-4545-8878-08dd99799e03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117

From: Saeed Mahameed <saeedm@nvidia.com>

Add missing HW capabilities, declare the feature in
netdev->vlan_features, similar to other features in mlx5e_build_nic_netdev.
No functional change here as all by default disabled features are
explicitly disabled at the bottom of the function.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e1e44533b744..a81d354af7c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -78,7 +78,8 @@
 
 static bool mlx5e_hw_gro_supported(struct mlx5_core_dev *mdev)
 {
-	if (!MLX5_CAP_GEN(mdev, shampo))
+	if (!MLX5_CAP_GEN(mdev, shampo) ||
+	    !MLX5_CAP_SHAMPO(mdev, shampo_header_split_data_merge))
 		return false;
 
 	/* Our HW-GRO implementation relies on "KSM Mkey" for
@@ -5499,17 +5500,17 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 						   MLX5E_MPWRQ_UMR_MODE_ALIGNED))
 		netdev->vlan_features    |= NETIF_F_LRO;
 
+	if (mlx5e_hw_gro_supported(mdev) &&
+	    mlx5e_check_fragmented_striding_rq_cap(mdev, PAGE_SHIFT,
+						   MLX5E_MPWRQ_UMR_MODE_ALIGNED))
+		netdev->vlan_features |= NETIF_F_GRO_HW;
+
 	netdev->hw_features       = netdev->vlan_features;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_TX;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_RX;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_STAG_TX;
 
-	if (mlx5e_hw_gro_supported(mdev) &&
-	    mlx5e_check_fragmented_striding_rq_cap(mdev, PAGE_SHIFT,
-						   MLX5E_MPWRQ_UMR_MODE_ALIGNED))
-		netdev->hw_features    |= NETIF_F_GRO_HW;
-
 	if (mlx5e_tunnel_any_tx_proto_supported(mdev)) {
 		netdev->hw_enc_features |= NETIF_F_HW_CSUM;
 		netdev->hw_enc_features |= NETIF_F_TSO;
-- 
2.31.1


