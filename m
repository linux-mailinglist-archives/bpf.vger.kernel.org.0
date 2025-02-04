Return-Path: <bpf+bounces-50394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A55A26FCB
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD8918874E2
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1089320B213;
	Tue,  4 Feb 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SS+8Gr1e"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05E16B3A1;
	Tue,  4 Feb 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667185; cv=fail; b=gwL+CKsjlYbAnKmxre+ju3+AhRQWAVvLKECGR044XEUxeUsiKrdOzbaCTM3QC5n6qSJTI/9IkeuzqAqJy2Q0t9dthb/mPnGu08NID73VChqYfFeWKQii12bzYa+wXY1AgL+PHGfF01Wv+uFy8tlUCRkxqMV0k3j85KimtFUhI6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667185; c=relaxed/simple;
	bh=RwxOwCIROrWc/clstMjAqr7QpTqFb13LtnFGYX/vcqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A3icokP9iP6GSfKAPlikFHyJMY0KA5IWysa/PbjcAVUPnRznqpjqZDHM5X9mSgz2X9yZqop5ncJJ0hUsw1NACO7zs9EDieQOn1O1MU5PS3AFAVJfoUSUb18510kzAOmTcD8b3ahxo4xlSK9g0aUZs2wACZsWqoyKvyb83wNJNu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SS+8Gr1e; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+V6g7Q8VCQHqWQ6+npB39YWbsMsrIXzWM29qJT/w146z3b2eZk7qvPaMdzo8288RIIg1qc/AOmxYAh/QALWLWY8HjcoYRMkOTBsMhc1otUQU13aG5f391J798l8eOiRJRzcUMA/4WjVVT57LC8aZDIT+11A+MjhAXYgvADgVOIBYVUIUQYHhL0ILXVwZ5hcMTz8uy/r9oATwoh4hoa4HFT5hCe65u0Dx5WDMTzDYACDv9p86ERL1m6ZbrCr5K0JIyua/pV18aeJ+Z39LqikzSdS3l9IWClx2qLQMsvc6QjJF0818hH+W9KannaRImfNQzJa7namrZde6qxBGAz5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVXqqSX5RpR3BMkDgQnSsC32glGL10MuGDATn43BX8o=;
 b=s+5T30ExB6cxECkeS0TuPvUl/rQna7NjUSqC8MfHzVD/1A24Q5MYPxwTiwgr/GgCrCy5hPkeMNbRnmvlGqMtK/dHXclUjClnEa4fnt+K7UDuLVuL4D2gZ2OyBhPwlgFQX8k1jq+iT87zrGWtYiEkhDebiGWxEOe+U7bkH9JleUCwma9GTPDcsJQURidsjnOvQeLFXpK1x4jQZfa1cvtaWZQgknXw0UgrVI8gbVeoJZKCPNo3l5Rg8bCeKjEJAaDwTPlGmSbMNeWbz6Ke6BbCfpP/kBrQd0TpnlIzEgYZpsANKxyTK15/8kfZb7QXb7uo69g2IxAKOKVTOy1E1hW3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVXqqSX5RpR3BMkDgQnSsC32glGL10MuGDATn43BX8o=;
 b=SS+8Gr1e8paUfvuSjDcZDw+untYEbOS4kuD6/VA7mlF46nZlfleGv44TxTaj5wsiKMQj1gf9A95rzBuGcOBf6/bmFS+kzZSNfmxttD+JO3+tvMpwq7Sy8hubHX8quLhIflW992UUlhhSTNmVR8A4w8eTaYnFOnFB23RmQZO3kVM4OrZOmXiPCjFpJzaQnFVUMq7apnipr/2ANITEHc3MQOJ18+5TmKl5vCUsu7cWhMC1QJvW3MX5A6kh+VNy1uPqmn/kjiJ23hzhlJOcdymTnc4Pbbz2dKmEj4nKYXvikt1/JEjb2jArCAdmlzI+d3EMvMZc/zum1VzwwmXJIFw/TA==
