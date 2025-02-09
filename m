Return-Path: <bpf+bounces-50889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB942A2DC1F
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7D63A6DD8
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8534F1A840D;
	Sun,  9 Feb 2025 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LpyVLQdb"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E1195B37;
	Sun,  9 Feb 2025 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096368; cv=fail; b=BLxvDLuV2U6bx9xO48dOMjPIFNb+K7qqMLqckYSFfH4i2ytQdK/Ibt+1KGxJJIdAh0idLzmkAB1EtUVA9+3V5WaPO7FdDC/9f6svq4wotq+qwpHDqeDj+xnPk7YhA0Cz0Lm8bXpxrzCS7L3kN55pD72oUtwoaXXGedxfznWtZ/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096368; c=relaxed/simple;
	bh=f0tkYPqNgjlWhutZqG5p0PGxUCDZN6UCpb8nyxIkk2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcTn2dFYmItx5mzi4Hcxr2YvJlmUrDAgmN8fA5OOCzVHArMjq2Va2ML7wZ2pMxsPxB1qxXrroAxo9mEABdMsWFlqnm2XUp8xzECEH9n3VI0U1YfmKJPX4pFSTa4EqVV3ua4SPCQsPatbNs8uybidIYrwB8Mf7RL7WqBu5R2oHrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LpyVLQdb; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzpQmCTnT27St+QZjOo5/sKB7UexfiNp1uEdwyUg6d06q4ZxIAcO2ThssDd+dYH7fS+LQSfjAv/ZVxhbeq7pHLXYU7SBs0Saj2VglhWxr2oiyBrmv2DieRxMp6KjH2QPDCqkIwoCte/mEV9dPGh5IaHRdQyLXsP7PhTkV8DIWTvJfxZbR1/6r2XMqYETUkmMgMlmyR8ZtsrD4FzCx/cECv2/6s2UPyqL86+folsWqoWt7XVMnFa1IyUDMTU/EOh+dRg/1mEHsWPUdl/SHos2Saj7jeLPD3SpOLdDM/Jbab9f0ZZrQm2KctLvfMTGStGw2uAezp0b8mvijIRw2+4Sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmVJq97C+Oq339jRPn7JB3ykfpCJEp7E+H+lmhCvXQE=;
 b=ED64bNzVhs1PXzCt3K+7CVECn8iEN7xXA6tixXkemailkE1wvBi+UIZ+IL90/1KjUBtYw26buY6V3XhHvs7QqkHuF/SwOvoHKUTbAsuae1YNWckOKNhS8NkOmKzqBpWfpOtjqCo2scFT8kGMo5YsvRv8JGVYuaRtv2cslL0P1f9NW8cFKU/qz+HgbzIIw0lwwtqq+x/OBEbM/qD79U6Ip7jqGSbgfD7wujU7PdXzf4fEf/IQZ9aacc+WrfbB1rva2kdamc8wjWQJ9J3ZAvDIuOa1XsnkWqhb0hi5+e3q6h72AG82cdYyjpJDLGM1nioukOrEDz13veaJs659VD+IYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmVJq97C+Oq339jRPn7JB3ykfpCJEp7E+H+lmhCvXQE=;
 b=LpyVLQdb9DJBdZBdHYVVq4z65LYNsa2MSbZvFK82tmtvb0T8MEOdNj6VPZaBHNZ7U9o1scY9Yq9/KUd6CTa/FIGtsANyhkeQJY/wNj9EBZ9kKExd559kaBQ/4LLWnVWDExI/A4b4HZZmXMK57l29PsupwEFgNuHA/xvVHfvRnnvjtLUXMf93hVPkyGs8L3j3xV6uCdK7pnsDqproCFDkMrbqhlZZsFa2Tk23vqbKM8/K/70+QRLK23wbcbhldIPkONXxg1C6CpVCND/iPvsh2eC5BrtaXyXlmHQGM43zcGJV0oyZuQmHmMfUwJUbJ6Kn8AEekVPf3fEqCqs47sGBUQ==
