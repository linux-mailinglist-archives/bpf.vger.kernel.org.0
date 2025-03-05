Return-Path: <bpf+bounces-53416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69169A50EBD
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F90188F048
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C126659C;
	Wed,  5 Mar 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="s4xTi8wQ"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2083.outbound.protection.outlook.com [40.107.249.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAEA265618;
	Wed,  5 Mar 2025 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214345; cv=fail; b=rQFykOv5vWmqkHbs5df8ZUdTGrISRvQwxyhueSGVUIlRQU9VbJVHwTlZF6Ec8wZdadR/Oej0wKOwsNYeThrckqXYUXS46q99CxTDoTmWvYOLpS82oB4PU5Evx1TIq+7RJ3IqembQ3od/nSazk5CRoDuwWXoxjhUF+26piMd6A0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214345; c=relaxed/simple;
	bh=yL7yQyw+fOPNNdHg98sMQDrvfwIn9YYy0na5JwuRmrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALm7cvynHcTTrMhSzlVv8ryoFKA6lWd7rqWOY61i1HKG1tV2jqVxhdj+0mqa+jsK47TBRbbRFXtGKnkOZdEowwH35ee1Csov9L0ZbecepM1uOwbT23XjUgrDbidyaSx4/gId6qbKUpmqLq131m35/bgW6jvaxceUt6sNzx+ZYO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=s4xTi8wQ; arc=fail smtp.client-ip=40.107.249.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dio+0ETIqcHdBMs9FrMLYu9dOrEyp8Tcdh8ZrhNj4o8d5NMq2Csb2A6MFEDxVWKVSocWtAi2G1MsK5ETPgCeEJIbp/VDjDsFCf+GR4vR4gagjJxSSP1Y9cW5Q9Ln8w6bRHMfsO/5dVyYyHB8hB8tKUmoIOEEQmWxeqz+egZ/UEEGhcsFNS1kUpjMuFjwnYiKmOsrBUM4kJcljxV35LEHPGpXDnH7MERgsrRY8/IjKty/je0YoP5Mp5GoMctre/PtHLipFD9VcIf6d7ryDwsISHy/7UYgUb9X08DSX7nE9UCI0Z0zof7UVvTRbjpF/94TFgz7yM0ghF3krcXIgclYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQWybgqsQ7JT9ksdd06zY2pYwS4ceOtCbII1UUuweQ0=;
 b=MdxMG2KVp7GpxsxTd7OKREOedLnkryzfsOtcR6r8e/GAaMWfEUd/gQntf0C1U9KxbiQd2SBMOb2T7I/92p6NWVLoYX83RuInJZfoglqwBQe8bYa0YQGz4PTjhSe3lW8fewAts4ePi9P0e5Ow8zwE1hEC1qvcLQ1DqeHvCo2+hcv2c45TUtlqxbbWlLaa78HDANNBpLVndvBxmkrAiP6GQdN6Hx83tl4SU2FwPi26FtDFV4wJuSSmqgNCCfVWL4WQrfogqKNVmf7RyVIjUksye7p8YCLNtctQYrOk8jP068ZOFx2c0ZZpYeYQpYn8+D0HOtzuHMOrNqcaoc9oGFkckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQWybgqsQ7JT9ksdd06zY2pYwS4ceOtCbII1UUuweQ0=;
 b=s4xTi8wQ+mKpgn5Av+MiFmvfHK+ry0B0rKiwQwrewK8rMP2vOr/ngzCb/dw/mvqj1IRusqQ6NyqrZOq+ke/xhZZcv0+4mpaUOO+0rGJm15V+kXhLQ4fzk+2wzwSAZRabgmcWWVxgXb1nxCs5ZG3kxTCS+5D/IQGrmYufWOiujwheEkLpKLYSQGM0OFF+o+SCt/v83olqZ02z2jonIuA+NqBYZkQQXXuaD/tcRDjk3LKFaXKer/eUUhf03kG+WNx5VYbuPxqzBuYpADN3owGQiV4++yauQsNra/DoDx89BxK7hp4CEflDGAWYJdfK2gyk9GeJT3w31G8mB84zSPdOaw==
Received: from DB6PR0301CA0077.eurprd03.prod.outlook.com (2603:10a6:6:30::24)
 by GV1PR07MB8349.eurprd07.prod.outlook.com (2603:10a6:150:1c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 22:38:59 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:6:30:cafe::56) by DB6PR0301CA0077.outlook.office365.com
 (2603:10a6:6:30::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 22:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 22:38:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id C310A251E0;
	Thu,  6 Mar 2025 00:38:57 +0200 (EET)
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
Date: Wed,  5 Mar 2025 23:38:43 +0100
Message-Id: <20250305223852.85839-4-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B94:EE_|GV1PR07MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: fac582a7-7bc1-4f51-fcfc-08dd5c368597
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TUZvc3RPWTRLSUp1bWtJcDNUU2pkcjB6ank2VVcyQ3V6Y0RjUXkrcmJiSmF6?=
 =?utf-8?B?a3pscTdHNUZkNEtZeG52NUh5Sk1XZ0NZNG1JTlk3MVRrakYrRExGK2pxQmlG?=
 =?utf-8?B?NlNWbzdHamQyWjNENTI4Nnh1UlZoV0RTN2g3UVg3bDhCVEdXTHZadU9GU0ZS?=
 =?utf-8?B?SDhqazBTK3NDRnRVZkxKeE9GY1NtNEo2ZEk0L2xFcEZwVWpyMW51M0MxVGhp?=
 =?utf-8?B?WUR6RGdVYWlRUm95OGQvTmJ6bXg4V1JPbFNwcVFNZEJiQXpvZWh2cW1OK1ZD?=
 =?utf-8?B?T3ZieDBXNVNwdllOcVVhWDdaNXp0MlhBaWRUeGNKMTJ1dTA1M1c5ZzFzeVpY?=
 =?utf-8?B?WXZCUmxEVnAzaUF5MkRCMDhmUll0ay80NTBOdWVhTlpZMGFaa3ltOTMrQzFn?=
 =?utf-8?B?eWpGNUV1U3BzcnJvcWFVSEp1VVA5bjljMjRYR1BnTDNxM0NQVFJna0pZdUx5?=
 =?utf-8?B?aTlNWit0V1ZJeC9MeE1KdkN0WHRYK0kxb3k2Ukh0T3k4MnhZY1RTOW9xVmhj?=
 =?utf-8?B?K1o1U0N5ckZwekZydS9ITkZ6MGFjWTRDa1QyNE1IYUJaRWMwaWYxcWlKa3dt?=
 =?utf-8?B?QkttUkNBYzJuaTJFZTVxOVJoeCtGYmNMcy91UllQdnZubmFhZkc0QWdwRzk0?=
 =?utf-8?B?aGlmL25BNk9CYVZ1OHdqOXJ4NHhpTndIaUY5RFV1SFRac0dneHBrdWZVditv?=
 =?utf-8?B?UXFqU25wa1Y5LzhsTkJ3WVdJTGFpZ3VpWEZKVWFxT05HUGp0TmF1bGJ4M3JB?=
 =?utf-8?B?QzU2VGI0Skl5N2kxYVZJZzdhZ091YjlFcVJDVS9NMWd6U2g3eU5rVE9jaWVO?=
 =?utf-8?B?b0dVWGE2MDRsNUZvYTdiVi9tRnFBZDNtOVVJV2UzeC9XS012TGszbUZyVlM4?=
 =?utf-8?B?UUxQUmpvRWU5eWJneFhteCtUcFhWVisyUk93ZHdna3BMc0RPeEVWMEVNYVFy?=
 =?utf-8?B?Sjd3dFZ5V2hZNCt4RUpWNm5zYnJUMEk0Z28reDdsRTNzc0pLOUJLRFhnT0Rp?=
 =?utf-8?B?aFdGTmpwM0N4cmlSQmhESXU3K05Kdk9hUERzRGdPVytvalhBQ29NWFdpN3Ns?=
 =?utf-8?B?bzFmdWkxUGlhRkcvbzNlMCtkdjhvTDZycG5VdWlJT2RIZW1NTkt3RjJmUm9O?=
 =?utf-8?B?VWdrNndwUVgwdXdxUWc1ZW9ZaGFma25KeVdzVXp4VHplQUpNOGoxTitaRDVz?=
 =?utf-8?B?L0VodXFKbmpGcTEzRVNEeEExbHNOWFpqa0dmNG5VZHZ0YzdOUWlJUG9oQU9T?=
 =?utf-8?B?YmZKaDNiT05MZVRUMmo2ZU0wK3pXTlNEUGtiVnBHRVNSR0JCc1hHSmp2dkcw?=
 =?utf-8?B?bTBsbm41V2xnSFVORy80dUtmWlZCT1R3T2o1cllTazRmNE9BSEN6bXI5UG5o?=
 =?utf-8?B?WFdzbldoRXdHeE84elk1dDh5dGJTQlpOMG5SenFFck53YlBpeDMrUGN1dWxm?=
 =?utf-8?B?c2cvNHdZdFdXVURyckJDdEdCVURqWFRQVlczRDNNamJXcUM1b21wcTdFL1NW?=
 =?utf-8?B?QTJMU2xhYTJSbmdpNjh2MGw0eHhLUno4MXZlVEJWVGRYMG5KcHA1b1JXbng2?=
 =?utf-8?B?UTlrMGpuNkZXdlJOK2lVdDdCcXlpNnRySGRYZ29QZm54S0ticWdXeUhvd0tQ?=
 =?utf-8?B?K25kblhlelpIMmQ2WWFPY0lleFFBbU8wT2tFK0NlSHdTdVFQbGE4RS9xcUQr?=
 =?utf-8?B?eW9JUmw3NTVYZ0VyV1RMQ3pXejZva1dMclBzWHFMVUxSSDNuYTNXOGIvUnl0?=
 =?utf-8?B?UWZIeFFkMCtlRGhFSGRwcWdTMXVMVUhtME1HbzFJTnJwcFExYXJHcGxNYy93?=
 =?utf-8?B?QkxqaDZmd29VQkJJN3Nydit2aVliS1NVWC9jQmR6ZnM4RG9KcVBlMXZnSk9X?=
 =?utf-8?B?citXNnhlaE92M1FTbFFnSmllaGxiZWswdTNrUXI0ZHRBczBhdEZ5QlJkM0NS?=
 =?utf-8?B?UndXeGNnRHhKMzJoc2ZBNXAvUnRHWVJVM25qWTZ3WGRMYWRFdkNLTjdRS3E1?=
 =?utf-8?B?YXkyUis0Sm03R0s5RHQ4emMzc2JrTGlCMjBKRzZ3WGhKQm95eXRFMmtlWmFS?=
 =?utf-8?Q?LJg5it?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:38:59.4704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fac582a7-7bc1-4f51-fcfc-08dd5c368597
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB8349

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


