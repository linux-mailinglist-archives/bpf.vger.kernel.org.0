Return-Path: <bpf+bounces-58766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CADCDAC161D
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB031C02DDD
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A4264620;
	Thu, 22 May 2025 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C4azvJBC"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8336E261589;
	Thu, 22 May 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950196; cv=fail; b=Ze5WTmx+WXtLy4sx7aoLL0hOFYyqMZfXFCN96OqMgbXmM7zwFfYC7ro/wFQPNatOOvk+6JTGnna90VFDwOxiFRDGPilW7lLE0Njpg6CFY1q0iJaEk0+hjY+cDA2+B6lCbghFOPN9SGClzxBvHjcGOztw3OSg+GHGDAm0lmdViQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950196; c=relaxed/simple;
	bh=do3GJW1FV/IgLX0DNOpuXeciKzMVS3HwRqoNFDnub50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/hGuBsQw4jnIaaV+GvqLXR4DnUpxCMHbfYO0GPbyX8r6uUr6xfP6ZURfRVOrTd5qmenpEdXhtZfH1cUq6WaQ+7EIAAJZZDlk3zoIuwFvxFdToilPfkfp9JkflIDQ/cXaD4bJwsm+fVFmjnNEBl/Qkv3JZZxIjpxz4txlsyZzU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C4azvJBC; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRsctBYv18Oj/eBnm9rKIfIMj4p3BdjkEWDhttLE7ULobecxdKj9pcY1s/5xiNKEFN5wUraZE+ALNuj59wc/rd5dzR1vwm98OsBoLKv7G4JKFSNfSNAmVbrx6Y2QgVa+hK/JBvNDu01JJKTkaNraDFS1JFA7fMRBsV/+8RKx35c44wxAYqNG+3NTxuSAMIjW0dtAaSbTXyVx8hGV03tTra205d7gFfP60bHrvjyJ0eWLewUSeFIqrLhJY7yNEVar18K+7p4gzNCWuxGdfMjjVg2XB09+wvek2P9Rw/qgSVQqf70cVYR5cwGcuEHMfyDLAu7SBDuBFFCKzskz8ukiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOkcfcF5EbqmXsXjndjUnMLK+FNHMRyaFxeoqPw5R/U=;
 b=FmQhqBJgNSePKMQUIsEd7RN9e24s435DrQ7AqZQxyNdUu92PdMdTiIWszoKuWQ/ovS0MZfmVp4RcetM5nzuFeYISjFonNZvePZTmq1ywMiYway5BCBJLUHz6zENwMGKY2PG5iWZjNP/Pl4tReUAjadkZ6agzdehwzLt7ChWdEq/O2h+trt4FRaXliu1YMX0g9vdfyhrtHpvJv+g88SDocNVvW0cIDNQXy0qGlhDNahs4IyU/x38wZY26VSLRH0ve69irGfUNVfjTeuQC7K09HWH+ce8/37EaeWM7kfccKLMSKnTfxs9/e0ifHNp0j1IgE99HZAd5l90y6UJ6YzacNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOkcfcF5EbqmXsXjndjUnMLK+FNHMRyaFxeoqPw5R/U=;
 b=C4azvJBCDwGKE11j05FjFjIt3uzXPJuoxee4vuY+c35Tv94NNjlBaIUS0QE8Uuky3MG+nrlH9PXXO6nCXuX2Ur9oyIpc/04/jA4Ma3oUFrJvWvEZ/MDL0PtohqRMf4VmCSIw5ATp9YRzoo7Z87i4i2rsnfaIK25pnQciz0ss9Y9oU1ZDZf0Ovp8GejErQJxdxvhIctud2vx/+hGsWrmzOlUsKJaAwvE0GcpRriff/rHP8uvs9+4D8wEYzTTX3KUi+ZyYszNrXm/VhgI08cj7kUKwg8ltBNJlHziOKXp1wtnA+hdziQidxz0KKJXFpKi92z3TheMj1+pMSFwjHZGQNA==
