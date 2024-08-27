Return-Path: <bpf+bounces-38139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE90960853
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A172840E5
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBDE19F485;
	Tue, 27 Aug 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZpwI+rnF"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45A19F46D;
	Tue, 27 Aug 2024 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757561; cv=fail; b=sNkooZbPzMTshNG4GY5VE+dS7zjMhJ+rREw748pX9mCL/k5B0CRGwcggjdpxFH/hpmNwKY8z1rHIaCeZex5WZkcr2eeEhxNdIRERrk1r6iByjoVtb44AD3XB17cByw/id4dfzE1rXq2xhco2zzkFkZCYjQimeNpsjofIG+apOpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757561; c=relaxed/simple;
	bh=UUhJJjnaiqgkXlPoHs+9ZbL/K2yIAY7+0/74rd0vJek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTfVa5bHUk7qzHyZhzcZX6KONjO6ztCifpT5vt+R0ocClL+QomMx5sR7pIJ9p3OPzm+aJCskeYjzHK2nJ0w1T28YXoQa+L7MW5AVKCaijvIo315WsiHiExXc+L/9e13zeZB/jH/L5ATozj1r8w7g8XMIjdU8PofsJ4la4eqw3C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZpwI+rnF; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pibb2UPDJdSll5lsjf2tOUXvjcpqs792Bf2S7Em3n55JKqIHFB0d3Nd2K+0bqAX+Ph4F4ykkHzWq54HYFkoCF/734OBfXGQc1DzzEtutXkcq882t85ZFzV4QTGFzSwgwpCHMB/iHXm1bCa+40D3Whg71Cu4oXxIeB174CqJTAleG5fzG2oLTGxugd+ZYRVslS8ftMShocqxQ18Vo0tmKDIEOTPXn+ablbf7aNUHAmkk9cfIxCv/MowqWsY6LPrp0G+QmCtZ3jN+SXqZqS1xO55lflK5IudZwBNXTaZjsImfXFmOVzkw7ueQdqAtrsQ1PM8kBRiPRYwTjv4PybaL4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKxv9jUUGT3eWubAicemjgYtILYotmk36tMAKeaStCc=;
 b=Um/exC4hi+sq3efryMS7kVjGN4245OK0BEj1iASUhwebULpz8uBuTxXaTnsDHGYirkdDBnnKgS8D6h4JNt4TtElkjWqPbIpLAckUxQMzu5xUapVL+usCF8eEwO0GVfNKmIsQ6oDe8eOp4d9n3Btdq2vpAIiPRL/iajO6vDFV85SIzucfuLzdSB5AvWYHk10VBPTlsFpR+kLMYJEtnotVpKuJgmt9qa7WUTcjeblTGKUAIUZ0OJHVuuIWFc2Kw5LYZfRMb4ubfxoi7ZzLx5DXRppo6zlJJxyBNuQB5b8VuQhe7Gtd8nCeD5fX5HUWbS5rPzydNlzEnL+dWxjh8e6Osg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKxv9jUUGT3eWubAicemjgYtILYotmk36tMAKeaStCc=;
 b=ZpwI+rnFTPSrmT6sAhnPdt7+rW//+A9VCVrw5e+QKkr0qKehm7y3wWirKFBf3KUYRbkd3LqqjaRkPhDoNe8zzXBfKGLpI81bXA4yXSsviUaH5Rpjw/51NS0aKdA1M7Cw4tuiTokxIgdac2jEDfCJgwA9U2phKI+ux3dNv3+VfGiJQgKJPUvnIBe0e1cuOoXEn7rtjXsvVM2FvZtyiuiPD/6Ojn6fpVkwBEUDMelwgWKAgosS/r36zUYGT/+GEzKFRRH0wjdhvrkuDY70+gu4wVmguZpiAaNkLf42Ta9meVGEVanjbeRNiXo7VmpLFfUJyD5LPJ9/LDrW6HdHIjCi3g==
Received: from MN0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:208:52d::33)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:19:14 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::9f) by MN0PR04CA0019.outlook.office365.com
 (2603:10b6:208:52d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 11:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:19:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:18:58 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:18:54 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 00/12] Unmask upper DSCP bits - part 2
