Return-Path: <bpf+bounces-68514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7C7B5993D
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7183AA4FE
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB9D3469F8;
	Tue, 16 Sep 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RClJxAoa"
X-Original-To: bpf@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A63451BF;
	Tue, 16 Sep 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031996; cv=fail; b=Z+fae7IUzgx0h6FZ2CAwbctkzRjRgFahx359oPD+bL+KJSwzItdOgExEnaXjtSVPgsnCRZmP0suk1CW9Rj3MuFRWYCuLWUtDMQbbWxScKEb4HjcYGQ0Lpn564hNio0EIOjKW2iOy4u2bMqSNlb594tIo12YSgiKSpILgvZY7Uts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031996; c=relaxed/simple;
	bh=7lfJnaf1uzVEdcjWU+tgkFWedFsB+wFPo28b8l7M+kg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEnoi+PhrpIoZ++nUUJuliGR45g5YoMqhu/Km0mwUCg335+wGjn38hiL0/nzgKEdqXOzYojrR77w7zhsbrOus6ot44w3Ne+UO82ZbjoDxUH8eRAJda8HHViKaUmdhnLoDvU9sFqbC4j1rQzMnLN1vxhCmwpDHCh1HWggHps6w7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RClJxAoa; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnXfHeLU4voRjyOirY2XLSScWxT0iRIOEZBLX767YDrnUtGsSLS/gX+RS+RsAl6pYTFOfVMpgDFTnbNY4IeJisSindATw0Md8RmvWizn79CZJ2AC0skbwah1oFcitnXOZJs2N7nY8SguZS5DnZI8FMpJndlEvt93uT2eKCoMNGMswZtNsVB699wzWbH9r/KLnW7edugy0CTd1VjIiQn/Ss6EBtEnw4wtugacScV6US2ROsfcQKwyfNJRAJEL02H+VQ8xnqo/etdZHpmzi5m78DcwZL9R68OQgew3ramlUGOtoKNol3qLgfbQJCYrr5jWwWA5nUA0VbfJ8tp61ZWkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCyGNhOPsUGCPEwYuGGIUZsOM6G8cj/dX8iYsrHaDM8=;
 b=PRzLMgRlMrc/iNA6K2LmZLn6X1JV87snxQzombepm5a9BxjZ+AVPKDaDvwbpKwedJczUbnnGAR+IbJTC6p2s1PoErC1sFoozLykp0aVEdxrhR/WVWWEXADYu+l0HBgZdP+qJxm2Nyx0W17iC7f/+RBWBdRAtp7+JYYZ1muIHD382EElkwfzNXr4P5WBeAk4GnjpRU/MdKs9/FG9n2CQuvOUa5ZOY+4oNMc7BYoQpMfrFp/PRlTsmOh2lWuQc+kB0ODMAb46WVsg9O+gEYVhPXsnW43qLrZ35zQwNPPSd0xx9RmI3QE6hgWJWADcOxxHEO7fi5wmmbjKxGnGf4qvmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCyGNhOPsUGCPEwYuGGIUZsOM6G8cj/dX8iYsrHaDM8=;
 b=RClJxAoa037GXZbgobJfoSBof3S1jmvxPSIejLmBoTt7PY0FwkRl2oW1ZzqGecvpgf7alyXQVsCNwWHTmrIkI9TBQSsuRySWmaiA15cFssVp5WUWBd1wEoBR4FKwDF3/wYbR9zSIisJ19Lofh73+5nXA+7onezRU8CSU4mUHYTKNwnTDKakCq6P/CuJhWK9ILy8obJ+E8CcRvi6nctGzGCxu5D0Yeyss+oPau/PTZJhkWDmzIb84JblYvHbvPLMvf8C+1HR1ttCVTTWssOcT9ecQ9F/kB4hgNZKuI1z3p/yGLZPRmCRv15ILIb0fMdp/rc47PgrQiCjtcv9VHJzETQ==
