Return-Path: <bpf+bounces-60479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B017AD770E
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1A6164A92
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF5B2C0334;
	Thu, 12 Jun 2025 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L4n8CPrL"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A729A9E4;
	Thu, 12 Jun 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743294; cv=fail; b=YDQ5nAHoNJvPYufi691zZ1DaGyoRzbrmNJHJ1Z7OZ7lIOeX/x2kB2LvsOI14wkARbhnZ5Jq/N83o2oz7f8f1QAYhOH6zo1cOnMFF48ehP9M2w05RAsjkmGfuD+xBvyhlTCKlL/20j/ZZIkjwUnLmTrnfvXLpTc1dzIpovQJRr2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743294; c=relaxed/simple;
	bh=udq+3o5ZtYamRoeM1huBcSpYT2n1uJTiwgb8yhgZkg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOqg3SUVkVvXvhrC5foleq0tH6gg07qjB0Y1sQnN/S/ZruQdMVJO9lUFtnV2vHtKSjr66He7ofF0IYkiWL8pm1uPXetB/VKa6iidOrmVgdS62nZz4OunK/ZX47ozyHOwjuUwM1GdXPWE04Tj3xdlD9EHoP5OVb94bwkCYIEav+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L4n8CPrL; arc=fail smtp.client-ip=40.107.96.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEpbCqYa9/TrLeuT8c6uc6M0EkTLmg386tyLlDv/Imp+9MfpMj5SseYGqQUIx+to+iJlnNqBXupDwce7JyDby/fdLVhfSQdshf1q+H2bGwe5CBVJEjsdfPqNX1pj6f+x4KVfyHJd2Zg4EouUTGc89CCOM5XK4FxG3uulSjU4d2/RlOc5XEHjYZ6WCffe8ZVGVO+LMXcAady80cZ/I2tq1+ct3JdE/pLtV71sIk4g2SrVN0By64d/g3Ncz3eGQAQ6dxY8Z7xnXfXMUuwCkRkP29GRlWmr92Z2fSUJ31N0+D6DU8hYTFXNc14D2mhX9TyWOH4leZ/koacgGYKa6dHWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsH3dcWUuviSyLvD16PIq0Dl8w+NXzoh610l+FCu6N4=;
 b=UIFuo0rsNni+7Y9E3dklB0KF3Q5yhN5LA+dGKcIAh7aXC9foMxeCzNNgptf/gJAAh7Fnb+ZJh4R6cJwcQVrFwaVIBrrzsJSjyc4LUaPOuUqzLLqS3e7L2zK5cvebYTV9WCSjeYX2KiB7B3zYGUFUZcEjpPYJwBAtEEePh68buFNdaoreUzgGXlMOUueJBYCmQ2YvfRDOCQ9nxfD4EMChjxQsa3vJzJtMqJOg/R7LkqNnQ1rHa7ZZfmUByv4fDC1TakduXKXYQpy4OIRMKejdOfukcKEHnxXVON6hYuUwnqCU8uCHQWDHzq9Ls/HpXxiOHq2Nd+Jjjk2VpLQoElN2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsH3dcWUuviSyLvD16PIq0Dl8w+NXzoh610l+FCu6N4=;
 b=L4n8CPrLJslPRVkTE8K6jERQKk7YVn3awV3EHqTjI4zy0+4W2O00c/qcSxdyHlHcyCNbwZIYbk3Fx9mgxWYsI6m4nGKSyf4JJ+5J/sbGSR0UIt8ObYPeKaCtxBgqa2NYijfJK13ebO8Twz+4A+90EM5TuzrgHSZBIMNqc4HZnztLkak9sdIWC4D7yxXEcdefRh08UhqwQQF6z0YuRriPXAxuN5XUmlbqMGO+KCcjxqoicMqv1la8QIV9YhDg0B3gQpNbELP5Fo5g6uYP0rfCrLZq+j0AIFgM9gSVdtxVFeNB7DSetFd2wJ88Se1+QzkpAh5j+HrTuirNijU1RMgEOw==
Received: from CH0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:b0::19)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Thu, 12 Jun
 2025 15:48:09 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::96) by CH0PR03CA0014.outlook.office365.com
 (2603:10b6:610:b0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 12 Jun 2025 15:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:48:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 08:47:48 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 08:47:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 12
 Jun 2025 08:47:42 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v5 07/12] net/mlx5e: SHAMPO: Separate pool for headers
