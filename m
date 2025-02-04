Return-Path: <bpf+bounces-50399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB33A26FD5
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74506164F57
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDE620C02E;
	Tue,  4 Feb 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZvXv7PMf"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D8B2063C8;
	Tue,  4 Feb 2025 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667218; cv=fail; b=lxYW/iAKkWpHPSGxcw/20SZSqA1oJjdKeaq2d/jT0hr2qSadAi8ReXa+2u68Fw8gCaRGAuXrHzZGLMdzWfQN65IKt2Y1LvuKTpMiE2AFnZgyynz2leOO3Hd5JNG5lPeioGolBUOqVeP3QuY1XLLBgrhkbmTysvt7Urb5S6dHGCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667218; c=relaxed/simple;
	bh=p90I8Uk6KyOEzfUGJcIKnRpy99lPBC7M6KfCJoJldSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4ztExjLCaAB952vjftuktLgublSoPZ2TeWFkvxCPLib20rFRHuiyzFh7z0OOQTeK+6N5Pmau/pO/5PKNjBnbEchQ5TQkxMXWv4Ipod3wHXHRtk4gGRjUa6rN5ZuUWvMCa2x6gLfkPlF3jpjmY0LdmRNjRXDx8QWhDjXqyL5UZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZvXv7PMf; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qd6NW9H2KHsoQ/lseV0tfp+sT4QNDD1tDfPMKOLuNqNesIxWsEbbJkLMXQ6TEwgQBM8butG2yKEsVswaN/hjJTa/KYaAn5Ge/AjC0nPRwDSnWlOgA7zrQ1Dx12282UGhpAo4xabyhMofBq9x6gDavvvKfEYugsmumhKbOZpcwU2nbwRBBhZcELVAOINTAYiQfiwJzuevtKfAt3Uo4+sQc6+aNLRnZJW0mgpvvsDDFB/EsneNQRFWNuTJ8MRJ/sJIz7MdtZiK0a/xw2NwtxG/A3yP7b1e3pVU8Y0Vgigsvwl+fb61NYyaVEHtTuKHmfzLJDvmpqUChMfb4eYGYxsPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAgSPV8iZcdviVkDRtQdlShhkSkMsJ9SOD1Qmkar1m8=;
 b=xnj+JU1pVaLaGu0vreEcGT67rB0wW+CvDfWlhoGoW3Lv4JZPVTipoaWRirWF2RYP9dLp3qouvkHbrIzIWMTyniBaXSrw+9Abx5odpzMTGfVIHDGWXsntCaGcyrrowNvtJ3U+sYtM0ikBui4WVQ5DTQHAmXUWp9+ZftPZ4djPWwimAUzp78cRJMoPfiP7e7Ztnpu6Vv57K9nGD97AG90u7uvmS89TDUhlGNg5Bg5JDbyDucmLjcge7mCb+mBzuJefP+PX7Au3BKvxwYIoWnu13QB1v50uDYImBu0HWTLDrr/V+pe/cW9znAIyaydaMAP5um1IrUJDYzRwKKHXHH2f0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAgSPV8iZcdviVkDRtQdlShhkSkMsJ9SOD1Qmkar1m8=;
 b=ZvXv7PMf1KEcrhHSO8HIU9XTUD1zZRcLFNAaEFkBjgMbZ5lca6Fcj7MsUrAWuxmHZsBKm7IYs2+pD1uZpk1kO+ChvlkvXcUpiigaD/IAqvd7zduJW5xvSCY5uylJggXZ7KInBTiyn2yIZOtZdEPUlzsg6Jqt7PpKOOWCEE2pO/oF2yVWtLAl+1RRELPW7cT3Xy5FU5DG4Utrj8VUplZ2qQQZL8nP2R10caXJigHCsGBJr9rI0wP63hQY9ewruRlrxnHZvd8f2pati63h4c8vjO9CLRgt6EzMvFJPyj0uTecSxYTfP3rrypGg/yiV4bB3c89prmiFIbC3QhdTSij/HA==
