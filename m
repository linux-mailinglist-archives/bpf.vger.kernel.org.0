Return-Path: <bpf+bounces-74678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC3CC61BC2
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 20:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEF434E759F
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A1D23EABB;
	Sun, 16 Nov 2025 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KGjAxFB2"
X-Original-To: bpf@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33623817D;
	Sun, 16 Nov 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763321270; cv=fail; b=ONxvle2BtE4rysxDhlOA3s4+9TifaGT6xvGlAS+YWN62tWkkGBJWOo5GkfdOBK/88TNE27ahc3FLl1JUjiIw4HcoJD3Kh+c7pU9tlXPEA3Z6OW+3OqVE3k8fQsQi6d+t61yHEjLQqCNatmc6sTkpHZMyYd0Gyz95bcdChlfYoWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763321270; c=relaxed/simple;
	bh=Zl9cqaGu+SsqdQYKwh6x525WMw2Ui3KcuoIHOMLFXbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8uYt9QavRCmNv/t8wUPElIMHiKVAKBSL+J0VriNOihFRhTvnQ9HwLiEVHuEDbPEEh7TekLHGd+OS5Q8RgKhuKnQ60Dh6MEHU4xVZje3tSw0xMSJ0ao6/N3Tndy3GpZFJBn1MvQYre0JfFjjKiY3LVvelGoiBJHyE02LhlbIFFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KGjAxFB2; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgTiBfCQ3W9A+39dWKsi3XK3Z4FrATS5SJUtDT7jsKUPg8QQ33DaG/eIxchcIJeYiHsg0fXT69KHDIiW4cv+VSJcO84aC8KIkXxZAFbg74lNf4Mkhnalv5+bV5EGhiPggX3EB1z23MQSJqIzAIpOCLvAeghe4G/cMCwqcXnWiawKvD1wOr8B8+aVp1GzMsu62zYDBGQA0UdZTWSbodUP2uKR0ZvnbWRoFSPeJSFJb3d+opAEj9RQYEGBbUnJ3PXcbPWC9pzApYgCV3s8BHA1Sjz5gGX8vWOT2NAK+X9HIny1Zr4zYltQP5ZflpyhdYYZkCUsm3mUKvZpn6qldCOhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkEgz7pNzcBkH6dNlRBoI2Iv5j9AxclV/IBovYLGDeo=;
 b=CXKFLJ2z1wPG5PmfMmzxasJKcw0soyrKEKX31Y/c0/KwnNovfAXHcJT9skJJ8mmIc84sG7cRTpcmJlZRpZZT1d3Im5ajhXcXk+isQjdCPiXkpd3oGAjJpfBqG7KDa7Ppu2ju1KqnLdZz8UnHh5lGQ6y42NH6nHxu4LQxlT3cTIU9eA1JoY93KoPP2NkxUIHQNnEUxlaS/rVYW0RRvhRXMM26uaGCZXIAZOelDiGbwhSDIvJv8fqhWRx03U16rxemlEDh0pADv+B86QaK1Lfj5kH9lbSFpFCShykzm1axyRTQ+wnkLA2ytW4kWrXEtFsHfaSi0x5bNOJsDFu3IU339A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkEgz7pNzcBkH6dNlRBoI2Iv5j9AxclV/IBovYLGDeo=;
 b=KGjAxFB2XCop3dws5xEg5fo0XbJVh/usbp82cYG4smCfxOIKLFT7twiz643d5jVLrgKisZ8IO4C/vI2oQbhI1mjsIz1VaiOQw0KY0O4C0MmkidIME3FRgc6FebEjs+ky+JdaArPXoMgzEn3WjPlVRPOF9poRL5XW85clj/I829zP/OnC9vfZ0GkzTmC6DyFPT+PZ0R2j3wYO+CrKayxjxBPxLPbAc8yrCoGwpw43k5Dg6RDp2UJCr8et87Xj5XnCTx1fMa1pebtOWTezKpSFtKRF0y1C0fphlCgEIB2ubsDc8agGuyKw2FhuZ7tAoaL8+1BkLQtSOX3lugmrtKMufg==
