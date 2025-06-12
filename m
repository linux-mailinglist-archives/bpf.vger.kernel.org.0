Return-Path: <bpf+bounces-60472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C604DAD76E9
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737EC1670E0
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF9B298CDD;
	Thu, 12 Jun 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dG2oYIip"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F29221DA8;
	Thu, 12 Jun 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743248; cv=fail; b=YdoWJrByYJeJDUFKxqWDmDlTTwOv3WE3jDtJ85TjBMcC0Ze4VoQh8IoV4/UZP2qh11cwIIu+6p8+3yaQJ5f5+LnCMQt8W3ul+FU6K2pE8fOlzA4X1EgNj6dOvRTQOfPUwUMwGqGK+za5er0ZRVMe/ZIpb169wum7r1L7NIVEgmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743248; c=relaxed/simple;
	bh=GALXUFl7RUTAAeEE+2l28qZHQozS6xYgEGx0he0mHQw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OXBEA8416FtCE44c3TWpuQfvX8AtRWx+UdODYvGRgAS9/hVXFRSEos7fJVBGZmNeeCe2XQkA3824szV5mH7x0PyJW8f++0q+udnoT+CIvfxh7dZ/q/mhmGDCaNJm02lyTKCjmbHmRThlsK2RRyH/HuIKCZ5YxkWnq+Buo+klsqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dG2oYIip; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhpGl8Cz62d9DBvYDYZUsl2NKHgptCgA3lj0p9gDlXprI4xEZAO3JF6V9J3CJDE7oLVvrafr/vwY9in+2TYkMrM+7gcPladqd+DHJz5Oi7F+w9OgW37I9iMDCnQalZDRYOqNQGK5pdG8kogEX6S4qrte+WaoxZpXMOz1GqyEjwfcRqW54aeEA2ufvSQ/wS6reel9DeEV665sYAzyeEcqhZOeYMQI94jJuSRWUCNuNXJRweJQsJbTzhMcYtfGFeNkSbGPEqldS4fdVOQ2AmBLyQSFWahNPK57K4HG1aGZ8FIROryICTItMSd5YKvCkF/Zn9YouBzE73G4Tw4IKx+BkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSS6W49pxUOPe7rSw3YFFK6OcjFWKMaD1P70xn/MWlg=;
 b=LI9dmBy4/elsLdFSvo9j5SvkvRq0lJ3kjkmabqZQKp+ao+rcfwaO7aFSwZQ7Etdjnuh/qFvYn+vf3xVqPCdJkI3wl9yo3hfzlUoIl13g4Y2R7CSYUZVR9bzvPTaqI3h6Vc7Ja8YmrOZuBySD7T8w8N6HfbpRUWvdmx5N+8zjsZgB7dRh9MzDomAxf2SYls0IJrJFwBENk/JiiseRo5IeiAzm/hWRdLI+xptB4N+6+flbCPESBKH2hzwSSy6OiUTtTOGUgnpN+dNFjQR67qhr8gLrnUO8XLgRbf5bjv6lkivCFeDmwaEBF0vEKL/7188u2PguW5GjAMPthO0peO/mMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSS6W49pxUOPe7rSw3YFFK6OcjFWKMaD1P70xn/MWlg=;
 b=dG2oYIiptu5p6YL9n3MyQ+S46X9USIDE7m8ZjC6O8TQZqf+UBIIFbuYG+miC6K6cZIT1U86VRiz4rPHeDhb/PbuRzgvAfc0r0CDE1Aq1eCrVbFC5dvziUu6ru4o6G3r0zANvOWJJoQr7/kw+evmvQIgzNBznm2NwUq9WNpm5yUgnlK3dMi3y97UNvCkuREzJh9OOv7K4XMlvKzU3/BQwsExtt3dVDsCCg4iWEpIqsHaMTL/gxPA7qTo5hff6JR6YNFe0s0MnUTeSyUm7CHRvGgFqrQBN5NtCVTcSAUqpCKmOBFApiv0nYEY7C6LP+4bswq4CyLijCiaDyMMAlV1C5w==
Received: from SA9PR13CA0146.namprd13.prod.outlook.com (2603:10b6:806:27::31)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Thu, 12 Jun
 2025 15:47:23 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::16) by SA9PR13CA0146.outlook.office365.com
 (2603:10b6:806:27::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Thu,
 12 Jun 2025 15:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:47:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 08:46:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 08:46:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 12
 Jun 2025 08:46:50 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v5 00/12] net/mlx5e: Add support for devmem and io_uring TCP zero-copy
