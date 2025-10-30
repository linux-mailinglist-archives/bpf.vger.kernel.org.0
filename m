Return-Path: <bpf+bounces-72988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03033C1F87F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC831882852
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9928A355044;
	Thu, 30 Oct 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LCFpcGvO"
X-Original-To: bpf@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F13C351FD6;
	Thu, 30 Oct 2025 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819977; cv=fail; b=ROqCxJQKytjjOSiLo9yrHN2sFfuhqWsacSJe98stytuyCnTdPIAhOX5Dh3uGkzxaeYEm0HtV3h9ABL9qRcrmSM6w/nQDlnlH+YdC3VPHreCBfmSppf9prJik7BlgJsz+uvWPzzlQ11AJyFXKKtfeGuNc4Y06CEKij0ezk07Dqt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819977; c=relaxed/simple;
	bh=LFTVevuolyl90YP3SK6lO5CAN8Ss8stifZTpDeHl4Us=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQ8SEP1flagJkOvF03SYUAg6EU8c81iH57qvqNC+em4J7qSBQ5maCJB7Hv3pIJpLKsWxXKsyjIMeZDkkCadqwGDnZGcx1M6j6keFE1sD5tkIR42pPfY3Tb+bzmKTXRY0jo6kssbXgNZnsBEzOqbQjDijhabXJ6QAza8JfSj6Hoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LCFpcGvO; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3RXgFhq0vvXAZtQc966amIFB+cEq9HsIXmEvSfP5F2ovtiQOAptfiSjlsTukHM8izcIcw1KM1iwl0DPLdXXfiZXsRpswoF20+Rwi/hiBjg8fFGv/4TwftRNoN9/uctEzQciNRPteKfpSUhA+wDSit6tOVCCczG21R34yWdZ7vLCWpVdu8SknoTgvz0ZqOhNY7aHn5NCyIhmC/9BebkoCvz7HbFmO/ql6N7+Qtp77JfMIxBMRw2AWHJhFJOS406Fxrl7cJu7vb+ixjDEioTPKcP1OhvH3nE1xgJx2PC7wXpqU0oKDcimjUL3dKcfRvrQ2YS3W08v99/Xa7/we1ryMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkrzRjeei7bowf/yfIoGYKcpYLUsd9ldwE5zKNJC0XU=;
 b=eOcjuUtG1/8S8jJ71+TZ7PifNlGs0r5Agmt2ISYru3zxRMf0T6700hi8DnWYDCJPx777uo3xyVvbA04V0cTJoBU26gi7fOjraHULUHG4j85sK5hDmU+Qyw1K52h+z1KoQeFpIEC1RNGDOYfywYnuwTZvCmMj1G/MWd10/rfJyK2UrIXTLfSLg92tcchM9XNreSUyhI3sb0KOvmOx+cnCQxc61TeDkaH2z67Njtjzf0bc949YIzyAQBxR4kPkDFzq1a5Xs7vYQskSXkl/Cgm7c27rwNBckWfLIGX2tNW7PXf5wPzvTxMEcJF0pDs2Z7QBupky02rK9fZ62f7ZiyOzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkrzRjeei7bowf/yfIoGYKcpYLUsd9ldwE5zKNJC0XU=;
 b=LCFpcGvOicyxPl+G5DdTrMa6359u/B5FrHjCbfdQL3vtUCwdd3eu/E46DL6q3HKg/XD/tiC7aQHxELAneNxARzrbS/UgEwdULH00MRHMGaGwWVvSJMBmnlT2i1RSGAHJb3RuAUlZrnvbhybhZGwS3VhrYaDR5YTpoxqUStsVEdFauHZWZBtS6DHeVVvTNwW2oqkFTuDRZwEUHXM6EkHBMHTQpuIkj1vLeZLPvh3jD9iFHxH4vfhapVU8v66N6iwpc+AgUSK6CaSbGLwAuOKW4JrGQqgEwSJlVRggHrgQdWxPenTIZ0qV8s3vmLC8GQTfcmWGNcRl5FIukM3oQrI/9Q==
