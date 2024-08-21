Return-Path: <bpf+bounces-37707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB8B959C7F
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760C81F23A72
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999CA199FA3;
	Wed, 21 Aug 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vylzkzpm"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D8192D97;
	Wed, 21 Aug 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244919; cv=fail; b=FbE4UnjvTYNixAgA34ZQnnbGczTsDBCquAC5uIOQWqkTUqaNkKHZkENuoNPFoXvmeKIEE4mBoYtlZ862qqXp/cbUpPdi785ZbUzs/eTUW8ZY4YxsrinVPrviB0pSK2HObzVqT3r1E0o4fv2hDWXE0VTVHBIWhRIYeLl/Py4jpC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244919; c=relaxed/simple;
	bh=kHPA7iNwZLZas9TVyyKp3U1hirkIFgJGpzAv2pDtZ/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLiE8QZBZQuCWvdsrsIjLGSv9DdL6xu7+4VtMrLsMcsrkrwitT8DSgPW/R0N/U1qZRJMRD4LvFqfH6FtTBmaxtXAuFtw+mdkiTNkA/X8TuxmG1UkISHt75MubP6wL6L8wFVXPxD7dcCf7aAYibjBl+Zrn7xYbyVXpkCNFTa0TMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vylzkzpm; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBEoCMmNaIecplo4qmVUhkljktwqLsQNCYhrEZvuT7sKy4ki9Pa7xXadpXCmQW4K37FMT15lCbfsktq57WR3RJoDd0IWhNJj1o85NmproXurrB51kQrQRl2yfdfr3Sm/DyzsRqlIFlfMUaZtuAKcm6EzBHIO2SXaTvmIEAzKyVYmqvm5XvQGP0FhMetdOp97zjEbXhlvAMzGgHuer+JQKnnuyr53ZXElJ3ckzQWMcw7p0QSXGwTAY1m+QVM2xD090auw20/t//RXBOCtge/F9h8MaXxcIs6BDNuF9U63OSob4eX0MTEX6lobi//9t8buZAxXccGVJkqc3unNHLDhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld0/Pj3CceHcy2iKcEKlASK4iw5jCzUbImP1F/Ar3L0=;
 b=UyGWsPTY3Nq347qpsBks6rFoTmhX39y2mjLWi1v2PPsKEBFhmVMWzLXZw9xEZk9YWFl29yXY6PWg1nQ1LlZGt8B1pdKHtwNKiwwWrNPkFz8mubT3E3ZsE4PBOrWSFpGKNB+A/vRmtBfPUOm5xDwGZZ/mhz0gcedjKnW+26ZGgyXzSeNv9sTxkFNT7MrB/ZZWWErmUxcbAWHhSaQqb+MwZ1mBrcLZhxS8lFwmJzjfn4HgGJd2swNLT+B4SjeiFLtKyIkwqAzPHEcmBm7zC80kJ3qVzdeheU7a6ezycnqqna6KB4laAD4ibWwptbyqeXluqjxAul5zHbvYf+x/W1SfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld0/Pj3CceHcy2iKcEKlASK4iw5jCzUbImP1F/Ar3L0=;
 b=VylzkzpmOCOSjoVISpfK9/DAzLLfgvAGYFKckplieGV6Nm5kNAePs7/9cscupZcw4//hBfSWCPIyZAspcgByhDjQKvtSsIkLDB9ieH5jGv2eRYHtef4Ja4bYymi4gnwqUE6Cd03rwb5iK5h43NDL1F8fVJIuUFTNDKb/9ckyIj9Wtklp7nWYgut6AsNGAAiufvdCsXMg5EibUpyQPRMx+S6sJpwgGFCsUB55HeLo8yLii32sdLWZrkhuqk7KvvOpj9DPap7JG9Zn79tYKGsLR5ut4az3/pIbdGcoXzxug1cVPZBV0XQu8l1JJrmi/uPd7KN5fsEHAxPe/wEtruk7Zw==
Received: from DM5PR07CA0090.namprd07.prod.outlook.com (2603:10b6:4:ae::19) by
 DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Wed, 21 Aug 2024 12:55:09 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::a) by DM5PR07CA0090.outlook.office365.com
 (2603:10b6:4:ae::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Wed, 21 Aug 2024 12:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:55:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:54:58 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:54:53 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 04/12] netfilter: rpfilter: Unmask upper DSCP bits
