Return-Path: <bpf+bounces-68509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30A6B5991F
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B533A5733
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6D632ED2F;
	Tue, 16 Sep 2025 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jqZJdOeC"
X-Original-To: bpf@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7906D306B22;
	Tue, 16 Sep 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031968; cv=fail; b=etXYYvwOFqldtzieq5UpREkomITbauwnesoXWRZV1QVA1geHlGZ3X1bATI5WXW9q1GzFGRVu/nrTMkj/5EOw0iZhjy+I7Q3ihStvfIhfsD4WanjM0+5xoJsSuZHDeBHv8kDEuQdzU0vmq9K7WCvTBQtjFp8ioNZU04N6X8/lkA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031968; c=relaxed/simple;
	bh=KH+CmzkfS5fJrZkpksUfnaDscStSRmNdk2M1CSnnjXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paEPpRwQI0D8kbJGw3bECZwUIc8g5QtXB8ZtHr1T0bKmhvZ0w1Tb1iQIG4eOk4Dy6otrXS9ZKm1jhDPuDzT4ClJRhy2LiJJGgYqZwvytw2J1ZZoBLbWu2caeFs/X34jkws6hMLzmK3fhvdbC9oi6VwFrnl5ZFjAFDVvKK/wfDdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jqZJdOeC; arc=fail smtp.client-ip=40.93.195.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lygYiKNxfJyPEDkMrn5akk/rHobyW5Aog4KOGMYiOg8tAOS7Jl96xkdmNfP000/g5unitCEBtHHvYtklJLKZ8K26RWmeRXtatEyDTeMhVZyF27x+AH2wBv26VmwxbWXm7uc+FSno4+pFh1Phc0KYs8RThV7Bul+GvEg9T6GOcyefbFn5p3EwCsb0Fm2enThI2E5Qj9h94+4uas215cUlazzsXiE/UqQvWud6IEUQdM1zHKn9cBV3tI5JNoRej+Gxkkrc6fJvUP7bnA6qdVKKhkuwv9d1N7mbwQZr+efqZrKFTmjQBOozpjcW2zcxJqxTuB5oNL9vIvr4xaG3cw65rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJXE+myfLkG9n9/wSbm20MzuplAyS0ccxJDIiVUn6Ks=;
 b=pOGQKlLFRrXekg/EJ1uhmbs8QNW7ot0+B2hijeGvNWUBO08z+i17cPIpxlgXMY3inR2a/F7lUATDMisygFNPQUtKLc7D+8ehNAEw+eP395OLyrgDh7nwC5zhnnh76K9JJFFaSVjeCabxIri6XpzwHTAWM0qbfmwyBB6LREVdtvOPRk4ZEDMFU5PWrIGtJ01Q7TJS0XI4PQ68uUSsS09bup/6ADi0Y0VfyKdPwsbxEzaq024AEyg1S9oz/5ZtQFHz7y1dqTgIo3x1tXym7Ysx7mzWyh25SKpNpIMfIJyITTyWMa8xulizz1tx3jiN3pDbNVNi9fP8AHnmJ1fKJrM0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJXE+myfLkG9n9/wSbm20MzuplAyS0ccxJDIiVUn6Ks=;
 b=jqZJdOeCaF66SGWgZS5Yn1xlLLdhM4RTvIWg6dzSScfEyZRf9PHC/cFglJ9YeQqxkU0dIuRv9G0y2RqktsetEb8M4aN6d0InTQZCXJNf7iAUW6l0hE+rdYoBF1mWoO2Da4lPlXKI6jd9ZFt5y7+nHSr/TrJU8eeeWYlUyHIfo5ZFmHF9tB02xEMW3SCjo6e4EyRAFPeuAjOLCER+mxri5lDRm4gR73kWmiQ0NZwOv9SvvBp+yFuWJFww2hGJUBcqfPW+okhoEUiEnCE2D3/KHpITaKQgPQFTFQMZEVLn3uUXzd+IqW7m7H8FjCBa/f5yBOFrpGw+/HyStUj8nkVOkQ==
