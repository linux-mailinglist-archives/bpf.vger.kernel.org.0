Return-Path: <bpf+bounces-53185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB7A4E34C
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1004519C37BD
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87117284B5D;
	Tue,  4 Mar 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="X4jHSUUb"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2051.outbound.protection.outlook.com [40.107.247.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0301FC107;
	Tue,  4 Mar 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101379; cv=fail; b=CkmMSOeGwSm/0UV73YalO7y2CjPgTk6ILrSLKj73RjfJVeqvrbRRuvUZPTg37VzWlHhcPU1bZFIrNXnUniyGSBx1nnGoQAVHlfZhj/dBLoI1R24A9LHUcXCB7L1CAoFwo5iRPTfxKTqfB+5OlGlAJeSQlLEHxybL/Yp6opMOZUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101379; c=relaxed/simple;
	bh=IcX55dvP/zGDr6yhh9y7tjCKqLCsbuDcUxXo6KKZ/TM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gjQ1Ki/WOYB/CyEKHuKMMLNBQZH95iwnbVJlrENgtehLh1sKX+9wLJJyUwMQi0Q9UUUZG0ASLX/MB+vYQRQGlqVWNw/rjMx5uQoYqoZ7YzmoHF32+sAP/RK6+1VCt9zpYUGi1DoSdDNVC2vUPkfNy7aZEzX1IlcHFeDNSXkmrjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=X4jHSUUb; arc=fail smtp.client-ip=40.107.247.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/5UXnMlmtpTEkLKjYWkPms54wX9Es4YrOkuobkrvA4fG1bzkmHhDxo22hYqig0hfDIUmkMHQ7yX7HQosMaCbiIerYaGpYYCSHuZ6vm1uzcWHIxJRDv50yyg/EqJdPBKN8RtVMyLuT/WFsAB6J3DKjHnf0dEvlDkHUGPYu/A/lQRhJj81GnGhB49FFvBZKo9gUgRn5W1AJqzaQ/StFwUqBEIkThh1Tc3/ktbSRX9NE/VTCVm+oeX0ts0JN303AD04r3uds5PMfqpqJ5AgW5VDFpObPXe3/Dk+KgBYcxjwQ8C8BT6jJ1INPM94gxGvfe83o4LvqQRSERsV3aE0x5dhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js+5x+TNDvXRqLgfpHF0jZNZIm55gvrHwAvgX83wkB0=;
 b=VcvkJxyvOwjqJz/hdlNUcLjzno+oBel3+jEC85mjR1C21HLQZm+koSAipSckmRQtCVSi66z3A+0ByH7nMNzuTj2D1w7h0JVWOPSQVKz65OywPp4I4liVMR9nxu3uuyLli7McM8wWi7OJrr/CXHk75ekysOATPjyqZ+zczx26rfRLceMx5LajcR+iOVs3WZ35jqI0SgHfDuNChjTSddkjfS57L4av7HyPTKBi8BoMrhPYJUCVdpDQXKAgyeZMgxrI/idib7gyK0qVSp4/RjorYu2hVIiO8zMykvK4BUxbsgunt+cCC+9UrbzgdMdVoXHFLO8PkeXnFyeIcNCQOtUrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.29) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js+5x+TNDvXRqLgfpHF0jZNZIm55gvrHwAvgX83wkB0=;
 b=X4jHSUUbdDPlKOeWCL64nrZmRvdw2FQ7xkB4abc25td1+I8hkH/ycZUYKj+4k0vfU6ltHnSU+vesrNNcvO3NyUSHUVAHdVQKPjR37diYNT5ml4oQG6apFZFTKglhrEBrdyJv9eROBZw2YIEN/9YHsSLRCBlVpLvRFkFYZsDDhzNbCKMI6JU4KwJyTuAuPBXNOxeCT8B2aBxwexCDbsoMoZuaXauYhODQNX+9+ACWVbOBQ+CfwfAG7hvYpozFhidnF8hgLSNvshGqovfdvIkdJX4I7pfF9WdxyDbuwHNSyWgNFl1SeSj328RZ6o0CP1eAZ4zsf+tXZVAyZFceK0sVcg==
