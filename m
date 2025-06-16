Return-Path: <bpf+bounces-60716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A01ADB34E
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967423A75B4
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2276420012B;
	Mon, 16 Jun 2025 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rk5flPXo"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542C1A83E4;
	Mon, 16 Jun 2025 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083312; cv=fail; b=q00vxlyMl5OOd0Z0Uyl/ZXPgt+N7h+vp42nPodaOkUw1OWB8bWfxkRblSSHv0cIE8tUhyWVYfBwVkyqTrTtVsCZhQCxPBLeQMt71t6kVEDjW/ZCv+axi7i8OH2sTxXalsfhyJbjCleKlm6OAFvpn5CBr7e//KffbOEWND6nI9FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083312; c=relaxed/simple;
	bh=fsu/6Z+3YrdhIPM0krEI4n05b5HvBjUljiQHt8Pd0/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Onjig7zoV4e7SeTEPeqG5MNJCsC6zb9g7PWW3UGOXxPux119h7ya4IgC3TMO5OoPcUmjFRY1jHMjY+go74VqhcSXRemfSFGAwP/qQdlDme5S7ZsSYp7qYKQseZ87UYwgwQdtwFSk3berTfDsA7XqYtMlhpvMyVFSpDhJq8DFp7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rk5flPXo; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au2oA1bgJxPTDZLN6ELizhRstiPJtitTsv3yneL94lgY+Pf1D6nMj1tRllThBSW/dwzoJt/LJlHiwcW8IAs9aAI+wW9SiXe9Zd2yEyY3TDLwuHTftZgj9JACSpEiMGIF4qnrJh5tyZ6VimCK4kIDRj678Zz0CzkJzyhCBMzz0/+eTEbJ4aLLJ7NEu/0AF6NZlBvcZLpBLYbYL1I/R5ye2cqQclmHncR+rGVZ2RarAqF52Zsa1BEDVCGRFSXFBdn7WI4spgXN+5Ft69pbOpDoXHUBpdSuP334koM/BIvvA8lwPRWYHIwSBCIxPT8h4cxBmGXxv0JcLaSKyzRtezU6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khOFh/lVYke3Hcx/3TBwT1tpF1QmpIv5wtLH57cz4Gw=;
 b=ZTEKoV8zRlB7cpbZQEb2MmnIYtNWpwRCBdRk3j5jib+dsRxcJ8BMdcgyXz1L/v635AJBd17mgDIJ5Jh4fET/KkayCtw9FM+4weFoyp772tpRHZw69LIjstxvOB4WgtCLVVva/RenJAsymdofN/kKHWFF6qSmZqJEkmjjf9HsTBlLh3ZuF7TYei4c0BBXPCy3QMqWDah2/qm07o0zk0Y7Ox/fjEyBhJbYOFPAeiVcwxV70jM+QduY3DzBAry9SKW/0H67Ay8EMOzRB8Uxs8SiEUmUizUeAUBg9DgpeVRKednl3eXhvBCzPKkiv7zsy7KlW4w7qCir1xolQhKDm9OPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khOFh/lVYke3Hcx/3TBwT1tpF1QmpIv5wtLH57cz4Gw=;
 b=rk5flPXo46pM49hnbYE9Tp12LwRT+4p/4sTdtTwhj0R76Nxwm+oTpi5quxRaQAjBPnSRlpiHawJD4qoB5F+oE88ZT7Dl6yXK5m1ZXXJyDIgnYBB8wZT3xnNqu8k73ENav4HDpBJPp3wmxA6gQSb+q61z3lVt1rN4h4gOWgPPzMb9alaQVZlrCSO4l61urswY8/dPmuzFcKJ29HQ9hC9xCnpwa0NjUK/TYOfL+xfoJAFuGKBHAzjquse6piaXj46Qz49lBElmk6+mfqY+k/HLDnf4sziV4c/zcdBR63D0iyA8Y90CeTpgwC9gTISCpcdBPlpX+tfzuYqnh+GaiE55yA==
Received: from CH0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:610:b3::10)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 16 Jun
 2025 14:15:06 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::5) by CH0PR03CA0035.outlook.office365.com
 (2603:10b6:610:b3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 14:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:15:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:14:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 07:14:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 07:14:50 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v6 00/12] net/mlx5e: Add support for devmem and io_uring TCP zero-copy
