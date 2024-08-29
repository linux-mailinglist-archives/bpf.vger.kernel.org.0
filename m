Return-Path: <bpf+bounces-38367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CC0963C06
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81B21C21D11
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED3416133C;
	Thu, 29 Aug 2024 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P2X0AOrU"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FB012F399;
	Thu, 29 Aug 2024 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914609; cv=fail; b=hoqrEc4Vp2a0y/8I1vySUqhVpMWZcKBB/3vroaTOB2PN5TLMyrl92837P3O6k1PjJKnVdqy9mq4UqTOdE8LBMc7x81bPscINa2jaH+gjVHRfJTpkSBzLNvN1kGn5JO4COUmaiaxVychZY6/EgyISPrRLzz7AbJbtEhGiCJP96eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914609; c=relaxed/simple;
	bh=Yd7kHIstzaKZPnS/hfj7iY7LqX+mVT60c3XaedVVdU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d8TpMI1Ih3HjzUOCGrYpmweT3mHRt8ptGUfDiuXs4vVfS5olgPqu+Co/J8vzAXlBIaOooNqWy4N7vhdgSrZ3lLyiTlZdEB/odFdFnL5tq8QVeHngCmOQacwCa+MLGmSpwAQbneHh6i6ZApuvhzJAhpTS1qTlz8GI7BL1u1HK+pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P2X0AOrU; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM3lnT/00XvWtG+CjiQb0vM/YdhZuqtwPZyEpkkMjmyopOEkhlJdkHTjgbmWsXwk3rO0weDRvryPAnXS+m3QXl+rhmk8fk0vR4LgNicm0eFvUDliUp9F+t/pxCsH2hLnnNyYVCM46y9Lym4QcR9vWrNrpmPol1tkuBcxUpFN7NIE8yaekl4tod6d66aMimjBzigt0oE/RZD1e1WJjPynXHIkRr6SUIybblZLgWK/5PvrIT22wOcbh4J2Ooihil9O7dhtyOpBrY89DK7XSZrc+Vzufr0+FBLxN1PXfPVGp+Zj5Be/kPegq3clDsOKgWgH+A48yGZfSApyvxOg/Fjkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tezgj+th5jTvZbjXyOysyD4PJ1Bk5Phn+Zdgp9mAK0k=;
 b=XFiWPgpMy02BRYGPuccIRYiv93gGeH+JGXu7QrnjUq/O0IF/hXJ2O63Jv2aBpepFevhvDuh/jBU2WRBD9oc79DBLa64PZmS/mO9Q3JtAGkIj6gfhyleDk1x7oSJitL8vz9vsNCecXpxcv75J+6SmYm9dvZ/qK6w9RZxlvNaUTFHnMyg361cZSWYGzYIRDA5j3DAPCjP0i79W7CdeOPayrTLGkNsgnoNOeR0aYYnAAoi++O1LPZJ2KT1o7Cxp1Bk7IHGhnfXpI2bD9Ux3y0e0GJ1ReUhJFbTSi0FhoqR/fW7vpn4iLICbduBGLb3Gp1tSCiP7hTEAi2gOW41kmr2UdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tezgj+th5jTvZbjXyOysyD4PJ1Bk5Phn+Zdgp9mAK0k=;
 b=P2X0AOrUay1Tm0vW/jQ8WqS9H95AGwobo07kgGb129L3PCMDL13KZXox9/sgaP/v+gzxf6PtZyZwDPc0qtcFluVQLRxbU9KNs1XFlmHgbu+X2k9ftEx9zqj9l+aBkYnKRw/ElpCTIG8YpSFrOHx1Gat7lBvmhNkjauMctsKr8suN5TeojMTTZHLiwVmRJiHJ+J+iEPbDIYc2aHxvdNDaz+fVA72kDi8OGxrLEmDn/qhdWZpY3UKlWRQcDji9mWlT169LBe1NTzCjcIdexnWUqeZhQnsRb50QpGoLX3bsKvCrLblI1iTURmlcCN01dFvJaUSm6qayk20gVcewCDh/pA==
