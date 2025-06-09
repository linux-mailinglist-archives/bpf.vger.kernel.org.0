Return-Path: <bpf+bounces-60060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4740AD21C5
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67D81892808
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F72221D596;
	Mon,  9 Jun 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FyyVxts7"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B421D3D1;
	Mon,  9 Jun 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481195; cv=fail; b=emhJ0o+pjNOph4967Qp/D1SLgT4GrIol7NeL6Hrmp3VHysJs4x74nQtnJNGSyaLDbpjMkaQdkftdFJ5H21NfFfp5YPeIyESiVbrqfQNduYyeDwTsPsUPvHNZhOleCQ7gOGZASBMyYDo9d/SoTAezMLQWW5dhyqC0s/ogfOQHkVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481195; c=relaxed/simple;
	bh=rMYCCfoI3lrJ66avKiFYorJAE9JqGNBcI1kT26stxs0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLCjscXX8CEbZaVf9qvKWSrffzBUfcuHee5vbzwkfol0OEmQ0RZvMhZ6GdPzphwvdCoxzRoWil5o0OpkrfYRLJ4dxVUHCR71HysSuTsMUrcLph2ivm/2/YFuQyprzL2qDbDuk4EZZdzRT5UieV1ervk6FcEs1VNLnde0dsPP6hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FyyVxts7; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMLHqp6kHG5YuNf7zlWQsYsOt8SPUiiErMEPoXJLcwm1C9bkW2OZxHxKqIvcN1MMnKrJ2wmkAs40owtS65QUGKrRkBwWRg3T9MyPTI1+f2axuSJLCIpfZ3AKAcXqlo3XqHGfIQU/EPbPbvXcdB7mPHerkiYzxFkDnrop4dujk2HG5Itpwmp1WTRFY/Emi2eEjDIaDNHdNcHbevONaUGrG/LVeQ6xxr53pKdyqbowhqruU4ij0NDJpCMjxLhwWSzRbhH1CS45PQwmBM+cilQPK99M0Hrc4o4oRFm3Wam6ukgoZZunMoDzutvWyHbNHiFHr08ZxvEiILSXtPpPRq4rBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/vbYfmyb/7tJdwiw+Ua6nw8oIje/fng0N2/l0PMEvQ=;
 b=Pz3Ee7PA0J9zr4ScgG1Z3eOvuF7Ntk5VYV/SmMU3sUjfzhTJLFweOx6yI23CZaKPGlaMYC0G37PJ2VVhUJZ1CbEBM1jMYAmFna3CdlaJq6z+viRuZZDMONYm3bejqEWvKvHsHOsnsLBpwbZ5JvUIyLj1DTV3GZDOo/wVDkhK/Og8OkZiviwhvDoC4vgGIZ1C4hyM5E+sYG/9U0w/KAu46Cpb0xw9CHREpsW6KGJgaiphPJEzxwzyXnliNKCQ69guDtsiTDCLRB6DZk1WLabcJ81MyMMUjGcefcjRx3AJ5JnpSXkzhr7xoC4c9aXfZAcTANJ2DAuFviEJp0zjvfsH7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/vbYfmyb/7tJdwiw+Ua6nw8oIje/fng0N2/l0PMEvQ=;
 b=FyyVxts7G9lG/J2tGWcodQF6rULiajyM64R/oAIaWuJaIsJq83Y8Fx5zoifFA+jfoQxwGTDN6TInH7s9Due1s/L9VjIae1/1sei+0AavVr0ioCaius4WHevZLkIFCkd0bKa/7ccz0ESvvb3pHXhTVldGrisZfSh+vTs2T92gEt9eklKQL98/2aEsfM87WEunj5XPqdL9WwadfSxjbLapleYvCkM66xEX4S8GzKGV32TUv2Gww71jxJXXPhdfryd5Xdv5HPiiI349IR5aOtRt9rZGA0Rqxe+8Sau/I0DymevbFVX6kDdpnfWSsla0b9XVYztrpDK9bw15HBpFnqkqdw==
