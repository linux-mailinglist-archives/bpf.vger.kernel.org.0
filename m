Return-Path: <bpf+bounces-74282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9481C5165F
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 10:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CC33AC625
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7CF302148;
	Wed, 12 Nov 2025 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mL5wQo5o"
X-Original-To: bpf@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6122FF14F;
	Wed, 12 Nov 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939917; cv=fail; b=J0LiA0cZevt1F7YMvZiCm7zQu0r0+ZMjEc9sdcIO3zaagb0Ijbr+S3fDDLnkK9tkCJ5Vv8sjA3I4y9RnBnnNjfMDvIvbJaPUSF1AoftaWdmCuQ3tKOuM/kN0jAlDj5pWRP7qIl/DTIcGG+d9Wg1Ww3I3gcnP20HNc4Nt9sGuvvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939917; c=relaxed/simple;
	bh=PnktpKM4l6lAjItf9blT+lhWqjem6fsBXPiIv2E2d/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lq/o4OHb+9x7Gp3uDHFqFVuknyzO8BaDeDW3ocpZOLaRlzD7Br24bSKSrL3+hxnhaEwWRWGmSuikj1ukxNlPA0OIfhIDr0F2CNS4HFgI6fLpmJjLVgKH3cvqeLGww5wbXY35KAwfkIiVKH6NfcC/Y0aUfCEDyeDWUOXO5LtWq0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mL5wQo5o; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/qPxQfEwntEGUNkaEntbsonk6FxPjVQRXH5yuusAOKHwbu49V90gzLt5pQc65lHcKf3/UfdoSMl4oB5uJNMramLS4tITxbjCGqAwMqH8b1cigNFr+lq3qxeoEGWchw2Wr300sZtjwajGUyzQwh9dKWhudhvSeeu8cnolRLVKeZT8ET2NklKm1fQAshJNTqw+gXrQEzYtIFNiaBJat6RoXLTfWzK8B5VKZOrJs40SL5E4EXki7wWcyL4LXY9L7fiehWLb1ziYU3zm76hWOYwgw8Y7fiPgSN+BuYFlrdejLREN85jF3Y/o3nqh34v6sDJ5NS04JUUQ4L2n6l3AkY9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DufAX0vFPy9f7j5hEgzSHUe6poXgio0cdSXQ35OZBnY=;
 b=W5u5YAfTSP/ccX8gl+S7uKXsO15D/8glz/Usilju6FMboiR3q3sKeI76QsD0UTZ8qjcdCjZKYeYFrelQcLCErzW4J3T8js82x4eFgHPtmUuI5YC4gWtPUeCnxlNJCzJ+TiLonv8xjlRHXGSJUMtDIq5wsfBcEE4W8ehjGemBVMyex9CAmLsEep7AAjP/fFWBH6zdGNnkWnG47Rvlnbbf3PUw0Am7uCFuN4Wl0cS1Grnal6SxQlVUAkQGwKwpszKAcgPodQLkFLbn3fUEGygU2YWxN+TX8/vvDVpotTYzE6fn6fkoLKFIhAotlDpcyWBVNu6GgYmjNXXJ0g02986e2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DufAX0vFPy9f7j5hEgzSHUe6poXgio0cdSXQ35OZBnY=;
 b=mL5wQo5o1Mhn3H/JWBRd1ZIVdrrIbPyEItyNK1qWmhZBHf0p+G5Z58rxPDSZ5BBsLKLK0xYg+4Uiqa6mbhYx0xHvCjcDAJsgfV2zjTmC63CCLoJcVf7ZZiWDyGOvVVl/Q1GGsuNEtTZYP0aYjISnVQoyZMUFsQU74LDkaKRHP/wkMgSm4aY2U4XDoaTkP8QOMVqenS0woYJPnyVMQqq+xUTzMtOZZkShTWgn51CA3njC8GgU6b7NHkKPt8KifZlQISwzr/m4VVYGYa1uLWNhLIkh4r5usatlAFkbZZhc70qxJiT7ojPssEmd6mczAOa+qpnubTVkxhAFxei9P1C/IQ==
