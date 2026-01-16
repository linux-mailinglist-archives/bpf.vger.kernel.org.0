Return-Path: <bpf+bounces-79214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCDAD2D6EA
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F7E130628CB
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAC13491F5;
	Fri, 16 Jan 2026 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WIk8Q+zA"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4C32FA20;
	Fri, 16 Jan 2026 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549397; cv=fail; b=qIlJEE6qs9y6JbR2BpUno3bJVMi+Sa/2fHIplBU1jdGg0x1qACzFsSHfoiX6+/Pr/TNqlZqnzhVZIjXD4iyrIHwuZUOf1AppO7RJJf2dULLS6f1Msdr9FcqKWMJoeVYb/aezy7VtRwoUBcfFr8THUlPGq1pPp+kpvpVuwTEVPEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549397; c=relaxed/simple;
	bh=c0RojH67rGHebggEpW6CpX5bD+TmqQP5m09rm9Ubvwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cIduK4fIKIJ/bqmc/rEUHp5AcijGsKrZySILe48PaXPjWbb7sw00yA4yz1fakBUE5lI4DeKAylS1mb39FyDievaePByTOZqjruHBmN14zxPWjuUMcbPHfB2hSr9Va2OWRn08P13Afxj4189oVwflBqQviVUvWjyIAzPaksE3Aow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WIk8Q+zA; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4K1KVlIkzLsounfG9xzVbALJ8f+QGvDZvVL275rd4xd5cGS0oiUPgUaoBv/tOGzbkkoVkfSfr5vtyeIJvT8Gulu1BtKMksVGl9/UyIkfCEDLzjh4bgO1j4HVPuXwePl1HgAa6uislZoUhquSZZZ9cXBGBUclzpw5k0BAEECYMrBCC90QU7tfRwHslp+swhzwwKvWrfTxCTlUOTYpBye2um3Z4QTSReyToUtSL3BMCPeOD6oxmzBH2FTIRZ0SLrnI9IlHVWOV0UoLAzJPQTb5YCp6LFCQmzJUz5sfxHCjHLkwykM5EUoRA1HfQPWmH3pSxYQIn5OnzizvSIYlJ0Jtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuNVtZMgAcAqbWLr4RB5fukeSQ0H/eloEsVrsh88ROU=;
 b=E1WhRZ9M/eF8dM6FOQS1miPuy9W+88VPx7Xp2OvzSJnK9xWhKdm1fH/ykuKaU2ual0AKACv3CFrhbb8ywC95YJh5gY/mJQ4rYMwMiDT5Xg2LLYExr8az+elSFZbJ3A/tMJVjjacYJcCLggY/506Xd95nM+dLB4TNiKStyhIxxYlW2aEga1RJK/Ff3HW7nOxpi0xgWi2ws9Id2EpwvppSvQep/skwhfB4CwDkytfbwTbC+FR+REG4db7POA/kHwGK56nbJjxxBEIT7brb7VrCSat+mjR58HacyVTz74n2+qBTIZSI/xXz3TGkecR5ilJ9zGktPZLFrRPWB3d4qupjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuNVtZMgAcAqbWLr4RB5fukeSQ0H/eloEsVrsh88ROU=;
 b=WIk8Q+zAeGwDf7kR0YqQ+3DvXh3+tyijlf76Tgy4CdalfZfVzpevQusPS6PW9jXEMsRfT6nWcKZWIaf43iInYyzH6SJxc8ApA0DbrJDxLW+1ydM3vJuL+Mn23hdmV+DxewqMMLMMoClgS04e+JEyhGFe3ytwigwY+es1N2JpvREox1YE4f9yrH5h0pNaVEZcIsFadQbp2W0VkTn47JxV1SLnYvKWHp/JaWlHL+DzkYCQA0veEKQ4j5U4eT7lP64l6WOvyFrUq0wyYd95OwyYXVuJy/T8Bw7KrcWXebtY+F06rsVKInD66l33kPLmzalZejEQcF9x00d+/453cwF7+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 07:42:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:42:05 +0000
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
Subject: [PATCH v2 net-next 12/14] net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
Date: Fri, 16 Jan 2026 15:40:25 +0800
Message-Id: <20260116074027.1603841-13-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5f1d5397-2f64-4677-4b34-08de54d2bee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|19092799006|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f16kUq7kmGRakKjbh2vcGwDOKULzOxa/x6CicK3oApuMqijX4A9pCTTnIo1Q?=
 =?us-ascii?Q?O6FAco1Naq0YWAG4EPv5/lVKXXLd6Rmih2eYLzEdJx9Pwfjj2bt42MdaEY5o?=
 =?us-ascii?Q?Djb7KG0Ck86lKzNfQ3540QQsnGJzQZUj50nVWxn7Gk74xh1yNKaQNbe8RVRE?=
 =?us-ascii?Q?aWRMoKyPhV6Col7W5Wlc1bslSkivTWO8GNSRjdvowHbhbiVlZAWoUjzIKiYE?=
 =?us-ascii?Q?zfv5Mj9u8S89kTp2Kzwa0UF8b0qbQpMM+RirttzsBUSpRFHRyZ6VBJLVlJra?=
 =?us-ascii?Q?oKGI1K0Exfam0fWAWXyf8LyncZGFYF2a3Eyk/OLprMxbF2rMx1t9OlV/dlKJ?=
 =?us-ascii?Q?xnov8A8LoTlsUai1cfcvoFExr2+OO/CptQ7U226S5uw8tL/dQ5zWTqtPrdWa?=
 =?us-ascii?Q?6E+8Gm0zeoQXnQLO6jMXXPEpf7xCqGtI6KBSKkWRLqR1+TM/5S9zs6G5ha4p?=
 =?us-ascii?Q?+hYc14zUqpmQP+G9Jyba2NPHU20MVYuzG/U/9pul5PLUf+MW5LPpabXYWnQj?=
 =?us-ascii?Q?VaoWnirBrrRg5e4zuHWv86Ei33raBZ52QrICppOFGbC58quz8nermaoGgF2Q?=
 =?us-ascii?Q?mhAVAA9IbTNvRDvT+GT7iz1ht3tM8h4QFODHSzjGuZ2l4OGKQ+4j0Wt+v7Df?=
 =?us-ascii?Q?5AmepQDRTz+OqtvjLUlMoQgvRFwaJU9gFq8RwxDTUjqb+zt11OhA2uKXRDOW?=
 =?us-ascii?Q?aPAUxj9LuD27SA7gZHZCojmn+d4ehmFUGMkOSL0UavFCKtISYbMtJgqvGXMk?=
 =?us-ascii?Q?MDm6zMFlGsm33tUi1IaG6LTjz/HaOCejOPkPChn/+aCs/4A4Rc94C/se7Uio?=
 =?us-ascii?Q?FGu9d2hPJSFt70leYbXJQnjgwAivHfT/9DU1FQrHsbWrsngyJm4koQwv0IbA?=
 =?us-ascii?Q?nihLjuZ8sCtQa0g2yvgU5qGZx46XKoyBp6XqtrLYiCSOvFg1Oh1sMYvIDlUC?=
 =?us-ascii?Q?CsVcDdGrWlgNUYlzo7ZEGNxB8eLvKlsTqSwnEeSlAoXVKZFYbAZjtLf5I0nt?=
 =?us-ascii?Q?ThV1Rh0DDTLquJMNZji6dlGOQkRN+7UKTFupLTyxbuZHZHWDY9LFpjolCprI?=
 =?us-ascii?Q?AK/q3iZKiwpkc9+TxkRd1vA0CP+QPV62XrnezHDQdNZQbnjQbg0BV1rE5GEZ?=
 =?us-ascii?Q?laxMo72yyRQKZ4wjSu5xNDdRdG4k0lrWnGKlh2noxNRuF8Y7Pxt8h2Zh8hpo?=
 =?us-ascii?Q?gsrRlyRw7G9jM7xDzjcI9mNBLV4BskR9zbir18Md6pYTTejqet5lUx95C/6r?=
 =?us-ascii?Q?02v/jyWi695nLU10pn3AWcKZ7W2vx2zH8hU7AUgQaqfcEmd8S5BL5PLXJST2?=
 =?us-ascii?Q?BjmvBybyupVC+HIOVmkgUeg8MU3FfTQoAtUxqBgCXKSa5m/zVYZI0lHGrqE3?=
 =?us-ascii?Q?qKDLyQ5I4j0CMR5w+QacT6bTEd7eGalt+AFAMD9ovIVYhMAqQ7OcH46CSwen?=
 =?us-ascii?Q?K8ZVDui69XdpazOw1lNDdSCyJVY2zmGMY+ie50jEd/adPvzr2nq69hllcv51?=
 =?us-ascii?Q?ua4isYy3ULGQnoDM6jlsst9NY4/3U2/gM6aUgNCTw2lb9ch8l1QHWL2nyGsN?=
 =?us-ascii?Q?N/GuLCnMoTfnqZd1zjx46Kbj+uPe+TPjre/DnIULCt/7XoP28gS6DlJYmwON?=
 =?us-ascii?Q?SfCgxJiED3BoLct9vijEdMV9tY6AQ2Qp+/72YUrJ6eGi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(19092799006)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5dZg++Xo+EAAefxSjQYwlcuHHFNXRvH2Ir/kdq2m8psXu09K54TYQDD5EzaM?=
 =?us-ascii?Q?cRFTnWtqLVMrHTQ4c/w9itg7S2OEgLhnZxgn6chefrGQRsooIBo6H+3sCETV?=
 =?us-ascii?Q?Y2kC6mtpzSiKvPTInZutx9t/7TTJXISCtjDJvxMA1ag8Cnb4kHejQVVUpnb0?=
 =?us-ascii?Q?57iht1Z66oNhnPbg9byWpgx4tT8Ge2rM6Rr6ftrmLSv2OGVzfmfGag76c96t?=
 =?us-ascii?Q?+jS9olOJyojoZmoqxuoSclPA1Gc46BS9xD/t5e1AuFlk16YPJPAd+XVnmmhv?=
 =?us-ascii?Q?Bbik9Ji7c29gtc0gPQch7kgy7eiQDoJ/wmbLkjSsex07cLIWAjcoZEL/w/Wa?=
 =?us-ascii?Q?3IGmnqp3zIIDz7PTqEkO9m/V4wKCtwzK9tR0KIPrlQXMb84UTnJQNxygXNde?=
 =?us-ascii?Q?P2ZA+vFjWYpg41dZGMz/h+aPNv+Z0P112O6mTM08GLEJgUZ3/+jvmrrq9xPk?=
 =?us-ascii?Q?fSsudZ/fSs+pYq6GWcDNXtxJRCcFAdpjW9Mf7bQBav1ndzBQ9LgT86LTlF1b?=
 =?us-ascii?Q?FJdtFnZxiXs3tra0yWUHG+hBKq0AZOHP+QIxzu4uqlNN9X7Q4RbPlxGZBeeT?=
 =?us-ascii?Q?O9uuQ/1JRTTBUB2qemZ8IZEwSti1YfedTkew9buHdnABY5fsmY3d4PLrlzhx?=
 =?us-ascii?Q?ERGGtaj7/2uXWXoWxLkivx3Q9VHRLm8uWe3Y6RNSJhyV0sIvpEDZG0EN8X3T?=
 =?us-ascii?Q?lTbeiPbCTRruNdAzyW7osEZtfbrYGreEFVPdJbFEOT1slyKNFMsT9kAcRc0X?=
 =?us-ascii?Q?RET6P7AoSthASm+ClDUPWSn04dubdLVpDfNBbnIXVxCE6vH6KgeBiVWNxoKk?=
 =?us-ascii?Q?WBpLeeFwTc1bJhDktxK+FpglBIY++FbUPplTfhDovN2U0i7iT83CzSLw5rVD?=
 =?us-ascii?Q?JivOsAJhDDJE93/6buXVDwAc1Cd45tkSGx+v9a1xZINkcpp962wFK+nitqcG?=
 =?us-ascii?Q?PEIxwrq5xBSX9kZHhvjhCHMvugEX57qIAisobSA2noiVhbxY245DBpAV9gHT?=
 =?us-ascii?Q?IuR/CgW5z1PQNmtGrbT570V8UQ6h1PjXIv44NqOJduW4xqjwlHQG0D4lwWAS?=
 =?us-ascii?Q?zysccib0lrnEXfDxNgxXtiG+pgQHNgxYIQu+3S3EafcCJm5bTVtmJ4hTiZo2?=
 =?us-ascii?Q?iSSBNT3BL0IAafe8NGJL04i/0ncTn8C28JY3ysfajY9Im3r2h26uV30HiNue?=
 =?us-ascii?Q?0CH411ZwX2gyvgsxoEGH/UpiFdrCJOIUOON7/TRqOdZXQRGXns659gg/w/b4?=
 =?us-ascii?Q?kfIVCuGFumGIBicl8wZ2FJjL/5HLLefpUnEnea1JTkOMfBjChZDLRdIMn7C4?=
 =?us-ascii?Q?LQBwPebEPw6tTl1EgEz5EqEDl8x/noHJv7MElWch2dwkYomcEv8fRyP9iziN?=
 =?us-ascii?Q?O801S6xXsGDQ5GXqLaLKZkNtRphxuqrqDMVpo66h7Uj5gibNyZ0Lo+9y+lB8?=
 =?us-ascii?Q?AMu99ZWm5rEZQ4K19bs4ub+QydznOM/AZOyH48sTUXvl/OSLWx4I8YqsahvI?=
 =?us-ascii?Q?M/xc2RRlsj97FbQitAsXXK0Ph8EB12jco2VLx8BQ+02e4grNJPbftM/7n6mh?=
 =?us-ascii?Q?hoQ681eIJu21rq/IldrdRK/qEwd1aHMDD00Bu/QEfLrYmBnAOCxbKyO+uycn?=
 =?us-ascii?Q?COcIj1vg0PKRSldK+MUe8I9xmjxxTEVkjeoI6p3rcxhAeiu17m+PiyN79Ehj?=
 =?us-ascii?Q?Jj1zpCZDEW8orfdjMbgPrsRyEjBo6+SDAikcyUA5jUamdmGbrfI1ALvT8qjo?=
 =?us-ascii?Q?FBcyPuilbQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1d5397-2f64-4677-4b34-08de54d2bee0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:42:05.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gd2qGGlzGSk7J4L19yeDHjRkdz6r2W2qPYwPCMQaSvzESdtevPE0XK1xK1tOJo0oQLDgeug2zBPF8obz5c/kzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8712

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
index a418f0153d43..68aa94dd9487 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3435,6 +3435,24 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
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
@@ -3448,16 +3466,10 @@ static void fec_enet_free_buffers(struct net_device *ndev)
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
@@ -3556,22 +3568,18 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
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
 
@@ -3590,8 +3598,10 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
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
@@ -3601,6 +3611,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 		if (fep->bufdesc_ex) {
 			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
 			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
 		}
 
@@ -3611,15 +3622,34 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
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


