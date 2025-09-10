Return-Path: <bpf+bounces-68004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F3FB513F9
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D61483D11
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB3317712;
	Wed, 10 Sep 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IWxEkgGy"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211231770B;
	Wed, 10 Sep 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499984; cv=fail; b=hcPiP666mup0Mx30Jq4XX75ppvn6wF/bI3Xd3xsNcyKL4u1+u4g4cFo5GH9zKu2Sz1Iu978K/I3r4n2iv2nfRIqAbuHYVgcZzsF0Fnv1Sni/+R3QOsvUDV4qc1W628fvBYQl3e2hTRjhm5sUQbdb64rFKd/8alshOOJJIN0ikeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499984; c=relaxed/simple;
	bh=7lfJnaf1uzVEdcjWU+tgkFWedFsB+wFPo28b8l7M+kg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJgM5sUMFfo7XrOZ9os7sdNOh6dc06lMTHgashRxhDQvDMBwuwi2XO2x8YfGLWAIbzKjm+Yhl4MCttIDKMrWYQOMjM5OOb35zJ5ll2HNhU0UsOWghgSTBfAvHGACwk1jb46DF8rnp8i2ROUAQ9MwHuh7od3gnQX2SLLFWqZ7Z04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IWxEkgGy; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjE0aLOiq2IrPDniAc2nb2qcZ2aHHqw0qgLSRvNa1jy75+nbz6VlWRzBM9cboxgTopyX3iJcJQYcT/LVP3e8IjVFxWt9gRxZqNs/A999kmm/7P9pUM7hKRvXmMPIUy9BXZejy+ZNbuT20pLKjd9eslxaaAPK9x33WxO+Wwjvjd9i5a2k6ho+bNPvkVEkaW9b8h7kSQ4ET5EcJx6dUv8QSsrBZzsXvnmv+1lIVoVvA5YjDJEuIo3siyPM8AjMXHUv5nacI+V8Uvf+jWZkuUs1BnnLD95mdyDPcFA1ZyVA7Q6h3cnKgdnc6xytGyae2qOus+LMmDJokVNrvEP1x4G+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCyGNhOPsUGCPEwYuGGIUZsOM6G8cj/dX8iYsrHaDM8=;
 b=i75mumd9kftjZyONK72DmQOzozXytRTxdj6//8oVtUSgoXzDCtGBPAl+PVmrKEgv6DC6EKRBl7qLAh5SM8ZXIPmAS8spcK905VW3IYmH0yQw7mmOgn95L6KKxl3qNl93BNTokx6mC4exVxTh3QTfHMdq8/Rs9wRsGy7P/jP2EqDnmCmvRqMyr6eiPVEe3CAuQepW7m5iN9IUCmTNussuY3iZqmXkSCsQ7UqlU52a+H9kDcNA6w02ZxXXb+Dm/mLjz6ZxouJDD3SvE+zH+T/Sfg15/NMr0/+YzRN5y2mZT0zNhrg2UoRnyJNwrNVsWWMkwvJriwE/EgaRvP6Bj2hSDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCyGNhOPsUGCPEwYuGGIUZsOM6G8cj/dX8iYsrHaDM8=;
 b=IWxEkgGyMQBVO07kckt8R/TKn317y20M78jY2ZgtOD4y+DVat8sZAIXz3LUkj5YyIwUmFiniA/tMP64ahKgLLDwizCE3HWdwmnh3dH1Bv+ni0c2FnQW7Alkn08HtE2jWqgzGWYzgmbo1TEoeJqi7Y+tjHrmtc7oJYdh9TYNZ/nBnIR1OwD4Qqw6rRDXyRpfDTBuGRVr81fzpDZ5D2sXHXq7U/GlRmOdtDlYd2VgpzRO+zL9ESYKSw34hQFTX/V43CMTvrfzk5uNqU/CoXN9g7oJEVh7kpWeudYuSHxL5B4BW2xokRERKPIFCNX0WQ/hko5skf3WEu/3ziCV9oeLxFA==
