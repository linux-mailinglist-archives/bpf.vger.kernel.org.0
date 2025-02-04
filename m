Return-Path: <bpf+bounces-50397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6D4A26FD2
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA6A1887D73
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F720C032;
	Tue,  4 Feb 2025 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eU/61REq"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F68B16B3A1;
	Tue,  4 Feb 2025 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667199; cv=fail; b=Wv2hDQxK8USCflo1Xqv36bTE2HA4tSrW+Z9dZiqj1IYZHebph3aZPd57X+/lDLtPOq9R5L474pEHqBk6krzusaIiTNdEcEyxxOrbTjZu1jJHlVfzectQBnoDKSF9DhHQ90pfLCFqt15l0vKaN3wVa7IhmrdqQgpr9CDbbgmz8EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667199; c=relaxed/simple;
	bh=/oNrjH1CakHXJ/f4+3kyDXh0VwczLWPFTGpwr0q6jVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9rpBHvf/IFSmQhoaapoPaiLCkz/ziPVnrJsGtokfsj8weRtYmeNJh+ydQHZiPe8YPNxtyiLPjWM8GC3p7tnyQfpJHZgKTZp9orBZr4NdTcWyWN2VpPS/Ad0csuUqBTCwBt/xVm6ruWZwfPJw7M+tishMAnLetmNzWRKz7Xg2MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eU/61REq; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5I2zFPmiBQMdO8nGXNJRuYRinQMzj4I/FQ9ahtdqIpOijsgrGaFuW69BkHoIo8tCvt4qHnMs5HaHn/c7RyC64QVLDAwcjRlHuBfXQzHDwuCwQ3YUUR3IvqjiJZEsNaWxk/ZjukjxzXmJ3XjUcG1Kw9BAhpK+GsSR9wW+6YLZ02re/yoMsxdoEKaU6dNgwXj5+jC8ulEq970hBnIma2/TUgoxvj82ZID3pzGIKx+znNmVbV30Hbo08Eh1zBJ9+ML5sZrY20gT7jwzFK6L1T+aEPQRYZ/x8l+YIabcqIfeim2X1fp36Iix4zs1Joj1A2iGyMdzayQaqKitDAMNsR+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPLnprjFxp5C9FYpa8wuZhKJAt2rTjRcuUsy7xx/XGg=;
 b=csjSqFaH8mzMjqxTRTY3aYya+LyC+LRx/J7ZQGjOUHHAXukplk36EdeBpb+pLUZ/EfevrK26U2ry1Rlb4AsD472YBXmHJHRzoizLEp8IbkYxMCx+P1GOGGB/54GcpEDAw4RkYk2iVljA0xZqM6wL9iA5wXBWV8V7Sr/HHiU0WPHXn39Rsow4HchUedqVM3JViLi3kWvw6SHqNXFMZkYNm6No2JE426phnJmupQW8SEtbzWounxXhAYj9mXJex+JrjCo30Hbrc4/FW8V8mWV8yzox2Pir6DVYDwczEHPOSYStFRynOrqVlzKG9/8/3cjjsTeZ0JEXd4oa6YmYfu+/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPLnprjFxp5C9FYpa8wuZhKJAt2rTjRcuUsy7xx/XGg=;
 b=eU/61REqiKIXaX58DJymudOJPiF3cedV8ikOqEe6A8N5wdxGDtYgYlp8Z5M7C9sEDTj9U0v8wqaJuf7B4L2AS9N2PiBsD//xSx4mJfBs7fXhqtukz4eDvoF9Z7x1V/nslV4C3m8RHy48hxbWsM820n1eSVKho3sg25LeltIhyIFwdOIIPobGjOyjnXOHzAmkVJeqv4p1Rf3wOX+XU9b84ZCBi7Ig+/y0TgPH8pxPrCXY4BEN2Zc6uSAFa95YuK3qt0TDFsmSaD7iGXJxcU48UaIMNMo2AJpkNsSB/llk0P4q7aeXNFTRK3MC+QEyzKA1jM86DS7aX/I9wpNbkqckMw==
