Return-Path: <bpf+bounces-50398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FE3A26FD6
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD7C1887994
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CD320C019;
	Tue,  4 Feb 2025 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mfdQHuyD"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0B2063C5;
	Tue,  4 Feb 2025 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667210; cv=fail; b=ZxaFfdZdXTJJ2CawlQxsUL7oVJzqNUt2c/ayQwgDikHlINqNuH6YqgAK1C2b8+NvaK3LsEz8R8svQhKtqVymw7BthRRAdwcTU1Z865MTf1p2NoEqkU9y5Gae5Y98OgD4bz/X2WrzVs437/mmbweasTuXhJkKn5W+NhdaDEmMEdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667210; c=relaxed/simple;
	bh=Eh/4/T9GNj32ivGqFVwm+vz+DhvryVqpeCMrUfhI72Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEh9uegcLonQtehrZbtO1YzboJSVCCyYFqfO2jR1jP3NMaweExls5D8tO+0olAX2336JqHoxXBL0Bd4k4VotJfZa+nIb9jeOzNOxrPXs2oFJtthHHLTgpaTvb2HVxGbPsZAbtRVngVnXmGGNx60iXrYO+E1ht7Vk2OkIKsrbugo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mfdQHuyD; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjsTkZjeop+RWMdF9K/73KU+kbmfquCKUzF9sqDtJrHYiyoX3hlyoPgXxE2VMVsGCdK9b0AFKyJvD+5RZ3cUT+4tffd3xPsoYnTdH8XfHKeujlIM8nhGn+xPALsHrMHlCRwtV0l+/1SrinXPeIZQqUFOPr9xwdoKDMe7YIFPIeRY/GdCti+D1Lp6c0jjM4wRdzRq9X3iAkv7g1lBUEqty6oZ0zBcqBLS7gtV0GP8QpkiCLgtkzCOY8KWvf4STVP5cETGCTPjA4H4tuDTuS5sQy1M+mDEOBEfR6UZFpRsGQqFtErdX+ApEw47/Bz52R6MMqaOKZ8m7BlTGoB63zgZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASsTDTEjIbFhxKDWmkzrbQ6NCt8L202OdNNlpU7YfF8=;
 b=P2pv3QoKZftPKS3MJDDuHti9ULmWAF+PPMQm24dzoArsMYmTY7hDCzFQFEIyQfXHvvbglViyGo6S2fKUdFoHzDXhHFfGK42Cl1D65xxfkvPsJmxwS9r5hoiAX4MtvrN8xFzgbDH9mNkde8Y2/y6tCy35bSs+Yw917sZKpZDSZQqSjQTJOjoRQRnNWB9aBsvJelSRMzgLFCHIG0LdYFrA+t4c+ObgWFX3sh2V7if7vBsPDEr4aBKN3y71pqXmSgms6R26I9voFobhuBjTjYBhIHSCXn7Vz+ooiABxdIubuiixbs9wjlyoH9iWIzgnwZgN4eVoECiJ3WAGIWphN5buoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASsTDTEjIbFhxKDWmkzrbQ6NCt8L202OdNNlpU7YfF8=;
 b=mfdQHuyDMIeblgq1elC1FRRu7Y4+giZ7ahdAeRb+a3sYVsWSHcJohMWETsfhKA/r3aENyO4vjHXotQx2ossQj23Lz8uqRbFs4NwQY5JVKTb+gQ7J1ixfVR6JzZJFXC3kQ6dbpn92JM/3UbD2aVfzoWMJJ9s3dGtYxF/xDoVY1ttr0plaJg2quJdQwQYpsgDNwc5KhH/U8KErlpw7Su7AigrD3lB5EF6PURP2UpSEkd6eVFzFakY3pWN3NZbC7n2/F+tKwk9g2M/M9DaP1SZh2RoKmNUcvpleUX1GZ4AVVUf2IunO7JhCADfbuwsXtHWbGYO5Zh1IqveiGHm5TGJTng==