Received: from DS7P220CA0072.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::16) by
 CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 21:43:11 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::60) by DS7P220CA0072.outlook.office365.com
 (2603:10b6:8:224::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 21:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:43:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 14:43:00 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 14:42:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 14:42:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 08/11] net/mlx5e: Convert over to netmem
Date: Fri, 23 May 2025 00:41:23 +0300
Message-ID: <1747950086-1246773-9-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 303b0706-b777-4a87-f79c-08dd9979a618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FpOjHMZ8QM2z7uxMO2dJlTGn5oI313S2NIgFWPUxfd6yJQH0cMsrvtPrwPAt?=
 =?us-ascii?Q?bzaMNCnr0X5oydWb98mE8oPl5YdoeZhKgB07eGb2sfZcg9kJEO/tbNW1EUoN?=
 =?us-ascii?Q?bLMrtXvDcipyX54rbrS/o4DP2lJSVtjlEjN+FbbWcwKpfxYvKwwRSUm0O5Pm?=
 =?us-ascii?Q?vEGFgb6VhUJEdFEzltm/ymqEG2CrxhXCpuhT/aEDfj45uVRJ1JjLCN6ZhslF?=
 =?us-ascii?Q?0AThEA3mhOC4pMNIOtdF1ZCUXGshJjZ3gHqBB4GLDepeMTtzieDwfIB13yOM?=
 =?us-ascii?Q?oliYvqVCphAA+39wJ4FkAO8acLPR0MwklIES/ZeAsuzvwpxDJjKDyghIjrAc?=
 =?us-ascii?Q?sdD4r9m94xEbnSwlS5Yer3kYD0Gb4IM/Uk0eyiJB/356uMTutTr2nIP7nakq?=
 =?us-ascii?Q?XoNdpgW1SPGQTCM939j2i4gZ87jJD1q7kRrYJghQwOatSy4baHyRlcNkBmbW?=
 =?us-ascii?Q?MLs6RVlJU9dxB03Z3OicqUdUhSgmA2khcIXwqhblW8flIxZJ1XVzY+E09mqX?=
 =?us-ascii?Q?1XuvlvDA3SuDPXoGejPLUHqazHYrPjj88PIqSUolACFfQhSQz+fh8fcg91d3?=
 =?us-ascii?Q?b23XSzhfT+XjIngNqHNEYtI16PfWb8xVDlhbJpAwENFnMJoBi1tLhoaM4lZ+?=
 =?us-ascii?Q?Xudye0QmewRD2SvRKW2edcznDTL8d61S4S1Ewy2Tkv/GGY/4gVoqMafwg0n0?=
 =?us-ascii?Q?nmX4y53BkGrhT6dYeIoaf1BidIaUxi175LBimRgxmTEOT9XAZupzqo9cOTEj?=
 =?us-ascii?Q?YQbvLzQMMWTOodCtGY1HriZV8lfBTOswh3C1Dib3YocT4oxMouSDstSG3cbR?=
 =?us-ascii?Q?/RC0MfjI2jLUt0JxPV7l268GCblV098v37ucumX08UQG9rFsfN55lwpuS56L?=
 =?us-ascii?Q?so5jZZEPmjal5ueJOo0mdw1AL9FNz5NcxZaaBpinj0ugL/KvjYk+LbMSXRx+?=
 =?us-ascii?Q?UZe0GP5FWhBCoJfRNqSB+VCoD+JL4GGc3LLj5alAzT6B1pwEOax1E5DComcq?=
 =?us-ascii?Q?3KhWCcaYkwQlQ2L/6asUNG8FRW9pFOQny3/7cL09T7q17V7qwxUc9ygQHtSP?=
 =?us-ascii?Q?KJ7FIrHFvTovppq1+mCPgnChMxuZ6vtaLZjoTB9XGfMyWnoYqkvhgRVUpMWv?=
 =?us-ascii?Q?CUyeyaJmo5dB6bm6Ng9evKAMBU0ovrcQGz1AyaKh1CFgn8k8t0Dd1AWyhv2k?=
 =?us-ascii?Q?WpuSZQNBPWm45uZLndhaZHhuPKCL7k/mCVJ0dQ3pOCpFMNR6fFRGrBriYC9z?=
 =?us-ascii?Q?AKvPLNkeGnB+0+qlY1TP95pliES+deUk4zYyFZJOhOQae6ehkonMU4Dd/D1H?=
 =?us-ascii?Q?AlpU6tl9DGa3VyVqnHGToHcPhQEyxRXVCWgmSgR66Y3EUnlhrcvUKVRWPkJf?=
 =?us-ascii?Q?cRtEOML65m3W6PMj9x2VNg7w2iwJ9Qv+MFV2DdHoUbVCJbcGINKM0tGn4waU?=
 =?us-ascii?Q?/OPxxA0y5ZQyf8L7ewbflCPk+j6f6x0k75jio5HGRYJrR/c6WXEPcFquVsjw?=
 =?us-ascii?Q?3hZutSoKd/HWZQIqf2FPtjzDtauYK3uBHPdH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:43:11.1787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 303b0706-b777-4a87-f79c-08dd9979a618
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680

