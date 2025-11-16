Return-Path: <bpf+bounces-74679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C4CC61BC8
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 20:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07ED24E9022
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 19:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0620257AEC;
	Sun, 16 Nov 2025 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pDoz/aXP"
X-Original-To: bpf@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59052475E3;
	Sun, 16 Nov 2025 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763321274; cv=fail; b=goU6IEY8WN2vH7ZKQXI5+aL7uwyhk9fSKAgAEIbn0XYigEH54AqP7n6JlXBcTa6cXQon7hIzyzHUoVCtWxMWnIOEYYLJdWTWT/3VfUUFnnBIs9MGG2mf1/HE2ay/RGzHEQ41mmlvnOH63vDiwK5w2NjJ7CYuimj8Y9UqV7lCImc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763321274; c=relaxed/simple;
	bh=8Dr8Me3jBFh8Mcib+FcRxOAy2Vjer40xUgz2CmZTUoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhEVUWF9vMU1T5bGWWc4Af3h60zHGN/qeZiCGKVvrtR9dvRoRxEmbH3w5aR6EBbQRLcbS6FZmvKGBfc4GKcyqh5+hFlb95IlngOEaHRIT4gXfPWyu0XFjebdHCKPRJpCNh8P2Hjs+Bq5VH1GGXMzX9cQfs2vvRaQnR27iuotKQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pDoz/aXP; arc=fail smtp.client-ip=52.101.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bv5wGejqg8EiHQe86EX4pYh48WKOJSILBk5uNE7OfK5E3jJf45X57sor9xigOdO8LCVH8vyxRJM3yVBt9nQVi0rYxrEaEHCMfDHoiqqdxjL0mONA9XE/lNB5jEbOfWBnMJKu+irr1jHrSt56R5pcNtEaMXrcP4cThPr5X9fLAtn+l9MxAAcaLnLpYqvJ6Lw27D4374DC6uY+Q+pfbapm4NMFQkYk/EU75xAiKhBUWk3KcrKEFJH/MJ/TpRxYvek6YHm9WOPIfSribC0NcDT5XwUQbLwkAKRNht+wNk1mh2MZccS7bUWWSGJbImJwB2R6nA0K1Bq2zLM3uquWHmWOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ugwHUULs9SA/rCpfaKmNrnUIpKOw2X3v3AqtJQ5SOc=;
 b=EPQPO+atkOWAUMP2kxivh7fkZxdk1CYj5SgMCJ1pqZICq/pb1Kod2lpMeI+ACgQconhN6tI5v4SaJ1SDQu/+Rr1VwdplkfFeoQv74MvKjyxL2OVCmZxU57IJMSsQN0LBTsXA4OMMRz2aOjlNow1C7dSr+7K/HjackHz7bohni2vJGzsKJjoTb2sfCp+KWZXbpjWIAZz6Yg2lF4hkBN6V2SCILiwceEvCwW/LEwC76M/nVpJErJKYBXbxvPTpFYLM8uEtMiGTqITDTKSGLuzD/kfo3KaXQKED4WtwoV3Rp8CKqA/VuwrMF914d1xy61PxXXKzSlNiVA3CFJLlEmWp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ugwHUULs9SA/rCpfaKmNrnUIpKOw2X3v3AqtJQ5SOc=;
 b=pDoz/aXPzLfiDlESmTXFUf+sDinf6x6Y3wLD3H2NfVidiEB6+XbJL+Nap5Vg559j/9Kwk7/Q5hPI+XYYTpyYUDqFWewjT9+Bn4JPscDYxF61UcIRa7J6j++RK02ifH6PnJ9nNqKEH+HgMSw4OULDWEQafkAoBf+eYvw5Ox3bd4rkYXZi38/D3FHbo/P6NCfAp5rsvfVCrnV1UZiaJr0VNUD0uJJUELH31JPWtZ1rvH0jl+VKVXuWMwqTmmNfmM4lHY9PtDWQO23+tPJ//RW2LuUZHBahRY/+IKrmXMNQgQd0Ch/rG0aC8aofcUKVR8NrC12bD8s9hRAg63BmzNVraQ==
