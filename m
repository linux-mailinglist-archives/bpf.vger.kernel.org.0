Return-Path: <bpf+bounces-60722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA05ADB365
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082D5172305
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADFF2638BA;
	Mon, 16 Jun 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q6tvQ+yc"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D5D1F37A1;
	Mon, 16 Jun 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083357; cv=fail; b=QwsrziTnF7hECoyPhrIVjgQSCrJ8WBRblpzOYcdhtVjTmcLSeonQdTvrwV2TtaQR0GhmUBhq43qM2lEIQuQi/ALzNW2ro7XC1YnwthfRSFZSVBuc3/6vSkyv4H4ge95Mj1K78IBYwAECcMgEy1IMs5Lub+L0nVGRJtjsHRUUgMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083357; c=relaxed/simple;
	bh=Y2ui4bpyi2StrG03Rxz/C3o+qK4XzXlFkCTpwgp/vNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FukQEoVnAp905iupsAu/O4YZLf+Ir38osIgfRi20/DOz+wthaRNO9jus8yNKVFiryhxtAwdYS2Gs+di3+MudLpWVSAjbdDFxSIT9T1sDw6Dp9xcKn51q5Br+6A16ipjgXQhVYJD3Covr/cDabECX8ANjADoNWGH7DL2+xs1di8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q6tvQ+yc; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GccXyFlbiEh2y8LWsel72Lqn0knJD3km3WqVnjcLKnjsL+siYYdNSEVoiIIHW3OaR1rRA1MAXBdtuPyUq5Toq2rRA9Jp223zWJf+q9vlutMDULjhaimg/IxD4FF3nJNZmoSAkuLoORhiqwejIuX29Ub6idNVpTl48uU/flM7x2zAnCgKczSpH5/+/YlOW1Ndo+qEefBFXRP0OljrGn2utOEuWAnXEYV5+IzgHEUE9LD+ZeXUOitTsm7MexmoG1EXYAiaXXbUgdO6f1OM1YCFY/rNDobFiPNHLg9bFoqEXhtLqNlXKGOn3BoXo9YcPxLNZCcAfD0m3lE7XF60jr7jOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffOldQx4EhzLumaUO4DQI/K6c9IeBAfc4wzdVLLPS+U=;
 b=vHRtXwzWChOQUCCQXfZm4QVwOOzVfuYHxdJS0ZGo2nfzINWsYwg+lMAfmGbXONWJRrLsE2H9+jwsEfSvjXjmBhBk+WjphpWFU/wX4hbF8CGtlT4aNMoS3P0Q/vOhpXticzsO+26jwi49LSH67IZCXmTW+f6BCC5U7h+QR4sq2rd8689+SM2yUqXOBNjFw6gvVVPtNpUQii/FHdtPDFaFk/RxQYSypI5LH61T7gaaMLiG2JtwtqGpZwhdV7SiEwtlPzIrYjLoe/UKdQf8oqfGrjfEQxBB7eKLcf+iPBMjLLV4ie8hKL4HWoYPivzNiKT52Ce79hkd0yVeo9WSgkvhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffOldQx4EhzLumaUO4DQI/K6c9IeBAfc4wzdVLLPS+U=;
 b=Q6tvQ+yctrSQgAovNFIc5VM8gz22ySUdHqIlM/NxemdvEF/I9l12c4v/QTqc1R7O78pdLkKMbQLIOGlK7AOcfNci+YvUS3Bi/nGmvRWipb8JOkD/eAzsLQ2zE8IVchB7/S+vffSIdXaH1Tov5Qdtp9T2gdnOnIsHnhYs9FEs5JmxFFJe4FcydTdRR0OvlOlh+H2z0R3t+Ofhf6+IzUH+hZf4Sk3G9MCvRQdF8TxCLiXTDgS+QkRA+xeJyxSQrafSlhcXQRzlOQG6/U9IsTXoASrRZeQZIc72JlNjY+ygR2fW/zaAsriTPIJlNQ0Q0AMzD+mAl9cdTMbJBYv02t/f9A==
