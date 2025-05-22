Return-Path: <bpf+bounces-58761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C65AC160C
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F14450512F
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B0425B1DA;
	Thu, 22 May 2025 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eBMsnw4E"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52F24A06C;
	Thu, 22 May 2025 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950172; cv=fail; b=QEDyZCsE7hifo2ryMDzsKfEiJciNY8gr1ACcxmr2FYVmR4xnCY4+L2PzlFxWqJDSOJ9SG+MA9J/PzxPkfENLFdv+faMUvrrGeUUwOnwCpnvsvVzk6lhy6XXzu0VRgHq3syNMgHLmC57QpZwILWu4AWHzYKsf2cb+/iK0gxk5zg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950172; c=relaxed/simple;
	bh=1eiq+74ESn5Gs9CZvfpcCwSOrY4yfIQnwU5WA8VnHh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tb1uptMPhjboQ6C7H2rBRf7zU/pMSmz1FPzKnEXJjNMMwJckPLEC2Sx9TBgD9rsioWLm2+n2cxkDv0eRfpX8vMYzA/Wk9KIhVg05x5YGKXd28udHEwXVOn22yyfuTpmR3wK/2jv0ypRUu9v7hvu47eR1DMKCTDEGi7esKTplpMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eBMsnw4E; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9bIrI2xchiBVeB9JyGEMqKqctrEsgpqTuobneyFN7OuwVsOEea0NjSZoEfWiD56/igWSrJEvFMNOdW1+2hxsMia1iRFJ+vE00//SJ8LJpnJnNpKJgupzbU6rI8Yq7TWgNzsuAbQJJiAGScp3jCyOTTuTgSrMysY8jVbbw1CT+4wVvX9B/wBOhOGr8EoZr5dzx7LfTqTQtgUK0LhielvKON32QT8pBkipQ0Y3Wd6geboxoYAEjjD0LmaQoeiF/Sw5PiNMjIkxmts6jvnCEVWvvFavty1MnTzlU289SDInOli4dAPZdiquij3z1BhSl4COCRszreSIxhdXmdeTz7UNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hivlT+lm3mumQgKfSQjxYmOo3vb7wTq7Oq/vt+2AbPc=;
 b=uidC+1KWG1nqfZjb1TEKsIKs/yVTQSxp7P8XfJExN+oYQs3ahtn09sAAbr3ehyJMalx6IAUu+Se9f1h1AVHxTNUccSY1TjbcMN3IONEN0C2mrB6dp9PXV4gXvAxpszMdXM+CvLvQdiU25gJNsHw7aoYnwc033OkigZP0lvI9X6W7mZ/H2/VQYGRIFeQ/ifftM2/ugeW2yjxkRYEihRwVCCskFdXPk1TTsPWZTSUytCmdLE3+zQmrFReWN0i6ikNZt7uSV4G5pHoRIwHl4R+TKieDFyDJgdKsAdI0t1FR1AxoqBsj5nv70pNR1mrb3xA1Z+edPSZEc9XdAAcRD25SkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hivlT+lm3mumQgKfSQjxYmOo3vb7wTq7Oq/vt+2AbPc=;
 b=eBMsnw4EAKFq4bRfGuf1Wd1msZw9F+iB1rkBrsVUea1DexzYp+0kNRJg48xFokizoYIOY0+otb9kwRjEAg9FAIQ4bNSK9OPyul2VahEQRC6Lar5vig4Zdq8naGMn4jIc1Y6YMS2+RkhixIFRJO/mTX72iYFJOpxScGOeBpyAoGHpSaGsQWhLlv8dJzS+Uz1bgY+PrawGzW8gA5bzsAVBsJKdgpjpOeRe+7mP0chYn/4mr2UMlhcEameMTNHcwnIH3HbQymhs61l0psfzp2OUK6Om2wI7JYgHc921UpSI1dGmAPcag4qtawh3cle0TAsXaM+1kMi1izWS07B4EwyVZQ==
