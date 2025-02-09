Return-Path: <bpf+bounces-50885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EB8A2DC0A
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0741C1887150
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B5D17A5BD;
	Sun,  9 Feb 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZzUze2Gz"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD7154425;
	Sun,  9 Feb 2025 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096344; cv=fail; b=Iv3qt511XEq4GjDGM9oAIDWt/6TB86siKsDBugD3kaxl3hbbHhEG0CnfwtoVE41rkmzHCty0ZX+FYZ/CpZPOqmePqRT9AH5qpw015pbRZbfWrtfv8AHUblUlPjEAxvNxpQ6jNmaqtdVIL7FWPERw/JpmTyQtoXd1/+KWUHnrj8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096344; c=relaxed/simple;
	bh=AE9uREYWWt1E+iCZ61ePGJQWMwgvR5BslZJtc6CSxAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faUxtsveykHwfK2FcxcY/xAYWp/XEaxQfKEfmg/m+NB+FgRRMO/C/Z6eAUXKlULvfYQc3pMb2tkfWYpHBSghARQpnDm6WsTesFpVtAMxpNSMnXDtM2CY5IirOO5aQM/fJqR4vm1btjrYce2ivzG4z48qPFOSKe51vVUH36I6kao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZzUze2Gz; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoGFxJUuWTt5aHKL0ZkVBiQd0CkwGoxY+4etrViN0l4LvVhfXA5f960mBex1dnrDgQa4CkYsNM9X6Vrwf8xpoowXtuGGCs/GHUperm0BxYZmJWEvvwPNpyKYRfhas/z+nLapdr4y3gayEvH6jwK2rFDpwI4/j4D5az22z3AxvKl9mgsV5jwAyNbyzYyZsEZuLATWHx0UmJfz/29dn/xWYOtvBO8QsJhe2S+W7nn9OqPDBiaZ4ppPxOdXKEdN71xOKfGz6Vykvq+Box4yW+Ryw03+ac9Jnsqg9WYrZhAEANcV38OiLCpvpGfUMomDi5YKk3z3iR+H5ksD9HxABHQLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBjNnR1zr2j63On85I4sITHK6GqY+hSDh/q+nszAJOs=;
 b=Bh/yK9T8TF3IapMKexc4Xf4jKqy8uanQvVNZjgHBlTex70A1ydDEuiJDoB0W5VQlM7l2XtTxHKandstexzzlNwHftV1p43c1VBWloXbt09MU32yQeaYMdzjFxC+E5cI0+j/Uba0JLI8pd3JSYBn/d17X1W4LzYTsMTIrvVEBAfFiNowHPUxTTTbNp0Fr5ZARjoxnb700aDTvZhWKqciJEycO7pJ7ylofmD34ib+04dfKtPD+n5VbE06HoA//UoR6IDXAQ24dcse2SSHohP22db2mFWQM+zviAks7Y7/IR1nUWswtQgG1STc4GPYoV5jgsZwvKjUzeC4vaZxJn/hCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBjNnR1zr2j63On85I4sITHK6GqY+hSDh/q+nszAJOs=;
 b=ZzUze2GzSYko7BHKjxcWdveFI2CmfXQc6tKybXUuQFwFxn2diNvZx6/YQcCCQA5LSyy7f46gnuKEWYA+fLuriNo1to66COAk1EknUjG053tv/UTwozj5J7fInElwWS69fnywYyzAiljLkhXY04v2jr6PoxiXpC+x2eHXNwVYk2dP75QyNnvycVwHSNli24Bj3iupCBQ3txG5Tpj98iVZtFd6vhXrsqVldBSW6ZoUWFj/9d11xy09r4dbyWcqMd0n5tf19tUy7oQ3455yn0Xv8dPv7Yl4DeR0NhV4NJjYt3r/GFDNV+Q99Z9U4tj16UbnfcDyhe/5TDRm+3FTsSqUBw==
Received: from MW4PR04CA0190.namprd04.prod.outlook.com (2603:10b6:303:86::15)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sun, 9 Feb
 2025 10:18:56 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::ab) by MW4PR04CA0190.outlook.office365.com
 (2603:10b6:303:86::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 10:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:18:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:18:51 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:18:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:18:45 -0800
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
	<bpf@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 01/15] devlink: Extend devlink rate API with traffic classes bandwidth management