Received: from CH2PR03CA0008.namprd03.prod.outlook.com (2603:10b6:610:59::18)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Mon, 9 Jun
 2025 14:59:51 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::2d) by CH2PR03CA0008.outlook.office365.com
 (2603:10b6:610:59::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Mon,
 9 Jun 2025 14:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 14:59:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:59:34 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:59:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 07:59:28 -0700
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
Subject: [PATCH net-next v3 07/12] net/mlx5e: SHAMPO: Headers page pool stats
Date: Mon, 9 Jun 2025 17:58:28 +0300
Message-ID: <20250609145833.990793-8-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd6f311-9081-41b2-ffbc-08dda7664926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6e3va3QT9xsKcz89aOcnTwurcseGvRVTKpH4E0Lc8ZDUjUq2Trpvou9xVQfx?=
 =?us-ascii?Q?S8VsytfsWHxCxmXDYF9ByGut/S5isygZ5Rgw3adhrhse9Fe6xTQPWgTY6A2p?=
 =?us-ascii?Q?Dqb+S3NFKZ93y5L99iWw3KHos3rVO6xGgR75Ey+qYxooD9ItQxztG8rxL8A2?=
 =?us-ascii?Q?hDIp9597nexH8LbVHQsN5fWZE2nai/EMQUIUZyyOXfg/CUQiFG5nrLQ+j151?=
 =?us-ascii?Q?4WLQc18u77Clb55nYMQmyFwr5pCixF3ZwoL6Rm5uOy/mZc3KvtweeTmlbdkW?=
 =?us-ascii?Q?j0xWSzJGAywa0bQiyfVMiRNg0XRiyA3XFVC95QTB4sRCy+nR+tEMe+cXiIZi?=
 =?us-ascii?Q?MUhqT4WQ7pQ6bOG+VVFEXinL25ZkM+qkRDVEtkh/5EeToz1+SirNvWu3Rys5?=
 =?us-ascii?Q?pdHwElpVuMQ9LD8hO9yc84qHhGC0Fw7K19uz2tlXPMj7WpKd2PflUH7s5KfV?=
 =?us-ascii?Q?m8Wo8VrDYHXPWzcllgMtwvkM1rROIHoPgaD4b6iOkyAi+axImjmFMKk2RhbO?=
 =?us-ascii?Q?48wtxf5HIgk/M4zx7N0OwQKZ1blzwPx2VEDFWYI0Q+yxmyIeXsUmoXsSEwUn?=
 =?us-ascii?Q?TUNzb1zOkNtOoyD58cvYpHVEMgFbgK++SzSfg1TGoHMZZq2ZwPLoLI1XjPb1?=
 =?us-ascii?Q?vvqDFapzIiYGOrVvSBLg4Xl1lsQBQDEmG3fs0xbWVy2mjpRGMSo+GdHJFrBo?=
 =?us-ascii?Q?HXvbiyhqOUKxAv36ZxyZzPMAzi6yvI/HvFGuuH7SWSFTjYDIdKapiU/ea9Yy?=
 =?us-ascii?Q?69CQJ/2g3PQwYkC8qz2xDTBc8EeBTFvmP5GOBORIB6zicZyFBkY29t6TDBQ2?=
 =?us-ascii?Q?KlCocDLrfVIpxknzxeeHAHd4a+ocxgfn5Qs7Pzhtute/Np1NLcew1FK3IU7j?=
 =?us-ascii?Q?sQ+hzpB0wfvJqov8TgFPypxWdnd0hOYfqixYnCKXcxAL9jB3teyQr8pzjjhk?=
 =?us-ascii?Q?foSNZYfHNyFjQ5ayR6twrvUNyLPXqXn5HCZpLt+CYMtcTc0f8vYbSaOl1m0Z?=
 =?us-ascii?Q?p1K6/D/+WHwrYi93nFxTpRNMEFoThFhhvOVvc+TCNEJJEyI02sYk0YmOVT1Y?=
 =?us-ascii?Q?jf/T/OlMU9VeasXfSrkLhIUOxzFGXOWsi5OSNdvB/NnQVf9+F7wa3QzMajdm?=
 =?us-ascii?Q?ZnNPcylrvZ3dTSF4MUmZwvYjRZggaCo0LpkgaA4nb1f4GbqaSPp0BQEnGtMn?=
 =?us-ascii?Q?Q1zRf+RvGhI5WINZWxXAokwtc1Pv7MUlrNnJ3Tkg0jQBNS5UXH+JLkSxfXUn?=
 =?us-ascii?Q?RKwfEpvXiDDgvKVFqlK+E6A+DboWg/yosi9BpPVnPq3sz49eF9Mu9EejadpP?=
 =?us-ascii?Q?zj8L7XyJM/NrJVG7OURExzDElGX63hESdS1qK53TdVAzbylPVlWBgmFh/asy?=
 =?us-ascii?Q?3Vs1Vg6619RlppcSMIo8ddJI8IzgjdcBKFGklZHo1D8Mx7jrKljaSU7rrvwy?=
 =?us-ascii?Q?ppkW7A88YWR5tiRDdm1ST3TkW72YlLz7z7Hqp+1q/q62t1TYDIIgw5d6uJUR?=
 =?us-ascii?Q?zgcW9MfbrUVnuqGhdoENO8Pg/kO5xoHCoO/l?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:59:51.0743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd6f311-9081-41b2-ffbc-08dda7664926
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

From: Saeed Mahameed <saeedm@nvidia.com>

Expose the stats of the new headers page pool.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 54 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    | 24 +++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 19664fa7f217..8422afbfa419 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -205,6 +205,18 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring_full) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_released_ref) },
+
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_alloc_fast) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_alloc_slow) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_alloc_slow_high_order) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_alloc_empty) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_alloc_refill) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_alloc_waive) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_recycle_cached) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_recycle_cache_full) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_recycle_ring) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_recycle_ring_full) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_recycle_released_ref) },
 #ifdef CONFIG_MLX5_EN_TLS
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_bytes) },
@@ -384,6 +396,18 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_pp_recycle_ring			+= rq_stats->pp_recycle_ring;
 	s->rx_pp_recycle_ring_full		+= rq_stats->pp_recycle_ring_full;
 	s->rx_pp_recycle_released_ref		+= rq_stats->pp_recycle_released_ref;
