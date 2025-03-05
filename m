Return-Path: <bpf+bounces-53413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F416EA50EB3
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375FC3AD02C
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F0D25BADD;
	Wed,  5 Mar 2025 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JAx1Js6f"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2067.outbound.protection.outlook.com [40.107.103.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71281201266;
	Wed,  5 Mar 2025 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214343; cv=fail; b=GQp2u0LxOoepneQTCbbCU5KWqOQbx3cyAIWb2NbKUNvpo1ZHvapTEHg8pt9VXlxeyE69LZB3n12deAwgA9NBq5HEJV3Zj/drAgsrLBLdNTkHLQwWxOa5KHSYUPnwmprR0gCV1/ig4Y0DzDStyvKPpD7Qsh1SK1QbdV5h+QmRzqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214343; c=relaxed/simple;
	bh=IcX55dvP/zGDr6yhh9y7tjCKqLCsbuDcUxXo6KKZ/TM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m7IvD5eNxVDdLkfQzjr4qW9r0OCs3n3sJKgLYDrwTkKzbNIpLl2FoMXEmt0GW40Z7jtYPJZ+FsP7gcFSrjFr4ZSh68ky4S+BPdLh5jUY6EH+6v5Nq2XjqGkOxsOD6KV/h2ofibF6cWjSMu06+4wUbRxNVv9C8iP8XDn1v1Vat14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JAx1Js6f; arc=fail smtp.client-ip=40.107.103.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3G00JdHrT6srCy3KgFvODOC9x/CVCC5kI++E2ILuBE5la+EOFbFLtk6nhLDpkIJEPTOAoE0UzKasbyqvFbImxfGPqQpQa5IqvtCOexZTHXKqkATxBfaWwHsFlcdfxrtPUfhsXupnpzjxiZzegqiIk5/qTCW223kyUHgGzuYKV3+EAqhH03GoM4KXr1DX3Xf+N+RzzeyX2/JxHoiqXnFJ6Ke05XtbT6gHUOgnh7gkksSIxLkKaKZ7kvplqRXVoZD8ewQTCB+4pwtuPIDKalAhkT2VXI9FmS81LJt4i7f52ihRRMEd/HiSeG4Vc+d8CJsADlsZJONft/wbp0QJ6MM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js+5x+TNDvXRqLgfpHF0jZNZIm55gvrHwAvgX83wkB0=;
 b=eTAaWtBkJgRlXBWGaZHPFqtKC4esBotYl4D8BrvZZaxVhVYP9MA3zCCtLAP0byrgLrwVVH9k64oWjtNSGI2mmL9Vbezx4F6BOkK0p2pxi/IJfnvvq089wwlW0XAc8jwp/qv4WGMW6Ug7qCLHptkCi40+qIQMoRvFARhPB/oMcBNtbAARdDRITsXDLiQpWDvWp4K/H2ZgtGW6qg6rqfxynfjAmabs8GorOeTCrSb7oPywEhr3FPt6ckaAV6GF0SHVit1FilajN1AWj4336ora0cKSdVNk6xlQjaF3HxTJxOjpMUtx6i82oah3pjWy3UdbQ7QH1qJAIzkclCHhVE8LNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js+5x+TNDvXRqLgfpHF0jZNZIm55gvrHwAvgX83wkB0=;
 b=JAx1Js6fS0YvsfzQYNJEB7A4jWTVGTnY9LpHc6PchxxzxcxemxyaqxWaY5Tu38D079wdtKdsw+Hl8LimHKETmRrTMQEz1DHCn+z6RDiGAqsuUp+C7gX6x+FPQ/L+HPB2si80hRQu7GeJWJUxpJ8KCc61HfjWAwDyRLhfSSGi9k7WlkAqdj75IMw/U8AjuN6XKeie+v6zEBvqdICpF3a3O+J15GRxAtz3BS1f1xuPUapYLg+txbi9yWQJUkBbECHna1Vu+bqtdSYKgwNlruSdFY+7HhalicJSeYE/3N8aTsnkKq7WQrWL+e/drC/qeXlGpu9FmginvTOQQ2c4fNX4Nw==
