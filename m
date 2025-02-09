Return-Path: <bpf+bounces-50890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A721A2DC26
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9357F1887155
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9081B423C;
	Sun,  9 Feb 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KGNNsbel"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8805A6F06A;
	Sun,  9 Feb 2025 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096377; cv=fail; b=cbOZROvu0iEkI0k4dUdajU6ASNaaIrGceFlPRtFZdcp1e6C8carAzprEayeUOKC+mtei8DsuDMh9/Mtubtnij50hjaZdBWiDdhFLw7QmW47Ood3pPeJS93Snn4CSUVUKnrQEr3NmW/HtS9Jvs8ORU+2GTlyzo9Y7CdOlAy8OFXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096377; c=relaxed/simple;
	bh=R+hLaWzESyGlfY+x8EfeS1rJI2l+H5ofHvTtKjCXEC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnBmsLy0t59j535fSwbfZ5rZ952ECYOjRN/vhxLrLXsn6NwPBbPwDRIUF83WlcJ92PIAKMLazjg4K8+q84Jvr2Kvu9E6BkUCsl3Lo/JkUdSU0TXpBn8aLPrD2tjeIdJ7+2y7jLvJoEK7iNip2Z6Zl1vXQApQfy3ZCQiiZGfD/Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KGNNsbel; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgP1GRJ39AdXztSvGC/pO6feHvBLIGopwqH3Rx0NYDvk3ib1Zu9uBdln17nR6E14zXZja0Zla9EZv5JAkRcLdphwoNZ1fSP+y9hFuuBjbLxacNIIMwuMzqhQ9Igm4T3xHQ/sEiY8rlWYip+M9Tv9AbQGeUm1XTpIFvNarWDQZ4pr4FmHnUt/cUZwX9syA0EUGw1gz4Iq2k7fphX9+1nve2rGkAbXzirLkIJjJp1k1SGyCCuMIYMUGKExtGMcvelQ2ofI55GwAu1MSY2xk/oZTcbvR54dT07jR4dly9VNBrAjhGFjThHcL9VUiBfpI7zqpMut+IkyYT1dlU7flAspfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFllP0J8wk8dCwmsDF+YV2hWQCRMazFe5TQkA0j268s=;
 b=RCbvkDM8q2NHs7/ikivd7pk8BClLaY8pLpgshfdZHpHCa6j7lMcvgDjbL+ou3H1bw5xpSUEHf8+asNL/D7JQNK2KdMC0WyJIv2DIrp9J8+IAEL9bwuuRQU5FIzEvsTUzc6S2Tws34uflciLvqJAZpO+iqymI4etqADtTBZRhzqa0C7mQbEw7bkWohvhpOtMJsEtRHGvBbsEOmxsoM7NjzlJo48gy6pVfrN31P9by6dwOwbF4QsVPV7buiJnhEyklR2ImGw0wwBuxFzvQnjk5K2yoz5A7g4GYyVFo7VBdkZdIFbpm0/beq8LuB6cwMGrOzLz1x8RXRmqZEWkPRZ/Tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFllP0J8wk8dCwmsDF+YV2hWQCRMazFe5TQkA0j268s=;
 b=KGNNsbelD6kov612kmjPUW64GxPCuYn/EQKvmXrciA7lTeGvvrKcBU+/BSVCwaU0FA5agZlIM2jj14niePWYjWRYvC/Km+NRpKlg1NrRg6L9aYD7AO9w70Uy9cyVjkS5wPwsB0s6lQEqfDkFbXS8+KZ8kMCuFLXJsI+xvJEv2r6+G5yNVsCplcMyzW9ECQOyeq3rZDjH/yzM3b+CAZQKMGTYEq0EOKgmVYdfovCikooYRBkOBezixkoo1Mf84PfoU+Tco6taRaPgA7QL/sDiVmgnRGAmvfIFaGMgtKEB4OB25VlUvCMvw+kYancLicP3ENq/AqdZVKB2otwhn7Qjjg==