Received: from SN1PR12CA0101.namprd12.prod.outlook.com (2603:10b6:802:21::36)
 by IA0PPF7646FEBB5.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Sun, 16 Nov
 2025 19:27:46 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::cc) by SN1PR12CA0101.outlook.office365.com
 (2603:10b6:802:21::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Sun,
 16 Nov 2025 19:27:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 19:27:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:27:45 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:27:44 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 11:27:40 -0800
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
Subject: [PATCH net-next 3/3] tools: ynl: cli: Display enum values in --list-attrs output
Date: Sun, 16 Nov 2025 21:28:45 +0200
Message-ID: <20251116192845.1693119-4-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|IA0PPF7646FEBB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 2420a710-6b5d-4c98-71ff-08de25463883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VOq9GOtAGgHFh/13v38oVeQ6a4TCJYDlkspqD+ZIKPprR35HfKaJQTSz1J2W?=
 =?us-ascii?Q?vKysTQwSioF1T7uisRTLxcohRBwYh+kTWfZa3Dn92n+g56Su89LBxYLf9jtI?=
 =?us-ascii?Q?y4PYOMqx58xj0/NvVFUauDlLgMGcNEYPMD5tHY+2dssjg2crC3UBu0LF5SbC?=
 =?us-ascii?Q?8STlLtwCQuhB35I60ISngAj8EBAszkD4MuFJAZvxPpFHpUGopVRCR/UyK1zh?=
 =?us-ascii?Q?BE4TNDldZUt6C9REMLsYC4YmPKVGUx9L6f2MdzIrL7kXVamcsFqjmmpLrN8I?=
 =?us-ascii?Q?qC19yvcyQ03R4ql76GHaCm0W9iSb69htBSaQj7b5zT/G17svCdVdngUNcv8/?=
 =?us-ascii?Q?r7/RNp1auLdJ2BGx2Gr5rxY0lTOIxL8eCvP9yOzqVQh1P1UzT09Hls0XDtaW?=
 =?us-ascii?Q?VyYTsi/wR6KzWWVCaAAqwSb+slibHMQ5NC/fSq5IgKd24KagFl3+nbVx39sV?=
 =?us-ascii?Q?0fAeVwAYs02pvcww5HGLG56GZdOMbPpo+akyplupWyOmLXKFfchqywUbOV4w?=
 =?us-ascii?Q?xE/xmRkFi8pSAogk5PFDIa4/vLyjZvX0PLMQ6nb49XcYmxMBZGeIdtJ55rQ/?=
 =?us-ascii?Q?10WThZgK13ik5+Sf6MAXrZLWbJx0YeT7Iw9qSo8CbJn9KFd8+DfxbGefZRXI?=
 =?us-ascii?Q?d0a5gTBtuHe+W+TH8hnfgA8GghMA/7zoVP446gUk7sbP3bsUfGIGpKSvmoWZ?=
 =?us-ascii?Q?Ga8Kdrfbk5RdaAo1uBbWZdGz554oOHyj6SdXp0Q7iVT3JbGib/RQ8IQ4aFYi?=
 =?us-ascii?Q?s/eN2QUdde2x1nyYRkvRsYv4Kvv8V9l2JSmB2C+I22srbAr8UPnfBoARg17I?=
 =?us-ascii?Q?DWKUUgyAapwhbnyG0MbLw9afQl1A81FXDDtnprtvWoreuvXM++orQbfMAtJA?=
 =?us-ascii?Q?B1trm7AVBSWwV50hhZPK6MPwZas/ayDGPuAwoPRWBl7qzO6FT/XWBFMQs1h3?=
 =?us-ascii?Q?Kamkz8KjDq4WlJ5KAcTLHcnS4hjsf6ZI7NRN1ZfB5EdbblXK4L0kXUE+wK61?=
 =?us-ascii?Q?siwACNoOQUgbP1Q+ZLPrJaHsFw3amMQGDTB30ojknTtjpiqaCsgo8IRHmZou?=
 =?us-ascii?Q?aYU0YsuPXUb5d41CR2N3qDkti3m/11oxDbcwlQ53uncTY0RglNMFk+0DEnLV?=
 =?us-ascii?Q?zUmbnKvtGqHyxyTlIGS5eASyU1LHXA/5gZfnEnRxt20o0fvaLaUp6EDKbmN7?=
 =?us-ascii?Q?nM5nPk0lMJUhUS8MwkYsp51WMWlt6kZgUtvOiVnxUHqmvSFl0/Gmxdlhejno?=
 =?us-ascii?Q?IfIdA6N8k8WrocOdyRm1Rb+rqbQKQZbfVtsjRWCBc6/mk7CoD19/s+1y9+Uy?=
 =?us-ascii?Q?u5wRk2cy0Vn7zuHMWpxH4VZ1O1E2XAUeCkX88Cp1opw1h/3Q7WaNhpGMHJMF?=
 =?us-ascii?Q?TF9JVN7yOE8PhND9BP3NC2F3vi5tkuHPlNr/SX2AcX50fuIAhu1Fh/4G+6RM?=
 =?us-ascii?Q?C1ucWILxmpAJEhPnr30OVFP67GoVbtjKoLdPIN8eQGOyM/S5CTAxQ2tG7KDB?=
 =?us-ascii?Q?VyctpA6w3J5YXBbRTStWYoW4BSrwhRiNSxiYErpbtwq6xlf7h1akLyVaArs0?=
 =?us-ascii?Q?d7ptQSVBAiAWB6jVhm0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:27:45.7980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2420a710-6b5d-4c98-71ff-08de25463883
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7646FEBB5

When listing attributes with --list-attrs, display the actual enum
values for attributes that reference an enum type.

  # ./cli.py --family netdev --list-attrs dev-get
  [..]
    - xdp-features: u64 (enum: xdp-act)
      Values: basic, redirect, ndo-xmit, xsk-zerocopy, hw-offload, rx-sg, ndo-xmit-sg
      Bitmask of enabled xdp-features.
  [..]

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/net/ynl/pyynl/cli.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 3389e552ec4e..d305add514cd 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -139,7 +139,12 @@ def main():
                 attr = attr_set.attrs[attr_name]
                 attr_info = f'{prefix}- {attr_name}: {attr.type}'
                 if 'enum' in attr.yaml:
-                    attr_info += f" (enum: {attr.yaml['enum']})"
+                    enum_name = attr.yaml['enum']
+                    attr_info += f" (enum: {enum_name})"
+                    # Print enum values if available
+                    if enum_name in ynl.consts:
+                        enum_values = list(ynl.consts[enum_name].entries.keys())
+                        attr_info += f"\n{prefix}  Values: {', '.join(enum_values)}"
 
                 # Show nested attributes reference and recursively display them
                 nested_set_name = None
-- 
2.40.1


