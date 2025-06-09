Return-Path: <bpf+bounces-60058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1DCAD21BB
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96761890952
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FB41A83FB;
	Mon,  9 Jun 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SvVitAHA"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0EB1A2380;
	Mon,  9 Jun 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481179; cv=fail; b=qXZla5sCHtL0HstiiynysVJ8e1U+9sA4ofirXk81/zscUtKVuBYoKorC0I28lypnQeiYza0XuyrvUSOsbdJo/Y4pxXTNvz1DxOYohjUbg1jqU9aRr0Pl1hHfU9xUjcQh3bF929UbiWfV0CdfV6ALikDgckYyu733TICdc67h/rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481179; c=relaxed/simple;
	bh=ZKP5AowOc91bfxJMYUruwyj4KjjnoRH/G5O+SG8VUW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrQTPbEuPBGGvIiJYBa5piMzxRKEm/LjOGwm6m68LU96Se8r/5+0LiJOFSgYNzSoC4A3q7pMuz5GaNyAlo6/9RdK2AZZ509RnFCNAm3+U2CjLkOCKDvz6LwM9HcI4lTzHmdOPKG2Cbc8iAUEc9e9+HNIOVIzt78tbm2w8aP3OUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SvVitAHA; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMT8Do/H58W3uKEV/XvKwWCOpdBl36rtPQwuqG5A/lF4PyJg2FDRQ5iocD21Epxf9ZxH+Ny4Q6K4mG/hGTKOw3ESeqcyvtR1z1mBYySK2B/AcujDpjHeRVPbQvJ64fXh0RlfrqHi41CLtZMcxmTHwdafaFrk/8mugHIAHCzNLmmDsbY2rQ4bqrFPWVKnuL3VnDFOxABplpIKAmf7xV4paPKRh/gOrk2WmAWo1XlPkDGnhSu9JwyYf+6q6XQczLQWTwVrejYV3JsRCkV6Tr1OvpOgSp9iO3jGfoA1oPrnmNg0dTSFAy+KgWon7uj08/lQ+qGcFbcEXEp2YBjMnvBYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgz1OGLRs37uvqGlZMMC1EsF9CaynvpaVkKMug3Cphs=;
 b=Bhe8yAn/BH19p/2xwo8jkL31X1TnZ/POB5HZa2kpPbOF0nghxufK0nSvCTDnYtKMuHD6HU3osr7SjdifHS7EBo4RPZH0cjRimURqQytm3qMgKoeeWevCTYglLefrc/wcW0QxCt7w3uu00rJ/GnZq7ga9bP4mOxWKirPmrA5XXBa/pPhOOFpYztf+wcyv+LgoCGiR3UBLPpiAL6uN9yDF++5cYQ915nSCLmHIqN5i7iq6HVRnr7KwgODUnbAwrPit2teKWCJtIw6AKdE62LVLbBgdVbkNx9p1moCXmY0cdOCyEEJJ2lCBMuJY3w2tG0X/oAjcGWiJveoxZqGR7VAC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgz1OGLRs37uvqGlZMMC1EsF9CaynvpaVkKMug3Cphs=;
 b=SvVitAHAglf9RQPzw3zIiyb2O0ds01F4XsgK3kmIjDrOrnuGw2ADZS6KGkMrdaF6YAjwd3+JPt9O3eTJjEDlvTqaX7pIJbpzo2zPaZUlJJDCiNTAtyj11xZ4YuukzYXQh6lWMHXgQ3D63ADmn+Hpd8Mj5zCiBksekPUZDtK0vQWJekODw4QddJifgRM1tm58ZQ9u4GTo2j6bgxK3wlylBNYXU85JZsJ7rWS8jJdI9EJSuN0mk48tmOO5/H9ZDsQl+OGhUyT9LWJrbhOmFUJxijonhuDCohCyzwY5Yv8PdLJEF07K79uTUuaUqRYDZkU9kPd4AMj1TuonE+/60JWt4Q==
Received: from CH2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:610:59::37)
 by CY3PR12MB9579.namprd12.prod.outlook.com (2603:10b6:930:10a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 14:59:33 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::ae) by CH2PR03CA0027.outlook.office365.com
 (2603:10b6:610:59::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Mon,
 9 Jun 2025 14:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 14:59:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:59:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:59:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 07:59:04 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Simon Horman
	<horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 04/12] net/mlx5e: SHAMPO: Remove redundant params
