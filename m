Return-Path: <bpf+bounces-58236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E823AB7659
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 22:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A828C09AA
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 20:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF52295DAB;
	Wed, 14 May 2025 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UKvIfe2V"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676FDC120;
	Wed, 14 May 2025 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253098; cv=fail; b=TtmZHqWCKDdfeNokqX/Bbux6u90VhnA4K7N3B+KzzrnRfGI1mWlYgSTQPJ0PqgYaiX89fxeTvX7CWhRXBsH74rSaLXUuxOVKD7gEtIjtdimckDBETGPvAaEQGQnvg649G9Mffd2a3aU0EVwxEJ6PdBXttmCfqbXIbdt7Zc0NGrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253098; c=relaxed/simple;
	bh=C9KIldj4qHQujjMALKuKTBFHPXONrRCYHOjxSDnVjg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EpwWpk7c5pS7J/ibyxG/sq3GYstf51P1ZG4MG9OPJz6+pGB6A255oaRrSDcqDk5VCYGQew1mo/3DWl+yqaKbGl0ohwmsiXND3NXc8NHUN56srEKb0bbUZq2OSZCxu071uewFHS5jfMVYeEIVvw4b92hcoEgmLfq77FjyUAjRMXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UKvIfe2V; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AruhYA/TQxx/wXxvVhfFf+iHlHg5GlBgyjFhG1Wnc0tKPL3TkYVdzaBHSVXS4Pb5sTDs3/wl7QtQddmsSILLLmv5+/J027Fp78EluLE/vbw8icte/KWj5gLdJPpVmpxPci0/FPaNyLRaauVi5ZevEqoAiub49h/IwJ3W8KJGd+tbXJ+1K9EPFJlwA6wvy2i9rHF5zkVOCmbh4iVmAFn8Sn7xHsc5eZcDq8dNzmWb8O335tw9VmNw3GuvRGtC/dSRRwAyAIDi4nYbdJf4joZfyIFRtyJNzb+L/LcHGlWw7B/hWlfwsijlekGP8fB437EqCnsZKzsxHytk7MLNWhkSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7Am0O4uab0wETWmLAPLU9WPUT58Ini6HnVtl7+1oUM=;
 b=UEY7sdNUDqXQ2KP28VN09uru+bwVn/tsYCcY48kw2hVlouroyLtLB+kLqMcS/DVzRZlT0JRlFJ9mCU/XRdo/Lita7RJmupNw4JmhS6r1Ll6vcq1pL3WhlE3uFEYexiFQDj82jpaH5EidnoLZunLnxsmzbvMQTP8Pyv5BegVq83xVGvFexteAjwL8iy2lZMrFIn6EfijjDZLDjoMbssu2g6u50j8XPgP7eLYkTCm60Xe8+n0lkiGQhda2pepr7Z78dXoq+oL9+XMqa8ywxJdM5aH3GfFOrn4JdtuVKw/2yzWtmNU5Bk7ixfpL8qfSlZJFM6SY5lPQnRt+KRbOXhWIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7Am0O4uab0wETWmLAPLU9WPUT58Ini6HnVtl7+1oUM=;
 b=UKvIfe2VUpc/wWps5Di500rATrx2wkKxFZ66bK6mi6ibgfFe2EqR1jz8IxMOmhy5wC70LE6OYYb29geLk7zIS3J1s26mqY9Yo9olz2t5ItHwILxI68Rk2N+9qF2EkIbOxI8+wCwjmNjyO2siL9G9+VV0PnFBCyPLYe4UeMVzTl4QYiSV+aymWLY+WKJjCevw+J5HHiSL+Vn9PhTPcpWpFenG7FCoH/UzaEf7UCpSKiD9dM/9tyABVwFmMYk6/TH1X7te9I15V6QVf1whOyjyhu9NssvdIb7sv+fWT/dy48X9y/JYWZIr4AYqBtt8OndkbpJ+sotzCB9XdmBZjAWycA==