Received: from BYAPR06CA0059.namprd06.prod.outlook.com (2603:10b6:a03:14b::36)
 by DS0PR12MB8479.namprd12.prod.outlook.com (2603:10b6:8:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:26:18 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::a2) by BYAPR06CA0059.outlook.office365.com
 (2603:10b6:a03:14b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 10:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 10:26:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 03:25:43 -0700
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
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 07/10] net/mlx5e: Use multiple TX doorbells
Date: Wed, 10 Sep 2025 13:24:48 +0300
Message-ID: <1757499891-596641-8-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
References: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS0PR12MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 935f220a-9422-4098-b54b-08ddf0547a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E+yWW/MgKorBq9cJEpgvvuP37dF5f5lipbT4VRmSjH9U5sLxkMoX3jQ0ZSty?=
 =?us-ascii?Q?vMDB+H7Pp8a231zXBkEmWCs5usyb2nkflqZi/jFoJhsSq0LhJ7KFO5xzU01c?=
 =?us-ascii?Q?H4dM3EWmL85U18kDlpjorDTe68lK7A1vEI1zEhsPIylpQZIMtYplLKVOkd7f?=
 =?us-ascii?Q?zTAGS2IlGA5OojojQVlvHiNoZt8nPkgFiuhNALywdM20nqE5gCPjE8ddx4A6?=
 =?us-ascii?Q?Zg3zDJf1nRetRsO8wPyTmiu9R1iln/DRkG1PDbKo4f7zdlYT6113LKFoZtgW?=
 =?us-ascii?Q?CFjR/0twaKAPTOyv+id0kjIQp0vLChuLbrKtuAW/OrFU9wlAqRZX/iCj6LBG?=
 =?us-ascii?Q?T+ACFWPyEQZ7J7LGqXF0EC/mHVnkV+CA+HLFq36cijzAe2K7w0c41Liy+X+D?=
 =?us-ascii?Q?pXmMbashgm8I+zwIZqKUkGROwOJBnrThGjfPqc2l4JMudWDKoTAlBGQBuHQZ?=
 =?us-ascii?Q?vul8/ge7tOpo8Nx01+7oLlTlNgSX3aG7oyn3giHEWNrldXnWP9IEuyt1nV6s?=
 =?us-ascii?Q?SRM/XwWaJiNnEJYRxD6fqDwAPlpNXn1ooCb7GkmIc1rZJYdfE/0ncBM46++N?=
 =?us-ascii?Q?eREMtR7qbA4wiUarUJvev1EdS+GJWXtGwykIhdWPcEvxe6O8yOQiEPg/VUeD?=
 =?us-ascii?Q?hbyQVDmyGJwYbGZXTxsn/fkm8Q4OzIJFEn1+O0gri7mINWWUNvnK0nL/9zf8?=
 =?us-ascii?Q?vGx7A4a/SUegSBAMwDrRB/ol8zqO7MH7OzmnZNCWRJ0f5xPddY9OOU9StHpG?=
 =?us-ascii?Q?buPfZhWDfgP1hcf4VBY1L38cLpw8rtQQUvZ3H+NKEP3MdwHV4hZHDnpm3Wch?=
 =?us-ascii?Q?ZskY+zDpQzuetyg0S793pDJUvyGHQT7uUZlQ+0ZI0bVnvAriIoIXlykX5GKk?=
 =?us-ascii?Q?KGXzHBvXSMZ4J+XfUFeNwXLlDDw71QhUJP2RDrMqLMWEm5M2iYAoZis2yXdN?=
 =?us-ascii?Q?GUAEqiFIVSaS2y3kgllIRYGgPBqtsfmwN5qtQ8ImLmvu9aGBNY3hJv0a9k3B?=
 =?us-ascii?Q?h/uxDVXvdEzVw+qRxzLYe7g0qPmcMprsAIV5Gh9gpRqd/dpj2MkP7zXGfY4u?=
 =?us-ascii?Q?GCTolGbD8pxieS3rJJwNTLeU3IcD/6sXLvA6fsTcw9fazhq/HsipMnalBJF5?=
 =?us-ascii?Q?gFdqWJULoUV6a8fhAbVCAljkd5H47hR7cJud30V7BuSw8AnKo50//oRLlNEG?=
 =?us-ascii?Q?yvQpu1iwUDcMcwGzys/M/SjYqPVb+i43SZlYGvR9M1im6aSIYWv+WxF8y6WF?=
 =?us-ascii?Q?NI4++Ittg400vOmmDY2wT91pxQTIN0ZwokbbctvVWeIuKKQkFawjd7kejVg0?=
 =?us-ascii?Q?o6oSzU/JQzNHn4hkD8ha6yX8vaHsNWvTFjryYd6mLc330qTOkk9v0JXDoBqt?=
 =?us-ascii?Q?B7/JZIcLRnjC6BTEHtkf0es81c5bbTOWaIAKdqgx3tIcfKQOejMC5k6q5irh?=
 =?us-ascii?Q?/6DizjLnetRzTOuejq5qIXxcVvBXHyZVjzNPzrSa/7IQc4nH11txzLnnjSm0?=
 =?us-ascii?Q?qWjckYIx3gMjHBgpubSjo5I/vQLXI/PQkb5v?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:26:17.6581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935f220a-9422-4098-b54b-08ddf0547a61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8479

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


