Return-Path: <bpf+bounces-58649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 989B6ABF3C9
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 14:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E0216A540
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 12:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DAF265CBB;
	Wed, 21 May 2025 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QHNF0MIs"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C725A2AF;
	Wed, 21 May 2025 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829407; cv=fail; b=M5JbopzWuGlTYDAmhWrmriQQ1ABKu85pAQ9+yzfh5Sp8o8SQsuQMtTodMbqGIul1yWuMI99OfaSL45m52BM+hpkmaZlFsvNBf+GX19BNBvTLItC2vqtHoLWTLFAXntSWDOd1EsdN6GqrosGJLGUU38JleRV7nnQIWAm6PWsFDDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829407; c=relaxed/simple;
	bh=z9Q3SDBaueCeiy4ZM2MkCBsikftP1THE6bZ0cSdgGvU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ifohLB9LmjEACS2JDnLQPPBmiloKssYyKWaxlXWnOLuaxrdnHdg9FTgs1O5f/t95G3jcYmeKFuS6Y0yESzMPHPLr4NjVQQ65+qDt9okuEFMAV1quiBYwHeL2SDuP20zvLbvU8a0LuHb+ANNJCKvPhOa1FlMOyxPKdel6nerqkUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QHNF0MIs; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGjlUB/6uUZ5mMAxSCRUjnGTjAbT2eerXxIABx4+FKEFNL/uSJlNDWBFHwh1IUXtxIcdBFtWfGbMbSCS/4Voh6pQMsq69h9Z62p3FqAtpYuMuk8pY57tf5xaNkSWV93wylt4I850zcyBIHKtJ7CoVXLfFwJBy7rmf7gLJHVqGP9mdm833k9oT0l1/as0OHwRo27f/uieIhEBTYZFPEYLOfR0hiGkC79mTGfvdP3/VtiBFLYWvL6UJWJPQH7W7W4iZJcY4myH4QjvC5wgqBhc9nxblYjGaaKvZoMUF+RDk71oIxpPkA1FUauMow/C04JTBwa+SCGuD4pU7s3/bsxZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0p4+VyH+1B5WuiqFbyNWlmnWE69rnSbdzvh5O7LQcg=;
 b=v3MxqMZd1iswOuJW66y9OVfaY6UvcbWcQJMDFLltrwrfjHM8+Hal8wXxwWp+2KhuexPmHI/TvaDxpeFQilhlIFw0cS9zpv4h+Kw6Y1A39rbSO0njaP+TJ+X6ylz7P6TuEnIu4UY8DAcWNpayjy7YlgCLXTXHebFCKXVTPLSf341MdvL4l1MlcqqhAGpqYRVKF+Rnss6mNqeSh2C+DxrOh4AaaFfGyD4l8aqBDooy4/tDZmOSsthOz42xSRmXodULZ6Qcf8uDj4V3qilLkOMHlCSTGtO24dyDGjCsUHpPXQW8WvQezxqjpJ3cymK7XhiAokSyUx0qeCoCkMaDxQSIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0p4+VyH+1B5WuiqFbyNWlmnWE69rnSbdzvh5O7LQcg=;
 b=QHNF0MIsj2BuAFHvsZpu3E5vb3icEllMJNpfkEWpl7hQyM3nNjluqLbIp0JXMZn7RfRllqk2UUj4Gh1k9mQ9xDK2kpicsuMI0VRXJ/E2hXi22F+TuOlj+hSR+rbjLFlrVWKlx6dYTy8hkkvHjRVprviBUQD6A5k/Z10K5rrT/cKfAy4PY8MInxGKaBXpgaw8Ianhhh0fJ6/L18PzT3SM8wYbVRLutV1WA70y2A0yDwNRSo4NXilZKkXdmlP8NMUPgSTecScZuYLjpYl9fGYsQy4soCOeOqEctD48gmqadNowDCWpUuhy/Da1pVABLlvuxqhHjr+8Wc19ZpB8CAERIA==
Received: from SN6PR16CA0037.namprd16.prod.outlook.com (2603:10b6:805:ca::14)
 by PH7PR12MB6634.namprd12.prod.outlook.com (2603:10b6:510:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 12:10:00 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::fa) by SN6PR16CA0037.outlook.office365.com
 (2603:10b6:805:ca::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 21 May 2025 12:10:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 12:09:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 05:09:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 05:09:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 21
 May 2025 05:09:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 0/5] net/mlx5: Convert mlx5 to netdev instance locking
