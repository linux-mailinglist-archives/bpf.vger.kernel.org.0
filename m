Return-Path: <bpf+bounces-78648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8A7D167E8
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FCEE30360D2
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527D934B198;
	Tue, 13 Jan 2026 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m7Inkach"
X-Original-To: bpf@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2019E34A78F;
	Tue, 13 Jan 2026 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275034; cv=fail; b=hwW3m4NmmVY1s2HLDdI6A00xn3YJa4mpRP/F78DYNshgFQ2Xj4tmVn3fHRNKoNXTrRnhQDtFLe0mzXwzEP/Lq9kThA7/l+8GapEvWLiyDb538Dbjtv32iKK4r8J5x3zg8jgHYN8Ai813FfzIvdwQbkYHBeIP5WOtCoFKm8AgHiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275034; c=relaxed/simple;
	bh=jUgQsJhCMBAxOFG0iTcUZndKPSdDdL/izA8wBc9aApE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MZVjGiOCigfIA0NJrYzicsOcOYYOjIe5AI2nma9Mefqzg769eGYvUwg/2/HszzcRRa9slYzHnpZ0RuggJLqeKk0eintK+A0ppT+6Rvgo94MflDMmKM3mYELyKHhDHAsZX0HnnTimot1gL39LkkBmaYu7x0XugqTHVEJuisLU5vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m7Inkach; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKO2oL3N9eA2BttDv+9do7aCCVHc+1lnbL9FuBxLcCyhfR4O+ZvO4cLzFA82X1DqC2Ue15VAZ/XqlLjz4M4jccq2UYEAfQtzfMGmsJ/kDL7DU2rA46lvC+8EY3qVyk/Rnn2uO5DIPiLsprm4D8evM0of75f4FITRPIWONpo7c0JrZGS4CWvtkmzmAzPU9jLABf/4/r604Iyl1KLAClkSmWeqDJxnSuMv37rnjp+ptI49vH9SHCTddExUet43O9Jyi8FAN5Ir/FpjrY1r605MD6qv6Zcn/tZmorqd++11KuKOTqKch33VKZ89qWpl/BprX5WcAkmxhCcg2XL/rbPtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynKvqNJPP+ATQir+Qql5fJdNXgSNmh1Jc9x59iaszXQ=;
 b=xanYTcDitwix7oJAS+bm59FbaN8TAY51Dqg+oZTOB1AbN26ot0tKp0mBrVaDaZKiifhWuQCcoQjGjfsanLzs3lYFvq1paBYVT8MWex7lFqX2Oa5QaExMYggTE4aashzH0eyaxgwpy59Ff5crA5ovqAP+QNjup0tyyqFCmYbkB1K2M2lXkwG4Q1R+eFNthvVug4oISklg2IxTFXLVsinMfqjrs2elt/mH0romeidtIyixTEkWXgHKcByhZLjs/CRJ6YUD43FF1dk5yYKX/Z0iB68XbvbKONG0LIi/OOkkI4152MMVakIcACuTMSe4PesfwokmCIGui7EPDIFsix20gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynKvqNJPP+ATQir+Qql5fJdNXgSNmh1Jc9x59iaszXQ=;
 b=m7InkachuwQaeKewZ4jy3HLpOux+pUEMoxOmOwtnz/ctgVtkaV0FFsCDIWFjbcQ/L9jSouj67lNxu5L9MJxeBxwHt9e5AsBL5VFiAQkDvRGyl/sDZ4pGz5X4G01YwQC9S00jiMfHKWNeEQPM0sgnWfaxinUDSqOFciPpVslPhusaV9aG+hT+e2c4bvJa7/BPsI4uYaI2V171eKJDexkSAO5BW5eil3hCTHNMxL6ZylM+SaT95gkga8N+RRMkAZwJRttgr43CS8XeGC7w4TlSnkRi0Hmyi4o4HJrZuJjxE2HFdIV4bsIKAbZDDDNqeSSzukyYJtKEtIJJIGZlMW3z1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB9395.eurprd04.prod.outlook.com (2603:10a6:10:35a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Tue, 13 Jan
 2026 03:30:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 13 Jan 2026
 03:30:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next 04/11] net: fec: add fec_build_skb() to build a skb
