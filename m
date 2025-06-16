Return-Path: <bpf+bounces-60721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E595EADB369
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9409E3AF6DF
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211682367D5;
	Mon, 16 Jun 2025 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mfVR5cJP"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E11FF1AD;
	Mon, 16 Jun 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083346; cv=fail; b=Iqg9C4M/X3UlRUpO1JKchOUHyywiFEeItBIwAVFkx72iufBCwWuTzd7Q24++eV71D0FtAdzCDV5gW0YgJjn/rJO8bOfEDvUgFx0AI0c0t5ZtoMlAjZAfq5PB+ZOZ6xzZsHL/ttB1kzwhmzS0cG9ZYUiZZbowLsLUFQlfKXOj2Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083346; c=relaxed/simple;
	bh=ZKP5AowOc91bfxJMYUruwyj4KjjnoRH/G5O+SG8VUW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxhFXOUyiC7cPqBKRL0GINBYjV5oH7gCWZdyYPDrucRhBq+x0D6DvB9N6vvFoG0h/YIk9HNpnhxW9r5PvU0BWKtmp1j4FdL0uxY1epQgRP9yh3H0kpH7wsrK9bft4bdVfIA0k7P7Yl0yvrz7ijgHuKUsEZDfL2NFv4VR6HMXdG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mfVR5cJP; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+S35i7Q7Kq1Dpb8/K23pZbuotCSfKZKo1F+AMNVXaJ5UEeD3rN1nPgaSuJsKuyThRCa12sTDP18X9f2qbkk261Fx+SpGXsNADxAr8LqDvOi+DgIAMuHvCn7RS48rvNnaAppfEko3vT42DB+fbMHkZ6Zgq9VoNAu1wkNCA0iiKl8HwR2rILwczGAMpKPuhqOnkK8nB+kyu4KFR9zqHFJnmOKG6y1oScT1znEWG7Sy1GCdDR+FyJhBic5Lga6Zu84ae9M7DVS+LH4jpaFRVewgoYUfk85ptWHvJgN9QyGiivPJc2OWTLROSzaJ9pE+wWtIMVx/0sFtauK/FFziFETNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgz1OGLRs37uvqGlZMMC1EsF9CaynvpaVkKMug3Cphs=;
 b=M+rmqY9KGKee+feAHsDRke2uJgNFNS9hS+FSjRUFLZ/RFvQ2Zf/4ZeQwaQgXgWW5iUuKtM4WD9J60xUDi2idvWepiU+i4R6gp+y86J91Ybq9eWUfmhJYDu2VIASuNdi4zDkT/TfBdSejWcsjrgQapdzoyZAhK0G0SYEuV33107oYSyL+7V3MnSICu8WUXuKCyhcqdIeJvAG4Gjf+G+cQ2wenp2o9Yi+bJe9VKOdW9SaRVIChSe7yVp+cYVCNBKzchYPDADnVdsZmVgpJn/ADGnO9HpeIWEBD4RGrV3XqUmV1ZYS+49G0VkNujE/2rBEt3RaJUq4I0Baxv4OlB0s+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgz1OGLRs37uvqGlZMMC1EsF9CaynvpaVkKMug3Cphs=;
 b=mfVR5cJP37sjxRwE3+CFK5BmI+mVa8cjJUeN0VrbiUJTxN+Rr+PGpN05gkMhAtA+QKt98oLWHN2Xzk7/41P+aFXmbfALztJbskp7DFAFXRnGjRYyhBd6qhuwvxs29T12P7BpMy3gEriMoAJn6oksIzQ3GxLiDJVvN3Vm5rYOpEUXppT/F/gNPXEkkLTsSrR4rog6K/gt1f+pNSVdhsn/lB9OaDonl/jOX/36bJLtHuhuxKTEt8OcHioC5TpUdQ1iXvuGtg/rLcWoL602lwZTTqntkIM7J0QJ0qt5jrvStngEZN0PEckpXH6Mrqwj4UqHzY0qbQGOlXefgdyhTDbPng==
