Return-Path: <bpf+bounces-74985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE35CC6A115
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 15:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D8C862F5CF
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760A3624D2;
	Tue, 18 Nov 2025 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m2SldIXA"
X-Original-To: bpf@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075F3587BF;
	Tue, 18 Nov 2025 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476300; cv=fail; b=hlou3hWMihX6rkOODsNpfWLj1dlRejmqKmeTjlItoCqJ+iJYz39ahMyv1p9XbsFSbaxTmdHnIX6SPVUC1VRXY0b9Lp6yHhRIs148KV6Q4suIkfJelznQtR849FSfnucMBkVCeX0j+dbKFcw9hGwUbZJ7L/q+FYJA2EWbW5qoZM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476300; c=relaxed/simple;
	bh=0syKOd9E+T3dlP3R8YAyKADYty5DSnrNMmp3Sh/e8Qw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTdd24vJTVQSdDwsHetrbYB1lb10PA7wZ2YB80p8zB4MFaANTvS1u1gdTKnx3XXztv/sVZ5fBE0f5V92n8nIWmmSAKq/XplMWe6M5cJOvAk+fhB7tyUW6yFwzCVSdW0lb0Sy16B70oS+yC8mU5qI6Lmof+T/2X0DqSvc993JE2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m2SldIXA; arc=fail smtp.client-ip=52.101.52.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODRraR/hRV0eHlgGSIh5P4reaMkKtQ1m5QzyAvnOhXWwrAIWEEWy8mP63waWCOPjUS2ZKu+qnVvJszLsTqBw05I7UL9Ek3820Jb//159b1letDmk1kLSlRvdnIxGZTsGQM+JZZApOL2NpXuKRjTS9gR3bobBdZxDD6wcDPHOARs2b5W4Ro9WqOT9HpfQtwGg/52bGYl5JPcMRA6XlxYRKy9biDw76dRmbKiqaejE32BLQ3ToqQvlLvLYZuyOH1yzLtokvXczvU/nqUBo77FaLaFeFfx7ykd5qw+yM1fYwz9rxOBlfIbi7JTyG1QbuukkAKzQXIWip3ebgQYHeWim5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOIpDzCRN1+wGVTGbQRyAecFnvNyBaMB+TyfrpbqfW4=;
 b=WkcQNfVXpKRDbACkJSpvXKTCN6BWT7Fe3fWGd597aW3086cBC0O0lLD5xFSzioEq7PX275uaN26mKmzpDsrBL3zeQFu2HVF5nFzMvy3gEEKtaRSeNdFdG2/KB7Td2S1tm4lWKCalTblEfSc6P0DZEt/2/16cKbI6BmEqmyTDDCDhPnpPA4efWfRhmMwUQOzqozxs17WpcTkJpV+8fbEZz+dYc8FYXQWT2YWhLd6eQ7AAPYkFn/EnOaC1MXSy3AuMwpqj9n3MsThvY6Kzd8+wLl9ozBThKYLefKk1GkwK91+VSnyd6FRJonz05XHDC95uxlmDf8v8+PnjL53ndJE6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOIpDzCRN1+wGVTGbQRyAecFnvNyBaMB+TyfrpbqfW4=;
 b=m2SldIXAarZpjZurnpnZeCnd2H+uUknX5DBQFPSX8FmFAyzllZNpxDXeA+bjJJQkLkx6Bqr7Mwp9H0PpRvvJLeA6nff5cGF561+CZNQFz0VzVRqbDXlflcq+X8RBKL8FbKSX0TER6t0BqGVUoo3W4059UFIGuDgOVBuqD1rvZmfSUiVsTp3p5KX4MVf7Z2PbfLKkmu/jmKPBb/V3gKnT9dHF0mbNqbJhVgRWPhu8vnVD/Um/Pzic7TyzaWzpWqFt0U3gD2GzatIMQIJ6SEPIDfFzW1ExGTIBzGOTMmGRfGI4T18fcH/8tVpuEhbrp5ViVnogMsnI544zydWQotj4rA==
