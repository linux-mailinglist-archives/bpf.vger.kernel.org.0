Return-Path: <bpf+bounces-60724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC6FADB385
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F427A40EB
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51D627BF79;
	Mon, 16 Jun 2025 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YXd1E48G"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAE226B095;
	Mon, 16 Jun 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083373; cv=fail; b=cj9toWN2+yJY9H/VrI8M0lplR4k3HIKRvPDL9GDDdu1S8id0l5mmOuJuD6obDm/C1v4FYZ3Me6VGyTmo67YhqRkuJ25p1c2yFEjBU0jrhk8s5umiOOOMEdb1NyBIH9pQuP2nQe6svG8kSXYHKhguGLqpGC+PhFtW8dJJoF2VQIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083373; c=relaxed/simple;
	bh=IgPRg2Z6oPvS5AnDgfyZfrLCEfntAHIivx4D4Z0if20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9LQz7H98iAGQgfINsxOz8CvQzR1mdI11ZYn79ab90Ig6RkoQlSNYNVb0Cfwhxv+ayVOBmhssQDLBsfGnzWF/YRFVz2C7GFxgDuwCcJVy+sEfiAgg/m+hb3iwfAz9ub6zkwVPGLDqgKjQZ5tNzsk7mpqrCMCoHmQShXB4EFD8JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YXd1E48G; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8yHv3iIzAzIMHy/lOE9RbRlJ6G4CHFMIZ113NdjtMoneHXU2i7oUT+9LpyhFrpeX7gGinHzLgb/CtWBB5Y7ZfkaL05zlEzC4fxy0jXGvfbaXJOOVXKM0QLCpoZ1c/hzl/UmXRbQJH17toug3C/HFVfNYgtlB2yvl+XkxiwjtvTqgMVJjHiTbtL38A/Ndsx6pQxy8QNuQNBcSMvdSJTYkg+JwUwOZ6pe4fnPDUm7FA9jo5ePrGuaEj4j2acx3Ll8l9h6vZ/pthGygqu1vk4y/mMybZRkAXg53m4yNqrEY7ROcmyU9YoC3aDeb+YNxa1oswhicCnplrfr9iMVO0788Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eZS3AV9PNli/fxdufttwlf/CrH7qfP7WTjeuTTH4kM=;
 b=qQKFsMErZiDRMcw0z2YqoCVOhmk7P/eQgc+PNPTtLmV5ruKM3XoEG+CTBcSAvIXewZQIATAReIBAn9cn36PaW492NFIQjUlqRz/4pWNVJHxzQ/pLwhIZxKvQ3+wqDyEH6K1yFTKDgYoixDiAZvEWTdKqfAjRvNFGni9Rr9xUKqLl05hpFppi2jSfCAgbDhni1gMzwjvAI3JB1Rokq8o4OqvVYapZneuyzr7i/G/0x5TRUbbeo+QG5bC/HmkQW2e0/SMdurWaT7nBi/OL/FnMYZkgwTYerVNTpaq2+7QTmbYr/kOrpctL56C2A4aVGjoA8fzxz5DcU9EZHG0ZnJHJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eZS3AV9PNli/fxdufttwlf/CrH7qfP7WTjeuTTH4kM=;
 b=YXd1E48G3JGp92WB4c2zj1buYzrfk13Gvfh94wqtTIrin6a00zyut2tQYfVTrOcdaf2wcGyANO5Tp/YwRnCp4qaYBA8rz9R5Q4TWtyC1let0whYNMoZ66XdHXzcsJKs9RW7T87d89nD4ZGedgnBa+OE+Yss6zBnAFDFqW2sc/mm4IuqnQ6phiPgt9BiQu2KgIwbW/U0QqqbvEhszbmDr+cIf2bes03XdyBFEJ1oiAhI8imImTVC8xwYkOQhQAFmxb0nkDDNtLW7zJH5IptOvCuhlbMVQxlLw6+veetN3dwgjpw79wIimpuDDxheFolJLXly9I1UoXs2FDSa1370W6A==
