Return-Path: <bpf+bounces-68515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D15AB59941
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC713AD6F6
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7297134AAE5;
	Tue, 16 Sep 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uRrzkK/n"
X-Original-To: bpf@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20434A308;
	Tue, 16 Sep 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031999; cv=fail; b=nNKX0Au+MWUYtDTcIvBeyjSchsssNR3jsbXJWA1V1oYVUp/jFpR2Z/BzdsIAC/5Le0HCzHOBW/vCtAB5PXUkBxbtxq8yqCJi84Z9muUYMGNpn+zM9H00pL6U+rybPhgCtMn5RNxnv4mzXEvGcMgHYcdB7RTwFNrwgbz7Yuz5hSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031999; c=relaxed/simple;
	bh=DpG7dFBiJuvG2ycHkZmRyTcJFSmO47ARNSXA1pxhUe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLTSA+hhZ59ZVpvsZ3M0Cwc2g9ZafDlal5aAyNHzywV72ArljXtlCX+D3eb1B3whHhdlm0ZcTHH73OgnccffW+Wuuz/CBxpja3bDkgbYqBpwicJ97Xp6aZIW4DtG6al4f3vC86G+XWKRg8zWo+0PtGJRjLNqzNkfLaPJ4oLezg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uRrzkK/n; arc=fail smtp.client-ip=52.101.85.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAKOlBxjfyT8/pfGTv2cN7DhcAjo542yNsLB2fXQjwL290yJqzifavtRrSBnXIYUWL759QHn6mnJ8WZBgk8sNViufRSVJoJW+WlC0kuMpl5qq8Tq80s3vquuWt/iF6YhULP8ox3w+2AsiiU89BOcuNiYvuYZZws6afpXqxKG1z0mIiWo63Xnwy7zVVyuLzWcd4a7ZknVLDWGvbUu9KPfG+QSet73mHEMZ+Y9XguQNsPGqldfEuVepAI1Do0gxUQtoqEtGfo/JQlt85vwuK4BgwUD0geueyuo8Z6r+7ixa8v3CU/423ko9orxWB4w9lDWTJHFTBmyaTubvSJbIzD6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eJbF73S51SOhgc/oD7fpYeBLLLNUnotMkhSMZT47ZU=;
 b=TtOgAvZn5jM3sXxiIWjAlAeN11i7Qeyw2FRNxrLnOcbAhILOap9jB6FIspIvVcADTNd71Pklx8gOLSisVfd74whyEphLH9AcR1Rg4ss9jXAPG6LGTy0FwPgqWTGNu5v0R+cbzteoWeli9y9PgRKT7XwXkTBu34cZI/LgnQya9kLBABtWrZysTr4tHHMb+h334rfDvgNEN1X2Gf1eXIM81VFvTAcKFQeI7EBfE2nzMMtRwklX+jkMn74nUJ081qm3xyEhD+bEYyv/2Hq7/E9RjgsagIOU7Pe27t5R1yiE7oehCPp5Ve2xhNgQM5lxbuCvUICL/dwh3U9SUYUJI9tzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eJbF73S51SOhgc/oD7fpYeBLLLNUnotMkhSMZT47ZU=;
 b=uRrzkK/nBDOGGoKBTIPcSZCUIQdNuIGWpNVryZmbn8iV8jgjIoeTP8k3syUiEKkI8zlkSdYvimiU7XuWAndkoNK9bpDfOt2IjYpWfyI5AtexqTCrLu2YKNcNY4rZauHoSpoQO9Fq9aF0M4WmRYsQUheQyB94pbmmKg2WSSa8S73Ag9dIHoUfy77o2rsYlgf0xAkYtYjTd2xSbj4L8xa2LQTtp4r0CoU4yh89EW8NH1F4TK5DahwK6MaLLDDJJnQVi8MEi8eWXINME28T99C56nIWnupcTSiZ2XsjnR3joE/C8mt48930T4l1euQlFZVZnS4Bk/QRkzPIbJ0alH6KSA==