Received: from DS7PR05CA0065.namprd05.prod.outlook.com (2603:10b6:8:57::10) by
 PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 20:04:52 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::d6) by DS7PR05CA0065.outlook.office365.com
 (2603:10b6:8:57::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.14 via Frontend Transport; Wed,
 14 May 2025 20:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 20:04:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 May
 2025 13:04:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 14 May
 2025 13:04:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 14
 May 2025 13:04:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next] net/mlx5e: Reuse per-RQ XDP buffer to avoid stack zeroing overhead
Date: Wed, 14 May 2025 23:03:52 +0300
Message-ID: <1747253032-663457-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 566c1189-f478-43a6-8b34-08dd93229633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQqGwQ1kDiMCtu0xxT7+MWWsUEb/iNXEhN5N1BU8i4o427qRlaqBh6rc4eAA?=
 =?us-ascii?Q?Mjeu5ssjoeapMQaK5h0uTApyokmR97SpyNh4eckJNjQkKBv00t7aznocRo/7?=
 =?us-ascii?Q?D87ggN+RfiY26vKqbr5yAgUahwe2IHVDQPtNwET4RP8siIgalssc2S4dJKhk?=
 =?us-ascii?Q?k9nSgqajrb2TYgaAyEzxiDz5ahFst/Bz+pK1PnEwh2Cr5AsDWjTt5OU0HKx8?=
 =?us-ascii?Q?ieW46R+mPxKkquBf3kvdQM3YGKmKy68fzmNo4dYKjJv+Z8uYiUoy/iNLK3hk?=
 =?us-ascii?Q?KfojRXJAsvnUqBjIZjFdjx28Qj/mVh/zP4LULls6yvOSk8feyOzxeGc0OOwb?=
 =?us-ascii?Q?c6/Qo6mzKNj393OBOUUBSTDCUV/NgX61T9iYrYt73SdVPan8E1NiyxezwBa9?=
 =?us-ascii?Q?DlbfvcNsTsqxw0Te2cEIVwmKiR2AVhfaxui4b/9Z+2gvLmfilWvAujarFhKk?=
 =?us-ascii?Q?s0VJPrOLR5/YPrBNjtYiEoqD+QeMZGqwYMS6Nu+LuhA9Ps50OmEuvFwU7T7R?=
 =?us-ascii?Q?92XitQY1pj2djfZEuOCkwe5VKLeAI6DBb9x7syBvYeSrU8kz/6AORFGcklSB?=
 =?us-ascii?Q?fyrdaMeCzIlYEfvcZ9d0rHvQ+vhBEMmdG5Y64lqFuVJFhpJjmTzIUZxRUMWK?=
 =?us-ascii?Q?VM3V4AhphIM32gb/HI0YW+LPL3QHJGPGE3YBUSbEX2M+JSslTmK96Wju1dvK?=
 =?us-ascii?Q?fmAUqin3G0dmzKtVWCByUbOuLL9cTDDyCVUFMWCHDOOUA94nt9RJa9fUsxOs?=
 =?us-ascii?Q?L+DTCm+qYcaPR2T9OTTIlh9idQhLiO9ZlqNlDqFTTjkvL+8V2Rri4Qx3z/dB?=
 =?us-ascii?Q?BuG6t7hLbv2Ct/27Yoaztg6HXW90qnv/mmxWAsRRL6jx9TGa/BfZnwgKRDFk?=
 =?us-ascii?Q?fs+AIWz1t+Fllx1IHA/pFq4ger0lT1+8QcUqs2w54um0a2HCv1IANRHgm8OI?=
 =?us-ascii?Q?Z45zYmCi3Hz87ydPdoVMLdd5ve7MSXt+Ct1kvI5IX+X4rGkdNNETA89dZj8i?=
 =?us-ascii?Q?NHSoSj+muvV7TXRNSRz31U6QXyfiP2N4kZOfVyGYdwKNUOYSZBRfdpu/lnIx?=
 =?us-ascii?Q?GgutGae1rjdIdBh1/P8Jj9F2VtgXn2RoQ2Qf+56WVM02bUlhGIzdIpsNOHNF?=
 =?us-ascii?Q?kyS8jCVEuCOkB8I3QI1DfgMa5YVRfs1312Qc+/9cJLeXpyUyHxM32vYgQwrS?=
 =?us-ascii?Q?jkPxSK2JHI2C0aKDRd8X+qeRQsHeGSSrL+wliBRUVfo8sRFjnLlhHBefhgbh?=
 =?us-ascii?Q?75HPMEsBbo7x8scblKBv1UJC2GJrW9y56YeB9oFWjmk3ZtbnIWNyKSoCYDVU?=
 =?us-ascii?Q?5Uce8CNWrK/QFmkEjvOz2lRCmICoaOxp9q4rZaEAIx4lQ+F59+LcZUcJAH/F?=
 =?us-ascii?Q?+AnyNzNStiKkfURFGmi4ZOUbBW+5v/Ou+gPMttIpPLgSILtLLam1kv8RgGDy?=
 =?us-ascii?Q?n82PLulvuSRjSM7RE+p5E3W+HdrNPtz3VX9frNy6nYwK6ol15TvDSfkKs3Li?=
 =?us-ascii?Q?KSeDYf85uFslKNsL0jH9f7i6Ejy2x1k6w6BC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 20:04:51.3126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566c1189-f478-43a6-8b34-08dd93229633
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080