Date: Sun, 9 Feb 2025 12:17:02 +0200
Message-ID: <20250209101716.112774-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250209101716.112774-1-tariqt@nvidia.com>
References: <20250209101716.112774-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4c5d2a-d0da-4c14-596f-08dd48f32897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iiM/8Dh1Qwfai6iwtv53AQ3DxXB/uhlpnTRz08vApsX2BdxyhXMqYUdEJRS4?=
 =?us-ascii?Q?rNyi0TYC0J9dsV6qEs7/wz9afrNLBUD2SxVmsL/HwaktIMvarvIG/nI7ezYS?=
 =?us-ascii?Q?jftWiXJBKZCmL/jOpSWYcJjKy+yn3h29NxDf+EikK7t7M9gWyWaK7Ol1aJJE?=
 =?us-ascii?Q?n0xljvRdekhAkUfNJ4VFbNly5e1CYUd168gNxaKrCstphVv4UE3C99h6EThv?=
 =?us-ascii?Q?EM8VnGvCKr1ZTTT3Y2+xUEUOUD2Cg450cPOD3XlULolKP6gPNMhI9BvjHfrJ?=
 =?us-ascii?Q?cVc4D1XD9HZJK2vB4iEYjR2THdOD9+50D1LlAySm/XJpDXWY5My6t4VdQ8jx?=
 =?us-ascii?Q?7PJXcS5Q9ksLM9kEeAIe5oAARhhayusf4j99aTQZYTSamvwBSokNI7er2a7P?=
 =?us-ascii?Q?QS0BUd4YdH6f0IG757jiLom7XdFXGGDk4fFGq4oesLb7yabKKcKoMRRNiwS7?=
 =?us-ascii?Q?ljDCiFThAdrqk/hYg1IfYEsHJpj2ZbqE4wKEZyohyvFbj1OXKzZVngW8nmY8?=
 =?us-ascii?Q?w1iQN54Y5DVorJkZ7LL2rTD5EChG4vcxM6PoMTSuJA5RYQrbr9+IiZgYDfQ6?=
 =?us-ascii?Q?WCwvSJciD7SyWl5mlbwDgZhslL0VGUjBoJYdC2VDtuaeAfEYZWLUrqpVFBme?=
 =?us-ascii?Q?J86KwEXZizx6BHpchMjLRcBAfWfCQMl2ao6HVDf/WnYVe4qI/K7WvFZKviUE?=
 =?us-ascii?Q?gUARjxGScYRZeWsMe7fKUbY8GOsRTLwrnDhHf9EHg2WBdF+R/e4bqhIv4iyu?=
 =?us-ascii?Q?0HloHP20Iwhh1hD7ZZuDTtUzyw4EpRLgwlQtd0Ddit+F1ZzBbRko9nHJxU9z?=
 =?us-ascii?Q?0BtW/EsH2I/F6i64ef0wwpWzhuc705Iy2gt0fnzTYcDQPIep8ulmIg3AnT3k?=
 =?us-ascii?Q?N+mDUQzdYBYSC8UxoJrhyzrzfrnxlTQ0C29hUuDyCVwCc5Hw43LByMr5u9q4?=
 =?us-ascii?Q?+58+AROIDw+/CJGXSbiJGD7IUKyNl1aE/K1JyQ4HA+CHrSQReZE5rfkfy0pD?=
 =?us-ascii?Q?n7ATYcow/LlIykXIERVcV4k1d85PJLdWPDormzWbU6075VTE1/avTI71mKKu?=
 =?us-ascii?Q?ChGvhVsSOTnKGNIuS+Rmq+9v8kCL8cOHToOmZ1xGhlYZUCv6DXrLJm6rY2YR?=
 =?us-ascii?Q?j0fYGw4DF2qbo4I0laRqMihHVlmv+mHUWrZs85kFdyOSped8MWzESSQ5SkuJ?=
 =?us-ascii?Q?PyqQAjrJUg9ELDgx95x9cFysmYHt4sT7JdyKpKm8lINzlRI90v4BNASPsXje?=
 =?us-ascii?Q?w1xHB2Nwg3pBlf4uaTDTUzGi1pKkxfApkWlpt0br3O2vdVYZ8XdGRTq2icuK?=
 =?us-ascii?Q?MuUXGPkshNxyoF+/Z30HxXnOmcgYGZfKJzxrvO4F4c1H/AezVNFAwf+8ttFM?=
 =?us-ascii?Q?c1XVpr8YOuSOSH1Heo5zKP5GgriIPmnP0NRGRKW6fgAEai/BchvqF3Zz/cOF?=
 =?us-ascii?Q?TKqOhxJLIBV9L+QDIbJRKFEja+MK1NIzWuVeB7vA2OHoc4YpUS7i9FwBgdUn?=
 =?us-ascii?Q?IkOi8Gg7fI3VfME=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:18:55.1582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4c5d2a-d0da-4c14-596f-08dd48f32897
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for specifying bandwidth proportions between traffic
classes (TC) in the devlink-rate API. This new option allows users to
allocate bandwidth across multiple traffic classes in a single command.

