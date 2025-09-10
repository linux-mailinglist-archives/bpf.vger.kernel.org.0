Return-Path: <bpf+bounces-67999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3868B513DD
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52D91783DA
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 10:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E1D3164BA;
	Wed, 10 Sep 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kn3YLwiu"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7895530C635;
	Wed, 10 Sep 2025 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499951; cv=fail; b=c2FO0gGXiIdYh9HbyjzFYiQPP2eCH6p4+4XpdB3D+kiK9Y0+zlwinCCcMULE0X0+WvVvRaWT8JbXdFMWS+BEsUDby284QXT766RGhX4tiriE6gnm9gOSC1THNkLhGA8FWzqybC9CTC0GMCFqcdw24KvHmEPBichXuQeBow3thNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499951; c=relaxed/simple;
	bh=KH+CmzkfS5fJrZkpksUfnaDscStSRmNdk2M1CSnnjXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/25Y5NoOWg4Iw4y9pR4SwUVji1mD97ExDDFKa6qYsNLpn6d9zGflNeb8wHik/M3cqiVMQKsXwy2hZ5n+7HD2bASchXx74lsd//B4onrY687QhVPF6i3YS6/RETKylaoaUJUWQ+u5Vf+MAOa+UBTDAV2MWugmgLFCcdD2ppJGzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kn3YLwiu; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpDQH6RUC+CzoBkmMshpsq/luYgebubxoD4DfUMrdisHXvTtP4ZJx1co0uW2BwV0DcV5vSNij7qRDshMWGD2fNnMktb24mVHnaavf65g32YZGSrm4qeqjx6raXUGliVGkzQPskqv5w3xUogk2cVBqMe/BOu8Ss50dx22T38PM7ZvxJ9PztIbtmNjoRxc3E6wVGaop+ZfDIS/FBe+UwH+RyhMio6Zi94EX5zF+gYTdUBNNZGK9vBhtd7qG3RZmja1ckTrbxsP6v3ZcMVSv06wE+GF0O1Yo5/CGmCFEV+eY+QXWZJ+oDyZUrSgbPrtKbJuuqdv5KOwmmOafgaC3SeTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJXE+myfLkG9n9/wSbm20MzuplAyS0ccxJDIiVUn6Ks=;
 b=WNi9f+AG2ACr5ZmBGSWmY9dMCFn5Q9MToBi9M0tzdbWFu/A452FB6StRnxcrL30rRs1ElfTVq3A6q/5Dg8YuWzt/Vv1fcydc2v9nM0ZAxk6OqEHlHqNHlLcI0fCY+H2kveKwNwM9bm2Aym0tw6UlwaqXipNBSS2SnXA0YuRTbKfH6moGsx27JFHF7P55hvSvgu8NC/Bmg5pdoAJAZSlWxQleiHhYKJKPDzUp7mrk7N+eGSr6Z06eypo7KEZYVzcZJwXWqd6Gbf41m3DTYa2Ap6S20n933qDmU4tKh+OPABZMCQOprsQRLyalqDj+dO/jyidQ1vo258c5/JQ+9V+j1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJXE+myfLkG9n9/wSbm20MzuplAyS0ccxJDIiVUn6Ks=;
 b=Kn3YLwiuWTh1T08zT/0Xs41jB9wfZv5zlTrCb1cilHG7l6++Xh6mUE7pbqw9DzIrUA8wlCQyQ9tQe4mkU4p5WqAnldfi0t2mnaOFIz0ZNTgAzBJl4KRsBaQPrtQGfHlV4Tf5KyzhV5KgVSmpho8npxzvsXwqtIne64Bvo3To25qbapyscKsvhJy/0TrwNBVcUXCT9KjklUffdHp3do9vfETcq+IhC7V6HvAZify5FDRzIo1aKFV8PKDO4ajsPABiff30MLrbJ+guWo4LZuK3l1yEEVFYXHxiYFwiBuFb/q1pJz9NZxWVbEMy2h5B/oVrGNcDMMCtMd0JvO8+oeKedg==
