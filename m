Return-Path: <bpf+bounces-68000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9682BB513E3
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CCC161276
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8EA319867;
	Wed, 10 Sep 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jcatDgok"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB8319848;
	Wed, 10 Sep 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499956; cv=fail; b=NJu8vWqtxfTzcZfZnz+RYjkMmNh/xFez05XS/ljM3F0JXT66meqQUSs4Z0YtVn2gG8rYuAWi1R6gB/DN75Wa8DeyZEHhXcttzyALBZ7JKc7V5fRQVsY1Js8fmQ3RXakuWEOM1ZWfT3Eb01dbfyhMuL7IHDXqveWzHdLao8QLd0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499956; c=relaxed/simple;
	bh=nazo57QJUKzzloxe+PZVTh3FcqlvIFzHSu9eXsbDz5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0WkOWnoriW9NXp5EwuWehNLdygl7QCuSE5+EpibtF97nwC5FJulEUvyzfz1pImyIGXEs29s+CuJfE0jr+/5KRS08FS0bUiTZGrLwNNA8yXujHAuVokXNPonWeulDAnON2plMcvBxRF3blRIpW9V7tdLoeAFVMEr4beC2dbxNnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jcatDgok; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5fU0s8QXs0pY6KjWqTtfXWVJdomWtc9DnY7p2hPbD7B4G61u7vZaipqW3tHThDd6drA8ymlkYKQd08xGUz+X8oHlQeqc5+J93Gayq7y5RQK6IkxOwb7fV3FmW4xlQljf0O1Skei6A6wnXYdsValuxNozPQPhAZHtyOjyqkCktKYLmd9HEYv/z5d+E8APowxgutfZifarojW9V3BkBYs6istQCubvlDB51SznApz1hJJ3KSpAiyxI+AUa2PEiIgVWDDcZqAprv0r2twM6jbZTxA0XVLQ1Y2pq7FC8KXPv8ugjytsIuEZBCe4vq07IVo9gB1n0n1nLCcYoaS3/UvIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdHtfWwkeP09jxPwOFIL2Z9wXiF7nuMuVAjBFcdgbXA=;
 b=FTOQ5O9JmUYNS3rUzEmEdr/7Av+C9bPfL0OkSFkrJegLb/Bj5l4ntRN+/PFoC+RmNGypYtlq7lQxAJk2sZ7DgCpgPMaE5C2RNDChL2gs1A7d+U/e7mXjR91jvRcVu9iB69JQ72yElN8mM+QFLQ6cvMtyCtQqQAonq5+TmbTtjR/ouZam/7vuWa2fEq0riPyqOtjQh9a2F8sZnK56+nE0l5q1DJ4n8cUndVll4NUEqZLEj57S2U07ZGcnwUNd6OiO4LOvlCjtjptKa7v6RbqWhnjIaO7Eu2cYvZKrPbAf0VcN5xlLzr2OUZx/WUy06/PLEznBguCZULnHkEbiV+Q86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdHtfWwkeP09jxPwOFIL2Z9wXiF7nuMuVAjBFcdgbXA=;
 b=jcatDgokEgknpy8WtxeQDdl2KLvA/7RBeXaeAdTAisiGJyE7mDtLP6wxczdmQ12olFDSBZEuBhyQjJqLSEO7NDAXdiju8uB50vA1qOnQj5tDaD9bK6NN/XlK8pedzQcs6uQ9smmC8JbMP4N+p3C5jQ0LUpIgLzsoLtOEQ5ltMkJ3Cw53wtLlU0mbCUdcwVd8BSew7Zm44U0rYelghktO+RdAhMEPBH9voiD31d2pISAATUPJJcNN0w50w71iA0guz5NQTsYRBbvXtLc04WHWA5M00OXjTfm6h5Mck3jVe9/dHceKxtZ+r0fR0f7G89zueVVJfd5gMq8U1NmC+068oQ==
