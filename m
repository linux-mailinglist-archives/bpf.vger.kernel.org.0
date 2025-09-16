Return-Path: <bpf+bounces-68507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C83B598FF
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8497A4AC0
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B5313E39;
	Tue, 16 Sep 2025 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fuaQglAd"
X-Original-To: bpf@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB52673B7;
	Tue, 16 Sep 2025 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031958; cv=fail; b=SPZ/eEU3lyKaWkiKylFOM8iY1WqVaneCiEEXcrJ7MhMouf81WzCvY1vr/0mLEllPBxNenoKx57tHQ+1E6o5Pg3AkRBxB0y+35mPq22KjgxZ+hNnTh8VYJ4W2dhMmA+oPPUxcco3MyKYttQuOYbMPfuZhClome5TfA01vH5WZ/FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031958; c=relaxed/simple;
	bh=X1tbeH32HXzCSiVuwfBe5Hau/Hi4kuFQRpqzKxx8xA4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=klsZUOYutx78E7o1VGrFl/yE+iV+SyUxehRNJA7wl7Q8s05tV2J5611A8OakxcTkTDuggh64iRdweMqJlDpANcTlSlkXfGSWYm89SA/qlkO5hhh0Q1Lpv+UuVSnuWpEBI5or4vSpHr7q3w4bvm23tBqq9JVd1Gm7ZacKHDorQGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fuaQglAd; arc=fail smtp.client-ip=40.107.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cp3UPWRC83WDPUuE0C+xhV9zYEvMH18mCz+pf0FKumHGrnLzxluc8fosXfkzhhqnyrHJkzRdR2s2p8tYI95sQb4OHW6+FYuGnianPElAcJvDl7LPKBeTJmWsffkYoX+pTNSB3/B8x18HoOFoFlcQrV5O1V5OV0vSfe+XtKr1Klqg4AI0cktbCL3Ax27eWunrlue2lZIPEPvSqdQ9ap16gIER1MY6BF+XfQLqr/hIo5hH6QwJwn05cm8I5s0s1uDiAof10p70aWtWC3qXMo17Gza8k5VyXBCf4VsMzaglmD5uCfnjjL+fWnzhx3gjvsuEYhDzOLY1I1iPa3z6hlK7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8RexWfeUqxmP09NFvc1bYGlwFWURDkjWW+VwzDSF64=;
 b=ZpNc9kdmqOevbUiqGiiuGcB68j57lp9YLr9BwddI3QkQ8Lk6Tyn51MIVHtDvIsaarqhZo7rLanTnko9q3OuEFw4ANpLAvEiw9NsNYXOncwo7DfFX/DvG6BI3toFYy+N6VSsTS7gvBLX7CvKEE+QYhrwyWLhzcwafSHDGSMDaEDb75j6tE6XPf2WrWuPOyyH9kYSNMFiiBYoptJPMgiauxyUoGt8CL4RRBNRLBnK7MaFeHsv6FsWCdzNEyeDbLJASW1CHOH1o3yt152ergNkyq/ExeFnK/9lvVAlZKoIcNZIMjcIDTdRlRQvvuQSYBScLkTTeUjP7N7DTDE3z+TEnlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8RexWfeUqxmP09NFvc1bYGlwFWURDkjWW+VwzDSF64=;
 b=fuaQglAdZexv+cGeNMwRyVScCi3ppKNPJ4EwdphYQBdMpDIzpx6kbmw+o9D9Uu6DxBZwZNRA+1EmFouBSNMBWmOiY4KV9Y6U7hDNbPrtDDguL5yWcmdU6LRkOvU8YW1o7DwQkxg4oVUDH5JydZY8gig68o5ExlWPJlwzrbu95k17HCVq9ke+/h/MnoNoIv+ulhgmnS69cvECwrEJZaFpmEU+7fncieWC+x/Cz+b+V9hKz+x0vhQGwEmS7vhAup9QSm9yzUAWxVLWB2po7tAwG97rHKgDBoqVkYsEIzdOR9DKLILFZcDlBMQ6IV3L8pbeKwB3uyy4opXOmE/WaOZsKg==
