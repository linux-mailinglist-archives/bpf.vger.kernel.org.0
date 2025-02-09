Return-Path: <bpf+bounces-50899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674B1A2DC59
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB750165B8B
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F081D935C;
	Sun,  9 Feb 2025 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ta3Y3B0j"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EEF1D5AAD;
	Sun,  9 Feb 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096423; cv=fail; b=kxgsmgSLkn7wsi5BVf1xil8KUnlt1cX/TTROql9fyaIjItSVTOrKgeYwglxV4UCDEPFbfAk1vFmkLbPkVMcHxB3XFfFd8bMQXWr3McMKIUXRDluSs8ndcUHsHt1PnXH0SmaRfxg03Cax/LVz2T67wSQPvWYOwFJcL80vbVbGhog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096423; c=relaxed/simple;
	bh=mtG2OBxa5lEk38ygdIVL/B6KTM8gISqWMJiPwtyYS/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VO/0puUQwGvSCalcQUf++B90Us6eG8u5S2lblK6TTUmlTjelgc3S/JUNxSBkPrbnY4kDW3UDpDB0eOzBP+J8d5HHArH+uA9Q0SB59uXjjnMDIpyz8qhJGYClQw8KuRj4WstVuioScAplb4QiMQBLYAf7Fy+v5oixP1OJnSk0SGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ta3Y3B0j; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROuI3EXEb/6otIP0Ojf6/+jJTYIJlFqlCmrnh/q3pxJi0aAOKF8kTrHUz66eBCIa7tnyWHT4GN5bBqcxItIc2HC45RZF5klbw7TSNRy8r7tcr5qBrkI3+rmTXVt7hXCYMZYHn6FV+YfVNU30AZivi8HjKwtja7RiuNeSZh+IkbrB5U5fjJggUZfHiPq9Qkz2km4kwNq6aB7tiZpymkP03To0CjhL5zZe4h6wUcGId+aUIoKF/nye67YNdXH5X36Rh/YogxdSosDSCOkirT4YWr0Jw1KC6EQGARPbMlgjAufBAu1aFEoCJYbfOqaUET6pZme8/VFohA6rngVaJxJ2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0gHxefuejxy5/6ZoMCuTrQc38czNSeq20vxSOdC1dQ=;
 b=mse7O6MrCjKZS1bUPpEBLD5pNuCpQJoKZATAf9u+l57mnzH80FVd52OMIekfG3TIpmMA9fOgR3grV4b3bsUOfTFvbb81GozOlrtpwIs347cGY7gtsNfOVFkeYSKpFq4PeSFxeoKeY9riA5p37zAUvHDr5HfdJQ2Fgt1+x2K/IfB0Pwmt4G6coQvdgRkYkuJYm2dbkQN/Ofp9ZBNg2xtasZ9cX9to7FNw8tJ81CWmh71MWKK1hsYT/wJIj9I+IBWdMVcsTdNA3l1YInhuvXta1hD7mopuh340ftoQsYFl+lPTdKzTbq+sTKgQU4VIDKksMkQimx1SsAgG2zK0YE9irA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0gHxefuejxy5/6ZoMCuTrQc38czNSeq20vxSOdC1dQ=;
 b=ta3Y3B0jKCMrCkzfjjNMDNnQ8evMbEyLUlqKx9r4UC/XSO8Ivsyn79yKfch4rRJBEXph5l4p0EQXSDyUQzZQRF5FrWVYzjeeC3QyiqYZYeZ5/9+xoHqOEXSHYDeVoj93ttwopNTFiw6rRKeWVM3Sctw86bjKA0BJj7TDXy4eDAKAQDPgwsOUQ5iAs2TwK6/RNEx0bhQlGf+49RL1XB9/Wq0ra0oKMvkAyGInX4BfuJN3mZZvVAFvN2TH1Pf0vh15Jqdn492JpCFflsjL2BjG1PpXsT4d0Rut0mH/tVzciKCOehMajHidKJtWjepwpDFDXnfiSM1Qmnryk/qhJroe1g==
Received: from BY3PR10CA0021.namprd10.prod.outlook.com (2603:10b6:a03:255::26)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 10:20:16 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::1) by BY3PR10CA0021.outlook.office365.com
 (2603:10b6:a03:255::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Sun,
 9 Feb 2025 10:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:20:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:20:12 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:20:12 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:20:07 -0800
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
	<bpf@vger.kernel.org>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH net-next 15/15] net/mlx5: XDP, Enable TX side XDP multi-buffer support
