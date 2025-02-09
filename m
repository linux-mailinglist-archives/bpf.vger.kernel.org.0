Return-Path: <bpf+bounces-50886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABD8A2DC0E
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC3D3A63BE
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07431898F2;
	Sun,  9 Feb 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZvkWRQ2"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF1154BE0;
	Sun,  9 Feb 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096344; cv=fail; b=innhFAdTCM1qsYn+Lz/oBIwZCZ0fEUS1Oq+AVnvsIn3lEtaBd1FH40R0HlyMkTAr8RJiSTKntj4E0MjMPTPOiUokU7AvQfiT7GdZ97rQc7u6BwAFfEYUJi7Pn/9p7zX0b9G3xXcp98KTE+sXTw6QbOY1+DscLS9TtXRBxrPXdts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096344; c=relaxed/simple;
	bh=PZhKfW9LvIzlsLnOmrB4W+C28i6LzyXbnfKYo0jYdOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cClUBpU6TJeahu1brYyHnW0d4tn53ya10aw9BLTsEubBYT1HbCuZ9afizIn7EV7sGSvj2/PJ2fBclRdYut+Xd0lyCyGNmcaZk2Erl0GOQzfizmm98c3KAwzFasp1jlHkRzmpu0MJbfkuJk1pGFJp9NGaxUoqzBvxSfmwSzelymo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZvkWRQ2; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gg5Rl/Kr4cRzLOUHAs2DUcjgxaIyf1OzhhnrS3SXjZy2kHqQAOb1AKPsn9uxpLUKm38Whp4nzLM3TrFyA3m+1mWt0JzGq9gGy+M+N0vQjmrJUYp7D9OQsdIv+tvlWU/a5lGilJtwZKp7m22jf+BbOTsGKdd6K0Zx/0u21Mh/8NsqjAu8hCS/Hi3zMF+b08HH612SWVcj+DS6qi5K9uR88+5Td9Gll/hXsqeVwtGb/yAJHCEZiAVrnli8nzT8JkvQjuNOOopSwf6ktX/dWlf8MAbDOngJlFif3ZpCUKlJLtGQofdpArWM2NCcRNpavyTR1KZd5BTcJzpiQSzCVq6Aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw3laofYjxED2GxVbHJFY7fPZTjPN8ctuWyOhHuF1z8=;
 b=Te0n+eLITO3ujHlRFYunFzuSOt8WOjt57maK70NXdxqxBee1hsgE8mOwpaAx72276gOHkiCZQkolAOuhOWJlOGaUjLy8j8lxx0j2glhDqSQ8MVYtBU3pJ2k0KD0tGVqNODWX+rCRoDvVl3Shzrcp5rys5OynbzY/CpKaveYaU5kcGDwRZP5PHNv2+uVyQZVuwzdF3MdZ8SggFqU8OQb25gCTYg+W5BoA/brXnt+5Y0zc7yPsMc5WGxI8j9xRSkeFpLJDXdVxtFRZHCHIlmaVjbkpUbsqScoTqlcWfHnJBym4NIhPBLpDm09bwv8uJQAZhm3u+3M1YINboTijTbPKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw3laofYjxED2GxVbHJFY7fPZTjPN8ctuWyOhHuF1z8=;
 b=JZvkWRQ2eyMwmgobh/RzNxGNMGgLlpQ3HfDFLYL+PziBhIA0n84gIs5UWVaulu8YKEVhM4H5ALfqq3hqnSUR04QYwXPniNFr8+kC2Rfe5Fp7eLEtaOTApvP4AcX/lLw57xAO7OStW4cNmmUwpiuM1PV8ZHipNPhiI45CkDvLmQ6lktl3OjuoqKZpNcuaIzAWHx25LHgdaqyBCZ4tZeQXqepTGxY8f0yOb4QhRFpItRwJ47h8D4ASsKkreJR5/OKloetfhebeX0Ite4XJWr38cUqvGTpUkw6SaM4U4IuzBPxREBklim5Ug/+8eX01PofovVNLds/y3UDTiI1In5fWMA==