Date: Mon, 9 Jun 2025 17:58:25 +0300
Message-ID: <20250609145833.990793-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609145833.990793-1-mbloch@nvidia.com>
References: <20250609145833.990793-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CY3PR12MB9579:EE_
X-MS-Office365-Filtering-Correlation-Id: 393a37fa-08f2-473c-f843-08dda7663dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WWqtr8+1u0Y3IpBHjvy8cGpzbHa3hiVIEBDBKSkhKPAp1ZYIh82bHMWB5/dR?=
 =?us-ascii?Q?Dxm/SziXvSSnRZ3BJ52sS7iXWFSoGMIdRdPdCnaLhVCxF3f1XI+VonIE5jYZ?=
 =?us-ascii?Q?Q/KF3082xKlfYJ+bfyjmGB2V64I5PF9iW1hXASIj7uykF5Hjk8V7APJe123n?=
 =?us-ascii?Q?n2K3uws8YsIX389iXsC7BcQkSvN0i0mDQ2EMIeu/zU8i+5YTLGsYTc/5apUE?=
 =?us-ascii?Q?2nbQ6jfyFXWoC8G3++n8w/on0sosG0Cia49IFix4/lv/spz1llbEGwragGXu?=
 =?us-ascii?Q?vhTHP8x72XTOHYy9SMTqpoH6thk4zlZHvV2OqqK7BNdYh9x3kRZW74xjOMsI?=
 =?us-ascii?Q?W/foT/dJXDdHF8vOFMh0/dTg3gzGZqAt8H+4lQFTXbfZ2lHoJu6p8qB8owIp?=
 =?us-ascii?Q?R3vO2HQU/Ggqxrdbyr3zDChqKDad1zRSnu2kFbcXBUdkufybVMZDpZy+YcQz?=
 =?us-ascii?Q?fws+LNjPlP9R99oQyYNvenim0eGy1Vbb7xf/HuppbS2FW/GdsBT7vIp35JDw?=
 =?us-ascii?Q?G4Ke45vFqRnbWHtVaZKQoD9qYW4G11f1lo1cipcZOfvo73rp1XP4s7OWLy53?=
 =?us-ascii?Q?AraGEEYVGj02NTHPX8yyX4ApxjxitNXQizVMpemUhzyb6rpCoK9M6YE4bedk?=
 =?us-ascii?Q?4n6m3rAsmgW6y7h4iPrHKBXQhBtTk3+wCk26r7yCtpIouJ8KDuLNqk2luVwA?=
 =?us-ascii?Q?Zs6XWxcPLo5d0IXP35UzODfg+h35MVHX4dV4Zvr/J3NCiO6/Qm3LKT1ggv7c?=
 =?us-ascii?Q?HEIMhuSwNPDz8PRuZQzYNC0QbretqQz8Oo2mWWRdjonEqkuaAENC1xIddQbI?=
 =?us-ascii?Q?zVCspSle32atbZBuHOdoqT9xkq4N2qwfTkWF8Bsqf5q3M1xfz8SWyW/eSVbY?=
 =?us-ascii?Q?n28d4nBkRg3mt4PURxrU7Lyv2nd0gRAoslTNpcwrXdP79F11Cat/6Dupe0u/?=
 =?us-ascii?Q?5wOD507yjsl0dSlE1PAdOyULWjiNE9jPNywF/nGifV7IK6O4BI2wqre1o7I7?=
 =?us-ascii?Q?Tr5IIGlg4Q5D/AIKXEBDFL/AkeIjcZnrDPseBtGHvL7ehdJXyCU9jT4Rw43t?=
 =?us-ascii?Q?kD5kLqNbs1GGF44iRJacPJmBgbRbOOvZTVzcaZmEfEWQf6n6/KbwVCxW90cV?=
 =?us-ascii?Q?K37VzcBhFWU84L1QmInZnX25RodI8WYzJw7QlsfZ1uBa/0OfN/1h6zZ6eooV?=
 =?us-ascii?Q?FxCkeqBE4Ajo+LSYFGKlaAQRT/dZCSFq6Axw0T3sTjDJyT6fznubilQX1sJ+?=
 =?us-ascii?Q?FoWrRwJoE6honRycFhVUQYG1yoSsq2/3z6Gi0VjRSyHNheByEkO3jAcfhlhK?=
 =?us-ascii?Q?gkE8AJJwo1ZeUDAKAVjbpQf8VtcuOswbdbVs0gLGBxVaUnMKYWyXdAkdF9uP?=
 =?us-ascii?Q?TVW9zmtsEUa+re6sUStvGc1jPf+QG+UBXuAiox9hhh8rOX/tsNxIiLMbY9eV?=
 =?us-ascii?Q?6gDG06KgqNOsiw6qyqRP1E/DZFgIIlNMpM3wevz61XRnTTcmlQatVc1nNxUM?=
 =?us-ascii?Q?1xtVxOl2m3ZPsKkweRQ7fw+10sM256EY1IV6j1rw28ZKAhA78PFjz911u+9y?=
 =?us-ascii?Q?b5s85XWg+GObgjW1ehYflKa3AwU9p1a8BMEk2Eyuo23SFf3aU1mQ23Df+oPL?=
 =?us-ascii?Q?I/cFXrI50/tSfv72INGmqG1N8MfG2BKpILN0jS4oVrmKtanBXO+Pe+qUe0Re?=
 =?us-ascii?Q?8XstGllerRcX2pcBBChrCzqfjXW9QWa8BuJ5lRObVBSEwE07ns3EthJRAC6m?=
 =?us-ascii?Q?7aoEQhLZjQgYnlBVSVlijFMcuKoAWg9F/SkUSGaxK7Y8EB0E8Fr8NV2abK2S?=
 =?us-ascii?Q?R+3gtRI64bwfHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:59:32.1075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 393a37fa-08f2-473c-f843-08dda7663dd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9579

