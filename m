Return-Path: <bpf+bounces-68001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD86B513E0
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3BD1C270C8
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 10:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD031A057;
	Wed, 10 Sep 2025 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V3EvF64j"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03833168EB;
	Wed, 10 Sep 2025 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499965; cv=fail; b=JSONxALpUQ7oM+hUfmED5hvFgw/wd0q2o73sqeFB4FVWN0u+xoBX8nB2pdzhX45ts+ohOkG3ksaYi6ubd267wNW3EAcczm551ZQZct5mgE4r0zmSZKZpDQm+rOEaE2zhu4NhLlMRy5BDzKjlvfDCF0eYAYX8mOiAwib72t+X7kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499965; c=relaxed/simple;
	bh=RGnfpjivlCd47IfeEWWycynYhsHSKlBqS6+/2Sa3ce8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kjzld2Lr5RPU/zhdgFd6FfunDe2TbjNoFMsK8P68Z+pbZvQxQWOIb0nZ5RWw4BGEgs+xZl2dpcSxdz7DqsoKwj/ybNKz5s3YM5G5ku+u9Ca8T0gc8SZEckWZ/AuVlqBx3NwYhs6c3z+4QIq0XKeztPGPEZxbya0tHDnGIyf5tK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V3EvF64j; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fk4Ztzb2CAKuT2oFoAmVpJs3Jv7HskxTO7cTLQXg5gYWtl3kagiWLaphx2CGkCRTwQ2x0rIa6xSH4xyB3gxAPQAOlGRjCQTLwBaZt74z8gSKEnfFJnEk235VYyTbpavy5JIRf1L5Zm55XCNhms9IEfz2l3ZJ5D1cBYlHsjsCZF7SmJA+W4PEXhi/C4+oTn0beHZD+cKPXnvTDXZFp5pzQ5fJzlyxCE6TExPDhSC0J9CRBPQu5FaR1qi2brwB9SmHtgc/R291zwdxbkjve3963UtQkXd+NT98Ic51bh0F++XfZEYpJSEn3Mg83a6g8HrWew3G55+j8Hlc96viS8U0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPn6eJYl5/tDQAea7TzyNQkztRML83XiJ+xSJ6PRF5s=;
 b=A9NCvM3YdM3RSf+8qiygj+JXahSTX11N3YMeXkD0WhpI4NMd3N2dYfd+nztlaNiCbbJOYb2mqG9EREnlieRE9EEi5IyMWr8v9T3kPVwovDMWLIlJmZmuWdvWBpck/yKQU59pcoAiknJcUnh2N8SS0TXIU4wbKIU6GfaxE1w5Pjnnj2BABXwIKkMbpmcAFujOqhoDglUH9PiVtg2YAoT2aaZDU2ErwyumCC/4dVwKGXwbP79hX5+dKHZBuu9KF8zkB/WvJYLhsEbXMPYzcIy6nxXkdP7wywMjrSLWOeSURyVfeF4SZASmgL39qnnetv4FJoR+EosNicx3yJxCTljodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPn6eJYl5/tDQAea7TzyNQkztRML83XiJ+xSJ6PRF5s=;
 b=V3EvF64jbSWikFuJx5oq/Xr+aT2aFUuGexm083rtPWa3GITd6MVLEez319tlsjkAywGrDeJ9/a7qFA8ckayLlzH03p9TcLMN6o/WEI2CPV8EYQrZnaht8MIu4QsodiZhEwRo/I+XQuuH5Op2RtgaloX/5VxVENmwxru43iQPW3hysAXCNt21fQ7qCMk+uxuWa7k6dY2apEj4NqUFai+1Wmh8tiTRT6jjUcWCgFtidvwPhO2GnZ7urXZasm+QIxn2HGm64ZFngRa+8uG6a/JlojSVMOaldXxblePDBFNJ3uU0tBppOTB/yQ1TyDF/ckZ2qsl8fZiZcq1Nk7iRq7zX/Q==
