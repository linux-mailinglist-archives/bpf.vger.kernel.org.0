Return-Path: <bpf+bounces-37705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B92959C79
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2991F23A79
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4C4199923;
	Wed, 21 Aug 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GwNKsL5Q"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E69199254;
	Wed, 21 Aug 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244905; cv=fail; b=Ad2AiUhMUFocEX3qAP/3qzNWbwNSWCq+au5n7k/3ekUoRbSMl4hE6fMKLSHnrYtCnqvX1YrA/pSBTcnrLKy3hL6ckluMOR/1qvLflRY5ZMZ3n1y7jIsZd7OxvwQc2AfUtbb3E3+fIfrtKv/dbiI5gWQAentqLcYTg6t43eYdC2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244905; c=relaxed/simple;
	bh=KhVJ6KPbI5VTPsJn+NMHoIaaboBc/pGI6rEL+SWDnpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhfNqVLeDD3R8UdXu60V5Iw4+ijOo3rn9A0faoF+njQ0KT+AgDrp7qfkDb0mlABYoU6QOUUcY5ubdh4qw03AlV/5Gcu+BdspG4Svg4wGuvh5wRok/qunodcbbDRJKYWxJahp3scHMFQOmnBsJ7PyzS2YLq0CKsH1OFlq6dvcfWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GwNKsL5Q; arc=fail smtp.client-ip=40.107.100.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxRYfmAsXbh8ZuQEHvLeGPp+tmnK1aSC3zzS+huxkavrQ82zFsIlIfptZf5mtoWq5tQoq+mrr13uFNRd1IWi7mPbFCSsK0sqi3ONIw1qt+cJVqLuY2gEvfclJHpOE3nxbFudxtscD1VqU/yp/zWiBXRR5i06jOxE1wMacOEAnnErYTyh0Kq4OvGtgj3PLDFDQaAxEwHG9RzAjbG7zo06rEGKEEOv6xzxE6A/biEshhRXWXn4SnOm+FjHr53jtsLpt1OBXdkaMdzCk4BMe60fQKj1pzdy0Itud0qaIzfeVxClT+B/ynEXodbgjc+La2MbHLCxWtd/h9w6lvlGeXEOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlDYgBt1qrqJ0qeK7LStIxRtnKU/C9Hpp9kk7THx+OU=;
 b=iHiRBMwNVtNlNdsGuvM3Zdq8Iy2fJgS6nbpUHCsrkUeA2GdYqCH1gTBEftq+G2NWo/P84+4gXhA94XQoR34MkphM+VQiPRJrWsQe6NxXuXJtgssLTnKa7cOu8jA33TDcL5MzZGaajFb9Or3nxbusom2cm0jd7bvelDExMzS0ZE6Ube23zuPq7k0yzs3cee0eRhUCbdvItBtPS2a91pg5kVRLFS79BEcAcxAcnFEM+vbtZvUfFx69jMuHE8qJLKWVcG2xAYfpaK4bY1z/71h7qmTqS95o1+XClabS3CbsRs5PKH7SloEVn+55Io/+69CQH/ZLOQ2dFvpQf9jCF10yVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlDYgBt1qrqJ0qeK7LStIxRtnKU/C9Hpp9kk7THx+OU=;
 b=GwNKsL5Qd0NC2JsoJW/hx8fSvcKpnVg+c5XgHa9OHf2AP2MvQpVPlA5A3Op1nWd7i/+p6wVJbLY2NCS0b8Ey1oLWjl5jAz3WcSU23GWdhmlx5IxDp2gpAe+c2tQV/+XhuMTncfRif2sD+i6w9irG02vC4VOBJ71D0m2SuDqAGmTRoIjKD1SYmGEQLotwC4snEFokIE4IeOZMSq0tQDVlZZkxp4ohRjAni/klKUQsGZpbkpN2bd76AY60HIQ9LARo0PFZYf3YVTiwIIno7X7Y1vS2gIDUmMuSgBG4Q98ogZS+8eCtUb3ns6rZzIxwwBQ34QQQ6lOV038WQMR4am5Qcg==
Received: from DS7PR05CA0072.namprd05.prod.outlook.com (2603:10b6:8:57::7) by
 PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 12:54:59 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::e6) by DS7PR05CA0072.outlook.office365.com
 (2603:10b6:8:57::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Wed, 21 Aug 2024 12:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:54:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:54:47 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:54:42 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 02/12] ipv4: Unmask upper DSCP bits in NETLINK_FIB_LOOKUP family
