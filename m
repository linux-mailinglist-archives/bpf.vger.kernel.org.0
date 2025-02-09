Return-Path: <bpf+bounces-50888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D959CA2DC1B
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EAD3A6D23
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F617B50A;
	Sun,  9 Feb 2025 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G87k+fJv"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6756215CD52;
	Sun,  9 Feb 2025 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096365; cv=fail; b=niupTyOr8cvR/cRqRzfWi0FQ7aguZ8zuzu3ZlvWh7i5P73TbV9EV8THGLbULDkktswNFD/GqwFQr+deke0pH8yt028dR1j8m8flRnk+9O2V3IJ5ftjF/jLhxgU0u+Z299EyLu/IAQGbp4kMCYIG3R1w75aH9RSyz4ksm+5csQ1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096365; c=relaxed/simple;
	bh=Rfm7YdffS5CkaXFPSyT66y02kgc4835PZrE1n70Z6Pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ss9NxNhxbcbwvhjfSaTgacMtVtUCR0TYqWIV1Xi5uCVA4za1oL20a7F/KSR58UvgPJ/95nbkk2Zy26UU1WN3aN5QGTQeMtY9oBKRqoRgvJxb5cLRlHzucvCzFHhRkKmIoY0chomD1mu4+lyj4BjdJeFjj7qGJ0XtFuFwWi7zr94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G87k+fJv; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLQW3O2D4lvvLrZqGxc0uyvCoDE3OA1BXCqO2GvaVmk6/YvqEy8VBOGr/UMzRJKrQkjkVkdh9tWVOKt0GuzZ9vHo90lLsV2JGsgTwidBWRCVw96JbGGqGELBuWIagJ6izoWwHW7rEMyzosv2LIT+u0DziinROrYfy55MLDDy1HQYv+GuW3usnlyV54sh6/Q0z2p3g8NBoapifhnL/1MDUB+NOVrigvy93KaZEQ4OXGlhkvWmRZ+dMf6MXeypG8DTol2F6+lLY76qrZgxkD+Z39HkVVNl4xEOuNLfvgCeT3tccb7g2wmzQVcJBKNmjOr47h3XUVK7XTiW9W1BVIUYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K40Blj6Y8NEcT6Y898hnDSOcc5qGjgt3KopFiVnWoXA=;
 b=sgecejshd4ltWBWfTQ3t/GXe4PK+YcE8mZEbhtWeUGaqXYADWxwnOUURSfbsanIfD9iJZJ23QKvsHr3AxNtdUmCqmB0hAHM9F0Rxn2pZR2j/UP+zhZ7s8es6xNV5N8fEZ/YybMX3+bGujU8NCGqk8PkhyJ9+ESeow5wKZ7w8qLYfvgDYYlr4D+UMZwoQqEfWBNrmQhST85u79dLdA+SyjImEANnTdQmf/oqErSP+JRah0nvCqA1HdYQtiu1L6r5CXZXHctfgqPup8DFpONFms25ScejHeZzinY+nTRaz1Hea+xBf6H7FwTP362tgSxMO3YwdAjI6HvpwD9Gpv5dqBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K40Blj6Y8NEcT6Y898hnDSOcc5qGjgt3KopFiVnWoXA=;
 b=G87k+fJvvGUHV+HCwyCrLWO6wdAqKcW8sYzgwojnN0e4es2acnq4VWpWb6Wcd0DEYSQ4Q7LShdDg+Lk9ezEP+RGCeL2zKo3QNiiG4ZxITa0o9YJOfbrdynlE5hw1VJ6CZRJYPzczODoKgCbEM4fhM+90/YZNCvLtLCGQWrJzTqwTt5t0CM6zTL6kd7yaFB8DLFyM8t4MiNEq3tzfAy3nVAyoicOLgwamkcge1X25zqyq6LFL4DhmmmKYgmIuLVAJPo/GjnQbRvke1MBZwunHcG3K1gu1HPu8NkVcl2fy0imv3EgIfus7nslFm8UMNj0r5jRK2mHwpKFEiVWabtjFeQ==