Received: from SJ0PR03CA0085.namprd03.prod.outlook.com (2603:10b6:a03:331::30)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 09:31:48 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::29) by SJ0PR03CA0085.outlook.office365.com
 (2603:10b6:a03:331::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 09:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 09:31:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:26 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 12
 Nov 2025 01:31:20 -0800
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
Subject: [PATCH net-next 4/6] net/mlx5e: Conditionally create async ICOSQ
Date: Wed, 12 Nov 2025 11:29:07 +0200
Message-ID: <1762939749-1165658-5-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: b80174d8-35f1-456b-fec7-08de21ce4dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2EdaqXqxp8F3fqaNkXiO6C1S+plP8r1nSZDvr2OS5oSHMm/HMBJIwNHeAOC2?=
 =?us-ascii?Q?jfBHkZ6qydpA5Ta9lvBskgButYvKhQ/UYenmm7XPZ5rL/63U76402IpKu9LP?=
 =?us-ascii?Q?BkiZnSfhk4wbci73VFJDrjiZJTmSRyAmpfhG5S9bwuIJEQQ5pHCJaviUvXN2?=
 =?us-ascii?Q?wAYjhoPLl8jC+qNmU+YsU2dUW7afuKgRCzL0nCDgJ7djdfiHRihB6P7KehNN?=
 =?us-ascii?Q?1pAswdl5lz2ncLGQHa19h2AmFIBuA4VmlRecHz2V0wzKs3q8zEAqs3LCHSW2?=
 =?us-ascii?Q?tBOm0WUGmXQNCGwoz/C/LYAIPUi0hvtwV9+Ya3YGkN/gFW19lQeK2JyOBbLt?=
 =?us-ascii?Q?YK0NOOHYMl1WhJJjqCf6lQZ3SoRIXHzDe4N/3c2cUjWDk4IeaC9wLN+o4NLr?=
 =?us-ascii?Q?V/1WHPWfBUqolnrsBRAZHd6IAq2umkI/+qNLRiVRFyc5V0nhzCmT6Nxs/Unb?=
 =?us-ascii?Q?8sIXLE1pxkl26s/ymu4sw128C4ZxqWodWoOAw9IGWXr8bD6MUIDfsMQ7yh7d?=
 =?us-ascii?Q?1byqLthGQFVfYva1On7BevWAjEDPsC17Rs2gSNN1BnaXBCOG3AsFvFaQ1wcK?=
 =?us-ascii?Q?cAq+a08Atcg4a+66d0RxmiFlZVAfhr8rmxpjt97NqsCLVi6oOxeZdrJ96kIL?=
 =?us-ascii?Q?glpp78czCGxJ70r3UIbQD0rWhlDU4ogGi4jxltc+2ADdczflRnTKtCeiB8Ph?=
 =?us-ascii?Q?YtGc1W628vI987l3rV/yK9r3G3KaM0LYvzWjFjF6y83BFY5G8kDJr9ux5nWQ?=
 =?us-ascii?Q?l95A1KokE5hBqRzd2bv9+EId+RniZHGMTmE2Cj8OsWVuj0i1Dg9E5SF6nBjG?=
 =?us-ascii?Q?5+1D52tsjEUygd2zosQsGRMHHp6FxCrGyUbLK4uWK68GiiZKAUPjyKZxMtHs?=
 =?us-ascii?Q?wHQEXutF9XW5eBNxWtiPI9evjnmsmYLtR+6YF2MVf3RV8QvJ17T5qvJpi8e3?=
 =?us-ascii?Q?tQoqB45WKXa2lkb1VX2GsNm0z4Bbs8f8B2NKMDtetHsZwlx4X1QHbffwC+J3?=
 =?us-ascii?Q?9RDYP2TkSnYNDWSgmZO8C46Th5Pxh0uiQvPEXd3alSF1maFSaqBST3pOsR9a?=
 =?us-ascii?Q?jF6YuzPsJYLZB67N2F8jQX0CaWYHIuC9RwodxSumOuI5bZsn3cDJNzGueMKJ?=
 =?us-ascii?Q?s6B6pX1iAzJQS8LBsijp0xOm6h0oefLA0ljlfaitph2685esgltcw4v4TTls?=
 =?us-ascii?Q?iJg/rnknRWP+VUjkBEshInGE/sV3u3m97JVVxTZ1Rq42JEwmnMYswyCmvaXD?=
 =?us-ascii?Q?qDfoB9CB1m2lLnB5VPMUWee7MyTvZfd8vd/sL588mzaldWk4/KMC/Qgf3CI3?=
 =?us-ascii?Q?ua9umLdUpBrNukKMin3onlZ8Hh2ZDH5SHsGm87KJK3ngj9uuvb7X2WWLT6qp?=
 =?us-ascii?Q?UBnP4yV6/KpcAFBOm+umf5pdQnzN08jNfpU6eGiLCdOTGJlCUCd2qVoYTc4C?=
 =?us-ascii?Q?xK7lLKd/Fly8RS3NBEoHcBD6DeY7NlEeKgj4pEWzYIeq+Ksg0pkGrFj4dwRJ?=
 =?us-ascii?Q?hdaB4Q74ta9td+c8OgjhNxP1gSsEnEMQOi+WK5cZGhaSbPAEv2CkcCtJMcgW?=
 =?us-ascii?Q?wgQMyUQloisIsz3N7Bk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:31:48.4849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b80174d8-35f1-456b-fec7-08de21ce4dd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884

From: William Tu <witu@nvidia.com>

The async ICOSQ is only required by TLS RX (for re-sync flow) and XSK
TX. Create it only when these features are enabled instead of always
allocating it. This reduces per-channel memory usage, saves hardware
resources, improves latency, and decreases the default number of SQs
(from 4 to 3) and CQs (from 5 to 4). It also speeds up channel
open/close operations for a netdev when async ICOSQ is not needed.

Currently when TLS RX is enabled, there is no channel reset triggered.
As a result, async ICOSQ allocation is not triggered, causing a NULL
pointer crash. One solution is to do channel reset every time when
toggling TLS RX. However, it's not straightforward as the offload
state matters only on connection creation, and can go on beyond the
channels reset.

In stead, introduce a new field 'ktls_rx_was_enabled': if TLS RX is
enabled for the first time: reset channels, create async ICOSQ, set
the field. From that point on, no need to reset channels for any TLS
RX enable/disable. Async ICOSQ will always be needed.

For XSK TX, async ICOSQ is used in wakeup control and is guaranteed
to have async ICOSQ allocated.

This improves the latency of interface up/down operations when it
applies.

Perf numbers:
NIC: Connect-X7.
Setup: 248 channels.

Interface up + down:
Before: 2.605 secs
After:  2.246 secs (1.16x faster)

Signed-off-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../mellanox/mlx5/core/en_accel/ktls.c        | 10 +++++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 30 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  5 ++--
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 3a68fe651760..fea26a3a1c87 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -958,6 +958,7 @@ struct mlx5e_priv {
 	u8                         max_opened_tc;
 	bool                       tx_ptp_opened;
 	bool                       rx_ptp_opened;
+	bool                       ktls_rx_was_enabled;
 	struct kernel_hwtstamp_config hwtstamp_config;
 	u16                        q_counter[MLX5_SD_MAX_GROUP_SZ];
 	u16                        drop_rq_q_counter;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index e3e57c849436..1c2cc2aad2b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -135,10 +135,15 @@ int mlx5e_ktls_set_feature_rx(struct net_device *netdev, bool enable)
 	int err = 0;
 
 	mutex_lock(&priv->state_lock);
-	if (enable)
+	if (enable) {
 		err = mlx5e_accel_fs_tcp_create(priv->fs);
-	else
+		if (!err && !priv->ktls_rx_was_enabled) {
+			priv->ktls_rx_was_enabled = true;
+			mlx5e_safe_reopen_channels(priv);
+		}
+	} else {
 		mlx5e_accel_fs_tcp_destroy(priv->fs);
+	}
 	mutex_unlock(&priv->state_lock);
 
 	return err;
@@ -161,6 +166,7 @@ int mlx5e_ktls_init_rx(struct mlx5e_priv *priv)
 			destroy_workqueue(priv->tls->rx_wq);
 			return err;
 		}
+		priv->ktls_rx_was_enabled = true;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 2b2504bd2c67..d1dbba1a7a2f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2633,7 +2633,8 @@ static void mlx5e_close_async_icosq(struct mlx5e_icosq *async_icosq)
 
 static int mlx5e_open_queues(struct mlx5e_channel *c,
 			     struct mlx5e_params *params,
-			     struct mlx5e_channel_param *cparam)
+			     struct mlx5e_channel_param *cparam,
+			     bool async_icosq_needed)
 {
 	const struct net_device_ops *netdev_ops = c->netdev->netdev_ops;
 	struct dim_cq_moder icocq_moder = {0, 0};
@@ -2669,10 +2670,13 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	if (err)
 		goto err_close_rx_cq;
 
-	c->async_icosq = mlx5e_open_async_icosq(c, params, cparam, &ccp);
-	if (IS_ERR(c->async_icosq)) {
-		err = PTR_ERR(c->async_icosq);
-		goto err_close_rq_xdpsq_cq;
+	if (async_icosq_needed) {
+		c->async_icosq = mlx5e_open_async_icosq(c, params, cparam,
+							&ccp);
+		if (IS_ERR(c->async_icosq)) {
+			err = PTR_ERR(c->async_icosq);
+			goto err_close_rq_xdpsq_cq;
+		}
 	}
 
 	mutex_init(&c->icosq_recovery_lock);
@@ -2709,7 +2713,8 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	mlx5e_close_icosq(&c->icosq);
 
 err_close_async_icosq:
-	mlx5e_close_async_icosq(c->async_icosq);
+	if (c->async_icosq)
+		mlx5e_close_async_icosq(c->async_icosq);
 
 err_close_rq_xdpsq_cq:
 	if (c->xdp)
@@ -2741,7 +2746,8 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
 	mlx5e_close_sqs(c);
 	mlx5e_close_icosq(&c->icosq);
 	mutex_destroy(&c->icosq_recovery_lock);
-	mlx5e_close_async_icosq(c->async_icosq);
+	if (c->async_icosq)
+		mlx5e_close_async_icosq(c->async_icosq);
 	if (c->xdp)
 		mlx5e_close_cq(&c->rq_xdpsq.cq);
 	mlx5e_close_cq(&c->rq.cq);
@@ -2827,6 +2833,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	struct mlx5e_channel_param *cparam;
 	struct mlx5_core_dev *mdev;
 	struct mlx5e_xsk_param xsk;
+	bool async_icosq_needed;
 	struct mlx5e_channel *c;
 	unsigned int irq;
 	int vec_ix;
@@ -2876,7 +2883,8 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	netif_napi_add_config_locked(netdev, &c->napi, mlx5e_napi_poll, ix);
 	netif_napi_set_irq_locked(&c->napi, irq);
 
-	err = mlx5e_open_queues(c, params, cparam);
+	async_icosq_needed = !!xsk_pool || priv->ktls_rx_was_enabled;
+	err = mlx5e_open_queues(c, params, cparam, async_icosq_needed);
 	if (unlikely(err))
 		goto err_napi_del;
 
@@ -2914,7 +2922,8 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
 	for (tc = 0; tc < c->num_tc; tc++)
 		mlx5e_activate_txqsq(&c->sq[tc]);
 	mlx5e_activate_icosq(&c->icosq);
-	mlx5e_activate_icosq(c->async_icosq);
+	if (c->async_icosq)
+		mlx5e_activate_icosq(c->async_icosq);
 
 	if (test_bit(MLX5E_CHANNEL_STATE_XSK, c->state))
 		mlx5e_activate_xsk(c);
@@ -2935,7 +2944,8 @@ static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
 	else
 		mlx5e_deactivate_rq(&c->rq);
 
-	mlx5e_deactivate_icosq(c->async_icosq);
+	if (c->async_icosq)
+		mlx5e_deactivate_icosq(c->async_icosq);
 	mlx5e_deactivate_icosq(&c->icosq);
 	for (tc = 0; tc < c->num_tc; tc++)
 		mlx5e_deactivate_txqsq(&c->sq[tc]);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 57c54265dbda..ec7391f38642 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -180,7 +180,7 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 	busy |= work_done == budget;
 
 	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq->cq))
+	if (c->async_icosq && mlx5e_poll_ico_cq(&c->async_icosq->cq))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
@@ -237,7 +237,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
 	mlx5e_cq_arm(&rq->cq);
 	mlx5e_cq_arm(&c->icosq.cq);
-	mlx5e_cq_arm(&c->async_icosq->cq);
+	if (c->async_icosq)
+		mlx5e_cq_arm(&c->async_icosq->cq);
 	if (c->xdpsq)
 		mlx5e_cq_arm(&c->xdpsq->cq);
 
-- 
2.31.1


