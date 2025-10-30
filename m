Return-Path: <bpf+bounces-72987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D433C1F871
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A5A1894402
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 10:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3C23546F3;
	Thu, 30 Oct 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M7pLV8te"
X-Original-To: bpf@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA12F6591;
	Thu, 30 Oct 2025 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819973; cv=fail; b=rd1u0GImiTzsDkglWGsYKFxexYSdIHGf5TfwdFQdmgVrN5kyjB/k9wPi7HcwrLoq/7tH97p9wn3CIY7EsGAPA7IKpum/xJyUsLdDawIU9xpHVFcJS61VpLqYRC65SvfYRzuO7CaBUBrHrFWklbJRzYd9JtCLiVxDmuOTOGPWaUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819973; c=relaxed/simple;
	bh=FZgE7Vko7pNQ20l2qAA2z7pVtqtH12JY3f432wwvZn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0xXN6O5hdRVAPhGEm2FKubTQTRGVvfFjCXQ8B2cr5SW3orsmMSbg2NJY5zjXEhZm52o+a83zG1olyvc8+FyDhUlJpFqX9E6dxV8Fw4mKJdCxvN2NeQ9arb0P3hPvKmLQUTcsbizIvPOj+ooHz4pNeT6+bLhc4FQdDk4bNBn2Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M7pLV8te; arc=fail smtp.client-ip=52.101.56.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLP0UI5YWukxo75UeqRsqod5gzZBj27zKHvpv0Wio5vOv+yTFbWchFUBidrNDaXlToBbRYkyifoJaL7qwXWL1anUx18CjXR0Z8mC03BR2UgttlILv+F7NejsfZgIyBNfpsi1nPgexXc6DOMVNi1A+SEBnbFcTJdFkyA8azDWuFKRqlwmOWWIAKJqGzdtduFOE3rbOMjaEukaQtp4W+NkgoKz8jyh/FfULNWdNqCvUORBMNcra/Rto2sciD+sKwhz0hWBYVdcUkYs+GqLsXugnOU5ZK4m17JXc55pKUlIbt3HOwGFyPY64UDwJc7J39T2wqGB7G88wSkvcicqbWxLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvok0no1W2mfk7GoUo2RxHOvtGPDJMpEvWcGJEhLLKo=;
 b=E3BThBE56kDMcwhk+aezckZlZtlBnt07A8oKGFU1/dovWp7cZxw+qw6IFOMSgGKppQwCkC0fqCEbpQdENTBoYCHCAmSb9lnjzbx7ZKAaFA7T/Mq1rvYXIfHoNBVPQoG0Os73V6XfpRu76jWRDGcvu8k/9AJYkvvIMgYhBROsye8zIEqRoxcxB+wt57Mvgo28jKiu/ZdEr5PqRsIm/oStYU97DLjeMe+2bvCYEYacTJVLoTS32CDbQo8PEFQnvb781W8stp3oE3IU82JltnS43dvyJAURqofdmNcPUUK45mqxcPswruAmVFFHfjvdJVzKQcIyGrvmNmLMZcXcxOffDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvok0no1W2mfk7GoUo2RxHOvtGPDJMpEvWcGJEhLLKo=;
 b=M7pLV8teEB1HuJzD8+ZPMlAfSZbyEPMM8czrxFXeD/R8Abf/l26LFfCVbJNREu+pidOsMoQw6thZBuRykDwP99NLnLGkRjtm17HaoxLFwWf+I4s8hIIaNqqc0EqpaavQR1yWOj5qNVy3F4xalPiyEI3yQBfeQSZUSgouOgOLRn7ghzIER+CzUC/St9koYSvaGpmGS4b55N++6oR3QYwCiWEK+5YIynOCOPzCq/nAvrqQcwQZqIvfdjhDGFwA2K0DZqunfaWrpPrwBRKMZtQ9IEvMwMbihC9ugIw4i07o2EYAVmCF5K6qPnrHIP/wt0TM0Del201k9dsP6ueY4aD65A==
Received: from BL0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:91::24)
 by DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 10:26:07 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::1d) by BL0PR05CA0014.outlook.office365.com
 (2603:10b6:208:91::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Thu,
 30 Oct 2025 10:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 10:26:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:25:53 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:25:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 03:25:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 1/6] net/mlx5e: Remove redundant tstamp pointer from channel structures