Received: from SJ0PR03CA0094.namprd03.prod.outlook.com (2603:10b6:a03:333::9)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 10:19:14 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::19) by SJ0PR03CA0094.outlook.office365.com
 (2603:10b6:a03:333::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Sun,
 9 Feb 2025 10:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sun, 9 Feb 2025 10:19:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:19:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:19:08 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:19:03 -0800
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
Subject: [PATCH net-next 04/15] net/mlx5: Add traffic class scheduling support for vport QoS
Date: Sun, 9 Feb 2025 12:17:05 +0200
Message-ID: <20250209101716.112774-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a44008-c918-4e19-7e94-08dd48f3341e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jAWX+I5HBGN5rwmoPWO2kNJGJJ6l85sYLQBmpebYqQZQ8IjZiaWwvqj8brpw?=
 =?us-ascii?Q?LRAfB2vsOztZ3iSPowNUrG5QGi+rQEqmydZOyH/cpBo6dgMuSca6Hj1vUaWR?=
 =?us-ascii?Q?9fYn0bymra9STDKCiAwJ5Rxyon8SO3vX9Mj4EMUk4USGMViW+FjHln1xYKXu?=
 =?us-ascii?Q?cB4yzl12Dd0mKHvhYeQYpFv6azzjP7ETHwOyjQ70o8m8fpRQXqxad1gSIZ5V?=
 =?us-ascii?Q?1sa6Hh+A5p6/9hdjUk5raHLqS14F0w6/YnA+retarUPUy3hjrLQbC7N8jaw4?=
 =?us-ascii?Q?o4J3MBPi03JkqbjXcTjYi3ssRNeLQdnjSPtc82tfNNgWoI4nHZvU0cTbrS1g?=
 =?us-ascii?Q?QeZEBJBcbc+Mj9w88ROgy9twcEWC9+g6jvB/1/Mjrcy4FvsOahLvR+mRBkP5?=
 =?us-ascii?Q?f52n0LtfE32InXyWpopsUyV/Wk6Dscee0DpH2vmxTxLV+o+j1hiPnb2FNn85?=
 =?us-ascii?Q?4zeeOrnDpARJejvJijs0UffYD8kroaougYc9YUJVtdYGE/nCY7swg9kkeACE?=
 =?us-ascii?Q?NsfI1XtpcXOY+ZqRD2i5fAapofHkjLjdquEejJZFdr/9EbPjRtgk8Qe27a7J?=
 =?us-ascii?Q?K6n/TsfL6sCrQtuoiBvVwTMZrlqjwGrxPlb0a/SeX9xiCmnQ3XQU/7NKypg3?=
 =?us-ascii?Q?1YBZz514HRvm0gwfkp+f0hb9roiIPN7Wzulg4IT0mgEoq2i3CrFAeAhEH2XB?=
 =?us-ascii?Q?TuTLPa9Uo6cxDENbFwILmXP2BFqf/mwc0T53Uh4kgkn7OBRzUKum1mpAQSPH?=
 =?us-ascii?Q?6HqYr6XLWMsArPHk2Y0qt80mAsqH6wy4FaeVx0mVWv0xq59Px/ZVwTXwf42M?=
 =?us-ascii?Q?2kZrQK5T15rgs2o1M6P+hCGXsRF2YYnOhBIdlhnfpjkF8Zu4VZQeDkom2ZaF?=
 =?us-ascii?Q?prk5wfLJ0NeBsObCTkB0v8zAvCGY+SFJSQyVt11gzs5F9KCOQQ/uiJa679df?=
 =?us-ascii?Q?bBCfvwiKtXGl85qTRRWo4rDaYHU15NjVfMvarg+mCwk+eArruky5l2t3nnnB?=
 =?us-ascii?Q?uOZh8x5YDuGJuORBS3OdbdHHQ2FKCmJQSL2PdXaO7JG3ruIDmtioTs5+WZ1E?=
 =?us-ascii?Q?n4wKGF6r40gFKw+DStdAX5OSW9t7hcPSxoKi/G0CYjbHWtbwuwSDqbUi8jOD?=
 =?us-ascii?Q?Ve0CJqFOcd2ddfojTe5ksBR4yESR68h44Dt8gnAGNiKRj6V5Y/eS+UVslC+F?=
 =?us-ascii?Q?DM0jkXtXmaWCd3Cg8QOmj4NGc5SRBC4xgFgVUBctz3tkUym4HW8xCVyKbdS/?=
 =?us-ascii?Q?bLCAV57av7zH0Ka9WrMwKIHrbAdWncDB/pHZnSax1uiYvmR4w82YlehPlQaV?=
 =?us-ascii?Q?BcgdG/QoyjyWVCywIxZO8BnMrAkrLMeW5wSH9or4mdNxjmRYVy6JHiW3Spyn?=
 =?us-ascii?Q?9i7L0WECIxCihUDFbpLp/DGZ1gaO0qA5bCPVcMQ+k/qAa96kLO43EwLsZz0v?=
 =?us-ascii?Q?Qbe60wu9NMpEB5cq812k5Boft4QEiMp2IoLdJoGR57D0R6rHmq3ymIxA5iwR?=
 =?us-ascii?Q?tEsG0jDAzaCzOW4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:19:14.4832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a44008-c918-4e19-7e94-08dd48f3341e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for traffic class (TC) scheduling on vports by
allowing the vport to own multiple TC scheduling nodes. This patch
enables more granular control of QoS by defining three distinct QoS
states for vports, each providing unique scheduling behavior:

1. Regular QoS: The `sched_node` represents the vport directly,
   handling QoS as a single scheduling entity.
2. TC QoS on the vport: The `sched_node` acts as a TC arbiter, enabling
   TC scheduling directly on the vport.
3. TC QoS on the parent node: The `sched_node` functions as a rate
   limiter, with TC arbitration enabled at the parent level, associating
   multiple scheduling nodes with each vport.

Key changes include:

- Added support for new scheduling elements, vport traffic class and
  rate limiter.

- New helper functions for creating, destroying, and restoring vport TC
  scheduling nodes, handling transitions between regular QoS and TC
  arbitration states.

- Updated `esw_qos_vport_enable()` and `esw_qos_vport_disable()` to
  support both regular QoS and TC arbitration states, ensuring consistent
  transitions between scheduling modes.

- Introduced a `sched_nodes` array under `vport->qos` to store multiple
  TC scheduling nodes per vport, enabling finer control over per-TC QoS.

- Enhanced `esw_qos_vport_update_parent()` to handle transitions between
  the three QoS states based on the current and new parent node types.

This patch lays the groundwork for future support for configuring tc-bw
on vports. Although the infrastructure is in place, full support for
tc-bw is not yet implemented; attempts to set tc-bw on vports will
return `-EOPNOTSUPP`.

No functional changes are introduced at this stage.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 361 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  13 +-
 2 files changed, 353 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index efcbd3180317..84f680aecfe2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -65,12 +65,16 @@ enum sched_node_type {
 	SCHED_NODE_TYPE_VPORTS_TSAR,
 	SCHED_NODE_TYPE_VPORT,
 	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
+	SCHED_NODE_TYPE_RATE_LIMITER,
+	SCHED_NODE_TYPE_VPORT_TC,
 };
 
 static const char * const sched_node_type_str[] = {
 	[SCHED_NODE_TYPE_VPORTS_TSAR] = "vports TSAR",
 	[SCHED_NODE_TYPE_VPORT] = "vport",
 	[SCHED_NODE_TYPE_TC_ARBITER_TSAR] = "TC Arbiter TSAR",
+	[SCHED_NODE_TYPE_RATE_LIMITER] = "Rate Limiter",
+	[SCHED_NODE_TYPE_VPORT_TC] = "vport TC",
 };
 
 struct mlx5_esw_sched_node {
@@ -92,6 +96,8 @@ struct mlx5_esw_sched_node {
 	struct list_head children;
 	/* Valid only if this node is associated with a vport. */
 	struct mlx5_vport *vport;
+	/* Valid only when this node represents a traffic class. */
+	u8 tc;
 };
 
 static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
@@ -131,6 +137,14 @@ esw_qos_nodes_set_parent(struct list_head *nodes, struct mlx5_esw_sched_node *pa
 
 void mlx5_esw_qos_vport_qos_free(struct mlx5_vport *vport)
 {
+	if (vport->qos.sched_nodes) {
+		int i, num_tcs = esw_qos_num_tcs(vport->qos.sched_node->esw->dev);
+
+		for (i = 0; i < num_tcs; i++)
+			kfree(vport->qos.sched_nodes[i]);
+		kfree(vport->qos.sched_nodes);
+	}
+
 	kfree(vport->qos.sched_node);
 	memset(&vport->qos, 0, sizeof(vport->qos));
 }
@@ -155,11 +169,17 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
 	switch (node->type) {
+	case SCHED_NODE_TYPE_VPORT_TC:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s %s scheduling element failed (vport=%d,tc=%d,err=%d)\n",
+			 op, sched_node_type_str[node->type], node->vport->vport, node->tc, err);
+		break;
 	case SCHED_NODE_TYPE_VPORT:
 		esw_warn(node->esw->dev,
 			 "E-Switch %s %s scheduling element failed (vport=%d,err=%d)\n",
 			 op, sched_node_type_str[node->type], node->vport->vport, err);
 		break;
+	case SCHED_NODE_TYPE_RATE_LIMITER:
 	case SCHED_NODE_TYPE_TC_ARBITER_TSAR:
 	case SCHED_NODE_TYPE_VPORTS_TSAR:
 		esw_warn(node->esw->dev,
@@ -253,6 +273,23 @@ static int esw_qos_sched_elem_config(struct mlx5_esw_sched_node *node, u32 max_r
 	return 0;
 }
 
+static int esw_qos_create_rate_limit_element(struct mlx5_esw_sched_node *node,
+					     struct netlink_ext_ack *extack)
+{
+	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+
+	if (!mlx5_qos_element_type_supported(node->esw->dev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT,
+					     SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, node->max_rate);
+	MLX5_SET(scheduling_context, sched_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT);
+
+	return esw_qos_node_create_sched_element(node, sched_ctx, extack);
+}
+
 static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
 					      struct mlx5_esw_sched_node *parent)
 {
@@ -391,6 +428,31 @@ static int esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_
 	return esw_qos_node_create_sched_element(vport_node, sched_ctx, extack);
 }
 
+static int esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
+						 u32 rate_limit_elem_ix,
+						 struct netlink_ext_ack *extack)
+{
+	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	struct mlx5_core_dev *dev = vport_tc_node->esw->dev;
+	void *attr;
+
+	if (!mlx5_qos_element_type_supported(dev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC,
+					     SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(scheduling_context, sched_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC);
+	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
+	MLX5_SET(vport_tc_element, attr, vport_number, vport_tc_node->vport->vport);
+	MLX5_SET(vport_tc_element, attr, traffic_class, vport_tc_node->tc);
+	MLX5_SET(scheduling_context, sched_ctx, max_bw_obj_id, rate_limit_elem_ix);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, vport_tc_node->parent->ix);
+	MLX5_SET(scheduling_context, sched_ctx, bw_share, vport_tc_node->bw_share);
+
+	return esw_qos_node_create_sched_element(vport_tc_node, sched_ctx, extack);
+}
+
 static struct mlx5_esw_sched_node *
 __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
 		     struct mlx5_esw_sched_node *parent)
@@ -587,12 +649,169 @@ static int esw_qos_tc_arbiter_scheduling_setup(struct mlx5_esw_sched_node *node,
 	return -EOPNOTSUPP;
 }
 
+static int esw_qos_create_vport_tc_sched_node(struct mlx5_vport *vport,
+					      u32 rate_limit_elem_ix,
+					      struct mlx5_esw_sched_node *vports_tc_node,
+					      struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	struct mlx5_esw_sched_node *vport_tc_node;
+	u8 tc = vports_tc_node->tc;
+	int err;
+
+	vport_tc_node = __esw_qos_alloc_node(vport_node->esw, 0, SCHED_NODE_TYPE_VPORT_TC,
+					     vports_tc_node);
+	if (!vport_tc_node)
+		return -ENOMEM;
+
+	vport_tc_node->min_rate = vport_node->min_rate;
+	vport_tc_node->tc = tc;
+	vport_tc_node->vport = vport;
+	err = esw_qos_vport_tc_create_sched_element(vport_tc_node, rate_limit_elem_ix, extack);
+	if (err)
+		goto err_out;
+
+	vport->qos.sched_nodes[tc] = vport_tc_node;
+
+	return 0;
+err_out:
+	__esw_qos_free_node(vport_tc_node);
+	return err;
+}
+
+static void esw_qos_destroy_vport_tc_sched_elements(struct mlx5_vport *vport,
+						    struct netlink_ext_ack *extack)
+{
+	int i, num_tcs = esw_qos_num_tcs(vport->qos.sched_node->esw->dev);
+
+	for (i = 0; i < num_tcs; i++) {
+		if (vport->qos.sched_nodes[i])
+			__esw_qos_destroy_node(vport->qos.sched_nodes[i], extack);
+	}
+
+	kfree(vport->qos.sched_nodes);
+	vport->qos.sched_nodes = NULL;
+}
+
+static int esw_qos_create_vport_tc_sched_elements(struct mlx5_vport *vport,
+						  enum sched_node_type type,
+						  struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	struct mlx5_esw_sched_node *tc_arbiter_node, *vports_tc_node;
+	int err, num_tcs = esw_qos_num_tcs(vport_node->esw->dev);
+	u32 rate_limit_elem_ix;
+
+	vport->qos.sched_nodes = kcalloc(num_tcs, sizeof(struct mlx5_esw_sched_node *), GFP_KERNEL);
+	if (!vport->qos.sched_nodes) {
+		NL_SET_ERR_MSG_MOD(extack, "Allocating the vport TC scheduling elements failed.");
+		return -ENOMEM;
+	}
+
+	rate_limit_elem_ix = type == SCHED_NODE_TYPE_RATE_LIMITER ? vport_node->ix : 0;
+	tc_arbiter_node = type == SCHED_NODE_TYPE_RATE_LIMITER ? vport_node->parent : vport_node;
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry) {
+		err = esw_qos_create_vport_tc_sched_node(vport, rate_limit_elem_ix, vports_tc_node,
+							 extack);
+		if (err)
+			goto err_create_vport_tc;
+	}
+
+	return 0;
+
+err_create_vport_tc:
+	esw_qos_destroy_vport_tc_sched_elements(vport, NULL);
+
+	return err;
+}
+
+static int esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
+				   struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	int err;
+
+	if (type == SCHED_NODE_TYPE_TC_ARBITER_TSAR &&
+	    MLX5_CAP_QOS(vport_node->esw->dev, log_esw_max_sched_depth) < 2) {
+		NL_SET_ERR_MSG_MOD(extack, "Setting up TC Arbiter for a vport is not supported.");
+		return -EOPNOTSUPP;
+	}
+
+	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+
+	if (type == SCHED_NODE_TYPE_RATE_LIMITER)
+		err = esw_qos_create_rate_limit_element(vport_node, extack);
+	else
+		err = esw_qos_tc_arbiter_scheduling_setup(vport_node, extack);
+	if (err)
+		return err;
+
+	/* Rate limiters impact multiple nodes not directly connected to them
+	 * and are not direct members of the QoS hierarchy.
+	 * Unlink it from the parent to reflect that.
+	 */
+	if (type == SCHED_NODE_TYPE_RATE_LIMITER)
+		list_del_init(&vport_node->entry);
+
+	err  = esw_qos_create_vport_tc_sched_elements(vport, type, extack);
+	if (err)
+		goto err_sched_nodes;
+
+	return 0;
+
+err_sched_nodes:
+	if (type == SCHED_NODE_TYPE_RATE_LIMITER) {
+		esw_qos_node_destroy_sched_element(vport_node, NULL);
+		list_add_tail(&vport_node->entry, &vport_node->parent->children);
+	} else {
+		esw_qos_tc_arbiter_scheduling_teardown(vport_node, NULL);
+	}
+	return err;
+}
+
+static void esw_qos_vport_tc_disable(struct mlx5_vport *vport, struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	enum sched_node_type curr_type = vport_node->type;
+
+	esw_qos_destroy_vport_tc_sched_elements(vport, extack);
+
+	if (curr_type == SCHED_NODE_TYPE_RATE_LIMITER)
+		esw_qos_node_destroy_sched_element(vport_node, extack);
+	else
+		esw_qos_tc_arbiter_scheduling_teardown(vport_node, extack);
+}
+
+static int esw_qos_set_vport_tcs_min_rate(struct mlx5_vport *vport, u32 min_rate,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	int err, i, num_tcs = esw_qos_num_tcs(vport_node->esw->dev);
+
+	for (i = 0; i < num_tcs; i++) {
+		err = esw_qos_set_node_min_rate(vport->qos.sched_nodes[i], min_rate, extack);
+		if (err)
+			goto err_out;
+	}
+	vport_node->min_rate = min_rate;
+
+	return 0;
+err_out:
+	for (--i; i >= 0; i--)
+		esw_qos_set_node_min_rate(vport->qos.sched_nodes[i], vport_node->min_rate, extack);
+	return err;
+}
+
 static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	struct mlx5_esw_sched_node *parent = vport_node->parent;
+	enum sched_node_type curr_type = vport_node->type;
 
-	esw_qos_node_destroy_sched_element(vport_node, extack);
+	if (curr_type == SCHED_NODE_TYPE_VPORT)
+		esw_qos_node_destroy_sched_element(vport_node, extack);
+	else
+		esw_qos_vport_tc_disable(vport, extack);
 
 	vport_node->bw_share = 0;
 	list_del_init(&vport_node->entry);
@@ -601,7 +820,8 @@ static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_a
 	trace_mlx5_esw_vport_qos_destroy(vport_node->esw->dev, vport);
 }
 
