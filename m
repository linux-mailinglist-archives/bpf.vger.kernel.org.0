Return-Path: <bpf+bounces-53186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00AA4E321
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A6C37A4A2A
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3292857D9;
	Tue,  4 Mar 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="A1m4a1I2"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00939284B31;
	Tue,  4 Mar 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101380; cv=fail; b=abXyqW+OMTx8xVXN9qGLdtMFFTZA6uu8DMbLHxeONV0uQBNx+453VdRcqB94c9mfg1kHIa6HvKdf/v9dfdbcYUDVKnCRJxgsZpyUI+9UOdorXbKunD0gvGMcV0JXiMNwcchz7JqnmWdsGfZBXfj/XCUGq1pKRgNxwoYf3J6WE1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101380; c=relaxed/simple;
	bh=yL7yQyw+fOPNNdHg98sMQDrvfwIn9YYy0na5JwuRmrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNTrYostsVGy0McH9MLg5zo3FUrSsSvmTPrDqgsCiIflQ+cZ9PMDK1zqKa4g5x8oyzzWHQe+6yv3LTh5VlIIHwi7WH0KqUE8qYkFj9j9rb6szDebR2+OSV2a7jItwoxZdZHl6lpkr/4A+4s+5jDB7PUaNs2u45UqyUciAYpJ7GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=A1m4a1I2; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Thvx6efPwyd8G4flLb4+LJB+RpiSVm5aDL1U2bWLhUNTAX3Gm4LdP6+BXL4XM9gtc6lCAfevRlI9h8PSE6SFgQE5zndcaO08lOTKe3sCpr9l2hVFypRjjp+GqFeiscKnPoSD3AfDJq/OMxGTSmjvdT90L0OOUIFuuBBfcsKXwrvqDoJw2X8k2V0IEGbuzO7WvkFNTHh0nv/65zyWECgBHF/xitk/Ix0n50MSDJElutkH+bwOWxtTAn4bFsoMxpkV07aKFy5jAdkDD4e9DOEusLVO5Y8CF2eKO82d13YDQKTDGfs/7ZJmOv2t/vRwiJJWbV8ayLW3nNONpUfRvCJouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQWybgqsQ7JT9ksdd06zY2pYwS4ceOtCbII1UUuweQ0=;
 b=eEh4FdRlNwmceyMBUdr7Em/vwDdB/HkNHNbluygFdi92JLu7EsADpTmvBrrSudRQNivz8EYhxCpHsIbOaV37fyz9f0brHaB3RHLig//jBA0vTrd2XDVPvq9ZN0QG96rsBe/9UYhsP1cJRrgOE1q+d4Bg9HSEOGBMrgtZrvHA8JIM6hJnrHFcOc4iv8Fy28tYATj7uYLyUESMuULnaUUEj90N4m1c2rewBihd7AnLi761jRL8RNYnIbkd4OVFqNW0aGp5QFUUDLZ73IEew72I+TPL8/z5d7muxd5QdN9YotTO+1Ree9kqZG8LbOQ27GejPsPZ78OP99boIq0bDd7ycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQWybgqsQ7JT9ksdd06zY2pYwS4ceOtCbII1UUuweQ0=;
 b=A1m4a1I2LZqyN31I4IiZC5W7/kH7198WnwanR7Gsc0dmBlFTjvacubAQLf50tK4wARA0sP+l7zct5Di+aoZ2yukLSNJ6zy4hG/exm1S4fPCG/KKB2WLbcEvykd3jv+SeVD8j/1ohV/k5ZqtbEgQvs4PZSBJOpXCR6fy1GUoYvAykUUAJ8WJWu374kDyw/ySXJUqTj95QkB2FxzzlbTwsW2rdcC7TnjbLn97Hu3zgEevwQ4h5bQWktcMixb/L7fu5a8AJshsyCgSPUhPZ9GiSbxv2fKUHmsIFMUMP79264bRrom075eM9VEvfquXSvJEbqL8s6mwbK3F3PRKiwIzxTA==
