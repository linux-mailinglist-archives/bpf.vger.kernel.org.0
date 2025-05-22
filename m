Return-Path: <bpf+bounces-58758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE2AC15FF
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538C51BA2D32
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC66257AF9;
	Thu, 22 May 2025 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ppd+SSV+"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17945257442;
	Thu, 22 May 2025 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950147; cv=fail; b=czlthvuKouc0Yj/MO47xpRwCEZM6J6jkdyz8uttOh8ZdfH2mL2Mr/5o1cEbJXgJXRsH6+ju+tSMjDaWCZe/4EoGHzEBr2Jy5lE3iyOe34xd/6I6A1Hh7kCC3mDmOnXJR4LLevkBQ87IEzPCVlMWYj8+LCXjdTru76vobljrF21o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950147; c=relaxed/simple;
	bh=S7cLc0r755iCaXOjBqRO5HznQQIgcZaNi918RI+3mq0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gwOMGY0cHlHvqNvfv9AZsOOwLaAQamy+zlnr5GOqaBm1V7yRbUN01KNP8rkGrMa2t3nAm8l20OanGWNztl5po5XvGwogcP8ylXrvaLTVkvgMIp2tM7VST8GwvPBnMeBWDG1vYLbKyw/kDL1i5ieQXetAciez44S+IYXZDR8h1HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ppd+SSV+; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLSx/DqyydddjNgEku5vGe+xySWfxn+n/3+PzyX0bQOz5ABFVoFxnz8mrGg0XlzRXfoGB7sybP+R2Lc/gOmrf3eXwlupQdkQTP1+mll+4X3J4KlJ6qu95fbWSzsGCLH6yvpLXZs6WSvkePh2IorO0s/hL3oeQRwFSjMWKu4bG7/ltrFJN191AKKTrdnvjCnOxgoYyGck9qShxGK7q5tJvmgIfWMR6s/X+PjGNwxd0j2boWsxLaNCPQS9ddBfsC6W/tCMNagrMIj3PIea9gpAsV0TCfLHn/eXb6RmxvOBWRf62ZjoiLFMJgvcWoVLMShj9wC5qq/kHS1ZUM7WiyO2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N323ayZHRB6ANaj0TtWd0756vNCC3nmaZPrAdM2fsE=;
 b=o6FUMZr+2D06D2uZdBqUqPQMT7qHqIoVQfgq7s0CsLYMFlMG4xpVgZR4d0qVinILHuRInFQCbxxmBSY2wbOJAc29ym4iqv9In2/AG+mk7oIpNrzILpIO84ZrDbduILAjhvfWC5foopw/OmFYzcsBGuTqSdX6qz3iyvsbrWo0Sj/s5TY5ht9SM96SK0ALHsfG8DFgZuadYeQM6WtWmpS8pOp5uRdU3f5sdTQql9MoJV84vVux0PeaNXJ70eKRuQYIJ52cQOWWBDqRH3KYrWlaDb1RBa8pCd/vWkI+PGao449+PYsx3CakvQQBTrwOQzrNdefNjb/XdBCwx2SnNmsgcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8N323ayZHRB6ANaj0TtWd0756vNCC3nmaZPrAdM2fsE=;
 b=ppd+SSV+FXeN+WNn9VXpG0E20zEzXTyiOlcbCHj+IWi/ET+q8Sl716wsyZAynX/7X9PGW+0H5dNk0sDrB/0Glgw9+ugedXTFQXA4Bojcwa/S1QPrr39ql0ExAgh6tDT75WPrzndVt2HtfFXziQmD+h/PK9s4VF/ucV7Wu0vWaLatct20XxsCP4d+deIkir9ofTPo7qfltVZrUOQsAo6gbZNJDN+Z3M5QvUNaFPEFNtkywuAjkntb6A7Om0UWOQd6i8SVGSDvRw5ifxit3kqsx161g2ydETh6aInE0oHdukAY4A53bOaZ3uJ12zFUUGgtmcTbSVGSalE9QyKUG3zjYQ==
Received: from DS7P220CA0052.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::32) by
 PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 21:42:23 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::f0) by DS7P220CA0052.outlook.office365.com
 (2603:10b6:8:224::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 21:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:42:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 14:42:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 14:42:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 14:42:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 00/11] net/mlx5e: Add support for devmem and io_uring TCP zero-copy
