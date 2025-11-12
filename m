Return-Path: <bpf+bounces-74278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD1C51665
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 10:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68BEC4FB43B
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB182FF676;
	Wed, 12 Nov 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R46VUR/H"
X-Original-To: bpf@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC52FF678;
	Wed, 12 Nov 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939892; cv=fail; b=u2tPSbF9aX4S0xA4vsQlal/KduodH4UxjwjkjDEKj0FnN6Opd9k5LdhZ/x/5FOTit/o76csxO/oyu/sFyO+GpuWqKnBlzAMu/tAq/MQN0J487uRNOsvCNcGYC4ZARBDRESgFgtObpNFSYJBfJIQFG71aJ63Hg/CT+LOe/vH0lh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939892; c=relaxed/simple;
	bh=LpIhuB4G/aKKvQbEz3fK2Wg6fCcLR6lmMkpTZcG/V54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKyEpXTK9tlzkTbkuNPAql41741TDlPpPqx0CF7wBo44hNC6yt9X364EdnJxk/Y/xKFzEYDV+OBAO5fY3Va90WgCV6jC6CHi0OR+GQq47Q9tPMHF74OAQhwFH+zYdT4eyZSTIFynJfQHarDmyKFZNgAPS9Eerk7Ssv0LtCms4hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R46VUR/H; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYeFAH3/4PZvoB2Yx+eMm1K3D/XKdTduwWwH6B0FUSOUBnVnScSl4mIm2/4J8cUv51/S2BznfUEmQddjGz1tIKVT6B/KL09I9ME69bGiOESapYv3MSLyDOzH5orZJe+BlFHlut2pJ/SNAVLw4WGM9mzZAQDtfLcUPRcUYj2FbjyUkTaoNg3vM4jPlHeHbJM71bQ9HzOb9O9V4LIBk8Pf/TLZRq4wCKTm/Flxb4Pkgp2KrSM933MT0e/zMxczJG7KELiEDu80rRxpyO2iZOD901phnj0y11RH9fM2ACppTIGW75Cixz4C99FD60DK1aiPhgago0gb3+X5/ThfPgYm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81yYwYS90nVXajcSmk+TkliEyFBUF0FS4XKSMJXy7Cw=;
 b=ycGgbJxiclkKTadUw8UhRyA0BU1lZRkWjpLC+Vjrfl3ttiUuTkW9zUWQ9ZSXOpkBKje2oD47vzJiZZKDTrl81P5wymzSG252UhKkFFlKIv7NBbv6vhS2zwgDVPlGaQVWt1ACBwEzpjqRiF5vEMQYEXhchOeuw2lrqs5UJrcE+suuSQwKFvPBx3soCFWOWR1dkd33PkdaxnyhooFVHEDafQ7agf5dW9MDStoSZBwWzpcLYGzkt8V3Wh+t3vUhbZdeUWgEVBiCbeNiViswKB97pLLIVcobvj/0bZoJm7VreMmUXdEmDq/EFBE3ilcSgQwbt3QXNdBGs1BnxTvY0kyOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81yYwYS90nVXajcSmk+TkliEyFBUF0FS4XKSMJXy7Cw=;
 b=R46VUR/HVbTjFszbfmb1McgHp3MQe5+23mgKDEQzZg5mdvTUJfWUJCarLM2JVNtTEomGGek2dv7lxltx2iHnH0iNGX4HeU/bhwcbF1kYVNjUERpLR7FCkEjGH/FQtF3iCgvNxriVnmdNbyHKV7GsUn0ettGL7rKuD3QUuNZCWZgIfdNj4ZVi46U8AE7KjnXHnJQhbL6ST33YkBX6OEWISPobtQljYUzAtRXfARJEV8Iqbfo3XsD9DfqgVLBFxphNSlICZM0/wpLB4lgTIqICOoIk0pVHH92u7ryWks4ri6OlnGhgq8mhf+lpIXiJcx+TKDpdgJKfaecrLmKpicLdXg==