From: Saeed Mahameed <saeedm@nvidia.com>

mlx5e_page_frag holds the physical page itself, to naturally support
zc page pools, remove physical page reference from mlx5 and replace it
with netmem_ref, to avoid internal handling in mlx5 for net_iov backed
pages.

SHAMPO can issue packets that are not split into header and data. These
packets will be dropped if the data part resides in a net_iov as the
driver can't read into this area.

No performance degradation observed.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 103 ++++++++++--------
 2 files changed, 61 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index c329de1d4f0a..65a73913b9a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -553,7 +553,7 @@ struct mlx5e_icosq {
 } ____cacheline_aligned_in_smp;
 
 struct mlx5e_frag_page {
-	struct page *page;
+	netmem_ref netmem;
 	u16 frags;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index e34ef53ebd0e..75e753adedef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -273,33 +273,33 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
 
 #define MLX5E_PAGECNT_BIAS_MAX (PAGE_SIZE / 64)
 
-static int mlx5e_page_alloc_fragmented(struct page_pool *pool,
+static int mlx5e_page_alloc_fragmented(struct page_pool *pp,
 				       struct mlx5e_frag_page *frag_page)
 {
-	struct page *page;
+	netmem_ref netmem = page_pool_alloc_netmems(pp,
+						    GFP_ATOMIC | __GFP_NOWARN);
 
-	page = page_pool_dev_alloc_pages(pool);
-	if (unlikely(!page))
+	if (unlikely(!netmem))
 		return -ENOMEM;
 
-	page_pool_fragment_page(page, MLX5E_PAGECNT_BIAS_MAX);
+	page_pool_fragment_netmem(netmem, MLX5E_PAGECNT_BIAS_MAX);
 
 	*frag_page = (struct mlx5e_frag_page) {
-		.page	= page,
+		.netmem	= netmem,
 		.frags	= 0,
 	};
 
 	return 0;
 }
 
-static void mlx5e_page_release_fragmented(struct page_pool *pool,
+static void mlx5e_page_release_fragmented(struct page_pool *pp,
 					  struct mlx5e_frag_page *frag_page)
 {
 	u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
-	struct page *page = frag_page->page;
+	netmem_ref netmem = frag_page->netmem;
 
-	if (page_pool_unref_page(page, drain_count) == 0)
-		page_pool_put_unrefed_page(pool, page, -1, true);
+	if (page_pool_unref_netmem(netmem, drain_count) == 0)
+		page_pool_put_unrefed_netmem(pp, netmem, -1, true);
 }
 
 static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
@@ -359,7 +359,7 @@ static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
 		frag->flags &= ~BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
 
 		headroom = i == 0 ? rq->buff.headroom : 0;
-		addr = page_pool_get_dma_addr(frag->frag_page->page);
+		addr = page_pool_get_dma_addr_netmem(frag->frag_page->netmem);
 		wqe->data[i].addr = cpu_to_be64(addr + frag->offset + headroom);
 	}
 
@@ -500,9 +500,10 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 			       struct xdp_buff *xdp, struct mlx5e_frag_page *frag_page,
 			       u32 frag_offset, u32 len)
 {
+	netmem_ref netmem = frag_page->netmem;
 	skb_frag_t *frag;
 
-	dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
+	dma_addr_t addr = page_pool_get_dma_addr_netmem(netmem);
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len, rq->buff.map_dir);
 	if (!xdp_buff_has_frags(xdp)) {
@@ -515,9 +516,9 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 	}
 
 	frag = &sinfo->frags[sinfo->nr_frags++];
-	skb_frag_fill_page_desc(frag, frag_page->page, frag_offset, len);
+	skb_frag_fill_netmem_desc(frag, netmem, frag_offset, len);
 
-	if (page_is_pfmemalloc(frag_page->page))
+	if (!netmem_is_net_iov(netmem) && netmem_is_pfmemalloc(netmem))
 		xdp_buff_set_frag_pfmemalloc(xdp);
 	sinfo->xdp_frags_size += len;
 }