Date: Tue, 27 Aug 2024 14:18:01 +0300
Message-ID: <20240827111813.2115285-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1a3563-98da-4fe5-32d4-08dcc68a148d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nS1MjQ41g5Kc2uYiolY2AknZ71tMH/J+vM/lsJUxmTDJJX13wzj9iAm6f9fn?=
 =?us-ascii?Q?wTogJUix4OzeakdHXWSBkwIDZH9pITtNQ9ylDCSDEQj8AWR9gEJkzw7LL/J0?=
 =?us-ascii?Q?kASwY38OBjPnHRFjuQu9uTq/ns91pDhmdPhHR+PYx6kHSJB+YyWkTbbhgtIB?=
 =?us-ascii?Q?aFhtjbTLUVsulg9GdopcqdyJwNpPYK1T4bFkZIPpONAYrzu99r5o9xNlaAwL?=
 =?us-ascii?Q?uZRsVhjrbOmRSsSzriEDbFyCeffPXC3I1LJztoAk0JTXSKXCpDya1bFCa0l4?=
 =?us-ascii?Q?Rd7uJU4ANWFVg1oZ/2hHeh//TJTeVh64j6wFL81hMRkEwH6vm4aXfJ+DTsQa?=
 =?us-ascii?Q?VyEI8Fjby41Xoe4Q42tVZ1LCvZUX8sljVfJ2hJbSpUIEv9G0i637JjLXBfDk?=
 =?us-ascii?Q?H5TuaCMlFZxjH0PHN6VZHvWd3rhM8SZWXXNE7F9qofo+NnQIsNRvT/5UBGCS?=
 =?us-ascii?Q?MCyhieOy2dVO4Wlw5Axl86zE3sHoXuG6K/EUOam/kSujmzCZP36bqgaduDOa?=
 =?us-ascii?Q?y3oYu9tuqYNJfoEb0vG8iO+wXgYjo7GBMIg6qtbH4BssmIYehlq5hf6/BSGw?=
 =?us-ascii?Q?v1kOSvO/w9zVr34f6S4jb/l8jz0CcXZOQviLcm8NryndgKQWzWlPiIjXVWOb?=
 =?us-ascii?Q?sAZMB11bUeAaqBHYBDpzHtOcKEFlmvKbxNtDezHesa/TUpTzgRHgswNvfyoV?=
 =?us-ascii?Q?xDxsxIn3cEFKOH7X4/MpMy1B6erN5zdQGmgIjosvuVeYfLHMFRmERvAC4EVY?=
 =?us-ascii?Q?UgVyUG+IkM9dsmAGHccNNV+vk7yxIqBqFxCYiT1F6z057wyVchfo5mAQUOu8?=
 =?us-ascii?Q?oXiDOrHGgmN8UJDjR0yWiQPY/TdCmcloapmFJ0aD3NCRFlatl6USjVMybpXy?=
 =?us-ascii?Q?Woi5mzYKQ9DQYL/EMa/WqPP3HewexftNiCGJDshNGZmiUqi6kwFNFoYIBcxT?=
 =?us-ascii?Q?TfufD7aUe40RcDGiupAKUtrd+WSUZgGWpePjCm5OlYVmtdf9wPYitDmqPapp?=
 =?us-ascii?Q?PdXnXngN57cmmnRFSwoRcnNDSjwQN6DEIIenQ1MEIyw1JwjoQsBodfzZtD+j?=
 =?us-ascii?Q?Q/goByt2bBhTbSCrtacmC6BjkmcMLW5SB+3M5EmcxeITb42jnoQaNgji32U+?=
 =?us-ascii?Q?2ia9/gSStHAGgGs9EVIKC6ZGA7GZf+sCn1teaAnOMSECOin3g+SZCNm3gsZf?=
 =?us-ascii?Q?tBRcyEpDdigjsrWW7ZjadMe0x7Ax/1s+LLS2/p+le971sTH3yvqQL2Xj+XAe?=
 =?us-ascii?Q?asdTDkS2cxBIXdYKhy3c/yymOyGX7dSIscSbF9gyVjxBp9lyQ05pGR1tBBmr?=
 =?us-ascii?Q?K6EzhscxVYbZS0/njyrOQaxb8y0WN3E/x4gGFStLDvq2u2tkRG1uOn5WDfak?=
 =?us-ascii?Q?JAFOd4rmet9IkSKnRNq+BRp0O1QsM8NzdWsi/4bAARseB2F+P4zGU9J1hgAI?=
 =?us-ascii?Q?HeEFnNy0P/s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:19:13.0477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1a3563-98da-4fe5-32d4-08dcc68a148d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968

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


