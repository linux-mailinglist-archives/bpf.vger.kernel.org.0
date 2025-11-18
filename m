Return-Path: <bpf+bounces-74984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BB94EC6A084
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 15:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66CE534DAC4
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A15F35CB69;
	Tue, 18 Nov 2025 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FYsSVp7f"
X-Original-To: bpf@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A06B3563F4;
	Tue, 18 Nov 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476299; cv=fail; b=uyhB5CQ4ewHEeERvDV3OMekR0/9mNzzg5fr7f78/8Awu7HB73BMbXveh/CEsnJU+1amnvgvVEKVXHORL08rGsKzNGadpq8d785fCsyfv+3pgjNBGlEVhlvdj7TIAE+ZVzIdASpSqvdXZ1X6hGtIUx/Gr5zycS/yo8MJDosgZRK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476299; c=relaxed/simple;
	bh=E91tSvBZywyxrM27JfB2kkcQ6m7pTVSdmdC7ugs9Sg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7NahIjbD0olfc1Wg5MK7jNn2Epz9NlieA9h7OClzBWbT6x6La5Amhhgnh1rfUxZxepFd3u7w1ZH0cUjLMWWxYb2jpJaoxdudRamd//MpZ/EVe3GTzo27AShZUqjxyi+O+JCqjpSJXx6eFzCOyPb2hnaN+DO6S33cCVPAqlrYI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FYsSVp7f; arc=fail smtp.client-ip=52.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqiVe0Xw+SW8hVGN7GrrJMq9UMxRhMjZn3TQ4Z7M48aJGlezoTj0TYJzcfV9Qi7qHg0aHmHa9KryVl1NKeOHO1p0IMbyd8kaSDFTO5SvQcPgE/ANmeISSZSPRzVxp+HEmnzgJKAGnLKYRipXSQyjSP/IB+5xas6fuUUh4lvf2bat17APijyhRGJ7jvrJDRjTn8foH324MPJeHjzs1r8vH/1svgMJDmjjg7zFZmT4EA4EyyhYHi7CmSt6K8RDyT8B3eGzhHfcxYOihNcKKGPgFrdXDT74gNA4JFAxeHrGN9iQPTErt82QHCqePl9OlnQ6qLp0I394YSfcocJmF+tBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q7La9rJjgWBZaZDImzqo8NFa+r6jPs7v+Giud0Nm/g=;
 b=LDIg93oOMT+rWJB5/IePsZnYIG2iSAbfX53CQIN06XtOBrt+Dlqpf55/iN+ybSUnqN4CFdRiC1VFtWK/OxZGK+Z0o85AThnhmweq/9or/JH+IAxJtd63T7LjLz561ylNXQ3+SPaaNe05k1k38rAWMF7kh1bV4taCGXB3ttZPVwP087bd36p9aYapgv0JduD6UrwznctgzYTMW3lxklQHcCdO80KZuNCYx75EriY2gEf8eQs8TVI7UDJjPWD/VmnnwW26VzGD7MDK7HPsE/zZIf8BvaK5kZ0FeJh2Zzwa3LLVH7P9uCL74vlxNZc+xjWQRwyqMDt30YOkm5DfznoRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q7La9rJjgWBZaZDImzqo8NFa+r6jPs7v+Giud0Nm/g=;
 b=FYsSVp7f4J4e+NB6gikARyY9jFLxeZBf3QXoRPMAXbDL+7m2G4Zo7cVb4Hipoy2+MheGRuQX1up2CZ0+Z5iKOZkpjtX59oBkWeAC8ngGgxWVLXzjCcZo1dwDY0huYvsOMAz4o4uwg0LoEWV6eSxJUqk6An1V6COrtvbVOBkM+JzC1FUN9MHn9Sqe5psS5lPvl04ZjeSFLmrw3rzGprliwUKBQl9Y9f3w8xkwcq6ZDAcR7Fc6aRoYZBOyI/miJ6KdVOz267zDdqWTEVa3XvdWX1ico2dNIF3pY3Gf8qCL0kVMIMksxcwozTanB3B69e/9eKmP7xygAbkVD2qU46+AXw==
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 14:31:32 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::5b) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:31:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:31:08 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:31:07 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:31:03 -0800
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
Subject: [PATCH net-next v2 2/3] tools: ynl: cli: Parse nested attributes in --list-attrs output
Date: Tue, 18 Nov 2025 16:32:07 +0200
Message-ID: <20251118143208.2380814-3-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 755ab8cf-101c-4e6f-d40e-08de26af2b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OivanvlKbxyycaDKFfJthANO7XoRH6O10d1LqJSsTMjKDuLLkabx7ptyDJMu?=
 =?us-ascii?Q?R/1cUvxNPUNoLhn9suiEegC7zFjMBHPPXfPLPD2PE0uH3+a10Pb44TxwSpYa?=
 =?us-ascii?Q?PQVxKKNEhFCiSYQ/hkXXN3i+7mcvg+2MNXYUJJfOkMdN8QTb+zMQmWKUZ3iQ?=
 =?us-ascii?Q?blyST7ypPTlGYFBJtLpUysFj8hj3P+4CK7M0jfIz+n6UMjUnE+hVDVYpQ9IX?=
 =?us-ascii?Q?fy/kC7fUeXb2Fxg8DcVKIzSG5s7lWcctzuobgh5GSUcnRErEtIq6a7/nGtK/?=
 =?us-ascii?Q?1S3yC3URVgzWVi9A3fj6kaAdy5pBk89QekYUU7Ef1jyWw8Ov0ADMh1ptD5eW?=
 =?us-ascii?Q?OHsJ2EVU0TV4A6kpUYNB3G0l884grcriF5/3cC0sohogqKbCd8IACWcBe+eh?=
 =?us-ascii?Q?zQ0NPAkXuvn781c4wtpviNbK4i3q4tpA61+U6YvygYwaKkqy0HR+drv3Ejk2?=
 =?us-ascii?Q?nO7OFq4FaNFxnhq50dILQV9aps+l5QK/tlcJB+2I7co2LE7Fr5nIvO6lKpj0?=
 =?us-ascii?Q?C7WJhjDkGakdv6gjVHSvxWQ8icb6+7hDPYTKh6uz0vf/GNYYYMbSdDcbLyPd?=
 =?us-ascii?Q?wSrCqxL9SGZ7JG6KpUiwTP2iCHXW5fbeD0ZRFeZEOMOuZmDmFMxsFnnz7lI5?=
 =?us-ascii?Q?irt4d8zl7O3ymin5wQKNF8VogNC3SGE2jSfY8l0gTQxDrf8D6FxT/ChrBXCl?=
 =?us-ascii?Q?PxNl3WoKWJypWxiK2kBBN8NZy8eI6X05gJmriG28q3wI1QeDktnNka7m+Eo5?=
 =?us-ascii?Q?sf2kXjx/Ic9MBfkkyyTBbj2+Ks21vzf4+L16s9XtqF6sgdutdP/3ld97o5gh?=
 =?us-ascii?Q?r69Gor5W0BmsVFawMucdH3r65V27ova4xB9tc7q/v83YmvHpDlOxqkQgtWB2?=
 =?us-ascii?Q?ysG2tAumVi3FewQ3Xt8unAUDaRMXkZJ54oco3k0bEmaGmyCfhtqj/i4ckg4K?=
 =?us-ascii?Q?Qz9iiC5ZeL9Z67kaW66Nezzyi3DfWrRlfn4wOuNKL2CXniCGzDLzTeoRafna?=
 =?us-ascii?Q?bPh8nSWC+kWFuOGaC03kep/YOqdbhz443+L1pCkEXFf1tzLNbgitSSJYsfZl?=
 =?us-ascii?Q?zmA9/tepOpu9nvzNVgbh8yjzAoGOiuWIivfErhtYd3d1VobQ/TDxPg196+ZG?=
 =?us-ascii?Q?wVO5WkF9BmqvkEXbs4sIJTpEu+z5XiW6wmZj8aIavJoDvOQu8rL+pYD1njTR?=
 =?us-ascii?Q?aSurW1cdOyeC7knQf8DacU5X2QYIMaBD6S6e6IELSPpOSGuQQ8i3gjZirhcd?=
 =?us-ascii?Q?2QmHGe4whwtQBmltEl0LeemOdkcJRCLYTGPALLIDe58Kyb+n03H2yJKHOZcy?=
 =?us-ascii?Q?9br9zU5cnVevirmofTx5DjaeT5wJRanDyINWMsGM1VNXyJucsh5Xx4kncNAO?=
 =?us-ascii?Q?QWSH2R+Tk/0jBCLN7uLLTF6Tq0XYs6Psn/kmH49iPIjkZXdjHlv5GT0dtLAY?=
 =?us-ascii?Q?X2TBHhVAE4M5HfoTCs1SsPGYcb4E7koLypUEsODvKWPj3lGGTRunLDikKTqc?=
 =?us-ascii?Q?qaN77tkJnLQctRNK58HGJPjSybHmSu1wMF7iz60sHcxV/HT+eVBXcH7IHr8K?=
 =?us-ascii?Q?ZAcehtfHfmu2bSWmmSI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:31:32.2806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 755ab8cf-101c-4e6f-d40e-08de26af2b70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043

