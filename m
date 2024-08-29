Return-Path: <bpf+bounces-38373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45920963C13
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8771C21A64
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B12D176AAE;
	Thu, 29 Aug 2024 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tylfFaXe"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A41537CB;
	Thu, 29 Aug 2024 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914642; cv=fail; b=ShBNpseZsqog4A4qUn82zjuh74NNNvtlCXrKWdtw76sbG0G86SGSC+K8PRLtZGqQdCGlY5BJeUFlcKIBzVkA3pntlLNq/qwrePmoYRdtqpqwbyFXwUscCvYND8WpLCNNVP9ICo4UlhzGa3NOzHCdf8j5DLZIN4lw6Vt3zp7rp6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914642; c=relaxed/simple;
	bh=8poBJutE79QChEnyrr9Q31AIQkjFoqop/k41/JmKcy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAxQ8vFAhPD00BG3bbPItu1jjbt93D42mTwdi4Z0AnTIG+cPu7KuH+1xwjRJp7WCoYJh7eF+VyQOPqdQXY7MdLi89/6416j8eiYlrvSbQh7gQV49jxIGN7ZP7UcroeZcG5vISSXXbCqKrgYbjdpGBEkfVO3K62uo4Xh5JQrAKZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tylfFaXe; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3xidKED+0KiywOhgH8cjDehpO5yWCveBWrZKekWi5AOsEUj7LAM3k1B7JCwlc/kOs4kSwTtT0cx/TLd4t65SQu+e0daaIDh4+TcbevHeFSUtdOtccSPmdmNB41oduzS5bqdfaQv6hgM54d+Fjl4wV/kyz/ZxzkEjnoKRopssOyXTjCDBIjOP+r8MpPl7xweP3xdrjIMduTMCorlt2GtngynMOvWM1bgfrE2eqCMh5/v9iEouo+lyK6W/MqdfeWeyu42lIiwJcnAnDwkeU9RxbTR0KwDLbMvWfdjNmu4U8VefHARp3UU88dH3SLQNtMXUgcBpqP8WjzscCJqS7TStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0YzbnRwLaXc/7mdC99erH53FZxB9c2BLDoAI04xQeI=;
 b=XNbYWqh2zhCpk3ReV85rUkLZYBxOplWJTADuPBb1WiQ/c1WNBZQKmQQqbRAMIUBa1ztYvdTxh4ZP7lCHcPrbHOwpP4TdNRibfqnBU/gUDCayXHoJSlqUsLBkjU81z8/w+dhAUA/cTq3WRHbEjFC5Ad+qZecnU/Jd5d0SmBFMUilx0czQ+vIPDYWQ1onvPpriOGWryY0oyaYj4gLn/qJetVALW7tIF+SZOq5j16eCENkiZ2MlMzBCi9A5XjU8rZsgHq68qOptxLj4vB5Sz/cPBIGJTgL18L/zXF+JXU98TSDZiX13pIPWed4C1jzTEo3wDDYUj1t29o/cmIhIZWIJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0YzbnRwLaXc/7mdC99erH53FZxB9c2BLDoAI04xQeI=;
 b=tylfFaXe3Q+06b6hR1NR0PQF8x6me64yPWTPCrn6QDcm4O7T+L5iz/PQNt3FBfw99pC714RKUWipJcjjHNLuaKmXSbPQVAVBypR0rt6vPqIY9/ZtbtE+/iJU1nVlDRGm82htKCxYNZ7N2XRtDfr9NH4/9oAqrSJzbMXrlBD5u9TcX+C4K/Qfx9mBwHknmKoUuxfpITCHruzWqDVeepsZ+6JYqLUOBNYmkE5ta51rVrBgQgwq7ZXflQx2ZLGQXtvQedUHmJ1Z1z2W8ceqf7iw15MdfGWdNEwWlsHS2jgWifXWED4kQz9+y/sTdKULgG+PKK0g9Vcah46+KGmMb+TF0g==
Received: from CH2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:610:20::20)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 06:57:17 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::e1) by CH2PR07CA0007.outlook.office365.com
 (2603:10b6:610:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Thu, 29 Aug 2024 06:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:57:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:05 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:59 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 06/12] ipv4: Unmask upper DSCP bits when building flow key