From: Carolina Jubran <cjubran@nvidia.com>

CONFIG_INIT_STACK_ALL_ZERO introduces a performance cost by
zero-initializing all stack variables on function entry. The mlx5 XDP
RX path previously allocated a struct mlx5e_xdp_buff on the stack per
received CQE, resulting in measurable performance degradation under
this config.

This patch reuses a mlx5e_xdp_buff stored in the mlx5e_rq struct,
avoiding per-CQE stack allocations and repeated zeroing.

With this change, XDP_DROP and XDP_TX performance matches that of
kernels built without CONFIG_INIT_STACK_ALL_ZERO.

Performance was measured on a ConnectX-6Dx using a single RX channel
(1 CPU at 100% usage) at ~50 Mpps. The baseline results were taken from
net-next-6.15.

Stack zeroing disabled:
- XDP_DROP:
    * baseline:                     31.47 Mpps
    * baseline + per-RQ allocation: 32.31 Mpps (+2.68%)

- XDP_TX:
    * baseline:                     12.41 Mpps
    * baseline + per-RQ allocation: 12.95 Mpps (+4.30%)

Stack zeroing enabled:
- XDP_DROP:
    * baseline:                     24.32 Mpps
    * baseline + per-RQ allocation: 32.27 Mpps (+32.7%)

- XDP_TX:
    * baseline:                     11.80 Mpps
    * baseline + per-RQ allocation: 12.24 Mpps (+3.72%)

Reported-by: Sebastiano Miano <mianosebastiano@gmail.com>
Reported-by: Samuel Dobron <sdobron@redhat.com>
Link: https://lore.kernel.org/all/CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com/
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  7 ++
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  6 --
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 81 ++++++++++---------
 3 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 32ed4963b8ad..5b0d03b3efe8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -520,6 +520,12 @@ struct mlx5e_xdpsq {
 	struct mlx5e_channel      *channel;
 } ____cacheline_aligned_in_smp;
 
+struct mlx5e_xdp_buff {
+	struct xdp_buff xdp;
+	struct mlx5_cqe64 *cqe;
+	struct mlx5e_rq *rq;
+};
+
 struct mlx5e_ktls_resync_resp;
 
 struct mlx5e_icosq {
@@ -716,6 +722,7 @@ struct mlx5e_rq {
 	struct mlx5e_xdpsq    *xdpsq;
 	DECLARE_BITMAP(flags, 8);
 	struct page_pool      *page_pool;
+	struct mlx5e_xdp_buff mxbuf;
 
 	/* AF_XDP zero-copy */
 	struct xsk_buff_pool  *xsk_pool;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index 446e492c6bb8..46ab0a9e8cdd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -45,12 +45,6 @@
 	(MLX5E_XDP_INLINE_WQE_MAX_DS_CNT * MLX5_SEND_WQE_DS - \
 	 sizeof(struct mlx5_wqe_inline_seg))
 
-struct mlx5e_xdp_buff {
-	struct xdp_buff xdp;
-	struct mlx5_cqe64 *cqe;
-	struct mlx5e_rq *rq;
-};
-
 /* XDP packets can be transmitted in different ways. On completion, we need to
  * distinguish between them to clean up things in a proper way.
  */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 5fd70b4d55be..84b1ab8233b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1684,17 +1684,17 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog) {
-		struct mlx5e_xdp_buff mxbuf;
+		struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 
 		net_prefetchw(va); /* xdp_frame data area */
 		mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-				 cqe_bcnt, &mxbuf);
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf))
+				 cqe_bcnt, mxbuf);
+		if (mlx5e_xdp_handle(rq, prog, mxbuf))
 			return NULL; /* page/packet was consumed by XDP */
 