Date: Wed, 21 Aug 2024 15:52:43 +0300
Message-ID: <20240821125251.1571445-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821125251.1571445-1-idosch@nvidia.com>
References: <20240821125251.1571445-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: e82728e1-2d53-4b47-abbc-08dcc1e07ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qTT93eA3HlPqBPziS/PP38MkiwgFZVBwEKhddz7Ebre/bK9hwxb7lVuohum7?=
 =?us-ascii?Q?87nkzLEZ6gKL1GNivXOLzaertelD/e7bmwNnJDPJhOZJlj4BukU7eQkJW/Rx?=
 =?us-ascii?Q?q9iLPSoc+4pfFQh2kXcASbBvdHmefXMaoN7cc9eSG1OgYXWKL68cf/GBF4xa?=
 =?us-ascii?Q?ymMFs+x5MmAsVKUtt4KOWMOSF2N3kCtwrzvfBaTVqwIqwyhdRBK2MjqMG1n8?=
 =?us-ascii?Q?ppAiBhDOyn//MujbTiE0nvl69J4CLNyvCICUgPFU9OGEqx91PbERo0A0KQcL?=
 =?us-ascii?Q?mVLYkkrQOkpsCAQv2tWz829yHxKkkxURkxn8LGc35zCSCNKp6Are3kTJVWdJ?=
 =?us-ascii?Q?KX2xfO7huFovufbZvumR1v5NzCuVZUjjMII2kX6+5IIfvBccGQhxHZkjbPw+?=
 =?us-ascii?Q?zESTjz5bYT5VLw2xSrCCJG7Akp7Y4jsb8cYDolcJx4BQy3AsD9WEjjVRSyLA?=
 =?us-ascii?Q?65Zzun0qUatNkY7lh3A6iNoUPl8b2j1LQy33hC2HLQKwZvVByxYUpWoHkcho?=
 =?us-ascii?Q?UIi+vdrJpbw5CtAQ/2rTHCQfBg0VbO5oXBhkh5rAMGCCjePqwe6UNT2ssswn?=
 =?us-ascii?Q?bNstU1lacyKwd2UqbN2datOfxh5xpaWlNMN+kZP6r6XP+T58Ycmk3oCYV/Ix?=
 =?us-ascii?Q?ZwpwSuXMaDMCRZAqCBi4v/u6Uyu/abd3iAyiwmglZHk0chVacSwSv6gl3pWC?=
 =?us-ascii?Q?0Tm5U0VEqdyEMzsW6hB9XvZDM22YoSMkG38col873VuHQ4GC1vSS5LN1QOE1?=
 =?us-ascii?Q?cf/bnu9jqUNyNJowinoKRxqU8D5OPM9Tn1CoUPNzuTVZTfdbEMRYUjpDEVQn?=
 =?us-ascii?Q?9n9463/foZfhEDNzkVBcKvCURWMAlNoPyhvlA8RJrIIUFgkJPScq9rPB0e0a?=
 =?us-ascii?Q?+ogGQwklnp4fxOz9cGxlCFnUd4s0FLjdIoR7SqcdafDHZsv9yJ8kyF0K5CM/?=
 =?us-ascii?Q?w2KpSaGtaOBF30iHES7U7u6L7v2fRgT2FqxEZy5BcHzgVHTokXJs8yHaGO7E?=
 =?us-ascii?Q?HRo2Wiq+87zDiX1vZe8aBZrQoXJdmAjI0iA17LOrSdr6JoSFepe4AjK4Ehr3?=
 =?us-ascii?Q?mjRktT74E3+/Jg6dnxh6Uk2QvS/+cg4I1DXYV94z4yZuhYZaz814ELWJIhcz?=
 =?us-ascii?Q?tdxz3T+pUW8OVgNBXpm88Qd3LGTPKL6fvbGHjLnDP1tIjS1vA2ZqQoXZJ0gv?=
 =?us-ascii?Q?uaEiR9ZrLLGynTQ9DpurwGS/Vqy7gpkHPMdsHF6qYSnJuaIOyZSqYQsmfzHt?=
 =?us-ascii?Q?iijMzwFmUwLXmA9n+3CDnZdzu8L2B9H6TCp+U4nSDXyuT8SZVzaUkfhS9AUx?=
 =?us-ascii?Q?BhrdyP/9zMj9T2oqMB18+FxQS9PNqt02bx8WIezsHbjn8dSCa6Xb798aYMSZ?=
 =?us-ascii?Q?p7FnJwX6WzstMOO6efAIxiStS5oFdA2m0vK6GSOMXwlWIu28C+jbXNs9jnUi?=
 =?us-ascii?Q?MB+RJFhEc/4b+wKDB3zybAnSHmsd+mHD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:55:09.0466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82728e1-2d53-4b47-abbc-08dcc1e07ce5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741

The rpfilter match performs a reverse path filter test on a packet by
performing a FIB lookup with the source and destination addresses
swapped.

Unmask the upper DSCP bits of the DS field of the tested packet so that
in the future the FIB lookup could be performed according to the full
DSCP value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/netfilter/ipt_rpfilter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter/ipt_rpfilter.c b/net/ipv4/netfilter/ipt_rpfilter.c
index ded5bef02f77..1ce7a1655b97 100644
--- a/net/ipv4/netfilter/ipt_rpfilter.c
+++ b/net/ipv4/netfilter/ipt_rpfilter.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <net/inet_dscp.h>
 #include <linux/ip.h>
 #include <net/ip.h>
 #include <net/ip_fib.h>
@@ -75,7 +76,7 @@ static bool rpfilter_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	flow.daddr = iph->saddr;
 	flow.saddr = rpfilter_get_saddr(iph->daddr);
 	flow.flowi4_mark = info->flags & XT_RPFILTER_VALID_MARK ? skb->mark : 0;
-	flow.flowi4_tos = iph->tos & IPTOS_RT_MASK;
+	flow.flowi4_tos = iph->tos & INET_DSCP_MASK;
 	flow.flowi4_scope = RT_SCOPE_UNIVERSE;
 	flow.flowi4_l3mdev = l3mdev_master_ifindex_rcu(xt_in(par));
 	flow.flowi4_uid = sock_net_uid(xt_net(par), NULL);
-- 
2.46.0


