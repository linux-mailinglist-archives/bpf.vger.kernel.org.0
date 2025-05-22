Return-Path: <bpf+bounces-58769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 332DBAC162D
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254CB506077
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAB26B2DF;
	Thu, 22 May 2025 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PC4RZx+X"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEA02580CF;
	Thu, 22 May 2025 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950215; cv=fail; b=IklHwUMHEY7ZT/2vYToYgHLe6LUzelmreh0lFlJKy9G0BGW1bE0S1f307dhCOLZ0u49OyHMpIvYVjBg2ylK3kyW7GFbBNo5JXtwz9WESYYhcHVEcxm2sX2pSylQJdTUhWRa8xis2bmreaBurySt2WivP6Kjm1MsndXErfMy0pO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950215; c=relaxed/simple;
	bh=fITbHzJLVssk6cU2+FxV3Mqg33AFEiH6q6YwIccmt+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfdduDxJ3IxQ7PmUhLGRwcYIPoYJZzLZq67WE+zTaeqSj6zxPTzfPxdOrqU8TMlT2UL17rZmnlwADqMu4eCLe7/PHfJpizLWeTKLHDAUa+11xgOc2Y8w/BbM3ZCDrZjVBZcCAWHAxb9zu5098GmOm0jRnzcsGB354M4tQXKiIaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PC4RZx+X; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWCbFZBzoCcm4H00r+18KiWUE6/7zEElH4Xr0egSC8tPa/vpX0HdlGCQb5ftvxgaCs3Jg+p7yL1nQN3eXrtvL4eZbllSGv0P9RMbhLdo4M+nKCN6u8e5CT5q9Ko8VyOktWdxiRPwYfZ0RhuG7fXNvhxmABJfgVVbKZ5QP0YyHbRxfSXWwubXvOgTsJ3EOy+JAleEW4AUjUn3IH1hIIjxA7KXMwedqdHJoKIM7sXUc5D2E3cTAJWt6gOACvqyRwtB/XYXjbkaF4+/vR5qagTGF0mA9RPIMuqSOwRep6cPKE/x5t92qrhKZbGjaZLtAbDp1EQuO2mYSjP480W8j8391Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsJN5GGHZqFWs/WGAH1svlBstTrkDcts6oKcciyvtxk=;
 b=iuWQp83defHJKE6oyzgb3Fx+zO0UcdGMGFhoGydOVBe/mfLhyDzW4mTREphgqaXmMvwmScR1gAtVIbKp3ORKU65tT+IWcNFdN+k8KbyV2oEp00IKLz7n8HG9VMuQ0c9v8uqe6G4N7LmeC7JSkithtH3btb5sOuye/vLEjVKC+V3Wa7J63s7Fhg4uTHhtzoiTkIrLVZcCmZzLlCEefAzXAMo8/00dUNYUAerIOYWfIvRvtGrq2GFBGsCe6TpmXWnUKbFfKxB69sNK8K6btbWYMUWHeVVoccsqwejZYPit27slW+N6cZQ5EB4Ev0byrDesJb+JyCP6MmRNaINnTCeLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsJN5GGHZqFWs/WGAH1svlBstTrkDcts6oKcciyvtxk=;
 b=PC4RZx+X+nBPETv+A1vLpqKE1hrRS+GFwXoRDYahmTJX5jj6MEBjRptXC9erGIifwTnsajPPYavz72gRz9S8ywS1HhjbJzrQQtwsFaE5JkR6OS75CnNQRDKtfU8ok/bpg01LprrODgqVSiHM08rKWiEcwFdqZIDrY0lnTUobT5dSlfeVxQVS8+cLkjZM7ChVk/reVwUF6BhLvn/zgCMQF38GADcdTVWJLeGyKahyPyudI4mpPCM2TIFhUiS4Z/M9muvPG8tEcvfkujAJujBQCjIklhnI6EnRZooS+fqTsiKwWuurQurHJoUKyMSlR9Vs8eJeBhcK3N9+lV+BM9ibFA==
