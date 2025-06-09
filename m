Return-Path: <bpf+bounces-60065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B7AD21DE
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED2A3B274D
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70080223DCE;
	Mon,  9 Jun 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZVvfLNOy"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75000223702;
	Mon,  9 Jun 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481238; cv=fail; b=GtxBGBnnLVVmJe1n07LP+XcpygQtvfJ+RPUDtQq5jKH4L/99z745RXkYX32cMGGbN9Ld+xO620NAEXpJIG0vvyTuNJFJ9N+qXJJ5JyfxEL73mc4BmsH+bFoCYmNSbj+jsr2Nra7cxFqBEiOTqzn9Eeb4LwsUq1cvVQhwlo3yTo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481238; c=relaxed/simple;
	bh=800E/gChn2LbRF+wMGwgHb7zNZE9elNQ30Lyaq/OI1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbY0JMXHnJLDqcmd9r+k2aiqaNx3RhzTt/7+ByCLnbYdSRWpW3mLICJvgbzChqXL/AjUulBN3fMKLHE8eJ/UtXRcmR0Gh7TgZ66ptCluVEBzuWaIR3gwaUDQ/A/w/kEEiXYeqQbQjkLUmhiv6naW6IWQscqjkcPtrNpAcTJRFQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZVvfLNOy; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EilMfarlN6yPP3XbbJvjebfHu/GRchCAEQw5/nKFH3RKvsnU+0o+Ffvqlyw4bjz91D+D5zjNpi4ChPJGJZFqePBjRaK66wBgeGYTrZrxQiy41nF4xFN9vgAgz0j1FQZSN3sxCkUBS5gWKkWATcP1ek5jNlTG9gbEdPPwR8SuPOqU7SZ2T8f2WP8ZA5Y72GSceuFjQM3uavYXUzDoiPuFalNJ2MTZ2vrLGT4XKBtsgXz/k0Ja6XZZs06wiXOgxDKfpkRXJKwzSQmRPVRbd814EBdKctVs0A1/7albRFcKxieXMs3RLZRqkM3MfI7J/D5VxseQyAM+kielh55zBVPlKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp4OXnxJCwnQ0BwA1z4VvmBiw+0bjL2e+Zv6ncvy3Zk=;
 b=RFbybWJmOT7DHdEnHDQCsPyWPdPZroOFWeAFBewPVa+Ae/sMVz2lis5YEMecZ5Bd+zOafZARgKSJwL/mxb/98lSQDyEShhpkOM6VzqwwOjEZ4tvdB+oKHHFCSOEtC/tAirPgx1rCD/IfYjnxMFt7++XF2PsS1hJTTOcSXuBfRn6+VObTxAR4huhK6HW4zixtodl1EreQJfIjhqbnZru0svZ4PBS3/LVeA2N/ObmUG7qWpRJb4Kx98N2y7TjB7GHnMRPQauOUe10JNtTpTak4EZU21xr1hMqgm5Jcr82nDN18Tci3FMuKZ/zWR+IvVaSAPSQhpMCMFX+2ondGN4SAkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp4OXnxJCwnQ0BwA1z4VvmBiw+0bjL2e+Zv6ncvy3Zk=;
 b=ZVvfLNOyfWCetGObsnNaCK6Y3/PRfOFREJDFFzU1MXjhPXKjl8/EhIZXHIhLTs0FK3VeqfG9Bbqj9PAseRjoL4RLV+xe3GfrBGZZExN5mF4EuKiCF3WEhXEKQ9huZdB4LsSu2B9f9cIew2NDDH9dMrb5mk0Ej2sisowd3oltAVJuC0QytT21Qk43lzLhfTnauzK3HeizbK96hSyXtgwCrMke8QxlRGqx6TH6REFvRk6wX3bM/2luqWVp8ZNjReTq944PdPBqGXeKnvvZ1S4wL949wkiHnQ/BAfzAjsX13N800Sq5D6XJzJM5Q36uL+SHe5BzBzZuvf7HaRc/qDp9tg==
