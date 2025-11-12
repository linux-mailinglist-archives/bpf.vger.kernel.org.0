Return-Path: <bpf+bounces-74277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6968CC515C2
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 10:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F161899680
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 09:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD9B2FDC27;
	Wed, 12 Nov 2025 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gjl8moLe"
X-Original-To: bpf@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C322D7DC2;
	Wed, 12 Nov 2025 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939883; cv=fail; b=q8a5QgQ++GzLDosZEpF/ZdcBXleVenCgpIVD71Eu8JeeJAfY2RFQ4DjZ4AGyx5GXbEUdXVEwlnL0AyUNjxeDdD00B+g9LfM5L8OcJ/rukf/9Qk5GttwvwgIBvqzOk6+XH3k1G3c9c7gLBgRv7A4bj35Dfb+fFr9rrDLP7KI9XZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939883; c=relaxed/simple;
	bh=25ckMqG2RLE3mi9wBeW6arORAzk98FzDcWlS/cBdbiI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zu4ZabECst4C7sCzU2EBfm8osMF22KNg/NmezP8ipPZSEXyVeVjSGDJA4HKj6LKv3NodKWEdePGQJ5yXFUl8lvmCbR9cJZn7FcVIdk6/SHOdf4Jy/kyU1/xw79ObqBP1VcyjbyKxEt2HnZZfmBo5EGtJNPKNz+tPs5yKqTXsifY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gjl8moLe; arc=fail smtp.client-ip=52.101.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coZz5UFAv6jLTZNpm/nhgyd7CXVjk6IVY1rZmT8gvUP+fBfg8JCQiIlrtl9P1FOKnHHKAYR3Ql4stCyP2kWAgTV66Sg91C8UP7AjeAwiLh2+yQhtDjguORoZu5SHRNYtTP3xUEyrtBGr/J2s7qr9yIqEvwyBsER05Axftqki7oEPnxP02BPWIjLIk3jRFEWfoTEk6SVNDHogaWoaAg1hUXmojvz+0/bDnlvwZlYTJdPmJ6Uma3d65fgwlb+xI+U4U6vZ6SPGU1BgjR4YKe1vtwtj4iaOl+CKwiYm/syYIU7hC3FXzgY4av+19eExxzS+6TfShYT734zHOJYc4KTfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ1eBrYYwS9kZJdJfFGsDrS328iRq2ylyubrFcijpzA=;
 b=TC0jzXD+2P1xv5p8AgompQKX2q9vFwYGo3KhpgFZND1nhALWZ7vOz5JM7AEVVU92EY3wE28j+j0K4r6QNmwQ/fS5hUM2MfCLo8h2pKzUs731j5FzKJWicoeBVtVz4rD20haIMdtloIaLkY/yUMme2dBJ/HAiJWE/bWE5mmMkL4M6fUgUvWl49MHcSI5h51S184nsK/TQI60aAiPdHYFsmGFKlHUT7r91IQ7b9JW0G7kf8R8depuuoy+BZJtfy+V58rU0Ks3Lp3fK5uTmMik38qoF5ScLieU97F1ApX+Ap9nHegRwIbTULvyJMVVLq9OR+NpmC0dzBbr8gUCKblxKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ1eBrYYwS9kZJdJfFGsDrS328iRq2ylyubrFcijpzA=;
 b=gjl8moLeMGca4vzjeVHHJVKxDIhCieoqQUYTjyqfwlgJb/O/l1khJ4MhEutZBIdVZqRdHVTOhNm4yPufaBGZzn/7QMk9tCPcE6xOkJKt+KwKnFkso0oapnCaoCdZjAW36uoc9CEZUUWasiioMplrPnlH0sDnjECylDv4zPZG/LG/LFhJUhDyI3qdXsZp4pjZSyF6YjD6HAIXCqPDfKih7HpiyMWB/qkykjxjp+vLBfNhME1MKIex5onVkDDwZcdFkRF39zEUIaCfAsfufu7sKfoobhs4KchJT8As8Vj71LyUBBCgYCAKMctiJwmfHdC0M1oEkon7jC0pXZtPfR2lig==