Date: Thu, 12 Jun 2025 18:46:43 +0300
Message-ID: <20250612154648.1161201-8-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612154648.1161201-1-mbloch@nvidia.com>
References: <20250612154648.1161201-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: e766b0f5-0bcd-4432-4aef-08dda9c88774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OGtvIt/hbGb1rNkx8xYNUWNXXyM3xJFfQJKNlPMQudo2zivE+vhz5s2BRVd/?=
 =?us-ascii?Q?7yxC+2IuZ2fv9I/KBhV9TaY5NbUzEo0mYGc6tScvuuEA/G0LnXwIphZ4NNTZ?=
 =?us-ascii?Q?aS7ZZ0aY7K3z3+goXfmLHd7YNUWhmF9MCNHvfk2mjJCukaJmSxZI3wjCwN/e?=
 =?us-ascii?Q?OAaFQsyNDcg4AEmRyjG1GN8QlLdyTkqzC9nMsRGJJUkFbrrB8NvMm8TKdqKv?=
 =?us-ascii?Q?iaJ2PUy2F42udN7AnsDz0nrqUpum139tUdMWtg/xfKG/Ld1+55Nmmk6ol8xm?=
 =?us-ascii?Q?FVdZ9Wuz19sDYbnDL1eW0pFonJKFUN5Z2YfuDHyOyx6cTZZJkSoALMRkGHmd?=
 =?us-ascii?Q?0qdJ1z5z9I94GVYGOd/Vy/JRvwQ9pHEyC4bty8z4IDeAmZhG0FV2xWDmr7e9?=
 =?us-ascii?Q?nv9ir17gHvEf2KSB5AiJ/sRXCsvfhHovRewOP8d9ZA5vm7a32D/1lx6bvucp?=
 =?us-ascii?Q?DBEwF5nUIuAu+4SzzBkDYPwzjLVuRGNoTOeOLcTrT6uthNBqUyonXtAr7Yl8?=
 =?us-ascii?Q?p0wbHuZnusHcVOU7/Wd8kyKEvaOFnLhnbrQVvF/sIGeIu9UV4flMDuyf/3wp?=
 =?us-ascii?Q?MEPP7pMFT4QsLrNXkA81qJ7bLequgwe/mZMN+4yjKX7LPXleWRA+YPoIPj4m?=
 =?us-ascii?Q?9KfSY4vMJf1QcAt4dae8J5zSVucg24HUgfbTGKGB8wcok2G+3kl/81CR5oN8?=
 =?us-ascii?Q?tO+VdD8ho5cuEox+g38sGWV/2C0blFsiseC7j3guB6a36ScniFsK7JEaFXKI?=
 =?us-ascii?Q?0R5lcLD+O0y4o/J4h8NG4DKzyOdEtZQpEv5J0hJM+gieptsk6J+6ZVzSen0i?=
 =?us-ascii?Q?9I3RMxc90FcfpfkTMKxvFu7Bs4DkEwhHMuhxKbaVeSbYaAEDgUi4SKDvmhg7?=
 =?us-ascii?Q?Kls+5Nh+fqstZVXM7fiMeTWV4fsydy0mTEbncX4SWS4cP6V9Vdf3b5AYh9Y0?=
 =?us-ascii?Q?aLNghbbpEa2/AnNSMnPZ0Cf+fFRz2/Rzgo7oZC6ulzt+YfpvNHDBEpdSwHgP?=
 =?us-ascii?Q?QFOKvu/Eqal4oT60KyQon5wR1VpxIUUQ+GZjhcwHFMKzHMfpSOKLLYpqvv9V?=
 =?us-ascii?Q?3tw8U5GWUvecdIbXaeQLOZJCvIUI+ZyOg9MeN8tolTJNqreYqh7lEg1JzPlh?=
 =?us-ascii?Q?+aVcKay4xauGEr1tMppPDQGBlpUyndvXXY/fEWxFIPOdCWe5P9DSAqk38KJG?=
 =?us-ascii?Q?MoUHK5lUxcAqQXfQvRAGMiXJ8/zfpJeQ76zI84XGv+lRR06fIY2I6WjvSEJ0?=
 =?us-ascii?Q?Gj93pMpkAP+k6Z0YNaVoF2+iXrK1EZuiTRHcvk3zkMt6qwFcI476s9SW6YQE?=
 =?us-ascii?Q?HN0BWEied72uZR/avus1rYNtISKxdoIlgd1sS18lnAg/iQ8xMUe2wUpIZtIa?=
 =?us-ascii?Q?LVKZY8fxOKjNF/jUVisN+xAkSlf+Idhnys12fR1t5lnPM4SLXTHu3Ij3R4lK?=
 =?us-ascii?Q?74q/4jsD959YLVegYbthIIndZ43Pbnzwx7AA+lHN6zonI6wLdtCTCOebY7XP?=
 =?us-ascii?Q?6EATHSeLNq5qdKn0n7TOpAO2lt2hVRlCik65?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:48:08.5997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e766b0f5-0bcd-4432-4aef-08dda9c88774
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986

From: Saeed Mahameed <saeedm@nvidia.com>