Received: from BY3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:254::6)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Sun, 9 Feb
 2025 10:19:20 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::69) by BY3PR05CA0001.outlook.office365.com
 (2603:10b6:a03:254::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Sun,
 9 Feb 2025 10:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:19:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:19:15 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:19:14 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:19:09 -0800
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
Subject: [PATCH net-next 05/15] net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
Date: Sun, 9 Feb 2025 12:17:06 +0200
Message-ID: <20250209101716.112774-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 32257613-7fde-4aa8-d5fc-08dd48f33772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DvqpTZFbII4tqDmPkqahYgO8UAvH5D18gG2AHlRXNG5i7qX//H9qywtuoGBz?=
 =?us-ascii?Q?c2EWkW3nEzJs4kSPqO4DpoOKylG2qE3uaqo24fST49WQ3QaNXaisVQGYXXJy?=
 =?us-ascii?Q?pgNnmPJuZTmHyvKXFFUoh9pyIMkIkG9AnpWt0uZczOTo81T3+9UnYhfZCcBN?=
 =?us-ascii?Q?ypHo67pl8+SGjOZyhN49WoMrkyxBeRe1eaJdqUhfxO5wjkZV+UeEXMCeOQA1?=
 =?us-ascii?Q?bo5MbjQsdm/d83o/lTaU04BNcpvtMjn5J3j7bnibn0KcW5IyyQx5W4Pn4evv?=
 =?us-ascii?Q?lzVRx61ZP8PMuqoCteD6GGI5XDDJrLa/Se+jQzrc+3pvsq1QuVOwtiQ5mvmL?=
 =?us-ascii?Q?q4hylkAlgQbuSc7Y3rg1BOot2IGbnw1H7W8jkZed2WOJMrou15DJMkA3q+TX?=
 =?us-ascii?Q?2cUplWIcXcKJ9oapqtw2Ea39qn8cLXRNCQXxE/dICTfbbylWTNWyDvTsqyJm?=
 =?us-ascii?Q?F0rLHS1cl5JYCRuBUC3oWJkIFp9sIHODWAJO+5fScyVyIFJgiF4wMPjWWvwr?=
 =?us-ascii?Q?kdM23c+SdooJ8E7rRX3Ots8cY5iymlZ9/Uc7AWp2a5a95Uz7lFGOsI8yyZfT?=
 =?us-ascii?Q?1NEyeUl8Q43G0nMxzklG7ZXArhYNO8YWNtniBdE7VycMozZXudrshKYRaHpa?=
 =?us-ascii?Q?v80mPHeavEKHR43OGYnsjVspQUMI9+HexVlQf8mHKMfH8CsbGZ370elSxeau?=
 =?us-ascii?Q?Pcfu7uMH2kxtzdm+IT6Qh+8dZrZV2jd8uDOQuqgqWAkGEx9fd2Eip7JLnl5P?=
 =?us-ascii?Q?RtAz2F22MHx+3ORkhXstrGKBFDs2exo0xLQFavAlRWBbxYa6CxSulP0zSnzx?=
 =?us-ascii?Q?quYbCVlsP6/ZBBniqhSsLhN9V3fvCVx+ysK9N/SDU2elocZ0YKXP1SboQ9Dn?=
 =?us-ascii?Q?t5zQJxZfw45NBQ1XBNlJFbxAFcJMlV1SgiR2/LCr7EyTPPFKV9ONNpcdgV09?=
 =?us-ascii?Q?p/meavScow5MUn+gjC6YYsZmN3HrIZIOt8JS9fDIzsYwUcqKnEnk0/u5Rk2a?=
 =?us-ascii?Q?XoFL8Sutm4JQxuBEq1JPrXxOrPrGSzrhv/V214ZzuadNmTrk4jGRiAeU2AAr?=
 =?us-ascii?Q?ePgwgA1iq2g2/ZSjHjTy80PgnnHIn61gN0+2uTUe97QmqBEpCQC69ZYz8lFt?=
 =?us-ascii?Q?JXJzDFHDijudOeTQbJq/hoXgSAnT01/bBStaNxV/eNN8KtXlrWA8eX7sNil8?=
 =?us-ascii?Q?NtkuZiHPbImbEtfyZV8UrLGQTiI4ft1eRJnFeyiWJAwyl4hQ/iQbqvkNf4Fx?=
 =?us-ascii?Q?iPep6SAT1dtXij2JFx4DJoOZ00zX3jsY9rD1PPXaYbVyzc/bczSnaP4iksL9?=
 =?us-ascii?Q?zW7DJnrA4/scabh4YYthaG1cyuq6wR3GNBXKf34G4HIgjQbIPYuFncTHT+11?=
 =?us-ascii?Q?BctF2hAge+E4Azv0SnWr5G4DTFiQ3BTHnMJZB9HFyMuR31iJMx5JT4R4lgMW?=
 =?us-ascii?Q?XnXSGqMk9ZSoAoQoefumyhdq345gY7ggfjOU4iTRfRkoqLQYRodBBo1lxNbt?=
 =?us-ascii?Q?gCD44qf6i/l1dcI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:19:20.0535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32257613-7fde-4aa8-d5fc-08dd48f33772
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for managing Traffic Class (TC) arbiter nodes and
associated vports TC nodes within the E-Switch QoS hierarchy. This
patch adds support for the new scheduling node type,
`SCHED_NODE_TYPE_VPORTS_TC_TSAR`, and implements full support for
setting tc-bw on both vports and nodes.

Key changes include:

- Introduced the new scheduling node type,
  `SCHED_NODE_TYPE_VPORTS_TC_TSAR`, for managing vports within the TC
  arbiter node.

- New helper functions for creating and destroying vports TC nodes
  under the TC arbiter.

- Updated the minimum rate normalization function to skip nodes of type
  `SCHED_NODE_TYPE_VPORTS_TC_TSAR`. Vports TC TSARs have bandwidth
  shares configured on them but not minimum rates, so their `min_rate`
  cannot be normalized.

- Implementation of `esw_qos_tc_arbiter_scheduling_setup()` and
  `esw_qos_tc_arbiter_scheduling_teardown()` for initializing and
  cleaning up TC arbiter scheduling elements. These functions now fully
  support tc-bw configuration on TC arbiter nodes.

- Added `esw_qos_tc_arbiter_get_bw_shares()` and
  `esw_qos_set_tc_arbiter_bw_shares()` to handle the settings of
  bandwidth shares for vports traffic class TSARs.

- Refactored `mlx5_esw_devlink_rate_node_tc_bw_set()` and
  `mlx5_esw_devlink_rate_leaf_tc_bw_set()` to fully support configuring
  tc-bw on devlink rate nodes and vports, respectively.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 185 +++++++++++++++++-
 1 file changed, 180 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 84f680aecfe2..097fda4d746b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -67,6 +67,7 @@ enum sched_node_type {
 	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
 	SCHED_NODE_TYPE_RATE_LIMITER,
 	SCHED_NODE_TYPE_VPORT_TC,
+	SCHED_NODE_TYPE_VPORTS_TC_TSAR,
 };
 
 static const char * const sched_node_type_str[] = {
@@ -75,6 +76,7 @@ static const char * const sched_node_type_str[] = {
 	[SCHED_NODE_TYPE_TC_ARBITER_TSAR] = "TC Arbiter TSAR",
 	[SCHED_NODE_TYPE_RATE_LIMITER] = "Rate Limiter",
 	[SCHED_NODE_TYPE_VPORT_TC] = "vport TC",
+	[SCHED_NODE_TYPE_VPORTS_TC_TSAR] = "vports TC TSAR",
 };
 
 struct mlx5_esw_sched_node {
@@ -169,6 +171,11 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
 	switch (node->type) {
+	case SCHED_NODE_TYPE_VPORTS_TC_TSAR:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s %s scheduling element failed (tc=%d,err=%d)\n",
+			 op, sched_node_type_str[node->type], node->tc, err);
+		break;
 	case SCHED_NODE_TYPE_VPORT_TC:
 		esw_warn(node->esw->dev,
 			 "E-Switch %s %s scheduling element failed (vport=%d,tc=%d,err=%d)\n",
@@ -354,7 +361,11 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
 		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
 			continue;
 
-		esw_qos_update_sched_node_bw_share(node, divider, extack);
+		/* Vports TC TSARs don't have a minimum rate configured,
+		 * so there's no need to update the bw_share on them.
+		 */
+		if (node->type != SCHED_NODE_TYPE_VPORTS_TC_TSAR)
+			esw_qos_update_sched_node_bw_share(node, divider, extack);
 
 		if (list_empty(&node->children))
 			continue;
@@ -488,6 +499,129 @@ static void esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netlin
 	__esw_qos_free_node(node);
 }
 
+static int esw_qos_create_vports_tc_node(struct mlx5_esw_sched_node *parent, u8 tc,
+					 struct netlink_ext_ack *extack)
+{
+	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	struct mlx5_core_dev *dev = parent->esw->dev;
+	struct mlx5_esw_sched_node *vports_tc_node;
+	void *attr;
+	int err;
+
+	if (!mlx5_qos_element_type_supported(dev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
+					     SCHEDULING_HIERARCHY_E_SWITCH) ||
+	    !mlx5_qos_tsar_type_supported(dev,
+					  TSAR_ELEMENT_TSAR_TYPE_DWRR,
+					  SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	vports_tc_node = __esw_qos_alloc_node(parent->esw, 0, SCHED_NODE_TYPE_VPORTS_TC_TSAR,
+					      parent);
+	if (!vports_tc_node) {
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc node failed");
+		esw_warn(dev, "Failed to alloc vports TC node (tc=%d)\n", tc);
+		return -ENOMEM;
+	}
+
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
+	MLX5_SET(tsar_element, attr, traffic_class, tc);
+	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id, parent->ix);
+	MLX5_SET(scheduling_context, tsar_ctx, element_type, SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+
+	err = esw_qos_node_create_sched_element(vports_tc_node, tsar_ctx, extack);
+	if (err)
+		goto err_create_sched_element;
+
+	vports_tc_node->tc = tc;
+
+	return 0;
+
+err_create_sched_element:
+	__esw_qos_free_node(vports_tc_node);
+	return err;
+}
+
+static void
+esw_qos_tc_arbiter_get_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node, u32 *tc_bw)
+{
+	struct mlx5_esw_sched_node *vports_tc_node;
+
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry)
+		tc_bw[vports_tc_node->tc] = vports_tc_node->bw_share;
+}
+
+static void esw_qos_set_tc_arbiter_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node,
+					     u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node;
+
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry) {
+		u32 bw_share;
+		u8 tc;
+
+		tc = vports_tc_node->tc;
+		bw_share = tc_bw[tc] ?: MLX5_MIN_BW_SHARE;
+		esw_qos_sched_elem_config(vports_tc_node, 0, bw_share, extack);
+	}
+}
+
+static void esw_qos_destroy_vports_tc_nodes(struct mlx5_esw_sched_node *tc_arbiter_node,
+					    struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node, *tmp;
+
+	list_for_each_entry_safe(vports_tc_node, tmp, &tc_arbiter_node->children, entry)
+		esw_qos_destroy_node(vports_tc_node, extack);
+}
+
+static int esw_qos_create_vports_tc_nodes(struct mlx5_esw_sched_node *tc_arbiter_node,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw = tc_arbiter_node->esw;
+	int err, i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = 0; i < num_tcs; i++) {
+		err = esw_qos_create_vports_tc_node(tc_arbiter_node, i, extack);
+		if (err)
+			goto err_tc_node_create;
+	}
+
+	return 0;
+
+err_tc_node_create:
+	esw_qos_destroy_vports_tc_nodes(tc_arbiter_node, NULL);
+	return err;
+}
+
+static int esw_qos_create_tc_arbiter_sched_elem(struct mlx5_esw_sched_node *tc_arbiter_node,
+						struct netlink_ext_ack *extack)
+{
+	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	u32 tsar_parent_ix;
+	void *attr;
+
+	if (!mlx5_qos_tsar_type_supported(tc_arbiter_node->esw->dev,
+					  TSAR_ELEMENT_TSAR_TYPE_TC_ARB,
+					  SCHEDULING_HIERARCHY_E_SWITCH)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "E-Switch TC Arbiter scheduling element is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_TC_ARB);
+	tsar_parent_ix = tc_arbiter_node->parent ? tc_arbiter_node->parent->ix :
+			 tc_arbiter_node->esw->qos.root_tsar_ix;
+	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id, tsar_parent_ix);
+	MLX5_SET(scheduling_context, tsar_ctx, element_type, SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+	MLX5_SET(scheduling_context, tsar_ctx, max_average_bw, tc_arbiter_node->max_rate);
+	MLX5_SET(scheduling_context, tsar_ctx, bw_share, tc_arbiter_node->bw_share);
+
+	return esw_qos_node_create_sched_element(tc_arbiter_node, tsar_ctx, extack);
+}
+
 static struct mlx5_esw_sched_node *
 __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
 				   struct netlink_ext_ack *extack)
