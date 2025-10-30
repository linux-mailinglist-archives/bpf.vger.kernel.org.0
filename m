Return-Path: <bpf+bounces-72991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F8EC1F947
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5102461180
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 10:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5EC357A50;
	Thu, 30 Oct 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kkQY/LCE"
X-Original-To: bpf@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51925351FC3;
	Thu, 30 Oct 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819994; cv=fail; b=euF8C6vYrLzG9S75bWx7l6XI1hK8pHB4abpL+KoEuK4uD7f1kJbYzyWBa1lqKCc6XAL3R8yRbWbZGaQqSFKVl5v7DQqxIAJ0iFPMz0fCIzmfPSWx3bGYdCRxXu/hKoz+/Tqr6MFEJ5jd6789tYxBiRv2qa2+Xn3mZeILxBFSZYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819994; c=relaxed/simple;
	bh=trACKxqs31w82cjB3spS7x0Qn8U3zCh0O9sHSxidYTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVeKSUZfVRszVYteMOBWRAsoKx2o24xqr4mnXBgfUleC8ovDg78VijL9DhkJGmjhsK3XL843WgIeffcWLaDhsYhMZfDVgAxhfTfLC5sWK+X1A1sAbRSqzo1yHTViQg0z7A318VRgXEMS7wGSBOTszT1LBRobRms+XjcsipRqKf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kkQY/LCE; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRhcg8EJhYwwjSuEqIIsX/OiSJ28x39W2ui3C5MDczZzUy6C06rwrnT0gHwKydFZgpnm12pg3JE3szJjnJ8pkiUNyJMH3YkUYktRSSufV1TNSZFSaEem0f7umxjfUFDakamNZQ/lQCMx59ebWCfakm6Zmsoy+9e9AniB0c0yG7XLdhzmtzjwJnkEzx2vE1PaNA9bae80cI2XcGe3PeJmWJw2F4Wyexm6Jy0uP/iB933QGAyKA4wYp5GBf3RdJgJjqee/ZZIBC2bHOQJvZwyvxONGwZGC7MHyGmv8BryY5xxBQNCUFebaueTMrPyuoTBtlzHQD2/lWRtnT0i76BmGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pz96eVpK1zBwecxI1QBcNm1q9fzXJPe4TRMBb2URUqc=;
 b=g8oYfOYc070LNHUi7tqxobbep1aGqRWjI+Z/XBAUS64AES1VBf702w2c79lxjfHwu/thRQTJ96bzjXW+HrDLRFrTB1K3LMocf86/8SeWGHoLmnnzxy9tvOnX6sxhMNsxQkbhwcbG/2BwOw0Tn9DfWaYTni75jQrKMXSIwo/LkD82shHQ9nH7i4ehTJsZzxlrtxWXlzbE+ZOLz3+BCpRk8+P07fS7GMFbjnD+QFLjJDMFgONN1p/sty0Kt88np6hWWGY62VTfu8B5P/VRTrQEOufNemwItU4WGtOcRttvck14ygfU65CQXIspATNsbcGj4Ru3P/mcCpSxOB0CNgrOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz96eVpK1zBwecxI1QBcNm1q9fzXJPe4TRMBb2URUqc=;
 b=kkQY/LCEZQgEliV0fcpiANQoPOmr7q2+VqPJEbM3t5Wg8HPu3wE+qCqlZ8AyIQ2QVjr4otJB2p6Y3lgU9qAwepzvLItEIDtqZYIZPagfI8lgsXZdnC6pUtu4kLYlgWmGunVPsuWAvxVN4M4UlucasIlQw+QQXu2jEITi6jJOPNDE5CABIYlbEpodgkv5pNK4Caygeuc3wsNab1Jq4itsNk62hXboNVkh6555jnAn76i/H99a52SfJ5ZzbcDhLRL3Gj0Zo43WpneV+BCuHK4JZIZsFV2Cw/WzkQxCJZHqH6pqmr03kC7rRDgo5o0xzqgNKWS3SWn4Q5wf8yruNNfnyQ==
