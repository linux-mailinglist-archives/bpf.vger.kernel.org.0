Return-Path: <bpf+bounces-72992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBA7C1F8D5
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2863A18873B1
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CCE3587DE;
	Thu, 30 Oct 2025 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cl/8a77c"
X-Original-To: bpf@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE5734F491;
	Thu, 30 Oct 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820008; cv=fail; b=kt9vAThcyBOr5onJ+0Sld7Qja772mY0TiCLrb6ww6VDzo1jvrSxk5Cfv+U6vAf/PAo8iXmAQUc2aiwHDB6z2+Fux3wU0WXU9iXYLNC3XPxY5bFXUxV99U3VcplcXNZUm9/SDG81+96KDOhffbUNJIBrTgbRFwY+MlxDCUdYw1Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820008; c=relaxed/simple;
	bh=/wIpdTVUlj2XqjEJvohDQ093NP3PWg9aP1UY6mdqkK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNvFe3bCiZ+kMGEaBQmKwDZbxvigFzmvq3ja4c3gYB58Ix8F0HrkhshcaOSRDDB9yvdfvKBZrYp0M10p/Eg8kBWk7ZLBnNc4vaG2UfOEqEzUp7d6QGvyk9k0x42dYnTFS0KB4TmF3s97ANQ2sTig/zqJ+L2QoM1yLIi+mSL5dp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cl/8a77c; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U554lwHnzCm+yNXGAQcMP/uaiRLTA9fRf/wLu0V2yHy1/dnNkWlukgPtiK+LPD/UZoPZIyP9fRO1xQiEpORIbUpjKJtwmJ0vTiOZKQ/BwpFklf3pssWcpMrhuAczN3jWZ8QhBiBIlaPf3SJGaqhPsjkWXUQqsYE+iqtZ/jSlIchGc6HUTHS7t8/MrxYV1/frzem8bgETVftNa/rjN4HehqqABo2R4b97iId3Ie0eaX7qfCb8Uws5fi8CKu8J8uH2Wanyc/OyAydghxUSQBVr2d1STAUSbqE71x2N6/k3L+CQcqSkZ55rWMUyObHg45I0uyMzHJmil7T97OqC9pHPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlJZ6EkDjRoQ9WLTa3dfaNZU5XUF0He6qVwKCN5W7OQ=;
 b=zOxXhoCGnmtPL3suB/WuZw3M+jrsKTO/qz5uxDr98qpiRXeVyTkUFGwcK+Torzg8tDAkJaE+2wvUwEBUFcmX+pbETURsslF03VNGdjOVTESlNlRuYUndB2xTf5wWpqSDJHjlqqkWndK8rvs8WLrQauOONYtrxWiVZBBOfqKxLLZCp6Kae1t71fX3j2ArixlkXRCdE5hZP0G5Nr3JSpYVlRZG7tS3fKInSIgLzOWn5qtcxSB2gVPZ2q96CnZgeJAI3rv5B1xv7UN9XBK1kt3LwSM4fHcMHo3xFMItcWF+JHj44fADJTVE/lMkCn2lT1W6CEacB0cSDICJHo5qMRVS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlJZ6EkDjRoQ9WLTa3dfaNZU5XUF0He6qVwKCN5W7OQ=;
 b=cl/8a77cl5JgN2XxFh6Kse6/z1ERdUPe1hdwQg9HbkG9i5Rc0DYmzKnN6YNA4Hxb15VexoB8vx+1UgtH7kCTdiB3BPZ8/PIf0tLiqwKP+7Up1YX8kS5DVc0Pt4FTSWMT8S7H3TWHOn1gCwCSjHu+or1wumtATggHiP0G+W9R1xYzVAQfWXJqaGrL/j380e7THk0RrYLcyEwAjGABqXIIwHY6hk45Ek7KpH5wQ8QAoFZQk4lNsfIRuL6l8MsYAy9jITaOhfNN/QSvMqw9Sx5PGxHRd8yQ/gJCyKORVB7vPtELttejT49k7PVGovrBXWJuqrEEQf5xzcaRrYD56JFydA==
