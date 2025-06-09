Return-Path: <bpf+bounces-60053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C868AD21A5
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECA3188F61E
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEBA219312;
	Mon,  9 Jun 2025 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q32QKvRS"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57AD218EBE;
	Mon,  9 Jun 2025 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481142; cv=fail; b=fHP/Qy6IST50HyJYhuHlLNlMmoH9gDGTVMmiuGLujJkQSzWl8AJ1pmiz88jo4G++4yg+XhoylDwsQDKaHVaqB0wuXqi40oFUQb+sDNiOT8r0GVUSYMLoJrrECR52eqx+MsbKFdaP/AhAGrKWU/36yiRPnLmc1QBsM1Qie9ssEoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481142; c=relaxed/simple;
	bh=R6G0kDwmzQHfanlClpKwlbA0XTg7a750/QLsBuPyBog=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=as7iNvkmtObKqPBqBlmg9nEkLiuVRPr3MpN0e9y8yS8I5LNjKqxXCUHEYz3wKXHrjmE17HBVP93JACwbiya6i0s90tydmvytsRqnelTs1P2NQytnEogmSt52LUtOhG0lMW7Cck8Qr698wHTwGDH7YCLFKCpRSCWzuyk4Dli31KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q32QKvRS; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPaLhEBHfK1D+hRpx3gBlgZu+DL5EfNDHeZseNnVg6Wn5mhJnJNGRJc/gLNd+Eq7lhJAr6iKSVqwL76tyQzhf/PCSwWAr2/5Mt4L+heJ4EM+rxPLU9q2Au2uJ5VScSFEAEVVWPl4oomdEclhD0Igk9jygONzGm/0L9JxEt7NnErPw8itVThQ2Wcb0Fz8KJUmR1ufEhD8tZANUdkoFJMYWyHgCH30RLcs51Zd+B9dw5hFpb0x8C0DPNdq2S+h6PZn8cqtEFiMUCA+czgeHFZtOw9HJPsADKKoaMW7S27Uc6uQas0Fp3xl9/AwNrBCcgEe+roAI+WLodmuIcqwjio0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GbowO8zUKBBkEJbildRgcO9cyGc+z3pdinvYJym1OA=;
 b=J38m5yrT1hiWBAM93Y0IVFQLSpsMY4cpQDocseE9xlZ6n7RTeNWVGh/fOw9RD3Q+I5sBOTXDqnS+c9aNGG/OYXZzCFlenZjsQwPBj5GH5+OBjBlC3wmUx2gBZucGXP9mcpRiQyAUTjAOUmpoPcYexW4CaHUsRt7n5Ywatzk943HM6a56YH4xsIcosCVQFDD6nOnQIgqW0nY2ATB7jsMdbidZVIV7ZdKXKsZd0R7ITaZlOI9Q9MFXklTiVQ05w0V6ImtttbNqYdqJ41vqqxFvDLWS1cpMilHCqW7yrjB84YLStU0WM1oYuIXqH987VEzXRoZ+nZ7O9Y7UXtuUpQGeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GbowO8zUKBBkEJbildRgcO9cyGc+z3pdinvYJym1OA=;
 b=q32QKvRSEVstU6/qIhmKktuItBBfW+87p1iSdL+5vb1IvdUFEzV+VU6ogZ3vBesjrKQkMC79gTdjTyAKJTbON84EIz8930Zm9wurFuLaJcfjwPCGErwVDCTMGro3Qd6PulZixT14sJ8WRvQDySNQ6cODZ/3lFqwNQzrkBEMH4KeNTpv8BY6a421jwR2RDGZi8yWn0SJYZYO1fllT/dkUL17sKWU1dP4nkDKxrc94hn52U+TBlgUA8Qk4iusPJnR1CWXhLwoiGEwUiQg/tZZWFm5faGF2PIunt6mrdwRsS3w008Xk+/szQqykqhuCDuNp5L+q8Dq+UNnopya3lf6wEQ==
Received: from DM6PR07CA0042.namprd07.prod.outlook.com (2603:10b6:5:74::19) by
 CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.39; Mon, 9 Jun 2025 14:58:57 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::77) by DM6PR07CA0042.outlook.office365.com
 (2603:10b6:5:74::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Mon,
 9 Jun 2025 14:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 14:58:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:58:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:58:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 07:58:37 -0700
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
	<bpf@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 00/12] net/mlx5e: Add support for devmem and io_uring TCP zero-copy
