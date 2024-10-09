Return-Path: <bpf+bounces-41372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222EC9964DF
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9E6B2458E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE4418E37A;
	Wed,  9 Oct 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GLOKp76s"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240CF9C0;
	Wed,  9 Oct 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465503; cv=fail; b=uGufEJe3LY4/U8dug3EsSuqSTAc74svkHOBIWH9MuEnXFPz/OwuZc6brZ14/+HlC1gKKDYK444wTil9mvHDIFtHtx6382KGd825/mAoHyF6t5Q9hHwA2EsOiTBr3YkCR9gwcgwQr20b23Vy0yKbhHBE4lrb25Y+bJ6qcuriBSyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465503; c=relaxed/simple;
	bh=yG6zMOIrUy1VozJLeovt3JsnwrjkIXFUHGzqiCfjNjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUx+FnNdkV/hlcD3X+q7bKrcC1KlxjaJMGe7VlRGtIuvy/tt+0ksK3eVXXQ/ZdQ4NjP9r231BHUUM5XyCoYn/WSrZvbqZtNUACZ81iJqL/dajCHOohwkBClKtQ/yEF6bo26GUB0ZLGx5dSmGZAe3ls4rzEHNT5QTs+RkBlGJzM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GLOKp76s; arc=fail smtp.client-ip=40.107.104.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WR2L4dbtalr7QjazYMEEEcrFIGQx7GhOTeGanyNrR4YXmpxLU4T1Gvw95w0c/gj9PN1quuqvLPLKGbXhYeOPPfbUFx0Z5Zwrq3pR8/nzvjdy3GoQOrG5lVvFxPpuS8YF7Ks/sJ5I4f02BgAJE/BMkPs6VcBHqBMtANBmBNNFTYUqwbQdtI9CjfYcro3ZyItUi0hw4gr/DSlG7YSwH3KvS/T4ch+8G+jh6ItkkgLe2W+W7kP62Ig6FVEp5ZoKgORLFf7fc7Hwm8ZvH2Q/xjOBj6m7/OS4/1TsyhwTWeH8VHRlH+m/YKWBp6NfSe+nj8XIM3EtzApUayNU01opSHHxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+UT3Aj9pXKHz1zIEj/01SoRaXU6yDqUrDa5Plb0JcE=;
 b=lYU9LlsMjpKfaHsE0X4jPUh9jVx82bvjmAa4BaTqcg4SpvJql8SZ8dtyZXuRK7Xav/f2EwUWL7u4UwUN0Iy4Pj4kme9HuH53FuT3xM7NCHREaYSPoOhLy0s05cT0eFdyxwBXiQoRnzMagcMiCkzgwLbSR1RtFT3fA5nuDUpjGF60Cd8qcO9nSeFtn6usNBEhSUg+dLetaLDTQ24xlsQs85j1lZpOfadu3IP3I8QhAll+X0OVNuBuBTloF9CTMF46m598w0iBAMfJLAJWYC4w61Dv8gyIiJKrR9ZVeHGLnd7yG6CmRnIKSebhCVrPr5UMqRxyWLy9OB2mv9jqtzA3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+UT3Aj9pXKHz1zIEj/01SoRaXU6yDqUrDa5Plb0JcE=;
 b=GLOKp76sxnIWjxF2fkiEpJG+8BBlAtjQZMsZWk5WN2M5IzbtjYOBSL1lqjR7mB3qIGFoV+7hdnSDCJ78h0Nh3AXZLfeq35oM/Bor26ITULEbW4KJklTJ4VAnfKwmlwxDWp+ViL7VqeZ00SitrpBA4nOkr6Xd2O1/0rGD25FN5RifbWoCL7f3efCysFZC+HaJ897dvvwhpk11yAMp0kRfGuhCBQRsVH7TYQsn79h79ck2jrgmTtnIYBOojGS5mNIDCPs+OjzEgi4FAWv1WB/ulKGEtCBpv/gB58wdLt/TdrZl+og22DJKzvCznFuJK48jBGgrSK74yq36Q9ED4GrKhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9318.eurprd04.prod.outlook.com (2603:10a6:102:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 09:18:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 09:18:20 +0000
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
Subject: [PATCH v3 net 1/3] net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
Date: Wed,  9 Oct 2024 17:03:25 +0800
Message-Id: <20241009090327.146461-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009090327.146461-1-wei.fang@nxp.com>
References: <20241009090327.146461-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:4:7c::30) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: f886636d-260a-4271-2fa3-08dce8435111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2e3c0uH8LfXBj9qZwFS6h4VOWIupoeIwqmPJ8QkJI1M3kyx1hdsW5hZzmT4x?=
 =?us-ascii?Q?V0+dE8fwAli+6XQJrqG0YPVjIFhS8shdxOHlS6F2bs6dQY/GoqQGeKIpdlK/?=
 =?us-ascii?Q?TFRLWJUer81sg9HGLc6pczpQB1/gQPna7YiqZ/j1CqAkm2DTIo3D5P69OrtA?=
 =?us-ascii?Q?rw/vqO9tHKk++3nVIVPT7lCCuRAeJtqIIZDvKwv4ZBGoYYTHmo7sqNa3pJb3?=
 =?us-ascii?Q?Ebrg9ITeFbRYn5i9R5gFgzaetDZgFfB2dv50KgROR2UFV8feFMqkmCnndZ1W?=
 =?us-ascii?Q?jKUUECzTf0CDBjDSqpbN1X7UCF5JMg8ReJQOz1DkvbVsmc2tDOqH4Xv9A86+?=
 =?us-ascii?Q?dL1OxQdw0bC6yenXMJ0bFdFDTVBKAc+Can/OKgfMrCg52tWkvQ+NJklqepzW?=
 =?us-ascii?Q?VYKfB8g1/KntEiuZ6vKF2g1z23cktxmG7LYYbqaZ9vPiy9WI1toDPXiwRYkT?=
 =?us-ascii?Q?c/wyuLKQPDScbCjsudU02nNyhoAnhynnfoqVHa07mN6P0u3W4ScgUktoAGZ9?=
 =?us-ascii?Q?88sQHcnVb2GKeNTHljn2XzmYN3QbiTUXM+fgKATTkVwAMSEAVUQ6BhwQJzpZ?=
 =?us-ascii?Q?tFcPUX0oNcNpJYd77B6jXcp/0mrl0KKjmmXt2pIk5+9JH1VXReI+5Kxn0a2D?=
 =?us-ascii?Q?K8+WMbv12CiqOubgJI3LuMZQuWSiNMJkuEkm8QdJxrvKyeMGQk+shBkbQ3gX?=
 =?us-ascii?Q?GP2jnnGhDrZYE4osaxTCIb43A3htDR8qg9kaBCpWc1+0Rtz+OcH/X6sl0pj8?=
 =?us-ascii?Q?8LliecqtNRXDbhNHqE5ImNg1vdryv6WKemBENZii74iGDC1uBlf0I/bl0D5+?=
 =?us-ascii?Q?tmnT3keLaYJK9s5SdWvmtwTzdaj2FAQ2C9aEa9Qxi+PRAdliuHDTyK52dxEU?=
 =?us-ascii?Q?cDz8ouTRJC1f3SsXUFU64r+Ty7JuUJ3elB6VViFufhdhgiAktCz5VyzEt5h6?=
 =?us-ascii?Q?cihsCv3ZqDaqrFYg6bt2x/D1b/yO8N2aPLQ83rgKThYoAC9VYlDTtT+AfXN6?=
 =?us-ascii?Q?bpvDGqkJ3eVb0Pd6iRczLOcg9lA/CKcaEjs426VWdp7tghEc7+AfuOh6JnuD?=
 =?us-ascii?Q?Vgt96ze+L4ZeRLX5EWayS40wq2m6Tvy2teeNtQCK/Io9pU1t5gqq2bFyBU7l?=
 =?us-ascii?Q?RuNFBEEg+aDCMm6kQGVhlR+dLzs/SW63t6wAD9L+e0CiQ/F1xYJeHemsDEcJ?=
 =?us-ascii?Q?D4HOhk/y1gujk/JvZ7m0KIJRpAnaoyBfb3yaerPHc9C83yVOXdK6a/lGx5Kn?=
 =?us-ascii?Q?VHmBuI2UF393BqGtFR5V1Xjfv/GiSlCjmFZOFOUtU+//XqpiU9YmKbYdvs5K?=
 =?us-ascii?Q?eHQynowyaOWRzCktUXCkSS0zyisKu81Cwjdn76sp+pWc6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?92SmKzujttIfEJlINMclSc3voUZZNJsRxEBx8vY47Qu5YXCtKYrFGC1Ul2Mt?=
 =?us-ascii?Q?xrTSkI8JbY86H9IQSirNcIhaWFFb9WIUorz+/Yu22udCJRrM1SooIsYHWSMV?=
 =?us-ascii?Q?eiNKQKNZMGtX2WBUE2KXBxpTtjTVR4rhkxT5y67HCZNR132nmsxZfs8HjpJ3?=
 =?us-ascii?Q?fmUCEEqEBNSt2BGuQS1lACnPxcKmphRGjQPmjeW2nIZaCtPp2xUeQM85X65e?=
 =?us-ascii?Q?gagBLecS/2FdAP9e4JW9cyxN79fqHUxEkiReSkyMhkIbdcX7a9qZh/bw1453?=
 =?us-ascii?Q?ooqxcgUd0DriP6PaSCUli6o+fBgiwSWp3ofAty/egIFrkq78mbUiXo3nKWL+?=
 =?us-ascii?Q?7I8PQv/zSyw2x/qQUVL/1jVreoiUqJLSkiQBNSwuBUch1N+Wh704WsTxm0mz?=
 =?us-ascii?Q?TgFPiEtUZ0q4oryutWMTGo226qTFzJx+PboXoEJEPo7Gs6mLD/O8u2jSa4go?=
 =?us-ascii?Q?eR5hGtAj0kvihqAXDWnxAlnJE0qiLkRUNeRrHgA94fGzQguW9TcnhUC3PbpT?=
 =?us-ascii?Q?fClcZAj4cls9ZAgsixUZCS0v3GrfpmslFcUYEScB+nIp/juX+KEG3Nqo8ywM?=
 =?us-ascii?Q?/JUfBorbuYuKC1JbVp/PCIiPpXoJB3jmFOLSuVt/nR4rYx8Kptx1BkhoeWs6?=
 =?us-ascii?Q?91bxQTAcl//mJKLOP1iTyAFYoQGrsUDQynhzMBX+4pRJHz0YHYEgY6rlwsyx?=
 =?us-ascii?Q?ALKdbqaB7/rH4fuLz0l0trIEGSyv/amUve94yXAnY2BblIaIeOyVVdRQLrn8?=
 =?us-ascii?Q?9nzRJpHNA8+sSMNvuwARJZ8mw5pFW62+MHIS7HtdYJmnKc1VeU4KxFYyA4SZ?=
 =?us-ascii?Q?i/TpHduEEmdrr+Pn7JkeLvXIyM5AlcHEvufRPOxdmUz9IpD2wZXUk6zXIcUi?=
 =?us-ascii?Q?p5ib0h3T023NI/aD97YSNgbj3yn1v03dx0YA+OB+miHCMl2tcaVFDvKyiHnC?=
 =?us-ascii?Q?J3k5WTfvuqawmMu/ijhjITt22/wFjmtmIwp1gweTzCbBUAuJotAefgFuLb5P?=
 =?us-ascii?Q?EJWOWVqa9NRwYmf577CeYJ2yBsSgP4+GadvCewbe6eAFhwXCzgdvFLXe/IXL?=
 =?us-ascii?Q?ynCcymwWfslooMAngFdVxtMOnkq2v4hV8Cyq3sTVAR+L/x+OIjuOvDc1LVfL?=
 =?us-ascii?Q?7vzBgFE7+NlAGCRiC1NR60HWayvUYvfUrE7Rb2FNZe/TkmvXCO7OLvXLhvcj?=
 =?us-ascii?Q?Bc9+6RCLqlycvXstEMXlJ29ryX0zG2wmmo6SN/BoXNeI/YD0MYrgK3aPPnBB?=
 =?us-ascii?Q?cUxZ5fGDlTOO+g2tix6I5Li6p9UJeAMMVPPxT5cFqMlFVoa7v9W0+tpesj59?=
 =?us-ascii?Q?qus9NhWR4b0iohyGl0itchTnryjqjH8k/ufgNpMuL3/r4YRtllN5qy7giz8g?=
 =?us-ascii?Q?390YUlmjJi8b53Jy+ERnMKZNKAEHXFHV4PHtV9o7i5U6AFXaAjZID3ZWg1mM?=
 =?us-ascii?Q?aYmOLIDS2sJBOzIqxA5ReYRdMqc79kVctcPMFgz9Ue255ovDWjE08P4rJFTb?=
 =?us-ascii?Q?ndJo2n8vsWQyrf26a+8v4KLrnqv8XF0n6o1Y93kyQkgRCGcCX1B2OuM0CYZc?=
 =?us-ascii?Q?oFCUYr+AqZopJHXES+4sbTGBYvyAPJn7K2VOATUe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f886636d-260a-4271-2fa3-08dce8435111
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 09:18:20.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0doioPXCuSTgiKwACvYwuV62tPEboi53B2wWcwqgW20FNb/LvRH08yYuUPAXULkpF4cuviGWexJTzIHSRlGI6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9318

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
v3: no changes
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


