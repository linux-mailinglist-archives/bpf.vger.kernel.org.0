Return-Path: <bpf+bounces-50406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91313A26FE9
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3EF3A2FF1
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FF920C477;
	Tue,  4 Feb 2025 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tNAj4PtJ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C120B80B;
	Tue,  4 Feb 2025 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667267; cv=fail; b=MeHWpKcuJSU/p6u3qZIlpmkLT6iXE1gJ2IUJjdpqrI0QFqipBGCEWcmULvq467sm+xaVFQwmF/revtHE1JpDfovbMIuRovfJXzEqiSNi8unY/LNIstXTh+tSVY3O0NYZ26P9IoEnoDeyjmEkNiAsjQ+B+9L2lYDL7Ho5jVK7pnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667267; c=relaxed/simple;
	bh=yqg+Wgfe7Hl9hhRnoJjm+2Qf/E6aJwzSOn8s/2Zu3iE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8/opxVq8An0z08EoHbGtY//m4hz9xTdrCPO0sPMori6mGFKmFKt+yPrCsgK1KUwS5Cb9Y//bx/b5ufsXjIjXilDudz9vgXQmbzGzqZRm/DQ1MWBduFmk7ENJPc1hZl99I2bWBI9yj3byE8I8RltqavpkVaMnDMEJjj/hHQImQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tNAj4PtJ; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Icq3ojHEzVlMNy1A3SPOnYU/mmf0Umb2mI74QxdH0f9CzweOw0KDiCCFocO4rhST/lXSgEu/xA+QyXotKDnHa10MALmAxQkTZYHRdfiygMPueBVhSqeyk8+kaXaFJ59DgZOaclIwEFb/Finh7MFQYMFR5yxel1Y6aoNcR3xt66uGty1rfCFYdCQGaxrJ71CnCqFAbZWW3MQpERi6HBBM+gCCxCDXGX2gsuLIEZSjf0JqRL4EQIqHR4oMbNOR+r0IyMVpFTChJPgyyivBKbPt5hghS1j9wnq/v65E+PhBCi2zOhCPgaZKkz6EbsJemBUkYFAfjWInIgcBkgCqI5H+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26S6pGaoooAnlht7dCz7PMaG4N/tQBW3tGYALQgZsds=;
 b=GJ5TVsJlvyiCJf+J71xgNpeBIaONQbKZ4ST03qwJbjVzVVRP6uqR/BMdZhavjfaujckKQCFYBII+c5HMoSiwKa3YMgk5rUSGm4g1ATwSxFYsT7x1TQkqQypmDQs8kiEgWvs+sHOywDzeyFK7Y08Ngsypn8kzd4irMVBIOEh96p8qp5lm8X/kHHIpxTxYHkyaT1rAeFr2hteKDm2e17PtDNcVQexsoUp6qf0vCtauiuuiJf2eqtW4ylSJlbKq4M73s90k6Fc0QHZ+ch8kIEdUODCO8aL/1/s+ZNQRW1N44oBJi5xwCcd5rLuvh9PjwtRuZrjwU766XHEg3f/7rWwAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26S6pGaoooAnlht7dCz7PMaG4N/tQBW3tGYALQgZsds=;
 b=tNAj4PtJDQHUhjpJJsWaAeb6yxng/FfzBl5hieaqnJdpSXb2gH1v8jGVfTMdfD64yzQ8aYRgdAiO5GxlTmucJUGFfy0+7Dt3w664jq9ALQd9yR79n4JNW3G5O8TprD0+oPOACdZ4u/YZmaJfukNxkV4bVgMrAMysRsfB4QGjvu7Z2rxHakXxhCy9rpOJgngk5Rjh2h3bMD2qPqWoyyshJKF0dSYx//MW4KFR4PSrtuQzE76jBIGq4GePX+1YHwaGpOmZp7b7YTI/oPJEQLzYlP0pMeoDtONP/+jtNNXLczsscl37bRTEoVn0/QnitMnnIyceV56VOSQoqHImNAw/gw==
