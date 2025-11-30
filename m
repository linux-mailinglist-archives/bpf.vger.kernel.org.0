Return-Path: <bpf+bounces-75780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70695C94D84
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 11:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FBC3A4AA0
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8D527E05A;
	Sun, 30 Nov 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AAnPtFOj"
X-Original-To: bpf@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048327703E;
	Sun, 30 Nov 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764497666; cv=fail; b=X3FzPoRr8cAdeJQISNNtObcRqcqQQdW/qobkB2NzTsOfHHj0Cy08GWtn7PWiWdFr34F1Ppw5z2IQMOdsCB0AbuWArUj7f04ABHy87vceleEOsgj7/Sm7bTHIuhpYqEmOmlbCeIiEexbIWtUmycmafwWYqE4EcMuY+yuXfGwGVYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764497666; c=relaxed/simple;
	bh=SMaSljIRIP2ohkAjE1YVYPmYohA1Kdeyh26ZnGKDboI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuWodEMxu1akLpJgXVeiZKYW3QYX/V3yJ3/5+FREcIeD3GIxNqBRj/X5KzzQ1qTWg6pDgdndNOwc63RJsQkyRzUc2fuAD//kx3Sxk2Q4d+b2XsN6eZ2ONPcqaAflNBSiUvU0QCKU0ypEHy0iO59Y9d6K/O7SpKjbf1sLfZr61qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AAnPtFOj; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/ygrOdzmp8qrSB5XveAPvm1eOem8fklRJUHTHImH3OvPE2m8AANCtvd/riDT9wk4TF++wJgiCoOghTsS2eM5no/TA10y702lCXR6Go+vQjSWpsFPZpOuskfDqsrCDBXsG74UwjvMt3djpr2cdBZP3P8AylkizU/M0qbmKldRnZ1WhxhDXuYVEPyrjjxIr/L81wX6PySWBd1GVU8m8G3wH5/tVuhzEhtTL75u6Tj4zKVqJphVVxmFyfDdV4nlO+hG9CmfgGzCyca7vD2F8MvpzqsK9Gb1WggggHGCZLJoZI8m8Yk/v6oQsXhJKKRMh7oXIbBS62keIjKz7Vx7OUviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34hoFB5JLXoeR7t7uQFfZq8sojaobUCjChScObJXkjo=;
 b=TO8QaqwZk/vlJPVsDud7ZFf9rAADcT+hnPFCX5dYuimrhPpMpH0AtsV/E1A/cTRPiYiG1xbINt2rqrATpfJnImygmB9SI1BA2CLoEEUvmKUSeJyqr+XUk5a0S5c5yNmkSpcdBj8bNZQY40pKIo+FBtHAEwYbSIhe7OMZUcV7ji1HsvTCp1x8INXkfWbmUTNLWd9OEGWSSQZBeuQIuJdTNa/b8ojmYp4ie7g6YVTQ+uj6uo7siCKduFMUhmB6JmhP7+bN37gI/IrLfl/hPcGOw+14bSb++9G7MwTC5qj99wr4PWZTbYTwQcJ6l9AvzA0T4asw6ocS7P9Gt7r6Gf0XWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34hoFB5JLXoeR7t7uQFfZq8sojaobUCjChScObJXkjo=;
 b=AAnPtFOjFCSw2SgQMzsOdLeOs5jN7xeRqrURZnjQZ2TtCVgi+pUQZAKvjSpJ3zhGBqXf6ysf9oK8JVFQMk2r1Tgjdk7vQ6g+8f7F3fEzSyIQsA9rRILSQWC/jKezOV+lAiqsgF2pRfcs3XQisqzG7uimpTKuz0HVGRhuvOMIoTGrBgQqOD1MBjzAUAuSF351VJ9NJfoyCtCPgAsd9TBdfFtQQLULJ17IQIMRUrW08bk6k1s1UkaQIdiM6qTBsbjxX3KxDwNlNk5r/Ig8PgMtPHeAldAMM5jOjzpYqxG1NLjW4Qyt4i/nNUXffg8kzbsSmxsgtnNbBKGw6HB5Vc1fFg==
