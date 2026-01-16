Return-Path: <bpf+bounces-79210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE82D2D5F3
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A051E301A394
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EB334C9AD;
	Fri, 16 Jan 2026 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jJul987M"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E2346AE6;
	Fri, 16 Jan 2026 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549319; cv=fail; b=j/TgJAxWg5ptZ2ogQaq6Xz3H8uhXmaY8dv+kHz2Qksc7wCl4UkmEGI2lizStj7csTbu+SG3ZVoqEXKdtDfYgxbVZoSoEFbtQLNOuTLa6EiBQidC+zxaY2xafc1q7+KneNOyHN38jqX11WQaY2gw37RiZ1cpdNeylIb0Wutp8res=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549319; c=relaxed/simple;
	bh=v3DD0heNEK+BUjE5yuilMFMbnQZWm3gQHtW6aNTmli4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fbsAy+ZrSZD4vSXRDXkmUYNYI+ZvN5cMEikSDgY3PP5iYS6yp1OSZnsmhRgvnim/EnVN9VeRAwa97bsaQ4ZKSyvCRp9bjAW217+kBkE/6u95j7bx8L035PxWTFh1h0cZBjmn4+JDB8WAwzl1AoyNY/ES2PYQZlsZ6nVKid2LCXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jJul987M; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lv4PlI1YQmiEKHn8KAYLatAs63LdEW19sCNTU3VHZKP4OkTniI6h8r90+bJaSIF4muNO/rAsyOYZo8LUKitDu1Evtg3SzUP4fVkIgs9seZItXqLFs3T8j7+5Vfabr5ajUcS3n5TBEAQrsZKnLL66qOG7y+hVYO2BnFcvv8vBhYOEu+O7koVY9Dz4FnXJPk2f67NwkENzgmqdxcr4h1uwkXIaS+vNtXggU59gXFrJb2Zyi1JCGT6vZKfMEentGJW6SaIC69zTMQFgDvwekGJvLAxpazs9ly1/Kc2qxMTJ8Ii4aveTNokwEUBSQd+D0mP+xA4nKh8eK1/AweVhUjKVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlE/Z16rY/riWsIsgqrdcunfr8xY2tqdVpcKQO69Rec=;
 b=W3tEaAMp6C0xgCkjw369RRFKwZjW9WIQB4jLyM4jjxwVFlX9BmjrjXCuGDV7deh9f313eR9N9UqV8UKKMpEsbbcu9/KS+x3gTy9l2cqNoFwhOtRYVCa9TAkJ3pNJPSB346/Yh3pssffxYn+Iw8ZMkaOzZTHkkpUF/SGxADnyubmVfDSzUVH21n5xZUj/559FBjvePU/s2FAjbO8L3qb1B0hxtdXewm7OuNB0j5O+NvM18BhS/HwTP+qIN7uzrxUlXrsxfQowjgDb0A1Y2DYeNIxsQl6aaysyvWlLc2vQAlYBDy1QluDAPeCgVouJmxlVYY5lhauJyya/YslM2KBWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlE/Z16rY/riWsIsgqrdcunfr8xY2tqdVpcKQO69Rec=;
 b=jJul987MTqOl/B4OGVfql2KzRO6dUk+0r4CsgVNjO1bHv8TIr0r5J4LBWk+Ffqj/rSSQQX3SO3mVdaYAN8mZkpn9pQg23uUpRHDcCnEKLTgq/0lVs0JmA+lepo3hYq7AxhjTWh/aM5WjNZIrsFcrSkMUu/S83LOTEmwC+kLccW8pDXT6GYSFBJ4EZYeV4Oe6IX/ViTRP72Zk4CvDa/+qHuA+9LcX2Wf0Eva6iLoPbpXFKxnXumD4GZ0a+E16fF+cm+gPNGA2jQBsKPusTY6aP13LKMksYI/c4KW3RfIjLuWK5cedT5VCHVs4OgVOqw8kbt18EUMFs2dJSw2nixTcsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7390.eurprd04.prod.outlook.com (2603:10a6:800:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:41:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:41:41 +0000
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
Subject: [PATCH v2 net-next 07/14] net: fec: transmit XDP frames in bulk
Date: Fri, 16 Jan 2026 15:40:20 +0800
Message-Id: <20260116074027.1603841-8-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: 03483530-fd16-4851-5fb6-08de54d2b096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d+f5CbhjPzZTIfFNYrzSm/Zz1meVn5PKOWJGob3YGdMsSN7oFn73MJUPPZQn?=
 =?us-ascii?Q?G0hx9VvcYuNo7zENiTC4nfWfMLTwppuUezLRriWlwu/qlCdMuR1PKoElmh9U?=
 =?us-ascii?Q?1FK0v+KXP4CDDlNMHZ4yjLR++m+mhPhKI4KPbT4zUcMBvtQv8vXwYXcT+TNy?=
 =?us-ascii?Q?oD1FyuWg56ZcoUkVbr1pO4qhAvZCSbIZeZh28gzqN/HOXD+K+pSMmHm5zl32?=
 =?us-ascii?Q?+YlVXzJZnzgl8wjKzDt3HsrBeWO75AO2ZxnojXLoKeJoyfFz9SaUpwXmJU1I?=
 =?us-ascii?Q?uvrSN/6kGVvpFAnxfAfrTUCW3rSv23sxSise8pvECSVwjwk3WVZ8NOg2pkKV?=
 =?us-ascii?Q?My8zKeVvkoGGIxwffd/AhO6tVgpHCtcxy4PdVmJhAndjimgW8F+YZpJL0cZz?=
 =?us-ascii?Q?zOR+AUKNo2amidfPBmaq2z5jJPHbdnxXIYAxrTtli6NIgmRlMibPe+Guelav?=
 =?us-ascii?Q?PdA6dwOnVc5a5kJuQND32/uORFFi06Kt4wy9XDe04X9qfEUMxclKGgiHl/rn?=
 =?us-ascii?Q?wxhscsk415DvEJKkuVAE7StcGMdPBky/UFEeSWz6E0be1Tngp7FNrSGY7iaZ?=
 =?us-ascii?Q?v+mFKl6rMpTeaFKjtq8jiDeszzWqKjJrdgigvliUcbJD3GIFRI8/CVovZVxl?=
 =?us-ascii?Q?oUYGEwRG3Ta4HLFkaHUXj89CGWbEH0Dm0e8l2jc4BGbZrNz+VFitL/vGxags?=
 =?us-ascii?Q?rVz/m2ODg6ojq9IWsWWZtLlWPBpHeRvGR4NxGzGIBY6loEpDkL9d0NG/Bagy?=
 =?us-ascii?Q?DwVrMCY1CdQk2qfOiz+euPjk8+Bga3HlKWOom27fm0TIip88jWtKMep19mIr?=
 =?us-ascii?Q?AIZjbSqmciIPQPqONlq22gOt7SsvPtY2i/VGg0E+T70l/3h3TjO92uS3Q6Y1?=
 =?us-ascii?Q?HkcaUu6QLZQ8xF9j5khMiH6CE1LZSInrZTFfRyxnytfD9sxtUImymGs+QlCt?=
 =?us-ascii?Q?u3fsUA2QDABr1I9brmuDHXWLlqqdudyPoQJbkwV7kUDc97iVloRjYhcuCBNQ?=
 =?us-ascii?Q?oeJCnJUKoW2iOtH2sHkWNJrT2jrdqN4N5dG6icmJyXqrF9mgbs2PVE6Mz4qf?=
 =?us-ascii?Q?DJWOixYxD/sRocV6uTl45GtNotZZAiMgmd7tvdjYfkjQ9LJNmNVSpF5pK28T?=
 =?us-ascii?Q?i6XXf3h380Wxwyj+jF8xxVNVjn4Ap+ObbpGHJ44lS0CZnFPyr4osraEZrVsl?=
 =?us-ascii?Q?GNr9cEhy3VmxnsSBL6CSjPVU8DDrWiu2BuGgOixcexzJN2AAm2sk7aGehEzr?=
 =?us-ascii?Q?4FZz1RED5ryboEHY+PMmOvzw/7liEAALQs3c27KGC0YHariFp9aP3QwMwYsj?=
 =?us-ascii?Q?i3vZM1nETdAUSMwjbn6lE34hT7efJI2avvNhibAHJcB33XuX4Xt2vB+JfMfZ?=
 =?us-ascii?Q?c3n3Ts+J7HJeX5WtIEIFCOtuqSlK/ncXrPnzKWqJ+CAuk79C+EB3grxzrREn?=
 =?us-ascii?Q?RxQErHq9irFELFBg5YKf9NCOadcv48DTAnVZ0syFoIOrLM4hA+aWM6iYwoFm?=
 =?us-ascii?Q?tmwA6R7I+MDkRCCytitnRIs5VT1Hb7LfYOzh3GiAoWxkDUpo8WM1TEtf3Rut?=
 =?us-ascii?Q?/XvBKRx5HK/kBCo5XP2oSdbZnbGMMrU0UH4W1zD8Cx4htWGGkQeIIyNQMqvB?=
 =?us-ascii?Q?uPCdjiJ/SPOQ9Tkjloc8h487fwaqCcNpdosOCgiPsHER?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BnItmrMRsfm2/fXft1RujVaAuAeWEFzCRferAkyF5G3CRGvZQWH2w7PFvTtg?=
 =?us-ascii?Q?BK9VF9OgAkXraCvk51DmsCZsMhmPQtXRz87eJ9uhs69srAIzIBZnTw3mP7vp?=
 =?us-ascii?Q?zgG+3uUR67LOvy2sWI8jcrvmgU7xCvXEfuFODBKSxK5WRwkzs6iMug12FCX4?=
 =?us-ascii?Q?NUYvCoQl8LqRWLktxzA6I+xxbI7yAEMZa56+AejmV2qB58DMvx5Mobc5U1oL?=
 =?us-ascii?Q?qHO44+NFzx6YOGv8JQiD4726ZoHgW5YwgENVnJHDbCIurDAWbxKnk2ruwF0D?=
 =?us-ascii?Q?lckLsYzWDB4a+MI4539pvVRl74tKDRGspSlxPg5qlepL7RuqcQkQR1cTOqSw?=
 =?us-ascii?Q?qURhGdvtLIAZHlvOL+nFMd800wfd9hV2xe88H8OQVOEGuywAUIS0wik2Vkfg?=
 =?us-ascii?Q?l2LP38FawAzOhDYaKVn58CQDQ1BgceUDnZ3b9zl7LgEZxlcwSK20B2m7hsxG?=
 =?us-ascii?Q?U/OhXg2FFx0A3zl0u8LVOFaL0rFaVq3h49IYVaR7v+BoJY1jYd4L0mrjFxrb?=
 =?us-ascii?Q?byLPojeROwAjgKg/HFvA5WCh8tj3cyzMQDnbeImMTp45C9RLbjDM4uqvyQpb?=
 =?us-ascii?Q?9IkohIsL/CEqipAMezyW1OIUia3kI6z/KrjOz4jpJDjJL0/Qfrt9A1ohQ0zr?=
 =?us-ascii?Q?r6GYZHm1PX9Eg/IbdN4OvMohW6QjRAt32eDVTsjs8iJfN6W1dPjK6tNxwypI?=
 =?us-ascii?Q?qBaSE5uOyt8gsII0LkjwyrM+zY1lfGMHJEkxdVKlZ0JIwybgd9tY8+5BNclj?=
 =?us-ascii?Q?RhvfnCNTfqHPUyOGQpuvKE5qkalfNB0al5JVZ3ftKAMcI4Sa+r4amddzSAl4?=
 =?us-ascii?Q?OpSOB7Ffhz+ZBuivfRXLvmvADWk4ZUa0kMvq4yi3HD9v2blcNXKEOweL/sgW?=
 =?us-ascii?Q?hD7hm8MOfvEM0TNB4fL+4ZJolN/1BaVe0fKJ0e9HoiQWLQ0wU/R4ma30LkOL?=
 =?us-ascii?Q?8hggisNISB1Mb3LEqb+nDmEo4hXkiyDokG8Fk/gcQiPqFi0zdBZVnaYyXMCR?=
 =?us-ascii?Q?YXtc6RhqsTVYm/5jGfb1U5dLa99ldqLo1K0dprsrDmmT+jTilEqCPxgANmnj?=
 =?us-ascii?Q?ezcuYhtywrjHJ7qnFJ7Sf6YMux1JXRBi8WvZJbRyELYU5O/SU68+dHHfP6jD?=
 =?us-ascii?Q?PUWp//Ti2VtCRIdjbt6RGaZxAsDrsp70Q0V3deQUYEQeSAdm3ss+9W4PVdsA?=
 =?us-ascii?Q?TNsd1fIlqs5NHfeYYl8/J/UGYzsEzeXiXjw2l64ltJ3mfbiyPNfFcoZrIHeI?=
 =?us-ascii?Q?2kGcQXSjl/guA3CRDbux4C0WMlwkKMoEkzyizHiAcfuwUviT6MPjUtVjwUcE?=
 =?us-ascii?Q?tyM0PeIylRhLm5jnvVqkUVyAuyZUMIlaP/vqVDRniRDGYooPfuhqQ/r48+vO?=
 =?us-ascii?Q?HZBUXPDt8QLLHhmRF+meYmZExI3eM2SDDCnYCYN9dMhInsmjA/IG7mtwxNzI?=
 =?us-ascii?Q?BYoa5dmcR/LZ6PAqp1HKa5uC7jxR4niYa5ZgZVuUO+NvsOuhiWzgyOu5EGTB?=
 =?us-ascii?Q?PcRUKjzL/Pi6Og8VahhAxaJR7FBFOaCpTgEvySfreZPJVvmaoLkB3IX1Tnql?=
 =?us-ascii?Q?k1Pv9b4gQdDwXSRhnsVgADGRAK9mjgno3pEHsfHbu3DDF2fMX7Il6CJWVilj?=
 =?us-ascii?Q?YTZyE/wYLll7/D3heYxDChfAhm2a+/JB04QuJ90a2ZpyTwYuxDJ8v2dmlINv?=
 =?us-ascii?Q?Bxiau9zyPm7NDP8NdU6W82KYgQLZR48DqVyVljJzlmbRzJsx6jb3+efgVExO?=
 =?us-ascii?Q?O0DO23KZuQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03483530-fd16-4851-5fb6-08de54d2b096
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:41:41.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbcugNv4EJSQoyKY1iXCOI4kiirl0h5/Fh/ZMhDxSosqqRyD4ci6c6lncT7MRQ08DSZEihORX8NTnOXZ6APykA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7390

Currently, the driver writes the ENET_TDAR register for every XDP frame
to trigger transmit start. Frequent MMIO writes consume more CPU cycles
and may reduce XDP TX performance, so transmit XDP frames in bulk.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 251191ab99b3..52abeeb50dda 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2006,6 +2006,8 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 				rxq->stats[RX_XDP_TX_ERRORS]++;
 				fec_xdp_drop(rxq, &xdp, sync);
 				trace_xdp_exception(ndev, prog, XDP_TX);
+			} else {
+				xdp_res |= FEC_ENET_XDP_TX;
 			}
 			break;
 		default:
@@ -2055,6 +2057,10 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
+	if (xdp_res & FEC_ENET_XDP_TX)
+		/* Trigger transmission start */
+		fec_txq_trigger_xmit(fep, fep->tx_queue[tx_qid]);
+
 	return pkt_received;
 }
 
@@ -4036,9 +4042,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 	txq->bd.cur = bdp;
 
-	/* Trigger transmission start */
-	fec_txq_trigger_xmit(fep, txq);
-
 	return 0;
 }
 
@@ -4088,6 +4091,9 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 		sent_frames++;
 	}
 
+	if (sent_frames)
+		fec_txq_trigger_xmit(fep, txq);
+
 	__netif_tx_unlock(nq);
 
 	return sent_frames;
-- 
2.34.1


