Return-Path: <bpf+bounces-60725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C95ADB36E
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61A316F9DD
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAB92820A7;
	Mon, 16 Jun 2025 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jNHyOstE"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0FC280023;
	Mon, 16 Jun 2025 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083377; cv=fail; b=O2C/e9+sPwk/+EllcvhjmU5XTvJPkA4U+FV0/9qBuo9SCaEtIJgl1yjKkxBiy3cDeg8Dn7MVDETHeJDdTxyXOCLnOmAYtVm8fTeUnu1xXXXixDWAsesGyMtVjd1Zl2V539rac0e25CfoiN5YAx55xlWaKpKs5G5krz/uMZdeLQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083377; c=relaxed/simple;
	bh=v/5hYEvABqD3wtOGv4j5we30H/IpXCScHgL1Y82Mi1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DO7340xHFa715KlcxgWz0gfyy5Q9qIKZhscmG8r7A/iCpTS5deA/vqFFZtz4VHuj7Gfhac7x1P7jo9bRdTWxpuYpMNXGl9kO/nMEhhm85krHt0hNVF/Eu5lIMPH7bF/g4CWnccRtF/7lFGyi+3dHkXrKh/6aK4yQVMxGc1waqSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jNHyOstE; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hc+1IGOauDUh6MXy5I+DKbZf7KTRsxQBBe1xYdXMiB81/3ged9jHvAGcm14syCAzIK0zFZzdcMH6543inoJTA3dY+jamrnAiT85EeGki8VhN3ZJq4tAg4U+H4Yv8RVFOEanmKbZJOfJjVRHgyHy+Zo5HNMoT6pAkWeLE2ZS5CHuhkegdrUkReZjwIs9OgwS4sczQvbJ4otfG3jodY4h0tgx4grRwDGro4H2CgeeqyYkMT8z5qppJLn40J23ql/E4S0+6g4B+lEjgFj3699I6AF4PBzNg3c7LInQaA9D0izVFGq40hiprIibYuwyCdofNV2D3zqEMMWfcHffX+hRs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDcXD133STGLLBQJAZk5dcrajsAm+ih5Ccq3EiaEKkU=;
 b=MDNa7BLRbeEI9AjPkfE5VckwobyJ087lCsJ+uzswSDvGXJtQnDXMaby1pQ2XhylpJiOc08L8zZRXm9uFi+wf4C9JHoKOO2Qn5Ytb4GY1CDhFc2emRHYpbbicBI1oj4iSa9SV3zVz4RQyfPHs5vT+dkyC2S8aubZAHsR71juBVcgUAvL0SijMsQekb2h2XgK7yXDQkBSDJty9oC2dSPrHrV7ky521mg1wywBjpwUmRRj8pjX7JTjYo6FnzIuUiz864nhtZGv6YziNEcTnQOOxHGLVXSlutHYat6Y57E2EfZQ1zlTTGzAq93G1AM4hZNRbviBAVCTIM0ZQoOWDsfyy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDcXD133STGLLBQJAZk5dcrajsAm+ih5Ccq3EiaEKkU=;
 b=jNHyOstEacey46BMH3E/w4Cht5SZcqSW+HT6wFPVNDpORU8qb9uvucidDha89W6L5X2HeI8fYK9evkSuMK9h8JM3telB8or6yKIXH8wwqUANzp5ZeXdmBW/vjuEOtFH90a717I6eGBEGuqUDC4rAmf+zC5kimZO4H92t74CjYQO1IwlXDxkaKwD0NTldl1Y+aoKguuCwoO0bNQCV6kx1sQMcyByw4VmICWono9HDMd9rOd9QhwGS6w6FZR7z70eJHVO1Y4s9aO/IyVAADX+IB4rlv9atiWc6TNeIxpku0KUkDGfL6Tt83u3NTGsVl6xUhjBgeKjL1SytNHfeKvcW9g==
Received: from CH2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:610:54::37)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 14:16:13 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::ad) by CH2PR11CA0027.outlook.office365.com
 (2603:10b6:610:54::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Mon,
 16 Jun 2025 14:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:16:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:15:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:15:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:15:53 -0700
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
	<dtatulea@nvidia.com>, Mina Almasry <almasrymina@google.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v6 09/12] net/mlx5e: Add support for UNREADABLE netmem page pools