Received: from PH7P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::30)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 10:18:59 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::c4) by PH7P222CA0023.outlook.office365.com
 (2603:10b6:510:33a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 10:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:18:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:18:57 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:18:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:18:52 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Simon Horman
	<horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Richard Cochran" <richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<bpf@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net-next 02/15] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
Date: Sun, 9 Feb 2025 12:17:03 +0200
Message-ID: <20250209101716.112774-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250209101716.112774-1-tariqt@nvidia.com>
References: <20250209101716.112774-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a8800c-4e31-4667-900e-08dd48f32a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/eANClT/AwRh9hkcAo8krgLn7fggb7HSreRbbaoBZ40SV7zXZGy28AsRHaSp?=
 =?us-ascii?Q?4c3ZbqVgf9iYnTEuRVwLiGsEPg6Z1As0FkCwpbHjlNXf8dQHH9ZbjDHsvzpu?=
 =?us-ascii?Q?sRMyEawCMQgBxcJUZ33L0cgEzx2wyJZzdmeqnQTRVnr584FbFWcdCZDcnnrI?=
 =?us-ascii?Q?G8AJmY8obnq1m0klmiDRIJoR/l7E9hGLglWRSrrqw8ltpR/RpQAdH/KpyA8w?=
 =?us-ascii?Q?gR6hV/HpXq6hEzTvc7UhGULYcA9lWOhF73QfaUeBw8lr6ubdFXya73YreBQK?=
 =?us-ascii?Q?zLgB4QTvNssI8//RtA66/7Qg7oDmeafZYbHvuPIUFXc4Bnc4bLUtQsMMfy5f?=
 =?us-ascii?Q?wFSytPfkBtAPWq42gm/XPpjgsJuGOw51Kp+u9zIt73GKUb3RV486UDdee8+P?=
 =?us-ascii?Q?WtG24QHZgK+tTb9f0L1TWVOMpSSWVl9Kh+S+ozn2OUQsJGO07+sfgJHGRbCb?=
 =?us-ascii?Q?pRdWAUvR1nSAvKSswlC3EEDm9tt8vKJX8qH5Jt3qWu82YRInuhyS9upA0xUL?=
 =?us-ascii?Q?BL/+1fmXyRmwyY5AdADIWtjBUEXZFzCBl0kHbgx5Lodz9buJ+P7bCRFeqW4h?=
 =?us-ascii?Q?OCQ17dexABrsS/avSDsXlFNSBsYJKv+Er2g1DabyGB/q+EMTR4OfKbByyJ4V?=
 =?us-ascii?Q?8L0kv9lpaPLx+lwRikaY7LFqR88t2iKJ5rKNEtJpKzMrvWL4um+Rm4oHYt9x?=
 =?us-ascii?Q?qFaMNeZHUN6VgyJ09lE+bzeeM0GwlxpaTaIzPwUGT/VD4xfTkcliQxKr3uuA?=
 =?us-ascii?Q?gmW9S3tIeEMcFItW3uVZEE0fR5eI5Xtv3hHofh8d6GQkBjNHQdeiFgS2qlhK?=
 =?us-ascii?Q?XJQ33TC0QFKeJ+qp4vrmyoS2A/t8ltaUYlCWsuDRetRK6RzMzBWLcH0NUU1Q?=
 =?us-ascii?Q?sOm0pWJGT7a1WWIPc9XZiHxGpBgW7R9+CFWuY6O3e6WY98N5i+OHp9n1ckRL?=
 =?us-ascii?Q?cOvvAFPBkkJ1qeTyeKUiuY5ZArK6RP20DGiP7bOh4rxWwIs548DbEAiZlSBb?=
 =?us-ascii?Q?3OXhGUbapjsdKgYv99hU1hhxkq80oBG7l8unZdXNBst+YEIZr/elJg7bhG/J?=
 =?us-ascii?Q?9rS8YRYNCOQ1EJr4f7dzOkrZLLS01z07A8k76LcwuiBKBqLo4fPRWAeV7W2a?=
 =?us-ascii?Q?L/mVtxyB9N24V+L17ni7QfSSk5QTBNmuUYcSOg0uLL+Ua08ep9vdO+KVW6vh?=
 =?us-ascii?Q?n7TDwn7Xb9Jw1cCt8qCrEYGt5AGfWM94+klBC3FU0A/bY2swSlZD140fNIeG?=
 =?us-ascii?Q?tLe6x6NVloEnCPs3q6pECAIFXhA/x9mqxkUkl+PiPSKEIML8wl7vgBnyqJCc?=
 =?us-ascii?Q?QcC7w7WCbfhRr/g6ZBiD/xuybmP2KIFHJh9U1t18oEftGpUBzc0+pTmj/umz?=
 =?us-ascii?Q?H3Xz4+f31xO86lvkAY8PKewDQfAfJnPVBRTHPmDak/YHJ8b7g054Bct8e2b3?=
 =?us-ascii?Q?7qdWI3ubizh6X9cq5CeFNtSbHuvsA4RPO78O7/3hYA4T8k24OMYz/WABRkln?=
 =?us-ascii?Q?TVbnm9yPcq5Ello=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:18:58.2222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a8800c-4e31-4667-900e-08dd48f32a7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `mlx5_esw_devlink_rate_node_tc_bw_set()` and
`mlx5_esw_devlink_rate_leaf_tc_bw_set()` with no-op logic.

Future patches will add support for setting traffic class bandwidth
on rate objects.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 98d4306929f3..728d5c06d612 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -320,6 +320,8 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.eswitch_encap_mode_get = mlx5_devlink_eswitch_encap_mode_get,
 	.rate_leaf_tx_share_set = mlx5_esw_devlink_rate_leaf_tx_share_set,
 	.rate_leaf_tx_max_set = mlx5_esw_devlink_rate_leaf_tx_max_set,
+	.rate_leaf_tc_bw_set = mlx5_esw_devlink_rate_leaf_tc_bw_set,
+	.rate_node_tc_bw_set = mlx5_esw_devlink_rate_node_tc_bw_set,
 	.rate_node_tx_share_set = mlx5_esw_devlink_rate_node_tx_share_set,
 	.rate_node_tx_max_set = mlx5_esw_devlink_rate_node_tx_max_set,
 	.rate_node_new = mlx5_esw_devlink_rate_node_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8b7c843446e1..db112a87b7ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -882,6 +882,20 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 	return err;
 }
 
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on leafs");
+	return -EOPNOTSUPP;
+}
+
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on nodes");
+	return -EOPNOTSUPP;
+}
+
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 6eb8f6a648c8..0239f10f95e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -21,6 +21,10 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *priv,
 					  u64 tx_max, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
-- 
2.45.0


