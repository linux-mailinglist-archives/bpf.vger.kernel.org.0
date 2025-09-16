Return-Path: <bpf+bounces-68510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6607B59942
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C571C015D7
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C9338F3B;
	Tue, 16 Sep 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cToeBMLZ"
X-Original-To: bpf@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C2315D38;
	Tue, 16 Sep 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031975; cv=fail; b=PAynCwPf8U4KdNCSDjbuPLQJNYmq/ncMOyx2oBjDb+6YycHhNNpR4RCU2n8iHz0NsLp2X7tHvDZ0l7Ji6iaWXDssyp525JJQVHKPwU0G2lAjfLkXGE58MC2z6LIBlcHAMRYeEdrk4W5PyxtamVzvk6JnVUCXrkWE3XSZIRlYRKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031975; c=relaxed/simple;
	bh=nazo57QJUKzzloxe+PZVTh3FcqlvIFzHSu9eXsbDz5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6RBcJmULXGYZVg7XKM4gPeRB4jvNk1wiYrlHZk+E+eXjKrfuWPz8/jBo5f3jo7Gabl90gjCXhpq1e8E31PJwFlvQQtK4Cp3l6A9JlX7BmBzdRfO8qBkwLJgcbLwrEWrWxcvHyxQT0rqlGe7JGnpbbsQLsqcTpbhYk+FP5hpwrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cToeBMLZ; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGvBs1wfoRwph4sPGlhkSkRNvlkzIwIBAcb5VHKKwmKW3qF7lLkCaF5bEn1EHxQROBgui1HTu2w3rR4ykSKcLnTScqcCJcuuyzOuolGpZHYLMImFOh6D4dBaPWNp7cwmMitXDj5wik1NY7zIWS141k76VzxMteh6QSpmrcIhtrrpFhx+pflOTjSOzHRE2i/9ke1/tjV1LC8fYOyJ5FklhfTGOcoeh/ed/Zd94D/2oJr4sZQM9JZ5vai5MOg95BObung0soBcvMBzTx/AqNH4BfGUIJmeWJAXT7C4yi+lT5QBN8OQLCQ+EXXjAyvIaD/944x2dq+KHMjH07J6fGiwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdHtfWwkeP09jxPwOFIL2Z9wXiF7nuMuVAjBFcdgbXA=;
 b=y/TGApDKUF0ok8BvqAFGNht2wDdF2gJujPzfA/BD167gHFbix0gvMtnD/gOPRCaKI8HfAlyn8Q2xzdZ0baGUQ+A7QRbjMyYYeZLXu9WzrEIU7WwxSjun2UfnAK2182CAAkAuxUt+VX34p2AqOtTsRSLchBtDHs/+sbi7xWqc/BNMm3KumAWpfvhoOIe4/cEjZOmO6PcKi+6O0IoV7H4bEfO/bldrRPMxt8RJhqQoRRcmUIdHRhF6/Qf/BJMCAOaUCNZlKzI7w55CdZ14FblqUPvdyOZvvhCsx0B5741oMIj/UghYWsy91+JBZkaO31AGm86oJqze6mmwAPXMU7k+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdHtfWwkeP09jxPwOFIL2Z9wXiF7nuMuVAjBFcdgbXA=;
 b=cToeBMLZBFdJp7gbsITrgkmXBPLs3E0AcI97CxetExk2HPsMv/tdMJFIqTsTk19t85X9uAzmeN2Cr5e78g9YNwaNba/MsfYih1LaUYXjkW+iDbGl9CTw1nmdvXQ3eNp1SuPIkCoUuWRsluFZ0uLS+7LbjAl5jSJopyEyvNffx1/sQO985UgNPEuuv3UyGys25i9NXKc4l5PXm8t+UbFlzGetYn0qAoROZqtu+SJm90P/8PIaLJ8M0pPBMMqNk4oYQdocY4fdEUViTMgXoha7ixpgiq5E0QsSJlslUL30BowmfG+ACQSsOLiPIY7ashDivE9mj1RZ7K2d+bHWq4lRaw==
