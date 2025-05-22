Return-Path: <bpf+bounces-58764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E50D9AC1614
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5F71C0282B
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F525F782;
	Thu, 22 May 2025 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VspE1ft8"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434BF259483;
	Thu, 22 May 2025 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950190; cv=fail; b=MCH5SmAsd4XYL65cCg24yO/ZLp2azqp+WiziTdDYwV2NQMMvovT3JcTERCHI2tdPu2yq3IStU+UfmU9QaSnlA5bQjFu0Ptt3B5Hfmt6bbzfOeiF8jrknnureK/GyVB4ox28c68LF+LRcj5zfzzoHZnzujvHHMDXqmcw83SvQpoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950190; c=relaxed/simple;
	bh=qfarjL2EpMn9r/p00Hug1n2m15/AXGx1wOVpJWvEdqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMAyyxGbeOXuinaiIfKIaD3ZK6vzZ4lc8a47gni5cdeCojCgHwAu5LaSCNHUa+vgp+E/UOvPRHwd8zeAQp6/0HNUAkXTSYTRx4nv5I1dFdVrM+0/ndGnTb3tIrEIxMrbQU7LlYvoQl42DxdHjpCupfNWM9KSRfbJwqJRsJ0OyXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VspE1ft8; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKG3IJxWlOkfkz3pzCPHgoQy8i7kZam0HZanIfnWNLzF9GyUmHqgM51yGnkXeHveagVQpLcLnB74roW9Hh1POxYHEUgQ+Oxmb9a1iTT/h+wIcDwHA+GD4q0h4QwWL4u+MA6Aws/8k6tJgTfuK3RMfy+lFGTfW2ANzkErk8z98WZjVAQmMKOmT7P3jdv+/PCXO1OR0l1m47WiK027QtkQW8ljUSSR5cX9V/ENg9l6UR6yYjj+cJDX+JDYptH+UQc7bsRBM6MUMqqAA5grJW6EizcMJvB5i38DHgzlkbcBvWM2MxaLaJ/rX0cvGGUtKgT5ZO2wwFWim3UvjmkQK4pImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA4WIi3KnJLyKWyYqupme70L9sk8yPVKBUXoXMkOAh4=;
 b=mvMB6d2cNI0GEyKUwyPz7hwYrXGoVPWucLaXQiiEOryi06etpTK9wdNMTBtRq2QKnemIYhSqX0gNdv5/e9psgcaGxlIoAANM1GG2qbOF7kRYR5w4F4DcK+jrp290dIFZU774JgE5BYsnQGkLhDyQYk9jZMdHNMFkiGQKFMLTiGUryEfV7M19Bd4p1DJ44AhQBTLppcPINt7gVfx2s8uoBc5nUYS2cfoyqpBXvTa1PjEWzjvyVXtnskprHaGwxYyzbFat2J1oNvrcETZ+UnyAxCBLeTJT8Wkp8FBDeJkj/iyiUNsYxBEPg2nu2Og/BuuFbOrFJq3yhIym2NybzvkKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA4WIi3KnJLyKWyYqupme70L9sk8yPVKBUXoXMkOAh4=;
 b=VspE1ft8yR8JMb0okuMaEDRh2IeyLR45b+fX6kr9Ql1hDewPqGKP8lHuOzMkE4ElD+JwlhXIDC+/CHWba1ILwyL8CY6DfERsdA/tSxd3VJ/FOVb1FK+x5HTgX/WToaI39tpZDbSzthei0wHspf6oCDobY7Z9m4VQ8jKKLhYetbk729bvgg8FB6JDrfW7Hl6xHn7jS79LHqCuLzqu3aQ5G5z4kT2geod1s+B/bBct72frWSCJc8RT3JP71DmraVnWaWTltns+kMorjs4XjtWtUioNvsj+Ce/UWBGvfog2FjKcsACf3tVNaBwWi+OhCMSN1t2UgndPy02N4eN6fyaIHA==
