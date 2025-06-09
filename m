Return-Path: <bpf+bounces-60064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE686AD21DC
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDBC171F0C
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2109D2185B8;
	Mon,  9 Jun 2025 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lm34xoRv"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C732116F2;
	Mon,  9 Jun 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481232; cv=fail; b=Ln3EBLwGKYWpMGBEVWesdfBOcF+xgQdRRJJCMpMSrwExbJ2O6GMT65486Tm5ncjm6uS6MwhewNCc6gWbWpgETn3KNrbKMXJDDVnig54nBRBih78FJpHGkZhqd0peD6i7haYI9K+TV+54+mbKfQaLPcFrgToqOS5NsnVCFIu4GPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481232; c=relaxed/simple;
	bh=32u6So0csLjprV4yGjItykkpk/BWB1yCoglHqvNJP+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OI+QZ4Tvx+aHtWAf8HuFb2IIibyIia2Nl9VTd+iQleXvxqlZ4ArC7Lsnd1a9r+8t1bTniYn72OpmGggNWrhfpgDGxDzp7iAgA2/KD5m30Lbkof07+rYZRzYgbUYaOsVzXrZAGXTpIgUrfaBvJXrCCpXr/+1Gv+0JxotT9DmySjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lm34xoRv; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjR6ZqlgYmtxIrgmETyvdxmTXJibeeWonyQ17KF8WrWkkK7ab0WD79K8jkIYmpErNmh7vkDhllP4bbmjiVOL0qpS6dr8rdHTcx0zxmVbglwgMo8nVZsPK8J7Sk1IDY8IEHA6XkfKzSb7r+EVMJ+D0he4PyOAMVcHA1TcU+zmQmUVMssgh5AY27jTrx/34mEKRyPxATW07YEHpyLHsCwd/Navb5EdjjmcVcqfeFtByBdhy9PbkqyX66GIJ6q4TDcQu0b/WRzVnkKEXxsbiu4LEEOX+n5lucQEPf1UA2nL258k5lS4tGdroc5Pp3eAvmmqlMbuymZkRUMUN0ziw5AMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m0iDAZAnWT/O2Uc4lSlxx2SAMTAYdoTiMMvLgY4Md8=;
 b=NGH+wM+U9iuyZG9f4hi96NcZkrOuPv/xaFt19PHhMh8m+sOEazIoF6ZLQ9IrjjYicMRutoV8kCDHEj7wG75+EUUNDXwcop1Rh+2JtpuUpuG6ulwZtHPXWhE0hPcqZBFXqqm1Vw6XgJcVe2a/XXNAmM68InQVhKloxJJZdnl7Ss85oy+BjFksn68+4JhniXHKSojr3n2z1k0KOU5mI4ZVMaFB+xrUazzPRcTPWlO3V1kOhCjYmlaOY1rhOnaJI7SclzxVpTEm2WJxVtqmpkRpktw6L04Qaojt+UQ9IPeSJ+guZ3/Pnd3l52yyiiWRoH4I7EvnMQYL0TkziJDokigpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m0iDAZAnWT/O2Uc4lSlxx2SAMTAYdoTiMMvLgY4Md8=;
 b=lm34xoRvE4uIRaK1EtssAQVukNybCjZL8712aygGzP3fL6RzPlKn7K+BlM/9Eaz+WohKieYXRUkwJArQgc/gVHxDfvLj/J0vfEeDjvBF92dmlQc1+o5XIJAnwBJidvxsl2efHL5WzcoOkGLgd4P9rhbS++SjXJCn67lueRzOozt7/ifyHk2/mrWAHfUGuJwtNhw2d0si44xeFi8ghsKJgf/99Ufz2f0TaTNCo28p7wRQGsod3DlE0fSyL5/30yYRGdvGK91kBvfJgqahRovGbrXsl1EbfQPy/FWTxiAKnq8d6vv9WlvrfHUfDidZsppiUx/J2QA780CW8kVmAIVbgQ==
Received: from PH8PR15CA0007.namprd15.prod.outlook.com (2603:10b6:510:2d2::10)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Mon, 9 Jun
 2025 15:00:21 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::9a) by PH8PR15CA0007.outlook.office365.com
 (2603:10b6:510:2d2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 15:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 15:00:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 08:00:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 08:00:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 07:59:56 -0700
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
	<bpf@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 11/12] net/mlx5e: Support ethtool tcp-data-split settings