Received: from CH2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:610:51::28)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 14:16:08 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::7b) by CH2PR15CA0018.outlook.office365.com
 (2603:10b6:610:51::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 16 Jun 2025 14:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:16:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:15:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:15:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:15:47 -0700
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
Subject: [PATCH net-next v6 08/12] net/mlx5e: Convert over to netmem
Date: Mon, 16 Jun 2025 17:14:37 +0300
Message-ID: <20250616141441.1243044-9-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 14023ab0-95d2-4315-7f72-08ddace05542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YhvTb6fgFTAkzCARKCT2YcQ8ldTTSWgvL10FDha9IxoCxNc0PaT4Xdc1YrHO?=
 =?us-ascii?Q?mrQUnFA67CDFn+WC0qgvoRIE9BGWgSHzYFaO1+ThoUYGfxQe5rx3rVjTh4ve?=
 =?us-ascii?Q?64zTmgGKMaeP/CICVmtY1YWDQVujuONG/TfOJ6ccVRE/YUsBHtK+PbXCFIIQ?=
 =?us-ascii?Q?8RjnISuIkSh2Li4UmdgICS+g+GkHKNpCQ3nOjukXwspnDa+uP+vFfaT3RCwJ?=
 =?us-ascii?Q?QtvQftPwR7Z/rZaKxu4awWMtyuId2laO1A9uIGmJvmmYIUoJaOO9qcduZVy5?=
 =?us-ascii?Q?1bkDTf5RJCdXaUWt9KSqWcVo3WIQNKw8uvYzdLQi6rQtgKJ1zij2XNa2nn++?=
 =?us-ascii?Q?381/cWNdfpYEHOEbJ28rWlu40zThS0B3ytCPCzhBVkZliVNYM0smLpA2ktb6?=
 =?us-ascii?Q?qyl3eheKS18NrmawROqikmL9L+xdpGn8AMDCnRVg+HX69wir5L9fOmQdgSNB?=
 =?us-ascii?Q?6d2jN9VZgQFoUY4AJBR7bsQeFRXHkCN0vx+U7zeJV6b08ZZwkTzzLG055lKE?=
 =?us-ascii?Q?c2A7TneoHCbm5DEqyNuvsGa6DlK8zF/QWHiAaq2CwDNiz5S925UniJVg7mac?=
 =?us-ascii?Q?LvpdcsO0FvaJRDmsz34JFoHXIYTs2tB0c9oK+y8QYxR0iu6u+XfUhB3AEn61?=
 =?us-ascii?Q?kPzMJCePcl3i6CWVWzB+hAvdntKmwO/yP5nJ5Zaptr6mySffBTezrxspSSPk?=
 =?us-ascii?Q?cIgeYLza3X8DAhA41895AEkYp1MbLE4oB8Z8sBRhrsAeFeTWu8XTQHcjjzWm?=
 =?us-ascii?Q?2bpr0Z4d3ELsvtiZNENMW/doxzjgdc0ptq+9+m5pTVKmOWXtqe4O31dPeVKu?=
 =?us-ascii?Q?II2JSbGW606MmUf0ixwTTCqp4B3CDuUJ6Gz7y301uaN7C+TtsTv3Bl213pD1?=
 =?us-ascii?Q?wwVYyS5XG4PqCkD+3CNqJWkosfuYTGQi9aSjpr25NGchC+wT6alZgoQImrnk?=
 =?us-ascii?Q?4wexyIKtY/fqx0WJdPGVzKT4MySJ0NRiLQlY3DYMeDkRswZ/SDkxJ2av2d1X?=
 =?us-ascii?Q?mux7LsamdN6QlomYRzJxUHRcoJ8qQO1/R3qnRUjUETXj+guzyUQKg2lRIpxW?=
 =?us-ascii?Q?aHWdbT0HbjSOwrw08lSIdZOfJHbr8tjMkPQrE7T1kELtpAiV5IMXhEeWB3Pe?=
 =?us-ascii?Q?2nK6bRfJqhegIgENzR8oXV6Juev0LqARlkc7tsB+lGxl3ChBjNUuYGqcIvdw?=
 =?us-ascii?Q?fqPffZ7uRa8N3UD9n2ZQ8rldr0On2KNDFfeIcnRVoCTOfnj+a22gm3QF8LGK?=
 =?us-ascii?Q?cq94Ff4MeYkTMTa/4f2nW3JOTLQL2mJsh0+dHAF56dQx2TMkx83g6xjEO0lP?=
 =?us-ascii?Q?BCuZVt1VLkMQVqq/SasWIJrxGwtKFdlsbWZsTy1wBqOirizfDmD7kdtSrgAO?=
 =?us-ascii?Q?MwKCcaiIM+eXspUYNk0k4O3ir2aLMgffgeGZT4Nn3h/kIWqmVdRPApf+ppnm?=
 =?us-ascii?Q?wY8A63k6ovW2kjMoEZeuM0RN0kbV3nGiFS6s7uflNipg4WN+ToaN5pJ3oYyv?=
 =?us-ascii?Q?d1Lex/LV2lOVz3tAIpzzqu7bWQqO+wv3ot9m?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:16:05.8066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14023ab0-95d2-4315-7f72-08ddace05542
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017

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
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 105 +++++++++++-------
 2 files changed, 63 insertions(+), 44 deletions(-)

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
index e34ef53ebd0e..2bb32082bfcc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -273,33 +273,32 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
 
 #define MLX5E_PAGECNT_BIAS_MAX (PAGE_SIZE / 64)
 
-static int mlx5e_page_alloc_fragmented(struct page_pool *pool,
+static int mlx5e_page_alloc_fragmented(struct page_pool *pp,
 				       struct mlx5e_frag_page *frag_page)
 {
-	struct page *page;
+	netmem_ref netmem = page_pool_dev_alloc_netmems(pp);
 
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
@@ -359,7 +358,7 @@ static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
 		frag->flags &= ~BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
 
 		headroom = i == 0 ? rq->buff.headroom : 0;
-		addr = page_pool_get_dma_addr(frag->frag_page->page);
+		addr = page_pool_get_dma_addr_netmem(frag->frag_page->netmem);
 		wqe->data[i].addr = cpu_to_be64(addr + frag->offset + headroom);
 	}
 
@@ -500,9 +499,10 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 			       struct xdp_buff *xdp, struct mlx5e_frag_page *frag_page,
 			       u32 frag_offset, u32 len)
 {
+	netmem_ref netmem = frag_page->netmem;
 	skb_frag_t *frag;
 
-	dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
+	dma_addr_t addr = page_pool_get_dma_addr_netmem(netmem);
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len, rq->buff.map_dir);
 	if (!xdp_buff_has_frags(xdp)) {
@@ -515,9 +515,9 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 	}
 
 	frag = &sinfo->frags[sinfo->nr_frags++];
-	skb_frag_fill_page_desc(frag, frag_page->page, frag_offset, len);
+	skb_frag_fill_netmem_desc(frag, netmem, frag_offset, len);
 
-	if (page_is_pfmemalloc(frag_page->page))
+	if (netmem_is_pfmemalloc(netmem))
 		xdp_buff_set_frag_pfmemalloc(xdp);
 	sinfo->xdp_frags_size += len;
 }
