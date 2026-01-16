Return-Path: <bpf+bounces-79215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51DD2D634
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2249C30178CC
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4073A3446D0;
	Fri, 16 Jan 2026 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KoIri8sx"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AE34253A;
	Fri, 16 Jan 2026 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549399; cv=fail; b=s0TjoGXqL6VifRqaepo4aYUxT7J7te4QJWYgzF9e+1oCr/t1ziU01RmAsek1CghItMlrDV1yfwLjdcphgb0t7L706Xg2I7Zw30v9OK/Nwwkfw2cfO/19ScHevB/umD2IxejGYVKxlcYfwAuICtY1NFEwf9PHSWHVPryC5zEcP3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549399; c=relaxed/simple;
	bh=YBAgYoOqmMOKlA1DgG3Um1YFaHxmrA69l8XooukTo0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXJ68WoEHvH7MCgYJ4eh6W1nasMc8+PBx0aCujhW7bKJv9v6SGh+PD3pg0VYWXj77nKUQ5YZIhAM0Y822Q1U35Qp99S6dULvSpIN8vdKwKp3s340bs6RAsCT11Qgh8wanRU47EdjJuQ1TiP/Yvv6f60KaVm4lXK9uOCAvZfJ/t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KoIri8sx; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucHR9on4/fKu1MJrQ0kAd1G/rW42tiGj1VOpShVAQ7p3HlwlI/FYwtIBoJQr9ff9am3w5DlwqUnF1gfSByBF5zBAHDkZdIDM6dcixQ553bwAteG4qfdZnW6VlDiav7NMXEKAnaBW+5s0c9QN7AN7FTVFGkCtY5jEwKcK+g2rZT5/CUiOqC24Bb9auHGU4NQJDmJS1aLJuu4kLqqbKUvsfeouZdDVrwtdtXc8b4GpBovxfJbg5kOiwOEle2GbC2bt/eDIZ5lIgcdd2dUqsvkfJqSCoNp1Sy21WOF0WNUAYJ08C6vdjpZZbx+tHRfiU7Ih546iJeVhl2anHQ39uwwu6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOePn2XofGmm6AsWsoUqvTRXyL23SFInkAp8wodxhYE=;
 b=KUSUffZwf1uNe4opnP3mNRtSEj9OAsSjPrkgD0W+0OwFk9vc+ijD5wODbach4g28H53wJXYyrnHQjQyV7eXPYJ17tcBT29N6uFFLjjD32ftsOMmrK+785VDpM6CAsCf3kLly15T9xNlUvWPJUhK04uAlGMk9+qdxMPoWMUgbREYJzthYjit29hGf1RV4pPbSZCNgT/Jp9gdxWs9HXcZT1YcumHTUvT7JIOYg0+Rx9++ElMCkMG9dvsGUZC1g8HLybdTvwYzMqxLGEZgYMwpyKTlqBd3XM3aLqmuqCTVIXRv0Z4Ul4VaA/qWQeqyCzD9TNgncwNAIefxLpmCT8YiWMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOePn2XofGmm6AsWsoUqvTRXyL23SFInkAp8wodxhYE=;
 b=KoIri8sxxYpGCdSYmJXJ1d/yu3qYJMTLMrOgrUzqpbtRTanFixkiMD22NrwbuyetCtciXfdAJ8zzNBaFJWVaePiC6roKGOOkQrVl/V67QK9IvS/IHBf7BEpLQlg3FF2vR8N65YfC3721eHnEYBf9V0/yhfcHWZLYbGu1OkVEbcth+sfhjjcF5C8+wHBQbwJzPVr3c7gikmZl0RkafZZW6mJ4+Wqn/KxHQGlwgxo1JqRp8Lxqym6iRIjXLpYT1/KICogRG+F1J1CID/VesXmN2FLkAXUfU4avGPDa9XGXL5MxAni4We1GPlpZZmC6eJN2As3CK6iO+oZKwtuuv2lcDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 07:42:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:42:10 +0000
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
Subject: [PATCH v2 net-next 13/14] net: fec: improve fec_enet_tx_queue()
Date: Fri, 16 Jan 2026 15:40:26 +0800
Message-Id: <20260116074027.1603841-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116074027.1603841-1-wei.fang@nxp.com>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0165ed-6357-4638-65f2-08de54d2c1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|19092799006|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DPnxmaSTs12uyUxg2TP4Ax1r+qFOG0Jg4wQ/XMFAf/GjXlNA2Ehr+HoMgUZA?=
 =?us-ascii?Q?Q1+i/+YjJV6ZBpbNluwg5FNR60+Psc9PujkLevx+QZ1StdFRcR2c+d6A1BEn?=
 =?us-ascii?Q?8Xen7ANmDRv82IOLhQ10w/lnvdTmkdMTPJkE8ibLJednOG1hiVvTb2gCbWcb?=
 =?us-ascii?Q?n74BR6ftMx63j8O2tvJ3VMbV0na734hdvpjL2EWNgz+VCPdeIYhnvp0e6lUf?=
 =?us-ascii?Q?VKk6Thy1PVlwc4Kha9rqfP5h9u+7sAmGNyNkWDnV4ci4St72c6yH7zPHGH7X?=
 =?us-ascii?Q?WqUdMD+BqxzrtD/rYvDonLXBhV+AlZ7Hy6lCcw8NJ6CBdKY7nRAvPmHO15YS?=
 =?us-ascii?Q?S4Zb0EzfCKDmp9g/ft5a+BsCX0I1MmstsV+nqY4elz8ZnNvOP+WkWKC2QuR7?=
 =?us-ascii?Q?tDZx9KyJrw/EgMg3DjJkxRj08MEszm/eIjaqIgN3/WP7qUyg4pG6DxzJV5+H?=
 =?us-ascii?Q?9sX9nnm0LKCCTPGZCZyNi8iAJVlrUkSlpZF7bpcFClkXMsXgMDxGCrLzgKhH?=
 =?us-ascii?Q?TNgNjxspNB6KUndjWzLQ3cwPI8XPqYjmt2iL2vSGcYHJDFaMzARKaRZp5fqN?=
 =?us-ascii?Q?Dyqqrf+nj5nD3YNXFxh1hUQ9nxKbFY/cKrViSahNs5jXzJlPVU8C5E/aP6hj?=
 =?us-ascii?Q?mO5Mt0YFKvK2x5XSVmERTLbPZ+f7lL4zIJ4XRBM4r7M8hYWUA2K26bJYd7jB?=
 =?us-ascii?Q?5wnoncItnqBZUYaAQ+8vOIMduKRaJg6j/MYtfuestkEKsKh9UTvwqITCKztO?=
 =?us-ascii?Q?+3IUIAg0LMiLe8thuCVbwnYZ7YHborVpM5fs8eldx78Wf0qN0ams+fExrpP+?=
 =?us-ascii?Q?L9TR8BI9etKsHGt2igi3X+bPawb9eZc4qQXBeSdFp0brFpTt4+9O5OFzk3tZ?=
 =?us-ascii?Q?4N/tnA39uzvV3GoutgGYAtmJF+XKjnnA4bKqxgEEmUYV105XgFsu5OIeuB+Y?=
 =?us-ascii?Q?cXB8iQH7C264eiLLkAcvZ8sHPY5dKkzz84fqkaCXXFg9JRl+AprqeIwQruwy?=
 =?us-ascii?Q?sISNVtwI3K6Hiy/9xxxXiQNbfJ2o19IsG0MACBilo4OYz30T0BYa39dFJH1J?=
 =?us-ascii?Q?5yBp2QfnZiD5HhoUu0Q5qocMvmeOybtZ1bhOQXDLbklJYvfnOXaU9crUDHHH?=
 =?us-ascii?Q?nJT1Ot/i9tqFC8bNaCX3BtnMVS7P8F8LZzwe763zIKO85A7kKE9TQ1oMwk26?=
 =?us-ascii?Q?9iuxZjBKXrXEIoUCGCiSo2Gc8K/TMnxySCJ4rmtSziSQ1KB8DgN7RuYwWUdI?=
 =?us-ascii?Q?ocTXONrjsNL+OfxsRl7czpZHYaCrkeXApmXJptdr+mXVxr2VgDJuwbDZq3j1?=
 =?us-ascii?Q?/iuxSFESkc5Ytu6/IYkmM9mKl6rYZfO1KkIsPtg+xbWyigm5yjY8mLMIAC9J?=
 =?us-ascii?Q?iosc53paB1deTtszlPfVyTZASgmtKYul9wv1hMA6/L8xgE2Hbghrn4zvxaeh?=
 =?us-ascii?Q?s4NbHQrScRuphVJW5TdqfvapUZugxj8vFQZREKb8Y6zbzu30AUSgn76a3dtH?=
 =?us-ascii?Q?2d9XiV3T6m9hWV9oB4lsaaHJN0EF0+H6gjbZk6YGScR2ZdQbKZaDN8Hkmo5F?=
 =?us-ascii?Q?CHJDw0w4/3LfiRvgvx9yz31fWhIQN/kLdioWYPBLObau8HECOX4xqtHwTkju?=
 =?us-ascii?Q?wou9Ec+evyfxeSC4n1YE/E6XMcSrHGvBBC+x5ZzTqf13?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(19092799006)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fBtGAUZs5KM/tGEGeb7tzSQWHCHcLXTrKOFb9GPLgLYiLL3ZNsYu4/vqfFwu?=
 =?us-ascii?Q?XOHjG+hHpReHslo1Yje3EG0yAOMZHG532d40FbVCDW1UNHcanxB8Hdn/ZeP9?=
 =?us-ascii?Q?v8hJTubVMPRTEfxYdQxIMHfrJLedgTa334rqOme0EXBplEVOZ9uqD1f7nAIZ?=
 =?us-ascii?Q?PfUw5BExuLfGH6qILRvji22RINwSdqKBQ2Afcq1AY3DGRePABdZWlUFoImla?=
 =?us-ascii?Q?6stpfV1vG0ule7dIQuzMAc88qJ79MOivFz9rhs9xkDlFkMeb38g1nrspSZTb?=
 =?us-ascii?Q?g7eXOIpR75Wqpt07NI17y+90/kGPvidSVrSBr/Xme3FAOyWz86/rDxNoVvX7?=
 =?us-ascii?Q?vXuH2zRO2fN+zkkLOi11dlSLIlLiOvcXvdwi4x3oteioGpE9KAV03OvDwAa8?=
 =?us-ascii?Q?EPLzC+jlZIIyo4w8dpGuDH4gWg+9GsVZc9gG/gWMuyjW6Hh+BDM0kcmFcvdK?=
 =?us-ascii?Q?ljKEmxbHC6LOYnhXHtTWSGQjBOJq8jJU5x2Kd7R7+xNAomtJinPd75oDCsr0?=
 =?us-ascii?Q?pZkmLNbtGYfkkmfU/wpBDopQujznpkTsnShkV8Of6lxj6JbtbqFbYqKWf7kH?=
 =?us-ascii?Q?AcrwgFzaXdx5ZYuiuhXiTIunfugsLqoJPcVHDJnmFruAVSvaL3CCcrCnh4Q2?=
 =?us-ascii?Q?RDlkCLIf75pnrlOaId5g/+VJCW2+rB2NQjfnXHJTMb4PDEqNtHR7thCxaUEV?=
 =?us-ascii?Q?2R4deKers2vXpYIg+A00qaHIO2VBF0VcrIAfjo8wB9pK0ZMAbEnNpD3v6fSw?=
 =?us-ascii?Q?UH+lE778ZofJkZmdLus2U+fM17HXyUy14s3HGiPY5H+FzZuVWJ4p+EXvkr1m?=
 =?us-ascii?Q?jEF4WakbTGqkZBmgJ+gygIDrWCpnepFBql0ADEmw7aNvUUOHuMrY7wR4ipRq?=
 =?us-ascii?Q?bkEc+8lWUs9Pu224oIt+bOeDBRtZiRyci3LfmnFwmpD6Dy0ss5Fdble5aAFt?=
 =?us-ascii?Q?VDctJpJWzb6pnRkmW79XZ/NAkFRFC10VCyV+UZ6VcfjFa9BFV9E1tAQSGj7E?=
 =?us-ascii?Q?9Br9mJabZFhwG+CDq7Odu+EFFmY2Gbdif8sS+DZ6rZTZib+xpzmT1+lcEy89?=
 =?us-ascii?Q?Fx/Q6EVAgBm7rSVQtJxk2raWwCWdhFLEjgc57N0H4zMgwR9JFk1pvuGJV6rh?=
 =?us-ascii?Q?mIGhSAL6yz5S6MHLCvvwJnbCV/I5tas+ZkybiIaxo/OrBWqPaYCm0zgHAwk+?=
 =?us-ascii?Q?BL1RMx0R+/usKXZ9yLn/WUIAPe8csAj4wjKdZVL+ck7dQyYFNw/mMpv32wBK?=
 =?us-ascii?Q?XihhpixSGGJQIX2hSk9yFdY27Y8+wMLImuhvevHp1xxmV7ENdz0gpxPbXY67?=
 =?us-ascii?Q?lGIoHfVJben+c8R0Qdreubtj8JgRfEQ+lHL0tO0fv02cl3LRrPPz03Vlf8vb?=
 =?us-ascii?Q?rdxX39v18NrW8zSMSornEoho82h4Sm0HGJLfcMet1QAl3OKffFo8iUtln5br?=
 =?us-ascii?Q?4VH6S8hEWFegATR4SboD+Ms/meYO1nndgkhTOPopCQafpYXFL7CkIprAKUKC?=
 =?us-ascii?Q?Gv+1Si5azRci1G7LXspVfsr5MYC9pfezjqUziUHyftzkWspEtlYqtjpeWCns?=
 =?us-ascii?Q?f/ZZxxc0TjOjIkt1GskclSP1enDfXAcRPZkrVa86a1LqyLn9DrYp3YW52yJW?=
 =?us-ascii?Q?+UCXqzqu3AIlRroROpx1w+NzqwRwM357WgT/iFyOr9I798l8npnk1rGt+EoE?=
 =?us-ascii?Q?8A+uUcX7eWdynuuk/Dkkc9Bs6TlsoKxv7VRjj8cqI56M191hLY/a3sz5ZF1y?=
 =?us-ascii?Q?1kInpj1RYA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0165ed-6357-4638-65f2-08de54d2c1a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:42:10.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keHwE58s6M8xtQi7jZHYM/uCfKdfS04R6PUoASKiyxJY8ShD46Ri9GQLsnOBDpTSd4slQ+ZixCYvJGWedxcCiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8712

