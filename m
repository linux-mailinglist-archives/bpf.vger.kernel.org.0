Return-Path: <bpf+bounces-78654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B55B2D1681B
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38C85303AAD2
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376F434B1B4;
	Tue, 13 Jan 2026 03:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hdj4F7X/"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68C434B402;
	Tue, 13 Jan 2026 03:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275069; cv=fail; b=sW6FmZHx98ZtTtQmKFBZBU+1YtVr93KJqc2kJzQe3jgcKyN86NVbMJmrVsb9/2JtAkS2TaBEwRjUeNTsMvvSznrp/qINDHyUT3OUE04JZq1Duh9JtaHp7UHrzN2Go1sQsDoTlnMnd6R4W/iiIK8BqGU6CR/JMKsAF16tYsRyAOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275069; c=relaxed/simple;
	bh=oVTzD1gLqn01i6SBFxjXrPDWXmACwnncpBuJwm1BgAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VRiqLOUnLgCAAurCmPSLdGrsHmZIPjySTh1SLs1Z7xQNdaBxpPBV92HIkr+gak+WvEUYhhKI7ba916m2sOtIj2xxeDvX4dS4KiHrydUraHhm1n7hS/vOnREDU3TdqU1svRlJ687amdnaQXHU787JQcmxpc0lYUBqGfJptYVNa/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hdj4F7X/; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seL8cpO1fnhkTiPhGanj2T/nNc6RG/Q6v4LVmYdtKllDN/nZ2LqP4yrNpl2hwBA+0Zxm83Q5UgKNsGpQcFuIuhHvAlwpWKPKNJkp83WMOGLRSmxEz/SYKdbxIW6tK31uKVHjh3kZbEHCB8LaEIr+7rB9JceGg/Bg3H16+gRZL22I7mwYY+p1M/rZCyeLR59D2qqeE3CV1jLN9FmmjptNJf/ExdQ12NNJHhNeGo1rg15m244nWaYcfFgBU0kMbA6oTrGfDTZ+S6jQNQ84JpWyCqUbjj2fce7SYCGX8aiOTXYJL5awUFSqB8MIylCMP4W5zsuaQCD8rV2nGkP9vQYUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NPe2F00KRzLC786klaJ7SAzjlzi1y6U3TGecRkLxU0=;
 b=U9P9LNXoPiAa1GvpsKZ/TYjiHYmpNu1jNWYvdvAA7n5PHoiTh6jPbHkqExyqUYZVgkQQ0vmo7sBaR91Rbodyo3CXIu7g7OagN4diq/O8cWgoOPVcuXPGJUG8Sa2xTUI3JgLxMjTK3DxULQqxWk9ZBUllALYrAemOXd2ILszM6+hNnZ7nvrkrGEvzwM87Ne+5dAmtxtdEVPjKccF5RjtxRORrAXUucOjXzinoEjmYQXDMBQbxLTFy8beYOe+jnZDXqbrXlEP5+xWZRhZqO6yev397PK2a6S/+w/sgA34z77xq3kdG2doxL5L8J06nJpeMSPmV378WdKml6F5SeOOv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NPe2F00KRzLC786klaJ7SAzjlzi1y6U3TGecRkLxU0=;
 b=hdj4F7X/3QyezlUIR4g7GsLvGYs2tnkEIvjuKp1Ws9NCcpH2nz1Dlg5Y4TSubwYdYQwAsqTmLB9s1jbFEXVtqTVi/y4EZ1JvuQuCh5gjLjVUHTz8ZDmCfYGH1i0oQdlqaQTsVTvSKu57fA/iTZaomV9sCaR1RJQISMk5LS4VlbzBgIfpK9fwHz2qPy+9KYGLvZ7vJd4PQd9e5N7/f/ZstOPtpEEU76qvePx6Uarw2KrEgT4CmwsJr3IzSRSKMAmkovj1vjD9pO8Yt/hIi6oEbxRlPcZVaN81/yB9YivPJttIn/qOFGx2LbK6cSuAkuDhoa3sO1NWC23/4TMcz2iZPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 03:30:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 13 Jan 2026
 03:30:54 +0000
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
Subject: [PATCH net-next 10/11] net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
Date: Tue, 13 Jan 2026 11:29:38 +0800
Message-Id: <20260113032939.3705137-11-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a4ebc5-18ac-40ad-e404-08de52542858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5XRDaOwV4a+BS15HOADzG+v9AfMAmuqtMpks8QAKlaomDMGyArmp5t2ekxJG?=
 =?us-ascii?Q?/PqrpCyPt5AJv3mOZo7rpDta8VuSASbiIqCyXppCJBeIrH1atkpS2WGaOeYX?=
 =?us-ascii?Q?6V0wT/I3RG9oM3AoeX1ZUaIvZAqXox8/Kd5uJw1s5rYEpxOqxSeiHK9kszte?=
 =?us-ascii?Q?XuXiehsUUT6pxK9YIQuE6miTJM7oLIJxls6yLxb+Q1qS7B7bgnOreORFSYjB?=
 =?us-ascii?Q?XxlKpBhuzqaf4C2MrvcyUQq/056JDazJ6N/+vxbX2jdTa4hutPMdbifAFhih?=
 =?us-ascii?Q?FfoFZC5A0sl0A9AeBRrgup6GovrEaLzBO45SfwLJ5lBwCF2CTMIFtgoyRlRu?=
 =?us-ascii?Q?nBBJYgHnkjNcP5DzS0TpQhPDLnj4IQdSQB5+CN0CGHP/jhUscW3EmRhzEkEm?=
 =?us-ascii?Q?ejQU5O8Z2alKnKV8knXasU839WbEof7oh1CmaIRLOU9q3bD2sbhzldDzR2bn?=
 =?us-ascii?Q?yF1k2aQ/3fdHtF+BMXI9FiPjKqRjTnTPgTBmgtzFLodjN4pdgdJpYyQXI8U2?=
 =?us-ascii?Q?Z+H3MGsPLermJEplx9q6RjVcM0sDTAzNsXfkAres+/dJ0hdmqXlQDA+kb9kK?=
 =?us-ascii?Q?jKxKFffSfmC/2fmW9YrOjEj4eibgHXPPZ0DLum0DrvJqSkDSywt0mQ5CKdj6?=
 =?us-ascii?Q?Af4GMv4Inki3cgT/HSWG49j93HHJ9N+fWQayFobDq/QNB9hclo7m39NezwEC?=
 =?us-ascii?Q?UKbkTsXYjvlbFv0FBXjgJU3EnKBVUOdsMauQORwiE79mbdqGXUafzTkqBaIm?=
 =?us-ascii?Q?dtF4yRI2WIX4O0V1r0o0gOYNsP/NEAcc2RmCEYrc25uWR+xHrz+yWt/B62wW?=
 =?us-ascii?Q?8+6GHpZ5lZCc2miDZnC2EvhMvw6vSVkhFCOAZeiPDeEEfvB1jXiBEn1KOYjC?=
 =?us-ascii?Q?5oUMRZuC2bGvb0qSsvXojZdnQcI0nCRhGvEDz2LrQDicuDfCidtlh09XdBK5?=
 =?us-ascii?Q?RwzbheteRaOnJ+bKkEObq2r+ILJBx5958IAgTqGNnnuj4VwErH1UbBy4zdW/?=
 =?us-ascii?Q?t3qkpQ2Hy/ypMQpXfzr2hlrOPQ8jcM3Jk3IctCpG4tl59DlfUmkkZ6Felsl+?=
 =?us-ascii?Q?KmjyjEOlZvpKmW+N2OTHgWHrmdrm8P/Ugxjy2cPCmhvUsqKquzjpUHtwNHdj?=
 =?us-ascii?Q?NYMyqaQIMG5KZO0OGSWgZ2uRRt4llBl20m6CHnidCi5Z4eQf6kJNigXopi0G?=
 =?us-ascii?Q?8voJ1wPdMeC+qjTlagWGlqMbBI6UUpHw+NRwFcJb4cHJF9TxMSm2HqPZAELz?=
 =?us-ascii?Q?yHyGv32cC1yuFhKPEaXQNtIx7ZG1xFMAs+dXNYOvo4GP62+D5ShPcVaGoi7J?=
 =?us-ascii?Q?kU7ew8uWqLq0ZZ5Lhi1dmX7kGb7R4bPj3AN8PjJHqR1Lr/KnjQeGsJU6tfvU?=
 =?us-ascii?Q?u9XeovYc6gUxKbHYUfU7tu9+tQrwT0YyNQaZO1JfDn6qYL+ooxMMPwv7ihJY?=
 =?us-ascii?Q?J3pH1Oqcgua+vHzfQdmlLojOwowPzAq9Q/xu1VsIFXxoUJ0gypxVEW00mjps?=
 =?us-ascii?Q?wbE1wUyVdhbAO2AZCLPOYlUYTaoj4FftDXf3+eiiFhykaAAd/Wcj/Fl+Vg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?naYTcIx7wpyWHEitDYMkgOl5hZ0No8YHOK01voIkC5ph42+U4xl1kfRewVBE?=
 =?us-ascii?Q?lGPvbK19c2DADj26IHMgA6ZV12XKzq+Z8i5pO4EBx8TgDMdUsL0NtEIZvffy?=
 =?us-ascii?Q?PrQNEQm/pqCIzik2jTDbwHNcRfHF3hcZAX3mXn+k8WV9y3BkhFF51L7k9E54?=
 =?us-ascii?Q?anmC5K/9O54VW1sCwEuWch47gT+kkvA65HSEASpQ4A9wkC6gJ/2vhuZPz1L8?=
 =?us-ascii?Q?3wJjFjcvRJsEZnTk3D35+e58UUJ75o4uKysLhTUQOI9ulbEIioqUjksQXbGz?=
 =?us-ascii?Q?w5TpiD1v/odgc16P+gvnc7/6benkktZF3WayW8xkuOPpLT6HhqFXPVEratq6?=
 =?us-ascii?Q?LLiPmakCSqWMY3/XB+RW2Vp5edhf1qQUMoSJIzRUPnmtzsLZlFEalUuVQNiC?=
 =?us-ascii?Q?XwM//Rg/etu3Qkc33/6xmPC03h6rRQagXKvrq6jVx0kA0V8M3lGsnyqR0ax7?=
 =?us-ascii?Q?VUK0azMRpy4GIVeG1UEtP1fxisblLSW1SM29O0jaAuQzRqYSVbmAlJp4quBL?=
 =?us-ascii?Q?OlqN83rhQR+qx+nygNvq4SpmZiK2Xywjz7iKjkafKeJb/JbjaipZco/NXa/W?=
 =?us-ascii?Q?Jd99BM14wcpuP0ull6ZFnABDQoZ4I8PSCSs5W6C26MY1xgsBXOolJBGzOJVE?=
 =?us-ascii?Q?yXAvP9wUXxRujiJSKi2QjeVIWe+bEZ0Apis91jvgJ/gG/BzJvkB6Ym8xgW22?=
 =?us-ascii?Q?kOebP/Xg7q2hvVJvfeOZ/Rmh9DalTeFVucepM3b/5juea8AppmnbwuxailvM?=
 =?us-ascii?Q?PHeX5rcDYm9RMuobaP6/H53esN3eTmrkA5+HEouZzlZlq7hpcSWasg/q5VvQ?=
 =?us-ascii?Q?7r+qW3TnkvwMhoc4xC+/uuk1STuwM6ITAD79uw4beHvCpsjtYVYfe0yrof2I?=
 =?us-ascii?Q?mjqjp3nIl03erG4yBoCyHJj1Rs0+wsO2/UbiY7X6lP16JugS+iVy6DQ4qazb?=
 =?us-ascii?Q?fpoY/xhMN2wF5mL9zJOEYpKLKIq1FpnV3vxCndF3cp7EPSLpoVzrLwtIE3jK?=
 =?us-ascii?Q?e6BF3wKD07JmiDeI3uWJHuxFvz9xtxFImyq2y+sdjbJs//AhAMLKuORoxnNX?=
 =?us-ascii?Q?84wEBkeMyuH4QBzj3b6LFSuv1oqExzittZUlWiPaWJz/hs5Zx0rulbKeqmJd?=
 =?us-ascii?Q?0q6nVZpuUCjD8RbqUw0zIloli2ybf/S/RszQUZ1VoejsXj6Cz4cB1WOF3oXP?=
 =?us-ascii?Q?/yZpdWr1FWDSNshm2AgbCQVnP4B9XnSVn245k4OBo0okAk1HOK+pmbZwnfoT?=
 =?us-ascii?Q?Xu/BkLFbtkLe7BGNyO9KRKF0owLFJp1yBc4P1rosLwSoj5n10FMk3Zt7/xoH?=
 =?us-ascii?Q?ow1kJWhgCuknxqX/s0aeAt1krrN4FrEQ4UkqX4NlM4Y+vZA8YDFYn7h9b7Tg?=
 =?us-ascii?Q?qsygcxEsDDkNbhS0uzWvZ6LblLO/1AID/a7jhJry7afntJM/sytvdZ1Zi++o?=
 =?us-ascii?Q?JIAK1ENK3LMMzugyBpkF+k7lPefyQC5AGzhGBaiX2u12nZ/uslKpElSknau0?=
 =?us-ascii?Q?BvJ2dS1Jg0aRrU/dUoWg87rWRUdM5fAEtVVIBSIImQx6iil2uBRxCbfGQoV6?=
 =?us-ascii?Q?wQLn6SNo/ck+FM2Aygtxi1h0/SPZv+2quXsDYPoAIcY6ev0tslSEAfZSkDXb?=
 =?us-ascii?Q?A2Hj9XtfgPAoXuUkv0/3fD1LfZg7Nq+QjKg7dMfevOWB8XBrQPWVH10ScCoz?=
 =?us-ascii?Q?K/1tQBVXRZbNO0AwXqwYVqsWV+8Yw9wZLTYrai/ZpvLg5UHzYjZENckRXP00?=
 =?us-ascii?Q?XIGYVOZdYw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a4ebc5-18ac-40ad-e404-08de52542858
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:30:54.4050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfL1YvI3HDTR4PAMam4gx26i+3PIEysH/H1xm5fuPQLzbmgt4eziCiY/dznfIj+u/2COscp4Z9ebFAENJJDKtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

