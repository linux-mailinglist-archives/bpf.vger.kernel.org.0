Return-Path: <bpf+bounces-68002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 619A5B513ED
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7106E17E573
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 10:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A75431A55A;
	Wed, 10 Sep 2025 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q+6zOHsI"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F88E31A072;
	Wed, 10 Sep 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499969; cv=fail; b=l1vWHTbRQoaCIo/zYqJgX/kGURi8ZymqaH+2CxbWbnACuJh3cfSLK6YtVH4nn+2O5AB9ZSHXO4bCmjTZ7/ciFB5ZbaYiSuxcSmTgIvJgYQhlauhwtbgKnIIid8ZA34tR0A1eqzzViwWPvD1KdtHwtJD1d88/e45V6gx/5qUGdYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499969; c=relaxed/simple;
	bh=cAaqKBoxnbEhz+yra4VDImmUtw46PoymDKTYMEersnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmyEMKG8oe2DI2uAOJ7GfpjHoo31DRmNbTPOGucWtJb9U/aUhAOFPgUL02DGvZehnMbeELYkG/Kl4w7VNFuQYS37wbmB9AZEHjDmsSvwNrwFFIUvp1WOwfIEKdgSC1bY9vckY+5r4fReMR3u8Os2FsbAJq/5GodQeC9nPwqzqmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q+6zOHsI; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0YddecHfVZ9fBdEqJV7+vC2juQzBRvyQUFEkuFbE92IEPHWVTdJ0HbUo4lOPgQ4RQQ+DFOtmG81GNZ8fTSHsvFrx9O5rJQ5fldkJMQY0xRTfriBn2os2xO8vZ+O0NIFixjiwNquIx75IcBWQwNXXaPDMCAk0WzyKY4Szv57x1pE7z2G2L/ZPfkWsopoH/w4ZaU9GYKyN5dROZb4+9OLra5QPG2DxfjO4EekDrdYFVa/KEkp+HfiYBNzLgvPwp8RdzCISy3jbOsYZbuDQEtbRe+GsS0Tfw9AP52WlPAzQ05AeL76LyVMttuvgsjqVpSI5Pvk25hEb2/Hjqu4QANB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxhb0YwSQptaFEa/268dyDggWbw63UzW76xYEwJR+nM=;
 b=qqe0L+c+4Jn5iRvuxH8GAAXPS7FS6QrsGt5H9CMRlDq+xvquB0egsic5gE03fLskdvskzh9dit0/AH796O5HY6Zcl79deIRwbSDQ9w9ZkKXucFxGuRS7hAkGbzqfcfvIaOTCeNDcHAc0qDknh0BwxYxruUoxyZeEmPZHluHJJVkJU5otP3kF62wxUGtYRarZXL8fxtLt7EBj5BsVFpOC2a2ZLuzb8EBYkTMdItzc5yuYDMSrK6LNk0y5Y1GSHedLLdUu3ddPKugBhQQSuLqW+HFlTUCBMzhBGK1E2jie06fE6PGa+SXkGRaz9GCgzzoROs7SZIFBn9IplY7A0aLuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxhb0YwSQptaFEa/268dyDggWbw63UzW76xYEwJR+nM=;
 b=q+6zOHsIydnLzrIfbp6IvRzVQx+la5P35+tFqotQzQjdsQS9+2+2zbRnrzbpnWcOV55m3p8kfBKdTvwlNs9cvBmMgXf7IEszzIuKXcJa+tVs3JcA68yMuRZwfvl+hPuF04bvrmVhKckrbRFXgEp1VJORCu8x+q6DX+ObM3ho/QJ0UOMglPXNxzJE6wvInORqXlE2v6d1pFQZ7Z9fTh8Sqla5vVah8+t5Dihto1WpJqQcEdVG1G8W+D/+2GybxD/L7GuQdYjJ55gTANwL5lC73V52LcCwx6MZcnM2/LmirrBz0YkKylsjBL61mHqItIi/pbxDjUbSW9wy5o2TRc1kVQ==
