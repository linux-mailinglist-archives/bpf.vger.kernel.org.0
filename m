Return-Path: <bpf+bounces-53189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DCBA4E32A
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00BD77A2EA3
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 15:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB072836BA;
	Tue,  4 Mar 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Cz0KiiIR"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E312862B9;
	Tue,  4 Mar 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101384; cv=fail; b=ICcHd7nw52TXFp7KMt0RlI4joOKumdQ2staQy+X6jR5VD8frUCsOhaslv17i0ZCghPVC73J92DEnHV99IonqNJPN95oCphF5pexykTF7XQ77b4FKMlrVXeJcDJDWsrUCsdrIvn598ryYw1lPro1t8q/uMJZQw/9Buyo6w/CfL0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101384; c=relaxed/simple;
	bh=Ulhva8XrbgA5oAhnhsw2Uqah86jbo5pF+6CBWOuyN3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slX+RXPgPygjyUhf6lOfUEsjssLFCXhhkfyDC1zIX01nhJMQQ/+nWzD15tqMj+RFpe91n5DdnDUXGVeU5HfCvBIEcVKOPqe5T7M29tIjoU4hw1fZI3Z5KVSuGpSKIt8VmhaEasUVt/82cyYHnswlG1MXe7YXVJ+03KbRv/6Q7uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Cz0KiiIR; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afM978J2jppi3Y/6Eb8jTWw0xdwy/N5/g8HBA8Z6H9lQ2W2sVVRGqTUlm4yQ6fJ24WTpGUulTmfJ7K8+BPnZNmzQt4k9hNh5VglbyBRZMo2Lttpm+YSmpiKGr4MCdEKJ0MNG8uENSR+qLycUbme13rhdZ89YKYj77gWFC8hzgGTskZ4J/mSaKgfjZmJ0iNGDAGfHjR9af+gFavs5WMtajf5atfM9deVBAATqCIzJ1MJRDIG3Tvj7aHZGkzGrC9MRtTbNJZaDE+V1LOH503KExCz8SpRiynVSX3XAowiMKhlp4GohW9CFusYtU0bZl1mE90smwJYgfzFeprM/H7DHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1hOb9LCv/YaASiqgdTDb3G4/8C1/qDxqxoEGYEqugA=;
 b=LPKCUjsPjxjv0CCT0pLdjuhs1RotIh27Akltj+5vfGeZH4RcEthdqVl02q/QUSQLNbMKplP+eHJUn8WpkcPVKeI/18CZQjaYJEi3zjFUlMaWNdREuaoFwSl/xTndqTa3eLswve9RgLEnCReCN/6SujezkV4l5WVRhFKcP5+F8M0p8kygXfOHlS2aVYg37e875rcAqkwMQcllPqSEdN5/cMD/EdDUOCR3IuPrHBy/5+oKJwLwy9hy7h0Car/6M6gI7wlx98HxvvnmRiyr9NFVnu3t4DUNzXlVQdJIWad2yJ4v0ejrWiU25bQRB+0nO5HuZ/IDuExcRhevQ3K5qey94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1hOb9LCv/YaASiqgdTDb3G4/8C1/qDxqxoEGYEqugA=;
 b=Cz0KiiIR2KKn2RYEop4ZSi+TXqUuADNafdXTXXWJBWsy1zBZr396geDkZVYgwkzieKKxLRtaRIuLXoxbBrLLUd9cuRHTbBX8fS3GVT1ngp1v1EjjEVuYjDGswxoMEoB2J0SD9fTs+ZOF6X10MSPRyKuqiin26K3OoOubvmgTruErq5598L7II3GO1FKbUNIP8sbETS3JK/8+vc6/hLaPITiBsjN3xhVsGFDFt/7yyRMo1wFRl7+POnX9LpX2JZWkGN9acaEvhDHob7zHj8Fm14J3P3cOuqoV0ca1ival5DgjWZnI/csdFKqkAEsmb2fw7M1qcEE7GWDopMC84sfMfw==
