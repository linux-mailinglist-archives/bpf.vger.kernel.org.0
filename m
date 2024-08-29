Return-Path: <bpf+bounces-38372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 763B9963C11
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94821C21B17
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0E917556C;
	Thu, 29 Aug 2024 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sRZB8Evw"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C601537CB;
	Thu, 29 Aug 2024 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914637; cv=fail; b=RH8keZ9wFgIuMxyW4OFJbD3zLLTLKIsiLBf8x6+ciEDAFw8SSmG6R1qw9XEli/+c3Vvu4zDu7lijl96wBdsjYj6OvRnrXUCU0B+Cr/E29XrSNklv5zvO0qHnhADcOGW0r2vBqQ/Txnfn841MoNvhrrKyPJl4m7i+w/SwyGZsB4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914637; c=relaxed/simple;
	bh=BeNxN6BHADuYybAIR1/+oMTbAD+xYbrZclTiiRZQXOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sv/QujvOtrYFEqJcgkp3W0oiPpFBuESSgvlQByfv/OJL7aqn9Z53Qf5JNqAydKRcfeM/tnktGZ86MgOiZ5uAUkvKOJw/10dSjsSbwaOXQB37BGJ/3w+Qg/zj2Qe6wKlia1wF/UyeqLX8H3sysmkPlc91A40SRkFSNyK875rowtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sRZB8Evw; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcZKw+KaWOuyKQ1E4U5azpk9r8mHNfQsLLTt/0OMsrAPjRJoaUHc1A2M3erlXhozPQtDxKZlnGkpHGf7mE3DBO8GHdpjtVh7qyV1JhS+XYqS/AMk4R0GuB5YbcyhfXEzo1A0bO+j9rPBoTZ8eL9W3pgdjRjt4d/MqocDGk8KaDH5MM42o3LVijTWKDDHnTAsjfuIcPuyn6cf+yLRZVYKQJ/9nz15Zi5o+vmmNna8BcqtF0AIlNrazjMn7XrWlC2rbByLsDSLSnu26IIXMxLwrQ2pR+95WXFfgNc5REjTuICmW2IkH0LUeNMN0de1YZ7knLYRZKzq4nuSccTgRIbvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgOch3gYGh6J5x1b5eN2ZtQTthaDQtfg68kfvlSQPEA=;
 b=pMyItRN7L/zZVkT0zN+6tDI8W6P/V61NDysMMkmZILQ/Ob/1Nq5NSr7VInT18VdcX0k8pJzyeKtsRhC/2UxluHa3Vcko5ge724sgU2XM6g0arDzUlvOj7C8Xn+sB3Zqr+8o7QImMYHnmkPS+HPuGnlGQLMDmYsdon6/C3EMoOXpdHC6P83vThT11RedVOKfU1UdriENR8FClTGEYutsyvlrqeg/wZT8998soQ4dmR4vtjvv+H3XktWzlbgxL2YnV4xIyljSAokNeyhQujQz5w/rwdLEtGLeaBhmTRvcIyoizqJTOuHUl+zu5qItt4cIgpNJkKO7yOhcDgdTj+FKdfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgOch3gYGh6J5x1b5eN2ZtQTthaDQtfg68kfvlSQPEA=;
 b=sRZB8EvwL5VelmwUjljMKnIfSGSQzuDQRz8NaLt2OMjpVhrlZwTkOT7HKjKVV5rdCnP1R+MQPE3EZcqeWwZu4CiX0RsNUEwGr9uwdBpOUw968JCbTtRWlpfMjCy0CjErpwk6lJ2RbU0nc1xZ/eG1LvRe0QCXuHg+WjtL+WIfy0E6pxj6Ogur7OSRAXe+sGXD976Abij8Ju/OfFiUMbbdK25wq7fuBJIWeEP7oIHHIi2rI8hS3Xjp47QEQHDlFd08UJwrh2xtx42dp7UhV++lX/rNUSQL5vZYMEbC91nYKBo0RW0feL+gMbOmzZDWVwBqGFm8Q/yphLQ0okaXrjLYdQ==
Received: from BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) by SJ0PR12MB6710.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 06:57:11 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::b9) by BL0PR1501CA0034.outlook.office365.com
 (2603:10b6:207:17::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 06:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:57:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:59 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:53 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 05/12] ipv4: Unmask upper DSCP bits in get_rttos()
