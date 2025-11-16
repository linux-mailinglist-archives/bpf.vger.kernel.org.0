Return-Path: <bpf+bounces-74677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69615C61BBF
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 20:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C48A74E64FA
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 19:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB9C255F31;
	Sun, 16 Nov 2025 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qgl+FCPt"
X-Original-To: bpf@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0642472BA;
	Sun, 16 Nov 2025 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763321265; cv=fail; b=ZRJSuXD4ps274mSv1y1zGIKx9snw8OfQJVIY+SDtbMzEUjVPMdIsFKWKqzxJtykDyYAGIx1T4WnDA4db76bea0DhylMm686XGdhpaNPMkiEn+DEFXMcO15An3HdC7u++0R6lWp4IqjlklK4S7kCTBmvI2oTEhFjpyfvKdJyKWgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763321265; c=relaxed/simple;
	bh=RDNSfLTNKdMYerkofXaSgA+eUCyNXKpepiDls6uB+Lo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVvoSXHwTWrCm60jDi+rTKuiSReFdcQNIcEnRsb9Q3jDmirTf6aRtnkWXCeXuRzv3pqMQPlGBP93XxQTql/vtn2198ZeXv7j2rRLt/i6on+Q9Mqlq/lo6z0H6SRu0HZYmlm5omHl3c6xgJdW46v1c1Jw9bPqhmdtz60oXrB7kjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qgl+FCPt; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXcZAwjTNcKZRP22fuTVivHdA0HBEViqogFHvuHChaVd4kJhL5TbzN1WLhOTa/3CwrdK+Hm5JIHWTJBUDufko0CMlQAtGUjprMaMV3zQhKuE8qo8J3wKIaFeUW58eg6B+iHYunqQkEI5b6UE/NgNyMj0/UBMxkj5aMMKv7cWZxCfCirjxMxlRC8o9wUfQjfCzH0edfmwLjaIo70vHyFLK0xUWhWDlWAAuRMIeDZ8KSCKUV0xd7wVGpyR0t1UWuVVGuu9JKc5Wbik2aImwhEIxARJOfuq2cKmC8qk95XDYyCN8wyNRTCYDpAAFMR5zH3WFZ9Dec9LdlziPyGXWLHd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM66L3H654kKDNmudnhbxI6aVVlPyL2vcAhlzFE7LkY=;
 b=G8PeTX0GiqJRJpG99dr57ssYmZDXtBkCnciI5J2xg2ZPo7hILvzj4N/j1mKsAF0RQV5u2Sk11YAjyWz5kyTAEXtF6QwtTjXKKyanUgv5DnSF3CwsvCYfsziEj1AHrgrSLBHsZSmIGG/5fVDB+1wVP3ms4PgsIHcShVC7Eh3E7albWnSUWYauh3Y8oA5h3lq7zZF2usYl/UZY19YlueMTZwNZdV9Jil46QCgsyZVNvp9/Lgw/Nkrg+lwATi5WhMne+TAL+wF2+ZbaXkAQ6CEVCKcP6bdrLFzJ9j+SDUJ6FoHbJOpM8u54u1S3Roh/wr9Bd274FUe5CYYcFtY8VX6phQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM66L3H654kKDNmudnhbxI6aVVlPyL2vcAhlzFE7LkY=;
 b=qgl+FCPtEtfNuPfyHa7Fpo6daWzTtymRKoZCkVAmIBlUrLwBZwxMZ4imbdPIJjJF8sSOdAWXK9mtotgDaYv24u3gYiL/Ev0RpsXrNQCD4PxYB/7QWuQLfdwcKkNQWne8dzlCzQeX9HM1iXxaDHa9LFMv8I22EniiKX9lqVwKVoM/Z3x0DNLDNMWRavYJJBkYA6Vk0CDKVy48+BdUuy2JccNuyrMbNz3OnQkKPGN/fSF3cVH1HpCU8fDYWKUt+7nl28wvCq64UruD5MJV8R5osOpAdUOEdt8Gq1p8ZV4kQQ4vtdiBX3GgsPAhPkrpq/XMpq1/CFxHgLgucQ/W68183g==
Received: from SN1PR12CA0084.namprd12.prod.outlook.com (2603:10b6:802:21::19)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sun, 16 Nov
 2025 19:27:37 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::67) by SN1PR12CA0084.outlook.office365.com
 (2603:10b6:802:21::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.20 via Frontend Transport; Sun,
 16 Nov 2025 19:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 19:27:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:27:35 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:27:35 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 11:27:31 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net-next 1/3] tools: ynl: cli: Add --list-attrs option to show operation attributes