Date: Mon, 9 Jun 2025 17:58:21 +0300
Message-ID: <20250609145833.990793-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: b235af9d-3f74-4a1a-e3ce-08dda76628e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AeEYkpRZFjYWUzsX4ZQ9ykUppWnK/x6CRJi5QSU7zm5rQbEHkWFrIXO0WqP/?=
 =?us-ascii?Q?/DlLZRJyqHmE2odA8is82wXTp7QMgZmbxVxQu4gH6oTLPyfEnCB/C9cHFl2t?=
 =?us-ascii?Q?j8fMxE0w7uHlpm/soPQbi5j1rJkmBXC7G/okDy+HXqI5vGJ0mKYZmqjrZj2O?=
 =?us-ascii?Q?eOixPNxJQgIWapyYEN5QEL9DROlrHpLvAT2rl2Y8RTOh0kz/nzvuLa0nILPX?=
 =?us-ascii?Q?IdVaTsprw/RjiOupB9ASU3OF0/FYbswuOzSBo69JiHkZ1CYnOuRF1mT9ZwyC?=
 =?us-ascii?Q?TSVVwEn8QudiuXwJ76BuOvljPhS5r6GUwgR7Qe4Q2HDg/rLWDiRnmn4kA3Md?=
 =?us-ascii?Q?sUcmdsUUALLCRxmn5mSgTlB9fDLgPOY92ZMaKS2WxYdVpVw5hjIT3CQXRl4C?=
 =?us-ascii?Q?MNrJ7YP1yYH9eVKkyoDg/Hp+gC64bfkxDLQSqXqsaHDwwzQK5sZSFjhknbN1?=
 =?us-ascii?Q?V8HkxSnNJ9LyPVAyRsCwoXnnxiMut/D3esWM6lsNl2D40Lh7hES67k813tsy?=
 =?us-ascii?Q?YvkZ+/ZonDqCkEO1vgfrMYO4DoAkV6xZvHecZ5dqMpGbe45Ficz9cAF90Clj?=
 =?us-ascii?Q?1/CSMhe7gRLsk2J9ljbROtp/QZP5FRZhf+A9WzWNdAsMdH881Muss851gTgZ?=
 =?us-ascii?Q?y+RmuyX4nlFTH+S0buZfsuB3N4iasdt03JOTTSLgoW6Cc5vJ4J3jOhmq5BKS?=
 =?us-ascii?Q?Tf95AKb8EqZugSh+GQ3OCsX5xZ/2CKYB7xFhASX7Bk6GwBMqpcDlrDEYifus?=
 =?us-ascii?Q?Pf1IQKQ5COtfp26P1gA+D4qmab+8G3YX8cAelQuum7CKjY65UdZTUu06Yxly?=
 =?us-ascii?Q?t7AXgyiAt/VvMrxLFhHKAFWi5Z8PHJl7JEOiKmijRwzNGhYH/qCwEiAHWFqd?=
 =?us-ascii?Q?/WRnlr1q/elq8f7LqAGJZUvoBf4XKTy1lZVh3Qk43n+3493GEJ5l68D3DoZE?=
 =?us-ascii?Q?+jjmHvk67Rir58zcskYLnJOAduIn0DF0Crvw7zuOGKJMq1CAOdiO20/lO0SZ?=
 =?us-ascii?Q?I9/GcoBMn+f1K3XtafYQDmbSWfxUt5jRfCztUTMQon6WL6gX2DBZU5KXrclv?=
 =?us-ascii?Q?OOcmYnZcZ0dQllZQ/a1vj0KReUrB899WgjYH1ymjm9l3QsApNOBD6D+6kBT6?=
 =?us-ascii?Q?VDt/VRkAumnOWAFad8B07nLGGOWdw9hLhjyAF2KXvSJMLCh3K3kU1bXp3lgI?=
 =?us-ascii?Q?KI75f/8znIinAwUbS9L71WHM8w3Qw4lMlr7mSf8MkXhzlxoAroOXxYCri2W0?=
 =?us-ascii?Q?xzfzEHcJj9ByemrjEzdc1Qu9KQpXOqYEy3P5PE67WSi5M3SzQoXriNbL4IOh?=
 =?us-ascii?Q?RlG5SmxxfqfDW6S4bNPpZA7QxCYAwvBc/Y/Xy0Xoc0E/W5MHAOx9uNjTvqXg?=
 =?us-ascii?Q?4XelfRB1g/xNpVcPzM8mZYmRViPl9mxWrWUdQVrXF6Cnu1/LEe66evL33DDw?=
 =?us-ascii?Q?7xR8eYbZk3lMRGPpMI6pvR59K0mxt8dhzXqpywAu1ITrS9tZyIxoYtPCPSVE?=
 =?us-ascii?Q?N/kkysWyMbKNCo+xpflJHgLX8mP/ym2/arLnw6VZg02GqvpLqDv+JmtJoA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:58:56.9464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b235af9d-3f74-4a1a-e3ce-08dda76628e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319