Received: from DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) by AS8PR07MB9110.eurprd07.prod.outlook.com
 (2603:10a6:20b:568::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Tue, 4 Mar
 2025 15:16:12 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::b8) by DUZPR01CA0049.outlook.office365.com
 (2603:10a6:10:469::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 15:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.29) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via
 Frontend Transport; Tue, 4 Mar 2025 15:16:11 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id E0E602118C;
	Tue,  4 Mar 2025 17:16:09 +0200 (EET)
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
Subject: [PATCH v7 net-next 00/12] AccECN protocol preparation patch series
Date: Tue,  4 Mar 2025 16:15:58 +0100
Message-Id: <20250304151607.77950-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|AS8PR07MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce61420-dc27-496a-aa28-08dd5b2f7f80
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SjNERHQzdjBLdTNVNmVSQ3dWbjVoV1hwT21YSHFMdjh0RFVmYXNlSmFmYVBp?=
 =?utf-8?B?cU9UNlMzZnhKcC9qTnFpTldZUGVySjVTM0hvcWV5a3dJOTBtVlJHMUxVZXN0?=
 =?utf-8?B?YmQ2Y21aWDBhWmhPd09lZDNzeUVFeWdxeUVGQnYzNWt2NWdBN21BdFFFdzM3?=
 =?utf-8?B?d0U1UnFIa1IxZFN3T0M1K1c0akp0SnJ4N0dEQ0IzcUMrUFJ2QkNIR0FLV2Jl?=
 =?utf-8?B?YTRjdmVjY1d4QXppd0lFOEdRNmp0YlNzazhUdFltQjBhRkpNNU5wUTRLMGhX?=
 =?utf-8?B?dy9mQkQxdVY1cTRyYVhiNVhucWpsNnllV2FDVDltWUxsK2FrbXRJZXVxa0Rq?=
 =?utf-8?B?aFR1czg5Z1g2dUc2dWpWckFUYi81eVFKUm1PSGxWWnpYbkZ1YlY5YTN5ZURK?=
 =?utf-8?B?cUQxM0hsU1N1MDd4OHRqbFYwUmFkeUZYTTl0bW9DOHRvcVM2WDNHbHJmMk92?=
 =?utf-8?B?dk5zNlpsN1RsbnVVdlg5UGVsSjN3ZEtHR21mSjJJeG5SWG52UnFIRU9lVHFG?=
 =?utf-8?B?N3I4bUhtTEMzdGlYd1JwdjhOTXlhZkJRQzFJdk5NRkU3R2dWUy8xb2tWQnlu?=
 =?utf-8?B?S1JHYzNRZUpVZ2lNaU5pWm1YT0JWeXRHbWhEb1hWWmRrNDdiSWtpOXpzYk5N?=
 =?utf-8?B?UEw4UTBINEM3UUNEQzBVUWZNTElBeXRsaG1lVmp0YnNONjNmMllaQ3pnQWk0?=
 =?utf-8?B?VUZiRURHYk1SMzZnc3I0SWROb3VzdGVuOHA5a0VSaXRqTDh1NDZSOVJUa1g5?=
 =?utf-8?B?cllReUZPeHpzOTRxTmtPVy9EZDdDUjJGUTNSTTA5dEoxWXFXYkYvamZINlJx?=
 =?utf-8?B?YnFyL2JDd1N1a1ZqUW5SYWdiK2pJK3ZBMkl6RUFMWE16SWd4dmEzclhhazF6?=
 =?utf-8?B?dG45MUE1SWVSY1dwZU5VaEMxM2FGQ3FNamxDNXNxaFlJcmhGd1d4OXRkV0Ra?=
 =?utf-8?B?czBoNlZMUXFGMWUzL01ZVGZ6bU5SMUJIRHVBT3ZCUmY1TVdJQWtPUnhZY1ds?=
 =?utf-8?B?bHZXYzBiN2pGMUEwOU44Qjh5dWs0eXp6MlFWaUsrYjhFbXZRdkE3a3Z5Um90?=
 =?utf-8?B?eVc5SHRjM3Y4bk5QLzFFQVovRFlKLzU0ZTRIdnRCejBONWxzbnpRMDFQN2tR?=
 =?utf-8?B?T1Nvcm5yWVE2VlZoYm84cFJDTW1PYWhrM1h1RnpJSHRQaWpEMHR1cXFXUTBI?=
 =?utf-8?B?WUY4QmgrOXp1b2s2c2JCM0pJTTdDZXBQazJmUGd1MXVkanVRNDFSSWpOM0RO?=
 =?utf-8?B?dE90aXhENERXd0VaQm45RlNtZWpZMk5tR2ZBZ0JiVHFHZGxPT3JRS0xWdEpD?=
 =?utf-8?B?Ny95YjJLU2tQaTNXSk1ScVljdXhnS2ZLUGVpMjdDR1I4emdzRkNCQTZQY2Vj?=
 =?utf-8?B?M3hKQU5VKy9TbktJamRlVTkwb2hoeW5ZT1hyQ0Y0aXozZFFYeXN2cGN1bmxW?=
 =?utf-8?B?MTN3QzJMNGdLZUZEcmxFYWJsTXdzc0VXckZYQjB2Nm10MWxQTG1zQWpvQ2Ra?=
 =?utf-8?B?UzBrL09IVkNXZGFyVkZBTXVRanczMTAvVkNnS1Jhb2FwOXZBZU80RnBoemox?=
 =?utf-8?B?Y0J2ODNXcThYZ2oyT3I0bFhtaVlNVGZtOFFkQ1hVVnJQbXRyeklKT2p6WGhG?=
 =?utf-8?B?VTdRcE45SjIybmREalVER09CMkVLRHo3N0xsZXJNSUJFUy9SQjVrZ2E4c01W?=
 =?utf-8?B?eVZTS2R1Ylk1U2Z4b2ZyeldiTjVBdm1iNURZOWZnN3dsMkVvdktnK0QzRTQy?=
 =?utf-8?B?N2h6eE5qMnVqSmlYVFc0ZXE2OEhlSEpBc0dQaUxSc3Z2UzVpYXdsb3ZpTXdU?=
 =?utf-8?B?SWFPWk4wZkFoeFhabWdUajNhZ3VCUHNsTWZGRGtFdkNSbGtJcWN4WE1qYktj?=
 =?utf-8?B?UEdBbElkYTh3eWwzQ3V0ejZBN05oMXE2dHNuZlRESE1CaUR3aDAwaTlsOUZU?=
 =?utf-8?B?UmZXL1FSeVJTTkNwNmxYRk1yak5DaDRlRSszSGtVZVBoRUJGYmMyMzc2UW51?=
 =?utf-8?B?YjhYVFdWWG4rZXpxY2RXaEx5dDVKTElLTzJoeGFqdFBmNEJCbklTc3k1cUg3?=
 =?utf-8?Q?oKd0eV?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:16:11.6113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce61420-dc27-496a-aa28-08dd5b2f7f80
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9110

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v7 

