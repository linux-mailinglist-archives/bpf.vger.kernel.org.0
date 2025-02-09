Return-Path: <bpf+bounces-50884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D12BA2DC05
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B018A3A6334
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42948160783;
	Sun,  9 Feb 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WYqxd6Ly"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0864154425;
	Sun,  9 Feb 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096333; cv=fail; b=C0yLlRUjsAgQRLWPviT0X81D8pB3JbzM5ucXu1BrPIEhpL3mEUkLjAq2mO73tr189CeSTj3AuveYZnCsAXtJ6FPZF07Y7ZZ47TNi4fDZYD7zQbMnGlwVVvRl3AkGPLdzig7aBT48y+fmvxCDT1jdAp8ur2D/YJXvIe8hkJc/fhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096333; c=relaxed/simple;
	bh=+vs+UMCbcq7pW/MBS83+lhk/JQgKksW6wav3Rlx0LgI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bry8XuDKVNBg19+9GdpM4LdTDGecVJeZYg4psczTeO8++dhB9LN2zupWPqpc83hncBFtBfMYWauRK+zpaqYSG5CuYVH6IRoBBRx+77qmzUSKfMAPq2VUtr7fa4LJZ3GBPrZiLgRNV8WJW2AN0Vr0L9Wj6Y5uvnf2foRZa4xKqJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WYqxd6Ly; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2Cor3BHZpS1n3UdPb1b/AoJx4cGRrenyr0AJL5xsfaB+vD5Xegnm+i70sPuiUOEbn1DNEsHgsMyEfx8IXkEGDZE0+jMG1WbrStrtjcvgLecfyMWMc1zFhVn5WKJwSPDh4xTDhzoj/zn6m+ywyiKAm+uYSNyN5jRRHQCC4y95m8uePLZOcqlRm2QjaCsTTxIX+Ed5jFZ9YGWtNL6kDhhEGHhoLA7E6/Jcd25aGUaR7rwK2Lz6eByACnpOC8krU8oLY9Hcb6Rr/R6D2rHFJzQa0Lgf/vS8Y+9fYCzkn7i2Vc5FN1SCu2A3Ny+FpGfyWSMgpLr4mRvTpZSbo2MB3Mkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgA8bVOidkOnFqkgeL/i2gXmvvN0jTdY7u8Syi2d9XA=;
 b=vSlvtYjocRlBv7oar8Jflx//GjYu0vmWuATX748I8QVfgRR7bTCNJz/QGo5pYIufiJLwsnkdFZURUW+0PeKJb9pBhYEXbHTN6//bJQB7yojXd/ezUQZsm2klHUYqd++iSeJ9gQq4rUd+BARyG9v237n4Q2V2umRB75/qpj0T/dQlLJRRnYHEqZFo/Uyimcv2bnnT03PCdc0swk3QLLOUw0d/uOPIHrG7JYcMDZ+rRGvxxr81hbeqLs1cU9jlqXwq2vxJHrXqeD2FhQr3G6+D+fCCAzjuJIdInh0bD6djrKQf+dRnlTOciAfNrN0s2H19xihnSi9pRP4nN0G0bTNo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgA8bVOidkOnFqkgeL/i2gXmvvN0jTdY7u8Syi2d9XA=;
 b=WYqxd6Ly7utdSxV9q0PtVepxp0+hhBDgof7GqYdcHz03B1+FAp9Ol5GhG5gayjUuCYk9/xQfcW1GO/GoKSYpPAUZmHMFghXzb1E3fpOa8Bkwy4cZo3obipFBxnL8JWDHc/AN5PPgCdeyKgoWDgRRsEcYB5DirfzMWwtPkXwSt0dGppviR+p52qiduSxURXiVUDE0NxJGQMq4Q5KTvIyE55jeeSCx9BW1QoXX4WVmwxI/eHf2RcfQjKpVx/EAdGiMrFphrxLLaex2aAjO+bViWiL+uOIPthkCH/ORHsGKY/fMo8mDz/rPD+xfeAxKz0zV5Vf4cYblxHvtEkIodcoIig==
