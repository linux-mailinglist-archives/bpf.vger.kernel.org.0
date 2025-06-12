Return-Path: <bpf+bounces-60481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9176AD7728
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1C01894751
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768AF2D1930;
	Thu, 12 Jun 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c7XEc1gj"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86E29A9E4;
	Thu, 12 Jun 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743307; cv=fail; b=t+YgZzbMZXZCgk/MJ4y3XqLQpkw2i+xybRidsuaBEDYXDt9F3n9IBjG7rHp3jBvymASmjAldVX83JTcwbLsT6I6jluyu3v10WSv6DfQLxY4l7kfDuTTpAos32VAqZgqIt9U0xINE6i3gNk4ePSXpK9sPmrkKDr2+cOAzo4e8c2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743307; c=relaxed/simple;
	bh=v/5hYEvABqD3wtOGv4j5we30H/IpXCScHgL1Y82Mi1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G58bN7BECVPIGCJ+PWfHDVow911POoUvIiCMX8KAOqIQe/4w/489gQ24m4Me5DZ7YgBllsO0+nT/ZIy3WFSB0og2ypz4xQL0p8FbFuowcgW3bhjlcMbN4iiDm6wS+dlZJIZjBksqtHo0s75kbzKKqYHz0oS0ukGcf256wmsqDPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c7XEc1gj; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ot1k09MDWo+pUvxsQ4CqrYg6rmetdfbTSwqcn78qUDwEgsITiTwNFEwE+cwho7JXa+7iFblfv9ebHECHHC6oONNKxfd7jP1hBQjo1ZVh8/IouPIlwE3EhV9ewAEROlL68XTAFsb1hCjCgYV64/j70KOlxaQev2akeqhstVSRoG6zHSO6LfgYK4Y8QbzgYLZYL5AyMh4wAQLgC6M+UObDQwFarrTZOgkwd+sHwgpTQexDltlPCYAMZePQNdQif8cUjAGwVYScwAVuCzIYed3f7oRfZahcOCF4v2GZccCCL7GCFIF0tzC0wWdtmuiweYQ+Yifmz06EV67xMAzW4YRCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDcXD133STGLLBQJAZk5dcrajsAm+ih5Ccq3EiaEKkU=;
 b=r9xSb3hnwSeqGLuD5cYQQNlLZwmA3LMsdODzfhek6npOxyULXcEPqEhi61vNr4k4ozFY7jp0m9vwYMHgyrM7iNYTqhwyV/qRWxHFpygVaHhqkAZfp1OTWnRCCmV9RCaABKNhsNnKHc9MGlf1i4Fak4Ue5RXH+hhBXmpLxzoooF0xG02MKNGcXGpgBnYZCW06mQV1xgllhifH/61PHdiG3WkzMGGtck2u2qFIbfJpOSAVpe3SBEi9fe2W0AYqLBBvn83TWvc/UoU2TMeiBABjNNIlnPtoY3iOmWKPN6TH2cwdazAyNes5aRq52ppmBqMbLl2J9FcEuUN/g+daZSHwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDcXD133STGLLBQJAZk5dcrajsAm+ih5Ccq3EiaEKkU=;
 b=c7XEc1gjlamx6fYXi8bEeeRi8Wy1ZwDh8WzDi8gFJnsjWXQ+imtU+6ZGo0mKeNmHMznfKcsCKwF8IkPhDLQAIENj+3xRK96EmPRNgdGttNNb7InssRfKPMmfz9hCEkw586KLGAosvyB+kJkKmdhVO07S5tBSlk0w3yTpi6ZylchSLW8M8Qr024E8IA1Sl6RAUAs977RbgEO8bDVqSTGQDYKPvS5WO6g4imZno8guqSMT0PehKGfXODX6tM+flyX6jmurX0QwGGaGAbh7FctXYdzbtrWHOfF7QhlvYVcxzFMGYG7FO2SvPHLdRUQvn7Om5DlwJ6K7I4ahUYAKqlogUA==
Received: from CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::26)
 by DS7PR12MB9504.namprd12.prod.outlook.com (2603:10b6:8:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 15:48:20 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::86) by CH0P221CA0042.outlook.office365.com
 (2603:10b6:610:11d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 15:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:48:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 08:48:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 08:48:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 12
 Jun 2025 08:47:56 -0700
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
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Mina Almasry
	<almasrymina@google.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v5 09/12] net/mlx5e: Add support for UNREADABLE netmem page pools