Received: from MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::23)
 by BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 09:31:25 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::2b) by MW4P220CA0018.outlook.office365.com
 (2603:10b6:303:115::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 09:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 09:31:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:06 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:06 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 12
 Nov 2025 01:31:00 -0800
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
Subject: [PATCH net-next 1/6] net/mlx5e: Move async ICOSQ lock into ICOSQ struct
Date: Wed, 12 Nov 2025 11:29:04 +0200
Message-ID: <1762939749-1165658-2-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: ec484438-275d-45ed-42e7-08de21ce4038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p8ixRU1gXTQPlVaQatA7ecYK83rJPUclnXAdY2rfoWmkDkLmvpwNYJ5tVNis?=
 =?us-ascii?Q?Hp8POIZK4vGeNw2/qKJmaNvsTNLfgswWv/iMHlTCElUzh7s55casFXEqGJPX?=
 =?us-ascii?Q?CExjwp7g6sGZpsASCJbdOQF123s/+Kr0Z0o+lIidJjJdNElIWqa8/dSEYC+u?=
 =?us-ascii?Q?w/1BcQodbQFaNK8a4EtxRt12fnEE/GSFUrtBsEa2UkVcdvr2KKvH1fnXbKw0?=
 =?us-ascii?Q?nFQ/cJ+FtEuMhSHoaatLldLWdn3h3C2+MrWfZdZJx3NM0RDilttHpvev5hSR?=
 =?us-ascii?Q?NpiVJtLMkBDJX0kELEegmO4K1I4k4hJ/9KRbq+A015R4pyMgci3Ti0VrhR3W?=
 =?us-ascii?Q?jDhfbwqKp0m6VJsj9gc3rdXikWqS5yoCHQmWKrVlr0duFa1jp9hk7eFxgY8T?=
 =?us-ascii?Q?LH3k/bZNexJrn5ltkyQDBqKzw7FNgMQKyQ9COaaeHxXbm6inNRzed9k1T69R?=
 =?us-ascii?Q?Q7RTuQpVNCaS6ofkWXXvwu4V9RbeO1gS0lk9RoAawci8WudKp9X3jtWK1Ezs?=
 =?us-ascii?Q?gd0QcM5HDIu2Ro0vprF+bfHX63Ejd7ePide3S4ZYpTNq1LYILtCPUuo5Rwfg?=
 =?us-ascii?Q?swyp01avqmDoOXvjuU1rvEU9cH8cCfduNBO3ENMuvLw22gKNGlpj+yxL7OVv?=
 =?us-ascii?Q?DE+TWuZHXahZfEeU70Mupv4LZ1yVmwbVMHE1iu/bo3OPLJrsg80hgv4hYloo?=
 =?us-ascii?Q?UunbeA50Krv4mWIxh/3A/l85EcYr+7r0UkADp9kGevTEHo5/rLHcwoEwCt+8?=
 =?us-ascii?Q?OucSE8mqdgShFQuj/1fADRih/WWLXMvH3+kazdoIlRAEgDlurEHHUcZQuS+C?=
 =?us-ascii?Q?izfSD+f5E+eKjkkTDchQuU9WmlUj+vvmXFLZ2Pug2AWzRBLQYOxK7c0MVTuP?=
 =?us-ascii?Q?FdLkatYHJWySOdAOlp8DtLuya0QCrvOO5z6II/+1jQ/iDCbcyRccJx2R7EgF?=
 =?us-ascii?Q?0VyYrbnDVOmTWaLuyFmZKAAepA9cL07G791HGpTLLm15U9QeYE32P5+ST5ZL?=
 =?us-ascii?Q?MrRBvdlAbB7xFUXhAmntvbgxeXucTp+/4B7f7EwtPIiWv5XmP+I6D1uBFS64?=
 =?us-ascii?Q?URLIA6SVEERGp2M7dfemdZZZmDBnlNe2bKhGa4YVWuSQojUVhJwPdnq9XK2k?=
 =?us-ascii?Q?SXE3NzOVq5Ah2/+hHzVSTTqPdTZznTiJHJ88xITsNWhl/lSGoI7DeN1AX8oQ?=
 =?us-ascii?Q?mZIbOiuJo5dP5qe8fNBs8qnmqRKoogQuJGQ23v2V3aRR3VwOEgdPGKcMbXz8?=
 =?us-ascii?Q?+tcrkLWiwS6E1eLKQNRqF4O7CBFoLAd7G8ybQjJx82HqxvlTI84biB2BO3Qj?=
 =?us-ascii?Q?4v7lrGpNqUFrgDnEnnLZOLcJuF+kMLG90rhWyZ+90aTgxKmCBUSk0Nl6bwjq?=
 =?us-ascii?Q?A34Tryynx769lxsTv91aUrQ/UV94eOIkxaShQx+WIPZH/AayT1Qi81NLyCU3?=
 =?us-ascii?Q?17pwK5vb5pEyCRck0/XIFPInkRkXN9MSYVJxqUC6/TDIMA2TgAgxOI7HrXmd?=
 =?us-ascii?Q?H+tUS6g9xTKYLhsOZ2kXBuZF/sc3t3IAKkOiIgCsV7ziG+A66h+x0G/lcPpo?=
 =?us-ascii?Q?Kh40xOruIxZ7ZVbHjgA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:31:25.6684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec484438-275d-45ed-42e7-08de21ce4038
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488

From: William Tu <witu@nvidia.com>

Move the async_icosq spinlock from the mlx5e_channel structure into
the mlx5e_icosq structure itself for better encapsulation and for
later patch to also use it for other icosq use cases.

Changes:
- Add spinlock_t lock field to struct mlx5e_icosq
- Remove async_icosq_lock field from struct mlx5e_channel
- Initialize the new lock in mlx5e_open_icosq()
- Update all lock usage in ktls_rx.c and en_main.c to use sq->lock
  instead of c->async_icosq_lock

Signed-off-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h   |  4 ++--
 .../mellanox/mlx5/core/en_accel/ktls_rx.c      | 18 +++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_main.c  | 12 +++++++-----
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 3ada7c16adfb..70bc878bd2c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -545,6 +545,8 @@ struct mlx5e_icosq {
 	u32                        sqn;
 	u16                        reserved_room;
 	unsigned long              state;
+	/* icosq can be accessed from any CPU - the spinlock protects it. */
+	spinlock_t                 lock;
 	struct mlx5e_ktls_resync_resp *ktls_resync;
 
 	/* control path */
@@ -777,8 +779,6 @@ struct mlx5e_channel {
 
 	/* Async ICOSQ */
 	struct mlx5e_icosq         async_icosq;
-	/* async_icosq can be accessed from any CPU - the spinlock protects it. */
-	spinlock_t                 async_icosq_lock;
 
 	/* data path - accessed per napi poll */
 	const struct cpumask	  *aff_mask;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index da2d1eb52c13..8bc8231f521f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -203,7 +203,7 @@ static int post_rx_param_wqes(struct mlx5e_channel *c,
 
 	err = 0;
 	sq = &c->async_icosq;
-	spin_lock_bh(&c->async_icosq_lock);
+	spin_lock_bh(&sq->lock);
 
 	cseg = post_static_params(sq, priv_rx);
 	if (IS_ERR(cseg))
@@ -214,7 +214,7 @@ static int post_rx_param_wqes(struct mlx5e_channel *c,
 
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, cseg);
 unlock:
-	spin_unlock_bh(&c->async_icosq_lock);
+	spin_unlock_bh(&sq->lock);
 
 	return err;
 
@@ -277,10 +277,10 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
 
 	buf->priv_rx = priv_rx;
 
-	spin_lock_bh(&sq->channel->async_icosq_lock);
+	spin_lock_bh(&sq->lock);
 
 	if (unlikely(!mlx5e_icosq_can_post_wqe(sq, MLX5E_KTLS_GET_PROGRESS_WQEBBS))) {
-		spin_unlock_bh(&sq->channel->async_icosq_lock);
+		spin_unlock_bh(&sq->lock);
 		err = -ENOSPC;
 		goto err_dma_unmap;
 	}
@@ -311,7 +311,7 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
 	icosq_fill_wi(sq, pi, &wi);
 	sq->pc++;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, cseg);
-	spin_unlock_bh(&sq->channel->async_icosq_lock);
+	spin_unlock_bh(&sq->lock);
 
 	return 0;
 
@@ -413,9 +413,9 @@ static void resync_handle_seq_match(struct mlx5e_ktls_offload_context_rx *priv_r
 		return;
 
 	if (!napi_if_scheduled_mark_missed(&c->napi)) {
-		spin_lock_bh(&c->async_icosq_lock);
+		spin_lock_bh(&sq->lock);
 		mlx5e_trigger_irq(sq);
-		spin_unlock_bh(&c->async_icosq_lock);
+		spin_unlock_bh(&sq->lock);
 	}
 }
 
@@ -772,7 +772,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
 		clear_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC, &sq->state);
 	spin_unlock(&ktls_resync->lock);
 
-	spin_lock(&c->async_icosq_lock);
+	spin_lock(&sq->lock);
 	for (j = 0; j < i; j++) {
 		struct mlx5_wqe_ctrl_seg *cseg;
 
@@ -791,7 +791,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
 	}
 	if (db_cseg)
 		mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, db_cseg);
-	spin_unlock(&c->async_icosq_lock);
+	spin_unlock(&sq->lock);
 
 	priv_rx->rq_stats->tls_resync_res_ok += j;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5ec0f5ca45b4..590707dc6f0e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2075,6 +2075,8 @@ static int mlx5e_open_icosq(struct mlx5e_channel *c, struct mlx5e_params *params
 	if (err)
 		goto err_free_icosq;
 
+	spin_lock_init(&sq->lock);
+
 	if (param->is_tls) {
 		sq->ktls_resync = mlx5e_ktls_rx_resync_create_resp_list();
 		if (IS_ERR(sq->ktls_resync)) {
@@ -2631,8 +2633,6 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	if (err)
 		goto err_close_rx_cq;
 
-	spin_lock_init(&c->async_icosq_lock);
-
 	err = mlx5e_open_icosq(c, params, &cparam->async_icosq, &c->async_icosq,
 			       mlx5e_async_icosq_err_cqe_work);
 	if (err)
@@ -2751,9 +2751,11 @@ static int mlx5e_channel_stats_alloc(struct mlx5e_priv *priv, int ix, int cpu)
 
 void mlx5e_trigger_napi_icosq(struct mlx5e_channel *c)
 {
-	spin_lock_bh(&c->async_icosq_lock);
-	mlx5e_trigger_irq(&c->async_icosq);
-	spin_unlock_bh(&c->async_icosq_lock);
+	struct mlx5e_icosq *async_icosq = &c->async_icosq;
+
+	spin_lock_bh(&async_icosq->lock);
+	mlx5e_trigger_irq(async_icosq);
+	spin_unlock_bh(&async_icosq->lock);
 }
 
 void mlx5e_trigger_napi_sched(struct napi_struct *napi)
-- 
2.31.1


