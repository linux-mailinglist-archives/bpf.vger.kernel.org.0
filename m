Return-Path: <bpf+bounces-53184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4E3A4E31A
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 029077A1764
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A495284B35;
	Tue,  4 Mar 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Pawegcrn"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387B27F4CB;
	Tue,  4 Mar 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101378; cv=fail; b=fnkWvuszhCmM4ygsdv0X6N29BkJjpvk3OVRuZ9nEWPmJgmYgoPKFNCwXnXmgz8mkz8GhQCH+FXZQ4zN/bAWCLVrmlqc1Z1uV7Y1A1wDsqJXOmeJ5MqCVObGj3ZmijP15LZs6XCbDz2sCXL2yJ7hyUFE3aCGINsB0vKVy4qo1VqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101378; c=relaxed/simple;
	bh=caj/4dZuzxPyIKMdpBQhANNHF4/Fmzuo5IWAFNxKlEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jF50I+30iH2ZDK/WpNNDh3Adm9gi83gw6Tjg4IMG0CkSYrUgxd//5xp+MT2DNJvMrM3wWiG7y6xkObpcwcZ/szg74EMYN64cMO2JZcI+faxWoSE6N9/V7xNxyQlcPAtxRJQaP8tmhgxQwgtBrHTAKNh/6FqEw1Jvj7Bb9xc/FUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Pawegcrn; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erqyWukkmsFfmujbOimpjL00SYQnJBhpzc5vhM6OvVBoDAYsNEQoyYTejLnve19d0qn/MheHrIWmMbvB+48ycRCSP6uE+zqNVXkztsdyDDwdK/1TFSW7E3ZqZw4iktNFwalAP95gCYb86PzoGD0JfAx02krtDx0UmxMVgdLbnifSAFqCFrMHRIeIaw/ofRBlfJnLJCcA/sbXfSumpnwbAsXaxR+3XDqPnIY/eZUz5qoFQ7IY3LYHPamckBKs0E84AH8oBq1ruMFe3I07m5YVSv1UvgrRmmbRMsgmS9YtwpgxHg3eMVHAaTsA4+C1QCiyt6eOWIOllbPCaZiU88cROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj6vrfMbkSm7IE+wBlr7CsgyhJJxRVGy//VrJ27K02k=;
 b=LzAmWF1bg/TcKB+zohbVxl2WUBZwmz8V5NiFVL8lhtuC+dOPBFs3bg5VgjJlQ1ChWRPXtDTFJICMlU+OJCuRmCoSWUiMsiVrcWx6C6Zj5DrhIZI24Ai5CozH/PricIt9S/+LxHnkPghUBZOUX0OGQNlmj+wvMul8wRBp5jHkLVyv1GCvH32cC+y4hhFqVMwDcu9AMi4JkmeHXkrHsp0ySm1UNEhSng1dw085nvbGa1w0jiqosHWyusUvRrwmhh9T7BCjakPwa3iLbYANtt2oO+W/dW71xIBrPp3kjtxYriBlNMYxjskNR9WRiOH0XYRYSGSM4RNkrEDzjRVKNOQKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uj6vrfMbkSm7IE+wBlr7CsgyhJJxRVGy//VrJ27K02k=;
 b=Pawegcrn1PQK+JZ/o66QbfaXhjknkTUGx/VdAGFN+fZRQQbaWBj9A/ut/0phT5aFmoMCHqfTVc0ZzE0ieT2/lZFy4XvPx6rSe6EYaOdd8lgGdY6f7PgQZhNh4QaoojMTLvht2xsuhTMmHK33+jErNtqPD7srVmrDxlt2UcNcc2GdBDoplmKg3NkeFzlUB2r9kG6PNCu0ESNBy+YkFpoEcwwF7u2EzudvSOk4cP1C8RFAwJUkjZlL4iihIZqbMfyzfqMZmKWBcpTAuBVY7k5rPVn361Yd4bMMAJulohGPb+muB4yzQJSG2nw6EouCfRDnxUiTfd9cLZ5scv9jit4iCA==