Received: from SA0PR11CA0169.namprd11.prod.outlook.com (2603:10b6:806:1bb::24)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Tue, 4 Feb
 2025 11:06:45 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::9d) by SA0PR11CA0169.outlook.office365.com
 (2603:10b6:806:1bb::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 11:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:06:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:06:36 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:06:26 -0800
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
Subject: [PATCH net-next 04/12] mlxsw: pci: Use mlxsw_pci_rx_pkt_info
Date: Tue, 4 Feb 2025 12:04:59 +0100
Message-ID: <d51ed1f65b666236e0caa197fd8669d88beba7cb.1738665783.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 274f7aad-6e74-4e2d-e911-08dd450c0353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vNDTUlu1V0afwLnxOnwasYGz353b3E/18JpwRKbCyoW6rGSTbvcYeh7s4FyQ?=
 =?us-ascii?Q?YD4c0B8Jde+PEdQGZbO9MvIgKBaWEzy8g6ZBZfW4KluhWVmIXpWDDisbBFlx?=
 =?us-ascii?Q?g1FUchz7zwU9m0qJLgTAgPhwyc0pmRnwH/ZtotKs3C53jzqcmLapJsMZepiy?=
 =?us-ascii?Q?m8KaD9c1hutoyelT2HRyp4pGjA4xWuObp2KTW1npm6J0uzoFITnKyvC4Z9DE?=
 =?us-ascii?Q?UuaZRGpNXyONqU+D3gEQDhfxWiWSEk19Gx1pXybuSXAbHO4WCm0Vqne+ru69?=
 =?us-ascii?Q?N8ReOT0/5++JacMRN0EN7qjxxh+JX73uvpgZHtEBz1vwNqf8wIuKHco1XRG6?=
 =?us-ascii?Q?lL+h1OM79/oK2gpXYWEz6tP42QHIsVLhPs+bsBFP8uW5WfCMT2Cm++l+Kee7?=
 =?us-ascii?Q?NEhKNvwEwCjm7SE6KlnFnEoW+v/eXVztlc5k0m97fNDjLrv7+5q6ZsEr25wD?=
 =?us-ascii?Q?Gsa74US+yXguzm1N1mlL6TxisVxRzLi75fQZ5YlY9gJeQg4qRrGhycN/FcGt?=
 =?us-ascii?Q?YMofrGxp1Va8AIwkQ331UwMIq/Nc/C4FWrSC88LHkZ5IcJjyOjhhP/e6wIkm?=
 =?us-ascii?Q?OkCWAKHRWK62x/wzKT6h2Yk4dd6WLNRrC1GBP6BbO2uOWBraQjJKOFBiqcp8?=
 =?us-ascii?Q?XED4VpFt+DdxeMRBsh1T2y4MxKUE7OOnsyRH8PnPGwygw7UorVNMT6pW7lab?=
 =?us-ascii?Q?QXiUZOTUiPZHWDykadc3ALDKtINFCJ7IArDsmHRepvsWF2V595gjsBnmlDOc?=
 =?us-ascii?Q?qSgyvbdzafE548OKFc6OA4urb/NKo/fUD5RZ1yENC9SXS0vwQ0LulUUhO8Zh?=
 =?us-ascii?Q?GkchmzHuLQ+2TzgZfJoJ8Wtzf1iFV0hERpI8uFa0ljsqiFeR0TPP1Nc894gv?=
 =?us-ascii?Q?6gTaX5p4g2V4cJkvsJSc6bmmFYdO8AKuVhHBDfjAKcgCDz3yrOGsULdM3Za+?=
 =?us-ascii?Q?7LIqHdGPuzFA0ryXZGyMYszKcsjEDO/cKIx7n117SX5gKGII+Ff+/oLc5wTv?=
 =?us-ascii?Q?OO09b51+WrxLoA4MG8OIEy7ftqwWKOEbd+DFMjkBLjU70CmNPaOK//R0AhjK?=
 =?us-ascii?Q?i1l6HPFA+OR+hPKO2a+b+2aPNQ+ves2QOr7CBxZCPtnmsGhLGLLUrEh12jHu?=
 =?us-ascii?Q?jQDmaQh+CZ0uFhOej64/pApGx5S9nznq16qSElZgtdKfNdKScUJj/Zvjpbwt?=
 =?us-ascii?Q?PgIwbOKkxHR3b+rBbALfUoRpPGTfXM1bUZ6G0TplrQkcDORbzHHQRzeOnZ1o?=
 =?us-ascii?Q?AEMejPYboXHRWXZCG6iynYfxmzJ3hgcR6G0YHCtJc+Jw1FTG0FZ5gMnS5tWe?=
 =?us-ascii?Q?rD0tIYbz27Qax30JCm5ur1AECCao+ZONoOY0Q3xens+vKmeqpzgsXVNqOnEC?=
 =?us-ascii?Q?0dSAS2dIXe84MIylITukxtw9qZCV070HOcz2U9SPlGo9mW7EK1c9MMHgGELK?=
 =?us-ascii?Q?VqBxPdbrbobNAQ+MAOC/q4Oi4ug89/ZWXv73Abcle2YjlK3b0zsDnHASn517?=
 =?us-ascii?Q?0C4gcnlT1O9ypTA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:06:45.2827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 274f7aad-6e74-4e2d-e911-08dd450c0353
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362

From: Amit Cohen <amcohen@nvidia.com>

Pass the newly added structure as an argument for mlxsw_pci_rdq_build_skb()
and use it.

Remove mlxsw_pci_elem_info_pages_ref_store(), as mlxsw_pci_rx_pkt_info
stores pointers to pages.

Pass to mlxsw_pci_rdq_pages_alloc() number of scatter/gather entries which
is stored in mlxsw_pci_rx_pkt_info.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 65 ++++++-----------------
 1 file changed, 16 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index aca1857a4e70..374b3f2f117d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -433,28 +433,23 @@ mlxsw_pci_rx_pkt_info_init(const struct mlxsw_pci *pci,
 	return 0;
 }
 
-static struct sk_buff *mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
-					       struct page *pages[],
-					       u16 byte_count)
+static struct sk_buff *
+mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
+			const struct mlxsw_pci_rx_pkt_info *rx_pkt_info)
 {
 	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
 	unsigned int linear_data_size;
 	struct page_pool *page_pool;
 	struct sk_buff *skb;
-	int page_index = 0;
-	bool linear_only;
 	void *data;
+	int i;
 
-	linear_only = byte_count + MLXSW_PCI_RX_BUF_SW_OVERHEAD <= PAGE_SIZE;
-	linear_data_size = linear_only ? byte_count :
-					 PAGE_SIZE -
-					 MLXSW_PCI_RX_BUF_SW_OVERHEAD;
-
+	linear_data_size = rx_pkt_info->sg_entries_size[0];
 	page_pool = cq->u.cq.page_pool;
-	page_pool_dma_sync_for_cpu(page_pool, pages[page_index],
+	page_pool_dma_sync_for_cpu(page_pool, rx_pkt_info->pages[0],
 				   MLXSW_PCI_SKB_HEADROOM, linear_data_size);
 
-	data = page_address(pages[page_index]);
+	data = page_address(rx_pkt_info->pages[0]);
 	net_prefetch(data);
 
 	skb = napi_build_skb(data, PAGE_SIZE);
@@ -464,23 +459,18 @@ static struct sk_buff *mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
 	skb_reserve(skb, MLXSW_PCI_SKB_HEADROOM);
 	skb_put(skb, linear_data_size);
 
-	if (linear_only)
+	if (rx_pkt_info->num_sg_entries == 1)
 		return skb;
 
-	byte_count -= linear_data_size;
-	page_index++;
-
-	while (byte_count > 0) {
+	for (i = 1; i < rx_pkt_info->num_sg_entries; i++) {
 		unsigned int frag_size;
 		struct page *page;
 
-		page = pages[page_index];
-		frag_size = min(byte_count, PAGE_SIZE);
+		page = rx_pkt_info->pages[i];
+		frag_size = rx_pkt_info->sg_entries_size[i];
 		page_pool_dma_sync_for_cpu(page_pool, page, 0, frag_size);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				page, 0, frag_size, PAGE_SIZE);
-		byte_count -= frag_size;
-		page_index++;
 	}
 
 	return skb;
@@ -513,24 +503,6 @@ static void mlxsw_pci_rdq_page_free(struct mlxsw_pci_queue *q,
 			   false);
 }
 
-static int
-mlxsw_pci_elem_info_pages_ref_store(const struct mlxsw_pci_queue *q,
-				    const struct mlxsw_pci_queue_elem_info *el,
-				    u16 byte_count, struct page *pages[],
-				    u8 *p_num_sg_entries)
-{
-	u8 num_sg_entries;
-	int i;
-
-	num_sg_entries = mlxsw_pci_num_sg_entries_get(byte_count);
-
-	for (i = 0; i < num_sg_entries; i++)
-		pages[i] = el->pages[i];
-
-	*p_num_sg_entries = num_sg_entries;
-	return 0;
-}
-
 static int
 mlxsw_pci_rdq_pages_alloc(struct mlxsw_pci_queue *q,
 			  struct mlxsw_pci_queue_elem_info *elem_info,
@@ -780,11 +752,9 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 {
 	struct mlxsw_pci_rx_pkt_info rx_pkt_info = {};
 	struct pci_dev *pdev = mlxsw_pci->pdev;
-	struct page *pages[MLXSW_PCI_WQE_SG_ENTRIES];
 	struct mlxsw_pci_queue_elem_info *elem_info;
 	struct mlxsw_rx_info rx_info = {};
 	struct sk_buff *skb;
-	u8 num_sg_entries;
 	u16 byte_count;
 	int err;
 
@@ -814,19 +784,16 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 	if (err)
 		goto out;
 
-	err = mlxsw_pci_elem_info_pages_ref_store(q, elem_info, byte_count,
-						  pages, &num_sg_entries);
+	err = mlxsw_pci_rdq_pages_alloc(q, elem_info,
+					rx_pkt_info.num_sg_entries);
 	if (err)
 		goto out;
 
-	err = mlxsw_pci_rdq_pages_alloc(q, elem_info, num_sg_entries);
-	if (err)
-		goto out;
-
-	skb = mlxsw_pci_rdq_build_skb(q, pages, byte_count);
+	skb = mlxsw_pci_rdq_build_skb(q, &rx_pkt_info);
 	if (IS_ERR(skb)) {
 		dev_err_ratelimited(&pdev->dev, "Failed to build skb for RDQ\n");
-		mlxsw_pci_rdq_pages_recycle(q, pages, num_sg_entries);
+		mlxsw_pci_rdq_pages_recycle(q, rx_pkt_info.pages,
+					    rx_pkt_info.num_sg_entries);
 		goto out;
 	}
 
-- 
2.47.0


