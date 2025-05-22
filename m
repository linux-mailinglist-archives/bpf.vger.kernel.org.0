Return-Path: <bpf+bounces-58768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069E6AC1625
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39381C02E0C
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD1826AA8D;
	Thu, 22 May 2025 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WovYv+Ge"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82861268FEC;
	Thu, 22 May 2025 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950214; cv=fail; b=qhZeihVZJrzvlKI4+3bWGP2zi5o+PWI5QWLWbv+pSpq7C7AqjmexOdJTkxEdwrCQrB04SHFBDS3zJ/4tqS3S3rySYx+PYTUPzihfNnqcl3Qa3kP3Ihzw5W1OOMO82mwG1L3zmdFWouWn7ZRC453vnb9JPVeWxalU+WQ2I2XafOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950214; c=relaxed/simple;
	bh=37FTrnki7AFujBHA8g9eJevrVFNHAhr6LVoNNZW0qRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtZNZjKfgbzqT3Htc0q4dKIun+xJrQ+l3guQ+u2ZFighCT+OSCEHt9mHUzPVxgR7nMMAVaBzLWLvm7xXsu7aaAEoFDfR+WXAJzol9Jz5cRuV0Rx+5ySMuDnCM7gohOc3WxhIseba4AYLGTN3RpnHWiWiK+OqOEPaSL8VvZ3iJXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WovYv+Ge; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiWcH2JFoUhAqxtN/d8W5enkCxcRihioTUt4d7Lj1TduEftgjePxaZktpWptdQ6us7NGpjrMZ3UvAZlmoHLcBeFjFQlIfi1sKzpQEj9wEu3U/w4DaHcG8yk3hUefSnCGGXPTY5JAEyCLMGyJ4jvCzEQL6iEBNeOZt9z+sKN9+x0+AkDZLviY0/ZFsIlc+7qD6u99UCg+J/jqsG7W2U8esHGZsWu0Z5i+DUpiPwLasdqAWe6nUZWyY4e+tt2BMX37YClXqQEk7pgWDXstpGFZTMOOYbjbotl/lCUGYNZIYUg1Rc4NNG0dvyOgKry4VY3/wACszjr3F9zVyWAmh2lLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhHaWYo3FtWTJXii+3kKT1gzOkCw3w/p1/iwtjTRK9Q=;
 b=IWZcHz4dqWr3K6h6d1DDg8dBqv4QZx4ERtx4t5X7YEQD007Kx/UsBQxxb66AXuepk+Rrk3TEnUsuxKSRxn0znl7jadxTA+rKepMkqiEtMKr30rtLAtN6wVHLnOmUFzTy+p9eLXl92uQZF9ojIn5FCzDjtdhJD7AlwqjOa68uV8IW+zg/GV8Kb+vTj9YjCiQ6pBOw6w9DjUWomZaOgbl4R8MNRCtnJurbzgymAnCvBIxOeVTdO5oi9Czn59GljTnSYMXT+4ahwtriEjNIVjXKmVf6/c97ihzBuXpnlKQVU8Oo9KM3icTsU6bQMvMMOCyoWL42RRt1fhoo3EU761DHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhHaWYo3FtWTJXii+3kKT1gzOkCw3w/p1/iwtjTRK9Q=;
 b=WovYv+GeZaMuCWpZnzxDYvS2VYfjNVv7OHiY4/s4iCpWJIaWrTYXP9frLzaciCBgiT2ruK64pWk9WLVzvoPkpBx8wUR9O570WaTW3D1jhs1/PvTjGDiKpynP37ZtQ74tqJPalYD4urtajkysQoHyYV0PNDpfStWcisKjnD4lsyknxhBriJSriqIKeNNNcLrpvSzfjo7CY3ui2j+GOIQi6biAfHvF9bLL9r8bRLOoDt/7NTMJRGkThrl/hlLqUwmubonxDubzOKwN9uptetFmj3EefUy2+EcXUvrVFy0BxkGiEAwKQRW1NXwtE/usSKMktAkVnAfDmcyo45mMAJ6tvg==
