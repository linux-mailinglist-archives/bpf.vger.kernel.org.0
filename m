Return-Path: <bpf+bounces-68513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA2CB5994D
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0663B4643CA
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51B33431E7;
	Tue, 16 Sep 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="trsX/7Od"
X-Original-To: bpf@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C330E0F0;
	Tue, 16 Sep 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031989; cv=fail; b=lYpDE+BDbVxib7sc+SdR/SG7Fq1g//mJMF6PTbPP/PGG4NXKWAPMimFH6S04Y/V7e6kUAnAHzyJzLHwD2orrQJO4jJ4nfBADIpbxx6BLAmjx4H6BqdK5FGIcHToiNV9BIld/rFkcH60sUVuqBdxGajsM5VPq2UBRxGGqTBZJ640=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031989; c=relaxed/simple;
	bh=vpd1dukzLde31aeuOlxlT0sns0OE7J5AD5m3OPOHpWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEDHkqXZx1k98ILZR3EwA/aPVIeQM2Kyf7lZU9n235fqAbc8zjYo+bz7gzZ+pDeCz6zXTxdE/RtgqiZ4TiDlMnl0Y/TLimn1Zn8KjoxtsYao1u4S6QNyEqH2mBbLfZu+nvQiF9s47Wv1ndPVdHB+BB7zEHLHTgPTBCq7M1Ky3EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=trsX/7Od; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmw625mqNzibt10b69dRxEgTk4/BX68B+d1bLlKXMYBhzO53sIqYdQKqs7/18bOhgi6T6gjrJL63dI1IKjN7w1DNJCybO6EpLRisuUzdpWVHz5byvhCjcrELZj7B1ES+rEa+xwHK44/+r8/FYeghm/9Uv4R1FNDSTIXhkduXa8WMYSJ2O8JqyR6dZi8RQ79tUgwyLFpgV79CvwRwWLYaXZ7tRkYj8O9DZj3s+GubvVIxhvj6Af//f4HKh/7GDsWDkt5Bs1L9/WZGot02ug20bzqxXwyTu7nJKm7Yvi/tCH4q0kTo2yJfN0wVCnS5+5VecFMjeEEVQ0K8O/0wqzJhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0FK8KLvOgyKV8Bk17NKjZv9+JmbFwcJEKdtUD3LSyk=;
 b=CZPFsg4RfSRwJ1mhK+kJjUSbJCB96fkTtybme4GBnOWi+9xIU/43PxQKt3TVmECL5gx+53h6Bu5sCbWW9vzq7gfta4Fbs+gFV8HZpuMPHIGK6M6QUOte74PruPzmwKjVrqDkuM2oW3ND65LNHYOEvjuV3FdBU3HRm15UkKfQCQg50dniQTbOmzon4ubWPg/T1FE97giHrMbcDz5nLfrzA+sbCX1IltaLKESdXvlHhrQjB7msstdBJ+x/GpntTSvDEzFCZpj2KBcRfiGUCtlHKY2BeYDC33GvwUF6Gkt3uK5ltCiXSjqkdKf+UMR2x2cVv2Fr+5Ghs+VJ0HfAWOXcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0FK8KLvOgyKV8Bk17NKjZv9+JmbFwcJEKdtUD3LSyk=;
 b=trsX/7Od0X1fcq2096BRFoU3JjeezhqfGJBNfUXsNXQl3SRUTLCrDDemtXu3EDApUzBrgLCcwVEA13snCL+xYOAczeJARUY0+DVnlmVH6RVX4fXRIzQnLZZs95+aLX/hdrbD2jEqqNHvv5MlIdlnHIhRrMK8SE4hdv3lGlWI8F0nCNsEp4AWAVWATE4F1HrSgQazWToX9lBnziBfs99BBu+yU9Aeh/dwK1FvB4dtjFhI+5c7ZzCi4iQWEOqfAkR4+HYhhMYqh0K8RGQ15rVTVXAWR9I3FH+6UxFw8a26Xqo5eoaaLxUAzTlcjxES9vyXg/JcS+lyTzY9XYd2RogI4w==
