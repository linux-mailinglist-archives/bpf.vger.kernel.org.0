Return-Path: <bpf+bounces-75779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C10C94D7B
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 11:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21C5B344E6A
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 10:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D16279DC9;
	Sun, 30 Nov 2025 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X2FIx+4d"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0772426CE2D;
	Sun, 30 Nov 2025 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764497662; cv=fail; b=Ay75we9703O9FjLXMQ+8c8/kX/AZ31iv9UzdejpJvnkf8cI7MBh7PU3Tyk6zlgGK2eAAvUDxoEwJKnuTTKLa8RSRnS8dFee2tEd1FbEvd3PL9wPBFlftJmmD6Q7Ap31CB1kQhXFZbpPoCNSnJChMNYB+VZcBidN0xSvP7QcghJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764497662; c=relaxed/simple;
	bh=/mKm2eioAZaGPFc6j9NE6Vx4sivv/R8pnoqfbO5S64Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdWuFJPcHmyP8kxDwTluuBzejqc7pxb5tnUqsXiaf6WVpv5EutdNr6fHJdxrAULz/CZn6S2sql0PtJz7Cj4mtx9BmECwCY1qYDwZ8Ayr1fpnnJ5tJZIyv172p5F4vbyZ4l1M+Y3UxCzME6ueqVe5mteU6h9Lx+TIouh6l5aIbVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X2FIx+4d; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqYfLq1sfwBGdny6YSoGYt3I5CGr28D7OISboKW3lvGv6IbVaWpDXaoZlT7vkhbBurhOfYNQkZdgkoE+bh+AgZCaUcRWeFf/3rXp5zKgZK2rzkKZ6r7TgnTyn3NWR5IYgYsIX8a+kO3EaLmu2+PHRjR9jE2QltT5hoXiqvQ/19G+a0akMYwSX8rzlDyhg4EeSICFk7A04AnKrHI3dGi/ErYM7EhBgwn6cG8kopbK76wIaVU6ZPbLcrJNYKXqRseatnd1ojKMTR8ryBbgSiLqJA3dEwShtVtBN+eZIe+KugX64lYYlIO8hYZ7aXaHiZlo90gA7draXcwlDq2AivQFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1I/XDqHC9KiFCT3vfFy1JHesJ01f4oV200WWWA8S+MU=;
 b=Iw4xCY+ruZzHADTAJPn2MCR50tSvj1UIPNJNZVQOxDQkffpZ0ofd+rhqAl3aGMPvFbP5CBPbAmV9D0WHo7pqhDcv8wez2OhNTlhUKgjOccZdBv5z9Qxnd/qoKfGzyYuXC7VnZzfZBvHjYJVRPVSbEmO09eNV3ez3lJRkkxlWeWxdRgJ4087ZAylPiDYvZwJnAisB6ETn07VIe4Yjz0dd6BD4irQ1cwYIFmWsJbJSKJF1HHhzSTYDf/SRJkdT7olVvBcOG5woW+bB9mM3InBNuG2ixjUnC6Aph+GUv5mRZXLbRaTmqwZxHB80/bMbihciczJ8Mml78TsiFUPdHHKrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1I/XDqHC9KiFCT3vfFy1JHesJ01f4oV200WWWA8S+MU=;
 b=X2FIx+4do92KlStmpAZvea5gS/Ch/4ltLAi0VLR23mWfgF1w0RW8da9wqvSeH7XZoc9ZLRmnRWFvn//AJdJm1NIdeIsCeFrls5aFMKY5hBJehyXRCqbO7tKgTta5NgmXAd+SqrYdrwYgDQVAOkSj/Iv8LKePLtkqWOV3PLn7eq313Jr2yqsOr5HMZ4tOPbmMLU4C462aa5K2O4bE7/oSk8Z89qHqWIarhJSDXK1JzjyiShopcAkKc6Jpv/Y6rR34Az7kWQyPGDXZ/gOFSL+D9gA/gEAnoe0z4bJdAN7P+5uj2XoIVmIf9mGoi4rl3m2IJjckkBr3yWhreGBaa0CSXA==