Received: from BN9PR03CA0114.namprd03.prod.outlook.com (2603:10b6:408:fd::29)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 15:00:31 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::35) by BN9PR03CA0114.outlook.office365.com
 (2603:10b6:408:fd::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Mon,
 9 Jun 2025 15:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 15:00:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 08:00:08 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 08:00:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 08:00:02 -0700
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
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v3 12/12] net/mlx5e: Add TX support for netmems
Date: Mon, 9 Jun 2025 17:58:33 +0300
Message-ID: <20250609145833.990793-13-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 343478b3-9961-4ce2-299e-08dda76660cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cbMg/jOlADBlxvlM34hm+HK9sB9VFXbydyzOZmoI2od+hMRjqAvdrUEnSI2o?=
 =?us-ascii?Q?eIcZHvIjpwJoRmzV5mB7jj36WbwY3xNO9Glcd6xoAqNH7S54PaEiPz5emF/S?=
 =?us-ascii?Q?nMIZ7O9CszJAcDMbGjb1U3OwfUj2ObpAXQX5B5fZlhhT8B/RUHokC0T3hB/o?=
 =?us-ascii?Q?JB2hV67aOiATG8OYC2tfoB5SOxy21W/bQyCmYFhrtiUgoMmVnSVD/qA+abfI?=
 =?us-ascii?Q?D2fO+erDb5qtSYagA8yn+m477j6EfD2KEIw5c2swVKhjOEKOCIbiJpxeCoch?=
 =?us-ascii?Q?MblxqyBRtLC1N5eJBi1XNvBGydXuslfOzLYkD5nF2/XVnYIX7E8Lf6C5gkht?=
 =?us-ascii?Q?l05hVHmt7decrGuuwJUIVTxqONctLiKkROwzvUa8TbpLMWpRaHXoN4H/F2W2?=
 =?us-ascii?Q?ym7+llCRDR8Pzy0GGWf55Iajlov1M74CqTIBBAmZikhYI2p6/3Ru3fNNOPiM?=
 =?us-ascii?Q?Zq+t9srWGAxCvUcw1+P1cxm6B9QAzNeWBFFA1hkL96014OuFRGsOouKkzA+s?=
 =?us-ascii?Q?U3Cz5CFBryKA5CRElcaqMD1F/UneEbev1Dj0MoY3NDMhgNU83j20irLSnbSD?=
 =?us-ascii?Q?SRMO/ubmSXda5cXIslHXf9XtgiXj31eAKYaLdK2FXDQOLKYLA6O0ngLhpdSv?=
 =?us-ascii?Q?yYCIpYoJjFpT7aaIaLBNnxmmcegxaa2gu2KsyeWF4xWz/HaSiIhT62EJq8wq?=
 =?us-ascii?Q?+iuuccsXIOy8qpQ6Ak4f4gtu0Uu3CDvCNPeQinqUSMI5i4vwAhqOyci2OC8S?=
 =?us-ascii?Q?2Y5fSIvfTvWK1gF6sQo18SnHwZ2o8UBAltA/2yjnssg9GdKwxmqS209vpSzO?=
 =?us-ascii?Q?bn1u+rHeZz/z4i6+QXAp96/aTer3xXRsacl9VPM6fRdWmT43VFH0hDmL2BEd?=
 =?us-ascii?Q?x2/aI19cDTJqlwCYmrNa2TBwA1qDc81mm4BUHl3QNg9/VGRmCJPYkMzJjmW3?=
 =?us-ascii?Q?aCHP7p9KQwN+c4RUQEkmbVQr3KigGZMGPOrlwsWgcvYQ3qofouck+AOiUMgL?=
 =?us-ascii?Q?J3DeDobPid7ZS+KxAVqVN1OCHAorPNsfM3BDYZUdUSJ2gLmv8IQ0pkQEBmAl?=
 =?us-ascii?Q?xXhJ3dYqCMRoOI2P9LNXQx2q3ikKlV1QHUD4WTbhrLgfQgS3cjQutxwm/oqp?=
 =?us-ascii?Q?0IWYAon4nloqw4VCHqid7ufDk0GHbHDhxdAX4hD1NX6xjetvN4harqOR4MQT?=
 =?us-ascii?Q?xCuBlNRlqEACYV1xW7BuNon5rIANxnjh/37x5S1vtPxk0XmN5Ea7vZbQyPkG?=
 =?us-ascii?Q?WpnPAYs1KyEILIWZlXA+InRIwKAkvOmAFwb9qIYFgrQJ0uSQbJhc2Pngdvw4?=
 =?us-ascii?Q?IfXNTVQMhXGaYUz7rVEedyewHr6Tcf4cADzlAZbueVJHOulZ7lt5q6FQQmGa?=
 =?us-ascii?Q?0+U9/zfqRc5v56rcp/Moe7NqJahK85F1iTifqPoCavmkPp/mPtKfIf/LRH3h?=
 =?us-ascii?Q?3UOqI+FDKxJVkTDM4EE9pzKy13NA6CcsUYZwtL3pJog8X0wckBiDfJBBQIYd?=
 =?us-ascii?Q?w/5U9dCTccECnDP96BJl82W7GBLJzTo1sG/W?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:00:30.7259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 343478b3-9961-4ce2-299e-08dda76660cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368

From: Dragos Tatulea <dtatulea@nvidia.com>

Declare netmem TX support in netdev.

As required, use the netmem aware dma unmapping APIs
for unmapping netmems in tx completion path.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index e837c21d3d21..6501252359b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -362,7 +362,8 @@ mlx5e_tx_dma_unmap(struct device *pdev, struct mlx5e_sq_dma *dma)
 		dma_unmap_single(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
 		break;
 	case MLX5E_DMA_MAP_PAGE:
-		dma_unmap_page(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
+		netmem_dma_unmap_page_attrs(pdev, dma->addr, dma->size,
+					    DMA_TO_DEVICE, 0);
 		break;
 	default:
 		WARN_ONCE(true, "mlx5e_tx_dma_unmap unknown DMA type!\n");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 026bd479c6dd..1f2973e82733 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5740,6 +5740,8 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->priv_flags       |= IFF_UNICAST_FLT;
 
+	netdev->netmem_tx = true;
+
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
 	mlx5e_set_xdp_feature(netdev);
 	mlx5e_set_netdev_dev_addr(netdev);
-- 
2.34.1


