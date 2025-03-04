Return-Path: <bpf+bounces-53209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBF8A4E74E
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587A319C73D7
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188B52BF3F3;
	Tue,  4 Mar 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="sqeYeY6L"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620762BF3ED;
	Tue,  4 Mar 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105856; cv=fail; b=Vwq5m1g5t5opJ61i2T84/KNDDFS9amHrkEJyQCXeuG4fXwJcvpC7WZ/mXg4gfLqmduml+H/Qdn+9s8aD5pHQ6gQzU7Ulr/COkR3HywmbqgCrRxxi6dLnOBc3/fY5EuwGEUfTdWfQPhpQJvdu99A2vovJoeA+kscruWOMGW9JDlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105856; c=relaxed/simple;
	bh=N2roZUx1POpzilcKOWvg9s1o/9xkNa/n66uQJi+Htuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3sJvK0yZ8LJKT6c/tpYcFDSBURn1iCz37Tc3+8YAHGrseaSRZrI/hNAI3xcj7Jgrs8W4oTvdV0na2eg9xxLgDKyKysIMkDoK3zzpmgNJTnD++HqbD8pyfiI8FkyDuYwHGgMyuzfXm+pFDM8R24XZMSIF9tIgh+ZngSPukzNxnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=sqeYeY6L; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aT73410Wx3Bd5geHvdq7XiyNMTSHkxAPv1FB8MxyZTmrVopmfwtW5ApMcMZfW3JhzApd0tmA85SuVos1XBSLEXNnsnoXCwltMGvlY/2EJwSv+SlYA3UxjhgEOtQgmZtPmVkQeIaXI4oPh2soXGCXckNaclU8WzgrkDqwCAF3yaKb+/gheSnlzw3TzWw8t98YIjANQhQRgpAM1wym95/mhf36zxUhOGX5hYD5GZ/qCImzIW82GOGY7jD9v7PCqk9Aw1JWFZtLRIA1QAqreeTDPqr4JyHcrhg2IRjcpiC+wUYYonLZSGTKeetiHohKFnQOpDbWw9mEzIX4BPqNRkUtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMh95eyAuab+m+v7q5+ZztOkCCyvp6AnIq+l7/Mcnkk=;
 b=DrXEfn5B8QGc2kZIItl9Fjqhmrb83Hf/MrDt/qCKcJejx4d8wJtECqttPp4myruM2Nkgjm7YebTkCU/DoTtHU85iCr5HZNa/DSkOaj20YBW/5h41DrVCnEhXkwq4LavyhgzyCIjOQJWiKnTJVXwIDBYr1zfDynmNbEAp9hHdMhmMgnFXLL4mBaXhKuJYYThlqkaMyAbyZP0tjdtuflRdtcB6J8GrgCczpFHmV3WBSCukmiKrIDVkNwi7G/ztVycxsoCAAgmCTY/qjVBvRaJ8VDG6QdtJ0w0MAevgla7o/KT+S/vVND5TldlAHzL1xnLYmQW8FnVxARIM9ITnAojJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.20) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMh95eyAuab+m+v7q5+ZztOkCCyvp6AnIq+l7/Mcnkk=;
 b=sqeYeY6LeXgoy8Iht25aT1H8X06TLEwVhzL12rV/i9r0ngG3jv8jPTH0bZdxqNyZ5ZUZ3JFPqcdNSDFoqXx+wSW4vh+BSJDq9VctIdVLMhbrdZa9kQyf3SjqdWV61Rda/emR8xTUDgZZW9nlLi+IuL6n4dll8ki4p3xL/ihIQLDg9GvW7jJjvCrXWlIXuLnBvVbcdibu6wWEB8jQDRTdFldteQQih9Sg9UNK28IlfMcOqjycOqIe4tT/YLJ53z1ckObGcEpZsSkOwjiX+q1GvTGQwdsjfGPBR0OcWCfmldLW5LU8e6yqE6HbKbdlsMMbYEpnZFW+c82EtQZzRdA+/g==
