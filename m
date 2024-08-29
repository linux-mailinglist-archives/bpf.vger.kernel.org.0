Return-Path: <bpf+bounces-38376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5E9963C18
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C112D1C21932
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7C16D4C1;
	Thu, 29 Aug 2024 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kUQIqYsF"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99F16133E;
	Thu, 29 Aug 2024 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914664; cv=fail; b=P3qXTMVb75swaZAulvLP7wdVW73H1zlGylHzB6nlEtyGJ8SbvBC8mv6NjQRkHH592v7O/6b1Hg+yITy6tS3qC3GivcklEXMU4RCvqZAB8DZPADexAwTD4ukC0J13oUX9M1nEOvQ+NTzstTjRSnXDzdhakv4q3tbxvB5TgvGq2Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914664; c=relaxed/simple;
	bh=Z9JoJ00RaJuveE2bNXB1drQQTRl4TOyJwZpO04QGdxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vd7+Pm7BaYZbUOkkJYfeL7V6dcTgbm6JEyoTeilsYpLZ5g+RcqH8y7KXSiuHW3uBaeEhXWvpfwQEezzg0H/Z35GM/kSGYaK854+PWYK6y9RsuhUKM0E1To+UFRwDPcd/n9V+LMrh7C0cAUm6rCngEcn2SiCVJnXJG8N/+EdSQKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kUQIqYsF; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bU04j0BPAZ+aGv1sT3dtP82bsWZLisZAs6p5m6y60RmRSiiL9AQIToSA13hXoOMIpsjRnQu/WKVs9VivwHkTlyX837IwlXeztKBAxsl2uxxjDuOtu5WU2Cg8xwM/F40Itf+zYlxtSHY56+bVwOE32wMKSjvFtPCqP8KJ5BJz3efJhykyZjiB+mjU7lDdJfKwAadhKHGZaEm8QFQWlBttzB0OenGQslZpypVntJRnXkonrg0KbEVS9ypbk+IYXYpA0ursBGTxRy8sqh2t5JAS7U0yoiaQKYnbEkhHmKUg80jUALN/4mxmUlOkRfxEHBZP+GbxPoymcta94zdYwQKJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKqkKGH1ZykYAvgv1f5F/xXkLVLKvRmX9/iPWuPGgBU=;
 b=kOT9qDYShKgnya6gmfou5i1lTQB4Xd2TpAvb9PxgKJUGK6EG3jw6o9M4AZ3/aXWCSJY1KyXerDaR/k2T+u6laDQc7ERGQJQMyWrMlpxw5d0VRJzYd2bLQyX/cyKoHtUdVEUR/JzNCPxhErtz9vyWYqZHBgQ+mB9XD1j1OfkrvFYbxy6U6B3iQh+bOeZdSyZlqvLe4Y231iXAzxv3Meky6e1fGCKR36BMb/ocGyG0aRqVLk6JADmRkmG0wa+LPlxdRbBLDijUTg3sUbYoGobNVTBA+R4tUP/B24S0HWRMdDVCXKETE+ROqBabNBmfxdStRXJBfcJ9gAR4Rlc7eSz6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKqkKGH1ZykYAvgv1f5F/xXkLVLKvRmX9/iPWuPGgBU=;
 b=kUQIqYsFdqzdyYxtmhWHkWdhDphRjHCjKQNcOcs3v2CEmovx5ZZBlvmzLRVQoi+fdBAKxC+fJ5RK/sdk7ioyP2yM5JlOO7KnSFeLA0X2xGB1LSFukQF0EsG926sVDgbWQ+Erj1NudmQqhFiNeF2NqCvxVPLw9pv2mfm3VyA+QP9ebjetk4LdhZlcwCjkg05jh/J34S6wwBIRv2Rjxvadqt/otRZPzYQD54UglfW6nUTR1vAWmMJYfvgBA1VHGaY9AzbiZuMcV6YY0Zp/cfnO18e8J8WE4KIMi4Jfi3h5MnvPjVjYH/lp5eC5LZ58TOUyWblhVpVZGfSou/6iZyjY4Q==
Received: from CH2PR14CA0017.namprd14.prod.outlook.com (2603:10b6:610:60::27)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 06:57:38 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::42) by CH2PR14CA0017.outlook.office365.com
 (2603:10b6:610:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 06:57:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:57:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:22 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:15 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 09/12] ipv6: sit: Unmask upper DSCP bits in ipip6_tunnel_xmit()
