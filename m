Return-Path: <bpf+bounces-53190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5440A4E366
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB7819C2AA5
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FED828FFC9;
	Tue,  4 Mar 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ngg4cc70"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDFB27E1CD;
	Tue,  4 Mar 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101384; cv=fail; b=VudIsVoaS3/ySFvmYDUOu7LmmC8ruxFEQUX3wmPl+OaQWrHUzrIoY0lHFTtS5obp2mO2WrlGY2O4CxAXtv+L7ly+IxwM9PVVK3F9AxofwbY/KItU+rWQ+F5PVRDWcqUToxhtU6EPTZNk/I2AFHqvz2zA/F+vEj9udSzJQRxbbuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101384; c=relaxed/simple;
	bh=bA19Bgpx59I0ZPvtfckmXShS5/xeaVVN/XJQwYHkm2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2iKl7cikARUZGxhEQrIwMyYOVO2H/wgozmdpcGmLIXtBQeVlduc3BGqmf8q6Eo0THIp5vt8dTu93sDbku0VOgdCZyMgCpF6C07yr4BK1k6+BRw/E96t8EvDqrt2LFBpXtXRQXO6f+5JOimGw57xTLN11FkKXsticY5F6PLoIp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ngg4cc70; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4HHbqcXjG7tLgkV6WCGhT9bi3ZF49Y6npZWE8tjOpl0iOhgXL4oiX16VFoIgXbXvKqpzVXcfw9MYfXCy48TO4s3Jwo8J5nIVzNhXC/u2asVzD2iUCcBoAaH3LYKp5LAgKSbZMzzf/2HqvKD/75el9O7hnJE8Et1HUsz1M2gl+HoONb5BTLY/Tbj8f+lDMz00sZAu4lIQTF7LMXOLHaK044MODdAxuAz0Cq7AR+aJIoTQj0Q/06iMwnojBCbF/VxLTooJAlirMdZgEfdiPEcmJx8Xh7M4/3VdBBO5PLeI2VVbuEhtQijxnC7bZYIBtDnJdG7d8/XOaH/8OfRe9KF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc9vVUPhzHEVD79jRHb5BVINbtRTTLDxS7wnK+13uWE=;
 b=KN6cWeNpMco824bkwOkPF8y86gnXrvW4rImMwVtgcEXPfC2NAP3EmIImAk1EUxS4D1FReUlyT3kC9x+IjL9eVBjJbi5ABPI9FmVEFnkVvNvtCQ7PJjU+Kt9zpxY1kqVXKDGcG8aZVHKCZfiqBTUsv3N/snsObP9Zm0ItG5w+ZSIl72TkhodxQWHpLhn0GQKfmpLoI74u4MS9m9RvnbGXR2unj5MbRMgEsHNFT80SPL11/t3Env1ruHBsinLziCBOZIMWErFJvxWrF8EqdwfLPNsv13yR47QzXAIAyghrfCpc1ad8690tvMdwk2WcRBBAyXIps/zx8JtCFYYQIlnatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc9vVUPhzHEVD79jRHb5BVINbtRTTLDxS7wnK+13uWE=;
 b=ngg4cc70yxBEdXt9UxBcxj+M7UCKNQmzXA6b2GcvY4+jTPI7t6VAlUHgxutXB0du7DjH0BKaaxC3i2QGPuqNdL11RCif4QVC6KldxVdlpbeH6tDo/JukqCPJVJaxg4lRnKhBq72JxNyOYQlndcFOs8yMZtLT6V6keogdj7poVyrPkmL5i9nq5Ntmcd36alHIUwOlEm230Bie/XSdgxDpcpZI6rgUh2r7d8A8cJVM9qRjeXZsD35zWjMpDHu6b0MZgeHBGlfGkpKp2CcKHA77nCgp6e422ghy7qga/vsBCWNI5lxNHEFo5m6gZRLEKeauwth+ltiUtRO+kgWpg6CHxA==