-static int esw_qos_vport_enable(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
+static int esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_type type,
+				struct mlx5_esw_sched_node *parent,
 				struct netlink_ext_ack *extack)
 {
 	int err;
@@ -609,10 +829,14 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport, struct mlx5_esw_sched_
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
 
 	esw_qos_node_set_parent(vport->qos.sched_node, parent);
-	err = esw_qos_vport_create_sched_element(vport->qos.sched_node, extack);
+	if (type == SCHED_NODE_TYPE_VPORT)
+		err = esw_qos_vport_create_sched_element(vport->qos.sched_node, extack);
+	else
+		err = esw_qos_vport_tc_enable(vport, type, extack);
 	if (err)
 		return err;
 
+	vport->qos.sched_node->type = type;
 	esw_qos_normalize_min_rate(parent->esw, parent, extack);
 
 	return 0;
@@ -640,7 +864,7 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	sched_node->min_rate = min_rate;
 	sched_node->vport = vport;
 	vport->qos.sched_node = sched_node;
-	err = esw_qos_vport_enable(vport, parent, extack);
+	err = esw_qos_vport_enable(vport, type, parent, extack);
 	if (err)
 		esw_qos_put(esw);
 
@@ -692,6 +916,8 @@ static int mlx5_esw_qos_set_vport_min_rate(struct mlx5_vport *vport, u32 min_rat
 	if (!vport_node)
 		return mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, NULL, 0, min_rate,
 						 extack);
+	else if (vport_node->type == SCHED_NODE_TYPE_RATE_LIMITER)
+		return esw_qos_set_vport_tcs_min_rate(vport, min_rate, extack);
 	else
 		return esw_qos_set_node_min_rate(vport_node, min_rate, extack);
 }
