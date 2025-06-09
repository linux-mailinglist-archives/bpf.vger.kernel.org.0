Return-Path: <bpf+bounces-60061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEC7AD21D4
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551AF18921C8
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49C221546;
	Mon,  9 Jun 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YPdn8kF3"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A7C220F2F;
	Mon,  9 Jun 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481209; cv=fail; b=gx4fJ6nFRzFHyuLDHNz+NTLRsSbXHABS1cHbJqTFULAgrbajnDzLv7GO23KotkfoG0fT9RxdqfCOU/6OojW0FJdHncwtDzrtD4CUmzo706IrlguUeknckOraL+L9yg0oAk9o4t4fk9NA4bYnq/4c/UtW6LBM0N+6wqC1sIZi3/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481209; c=relaxed/simple;
	bh=fENsorai1v9CegEHC0FZSBz9oTM06yXxUcUA2Zvj1gM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7mqr0mwDEXalxWr5Qq0zqOiT1GmHugfn+FG8JHsNbC0uH2sLvZslik9Fds8by2muqLtyRxBe06zKibsbs3/wjISNZ6LeQLa3JPTmYCDmhPsv8GCYL4gF2PfAJFKVwyXG2WOM6flWnF9pbmEPD+L5VdNO7X6cqtmJoxDdNU5bkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YPdn8kF3; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNWwAQlzL8Po3ar/PGY6WVIzAZi7ro+BHxCN8swZEXezmE/fT7G/h2wT4RDkNugosJOTimAHo1yo9qH9iS+eQWUM9QjXAB/v+1jgGWZHPWlqzSXtUxhyHZVBNT82OIgBpCW9YcfOnZvkQmFPHh/Nj4c+MMvubNGkUb7LGS3+QCfvi40NhL2bnOnUcIzeIcxWXd1jH4NkJO3tjVHiOflKbrl6zDNjn3vG+l/nGnAXHC6BvvhDS0C6Npaq1OH08rzzngNqBPt6dXyqlaiv2GoaIlCoxGl7mSduk7ZTXDNJ3ZWof93LL4NG4XHUoELEWgdt7wjj/Vvhq6FRlM+jItqunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J77UU0NU34bHgxDj/1sh2/Zc3iGqgzJOs+pMgPFdVaM=;
 b=jXbGT+/fuWCl8QcFwB+R5dRsE60yt2bXzMnqRjd7t29r9h29tuRviM+zy3o9gBmrMdgCP/oxbC++CBa9gmRkHfr0t1Y7WHb6xpp7xwqCOPb8/jnwXRF/PPMhUmJqDOvj/S0HE1vi5eVnYQvSNTAbGY9LfLywEK4zzXgo1Pur0JxsDIvlExp0GsV9PNUjpKtcK/ix9S03toB9eIaktbqjjwLW2gFzZd/DAfQ/14AKJtFEBIHIVQ7kprGIVH4Z3vVmbnJWhwFFJfYV7Wz7c+zHyiZ2isg/KwE/+YDecoLFqdMwxi4myRMKo0vBEfOvK7WpCZAeSnJPMyU6FaFv3W7pmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J77UU0NU34bHgxDj/1sh2/Zc3iGqgzJOs+pMgPFdVaM=;
 b=YPdn8kF3Iaem6wzCvxPHivXmFiZlfuwUITbwuLc6oGSIPAf6xlF9qbGR+BrVK/R7tPkP6zWgtzsjjcP0Yt9ks1wQLnS9qTmJ+4D04QzTHYGExdN4Ze6dlYl96+mVihR+ENGc408DoIDHgony/F68rSI+PKDxSgpEpbAMTO0Rv740i145q0m5qfrnwqSiyfhqgoZ1z4zob5Zs+l3LB3G56pIiTuIJ5TWKQjDsVegdNSI68Hk9asO0SmU1RnwAp/A9Aao+8TA/vAUlvO+BLnt0mXm9wUMsMh4RKfqhgYEXCLhrUyaXaw9nHsZTJur23vx0v7UJuXqNYHoXEquWsU/pSQ==