Received: from BYAPR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:40::28)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 10:26:30 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::44) by BYAPR04CA0015.outlook.office365.com
 (2603:10b6:a03:40::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 10:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 10:26:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 03:26:15 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:26:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 03:26:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 5/6] IB/IPoIB: Add support for hwtstamp get/set ndos
Date: Thu, 30 Oct 2025 12:25:09 +0200
Message-ID: <1761819910-1011051-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761819910-1011051-1-git-send-email-tariqt@nvidia.com>
References: <1761819910-1011051-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c8299e-635d-4a96-056f-08de179eca1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nd7VerEJXiVqkKm6HqcK6En7UM2+rHcExjvUvjXIObq1rQXuZlJO9ma9GE6C?=
 =?us-ascii?Q?YEhFYuQLjQ0XH2HM25A4CNbrdRRh07c1/PQavhpy7iFgxSB1z/01Gqn1+InY?=
 =?us-ascii?Q?hH2g6l4qQNOrMw0vmd4syPMpfxoq7okNpi3ktVX8dH+Gw73tDmjFtx07xhZF?=
 =?us-ascii?Q?YFnyDpbTZ7+KcT7Io307wHrLseTjmgkcYIjYLRTgpK2d3wh1x9PGdtDD2sER?=
 =?us-ascii?Q?PKJeacYYJoJ8UMqWDWoNJnq/cWztswGM2R9xcyDeiEst9po0gjswcE5k31Q3?=
 =?us-ascii?Q?/hMhre/LkBfSBo2JV7thKbSFBgzQSzNZtKM0F2B9OUzZ/vpPsGkmPtzTGeA1?=
 =?us-ascii?Q?UvtBCCk1EsTr2sKMOsdtqYk65mSxfSolr1ToERd6eZ7Gh5WK6S58tX0WMkBz?=
 =?us-ascii?Q?u6YQyEzT3p90nNryGbTx52Q+SxD/+KcgQ4Tv1aDm1xu1hP2H7TU206S6e76P?=
 =?us-ascii?Q?AwATeUzp2tm6s9o2s8aweEp/MtspySm000bqAkJKf13VBZfZZ+tdp07PhpIf?=
 =?us-ascii?Q?6vkR4KzwiPRl45FL6eR72RCFoLuuTryZHTJZtqQBJrpAHYeUbRwG+0Kg2YrV?=
 =?us-ascii?Q?12Y0ZNjPThWU68PQXFNVw9LU8BbJTQsvRg+A/jS74RU/3+TSvSgRUJNBWreg?=
 =?us-ascii?Q?FGoqU36vbysSPf9eI8J8ck5QfiOZ25EEEKWAwROVKnU3vztYnYCZmk5oAiQp?=
 =?us-ascii?Q?z0MVAMcmOpJcMpea3HNoAfNQkxEQSbrXKfMM4N85GptqEn9keQQcrmX21ktq?=
 =?us-ascii?Q?Yxx7kMKgO+kPZuCP6DbBqS+Z+3uabxPiZZCFROhWwfAs1HdSVyWDcsk8FRqL?=
 =?us-ascii?Q?a5gZ2tgVV2iLB/Ufa1Q7EhJubJ8fPI0H8n8aOn4vlNj8BJeLxyqySppVQSHQ?=
 =?us-ascii?Q?iKrW7QLp8A0nj8Qza1IEU+Euw6W4FdUiFS5J5ubK6TZ3YVCZ2ASBYIfjO6N9?=
 =?us-ascii?Q?A9ZSoU7FS2rswaw1N6WKFqaHGqltinqowhxuD6lJqOPHcLCvqYie/kES1Mgw?=
 =?us-ascii?Q?TXvEjabgiuQla61nLH3rmFr37gYp9b53Jd6kn+toihR5fda5Ml1K9JTaQpmU?=
 =?us-ascii?Q?mD2LEF+Y5LP9orWAKrNDOynxbbWLI/T+IJDaZ9WOohOHEIp98SCHfwcHge60?=
 =?us-ascii?Q?l6oYanltrRWBX3MzaFY9X9k94PNDPhXTZnr/Wu6Zu7pPPhEJjAoaEqR53u9u?=
 =?us-ascii?Q?lIbHPUdBePXdIPpHHbBfQpg8uzOOarVWAVp6Bw0xZANgPlv4PiePLnia1BHS?=
 =?us-ascii?Q?efM+bRo0drNu3N/+We/m9G5HYzfudk0ZthZrNiglLH2FV1LKNpW+C3KCM6R3?=
 =?us-ascii?Q?zJ6kEgrqXkdrMNMRcg4gjm6nLlscqIZ7CyV+2PGfHoDhgQuCHpEti8AUQmrR?=
 =?us-ascii?Q?ojEAelSylWtKllvHVHeK6o8srPXyiZSPptC4jaCMqx8LEHXGHdCglZ88o7Zo?=
 =?us-ascii?Q?Tmg49jak1xHt/ZzSC9qb4w7g9l6mqApP3yZNTGCBhZD4E5FGTuB2Bk7FItrA?=
 =?us-ascii?Q?W6IHtmWCaELFHY7dJ3ENzK/TSTHS/YGxAGlonL6L77LqlJuE6NIkbKCefGZd?=
 =?us-ascii?Q?gOKtKjCjxRuVI97IS1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:26:29.5378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c8299e-635d-4a96-056f-08de179eca1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172

