Return-Path: <bpf+bounces-38140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B719B960855
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD631C22786
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145EB19FA64;
	Tue, 27 Aug 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PxYiqPTy"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1F19F46D;
	Tue, 27 Aug 2024 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757564; cv=fail; b=V6W2H/OXdz/d0FA94CZM5u3J1j5nX4sXQlKB/UygVFZFk4KxdQmpuNhnuuUxjY42r7afWNfS1MIUuA0zvZxsvV7Y+nuWQ/FedQQwdmUJWlHaTRE9Vb5c6MTOgbZVM9+luH2juXEefbphKDlL/+33T0VOUzJN9xA13PLgMTcEXhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757564; c=relaxed/simple;
	bh=nR9h8CGc8lkL2HZYBXD+kh25pcDbzUIUbxh9hhYd6Ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RV5UqCZzEpyZfGEd2EVswe02X8kdv3JlZX2dkCf3gUcr+MxGOhdTIMEQw/xFCkqGXbAVYTRCesIRR9PhXSCfkJOgLhqp4u5iLGfzlhW0bPkaz14sQZq5pfNl8EEO7Ht2HSrdGFGQLFvZ5CAfkLyYdYgElzchkJiJnFxoLlmx4nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PxYiqPTy; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRa1Q1NsMGbj+Bwtn2z4uD8ep7OQZ80yWnGmgJiEWUtIQODiH+vQNxIcVGilyfTXy4O3FrUn6s+ryncjYZcpEFlQ1ANHjrZ7x6h0uj5su7dRzAy9OZBDEDTN72UgSAT1YboQx0ywcUXN4Fnm3XygTpIqO/yZ/i/n2kheWY2NaRYDdoqp2RNgBeqABXvqk0o5u3sRxfDm0zSNn9Xl2Cj/UkOkCIab6r9DOttN4iStZ9e7sB+l/6zt5Lt3ixgo1nSw+nXPMRr7umQ5Shsyp4D3zIHBDGVrqYioGvsz0kaJPheB1eeVTXrqtDr8MJaQes57Jq7EwgKbRd42G5CxwMWRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mka0Bd/tWl4lydJeoL0KyeYnNSXOFH8yEhnO5ZvQ4O4=;
 b=Pi/76CtRXyaEdMt+dftFJj0oxgDvtObQKT+TTYiBvcqtiR9YnpJ5p51eujI2JHVKfeyChw995eL3/wsv1+Ztc74fRCkmLrSFP9lkziMXhNoybRUWRCP4l8QVZDW+XolCpINElDc7LYW4W1s5vQH1fcYp/Ml+wEi95yhgNfM1ew5yvVR9uZ9s826SEK3oep4EgKIYUPJ2b24FOQ/U6hNTni3Xgzn/TODeMkjnf8+nX+xp19/32ER8cuHi9XIST7VudZek+K0h02HSbEHc01fHuyfNaJDpB4LflRsexXFFTPw16E5iOru8lXsHn8Agrlzi3e/ULTzKC72iW9HPNIUVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mka0Bd/tWl4lydJeoL0KyeYnNSXOFH8yEhnO5ZvQ4O4=;
 b=PxYiqPTyH2xOyb/b1mHwykA3SKPB97TLRAt+xTa19tcuLHIort2dl+ecBNyZ23+smChlklVgGQYJFxsxSiarrB+yd3tAZ2MkpIVsES45Z5wCiaH73paeYdKO9fg5JUo6pK4CBo0DqadsWBJ/EHvEMKt6YN8gZ/Y4Zt/oALlpjKK+74OXzHjxtrbso92KiktU6ilzZTHU4ZbGhiGqqLLlZvITn/CIkqok/8NDici1Yi5ZDVX7ovCpEpTZk9vElnlOG3IHONnXbzUXsL6STq0+drd9f0/mlmKb8j+jlNmWo0O2RUiJeFR97LHHBmWOwl82DCBG4rZQU9ZQK1AleedC8A==
Received: from MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:19:18 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::2a) by MN2PR08CA0025.outlook.office365.com
 (2603:10b6:208:239::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 11:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:19:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:02 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:18:58 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 01/12] ipv4: Unmask upper DSCP bits in RTM_GETROUTE output route lookup