Received: from PH8PR21CA0016.namprd21.prod.outlook.com (2603:10b6:510:2ce::24)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 11:06:19 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::fd) by PH8PR21CA0016.outlook.office365.com
 (2603:10b6:510:2ce::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.3 via Frontend Transport; Tue, 4
 Feb 2025 11:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:06:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:06:05 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:05:58 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
Date: Tue, 4 Feb 2025 12:04:55 +0100
Message-ID: <cover.1738665783.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f147cae-ec8c-48c1-208a-08dd450bf371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bwER/Ojj51Vph6K9vq6NQv1xKr8K3FkwdW9IUpog7GcoQ7Slz5n6cDVdXnL6?=
 =?us-ascii?Q?vuZT/Dx1B6tA31Q+O0Se0YD55vwl2dmdE99kjM5+/iPKC3fZcMFwFOouH65f?=
 =?us-ascii?Q?tuimbqIzfTpWUBrl0ksFOGf197i3gmFXjTkJs+GtE6kMrJHuRfouY7LXqfZa?=
 =?us-ascii?Q?8Nm1eR5SVb5F4yonM+5tenz5Sts5IzAyb2cz3SdcbhgucZnIFNNgnhbrMo+m?=
 =?us-ascii?Q?s+ZEeHRRChMNYWSjzpG4ibO4sWlouVoQOy6H7uEWZpNy6zKDy4UOMOEXhngE?=
 =?us-ascii?Q?iv2d3/e8V5maacyf9Rt6PPDUdPqVA+iG/ov8EzuSdowLOWy9eyi+2lxV3gWF?=
 =?us-ascii?Q?DJewIr0PwpSSb5rB6PRSUsRZagVehw/bTDiOQtjeOMlIGXlp6pQZ+pZ1/FCG?=
 =?us-ascii?Q?RA6uwD8SBfbjwr3hNA0SJjr0r7Hkn1lgsRVbl07tqD+GSiAp3/Olu7CWVgs/?=
 =?us-ascii?Q?fe4BszcmpLeNlVPICXxej5jIiw4Eb209k4ijE/46Pfkr/9DR6nu+egXCdKjZ?=
 =?us-ascii?Q?JoJLjhQFX817f2hdd5LF/84PKXOREFQUCQMem5Dd9Q8XffJWLp02cjQq7exC?=
 =?us-ascii?Q?V5xDuc5SmduohPFPkALcwI5xDArV7gk/p6Y/0hhe1W1ukBO3rLIhgxLopb14?=
 =?us-ascii?Q?zYoPO9q59lXwFEsfK8g+HyyudOF9mGhVQMJbix4W71MkQHZJQCTF+xEDK70C?=
 =?us-ascii?Q?upsjk/o5/3VtD+RRoSmB32mE3PLBWq9cpzyhY8zSte+eOqkZhEWut9wrzSDU?=
 =?us-ascii?Q?icCslSyvXtsPD91Hqdf58wYbKKolt+lUi9sOMvhyanbj/NsDRlZOiQ4SAyea?=
 =?us-ascii?Q?SCnJJ7hxiwNNqeIT4eK00BZDgEBWP3gPst7F2avObNff+WEgkm2bDUtxSPTJ?=
 =?us-ascii?Q?mlZlp0F9G9Ti7BbCbsjs5/O9eZ73gF5o7gx1VHN+r7SvdhAYZ1bNrDQyyqKW?=
 =?us-ascii?Q?wHR5OBfWvyllRdhi5j/KelFY+7qQUfOIPCMCy8IkhYhuK9XDEOAGpe5goTeb?=
 =?us-ascii?Q?iG6jVVJawonTNWj4Qfc1vQpXTBLQVpdhPCQaNPlOpzVyXz8WEcejvLUrHc3+?=
 =?us-ascii?Q?INkC6L4Q3XGLGvVRcTP+BR4wJgH5I6mflg17xykjvFtIgDJ2OJnHn1u1mk9G?=
 =?us-ascii?Q?wl3xGZQgx2iEYDkym4f2+7NBI3MfFDDFxOQ/DqKQDH/VgYkLBE2Lzq5+1ECz?=
 =?us-ascii?Q?9QQjkHvBA3Af73cXEUeWzyerr2vVeb8NqqAJ9dCwydLZSeY3+Rvk/uDCXPOL?=
 =?us-ascii?Q?S9F0KNHPJ4Zt9VODsvKWIceyFoeWzNCdEc/w4j54zSBwqjQ9bpwxnMdkk7UM?=
 =?us-ascii?Q?kSB+YSSyENuvPMObkyYMJu/l/fS1gqPEMLjtBJnTOT17Rq8AnCSHbBTFpWOM?=
 =?us-ascii?Q?JB1Q4PBgJkWEIPGmaCp7+4iTMm4TgFyeP5G6VJbIDv2aM5rJk/a0A5ehkj9P?=
 =?us-ascii?Q?NzYFBulK5eCKTFZAVoEkogjvoad2oe09P3uuzlmYR9+jZuKmRKmTjwZH23Yc?=
 =?us-ascii?Q?wjp/B48duUWEHAo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:06:18.6618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f147cae-ec8c-48c1-208a-08dd450bf371
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976

Amit Cohen writes:

A future patch set will add support for XDP in mlxsw driver. This set adds
some preparations.

Patch set overview:
Patch #1 removes debug prints
Patch #2 handles local port from LAG in PCI driver
Patches #3-#4 add rx_pkt_info and use it
Patch #5 adds a separate function for syncing buffer
Patches #6-#8 store mapping between local port to netdevice in PCI driver
Patch #9 initializes XDP Rx queue info
Patch #10 initializes PCI port
Patch #11 handles some SKB fields in PCI driver
Patch #12 moves local port validation to PCI driver

Amit Cohen (12):
  mlxsw: core: Remove debug prints
  mlxsw: Check Rx local port in PCI code
  mlxsw: Add struct mlxsw_pci_rx_pkt_info
  mlxsw: pci: Use mlxsw_pci_rx_pkt_info
  mlxsw: pci: Add a separate function for syncing buffers for CPU
  mlxsw: pci: Store maximum number of ports
  mlxsw: pci: Add PCI ports array
  mlxsw: Add APIs to init/fini PCI port
  mlxsw: pci: Initialize XDP Rx queue info per RDQ
  mlxsw: spectrum: Initialize PCI port with the relevant netdevice
  mlxsw: Set some SKB fields in bus driver
  mlxsw: Validate local port from CQE in PCI code

 drivers/net/ethernet/mellanox/mlxsw/core.c    |  38 ++-
 drivers/net/ethernet/mellanox/mlxsw/core.h    |  13 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 249 +++++++++++++-----
 drivers/net/ethernet/mellanox/mlxsw/pci.h     |   8 +
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h  |   1 -
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |   8 +-
 .../ethernet/mellanox/mlxsw/spectrum_trap.c   |   6 +-
 7 files changed, 218 insertions(+), 105 deletions(-)

-- 
2.47.0


