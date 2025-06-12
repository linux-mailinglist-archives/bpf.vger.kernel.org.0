Return-Path: <bpf+bounces-60477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDC0AD770F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A081881AEC
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996AD2BD597;
	Thu, 12 Jun 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OzbLwe5e"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6A298CDC;
	Thu, 12 Jun 2025 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743277; cv=fail; b=Cr7a3IWVv1dKXeMHGHpdDi66EUEgG1nEGXPTRnl8iwqaaEnLieqKTNVjkyolX1MpATRL6GednMCSFJhnzUJexiFXhc7K6A+njUsudPS/csdp9GTX5ATV1WOiSggteu82hB4MxtaP7QJsi+xyD5FxSfKLyDBU3qReBpPNagBOVyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743277; c=relaxed/simple;
	bh=ZKP5AowOc91bfxJMYUruwyj4KjjnoRH/G5O+SG8VUW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbwHkiBSyJnpj759YEK9hpCpirSwQW9RfhDvEkEhEuSykY8f8Sr0pSHt6QwP0Srd5WgXGP8dbFyr8q+E1DRG2COF5eDK5JZFgpGnnwgSITxpbuEySb2KPITcigOijW7iOnRBDCRPmqnOWpvdX3QbbpE2kRMtCjYWrewYvo/CbkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OzbLwe5e; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATJy6mwX0qbeCsehDs44RyH8d1iCxRGB2OmDcc42m8bRduyLWcZhZ6xKTP8P0kPouvp2y0KsfJTZbFdgVtfrSq82DxWXU4BE7JSDxg66+svWwql2jL0T0TQh18aGu1ary7Wd6mbx6OSpm79lfslFOw8osnNXVf8xG7boQ6BwlY8LYcYXyq2xo107nHfpcIEnxKieImL39xwUX7cuvOCQOk9EcVDAM0LRy3B5ZUd6mvPIO58IXeJpb8J9r4JwRehi0YZhMnzXGWrmS2BkLYiIamF4m2r77kJ7qrn3dR6sLEOLelhrmls18n3mGDVj3mTghsvZ0iUBifhVC2Ln1hjJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgz1OGLRs37uvqGlZMMC1EsF9CaynvpaVkKMug3Cphs=;
 b=QYtkxs5qDTXX8/tiQRJFmJfoOoZsB4Nt6QlyfYUIKt35lXD9ckJAGm+boENYGmYHOexk6UjqXZvB8cSOoRUmX6z1KzS+b1V6vOufYGSBcELm+aHlAMIV6Dn5sUUYXNi0NnFW8yovGxIm0bneDLGiS+zFGylwZkMv2gbgz6QR7gjk8npGc6nWAiHV8b8Ie7jlOhCk6rS9mqfZ32m9Yn9IlELgEJ7WpID/cj97XU18zv3Z1eaffFGSOPLPGkhNhGVU7EXGzVvpiM2Qt7zL9oOcp1us3x3C0LVh45bQ1/nNTOp3IiZ6sbKEahItZnU1Mmm9Viow0KmFeRsSY0Hgve+P6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgz1OGLRs37uvqGlZMMC1EsF9CaynvpaVkKMug3Cphs=;
 b=OzbLwe5e2yv1jeuB5sNwf1nXX97ItgO0ofYhgcf5yzEr9mEX0C9iKY3PEVNynvg6/M5rraEBMaBiIO05SgfPLYkXddg0J6l3OBJF2npcF6ud16bioE9C7mwodC+yjWerbFU7B8buBXaqKDCxBpsW9jzkVzwA0z+01PHM/TZseowwKrbAZhoNpd/JzMTi63OLsBv+GYhJuPub79ZLvoJsdVwDehzrk493j3iKbmM7eNIet0ZyCzSDe7qISoX8jx89KpfV4wWhc9PhJmeR+tyAHdTjVqmy/71i0trCQHykLjNBeNuE4JasQ8YBrIZQRPpOHyHmflHL9eo0TmfsDedLdg==