From: Saeed Mahameed <saeedm@nvidia.com>

Two SHAMPO params are static and always the same, remove them from the
global mlx5e_params struct.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 ---
 .../ethernet/mellanox/mlx5/core/en/params.c   | 36 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 ---
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 211ea429ea89..581eef34f512 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -278,10 +278,6 @@ enum packet_merge {
 struct mlx5e_packet_merge_param {
 	enum packet_merge type;
 	u32 timeout;
-	struct {
-		u8 match_criteria_type;
-		u8 alignment_granularity;
-	} shampo;
 };
 
 struct mlx5e_params {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 58ec5e44aa7a..fc945bce933a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -901,6 +901,7 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 {
 	void *rqc = param->rqc;
 	void *wq = MLX5_ADDR_OF(rqc, rqc, wq);
+	u32 lro_timeout;
 	int ndsegs = 1;
 	int err;
 
@@ -926,22 +927,25 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 		MLX5_SET(wq, wq, log_wqe_stride_size,
 			 log_wqe_stride_size - MLX5_MPWQE_LOG_STRIDE_SZ_BASE);
 		MLX5_SET(wq, wq, log_wq_sz, mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
-		if (params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) {
-			MLX5_SET(wq, wq, shampo_enable, true);
-			MLX5_SET(wq, wq, log_reservation_size,
-				 mlx5e_shampo_get_log_rsrv_size(mdev, params));
-			MLX5_SET(wq, wq,
-				 log_max_num_of_packets_per_reservation,
-				 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
-			MLX5_SET(wq, wq, log_headers_entry_size,
-				 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
-			MLX5_SET(rqc, rqc, reservation_timeout,
-				 mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_SHAMPO_TIMEOUT));
-			MLX5_SET(rqc, rqc, shampo_match_criteria_type,
-				 params->packet_merge.shampo.match_criteria_type);
-			MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
-				 params->packet_merge.shampo.alignment_granularity);
-		}
+		if (params->packet_merge.type != MLX5E_PACKET_MERGE_SHAMPO)
+			break;
+
+		MLX5_SET(wq, wq, shampo_enable, true);
+		MLX5_SET(wq, wq, log_reservation_size,
+			 mlx5e_shampo_get_log_rsrv_size(mdev, params));
+		MLX5_SET(wq, wq,
+			 log_max_num_of_packets_per_reservation,
+			 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
+		MLX5_SET(wq, wq, log_headers_entry_size,
+			 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
+		lro_timeout =
+			mlx5e_choose_lro_timeout(mdev,
+						 MLX5E_DEFAULT_SHAMPO_TIMEOUT);
+		MLX5_SET(rqc, rqc, reservation_timeout, lro_timeout);
+		MLX5_SET(rqc, rqc, shampo_match_criteria_type,
+			 MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED);
+		MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
+			 MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE);
 		break;
 	}
 	default: /* MLX5_WQ_TYPE_CYCLIC */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3d11c9f87171..e1e44533b744 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4040,10 +4040,6 @@ static int set_feature_hw_gro(struct net_device *netdev, bool enable)
 
 	if (enable) {
 		new_params.packet_merge.type = MLX5E_PACKET_MERGE_SHAMPO;
-		new_params.packet_merge.shampo.match_criteria_type =
-			MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED;
-		new_params.packet_merge.shampo.alignment_granularity =
-			MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE;
 	} else if (new_params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) {
 		new_params.packet_merge.type = MLX5E_PACKET_MERGE_NONE;
 	} else {
-- 
2.34.1


