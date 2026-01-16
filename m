Return-Path: <bpf+bounces-79216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55250D2D719
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D077530C67DE
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC7234F478;
	Fri, 16 Jan 2026 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S+zues4V"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9634DCC7;
	Fri, 16 Jan 2026 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549401; cv=fail; b=D8Bbrt2NmK5gI0a2uZG+hfU/Qb5HXj/F9Z6KyhW7xw7DeJL3yeO41seSLybgom3yGfEwckFbNFLt6yJy3s5UlodfsOr/VA29N/R2sTp00lJgXmK9wTxsT67lLKTGwAVz61t/RqLK/W+ZSWUITLpIywzA9dHzDyiZvpbY9+Zn7eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549401; c=relaxed/simple;
	bh=v1niPodP4csztepsK8F6ER9XK7dcVrP9n2F5Ku5K7e4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SNoBigT5N1MPN6JyH/tBF7zFHUKHteF//s6L/f8JF7O57Fmd2FXXvqdgKMhEtAWfypR0mB8MBldHfmv+ngXvMuMKv9Tidp/WSNnxFWi+8n8xasBsI1pvu1FcDFNB5xtQ6ZMv+DHLj9pkUGn+K9D81QNn4djRLVwRaOvC+Bp2Fnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S+zues4V; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4UR9dyCtZQ+cOTBadK5ay3bJ/5CB2jOgbVhRjnGmXbWWCHg7jNN+UQ2V9eajNU6JxPcAxpvunUJ0qA/SsPVCub9xtVwtttsyVS7DhQBpPEDetaI68FijDk+rDoC3oDcvpanjJ7VB9M4o+bzrt+Zr3gLF6bXrGVVIMM2V61Cv9E0eDo7wJPyhpSwdSbUkJWAx5chEL6IBxW6diqjKMt+j/hW1tXXSfdBvELakRU8XHx2ynE4NMel1ordkD0MtMZ8o44a/NZErRGehKIbqrOFsJhq6xCodaoF3jUjWL04yEE5uqkb0Y5dETO4xVm07sEH/qFd3V/yTHlr9nADitvJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jwyc7Rw1cF8rrhnCrXuW3bLKnAI0yneLeoua1zA8sQg=;
 b=GU1rZjrlrxh7q7yYcxhApMYajff9XtnwXQUAe+r75WNwpLT8jaAs8kiJvXibg/e/Sc8LYp50LVc0tSScf+AbANyHZM7WA28zeHrTX6lWPDFhJOkZqynwV0rLJPeKstiSosguog8qEwkZf10Ai0brfSPjif39WqJZcPXkaycOmGAzEfJ6Nbz080GMBX932PaLCo3FZOpym7nr+r/a4LM76VXm//UMO0kiovkhPc1Od10vgJmxEGZoXCAY9bdwzsN1ZUJ6UPFfzV1EN536e2ygqyhARyofVWWybenmp3oK+M5sPUiQjFGvD5NZMEWzxfrOuDAcByEo+SBr2n1ztrg3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jwyc7Rw1cF8rrhnCrXuW3bLKnAI0yneLeoua1zA8sQg=;
 b=S+zues4VOizKvJar3IpN4HB5H2MxzxxpioU7PzplIG3+enpVI3bOqpxGslWntKlfm6iBqWeXXJt38JPcGJtcLBCQhd/GwFkw1JNOYfLcH2NG76jheouLvrrLKrcoMXhKZNCUjDIxcmyUs/n3xF1CypoXPUJpB4xWYjgLoW4ODj4Weg3raGfdkgQtLucmkDnY6lGABhP7vecb7geM1ppIi2UriBJHxR9wNgwQpGM3MaydWh6Pj/0mshVjFrl1o36nmtOBNwRvLAnNw7nzG5+m6jaqI6tAerXbIs7CYq9YiukzGS6jsWF5C3h4CB32pByAQQiGniLEblM//9hs7qB+ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 07:42:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:42:00 +0000
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
Subject: [PATCH v2 net-next 11/14] net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
Date: Fri, 16 Jan 2026 15:40:24 +0800
Message-Id: <20260116074027.1603841-12-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 98c28109-042c-4b96-5e89-08de54d2bbfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|19092799006|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CJoY2eeeAw4KnNQCTVTfJ18XOAiQSgaPWG0LI5sOtxDv4phPfvDWQ7m0TqVx?=
 =?us-ascii?Q?zDTQH/gng7XP7yNBv30MYpHgYkhIi8+FEkPSfhoHOa1WC6gtMWd44z66Lrk7?=
 =?us-ascii?Q?YWRJjsE3KQ5+iz9tM6OhZ9ijLI1wrC6IF2dj9VyyMLApFfUKLHOxrRcfZjN5?=
 =?us-ascii?Q?rUvgenAFAPfYsMCPXoAJqv1JtFPbwelLMNl26L4U3PKM4qRm5CmcDx5YffAt?=
 =?us-ascii?Q?QAIpLY5tBO9weu9ZINqXAIdhKu7Yam+65dcmtmi7vZL3JccpkxYnYkX9zwmE?=
 =?us-ascii?Q?Bfn2ADtptQFH/izNWqxM2/1zKYuxdaICy/G0KtBu94KOkYFkgYmmJ6MAXGB4?=
 =?us-ascii?Q?Bf5t5xNs6cYkOeHjp1hqBvDDIS4xttpW1AkMfBQQAAUf59GB09orHGnehrJl?=
 =?us-ascii?Q?TIFHknLXma5EN+2QLZoksraebEyQj8lcE8lCLRUL464orzQzFu+QHE59+Qmg?=
 =?us-ascii?Q?l9n2nBnh2qMeRRGIkwsnrLpOTWc7iQc94C2DYsop8bJHqPvGlxrqrVFfJnlY?=
 =?us-ascii?Q?BXLU3OVPYDdpsEvOPr5ZHi+f4JQoSV+bfDY9IzS4cTY4l+JuWzrI0r2oUKns?=
 =?us-ascii?Q?37nW/8vaUi3MS7h9KH7Bgr72Y2pBLvibo+/YwomqXhcalHr4zegOHC6vk0QU?=
 =?us-ascii?Q?1jDkszR30ESgJOw75uGKMDz1kWRibuR999qVHpHit14OazOj0TQRDYalJS9+?=
 =?us-ascii?Q?8LWTMeQHAsrl9Bn+abheIpI17JQILZ/wejfmT1I+99cQbb4BH0yoWUhnZN2v?=
 =?us-ascii?Q?Xs580OLTzw4tn84jPLoWOfN08unetmZnKKaNOIylYr31XVkE1kd8Oi4UKmPV?=
 =?us-ascii?Q?g4l1qMWy1IoGO9zbC0Vq7oJ4mDJ4oQh8RkQdrxHZh2jfzz4Mfi8dI0KMK0Ry?=
 =?us-ascii?Q?PXgXxKofHCUacYLVz5XhuN2Qs40ce5UJAruAbfyPJWXmzJxL487jXdR7+Uv/?=
 =?us-ascii?Q?sULfFoaWAmu9g00Cl/uDLaC9ewsWDVJyXSsOzVIoN7+8hnGb7Eoy4tfA4cGl?=
 =?us-ascii?Q?mVVfxEpyTJNkYb2zLPb9Q4IbyGcTIM5RPlCimpXyMgQ29S2QLKcyP23Gg3XH?=
 =?us-ascii?Q?ptiKkr5OwLYHny2Jh1/CCwiz/OIz4duktmRlA8ZtSvsKZrtX4a/c8Ry/WQHQ?=
 =?us-ascii?Q?Ns1dYOB51MCCzSAILHLww8d+eZpUVmYnAjgFUmJjHih9WFRluJQ4kdtddho/?=
 =?us-ascii?Q?hpCSQxJ4yJPdoKOP6LhU5xWY0YhseEe7kZtArrRURLeS/QR80otIp++H49Gn?=
 =?us-ascii?Q?/zcL2+f7qZkOV2HDrmlqRrA4DrzpQDpm/ymIIehqvXrWniLDtMxhGhEYtBlw?=
 =?us-ascii?Q?6gd8XuBp6+WduFVizXtiklingtd7ITUBhFCkwrKUOMNVMoLcEeKA6uUreijF?=
 =?us-ascii?Q?22hBq53kB++uuL9EpWrNnOybpa1RPfGXKdrzTvTAvd5daimE+UxUCXd2ZPEh?=
 =?us-ascii?Q?QpWjBBK/RXtd6360sgVzekoYKdIv+PL8p+yHoirP9DcQIqbN3+aa42OAoHrd?=
 =?us-ascii?Q?KAzaWvjO78INIgRr2QC0aHGvOADsx0x6a91IHEC94e8UEQjtFbY99zl5kKQh?=
 =?us-ascii?Q?kMHJkO38LasqK2zkHH5d8OCyWEJe9mDCTlCyNIenZy4UxcsFP42QxM/4tPpH?=
 =?us-ascii?Q?SUQgiWY2iHUCo6n1YET/WexP16lg6lEX9sgTwhRAJFiH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(19092799006)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DrT1TZDogAv9TQgR2iLrHqhBkpfUs0B2nr1GPLIAxCG5t4wTA+hUrmRGTbkb?=
 =?us-ascii?Q?hvR34a52nVeEOpJW8ilzt+kvyyu+5B5koIo6FFAEmXCU1xYZciiQuyehjifz?=
 =?us-ascii?Q?KdWvMl3LK84rFKiFN1dwS+5nZAAbk1GWIkASEnOQmKmNYUeL5u7WSvp01Bt9?=
 =?us-ascii?Q?Jfvqk5ICncvBwE0Nu7sAxJ8KPEIVo+kXXdpZQnnLuYuFzKnyAT59kBpQmF2v?=
 =?us-ascii?Q?Ic8iQhz6YQhtXFqyLEByDm1WkMdlpihgTaTSL5WawoNaHlg0b7G7FwfZgt2H?=
 =?us-ascii?Q?L1ayYbXEp7Spayj05hX85zZaoHW5Woyaouq76mit+5dSzCnxlxtkk9Rwa1+W?=
 =?us-ascii?Q?AOb1O0qLKT6eofFQk+r2nIuwhUoGPQzSYpitY04TPvn31pMUJuYfLtMgp0l9?=
 =?us-ascii?Q?ix8AEyznTQmiXsvhQ6swqetVwfJfzzHohcSY51G+Aathxqh841D/ARGawbq3?=
 =?us-ascii?Q?lxJ9BXcog/9QyD8jGfbZ1FG2Vn4LmVFQ7ddLzn4kc6K8svHqpf5UiZ+KYUOb?=
 =?us-ascii?Q?YlcdCKuvpT8+fXxc1pcGEyP8KAT7Xs7RSv+6OxzfRJXjxFz0SZq3OTt/0Klb?=
 =?us-ascii?Q?NQrSlH07seiN2bjs6dmZo120VO9vWGfUjTV1znuoTS8XKZ++FZKuJyZxcZ/a?=
 =?us-ascii?Q?XiOp0xi3PDuzkRWcNKqmvYE1vO9mgc4RwD8Aupd5D4uSZb6luQk/HfG5oknD?=
 =?us-ascii?Q?48fMyA1UwMjz6OLoVMcMcxqBjMx3+bSUHBTwJ5poP9Sxsm00UXRjkcaPQswh?=
 =?us-ascii?Q?gpBLUwgYShq+T6HHCaLXKgIcyjK2XM2wHxm87oMtImK5WrpXLdVR6wCaeoAi?=
 =?us-ascii?Q?+vCZw3DJj+OglhiRvKNA5jNEdu4sDZ+jD7jrBCgMyYM0Z7lyeG4FnvTPdiFL?=
 =?us-ascii?Q?GgPh6EmbMRTVyBGD4zGoNLNdOwVRz/N8K3u6qP6Ge/CfO4eNJYQ/WBQjsh5h?=
 =?us-ascii?Q?PPcMR+X3uBU1PG11B1suDYqXrHo5OmQDVwzzAw8wxkunls/9W+VXqK+LSzSW?=
 =?us-ascii?Q?gt/eRG1sYXY/XCAmlMjTHdhHKtENyu+LuUYWZ5TazfXfY37glfROBLdERZZ+?=
 =?us-ascii?Q?7fXkj6WGiSfa4XIWPOVOd/KgJrClG0T3Gj8UDbij8G9znuni7zP3gYbPr7jP?=
 =?us-ascii?Q?9HctpjrC9Izwtcof53QJzRJ9XaGJ8SWvwHOQu/eRRG3EvK4//KTtVGvoFfzx?=
 =?us-ascii?Q?U1sfaGMInxq2kxTdhv4vQohonN5NbiPawJ1Y2J1KNjeZSo6NSSbsF+wHGUne?=
 =?us-ascii?Q?VzFrGSqfUbKAekSvLw0W2O8MNRkKbOwe7Qlwy1JgrC8nd1HOnhkvGhfWHBKu?=
 =?us-ascii?Q?UzXXiUak9zB/kDwh42KUQZ5nIQvCxhWOdm0BohaBWi78tEFo4uW0WCRWHcvK?=
 =?us-ascii?Q?+OyGMjuo33xef4Q4lGjoh+ZW/INDpjiX2+hVwKdp5mJhvMTiM/ddBlS35wjT?=
 =?us-ascii?Q?ZC1L/JGixnEiJh9qILF3vI4rmRHzoE3X6kV4NNRmjajDOuRpa+djlRGmCTYl?=
 =?us-ascii?Q?QaoG3P6iycfySPeLtVSkZqm6kixpAZkSMdPua9oCH5GNDXZN91oL+1s8l8BT?=
 =?us-ascii?Q?ZiImEf9ryYxzFW6CoWpcw9kZUJZimAqEYdPmFsMHcuPXgXTW7PMasahkYBbx?=
 =?us-ascii?Q?MWw/TLjGqLESXJhsxA8FZH515JubOYQPBdwXeFdxLk90SBI5CXp3xneh5Pay?=
 =?us-ascii?Q?sYe3apPVXPArgV+FDt7o7rcwG/jID7FJRgDHoTHhAmNvt+aUc0n/3Ga1SBeO?=
 =?us-ascii?Q?Xn5+ZHJJCg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c28109-042c-4b96-5e89-08de54d2bbfd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:42:00.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bU/l7OmFDZVkOP2vfCPFs04gjtNRitxzS0c3NUWixn28t+i0XosSJ7yHThuQsh6jxi3XAH/0zwGD22yEYzWNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8712

