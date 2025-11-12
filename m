Return-Path: <bpf+bounces-74281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A669C51695
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 10:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4021E3ABB2D
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF335302169;
	Wed, 12 Nov 2025 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LsSrczqz"
X-Original-To: bpf@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713030171D;
	Wed, 12 Nov 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939917; cv=fail; b=eVtBmIZgpniryn4GfxK9VdZqoeHF1zMagZ49otwvhc4YYMCNxh0TgeD0gpo6TQH5SuTQCAEQxorRukkCY5UuHU3E2WcOC+rZrTSyxIJk3xOn+d6JRckWiHDyZ8VfQGfdiHA3ugn+BC6RQ1RKnKuwLmy8fpR5g/FgcqIQQgNa6zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939917; c=relaxed/simple;
	bh=6+8J5fXdYtTAgjTAl/vq7oLWmLSNqiWNvewLLYr8AHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f675lpUhcEP8j7JzZ45EXK8vvl9hb2AIraunUoRYitmiH5CC4QM7/UbpzOAwcoUYjs7m+pNVZcvj4rpXKgKbzbJfmqjrvbBLGfv1oECiaIcCfH155xHxrpkP6PyVPbw8s2FtuEl4fMSKMBh76331g1Gtrk661HzmeALzS0h30QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LsSrczqz; arc=fail smtp.client-ip=40.107.208.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knRSOXMANAX/u8xNf4jmL4psfUOIozpmUTJVevupUgwgyvpTRD1ah2MoHETlWdkwrB8msUjWp83raSM5+ZbPxqNFtkHNzlWf4d82qGaeHxB0D9KdVrzUnk0GZ12G8VvzCKKoSJesPpNLbaAZpOSD42C0X/yf8uEKNdEO3dyJ0gT8olt1or8rAxnKHFU9J+fQmJPp7/7O8PaFbPUAy10rOjG/CDD7MjMfAWkYDN1ZJezh6TWN6JfL66+OOELFpiqj+Tzpwu6xhvr9e3FfKYcJQZWAdSJ/Ex0a24xybPStXJz2OcC224nkE7867ITlbjGutFm3IhK6kpX3tTG9D60/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHgdYUvepELlIiDZePohvyoDJdCdwiSzu3OJEQikPKc=;
 b=w9WAG92BvLa2q4FCn3s9Al/RbzVFQ8ct03xl+0KOV8pqsYNJ7eWGbPwPVfXyKcQ46m2+ixZb9PLfKhSFBHcWC7oUxkwRnu5ATvRaQzivKSTQAsRzJ7tR5hJ3U7kT/EexLopcFSeaNr0KtewIfGw0wTKTaNrGNNhwXEMUlRVVCVgLENh6sq3Js6qKd2FZNs1XCiSuP9fcQyQpLAUc9gxolLfuHBbG7S9Y+ekXukZCNW8Fsf1/eCLEGshaEgqnjGl6qOC9so0ICdGqeYAEjEJQ1royFWcOOg4WX+6hNQBWebjdfjNOhsa1PIDKiFIvojWK6nktSvS46Cp3GRcjzFLYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHgdYUvepELlIiDZePohvyoDJdCdwiSzu3OJEQikPKc=;
 b=LsSrczqzVW28EGFkgYeI9sPi269Vwxnbzi/37gWMV4GfCqkvv9wxTSuz5BcQDDDa65q9i4KS4uwThxDuuIRd43qZlk5DQ0G1u3K5w6lzaT0634bcZjp8UJZEGG5Tf45Pww3kgRzhS0CK7wMj8NmogH5+y5dFBdadDL0U51Z7dCi2jT6LcAYJnT0tOyMvP8chovsldP8dC432nxJ5IxilvXk6iKDPh86/2bcCK3URwsewms5nQ68NriO9jqOeinlqc39qljSE5QtFsh3jlVBNyM65Q8BMdKkGN7CtX7dHNLbsgDaujaUfSygc95mVqiPy+RAlprCRF0IiZAEU0CzvCw==
