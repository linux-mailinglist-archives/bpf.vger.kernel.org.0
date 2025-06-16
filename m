Return-Path: <bpf+bounces-60728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC2FADB395
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47E87A962B
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4162857C9;
	Mon, 16 Jun 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gUJlA+dk"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3317A2FA;
	Mon, 16 Jun 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083398; cv=fail; b=ToHnCxOD1iKetQk7VMHfB/lq84S4lF2HBhTU+Pfp+H6yhb+zZmt38avuaQR/MSnfEECZEMqgLZ1c0O7xfuV/Momko4nwqhKIDcK1khr+ojFgA1mO36bLna3vnaY41Lk2VuBRluhkujWMa9V7jqs4XrFKAP5wQrIe6RJ6077VEgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083398; c=relaxed/simple;
	bh=NRNIwdtX0mxErnQIT/tmosLeBDWShrgDNz5WJCaiAAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2NZ1BKartg/f8aMSruNKrqQL2B28GXbudgSVG75QEzHlLUJ66E6sM9Rluxmo/WFBXEBHD0rSTTaIuGD9bzgcBz8NeY9RhnIooYIGLhGv/4R0JBYt9p/VLfStgsJSYAIK2ZR1BZnJEuoTI8A9X3Jw1WYxfobq4GUvBTx5USvwqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gUJlA+dk; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYV6FrNEEtWaY9ZCGv427blQHTZQJIwJDfmbOzkh5jvB2azyPRPGEnXE7mExU/i6Plkw+Pq5aMq/MOlPSOiwlrpBxXd8eGuJoZTn+nyHCtvyRf36uSVbNz1cIGYihq8mVraVa1tHBgJkPQdDbt4T9cgICKUwAwT6LFuowRbdeLiLXPCxIozyq6+/lI+h2QPjJn0EIEnY3gQ0FLNqbnAmXozn8Q9iKbxb3BXhFGeazQu3EI/vKVmKjF8rVuta8+v/+zk2/PYV7C8IgQlRaL72IouQxm5ZtimhS+eL+w9DrltQ/H52+AMQqgBot0CfhnC7MeYBUE6GDjAFT8iqvIt+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmkB3/PEgvL2PBTLIqqFkB6YldetutnkLe8oZE10M9U=;
 b=GCtL0K4gxVfa81GL0BWcMIl02xX2KoSWaSjJmLIi8knA8iI+PecaRP10y1nQuG3TqJ1Q9AAjk7kLYZFgX8l73EKFVINvgAXy8mXFRdp2MhqBSjHs/x58Fpv/2fb44NLckcEiDUg8rvmrtqWhj6CElMdqSRtgGOPepymPHbqSuAbPEgNjwj4ixPVqnrfm4xAeCaIXPVgn+wSA1lW875Ee0qpt0+Oe49kQEaY56wy2TUnplGDqoNamvoKZNJPtt0EkeG+jztHw5jyKv9HEXznB8+l0wVnmrRlfNIpwGoiagSeLQ0sV9VALTgfv6ovdfacMPiYf0dhouFyqWjUukBMuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmkB3/PEgvL2PBTLIqqFkB6YldetutnkLe8oZE10M9U=;
 b=gUJlA+dk1vm2bC054KlvfkpDK3sNCPyJ2SYweAg60+U0VkQIIksN+Z14CHKk4exm968OamBbaRJADdCUFHhNd769WoKqtFKuZYjIP20F28CF500m1hfyEO9Dd0HcWkSqDxXltiJp4wIXmMFbcRiVqnDJosSDvx48kfmqGbyjzUt+R7bPeQoAEbn0psEJwdj2CoekHx4QcHPHwLix8gH05552CpwAfScAicArgiRsGiwnRGD1wogiB+3n7XoKq5mdCV3uk/vE3NIyN5Q3k4iu6/AkDMIP/v0w4ZY1zRROH2qC4jE+qQGIPL999UJ7xP1B9jcPjK+OyFEGacrO7F5zxg==
