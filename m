Return-Path: <bpf+bounces-38148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25C9960866
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195341F23941
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF14B1A0715;
	Tue, 27 Aug 2024 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eliozZcE"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D219E802;
	Tue, 27 Aug 2024 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757600; cv=fail; b=CxBYquoDzQFgsp7MyJHh1tqzTj7NMjOiOoidBd+MpBvonL7mkVDI6embhabTaqQA45v4bKWRs2C9LUDWIJ6tLyqeA1ts10dyJ5sJl25rU9eGGKT12MtY0IRrE+eBQrt0ZGqtQDEI30jbOImVKi9UkvNiP8nrjVbHZWGGCTXwBcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757600; c=relaxed/simple;
	bh=APNbrr/UCNrr6ZaEuU8a5UEsIcntj0yIskJvsac5GpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtCDJjU5Sm0YvtitxDRJguCBxXNfYD4mYnRTkJqB0aG8NvMZpRtRL1xgzywyJbOQJd7UDPWyTq+3wdITSRKrUV/fSDWBHDzqRQchWmXEOYP+5OPQceA4YQaOv9ZuOaoW5hiKDmHbh80s2kOiVNkDPxGAOTR7nJByGjJbe7ucL3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eliozZcE; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvScXHpaJWXpxcXP8feDpvay5NOTxLakq2hBh0+sHa3dn+WLEjj3e/4+Hlak4JlCP1pJ9P/ajBnUMMGJjZjeUssu2QSQluqHn2hfJ9f0rQw77huOXluVhyUdBopNeIpnwpmsRlEfdAdMGY3xsK14j5w8CcIaadCGXyluNlFZ89PMEZ1Jfw61yFf7lteMRpoMr9Yh9KKCL/pIJEvbYHZfBT/ZNvmA8EZpCnpNCJ4Cew6gbsbW5eJnKhWfQzxCdzlM5Kgq9iqyn0CVL1wy+P5YDlzuZy8Vpmd1pxLBFHUs7CZf+ILn+/ai21FqX3jNT8Uj3ruErrgopgFGTzv7V48SUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMS2N7vOBZo2lrHWR+Taru9/YT9G88+xE5xprkm4+dc=;
 b=lS4ZishJtLlpJaaVfMRNVfYLaqkvPR34K/Jaabh9o/51kdjHEwHy6ONVl7nV97vY+KQ8lzqY6HOcXJ4rYfW9c6fCJ0TAMfye1zmrpQwO2SZBsqnrDNgQCncj0r2ghGqQrdRGQgFIHzy3MofF8O2ZaDMTZgbhI1+IVE8r3TJ68TmcjTpxbLZLHwLs/Plm15rMuWzXDnP+0yxAIj53XACaIeFHKoRNwBP1g3BCfv87Zdv3lnYuM3bwMy+bvHdIaekUm5l88YRhrmbIRqKNw7IbSH0WyY/wc7XoTMRxxiISeVk3nrMDLTsEgg3rfghJKkBZdF8KZddPiKuuI5NG9YujOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMS2N7vOBZo2lrHWR+Taru9/YT9G88+xE5xprkm4+dc=;
 b=eliozZcEEHrpVzTbkH4MheCPDPyLBZ9VSe0E9e9SXXowVk54/7qz1GPXRMPsbwbqGqo7MQgURtVNvpgEjBgKXl+CYklC1j4w1MDVe/NAG9lNrQScw0ykkYVkDXzy7TA+3s12GtNRYDVfm3NJDhP/EU2B7B7pYGxuPb5ewf2bPkRM9ECE19YstSLAtSj/vy+1mJU70kDQ2CNP7zFVWQzkx/X80h1CL8oFAqAWSQyIA7TvbCjmOhlBeHrWQNMDgB+P9nMvbc4fehgQZ8IvKXtj38Qnwyhsi87xKbtQ9cEfCdh95fcKoWsoFc1lk31Chh/1+3sYex3asC4FrkRBBVC5GA==
Received: from BN9PR03CA0209.namprd03.prod.outlook.com (2603:10b6:408:f9::34)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:19:54 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com (2603:10b6:408:f9::4)
 by BN9PR03CA0209.outlook.office365.com (2603:10b6:408:f9::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25 via Frontend Transport; Tue, 27 Aug 2024 11:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:19:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:31 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:27 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 08/12] ipv4: Unmask upper DSCP bits in ip_send_unicast_reply()
