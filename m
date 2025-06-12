Return-Path: <bpf+bounces-60478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E05AD7707
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D338163C62
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAF7299937;
	Thu, 12 Jun 2025 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TY+Olkod"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90329993B;
	Thu, 12 Jun 2025 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743292; cv=fail; b=FPW02FXKJ4sK2H7mMQWjuyYU0VTJX/tGtDbI9fEm6jJEqTC1CNuA3ZMMYYviHukVZQScu+rwIxeCV3bghx8sHGIg6mAoBC5PmAQXajkZ1LcyTluL6uAGRskPi1HLI0geGZGevubLZunyKlk0YAd6JBs24uVfpVKOO965IfkPtKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743292; c=relaxed/simple;
	bh=Y2ui4bpyi2StrG03Rxz/C3o+qK4XzXlFkCTpwgp/vNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baou1gsH9wt1JWgULjH/natIWQZ6T7W9mEQ3wzjxlKoEbPGNZ/jJOgJbesEoWilYuBm/FFTpRbMKlGon0Jj5KOfJQsBdF1Yytoaa1huJGKguSSMbe0MIt6BpIKtJ084TK1Tauy8HiZemagEvomSb1prIkMGItZcExkuVxMDVHJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TY+Olkod; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIycImbEsk3GBO7juMmPu0FdZ4gY/uktIaBUxWChdLilnkbW8htwKEDHIFD7kzPm/iub5vUZvX35fkY35As7l6bg3F0LB1f3+Eycsr7ad3fnyIZ/v5+cnLYXBV9+wbtFNbRn48p39gZzPmctluAmWJhz+WzNlqaEBf090ro6OxYy8z01YxEVpnU6tlQUW7EcrDPCQ5Ni2sKo2GRXBqbWzTOSSuFf4WKLuMaQcD/fhXF57QaeRdFidUQAh4NhsF3kTQRiZkbjK2Y1O1qhd1DKBUyL2PAz1m+0tsOhnIBPoR54+6VWrDD15BONfbHbcqlArkdyUoaOnlks44s1cr4Iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffOldQx4EhzLumaUO4DQI/K6c9IeBAfc4wzdVLLPS+U=;
 b=OhGCKpjhumjbCQMU/ZNiW4LYcIhuBrICT21wmlMxqfnmAHy9NaU+wbCY0IqcQmuo3ZSHqUo2e0G6irJ+POxXsBsTFysl7Eica7EXHb4Cp1Hp2Lgfn2MmokPuQoFuUtvhdVnF4Ve7NGeJPzosIyPU6e2Z5ikBWBvFyWtmg8FZjGivxweg7wwFvZ/OkvOM8Z3E0Byc37zWEbuYU1lvN8uoBpvBU0Nu6rc3AsJ81z2MQw/Vg5RP3KykzZm0QGvuailJiABq9vHU+zh1I96STqjDlWx9+vuiiRq96XNULA9QCLLIlPOeg5oRUo42uWcinFVXinxdT/2n41BTXHgXKn19eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffOldQx4EhzLumaUO4DQI/K6c9IeBAfc4wzdVLLPS+U=;
 b=TY+OlkodIjPfG31Q0Kp7p6pfrFCBF2s2fyooulfu/Ze/gaTNN1UoWLiUaAsvmHZwHCJnH+HhlJasyi8gqr3zkptlzuyq5eOpfFHAC224DP9KYM8p940Ejf7bSluGzsnEtHerQu0pHf5Dd7z6ikJVrD8KB1X6FY/fE0YzffTzPYsOe0BGQEmaa5atb/vPgSPFskTD74Ky/LWfUHzBmAn8hDk+3QL8+aV8LGJ0zXkDMqSCWCYgd38FpAeXyxHDSkgG5sXj9lykU9qQTu8+b8iAIZ3qKYMkH+HNfov7hbR0FEwKLtNqHyRmKAYnkxvPUoL02jJdDr8cCmgQidaEycdSdA==
