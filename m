Return-Path: <bpf+bounces-40474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702739892D4
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 05:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B1C1C22801
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 03:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBDE2C6AF;
	Sun, 29 Sep 2024 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BofRoxdc"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1449F1E493;
	Sun, 29 Sep 2024 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727578846; cv=fail; b=LsNS99bJAlOWuH7rGuwN3rDGhQH/WIoJMVwvXICTYUvfFGFpTBVPGGQ1SOdmq894iP3e3A4BTIdtwbtS7lPhZB5wPS+8t9TB4sGlJHECGB6sLggRIq3gFT+PpSzsi/8d1C35CqeWiHBcU0NQkiicd3Hfj/XTPuib0AulxmY/bi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727578846; c=relaxed/simple;
	bh=jo0zcjTxPmpgKrrLRu7oOnhbPSzk4/IH5Sk+uHDJFo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QcfFcPnfyWqXBx4TN9sBv79jdc8aCSSul3Et3yoUOitSBtqAofvqtcRRd1jHZLxkT1zz0NXiAUyGIK8UKP/GIHBrIjwZP1t2C9a0AR6qOxaEOdPBiBxRSr/XB8WpsWjQc/hR/3xiTebL7jtNwT9qlfWrS8C+UH8b2ky7wurIzwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BofRoxdc; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rswECR6QI9am6u3A03rf6cSvu6JR3VoRq8SJwcZxBhbxLD8PAnDJGOkeyMy78++PVMdt5kM0C4JlI2PRPAxLnahYlDCoOALYE/3GNadJSCkXWIzPic/IccysCYwpMMpL+eSSLwrol2noMG1N0d5I6dzVUMR0zdGnjt+11CUShBljFAJba9WrkkN3HHr3QEFmj9Y5Ylplysb7PVHg9IXibk2UWULNLv1+fuhL+YnYnSpwrSjrkaA2RoGcNCxcFqbtB33+Dz5Y5RHfYWc5R4evF87BAkSZK1tAZWaZiNaX6QSOdxvJMX9vbP6X3TOOY2KVTt3SSQndWY7TQ+vnDEFmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3emIS0MbRnOt4rKCznCGzkjomRJ9jMyr6aiq5rceM0=;
 b=cqp7hRBmQhzLtSXWllnJKGOL3LaaNDD9AjTlH3J1aXE9v6Uh4ifKSzqmIGekALDMImYypxSt/f57BAWe93/cwlfNOpuLOBHCOcxL41JBLAtvtVmWhlKdCwNrIO144XxcB/m6RKIgAQTtnAyPynfGH8EBFXahxLg8DRp7xOx4Qwkl51uOY6Nib6GV7gF8jRdBuAKHmkNz9f4DuM94gWo2eSL6H4mMR2N4/SqVJY3c7oANbgrdTKGx/32DF1HNS5Gyu+6V5oEDvWc3Q0DbFurINnUrObUvjG6jpatlCK5G7TQOIEbLnxE1+1R5XS1cTewahy0+Xu2aXikjlOxkUwL63Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3emIS0MbRnOt4rKCznCGzkjomRJ9jMyr6aiq5rceM0=;
 b=BofRoxdcZgq2ikEcjJuw99n0Mi2oeNdHev1AWW5NqTBI7JMjGOQDSm09PGUtnEqkHIqnvCKlNOpc89nRsNB+tD2DlTHkqcYGeCWL6eFrdypGq2OeKltRredRiD+4qbIu4FkYuQFoIKJBwzNo3bkFmxUyUaI1rao5VHLgHphb44dmL67yrLtlQstHr3YKR00xfPt7MU/7BMO9Gls8RBlfN21oGc+eQDzKBrluq1m/S9RyJyU5KvepXLcnYQDaWT/WBRPOVGLCOPRLgHh4rt3fr6ymJb+Tz8kpQeDQ3y7oc6CD1JLMmWq0YEeVj8t6gxGkfNQEO+hKbR219qAMj6v8ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10690.eurprd04.prod.outlook.com (2603:10a6:800:279::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 03:00:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Sun, 29 Sep 2024
 03:00:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	imx@lists.linux.dev,
	rkannoth@marvell.com,
	maciej.fijalkowski@intel.com,
	sbhatta@marvell.com
Subject: [PATCH v2 net 1/3] net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
Date: Sun, 29 Sep 2024 10:45:04 +0800
Message-Id: <20240929024506.1527828-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240929024506.1527828-1-wei.fang@nxp.com>
References: <20240929024506.1527828-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10690:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f019287-2f13-4fee-17a1-08dce032e5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?woxNXBCV9kfIqmY/fUzMc9ySQ+8Xky/dWlcxrQmBmFPjTK7jDsY3ImAD1bnd?=
 =?us-ascii?Q?/oFppIlXVYdox86o7QqmYY6f0IfGoyD1sl46xW6swu28MxfQd7otN3Vt8w2l?=
 =?us-ascii?Q?54yUIGrnYjtQIN0aIUo74ka//7DnovM/BXAAmNvr3JyRsx74KVoUsxerjJOT?=
 =?us-ascii?Q?9WDQv6bJvQDXuPTPIlum7zMU8bKLVvlUgAnnFthyFAy8vH8dD7kGS8H2VxMW?=
 =?us-ascii?Q?+dSNRIeDm/4Sm215etkSNGSqquZn66tmSjQeNC2fGrwmzhx5DkNizTvsS5sX?=
 =?us-ascii?Q?W9e1G6LzDcULpKqqcdjr/Z4NSYX+VyT9ydqcBqGo66Ku9t5EsQE7CRfDu1wD?=
 =?us-ascii?Q?wCSg3Yv8T9z9tRgkOQcxo1YDuxZcssO+q0zWfYN68xOOeugorn2PfoPfAf8y?=
 =?us-ascii?Q?t7I8W2IUNBTsGQaQxqA33yOasHzKmWrdqf/TyjQNww9MIUfT53kVSFexJkcj?=
 =?us-ascii?Q?2BQ/YbYloQtxKPdPkvL2VF5nDJ1XYi7TwlKyE2bnsdhFs3+Qqu7ZDpCUfKYO?=
 =?us-ascii?Q?ZkY0lclUkzQ0ybn1cNEJJiV51pBfT7Ic1OuqKZ8Oft5UvDn1Epb3b5hHCGTp?=
 =?us-ascii?Q?FglvhWWOMT1fIl4ud9N13iCBRA2S32LP/WUm+a1PUa6E2TbykOYRjBx9B03l?=
 =?us-ascii?Q?EdIp1dZKzGCAVjugrPPhjmxoULvTRZCfZyJr7Dv2S3LqANTRDe9Ousu5bsBA?=
 =?us-ascii?Q?1ZuFhyLuft995Fh9+ZJ89uXJzhY+e6BFzJXCxczLXmwhRb+D+Fd8SQatm8lS?=
 =?us-ascii?Q?kwPgsiZy8/UY0n7/OQuAHvXG/Ytr1tW1UX7+IAwwePXDSHXWav5qoeTltYKN?=
 =?us-ascii?Q?OtmoNWBKXPtnjcuF7DLOvUrltC3rI7KRNvgsNO1sHCY7b10r6avsIf1oEfxL?=
 =?us-ascii?Q?zfBgCsM+V6OIKbc6aTDvPAuV7bjnwyqFVpeibcEv3PpksIXJyapNnoaSkUb8?=
 =?us-ascii?Q?Lmk5aldCtfSMLrKMQ5VQo7b8VuM0CrmQ8ler0Xu65PC6Z5REh/ooLQM4iKrc?=
 =?us-ascii?Q?p9GLtfBH8935ZBIpd7bMBvmEjgbplipN8bmkBX2yv7fPK/xKkv7708SJF+nV?=
 =?us-ascii?Q?g8leFpCe2RBV87AT4JZx1+Ki8ydq9Rdr4GpUb/Iu9SGkSvkO29KYJqJ00ssC?=
 =?us-ascii?Q?gZx+RjDDgnn/Mgu9vtRhFQ/Afi+HiwKyIwpBqk6zUQvbDXM7qf0BbBaefu6k?=
 =?us-ascii?Q?/BuPXtfSd02NkqnnO3Uy4QAKBdDHrgiXFz+7XLVGrlEeefIWYwHrCh9BAUP1?=
 =?us-ascii?Q?IfMBiIwg43v9H/oJ1QBQ5KFoGJjqOMPgOyqLHpAkBIwzuEMFIVn8p8vmyHi9?=
 =?us-ascii?Q?809dvPPIYttd9t4SR3d5Lst8lU1nLOssAgZkVvRNLFn6fTL0Tx/e5NeDTSrK?=
 =?us-ascii?Q?LVSPBUfPHdAVqJFsw6DKFeN9BvVDSfyoGHolXmojQMfN/SzCnvIBdmKcldJy?=
 =?us-ascii?Q?7O+1kG4aajE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ppi+iUQmNy5C70NVAQAfjHtb3PzczReNhecSNCz9PuvyAdLjobVHuYKnRKYt?=
 =?us-ascii?Q?bkEYbFVcu7G9z9ckT0Ie9YVdRUL2tOze1xPlKYRjfgSwKSoDFZGyjKAdfVmd?=
 =?us-ascii?Q?wf1vhwBiWOUudfupHzdLrTYoCydx7EbAC8q6GdJ7y53o0SA1IbbOAPs2+iwZ?=
 =?us-ascii?Q?4/s6mtt8tA8hMjqIYfUPrktFHHA2ofwkBT5nDeUuaU/Kk8swiE6a7saxLVoU?=
 =?us-ascii?Q?jSLe5+AxdPxr7U0pvk9nYi5+qZfFstSXvCB1jrPp27WXb8hrbfz36PolwXoP?=
 =?us-ascii?Q?ZTakeB/J+CZBH6TBJCpHSLJM8It4huOnmIotlWqELZ1EyEVRI7DccnltTZBd?=
 =?us-ascii?Q?U5iLZ2YqGrC6BMxn3z2N0atnwLT5uPPbE6DXBoNaUzAX9ScdJBZaeeX4ytyI?=
 =?us-ascii?Q?HSC93Rm2IZNwzAqk/hWh4bNEl7Z6ryWpgiExtUmS6GFiHZVLj4JkVLwFLIMG?=
 =?us-ascii?Q?dqsBz3cP3Kz8SZxfMS1zW9/HRXQtxRwcoWeByjbIBX4vWbPOYUr2663nW2F5?=
 =?us-ascii?Q?VOe2YgBDtJImEE6t3wHETCAEPUq4QMwQSTbDfRnQtsVsJ2A8x2w8bi7Bc9w1?=
 =?us-ascii?Q?ppXD8ii/PRVXFOOysLzsVcpoWsU7tp+74UBuUCjIN0sLBZy1Ln4MbdWe58ZF?=
 =?us-ascii?Q?usK7zhrYL1FtKBg9dhC/jPUkV1RKDL6H+l7P+u/CYttTJG1BVN2IMhrJShha?=
 =?us-ascii?Q?04BH83ljmjAlrujcxLm1VruxEO+WonG9gF3SyvSu97ezCCWVfRGRGPnlzEgP?=
 =?us-ascii?Q?XF9U5/KM5mnoLujISBHHMhpGbhc56LKwAFZPFaPiMFElWIJRQ8J5LHhc6sIF?=
 =?us-ascii?Q?Ket9eNa+T84zoS2hpfGCX+kaY6Js9QY173bXqd3EF+2h9CsMj0a9WXazZMjt?=
 =?us-ascii?Q?6/SYYP1JqsekpNMLGtd58akvLouiFm98Z1DLXnPgzhrupzdchcL3GQla2TAd?=
 =?us-ascii?Q?MuGWntQHQL/MpCoVLAD1qDDYG/TW3a4794jkvkINfQ/uj1dXwt9zGd2llFxx?=
 =?us-ascii?Q?c16tebYF3HzCXo8M26A/us6Uy244A4/YFUV/26bHoWK517BV2XVEPQfJVsSr?=
 =?us-ascii?Q?l6DnnzUxXfe69+X6AleuMYf3noUNFt21qFheO9qWSlSuZhdRaWIc9ZAg7o6K?=
 =?us-ascii?Q?g2vV6q1TilCnlQEMmlAELQnqillvZCTymVLjELUc2jDUwMzg/t8vt2/E824J?=
 =?us-ascii?Q?bTfA+/Vb6JqYl0Ggg39qEmkqTQERp3rEq5UNYtDt/NjfGtzne7NJVBKIFKG1?=
 =?us-ascii?Q?ReN2+kEzViguZQbDVuVHYN6xgJJM5X331mjTlzsYoVQJ3cApOZq+XjXcTB7Y?=
 =?us-ascii?Q?sTqq1qXqbr/TFKYv7GTmewt9Fpd8kZnQx3HGmrhVkiIv7TDAuJ2PrjIrM2Qw?=
 =?us-ascii?Q?GDmsb/x4tgP3VZP/KijBLFiRuSFwslMjIbAjOUaOQeiNC4ZnEjjCz6laDr2J?=
 =?us-ascii?Q?S8HGqSAqxv70llB0YhUMRB2H2Yr/VIK2aX8wtEIpxCnXwnwjP0j+fyKpr+ZE?=
 =?us-ascii?Q?JZErFH8Cr1Ng5tMqXmFeLIpMTt1Lq3a2R5+3I0RB2I9I+B985eN/Fyd6NYPr?=
 =?us-ascii?Q?LrKyCtIxXLtpAiE0OZLmEU0XLqmv6pddOcg7Cfus?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f019287-2f13-4fee-17a1-08dce032e5a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 03:00:38.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ys/LEiJCL4fw2+Ie9rxY+nC9lljQoYm68hjSziaBAKSp6I9WXqrWRapKK4KqV22wfMwZ3Ak2H8pxxeA1yDK+RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10690

The xdp_drops statistic indicates the number of XDP frames dropped in
the Rx direction. However, enetc_xdp_drop() is also used in XDP_TX and
XDP_REDIRECT actions. If frame loss occurs in these two actions, the
frames loss count should not be included in xdp_drops, because there
are already xdp_tx_drops and xdp_redirect_failures to count the frame
loss of these two actions, so it's better to remove xdp_drops statistic
from enetc_xdp_drop() and increase xdp_drops in XDP_DROP action.

Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v2: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 032d8eadd003..56e59721ec7d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1521,7 +1521,6 @@ static void enetc_xdp_drop(struct enetc_bdr *rx_ring, int rx_ring_first,
 				  &rx_ring->rx_swbd[rx_ring_first]);
 		enetc_bdr_idx_inc(rx_ring, &rx_ring_first);
 	}
-	rx_ring->stats.xdp_drops++;
 }
 
 static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
@@ -1586,6 +1585,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			fallthrough;
 		case XDP_DROP:
 			enetc_xdp_drop(rx_ring, orig_i, i);
+			rx_ring->stats.xdp_drops++;
 			break;
 		case XDP_PASS:
 			rxbd = orig_rxbd;
-- 
2.34.1