Received: from SN7PR04CA0180.namprd04.prod.outlook.com (2603:10b6:806:125::35)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 11:06:33 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::e6) by SN7PR04CA0180.outlook.office365.com
 (2603:10b6:806:125::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 11:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:06:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:06:25 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:06:18 -0800
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
Subject: [PATCH net-next 03/12] mlxsw: Add struct mlxsw_pci_rx_pkt_info
Date: Tue, 4 Feb 2025 12:04:58 +0100
Message-ID: <67e4b6dbb35d1e977b56e1a40e8227704ba353a3.1738665783.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 00016004-5e78-439e-90de-08dd450bfbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KcOWS+dmy5ibopCPr5YKbQQc3EY+ofw8cml3ctw/RQBZGGHOsrgOKWZid8Uv?=
 =?us-ascii?Q?/XBvQVSvU4UJFLYaDO5611Q1/Mzykg5nJ59OQJBuG+yoQpuQlcswAPHp9qUw?=
 =?us-ascii?Q?Zvfc8pFqI0HiLC0jnzMfF2XVhoOCdq5KC/QhEPyaalsHPpzXUlOlTTLPsH84?=
 =?us-ascii?Q?TpTlICbeDKaEcWeGQZOrYnS1ejYoPqFWrN2lYuFCm7IXlmijvt6gh46zZ4Eq?=
 =?us-ascii?Q?H1eRNPchOyAQ79pfhqZwGeAYNRaD01L6Lqed/u/lxnwMqlkDY0sba9JNygN2?=
 =?us-ascii?Q?9v2MqBXIT51SGLIIfQjfK/bxCgQSVi+11dARIjCx4HKUSzlBscvYEYMFxcp+?=
 =?us-ascii?Q?Xryl1p9+Mny/ytdkpit3IZB5Qwk61uo+fWUQPA7+gN3OOSGyqptLDJDxVJGE?=
 =?us-ascii?Q?JjLFKxG2w1nq5Y5zrKF+ukggHW0Vz20Ayi9GLp7OQ3NphexlGiO9kGjUkkUy?=
 =?us-ascii?Q?nTz2qBwrv9p0gzecR4VtwCFM83cZP9/2cJOccAdjtjew0k1/a4xg31aDC0mp?=
 =?us-ascii?Q?raxJ5T9ZCeHtHEDCwyHZPXm5Y5r9wYpMfLXDjtjXYzdoap6JC8f/c1JVDki7?=
 =?us-ascii?Q?HDt/yX1iABRaetdqg528/hpJ/JboVm9qQglLOeHtq2ZGF1XY527cDdQ6pgqU?=
 =?us-ascii?Q?2GIC/GujI4oqK1c+z2rcH/kOMIn5XOOnKeWvW4UAppjpnY2ewOnclsIySERb?=
 =?us-ascii?Q?wpNPo706BXHn0pAw4kYI6VUBskgozfckHiSnVOLpic/SGmgnSYp7X27lsG0M?=
 =?us-ascii?Q?6JzOrn0q+4Nt1/6cyvDU6ZVd4nDcjtPkOfiD00Kmo7UjAEaIqUniOvtItO2i?=
 =?us-ascii?Q?+UaEWbash09YeSbIe1zLn7JZzBS7d58DxfaNRdRGQ29V2gD6tr7/LXwPrMJ9?=
 =?us-ascii?Q?Qh6zEAPlnYYwx7G1KvOWG1B1DN4ujPWZoc8LK4GADPifcuhztr7J9xCFGm/A?=
 =?us-ascii?Q?65S3bvItgRd92dR6z7YF09q2kDLASVTmP4wWvusdtxCPi6bqqbAw5QTw5xA/?=
 =?us-ascii?Q?4SsoJpbb+BNA+/y1TGRTkRTj6F6/tRkN4KmHtj2HZlKq0EXQziAfs5KYBOc7?=
 =?us-ascii?Q?yiaYg5xX8TWJ5o8vBLLNNH9qW1UEgHSxDpS8MfNJxYHd1sCsbbOG/zoFHYYD?=
 =?us-ascii?Q?f89vOuSzA7GjcY9xE1BPeXzWj9F24aZ8Vl0JIOmviWkTRCXGXFTadqIwOwMR?=
 =?us-ascii?Q?KIxbG/O5RKmZ9oHA0awDN+mOCWP9zwc3SaRFJqE6KzWPKcRHvoSRsW5fre5a?=
 =?us-ascii?Q?cT9AA7Oaqh7WE92Ityd7yZZnUueKS7Ech2j+jgsoVBfYb5JbxwyGRaFpG/6z?=
 =?us-ascii?Q?Gl3M0fJ8LETQw9q2UDKXeUDTRGqFC71/5SG6tIa3JeCjnMpp8rNosFVBEiFp?=
 =?us-ascii?Q?9Se4BrrgiYU93giMoo5z0Ot0WW+BBYkhrb1F03RLSpuE5GdI6aMR6/n/Sw7e?=
 =?us-ascii?Q?sYgNg+yHuIqbxn8zUQsizlbJiED9mw8wSBnCuDJkbSUg5Bd5cNllbufkYAss?=
 =?us-ascii?Q?aqwlhYDdaBKoriY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:06:32.7655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00016004-5e78-439e-90de-08dd450bfbdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

From: Amit Cohen <amcohen@nvidia.com>

When Rx packet is received, given byte_count value from the CQE, we
calculate how many scatter/gather entries are used and the size of each
entry.

Such calculation is used for syncing the buffers for CPU and for building
SKB. When XDP will be supported, these values will be used also to create
XDP buffer.

To avoid recalculating number of scatter/gather entries and size of each
entry, add a dedicated structure to hold such info. Store also pointers
to pages. Initialize the new structure once Rx packet is received. This
patch only initializes the structure, next patches will use it.

Add struct mlxsw_pci_rx_pkt_info in pci.h as next patch in this set will
use it from another file.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c    | 57 +++++++++++++++++---
 drivers/net/ethernet/mellanox/mlxsw/pci.h    |  8 +++
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h |  1 -
 3 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 55ef185c9f5a..aca1857a4e70 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -390,6 +390,49 @@ static void mlxsw_pci_wqe_frag_unmap(struct mlxsw_pci *mlxsw_pci, char *wqe,
 	dma_unmap_single(&pdev->dev, mapaddr, frag_len, direction);
 }
 
+static u8 mlxsw_pci_num_sg_entries_get(u16 byte_count)
+{
+	return DIV_ROUND_UP(byte_count + MLXSW_PCI_RX_BUF_SW_OVERHEAD,
+			    PAGE_SIZE);
+}
+
+static int
+mlxsw_pci_rx_pkt_info_init(const struct mlxsw_pci *pci,
+			   const struct mlxsw_pci_queue_elem_info *elem_info,
+			   u16 byte_count,
+			   struct mlxsw_pci_rx_pkt_info *rx_pkt_info)
+{
+	unsigned int linear_data_size;
+	u8 num_sg_entries;
+	bool linear_only;
+	int i;
+
+	num_sg_entries = mlxsw_pci_num_sg_entries_get(byte_count);
+	if (WARN_ON_ONCE(num_sg_entries > pci->num_sg_entries))
+		return -EINVAL;
+
+	rx_pkt_info->num_sg_entries = num_sg_entries;
+
+	linear_only = byte_count + MLXSW_PCI_RX_BUF_SW_OVERHEAD <= PAGE_SIZE;
+	linear_data_size = linear_only ? byte_count :
+					 PAGE_SIZE -
+					 MLXSW_PCI_RX_BUF_SW_OVERHEAD;
+
+	for (i = 0; i < num_sg_entries; i++) {
+		unsigned int sg_entry_size;
+
+		sg_entry_size = i ? min(byte_count, PAGE_SIZE) :
+				    linear_data_size;
+
+		rx_pkt_info->sg_entries_size[i] = sg_entry_size;
+		rx_pkt_info->pages[i] = elem_info->pages[i];
+
+		byte_count -= sg_entry_size;
+	}
+
+	return 0;
+}
+
 static struct sk_buff *mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
 					       struct page *pages[],
 					       u16 byte_count)