Date: Wed, 21 May 2025 15:08:57 +0300
Message-ID: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|PH7PR12MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: d6358797-212d-42f6-c406-08dd986068a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?npP0KCFUbKZ7Lhxo7+7RZQ3ZaAlW269okLRywllYdOMxsNM6KoJlof8Z4HCa?=
 =?us-ascii?Q?qS2hA8vav7qR0iK4tVJhBDhnFXOWeV3YfJVv6R3h7398IuoHSBQD3k2WCcUF?=
 =?us-ascii?Q?0lTerzk4691pS/P08FKNpyC2vGkBKI5zEuSi4sJX0l44I9Dauw8bdszSrZoj?=
 =?us-ascii?Q?HopKJcpvRv9JKassJINbIYsOcipQpmloNSSS0GsM5g3Tc16inCBdiM6Yt2So?=
 =?us-ascii?Q?3wi4A6LytggmyFedhO1DWG7bm3kJocaSMOsrRwCwuxn13YeoqYucwkOudKsX?=
 =?us-ascii?Q?BtyhMEdp6Nv5biy8shJO7xOi3LRLiMc7DFz71rBsStRCzaSeyyTti6Hk8pt2?=
 =?us-ascii?Q?H1tSZvUkpSHqvwxPfszwp6WyeWtro+dMF60pheI3kLvqC+8FJ8dPnvf98sQR?=
 =?us-ascii?Q?DyTJgcUkfis1j59GYzyvPidZJLtV2BGAirz9QSjmPmRLElt3Abs1Ne0LG8Ig?=
 =?us-ascii?Q?POuGNabVsriIlrXSUv859H9AcVwAPikO2p7CacDT4iFQVQkdy1HmFzVgwPa2?=
 =?us-ascii?Q?TanjCTLU7y6TJvMiNGaugF78Zf/Apy2afaAOStPUo9zVMUDssXQe7kAyTpkw?=
 =?us-ascii?Q?Do7wMcqZ+xw2NLjGDFWMGfGc3pav4elLENNv0u+E0qTdGtpvSgVRxdzQn3TN?=
 =?us-ascii?Q?MRVgCXUgmHdP10kpPACGxE//sLnuzxl/GxKqTknKa7pUtCM7b5/gfAdUMqeG?=
 =?us-ascii?Q?nJaIobLLTOCI2Y+3PexzRMSPZV/oTJooEYKbu5bTJLMF2m87iU2c57ga8HFw?=
 =?us-ascii?Q?poopi5YI8Co2hytki1tvRdkHG8Y89jxvR89aEkDG2ti0NfpJKYN0pJbx2wZn?=
 =?us-ascii?Q?CBdFriZ+BNTuEK6iXjlNMN/L7VTpzheBzIWuEvsDMOaeEfpZlZUQJNbRvxkQ?=
 =?us-ascii?Q?qRJLvCm2LYHZfNjSB82BvdYPqU8o99q7HvkXljlUPRHdQIaIT5FmY36FUaZi?=
 =?us-ascii?Q?URlfdlU6iWcgl4yX55VPVLq6qmMLR1wwpBTxjV0ThNJxKQVdX4iHLuHdji7J?=
 =?us-ascii?Q?OyHRP66Rk2g6bf5hQZpBhJsoWgN5z0pJhJDKnHqKR7IWDqU235tW3/iW/XCA?=
 =?us-ascii?Q?0EGI8qC/YmXxyPufMc6PsACM0LBPUTA67HYCnx/uyeMAGxgnjwIGXbEbzcqQ?=
 =?us-ascii?Q?Au41V+qcUYj4k0QTtTsqxRDdS0qOJJqOmQJ1zbC5CBn1KTDxFmAs1KO0ORij?=
 =?us-ascii?Q?yYpySQztmAaxQ+jv1wBL0IKV+BLGg1BIdy5szFmceeQIxZ2FlY343mvVUWKM?=
 =?us-ascii?Q?LDcRKbsHxIKVADeZOhbnOp6vlm4/qYN1/VZYq83VWJzCjjPUBkUbzmrz3WjP?=
 =?us-ascii?Q?Ki5dIARGisER1pP914PDuJOS9Lobwley51HmZfJx4LArHaXISyPNnEbzJXPD?=
 =?us-ascii?Q?uCdorAK2ObYVmTXoN18g8ZtDVuCCmNZNJyMB2kClJsXaKbJtFmymfmyxzXW3?=
 =?us-ascii?Q?YViakVm4NUSe0VY/5bSZH9hKrXD9fw0+OaR/qLxtZhzr2qyWdcgN0QKYB/Ru?=
 =?us-ascii?Q?ltTs7HlBHry4ymffz4pSjDggyNjHbEGjIWKR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:09:59.4782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6358797-212d-42f6-c406-08dd986068a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634

Hi,

This series by Cosmin converts mlx5 to use the recently added netdev
instance locking scheme.

Find detailed description by Cosmin below [1].

Regards,
Tariq

[1]
mlx5 manages multiple netdevices, from basic Ethernet to Infiniband
netdevs. This patch series converts the driver to use netdev instance
locking for everything in preparation for TCP devmem Zero Copy.

Because mlx5 is tightly coupled with the ipoib driver, a series of
changes first happen in ipoib to allow it to work with mlx5 netdevs that
use instance locking:

IB/IPoIB: Enqueue separate work_structs for each flushed interface
IB/IPoIB: Replace vlan_rwsem with the netdev instance lock
IB/IPoIB: Allow using netdevs that require the instance lock

A small patch then avoids dropping RTNL during firmware update:
net/mlx5e: Don't drop RTNL during firmware flash

The main patch then converts all mlx5 netdevs to use instance locking:
net/mlx5e: Convert mlx5 netdevs to instance locking


Cosmin Ratiu (5):
  IB/IPoIB: Enqueue separate work_structs for each flushed interface
  IB/IPoIB: Replace vlan_rwsem with the netdev instance lock
  IB/IPoIB: Allow using netdevs that require the instance lock
  net/mlx5e: Don't drop RTNL during firmware flash
  net/mlx5e: Convert mlx5 netdevs to instance locking

 drivers/infiniband/ulp/ipoib/ipoib.h          |  13 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c       |  65 ++++++---
 drivers/infiniband/ulp/ipoib/ipoib_main.c     | 127 ++++++++++++------
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c    |   8 +-
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c     |  19 +--
 .../ethernet/mellanox/mlx5/core/en/health.c   |   2 +
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  25 +++-
 .../mellanox/mlx5/core/en/reporter_tx.c       |   4 -
 .../net/ethernet/mellanox/mlx5/core/en/trap.c |  12 +-
 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    |   2 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   5 -
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |   4 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  82 ++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   7 +
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |   3 +
 15 files changed, 246 insertions(+), 132 deletions(-)


base-commit: f685204c57e87d2a88b159c7525426d70ee745c9
-- 
2.31.1