Received: from BY3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:254::31)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 10:18:47 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::ca) by BY3PR05CA0026.outlook.office365.com
 (2603:10b6:a03:254::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10 via Frontend Transport; Sun,
 9 Feb 2025 10:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:18:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:18:45 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:18:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:18:40 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Simon Horman
	<horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Richard Cochran" <richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next 00/15] Rate management on traffic classes + misc
Date: Sun, 9 Feb 2025 12:17:01 +0200
Message-ID: <20250209101716.112774-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c655d4f-7f54-4bba-be78-08dd48f32384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QBaiLRHKpwts7KmOsmGZfj9BLpoUvdzRQogDLjUoq49CoBthRtggIyyGIM3v?=
 =?us-ascii?Q?0h10wnptMi3hkKRtOjrooEWdLKQ+0EQz/o8ECTgdwYn5fPP9Kh05WdvEmd9J?=
 =?us-ascii?Q?TvTtRzfUManU+xcGnBCHM1fbX/MNyLwQZBi7zDncULh0g4DLrY1Pxe9LkZQC?=
 =?us-ascii?Q?nGKQ7PliODvMkP6ogNA9z8Y9kOBuoieP9qPkQn6lyhl0dtapHilFsamwjn11?=
 =?us-ascii?Q?3vebWPRFg1sOgXfrddm/2zAQER/K8tBDDQMYVuPaHlRU9M1DfzUo4hAibNYj?=
 =?us-ascii?Q?UsKZ4oh+1tJ7UiM65hQQ8tXKgIKZkyJuwXOnSOXb+suIt6ljJJO8W/DUmU5E?=
 =?us-ascii?Q?luo5AC9wx9i+lqa1ZFjkNdXfHVz2eWpkyQSG2FpEvn7gIGpe91jjBR9wnjrY?=
 =?us-ascii?Q?xWMiqJcsC5YF7cV+3iMbPtASF0JzAlYq2JRjLYRqhQ00QXoVZtQtRvIRq3Pf?=
 =?us-ascii?Q?FspDzG+wAhE8puHeGkYLQxUWL8JMnIQinwea2YPBVBi/R6RyqsrwDnah+z48?=
 =?us-ascii?Q?ima9xk3R+KQmUb+kuAlAU2DLN2dcIJwqVtkGEkhLHQdZXfWuQD5J41AjO8lT?=
 =?us-ascii?Q?WQh5bX9q/D7ucA3gvRuDcpAwrQG2TAtFCPJN0EjKmC63TQ27LF50Rh3ABDCi?=
 =?us-ascii?Q?4iq29AZyyEpUqtRfIcdJK/Y1DEUalfpkGNUV/oX7Kzpbib21/zct14wCHDac?=
 =?us-ascii?Q?8cI+OiwYVBNS6cG/HTY/a6EnfYV7qq1E+hFxEdv4OWynaRNQWH5nPRfCO+ud?=
 =?us-ascii?Q?T3TTGHYzzO58iR1sNSivwGgc2H6OlCXNt0reEcormAd65TtcP0LeZoF9ajO0?=
 =?us-ascii?Q?eEYAUK2xGntHXTr03COE61HTKn8oZOnMjBCVIt0N2krin+uSHdXjClZj00B1?=
 =?us-ascii?Q?Aj3idrej5y4qwyGyZOANC+vuWS3M+x6h65Fg1QK7LR5faTX/Z1nI8zSYEbcR?=
 =?us-ascii?Q?h79s9XK9wFTr4Fo3VQcUSr29skLkmkYYJKmPWE+AmZxfYt4dY5sMmn2MR02e?=
 =?us-ascii?Q?iWc7lGhoA420AFmedBNCnurdNqh8uZl3i+h+blr/WlyhffJaCsnz/0r6UJBv?=
 =?us-ascii?Q?6vrHZYPwrKScxNGQ1KsqTFKgJs9dqvpJNpOMoJNauEKXS4luvXatbe5mVNAG?=
 =?us-ascii?Q?+sRSMKzFjJq+k7wxWs1L5K/UtKph/l6qHcW3URLvMvCBSu3XFb7ZqSrnV4LR?=
 =?us-ascii?Q?T8MM0pBgyGf/tagvy4GAWlUVneeycScukKViYgo/MLZyDu1i4C434Craa5E1?=
 =?us-ascii?Q?LtLlXlR1lPzGKuLhF9gideYrLZrYqfPNqgIj1PDhBrk41IrszWEgkJjIAZcL?=
 =?us-ascii?Q?nMgD3gMoYmWMBltzybO07cNYAZcMNlkLpZWfcLyCsQmWXyHsbqoKBJw1xTJM?=
 =?us-ascii?Q?5s19TifeEg3iplfHGoJ5STRHTDIn5K5O009Srn7w9mbIH4SMGLp+P7coTOkF?=
 =?us-ascii?Q?PyEo8eK2oQVARtZn1Dvq4K8tQta8nRjSkV1b+oDmq+sju6GXIOnWhU6zF1RI?=
 =?us-ascii?Q?Ms/AwkD88DeMTsE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:18:46.6319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c655d4f-7f54-4bba-be78-08dd48f32384
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patchset consists of multiple features from the team to the mlx5
core and Eth drivers.

The first 5 patches by Carolina are V7 of the feature that adds rate
management support on traffic classes in devlink and mlx5, more details
below [1].

Patches 6-8 by William reduce the memory consumption for representors to
achieve better scalability.

Patches 9-10 by Akiva expose ICM memory consumption per function.

Patches 11-13 expose helpful information on RSS resources in devlink RX
reporter diagnose.

Patches 14-15 are simple enhancements by Alex Lazar.

Regards,
Tariq


[1]
This is V7 of the feature. Find V6 here:
https://lore.kernel.org/all/20241209210950.290129-1-tariqt@nvidia.com/

This feature extends the devlink-rate API to support traffic class (TC)
bandwidth management, enabling more granular control over traffic
shaping and rate limiting across multiple TCs. The API now allows users
to specify bandwidth proportions for different traffic classes in a
single command. This is particularly useful for managing Enhanced
Transmission Selection (ETS) for groups of Virtual Functions (VFs),
allowing precise bandwidth allocation across traffic classes.

Additionally, it refines the QoS handling in net/mlx5 to support TC
arbitration and bandwidth management on vports and rate nodes.

Discussions on traffic class shaping in net-shapers began in V5 [2],
where we discussed with maintainers whether net-shapers should support
traffic classes and how this could be implemented.

Later, after further conversations with Paolo Abeni and Simon Horman,
Cosmin provided an update [3], confirming that net-shapers' tree-based
hierarchy aligns well with traffic classes when treated as distinct
subsets of netdev queues. Since mlx5 enforces a 1:1 mapping between TX
queues and traffic classes, this approach seems feasible, though some
open questions remain regarding queue reconfiguration and certain mlx5
scheduling behaviors.

[2]
https://lore.kernel.org/netdev/20241204220931.254964-1-tariqt@nvidia.com/
[3]
https://lore.kernel.org/netdev/67df1a562614b553dcab043f347a0d7c5393ff83.camel@nvidia.com/

V7:
- Fixed disabling tc-bw on leaf nodes that did not have tc-bw
  configured.
- Fixed an issue where tc-bw was disabled on a node with assigned
  vports, ensuring that vport->qos.sched_node->parent is correctly
  updated with the cloned node.
- Declared a constant for the maximum allowed Traffic Class index in
  devlink rate.
- Added a range check to validate rate-tc-index.
- Added documentation for the tc-bw argument.
- Add a validation check to ensure that the total bandwidth assigned to
  all traffic classes sums to 100.

Akiva Goldberger (2):
  net/mlx5: Rename and move mlx5_esw_query_vport_vhca_id
  net/mlx5: Expose ICM consumption per function

Alexei Lazar (2):
  net/mlx5: Extend Ethtool loopback selftest to support non-linear SKB
  net/mlx5: XDP, Enable TX side XDP multi-buffer support

Amir Tzin (3):
  net/mlx5e: Move RQs diagnose to a dedicated function
  net/mlx5e: Add direct TIRs to devlink rx reporter diagnose
  net/mlx5e: Expose RSS via devlink rx reporter diagnose

Carolina Jubran (5):
  devlink: Extend devlink rate API with traffic classes bandwidth
    management
  net/mlx5: Add no-op implementation for setting tc-bw on rate objects
  net/mlx5: Add support for setting tc-bw on nodes
  net/mlx5: Add traffic class scheduling support for vport QoS
  net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw

William Tu (3):
  net/mlx5e: reduce the max log mpwrq sz for ECPF and reps
  net/mlx5e: reduce rep rxq depth to 256 for ECPF
  net/mlx5e: set the tx_queue_len for pfifo_fast

 Documentation/netlink/specs/devlink.yaml      |  36 +-
 .../networking/devlink/devlink-port.rst       |   7 +
 Documentation/networking/devlink/mlx5.rst     |   4 +
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   2 +
 .../mellanox/mlx5/core/diag/reporter_vnic.c   |  46 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   3 -
 .../ethernet/mellanox/mlx5/core/en/params.c   |  16 +-
 .../ethernet/mellanox/mlx5/core/en/params.h   |   1 -
 .../mellanox/mlx5/core/en/reporter_rx.c       | 119 ++-
 .../mellanox/mlx5/core/en/reporter_tx.c       |   1 -
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  |  15 +
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |   3 +
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |   9 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |   5 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  49 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  29 -
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   5 +
 .../ethernet/mellanox/mlx5/core/en_selftest.c |   3 +
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 815 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   4 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  13 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  29 +-
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.c  |  19 +
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.h  |   1 +
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   2 +
 .../net/ethernet/mellanox/mlx5/core/vport.c   |  25 +
 include/net/devlink.h                         |   9 +
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/netlink_gen.c                     |  16 +-
 net/devlink/netlink_gen.h                     |   2 +
 net/devlink/rate.c                            | 127 +++
 31 files changed, 1274 insertions(+), 145 deletions(-)


base-commit: acdefab0dcbc3833b5a734ab80d792bb778517a0
-- 
2.45.0


