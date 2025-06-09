Return-Path: <bpf+bounces-60057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151E0AD21B1
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6811216E655
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13F721B9FD;
	Mon,  9 Jun 2025 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p42wHwnC"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B483320AF98;
	Mon,  9 Jun 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481179; cv=fail; b=eOlOArIMzvRJKsqnkP6F2M5mAgt/sCv2soR48IOZyQd1VkXf5BK0EFEVxaFC1tk6zsofBnc6JeISMo4saXKvikTRkgrCzsh+CpTlwKizlUyZa0jdkUJCXo1ICin2mZaAbzo8ZVXcnHb8Yxqy9iAdItZi2hTEMI8gr6IG7SQO85k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481179; c=relaxed/simple;
	bh=Y2ui4bpyi2StrG03Rxz/C3o+qK4XzXlFkCTpwgp/vNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0HOM6KNA5vBuLNY6AMsLwACZkTpetaGNlPcA9nyISFSqSghoresnC1t6JKAREU/UjPQlB87iS5diSzx/wiHfJTREJU8nBUHL1fMpPB2xoVzo8dh/08X/Y+pM2CLXMLuS84TkUmb1Nah+3XK9XFP7f5F7Q0Onzw6IDECC6ZGMEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p42wHwnC; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kINzNQVUKfUQPtMQDM8wTQXxTgCbXE/8+Xbh/w1pecyowr7afNnSPwFygtldboG1SqaxZeGuVe4GiXLv98XPBS+E1NWBFoUtQiEbn3LnuOf8hCoRGsVX3tPsCAIdsZcowm/vN1MnlvmNefXEzLr3PYDZNruHLEQh6M50aRFRXWIFyuLmgoWflnJWOa3oQvsenTeOI5QvgbxlPZzIXpC5g4AnnCN0dT0DiMhWVXob01MmhScK0NLy03QA6x8xVaGmnUapDE96AN1vjbiZIvYzR8VyGNxPB+0jC8C8OSbrO5jpIo0lyy5k6LwFldsz6/XYlI3nQBqNKiPSGO3Z2g+bFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffOldQx4EhzLumaUO4DQI/K6c9IeBAfc4wzdVLLPS+U=;
 b=UqjZuL0MrIDu6dKDqeBE3aLVYhfKUmlI1V2x16MjO5u8G0r+VhDacWq3hTtV5vriy6xpZsJR17/KTv57X5S69cxg2Qn4H8xJ2BBriGz2+mB9TFHSRB5XYwcYgbH88SdzCJjooHAPRj4hCBB8FmlL88zQDxow6Y/QJXdlpABx+4EWyiq/2tEtGvFTVnua5ojeVOBhvH0XZhMffRbSYfF52+sgWdRSIGS9cl19Ce/cktXazD71TCZTkW2IgR+CJsyXog+99EiH3XyP89KHRTVufFAEel/nQGghewuCWXRtT+KR+sevhm6497IzrlFGyuFe4rjBthwbtrVScXOC6WPoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffOldQx4EhzLumaUO4DQI/K6c9IeBAfc4wzdVLLPS+U=;
 b=p42wHwnCWcqN1F4H+tOINMOq7U73but10o2EhFxd5JqI4uY4vz6uxMi3AX5sXYyOcHHOKw3EwImonm0oCb7v5+8j9mg7yPzkp45Yd5iXGBTKiki6crJB6gvavdt2TAQsUSO3FAHO25mnd3mzyyDVLtFDLG9zfGLCva1W9dNoeP8ar4wein9x+Egegm0rd2DP+gyrfJHlBh5NAArQe/PE9/uq0ODJMCUoP2IHcxn1oPttf+2DsAGexNz9hRwWoT2gqNpdGXpytuuQYdX1T7GYU7+KaOKABWOKzsct4/tDC/xEEsk/hWbnHjcmdIbvc846md3SKEcs3AprExOWZbVMXw==