Date: Thu, 30 Oct 2025 12:25:05 +0200
Message-ID: <1761819910-1011051-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761819910-1011051-1-git-send-email-tariqt@nvidia.com>
References: <1761819910-1011051-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cafba00-56e1-4f70-19db-08de179ebd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y5JZSjCTlofMloQlcRnJ6wlOf8v38dqX5PVOh/AYYF+3/nBvdBpyeC3j8zJV?=
 =?us-ascii?Q?TM0hXCJj0MUxyYIFGkbSMByJ3FcHE5k+uHpzYgB+I39QlCwTtZweLVMzTO42?=
 =?us-ascii?Q?FCpnTpwD4l/dL4ADKMc9JesDefuM25FhYR3MlOBo0fQH11hpSo7Oy/brdWD3?=
 =?us-ascii?Q?a3Jsm4gM1LyjX7vdqgQitEZumRBRUp00V6mCpsoR9jhP++ApZsI9Sw436p9f?=
 =?us-ascii?Q?8Dhf3RL3ANb8T2daLkukpqKnTGeMA5ohJ9eF20IpYDfMBR2rCHxPbcpXjFSA?=
 =?us-ascii?Q?hW+H2q4DeF1YbV9NUp5Goc0gs4AkMc7OKzgEor5xymqaRn9zrwEFArhpSRzq?=
 =?us-ascii?Q?jypYIJQTSFTxxRHea1qU7NfFjKH5Md+NDUUM2fhEc31XeG9ZZMS3qsG1b5Wl?=
 =?us-ascii?Q?M4hrN6HYyOBaEXiQ43tWUEnzzI387Fd1heKxSUwx7YH9/U9Dch2Q5bn0HbwE?=
 =?us-ascii?Q?Abs5mIhCP4GaCWvJ1zld6mYn3Px9vVncPg4/OHk/BZKFf0MZowbxlL/T+lMw?=
 =?us-ascii?Q?jCB5Ry/ssvqFE8mgBhbx7ptunglYGlJFo076bfw6e+CeYGM+lwibAqUMmzIC?=
 =?us-ascii?Q?BIAXFUACGn6u8pnPlzC7mmo6K4FsbxDb7F8niQoFjAH7Kjo4PJzgHH1FRFCr?=
 =?us-ascii?Q?qr+gbGhBDW52MwXMWRQWe8JhvdrjOpnfNujixuZqDYoRWf8hZGP4DeNtw78X?=
 =?us-ascii?Q?nWP+HuieQDsDVp8RSbVL7oq+YDtrodblZuJDyO28NNHbuQ9BeUYQsBQw1tgn?=
 =?us-ascii?Q?RfW9REi5wgBcNVKjUvxrG2sgKumdGE+sH/8IZQ8e3vWJvBtRk5FDJPhcj0jg?=
 =?us-ascii?Q?uW8u9GlJx5NipRJlGHnk077d9HI4KhyqUo5iHgYDk+8+xdWv+qjGxlsRTxDL?=
 =?us-ascii?Q?sryX9ESAxXqHFWT6qrsP1os74Ll5Lfv27x8a1czkTBflxHd7Tf+OoeQdGADv?=
 =?us-ascii?Q?uYXgQ9AbbsAygakN9hFATlf9cutEvra85xd0YbelPlO5d1fKf/tUZ72AS7/J?=
 =?us-ascii?Q?tfiPdzrnkX+gqNX/5snoeF6UMTwezK4CNopqeJt91eP404o+6mZ8rozxib5F?=
 =?us-ascii?Q?wXztrFznqb/1nRMp+X5NPStdTQ/wLMQM+nNw3I8F+HgFyrj8naPFLYgmVAFb?=
 =?us-ascii?Q?T4Lrx9bm1knaARaW30UGp8CGVOkAlcR0D7RkWPZP8fZKVYPlFyy2Hi1ajW8+?=
 =?us-ascii?Q?FdQh64rUAMYuxzeVNHL7Q5JFtf6posR2cxY5sQHy3u28j5yO2XEP8dXEtiIl?=
 =?us-ascii?Q?oD5uLWDWEpwrI6nXDnyYQRtUjMtijARBstGvEHTpEYzuq9T/t0XCFc6PG5Ra?=
 =?us-ascii?Q?FugXkOxAW7orSGEHT0zyw2zLqjhdN64iEZvMhEQv9jIKe8aFi5+e3epuoK0H?=
 =?us-ascii?Q?BUDDsIUmpyVqGvZDwAScHRWyqnrQkcchr6ZDnbQE0oCWt3WSeGpcv2E+molH?=
 =?us-ascii?Q?BUxOV4sefqu4pHvWD4tpcNZUEOxzJctIqSfkxCPY+PIfD6qXTk0r6lO3YH36?=
 =?us-ascii?Q?kkzXFNSs+HZuWjj610XCg/8YSsDrXQAoY+cG0X8FfnKvISbxfZndbY8OPRfU?=
 =?us-ascii?Q?zzwIezDiBx40Mc1nsrA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:26:07.6200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cafba00-56e1-4f70-19db-08de179ebd1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348