Date: Tue, 27 Aug 2024 14:18:09 +0300
Message-ID: <20240827111813.2115285-9-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827111813.2115285-1-idosch@nvidia.com>
References: <20240827111813.2115285-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d40f1c-73c2-4463-8ecb-08dcc68a2c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Urbi45V5WsxzKW07pY9O/TximKPlxirvGMzTVRDuRY8sKZ61G4e/+Fd1QiGg?=
 =?us-ascii?Q?vtxl2pcao9zzpUw5JtV4hTRiQuOq6kGY2ujwj5dTVNQ5Ya8mpnTiCpDPG//j?=
 =?us-ascii?Q?H8AbYKqN2z8M+p7bLQr3VKWI3jc+jsBMCjN7snUZ4FX66l6/anbSmBu9/V3t?=
 =?us-ascii?Q?xgoARAzB/o+uWW2ODM8XiXQrs3/MHGfKF9f1esqj6CmRywYcY3kX/D1OjQhQ?=
 =?us-ascii?Q?ibfwCpsxO6SNgWPrILHl9bdhDG68EnrQcvPAK6TN3FXchJUoeCiCNUbjLeCY?=
 =?us-ascii?Q?2klCxSzp9iMpNE6b+vOVff4PwAQ7O+zc3BdJa5iSdvqIiXxV9L7+8olra8EY?=
 =?us-ascii?Q?BESgKIL8u0lyZTKkyFrMObUJIh2aGmw5RmIgGfr3hIuZSpEUWYdxrHorMt+j?=
 =?us-ascii?Q?5F9HCAGb+Xe+AuBcL/KmvF8SCC7JNgoGX6R8+w3Wjt3u2tMbsmh3Vcsu/Nty?=
 =?us-ascii?Q?qtdSpzUTDpyHppFtN2XX6G/1GthJsCSZPyMcYnGbDCr3HNaMUNXH8n/0nNiQ?=
 =?us-ascii?Q?HQsSPVoETKEotDpNC6YZEMQg2Eihe3d4wsLf/umjG32YmMRfOA9iFDg8o4uV?=
 =?us-ascii?Q?oHjSxFABU307TdFplI29iEFn3Kv7D6dmECi+Rls/jh2yET5YDz9pPqmpVsSM?=
 =?us-ascii?Q?J3yhYdfGOq3b4EOXIOgRlmCSluI1vZuRq4Ds0UYA5YKuj9pkjSAkCzOuufkZ?=
 =?us-ascii?Q?4yl+v2ETNeRlAC0CReswjat2i8i79H9RZfB1mP9OSbVz6C+IawsGzezqaQH2?=
 =?us-ascii?Q?ANClgBOAeO0V+bRsofX6XgJcjRolf4JEeG/KqIeJaaQB/SD4icu7BThVXave?=
 =?us-ascii?Q?Hzj5/ZMQOTY143veyurdo3j52YrPLPyKfYnLWfXyWlV2voOQLpRKJWk7bqlt?=
 =?us-ascii?Q?993+S+b/8nGHIz0sManIW0kVQnxISLtzpCn8dPDAt7bZ16RHhvoEsZTgpfSD?=
 =?us-ascii?Q?l/7OesnWiGldlD83Ec4vR05UsCZGl+x11UlH8hHJpIfwXMUfWzx9MBB6rzT8?=
 =?us-ascii?Q?uMYo464gOadI3y6zftALc7UuPgJ21Uay2KjF3nKL1q2RErzidyy2JU0CdY5D?=
 =?us-ascii?Q?ZGHp1EV6D+I5nu70yioMq+T30Z56U5v5Y+RU4pJaqH27VHLVhVJ9HaTQuRXy?=
 =?us-ascii?Q?5rHqkNZKormopNsnNlIuiFAuf7/njG6d6CRaXG4v0SfvJC3s5Ms+omCugPmC?=
 =?us-ascii?Q?B5JV50b6uGAlVfBg7Q68tMZOU8J23IE0rQ43m26arN2re+RVAdOPIDdpg6DE?=
 =?us-ascii?Q?cq6R52fAenXGagLkc2UyFbxI7fj2W3wy/SjprTxEvcDSDnReFF1A4nm/0VvI?=
 =?us-ascii?Q?+1rms1luZ4C8E7FmVdCDVH0N8smQvAN1FIODqRIAJYrin3qS1Y/qgrwGQzAA?=
 =?us-ascii?Q?EyHk4FZ+qw+b06MzH5PVnhv/97zETFVcdFeAI52fVq55qxMOKtBwhc5dG5Kb?=
 =?us-ascii?Q?+I/TewIJ6mHZk4yVce/4M2FDrjr9fKru?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:19:53.0401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d40f1c-73c2-4463-8ecb-08dcc68a2c63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649

The function calls flowi4_init_output() to initialize an IPv4 flow key
with which it then performs a FIB lookup using ip_route_output_flow().

'arg->tos' with which the TOS value in the IPv4 flow key (flowi4_tos) is
initialized contains the full DS field. Unmask the upper DSCP bits so
that in the future the FIB lookup could be performed according to the
full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
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


