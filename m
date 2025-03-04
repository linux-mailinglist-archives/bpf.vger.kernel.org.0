Return-Path: <bpf+bounces-53191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB080A4E35F
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43251884132
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DE828FFEC;
	Tue,  4 Mar 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dAO79+lh"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D328FFC2;
	Tue,  4 Mar 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101387; cv=fail; b=gohmxq8uMJOOc1tWX4Y0UQ44FCO9nicLQXjFIrlBKMEGhk5QUEsLwG4/ks92MqYFK8o/kHTr5R+bH70Zv5sgzMzRBDQWnlUMsa/RU03/uxq6GSLCGXbDLfxjnyWRM4lz2MaPeZYQ4KSm4Tjq6g4smhO/lvKq+ZbysJsgZW4mjiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101387; c=relaxed/simple;
	bh=O3ZZ+hEDmoX6MlL7QX+4VLaPlkgdXaFjCXddHHveQjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCdtSHkXmqwxCbs1lYSK61UWoh6aibcue8gEKQivU7sN4zEe/ec7ui47b99jISt+btZomaBAuCUWTVPkIpDtvT8S9rJRq11uAjQ9FPIrwrZ9TbHKWRbZTl88aXAgzGATV6sUHYWPlciBacdDAYSsKrCuS8yr06RAI3jL3rE08sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dAO79+lh; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlQdbtf4qAyrgRk6QnuSwzWvEALUCBxdlRa8LY/S2/HBop8KC3JLse6FofpNApHhUYIqXrwKsXqSQE+zmppCfAGJJTweR42lsNlcvqPbLD3cuxzUHFLRkTArm3CjyxRu7jmJWDQkT5DOCWUWZYpvcE1e0mlzjNMiBmzHApp2k68vam9uH/oA2lKL9qVUoKLSpC6/mT/WaCXegTAhCna4dJEV70yFZox/s2lQAahFFVh/4srZQfM0EyB0pjltp8w8BscQ9G0Lc4RbgDyBhOUNG9QFPHtADNMZXDWSEj3EyuyDhq2oojQ9cZi0x3UUpIALpUZL1lR9GwtKPT4lwDs/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlcC8lqloYr+wc5Uzrisp7seX+Nc18fIeGDKA8wt4XI=;
 b=Xy4c3pWssHbYjDfJDg85/K7ek0BP1KCNKbBLvEn3YgVg5oA6/r48jXNfEBCz4hRpjAanii/obkuztn7BvAT31xAkbx9XGtVLbV9YbP+EWkta64ccl6OUOOEpnep/MGnj3nSkTvmEawH6nWaNu39Zk+abkrOdSBR9ZVG8IOoQ1LoN66ltP8bR1bw9HQsRm/mv8ddos/E8H/DjwShyqsIK+P/Up1gxJ+Svm0GmIW3ZiTcn4zxVZAaPCkdR+H5800JIqxUpA78+ZgX9Krs5q1c9MiGcXbQwWk70fUH44R04uWBxaVdB5Ao6BMARFo84tWod0iZySYn5kb8/e1u8teNZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlcC8lqloYr+wc5Uzrisp7seX+Nc18fIeGDKA8wt4XI=;
 b=dAO79+lhQuujWfRx4ApeWDHaTLpi/t+7+8moGa6Qnck4vSXNssi//8EzakXeZn5qlkTVkHByAhWOGQsEkWPWheca4UdvAEWFjpYpFGGeOD4AtFs1/LbA1oKuBR8cf8hmnP2I09OibusNM732+4lJlf2S6m7w+2TA31D3hx4lAETu0c37tPTaffeYiA13L4gsIZhTBDrKZUgpolIScZK5PZrTWyW2uYi2S4OXv4jihg2mYOBkiu5Awas6laE7Uzuf7/2ehV+9kHVoq3I+rBeSw43QakWjwjUbEBCNE/wS9wAQifBJu82ZvfpZEnV+FHiynFVdo0I5yJ/irG64bCceGw==