Enhance the --list-attrs option to recursively display nested attributes
instead of just showing "nest" as the type.
Nested attributes now show their attribute set name and expand to
display their contents.

  # ./cli.py --family ethtool --list-attrs rss-get
  [..]
  Do request attributes:
    - header: nest -> header
        - dev-index: u32
        - dev-name: string
        - flags: u32 (enum: header-flags)
        - phy-index: u32
    - context: u32
  [..]

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/cli.py | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 4d91a2cee381..6655ee61081a 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -40,35 +40,52 @@ class YnlEncoder(json.JSONEncoder):
         return json.JSONEncoder.default(self, obj)
 
 
-def print_attr_list(attr_names, attr_set):
+def print_attr_list(ynl, attr_names, attr_set, indent=2):
     """Print a list of attributes with their types and documentation."""
+    prefix = ' ' * indent
     for attr_name in attr_names:
         if attr_name in attr_set.attrs:
             attr = attr_set.attrs[attr_name]
-            attr_info = f'  - {attr_name}: {attr.type}'
+            attr_info = f'{prefix}- {attr_name}: {attr.type}'
             if 'enum' in attr.yaml:
                 attr_info += f" (enum: {attr.yaml['enum']})"
+
+            # Show nested attributes reference and recursively display them
+            nested_set_name = None
+            if attr.type == 'nest' and 'nested-attributes' in attr.yaml:
+                nested_set_name = attr.yaml['nested-attributes']
+                attr_info += f" -> {nested_set_name}"
+
             if attr.yaml.get('doc'):
