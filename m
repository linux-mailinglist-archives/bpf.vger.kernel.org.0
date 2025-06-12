Return-Path: <bpf+bounces-60476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663F7AD76FD
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D507B3A1F6D
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B377299A80;
	Thu, 12 Jun 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gPWmXISy"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D5298CC9;
	Thu, 12 Jun 2025 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743268; cv=fail; b=TmM1+y1gQ+229Ic9jbOBoS2aaZvRtYQRE3KWankNCpGt1kF9kI+liLsySOWcmy/IzccL9iSp59XimwUVPmhU6G9u/kkYY23QLCJ4A5650wVuuGhDnzLiVRr6EDc6ab/ozUpzXZw/ihKf8M3UczdhdSVKOhKDmge9E6jEWz0Z00Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743268; c=relaxed/simple;
	bh=Xgx/dPfVS+Tkzxi3CaWGdOyCIJe70pIQDr2I5eF6M04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAqFMz4Mb8c4BxE+DRtmb90Qiqm9GqA3dPQiBUfJjgJ9R7WvqiS4xAyBq+xYEKafq0OvVY8Xgz/JztrR6SlCSZP5yhYBHSgioBb+4xSZncmEyKANocYEq1qc9rikE31l0PokanCo8GNmZUEGasZLqbdUB1rFw76l/tIeDp/7w80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gPWmXISy; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAmA9eD6/URMfc5gu0rfgm9bxLlpesOLwaU4H2Vancf7e/uJTnEF/Jd5LKaMPvuOmn5s/YRiIJDRb+RjPdCGK8jQ0XsZelEDxwqSKu6UWauXgTQlhTPEE8CeFIIT/Z9I7Otm277lAooU2yMPnSwkyL90H4bhEtVPW3fqRp5iqkmdiM1NnXQvwA6VyjxSVlBoPPjSO+kF7T6TqrgkMJ4bb7ZCyK4O44U8OQSz0sw4Wdqb8vpynHXIImV6mgVqsxj+9S7GP1jUz9yj6nI/qr5E7VLF2XLvI2MSqeUIcCO3tJQMfeZDFIJhVa03hViHMwXhu5PNklXtk76TYrEQ90nUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZmdD+pOnRRieqlX3rygkvIpgIXGt0BMPDG4T0Q4HmY=;
 b=ee2HQS+4z13VyM4STAjw33FgnSGnKKtWWXyDOJBJmxqf5qG9D0FKTvHMWwockZNT3urPNJs1sLNg3Cwh0zBLMofFRgtfVu0HpqHRCWkKDAXCIaju+/46+U9KQV6nVOcoiC8Qqb69nKMDk+ZaMz15ZUYC3I4b17mYweJf8lw/S9Clcd9VsNjweyD9lBlQgtuDVaLRAj6fYfnaO4Wx+5GsCBxEnO0HyB25xyIImMEf8Oc48e821wvsW93pp8y2Y/apv2lgftwBI45nU95g7zmepe8BZVy8uOzbYDFQOaCtOnQRieJDzos6fYmNh/hqfvV3ZDMj4wpLAYcj28mtkefnCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZmdD+pOnRRieqlX3rygkvIpgIXGt0BMPDG4T0Q4HmY=;
 b=gPWmXISyXRJXQWPuAB4Zbhid0bD32UQRLuALXrCc5iGMQczUWKkFQL+OH+E7dDCd8fsWI3MAEiTzygcDOqZFDLYCgLzNxb6LjzuuX76Ug1cDF+b+C4A/6dDME8KcEZ95E+dNcZrkL+qxGjFyl7Tx5hx+A3qE94DOXOxcLmVxRbak1Ut4NnUkoqsWMCoi0TY+mG7DXXB+cxWBs/CSJFvVcIWTiDgjgEFiQQpt7B3tFlJIvG3hSgaskv28bakaK9X1jOl0yZmHFXGNo87HUmxtyzPT2JwqHyu3U3iASqBH9EKPCxLu4hxrTA8Q5m+WisuLddkF2KuwF6oxT+5tC3q+jA==