Received: from SA9PR13CA0160.namprd13.prod.outlook.com (2603:10b6:806:28::15)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 09:31:50 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::76) by SA9PR13CA0160.outlook.office365.com
 (2603:10b6:806:28::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 09:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 09:31:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:33 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 12
 Nov 2025 01:31:26 -0800
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
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, William Tu
	<witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
Subject: [PATCH net-next 5/6] net/mlx5e: Update XDP features in switch channels
Date: Wed, 12 Nov 2025 11:29:08 +0200
Message-ID: <1762939749-1165658-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: c62c9881-8d43-4fc3-908f-08de21ce4f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FVfQvooXAqBaMLfZ+zh+CxMWr+A/3d8+Z835L8K+P2h+4t1wBOXQ/I7ZKL8y?=
 =?us-ascii?Q?PIlS3hoUy3+JV9w40F0KuNbtO6zxUFTYJ4bTLfhJTC5KNMB9Ekcgubislch+?=
 =?us-ascii?Q?w40SkXj7TJy1WXOtNCFGxhU9g6mmqGkfWWbkGLO5EnHc6I5aS4tC3CVLbSF7?=
 =?us-ascii?Q?CFFkTGHyafJiAJHOZt7C/Ywfz4nsOmiT5MDsXAzoRGhxGnhXgnhf5hSW3Glk?=
 =?us-ascii?Q?psC5aw0j1PSEy9eo1TLs18VBcf0CfRdVefhEQqK6OOi4ECSSU9o7OKaxx3kh?=
 =?us-ascii?Q?is+ghBw1kdaQ4706GYtFFPOxK+3iWCvOT7BD6AnEZKgLzEm6J72P5sW1cFZX?=
 =?us-ascii?Q?1HGiw0+VxxFZSsYqC2UeXk6EJnVji9K+SUP4Mpf+ekwnj9v1b3BXdM0oSC0H?=
 =?us-ascii?Q?hs9T2B4yiJgskJY6S9pXAZRZvEAz8aWRX13sW+/A3XPhVG8aE8tvwAVBz5tu?=
 =?us-ascii?Q?joid9L4tA6C9/qqfkjHRzYVT+LPUlhwWUgvKO4e11tUYhXhmuDXiPukuHa7y?=
 =?us-ascii?Q?gxcyWHOZrxBvBLP7aD4uLIZpP0Tzhh38xu8g1fp3F0GW93sRDleGkat/tQaV?=
 =?us-ascii?Q?gj0tPsPx+FfiL3l0ah8kpPAijKbvZe7C2klsJyY6pcX0vvPz8ZgO/tvqVk3H?=
 =?us-ascii?Q?j+BpxtYnPaLPAz8ZnjemWklL9XfDeIOUdIEVtndRdDT+s6dvCCm97q1/pKba?=
 =?us-ascii?Q?JDUIIppDG8hULaf8iEZezS39f0RA5ld+KGyjZWIHtoQv8xo9fEJTeG5Vd7rX?=
 =?us-ascii?Q?2dZWpEGuBbL/m/sOODlhqrD1fkUUV/gBUx4zb2TslI+wGYm8ytQQ9QhwY3vC?=
 =?us-ascii?Q?7HbKOQqD2wX1trmCv7H9hGI7v9B2Q+YZ6ydjOWUchZj0eeHKr1JKFkx/331R?=
 =?us-ascii?Q?Im+09RDDvCT8OIp8M3bfqNV5aYgACLqrvZOLvFyGp/zylk+hKaZ7YtttNPxP?=
 =?us-ascii?Q?lYIdjmDKwZ9VGvGkbCIVKtBxyTiKSDRUARyYOUnoYcxSe+VhxmAmgjj2lMRU?=
 =?us-ascii?Q?iBVkEsRd2l7nQ6gm8ZDNM2TqqzLw8Dmdu2QJrTIabJZiPW3jeAHlqm6WsxdY?=
 =?us-ascii?Q?wUe2HPypgzJjsJ68dv9f5FRL3V4v7VnLZ65Dh44GH+XzkzVgMorG92VLroKG?=
 =?us-ascii?Q?aZhe4rE1FuXJg3Hm9jfi8PePxe0PmJ5TdQo36l5gjavHRvh3QKNveXxv4tSe?=
 =?us-ascii?Q?TcIm7ALug9XeOr06v2TTSD4jDXTTQvy9Xjgorr4Cbup2KjGAviLA8tk6mITF?=
 =?us-ascii?Q?S7JVKbV5vs5wYEvvWCf9q4t+Y4CKk46egfOrFQen4a3iRL8NQF5MaxcL1W8O?=
 =?us-ascii?Q?c9cqZ6SVsqGlHmY3WLeTyNi2Nzc44jl/B2dO9O3nL9JL5OhhXZL1DCaCI8qe?=
 =?us-ascii?Q?eK6dazK8jtzuwoyGeqy3QSEzxzXBqmCRN/yfkMNlDBhmwLzuDWVjgSx9Ps1j?=
 =?us-ascii?Q?HbAKrLnt3hk2WZkPtnq8+WA1p+QkrswHdwf13YaZPg+0gm+yP0rYB5ve6o44?=
 =?us-ascii?Q?OS4l+v6/4+pbi7suqLPywCzxTTahkk3oRQbRLS4x9L3DEbVElTfvh8hubXHF?=
 =?us-ascii?Q?Zc+Cd1G79vvvIXmlCOI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:31:50.8045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c62c9881-8d43-4fc3-908f-08de21ce4f3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448

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
index fea26a3a1c87..f857ed407cb0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1288,7 +1288,7 @@ void mlx5e_netdev_attach_nic_profile(struct mlx5e_priv *priv);
 void mlx5e_set_netdev_mtu_boundaries(struct mlx5e_priv *priv);
 void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16 mtu);
 
