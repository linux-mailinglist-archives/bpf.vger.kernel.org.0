Return-Path: <bpf+bounces-38368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D961963C09
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E108F286006
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E34B16C6B0;
	Thu, 29 Aug 2024 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XXhhgDOY"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851041667F6;
	Thu, 29 Aug 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914615; cv=fail; b=iYPa/CHDQUA9te8PRydPjhrhHJ1hSkDj365WDDmbfERYxX5ZWVUWT/UoMcrsfZN53z8dK3xUh56XsQ1zuwr1Ucc0E6JshcanE5li3jXVpJZBKfPTC6SL7eZ79T0yiZjrhUCCSx3WAN68PbTcR84eSb+EDKf3oY/FIqX3Q86TFio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914615; c=relaxed/simple;
	bh=/Lx8r3IqAu1wd83IbelkEc9LgSfjXipzetwdJB93++M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwPhnmQdBFTMgkCa71WwoPy2tZJT+AEDLaMjL0HCdoDlopWB+ntu0MMYHb2ypjPIfoWRGwtfljDCM2oquH8Gq46MxTn0L9UHf/UENu2i/G3SIB7zf5oEpPUK7pSwrbTSj25OC+N7uAByvcwpddqyfQx6fy3dMejarNpfjZVKwIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XXhhgDOY; arc=fail smtp.client-ip=40.107.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxoZE/j7+PpN2m00+v71Buv67jC8cVfyWy+ADTj/Oc4eQi6ED9lfgFddmVBozc8DBqHUnl0yXKJwJuVwC/9DpX2yhlL0OgYGJ/C+i/ns41DGME775ndH8qg9mgvpBv7aDhNK7OUF2bCH4GjlLuZr1fUjniJcHVKQpNAHWaY7NhQmqTu+wugjybfXEwi2BDIbBFeFwFEVz+tBR1HDXdbEk/2SP8yFQZ9iMnSj/ll3Dy7JcfEDf7gLagnyKtQLBHT5tlPRfO2ffgNh2S5Lg+F7ntPqsefe4WTe9MkGgSzfoRJ0kD1RlgczrziVdl1/frwp47WoD2wrToiYTS2kA0gstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4sjNMn/mlbn92i81LlovqYh0m7A7/JbeedEzYiwNWM=;
 b=I281N12d+Czr2so1sGiQ7FZ/QLpSyPqrgZwAPgvrGuzJyx71f7Cfzne1V9+U3yet7c4x66Z3ibR982DlC9QHTMHFKBgI7ovW9JZPv/213f1tcSn1xipRCkAGZJfc1l4PY8w9ZD/lhC8S/CP4jGnIaRcqXhNVSq3w5iJ5JsJCZpd9UPW9koU+wuBV9VCvATUfgl0vpiofG2/CBB310KcUyJAJ/dXdSCt0D1rZBusqKF4xHJY/TC656zrAQrcp6PiT+Vc3aGQirynwUpT8He4/ymQj6mgMr6AfTWzpOJnY+cjTNMGyFU7iVm9BquErB9cVuJyCRFgnbDnSv9ipG6asYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4sjNMn/mlbn92i81LlovqYh0m7A7/JbeedEzYiwNWM=;
 b=XXhhgDOYwB/N/48Vl24ozbr5QC7SMlc/IuewW2yzUe7HjAWbYcrOQPItyiP6TEzEa+38fBXv1VkJlZ5jnb8HUXlOQTxYe44jK2gsbz7Kd64nQRmVPxQt9JACMMNw3WltcL7W0hn9Ool0gBWcRqTrOoL6aHBObUfeknqCpZWpM72wiN/IfaOhorIveOYzIMSkhmvs0dAyxmUGU9GfLIekUwOhLilxTH5IqQpmmFzeyH6oy//G5y2rYSi2v1lqig5oSCLzvDTf1Cg+spysX1UKlGDGFSPKVuVm0hZqfXA6HC0l2CiNfmuV9Rsv2/1NpJd3T0F5bfeWTVnPPHxjYULIwQ==
Received: from MN2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:208:120::27)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 06:56:50 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::f1) by MN2PR10CA0014.outlook.office365.com
 (2603:10b6:208:120::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 06:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:56:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:36 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:30 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 01/12] ipv4: Unmask upper DSCP bits in RTM_GETROUTE output route lookup