Received: from SJ0PR03CA0244.namprd03.prod.outlook.com (2603:10b6:a03:3a0::9)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:13:12 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::30) by SJ0PR03CA0244.outlook.office365.com
 (2603:10b6:a03:3a0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 14:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 14:13:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:13:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:13:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 16
 Sep 2025 07:12:54 -0700
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
Subject: [PATCH net-next V2 08/10] net/mlx5e: Use multiple CQ doorbells
Date: Tue, 16 Sep 2025 17:11:42 +0300
Message-ID: <1758031904-634231-9-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: c145205b-e9a0-4c7d-74e6-08ddf52b2bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kl1FEeUjeTsDFwHU0Jqve2finTvVEuGtt+AZLIv8MPN7ymLExgZfbL5KB1qq?=
 =?us-ascii?Q?fD3kMV2ydgvqzfHRuWSU454L/xAKsVGN1f+zFBz14oSs5ARm3UkBD8LyNiHO?=
 =?us-ascii?Q?QISdNvGmOnoBSzBOZkY6csLuV8TY2sqog6lZVQ7DT35ypJ1SjSaV9jYOLwKP?=
 =?us-ascii?Q?bkhj6EhkGgk1uDWNzIbHMG9ZIRHyNZDsjeJU2ajet1gmVqqMOuhOKnn95Qf3?=
 =?us-ascii?Q?BewbSu0fb7QCdyNJKlXROJ2CGpTJvFJHrOhWrw6kZfB2AE/tPhtZxU8iltZv?=
 =?us-ascii?Q?I+nX1kC7FDiColOyIoCEtZbOsdA8kmDEonNglqxAU1kuQEXrHF2pruX6aECR?=
 =?us-ascii?Q?R+ORoqQNtMvLZFrbXdxYUCAX7KMbuuZePwNGuusVgZ1lhaB5RveUFdjM84Vv?=
 =?us-ascii?Q?OfNS2OcAgX9SQo/MiFaFhHi17vjPoi6QLNzmLbeO6kv5/EFPP0M/Es2tSdHi?=
 =?us-ascii?Q?OEDTJP46lOi8l37BKUHb/k5upbXKsunE6e/YQNQ6Dzg2g8hnraqKcEzmW7Sd?=
 =?us-ascii?Q?ndRXvxl95J9OZ+QdDKWiDfL1CmwHsxJrzOO0BgNfkr3NGDSHyWfdt1e0ecLK?=
 =?us-ascii?Q?CbH21see1hX0wEk+3ZnsY36xcB+BHw6kXjrCzrXKgpktvCIrJ0mIk0r3Yb6o?=
 =?us-ascii?Q?OedLIEQALQ7azRbXd6W35qCTw6360wW/O7lemg1IUrfQX29G3GA+SlNyE+B/?=
 =?us-ascii?Q?VIu/YjyT0TTOzZEbxLs5UBqSOd4fJGld5vtXxQJ6c1DSxtokislz2ntGpeJH?=
 =?us-ascii?Q?b4Ze0MRaYFqNzOdbnj7Hgg8fD4LJHwdrBiftoW9LSXa1LVdK+pmLUyYTpybo?=
 =?us-ascii?Q?FGXkMaE8vSoZ1IJyXRmGuPhPFylg0YXoPTKqJm1hFXRNYknuctXLH6duI11b?=
 =?us-ascii?Q?J7oDJgXIUHvY8lxMd9XKe3cqZbkKkQNp6oLnr1lXgrqslj6RkjLYlTaSoB4b?=
 =?us-ascii?Q?UkN1TPQ6Hq6OhQRRNBbJSN1HngmR8pPFwOH8mKUcm6l1eZ6P8R7nX+vD16qd?=
 =?us-ascii?Q?OPAMVvpcyRixfOtZBK2+ENOFTpCRLJ32DlWoWqbqLUZXsXGfOgSZwi3DM7Aq?=
 =?us-ascii?Q?1/keex40MmgQZ6PZv35G9WWkCnDKq/j7xjmpmLDNWNcr6MMOIFP/awR4jWj8?=
 =?us-ascii?Q?LctkOxh2EwKA79aNOlQIW0Mbv5mfdy1o+8LjOkPpDF2UN89VKcl08HqxyWvG?=
 =?us-ascii?Q?wILe9FjUVdlJuAO0GWOEM168PrAwdVCansQIzli7ZWkzX4b3i6+pOf7IItTK?=
 =?us-ascii?Q?1clWq/HogQmNMVmNuWBF40UbFWJFw32IYxJn/ZLyRZJIdZVPXjzMKLJrCLvd?=
 =?us-ascii?Q?u1m39AUCHyzrLmePjcIWZ0X829GyakwEegp1jDcsSZE4fb4l3jJZIEZF1CMB?=
 =?us-ascii?Q?EnFHxOnJHTA4L8KP/xpG+LZs/6QbVpCr8Qtwb3xrEXO1OkendPyNV+7JAqbW?=
 =?us-ascii?Q?I+JnoSrJChd8vxfvzREZhi4gaD9c2yNtXl5mFBSOb/BKe6WOC7F5XXUGFKGO?=
 =?us-ascii?Q?JRD5zPHHyvoZWOOmrt0KKhOhFsqE/pWOL2R7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:13:12.0765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c145205b-e9a0-4c7d-74e6-08ddf52b2bb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408

From: Cosmin Ratiu <cratiu@nvidia.com>

Channel doorbells are now also used by all channel CQs.

A new 'uar' parameter is added to 'struct mlx5e_create_cq_param',
which is then used in mlx5e_alloc_cq.

A single UAR page has two TX doorbells and a single CQ doorbell, so
every consecutive pair of 'struct mlx5_sq_bfreg' (TX doorbells)
uses the same underlying 'struct mlx5_uars_page' (CQ doorbell).
So by using c->bfreg->up, CQs from every consecutive channel pair will
share the same CQ doorbell.

Non-channel associated CQs keep using the global CQ doorbell.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h        | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c    | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c   | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c   | 2 +-
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 1cbe3f3037bb..f1aa2b2ce10b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1062,6 +1062,7 @@ struct mlx5e_create_cq_param {
 	struct mlx5e_ch_stats *ch_stats;
 	int node;
 	int ix;
+	struct mlx5_uars_page *uar;
 };
 
 struct mlx5e_cq_param;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index b6b4ae7c59fa..596440c8c364 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -611,6 +611,7 @@ void mlx5e_build_create_cq_param(struct mlx5e_create_cq_param *ccp, struct mlx5e
 		.ch_stats = c->stats,
 		.node = cpu_to_node(c->cpu),
 		.ix = c->vec_ix,
+		.uar = c->bfreg->up,
 	};
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index a392578a063c..c93ee969ea64 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -578,6 +578,7 @@ static int mlx5e_ptp_open_tx_cqs(struct mlx5e_ptp *c,
 	ccp.ch_stats = c->stats;
 	ccp.napi     = &c->napi;
 	ccp.ix       = MLX5E_PTP_CHANNEL_IX;
+	ccp.uar      = c->bfreg->up;
 
 	cq_param = &cparams->txq_sq_param.cqp;
 
@@ -627,6 +628,7 @@ static int mlx5e_ptp_open_rx_cq(struct mlx5e_ptp *c,
 	ccp.ch_stats = c->stats;
 	ccp.napi     = &c->napi;
 	ccp.ix       = MLX5E_PTP_CHANNEL_IX;
+	ccp.uar      = c->bfreg->up;
 
 	cq_param = &cparams->rq_param.cqp;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
index b5c19396e096..996fcdb5a29d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
@@ -76,6 +76,7 @@ static int mlx5e_open_trap_rq(struct mlx5e_priv *priv, struct mlx5e_trap *t)
 	ccp.ch_stats = t->stats;
 	ccp.napi     = &t->napi;
 	ccp.ix       = 0;
+	ccp.uar      = mdev->priv.bfreg.up;
 	err = mlx5e_open_cq(priv->mdev, trap_moder, &rq_param->cqp, &ccp, &rq->cq);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4dee4c6d048d..c22dcae9612e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2234,7 +2234,7 @@ static int mlx5e_alloc_cq(struct mlx5_core_dev *mdev,
 	param->eq_ix            = ccp->ix;
 
 	err = mlx5e_alloc_cq_common(mdev, ccp->netdev, ccp->wq,
-				    mdev->priv.bfreg.up, param, cq);
+				    ccp->uar, param, cq);
 
 	cq->napi     = ccp->napi;
 	cq->ch_stats = ccp->ch_stats;
-- 
2.31.1