@@ -724,12 +950,59 @@ bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *m
 	return enabled;
 }
 
+static int esw_qos_vport_tc_check_type(enum sched_node_type curr_type,
+				       enum sched_node_type new_type,
+				       struct netlink_ext_ack *extack)
+{
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR &&
+	    new_type == SCHED_NODE_TYPE_RATE_LIMITER) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot switch from vport-level TC arbitration to node-level TC arbitration");
+		return -EOPNOTSUPP;
+	}
+
+	if (curr_type == SCHED_NODE_TYPE_RATE_LIMITER &&
+	    new_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot switch from node-level TC arbitration to vport-level TC arbitration");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int esw_qos_vport_update(struct mlx5_vport *vport, enum sched_node_type type,
+				struct mlx5_esw_sched_node *parent,
+				struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_parent = vport->qos.sched_node->parent;
+	enum sched_node_type curr_type = vport->qos.sched_node->type;
+	int err;
+
+	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+	parent = parent ?: curr_parent;
+	if (curr_type == type && curr_parent == parent)
+		return 0;
+
+	err = esw_qos_vport_tc_check_type(curr_type, type, extack);
+	if (err)
+		return err;
+
+	esw_qos_vport_disable(vport, extack);
+
+	err = esw_qos_vport_enable(vport, type, parent, extack);
+	if (err)
+		esw_qos_vport_enable(vport, curr_type, curr_parent, NULL);
+
+	return err;
+}
+
 static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
 				       struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_sched_node *curr_parent;
