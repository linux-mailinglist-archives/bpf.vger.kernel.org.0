Return-Path: <bpf+bounces-53418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15624A50EC3
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F58E170544
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9887267AE6;
	Wed,  5 Mar 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="O85VUQ3s"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391B266F1D;
	Wed,  5 Mar 2025 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214349; cv=fail; b=Lfrp28x4TJUJCWx06Ct/f3DAtCgXA285iyEP6y4bB6ed+EBTb1DZikE8PIdDJnVTAJc4QnNhJ27Glqn3V34vaPtSYkCyGXYA7br7VxeQJer7eiVDqY3DwEueO+yN7jfGVppnhL2VbuhuHWsPrE2ZHMPyt0Cx4ZLwBaVMU+O8oiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214349; c=relaxed/simple;
	bh=Ulhva8XrbgA5oAhnhsw2Uqah86jbo5pF+6CBWOuyN3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vc7/yqJrmB01jZlK6WfJ2t3pAP5aQG/ZM4MvyP5NATKWJAi/B9uAIQTWKr/MY1muMCiXr6+mmOEMvSvJWsucYaaySt/52mAVWtemY0mQhHx8uvEeo9g0KC2IymLeemV2DdIMeCnUnFfCnU/1b07dltF4EFAGi62HS6un3Nt7dG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=O85VUQ3s; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZrv34DW4VX2W+QPskO+g1Vo4BojdlKCs6jQVLscBYcrgIT652OJolpKGSjFiZErwMFBXD09ukZUk54kxrX4Qq7hsDC0WO5tIDew91PIu+GDMTKehejPYvorgNmnh5RF4QOHnrzG4XIu8ShMDQNxkwHQYQbDI0t4+p6UpxMzV9/yxdBHrRM24bSfD6Cpu9y8vXMhg463hPYGAiC4sknkvbQ1fHL/4dbcTDuTbQm8/XNP9BjF2O13onbBWCTE990LKnrVrGQHJZB0jtmyYuXU0ahf/A8ED8lYbCId8B7Cga6PeAjRXF6UVdlRa0fJ5YsbHuuzNqssBBuL1Zo3Ci0d3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1hOb9LCv/YaASiqgdTDb3G4/8C1/qDxqxoEGYEqugA=;
 b=BRQ5ESX4CUGHAxCktIYIcehj4b6VqAdsvcXUwojBSBkWiFbJDKCQDLXyrAv6LGNFFndp4o9+KIoQczY9TewPnxCmpGyO7QE2meGTsbGlD/ZO1oMPbQ6kYR1iyBBbOq0l3sQFvf2YOoHnMuhBRaJXoAFenqDL/fOzc9ur0rLHQUP/Eo4zfHYNqx/MrN95R2EcESLNf2mMTdsylY+QNH/nLdvSzj1Cw7C7WzmX2NnqDvGL6oGrUKlN66+InkNUQ7Fa92vuJ/sTj1Kb9aUisOlXYG2FaR3WGTQfJbIVNvdsJg0vk+PieZ2E+05SFwpVfzyD6J53NXT5iIlwM1KwaEsiCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1hOb9LCv/YaASiqgdTDb3G4/8C1/qDxqxoEGYEqugA=;
 b=O85VUQ3sgMOvc3wHVX8JshCco8Yen/Ivp79IJm28Xnf4QHVfPB/blGXSrKx73lROFrFd2R2A1uku0h/0FhWVsMECSh/Y61R0126nIZ+y0fdUnz5BDQrMIUFu97JPHSCGMW7rPbQE9jlG4dKA4n5Sva9579SCjEzMogREPs6BXWSNOZJImxt6sP5vw2iGFHpjcqYr0MnRijHG+47lWieaEMeCL7zCwiWv7B69Q473kv899RtX0iv2WJwErttIFDjsV2Bwydta20e/zusS0jXAPS5E1KuqVaXDkklHECemwkP3odJw3jfvlbgv2PeTBL5NcJ1fCqxAHHzmYXRsO6r2JQ==