-		rx_headroom = mxbuf.xdp.data - mxbuf.xdp.data_hard_start;
-		metasize = mxbuf.xdp.data - mxbuf.xdp.data_meta;
-		cqe_bcnt = mxbuf.xdp.data_end - mxbuf.xdp.data;
+		rx_headroom = mxbuf->xdp.data - mxbuf->xdp.data_hard_start;
+		metasize = mxbuf->xdp.data - mxbuf->xdp.data_meta;
+		cqe_bcnt = mxbuf->xdp.data_end - mxbuf->xdp.data;
 	}
 	frag_size = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize);
@@ -1713,11 +1713,11 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 			     struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
 {
 	struct mlx5e_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
+	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 	struct mlx5e_wqe_frag_info *head_wi = wi;
 	u16 rx_headroom = rq->buff.headroom;
 	struct mlx5e_frag_page *frag_page;
 	struct skb_shared_info *sinfo;
-	struct mlx5e_xdp_buff mxbuf;
 	u32 frag_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
@@ -1737,8 +1737,8 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	net_prefetch(va + rx_headroom);
 
 	mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-			 frag_consumed_bytes, &mxbuf);
-	sinfo = xdp_get_shared_info_from_buff(&mxbuf.xdp);
+			 frag_consumed_bytes, mxbuf);
+	sinfo = xdp_get_shared_info_from_buff(&mxbuf->xdp);
 	truesize = 0;
 
 	cqe_bcnt -= frag_consumed_bytes;
@@ -1750,8 +1750,9 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 		frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
 
-		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf.xdp, frag_page,
-					       wi->offset, frag_consumed_bytes);
+		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf->xdp,
+					       frag_page, wi->offset,
+					       frag_consumed_bytes);
 		truesize += frag_info->frag_stride;
 
 		cqe_bcnt -= frag_consumed_bytes;
@@ -1760,7 +1761,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	}
 
 	prog = rcu_dereference(rq->xdp_prog);
-	if (prog && mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 			struct mlx5e_wqe_frag_info *pwi;
 
@@ -1770,21 +1771,23 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 		return NULL; /* page/packet was consumed by XDP */
 	}
 
-	skb = mlx5e_build_linear_skb(rq, mxbuf.xdp.data_hard_start, rq->buff.frame0_sz,
-				     mxbuf.xdp.data - mxbuf.xdp.data_hard_start,
-				     mxbuf.xdp.data_end - mxbuf.xdp.data,
-				     mxbuf.xdp.data - mxbuf.xdp.data_meta);
+	skb = mlx5e_build_linear_skb(
+		rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
+		mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
+		mxbuf->xdp.data_end - mxbuf->xdp.data,
+		mxbuf->xdp.data - mxbuf->xdp.data_meta);
 	if (unlikely(!skb))
 		return NULL;
 
 	skb_mark_for_recycle(skb);
 	head_wi->frag_page->frags++;
 