Received: from MW4PR04CA0196.namprd04.prod.outlook.com (2603:10b6:303:86::21)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 06:56:44 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::95) by MW4PR04CA0196.outlook.office365.com
 (2603:10b6:303:86::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Thu, 29 Aug 2024 06:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:56:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:30 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:25 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 00/12] Unmask upper DSCP bits - part 2
Date: Thu, 29 Aug 2024 09:54:47 +0300
Message-ID: <20240829065459.2273106-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 8296dd48-eee5-4e5f-eaa5-08dcc7f7be1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EAn3TXqADWGnjVdKNuCFvurj+CmUiRrGw4+tE52T433qzrfndI7ijfjdi7y0?=
 =?us-ascii?Q?6kAVJzRqNazVQ80vcaQwwagp/hKbOD0laTj/fgQAgUvallxThJhVSYhDApd/?=
 =?us-ascii?Q?lDv66fqoTQdWeJCCHmRxVzPPFbr8LkwBcXgVt6pfi3WNoJBz9zZHW3moHlHk?=
 =?us-ascii?Q?uJ2G/tvUsxRLb3DUOMymvV97rXsScqFO4tquZDIWNH2WZFvYHuQLMT6TUiA2?=
 =?us-ascii?Q?HagFu86sHWhusE1KwLB79zG0Nx+RR7tfVJm/SbAfiRDye0HPBFdecwm+18ek?=
 =?us-ascii?Q?Tn5jTY7hf35xh+i2JSAZbFx2L62892w4uNoVyYNOx9LHiqSsj1l48tXVhM0v?=
 =?us-ascii?Q?RH9AnOsNaAvGMnyVQVA+fxEO0GJCTT45ifn/IQ5Nnt7myUn0CB8LdbmQzQjv?=
 =?us-ascii?Q?CtWhwHlIVI/4mv5vSpAugTMu7GPdfxnDUF+TRGruQ6ubpKtUsOh2szvrgOyj?=
 =?us-ascii?Q?RKlAX/OJ/NeCvGykBERQReOKaufUnJtIoYGwQTp2mo/t9TgoTgf5F/0jLCjz?=
 =?us-ascii?Q?+xNY/LCTzt6MUk0xzDNZSU5a1WrWjQ+CVNknJOcIJNDekbnhrsoDy6sVDF1+?=
 =?us-ascii?Q?mXf+S978MmD+CGLfHRB8xjG4Ye5SbERDxdOsZfrEvV/YwOBc6F4GXMextSGI?=
 =?us-ascii?Q?99mo8c5eVxrQqrGp+34owQBBzrIBcx8Vh6EbBAusLanx3M/KNqua6q89z9fP?=
 =?us-ascii?Q?KYQUSsTbFzR9zwQ0OmunKxdv/ahckkEQssNQqkBb3z5me3jNXkDmnthM25rp?=
 =?us-ascii?Q?58PuP5sdU3x5iBwWVvL6Z9ep+tih38oFWx3DjR/oNa0fsZvMH8nTSNGbg8Fl?=
 =?us-ascii?Q?+nPOshsfSGOSfTw8nJQ5hpqDLMocIyRvDBzc76n9MhPBz3WBx23+EoAcnP8o?=
 =?us-ascii?Q?9ZVFpEDIXJTSnJXH1J7YEQzIedtHMOhVMXq0bpcZkAl8M7m8BYx/wVQHkfyE?=
 =?us-ascii?Q?KB3xWeWCYkznkLAGyZ/xNZNiqD3dcydoFTFWbf7Y/bgNPNdBxSQ3oMDKMeDL?=
 =?us-ascii?Q?9oxLmSDArISkoCVx8aLyszbU3ajyHddJPMFwwQYRde6TFEJWtHrRIFfG28EP?=
 =?us-ascii?Q?N9koVzb5fQ3fMPDDLPFYtptmQJIIgRPImpx1zcn394jcSSFqyqP9hWQT8zdf?=
 =?us-ascii?Q?921t9T/tVvS6bwGp/ldFaLRNOjCHHFmp9TP+QD7nTomvni9NhSThYEaT4pVK?=
 =?us-ascii?Q?R9cYOwGik0XPNzkDxAkQHi+GAkNucsDXQ/3Bz4LKNtlQ8b19DQUL+l08yI+d?=
 =?us-ascii?Q?w5RByue121Q/u0hqVrOtmKB0RkmjZTvIlqfbK2bCN9FpDhnjFChzeTgNVlDu?=
 =?us-ascii?Q?SRU1IYFc3VeGg12OIbqrI1gQqzcr34YXruVM5Nary1B5fHP9+EfsZtKsl+Wm?=
 =?us-ascii?Q?dCv1PdNYRqEPnOWuo2jHelutIy8QCTAmp763hiJGynqn4SnlhLGcz0mTn9Nk?=
 =?us-ascii?Q?j4XDXmIoAM2CPxrWiL1trtAVs4UvIkXL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:56:43.9155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8296dd48-eee5-4e5f-eaa5-08dcc7f7be1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967