Date: Sun, 9 Feb 2025 12:17:16 +0200
Message-ID: <20250209101716.112774-16-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 71062ce8-be56-4393-3256-08dd48f35870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rme5fRCW4Xfl4pem0lPzHy5AF/9qyyA84mcpOJAOO+VV7DgfxGYtgXnKtp/R?=
 =?us-ascii?Q?80YhjbNJ43i+K2m78mH1Mcg1NeEdHmDTVRfVnn8Qc934LHyvErWb9DhQ4wRF?=
 =?us-ascii?Q?rVOD9CHhTC8JDo76Wz79ZruasB8nXu52NRKAkfA+vFWR4aFaTrW6lqSUTAeW?=
 =?us-ascii?Q?Ybwe4gn05eTZbONi6n8a+zICRbUT2wAJ2JlVQtPsEWze8jms3mR5FeDYo0xF?=
 =?us-ascii?Q?twPWMCOb0wDyG/HGwfDxcHCKioP7Z8dLdI3EiufvP9Dwe30txYGdrjztJvZv?=
 =?us-ascii?Q?NxNX3yHWkhWD7qukt46vyPj7YNEAoKkcPH/Cc70qO93wTk/ZyX3cW6INEl25?=
 =?us-ascii?Q?j4HCk1SKahJGyAXsihYRJOnzTrDh9dptG0IHQTGkCotMSmfzaTubPA7EHOYK?=
 =?us-ascii?Q?DESqGXJZ+BRT/TmodzoiGj/aW0mA1cGlZ7PTJKTVqwMN/uJVm35SNXnVnjD8?=
 =?us-ascii?Q?SMbyRk/LIIAcmllgOLFS6E1yVLBmXA9TBZe19ZdYv6PhjpNNisthjib9KqYN?=
 =?us-ascii?Q?fPWAbkUkTcje8dIKopX5Fjy7OSnb7ialCkAD2pzxZvbQD0t9MSjZhyOL4sGE?=
 =?us-ascii?Q?g/Huma6HaOkwxszC5mE6kE2vDkhNrf4eW6AvqfhroA4vJV8K8BTZlM6MMJcg?=
 =?us-ascii?Q?uODiviE565LY1me9K+YaCkDK9YwL4CigvT9CTkhTGfryaWgzqjd9tzJQXVY0?=
 =?us-ascii?Q?53fTZB2lyZ9Sm5i5SEmS+XRA/n9iv2eY5fEn9Wl2UoZxPuEdmnn5z0D4GvEt?=
 =?us-ascii?Q?LFqYuIqQAUGZsrV3ZFzhPNziWKrHV9sqycoWJ92vX7ZCxMZtBWwzQER5EKOp?=
 =?us-ascii?Q?655l6xg3vETjoOdgrQZq+gy8sjLoQuRfZaFb0XeiOPP783g0P7y1LsxpLT7O?=
 =?us-ascii?Q?yf2pA5yIyUii/FFr9CqY+d2leNfGwgwu9CvXFA7vMVEnM4pLQIG+JfkFeNuT?=
 =?us-ascii?Q?kx/avUtcbgp7mxlBeKIlxqQMM389ktjAKwSBTwZZM7qTk7dTj23dOIYIsbpd?=
 =?us-ascii?Q?+Tn9mIGCSruQTVEPY6JtIyNL2GezQCZ2Olxu74gMJfpZr+nlhWtiR/0Pdo2R?=
 =?us-ascii?Q?UGh8J1V7KqOooSkGk8dvrNNkv6A0hf2t2/h+ByoFqpKs529b+7+tEJlGmY9L?=
 =?us-ascii?Q?AYSvwTJXvDlTZaRSN7lICPr3fIVySAVz8VhH9wyjIwqrGUrWrltDqYtNGXCb?=
 =?us-ascii?Q?2idcn4C/LXbSDmXKeVbltHP/33ZK79+Mtaf65zoJbCiJ/6Cp1sDZRV5f3Am9?=
 =?us-ascii?Q?0pupXI6GBj3KeAwFKCuSAPnRNnef7O0NlIZDJIGp6B/bDZPQtFZ1HoLQ+gJi?=
 =?us-ascii?Q?UiX/FGaBV3dMShT5F2Ft8g7gH6mXnbT+5Oc6sFPbDzPAeNPhZnEPosff6r7D?=
 =?us-ascii?Q?smUWabX0vXJdD3i3iOEEJPTV5KFX9QBo6xpTQs9liP1lSuZEdVRgnppvT5pm?=
 =?us-ascii?Q?a706BfR0O0cZbjBxNWDJfYmVvwwPckNCtlbFzhJNNaLRdUjy9nBcI9KiH/tE?=
 =?us-ascii?Q?Vxf8BY2rRaRbLJg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:20:15.4166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71062ce8-be56-4393-3256-08dd48f35870
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645

