Return-Path: <bpf+bounces-53417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BFCA50EBC
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05123AD087
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964BB2676D0;
	Wed,  5 Mar 2025 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="fQyGm0tK"
X-Original-To: bpf@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D826739A;
	Wed,  5 Mar 2025 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214348; cv=fail; b=NE1F+QLhzF7U0vLXR3dK2XBy9wLsmq0XLbpQt18fTO8/Zh7GzEEXm+czTkg6Sa476V1irLGV3403U4PFYPA04j2L6YEJYE841OFj0mxcFiMQ2LNVAYw6jgeJ7TG3JP8QO09rr1SZfLv+auH9HgIsu4Mt8LdylGqFsagLxhXof9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214348; c=relaxed/simple;
	bh=bA19Bgpx59I0ZPvtfckmXShS5/xeaVVN/XJQwYHkm2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgf5fkSfzs8voa1yfUzaej5ZB47H1So0S1ofBnrH5NRW4y2AekwBnhmlxAC57MfXv6KRTIExsq6DK85XcbhKjET05hUxmxEumBrgUAVQs/DQN2b9f2Oo7eDEmHCnUnCYDIaGuJVn+IYR+MhqTJQlR5K+XbGSZTe4lf0H3tOhSLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=fQyGm0tK; arc=fail smtp.client-ip=40.107.159.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn4fTNZ7icvs2UW3Foh36sYuwLWnUNcPgWpxngh65w8ugLn0AQtKtN7W6r7VaAz3k9FVepUL7IMaq2bw10CHpnB/y1KgC9nklSpzJv1YvlpwWRkrbrdzyYnSWBfTMfcztUNM6zwbe9C79rcVgOGm0Wb3pZQ7pqRqMjsX16PqSIRU5poERkg5MA62yVM0O9t5xWguY3nXIcpy0CYvLPbfMJsnrmxWNlXE7g0ITbyvH5gWi0H5IE72LGn2oxlwvk3ABDc1LRcMeaCPWSSFeRC/qQ8OacPjH08nH8pF/1wGLTWQZ0rbsCuDcMhT2iZsVR3D30osmd/EVNDG7fEqp7Cuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc9vVUPhzHEVD79jRHb5BVINbtRTTLDxS7wnK+13uWE=;
 b=RCCZ1xwMi9N1CvojwsnaeiU9GGCbSl69GaAGMtjHcTXyqn98+mkdLU0tXWuoF6Mg8bowm7e5s2FWVhBoSPqBQb9ditB9TC5+bCSMO8a9lofUF9wf7VhzhnG/nj0w72jP1zdl9VcUO6pFyMOIlzKl15NXCFaQEkbReECw0LfakTGiRZ+PGR8WMBqF1leAX4iCmF5vOPvGFmpZ1P8WYg0L3aBS2uRZYyg9eudeBko1/dfh/LGns3sytG5rJhPr4kxACPfHYNEKq2LzlAm3bV8U5bHXZp267AfuvJpr+E3E5bLxnUOpEOxknFlXFpgnq+eoX/3OsWgU6dpb+uixCWs/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc9vVUPhzHEVD79jRHb5BVINbtRTTLDxS7wnK+13uWE=;
 b=fQyGm0tKNsl078fOtWKFhcGsg5wor3yySk9FaY2d7Ba3z3Tvq448F5izcOpt98uaa86MA4msLi9kO66kTVEhdjgmGRzIYx1coXsCqgZUUa9/xcdoRU0cgjCIJIWzTPTieZ7QT7ECdqSa6COBOwaytpzwHAas86QDvWuH4H+PIr9M98hBRHwpUF2lbnS7XKCAqDt0DINiYa8JkX88XFU+tW6CH/m7ftyzV/MlkGtyUtmQj+OhOe7g4ch1oIChMLrVgoVXfct13bqRSw48M6Fy+W32epS6b8WmLXteSPU4h/x+JaFND3Ez8tVWlrobg8I4zFkqZrDca5dErvHvgPhMug==