Received: from AS4P189CA0030.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::17)
 by GVXPR07MB10085.eurprd07.prod.outlook.com (2603:10a6:150:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 16:30:46 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5db:cafe::4f) by AS4P189CA0030.outlook.office365.com
 (2603:10a6:20b:5db::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 16:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.20) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Tue, 4 Mar 2025 16:30:43 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 47AA72363C;
	Tue,  4 Mar 2025 18:30:42 +0200 (EET)
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
Subject: [PATCH v7 net-next 11/12] tcp: add new TCP_TW_ACK_OOW state and allow ECN bits in TOS
Date: Tue,  4 Mar 2025 17:30:38 +0100
Message-Id: <20250304163039.78758-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304163039.78758-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250304163039.78758-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|GVXPR07MB10085:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b5c4cd-33e4-4ef1-959e-08dd5b39e93d
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?U0pIQVBRa2F3dzZhditLK21PWkdIQlM1b1lCWDVreTYvcHJyMkFtc1poY1pS?=
 =?utf-8?B?bEVoMFlNL0JqU3VxT0dmV3QzTDRzQ0xHV3lmUU51eXQySlNtYXVVNVpNNDc5?=
 =?utf-8?B?R1NxVlU5cVJUN0xtMW5yakZFd21MQnFCR2UwV2NaRWxHdmVzV1hUOEJTeFZW?=
 =?utf-8?B?VjRKVzBuRU5VcGpDNnM3NDVrcFI3MHJLVjI1RG1MMnlRWWdYSkFaV0hYdG1P?=
 =?utf-8?B?VWFxZW0vRWZGbWs0WERhVVZEUFJ5V1phakkrSnFkVWhHMHluTkU3ZE5IT3hi?=
 =?utf-8?B?d3NuNGJiOVlPcjlJWENnZ3NDdkI4Z1ZKaTNiWnE5WVMzMWVxc1U4MDhlVmFY?=
 =?utf-8?B?N3V0d2VzeFJlcGhmWC9Rc2RUUHBydkxiWkdVc3JDU1AzQUEzZXBxZXllK3J6?=
 =?utf-8?B?ZXI1dmhUNnR2R2k2UzN2RVpLVURtSURtWE16TzJaNE5Ecy8rMVI4bWdteHA0?=
 =?utf-8?B?bVh0b2UvRTBpK2FXcWVNRDhUNnNXakEwaTdKN1pLUTY2a0RieXEzdnpUZHZG?=
 =?utf-8?B?MjY3TnlLc1FHNjMxNFdKNjhjSE9ZbnVTZGRpcmJpZml3UnNZVTA3ZGdZcTQ2?=
 =?utf-8?B?NG9GT1ZncjYyMUtndnVIZ05vYW1YWmhqUldnU25FRDVXK3BRSXJjMTdoUHJJ?=
 =?utf-8?B?YjdpZWxYT3pnOVlHekszLzI3OWJFbGg1Zmh4eDF0RURFVVhKaURUVncvTFRG?=
 =?utf-8?B?RHVUK2ZWc1dKVStOTUh4QkdjUUxTR2s2aUxPOUc0dGRxMUZxOXVkQ2ZEWDJR?=
 =?utf-8?B?U051WWN4emw0QytkbDlKVnMvSmtyUTI5WWY3b2ErRFZ3MzR0eUNLK1AxL3Jl?=
 =?utf-8?B?blVJSm4yRmxjOG1tb2N1Znp4QzU5dFo5QTMwNlZoalYxcGxuTG0zZDByL0xH?=
 =?utf-8?B?R09HdFhyVldHZzBqZU1jSG9yWklDOVdpeG5RZ2o2MCswM2RKNnE1SjcrMU1I?=
 =?utf-8?B?Q00rUXdqYjBTeEpMM21jdmUyMnZXQTErMEVrL2VhWDVnSW96aFVKaHM4WUk2?=
 =?utf-8?B?b2FYOTgwMWVCQ3ZwNmYwb1ZUOVRLS01IUzhIZk1LKy9LTEpmQmlPNndLNDl6?=
 =?utf-8?B?dnhORTc4ajlacDNGWmQ0N2ZjdnYvZzBWd3A4TW9oQnpheTNKL0tsanRIczYv?=
 =?utf-8?B?dkpwd1doajlSakttTFZNbWJuQ0tPSENiYXBpWDVDOGVDVEF4akhyWGVrNzNw?=
 =?utf-8?B?SndkVitJYzQ4V0xjVGxqVmNGVE5VKytMcmZlZ05WYU5NSGZFbjMyeTErRjQy?=
 =?utf-8?B?cnNHMUpERmp6Q3JJUGJRd1hmRmV1dXJOY1ZhZjA5YTY5Y0lkRUdHL2JkSXNX?=
 =?utf-8?B?N1g3blcwSjdSdGpHb1lUOVd4ZlByRnFwK3lxTkFyNG4vWjJnb0pGUjBRR0Fx?=
 =?utf-8?B?Uk8xcUowcTBwOTFCNEFZZnVxeEJpOFNxOTd4L1dGWFk2YWFkOThsczUvSitm?=
 =?utf-8?B?d2hGaEtyNk9SeXNCV1hCKzdidjFHMXcvUTZrT2VJdFZPbjR5ZWRnSFp0MmZD?=
 =?utf-8?B?RmJ5WFVhRUhZSmtseU4rdDFKUFM4cXI5M0V6dFlqa3gvNUs4NjdLUG83TTJM?=
 =?utf-8?B?N2ZvOEVsR25mdUMxdkd4ZUF2MU80Z2VBQ1MwV2pleXRXR0pFYkdKV0lpOU8v?=
 =?utf-8?B?dDQ1NzFyNDlJYVVOK3VZS3BSZThMWjJVUzJMNUs4M2FFR0lJeHVoc3pBUUlY?=
 =?utf-8?B?Mjh3SXI4bmRndTFDbmZoalFSUW4yaWFEL0NmMTkyMWIyU2hUTFR4bzgzQ1pz?=
 =?utf-8?B?VlJWaXpWNThyeUtJNXhqTm5KdDcwcm53NGFtenpuS2YydnJtQTlTYTE0UllB?=
 =?utf-8?B?S0ZuVHVkOThyY3FWYmdRckZkdUVoZGJRcjBxL05UNUMvdWUrOVd4TXRlUTNh?=
 =?utf-8?B?Ny9aazdZT05LMkV0YVN1Z1BLM3RubThyU1l2YmlTNE4yVUxoY1IyMm9oT09i?=
 =?utf-8?B?bjNmRFpzVjZYb2ZYL1ZVZWI4dUNNdFVvMVZWMVl0bTA4NFVNMm40b2taSGlT?=
 =?utf-8?B?ZGpmVTZsSUw3SnJWaEc2QTJhVXJUOFBzSER0M0RJVHBwczJ1UWhVNUVoWTdr?=
 =?utf-8?Q?8TqWhZ?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:30:43.8212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b5c4cd-33e4-4ef1-959e-08dd5b39e93d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10085