Received: from MW4PR03CA0359.namprd03.prod.outlook.com (2603:10b6:303:dc::34)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Mon, 9 Jun
 2025 14:59:31 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:303:dc:cafe::e6) by MW4PR03CA0359.outlook.office365.com
 (2603:10b6:303:dc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Mon,
 9 Jun 2025 14:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 14:59:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:59:17 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:59:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 07:59:11 -0700
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
Subject: [PATCH net-next v3 05/12] net/mlx5e: SHAMPO: Improve hw gro capability checking
Date: Mon, 9 Jun 2025 17:58:26 +0300
Message-ID: <20250609145833.990793-6-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa04917-daf4-4fb0-b163-08dda7663d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?46ZJAWhjSJinOyCOW5AS8fuon0N9D3lE3TOv+EuGCL/KjJrKgVt0X5JOxW+M?=
 =?us-ascii?Q?yi+KF9MjN2CUpWgCQ2s58LncPAbuwjI4MDBs23UIl71HaXgC8ivlp86tx0iL?=
 =?us-ascii?Q?B+2l0NOc08WL7doeZHiq2sYHPSBnk57eRJ1iD8ZX7SpiERyUn8ExkUzs3wJP?=
 =?us-ascii?Q?CBs08SZzPRlUqm/kFx/aZGts96P0ME4SyrpGepIAAPlYtNIljp8RbAFbHR6r?=
 =?us-ascii?Q?HGezzZpJbU1JOljYxpUV4G4vbZ9pX4DBf5B5ePGhLc0JsyuYmFkVBUJu7wfS?=
 =?us-ascii?Q?dyXzvT28tiqOZpp8P9ZINEf3HTMqiH6f8oBaP+/DA0CmUXSa+uLX1wqiyOVe?=
 =?us-ascii?Q?kHb/QsSChV/ImR07dTyAuUxTdlkAF7jXyWq/lk81Vyo63KAV5nJRVDi+iuY7?=
 =?us-ascii?Q?S9LGsOVF1/LJ2vrCXM3CQSEEXjl9ukDKnzSfwVRn7XNTcERonlJB4R8v/OIJ?=
 =?us-ascii?Q?JpCyPfN1ULiVJ97fVRxoNZR+ooog8d6CZ+/EQWU88Xhfv6ZPMd3wkydsutSl?=
 =?us-ascii?Q?Iw5d6jaNtu3LCIL5KXGSomHh4gVkaTHK0JGd1fNgWIBaUzO056N6K3oJDkic?=
 =?us-ascii?Q?9HfVVTanmqAsSXbEsO7qBt5Zjk/umppSohHejxXzAFgFvJkeTFm1H2MFJRCx?=
 =?us-ascii?Q?/oTl6c7oyAg251hsH+XLrQWA7vKohM9ZUHczTVu4KYFxgVuhMWP6u5M8/rMa?=
 =?us-ascii?Q?QaLzo6qACYZJSHABr2zYi7X9wki/BrsXO/xsOHiuMsYm/wE9csuE6V04eDx0?=
 =?us-ascii?Q?dXvSVGuGvp4QVTHwmTo4cKOgFH8BbHpQuNglbVukRV6GSxkyG1xRXVSkRZfM?=
 =?us-ascii?Q?yVOH7DLhuP22Xf3Pwl7rMQeEmGOgOKY7OdpbC155fqoyV39KSASeV1NCFHU3?=
 =?us-ascii?Q?rNaAsWtO9RoriaYrbe/Q+tULGMuCVDPwzCcsnoFEr+PBd15o6zFp/+6gky0C?=
 =?us-ascii?Q?0dRyAhdPJVR3DbQUjCVUDFT72rMwE9R2QgPz8jVxVE8ZpHqsdFTw7uyiNDEO?=
 =?us-ascii?Q?vkZLMt59R84LMeMayEwH911z75ENyRIggqUE/BK5Q/EY6M/qfuweN2WeSWBr?=
 =?us-ascii?Q?/PRSpT1VqiAqmxR3Aym4tIFdnQWBvu0hhwXAwN04v7S/tF6Tjbl0VfRlCfMQ?=
 =?us-ascii?Q?MtgzPpapEc5yKe1FsauYGy6IoiFhlkJ1aYfNaxy+IezSnzqI55CCBGN7O36T?=
 =?us-ascii?Q?IKuA8zrO77tjDhvfAkPr4iTbQHJ1yQyG3DuySlsEkdYWMy50WjdJdwy1QTgt?=
 =?us-ascii?Q?TQ9Rt7ch4gWix1ex+Yad4yTeQ9K81zq5mKa0R2N9ifa5cRgEEKpXoBBM2C9u?=
 =?us-ascii?Q?xoPChKyjlgeVJBIa78x4cqrgAFlekseQy8gKQyoAH5BaRyyboC+EfyQyovJ8?=
 =?us-ascii?Q?8v6cNoVePBjKij4WFYF1aoEeOuQGKrpmCdjy1QmE3qwLmzN96Y1Yh/JtET5l?=
 =?us-ascii?Q?pJAtW81tbxoQfjNcZn+rqKX63S6Uqn+KCt8TbCO+RNVfRBE7jan7fpFHwyO+?=
 =?us-ascii?Q?Pc2jFaTWZWgt7ZQn+euymOdw0OOvYZSW+53r?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:59:31.1170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa04917-daf4-4fb0-b163-08dda7663d3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025

From: Saeed Mahameed <saeedm@nvidia.com>

Add missing HW capabilities, declare the feature in
netdev->vlan_features, similar to other features in mlx5e_build_nic_netdev.
No functional change here as all by default disabled features are
explicitly disabled at the bottom of the function.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e1e44533b744..a81d354af7c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -78,7 +78,8 @@
 
 static bool mlx5e_hw_gro_supported(struct mlx5_core_dev *mdev)
 {
-	if (!MLX5_CAP_GEN(mdev, shampo))
+	if (!MLX5_CAP_GEN(mdev, shampo) ||
+	    !MLX5_CAP_SHAMPO(mdev, shampo_header_split_data_merge))
 		return false;
 
 	/* Our HW-GRO implementation relies on "KSM Mkey" for
@@ -5499,17 +5500,17 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 						   MLX5E_MPWRQ_UMR_MODE_ALIGNED))
 		netdev->vlan_features    |= NETIF_F_LRO;
 
+	if (mlx5e_hw_gro_supported(mdev) &&
+	    mlx5e_check_fragmented_striding_rq_cap(mdev, PAGE_SHIFT,
+						   MLX5E_MPWRQ_UMR_MODE_ALIGNED))
+		netdev->vlan_features |= NETIF_F_GRO_HW;
+
 	netdev->hw_features       = netdev->vlan_features;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_TX;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_RX;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_STAG_TX;
 
-	if (mlx5e_hw_gro_supported(mdev) &&
-	    mlx5e_check_fragmented_striding_rq_cap(mdev, PAGE_SHIFT,
-						   MLX5E_MPWRQ_UMR_MODE_ALIGNED))
-		netdev->hw_features    |= NETIF_F_GRO_HW;
-
 	if (mlx5e_tunnel_any_tx_proto_supported(mdev)) {
 		netdev->hw_enc_features |= NETIF_F_HW_CSUM;
 		netdev->hw_enc_features |= NETIF_F_TSO;
-- 
2.34.1


