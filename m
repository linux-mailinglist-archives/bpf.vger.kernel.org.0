Return-Path: <bpf+bounces-67997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B4B513D5
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5EB482FAF
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 10:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966163168EC;
	Wed, 10 Sep 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ImQzCu5/"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552A32DCF55;
	Wed, 10 Sep 2025 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499939; cv=fail; b=gNJlx7Dzmf8sY5V/hZEujiOpEMQ1DHAXpCSe2HzG4f8mo1r1enuctP8GFXiI5HYEVA0BFXbACo/4ndNGEo47p1B2io/OIhLldMoEFewtVMeiPTFYB57ZY9T1AFLH1MrIt15GBngX1Ddn3rhBVVhDGvQ8jdGiaMPk1cqn/+c2cCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499939; c=relaxed/simple;
	bh=JlZi5/PNbeFXxkE6VxCPR06ES8sJqO03CPHyUDPd5PE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PYNHNpucfErBdgxqjI8FTc3ONnMxRpQYCe9JQZ0sqYnTNIa65CNDjz+ij800k+o6e1jRlK3/7sAUikSBqKFX3TfkR6sNYFufEM3xAgG+7GGEHj0aC5NSX7Gh+yfE69kLhX9oCC2JILL/S+2nd8e1sq06tE5R5ZwX83Ej0twK0lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ImQzCu5/; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2gCK64xZ/9QIGYIllUlTHdtG2OxPO+bz9qu6PPfuNIFEe73HPIR+H61krNq9Rg15Lojmaz70KGlVSuHyBIBe3tsxWQBW9sRZJu8fd2sSm7c73/Xb/dI8IycH3mbzF0isoowou9aOp3IxU++AzBPjBWP/+LoscKP+JTOtLEi9L6ccarpqng/JGOVfuyg1u7tCwFnAVU0CyjVsm4Y7hxOYu0lO2NOcHHmmBKMMkbrSIcEPVrAtjzSjt57BReHqVLGMwh1Q9qbuplB/RAA1oAcU55rwRfsNfRX9TxEqy5v8q/NOpFtd7+s/WrVGMb3Jf5VxmTikPEECPYsJhpf8vokiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfZBu/zRtsFZWS1ayHQuYM5OJCppBIObo/D9WeNTVgU=;
 b=jEixQVEql4k/Y5pCki+OqkxwcuP5JNo3A7VhIIUU0XFAAK0t1PZIeSoHAK8Z+uYsIjJF/JVigUEQXxvNsZ8hQYTKwPnpd7RlpVT+YG8PjUz8lbZkGvxt2r/iU+UuS373utk6Wx5H1RmfSEAvPhuAeCQgpS4KQkfHKoBZ83ckX8keKl/73IU4Hui08lDsumlC/VkBiD33AjilZlh3lB9yjoyqHPr244tYmMS9/T1F0k5AqmWvSGO7ZrWThulU8IdZWVqzSdRdZvEsuIJsDfDT0SNdU/f/tbROYHvpG5/bxzXWx3gYwgKVSxmoErKoiveqvMj6EUQXsRCDxKJ6SwZiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfZBu/zRtsFZWS1ayHQuYM5OJCppBIObo/D9WeNTVgU=;
 b=ImQzCu5/eneuv4ZwevaR88/vf9mA9Hv0ikreRIxSH+hWuMZpkewqEwz0Qu3hEHSCK5B4updkwS/a3gRXT9XpvyHpyOEZQ0xIScAahaO1WSqZ4sqWaR40wD6S+4V6bUtzK/hSCm1x2LWRSVScZqqsjYXSG6AmZWGs222llfhSmTapNRd24Z5cU0JP+rGqavCRqCMBC7DgFpUHIvn38Sii+2P3HvSbXc+sSkfvvWTabesAWJdGD3oqWHKL5iOuDodf1QqQ95YvdsSInQXjLzf19weIiUKtcyja1jP4UDUAy/19FrIndpJmqw/Rg8em6dqZg0d4fwWZ9a/4/ERsYCzL3A==