@@ -551,6 +685,9 @@ static void __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netl
 {
 	struct mlx5_eswitch *esw = node->esw;
 
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		esw_qos_destroy_vports_tc_nodes(node, extack);
+
 	trace_mlx5_esw_node_qos_destroy(esw->dev, node, node->ix);
 	esw_qos_destroy_node(node, extack);
 	esw_qos_normalize_min_rate(esw, NULL, extack);
@@ -640,13 +777,38 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 
 static void esw_qos_tc_arbiter_scheduling_teardown(struct mlx5_esw_sched_node *node,
 						   struct netlink_ext_ack *extack)
-{}
+{
+	/* Clean up all Vports TC nodes within the TC arbiter node. */
+	esw_qos_destroy_vports_tc_nodes(node, extack);
+	/* Destroy the scheduling element for the TC arbiter node itself. */
+	esw_qos_node_destroy_sched_element(node, extack);
+}
 
 static int esw_qos_tc_arbiter_scheduling_setup(struct mlx5_esw_sched_node *node,
 					       struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack, "TC arbiter elements are not supported.");
-	return -EOPNOTSUPP;
+	u32 curr_ix = node->ix;
+	int err;
+
+	err = esw_qos_create_tc_arbiter_sched_elem(node, extack);
+	if (err)
+		return err;
+	/* Initialize the vports TC nodes within created TC arbiter TSAR. */
+	err = esw_qos_create_vports_tc_nodes(node, extack);
+	if (err)
+		goto err_vports_tc_nodes;
+
+	node->type = SCHED_NODE_TYPE_TC_ARBITER_TSAR;
+
+	return 0;
+
+err_vports_tc_nodes:
+	/* If initialization fails, clean up the scheduling element
+	 * for the TC arbiter node.
+	 */
+	esw_qos_node_destroy_sched_element(node, NULL);
+	node->ix = curr_ix;
+	return err;
 }
 
 static int esw_qos_create_vport_tc_sched_node(struct mlx5_vport *vport,
@@ -977,6 +1139,7 @@ static int esw_qos_vport_update(struct mlx5_vport *vport, enum sched_node_type t
 {
 	struct mlx5_esw_sched_node *curr_parent = vport->qos.sched_node->parent;
 	enum sched_node_type curr_type = vport->qos.sched_node->type;
+	u32 curr_tc_bw[IEEE_8021QAZ_MAX_TCS] = {0};
 	int err;
 
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
@@ -988,11 +1151,19 @@ static int esw_qos_vport_update(struct mlx5_vport *vport, enum sched_node_type t
 	if (err)
 		return err;
 
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+		esw_qos_tc_arbiter_get_bw_shares(vport->qos.sched_node, curr_tc_bw);
+
 	esw_qos_vport_disable(vport, extack);
 
 	err = esw_qos_vport_enable(vport, type, parent, extack);
-	if (err)
+	if (err) {
 		esw_qos_vport_enable(vport, curr_type, curr_parent, NULL);
+		extack = NULL;
+	}
+
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+		esw_qos_set_tc_arbiter_bw_shares(vport->qos.sched_node, curr_tc_bw, extack);
 
 	return err;
 }
@@ -1429,6 +1600,8 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *p
 	} else {
 		err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_TC_ARBITER_TSAR, NULL, extack);
 	}
+	if (!err)
+		esw_qos_set_tc_arbiter_bw_shares(vport_node, tc_bw, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -1455,6 +1628,8 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *p
 	}
 
 	err = esw_qos_node_enable_tc_arbitration(node, extack);
+	if (!err)
+		esw_qos_set_tc_arbiter_bw_shares(node, tc_bw, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
-- 
2.45.0


