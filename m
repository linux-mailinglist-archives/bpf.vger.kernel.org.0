Return-Path: <bpf+bounces-71144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E1BE54A8
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 21:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09ECA585C08
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606272DCC1F;
	Thu, 16 Oct 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GSvvpMR+"
X-Original-To: bpf@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42259229B12;
	Thu, 16 Oct 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644612; cv=fail; b=G2JkEscqaCPVgLUntOcar0Vayj0rugrx2sMwh/tciQG7fcWftQZZUT+Do1TsMyQ5hng93byBg6a45gEoQcV2yvMGDvv6sCaH8jKSw/XI4TiDRQDU626JwS1TeUYBdNe9Z4rq3E5GxOsuanKR92Ft7HmZa5iPVwimIySHP+lpZN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644612; c=relaxed/simple;
	bh=+2JeHvop5I4rJnjRhY4fw4eYNkgzrn6p0/FhQuIGIYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXAK5NQUrgsU/Jkt50O7zbDIotiXb/fgucKhhwIn/sOOFWS/vXqAVG8Ce9GjQNikqOuuNGge+qHzOdZsMI0lb55rC6ZDB5mqLDWVW5bbCp5oxkCxBCOp9tc0amojONSnnZPf6TsEE/kaeCr7iS0SqZ3VxoHpdoHL8Rx3hRpy6Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GSvvpMR+; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw1MZ4QcKiD2DP29iCSWy64ziOpItoLlss9990g5AvBI4f2shEedk9ILWQY5qGxa/0b0Cv70FKLW8/svF+hXmSvvqrtgJ94TQvWXdzb5ABoh9YVcYgDcTq3OC7fRmLchfSvsr7hYuR2IrLHO13kY8FYpE1wSbcOwAjg/UJOeyqDToI14amyMGHqUJ01HPYG+iEom+rdv6b0FHd+y608WqskTAaM8mQLA4eMeJX9mzQW2S0i8OE8E489J7gmGDCURjnblG4oGpchZmI9F/lCaz1o4Xld4m0k4Qs131Ebgc0/oWDOYuwOhJO4yFoymf9tJHFDrINhYw42CtNkm0CbyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f9PwlgOocfSzrNnMyMAUvPPWuvFqwcoDPqbaJYiqhM=;
 b=B+Xy1rYETpWU0Zdb+T6+0hMI5aur4hOlHxDHVMPgE0icbDVXUOggcwWhu3QYAV6gnlO4bsC67ZroG+w5g/2rimivdiBL7ZWawG97M54H+ZVIJJuoqvUdf7uKmGgoNaO32zXlvrtLXr0Ml0nTM3Y7q/AbA3aGhspXqw2KXoC6/bRsEJxXRTE8UE6VlxMrqBgtIQ+AaI4A+Mkvsv/0SJgosfcTruXuDq7RGDBArOrF3SI3l8yei2pJN0o8Ox7MJha+ukcF1aMYP27Q3mU6Z+jskgOFGo3gcgtCC1duorTZ6Dk93dUbhWNzOEv1go3ab2KvM9duyjM7GxFpsxkvSBO3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f9PwlgOocfSzrNnMyMAUvPPWuvFqwcoDPqbaJYiqhM=;
 b=GSvvpMR+wKrimo7FplTyjhvsDZO7c62Mvhvq7pr1U5fwIRFrvv3GlDC96fqgIXP0pu0hNoYttpqRrQZ4wuFUhKUf9s+9e+Y3Xnn4kKL2XdvpIhSRkNXr18Y89rptaxY54LnFZNB7jaX9/vV58dla107OGUh/CSOHltQBQ7aBL2JSYAnIL02x796pZBNuu4sPcnuYoZnDXEM7b0aa5MApFqWrXKaWSzrHhLkbqB6ecVDR3vUKVVS2qRZRfAkeNERzMWA9Wkt3xKmrWdF3/t7bJjTAjqSH/dPoAKljTOsBF5afAZpL7oTpxAHxOZVeA9Lk8EAgWPHOZVNhipfOwXVKLg==
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 19:56:47 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::26) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 19:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 19:56:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 12:56:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 12:56:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 16
 Oct 2025 12:56:14 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Amery Hung
	<ameryhung@gmail.com>, <martin.lau@kernel.org>, <noren@nvidia.com>,
	<cpaasch@openai.com>, <kernel-team@meta.com>