From: Carolina Jubran <cjubran@nvidia.com>

Add support for the ndo_hwtstamp_get and ndo_hwtstamp_set operations in
IPoIB. This allows lower devices to handle hardware timestamp
configuration through the new ndos instead of the legacy ioctls.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 5b4d76e97437..300afc27c561 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1825,6 +1825,31 @@ static int ipoib_ioctl(struct net_device *dev, struct ifreq *ifr,
 	return priv->rn_ops->ndo_eth_ioctl(dev, ifr, cmd);
 }
 
+static int ipoib_hwtstamp_get(struct net_device *dev,
+			      struct kernel_hwtstamp_config *config)
+{
+	struct ipoib_dev_priv *priv = ipoib_priv(dev);
+
+	if (!priv->rn_ops->ndo_hwtstamp_get)
+		/* legacy */
+		return dev_eth_ioctl(dev, config->ifr, SIOCGHWTSTAMP);
+
+	return priv->rn_ops->ndo_hwtstamp_get(dev, config);
+}
+
+static int ipoib_hwtstamp_set(struct net_device *dev,
+			      struct kernel_hwtstamp_config *config,
+			      struct netlink_ext_ack *extack)
+{
+	struct ipoib_dev_priv *priv = ipoib_priv(dev);
+
+	if (!priv->rn_ops->ndo_hwtstamp_set)
+		/* legacy */
+		return dev_eth_ioctl(dev, config->ifr, SIOCSHWTSTAMP);
+
+	return priv->rn_ops->ndo_hwtstamp_set(dev, config, extack);
+}
+
 static int ipoib_dev_init(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
@@ -2149,6 +2174,8 @@ static const struct net_device_ops ipoib_netdev_ops_pf = {
 	.ndo_set_mac_address	 = ipoib_set_mac,
 	.ndo_get_stats64	 = ipoib_get_stats,
 	.ndo_eth_ioctl		 = ipoib_ioctl,
+	.ndo_hwtstamp_get	 = ipoib_hwtstamp_get,
+	.ndo_hwtstamp_set	 = ipoib_hwtstamp_set,
 };
 
 static const struct net_device_ops ipoib_netdev_ops_vf = {
@@ -2164,6 +2191,8 @@ static const struct net_device_ops ipoib_netdev_ops_vf = {
 	.ndo_get_iflink		 = ipoib_get_iflink,
 	.ndo_get_stats64	 = ipoib_get_stats,
 	.ndo_eth_ioctl		 = ipoib_ioctl,
+	.ndo_hwtstamp_get	 = ipoib_hwtstamp_get,
+	.ndo_hwtstamp_set	 = ipoib_hwtstamp_set,
 };
 
 static const struct net_device_ops ipoib_netdev_default_pf = {
-- 
2.31.1