Received: from CH0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:610:cd::12)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 21:43:29 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:cd:cafe::a8) by CH0PR03CA0097.outlook.office365.com
 (2603:10b6:610:cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 21:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.4 via Frontend Transport; Thu, 22 May 2025 21:43:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 14:43:17 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 14:43:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 14:43:12 -0700
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
Subject: [PATCH net-next V2 11/11] net/mlx5e: Support ethtool tcp-data-split settings
Date: Fri, 23 May 2025 00:41:26 +0300
Message-ID: <1747950086-1246773-12-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: ee545efa-a298-447f-3b34-08dd9979b05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GWQAAOS46JST8rPofZwpnWOHpo2qVEHYk66+sbngJJcY9O8C0KtABoqTsYQe?=
 =?us-ascii?Q?YjWj0YsAwDahKzz4oEjN3hOrQYuOQSKPDh/o6QrHxVT35/BHJLEkORCKVU9b?=
 =?us-ascii?Q?hvKgHwgqeU0N3P47IVo4llFtjXGdIO6m5cY1xqVM9HgZGvq51x2jKsDcKY8A?=
 =?us-ascii?Q?1n7hQrDD628v8h0/UL8UOSJyWEP3nB7XjN94v40x/3LnNcZEN8z/+kjFNN/S?=
 =?us-ascii?Q?w3CfGEwGNta9AuHFUnN70JVq9gj46Kom0BfnA9V6kdumqN5o4T/Fm+f25kUt?=
 =?us-ascii?Q?X4Ko4OS5+AZtEktfoQzDW7d0ycuy2WfFmNimdQoLtHkmRnj5yAF7OggxntKo?=
 =?us-ascii?Q?jYfZ6Nnlm9lOnx42ux+jun2X2NqT+01XdodTBcPo1/skA6/45/HtucG8CZeW?=
 =?us-ascii?Q?Nfuh8spzIg/mLmp/DAqD/cRuz6Uz/oqEpxrH6UZ2ndA01ijxlshTedBxigS3?=
 =?us-ascii?Q?sSKcdWznNutJJOpXMre36+wk7hBjZJ0icKpfldCbHIeoixDWm6TIKqLiJaMm?=
 =?us-ascii?Q?SykPMVGWoHT9sc/RCgdrl4n7cDRjF7ZEchdR6Ho4TPSwbJHf/nIIabafU0Zx?=
 =?us-ascii?Q?3ZVE1mFcZvs1MTYGqFKoW5OOuzSPC7ULEsA5LhHdUcioYEsSBfSHzfByc5LQ?=
 =?us-ascii?Q?OQYHIreNVUZCWwMBtAdvdkqklgjnIwg/TITxkSOpVMxReKNflF4Ig9zAeCJT?=
 =?us-ascii?Q?bDPra6R6i6dBRYqfVwNiWdSogfMGjW9Qd8SYNQNMOr1UPdlfPyaWtOc7f2KB?=
 =?us-ascii?Q?H+HxHp6rGPqWeh5fJL2KR4gOs0A2zBoD0WU5nGIB+Zve6UjshBkDDhL2ihwt?=
 =?us-ascii?Q?so3Uq6xdID8H7jmcZsg9XbTvRn4gaW2NiBppFp0vfFEr5+xacpDTIVPwdTd8?=
 =?us-ascii?Q?LPV3sAaRn+y4Ofgpdj/3soqq+Een1oOiQDQf1wfNZy1ABMMc9qI8+ratVG7l?=
 =?us-ascii?Q?QvyRBLu9vt6PVjcn1NF6duRIqcIS56wICxBaLvL58cnvkrMFD+YlTO/QbHN1?=
 =?us-ascii?Q?qh/la/iIdm96EVBQWC2si/6FQC2aifiHp9ZYnBcW3Nh9Vh7p3fVr+I7DuYIG?=
 =?us-ascii?Q?pmB3vjn1GW3N+JKckgluaY9hGsmSnRJzSvu5NCaSE1c9Hq16tUfvBxBBrfNv?=
 =?us-ascii?Q?PZkN+83dpS2S08jRC9Isjo3fpTMV1HxxDrrSQBLmQDpYx8izd88Rf5vL0j5v?=
 =?us-ascii?Q?8BistW+9yE8NdJCxa++q9CTXmOuEvdptiak+27cKlyBbB4hFnOvycOTj0grY?=
 =?us-ascii?Q?MvtJLgzegfqqKVFT4laSZrc0+GuaW+MFZKy84OJFAkRZml2gGl09BHooUYXC?=
 =?us-ascii?Q?7+d3s9uSihJOZmO1rw97Hd5cMsqYELFaHd6oZOFNjUdZfoGJh3ZzaHmB3cW9?=
 =?us-ascii?Q?0F/Gm4pcMmPsc2If3FmZewZws/Hxk/NhliCruuqDFgLtJrKo+ZrCNa2CxTmg?=
 =?us-ascii?Q?4p48w35fMEg7hStW16mYPz+oUq1oGl4l5dzlGgvDvKhskwAtGhzegHsn3vFW?=
 =?us-ascii?Q?n5dYwcV3tR11XKrBMphMCfp3P4tcu0knBXLY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:43:28.4437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee545efa-a298-447f-3b34-08dd9979b05e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428

From: Saeed Mahameed <saeedm@nvidia.com>

Try enabling HW GRO when requested.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index ea078c9f5d15..b6c3b6c11f86 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -371,6 +371,14 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
 		(priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) ?
 		ETHTOOL_TCP_DATA_SPLIT_ENABLED :
 		ETHTOOL_TCP_DATA_SPLIT_DISABLED;
+
+	/* if HW GRO is not enabled due to external limitations but is wanted,
+	 * report HDS state as unknown so it won't get turned off explicitly.
+	 */
+	if (kernel_param->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
+	    priv->netdev->wanted_features & NETIF_F_GRO_HW)
+		kernel_param->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
+
 }
 
 static void mlx5e_get_ringparam(struct net_device *dev,
@@ -383,6 +391,43 @@ static void mlx5e_get_ringparam(struct net_device *dev,
 	mlx5e_ethtool_get_ringparam(priv, param, kernel_param);
 }
 
+static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
+					     u8 tcp_data_split)
+{
+	bool enable = (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED);
+	struct net_device *dev = priv->netdev;
+
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
+		return true;
+
+	if (enable && !(dev->hw_features & NETIF_F_GRO_HW)) {
+		netdev_warn(dev, "TCP-data-split is not supported when GRO HW is not supported\n");
+		return false; /* GRO HW is not supported */
+	}
+
+	if (enable && (dev->features & NETIF_F_GRO_HW)) {
+		/* Already enabled */
+		dev->wanted_features |= NETIF_F_GRO_HW;
+		return true;
+	}
+
+	if (!enable && !(dev->features & NETIF_F_GRO_HW)) {
+		/* Already disabled */
+		dev->wanted_features &= ~NETIF_F_GRO_HW;
+		return true;
+	}
+
+	/* Try enable or disable GRO HW */
+	if (enable)
+		dev->wanted_features |= NETIF_F_GRO_HW;
+	else
+		dev->wanted_features &= ~NETIF_F_GRO_HW;
+
+	netdev_change_features(dev);
+
+	return enable == !!(dev->features & NETIF_F_GRO_HW);
+}
+
 int mlx5e_ethtool_set_ringparam(struct mlx5e_priv *priv,
 				struct ethtool_ringparam *param,
 				struct netlink_ext_ack *extack)
@@ -441,6 +486,10 @@ static int mlx5e_set_ringparam(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
+	if (!mlx5e_ethtool_set_tcp_data_split(priv,
+					      kernel_param->tcp_data_split))
+		return -EINVAL;
+
 	return mlx5e_ethtool_set_ringparam(priv, param, extack);
 }
 
@@ -2625,6 +2674,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_USE_CQE,
 	.supported_input_xfrm = RXH_XFRM_SYM_OR_XOR,
+	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_drvinfo       = mlx5e_get_drvinfo,
 	.get_link          = ethtool_op_get_link,
 	.get_link_ext_state  = mlx5e_get_link_ext_state,
-- 
2.31.1