This feature provides a more granular control over traffic management,
especially for scenarios requiring Enhanced Transmission Selection.

Users can now define a specific bandwidth share for each traffic class,
such as allocating 20% for TC0 (TCP/UDP) and 80% for TC5 (RoCE).

Example:
DEV=pci/0000:08:00.0

$ devlink port function rate add $DEV/vfs_group tx_share 10Gbit \
  tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0

$ devlink port function rate set $DEV/vfs_group \
  tc-bw 0:20 1:0 2:0 3:0 4:0 5:20 6:60 7:0

Example usage with ynl:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
  --do rate-set --json '{
  "bus-name": "pci",
  "dev-name": "0000:08:00.0",
  "port-index": 1,
  "rate-tc-bws": [
    {"rate-tc-index": 0, "rate-tc-bw": 50},
    {"rate-tc-index": 1, "rate-tc-bw": 50},
    {"rate-tc-index": 2, "rate-tc-bw": 0},
    {"rate-tc-index": 3, "rate-tc-bw": 0},
    {"rate-tc-index": 4, "rate-tc-bw": 0},
    {"rate-tc-index": 5, "rate-tc-bw": 0},
    {"rate-tc-index": 6, "rate-tc-bw": 0},
    {"rate-tc-index": 7, "rate-tc-bw": 0}
  ]
}'

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
  --do rate-get --json '{
  "bus-name": "pci",
  "dev-name": "0000:08:00.0",
  "port-index": 1
}'

output for rate-get:
{'bus-name': 'pci',
 'dev-name': '0000:08:00.0',
 'port-index': 1,
 'rate-tc-bws': [{'rate-tc-bw': 50, 'rate-tc-index': 0},
                 {'rate-tc-bw': 50, 'rate-tc-index': 1},
                 {'rate-tc-bw': 0, 'rate-tc-index': 2},
                 {'rate-tc-bw': 0, 'rate-tc-index': 3},
                 {'rate-tc-bw': 0, 'rate-tc-index': 4},
                 {'rate-tc-bw': 0, 'rate-tc-index': 5},
                 {'rate-tc-bw': 0, 'rate-tc-index': 6},
                 {'rate-tc-bw': 0, 'rate-tc-index': 7}],
 'rate-tx-max': 0,
 'rate-tx-priority': 0,
 'rate-tx-share': 0,
 'rate-tx-weight': 0,
 'rate-type': 'leaf'}

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml      |  36 ++++-
 .../networking/devlink/devlink-port.rst       |   7 +
 include/net/devlink.h                         |   9 ++
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/netlink_gen.c                     |  16 ++-
 net/devlink/netlink_gen.h                     |   2 +
 net/devlink/rate.c                            | 127 ++++++++++++++++++
 7 files changed, 196 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 09fbb4c03fc8..3a6dd62b6684 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -202,6 +202,11 @@ definitions:
         name: exception
       -
         name: control
+  -
+    name:  devlink-rate-tc-index-max
+    header: net/devlink.h
+    type: const
+    value: 7
 
 attribute-sets:
   -
@@ -820,7 +825,26 @@ attribute-sets:
       -
         name: region-direct
         type: flag
-
+      -
+        name: rate-tc-bws
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-rate-tc-bws
+      -
+        name: rate-tc-index
+        type: u8
+        checks:
+          min: 0
+          max: devlink-rate-tc-index-max
+      -
+        name: rate-tc-bw
+        type: u32
+        doc: |
+             Specifies the bandwidth allocation for the Traffic Class as a
+             percentage.
+        checks:
+          min: 0
+          max: 100
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1225,6 +1249,14 @@ attribute-sets:
       -
         name: flash
         type: flag
+  -
+    name: dl-rate-tc-bws
+    subset-of: devlink
+    attributes:
+      -
+       name: rate-tc-index
+      -
+       name: rate-tc-bw
 
 operations:
   enum-model: directional
@@ -2149,6 +2181,7 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - rate-tc-bws
 
     -
       name: rate-new
@@ -2169,6 +2202,7 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - rate-tc-bws
 
     -
       name: rate-del
diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 9d22d41a7cd1..bc3b41ac2d51 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -418,6 +418,13 @@ API allows to configure following rate object's parameters:
   to all node children limits. ``tx_max`` is an upper limit for children.
   ``tx_share`` is a total bandwidth distributed among children.
 
+``tc_bw``
+  Allow users to set the bandwidth allocation per traffic class on rate
+  objects. This enables fine-grained QoS configurations by assigning specific
+  bandwidth percentages to different traffic classes. When applied to a
+  non-leaf node, tc_bw determines how bandwidth is shared among its child
+  elements.
+
 ``tx_priority`` and ``tx_weight`` can be used simultaneously. In that case
 nodes with the same priority form a WFQ subgroup in the sibling group
 and arbitration among them is based on assigned weights.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index b8783126c1ed..1b7fa11b5841 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -20,6 +20,7 @@
 #include <uapi/linux/devlink.h>
 #include <linux/xarray.h>
 #include <linux/firmware.h>
+#include <linux/dcbnl.h>
 
 struct devlink;
 struct devlink_linecard;
@@ -99,6 +100,8 @@ struct devlink_port_attrs {
 	};
 };
 
+#define DEVLINK_RATE_TC_INDEX_MAX (IEEE_8021QAZ_MAX_TCS - 1)
+
 struct devlink_rate {
 	struct list_head list;
 	enum devlink_rate_type type;
@@ -118,6 +121,8 @@ struct devlink_rate {
 
 	u32 tx_priority;
 	u32 tx_weight;
+
+	u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
 };
 
 struct devlink_port {
@@ -1482,6 +1487,8 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_leaf_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_leaf_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
+				   u32 *tc_bw, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_share_set)(struct devlink_rate *devlink_rate, void *priv,
 				      u64 tx_share, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_max_set)(struct devlink_rate *devlink_rate, void *priv,
@@ -1490,6 +1497,8 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_node_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
+				   u32 *tc_bw, struct netlink_ext_ack *extack);
 	int (*rate_node_new)(struct devlink_rate *rate_node, void **priv,
 			     struct netlink_ext_ack *extack);
 	int (*rate_node_del)(struct devlink_rate *rate_node, void *priv,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9401aa343673..b3b538c67c34 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -614,6 +614,10 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
+	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
+	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f9786d51f68f..186f31522af0 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -9,6 +9,7 @@
 #include "netlink_gen.h"
 
 #include <uapi/linux/devlink.h>
+#include <net/devlink.h>
 
 /* Common nested types */
 const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1] = {
@@ -18,6 +19,11 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
 };
 
+const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
+	[DEVLINK_ATTR_RATE_TC_INDEX] = NLA_POLICY_RANGE(NLA_U8, 0, DEVLINK_RATE_TC_INDEX_MAX),
+	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_RANGE(NLA_U32, 0, 100),
+};
+
 const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .type = NLA_FLAG, },
 };
@@ -496,7 +502,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -505,10 +511,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -517,6 +524,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1164,7 +1172,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1174,7 +1182,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 8f2bd50ddf5e..e3558cf89be4 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -10,9 +10,11 @@
 #include <net/genetlink.h>
 
 #include <uapi/linux/devlink.h>
+#include <net/devlink.h>
 
 /* Common nested types */
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
+extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 8828ffaf6cbc..3a046e929594 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -80,6 +80,29 @@ devlink_rate_get_from_info(struct devlink *devlink, struct genl_info *info)
 		return ERR_PTR(-EINVAL);
 }
 
+static int devlink_rate_put_tc_bws(struct sk_buff *msg, u32 *tc_bw)
+{
+	struct nlattr *nla_tc_bw;
+	int i;
+
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		nla_tc_bw = nla_nest_start(msg, DEVLINK_ATTR_RATE_TC_BWS);
+		if (!nla_tc_bw)
+			return -EMSGSIZE;
+
+		if (nla_put_u8(msg, DEVLINK_ATTR_RATE_TC_INDEX, i) ||
+		    nla_put_u32(msg, DEVLINK_ATTR_RATE_TC_BW, tc_bw[i]))
+			goto nla_put_failure;
+
+		nla_nest_end(msg, nla_tc_bw);
+	}
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(msg, nla_tc_bw);
+	return -EMSGSIZE;
+}
+
 static int devlink_nl_rate_fill(struct sk_buff *msg,
 				struct devlink_rate *devlink_rate,
 				enum devlink_command cmd, u32 portid, u32 seq,
@@ -129,6 +152,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 				   devlink_rate->parent->name))
 			goto nla_put_failure;
 
