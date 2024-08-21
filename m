Return-Path: <bpf+bounces-37713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB49959C95
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383382828D3
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D209C192D84;
	Wed, 21 Aug 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dv9o1KUX"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF1199929;
	Wed, 21 Aug 2024 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244949; cv=fail; b=qy6+j2MaQ6pFVJtbsUyotwJNAxy9md9YtTeP5DImieoxn8cyZ5w9LJgSEoIqYx1YCt7+nqtr052PE0ZsgTobk0tnGtq/qef3jpURMIwPIAqROgLxMeIl+DDY4xuTrnsgxr1E+Kk2OlcmIGP+VLFCqVMD4u5ST4+u5FPmkLKqWXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244949; c=relaxed/simple;
	bh=JdJAOZdeIb/EnwB5kzgnKm/t7RTZtRp2XFvC+2JBaKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8djL2gOVtVU/S/mzP7d0mtPJIpyvNjvfbdM5dlUbp+EHzX0NZ60o7YrY5QQ98lYdj5FAtsDmStPndfVucJlwC+aHeGqpuMJ1f/7ms1BPWseOm1u4TxHbaqSskO1pbVzCOHJzQMsGjo1wIETeH1fJJacRBXy8kYaxCfz7rlQ3Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dv9o1KUX; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CypxgEMqx5SoXqI+TCZlmXnNMRc4771Wi4Uzh5fC/g+zLuF3X4yr24ic3NxwAsIOFQyQ/4I+pp9nE3ogZfQYa8Ymnc2S9C6ZGh8oDZug6nRG0RQRD5QMoUUvrrljMsvRk5BQ9LBPAkCcS729th7jL0+YnnqQpPk2nV8tL4t4OPPL89KslsBAZUVMtYwN7u4lWI/yy6svtuVqKet+kjj0WAVBBbsCMSxU0ENB4AlQvY6qxO2tuQSvM/j4qslYHRH1zn5CTmrTaWE0N7foKIKQBx2X6jxqjO6kcpKrdbx1Pe7VLg51y9foFI9qstYeKWCXfBtSTaxt9/RPdrMk311Guw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNn9TVtOHYLkQJp+j/8k31F5Cd91zfWdA9w+5U7JoQg=;
 b=krL6u0f/mo7OMOhMJw0CzQufbtUGKbxpmGYBQHczl8V+rCoPzD3WmO1fiPwsfSsxr557bai2qnhcO4qybaHcNqNo/zoBOxZ7ybKofqMK8bgnmg65AFEipyVz4OtpTwEu7I2qybfVt5yGMPhOWD0SU0P5daEY5gJcOfIQJse7u7krPpoKzXR+Ferqud+1opbFkzWMGt6/3SAXFXshMH/BazfeHwG0V417PrUhFU7CSpHBBf8hncqF7Ia1oRakoXgWN1yyZRCmpw4vR9+b8wBHMmfylWWR2vtgf95YMN3pMmjbSNG2Gd/vHtf6YItWeezmxE13VM8CYwoTmtnaEJJu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNn9TVtOHYLkQJp+j/8k31F5Cd91zfWdA9w+5U7JoQg=;
 b=dv9o1KUXzAjUi+tpCrhzD4EBK5rIesLGYTKrkef+eyEWYOsZYfqooThhXkcN4OSWkxM2jtWn2XUFtHT+lwAKqbLrXQ1ItYDShrybwgYCao0ZmNyQr09LSxCXWdp2Gc+sgBS01w4jSzqWtgHgx7BJFnxn4PiNSY/EoJqVCkkPPLbc3CByv5zaWBgW19HlH5dEXC424E0dPbgXelIz3qzyJghpclwRkm+VoVNU1D/4HmCJCR0+bRT/HJraIEtGd7GCM1aSwZqMQilySnZb8AOupJjfaMiDJlREG8Lfv4nl7AXFk7WPgVAQy2XdnpWhM/PbNVyfgKSWtw4oZRJKedm78w==
Received: from SA9PR13CA0026.namprd13.prod.outlook.com (2603:10b6:806:21::31)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 12:55:42 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:21:cafe::75) by SA9PR13CA0026.outlook.office365.com
 (2603:10b6:806:21::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Wed, 21 Aug 2024 12:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:55:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:25 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:20 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 09/12] ipv4: Unmask upper DSCP bits in RTM_GETROUTE input route lookup
