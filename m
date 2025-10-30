Return-Path: <bpf+bounces-72990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E6C1F8A5
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 308C54EA323
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0629357708;
	Thu, 30 Oct 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZIJkYOkB"
X-Original-To: bpf@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57785351FA7;
	Thu, 30 Oct 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819991; cv=fail; b=pJ0PTi+PH+sWLCmLV0KARHiLGs9UKMazyqFJzrQAPVnfUXT/6B/v50xlWAKVjRx4L+PRtR3NYell0MpOvrVd62GzsbMRFs/pL3pJ9/gwNiTy7ChZBiHALfpseulraGpcP5hj4V7ffRsQQTIoyT5JcCj8TAdka6PGfKVtKCJyaUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819991; c=relaxed/simple;
	bh=jkg53qXTb4vkhasC0o8p3gmvGgwSQTRKYTmTVlmGyb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSmxvWbEkk7PtEadOmyMYmARLAbmpEe7tdwAsbSE633M781roCUhZhWrT+38/PEjSQ9XbPCEJmQyBCJ4cuh2Tz/ayIm7fRhqVvjjSCnbDrRSFzhhCAOk3BnC/sCkTlMs3QwYPc8syfgoLd3hU1AgTOP6tAk7Y7swsczeXp/pan4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZIJkYOkB; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NH28E7mvzUW77oefj0yRJqlkXVAz0L49Ky+cM0RvltbTqwb7gQHqw6l/kGQJyTSDFpGFv/kuau/ay1mC4qSX9AhSfG8TnIev2jUmvSjVHbCxlSHYHrEGm/W+g7+u1NHrlxEHY0RH1Quv4f3qIWPUK7PWBM04yprbA/XOPWKumZWtA6VCKftfScZe48BTyG998lZ54IM2U+S+7oie7pd2dEwtG56IcNInAcyRwF7v6Zt8YLSoQJBfsAspJDPX6oXrllNiEsBbIJ+zV7aP6Dvc1f8IT7Ii13wQqXqSAhkdS84BAhjQP++td+oQzbUxqGUcWxU00kuQbPNeTaC2ksTSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byQ+RnWlGUwYqi6w9EvJsRqiKkdX2WCq+tT855Rzfw8=;
 b=KI+ooE1amXie3QzsQrYNeK3G6iGKIVq7X4hC3xHpZbYk6hyhkx6LwCZ26xLEWfBBdousMFH1qg16D88H1gCIgBl1GpYPvjnk7dE4NRYfk1KBWrqlCIQJaYteaZFWg/4wTUkXoM4JrfP1OFjWemQp1zBGJ5O07WKjYJ8W72AmgVP8KheDBOxR6LmiIcqJB79ru7Uj6tPwDdGOeghCVHlKOmc3s0iF5Rp8Qqe6dHT3AqDTMIGZzDmPatZXA6XSqSTpQQkjMiioTVQQtUGP5rrWkvxmLLRjJj7OKNp6HDTg1aUFRc9RugawmGIVccbCrbTlz8f6YRci/sdR6+nGaUh97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byQ+RnWlGUwYqi6w9EvJsRqiKkdX2WCq+tT855Rzfw8=;
 b=ZIJkYOkB/03ooPEXeN69vg88pUira01kvH87Q4+MCQaf4/xkL7MHCofcmFhg8NROcWnR2b0LEezk2KXDf7VsK6DvnrwPIMw8idubLhUtMl7vZzS7Qj41OAnUjtOJcnZP9Kz6H4bZaxF8nt/kKWANZAdtd1uTfRbNifXuFKZnCuYJ1BAqMBCzK5P+32mTHw5eUWMPS9KUB3WpcO8Ozz1fyFHonoQkj0ktUlaUQvRuM8MXFY/2m1fFa598c+UA5QndZDJBi3MrkZ2rQ7b9ICvhhOJxZuIUL0kT0t3oCjjGJROUDfzxUD+FmZud4+XqVpqi7mmmlz/rgeXrip20RKlTeg==
