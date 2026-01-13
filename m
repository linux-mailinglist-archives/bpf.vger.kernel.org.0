Return-Path: <bpf+bounces-78646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5933D167D9
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EF15301E203
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A15334AB03;
	Tue, 13 Jan 2026 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RbrGK3lJ"
X-Original-To: bpf@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A02ED164;
	Tue, 13 Jan 2026 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275027; cv=fail; b=EPzXrhyouySC2r64xQ3wopm+PvPTa5oADNHUrNTwGUj2yuwyzsTyCsd7D3WUEdn7JsPiGIZauFBEibUl1aP8TvibGNUXl4h+iPWBJ40iJU/JRAw0hyuJLySQli4DhnvI1m8xwHtXkngB7AeyGystf1wVvbhxjRFK1tlqBQt6tEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275027; c=relaxed/simple;
	bh=1uS2DJhivHqeFcXkVOBwL5iLUc9CQutK4Hb8tL5fnr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aRzIHQwP6lH1rIimroScVO17r73u31lFPonr95FJaWCav/q7LKh4j6nrtiV2rFtOjzzS9aqmEmZgqa+r5rDlcYw3eouSOUHz4eCIWaYhjbKUbxML5YDqGgIZloR08zke53gL0ct/PuFy+G36EY3YiiuCWxk6TUwZhbFhzoQ0VdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RbrGK3lJ; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iH2euoUXzwu5QvRoWtdoURDLEPeoDIMZxv9Krvvsnj2C8NOgeO8hNAkhs5mW4811/TySFpVVlpIlkqYtYAsLd7RHTeW3bwqk48qtCkEt0/diBgla39Mx2wDuma2SqM+y6bgJMLs5Hmm0qEJA+2+kWmcOb2zbGOoVZeRBqkgUqG2oMxy1CfdysAd92Vy3S6mvHrMzL+gvxuuyDpYreKDXdIszWe6B0CvQ6LVRfUayZ05vFMKy+5Y/hOX43oL40c202WvxrKQ6hZ3V8OsaAjpHorSySsZy7hfYx2IU693kX61pkYm4tez1+FmrMnSZk8OWFRG7ysFq/jcqDF0WtvLDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2glirdH1BWKOPwFGkAS12rmz4gU/OLPqY92mD33SXh8=;
 b=hvClXVeebyR3zZvpwaLF44OK8S3z1/Z2IILgeTY1f/Ms3Ffy8bizocfIEiIr3lVm15DMCnT2xqzDuphvBV+V0lR8/ZWLjIY5leEGTPxv267ovWdEKdNILnoc8SU7n/NT6j+r5XmBra97Vnl7+VXgnBmzug3Hf6VdFBbUdTDygpk3PEKM/EtYxetojElLado19Nt3oUTMU2bzyS71/Tm6pa7K6PRa2EAIuX82cwuhYTT3NpMqbJljQ9I7Pt3GWK6m8+WY3xA1euiRWvNuALnAySZ81TeyqmAQt1AR9T6U7okTowd8JeOup4Emp75IsvjvUrjsTL++DUBtvPWgrncRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2glirdH1BWKOPwFGkAS12rmz4gU/OLPqY92mD33SXh8=;
 b=RbrGK3lJE1GQc5YG8NmU+D3dAgLC3cWebAOQDATZIvHhI/w7fv4RiXxb9587DuEUIFwwDcQAomOO/5uMN+1FDI+ti67yDjnsc7Yg0B3Aswvda04LhFabnMGBNp62xzzTIJDFRdH/thFTrHMX/ktjfbc+fYkzh9cdNAY4vEQJLoaQ11rdXZoDrjcehCO++9evaNM7+VWf2qabtgi6xt01rzcgZ57kTUsIQDicJrPr7vKEqqXlySjSMeEakPmftQdoNRVj5lHTBYRmFLqCcb+ktFo2uKPslgLhc9zgNBohSqVcKz+McUewvmqyQSShdTqcEKwBoM2fzPAU/sc2QfWe/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB9395.eurprd04.prod.outlook.com (2603:10a6:10:35a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Tue, 13 Jan
 2026 03:30:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 13 Jan 2026
 03:30:15 +0000
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
Subject: [PATCH net-next 02/11] net: fec: add fec_rx_error_check() to check RX errors
Date: Tue, 13 Jan 2026 11:29:30 +0800
Message-Id: <20260113032939.3705137-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58b58e3c-1f20-4bf5-bc5b-08de52541121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|19092799006|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?74wHwUp/TKn1xhphT2D0an/7mEa7ZjioDx2jPy70Qi+tUOjziKyXCjiTOLkX?=
 =?us-ascii?Q?h8XtmKVhGbF0YoITe5By9gC0g/slLjFbfWVDMjfBy88e5Jqx1whGXolumSbo?=
 =?us-ascii?Q?gFp7xfM97XjSPNMnrFyMX/VIo1XG3Es993IS5iOpvHoscy4K1eMKPMsnZWis?=
 =?us-ascii?Q?fgIf9Wu6kPM1czi8IikhlRSwdzZFUpk8gDwgj8gpZbagNxCJ/y75aDe2gUfM?=
 =?us-ascii?Q?CMXV3wudZh6xQ186Rjcw+o3woq0lXzmVvLTyPeJe3aSwxk1SC+ivWxmu/jEm?=
 =?us-ascii?Q?dZfP3Q60aSVhYgtvKWe7Qy5XV/Dx13ptqH5IOWDcjBI0ajpfYfCoRBZC+zqQ?=
 =?us-ascii?Q?NkwvRTL5QMWPKFEts+V9QOw82Du84iXqfcn6gUkNnzJig5RJto5i6AVgCRmr?=
 =?us-ascii?Q?uLbBi1wLWyE3dCmXQEGoZJZjet8Cl6siqcDd8Kw5X0nj1AEV0ccDiupzuszf?=
 =?us-ascii?Q?ITFOjJTiQ93FN4LKnXdMgcuSQF4V4AyugmA+2m4PrWsUEdSvFDG+8/OZp71X?=
 =?us-ascii?Q?UdrLsvD8A61P9Tn6ZiuoTk1TqOXyIIUfqtLaQHDhQIL+aaRifCiOEX276xOs?=
 =?us-ascii?Q?ZgJNdaE3UPkgv4U7rSkJOwZiltwQCaYSMlNQIgzKCYXEWYqJlBci5pMAV8+z?=
 =?us-ascii?Q?hUnn+0Fvg6xR1ERa53Qj1GpDVU30u1bjFQugiiYuVkmLTWSLfqkvWOwRlY8i?=
 =?us-ascii?Q?Fsl8u7RkiEc/WW8OZA8dyDpnDDmTz/ggKIdFHrVNa9c449h6GZC5p8syg68X?=
 =?us-ascii?Q?POiTqOVjfcO4lBU9qSsXzbVx9XWxkE9ZYjBjt6ijwl33an20rpp6ZpVDtW5J?=
 =?us-ascii?Q?9+CBdxZK9PB2/JSeN0fz9IjmQhLnlIWY59La/HAKP0avcPx0geN/ozmRYwYr?=
 =?us-ascii?Q?ePrbnzORFerFWo6BtrZiRwQ+TcxBkjnVVJkHo83J52Hu5nMpLUhkv/+0uGEk?=
 =?us-ascii?Q?MxDbDifMqySO6K0Jkn5V+oEGoyOKwfBO9e17sGPVZUUiIUJKlQLQciJQCOvp?=
 =?us-ascii?Q?6meV7rV29e4cIkRGmlVpLidnVkamL5om+4Vks1gIQ4P/Ks2CHEjyhQq0TfGO?=
 =?us-ascii?Q?BkANXv8TSTIN6i4vVMvHzqS7sUoNmE49iNyu1US8iD9cnb1dh4ikMD6mbopX?=
 =?us-ascii?Q?d66SSCGHybQJ+AKiENAE2B8ZZr9181Tg3khQWL0w9J42EwnW/c+b8BbQ6jCt?=
 =?us-ascii?Q?Xzy0QNom3HVtqKUnkX2GlGpRYP3J9EUJerWzAgqrVe+KUNVBF1quZ3VYyAOY?=
 =?us-ascii?Q?57ZWi6M+ixGrA3+mCWWDFdwhDbWZED+muzUhBwrYvQBR2TpocBV6wEqzpva+?=
 =?us-ascii?Q?nb5936Q5WBW+buXylsZOoWXYWdS9qwek7yDdOHWUAHKXflypo0383OsxpZEW?=
 =?us-ascii?Q?AKskB1UhcP6LlqhRCUIPJZRRjOP0Z9VDiCgHpG3KygMDDzf9bUsAgsIig4Bq?=
 =?us-ascii?Q?yJNo9/AsQoILceuXAqVc12Ikjj0bKBFHJdofMe/sXcjNXZrMgrT9G3W6b7Eo?=
 =?us-ascii?Q?YA636NclXu0YHKvruVMbFt3S4xDnqw52fT4W8kJCnYzweojuIJSR1nsv3A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(19092799006)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6KcgHzxaBIz461L4vau2C9DcLzw8zYWMCfJJJVcEtd2nL78gwDQ7B3F0fg7A?=
 =?us-ascii?Q?y4lVm351rDMNkmjRYNyi7QvntHrCdnMckiFWVGCU8yOyGWMF9YxvAW8vPEsv?=
 =?us-ascii?Q?kFm06djwx0NugYBCH6Ycr1hVPEE4ipDIiwJDbwJR35jiwaLp47B4v7j3iYgz?=
 =?us-ascii?Q?zWBWgg9Uqh3+VMl/AH+O2VpYggE0DOkoIWsekM4Lw/YsTZTav/uaEhJiDqSV?=
 =?us-ascii?Q?gcRCLGH2zET3xHD8ftQrTmOZL2xh8k9eDjh22V73XYdjIvneYNGG5XOekJRw?=
 =?us-ascii?Q?a8r+ohDdxRUxEqBosQakHatX30Tm/UuqYzZp1ASNlelxwvhPD85stYqj/9j7?=
 =?us-ascii?Q?1fRnczCA+a1eIlJXqenLr3d2kXAPB8Z/bWL4Y0ih9EQoENxlxztmT9dKPRXD?=
 =?us-ascii?Q?oQrSzSNUHVKAe5xBCtfxhcbdgUvsEZMbgut6MBq1r6QUNdTIilHLlAl813i3?=
 =?us-ascii?Q?NwBfpFVfkPBcS5QJ3E5Qv1fIPUCSJWdhdnjeZoSRZwmB3KDiMvU//PT2cjV7?=
 =?us-ascii?Q?Iioqx6n0J0wxuWM1jyJksDSymxsjTpqSnbGdcqoeYW52Y+kOTbI1+M3Ws7D8?=
 =?us-ascii?Q?QBSnjxM5IIF5Zjs48/osl7mofcOjU9KKVprgMmhWYG+l3aw+MCIHCqL3ykg6?=
 =?us-ascii?Q?kIvQGcB+oG6RxKh8Vt4lTCTSKyysngCqmlZSTBCpPjvzByRYqIOXDyzzuEXJ?=
 =?us-ascii?Q?+QzM8WWOrgPfOkHCqmFKUj5JfVj76R/tV1GIW1UewhP5RRAmgR4M02xhkesg?=
 =?us-ascii?Q?YpD79Bh9+2RlCPEGJtorvsPUWDqFtgQtPJpz1r03RruExndmdapnyIYke5Lw?=
 =?us-ascii?Q?BiuFV22aA0HN2dEo5AiBE+kwqwsVYO4d12LH7rw/MiqKXv8lvk98ZBpmGOFf?=
 =?us-ascii?Q?Y4ry2CKWWQq9ymuVKMuoOcyHebRtzWKkH7jVYSVIw4y116nZf0/XIK3eV7+z?=
 =?us-ascii?Q?qpaB7e4fnITZIx8p6tB2CIFCfB166a6qCdnlwPdsTK/wsgEaX3TSgoNleZF3?=
 =?us-ascii?Q?prd7MaHkADhWvl60+kUkIDDiUaE/xv6rGznuFSG0OGWzSS2efdYWddCP19Za?=
 =?us-ascii?Q?O7zgVR7P4ti29sSg3rR9lHf+Isf3vvZWySpwf+eXWMFuyfpnkKSGKwe78WF5?=
 =?us-ascii?Q?j+GetDSzmt6H8TCvzvNdC1Fyc3XDM+E1YUHBkSRjnAEdUXTN/jKbbEtmbxwn?=
 =?us-ascii?Q?9FWSgYoy0HRMShcVfnUAEOGz/71dAvXp+ik3t2PEArV/KG2yeXYzgdVcJHDW?=
 =?us-ascii?Q?NCzG/ahjinIAitspbeuJnX235g87dsCZtQQP+GXkr0qkmQPEmYjxzPgeXIq6?=
 =?us-ascii?Q?SWmSTpRymw6qeBc6NqFZjUXnjNq6V2hiCQf+1zEzY1PsipR9eU7wSW40cXd9?=
 =?us-ascii?Q?Q5uEjB0bJOiP4KOsFb8B39XBn51vglPOZ7oFkltEhicj3qOhrpAQyYEN4Bpw?=
 =?us-ascii?Q?FoGZDnFBWnTg3uj+9mKv1NVo0TYiI9shutJvMDJFRZFXJXtowvnZX5pYLxDU?=
 =?us-ascii?Q?iAFPWIzYGjf7C0TOled2sCOogdsXXkKrLBzHv6QoGDw7VGvAHTMjwpdr2C+D?=
 =?us-ascii?Q?IKBLeI71nvykVefhjh/S+llJRC0ceHtN1ItkWtD/x5btdsEQE4BKY1sRy73O?=
 =?us-ascii?Q?AMFOqw3y5t65yptCfML2+LzCocxwYMcR1p+6mRER0WIFh2xBacG67Evf7vgX?=
 =?us-ascii?Q?58lsrqUxjQ6zpGj7yj8NOCPEhYd4YbuPyYzajvO2SDES5vmZQgNhtn/qHR59?=
 =?us-ascii?Q?lR1zfqtu8w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b58e3c-1f20-4bf5-bc5b-08de52541121
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:30:15.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jasxVxSQRfcNekqGBqf6gvodYlTXcdGAJ0XP0l6fG7I2zkfBP0pd4iqzjOq96wssrZZH886l+hJVEvaAakK/Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9395

Extract fec_rx_error_check() from fec_enet_rx_queue(), this helper is
used to check RX errors. And it will be used in XDP and XDP zero copy
paths in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++---------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 85bcca932fd2..0fa78ca9bc04 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1746,6 +1746,41 @@ static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 	}
 }
 