Received: from MW4PR04CA0319.namprd04.prod.outlook.com (2603:10b6:303:82::24)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:26:02 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::ad) by MW4PR04CA0319.outlook.office365.com
 (2603:10b6:303:82::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Wed,
 10 Sep 2025 10:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 10:26:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:38 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 03:25:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, "Leon
 Romanovsky" <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 05/10] net/mlx5e: Prepare for using multiple TX doorbells
Date: Wed, 10 Sep 2025 13:24:46 +0300
Message-ID: <1757499891-596641-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
References: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf4e50e-17d6-4159-59bb-08ddf054711c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6WnsRexnj6L3J88B/cvAJHxdddUDOqGozg+ny404zLlcZ90VShQQz5nFPU/5?=
 =?us-ascii?Q?B2KtQd0gROZejclf87MmCSGuX/N5Q4tLkO+7lbTDdG2f9SWHUsB7NDUiinXL?=
 =?us-ascii?Q?0WG0SI1Dtca6smbCaOIRFAJEDQFV7dKC6bBweOW9NKBxRUF899pvEtrUUL9E?=
 =?us-ascii?Q?ey0Pl21FnqONazgPiNTuCbsIq9AB0Yr4CmkiDVPYdlV/uUsRWtIW6FMnmkFi?=
 =?us-ascii?Q?DbReMOFc7humHmrTQC1a3lxMmHTqOJ4r3xg7OF2/cY9v/isURpdi4HDKbZ7p?=
 =?us-ascii?Q?ehVyVZUbmZzI6l8sh7RHciYiaLv4oOyvDckiKKDYQAo/lKgrFnDTB1Lp1z60?=
 =?us-ascii?Q?zqVmJ3+p/Zyy0oW5gtEWSFy3+YFiUBvMvsCX6bvbVBHi6r8W/TxXZcSz2wt6?=
 =?us-ascii?Q?/OLgoBbcDl2xPhfiH3shbpkHJZF4sbEGMMs+9ffFL7mcCh+XIW3OKSZAz/+5?=
 =?us-ascii?Q?TP3QJzxqwKJxYu2zpnq/d2oNkcNZH9Q+7WY1wcI1sCOvHRwQMexil8YaMjWQ?=
 =?us-ascii?Q?jCXI6honln18b+3rk8tMYkENw5XkWOPtVID/Y9KdLVmHGnrBZSw1viWK2Bf7?=
 =?us-ascii?Q?3nKw4wWzZriK1+3rQuq7pQFz3qgTZkpdOs2Q1yi5HIXTzZikpph8Cq0G/AW7?=
 =?us-ascii?Q?54LrACGb0jWzKf9dA8ZERBLi3Zx+svLrSBmgvp6z3Mdv79V0jKhx6OcLCbyp?=
 =?us-ascii?Q?4KtHZWRtSjx0Q//8SoIxNa6EDjjB2OzO4SEu1/DY56IL4bAB5FMQYlaXsjR5?=
 =?us-ascii?Q?02l64pgPZtmb1zdscw3Ymo53VqxgX80D/hG3mHHQqOwthBLr8MazNVFC/ibr?=
 =?us-ascii?Q?h8T78ClKGqbLcKVuDR3fr6FWs6hr8ztgORL9N8i9siqjv95G2Q9lnwmmxvto?=
 =?us-ascii?Q?Ez1NZsmuIksnv5ZqXFOogbC7cT7wRvhetYyQGttv5F7AcsMs0ezG8/5kmm/F?=
 =?us-ascii?Q?KuWlCHF1MHYLt/hOxcOT3ANRCvz/wU/+qrAgDREdvalflKESKsIlZ0iwNMSL?=
 =?us-ascii?Q?DVtLo6Oxw5Hg0WrQQ8ml6MncXXRcqUOAoOr9yNj7esAjNUHFyKZwRLrYFg40?=
 =?us-ascii?Q?zV6jalWkcLxcTNN3Ptc4CTyjKZulJYPoggOvFJu0TfC9LolP+xXKa98UFJZs?=
 =?us-ascii?Q?jCYnT7JWB0BiA3SRn4dTKLxqfk3fIZ5E/ThSeMG57VBQ/sM6/mVToqRIU0FJ?=
 =?us-ascii?Q?Cg6+SDlZiYvWy15c00TDi8Xee6mTf29Ef/ed8Xf8IlY7uiPoXrPwjtM342g4?=
 =?us-ascii?Q?z9ECjgLvjF57pepoAM8IP/BhGsDXbvg2b5FNjpqZs1aZmg/AnuSuj5cyfD7c?=
 =?us-ascii?Q?uQOzL/4sEEjzHiFv5r1w8rXI4xLggMOlOEtyed3NIhBDl6UIdY/pQDRJUSR4?=
 =?us-ascii?Q?laZR9+QWkFHwsQgv22yJ9WHCeSzv6GrhQQsxY5DGO88dcaAs6D5+8FBoVLau?=
 =?us-ascii?Q?zSXKuQ49s9qzzu2hCVLqh8RwxK3NQqt+e8v5Wu9MgSCQhItXKzcF07+ETWQG?=
 =?us-ascii?Q?cfgHTPhf12n2hNwIlUEVKXsM+/EWdBX8C2a+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:26:01.9541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf4e50e-17d6-4159-59bb-08ddf054711c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006

From: Cosmin Ratiu <cratiu@nvidia.com>

The driver allocates a single doorbell per device and uses
it for all Send Queues (SQs). This can become a bottleneck due to the
high number of concurrent MMIO accesses when ringing the same doorbell
from many channels.

This patch makes the doorbells used by channel queues configurable.

mlx5e_channel_pick_doorbell() is added to select the doorbell to be used
for a given channel, picking the default for now.

When opening a channel, the selected doorbell is saved to the channel
struct and used whenever channel-related queues are created.

Finally, 'uar_page' is added to 'struct mlx5e_create_sq_param' to
control which doorbell to use when allocating an SQ, since that can
happen outside channel context (e.g. for PTP).

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h   |  1 +
 .../ethernet/mellanox/mlx5/core/en/params.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c   |  4 +++-
 .../net/ethernet/mellanox/mlx5/core/en/ptp.h   |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c  | 18 ++++++++++++++----
 5 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 0dd3bc0f4caa..9c73165653bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -788,6 +788,7 @@ struct mlx5e_channel {
 	int                        vec_ix;
 	int                        sd_ix;
 	int                        cpu;
+	struct mlx5_sq_bfreg      *bfreg;
 	/* Sync between icosq recovery and XSK enable/disable. */
 	struct mutex               icosq_recovery_lock;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index e3edf79dde5f..00617c65fe3c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -51,6 +51,7 @@ struct mlx5e_create_sq_param {
 	u32                         tisn;
 	u8                          tis_lst_sz;
 	u8                          min_inline_mode;
+	u32                         uar_page;
 };
 
 /* Striding RQ dynamic parameters */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 7c1d9a9ea464..a392578a063c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -334,7 +334,7 @@ static int mlx5e_ptp_alloc_txqsq(struct mlx5e_ptp *c, int txq_ix,
 	sq->mdev      = mdev;
 	sq->ch_ix     = MLX5E_PTP_CHANNEL_IX;
 	sq->txq_ix    = txq_ix;
-	sq->uar_map   = mdev->priv.bfreg.map;
+	sq->uar_map   = c->bfreg->map;
 	sq->min_inline_mode = params->tx_min_inline_mode;
 	sq->hw_mtu    = MLX5E_SW2HW_MTU(params, params->sw_mtu);
 	sq->stats     = &c->priv->ptp_stats.sq[tc];
@@ -486,6 +486,7 @@ static int mlx5e_ptp_open_txqsq(struct mlx5e_ptp *c, u32 tisn,
 	csp.wq_ctrl         = &txqsq->wq_ctrl;
 	csp.min_inline_mode = txqsq->min_inline_mode;
 	csp.ts_cqe_to_dest_cqn = ptpsq->ts_cq.mcq.cqn;
+	csp.uar_page = c->bfreg->index;
 
 	err = mlx5e_create_sq_rdy(c->mdev, sqp, &csp, 0, &txqsq->sqn);
 	if (err)
@@ -900,6 +901,7 @@ int mlx5e_ptp_open(struct mlx5e_priv *priv, struct mlx5e_params *params,
 	c->num_tc   = mlx5e_get_dcb_num_tc(params);
 	c->stats    = &priv->ptp_stats.ch;
 	c->lag_port = lag_port;
+	c->bfreg    = &mdev->priv.bfreg;
 
 	err = mlx5e_ptp_set_state(c, params);
 	if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
index 883c044852f1..1b3c9648220b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
@@ -66,6 +66,7 @@ struct mlx5e_ptp {
 	struct mlx5_core_dev      *mdev;
 	struct hwtstamp_config    *tstamp;
 	DECLARE_BITMAP(state, MLX5E_PTP_STATE_NUM_STATES);
+	struct mlx5_sq_bfreg      *bfreg;
 };
 
 static inline bool mlx5e_use_ptpsq(struct sk_buff *skb)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 02a538ec2ecb..0425f0e3d3a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1532,7 +1532,7 @@ static int mlx5e_alloc_xdpsq(struct mlx5e_channel *c,
 	sq->pdev      = c->pdev;
 	sq->mkey_be   = c->mkey_be;
 	sq->channel   = c;
-	sq->uar_map   = mdev->priv.bfreg.map;
+	sq->uar_map   = c->bfreg->map;
 	sq->min_inline_mode = params->tx_min_inline_mode;
 	sq->hw_mtu    = MLX5E_SW2HW_MTU(params, params->sw_mtu) - ETH_FCS_LEN;
 	sq->xsk_pool  = xsk_pool;
@@ -1617,7 +1617,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
-	sq->uar_map   = mdev->priv.bfreg.map;
+	sq->uar_map   = c->bfreg->map;
 	sq->reserved_room = param->stop_room;
 
 	param->wq.db_numa_node = cpu_to_node(c->cpu);
@@ -1702,7 +1702,7 @@ static int mlx5e_alloc_txqsq(struct mlx5e_channel *c,
 	sq->priv      = c->priv;
 	sq->ch_ix     = c->ix;
 	sq->txq_ix    = txq_ix;
-	sq->uar_map   = mdev->priv.bfreg.map;
+	sq->uar_map   = c->bfreg->map;
 	sq->min_inline_mode = params->tx_min_inline_mode;
 	sq->hw_mtu    = MLX5E_SW2HW_MTU(params, params->sw_mtu);
 	sq->max_sq_mpw_wqebbs = mlx5e_get_max_sq_aligned_wqebbs(mdev);
@@ -1778,7 +1778,7 @@ static int mlx5e_create_sq(struct mlx5_core_dev *mdev,
 	MLX5_SET(sqc,  sqc, flush_in_error_en, 1);
 
 	MLX5_SET(wq,   wq, wq_type,       MLX5_WQ_TYPE_CYCLIC);
-	MLX5_SET(wq,   wq, uar_page,      mdev->priv.bfreg.index);
+	MLX5_SET(wq,   wq, uar_page,      csp->uar_page);
 	MLX5_SET(wq,   wq, log_wq_pg_sz,  csp->wq_ctrl->buf.page_shift -
 					  MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET64(wq, wq, dbr_addr,      csp->wq_ctrl->db.dma);
@@ -1882,6 +1882,7 @@ int mlx5e_open_txqsq(struct mlx5e_channel *c, u32 tisn, int txq_ix,
 	csp.cqn             = sq->cq.mcq.cqn;
 	csp.wq_ctrl         = &sq->wq_ctrl;
 	csp.min_inline_mode = sq->min_inline_mode;
+	csp.uar_page        = c->bfreg->index;
 	err = mlx5e_create_sq_rdy(c->mdev, param, &csp, qos_queue_group_id, &sq->sqn);
 	if (err)
 		goto err_free_txqsq;
@@ -2052,6 +2053,7 @@ static int mlx5e_open_icosq(struct mlx5e_channel *c, struct mlx5e_params *params
 	csp.cqn             = sq->cq.mcq.cqn;
 	csp.wq_ctrl         = &sq->wq_ctrl;
 	csp.min_inline_mode = params->tx_min_inline_mode;
+	csp.uar_page        = c->bfreg->index;
 	err = mlx5e_create_sq_rdy(c->mdev, param, &csp, 0, &sq->sqn);
 	if (err)
 		goto err_free_icosq;
@@ -2112,6 +2114,7 @@ int mlx5e_open_xdpsq(struct mlx5e_channel *c, struct mlx5e_params *params,
 	csp.cqn             = sq->cq.mcq.cqn;
 	csp.wq_ctrl         = &sq->wq_ctrl;
 	csp.min_inline_mode = sq->min_inline_mode;
+	csp.uar_page        = c->bfreg->index;
 	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
 
 	err = mlx5e_create_sq_rdy(c->mdev, param, &csp, 0, &sq->sqn);
@@ -2740,6 +2743,11 @@ void mlx5e_trigger_napi_sched(struct napi_struct *napi)
 	local_bh_enable();
 }
 
+static void mlx5e_channel_pick_doorbell(struct mlx5e_channel *c)
+{
+	c->bfreg = &c->mdev->priv.bfreg;
+}
+
 static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 			      struct mlx5e_params *params,
 			      struct xsk_buff_pool *xsk_pool,
@@ -2794,6 +2802,8 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
+	mlx5e_channel_pick_doorbell(c);
+
 	netif_napi_add_config_locked(netdev, &c->napi, mlx5e_napi_poll, ix);
 	netif_napi_set_irq_locked(&c->napi, irq);
 
-- 
2.31.1


