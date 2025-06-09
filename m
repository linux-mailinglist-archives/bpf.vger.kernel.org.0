Return-Path: <bpf+bounces-60063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF4AD21D7
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13B517134B
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE925221DA3;
	Mon,  9 Jun 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kqZgsX4r"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE75D221FD4;
	Mon,  9 Jun 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481214; cv=fail; b=AOpLvDSgpMPTDFTIxbiU5PHyZ/y8QAJ00w5w4GoZoiWnZotwr/A1YjJAuStBssHpZxmvDf32506CbhZZraOWsVSY6DVv16yBK4ovvxxj3Mh+emohbhFkEdXr44UtnUIU86FswNZP/Ocy+l/OgeiVo5U/4oLh7ffJSdMbMJGFPAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481214; c=relaxed/simple;
	bh=dBWmL27iqY7NT25IKggnsBH3DTGF04107Yk+pi8pLRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8/RFqnbgSuB3RDWnSf4ilM77i9Ppanwd66sH0KyL2giRw5vpI5Yy6p9zAQPCmLhNVlRet3SpApQdtcidmI/zRntMT6gSg60/kmh3cqUTACQzMND/qnaQ8STk3GGy/75Dki+pV3LZWFZ72fx9y1sRzqx7pgtPSkOPcpdB9MaacU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kqZgsX4r; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtlIsh6a/KaxDzDF19dpkRESYS6l5POZFhhA9RZZwPJkPgL9PDtSPJOqp1xAm6dMFaeeLP7wij2AqAx01rnjE6io3XfMG7EOokLnbmEoOsaqVxCaJtgh/Oiz/YpFdpdzhstI6icMxL/ncbyO1zAJQlu6qBJuzFCwKTX8Wz4jXQ25Jj1DIWV4VgxW2J9B7M+uShB4HCxyLqZ+gSC5N1F06EsAtH8D+TcI8XWAMvbakibag2MFomIOpHCCM7n7c/e4Mxu5iUT4uGES3sRxgMy4VyZnQ1BdYuEdd0uR1iVF+j+92pSbGib1cRVpw6eeFouwxtYIR0SzZTP9QoVdTfr3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixwoh1AqfN0SSe/5EGnEDm3XZKwJMJ9DwWKOEsrpBL0=;
 b=mTevlI2y027CedGWK+GUPOlsZFjqc5jO/LeONS0cYXqS79ftRxvF3aymLi8HSHKnpmdMUdBmHM7DRd+pDkL9My3amTeGJA2y/VjrxjlnLqighDFbGNGKxQeuQk9h34OZDrBipZRHGKWeTdnN3X8OPk16XB4fPY4gVyjKOqo9cDLKwqKO49hg34+Crf4HcTNMyXGq101MrU6u/O5WWEIMWi9cIesBCUE61NZqzbP0NyrE9x2gI2JbTQEdzHVKdGDLHXXTqBSMGfdSc0F25EzsDMYoOqpXpoSVdKNem/1eYbbDVIKY3ZfF7e75qc/jqNhvBdr1/Ntv9hZT5djXQcPwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixwoh1AqfN0SSe/5EGnEDm3XZKwJMJ9DwWKOEsrpBL0=;
 b=kqZgsX4rmL9DQWBfVkvEX7F0SQTpU83F4/7WhynWBTWJ7aAxHnmAjmOQGTQADzwZ1elznjvrXiP87ZHWnMSOLA55oYAddZWwECo9LgqyIN6YsaLByYX1v4XFfEQnczVEseUOUtp24fYaTErOSVeRkgJLIVNfeLABYHZEEF+5GdJv5K4PVmggxf+lHFytENTOdI4PV6Z/6Fly1AIR2ralKCz6ZsuT1RReQrCZYvZfX5JwWoFtozgSbSTF28p3+ZNcvMr+6guVOHxGgTDwsKL7H4uBnwkOUiM9qE3bvPguthgpaPn7zEhpYBpuCN9aOPbv1yqGkuuD4NujppQqLf4rvg==