From: Carolina Jubran <cjubran@nvidia.com>

Remove the tstamp pointer field from mlx5e_channel, mlx5e_ptp, and
mlx5e_trap structures, since it was only used to reference the tstamp
field in the priv structure. Instead, directly use the tstamp field
from priv when initializing RQ structures.

Also remove the unused hwtstamp_config field from mlx5_clock structure
as part of the cleanup.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h           | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c       | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h       | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c      | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.h      | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h    | 1 -
 8 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 14e3207b14e7..5485cf014926 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -784,7 +784,6 @@ struct mlx5e_channel {
 	/* control */
 	struct mlx5e_priv         *priv;
 	struct mlx5_core_dev      *mdev;
-	struct hwtstamp_config    *tstamp;
 	DECLARE_BITMAP(state, MLX5E_CHANNEL_NUM_STATES);
 	int                        ix;
 	int                        vec_ix;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index c93ee969ea64..96a78b6d4904 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -896,7 +896,6 @@ int mlx5e_ptp_open(struct mlx5e_priv *priv, struct mlx5e_params *params,
 
 	c->priv     = priv;
 	c->mdev     = priv->mdev;
-	c->tstamp   = &priv->tstamp;
 	c->pdev     = mlx5_core_dma_dev(priv->mdev);
 	c->netdev   = priv->netdev;
 	c->mkey_be  = cpu_to_be32(priv->mdev->mlx5e_res.hw_objs.mkey);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
index 1b3c9648220b..1c0e0a86a9ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
@@ -64,7 +64,6 @@ struct mlx5e_ptp {
 	/* control */
 	struct mlx5e_priv         *priv;
 	struct mlx5_core_dev      *mdev;
-	struct hwtstamp_config    *tstamp;
 	DECLARE_BITMAP(state, MLX5E_PTP_STATE_NUM_STATES);
 	struct mlx5_sq_bfreg      *bfreg;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
index 996fcdb5a29d..db6932b0cedf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
@@ -144,7 +144,6 @@ static struct mlx5e_trap *mlx5e_open_trap(struct mlx5e_priv *priv)
 
 	t->priv     = priv;
 	t->mdev     = priv->mdev;
-	t->tstamp   = &priv->tstamp;
 	t->pdev     = mlx5_core_dma_dev(priv->mdev);
 	t->netdev   = priv->netdev;
 	t->mkey_be  = cpu_to_be32(priv->mdev->mlx5e_res.hw_objs.mkey);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.h b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.h
index aa3f17658c6d..394e917ea2b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.h
@@ -22,7 +22,6 @@ struct mlx5e_trap {
 	/* control */
 	struct mlx5e_priv         *priv;
 	struct mlx5_core_dev      *mdev;
-	struct hwtstamp_config    *tstamp;
 	DECLARE_BITMAP(state, MLX5E_CHANNEL_NUM_STATES);
 
 	struct mlx5e_params        params;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index dbd88eb5c082..dc5a4afa4974 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -71,7 +71,7 @@ static int mlx5e_init_xsk_rq(struct mlx5e_channel *c,
 	rq->pdev         = c->pdev;
 	rq->netdev       = c->netdev;
 	rq->priv         = c->priv;
-	rq->tstamp       = c->tstamp;
+	rq->tstamp       = &c->priv->tstamp;
 	rq->clock        = mdev->clock;
 	rq->icosq        = &c->icosq;
 	rq->ix           = c->ix;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9c46511e7b43..20f55542433d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -735,7 +735,7 @@ static int mlx5e_init_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
 	rq->pdev         = c->pdev;
 	rq->netdev       = c->netdev;
 	rq->priv         = c->priv;
-	rq->tstamp       = c->tstamp;
+	rq->tstamp       = &c->priv->tstamp;
 	rq->clock        = mdev->clock;
 	rq->icosq        = &c->icosq;
 	rq->ix           = c->ix;
@@ -2803,7 +2803,6 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 
 	c->priv     = priv;
 	c->mdev     = mdev;
-	c->tstamp   = &priv->tstamp;
 	c->ix       = ix;
 	c->vec_ix   = vec_ix;
 	c->sd_ix    = mlx5_sd_ch_ix_get_dev_ix(mdev, ix);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
index c18a652c0faa..aff3aed62c74 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
@@ -54,7 +54,6 @@ struct mlx5_timer {
 
 struct mlx5_clock {
 	seqlock_t                  lock;
-	struct hwtstamp_config     hwtstamp_config;
 	struct ptp_clock          *ptp;
 	struct ptp_clock_info      ptp_info;
 	struct mlx5_pps            pps_info;
-- 
2.31.1