Received: from BN0PR04CA0173.namprd04.prod.outlook.com (2603:10b6:408:eb::28)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:14:15 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::37) by BN0PR04CA0173.outlook.office365.com
 (2603:10b6:408:eb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sun,
 30 Nov 2025 10:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 10:14:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:14:03 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:14:03 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 30
 Nov 2025 02:13:56 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, William Tu
	<witu@nvidia.com>, <toke@redhat.com>
Subject: [PATCH net-next V2 1/2] net/mlx5e: Update XDP features in switch channels
Date: Sun, 30 Nov 2025 12:13:36 +0200
Message-ID: <1764497617-1326331-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764497617-1326331-1-git-send-email-tariqt@nvidia.com>
References: <1764497617-1326331-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c722284-2720-4921-6b35-08de2ff936f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4H3pjZqNcIpVJ7ppR/SB8tGSN8i9Ouy3mnRJ7XCQY0AanfQxm6Z+bYbN35dl?=
 =?us-ascii?Q?Epg3yDTi8P+soOGqASOoDOpDWDI0wcja6mMw8hdMEoviRDigsyAMv9a81FdI?=
 =?us-ascii?Q?ZV6TVlhlyozWx3WdvyyJCNtnbN3WF93gPl/nGlLIUwFtd+KCPWCq9A+qMR6P?=
 =?us-ascii?Q?ZDLkW5FdI1PinrLvuJStcIOJ90Fnv/EV4jP2UJfRXAjmXxkNJuHKlnkwX5TQ?=
 =?us-ascii?Q?hmQLorHBzXEpwU1J0u3NQksQY5ss8k/lmCUnS6nlLYiMCKfNB7AR1jAzpNaM?=
 =?us-ascii?Q?fi1b2r/9CW4P6SeSrIcLw4efPCa6o0AaThihIqzVBrSdH/1BsEznm2VjM4Pc?=
 =?us-ascii?Q?YPrbYt4f/EmBQpKdteM/othVtcgiJJZcqbTfwi7F0xYBCEPGQ6nBTwz7srOY?=
 =?us-ascii?Q?C/8VFa9ueJSdc2C4JwdbxHC3mtaEcdB3AxPx8DhD2MfKQKoIRKYpLIyfmoUw?=
 =?us-ascii?Q?PF2nRXoE/XCTKaQQS2al8Ie/B12j0AzIPgMLYZxOJI4enDhB7xchv9dBM2SA?=
 =?us-ascii?Q?K3pgwR0AiE/6ZEgvisg11apg+hgqfeFZcBNg/3umc/K54Vb8LnuCAc7sVSxE?=
 =?us-ascii?Q?uoMP8dkxRqxKqpm2V9UF+qCF9qKZt6xOvjxSuq4qb2xOjk5ms1IGZH9DBdHC?=
 =?us-ascii?Q?ZBieQBkSJYROCRvxA8fspjx+TqQqaPfA1la61RzqF8zkTF0WyxvUZ1hEDXTc?=
 =?us-ascii?Q?e6+mJTC6Yxkmd2/w3F2SnZELXB9m/kj89iUKipaC7uWnin8jcZ1D4C15X0a+?=
 =?us-ascii?Q?FmFjvvpRDgtN9tjh6No6skLiePfc3xUnR9DemVMfTAfq3eXhVgQmCK4KEkzc?=
 =?us-ascii?Q?exzTSaufGOOgoC9TcNAfjEULzqFfeNyAzMIZRJYyxmvKYcpC8xvQGf9hR4Hi?=
 =?us-ascii?Q?r4tJ2Fs9XBmi/uYyBqIiXd/yeUv8v41oNxnmbX4DxhfkQCnc/KLRZ4+nJub8?=
 =?us-ascii?Q?5Pbv/LznL7XsKKEOomsd+TS5yvFj2XAiCXKI0RmrRrOjsAoV3VBorkJcNPh7?=
 =?us-ascii?Q?SQNWge2qssQEnvWxdQZfcmfWZAqhIv+5z4BfBBK5Z02h/fXr9gyDmaHT5P8D?=
 =?us-ascii?Q?45AfzNZfYGcOILSSW7dMakGhL07s/Cv/GD66MdNBRhEPKOgqGW1xzMJW66LK?=
 =?us-ascii?Q?qwQf6B7UQ5XFQF38bc9GY1GP2K3/gzYuRm9K4nnSFgNhZzDEXrdxH4abkZgl?=
 =?us-ascii?Q?mT1FZuyzKxaea4HMYzuNkYXyfgcfLtxubcdXPWfA5Fq2O0JEbcohAJOm3wEi?=
 =?us-ascii?Q?EO2+lhXdiNVgV5zp3YjH1/6SKd6wgaCdAC5fax7YfUgMsPNHfyv32aQcexZM?=
 =?us-ascii?Q?fz3f786RKQ+W2Jqr1VjsUiUEho4FLZOhZaykERjh/OPYK1ZE/WUSwJ2YA9zZ?=
 =?us-ascii?Q?qbODjXpvpFEVi9oSsM4aSdR7ndwvZ3B8uS1slBtZA+5B1SIO7fOhYu5zg/ai?=
 =?us-ascii?Q?6VHWAZNEYPqmI9ASmbO+Immcv9dgReBSpNTsPOJRsuUrqUILG+rsFxGyp+TP?=
 =?us-ascii?Q?noeBvHI3YTPlX39RQ8AfnQlpQVrBXHJpioIWZrCkSnUKfvkCMALkVCaJZfCv?=
 =?us-ascii?Q?5wacCq3pfURCnmRF/tM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:14:14.6336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c722284-2720-4921-6b35-08de2ff936f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176

The XDP features state might depend of the state of other features, like
HW-LRO / HW-GRO.

In general, move the re-evaluation announcement of the XDP features
(xdp_set_features_flag_locked) into the flow where configuration gets
changed. There's no point in updating them elsewhere.

This is a more appropriate place, as this modifies the announced
features while channels are inactive, which avoids the small interval
between channel activation and the proper setting of the XDP features.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h        |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 10 +---------
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c   | 13 ++++++-------
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c    |  2 +-
 4 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 3ada7c16adfb..811178d8976c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1249,7 +1249,7 @@ void mlx5e_netdev_attach_nic_profile(struct mlx5e_priv *priv);
 void mlx5e_set_netdev_mtu_boundaries(struct mlx5e_priv *priv);
 void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16 mtu);
 