Received: from PR1P264CA0096.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:345::11)
 by DB5PR07MB9513.eurprd07.prod.outlook.com (2603:10a6:10:48c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 15:16:17 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:102:345:cafe::57) by PR1P264CA0096.outlook.office365.com
 (2603:10a6:102:345::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 15:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Tue, 4 Mar 2025 15:16:16 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 3924F2118C;
	Tue,  4 Mar 2025 17:16:15 +0200 (EET)
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
Subject: [PATCH v7 net-next 04/12] tcp: extend TCP flags to allow AE bit/ACE field
Date: Tue,  4 Mar 2025 16:16:02 +0100
Message-Id: <20250304151607.77950-5-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C713:EE_|DB5PR07MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: eb78b578-9052-42ff-7d62-08dd5b2f82a8
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SFhISEFUbm5VUW5ycE1oU1dLM0s0ekRvRlJpSjRMdlJUYk5JdWZkaGFobE9H?=
 =?utf-8?B?amloeldqZjZYaTRacDFwRmpjR2NwTnJhblI4V3FkMmZkalpaSWpqaXNTaDUx?=
 =?utf-8?B?RE9QRzBjK28zdlJGbllkdXJ6WGlIM1JRZlM5SUZ5RHIvTDA1d2hIVlk1NlpL?=
 =?utf-8?B?OExLTzRvZW1UVHBYdjlBUjdrUDBGZHJTODRodkpscnV5Mm9ZSHpjMU8xNmtV?=
 =?utf-8?B?U201c0kwdHZFSTZqYjk3RUZvTHd4SDZDKzV2ei9velorbWQxcmxrb0dTZWlT?=
 =?utf-8?B?enl0UTZMSUdrd3RjT0tFTmZZV2NPalRpSHdGWjVvN3RxN2t6Z3h0THV0Vm5p?=
 =?utf-8?B?R0hYVkk4U2ROZVpCMGNCaFYwK3Z6aEpLRFRpa1RnVU8xZlpKKzFGakJQd2Mz?=
 =?utf-8?B?b0ZLODdkUmVsYWFmdkVxczdBS1hKRkE2MzZnSlFySHBZczBvQVRnaGszUFV0?=
 =?utf-8?B?TjR1NUNCc0o0R2duZm1xNldEdlRpZHJoZlRFdkJ5bW5lRkFKZXZ2am5jSVRZ?=
 =?utf-8?B?dDliemFQOXNoTnphaDhiYTJ6QW5Qc0tqdmo4RU94ZXphSHBjcCtaNnpibnFN?=
 =?utf-8?B?b0dFTVRZWUVVZ2swenRXSTJMZXpBTXkwTVJ5bXNVOTM0aHNXYmQ0VzBQdlQy?=
 =?utf-8?B?bDFTcThDT1pPUjk4THlYNnRNSW01UTd3cWZaOGsxb3h5anBWdDVyRUkraUYx?=
 =?utf-8?B?WjB4TjZSbkQwTGtBQ2VwOStsOE1rdndiZDFBN0dmZ0VtaTRlWHM4eEIyWUFj?=
 =?utf-8?B?YWJIQlNHUnFXekplQ1pZUG1jVytxS2FUckVEM2lVYk9SL2s2b1NGMFovMWxm?=
 =?utf-8?B?bGpYVEdyVVBEMDJBdWZBRXBKMjYrOVBOK1BVTnAwZDZIRmx6VXFXays0cS9v?=
 =?utf-8?B?M1RMUHYvRytnYVkyVlh0Z1BhOUttdWZ2ZkVQUjRaSGt0aENTQzB5d1loKy9S?=
 =?utf-8?B?RWZDNE1HS0c3UkJ5dWp5YjJuSUczQTRrcVQ1eGVoWm1BTlZ3K29BR21jL3p6?=
 =?utf-8?B?OVIzVU1uNXZmR2R3d01rcjJ6Z012bFFSa2d5TWlYeE1ZeFM5UVJGbFExZnND?=
 =?utf-8?B?K2dXT0RtME9nd2U2MDZjSi9yRFFQZFEwL2UyMlFBOW8rUVBGZ2phRWlQS1Vy?=
 =?utf-8?B?c2xXS2hFbE94Qnp0L3pkYkxkWlZzekJZQ3Vjd0JBeUgwQmpOMnNvT1NidC9U?=
 =?utf-8?B?RjhJRjM2ODJUM1ZvYy9iWko2SmFDbGxNbFJmR245YTJFQWVwVkNmOWd2Skps?=
 =?utf-8?B?NjJ4eGptYWFHcWdUL0l1RjFsNUdqRFV0WkNEVTlrSmJXMXpJWXlQUHBXTHZB?=
 =?utf-8?B?NnoxZzd3clF3dW5laDNCTkMyQjdJdi9VZ2k0OWQzMXdRakRBTFN3bzdwNDlE?=
 =?utf-8?B?Z3hlNTNXbzgxYVNnQUZMOGl1YmdjLzlqM2NQSFRUaC9CZGFoMGx4OEUvVVJ1?=
 =?utf-8?B?Y1ZDRzVkR1lBeVZkUzRRY0t6WFQ2N3hNc2hOWmdwWWgrZXJ4TCtROC84QWV5?=
 =?utf-8?B?emhVbFJueGt6M3lJQmllNkY5WUhvcEMyaXRmc0ZwMjZCeW1tcHVuMTY4L0pX?=
 =?utf-8?B?enRKcGVSNXd3NTVhNHhQclcwWXNuaWlNTXhVWStGekhWZWJwbEFBOFpFaXdI?=
 =?utf-8?B?SHJjbC9hb1pobDU5dGJHVUgvb3ZTSWM3dFpjTFpBb1BabCtkSFdhNXY0Sytu?=
 =?utf-8?B?VlFCZTlFUE5vZTNMSDhnVHdLUlgvYXpOT3hQVWp0Q1ZwUnNRUXdRVzRNUVB5?=
 =?utf-8?B?OWRFamsyRlFsWC9TVmhYVkRtNzJXYjdhL3lNanpMMU9VNGt4V0ZhYVVzdEx3?=
 =?utf-8?B?UjluZ2VKaHJkSHkvaG1yYSsvZlRyYTZKcXNZb0d6WWd1YVFuYUw5RVFFOTJU?=
 =?utf-8?B?NW5LKy9QTHhWNjVhQ05lcmRDN2Y5K0cwRU1tb29JYWJ2R0EvQmQ4WE83aHVo?=
 =?utf-8?B?TEZrczE4cUlpZE4va0FkUkp2ZE45a2toa0lhZ2UzRGR1K1pxQllUVW84Q0xG?=
 =?utf-8?Q?TeOLEwVZWDNF0rkkY0T/UEFsAu7dTw=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:16:16.8274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb78b578-9052-42ff-7d62-08dd5b2f82a8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9513

From: Ilpo Järvinen <ij@kernel.org>

With AccECN, there's one additional TCP flag to be used (AE)
and ACE field that overloads the definition of AE, CWR, and
ECE flags. As tcp_flags was previously only 1 byte, the
byte-order stuff needs to be added to it's handling.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h             | 11 +++++++++--
 include/uapi/linux/tcp.h      |  9 ++++++---
 net/ipv4/tcp_ipv4.c           |  2 +-
 net/ipv4/tcp_output.c         |  8 ++++----
 net/ipv6/tcp_ipv6.c           |  2 +-
 net/netfilter/nf_log_syslog.c |  8 +++++---
 6 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 71754d5916f3..49b66b499429 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -943,7 +943,14 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 #define TCPHDR_URG	BIT(5)
 #define TCPHDR_ECE	BIT(6)
 #define TCPHDR_CWR	BIT(7)
-
+#define TCPHDR_AE	BIT(8)
+#define TCPHDR_FLAGS_MASK (TCPHDR_FIN | TCPHDR_SYN | TCPHDR_RST | \
+			   TCPHDR_PSH | TCPHDR_ACK | TCPHDR_URG | \
+			   TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
+#define tcp_flags_ntohs(th) (ntohs(*(__be16 *)&tcp_flag_word(th)) & \
+			    TCPHDR_FLAGS_MASK)
+
+#define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
 /* State flags for sacked in struct tcp_skb_cb */
