Return-Path: <bpf+bounces-53425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72057A50ED5
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1921706CE
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43842269CED;
	Wed,  5 Mar 2025 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="PB4L4aKK"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A33266593;
	Wed,  5 Mar 2025 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214359; cv=fail; b=YByz5Nu+gYHla8iTHdTXjp4WiXcK3sS5EQFXuApibVtrlhSWeySAQzu8XHMA9ykpUKBqv//JEH0Bi9gzPXwj5FBtUdBdRhuY7pGhjH4V3E1hTy821cX1T/OySLH0/casiIDBxXLVeVL8N7h3tpPty7HuPh9XLvCaO5kqHAh0JUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214359; c=relaxed/simple;
	bh=kEMTwggpvfj6X3uqQrKG1E1SLaMV3zClTNLGP11BQNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpTCQ+hHv8iTHCq/8vrF8UxO7fbFPdO6ff0ut39jvqt8EQDw7GuOINB/awngu2x8jXPBUXPOrPAPmy6LPGm1PoRGbfGmtWR2q8QnIOnDWORr2HJ9FgD6KLTDa/MG32a+UCP/KQB+4sJyqSy6qTkn04RyoIXHYCtA9yYUlR9Ess8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=PB4L4aKK; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y58DoSKcM0BjdE4knmUv3FaOnYdHyoYo1evqne5jV6v/AEmaxgbdms0iclw/G3lbsmSsmH3Jbreh8aPBPaY/UoMIoX3iUf2a4SnDiqiLGwGDDI8khgk4lzz6J2lqEE798m/iF6Zr8xCeAhnOSY4F795w5K/nml3UCzpmjj+9feoVTFOrmaU79/fEFSceTrSA2d2h0JsIKAHQzTnGgSILastiVYaZhwNyuKkY7kT7jOGe+tTzUR26JCDBTEJCy+dCXtVqivw8PhESt/kT0SdF930/gDQyp8y1FlFF+gRLx7zsZ2twRpC4zd9PkSOKxv856i4KteCb1tH0lwI5nRHPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMB3e50qSo7+nFbyvwRwn06pAAVzB+09EnIvXQDF5uk=;
 b=u0xhJPkLJXNNbcUj8JuZY3wg7odO1UCqrT8Rb/x2hRSbGxa7I1oPHcdqAWthgfydWGSR/ujufPLULQnlWkz/EgJrl50Djiql0o4BfklcAPnDLcaAlScxvhVkSS1GYDwaiyroGkt9jlZlrpkCbBGHIEnZZaQRtG4Jux+Adb92esV3ks/o8S+lRQe8QOCLIvqJHgUxatW9YyBmZZbKYZQOBtIdieWlfWNBFlm9811B++Dj8VEwFyMzkQHxQ/PO2Z7gHm0gd+R2bKMLvjuwdGRBeVWmHQKG+uqV6z0S3xKDJwS9B3EF7A8+Ftg3ggC3AQLrSCisAHGh49D9Cz2w7hHkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMB3e50qSo7+nFbyvwRwn06pAAVzB+09EnIvXQDF5uk=;
 b=PB4L4aKKqIzSVl9JZYXXpdGZuFVNeEFnGG2V8+ErN5nUQ2e8tp9vnTKTKQJoe9MlDKzUuT61107uOReQkeZMvodLCjRIv523RxziLYHppPUSzXTcCbDJa4vWalWBC/Iq8bq9NJiuulH7velndYOgtmLtvQv9ae7UOtuOECRmugxxxwp3B9YQBpYLmRWHDB7ip2t6hWa+G+Q6EgJs2mbTilW98AjCx6mNohCyXZBFevQgDT9Nn5WRWNOPJNk5l66zCdW2303v5KtappAnU7aCsWn2rc22DiD2R2fQIHquJdcTwF+XrqZDX1mEil7AOtSdRRr6U+AMpXpPgX8PH6lrkQ==