-	if (xdp_buff_has_frags(&mxbuf.xdp)) {
+	if (xdp_buff_has_frags(&mxbuf->xdp)) {
 		/* sinfo->nr_frags is reset by build_skb, calculate again. */
 		xdp_update_skb_shared_info(skb, wi - head_wi - 1,
 					   sinfo->xdp_frags_size, truesize,
-					   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+					   xdp_buff_is_frag_pfmemalloc(
+						&mxbuf->xdp));
 
 		for (struct mlx5e_wqe_frag_info *pwi = head_wi + 1; pwi < wi; pwi++)
 			pwi->frag_page->frags++;
@@ -1984,10 +1987,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
 	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
+	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
-	struct mlx5e_xdp_buff mxbuf;
 	unsigned int truesize = 0;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
@@ -2033,9 +2036,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		}
 	}
 
-	mlx5e_fill_mxbuf(rq, cqe, va, linear_hr, linear_frame_sz, linear_data_len, &mxbuf);
+	mlx5e_fill_mxbuf(rq, cqe, va, linear_hr, linear_frame_sz,
+			 linear_data_len, mxbuf);
 
-	sinfo = xdp_get_shared_info_from_buff(&mxbuf.xdp);
+	sinfo = xdp_get_shared_info_from_buff(&mxbuf->xdp);
 
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
@@ -2046,7 +2050,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		else
 			truesize += ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz));
 
-		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf.xdp, frag_page, frag_offset,
+		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf->xdp,
+					       frag_page, frag_offset,
 					       pg_consumed_bytes);
 		byte_cnt -= pg_consumed_bytes;
 		frag_offset = 0;
@@ -2054,7 +2059,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	}
 
 	if (prog) {
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 				struct mlx5e_frag_page *pfp;
 
@@ -2067,10 +2072,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
-		skb = mlx5e_build_linear_skb(rq, mxbuf.xdp.data_hard_start,
-					     linear_frame_sz,
-					     mxbuf.xdp.data - mxbuf.xdp.data_hard_start, 0,
-					     mxbuf.xdp.data - mxbuf.xdp.data_meta);
+		skb = mlx5e_build_linear_skb(
+			rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
+			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
+			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq, &wi->linear_page);
 			return NULL;
@@ -2080,13 +2085,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		wi->linear_page.frags++;
 		mlx5e_page_release_fragmented(rq, &wi->linear_page);
 
-		if (xdp_buff_has_frags(&mxbuf.xdp)) {
+		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
 
 			/* sinfo->nr_frags is reset by build_skb, calculate again. */
 			xdp_update_skb_shared_info(skb, frag_page - head_page,
 						   sinfo->xdp_frags_size, truesize,
-						   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+						   xdp_buff_is_frag_pfmemalloc(
+							&mxbuf->xdp));
 
 			pagep = head_page;
 			do
@@ -2097,12 +2103,13 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	} else {
 		dma_addr_t addr;
 
-		if (xdp_buff_has_frags(&mxbuf.xdp)) {
+		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
 
 			xdp_update_skb_shared_info(skb, sinfo->nr_frags,
 						   sinfo->xdp_frags_size, truesize,
-						   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+						   xdp_buff_is_frag_pfmemalloc(
+							&mxbuf->xdp));
 
 			pagep = frag_page - sinfo->nr_frags;
 			do
@@ -2152,20 +2159,20 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog) {
-		struct mlx5e_xdp_buff mxbuf;
+		struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 
 		net_prefetchw(va); /* xdp_frame data area */
 		mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-				 cqe_bcnt, &mxbuf);
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+				 cqe_bcnt, mxbuf);
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
 				frag_page->frags++;
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
-		rx_headroom = mxbuf.xdp.data - mxbuf.xdp.data_hard_start;
-		metasize = mxbuf.xdp.data - mxbuf.xdp.data_meta;
-		cqe_bcnt = mxbuf.xdp.data_end - mxbuf.xdp.data;
+		rx_headroom = mxbuf->xdp.data - mxbuf->xdp.data_hard_start;
+		metasize =  mxbuf->xdp.data -  mxbuf->xdp.data_meta;
+		cqe_bcnt =  mxbuf->xdp.data_end -  mxbuf->xdp.data;
 	}
 	frag_size = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize);

base-commit: 664bf117a30804b442a88a8462591bb23f5a0f22
-- 
2.31.1