Received: from SJ0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:a03:331::12)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 21:42:47 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::ed) by SJ0PR03CA0067.outlook.office365.com
 (2603:10b6:a03:331::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 21:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:42:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 14:42:30 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 14:42:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 14:42:24 -0700
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
Subject: [PATCH net-next V2 03/11] net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
Date: Fri, 23 May 2025 00:41:18 +0300
Message-ID: <1747950086-1246773-4-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1df692-4f0e-45ae-ec3f-08dd99799733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mh118qY/Y0ZT38lyI5eA9ErQpcHGSEackGMencFblzl/ENakcJDkW34d83JP?=
 =?us-ascii?Q?3Z0gprU/qKfykijhZJycy6DrWGw4q5ZHXMtINaGitECO5wHVKP26oYKjwzMf?=
 =?us-ascii?Q?ZXli2taravvY/nJri9yJcHhej3jg3FHwaQKxJid04s2ARm3/HBq8gcfYCSkA?=
 =?us-ascii?Q?U2mxWASskt/rXxXE4GegzaarOuKn1onZo+JT31Xjl58e1BJE16SJDqbwlqao?=
 =?us-ascii?Q?bMsyLI8l94fVEQzdBOpLPk5PaEhI6BKPKUyQo0rEvknGhR05nEWhhHhwpUP5?=
 =?us-ascii?Q?l9ti6fjJOyQ9Pi0RhCSH3tpH2FiE8ffltufNPGT0giRR/v8qoMIrrSG5KmIb?=
 =?us-ascii?Q?lmjrxinT8TXMuzUAZmWW3CCozp2EWTBcG8plExhCMF64z2B5QGOces2c6NAY?=
 =?us-ascii?Q?OFGgyxnNCFpssGPW1N1OkFoxX7n/QHjBhOTOB1ewRh5gIfCHG0wdgetFR87D?=
 =?us-ascii?Q?Wg6yFuMSi6UEzQjv/iKqSXIHUXuK7ndPhPSqouBr1OGPgQNNy32DSte/i9yA?=
 =?us-ascii?Q?QZ/wUpC+eSRyezg0FTPFmVKgQfnZgI4SfFGR35URDcDo6NrbGEGqs09ZCX6F?=
 =?us-ascii?Q?CYtNJ293shDv7b/tbH5uQS8wETrPSe9NJKqN8QdipRrXHBOs2GK+wYWGl+fi?=
 =?us-ascii?Q?43lqDeZ4VldxBz/TNiDFL7e6uRduBpxU2Mxj8oAJcrj7rM8xzBuyH9mwPljz?=
 =?us-ascii?Q?6mUWV4NvkAEd4gWEOvbrWQa5u+1c5gegbPz+3P6ZQd4rJMGUBEC2RsQNpkmQ?=
 =?us-ascii?Q?7xantuF24gwygI/msxYZ9idD1lYorcFZq1OQgOgwwCUAPwl1AhExbr/LvJzN?=
 =?us-ascii?Q?XJVbx/kmaZouzuXu2L5iKioXw9o3yzqm1ix015K2tiyEaxNr3lt6knNiHbgu?=
 =?us-ascii?Q?Jtu2Se2M+qtTMfz3iX4mH+twPrDi6ZzOsT8IWxEjfkfgKVrche+/xz4KxDW5?=
 =?us-ascii?Q?OSOPd/rSwSMkznguD5gRWI3FUf0nnQ5/Fw+LNTTFqjZfxYyBm04x/Nq1qJT9?=
 =?us-ascii?Q?Zp/ZVTg/xrRHTVaWNYyHX4xViiurdEHIZK5otDDzBILY27B+j8CKW6VUyaUw?=
 =?us-ascii?Q?rDbprz5r53x5SoY3mLCRUYyp7sKbegud9pBnx+iMaM5zQoOzSlIJJEzeU3qT?=
 =?us-ascii?Q?SCZ56i8WyksLKLM/hQm7liwjiZ/ENPFie13BhXmlYbn/iGcsKtdIt3Fytw86?=
 =?us-ascii?Q?Wly5ajftxgahuZXCSUfoSm0jcHsWOGRCFGTamy9kc/sE9/H7vykOVNLepIth?=
 =?us-ascii?Q?PtfhwvWsYJmmoaL/1urakpZsn09GTincNEDOcHVuwbnLm2pDVnYF/eWC8uV5?=
 =?us-ascii?Q?2BzyNzyRdArB/Xuncum90v/8NT6kUj3B9TzYb4bdlhoKli4P7VN92i0CFagF?=
 =?us-ascii?Q?vDkC+1lDKsYrrIMyq1o82naitNqVCi2/GPJ8eap7VoTp4f2+uyM5ARBtj6pa?=
 =?us-ascii?Q?Bkx1useCWuw9ivXLPoyuT8Ew8o8s6FM1wkssLUdvft0J9jWzniTbJ5c++FXA?=
 =?us-ascii?Q?f6GSyS69JBxi01LN6JKYGqwoiMe1KlIuULqM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:42:46.1989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1df692-4f0e-45ae-ec3f-08dd99799733
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186

From: Saeed Mahameed <saeedm@nvidia.com>

Drop redundant SHAMPO structure alloc/free functions.

Gather together function calls pertaining to header split info, pass
header per WQE (hd_per_wqe) as parameter to those function to avoid use
before initialization future mistakes.

Allocate HW GRO related info outside of the header related info scope.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
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
2.31.1


