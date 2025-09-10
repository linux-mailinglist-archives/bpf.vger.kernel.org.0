Return-Path: <bpf+bounces-68003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E60B513F2
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6209617F688
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2C1316911;
	Wed, 10 Sep 2025 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k1xQ9JuW"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D631691C;
	Wed, 10 Sep 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499979; cv=fail; b=thCu56UPBTSD4XkNAbNeLYPfhu6PVewR9nU0rGNx6EjRh/7M9z3qI1ZSeBpCdy7HOgN1PtazbiYn3NIMXdGfjDkzsVHzEU9uXON0jaHmHnFCvmeEDYK8lWtVEP3L66GGyi+P9DvYoLrVlpizfg/Y1LloHdMoDvFZy1b3ZGhQDqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499979; c=relaxed/simple;
	bh=vpd1dukzLde31aeuOlxlT0sns0OE7J5AD5m3OPOHpWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7+ZbBxE+5k19cC6nSO1lkQYjdLbSvPysWCl3SgBqM+WiYoVY3G7sumCd37Cmga3pQLG2L0Fhkasvbh18IIsJZMaKbR8HBAsoScGgFUGWEt5cdTruOvBpp+D4UvuVdHC2OfEk0C33EFRjtOL+l3OPs1TfcSgnGxYWk3vwKGaqms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k1xQ9JuW; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVPX+ADTm4eGIgKRNPFvYvtHl26EmB6OAwX9HjCZGgH8Lhu421RWb4PSIs5D1gcKIE/E1ZGF0Buom1Z7nwqkvj4P2KPLLEAsTqVFrEK65Q5O2NLofj91VHuFGMWtMfucw4grDUXWz2crf8fKDZxC6BZOWI3vqY9Pd2DrQLzKlDqR2+qp171CjqQijjOE6kQfU46IO70R6fKrRofj71BQRZikKWOqn0epY1pVdEKMPopXp9E0BOivHqKZQzVJJSJdjdHAR7vfY3Ch2I8wctgjofabYymJAaZhRDq0GBcS3F8x5005o5zq2jDvgfcp+yDAY9RRvWxPhaYyE/mdFw8lEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0FK8KLvOgyKV8Bk17NKjZv9+JmbFwcJEKdtUD3LSyk=;
 b=roFOQ42olAIiu/lAbV9x2AEVXtzijWVZ1vF416ysZg03sH0QuRF3IhOKyep3dcQZMyrNhro/ScYaTM/YbFi+l5bgg6HsbRRjCUHD2wsRCY3QG6W07HVyFS4hvIlKnXYQHlI17lYO0NyBKMWY1Jki1+8q2mEyTklCTvx/qRgEO67dMk8XZmvcKhCtobYteXVs6QErkqNurCWq3YqOcRYVMcA0vsl9WDQqQXGiyTxYxcTpIc2mab9l8kYltrCggUn1HA/KdkhWsZkj4HVBL4SC+rv+YlH8oVZcuYRPLjuI4P2OruI4HUfLtEZXoGfHj+V2wZh5MhjlpXnZoXFPGw32mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0FK8KLvOgyKV8Bk17NKjZv9+JmbFwcJEKdtUD3LSyk=;
 b=k1xQ9JuWMDh9FL6yXxuxkYn4iu6Gw8wKu65OPFaC1qOGH4nTEKC9Im1PFZo7DjtRd/dzqat660TrX6qanbRWpe5ksSqjgtCOOX713PL0d2PYae/fwpo3VXvfxH9VjhO1JPkkWfuMuaWUVnlNRIJQF8lnevfA68C1jNCDdHBbODRyACQtdUnaa989oHh7gZ0sITqtJsZm1XE5riFdTQ9owwtCq7UrqZC/HjirC59/PwDJ/FE4CjjhlS/CgskPGLBOfn9XPNvc6rguKzKjkP1mS1C5Z8E2eH/iOJjhn9ppsSxMK2uGalW+uQBPrTI5wW4U5V5ZtvlgbPqwo+y3bQaBsg==