Received: from BLAPR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:32b::21)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 10:26:41 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::eb) by BLAPR03CA0016.outlook.office365.com
 (2603:10b6:208:32b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Thu,
 30 Oct 2025 10:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 30 Oct 2025 10:26:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:26:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:26:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 03:26:15 -0700
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
Subject: [PATCH net-next 6/6] net/mlx5e: Convert to new hwtstamp_get/set interface
Date: Thu, 30 Oct 2025 12:25:10 +0200
Message-ID: <1761819910-1011051-7-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: ef267c33-02a1-4f6b-e2a1-08de179ed127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gOHOI9BcIxxyPqqJ2xszvuS+NSQZJ/ZKTu4s+ORKIrw5S0pSp6kkr8rkhZsv?=
 =?us-ascii?Q?gruVpx4lRzNgXyEQgk9eJlWdZ/A8LuHhctBJBVgkCQ/lGPdPeleTXwQSXNdX?=
 =?us-ascii?Q?c5V3nF8p93Dl9avFDwaki9FBXPeaEeeTVm12MCHfI9nXqwbBomX3DJtUf4I/?=
 =?us-ascii?Q?4gCObKuPT1RGMNBC3z9GoHghE9p8NZ+oD/PW6Y6mELBMCnKH6ICziGEY9gL/?=
 =?us-ascii?Q?RSsqyLjBd8AulAYWbj9TnPWl3TnroYXzNiG2NsxLS8tpgO5zxN21XaTjODwR?=
 =?us-ascii?Q?VnksIMpccjTVOHpTpNN2kYR6CEbeNk1e2ZXTjTa41lf9PYwFNKKoZRwR7y6A?=
 =?us-ascii?Q?NHeXvq0yEoGpvsFeKyFUEh7JOiPHxbCIhS64reAjk2rAgDbyFpfybrnraACG?=
 =?us-ascii?Q?BAgJ0sEqjiqLu+VaJ1zrHJbkwYUaT1ZFrKwJAU0dLimQgR7F93ASNR0duVJP?=
 =?us-ascii?Q?RbbRqGvZ1+CwsQuZFNx+bcRC+RfK3EtJfckEN3312Iimyrx/ueG8nHEJP921?=
 =?us-ascii?Q?1Gg2bKARLfe+2P9XQ60EFargCpQarMclnuBSHNhYUdqBb5EKSFuA1xRmKozG?=
 =?us-ascii?Q?aPWotCyFd6usdiNq3HO6W+FqCb1wnA+D+lVzu5NS18YwMI7jm802eMOKXrD4?=
 =?us-ascii?Q?+yoRf+9bSHUKIFdOG4ZJNKnQ2+ufcXYFtvlyutmWsWchR1dSBtokgePJVL7G?=
 =?us-ascii?Q?Lge4oNzCg30PpdTb0jGC5bMRQ7iEK1aqRbtKL5O0eDIcShnRbufTGJBFQRn/?=
 =?us-ascii?Q?84qpxnhEgjyjKua8CzGsBqkTc3FoSBPMR/8RAntKKssQn0BrNFsgMVEzYzro?=
 =?us-ascii?Q?AG90xz7gDbBOF67SYKRT62L2x2D6/4c4Uq584HuGucsjGJpBhGFw2Nb/bhR1?=
 =?us-ascii?Q?Am6fHlyalSj5/2tqCEI1O6qsPy4+gt4nCaGIEYTFuKwHCd06UslUh2I35TRJ?=
 =?us-ascii?Q?PJQkhVMxAUUEnPJEzcj10zLWNC5v/v3BTguaslLuY/3uZeutNJb+bYc3jdWU?=
 =?us-ascii?Q?oGQVA3WZdJTvMbxIwyGKgOSAhDO2hdR0GS4wF6+H3PzwCc56BkOQx/YVRVOH?=
 =?us-ascii?Q?CrbuCAIKwbfHexBF70348oG25fxNtgFHrRQA+p43IKo9FePI1lDQp9Ut2Yyt?=
 =?us-ascii?Q?kocj14Cel4dj8kzElzbcUCusJ0ybgxLyaFKGfb4MGqwIIZiLdti8VtRvpuGe?=
 =?us-ascii?Q?qsLfcVr09az5cLv9CiyygWrv7RoPdjiDtjiw/p3G6KDjuaY0YWFz/naFXICl?=
 =?us-ascii?Q?+Ai/YgNUIEhItUEUOMLu96b//jsWD9bFxHayvSgVBvEBsVTsxyhxZZAv5eGZ?=
 =?us-ascii?Q?za23NvXRVN8iWuciPEa2obzcmj5OTg3267RD7Lgz/conw4UbMR0cut49JgIn?=
 =?us-ascii?Q?UNjgcVuB5/Bu4EUPQfDbLbmOIZGctlPNn2mLMvwUGEjwV5Cb4UMYgEeAMCGz?=
 =?us-ascii?Q?DSumA27i+ynt6hkZhGPHW5XCtoaxk1QwKnJwDKs3A6T4Ki8eBKRlC+jM2ITG?=
 =?us-ascii?Q?GIt7Mgq3hlXK9sXWDk4T6/OcOYJwhPLypHewffGh5O1dzzSA9zE4zsPL5RXq?=
 =?us-ascii?Q?V38knF0TzpfzWTBUL9c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:26:41.2771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef267c33-02a1-4f6b-e2a1-08de179ed127
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214

From: Carolina Jubran <cjubran@nvidia.com>

Migrate from the legacy ioctl hardware timestamping interface to the
ndo_hwtstamp_get/set operations.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 11 ++--
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 59 ++++++++++---------
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c | 34 ++++++-----
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.h |  6 +-
 .../mellanox/mlx5/core/ipoib/ipoib_vlan.c     |  9 +--
 6 files changed, 66 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index eb3eef1a496e..fd107906bc28 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -696,7 +696,7 @@ struct mlx5e_rq {
 	struct mlx5e_rq_stats *stats;
 	struct mlx5e_cq        cq;
 	struct mlx5e_cq_decomp cqd;
-	struct hwtstamp_config *hwtstamp_config;
+	struct kernel_hwtstamp_config *hwtstamp_config;
 	struct mlx5_clock      *clock;
 	struct mlx5e_icosq    *icosq;
 	struct mlx5e_priv     *priv;
@@ -917,7 +917,7 @@ struct mlx5e_priv {
 	u8                         max_opened_tc;
 	bool                       tx_ptp_opened;
 	bool                       rx_ptp_opened;
-	struct hwtstamp_config     hwtstamp_config;
+	struct kernel_hwtstamp_config hwtstamp_config;
 	u16                        q_counter[MLX5_SD_MAX_GROUP_SZ];
 	u16                        drop_rq_q_counter;
 	struct notifier_block      events_nb;
@@ -1026,8 +1026,11 @@ void mlx5e_self_test(struct net_device *ndev, struct ethtool_test *etest,
 		     u64 *buf);
 void mlx5e_set_rx_mode_work(struct work_struct *work);
 
-int mlx5e_hwtstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr);
-int mlx5e_hwtstamp_get(struct mlx5e_priv *priv, struct ifreq *ifr);
+int mlx5e_hwtstamp_set(struct mlx5e_priv *priv,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack);
+int mlx5e_hwtstamp_get(struct mlx5e_priv *priv,
+		       struct kernel_hwtstamp_config *config);
 int mlx5e_modify_rx_cqe_compression_locked(struct mlx5e_priv *priv, bool val, bool rx_filter);
 
 int mlx5e_vlan_rx_add_vid(struct net_device *dev, __always_unused __be16 proto,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 6760bb0336df..7e191e1569e8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -92,7 +92,7 @@ int mlx5e_poll_rx_cq(struct mlx5e_cq *cq, int budget);
 void mlx5e_free_rx_descs(struct mlx5e_rq *rq);
 void mlx5e_free_rx_missing_descs(struct mlx5e_rq *rq);
 
-static inline bool mlx5e_rx_hw_stamp(struct hwtstamp_config *config)
+static inline bool mlx5e_rx_hw_stamp(struct kernel_hwtstamp_config *config)
 {
 	return config->rx_filter == HWTSTAMP_FILTER_ALL;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5b2491e19baa..bd7777199a01 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4740,22 +4740,23 @@ static int mlx5e_hwstamp_config_ptp_rx(struct mlx5e_priv *priv, bool ptp_rx)
 					&new_params.ptp_rx, true);
 }
 
-int mlx5e_hwtstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
+int mlx5e_hwtstamp_set(struct mlx5e_priv *priv,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
 	bool rx_cqe_compress_def;
 	bool ptp_rx;
 	int err;
 
 	if (!MLX5_CAP_GEN(priv->mdev, device_frequency_khz) ||
-	    (mlx5_clock_get_ptp_index(priv->mdev) == -1))
+	    (mlx5_clock_get_ptp_index(priv->mdev) == -1)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Timestamps are not supported on this device");
 		return -EOPNOTSUPP;
-
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
+	}
 
 	/* TX HW timestamp */
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 	case HWTSTAMP_TX_ON:
 		break;
@@ -4767,7 +4768,7 @@ int mlx5e_hwtstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
 	rx_cqe_compress_def = priv->channels.params.rx_cqe_compress_def;
 
 	/* RX HW timestamp */
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		ptp_rx = false;
 		break;
@@ -4786,7 +4787,7 @@ int mlx5e_hwtstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 	case HWTSTAMP_FILTER_NTP_ALL:
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		/* ptp_rx is set if both HW TS is set and CQE
 		 * compression is set
 		 */
@@ -4798,48 +4799,51 @@ int mlx5e_hwtstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
 	}
 
 	if (!mlx5e_profile_feature_cap(priv->profile, PTP_RX))
-		err = mlx5e_hwstamp_config_no_ptp_rx(priv,
-						     config.rx_filter != HWTSTAMP_FILTER_NONE);
+		err = mlx5e_hwstamp_config_no_ptp_rx(
+			priv, config->rx_filter != HWTSTAMP_FILTER_NONE);
 	else
 		err = mlx5e_hwstamp_config_ptp_rx(priv, ptp_rx);
 	if (err)
 		goto err_unlock;
 
-	memcpy(&priv->hwtstamp_config, &config, sizeof(config));
+	priv->hwtstamp_config = *config;
 	mutex_unlock(&priv->state_lock);
 
 	/* might need to fix some features */
 	netdev_update_features(priv->netdev);
 
-	return copy_to_user(ifr->ifr_data, &config,
-			    sizeof(config)) ? -EFAULT : 0;
+	return 0;
 err_unlock:
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
 
-int mlx5e_hwtstamp_get(struct mlx5e_priv *priv, struct ifreq *ifr)
+static int mlx5e_hwtstamp_set_ndo(struct net_device *netdev,
+				  struct kernel_hwtstamp_config *config,
+				  struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config *cfg = &priv->hwtstamp_config;
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+
+	return mlx5e_hwtstamp_set(priv, config, extack);
+}
 
+int mlx5e_hwtstamp_get(struct mlx5e_priv *priv,
+		       struct kernel_hwtstamp_config *config)
+{
 	if (!MLX5_CAP_GEN(priv->mdev, device_frequency_khz))
 		return -EOPNOTSUPP;
 
-	return copy_to_user(ifr->ifr_data, cfg, sizeof(*cfg)) ? -EFAULT : 0;
+	*config = priv->hwtstamp_config;
+
+	return 0;
 }
 
-static int mlx5e_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+static int mlx5e_hwtstamp_get_ndo(struct net_device *dev,
+				  struct kernel_hwtstamp_config *config)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return mlx5e_hwtstamp_set(priv, ifr);
-	case SIOCGHWTSTAMP:
-		return mlx5e_hwtstamp_get(priv, ifr);
-	default:
-		return -EOPNOTSUPP;
-	}
+	return mlx5e_hwtstamp_get(priv, config);
 }
 
 #ifdef CONFIG_MLX5_ESWITCH