Received: from DU2P251CA0005.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::34)
 by PA4PR07MB8576.eurprd07.prod.outlook.com (2603:10a6:102:26e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 15:16:13 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::d) by DU2P251CA0005.outlook.office365.com
 (2603:10a6:10:230::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Tue,
 4 Mar 2025 15:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via
 Frontend Transport; Tue, 4 Mar 2025 15:16:12 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 3D58424F98;
	Tue,  4 Mar 2025 17:16:11 +0200 (EET)
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
Subject: [PATCH v7 net-next 01/12] tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
Date: Tue,  4 Mar 2025 16:15:59 +0100
Message-Id: <20250304151607.77950-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DE:EE_|PA4PR07MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 8356b366-99ba-4e6e-6d27-08dd5b2f8050
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Nk9uaEhKT21BUHVFT0FmY2VQK0xyZzdMUnlGSUlRWXFqN000a1dLZUs4Z1Jl?=
 =?utf-8?B?ZUs4UEl1NjF5V1dNQXg5YnJTV2l6VGlHOHpybUpCRklKck5LVmlPaTRHc2tp?=
 =?utf-8?B?NG5DV1ZzOHZUcXJINnVSMm41RU5iNC8zWnltNDZJUytaejFWTlMzMjBhdUUy?=
 =?utf-8?B?bFgvQzZZd041dEIrVE9hK2cyVmg1Q2xWWFZyelNlSENGaXVXd0w5L3A0dTVT?=
 =?utf-8?B?ODM2N1Y3TVA5SUx5RkRobTJLVzByR1FyTE53aUVQZEJWVkkwSHI1ejNZc1ZN?=
 =?utf-8?B?K00yVllJaVJYNEhTKzg2YzNRTVRmcmdhRkg3dGdWVmZ4VGNnTzZnOC9yblFB?=
 =?utf-8?B?QjU1WXBYcVcyNHN4YVM3TmdrNzQ0cWU1V2tQaHV3YzRwTTBMMldXWVAyYTdQ?=
 =?utf-8?B?SmJYQXRVSEZTYU5zVUJVMklCS0tiS0NhQUhSV3loK3REYkl4NWEwU2JuQ0xS?=
 =?utf-8?B?QUprL256MWU4UzNEb2tDTnQ4SUVOaGkvMzFSNUdjb2NmdTRBbEVsY3BNUkZ4?=
 =?utf-8?B?b2JxYmFybXR6cVJ5cVhWREJRTWM4R3VwNkRLNVU2b3dXaHh1VHZ2UFFzV2hq?=
 =?utf-8?B?UVUrbFZZQVlZaGtMZXJjdFM3ZGhERHQyTkN3SUppQjZpeUhqdnVrTTZJdXdK?=
 =?utf-8?B?SmxiVXlJNDNvd0VRY2VnaTBRZm1ZeFJZVzUwS0lmS1VyaER1K0dyQVAra0p3?=
 =?utf-8?B?aExGREVlUTIzSk41RXVkVE13YUFvbTVSQzJnVHQxOUpjdDdMZFRycFRNOGxx?=
 =?utf-8?B?TXFGd2hXVGtab0E1QXUvZGY5a3Y4eWJvZ1Vsc0VTaTlobTZoSVpUbFp1K25l?=
 =?utf-8?B?QWRYbHlsRHVaZng5MEduWlRjRnVIaDlXNXArTU9DWDdlNDRUR0RLVXRuazZL?=
 =?utf-8?B?QXYxMS9yNHNqZk1OYnUxT2hucStzTllWNDMvNndaYnI5d3R4c3FKU3dORzNH?=
 =?utf-8?B?RXZHQ04ySFpXcmZueUpJVUhKYnhkWXVIVjNlZDBwU2xQRVJBcGJoc2s4eHR2?=
 =?utf-8?B?dlgzb0EyZXM2dE12RnpDR3NWVDBEWWphd3lGOFJBSDRTRGpQS3FTZGsvMFl6?=
 =?utf-8?B?aTFmNWtmWUxuejBLdjRDZ1FnZnBkaWJXNGp1Sk01MzZqMVpCN0I0TlhDdTdF?=
 =?utf-8?B?RHdmZndCSllSNDN1RkVkV2R3ZlhWYUpKdy9uTUYrZ0RYcS9yZ0FQczJIU2F0?=
 =?utf-8?B?U1YzcXZjaHN1L2VFLzZ6RzdabWUxdjJBRjdRNEd4QVZ0YVlNU1VoTitxYmNl?=
 =?utf-8?B?OFQvRW9sOCtyU0gzeWtEakZZZFpBZmlJZmlINTJRSW5BNVhVM3pYZzhKeHZY?=
 =?utf-8?B?MTRodFhKRlVtVGhPQXFpLzJWRVBCVlhncXdCOVJaYTk5NGlBRDV4b2paUm9l?=
 =?utf-8?B?MDRMT0RiMk5VeE4ybm1pU0ZMZVltZG1SeTFZKzM0WmxRQkZ3c2NtQ2NoV2Rq?=
 =?utf-8?B?MmJtbEMreCtUN1RBakNvUFhBam81Y3phRkZqaUo2UXBtOTVjbGVacW5WM1gz?=
 =?utf-8?B?ZVMrNDgyUlBkNTRCdU8velFmbytlUE9Rc1RNVGo2QVJRbExhNVpMcTVubFBR?=
 =?utf-8?B?Z25aQWVKYnZPd2ZpSy9Va0tndVVVaFVoeUFucmhhSFoxVVlzNmIxTldPV0VJ?=
 =?utf-8?B?VldBZFlqY3R3ZjNub1hHOFF1M1phdkZCODRVRjJWTVhEK25CU0ExTjMxaVhT?=
 =?utf-8?B?czVxWllaRDFRNEFCeWxpbTZkMldWSkhqanpRM1dCc2pwL015SWR6Y0JPWVdE?=
 =?utf-8?B?RXNISVpHcWZpdDVLL2xCazkxRGM5OE5JazFHR05oUnNqUWxFU1ZTbzZZV3hK?=
 =?utf-8?B?VFhiOFIxc3hnbk9nTC93ZnZKTDFqU1VZUzQvMno3YXlJamlNK1BmWUpadjJq?=
 =?utf-8?B?d05ydnZuWkN1MC9NT2tjNVJkdUxJaWoyd3FkOHpnTXFUbXFtK256cWJYNXA5?=
 =?utf-8?B?NU1jUk1vb1FVUk5CK25LSUllTnl1U1p0bi9XM0Vwa2R6QVBwdVR3YTlucVRG?=
 =?utf-8?B?a01ta0UxeWF3NTMwVlAyUUhuOXVQR2JGcDBMd05NNjIrUjY2ajN6YklHN1BT?=
 =?utf-8?Q?lluryC?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:16:12.9573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8356b366-99ba-4e6e-6d27-08dd5b2f8050
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8576

From: Ilpo Järvinen <ij@kernel.org>

- Move tcp_count_delivered() earlier and split tcp_count_delivered_ce()
  out of it
- Move tcp_in_ack_event() later
- While at it, remove the inline from tcp_in_ack_event() and let
  the compiler to decide

Accurate ECN's heuristics does not know if there is going
to be ACE field based CE counter increase or not until after
rtx queue has been processed. Only then the number of ACKed
bytes/pkts is available. As CE or not affects presence of
FLAG_ECE, that information for tcp_in_ack_event is not yet
available in the old location of the call to tcp_in_ack_event().

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 56 +++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4e2212348088..6a8eca916580 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -421,6 +421,20 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr
 	return false;
 }
 