Subject: [PATCH net V3 1/2] net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy RQ
Date: Thu, 16 Oct 2025 22:55:39 +0300
Message-ID: <1760644540-899148-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1760644540-899148-1-git-send-email-tariqt@nvidia.com>
References: <1760644540-899148-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 20851362-a0c2-4657-575a-08de0cee23bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hBu7py31pHCDExAghUPCx3hDJoVapxetP8SXIkuC9b+QwwugO5nSsksGMgyD?=
 =?us-ascii?Q?GDMdlqbPbNY49radAIjfMnRCi2g9ruE9daO0oRgbwzplVbfHuUjrnD980CYt?=
 =?us-ascii?Q?zlwRZbqIjcr9dJXgrPLEiet34jZGNMK9HiEVOmZwU44fq+tpMfGnAIjJhrE7?=
 =?us-ascii?Q?5qHrx5gNkgXni37izC5O/30aijic04+NeRPlfgFIiSqviAiqK0ghN8HfMZjz?=
 =?us-ascii?Q?tPPvpIuwV05+lXKmflKMQvP83hhp+r5qDmv6w8NDP/6oR/XZtR5Lg30yMPgy?=
 =?us-ascii?Q?PhlKr9JlvW0FTA6VOav7rGM1aND/PTeA++uKeAiU2gXvs4uw6ynORi6vW7Dd?=
 =?us-ascii?Q?hoST8ndUof+YLTO843dBypNHK5l2gUCBC6kKab7FmkQsN8qbNhgTePii4LKM?=
 =?us-ascii?Q?GrR/UKEl9vVPhqEoxLA4kDgUkCQit0GCv0OXF+Iy+IJkpwwPmArhYcKDG6cy?=
 =?us-ascii?Q?PF9DZvT0w/DCa3kAy22Grnoq+h1X3ORoSUrPDj67k6JOYWJh528TleHJewjz?=
 =?us-ascii?Q?QeddeeXQZOvDZ6ctTJ4WWFb26NRJ01OYQ+m4Vm8ZugNn4r/7E9fYAHpBnAc7?=
 =?us-ascii?Q?WggEKzBxuNbrI0S6fI23a5jwh9aCugqGofW1c4CVX8dwL1hCqPgMoYLdN4rg?=
 =?us-ascii?Q?78y9aQPZ6m6s1v3+5ckgfdyDTNSVNxD590XaLLLzcDj6ZCsXzEfvY8aGc+7K?=
 =?us-ascii?Q?aQRYdMgD1KnjPPaQkHv3tgDkUQN6m1zsRjnqL+Ji73D3pggGH0B7oC5UeRhP?=
 =?us-ascii?Q?gfNBC48Xobhi7zbmf8oztjLERh/TInm+IbyEGUj7tXYsOC2qUdGprXqXtcDN?=
 =?us-ascii?Q?fviVYvEL+b8+1XVla7UXYe6v38WyEhA1LGAkf6pC/gVTe4+fsosI86xRN+q+?=
 =?us-ascii?Q?t2c3wsFtLgYa9+9jhU1J+L8UaXNWtwlZTaKAtP0VPe6ZI2K4lanpGL8au6zS?=
 =?us-ascii?Q?KQX51tE/DOrADBIpGkZ4g0cKlOC673UyDLk6eKXYMKaKlOJvydeJ7Qs2N4qX?=
 =?us-ascii?Q?nKhoDXxV8vi+kWAnQjiizMbAkMPYS2078W4xkw0B5+YJtRUAlw5FMChnhCNB?=
 =?us-ascii?Q?3VRwih/gsd/Elr4eEv/16mmbW2lWpV1S0R/e4I887nJwtq2dDscFjsBEIyqb?=
 =?us-ascii?Q?bDklv/oP2Yg7iF+ZgTgWL12YIkpXyAqZN+Tnd3WVBHqd4+PCFSVaPktymrj+?=
 =?us-ascii?Q?5JjggnzWNueokZ4PDMEo3rL8q91MB+lxW6gMemu4y2CLzWejdWsjZjvf1ZLV?=
 =?us-ascii?Q?tdmmUQNA7iBgZsnFtoihXG5XD+9OOfI61pWQHQPZlYfZdgqz+Nzl02YdM3IM?=
 =?us-ascii?Q?eMoLYIY4Bs0Ne1ur2kItjMYsJiprcI3A4tz5UJmdhfJNLCD6/RIo690ykmYN?=
 =?us-ascii?Q?yqnqxxKj+D6kF5CYkMI+txATkg+8cUszTnJx7hbzDmUYsPovuZS69nw1AJiE?=
 =?us-ascii?Q?IXAawJVm25vpWW3Xq0TPE2/V9eGoIbJsm8mOK/kE3s0A6mYhhlI8CNxeB4Lh?=
 =?us-ascii?Q?r4eKWdNxSnVaMpr+8Rb0onil5/jbYKdcpMmPnWHQ2ff3HVGSuORODwYUBOrw?=
 =?us-ascii?Q?E0klu3YGZ0iMjpDu1Gk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 19:56:47.2645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20851362-a0c2-4657-575a-08de0cee23bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

From: Amery Hung <ameryhung@gmail.com>

XDP programs can release xdp_buff fragments when calling
bpf_xdp_adjust_tail(). The driver currently assumes the number of
fragments to be unchanged and may generate skb with wrong truesize or
containing invalid frags. Fix the bug by generating skb according to
xdp_buff after the XDP program runs.

Fixes: ea5d49bdae8b ("net/mlx5e: Add XDP multi buffer support to the non-linear legacy RQ")
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 263d5628ee44..17cab14b328b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1794,14 +1794,27 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	}
 
 	prog = rcu_dereference(rq->xdp_prog);
-	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
-		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
-			struct mlx5e_wqe_frag_info *pwi;
+	if (prog) {
+		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
+			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT,
+						 rq->flags)) {
+				struct mlx5e_wqe_frag_info *pwi;
+
+				wi -= old_nr_frags - sinfo->nr_frags;
+
+				for (pwi = head_wi; pwi < wi; pwi++)
+					pwi->frag_page->frags++;
+			}
+			return NULL; /* page/packet was consumed by XDP */
+		}
 
-			for (pwi = head_wi; pwi < wi; pwi++)
-				pwi->frag_page->frags++;
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			wi -= nr_frags_free;
+			truesize -= nr_frags_free * frag_info->frag_stride;
 		}
-		return NULL; /* page/packet was consumed by XDP */
 	}
 
 	skb = mlx5e_build_linear_skb(
-- 
2.31.1