Date: Sun, 16 Nov 2025 21:28:43 +0200
Message-ID: <20251116192845.1693119-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20251116192845.1693119-1-gal@nvidia.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ea2dbc-494e-4d4c-d064-08de254632e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yj4Z6nbPUk9Hz1Jb3CDuBnx+bzNkNH6OCZUhHrhBVpjN28zxUwDw/LffE5qn?=
 =?us-ascii?Q?mE7rFd//j0VoXH1/4OIsa0ltxe4A5pK5gQSejEq0iCDzb1HG62mAeESFFojW?=
 =?us-ascii?Q?6jLDGeKOC5KmuWISidARwN7RZ4LXlSCTFzn7y4s4+7WGbnxxEfcrV6q7AZww?=
 =?us-ascii?Q?BGZlPdbMjthhBGJBK8mERKwcQgXfyrCddhiketOfOg/6/zpdIX804quYAZkc?=
 =?us-ascii?Q?2tpqDLstXFZ0inJkT/9fY27+4ShLopD1PqvN1Rz9x2HFLwX/IZxC+flnF4D0?=
 =?us-ascii?Q?FYUVLlT7/opMavcc3rl7XxJi4Qb91f75BfFzcJb52pbcHZ8KBxblul+IDUgZ?=
 =?us-ascii?Q?ZtfPiqQ0xtlddQHX9nfy3n3xEqYehYNQj5mXoczVirCr7ewnnqSkbvR5z6NA?=
 =?us-ascii?Q?7YhoM72T4nxO4UiPmuolaK2NPhV+/wx+bFjLy+7mUuvorxI3fwP4XLZbgs4l?=
 =?us-ascii?Q?Y0HUN3GnKZ2JzSy2oxcGqkUbcEm6Nh9fOQk/oDOxLC/ejlBnU046ddAfyOea?=
 =?us-ascii?Q?RopTp94M8P5Jk1iUA1ihBjq8Gc5IDUUr9B80GdFh27e364Q1bH3rZbtfxrnt?=
 =?us-ascii?Q?2pyAUnurUC+uXs9NU1DdQqZ9jehCPmxpa2pU0N3Gs+5KxsMCMhxaUDqwdl3V?=
 =?us-ascii?Q?9Wtc0cPkLIqHxTqO4NeMfgJXHMZ/TkRH9tKkqLKSv5YszyXogzPCJGZ3esXu?=
 =?us-ascii?Q?Sr2lYb7PY44uvUJkvhjEtfRSvfWtYMSYcaLsIZMr/F86cU1bqBeaep1riLJV?=
 =?us-ascii?Q?N2+SiWluaaSap/F+LuGtLrMj7TsJdau+Pnl0YLjt7g2v6ON17Y0/jL/cSAyy?=
 =?us-ascii?Q?eKugW9Trtk0X0wbAXPW6Ti8xi0U2VFlZI8Uw4gxqpLmV7Wqkv+qTHUS4u4Qz?=
 =?us-ascii?Q?zIKVN7cNhOAQ4NL5yL3FZwvMTQEWZSEQrppgcwRXBPw7W1tMdw2VJaEAt5JH?=
 =?us-ascii?Q?vXD1T/HZNqOllMmHLfJRcck+uBONdgXGomEG/S1Q0a/c0TMtotBbfjtqZJKD?=
 =?us-ascii?Q?i0RF8rFBTI9rPbHQ8jYmPQHhGT1YVUMqC6jv6ldu4Lib1tBxWzdDcoIkbZZ6?=
 =?us-ascii?Q?o2AxcENqOMANwV/LOTie2PElADysqGF4LH7MMEpzAsju+P5uTp/kRfcgKULM?=
 =?us-ascii?Q?z2j8mssHC40JT8ZIvB59qep4O4xrvC78VFDFcb9UjcS1X6mdi8ceiS01efqX?=
 =?us-ascii?Q?luj0SwVByXHseYbLFHF4Zws9/I7irfUjcbERLOKp6I9skCmDoQ/akGJ8KeWx?=
 =?us-ascii?Q?DLU28AnXtjqDW9RKGiwHewzijHoR7I/LBAAUMWCfKLc2RMGp0/BTXE8/udxY?=
 =?us-ascii?Q?Ioxzl6aJYy5XfKb20uwPCbPLzsNaj+K/frpzUKTBX44H0xzWT6PflpHi47+6?=
 =?us-ascii?Q?rUOSyv9hRmdQtMl5X86aQPS5I5mLF2xvsDgURC7q4dWfJZBakYzPdkQ/VAbI?=
 =?us-ascii?Q?PO3ddFHnyVbFyZK/E8ItGZEG4Zb6x/EKyc4kFzhv4sEZcGU3O5+CBFwxMbig?=
 =?us-ascii?Q?THWvkSkzM5TvJfOoX4NyfcEHQ+E/qTxcQm07mgBN03kJ/YRM7tFwBklfRhLg?=
 =?us-ascii?Q?L7T/lZAXBOQtgI2sMQQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:27:36.3756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ea2dbc-494e-4d4c-d064-08de254632e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

Add a --list-attrs option to the YNL CLI that displays information about
netlink operations, including request and reply attributes.
This eliminates the need to manually inspect YAML spec files to
determine the JSON structure required for operations, or understand the
structure of the reply.