Received: from SA1PR02CA0010.namprd02.prod.outlook.com (2603:10b6:806:2cf::16)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 14:12:43 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::47) by SA1PR02CA0010.outlook.office365.com
 (2603:10b6:806:2cf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 14:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 14:12:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 16
 Sep 2025 07:12:16 -0700
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
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH net-next V2 02/10] net/mlx5: Remove unused 'offset' field from mlx5_sq_bfreg
Date: Tue, 16 Sep 2025 17:11:36 +0300
Message-ID: <1758031904-634231-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH1PR12MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 72319b14-f607-4613-e109-08ddf52b19ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rcxNf+d+W2crS174OVZ57ppIGslOm1GzuaHuqX5v9VOiT6k9hDcjL+qwUd+y?=
 =?us-ascii?Q?b0ZLBx854C53y5/Av3C46k/DKinAC4Yf5Gr/eky5SJQlgUydHI8hG6CpnLsl?=
 =?us-ascii?Q?Q1tjjq5jRJNe3jBjV9VupPiEHnrbj12FNZhNWixfFSQB8cuNfLYgOuuwMhUa?=
 =?us-ascii?Q?LhBRHu0LSRk6ntXIyEpPyyN7Kt/VkOPSMhF/BeV6L9dkAssSAmP/EbtL1pcj?=
 =?us-ascii?Q?1V6+ph4pFwoy/OdJTr3Qx1Gq7fVX5hCT3qZy2Ed/Khm8xZsUvcmdgbatE48L?=
 =?us-ascii?Q?Q+hlNOCDpcVoxvmwTJN12AbyLnce96wK9qwf0S8n7OX/dKREtZBtMoBVtoG1?=
 =?us-ascii?Q?Jqy0D2R/aJwkGYaEy8mXG2rKvI7AFaWyXlycFleHh4LOZakzpK7zOKsOm8Qn?=
 =?us-ascii?Q?UHdFTnmJirtskjikLK9D/yuqEAJ88j42N6KSMuXXMyuG/hYX4ul2EyBo1vJx?=
 =?us-ascii?Q?ngAirmVST15mL90FWr8SnxfafMhi39rx6aqmRF8lHxKtwmX6RxaVA5EZ9lrM?=
 =?us-ascii?Q?2f964usmQ1/nXrCRgf6v9ZZFHKI9Rcz1n2qe4xI1cEP6cksAFm6pvbrlbgZV?=
 =?us-ascii?Q?iXC9z553/UTKgJvBXudBKSyKhJUViGLr2TT6op5MYuJV0H0LmTOuqDhQbnG/?=
 =?us-ascii?Q?Sqf2DTw/r6eoWgDosESgZGguGtZhDA839l+geX28N5N7crtj3Gn1/KUjiOU6?=
 =?us-ascii?Q?gVzHW1QdA5cJrH2Ui1+vLmbeRoI3kzAq06ZBnsTo3QqQGyUpLMGbPnh5DG17?=
 =?us-ascii?Q?SqltptqJ+VYFMIMcofBGWUi4d0NpgF/FpDHcNW8H02mrEXKvhK9ZnpG+SX5G?=
 =?us-ascii?Q?QylU776SYBDqhi1TpD4O4yEAw/FrRdpaqQEHIdNTb1vXjU8bFIGdAG4Gu5Cg?=
 =?us-ascii?Q?7V8H7cKN0+DQzuTeIAm2++55CNB4SPlDHeQBZV1GtS3MRVeyc4UNz3OO6FLr?=
 =?us-ascii?Q?Q7PMuiXy+IFhfwRxEF3270DQ1CgxJsjbpdWUEtAhoRTwrctMK8w9vUPMFfyO?=
 =?us-ascii?Q?97mU2h2oOdr5oOYnYf8pfmgpU+X2ffemigtcZrwh2fH1rILcQS7zRbC44iYL?=
 =?us-ascii?Q?TE69UUDj1MvEwYhauqm9T765d1PtcNjjLBtjke/MKDwqxsRmKXd+smlIedms?=
 =?us-ascii?Q?J/lfUT9QRHANoumbc6cu+mqkZMHlmx3X6jg2IC7KrjW9yJSgDQqXPXcGGswG?=
 =?us-ascii?Q?QRVwgL8our8g2i9nAKm+DcphRTEzBV07qlSHBfvEK4e39N1lYvY+1i/PYptu?=
 =?us-ascii?Q?T8ygx6xCf2rQeKaDkeHvFvgKTKA/q0+2VfXW2fodEunAAHO+wReH885ZLjy5?=
 =?us-ascii?Q?2Cq2xVUuGo/yBpLiOAbUZpxk20qhAhJaq8+GnrvcxrmlEEejVrhTvXYtQGWU?=
 =?us-ascii?Q?KzxNimvOG2vFuLllIrGvwpzOvxEpKgdrr2Dl/s3XIWjLRMevmf5G39PptJzT?=
 =?us-ascii?Q?iIwkuZdcdytXXKzZIVDmZiAPYaNAzOlMQ9TSsN20KFlLtmnRbtgBXF8ZXYfr?=
 =?us-ascii?Q?fedwOmAwW3pGlDgpR/I4qc4FnSIMYr+vkrlw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:12:42.2133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72319b14-f607-4613-e109-08ddf52b19ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9576