Received: from SA1P222CA0173.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::16)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sun, 9 Feb
 2025 10:19:30 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::ff) by SA1P222CA0173.outlook.office365.com
 (2603:10b6:806:3c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 10:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:19:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:19:20 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:19:20 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:19:15 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Simon Horman
	<horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Richard Cochran" <richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<bpf@vger.kernel.org>, William Tu <witu@nvidia.com>
Subject: [PATCH net-next 06/15] net/mlx5e: reduce the max log mpwrq sz for ECPF and reps
Date: Sun, 9 Feb 2025 12:17:07 +0200
Message-ID: <20250209101716.112774-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250209101716.112774-1-tariqt@nvidia.com>
References: <20250209101716.112774-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: c6dd96ba-51cd-4c3c-14d3-08dd48f33d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P06M9WNMjhR0qKVbWFq2Tv1ikGy97M+H5co3fDM1kgbbxHln6lsaF2IRMhYI?=
 =?us-ascii?Q?A8P+kQe5Du5azPQC7R8DhoLMxEfQg+bX3xmjFH03KesA3LuK9kJHFco1jvF1?=
 =?us-ascii?Q?9Cn3WN63j7mrY8CZ0rdVjkXnlen96f8DyieaJ2mXOrSUIqjCqGqpAyJiiVR+?=
 =?us-ascii?Q?bKZnAk1Y/h57gxr7g6rkpo6vQanyS9+Nu1wDa8Gc7b0GoVluy5yZ0WEmhSE5?=
 =?us-ascii?Q?DU5iBSa55R1we/8It3lBiQL0kMRnuFPnrxbTsDOkr78OMHT4DrSb1iTbIGqB?=
 =?us-ascii?Q?LQUSiTvZ7EV/UrMUQFgv4HSgC793h6ztVrIdB2m/mq/OpqMSF1/rsRMYHGjM?=
 =?us-ascii?Q?2A9db6QnLfH753xMM636N+uMATWAX75uKSrhez6BWomjxUjX6kJfOjIwjYeB?=
 =?us-ascii?Q?Dgm9DZaDNhu58hhfi0B6k5e/g47rxYkY4Ae9CB2GwrMvLQhKSD7PKvG8Iqkr?=
 =?us-ascii?Q?STglgW6eKmQ/DBFlykJZoQe9wEfP99gobiXqz2bNKRvMLpAg46v6AP40nhlB?=
 =?us-ascii?Q?va23eMxLR91GbuAAuJmu+jHx16Ijszn2Iny64fjgQnlnFxPpqh3egs5ybNYQ?=
 =?us-ascii?Q?1i2FFCbCFjaMiJWJRb+dEX9z/W9FHjcEhxvicBIYa9wq9E62xzDzGy5hSGpb?=
 =?us-ascii?Q?rA1PpnmEDcBvFM7iS7aeff2PbaEy97yfEOCWAQYXWdNAKAi+2QKw056YXTs8?=
 =?us-ascii?Q?nrTN2rASnMG1Xl1YIhb/z93vjSLVprJ5YwRFcVvvmSGxWbuSu+Q5HxbQFKsq?=
 =?us-ascii?Q?dII2ldn3VQIUyFMzmYyL6h3khWQfZ46Iv22C+z26CAmLd2eaQDOmgi7OWbkC?=
 =?us-ascii?Q?s8RhrkSqCxOXLFPrMRQ1SpIH7DrxaQWdaWG7RkDPu9p9Pw30wI+P2sAzAEks?=
 =?us-ascii?Q?+H7AH/JaGQAUp6W+zvD5P3F7O9GfQ7kFz++s0zxkIeygyFYHdckxIsWmc4gI?=
 =?us-ascii?Q?glCPgCmZQCm/pXe9RJM6PL+dChYq/HBBJ6HH4WfMsq27HJtMIFEAt34rs9uR?=
 =?us-ascii?Q?bEoPwEuj/r9Bu8wvwQLkp6S5+QRRlNJ8X4K8FRrTSGc1kL3b3qGpjsiPutZx?=
 =?us-ascii?Q?wkc6hZwdKCMIHaFxyfsxqt8cNVUDOXQQKk2FwcL+M4R/s2mmC3xEqPQKTD28?=
 =?us-ascii?Q?AYm+22dYn+rGMmdYMFBXT4DKXd9MrnXoNSj0TNFHMf8yW2HB4U92STPZcZ+K?=
 =?us-ascii?Q?iRlshEeUU4EJRgLyfhJ1GGYCROBrXmXbPtxg3gqNpMYvuj7APtYz5xAllEc6?=
 =?us-ascii?Q?guuiERe/sy/MwM5VXTEuKy7UJgXicRTe12F/uk0JZAFTYHHxR1Uw05creBzr?=
 =?us-ascii?Q?d5lLgc/9Rje1tfNcX6KO/kC7PdXGTsVrqP1fCBo1mU5iIZwQiOb8UgYzv7Os?=
 =?us-ascii?Q?XKMrqoaCwYN7e8Nynp5hLNL+q1Vd4mPvXfMH/S+TzldTT6JzD5rOY9pWLs43?=
 =?us-ascii?Q?YTyPmRFfc4Vnlt7TJ3Dqc0TAce35xQibtjzKtgjbJqVDV7k/hAgiEKeK8MMR?=
 =?us-ascii?Q?bXS1zruZJ9GIT8U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:19:30.2898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dd96ba-51cd-4c3c-14d3-08dd48f33d9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947

From: William Tu <witu@nvidia.com>

For the ECPF and representors, reduce the max MPWRQ size from 256KB (18)
to 128KB (17). This prepares the later patch for saving representor
memory.

With Striding RQ, there is a minimum of 4 MPWQEs. So with 128KB of max
MPWRQ size, the minimal memory is 4 * 128KB = 512KB. When creating page
pool, consider 1500 mtu, the minimal page pool size will be 512KB/4KB =
128 pages = 256 rx ring entries (2 entries per page).

Before this patch, setting RX ringsize (ethtool -G rx) to 256 causes
driver to allocate page pool size more than it needs due to max MPWRQ
is 256KB (18). Ex: 4 * 256KB = 1MB, 1MB/4KB = 256 pages, but actually
128 pages is good enough. Reducing the max MPWRQ to 128KB fixes the
limitation.

Signed-off-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |  2 --
 .../net/ethernet/mellanox/mlx5/core/en/params.c   | 15 +++++++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 979fc56205e1..534fdd27c8de 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -95,8 +95,6 @@ struct page_pool;
 #define MLX5_MPWRQ_DEF_LOG_STRIDE_SZ(mdev) \
 	MLX5_MPWRQ_LOG_STRIDE_SZ(mdev, order_base_2(MLX5E_RX_MAX_HEAD))
 
-#define MLX5_MPWRQ_MAX_LOG_WQE_SZ 18
-
 /* Keep in sync with mlx5e_mpwrq_log_wqe_sz.
  * These are theoretical maximums, which can be further restricted by
  * capabilities. These values are used for static resource allocations and
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 64b62ed17b07..e37d4c202bba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -10,6 +10,9 @@
 #include <net/page_pool/types.h>
 #include <net/xdp_sock_drv.h>
 
+#define MLX5_MPWRQ_MAX_LOG_WQE_SZ 18
+#define MLX5_REP_MPWRQ_MAX_LOG_WQE_SZ 17
+
 static u8 mlx5e_mpwrq_min_page_shift(struct mlx5_core_dev *mdev)
 {
 	u8 min_page_shift = MLX5_CAP_GEN_2(mdev, log_min_mkey_entity_size);
@@ -103,18 +106,22 @@ u8 mlx5e_mpwrq_log_wqe_sz(struct mlx5_core_dev *mdev, u8 page_shift,
 			  enum mlx5e_mpwrq_umr_mode umr_mode)
 {
 	u8 umr_entry_size = mlx5e_mpwrq_umr_entry_size(umr_mode);
-	u8 max_pages_per_wqe, max_log_mpwqe_size;
+	u8 max_pages_per_wqe, max_log_wqe_size_calc;
+	u8 max_log_wqe_size_cap;
 	u16 max_wqe_size;
 
 	/* Keep in sync with MLX5_MPWRQ_MAX_PAGES_PER_WQE. */
 	max_wqe_size = mlx5e_get_max_sq_aligned_wqebbs(mdev) * MLX5_SEND_WQE_BB;
 	max_pages_per_wqe = ALIGN_DOWN(max_wqe_size - sizeof(struct mlx5e_umr_wqe),
 				       MLX5_UMR_FLEX_ALIGNMENT) / umr_entry_size;
-	max_log_mpwqe_size = ilog2(max_pages_per_wqe) + page_shift;
+	max_log_wqe_size_calc = ilog2(max_pages_per_wqe) + page_shift;
+
+	WARN_ON_ONCE(max_log_wqe_size_calc < MLX5E_ORDER2_MAX_PACKET_MTU);
 
-	WARN_ON_ONCE(max_log_mpwqe_size < MLX5E_ORDER2_MAX_PACKET_MTU);
+	max_log_wqe_size_cap = mlx5_core_is_ecpf(mdev) ?
+			   MLX5_REP_MPWRQ_MAX_LOG_WQE_SZ : MLX5_MPWRQ_MAX_LOG_WQE_SZ;
 
-	return min_t(u8, max_log_mpwqe_size, MLX5_MPWRQ_MAX_LOG_WQE_SZ);
+	return min_t(u8, max_log_wqe_size_calc, max_log_wqe_size_cap);
 }
 
 u8 mlx5e_mpwrq_pages_per_wqe(struct mlx5_core_dev *mdev, u8 page_shift,
-- 
2.45.0


