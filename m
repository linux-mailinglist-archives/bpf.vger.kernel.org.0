Return-Path: <bpf+bounces-64989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72141B1A164
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 14:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214FB1885FB2
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77192594AA;
	Mon,  4 Aug 2025 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ozHlFHMM"
X-Original-To: bpf@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012028.outbound.protection.outlook.com [52.101.126.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2612580FB;
	Mon,  4 Aug 2025 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310469; cv=fail; b=NlMHrPFz+5jhlT+TSVK2eeOhLvisJAl9la6+XYmqoc+dJzrEbZoLF3QZxe8Bg+V5G/5EOGaEgNlx8bJFyHlZkSOS2eqaC72q9wB5sA94KW8fobvurBn4g500tzoqf1WR8nJfK9guAFpaKvAcHxNF4I4g0f1ShZm+9WqrnFL1AIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310469; c=relaxed/simple;
	bh=iT5OfO1HmnmjdePkIv8Ir/9h6ZgUaEgQIR7LC1/JfBU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nW7/txXzh1hcqNarWgrDVdtgMyPQ3RKqt2xKPCoV9hE6GYUEsWoVprJ9ouLCGN9WKGVa0lZMCEx5gQBi/2NFqYedh9n8bLNqnIi5Vq3SGziCwD7brRL0S4WG/GVAgjeSU0JberUI64X7CkLZufU3+k7wtiYhyINm9+8YmI8H5NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ozHlFHMM; arc=fail smtp.client-ip=52.101.126.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tB6fJOohREy/kbuE0nl+7BPAICzEjVEwT9Y/ZDRk+XQ65tEJ3+yugksAp/U66t6HdxWk6xS29bX0ntcbDzFgIJGH6srPBf0wXga/ahMIqEDEYlZKLdbQq7OjrreciBVdNpNb2Zogvb31Zw2qRwQJCORcuw+BFyPqIuQdEtzcr6G0/KF3wa9FklFNOYDryZaDwRTTPbCLfMoGgYaD/CVDL9uRqMP34s/BrhWHqXOAAtP5MAZmkLqoa3yNlYQGUrxjnMkjnX283gkdxpZJfZsG2545qDI1HzS++UrSrxbrxs4Rs1aSSwouxtj5lN6UwSObts37Jcbr1rbp0EgFFo5zBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxIHh8ACv8r+2FUxhwnGJEy4IJ0RJ9qF+MsPIGuGNtE=;
 b=aSAyWEPgJBJxBQDJCK4JvldvBIB0503rYvb8n0Vhcs05bRquOY8PUppthxKCOYY1L4ml7NvfcR68VeGNJxA/ZozpkfdbVWgg84yeKy0YTue82Mx4V2MVeR107o4Qq2RuG4DBOmTdBEUKro48RRIsy58RFeveyqiao5NuH5/gSBhjlYr1mFFHY/UVN0H7AZcPTHyQZ3d0FX3neh6sqqd6/QlyRboL5r55fGniwVcQzfASJGDk3qdeDmOXr9CMWSeo21t3LEs0dHhOZCBeeAnZjxdYkAssOEN9wkQmLVNOfDSOCCucDurZol4g+tFPw0d09NE3xRLdr9JtmRyYrQ3Y7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxIHh8ACv8r+2FUxhwnGJEy4IJ0RJ9qF+MsPIGuGNtE=;
 b=ozHlFHMMwmhnzy0l/VHcpXUUPilD8XwzLRmD0z+msmT89jrtOjp9l1mptj2mMQyG78y8S9RjOzx7IgYhIzPPYR+mSGc/OWIMbgJKwBD0ms5w/2akEfpDCZNJfRcgByyImy0CbWX1GQXj+QP/vwAD023pOjO9c/C4GiWu/L1UOhvyxhcK/5Srth/bWdWq/nOgiMXKjkuY8OpGMst3qwRoqkItxCiTYk8wba72PA5GpiyTVA5LVGy1nXrnovqDLz90BEe0Djz2V8O46OkH1OuNZbwZytFeO1zNh03kksahK6kukP/2aI0yiWcNCixsPxkUwnzQfsC24KYzQ751XDF5eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB5296.apcprd06.prod.outlook.com (2603:1096:101:7c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Mon, 4 Aug 2025 12:27:44 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 12:27:44 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] bpf: Remove redundant __GFP_NOWARN
Date: Mon,  4 Aug 2025 20:27:30 +0800
Message-Id: <20250804122731.460158-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:404:f6::30) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEZPR06MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c39632-73c8-4e1d-6b38-08ddd3524feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pZcQ2UHQYM0jTdJ+FQv0/wqUol/8rfvAYN2mbwveKBVMhXRoE0vzJJ8UJkHC?=
 =?us-ascii?Q?+FNU9vsEYNcoR37ksgVhWvfIrC5jihFoJHmY1DHm/4sdgqsuQM9zCw6O8U7+?=
 =?us-ascii?Q?eFb482jKTp76R4b/Q0sm36nPKBT31l1DhDkgGmJGugWTCqE/747KWeugKHFS?=
 =?us-ascii?Q?yKYR1fWjug4rjpjBqYoftNpnZgdkOEUjVRXuTeOBCa5SNXyQDgRPrpnWuxRU?=
 =?us-ascii?Q?DltOtVKrLA4q3OCH3m9VSbE77HJY14qbGmUVbOTVZjTE6h8Ulx+knbmkPqnf?=
 =?us-ascii?Q?+P353spfl2ZazPQ1FRCiSNqbtWAf0+xnPn5X9QJuDPCmGOSeEWJpEgevGe4U?=
 =?us-ascii?Q?Mv1e96SOTFGhrMojKblRbu3YuI3o+pT38rL0aIaXQkpCuBJ7XcSyPI5Dl8YG?=
 =?us-ascii?Q?2V5qODgk0v/mO+qcH68d3qYk9RwiUMuTbZH7gDIE69xfHfpZ++6lD/9JGeKC?=
 =?us-ascii?Q?mJUf8BuhLvGHAx4oGhBc0qF7vOjdJ8JMOu7zfvoQI2BSnyrrD7gt7F0hSlYr?=
 =?us-ascii?Q?uQDMpmLQ1QvAA52MEbUBeTURt0bLJNVvsicgc+9aieYjnuE8nGgWAeZNUQ01?=
 =?us-ascii?Q?JniBvvDymJyIn+pTYKnpbXp4uzpzcoiA/2uGjc0/xowfPjI+ZEaVdrnzFsbQ?=
 =?us-ascii?Q?dp0o5mH/9gw0DewZ6H02JAXjaWMZ64YkhiSqt3K5eDskLOp1zBtmWDjYFvDl?=
 =?us-ascii?Q?wcF+PB+6+Qow/va/uPnp+fJBo1Px3pGoYcG9O9R3G3Qp/4Q5YoxzGBGhzqBp?=
 =?us-ascii?Q?cYoqSyKJUdMZMxh6P23fTvLHczypQ81OH57sK4DslohhtDGZ8Qcl7UjKvqPT?=
 =?us-ascii?Q?yDwUZUrxjItocCs1IFfRGHAruwgt8KheM6grPUVvpUHoxHqBeXD6Gycma3ib?=
 =?us-ascii?Q?VQ0L8gBFVubdL19fV4n4R9L9R982Q8bsDOahQYGT0I8FzPGV3t0Edkwq4Cw0?=
 =?us-ascii?Q?SU4Jrjde59uSmVsEIT5BtOiMQsWFUSOwHsuqDhrUcbf8H4TTPwaYi27AlUt1?=
 =?us-ascii?Q?kSNTQfihHpkVPdHGP+kAxfVM5FPVtQz9MUoosCPDxMymW2HDlVg/S106cFwM?=
 =?us-ascii?Q?ZSrOYUH1VaxJIxiqg9fEiU/q52ZBO478CYf1D20g1E+NLLsvSklmjDEr7nYH?=
 =?us-ascii?Q?LFTp90cunzeKWzfuIJab/ZgWG+EpvBg2tSges6xfSZSlwThj0k+VusNG2L2N?=
 =?us-ascii?Q?Yz32e23LPdrmvK5/I9EwLPDLPy9j9XmxFLNLQ9EEGHHyAwpW9mtkCTloZJ84?=
 =?us-ascii?Q?oPPlEAXGTj+1BLFcZEL1fQw/Ec7BeD2h6FQwA+PWl9ZnO4phEX1+NDsCf8Aj?=
 =?us-ascii?Q?Pz2aQGIQOdaisjpjN1i0bWecs6n6gCPZNzm7yNSXemvDjTQxTUdiHGkB23KS?=
 =?us-ascii?Q?7OOQKTua+I7A6MQl6wfztwQ8B57b8q7mXzwzTAVLsTIVTmGpW3VaVc3sayHF?=
 =?us-ascii?Q?686SQiPgUYyakZftxsRohb/cdCgG8Y1AgagrIzlrnxiTbwd2KWKcpjejDyz+?=
 =?us-ascii?Q?+Pr3drcN6Kbf5Y0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jwj2fhStjTXmgqoWOre8gjJ/YtgJ4eUYqD9RWCJvtz4ul+Gmk7TSleTHIowF?=
 =?us-ascii?Q?/KvXEv9aTq9cOiAnmvfIq5Ov0Fn43Cv5OYjs1Ti4mTrkUM6ATLdqhpWLjKae?=
 =?us-ascii?Q?Cg63erm0Hbzbj7LONTrYOCGlt5OpWah+obHhwcin9snnyX1FfJsdv6o9nwbr?=
 =?us-ascii?Q?sPcWL9NSGgac3g/kbb36RDSo4oRnbmZcEJl1/YMpQpn1ko2V/8ejFltrQa7w?=
 =?us-ascii?Q?ttLhNs7IJtteItBaWQu5rILY83yYt3C/clnZDBafS6Flkcl/ExfWBYxwzlWf?=
 =?us-ascii?Q?CJqBFYmS6fsKd1uVhuYlmtofZQ5eERymDkgHPB5FMxk0SSCbSbvRmufVCwqC?=
 =?us-ascii?Q?WBlbVjIV+XLndWmvQ3EAjuW/ED1I0CABvZg/zwsm9/MhBa2LgD876hhQv2xx?=
 =?us-ascii?Q?EyzZy22xOakf9k/xUHF64qDq2WjRVtBgvtUmXdZmkHYt/XnodeX/dx5FpHCe?=
 =?us-ascii?Q?xzs1WUi2lPHE4RI2cpZFZqWzZ5qAC60BK/Y8fXehmYp+8doQ5p5oDrcnuZNy?=
 =?us-ascii?Q?alq5LPpwtzt0TY7hcfsDYD3iqsZdgFNDWYMax+G0os2mlC123Kyh6k0lnWY9?=
 =?us-ascii?Q?V3+0UCq0g7Jd56d8nCZZFGEhcwXmd5oMCCPeOrj8lRrr8Ova/z2m1AQzUWc7?=
 =?us-ascii?Q?LvlPWLetjzaqBcxrhTEJaR5IUFasGw6S+GCWtOsUgpTVv3GTrLXpRbgBjJzm?=
 =?us-ascii?Q?B4vk168Af6HPikKho2YMJ+7g33T+J6EEKTzSH9TpG2wepTYA3jlCEud9rKL4?=
 =?us-ascii?Q?5AzX7OVS7mmZeS/Cf94w/De+S87w60YXxtfCDCvVx0JaEp4V8uFFdB3waRxS?=
 =?us-ascii?Q?SGH0h+p1LHApESy+9lJ51YLHTYNH7wFPS2cuCkHO/CT6DtkD3ZIzLcCD7WXX?=
 =?us-ascii?Q?al2LondVYs5venefZ2jAOaE4fB7QdIMkN7XCM2i+aWdDD1tU8RYZG1WBdb7A?=
 =?us-ascii?Q?LBWB7u8mySEWqqsoadELq6pFzhIGH8dloxQ/I6WabFYwLywVxSusvgUSLvF7?=
 =?us-ascii?Q?mxM1WdEepDBK05L22w64YQTdENBerrgFa7g7fVSJb1jG4vEFMeMlPi16lpSV?=
 =?us-ascii?Q?6tvWs0l9z/nQE7HFPoAz45OrTfeSRWZcF7hX/Ie46yh4kk39/ITGKgxaskOs?=
 =?us-ascii?Q?1PEdE+exeGFw8O4Y0BiYmqCFglvLWlBa1xktFzuQ+U34Ptyh/Hp2ovKlzQvI?=
 =?us-ascii?Q?48+9AIMkZTBNGjDo9O1z1QlMiNX0V+ca83x8pDd1q/I4vGNVBiTiXO/DfY3D?=
 =?us-ascii?Q?6Qz53bGpNmaQsvyv5WBDvlQuK3fexS7MBNyuPm+3ijeY5F8G7A4Z0s8UeR2Q?=
 =?us-ascii?Q?pLWmMTwmfGEOFNk9pkmANQ4+5PA4Ni9kzFaaFkWhdtYhcnsBHwG876EvOKE+?=
 =?us-ascii?Q?2aaCV8N1YTEb3FXul3Ab7tb6Sl+2gtuzmddU9cAlI2c2g8Vhd+8V94bo4svp?=
 =?us-ascii?Q?PaSCg9qWhWeRNW0ql/ZtTEAb0AKGs+Bkagwj61a/0DAtoB03UgbaV+okh0zZ?=
 =?us-ascii?Q?j2Em4BSN3LbPu1qhmLwVYKew1U+qzMHER3TtV+I7tyalR3IdE3u1+GLSHzb2?=
 =?us-ascii?Q?rN75rAR26Be/8QJjemxfPPbeyuwS2H9ZeOSZuKKm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c39632-73c8-4e1d-6b38-08ddd3524feb
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 12:27:44.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3woWYfErvhLVIuqwxyrV6Ix6icGgINtLMSORdkWzykNfgDvOXeu8zCh6iLgWOKxdw6L9HJpggfsaSJ3ju/+HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5296

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
made GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
up these redundant flags across subsystems.

No functional changes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 kernel/bpf/devmap.c        | 2 +-
 kernel/bpf/local_storage.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 482d284a1553..2625601de76e 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -865,7 +865,7 @@ static struct bpf_dtab_netdev *__dev_map_alloc_node(struct net *net,
 	struct bpf_dtab_netdev *dev;
 
 	dev = bpf_map_kmalloc_node(&dtab->map, sizeof(*dev),
-				   GFP_NOWAIT | __GFP_NOWARN,
+				   GFP_NOWAIT,
 				   dtab->map.numa_node);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 632d51b05fe9..c93a756e035c 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -165,7 +165,7 @@ static long cgroup_storage_update_elem(struct bpf_map *map, void *key,
 	}
 
 	new = bpf_map_kmalloc_node(map, struct_size(new, data, map->value_size),
-				   __GFP_ZERO | GFP_NOWAIT | __GFP_NOWARN,
+				   __GFP_ZERO | GFP_NOWAIT,
 				   map->numa_node);
 	if (!new)
 		return -ENOMEM;
-- 
2.34.1