-void mlx5e_set_xdp_feature(struct net_device *netdev);
+void mlx5e_set_xdp_feature(struct mlx5e_priv *priv);
 netdev_features_t mlx5e_features_check(struct sk_buff *skb,
 				       struct net_device *netdev,
 				       netdev_features_t features);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index fe67c73849f9..d3fef1e7e2f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2294,7 +2294,6 @@ static int set_pflag_rx_striding_rq(struct net_device *netdev, bool enable)
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_params new_params;
-	int err;
 
 	if (enable) {
 		/* Checking the regular RQ here; mlx5e_validate_xsk_param called
@@ -2315,14 +2314,7 @@ static int set_pflag_rx_striding_rq(struct net_device *netdev, bool enable)
 	MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_RX_STRIDING_RQ, enable);
 	mlx5e_set_rq_type(mdev, &new_params);
 
-	err = mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
-	if (err)
-		return err;
-
-	/* update XDP supported features */
-	mlx5e_set_xdp_feature(netdev);
-
-	return 0;
+	return mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
 }
 
 static int set_pflag_rx_no_csum_complete(struct net_device *netdev, bool enable)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e537df670758..f0f2bc7f317d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3365,6 +3365,7 @@ static int mlx5e_switch_priv_params(struct mlx5e_priv *priv,
 		}
 	}
 
+	mlx5e_set_xdp_feature(priv);
 	return 0;
 }
 
@@ -3396,6 +3397,7 @@ static int mlx5e_switch_priv_channels(struct mlx5e_priv *priv,
 		}
 	}
 
+	mlx5e_set_xdp_feature(priv);
 	if (!MLX5_CAP_GEN(priv->mdev, tis_tir_td_order))
 		mlx5e_close_channels(old_chs);
 	priv->profile->update_rx(priv);
@@ -4409,10 +4411,10 @@ static int mlx5e_handle_feature(struct net_device *netdev,
 	return 0;
 }
 
-void mlx5e_set_xdp_feature(struct net_device *netdev)
+void mlx5e_set_xdp_feature(struct mlx5e_priv *priv)
 {
-	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5e_params *params = &priv->channels.params;
+	struct net_device *netdev = priv->netdev;
 	xdp_features_t val;
 
 	if (!netdev->netdev_ops->ndo_bpf ||
@@ -4461,9 +4463,6 @@ int mlx5e_set_features(struct net_device *netdev, netdev_features_t features)
 		return -EINVAL;
 	}
 
-	/* update XDP supported features */
-	mlx5e_set_xdp_feature(netdev);
-
 	return 0;
 }
 
@@ -5859,7 +5858,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	netdev->netmem_tx = true;
 
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
-	mlx5e_set_xdp_feature(netdev);
+	mlx5e_set_xdp_feature(priv);
 	mlx5e_set_netdev_dev_addr(netdev);
 	mlx5e_macsec_build_netdev(priv);
 	mlx5e_ipsec_build_netdev(priv);
@@ -5957,7 +5956,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 
 	mlx5e_psp_register(priv);
 	/* update XDP supported features */
-	mlx5e_set_xdp_feature(netdev);
+	mlx5e_set_xdp_feature(priv);
 
 	if (take_rtnl)
 		rtnl_unlock();
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 0335ca8277ef..ee9595109649 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -867,7 +867,7 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 	if (take_rtnl)
 		rtnl_lock();
 	/* update XDP supported features */
-	mlx5e_set_xdp_feature(netdev);
+	mlx5e_set_xdp_feature(priv);
 	if (take_rtnl)
 		rtnl_unlock();
 
-- 
2.31.1


