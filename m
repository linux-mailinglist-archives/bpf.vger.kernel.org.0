Return-Path: <bpf+bounces-53415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D95A50EBB
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A92188F0B9
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1CA266F0B;
	Wed,  5 Mar 2025 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="a85hgZKP"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2089.outbound.protection.outlook.com [40.107.249.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BAF204C27;
	Wed,  5 Mar 2025 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214344; cv=fail; b=J+IwZf49fThIonJL1QhSMtNeEZFmMnGLZaesx1jXfJjHdcskcw6DCNkyY4mkYaGoS/xt1R61w1zCdxudvHKA0H7Yq2/uSdFvloxczY28vGfUCjE8dUZK2H9/XzP43SX6l7QBBUKBqoScg6uQrcp4T1TluHQFbbefdEi477IDS8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214344; c=relaxed/simple;
	bh=caj/4dZuzxPyIKMdpBQhANNHF4/Fmzuo5IWAFNxKlEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+gMMpkdl0VXRONMHTnSlMDDLFYo9PwofWin966FxG2MlHD0bh8HIf+bU/FTIwiIUNB2CUn8fDafQbY4n0ZhSpcPvIwYfl25RSI4xgMeXJ9W4SQlVBk+WHQBpvwu/vX/C/3AczNjQEntYrQzDPohnZfzx88S+dkA4n0ipVN5Voc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=a85hgZKP; arc=fail smtp.client-ip=40.107.249.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhHz2YVQ6fIOLoAT4NsoqbO7cybezOB1ghkXymdG/poXMKrgKqE7k8KLaPm+hgEV7gA6lvTlf02Q62y3TO4yGRRYE4i2Y0zJSjeM1AFQjhN1oTuWJo/ueEW/BmYPF2UQfgT8nFbfDU6Gi2V/AszhCzXxHfLThmhVMQuhotxzIw55R31NN5VDixWgAa3H0bf+HCoUuSKr3kGg3V+7pg5/zAvHcAY56+oGmpZfiT2HdJOi5jq7FczSQU0on/jLAYEhRr6wrchSoRinshtLxaUJX/2+GMfU7tX1ReGIdqWJbsE96xVDCylrVAWqDHszkA6DRZL5NROADAfv6UdTDZT9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj6vrfMbkSm7IE+wBlr7CsgyhJJxRVGy//VrJ27K02k=;
 b=q3qpwX3d4hYvbX93m4cfBK/rtqj4zqiYI+n1fu8lr1rRjfaeHllvwhZWHx0nHgKHa3KTiFCmXwTl7YglI5IqaHm7FF85S9ZbhmKi1iUDaLbnz4N5VWEwOW8nMsYTyM81Qn+I+AAl+1pTH1QHZqamJaQnVh6fnZovrjQdhwlC9qYFj4SwxiLEV0SuwpuuNuKwuRwUsfp2Yk8BUqTuX6TVAiKJW4ruNEnPn9nDi4wcRcy3l0qxHlAIeI/+9+sF3dtFdA1Vd7N0InfVIhwY3phYdH+zgrod5LZTZJBvHSJIAzQP45+i5NlIpsRQjiVy4pYgN7ctqNZPwlRv3gJWaJlDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uj6vrfMbkSm7IE+wBlr7CsgyhJJxRVGy//VrJ27K02k=;
 b=a85hgZKPIsx/inRHvcwvC2GPaV7XUPtBeYuB/6ReAMK9vAAILrX31cBu+j69uv5dsDGR9vr4oIQtSo7NewJ+jnOY70xelHJkkXgNCm+htKCcnMGkzIt8DjSdg9Bu33ctmcySF1Kv1eNmgjZr7WeuEZIKWeQtaSamezTJHtWrjG8Muc56hD8e337XspYMW9SR9pFgTE7ctMNc5K1zvOb6sSK26i4jSb36lSP6C9ELgo1XHO3AxAVwfTugQC6d9N6691h8fiU66+6cIUAdAg2TN6HLaFiOxAxxahXsV9wnP+PeAJjdiDeblUDz0swiQqp3AU7XdgzHVYdYjycT2VgFjA==
Received: from AS8PR05CA0008.eurprd05.prod.outlook.com (2603:10a6:20b:311::13)
 by AS8PR07MB7431.eurprd07.prod.outlook.com (2603:10a6:20b:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 22:38:57 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:311:cafe::64) by AS8PR05CA0008.outlook.office365.com
 (2603:10a6:20b:311::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Wed,
 5 Mar 2025 22:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 22:38:56 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 204C2251D8;
	Thu,  6 Mar 2025 00:38:55 +0200 (EET)
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
Date: Wed,  5 Mar 2025 23:38:41 +0100
Message-Id: <20250305223852.85839-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79C:EE_|AS8PR07MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 03761d62-7f73-4796-7272-08dd5c3683f3
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?amF3a0pCOEhhSS84VlBzbGRkNVI3TFpjVWMyZ0dTeGRNWHZOeHNjRmdqWEhK?=
 =?utf-8?B?QzJZZ3VqRVhQRmdaWlErMUdjRXBqelNJT25VdTZiYlowNkltSkUzMXVkQnRG?=
 =?utf-8?B?VmN1UmJxd1BFMHYxYWRNWDFJTHVzSkk2SkNqbGZpUWF1b3l6MkdqbGwvN2Fy?=
 =?utf-8?B?dmk3dXZUWGw0b3pta1VndWtURUFEbkRxSjFaZWViZ21HM2NyeWZxNms2RVVR?=
 =?utf-8?B?ZFZEQnZ6SURubkVoT2d1SzU3RkxSK0xBMlJNVXUvWEc2VW5BcCtZZ2JhcTVz?=
 =?utf-8?B?L2M1M0R4NnVHdm5yb2VIQ0Y2aXFFSTgrV1p1T3pSbGFUdG9ZWjZidGRPN2Z1?=
 =?utf-8?B?K1ZVdXR6L1VudEpqRVB5dHZxYkpieVBDLzAxU1QvUlVjMEFUcnl6ZXQ3aWlR?=
 =?utf-8?B?NlNzdXZYVnR3VnNMbjhTMUZXUDNhSTFabHNkMGQ2bXlMNmZwZ1UzRERUWGpl?=
 =?utf-8?B?cklTZnhVSEVrVXhwNTYrY201YWtldXErWVF5SmZydHhGYWNCMlVqc3p5NFRH?=
 =?utf-8?B?Zk9yaFh5WFMrYjR4S2t3dDZGSFZZRVptdDNob2o0ajZWZXZGMlFRVGpqU0Vt?=
 =?utf-8?B?aEQ1ZzRpSXNJZzRoUUFNZlY4aDZzWjE0YkhPSlBjcjJnMnpzYWVSV3FwVzNm?=
 =?utf-8?B?N3VKLzJoejJzTFFWQjgrZTUzK2ZEUno4RVpwQ0FPL1FUZUtOc3dYdm0vYTJL?=
 =?utf-8?B?SC8xTGdPSFA4VTVvb2hIaTc0U2xJZlVFTXZyeGJYTHQ4QWZ6UVE0b3RNVVo1?=
 =?utf-8?B?ODN1TU5uZ1RRMWNRbm1jd3VBc0NUZWU1ckQrOTNYdjNGSXc1c2U3djJhblQ3?=
 =?utf-8?B?ZmVaZHhYZHJWdUx5UXppUlhJMkU2Z25BSjNKQ3NhVjROdzZFSG5xTEUxUVBh?=
 =?utf-8?B?SDVycnZNeG1BK09KNGpxdWxWcndTb01QYVNoRTBOb3dNa1FzRWdDdVVmNnlL?=
 =?utf-8?B?NDNFSy9LZmt4b1RSM1M5TUs5NmRzTGg2eFBFNXBTK0tHUmhES0Rmc2JYdFVZ?=
 =?utf-8?B?dDVXdVR3bkxYRXF2VW5saS81UHh1b004WXdiRktFbzZPSHhzbngvclFzUHl1?=
 =?utf-8?B?V3dWSnBmU3U4RUJtbG1aWUVVSXUrY29YaC9IQndPSWttTHB3THJJRzVqQ1dV?=
 =?utf-8?B?TnBPbGZseXNNUDhOYjIxclFyc1dmVmN2YldwZHZjQ1dyUUR4S01RUjg2SU9v?=
 =?utf-8?B?VXVsS0FyZWhPYXlzQzcxYTNSWEV5dTRSZGg1dXU1eCtEeEU2MlFZTHUrY1Zx?=
 =?utf-8?B?cFdrcXRkOXVUdXJHdHBaa0FBREdNNmJpU3JwM0xPV2lFWjNjajV6M0s5V2g5?=
 =?utf-8?B?TzdiVEIwVW9sNW9UbWZQTEtjY1hPRWk0dEk4SFp4amJRN0lWMGZ0RGR4ejlW?=
 =?utf-8?B?ZVZMN21YWWxsS21xaDNNUE42NzNSL0ZHYUhFVlVCVnEwa2QwV2JnU1Q5cHdF?=
 =?utf-8?B?QXVGSkl0UkRJRDV4YjFmalhvSzQwaFBkTXRhS0V2MTVIU05pY25Ta01UdUNM?=
 =?utf-8?B?R2VDTnBUQTlnUU9WZjRJb2RGL0xTWi93WGRuZDd6cVpNL2VCQzZRT3A4d2oy?=
 =?utf-8?B?dlZHbEs2bkJVMDR3ZjRpWW5JSTE0dEpvQXV1TGI3K1lTcGFNUTdFaWwzamhu?=
 =?utf-8?B?S21KMFhyc1VSc3R0VzlxUnVHQlZ3dTQzWmVDY0lNZzJ1a0hVZm1ia2luVHZU?=
 =?utf-8?B?OTFRODBXc3JScjVkSGdVMG0xWEhqVm5ONEFuYTIrbzlCUWJWY0NBVEZLYklF?=
 =?utf-8?B?VUZvajNGUEIrTWh2clBuc2xjWlR2UjBCeHY2U1Q2d3BpQVc4Yk4rVXRDR0RV?=
 =?utf-8?B?cGY5QTFVTU9wRzNhMER4bTZLRTRvaVRsaVh0Ui9HNW9hNER0STl1NXRmTVc1?=
 =?utf-8?B?TTVFdnpseElOMDVSVy83QkhLbzRJVk1DZzRjRHBkVXd2ZjRHeG9iMWsyY01O?=
 =?utf-8?B?dE1nSHlUWFd3bHVpbGN3NFd3cTNxUEZJVkc2U0xVMXZlNkJCVmpTT3h1MDh5?=
 =?utf-8?B?RVFjYUVvVWIyeVhvTjNXaFU3SmkxWEFkb2R1UGY3VmVCQWFzUldaRkVVSEhK?=
 =?utf-8?Q?+VBKxh?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:38:56.7300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03761d62-7f73-4796-7272-08dd5c3683f3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7431

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


