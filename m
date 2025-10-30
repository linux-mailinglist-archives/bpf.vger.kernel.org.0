Return-Path: <bpf+bounces-72989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8428AC1F89C
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4BD44E9D9C
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A39C3563DC;
	Thu, 30 Oct 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="skdK5yV+"
X-Original-To: bpf@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2E3559E5;
	Thu, 30 Oct 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819984; cv=fail; b=kwOu8giiH7p0Mddqkuq6ReLld1EHEKY20LTCmO2LGKDltm6iVAmAHbKVPUBbpZsUT0ZBrkXhJhfLPOOACEMVm3kVL8idUfnX+4Syi9hYh3BfMu4VYVeRgXQ+wCPWBcTXYCvBysw9I55AamhYk2vCNbs2JSFx25sDLvQigZbLs3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819984; c=relaxed/simple;
	bh=QgqbTVB1dN9VI9lWn1pWWF+uFbSB6k/3pIfCj2vNLeE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKKKjyx/fUSgUFIuS6bcBX790F2iDrY0kZQpLMGoMH9HWz4fnEm5+1bZriagYmKr4PJcMlm2+EXxo4HYHbprop8TVR/ca9Dp8CLjuQLijm23hxDoHk+wYdUEDlmyPO6hTo5te1sW4x7eMoaj0jJ9Czc5HYcq1v2bbvba2TESoJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=skdK5yV+; arc=fail smtp.client-ip=40.93.195.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IC+/8XyztPhToYVRIJ744JxRECA8lInWjsJL0KXoG/we/dnv5KseU7ZGehYSEPEeI+QuUmBgsCz6iBiR0C37EKfUlK6ZtSHyN9v7bA/q/QRYR5nLmnoy6A1k1iIF602DSn15dNAhRkP4nGGVprIIVwETAX60+yXN85lrE70pktQV+f6z1l6Uyomp40CtwpfKb+Z2scIteHxAUhYDPKBmaTOGgAanla5Wbuan92eYNHoC/i68YsyxhRtM2IN68HM235q3DfoTQQ84/KsekTrhgfbm9zWEmg2LYJQozfOUEUN2Mn7O06vqXat5MQt92mw9PLaatKWruE37l6Ds3qfx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acPTaCYYGcmIVy4VyHIHr7goSCgIpxsyXGn3BtJ/nlw=;
 b=WNvqtgQ5AK9JVa2/q7ReHtBAqPt6tXBHrIG/6DY/D3qUSk9P8+l8kOfD46zUjFfGtwSjh//uQDEQ/7iXdAe1vIX6o+sw+Pnjt1kfTGBLvyjqKtxwG5IK3zNteXdQHi6QKKEaglHCxUEFYQIkMUUCM7uHhA9EzOQ7LBCb0F2PwWKCrFtSeD+Pun5Henp7TT83Zubm7dpf0gYdqI/Y/HLb9GvxrNV0+m4BNs4A2q1Z8LwVbS5hOe2k/koEWkRfR5E0szgHHUVafGpCMGcxw7jSQDmKinCwBpOf4xHYrsPE/XjZEezoia0gFpqXEJoXn8kGhVI4m7Uqe8aqxE1GH2nn8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acPTaCYYGcmIVy4VyHIHr7goSCgIpxsyXGn3BtJ/nlw=;
 b=skdK5yV+Jren/lg7JEnnaiZX5fQGzXCKH582RK+X8XxmhDFAXoWYuAqkMdeK65obINKzWX7m9x+ZmmkOB00EsUhVur90SpJ1gJd6pBKPlDQF5BhB79PHw2GXwU3arnyeqFy8WUMD8jujiVjgc8pmKBgun9F3PtHHTcpSBbk7i9oP7VpgmWSzgCFm3OLFsBr3NRm0Pk3kqXs4QL8PNg14KxsNFIklfDcToXBpzsGt7a8EmssmdhMsQMxGw+HJc45MctkIhRP9PIvUPvmqteoM9mZPTAAcspWMtzXZEEiUPx5hwcwH9ims25TLYSyVzIcPm1qqu6mXzGSG+hm1572lGQ==
