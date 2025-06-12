Return-Path: <bpf+bounces-60482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B8AAD7721
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284A7179C68
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2D12D3206;
	Thu, 12 Jun 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wb9GF0LV"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972A22D1F7C;
	Thu, 12 Jun 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743315; cv=fail; b=ELVBm1x5Hbnk7RK2VexEbdiEhwUKL4a9kK33Zv1urqp2TsMfrbtnXoKrsvftGw5e4IRnhbd/APYA7EbhBQalNh4+oGoWy0y65IDYHwUE+5VJiy/CzLXV774kwO3UDNrrv1T8Naa0YUHriimhBZ2BaEvZ5le3jJAI4gsCKVFKWB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743315; c=relaxed/simple;
	bh=fNDNijacQ6HXnsRmJVmczVXKMRsVzC5YyMTw3RBQ2KU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Puj+VtqyIV4Tk2ldBrapg5txR4DN0wAL9uyKGF8Gyw4OQDcgYtilpam1s8J8MWsRcLF2aORh/fwJIHs0rZYFgv3y+I7vnsaobGF4iW96BHs8HH+UtE9orU+QkJWnbHKx6JabpWhZRd3uTVtO0Kh5tYQrwohtOgq/9XrK1NBfUnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wb9GF0LV; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffvLHcHE++bJq6h1oWZuNLAEc1CqtxJWuC6NOKlbcNipp3Wy1ndiF1PN6fkzn/I8Mz/4twtp1DF7JhhmUITh1fxKJBXOEcxkqFqzHU3ds4C1gubeH22iUrnWmdlB/kOdsVrw/wXDCzsDtZkKOOA0WRm1/YusS3FC/9sazoNJ20BQ4f50aVi8RK0i58XKAQZdPdHfyzZWBxqwuqGrE2v9xVBdGaYUukr7yO2i9CSJ6SLgvpY70R20SWjaWjZXJ/nFnSkQEbZhiEq9BzLWvyLB49frCasLqAZjP5f/RGW2L9SPmk07gv/+wwkrotlSh5egf5CbVRSbFgqI+JPj6cr/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4qaGDM9Nndt87AehHjDKTRzHc2WBx8aTjZcpC7LM6w=;
 b=NLIpwVaB4n9RZH3haCrWIOoRQ86F1+ZG3liVCiWtcfU5BaWF2slvJv1+n5sfoUJtLiacKo6Qh2sEpd4oQWNpeRxhFg8K1wCTVv1lCAX8srYg0tWx3QwUvLcwiDR5JGKjm11+ftJFqNj3KlT4VRfQhY8l4pULvlp0Jatc13RvbLAHX0gyuatFlfd6s4bdOwEvHdCfeeU3v79Xv9MPq7OYdPW+GcYhdHQFcdBltpe9WMDUcZurU/JZmQG1gMW3M6fl1qP/+S4oPLxduhwOXC/AISrgTjUY2J0+Hl39fB7W3OCePb0UydFARO8mssoK13wBuu6YUkFugWFzv7+IJBFFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4qaGDM9Nndt87AehHjDKTRzHc2WBx8aTjZcpC7LM6w=;
 b=Wb9GF0LVgfONlAs4DJFj8bvoOLOXKnzamNfAXFX5FNe/wcIT7VBkjCNKI53Ki/jPWnyewXy5ousVp7WCs4dBWtKsjeEZwn/fG1Ia8mkJfoss3SDShCbc90ypsAhoskWWaU+gpSi4WBM6aGGtMjd1mWanCfLagZUQaOVboEoEvN89JSbO7EQHksm7biEMuUgXlqaKPEjabgvAOl0UtdM7rHh6UMIGkCgHpvYCs6sUm+0x+o4aFLKSC1WGVVF9HCtyGNFNmT5XQIgYt9Q7x45Sq5fg8sMtwsAUROrpseYe9X+YkbXpODLUdeXXfOOWuQW3ukybOtjEzKve7/gtyJGuHQ==