Currently, the buffers of RX queue are allocated from the page pool. In
the subsequent patches to support XDP zero copy, the RX buffers will be
allocated from the UMEM. Therefore, extract fec_alloc_rxq_buffers_pp()
from fec_enet_alloc_rxq_buffers() and we will add another helper to
allocate RX buffers from UMEM for the XDP zero copy mode.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 78 ++++++++++++++++-------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9f980436bb5f..29ee9e165068 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3419,6 +3419,24 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
 	}
 }
 
+static void fec_free_rxq_buffers(struct fec_enet_priv_rx_q *rxq)
+{
+	int i;
+
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		struct page *page = rxq->rx_buf[i];
+
+		if (!page)
+			continue;
+
+		page_pool_put_full_page(rxq->page_pool, page, false);
+		rxq->rx_buf[i] = NULL;
+	}
+
+	page_pool_destroy(rxq->page_pool);
+	rxq->page_pool = NULL;
+}
+
 static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3432,16 +3450,10 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		rxq = fep->rx_queue[q];
 
 		fec_xdp_rxq_info_unreg(rxq);
-
-		for (i = 0; i < rxq->bd.ring_size; i++)
-			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
-						false);
+		fec_free_rxq_buffers(rxq);
 
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
-
-		page_pool_destroy(rxq->page_pool);
-		rxq->page_pool = NULL;
 	}
 
 	for (q = 0; q < fep->num_tx_queues; q++) {
@@ -3540,22 +3552,18 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
 	return ret;
 }
 