Received: from CH0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:610:b3::34)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 14:15:40 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::8a) by CH0PR03CA0059.outlook.office365.com
 (2603:10b6:610:b3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 16 Jun 2025 14:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:15:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:15:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:15:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:15:24 -0700
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
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v6 05/12] net/mlx5e: SHAMPO: Remove redundant params
Date: Mon, 16 Jun 2025 17:14:34 +0300
Message-ID: <20250616141441.1243044-6-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: de7fb766-78b4-464c-cc11-08ddace04611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uscm2gUYB72N+LwBXIaxClx6hQnIMk4zTnyG01ylTpqIZtjp0z/ys4f4WW18?=
 =?us-ascii?Q?APCoT11dUDICwY08WLlp/CSSHLHBsdPhTnRh6K8c23jCNVePXazcG7Xo2v0I?=
 =?us-ascii?Q?IxM6OZb+GaDi4ZVGp+J0oDt3saupWBoJmdFsOSNWJfXN0uOF6dS6KfEEuQPw?=
 =?us-ascii?Q?EWEfPkfHY/1JGN6DX2/LpHfCpmh+Ox12bAJdA8d2KmL7M6a4mMkvZylaPu8P?=
 =?us-ascii?Q?S97Gbar/DgGGI4hp6G776hT+CotCQAHbtwnD0u2SCTa9CiQqS9eTjWZfNzxU?=
 =?us-ascii?Q?12KHhjomCl4MpqLHeB0bNIQTZ+JeU61I1vmrHV3MJ1lS63+sJYhhP2dSg1Ru?=
 =?us-ascii?Q?jzfqqAXIb9qRt9R94d6/OgMZSkHHNA3sZhxJRmHnymyGaTOJZrsGUgZHsJJS?=
 =?us-ascii?Q?fAqNvJoL0Zjd876RrMXXRd0s6Vqq1la+3K+mFTRvR3ML5rfn0RBtCgeFI6P4?=
 =?us-ascii?Q?g4KWZQLlvpm7KaSIU9lHak2k/PxtHl6wt9jl0Y/shPd8zSVHweLe8UjbYh7K?=
 =?us-ascii?Q?anYGMaR7eSWae4sSKoIRNha5Y2dSg1iGW6aWh2JH8vc0GUO+eoytE+mZ1eWD?=
 =?us-ascii?Q?nO3KRWVTehGygSx3wx5/vECQUAe+n298Jj0COo1Q/NSs35+dxMrj/igSMnqu?=
 =?us-ascii?Q?5QVsWwTElbOpKawCX4q2+8N2TexOumcksyO/U3FLXAAuXwMhQqA3SUm86Oaa?=
 =?us-ascii?Q?39NwLSOAGZpgCt1QzYEP07pGiEo7LSXWd4smMDn2MO5fYwpNXu3odha1uTik?=
 =?us-ascii?Q?SI1RJSrGrTA/DBKZ7YkLEf2aoK82Ox732GnJDK0LuVsN0g/ZqzLWwGa0Bop0?=
 =?us-ascii?Q?S+3iA1GCjixMXWJj7njh+PRl6rLj4pdftDdag46KM4tq6LVR1kzpbPrqmbLl?=
 =?us-ascii?Q?b2o3fIEkvws+3IYr2MooBK7Y88D9zQpNXGrNnk4URrDvbvQf+/MC17zkbAvA?=
 =?us-ascii?Q?7xyS9MdVBT2HEYe2+Lft44buXa+9dPNcVRZK1xPPwZrHhmVonUrvSWTSE6QQ?=
 =?us-ascii?Q?/dkMeoOXamXo6z0ZrQ8MTGEH+QnB51jk4NasUEWw08vLSqxSK4CevioQOM68?=
 =?us-ascii?Q?dKgwvM/X5Cq/QPdPrWjaTF/Yh8RTHRivLrdaaviAT5JdX5h70ilGIIS+xmfp?=
 =?us-ascii?Q?5b9YgzCSEH8i5O/+gyuAEXzYHvhU7ue93vMJApQ1CnwXcav6GV8icPQEpYXO?=
 =?us-ascii?Q?BnDdZcynvXuSNA8HBSj8JWb3g0sRw+DTiFAj5bn0om3LfyuWXSyVPOoSV1ir?=
 =?us-ascii?Q?ztUbnCZP0MWXRHm1C1qORW6OjHICr0BrOBGOdRXWrR2W9LNcPrIGslsmV3k3?=
 =?us-ascii?Q?l55XtlvYw9n4j4MHiDPc+hBf10mkRNR/g8Zz3vCZgNVx8HWmLCMOC9M/ODEj?=
 =?us-ascii?Q?6OkK2TRWGJgGDN/kR2748q9PbKWIrLPzMKijQ9vQP0l4Rjj70ZPMTH0bnrfO?=
 =?us-ascii?Q?JTR9mWASocGueA/fGSjg+Qw3jw+3v5oTe3J7W7H5I1dIYaJ1aooH3+/LEu+6?=
 =?us-ascii?Q?13wdzlBxbmRjXC/Tk5FHrj0JKKiLVMZXsj84?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:15:40.3355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de7fb766-78b4-464c-cc11-08ddace04611
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185