Received: from AM9P193CA0014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::19)
 by PR3PR07MB6809.eurprd07.prod.outlook.com (2603:10a6:102:7f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 15:16:22 +0000
Received: from AM2PEPF0001C708.eurprd05.prod.outlook.com
 (2603:10a6:20b:21e:cafe::3a) by AM9P193CA0014.outlook.office365.com
 (2603:10a6:20b:21e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 15:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM2PEPF0001C708.mail.protection.outlook.com (10.167.16.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Tue, 4 Mar 2025 15:16:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8FF7C24DCE;
	Tue,  4 Mar 2025 17:16:20 +0200 (EET)
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
Date: Tue,  4 Mar 2025 16:16:06 +0100
Message-Id: <20250304151607.77950-9-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C708:EE_|PR3PR07MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2886a2-230e-4aed-38d7-08dd5b2f85dd
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QVRBNVhpOTBPMGN3dFZPUGUzY1VJTjl6SU9WQ2FZNzE4ZWRnZFd3bzN5T2Iy?=
 =?utf-8?B?UmY2YUM1cTFmZlBBVjM2UWhlbllMRUJqY0ZSeDk0SVpUbEoyNVRjZlNmSi9P?=
 =?utf-8?B?NWwrV2NmcjhJZTNVaWxidVI5cVZFdnFHbXErVTNhSjB5UjdtdE1JYXBXZUl5?=
 =?utf-8?B?dkhsc1VUTEdNRWEyVGFBRTBueXExVGM5WEZRYTVEMmZXYWt0a0JjYlliQ2pO?=
 =?utf-8?B?QXpESXF2alNiVStTbFpEa1FYbGpkd3FqVVNBdWh2dUp3S1UzK2oxdlpsY3JS?=
 =?utf-8?B?aWxsc3JxQVR1d3VNeDJVbXJrOHRENk12TVdsZmhncWp2UjNJUU85bHBWQU5V?=
 =?utf-8?B?d2RlbzZ2QlNoTWtqVVFiWEljL3BEc3NPN2xxM0ZIV05yVnhUS1FMb0RDZHdl?=
 =?utf-8?B?Y2NScCtKbElNaVVzb1ZmOWpoRWNLdnRTdHAyVjR4V2IzeEJJOXRqMmRTUHJW?=
 =?utf-8?B?b20xTlBoU09JNmZ3ME0vcmJGeHZFR2VrWW45ejU0NWJmR1lzMmIzRTQ2N3I0?=
 =?utf-8?B?QklkMDNyR0sydDJMRWZxN2xpWjg1azVJd2d3dU9SZU1MaE9HZVhoMUZ6SDM3?=
 =?utf-8?B?TlhONy9CVzcwdzErYVJOOUlMSHNDVm4xZFpGVmdFblNJclZ3cjAxRFEwRVNE?=
 =?utf-8?B?V0VvSjNnWU5kQ3FUVnNHZ05OUlB1T3FXeTRaZHhvNklBVTZJUVFYWWdCYjdo?=
 =?utf-8?B?QUNKYk90dGlWTG5uOXRCYTNDS1daSy8zajlWZ0V4TXRRbmpSbE5pS1pSdm1E?=
 =?utf-8?B?aDBIOUhuRDQwM2czVWtzZjRRRnpmL0FQOWhFQlhTZWVWV1FaTCs1bDlFUUhZ?=
 =?utf-8?B?V0w1dlQ2b0V0eWwvS2ZaRlhONW5EMDNialJ3M0x5T2tqTU01UFRrc2ZXOXBt?=
 =?utf-8?B?Q2lySmluQ3ZPVkZVdmxsUzRtYkJNYUpIOFpudURBOXQrUmlpTk5FNXpURUFU?=
 =?utf-8?B?MW5xa0ZFc1hiQ3BqeThZVVRVV1UyMlFWWVJHQVIyL1pBbnkxeGRoQ0w5ZG02?=
 =?utf-8?B?Tms3R3FvMGl2aDVWV2QvemhHMlhWRWpORWcxUGxRczArazdqTlB4cU9OQ3E5?=
 =?utf-8?B?TmkyZysrRGc4UkZubU1lUlNodUsyeTVIRERZOW1CczJJVDFjN2pDZVFQTEt2?=
 =?utf-8?B?SXo2VU41OWZ3Qzg0Vmt3TktvME5wQXF3ckxoM3AxaGhEUnRFelk5Tlh1L0xm?=
 =?utf-8?B?Ty9uaDI4QXZKbGNwSlNxVmVoTDRVQm9nZ0d3bmtCa0J4NSttVWJjYlZ6VFUv?=
 =?utf-8?B?QXBob1FEMEJxTFJHbWVOdlpIUWI2YnFMNlREUXpMMG8vZFpvdVRyS3J4RFVP?=
 =?utf-8?B?SVVEOU5zMkd4ZVZuTzJGdkp6amV4S2x0UGkvU3hYaHBVdmV4RCtWK2tCb0xl?=
 =?utf-8?B?d0NWTDJGWFJsSXBaL0pOS0ZhWWJia3haM29GY0FhMk5mN2IrODZ5NjN0VUpw?=
 =?utf-8?B?RUUvbEh4ZDNONUQxWHVQOWExdXJDTGpZR2tlWVRJUTRhTDEwc2RrOE1pM0o5?=
 =?utf-8?B?TjVRSXdVVGdsYkFpRTVveWlZYjk4WnA2K3FuTjF4VXA1MkRkSGFvNnVHbGx1?=
 =?utf-8?B?dGdMTmN3L1U3ZmNnSldZSmhFbUJCU3pQQzU1dGdER29Ta2JVYTlaSU1CR21F?=
 =?utf-8?B?V2s2TmNiWHMzcmhkQlptaXJ3Z2xsdDJGcWRkMDhLL0tDTWladG96Um8yenNL?=
 =?utf-8?B?cCtIditJeE9aMGNmdUhFQ0dxa1NaNTVVVUJFVUxLTE9JSVF4MUlvSzBVUnUz?=
 =?utf-8?B?T0toSm1kalpqWHpMaHgzdmNFZm0xRjdNWlJpY1NGU01Vb3p6VVFYZ2lSOXJL?=
 =?utf-8?B?VGFqcHp0L0V4WlZ4elc4Znp4K3hBRVBuWlIydXY1OVJSeFBGcTVIV216VE5r?=
 =?utf-8?B?TnZIdjlkelJjWHFMenhCemRKTGZ5cXprdnJISVAranI5UFNXYlF1STZ2Q2Np?=
 =?utf-8?B?RFRBVWxPVVZsL2x5M2lHTkNrVlRlRmNldE1GaXZOY1dNR1JRNU53eEZ5dksx?=
 =?utf-8?Q?ennU3pvWLXvijvuC1UC+jp7n2EnCtI=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:16:22.3155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2886a2-230e-4aed-38d7-08dd5b2f85dd
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6809

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