Received: from BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::8)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:25:54 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::c3) by BY1P220CA0012.outlook.office365.com
 (2603:10b6:a03:59d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Wed,
 10 Sep 2025 10:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 10:25:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:30 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 03:25:23 -0700
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
Subject: [PATCH net-next 04/10] net/mlx5: Store the global doorbell in mlx5_priv
Date: Wed, 10 Sep 2025 13:24:45 +0300
Message-ID: <1757499891-596641-5-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 445f40eb-ef85-40e2-1af7-08ddf0546c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LLIncueXclIZi+HLU5y6qvw+VgCjNwbW1PTmDelWUJPuiEyy11Z6/HKTAAyO?=
 =?us-ascii?Q?egP7UZhNEJeHaRiJTg4Te5CuUg9LUWq/BiJIbXkr7gcg72nRAwJ67NutuqC2?=
 =?us-ascii?Q?+rNq8rNxBMHQMYDZJwY5nLV54ShWBoR/50fLT+X6b/+JFGdS9mL6WmC2QYgJ?=
 =?us-ascii?Q?pWGzGi3hv2OG5ADMu9LyZiHus0oThnddV3ByQmMqVDRtSy6lM7Ug7CDBBsQh?=
 =?us-ascii?Q?dJFRdfPnq5wXZLGayJy4gpMpy14Jz2E1FCjbFi0/QZ1qM8e7w4AFyXDfdkkK?=
 =?us-ascii?Q?iM3wwT581r3bZdTRmfPSEt7IiHQ1T8MLfiIzn6BAE4HwUX5c3M8lLcY5f4N2?=
 =?us-ascii?Q?FQji2iBEFXUh2osPcy7BWNYE3y0KpqtSDTaFCpRAZCdbOeNBdYYugtZim6Oz?=
 =?us-ascii?Q?vXCXRBLkVZqKipmkp8VlaExYAGhhGA+SO4zvsWtgCUEpMyOTMUsOK1TCkYRN?=
 =?us-ascii?Q?IuIeGl1ZUjRWjOLoxOLMIoNw1Oo9/CD6iRcrCbN9dpR9MPUAiYuEyWWsirQx?=
 =?us-ascii?Q?Gmi3jYIUX7loqkT+yfObNkl5CEcJvUg+fsbRDkjUM0V8UB4w7mJQdUEAlA16?=
 =?us-ascii?Q?6Re3JMzu+W7WcSJx6YyyN+iSFS4RT9DWeByhrNTRYkqou1o6PWFN0H6qjwE0?=
 =?us-ascii?Q?QJiEiEBlHUHQB6ZzIe5sqf8TaTKoUWYjG/pN30Qr44cCm4r8597oxRdnx3GP?=
 =?us-ascii?Q?jH37gDZ8QjXz6kX1jLohesOcRWfGbTFxJUal0nybZibPqgmajyCtsRcgXoXI?=
 =?us-ascii?Q?vE6Q7kpZe4JspimIEN1Lt709Pa9ae7iIar7Mj1uSCUWDSwlawwJ54A30v7U6?=
 =?us-ascii?Q?Rzz2XleSld8n/eXWBajzQK/AnoWuh83Wu+1f80jAwEAsMB9vbxF0c5eRd664?=
 =?us-ascii?Q?iFPwF6KD1cNKPyWgiBpbVGcnfLS6IXaJm+mnddiqbgrU73qNOw+3SwnBJry3?=
 =?us-ascii?Q?0Ybg27iTG/O1m8/fxgIMxNuHutPedjYzqdZj1CfeWhpxlOSeavk2bzDWWtw2?=
 =?us-ascii?Q?Lrsbkn26DHGdrP628Dw3lIZPszmjFZec/hQAw5wVRb40u2XHMKkKV1qjKsv2?=
 =?us-ascii?Q?k+Tutt58Lfc8rLoKwtzB2fbGcj24UdYabbsmMklOthMltFaHJVsthiVBQXjM?=
 =?us-ascii?Q?sGPjLk3FKezPfeKd6/92WlHZjStEdPmYRYizdTxFpNEgKAxn8dgWkMhdYUZK?=
 =?us-ascii?Q?uo8Wlmcynff+lC2FLMddy+ekAhgE9OTv8fzOP+jLB96GiQlrP2GytzBqXati?=
 =?us-ascii?Q?+fKEtgxd4V6Lnydjwf1KWi0veeKCzSv3sVDFy3+/D3X0EJOG4lHVdg+pgWKD?=
 =?us-ascii?Q?38h6Y+KgS0f6xOMp7r1yfBpx6xYnzo/HOqycI8kyK/tDrjEDjWgYT8MNgMq5?=
 =?us-ascii?Q?5fpJaxEmM+4NnhqP1Yeq3T5GHtdA8D7yb4FkIGFvs4hnCnDQWcDqTdNyLhhc?=
 =?us-ascii?Q?QSALdh5FXFeRKZZYfyUy5KTbsA7W0swtuTdTKpBgDn6/u7oK3BFADVZfvmkf?=
 =?us-ascii?Q?WKABXdqIDKCxz/fm1M9/mZ6GXd0aYJDQ4lfr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:25:54.0325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445f40eb-ef85-40e2-1af7-08ddf0546c56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568

From: Cosmin Ratiu <cratiu@nvidia.com>

The global doorbell is used for more than just Ethernet resources, so
move it out of mlx5e_hw_objs into a common place (mlx5_priv), to avoid
non-Ethernet modules (e.g. HWS, ASO) depending on Ethernet structs.

Use this opportunity to consolidate it with the 'uar' pointer already
there, which was used as an RX doorbell. Underneath the 'uar' pointer is
identical to 'bfreg->up', so store a single resource and use that
instead.

For CQ doorbells, care is taken to always use bfreg->up->index instead
of bfreg->index, which may refer to a subsequent UAR page from the same
ALLOC_UAR batch on some NICs.

This paves the way for cleanly supporting multiple doorbells in the
Ethernet driver.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c                       |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/cq.c          |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c      |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c   | 11 +----------
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c     | 10 +++++-----
 drivers/net/ethernet/mellanox/mlx5/core/eq.c          |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c     |  8 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/main.c        | 11 +++++------
 .../ethernet/mellanox/mlx5/core/steering/hws/send.c   |  8 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/wc.c          |  4 ++--
 include/linux/mlx5/driver.h                           |  3 +--
 12 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 9c8003a78334..a23b364e24ff 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -648,7 +648,7 @@ int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 {
 	struct mlx5_core_dev *mdev = to_mdev(ibcq->device)->mdev;
 	struct mlx5_ib_cq *cq = to_mcq(ibcq);
-	void __iomem *uar_page = mdev->priv.uar->map;
+	void __iomem *uar_page = mdev->priv.bfreg.up->map;
 	unsigned long irq_flags;
 	int ret = 0;
 
@@ -923,7 +923,7 @@ static int create_cq_kernel(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 		 cq->buf.frag_buf.page_shift -
 		 MLX5_ADAPTER_PAGE_SHIFT);
 
-	*index = dev->mdev->priv.uar->index;
+	*index = dev->mdev->priv.bfreg.up->index;
 
 	return 0;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
index 1fd403713baf..35039a95dcfd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
@@ -145,7 +145,7 @@ int mlx5_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
 		mlx5_core_dbg(dev, "failed adding CP 0x%x to debug file system\n",
 			      cq->cqn);
 
-	cq->uar = dev->priv.uar;
+	cq->uar = dev->priv.bfreg.up;
 	cq->irqn = eq->core.irqn;
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 31e7f59bc19b..b6b4ae7c59fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -810,7 +810,7 @@ static void mlx5e_build_common_cq_param(struct mlx5_core_dev *mdev,
 {
 	void *cqc = param->cqc;
 
-	MLX5_SET(cqc, cqc, uar_page, mdev->priv.uar->index);
+	MLX5_SET(cqc, cqc, uar_page, mdev->priv.bfreg.up->index);
 	if (MLX5_CAP_GEN(mdev, cqe_128_always) && cache_line_size() >= 128)
 		MLX5_SET(cqc, cqc, cqe_sz, CQE_STRIDE_128_PAD);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 391b4e9c9dc4..7c1d9a9ea464 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -334,7 +334,7 @@ static int mlx5e_ptp_alloc_txqsq(struct mlx5e_ptp *c, int txq_ix,
 	sq->mdev      = mdev;
 	sq->ch_ix     = MLX5E_PTP_CHANNEL_IX;
 	sq->txq_ix    = txq_ix;
-	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
+	sq->uar_map   = mdev->priv.bfreg.map;
 	sq->min_inline_mode = params->tx_min_inline_mode;
 	sq->hw_mtu    = MLX5E_SW2HW_MTU(params, params->sw_mtu);
 	sq->stats     = &c->priv->ptp_stats.sq[tc];
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 6ed3a32b7e22..e9e36358c39d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -163,17 +163,11 @@ int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises)
 		goto err_dealloc_transport_domain;
 	}
 
-	err = mlx5_alloc_bfreg(mdev, &res->bfreg, false, false);
-	if (err) {
-		mlx5_core_err(mdev, "alloc bfreg failed, %d\n", err);
-		goto err_destroy_mkey;
-	}
-
 	if (create_tises) {
 		err = mlx5e_create_tises(mdev, res->tisn);
 		if (err) {
 			mlx5_core_err(mdev, "alloc tises failed, %d\n", err);
-			goto err_destroy_bfreg;
+			goto err_destroy_mkey;
 		}
 		res->tisn_valid = true;
 	}
@@ -190,8 +184,6 @@ int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises)
 
 	return 0;
 
-err_destroy_bfreg:
-	mlx5_free_bfreg(mdev, &res->bfreg);
 err_destroy_mkey:
 	mlx5_core_destroy_mkey(mdev, res->mkey);
 err_dealloc_transport_domain:
@@ -209,7 +201,6 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
 	mdev->mlx5e_res.dek_priv = NULL;
 	if (res->tisn_valid)
 		mlx5e_destroy_tises(mdev, res->tisn);
-	mlx5_free_bfreg(mdev, &res->bfreg);
 	mlx5_core_destroy_mkey(mdev, res->mkey);
 	mlx5_core_dealloc_transport_domain(mdev, res->td.tdn);
 	mlx5_core_dealloc_pd(mdev, res->pdn);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 714cce595692..02a538ec2ecb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1532,7 +1532,7 @@ static int mlx5e_alloc_xdpsq(struct mlx5e_channel *c,
 	sq->pdev      = c->pdev;
 	sq->mkey_be   = c->mkey_be;
 	sq->channel   = c;
-	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
+	sq->uar_map   = mdev->priv.bfreg.map;
 	sq->min_inline_mode = params->tx_min_inline_mode;
 	sq->hw_mtu    = MLX5E_SW2HW_MTU(params, params->sw_mtu) - ETH_FCS_LEN;
 	sq->xsk_pool  = xsk_pool;
@@ -1617,7 +1617,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
-	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
+	sq->uar_map   = mdev->priv.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
 	param->wq.db_numa_node = cpu_to_node(c->cpu);
@@ -1702,7 +1702,7 @@ static int mlx5e_alloc_txqsq(struct mlx5e_channel *c,
 	sq->priv      = c->priv;
 	sq->ch_ix     = c->ix;
 	sq->txq_ix    = txq_ix;
-	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
+	sq->uar_map   = mdev->priv.bfreg.map;
 	sq->min_inline_mode = params->tx_min_inline_mode;
 	sq->hw_mtu    = MLX5E_SW2HW_MTU(params, params->sw_mtu);
 	sq->max_sq_mpw_wqebbs = mlx5e_get_max_sq_aligned_wqebbs(mdev);
@@ -1778,7 +1778,7 @@ static int mlx5e_create_sq(struct mlx5_core_dev *mdev,
 	MLX5_SET(sqc,  sqc, flush_in_error_en, 1);
 
 	MLX5_SET(wq,   wq, wq_type,       MLX5_WQ_TYPE_CYCLIC);
-	MLX5_SET(wq,   wq, uar_page,      mdev->mlx5e_res.hw_objs.bfreg.index);
+	MLX5_SET(wq,   wq, uar_page,      mdev->priv.bfreg.index);
 	MLX5_SET(wq,   wq, log_wq_pg_sz,  csp->wq_ctrl->buf.page_shift -
 					  MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET64(wq, wq, dbr_addr,      csp->wq_ctrl->db.dma);
@@ -2273,7 +2273,7 @@ static int mlx5e_create_cq(struct mlx5e_cq *cq, struct mlx5e_cq_param *param)
 	MLX5_SET(cqc, cqc, cq_period_mode, mlx5e_cq_period_mode(param->cq_period_mode));
 
 	MLX5_SET(cqc,   cqc, c_eqn_or_apu_element, eqn);
-	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.uar->index);
+	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.bfreg.up->index);
 	MLX5_SET(cqc,   cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
 					    MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET64(cqc, cqc, dbr_addr,      cq->wq_ctrl.db.dma);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index f3c714ebd9cb..25499da177bc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -307,7 +307,7 @@ create_map_eq(struct mlx5_core_dev *dev, struct mlx5_eq *eq,
 
 	eqc = MLX5_ADDR_OF(create_eq_in, in, eq_context_entry);
 	MLX5_SET(eqc, eqc, log_eq_size, eq->fbc.log_sz);
-	MLX5_SET(eqc, eqc, uar_page, priv->uar->index);
+	MLX5_SET(eqc, eqc, uar_page, priv->bfreg.up->index);
 	MLX5_SET(eqc, eqc, intr, vecidx);
 	MLX5_SET(eqc, eqc, log_page_size,
 		 eq->frag_buf.page_shift - MLX5_ADAPTER_PAGE_SHIFT);
@@ -320,7 +320,7 @@ create_map_eq(struct mlx5_core_dev *dev, struct mlx5_eq *eq,
 	eq->eqn = MLX5_GET(create_eq_out, out, eq_number);
 	eq->irqn = pci_irq_vector(dev->pdev, vecidx);
 	eq->dev = dev;
-	eq->doorbell = priv->uar->map + MLX5_EQ_DOORBELL_OFFSET;
+	eq->doorbell = priv->bfreg.up->map + MLX5_EQ_DOORBELL_OFFSET;
 
 	err = mlx5_debug_eq_add(dev, eq);
 	if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
index 58bd749b5e4d..129725159a93 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
@@ -100,7 +100,7 @@ static int create_aso_cq(struct mlx5_aso_cq *cq, void *cqc_data)
 
 	MLX5_SET(cqc,   cqc, cq_period_mode, MLX5_CQ_PERIOD_MODE_START_FROM_EQE);
 	MLX5_SET(cqc,   cqc, c_eqn_or_apu_element, eqn);
-	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.uar->index);
+	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.bfreg.up->index);
 	MLX5_SET(cqc,   cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
 					    MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET64(cqc, cqc, dbr_addr,      cq->wq_ctrl.db.dma);
@@ -129,7 +129,7 @@ static int mlx5_aso_create_cq(struct mlx5_core_dev *mdev, int numa_node,
 		return -ENOMEM;
 
 	MLX5_SET(cqc, cqc_data, log_cq_size, 1);
-	MLX5_SET(cqc, cqc_data, uar_page, mdev->priv.uar->index);
+	MLX5_SET(cqc, cqc_data, uar_page, mdev->priv.bfreg.up->index);
 	if (MLX5_CAP_GEN(mdev, cqe_128_always) && cache_line_size() >= 128)
 		MLX5_SET(cqc, cqc_data, cqe_sz, CQE_STRIDE_128_PAD);
 
@@ -163,7 +163,7 @@ static int mlx5_aso_alloc_sq(struct mlx5_core_dev *mdev, int numa_node,
 	struct mlx5_wq_param param;
 	int err;
 
-	sq->uar_map = mdev->mlx5e_res.hw_objs.bfreg.map;
+	sq->uar_map = mdev->priv.bfreg.map;
 
 	param.db_numa_node = numa_node;
 	param.buf_numa_node = numa_node;
@@ -203,7 +203,7 @@ static int create_aso_sq(struct mlx5_core_dev *mdev, int pdn,
 	MLX5_SET(sqc, sqc, ts_format, ts_format);
 
 	MLX5_SET(wq,   wq, wq_type,       MLX5_WQ_TYPE_CYCLIC);
-	MLX5_SET(wq,   wq, uar_page,      mdev->mlx5e_res.hw_objs.bfreg.index);
+	MLX5_SET(wq,   wq, uar_page,      mdev->priv.bfreg.index);
 	MLX5_SET(wq,   wq, log_wq_pg_sz,  sq->wq_ctrl.buf.page_shift -
 					  MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET64(wq, wq, dbr_addr,      sq->wq_ctrl.db.dma);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 0951c7cc1b5f..89b224d76186 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1340,10 +1340,9 @@ static int mlx5_load(struct mlx5_core_dev *dev)
 {
 	int err;
 
-	dev->priv.uar = mlx5_get_uars_page(dev);
-	if (IS_ERR(dev->priv.uar)) {
-		mlx5_core_err(dev, "Failed allocating uar, aborting\n");
-		err = PTR_ERR(dev->priv.uar);
+	err = mlx5_alloc_bfreg(dev, &dev->priv.bfreg, false, false);
+	if (err) {
+		mlx5_core_err(dev, "Failed allocating bfreg, %d\n", err);
 		return err;
 	}
 
@@ -1454,7 +1453,7 @@ static int mlx5_load(struct mlx5_core_dev *dev)
 err_irq_table:
 	mlx5_pagealloc_stop(dev);
 	mlx5_events_stop(dev);
-	mlx5_put_uars_page(dev, dev->priv.uar);
+	mlx5_free_bfreg(dev, &dev->priv.bfreg);
 	return err;
 }
 
@@ -1479,7 +1478,7 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
 	mlx5_irq_table_destroy(dev);
 	mlx5_pagealloc_stop(dev);
 	mlx5_events_stop(dev);
-	mlx5_put_uars_page(dev, dev->priv.uar);
+	mlx5_free_bfreg(dev, &dev->priv.bfreg);
 }
 
 int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index b0595c9b09e4..24ef7d66fa8a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -690,7 +690,7 @@ static int hws_send_ring_alloc_sq(struct mlx5_core_dev *mdev,
 	size_t buf_sz;
 	int err;
 
-	sq->uar_map = mdev->mlx5e_res.hw_objs.bfreg.map;
+	sq->uar_map = mdev->priv.bfreg.map;
 	sq->mdev = mdev;
 
 	param.db_numa_node = numa_node;
@@ -764,7 +764,7 @@ static int hws_send_ring_create_sq(struct mlx5_core_dev *mdev, u32 pdn,
 	MLX5_SET(sqc, sqc, ts_format, ts_format);
 
 	MLX5_SET(wq, wq, wq_type, MLX5_WQ_TYPE_CYCLIC);
-	MLX5_SET(wq, wq, uar_page, mdev->mlx5e_res.hw_objs.bfreg.index);
+	MLX5_SET(wq, wq, uar_page, mdev->priv.bfreg.index);
 	MLX5_SET(wq, wq, log_wq_pg_sz, sq->wq_ctrl.buf.page_shift - MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET64(wq, wq, dbr_addr, sq->wq_ctrl.db.dma);
 
@@ -940,7 +940,7 @@ static int hws_send_ring_create_cq(struct mlx5_core_dev *mdev,
 				  (__be64 *)MLX5_ADDR_OF(create_cq_in, in, pas));
 
 	MLX5_SET(cqc, cqc, c_eqn_or_apu_element, eqn);
-	MLX5_SET(cqc, cqc, uar_page, mdev->priv.uar->index);
+	MLX5_SET(cqc, cqc, uar_page, mdev->priv.bfreg.up->index);
 	MLX5_SET(cqc, cqc, log_page_size, cq->wq_ctrl.buf.page_shift - MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET64(cqc, cqc, dbr_addr, cq->wq_ctrl.db.dma);
 
@@ -963,7 +963,7 @@ static int hws_send_ring_open_cq(struct mlx5_core_dev *mdev,
 	if (!cqc_data)
 		return -ENOMEM;
 
-	MLX5_SET(cqc, cqc_data, uar_page, mdev->priv.uar->index);
+	MLX5_SET(cqc, cqc_data, uar_page, mdev->priv.bfreg.up->index);
 	MLX5_SET(cqc, cqc_data, log_cq_size, ilog2(queue->num_entries));
 
 	err = hws_send_ring_alloc_cq(mdev, numa_node, queue, cqc_data, cq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 276594586404..999d6216648a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -94,7 +94,7 @@ static int create_wc_cq(struct mlx5_wc_cq *cq, void *cqc_data)
 
 	MLX5_SET(cqc,   cqc, cq_period_mode, MLX5_CQ_PERIOD_MODE_START_FROM_EQE);
 	MLX5_SET(cqc,   cqc, c_eqn_or_apu_element, eqn);
-	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.uar->index);
+	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.bfreg.up->index);
 	MLX5_SET(cqc,   cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
 					    MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET64(cqc, cqc, dbr_addr,      cq->wq_ctrl.db.dma);
@@ -116,7 +116,7 @@ static int mlx5_wc_create_cq(struct mlx5_core_dev *mdev, struct mlx5_wc_cq *cq)
 		return -ENOMEM;
 
 	MLX5_SET(cqc, cqc, log_cq_size, TEST_WC_LOG_CQ_SZ);
-	MLX5_SET(cqc, cqc, uar_page, mdev->priv.uar->index);
+	MLX5_SET(cqc, cqc, uar_page, mdev->priv.bfreg.up->index);
 	if (MLX5_CAP_GEN(mdev, cqe_128_always) && cache_line_size() >= 128)
 		MLX5_SET(cqc, cqc, cqe_sz, CQE_STRIDE_128_PAD);
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 5a85b6d91ba3..15c434fedff7 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -612,7 +612,7 @@ struct mlx5_priv {
 	struct mlx5_ft_pool		*ft_pool;
 
 	struct mlx5_bfreg_data		bfregs;
-	struct mlx5_uars_page	       *uar;
+	struct mlx5_sq_bfreg bfreg;
 #ifdef CONFIG_MLX5_SF
 	struct mlx5_vhca_state_notifier *vhca_state_notifier;
 	struct mlx5_sf_dev_table *sf_dev_table;
@@ -658,7 +658,6 @@ struct mlx5e_resources {
 		u32                        pdn;
 		struct mlx5_td             td;
 		u32			   mkey;
-		struct mlx5_sq_bfreg       bfreg;
 #define MLX5_MAX_NUM_TC 8
 		u32                        tisn[MLX5_MAX_PORTS][MLX5_MAX_NUM_TC];
 		bool			   tisn_valid;
-- 
2.31.1