Received: from SN1PR12CA0103.namprd12.prod.outlook.com (2603:10b6:802:21::38)
 by SA5PPFEC2853BA9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sun, 16 Nov
 2025 19:27:43 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::ff) by SN1PR12CA0103.outlook.office365.com
 (2603:10b6:802:21::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.20 via Frontend Transport; Sun,
 16 Nov 2025 19:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 19:27:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:27:40 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:27:40 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 11:27:36 -0800
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
Subject: [PATCH net-next 2/3] tools: ynl: cli: Parse nested attributes in --list-attrs output
Date: Sun, 16 Nov 2025 21:28:44 +0200
Message-ID: <20251116192845.1693119-3-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SA5PPFEC2853BA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c74c04-98df-48a2-7933-08de2546373b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rA3hPhG2MUGLqaNnj3rzfqD11JblJMtp0k5Im31AR5+G2NxGjYNydRkvLlct?=
 =?us-ascii?Q?xEXolUEfEkcE+Ud+yUFb7orE9N1VO5iB3e/3TkPjRFAg20IZZ9Z/wKGh2Yyr?=
 =?us-ascii?Q?8eRpaihD2hcOscSBMCkqR4drE9TX2XI/QRksNR8NkJQna0c6DRTiGK3meDAo?=
 =?us-ascii?Q?S3SbUsdu49n8WWMxlM2Hu3nZyZZc5yAfts8P3M238ETytoqWuk55Pzld3v7U?=
 =?us-ascii?Q?pOlEXBSgZgTs+Ah9SOUiv2Pb7PXLmNPifc02DudII6M791Uey6Qq3eNrneh/?=
 =?us-ascii?Q?623bOQmL7r1oqVssRG5CXWOvEYfpO2g4xT4n3ho8ifsqAMFJp8dL1+IpkLim?=
 =?us-ascii?Q?BbN6hWmlggNfFJE5F6ing02XAQ4Cx4EsjHSjpHgpFDMMB7uAgy8BE80mcFAV?=
 =?us-ascii?Q?sh493eyebl04q7d0KiiEbhj3ZTSwCnV8lA01Gs+rE4R2jX9t/kwPHz+r9EOb?=
 =?us-ascii?Q?usZhHw3BubNspuFx2+Bqi/imAiZQf+henLWvGLscaz4/YWTc8gbS7v6DCy4i?=
 =?us-ascii?Q?NoRSCiabbw+vuHDkPcbwF2bAEsKdrEsSvZxhmau8+bI6gIh9RMMvRK2WiZti?=
 =?us-ascii?Q?oPIdf8QCfW2uTDuXYtOJoGt2FitJUk/ZfG4kAPccE0Y8hoD4S3OdASxHW5mE?=
 =?us-ascii?Q?kidkeKN0hXU5XsY9cJeoRV3MB8KIQrcQCWtmkISNX7NzOk64NUk4UmDdkY5V?=
 =?us-ascii?Q?7r4HFYYZ2ItYHjzg1wgWZGccM1Hel/KpL1AL6xAduCtfkhWKub2W6ibzDKKa?=
 =?us-ascii?Q?CbekDwQ8YMi2pZ2ACYIAqe0Y26838L2YG7tBMKEdiegoG2DBcUMzdeT7UQ5w?=
 =?us-ascii?Q?Jdg9SrfoPzUzVuKb7o5RrAGQHAKCFD/5rdfCvrfqduKxnWvDpJ47S8dkCevv?=
 =?us-ascii?Q?undrLBstvRnxoE/zPgQmt+Wk4kTssyBfXJ/A/iS4CWBPo33YuOcrrVolsOta?=
 =?us-ascii?Q?uRsmVmGFS9XQQN239d1vuE5FuDWLdFBgMDHFKfWVNi0IxYcdn90sHZARkgJ8?=
 =?us-ascii?Q?ozoxTB+kx81OAduGGQtI0D4WP9VQNi4xIYO37ed3+6u2KcN6XgSUA4hLSvbc?=
 =?us-ascii?Q?qBhRBZqt4RZabfR4y7yRZ49t1tmzR076+N89/GHkF8SiMzXvHzXFHxMDRkr6?=
 =?us-ascii?Q?WGFmpCNGzWaqOIKIpi9xvx7otS8bH0uGPHjmpC0aL2A+BNp4jFSVJm8rtU4S?=
 =?us-ascii?Q?p5Rklocd42N8ssa/3wctra8qORoESTVNVfzv6rFtexGWJfA1Bl0FUwuFYfwt?=
 =?us-ascii?Q?ceByj/JWULd5gBkWOW7w4Xvi87hv3jfpgTXF9I8nXpuAaBjzEh8nzl6203rS?=
 =?us-ascii?Q?PPLudC1OIbYl3nfWgXRlnZScdm5WohviAW5tZrvHN02BVs18hUx4xQtS8YWC?=
 =?us-ascii?Q?iMmI2wyyuErPHpvg6M22nthr8jZLo5f/gkG61TMmm0Cecv9zap2AS+L/PEt8?=
 =?us-ascii?Q?jJxXDMp9VItlsPC8S1GwsXvqsOqQ0vTnmhaWUASqzHgI/jqEhTp5MINSQNx/?=
 =?us-ascii?Q?eT1TxXhiG+6a4TpgPSatKwlT69HjZe5gTWF+0u0rZXSGoH201qfnM9O6Wp3b?=
 =?us-ascii?Q?ZJuqB792E2VmAQIkEZc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:27:43.6545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c74c04-98df-48a2-7933-08de2546373b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFEC2853BA9

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
---
 tools/net/ynl/pyynl/cli.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 7ac3b4627f1b..3389e552ec4e 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -131,20 +131,37 @@ def main():
     if args.ntf:
         ynl.ntf_subscribe(args.ntf)
 
-    def print_attr_list(attr_names, attr_set):
+    def print_attr_list(attr_names, attr_set, indent=2):
         """Print a list of attributes with their types and documentation."""
+        prefix = ' ' * indent
         for attr_name in attr_names:
             if attr_name in attr_set.attrs:
                 attr = attr_set.attrs[attr_name]
-                attr_info = f'  - {attr_name}: {attr.type}'
+                attr_info = f'{prefix}- {attr_name}: {attr.type}'
                 if 'enum' in attr.yaml:
                     attr_info += f" (enum: {attr.yaml['enum']})"
+
+                # Show nested attributes reference and recursively display them
+                nested_set_name = None
+                if attr.type == 'nest' and 'nested-attributes' in attr.yaml:
+                    nested_set_name = attr.yaml['nested-attributes']
+                    attr_info += f" -> {nested_set_name}"
+
                 if attr.yaml.get('doc'):
-                    doc_text = textwrap.indent(attr.yaml['doc'], '    ')
+                    doc_text = textwrap.indent(attr.yaml['doc'], prefix + '  ')
                     attr_info += f"\n{doc_text}"
                 print(attr_info)
+
+                # Recursively show nested attributes
+                if nested_set_name in ynl.attr_sets:
+                    nested_set = ynl.attr_sets[nested_set_name]
+                    # Filter out 'unspec' and other unused attrs
+                    nested_names = [n for n in nested_set.attrs.keys()
+                                    if nested_set.attrs[n].type != 'unused']
+                    if nested_names:
+                        print_attr_list(nested_names, nested_set, indent + 4)
             else:
-                print(f'  - {attr_name}')
+                print(f'{prefix}- {attr_name}')
 
     def print_mode_attrs(mode, mode_spec, attr_set, print_request=True):
         """Print a given mode (do/dump/event/notify)."""
-- 
2.40.1