Received: from CH5PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:1ed::27)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 14:15:48 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::21) by CH5PR02CA0013.outlook.office365.com
 (2603:10b6:610:1ed::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 14:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:15:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:15:37 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:15:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:15:31 -0700
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
Subject: [PATCH net-next v6 06/12] net/mlx5e: SHAMPO: Improve hw gro capability checking
Date: Mon, 16 Jun 2025 17:14:35 +0300
Message-ID: <20250616141441.1243044-7-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: aa056869-a64d-4b58-68f3-08ddace04afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gSbnOELVplb5LQFEPewJl/9xclRh0lGY9WTUxT3YC3iR4pbNy1ifl2kelW+6?=
 =?us-ascii?Q?BbCSHDXyNxQon/N5ubmJZwwfT8EggkW9ShyUrsm3u2ob1VODbWxVrWjK60ig?=
 =?us-ascii?Q?CxFyCOSJ3cczJlsp3Kq/CmJVSFFsoQPwYjRxC+TSpqHq7KUJmWtwzHramOrn?=
 =?us-ascii?Q?xn/SS7CZP8o27nz6s23kqAQgTRPbbLylkkEeai26Tvi8jn6BcCoskCP9Kkn5?=
 =?us-ascii?Q?2fwCXddyLS5Scr9Kk1z03Ofe6Krd4Aba78dGocghubkWHh+rIOWuouc8Hy3L?=
 =?us-ascii?Q?xQUTxVcK729J3LCo/WrqtGHgr/IfG2VWmeH4fd6gZhOIeY9h0+rNpxiqhT+K?=
 =?us-ascii?Q?cdYJ/niGFSJ5ohSMTveUj4B629sTvLqfNSty3nZd7o4xkD/ckggo8WWc6YHE?=
 =?us-ascii?Q?PJ5MHd9iwS6EUaTOye+HMiCOvMflz0G6vN7q4xrX5imiP0kO0UCkIsd9mbMw?=
 =?us-ascii?Q?T+2Zcxgh19SUcfEngSdthO5U3aADb4HW460Mg6qqSkly7JJ+B0S1TpPBg1/O?=
 =?us-ascii?Q?L1XcRjXgvXvlf42tGzM51tRBw+mUaFDHOexYLAx/EByci0hnyK93WioR5JE4?=
 =?us-ascii?Q?OK85wV9g7ZQSSvimbyo46BbJEevv6gHVvCs8FWBWaJ9BGmEjychAU7grLel2?=
 =?us-ascii?Q?XzMH++dyiLcDjY28MV4y6+HOatmKk+u41MlnkXD3qzuz6qLkX9wcdDNgRfxq?=
 =?us-ascii?Q?VUY/x3g+v8xT5l5cDOb0YlxQKMMfeP2wBLrn9I6ufu1qYI+Qi682l0N4tqk5?=
 =?us-ascii?Q?USvPIxJxzM4mXN7p4jZA77dHxOer8mQFiORUtCHp1IToqCeWYTnNT9FM2Tcg?=
 =?us-ascii?Q?hFtCPWT0jota+o8STc69CYoIq6a2bOHsbH3f3CQJCqyylI0gu/+ZATdJc5QO?=
 =?us-ascii?Q?qBYifMSwcbSFXgS5ADdgCBxy8tTTeBn8LN0R4Yp8fPfd9KCaFQjesz5fektP?=
 =?us-ascii?Q?rh0NzPFI6uPC0POZhIipVJWPnsCDI0E+HilGFFO57LllMNJac5mQobZqKcsW?=
 =?us-ascii?Q?iaZUlP9RmgNyvln3rgTWYB4Rg4NUKykV7xZOcPNg2+ytrS1RNkndAwnxYxbt?=
 =?us-ascii?Q?G+qzFTrDUfgtx5Zly6ciOizPjGYrEoR3CrKXkpqBcP1OMx6+8QvlO91PxXsx?=
 =?us-ascii?Q?Pfi2LNHbdTg5AlDOmg9QAsk/7w3/++loSFDERiiLVBEChAqtFhQFKP74XmQi?=
 =?us-ascii?Q?hPJkHFtgxm3V8pG+c4+BZswqafs8a1Rm6DYYdQkI7N6mxNmKfKN170tRsh1O?=
 =?us-ascii?Q?tOWgCM0b6d/YGLL3N8H0Occt2fzlnlQLONZ7NSmMjTrCqrfl1dYEc0zzHy5v?=
 =?us-ascii?Q?/qFzOeV4e/KWVRvZLqIInDdcF/PNApwZTghZlH94IL6KO2atqhu7sXHPD6XQ?=
 =?us-ascii?Q?ovEkrIqIYQoGG41UgvArftofVFQJf0k4Jm+1M9BpWazQDABTtxSHi/+qBWl3?=
 =?us-ascii?Q?rheKKKdQ7kz8MhSmiUdRrmp9MIGfHSl+EUM0ncJyXi8Ct0YLonxkzeY5BYNa?=
 =?us-ascii?Q?NPRmWp6rbJa8jId7YUhu1d0+2VDG9n77QXD5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:15:48.5641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa056869-a64d-4b58-68f3-08ddace04afa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578

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