@@ -978,7 +985,7 @@ struct tcp_skb_cb {
 			u16	tcp_gso_size;
 		};
 	};
-	__u8		tcp_flags;	/* TCP header flags. (tcp[13])	*/
+	__u16		tcp_flags;	/* TCP header flags (tcp[12-13])*/
 
 	__u8		sacked;		/* State flags for SACK.	*/
 	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 32a27b4a5020..92a2e79222ea 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -28,7 +28,8 @@ struct tcphdr {
 	__be32	seq;
 	__be32	ack_seq;
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-	__u16	res1:4,
+	__u16	ae:1,
+		res1:3,
 		doff:4,
 		fin:1,
 		syn:1,
@@ -40,7 +41,8 @@ struct tcphdr {
 		cwr:1;
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	__u16	doff:4,
-		res1:4,
+		res1:3,
+		ae:1,
 		cwr:1,
 		ece:1,
 		urg:1,
@@ -70,6 +72,7 @@ union tcp_word_hdr {
 #define tcp_flag_word(tp) (((union tcp_word_hdr *)(tp))->words[3])
 
 enum {
+	TCP_FLAG_AE  = __constant_cpu_to_be32(0x01000000),
 	TCP_FLAG_CWR = __constant_cpu_to_be32(0x00800000),
 	TCP_FLAG_ECE = __constant_cpu_to_be32(0x00400000),
 	TCP_FLAG_URG = __constant_cpu_to_be32(0x00200000),
@@ -78,7 +81,7 @@ enum {
 	TCP_FLAG_RST = __constant_cpu_to_be32(0x00040000),
 	TCP_FLAG_SYN = __constant_cpu_to_be32(0x00020000),
 	TCP_FLAG_FIN = __constant_cpu_to_be32(0x00010000),
-	TCP_RESERVED_BITS = __constant_cpu_to_be32(0x0F000000),
+	TCP_RESERVED_BITS = __constant_cpu_to_be32(0x0E000000),
 	TCP_DATA_OFFSET = __constant_cpu_to_be32(0xF0000000)
 };
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d9405b012dff..fab684221bf7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2159,7 +2159,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
 				    skb->len - th->doff * 4);
 	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
-	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
+	TCP_SKB_CB(skb)->tcp_flags = tcp_flags_ntohs(th);
 	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
 	TCP_SKB_CB(skb)->sacked	 = 0;
 	TCP_SKB_CB(skb)->has_rxtstamp =
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 24e56bf96747..efd3cb5e1ded 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -403,7 +403,7 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 /* Constructs common control bits of non-data skb. If SYN/FIN is present,
  * auto increment end seqno.
  */
-static void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u8 flags)
+static void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u16 flags)
 {
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
@@ -1395,7 +1395,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	th->seq			= htonl(tcb->seq);
 	th->ack_seq		= htonl(rcv_nxt);
 	*(((__be16 *)th) + 6)	= htons(((tcp_header_size >> 2) << 12) |
-					tcb->tcp_flags);
+					(tcb->tcp_flags & TCPHDR_FLAGS_MASK));
 
 	th->check		= 0;
 	th->urg_ptr		= 0;
@@ -1616,8 +1616,8 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 	struct sk_buff *buff;
 	int old_factor;
 	long limit;
+	u16 flags;
 	int nlen;
-	u8 flags;
 
 	if (WARN_ON(len > skb->len))
 		return -EINVAL;
@@ -2171,7 +2171,7 @@ static int tso_fragment(struct sock *sk, struct sk_buff *skb, unsigned int len,
 {
 	int nlen = skb->len - len;
 	struct sk_buff *buff;
-	u8 flags;
+	u16 flags;
 
 	/* All of a TSO frame must be composed of paged data.  */
 	DEBUG_NET_WARN_ON_ONCE(skb->len != skb->data_len);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 85c4820bfe15..a2fcc317a88e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1731,7 +1731,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
 				    skb->len - th->doff*4);
 	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
-	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
+	TCP_SKB_CB(skb)->tcp_flags = tcp_flags_ntohs(th);
 	TCP_SKB_CB(skb)->ip_dsfield = ipv6_get_dsfield(hdr);
 	TCP_SKB_CB(skb)->sacked = 0;
 	TCP_SKB_CB(skb)->has_rxtstamp =
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 58402226045e..86d5fc5d28e3 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -216,7 +216,9 @@ nf_log_dump_tcp_header(struct nf_log_buf *m,
 	/* Max length: 9 "RES=0x3C " */
 	nf_log_buf_add(m, "RES=0x%02x ", (u_int8_t)(ntohl(tcp_flag_word(th) &
 					    TCP_RESERVED_BITS) >> 22));
-	/* Max length: 32 "CWR ECE URG ACK PSH RST SYN FIN " */
+	/* Max length: 35 "AE CWR ECE URG ACK PSH RST SYN FIN " */
+	if (th->ae)
+		nf_log_buf_add(m, "AE ");
 	if (th->cwr)
 		nf_log_buf_add(m, "CWR ");
 	if (th->ece)
@@ -516,7 +518,7 @@ dump_ipv4_packet(struct net *net, struct nf_log_buf *m,
 
 	/* Proto    Max log string length */
 	/* IP:	    40+46+6+11+127 = 230 */
-	/* TCP:     10+max(25,20+30+13+9+32+11+127) = 252 */
+	/* TCP:     10+max(25,20+30+13+9+35+11+127) = 255 */
 	/* UDP:     10+max(25,20) = 35 */
 	/* UDPLITE: 14+max(25,20) = 39 */
 	/* ICMP:    11+max(25, 18+25+max(19,14,24+3+n+10,3+n+10)) = 91+n */
@@ -526,7 +528,7 @@ dump_ipv4_packet(struct net *net, struct nf_log_buf *m,
 
 	/* (ICMP allows recursion one level deep) */
 	/* maxlen =  IP + ICMP +  IP + max(TCP,UDP,ICMP,unknown) */
-	/* maxlen = 230+   91  + 230 + 252 = 803 */
+	/* maxlen = 230+   91  + 230 + 255 = 806 */
 }
 
 static noinline_for_stack void
-- 
2.34.1


