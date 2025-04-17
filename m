Return-Path: <bpf+bounces-56126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F58A91B58
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 14:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7756219E3E06
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44192241CA0;
	Thu, 17 Apr 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZNfzIqOA"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56CF24113A;
	Thu, 17 Apr 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891243; cv=fail; b=ZLJx4VYjZKWeKwbdWM188d7Gmg1TvRVbRkMaIPjZUt4fm0ZsKWJUn7mfZHFS18KxWU+4dwENx3LgfGhcE5ljkwyzVnE+sFBzCo4WkDcMgVcWIW/+1xuV9PeNmdYP53qnMP1VaF4S710Vi/DCROHUXnhzFLCDfe/ZHRPs5klJORY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891243; c=relaxed/simple;
	bh=00P2rmQ36nDf5v2ClZv7Bsqb3BVUyzT9EvDy4fgJFx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TszE7F8t4560t7YjZW/i63nof1wX0a4YWozHcMdBLWgM3+UICPslZ47YgReXQcn5W/ayO/GN+cFIURW5+BqKSEGm8aAaz1FgYz3U+ylJqwATyBIBDZTge/shyosxIVG1dFBTkNTY1C8V6TjMUUqrkcu7CMNQ78HAB+9Auz17sjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZNfzIqOA; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqra8YfQor8HnlB67kVag+FGuJ/AUZqSz2dhBYmGO4JVPcR8gCAAp6fGF5wAMTVcPVc15KemXylI5bAJqFeqULM9Dua8i9IkOcYxLhWWTjA+0/RPM6jnCb01vsDuFzpfkZhdU8Llual5iqqbHt2OO+S/o1NELeZ6UezkH6pM7n6YniwhnajZ63USLni1ThhaTsl+PGln0L2C2I6eG6m4hAYZ64UmoNFEZvLNxfgJB5/PTidCLcO6so7uHL2SwR6LHT07QTZe2+FBC3WNLSwhhg9dzzEBlzOmzUdAlYqt/MNzd8AViyq0UjUwvYnHYshJR32vSaYh9+XrVKk0lIfwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8pFM7B+rG1L8XgkCazQMAB5vJPWIocRubRYkfJsxRU=;
 b=Cs2DdzD7BrhmwzsCIJN+GTSsiEqpKfbLJuaVC9NnnwwYP6odRoUMO7pUqFFc7JMSqGciQpnBzY+nFJKaN8qkACeQIQjTFIvq1GytN4RXL+8QwEDxGLm+X4rlrbxmfuOEX6QG7dq3Mg4PfySdd5STLmBPUHA19fJ+CHcb3cv63YIr3EPdFd1QAiV3QzFGpVacIrme29k4WxIxV/3LT8atkwT7kOt4p+JSMQCWyujQ9HMalgv08dzQsIAfMZr2yn5n6X9WJ0yg/yOF1VjmFPE6i8GUSjOteljVYorkaKE9nQbizzgevZb584dkbihhO2tPOZsVfRDrTc86OUESfjlV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8pFM7B+rG1L8XgkCazQMAB5vJPWIocRubRYkfJsxRU=;
 b=ZNfzIqOADKHOfms/Ivx4pZ3vmqBBTL/PpT/Mdc0wpqUCoqyxsPJRqmq20aBdiK2ZBq3WADVlK/L+fmYsmI5gNQN8QED5aPnUR1oSD+juKpsmcPac2QAfA2Cp8ap5EcbNBIWRRVAV6MeMK6xuMZrqegjOuchEutr4co5X4jpebfUkd4riO2SFx0fAPZwHBNkMU97BTqUQy9VwxOWxkRGdsZINko8LDiqkHPqj6RfYPEwwrHyOgTGxLwUZyV00j73QZJAwU10YxIn6fZWA6RGjF0HDjoLhq5/GH92u1e4nuHSMi7pkaasJtL6jZk+QQpJEN87Lpdw1QJa2CnB1YuWwvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10560.eurprd04.prod.outlook.com (2603:10a6:150:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 12:00:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 12:00:37 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Vlatko Markovikj <vlatko.markovikj@etas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net 1/3] net: enetc: register XDP RX queues with frag_size
