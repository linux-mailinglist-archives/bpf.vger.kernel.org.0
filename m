Return-Path: <bpf+bounces-41555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A43B199826C
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 11:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C811C23DC3
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D2F1BE84B;
	Thu, 10 Oct 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h2G0MLFp"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F731BD516;
	Thu, 10 Oct 2024 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552948; cv=fail; b=GGmQTu7stOtETtDyDeP0Kn1KvC1xWtJ74sNfuQKVZSWvmF7mmaxIhQX9ZFU2bqJ74tPiMyxQRB72fPPpeVbSwsFt+rj15Q5d1sdGM9uduMGnoUtNBEerhwqlJmdtnKPVUTuGKa8a9vxJy0ZEnd6Ok+VyF5+i292M8D6KWv3Dwic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552948; c=relaxed/simple;
	bh=94lZlI+yAUW8VqjbiR3ZlZhdLmdrLfQON7QWRZP+lQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hMqKxPwRnMDZVqH3r1GQUxzXoy26r1dn5gTETyX4fQ+LH+0B+CMNULXSngprKYdoeQTq7cxTgL8PAZx0k9DCWxD5foLe9C4WdD+KqOEnlxemhbL0HSreHUeZqhY1apGhbN8Y6Id38SvxxxPx3FD4I1LXCg8bFbYBIy9vFR7++h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h2G0MLFp; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtvWNa3XRYqRxBSl9cZsvpbeyPXwVuk/hsnCrN4q5jJkWJXRYtTktuUchorq+VqFfHhap5tobPjGkTjXSDNgyXtailX5BVf61q4dxCE0migHMkz0HH4gt5i7HVUMdeCjY05VHSPA7wGiYR7b+aM5gRo15CJVOxp+iB0hlb1S/1GDDpKCKWU02RzOV8dWX3qTD45XUopWJlv3c+4ghj7qvWi9ScV6QlkJY2cNGLv05dzqgwJ6WVPzoKliRG1RWSWmQWEfFGnvukGhIMwFOoC/sttnRwh1fBYPFH9EzIOvaW3DUfgRkpWpiJ8eTG58jNDvSlRuJdqbYUvx/fLtyjir2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEqTK5LVLzSagk7VtJOHN1FFsPC8NVFjO9XD78ydW/o=;
 b=x5ZafsTNniN8eQisLB7Ug/uH5LSJm+7tKvRQcgHftFuryoUeNlRYR7L9fliXaQtamCPKqp/i/U2N2Kr9aHPioiFI1loJGEz/fmp2euF+j/tCFeVkW1LeZSCsfvIoKZdsYe8R6InYUvLbMTtXDhGZS1MFXmC4Sm1WMswzpwq8knwcHHgsNWpNnUMOPNSNILwuzSsvaCH+jAd6LhZWqMyO74iXG36PFYL/ESdYt3nBMnd8zUCOWYfCepyRcByczhkDhoKGRCY9ZHJNYOGYJb09dyUe1lyWEYWz1rIn6oJnEOn61gwuFzEt2lylD/loBnEvmMEWx5oK98+artgVVhjwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEqTK5LVLzSagk7VtJOHN1FFsPC8NVFjO9XD78ydW/o=;
 b=h2G0MLFps3l/GpXBXG8OksAUuTeKwdLcxM9tcp82BRL/VGsj/Jjm6s+GvaUesiyikjDUNAz5VGD0wuq42C3bgyqtAtbb1FaBkr9ew38IdGtB4MjfJXDFQqB3jAyF3MAoceLXGEf2uMMiNXZa+G8pcmAwW4w6y/ghaDUTuhAi0w04SOO9+aZAjwMN0dQO2y6nb8zRtTOzEW2TAt6RwZAtS9lZ2TaCH5iX0m3RXQV1MRpGFNZOJQ5MudyZXMNlcSA8UFmASjwUdulom5GUrguZK5V9SXbLvii+ZnnaHpBjTzfK7IN16ujpB1E2KUqsM6NJQAY9ydL4ykpvANb6nuywPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB6847.eurprd04.prod.outlook.com (2603:10a6:803:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 09:35:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 09:35:42 +0000
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
Subject: [PATCH v4 net 2/4] net: enetc: block concurrent XDP transmissions during ring reconfiguration
Date: Thu, 10 Oct 2024 17:20:54 +0800
Message-Id: <20241010092056.298128-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010092056.298128-1-wei.fang@nxp.com>
References: <20241010092056.298128-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ad2d32-6bca-49e0-9118-08dce90ee85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QoSr4o+bxY4l9afy8UanIBQphXuzwnKwxeZRQYp3th3jEGbSBvH+cQlp4+Zl?=
 =?us-ascii?Q?ecP2u/r14netWJbdELDsg/gZCQs03NzPXi5MsdR4V+d1oSrFfHZ6hrIjQ81+?=
 =?us-ascii?Q?gEHr4uHV1z1oWFD4w/VtTrnanwIXsmwMC/3XElvb76xRcI4veAoCVrPK4zUG?=
 =?us-ascii?Q?hZwB25puvDwunuyhlTvQ21hrYmtgugZhBgxZa3mjW+uUV4fcondAZ8L6UvBz?=
 =?us-ascii?Q?eb4GU/gHZR8eoWtxRSBqpErfpEq6p844ln19q8FV1G623fgDySWX/AwEf6Sd?=
 =?us-ascii?Q?gKTz/Jyc07h4lTHGn/UA4Pxhu0y4GTbibrMjDY9jzXCpap6w1egsJLbbNm5W?=
 =?us-ascii?Q?1xc9Xp8FL3B1s+KQVpzzlLlqjS9UWx4T32pDjSs48uRs7cuvcKYQxqDbgHQp?=
 =?us-ascii?Q?snprOibMKEa3LlEuubpUWbmJXpKEbaTbNrsjhLN5f4WmHuyEKkV2MS+IM1wa?=
 =?us-ascii?Q?u1fyalmWnOk1EVLZ2AHYjhuHt4bcGJOiSVkia0urjuY7rlwqXr5GzOes5ceO?=
 =?us-ascii?Q?PqmJ8IaOp3hTBfKuMuViCd63lxwbvzSLBv3KPAYVf/nMFWYww8DaScYSEO1r?=
 =?us-ascii?Q?Wvd2fJRe1ydaETIsKQ5aOFV9A3GbA4BHkraQZZmmp9cgGy8dcVR8wcRz1MsW?=
 =?us-ascii?Q?1YHs/2wGhKM8MZJ6mS6TQv+vnSz91cVOaX8SVZv+iTnjTmkf9WlZ0nqE+wjH?=
 =?us-ascii?Q?Yr4zCmhANCSPQy5Z9JuwFGlVmHlHDyUvBPxnxDkZysEWbv186Mr1MXJu7lAA?=
 =?us-ascii?Q?DSpCED6ysOwL8dnEBLjzLIxEk+IDrkdWZi2nBfLvqTB69nkB3ygEKy8tSYkQ?=
 =?us-ascii?Q?QLFwh1LBNUvpNstZL3pvryOm2C30G1dROKkKxL+7Q705H8q9u8ftW7mrZWRB?=
 =?us-ascii?Q?u/+fHy8fDYB582xGL1F/Ff/3PtySwilqBZL5UVpldXzMGvcz0yXgqLtAiXvq?=
 =?us-ascii?Q?qG6yaPB7c1ayM9fUsIyzyBeYkOuRcIOg85kQ7sbXF16etns91r8jPx4I/5ck?=
 =?us-ascii?Q?1H2QyWEoaPDdhp4KNZFFY7ZlCq/lYYRy4uPxUBKrQIf6d1SvbQyHf9IvTf0z?=
 =?us-ascii?Q?Sc7UBpq9w6AS9TiiCD5Yc0SJ8xLPZ8Jsqy5bGCd5lynDAq3DkZ3U7jOheYo0?=
 =?us-ascii?Q?+TvzAJYKUWsHVjgrQm0GxfnhiQcbpZTl+2lDIN1Eu8dcr5+zh2rEKEAJGAJ4?=
 =?us-ascii?Q?lDXBrvVJ2lyqHOo+2eDebckYXog+3dqzAjqSIuZ/U28O9AsuJiksuQHNbIfD?=
 =?us-ascii?Q?XgBpW/khmZFom0N0d35+gL+UqjEM99pMJ1vyhS9i/8U40LKecYVOUYZZADIW?=
 =?us-ascii?Q?p1OsdhLOeA4qrogPRBynb7U4MddZcWI6j/PuEzMK1mGEKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7DBqAHjteWfRL6Ks0D+HDq10o3VQ2mALdAHXLUUrtXOpWm9vnbGFcf5y8yc1?=
 =?us-ascii?Q?vQtTqToAX2iic6sFhcFrBvfapdzHthXOXMBrkvFsXzZEDj8BoM1HBmzfHd9u?=
 =?us-ascii?Q?9A9McvMsb7AZaYXI6vi+sYFD9iMKvdAbBuR/Ff/+ZQ4OjUCnnce/PvQ7ojkX?=
 =?us-ascii?Q?ygwTsmb3+hXZE0/v9rVZ0I9s27I+fkxWYA9PMmVGHh/P3S46eUHqRscXaFfy?=
 =?us-ascii?Q?9t7auZ1DpSKhXHUYuO5db1W6OQ0gk0+wTSKCtI0dOpLgthTiING26BDO4jBW?=
 =?us-ascii?Q?8ZvMPtu3wrblvR98koXdX3ZINZ4s7I1lxc8+f5U2OXYQxcx+Sq9kzIOY+tiU?=
 =?us-ascii?Q?3EzpAd79W7zJ2HLSSZnqheDiIbUBPUZCfJY3qW6J/QJ+kWio2anduiKhSI0y?=
 =?us-ascii?Q?6XzM9cTOqimazrgFzuGyvFMpAqoTa9fEwSgqPTkixtxeH8AqbvanMi2R/jFX?=
 =?us-ascii?Q?DZjRSWO+IZiws1KERvGPzZ+T4+OrxJCF62FjwUjQpT0T4PPU+UzXuM5i0IX/?=
 =?us-ascii?Q?mw0HCUxN1DLvHgkT8QXKxzBDcy+U8hWbqVZ9W22xF/a5bgLX0ltEAnAHdWsX?=
 =?us-ascii?Q?IDp8h8Q+kPT3AspzJxV0PnZQM9LHsKX8fX8kmpAXlC/Btr/tIhcm9nYVimBT?=
 =?us-ascii?Q?GLdpsu/QAjNoN2QqbQSGw9a0bbeZ6cgU+xxTef16MEXJQIOY9k87+zD+howQ?=
 =?us-ascii?Q?EavKjk4CqzwObBiMw4ttwmru+qAHob7VPa4Tk01iqGhQsY/TtZQr0LUV13io?=
 =?us-ascii?Q?k15Crt6A3ClheJFVEbvpexnxWbqXN1CN0ue3+Fa5Dy1WK7Wgtb5/8NJaQ4bY?=
 =?us-ascii?Q?poJdXazWbz/5lAZezQjlZA9F6i8dnKTbnGIwaUkpAqVKle48/GPBO2J3G7H1?=
 =?us-ascii?Q?owgrf6CKlwokNOOiAI92Gr2F2fJfPQHwhn3rO+FTxdMQFd7gPHQ6J05B1VUk?=
 =?us-ascii?Q?YKIeS4JXsyOX8wwtCF4B/utO4u069U4FqO/h7ePaNrOY3juwaWoFLhHdk5/A?=
 =?us-ascii?Q?TnGpTVxCpHlB+ui3J2+81KQdbDBT51Ot7dqe7/htGcn1Ywst+IfwIoBurVY1?=
 =?us-ascii?Q?ldp8/4/WMaJ/kkUUo6cv6sFNWLJPvsJAcNHhwggHac6TjwU/A9BHHNSHtUDo?=
 =?us-ascii?Q?e9shBTsL+Vpvss5h89wyFlCDGJLe8SnnVlCh7auywNjzA99Zo584eNnv10gu?=
 =?us-ascii?Q?7/harDeN7juIvB2u6FMWzGyeAhNSjTH0+s2WwdWeI0iw84nC37cRC+/GSdeG?=
 =?us-ascii?Q?ppb0xDOsvYpBDI1ptzfatx5O/ncAkjKE6Qs9bg6owhJFHZt1RgBJhrlBBMBQ?=
 =?us-ascii?Q?4coQMoNenrxlZ5TFqSVtoG4hhPSjmbOI5NWOY4jh4Jl1hUwNUe9IgBO6POq1?=
 =?us-ascii?Q?nQdVXmRRnVkGfDBMBP04Pm32AxJ5syw2eS5pX1WJFnzt4mu5bkx0rwTRoJPn?=
 =?us-ascii?Q?prbHnFxckE0CA8fIHGX/BjR9emtZTLI4o4mEocVPuX+LKgV6Q/AaUDeRB6P6?=
 =?us-ascii?Q?7KyXDqilY9p7aiU0IrCQx8KSchnZW8ag+bnGtIPXKoTz1D9TZWyCRu2TefU5?=
 =?us-ascii?Q?odNLRrTmi8+7RlSNMiOlQyAEQokkxWfKIP+8L+ko?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ad2d32-6bca-49e0-9118-08dce90ee85e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:35:41.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2GCL8FGF6vVIwr1V2LsIaMaKussCZBdrYlqJL+drMkfdJOChg0do3WEEpdzhYITcMQemyFu/CDYAYq9l2IPmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6847

When testing the XDP_REDIRECT function on the LS1028A platform, we
found a very reproducible issue that the Tx frames can no longer be
sent out even if XDP_REDIRECT is turned off. Specifically, if there
is a lot of traffic on Rx direction, when XDP_REDIRECT is turned on,
the console may display some warnings like "timeout for tx ring #6
clear", and all redirected frames will be dropped, the detailed log
is as follows.

root@ls1028ardb:~# ./xdp-bench redirect eno0 eno2
Redirecting from eno0 (ifindex 3; driver fsl_enetc) to eno2 (ifindex 4; driver fsl_enetc)
[203.849809] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #5 clear
[204.006051] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #6 clear
[204.161944] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #7 clear
eno0->eno2     1420505 rx/s       1420590 err,drop/s      0 xmit/s
  xmit eno0->eno2    0 xmit/s     1420590 drop/s     0 drv_err/s     15.71 bulk-avg
eno0->eno2     1420484 rx/s       1420485 err,drop/s      0 xmit/s
  xmit eno0->eno2    0 xmit/s     1420485 drop/s     0 drv_err/s     15.71 bulk-avg

By analyzing the XDP_REDIRECT implementation of enetc driver, the
driver will reconfigure Tx and Rx BD rings when a bpf program is
installed or uninstalled, but there is no mechanisms to block the
redirected frames when enetc driver reconfigures rings. Similarly,
XDP_TX verdicts on received frames can also lead to frames being
enqueued in the Tx rings. Because XDP ignores the state set by the
netif_tx_wake_queue() API, so introduce the ENETC_TX_DOWN flag to
suppress transmission of XDP frames.

Fixes: c33bfaf91c4c ("net: enetc: set up XDP program under enetc_reconfigure()")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
Remove a blank line from the end of enetc_disable_tx_bdrs().
v3 changes:
Block the XDP_TX frames when ENETC_TX_DOWN flag is set.
v4 changes:
1. Modify the title and rephrase the commit message.
2. Move the changes of operation order in enect_stop() and
enetc_stop() to a separated patch (patch 3).
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 14 ++++++++++++++
 drivers/net/ethernet/freescale/enetc/enetc.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 56e59721ec7d..482c44ed9d46 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -902,6 +902,7 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 
 	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
 		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
+		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
 		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
 		netif_wake_subqueue(ndev, tx_ring->index);
 	}