Received: from SN6PR16CA0050.namprd16.prod.outlook.com (2603:10b6:805:ca::27)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.23; Thu, 12 Jun 2025 15:47:52 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::c5) by SN6PR16CA0050.outlook.office365.com
 (2603:10b6:805:ca::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 12 Jun 2025 15:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:47:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 08:47:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 08:47:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 12
 Jun 2025 08:47:25 -0700
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
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v5 05/12] net/mlx5e: SHAMPO: Remove redundant params
Date: Thu, 12 Jun 2025 18:46:41 +0300
Message-ID: <20250612154648.1161201-6-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8f3849-6d91-40ac-ce3f-08dda9c87d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NK2pCEyDNWj3o2BV38VF1dT8SS3qL32IdUGUacGry0TJIZCsY/H+KeKimUqE?=
 =?us-ascii?Q?9SNUHFM8cJrRHhQ8itTnGjaBn2dj0QhWUK82qoNBmIVnIhlEOLso4YxalOlT?=
 =?us-ascii?Q?+lU3XrHZDlQFxjBPdA5Me+m4d0T6GO1WwfyzJSUzuWfFTCNMAitOdgBGAMTb?=
 =?us-ascii?Q?F7i9/AY8KLa12FUFZdHHe07Dva8FWDFp2HwI10pSVCYuHL31CqbgKvXXXMvo?=
 =?us-ascii?Q?q79A30Oiyy+RidWHyStUy/ewfK/CRqfgOtSexmtpdCPTjv9XbaDaq39PkpK5?=
 =?us-ascii?Q?X8ZoolSQkkQAGc98iG2Y7sgQe2mz6yqI7C/qs7VhCz/I7LbY4KtCGCpIIu6j?=
 =?us-ascii?Q?25fhuygajNaihiJ3IiTrxBBrrLMSaO1VrK9B6ZxbC/TOUY66zp0wyjE3Ok4J?=
 =?us-ascii?Q?CtUz1yA+T75lEyXA3B0Rw4UYRMtYkgRS2Dvoa6Y6GTBqJPRvjMPQQzTzmRLe?=
 =?us-ascii?Q?5u2cM6DvFRv7ZyPoeJKqrHirTSbcyfq/Z+TeLAKHrhmsfek2I6IneL+bOhi3?=
 =?us-ascii?Q?xK7l64gqi8Z831x5U/CjT40FoZlGwATb7ZjU9GOaZXu6umf9m3gtnNJEuo8w?=
 =?us-ascii?Q?iOPetCVX2Kyn7DvslnrV57dSOgsEUnO3gp26VL1SQEgJdh3f9MBnRVPLje7y?=
 =?us-ascii?Q?S+KC0FTJ9SY4tDaMq64Z4iCXvqQOMI+87B6CrSiVHC31vR4REwkWjSSJGq1Z?=
 =?us-ascii?Q?Fn2+kGU3ZIXdCgbDJbzl1gSnKI77itsPCkUjZ2jF1qg19dYS+lO3CYu6muYS?=
 =?us-ascii?Q?NE7J4fMsiTAXDATWa7BLIMcKwOo1kbPmpKN70rP73d8y/T8GShWlQG0cO8tm?=
 =?us-ascii?Q?gCtatmG2vscPWwCBGC3I924/EQ1Rni3emubS+SWAMgNpW7F6AIksJUaoZIR0?=
 =?us-ascii?Q?pL3UYW5eHV0sLQtZXeaJBGU0tt0LBZfeyJw4+e9qD7TS/CTnCtHckVzEm9yZ?=
 =?us-ascii?Q?3/5iPv2GnHfLcY3Y651UB02izP+SSfFi2X9SxsyRoVNqznwQNR+0yDtmPlCY?=
 =?us-ascii?Q?i+URrANYM1Sq2OHTVVDMG0F8uOZd88mSnYlIeVi3LFCz9HexP3etNivdi0JO?=
 =?us-ascii?Q?QTF+5c19h/JqMSyHaBLRAxsHyzoMWORoCxgMwUUwqVi2Yk60Xop4iDHEUu8W?=
 =?us-ascii?Q?b+WGJ+2VkmF2qlrXWhgkNJBE8e2/9uOz/HwudKdVSxN/dKI1rrl7Q96ZyowV?=
 =?us-ascii?Q?T/w2GhAVCIUVhyf0ybAoMoW7ATEL0jh7yklzLAuoXZb1z7MYdgq0J96HrRrv?=
 =?us-ascii?Q?sDkwRVi5SpHO9jS6Y6hRvuqC3KIB23plbQy2whfBFvOnH1gAt/l8Bn65B8Yu?=
 =?us-ascii?Q?w4APGxE2oKRo7JynjeBsHS92y/Q4LqDrXBfvIOaUJD8Q+3yatLnVlhyblXm0?=
 =?us-ascii?Q?U0XKvZ0V5a8Cr2cVeCUFUPByHPI8FBeTstYOXDQog6NyV3y3b7VgKqh4956f?=
 =?us-ascii?Q?WhzPgf+Dnbw2SNXiKIRJSbKOAAcIGsK9vTI6H2EYkffQtRCNMAx1PI2+OlEF?=
 =?us-ascii?Q?PP7Vgre+msc8dNDruw37of7PgAeR2/fd8pLC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:47:51.9558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8f3849-6d91-40ac-ce3f-08dda9c87d87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400

