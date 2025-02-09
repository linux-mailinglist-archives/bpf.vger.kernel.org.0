Return-Path: <bpf+bounces-50897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B7A2DC4D
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE071887754
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA201CAA70;
	Sun,  9 Feb 2025 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wf7RIapi"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA11C6FE3;
	Sun,  9 Feb 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096409; cv=fail; b=VoRspTjo5T9OQOZVH0ktFo2hFuNbhntzMoaMtZDyjv9JaUxdDDdP6IN71m2mFTgsIHvubnKv0y8QkHI0EejN7WvXuJc6701pmxnchMYfJsFbBQcsx3GNBbe2LM2FEO6Fp9yBIG4mbedamTmC0ISPX4tjR4c8z2b2C2PYY0g4aEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096409; c=relaxed/simple;
	bh=2Dtq1Z181y6JdpdlxsBVQg3QjvdjZujOMgzGtudtEVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Olhzl9CFl8aqLeUcUaS1y4ZtS0P5hZnPyvvowTVJuYlN4CGlWAsD6vNmh2ZMg+nRauS32TZlUW7xFkydqdUYayph8tBITjFoYDsfvWF+FJlHH/SctqH9fi8Nw21qIcrO3l894QuRGVKpGmvw6jT7VYXFtMElO/XvgcWNkeJ51pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wf7RIapi; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGEKIX/F2PzQhCfYFutFBanNV1cd3N8Afux5n2TTxOYNG+vn6P9vmFhfMIaPYnycEeBCJuTHXelN5qbWuBiO9s8U2v4qSWclyY16PVLnh0rV5NZPtlh2zKOXeKW1DY1vboDrs+7rO78izo3fbjwz6eKtZNU+aMMQZW0KmF9Y+UoLzK2S/Zi8MH4VoeCxQOR/loJYBVRZ2khfmvgItpJLS2EgjRpHi5e3kBDvf00B22TjnixEx/e8q+ORBKwtr7Jwa4dA5kvJ5y6c7rdigbL0dTquLHq0+GnkCfLzx2+r3b7GHF68bPeXvUE/ne3PJsBqCfeDiPbZuXEMXVjbYvOR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy2zmBFY9k2CWHopSktNDw03KUCfjBokgULjr5WIWg8=;
 b=MGzXc8O6V0iL+/DOHKRZGvrLYuhdsz6ASbPa/Tfdkqy9SBsl3qpQ9L35kFfANm8QRewdjIUOSip0Hhj46YpeJBjRojR5SBsbIWb+6cAd3aYzLSreKE6Q66gJtviaf4WAF9w1BXjTPjXyXG8o6sqT8R32WXIYAYN/yjoop8yZpiPGBWgM7cX33dEAPn/Ie5o0X5mh+0lNZ1K6RwplKOkRTyE0rj7m7rlGk0ydfnv1zCUOmHBfIRbRyQrLcAkpaJfBR2YrFMzKTUyN7VjDcos9gvkiXtzCfnGWjOvchUNbb2evr9tvVrS0B3cGrRlFhCEvMSbjw2wZXHJOxr5k2u6b7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy2zmBFY9k2CWHopSktNDw03KUCfjBokgULjr5WIWg8=;
 b=Wf7RIapiaR39rgYMa9e+fjvzsLkaZ+9MZ1v1bHAjEr/b0Pn5c9tiKlLHuC05XikgYN5HOG5JcUx+ftWqIVe4umXryVpCiXcFohoUs5nxT+2tuDTUKPTZlA0X2bSfNy8NUGAioQKOfPI9/wP2Q1mYW450eZdZrNyUApF86/cqGGnkBI4OariMTDzmwqOUneP154Xshl7iU2LcOAnGdE65o5/PNXlplxbRPUWNOyYUAF3Vp6lyc4E/BBJuFpe4pj8IdoUZ9VpKUKmq0dmJpvNYRGnYS2+lX/jQE8gr/2gpQHGHybHLC2lOXNUBKNHJpR7CTl3aK9A4SfRJQu8xkH3rqQ==