Date: Mon, 16 Jun 2025 17:14:29 +0300
Message-ID: <20250616141441.1243044-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: fcce2462-e528-45af-f0af-08ddace031b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rhn3cCsteRqtJm8sDqqvZ56Rz5/9uuneBmS/WqHyaEsIOmi4+mH0maIFpPk8?=
 =?us-ascii?Q?XOFIoiDrfvEVum8fPOSqwh44zBhAE6aKM2ZkIXUE9vt7Hxt9BRl9kNxZgBpN?=
 =?us-ascii?Q?B4fSlLba6sRh6KpsgIWHRy1i87jXYhkkOpe9flu8ITgms+80MEoE8932zl1c?=
 =?us-ascii?Q?+pkdFdoMj9ZjVqWo2dVESmqdS93gm2QMobsIgUk690VnKWxEHV2hZdnxXYF4?=
 =?us-ascii?Q?qECJ97shSD5a1AHUgLFDhmnL3lnHgR9n8Dfbv4FscL9lwi7uJqtE7uYW4H8t?=
 =?us-ascii?Q?X0YJCAloOarnr9zUneSwSDnlEKLx7unDZx79Mo5fi4asbhw03qE3cqs+pbt+?=
 =?us-ascii?Q?hC+uaQZBOFbfP07S/olZufhXSDGSoS8VnRd4aiOs3LC3+JywGQcQwT/rZUj5?=
 =?us-ascii?Q?WKu8PA2CacNP89CxflSPlyvLW6gMboPZPBRAd+9iiMg2XO4nVBLXcUPwHG3I?=
 =?us-ascii?Q?b4akh9qieb77t5zN5z0wAUEAzNQpG8OthWz5g8/hsuzU+PD+XfvOznyAiibf?=
 =?us-ascii?Q?FnT2Vf4Ltoen6OBDqkXIm1ynGUg3s3RN9IstwOtm6DWeM4J1a9YzKYqpz6FF?=
 =?us-ascii?Q?nbpSlQipM0+/WqM9kxVKk03hFM42Y3o0QXSh+177tx9B2SIoqEVh6qIvkvlk?=
 =?us-ascii?Q?n8fz/MW0+6wLouH/f6FxTDM86RiAMEMhoRc5h8H4+j18ANjYDnbclv6j54fj?=
 =?us-ascii?Q?w8RZuaA9p8Iltmwi9GtjMLVsXlnTzZFKHOt6S4cJRWWml49oMsiFRz1pOXGi?=
 =?us-ascii?Q?XLffUqCqNm6s51JFFdskmTUPpMR1icYZImOI1mbAYR8gFCBGAW63Y7QtMe+I?=
 =?us-ascii?Q?vx4KQDbSeeUes40q0GObOY65u/LtsgdvnK8l+Y5ShaH+cUhJ8ue0AFWg7Zv+?=
 =?us-ascii?Q?hnjbPhjzhAyuYrEmhOKIoCpd2h5V9all9LoBrhZE6H9Cm/8Yf2AB4krqaJ6V?=
 =?us-ascii?Q?l25OShvgM7RN6zv+IZAsbAyc+cifFQNg5xmq6oLHUDIXkfAClVVL4+8CyCxI?=
 =?us-ascii?Q?9IRvLBTqQ7T2YxjhvshflKWlA4AegDvtDd2kd/9aVsilmW0oyJB4/USqC43b?=
 =?us-ascii?Q?MEwi6PWnHtVHmG4OFG1AeufQM2O837jaVYWcmkEcsfGRJVL/Ps5L0STZ+XiD?=
 =?us-ascii?Q?A0sG6IjYVYV4/llM39x2oVJ20QW7oDQVt+w7ahiEnov596+tecyPwA9Gs0AD?=
 =?us-ascii?Q?P5dMxz+obHBhFQb26+F+ulpnUqo1X5FRudH9NpO8MmpT+6mK1qa7dHTqWd+P?=
 =?us-ascii?Q?66OxJADSVCJtQAuIcPcXNVY01WkkGMQNan+bu7VVtBnGdbBQQkiMwU2rNGA6?=
 =?us-ascii?Q?yRg8sxbBCHSNGnK1o8tfXmk+vUxYlPF52hjliIxBV4/ZR8ub2oc4xk/ylrQl?=
 =?us-ascii?Q?RHUe79a/28nG9jzM9bTYkvlC4isjRCJ/c8uqCj4kXNXazbb/6Vb2GtBgE/lh?=
 =?us-ascii?Q?upguXK3O1LiMzyz+ZZWK3gEbWBlvJswIgEC2UDq+DEQWtLUusv9NYC8BKtEf?=
 =?us-ascii?Q?PAzWCjYAZT1ZcjTU+nSjn1BmENRUjoxJchQh1jH0f5LL4ZzE3hEr2GWTsA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:15:06.2314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcce2462-e528-45af-f0af-08ddace031b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588

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
the rxq has a memory provider.

Then the driver is converted to use the netmem API and to allow support
for unreadable netmem page pool.

The queue management ops are implemented.

Finally, the tcp-data-split ring parameter is exposed.

Changelog
=========
Changes from v5 [5]:
- Added a TODO in mlx5e_queue_stop regarding queue restart.
- Added Reviewed-by tag.

Changes from v4 [4]:
- Addressed silly return before goto.
- Removed extraneous '\n' and used NL_SET_ERR_MSG_MOD.
- Removed unnecessary netmem_is_net_iov() check.
- Added comment for non HDS packets being dropped when unreadable memory
  is used.
- Added page_pool_dev_alloc_netmems() helper.
- Added Reviewed-by tags.

Changes from v3 [3]:
- Dropped ethtool stats for hd_page_pool.

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
[3] v3: https://lore.kernel.org/netdev/20250609145833.990793-1-mbloch@nvidia.com/
[4] v4: https://lore.kernel.org/all/20250610150950.1094376-1-mbloch@nvidia.com/
[5] v5: https://lore.kernel.org/netdev/20250612154648.1161201-1-mbloch@nvidia.com/

Dragos Tatulea (4):
  net: Allow const args for of page_to_netmem()
  net: Add skb_can_coalesce for netmem
  page_pool: Add page_pool_dev_alloc_netmems helper
  net/mlx5e: Add TX support for netmems

Saeed Mahameed (8):
  net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
  net/mlx5e: SHAMPO: Remove redundant params
  net/mlx5e: SHAMPO: Improve hw gro capability checking
  net/mlx5e: SHAMPO: Separate pool for headers
  net/mlx5e: Convert over to netmem
  net/mlx5e: Add support for UNREADABLE netmem page pools
  net/mlx5e: Implement queue mgmt ops and single channel swap
  net/mlx5e: Support ethtool tcp-data-split settings

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  11 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |  36 ++-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   3 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  33 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 306 +++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 138 ++++----
 include/linux/skbuff.h                        |  12 +-
 include/net/netmem.h                          |   2 +-
 include/net/page_pool/helpers.h               |   7 +
 9 files changed, 381 insertions(+), 167 deletions(-)


base-commit: 8909f5f4ecd551c2299b28e05254b77424c8c7dc
-- 
2.34.1