Received: from SA1PR02CA0009.namprd02.prod.outlook.com (2603:10b6:806:2cf::14)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 15:47:41 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::a) by SA1PR02CA0009.outlook.office365.com
 (2603:10b6:806:2cf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 15:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:47:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 08:47:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 08:47:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 12
 Jun 2025 08:47:16 -0700
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
Subject: [PATCH net-next v5 04/12] net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
Date: Thu, 12 Jun 2025 18:46:40 +0300
Message-ID: <20250612154648.1161201-5-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ba1ffa-15f4-4abd-cc77-08dda9c876d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sKy0kdpaR1zAZEWO65tkbLjZbAutDjJOKQAlznjU9b43WrJmRUJp3j5bfNJt?=
 =?us-ascii?Q?sGuEDFI2EhSuEc7Yx/Wfpj/wae2H0nmG2t/yX3+ETVkD6wy3Fa+CHcIWXTI6?=
 =?us-ascii?Q?d1AI3TFNsXy6k1HIvUNFTdPv5TTTs8hJu560DCcllGA49wCbZjVmwEtCXkp9?=
 =?us-ascii?Q?yl635oC6364h2Lk2/tZOrhgcuBR28MjO8K0BdgAdH5e5tOiE9R9c3ZYex0nL?=
 =?us-ascii?Q?ExC1JImU55ITKnohe9xsOZ7BqdDTXvh88HEbM/lgt9VsifEavyFgw+lv4Znt?=
 =?us-ascii?Q?JIGQbS3Z6pndzvGOPaK61cvWz0iuRuvATkkoetCnVOFdS4q2e24ENTQLSUR6?=
 =?us-ascii?Q?RufWTAjN0c4VKD7G4fN6Aeql8vlY5K21ZIigWg37Zc8nZW1xnOtayVmq1z3j?=
 =?us-ascii?Q?sgWZV1tdeegOBMfqeb0Dxxm7b86W4KwIMd8pVaLuSdhg83bpoVYfarbnpLsq?=
 =?us-ascii?Q?v1+rXGpokAa1Zq5x1PcyJpBof42Oa16NtErA8MMzq0OwU1game51NMRXsDh2?=
 =?us-ascii?Q?W0HiEG3BSLe73gC9OCH+XTBFmKU15E/0jpxwe5DdbQzRp2YSgy9K/b3D+KL+?=
 =?us-ascii?Q?Fz//vwzCZ8HswmgYVc2GenrHJEKSzMi30I6b62ZVtfMDVaLBGLWeT1GmJYe0?=
 =?us-ascii?Q?3NtWV3ds7jePEOp+vnf4yqwqLEXQsx0C7DrSq/2uYXlKuvretvRTvf93I+z9?=
 =?us-ascii?Q?JecT4gmX5rpMYh/J76f1ZRjO4Hb0E8SM++GHSeVtf1lSmSPaGNIIpOW1qcZT?=
 =?us-ascii?Q?G9Y8+eb0mKN0Xb/38RNJPZjwClIEF81oNhlFbn2+XUIZJB/3UyU1ydXUPtQV?=
 =?us-ascii?Q?rrRmlPRPrDEUhznkpvgMsz9UROccenoQzR1+ylI70gcaBQL+u0vGDhW5z7xY?=
 =?us-ascii?Q?wY37olYCVC8DMsLEBFERsct68UHuoLv5+3j1WPrMuLL/ym2Nnq33YBrHf5EX?=
 =?us-ascii?Q?edRVoErxB6I1BgOOpyTX20vA6yIzBZHh/yaxo1u0Uq9PSEINVn+gGisotwBf?=
 =?us-ascii?Q?aklMVIateQIvDUZQkF3G6Mav2bp4+cH155c9JZmzwFP8txxQTWvnRksFXgox?=
 =?us-ascii?Q?WLVCIdpz6PZE3V8BDUzq4Q+uCW2Gob++vWEhS1Kc27/BpjZ0gXJe1lr02xeY?=
 =?us-ascii?Q?Et3hlPjIPULlQpFU+zkCt0Y9GTeI8TPrnTeUSFDxU0K1iBzKr0xPH58f3Kaw?=
 =?us-ascii?Q?p6fMuGxZTC/5DwPp+w8kN2M/6GUlcIcae87n9PZq41oyvSto/4F4AWPxGnb9?=
 =?us-ascii?Q?ztNq5hL+BImvhNWQprzvPkH8pw4QB92vWOZrfrDdIT0w/ozAFCt9O5qhfBiH?=
 =?us-ascii?Q?Rm5HU9f5WvFIpahxW7pyxL0oKix7bbL+Ep5t/EzvgdHMbAYh38f1/M0Twtm6?=
 =?us-ascii?Q?q0J63r9/UDr0XkJkbEYHzSbHLv+E6Owp6skkyojU0ADJrHnP7WdzQ0HfPGDe?=
 =?us-ascii?Q?EJz08C8GmQw7nFKf3OxECo//1zMCIADx/kX83t/VeRLhUFc2HEJByh/CS5bm?=
 =?us-ascii?Q?pFoov+1G7RMv7/z70LCrX/r1v1PzOJc+7kPo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:47:40.7351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ba1ffa-15f4-4abd-cc77-08dda9c876d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

From: Saeed Mahameed <saeedm@nvidia.com>

Drop redundant SHAMPO structure alloc/free functions.

Gather together function calls pertaining to header split info, pass
header per WQE (hd_per_wqe) as parameter to those function to avoid use
before initialization future mistakes.

Allocate HW GRO related info outside of the header related info scope.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 135 +++++++++---------
 2 files changed, 66 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 5b0d03b3efe8..211ea429ea89 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -638,7 +638,6 @@ struct mlx5e_shampo_hd {
 	struct mlx5e_frag_page *pages;
 	u32 hd_per_wq;
 	u16 hd_per_wqe;
-	u16 pages_per_wq;
 	unsigned long *bitmap;
 	u16 pi;
 	u16 ci;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ea822c69d137..3d11c9f87171 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -331,47 +331,6 @@ static inline void mlx5e_build_umr_wqe(struct mlx5e_rq *rq,
 	ucseg->mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
 }
 
-static int mlx5e_rq_shampo_hd_alloc(struct mlx5e_rq *rq, int node)
-{
-	rq->mpwqe.shampo = kvzalloc_node(sizeof(*rq->mpwqe.shampo),
-					 GFP_KERNEL, node);
-	if (!rq->mpwqe.shampo)
-		return -ENOMEM;
-	return 0;
-}
-
-static void mlx5e_rq_shampo_hd_free(struct mlx5e_rq *rq)
-{
-	kvfree(rq->mpwqe.shampo);
-}
-
-static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, int node)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-
-	shampo->bitmap = bitmap_zalloc_node(shampo->hd_per_wq, GFP_KERNEL,
-					    node);
-	shampo->pages = kvzalloc_node(array_size(shampo->hd_per_wq,
-						 sizeof(*shampo->pages)),
-				     GFP_KERNEL, node);
-	if (!shampo->bitmap || !shampo->pages)
-		goto err_nomem;
-
-	return 0;
-
-err_nomem:
-	bitmap_free(shampo->bitmap);
-	kvfree(shampo->pages);
-
-	return -ENOMEM;
-}
-
-static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
-{
-	bitmap_free(rq->mpwqe.shampo->bitmap);
-	kvfree(rq->mpwqe.shampo->pages);
-}
-
 static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
 {
 	int wq_sz = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
@@ -584,19 +543,18 @@ static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq
 }
 
 static int mlx5e_create_rq_hd_umr_mkey(struct mlx5_core_dev *mdev,
-				       struct mlx5e_rq *rq)
+				       u16 hd_per_wq, u32 *umr_mkey)
 {
 	u32 max_ksm_size = BIT(MLX5_CAP_GEN(mdev, log_max_klm_list_size));
 
-	if (max_ksm_size < rq->mpwqe.shampo->hd_per_wq) {
+	if (max_ksm_size < hd_per_wq) {
 		mlx5_core_err(mdev, "max ksm list size 0x%x is smaller than shampo header buffer list size 0x%x\n",
-			      max_ksm_size, rq->mpwqe.shampo->hd_per_wq);
+			      max_ksm_size, hd_per_wq);
 		return -EINVAL;
 	}
-
-	return mlx5e_create_umr_ksm_mkey(mdev, rq->mpwqe.shampo->hd_per_wq,
+	return mlx5e_create_umr_ksm_mkey(mdev, hd_per_wq,
 					 MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE,
-					 &rq->mpwqe.shampo->mkey);
+					 umr_mkey);
 }
 
 static void mlx5e_init_frags_partition(struct mlx5e_rq *rq)