Received: from SA9PR11CA0021.namprd11.prod.outlook.com (2603:10b6:806:6e::26)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:12:33 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:6e:cafe::89) by SA9PR11CA0021.outlook.office365.com
 (2603:10b6:806:6e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 14:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 14:12:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 16
 Sep 2025 07:12:03 -0700
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
Subject: [PATCH net-next V2 00/10] net/mlx5e: Use multiple doorbells
Date: Tue, 16 Sep 2025 17:11:34 +0300
Message-ID: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e344d9d-e4c5-4f03-f997-08ddf52b1485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ac6Qes4BT0InlNZALTujHDCI4XN5QbxI1EdzhR+GhITqaYiscbZ1DEI8bKh2?=
 =?us-ascii?Q?19vvk+VtibTdao+SaosN7Cqr5HlHV7JyXwQh4NRzXlBFcLQ7XLVorUsjxQ9f?=
 =?us-ascii?Q?G8AkXQyDj82ytkRWaK0qlx6tjmKb6fL3XWUelG2r+HrRvHBXAFgNl8VJvfah?=
 =?us-ascii?Q?XRlYWQickmWapAmAtTJLlynKpkbAgpUf/aG5ZvWw9YHFMSZp/FI+yW6igTAe?=
 =?us-ascii?Q?nYcjSP91/VT4SY+kfuMnCPNZfRf6S+p0SZJPc5+efK5CKwidZWchPchLBZCV?=
 =?us-ascii?Q?ODOcWjBEUzrHk8rA0co1F8U4iJc1Sfm4P0B1Tls7Tl7TWgJbqoKieTepamBG?=
 =?us-ascii?Q?pLmCDB3uxlZv/mPqqYyVlP2aFDp7ccGY8q2ZSXytyATn3dE/d2PJoigC6Ori?=
 =?us-ascii?Q?KOflyROkE+3GEmiBJ73Fq1lzL15v43R5NhVy3HMGJG9IJqvdWnK8mX6wckmJ?=
 =?us-ascii?Q?EGp6EiwWjmAtbt3I9h2nPwTk/jVsp+G2KZ+8ASsDWnfaKE37MViotWm+MTFa?=
 =?us-ascii?Q?m5frSTtWrBiR8sqN9RWBQorEQ7GwJ8pJOeDlE0Zjqt4GJ3JW8KkWMH9ioxR/?=
 =?us-ascii?Q?tbSQnJ6zYs6Dn+xPHtGk7xHOVsoqR1jxrnlaagUdjNwVQrboZP/Osq0AukSX?=
 =?us-ascii?Q?gRJ8ra+HGi62hCghm0h8x9fwPpqWQ18J+CtK2C90UVD9RVVmzOywjmLZt+57?=
 =?us-ascii?Q?87rQWnZDIzAr9ar0WHnqsH/B3ftgMWnaObgKkfyeojb726Oq+qlV80dhekXU?=
 =?us-ascii?Q?IFnuhSR9/9Mp+UQ9vC9fljp/LFylUu3h/WwvYiniy4lMpi8/vu6rn9+cicch?=
 =?us-ascii?Q?fcyGOuFD6I0213WMpWX+/dlUH0n6/lVhZqact8S4MR0Ak84ZavfhM4PUSO1s?=
 =?us-ascii?Q?5aLeK65ff+lcUUWF6bw2VW//4iyz+yyCiBx2bJ2dZ3TgW+AgnRq5M1VeO4DE?=
 =?us-ascii?Q?nCRFRdhCh1wk9G/X2OseD2y2gceD7BP9069ebRMh29rHD3nAiRvgi7wl9o4F?=
 =?us-ascii?Q?23+yuPJj5xr5btZks+BLKr4ybuIv+jr1f8hZmcy9kDVsdLyEAJn0Vtp/IYCF?=
 =?us-ascii?Q?R2EEQlIi4iX2p0orf9Jkx20Z5PCfWQpN7+8aD1XYfr+GSWsgsDMOlWbaqr99?=
 =?us-ascii?Q?M/es2zqNrhhl1AXdd4L/IUEEaIVFpdRk1ZUJBlk035tZoKlCMEQ+czDYV+V6?=
 =?us-ascii?Q?EJ9GbOV02GHcoST9pNSEb30zJB9Cg/JOX1eWQQmAVlamwo2xvXnNzDDkqDmf?=
 =?us-ascii?Q?xfJTJqd1krxSlBP3HJMkL/rpVsWN+dWSYm/F6/Pcvh4wvKyGZQKs2HiRAWzV?=
 =?us-ascii?Q?RBu3jBah7zYSTTXHulGcQ0Ggm78KEY5wOtIi63MYYbcUqmlWZEmuedFF8+Za?=
 =?us-ascii?Q?WSyha4UfPBXuhOLHG4TNKeffiNi4Ob3nFZfLkjADNXLB2Jaye2L41N7OBw+k?=
 =?us-ascii?Q?6OCy8tmfMNTjkI2T+qitKcsjVf81SHCUeAYuHUe3b+oNIwMCDYSFWQaxIV0u?=
 =?us-ascii?Q?tnYjaP1V8kYAI2uxLgtc74ti2J7NLdibPz4O8cKgpNKYCRKOAfoonFXqtg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:12:33.2287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e344d9d-e4c5-4f03-f997-08ddf52b1485
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

Hi,

This series by Cosmin adds multiple doorbells usage in mlx5e driver.
See detailed description by Cosmin below [1].

Find V1 here:
https://lore.kernel.org/all/1757499891-596641-1-git-send-email-tariqt@nvidia.com/

Regards,
Tariq

V1->V2:
- added numbers to cover letter.
- fixed mlx5.rst nested list error.
- removed newline from NL_SET_ERR_MSG_FMT_MOD.

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

Some performance results, done with the Linux pktgen script, running b2b
over Connect-X 8 NICs:
samples/pktgen/pktgen_sample02_multiqueue.sh -i $NIC -s 64 -d $DST_IP \
  -m $MAC -t 64

Baseline (1 doorbell): 9 Mpps
This series (8 doorbells): 56 Mpps

Note that pktgen without 'burst' rings the doorbell after every packet,
while real packet TX using NAPI usually batches multiple pending packets
with the xmit_more mechanism. So this is in essence a micro-benchmark
showcasing the improvement of using multiple doorbells on platforms
affected by MMIO contention. Real life traffic usually sees little
movement either way.


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
 Documentation/networking/devlink/mlx5.rst     |  9 ++++
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
 26 files changed, 163 insertions(+), 59 deletions(-)


base-commit: a4ab91f470c5c84ce0c17197c1562d29aa032340
-- 
2.31.1