Received: from PR0P264CA0069.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::33)
 by PA4PR07MB7136.eurprd07.prod.outlook.com (2603:10a6:102:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 22:39:03 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:100:1d:cafe::4c) by PR0P264CA0069.outlook.office365.com
 (2603:10a6:100:1d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 22:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.11
 via Frontend Transport; Wed, 5 Mar 2025 22:39:03 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id C5D04206F9;
	Thu,  6 Mar 2025 00:39:01 +0200 (EET)
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
Subject: [PATCH v7 net-next 06/12] tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
Date: Wed,  5 Mar 2025 23:38:46 +0100
Message-Id: <20250305223852.85839-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305223852.85839-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250305223852.85839-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|PA4PR07MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0f86a9-e739-4b21-e697-08dd5c3687f2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UUhpbkw0bjc2N2tGb2Jid2Z6NUxzSng1Q0pxU2s5U0hJNVhmQ0RYTWEyajNa?=
 =?utf-8?B?YkFoTlphVXFra2UwVHZsSTlxYXhjc2I1RGFZR00zSWRZejlHUzVGNHU5SW8w?=
 =?utf-8?B?WWk1NHBiUE5rSXM3QnNGYTFlRnYyZ1FUN3VXWVlhbWUzQlh2LzBORy9MRUFF?=
 =?utf-8?B?bm9ZbkNRVGxoMTQ4TGZFbUhOT1UzK1A2aTlFVnZPRWxsZnFibG5iY1VkT1Vr?=
 =?utf-8?B?RXM5cG1scUhHN2VDT2J4ZGxOSDhTT0RRRjlZN0V6TTFMTXdJZk5xajUvOFM1?=
 =?utf-8?B?dU82NTBlc0RQMnJxRjcyZzVlTWdJRStVMTRBS2FYMU1TMExXTWdkZWJqSzdU?=
 =?utf-8?B?TFFCZ3Z0MFp1cWhGakNUNWxOaGN5Wk1FRUNIMnI1L2xpalh3Wkh1TXhYT1gz?=
 =?utf-8?B?RlZTejBYT3R6RXpWZ3pLSFNjeWxLbjFQWmNuTDd4TFNmY3BFU1RhYjFIS3RT?=
 =?utf-8?B?MVg2VERCV2hPMWZEOFVoZndaOUJFZk1CNDlEb1BmbFRUZzQwZGFBQW1VZVh0?=
 =?utf-8?B?VDdqRlgwSEdZVVExWUR1ZFZySUZlSFh6bno1aWlWL2tNUE10MTNFeTRSZTAw?=
 =?utf-8?B?WWp3NzBCb3luUU9XYU4xSWR1c0RDcGRSVUlQSlM2a0IzSjkvaE5KMS92MnlJ?=
 =?utf-8?B?eTlETGQzRnZjVmhIVmlDY1N0Rlp0TG93Mmh4eFBMOUdOTHRkSFRKSXRrS1Yz?=
 =?utf-8?B?NFpETWk3dW9LRGdJYW1JdEErdktnM1QyK25wSHpWTGJKN0JHT2JwbUVSb0Jw?=
 =?utf-8?B?Y3ZtVzFrZWgxbXhRKzl3V3M3UkhYKytnWVVIN2VVWlhOeDhHWVE0NE1yWTI2?=
 =?utf-8?B?cXRVNXFFR3poamtyOWRxUW1iejMrbFdsdUVPWFdQcTRxY3RyaHluVnhkeUxP?=
 =?utf-8?B?ZGNSNXRTdmdjNEdydEtNeWxYL0grVERuTzc1aEVpZEVDdlBzZlVOYUU3dC9Z?=
 =?utf-8?B?K0xTcGNSWkJaNGVER3ZCdUk2TWtmSFAxd2ZLY3B3eDNGSFZQaTBmcVlzN0tW?=
 =?utf-8?B?ZU5RZDVwRzg4VWFaM1FhOGNISHdMdFVWcW9zWTY3L2hLUUlPRU5vcGNTNEUy?=
 =?utf-8?B?YUlxdUFpQ3hwRnpXYzZQSG9JR3hJSFh3ZTFkTjdwaXlHcm5LZHF5ZDFYUWlo?=
 =?utf-8?B?UXJEZzNtN0NuckxSRm5TUmRDWDhqdERPRFpiVk5IRkgxNE5qbjE1ZEUzaW5p?=
 =?utf-8?B?ZWlKUHluSlRjNWxJZTFsOFBRSWEvUVdoalg0V1FQeWZMTTY1THJ4cTVKWHFL?=
 =?utf-8?B?eGFQVlFkYm5mSWo5RVpvNWoxcWNmUTBKWTUwOEhKRWY4Mnc5SUtkdjhZMXV3?=
 =?utf-8?B?eCtYWWhUbStJSmlNQWkvVkFWbFZ3bHFxdktQS3FHODBmWU5XVEg4Tk43OXc1?=
 =?utf-8?B?SENXMm5GZVhwbVNZaEw4TmpaQ2NqYndWY2hDcVl3MkZKYktIeWlreEVPL290?=
 =?utf-8?B?NE9DUE9mMnhxamd1YTJXTGNQMi9VSVNrcFdlNVpWRUpValBNVzRobWZ4Rm9s?=
 =?utf-8?B?OHZuWmRJcUtveU5ESWtPM29hWU5PUi9jNFdLdGdZdWFTTXRtWUhnQ1V5M1Nz?=
 =?utf-8?B?Y1pwSUhnQzU1Mm5JQkNlUDdOOU85YlVzSnRCNTR6UmowNnZhVzFZVS85c2Ix?=
 =?utf-8?B?em1pWm0vd01iSXQybjZEQmtIUmlheTA1UExmYUNLUytSOW5RWjZacWpiU0NN?=
 =?utf-8?B?d1UxSTRETFg5S3RaZVJIZnJHa3pDY3haTEpoZ0JKVkJrV2RldHRDbE5Bdmwx?=
 =?utf-8?B?SEt0d29uY3FTRmYzekFoekM0a2NWQ2VXa3hlbVFHQ1oxN3gwTTdHQVlndFl6?=
 =?utf-8?B?eWJpV0NEZkFzZWVjYzRvUmdneUVMMXF1VDJMQUhDN2VydFZqbFgvWmMxT0Qw?=
 =?utf-8?B?N1NNUnhPcU84SEJTck9VRkUrUk9wdmQrSGlwZk1pcy83N0d6N1VlWTZOU2FC?=
 =?utf-8?B?SXo0a2JPRUxtUFMweDU3a1FlMWNoa1Z3RVRCMFQzY1RHaFFmalBydy9LV1JL?=
 =?utf-8?B?bFFrS3dxbWlzR1NkZXBkcUY1YlRJblFLNm8rNVR2Qjd4d05JYmhHbjBkd1d5?=
 =?utf-8?Q?3uma03?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:39:03.4529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0f86a9-e739-4b21-e697-08dd5c3687f2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7136

From: Ilpo Järvinen <ij@kernel.org>

Rename tcp_ecn_check_ce to tcp_data_ecn_check as it is
called only for data segments, not for ACKs (with AccECN,
also ACKs may get ECN bits).

The extra "layer" in tcp_ecn_check_ce() function just
checks for ECN being enabled, that can be moved into
tcp_ecn_field_check rather than having the __ variant.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 771e075d457d..769048b559e5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -365,10 +365,13 @@ static void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)
 	tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 }
 