@@ -758,6 +716,35 @@ static int mlx5e_init_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
 				  xdp_frag_size);
 }
 
+static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, u16 hd_per_wq,
+					 int node)
+{
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+
+	shampo->hd_per_wq = hd_per_wq;
+
+	shampo->bitmap = bitmap_zalloc_node(hd_per_wq, GFP_KERNEL, node);
+	shampo->pages = kvzalloc_node(array_size(hd_per_wq,
+						 sizeof(*shampo->pages)),
+				      GFP_KERNEL, node);
+	if (!shampo->bitmap || !shampo->pages)
+		goto err_nomem;
+
+	return 0;
+
+err_nomem:
+	kvfree(shampo->pages);
+	bitmap_free(shampo->bitmap);
+
+	return -ENOMEM;
+}
+
+static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
+{
+	kvfree(rq->mpwqe.shampo->pages);
+	bitmap_free(rq->mpwqe.shampo->bitmap);
+}
+
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params,
 				struct mlx5e_rq_param *rqp,
@@ -765,42 +752,52 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				u32 *pool_size,
 				int node)
 {
+	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
+	u16 hd_per_wq;
+	int wq_size;
 	int err;
 
 	if (!test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 		return 0;
-	err = mlx5e_rq_shampo_hd_alloc(rq, node);
-	if (err)
-		goto out;
-	rq->mpwqe.shampo->hd_per_wq =
-		mlx5e_shampo_hd_per_wq(mdev, params, rqp);
-	err = mlx5e_create_rq_hd_umr_mkey(mdev, rq);
+
+	rq->mpwqe.shampo = kvzalloc_node(sizeof(*rq->mpwqe.shampo),
+					 GFP_KERNEL, node);
+	if (!rq->mpwqe.shampo)
+		return -ENOMEM;
+
+	/* split headers data structures */
+	hd_per_wq = mlx5e_shampo_hd_per_wq(mdev, params, rqp);
+	err = mlx5e_rq_shampo_hd_info_alloc(rq, hd_per_wq, node);
 	if (err)
-		goto err_shampo_hd;
-	err = mlx5e_rq_shampo_hd_info_alloc(rq, node);
+		goto err_shampo_hd_info_alloc;
+
+	err = mlx5e_create_rq_hd_umr_mkey(mdev, hd_per_wq,
+					  &rq->mpwqe.shampo->mkey);
 	if (err)
-		goto err_shampo_info;
+		goto err_umr_mkey;
+
+	rq->mpwqe.shampo->key = cpu_to_be32(rq->mpwqe.shampo->mkey);
+	rq->mpwqe.shampo->hd_per_wqe =
+		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
+	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
+	*pool_size += (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
+		     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+	/* gro only data structures */
 	rq->hw_gro_data = kvzalloc_node(sizeof(*rq->hw_gro_data), GFP_KERNEL, node);
 	if (!rq->hw_gro_data) {
 		err = -ENOMEM;
 		goto err_hw_gro_data;
 	}
-	rq->mpwqe.shampo->key =
-		cpu_to_be32(rq->mpwqe.shampo->mkey);
-	rq->mpwqe.shampo->hd_per_wqe =
-		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
-	rq->mpwqe.shampo->pages_per_wq =
-		rq->mpwqe.shampo->hd_per_wq / MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
-	*pool_size += rq->mpwqe.shampo->pages_per_wq;
+
 	return 0;
 
 err_hw_gro_data:
-	mlx5e_rq_shampo_hd_info_free(rq);
-err_shampo_info:
 	mlx5_core_destroy_mkey(mdev, rq->mpwqe.shampo->mkey);
-err_shampo_hd:
-	mlx5e_rq_shampo_hd_free(rq);
-out:
+err_umr_mkey:
+	mlx5e_rq_shampo_hd_info_free(rq);
+err_shampo_hd_info_alloc:
+	kvfree(rq->mpwqe.shampo);
 	return err;
 }
 
@@ -812,7 +809,7 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 	kvfree(rq->hw_gro_data);
 	mlx5e_rq_shampo_hd_info_free(rq);
 	mlx5_core_destroy_mkey(rq->mdev, rq->mpwqe.shampo->mkey);
-	mlx5e_rq_shampo_hd_free(rq);
+	kvfree(rq->mpwqe.shampo);
 }
 
 static int mlx5e_alloc_rq(struct mlx5e_params *params,
-- 
2.34.1