Date: Wed, 21 Aug 2024 15:52:48 +0300
Message-ID: <20240821125251.1571445-10-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 54155890-baa4-46e5-4294-08dcc1e090cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EAVYrgi5PJjM5Pq34qPGs10tu+SzGk/FHvVfIPxTZSrI298XPIaFF8YfpSKV?=
 =?us-ascii?Q?cKkavf7nQxZaH8d0Zd14ybd6/ACn6Zh/U02BPO8mFpiWQUrmFOfhOFDIgz9J?=
 =?us-ascii?Q?Udb4F1WUGo9hfRlNKusoG9oUrVNFdvml+SH6vnQunbA5EsRCEhEBrNG30FVx?=
 =?us-ascii?Q?RQqZqfh3d6MSmimKbxLDrBy9dTUXJxYTjM8FhIHFofTZv3UtDND0gxvhgMPa?=
 =?us-ascii?Q?yguOwkxN1Hp1GeqnjUygnBeB5a7mMflHjhUlVxrjwJEw8Xa3KNOEIcOTuKdN?=
 =?us-ascii?Q?JwQCiJbUJkhkse5cnG83Q6CRZSjz2QePAgon3anjji+ayF3FXAXtKLYoSST7?=
 =?us-ascii?Q?7+gKrOWEayvQZkomVd1jAFamfTSU8XdlKRvFe2iHVfuTRWEa+hex2uzGw4rT?=
 =?us-ascii?Q?UBgFFlg6zs/B+3jsprIq7gUVwUtv5ivWSvxCF+J2MkkqOYgQNLIhlEtb7I3D?=
 =?us-ascii?Q?vwMsd2QDczZxZy5BFVb/DkkUXIMgvvz7W3sWS3mZ0/OWQBpH70M0cwWfNf60?=
 =?us-ascii?Q?YL7GPpOcuQonNTVRZTYxOnPqin3e/Rz+PEm5VUE34k87JTgOohCPVAhOlX51?=
 =?us-ascii?Q?a6P8suqPdfP2zRLRpGmgjJHDY4pygVOCP6ZMt7nFR01C7GLEme4Ki86Nkf30?=
 =?us-ascii?Q?C5gQif5Ar6BnrytDKokBDYMISydr1o1NQqXhaTmu4H6mjrZHujk8+IBE8Gkd?=
 =?us-ascii?Q?H8Sy8ElTzqw2/duHxo0T6UsOV2JG6MHaxZYxOp1CfWmnl2p5Zqri1ynpNGMF?=
 =?us-ascii?Q?45xzga/Axp3AKZuuGbAoEMBMGUxqT/9hq89sPlWoXrSJDK8Wdje9ttdtBJ1q?=
 =?us-ascii?Q?J7Dq7y/ylopIvjLyB3nNkXjw2fZAmmGyg1L2hBxIbZu5tlXnF1osc3AZYQ6v?=
 =?us-ascii?Q?cah1AwjiTct3NsDODKf9vqwR5/oeV2rEcxBfIyKVDiH7iP6V+amlwugXXunp?=
 =?us-ascii?Q?u6I97kwUsF2WjC0ONaibE+le7bazUdJEPSbtykUPmSnzmtLsgX7k+U6GEZg6?=
 =?us-ascii?Q?LL9awjkog/YBF69HRqz0le7cyMgQdiuDmxMF63MzhObs5FZUDwNSPYnhqwyc?=
 =?us-ascii?Q?sP5xcOyG7ChTuDviX13gJVbSmvEIDXVrE3kcffHGyzmup7YAdjH66VfKFUH+?=
 =?us-ascii?Q?vCWVjf4wgtNthiew9xJtwr7y9QfC+kFzVTbX3B2x9VZQA0cZgnZaKaEuOg3T?=
 =?us-ascii?Q?u/i8hRiMwmULn5sDrrUNJTU8SLdttvBibnu65qqzSccOBlW3n8V6Fg/VsrhA?=
 =?us-ascii?Q?3tZZM5EaWyw+s+EFcsY2STHWpuveBInIgy0XgPOFcXYGeZYXYePEQMyJEZka?=
 =?us-ascii?Q?afOBBFjr6dGLjFabRnrnozoS5qCR2y4pvP1gv1G8iaaBjMFnNmmXIgYP7OwY?=
 =?us-ascii?Q?zk5pzd3r9k1oUvLMu2vZbNBb6zQglEEGSIhMn8YgsGCCks9WJmCyKJSNLYdi?=
 =?us-ascii?Q?ldiQjs65INmdU61ZCbz90mrbXcoR+uCQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:55:42.4567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54155890-baa4-46e5-4294-08dcc1e090cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256

Unmask the upper DSCP bits when looking up an input route via the
RTM_GETROUTE netlink message so that in the future the lookup could be
performed according to the full DSCP value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 73bb61162445..524b70ab77a0 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3286,7 +3286,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		skb->dev	= dev;
 		skb->mark	= mark;
 		err = ip_route_input_rcu(skb, dst, src,
-					 rtm->rtm_tos & IPTOS_RT_MASK, dev,
+					 rtm->rtm_tos & INET_DSCP_MASK, dev,
 					 &res);
 
 		rt = skb_rtable(skb);
-- 
2.46.0