Received: from MW4PR04CA0310.namprd04.prod.outlook.com (2603:10b6:303:82::15)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:26:12 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::7c) by MW4PR04CA0310.outlook.office365.com
 (2603:10b6:303:82::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 10:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 10:26:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 03:25:36 -0700
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
Subject: [PATCH net-next 06/10] net/mlx5e: Prepare for using different CQ doorbells
Date: Wed, 10 Sep 2025 13:24:47 +0300
Message-ID: <1757499891-596641-7-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: c4604837-c021-4014-a8ca-08ddf0547706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sE8dv7pqBX0mYpF94cemC+RwgTrvZijlXBG+2fFZH/eBmaMGvwPVuGbMEnTg?=
 =?us-ascii?Q?W0AxxtteMR0Ywqz9XWkKpQPlxI402ObMwOkL8IzJCEap+fy4ZAWS08veOxkE?=
 =?us-ascii?Q?ABUnq+R4IDfqIh0FmAbyuFFx++K9gnaIQUBBUkTIF/pCAN6fqSCWi8mlDY8L?=
 =?us-ascii?Q?/x1YLkBtQ8V98VbO5YOQE8lb3HMnY0HmcUaF6GKZuIvFC0/2lTll0rvz57iZ?=
 =?us-ascii?Q?eIuJdPGwDVAyuvm5U2Q/TkKR8FmOuXehoyc9gBEt38r6nXep1F9WmfKXYDO2?=
 =?us-ascii?Q?eklqnVlAwUd32YwJyO1nV2vA8X1WCO1caRKE5wzok95Qket92T5+B+pyo1mh?=
 =?us-ascii?Q?65DPUFyonMvymosVZmNgBD9XJLtMy9CkRdrHPPNejvCv/CiKuxtye4BRDgWn?=
 =?us-ascii?Q?HvV3CLReNzbpaxLjI8k1O2Irjf6UhkSfBviRAh2y+HQfeFKz148i8nzo9XUY?=
 =?us-ascii?Q?UKvWrl60Bhav4u5dNU5qw7r7C0IsnuJnVZM4DowAiPdE9aHvrBnFrWMZUtCr?=
 =?us-ascii?Q?sMZIcsp6uBv98am9khUT7oZLMa4/jor09c0O48pT7MTb4AyGZn4u0gOT8F5w?=
 =?us-ascii?Q?dKa/FzdaREXM/8Ja2XzWqeiEanJUjhyouFiTgzeD/sYAxvtqc+fH9rSrvE5m?=
 =?us-ascii?Q?NqobZX6MMWPTLZRQDhRLz/LcNXnHDXOS1XXJ0qapMhDabyqwgzwkXuhM3zac?=
 =?us-ascii?Q?53iGE8xtqey3qB+YLreEmI/xOuVVuCwH+M8PII9sEkK+3sOObf6OuaQ6qDLs?=
 =?us-ascii?Q?BXtaLkTdu3K7n27p9k3Jmk5nD+7G8ZmX+Q30YNFhIa/xXQ/dPcSSYym1L2KZ?=
 =?us-ascii?Q?5HQLlMllRupJjgrixKlX2qA680atpBxeODs4qttd4G/LdmNIR9WoflZpN1bI?=
 =?us-ascii?Q?lGVWLQRhcKmz9Jn9o+BREhqw9e9JOPqrlT9iT3yhD07p7mCTVEhmW4hSb7Xd?=
 =?us-ascii?Q?PekKNuGEhU7UfubzAwh2rHZOco+Czn8GdLARH4H1mcN0xkCokTlGzU2mQw++?=
 =?us-ascii?Q?AYWuaeYFHZ1G5hS8PJI2gEfmsGu/izcTYqe3oWZUOxISjEWUHK9E/sz3SfMp?=
 =?us-ascii?Q?desWCwbkG3+DNP+8fxpZqZMa8N2xyZgDhCV/GJRIB56vlim/0/StblTF/EqK?=
 =?us-ascii?Q?jcJhW2bSZl2DMzXazoQJrhGaLQDqwJ8+e+aeGNTo9xEbpbNOHoxKWIRYHqpw?=
 =?us-ascii?Q?MvVQqufXeBvaaEN8tHcBMqpiKH1Yxv40r2bnMiYdcTNYddomAkAPBb1OnoY9?=
 =?us-ascii?Q?RNZLtRKvY9vCeiGf1l5u7B7Sf2lsC8qyLaNOh2afsDEYNtMeul0TMNT29YO7?=
 =?us-ascii?Q?d+u7D4/YuYRIcfUlK4excZGXWuF0GDhgmKo3mwEPI4k+PAx3lWDe0z1Klhqo?=
 =?us-ascii?Q?wwXnwV4K6njp1NH6hMXoVeSIouF27n5uAtk2rpZ+ypACykV+OpyDu0LNUXwf?=
 =?us-ascii?Q?K1eahAg1+PbXrlK8Q+yHGTUGXx7V1N3PWWst95mHwqLW66Jm0QmOGlHWNtgR?=
 =?us-ascii?Q?EC6Fj7cp+JW4dJ+HYyWQ9+oTG6JgSH7PTUWh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:26:11.7066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4604837-c021-4014-a8ca-08ddf0547706
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956

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