Received: from CH2PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:52::24)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:25:50 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::83) by CH2PR04CA0014.outlook.office365.com
 (2603:10b6:610:52::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 10:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 10:25:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:23 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 03:25:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, "Leon
 Romanovsky" <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 03/10] net/mlx5e: Remove unused 'xsk' param of mlx5e_build_xdpsq_param
Date: Wed, 10 Sep 2025 13:24:44 +0300
Message-ID: <1757499891-596641-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
References: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 807df9c9-960d-4335-8fa2-08ddf0546a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AbeNFkiDLVaA6Ts1q7zPD33kg1L1GOhf6/ecvL+cCgg1fFqzH6xnoujAUiGa?=
 =?us-ascii?Q?hM162lwQ2A0ZBsFF0tUhzzpYWPDKGXk0A7g3ILC7+kTL7P9i/0L0CSORobTy?=
 =?us-ascii?Q?FKuzVD5pIxck4rfnbHi0ED8emEoQ8WjREJVZurPKRJSFlayR6Fpmgl7mVp0b?=
 =?us-ascii?Q?kURHuLszlDHIFW+RfcR4X6iJt1rFbYgCs9uTyguH06d7zShFSez1r2yt1m9O?=
 =?us-ascii?Q?13r8ViiP6jX7jO4uiY+FG3DVPGsMeWcp7MY29tFjHxffqdhAivhqND6hPTiE?=
 =?us-ascii?Q?8kMxPeDPGvWig2t+b0SBGLxvlDHaa4WyWV4aQVKDMe6mB5YAPKcsAfACRu4J?=
 =?us-ascii?Q?Mdv1Y7DDWUP1lH4ytZ/IkuFAczhTK2xS4a6CwLodoKe7p8sve4C+N/oQpT/G?=
 =?us-ascii?Q?Z0KStavbJvbg+23L0/4WeZHsb9B+GOine9avJqFPTXMyA0rBo9ESYBNSPBXs?=
 =?us-ascii?Q?kIfvOFyDls4q6oy8pDxRdW9mVh0QR+wiN1fVtc49U2XeVrc4Fl4M/wJkwSNK?=
 =?us-ascii?Q?CK9bmMIlUmiJzzm+m4Zi4ZxMWDVEz4/ufKHfKRAvDd/2VT4LLsYxrQ7m5Cnw?=
 =?us-ascii?Q?/whGVOgs0RXjwCkLoCk9/1zftVVuVvgSgl+pDI7olhE3R2gQ0TywQ3kgHOo/?=
 =?us-ascii?Q?ie9LCp05VXsF4V/jEhSuREvUGyVAMZpVbs6uXSoOlpqWOYQ7EaPnV0IVlDhv?=
 =?us-ascii?Q?wheVhbkoG6brgbOhfHitYIt1C7c70v0qlrTOR0CBUlvsMR6wtDfrcpSuiF1l?=
 =?us-ascii?Q?Bwk8risf7q8P7qjeLGue02zj/jNXB8AkqsHHT5kGo0i2kX75PmeqGEziRjXj?=
 =?us-ascii?Q?38xumqfBDIqum0X2aofqFpflyGIIh9tzGYj0WFYI4vV21tVcs629DDwk+CAw?=
 =?us-ascii?Q?na+nlRiXlvZF9xiE8bCsH4+CemRR3djUReB2y0z32jFdFo27r0tOjtduWDCr?=
 =?us-ascii?Q?Ev8y8PFK62zbzDyembp9UA/VujuZjAzEUSbbxSEJWKvef4m3SY0sStENwng5?=
 =?us-ascii?Q?t4un+9FoiAqhiSUgyoUtiWInn/qQmZj3+N0OFfbLx3eJxlR+SmLRjbJjmftn?=
 =?us-ascii?Q?aGycR/gaEh0IyVzv5stnUOGfkUpWCkAOzg195T3/Grm+FJpcMxb1UFl5/jcw?=
 =?us-ascii?Q?/bqiBbfVm3czGXvYHogteAKEL9oGDlaFOhFwtYMV56Ex72R/wP9B3MMkUNgC?=
 =?us-ascii?Q?PC200ok93b2kG1Rg8yNsopnVyVXfUcE2enSUghtMobDFmTLPYUGGN6LYACOs?=
 =?us-ascii?Q?fRVLqUg6hxICViv9bVy5dPPR1Y8h/coBMgsfo0jRqPXSX9e4GVNAM/4Y8uSU?=
 =?us-ascii?Q?lOJxyN7CTP311sgs9578qxJTiO5GZyZjfTH34WVqtUtlQ1DaKk/t5uiuNq+y?=
 =?us-ascii?Q?2U6hmQD9PO3LqSnNp9vnEem1i/JYQt1dQfX4Q5ZL8NZNK4SyNwTZCdkjfC0I?=
 =?us-ascii?Q?T6T5IHwSHBZRF7iIV9vUGd9i95/WlkT579g8pOFso56ihER26CKJ56N7I9jY?=
 =?us-ascii?Q?qIGxCXQmFSDRxEMXMs5DVHAqjp5athvKZIIr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:25:50.0497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 807df9c9-960d-4335-8fa2-08ddf0546a20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562

From: Cosmin Ratiu <cratiu@nvidia.com>

This was added in commit [1], but its only use removed in commit [2].
The parameter is unused, so remove it from the function parameter list.

[1] commit 9ded70fa1d81 ("net/mlx5e: Don't prefill WQEs in XDP SQ in the
multi buffer mode")
[2] commit 1a9304859b3a ("net/mlx5: XDP, Enable TX side XDP multi-buffer
support")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c    | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/en/params.h    | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 3cca06a74cf9..31e7f59bc19b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -1229,7 +1229,6 @@ static void mlx5e_build_async_icosq_param(struct mlx5_core_dev *mdev,
 
 void mlx5e_build_xdpsq_param(struct mlx5_core_dev *mdev,
 			     struct mlx5e_params *params,
-			     struct mlx5e_xsk_param *xsk,
 			     struct mlx5e_sq_param *param)
 {
 	void *sqc = param->sqc;
@@ -1256,7 +1255,7 @@ int mlx5e_build_channel_param(struct mlx5_core_dev *mdev,
 	async_icosq_log_wq_sz = mlx5e_build_async_icosq_log_wq_sz(mdev);
 
 	mlx5e_build_sq_param(mdev, params, &cparam->txq_sq);
-	mlx5e_build_xdpsq_param(mdev, params, NULL, &cparam->xdp_sq);
+	mlx5e_build_xdpsq_param(mdev, params, &cparam->xdp_sq);
 	mlx5e_build_icosq_param(mdev, icosq_log_wq_sz, &cparam->icosq);
 	mlx5e_build_async_icosq_param(mdev, async_icosq_log_wq_sz, &cparam->async_icosq);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 488ccdbc1e2c..e3edf79dde5f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -132,7 +132,6 @@ void mlx5e_build_tx_cq_param(struct mlx5_core_dev *mdev,
 			     struct mlx5e_cq_param *param);
 void mlx5e_build_xdpsq_param(struct mlx5_core_dev *mdev,
 			     struct mlx5e_params *params,
-			     struct mlx5e_xsk_param *xsk,
 			     struct mlx5e_sq_param *param);
 int mlx5e_build_channel_param(struct mlx5_core_dev *mdev,
 			      struct mlx5e_params *params,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index d743e823362a..dbd88eb5c082 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -54,7 +54,7 @@ static void mlx5e_build_xsk_cparam(struct mlx5_core_dev *mdev,
 				   struct mlx5e_channel_param *cparam)
 {
 	mlx5e_build_rq_param(mdev, params, xsk, &cparam->rq);
-	mlx5e_build_xdpsq_param(mdev, params, xsk, &cparam->xdp_sq);
+	mlx5e_build_xdpsq_param(mdev, params, &cparam->xdp_sq);
 }
 
 static int mlx5e_init_xsk_rq(struct mlx5e_channel *c,
-- 
2.31.1


