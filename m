Return-Path: <bpf+bounces-53421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F556A50ECB
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581601704EF
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6837268C7A;
	Wed,  5 Mar 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RyTwtcnQ"
X-Original-To: bpf@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064F267B90;
	Wed,  5 Mar 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214352; cv=fail; b=c6zCkoorNoyz6Ge0duTqdy23P3LniJ9COI8GfES+ElAJ4oX23v+4mS54MiR54JX1r7pJWNl427co+FjNrOmYc22NjNEB3WoyMNiIIqAXsVeYeLXzK5NhH5BVDU/W+xxdKY8AunyiCiCrtJB1+y4lzee8hdwqo1Pyop6Tv9sCO04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214352; c=relaxed/simple;
	bh=O3ZZ+hEDmoX6MlL7QX+4VLaPlkgdXaFjCXddHHveQjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4QHZWVc33Vae/CInDg+lewocsPnDjHiRLtHmhPR6L7jWKjKwgN6LtzFX/vdc190py4M+va7maWSJeRcKcjGsOYDkKlf8yc4UGJy7DUWJAAzL10mnCSUO4sMtdn3SKZYp9xgyzoetoP5u8KJ5sXSNH4A9NOA2vsTo9gYStsijQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RyTwtcnQ; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFdqK/75z+eYI7la05xN0A0GGGhPKSd5wy61BOqAVkODu98VgbbcZK/7xsjPTQhr/iIURDdlpx1Y/QaRqmg5TVhr5pYCs4A6P6R2K6OWTFxGA7C9U0b7m6EMEZRlrbTKAdDah+ad+S2HRkNgle4UxDvi7xRoKaCDQ+9YEx7+NidXzHH3dowHeisoNlGLIDrSle/cclvEinLU0L6zN2jYbPbjKuqpjOJ4N+gDOnz/l2KdCmmPrTXkX7ydcDU5pOW9O0EVccXZ48yK7eKvdWyHir9r3RxzE6KTRQ7Nnzpb6dcaezxUFLhvOF3Wu77JPB5QfOL38QX/UYwIW+pOVh2EWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlcC8lqloYr+wc5Uzrisp7seX+Nc18fIeGDKA8wt4XI=;
 b=IAHPfEvdDAXHQTWH+5rBrwIx1v/mEGPMSPG5NQ7OJjf5n2QSeuCaWq+/ZD84ycg7qDFl0rJywQ5kvmNqaOY06IZ0h8qlzTf3/5xb8pNSymx3ZyPyxXxKaOYdSsxVBzLiR5V2xxcNC9IskuxIWxqMhOcOfNs7NCyB8ketumgN0JIH8e7MRzKlcbzXqiNdSilVdkjS5e7ROfhct5g5oB6n6i2AY0YWHgfi/FWV5BCgLASgymt74l/c3GfEL4u/xSn+GYSXW7WvlcAtA1UdHmSQjJhzQAMATE33QnwfPZ/mKlZHsPgIYInW5aeY/6ytoKw0MPsOz9qWfzJj1XtO8AsvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlcC8lqloYr+wc5Uzrisp7seX+Nc18fIeGDKA8wt4XI=;
 b=RyTwtcnQEAzMF/TvktovgP+hIdqyN5ynZFcl6aFeD+855YItmUo4KjbOgX62wNPWZcIXGHEwVIk7i8leaxzQhTWwwV43tSteJBKJbURhfaSLPZwztimgznqx/8g5zvY1/hzKVjrLXHI3pOGlDQGJvZ1RakqNDANbkDsh0IOEPN8X1fFvxaiCmxQNpKoEl+aPcsBorSDPPmBJupkHc71WUVEd/NU34cnSJmXEGbU47CMmgm/duABqGvg84t7njQ7yeSbza2buQTU58RCkliGEq+o1ei+bzab8iW8PtSkC6XcrmqFhU+nc3HPnaCjK6lCiqG+1yrRiPuxNYNIYfshccA==