@@ -5280,13 +5284,14 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_set_features        = mlx5e_set_features,
 	.ndo_fix_features        = mlx5e_fix_features,
 	.ndo_change_mtu          = mlx5e_change_nic_mtu,
-	.ndo_eth_ioctl            = mlx5e_ioctl,
 	.ndo_set_tx_maxrate      = mlx5e_set_tx_maxrate,
 	.ndo_features_check      = mlx5e_features_check,
 	.ndo_tx_timeout          = mlx5e_tx_timeout,
 	.ndo_bpf		 = mlx5e_xdp,
 	.ndo_xdp_xmit            = mlx5e_xdp_xmit,
 	.ndo_xsk_wakeup          = mlx5e_xsk_wakeup,
+	.ndo_hwtstamp_get        = mlx5e_hwtstamp_get_ndo,
+	.ndo_hwtstamp_set        = mlx5e_hwtstamp_set_ndo,
 #ifdef CONFIG_MLX5_EN_ARFS
 	.ndo_rx_flow_steer	 = mlx5e_rx_flow_steer,
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 11d950f58ae3..906b1fbc27aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -45,6 +45,23 @@ static int mlx5i_open(struct net_device *netdev);
 static int mlx5i_close(struct net_device *netdev);
 static int mlx5i_change_mtu(struct net_device *netdev, int new_mtu);
 
