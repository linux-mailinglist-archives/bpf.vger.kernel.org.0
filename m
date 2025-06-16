Return-Path: <bpf+bounces-60727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CDCADB38C
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE953B50AC
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEFA284B20;
	Mon, 16 Jun 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hR573FsX"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045227380D;
	Mon, 16 Jun 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083390; cv=fail; b=eGPjfdO6hN2WP+ILwvsSQOFoLQTtuOZ6rzfjOcGxxHu8GQ9wmXBdoOF0gnRKb03ZSwf76LW7xj1w0ANv7R50kDDPeuZNit3McdXK43YUdtl91lZZ4KR7/EED/LYAWuPGxfDM23xpb8D0NJRjPc+Bh9tNBNa9Gj7rW6QNl3WyXxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083390; c=relaxed/simple;
	bh=AVfvB5Oh7fvBdngn/NZ6k4Sd5BjSmwO6liDlzlnU5gY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+UIaFFju98TWTSkZsbF+dqu07L4qj3486MaRvrySIfo2LRLzudN8alyMJkOC9plFiVHtEvxsW4fB3vQv/bZ4rTPJiwEQMvyuGkEtxuj/Tx8vq1OIAvWO0kDuG+pG+nOyUPVWFMI7wlr6ztCXbXA/I1KDvmzRbWC1W3jTx/2uJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hR573FsX; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfgWSeX87vj1VNHrj3OUzZcIctMWI3IpfH1e2bMzXWeW8LBijmMSFmGm9bexY9MCV/I22iA35u7+lAMYkPSznsUb0FiyeTazo9oY8gWWjuTpp6zsccdPKjxgqfbdGJnLu/myzd00W1cudkXFU5EXOcG5BiPJhBsc0Ro/rtwOFA52EUg+0Kppopq36YcREAf4gGW89yQHEbMmcCqHYgkQd/JIyb/LEY29PN3hsaaKzoUvWf26JSsMaP+fbwxIf10cVwa7vNZ6pB5DN5KkzWxm9e9bWXmmiCHDtWH25USe+g143bc7ETB7GSlB07S+T8TWrV0HebooY/J5s4v+7044lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krelBdBN6gbJqsaZO0Ontmxx5eL2CSHHe15EJuGr/Qw=;
 b=ml8Jzos8yL4JRKhVXLMlRlr6rO7MegC7TsocCFbhTSDzSLqTkYKV7brKeSxaRpjICcjv9rUIIQ6owB1oqm5L8ZUcBnD7Y/BNckWoj3ahIn4OUpyCyWSTFMu1CJsetOAGr3KXbKfyWkldMkLF3eu7dyhxEJrLVcS8FyNHQmtgX6Zy7O/1CZem4XQx61Gk/0f7szCOobYe3HnppwrfvkbqNAyiYde4kP6asw9Ep6f6S14wMJGbf8BG/WDRjBxsohuK5EX0wYjH+FBXFhOWT4bMsAEr98Y6EaQgiwoEBfiH3u6d5jF/4JYFUp/qBajG0Bo+qB0OF1ZBFV7qsTZlhQx10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krelBdBN6gbJqsaZO0Ontmxx5eL2CSHHe15EJuGr/Qw=;
 b=hR573FsXbPRB5FkjLJ6hU/6XwO12co2nss4A5AHLX7Zx2+OgxEI2+C0/ccTUCFEElkgnuNByf7fEMaeZ1VO4qu3VSGRX9M4b65PCSvVC1Cum8CxbR6XiQMxjDiGrSEFIvhRlCxbkZEsSczYNW6XFjQ78L1Jy8qQPExqXediWNq2Tz0VAIrHUeLRT4naa9hM39YTefdWDUrtsbCGs0AZUcwXzAAISbfyf2o9IP4DxHT5u4P6VI2OGDxZFMR4/tWzoEQjBockTAKMenfm932FjUbZop8/Q6pysheAe5Pq07IByqLY1x/K/+HSLsbgTtKPCaR3z7UQrjOnekZEli0GSAA==
