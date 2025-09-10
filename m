Return-Path: <bpf+bounces-68005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E1B513FF
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C47C3AFE20
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D13318127;
	Wed, 10 Sep 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VqHUQBfc"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB531B83D;
	Wed, 10 Sep 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499986; cv=fail; b=q6nplmR3KuJeJgDFV72UHNwLwUsUNIh7yeDfOcmHYIQ9nZ7nM1oxgqhGg9S1I2Wd94oNMBMDFoIiEC3v3AvFbbosPoo3dQYCmjbSkvtWfyTwiqsIBXZmlRKMVcW2nkxE9AayUSI/kcrA8goCv68P/TropbZLt+NUEn0yHeZRpCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499986; c=relaxed/simple;
	bh=DpG7dFBiJuvG2ycHkZmRyTcJFSmO47ARNSXA1pxhUe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BX2H5JGsibZ9Y5PGiOLvBmJQJrAwGXoGQMd3DxZ7vo/LxNQzyViPHoeoUM+JxrkGF3S84cXzqLStLeaUG/MqMNQoR6eOOCgd+4O05/kv1+X7ierj2OpnCl9Xqm9IGOF34EbsWOvtByqKfVLdB24iKmq7MhiNDXk5E5XLFas6G/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VqHUQBfc; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeZMoTFR1uD9ajLFbCuGO1gptXU60ZzO2QMfWDQJyKgOehdYKnZ4hW+nBtlBd1ug3z8OhK6EVITOhg1JSyXu0LV6sgbrPMkmBq+btmW81E3I1kZKoNcZm7mYy5Sga3wCM8EC2n9wksDephvAHvIYshmcDVbSCgd637hJjqJt36t/3FM9VTol3POofmwD++fS/yieaPoW9sjsq8nnClCROvhrnlV6PeFYVGoBLQ2ZPoKN/w9/j3FC7M4F5iWHlC6HO0+eebGJJ1eFom42C9UDLnbZ9KjuzMohN+kXGXFp2qMKVOYJwwGm83LHE3lGQ6jAXht2ED/Piw7VVLwds3pHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eJbF73S51SOhgc/oD7fpYeBLLLNUnotMkhSMZT47ZU=;
 b=rZT0XJR0OFUxoTLXop7uonoEPwoBB2X/FAx5UlGAPkXbGsFpkSr5yomCOGXI2fjn1I+Tre7acBAS6miwxqHdUEY+Jh0Z7pZ0CcEpjK/ehj85nZJtr+oQhlYzH2KLyaF6NSMAh2P/J1yb3ETnGZipgdwI3FaXdkeEMXLyq3vQ6d8r2ZUrq5McNouiJfF36Y4jVRFKb3IV0kaIZsx++C52Q3UpIeko7rDO5oecbWScAlc+xvlDuhaQ4tCBOzoRE5FlsjZzHDkGm4HaCJbn0xXe0L1OuL+5dRliNpuuZvQJoRs0wKKYnqkN3r1mrRewANT4t8peqDgbQO++E74aNfdEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eJbF73S51SOhgc/oD7fpYeBLLLNUnotMkhSMZT47ZU=;
 b=VqHUQBfcJSSJGoNO/NTq7fw4J7KvzeegZOvNpFHiR6+e6vtv97e52lOQlxVzMu0ZWBErF/LzKAbh5VvMVDxMt/9UvYwzX61rGglzq22+ILMrekfsFfB6zX6O4Ha0bseyQfnoNy41zEiPd7w1Bcv292FM5i0G1qiBUBRu+go7Zsk5lJ+H8jJAWESU6OWKyfLcUCOpYRWsjAdsepA4Uv/Ab+EhybZ4qrRpmr6+QQbhcgPnbs0gphLhrh0f6B254NC5e5CHmGjDARJ/psSSrPKtcnMhqzcOdZ6lgRqXmvEiz22QnfJaLxNDlfI3rimPq1sV9ghEZNzeOOm7bvukrCG04Q==
