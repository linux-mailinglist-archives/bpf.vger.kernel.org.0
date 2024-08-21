Return-Path: <bpf+bounces-37706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84DF959C7C
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707D3281C63
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FC2199254;
	Wed, 21 Aug 2024 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dXtx21WZ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A419259F;
	Wed, 21 Aug 2024 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244917; cv=fail; b=pcLHH4Q9PjKz6eTcS1Pis5j8m5KNMDQ9ViuaLR7jZTKK0oL4fO8ThE157ayGwzUF7a1mZfMUHv/Pw+I73eTDdT0ZY/KJjWO+WsTOQoM3Z41uY9sfDTx59EN/3zsUPYcS/cEaEGWIniITuRPnrM/1GkKKIJb019QwgjkyW1MF+ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244917; c=relaxed/simple;
	bh=nxv0I3FxShIzkDqh7EPO7yngogz426b+AGsrPo0TQLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngSiL0qVOeWHBcu3ziH7Ow5iF/2W26KBD9A1UkV3dk2NVGlrq+JmpW8mLwmORwM1beLQ6/Qvne6S4W6YJE1RGR6a4fnmvE0V17ofFMQ5bdQJFlu7t47uuPRANFBUNqtVZj/0UA817o6917dSMXHV1XUTqK4AR+gnBB+b57eGKOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dXtx21WZ; arc=fail smtp.client-ip=40.107.102.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1pO/2rW1wsdKSPw02uZuHAb2LrvWa/RW6vvVWv3nBq34P5LNo3ZozQmVKjG14PbLYiGPYZjx710IpxEKgeT4WqdHKJtb9H27Vai7zmGFFsR18NQxwFxMLCHF9dHVcZhChgq32JaGxTsxX4EXGdTEu6PRi90g/CFp1qGcWaHR32r9ORAci3p2ncJwYozVaZ8/tVSJ9K4aYlw+NkLeAcbfasZEJYtaI0qw5xe8tasVfjkEqJPz0YpDMrwShV6bIeOAlqDppeBsSOkV9vMkoLhGe3jOB5JT97EsCWxlMWmjKY+TTtvr8XtQI6sIOAmodzrelNTocUFWex9E7ouz8Vn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbsujHa33SRowM94zpyo9pHEEx1bwuyvreMXZD5TDQI=;
 b=v1jp5hUe5OLHStVeT2MOarbF3xFOMNyJWPedLnIPh4cvdnKl7cSPO4LJzp9mp+4clUxZi6scUAO8hxGF0qloOFfbCJkPUb0FSvFO7ex46GAM0YTgHy+3eu45wCcEADNwR+/o+NrBNWlxTKVmOEYbdoRxeg/pgxR5aFiZ92dJAHu+5vWrrIKLZS8e/tYR5EEy8/0bK8AicnyEGUGkJFKFcgCKp1+Kt896AiHhe3I4GbvG7WlmwgRDKM4h8UT8NwJB3tMD0CTnguYwtvtj+5kb2x5N+3J7wPKPwO3U6PJeJoLfiogswf1ThgBPNVyzoYpV0eb/W379HcjvvswAkZRJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbsujHa33SRowM94zpyo9pHEEx1bwuyvreMXZD5TDQI=;
 b=dXtx21WZrtKVtQBB8bIpOjpgANad5+s3Nq4xytV6OhCtNp73MEJEuuCHoI7J7VjV3Ywmaj9s3z7GuyX90fWqupk9e60UNwCr5txM2aqKOHulcY4vR64iXLGTbxpOm2jcW17RqScDp4OCmRxUZHT35IRDGRPyzGRPhx6FN8DBQS8h/hPlw58bfN4l6YxLPylcmAcvVQ8R3MlaMP5fNcvfPEM6Ai6LbeNBWmZIOYGrqCXoapE+5fikjmEpQojh7MEorCrlkFE6SwLAqiuzBxKyjC2t0pDkEQ7IZ0WZfo7yX+ODqM9ECnLtosVkQZPHVdtWlfSIHNA7XUrAEXnVKKETug==
Received: from SA9PR13CA0007.namprd13.prod.outlook.com (2603:10b6:806:21::12)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 12:55:12 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:21:cafe::1d) by SA9PR13CA0007.outlook.office365.com
 (2603:10b6:806:21::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Wed, 21 Aug 2024 12:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:55:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:54:53 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:54:48 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 03/12] ipv4: Unmask upper DSCP bits when constructing the Record Route option