-void mlx5e_set_xdp_feature(struct net_device *netdev);
+void mlx5e_set_xdp_feature(struct mlx5e_priv *priv);
 netdev_features_t mlx5e_features_check(struct sk_buff *skb,
 				       struct net_device *netdev,
 				       netdev_features_t features);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 01b8f05a23db..73d567ccd289 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2286,7 +2286,6 @@ static int set_pflag_rx_striding_rq(struct net_device *netdev, bool enable)
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_params new_params;
-	int err;
 
 	if (enable) {
 		/* Checking the regular RQ here; mlx5e_validate_xsk_param called
@@ -2307,14 +2306,7 @@ static int set_pflag_rx_striding_rq(struct net_device *netdev, bool enable)
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
index d1dbba1a7a2f..078fd591c540 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3417,6 +3417,7 @@ static int mlx5e_switch_priv_params(struct mlx5e_priv *priv,
 		}
 	}
 
+	mlx5e_set_xdp_feature(priv);
 	return 0;
 }
 
@@ -3448,6 +3449,7 @@ static int mlx5e_switch_priv_channels(struct mlx5e_priv *priv,
 		}
 	}
 
+	mlx5e_set_xdp_feature(priv);
 	if (!MLX5_CAP_GEN(priv->mdev, tis_tir_td_order))
 		mlx5e_close_channels(old_chs);
 	priv->profile->update_rx(priv);
@@ -4461,10 +4463,10 @@ static int mlx5e_handle_feature(struct net_device *netdev,
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
@@ -4513,9 +4515,6 @@ int mlx5e_set_features(struct net_device *netdev, netdev_features_t features)
 		return -EINVAL;
 	}
 
-	/* update XDP supported features */
-	mlx5e_set_xdp_feature(netdev);
-
 	return 0;
 }
 
@@ -5911,7 +5910,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	netdev->netmem_tx = true;
 
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
-	mlx5e_set_xdp_feature(netdev);
+	mlx5e_set_xdp_feature(priv);
 	mlx5e_set_netdev_dev_addr(netdev);
 	mlx5e_macsec_build_netdev(priv);
 	mlx5e_ipsec_build_netdev(priv);
@@ -6009,7 +6008,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 
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