Received: from DM6PR06CA0062.namprd06.prod.outlook.com (2603:10b6:5:54::39) by
 PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 21:43:23 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:5:54:cafe::29) by DM6PR06CA0062.outlook.office365.com
 (2603:10b6:5:54::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 21:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.4 via Frontend Transport; Thu, 22 May 2025 21:43:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 14:43:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 14:43:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 14:43:06 -0700
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
Subject: [PATCH net-next V2 10/11] net/mlx5e: Implement queue mgmt ops and single channel swap
Date: Fri, 23 May 2025 00:41:25 +0300
Message-ID: <1747950086-1246773-11-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 3093ed20-b42f-4019-85f2-08dd9979ad63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fmVG6E0uB02lNdqKrRVB/1X+u1q+vjf0+K6sGBGAcaSHpWUhnuPCeRe3ferQ?=
 =?us-ascii?Q?ujS0qJOV8DwcWuoKnV8qYoPLDcGjJhQ8M0oh56yUe5+epxvOfVxQchq6z7In?=
 =?us-ascii?Q?jwdIqjBhIJuFvHz8Ci6NkXYa67MF4BYNehi7vMVmI82XN/Oju55arYjmGo86?=
 =?us-ascii?Q?eyXmrF8zzQAusZNARJkP5Kdo0gb3XNRoOpPg2s0ws+q004uELoG1XjvjCIWg?=
 =?us-ascii?Q?0Moa5k61TjlGAYodO9lTOPU9VSa+lisFn6NBtlZDgs4vXcqsDZCE4Mfnk0yA?=
 =?us-ascii?Q?IQD1kzrtgE8ije6l7FDjHcqBmdlYQCF+9lAaK6gJTUOQiwJtqh9hHTirCdWe?=
 =?us-ascii?Q?DxKsSWTnNaEXBkYtSOqyf9/Ycqsenzox4uBu0XQ4D4Q9YZO7duX04HZf7gjp?=
 =?us-ascii?Q?jS9HDKKU1gC+FwHooGh3W6ldnSkoEel96wWY9+6dkoEaPOKtMETekip89hL9?=
 =?us-ascii?Q?JVlcbyHCXu7FEVRJzYLNu6TBfPLkzaXhw7t+YjakCXob8VYUwAMH3dQtHscH?=
 =?us-ascii?Q?M+7KKO+fbh1jX9wK47Xlq0MEd1Pe1LaaCKUTH444BM/377OPyCtgknXHBD3q?=
 =?us-ascii?Q?qSJZptQD+sojRnjesBrW1o+97ybatwm/UCHhWH03f3f1IAXXuJNQkfVe6Cfi?=
 =?us-ascii?Q?Oef8OfGT6ySjYvD1DF5xMnwv7avs4dWbfSjZuyBenCy+gSVsklAwRQTLsl9c?=
 =?us-ascii?Q?6eOzwwbERseQ9rkytd5kout03KAZLf90E/G7hfiTNZH0cZRgseAmPcR2kNOl?=
 =?us-ascii?Q?r2K/kIK2vX/Lz2ZFqRL7LlV+HRSq+86L9aANtlTgatYdwcyO6+GWM/WLI/u9?=
 =?us-ascii?Q?zUHNYz3ImEA0PoxnfyexYtin45KPNsftJn01Q3yK4BolKz4GxCM0tnBHR/Jh?=
 =?us-ascii?Q?X7iYsMherBjFeffHDLyMahsdirBF4bDN8jo4uaOuUfO18xJmd7rCKWjGFP7h?=
 =?us-ascii?Q?6q6cokHAcjv7kUbYwFzDvv2mo0yLNvmU25UeNtP2irE/UAjuT2iD/noxEqsX?=
 =?us-ascii?Q?MX8HU76pJhqMbH8p2pltFedAItSfQ86O9soMnie2o6n6trYsNn6CTl2xbPtt?=
 =?us-ascii?Q?uvM7JgUpZ2uWO3zzg/Zz7ANlGu5o0kQ2OvW6Of/f3f9oMQptTmf/Fq6YLlw7?=
 =?us-ascii?Q?tf/kUowLNNNMUkuceyHBecZszdKteoMOwQjqx/Su43vPHCwIxKIXUvy1SH2l?=
 =?us-ascii?Q?Pn7d1ZU/XVl1e5vJB9zeryNMM0IE5LvGnLeR+v/zVDO1LE+yPVyot3LeULZc?=
 =?us-ascii?Q?v+BW3A1n90yPS2/7vNgRsPly52CPOG+Bl/DfpyScWtm6pPC+h2zf8fv6Up97?=
 =?us-ascii?Q?7e8vVb2HFYyMf0sPHagqXIKf6UTpIT4yUX4kpqSp6K78SKj1d+DUergcALbB?=
 =?us-ascii?Q?onXfYOtZIwMlERIUzYnycRzVFxn+IG1MvJk18N6TGUZubeqo9BJJwFc2KKpt?=
 =?us-ascii?Q?qF2gmCDv4yNJx2R5ZKDs4ZWkqojNzKAoi/pyKpq+n5RsNfvTFasEVc3Wr9j/?=
 =?us-ascii?Q?zM0F8ez1gixcfHcyVzleo+o0OFbxM/9e+Tli?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:43:23.4064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3093ed20-b42f-4019-85f2-08dd9979ad63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988

From: Saeed Mahameed <saeedm@nvidia.com>

The bulk of the work is done in mlx5e_queue_mem_alloc, where we allocate
and create the new channel resources, similar to
mlx5e_safe_switch_params, but here we do it for a single channel using
existing params, sort of a clone channel.
To swap the old channel with the new one, we deactivate and close the
old channel then replace it with the new one, since the swap procedure
doesn't fail in mlx5, we do it all in one place (mlx5e_queue_start).

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 485b1515ace5..3cc316ace0a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5478,6 +5478,100 @@ static const struct netdev_stat_ops mlx5e_stat_ops = {
 	.get_base_stats      = mlx5e_get_base_stats,
 };
 
+struct mlx5_qmgmt_data {
+	struct mlx5e_channel *c;
+	struct mlx5e_channel_param cparam;
+};
+
+static int mlx5e_queue_mem_alloc(struct net_device *dev, void *newq,
+				 int queue_index)
+{
+	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_channels *chs = &priv->channels;
+	struct mlx5e_params params = chs->params;
+	struct mlx5_core_dev *mdev;
+	int err;
+
+	mutex_lock(&priv->state_lock);
+	if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	if (queue_index >= chs->num) {
+		err = -ERANGE;
+		goto unlock;
+	}
+
+	if (MLX5E_GET_PFLAG(&chs->params, MLX5E_PFLAG_TX_PORT_TS) ||
+	    chs->params.ptp_rx   ||
+	    chs->params.xdp_prog ||
+	    priv->htb) {
+		netdev_err(priv->netdev,
+			   "Cloning channels with Port/rx PTP, XDP or HTB is not supported\n");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	mdev = mlx5_sd_ch_ix_get_dev(priv->mdev, queue_index);
+	err = mlx5e_build_channel_param(mdev, &params, &new->cparam);
+	if (err)
+		goto unlock;
+
+	err = mlx5e_open_channel(priv, queue_index, &params, NULL, &new->c);
+unlock:
+	mutex_unlock(&priv->state_lock);
+	return err;
+}
+
+static void mlx5e_queue_mem_free(struct net_device *dev, void *mem)
+{
+	struct mlx5_qmgmt_data *data = (struct mlx5_qmgmt_data *)mem;
+
+	/* not supposed to happen since mlx5e_queue_start never fails
+	 * but this is how this should be implemented just in case
+	 */
+	if (data->c)
+		mlx5e_close_channel(data->c);
+}
+
+static int mlx5e_queue_stop(struct net_device *dev, void *oldq, int queue_index)
+{
+	/* mlx5e_queue_start does not fail, we stop the old queue there */
+	return 0;
+}
+
+static int mlx5e_queue_start(struct net_device *dev, void *newq,
+			     int queue_index)
+{
+	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_channel *old;
+
+	mutex_lock(&priv->state_lock);
+
+	/* stop and close the old */
+	old = priv->channels.c[queue_index];
+	mlx5e_deactivate_priv_channels(priv);
+	/* close old before activating new, to avoid napi conflict */
+	mlx5e_close_channel(old);
+
+	/* start the new */
+	priv->channels.c[queue_index] = new->c;
+	mlx5e_activate_priv_channels(priv);
+	mutex_unlock(&priv->state_lock);
+	return 0;
+}
+
+static const struct netdev_queue_mgmt_ops mlx5e_queue_mgmt_ops = {
+	.ndo_queue_mem_size	=	sizeof(struct mlx5_qmgmt_data),
+	.ndo_queue_mem_alloc	=	mlx5e_queue_mem_alloc,
+	.ndo_queue_mem_free	=	mlx5e_queue_mem_free,
+	.ndo_queue_start	=	mlx5e_queue_start,
+	.ndo_queue_stop		=	mlx5e_queue_stop,
+};
+
 static void mlx5e_build_nic_netdev(struct net_device *netdev)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -5488,6 +5582,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	SET_NETDEV_DEV(netdev, mdev->device);
 
 	netdev->netdev_ops = &mlx5e_netdev_ops;
+	netdev->queue_mgmt_ops = &mlx5e_queue_mgmt_ops;
 	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
 	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
 	netdev->request_ops_lock = true;
-- 
2.31.1