Date: Wed, 21 Aug 2024 15:52:42 +0300
Message-ID: <20240821125251.1571445-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 869b9345-f7e5-4ae8-e489-08dcc1e07edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u1rPZzMGndltSO+aLtU4HyQyQ8NNO3iJPqlN7ClMItzPwFSRK9UcML1mP/er?=
 =?us-ascii?Q?7SNq8iucgJY7bYF5zYLbtHZwC6QNReO5J4OpDrLiweKcJEpMKkpUv1lY2fsH?=
 =?us-ascii?Q?qUDGT57H0jqKDorrU6F/B9Q38DTRED+O9g9/x02Wp6G/GNngaJz/68+hHSLK?=
 =?us-ascii?Q?X9KiW5yGaLQ8G0EvaU6fENoHivq49PRADiieoVsGhY27jxv+Bb9XbzUAeJbd?=
 =?us-ascii?Q?OIw4zLR0q0/r/iyZ/UgRlS7kk/B0izqoIJvMKjjiEyhGhrVU4fL6mCoyv56q?=
 =?us-ascii?Q?X/+VNhL8CRMawUnumzQnhzNSC4wT6XmRZgu7upHRg51VIwXBO+UDInqjeuyx?=
 =?us-ascii?Q?p2CHQup+AcOFkgiz/9uuM7Utx5HGsUIjFoGuMhA5JKVmxZIjQlI3+eIQj+Bm?=
 =?us-ascii?Q?YI4WGdjKLHmGB4QQg8czDB+jA3PY+iCVAn7OuogApxkUOPay4sbTH8RrkOwf?=
 =?us-ascii?Q?xt18i8EPP6i8abs1zSEZBZfPJkhxNlMM+NIWmrH/Umu3Z95hvxDPXF51Ja1G?=
 =?us-ascii?Q?vQJw7AQTOA8ILoEYA8iH68da2AK1jCQtG5+AWHpWKfi4O2FJ0p7c9/RVAgai?=
 =?us-ascii?Q?CysvTiPvDU254Q38f9J94nadthu1PlfuuERYXL+UrflXEzAo7lcqNyiaJ//W?=
 =?us-ascii?Q?lbYkwhx12HwsN3QXZX61hYfNn6SxTS3g8pj3uz20wne+3oi3pMOpZghnMgWb?=
 =?us-ascii?Q?x9kpxWthxIOG7nqb1vO1tNyCwb2I4iaTZgedN/5cBzsa54wKeELj73HlAuwu?=
 =?us-ascii?Q?C45lys0kQ8YkX41DwRDQfHLRuD8fJDNfj4CwP8wNcAph/hN0f9WcW4VX8+JM?=
 =?us-ascii?Q?6M4AeOrF/GKxTD8kjyJ/e0EGRRwcv4iDPjaLMMWyl3dClP3z8uuD1kwBRwYj?=
 =?us-ascii?Q?XDXCd1mGYRjrcPAU6w0S9VPQ6Tkioeujx3BuK4AJBvfRkWLu92Jja/DOvFkq?=
 =?us-ascii?Q?yg+z9oCUym/lD7NbPgiIHH5aLKXNMI0ZJoJQ2MbdJDfCvPZ4sdqRH90QF+sd?=
 =?us-ascii?Q?Lb5tr42U40QHdalFo/3IUe7jepbZbYsgU9AxkU5pESIBSKkgFFGzikRM+BtH?=
 =?us-ascii?Q?IhgFv8j3uKDeSlHCDv0kzy8BsI9Ic/Azfj2o3pu3s/kH1UMKZ+fNDl/n2XW3?=
 =?us-ascii?Q?0aZbaOMdnJQlYmIbnMDw+S4iV2+gzxFh7A1TMqYcuSwHb7ApVmQ81zZrinX6?=
 =?us-ascii?Q?jZWbfLzp7Bxo4SZBpsMnLb4DUuI1lN+q8svIV4R31fbYv+YFdWGll7alPrcL?=
 =?us-ascii?Q?ZjreFBdK5W2zgB3+NDvm8Kc8tx6iFBzOL8IntZEnagwL/vwZ7xqZWQi5/U+D?=
 =?us-ascii?Q?TjxJHKMf+eN/UHARFUwFRcXJcVdOmB+5V/orreAb3Fa4u7EWgpfVeowuKP0y?=
 =?us-ascii?Q?eAypNxdQyGN0Uiq1zKXC5pNyKqDDzc0Ho2xIU83FiC/Hrzeu30AbSnp1GMKk?=
 =?us-ascii?Q?oc2MoLbZAJA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:55:12.3798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 869b9345-f7e5-4ae8-e489-08dcc1e07edf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485

The Record Route IP option records the addresses of the routers that
routed the packet. In the case of forwarded packets, the kernel performs
a route lookup via fib_lookup() and fills in the preferred source
address of the matched route.

Unmask the upper DSCP bits when performing the lookup so that in the
future the lookup could be performed according to the full DSCP value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 13c0f1d455f3..9b6528b7b562 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1263,7 +1263,7 @@ void ip_rt_get_source(u8 *addr, struct sk_buff *skb, struct rtable *rt)
 		struct flowi4 fl4 = {
 			.daddr = iph->daddr,
 			.saddr = iph->saddr,
-			.flowi4_tos = iph->tos & IPTOS_RT_MASK,
+			.flowi4_tos = iph->tos & INET_DSCP_MASK,
 			.flowi4_oif = rt->dst.dev->ifindex,
 			.flowi4_iif = skb->dev->ifindex,
 			.flowi4_mark = skb->mark,
-- 
2.46.0