Received: from SJ0PR03CA0249.namprd03.prod.outlook.com (2603:10b6:a03:3a0::14)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:12:50 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::22) by SJ0PR03CA0249.outlook.office365.com
 (2603:10b6:a03:3a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 14:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 14:12:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 16
 Sep 2025 07:12:22 -0700
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
Subject: [PATCH net-next V2 03/10] net/mlx5e: Remove unused 'xsk' param of mlx5e_build_xdpsq_param
Date: Tue, 16 Sep 2025 17:11:37 +0300
Message-ID: <1758031904-634231-4-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: becf1674-c597-487c-98c6-08ddf52b1eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O/HFprsxo5Ki1m3qqTCGq5z9irfA/kvT+gKGp0U76uZ+uHJRCtlQV+fA+Zww?=
 =?us-ascii?Q?5Pg5r/DNhvAcKzxMSQ6jyjWlMceZOLlZyWE7OGxBNWO/3kB1t06ZrJg6No11?=
 =?us-ascii?Q?jFipUzTbU7VGfys7XevXrdoHuTcK0aln0qziy9GCSyRGONQBat5jCWICYGnZ?=
 =?us-ascii?Q?RGJtTSIjLKvcJcal8N82NX765qnYoqth8NbXsbDtvB3ynS4LJBnrJLmt81tn?=
 =?us-ascii?Q?dTApLYuXAMPWrwX/+JDXaTkNNDDQJ2KIpMWdzHPJj4KFOlbe2N2+BhIi7FYd?=
 =?us-ascii?Q?OJIfEurlyoyqXma6zQvpONEknt+QHpoHelymhZaTuxlWyQwScANDVbXgxHq4?=
 =?us-ascii?Q?67m+6BqMwT/bYiXv4X13jIGBLxmZvA/wqsA00JHtmH9EsrZtm6JBOUYQi/K1?=
 =?us-ascii?Q?IMpW8EtpNEXTl0nG+GzH3JuUvRZqEilZu7xtgDhNZg2FgHvlqxySdS+TqGZf?=
 =?us-ascii?Q?rbrIZpWaNh7g8Zk3QXjdC8p4J91YHCXr+CRI2S77wdCee8KxB6FgGWTx/Z1U?=
 =?us-ascii?Q?eo2zpJUNTOFzV/jzG0s42AbT84CLgJLW0sqN8woVayLc+NuwX8/JwfSS8snH?=
 =?us-ascii?Q?Mtv7KtH9TtO7Ab8KN0gyPi6MjhKpaMCZJg53/oQaKm+hjDLJz8F3TXFWadkO?=
 =?us-ascii?Q?LzXZ12HaEMfE3P1wBaLxckMsdAe4MIYgDn/0iJ3z6STLWBO15Z3JzQBGxbru?=
 =?us-ascii?Q?REjWBT4MlLmFzDjrSXJ2WYUfF3mOaTSilTLP9eqYMAz9J9fKlIeRWAxD4kRy?=
 =?us-ascii?Q?9bAtWSlFfm9eRXiXvnHF9Yosfrs9fE+sS9NqE2hgNXE6zSeeGVE4Td5KNObm?=
 =?us-ascii?Q?PFxp7kqSYg18gaGprbpHxpMnJzUE1R39jkWnvc33nENN/vj6UKwsLETbz2LM?=
 =?us-ascii?Q?wPdvq5Gwx6tsbZHIZblIXTJy23S/LmGsuH6BdekhC38kQ/Dc9HnEZhhryajy?=
 =?us-ascii?Q?nHRxbBF2anqUU3jFwRUcjf8vkJ4O8WST2oGc9rTQuk4XQWMBhJqJmNgxb21Z?=
 =?us-ascii?Q?yRdutQKDbgfyG8Kx2lWTL7caCQI+0RFLT47I+j+Ayi2tSW28GIPahiirFcxq?=
 =?us-ascii?Q?8pM0rPtUDFzLOCz7ftmV7EgloezG8pwTbCsSJtDIT2DImN3Soe4LNUhCYpC2?=
 =?us-ascii?Q?VqeUyN0yuFvK2y+XyoQsrW8vg3WICxZF6tSqKyK2gQhgTEqSOtxyG7aJanOd?=
 =?us-ascii?Q?8hGzafbFrdjz8dOTrncprKQz66uQVrofpOojThKXVOWt5aAqa8y7ezYDPWiG?=
 =?us-ascii?Q?Ep2wREsdiM6lDx3FqPgNg7EGolQfsdrq9L9/4XU1mgAOwEXrZPeq21EoF/c6?=
 =?us-ascii?Q?jxFk0M4V41l8NTzzFHeK/JCxBu6Qqs+45tRPphBjmS3YPWuduY+br40HVfl9?=
 =?us-ascii?Q?vdXmHa50xtej6yofASg5kZCCmGWkq21Qr2T12+UbDdV1M9B19dMBWmpfheZs?=
 =?us-ascii?Q?FMPl5NKJ+qs8mYgbDq944leZlTyZHbmMIUwvn/Ovybtufj0hZGsVPO1NJDyo?=
 =?us-ascii?Q?4r/x6mmEBreHGLXzLIfft4aJljEg1zfk7a3V?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:12:50.2604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: becf1674-c597-487c-98c6-08ddf52b1eb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

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


