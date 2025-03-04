Return-Path: <bpf+bounces-53188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59FCA4E328
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F2F7A66DC
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A39E283698;
	Tue,  4 Mar 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="FrT6nwRJ"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1462857E4;
	Tue,  4 Mar 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101383; cv=fail; b=sSuAQ7ZPyBBAEgLxe2kY3rMAMiSEDoXolJhaAxbglkCJxCvoHfJ8DHmCqyY9y51Tth7bMoQxCp6UY+HeTAC/1hENLmyK6QUOmL2JcnjnFGIfumRznzHHi2Wl7mup+bqfKHB2xnETBoRh0xvs1PX0jIexBkn0Hf8IPN9P69HlGiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101383; c=relaxed/simple;
	bh=HxJALqWnEF8Whxp0ZdFTJB3/DnjfC9ktgSbH3RujgEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0G35WzVMiVoBekRzPEyAk520oEeWntOeAlqj2zlTtDwM/brNhCmnOKqneKa2qJ7QGBXYC3jE7MHVsATwqTM07nWo5wbOuj4HN3Ze0HL21bveUZ5e/QzdxoBaoWzI3gMycVVdF22keeXXVa0bwUCUkSpePYT3DEz/TyQOFcCIUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=FrT6nwRJ; arc=fail smtp.client-ip=40.107.247.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMoovX3N3ZhpBMsfB9Cmf5gCXB2k7W5cG2k/L64sP4UF0y2ow2QFbvBuxWHgrkXfvSHLrCmeEbmE1NcqwNf8xlOX0QqIFyfcWQol3RLhm/fZ6weKdkPfHTuGR2u1hwm8X3aXsrr7cwZojWUqTw0Q4f6DN8Xl9uvB2iw4YIqVJVg+ezPB9rMSU7nQjIvnDYPR4LjeV0UkxTjObfhtWSmpKjD2kFj2QQc++qCUyKKYKnFm5t6vNeby+am7jWyBh5ZBVtwP7NYy1CnmlCYsJd6nvH1ZTlc3N5AWkoCMusNt1+g+U5NZEfmbHjAjq22OVaSQE9sU7gUjUvxaF0pbvZ7wDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTSh1SaQdAu7He1aPYFxG7DTSFXD9HAX4cddFz0FSPk=;
 b=ha5JHdBjV1StbX5qBq3isJSlzHVJSFp5KbWWUENSRm8pIZPfswfAm4Ex0LsBh0qYoD0SS3zSpBAEL3lKTmDLeHzIzIzsSMbG/0EfkAoHX8dBxERJ/7iRPvCAbbGRyw7y8B+31qcsoIJZT08B4XA3ckXCgSrqAnPe5zsLePQFMacc8QlOj4VlrbNUl2PElhnL863e9uXCaXzeFdmAEYPyccgBgN3YcKDrRdmmD9syVlqhv67EkbvlO/yVgmYH6n/hy4jtEGi2AfEmS7BQh2Z8fP1bIeSduGXIOagmtv8XiW/hWMjl8Q1zcrHkDd5/9NxJFhJoqC7hxseVhHDpSbIdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTSh1SaQdAu7He1aPYFxG7DTSFXD9HAX4cddFz0FSPk=;
 b=FrT6nwRJ4U38OP/IEMmd5AJhcuSTWX1BpBpRBLZwsmK5DjkzzU/crtrJzqH/p9St9Qxo+tpyOtgssRdLkgEf6vVEE2khj86XDFplgFL25+nraniRVZ61xbTlijWxsBlfHsnU/+V5ssYkBPMMVZOMNlPepmYdKtj0D1YYE1kxYZK2jMziEY//udSb4RcVTXYyPHvMtM7rJJd2MVqBjKAD/7V7WdhckMHp9OxY2RCABnwSp63BOjSZiSPichVNfX2J3rQck2VW+d9WJOhxWLdTCyH6Dpt//MYORIOTzsL+WqyMACSA16vuFmzkkkYTRgbex/coMpU8MtdWV864TiyPXw==
