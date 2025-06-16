Return-Path: <bpf+bounces-60726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F91CADB386
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDCF3B3A18
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE57C283FDF;
	Mon, 16 Jun 2025 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t7a4NDpO"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B568213E94;
	Mon, 16 Jun 2025 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083383; cv=fail; b=A5ai7FbbnEWLNqQ6J/k64JJfKVEFHWicAVsrDHX9AD5CKVHnyhrIW1kB6epg7NHS2u/ehTbwQiRN93hEWpx+XU3jDD54uiqMr8MK5LiUK6bv4Pmnh28HajEe+5+tZlRHPuekuA49bOKhkphxlU+ndrdzveLBGH6rSbrdQUy3j0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083383; c=relaxed/simple;
	bh=YgCCWY00VqyWrTpVMiSHLdSHpDeJIpOfMQP/pODJq88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQu4rjPvdKhXAXdjYWQvd9eHfpvxaWy16p+P6CW3026VKm36nOKBXw32J3uzPeM4MnGQ4wCWxupEGrT9xHtbhA3l27EiBA4gRJEbiFez2d/YMb3TcR8FiNz3TulPUTD6RMMKuJL9RrS8ZUGLkRDPaUJrP0EBPGM9xRsZ4Z/OmkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t7a4NDpO; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rABEmi3NaGQyhl0OBfxvclha+U346VDZ1uIdhE0k3+o5HTgyreXCEcElyNFa/2pMsbSbfjq5ff56pG1TJoir1SeQboYE19bQoCNKdu231FjG+GilSbZWZKOHZ89dSBPqclwe4s3OM2nfL7Ix4BnmWrW5Xhg+ClMUlBUu912y9oYuW3tFkErfLxQ1nNE/sX0z/M7c8gjBVG5VojgjicNNRpwHWbXjaFIHmj4izYBpjSUkPemSOh1k5GSbE7fNq5puqyHbgdyL27/FadQWmfovP6c2kA6nmu8Qrm4p4QS+fOnYIxUFRHqofupiA2qCnlbyFh2/2wpRC88AzowFQg4IHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hel9YA8zFa6ZDAzl8qG5FGxhYA0RZj3QJKQqZf7djKA=;
 b=azF45mGWLNd28hhl0es6G0ANOmGeoqosF8dxJMSK/mXm+aclcGBGK34Tx6aLjuvwfvm91yMOGfxcNYqKHIZJraooHBRWjtJzprxR/i/K/dC/n01bI+hkckJLrOI/0vKFiw0loi7IXHvn1yxLdwEetoB0JKdZUtJ4G1FpS7gkFhAPEKINHJu69Dms4grrVZEI6Coh7EyMhRozmdTmE+C3VU0kB85wQZgrjZuyWyP6X4A84gmzYQW4+Ocz6jlPXhXOlX4l7Vgva+BK1pawRyAjuu0TVO14LuhAlkT53+pRjmo4l805Xr4japmVzUVB6pPusdx7pWWQFyjhYqI7kEHS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hel9YA8zFa6ZDAzl8qG5FGxhYA0RZj3QJKQqZf7djKA=;
 b=t7a4NDpOy5+KkIVYXOybsPELihR+2xTbJIGwCygd38BZH/0Hqc7TZFDCq06xxVmUHNkUfKADEjz9bzruVqfM1nx1rKLV+B37hWvr5+vrWcUXHejSX5uYlL0STGebzjaHcOo+JxO92AjozHPpcZCMQ4sdqpBE9cqSO8+qnjV9iKmNgipVSWdUb4c6rLywxKgCB5+nWP3yLifKQkK14Foq5dHYDEnX+4TyOUNQQapc+WlGMV+mYdhp4J4ZqCZQ6X4C06gJuWxxkO5k81vdqX2k6fGeB5k42F2obown36cPofdXIoeBZ3/UPrSguIzwKxp1cuq2t8pUcwj3ebv3Zdo+PQ==