Received: from BL0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:91::22)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 10:26:19 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::a8) by BL0PR05CA0012.outlook.office365.com
 (2603:10b6:208:91::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 10:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 10:26:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:26:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:26:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 03:25:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 3/6] net/mlx5e: Rename hwstamp functions to hwtstamp
Date: Thu, 30 Oct 2025 12:25:07 +0200
Message-ID: <1761819910-1011051-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761819910-1011051-1-git-send-email-tariqt@nvidia.com>
References: <1761819910-1011051-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 586a0c6d-d1ba-4af5-4e80-08de179ec3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qKyPGV8tjNkw/s0Cepa2RKQM8GM33Lnc75m3B/XapaKXcSLcQo17UdYgqbQd?=
 =?us-ascii?Q?tUvLSZBHGAFB0335W90+hBqr3agOBWTRrJZnvRVSNvD9AbxZ1CCml592S7NF?=
 =?us-ascii?Q?XOkq/RFCgxfibbGHgM5TaHLCYwKYOvMbCuRDkL0uY0bLnrjdeVWkULDUmXV2?=
 =?us-ascii?Q?fjhcBYeeH9ywUhfL4GMyxO+8DZLj7dEYkBXaQJFt9m2kX3Qe4NdhNIlIJjYO?=
 =?us-ascii?Q?WHO1FmMHWKVZo0gGW4sMgQNg04UAgsZ2MoNHFp7T+Rd26z8bkd3pcLfQpnex?=
 =?us-ascii?Q?oKzthhXiKpM3OWLRZxdhKtyRA9fcxWnVuD6YMPkEMpMT+CNx/+b62N9llqEG?=
 =?us-ascii?Q?4iPl5Q8/yUrpMTtAz0+/Dzq4h3x2k0qovX9jwMwcMySlyVaPgTGKZ25HGO6v?=
 =?us-ascii?Q?f3HkvDE6u7/WWG+QQ3baP+otFv4FbARib2l8CuXbD39RCgqSckH9qzrjOFQt?=
 =?us-ascii?Q?wztqjilt/zHyDjSPVzMHfCMaTZfWzBOL2jWg0u8Nbb0oUtVdxix01lUWMcjk?=
 =?us-ascii?Q?kzNMfpah/xqMBkjlJZaVn7jZynjG5e9EMbXL4QyHu9eEmnAxieNfLx+5kfAu?=
 =?us-ascii?Q?h444woSQ2G61rf+24Yxs/IQlDd3B76QLWJO4mjgUmNxaUZFW7pdJbyLq2wsG?=
 =?us-ascii?Q?QMZBe82Uw+hb+L0rXPsMZWDMmgf4bpJ3OKDLWj4bajIp+I4WDYTXSuTYGpq5?=
 =?us-ascii?Q?b80goqD8XxvRDrplVTrNAdleFi7kld0W6T6o48YGY1VE8R9hILJhD5M1rqbo?=
 =?us-ascii?Q?hj78qRpnkrJjT+6XkgGzZPhrlF8TOQX7Jm6xo3a0tGTGolXKBkWo3ckWYAd1?=
 =?us-ascii?Q?pQAOk5H4dzGhDVud/jxKw4Zwxhm8YqF6XU2Wz5u8v3kLjloZ7lNxjw3KPDG0?=
 =?us-ascii?Q?FE1MRsvTrj+JMXo2RzsESyVaumAEBoOmSMNd7kJ4f+Ix4+yfTddpA0a6TXg+?=
 =?us-ascii?Q?Dsj886MNubP/vn4XL8A5k1Ub3tE0DnLTYA3Ol8vjBr/dc2E6J+UnO+g0pu7f?=
 =?us-ascii?Q?i12k0CBfC9sR8TMRNyb1HXRkvuhdsC44oIskoVI9pEjt5tf8l9BmTg8ZluWb?=
 =?us-ascii?Q?P85fvMEjvDWz5yXr2TjjO3qY0YmBDFG1+4SutdXIzCwspOQi0uLGuPmaYKXL?=
 =?us-ascii?Q?JzBXonTmCimiWYMWGVKO+BInTFM2VVgZnYtHUeqoHA+Ce6mLXbJrZYK5uT13?=
 =?us-ascii?Q?SyqwUN0elb+OawhoTq8hoeua2cO3WeYrf7Is+YrWR3DLLPHjX4pPSnfK9GJx?=
 =?us-ascii?Q?Whv6a8NfWgvzhD9gSO7vvdjRpfT1aC4bJrG9SCVFpvyb7Xiy/yMVIMSTm6UF?=
 =?us-ascii?Q?OsfiXNQS9RjPNEK26g7lJcCAE/WWNVD9RdSfZsE4rIo/xAH2byHdUlKc6BoJ?=
 =?us-ascii?Q?7M+0L/NDh+jZkujTom8m/UnAQvIfTOEwA/HY8Kay5oE4CqNN1NpDktOjMezm?=
 =?us-ascii?Q?bC+XBNBdHZW/wqiMJvM69cmYfT+W2t4UKFULu5n5gRqO1tusld7Z6Xv0tXWd?=
 =?us-ascii?Q?Pwf456lzSskx5+M0J+NmXYTHxat1W3IC2FHuiKS0+0UYpghK+R8AX9aS1Bby?=
 =?us-ascii?Q?U8mTUmMoSK3Ik4K8U6s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:26:18.8340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586a0c6d-d1ba-4af5-4e80-08de179ec3ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496