Received: from BYAPR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:74::32)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 10:26:24 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::58) by BYAPR05CA0055.outlook.office365.com
 (2603:10b6:a03:74::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Thu,
 30 Oct 2025 10:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 10:26:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 03:26:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:26:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 03:26:04 -0700
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
Subject: [PATCH net-next 4/6] net/mlx5e: Rename timestamp fields to hwtstamp_config
Date: Thu, 30 Oct 2025 12:25:08 +0200
Message-ID: <1761819910-1011051-5-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: c950b6fb-96cb-43a2-16bb-08de179ec6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qw4/cxuTr5Uyi3ut7QweIYnxzeNafT6UuZI3Dg5zEAiN7iDg2aXkeCqN7ZT8?=
 =?us-ascii?Q?gXPET8yC6h+lJw4L/l3kKTWB9zSfGiGC39rGjf+zIU9lfrSYJv9xY7Z8wMEB?=
 =?us-ascii?Q?XVjigu7cSbmRkzMtjmHm9eA24DdZGqIRb91ItFF+xOwx+7R3q5o/bzJSoxc2?=
 =?us-ascii?Q?FufVGxfLao6rkgF6x6maOQQzCes8EEQDbPN9A2H7s8yC7dSKEk6r/HLN1YJo?=
 =?us-ascii?Q?fqcjU4MSqrG4OIWrPyo83uOSyWfJuEpl43Unr2yTLOAgvpKIrRkmNos4KHL4?=
 =?us-ascii?Q?iEHXWx5owNB+F965UIS3Z+pUqhw4/j3RCoNg8meL9JraEd8hVUJu6d02uKok?=
 =?us-ascii?Q?0L3tELnLSAZBxIxb2wuZ8J2RDCoRktH/BYL2cuCcgpMQzFvOsunEJiX73WVm?=
 =?us-ascii?Q?Ql4J3hsC4K136mIblv0JoMjdhuxXeEO2Wifo/oA5TLNn2F2E0Vg/smKzydw8?=
 =?us-ascii?Q?eTd+5ZAHg885t3pUUs3D6AHwQ45nU1iZGGHSJBxWIAAXVY2jwdkf1JGghLla?=
 =?us-ascii?Q?4azavmVVvVhaOPsEML3hXTWfjZ4gROvHErLD8ekhGo+TWg9HAFaEiYCVT6zh?=
 =?us-ascii?Q?4BRzdDjYE1ReFIsHr9D7g+h4b17IP3XBk9J/1g93vxnC1VXdQWrvJ8QK8amR?=
 =?us-ascii?Q?yhqZGCHWJmQ+pwL6MRk8o2L1heN8s9taC4qtY3y70IATuzQ6Qli9+aGYtFaL?=
 =?us-ascii?Q?mAEHfqlpIxzJjiQsMrxpTgAPdla0ysGZEV2hQO8oPUjnZmzX+dImChySWcFM?=
 =?us-ascii?Q?PyZTVywwQEeScuf6dc/ClIMzAjcUS0JrPvms8TaPvvt89TCaNIMTMzYx1ngZ?=
 =?us-ascii?Q?RouZx072RG5vg8U1GV3iMpaRx+mev39GdJtFLnuzC2oxrM0htsyqpdSUs/0s?=
 =?us-ascii?Q?2G8rtdsMEjGJ+dSZi6BDAZpWxd8aNgll3wEojXcXdB6nMTIUleIcB4IWWYHN?=
 =?us-ascii?Q?14bQaLoA8AL7T45KwrYUP/7mt9CaWhcBOHeWpN3kDA746gsKHecNlZoan2tE?=
 =?us-ascii?Q?aH4wZtL03lJid/GSFu/n32J+qAwu2Anyt+SnyaDzZLVeIO3zadfJ6GkZ3ZjV?=
 =?us-ascii?Q?9fpzUey14cpgUoT43WINkm7YjvyJskRoDwa005D1vyDc2nzNzdu9soSfAkxn?=
 =?us-ascii?Q?UFd9XqkauMJzKS/iSEH1v9hfRQYb87DbveOi2olT7GMbqha2UeEkVpCVm0qJ?=
 =?us-ascii?Q?PpIJFFOh9vWXHDUKjCBfzAWnEiaG589WmbvZPb9LWV1Y5q+ZAKGImoMkTyyR?=
 =?us-ascii?Q?0WnEQ+SqOEd/wSaqoftz1cq76jnW+0TJAVlD+A14uq9frYu+P6Zj226hOWdm?=
 =?us-ascii?Q?PgAc3hlg6vLXihb4aom8s8U3495rpaMhkMlv9nBKFBGNntDlY3pfwtvW6kkb?=
 =?us-ascii?Q?F8c0Sty6flFfMRYc/705jdbrw7vq8T++2Cpk5Ix0l/OeXEfgpwwkRXGnQbZI?=
 =?us-ascii?Q?igLBV934++QMBW30S3mUZweTDk1fz+pJ1+w7y3N4N5F/CuZto2YCeEsdJcRL?=
 =?us-ascii?Q?7fTS1B1TiyIqQBagL8tv34hatfz9oFT+N+9SLQyAnnUp4CLD7/iMtdtiVP5z?=
 =?us-ascii?Q?HNorGYzulmzyVZfbeY8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:26:24.2916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c950b6fb-96cb-43a2-16bb-08de179ec6fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778

From: Carolina Jubran <cjubran@nvidia.com>

Rename hardware timestamp-related fields from 'tstamp' to
'hwtstamp_config' throughout the MLX5 driver. The new name is more
descriptive as it clearly indicates these fields contain hardware
timestamp configuration.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h           |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c       |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/reporter_rx.c   |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c      |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c       |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      | 10 +++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c        |  4 ++--
 9 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index ebd7493888d7..eb3eef1a496e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -696,7 +696,7 @@ struct mlx5e_rq {
 	struct mlx5e_rq_stats *stats;
 	struct mlx5e_cq        cq;
 	struct mlx5e_cq_decomp cqd;
-	struct hwtstamp_config *tstamp;
+	struct hwtstamp_config *hwtstamp_config;
 	struct mlx5_clock      *clock;
 	struct mlx5e_icosq    *icosq;
 	struct mlx5e_priv     *priv;
@@ -917,7 +917,7 @@ struct mlx5e_priv {
 	u8                         max_opened_tc;
 	bool                       tx_ptp_opened;
 	bool                       rx_ptp_opened;
-	struct hwtstamp_config     tstamp;
+	struct hwtstamp_config     hwtstamp_config;
 	u16                        q_counter[MLX5_SD_MAX_GROUP_SZ];
 	u16                        drop_rq_q_counter;
 	struct notifier_block      events_nb;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 96a78b6d4904..12e10feb30f0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -713,7 +713,7 @@ static int mlx5e_init_ptp_rq(struct mlx5e_ptp *c, struct mlx5e_params *params,
 	rq->netdev       = priv->netdev;
 	rq->priv         = priv;
 	rq->clock        = mdev->clock;
-	rq->tstamp       = &priv->tstamp;
+	rq->hwtstamp_config = &priv->hwtstamp_config;
 	rq->mdev         = mdev;
 	rq->hw_mtu       = MLX5E_SW2HW_MTU(params, params->sw_mtu);
 	rq->stats        = &c->priv->ptp_stats.rq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index b1415992ffa2..0686fbdd5a05 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -318,7 +318,8 @@ mlx5e_rx_reporter_diagnose_common_ptp_config(struct mlx5e_priv *priv, struct mlx
 					     struct devlink_fmsg *fmsg)
 {
 	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "PTP");
-	devlink_fmsg_u32_pair_put(fmsg, "filter_type", priv->tstamp.rx_filter);
+	devlink_fmsg_u32_pair_put(fmsg, "filter_type",
+				  priv->hwtstamp_config.rx_filter);
 	mlx5e_rx_reporter_diagnose_generic_rq(&ptp_ch->rq, fmsg);
 	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
index db6932b0cedf..da8c44f46edb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
@@ -47,7 +47,7 @@ static void mlx5e_init_trap_rq(struct mlx5e_trap *t, struct mlx5e_params *params
 	rq->netdev       = priv->netdev;
 	rq->priv         = priv;
 	rq->clock        = mdev->clock;
-	rq->tstamp       = &priv->tstamp;
+	rq->hwtstamp_config = &priv->hwtstamp_config;
 	rq->mdev         = mdev;
 	rq->hw_mtu       = MLX5E_SW2HW_MTU(params, params->sw_mtu);
 	rq->stats        = &priv->trap_stats.rq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 5d51600935a6..80f9fc10877a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -179,7 +179,7 @@ static int mlx5e_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 {
 	const struct mlx5e_xdp_buff *_ctx = (void *)ctx;
 
-	if (unlikely(!mlx5e_rx_hw_stamp(_ctx->rq->tstamp)))
+	if (unlikely(!mlx5e_rx_hw_stamp(_ctx->rq->hwtstamp_config)))
 		return -ENODATA;
 
 	*timestamp =  mlx5e_cqe_ts_to_ns(_ctx->rq->ptp_cyc2time,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index dc5a4afa4974..5981c71cae2d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -71,7 +71,7 @@ static int mlx5e_init_xsk_rq(struct mlx5e_channel *c,
 	rq->pdev         = c->pdev;
 	rq->netdev       = c->netdev;
 	rq->priv         = c->priv;
-	rq->tstamp       = &c->priv->tstamp;
+	rq->hwtstamp_config = &c->priv->hwtstamp_config;
 	rq->clock        = mdev->clock;
 	rq->icosq        = &c->icosq;
 	rq->ix           = c->ix;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 53e5ae252eac..47a3770fb0f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2273,7 +2273,7 @@ static int set_pflag_rx_cqe_compress(struct net_device *netdev,
 	if (!MLX5_CAP_GEN(mdev, cqe_compression))
 		return -EOPNOTSUPP;
 
-	rx_filter = priv->tstamp.rx_filter != HWTSTAMP_FILTER_NONE;
+	rx_filter = priv->hwtstamp_config.rx_filter != HWTSTAMP_FILTER_NONE;
 	err = mlx5e_modify_rx_cqe_compression_locked(priv, enable, rx_filter);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 2ecbd735584e..5b2491e19baa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -735,7 +735,7 @@ static int mlx5e_init_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
 	rq->pdev         = c->pdev;
 	rq->netdev       = c->netdev;
 	rq->priv         = c->priv;
-	rq->tstamp       = &c->priv->tstamp;
+	rq->hwtstamp_config = &c->priv->hwtstamp_config;
 	rq->clock        = mdev->clock;
 	rq->icosq        = &c->icosq;
 	rq->ix           = c->ix;
@@ -3444,8 +3444,8 @@ int mlx5e_safe_reopen_channels(struct mlx5e_priv *priv)
 
 void mlx5e_timestamp_init(struct mlx5e_priv *priv)
 {
-	priv->tstamp.tx_type   = HWTSTAMP_TX_OFF;
-	priv->tstamp.rx_filter = HWTSTAMP_FILTER_NONE;
+	priv->hwtstamp_config.tx_type   = HWTSTAMP_TX_OFF;
+	priv->hwtstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 }
 
 static void mlx5e_modify_admin_state(struct mlx5_core_dev *mdev,
@@ -4805,7 +4805,7 @@ int mlx5e_hwtstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
 	if (err)
 		goto err_unlock;
 
-	memcpy(&priv->tstamp, &config, sizeof(config));
+	memcpy(&priv->hwtstamp_config, &config, sizeof(config));
 	mutex_unlock(&priv->state_lock);
 
 	/* might need to fix some features */
@@ -4820,7 +4820,7 @@ int mlx5e_hwtstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
 
 int mlx5e_hwtstamp_get(struct mlx5e_priv *priv, struct ifreq *ifr)
 {
-	struct hwtstamp_config *cfg = &priv->tstamp;
+	struct hwtstamp_config *cfg = &priv->hwtstamp_config;
 
 	if (!MLX5_CAP_GEN(priv->mdev, device_frequency_khz))
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index cc2d90ed5378..727a561e8ffc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1598,7 +1598,7 @@ static inline bool mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 		stats->lro_bytes += cqe_bcnt;
 	}
 
-	if (unlikely(mlx5e_rx_hw_stamp(rq->tstamp)))
+	if (unlikely(mlx5e_rx_hw_stamp(rq->hwtstamp_config)))
 		skb_hwtstamps(skb)->hwtstamp = mlx5e_cqe_ts_to_ns(rq->ptp_cyc2time,
 								  rq->clock, get_cqe_ts(cqe));
 	skb_record_rx_queue(skb, rq->ix);
@@ -2704,7 +2704,7 @@ static inline void mlx5i_complete_rx_cqe(struct mlx5e_rq *rq,
 		stats->csum_none++;
 	}
 
-	if (unlikely(mlx5e_rx_hw_stamp(&priv->tstamp)))
+	if (unlikely(mlx5e_rx_hw_stamp(&priv->hwtstamp_config)))
 		skb_hwtstamps(skb)->hwtstamp = mlx5e_cqe_ts_to_ns(rq->ptp_cyc2time,
 								  rq->clock, get_cqe_ts(cqe));
 	skb_record_rx_queue(skb, rq->ix);
-- 
2.31.1