Received: from DS7P220CA0068.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::23) by
 DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.31; Thu, 22 May 2025 21:43:06 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com (2603:10b6:8:224::4)
 by DS7P220CA0068.outlook.office365.com (2603:10b6:8:224::23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Thu, 22 May 2025 21:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:43:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 14:42:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 14:42:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 14:42:48 -0700
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
Subject: [PATCH net-next V2 07/11] net/mlx5e: SHAMPO: Headers page pool stats
Date: Fri, 23 May 2025 00:41:22 +0300
Message-ID: <1747950086-1246773-8-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: a93f55b4-6322-45e7-19b0-08dd9979a2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B3EqtUyNWw9UrvULn/FYmLnk3yzJ8eqTmAHOD3dm4hFcu90KepqLclLhyqxz?=
 =?us-ascii?Q?9amXoKzVsEiQfVlXECYg5wEjl4rN65k4/JX104u1GFloiWKrreNOALXYilg/?=
 =?us-ascii?Q?4CDxJyhoiPbM/0hcyHYtU/6qNtstMwUMTJ3Xb05lMfN3ZbNlRaFVdkKF9kRM?=
 =?us-ascii?Q?XSSHphzmV4FhlTYmqmgDCcfICzV4VFC2QUVTBnCeidvNBwqoY9+okGfGLPrM?=
 =?us-ascii?Q?OHKu/ucWIyo1uMyLbgBeg97CA0GK/fHy4xXMe+igiknrBVPZW5BVOiozsKiq?=
 =?us-ascii?Q?VDypz/OdyRKBxR80TAqI+iS2b+8QfHSqPkSMIE7ND040sk7qJaoBsINjTi6w?=
 =?us-ascii?Q?ng66W+oux8PsV0wmEva8VtoxEqH5ckuA2wO+5g9oy7iZFnBjN9IifjreHe6k?=
 =?us-ascii?Q?FysVv2CoXTIXJ4hpxdx2gSA2kOt1mSLljH8a8mbC0ojCuyY5tH/0VKCsQ54p?=
 =?us-ascii?Q?vQtWFd40ZC2ClSk8bCRKTh/q1Eeq0VgAXiRSyNUHDUXmYrQyXST9eAXK6uTE?=
 =?us-ascii?Q?r088lKYZW4+O+RGtP4wFvT+uoTa2AQ6OXdIbH4X9aKiIgrylWt8B3tD9iz7J?=
 =?us-ascii?Q?2mEIVu6JDbDDqtCMXtIfn9RqpvWCUiyzLr0XIum+kV6y50c/nXh/LqDv45Nt?=
 =?us-ascii?Q?bmmwVzmADvxg12L2oB2enfgN7qlG7vP0F/albgIBOyqV0Njo2S9ttsI9nxho?=
 =?us-ascii?Q?ilEYZ1gygjcLIgeFzutRowAgpfCM+65FS4b1kz4vLp3P7nbttoqq4JVEtCBB?=
 =?us-ascii?Q?cwlS16QkaXG5P6fzMuAvzndkcJVuP3IV8jbJrvPe75B1teT+bca+qfMr6sFr?=
 =?us-ascii?Q?cqtq6jM4KKeoUrmeE47kujkl9xL8iAsCzdQL//2261LF9dp41IC2512RBm9o?=
 =?us-ascii?Q?zUPVEDi7zwBaqtwD1GmJIa5iKK3U9JpE8HgZ+xN2Kmef8zzTM1rb4R+eis/5?=
 =?us-ascii?Q?oJYaUhPUtCiGLtFoyu5QgbQ7Vyt3FJCpfUmJlncFzw1b3OeJpVqmZ60yGvKu?=
 =?us-ascii?Q?0GpDfD1A0aECYInSZLPMyzS95+3dExoNPuTtUr7QIqZAG27qrJOJJJDeNgIg?=
 =?us-ascii?Q?DuHHPTevDizZyLr4sICfBtti0q85ZpzmIOEUO/ooUt28BQDNZn0ZIzGujUHn?=
 =?us-ascii?Q?D0o3Q0dgPrKlUWHIVfWzGBdAX0ta6mDJNKUWoaqwNtual5Tby56QSLBtA1Jo?=
 =?us-ascii?Q?CZGcCQQkCWdp20HvJ8JGWRJuhXVPbIcZHPjreVjYrNEXkAuUkR/+UNs9frBH?=
 =?us-ascii?Q?L5qPb/Z8VHODw4dD2gOZaY48IcfLhYsWMCMla5E7IKC+5pkZloa5oz7z/tdj?=
 =?us-ascii?Q?8c4jii/7p74FtsvwrKHcrV1/y232Rd71o39ns72nCslFv08acJscT0E/m54z?=
 =?us-ascii?Q?m4mOIerjgXLtOxRVf9+KhdR7jan13kvTJUm/saPakz8KSljrce1etSr01xri?=
 =?us-ascii?Q?AZ20EcGISS2iTYXcSLAPUaB8PSCg9WRdVQCy6jWo55JemQqK22dHADu122BR?=
 =?us-ascii?Q?p+NOYsEFnLF7rMxocBh+OqtP2c9gB6vEC1Kw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:43:05.6881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93f55b4-6322-45e7-19b0-08dd9979a2d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342

From: Saeed Mahameed <saeedm@nvidia.com>

Expose the stats of the new headers page pool.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 53 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    | 24 +++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 19664fa7f217..dcfe86d6dc83 100644
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
@@ -511,6 +535,23 @@ static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
 	rq_stats->pp_recycle_ring = stats.recycle_stats.ring;
 	rq_stats->pp_recycle_ring_full = stats.recycle_stats.ring_full;
 	rq_stats->pp_recycle_released_ref = stats.recycle_stats.released_refcnt;
+
+	pool = c->rq.hd_page_pool;
+	if (!pool || !page_pool_get_stats(pool, &stats))
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
@@ -2130,6 +2171,18 @@ static const struct counter_desc rq_stats_desc[] = {
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
2.31.1