-static int
-fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
+				    struct fec_enet_priv_rx_q *rxq)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
+	struct bufdesc *bdp = rxq->bd.base;
 	dma_addr_t phys_addr;
-	struct bufdesc	*bdp;
 	struct page *page;
 	int i, err;
 
-	rxq = fep->rx_queue[queue];
-	bdp = rxq->bd.base;
-
 	err = fec_enet_create_page_pool(fep, rxq);
 	if (err < 0) {
-		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
+		netdev_err(fep->netdev, "%s failed queue %d (%d)\n",
+			   __func__, rxq->bd.qid, err);
 		return err;
 	}
 
@@ -3574,8 +3582,10 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 	for (i = 0; i < rxq->bd.ring_size; i++) {
 		page = page_pool_dev_alloc_pages(rxq->page_pool);
-		if (!page)
-			goto err_alloc;
+		if (!page) {
+			err = -ENOMEM;
+			goto free_rx_buffers;
+		}
 
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
@@ -3585,6 +3595,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 		if (fep->bufdesc_ex) {
 			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
 			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
 		}
 
@@ -3595,15 +3606,34 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
 	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
 
-	err = fec_xdp_rxq_info_reg(fep, rxq);
+	return 0;
+
+free_rx_buffers:
+	fec_free_rxq_buffers(rxq);
+
+	return err;
+}
+
+static int
+fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+	int err;
+
+	rxq = fep->rx_queue[queue];
+	err = fec_alloc_rxq_buffers_pp(fep, rxq);
 	if (err)
-		goto err_alloc;
+		return err;
 
-	return 0;
+	err = fec_xdp_rxq_info_reg(fep, rxq);
+	if (err) {
+		fec_free_rxq_buffers(rxq);
 
- err_alloc:
-	fec_enet_free_buffers(ndev);
-	return -ENOMEM;
+		return err;
+	}
+
+	return 0;
 }
 
 static int
-- 
2.34.1