Received: from SA0PR11CA0039.namprd11.prod.outlook.com (2603:10b6:806:d0::14)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:13:02 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::7d) by SA0PR11CA0039.outlook.office365.com
 (2603:10b6:806:d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 14:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 14:13:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:48 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 16
 Sep 2025 07:12:42 -0700
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
Subject: [PATCH net-next V2 06/10] net/mlx5e: Prepare for using different CQ doorbells
Date: Tue, 16 Sep 2025 17:11:40 +0300
Message-ID: <1758031904-634231-7-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: e7448fb1-bff5-4c1d-3240-08ddf52b261c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gPUap6NCyZRbwItlVGYaRE3cccq7bmGz9+oNalguPVcF2RbbO0aOdleI2CvZ?=
 =?us-ascii?Q?d8IEGBEnhRPjcivR4kOczsYoh3jzOY7Jp3oAeAk2cdUjc2jH+MZYMY5zhQNS?=
 =?us-ascii?Q?iFwMLh/O4XZCX2v61qPdll46YgBrvjVvl9rLk+Dn8oWCat3Kewkj1arRIF8U?=
 =?us-ascii?Q?iZfvUfta7VbEym8WPssn99RoPWBOg0lffgvnNnaGc+KuvPRMug5cBMV8sNGy?=
 =?us-ascii?Q?RnS7o+b4BnIMR2WUF0dM4LpGaCVGxSpZZ2SZAwe1Pt4WvACiSEO4gXOKhpQT?=
 =?us-ascii?Q?xaqYJKz8ar70FLVdGyOfWBsb0OkUNNP0o+gnADc4MyIC+pNsv38ylQaaxRNz?=
 =?us-ascii?Q?7mBfFwMAyFEle9xlcNp0r7tkpUoSq7axW7kWhKVYG6/EmS5ExYJHMNmzgs3o?=
 =?us-ascii?Q?wprcxEV4IXeAMNbvyXeNN5GcuIiqs+UDnzzPQyJX+7i3vhGzNbvHW23jcn1H?=
 =?us-ascii?Q?yxg9+rQhRcZsP9ZeRek4BZm98twNkA3RpRC3uNv5nnWk+brgEMR4TqCAD90E?=
 =?us-ascii?Q?CtJTL2MKTWFpvfyV8lr4CPK04bp4TnRzlRSdPHicvWaFNUsd78e0/qaIoyZj?=
 =?us-ascii?Q?byn9ybwUhCOCLuefVspbaYms9Y1DpsXDlf1JtJvEWLPVtKRnt+t4qNzPx23Q?=
 =?us-ascii?Q?miAiowFX4Tcd40sb6zcgrA3F1S/RVV9B/BB55Unpx2i43qAr6TjliXI0Qnw8?=
 =?us-ascii?Q?KT46fFs0Duksh7J3swYH+7jhKolD0y9dlNcYNYpQvtLaYfXbV8zKCQIlZCcd?=
 =?us-ascii?Q?IgggMzIIcb+tCqxP8D7sU9L3vdeRmo3AFoC4GEol0AuOUh2g7rLNFQQXpF7j?=
 =?us-ascii?Q?V5G9lLhOo4365ckRijOuqQxblOoYGh8rTmNg53Kh3RLq3dQ1QEKTK0uNTgNA?=
 =?us-ascii?Q?y3G1dk02yJoouIp90+bippawr/HiMnQLds2gxlNtaaz/tTZU7dLb41TbJs4M?=
 =?us-ascii?Q?/duVVDs4zJo3jtTfhKe6Av8QftKcglz37cvF/O736euuCFoceEAxfXPk2XDW?=
 =?us-ascii?Q?ICA8UgZ3LQ5PXeJ4RGvO110hV06+qCCxk5EEdjDVgJkZ/uwdJcJvx1nQIbXo?=
 =?us-ascii?Q?UBWwBTJKKvliZtMcs5Z80NvPQXxpFYc4k1FSGQOcFgQMDQLBd4FXKBmPDh3u?=
 =?us-ascii?Q?EMeb8gIirtltlHwoSWUFIsfhJZafGIO/LVyEh75OKkiGe7m/WQN2qx51C2OE?=
 =?us-ascii?Q?dDF+yDuPD4hjIqS2EjTEFKEnfSYyByNEuAlWqy0Pq7JTOrc7VxqQozHk4CyF?=
 =?us-ascii?Q?EVLlwD7rpcYigwOqr0TzeA0KiVrBbPLa/AvhdPD8gsIQqLpPwabJHVLXY8i/?=
 =?us-ascii?Q?fZQiPR6o+Q7g4FPwp9Ha/bZEKoDBvckyL20XJd2wCuDbsKiMxnsOAzbxz9v8?=
 =?us-ascii?Q?sW1/5+VGX+chYpMUBsgXUBpRtOMiJCLv4lCDMyQItEXxE4tJ8ciCRNwO7Qc5?=
 =?us-ascii?Q?oxsbWEpWk9iwE5zWvtVGnhhd3IkdBJ+eX5PdLls+f0/BQkeln8KMvSsiz7XP?=
 =?us-ascii?Q?xla0aVMS7I6cH0j++c+RYGyyQni5jetfkNuy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:13:02.6956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7448fb1-bff5-4c1d-3240-08ddf52b261c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259

From: Cosmin Ratiu <cratiu@nvidia.com>

Completion queues (CQs) in mlx5 use the same global doorbell, which may
become contended when accessed concurrently from many cores.

This patch prepares the CQ management code for supporting different
doorbells per CQ. This will be used in downstream patches to allow
separate doorbells to be used by channels CQs.

The main change is moving the 'uar' pointer from struct mlx5_core_cq to
struct mlx5e_cq, as the uar page to be used is better off stored
directly there. Other users of mlx5_core_cq also store the UAR to be
used separately and therefore the pointer being removed is dead weight
for them. As evidence, in this patch there are two users which set the
mcq.uar pointer but didn't use it, Software Steering and old Innova CQ
creation code. Instead, they rang the doorbell directly from another
pointer.

The 'uar' pointer added to struct mlx5e_cq remains in a hot cacheline
(as before), because it may get accessed for each packet.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cq.c           |  1 -
 drivers/net/ethernet/mellanox/mlx5/core/en.h           |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h      |  5 +----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      | 10 +++++++---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c    |  1 -
 .../ethernet/mellanox/mlx5/core/steering/sws/dr_send.c |  1 -
 include/linux/mlx5/cq.h                                |  1 -
 7 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
index 35039a95dcfd..e9f319a9bdd6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
@@ -145,7 +145,6 @@ int mlx5_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
 		mlx5_core_dbg(dev, "failed adding CP 0x%x to debug file system\n",
 			      cq->cqn);
 
-	cq->uar = dev->priv.bfreg.up;
 	cq->irqn = eq->core.irqn;
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 9c73165653bf..1cbe3f3037bb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -344,6 +344,7 @@ struct mlx5e_cq {
 	/* data path - accessed per napi poll */
 	u16                        event_ctr;
 	struct napi_struct        *napi;
+	struct mlx5_uars_page     *uar;
 	struct mlx5_core_cq        mcq;
 	struct mlx5e_ch_stats     *ch_stats;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 5dc04bbfc71b..6760bb0336df 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -309,10 +309,7 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
 
 static inline void mlx5e_cq_arm(struct mlx5e_cq *cq)
 {
-	struct mlx5_core_cq *mcq;
-
-	mcq = &cq->mcq;
-	mlx5_cq_arm(mcq, MLX5_CQ_DB_REQ_NOT, mcq->uar->map, cq->wq.cc);
+	mlx5_cq_arm(&cq->mcq, MLX5_CQ_DB_REQ_NOT, cq->uar->map, cq->wq.cc);
 }
 
 static inline struct mlx5e_sq_dma *
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 0425f0e3d3a0..ef7598e048b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2185,6 +2185,7 @@ static void mlx5e_close_xdpredirect_sq(struct mlx5e_xdpsq *xdpsq)
 static int mlx5e_alloc_cq_common(struct mlx5_core_dev *mdev,
 				 struct net_device *netdev,
 				 struct workqueue_struct *workqueue,
+				 struct mlx5_uars_page *uar,
 				 struct mlx5e_cq_param *param,
 				 struct mlx5e_cq *cq)
 {
@@ -2216,6 +2217,7 @@ static int mlx5e_alloc_cq_common(struct mlx5_core_dev *mdev,
 	cq->mdev = mdev;
 	cq->netdev = netdev;
 	cq->workqueue = workqueue;
+	cq->uar = uar;
 
 	return 0;
 }
@@ -2231,7 +2233,8 @@ static int mlx5e_alloc_cq(struct mlx5_core_dev *mdev,
 	param->wq.db_numa_node  = ccp->node;
 	param->eq_ix            = ccp->ix;
 
-	err = mlx5e_alloc_cq_common(mdev, ccp->netdev, ccp->wq, param, cq);
+	err = mlx5e_alloc_cq_common(mdev, ccp->netdev, ccp->wq,
+				    mdev->priv.bfreg.up, param, cq);
 
 	cq->napi     = ccp->napi;
 	cq->ch_stats = ccp->ch_stats;
@@ -2276,7 +2279,7 @@ static int mlx5e_create_cq(struct mlx5e_cq *cq, struct mlx5e_cq_param *param)
 	MLX5_SET(cqc, cqc, cq_period_mode, mlx5e_cq_period_mode(param->cq_period_mode));
 
 	MLX5_SET(cqc,   cqc, c_eqn_or_apu_element, eqn);
-	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.bfreg.up->index);
+	MLX5_SET(cqc,   cqc, uar_page,      cq->uar->index);
 	MLX5_SET(cqc,   cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
 					    MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET64(cqc, cqc, dbr_addr,      cq->wq_ctrl.db.dma);
@@ -3589,7 +3592,8 @@ static int mlx5e_alloc_drop_cq(struct mlx5e_priv *priv,
 	param->wq.buf_numa_node = dev_to_node(mlx5_core_dma_dev(mdev));
 	param->wq.db_numa_node  = dev_to_node(mlx5_core_dma_dev(mdev));
 
-	return mlx5e_alloc_cq_common(priv->mdev, priv->netdev, priv->wq, param, cq);
+	return mlx5e_alloc_cq_common(priv->mdev, priv->netdev, priv->wq,
+				     mdev->priv.bfreg.up, param, cq);
 }
 
 int mlx5e_open_drop_rq(struct mlx5e_priv *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
index c4de6bf8d1b6..cb1319974f83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
@@ -475,7 +475,6 @@ static int mlx5_fpga_conn_create_cq(struct mlx5_fpga_conn *conn, int cq_size)
 	*conn->cq.mcq.arm_db    = 0;
 	conn->cq.mcq.vector     = 0;
 	conn->cq.mcq.comp       = mlx5_fpga_conn_cq_complete;
-	conn->cq.mcq.uar        = fdev->conn_res.uar;
 	tasklet_setup(&conn->cq.tasklet, mlx5_fpga_conn_cq_tasklet);
 
 	mlx5_fpga_dbg(fdev, "Created CQ #0x%x\n", conn->cq.mcq.cqn);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
index 4fd4e8483382..077a77fde670 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
@@ -1131,7 +1131,6 @@ static struct mlx5dr_cq *dr_create_cq(struct mlx5_core_dev *mdev,
 	*cq->mcq.arm_db = cpu_to_be32(2 << 28);
 
 	cq->mcq.vector = 0;
-	cq->mcq.uar = uar;
 	cq->mdev = mdev;
 
 	return cq;
diff --git a/include/linux/mlx5/cq.h b/include/linux/mlx5/cq.h
index 991526039ccb..7ef2c7c7d803 100644
--- a/include/linux/mlx5/cq.h
+++ b/include/linux/mlx5/cq.h
@@ -41,7 +41,6 @@ struct mlx5_core_cq {
 	int			cqe_sz;
 	__be32		       *set_ci_db;
 	__be32		       *arm_db;
-	struct mlx5_uars_page  *uar;
 	refcount_t		refcount;
 	struct completion	free;
 	unsigned		vector;
-- 
2.31.1