Received: from AM8P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::25)
 by PAXPR07MB8388.eurprd07.prod.outlook.com (2603:10a6:102:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 22:39:01 +0000
Received: from AM2PEPF0001C70C.eurprd05.prod.outlook.com
 (2603:10a6:20b:21a:cafe::f0) by AM8P191CA0020.outlook.office365.com
 (2603:10a6:20b:21a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Wed,
 5 Mar 2025 22:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM2PEPF0001C70C.mail.protection.outlook.com (10.167.16.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 22:39:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 1E70A251D4;
	Thu,  6 Mar 2025 00:38:59 +0200 (EET)
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
Date: Wed,  5 Mar 2025 23:38:44 +0100
Message-Id: <20250305223852.85839-5-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70C:EE_|PAXPR07MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 370b80e7-0bc8-413a-0e9b-08dd5c36865a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WkN2dEM3ckZZZkltQ0VVTzF3ZmEvYWpnd2hURGNWZlhHY2tFcmg5L3VoYzI0?=
 =?utf-8?B?NUhyUHJZMUNDeTdPQ2xwWndJY2ttS05MZEE5VzgyRWU1ZitWb2lCbFo1WXJF?=
 =?utf-8?B?bjkxMXhJREE3MTlQSkM3TkpWM016VXRxVUtpSTZLemhDOEZ4Nlh1RDhMdTZu?=
 =?utf-8?B?cTVLS0wvQ3ZkS2IrVE95ZFp4VkorTWlQVGxkcDRoN2l5TWpoeGxaY0taU2Zj?=
 =?utf-8?B?Vjh1K2ZuRmVjSW5KcmxGcFd0YXhFMG9JNXp1dU9VUWU4YjVTRVgzOEY4bUFF?=
 =?utf-8?B?eFY1a0w1aE1veFMvMExFS3BOaDZJY1FYOHZFTzdCSmhjRXpSLzJSUWNBS3lZ?=
 =?utf-8?B?U2tPdTd4dGxFQUNFMUFrRlV0QXgrTXhTem52Ly92Sm03NTY5RGt2UHZOenFn?=
 =?utf-8?B?ZHBjMkZFMjRsYy9IQXFwdTJXRi9nQkRPa1lpMk1tRFViM1lmb25KZlg5a2pz?=
 =?utf-8?B?aTMxN044TkxMRnBTdVBuQTJvUmI0SmR6VTZhaFpBdUl0MTZCYzUzMlREWGY1?=
 =?utf-8?B?K3lKeEQyamQzblRzQ2ZmWFlOUmF5K1RPUHdPRVUwdkxRM2RvM1g0TGFraHJY?=
 =?utf-8?B?NWNUTnRXbnFWd0plVXJvQlB0QldCV1lUT3F2TThBWWVsc054WE01SzVadmhB?=
 =?utf-8?B?NURwVG1OVmlrWGV3T1MyUTdld3ppNHJNV3hxeVdmYXZQekd5bEMzbUxDcmpj?=
 =?utf-8?B?Yi93c0FPa1lUZk5BY3ZnUkJ3WVV0RFJOUHY3Y1IxcndWYVFvelhGNTRLai9X?=
 =?utf-8?B?NU1LeC9seTg5MVlKNFFHQWd4Y2o1ZGEwKytRUlNRak9XelRYQVp5ZDV1YzRN?=
 =?utf-8?B?N3ZXbS9OUWVuZUV2a1N1M1ZSb05CTXRrZER1SkI2T0hjejVEOWhkWlJ6VGxv?=
 =?utf-8?B?RFNJbXVYWDJxKzdacHZ4bmV4cVp3YUZWb1dUOGZnVDd3V3JkNm1lMTdCVkhH?=
 =?utf-8?B?OFpxdXAwQllDdFdmQ0FwbXZORklIVDRhU0RYSk4rd1lBZzRrQnZOV3ZaT3NR?=
 =?utf-8?B?bmhoQ2NDckRNQURsOFkxaVlBR2EveW8zV1dkaDFTdGJJVFJPMTM1VFFxemNJ?=
 =?utf-8?B?S1BhSUE5ZFM2dFZrT1dmbmp4d2lvTGR0dkEza210dlRsNW4rcUxkcy8zSDNm?=
 =?utf-8?B?eWF0bnk4TU85cHNyMzJDVkRrbTNNQ3NUTnUyMEVBOG1GY2FDUkRyL2pEeWhk?=
 =?utf-8?B?Yzc5YTE4QXZQY3J1ZFRHUzZVZk9pUkFqc3JBalI0T3VLcWJ2cGtjSGpyeDh0?=
 =?utf-8?B?bjM3djRSNkwrWDdMOFRueEhLWDJSOXhwZWlOSjVrTS9jbkZuS0FTTkVidXFC?=
 =?utf-8?B?VnNsQ3dBbTBXZUNTbzVMSDdPZU1DTmY0MkJvZVNsYjhtU0pxcmdHb09zWVZh?=
 =?utf-8?B?bU10TGxYazBYZmh0SXFkRzVQN3dUMlUvUjRSNjhqKzlUL3A2dUFFRmZDanRK?=
 =?utf-8?B?aG9ZNnFwV2ExZ1E2NXBDNHVCaiszaWR5VE9LbDJVejhZekhuOGVrM0Q2eC9B?=
 =?utf-8?B?RkY0RjgzU254Z2NKNlMycHNLNFFiUDh4d3BvSGJ0TGpqTzYzM285dmpSYW03?=
 =?utf-8?B?TC85NG93NjNjMnhRRjdPMXNzZnRPZlZqQ0lwVnRZQXQ5OFdHNTZUNnVIRFVv?=
 =?utf-8?B?Z3VsMjl0K2JNanEySFpDay91cEZ5NEs2Z3JYcC9ZTTNIZW8rUU5XaTFKU1lV?=
 =?utf-8?B?SW5UejRTdzVvcGczcG1WYzMwRi85a2xmdFQ3UzVscklBaXg1cGZTc2VxT0JU?=
 =?utf-8?B?cVRXMkx2M3hoQzlUTXVWVkIyUlcxeHgrT0U2b0FPai9QMnVTQjFLZkR3Zkxl?=
 =?utf-8?B?bVBhQkNDZ0NGM3A4ZzZiQnd0N0JUb0dFU1A2RHZ6NEZmQ3FmTXc0a050NFJH?=
 =?utf-8?B?WTFJOC9WalZjK1JIT01hbFVQdDV1Z0txS2pDODg1VnhvdDBnYUlsbUhya2Vk?=
 =?utf-8?B?WTZRRU9uc3UrcXVna0pNYmw4LzNVaURMSFBqcWNCT0NPTUFJR2YwN0NpRWtp?=
 =?utf-8?Q?p2V1qD5UIk/cZqs+KhwTi1d53Eo3/k=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:39:00.7735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 370b80e7-0bc8-413a-0e9b-08dd5c36865a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8388

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