Date: Fri, 23 May 2025 00:41:15 +0300
Message-ID: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b49cde-ff4e-4b5f-c621-08dd997988d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kyWkyFqRGkl/ji/r7YQUe3vhv6iV9bmK0wECZBdhF4pxkNEyO7q1TjjwpqMV?=
 =?us-ascii?Q?uFonYjpS6p0yQwK9ZU829O+4udoa1BdxFXFP/EqFdv5+PMsjS0CDyFJataSz?=
 =?us-ascii?Q?QfK0G2nqCSQcEzdVNmE2OE/7LmO31fq8s9+wCG/lMF3hzfWPn8ITUOsMYIME?=
 =?us-ascii?Q?2kKcSf9czjZN6h1+9gdkG3WAyaYc28TtNxaiJg+6Pb0mV/u5ygT+KEAafyxH?=
 =?us-ascii?Q?E5pdBgADvPbJYS9nQwdPQ1xNI2Mb6VWhctDuVgjdXeIvJ4Hwu5+RWXYpTO7b?=
 =?us-ascii?Q?vHvAbcjw2tFtxTsaffxgPdLzcm+aZinSPkhB7slT+EUjExnM/ldaeCabKljO?=
 =?us-ascii?Q?TJ6FwMVkUw3BfEmHpKjGvZUQZ/GgQghhAUZzkF+6NeU3p6SWan0gH4a1pc2B?=
 =?us-ascii?Q?r1ouj7VVHvLfvHVqgMwSZHAjw63lmQhOwoE4O6sghvQcAJGW+4lxxMGh+BKf?=
 =?us-ascii?Q?+OLLuKQD2W/INt8VeE61AOH/sVItat77J7qaoDwjUxGGzwMNqKgAzK4AzYMO?=
 =?us-ascii?Q?RThHb1lzkd/IdeEIJfVLcmRYfE4NYj6wsSZ6kfDR2FKoPhTAFRERYdn2DtIQ?=
 =?us-ascii?Q?0fOG43QHtb1WiwU2lVwyNLscDurRIUBx2wqkpr4dTODgewWAAXRbA/4T1J5y?=
 =?us-ascii?Q?OZuYyEZe/fe9HmjrQqenGs1YLegqXkkay4uoX0goKahRvPIAQKsRr34fv4CZ?=
 =?us-ascii?Q?LtNI3MdmgcaGmdURACAmbGq7lBW7cPYp1fp8pfFwLgLVCGN1+iS0yd6sw0IT?=
 =?us-ascii?Q?QgD9Hz1xCRuvhAxWWKAWj9BAaso1wBl5Oq9pH6P7k8cRr18QRFsscNbpZ4vO?=
 =?us-ascii?Q?s7Ha2H1gvLhh/JztqVhPYm1Uw2nOinoH6pc+ZSGhCd4tqgiRmdFJYfnMYZSG?=
 =?us-ascii?Q?xQTfxEvyqdBcJhNXphkqDB0lZHIrCoTVqfS19o3QlB+DWf5WOyyzrw3B2jA7?=
 =?us-ascii?Q?VWP+HUAAV46NWfVBv7lMbfgSDIYKp0+3Yuk+/tKUERCqYyjbBjBssOBYY4xg?=
 =?us-ascii?Q?apSHkrjAiE/y26R6djDjOXAwRC39Mrm+WlokSBLa9qreO7Ns1U8jm4hAVR8i?=
 =?us-ascii?Q?of6nVxFX4Jhw11NeVmfwA3Q7oljh5QQLfLaPYQSGSeAMo4eCFFzLNgHDZKk1?=
 =?us-ascii?Q?Mcxvf3HbTRqmUWvexlNeBzwByt3WuZFnT8mt1ZAjyxsfZWzsIzzqfjeGJoe8?=
 =?us-ascii?Q?mFDJaq1sgKasPg8mBwEB7xcqS6dfFE+5ANlpFAMQVZ0VwkMkbNdo7TkxeArd?=
 =?us-ascii?Q?rLg8F/XgXWhoEswtve1IyouQDT25wETAFSJXTcacGR65/P6rEqQkCtAPXwhY?=
 =?us-ascii?Q?2Z8ccX3MrJMlg60sHmgquOYdmEDp4eziwa8QYTHX556eOFIxF4ViEyb+bBXe?=
 =?us-ascii?Q?AtLOMKtwsh9ePQahOyysSJDKl3vC6GC/e2AVIrwT+AQTJz3Woyqu3SxK4bNE?=
 =?us-ascii?Q?Vht/U2R1QUGp5eKdMN5tqIp10mH4Zqa09+YHRFm5zD/mkOD2l/47+sIVBzJA?=
 =?us-ascii?Q?RjvJbFUUK7a+XmwZhavZQtPG+Zd16vDPdwps5Ln1/1z1aT7l1Ync3Qk53A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:42:22.0710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b49cde-ff4e-4b5f-c621-08dd997988d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736

This series from the team adds support for zerocopy rx TCP with devmem
and io_uring for ConnectX7 NICs and above. For performance reasons and
simplicity HW-GRO will also be turned on when header-data split mode is
on.

Find more details below.

Regards,
Tariq

Performance
===========

Test setup:

* CPU: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz (single NUMA)
* NIC: ConnectX7
* Benchmarking tool: kperf [1]
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

A separate page_pool is introduced for headers. Ethtool stats are added
as well.

Then the driver is converted to use the netmem API and to allow support
for unreadable netmem page pool.

The queue management ops are implemented.

Finally, the tcp-data-split ring parameter is exposed.

Changelog
=========

Changes from v1 [0]:
- Added support for skb_can_coalesce_netmem().
- Avoid netmem_to_page() casts in the driver.
- Fixed code to abide 80 char limit with some exceptions to avoid
code churn.

References
==========

[0] v1: https://lore.kernel.org/all/20250116215530.158886-1-saeed@kernel.org/
[1] kperf: git://git.kernel.dk/kperf.git


Dragos Tatulea (1):
  net: Add skb_can_coalesce for netmem

Saeed Mahameed (10):
  net: Kconfig NET_DEVMEM selects GENERIC_ALLOCATOR
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
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  50 ++++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 281 +++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 136 +++++----
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  53 ++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  24 ++
 include/linux/skbuff.h                        |  12 +
 net/Kconfig                                   |   2 +-
 9 files changed, 445 insertions(+), 160 deletions(-)


base-commit: 33e1b1b3991ba8c0d02b2324a582e084272205d6
-- 
2.31.1


