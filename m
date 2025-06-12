Return-Path: <bpf+bounces-60483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30778AD772F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F33164E9C
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C493B2D4B65;
	Thu, 12 Jun 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Su5xITaQ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3611CA0;
	Thu, 12 Jun 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743328; cv=fail; b=oPxfZXsCl/59HB45wZymBYhbQIR2adKAbKfBWNW7hB6F+2m3sl9MNq5sRv2P2QCEoaJMDkiNLQJMUGfD4cAtSQYdIfn1vUPefsn+Em2haNs3nTiTt4dFB/wf4/+T6mK2yCHv34WJmqwq6phyFUF0kZ6ckif2Hi9RpN+8MtfHhkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743328; c=relaxed/simple;
	bh=u5bCwSYJn2a1dX0NlLwRZShpAYJyAY8+sGmxjkf803s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzzMTZI2rt6ka/DqnMt9VBgxKdyfycCEpI21AmhNwVB/SDdFwaBZ2XASVww4xTLp+r5icl5LYxpicnUqoozVvygElajrZCsnzS6vJ/9iDQuW4hj0SjYHj/TaF2IK2Ysk6n8CpfaPBSYlxI6BXUy2CuIa2hOBWBLhdt2maUfH6tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Su5xITaQ; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgfZdnTpvyPTvQHIiGRDi5aQxAdnbjrAkWKWCJmDgZZQc3bz5Mtfz3BbJ+0smJGhA74F3BWivIxeF6NkkhcD6KQcfCc4srpqqD/N8M26UAx3bJl/3qZ5ddX+BSmUG4WHH1FHk5tfYmFtMt+02YY2JZvGTYuB8G+Y6j8jZVu7Io7OPAFP7kX1EZpsLDc34PbejPs3tNvaebxBuxdMIcx0XEze+wGGPPWMFAXPV6wE7AbMh1491UuOt1AJ2Z9IrZj/bKKorX7tHKIFxgO2zaWYpk9sKRcE0ilbDOBDIH8u4UFBnclKQ4zY9GqOhvJq3qJKz8bTokBRAYBz8hOgSVjnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxJaiiPbsvq9+bJ7i5vFS+MBlGVWQgIlqwUhdOE3M0o=;
 b=Uq7zzhzv4kbErKRnGiEOVaZxFO4VvV3V3jZvG2guDnxP6ircVFrZkY/zwxXD5L43iyHxzula7xG0tTJ2gSp0mBMn+SN9nLMQQrCxu0CYFGHoYsfGyg7zWxz/mxGCsbYr/fST2LC/mBAOuUajW6mGBKnCQ0OW6QnlJx8Opr+UcqoWN3o7r/SX15OPhJDG4ewp2YNETzXJYBrZwtkOhUEP0PF6pahoOv4SOo11BWIEW3NUtcIu7BGj0mCtJHK62n/T0RAHknRfVDkgxbIPOjjA2o2Stak4eSrhUPFbyAk36tn8RiA9/pq1g3wXJCCmMuzKOrFROfl5IjAr2lfdvhRcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxJaiiPbsvq9+bJ7i5vFS+MBlGVWQgIlqwUhdOE3M0o=;
 b=Su5xITaQke9TRLAiG2T7GNlvCrn2Y/6Nu1Zdc/g/xfEBbAVV1Ey0cVu+EzLoh/CCveVsIi4y252XSDv51cST6q3BobtviHHiBKoDQI7QccLLCI2DewOIuzI+0xCPRVw19TTUScZ74WwjhRNSa54unhAOqxOq4ArkREYLwT976/FsCl6Irufhfz9kWmqLoIXxeHCxwGiFABwaoFRnOkfsrXATmdGaE8rkQbL4+w+K0LAQ7R2V6pmv60SqP5BTJgJzVjklyum3mT9ovll0R6sdm6wMrFAfe41GrBIDXmg7tp5Q9D7NyIOhALm3pkhV/0DK5ik+CiO56uwnjeada/pXnA==
Received: from SA1PR02CA0007.namprd02.prod.outlook.com (2603:10b6:806:2cf::18)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Thu, 12 Jun
 2025 15:48:40 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::a6) by SA1PR02CA0007.outlook.office365.com
 (2603:10b6:806:2cf::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 15:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:48:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 08:48:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 08:48:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 12
 Jun 2025 08:48:12 -0700
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
	<bpf@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v5 11/12] net/mlx5e: Support ethtool tcp-data-split settings