Received: from CH2PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:52::29)
 by LV3PR12MB9410.namprd12.prod.outlook.com (2603:10b6:408:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 11:07:40 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::d2) by CH2PR04CA0019.outlook.office365.com
 (2603:10b6:610:52::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 11:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:07:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:07:27 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:07:20 -0800
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
Subject: [PATCH net-next 11/12] mlxsw: Set some SKB fields in bus driver
Date: Tue, 4 Feb 2025 12:05:06 +0100
Message-ID: <cf7b6b6a689446db4fc9777679f98c738c3b9b79.1738665783.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|LV3PR12MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: 41857f90-f179-4999-3193-08dd450c2390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TV3zSNjo8v06tkiQqFHfN39ZwABUA5GBK2K3OlzeSyMdpPT6H/11H2p4HU9e?=
 =?us-ascii?Q?P3CzkawREjd/ajlVHSIEqhrvQ82lU5t58whP9ZqxfRkfpnU6ZHvTQFAJZ0sV?=
 =?us-ascii?Q?S5bF0+I9/U0vupvpvSs7G5UEi41g4HpwxW0rFQ/mPEdvUC1BmGILAB+uzZNs?=
 =?us-ascii?Q?b/CT+kh8R5Yy5ZMdMTwS6k+4OLYmwFN12ymtKP2AkHOX/YYgnQMthkdwKb7o?=
 =?us-ascii?Q?b68TVxqoYQR8Jspb39H67/MjVgbmX3QfpXTKg5g8BUtALX79YG/A5ODNuYjj?=
 =?us-ascii?Q?UzbTAJFtPDZLe+WxRrUaohR+ZzJ///R4aMaOxHg6ql5swP52N3gzBDguWhJ7?=
 =?us-ascii?Q?w3ceYOXgHsnH2XtcnexhGItOFAJHcPbqQ5dgcKmzHooxF1TLHzw9lSjB2e6w?=
 =?us-ascii?Q?0TNRwWhAOvB0TRVHme3hccPZCorTLijpagK0bdT4/z3nNUJ1hPO1d+i0g36z?=
 =?us-ascii?Q?33kLB0MxZfXmBpwhdVoqbbvK+Ryany9/x9G77x8GEsPkj7rjAKS29BLVyDlz?=
 =?us-ascii?Q?KhhMMRPPIwnMzUUjURxajiY4NwSOEtKJlfFo/u2b+M5vrRkpZS5loREnYG8x?=
 =?us-ascii?Q?uYNzk5GGnUxLylHjLCIS4doW4wXJIUFgegJBLLO7LHW8UrdWuV5DWRDLytj0?=
 =?us-ascii?Q?ayas5ULnQFIGjl6CRE0pxw7+4TesYESS5Pvi8L79QTOTD+Qd9gb6sRXHVW99?=
 =?us-ascii?Q?u/f1H9Q8y2JvO5DcuWmbQveelvLp0FSCFX7hbuggoUfkTp2ARZvAe6knupAA?=
 =?us-ascii?Q?RTJ7Y5qv+Ve9rSB3V1ffP64emSmrHg89GmSFNgIimC44/L0pNbt1d88c0AjO?=
 =?us-ascii?Q?A2XkoeZNcvOuCSD8xo5FVep+0rIr8wpR1Atla0x2rtLrkWOf/Hp+uUyyemBJ?=
 =?us-ascii?Q?bpTr/HrYJIXvW5KyeHnGne1juwnUsJDiubBNnU/V3AitGs+4iuvivqnKtSSi?=
 =?us-ascii?Q?XJ8mFau5OeBD3+HLW/Er8H+uSsUnw1HL8wR3DLfU2smC97w8lUTvtifyJLUy?=
 =?us-ascii?Q?KoYKYcEIr+FEdvvIAJKNylAiDKrrrMoQpPlNfevJoFGW4uIxXfq2emLndIOH?=
 =?us-ascii?Q?EPEkeyExDxj28eWo+fgUf3G76T3zxN7j3+zqRf33w8RRF0rpQ3U/1kVaDGOE?=
 =?us-ascii?Q?1Y6kAQiegw0vvLDY6UNeKT0V+S91XM3HCgjcsGcPzFlq1tML5eSqSY08LX1p?=
 =?us-ascii?Q?avmifTkwslFt3MQFx5GubI7nKuXU/PLiT23pwBX/cq7CckV8usLdvtCPiULO?=
 =?us-ascii?Q?YectlS6fExn3s80Lu0X16wTL0TFYZqfcd1WZb9zXH2RnJOPwNBMmV4MtduVQ?=
 =?us-ascii?Q?lI/4dTPPKh+gukBlsiF0uSzn9j4kEL4rIVCdV5QUWcAmcv6QBL9Onok6sDLo?=
 =?us-ascii?Q?oSD8sqlSIUNtYQRxl35VaACQkHPn4dC9bxlpxWVs8Re67hORpk/SjO+cSACu?=
 =?us-ascii?Q?cUgVcJrIEUJqYe0/7RSfr2djnvLuAuGfHaQv906HSOW4DDzcOutSRMa0aNI4?=
 =?us-ascii?Q?sLHJ0ROg0buNAPY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:07:39.3805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41857f90-f179-4999-3193-08dd450c2390
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9410

From: Amit Cohen <amcohen@nvidia.com>

Currently, skb->dev and skb->protocol are set in the switch driver
(i.e., 'mlxsw_spectrum'). Previous patches add ports array to bus driver,
so we can get netdevice given local port. There is no real reason to not
set skb->dev and skb->protocol when SKB is created. Move the relevant code
to bus driver. This is needed as a preparation for using
xdp_build_skb_from_buff() which takes care of calling eth_type_trans().

eth_type_trans() moves skb->data to point after Ethernet header, so
skb->len is decreased accordingly. Add ETH_HLEN when per CPU stats are
updated, to save the current behavior which counts also Ethernet header
length.

eth_type_trans() sets skb->dev, so do not handle this in the driver.

Note that for EMADs, local port in CQE is zero, and there is no relevant
netdevice, for such packets, do not set skb->dev and skb->protocol.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c           | 13 ++++++++++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c      |  5 +----
 drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c |  6 +-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index b102be38d29d..b560c21fd3ef 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -494,7 +494,8 @@ mlxsw_pci_sync_for_cpu(const struct mlxsw_pci_queue *q,
 
 static struct sk_buff *
 mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
-			const struct mlxsw_pci_rx_pkt_info *rx_pkt_info)
+			const struct mlxsw_pci_rx_pkt_info *rx_pkt_info,
+			struct net_device *netdev)
 {
 	unsigned int linear_data_size;
 	struct sk_buff *skb;
@@ -513,7 +514,7 @@ mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
 	skb_put(skb, linear_data_size);
 
 	if (rx_pkt_info->num_sg_entries == 1)
-		return skb;
+		goto out;
 
 	for (i = 1; i < rx_pkt_info->num_sg_entries; i++) {
 		unsigned int frag_size;
@@ -525,6 +526,10 @@ mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
 				page, 0, frag_size, PAGE_SIZE);
 	}
 