Date: Thu, 17 Apr 2025 15:00:03 +0300
Message-Id: <20250417120005.3288549-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417120005.3288549-1-vladimir.oltean@nxp.com>
References: <20250417120005.3288549-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0023.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10560:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fa79c9-bd57-4f4f-84a7-08dd7da77732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ql73KbX3TpHDOEn72YHudDs2oDhDyuEhFO3b6pn8Lx2+x5YGi4cU6FSgrqy6?=
 =?us-ascii?Q?g6Umr0kqiZzzGv0ir+LCOkvOL25r0eTd5a2qrDiCoD8HOm7Nk2Ey1306xA7h?=
 =?us-ascii?Q?WjcRhp8aln6E4B3wvF9SNzUqU/CxqbE/yTgf5obMxBbI3bijD8y2cJ1Dzkdr?=
 =?us-ascii?Q?AVaDAg7zaJ/xRCaqJaBZIqiHHMwmDfpLt+mLl2yTNfKONFsD7Qw/CyLd88pr?=
 =?us-ascii?Q?TSKn435y92yJRppNuCbUG+8KURlZkVW7GvoLnOspjszPyV3zBK8sH2i9xFMR?=
 =?us-ascii?Q?6cCP/PjWGudqgFWaaZ2y6P4C4oIYafERwVYUqUkofaV6Cxm75CVdgOfwneai?=
 =?us-ascii?Q?Q/ZjDaP8iLbxnZkpiIT5/HtGB38L1aLcLpPdfGJOsXENldK8SlADRsam9zZV?=
 =?us-ascii?Q?a9TEvMp1EE24+myZW1yKVp5IF+prPY/YyPswIgiYNDe2Rv4IDVKRmbUZLqL7?=
 =?us-ascii?Q?L5KL+UgIRn2+TZd0xu1GbJyx3BJ1ablsEMl24mVlICeUPLmfh+l1B7+DLg9v?=
 =?us-ascii?Q?sEurq07o8TGByGeBTpaway9BuJmpPQrBz5Vrq04rHW+ABRuC41LHHsh9a34Q?=
 =?us-ascii?Q?TVJ+Ir/y/yCz+raVaeABiTUVqA8pBPd62qrWerMlr0jaDe/TmkH6oU/x7LvJ?=
 =?us-ascii?Q?Sj/VkHzvygdc4WpIgubCMyAJsO1Xpco3sqWgVOkALz2cDNloET6jYWTy8Iw3?=
 =?us-ascii?Q?uHYuovL7rMa/VP2052wq3CA9PcCfp5qOmMxMBEBWjU93bRcPpD3bljxNYJgv?=
 =?us-ascii?Q?tqhlEp6FFSDwSlB5Nmre2mmvd6KPhxQd8cXYmgiUGNkX/LIceCQuD64zxCna?=
 =?us-ascii?Q?JABQ8BNllel+TrRJA/0/PFpLPvcJYG7VhByKHXYoXLN/tyC7EC4HwGMTG0nk?=
 =?us-ascii?Q?cL7DehUWe5lNBQN46BW67+L7tYUm62Lt8RRwMwHm6tB+pjEyS2qdnYbTYYT5?=
 =?us-ascii?Q?aoFoVEw9CUbBKE+gRkh7Ma/M+E9TD1CuJQtFGH/1gljywRRtGl27h7rCAAw9?=
 =?us-ascii?Q?FgoAoOB41svC0L38aAdmNiaLXq7X9z+Zg6szZPk292wjNOKxsh4fcZ4KqwIp?=
 =?us-ascii?Q?+sp/EEawkXuqYSYjTf446aKMcIhlkCi+fg6YWo8pDkbPTJZp7DMo5FWYU+Rp?=
 =?us-ascii?Q?o2O93x73mt5jdZ5rCrsEhJYmtWfh+oAW8UwyEJoHGXWohrPD23stKcxgS/tn?=
 =?us-ascii?Q?ANLx2Chl4V8uA0xIEtX+3CNEsa1fIko/rQ/UJdGWCFKRviue1dtyLdCD0AuV?=
 =?us-ascii?Q?EK0OCVafAFNP6gGfUgPiZVwJD+p0G4flq0/W9QmtbO9lRx5qR+usyxD+sIHw?=
 =?us-ascii?Q?jvnN731hNJfEGQArZ6/YpwT96DDhnIJVKMczmk+Bk2HDNdrJZeP9kYnHzQeU?=
 =?us-ascii?Q?qBTKFwylvZqN9wZEk3PGmIVZgLNihMxHh9NljksUdf503KDRUzSSt3WdEZer?=
 =?us-ascii?Q?YeFC81nqFmJgZuqhQUariPYwOYP3xd/SzaByep48VFwx87k2P+fLKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jJDAhb82c+dW0AafOkd5R8nrRXWqaCgEqVyZ7GPbaGYpjqoaFxFokBSvxeR7?=
 =?us-ascii?Q?mUjYrf2nCd2aDB189Yy142nEP8byABqmOUkGdbwEGGUB9ToQZPD/EgTONCoQ?=
 =?us-ascii?Q?rezvuYlovnd4SiNkjJAyvBN8d7+ICFs22mbNAZcd8CMWvanln2VDUje/TKi/?=
 =?us-ascii?Q?S2GeeaHwlNtpWo6oUc+eU17ZeyEn6xqbz79c6XJfx7uiX6RvlTZkTabtyj7J?=
 =?us-ascii?Q?y0dqp/C3nsgH11YJdLQ/cuYMkl5v4Ggtguzf/zL5pq4y8Xn2v6pO7UwBVnvh?=
 =?us-ascii?Q?KfFPuHiroy3KpXkq8EhTrGiHLcMG9S0A2rvXaDBOmnQofZGiGzuMVyW5YHkl?=
 =?us-ascii?Q?pmh/+heAUDFiuYrQ+yAjXVlizW7jn9aMHNEPrsQ37U5G0ZjGp4UPwbPLS6f1?=
 =?us-ascii?Q?EQR0c1K/IxuAsRuQe9ljWd1r1lkfZdUFOm42Ns1G00KVKYaa1mq/eWw6QHmC?=
 =?us-ascii?Q?lLEZ0KtXLMjm04s89IpXixPVUTnO8AfWw9DFPycYWIKe/HnSEqZ8E1SjBdKS?=
 =?us-ascii?Q?CerAN48dLiRDHpQcD/9Z7sRtdad3MAyMuxDO4QsBqJ/HgtxuF1gg5azo/eXi?=
 =?us-ascii?Q?Q7TK1MhUCGzPgqpJ/rCc4VKuhNA8T57uj0GSW9VhL79yBQ7+EkgwLPo12ZrE?=
 =?us-ascii?Q?FmO6anpa+rp+uYSxTf5AgkxublS+pDAENVj1O1zA6OepU4+fMkkyjuQF7lyI?=
 =?us-ascii?Q?XrzldLqWg4EyF25lM20TXcX74TmHWEfvB25Lz0EfWusetDAMeamtcRxfPYgN?=
 =?us-ascii?Q?tHX15PBGbW0WpXKJW96yLFMZ3+L2LTxTWBkc86zfVcvold92pOsrelZKSNVO?=
 =?us-ascii?Q?vRxP8yrJV8xop18IkVlmzNe3pVhinmBpDsiFAcpRlekD/9VDFHvWMRct9FIY?=
 =?us-ascii?Q?Zo88Z2qecMy0tAiw16lk843KkgKw8AjDbdgEkxqU742JPb8uGHaHUh3i5919?=
 =?us-ascii?Q?fLBYR6gqbAWMfzW/0FlKMvfnkIcMlQsjtKtlZHljojsz7Aj/OTBr1lTFJsNR?=
 =?us-ascii?Q?yR+k6Qv4imwF2rsDApksQDkmUI2+9VWnoC6j23x/cwSKEe8jDWM6dxtH00SD?=
 =?us-ascii?Q?3E6PDfyzS3NXCa6F60iMI9O9gc7ruT9Wpy6UjPApp8QZpOwGJqiSFJDl2GX6?=
 =?us-ascii?Q?DgdSCarHVlGYP8vlBRPjaURrAbafOFWT/eEQh/ZZQhgrVbCs/gz7Z6rUS5Q6?=
 =?us-ascii?Q?C+v1Xm6MhM5BlaSF4+eViQxzcuRYMxZks1aLafKqRNp/JGZIFaC9OIJVh856?=
 =?us-ascii?Q?Z8dSoxmvNl7wA+hdbCh0pLNhrPFQn6BLFg95MiMLHM18HdP4TwGS3nPqF65I?=
 =?us-ascii?Q?dg0W7YotL/hAdWnXet0M5v1dGMeudjAk6IZQD4HnmRvaF+rnSUHLlRZBHthf?=
 =?us-ascii?Q?uQfXem7MvmKActsHfMuPlYeXCK6Snhzh5vi6bHsZT/u5E2hBpDuEwOjD1kVF?=
 =?us-ascii?Q?cI4PO3x5iC5Ra/qqoM6hulZm27f77+/M83XgAjl/ksIgovivdnDgNF4MF39f?=
 =?us-ascii?Q?p4FJTzYcIRU3mSFV+IhnNoWT2f9OwVgIt1uSnWRzlsft8ecYc8+WOu2P+Yrj?=
 =?us-ascii?Q?G5V9gkbnmwiQg3h2aLohmKAi0lu2+MzQdCkfXA+nFstc6VCB5GFafY9Pk54y?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fa79c9-bd57-4f4f-84a7-08dd7da77732
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:00:37.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rbja0Tz9o7Q4fShFWrh8Y8QtUxhuRqoH6N5YdmBM0Xhjv5m1YyFr68nRiLlJ3A1OudyCCpwRSj7m7jO0w+xgIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10560

At the time when bpf_xdp_adjust_tail() gained support for non-linear
buffers, ENETC was already generating this kind of geometry on RX, due
to its use of 2K half page buffers. Frames larger than 1472 bytes
(without FCS) are stored as multi-buffer, presenting a need for multi
buffer support to work properly even in standard MTU circumstances.

Allow bpf_xdp_frags_increase_tail() to know the allocation size of paged
data, so it can safely permit growing the tailroom of the buffer from
XDP programs.

Fixes: bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_tail() API")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 2106861463e4..9b333254c73e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3362,7 +3362,8 @@ static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
 	bdr->buffer_offset = ENETC_RXB_PAD;
 	priv->rx_ring[i] = bdr;
 
-	err = xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
+	err = __xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0,
+				 ENETC_RXB_DMA_SIZE_XDP);
 	if (err)
 		goto free_vector;
 
-- 
2.34.1