Date: Mon, 9 Jun 2025 17:58:32 +0300
Message-ID: <20250609145833.990793-12-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb4b4a6-2947-4b72-843c-08dda7665ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fZM/ObCxVmy+cD5gQQkJIf7IRyJ4BKJANC2uCIxx9msUDeIGZGLy+eRqconh?=
 =?us-ascii?Q?y1iVAbJpAJJN4OzaTyV/TVWvd5HzXF1wF+tQ9RoEnOPhfvbh4egfCPoud4L+?=
 =?us-ascii?Q?QLfSFDdDbPudM3AI/WEazANAaN+bATirPeKJdBQIajRC3Xh145AkZbGj8jz8?=
 =?us-ascii?Q?1+Ge+eCBhF1k1HUNxo/IuJHejMDGxjijkxcknSG15cwnG9gn8v4ol79AEZY+?=
 =?us-ascii?Q?jDojXcNgrBIqc7HdxVTTjV9fMQkK3LA1lBuBT+Xtc67uoRlCa2hY/HHRPYqY?=
 =?us-ascii?Q?Q5+CcgoNDQ1/Qw1nma56C9khF5eS7uRzZujNDNN9nvFgpgchB85Ju/vKUEJC?=
 =?us-ascii?Q?jq8LK/T442vHguzUyiWNZASlFVBTwnB5nXQka7i41GB8iPLx3NEBcyTvvxEM?=
 =?us-ascii?Q?TVTkF5o5KFWhI0fztk+/DOaSmDerka7nAfiGbcfzboe6YcRyCbNbBA+OLLVO?=
 =?us-ascii?Q?k4SAC2agTYvR4u6uS0v5YxvRKvrC5Ei3gtqOLNtnu/GV2cYGiDT8jupaXMON?=
 =?us-ascii?Q?BSe79ts2dds6tYd1UW/kr4+/XXhHlQA+11vj0PbZLX+r9j0NKPP34y8rbj/u?=
 =?us-ascii?Q?kSo3Y4eVAkJPE5D3vCN5ovd5cX42Gy/5mih92A7WdFENYxFtB23B8rdTdhuG?=
 =?us-ascii?Q?oXCcCrIfyGrvF8WdKBjoxESmjpl9sNTluHZyvlMPEvdXaNZj7KdICZwWXMg3?=
 =?us-ascii?Q?MU17pZWLgawNNHC0GfbO4po7l6LktUoeucZV0lVeGjYARWa0UbarJuZUhcdJ?=
 =?us-ascii?Q?i4oy8ZBum6nc1y/dQQzyW1gE3k4QU5fcAp5f42ukiLqcopA4iA6grvTggFD/?=
 =?us-ascii?Q?XdYlw96lDmNpOU1ChOR6oGROoqJHd3AAh78lUzJJHzgJqPQJQCWAgJr4gDkC?=
 =?us-ascii?Q?a9z3uzJkNs3HHxwN5erE3Q08uSPT/Szovq3b8Hub+NcfutnbRRcBnFcV/0zX?=
 =?us-ascii?Q?4pnImCLZYSM3nDGJD6HXuatJwUztJ4VovbIqXFhwiWHTUWIJpmula66ibpV6?=
 =?us-ascii?Q?13+Vl+JQGbiclNm2/W0rCCzm6kYxwf4y2pqJNJm0y3lufHmn/+haPd/tO4S7?=
 =?us-ascii?Q?PUjNiDiNiNz3itEn/pUsSl59OcWzRNcFhAFwuYcecVcVMQ2J1ubj7I34pWfz?=
 =?us-ascii?Q?/TJpR402sDfMRhSzR4oG++T7FVH9U/KVrId47ytiYscWDRTpOns5GtmCWJi+?=
 =?us-ascii?Q?C4jJdiaVxH94//YpVhWdVVoMsrdz+qMC2HF2tNAospmj+qyWyBEtb/X/Xjt2?=
 =?us-ascii?Q?N1EB+SPPwJLORy43xec9jbgKksWBIS6MQ24ulLB05/kOFcnsHvHW/3CcndcP?=
 =?us-ascii?Q?VLoNCs4DmJUXX/QBZKbEgV9Ym1F2CrQCdO9RJT+uB4bLQJqdAfqe6ULxDVv0?=
 =?us-ascii?Q?0j0N2nw957rWE2QQY4nBC9wF2xs/zYt6MBd+0ZsjcE8UBhzXS0vdNFalKNcO?=
 =?us-ascii?Q?hffAfulwSgzwsAkx2DPQqxrJuyy9mWhqfyQmJ86OhSaTkaBoae+/WtGqXSat?=
 =?us-ascii?Q?i1xbCipkeJnZvPuTsRhTVK1YTJSqUwIczV/0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:00:20.5612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb4b4a6-2947-4b72-843c-08dda7665ab6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

