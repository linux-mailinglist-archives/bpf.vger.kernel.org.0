Return-Path: <bpf+bounces-74986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E35C6A126
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 15:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 28DF42D3EB
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BF5363C4F;
	Tue, 18 Nov 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FoTZlbqH"
X-Original-To: bpf@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955E3624D3;
	Tue, 18 Nov 2025 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476302; cv=fail; b=fovOSeGbSZqCnzLmTeF9adGIC8TcF+AVXnoPvnxPyHWcJYXw+uP7O1dLH1ltLgts8CQ4TA9YWrarcHqlIRkhXkBiMCSsvr77+sBkYepidYf6AeOcbnp4l7ga1pCf8P/XqIhqIhkENkSzlnU1TnrfJVw4O5MCzp0RY6O1DbXU8M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476302; c=relaxed/simple;
	bh=ji4tajq8MEdhxMq0NZ88u4qn17CS5wdqH0cmnwGeg6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YisFWyBFvfAC2iKiIV8Pyol4sOPVxsgA9KrTFSG+e1VgIjRTIoDKwszTXjAy1wRBSbwpqekvBT7U05vdNXKvJgu3KXtVUhQ3Or7LiTJah2TZ2MwCakH/XzLVM6IZVSt5osMdgphTMDQIvTKyBq1edsbmPSK2UN2wjucEo+XGRSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FoTZlbqH; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPhGUdJLAB9zGxafIh0Boxe+JLJwslmOPHiRheKwYar+BosyOag0R8Nmg3XZvu5cncEqTllK+9ZV1xjYGggP5VV5+2XMV+1Hy6tdkBEkizeFgavF7SHT5YvfvtDo+aH8w8llS0CRnW+Tj/0L/Ve10ud/XSm/pOZPKTZaEgJu5wqoDu1+AaJIacL1kg9Wc1fmZMDRSayEZbesomRmgJBjvZ+z1/2M+J1ahfYEOphrgHiQthVg9difW7fF55/uYy0aNqYBy9+Jf+BhW95GyDnMBn6Yix9ma6/4wFY6oZ1nLm4/mNEB/JDcgTzHDyffFBT5PnsaNhQmGIMtjKPmVlx2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jVuxnVwaImIoZMtD5Llj3S2l2kFakwJYvAeLiI3CR8=;
 b=Rr86kBJBh1TfaQSQuQlK0gk8k0mJ0dd9GY3Fm3oAmPijgHHIYH+er/lhfaMnpxwqM3IgK9zKD3G4zvapAMVjl+NS7VArcrxX5nUEsPBN8noNQ8Tb3OL6ypSjWA1AJmoS9VGfezP0qHHF/O+0q/Z2aR6jiMgtSINHcnFmbYsGNHmpwVzAXlA5iHaDtf3OV0QmswvdutOKYXbrt+u76C93MHQQL5nz4Xb3I2F75gi2uPdQHzfAW2OWbQG8aVQ2h6ufL13hOD499XSODVdhiokh2Hf+36Q9DBarI6BM41EJCWdkse8EZjvsIbX1ZieTYjAPByVqjVTlsowZc8EOfPec2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jVuxnVwaImIoZMtD5Llj3S2l2kFakwJYvAeLiI3CR8=;
 b=FoTZlbqHFXogPpwuOQ7IOSVVDnYkcYFYD89pidGOSxVIVZlf6JseNexNKDTI8Ylc/ZAwaaD1FIfjS+3f/8tYzOD0u+GfmL2y8+n8saQpHZEfRGmU1flUfQzn9Vw4i2ugBM35pG59q3uMkeXlL2s3Nd7maLud4pL59VzA5DJ5erwfU5dvstn1jVgB0MStWOhE0/KfZfDztjGzOisxbhxFkOxKPdGhf1xCnXUev5fN6Cp4SRp9gWwPb4TdPPzw+hNjlklQIHsIs9l4vkvU13jXk2CQ4dSfMlWviJnnohj1m1WF9bqVoAUcQyTorB2dB6h/EufyIbeIhMXXALQ4GoOKyw==
