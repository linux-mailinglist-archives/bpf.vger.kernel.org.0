Return-Path: <bpf+bounces-50892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93407A2DC35
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9133A631E
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9981F1BC065;
	Sun,  9 Feb 2025 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IZkKoX1/"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754F11B87C1;
	Sun,  9 Feb 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096381; cv=fail; b=LdaAxcAXI5Sz8ye0YMTcexcNJbvQ3Y0PtkL08Wtu1b1wUSa3R6EGUH0j4m1n8djakn/3TZCQr1ol6wAt52cktbQYuz3gOYxbN+ql6lm603Tn3BDnJIcvwxQyvHDgcfzuxdPqmskwOSObot2S7VdIcFJWLi4MpkfMC3yZLVCnjT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096381; c=relaxed/simple;
	bh=8kO8XKdGEPVGNLSGBDtaJ1JX3DyeuEY8RzmTVmaeNe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbwPPEdkmYH9Do+YNhJG4zIj3xsY8ktYRgt8N+sjgXUSIRu+wh9Czvw1LdUztD/xDb8jaBWiWZ9Pog6RQW4Fnpa07eQxlCNCvbd2m3FKdZuPZ/HDZkQZ3Bmbz/efVboP3uD6CHa53BjcQ6znQOg3Z7HsULG6GUM/Tj1GIAd6td8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IZkKoX1/; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEOu5C9cXFcWLh1j8AAGKG/zBnIdpAy1RFzdMYg03rX83EfSGp1BOUfq+Ij88P4zjsuxwwx+XFm6pN6ES2HJbdy7bhqqcnfkH0+xff5/Q/cd9MAvXCfs6ZUTzGOkf1Z1fMOEP+lSZGog50cGWN4851jyV78GuwSVUwlDuUJ+hVVQpAIBMbY40SXP2C3uFQe/r3RGSiNHN+NErk7AqVErER/EaPkAatbOiFRp8SMTd1wAt7cDFT/GJ25q4DDzVexDE/oI48YgSlzcxa5k31YFrCo8U8B9GkiPoy0uLig+BDrp+QrwLJbhe5lm4WMmk6dBnj7O9z0c9Y41Sj4ztdGjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqJa+brBEhU/iw3G1XWFwtfeZAGcMWfr9DBmC7PFrgE=;
 b=rPnV9HtGkKPp07ZX2ugttLJn5Mw2DUFdbyBywWo8frpchMjPpmnMthR9sGvPvhTcRyXN0TB+lDFmjJjueHcpFTwI1Pg0EFVRaynfv24CudeMS3/HQxLqVEjCVubgN2bHRsYA8yr7mtmTQa9ZwplJ8j50nfCbpWjFs4xsbjCJiWkpGQFK/AEgdOXQ7hLGxsQYiLzYcrN798r7IHHHR4qfd/EzpWHQhLmVFIpIOxSPwdN92uoalcVDslBJNodnA9yc7RrpLB85fRjck2sGtEOKT7O+KkQPw+MGzexoXEA94mGV8BSmHgt2FkSPsw7h2Dt1K11UVK8SL3cklPr/6T3HLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqJa+brBEhU/iw3G1XWFwtfeZAGcMWfr9DBmC7PFrgE=;
 b=IZkKoX1/9126JXITQzqRYCoYtdrfyHNJWkshPBDEQfZ/7Tua/LCLouvNDBVfIm6yr0E4miOUPqlnwxsEIfFqArQqdU+ZXIYKnDc0Z+4WyugX7bGVHmsa6Rd2vAs8QXF2+3yD2ors35XQeI4OJnBnV+NXaYMJ5rhV+aYpeTsDfCUj/4M4pydEz/0YVDY64TS1uXDcEj9SNA6USHVxga4pSyH/UoXiC7cpOvJaErUxHVig9GQu/b9fUTaBWZfExLyVl21B+ooh2u0T2WZECETGv+1rQ8cX/U5SyBqnNb4EbJe1Fi8ThewKyOm3Bx8rxC3Y1/oPHf4QV6P5GO+16eVwzA==
Received: from BYAPR07CA0011.namprd07.prod.outlook.com (2603:10b6:a02:bc::24)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Sun, 9 Feb 2025 10:19:33 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::92) by BYAPR07CA0011.outlook.office365.com
 (2603:10b6:a02:bc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Sun,
 9 Feb 2025 10:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:19:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:19:32 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:19:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:19:26 -0800
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
	<bpf@vger.kernel.org>, William Tu <witu@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next 08/15] net/mlx5e: set the tx_queue_len for pfifo_fast
