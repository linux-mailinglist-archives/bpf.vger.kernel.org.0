Return-Path: <bpf+bounces-74283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA3C5167A
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 10:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FE23ABAA1
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 09:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE8F3043B5;
	Wed, 12 Nov 2025 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G7IywWZu"
X-Original-To: bpf@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF95303CA0;
	Wed, 12 Nov 2025 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939924; cv=fail; b=m+UnJfGlMoPBqAK8NxDhzle8U7mNFCWpTN2z3TxeQDk+xmTwYOqy2lDoKe8lq+3vXQ1m6+jqJ9f3tD5Vy6zN68PwvbZxmE2NjOjIMo93U29fb2O0Gv9DM8VrLNA+jGQu1eEFdpJBVkuokXEvGfKRA2xWgaZ4+6yPRkbk5jGygo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939924; c=relaxed/simple;
	bh=n4v9b+uitHwW4vmRhhhRvdG3/rLVn/O3s5uRc0wx4iI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+oc8j21BYUwA+2+2zyhJpDuTgKR0C2jAwNmLBiZyd3FhUN8HElpx4W3zbyGSwJ8WKVzEasca8aoTvNBqOBlnBPa1ZdPpq25YokOh61l8cSMByALw3FkEOgULEaGQcYX2iQj6mAxJM46SAVAVP7kxWGWO/FDWT4Lz0iTd1hlgjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G7IywWZu; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgX8Aox2h01/teXPjlPJld4fEBbY9dMWouiRMKR+JIZkO8lDACSaidFICeFwmWs4Wz8mUwtOoJMN4dLK4ynNGqQrd6chkjcd7qdkqdNaOYH8QYS2vYTi10MS9aFPD37m9izEyZxfIRLe0PrMMUIRmV19OewU3JgrK9uqp1NNU524K+uaBoIH7RvBfb0DPq+vgLU8NxEwld6oBNu52ApScoRST80BcFTBj09GLssxPxDYlpFW+IJBBqhaFItzmkcS2/Bh1an4E67Lg7Gat4gGSPrkPB6F+eYBNQ291xIfPMtm4v8dR2kHGINp5VC45tUK3/E03pXzUPDDz3aZLYnEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZ6d72Q+8KzAtf17ZtvDWts8GkBxVbalnzI7vsz9EIM=;
 b=IbQWVp0nKKZB/lu4ce0AIKFo4OJ2XAlV9uLcGOwubprza6G+VbH0ksSfzSsrnjZ2ELUBAI5TOG3Dh/ZBorHACs7h1YE4ESP/nUQHTJMD1Ber2pLQdTXc/+E88yvmqT42aMk7E6psauB8VVJ8ZYZ3nmLhRdTWINa12oPEF/MALIkYslJ4vM4tQyqAV1yqmFR4TyU2IoaLap6p3nZdpuxAbRL1h07We0eVUYUERitgfAy23AQSCAetwI35+tkI5nfL3EFnEgnKp75xmrm8ZTVdiB6QWSaAzFY3L6ead7EX4MVcSxHIXiCcDbZz1FJhm/lH0a5lO9b/4/7ZCIoriS/fsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ6d72Q+8KzAtf17ZtvDWts8GkBxVbalnzI7vsz9EIM=;
 b=G7IywWZuC1DlnIrj8gPb8RihalNOhl3Rfp/TQtjmNphNQ/hrMapKfSF2GOFiO+V5KAwXVDRT85/ZQx9VZ7BJjF+cWR8uS3WrQG+mvBAzf7DSb1o7ICR8hna+mGJ4Bwab0KJQ5IhwvYIZJN7wwWgyuGQaDKjtPHPP0GstCWsRDik4+9Z/ll1sCotmEtdXYHZwdw/ArBZ3MK70qnL3tVjY/2xIcLoa04olbNqCGiZ+83zQwXBQ2gYSlTD1I0rcWKSmYUs+lqjec5GSdMUktFnTtSdmceiZrJui1fDpwspLdEzyE8doB4sd00bNUFy/bZGjHVmL0eR55/TXkQvCl5d/YA==