Received: from AM9P193CA0012.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::17)
 by AS8PR07MB9017.eurprd07.prod.outlook.com (2603:10a6:20b:536::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 15:16:20 +0000
Received: from AM2PEPF0001C708.eurprd05.prod.outlook.com
 (2603:10a6:20b:21e:cafe::ed) by AM9P193CA0012.outlook.office365.com
 (2603:10a6:20b:21e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Tue,
 4 Mar 2025 15:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM2PEPF0001C708.mail.protection.outlook.com (10.167.16.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Tue, 4 Mar 2025 15:16:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id E464F24DA2;
	Tue,  4 Mar 2025 17:16:17 +0200 (EET)
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
Date: Tue,  4 Mar 2025 16:16:04 +0100
Message-Id: <20250304151607.77950-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C708:EE_|AS8PR07MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a699f8-73b4-42f9-8689-08dd5b2f8445
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TU9TaVE5WjRCNUxsbkpWbmVQRTZ5aHk5UnU2ZUJhNjljTUpvWmpCdER3Nk5L?=
 =?utf-8?B?V1JNbUsrbFZzcTBvQko1VlAraFdGVytWbjdjQ0tNWURsNTBoZFc0WFltLzhy?=
 =?utf-8?B?RUFHODJYbmkxYjdVWC9WbXZyYXZNcDBYRy9EZ1cza2d6K2h5S2hIbnBtcVV6?=
 =?utf-8?B?R2gydTFVTnlTTG44Slh1UWZhNXgwRW5nb3FwR00vNWlzaWVUWHVTL1hoRWsw?=
 =?utf-8?B?c3BLZnRqb2VSVCtqcnl3aFVJUngyWXgzMkMzYWxlMTJKVzJlRG5ZQWNTUDQv?=
 =?utf-8?B?aFNzOWkvaUptUFpPZUlMcU5FdTRBSytpYk9kZU9oRllBYm4rVzE3dGJYWUhz?=
 =?utf-8?B?U1hSMHpEc1k2TldtOE1oUEIxY2ovRTZUTUFwbkF5UGc1VloyczFaM3hGb0V1?=
 =?utf-8?B?VGFMY09hQ1NxandVTUZTK2hDdVdRYmo5d1JIaXdoeTJyVkhETFI3bHFKcisz?=
 =?utf-8?B?aitFT2Q4UjVPakQ2RGk4cFpVQ21xWG96cXBPcHJqMmpaTk92aWhVQk5mK2h6?=
 =?utf-8?B?VlY5cTY4NCtmK28rdlJsWVk1cDcyR296QTdjR2ovNCs5d2dGUjN2T21ZZndI?=
 =?utf-8?B?VDJlZUNtZ3VzcUhKQWpKd245R0pudnhLNUJNVTlUMjl6NGZSRU1vQXFOLzl3?=
 =?utf-8?B?R1pYT2x0czFURWxHU3NyVE5BZlphQ2hpN09OazZxR0p5RXM2anpuMk8xWkFT?=
 =?utf-8?B?Y0dZeE9GbjA0WEpzNjllTmlJcFNza2ZIWW1jYWp0QTdmcVVReDZqdjZkamtG?=
 =?utf-8?B?a3J6cERlU2ZtTEpHRndRalNjaHQzYTVSYUUwdjZjTGZ5WU9QTjg1djVUdW94?=
 =?utf-8?B?K0M0ZzZ1dHRGQkpFeU96TE44STlUWGk0QTdGT3U4RlQ1Q2tHWEM3LzB1MGlP?=
 =?utf-8?B?cFl2OTBnWEt2NGJqMGpqMDR1T29nMng3Wm5vTGhjdFg5NkoyMURGbWEyblZr?=
 =?utf-8?B?WUtqMG5BaUdnZ1NnOWRqV052YmxSNG1Fbjg0T2V6Rk8vSGpPekExRXc3VlpJ?=
 =?utf-8?B?MnM4akpIc045VVozR3NyMW14dEFUOXl3bTJXdTV5NTBrMWYzdVhZRGRSZ3Z0?=
 =?utf-8?B?UzBDSDdVd05rb0d2SEZMUjhaNFpTRTJLQWlJWnRVazFhVHpRYStseVZHL0dP?=
 =?utf-8?B?NkhEQWUyc2YxcTBIbkE2YXV4YW5nejZQVG1lR1R2SHIrNUMwRkRmb08xY1Mr?=
 =?utf-8?B?dG5udDVLZytDeitUSW1CczRwb1JmQ1dJSERnS1A0Y1E3TXhVT2laUkhTM3Fn?=
 =?utf-8?B?SGJ0c0xJMmJMNG5SSGJGY2x4K1ZmT3Q3V21zb3B2VjVaK3c2T3BWRi93QXZm?=
 =?utf-8?B?K2Z6ekhHYVNPNCtiUHVqWFhQbTR3d3lUTCsrbTh0bU5vYzcyOEswS0RqUXN2?=
 =?utf-8?B?bU9iaHRtbTB5Nms1VTJMVi9ZUk55aXNUemE5d00yYndvYUZxK09pRitYcDVI?=
 =?utf-8?B?djBqeDRwNjJlWlJ2RE5aSDYxN2VJYnhmYTZrVVhiRTZlb2krd25tN3RNdTBY?=
 =?utf-8?B?eU4xT0kwZEVzeGcyYTI5VWhrSG1YYkVUNHpsQm8xMjZUd0Q4VDhDRnBDamVR?=
 =?utf-8?B?U0g2OEhEQ1QrY3R2NkJCcm1BamE3NVlnYVBxQ2VCU0p5NHlvbEg0RG5rR0dp?=
 =?utf-8?B?RkZ3OUhIYjQyYjh4SytYU2MyWnB3VlUxMDlZMHNzVlgwdkVUc09ERnBRb1JN?=
 =?utf-8?B?Yzkxa3ZpNVFYeXhScStqYXNWV0I2U3BJMU5OMmtGMm83UGt6ZG5CZFNnaTcz?=
 =?utf-8?B?ZHFPWnlVRzZ1Z3dGM2xNSEZuM24reG9lZlVJOTZZeGdheUNqd1gwY1JBaHhR?=
 =?utf-8?B?YmNjSXNWN1JZNEFWYWcvQm9sR3E0eisvTUZtdTRSdlQ2NnZGa1NSSnN5bzdu?=
 =?utf-8?B?SC9EMUpaWEhEYTl0UUxYY1prRUdGWk84Zk5hVmRINHFkSnlFVG8rc2VmUU1D?=
 =?utf-8?B?eEMxMG5HcWgxUk9pQStzYW9IY1J5OTdOdWJpekJQV1ltbWtYeklaWkhteGov?=
 =?utf-8?B?RnMwRDI3WmEwbGZoaTRIV2hQbG1ObXVFcnZ6TDBzM0dVQk1MZ29taXBpbE5U?=
 =?utf-8?Q?QbpiiY?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:16:19.5030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a699f8-73b4-42f9-8689-08dd5b2f8445
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9017

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