Date: Thu, 29 Aug 2024 09:54:53 +0300
Message-ID: <20240829065459.2273106-7-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 674d3da9-6b6f-465a-79c6-08dcc7f7d22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OL/MpuTyVJKawo46oadLzEFm7KcL4XI2LVYJy4Q0i7NuhEzLCQZsgBdRSvcl?=
 =?us-ascii?Q?LUoT/bH6U92gMlZDFWNmRuslfBVD7XrnO6fvkARBZuH2O6uIPDhRlQSHqe44?=
 =?us-ascii?Q?hUw3jOqacCl9NjBuZPMcejaDkKJ86zsxci/GeZpPj8YmvpnKkXcN05iCjjxB?=
 =?us-ascii?Q?Inmt02hmo1uJ+ybJ/lY6vv0EMIS/yZlnvwV85taAtchkn2MYGR2xwTb4P5to?=
 =?us-ascii?Q?fCLTTQNHhC7UQn5evfGHunrP+LmvVDyrFhCiCCIK/Vlcn1bw1pv0GTGJ4ndH?=
 =?us-ascii?Q?7wa89ARw5dePTF/hFRzGhLww/pUq3yZcDuKEdpGcAIR0uAxzqgBV9FhXwz7Z?=
 =?us-ascii?Q?88qcRTduRiWZD9rZ9EIbK2jwMxOzTvleakR438eFpG9wyy3/t4WVFzA2PqHY?=
 =?us-ascii?Q?qHjkhg4HbrjRGi9g9z3eP2veglm3ZBAyRjq0VbW2SVJ2PN5ZOb8UM3DZmT99?=
 =?us-ascii?Q?GIJzcBeH+ZUAT7N7iS/jQVwt4QeWIo81c8j6f/es50qZrGAOEj6QlL85bZdo?=
 =?us-ascii?Q?HJlUFP+f7YDGogTcT4lCyr3TMa3PdOy2fz3jRqUpq42etyzwebdlZd5ajpB8?=
 =?us-ascii?Q?cU97D8KA+vlw7omHreYC3JvMbj/jKUdKShGjY9YFI0RDAeu3gsNi4G0rOjbP?=
 =?us-ascii?Q?0Y3gkZEbWfnfjXl2XVAFfXWC1PrTtyB7YioEc6DDpAgImKSezSIJ2NxXrkQ4?=
 =?us-ascii?Q?JRbtfQbxTnig9NZGSYG3qnGTmB6GafTB/OMddCddg8H8sdCj5d22DDCgkOYF?=
 =?us-ascii?Q?rWdMD94p78C9EVXvSihrws6Uz7exW00VGg4vQUONh77Yl/CwJoGBxDpdajYm?=
 =?us-ascii?Q?n2ZrjUaKTkAa8GM/7M/Apv21RslUDLvWszSatmlVjSJRuZ8Vd+rfr07KfTjO?=
 =?us-ascii?Q?XFYSfJQk63yLlV/YBio8qAFiPeMYsAEbnHOMDKoPu1fx6WwoKuqwY/JU/jtw?=
 =?us-ascii?Q?v7WRlbl/CQuhZ2qp1/ZztqWUptcfhFztHQQfBtSl7GQ41RZNvRsNcq812FUl?=
 =?us-ascii?Q?1dnFeM3Y62XqOtbiNrPkasOw8ENQoK8xfCLZffr56ZN997vDGlHNwuelKqp/?=
 =?us-ascii?Q?63S/EVlb88dcd6oDeoIY0sZwKs3WCmkO713wsj+zjzOUH5zeOBkEI7dMyun2?=
 =?us-ascii?Q?wltfT97bWm59LgE2Y6Rs2rT3NXJZL/ntwR/lLCrVMdxBbY518i5D2UIcFITx?=
 =?us-ascii?Q?iICbecR3MhIbUfZEJAb04cEsizlSgLJlSUJmbZF4xvahY9JQCr7B2t0B+Euj?=
 =?us-ascii?Q?RAwdkpLiNQ3MLs91Qa/CwNPrCocEEhrrxiH4Sb/iYb5TlABtIOhDGxfDE86Y?=
 =?us-ascii?Q?W0aUdLXQdVV7CFmpTaY11M/1fmMgJEpSTjV/Gnm2KJCUUeot34Qt0JwD9u0e?=
 =?us-ascii?Q?usc6r35sDfqpWkN13XxwmhLjIiKElHG7Da2jPnt2A76JFLjVN8b7HF/TbEHY?=
 =?us-ascii?Q?L21UbKikOos=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:57:17.5694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 674d3da9-6b6f-465a-79c6-08dcc7f7d22f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892

build_sk_flow_key() and __build_flow_key() are used to build an IPv4
flow key before calling one of the FIB lookup APIs.

Unmask the upper DSCP bits so that in the future the lookup could be
performed according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/route.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 5a77dc6d9c72..723ac9181558 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -512,7 +512,7 @@ static void __build_flow_key(const struct net *net, struct flowi4 *fl4,
 						    sk->sk_protocol;
 	}
 
-	flowi4_init_output(fl4, oif, mark, tos & IPTOS_RT_MASK, scope,
+	flowi4_init_output(fl4, oif, mark, tos & INET_DSCP_MASK, scope,
 			   prot, flow_flags, iph->daddr, iph->saddr, 0, 0,
 			   sock_net_uid(net, sk));
 }
@@ -541,7 +541,7 @@ static void build_sk_flow_key(struct flowi4 *fl4, const struct sock *sk)
 	if (inet_opt && inet_opt->opt.srr)
 		daddr = inet_opt->opt.faddr;
 	flowi4_init_output(fl4, sk->sk_bound_dev_if, READ_ONCE(sk->sk_mark),
-			   ip_sock_rt_tos(sk) & IPTOS_RT_MASK,
+			   ip_sock_rt_tos(sk),
 			   ip_sock_rt_scope(sk),
 			   inet_test_bit(HDRINCL, sk) ?
 				IPPROTO_RAW : sk->sk_protocol,
-- 
2.46.0