From: Ilpo Järvinen <ij@kernel.org>

ECN bits in TOS are always cleared when sending in ACKs in TW. Clearing
them is problematic for TCP flows that used Accurate ECN because ECN bits
decide which service queue the packet is placed into (L4S vs Classic).
Effectively, TW ACKs are always downgraded from L4S to Classic queue
which might impact, e.g., delay the ACK will experience on the path
compared with the other packets of the flow.

Change the TW ACK sending code to differentiate:
- In tcp_v4_send_reset(), commit ba9e04a7ddf4f ("ip: fix tos reflection
  in ack and reset packets") cleans ECN bits for TW reset and this is
  not affected.
- In tcp_v4_timewait_ack(), ECN bits for all TW ACKs are cleaned. But now
  only ECN bits of ACKs for oow data or paws_reject are cleaned, and ECN
  bits of other ACKs will not be cleaned.
- In tcp_v4_reqsk_send_ack(), commit 66b13d99d96a1 ("ipv4: tcp: fix TOS
  value in ACK messages sent from TIME_WAIT") did not clean ECN bits of
  ACKs for oow data or paws_reject. But now the ECN bits rae cleaned for
  these ACKs.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h        |  3 ++-
 net/ipv4/ip_output.c     |  3 +--
 net/ipv4/tcp_ipv4.c      | 29 +++++++++++++++++++++++------
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv6/tcp_ipv6.c      | 24 +++++++++++++++++-------
 5 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7e553f27c0e9..3b9b3cdbc0cc 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -419,7 +419,8 @@ enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
 	TCP_TW_RST = 1,
 	TCP_TW_ACK = 2,
-	TCP_TW_SYN = 3
+	TCP_TW_SYN = 3,
+	TCP_TW_ACK_OOW = 4
 };
 
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index ea7a260bec8a..6e18d7ec5062 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -75,7 +75,6 @@
 #include <net/checksum.h>
 #include <net/gso.h>
 #include <net/inetpeer.h>
-#include <net/inet_ecn.h>
 #include <net/lwtunnel.h>
 #include <net/inet_dscp.h>
 #include <linux/bpf-cgroup.h>
@@ -1640,7 +1639,7 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 	if (IS_ERR(rt))
 		return;
 
-	inet_sk(sk)->tos = arg->tos & ~INET_ECN_MASK;
+	inet_sk(sk)->tos = arg->tos;
 
 	sk->sk_protocol = ip_hdr(skb)->protocol;
 	sk->sk_bound_dev_if = arg->bound_dev_if;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 87f270ebc635..4fa4fbb0ad12 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -66,6 +66,7 @@
 #include <net/transp_v6.h>
 #include <net/ipv6.h>
 #include <net/inet_common.h>
+#include <net/inet_ecn.h>
 #include <net/timewait_sock.h>
 #include <net/xfrm.h>
 #include <net/secure_seq.h>
@@ -887,7 +888,8 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=
 		     offsetof(struct inet_timewait_sock, tw_bound_dev_if));
 