Date: Thu, 29 Aug 2024 09:54:52 +0300
Message-ID: <20240829065459.2273106-6-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2b8b42-f60e-4a40-c8e1-08dcc7f7ce2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5/W1yI4O5Y6Y9LVDScv+iUT/emhnHtWzljzj3a6MeQF4Ou5QFVXe6/dKM5/l?=
 =?us-ascii?Q?/bvLl+qr4nxKN0kbADAxFrZr3Y8ShDyUBv1dcJBRNQfVq1E8xAtQDnWW8lTK?=
 =?us-ascii?Q?aNGnZpKBpA6KJ2K8igg2q61beScV+rmZgP0FyA2JjhYoh01bJBEq+4+jjP8q?=
 =?us-ascii?Q?x/jLDAZ01/KetM8pPxvbzrqch4jqLRvGnwbyW1URyRJuC4vMvwycxmwCTio1?=
 =?us-ascii?Q?mVNqEmaOFeJkCK6XHpfLRKG7w7DNr0uG16zrKu4Ge5+/AKK7knlHh24Vmot1?=
 =?us-ascii?Q?hF5PaNQqxniLJXe/bC+aWI9rTODCHmuzgT1i0CKKrgPSzAjszEu5FX3Unijy?=
 =?us-ascii?Q?iTOUlWOzokCZ7+OvRA+oOoddqKSSGKccBTZqUqVevSDxxxZKskjGKv/GtjUV?=
 =?us-ascii?Q?7P2T7uLgJaci6KuWKW7k2iTMfKU8pKe3v2syzB/qgoQUsUZ6bfByzJ4Rnii7?=
 =?us-ascii?Q?Kn7C5EiDnQHz4XwoFMmopXDqJvn3LRD2f5RYVV6gGWPTUffpw3gWsaYK3pBn?=
 =?us-ascii?Q?kknoNi31VXItscfabmGy7FKhY6NKdFGGMP8KwPN5AY0ho5zKP7hMgDnGcImF?=
 =?us-ascii?Q?52jdk2NANwBet5lqmHQEBtDHwiB5q25kP/unrhRyVw3xEQggy2If6CdgDmFt?=
 =?us-ascii?Q?aXYnEbKtPnvaLUtMB+dybQDkqH+ouHyQ0S8PPATGD15KdnedmPsE9G4YK3Ek?=
 =?us-ascii?Q?GmbriOsPmWJFZs0GGNDX62o6pCktfcEGKlZgskjsg9STp0vmFlOTgpb7/BKc?=
 =?us-ascii?Q?GfXVm0c0NsgX+sFIkUNePu013u86oEijaey6CwRwtuW0XBYyiLKXrrgVurdC?=
 =?us-ascii?Q?RILx+VRDqhblCovxzbwFoFymUpPbXSk3hPFCje1fnk60XUTZeCsoJEZUBIOd?=
 =?us-ascii?Q?nCButo+jhehT9Dpv/Hg50eM2Myw4Fv0HZCPjR/huJYxNvWYMovNwfA0UaLTj?=
 =?us-ascii?Q?+NQZVzgyeJGRq0j0JAuGc6m7FuHNML4Imbm0crpU4PcgXB1ARpePHGQLA2gK?=
 =?us-ascii?Q?WFfBTxEeBbxSCkUUeDcEoUED66LOCBsq7kgOWmtsWRyMpCVZNf99AHuIMhFl?=
 =?us-ascii?Q?cr0QTSHOglXHrMrq+wP4dUvlISt/RNPM6MYtS8YrGHQWc3Fxx9xYAcm8wa0E?=
 =?us-ascii?Q?q0oL6YNPn07ziVmeXqplablpZbnJpZSyNJnsLR6Jf6eIfq0N5JaAxoG9ic+L?=
 =?us-ascii?Q?NHumzHGIIikzwPwly3aN01Jif26l7WhMIKyhN0r3eXdQmmSPJ2B6fJ5Y3fo4?=
 =?us-ascii?Q?qgf4OU7B6Ccdw+TZPUMsp7dgcLCbVlLV/bqfYlRkp1ljziIWq2s3geu8UQGI?=
 =?us-ascii?Q?y9HbZcNp0xL30noF5jynKHuVZMWpoJyfsQ6cPnvFUuNuoCiBOhZeO64Aj7Cz?=
 =?us-ascii?Q?04lLpq2iAxtDjelCoVrUnm3XUhLadUhL2ZplJkR8LS2WV4yzXTjDYLsGdnpo?=
 =?us-ascii?Q?Y+WFf6JmL74cC8s6eyopubFy8oXZo0nz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:57:10.7496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2b8b42-f60e-4a40-c8e1-08dcc7f7ce2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710

The function is used by a few socket types to retrieve the TOS value
with which to perform the FIB lookup for packets sent through the socket
(flowi4_tos). If a DS field was passed using the IP_TOS control message,
then it is used. Otherwise the one specified via the IP_TOS socket
option.

Unmask the upper DSCP bits so that in the future the lookup could be
performed according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/ip.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index c5606cadb1a5..2b43f04c7d03 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -33,6 +33,7 @@
 #include <net/flow_dissector.h>
 #include <net/netns/hash.h>
 #include <net/lwtunnel.h>
+#include <net/inet_dscp.h>
 
 #define IPV4_MAX_PMTU		65535U		/* RFC 2675, Section 5.1 */
 #define IPV4_MIN_MTU		68			/* RFC 791 */
@@ -258,7 +259,9 @@ static inline u8 ip_sendmsg_scope(const struct inet_sock *inet,
 
 static inline __u8 get_rttos(struct ipcm_cookie* ipc, struct inet_sock *inet)
 {
-	return (ipc->tos != -1) ? RT_TOS(ipc->tos) : RT_TOS(READ_ONCE(inet->tos));
+	u8 dsfield = ipc->tos != -1 ? ipc->tos : READ_ONCE(inet->tos);
+
+	return dsfield & INET_DSCP_MASK;
 }
 
 /* datagram.c */
-- 
2.46.0


