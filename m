Return-Path: <bpf+bounces-40081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBA897C659
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 10:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B292A1C20888
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E301991CD;
	Thu, 19 Sep 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxE15vaw"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1890199240;
	Thu, 19 Sep 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736189; cv=fail; b=FJKac9XqR0p79FhCGEHPF9UGbzBSEcU8Jq6XYA9eiDYY3FDMh0LaPQubWDqmflVAlKhi1uDVq1guvkjIyiv4NG0fLpNiGYhGGQEmNIpAruAOZQwrcPbEpTlJSj6jDIfZX7oMknQedBUwP8ys6kXGo6Oy9RDSVTRC7R9SlWAWY9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736189; c=relaxed/simple;
	bh=HhZiYKornp5ytnDoCd2esR31fqRIVo04QywrdpKwsYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YsPBB97n/lem0siCN7wyT3JrO1caigg8SrOL6R2mfeTq650CpFwXtarDzTlZk148RMV0bJhxgjCh8BbP1hJqNpFXUI6OV4kY+Y5gCL2I6YZWQWpnIwksukFjijx2x9JTqO7oxIbGejreSpyH84BUrxXgqE4AscKWwlqtqIGsBp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kxE15vaw; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8mX6uraMy/5wI5aRxAz0+g5k8CdjNvkBkB5y/jiEbzChwFkMIFQph018MrToUmU5t2NtMkVjMWBXWJWL64SfdCBC1+s8NmqjBa7FRKGP9dnRZ2Fo5n5o5aC6sJ9g0HTQcMauSp1MH4yTWUcAiZsd1PHgnQa18QrF7PWZCgbgr+S/rzU/4esXMUwJ/6KCS6a9Eu4qe7UYqaNY2Gi0HIJJz9rGiOV70huVBBirwZlIWg8rBAA+qGsmsQ2j/LuR/mUePYrv/T2pyL18uUHcpOxoFJ19lD4/dZtajT4/4pJLOw85sd6QadWfo5WCm406GCl0Ct8h+H+nGjd8/cm4+Cr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA9MIuYWcWZejfrz9HxIEAn8oS+/fbp15DCAFJw4vMM=;
 b=bbgBCVaKZ1YZqA/TgMBF5p8SmLC7vwv7v4zqRIUcbU+3UN6o1ETSnRVC02DJrKlhln8jcrs2sLB0RNUcYqo9H7uVYzrQwRdRO3vju4LNi4AdcYw9GyngCnx7R53RthOOH8GSkG6u+P/EcGWtI1L49hngIR0XlqfL1b3aouVFPI9R5q/kZQqOEMGRSLJs+X7rTKhdw+Vs01FjYswUEAClV1bm65zC500WK143hi3KJxJ5tmyNFGhZTFUY9CfoMGF6USqOe/VZXpeFXr4Sz9B30Hts/H+vpad8d74ilmYLT7URKuEFR32+JHmrPzXB6dtIMNVeN7z4A2ny8kPK9zwQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RA9MIuYWcWZejfrz9HxIEAn8oS+/fbp15DCAFJw4vMM=;
 b=kxE15vawP21eIesh+/kd7kJTBZ70UCXIppWuBBV0T6cTfOq65uCIGlZrpdY8Y4otJijL+EGJ+65+3z0eOoAPE2xot0F6ykxwln4HtgLuIX/cbNMLxHLZTPfkIuGGJiQVUIL/8UYSkqkJLBV7dbdaJT5T55iqV3nFsiSjUm7kvQWrGpViMEfD4u/JhFXoVjOoim3htSGD9r9RXPy9qr4aXSadfXgG70/kgFUnG61m6OTeiTzNoauTGumXCKiv0X6x+IvPjAmFfLINhxtYN/XabavG/HXJK6lFit3oXWWaDDThK4131GhAjoqsOipEPrSUiSCa1oOVpBHARGeQ6DQqHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10242.eurprd04.prod.outlook.com (2603:10a6:150:1a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 08:56:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Thu, 19 Sep 2024
 08:56:21 +0000
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
	imx@lists.linux.dev
Subject: [PATCH net 1/3] net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
Date: Thu, 19 Sep 2024 16:41:02 +0800
Message-Id: <20240919084104.661180-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919084104.661180-1-wei.fang@nxp.com>
References: <20240919084104.661180-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV1PR04MB10242:EE_
X-MS-Office365-Filtering-Correlation-Id: 031a7fc0-2afb-4da6-a75f-08dcd888eea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cobNhYE3+D3p9ZQBfiRk6esjMrbf7SOhbghYDAAsiv9x7nvGAoo+fpfeAe1e?=
 =?us-ascii?Q?6A4AycrEDb8lZIKFKfoqtxfJHDrCxLr1b03d9lQIjwKr4xjQqMpOeW6mh2mI?=
 =?us-ascii?Q?KdVpBavfd7IYiIVpjAoZ2TJMzhcIw2CXCkvwKGbrZTdyGDmWHpv30I7jNIvA?=
 =?us-ascii?Q?mNcVEsrNWfilOmvUuCrrh9wvB5Dgq2hLFMH1MMDFDMpSRWb9dosSlM/YP9ZJ?=
 =?us-ascii?Q?fsBi5ZZfpbmH7C2w0YPJ9fh8L74zzp2g3Uxeoosn29/Iw+SBonpZKwk1Rhh7?=
 =?us-ascii?Q?KtB8TlyCzC1hxK7DvQuFTJW9D3Bz8aDet+BOXuZF0ovZqXd8oJjSmjP6+U+U?=
 =?us-ascii?Q?8LGJqJC6nFUmZ0M6GPi9cBctp9APw5OuEq852uFQMq8qWfcL5agrgaW0vA3m?=
 =?us-ascii?Q?48qZYJR/jmvRfQJobetSpPQ9i8vjs4E+eEQ2u3wVdZDfhY7gAsQAjwqdJkD1?=
 =?us-ascii?Q?XdrTuQIqg7j23LMAzy9N3O1o4TWMnhk8DIAI8Un2Bd7xL/dAej8+IgHt5xu5?=
 =?us-ascii?Q?1ODB3Q8HWvSXOmT0IUjxki2YktVg3vaUxTveZhO6b6jhhed84MXXewpzMrL2?=
 =?us-ascii?Q?EitNfhytV++R8zPqh8Xv5GnEJjzMTUvvZAuTKVU42seRR6EvwuOtG6puUF6h?=
 =?us-ascii?Q?Cf+wmhSHFXePd1eVENVlpHvT11/tAJktLDz/93/SGQ6Qg4sEwl9ctOZOdCfh?=
 =?us-ascii?Q?dVhbPKQ+H0l1xnz6N9/7dJPlIuXkZRFmZ0GRQnY2xiSx5DdPia8OpYym8c5t?=
 =?us-ascii?Q?6vf2RcorjtNh87YtQKegph1Cc9vXf8kM3GcAFSHFQSC6nb9CdWg2PlPqtKc5?=
 =?us-ascii?Q?GAopPUrmKyKY9wp8S29qKQqCoqMGmFt/qOq4ACxvb3qAWitPZaEJNglCANhk?=
 =?us-ascii?Q?o3+7AefsOjhERhZ0j/lMfZAg80JohUusu5kIYAKacQz0FZqCG0wtm9WNislu?=
 =?us-ascii?Q?iEkxhEiW56hMLqnQkYBzv/Qi4p3ZHN2E/whCvQSyj9GeApmlPD/NR/DfQisC?=
 =?us-ascii?Q?lKtH4DNyjsQS8XLKTIw5ugzKlyjnTOqxgwGvNc1z1KKfKl9cH4YYbApk3HHd?=
 =?us-ascii?Q?OgW60YyIuXN9HX2ArPlmhTU81G5GkUCJbYndPz0fkSxBUvYZgzswt4mUiPOC?=
 =?us-ascii?Q?exzEqC3xX/79YANgwl/vfUsUDjXDGOj9WH8J1oI8xUsa5V07rxI95my7nDYZ?=
 =?us-ascii?Q?GxO9RO++oXhRqBWEb4nMUeVtIlF0hssjitFCpVv4ReDmcECf97IDoDXM364s?=
 =?us-ascii?Q?Vj3MDENu0H9Yha+yjmoahKL8wix8rRjoyxCbmkdYVXJ1VFtGDEIC86wXLlcu?=
 =?us-ascii?Q?HGDWSbC+B3wBFVO1EheV3WaT1nuDX36/4ospociADHdryBprROkmKgpK5MMH?=
 =?us-ascii?Q?H0J7B4ihZepo83tpgsgDqsChAcRXI5WfPtCSCTLERa7eR16hi7u+T/Ua5m3a?=
 =?us-ascii?Q?D8n2HgKo9To=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?83SoA4rCdJFUp/9DuLuFgTqn+CB6hJI1EBU7bYSY5fL/RVRbFSzdwuJELDID?=
 =?us-ascii?Q?qJnLhorEukI6Ti2T1bECsRO0UuKigHB6K3iy4RlrXZpWBsQxDAU/Qz2D4RPo?=
 =?us-ascii?Q?a/lipF1YFVCIBbKwWA/YEk33sLcReTZ9XnQ+RXE+4bfUG2GctuYEQpKBxeVK?=
 =?us-ascii?Q?3QUxKogRUHpO7Ebe3uKLWl5CAXEAwidhphMoSZ9Dd3k8ygzrHq0sWwq/8ddD?=
 =?us-ascii?Q?nCMMigJBC0NvaZzfgPqOkKm+dnGpuOPqhToe/ANTTaJ0Op1pOTIU23qJL3ok?=
 =?us-ascii?Q?99mrUMU3VlDCB01VOFAa7wLIMVNH3dgnaAM7lGtG4yc2Gboi27p8hCTV3wsA?=
 =?us-ascii?Q?6gDZN9S3bEzK438sk04XFj4DwdHWxKeGJO7JmSuSnygrSLuU9Gip9ovOQNmq?=
 =?us-ascii?Q?uNTnf6A2jPgSCrZ/5Z8Z7hblb9LWWDHRDSxRZW5KY5Dhc7Kt0VR0QTtXwTNP?=
 =?us-ascii?Q?MPWmWRCkjI5RMwHN6b+PvyKgartdwCS40yWb3vQSVskr0pZpIA2bdQ619aoG?=
 =?us-ascii?Q?xVZ2Cg7YnPKHuyxkgGLPHNvT2mY3QQhhDVtjRgKdHLZcyg9El9lYpQTPFCvU?=
 =?us-ascii?Q?5y29VYXdpeWl3yq8Qwy5/VNswMMnLhwd7ILAWy+4iSz7GxpHBh3aqZmE/awB?=
 =?us-ascii?Q?rBWyWPyMne9vJvdtiqSggJBbbdOQzKBjN4EOIa0yHrji3e0bscGJ+D/jmcmn?=
 =?us-ascii?Q?17Qyd/2+fi02IdQbpCuf+R+oYB8Pe1L4xGQm5RiyoNgsw9tBdo+9Z3Ac1c4R?=
 =?us-ascii?Q?ILJZte9CBy4vzjSuN5RVieiLEV2p88Jg0qHjX+zpOoIhXFIt4KTJYgbmrFq+?=
 =?us-ascii?Q?jnipjfc3O0UANlpUxRW82OYBMky4AejfREy4chbqGEK2Q1ow7pcA0nu4igjY?=
 =?us-ascii?Q?T/4ODlbN20PHE42sZ/IcK36h0iZ1a2Y7PU3kRo9dT9w8r3aMSkSZVz7qZsoc?=
 =?us-ascii?Q?pKbCTTIoYc7cC5LHO1kEoYIzcKRlCO4xIy3XQcO0ThUvR+NstjBqNK+Ek49r?=
 =?us-ascii?Q?UGJn33CcfzgiIy2U2mEVZET1p3dZsOSUEAUdAZYGjcQMwWGygt+6TCSfsIev?=
 =?us-ascii?Q?yeQTFzFnFKtw8+vOkJrKnnB4OZo0R8+p5G38n2GN8szZJCmHOLI7oSoQpCkS?=
 =?us-ascii?Q?Xui/qubdXZjAfZF0v9ItHqvsvUPvAXigOf95U18vF6IRjNe8Dcxz8UiFlT1g?=
 =?us-ascii?Q?qgHG1vnG/eiausoP7AT1S3l3dBriJPgRLT9jDzV7j5AV8p3Hf8K1do5Hor4Q?=
 =?us-ascii?Q?y00a8mzuACanH6WDUVbbAJS9p88QWHSf9umvtRMcg3gXSsMi5OfQOOQ4UKF5?=
 =?us-ascii?Q?/Of69ERNuIh0nCD+RXOZMEdYzDvALrCyB26JcyzT5FihPQoa7vDSk7SkxaDz?=
 =?us-ascii?Q?F+6bxdM6fNff5+B5ISnCMhHDqxV4qBnfwX7FMMNgeKjyb4PVyWMUyIUT35Pz?=
 =?us-ascii?Q?nLMxCEu2PJy+sZuqvkFAQGaWls1/FD1BoY4igVTEsoaUpGefieIGLrqIHrA1?=
 =?us-ascii?Q?iHiHaUGeWIAImeWpvxJwg5hc6vgTGUpdbavh5mYO92V0JSIdS1J1rPdAR486?=
 =?us-ascii?Q?ryWg/njuQQ1TGG6a6AFblyFWEekIRh4rTB/2aX1y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031a7fc0-2afb-4da6-a75f-08dcd888eea6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 08:56:21.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCFzl9DSgrRmRpk25xm2pq4N9EFur0O95C3rPt0Ad2c7yjD3SVx4Jzyj7YbjjyJAUP1Re3JPvTylOt2LsPgwYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10242

The xdp_drops statistic indicates the number of XDP frames dropped in
the Rx direction. However, enetc_xdp_drop() is also used in XDP_TX and
XDP_REDIRECT actions. If frame loss occurs in these two actions, the
frames loss count should not be included in xdp_drops, because there
are already xdp_tx_drops and xdp_redirect_failures to count the frame
loss of these two actions, so it's better to remove xdp_drops statistic
from enetc_xdp_drop() and increase xdp_drops in XDP_DROP action.

Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
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