+
+	s->rx_pp_hd_alloc_fast          += rq_stats->pp_hd_alloc_fast;
+	s->rx_pp_hd_alloc_slow          += rq_stats->pp_hd_alloc_slow;
+	s->rx_pp_hd_alloc_empty         += rq_stats->pp_hd_alloc_empty;
+	s->rx_pp_hd_alloc_refill        += rq_stats->pp_hd_alloc_refill;
+	s->rx_pp_hd_alloc_waive         += rq_stats->pp_hd_alloc_waive;
+	s->rx_pp_hd_alloc_slow_high_order	+= rq_stats->pp_hd_alloc_slow_high_order;
+	s->rx_pp_hd_recycle_cached		+= rq_stats->pp_hd_recycle_cached;
+	s->rx_pp_hd_recycle_cache_full		+= rq_stats->pp_hd_recycle_cache_full;
+	s->rx_pp_hd_recycle_ring		+= rq_stats->pp_hd_recycle_ring;
+	s->rx_pp_hd_recycle_ring_full		+= rq_stats->pp_hd_recycle_ring_full;
+	s->rx_pp_hd_recycle_released_ref	+= rq_stats->pp_hd_recycle_released_ref;
 #ifdef CONFIG_MLX5_EN_TLS
 	s->rx_tls_decrypted_packets   += rq_stats->tls_decrypted_packets;
 	s->rx_tls_decrypted_bytes     += rq_stats->tls_decrypted_bytes;