Received: from CH2PR04CA0001.namprd04.prod.outlook.com (2603:10b6:610:52::11)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:25:33 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::55) by CH2PR04CA0001.outlook.office365.com
 (2603:10b6:610:52::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 10:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 10:25:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:09 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 03:24:56 -0700
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
Subject: [PATCH net-next 00/10] net/mlx5e: Use multiple doorbells
Date: Wed, 10 Sep 2025 13:24:41 +0300
Message-ID: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfa151a-56e2-4068-b775-08ddf0545fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zyAA9XzNmB+xYuT9Pdzagooj7KkaZ9xBCGmKV2qIeoXI3APlCapuML3GZA5h?=
 =?us-ascii?Q?BVMDqXi3MTcfm2mv1BeqTKLTCWYvMnTvl1pU6Zilg36RMHpZSf0Ojk2R8fBt?=
 =?us-ascii?Q?0OaiEjtvNB2A6F1AJw6LNnxmfaZgLgaYXn7hmuvSbl5Q7qLuQU4axm1Mp44P?=
 =?us-ascii?Q?tRYhNULyHgiM76FI+G7tCfjgMSXqg4gEfx2zH+COghCpTK3BASe6wfofuLzK?=
 =?us-ascii?Q?ImuIyLI/QnGFMabsIWOG7p9U88+j0q293ck9sq0uU9YXfBd4FAh7hue7c9+F?=
 =?us-ascii?Q?T49Mzh89kEEXrLcRo7LkZryPdEIHQPD33oLetkzJLTg99LiASSzvPpV/COc7?=
 =?us-ascii?Q?uf5n5/P+x5NXh9CzFo/AostWLvLEN0NzC8wXL7pcMKjL+nnkAYHEDfD8q0oM?=
 =?us-ascii?Q?3IbFcRGu4OPqn6zI882f8zlIersw/xCHDk/TZkQKWFBInkBBMXA51YLmRj0F?=
 =?us-ascii?Q?0Qp5u54h2UyXmq6mUQ1b85qgoj/s1JtbhS9mgIxK7UmCLfc6GswkfaG9Uij5?=
 =?us-ascii?Q?prjSi6mpZB9GZa4GBtaOyyKgmi54m9sLys1iMhE7ITRj6J0ooU3OPcsidOhD?=
 =?us-ascii?Q?tpKr2FjJLXtq1KDTE/HlnQDtHST42NLmb3kFLosAR5/w6SDETEBW1gfheHaw?=
 =?us-ascii?Q?gtQpSeNY7scXC+u9GwwwSMzDcJui/a7nAR1UILUird4mjt/KWDhALUPtFTaS?=
 =?us-ascii?Q?m/ALInFo5ZN7dPp8jlBG1Ri/jraSdTKaLoALxyvnQAAoqB/Kzm7ZlcljJHUj?=
 =?us-ascii?Q?aM1vRt0KP11Xxw93GLlS8jo7aWK2gLFhXvTihwCsirAkVexSRy3GBB3u+6yE?=
 =?us-ascii?Q?bOy+hewQubLESnGPW72f066UOY+IIKNi7Vx/PKoo5DaJVSPsKDmFqhv9jvo5?=
 =?us-ascii?Q?Opa0CkQnTiI3zdKPeRzXTWRiLvSaXbkQNnAIJvKGdZ1Lo5LJoyh3ahRGLR7e?=
 =?us-ascii?Q?shjozpFxi/2iZChc5Bqia4PYyZT2bszKBVXxhtxFQnJTimOoUg58mYRV+el6?=
 =?us-ascii?Q?KKbzCEmk22ITtnqyrsCBUTkuFuFO7VZeBJ0wqo5N04+BmmTvsZOOPdU9pTHw?=
 =?us-ascii?Q?7EZPkfDBmm9CEqSnCPLE3P8yd0FZlhT3NlTcIpe423rnb0PXKNZnK5u30/1s?=
 =?us-ascii?Q?KOIR+rYxbmCr78lXgHgej/Rxx22Lx6jC38UQ1tQM++yQ5q3d00BZmuMyvwhk?=
 =?us-ascii?Q?IVH+S2aA1ZsuQqgOpttt85XJho58JKKPaooOsrejpwqDMaUjh0i/prqqixRh?=
 =?us-ascii?Q?mT5pGRVPbcbSZVIuzVRn5kbAOUUglqi1YRRJAtrU1xp3LZejbtYvwf5S9g5/?=
 =?us-ascii?Q?wU/ihGxl3wiAOPil2kDRqRwJmzKiS5ScOZQyAgRubg1XC9fCUL20FYsbtpjT?=
 =?us-ascii?Q?025qtSN1ISIYTQbeAxSqLo4/hKt6WZT/+96q+MQ8C9AdvHnnJb0DBoBuE3HI?=
 =?us-ascii?Q?7iZEjyBVhXyQa9ki2qZacbHMYpxO9zutLShkOIjjXHmcpu4uilBYAo3r8WnW?=
 =?us-ascii?Q?lxGV3dtSNeSbDUiIyaQBui+DKwnmqNfI0yvR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:25:32.8349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfa151a-56e2-4068-b775-08ddf0545fca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099

Hi,

This series by Cosmin adds multiple doorbells usage in mlx5e driver.
See detailed description by Cosmin below [1].

Regards,
Tariq

[1]
mlx5e uses a single MMIO-mapped doorbell per netdevice for all send and
receive operations. Writes to the doorbell go over the PCIe bus directly
to the device, which then services the indicated queues.

On certain architectures and with sufficiently high volume of doorbell
ringing (many cores, many active channels, small MTU, no GSO, etc.), the
MMIO-mapped doorbell address can become contended, leading to delays in
servicing writes to that address and a global slowdown of all traffic
for that netdevice.

mlx5 NICs have supported using multiple doorbells for many years, the
mlx5_ib driver for the same hardware has been using multiple doorbells
traditionally.

This patch series extends the mlx5 Ethernet driver to also use multiple
doorbells to solve the MMIO contention issues. By allocating and using
more doorbells for all channel queues (TX and RX), the MMIO contention
on any particular doorbell address is reduced significantly.

The first patches are cleanups:
net/mlx5: Fix typo of MLX5_EQ_DOORBEL_OFFSET
net/mlx5: Remove unused 'offset' field from struct mlx5_sq_bfreg'
net/mlx5e: Remove unused 'xsk' param of mlx5e_build_xdpsq_param

The next patch separates the global doorbell from Ethernet-specific
resources:
net/mlx5: Store the global doorbell in mlx5_priv

Next, plumbing to allow a different doorbell to be used for channel TX
and RX queues:
net/mlx5e: Prepare for using multiple TX doorbells
net/mlx5e: Prepare for using different CQ doorbells

Then, enable using multiple doorbells for channel queues:
net/mlx5e: Use multiple TX doorbells
net/mlx5e: Use multiple CQ doorbells

Finally, introduce a devlink parameter to control this:
devlink: Add a 'num_doorbells' driverinit param
net/mlx5e: Use the 'num_doorbells' devlink param


Cosmin Ratiu (10):
  net/mlx5: Fix typo of MLX5_EQ_DOORBEL_OFFSET
  net/mlx5: Remove unused 'offset' field from mlx5_sq_bfreg
  net/mlx5e: Remove unused 'xsk' param of mlx5e_build_xdpsq_param
  net/mlx5: Store the global doorbell in mlx5_priv
  net/mlx5e: Prepare for using multiple TX doorbells
  net/mlx5e: Prepare for using different CQ doorbells
  net/mlx5e: Use multiple TX doorbells
  net/mlx5e: Use multiple CQ doorbells
  devlink: Add a 'num_doorbells' driverinit param
  net/mlx5e: Use the 'num_doorbells' devlink param

 .../networking/devlink/devlink-params.rst     |  3 ++
 Documentation/networking/devlink/mlx5.rst     |  8 ++++
 drivers/infiniband/hw/mlx5/cq.c               |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/cq.c  |  1 -
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 26 +++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 ++
 .../ethernet/mellanox/mlx5/core/en/params.c   |  6 +--
 .../ethernet/mellanox/mlx5/core/en/params.h   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  6 ++-
 .../net/ethernet/mellanox/mlx5/core/en/ptp.h  |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/trap.c |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  5 +--
 .../mellanox/mlx5/core/en/xsk/setup.c         |  2 +-
 .../ethernet/mellanox/mlx5/core/en_common.c   | 45 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 37 ++++++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |  8 ++--
 .../ethernet/mellanox/mlx5/core/fpga/conn.c   |  1 -
 .../net/ethernet/mellanox/mlx5/core/lib/aso.c |  8 ++--
 .../net/ethernet/mellanox/mlx5/core/main.c    | 11 +++--
 .../mellanox/mlx5/core/steering/hws/send.c    |  8 ++--
 .../mellanox/mlx5/core/steering/sws/dr_send.c |  1 -
 drivers/net/ethernet/mellanox/mlx5/core/wc.c  | 16 ++++---
 include/linux/mlx5/cq.h                       |  1 -
 include/linux/mlx5/driver.h                   |  8 ++--
 include/net/devlink.h                         |  4 ++
 net/devlink/param.c                           |  5 +++
 26 files changed, 162 insertions(+), 59 deletions(-)


base-commit: deb105f49879dd50d595f7f55207d6e74dec34e6
-- 
2.31.1