-	arg.tos = ip_hdr(skb)->tos;
+	/* ECN bits of TW reset are cleared */
+	arg.tos = ip_hdr(skb)->tos & ~INET_ECN_MASK;
 	arg.uid = sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
 	local_lock_nested_bh(&ipv4_tcp_sk.bh_lock);
@@ -1033,11 +1035,21 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	local_bh_enable();
 }
 
-static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
+static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb,
+				enum tcp_tw_status tw_status)
 {
 	struct inet_timewait_sock *tw = inet_twsk(sk);
 	struct tcp_timewait_sock *tcptw = tcp_twsk(sk);
 	struct tcp_key key = {};
+	u8 tos = tw->tw_tos;
+
+	/* Cleaning only ECN bits of TW ACKs of oow data or is paws_reject,
+	 * while not cleaning ECN bits of other TW ACKs to avoid these ACKs
+	 * being placed in a different service queues (Classic rather than L4S)
+	 */
+	if (tw_status == TCP_TW_ACK_OOW)
+		tos &= ~INET_ECN_MASK;
+
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
 
@@ -1081,7 +1093,7 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			READ_ONCE(tcptw->tw_ts_recent),
 			tw->tw_bound_dev_if, &key,
 			tw->tw_transparent ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			tw->tw_tos,
+			tos,
 			tw->tw_txhash);
 
 	inet_twsk_put(tw);
@@ -1151,6 +1163,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			key.type = TCP_KEY_MD5;
 	}
 
+	/* Cleaning ECN bits of TW ACKs of oow data or is paws_reject */
 	tcp_v4_send_ack(sk, skb, seq,
 			tcp_rsk(req)->rcv_nxt,
 			tcp_synack_window(req) >> inet_rsk(req)->rcv_wscale,
@@ -1158,7 +1171,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			req->ts_recent,
 			0, &key,
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			ip_hdr(skb)->tos,
+			ip_hdr(skb)->tos & ~INET_ECN_MASK,
 			READ_ONCE(tcp_rsk(req)->txhash));
 	if (tcp_key_is_ao(&key))
 		kfree(key.traffic_key);
@@ -2175,6 +2188,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 {
 	struct net *net = dev_net_rcu(skb->dev);
 	enum skb_drop_reason drop_reason;
+	enum tcp_tw_status tw_status;
 	int sdif = inet_sdif(skb);
 	int dif = inet_iif(skb);
 	const struct iphdr *iph;
@@ -2402,7 +2416,9 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		inet_twsk_put(inet_twsk(sk));
 		goto csum_error;
 	}