Date: Tue, 13 Jan 2026 11:29:32 +0800
Message-Id: <20260113032939.3705137-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113032939.3705137-1-wei.fang@nxp.com>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU0PR04MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb6ca85-026d-4222-e78a-08de5254171c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|19092799006|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wcqm432HdjzXLeccGEudXd/U2ZcW4UtplkU4Crc+FKmt+uVd5TvH8adklg0G?=
 =?us-ascii?Q?PmZJDyCeNUOy5DMyEshAV4D2BRJz2pA4G9dztggzpSZ+UXjA/Pr3OhsZElY6?=
 =?us-ascii?Q?QwmpMrP5hVBWqcX0Sw9DL0MrSHhR8nRrqO3aig7Vjj9HFZq3gJ4STirUZTVh?=
 =?us-ascii?Q?WiVcNamdiW5whEotaaEWqqTnZ0x+XuRF9V0rSMzfAfHHBF+B3vLlkIngCl3b?=
 =?us-ascii?Q?+fgjnEVym09ZiJNcDlfk7/yZa+dVUYBjv+OXrJcnY2wr7jR7T9ze9F60Kv7L?=
 =?us-ascii?Q?DOYq6Zj1QBdI/a/g+L+rkCLLrlED/Q5ZPhUQ1gnboux0HJ3vzpaBleoCY9Y7?=
 =?us-ascii?Q?tpolgawYA6kLwSq9Onrs1xcHIoNAjpgC6q6gzzWQk1uCYgcWsSOC6LKgaWEv?=
 =?us-ascii?Q?qGiyRRWoJ4Sr0geRe7O0SQeHi0IjYsukrU3DbIfnlQFRb23twtlfCnFQErnd?=
 =?us-ascii?Q?BRj7kR2/5xjBKRQlgFGa2STvobOSVjJaYherlHrzJ0aQNdpIEkU2d/CnR26x?=
 =?us-ascii?Q?7mGizhNVV6ikzRmwpwxwj1gb+CNbiyeW304Wp6AuwCB45xnh1FDsdCFX/m3Z?=
 =?us-ascii?Q?o5wGrK6lQnvJ0wSKkvtiMutqwYg18ZQEHhBXS0sLO2bNuKvI3HRKpPhGNPpg?=
 =?us-ascii?Q?WNRri36o0MqbMBK99DWVFTSLaCtMpty4XkJGKbESk4MGSrIg2ZCaVvmxOYWz?=
 =?us-ascii?Q?PPNEXN/5wtQp0w+v0rAheVzczV0vV1ISyd5yumq4wCLnnCMw4v3lqaB70tp2?=
 =?us-ascii?Q?5VkNScdkYlfdclOqB639vkTFzO2VoZsAvmKCAintcWhJmhakmOGkO2wAFoH2?=
 =?us-ascii?Q?ulGoWEoykg5o2Ggn+jP7TJxN2eCSqxnYwTauhwDUr7agwq+MTaEi2zp/QvsR?=
 =?us-ascii?Q?QVdEOAifUNZdY+pAK3OuGNTiaUuMwAQmXYK+0pe7XYjnAcjBubUO44h9+7sG?=
 =?us-ascii?Q?XWRD2JcasN2Jy+67MCuRHp0rAIK++onfmTscqw/76xwA4DQUMWJPVmz/+s0E?=
 =?us-ascii?Q?OkD9jGE/2AaFRT4UGx1aEGPGWoJog7MFLbg6AGJDmTh9X6MDmpAyfY4CAqeW?=
 =?us-ascii?Q?Hn8SCLcDf2QE09h5sgXbNvCW0nRZHMhotTqmGDbPsitHQ4NK1qk1sEh9gtZ1?=
 =?us-ascii?Q?uSHuzXSLkIyv3B/3OaHVoE01/2QfgsYD8Dql1l8zGSSMzdBgPZfxcbLqmCeH?=
 =?us-ascii?Q?2xsiXLgT7GL9hr/qusDm9Z25mOsfXuR09Pd+N9BVPMqt7wXaIh6yzXp5noG3?=
 =?us-ascii?Q?bYKLRxHFNPj4nqFQWHi8tV/51Z2tPdXWbbkMOxejOZZcPlqIGRhVyGWKS70D?=
 =?us-ascii?Q?9KF/Hy06Ku959/OFw6fB8Glo1QD6WA1shmclVyxpzjqUCapwHdQJh8sFrpdL?=
 =?us-ascii?Q?10b/vQYjcoKMNogMl2vex+sKcdbZZPpJQvolkHO6YREzfyrCGFIUzGAcY9sL?=
 =?us-ascii?Q?q1FB01zn6DZhBIMHh0ghe9KDahuWsLb1YJve7BvvWMHF3pKqkKrSZFkvt6I9?=
 =?us-ascii?Q?aS2rKimuFl/YpUCPNshZ3s7/IAFdUY89RMGK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(19092799006)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/bLv9K+qCbpPK5VqaY7chVKrrs0gnnBn76OGoe9fpsE538UIiuwDPwDRuDfS?=
 =?us-ascii?Q?OwnRXPv5Eu6A8K7kQycxAp6XZsKBqr8sYfkMOLqkJJcqkn3nDcz53muui5pd?=
 =?us-ascii?Q?xP/ere5Xj/MdyXzkld7qlfozyYOXktCNRPRtQeCpFzSd8Qt0eiN95b9Iwte0?=
 =?us-ascii?Q?PKloHzgkDbs3MVo0f9sUZewwaSvsA+Luiqrea0tz3JHAhRzME6LsTpSUUTgy?=
 =?us-ascii?Q?1y6xR3o8InfNfiaWU2K6dhQrjLBn2G1ag5l5kpb8PvlfaTep00Gk37Fbwibz?=
 =?us-ascii?Q?F3x5pKRFJWHn86nB9tBehmOnZZWux6LvrPJPLuVlz/FGhYjSWM3baUTeqHSz?=
 =?us-ascii?Q?hSXNfi+kSPNU7XBEFJQqBF5dk/bko5BOr2AWUmwM2K7wllPk0BEpztN1s4iy?=
 =?us-ascii?Q?4yZicHF6sXLQUr1ABB4vdQn21DP8DCoEB7rXhQmU7dE1lKVF0vFvolL3+fXx?=
 =?us-ascii?Q?DnfYUDztrZlhcVigmKWpeU53HzOWpKmKsWFEk36Ffp9WhlJTQIzSRvuyX9L4?=
 =?us-ascii?Q?SWIki4ZV1PfL+Lqe3HdTSZnJAGe7A0fqxYUQOaB6re8OZQaRLdC5XXI8PAC5?=
 =?us-ascii?Q?Y40xV8NORwT19P01gnua12jSeVspfUBRyu+C+xj8S/TL5ZzJcrApoX0vNh8b?=
 =?us-ascii?Q?XVPoZkqRhK84vnY4E/oYUYLBZXIrT909aVhkOc3n8Nm3HpjjdbP75svQ6mim?=
 =?us-ascii?Q?7rX8vv7k1JhIyRxqIsUMveGWaa/r6GOrOkPew21MXmouVn9pBLI1kMpkSxJ5?=
 =?us-ascii?Q?zMobDY9KHtfrM1h39tFebFvp/yIAiHTx96jZVMpWjDSZYsZg2jI6kg1OB27H?=
 =?us-ascii?Q?PG2SoxNVt6U1JpyJSqr4Lg4hQ1HnBsQPw/R1MPNfK6mG2Qv9BuybOXTcSvRj?=
 =?us-ascii?Q?jF1+66RRZEWLPugRA+LgTJ4oGWqtSJ3e189u1IL4Q8I2SnrlJaAcLG20Y6+m?=
 =?us-ascii?Q?HrGmQNbv4fv9lGLEzZ3dEzYgLQ5f5UGMey1t9VbYUxMPc/FeLSdUc7UvoBg8?=
 =?us-ascii?Q?WHEt7IWN2n5CUUB7Nt52YE3EUC09+4U3bkGugE8u60a6wtIH8e9KYSLWhoGa?=
 =?us-ascii?Q?h+o1YVJWcUVllLMXNzWVpOMxADk+AZEfIFcJfugDW13Vu+5+iQFegVnbcDgT?=
 =?us-ascii?Q?V/pNChnMEwL68QLXnhKWFRWjOqAnxrEkHADOfEaZ2V1TV9R5ehlRmsRbXPqn?=
 =?us-ascii?Q?97L+6PJGazAkQvQ3mpz043z8ymfwNrBR+Vlj1y64v36En3bipbzzbPiVv1cl?=
 =?us-ascii?Q?J5fgplqyMDjss2q/d6UqD7kwZr6XY0IPAbzmJXNwbQRpAJaDa6FDCTRhkP3f?=
 =?us-ascii?Q?iRGzCxwZ7NRLFdHXDUh8FBvuJJJZgMATATCyM75m4UUqfaDIKSHvvpCYXwXZ?=
 =?us-ascii?Q?FjdHkt6x+P2XFXMrIDpEyPfyNg+YqYQeT2ZqGkg3mvjnC+xdXQyp3laf/ZGA?=
 =?us-ascii?Q?vTsLBaCIlMjtp4+TzUlycWmkRYrtO5NKNmz866MBHwJefW9eSPqJkeONPtzr?=
 =?us-ascii?Q?LfzpAXki2u638w3irnwaC61jBA/VSDqaMJveHgXlSTqBWvr7B09CgtDFdpIm?=
 =?us-ascii?Q?hwU4AkT4SfBExpO862eo9kulHrySRpLh0SiR2xa2T6VpIbizws7lEBXVDOpA?=
 =?us-ascii?Q?P3+MSkHXOI2UUjQ2engbfo7VLAAwOtev5HBH2bqX+AuzuAYbGmGudUKWEsuw?=
 =?us-ascii?Q?TwpxKo3bwcgE52Xod3PEynO6Pf/AgWXz6TzP16/MutUMe3AWIhAQAa7xcfNW?=
 =?us-ascii?Q?lAr/w1RNfg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb6ca85-026d-4222-e78a-08de5254171c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:30:25.3594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvDesbU717GRkOX9AnnO/N8llxh5JuFKCy61Fgc0PhyV+hD5bUxU4RlEgcHOhKaSKiCbWTXmETwcts16drQX6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9395