Date: Thu, 12 Jun 2025 18:46:47 +0300
Message-ID: <20250612154648.1161201-12-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: ac38f44e-d126-44f5-4a4a-08dda9c89a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ODcFnLHmtQy5rLSYPdR/QtWX/TrJ51iBcfg2d3yrAxyIPGaH/O/Xsd18E5Py?=
 =?us-ascii?Q?qOpYfrCfdYxzk/HImE6tmW2wATtPbOr5/L98gsQiayhp5M538RI6aLF8Skj4?=
 =?us-ascii?Q?/Y2LCFcKmzB/pKHwDLUhkmLGDia6fA+rffx/xb2UN/w2QcqpO6q4qx8lOzkA?=
 =?us-ascii?Q?szmJJVA81JWWtOGn7Q1+zFe7SYDCN9f1iPgcvZz3vzlC+QaIAZ38hk1FvIKQ?=
 =?us-ascii?Q?RYtQ3Lr0qYP1nxr6c8i+1lqBCw4OblKzr44fioy2jgWWIFeURpblE3fR/XUd?=
 =?us-ascii?Q?IrQCYc6c4Leu44mwbZrAUsNTbtz3fNFs/iOqakaoBGavchFOzGPNvDnjr0l9?=
 =?us-ascii?Q?kB6z8CLJy7b/jgroeFCj6fyzkZWvCP9qvQfgIkln37y5t7TQctKd85Ott1fd?=
 =?us-ascii?Q?uGDbnPxkK0wGN5YZ7hnzukYCOlbLuZpIw+oDAGbAfh26xT/NRM0yv+8OdgSq?=
 =?us-ascii?Q?OwC2c8Ryzpu6wdXOOAapFBV8DhrYKtcyIjbA1JtcVLDlH/EYYpDkgkyeST1b?=
 =?us-ascii?Q?ON93L0k0y7I+eTJNmno7rCPc5H91Bqi0PMaEZ3qoi1dgu3DJ/Ddo4s9PAzwt?=
 =?us-ascii?Q?n4cjKWRtLxcZnUsbLPAbqHTCMGxfDD0cI2pQ6iJ4nVlV5yMOJ9+ml+fTKB9h?=
 =?us-ascii?Q?W4xzNA30Q/QdO5bseJ2Svadb2vEZMCZP/Eb0KK00NfiVzNE/PzYeLTRhGcPy?=
 =?us-ascii?Q?cl59hz5v7ViqwJdKmNOowsUF+rtJiBuLeCBnn62vsHY8RCWGuKfInpuZ6U8R?=
 =?us-ascii?Q?4CMx9ZmWYzyJ9WBkGcJjm1OxkWopCBMVmMzqzljLF7thymQvGPPZOXW/VRlD?=
 =?us-ascii?Q?FOr/2EY1Qn4mMsGnlmWcK5oy8RYkMnWHnzDNbMK7sT46mYG8xUn56lJDG/pe?=
 =?us-ascii?Q?h0CBdRJohDaF85Gpw7c5ethXffIHs/55K+X3hjHOKgGhfH40jeq+FJt+pCeM?=
 =?us-ascii?Q?3Y2UKMn/S2VVMyomWRH6D3WHk+Ci0SL6a3P0wqRX1OgkJgkp+fi7IwgK8yqS?=
 =?us-ascii?Q?c3V3qbAlEZg8PSDxTIlgkG3xude+ek+815oCwe6lVkYaMDpjtr0SBuSjmzXi?=
 =?us-ascii?Q?Ndlq5OWr5Dpb6MS5ACl2zXhJLPWP4vwpY+dIuW+MCaXeRLrmI4OfJbvszQHv?=
 =?us-ascii?Q?AO48LJoOxkk+OHkPzZ5+TYOcNuL4ULC6zcYLD5M82W0ZgIrJqDAkGOOR8UFr?=
 =?us-ascii?Q?proy0Y+KSF3nb+qRdyDLF9Yi8yP7Q/pGLxrH9ckUUk1kCrgVMIQEMXYwExSq?=
 =?us-ascii?Q?EBt0KVuKIRB//C1xYGnHxw1Ux5zTPjDTO3Ks0l1cxaKpkXgkSSkqQhz4Evaw?=
 =?us-ascii?Q?nNFfV8eHnaDIRGKB4+iYG91k+sGpKn0HSBS5+1cOWUXRC7loygCvZyBVATv8?=
 =?us-ascii?Q?/IoKfSCJDf0S13LZP7+04DZOsTuYkRdLFj8hYryqwqJqI3dQT7F6acnjAPNu?=
 =?us-ascii?Q?dtsuLimGzf9tbQu1mRSOlnsYRZo1tnqWsu25MSwQYQd0LNySPgT90XJKBuMQ?=
 =?us-ascii?Q?4Qw6va6hBNS5pLjR7lcbgX10iFZ6W1suYdeU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:48:40.1898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac38f44e-d126-44f5-4a4a-08dda9c89a47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751

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
index ea078c9f5d15..1761945e858c 100644
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
index 06a057ecaecc..1be149aca1e2 100644
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