Received: from DBBPR09CA0044.eurprd09.prod.outlook.com (2603:10a6:10:d4::32)
 by AS2PR07MB9172.eurprd07.prod.outlook.com (2603:10a6:20b:55c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 22:39:12 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:d4:cafe::14) by DBBPR09CA0044.outlook.office365.com
 (2603:10a6:10:d4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Wed,
 5 Mar 2025 22:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 22:39:11 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id B71E5251F4;
	Thu,  6 Mar 2025 00:39:09 +0200 (EET)
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
Subject: [PATCH v7 net-next 12/12] tcp: Pass flags to __tcp_send_ack
Date: Wed,  5 Mar 2025 23:38:52 +0100
Message-Id: <20250305223852.85839-13-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D01:EE_|AS2PR07MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: c41a9583-3c47-4939-2a32-08dd5c368cf0
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?R2pvWEVBOUZGNHBYUmRjeS9Zdm96eHM1THVkRkJQcXg4TzlWbm9TeEtsWGpk?=
 =?utf-8?B?Z0IwK1hnRkZyOHEwZ1IwamFDUGR0bnpzNHo1SzlOL1VJM1orYjBIMmtWVko2?=
 =?utf-8?B?ODYvbEozT0tJMVNndjFSUU81cjY1REROcHNIZVk2Nk8vemhMMnYrQTZlcUFi?=
 =?utf-8?B?SDlMU0h1K0lOZXZvYVZBVnhFSUk1a0QxZ3RjYjZ5WFNwQkZjVkE5NGx5Qjlv?=
 =?utf-8?B?TkFYbHFBdENzYjBMZFBUNGtxVm9kNHBKYlFyTDQzWnhuUTNiV2M3bksxSjRP?=
 =?utf-8?B?NUNHOWo0VmtLTjg2YVhjVnoxbi96YkdvbHhZeTFFb3lwNkh6eC9lK1o5OFVS?=
 =?utf-8?B?NXNCZlFWNTE3NzIrenBwbGRZeTNzMVJETXZBaElIUkM0bDFveXNZbGhEQ0xT?=
 =?utf-8?B?M3FHMWR1dThjVkpKTW14bnFJWnRQUnByb2Q4R1RINkZsbVdzMUFtdVVpNnFG?=
 =?utf-8?B?UmFQNnllVzFhaUJoQlpNQmo2SExxRGlNc1MrV1FVKzZmS0ZiNWxGcysreUph?=
 =?utf-8?B?RHhPWTBEUEd3WGo3cUJha3RlZnJ0bUdKRk1IMnFyZldnTnFEL3FnV1R3Qnd4?=
 =?utf-8?B?QUcyQWVPSWlweG1xWDVra1IyVXhpR2lYUklpQSt6cFZpV3AvOE5BTkgxZGti?=
 =?utf-8?B?T3Zyd3QrakhOMlpkbGFFdkVjK2RVdEZoWU5HWWg3RWR3S2dZTE41dW5yeVNo?=
 =?utf-8?B?Sy80cHYyK0Fyb2d0aGMwNkJOT2hWWjNhQmtYbjh6cWMwMlZIRy95eDc2ekZx?=
 =?utf-8?B?dzdiSmtGMkZ3RVhwK2t0QWhBRStOTzNCQTZ0M1JSNDNlSnRJdHVKazM3ZjR5?=
 =?utf-8?B?K0daOXdqOU9Ia292aEJUeUF2dE4wRHQ2UkhHUXBvU04zdDRxa1VjTGhqdW1I?=
 =?utf-8?B?VmxmS3YzTkxnRWV5aytYQ1AwZkJBcVJKVk9IUXY1eXlsRkFhZ09sdnZSZWI3?=
 =?utf-8?B?VkFicVQ0RERpcDRPaG9pbm5INlp3Z2hsQ1VJeVN3cFJoazVza2VMdVpsKzEw?=
 =?utf-8?B?RjVPUGFFdWc1QXB0Vi9MNk4vUUtWSkF4STlIU1RnUjU4dWw4VHBUMlEzY050?=
 =?utf-8?B?M2FJL0JNZ1dHQWI5UDhFNXVjRWRHQjJIUTVlNVQ1d2JrcFBFS1RrMnlrSEdK?=
 =?utf-8?B?SnV2a0JNTjJKeGhyaDdJMVdPWnBmcktLdW9QMEVWSHBkalVhQmM2ZHlRNGJK?=
 =?utf-8?B?QWthS0xJUlRtSFFCakE4N3k5ZTNsUHVoWVpGcUxSakw2aUZPWjRQQnJFMkZY?=
 =?utf-8?B?UkRlZ2NrNlFvSGduYkZxZ1FPZWZaK0NlaXNjWHZLdDdmaVVDNFR1cUtiRVhO?=
 =?utf-8?B?aUVqTkQ1WmFHNkdKVEFDWVlxWmk4VDdPRzFHTEIyWmY1ZVV0cmt1ajc2QmJj?=
 =?utf-8?B?K3hhLzBObDcyZFhxUVIzTkloNUZ4MkVFTTVKYWZFVVJERjhSRE5EcFdqQ2JW?=
 =?utf-8?B?RWxVZ3M5VnVwc1pXY3M3WGxmV0djTWVQUUZHazZBeDdBV1RxaDNQeUVOejhG?=
 =?utf-8?B?R1B2ejdHN2FEdHlqc2R6TUh2Snh2MmI4VDZWd0RvVkdPMG9UcDVBek9oSEZE?=
 =?utf-8?B?TjdGTUhjb1BiUGtPSmhUVFRhMWEvRUk0b2xHVmdYZm9wN1BuVlhsMDd3SGlY?=
 =?utf-8?B?WEJsWTJOWGFlSGp3OVZSMDFtUlVKOFZtTVB0L1hvSFRlQ1B3dVBmd2lrWHRn?=
 =?utf-8?B?c2x1K3pSWEtaZXBZWWsyWGR0RWdUcnV5anBIUGhWZjFnL3lad0pXWXZiZkI1?=
 =?utf-8?B?QmRkQzErWGdmKytrT09PTWpha2JxMnJjd1Bmd05iTmZxUzdrdHZsK1pNKy9j?=
 =?utf-8?B?TUJ5NTlhZzlMVUI0NjNuSjRuemtpM2hwM2RCRkRQNHZDb1lWeEtOalJEL1Yx?=
 =?utf-8?B?Nm5JZXZMWDNWbTNWSXhyakU4dTlMcEVTN3JDME5ETWxYbW1OT1k1dHZybHB6?=
 =?utf-8?B?Z01meEhuTlR0WDdDZUdSRVRTeTl2czdqQ0pheGhjM0V4WjQyU3BNY0RpYmdV?=
 =?utf-8?B?WEFGKysyYVR2MTNRZUdSdGxWMlRVZDZ2RjFBTnNXRjUzbFNCUnpadTVZM3JN?=
 =?utf-8?Q?czRj14?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:39:11.7923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c41a9583-3c47-4939-2a32-08dd5c368cf0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9172

From: Ilpo Järvinen <ij@kernel.org>

Accurate ECN needs to send custom flags to handle IP-ECN
field reflection during handshake.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     | 2 +-
 net/ipv4/bpf_tcp_ca.c | 2 +-
 net/ipv4/tcp_dctcp.h  | 2 +-
 net/ipv4/tcp_output.c | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3b9b3cdbc0cc..297aeca9109e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -707,7 +707,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 			   enum sk_rst_reason reason);
 int tcp_send_synack(struct sock *);
 void tcp_push_one(struct sock *, unsigned int mss_now);
