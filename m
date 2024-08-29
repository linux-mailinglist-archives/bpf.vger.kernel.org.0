Return-Path: <bpf+bounces-38375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B52963C17
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 895E4B20F7E
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A6171E5F;
	Thu, 29 Aug 2024 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d/lbfpyD"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4A16C6B0;
	Thu, 29 Aug 2024 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914652; cv=fail; b=tDdaWMQouAjwgCD4Tbz72LNvdyW4i0VEmarzJESX7RK1IOmxoJX+1xkk3RcyBQRWvVmJF53KMwC/YfNm/fXqCcHA9sb5oxxKvTdI1Jcoq7+oZbiujnko14BH6Svb436g3DV0kt+ZsG9Lcj1cG42GrHZYz0p4hepMo9REP8c8pXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914652; c=relaxed/simple;
	bh=jvi1gMc8usqCC5Y2HjICOgtwTI7ZC/Ke1mvMSYVcTCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmB2sxKE24S0jz+7kp/Rmf0JB0P7GC57RYE7RM5ZgyBpZxVRoAd1fA+8XlZR4qeA0kzYeAKAErq1CoPJl+yW7qFPIbDMi6pTfSqrUYkVy3S9CJw+1H5Op19RhUSnt0ShyH2JQSBuzu8oWjRrKX09SZ7yYdSGw/s5tqO1w5Tel/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d/lbfpyD; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shQrToa1Ki/OJkNlqI2FIMCrjbD+nVBP7gG7G1El9El6nsH1BNTy0+kG7VxAg53Vahtx0SUeyeiRrNEOUBNVRg2iIoxyTmC2oLwaZP9ANUvLkU8rXy68HO5kG9k9t49nMOacz1MqzfTKEcQbptE+r5fFAub08bBSOqBYnLb/+X+qyUeoTSfyuE1YPms9g5kDqNMA9Zg31v0RHlPzvdMgTbzxKwC/ZuPeUyypw1U2puGmH7Xoy6PQiY1O22vMQAjbvUGPrK2025KHnXRAnsH9Vga4Y/QbfZxrSHijb3OpLLt1FIUtCYsGzDHGZA2iY1T7tYpB1PDm9VT61lZdXgbtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30mFF7JqNI1HKeEzyn/LLjwo08vl8GpE3tTpaquC8nY=;
 b=xV68Q/UtU+Gx8I/JSeDGiXegbyUm1DdGag0tHUmjjGvd0lWztW2EXZQL/3t6C3hoH22NO/s52FQ/yjGF9M+ftmT6abwtpcQJ+i585VIiES7eiTnL6gHLv+B+kSG/kT7R7Y9VTGrf+dux+BfEku4z0TGp9lSzkQ9y5PcEXeOkc1BLDJec6c/ajgOB1cQ5oDAeYKRF4PFKSqN0/NgNi3ImbHh1LMCWJGPDy+YFgnXQarz4QVqOsuGfg4qSGH1I7mfpDt+d438JrF0eIEYsMmoEIN/jfdhnCtijNwzXK9QL/GkpSlrB0gBv72t8nnTeA9wqJknvP3VbQVZ1mzJMz2OZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30mFF7JqNI1HKeEzyn/LLjwo08vl8GpE3tTpaquC8nY=;
 b=d/lbfpyDb9rPuKFqD/CNddVFronqMu5MiNAomcvUymeq9EfM3bIy/FP/u0xxGEcSPkoEYHIo3gLx36zPekjCDU6Wdkhvnzu9ddd6jBMk+qCxUBeHMReTN9AmRNuYIISfuvGV+T3L/3NNsOmMmfuFcmoXT3Oom0VvR4t2L30WdiOchHwlg3F0yLLnm8ar5oKtQ8B+d5sHNVppFx2SiWsgojfdt9JRC7y2fxspkoMhl7ufyjy34IoLEe21Lm5US81Ny6Kf6x4URJERu9fHLU2aSFOfgEoVvUOkTKipUG8/TTnkF0ELxpx6sCMzp9tvbC5Jofg63/wrSqmTzdhxC2r0Ug==
Received: from SJ0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:33b::10)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 06:57:27 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::64) by SJ0PR05CA0005.outlook.office365.com
 (2603:10b6:a03:33b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19 via Frontend
 Transport; Thu, 29 Aug 2024 06:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:57:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:15 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:11 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 08/12] ipv4: Unmask upper DSCP bits in ip_send_unicast_reply()