From: Saeed Mahameed <saeedm@nvidia.com>

Two SHAMPO params are static and always the same, remove them from the
global mlx5e_params struct.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 ---
 .../ethernet/mellanox/mlx5/core/en/params.c   | 36 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 ---
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 211ea429ea89..581eef34f512 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -278,10 +278,6 @@ enum packet_merge {
 struct mlx5e_packet_merge_param {
 	enum packet_merge type;
 	u32 timeout;
-	struct {
-		u8 match_criteria_type;
-		u8 alignment_granularity;
-	} shampo;
 };
 
 struct mlx5e_params {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 58ec5e44aa7a..fc945bce933a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -901,6 +901,7 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 {
 	void *rqc = param->rqc;
 	void *wq = MLX5_ADDR_OF(rqc, rqc, wq);
+	u32 lro_timeout;
 	int ndsegs = 1;
 	int err;
 
@@ -926,22 +927,25 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 		MLX5_SET(wq, wq, log_wqe_stride_size,
 			 log_wqe_stride_size - MLX5_MPWQE_LOG_STRIDE_SZ_BASE);
 		MLX5_SET(wq, wq, log_wq_sz, mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
-		if (params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) {
-			MLX5_SET(wq, wq, shampo_enable, true);
-			MLX5_SET(wq, wq, log_reservation_size,
-				 mlx5e_shampo_get_log_rsrv_size(mdev, params));
-			MLX5_SET(wq, wq,
-				 log_max_num_of_packets_per_reservation,
-				 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
-			MLX5_SET(wq, wq, log_headers_entry_size,
-				 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
-			MLX5_SET(rqc, rqc, reservation_timeout,
-				 mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_SHAMPO_TIMEOUT));
-			MLX5_SET(rqc, rqc, shampo_match_criteria_type,
-				 params->packet_merge.shampo.match_criteria_type);
-			MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
-				 params->packet_merge.shampo.alignment_granularity);
-		}
+		if (params->packet_merge.type != MLX5E_PACKET_MERGE_SHAMPO)
+			break;
+
+		MLX5_SET(wq, wq, shampo_enable, true);
+		MLX5_SET(wq, wq, log_reservation_size,
+			 mlx5e_shampo_get_log_rsrv_size(mdev, params));
+		MLX5_SET(wq, wq,
+			 log_max_num_of_packets_per_reservation,
+			 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
+		MLX5_SET(wq, wq, log_headers_entry_size,
+			 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
+		lro_timeout =
+			mlx5e_choose_lro_timeout(mdev,
+						 MLX5E_DEFAULT_SHAMPO_TIMEOUT);
+		MLX5_SET(rqc, rqc, reservation_timeout, lro_timeout);
+		MLX5_SET(rqc, rqc, shampo_match_criteria_type,
+			 MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED);
+		MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
+			 MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE);
 		break;
 	}
 	default: /* MLX5_WQ_TYPE_CYCLIC */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3d11c9f87171..e1e44533b744 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4040,10 +4040,6 @@ static int set_feature_hw_gro(struct net_device *netdev, bool enable)
 
 	if (enable) {
 		new_params.packet_merge.type = MLX5E_PACKET_MERGE_SHAMPO;
-		new_params.packet_merge.shampo.match_criteria_type =
-			MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED;
-		new_params.packet_merge.shampo.alignment_granularity =
-			MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE;
 	} else if (new_params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) {
 		new_params.packet_merge.type = MLX5E_PACKET_MERGE_NONE;
 	} else {
-- 
2.34.1


