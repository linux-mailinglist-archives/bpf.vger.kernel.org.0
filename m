Return-Path: <bpf+bounces-38141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A343D960857
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9F71F23574
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989819F48B;
	Tue, 27 Aug 2024 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JuBN1ly7"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68B019F46D;
	Tue, 27 Aug 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757573; cv=fail; b=LG7XkDkZlYrRsK+KrsojNClonQcOxoH/991u/0XHtODD62y72oR+BK9HIjNNgpcg+bDIow68TbhBDYkC4NTA+StOZz5IufjYss4iPTwdIHxb+1AL5uxbn0OQXQhekRu0ndMK4iXTKTujjVpYarvBBj2+kvxPWkJRUEDAlDH/2t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757573; c=relaxed/simple;
	bh=VCZs+AXTTjEaHoT24M6P1LixZKytOvmM4qaeAT+XYwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuKZOfx+C4A0eGtcTWoonme0XSUqgKbGWnQydRxJIMrI1UY5dm9BKlorEk+0GYAcb5C5FvSsQQmglcWjPRYQt0F2goAWlk3sT0E/ZoJx7YeLj7VR6+UMnAn/Vk3S773PrRmAhLoxGRYDY2AMGFiTwHxSM7BS4yiV0zQi/sUPlOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JuBN1ly7; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbUc8yISmog4vTfUS6RGX5zt0TQDbsqTSnjfZssdOzREZyllgO/pOXnI1FLSWYhQ03XbRCeZfmVvaIMpAiVX451iy/IqbJqyh6RAk8yNwJM3LWAwp6MDiziATsDgsjHRdj2+FeLpb/oF1jMDMYKcec+hMnicc2tbEcHe/N9glr6k29oFUUc6mjPzkwN2jb82gnNI7LTQhZ1w3RlinF1aBvfhcST9U3xA4t5LVA+v5L1C4kmp/U3Cx1bR0KsTnYDxPYBPWbxQ/xM9yI3a35iFW5IC0k11PKA3LZh79af+j6L2LpkAVUv7+a0Kug3I0qW/eCS7P4tXYCBGp0KWAhCyUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtr2WBvUsosFanWr/xxGmcpnzsGRHMyqvBQoH0jgCf4=;
 b=hTSMKa23Lg2CFGMPjJmecxuQAH7/8nuBQni6GBmb/J1kmkz9DQViik0pt6wtqX16DOXq9qSfOSiL+md8turEFm3Jvf6n8CJj/698HAy5Vf1WW7EiBkQ0lENP5ByXoVbHYMhzyirGi8YeSNgrX21SDn9BUFkc3g9GC6o5d+21sonD32vSLQ+Lq+H5iIVyZPse9hWl3HmzCYs2Ioqt2R1a2wH4a7O/NtirsyxZVphDPa8rBZmlyFd0+JFrxJH8TGCW4rKqmvqaj2+RzaHJRWYjuNE5E6dn15zu61RQltXDn8vEPaR0ajYn8WO1uTuPTR5B0o8UgNFWSUT3XopYJzyG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtr2WBvUsosFanWr/xxGmcpnzsGRHMyqvBQoH0jgCf4=;
 b=JuBN1ly7wx3WLWSLdQLYIuIDWZsJHZusONq4I0CdgxX2u+AshzNtAUqtfO17pPmorG8GuYaNlDfjeAgL/DlWGdVD0kJcoZK7eHM8pYr3iz5ay+Udj+HKtLZyCnSjYNUxYBCYdK6zGluudsHoS/8rg79LHIIHgTw56cZfY1VwjxQUyrQbxoti890wOvmhJB9qDxNtpz/mO9191Vb2XnSbtnpjjVwR/PASj9qhL+nkDDWFKx4oMXxZcOwYs3ips1KmM0zhnriwG1D9gpufIvTCWllE5F7JfrqNAKNavm6QQtgAN/6IlTc9ylLb4cmZb0e36xZeD241DoSlCDI5crdH2Q==
Received: from BN9PR03CA0526.namprd03.prod.outlook.com (2603:10b6:408:131::21)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 11:19:26 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::5) by BN9PR03CA0526.outlook.office365.com
 (2603:10b6:408:131::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 11:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:19:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:06 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:02 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 02/12] ipv4: Unmask upper DSCP bits in ip_route_output_key_hash()
