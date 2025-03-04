Return-Path: <bpf+bounces-53208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A91A4E909
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15A48A3C3E
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD9F2BF3E3;
	Tue,  4 Mar 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="iBnG1Fvx"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2088.outbound.protection.outlook.com [40.107.103.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35DB2BF3C4;
	Tue,  4 Mar 2025 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105852; cv=fail; b=o+FbSRMMd7G2OslZitvb+FrkCI47jq5MRj6VzF85HQXhdVAvtr5bbLxxKTKhMYJZKYWy+xo7sQ1YhLc3ta4gfX/A8EiXDyA0uw+OR6qrWBsDv+OctKuvxTsKwv2l6WbnLt47/vXqyEsLN02QRJ5wt7LRy3TuwGw0c+Mjl78z58Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105852; c=relaxed/simple;
	bh=kEMTwggpvfj6X3uqQrKG1E1SLaMV3zClTNLGP11BQNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKE24/BM5ED9YuLirFBE2rP/HG4SQ2W5sSjzsosvoE7fMyVQfhXDXtI1/6RhihC+3EJQ50g7v1qhW57Uf2stYNW14u5PRHNGeTdwZ+wdoKqd7El+kWCy+d9wQ1ISwgPNKySaJDl+8Au8xA+Rcbs1pIGYfAye2bovMMJIhZZrhZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=iBnG1Fvx; arc=fail smtp.client-ip=40.107.103.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W01YruzWoqWoPRIyCUo4uxoBiI1JIqIVKfIxl8kItQ+y7+ClLloc+a21RdqjJWGqfaMYPsTvFHm2A7dJTEmfVwjMLVNLTYrnEq72/krRbFYz1a3u40MKizgr0g2M0dVlaLYnV4/AWcMJlcH0x50rq2YPtz4q3aZOsL95I6UCtWvo4iBl6BOTvHL07yH03zABgQZOM6e/9n65A+1GsURTvVm2rqNN3FHVoeytK+nq9p9iZ64T1PnqkE/iVTmUCP6uTNWr7HFCObGdi/AHcjIa8ZTx6KlGevJ7GCCnUMqWClnF6+BQ/oiqSjNycjcdexiXQt3Eg37wXQAOM0zxmMc4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMB3e50qSo7+nFbyvwRwn06pAAVzB+09EnIvXQDF5uk=;
 b=RXIH9+YdXEaWsRfMMP0EShFo5RFRcR0rAofjn7NcHuSHX+JRhjVPkEVIhUr/KkOuDfQR8Ptc3J9aOVytwbuuP+ltP8HgCQtNaQKmFJYJMNXv646LaTUkBStimbeufnlncTLKb0kcTuKNVqmEx4PMbEX9j+YrxbRDUajBRXfJG3KlBXXQaT4ljQGqIY7u+hDhIOq3r/dZs6hTXIgrSTLcjRFL6ku3V43cAWmG8VrcTVbVYivHEB516/iWzVCoa7Liw/2mOqJblSPKZqjgs7R50cE7kDwcD2DYu3asmr+FXkKxpxa6TxTWScyhWof8Hs4SJ8TDT4WSFoTom91Llx+Apg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMB3e50qSo7+nFbyvwRwn06pAAVzB+09EnIvXQDF5uk=;
 b=iBnG1Fvx3SufRcnT8e8YxQ1VXFmex5U+jKLPok82QpSs8Ct1UiECp9PIiQD66bmep2tdnuGw+/PpvtWTqxGHVAT7LHpTiqXvxffyV07a8wIZxaVjyMAxH1CDUAR4ob+zI0i9oGswmy7+a3vSkLQXu01bumJXRUuXuKd6Kok9On9u4ReM2WVDz940ubsku/WmgiE8tl5d7OX3wzn3I5re7uEzWeEl+mru4XIB8n7TEW3PpkTFgfqyoQecO+rN67WG441kzb9qU61e9yBL7L2GjwddpV6DPTUbWPToL+ahiSLmsx5jXYxuqhPPlI7UbnVMaGuW3ZUEePyvSfMrLX9pAA==
Received: from AM0PR04CA0122.eurprd04.prod.outlook.com (2603:10a6:208:55::27)
 by AS2PR07MB9183.eurprd07.prod.outlook.com (2603:10a6:20b:5e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 16:30:45 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:208:55:cafe::c7) by AM0PR04CA0122.outlook.office365.com
 (2603:10a6:208:55::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 16:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Tue, 4 Mar 2025 16:30:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 97BA924A54;
	Tue,  4 Mar 2025 18:30:43 +0200 (EET)
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
Subject: [PATCH v7 net-next 12/12] tcp: Pass flags to __tcp_send_ack
Date: Tue,  4 Mar 2025 17:30:39 +0100
Message-Id: <20250304163039.78758-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C709:EE_|AS2PR07MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: da4a72b0-a10e-47d2-c0dd-08dd5b39ea03
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?azVjS0REbXQ3OXVUbTJiZlZpNnRsNVQxd3ZEQUxJMlkrTFZuUWl2dEtBQ2hG?=
 =?utf-8?B?eWxoL1RJNTRiL2VPYzhkOTNoMVFRUUtQeEZBWFRIeCt0emVnOFB6YWtXL09M?=
 =?utf-8?B?Z0VJODZzWlZ3MEhZclBIVEdkU0orcXlLZXk5SVBZVlJsbjhjZUllc3ZtMkN5?=
 =?utf-8?B?TVdmNXVRVDZjUmZ5STE1emFaMHkyK2g3Rk8xRXBvSTN5dTgveXl2VFBzd3N4?=
 =?utf-8?B?KzFXVnA3cEZ4bWxWeFMrZk9CZlNKZS9nRXo5ZHhGbnBZdGJzbDIvZGpvNHha?=
 =?utf-8?B?MnlnVUhnOCtCTEhId0hnTEVhMTZCczE5cEhCcXJTVnlkbVRLemREb3JiVWtz?=
 =?utf-8?B?bmp0SjNNeEF6KzFOYlh6ZzNmRGl2TkgrZFczSzZyUC8rbUdBNDIxcnFXZS8y?=
 =?utf-8?B?cFpVUmNNbVRuVy9HekNzR3ZPeEFueGRUc0sxSng5K3VDQk4xaFBQUzl0YVhC?=
 =?utf-8?B?cXRFVFl1SGdtWDRPQnpoa0tCZms2UGwwTFVGK3gvU29OY1ByeUJ2U2hkM0Y2?=
 =?utf-8?B?RkxxMWU5bWpjeHJjdTc5V3VZU0VodHk1Z29IYWc4V2lkaFgrd1hXNCtacGcw?=
 =?utf-8?B?YUVxTDdSUjVXTXcxcC8xYXVkSU5SVURHOUkwWFl4Z21tUmExbmhGMmFHYWNG?=
 =?utf-8?B?VldqVGVFb3BkOVlsL0lPc1dGTG1EMHIrZkF6eEpSUzRoN3YyY0pNaWpPckJy?=
 =?utf-8?B?TGk1SHpqZjVpYnh1K3RaYVQzVlRiNHpiSGNiWEFXSkxJdkNyWWc5ZEpGUDJz?=
 =?utf-8?B?eWxVOElsU0MrU1IyMXVWQjFoeDY2cDhDRm5odVMvWnNDQnhJU05xYWh3SndU?=
 =?utf-8?B?UDhaZjBIQndCQkkwdG8yWGJteGppeDBUNERwaTg3WHlKeVhDKzNrWnladk5p?=
 =?utf-8?B?dWN0dEUvY3AvVEtVdjYwY1hSVGNDR0YwWGhPK2FRdCszMWZ3bVhKMlNQeFFD?=
 =?utf-8?B?QWFLYnBCUWNWSXdXS2o0ckNQUkxyZU5wYm1mdWhodDF0SFNnYkJUbzVQSnRs?=
 =?utf-8?B?d0xUYTh6QU5mUVU2Uk9pRHk1OEFEZy9hS3VubEVCMks3MS9LMVd5TFU4amh0?=
 =?utf-8?B?TXZydGpTUUVTTkJvdVRqU2xCQk9GV1RXZ2VnY0M1L0JFck1rYTZuditFcWRS?=
 =?utf-8?B?U1g5ZWkrdmtDRVR3VzFSd2xSa3NCbUw2Rm5YQVNwV3Q1R3h2SkdpUUYrUlBY?=
 =?utf-8?B?ODQzTEFlcVFBS2wxRmRLM0htUkFlOHNSVGZ0SXlmSjFET0RoSWxwSjJ6MG1Q?=
 =?utf-8?B?UlhuOTk3NEtRa3dtanpGdEM3Q0dxYUxZWFBiRWlKOUE4THBlT0tVd1VsWTE0?=
 =?utf-8?B?YWlUc2xtdFdlN0FXZzRCcDVCNkdCRHhwZ0lmS2JUR3lFS0ZSM202Y25vd0JR?=
 =?utf-8?B?WC9rNStzdmlNbnpzanNKQjNOanlsSXEzWkRGVHNKemtzNTVJcHIyTUwybk1p?=
 =?utf-8?B?cG5vY1kyTGFiSEQvRUtaSlBNdWF0ZDlHais3T3JFUzFyOHhzcjhlaHJjYnVV?=
 =?utf-8?B?TTkybjlLM1pVa2pNakdIY284WjYzeU9EWVovU01HWUJoV3pRY1A3c1N2NERW?=
 =?utf-8?B?blhoNkxMOTVsMTE4U0tvS245S0FMaEorbndUY0l1Vmp6VmtubU5LVW9LdFJy?=
 =?utf-8?B?dk5lcTB4UUdDQmhVUkNvaGxhNmo0ditYeU1aVkNSa3VWWEZJS1BkS3NpYWx0?=
 =?utf-8?B?Q1E1YWN3bTdjVzBDL2xCdk1XbzI3Mk9aQUJtV2I0R0pHTElyWnRMbjBZb05S?=
 =?utf-8?B?MmFkK3VvMU03cngrV1ZQa2FGRnM2djRadzRBdHpPNkR4V2k1UHc4N21DS2dv?=
 =?utf-8?B?Ui8rWDZweW80UEJwanlUcmNDekcwb1BvMnFuWkFwTi9ETm9Rd0xzVS9nZG1P?=
 =?utf-8?B?N0dPVXcwL0ZnVnprLytpR3hwVlBwWnFzalRjSWJleE1GVXY0VDB1d0xhOGtY?=
 =?utf-8?B?VVE2QWFvbzhnVGdaMDVvaGZYMWNLbE1KSGZhV3U2ci8xWmU3M2p1MkhuYVFY?=
 =?utf-8?B?V2pIOTdtSk5mVXY2dElkVThUZWxLZC8xZGlWSTRhTDBNOXVscUJ6aWFLc3RR?=
 =?utf-8?Q?L3zPa/?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:30:45.2450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4a72b0-a10e-47d2-c0dd-08dd5b39ea03
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9183

From: Ilpo Järvinen <ij@kernel.org>

Accurate ECN needs to send custom flags to handle IP-ECN
field reflection during handshake.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     | 2 +-
 net/ipv4/bpf_tcp_ca.c | 2 +-
 net/ipv4/tcp_dctcp.h  | 2 +-
 net/ipv4/tcp_output.c | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3b9b3cdbc0cc..297aeca9109e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -707,7 +707,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 			   enum sk_rst_reason reason);
 int tcp_send_synack(struct sock *);
 void tcp_push_one(struct sock *, unsigned int mss_now);
-void __tcp_send_ack(struct sock *sk, u32 rcv_nxt);
+void __tcp_send_ack(struct sock *sk, u32 rcv_nxt, u16 flags);
 void tcp_send_ack(struct sock *sk);
 void tcp_send_delayed_ack(struct sock *sk);
 void tcp_send_loss_probe(struct sock *sk);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 554804774628..e01492234b0b 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -121,7 +121,7 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 BPF_CALL_2(bpf_tcp_send_ack, struct tcp_sock *, tp, u32, rcv_nxt)
 {
 	/* bpf_tcp_ca prog cannot have NULL tp */
-	__tcp_send_ack((struct sock *)tp, rcv_nxt);
+	__tcp_send_ack((struct sock *)tp, rcv_nxt, 0);
 	return 0;
 }
 
diff --git a/net/ipv4/tcp_dctcp.h b/net/ipv4/tcp_dctcp.h
index d69a77cbd0c7..4b0259111d81 100644
--- a/net/ipv4/tcp_dctcp.h
+++ b/net/ipv4/tcp_dctcp.h
@@ -28,7 +28,7 @@ static inline void dctcp_ece_ack_update(struct sock *sk, enum tcp_ca_event evt,
 		 */
 		if (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER) {
 			dctcp_ece_ack_cwr(sk, *ce_state);
-			__tcp_send_ack(sk, *prior_rcv_nxt);
+			__tcp_send_ack(sk, *prior_rcv_nxt, 0);
 		}
 		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0d275ee68a1a..124b2e95bb0a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4241,7 +4241,7 @@ void tcp_send_delayed_ack(struct sock *sk)
 }
 
 /* This routine sends an ack and also updates the window. */
-void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
+void __tcp_send_ack(struct sock *sk, u32 rcv_nxt, u16 flags)
 {
 	struct sk_buff *buff;
 
@@ -4270,7 +4270,7 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
 
 	/* Reserve space for headers and prepare control bits. */
 	skb_reserve(buff, MAX_TCP_HEADER);
-	tcp_init_nondata_skb(buff, tcp_acceptable_seq(sk), TCPHDR_ACK);
+	tcp_init_nondata_skb(buff, tcp_acceptable_seq(sk), TCPHDR_ACK | flags);
 
 	/* We do not want pure acks influencing TCP Small Queues or fq/pacing
 	 * too much.
@@ -4285,7 +4285,7 @@ EXPORT_SYMBOL_GPL(__tcp_send_ack);
 
 void tcp_send_ack(struct sock *sk)
 {
-	__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
+	__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt, 0);
 }
 
 /* This routine sends a packet with an out of date sequence
-- 
2.34.1