tl;dr - This patchset continues to unmask the upper DSCP bits in the
IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
DSCP. No functional changes are expected. Part 1 was merged in commit
("Merge branch 'unmask-upper-dscp-bits-part-1'").

The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
lookup to match against the TOS selector in FIB rules and routes.

It is currently impossible for user space to configure FIB rules that
match on the DSCP value as the upper DSCP bits are either masked in the
various call sites that initialize the IPv4 flow key or along the path
to the FIB core.

In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
need to make sure the entire DSCP value is present in the IPv4 flow key.
This patchset continues to unmask the upper DSCP bits, but this time in
the output route path.

Patches #1-#3 unmask the upper DSCP bits in the various places that
invoke the core output route lookup functions directly.

Patches #4-#6 do the same in three helpers that are widely used in the
output path to initialize the TOS field in the IPv4 flow key.

The rest of the patches continue to unmask these bits in call sites that
invoke the following wrappers around the core lookup functions:

Patch #7 - __ip_route_output_key()
Patches #8-#12 - ip_route_output_flow()

The next patchset will handle the callers of ip_route_output_ports() and
ip_route_output_key().

No functional changes are expected as commit 1fa3314c14c6 ("ipv4:
Centralize TOS matching") moved the masking of the upper DSCP bits to
the core where 'flowi4_tos' is matched against the TOS selector.

Changes since v1 [1]:

* Remove IPTOS_RT_MASK in patch #7 instead of in patch #6

[1] https://lore.kernel.org/netdev/20240827111813.2115285-1-idosch@nvidia.com/

Ido Schimmel (12):
  ipv4: Unmask upper DSCP bits in RTM_GETROUTE output route lookup
  ipv4: Unmask upper DSCP bits in ip_route_output_key_hash()
  ipv4: icmp: Unmask upper DSCP bits in icmp_route_lookup()
  ipv4: Unmask upper DSCP bits in ip_sock_rt_tos()
  ipv4: Unmask upper DSCP bits in get_rttos()
  ipv4: Unmask upper DSCP bits when building flow key
  xfrm: Unmask upper DSCP bits in xfrm_get_tos()
  ipv4: Unmask upper DSCP bits in ip_send_unicast_reply()
  ipv6: sit: Unmask upper DSCP bits in ipip6_tunnel_xmit()
  ipvlan: Unmask upper DSCP bits in ipvlan_process_v4_outbound()
  vrf: Unmask upper DSCP bits in vrf_process_v4_outbound()
  bpf: Unmask upper DSCP bits in __bpf_redirect_neigh_v4()

 drivers/net/ipvlan/ipvlan_core.c | 4 +++-
 drivers/net/vrf.c                | 3 ++-
 include/net/ip.h                 | 5 ++++-
 include/net/route.h              | 5 ++---
 net/core/filter.c                | 2 +-
 net/ipv4/icmp.c                  | 3 ++-
 net/ipv4/ip_output.c             | 3 ++-
 net/ipv4/route.c                 | 8 ++++----
 net/ipv6/sit.c                   | 5 +++--
 net/xfrm/xfrm_policy.c           | 3 ++-
 10 files changed, 25 insertions(+), 16 deletions(-)

-- 
2.46.0