From: Saeed Mahameed <saeedm@nvidia.com>

Two SHAMPO params are static and always the same, remove them from the
global mlx5e_params struct.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 ---
 .../ethernet/mellanox/mlx5/core/en/params.c   | 36 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 ---
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 211ea429ea89..581eef34f512 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -278,10 +278,6 @@ enum packet_merge {
 struct mlx5e_packet_merge_param {
 	enum packet_merge type;
 	u32 timeout;
-	struct {
-		u8 match_criteria_type;
-		u8 alignment_granularity;
-	} shampo;
 };
 
 struct mlx5e_params {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 58ec5e44aa7a..fc945bce933a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -901,6 +901,7 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 {
 	void *rqc = param->rqc;
 	void *wq = MLX5_ADDR_OF(rqc, rqc, wq);
+	u32 lro_timeout;
 	int ndsegs = 1;
 	int err;
 
@@ -926,22 +927,25 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 		MLX5_SET(wq, wq, log_wqe_stride_size,
 			 log_wqe_stride_size - MLX5_MPWQE_LOG_STRIDE_SZ_BASE);
 		MLX5_SET(wq, wq, log_wq_sz, mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
-		if (params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) {
-			MLX5_SET(wq, wq, shampo_enable, true);
-			MLX5_SET(wq, wq, log_reservation_size,
-				 mlx5e_shampo_get_log_rsrv_size(mdev, params));
-			MLX5_SET(wq, wq,
-				 log_max_num_of_packets_per_reservation,
-				 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
-			MLX5_SET(wq, wq, log_headers_entry_size,
-				 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
-			MLX5_SET(rqc, rqc, reservation_timeout,
-				 mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_SHAMPO_TIMEOUT));
-			MLX5_SET(rqc, rqc, shampo_match_criteria_type,
-				 params->packet_merge.shampo.match_criteria_type);
-			MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
-				 params->packet_merge.shampo.alignment_granularity);
-		}
+		if (params->packet_merge.type != MLX5E_PACKET_MERGE_SHAMPO)
+			break;
+
+		MLX5_SET(wq, wq, shampo_enable, true);
+		MLX5_SET(wq, wq, log_reservation_size,
+			 mlx5e_shampo_get_log_rsrv_size(mdev, params));
+		MLX5_SET(wq, wq,
+			 log_max_num_of_packets_per_reservation,
+			 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
+		MLX5_SET(wq, wq, log_headers_entry_size,
+			 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
+		lro_timeout =
+			mlx5e_choose_lro_timeout(mdev,
+						 MLX5E_DEFAULT_SHAMPO_TIMEOUT);
+		MLX5_SET(rqc, rqc, reservation_timeout, lro_timeout);
+		MLX5_SET(rqc, rqc, shampo_match_criteria_type,
+			 MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED);
+		MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
+			 MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE);
 		break;
 	}
 	default: /* MLX5_WQ_TYPE_CYCLIC */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3d11c9f87171..e1e44533b744 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4040,10 +4040,6 @@ static int set_feature_hw_gro(struct net_device *netdev, bool enable)
 
 	if (enable) {
 		new_params.packet_merge.type = MLX5E_PACKET_MERGE_SHAMPO;
-		new_params.packet_merge.shampo.match_criteria_type =
-			MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED;
-		new_params.packet_merge.shampo.alignment_granularity =
-			MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE;
 	} else if (new_params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) {
 		new_params.packet_merge.type = MLX5E_PACKET_MERGE_NONE;
 	} else {
-- 
2.34.1


