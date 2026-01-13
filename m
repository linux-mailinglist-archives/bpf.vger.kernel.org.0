Return-Path: <bpf+bounces-78650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F53D16840
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14E5A30B02B2
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2B34B198;
	Tue, 13 Jan 2026 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ba9cZ+RP"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E8348867;
	Tue, 13 Jan 2026 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275044; cv=fail; b=OrI3Pyrojy3SYktHnzcwTD9+WbV27Hu5z1yzaDfPgLym/y3FIF4+a9IWCsPGbz/TauoFbmAnpvk5TmWuIH5xBUFFZMJqpZHxRRGpCf/2HbzqmfC7p3gLyopPoAVveL5Rzn3/OH/v4kARuWjadHZFLDObRJ4NccLerVrKwc2vaeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275044; c=relaxed/simple;
	bh=letWjcHrvK61jFUyl9Tnek/7G/q/1sZr89IBSWg919s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WtTibfR8CEZ8rQNLrdW5C4t8YToeTQ8VdTRa/WEfP+1p8x/hgR6HoxGRoYJbrssxnB82V9B9oW6EcotgEdM6J8zCCgozZt5/17+G7HaGwYikgonztg5PKAsD0M25Byc9Zqye0gCe5Ha/cFZmjXR8+OEdf4munKXEm9LbzpiIXNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ba9cZ+RP; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKB81Z3u+EAmWE7LdWqO98M4RPUdygHwdG8tzyvAlkS4sitjT4QSqg8TVtl1dHKz6BKomKNfl4qYJGoUuAD/0K6kn02sgUFlrAbgWUFYqTqQ/cBRfq1P3LTmFFknt/gkZNCWHNJNelJXErKSOQ9MD964T9qWvpNSe/mEQyyoDrJJ0a/wgK3zAoyAUlkNMeDRffVz90NeTZtKtoPufSsIDel2j8GlXgxDuj5ZP9ofEruXzhqb4jmPEMzQ3W4xu9+BKOYvl44eg68YmTbSx09ai3g5cBgW/74sxCj+Qq7FL9D0nur/gqI3jHLBE2cUeRC0ogldE7cm1bCvCcYqiDFArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvS/I843Ib6JayKBehG1jF02/Uyan7zp63+ha1lhY/k=;
 b=P4vFoD6RGTS62kLRxDR0bAC5NnpplNIjt3oQ4vaLbbxuWAp1gdtK39A3wRPbuXXGZiemgw4ck8WwaBptz2W4vShnAPZ5xKzKDY5zIIblklIpOO4xSdWGWhss0ffqxgXeqS401AgMuP9Q3Rc9el9UO5xyzKk49++73/jkgGrib+m7x1R03W/IQgYe9pGplmlSarHb0t/lDWP9JsmjTbPtbC47oQefXu9XZxuBim6dK/KnsYNJZ3F0R+mmoe08OBn7DiFT3ZQzeTD8dJGrA3oKdyl+hW4LT3o6nZV6oDlTkpJNiP/MHCXzAE0K5RqeAVi4cJPv4dFDVKmbvbBtg6c25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvS/I843Ib6JayKBehG1jF02/Uyan7zp63+ha1lhY/k=;
 b=Ba9cZ+RPJf8G782ZvXLj/CQWswuDmbeBderlj7G6r242XWkVQt/PxqCNfvhxh2DzPGeCQ0Yc0rWfWYw9HgS8Z8jDGtu4cH2lKCjSwmoYdoC0vrCqklY8WBj7ZeA7VDaKk2FWTFYBlDocjqwCXgfj1vXetShwyFQbOAkZcHSJB0PiXaSvUhtbue7kdWFbsWLYZ8qHJ9Xbuq83iYXM+L+UqVhYbKMe2zL8fOaUe1mX4QBJ+hwZD7kVw77wpzt30DSxslAvyJoRTgOynHf1yfGLqGd20nDN5NTSVBo48VXd9MtinvZrkeS6icxroFSIagyGgeVv++CXxloMThGeehrnAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 03:30:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 13 Jan 2026
 03:30:35 +0000
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
Subject: [PATCH net-next 06/11] net: fec: transmit XDP frames in bulk
Date: Tue, 13 Jan 2026 11:29:34 +0800
Message-Id: <20260113032939.3705137-7-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a5837444-181b-4d5d-7e4b-08de52541ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pn9EodQfX6weUOacWkCDUDhkuneSTwDaEifqCFZ85Wz38q0qszKpZugjqibh?=
 =?us-ascii?Q?JfIPjEXYz/L8vPMJYx+n8p/6BV/cJ9fCiIVAjs0WeZ6O/qL7pV7e/+Ud7OE9?=
 =?us-ascii?Q?Jui0mqdQKuqGEVzXS6G9e4gtDGE797ThrO0cYHknLF/dXN4+QAaFcwoYOqGa?=
 =?us-ascii?Q?1lnvOk+e7dUJeJJe2MLYYMPqmvJuIM1yh3lTTg/nUKLRkcsOxXl42UJL+BCV?=
 =?us-ascii?Q?YInrJXRuqu0sXHwJeSUELxA9vrzhfJlXzvuHhbygVBat7J+vz2IDvgua9r08?=
 =?us-ascii?Q?g59oPM/2GwaY0asKvrTS7V/WE5LSwwlHup+qRo+Qfw67L04jHr6v6cylUJu+?=
 =?us-ascii?Q?al6jXKzTDcLPv3VLgffs1SoPx7O+CqW+lhGH4vAJdw7LLiCIHYAOIfzf5RM3?=
 =?us-ascii?Q?YO/tnMqTtsGoTzE70wB0PDq+Bxmtdm/TSx7w62V8y3I9OwAhdAqDP1za6n7Z?=
 =?us-ascii?Q?TJfcGYRBSdRZZJVUV7Z/RusScbq6TTmrHWA+xhhe5GBAxtp9D1H6HP6KukWW?=
 =?us-ascii?Q?Nytm/7N1lleiEYX6yes/HR7dYBtAnHKEh8D4pR0Vrn57mqYo3uPtnwDueSR6?=
 =?us-ascii?Q?WT8lSHe/i2Q/H3PF4jv8bUYZ6TPODUYOEtINrpbIIPyXCcBbyJ3bbEqoKDfm?=
 =?us-ascii?Q?KLcQzS3UN13OXIXms+1I8Om1HgbfDf+8R83zF6eJ4G0jV0GxvZZqsIzYK6h6?=
 =?us-ascii?Q?2sO6Tt+Xy8DdMB/71C7uZxwi61atd/nHI+OyLzrJ6m3LrqVbZjTjhIZgo8V0?=
 =?us-ascii?Q?CZ8N2Ul91vqzM1hc7ePvhEXMHELZgJDOHdY+vymMYU6GMWpMtBv8zjC1IFGj?=
 =?us-ascii?Q?3Uj+BGZSRRvtieDXLVgV0GMq9HRBgmyyw/OQZn+Sg93DCue06K7QyUM8NkXz?=
 =?us-ascii?Q?ET8xjgxv8A7l7m/oKJl//wiCHDLlu2VSjtEjPuKFZW/lttd1J0jdbHsqnhuR?=
 =?us-ascii?Q?gg+LeM/oVWf9xMyDIe30hAO9Ll5ZG89JustbjF77hWApQQiNGgDKakfHPTXp?=
 =?us-ascii?Q?j004BGguRGRjk8kIvmEm9+Lh/ctboE9kCeNI12VyAoJiOPK8DNEBDlcPQrOM?=
 =?us-ascii?Q?PT0Y3KMzbFhJmSb618fsIzaA6KcpToMSyMbujl5AkKlVTUZmt/TfdUnDuRZG?=
 =?us-ascii?Q?PJ7bDEEpWJWcQR66JFvRqeVSqnK7PH5kMvv16eQHQpf2HvCFeHn235VuX4mJ?=
 =?us-ascii?Q?Td4pq421UmUGHQWuhnTmjx2pGbhKBZa3IVbCyw3GEyoLfbAJdI+xSmKPWB6V?=
 =?us-ascii?Q?ciIiOheUwK7qma4ojcSUeQ7B4s3ZXXbfZNbKnMn53PwwVaMWGNF/ZB9Uznd/?=
 =?us-ascii?Q?AkwLOxB9N+3PeqL1U5yhSl0tULi2uY6GSAQBRm+kuXW+wCOmFg+NNNincNwh?=
 =?us-ascii?Q?oMSeJz/P/nOy1mF4QMJfNtNmfBPZ2vAHV3BieKxAoAH2YDAgki75m2XmQQv8?=
 =?us-ascii?Q?UbBpaFr9D5r7EMk8g6+4pfEzMH/Vpx5rqYC629Bzdi38j7o6k+qnuWCw9QeJ?=
 =?us-ascii?Q?97eXqwA5NKVife9EtuWEXBvD3mjUaT14FzmgzCE5uUzS+AJe7CCTgadc/Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BvMQxqBFp91HcrPO6YkVpS02HRXBx39+o0xwj0pQOGpxrttIW6TYql0oc8Rr?=
 =?us-ascii?Q?gZNlHb8wXW7Xt26nOKINpSn2rxo1Tmu3kGaTjw4BBLl7HbN/Tq8iqEcO5lHi?=
 =?us-ascii?Q?NK4KXwvVGz86RspABb26D7xB2rahkLQEJtD7UpVIhWo9A4i6jipDFYc5HMFk?=
 =?us-ascii?Q?23Yn4gw9BefWLCvlMW9Hh8t0/WkJ1PAaJV3PqbPzsSpb6h3cQVpl5J0LOJ8j?=
 =?us-ascii?Q?G29zeaLJR8BZ0q5vEU82LLo06PsreFmfKmvBB2y47PPLdaeujOb0LZ0TLwdC?=
 =?us-ascii?Q?Vbhyr15S56yBhLc0A+7VTUVJUmhxVLyVAnF8CdWhNCK/aEFyzUjY84YM2YJ8?=
 =?us-ascii?Q?PH3QOxwx8ArvUiooAjxTLy6zPB4WLEqH/lj7OC+K3ZhlFLLdSR2HZI1uGgPF?=
 =?us-ascii?Q?BYKjCXjpk/tAcJyV8blCHUBN3xT1l8UU30tSM6+0qOqeSuVWL1wwAeA9tmWN?=
 =?us-ascii?Q?gewdUInaQM6Agoj238p7yiu/kO50bGfK4pnt0ZCk4gT+4D2uZAonNiOSvDXY?=
 =?us-ascii?Q?hg7BVryW+KJ9s9cVGM+zRrKq+l9PJZ9+zapu2Bv8AZ6OUYbi2WyawuY5/V2L?=
 =?us-ascii?Q?tc2Hk3rNzms3ybHp9ddt5cF3rQW2ziyER08AfamND6zP5Qb5gXWI+LqbE69W?=
 =?us-ascii?Q?6C5adBKmAYDiQ8gI3l0PFq932+5uibmylzYxYXQXDcdkajXoQgg7fZzr5BJJ?=
 =?us-ascii?Q?fWE8tslr5CpAKWZ8hrgi9iw5aG42JSznaI0ZYPcGUh/BwE5+jfvrEdbGjAMB?=
 =?us-ascii?Q?M+uQ34IP9/mnvj8mUFEKDfULFMbz41QTNQa38ShRDPhNxKr99RMhPb0Vmohe?=
 =?us-ascii?Q?nF5NTpZ4Acjo15fRC33+cD8IDiSBVVMM3KNarJFf0EHJ/vHWdoqyHXpNbbow?=
 =?us-ascii?Q?lNExLk41zw3uilp/CmaJYrvs4EBgKtiMqaV5LMuR7cIrRnN/RGsD1SH2XLCk?=
 =?us-ascii?Q?PIoey+qUO6miPiM4OzE9JNrbTQAG3ZJ29pie39XqnDEpQsfWvw34rRvhVJfW?=
 =?us-ascii?Q?Rx10qngAoko9Fmj/sp3HB9YU4JH6DaJ0+yYweDZ/cqeZ86w+gwgMjsbtShIA?=
 =?us-ascii?Q?dYHIOaxd02u+EbTRD5X4YvyCjZnSq8CBNvIKG52o9vfx4QQhXNw2ozW2UoFo?=
 =?us-ascii?Q?OnIwjOsFXvQ5xec1/OTT7K1Yf1P7RF13AtqlOGjk4MBSXB3OkO/Pf+kbkPkI?=
 =?us-ascii?Q?x4M881NwMNDR7GaOTb/aGfeCi/+blFTOfIFatFmbQAdZDBT/rYzR6zmQijmT?=
 =?us-ascii?Q?pn+KGfXxu83Z0FQJ8LfZ2gC/w9gQeUPdovycLgjHwEpyMyyTbZo8bDtdDKpn?=
 =?us-ascii?Q?tjztLyI9HVU91kVFuZgfGYhwsxLmZSGQipJqcKYM/1RoH+zcYH3xKc5aY+Hj?=
 =?us-ascii?Q?WPSgqZbfGbkOg3kCWAIfZezH+/1ib7D0yGHHhDJDpa8Nudf/ZAAToTJ3XRxx?=
 =?us-ascii?Q?GglwtJUz24fBes5wt+CYRLVzBQgOKdo9d5IzZ7JCRFiur7DpbDNLPw53NuO7?=
 =?us-ascii?Q?zJP4facZOcebZXRudDd76cOGeg3wF0kOPzuoPLkjYPcO/q/oU2GpBz3k+FyF?=
 =?us-ascii?Q?Vy/m7Q1WIiPygUfd2kujqAiROm2hE1YJN14Bkxox85pmXmZjlxJTIFV4kgnV?=
 =?us-ascii?Q?LVckImWIyqtYaeWem6lnjVm8SKriqoQMUKsyGhHa3cmP5ZLXTeN5l8ZHPk9m?=
 =?us-ascii?Q?bVuB7sXczmqgQ1qyuugN8ejeIrjjV3hNqAKwkVhmYqiZJrFAhfJrf/SViiQH?=
 =?us-ascii?Q?zEtpOKkFug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5837444-181b-4d5d-7e4b-08de52541ce4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:30:35.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/9H9BMe4cm7T7X35E6FKPa9zDLsoRlHWuxieQwgoDYnSWGCOhX0fPY9KgCFuzT3qsNUhF8xpE5B4FkNZHY1Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