Received: from DM6PR11CA0029.namprd11.prod.outlook.com (2603:10b6:5:190::42)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 15:00:09 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::73) by DM6PR11CA0029.outlook.office365.com
 (2603:10b6:5:190::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Mon,
 9 Jun 2025 15:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 15:00:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:59:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:59:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 07:59:49 -0700
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
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 10/12] net/mlx5e: Implement queue mgmt ops and single channel swap
Date: Mon, 9 Jun 2025 17:58:31 +0300
Message-ID: <20250609145833.990793-11-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: f14e7b28-9cb4-4fbd-ca10-08dda76653b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8WrG9dQerWdcZuW3+2jyBuj7QfZB8BmNzaevDpTrumlzNbUcntj+QGQbAywc?=
 =?us-ascii?Q?rYhCD52JVogA+154ddatIEbGNjzrLxAOzByzApbKFYwKHg8Ej4byF5jb9CYq?=
 =?us-ascii?Q?slQZAL91jUf+CRuTdm7k0qY+q20MuVBfFIA5OVPSwEz/WPaopL0PwySkqUcL?=
 =?us-ascii?Q?pcnjX1bPxi/5/77sqTW2TzA0PDYh6kepG9NdlWLuaN4oUUcZnHucwQaQCGwa?=
 =?us-ascii?Q?e0pq1y1VrssNRJ/vdGmA+GuOe9xM+8EwJpPn7Ts4jyabQA/AhujDxPJAUSZL?=
 =?us-ascii?Q?naVAOXpBP4Y71cjYrrm1glD8Q0aJ6S4LmDY1vqLBwUTzskqegmt96rZ/ipaU?=
 =?us-ascii?Q?9swZX/Hp5VwKQL43QDbu3KcCMQVrq+CyVRIBCsjj37kCh5P7xxTbj0ur3uZH?=
 =?us-ascii?Q?B8T6K+1UBRacVDkTvTC2pfPtFbtNJZHhMBjS25Q2ea/Gqqdpx7rVuYtU9uZh?=
 =?us-ascii?Q?LJ+CMx9C7ejyQQmmxI4gDMRXSZvwE1gz/X6a03zebzjy1q/WCX2jiQHSt+fA?=
 =?us-ascii?Q?ORAJdx1iV9yQBpqEbkK0P91j+TXI2/kuO25k9wuM0WgcuHwTdxr3vFI/R1rN?=
 =?us-ascii?Q?ZoWBNLUZEGhsbrEocFuv8S0roQmrw+lZMAJZdSC+6/bnXdIMDadYAULqgBkR?=
 =?us-ascii?Q?GrZxllLPo9h7n06mPrlrAsu3UGxwTku43ssdzOv6oOjaqARRA9R3USBy6p9N?=
 =?us-ascii?Q?YtFRuEEDzgctKR0iWLnUG7jaTLvpTWbY5rGHJO/+w66cPeMlL62U08cdBeSw?=
 =?us-ascii?Q?wroY4TQgEmGaV5vNT6S0DY6ngNECykevkEz1fIFnjWbxlGetB+uI7ZJo12J8?=
 =?us-ascii?Q?Yli/iluzoEb6TgZPsI1pOcgEpsZvRh1asHpZHdddNnZ78/Vlsj06B/XZs9TP?=
 =?us-ascii?Q?KRCu5RPQeqMaErI179YJqcvWMPczxPPVt341cE+bh3ySgcfbTjlqyX4xTCMl?=
 =?us-ascii?Q?oieNjeeKeUDvas6ByD5iBXaZ0YdKP/Gwr3Sk/zfen4mLVPVtCy/LLlGjS7+e?=
 =?us-ascii?Q?o/YM1pbTAL4+Jd2+FyU0NgSIlnKhwAP7k+33BshdzmySJJ7bIdRMzrNAvd/s?=
 =?us-ascii?Q?PGAWzCXj3xADYjRUz6QeUzORdFytti9kCI+RHWsH8PvpwaKpTOvJ/rvYl2RQ?=
 =?us-ascii?Q?8GyygPoTxGpGOYnrr6GoIZvMtKfTtkbUGQkMaHtbcemeWMNC2aDHK8GAzA5R?=
 =?us-ascii?Q?koEOK9uZE6wxerG/iw2l7mwvZ/9+mKHQBxBoYhG8fwa/fdj9kiOdo4llQgk0?=
 =?us-ascii?Q?RDbKsQAyAlBhKwSKyOUNLVMvaeXhG+8IuJQbN+bh86NkuN6+LOa8RVe8ahE+?=
 =?us-ascii?Q?KAf+jk31XkUT95wfWk9O70jOiP7rlqkRcbcK9F/pZ55eUwaN+DQRzJ3lUg1R?=
 =?us-ascii?Q?TWArMp5/rXjX1mJC46isqixlMBa3Z2kolwp8Me/ENOuNGfROeYzTNEarhnrJ?=
 =?us-ascii?Q?RYssVD+VVVN7SDDrOkymDB1mV+33eBhK2GpMPRHdhifSCDegjor2djVO2IF4?=
 =?us-ascii?Q?kwYkWzmORFZIbDFE/FAnq4VLiPHcrISuQGjy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:00:08.8074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f14e7b28-9cb4-4fbd-ca10-08dda76653b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682

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
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a51e204bd364..90687392545c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5494,6 +5494,102 @@ static const struct netdev_stat_ops mlx5e_stat_ops = {
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
+	if (err) {
+		return err;
+		goto unlock;
+	}
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
@@ -5504,6 +5600,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	SET_NETDEV_DEV(netdev, mdev->device);
 
 	netdev->netdev_ops = &mlx5e_netdev_ops;
+	netdev->queue_mgmt_ops = &mlx5e_queue_mgmt_ops;
 	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
 	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
 	netdev->request_ops_lock = true;
-- 
2.34.1