@@ -470,12 +513,6 @@ static void mlxsw_pci_rdq_page_free(struct mlxsw_pci_queue *q,
 			   false);
 }
 
-static u8 mlxsw_pci_num_sg_entries_get(u16 byte_count)
-{
-	return DIV_ROUND_UP(byte_count + MLXSW_PCI_RX_BUF_SW_OVERHEAD,
-			    PAGE_SIZE);
-}
-
 static int
 mlxsw_pci_elem_info_pages_ref_store(const struct mlxsw_pci_queue *q,
 				    const struct mlxsw_pci_queue_elem_info *el,
@@ -486,8 +523,6 @@ mlxsw_pci_elem_info_pages_ref_store(const struct mlxsw_pci_queue *q,
 	int i;
 
 	num_sg_entries = mlxsw_pci_num_sg_entries_get(byte_count);
-	if (WARN_ON_ONCE(num_sg_entries > q->pci->num_sg_entries))
-		return -EINVAL;
 
 	for (i = 0; i < num_sg_entries; i++)
 		pages[i] = el->pages[i];
@@ -743,6 +778,7 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 				     u16 consumer_counter_limit,
 				     enum mlxsw_pci_cqe_v cqe_v, char *cqe)
 {
+	struct mlxsw_pci_rx_pkt_info rx_pkt_info = {};
 	struct pci_dev *pdev = mlxsw_pci->pdev;
 	struct page *pages[MLXSW_PCI_WQE_SG_ENTRIES];
 	struct mlxsw_pci_queue_elem_info *elem_info;
@@ -773,6 +809,11 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 		rx_info.local_port = mlxsw_pci_cqe_system_port_get(cqe);
 	}
 
+	err = mlxsw_pci_rx_pkt_info_init(q->pci, elem_info, byte_count,
+					 &rx_pkt_info);
+	if (err)
+		goto out;
+
 	err = mlxsw_pci_elem_info_pages_ref_store(q, elem_info, byte_count,
 						  pages, &num_sg_entries);
 	if (err)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.h b/drivers/net/ethernet/mellanox/mlxsw/pci.h
index cacc2f9fa1d4..74677feacbb5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.h
@@ -11,11 +11,19 @@
 #define PCI_DEVICE_ID_MELLANOX_SPECTRUM3	0xcf70
 #define PCI_DEVICE_ID_MELLANOX_SPECTRUM4	0xcf80
 
+#define MLXSW_PCI_WQE_SG_ENTRIES	3
+
 #if IS_ENABLED(CONFIG_MLXSW_PCI)
 
 int mlxsw_pci_driver_register(struct pci_driver *pci_driver);
 void mlxsw_pci_driver_unregister(struct pci_driver *pci_driver);
 
+struct mlxsw_pci_rx_pkt_info {
+	struct page *pages[MLXSW_PCI_WQE_SG_ENTRIES];
+	unsigned int sg_entries_size[MLXSW_PCI_WQE_SG_ENTRIES];
+	u8 num_sg_entries;
+};
+
 #else
 
 static inline int
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
index 6bed495dcf0f..83d25f926287 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
@@ -64,7 +64,6 @@
 #define MLXSW_PCI_EQE_COUNT	(MLXSW_PCI_AQ_SIZE / MLXSW_PCI_EQE_SIZE)
 #define MLXSW_PCI_EQE_UPDATE_COUNT	0x80
 
-#define MLXSW_PCI_WQE_SG_ENTRIES	3
 #define MLXSW_PCI_WQE_TYPE_ETHERNET	0xA
 
 /* pci_wqe_c
-- 
2.47.0