Received: from CH2PR07CA0030.namprd07.prod.outlook.com (2603:10b6:610:20::43)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:25:43 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::d7) by CH2PR07CA0030.outlook.office365.com
 (2603:10b6:610:20::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 10:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 10:25:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 03:25:09 -0700
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
Subject: [PATCH net-next 02/10] net/mlx5: Remove unused 'offset' field from mlx5_sq_bfreg
Date: Wed, 10 Sep 2025 13:24:43 +0300
Message-ID: <1757499891-596641-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 047ff07b-9075-4304-b74a-08ddf05465f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?egA4T4GjBjLc9MRVjCwpZ7qSp3sZYhoTPSEh+S/p/ivsNRUku+rNhvnZrcxG?=
 =?us-ascii?Q?CGMWT5HBjOpNGgp4S5ggnO+azBAv6Y1p+wdjc+4TwtjfcaIF12JJ4jNzjQE3?=
 =?us-ascii?Q?i5hTtnb6FmXPUq9ouOR+3eDdqUZ39RB5EmEUfPU+U8XrUEFmszJyRG9iy/1T?=
 =?us-ascii?Q?XDdSW2nAvWbVc+25aTEkmACvOgYblezYZNUhJ74XGOIDrY8+e3D1K+MI/Y0P?=
 =?us-ascii?Q?VgSgLqhXavfvrSGbtMKngXXKkatcX32e1WtF5eJqkOp0Mi+W3Zp9PI5hkW/e?=
 =?us-ascii?Q?MdbA4ybW9yxQCVYM9j3DyW9WpfvvvugjLV76C00fRh659OrKpFH+WUbYYJAn?=
 =?us-ascii?Q?iFSnmAfe2x3NEZxX1VeA1qA8hxweKlofzHdwi8DJnMZjPcYr5dwiaZW2kPS/?=
 =?us-ascii?Q?LpsQCkDwAPSbeg9oymIPfHf1qKjtqITRP9YXkM1nx4Mh1g2P3PoSmU0Kzwmp?=
 =?us-ascii?Q?Vg73ByYTUNDfuOj1iDnZV5LHt+KYOcl80wp/rWg9i//QxsR24K6P273fqTET?=
 =?us-ascii?Q?SS6zI1yBZzg2BNSsaS+/IFVehMqS70MDlf9ih6OdgLWQtACcti2zvhI+LTgi?=
 =?us-ascii?Q?+TkA4796M5mOHbs+Il1Qqj9JSmD27lr0R3qDMyyfvp7ov9tQa63JcgPhlBSV?=
 =?us-ascii?Q?LJQ3yMjp8hXNtgM+cV985IT5aO2KZdeMrrxfik6nzoHYjJ7wBoWABujLc52L?=
 =?us-ascii?Q?fmY5pUL2dxXUfFVtJhBK6x8jjq2YdY/T2ApDjtefE/ZHwNtSWTWdCWdlBJcW?=
 =?us-ascii?Q?M5xUmIbzfQgqJN/eIAKrO1glfwjJKlPpzn1fXbx8WRNx8p7ZFJ7m74x633NY?=
 =?us-ascii?Q?B49q8XG9mQekb+sgh97uOe5bPiHy7ybFJDJWirt9V7JT50ya01CdHCC21kXl?=
 =?us-ascii?Q?LdfWTbsJMeHovVGxsEs/xO+WVKm4RfaEeLYNlN8p/LxmjV4qKggwOGWUFG26?=
 =?us-ascii?Q?kkXH03Q/2hF9zojyZqq/jGmEuBXwGQ61Eu3L7HGn7be9sObKyZX+K4FjRHMY?=
 =?us-ascii?Q?2WxcbeeMKlxJ45GW5wQDuwU4mJJw/3LsrbxzcNjPJn+OF36kSYQxVaMCio7W?=
 =?us-ascii?Q?0tVH84wsD1j1BDgbUa52AF18LFNQnRmEcUGVK+Y+crWPHaecwW7zccMs8IrH?=
 =?us-ascii?Q?L+Zp85yIL4Cfm4MV5FzZouZO0qVjRnZ4Gu1isbqPZJoFZXijKXEZw8dwFZrs?=
 =?us-ascii?Q?C7najDuS/UeIr9+IGNMRYXjvP4b5eA4vcSsBaw86N4qcntRzTae/p1jQmXYb?=
 =?us-ascii?Q?BXdgdBf0+xJSEyA/HyaCXLhNSASS3Q9DdE/iMbA16+ML5ShKij535TYeuE0o?=
 =?us-ascii?Q?/ZIZ9iCU7n1V1MgSukgDpwxiSkBg2eAFpYki78gT13e9oJm3u/5rTLlbJ2ta?=
 =?us-ascii?Q?SpiOi3mIDtNiDquRvt3MhxCLY7VmPrf1EOjTUXl/G9/yuKvtS8iTRDFp3Yc7?=
 =?us-ascii?Q?4TeZnIUjbrkLO8CZiR6ZABH4wCBVimj3tlImqandyiu0B4ZKY0kESAD2emXM?=
 =?us-ascii?Q?ptK4vKmw7LGC0lCrwdpPytmHZ3OO1ENHl40b?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:25:43.2740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 047ff07b-9075-4304-b74a-08ddf05465f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968

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