Received: from BYAPR11CA0085.namprd11.prod.outlook.com (2603:10b6:a03:f4::26)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:31:28 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::1d) by BYAPR11CA0085.outlook.office365.com
 (2603:10b6:a03:f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Tue,
 18 Nov 2025 14:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:31:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:31:03 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:31:03 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:30:59 -0800
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
Subject: [PATCH net-next v2 1/3] tools: ynl: cli: Add --list-attrs option to show operation attributes
Date: Tue, 18 Nov 2025 16:32:06 +0200
Message-ID: <20251118143208.2380814-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20251118143208.2380814-1-gal@nvidia.com>
References: <20251118143208.2380814-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9857a2-fa1f-4ee6-dbf3-08de26af28aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+FJmOKlacrMt8z9//7stONxxHtTeoCp/yufYIU4u6peJw+kqdXedHbSxRoRy?=
 =?us-ascii?Q?LmLTLdC8wPzg7722rwPhJ4Bguw3NDL50/bb78NcE28zN1KnFnELHH2rnfd4j?=
 =?us-ascii?Q?GH3cHkcxMs9IKTRFifnlxDhn+b1YQan5zgDxKicUzq2IE6nW8m1x1o0Nl8Lc?=
 =?us-ascii?Q?OPWpxKmvgDg4di1OlK3N4wYWmsk9k0NMlxubpQsd0/kxwflkoM6xeJ3ZB1OX?=
 =?us-ascii?Q?D8/NcQav4xx2bSdbgD8ikrvGc1yGziWedQQv9e28T/Bk+KhqgW9snQR4S1+C?=
 =?us-ascii?Q?qiwAwyX6i/R5OcCEmKRO3Y4jDkJEvX0hybS32w2ydkjJ8OefLDD4b6U1X5Mf?=
 =?us-ascii?Q?/bHtKndmA2nwgs2DFYs8Gt74kiO/+cxfCcaWwa3V8WUFQCR2W8BhB9TWdkW/?=
 =?us-ascii?Q?y+afS/+HJW55O8Z4NtIh0Zq58kCc9iUoioocBkKkNFd9UYexlyWF0Q/P8yt6?=
 =?us-ascii?Q?4f3Akh5WKz/yDg8uNOUZ6g8xCmW7rOFD7EDyX6fMEWtRCREK7JCdhyCvByKo?=
 =?us-ascii?Q?WFqed/VnZLBOlpb8qgiPAcSHSj9qsb3g5SwNrIxL6pjbKGFAtlRBRwJgcLye?=
 =?us-ascii?Q?HEqhdzV8dkCCmbXFVwTkyVwSGO0KGD4jUf/aUsG1zVV++Ueq1pMdmb3xPwO+?=
 =?us-ascii?Q?kHESpYItMu+bF0N4kB0/dti8UEQ1mHBGWClbDtuZr1t5mldiKfSPaeeiglIB?=
 =?us-ascii?Q?NNr8oAdz9A1R0XdOA7cqfg8oV6w26xz/weA+5xmJ8rhHjmyEoffNk0yM6ex1?=
 =?us-ascii?Q?CltI7kCfk2SoqptF+fyPbCDzZ+m/mmRJlaZp9enfOMAUZuUhkhLxqLTfc7KW?=
 =?us-ascii?Q?IvHCvo1ysPR4y49cMrQ5gi9wc6B1pOou086WL6yqrYvlTQFugxSrDONBpV39?=
 =?us-ascii?Q?O1g8qlCfULUXn/NXEl2kLLNsXLQFOmXmbTBjmAtCRrd4FpTVF2nwgWeWWR7J?=
 =?us-ascii?Q?s104darlxuDvWxAX0nCpdhjPboSKAI/yI8ViBbXQJLYwnyKU3OercTwWyxSG?=
 =?us-ascii?Q?DFg4eFXEnXLg//ti1oZNXWK+nlGE8ss3eIp136/f7ArVpafgpQyBHtn2dLev?=
 =?us-ascii?Q?dml0u6kq2JcFeDba4ksZ9ZmOFe2FdDqF3gvVvtqHkyE1cxI2E2xQEQ65cFDd?=
 =?us-ascii?Q?z/ZpIEeK0yHZ64fGv1aeSmdpxj4Iwe+jhyrpMeG8lDc+tCzvcbJ8LeQyP+NX?=
 =?us-ascii?Q?4x0dG9reeTlaMZqIx0rLQ0Ix2aOcrWbRQiDkUdjCr7fFb1UleZ22TuQw2a+s?=
 =?us-ascii?Q?uzbmx7fwyZLzlF7rZtHP9jLZWKosZUFrytR5licwuD1Spmc/4lwANZPUJeQg?=
 =?us-ascii?Q?ERrPSrygPcurwN+k+e40a8fImWhXIEXWamjP1e81Yp8Gl1U7e5LZoOAytaG8?=
 =?us-ascii?Q?V1OKBjCyRnVaXVBAIljAXia7KNF0bXnHJTtq8zrL4QfsMLU4JogGFhClYZ7L?=
 =?us-ascii?Q?9JNVLvn93/vaCyBoBhVKX9CO1kjrSo/QvMe75FkZaSMOnkZcZsXkVi6KHfVm?=
 =?us-ascii?Q?9b/a6n/82i4imr6U9PgETnc3jp0Y/oekzQlZCzT7t+PdBd2WqEX5ZX4K/MZj?=
 =?us-ascii?Q?F+XBIpeoCOfpAyw1LMw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:31:27.6443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9857a2-fa1f-4ee6-dbf3-08de26af28aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050

Add a --list-attrs option to the YNL CLI that displays information about
netlink operations, including request and reply attributes.
This eliminates the need to manually inspect YAML spec files to
determine the JSON structure required for operations, or understand the
structure of the reply.

Example usage:
  # ./cli.py --family netdev --list-attrs dev-get
  Operation: dev-get
  Get / dump information about a netdev.

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
 tools/net/ynl/pyynl/cli.py | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 8c192e900bd3..4d91a2cee381 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -7,6 +7,7 @@ import os
 import pathlib
 import pprint
 import sys
+import textwrap
 
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import YnlFamily, Netlink, NlError
@@ -39,6 +40,37 @@ class YnlEncoder(json.JSONEncoder):
         return json.JSONEncoder.default(self, obj)
 
 
+def print_attr_list(attr_names, attr_set):
+    """Print a list of attributes with their types and documentation."""
+    for attr_name in attr_names:
+        if attr_name in attr_set.attrs:
+            attr = attr_set.attrs[attr_name]
+            attr_info = f'  - {attr_name}: {attr.type}'
+            if 'enum' in attr.yaml:
+                attr_info += f" (enum: {attr.yaml['enum']})"
+            if attr.yaml.get('doc'):
+                doc_text = textwrap.indent(attr.yaml['doc'], '    ')
+                attr_info += f"\n{doc_text}"
+            print(attr_info)
+
+
+def print_mode_attrs(mode, mode_spec, attr_set, print_request=True):
+    """Print a given mode (do/dump/event/notify)."""
+    mode_title = mode.capitalize()
+
+    if print_request and 'request' in mode_spec and 'attributes' in mode_spec['request']:
+        print(f'\n{mode_title} request attributes:')
+        print_attr_list(mode_spec['request']['attributes'], attr_set)
+
+    if 'reply' in mode_spec and 'attributes' in mode_spec['reply']:
+        print(f'\n{mode_title} reply attributes:')
+        print_attr_list(mode_spec['reply']['attributes'], attr_set)
+
+    if 'attributes' in mode_spec:
+        print(f'\n{mode_title} attributes:')
+        print_attr_list(mode_spec['attributes'], attr_set)
+
+
 def main():
     description = """
     YNL CLI utility - a general purpose netlink utility that uses YAML
@@ -70,6 +102,8 @@ def main():
     group.add_argument('--dump', dest='dump', metavar='DUMP-OPERATION', type=str)
     group.add_argument('--list-ops', action='store_true')
     group.add_argument('--list-msgs', action='store_true')
+    group.add_argument('--list-attrs', dest='list_attrs', metavar='OPERATION', type=str,
+                       help='List attributes for an operation')
 
     parser.add_argument('--duration', dest='duration', type=int,
                         help='when subscribed, watch for DURATION seconds')
@@ -135,6 +169,28 @@ def main():
         for op_name, op in ynl.msgs.items():
             print(op_name, " [", ", ".join(op.modes), "]")
 
+    if args.list_attrs:
+        op = ynl.msgs.get(args.list_attrs)
+        if not op:
+            print(f'Operation {args.list_attrs} not found')
+            exit(1)
+
+        print(f'Operation: {op.name}')
+        print(op.yaml['doc'])
+
+        for mode in ['do', 'dump', 'event']:
+            if mode in op.yaml:
+                print_mode_attrs(mode, op.yaml[mode], op.attr_set, True)
+
+        if 'notify' in op.yaml:
+            mode_spec = op.yaml['notify']
+            ref_spec = ynl.msgs.get(mode_spec).yaml.get('do')
+            if ref_spec:
+                print_mode_attrs('notify', ref_spec, op.attr_set, False)
+
+        if 'mcgrp' in op.yaml:
+            print(f"\nMulticast group: {op.yaml['mcgrp']}")
+
     try:
         if args.do:
             reply = ynl.do(args.do, attrs, args.flags)
-- 
2.40.1