Date: Thu, 29 Aug 2024 09:54:48 +0300
Message-ID: <20240829065459.2273106-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: a43131cc-05ba-4d1b-adb8-08dcc7f7c1df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3fi8b5+lNoSWiWVtHlEkEew3OC1fQ4YytTR/8TqQm2cQwS69kPZ1MSKbNImu?=
 =?us-ascii?Q?WxnTs9Nny31DLp2yQ+RaQR+xp3kTg7cf576ea4Yy5cRPYSBXTJD9RkrNPASY?=
 =?us-ascii?Q?s6Djq/H2EN75NLDwo3baloBZXzTDxY9PpmbNIywzfch0aiPL5MH7o1el5wK2?=
 =?us-ascii?Q?IczDXXe5zIDLGty5c/QGQ5j6YFzLc4MpxRlCnmPLWvBYE+KKJxcbx49tMUMK?=
 =?us-ascii?Q?DL2jJZHiUlGHCRhfUfDvSboIbtCbgUBxoa2oN1AQ0vTkbDkhHQ96sQC5m1lO?=
 =?us-ascii?Q?DCAzs9RfqekzyvuhQhg9eJ11YepTGYUvrGHR7k9e/lMbl+yBpqJKuhJm2TF/?=
 =?us-ascii?Q?Z/VGe8/iJRPxVS5FIwqvcG2SLK6Aw/kzuzta0k2/Q6vfVOCgYHrdKUA/FWj8?=
 =?us-ascii?Q?rgYqQSJ/8YVlWmcwYhVWAhZASH8FOnLNdVzlP+dTRmJRR6hLCF9fdBH8RD12?=
 =?us-ascii?Q?mU98+dNHcUQw6p602IIi8OdkIJaFMfCah8vEBzcsW1Cxnv93cB/K/rHNB5qr?=
 =?us-ascii?Q?JZRSetizVU2aY/6UyfC1KlVH/2yo/dclJl9Lmba/4EodrP4ma8ECBfWoJvOl?=
 =?us-ascii?Q?s2gJrHv+A6UU/XCH4NCdNLYTb8GpdH4nrCun48/KJIKvrdc717KXfn9OegCf?=
 =?us-ascii?Q?CVT9v/gKSwpNIudIfRQN0y84zuq7S7qs1Injy2o0yBk2y1nctyFOtn+JbLvD?=
 =?us-ascii?Q?6Pgo/hfXgfhVt/joXRdw1FTJgyBku8XzofgSZwHVcSMdblzY1D6QbAzcnb66?=
 =?us-ascii?Q?ARLrUseOwivpLiKHIsuUcRPdltx5z3QG9chJ5+/S3I97k3BP/YKZviRt+/IC?=
 =?us-ascii?Q?l04kaxDARe57ZDIZ4MGaPJJFCeZM/ChHazzG7daunYevYKgKUHjGJYy4QSeW?=
 =?us-ascii?Q?phVf2OpwRGNRHQ25GpRawB/mVs5QmTT9LXyEK0MP/SPFJ2fCa7mK3dp+x6qO?=
 =?us-ascii?Q?ff8+GtgsEPdj88iA0bQTeWS5q5N+OGuAVJ2SBc2NMSWywrmi4gNueXbt82q8?=
 =?us-ascii?Q?Lcnv6sjdgNgrG36YaGJmkzujdwO0DVb/KH3/jWAmfcVp8XqS2TIcYoL1lGvb?=
 =?us-ascii?Q?WZROXosAxQYyXr1amcNh2Nq43ohhcSLYxhyUpOZrjWzZU1bLfguOsii8l5Pq?=
 =?us-ascii?Q?IeqijrnQ2fUzzaQdbAdL0WIE4cnq/dMwi5KsJWMdkV5PlPvOGoxPw32aeuB/?=
 =?us-ascii?Q?93JqneieumZ4COEYeu1mg40Y6vy0/kE5o7D3ep83ihAtXCfYY1yovWT4YrGg?=
 =?us-ascii?Q?9pLckfMp5v3saeNPTAAaz79tw7OxUs9A81DCHm6RxJ1lJ55ieC69g9fh5QAG?=
 =?us-ascii?Q?lt0zimtkvPT64/bybcou+x5Nu+/JWb7hMu3iO7XTstLIBZi1AwtpnlGeCa9K?=
 =?us-ascii?Q?lpog8p5YUOUqmHBPst6bcklPZwMaj5WXnJulsi/x5V+asx+8HLxxzTBl73mI?=
 =?us-ascii?Q?DFThPB/yf1KVLCVGqzo9ULSioRR8K9U2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:56:50.1404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43131cc-05ba-4d1b-adb8-08dcc7f7c1df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722

Unmask the upper DSCP bits when looking up an output route via the
RTM_GETROUTE netlink message so that in the future the lookup could be
performed according to the full DSCP value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
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