Date: Tue, 27 Aug 2024 14:18:02 +0300
Message-ID: <20240827111813.2115285-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6b1153-4a13-4ab9-0968-08dcc68a17ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+fZeyLzFKQbw7zQ7Dt2asxEzxlyLBYw9HEtpnm7Uw4olP5+E2i4wW3zTBilP?=
 =?us-ascii?Q?fP+dZEZu1rnJHjiDrsSbB4Tw1kGwHwgxheEyBtsR/8lpBOFfN1wPfhDkuczu?=
 =?us-ascii?Q?sbpAZQcXSHkYAr5QFbJMfHk6m88ExDjjD6mrO3+ULet241tcR96Q8bm6Ui48?=
 =?us-ascii?Q?fJgtnm4djxxxMNy1xIt5Th4/lXJ15V0ICA4HXUR6pGD/hoATwnkv2qMKGJua?=
 =?us-ascii?Q?QtQVuq24G3BzYo+2HErfIJ//dm8DsmnF/A+hkfU0d6Z9xDrKmiIsAhyqSsaC?=
 =?us-ascii?Q?dqaVRdPMGtDigKpt5rJ2z0Antu2223OepO1Yql1WQUHSTd4rqOGKQrERzhAP?=
 =?us-ascii?Q?JP/md1n72S+mCsTHY3EbJYdBNJLd+y5kN1GUdvC+v7ayxwxjSheq2Zr0uuxJ?=
 =?us-ascii?Q?hY/HRvGqQr6aBfIS3fksXuGkHQfyz7z5zxSeupRH5ub0U28W1M+OCIG/S5Uk?=
 =?us-ascii?Q?0okNTDt83559/AIFqVGsfsPb9J4w6AS2sf/2+gOhEyUGM8Z29i+xKTI5gcIo?=
 =?us-ascii?Q?+r19B8WDO9TfEGq0sM7rW+l25/bBwLNHVj514PPg9U6+HJTHwV2n9wWyDO92?=
 =?us-ascii?Q?UB/tr+Xe7YoDbIb23byC/df0fi1gt2DGXEu/n8F6L4sfSOgO7kl7FtIZVEBO?=
 =?us-ascii?Q?tL4bXJFgfEsXZ5adZ5OaEAUwlS/QmXr8xgLfdsnOe1aHqNJb5AVp6rf0ec9d?=
 =?us-ascii?Q?LdUXcBqdc1TCogxy+H21UX1EXp/Vl3nkCaNLb0hNMADTQgMnj9BVQK8iHB2d?=
 =?us-ascii?Q?kJGF23dSkdat4RvelOBc7hPNmksyRPdlCeiCgpZHcT/vwXMMlNeWoM+3lpNl?=
 =?us-ascii?Q?mWS3VgYekRE5BUj8MmvIlp6iwV0/VVSMKSrt+Sz1O0SLzZv9VuvKaE02NLj9?=
 =?us-ascii?Q?KoO8s7EvOO6tm1xdjb+Nuqa0eKBwKPAW7rw7FwylakjzfXh00+yR1XomCX0d?=
 =?us-ascii?Q?qY/IFlThbUROciWHYfDTb69otM9INGfeqtI8paMiqu5/FDV3trjbvfYJiHnO?=
 =?us-ascii?Q?c0k54tGwLXN775rntNHbgK3tBrFeBrFQxzhujqAUaFXt6pwbpCK0sa27TyUT?=
 =?us-ascii?Q?MqRc0ny9bwXaRJL1ahlUhWoeQ+Hffiai43VjGH7gdxCivSWmdN7hxxoNQcp7?=
 =?us-ascii?Q?J947T9kqPQ5vXoQsXvRWiG9ehaD9ZJUzgkc+TnL9upglmJMbLzygatS4XNrV?=
 =?us-ascii?Q?A81GQp4NTVtWyxzlMRPto3VmwlTQ2OC2O/jbkxEVVU6gH18dtSFIA84bkkal?=
 =?us-ascii?Q?+amI8qagS9PzrT28psJWloMC+bPEZhqF9fQAX5zsWEUa/36eGdMk+PvuH7p7?=
 =?us-ascii?Q?4JYJn7lG6vs3ayBNp0pGfOM7FkRt4z3m0z0gt5hofX0Pqb4fgP3kXzjgTNnb?=
 =?us-ascii?Q?uC9Qtu5ELCzpngrmQq1pryishl9WE2tEa9YHoaYxnSe1dzkxzB35XpJfWM8F?=
 =?us-ascii?Q?y4mVebPXmpqJAmarnyAe5sQ7RQvPGuat?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:19:18.2829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6b1153-4a13-4ab9-0968-08dcc68a17ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

Unmask the upper DSCP bits when looking up an output route via the
RTM_GETROUTE netlink message so that in the future the lookup could be
performed according to the full DSCP value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f6972b24664a..e4b45aa18470 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3261,7 +3261,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
 	fl4.daddr = dst;
 	fl4.saddr = src;
-	fl4.flowi4_tos = rtm->rtm_tos & IPTOS_RT_MASK;
+	fl4.flowi4_tos = rtm->rtm_tos & INET_DSCP_MASK;
 	fl4.flowi4_oif = tb[RTA_OIF] ? nla_get_u32(tb[RTA_OIF]) : 0;
 	fl4.flowi4_mark = mark;
 	fl4.flowi4_uid = uid;
-- 
2.46.0


