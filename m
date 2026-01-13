Return-Path: <bpf+bounces-78647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9B8D167E5
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8A533008E29
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49815346E62;
	Tue, 13 Jan 2026 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d9kgUzWp"
X-Original-To: bpf@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE334A782;
	Tue, 13 Jan 2026 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275029; cv=fail; b=pbbii+AYwiC0OkXAVYFpq52CTAPSOel6FqjJOAEM2lWIBsbeA5CYNu6x/1f7crSeK/hbw3MW5e+pzUOJ7d2jXs3tYOg60ICuAGRx5phdWLQFF7qUK99IOKLccC0z5xQ2ebc06TjpS+e2vwg2BY4U9RxKKhzt/ajyrvK6BJ522DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275029; c=relaxed/simple;
	bh=T9d1miHYFzccHSWX7F31F6omdcB8O7zd0K5njY/kUM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dd3piaEYuP6dbBFO1jUxSD4QSERe9YwvCf4t1flK9/yJLHy88nOfKm0pHdO4wkEYLNTrRfmGkzxNDcj2GEcAi6ktniyKkU3HwGH+/2jrIC80FvDslcOIA8OxseAT39gggTBU3Lz+6iEAEcYJo0/wz6IcgkbkL/wvDIba2wBLRPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d9kgUzWp; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmqX7e1l+45eebP3sn0+YpXjh4Dp9OqKJmrz4K1F8sVm/uampY7lNj9eLaUrZtILvus8YYkdDE1gXAXh7gj30G83WQueD5A8ht6DxCuxY66Nz18JX0vkV8pkvJ9pzK2rd/mrTESM428ZVILeWwuKAc58n3odhGSDadmZPRfSgOkgU54azutgKRGK+dEA8QfnjgFhayTrdSMPCy1XXtrl+yK9RiqVprkZvquyaanK1rbTU28Pun+urzJn9i4fDjHYycFLq+LWe20SULIYlxd8s4nLUvQI/11dzHH3fSyl5XICVPtCHzPqeQWzFpdmFhhjKaxBvZG7KzO+JcC1xqOeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiZG2DQCNErJbSq5b6n8dKc0MWppjO9JwWRuArXRwQs=;
 b=MrrZHKCkvKJL+tQO6iwGReNWBVcPmtGJGk9E10tkeFXhVWcNguR6F0WEBgnIifW/8BLx/bZiG07dRwud7CiszmOt9qnp1R94BuUhLsHBWeC5wFQVKx0FQ71G0ycBLeHU0aeZEUEmRBZ6f0f2jBXccyIWAFIhGiIl96P2YT2W5dBIV8H+swSoMZjNloKZNnWYp0Txfkoimo2UGc+YlgxTjbA/lrsKs+YkOJU25uJ+pgLcugD7u20ux3Aa+WbIvqVZEXYUO5T1uB53Wx2ThSaMppiRBSrGtD9P+CZOweBAKPL2O4H813K/65KUmvNE/0AwxbGmCl5lnjcaMaZWIWTi9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiZG2DQCNErJbSq5b6n8dKc0MWppjO9JwWRuArXRwQs=;
 b=d9kgUzWpNwMwhS8owOQqj2nmbg3ZHK4Im/iLXG47GAEgggggtjEIr6LHnSNbYdx6VPo6rsdVrlH9I4UJxkYpmd8+B01wUthraLTlf8asckHQGC5QbLzAJR12GGcCYaDPvuElxk20Usji7N9t5JsMIrva4xzkChbx50alKXOT9KuIJVLIWP48+a5qwcW0GIeHE/lgJWm/1VnS/hWmojWewDEZGIi/SMlQkSUbqkXiLhDx7OIjuyrkcWWajLIxx+Xvrt5UKbGnYZxzGBobyyiqZJgemINpf8q3Jrr6pf52fugX4Nfvy1q+EyYq1SK9kQI2zF1KGQwNP+CZXj+KJR1bGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB9395.eurprd04.prod.outlook.com (2603:10a6:10:35a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Tue, 13 Jan
 2026 03:30:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 13 Jan 2026
 03:30:20 +0000
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
Subject: [PATCH net-next 03/11] net: fec: add rx_shift to indicate the extra bytes padded in front of RX frame
Date: Tue, 13 Jan 2026 11:29:31 +0800
Message-Id: <20260113032939.3705137-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d8c99d85-c7be-44f3-c712-08de5254140a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|19092799006|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r6qETOeflrbmkSbkNvFC7mDmUm+1YBe+9n6gV6gWjuXXHUrE4TcEgOtcrXNy?=
 =?us-ascii?Q?o/aMOQjHFIr6raB1/bYU8ybe8PHmr4yZHtY0c1cX8i2S9ecp27FQl3C47sKc?=
 =?us-ascii?Q?oVdSQgaaQ7gwqayBqh5pX9B+QlnoEA/6W7JWMceboFZsRhcIz9ZIyK4w3J5K?=
 =?us-ascii?Q?b6vmk8xGdYdQ18M/skftspsbe4G6erUxlDk5ppiHC+32Kxfkhbi33L+YelR6?=
 =?us-ascii?Q?Dckj+p7GDZJUPBn5z9sKjN5VvHFHSgfptoyfdXZ2VbG9u4PEVJrYYu4fL5cW?=
 =?us-ascii?Q?RJDlPSw8ETRbD/L0CSBBICRit/r18FbpUnHRPjzNEDpBy6Sayw5KFBaUUsP7?=
 =?us-ascii?Q?/oXnT5HyRfbgPGOfvqWAYT38/M1n0WvGnB2rOV1mzOkL1C9ZyA2NDAFbjRxs?=
 =?us-ascii?Q?ETAYgBIMzXUUE3/v56+btFHP42MCA5AmACIcya2CqU3s36BPhqE8098AlEFx?=
 =?us-ascii?Q?mhDpBj3PWpFVCGWzfB1zKf6SWjkqdp620NeG1sIrg7qo5ZO33V8PcnEVz/r1?=
 =?us-ascii?Q?ZJ1ibaKy/8oky07+Td6e4Dbnb20+ZRG3n1vEZnndrnU1j8t0DXfOUxi7RCZK?=
 =?us-ascii?Q?CFTh/75C0NDfEWeJEMBAZl2csR3ljV0iFJhW9x2LDeNe/872nh7USmw8Oac+?=
 =?us-ascii?Q?cnw2rgTM95irtSiFhOOA6CWPurE2WtZupcLc4AlCOjug9xhrc7dT+EBr8QdR?=
 =?us-ascii?Q?paB29F/7cCnxF+R8zxrtUeVRsfeieYIlHPpGxbxy/Jp7O46l1xzJKQYkhFA/?=
 =?us-ascii?Q?5JV7PGfviidsDo77CcXoIATSbEli1xb//c/GyUUdBnAgi8XQmHcmamS6slH+?=
 =?us-ascii?Q?AIKHYuwp2lQJ8eVloEZVDKk4NB9kgBd20gk9q4fbtc74DX+mDunc2mhZCwgt?=
 =?us-ascii?Q?J8fv9t44DfNo00u7s2+BpT1jpBDbKzl4RGlDgeLwmAG41n23XbYKcyCgwBl9?=
 =?us-ascii?Q?haNer8E1wIm7wdlE02vCNyzGitMujSdji4c4ltD8JDl78M1hs9PuvN5EjUgj?=
 =?us-ascii?Q?fqY9W+twUEC6aIdKeXK6h+6RWK7Bs2d35irs39uijMkirhYvyGBBAscGGcvk?=
 =?us-ascii?Q?9iTZuMrtRDZj/NQu4Zzgb1W5mN0YuXzhnPNBuuLNWYo2kiCsgw/d92Cbl6T7?=
 =?us-ascii?Q?uaUrXa+HYd3dc+NZJXJ4Flv2UGCCEZbsHPHbOUX8AacHh7oDm0zLAPB9masM?=
 =?us-ascii?Q?UioDVYyqCoiVXCKOVbjBzX1q0xVXvJAN1eDFx7nIQtGdc91WQURFyx/DcIjS?=
 =?us-ascii?Q?rqg3CwYdu30jBqkGQl4C+UyOvuZF4sGtZGE/T/cGQdzF3fNkBVZ2SWvrCqC/?=
 =?us-ascii?Q?YYXGmSL2FDt1M0RDE2JBYGBFDElmBhN527mB4m/E15qrCpp5oPyFeVotHblr?=
 =?us-ascii?Q?E/+f3NVj2fLAOy0E382iB81rCztGN2DAYAU+u99iDIlxn/HywQ/ooz68/Eck?=
 =?us-ascii?Q?vIm7W7ijlNvcItS+AdvbW61iqAvL8aQHaPJX1pAAcP0ST2rH4ClOYX1hynS0?=
 =?us-ascii?Q?Fa7w9nXaT3ksjQvoUDh3ddPZBGph/Mq9E+2Uja/mnCyVqbemPEWxNCMQEA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(19092799006)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JaqIBbzmAv/fL33kOq56lmSZmAUgZ8+sldeHK3py/Jvcmg0fKgnRuiXcyeBQ?=
 =?us-ascii?Q?jRcEBa8PhRJ+hZFqzsjuO9OeH5MHsWZgqYHTKGPoDd35Nk4LGRKqCNikdNXC?=
 =?us-ascii?Q?JoV9d9oYMmFJ2BEGQyg/i2GQFd4WPnBOLfZ/NOMu4tuG5E9vom9UHDBGrZcq?=
 =?us-ascii?Q?2X+FoV75HDKGzZVguD83F+P3Way0ZZWCkI5PlYx3k6boGNpnJGNbGpIHid6J?=
 =?us-ascii?Q?LaYuZ7a+5J/4MVIGEMJKDrL2YU40Yw7Mhy1A8rnGFieAKpJtL10+cEl5+Gc6?=
 =?us-ascii?Q?ORrtjkmcbUFZ5R1CAIYURSliNOscT8EYQ6D3ELy5sdeMBkbpUWB7uZnLQdL1?=
 =?us-ascii?Q?fr0d1wWqnGCBvflrzjcw9nruAw5KKGvR8fytb7Z8aN22DBbHQI9yyQYmBnFm?=
 =?us-ascii?Q?VTN4AVA/GI4C4nGV3vgpO/0N9WqeWkjENfykEH+912FOOGYy3R5QBUdnNh/E?=
 =?us-ascii?Q?454aCOVWAAWFoP8CvMisV8bLqWyXYNydh2wgSOW/qQ4s7rJjNz+UKQ1hSXVo?=
 =?us-ascii?Q?EAfAfYpxgPf8aty3J/5Avd8p6SPb19oPIaCVoU/6xrzMKZHnMRIqebFxBJkk?=
 =?us-ascii?Q?Auk5pY+B5iNTE8xuhmaz+kVJxS5/Iuazz7B/a7iRzi3KnQeKaipcgiBhioqH?=
 =?us-ascii?Q?RzGksZKTbmBcSHBNGYO0wDHx6eFkaNvcv6P9Na0Ier4QcyFqc0UJD0iJ1TJi?=
 =?us-ascii?Q?Zbvw6k9rJYgtGpBxHDfn7cShVQENDxn8y3mMymVaTc51W4g0mL7CJ7TEh1C5?=
 =?us-ascii?Q?MgEeVnGay+pr6zlGD3Hd8+8h60s818FSTk1xWi+gsnbSacETr26HngLYMPFY?=
 =?us-ascii?Q?JZiAHunwol6AFDzMYOBkzUGLVK0RivWq4EQqujlDXAK6KI5jpGEIoH1oqmVw?=
 =?us-ascii?Q?jWhNCf52zvc1S1v6ZbKkYe6E7gmC0RNEo6ea/QOY+ubYPx0ntBajZdN5etAz?=
 =?us-ascii?Q?3pCnXCNxdcgtCgRvKYn2hNHGhuD43dmH2cTIGp2gaNru+tiNO81/jxN/A94Q?=
 =?us-ascii?Q?8L+cRGOY0xjn/wxxuC0YjLeilynl7ycILB7hCmA4NOoO/em5rEdtcelBO6Jk?=
 =?us-ascii?Q?IhZUOgs+3NPzs0geP6JqRk9a9mF43JGr8rUqrK8ncqjpggSujufEPsDMs1cM?=
 =?us-ascii?Q?cQAjh5VFd+tH/h9e3/RFCtKRlBos2Xxlug74GQMuqVvvZc0e8AVO7sVVULQS?=
 =?us-ascii?Q?Bj6z7tcpFxQvvlma61PkhVh9WP/eY85c7nyqI/tag+16+ISB8B6rbMNUcCZ/?=
 =?us-ascii?Q?TYG5fb6+0a0rLSwSJ+/AOxkA1lCR4GCCXHVXqrCsTgGXZKKaQNhwAnL0JEWP?=
 =?us-ascii?Q?dz9skX98xio3/z/Le0k8Rb1i+1DHJ9JdNFKaXUf5gp+LZjNgIEp3HC1VrJyz?=
 =?us-ascii?Q?7O/DOD4NBqRyUeBcpBWPS6rsQd1KiCt9KC66ns10EsEVStCdhW7SPMn+GfXq?=
 =?us-ascii?Q?uVkB0d6dLbfCBhOEhbq5KMz6GDeCSD4p0RKfgAsxYpIHYOBDHavN2HTdNudR?=
 =?us-ascii?Q?VCuCLS0Juo+My3G2lN3VMQLwsXtLAN7rY2FWyFGI9tLTEQXT/3mGh2QLt9ut?=
 =?us-ascii?Q?1WI18OvgRrvBMwDQTjp0WkERSVKC1i160stShUv4vH8lUkGYo7yeO2buW61Z?=
 =?us-ascii?Q?5WMf3xUaqSb68qRkOrqFnaP9dzSF8PGiB4hPoNqbkxidzAFqnoq1BYLzbj1o?=
 =?us-ascii?Q?qVRhtl/DqxZ8/MoORtPnV3pHsQJfH47D49BRCzEDwLSVX1nDoHAh062RD14x?=
 =?us-ascii?Q?r1Pr0fV7Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c99d85-c7be-44f3-c712-08de5254140a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:30:20.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snj1eVSXL+Y9EVmKMNBuiZ90XehxZw36HiykpjLw1i7HVO8kwe1xKKHKoDHKfdl8fwFYJs09Ga1NHnbBQ+oIvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9395

The FEC of some platforms supports RX FIFO shift-16, it means the actual
frame data starts at bit 16 of the first word read from RX FIFO aligning
the Ethernet payload on a 32-bit boundary. The MAC writes two additional
bytes in front of each frame received into the RX FIFO. Currently, the
fec_enet_rx_queue() updates the data_start, sub_len and the rx_bytes
statistics by checking whether FEC_QUIRK_HAS_RACC is set. This makes the
code less concise, so rx_shift is added to represent the number of extra
bytes padded in front of the RX frame. Furthermore, when adding separate
RX handling functions for XDP copy mode and zero copy mode in the future,
it will no longer be necessary to check FEC_QUIRK_HAS_RACC to update the
corresponding variables.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 21 ++++++++-------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index fd9a93d02f8e..ad7aba1a8536 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -643,6 +643,7 @@ struct fec_enet_private {
 	struct pm_qos_request pm_qos_req;
 
 	unsigned int tx_align;
+	unsigned int rx_shift;
 
 	/* hw interrupt coalesce */
 	unsigned int rx_pkts_itr;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0fa78ca9bc04..68410cb3ef0a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1799,22 +1799,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct	bufdesc_ex *ebdp = NULL;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
-	u32 data_start = FEC_ENET_XDP_HEADROOM;
+	u32 sub_len = 4 + fep->rx_shift;
 	int cpu = smp_processor_id();
 	struct xdp_buff xdp;
 	struct page *page;
 	__fec32 cbd_bufaddr;
-	u32 sub_len = 4;
-
-	/*If it has the FEC_QUIRK_HAS_RACC quirk property, the bit of
-	 * FEC_RACC_SHIFT16 is set by default in the probe function.
-	 */
-	if (fep->quirks & FEC_QUIRK_HAS_RACC) {
-		data_start += 2;
-		sub_len += 2;
-	}
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -1847,9 +1839,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
 		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
-		ndev->stats.rx_bytes += pkt_len;
-		if (fep->quirks & FEC_QUIRK_HAS_RACC)
-			ndev->stats.rx_bytes -= 2;
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_buf[index];
@@ -4602,6 +4592,11 @@ fec_probe(struct platform_device *pdev)
 
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
+	if (fep->quirks & FEC_QUIRK_HAS_RACC)
+		fep->rx_shift = 2;
+	else
+		fep->rx_shift = 0;
+
 	ret = register_netdev(ndev);
 	if (ret)
 		goto failed_register;
-- 
2.34.1