+out:
+	if (netdev)
+		skb->protocol = eth_type_trans(skb, netdev);
+
 	return skb;
 }
 
@@ -814,6 +819,7 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 	struct pci_dev *pdev = mlxsw_pci->pdev;
 	struct mlxsw_pci_queue_elem_info *elem_info;
 	struct mlxsw_rx_info rx_info = {};
+	struct mlxsw_pci_port *pci_port;
 	struct sk_buff *skb;
 	u16 byte_count;
 	int err;
@@ -851,7 +857,8 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 	if (err)
 		goto out;
 
-	skb = mlxsw_pci_rdq_build_skb(q, &rx_pkt_info);
+	pci_port = &mlxsw_pci->pci_ports[rx_info.local_port];
+	skb = mlxsw_pci_rdq_build_skb(q, &rx_pkt_info, pci_port->netdev);
 	if (IS_ERR(skb)) {
 		dev_err_ratelimited(&pdev->dev, "Failed to build skb for RDQ\n");
 		mlxsw_pci_rdq_pages_recycle(q, rx_pkt_info.pages,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 6b77e087fe47..a7d2e3716283 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2340,15 +2340,12 @@ void mlxsw_sp_rx_listener_no_mark_func(struct sk_buff *skb,
 		return;
 	}
 
-	skb->dev = mlxsw_sp_port->dev;
-
 	pcpu_stats = this_cpu_ptr(mlxsw_sp_port->pcpu_stats);
 	u64_stats_update_begin(&pcpu_stats->syncp);
 	pcpu_stats->rx_packets++;
-	pcpu_stats->rx_bytes += skb->len;
+	pcpu_stats->rx_bytes += skb->len + ETH_HLEN;
 	u64_stats_update_end(&pcpu_stats->syncp);
 
-	skb->protocol = eth_type_trans(skb, skb->dev);
 	napi_gro_receive(mlxsw_skb_cb(skb)->rx_md_info.napi, skb);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
index 1f9c1c86839f..2a69f1815e5a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
@@ -72,16 +72,12 @@ static int mlxsw_sp_rx_listener(struct mlxsw_sp *mlxsw_sp, struct sk_buff *skb,
 		return -EINVAL;
 	}
 
-	skb->dev = mlxsw_sp_port->dev;
-
 	pcpu_stats = this_cpu_ptr(mlxsw_sp_port->pcpu_stats);
 	u64_stats_update_begin(&pcpu_stats->syncp);
 	pcpu_stats->rx_packets++;
-	pcpu_stats->rx_bytes += skb->len;
+	pcpu_stats->rx_bytes += skb->len + ETH_HLEN;
 	u64_stats_update_end(&pcpu_stats->syncp);
 
-	skb->protocol = eth_type_trans(skb, skb->dev);
-
 	return 0;
 }
 
-- 
2.47.0