Extract the helper fec_build_skb() from fec_enet_rx_queue(), so that the
code for building a skb is centralized in fec_build_skb(), which makes
the code of fec_enet_rx_queue() more concise and readable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 106 ++++++++++++----------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 68410cb3ef0a..7e8ac9d2a5ff 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1781,6 +1781,59 @@ static int fec_rx_error_check(struct net_device *ndev, u16 status)
 	return 0;
 }
 
+static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
+				     struct fec_enet_priv_rx_q *rxq,
+				     struct bufdesc *bdp,
+				     struct page *page, u32 len)
+{
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc_ex *ebdp;
+	struct sk_buff *skb;
+
+	skb = build_skb(page_address(page),
+			PAGE_SIZE << fep->pagepool_order);
+	if (unlikely(!skb)) {
+		page_pool_recycle_direct(rxq->page_pool, page);
+		ndev->stats.rx_dropped++;
+		if (net_ratelimit())
+			netdev_err(ndev, "build_skb failed\n");
+
+		return NULL;
+	}
+
+	skb_reserve(skb, FEC_ENET_XDP_HEADROOM + fep->rx_shift);
+	skb_put(skb, len);
+	skb_mark_for_recycle(skb);
+
+	/* Get offloads from the enhanced buffer descriptor */
+	if (fep->bufdesc_ex) {
+		ebdp = (struct bufdesc_ex *)bdp;
+
+		/* If this is a VLAN packet remove the VLAN Tag */
+		if (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))
+			fec_enet_rx_vlan(ndev, skb);
+
+		/* Get receive timestamp from the skb */
+		if (fep->hwts_rx_en)
+			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
+					  skb_hwtstamps(skb));
+
+		if (fep->csum_flags & FLAG_RX_CSUM_ENABLED) {
+			if (!(ebdp->cbd_esc &
+			      cpu_to_fec32(FLAG_RX_CSUM_ERROR)))
+				/* don't check it */
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+			else
+				skb_checksum_none_assert(skb);
+		}
+	}
+
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb_record_rx_queue(skb, rxq->bd.qid);
+
+	return skb;
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1796,7 +1849,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct  sk_buff *skb;
 	ushort	pkt_len;
 	int	pkt_received = 0;
