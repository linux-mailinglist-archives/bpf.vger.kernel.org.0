Return-Path: <bpf+bounces-72986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A9BC1F8C3
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19320420515
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA87351FB9;
	Thu, 30 Oct 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/L8PaR5"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013052.outbound.protection.outlook.com [40.93.196.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC76C346E7E;
	Thu, 30 Oct 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819971; cv=fail; b=iFnVBwFCmWQH9HOfQqqd34tv6/OzyBfqOyeaPuuQzXV3mEObXONtGuSj1c6qB4IiPk8Ew0Dl8VShkAdGmwGqbjDLALQvoVeRSREc2F5Jt8YjUoyrmd5xCR2YYnMgcJGAqGgGAdscLuzL6C0Zxix1DAbJLNVp2PiWVozFdtQQwX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819971; c=relaxed/simple;
	bh=4Msg23iSF5WaNsoAUGWahLz3ldM6h/WhBlLPDxSylRI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vAzT/a8F+qk2dp32PRvsPRm0VYODoKWwBQxr09f8jOpM0ZovXY+b0ZMOPVCLnEhOEkr9kgWY0ZzoB2Sm10IJExrZQUpYRPwVFNFO2v0NbWUONUmEs2WQaLPoaN8LTCR3X71vOXbc2jOsU2QCo4JueKLlPLjNY9Sw+2Q+fSAuUMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/L8PaR5; arc=fail smtp.client-ip=40.93.196.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+KwzRlV5WzH5Yo8E3HzkxAnQ15ZirUR+Vxz/6/esxClyBQS8M4huswYHhyKBPwSkRd93oJUmjGykQPnjXYDHFZqrAD03jQTMw58PQ38Xwk3UEYla5m+unXCIaDzq2QZDX22aGZ2Mo8wgP0mtxH34L4JwniE/OPlKe/nF2iU0uGdouF1z2+aCX3+e/JDdlco/w6VhlUE7d2KLDJzBSDUxddT/+PjBqCB5pT8clOKjNo2CENiC+rpLHPvqYXzaq9++xuvLSOIFRvFDbZ4RLAgzogvAuP8TnvDmk/tWJ7Sx5NEjOWibbGmrLg5l3nu2WpRalqiLng8lyusZQZDRGrAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSXwpPG871gQw9v/lBu7H31gN3Zbax3yISN2Wd13o20=;
 b=H1p5psjqTOyV0DbyIjtYdv+fsNRzzDCb7IbOuu4yMfr3O7CJ6/bWxk87ZPE7DaVzqk5B7UKXJwyBHT4OobukLvgy3YXKU0GtpJuU1CD1KVSkJa7ymZ611EAvdTGV9rGsW+CsOkqgOjsl8nydrKxfwxlGSFBt8Wtd3pW19dBHnMa7GAZ1nueAair6M96NfpHeBQCYiYytXHNoKIKLI5LOmkb7SvSDrpxEpn/dX5Mbr34qDFvLywsdNuB7iVV441TS8kb7Om+RId/vpyOdQczj7OSZ/6hmFfOvm6JWfApeZ0nYWTQLrLO9z/Y8nkYkCx4Jx7oXYq/v81YHtqX8e+5s/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSXwpPG871gQw9v/lBu7H31gN3Zbax3yISN2Wd13o20=;
 b=t/L8PaR5SGR6ggD2RUvpG75R5GMwhLY7FDExAqhd8ybFmtVTNVAYg/FvQACug8Muq9vwWXAeMwxO6XksQhlq0bNU/E8lb04LbavzWr4RqZ1/1P2a11S9eggZQ3Ki2hYak9ZBmWA4rwHZ6Gxg/62+KZeWEQe3GzBgKMtS2xEulN7e3InxvpcmrGe5pvU1SVfUOHYGaimopowqcE0yZhdi71xNn5sIGiTASpcJOI8552XH59uyJmUdJ2w7UjeLB2+FxbYpJVncCgs7rThrMZigGoJ2dZd+q1k8u810r+vA38xpYFWFXNnrg5dEW8ouXt+d5lXHo0841ORariimX6YRRQ==