Date: Sun, 9 Feb 2025 12:17:09 +0200
Message-ID: <20250209101716.112774-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: d8fafaef-bb76-43e3-8f55-08dd48f33f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1PqG/FzE6j9X5ynWrw1cJmSVtTHLhP/FYhZ8I32OvfkV93c+sZK9wY1jx3nj?=
 =?us-ascii?Q?RDNAhy03DNtgDP8F47eAE7h8Mx1yqQWKAq1Al8Xs+XpjGxJYpQUyOUke/+Ta?=
 =?us-ascii?Q?yXNYej5SnOAI+H5YluNpshsEJAC8ZGxpJeRxxYYIxBN/2Q2usfBJMsXBwglI?=
 =?us-ascii?Q?kUdHDQ0BqfCOrauDyvHRfTdbpgmdp6oNIuWcPMqytqtyLbN4EZvDqRsZGSUR?=
 =?us-ascii?Q?wJ0S730WKPlcVXcHX7+0ZM9Ou7xHsKrbF48WPstyPtqMkA6rAifPdxTl1dG/?=
 =?us-ascii?Q?iTUgqhscsrcgoo955oKp+JeznRpMQs7Ua+wq5/BPvzG2QRBKGSpbcq6A305I?=
 =?us-ascii?Q?spV87q+pVe44NGELKcC/MUS05ZfDnSfiLojEb+uup1cWDeXzWZn/eVoOYaRY?=
 =?us-ascii?Q?Ym5pKl3rn5HZ7QMdheZIqUt3eYp2PQlcEKdRDvx4sX7YJnTRgxWqBafkB8dj?=
 =?us-ascii?Q?V5vaDYSfzYtPeSPrtiyCYKn9mA32Z9GXPm/AqmOGDojsbDE6Ns+UoAi79E73?=
 =?us-ascii?Q?hZ1RpEaJvKT5JpWBG3JOW52O1G41h4diSuGdWiD4kFfcEi9h78nsZgi7wSa2?=
 =?us-ascii?Q?aSUjOl78YvBGRip+xNA5lquyOeCr7XScGbO4iksbygPPrMR4aK81VuA8fQIU?=
 =?us-ascii?Q?RFdexovomnW+GFSHOvxPEuQL50UZaIugHJwGFa8leax4Csg3jVPf1n5xqfHH?=
 =?us-ascii?Q?qC6n3AXwBh8ZT3Bv9O5ivsN8l1DQ/4ZYfBHLNAy34hSsRP3llPdcx7FgE/OV?=
 =?us-ascii?Q?vBlCUrxwoVsvllwFbtM+D8HaZ6zvbtZ2SOPvrQ3V20YcSzlkChWBhCdRSnKb?=
 =?us-ascii?Q?n8NmTaO0W14wD/wiv0tm7PBOUs7i0MKcZijt7ttTnzNfDReO3m+vWlYaRLGy?=
 =?us-ascii?Q?nygZUZsu+dx+DFAzpHGQXhqRQwtZfbr+PZe3WmAF50bOZZ/e4zPnqWcdJwKx?=
 =?us-ascii?Q?MkhJ7wjkuhL2xmP0SCcP8JXLPGqZ81MCNuvpqHps2At6xKXwGFDxjeBqJrt1?=
 =?us-ascii?Q?6cT5HZZNymBKKHXQ6ZiDdj/CmlSGfVcGm4XxUPyuxG5MQMzDcCOSZV+0hDjZ?=
 =?us-ascii?Q?ZdDDaJfcyq1RYzwm9bmpYqlsOA+J8GSuN6AZVEZIKxraS/9K8ZowU9hLuL2P?=
 =?us-ascii?Q?SAo9+3hdT5otrAHIH2hO26j9p/3qy1NxlUb+sJh0vAn4iU+iZTR/zUutjsIV?=
 =?us-ascii?Q?ckyYFz2hJv4Kh3YhjcO/EitSl62It6KIJtBJ/ys1A7mdumHd+KHhpT5dybP9?=
 =?us-ascii?Q?vEMtci53lMrEApsAq8JGKcE1I3M0wkqxodKy8rN+kA375o73pqXCTxqKWokB?=
 =?us-ascii?Q?CALZO4Ik0OhAJX1ouU8oICFwd4cl3m5huItwNNv44Zb6Lo+M6PW4qPOM8v9v?=
 =?us-ascii?Q?XWbZ+ZACB4mticeAyAw+rUA3FpDUMpqYvWgW+N7g1JVy7gMyQUkUiTXRXBtK?=
 =?us-ascii?Q?0uYJJreRrmxTCDynHw1cDLPh8WNN4CjfPe5Yat4gAZpvNtSurGV5hoDaSPg3?=
 =?us-ascii?Q?nUFSp0tC+nRvhqI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:19:32.8231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fafaef-bb76-43e3-8f55-08dd48f33f0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184

From: William Tu <witu@nvidia.com>

By default, the mq netdev creates a pfifo_fast qdisc. On a
system with 16 core, the pfifo_fast with 3 bands consumes
16 * 3 * 8 (size of pointer) * 1024 (default tx queue len)
= 393KB. The patch sets the tx qlen to representor default
value, 128 (1<<MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE), which
consumes 16 * 3 * 8 * 128 = 49KB, saving 344KB for each
representor at ECPF.

Signed-off-by: William Tu <witu@nvidia.com>
Reviewed-by: Daniel Jurgens <danielj@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index da399adc8854..07f38f472a27 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -889,6 +889,8 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev,
 	netdev->ethtool_ops = &mlx5e_rep_ethtool_ops;
 
 	netdev->watchdog_timeo    = 15 * HZ;
+	if (mlx5_core_is_ecpf(mdev))
+		netdev->tx_queue_len = 1 << MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE;
 
 #if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
 	netdev->hw_features    |= NETIF_F_HW_TC;
-- 
2.45.0