Received: from DB9PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:10:1da::10)
 by DBAPR07MB6630.eurprd07.prod.outlook.com (2603:10a6:10:181::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 15:16:18 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::f4) by DB9PR05CA0005.outlook.office365.com
 (2603:10a6:10:1da::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Tue,
 4 Mar 2025 15:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via
 Frontend Transport; Tue, 4 Mar 2025 15:16:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8B70124D60;
	Tue,  4 Mar 2025 17:16:16 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
	dsahern@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	dsahern@kernel.org,
	pabeni@redhat.com,
	joel.granados@kernel.org,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	kory.maincent@bootlin.com,
	bpf@vger.kernel.org,
	kuniyu@amazon.com,
	andrew@lunn.ch,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@CableLabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v7 net-next 05/12] tcp: reorganize SYN ECN code
Date: Tue,  4 Mar 2025 16:16:03 +0100
Message-Id: <20250304151607.77950-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304151607.77950-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250304151607.77950-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|DBAPR07MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e7922e-ae97-472f-abba-08dd5b2f837c
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L3ZXUExwTjZNL29jQ1ZKNEhIVFgwSlZHeWJ0TlJ2SnhHODR2RUdNNzlVaFBE?=
 =?utf-8?B?THZyWjJLWmhTenBtN0phWkRiV0FLdDFsZVBXZld6Z3RMd1lBbFZROElKTHg1?=
 =?utf-8?B?UzNKUktUcnBLSVkyc2YxQWovUC9kaVEzWW5sdWw4RW5aOEI1bXpVdmt3MDN2?=
 =?utf-8?B?SXVwMWJ5aWJCZUU3eDJKSVRkbkNuelBoR01DV08rK2RaeWxsZmNRSFcxODdr?=
 =?utf-8?B?ZFdXM21UY3pOQUp0dGNkVmZGYWhzQ3pnWjRKZnNsMDd5VVFCNEI3cUh4amdn?=
 =?utf-8?B?RGo2MmF1aWdIc2o5dUNuSWxVVmI0TmdWaFk2bjRTSFg5MnRhMW45L0lDQjZs?=
 =?utf-8?B?MkdnUjBMM2g5a2g0WUc0THF3YUt3cWVsSGN6N1FHc1BBN3hZQjNQRkFUOVYz?=
 =?utf-8?B?a0VjTmFvSmlxbXdnNlFkVUtMYmNvVVJYWExQb0ozYjNVV00yeEkxWW13L212?=
 =?utf-8?B?UHFYMldZc1l0VS9BbGN0M0FYa0tUemF6ZThuQzNPVy9oa1dwUVRoY0tSZ0VD?=
 =?utf-8?B?OGRucEpjT2E4RUJzd1VBTS9HMVRIamtkQUcwemkyaW1SWEw3T1NpdTZpSUFK?=
 =?utf-8?B?ZXhDeVZwRzJ4OUJHWlRvRnlxWWpDUkREMmQvOStFbGRyc09DRVBGbWQwNElY?=
 =?utf-8?B?NHB3dlA2dUdYcmNSYnljWC84LzNDMXFXS3RZTStSR3UxS1hFSmx5UG5ta0RV?=
 =?utf-8?B?T1hBd0pUb1J4WUNYU3pteFE3eUszWDNPQ2VLSTFEV0VTcVNtSldPZ0VLKzRD?=
 =?utf-8?B?azhYbXVjdWhZdGNrY2pHcnlsTU52Z3ZJeXd1NDJxVWcyNjFiYUFyRkhqazA4?=
 =?utf-8?B?Y2VEZ3N5WUZXYnFTRVRQZENiei9YUG5wdmJSQlUzczFjUVlySGZKczlKOE9V?=
 =?utf-8?B?YVRXVUN2RXNqV1E5K3RhTmZ3RHZocGhxRE4wQy9uYXc1YTF5OUN2SjBzRFhZ?=
 =?utf-8?B?RUpJYWVEZkpZZGtNUk1EdWliaElOazBvZVFWVk5WZE1ac0hCY2owclBxRmNG?=
 =?utf-8?B?ZEszWWlnZk5HT3FsaGcrNWFEbXJIVnd5d0o5UzJZUUtzR3duMnN0dTI0TDFI?=
 =?utf-8?B?Y3R0UWRZNzFMUlFNT2Fib2g3QVIwNXlKaEExUnRQam1abGcrL09ldDgyZEdJ?=
 =?utf-8?B?cVRmdVhJUHhiU1RYcU5zc0c3aGxab3lLWHJmMDVLWWljTWk4cFF0UTU5Q2F3?=
 =?utf-8?B?bzJSdUxqWEIwRTVJQVBDeUt5b1lWM1p4UVRMWkFvL1J1T001MmwzbWg1Q1Mr?=
 =?utf-8?B?U0ZvTnNVVEYyZkFzMm5zd1N4R1pOV0ljWndaRVQzMW1UaVBaeTg2MTNDMEt3?=
 =?utf-8?B?elJUVXYzTGpWOE5tVm9YMFNKbDlTVzdTU1Ewc3hWdDl6MTgrNnpHMG82ekd1?=
 =?utf-8?B?c2pUUklBYUJtVUl3K0RLQmpaUjMwTlRSancrbjYxZ2F0QkFrUW1Wc1doZ1hm?=
 =?utf-8?B?eGtmSTdYMmxDdTB6NGU1RzJHTDVkVkNOTXhoQ1g4b1ZZb3g4cStGdEFuM1pJ?=
 =?utf-8?B?Qld3cnJEbGFIWkl0bUtmNG91TUZwTEh3WGNteFplRlNmOFJHR2E4aWcyMnZL?=
 =?utf-8?B?WU5qZVg5aWtVMkRRc1FCL0JUd3BGVXhSendKd0dtNkxxUFRmdTRmdEpjdmsz?=
 =?utf-8?B?MXJPMlpleExIQlh4dUdaRnpBejNCOG9SWHd0V2QrZlVaVVM1WHZVRTBLNzJB?=
 =?utf-8?B?QWI4RE10VFFEcndKRTA4Mi9mazBLMU9rTEtSOWRBR29MaGNQV1Yvc09JY1pM?=
 =?utf-8?B?bmYxUkh5cEN1ajdIK1lUQmk5VWpTRUNxb0VqRHhqMThyTU9qeFJLSm1zTTlP?=
 =?utf-8?B?S3V5YXFUdXJqTHlPa01OVDFnSDVKcWp5YnVBUXpqVkZsdmdnMmdvcTBBTDNK?=
 =?utf-8?B?SXY4VGU0NFowZkd4a2NYU29BVFptajVrY1lvdlg5bE44ZHpoOXlURWpvZGRU?=
 =?utf-8?B?a2J0QmFmcGJDZkt6SE5Kc0NuQk1HdWZabWNNZnA2Rk9NYUs4L3gyUGd6SzBv?=
 =?utf-8?B?UzV3UjdHRWtvTnAvbkFJYXBLU1FwdmhmOG9xdUVHZ0VZS0FNZG1UekNMN2lH?=
 =?utf-8?Q?efVxyg?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:16:18.2804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e7922e-ae97-472f-abba-08dd5b2f837c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6630

From: Ilpo Järvinen <ij@kernel.org>

Prepare for AccECN that needs to have access here on IP ECN
field value which is only available after INET_ECN_xmit().

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index efd3cb5e1ded..98f2684e0006 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -350,10 +350,11 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	tp->ecn_flags = 0;
 
 	if (use_ecn) {
-		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tp->ecn_flags = TCP_ECN_OK;
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
 			INET_ECN_xmit(sk);
+
+		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
+		tp->ecn_flags = TCP_ECN_OK;
 	}
 }
 
-- 
2.34.1