Received: from BL0PR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:91::18)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 10:26:05 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::2e) by BL0PR05CA0008.outlook.office365.com
 (2603:10b6:208:91::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Thu,
 30 Oct 2025 10:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 10:26:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:25:47 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:25:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 03:25:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 0/6] Convert mlx5e and IPoIB to ndo_hwtstamp_get/set
Date: Thu, 30 Oct 2025 12:25:04 +0200
Message-ID: <1761819910-1011051-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8a9de9-0536-4fe8-a7e9-08de179ebb17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t6W6V3a+LKLMoHmM+pCniGVprVmOgP4bBMhbfrj0vo2py+Z0QFyZkUfkAfaG?=
 =?us-ascii?Q?NfcQz5Cr+Z2yazvBSL0FXhz0HyqckkoHPF5l7UKaH1nH7qmZx7XmjI5HtStP?=
 =?us-ascii?Q?BVAVer9bRoaOXY4dgsDP+w+MgG/oavGkFmZAZKOYhHkWErlWFCzJ/ool9JzP?=
 =?us-ascii?Q?QnO/EFnnVVp2/tbJWpaXHkAClB1Jut2xChHgSV1d9Fs0x7NwIWiFWW4kcIVR?=
 =?us-ascii?Q?hZ3sY/ngbZKLOn6XXpklAtRJ7Tlj0DbGr7H05DXIe0fLgxOFMv5DAayd2QpI?=
 =?us-ascii?Q?IVUVmhPNth0bzXFAB91fCxWyBqRTzPeX+bp12S20BKAKaEcxoTfaGNiVHKSH?=
 =?us-ascii?Q?OS5KZyujhpSRlvAQEwovA1+aeM4zEaYV3ZaQnqT0t3b2Vm9ciMv0URk1BsR8?=
 =?us-ascii?Q?9pU0HjZPkXYZzWO4DxwY4KhlPsR8Xar/j4899uHoRzzi2bkA4b5sTzKvNbJ/?=
 =?us-ascii?Q?D0H5gQR4tSdEWx1v4+Ht3J7Lg3rT9w5cDX6KxdaxQJM5S9emeVdHaJ3HKmmG?=
 =?us-ascii?Q?wknaCg30bDTYqCJlwO2S+CUj3+IHExQ5re4g5ZJabz9mMBmGeuHXAVczTnQH?=
 =?us-ascii?Q?XV6rNLTYilRBoCGeTCTAEZB/i9vm5B4Sfy7tTFN9I3I3bFieXNGLXAJ/QczG?=
 =?us-ascii?Q?yc5pE4iqjpKPeeroinol7adCTkNP6DR/gW15XtBnDrvTqF0Z9i/4pwP65XGC?=
 =?us-ascii?Q?g9sBqAkOPTpdX1wzkABJk3sCvxsM7oMoApLzM5Xl3AD3FS8LLxQyi9QTqGtP?=
 =?us-ascii?Q?ZW+5Ny90ZctpFjSarx+BuWyHMyDOT6IKmPbgohq5CdfDDWYaYKOcgM8q8VQk?=
 =?us-ascii?Q?69oOBomPeBHO6BDimx8x3Es3I4OxgLeYVRA+EZZjggoMnP3Llhh3Vs0jcHye?=
 =?us-ascii?Q?YeoW33GbKemSKJVSmhf6tzcybyCqVeG7TTg16xXx5lr+8qPgpHa/OrGXq3ox?=
 =?us-ascii?Q?Do7w+knj4Mz/rH7uUL70/KUIkZsT5fDLCObTxSD3hGjziTmWAquQ2hrRmfMr?=
 =?us-ascii?Q?5kBfGRCAy+WR5ggsK+hx1UcprZAhD4yMTtEvWyvkHjAcAwRdHskroBg/Zo6w?=
 =?us-ascii?Q?CMA5tBlSwZWZ3DKZy+sS2o8SgWHfWQ0mkR6revqf/B/ilSbIIPOFUihKh25V?=
 =?us-ascii?Q?tHi/63BAfr+VX7inwb4tHSH7RKwEFOxifU1CIr9TIgMvMfjE3Q3crXTgyj2L?=
 =?us-ascii?Q?+yE2KFTY0vpMQ0dq9QBAiGUFM0UdZ87A0X+RFe8pANf1pePycRSTcjOtablv?=
 =?us-ascii?Q?w2Guxim3ylM5xH7Mq1oVxuJrsA6GFVK1gcAcui06KDKV5NFOqd6h5e143EZh?=
 =?us-ascii?Q?HdhQnceC35T5OD91pE5EKi+CJK9moUWUwRdKG1scd7Vl8A4auNnnL9PVGSCs?=
 =?us-ascii?Q?xdQ9X8gVQbwncMy1V/BcCjUf8JErzLA7uE38Q2/VEOEvZVvrZ7CvvtQyFcgf?=
 =?us-ascii?Q?1gDFzv9H0nHAOQJBM8BDH+hLtEXwL1s0sSA7bMSpi+8KqQwn8TiKD5P7UDZW?=
 =?us-ascii?Q?xUSvwb8jjlCfBTLt0FFDIrMWIpTq+ppRKvJ1Usp2CAuIwfrxEvD1BlCgfqkU?=
 =?us-ascii?Q?CfYT1ajh72bezsBEhtc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:26:04.2462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8a9de9-0536-4fe8-a7e9-08de179ebb17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964