Received: from CH2PR11CA0024.namprd11.prod.outlook.com (2603:10b6:610:54::34)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 16 Jun
 2025 14:16:18 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::83) by CH2PR11CA0024.outlook.office365.com
 (2603:10b6:610:54::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Mon,
 16 Jun 2025 14:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:16:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:16:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:16:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:16:00 -0700
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
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v6 10/12] net/mlx5e: Implement queue mgmt ops and single channel swap
Date: Mon, 16 Jun 2025 17:14:39 +0300
Message-ID: <20250616141441.1243044-11-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 1675f524-4152-4fb1-059e-08ddace05cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gWwmwL60h7FJRe1oZVxfNsCwpKzctHK/5fX/is9NfSzilVQM2Oy5qFIZ4Mfa?=
 =?us-ascii?Q?HsZ7gy+4MOjMs81sKBwajE8cErNLKCRg2nJ+wI+C5JdPaiMCGXVhQ2weKsgV?=
 =?us-ascii?Q?VjOvMI572UUZhVQWItDcvd3n9y5xmzSlod/IwNUnGms1o4801i9Y62nJ88xQ?=
 =?us-ascii?Q?0K5IltK7R12kh30STahT8R0UrhPFJRekTPb+9WXtCBdfOUcVWTI/nZZHwYlr?=
 =?us-ascii?Q?Z7P3JuQXk3UgqrQ0x4wztoZuaQktuxHwKkIIZYe3Ysmdxi6QZROVGESDOaB5?=
 =?us-ascii?Q?nEHESsG/TyBaV/9Lxqsq2VIvlaX9v+KnIbFTGqagNKluXC1QCq2glDcnVFJW?=
 =?us-ascii?Q?/UwCKKhzMZVOnwRV1w55qMdGzNdNwiqUGqejuK1kbA4KJkIiLsUxjx5T824V?=
 =?us-ascii?Q?AirnctAqVcyr7kkhV9AtgpovIooK8GhJU4WymuuQrm6dieCDyP1XoSwPuiS6?=
 =?us-ascii?Q?IBmLQIWc2ob4PVt0tqNnUsWA39Wh/ZEgVqaxxFxe8WNHNfQNnkeb9wp3neTL?=
 =?us-ascii?Q?e8NIScwd8YLr8ENPrhR5Gj9NhuqXkvzkKuY7nH/UNZ2kcYT64b+ToSrnkhV/?=
 =?us-ascii?Q?vIlJNvbvrcIJ5Wyn9DsACpfdF5nUJYWHpsP2FQdZemyqehvNr8bIwnYuaJe4?=
 =?us-ascii?Q?7xWfeqakPxaqdMPD7dFdmYbmcTbJlqbMIs00T7RhhMeI1WA09xxY/zFmuGDB?=
 =?us-ascii?Q?ozHYu56DjplxMvKOFajX5ev/zeO0ZxU7zdzzkpt58kLuLLckRkh00jYG68mn?=
 =?us-ascii?Q?9tBxA7C/c1GAiL90JDh0+GStntpxsDJfBi/RXmClj1HwSV/g2LfcdY+3GY3Q?=
 =?us-ascii?Q?7FFkE1ZoKoPUePmcTmZsIUgwakS3LQ3me6zvk8pMLWKg6rDP7SjC2cAlVP8Z?=
 =?us-ascii?Q?R+XlfGtinzjNPbwt2nfmPbqD3f5mp6f4aUgou10f3lfdijRgQna5ajoIMMQb?=
 =?us-ascii?Q?lPMTyRWlUAHttjXWH3p38G3MxuDH3r2wvOeDfrcL5a6WXy4jpTvIWZO6FDEc?=
 =?us-ascii?Q?CETk8Om7zL1UqODPzq5zQSzFwsVhdp0XKWeOCwiBBC2fD8xpVc+31rK/SP34?=
 =?us-ascii?Q?tNYjMQ6YmSN8DnTT1yP4T6GNWObow8s/rRJlzF4Q4x5QEe8jq8o8Uc1dfxeR?=
 =?us-ascii?Q?gjaSqW2vAcdpQKqIlyGb3+LqWegPHjqpACLrLEAB+R85y9+C2f1Z3bVSVtVB?=
 =?us-ascii?Q?6EKlUNWFcc4ZB5mCkTzRw7GigFVRrz4kfxUFULA34JwOAlxUQOMPbpExMAnY?=
 =?us-ascii?Q?Ghe6WMGgPLkz43A7xQxgigyGolefZLmObEnf0VKaRv7k/FeQo3JSCswFLTyJ?=
 =?us-ascii?Q?pAMbcvuzGhxOnc7oMjbQ8u0Sw6RtcLDcAI63whksxmQjlKI2xDHbbiiVXeq8?=
 =?us-ascii?Q?Z9fudGkwAH/M5J2nB6edoLfwEHp8hyPGUoXAnSZBVFcHBI/9/fYW2i4llbMQ?=
 =?us-ascii?Q?qX5amuI5lqUwZsgYNreHQAKWONj8dHV5jp5oxCcoBjdKwkHPsRNzFKB2FV7K?=
 =?us-ascii?Q?fa+OdkPNWNffDGOn8lrlqslwTakvxpO6xjPe?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:16:18.3612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1675f524-4152-4fb1-059e-08ddace05cbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618

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
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a51e204bd364..873a42b4a82d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5494,6 +5494,103 @@ static const struct netdev_stat_ops mlx5e_stat_ops = {
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
+	/* In mlx5 a txq cannot be simply stopped in isolation, only restarted.
+	 * mlx5e_queue_start does not fail, we stop the old queue there.
+	 * TODO: Improve this.
+	 */
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
@@ -5504,6 +5601,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	SET_NETDEV_DEV(netdev, mdev->device);
 
 	netdev->netdev_ops = &mlx5e_netdev_ops;
+	netdev->queue_mgmt_ops = &mlx5e_queue_mgmt_ops;
 	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
 	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
 	netdev->request_ops_lock = true;
-- 
2.34.1