Received: from PA7P264CA0128.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::11)
 by AM8PR07MB7506.eurprd07.prod.outlook.com (2603:10a6:20b:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 15:16:15 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:36e:cafe::29) by PA7P264CA0128.outlook.office365.com
 (2603:10a6:102:36e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 15:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.4
 via Frontend Transport; Tue, 4 Mar 2025 15:16:15 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id DC8C324F98;
	Tue,  4 Mar 2025 17:16:13 +0200 (EET)
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
Subject: [PATCH v7 net-next 03/12] tcp: use BIT() macro in include/net/tcp.h
Date: Tue,  4 Mar 2025 16:16:01 +0100
Message-Id: <20250304151607.77950-4-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|AM8PR07MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ec70e2-779d-4f5f-edf7-08dd5b2f81ca
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TU9ldFhSWUhpUmkzYkRjait2N3ZyeXdZcVVpU2RQT0cydG1CdjRJelg3Qm03?=
 =?utf-8?B?ZWh3Q1A5YzhBZzI4SEc5RG1VN2tkL09QMGhpL1F4ZU5ybDg0OUs2SnhycGtD?=
 =?utf-8?B?QjYxMFNpSy9LYzJuRHhvMUE4N3c2bGRsbXlRZGIyMTF1YWI3Rm1QRzVNYUps?=
 =?utf-8?B?a1UzVHBVOEdaTm0xcGZVUmdxZkJ6SE5Ga2FSNTNDcjVpa0NZV21EOTNJamNn?=
 =?utf-8?B?eVFaZVJWQUJ0ZkNaOGdHQzk3OTl2d2F6UnI0TEYrWVZBOGRCcmN6U3pzS3V2?=
 =?utf-8?B?YTN0ZmNiNFl1Z2dTNFlUTXVSMjhzcnd5ZkE1MmVUU0FjOHQwZVFNSG1JamhN?=
 =?utf-8?B?STNkeC9jd3V4MUhYUVRHTEJ3MDhjcVRsaVM0cjBrZ3VSVVpmTlBza3JJdjV4?=
 =?utf-8?B?Tk5TaVpDUEdKaTZsT2p1R1BaWlBjS2pkVHpXdkw0WC9lbDFOQ3ExenhQQVNi?=
 =?utf-8?B?UUhFdERvK0lnd3VrVUhpdWxDVlpnUXpBODN5YnRRcjl3L1c5d0NkU2lpU2JX?=
 =?utf-8?B?dWJlUWVmeVAxeTFrZkU4dSt2TDJFbS9hdklEbFNSUzc0VWlRVW1kVEM4UGxZ?=
 =?utf-8?B?ZU9JWmQ0KzFHYUdOVWttMXY2ZUZIMTBRZS9SK0JDWHJTaUZCcTdEV3BTUG9w?=
 =?utf-8?B?Wk0vM2tzck5USkVoR2trOFRxNk8xWlNLQmZVYSswM1p2N0hPMzBteFhhQ1R5?=
 =?utf-8?B?SFBaRy94Wk1RSDBKRWtleWVMc3NESEF6OENVeUZBdEFFRFprVnRkc09ydUdS?=
 =?utf-8?B?SE5GMEhvRjViWUJjcmVXNmNCYUV4WktMVUVaNFB5QlFrMFptV3NlU3RmajVp?=
 =?utf-8?B?NzdrZTZqSWx1Z09yRmdjTm1MeGZMSzJqUzVQUjBaeTFHNGlkMTU2eWFBeTU3?=
 =?utf-8?B?TkxJVWh5SW9kNHJPOTVndGhrcVRzRFk5MFROUFBrZFhwd0VBRkUrT3ZxV0tr?=
 =?utf-8?B?YXE5dXl1WlVlUDdKbkVMckZoZ21Ucnh6VWNVVEY1WHQzbUNPVGZYUkNCeXE0?=
 =?utf-8?B?MmV6WGhmUHFCZzIwOG1UNE01VExtUWUzSkd0VG9KL0pGdkEreitIODNtcEln?=
 =?utf-8?B?WW5vc3VRbWFsMkpnKzhNSWZUekFjbTd0dTZDY0Z1TlZlV0xTSk5qQ0NPenp5?=
 =?utf-8?B?VXo1ZmxPM3NhOGpyNU1rTmlFYlhkU2N6M1Uva3RYTCtKNmZyY0tIS0hLWVlj?=
 =?utf-8?B?YlB0SUVMTzFVaVNvMDJaVk0rRHFEVFEvMkljajJkU1oxU3VveFRzMGZPZnVK?=
 =?utf-8?B?U1huZXBONGpYWmNJNitxOXBhZlVjcWtUcUNRQytCdE9INkdUQ3BjUS90Rm5F?=
 =?utf-8?B?dWxRamo3L0RFUGVDY2pJcWNoSzJNSloxdlhVenB4a25HaDZvVjdNWnpoVTRv?=
 =?utf-8?B?Y2k3WGoxcTNlWnVIU3lJMVNGbmlpQlp6T2NJbmxBQ0d3blcvWWdZanJiWkN2?=
 =?utf-8?B?WDFxRjZ2TC9LTnhJam1rNTN4V1Rnd0s4L045Vk1zQzRkaXlMeWgySFJKL2Vn?=
 =?utf-8?B?b1JWeE00SzljRnlGZ1AyNzNTWThEd1EzM0VHQ2YwZWtGMnFFK1FBd0lhemFE?=
 =?utf-8?B?ZlVKeEp2aGduUnBMVm9uNVVzaWs4QlQ2Q0E0NTJIVjBUU1dsVkR1a0YzUGVB?=
 =?utf-8?B?S2RoUzNRQzdlVm1qSUtZdkhUa2tzQkIzZUswM3BXTEpDUGVKSkRxdTViQkx2?=
 =?utf-8?B?Z3dMbHdtaWlpT2xpZGRPZ0RXSWFub3F5aHJ0Z25NTWRpT2IyaFVoRG5PRjI0?=
 =?utf-8?B?RVJaWkxXZ2ZqV1hydmp3MWZ6WDNHZEs1VTB1LzZkM2RISnlCNEtXeUJ4SFkx?=
 =?utf-8?B?QnNKMGRiMXVVOWlXd1B6TUlXQU5PTTlPTnozTHJBWWp1cDBuWmJPaXBEU2JD?=
 =?utf-8?B?c2JjTHNlVjBqUUFsR3pjWlo5RlR1RUNEYTBGMTR2QnV2NjZ0TTk5VVBtVkxa?=
 =?utf-8?B?R1hMSkgvcVgwbjcyZnh0S1VEOTN3NUNUMTZlcVU2L29oYjFTZWNCdFlFSkdq?=
 =?utf-8?B?UE03Ym5xWFVxNFJGcktSQVlJS25Sc2Q3NlNueFVWTnFHZTgrODFtTDJXWlNZ?=
 =?utf-8?Q?gx2iBQ?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:16:15.4691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ec70e2-779d-4f5f-edf7-08dd5b2f81ca
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7506

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Use BIT() macro for TCP flags field and TCP congestion control
flags that will be used by the congestion control algorithm.

No functional changes.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Ilpo Järvinen <ij@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a9bc959fb102..71754d5916f3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -26,6 +26,7 @@
 #include <linux/kref.h>
 #include <linux/ktime.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/bits.h>
 
 #include <net/inet_connection_sock.h>
 #include <net/inet_timewait_sock.h>
@@ -934,14 +935,14 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 
 #define tcp_flag_byte(th) (((u_int8_t *)th)[13])
 
-#define TCPHDR_FIN 0x01
-#define TCPHDR_SYN 0x02
-#define TCPHDR_RST 0x04
-#define TCPHDR_PSH 0x08
-#define TCPHDR_ACK 0x10
-#define TCPHDR_URG 0x20
-#define TCPHDR_ECE 0x40
-#define TCPHDR_CWR 0x80
+#define TCPHDR_FIN	BIT(0)
+#define TCPHDR_SYN	BIT(1)
+#define TCPHDR_RST	BIT(2)
+#define TCPHDR_PSH	BIT(3)
+#define TCPHDR_ACK	BIT(4)
+#define TCPHDR_URG	BIT(5)
+#define TCPHDR_ECE	BIT(6)
+#define TCPHDR_CWR	BIT(7)
 
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
@@ -1132,9 +1133,9 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CA_UNSPEC	0
 
 /* Algorithm can be set on socket without CAP_NET_ADMIN privileges */
-#define TCP_CONG_NON_RESTRICTED 0x1
+#define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
-#define TCP_CONG_NEEDS_ECN	0x2
+#define TCP_CONG_NEEDS_ECN		BIT(1)
 #define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
 
 union tcp_cc_info;
-- 
2.34.1