@@ -1377,6 +1378,9 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	int xdp_tx_bd_cnt, i, k;
 	int xdp_tx_frm_cnt = 0;
 
+	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags)))
+		return -ENETDOWN;
+
 	enetc_lock_mdio();
 
 	tx_ring = priv->xdp_tx_ring[smp_processor_id()];
@@ -1602,6 +1606,12 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			break;
 		case XDP_TX:
 			tx_ring = priv->xdp_tx_ring[rx_ring->index];
+			if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags))) {
+				enetc_xdp_drop(rx_ring, orig_i, i);
+				tx_ring->stats.xdp_tx_drops++;
+				break;
+			}
+
 			xdp_tx_bd_cnt = enetc_rx_swbd_to_xdp_tx_swbd(xdp_tx_arr,
 								     rx_ring,
 								     orig_i, i);
@@ -2463,6 +2473,8 @@ void enetc_start(struct net_device *ndev)
 	enetc_enable_bdrs(priv);
 
 	netif_tx_start_all_queues(ndev);
+
+	clear_bit(ENETC_TX_DOWN, &priv->flags);
 }
 EXPORT_SYMBOL_GPL(enetc_start);
 
@@ -2520,6 +2532,8 @@ void enetc_stop(struct net_device *ndev)
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int i;
 
+	set_bit(ENETC_TX_DOWN, &priv->flags);
+
 	netif_tx_stop_all_queues(ndev);
 
 	enetc_disable_bdrs(priv);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 97524dfa234c..fb7d98d57783 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -325,6 +325,7 @@ enum enetc_active_offloads {
 
 enum enetc_flags_bit {
 	ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS = 0,
+	ENETC_TX_DOWN,
 };
 
 /* interrupt coalescing modes */
-- 
2.34.1