-static void __tcp_ecn_check_ce(struct sock *sk, const struct sk_buff *skb)
+static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
+	if (!(tcp_sk(sk)->ecn_flags & TCP_ECN_OK))
+		return;
+
 	switch (TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK) {
 	case INET_ECN_NOT_ECT:
 		/* Funny extension: if ECT is not set on a segment,
@@ -397,12 +400,6 @@ static void __tcp_ecn_check_ce(struct sock *sk, const struct sk_buff *skb)
 	}
 }
 
-static void tcp_ecn_check_ce(struct sock *sk, const struct sk_buff *skb)
-{
-	if (tcp_sk(sk)->ecn_flags & TCP_ECN_OK)
-		__tcp_ecn_check_ce(sk, skb);
-}
-
 static void tcp_ecn_rcv_synack(struct tcp_sock *tp, const struct tcphdr *th)
 {
 	if ((tp->ecn_flags & TCP_ECN_OK) && (!th->ece || th->cwr))
@@ -874,7 +871,7 @@ static void tcp_event_data_recv(struct sock *sk, struct sk_buff *skb)
 	icsk->icsk_ack.lrcvtime = now;
 	tcp_save_lrcv_flowlabel(sk, skb);
 
-	tcp_ecn_check_ce(sk, skb);
+	tcp_data_ecn_check(sk, skb);
 
 	if (skb->len >= 128)
 		tcp_grow_window(sk, skb, true);
@@ -5041,7 +5038,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	bool fragstolen;
 
 	tcp_save_lrcv_flowlabel(sk, skb);
-	tcp_ecn_check_ce(sk, skb);
+	tcp_data_ecn_check(sk, skb);
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
-- 
2.34.1