Date: Thu, 29 Aug 2024 09:54:55 +0300
Message-ID: <20240829065459.2273106-9-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829065459.2273106-1-idosch@nvidia.com>
References: <20240829065459.2273106-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 3833a075-07e5-42b5-84c9-08dcc7f7d7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/sXCqLMgKFO2Owuxz5+iJ5TpGJcycvjHrcRzXwx9x1pzBE7jVUdiHKG8vczU?=
 =?us-ascii?Q?Y3RnGEfX9elstLQsvvsmjQULY8DgLODy81yfutftIj72mBkmCDim0oKvg0fw?=
 =?us-ascii?Q?OEQ3sj+wg6CoSBmorbVreMDL2RIzawSGZFV29kBNBijXoDLRe0wTY/VAUeTq?=
 =?us-ascii?Q?EmjnMO+zc2o4JaYIDDXBVgvXux8bYCRfA/fqfh6NHB8H3JeUCVtxy9TwPrEu?=
 =?us-ascii?Q?RouB0Ee4NcYTnTr8dCFB8uATWIxs4NxtA69AvQ8S87LRshT7BrSSNq0w7NpM?=
 =?us-ascii?Q?iYVLI6j0NfQug54c8IZ/NwxrUSlidkP9Fvk4P2KaZt7faZbvkv5kXOZJfN5y?=
 =?us-ascii?Q?aM9eX4IBy3Piba/qK5M5l2AvvBvJO7tDQ1JQekTU+/ezXwBQXROVDHaj3u5/?=
 =?us-ascii?Q?EgbMhQc4ZlKcRT1gxa0awwNS8tGAT+J3TdWsKcLT63YyzyEhCW5pnSTLrNYp?=
 =?us-ascii?Q?yRFvEUxx4wgeHdkLkrWUMotA4fqznUSQETCRyWBc1lKs7ZPbByqIHAyuRHu4?=
 =?us-ascii?Q?hLtH0+gCIY2IN62sU2uHAiUwnxnMZg7NBYzWp6uFsZuRdXM6bAdE1PjPoY1K?=
 =?us-ascii?Q?UvS9UNTH2GkmP2MxKpBy6zWDjoPtVb8ARMypktKM+t32UVRdPhaso27UKPKM?=
 =?us-ascii?Q?rZPBK8/a68GVIn23gERepITvSbriZ6nRM7Qoov36CF11idUrmyV+ODt/CZSh?=
 =?us-ascii?Q?wfsIVV/ydcsZxgpfigg2EeMRqe3b1wDu0Wz/xe9vQWLHukyeOdf4gbfR2gj3?=
 =?us-ascii?Q?1muGZrohEmJBLRCqwpnPkQk4NXdq5hWxG4MtPXuWKhTpW4pR//utA28zvnSI?=
 =?us-ascii?Q?y0239oJEIht6ZrQthEr9g6GQKZqUB1wCN54b88dYTJRaThSgI7KYDXBb1hnE?=
 =?us-ascii?Q?7w8QpfvCKMv4uJV138Z+z5siZinlpwOIlsPGInCWJ4v+qpdDeUL7+EHmkq3D?=
 =?us-ascii?Q?2eurUIv6WD4wTJRP0Ovt2eLQBKU85i1aPN57zBqIEk8r3Uy7LsH35C2nmkia?=
 =?us-ascii?Q?dCN3ED4xGUcRULtEnAysl6PRFbIHjdWwErMwUDaBgP46C1q/24x19OSWGHFr?=
 =?us-ascii?Q?Yzun0H0dJ5r3xTWp2zLg+FHqA1hBHX/b1Lid9FvuzKHxbcOT4naRKJlgVuMh?=
 =?us-ascii?Q?HEOX/Brf1AvwucjLkc1Hbr4OHok/0J473cMyZazR6W3hqh1K1KhXV/jsAMqV?=
 =?us-ascii?Q?nquDaxnnaJUuPux1TmezijyjskXeHUheGAVJX/mPPFkRmLg9P5zuyCgIDiHF?=
 =?us-ascii?Q?PmSZft+owiqTRJ0Y1+nwO2W5TfoDhkqz7OdeKwuvRmvcjuI2R+7CqxXs8y+r?=
 =?us-ascii?Q?zqep79tfQFFq1xyr+KXWRT8gOHmsTFqjoRaPsv9BfqXEqD0OHbax3KWmVF0U?=
 =?us-ascii?Q?UW9gmjdWYqsHG8vTfFvSOHIEp1O7EzIrRLZZKyQndNbVTZ10nLqQcIeZmrwz?=
 =?us-ascii?Q?bfqeGJTR2PmsITm2bIv0IYCpmKRXu2Ut?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:57:26.9791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3833a075-07e5-42b5-84c9-08dcc7f7d7c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553

The function calls flowi4_init_output() to initialize an IPv4 flow key
with which it then performs a FIB lookup using ip_route_output_flow().

'arg->tos' with which the TOS value in the IPv4 flow key (flowi4_tos) is
initialized contains the full DS field. Unmask the upper DSCP bits so
that in the future the FIB lookup could be performed according to the
full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/ip_output.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index b90d0f78ac80..eea443b7f65e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -77,6 +77,7 @@
 #include <net/inetpeer.h>
 #include <net/inet_ecn.h>
 #include <net/lwtunnel.h>
+#include <net/inet_dscp.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/igmp.h>
 #include <linux/netfilter_ipv4.h>
@@ -1621,7 +1622,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 
 	flowi4_init_output(&fl4, oif,
 			   IP4_REPLY_MARK(net, skb->mark) ?: sk->sk_mark,
-			   RT_TOS(arg->tos),
+			   arg->tos & INET_DSCP_MASK,
 			   RT_SCOPE_UNIVERSE, ip_hdr(skb)->protocol,
 			   ip_reply_arg_flowi_flags(arg),
 			   daddr, saddr,
-- 
2.46.0