+int mlx5i_hwtstamp_set(struct net_device *dev,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack)
+{
+	struct mlx5e_priv *epriv = mlx5i_epriv(dev);
+
+	return mlx5e_hwtstamp_set(epriv, config, extack);
+}
+
+int mlx5i_hwtstamp_get(struct net_device *dev,
+		       struct kernel_hwtstamp_config *config)
+{
+	struct mlx5e_priv *epriv = mlx5i_epriv(dev);
+
+	return mlx5e_hwtstamp_get(epriv, config);
+}
+
 static const struct net_device_ops mlx5i_netdev_ops = {
 	.ndo_open                = mlx5i_open,
 	.ndo_stop                = mlx5i_close,
@@ -52,7 +69,8 @@ static const struct net_device_ops mlx5i_netdev_ops = {
 	.ndo_init                = mlx5i_dev_init,
 	.ndo_uninit              = mlx5i_dev_cleanup,
 	.ndo_change_mtu          = mlx5i_change_mtu,
-	.ndo_eth_ioctl            = mlx5i_ioctl,
+	.ndo_hwtstamp_get        = mlx5i_hwtstamp_get,
+	.ndo_hwtstamp_set        = mlx5i_hwtstamp_set,
 };
 
 /* IPoIB mlx5 netdev profile */
@@ -557,20 +575,6 @@ int mlx5i_dev_init(struct net_device *dev)
 	return 0;
 }
 