Received: from BYAPR02CA0003.namprd02.prod.outlook.com (2603:10b6:a02:ee::16)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:14:21 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::ce) by BYAPR02CA0003.outlook.office365.com
 (2603:10b6:a02:ee::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sun,
 30 Nov 2025 10:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 10:14:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:14:10 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:14:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 30
 Nov 2025 02:14:03 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, William Tu
	<witu@nvidia.com>, <toke@redhat.com>
Subject: [PATCH net-next V2 2/2] net/mlx5e: Support XDP target xmit with dummy program
Date: Sun, 30 Nov 2025 12:13:37 +0200
Message-ID: <1764497617-1326331-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764497617-1326331-1-git-send-email-tariqt@nvidia.com>
References: <1764497617-1326331-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba6384d-8114-45df-2e6f-08de2ff93acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DVvlTKLpFdXB2keiyF0nZU+U0xoW13S1B2GSyuMbhE3tNNckAEpZEMXPbvEs?=
 =?us-ascii?Q?DVIKTNgXSWJ+2fOoQn1bWiNfabthgJUM4DSqSe5c63Dc3U/yqdHa1PxavmFd?=
 =?us-ascii?Q?2g9QDzylQYU7fMH4FaWUgOb9s57wu3BE8Kz/3R+Lgg0yrdFvwHVI2ai+zsYU?=
 =?us-ascii?Q?ePcM1nI6p8QcYh04hkPx4VxmVh//iVvvRzj8Sz4SuczzEB8dCf70p/sixfnm?=
 =?us-ascii?Q?TCPd5idXXchHRcGmFT2GPWkZ9fqG5OB+xk5ewR6Fz2GPCuImI/YrC+y+L0i9?=
 =?us-ascii?Q?7ZaAq+/jcssyajswSJGAesadAfLPnGkismt+0OTSEqHh9EFmCnmsADl8XKQw?=
 =?us-ascii?Q?+qxj/49MQX78jtJF56XUe1jaoGXeJEUMMi3Q5EiYAVUO7aosVncCDvzjDM8h?=
 =?us-ascii?Q?l4064wxLSqf9syxdytIhY1dPOubKycVtSL13YNBvtVAqRACAR3IudC/eCzYI?=
 =?us-ascii?Q?y0LxH0JVFv06D1AIRiNesrIY7SkObPOpCl8nW6Ub54VekOzIlL3xmxDA/rc4?=
 =?us-ascii?Q?6l5tbHfn3k8IfjWuWdx8aGBX3o/FyD7jMR/otQ4aRby/pPEdFJs1CVPCHFPy?=
 =?us-ascii?Q?cHt3uI1qByDGVPlbu5XibwhhguNuG1ILPqFA/YqL8/aMS/Yefi1UJNvJfs9h?=
 =?us-ascii?Q?Qb+GarfIEM4HIGeuvfTPz7K2fjgPc6YmZpb5DWbXhZ4wP7joMyIh8JbQZAhZ?=
 =?us-ascii?Q?9GuzOzEreILBbx4uYrHVm0dGEUz6rpsXgOr0il0M+NV407PKdenQnh/lWEFb?=
 =?us-ascii?Q?h0CitjozDTHuR0TUwkuIwFkP+JgpYqhJXWDkDmqReDmtWw9SQC15MJHWxVw+?=
 =?us-ascii?Q?beII7zYwOxjaJoQdNyU5q++/ADvEGnkMgCG/wddECtFq+j+h7HBD3heU+WDj?=
 =?us-ascii?Q?JoGs14EsxRptv/k9D7Sg8IRL5ve5FoeyvGbt3f/3fFX/gzqOex4qqk8hh2ne?=
 =?us-ascii?Q?Ve0GtliDX7pA7mBUWNzj3Z28I7KSDGRy9f/bZLalC2UOl+VN9+Ap2KF5YvEj?=
 =?us-ascii?Q?Tgfyo7dwBUwr1TjByNdcqWX4K2VQOskcxzCSLT6hmNV1xzPth/QYnaNJBAZd?=
 =?us-ascii?Q?n/2upAuwPZwFRD6jvFtzo45so0YSRlUMyHuxOL+S31gxOOWef8z1cSzIMCnv?=
 =?us-ascii?Q?4rVyDk0MM2TSXgS+ZlUmcjFNqLPwcZ3lhHolEKHd0tYoKppmGlvb1+eSysdW?=
 =?us-ascii?Q?RvUWqJckgCeuS7m33npJWPiKt2tAr6axQ2wsPI6Nl/xWhudYJCG8kST96cxQ?=
 =?us-ascii?Q?xfDty7WOmY2ojihQ6rysPr/fOMvVT1OKWGboAc6H6ZgK3Ukw7q8qbhxuQvvC?=
 =?us-ascii?Q?6rY9RYtJ9nRt+RhQhhsHfC/+ziccE+KXWszjjaeTHYMnd+HN607SdeaUuxvj?=
 =?us-ascii?Q?MCycJcACR0kFKsWujS3UK06dP4JLvs4uSqGiN8cOYfqxCEx51z2ooPgMpj+b?=
 =?us-ascii?Q?cvoFFEoo3ynQVvwRuFr7R6a4bwRzyMxIpjtsMelS5EX7+9AEyNiIxJ7CIesh?=
 =?us-ascii?Q?eA8+PO1/3NBqU6TGjaEX/JALue2ZeVxbCX+KHv0jORUVqBH6/v7+4KCjghz0?=
 =?us-ascii?Q?MyQV+RZAlxqWaFyPjiM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:14:21.2911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba6384d-8114-45df-2e6f-08de2ff93acf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253

Save per-channel resources in default, in device and host memory.

As no better API exist, make the XDP-redirect-target SQ available by
loading a dummy XDP program.

This improves the latency of interface up/down operations when feature
is disabled.

Perf numbers:
NIC: Connect-X7.
Setup: 248 channels, default mtu and rx/tx ring sizes.

Interface up + down:
Before: 2.246 secs
After:  1.798 secs (-0.448 sec)

Saves ~1.8 msec per channel.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f0f2bc7f317d..6168f0814414 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2612,7 +2612,7 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	if (err)
 		goto err_close_icosq_cq;
 
-	if (netdev_ops->ndo_xdp_xmit) {
+	if (netdev_ops->ndo_xdp_xmit && c->xdp) {
 		c->xdpsq = mlx5e_open_xdpredirect_sq(c, params, cparam, &ccp);
 		if (IS_ERR(c->xdpsq)) {
 			err = PTR_ERR(c->xdpsq);
@@ -4415,19 +4415,18 @@ void mlx5e_set_xdp_feature(struct mlx5e_priv *priv)
 {
 	struct mlx5e_params *params = &priv->channels.params;
 	struct net_device *netdev = priv->netdev;
-	xdp_features_t val;
+	xdp_features_t val = 0;
 
-	if (!netdev->netdev_ops->ndo_bpf ||
-	    params->packet_merge.type != MLX5E_PACKET_MERGE_NONE) {
-		xdp_set_features_flag_locked(netdev, 0);
-		return;
-	}
+	if (netdev->netdev_ops->ndo_bpf &&
+	    params->packet_merge.type == MLX5E_PACKET_MERGE_NONE)
+		val = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+		      NETDEV_XDP_ACT_XSK_ZEROCOPY |
+		      NETDEV_XDP_ACT_RX_SG;
+
+	if (netdev->netdev_ops->ndo_xdp_xmit && params->xdp_prog)
+		val |= NETDEV_XDP_ACT_NDO_XMIT |
+			NETDEV_XDP_ACT_NDO_XMIT_SG;
 
-	val = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-	      NETDEV_XDP_ACT_XSK_ZEROCOPY |
-	      NETDEV_XDP_ACT_RX_SG |
-	      NETDEV_XDP_ACT_NDO_XMIT |
-	      NETDEV_XDP_ACT_NDO_XMIT_SG;
 	xdp_set_features_flag_locked(netdev, val);
 }
 
-- 
2.31.1