Received: from SA1PR03CA0012.namprd03.prod.outlook.com (2603:10b6:806:2d3::15)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:13:10 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::4a) by SA1PR03CA0012.outlook.office365.com
 (2603:10b6:806:2d3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 14:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 14:13:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:54 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 16
 Sep 2025 07:12:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, "Leon
 Romanovsky" <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH net-next V2 07/10] net/mlx5e: Use multiple TX doorbells
Date: Tue, 16 Sep 2025 17:11:41 +0300
Message-ID: <1758031904-634231-8-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 0941d8e4-4ecd-4a84-02fe-08ddf52b2aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XLcQqZ5iZ1n7Z0DMGS83D1DDNMwIz740B2r88I431u+XUAfdWYhBcyMN8iJ+?=
 =?us-ascii?Q?J4EnCnPpcuBIXISg6cU3iyO0dC5RJcm0GCOv+yVNJzEbJPo64novsm/eSIN7?=
 =?us-ascii?Q?ssMpOJzzRC9P/Dszeo8vbMVuAJfGqLPLcdYTeKBZAvNxdp2l0+2xVWyrFFbh?=
 =?us-ascii?Q?C9khSLE3r8oM2c/bA4joMh426jR36gbe2sIAE6Wdsovip/0/clCNFMOY8c87?=
 =?us-ascii?Q?r4dfJHPON/qzWNPrbOgzHnMGuEmNQtgWuV2MeM0pLJxTWwS2Xsp3Qx4eDC36?=
 =?us-ascii?Q?dBv6kk4TdG6lRsw3dID4HSpBLjlijslYKwr+D4OU+BwzITgKSFf/goA3ftLR?=
 =?us-ascii?Q?5xqs+Krk7h0a5v9U4eU3YeLDPMM3pyArc/GRl0pAWroADidPyf/PPZ/kVcI4?=
 =?us-ascii?Q?syC5Aswv3jwRLls8mEUgCNYRHRqhmRudT8dRB21Z6QA9cG2KEgXVdKOUruvT?=
 =?us-ascii?Q?40kJVhOdT8FEokBze+xji8mpiuV9ne31YtqkE/ENnU4F+22ig3qr5b8C9tRe?=
 =?us-ascii?Q?lDdzfnSe6i62OUUPAI8mlvKqsmOHgNJZ23tkXZQVd2tLuMg8HV8MWutWT3Yw?=
 =?us-ascii?Q?wW/p3r/mSz8ghzhE+c+wCPMK+RUCmT95uAZRLbh1s2uRUHQ1JVQt1gkBmTdo?=
 =?us-ascii?Q?kfBe/n8XDbglRURESrL5TabBd5pGbwFmvj1ymHpy323Lr117403anG5+nc+m?=
 =?us-ascii?Q?fzwZ1phrNBOy9k6U0C/A4u+GPreQx2gp1NELRmbBVyY5Jex2vhpojXWm382D?=
 =?us-ascii?Q?4zjzZ/mbNuNP21iDUN+LqpG7jYdF/Qp2XBo2OcpgWQ5f5+IhBB2w8Mo4NPJ1?=
 =?us-ascii?Q?bFex48XsrC5twFKJjE3uEOF/LNVm798mhAm1jUJNQRF76suAb8QHu1LNRp1n?=
 =?us-ascii?Q?+a5uozXf7u6ft2ONxHuKTpjAQkGplHMI/2OX7LkSbTAnbEjR25Cbi+mlcGCw?=
 =?us-ascii?Q?PHNTmsfzOU5Sz0xpWpuKZNGqS7ivdeWxWpZqoUS+e0srJrKVoBIbMcC+pt1r?=
 =?us-ascii?Q?U4N4PRVZ3rRZe82q2eEeOxxjSEWij0Eg2KxqLG7YpJ7mZtPAN2zxI70pfKU3?=
 =?us-ascii?Q?DAic1/fRnxETC1+VnQeODis14OShoSLHwJc7+xYSoX6FVa3QZMii5D4ZY2KZ?=
 =?us-ascii?Q?o/7p6BCJye/uMPXVgc2AlxNExomQ2pOnr95eXBDBc/4cWPoa+iml8xWqqSpn?=
 =?us-ascii?Q?WJkwQkhTF7FHL+K5XLBkxTVMiRSAXVuHa/Unbh8TaRjgd3PY5R5r7kDEgpOS?=
 =?us-ascii?Q?rvlXKJYi3ibxx+Fk2GVzqOTu/1GbTbdZbSOfOjESXQazEhlGYoQN1YSs5mBM?=
 =?us-ascii?Q?hKtCkyQ9AGrMz8DkkJZ5yDRFFLjiXX8Xx1z8lsUAxMBXh6OrjsLWGi/7vvRV?=
 =?us-ascii?Q?Kbl5C9+nIFe+mbvdVOX13+26khv/M4jhY0HqoamEBJV6wp+uhuiss4eSjriL?=
 =?us-ascii?Q?XFn12XHQpAk1TgZJAKb8xGcHxZ5wXK4SWm1el1+C58IZUH1x5J5Yzo8pkhdf?=
 =?us-ascii?Q?lYWQbJ1/Dgp25j0hfoV9+l4yIqFMCXasBSL+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:13:10.2708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0941d8e4-4ecd-4a84-02fe-08ddf52b2aa2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

From: Cosmin Ratiu <cratiu@nvidia.com>

First, allocate more doorbells in mlx5e_create_mdev_resources:
- one doorbell remains 'global' and will be used by all non-channel
  associated SQs (e.g. ASO, HWS, PTP, ...).
- allocate additional 'num_doorbells' doorbells. This defaults to
  minimum between 8 and max number of channels.

mlx5e_channel_pick_doorbell() now spreads out channel SQs across
available doorbells.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_common.c   | 29 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 11 ++++++-
 include/linux/mlx5/driver.h                   |  4 +++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index e9e36358c39d..d13cebbc763a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -143,6 +143,7 @@ static int mlx5e_create_tises(struct mlx5_core_dev *mdev, u32 tisn[MLX5_MAX_PORT
 int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises)
 {
 	struct mlx5e_hw_objs *res = &mdev->mlx5e_res.hw_objs;
+	unsigned int num_doorbells, i;
 	int err;
 
 	err = mlx5_core_alloc_pd(mdev, &res->pdn);
@@ -163,11 +164,30 @@ int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises)
 		goto err_dealloc_transport_domain;
 	}
 
+	num_doorbells = min(MLX5_DEFAULT_NUM_DOORBELLS,
+			    mlx5e_get_max_num_channels(mdev));
+	res->bfregs = kcalloc(num_doorbells, sizeof(*res->bfregs), GFP_KERNEL);
+	if (!res->bfregs) {
+		err = -ENOMEM;
+		goto err_destroy_mkey;
+	}
+
+	for (i = 0; i < num_doorbells; i++) {
+		err = mlx5_alloc_bfreg(mdev, res->bfregs + i, false, false);
+		if (err) {
+			mlx5_core_warn(mdev,
+				       "could only allocate %d/%d doorbells, err %d.\n",
+				       i, num_doorbells, err);
+			break;
+		}
+	}
+	res->num_bfregs = i;
+
 	if (create_tises) {
 		err = mlx5e_create_tises(mdev, res->tisn);
 		if (err) {
 			mlx5_core_err(mdev, "alloc tises failed, %d\n", err);
-			goto err_destroy_mkey;
+			goto err_destroy_bfregs;
 		}
 		res->tisn_valid = true;
 	}
@@ -184,6 +204,10 @@ int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises)
 
 	return 0;
 