Date: Tue, 27 Aug 2024 14:18:03 +0300
Message-ID: <20240827111813.2115285-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827111813.2115285-1-idosch@nvidia.com>
References: <20240827111813.2115285-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f2025b-e5e7-4529-c04e-08dcc68a1c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PMs/OH8jWvhP+EJ6nb+nDE801fzToXCth1dYhaPZkWqJvLmJ9781sf4qbnKA?=
 =?us-ascii?Q?vuits4cythLYAX8Gqrpi/6lg6NtxjMaSzwAwZ4IvU5efQDmYBiZY777+/WUq?=
 =?us-ascii?Q?sOmiU3Rnbn2swOivbSYC6VzcIg/mjtl2pL1slK3kFB1h9HMEKSIAlBXSRu2J?=
 =?us-ascii?Q?5Rc6z0ivC5qtDDwVXYQ0YiIcbnv8Ollnozw5mxZ7CZsDTeBunuTIQNMbiYFH?=
 =?us-ascii?Q?1sR+5MCgCVGAk74oh0I4FNp2GB7fs4aVR9JUtZuHUYoquqw5BXwPq64y/P3I?=
 =?us-ascii?Q?1NNl3dadDbXMZZcCuwHC/CBkHnQhv6IAdc0uZZoA3txZ23eTj5Vw4M4mQbSD?=
 =?us-ascii?Q?zvUKoSnO33HfYLHWCxwn/nui9zbkNslNmlg6cd4rfSuUPur/5Rw/gt7skSt7?=
 =?us-ascii?Q?Ahd17+2WqkxgWSLCeDy56/eZIP3gSbFB+Up2UnYh4L84PUqbkWULCvYFN0Pq?=
 =?us-ascii?Q?ko4csASUzXOxE5+ph5XGOXPErXrTlNr8MuiRfMJCzSApIUNsjrPDg2oFyq9B?=
 =?us-ascii?Q?le3m4D2771jcwScW0usnAAIPkbIsi7jq8kBeLiJg0KMOCDRGkzFKOSZc0SeT?=
 =?us-ascii?Q?/sNVtHcFEyXAmX8p11wVXgnjjUArszLlwUdUg1J7/Akxz1uqndS+zTDNJsNq?=
 =?us-ascii?Q?tU1tCbU23GHty03aue7XH3kjWVdgScMYmdiFfdL1MTDk/bHH9pdx2jRcelTx?=
 =?us-ascii?Q?PeRXB6afkh9XQQ9At0G+czg8e+Tw4PPI2fQhKOu+EZM1EcSErgs1Os7ziPuw?=
 =?us-ascii?Q?2BlhAjQubADmND/27dyb8a2T7tlp4431MT3ySPDqR9AJ8rXRWhUbM593+qn7?=
 =?us-ascii?Q?MIP9tdPV6Lz+0iRBft7WhUvLHi8Gh01j7sQD7Xy0I/6EfIfDPsEylUpONG3G?=
 =?us-ascii?Q?CAGfKRsecka2eY4FaniCIxREODUrxv2/x8oc4zRZk+ZrIAKKgYIfJMDugEYz?=
 =?us-ascii?Q?h5xq6pBf7BDK7w5N+bXMrNZYKhe1gYysvdYHEfixGzzMmqNLjvRl0KU7gYz2?=
 =?us-ascii?Q?7FptKIDWvsQj1rqmI44/tWbnKxgKDImLYECpXdlr4aMBh3T7fwYG4BetCHty?=
 =?us-ascii?Q?Q2OTt0NOYUC1O6/dV4NXKjbzhUQu4gM7Iv4B+QZedkPvUy6WFffGGnl3rm6M?=
 =?us-ascii?Q?QnHBC/O/iFNyNHdyhEOhPdNW2d5+Hw3H0wdUMG+ZtsVBkNZnuRcWhq6Nv9+3?=
 =?us-ascii?Q?vRtipn1HHBndc4ggtjog0eXUaAViTiWXEO+Y2K+Lvvq3nIbt1CvxERxmDXIh?=
 =?us-ascii?Q?w+4A9obrQU3GLyrkH4zO0N4ILCrVU5vWYO9mUuH1n6KSDS9Kbj6jxhSfv2wH?=
 =?us-ascii?Q?oLrhWtdmLo/gur0xS5W3GWeG1TeZAlIH2nn2FYggFrmVLGSw9PzkJcwKDce6?=
 =?us-ascii?Q?NL5Qx04P77qw6yc37LRU7MLkqAy2ZRmFUdyWt/AK3ReYUVPl+TTSUreIRkfE?=
 =?us-ascii?Q?L+t34owrjglpJH3QGxT++uhhARlCXHJo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:19:25.8349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f2025b-e5e7-4529-c04e-08dcc68a1c2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737

Unmask the upper DSCP bits so that in the future output routes could be
looked up according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e4b45aa18470..5a77dc6d9c72 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2618,7 +2618,7 @@ struct rtable *ip_route_output_key_hash(struct net *net, struct flowi4 *fl4,
 	struct rtable *rth;
 
 	fl4->flowi4_iif = LOOPBACK_IFINDEX;
-	fl4->flowi4_tos &= IPTOS_RT_MASK;
+	fl4->flowi4_tos &= INET_DSCP_MASK;
 
 	rcu_read_lock();
 	rth = ip_route_output_key_hash_rcu(net, fl4, &res, skb);
-- 
2.46.0