From: Alexei Lazar <alazar@nvidia.com>

In XDP scenarios, fragmented packets can occur if the MTU is larger
than the page size, even when the packet size fits within the linear
part.
If XDP multi-buffer support is disabled, the fragmented part won't be
handled in the TX flow, leading to packet drops.

Since XDP multi-buffer support is always available, this commit removes
the conditional check for enabling it.
This ensures that XDP multi-buffer support is always enabled,
regardless of the `is_xdp_mb` parameter, and guarantees the handling of
fragmented packets in such scenarios.

Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 -
 .../ethernet/mellanox/mlx5/core/en/params.c   |  1 -
 .../ethernet/mellanox/mlx5/core/en/params.h   |  1 -
 .../mellanox/mlx5/core/en/reporter_tx.c       |  1 -
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 49 ++++++++-----------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 29 -----------
 6 files changed, 21 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 534fdd27c8de..769e683f2488 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -384,7 +384,6 @@ enum {
 	MLX5E_SQ_STATE_VLAN_NEED_L2_INLINE,
 	MLX5E_SQ_STATE_PENDING_XSK_TX,
 	MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC,
-	MLX5E_SQ_STATE_XDP_MULTIBUF,
 	MLX5E_NUM_SQ_STATES, /* Must be kept last */
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index e37d4c202bba..aa36670d9a36 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -1247,7 +1247,6 @@ void mlx5e_build_xdpsq_param(struct mlx5_core_dev *mdev,
 	mlx5e_build_sq_param_common(mdev, param);
 	MLX5_SET(wq, wq, log_wq_sz, params->log_sq_size);
 	param->is_mpw = MLX5E_GET_PFLAG(params, MLX5E_PFLAG_XDP_TX_MPWQE);
-	param->is_xdp_mb = !mlx5e_rx_is_linear_skb(mdev, params, xsk);
 	mlx5e_build_tx_cq_param(mdev, params, &param->cqp);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 3f8986f9d862..bd5877acc5b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -33,7 +33,6 @@ struct mlx5e_sq_param {
 	struct mlx5_wq_param       wq;
 	bool                       is_mpw;
 	bool                       is_tls;
-	bool                       is_xdp_mb;
 	u16                        stop_room;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 09433b91be17..532c7fa94d17 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -16,7 +16,6 @@ static const char * const sq_sw_state_type_name[] = {
 	[MLX5E_SQ_STATE_VLAN_NEED_L2_INLINE] = "vlan_need_l2_inline",
 	[MLX5E_SQ_STATE_PENDING_XSK_TX] = "pending_xsk_tx",
 	[MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC] = "pending_tls_rx_resync",
-	[MLX5E_SQ_STATE_XDP_MULTIBUF] = "xdp_multibuf",
 };
 
 static int mlx5e_wait_for_sq_flush(struct mlx5e_txqsq *sq)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 3cc4d55613bf..6f3094a479e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -546,6 +546,7 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 	bool inline_ok;
 	bool linear;
 	u16 pi;
+	int i;
 
 	struct mlx5e_xdpsq_stats *stats = sq->stats;
 
@@ -612,41 +613,33 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 
 	cseg->opmod_idx_opcode = cpu_to_be32((sq->pc << 8) | MLX5_OPCODE_SEND);
 
-	if (test_bit(MLX5E_SQ_STATE_XDP_MULTIBUF, &sq->state)) {
-		int i;
-
-		memset(&cseg->trailer, 0, sizeof(cseg->trailer));
-		memset(eseg, 0, sizeof(*eseg) - sizeof(eseg->trailer));
-
-		eseg->inline_hdr.sz = cpu_to_be16(inline_hdr_sz);
+	memset(&cseg->trailer, 0, sizeof(cseg->trailer));
+	memset(eseg, 0, sizeof(*eseg) - sizeof(eseg->trailer));
 
-		for (i = 0; i < num_frags; i++) {
-			skb_frag_t *frag = &xdptxdf->sinfo->frags[i];
-			dma_addr_t addr;
+	eseg->inline_hdr.sz = cpu_to_be16(inline_hdr_sz);
 
-			addr = xdptxdf->dma_arr ? xdptxdf->dma_arr[i] :
-				page_pool_get_dma_addr(skb_frag_page(frag)) +
-				skb_frag_off(frag);
+	for (i = 0; i < num_frags; i++) {
+		skb_frag_t *frag = &xdptxdf->sinfo->frags[i];
+		dma_addr_t addr;
 
-			dseg->addr = cpu_to_be64(addr);
-			dseg->byte_count = cpu_to_be32(skb_frag_size(frag));
-			dseg->lkey = sq->mkey_be;
-			dseg++;
-		}
+		addr = xdptxdf->dma_arr ? xdptxdf->dma_arr[i] :
+			page_pool_get_dma_addr(skb_frag_page(frag)) +
+			skb_frag_off(frag);
 
-		cseg->qpn_ds = cpu_to_be32((sq->sqn << 8) | ds_cnt);
+		dseg->addr = cpu_to_be64(addr);
+		dseg->byte_count = cpu_to_be32(skb_frag_size(frag));
+		dseg->lkey = sq->mkey_be;
+		dseg++;
+	}
 
-		sq->db.wqe_info[pi] = (struct mlx5e_xdp_wqe_info) {
-			.num_wqebbs = num_wqebbs,
-			.num_pkts = 1,
-		};
+	cseg->qpn_ds = cpu_to_be32((sq->sqn << 8) | ds_cnt);
 
-		sq->pc += num_wqebbs;
-	} else {
-		cseg->fm_ce_se = 0;
+	sq->db.wqe_info[pi] = (struct mlx5e_xdp_wqe_info) {
+		.num_wqebbs = num_wqebbs,
+		.num_pkts = 1,
+	};
 
-		sq->pc++;
-	}
+	sq->pc += num_wqebbs;
 
 	xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, eseg);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 2fdc86432ac0..5d5e7b19c396 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2023,41 +2023,12 @@ int mlx5e_open_xdpsq(struct mlx5e_channel *c, struct mlx5e_params *params,
 	csp.min_inline_mode = sq->min_inline_mode;
 	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
 
-	if (param->is_xdp_mb)
-		set_bit(MLX5E_SQ_STATE_XDP_MULTIBUF, &sq->state);
-
 	err = mlx5e_create_sq_rdy(c->mdev, param, &csp, 0, &sq->sqn);
 	if (err)
 		goto err_free_xdpsq;
 
 	mlx5e_set_xmit_fp(sq, param->is_mpw);
 
-	if (!param->is_mpw && !test_bit(MLX5E_SQ_STATE_XDP_MULTIBUF, &sq->state)) {
-		unsigned int ds_cnt = MLX5E_TX_WQE_EMPTY_DS_COUNT + 1;
-		unsigned int inline_hdr_sz = 0;
-		int i;
-
-		if (sq->min_inline_mode != MLX5_INLINE_MODE_NONE) {
-			inline_hdr_sz = MLX5E_XDP_MIN_INLINE;
-			ds_cnt++;
-		}
-
-		/* Pre initialize fixed WQE fields */
-		for (i = 0; i < mlx5_wq_cyc_get_size(&sq->wq); i++) {
-			struct mlx5e_tx_wqe      *wqe  = mlx5_wq_cyc_get_wqe(&sq->wq, i);
-			struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
-			struct mlx5_wqe_eth_seg  *eseg = &wqe->eth;
-
-			sq->db.wqe_info[i] = (struct mlx5e_xdp_wqe_info) {
-				.num_wqebbs = 1,
-				.num_pkts   = 1,
-			};
-
-			cseg->qpn_ds = cpu_to_be32((sq->sqn << 8) | ds_cnt);
-			eseg->inline_hdr.sz = cpu_to_be16(inline_hdr_sz);
-		}
-	}
-
 	return 0;
 
 err_free_xdpsq:
-- 
2.45.0