Received: from CY5PR10CA0002.namprd10.prod.outlook.com (2603:10b6:930:1c::35)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 14:16:24 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:1c:cafe::5f) by CY5PR10CA0002.outlook.office365.com
 (2603:10b6:930:1c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 14:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:16:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:16:12 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:16:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:16:06 -0700
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
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v6 11/12] net/mlx5e: Support ethtool tcp-data-split settings
Date: Mon, 16 Jun 2025 17:14:40 +0300
Message-ID: <20250616141441.1243044-12-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cad4270-46ef-4893-6503-08ddace05fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RZ2m8Le5hLRfQkQhqxaAGs0L9JuzLIy4yQEbMMSth/36m6RrPMOpJaXLjbEf?=
 =?us-ascii?Q?+xGPY0q4oA+PB7GnSZdMtqxxicaDkVWvUl3bIM49JNbiXklTLG8bTgImejxe?=
 =?us-ascii?Q?e5U70oz796vTSP+0X7j2ZixP2Q5NbXB44VmQVdOU/p0OAeCSqLagmh/n2Fkt?=
 =?us-ascii?Q?nguwiW5UBvfNpGOkPbImth0fT3j2w6seO7TkMFUwD0/eAIOH/Up7NzC0Jkyw?=
 =?us-ascii?Q?eVFUK1Uai+JF3WoFCN4Zk6g3VtYc8q7cQCvQWg3VA65pGYACwUaYeqOxvyIf?=
 =?us-ascii?Q?YRd6XMwqGekzyB53BvZ9gFL2ONF1sDRthQYBc/GKa+ozXeX/Yu3TcC4ExPjR?=
 =?us-ascii?Q?xaPXljHVUx2vtCeor1iAKiwwDPWDBBDHyQgkZ/6Got+04+3vwlZw4Es4wrVG?=
 =?us-ascii?Q?kz225hGVwszyHOllHHT/9al9zpjtycYGvL1LG15u1/Bmg18/BfxN0daTB1Wy?=
 =?us-ascii?Q?6gHQl2XpvMqp2nVZuWVUyF7wwlJx/A7fY+iyIb1zr1gMO5f11Rqr3ETde25v?=
 =?us-ascii?Q?n5E6vrcYsSmyxmSl7MfsH9XzKW8PHc/sgTcLF/TJp4WR3WDo2wEG7hLs9uwI?=
 =?us-ascii?Q?OABNt7CPkliheNHaqPeM338jS96RRy/vO/tDGx64ApcTINAyffjTbqfqP2mo?=
 =?us-ascii?Q?Fb7btNEZ0k+PYAF0P9XOQsMxy0kTZkCjTXrQzVpbJSWCLzFf5JnvC860d9wT?=
 =?us-ascii?Q?gi2nCkgZZtCSeYLkDovXRkk2LchLXbQNZ9dsgyARvTLuFImmO+WlNQek//yP?=
 =?us-ascii?Q?UyHA+lTl+158VSWXPf0xzd+Boh4uTNSlspQcTN3wuWIbz4yz2fRhE8/tcQ+K?=
 =?us-ascii?Q?AtpOY4cWNAWXxzTSuC+i1IkQV9QU9maCH1pywvhGo8emfILZ20XpdFtge01h?=
 =?us-ascii?Q?A5+rSc3sAxlTsgjoYZILoQ/PHomyq1JcF2c2NxOxiNca9s6apKnfo7xqLU2U?=
 =?us-ascii?Q?POFgFDgk7COc+03uAPxADLrEfCTKjKke6SvuunCd2M4zW01eC7gKDrXu3Mnm?=
 =?us-ascii?Q?8oERwrahQS8oKgOzuf9aC+3/kHkHPxUXtqUUYv2qjtob8Ih001kumscoda61?=
 =?us-ascii?Q?4EmP8FfUpuUDAdMStYpFvLB0IufwK6Xb409D3eeCIDLNfB/QPu0vOfKN0yB4?=
 =?us-ascii?Q?9ir96x7+4GqLa/6W+P6R/I+oPAdYhgPbW9du5qMXstWHL3OX/WqlGw0hPm/O?=
 =?us-ascii?Q?Znt509ph3S5EUpqVhmFzyqg/iVoqy84zSZ3WFAAFY73or7/KdbVCSLbrI7cT?=
 =?us-ascii?Q?ixO7/m4danDF4/MBuv6A/Jovq4X13fYg32KuCC2j3RvUsB5HsQ3AjR8bDTRN?=
 =?us-ascii?Q?xXiGB5X97orejs2SmsXLQKS76RE0SVhQFz7yQ8DkvnNRu8CvAcBMVPdfOnCo?=
 =?us-ascii?Q?Rue+NsFRAdp2pz2uGm9UYMGnG91VeOYMXuSFqujs7Glfj0vgTuJcenss/uz9?=
 =?us-ascii?Q?TTUjPruy8pcQ5MH4xbq0rqAZensSVAUS8MCkcWV/6nGaD8WnzgGE6DV0G4e6?=
 =?us-ascii?Q?9UvG5Wr7IjuztkX9eM8vg305wW17COAzYJBX?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:16:23.7545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cad4270-46ef-4893-6503-08ddace05fee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746

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
index 8b9ee8bac674..35479cbf98d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -32,6 +32,7 @@
 
 #include <linux/dim.h>
 #include <linux/ethtool_netlink.h>
+#include <net/netdev_queues.h>
 
 #include "en.h"
 #include "en/channels.h"
@@ -365,11 +366,6 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
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
@@ -382,6 +378,27 @@ static void mlx5e_get_ringparam(struct net_device *dev,
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
+		NL_SET_ERR_MSG_MOD(extack,
+				   "TCP-data-split is not supported when GRO HW is disabled");
+		return false;
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
@@ -440,6 +457,11 @@ static int mlx5e_set_ringparam(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
+	if (!mlx5e_ethtool_set_tcp_data_split(priv,
+					      kernel_param->tcp_data_split,
+					      extack))
+		return -EINVAL;
+
 	return mlx5e_ethtool_set_ringparam(priv, param, extack);
 }
 
@@ -2623,6 +2645,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_USE_CQE,
 	.supported_input_xfrm = RXH_XFRM_SYM_OR_XOR,
+	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_drvinfo       = mlx5e_get_drvinfo,
 	.get_link          = ethtool_op_get_link,
 	.get_link_ext_state  = mlx5e_get_link_ext_state,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 873a42b4a82d..b4df62b58292 100644
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