+err_destroy_bfregs:
+	for (i = 0; i < res->num_bfregs; i++)
+		mlx5_free_bfreg(mdev, res->bfregs + i);
+	kfree(res->bfregs);
 err_destroy_mkey:
 	mlx5_core_destroy_mkey(mdev, res->mkey);
 err_dealloc_transport_domain:
@@ -201,6 +225,9 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
 	mdev->mlx5e_res.dek_priv = NULL;
 	if (res->tisn_valid)
 		mlx5e_destroy_tises(mdev, res->tisn);
+	for (unsigned int i = 0; i < res->num_bfregs; i++)
+		mlx5_free_bfreg(mdev, res->bfregs + i);
+	kfree(res->bfregs);
 	mlx5_core_destroy_mkey(mdev, res->mkey);
 	mlx5_core_dealloc_transport_domain(mdev, res->td.tdn);
 	mlx5_core_dealloc_pd(mdev, res->pdn);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ef7598e048b2..4dee4c6d048d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2748,7 +2748,16 @@ void mlx5e_trigger_napi_sched(struct napi_struct *napi)
 
 static void mlx5e_channel_pick_doorbell(struct mlx5e_channel *c)
 {
-	c->bfreg = &c->mdev->priv.bfreg;
+	struct mlx5e_hw_objs *hw_objs = &c->mdev->mlx5e_res.hw_objs;
+
+	/* No dedicated Ethernet doorbells, use the global one. */
+	if (hw_objs->num_bfregs == 0) {
+		c->bfreg = &c->mdev->priv.bfreg;
+		return;
+	}
+
+	/* Round-robin between doorbells. */
+	c->bfreg = hw_objs->bfregs + c->vec_ix % hw_objs->num_bfregs;
 }
 
 static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 15c434fedff7..99b34e4809ae 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -658,6 +658,8 @@ struct mlx5e_resources {
 		u32                        pdn;
 		struct mlx5_td             td;
 		u32			   mkey;
+		struct mlx5_sq_bfreg      *bfregs;
+		unsigned int               num_bfregs;
 #define MLX5_MAX_NUM_TC 8
 		u32                        tisn[MLX5_MAX_PORTS][MLX5_MAX_NUM_TC];
 		bool			   tisn_valid;
@@ -801,6 +803,8 @@ struct mlx5_db {
 	int			index;
 };
 
+#define MLX5_DEFAULT_NUM_DOORBELLS 8
+
 enum {
 	MLX5_COMP_EQ_SIZE = 1024,
 };
-- 
2.31.1


