Return-Path: <bpf+bounces-78644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D93D167D6
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D7963026BD7
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9D3241CB2;
	Tue, 13 Jan 2026 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YD4fLFiQ"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386DE1B3925;
	Tue, 13 Jan 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275010; cv=fail; b=MsNnog+aDOawdpt6yEp8rYytHLfk1REQ3M8rfV7C3h9WvdAPrG/4Qkgnj1GGeSPmEWIXNigkm3ypuCi3nEaOnGQmmT0id0Z2K/M+LKzWElZbGL4r+oIq/r7EMlvlqYbfttl6GVN/VGfB/RNlcn76Jqp/u9OdvBpXJyD2cqEKSQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275010; c=relaxed/simple;
	bh=UJfhFp1CjyG9yJ9LQRCPCHlxi9iTQnOxQPMKi3yTghA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gNvPVM/hZXDMfrHOMeUS1G0Cqz42eOmGj7dwqyHvxV+YeQsGWkjI9IQ3wdL7ELMY0EaPpcLhYUTwCch9hL23ssxsUrgHbwY58Yq94H50pUioJi5UkE7YXuaiG2XwG221UdfXodJALQRLFDlQgFiCDKTrYPL9SNuY9qOIpfqWHvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YD4fLFiQ; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2Pern69SmY0CXvWtL69KgcQpkui+DG4DqkuhOILaHM7cOuObPI24CVeGL5pnKdqs7HF0KQSgHQektOyOO08Xx0m1ZCEhcjqD74U5XjsCGh+yaHMNXOuU+NEYWowyXVJ+lDOuRHtttyXNk4CW/4CNGK6KGAZ1QMS+hqVfgJxU8Fmph1502D/epjSvmOVRBvIAAp8ahJN8CNdotM2NExISdt5M61Xa9aizlbXcni3shTuynk+bRrt7i1fRSAE4obdpY/nK1oQOEJ5xYmgFZmGQ6MjOoK/iQc/VXQJLOuK7zaah6QSJBmu8WYRD5bpoqRpsLsBu0ghWyuf7Dy2UE3y/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPL+cQvxO7CsRWRLTf1ai1wu/yVqS4cBeSkRLprWhQ8=;
 b=rF5b+Jgu/nUrunMcusC397zCitC8jCGIt3vIq3pyL9p8VpZk4fh0Jm3yYLsKSuH9/0jDZFFYaLywT+PeBj/30XOhYm6XFRZVZsqB5I9Qa0tPj/FI46Mj3lRipucq2+N8SO/CYh4EHCIS+GYHtRqTTjIaudcyo4h/nxndG2UBfjbbEZa9tN/PGH5EvToLqCgZCDQ/6EFOVF+rJT9X5V9ghDRsrKntUPK9vOgj0kict403UyykmOOw44/GfXCw/Rq4KMdjUfE7rJfIN+V4ni7aDmIBHn/nedNpKSPhaJGChcTSwlF3i6UTyYz4q//7+tN9kfHHSDnPHmq8w9pMp3jZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPL+cQvxO7CsRWRLTf1ai1wu/yVqS4cBeSkRLprWhQ8=;
 b=YD4fLFiQUoUXLylDqAISBCG5cXz9E7IA1EGpd9lLrZzg+eoox4CMIXWvfRgfMdNBDNj3Q2HxPqzXPpMg8SSO+/MHYM6PXWuS2xwgTZWwnZtV57+7ZD+MIFmlBC4t8b/WuLDOZqNmZ11LMy3gA1pwfugHyAbxo+Wy/dtXYfIIzeHwa169FDB4za4a9Oyle8Tm+fb5afqzXFnj+d7Rwd3fMkjUk6KQmjVT7svRpsGOAjK0l8nvgc3jiK8P2xKZDGgiPzOYa2fyc8/qdE1uBGQYG7X1HPrMIO+irr4Aiw8KJm/6qwM/HVfTlTjU880aMaVh0AmsWuOp+/I4Gb8JYCT1/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB9395.eurprd04.prod.outlook.com (2603:10a6:10:35a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Tue, 13 Jan
 2026 03:30:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 13 Jan 2026
 03:30:05 +0000
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
Subject: [PATCH net-next 00/11] net: fec: improve XDP copy mode and add AF_XDP zero-copy support
Date: Tue, 13 Jan 2026 11:29:28 +0800
Message-Id: <20260113032939.3705137-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: dfed92c0-4143-4f2c-98d0-08de52540b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|19092799006|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3dkH3pDSMMiVnPu/k/+OUSoC2JGfAmZHrQ0vyYfkc63W3a87WrpS12zW+Lov?=
 =?us-ascii?Q?mzUeOKLnHfyBjHXI5z7uS9gDTdpD1iO9tsxxiiPEGEH1rie3Lomrw2Cz2uu+?=
 =?us-ascii?Q?gCVkMWbXaoyAOX6xi8eLAsU0+spI3wnNthLTgkJQhmSVmyQA5vkwABGnJt3K?=
 =?us-ascii?Q?V/K6Tt+I88nIp7BV4U83hxpw2WScNwGEZQfwiDft4T/o8xoAjElaJxxwRH2r?=
 =?us-ascii?Q?oUFQoyA9IjhiXwkye5cyYVnxVbZF5Q8loaBilelvXpx5SMi19jvQv/4ALkez?=
 =?us-ascii?Q?yZQkb2I2x6rrdgFzt2yku4QzUZSLBnjOZKuDIfeCiANkHA9UbmQhkk1478Mr?=
 =?us-ascii?Q?diySqmPOt/e8mSZb+1aLPOGYnZscaxxcEXjThikQ/TRPf0yk1hj9xuW3oi8+?=
 =?us-ascii?Q?Aqw8wuKJHbuJQs08wjyEQZnmwKMsFCu17VBtAwZSN6i2OSbouwNPyn4InPFd?=
 =?us-ascii?Q?yFQBVFYnCHFoIuAPyefe0Wk1SQv6atzxPTUSTiUIsQc04lNPY+aDJGLq9eRW?=
 =?us-ascii?Q?uAFgSqMw0s1AiXoD7lZQtMAMmAfDimB6Kq6yF1qLy6k94gu2WkRjwYfumGwx?=
 =?us-ascii?Q?va2MoymbkFcsz6zZwwykYnsjU/e5EDxm83qx/etm89y7rfR06JgNcpnV5/Of?=
 =?us-ascii?Q?aeV/XytMfRB6sGYE8RTlzH8w/1ovj1GCHuSct2bqkPIV4zlCx+xafO63J8ST?=
 =?us-ascii?Q?AATtJBUu+tAcxw0jyru176T94iVRrSMNrxzRadnxXekjESmy+zIkVdbJYd45?=
 =?us-ascii?Q?d1b/rCT7KM5M0XtxxYAkwaxx06JFPPt6sC7HtH2nI233CdG2XaJMaHxHB519?=
 =?us-ascii?Q?EOL9DQaH96zejiD8KZ8yiXICual8YAWbcpT0NVnwR3l6TshfWCzcO//2zrDf?=
 =?us-ascii?Q?5dKbWXLRpcgi/E6y/N0veG1XQkf0fCIMgh0PXTiO7QpVd/hLfjQWa19J8dII?=
 =?us-ascii?Q?hw+QledqV6OcKsCaCRV6GTnpCZonjmWzJp9BXgadwsUoYmRjxqpMuuTmHPrQ?=
 =?us-ascii?Q?32up9Mx4xPfiAkDX/5ROsVS3IBU+dQdK35nsxflIUuUWNavnfX6a8rvH11bW?=
 =?us-ascii?Q?OnRHeMudgw9FSpNphfFN4e+4WISx6efGfSKL5kHf/0uWR7n2a3exmXIBWKDd?=
 =?us-ascii?Q?FjgtOWkdE+uBiFzRZHbcRQKdP/yQmyU13up6g0fKL29zgMZW13fmB3Iz4oCW?=
 =?us-ascii?Q?Upo6h+WWBpEAruM6VmWl74lat+U+poNMdZIwZlraZ0puKF45l0fuSAUZh3ul?=
 =?us-ascii?Q?DhOXR9JhjJus13Z8l0QvmPE9W7yRBpfvtjL0m54JXxjg4yHubKoGHnpHUjnz?=
 =?us-ascii?Q?aoLomf8CVtAAmAT8+bBrLkr/6aDqZsEjGIzR/Wl0mYcqw8+BM+WdNT/+CDlf?=
 =?us-ascii?Q?DMoMY5lVoEsBvkxaDVA+Ooc3oj1JetonjjKVVA//ghxD8soqu/cowOXQReMb?=
 =?us-ascii?Q?VMbwQmeAliNv6nbAYp05bv2AqiPCCqy3TgbZNcCnE+fgpy66w4c6fVZT7Hln?=
 =?us-ascii?Q?AL1UXqCfy1A0Tp7djSiUkiDz3JAplLsk+IduYXA7M1PBJwg9gqwsRC3MEg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(19092799006)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/L+TqRpGWpJtLln2dpl6UN1gu/xX9HoirX0sSjaibxln7NSXQZaltVNK5cx9?=
 =?us-ascii?Q?BoPCqiL/wHtOcIaEhyhXh8bNP8Hg08w+BxogjJ1lUeXu0ha9UJhSoIOOhTiz?=
 =?us-ascii?Q?tj2KjhosB97YbMhr+hBaBKOOdQYLsJeJ1hmbqMjZ55qSQCgm1NvV+hiYMy9y?=
 =?us-ascii?Q?FBfkAtJO0VtX7+rngGz+4t90QxlTqnDcns0ZRptPGnk7XLf4gxQEH57wSdZv?=
 =?us-ascii?Q?Rmp8lsF4BbTB6gf2Cfz7F4IOnDJ5ZR3gec4yR5bXPx8lG9c7fgYyb8oJUFNu?=
 =?us-ascii?Q?5K382X+uRg+UgLzQAEAonmvF7Podsukjuiz6Iau7K1BFfiUVmd/oHqAx2pmI?=
 =?us-ascii?Q?b2exLsY/HUEt2F5m9fOsYkr6aAJfImb1FpaGTjIFoyJGNV/GUhy6JLFNACuB?=
 =?us-ascii?Q?038KirK/1Efj8PreYdHR2Ic13oqtaf8bTVaU/qpGJGZkO/0XUBc17rx3C3LL?=
 =?us-ascii?Q?6TpRDd6kXTVufd2DbmROhMyCHsFLaRXjWU4tH239WnsV7sgMq1y/mbupIuMc?=
 =?us-ascii?Q?tn2XFHBkVt80hFVb51LFm8rBq1KM3XbfV2c7lOzYeaH51ExDK+N0vEAXiaJ+?=
 =?us-ascii?Q?49+XRbbeE4xrfNGDUVJKlzmf45qOuqwRljHTHGF0NqGNis4yCvwM7tXyf41C?=
 =?us-ascii?Q?8WRUmZ42XFGvkkPlRseVpWn+9YU73gS10eiafO2Ko2min6UFJgPEB3pWYLrc?=
 =?us-ascii?Q?eVOF8yS3g479cv94OPzxOEMTFprNiTyO6itP/BPubYUtVI9MaWBpOH8WLYBi?=
 =?us-ascii?Q?tWFvrcSHF44kPw6zUnDty746tzURvFcDuIzKzgueIiyeOUEJGrH5hFqU09QJ?=
 =?us-ascii?Q?BuuXMWKg9oVm4R/shcvedx9ELmxjH1lL76Fg7f+dRuEYd4FWT83L+5zd0zS9?=
 =?us-ascii?Q?DuqtQNC1l7UUqC7QVJ8LhMrcn2In1VVTNS5HmprFVLwnXrfvnPx+UbUsObQz?=
 =?us-ascii?Q?TkfAtBrCz3UegyNZ9ERq6NuR4D+UZgw3RzQx4sYwNRG0bmuN3oLAPi2YuRcx?=
 =?us-ascii?Q?78TVufgFNbkKrzkVfwU748EdbDZUc0FeOE9NlQX7vPQghaM6dvBb4bB9Ztio?=
 =?us-ascii?Q?sPfqPeiKwK+7GHfZiNYfERI5RbmjjqFaOC8xns1usqa2ykvh3KY90hf/mXWA?=
 =?us-ascii?Q?234b4yM81Ey2YL2AmZZ6JUe+vRuLFG/mEHXRFfM9XZUwt0jdMJAZtTTIj2HA?=
 =?us-ascii?Q?eBd32euzDsmrqHPZIzjgSkNqecD17HE5u0p8WcU3m0EIdtjRZC87XfCNMcjv?=
 =?us-ascii?Q?CVOa1S169EcyUVBUtanUQgDMZNSMKIaPcEIvjlAMSG2tkWTmp2ptF1sN19Yf?=
 =?us-ascii?Q?afzixoKgTYuTTCX4Z2Y/cjJUUpi5nKXdSjvATbeXgawcGBYpulJxEbPeKh9Q?=
 =?us-ascii?Q?DPRdVkE2L48mWDYWaAjk9iwFdOWviCCV6vT5z2VmFjiLSYKqVm8gt6DHh7Ak?=
 =?us-ascii?Q?yeDuwgT6ywTbD22sC/r65ZIZzsjjlPt+pRwCl2f0+Kuz2ekB4LN8BjdyVzU/?=
 =?us-ascii?Q?QD4ZtgB5YxCHf7uYKZH4VcWknMv/uu5UtQo/3YQVilL5YEXybKl+qrMc3C02?=
 =?us-ascii?Q?hOgVdyvgtu2GHave7AhbppNzbIupLlgLMqH2ljYkzwWmCOftcRbsDVtQuo+v?=
 =?us-ascii?Q?cL3rNZd4J/7Wae4WlQBHEUjTTyWBG7NZw5rt8khs0k+WuKVdV7M9IggvqYen?=
 =?us-ascii?Q?lgGInD5s4H4FZapuQVQePzSqnkIhnFXFje0aMaCtevArs0jxHLUNvnzW5WJU?=
 =?us-ascii?Q?19OwMgcnmA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfed92c0-4143-4f2c-98d0-08de52540b46
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:30:05.5311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgErEb8dY6sfCEy8fk+dPVSNPyAXtN9GjG/FkPNOQwSSpVeQ/bS+ByfxXJCE8Es2N6v/eL3eeYF4LtFosDTfow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9395

This patch set optimizes the XDP copy mode logic as follows.

1. Separate the processing of RX XDP frames from fec_enet_rx_queue(),
and adds a separate function fec_enet_rx_queue_xdp() for handling XDP
frames.

2. For TX XDP packets, using the batch sending method to avoid frequent
MMIO writes.

3. Use the switch statement to check the tx_buf type instead of the
if...else... statement, making the cleanup logic of TX BD ring cleared
and more efficient.

We compared the performance of XDP copy mode before and after applying
this patch set, and the results show that the performance has improved.

Before applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s
Summary                   402,105 rx/s                  0 err,drop/s
Summary                   402,501 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s
Summary                   667,000 rx/s                  0 err/s
Summary                   667,960 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s
Summary                   208,502 rx/s                  0 err,drop/s
Summary                   208,797 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s
eth0->eth0                311,340 rx/s                  0 err,drop/s      311,339 xmit/s
eth0->eth0                312,030 rx/s                  0 err,drop/s      312,031 xmit/s

After applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   425,778 rx/s                  0 err,drop/s
Summary                   426,042 rx/s                  0 err,drop/s
Summary                   427,266 rx/s                  0 err,drop/s
Summary                   428,805 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   698,351 rx/s                  0 err/s
Summary                   701,882 rx/s                  0 err/s
Summary                   694,596 rx/s                  0 err/s
Summary                   699,832 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   210,348 rx/s                  0 err,drop/s
Summary                   210,016 rx/s                  0 err,drop/s
Summary                   209,854 rx/s                  0 err,drop/s
Summary                   209,973 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                354,407 rx/s                  0 err,drop/s      354,401 xmit/s
eth0->eth0                350,381 rx/s                  0 err,drop/s      350,389 xmit/s
eth0->eth0                350,966 rx/s                  0 err,drop/s      350,959 xmit/s
eth0->eth0                348,488 rx/s                  0 err,drop/s      348,488 xmit/s

This patch set also addes the AF_XDP zero-copy support, and we tested
the performance on i.MX93 platform with xdpsock tool. The following is
the performance comparison of copy mode and zero-copy mode. It can be
seen that the performance of zero-copy mode is better than that of copy
mode.

1. MAC swap L2 forwarding
1.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -z
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 414715         415455
tx                 414715         415455

1.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -c
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 356396         356609
tx                 356396         356609

2. TX only
2.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -z
 sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 1119573        1126720

2.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -c
sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 406864         407616

Wei Fang (11):
  net: fec: add fec_txq_trigger_xmit() helper
  net: fec: add fec_rx_error_check() to check RX errors
  net: fec: add rx_shift to indicate the extra bytes padded in front of
    RX frame
  net: fec: add fec_build_skb() to build a skb
  net: fec: add fec_enet_rx_queue_xdp() for XDP path
  net: fec: transmit XDP frames in bulk
  net: fec: use switch statement to check the type of tx_buf
  net: fec: remove the size parameter from fec_enet_create_page_pool()
  net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
  net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page
    pool
  net: fec: add AF_XDP zero-copy support

 drivers/net/ethernet/freescale/fec.h      |   14 +-
 drivers/net/ethernet/freescale/fec_main.c | 1436 +++++++++++++++------
 2 files changed, 1068 insertions(+), 382 deletions(-)

-- 
2.34.1