Received: from DB7PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:10:36::25)
 by VI1PR0701MB6816.eurprd07.prod.outlook.com (2603:10a6:800:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 22:38:57 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::22) by DB7PR05CA0012.outlook.office365.com
 (2603:10a6:10:36::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 22:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 22:38:55 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id C3DD7215CA;
	Thu,  6 Mar 2025 00:38:53 +0200 (EET)
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
Date: Wed,  5 Mar 2025 23:38:40 +0100
Message-Id: <20250305223852.85839-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|VI1PR0701MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 17055bf0-1842-420f-2268-08dd5c368341
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YU9vK0N2SlJMVmxZRFI5eEhvTlZnMVZXN3Y4RytwS3VQVjdsZFVPZ2pPelBX?=
 =?utf-8?B?M2VtOHoxRFc4NXcyU283Z2pBdmpIb1Q0TkRYSzdqMVpHczFyWU9KZUNRU1Bz?=
 =?utf-8?B?bGN1Mkl2MXZYeDVaUy9Kck82ZDhqakU5cm9NRUpUY2kyN3FxL2xkQVdUQ2ZJ?=
 =?utf-8?B?Tnd4bVBmalhiYnYvdjhGYVB4ckd5ZEM4MENwdE1DZFlqbWRnS2FMWjNSQkQ1?=
 =?utf-8?B?MVNvSWFGV0lLTXVlbzh2bExZNUVmUkxnMlpyd1p5dGw5ZVdicUtLQzk1MHQ4?=
 =?utf-8?B?cWtqUnVjT3RxdHRxTDhxWTFKUHJXQXc1STNDMDR2ano3TVhFOE9NZGN2UHpN?=
 =?utf-8?B?enVCSXpoQk1SMU9YWXNkV2p5OGRXM0Y5SkZBYmgyaHd1MkQvT2tQR21XMEFy?=
 =?utf-8?B?dFVPcWJwOGVUZnU1cEtrQ3lEMWszUTFoUFBrVEpKZzRvVVYzelI3cFdhK3Ba?=
 =?utf-8?B?ZVFtbFgvSFc5aU5reWlIWTM0UDdJTlRvcC9ZQUg2aVpKTGdEZUVRTW80QzJN?=
 =?utf-8?B?MjNPVUtabHNDTkluZWlqZEFTcWJ5L29FZXpzV3YxRUs4QUxHQm9LV3o4ekVQ?=
 =?utf-8?B?cWRCb0VPWDBFOU9wcDEyLzdrcU5JWE9ReXlBZDdXTk5RVkhpbVIyYmQ4dWRK?=
 =?utf-8?B?ZVdHcnJFZW4xSjd2V3dyb0VxcGhvQklGdVdtRFBHQXIxUTNPOUFtN3lRbjEx?=
 =?utf-8?B?QjVTZG82NWg1alJQak9QK3QxMDFHOFg2SFRuMG9xMFpZdFJyRGsrQ3FRRHdU?=
 =?utf-8?B?QkVYR0NpL3ZORTJJSTdCQ2ZBYTJWQ0wzK1NBQTRIdndqUWpVeG4zUmpmb01D?=
 =?utf-8?B?NVRlTnk3REh1TE56Y3RVVlZzck5nQlBjeUx6RHJmRjBFV2xIdTFkejdwRDIv?=
 =?utf-8?B?eVV1d0tVcVkvY2R4K0NGa3V6NExCUFFiU0xOeCtPeU9vU1BUT1I1all6MUNO?=
 =?utf-8?B?Y2c2cTBUUUVSL2kwTXBaSkpLN0h5aDBHQlNVUFRNTWZTdklWYSs2cExtZGU4?=
 =?utf-8?B?Z1YxSVRYSnFSSytpbFlpTG5tN1BZN3JiZVpTUU9sQSt6a0ZjVVFPM25WN3Jn?=
 =?utf-8?B?dkVLNS9wckZ3OGM5dEROdy9POWYzb2dGUDJocGdaOTNPZHB1VEhjNmZtTDhF?=
 =?utf-8?B?TjVUQUFadDlOeDRCbUt3RlBGQjNKUVA1dXF2cXBjZUJpaG5JeTNWL043T1Jj?=
 =?utf-8?B?T0Nvb3hjdXR4L2FQVU1pa05Ib1J2Z1RnWkZBc1pmSVhiSmdyS3JqbWNKeGx5?=
 =?utf-8?B?MDUxKy9USGN4MWFWakloTTlua2VrOWNMbFhaamM0TnBwb1FQNm8xakJ2R1M5?=
 =?utf-8?B?bmFyek5OUTBxdmRZVkVIRjBOYmpnREo0TFBzR3JYRGVZR2RiMkc1TVk4QjVV?=
 =?utf-8?B?Y3hnb0tmOEJDdFYzbk92aWVXRG9seDJEbzlRc2ZiZmdvUVByajdaL2dKQi9Z?=
 =?utf-8?B?aTltMHcvT3BVY3dCQzRURndnTXRZNVVsVjlOM1UwSkROT0N6TW9QU2x5RFRC?=
 =?utf-8?B?QVRPYWxTZVBJOHk2bEVmdGxiblhidmp4eWk5TGQwY1g0amlGd2kzakl0aFZM?=
 =?utf-8?B?TmZNbzBUQnk1ZzQ3QjRVWFMydXU1a21jYlRQclJoWE1FNzFYNkpXN04wUXE3?=
 =?utf-8?B?TXBwRjYzOC9SWDM1Y1hGK3JuYjlxOHJtMm8vVnJmQ0hkMGIyMWZ3L05pWjhG?=
 =?utf-8?B?MHZheFhoUm1uNmdQMkhhZ3NoQ0FGanZrTCtrN3NTdjNpOGZCN2VKVmswaUs3?=
 =?utf-8?B?dy96aVE2ckkwVEFsMWIvZzJHcU5BdWZVQjdidjdISXdOd0NQRXFwOXp1VHVn?=
 =?utf-8?B?RkJYL1BNRzRhajBDK3pmd2FTbzJ3dTBFdFhKRkNuV1hQR1VMZmthOUZFUXY5?=
 =?utf-8?B?L3V2V1lwMWo4Ky9tc0xkSkk3aU0rTWQ1Sld2T0pBTDlwR09vNHlwb2UyU0Zx?=
 =?utf-8?B?TFFDUE0rU214Tjd6V3hoYWNOZGMveS91cW90Y1FWYkkyWmhPcHM3SmN6SE5G?=
 =?utf-8?B?bFBjU01nNTRSSzZpKzZvOERPNEhqeFR0dFV2SXd0bmUzY2VteEdhaEhJbU1K?=
 =?utf-8?Q?6WpR2g?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:38:55.5458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17055bf0-1842-420f-2268-08dd5c368341
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6816

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