Date: Thu, 12 Jun 2025 18:46:45 +0300
Message-ID: <20250612154648.1161201-10-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DS7PR12MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 551f40a4-e012-4df6-808d-08dda9c88e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S5BqKVU8uyjqhBzR7aYpur5QIljpZwd409iStopOgBKmY8cZ15OA/S0LDEpx?=
 =?us-ascii?Q?WJfRxDeHDGRoHIgGXMf079eh2bEypWlQqTcPkBW5YHw/RpkGERPSq+p5fcJG?=
 =?us-ascii?Q?54DxHD6Lv7pn2tieIujS15g4BLUXjtPlvRs8FkMI+5IUwUKy5aVRNz03eK+O?=
 =?us-ascii?Q?63vx/CTsi+qs+BTWYc4eaDAX1ibBB+TfbI13mpQYXxKmGAVOW2vE0HP4Xdp2?=
 =?us-ascii?Q?DqyfVPSPDx1vDvW3bHyGxYm8r+T8DL1B+t28Oh/Fu1ERfKNmqTu5ItCF+Eb3?=
 =?us-ascii?Q?ztRR9NoZ570r4XisaqTDAdBrXDh308pYTVet/QL+C9qbTVWEJDanY2evOqJw?=
 =?us-ascii?Q?2VybM7wQwnFBLCW1GEgfSE+coDIOt9Cx1Cyo7l7AG70wC7wRQN5dBx3ocM1D?=
 =?us-ascii?Q?FzfOvw1dUvFzM7oiqnq5WKtwrvemQh+TPPld36yp03q7B179pA0FjttktTOg?=
 =?us-ascii?Q?1lQU8gXsfAU8eb7DkJIKgMhra+1p7igElUzuU9tSaAjEymxglqskDPh082D8?=
 =?us-ascii?Q?6PanT+p/HqZhzzhhAm6fZp1406tTPzRpdtvpDvTKMvjoTYVqKZ14dWCG045J?=
 =?us-ascii?Q?Vd4O+/X72q8/l2gSvi5gcTUgSWUn/jk+QnIl17NRlb3kATnhFYyCE1VQfAV3?=
 =?us-ascii?Q?iUysWCKKBZeESwjpcY2usq/L1yWm7W2xTaAX/hMlR7IXUoqw8B1nCKeAjV4c?=
 =?us-ascii?Q?yStgvD7fymFrkvbvxuAt2Jgg+hA/gYufyCfZ6DoVM9N9bag3kzx96WtTtntT?=
 =?us-ascii?Q?+n06VEbwnEcuef0tQiqfUYsgrufCLy4vZnFIjdhUurkpyLtojSiqRmT/vxfV?=
 =?us-ascii?Q?w+Ym6ZZjNJ+nL+bZjqCSBsN+4Sx0T9g68cXr98iZUMBB3iCIvivEgTSWVlw3?=
 =?us-ascii?Q?Vpv6i2184jUUep0oDvjrQBwygRkwMa88Y0FfBzwg1UMIoA4YozjHSihQFpVf?=
 =?us-ascii?Q?CiYLbW+dC06zBgZe1bKR4I3kN9Yk9YiVkF0fQUFzntU/xxxyQRZXCq7tG1ij?=
 =?us-ascii?Q?M9Wz60ZZqiMrqRjpRFaOaSBsNp2uphY30UlLjevEbjIIhNBat+sY0CoNO01L?=
 =?us-ascii?Q?1vYq1wO6RcjCPPwKI+jCAxGI1tKZCV/6SYg2KWVaGffDPOLK5kyn4XLDW5b+?=
 =?us-ascii?Q?7rhoXrdNjRhtyn+GyeRXUvHGxvH24q6CWTz4Vva1Vw1jCjP8/egEScOKimgD?=
 =?us-ascii?Q?nhdK7e8kHXuM8FzqrbHfDjnPk9XmpZWY00VBr24n1xa46Y94MuxtCNzhQh8R?=
 =?us-ascii?Q?jyvzRcIDi9ucZUCM4h8RRFpiV3xKF8zuSHzixGr5z5W9ziQgAni8TnD41ZYF?=
 =?us-ascii?Q?qggH6IT3YCVUuRRLbO6o/dVg2XfQOWn/io5Lu2AYjy3vHITMBr3WzrlMfCom?=
 =?us-ascii?Q?4Xs2KB6i4LWfUN+NFki/i03OL9HnAWZlXrmfHYLfC8LvBhQQrthBT+vkIJn4?=
 =?us-ascii?Q?tLwwTYAmek8scTs+5veAFdVfESCCP9CfexsvwEkpCrINhdaQY78Py5qY0S8Q?=
 =?us-ascii?Q?1N0/rYnbnRTMNqbNfWx5G0BVj7MMYJwHZGU7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:48:19.7053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551f40a4-e012-4df6-808d-08dda9c88e0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9504

From: Saeed Mahameed <saeedm@nvidia.com>

On netdev_rx_queue_restart, a special type of page pool maybe expected.

In this patch declare support for UNREADABLE netmem iov pages in the
pool params only when header data split shampo RQ mode is enabled, also
set the queue index in the page pool params struct.

Shampo mode requirement: Without header split rx needs to peek at the data,
we can't do UNREADABLE_NETMEM.

The patch also enables the use of a separate page pool for headers when
a memory provider is installed for the queue, otherwise the same common
page pool continues to be used.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5e649705e35f..a51e204bd364 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -749,7 +749,9 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
 
 static bool mlx5_rq_needs_separate_hd_pool(struct mlx5e_rq *rq)
 {
-	return false;
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(rq->netdev, rq->ix);
+
+	return !!rxq->mp_params.mp_ops;
 }
 
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
@@ -964,6 +966,11 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		pp_params.netdev    = rq->netdev;
 		pp_params.dma_dir   = rq->buff.map_dir;
 		pp_params.max_len   = PAGE_SIZE;
+		pp_params.queue_idx = rq->ix;
+
+		/* Shampo header data split allow for unreadable netmem */
+		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
+			pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 
 		/* page_pool can be used even when there is no rq->xdp_prog,
 		 * given page_pool does not handle DMA mapping there is no
-- 
2.34.1