Received: from SJ0PR03CA0125.namprd03.prod.outlook.com (2603:10b6:a03:33c::10)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Mon, 9 Jun
 2025 14:59:56 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::2e) by SJ0PR03CA0125.outlook.office365.com
 (2603:10b6:a03:33c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Mon,
 9 Jun 2025 14:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 14:59:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:59:41 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:59:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 07:59:35 -0700
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
Subject: [PATCH net-next v3 08/12] net/mlx5e: Convert over to netmem
Date: Mon, 9 Jun 2025 17:58:29 +0300
Message-ID: <20250609145833.990793-9-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f4de2c-453c-4918-282b-08dda7664c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9YqiA/ePU2DsGjlRPNkFUS4yZ93uJjWwnvq7q5HIYKSyV7TZEBa7x3vzNONb?=
 =?us-ascii?Q?Ur+dAIFcXxfRIcWRdYT47BoRneho2t94D+Zm7oIn+4jfTa9eenkUCyrpnelg?=
 =?us-ascii?Q?luGWYQdqHj7TEtiJsVWTFPpkWDQ0zBVKSquvVGRS88cGto6PMMY2oZn/sX5A?=
 =?us-ascii?Q?KsT1lJ1vK6IBUrVgMtrSJh0ZsXGV/0qta/ICDdqZp3PPezQfUDF6FPp85KKa?=
 =?us-ascii?Q?F9CjPMC6buMtM9L1GUW1xePLey/rIfH7INjDSCVQhBqOBWNjg46cdkclVjoQ?=
 =?us-ascii?Q?8Pa/Wp2qA3vRIioELSzZl8A2XwsGmLMuKSYqTPjVxGY++tWYmm1XESsl8QGe?=
 =?us-ascii?Q?lhhoSf28/9rOYU6IFL9c0wqOWjjifuec7AwKsl8FSakyXJzKuHr0HzHdyF0O?=
 =?us-ascii?Q?P4Y2ZhTc+7YkKsckkdlInRS/s6T+oZZWbmchzOGdNfwYOek6guuMS4Gnm+t7?=
 =?us-ascii?Q?kQK2ZVrjzt2rDvqieyfE1RrI4IwqKLYeCsN4KkWjxWgowrGybDJ4GwS/Slxo?=
 =?us-ascii?Q?y4hQLElYDPEF4J4EHbbmjGGaebRXuHt6Fx3iIGr8Rj/kN01kNB02mmy1PWCQ?=
 =?us-ascii?Q?65UUvgzVIFb8PE4LpDTLminzZ9hARnZY14h83fG/09Kp/N9J9oTf7U5/cxH2?=
 =?us-ascii?Q?IMVGzgkemyO8Ui+khzqMUrbax8lKU/9ZQ0p4CWo3ixOyee/N64BMdfwj2Wj0?=
 =?us-ascii?Q?pl9U7rGotq7BrUu3ZrTQmJLfKWqwDqw8ZsPc8ukIWq/HPdHhdEu+VmEDdzFA?=
 =?us-ascii?Q?dcUPEpSysXtmK2+3OnT2wurbQf0AeQXWfqZlR+q38TA5Vn++OWFOBxoE2Wbm?=
 =?us-ascii?Q?/P8HczdZZ9+fPsXL/LiaTtZSEEpmVZkZfXKV0YGSDPqyGb3c47tv64KcL2Ud?=
 =?us-ascii?Q?nIEMZECy+IBZohE0appYWeKTJaZIFZuc0sMelSqiXFyJG5FCWecvmq1SVJu6?=
 =?us-ascii?Q?ZZjLLUVPm4VwG5iTEa5TaBAGY9+Y2qQKA9oQHIU9bAfk4PhhuF+hHWgd2pX1?=
 =?us-ascii?Q?tfpFQbVHgWlGXE+IIauJlTkIfsSyvAoh91WABiRT/9NBAbDtXteorCSvsvfb?=
 =?us-ascii?Q?Z+2crev+wtImmBGwC1XW23gVgFAKzWbfWGOiuVEI2WU+Ps8mj89GV9pK9IER?=
 =?us-ascii?Q?zE1+RKseYLMCib1plN0C/5FVgy30gSUjLC2T5ovrhEsuOg3Ud4K/8sSZWT5s?=
 =?us-ascii?Q?yyQ+w7b+r/sdrVFYG8VA2ET3HurN2t3ZkgVxSkKqEAA4vIRnq0aZfSNVlg/l?=
 =?us-ascii?Q?SodsxVGVLG9y7h0WpXL132tTjCg6Wq9lB2yt6+e/r9DJjq/yJLO5N6Xp9s/L?=
 =?us-ascii?Q?2hCNLIJk/5gBAlqbjzGdctFs03gudmreSCe8/aIG/leYtkgPA4swM6O9prwa?=
 =?us-ascii?Q?ZTCVhmtd2Vx77n3u+kveq5Ks/Ck5HztC1YTundKMW3FPn/vq03ke23xaXk+s?=
 =?us-ascii?Q?0+j+ZIKLGc1z3/vUv17Fhms6NAjttotcZtH4fzqWrLtv4JbeCTfzStGpc/3f?=
 =?us-ascii?Q?bHB96Ne9olGnmruFCM5kONwR1ZdbMdwKG4/0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:59:56.5118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f4de2c-453c-4918-282b-08dda7664c60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783

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
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
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
2.34.1