From: Carolina Jubran <cjubran@nvidia.com>

Rename mlx5e_hwstamp_set/get() functions to mlx5e_hwtstamp_set/get()
to better reflect that these functions handle hardware timestamping,
not just hardware stamping.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h          | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c     | 8 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 5485cf014926..ebd7493888d7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1026,8 +1026,8 @@ void mlx5e_self_test(struct net_device *ndev, struct ethtool_test *etest,
 		     u64 *buf);
 void mlx5e_set_rx_mode_work(struct work_struct *work);
 
-int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr);
-int mlx5e_hwstamp_get(struct mlx5e_priv *priv, struct ifreq *ifr);
+int mlx5e_hwtstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr);
+int mlx5e_hwtstamp_get(struct mlx5e_priv *priv, struct ifreq *ifr);
 int mlx5e_modify_rx_cqe_compression_locked(struct mlx5e_priv *priv, bool val, bool rx_filter);
 
 int mlx5e_vlan_rx_add_vid(struct net_device *dev, __always_unused __be16 proto,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 20f55542433d..2ecbd735584e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4740,7 +4740,7 @@ static int mlx5e_hwstamp_config_ptp_rx(struct mlx5e_priv *priv, bool ptp_rx)
 					&new_params.ptp_rx, true);
 }
 
-int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
+int mlx5e_hwtstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
 {
 	struct hwtstamp_config config;
 	bool rx_cqe_compress_def;
@@ -4818,7 +4818,7 @@ int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
 	return err;
 }
 
-int mlx5e_hwstamp_get(struct mlx5e_priv *priv, struct ifreq *ifr)
+int mlx5e_hwtstamp_get(struct mlx5e_priv *priv, struct ifreq *ifr)
 {
 	struct hwtstamp_config *cfg = &priv->tstamp;
 
@@ -4834,9 +4834,9 @@ static int mlx5e_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 
 	switch (cmd) {
 	case SIOCSHWTSTAMP:
-		return mlx5e_hwstamp_set(priv, ifr);
+		return mlx5e_hwtstamp_set(priv, ifr);
 	case SIOCGHWTSTAMP:
-		return mlx5e_hwstamp_get(priv, ifr);
+		return mlx5e_hwtstamp_get(priv, ifr);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 79ae3a51a4b3..11d950f58ae3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -563,9 +563,9 @@ int mlx5i_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 
 	switch (cmd) {
 	case SIOCSHWTSTAMP:
-		return mlx5e_hwstamp_set(priv, ifr);
+		return mlx5e_hwtstamp_set(priv, ifr);
 	case SIOCGHWTSTAMP:
-		return mlx5e_hwstamp_get(priv, ifr);
+		return mlx5e_hwtstamp_get(priv, ifr);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.31.1