Hi,

This series by Carolina migrates mlx5e and IPoIB to the
ndo_hwtstamp_get/set interface and removes legacy hardware timestamp
ioctl handling.  While doing so, it also cleans up naming and removes
redundant code.

No functional change in timestamp behavior.

Cleanup patches:
- net/mlx5e: Remove redundant tstamp pointer from channel structures
- net/mlx5e: Remove unnecessary tstamp local variable in mlx5i_complete_rx_cqe
- net/mlx5e: Rename hwstamp functions to hwtstamp
- net/mlx5e: Rename timestamp fields to hwtstamp_config

Add suppport in ipoib:
- IB/IPoIB: Add support for hwtstamp get/set ndos

Convert mlx5:
- net/mlx5e: Convert to new hwtstamp_get/set interface

Regards,
Tariq


Carolina Jubran (6):
  net/mlx5e: Remove redundant tstamp pointer from channel structures
  net/mlx5e: Remove unnecessary tstamp local variable in
    mlx5i_complete_rx_cqe
  net/mlx5e: Rename hwstamp functions to hwtstamp
  net/mlx5e: Rename timestamp fields to hwtstamp_config
  IB/IPoIB: Add support for hwtstamp get/set ndos
  net/mlx5e: Convert to new hwtstamp_get/set interface

 drivers/infiniband/ulp/ipoib/ipoib_main.c     | 29 ++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 12 ++--
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en/ptp.h  |  1 -
 .../mellanox/mlx5/core/en/reporter_rx.c       |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en/trap.c |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en/trap.h |  1 -
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 .../mellanox/mlx5/core/en/xsk/setup.c         |  2 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 66 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  6 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c | 34 +++++-----
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.h |  6 +-
 .../mellanox/mlx5/core/ipoib/ipoib_vlan.c     |  9 +--
 .../ethernet/mellanox/mlx5/core/lib/clock.h   |  1 -
 17 files changed, 107 insertions(+), 75 deletions(-)


base-commit: 1bae0fd90077875b6c9c853245189032cbf019f7
-- 
2.31.1