-                doc_text = textwrap.indent(attr.yaml['doc'], '    ')
+                doc_text = textwrap.indent(attr.yaml['doc'], prefix + '  ')
                 attr_info += f"\n{doc_text}"
             print(attr_info)
 
+            # Recursively show nested attributes
+            if nested_set_name in ynl.attr_sets:
+                nested_set = ynl.attr_sets[nested_set_name]
+                # Filter out 'unspec' and other unused attrs
+                nested_names = [n for n in nested_set.attrs.keys()
+                                if nested_set.attrs[n].type != 'unused']
+                if nested_names:
+                    print_attr_list(ynl, nested_names, nested_set, indent + 4)
 
-def print_mode_attrs(mode, mode_spec, attr_set, print_request=True):
+
+def print_mode_attrs(ynl, mode, mode_spec, attr_set, print_request=True):
     """Print a given mode (do/dump/event/notify)."""
     mode_title = mode.capitalize()
 
     if print_request and 'request' in mode_spec and 'attributes' in mode_spec['request']:
         print(f'\n{mode_title} request attributes:')
-        print_attr_list(mode_spec['request']['attributes'], attr_set)
+        print_attr_list(ynl, mode_spec['request']['attributes'], attr_set)
 
     if 'reply' in mode_spec and 'attributes' in mode_spec['reply']:
         print(f'\n{mode_title} reply attributes:')
-        print_attr_list(mode_spec['reply']['attributes'], attr_set)
+        print_attr_list(ynl, mode_spec['reply']['attributes'], attr_set)
 
     if 'attributes' in mode_spec:
         print(f'\n{mode_title} attributes:')
-        print_attr_list(mode_spec['attributes'], attr_set)
+        print_attr_list(ynl, mode_spec['attributes'], attr_set)
 
 
 def main():
@@ -180,13 +197,13 @@ def main():
 
         for mode in ['do', 'dump', 'event']:
             if mode in op.yaml:
-                print_mode_attrs(mode, op.yaml[mode], op.attr_set, True)
+                print_mode_attrs(ynl, mode, op.yaml[mode], op.attr_set, True)
 
         if 'notify' in op.yaml:
             mode_spec = op.yaml['notify']
             ref_spec = ynl.msgs.get(mode_spec).yaml.get('do')
             if ref_spec:
-                print_mode_attrs('notify', ref_spec, op.attr_set, False)
+                print_mode_attrs(ynl, 'notify', ref_spec, op.attr_set, False)
 
         if 'mcgrp' in op.yaml:
             print(f"\nMulticast group: {op.yaml['mcgrp']}")
-- 
2.40.1