-	int err;
+	enum sched_node_type type;
 
 	esw_assert_qos_lock_held(esw);
 	curr_parent = vport->qos.sched_node->parent;
@@ -737,16 +1010,17 @@ static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw
 	if (curr_parent == parent)
 		return 0;
 
-	esw_qos_vport_disable(vport, extack);
-
-	err = esw_qos_vport_enable(vport, parent, extack);
-	if (err) {
-		if (esw_qos_vport_enable(vport, curr_parent, NULL))
-			esw_warn(parent->esw->dev, "vport restore QoS failed (vport=%d)\n",
-				 vport->vport);
-	}
+	/* Set vport QoS type based on parent node type if different from default QoS;
+	 * otherwise, use the vport's current QoS type.
+	 */
+	if (parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		type = SCHED_NODE_TYPE_RATE_LIMITER;
+	else if (curr_parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		type = SCHED_NODE_TYPE_VPORT;
+	else
+		type = vport->qos.sched_node->type;
 
-	return err;
+	return esw_qos_vport_update(vport, type, parent, extack);
 }
 
 static void esw_qos_switch_vport_tcs_to_vport(struct mlx5_esw_sched_node *tc_arbiter_node,
@@ -1038,6 +1312,14 @@ static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw, u32 *tc
 	return true;
 }
 
+static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport, u32 *tc_bw)
+{
+	struct mlx5_eswitch *esw = vport->qos.sched_node ?
+				   vport->qos.sched_node->parent->esw : vport->dev->priv.eswitch;
+
+	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
+}
+
 static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
 {
 	int i;
@@ -1111,8 +1393,45 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *priv,
 					 u32 *tc_bw, struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on leafs");
-	return -EOPNOTSUPP;
+	struct mlx5_esw_sched_node *vport_node;
+	struct mlx5_vport *vport = priv;
+	struct mlx5_eswitch *esw;
+	bool disable;
+	int err = 0;
+
+	esw = vport->dev->priv.eswitch;
+	if (!mlx5_esw_allowed(esw))
+		return -EPERM;
+
+	disable = esw_qos_tc_bw_disabled(tc_bw);
+	esw_qos_lock(esw);
+
+	if (!esw_qos_vport_validate_unsupported_tc_bw(vport, tc_bw)) {
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch traffic classes number is not supported");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	vport_node = vport->qos.sched_node;
+	if (disable && !vport_node)
+		goto unlock;
+
+	if (disable) {
+		if (vport_node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+			err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_VPORT, NULL, extack);
+		goto unlock;
+	}
+
+	if (!vport_node) {
+		err = mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_TC_ARBITER_TSAR, NULL, 0, 0,
+						extack);
+		vport_node = vport->qos.sched_node;
+	} else {
+		err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_TC_ARBITER_TSAR, NULL, extack);
+	}
+unlock:
+	esw_qos_unlock(esw);
+	return err;
 }
 
 int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