@@ -528,27 +529,29 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buff *skb,
 		   u32 frag_offset, u32 len,
 		   unsigned int truesize)
 {
-	dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
+	dma_addr_t addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	u8 next_frag = skb_shinfo(skb)->nr_frags;
+	netmem_ref netmem = frag_page->netmem;
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
 				rq->buff.map_dir);
 
-	if (skb_can_coalesce(skb, next_frag, frag_page->page, frag_offset)) {
+	if (skb_can_coalesce_netmem(skb, next_frag, netmem, frag_offset)) {
 		skb_coalesce_rx_frag(skb, next_frag - 1, len, truesize);
-	} else {
-		frag_page->frags++;
-		skb_add_rx_frag(skb, next_frag, frag_page->page,
-				frag_offset, len, truesize);
+		return;
 	}
+
+	frag_page->frags++;
+	skb_add_rx_frag_netmem(skb, next_frag, netmem,
+			       frag_offset, len, truesize);
 }
 
 static inline void
 mlx5e_copy_skb_header(struct mlx5e_rq *rq, struct sk_buff *skb,
-		      struct page *page, dma_addr_t addr,
+		      netmem_ref netmem, dma_addr_t addr,
 		      int offset_from, int dma_offset, u32 headlen)
 {
-	const void *from = page_address(page) + offset_from;
+	const void *from = netmem_address(netmem) + offset_from;
 	/* Aligning len to sizeof(long) optimizes memcpy performance */
 	unsigned int len = ALIGN(headlen, sizeof(long));
 
@@ -685,7 +688,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		if (unlikely(err))
 			goto err_unmap;
 
-		addr = page_pool_get_dma_addr(frag_page->page);
+		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 
 		for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
 			header_offset = mlx5e_shampo_hd_offset(index++);
@@ -796,7 +799,8 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 		err = mlx5e_page_alloc_fragmented(rq->page_pool, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
-		addr = page_pool_get_dma_addr(frag_page->page);
+
+		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 		umr_wqe->inline_mtts[i] = (struct mlx5_mtt) {
 			.ptag = cpu_to_be64(addr | MLX5_EN_WR),
 		};
@@ -1216,7 +1220,7 @@ static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
 	u16 head_offset = mlx5e_shampo_hd_offset(header_index) + rq->buff.headroom;
 
-	return page_address(frag_page->page) + head_offset;
+	return netmem_address(frag_page->netmem) + head_offset;
 }
 
 static void mlx5e_shampo_update_ipv4_udp_hdr(struct mlx5e_rq *rq, struct iphdr *ipv4)
@@ -1677,11 +1681,11 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 	dma_addr_t addr;
 	u32 frag_size;
 
-	va             = page_address(frag_page->page) + wi->offset;
+	va             = netmem_address(frag_page->netmem) + wi->offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
 				      frag_size, rq->buff.map_dir);
 	net_prefetch(data);