-	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn)) {
+
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	switch (tw_status) {
 	case TCP_TW_SYN: {
 		struct sock *sk2 = inet_lookup_listener(net,
 							net->ipv4.tcp_death_row.hashinfo,
@@ -2423,7 +2439,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		/* to ACK */
 		fallthrough;
 	case TCP_TW_ACK:
-		tcp_v4_timewait_ack(sk, skb);
+	case TCP_TW_ACK_OOW:
+		tcp_v4_timewait_ack(sk, skb, tw_status);
 		break;
 	case TCP_TW_RST:
 		tcp_v4_send_reset(sk, skb, SK_RST_REASON_TCP_TIMEWAIT_SOCKET);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 0ae24add155b..fb9349be36b8 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -44,7 +44,7 @@ tcp_timewait_check_oow_rate_limit(struct inet_timewait_sock *tw,
 		/* Send ACK. Note, we do not put the bucket,
 		 * it will be released by caller.
 		 */
-		return TCP_TW_ACK;
+		return TCP_TW_ACK_OOW;
 	}
 
 	/* We are rate-limiting, so just release the tw sock and drop skb. */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index a2fcc317a88e..e182ee0a2330 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -999,7 +999,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (!IS_ERR(dst)) {
 		skb_dst_set(buff, dst);
 		ip6_xmit(ctl_sk, buff, &fl6, fl6.flowi6_mark, NULL,
-			 tclass & ~INET_ECN_MASK, priority);
+			 tclass, priority);
 		TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 		if (rst)
 			TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
@@ -1135,7 +1135,8 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 	trace_tcp_send_reset(sk, skb, reason);
 
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
-			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
+			     ipv6_get_dsfield(ipv6h) & ~INET_ECN_MASK,
+			     label, priority, txhash,
 			     &key);
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
@@ -1155,11 +1156,16 @@ static void tcp_v6_send_ack(const struct sock *sk, struct sk_buff *skb, u32 seq,
 			     tclass, label, priority, txhash, key);
 }
 
-static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
+static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb,
+				enum tcp_tw_status tw_status)
 {
 	struct inet_timewait_sock *tw = inet_twsk(sk);
 	struct tcp_timewait_sock *tcptw = tcp_twsk(sk);
+	u8 tclass = tw->tw_tclass;
 	struct tcp_key key = {};
+
+	if (tw_status == TCP_TW_ACK_OOW)
+		tclass &= ~INET_ECN_MASK;
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
 
@@ -1203,7 +1209,7 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
 			tcp_tw_tsval(tcptw),
 			READ_ONCE(tcptw->tw_ts_recent), tw->tw_bound_dev_if,
-			&key, tw->tw_tclass, cpu_to_be32(tw->tw_flowlabel),
+			&key, tclass, cpu_to_be32(tw->tw_flowlabel),
 			tw->tw_priority, tw->tw_txhash);
 
 #ifdef CONFIG_TCP_AO
@@ -1280,7 +1286,8 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_synack_window(req) >> inet_rsk(req)->rcv_wscale,
 			tcp_rsk_tsval(tcp_rsk(req)),
 			req->ts_recent, sk->sk_bound_dev_if,
-			&key, ipv6_get_dsfield(ipv6_hdr(skb)), 0,
+			&key, ipv6_get_dsfield(ipv6_hdr(skb)) & ~INET_ECN_MASK,
+			0,
 			READ_ONCE(sk->sk_priority),
 			READ_ONCE(tcp_rsk(req)->txhash));
 	if (tcp_key_is_ao(&key))
@@ -1742,6 +1749,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 {
 	struct net *net = dev_net_rcu(skb->dev);
 	enum skb_drop_reason drop_reason;
+	enum tcp_tw_status tw_status;
 	int sdif = inet6_sdif(skb);
 	int dif = inet6_iif(skb);
 	const struct tcphdr *th;
@@ -1962,7 +1970,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn)) {
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	switch (tw_status) {
 	case TCP_TW_SYN:
 	{
 		struct sock *sk2;
@@ -1987,7 +1996,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		/* to ACK */
 		fallthrough;
 	case TCP_TW_ACK:
-		tcp_v6_timewait_ack(sk, skb);
+	case TCP_TW_ACK_OOW:
+		tcp_v6_timewait_ack(sk, skb, tw_status);
 		break;
 	case TCP_TW_RST:
 		tcp_v6_send_reset(sk, skb, SK_RST_REASON_TCP_TIMEWAIT_SOCKET);
-- 
2.34.1