Allow allocating a separate page pool for headers when SHAMPO is on.
This will be useful for adding support to zc page pool, which has to be
different from the headers page pool.
For now, the pools are the same.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 43 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 41 ++++++++++--------
 3 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 581eef34f512..c329de1d4f0a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -716,7 +716,11 @@ struct mlx5e_rq {
 	struct bpf_prog __rcu *xdp_prog;
 	struct mlx5e_xdpsq    *xdpsq;
 	DECLARE_BITMAP(flags, 8);
+
+	/* page pools */
 	struct page_pool      *page_pool;
+	struct page_pool      *hd_page_pool;
+
 	struct mlx5e_xdp_buff mxbuf;
 
 	/* AF_XDP zero-copy */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a81d354af7c8..5e649705e35f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -41,6 +41,7 @@
 #include <linux/filter.h>
 #include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 #include <net/page_pool/types.h>
 #include <net/pkt_sched.h>
 #include <net/xdp_sock_drv.h>
@@ -746,6 +747,11 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
 	bitmap_free(rq->mpwqe.shampo->bitmap);
 }
 
+static bool mlx5_rq_needs_separate_hd_pool(struct mlx5e_rq *rq)
+{
+	return false;
+}
+
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params,
 				struct mlx5e_rq_param *rqp,
@@ -754,6 +760,7 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				int node)
 {
 	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
+	u32 hd_pool_size;
 	u16 hd_per_wq;
 	int wq_size;
 	int err;
@@ -781,8 +788,34 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	rq->mpwqe.shampo->hd_per_wqe =
 		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
 	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
-	*pool_size += (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
-		     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+	hd_pool_size = (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
+		MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+	if (mlx5_rq_needs_separate_hd_pool(rq)) {
+		/* Separate page pool for shampo headers */
+		struct page_pool_params pp_params = { };
+
+		pp_params.order     = 0;
+		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pp_params.pool_size = hd_pool_size;
+		pp_params.nid       = node;
+		pp_params.dev       = rq->pdev;
+		pp_params.napi      = rq->cq.napi;
+		pp_params.netdev    = rq->netdev;
+		pp_params.dma_dir   = rq->buff.map_dir;
+		pp_params.max_len   = PAGE_SIZE;
+
+		rq->hd_page_pool = page_pool_create(&pp_params);
+		if (IS_ERR(rq->hd_page_pool)) {
+			err = PTR_ERR(rq->hd_page_pool);
+			rq->hd_page_pool = NULL;
+			goto err_hds_page_pool;
+		}
+	} else {
+		/* Common page pool, reserve space for headers. */
+		*pool_size += hd_pool_size;
+		rq->hd_page_pool = NULL;
+	}
 
 	/* gro only data structures */
 	rq->hw_gro_data = kvzalloc_node(sizeof(*rq->hw_gro_data), GFP_KERNEL, node);
@@ -794,6 +827,8 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	return 0;
 
 err_hw_gro_data:
+	page_pool_destroy(rq->hd_page_pool);
+err_hds_page_pool:
 	mlx5_core_destroy_mkey(mdev, rq->mpwqe.shampo->mkey);
 err_umr_mkey:
 	mlx5e_rq_shampo_hd_info_free(rq);
@@ -808,6 +843,8 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 		return;
 
 	kvfree(rq->hw_gro_data);
+	if (rq->hd_page_pool != rq->page_pool)
+		page_pool_destroy(rq->hd_page_pool);
 	mlx5e_rq_shampo_hd_info_free(rq);
 	mlx5_core_destroy_mkey(rq->mdev, rq->mpwqe.shampo->mkey);
 	kvfree(rq->mpwqe.shampo);
@@ -939,6 +976,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 			rq->page_pool = NULL;
 			goto err_free_by_rq_type;
 		}
+		if (!rq->hd_page_pool)
+			rq->hd_page_pool = rq->page_pool;
 		if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
 			err = xdp_rxq_info_reg_mem_model(&rq->xdp_rxq,
 							 MEM_TYPE_PAGE_POOL, rq->page_pool);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 84b1ab8233b8..e34ef53ebd0e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -273,12 +273,12 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
 
 #define MLX5E_PAGECNT_BIAS_MAX (PAGE_SIZE / 64)
 
-static int mlx5e_page_alloc_fragmented(struct mlx5e_rq *rq,
+static int mlx5e_page_alloc_fragmented(struct page_pool *pool,
 				       struct mlx5e_frag_page *frag_page)
 {
 	struct page *page;
 
-	page = page_pool_dev_alloc_pages(rq->page_pool);
+	page = page_pool_dev_alloc_pages(pool);
 	if (unlikely(!page))
 		return -ENOMEM;
 
@@ -292,14 +292,14 @@ static int mlx5e_page_alloc_fragmented(struct mlx5e_rq *rq,
 	return 0;
 }
 
-static void mlx5e_page_release_fragmented(struct mlx5e_rq *rq,
+static void mlx5e_page_release_fragmented(struct page_pool *pool,
 					  struct mlx5e_frag_page *frag_page)
 {
 	u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
 	struct page *page = frag_page->page;
 
 	if (page_pool_unref_page(page, drain_count) == 0)
-		page_pool_put_unrefed_page(rq->page_pool, page, -1, true);
+		page_pool_put_unrefed_page(pool, page, -1, true);
 }
 
 static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
@@ -313,7 +313,8 @@ static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
 		 * offset) should just use the new one without replenishing again
 		 * by themselves.
 		 */
-		err = mlx5e_page_alloc_fragmented(rq, frag->frag_page);
+		err = mlx5e_page_alloc_fragmented(rq->page_pool,
+						  frag->frag_page);
 
 	return err;
 }
@@ -332,7 +333,7 @@ static inline void mlx5e_put_rx_frag(struct mlx5e_rq *rq,
 				     struct mlx5e_wqe_frag_info *frag)
 {
 	if (mlx5e_frag_can_release(frag))
-		mlx5e_page_release_fragmented(rq, frag->frag_page);
+		mlx5e_page_release_fragmented(rq->page_pool, frag->frag_page);
 }
 
 static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
@@ -584,7 +585,8 @@ mlx5e_free_rx_mpwqe(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi)
 				struct mlx5e_frag_page *frag_page;
 
 				frag_page = &wi->alloc_units.frag_pages[i];
-				mlx5e_page_release_fragmented(rq, frag_page);
+				mlx5e_page_release_fragmented(rq->page_pool,
+							      frag_page);
 			}
 		}
 	}