@@ -1731,10 +1735,10 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 	frag_page = wi->frag_page;
 
-	va = page_address(frag_page->page) + wi->offset;
+	va = netmem_address(frag_page->netmem) + wi->offset;
 	frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
 				      rq->buff.frame0_sz, rq->buff.map_dir);
 	net_prefetchw(va); /* xdp_frame data area */
@@ -2007,13 +2011,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
-		net_prefetchw(page_address(frag_page->page) + frag_offset);
+		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
 		if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool,
 							 &wi->linear_page))) {
 			rq->stats->buff_alloc_err++;
 			return NULL;
 		}
-		va = page_address(wi->linear_page.page);
+
+		va = netmem_address(wi->linear_page.netmem);
 		net_prefetchw(va); /* xdp_frame data area */
 		linear_hr = XDP_PACKET_HEADROOM;
 		linear_data_len = 0;
@@ -2124,8 +2129,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			while (++pagep < frag_page);
 		}
 		/* copy header */
-		addr = page_pool_get_dma_addr(head_page->page);
-		mlx5e_copy_skb_header(rq, skb, head_page->page, addr,
+		addr = page_pool_get_dma_addr_netmem(head_page->netmem);
+		mlx5e_copy_skb_header(rq, skb, head_page->netmem, addr,
 				      head_offset, head_offset, headlen);
 		/* skb linear part was allocated with headlen and aligned to long */
 		skb->tail += headlen;
@@ -2155,11 +2160,11 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		return NULL;
 	}
 
-	va             = page_address(frag_page->page) + head_offset;
+	va             = netmem_address(frag_page->netmem) + head_offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, head_offset,
 				      frag_size, rq->buff.map_dir);
 	net_prefetch(data);
@@ -2198,16 +2203,19 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 			  struct mlx5_cqe64 *cqe, u16 header_index)
 {
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
-	dma_addr_t page_dma_addr = page_pool_get_dma_addr(frag_page->page);
 	u16 head_offset = mlx5e_shampo_hd_offset(header_index);
-	dma_addr_t dma_addr = page_dma_addr + head_offset;
 	u16 head_size = cqe->shampo.header_size;
 	u16 rx_headroom = rq->buff.headroom;
 	struct sk_buff *skb = NULL;
+	dma_addr_t page_dma_addr;
+	dma_addr_t dma_addr;
 	void *hdr, *data;
 	u32 frag_size;
 
-	hdr		= page_address(frag_page->page) + head_offset;
+	page_dma_addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
+	dma_addr = page_dma_addr + head_offset;
+
+	hdr		= netmem_address(frag_page->netmem) + head_offset;
 	data		= hdr + rx_headroom;
 	frag_size	= MLX5_SKB_FRAG_SZ(rx_headroom + head_size);
 
@@ -2232,7 +2240,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		}
 
 		net_prefetchw(skb->data);
-		mlx5e_copy_skb_header(rq, skb, frag_page->page, dma_addr,
+		mlx5e_copy_skb_header(rq, skb, frag_page->netmem, dma_addr,
 				      head_offset + rx_headroom,
 				      rx_headroom, head_size);
 		/* skb linear part was allocated with headlen and aligned to long */
@@ -2326,11 +2334,20 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	}
 
 	if (!*skb) {
-		if (likely(head_size))
+		if (likely(head_size)) {
 			*skb = mlx5e_skb_from_cqe_shampo(rq, wi, cqe, header_index);
-		else
-			*skb = mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe, cqe_bcnt,
-								  data_offset, page_idx);
+		} else {
+			struct mlx5e_frag_page *frag_page;
+
+			frag_page = &wi->alloc_units.frag_pages[page_idx];
+			if (unlikely(netmem_is_net_iov(frag_page->netmem)))
+				goto free_hd_entry;
+			*skb = mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe,
+								  cqe_bcnt,
+								  data_offset,
+								  page_idx);
+		}
+
 		if (unlikely(!*skb))
 			goto free_hd_entry;
 
-- 
2.31.1