-void __tcp_send_ack(struct sock *sk, u32 rcv_nxt);
+void __tcp_send_ack(struct sock *sk, u32 rcv_nxt, u16 flags);
 void tcp_send_ack(struct sock *sk);
 void tcp_send_delayed_ack(struct sock *sk);
 void tcp_send_loss_probe(struct sock *sk);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 554804774628..e01492234b0b 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -121,7 +121,7 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 BPF_CALL_2(bpf_tcp_send_ack, struct tcp_sock *, tp, u32, rcv_nxt)
 {
 	/* bpf_tcp_ca prog cannot have NULL tp */
-	__tcp_send_ack((struct sock *)tp, rcv_nxt);
+	__tcp_send_ack((struct sock *)tp, rcv_nxt, 0);
 	return 0;
 }
 
diff --git a/net/ipv4/tcp_dctcp.h b/net/ipv4/tcp_dctcp.h
index d69a77cbd0c7..4b0259111d81 100644
--- a/net/ipv4/tcp_dctcp.h
+++ b/net/ipv4/tcp_dctcp.h
@@ -28,7 +28,7 @@ static inline void dctcp_ece_ack_update(struct sock *sk, enum tcp_ca_event evt,
 		 */
 		if (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER) {
 			dctcp_ece_ack_cwr(sk, *ce_state);
-			__tcp_send_ack(sk, *prior_rcv_nxt);
+			__tcp_send_ack(sk, *prior_rcv_nxt, 0);
 		}
 		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0d275ee68a1a..124b2e95bb0a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4241,7 +4241,7 @@ void tcp_send_delayed_ack(struct sock *sk)
 }
 
 /* This routine sends an ack and also updates the window. */
-void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
+void __tcp_send_ack(struct sock *sk, u32 rcv_nxt, u16 flags)
 {
 	struct sk_buff *buff;
 
@@ -4270,7 +4270,7 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
 
 	/* Reserve space for headers and prepare control bits. */
 	skb_reserve(buff, MAX_TCP_HEADER);
-	tcp_init_nondata_skb(buff, tcp_acceptable_seq(sk), TCPHDR_ACK);
+	tcp_init_nondata_skb(buff, tcp_acceptable_seq(sk), TCPHDR_ACK | flags);
 
 	/* We do not want pure acks influencing TCP Small Queues or fq/pacing
 	 * too much.
@@ -4285,7 +4285,7 @@ EXPORT_SYMBOL_GPL(__tcp_send_ack);
 
 void tcp_send_ack(struct sock *sk)
 {
-	__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
+	__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt, 0);
 }
 
 /* This routine sends a packet with an out of date sequence
-- 
2.34.1