@@ -511,6 +535,24 @@ static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
 	rq_stats->pp_recycle_ring = stats.recycle_stats.ring;
 	rq_stats->pp_recycle_ring_full = stats.recycle_stats.ring_full;
 	rq_stats->pp_recycle_released_ref = stats.recycle_stats.released_refcnt;
+
+	pool = c->rq.hd_page_pool;
+	if (!pool || pool == c->rq.page_pool ||
+	    !page_pool_get_stats(pool, &stats))
+		return;
+
+	rq_stats->pp_hd_alloc_fast = stats.alloc_stats.fast;
+	rq_stats->pp_hd_alloc_slow = stats.alloc_stats.slow;
+	rq_stats->pp_hd_alloc_slow_high_order = stats.alloc_stats.slow_high_order;
+	rq_stats->pp_hd_alloc_empty = stats.alloc_stats.empty;
+	rq_stats->pp_hd_alloc_waive = stats.alloc_stats.waive;
+	rq_stats->pp_hd_alloc_refill = stats.alloc_stats.refill;
+
+	rq_stats->pp_hd_recycle_cached = stats.recycle_stats.cached;
+	rq_stats->pp_hd_recycle_cache_full = stats.recycle_stats.cache_full;
+	rq_stats->pp_hd_recycle_ring = stats.recycle_stats.ring;
+	rq_stats->pp_hd_recycle_ring_full = stats.recycle_stats.ring_full;
+	rq_stats->pp_hd_recycle_released_ref = stats.recycle_stats.released_refcnt;
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
@@ -2130,6 +2172,18 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring_full) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_released_ref) },
+
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_alloc_fast) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_alloc_slow) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_alloc_slow_high_order) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_alloc_empty) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_alloc_refill) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_alloc_waive) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_recycle_cached) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_recycle_cache_full) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_recycle_ring) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_recycle_ring_full) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_recycle_released_ref) },
 #ifdef CONFIG_MLX5_EN_TLS
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_bytes) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index def5dea1463d..113221dfcdfa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -226,6 +226,18 @@ struct mlx5e_sw_stats {
 	u64 rx_pp_recycle_ring;
 	u64 rx_pp_recycle_ring_full;
 	u64 rx_pp_recycle_released_ref;
+
+	u64 rx_pp_hd_alloc_fast;
+	u64 rx_pp_hd_alloc_slow;
+	u64 rx_pp_hd_alloc_slow_high_order;
+	u64 rx_pp_hd_alloc_empty;
+	u64 rx_pp_hd_alloc_refill;
+	u64 rx_pp_hd_alloc_waive;
+	u64 rx_pp_hd_recycle_cached;
+	u64 rx_pp_hd_recycle_cache_full;
+	u64 rx_pp_hd_recycle_ring;
+	u64 rx_pp_hd_recycle_ring_full;
+	u64 rx_pp_hd_recycle_released_ref;
 #ifdef CONFIG_MLX5_EN_TLS
 	u64 tx_tls_encrypted_packets;
 	u64 tx_tls_encrypted_bytes;
@@ -394,6 +406,18 @@ struct mlx5e_rq_stats {
 	u64 pp_recycle_ring;
 	u64 pp_recycle_ring_full;
 	u64 pp_recycle_released_ref;
+
+	u64 pp_hd_alloc_fast;
+	u64 pp_hd_alloc_slow;
+	u64 pp_hd_alloc_slow_high_order;
+	u64 pp_hd_alloc_empty;
+	u64 pp_hd_alloc_refill;
+	u64 pp_hd_alloc_waive;
+	u64 pp_hd_recycle_cached;
+	u64 pp_hd_recycle_cache_full;
+	u64 pp_hd_recycle_ring;
+	u64 pp_hd_recycle_ring_full;
+	u64 pp_hd_recycle_released_ref;
 #ifdef CONFIG_MLX5_EN_TLS
 	u64 tls_decrypted_packets;
 	u64 tls_decrypted_bytes;
-- 
2.34.1