Received: from BYAPR07CA0003.namprd07.prod.outlook.com (2603:10b6:a02:bc::16)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sun, 9 Feb
 2025 10:20:02 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::1b) by BYAPR07CA0003.outlook.office365.com
 (2603:10b6:a02:bc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Sun,
 9 Feb 2025 10:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:20:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:20:01 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:20:00 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:19:55 -0800
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
	<bpf@vger.kernel.org>, Amir Tzin <amirtz@nvidia.com>, Aya Levin
	<ayal@nvidia.com>
Subject: [PATCH net-next 13/15] net/mlx5e: Expose RSS via devlink rx reporter diagnose
Date: Sun, 9 Feb 2025 12:17:14 +0200
Message-ID: <20250209101716.112774-14-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 752b8a40-533f-472a-9717-08dd48f35091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fBAW+SEFNeumi1B8C4P4POwP83xWgJg2cI2NQYQfZyYCGbfZPSewCEwGLqIj?=
 =?us-ascii?Q?eYAbm0WFr9XoqugfMm6bCD1bMiqOhPX2BqSbe8WC07udvlwHiKZuVfrp0K/+?=
 =?us-ascii?Q?FCabq3s5FFBht8UL1BR131ftXzybjWVEQZRWUR4EaGVFl0tmmMKtaVDHfpuD?=
 =?us-ascii?Q?enAzzpCqR/w3VWuNq7yAcyXjGg/XKqu0vC03l0o1UuEtaVv7ucFItqF6wiWb?=
 =?us-ascii?Q?XGeaCe42DHSE1Ga3HA4dTcZdkvr6IfdvEbGG1NcCOPFW18CzyXOGC30CxMJV?=
 =?us-ascii?Q?Nz/LAGvuA0OtjmOEgOTOojtKRh48PkrhgQGF6bDOm8ZkGyH5qMEbu+9eZGsF?=
 =?us-ascii?Q?zR2aRLLYOdWW1q5UUAhMGTYqP1B7R2j3DjVCCIdDt7Qb6pQcQgrwqNt51QOW?=
 =?us-ascii?Q?bs2ZmJ4gGcm3Iq2IjIfjbYfxjejU5hsQTD88Zu6U7NXz45cvUGCxn+6pY/6I?=
 =?us-ascii?Q?G8XYIwgAdTWxh0P6pH7BXTgvudTPGrqxjv6WUzQOje0zVZZWOfvP8m7uWFa0?=
 =?us-ascii?Q?/3mTDQi+yfLGCvgj2buc1k9k3SRcG6L6xVSDNbvA818SeeUEIn1WlDj7M4pf?=
 =?us-ascii?Q?c/1JNPOd7ybdPc7f01vxYhqw2LoWBJNoSsozpbXizuhWxq0CPFb+uV4u4uvx?=
 =?us-ascii?Q?XZ9/5+xGcsjYuALvvv+6vKjanOSDrfUOQr4AlWVeNG9uqCVgzvI4QIIC8/cY?=
 =?us-ascii?Q?YCbNOyTrY8LTzsqUQPjL6iuoSELggc32uDGW1NjHaMgGcSFXABnuNyGqCgNO?=
 =?us-ascii?Q?x/umkQqoXAsyEsEC68BcHx1arIVlXSLOdNQYszOMsCsdypiWDxQ7bO3B6WEl?=
 =?us-ascii?Q?f8VkPPpoIH6qIKGEGYydjO9slm3dRu+qRPAOtwAF4Vp9EVWzMof3/mH7wiJP?=
 =?us-ascii?Q?wtFwxOJArGkINDQEebgkdZ+zuXQ5z7CZNZESJ8Uhi/LT9HWW70sge/jh/XY6?=
 =?us-ascii?Q?pD/v69S9t9dKrAiuy2P90NoWbXi8quMy5PqEboBiNwbXjtf6752gR/+lAjsd?=
 =?us-ascii?Q?WYkh83CdgJcOO9+D/dKWFRpMS3PyOPPojV4EOYuU1ONCZe79wlS9z59s9kR/?=
 =?us-ascii?Q?GYau2rhFXMNQZT7dtLRuWIT2P4IAxb5zqaTHb8zAd3v3zN7hEtjW2N58BcJD?=
 =?us-ascii?Q?h+1U4c37MB/LeQ5orW2wT2VAkEQQ3A9TgVqCHGwA5eDM9wLM9xhwnWjQ93CX?=
 =?us-ascii?Q?FAgnL/mFbaQmudre1s5BExqEyL8HC+oOZ2TS7kE3wQPMtBMV7u5s+fO3kqAC?=
 =?us-ascii?Q?d/s1bzf0IUXYqKTakpl60T9b+Bc4G6ZIzLUINZOywy8JvG2XrpaMKIDAbmX1?=
 =?us-ascii?Q?yQcq+lg5zeiyR8+ubemSI9s2VpFCqojo9AHkGEDz8NpUWOzmYWsRLhtp+KfM?=
 =?us-ascii?Q?HZtHSzZvgwrbOS8URNHxlWTVgiDWhQVCJmup9cF2DI1AZdBj1sxPi9iGSIQC?=
 =?us-ascii?Q?GTGtP729FxPxWng6GBhDqESiXhw4dHhAmQ8zjfftugVjovvzTCXKFiosKW4u?=
 =?us-ascii?Q?20thsiRfiMJ0SzM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:20:02.2293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 752b8a40-533f-472a-9717-08dd48f35091
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989

From: Amir Tzin <amirtz@nvidia.com>

Underneath "rx resources" tag expose RSS diagnostic information. For
each RSS expose its rqtn, TIRs and inner TIRs.

$ devlink health diagnose auxiliary/mlx5_core.eth.0/65535 reporter rx
 .......
RSS:
    Index: 0 rqtn: 0
    TIRs Numbers:
        tt: TT_IPV4_TCP tirn: 0
        tt: TT_IPV6_TCP tirn: 1
        tt: TT_IPV4_UDP tirn: 2
        tt: TT_IPV6_UDP tirn: 3
        tt: TT_IPV4_IPSEC_AH tirn: 4
        tt: TT_IPV6_IPSEC_AH tirn: 5
        tt: TT_IPV4_IPSEC_ESP tirn: 6
        tt: TT_IPV6_IPSEC_ESP tirn: 7
        tt: TT_IPV4 tirn: 8
        tt: TT_IPV6 tirn: 9
    Inner TIRs Numbers:
        tt: TT_IPV4_TCP tirn: 10
        tt: TT_IPV6_TCP tirn: 11
        tt: TT_IPV4_UDP tirn: 12
        tt: TT_IPV6_UDP tirn: 13
        tt: TT_IPV4_IPSEC_AH tirn: 14
        tt: TT_IPV6_IPSEC_AH tirn: 15
        tt: TT_IPV4_IPSEC_ESP tirn: 16
        tt: TT_IPV6_IPSEC_ESP tirn: 17
        tt: TT_IPV4 tirn: 18
        tt: TT_IPV6 tirn: 19
    Index: 2 rqtn: 27
    TIRs Numbers:
        tt: TT_IPV6_TCP tirn: 46

Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en/reporter_rx.c       | 58 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  | 15 +++++
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |  3 +
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  2 -
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  3 +
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.c  | 19 ++++++
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.h  |  1 +
 7 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index bb513a22dc66..e75759533ae0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -359,6 +359,63 @@ static void mlx5e_rx_reporter_diagnose_rx_res_dir_tirns(struct mlx5e_rx_res *rx_
 	devlink_fmsg_arr_pair_nest_end(fmsg);
 }
 
+static void mlx5e_rx_reporter_diagnose_rx_res_rss_tirn(struct mlx5e_rss *rss, bool inner,
+						       struct devlink_fmsg *fmsg)
+{
+	bool found_valid_tir = false;
+	int tt;
+
+	for (tt = 0; tt < MLX5E_NUM_INDIR_TIRS; tt++) {
+		if (!mlx5e_rss_valid_tir(rss, tt, inner))
+			continue;
+
+		if (!found_valid_tir) {
+			char *tir_msg = inner ? "Inner TIRs Numbers" : "TIRs Numbers";
+
+			found_valid_tir = true;
+			devlink_fmsg_arr_pair_nest_start(fmsg, tir_msg);
+		}
+
+		devlink_fmsg_obj_nest_start(fmsg);
+		devlink_fmsg_string_pair_put(fmsg, "tt", mlx5_ttc_get_name(tt));
+		devlink_fmsg_u32_pair_put(fmsg, "tirn", mlx5e_rss_get_tirn(rss, tt, inner));
+		devlink_fmsg_obj_nest_end(fmsg);
+	}
+
+	if (found_valid_tir)
+		devlink_fmsg_arr_pair_nest_end(fmsg);
+}
+
+static void mlx5e_rx_reporter_diagnose_rx_res_rss_ix(struct mlx5e_rx_res *rx_res, u32 rss_idx,
+						     struct devlink_fmsg *fmsg)
+{
+	struct mlx5e_rss *rss = mlx5e_rx_res_rss_get(rx_res, rss_idx);
+
+	if (!rss)
+		return;
+
+	devlink_fmsg_obj_nest_start(fmsg);
+
+	devlink_fmsg_u32_pair_put(fmsg, "Index", rss_idx);
+	devlink_fmsg_u32_pair_put(fmsg, "rqtn", mlx5e_rss_get_rqtn(rss));
+	mlx5e_rx_reporter_diagnose_rx_res_rss_tirn(rss, false, fmsg);
+	if (mlx5e_rss_get_inner_ft_support(rss))
+		mlx5e_rx_reporter_diagnose_rx_res_rss_tirn(rss, true, fmsg);
+
+	devlink_fmsg_obj_nest_end(fmsg);
+}
+
+static void mlx5e_rx_reporter_diagnose_rx_res_rss(struct mlx5e_rx_res *rx_res,
+						  struct devlink_fmsg *fmsg)
+{
+	int rss_ix;
+
+	devlink_fmsg_arr_pair_nest_start(fmsg, "RSS");
+	for (rss_ix = 0; rss_ix < MLX5E_MAX_NUM_RSS; rss_ix++)
+		mlx5e_rx_reporter_diagnose_rx_res_rss_ix(rx_res, rss_ix, fmsg);
+	devlink_fmsg_arr_pair_nest_end(fmsg);
+}
+
 static void mlx5e_rx_reporter_diagnose_rx_res(struct mlx5e_priv *priv,
 					      struct devlink_fmsg *fmsg)
 {
@@ -366,6 +423,7 @@ static void mlx5e_rx_reporter_diagnose_rx_res(struct mlx5e_priv *priv,
 
 	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "RX resources");
 	mlx5e_rx_reporter_diagnose_rx_res_dir_tirns(rx_res, fmsg);
+	mlx5e_rx_reporter_diagnose_rx_res_rss(rx_res, fmsg);
 	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index 5f742f896600..0d8ccc7b6c11 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -81,6 +81,11 @@ struct mlx5e_rss {
 	refcount_t refcnt;
 };
 
+bool mlx5e_rss_get_inner_ft_support(struct mlx5e_rss *rss)
+{
+	return rss->inner_ft_support;
+}
+
 void mlx5e_rss_params_indir_modify_actual_size(struct mlx5e_rss *rss, u32 num_channels)
 {
 	rss->indir.actual_table_size = mlx5e_rqt_size(rss->mdev, num_channels);
@@ -449,6 +454,16 @@ u32 mlx5e_rss_get_tirn(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
 	return mlx5e_tir_get_tirn(tir);
 }
 
+u32 mlx5e_rss_get_rqtn(struct mlx5e_rss *rss)
+{
+	return mlx5e_rqt_get_rqtn(&rss->rqt);
+}
+
+bool mlx5e_rss_valid_tir(struct mlx5e_rss *rss, enum mlx5_traffic_types tt, bool inner)
+{
+	return !!rss_get_tir(rss, tt, inner);
+}
+
 /* Fill the "tirn" output parameter.
  * Create the requested TIR if it's its first usage.
  */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index d0df98963c8d..72089f5f473c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -32,8 +32,11 @@ void mlx5e_rss_refcnt_inc(struct mlx5e_rss *rss);
 void mlx5e_rss_refcnt_dec(struct mlx5e_rss *rss);
 unsigned int mlx5e_rss_refcnt_read(struct mlx5e_rss *rss);
 
+bool mlx5e_rss_get_inner_ft_support(struct mlx5e_rss *rss);
 u32 mlx5e_rss_get_tirn(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
 		       bool inner);
+bool mlx5e_rss_valid_tir(struct mlx5e_rss *rss, enum mlx5_traffic_types tt, bool inner);
+u32 mlx5e_rss_get_rqtn(struct mlx5e_rss *rss);
 int mlx5e_rss_obtain_tirn(struct mlx5e_rss *rss,
 			  enum mlx5_traffic_types tt,
 			  const struct mlx5e_packet_merge_param *init_pkt_merge_param,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index 4e301bb5e305..9d8b2f5f6c96 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -5,8 +5,6 @@
 #include "channels.h"
 #include "params.h"
 
-#define MLX5E_MAX_NUM_RSS 16
-
 struct mlx5e_rx_res {
 	struct mlx5_core_dev *mdev; /* primary */
 	enum mlx5e_rx_res_features features;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 391671b09c91..05b438043bcb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -10,6 +10,8 @@
 #include "fs.h"
 #include "rss.h"
 
+#define MLX5E_MAX_NUM_RSS 16
+
 struct mlx5e_rx_res;
 
 struct mlx5e_channels;
@@ -36,6 +38,7 @@ u32 mlx5e_rx_res_get_tirn_rss_inner(struct mlx5e_rx_res *res, enum mlx5_traffic_
 u32 mlx5e_rx_res_get_tirn_ptp(struct mlx5e_rx_res *res);
 u32 mlx5e_rx_res_get_rqtn_direct(struct mlx5e_rx_res *res, unsigned int ix);
 unsigned int mlx5e_rx_res_get_max_nch(struct mlx5e_rx_res *res);
+bool mlx5_rx_res_rss_inner_ft_support(struct mlx5e_rx_res *res);
 
 /* Activate/deactivate API */
 void mlx5e_rx_res_channels_activate(struct mlx5e_rx_res *res, struct mlx5e_channels *chs);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index 9f13cea16446..eb3bd9c7f66e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -61,6 +61,25 @@ static void mlx5_cleanup_ttc_rules(struct mlx5_ttc_table *ttc)
 	}
 }
 
+static const char *mlx5_traffic_types_names[MLX5_NUM_TT] = {
+	[MLX5_TT_IPV4_TCP] =  "TT_IPV4_TCP",
+	[MLX5_TT_IPV6_TCP] =  "TT_IPV6_TCP",
+	[MLX5_TT_IPV4_UDP] =  "TT_IPV4_UDP",
+	[MLX5_TT_IPV6_UDP] =  "TT_IPV6_UDP",
+	[MLX5_TT_IPV4_IPSEC_AH] = "TT_IPV4_IPSEC_AH",
+	[MLX5_TT_IPV6_IPSEC_AH] = "TT_IPV6_IPSEC_AH",
+	[MLX5_TT_IPV4_IPSEC_ESP] = "TT_IPV4_IPSEC_ESP",
+	[MLX5_TT_IPV6_IPSEC_ESP] = "TT_IPV6_IPSEC_ESP",
+	[MLX5_TT_IPV4] = "TT_IPV4",
+	[MLX5_TT_IPV6] = "TT_IPV6",
+	[MLX5_TT_ANY] = "TT_ANY"
+};
+
+const char *mlx5_ttc_get_name(enum mlx5_traffic_types tt)
+{
+	return mlx5_traffic_types_names[tt];
+}
+
 struct mlx5_etype_proto {
 	u16 etype;
 	u8 proto;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
index 92eea6bea310..ab9434fe3ae6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
@@ -49,6 +49,7 @@ struct ttc_params {
 	struct mlx5_flow_destination tunnel_dests[MLX5_NUM_TUNNEL_TT];
 };
 
+const char *mlx5_ttc_get_name(enum mlx5_traffic_types tt);
 struct mlx5_flow_table *mlx5_get_ttc_flow_table(struct mlx5_ttc_table *ttc);
 
 struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
-- 
2.45.0