From: Cosmin Ratiu <cratiu@nvidia.com>

The 'offset' field was introduced in the original commit [1] and never
used until commit [2], which added an unnecessary use.

Remove the field and refactor the write-combining test to use a local
variable instead.

[1] commit a6d51b68611e ("net/mlx5: Introduce blue flame register
allocator")
[2] commit d98995b4bf98 ("net/mlx5: Reimplement write combining test")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/wc.c | 12 +++++++-----
 include/linux/mlx5/driver.h                  |  1 -
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 2f0316616fa4..276594586404 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -255,7 +255,8 @@ static void mlx5_wc_destroy_sq(struct mlx5_wc_sq *sq)
 	mlx5_wq_destroy(&sq->wq_ctrl);
 }
 
-static void mlx5_wc_post_nop(struct mlx5_wc_sq *sq, bool signaled)
+static void mlx5_wc_post_nop(struct mlx5_wc_sq *sq, unsigned int *offset,
+			     bool signaled)
 {
 	int buf_size = (1 << MLX5_CAP_GEN(sq->cq.mdev, log_bf_reg_size)) / 2;
 	struct mlx5_wqe_ctrl_seg *ctrl;
@@ -288,10 +289,10 @@ static void mlx5_wc_post_nop(struct mlx5_wc_sq *sq, bool signaled)
 	 */
 	wmb();
 
-	__iowrite64_copy(sq->bfreg.map + sq->bfreg.offset, mmio_wqe,
+	__iowrite64_copy(sq->bfreg.map + *offset, mmio_wqe,
 			 sizeof(mmio_wqe) / 8);
 
-	sq->bfreg.offset ^= buf_size;
+	*offset ^= buf_size;
 }
 
 static int mlx5_wc_poll_cq(struct mlx5_wc_sq *sq)
@@ -332,6 +333,7 @@ static int mlx5_wc_poll_cq(struct mlx5_wc_sq *sq)
 
 static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
 {
+	unsigned int offset = 0;
 	unsigned long expires;
 	struct mlx5_wc_sq *sq;
 	int i, err;
@@ -358,9 +360,9 @@ static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
 		goto err_create_sq;
 
 	for (i = 0; i < TEST_WC_NUM_WQES - 1; i++)
-		mlx5_wc_post_nop(sq, false);
+		mlx5_wc_post_nop(sq, &offset, false);
 
-	mlx5_wc_post_nop(sq, true);
+	mlx5_wc_post_nop(sq, &offset, true);
 
 	expires = jiffies + TEST_WC_POLLING_MAX_TIME_JIFFIES;
 	do {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index fcfc18bfeba9..5a85b6d91ba3 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -434,7 +434,6 @@ struct mlx5_sq_bfreg {
 	struct mlx5_uars_page  *up;
 	bool			wc;
 	u32			index;
-	unsigned int		offset;
 };
 
 struct mlx5_core_health {
-- 
2.31.1