v7 (03-Mar-2025)
- Move 2 new patches added in v6 to the next AccECN patch series

v6 (27-Dec-2024)
- Avoid removing removing the potential CA_ACK_WIN_UPDATE in ack_ev_flags of patch #1 (Eric Dumazet <edumazet@google.com>)
- Add reviewed-by tag in patches #2, #3, #4, #5, #6, #7, #8, #12, #14
- Foloiwng 2 new pathces are added after patch #9 (Patch that adds SKB_GSO_TCP_ACCECN)
  * New patch #10 to replace exisiting SKB_GSO_TCP_ECN with SKB_GSO_TCP_ACCECN in the driver to avoid CWR flag corruption
  * New patch #11 adds AccECN for virtio by adding new negotiation flag (VIRTIO_NET_F_HOST/GUEST_ACCECN) in feature handshake and translating Accurate ECN GSO flag between virtio_net_hdr (VIRTIO_NET_HDR_GSO_ACCECN) and skb header (SKB_GSO_TCP_ACCECN)
- Add detailed changelog and comments in #13 (Eric Dumazet <edumazet@google.com>)
- Move patch #14 to the next AccECN patch series (Eric Dumazet <edumazet@google.com>)

v5 (5-Nov-2024)
- Add helper function "tcp_flags_ntohs" to preserve last 2 bytes of TCP flags of patch #4 (Paolo Abeni <pabeni@redhat.com>)
- Fix reverse X-max tree order of patches #4, #11 (Paolo Abeni <pabeni@redhat.com>)
- Rename variable "delta" as "timestamp_delta" of patch #2 fo clariety
- Remove patch #14 in this series (Paolo Abeni <pabeni@redhat.com>, Joel Granados <joel.granados@kernel.org>)

v4 (21-Oct-2024)
- Fix line length warning of patches #2, #4, #8, #10, #11, #14
- Fix spaces preferred around '|' (ctx:VxV) warning of patch #7
- Add missing CC'ed of patches #4, #12, #14

v3 (19-Oct-2024)
- Fix build error in v2

v2 (18-Oct-2024)
- Fix warning caused by NETIF_F_GSO_ACCECN_BIT in patch #9 (Jakub Kicinski <kuba@kernel.org>)

The full patch series can be found in
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

Best regards,
Chia-Yu

Chia-Yu Chang (1):
  tcp: use BIT() macro in include/net/tcp.h

Ilpo Järvinen (11):
  tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
  tcp: create FLAG_TS_PROGRESS
  tcp: extend TCP flags to allow AE bit/ACE field
  tcp: reorganize SYN ECN code
  tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
  tcp: helpers for ECN mode handling
  gso: AccECN support
  gro: prevent ACE field corruption & better AccECN handling
  tcp: AccECN support to tcp_add_backlog
  tcp: add new TCP_TW_ACK_OOW state and allow ECN bits in TOS
  tcp: Pass flags to __tcp_send_ack

 include/linux/netdev_features.h |   8 ++-
 include/linux/netdevice.h       |   2 +
 include/linux/skbuff.h          |   2 +
 include/net/tcp.h               |  81 ++++++++++++++++-----
 include/uapi/linux/tcp.h        |   9 ++-
 net/ethtool/common.c            |   1 +
 net/ipv4/bpf_tcp_ca.c           |   2 +-
 net/ipv4/ip_output.c            |   3 +-
 net/ipv4/tcp.c                  |   2 +-
 net/ipv4/tcp_dctcp.c            |   2 +-
 net/ipv4/tcp_dctcp.h            |   2 +-
 net/ipv4/tcp_input.c            | 120 +++++++++++++++++++-------------
 net/ipv4/tcp_ipv4.c             |  34 ++++++---
 net/ipv4/tcp_minisocks.c        |   6 +-
 net/ipv4/tcp_offload.c          |  10 ++-
 net/ipv4/tcp_output.c           |  23 +++---
 net/ipv6/tcp_ipv6.c             |  26 ++++---
 net/netfilter/nf_log_syslog.c   |   8 ++-
 18 files changed, 228 insertions(+), 113 deletions(-)

-- 
2.34.1


