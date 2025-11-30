Return-Path: <bpf+bounces-75778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A04EDC94D6F
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 11:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4603A461A
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 10:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F6275AE3;
	Sun, 30 Nov 2025 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JAAhuV0s"
X-Original-To: bpf@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA82623ABA1;
	Sun, 30 Nov 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764497651; cv=fail; b=cOpO0VF69E4SMOKh+8+QADBF2w8vK/tvQXXTAhutuJoeVMsbmGdFfk9IxAfr/gV8FSvWDSUd1OWcxaB6Fza+kTCDPUohBE+uEVTaqiOyd51bis+VXfgf4LEVRMSACAoNpkghZEs6DWS4E+gkShSe0UK+Ctzz5tEdNuSBg4CCVMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764497651; c=relaxed/simple;
	bh=nav2efQbsEPCwE+ovYkJswrmiIilVnHRQk5pd8ZSZgg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OYIOd3ds77u7c6itjuwuO6nC8zCjWSMs3FaOmIurrOd3o66FiqBDgjzf5QOHDPEA94IPp1un0m71czIoNjs2hDGs3NlgtZS2fISR/ufleIuszLSsGHHWEjryIfwvQt6SxJZ6i4dDGk0pcWyv1LsWh/elLU/q/WRmILPs+4cGfg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JAAhuV0s; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWrxLwgNYl28fDxS9OVZ29DnfgARSB7BODGC2Jvk0pnysUHu+eKYd1Jnb1iiqFX2xy1C33xe8KwhmG6ofmgbESl2eipc3hirDszxxuVNmRW7KW6JTN2Z9/s9FxXWhwmABajhUoDI4lh/mchxzoo2j/xPCRo+SnyR+13KZgtnMTaZhosTDKJk2KNB+jI8aWeYML0UkhXZfRXdZO7lMpz66L0EjIfWf3077Hs1EwXk2GnFBo4jqLcLuWwGT3P5koXL9rwVeMgZ5dxQt8ZqRKbBvButuEQ9OhQa1N9BkVTvArAxOu7sRrNnbgT5ygmmb22UTMWIRM0mArVE3oqLHpDcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4DKAh/6oBzBcgwAh2kd8OFx7AbWvUUacD0/IcSZvgE=;
 b=N9JoxboPtoRB+3gFNL5G/iU87WDjQXZYS/0VVk2fQXLcp6aS3M6Z71v2R+k4WfYICtEOPiyMLn3zeEwYKeC+I1q4ouGi1U66FFP3y3kdPFrjain/8JG6dWJyIh5puZdsTHFX+F5RIk+iZ6cg5P3wRUzBKlPDVDPMseEPT5hS6febg/dlWvbBIdZKAFKu2VZ4XHFxOKE619vuNxAH2exB2ox90nVnD0AK1POC9zqT70PLGIRzMFUkmuWLpar+NZhMXUPDZzZVM0oIFnvQokJN6cQLdNFQqHNIwrb8Pqrdo/Cg6IF9QZt3udyqMYb1sO4vYtKgFngohNGrMvhdpD3xnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4DKAh/6oBzBcgwAh2kd8OFx7AbWvUUacD0/IcSZvgE=;
 b=JAAhuV0svNZxWl+QctBvSdbxeu/ldp4TZnsxioyYRRp7moxqYqdJI+pJUkDZnfiUBoCUsdt5oQ3w8FdpT6C4pa67IexVCP4nfLHCZega0qtbn35/H1os0VUMhmZPz+/Qpzeq72Mf45awML+uQfw8fpYfJ8isQpWIshn5dNrGVErodtL+SVj201zuBbtYMWs3x0LDRTFqASqM/vpsr8AriHmBNsfz3dhBVtOtbkeO+rr7ksQR9UrlddXwsOfq84l6kfJ1cir1Py8MwU+sUKAklD/n+euG8+rcKMLd6UsigAGQbDQ48L5wNSU/1B64P1qRiODs5L4weyGamnmk4TIwSg==