Received: from BL1PR13CA0244.namprd13.prod.outlook.com (2603:10b6:208:2ba::9)
 by CH8PR12MB9815.namprd12.prod.outlook.com (2603:10b6:610:277::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:31:38 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::34) by BL1PR13CA0244.outlook.office365.com
 (2603:10b6:208:2ba::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:31:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:31:12 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:31:12 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:31:08 -0800
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
Subject: [PATCH net-next v2 3/3] tools: ynl: cli: Display enum values in --list-attrs output
Date: Tue, 18 Nov 2025 16:32:08 +0200
Message-ID: <20251118143208.2380814-4-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH8PR12MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: c65dc196-eb25-43f2-29eb-08de26af2ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zvI7iz2t9Sxvyvt0jFku01xYnPVHev1rzlZhigkcCkfZE8cHjDj0WbyUNRMt?=
 =?us-ascii?Q?yHMHk7yhDD3bDxr3cn88AYOPp8B0rRGtrIbgsbSZn2BS/a7WddXVSDk3A+0q?=
 =?us-ascii?Q?Mf3wsWWkKjhDEHQKtRxfQIvX7HVyzL+ULJ+w9VXCCWhozKoXm7Y5SsEbjkAQ?=
 =?us-ascii?Q?1cBjxi/UwTEIQN7oJ94lw24DvHhmQA3NrNmljmWOXe0Z3T7z7Uec0CbFjysO?=
 =?us-ascii?Q?gMjR4Vu1Dd3l5kHxCzgbJAFXb3Gon6tK+Ee3oJ/uV1C8j5Rde3T3QQSEg97w?=
 =?us-ascii?Q?xQblOny73DE0wc3apItQC8iv4EatAlfKVk/f35cYXhTKMg8lqLpuapmzBhu6?=
 =?us-ascii?Q?fN8vqj64+nC3WGnhk7pbpn6yddX3Mi6WqOwwDJ2KH4bSXmUWMo3Gqq8rAMcE?=
 =?us-ascii?Q?jM6llK/25ymc+povssLkGVfwdOOHNUD47xA4H/jkjG71OIUZfynbM5Rs7Zo0?=
 =?us-ascii?Q?LfywQu/r6Nni1Fd/FfMW5c/7vqQQOvHE4zTbX17fmbGXgvvNMC9D2RD8H1q8?=
 =?us-ascii?Q?H0egP7Rmq/wdxN8N3+1e7z5+8xL7eHl8ZJeu2YfXpGLsacrZc6m1EkAgnZxC?=
 =?us-ascii?Q?n1zcUoGLDepAAMPBdL2oSsXSKMSpqzn8DhFsdQn+b6HPW31QzyXP+Ft3Le0P?=
 =?us-ascii?Q?FHncf/PwnXpzfh3m6QykOKwpBkj9NndnM5Gli0dvDbTOi8uJ5ajmbkDYWqHo?=
 =?us-ascii?Q?4ZUMSHFFQZ1UcX1xXQChKmJf9fJ4+jdeQ/1k4SCGUJdmaXNbHzPeWDAocibt?=
 =?us-ascii?Q?p6N6kliq1b9shfkwOaOmvArUQkv7OvaQup+W7C/XF4ywZ6TqC6FtaUzLuI5P?=
 =?us-ascii?Q?l+TZWePLcHOjFf9fYlxtbiMF3di+TsYL+OprWOptJmQSqwbet7mrimfx+r7j?=
 =?us-ascii?Q?iWPtPMnMUi2pQfEZXEqZuOj9Vnph0SPlXePQFOdVw6U2F6+mPvzcMtuR+OoZ?=
 =?us-ascii?Q?FZUkmtPMfSJhXGZcaoaOsSw3q4zeIgfgiE2XXUySkz7cJXrfXlNAqOQVpfdv?=
 =?us-ascii?Q?F9Qb8x99LUYmdOMrMVUhHchiJbl6bXGKmA/62OIX1dZuPKeGH6qhdZ5ya+1x?=
 =?us-ascii?Q?H4nBHl66pBt7499rfW1gMxosbW3S+F0wDoGCzs4l3nRe4rCw7cUzKS6Vv/qC?=
 =?us-ascii?Q?jlJV9jecUJNy+vHIXCiF5gazrhs7FeQGHV0uDxylin9qP+MnQ8lm/vrShnLe?=
 =?us-ascii?Q?QbbjXXZMFzrWFGLLcklCao2HC0DAeTL5g4RDM33ngElbFkXhxurnKO03KESd?=
 =?us-ascii?Q?zmMcvumzrCuzLqhMT+3cNNq0RTF+0Wa9uxSY05fwQKIHYKfPFh/rPecnb5g6?=
 =?us-ascii?Q?MWUK+tiOLUbj2hyFvqwva595p/cqh8ysxHj/UipvcEM/CIufeRWY3dVSx+SL?=
 =?us-ascii?Q?5xMNjuoGZR0U4Smwb516Kj/ip14GUNfOjyd7o3wzjZCOqlaAu8ncYc1vOOcI?=
 =?us-ascii?Q?riP937rKzyayFIELiLOjV1/qFFas4QbpK3qFvJQiy1vV47mcrvVsTET4Ywu2?=
 =?us-ascii?Q?Xv3Uj1OvAPyXdlFuTpMUtzpqi8RrALUf9URC6q4+9EfF14Fgs/80+iizMSzf?=
 =?us-ascii?Q?/6Ss1Wm5eSY8d8xNEng=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:31:37.4785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65dc196-eb25-43f2-29eb-08de26af2ea0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9815

When listing attributes with --list-attrs, display the actual enum
values for attributes that reference an enum type.

  # ./cli.py --family netdev --list-attrs dev-get
  [..]
    - xdp-features: u64 (enum: xdp-act)
      Flags: basic, redirect, ndo-xmit, xsk-zerocopy, hw-offload, rx-sg, ndo-xmit-sg
      Bitmask of enabled xdp-features.
  [..]

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/net/ynl/pyynl/cli.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 6655ee61081a..ff81ff083764 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -48,7 +48,13 @@ def print_attr_list(ynl, attr_names, attr_set, indent=2):
             attr = attr_set.attrs[attr_name]
             attr_info = f'{prefix}- {attr_name}: {attr.type}'
             if 'enum' in attr.yaml:
-                attr_info += f" (enum: {attr.yaml['enum']})"
+                enum_name = attr.yaml['enum']
+                attr_info += f" (enum: {enum_name})"
+                # Print enum values if available
+                if enum_name in ynl.consts:
+                    const = ynl.consts[enum_name]
+                    enum_values = list(const.entries.keys())
+                    attr_info += f"\n{prefix}  {const.type.capitalize()}: {', '.join(enum_values)}"
 
             # Show nested attributes reference and recursively display them
             nested_set_name = None
-- 
2.40.1