@@ -679,11 +681,10 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
 		u64 addr;
 
-		err = mlx5e_page_alloc_fragmented(rq, frag_page);
+		err = mlx5e_page_alloc_fragmented(rq->hd_page_pool, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
 
-
 		addr = page_pool_get_dma_addr(frag_page->page);
 
 		for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
@@ -715,7 +716,8 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		if (!header_offset) {
 			struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
 
-			mlx5e_page_release_fragmented(rq, frag_page);
+			mlx5e_page_release_fragmented(rq->hd_page_pool,
+						      frag_page);
 		}
 	}
 
@@ -791,7 +793,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	for (i = 0; i < rq->mpwqe.pages_per_wqe; i++, frag_page++) {
 		dma_addr_t addr;
 
-		err = mlx5e_page_alloc_fragmented(rq, frag_page);
+		err = mlx5e_page_alloc_fragmented(rq->page_pool, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
 		addr = page_pool_get_dma_addr(frag_page->page);
@@ -836,7 +838,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 err_unmap:
 	while (--i >= 0) {
 		frag_page--;
-		mlx5e_page_release_fragmented(rq, frag_page);
+		mlx5e_page_release_fragmented(rq->page_pool, frag_page);
 	}
 
 	bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
@@ -855,7 +857,7 @@ mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index)
 	if (((header_index + 1) & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) == 0) {
 		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
 
-		mlx5e_page_release_fragmented(rq, frag_page);
+		mlx5e_page_release_fragmented(rq->hd_page_pool, frag_page);
 	}
 	clear_bit(header_index, shampo->bitmap);
 }
@@ -1100,6 +1102,8 @@ INDIRECT_CALLABLE_SCOPE bool mlx5e_post_rx_mpwqes(struct mlx5e_rq *rq)
 
 	if (rq->page_pool)
 		page_pool_nid_changed(rq->page_pool, numa_mem_id());
+	if (rq->hd_page_pool)
+		page_pool_nid_changed(rq->hd_page_pool, numa_mem_id());
 
 	head = rq->mpwqe.actual_wq_head;
 	i = missing;
@@ -2004,7 +2008,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
 		net_prefetchw(page_address(frag_page->page) + frag_offset);
-		if (unlikely(mlx5e_page_alloc_fragmented(rq, &wi->linear_page))) {
+		if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool,
+							 &wi->linear_page))) {
 			rq->stats->buff_alloc_err++;
 			return NULL;
 		}
@@ -2068,7 +2073,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 				wi->linear_page.frags++;
 			}
-			mlx5e_page_release_fragmented(rq, &wi->linear_page);
+			mlx5e_page_release_fragmented(rq->page_pool,
+						      &wi->linear_page);
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
@@ -2077,13 +2083,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
 			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
-			mlx5e_page_release_fragmented(rq, &wi->linear_page);
+			mlx5e_page_release_fragmented(rq->page_pool,
+						      &wi->linear_page);
 			return NULL;
 		}
 
 		skb_mark_for_recycle(skb);
 		wi->linear_page.frags++;
-		mlx5e_page_release_fragmented(rq, &wi->linear_page);
+		mlx5e_page_release_fragmented(rq->page_pool, &wi->linear_page);
 
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
-- 
2.34.1