Currently, the driver writes the ENET_TDAR register for every XDP frame
to trigger transmit start. Frequent MMIO writes consume more CPU cycles
and may reduce XDP TX performance, so transmit XDP frames in bulk.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0b114a68cd8e..f3e93598a27c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1994,6 +1994,8 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 				rxq->stats[RX_XDP_TX_ERRORS]++;
 				fec_xdp_drop(rxq, &xdp, sync);
 				trace_xdp_exception(ndev, prog, XDP_TX);
+			} else {
+				xdp_res |= FEC_ENET_XDP_TX;
 			}
 			break;
 		default:
@@ -2043,6 +2045,10 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
+	if (xdp_res & FEC_ENET_XDP_TX)
+		/* Trigger transmission start */
+		fec_txq_trigger_xmit(fep, fep->tx_queue[queue]);
+
 	return pkt_received;
 }
 
@@ -4033,9 +4039,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 	txq->bd.cur = bdp;
 
-	/* Trigger transmission start */
-	fec_txq_trigger_xmit(fep, txq);
-
 	return 0;
 }
 
@@ -4087,6 +4090,9 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 		sent_frames++;
 	}
 
+	if (sent_frames)
+		fec_txq_trigger_xmit(fep, txq);
+
 	__netif_tx_unlock(nq);
 
 	return sent_frames;
-- 
2.34.1