@@ -528,27 +528,29 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buff *skb,
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
 
@@ -685,7 +687,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		if (unlikely(err))
 			goto err_unmap;
 
-		addr = page_pool_get_dma_addr(frag_page->page);
+		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 
 		for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
 			header_offset = mlx5e_shampo_hd_offset(index++);
@@ -796,7 +798,8 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 		err = mlx5e_page_alloc_fragmented(rq->page_pool, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
-		addr = page_pool_get_dma_addr(frag_page->page);
+
+		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 		umr_wqe->inline_mtts[i] = (struct mlx5_mtt) {
 			.ptag = cpu_to_be64(addr | MLX5_EN_WR),
 		};
@@ -1216,7 +1219,7 @@ static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
 	u16 head_offset = mlx5e_shampo_hd_offset(header_index) + rq->buff.headroom;
 
-	return page_address(frag_page->page) + head_offset;
+	return netmem_address(frag_page->netmem) + head_offset;
 }
 
 static void mlx5e_shampo_update_ipv4_udp_hdr(struct mlx5e_rq *rq, struct iphdr *ipv4)
@@ -1677,11 +1680,11 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
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
@@ -1731,10 +1734,10 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 	frag_page = wi->frag_page;
 
-	va = page_address(frag_page->page) + wi->offset;
+	va = netmem_address(frag_page->netmem) + wi->offset;
 	frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
 				      rq->buff.frame0_sz, rq->buff.map_dir);
 	net_prefetchw(va); /* xdp_frame data area */
@@ -2007,13 +2010,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
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
@@ -2124,8 +2128,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
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
@@ -2155,11 +2159,11 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
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
@@ -2198,16 +2202,19 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
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
 
@@ -2232,7 +2239,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		}
 
 		net_prefetchw(skb->data);
-		mlx5e_copy_skb_header(rq, skb, frag_page->page, dma_addr,
+		mlx5e_copy_skb_header(rq, skb, frag_page->netmem, dma_addr,
 				      head_offset + rx_headroom,
 				      rx_headroom, head_size);
 		/* skb linear part was allocated with headlen and aligned to long */
@@ -2326,11 +2333,23 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
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
+			/* Drop packets with header in unreadable data area to
+			 * prevent the kernel from touching it.
+			 */
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
2.34.1