Received: from CH2PR11CA0003.namprd11.prod.outlook.com (2603:10b6:610:54::13)
 by DS4PR12MB9747.namprd12.prod.outlook.com (2603:10b6:8:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 14:16:33 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::32) by CH2PR11CA0003.outlook.office365.com
 (2603:10b6:610:54::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 14:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:16:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:16:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:16:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:16:13 -0700
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
Subject: [PATCH net-next v6 12/12] net/mlx5e: Add TX support for netmems
Date: Mon, 16 Jun 2025 17:14:41 +0300
Message-ID: <20250616141441.1243044-13-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DS4PR12MB9747:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea35797-476e-45fd-d7b8-08ddace06588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqJjo/0xgkneHVF6c7GOatwakpaLtVaYe5b7y7msxVI0yV3wk1zUBbxR/Qum?=
 =?us-ascii?Q?U9dnNlzHTqIPHfa4lj9WqhNxvHGqsBIWI7gIU2ixrphALMV4Z4W6PUZbaSDF?=
 =?us-ascii?Q?Zo4HrH9jPLwk9XCU7xjCdu7dRdVf5640tIdQlXxO6vXSdmktBkjCl7GluEz5?=
 =?us-ascii?Q?ia7TQinb7FDw5yqadLbqMAJo/CwGU+EMGpr1RDaZiXPbvuUCzXk7i+nBTFsd?=
 =?us-ascii?Q?8wCqWoQ+BtOywpwkuNDHQQrPP8boJRhldRq0eCf4+u+ShbSz8O96MALQ4dxJ?=
 =?us-ascii?Q?v7hzBzmF7b4VOEVKwjRJnhiv6F8q7i9J3GjwMR/liT8kYdpa24MrSbymYDtH?=
 =?us-ascii?Q?jkJrz61ZZkOkeB6FcKPszZBvJEavE+yQMdTCEPO6jvuoxwHqL0/OfhSlVnK1?=
 =?us-ascii?Q?2NZRnzNRO36VqkjXXMkdvpNTMgF2RXjv1KPa1VohXZkFdb9MQRcR+8t72Ten?=
 =?us-ascii?Q?teJVIm8oqz3o3wjehVZKdlDHq1Qo84Adrr9l5Qdjr+jf02x9MtoNtj1Dwf4x?=
 =?us-ascii?Q?Go9zB9s9on/hUFZC0Y9Sq+i1PdbnMAK3pFDUK9jPgbNhHgg0B6+J0NaqZ/ie?=
 =?us-ascii?Q?eGki4k+tf2zqsPzwVRgmx62ALZHWJiWIrk1MihEl9G1DTuNPVHidPwBbBMsC?=
 =?us-ascii?Q?cAkQp6nW1d4/wdExCb6/XzRZ8565urcQOjQJFlEfToNIc0cZe+jJxLkgDwEu?=
 =?us-ascii?Q?ZCWmwadlxM85ekwOf6yu3YnZGBoX5DwZ+yaj/bffFWS4smGO2ItN3DRigb1n?=
 =?us-ascii?Q?FemHYmcG9W0Zb7TxZoRelWpP0VmeFuFt0YBDwN9AmaNf7LzgiuaPYG8TXNb2?=
 =?us-ascii?Q?LRBc5KS9cLc78ishZ2VD8qxcot0/awcszOwlyew2I/sogsRIqAQBeI9cP/4J?=
 =?us-ascii?Q?XVwRY6Vt4H3g4sMwnvPnL/w/S0EeRXr5ToYuMuw1r+Z46ztA+ef/3hZ0GEat?=
 =?us-ascii?Q?XUo87Qxp/jTXEbv9keYbzFuRNwe7vuaE6FDPcSukVh8Vo7iIJlth9nfvF4pb?=
 =?us-ascii?Q?MgpC8WCg0rF1cZoKhw7lNkNszT8HBsgKNoSNzA1eOguuqj4vMJ45HS1lRTKM?=
 =?us-ascii?Q?WDxoHYsMMHYTiOczjIK0+jXcn2AISehfXK1mkGXB1MUfFgYxLiKt5GjX5A50?=
 =?us-ascii?Q?HI9n/IXyF5rxbCGHbaOXIkj+oV+PqieJET7auMN0kdnxABIqAftvNveMdsYn?=
 =?us-ascii?Q?CzObIL5/8+gVBWqnNFgNK5ry+LYjCjgCXpKMbDqCI/JaRPzoicyF6RapsQmL?=
 =?us-ascii?Q?9sjsVA+WTeGf0owJ/fo2+Stuyuuy08Evl7p4Tw/HQU133UP8XfSpok7KcD8b?=
 =?us-ascii?Q?oZa1VKdp3GOPZzEBugl7TLAUc3A/TxMBHs1p9AfQPblnp2KtCcLLN0ENyddV?=
 =?us-ascii?Q?I0vNjX7tqVF/fOiv7MW7dPsU2jWDnS01SoT/rM36qXzD2S4/0tv2gjha8Stl?=
 =?us-ascii?Q?KIKeZbQJEJ7olVsrfwOLdZPgUPABFQBWZ96YLwP1tXyPXxNW8j/GxR/GqMKl?=
 =?us-ascii?Q?NUkPcvFSkkW+hOyDcduMvmEduLGl/3VWiYCJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:16:33.0850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea35797-476e-45fd-d7b8-08ddace06588
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9747

From: Dragos Tatulea <dtatulea@nvidia.com>

Declare netmem TX support in netdev.

As required, use the netmem aware dma unmapping APIs
for unmapping netmems in tx completion path.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
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
index b4df62b58292..24559cbcbfc2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5741,6 +5741,8 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->priv_flags       |= IFF_UNICAST_FLT;
 
+	netdev->netmem_tx = true;
+
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
 	mlx5e_set_xdp_feature(netdev);
 	mlx5e_set_netdev_dev_addr(netdev);
-- 
2.34.1