-	struct	bufdesc_ex *ebdp = NULL;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
@@ -1866,24 +1918,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				goto rx_processing_done;
 		}
 
-		/* The packet length includes FCS, but we don't want to
-		 * include that when passing upstream as it messes up
-		 * bridging applications.
-		 */
-		skb = build_skb(page_address(page),
-				PAGE_SIZE << fep->pagepool_order);
-		if (unlikely(!skb)) {
-			page_pool_recycle_direct(rxq->page_pool, page);
-			ndev->stats.rx_dropped++;
-
-			netdev_err_once(ndev, "build_skb failed!\n");
-			goto rx_processing_done;
-		}
-
-		skb_reserve(skb, data_start);
-		skb_put(skb, pkt_len - sub_len);
-		skb_mark_for_recycle(skb);
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1891,34 +1925,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			swap_buffer(data, pkt_len);
 		}
 
-		/* Extract the enhanced buffer descriptor */
-		ebdp = NULL;
-		if (fep->bufdesc_ex)
-			ebdp = (struct bufdesc_ex *)bdp;
-
-		/* If this is a VLAN packet remove the VLAN Tag */
-		if (fep->bufdesc_ex &&
-		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN)))
-			fec_enet_rx_vlan(ndev, skb);
-
-		skb->protocol = eth_type_trans(skb, ndev);
-
-		/* Get receive timestamp from the skb */
-		if (fep->hwts_rx_en && fep->bufdesc_ex)
-			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
-					  skb_hwtstamps(skb));
-
-		if (fep->bufdesc_ex &&
-		    (fep->csum_flags & FLAG_RX_CSUM_ENABLED)) {
-			if (!(ebdp->cbd_esc & cpu_to_fec32(FLAG_RX_CSUM_ERROR))) {
-				/* don't check it */
-				skb->ip_summed = CHECKSUM_UNNECESSARY;
-			} else {
-				skb_checksum_none_assert(skb);
-			}
-		}
+		/* The packet length includes FCS, but we don't want to
+		 * include that when passing upstream as it messes up
+		 * bridging applications.
+		 */
+		skb = fec_build_skb(fep, rxq, bdp, page, pkt_len - sub_len);
+		if (!skb)
+			goto rx_processing_done;
 
-		skb_record_rx_queue(skb, queue_id);
 		napi_gro_receive(&fep->napi, skb);
 
 rx_processing_done:
-- 
2.34.1