-int mlx5i_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-	struct mlx5e_priv *priv = mlx5i_epriv(dev);
-
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return mlx5e_hwtstamp_set(priv, ifr);
-	case SIOCGHWTSTAMP:
-		return mlx5e_hwtstamp_get(priv, ifr);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
 void mlx5i_dev_cleanup(struct net_device *dev)
 {
 	struct mlx5e_priv    *priv   = mlx5i_epriv(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
index 2ab6437a1c49..d67d5a72bb41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
@@ -88,7 +88,11 @@ struct net_device *mlx5i_pkey_get_netdev(struct net_device *netdev, u32 qpn);
 /* Shared ndo functions */
 int mlx5i_dev_init(struct net_device *dev);
 void mlx5i_dev_cleanup(struct net_device *dev);
-int mlx5i_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
+int mlx5i_hwtstamp_set(struct net_device *dev,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack);
+int mlx5i_hwtstamp_get(struct net_device *dev,
+		       struct kernel_hwtstamp_config *config);
 
 /* Parent profile functions */
 int mlx5i_init(struct mlx5_core_dev *mdev, struct net_device *netdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
index 028a76944d82..04444dad3a0d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
@@ -140,7 +140,6 @@ static int mlx5i_pkey_close(struct net_device *netdev);
 static int mlx5i_pkey_dev_init(struct net_device *dev);
 static void mlx5i_pkey_dev_cleanup(struct net_device *netdev);
 static int mlx5i_pkey_change_mtu(struct net_device *netdev, int new_mtu);
-static int mlx5i_pkey_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
 
 static const struct net_device_ops mlx5i_pkey_netdev_ops = {
 	.ndo_open                = mlx5i_pkey_open,
@@ -149,7 +148,8 @@ static const struct net_device_ops mlx5i_pkey_netdev_ops = {
 	.ndo_get_stats64         = mlx5i_get_stats,
 	.ndo_uninit              = mlx5i_pkey_dev_cleanup,
 	.ndo_change_mtu          = mlx5i_pkey_change_mtu,
-	.ndo_eth_ioctl            = mlx5i_pkey_ioctl,
+	.ndo_hwtstamp_get        = mlx5i_hwtstamp_get,
+	.ndo_hwtstamp_set        = mlx5i_hwtstamp_set,
 };
 
 /* Child NDOs */
@@ -184,11 +184,6 @@ static int mlx5i_pkey_dev_init(struct net_device *dev)
 	return mlx5i_dev_init(dev);
 }
 
-static int mlx5i_pkey_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-	return mlx5i_ioctl(dev, ifr, cmd);
-}
-
 static void mlx5i_pkey_dev_cleanup(struct net_device *netdev)
 {
 	mlx5i_parent_put(netdev);
-- 
2.31.1