Extract fec_xdp_rxq_info_reg() from fec_enet_create_page_pool() and move
it out of fec_enet_create_page_pool(), so that it can be reused in the
subsequent patches to support XDP zero copy mode.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++++-------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c1786ccf0443..a418f0153d43 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -489,23 +489,7 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 		return err;
 	}
 
-	err = xdp_rxq_info_reg(&rxq->xdp_rxq, fep->netdev, rxq->id, 0);
-	if (err < 0)
-		goto err_free_pp;
-
-	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
-					 rxq->page_pool);
-	if (err)
-		goto err_unregister_rxq;
-
 	return 0;
-
-err_unregister_rxq:
-	xdp_rxq_info_unreg(&rxq->xdp_rxq);
-err_free_pp:
-	page_pool_destroy(rxq->page_pool);
-	rxq->page_pool = NULL;
-	return err;
 }
 
 static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
@@ -3419,6 +3403,38 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
 	.self_test		= net_selftest,
 };
 
+static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
+				struct fec_enet_priv_rx_q *rxq)
+{
+	struct net_device *ndev = fep->netdev;
+	int err;
+
+	err = xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq->id, 0);
+	if (err) {
+		netdev_err(ndev, "Failed to register xdp rxq info\n");
+		return err;
+	}
+
+	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 rxq->page_pool);
+	if (err) {
+		netdev_err(ndev, "Failed to register XDP mem model\n");
+		xdp_rxq_info_unreg(&rxq->xdp_rxq);
+
+		return err;
+	}
+
+	return 0;
+}
+
+static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
+{
+	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq)) {
+		xdp_rxq_info_unreg_mem_model(&rxq->xdp_rxq);
+		xdp_rxq_info_unreg(&rxq->xdp_rxq);
+	}
+}
+
 static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3430,6 +3446,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		rxq = fep->rx_queue[q];
+
+		fec_xdp_rxq_info_unreg(rxq);
+
 		for (i = 0; i < rxq->bd.ring_size; i++)
 			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
 						false);
@@ -3437,8 +3456,6 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
 
-		if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
-			xdp_rxq_info_unreg(&rxq->xdp_rxq);
 		page_pool_destroy(rxq->page_pool);
 		rxq->page_pool = NULL;
 	}
@@ -3593,6 +3610,11 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
 	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
+
+	err = fec_xdp_rxq_info_reg(fep, rxq);
+	if (err)
+		goto err_alloc;
+
 	return 0;
 
  err_alloc:
-- 
2.34.1