@@ -1231,10 +1550,14 @@ int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_s
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.sched_node && parent)
-		err = mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, parent, 0, 0, extack);
-	else if (vport->qos.sched_node)
+	if (!vport->qos.sched_node && parent) {
+		enum sched_node_type type = parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR ?
+					    SCHED_NODE_TYPE_RATE_LIMITER : SCHED_NODE_TYPE_VPORT;
+
+		err = mlx5_esw_qos_vport_enable(vport, type, parent, 0, 0, extack);
+	} else if (vport->qos.sched_node) {
 		err = esw_qos_vport_update_parent(vport, parent, extack);
+	}
 	esw_qos_unlock(esw);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 8573d36785f4..9cd231a6b924 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -212,10 +212,19 @@ struct mlx5_vport {
 
 	struct mlx5_vport_info  info;
 
-	/* Protected with the E-Switch qos domain lock. */
+	/* Protected with the E-Switch qos domain lock. The Vport QoS can
+	 * either be disabled (sched_node is NULL) or in one of three states:
+	 * 1. Regular QoS (sched_node is a vport node).
+	 * 2. TC QoS enabled on the vport (sched_node is a TC arbiter).
+	 * 3. TC QoS enabled on the vport's parent node
+	 *    (sched_node is a rate limit node).
+	 * When TC is enabled in either mode, the vport owns vport TC scheduling nodes.
+	 */
 	struct {
-		/* Vport scheduling element node. */
+		/* Vport scheduling node. */
 		struct mlx5_esw_sched_node *sched_node;
+		/* Array of vport traffic class scheduling nodes. */
+		struct mlx5_esw_sched_node **sched_nodes;
 	} qos;
 
 	u16 vport;
-- 
2.45.0