Received: from BL0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:91::25)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 10:26:11 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::e6) by BL0PR05CA0015.outlook.office365.com
 (2603:10b6:208:91::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 10:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 10:26:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:25:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:25:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 03:25:53 -0700
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
Subject: [PATCH net-next 2/6] net/mlx5e: Remove unnecessary tstamp local variable in mlx5i_complete_rx_cqe
Date: Thu, 30 Oct 2025 12:25:06 +0200
Message-ID: <1761819910-1011051-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 693e16e4-a015-4676-a962-08de179ebf5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VjiTcyBls+Bs2BaFwNhu6j9/Uk8DpzEsquBrTIPc12ntBuXkDDUTk4hDOCAN?=
 =?us-ascii?Q?DvkbYa9WeLV6RIiTfl23keYEqGgPneFPLGhxtqeeEOeCZ97hV2tfD3iS7Wvf?=
 =?us-ascii?Q?OgU8ZA2NrhyhBe5mb0Hb5HA+/ImIRifoisN3fqx/UixotT7zsrHzFlCj6qhj?=
 =?us-ascii?Q?GvZZxJUmikiMOQ5c1Hr+j4f3Z/lODJXIBg7j/jWWQtxkcpGQny2RRpA2nGQJ?=
 =?us-ascii?Q?V5jzh5xjH9uTfUI/LE3OdhCDPG8O3SH8c8FL3O8huG4UIu0QDv/HSXFkE+wE?=
 =?us-ascii?Q?vCy2vjPXia6FmgTypszZjdqg6ZrByuPsdXfjLaeSpfEA7ZmN9+nlT3pDHbOC?=
 =?us-ascii?Q?qMB7EHISO0apufF9LdEjUsQ0yWEG1hj9dc/a8iR4XBaB6cWs3SXsAx3p7P5w?=
 =?us-ascii?Q?pzD/Rw8Ed0Mlel+ywQUvTCgjoTvoG4wbJdlCOKBGYu+C9TqA1utZdGR4CdTP?=
 =?us-ascii?Q?Y4gHla/OUKwncTRzftKJan++1YslXDz04eqCq3vPlsftKdqkE7gJRU8tUaKD?=
 =?us-ascii?Q?XoV/PJ2XMpalQouxlzq1Vn/macYEE0AwNHPhAjSiDerY8dtiycqvTt3VjcyN?=
 =?us-ascii?Q?77TrP7sZV+SzVgyRRe9EiBPoHg7aqtEDB3AaYTRS9zr6T7yfgZAxeo4RH5Xx?=
 =?us-ascii?Q?/0i89CgGB/8QqRxj6EIfpYUuKDOuoYFjDxIrJKX/xfhIYGqtI5At2ggd68+J?=
 =?us-ascii?Q?B/KWHcAJNfRxYJ7io7G+WXmEQA/BYMBLu6+SmuYoZhHiVIzLCThSleIcpfIa?=
 =?us-ascii?Q?eqiQftGG7kSNecXWfQZSbVgVNTISzYk3RHbxIhnb7SEMk7ichawnjNrkNZMk?=
 =?us-ascii?Q?Nc7eB7LSXIA8aKiz9wb9f2WLXShqxYh6AC6QPGdopSHxxN9SFEla9yo6AYpp?=
 =?us-ascii?Q?ZDXJp8JVFKwnSWTcTyAkTLZFAbE25qzpDLN9oWjekjlx2HPHAg7njA8nDlCL?=
 =?us-ascii?Q?oCMu05v9o47cR13xRE8l8nYTLAJrO2bYDXOrN9nsDCgpttZJSLeA7vhaMKGK?=
 =?us-ascii?Q?qZ0vbGJIkcU8ZSXnWUpp93ksQLPBCWNn9BnxHCy+jje59L7NAVr6SK3DgPtT?=
 =?us-ascii?Q?jNE4mG7X1Z4jpPYU8cvynXG5ouvy/pb/k1SaoSJtzwVFknuZeAXaXdvZgDjp?=
 =?us-ascii?Q?m2N1Oc2DTipmojc8Et5PdthvzEnDz/a6qdtP/DoUs5AaoU1W7YI2pTmxWVuZ?=
 =?us-ascii?Q?I4ptt/1gc0uEUCXs6FT2o3TJiQdY8zpaE/7A7JIedOeVe4smBTwJNiLf3MFx?=
 =?us-ascii?Q?uEO+inMUqmhySyTd5m/hHxpwrkChgFA4urisIBWI/HZBNw7WMTwmqkhofp3f?=
 =?us-ascii?Q?kpP0HsC8X3usnDh9YXbpnxJJlzPhH4NVq/QdiViv+7KECP+Ul4ltrg/XOhe5?=
 =?us-ascii?Q?R8vAqJIQRyRD015+mYI6khpRwL3C5tWJE0JycKItAMFfIXX4ENxQZRZ0gSkk?=
 =?us-ascii?Q?IvMnSGGtMNX58ml8X8qcGrnn3P90OTVAHAdTGXlYRTeEuwgZj2cLeN0vuyRB?=
 =?us-ascii?Q?YA1rm6sNh3ZLFiFM4Uz7wc2lAPfMQXZW1Pfda3gGkUoOaY+nHCobE964ZJ9q?=
 =?us-ascii?Q?IcZk0Io3PvWTFbP0vYs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:26:11.4077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 693e16e4-a015-4676-a962-08de179ebf5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

From: Carolina Jubran <cjubran@nvidia.com>

Remove the tstamp local variable in mlx5i_complete_rx_cqe() and directly
pass the tstamp field from priv to mlx5e_rx_hw_stamp(). The local variable
was only used once and provided no additional value.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1c79adc51a04..cc2d90ed5378 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2646,7 +2646,6 @@ static inline void mlx5i_complete_rx_cqe(struct mlx5e_rq *rq,
 					 u32 cqe_bcnt,
 					 struct sk_buff *skb)
 {
-	struct hwtstamp_config *tstamp;
 	struct mlx5e_rq_stats *stats;
 	struct net_device *netdev;
 	struct mlx5e_priv *priv;
@@ -2670,7 +2669,6 @@ static inline void mlx5i_complete_rx_cqe(struct mlx5e_rq *rq,
 	}
 
 	priv = mlx5i_epriv(netdev);
-	tstamp = &priv->tstamp;
 	stats = &priv->channel_stats[rq->ix]->rq;
 
 	flags_rqpn = be32_to_cpu(cqe->flags_rqpn);
@@ -2706,7 +2704,7 @@ static inline void mlx5i_complete_rx_cqe(struct mlx5e_rq *rq,
 		stats->csum_none++;
 	}
 
-	if (unlikely(mlx5e_rx_hw_stamp(tstamp)))
+	if (unlikely(mlx5e_rx_hw_stamp(&priv->tstamp)))
 		skb_hwtstamps(skb)->hwtstamp = mlx5e_cqe_ts_to_ns(rq->ptp_cyc2time,
 								  rq->clock, get_cqe_ts(cqe));
 	skb_record_rx_queue(skb, rq->ix);
-- 
2.31.1