Date: Mon, 16 Jun 2025 17:14:38 +0300
Message-ID: <20250616141441.1243044-10-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 5104a963-4a67-4087-e290-08ddace0596b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FXwsBTPiChs5jdAfiVwXLy63qNhK94f2jmsMYg7JNbqwIsGDfY+uABYdHc7K?=
 =?us-ascii?Q?9XBu6UkSRz9YSYpBTuIezgJ1RZuvK+gPwZKs+muHIe+GYB4SsiWl/7qlJolx?=
 =?us-ascii?Q?zDZ5xy9T197MJOcjAFEM9pMSkk7iT/SDVd+WkWi4s5dQ3XuRryW8E+yuqDiz?=
 =?us-ascii?Q?JPQhY9fU85tPnyagLBCqumDTrqaLjZONtjp+7DqqIK0qP4+VUt1XvY5PVR9y?=
 =?us-ascii?Q?SpxoLiQDb5FFZJ8CMxruXrlBOw9Ij6llbLLWffZ6fzWc9/jxlynbZjWvMB4F?=
 =?us-ascii?Q?vCHJJI+DGWS+KaMpRqo7uD5iOTE0WmYGlXbpNejSH6p4s4S3bmfjO9a0AxIP?=
 =?us-ascii?Q?eE6PdZ0bq/LTX5yn3hlOcrqUJYAcFAY1ClFk4bOcuOX+8OIXpVy6h6AWqoL+?=
 =?us-ascii?Q?o486k64ApM+wEFAzkEHdYrJvY5F8gASQWZQksior4WmQVsQMXxg/xsmLmmkB?=
 =?us-ascii?Q?GA2gOzlOBowOgJIET1LCeQ8uiwbn+Jk6flaGkDwEFJpaQEvPxkLGCztghXiD?=
 =?us-ascii?Q?7SDsm2r/tmifK3TsVlUewEjvtqG61lUsUdRlBKMFXtW0Kx3rFksxNDsACx4L?=
 =?us-ascii?Q?L4OtrM9wNkDg5eQQKzzemIx+FMcfAuM09Kf2kqajAEOmfOqTBRATtdV2f3j9?=
 =?us-ascii?Q?LcPJwvrlJdXOl/uiR7+abLCh2RCpTaHB55VVbQdYQ8F0oO70k+sESyjaqvjL?=
 =?us-ascii?Q?gOqiIyYAzvmIKJ6l3dOdNFE6cMRX3wjWAYwbbTolIXRhNTnt/IlblHUKryik?=
 =?us-ascii?Q?4zUvqOCzAIzs48d62Ch4clew60jjrMm5BXbTmGCk3ZU5PIFsOyyG+cghXoV5?=
 =?us-ascii?Q?GNxCdns7w3VdUi5bssrHdEFSgcETbr8ukwjZghUZf5YW2SaKZi+44zaw3khh?=
 =?us-ascii?Q?1e4Rmm6vk8Y1XDcpu/9oXpCtgnS0VKw+VaFeXdCjRUAABglvFlPt16IWGriB?=
 =?us-ascii?Q?Mch1zYpILv6vaQiKJMskZTJsNCAGcUX0Y+2LSaWcBXAj6D/GOrEAi0zZUpgI?=
 =?us-ascii?Q?BNses/d4hB94RZXHvGpu3qCJtWYmmg4puoGh2AhFgprTyuyH+S7enOQK2H/W?=
 =?us-ascii?Q?wfK8BaGi3jpvw8kEQwUkL8QyUiO8YrqMjXocQnDP3vh2JGhwuks6gKHRni5X?=
 =?us-ascii?Q?9m71wYybM0Hn69sDkpJIRNDO3jKfHrkoCowZTmCTzSHJ/oCdmF9Ug+W4TLdp?=
 =?us-ascii?Q?PeWYEtWjqIkIcDr2O6jW2rG0aWj/hZEpm7L8oTFlNB8vAOnQ6+Tzt0OR9Fgh?=
 =?us-ascii?Q?pFq6gAVUlWOtODsydzi+DQeKCAXqtlFe/gzUKjiCOhmcmz56u6OYcr0BXnsR?=
 =?us-ascii?Q?/gtB008i5ea1lCbSo5JicRj43sAYmOwIggonbZrm89QbPX2Ecq88fIyyZ81o?=
 =?us-ascii?Q?oN3iAP9Zx0IB+KhjKiwciQoxN2zmZ4vSnzMHR/MWKWbcagkf4g/7Yi7aWqlv?=
 =?us-ascii?Q?DHCXWaxwDg8IdnjfpFhtVgloD97Hl3invPthZ2q+2rwLBlJQ4KNHEQzrTCR5?=
 =?us-ascii?Q?WXo/H7gUtsk1h/9iMl53pN0pKK84e7PNNnlQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:16:12.7981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5104a963-4a67-4087-e290-08ddace0596b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908

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