Received: from SN7PR04CA0057.namprd04.prod.outlook.com (2603:10b6:806:120::32)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 11:06:53 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::25) by SN7PR04CA0057.outlook.office365.com
 (2603:10b6:806:120::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Tue,
 4 Feb 2025 11:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:06:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:06:45 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:06:37 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 05/12] mlxsw: pci: Add a separate function for syncing buffers for CPU
Date: Tue, 4 Feb 2025 12:05:00 +0100
Message-ID: <7674318d47d36fb91a64351ca64a491ec61d5284.1738665783.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738665783.git.petrm@nvidia.com>
References: <cover.1738665783.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc2ce18-b815-4690-6095-08dd450c0807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2TK/K3P5epWp/BWapbqR8ZtEtKK24A3CbPKHxeD30Z+BReRtQK5Q50Zy1+Ya?=
 =?us-ascii?Q?icOuNTdiwiwmsQPFSemSLFqW0EvjWvQx4PNYG8lyyDxiteyOxe3aVeOTbaOn?=
 =?us-ascii?Q?6eHbqzawiVUNKm2Eg4MnIwttzy4yKs1X705Lf+e76F48ho0gicF0BWllmXNR?=
 =?us-ascii?Q?cf+wO7Vxu9SQJoPF+IwrcQbrQ6evayiosU73TO72aD3sUZeXGNHxotSibHh+?=
 =?us-ascii?Q?PdkEsEqZoOrnJAFFKWokAMvPNPy7ElvunlivGkzep7aP8pDxeW2NXKpqy9uO?=
 =?us-ascii?Q?cvZcpbqhNcVMat3a5CCWaSGIj5q3cKIGqehan+PO8qUIWUpI1q4YvgwNkgd8?=
 =?us-ascii?Q?Ibf42phJUEsv7k5EgvzrD68Tat9fnS/QHFnMjxBA5nWXkAAYh5gj9EJAylg2?=
 =?us-ascii?Q?LlyJtVOaPHAEXLP+EcQuttaza8g7LvBvJnwQEGYEYVSHzqEZfsHmU/Arb1Ns?=
 =?us-ascii?Q?WlKsI0MF02jWugHtnBvVCJ1o1J4l5a8zbs4U3SQhqJusotakXbrfFq4xjjsg?=
 =?us-ascii?Q?xJer5g4gD1ZfTuGYKMZLrvO3uviX7qFbcB/6OInAgSrD6oT1kwmORMOXf8pS?=
 =?us-ascii?Q?V1wNeJyECNcKlwT6frzsiowc9VoldCsoOET7yfQ8pROkQ3Y3wl9O9QKi+pSb?=
 =?us-ascii?Q?niV5d/VYmXnFtQ+HMcFdvgTFnv7zG3ErVZHV6JdHJNcDhZqWKyR2LyJPb12s?=
 =?us-ascii?Q?zLo5Gr2buGulKeO+Alplb1seuNNe6wg9HGLcTtvt6ByodXkrKDOjr986tucs?=
 =?us-ascii?Q?lwX5359pwRQvv2lYEfX/DPBZcjG+B7jhh6mFbeycFNrXgM9kpS6p/9GHAFZF?=
 =?us-ascii?Q?QOVO8eN08zLaQGshVmz6nfrvYbB7V7YuElL675eFBCTQn/cmKnq7gPYtFhVT?=
 =?us-ascii?Q?fd7nHFfxemyyR0OSZ3NecpLkRV5Vo0fFtPjBzxUVZJnmLtv4zKaDp5zrEFtD?=
 =?us-ascii?Q?LwYVyACXtuVExRCtE6U1ObDs4sa/jn4B9w/oS3T1duR4m8PxH8L3W3HNpOsY?=
 =?us-ascii?Q?bbLic51jFhWTa9myMxcBa64IAx4F9Y21mjt8i0rX4MCDfwIz7cGj6uxn7IB9?=
 =?us-ascii?Q?zxrZcKxgGRmIXrbpjTwaIBT560+rBNFaOmcvflZoZ4698LQ3wTBLI0orV4Dx?=
 =?us-ascii?Q?hrJClaIoxiPCNw9bL7u/OemctLWn6lzaSRCJqFRzjNZnRZzlonxKac4eShZU?=
 =?us-ascii?Q?rAw4V5G/Zacp4RIoyTFV3J86mPXh8pT7axHXsaSUvSyDOFFi1/J6lw+k7arf?=
 =?us-ascii?Q?r2z3TLhUYefAFBlFrFFD+lYx9ZYwFEyy4dvtOCh8h5r31PhFjPc8t6XPDgOz?=
 =?us-ascii?Q?1HtNPPH4U31i5LN0jVPJJUBxunK5UoTOt0Ty4V6ZeMhcBBZsOguya5fI85wf?=
 =?us-ascii?Q?iV8jywaqkvQc4/QXxmfWxgP9NbLRids0cryzoiNNT4/JrCVTygY6wtC9gEHU?=
 =?us-ascii?Q?tmACoW4PjDWqev4jQaFqH8Qt8Oec0I9vXSTHmApc5pCykdI0uUPfnNSEJiBf?=
 =?us-ascii?Q?A30NEY31l0T2Qqo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:06:53.1541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc2ce18-b815-4690-6095-08dd450c0807
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344