Received: from BN0PR02CA0044.namprd02.prod.outlook.com (2603:10b6:408:e5::19)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:14:05 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::79) by BN0PR02CA0044.outlook.office365.com
 (2603:10b6:408:e5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sun,
 30 Nov 2025 10:14:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 10:14:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:13:56 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:13:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 30
 Nov 2025 02:13:48 -0800
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
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, William Tu
	<witu@nvidia.com>, <toke@redhat.com>
Subject: [PATCH net-next V2 0/2] net/mlx5e: Disable egress xdp-redirect in default
Date: Sun, 30 Nov 2025 12:13:35 +0200
Message-ID: <1764497617-1326331-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a5479f-5e5a-40bb-269a-08de2ff93163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zvfssDyofvsd9KHnF6OAgE5l/y97mT+LFopWp6eC5g1QnktOMSAIiIge/YRp?=
 =?us-ascii?Q?DmSZuQ4dWH7q4IEfcbndo92TKd5AZUKg14PEg3yB2GjXJJJdby1Th71fk4NO?=
 =?us-ascii?Q?b7YnV5ozsEcPBGfp+TCZFWUeeG7VQk8k5AvePCMXVeBO5++vrn/G1WFt6z1S?=
 =?us-ascii?Q?2GVu127jnbHRq7kstvP1GS9Y6/siVW4Icg/Tsa16jtWvBQX7TaxM5dYK6BEs?=
 =?us-ascii?Q?5QGP42Dds5qffTbHBQOqPGwmZv8B5gO85NHlMBAasqx06tB2Dbr3Hlo6Lifo?=
 =?us-ascii?Q?ow8mHVz4O0ZXarCk5ueACpmbjqCbKt0ZSu/fPHQW5dkH718R5h/5p6FooBQK?=
 =?us-ascii?Q?A+z9SiDjX1THwVO+41b4OM1C8l98KB8K5jSnjW4W8IMTMCbNptcTHkLAbY5Y?=
 =?us-ascii?Q?okkKMheR/M7i6mflGLeVPuUqzQcZe4ns2fqlI919cMdrQNSfB9Ee5RIpyg1i?=
 =?us-ascii?Q?/YHEbRqEjGrePw7OEXXmbRQSzW8uqp9i8RRwz4WVvyXDV7JALXYTdlcyHkyN?=
 =?us-ascii?Q?FRZckUMZKjfROQ7AYl3VLn9PwR5l2LoGeB3b38aEZTD9zFY7UCAFalkTp+Q1?=
 =?us-ascii?Q?g56YT6X4YNLMCL3OJq4NyQKLrzw5OfJ0RQ+C7EFihMJfiMTKm+gBPiR5dQHd?=
 =?us-ascii?Q?Dhoa/X0yHVrifhuKbePf0xj1/o1tDnnWIe8dviDdzmEJjIN4d2csMM2c90hQ?=
 =?us-ascii?Q?CiqN/5Cs6aiEnD6XYws8QG0+DLNVEcEbgY51YjAfdUwbLPmzrhn4aHRYNEwX?=
 =?us-ascii?Q?jU8VJM73CEjinoTT7S9/dFlADF6FJAAbzCQzlQiHqPTQDDmoKpVFK5SU4zx4?=
 =?us-ascii?Q?eq/QQ5iausF7WNsUwzh0aPjKlYZzNYteUgAZt/M3asVPDEcBerMp3Lwv+jhb?=
 =?us-ascii?Q?ySORVqZEw1X7sijUWnsmlCqQ4AEKFfMWhPQ9cKHD/bPsFxKKsrAlLCh6mYh2?=
 =?us-ascii?Q?yTBtXglUaIsgLnpsEEKkZG2THUQVUN/C4tkHi99ttc50/4FOOkXwSBRKZbqr?=
 =?us-ascii?Q?v6XuWFTTtCC5WXkrByWMrSlnYQccDjijxkoQTxaO5OnCEvYVP2rX7MIiSzSQ?=
 =?us-ascii?Q?mbGgOH1/84ZkD3HHQU+mviLNEk9H0Wx2M+sF4I1Oj2mWGz5OvtDS5agiYJ4n?=
 =?us-ascii?Q?+sWDsjlUMOAa5IY+GeTaqJDacN+ze07s5JU/XeicKvdQEiTggItsfT7nBNjr?=
 =?us-ascii?Q?yiHp4ub+/VV1wohj1AatWSNcicevsjyK/gLBgxFTHB7WurCH9AoJgoL+Y+wG?=
 =?us-ascii?Q?E00zi37He3JM8rvAXsDP/mcoY3GG13rfWilhEBOyWKQs/egIPOQGq2WeGJeI?=
 =?us-ascii?Q?OpUSUhb3Ezl07l6SIo0bibculJKSN+mjQ6ZxUM8oiczPA06db7CPZAdYlrIu?=
 =?us-ascii?Q?NBqihORhMzKGbdwHBcsiF2eHc2KlmdG+1f/SX9yQTKwCxXgGb9nOwo61e/iG?=
 =?us-ascii?Q?Dyu2OcLynb6RcxDlWP6lPmWEqWWIKpeGG9LFqBuDuyfKiefcf8pN5YNLvHKy?=
 =?us-ascii?Q?Ti+zO8cTfd6UfAC7PI/XNqP6sEYgy9a6x49qeQF4RePQvPfJ1XNKo+x1FmOR?=
 =?us-ascii?Q?QcB1NOFaryE8xJ13j9s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:14:05.3155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a5479f-5e5a-40bb-269a-08de2ff93163
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551

Hi,

This small series disables the egress xdp-redirect feature in default.
It can still be enabled by loading a dummy XDP program.

Patches were previously submitted as part of [1].

This reduces the default number of SQs in each channel from 4 to 3, and
saves resources in device and host memory.

This also improves the latency of channel configuration operations, like
interface up (create channels), interface down (destroy channels), and
channels reconfiguration (create new set, destroy old one).

Perf numbers:
NIC: Connect-X7.
Setup: 248 channels, default mtu and rx/tx ring sizes.

Interface up + down:
Before: 2.246 secs
After:  1.798 secs (-0.448 sec)

Saves ~1.8 msec per channel.

Regards,
Tariq

[1]
https://lore.kernel.org/all/1762939749-1165658-1-git-send-email-tariqt@nvidia.com/

V2:
- Enhanced commit message.

Tariq Toukan (2):
  net/mlx5e: Update XDP features in switch channels
  net/mlx5e: Support XDP target xmit with dummy program

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 10 +-----
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 36 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  2 +-
 4 files changed, 20 insertions(+), 30 deletions(-)


base-commit: 0177f0f07886e54e12c6f18fa58f63e63ddd3c58
-- 
2.31.1