Received: from AS9PR04CA0138.eurprd04.prod.outlook.com (2603:10a6:20b:48a::18)
 by AS2PR07MB9373.eurprd07.prod.outlook.com (2603:10a6:20b:60b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 22:39:06 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:20b:48a:cafe::2c) by AS9PR04CA0138.outlook.office365.com
 (2603:10a6:20b:48a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Wed,
 5 Mar 2025 22:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 22:39:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 6FAE3229AC;
	Thu,  6 Mar 2025 00:39:04 +0200 (EET)
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
Subject: [PATCH v7 net-next 08/12] gso: AccECN support
Date: Wed,  5 Mar 2025 23:38:48 +0100
Message-Id: <20250305223852.85839-9-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|AS2PR07MB9373:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3a7e69-0d19-4d97-64fc-08dd5c368982
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Sy9EZkhFbnQvNmIzM0tGQ1BvelNUZWMxR2hSS2IrV0duZzhPRTYrblFuN3E0?=
 =?utf-8?B?WU1EQUQ5T1U3c1ZKSW5La3hJTU9uSnRTTzBpQzMrQ1RtclFxdHNXZjBZNTlR?=
 =?utf-8?B?cjNrM2REOWJ0UFgyc2VMejl1SU1sVFQ0ZFlObk1hS3FlYjRWOGpKbkQ4S3Z4?=
 =?utf-8?B?MTZoRzVZKzhSdE8xUERRT0R3WllMc3o2WExVM1Q5bFY5UnM0dFdLdjBIeU93?=
 =?utf-8?B?ZVJYeW5VSXQzc0RFelQrNzE0bmZMNytaT0NGV2JqOGk5YnF6TmZCVG9wYklM?=
 =?utf-8?B?Y3UvTmFZQzhkRWVLTCt4SmRvVmNmOHBiU1VCVkVPVjl5aWRYT2JxOVdpTk5n?=
 =?utf-8?B?eW5mOEZ2eExLTW9UNzV4bkkvY2IxSEZTSVlpWW42NlBJR2w0NlU4Q2VpYzNE?=
 =?utf-8?B?VXNsM2RXRUxaZkVvdU00R2lqbzduREVyL0l3c2Y4Z1h0bVZmZzJiOXdUSDEr?=
 =?utf-8?B?cURmRldxbTV4ZHRsWVc4WjdpQlBCcG0vaXd6YUI1Uno1RzJKUXlrMEJIMVdI?=
 =?utf-8?B?TE1BdEdkNVVmaWtkdDRHeW16RmVoVWUvYXMxVVdOYW9JZXRTKzBYczBSS0JZ?=
 =?utf-8?B?SFVodGEzWFg1R1dmdlN0dlJRRTlpclFvcjRXQ0o4TjhsQ0E4b0wrWnQ2V1kz?=
 =?utf-8?B?UTMwbE03RlUzVE1ncjVGVE5rZ0JsSDBtbFA3Y05zbEVkRTdjT2llcXBWNzBF?=
 =?utf-8?B?bSs3UzRtL0NGa3FSa283bFM4L0VlQ0JPOEd4R2lRNVpxbmprQkNPaSsxZG5D?=
 =?utf-8?B?c2Q2ek1lR25Va3dxTVVFejA5RzYyc0pOWjJjVjdiaHh4KzFFajVtQi83TUJp?=
 =?utf-8?B?bUNpbzFRdHZQcFpzcGFMaFZNdDZFRk5TcHJyOUUxUGdmdVUxTlpMNHBybHRQ?=
 =?utf-8?B?S285L2dIY3A4MHFtU2k3aklOT2pWZFJCNFJ0K1FudGNxSDUxQ1RoZ2xlTHh0?=
 =?utf-8?B?VWJwbUt3OTVEbWRvUkR4Mk1qTjRBQWJ1ZzNqU09oOXBsU2hQb1BBNFJNWU1O?=
 =?utf-8?B?WFFRMHB5bG50Mm01aWs3eFoxN1BJSVdjcTBocmJZNWdPRGx4VG9jM1FFeFZJ?=
 =?utf-8?B?NERGMVBLb2lRUlFPMFV0SWRwZW5KcXJSbmlqbW5PNFlNSVVKZ2IzVkQyQ1o2?=
 =?utf-8?B?VlhlZXFwVCtCV0QwT05UMEdYWXdTb0U2a0U5dVJxYStjQkZqYzRpbG1LUk1D?=
 =?utf-8?B?Y25valMrYS9UQjY5dHFtUzByRW5rS0R1R1Fvb2ZyUkhYTnEwOVB1ODBMS0hO?=
 =?utf-8?B?dU1zVTNaWFN2RWQ3Nk5qWGpSblBxbHh3UGpnYWxKa2l0SEJPRDk4T2craEJQ?=
 =?utf-8?B?ZXlOanJ6Z2ErQVRqY3VPalZxd1E3ZzRGOFU0MW01T1hiNHp1bTJ0eDEzMkp2?=
 =?utf-8?B?VXJFblNhLzIzYTdJVXAzenFTU0ZvdndGZng0Q1hWSGVhKzN0dzBVNUFlZ21o?=
 =?utf-8?B?OXhBZVppMU42enVLS0daSVdFeDNjdE5NVTY3N0hDRVg4Y29xcFVrVlR6V3FV?=
 =?utf-8?B?K0QzRk5KdkVOQVhQTDVrZXFwTG1VYkdYcjFBZy8zRFVqeGorNU96bWNkNkNl?=
 =?utf-8?B?WEFTTGZZSWt6THRNczhkdGE2aEowYzBTc0ROVjR5TkJZL2RLbmtTV2E4K0xj?=
 =?utf-8?B?cW8vNHJtM2p3Q3VYS0U3bkQ4TlhIL3Zyd2hsNzg1RzZHb1AzclVZNlNtdUl6?=
 =?utf-8?B?YjNIMnR1eWFlY0RVaktOWitVL3BvbTJnNXVlV0J2bUV6RVNKUjQ5ZitscHdR?=
 =?utf-8?B?WWc5MndvQ2k0ZzhCNFVjNkQyRndZOE81U2lGZXNQZUcxanR1RTdrYmlURjB5?=
 =?utf-8?B?eTIvZlBBT3RsczRpY201dGFFUGJ0cnRTWU9SeWx2QlJEYTBaS0ZSdXpDeWUz?=
 =?utf-8?B?MmdoQWRIRWdiZDhxZHE1MnpPMEZ0dnl5MWd0VnlWckgzYVZVb1lJWmQ1Yi9E?=
 =?utf-8?B?dS9kMlh1akNuOXB5Z1pQMnhwTlZud2tsb0o5SmR1ZCtxSFNvcDhzWmdEVWh4?=
 =?utf-8?Q?hkyNvxdbQjJv91kpkHKkxxSKVF2opI=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:39:06.0554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3a7e69-0d19-4d97-64fc-08dd5c368982
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9373

From: Ilpo Järvinen <ij@kernel.org>

Handling the CWR flag differs between RFC 3168 ECN and AccECN.
With RFC 3168 ECN aware TSO (NETIF_F_TSO_ECN) CWR flag is cleared
starting from 2nd segment which is incompatible how AccECN handles
the CWR flag. Such super-segments are indicated by SKB_GSO_TCP_ECN.
With AccECN, CWR flag (or more accurately, the ACE field that also
includes ECE & AE flags) changes only when new packet(s) with CE
mark arrives so the flag should not be changed within a super-skb.
The new skb/feature flags are necessary to prevent such TSO engines
corrupting AccECN ACE counters by clearing the CWR flag (if the
CWR handling feature cannot be turned off).

If NIC is completely unaware of RFC3168 ECN (doesn't support
NETIF_F_TSO_ECN) or its TSO engine can be set to not touch CWR flag
despite supporting also NETIF_F_TSO_ECN, TSO could be safely used
with AccECN on such NIC. This should be evaluated per NIC basis
(not done in this patch series for any NICs).

For the cases, where TSO cannot keep its hands off the CWR flag,
a GSO fallback is provided by this patch.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdev_features.h | 8 +++++---
 include/linux/netdevice.h       | 2 ++
 include/linux/skbuff.h          | 2 ++
 net/ethtool/common.c            | 1 +
 net/ipv4/tcp_offload.c          | 6 +++++-
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 11be70a7929f..7a01c518e573 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -53,12 +53,12 @@ enum {
 	NETIF_F_GSO_UDP_BIT,		/* ... UFO, deprecated except tuntap */
 	NETIF_F_GSO_UDP_L4_BIT,		/* ... UDP payload GSO (not UFO) */
 	NETIF_F_GSO_FRAGLIST_BIT,		/* ... Fraglist GSO */
+	NETIF_F_GSO_ACCECN_BIT,		/* TCP AccECN w/ TSO (no clear CWR) */
 	/**/NETIF_F_GSO_LAST =		/* last bit, see GSO_MASK */
-		NETIF_F_GSO_FRAGLIST_BIT,
+		NETIF_F_GSO_ACCECN_BIT,
 
 	NETIF_F_FCOE_CRC_BIT,		/* FCoE CRC32 */
 	NETIF_F_SCTP_CRC_BIT,		/* SCTP checksum offload */
-	__UNUSED_NETIF_F_37,
 	NETIF_F_NTUPLE_BIT,		/* N-tuple filters supported */
 	NETIF_F_RXHASH_BIT,		/* Receive hashing offload */
 	NETIF_F_RXCSUM_BIT,		/* Receive checksumming offload */
@@ -128,6 +128,7 @@ enum {
 #define NETIF_F_SG		__NETIF_F(SG)
 #define NETIF_F_TSO6		__NETIF_F(TSO6)
 #define NETIF_F_TSO_ECN		__NETIF_F(TSO_ECN)
+#define NETIF_F_GSO_ACCECN	__NETIF_F(GSO_ACCECN)
 #define NETIF_F_TSO		__NETIF_F(TSO)
 #define NETIF_F_VLAN_CHALLENGED	__NETIF_F(VLAN_CHALLENGED)
 #define NETIF_F_RXFCS		__NETIF_F(RXFCS)
@@ -210,7 +211,8 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_TSO_ECN | NETIF_F_TSO_MANGLEID)
 
 /* List of features with software fallbacks. */
-#define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | NETIF_F_GSO_SCTP |	     \
+#define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | \
+				 NETIF_F_GSO_ACCECN | NETIF_F_GSO_SCTP | \
 				 NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST)
 
 /*
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 15d83d89ae70..6ce7ff453774 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5279,6 +5279,8 @@ static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 	BUILD_BUG_ON(SKB_GSO_UDP != (NETIF_F_GSO_UDP >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_UDP_L4 != (NETIF_F_GSO_UDP_L4 >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_FRAGLIST != (NETIF_F_GSO_FRAGLIST >> NETIF_F_GSO_SHIFT));
+	BUILD_BUG_ON(SKB_GSO_TCP_ACCECN !=
+		     (NETIF_F_GSO_ACCECN >> NETIF_F_GSO_SHIFT));
 
 	return (features & feature) == feature;
 }
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 14517e95a46c..b8a1343d6785 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -708,6 +708,8 @@ enum {
 	SKB_GSO_UDP_L4 = 1 << 17,
 
 	SKB_GSO_FRAGLIST = 1 << 18,
+
+	SKB_GSO_TCP_ACCECN = 1 << 19,
 };
 
 #if BITS_PER_LONG > 32
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index ac8b6107863e..1c6f2a2f1871 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -36,6 +36,7 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_TSO_BIT] =              "tx-tcp-segmentation",
 	[NETIF_F_GSO_ROBUST_BIT] =       "tx-gso-robust",
 	[NETIF_F_TSO_ECN_BIT] =          "tx-tcp-ecn-segmentation",
+	[NETIF_F_GSO_ACCECN_BIT] =	 "tx-tcp-accecn-segmentation",
 	[NETIF_F_TSO_MANGLEID_BIT] =	 "tx-tcp-mangleid-segmentation",
 	[NETIF_F_TSO6_BIT] =             "tx-tcp6-segmentation",
 	[NETIF_F_FSO_BIT] =              "tx-fcoe-segmentation",
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index ecef16c58c07..a4cea85288ff 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -139,6 +139,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	struct sk_buff *gso_skb = skb;
 	__sum16 newcheck;
 	bool ooo_okay, copy_destructor;
+	bool ecn_cwr_mask;
 	__wsum delta;
 
 	th = tcp_hdr(skb);
@@ -198,6 +199,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 
 	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 
+	ecn_cwr_mask = !!(skb_shinfo(gso_skb)->gso_type & SKB_GSO_TCP_ACCECN);
+
 	while (skb->next) {
 		th->fin = th->psh = 0;
 		th->check = newcheck;
@@ -217,7 +220,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 		th = tcp_hdr(skb);
 
 		th->seq = htonl(seq);
-		th->cwr = 0;
+
+		th->cwr &= ecn_cwr_mask;
 	}
 
 	/* Following permits TCP Small Queues to work well with GSO :
-- 
2.34.1