+static int fec_rx_error_check(struct net_device *ndev, u16 status)
+{
+	if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
+		      BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
+		      BD_ENET_RX_CL)) {
+		ndev->stats.rx_errors++;
+
+		if (status & BD_ENET_RX_OV) {
+			/* FIFO overrun */
+			ndev->stats.rx_fifo_errors++;
+			return -EIO;
+		}
+
+		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH |
+			      BD_ENET_RX_LAST)) {
+			/* Frame too long or too short. */
+			ndev->stats.rx_length_errors++;
+			if ((status & BD_ENET_RX_LAST) && net_ratelimit())
+				netdev_err(ndev, "rcv is not +last\n");
+		}
+
+		/* CRC Error */
+		if (status & BD_ENET_RX_CR)
+			ndev->stats.rx_crc_errors++;
+
+		/* Report late collisions as a frame error. */
+		if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
+			ndev->stats.rx_frame_errors++;
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1806,29 +1841,8 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
-		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
-			   BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
-			   BD_ENET_RX_CL)) {
-			ndev->stats.rx_errors++;
-			if (status & BD_ENET_RX_OV) {
-				/* FIFO overrun */
-				ndev->stats.rx_fifo_errors++;
-				goto rx_processing_done;
-			}
-			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
-						| BD_ENET_RX_LAST)) {
-				/* Frame too long or too short. */
-				ndev->stats.rx_length_errors++;
-				if (status & BD_ENET_RX_LAST)
-					netdev_err(ndev, "rcv is not +last\n");
-			}
-			if (status & BD_ENET_RX_CR)	/* CRC Error */
-				ndev->stats.rx_crc_errors++;
-			/* Report late collisions as a frame error. */
-			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
-				ndev->stats.rx_frame_errors++;
+		if (unlikely(fec_rx_error_check(ndev, status)))
 			goto rx_processing_done;
-		}
 
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
-- 
2.34.1


