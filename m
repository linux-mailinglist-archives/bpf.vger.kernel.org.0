Return-Path: <bpf+bounces-53424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CD2A50ED4
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65041705D0
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D5269B15;
	Wed,  5 Mar 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="s3gZyGZP"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2073.outbound.protection.outlook.com [40.107.103.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472B2263C97;
	Wed,  5 Mar 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214359; cv=fail; b=SozKbYiXSau9zyseNNr0IJ9sXy55C5AqwyChCxPYDME+2gyXon1OjFpfG3LDJouxdLNKTMvt7kUI1dSTnqs029t7QbzMvshWxdkPZravviKeM4pnsEM4sP5WUthz8HIcmhnk2zAhymM0/nkS3Pf8YWPOzOitvdwcVqOyu3qfdoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214359; c=relaxed/simple;
	bh=N2roZUx1POpzilcKOWvg9s1o/9xkNa/n66uQJi+Htuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhGtIJycM5tAZAbfgN7GSUDXprSZUEORopfpPQ2A2zMT/7PdAK/lRotIHH70wE5sTuzhUVf5gRXHw39Btr77s0qattpfyjbeds6UpdYbsMcI5B1ldScHZhP5UieAnMJMIEORCFNtDXHSJbmKGAFCPPzD8tTu8WiRb83QdDuEL38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=s3gZyGZP; arc=fail smtp.client-ip=40.107.103.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVBM01gTGb0qzC7p8sMMdKAYuz9p4RRQbIQR+iOsPzcbZz1tcS8Xb5/hlIiJCiejdCGvHFT60BQDKh/cI0QhSyLh3y+sudTOiiCH4u2QSs0yVsYjIQjwk6t490a28fqjbcv3DapD+rsAj35/m3XyZ6TDEFZ1BwxwUdvQx9Oz/DZyTLSQJxqcF9NewECQBmwdNUqT2tQ/GKPohCKDd7sCV+vpV3Mwd/HxDN6XRipuylshcyZFKbieLM/uCNJuoaYAlFFvhbdCB7RwIikrQPTE55LI7pvNyeTkG0ETPx+in2FOPdVVTqEvNCvnAFGkNcR1jvrtGpIagRLj/RyigVSu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMh95eyAuab+m+v7q5+ZztOkCCyvp6AnIq+l7/Mcnkk=;
 b=uGy2DogrUc5Pt5y+vH3UWr26N6UEqq7azPwEe++6dBzhMrxp2lcb++dVEiYbrT5G5oIQWcKInVvXlJo/OkFVr6J7g5ZMHlOPrgy4pVgd003hZUFcgCqqqqn0QdcoqomkdBAG34GFnBipTvRsi1ho13LHUhbBvxxZXGaot1xPuCgU6v8b5u8uWkrwWmehDMiP/H9CPPxm8O2CQfGSDCFmSedfj8e/gyrh87z+3y1KFDQbRk+/+kTp1zKIK8wMbZKi93slLgfdYCo+bNBmpDqI8LVj59fACKlwzMzLy62MWbqUyA7QMqgperrG5YQdXkWxwQSPTSCTWCKl/s9pGLcARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMh95eyAuab+m+v7q5+ZztOkCCyvp6AnIq+l7/Mcnkk=;
 b=s3gZyGZPGmpniMtly7YcHiOILNppWNe2EhXieoTdXFSaFCK7EzgdeJNh8iQLMMNpUnKgSdIYZwRoBTh7ooASsungwu60Hl8GQo2x5gLDRICHOOwon/96/yaTyzRDBOMb820xBsI5RXdQb0PvcdWs6WODvMfxy+FqZg86SvwYDA5HhGWNIB4/rmATQOIFRkag6a8qHZA6UApF0nZzGQKphm+lJMoFN9vY4bchguBNPxbwCs160DOWEylx/B1zRWB02h5Md17xOQ4WRrvc1C9tu2zCkS361hVD5GaAzmXtfk3amvnfSN1jhc+rzbFr412Tn0PRPbux6HcB/YYOgnvIGw==
Received: from DU6P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::8) by
 AS4PR07MB8683.eurprd07.prod.outlook.com (2603:10a6:20b:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 22:39:10 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::de) by DU6P191CA0006.outlook.office365.com
 (2603:10a6:10:540::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 22:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 22:39:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 681E6215CA;
	Thu,  6 Mar 2025 00:39:08 +0200 (EET)
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
Date: Wed,  5 Mar 2025 23:38:51 +0100
Message-Id: <20250305223852.85839-12-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F6:EE_|AS4PR07MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: f041b9a6-7467-427c-b492-08dd5c368c31
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TzVqQ2R2MFFLbFliT2YxZHl4RW1iOFlISTVDRnRVY2NWWVdQRDlHSXNNQ2Vw?=
 =?utf-8?B?K1Y2UEVhR2FLUGloV3BCaGdyL2dpZFUxekdBaTdEbUZwSFpZMFlsdk1vcHVx?=
 =?utf-8?B?S204dDBWcjJvcTA4cit1L0pQR0xFTDdacE9VMmdtaFhKMzZqTWtGWXdLdEYy?=
 =?utf-8?B?VkJhbnIwSllhN2pjSGVjVDRHVkF2eHkwUFJIYzVraG9GRzlMMFRPSm13MXZz?=
 =?utf-8?B?c29ObGdlVmlOYm5YZTJnY3lUWjZTWFZxcEpVUGdCOVFhSllqODYvTlcydnhL?=
 =?utf-8?B?MjhXNWhabGIxVVJBVzNNNlZnUklrSnJrMzgrNFd2YnRTN0I1WmR0KzdlUzhx?=
 =?utf-8?B?L1NBU01GUjI3SGY3eWNpaHl1WlpsSVZ5d2JDaEMxL0l3SGNZQWF6eVJnWCtk?=
 =?utf-8?B?c3JMdTZEeHF0VlJDVSs3ZVR6VVVmcXFqcFN0MDlTOGJLSm1HTjVyZlZ3ajNE?=
 =?utf-8?B?M1c0RTk1Y09oZkZhb09xYWJSSjNxbHlqZG03ZSswdFEzNGF4SG5DeGhIN0xi?=
 =?utf-8?B?Skk0MXpxbG1xbllMSnh0VlUyNFdTb1J5UEphRFpNUk10dFdmdEZ1NTBTbllO?=
 =?utf-8?B?akZZaStQQktQclNsd2ZqNU1iVS9tYTc5c0hBcjJhTHVpSUExZEpCUzkyMlp3?=
 =?utf-8?B?K1RSdlNHejdEejltUGpkRHV1TnQ2eVYwYzQ1NkZYTEd0UUtDZVRuWDk5WDEx?=
 =?utf-8?B?Y2U3T2Z5WEN0OElFTFRqdFQzd0xkVjBWWDFZZFQzSnRtTW4wUkxPYWFPWWlm?=
 =?utf-8?B?RWNBaXAwNzAxRWdoRC9mZXFDRTlFeG50djYrdVhhRzhMU25qRmFiL2R3YWQy?=
 =?utf-8?B?UytubWhXSTdHWWJlZVFUc3MyMHBMQmRPdHlSalNQRzFYQTVzd0czS0U4cmI1?=
 =?utf-8?B?Ykc2REhmbzlra1M5RG5FY0t5OVBLaTJ0MnpTaExpUDVMN3Z4czlHNGhWR3Vm?=
 =?utf-8?B?MzNxYksySDQzRWlOV2kzUXYwakFGRGI2N0NoWlA2R0FWOFpvem1nNTdWTS9D?=
 =?utf-8?B?NWEyK29XUm8xU2ZlNHg0MWN4OGlRdlJ2cmR6bS9ybGtZdnh6ZE8yR3dvdlh1?=
 =?utf-8?B?b3ViZjNkSFBDdFduZjFhWmwwckovWVk4R1lNSEl6emJid21oVTVFY1YxWHpV?=
 =?utf-8?B?S0I1NytFNjdoZUUvLzNIK1B6YXYvbS81bjR6RkZlYS9OUTFVTXJSWGlnY3dQ?=
 =?utf-8?B?bC90bEZBbDN0WWVGSVkvWldiUDJjSGpyWGxNdU5HbHNGRmQzNlppMWZjODZq?=
 =?utf-8?B?ZTdvVnBScFAwVlhxdFdxK1A0QUxjMThzcW9Za2RtbFlPaFB4QzNIdUtRb0Fj?=
 =?utf-8?B?SUZYMnkzckF5SDAyVXpUdmlpMVk1dXVnVEYyUXRjdlB2WmhlWHRaUzQwVDdZ?=
 =?utf-8?B?TUpsSzVSTi9McFZMUDVHaE1JOHRhK0V4LzVMYUhseStFTmRCd3NnMmNiZDJp?=
 =?utf-8?B?S3Y4WXNMTEg0ZlJ6TkIrYm1QTnFvVnIxSUNJUEg3WDNmUTZSU3hCT2I4OFE5?=
 =?utf-8?B?NjlaWUdsS1F5OTBPeDNlUG05Z1Fzb0ltTXBZQURNcUF2ZUZaT2RzNk42VE9p?=
 =?utf-8?B?bTB2UXFmWW11Q3BZdklGeWpqUUtZanZJQityTXM5NXNrT0h5R0lTSHBESlBO?=
 =?utf-8?B?VG9Mb2NBQVIwVlF1Q3czZUJLeEhZWjVwTmZkSDZVUmw0ZmlBL0k5aUJXS042?=
 =?utf-8?B?aUJoR2l2Y3pML2g2bXQ4L1lRQU5UdmhtVElxanljbWtFVzlPakZ6bTVVb1cv?=
 =?utf-8?B?S1VGeUJISHRMcFFnQjVROWwvLzNCbzdiNlYwM1VqZFFMMTJ4NmpMVW4rd3I1?=
 =?utf-8?B?WWJUVElkQ1F0c2NJYkxtcnVrVEd2M0xRRnpFSGg3STZ3R2tFdWlHZ3FJRTlo?=
 =?utf-8?B?Mk5FL1FyMER1SjBkc0tVNDQxMkdObGt1ZmZGUWFKUFJFWG5iUFd3VnJWUUk5?=
 =?utf-8?B?WktsZzA2M3RpYWFUc1ZkNGE1TFZaYk9EbG1nc1pnRUlOOVBDRkJwYUVJUjhE?=
 =?utf-8?B?MVh3QkFYK3FqdXdTSWoybGRRd2xHUDBsZElXdE1MUnlKYVh5ellsN2FDbnhS?=
 =?utf-8?Q?ZoyDPu?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:39:10.5285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f041b9a6-7467-427c-b492-08dd5c368c31
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8683

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