Received: from SN7PR04CA0071.namprd04.prod.outlook.com (2603:10b6:806:121::16)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 09:31:17 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::90) by SN7PR04CA0071.outlook.office365.com
 (2603:10b6:806:121::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 09:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 09:31:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:00 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:30:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 12
 Nov 2025 01:30:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, William Tu
	<witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
Subject: [PATCH net-next 0/6] net/mlx5e: Speedup channel configuration operations
Date: Wed, 12 Nov 2025 11:29:03 +0200
Message-ID: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 279227b7-30bf-4e13-ba12-08de21ce3b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bsdNfMAoPxCkTC1DU6F26wrvahSFTuLMc5ojK7mHUlTY1cV19HUTBxs0jFsi?=
 =?us-ascii?Q?oY805EVm1EF0iYoc2MyH37/cDNrwPB7MvWcz+UfGINM5nCOIKBkzkvw606l6?=
 =?us-ascii?Q?PTeoKn0wNrDkp7WCYOWbdaTxK2iDda1vr6CajhfNOOFuOnxc4EPOnoVGSzEF?=
 =?us-ascii?Q?LsxNWsjoSpSsyDN9rYYBkpBRR3a1IhcWqxkdV3340+6p1xgzh5M2m+FZC0Ds?=
 =?us-ascii?Q?AFry9T4cZjyS/55rQsUnUHTVAo9VC44mIjYlQ+AlfEd6c6CSw5eIZn5TacZB?=
 =?us-ascii?Q?4g7HSAl+pQrsCdN/CezwKsM24S030YTWHsg9sgKxOhn/irqiMMv9pUfARN3x?=
 =?us-ascii?Q?molNl+Ig36OSwafJ7yxr1v9gHEbdw8/N12Fgv30SEwwoHtfCyybO3fZVkQyk?=
 =?us-ascii?Q?0krLEYzANpBPkYnV48SALvoMEyVhOG6XacOe+j2NSD0FyDafSCNJgDGqY3zf?=
 =?us-ascii?Q?RI5bRqLwQkiu1DL9CjVuO7/sCe1XeqD8sf3OCCPxck4B6k3d3Y24sYejKhlz?=
 =?us-ascii?Q?8gWfkWiumiY4prvVLBt6QUVJWk0SS5aYZ2UF9b95DR6jcFAnCidlV9fIhccn?=
 =?us-ascii?Q?QrFpJ6DaIjzG85OXFU2+rPGEKO1qfVczXioLJwrAyzLFtlO3zGrzI8vNpO3A?=
 =?us-ascii?Q?DzwO8z0osd/GGyFHGGDqeFHmyDu3U5C5OkuBc4gI0c+J65Rb2+aM9btSx5VJ?=
 =?us-ascii?Q?z0PegohF6qpSuscsTyXsnqU9eV72pQ5lgG+uuFfZ+hvkj1sW+NHKV5TGVvWJ?=
 =?us-ascii?Q?PpFmZnWVgxPexgEB9xqF346myTQC4v3NT0Kt8WKUXBtR0JSk2HXgOTZenelU?=
 =?us-ascii?Q?XtadFpeYV4IR8b5dNkqOXl7UgpJxtDi3pa7Cyg9MFMYtYet47UCxj5uc6gv3?=
 =?us-ascii?Q?qC89RS8tbTvdwVtHuniU+Kwy+iCoqS7oG1y+pOGpET7vjwx1O2aj3dtNz5F1?=
 =?us-ascii?Q?bL6c2TsFzynF3LfxcBr/5ER+WvNYMEWGKgKPRzFdKBV/x9Q45GCr5nf70Bqa?=
 =?us-ascii?Q?pxSlxS67bNLdtXPKJUry4AllIK+0tqC5ubvA+2AEdun9MnpnXzW7zEGPjLoX?=
 =?us-ascii?Q?ESqqitbYKZwfr3F3AxVZzYBOCql4MwF8Xl1xxWH50sCw3GpykT2oylcmnIfj?=
 =?us-ascii?Q?XRVdukqBpDxfhFwrsFBuSUb/kjFPJsO50yHfLga/XJ0kcgxQkb2sY3fHysCu?=
 =?us-ascii?Q?WRzsAvh1SFdU+f0XDERP40hhXsSLRwPkTOTeUhNmPAL5cydB5WLJRIcM5jxz?=
 =?us-ascii?Q?cesl4BAXzg+3JCKMrZ+N7cT7WcOaNSMTSN1W4l8YPJLgWRkdmv4q7Ei5UKV0?=
 =?us-ascii?Q?BuiPIn3ueUGbr6YxepODSrfOfy3HBQ7boo4jSamqulWw9V8TWovQ5kOO5TOx?=
 =?us-ascii?Q?Q+8L8EYELeRAgO5liG74wYxl3fM+5TMY7f4hyPq2mWVISn53of25epfIZrXt?=
 =?us-ascii?Q?H4Pvo7xMCDNZmpNC7G9nCyiXTxBrOc6aVcs7wALVMbyGFWQ/qpegrcJMuUYa?=
 =?us-ascii?Q?1MGHUxALo0xc9VC1HV3KiBSCS9OlCm4EOmvVpKGKWLxZTAcD0MmkLcAty0Ro?=
 =?us-ascii?Q?kYQ3f6II7sU4/ZWiwHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:31:17.1955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 279227b7-30bf-4e13-ba12-08de21ce3b33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656

Hi,

This series significantly improves the latency of channel configuration
operations, like interface up (create channels), interface down (destroy
channels), and channels reconfiguration (create new set, destroy old
one).

This is achieved by dropping reducing the default number of SQs in a
channel from 4 down to 2.

The first four patches by William do the needed refactoring to avoid
using the async ICOSQ in default.

The following two patches by me remove the egress xdp-redirect SQ by
default. It can still be created by loading a dummy XDP program.

The two remaining default SQs per channel:
1 TXQ SQ (for traffic), and 1 ICOSQ (for internal communication
operations with the device).

Perf numbers:
NIC: Connect-X7.
Setup: 248 channels.

Interface up + down:

Before:		2.605 secs
Patch 4:	2.246 secs (1.16x faster)
Patch 6:	1.798 secs (1.25x faster)

Overall: 1.45x faster in our example.

Regards,
Tariq

Tariq Toukan (2):
  net/mlx5e: Update XDP features in switch channels
  net/mlx5e: Support XDP target xmit with dummy program

William Tu (4):
  net/mlx5e: Move async ICOSQ lock into ICOSQ struct
  net/mlx5e: Use regular ICOSQ for triggering NAPI
  net/mlx5e: Move async ICOSQ to dynamic allocation
  net/mlx5e: Conditionally create async ICOSQ

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  49 ++++++-
 .../mellanox/mlx5/core/en/reporter_tx.c       |   1 +
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |   3 +
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |   6 +-
 .../mellanox/mlx5/core/en_accel/ktls.c        |  10 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  26 ++--
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |   4 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  10 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 137 ++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   3 +
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |   8 +-
 12 files changed, 179 insertions(+), 80 deletions(-)


base-commit: 8da7bea7db692e786165b71729fb68b7ff65ee56
-- 
2.31.1