Received: from CH0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:b0::7)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 15:48:25 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::30) by CH0PR03CA0002.outlook.office365.com
 (2603:10b6:610:b0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Thu,
 12 Jun 2025 15:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:48:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 08:48:11 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 08:48:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 12
 Jun 2025 08:48:04 -0700
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
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v5 10/12] net/mlx5e: Implement queue mgmt ops and single channel swap
Date: Thu, 12 Jun 2025 18:46:46 +0300
Message-ID: <20250612154648.1161201-11-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 441ada30-a63c-42f2-7a2b-08dda9c89156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kKOwkE5Z0VKUqGvTS6uB3ViOlbH+EM7NPToZ0YvTef2nM/4a478EBFH7BJ47?=
 =?us-ascii?Q?gJHFv+tA4btyl1PqYM5gTryY5GiNPQU2kaDtBFQXKvZjhaIFT6aiM9tNZrzs?=
 =?us-ascii?Q?vwyQMCNLETaNKgFzN1NickoAMJtXO/V3Ez0rksxl9V2MKhRGOCgxL2SZ76Kn?=
 =?us-ascii?Q?aDp3wsMepYPiC/o1EKebfchPGkRX3xkhAvCxPWKEAz9QEQADqFzTqZL/9IxT?=
 =?us-ascii?Q?YQQ3HhLRUwydXarg9IhbKB+iwhJFnQdFYkLY8jvZWC81W2h1pAz/ZS1ztM4v?=
 =?us-ascii?Q?yFStdRPwPUK6frIkyaIG2VYFzXcWveUWxYy1bHPSDAzscFs4oRLOFT97Zulf?=
 =?us-ascii?Q?GOGWhJh87JvUPfE2+mGfY7Gltg8kD0UCAt3mzlQ/x7oGyG6x01c/1MSsldYM?=
 =?us-ascii?Q?EcxCFMwvD7CB2qdBJMWjM82Pbs/AixpQ2Ap5SD8j8wBZZsNqx2ra2JnKQmMQ?=
 =?us-ascii?Q?E4Qim1nXxeiVrl2zJqE4019pvcSr86ng3ZiOt9DFUgwB4k1JJB9nki08Fb+Z?=
 =?us-ascii?Q?2Dtlns/9R0qv+Jz22tBXjwt1N3GuBF9JmrtGE/c0XaSLUOHwELItJLYkOxtU?=
 =?us-ascii?Q?/7WRGB6jNP+pIthnEYAnZhP2F3gpm6biQL0zoAcU6cGRSbDMDq2uao30Pm2u?=
 =?us-ascii?Q?Bw6de37uJ3wQ8v1uPKSaH3xP35FezY9cacNyy+3mfPeJ70J1RcqChWmscBvv?=
 =?us-ascii?Q?rQTI24msO3Iy0xCxmKB6spsOvacsGds4alRp3plODianmrvKXgBkxJzreHRi?=
 =?us-ascii?Q?a66opJcLz9JLfiNxU4N/Tg/dCF0GVA5OEAoS1O88vri/XMUYWzSmKuXDNcaS?=
 =?us-ascii?Q?HGzU8NB31+bzvlAn6gJPXdsMS/It72ucs0+AEKO+LEmxjMpUan+8Lb+T2iGY?=
 =?us-ascii?Q?5patS7USnFK5ayVzPv+UOaToMKVgS1ItUNSTaC3nBcVHP05mZAc0F/kIYKsw?=
 =?us-ascii?Q?1fazO3lW6Lq4B1TgbYK0H0Ec5qewfX1DOxa7zMfdE877h2qTkL+PzTJZYJWy?=
 =?us-ascii?Q?Gf47346N6BQ/nfBqzF9KTn7Dbz9bw2OSrX4wUntXGiufF06L56sw9C9/IAGq?=
 =?us-ascii?Q?aqGfKeYRFWTgwMUvdYViUK+OAHXpvewOeLeOQR6qW2RBOnapR71DvClJGCg+?=
 =?us-ascii?Q?PAL5gZ0ncFD5DK0L8dn5ogRhO3ACLHVWOwkviR/bgbXpBfixDKsmwhpuC63v?=
 =?us-ascii?Q?qp2GetG8k636RelK6Y4igTaqU7svEKlF52Fk+j6KA/4SIlywet1XXZ3TG0JO?=
 =?us-ascii?Q?Xk3hJ+yEfk83GyakDsq3NwDHFCreNrzsWBKxLO1JyOVFnbeGrAwlhWVi9wRh?=
 =?us-ascii?Q?IMPFmhpY+wWVHC56yH1XHHLdhY6WTvfX/wP3SGsbuiX53GGRMagRbbUAMW+F?=
 =?us-ascii?Q?8npruXho9xC7a7hyk1gpQiiSlupi3hOlt8xgyOLW4mr+M+g5lbItWSkJMvzI?=
 =?us-ascii?Q?IC7VO4OR/YzGbHsHrCjEA/0K4P0SlglDZBvp7NgIAa41PzjbQkbzAp+EYcJP?=
 =?us-ascii?Q?9p/x432irxRzW0J74xx/rTZW0SrEcpFmrb9o?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:48:25.1744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 441ada30-a63c-42f2-7a2b-08dda9c89156
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333

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
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a51e204bd364..06a057ecaecc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5494,6 +5494,100 @@ static const struct netdev_stat_ops mlx5e_stat_ops = {
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
@@ -5504,6 +5598,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	SET_NETDEV_DEV(netdev, mdev->device);
 
 	netdev->netdev_ops = &mlx5e_netdev_ops;
+	netdev->queue_mgmt_ops = &mlx5e_queue_mgmt_ops;
 	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
 	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
 	netdev->request_ops_lock = true;
-- 
2.34.1