To support AF_XDP zero-copy mode in the subsequent patch, the following
adjustments have been made to fec_tx_queue().

1. Change the parameters of fec_tx_queue().
2. Some variables are initialized at the time of declaration, and the
order of local variables is updated to follow the reverse xmas tree
style.
3. Remove the variable xdpf and add the variable tx_buf.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 43 +++++++++--------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 68aa94dd9487..7b5fe7da7210 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1467,27 +1467,18 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void
-fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static void fec_enet_tx_queue(struct fec_enet_private *fep,
+			      u16 queue, int budget)
 {
-	struct	fec_enet_private *fep;
-	struct xdp_frame *xdpf;
-	struct bufdesc *bdp;
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = txq->dirty_tx;
+	int index, frame_len, entries_free;
+	struct fec_tx_buffer *tx_buf;
 	unsigned short status;
-	struct	sk_buff	*skb;
-	struct fec_enet_priv_tx_q *txq;
-	struct netdev_queue *nq;
-	int	index = 0;
-	int	entries_free;
+	struct sk_buff *skb;
 	struct page *page;
-	int frame_len;
-
-	fep = netdev_priv(ndev);
-
-	txq = fep->tx_queue[queue_id];
-	/* get next bdp of dirty_tx */
-	nq = netdev_get_tx_queue(ndev, queue_id);
-	bdp = txq->dirty_tx;
 
 	/* get next bdp of dirty_tx */
 	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
@@ -1500,9 +1491,10 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		tx_buf = &txq->tx_buf[index];
 		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		switch (txq->tx_buf[index].type) {
+		switch (tx_buf->type) {
 		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
@@ -1511,7 +1503,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 						 frame_len, DMA_TO_DEVICE);
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			skb = txq->tx_buf[index].buf_p;
+			skb = tx_buf->buf_p;
 			if (!skb)
 				goto tx_buf_done;
 
@@ -1542,19 +1534,18 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			if (unlikely(!budget))
 				goto out;
 
-			xdpf = txq->tx_buf[index].buf_p;
 			dma_unmap_single(&fep->pdev->dev,
 					 fec32_to_cpu(bdp->cbd_bufaddr),
 					 frame_len,  DMA_TO_DEVICE);
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			xdp_return_frame_rx_napi(xdpf);
+			xdp_return_frame_rx_napi(tx_buf->buf_p);
 			break;
 		case FEC_TXBUF_T_XDP_TX:
 			if (unlikely(!budget))
 				goto out;
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			page = txq->tx_buf[index].buf_p;
+			page = tx_buf->buf_p;
 			/* The dma_sync_size = 0 as XDP_TX has already synced
 			 * DMA for_device
 			 */
@@ -1591,9 +1582,9 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		txq->tx_buf[index].buf_p = NULL;
+		tx_buf->buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
-		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+		tx_buf->type = FEC_TXBUF_T_SKB;
 
 tx_buf_done:
 		/* Make sure the update to bdp and tx_buf are performed
@@ -1629,7 +1620,7 @@ static void fec_enet_tx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_tx_queues - 1; i >= 0; i--)
-		fec_enet_tx_queue(ndev, i, budget);
+		fec_enet_tx_queue(fep, i, budget);
 }
 
 static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
-- 
2.34.1