Date: Wed, 21 Aug 2024 15:52:41 +0300
Message-ID: <20240821125251.1571445-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: bf29eec8-7c0e-472a-b3eb-08dcc1e076ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eaizPZ99Pa7eFFRJTod+H+69h9KRVu8KiyfilKJPwj7cG7WiHN/DE34AgwFw?=
 =?us-ascii?Q?UqmsyD1w3i4tEjH5rRFO4F83/CEAF5pJ1xNVYmrDrZwAMKmjLpuh9Me6tfRN?=
 =?us-ascii?Q?tCbS5tiKFtP0eTjAQYk4kx6Q3PSMKnZn+ZAz0tYBjOfCJgm/HLTAN4sV7Wzh?=
 =?us-ascii?Q?HHfYuSrqx6oPk43MLak/E639lFEgehoKa08q7buy6RuikR0gIGEer2qUMxbj?=
 =?us-ascii?Q?EZaY/vIlJublQ6U9I03zL/2ljBslrMCH4l/KpyH5X2Yj+yZzBGwPSuwwXQap?=
 =?us-ascii?Q?02UbBb7BbtrJr8cUbJz7z8HXdmCr02DriQMo8meOP4RY6tzuM5RtRNtoZz7N?=
 =?us-ascii?Q?pqBW/XVcBfPJxTVrWTbpu+GfLKoxJ6YQDflga4iK6Nfr26tMVwSotX3kErQn?=
 =?us-ascii?Q?edBJPSNd9UGxy57eAqCLGezocmVsCVIZeEs6kRhJ79X1SnXTHq5JDOEJ2lcW?=
 =?us-ascii?Q?xna7klG2VsRPU9ZRwu4v3CgqRBRqfVHL1fEB1SPPgrIRlwOSuxmntH7dphbN?=
 =?us-ascii?Q?soCDYtBK9j69Lal4xbRvUME1cTsJfWBehKxq91yqsrTIinM3MG84kHpsCF96?=
 =?us-ascii?Q?N3dupW33LSDQN8Fig9ZZdt1N/p/EamXenGUS5P8pKoNRk4YDiCG/gN4EadXN?=
 =?us-ascii?Q?QEJ7kOwM374u1RcygEYZybRcfmBVsG3tA9z5kH9Ep6wowc6w6RcAQ6dArexU?=
 =?us-ascii?Q?ybtVuZmgYlobY0I4VyAymLGN3F8L3H4YxAVK9Q7PtDOeXewEbv/wMWAeLgap?=
 =?us-ascii?Q?v8EEGaiiLwvENjBK+C6yxGa5jK8H0vzg9lOyE98t6APHR2EG5e0ZztrAlOdq?=
 =?us-ascii?Q?GgUDSt2cQ8Elrx9clAKOme5UVXJo/fEHEUB8u96ppohrGpj+JgXDofE6JprH?=
 =?us-ascii?Q?YNtPOxeHFE9M9G07wpQhExCL0lVh/ES5nonUu8f66ERV7v0LSrlglnpDtAyH?=
 =?us-ascii?Q?n9/aklx+niyhPKafMn1k+R6rkESPVHEGVkWBZ7SjIViWsY4lVtFDclKWkRyT?=
 =?us-ascii?Q?dFkHLOxM0Pyb45hLtDr4V8l6IlGPoMZHYIqCj7EnW3JxmQT0UDVDTDmmZPky?=
 =?us-ascii?Q?o/i0XIUVICGoVMvv+BmGpl80PjDoBQ8oiUlGPA31UaR+gBXXUVc12VSwKUU/?=
 =?us-ascii?Q?7pxkLFy5w/rdLbQpS+AxaY2Yubv3pVhjsJF8Taz66Xo4OO2iXbOVIDm2vnTf?=
 =?us-ascii?Q?6UbqrX47fdvetR+gc9dol8PUV40S+nVuByhsUI0u/OYdkupifYWmcwcJPIM7?=
 =?us-ascii?Q?LNoogc6HVwJNeOEUbvUBPWc2hPoHeiSz6hw7BbTctoevAISJq095irumb9hg?=
 =?us-ascii?Q?aHxGJzKV6eIkIvhGbO9HDB0vazZFET2/Y9Mawkqnhzj3ER7STjP7/IPPZAvM?=
 =?us-ascii?Q?rfU6u4PJTRw0pRKzDJULvd522y/xDxIY6l94DdPLRBvxs8+VezEW0bCT9rpN?=
 =?us-ascii?Q?LgHQUGx+A9CKyr9HlIg262Lrc/c7SKqd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:54:59.0461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf29eec8-7c0e-472a-b3eb-08dcc1e076ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882

The NETLINK_FIB_LOOKUP netlink family can be used to perform a FIB
lookup according to user provided parameters and communicate the result
back to user space.

Unmask the upper DSCP bits of the user-provided DS field before invoking
the IPv4 FIB lookup API so that in the future the lookup could be
performed according to the full DSCP value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/fib_frontend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index da540ddb7af6..8b740f575da1 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1343,7 +1343,7 @@ static void nl_fib_lookup(struct net *net, struct fib_result_nl *frn)
 	struct flowi4           fl4 = {
 		.flowi4_mark = frn->fl_mark,
 		.daddr = frn->fl_addr,
-		.flowi4_tos = frn->fl_tos & IPTOS_RT_MASK,
+		.flowi4_tos = frn->fl_tos & INET_DSCP_MASK,
 		.flowi4_scope = frn->fl_scope,
 	};
 	struct fib_table *tb;
-- 
2.46.0