Received: from BYAPR06CA0044.namprd06.prod.outlook.com (2603:10b6:a03:14b::21)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:26:23 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::79) by BYAPR06CA0044.outlook.office365.com
 (2603:10b6:a03:14b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 10:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 10:26:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:57 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 03:25:49 -0700
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
Subject: [PATCH net-next 08/10] net/mlx5e: Use multiple CQ doorbells
Date: Wed, 10 Sep 2025 13:24:49 +0300
Message-ID: <1757499891-596641-9-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: c31165e0-a278-49d2-ea90-08ddf0547d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QY/nrzc0zwR8C4cT8POYJ2tuzLHgKZadWgwcHTEmgxRbixuXFa2/mxbwiBoy?=
 =?us-ascii?Q?akZu9SURWadmNHUeK99rZ9dtW13v+kYgza+71O9SBIg9olKk9/A4mWCzcTJw?=
 =?us-ascii?Q?u8kW0XrQUy8pl/PM7tVYlfy8bH/b7QNhePkV+2RMLm4tSmwF0klFkKGNLpXN?=
 =?us-ascii?Q?JPS1e4nZJqJr57s6GfIGzCmZpuO72VjLrJmSjfov+4CCVSv89ZHki+EIkm+P?=
 =?us-ascii?Q?s36y7+PWhKXnG+Y7un5sq3GOpC6nfvKMZUMfZpP6epTGJPupZWdlRtMsWbwQ?=
 =?us-ascii?Q?SSYGtq+k2M93xKl/88ewtcrKoiGl745XBbn8tTWCtgFAq1EIanreNqn7mUkN?=
 =?us-ascii?Q?+m2ZGN8l6PANnqU0Y9hxGrC2SNDu30gnuhMYStDDf/wJPZSf9Zj8UukD8fo9?=
 =?us-ascii?Q?iEnfjEdWHhw2qNr4HC7Xml1J5pWPiPdhT8pdDbYNIGLWUcQyt3Qub9hGCo0J?=
 =?us-ascii?Q?DFOfe7ePsMgY7cHjeDUrQvdGag8NJxtJKG1DxNY8VxZOUfXdTzdzCyl5Owzb?=
 =?us-ascii?Q?70754rl4vQtLid0QyZW7m6R1Be6jAE2tePhqlMmo1lsqs06vqzXFu6Hfdkzs?=
 =?us-ascii?Q?8cNe51c+PMCxn+m4HphlXdBWp2XP9QnTki/C5T00m7xhxpAQcrDXF9/qOzs8?=
 =?us-ascii?Q?0hDlZpo326Qsq93ThC8tbev7wTJDAH0rLrzNqc3NYth5HiRZIYBb2lPrGxKf?=
 =?us-ascii?Q?n4Z1X4TI09CPbKPvQ+Q3v78+ryHVHSBwNhCEznwumDBu7yIUwfW6SONj+CyL?=
 =?us-ascii?Q?us77JS2qw4whww8VejaA1NbT2XX9TJFuYCEvwq6KbZkBgMU622ZKcUXCxljg?=
 =?us-ascii?Q?8yA0W/iKxDTo6fUC7a+G/43WO67OZUl3pcG5Vyf4v8z5NZUXRGoSnbNgGw0z?=
 =?us-ascii?Q?XoGUOkFGKzXv8j9KrmwStmSaB9eb7SoaUy2oSRN5+8Kj9SFfZ5awC8DGta6X?=
 =?us-ascii?Q?MYwyivM66ajjIjmjPMV15iNjvcofZz4UfGhSixTUN8InvE/65JJ8VMGcHKc4?=
 =?us-ascii?Q?uyEKfwiRorhB7lj/jq9JCeZb/yYR/m2ugMnLP3j53MuupsEwY742yD0DElku?=
 =?us-ascii?Q?x8cJ5GvWhLVHQhG5XVJYO50y1odDEGdniRfiBIvaZ4s73942jOGESUo5ja0W?=
 =?us-ascii?Q?q/WKLUUR/hOgzgg7vS5mBQ1x28bAaGXwA07fvwmNf9giTy8VBVZhq2UTTzQz?=
 =?us-ascii?Q?pXcCWnDcaXn4AK290ibVh8z1XUv4YPQ4KoxX5EpliQsNegi/ANWEDOmSG4CE?=
 =?us-ascii?Q?/Bb73JI/758/oDSc+nhOPmEOuBXeCaUgXWmGRIIioa2qSaw/yasG8prN8v52?=
 =?us-ascii?Q?JnK3TMH8egOumVl6BadfKjjPQBtGwmpD5Phu1NLRhaJj4564oeGlVa573VDx?=
 =?us-ascii?Q?IUzKzAgTnRYpmTN0AmvrlSyUbtT2Eewg9YC1bwHdVt1aKtXqXyFXWxi4FXvA?=
 =?us-ascii?Q?8SWWmKYz2nswWTJeLVkO7qxJS1K3QftemTZ6J0GeAzXZ3lpoBJzDea4atjTJ?=
 =?us-ascii?Q?WLZQu/aNtsIHiaOfPnKwHMX/3Me7Oco/79Sg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:26:22.0412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31165e0-a278-49d2-ea90-08ddf0547d4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781

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