Received: from SA1P222CA0107.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::28)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 12 Jun
 2025 15:48:05 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::25) by SA1P222CA0107.outlook.office365.com
 (2603:10b6:806:3c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 15:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:48:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 08:47:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 08:47:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 12
 Jun 2025 08:47:34 -0700
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
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v5 06/12] net/mlx5e: SHAMPO: Improve hw gro capability checking
Date: Thu, 12 Jun 2025 18:46:42 +0300
Message-ID: <20250612154648.1161201-7-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b9fc7b-23aa-4b1a-fe4a-08dda9c88504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6xhmG2skokOypU17Xi3ugg6uSJJHqawAHtxIzBiSe7xmAiE1aMCEPlxga+DY?=
 =?us-ascii?Q?dGzn3xCu6CfqrnWCwEWbciPtoUhT00MNf3ky9DM4/h9QTCbOkDsNfs1bVL3S?=
 =?us-ascii?Q?BP+nhr7vfQ86mCmRifjLOI2q/LpaQPpX609Sho1XrOJAWhFcYOyy7lBkTWuH?=
 =?us-ascii?Q?9kaILpv+A62vTYPUltgrTCrm84lYvzlkEisETLh2PEVdweJFRf2jHhv2yt0y?=
 =?us-ascii?Q?lam4OcT8eFi/kS3Tfm5yH0doKY912UfdIzPg1g3IjZgWPFfQViXJ7W4P4hxu?=
 =?us-ascii?Q?mXHgAM4np4+Fcu3j4Hqr9s1D61S7/H8GlAKF1RoTJVuTduWtZ4KSVZzWVk6g?=
 =?us-ascii?Q?D5KsrzRDm2F1hJ1N0Bl5exPLXNVyz6pBJYhwDdXXsFgLtdzGemNkpLKiJVxY?=
 =?us-ascii?Q?9qdfCJXYaIubxK4anc7EXJyVttxzrE2UfEsQDBAe0HgaTBIiuxA4/Iqpq9ih?=
 =?us-ascii?Q?VbmUI1dBZ9H4eRrDiZrKl2xD0mgl5Pxb/o+q4756Q2M2H2FQDyNO9Ari3j9v?=
 =?us-ascii?Q?z7a8XLLV6E39sriH7PDlUgpMpD1T4xGUU7EZTJcYltN/9PLeWf9iIiIgx5qv?=
 =?us-ascii?Q?m5dm06JDHuSRE1l7wZ8+m69XFG+jKixIdHfV+NU1YK55RUTxAgMUKvmBsjs5?=
 =?us-ascii?Q?l6aA6HZgj4RF4hRc8Z2szJSkU2L5KJJQ0/4PdpyYJaEaAQmFhx0l+gjXMA3Z?=
 =?us-ascii?Q?FaWZxmmsy65/4N3afWKvPY4w8C6VMl8C/mR2wMXUhsZ+LUww0eS942HC7WCy?=
 =?us-ascii?Q?LDOed0ou9OtXKuUd9+Y5Lrraplsxf9WTVL6JLC5C3Y2A4s6aVYXroA4gH7RH?=
 =?us-ascii?Q?cKTexkr/XMOZzvmAakw9x1aP6INON5AKZp00xNmCSuvdFyTKTdTjKQJpZmmn?=
 =?us-ascii?Q?nadgegg8H63GvgWM6w7Yn/B7KQ4hguPSV5stsGPrGEmrBzXREA16auC0DhKz?=
 =?us-ascii?Q?59dLBUJ6B0VYr6WxphrPjkNLsYy8QZ6O57kluOI8sWUoMkMkTb0u5vSuyxr1?=
 =?us-ascii?Q?f9AbxNG0NzZV1bTQZOAT+3T+F5CmSlRShX/oj2K//dF7ze4R2ATfzc+q4hTf?=
 =?us-ascii?Q?I+PoANjsWadhPszknTKnQrX4rL9Ih5jwpEjeDU5BSrxHAeIjayPlPEjGjlh4?=
 =?us-ascii?Q?irOB1wWzXiQ4WwyvPe5+q7kvUtKbY+3+qULc3K1H1HiKaiiGuQo7B59ugjhT?=
 =?us-ascii?Q?B/opQ4TcXs4Yi/vLv2gP1WtL0vLSIlYXUj6DJgmRCGq5HpvzWo2Y3k+dHZUj?=
 =?us-ascii?Q?ZUrRDrFOsZs9j20ZK7bO5niXKlcA8DqaG2jk/Rxb2HKUnbdpU8BrodW6WW7O?=
 =?us-ascii?Q?EnvhHMCQSW4UvmUUcDYbtQb3lgKTTDGwexiuF9qns717prl9Fc4yOLI4QiJa?=
 =?us-ascii?Q?JZpaYCksHYAgERdntZcKkZ/wAo59rP9biXQ9ycQtsAOLXO0nA66rUI4n7Ciw?=
 =?us-ascii?Q?9bympz8gpFJ94uOjWLfcwhlm1N7LLSIn0Wb6OTKII74onAF7OYti5P2+2Oes?=
 =?us-ascii?Q?vYEpd7bR3xOadTJrhYw6gLHVK6ck2ap7ZPGK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:48:04.5082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b9fc7b-23aa-4b1a-fe4a-08dda9c88504
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523

From: Saeed Mahameed <saeedm@nvidia.com>

Add missing HW capabilities, declare the feature in
netdev->vlan_features, similar to other features in mlx5e_build_nic_netdev.
No functional change here as all by default disabled features are
explicitly disabled at the bottom of the function.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
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
2.34.1