Received: from SN7PR18CA0011.namprd18.prod.outlook.com (2603:10b6:806:f3::19)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 09:31:56 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::cb) by SN7PR18CA0011.outlook.office365.com
 (2603:10b6:806:f3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 09:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 09:31:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:40 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:39 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 12
 Nov 2025 01:31:33 -0800
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
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, William Tu
	<witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
Subject: [PATCH net-next 6/6] net/mlx5e: Support XDP target xmit with dummy program
Date: Wed, 12 Nov 2025 11:29:09 +0200
Message-ID: <1762939749-1165658-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 85baff6c-4c57-4563-1901-08de21ce525f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uRnT7w09OMAf0MnOp8HybOGJptA2FXRI8MCV1BvXgvfkb9Ju2EuGcAPrrR03?=
 =?us-ascii?Q?YfnZy+U3WodAy67ji7bE+7uuDGsn3TciWJt0f9RJ6Ew2Di6ErqglwRyrEchK?=
 =?us-ascii?Q?xcN0Pr6dOUKw5h0FZ6boa39Aww1HWSiy49BSMFbznCiwBIyCdcI+wmjtwhiZ?=
 =?us-ascii?Q?BBPl7omCVA7sgcYyPcyYNidnNrBr9UB1mA/kuRWx55NE2hATEEuhsWiy58no?=
 =?us-ascii?Q?O6nrRC1i8+oxIGoHys/c9arWQpw5PQtHQOEv4eYqmaRMgpNYUO3025/AsJE5?=
 =?us-ascii?Q?6lmtoak/8u9PBcdg9aI4R2UPswZ2RBPEufe2+f6PU4Lv9u/IwlstqWCuGMal?=
 =?us-ascii?Q?RVLGZE4xI0864iarLH5+i58VMXxnzT9aJYwblDNz/RDfjsNYq07kOokh0+/Q?=
 =?us-ascii?Q?kamlsVeoVSDY88nI6i6IFm3zKYIczh99JSlzcKykgzTbJ3EQiMOWqobwNwBu?=
 =?us-ascii?Q?aOoDq9LqQxI33Ovf9dqCDdqKAvckACW1K85aAF0uOnQR7u2H21kGgS3b9IhI?=
 =?us-ascii?Q?dG7p0uc1H38rWX16aLSvcky5aSF5Ad35BmPWsNEgXkjRn5KVQU95+l0lyKIJ?=
 =?us-ascii?Q?z8u8/x1kKZpFk4omMyuwYFtWJ/r4NlVDPjdRF3O0bgbzsalFHC5u3/bDT+Bi?=
 =?us-ascii?Q?IuJ3FGMIYsPfQEx540h3fOOhMq7IW7aNQdGP7owFXODOckXZgfniVEky0Tcf?=
 =?us-ascii?Q?2NsxTujcaHrGzK0x0fjZL69bF0f3DusSsmNaNggQB0+OjKXleLigoOP6bt/8?=
 =?us-ascii?Q?BGYckyZ4J32f+9V2zctp5yv3ZSxcXhcwIvsZbYdKS4udOpK+9o/kH0coG0JO?=
 =?us-ascii?Q?JSeWUS0G3wzjSeHWKS624IJJpg9TTq7DE5VWy8n3g1YtqYo/wTmENpTSyqOM?=
 =?us-ascii?Q?rwBexpeZ6qR2b3Xb8EJ0FngHZAEbZiyw6p7mf36Zp7W0piataIKPnKH4SsVv?=
 =?us-ascii?Q?/5XYwsyMkon+Zvxe/uLdCjpyFo8aqH8BJtSaHYSH+rgLj6H5iGn0TbC3LaMN?=
 =?us-ascii?Q?dyL6U+zbQpEpeIP07NS/TeLV/oX2QuXAxGj8ZdxLIO5ctTQLfB+Qj0fRhIRD?=
 =?us-ascii?Q?rJIggCl8Q+ow7EjxujUIe6Zc5ejLrQ6Wg6Kdqdl42VrZC6O/zPFLLxyhB656?=
 =?us-ascii?Q?gFvT+YtMlXWhqBN3aUAf1rp1lk6KOTaMIMtWuUfGs/WyMQmjLtMwuPt50H4z?=
 =?us-ascii?Q?4/4Z1MvqGQj0kLSN/XIkBEXdw4UdpYShRncm2j7nLQuJ9vfidykzKBMImAp0?=
 =?us-ascii?Q?V+QgaXKOGQHVHtmG7Eh+RLyyQfynk/JgMnSBBQBPbLd2vbQRcrtJloYqIAi/?=
 =?us-ascii?Q?syFuOWXO2uLkg1yaOfkLn/OhwF0ijOazAJdKefCvyj1RRd87//cJYfN2ErXb?=
 =?us-ascii?Q?6YzJO4ayXLsXWyRzwEhTLVN7qQWSIMMsIlnuGfDiJfS7O6hJ6VeD5TK9nF0f?=
 =?us-ascii?Q?wYcF/j858z5TXIjM1mxlqlnx0QqBSucFWvNXYPGOeTXGCrGrzXsMDAexWPDW?=
 =?us-ascii?Q?4o5CBs0+2gxYZdiCfhJITZoo2lCG9F9Z8vc4u5x7940r0Pt6KDA7ajbtsTjl?=
 =?us-ascii?Q?NRwXMdn3o+aLCV5Xsw0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:31:56.0220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85baff6c-4c57-4563-1901-08de21ce525f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

Save per-channel resources in default.

As no better API exist, make the XDP-redirect-target SQ available by
loading a dummy XDP program.

This improves the latency of interface up/down operations when feature
is disabled.

Perf numbers:
NIC: Connect-X7.
Setup: 248 channels.

Interface up + down:
Before: 2.246 secs
After:  1.798 secs (1.25x faster)

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 078fd591c540..23a0b50b9dbd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2652,7 +2652,7 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	if (err)
 		goto err_close_icosq_cq;
 
-	if (netdev_ops->ndo_xdp_xmit) {
+	if (netdev_ops->ndo_xdp_xmit && c->xdp) {
 		c->xdpsq = mlx5e_open_xdpredirect_sq(c, params, cparam, &ccp);
 		if (IS_ERR(c->xdpsq)) {
 			err = PTR_ERR(c->xdpsq);
@@ -4467,19 +4467,18 @@ void mlx5e_set_xdp_feature(struct mlx5e_priv *priv)
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