Example usage:
  # ./cli.py --family netdev --list-attrs dev-get
  Operation: dev-get

  Do request attributes:
    - ifindex: u32
      netdev ifindex

  Do reply attributes:
    - ifindex: u32
      netdev ifindex
    - xdp-features: u64 (enum: xdp-act)
      Bitmask of enabled xdp-features.
    - xdp-zc-max-segs: u32
      max fragment count supported by ZC driver
    - xdp-rx-metadata-features: u64 (enum: xdp-rx-metadata)
      Bitmask of supported XDP receive metadata features. See Documentation/networking/xdp-rx-metadata.rst for more details.
    - xsk-features: u64 (enum: xsk-flags)
      Bitmask of enabled AF_XDP features.

  Dump reply attributes:
    - ifindex: u32
      netdev ifindex
    - xdp-features: u64 (enum: xdp-act)
      Bitmask of enabled xdp-features.
    - xdp-zc-max-segs: u32
      max fragment count supported by ZC driver
    - xdp-rx-metadata-features: u64 (enum: xdp-rx-metadata)
      Bitmask of supported XDP receive metadata features. See Documentation/networking/xdp-rx-metadata.rst for more details.
    - xsk-features: u64 (enum: xsk-flags)
      Bitmask of enabled AF_XDP features.

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/net/ynl/pyynl/cli.py | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 8c192e900bd3..7ac3b4627f1b 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -7,6 +7,7 @@ import os
 import pathlib
 import pprint
 import sys
+import textwrap
 
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import YnlFamily, Netlink, NlError
@@ -70,6 +71,8 @@ def main():
     group.add_argument('--dump', dest='dump', metavar='DUMP-OPERATION', type=str)
     group.add_argument('--list-ops', action='store_true')
     group.add_argument('--list-msgs', action='store_true')
+    group.add_argument('--list-attrs', dest='list_attrs', metavar='OPERATION', type=str,
+                       help='List attributes for an operation')
 
     parser.add_argument('--duration', dest='duration', type=int,
                         help='when subscribed, watch for DURATION seconds')
@@ -128,6 +131,40 @@ def main():
     if args.ntf:
         ynl.ntf_subscribe(args.ntf)
 
+    def print_attr_list(attr_names, attr_set):
+        """Print a list of attributes with their types and documentation."""
+        for attr_name in attr_names:
+            if attr_name in attr_set.attrs:
+                attr = attr_set.attrs[attr_name]
+                attr_info = f'  - {attr_name}: {attr.type}'
+                if 'enum' in attr.yaml:
+                    attr_info += f" (enum: {attr.yaml['enum']})"
+                if attr.yaml.get('doc'):
+                    doc_text = textwrap.indent(attr.yaml['doc'], '    ')
+                    attr_info += f"\n{doc_text}"
+                print(attr_info)
+            else:
+                print(f'  - {attr_name}')
+
+    def print_mode_attrs(mode, mode_spec, attr_set, print_request=True):
+        """Print a given mode (do/dump/event/notify)."""
+        mode_title = mode.capitalize()
+
+        if print_request and 'request' in mode_spec and 'attributes' in mode_spec['request']:
+            print(f'\n{mode_title} request attributes:')
+            print_attr_list(mode_spec['request']['attributes'], attr_set)
+
+        if 'reply' in mode_spec and 'attributes' in mode_spec['reply']:
+            print(f'\n{mode_title} reply attributes:')
+            print_attr_list(mode_spec['reply']['attributes'], attr_set)
+
+        if 'attributes' in mode_spec:
+            print(f'\n{mode_title} attributes:')
+            print_attr_list(mode_spec['attributes'], attr_set)
+
+        if 'mcgrp' in mode_spec:
+                print(f"Multicast group: {op.yaml['mcgrp']}")
+
     if args.list_ops:
         for op_name, op in ynl.ops.items():
             print(op_name, " [", ", ".join(op.modes), "]")
@@ -135,6 +172,24 @@ def main():
         for op_name, op in ynl.msgs.items():
             print(op_name, " [", ", ".join(op.modes), "]")
 
+    if args.list_attrs:
+        op = ynl.msgs.get(args.list_attrs)
+        if not op:
+            print(f'Operation {args.list_attrs} not found')
+            exit(1)
+
+        print(f'Operation: {op.name}')
+
+        for mode in ['do', 'dump', 'event']:
+            if mode in op.yaml:
+                print_mode_attrs(mode, op.yaml[mode], op.attr_set, True)
+
+        if 'notify' in op.yaml:
+            mode_spec = op.yaml['notify']
+            ref_spec = ynl.msgs.get(mode_spec).yaml.get('do')
+            if ref_spec:
+                print_mode_attrs(mode, ref_spec, op.attr_set, False)
+
     try:
         if args.do:
             reply = ynl.do(args.do, attrs, args.flags)
-- 
2.40.1