Date: Thu, 12 Jun 2025 18:46:36 +0300
Message-ID: <20250612154648.1161201-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 0132be5f-ed72-47be-5e6e-08dda9c86c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tJxUj8gr8bvfhjsvPDn2dUm+YIEytEVk9iIb03DOpya5ZcXWk6hnVX00Q71O?=
 =?us-ascii?Q?ELEVR9Ti6Wx5EYQXMYgybL/X4/RucNtSJpl9uJvodmOqj98xtTyV7YxVhJI/?=
 =?us-ascii?Q?GIKLMJ/zrrlRcqyG1mhGtshx+Rw9APgsrX4AHftaG6QrrjNNSA6KniG/5kCO?=
 =?us-ascii?Q?2k8ObQHXsrX+/NJ/Nqbqkcf+NAXGhnaVMDA8iZ8Iwqk32f6IC8aDduISJUtd?=
 =?us-ascii?Q?aBxqHQYCRJ8KS6rtGqvluFHW1nvKGnYC6Gl1atGXa78BuE1XGKjalygtkdpw?=
 =?us-ascii?Q?2ujIK1ckbIZEOQM7Ia3x04R6KpMHCQL04INtW6prfVFZVPirzc9QshxADTFV?=
 =?us-ascii?Q?0+p6kYBw/QnCxvuXmZHmNmF6RWtjwpBH0YrYr1rg7CH1/8tXt1y3oh1Le+rU?=
 =?us-ascii?Q?DiiS4l4SK893V2PpwsrMJO8iTx7XldeUhbW+kcBw+CJcul6vxcRMcB3EpEj3?=
 =?us-ascii?Q?EQFHByoMZrSncw1wiW3FGwt9/2PDltepCqNbwu2oEySc9gLoIk2EPDiWYrK4?=
 =?us-ascii?Q?U76V6Gz4hjJ2j5suZufa1ofnQn5Q3xyxKBrcoPMvFiXHcol22I0+AyS+HiGP?=
 =?us-ascii?Q?FudJO8fExGnmPx7PnzQ4wFzA09ySYEVS5dS/cydndHPytx6nARYwBjZYxd7n?=
 =?us-ascii?Q?NVJR5plhxf2FSwpUFvqJECvaO3yCw5wR+jFjeqEL7X2F6HqQjNpz88ZM1e1Y?=
 =?us-ascii?Q?hUAgJ4ROYLptIB636Nm2/16sXVRXBL5XvLm/+rjwpfy3u3vH2j/h7jGHQ3by?=
 =?us-ascii?Q?rYklFpIlwcL5CDZBGAhUuptlOWkumBg0C9mbiWytBjXKDX1+fXnZwPAkfEDQ?=
 =?us-ascii?Q?TzlNlS9TFj9vK2dTxlBdQ8oK148FlkO2ixromW/sos5LZDsDUcM/UmzG84wh?=
 =?us-ascii?Q?8jBWqiSIiFn9mmWfeItOo1W+m/33FFI1BI0dvFacj/ggOM//mnaITItnQPY5?=
 =?us-ascii?Q?+ZSTL5LaA2TNtiAeeUh/WLKmDxz6/4VA9FEt1L7Avv/VnaE4aQlnQ9QR6LvF?=
 =?us-ascii?Q?dc7RCznz7HTbW9jhbCM1VuQGpYaDorFNgV7W/IQFTDz/CaXx6ABozL8u7OYi?=
 =?us-ascii?Q?3BeyYehz9JyNSYIMppgsJBICGvzZYxEJB5sgFAXFnbkbp5pxVF1Cb0VfoXOD?=
 =?us-ascii?Q?gOIoR7JJ4p/FuJtiBje+QWDm2djkGmfo5DQpqXz4Y15h9J5Y5aigD774bAhy?=
 =?us-ascii?Q?qQjJVhVfjhUNNNr1JqBI6yZug7t6zjMXZBXv2PPDsj0hoeRgmYIgqh42kBYm?=
 =?us-ascii?Q?0I4w9c4IQDyRrs6udcPM/QONwBThsQGY0FSmoPUKq8/AeT7FzsCisdurhWWn?=
 =?us-ascii?Q?hpLLizmTfUlOYX9duH3PueklBnfUdXKARlySfa34EU4zYG+IpvD1m8jC7T+a?=
 =?us-ascii?Q?MWgsp+LBmS0ZzW0nP8eM2/iV6/goZODBHskW/JObbHa3BbtfcNYoLLLP2TMn?=
 =?us-ascii?Q?thsKUXY/i8MgNXthVW5MtlaD2NlCO9Y9JPu9rLZUV6ifTMgT0Jb/BY1lS1BX?=
 =?us-ascii?Q?UcDIf8KkCy9/BTLgYyaOxsQj6T69OsEMwETXO1qiN3gbg1oR6Qvl3YSnlw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:47:22.5457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0132be5f-ed72-47be-5e6e-08dda9c86c03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180

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
[4] v4: https://lore.kernel.org/all/20250610150950.1094376-1-mbloch@nvidia.com

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
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 303 +++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 138 ++++----
 include/linux/skbuff.h                        |  12 +-
 include/net/netmem.h                          |   2 +-
 include/net/page_pool/helpers.h               |   7 +
 9 files changed, 378 insertions(+), 167 deletions(-)


base-commit: 5d6d67c4cb10a4b4d3ae35758d5eeed6239afdc8
-- 
2.34.1