+static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
+{
+	tp->delivered_ce += ecn_count;
+}
+
+/* Updates the delivered and delivered_ce counts */
+static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
+				bool ece_ack)
+{
+	tp->delivered += delivered;
+	if (ece_ack)
+		tcp_count_delivered_ce(tp, delivered);
+}
+
 /* Buffer size and advertised window tuning.
  *
  * 1. Tuning sk->sk_sndbuf, when connection enters established state.
@@ -1156,15 +1170,6 @@ void tcp_mark_skb_lost(struct sock *sk, struct sk_buff *skb)
 	}
 }
 
-/* Updates the delivered and delivered_ce counts */
-static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
-				bool ece_ack)
-{
-	tp->delivered += delivered;
-	if (ece_ack)
-		tp->delivered_ce += delivered;
-}
-
 /* This procedure tags the retransmission queue when SACKs arrive.
  *
  * We have three tag bits: SACKED(S), RETRANS(R) and LOST(L).
@@ -3864,12 +3869,23 @@ static void tcp_process_tlp_ack(struct sock *sk, u32 ack, int flag)
 	}
 }
 
-static inline void tcp_in_ack_event(struct sock *sk, u32 flags)
+static void tcp_in_ack_event(struct sock *sk, int flag)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
-	if (icsk->icsk_ca_ops->in_ack_event)
-		icsk->icsk_ca_ops->in_ack_event(sk, flags);
+	if (icsk->icsk_ca_ops->in_ack_event) {
+		u32 ack_ev_flags = 0;
+
+		if (flag & FLAG_WIN_UPDATE)
+			ack_ev_flags |= CA_ACK_WIN_UPDATE;
+		if (flag & FLAG_SLOWPATH) {
+			ack_ev_flags |= CA_ACK_SLOWPATH;
+			if (flag & FLAG_ECE)
+				ack_ev_flags |= CA_ACK_ECE;
+		}
+
+		icsk->icsk_ca_ops->in_ack_event(sk, ack_ev_flags);
+	}
 }
 
 /* Congestion control has updated the cwnd already. So if we're in
@@ -3986,12 +4002,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		tcp_snd_una_update(tp, ack);
 		flag |= FLAG_WIN_UPDATE;
 
-		tcp_in_ack_event(sk, CA_ACK_WIN_UPDATE);
-
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);
 	} else {
-		u32 ack_ev_flags = CA_ACK_SLOWPATH;
-
 		if (ack_seq != TCP_SKB_CB(skb)->end_seq)
 			flag |= FLAG_DATA;
 		else
@@ -4003,19 +4015,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 			flag |= tcp_sacktag_write_queue(sk, skb, prior_snd_una,
 							&sack_state);
 
-		if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb))) {
+		if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb)))
 			flag |= FLAG_ECE;
-			ack_ev_flags |= CA_ACK_ECE;
-		}
 
 		if (sack_state.sack_delivered)
 			tcp_count_delivered(tp, sack_state.sack_delivered,
 					    flag & FLAG_ECE);
-
-		if (flag & FLAG_WIN_UPDATE)
-			ack_ev_flags |= CA_ACK_WIN_UPDATE;
-
-		tcp_in_ack_event(sk, ack_ev_flags);
 	}
 
 	/* This is a deviation from RFC3168 since it states that:
@@ -4042,6 +4047,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	tcp_in_ack_event(sk, flag);
+
 	if (tp->tlp_high_seq)
 		tcp_process_tlp_ack(sk, ack, flag);
 
@@ -4073,6 +4080,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 no_queue:
+	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
-- 
2.34.1