+	if (devlink_rate_put_tc_bws(msg, devlink_rate->tc_bw))
+		goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
@@ -316,6 +342,89 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 	return 0;
 }
 
+static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
+				       unsigned long *bitmap, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
+	u8 tc_index;
+
+	nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest, devlink_dl_rate_tc_bws_nl_policy,
+			 extack);
+	if (!tb[DEVLINK_ATTR_RATE_TC_INDEX]) {
+		NL_SET_ERR_ATTR_MISS(extack, parent_nest, DEVLINK_ATTR_RATE_TC_INDEX);
+		return -EINVAL;
+	}
+
+	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
+
+	if (!tb[DEVLINK_ATTR_RATE_TC_BW]) {
+		NL_SET_ERR_ATTR_MISS(extack, parent_nest, DEVLINK_ATTR_RATE_TC_BW);
+		return -EINVAL;
+	}
+
+	if (test_and_set_bit(tc_index, bitmap)) {
+		NL_SET_ERR_MSG_FMT(extack, "Duplicate traffic class index specified (%u)",
+				   tc_index);
+		return -EINVAL;
+	}
+
+	tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_TC_BW]);
+
+	return 0;
+}
+
+static int devlink_nl_rate_tc_bw_set(struct devlink_rate *devlink_rate,
+				     struct genl_info *info)
+{
+	DECLARE_BITMAP(bitmap, IEEE_8021QAZ_MAX_TCS) = {};
+	struct devlink *devlink = devlink_rate->devlink;
+	const struct devlink_ops *ops = devlink->ops;
+	int rem, err = -EOPNOTSUPP, i, total = 0;
+	u32 tc_bw[IEEE_8021QAZ_MAX_TCS] = {};
+	struct nlattr *attr;
+
+	nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
+			  genlmsg_len(info->genlhdr), rem) {
+		if (nla_type(attr) == DEVLINK_ATTR_RATE_TC_BWS) {
+			err = devlink_nl_rate_tc_bw_parse(attr, tc_bw, bitmap, info->extack);
+			if (err)
+				return err;
+		}
+	}
+
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (!test_bit(i, bitmap)) {
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "Bandwidth values must be specified for all %u traffic classes",
+					   IEEE_8021QAZ_MAX_TCS);
+			return -EINVAL;
+		}
+
+		total += tc_bw[i];
+	}
+
+	if (total && total != 100) {
+		NL_SET_ERR_MSG_FMT(info->extack,
+				   "Sum of all traffic class bandwidth share values must be 100, got %u",
+				   total);
+		return -EINVAL;
+	}
+
+	if (devlink_rate_is_leaf(devlink_rate))
+		err = ops->rate_leaf_tc_bw_set(devlink_rate, devlink_rate->priv, tc_bw,
+					       info->extack);
+	else if (devlink_rate_is_node(devlink_rate))
+		err = ops->rate_node_tc_bw_set(devlink_rate, devlink_rate->priv, tc_bw,
+					       info->extack);
+
+	if (err)
+		return err;
+
+	memcpy(devlink_rate->tc_bw, tc_bw, sizeof(tc_bw));
+
+	return 0;
+}
+
 static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 			       const struct devlink_ops *ops,
 			       struct genl_info *info)
@@ -388,6 +497,12 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 			return err;
 	}
 
+	if (attrs[DEVLINK_ATTR_RATE_TC_BWS]) {
+		err = devlink_nl_rate_tc_bw_set(devlink_rate, info);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -423,6 +538,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 					    "TX weight set isn't supported for the leafs");
 			return false;
 		}
+		if (attrs[DEVLINK_ATTR_RATE_TC_BWS] && !ops->rate_leaf_tc_bw_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TC_BWS],
+					    "TC bandwidth set isn't supported for the leafs");
+			return false;
+		}
 	} else if (type == DEVLINK_RATE_TYPE_NODE) {
 		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_node_tx_share_set) {
 			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the nodes");
@@ -449,6 +570,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 					    "TX weight set isn't supported for the nodes");
 			return false;
 		}
+		if (attrs[DEVLINK_ATTR_RATE_TC_BWS] && !ops->rate_node_tc_bw_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TC_BWS],
+					    "TC bandwidth set isn't supported for the nodes");
+			return false;
+		}
 	} else {
 		WARN(1, "Unknown type of rate object");
 		return false;
-- 
2.45.0