From: Saeed Mahameed <saeedm@nvidia.com>

In mlx5, tcp header-data split requires HW GRO to be on.

Enabling it fails when HW GRO is off.
mlx5e_fix_features now keeps HW GRO on when tcp data split is enabled.
Finally, when tcp data split is disabled, features are updated to maybe
remove the forced HW GRO.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 33 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  8 +++++
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index ea078c9f5d15..21005cc4eb06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -32,6 +32,7 @@
 
 #include <linux/dim.h>
 #include <linux/ethtool_netlink.h>
+#include <net/netdev_queues.h>
 
 #include "en.h"
 #include "en/channels.h"
@@ -366,11 +367,6 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
 	param->tx_max_pending = 1 << MLX5E_PARAMS_MAXIMUM_LOG_SQ_SIZE;
 	param->rx_pending     = 1 << priv->channels.params.log_rq_mtu_frames;
 	param->tx_pending     = 1 << priv->channels.params.log_sq_size;
-
-	kernel_param->tcp_data_split =
-		(priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) ?
-		ETHTOOL_TCP_DATA_SPLIT_ENABLED :
-		ETHTOOL_TCP_DATA_SPLIT_DISABLED;
 }
 
 static void mlx5e_get_ringparam(struct net_device *dev,
@@ -383,6 +379,27 @@ static void mlx5e_get_ringparam(struct net_device *dev,
 	mlx5e_ethtool_get_ringparam(priv, param, kernel_param);
 }
 
+static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
+					     u8 tcp_data_split,
+					     struct netlink_ext_ack *extack)
+{
+	struct net_device *dev = priv->netdev;
+
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    !(dev->features & NETIF_F_GRO_HW)) {
+		NL_SET_ERR_MSG(extack,
+			       "TCP-data-split is not supported when GRO HW is disabled\n");
+		return false; /* GRO HW is not enabled */
+	}
+
+	/* Might need to disable HW-GRO if it was kept on due to hds. */
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
+	    dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
+		netdev_update_features(priv->netdev);
+
+	return true;
+}
+
 int mlx5e_ethtool_set_ringparam(struct mlx5e_priv *priv,
 				struct ethtool_ringparam *param,
 				struct netlink_ext_ack *extack)
@@ -441,6 +458,11 @@ static int mlx5e_set_ringparam(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
+	if (!mlx5e_ethtool_set_tcp_data_split(priv,
+					      kernel_param->tcp_data_split,
+					      extack))
+		return -EINVAL;
+
 	return mlx5e_ethtool_set_ringparam(priv, param, extack);
 }
 
@@ -2625,6 +2647,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_USE_CQE,
 	.supported_input_xfrm = RXH_XFRM_SYM_OR_XOR,
+	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_drvinfo       = mlx5e_get_drvinfo,
 	.get_link          = ethtool_op_get_link,
 	.get_link_ext_state  = mlx5e_get_link_ext_state,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 90687392545c..026bd479c6dd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4413,6 +4413,7 @@ static netdev_features_t mlx5e_fix_uplink_rep_features(struct net_device *netdev
 static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 					    netdev_features_t features)
 {
+	struct netdev_config *cfg = netdev->cfg_pending;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5e_vlan_table *vlan;
 	struct mlx5e_params *params;
@@ -4479,6 +4480,13 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 		}
 	}
 
+	/* The header-data split ring param requires HW GRO to stay enabled. */
+	if (cfg && cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    !(features & NETIF_F_GRO_HW)) {
+		netdev_warn(netdev, "Keeping HW-GRO enabled, TCP header-data split depends on it\n");
+		features |= NETIF_F_GRO_HW;
+	}
+
 	if (mlx5e_is_uplink_rep(priv)) {
 		features = mlx5e_fix_uplink_rep_features(netdev, features);
 		netdev->netns_immutable = true;
-- 
2.34.1