Quick note before diving into the series details, Tariq is on vacation
for a few days, I’ll be handling the mlx5 core/netdev submissions
in his absence.

This series adds support for zerocopy rx TCP with devmem and io_uring
for ConnectX7 NICs and above. For performance reasons and simplicity
HW-GRO will also be turned on when header-data split mode is on.

Performance
===========

Test setup:

* CPU: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz (single NUMA)
* NIC: ConnectX7
* Benchmarking tool: kperf [0]
* Single TCP flow
* Test duration: 60s

With application thread and interrupts pinned to the *same* core:

|------+-----------+----------|
| MTU  | epoll     | io_uring |
|------+-----------+----------|
| 1500 | 61.6 Gbps | 114 Gbps |
| 4096 | 69.3 Gbps | 151 Gbps |
| 9000 | 67.8 Gbps | 187 Gbps |
|------+-----------+----------|

The CPU usage for io_uring is 95%.

Reproduction steps for io_uring:

server --no-daemon -a 2001:db8::1 --no-memcmp --iou --iou_sendzc \
	--iou_zcrx --iou_dev_name eth2 --iou_zcrx_queue_id 2

server --no-daemon -a 2001:db8::2 --no-memcmp --iou --iou_sendzc

client --src 2001:db8::2 --dst 2001:db8::1 \
	--msg-zerocopy -t 60 --cpu-min=2 --cpu-max=2

Patch overview:
================

First, a netmem API for skb_can_coalesce is added to the core to be able
to do skb fragment coalescing on netmems.

The next patches introduce some cleanups in the internal SHAMPO code and
improvements to hw gro capability checks in FW.

A separate page_pool is introduced for headers, to be used only when
the rxq has a memory provider. Ethtool stats are added as well.

Then the driver is converted to use the netmem API and to allow support
for unreadable netmem page pool.

The queue management ops are implemented.

Finally, the tcp-data-split ring parameter is exposed.

Changelog
=========

Changes from v2 [2]:
- Added support for netmem TX.
- Changed skb_can_coalesce_netmem() based on Mina's suggestion.
- Reworked tcp_data_split setting to no longer change HW-GRO in
  wanted_features.
- Switched to a single page pool when rxq has no memory providers.

Changes from v1 [1]:
- Added support for skb_can_coalesce_netmem().
- Avoid netmem_to_page() casts in the driver.
- Fixed code to abide 80 char limit with some exceptions to avoid
  code churn.

References
==========
[0] kperf: git://git.kernel.dk/kperf.git
[1] v1: https://lore.kernel.org/all/20250116215530.158886-1-saeed@kernel.org/
[2] v2: https://lore.kernel.org/all/1747950086-1246773-1-git-send-email-tariqt@nvidia.com/

Dragos Tatulea (3):
  net: Allow const args for of page_to_netmem()
  net: Add skb_can_coalesce for netmem
  net/mlx5e: Add TX support for netmems

Saeed Mahameed (9):
  net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
  net/mlx5e: SHAMPO: Remove redundant params
  net/mlx5e: SHAMPO: Improve hw gro capability checking
  net/mlx5e: SHAMPO: Separate pool for headers
  net/mlx5e: SHAMPO: Headers page pool stats
  net/mlx5e: Convert over to netmem
  net/mlx5e: Add support for UNREADABLE netmem page pools
  net/mlx5e: Implement queue mgmt ops and single channel swap
  net/mlx5e: Support ethtool tcp-data-split settings

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  11 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |  36 ++-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   3 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  33 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 305 +++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 136 ++++----
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  54 ++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  24 ++
 include/linux/skbuff.h                        |  12 +-
 include/net/netmem.h                          |   2 +-
 10 files changed, 449 insertions(+), 167 deletions(-)


base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
-- 
2.34.1