Date: Thu, 29 Aug 2024 09:54:56 +0300
Message-ID: <20240829065459.2273106-10-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f481a3-905b-4b27-6ee9-08dcc7f7de21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TzMFsKiulmP5kbeEt0G0A8zD6hccj9S01Hq1CvTZNBmFCCmcLCfeLXjiKgII?=
 =?us-ascii?Q?nAL53beSkjBrU3s+iQJfvzMkHLxUl6TGFk4tV7Dn+jGHyouvqX4YJkiCE+1j?=
 =?us-ascii?Q?NC3ZRwCGJ2rtNIaqzze4Oedyqi11aOwgTMBhzKqcREKZD5SqyHgoOMGUfErh?=
 =?us-ascii?Q?4PeTN5ewJYsj0lfQdafJQIUEwGd9262c7BwYIQ1ENedSG4xVCzhsWoB4MCYp?=
 =?us-ascii?Q?/42ZwMeALpqcBSza89My7h5uXuJs3ozLSfaDfXaa2P5LA43KyK07Qu3y1io/?=
 =?us-ascii?Q?Q0CkpkxhiaW+7wYdyGhNYYZ1KDEDvtTkIMRlOd9EaGuVjQGCRE1iq3Wh5Vvt?=
 =?us-ascii?Q?k1wBNT7w5K3L+tzNUwzIK4y0ouH+SVnJO3oM1CioSwcKDwhoY8wExhhex4Wk?=
 =?us-ascii?Q?eMQyv5OlgKVHOvJFa3IcE2tFbIqKwyn1WQ8UY4153z5Jrup8sZ4JexmCF4Xc?=
 =?us-ascii?Q?X+oDA5Z8QU1tPBFhuKcg9sZ530uHO0UIPFM9POLGWZaRldBjIrlitA6ZmymV?=
 =?us-ascii?Q?WrRyFi5VxXt+UfVO8yJb4jsRRZ4OC17maERH4gb+BOktTouLk0ACLgxZbyMv?=
 =?us-ascii?Q?6aThyXGah9BpW9NjUDWbkfe1y57SUyTAag/sI+Xj19lsf5c2QmbRERoSZujA?=
 =?us-ascii?Q?4pBQNjxaf7mfoIdJnad34CvX+8+cIMhZGCDd8nARi8Lp7UNDIZJi5k5jennQ?=
 =?us-ascii?Q?EZbrt22O/ChiwaD74Wou+CjQHzO9ZPDtYPbh8zIIwNa/8IPl1BrX7AWAFCxi?=
 =?us-ascii?Q?0vKLlsaCmX27GkJv7mlwzWKZu26qfW138sf/J2GVDftIJq4bRftNK1H2sTyl?=
 =?us-ascii?Q?nQkpGe1klcQr/0xwAgcscTht8IajAnuL2yE+KyCBYVNxjiWGewQo5Cgm0Ozm?=
 =?us-ascii?Q?7X/MDbNdLn14mJoChNdj23LT6dfMFJg3ZH/Ho4BYPxDla1zZiuwvvCu4EMhE?=
 =?us-ascii?Q?iUlFVAQGBNzjgal67r4+NQShvY7ivLS2fy8jjlpPfAIeoDSmIIE/KjPMzVc/?=
 =?us-ascii?Q?edOUqucRMbaaNAs9FpzO5B/XgLs8MEa+gQUWOFjO7QOq1oiSilMYlr4daq8X?=
 =?us-ascii?Q?SlocotBNaBfwgvkCFmFlIAMz67pfiKhXEhrNjtsyFVltcLU/unBe8gCTQo8c?=
 =?us-ascii?Q?Qvexwse4mzGN+gTlg3PIIAwwHpmY4bufWtbyyvAWHjAp9e1f4aRvJ+xmcVKm?=
 =?us-ascii?Q?sQ1vSFq5xCcbgxev3uISYaXPB3fss4OQAp4pw0F4Dp8ZkYnoJ7cWUG5Maplk?=
 =?us-ascii?Q?erewGMznLqpJfx/k3j16uD0kY59FQqMLu7VBEKTz+4zJVDMbc9lEchLLgjpQ?=
 =?us-ascii?Q?MaX4CVdssU619pskZg+P85jsTMcUVInsyhKsnSsNxfimpKyix3ak9quNqRJv?=
 =?us-ascii?Q?R/GgUlwfh/RygbO0CRnWPX4YVcvY5od0wrCwKqpQtzc4uV3KYfpoqV070pEG?=
 =?us-ascii?Q?l9ZMpJ5FCenF/ovD0z5L9psnzhMw9Nrd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:57:37.5787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f481a3-905b-4b27-6ee9-08dcc7f7de21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272

The function calls flowi4_init_output() to initialize an IPv4 flow key
with which it then performs a FIB lookup using ip_route_output_flow().

The 'tos' variable with which the TOS value in the IPv4 flow key
(flowi4_tos) is initialized contains the full DS field. Unmask the upper
DSCP bits so that in the future the FIB lookup could be performed
according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv6/sit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 83b195f09561..3b2eed7fc765 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -51,6 +51,7 @@
 #include <net/dsfield.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/inet_dscp.h>
 
 /*
    This version of net/ipv6/sit.c is cloned of net/ipv4/ip_gre.c
@@ -935,8 +936,8 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	}
 
 	flowi4_init_output(&fl4, tunnel->parms.link, tunnel->fwmark,
-			   RT_TOS(tos), RT_SCOPE_UNIVERSE, IPPROTO_IPV6,
-			   0, dst, tiph->saddr, 0, 0,
+			   tos & INET_DSCP_MASK, RT_SCOPE_UNIVERSE,
+			   IPPROTO_IPV6, 0, dst, tiph->saddr, 0, 0,
 			   sock_net_uid(tunnel->net, NULL));
 
 	rt = dst_cache_get_ip4(&tunnel->dst_cache, &fl4.saddr);
-- 
2.46.0