From: Amit Cohen <amcohen@nvidia.com>

Currently, sync for CPU is done as part of building SKB. When XDP will
be supported, such sync should be done earlier, before creating XDP
buffer. Add a function for syncing buffers for CPU and call it early in
mlxsw_pci_cqe_rdq_handle(), as in future patch, the driver will handle XDP
there.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 30 +++++++++++++++++------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 374b3f2f117d..5796d836a7ee 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -433,22 +433,34 @@ mlxsw_pci_rx_pkt_info_init(const struct mlxsw_pci *pci,
 	return 0;
 }
 
+static void
+mlxsw_pci_sync_for_cpu(const struct mlxsw_pci_queue *q,
+		       const struct mlxsw_pci_rx_pkt_info *rx_pkt_info)
+{
+	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
+	struct page_pool *page_pool;
+	int i;
+
+	page_pool = cq->u.cq.page_pool;
+
+	for (i = 0; i < rx_pkt_info->num_sg_entries; i++) {
+		u32 offset = i ? 0 : MLXSW_PCI_SKB_HEADROOM;
+
+		page_pool_dma_sync_for_cpu(page_pool, rx_pkt_info->pages[i],
+					   offset,
+					   rx_pkt_info->sg_entries_size[i]);
+	}
+}
+
 static struct sk_buff *
 mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
 			const struct mlxsw_pci_rx_pkt_info *rx_pkt_info)
 {
-	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
 	unsigned int linear_data_size;
-	struct page_pool *page_pool;
 	struct sk_buff *skb;
 	void *data;
 	int i;
 
-	linear_data_size = rx_pkt_info->sg_entries_size[0];
-	page_pool = cq->u.cq.page_pool;
-	page_pool_dma_sync_for_cpu(page_pool, rx_pkt_info->pages[0],
-				   MLXSW_PCI_SKB_HEADROOM, linear_data_size);
-
 	data = page_address(rx_pkt_info->pages[0]);
 	net_prefetch(data);
 
@@ -457,6 +469,7 @@ mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
 		return ERR_PTR(-ENOMEM);
 
 	skb_reserve(skb, MLXSW_PCI_SKB_HEADROOM);
+	linear_data_size = rx_pkt_info->sg_entries_size[0];
 	skb_put(skb, linear_data_size);
 
 	if (rx_pkt_info->num_sg_entries == 1)
@@ -468,7 +481,6 @@ mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
 
 		page = rx_pkt_info->pages[i];
 		frag_size = rx_pkt_info->sg_entries_size[i];
-		page_pool_dma_sync_for_cpu(page_pool, page, 0, frag_size);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				page, 0, frag_size, PAGE_SIZE);
 	}
@@ -784,6 +796,8 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 	if (err)
 		goto out;
 
+	mlxsw_pci_sync_for_cpu(q, &rx_pkt_info);
+
 	err = mlxsw_pci_rdq_pages_alloc(q, elem_info,
 					rx_pkt_info.num_sg_entries);
 	if (err)
-- 
2.47.0


