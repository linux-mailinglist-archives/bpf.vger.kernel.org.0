Return-Path: <bpf+bounces-41373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08F9964E5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F45B21E5B
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E8B18FC72;
	Wed,  9 Oct 2024 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M4bDe+vO"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E5F9C0;
	Wed,  9 Oct 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465511; cv=fail; b=CuWScyjOpm/fURNRNv0lQ9Jb8X4y+TlyfTLNvEWedney5NtkBz2Vat3ML2Tzbx85Isb2iRc8V04O3KDqN0c7JsA4YbmUgLu6Z6OYgIA4KOIiZVFci/QVRJyW0odguCnsyV/M2QX18Ap785cCT92Jqej8olMnu1h50ho1mBWr9Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465511; c=relaxed/simple;
	bh=f3KMfoSLaFhD4UyCQcKwW1J49zjJkyBjI8Ut7puYXN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PJDBVlp/I73ESHEn+zS1kMGD1bwiMUtlGvuxkce1sXTO1A1W8JPt5Rgh6Zloo1lbaJ8FgjSCnu1EPg5kewGVNIQVNSbA7dUUgnCX9617lnvgs5UDWG3qnFx8fWRfVkr0st9eZW/lUcfzuiB3VrwaaD2a5nJeWV5yhN7IwEgZPWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M4bDe+vO; arc=fail smtp.client-ip=40.107.104.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7OL0YrxX6YKBSzNZwUZhO7moFJBCXnuOrnw2sLQMZlTjb6vcGcaVfZfj95Tb5PtwTzYlmEyiXO4i83tr8fIXWe5hudBHb63K47jI8UsumsIyH0jlb6945LnzekJctOfKyHWjP/Pj0QaIOQ0n7YHSg9cah2B5GWZAlgriWU0GerGdkJUSAq8JshsaqA3tncsR3cv9hZmpWJUX1vb7IiAcC73uepbvJdnSzdk8243mhffnLjyfHfS9xxS+W8OQiBaZsKW0IAcmJ3QiK7KtV40qhfxtAKp9LszJcxeP9PFfAEutlHuTXuAT+2JLnmdyXk7prvahyK/wiUeVdG1PCu1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX3E5Q42efCWu3VFFPuVSQQalVFHiWE5+TajCjjRfIY=;
 b=lIdNZvWDyXYhDsUaxIj8KyNjvDUqLZ+6uHUoVWuFqgHXjH0sW77p35re7oOAPUZoY4J2Vbqg7hpGj9khiSsdfW+q8pmCI0cJzMowulY5XisNu4VlLelsKyrhFW6/2y+csJ+SSGpdQ4Gzlf0kBMxN7+RSEjJ50Ftrs7ro0Gn2GUE1ezPU04r7f9BMv2+dpdQm1CThO8BpNfvLNYjbfc538w9H/1ZmZV2absUzyZpmMTwL0+FDtzTUDnLkIsvVCaseiB28CO/rj4lYN8fwYIYsmkwN4++PSK6hvhlEDyfH98NHZNIyrtq4a5BfhmgCDJi7nFfzoguUSjp9kf8zlVTnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX3E5Q42efCWu3VFFPuVSQQalVFHiWE5+TajCjjRfIY=;
 b=M4bDe+vOn2woGMyid6iRo02OZ4e4iP1n5FNYQzRGi++L9kIubiEPpbJSpCOGBcRVJOJA+lOuM4v3pluH58h//o4L0556Sb7EY+jhy1oUjrzZkUn3h7UsP0K139+toseuFJk3k8ZCBPW7mAM5tifMz26ksBVvGQe3rJUwR2+nfNingxPNpJXcLGQapdstTuMhLASS+xnxXl3dJeJu8ZomYOhONsbMczvHHHARqdvB1Siq5seYB2lpli+qacM2c/evU54oISpqdKLOoefc1Jo472rzhJn6DqB/VWZ35zWqVjXiTdoZRHIH/SUOEjxHSSumeZWxh7RXbwxeuVUAulUkrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9318.eurprd04.prod.outlook.com (2603:10a6:102:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 09:18:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 09:18:25 +0000
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
Subject: [PATCH v3 net 2/3] net: enetc: fix the issues of XDP_REDIRECT feature
Date: Wed,  9 Oct 2024 17:03:26 +0800
Message-Id: <20241009090327.146461-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11c8b8bb-47eb-4973-c211-08dce843543e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fRiiZGx71IWJfEiIUrKt7bQIliJt6A62CJRGjyri2WRHzgUGdD4XkrgMmcEn?=
 =?us-ascii?Q?C6KiM2HA4+SSdosC9xtSpmtClAuUw0Nz41bouDEQzTxa1wxcLK5af9pRk7rD?=
 =?us-ascii?Q?gZiPEOnYxKRSmMp5CwHhEonaicffiWfh6FedyywTCzFO5fE+0xolqCfpQ1md?=
 =?us-ascii?Q?hXFGWiNpvUtmTOoBP6cpN+MXoOadBn2ZoCzarERMf5PCeHJka+5b2LmapD4w?=
 =?us-ascii?Q?uEuMOqK4MOFin2rwx13ReThg6D0+8FzfmMPtN73sLATqzo95Wwh9NAx18CSQ?=
 =?us-ascii?Q?5DcS/egPUZrJLlSFydhLLJeCtDkNMKXoAUCFgUqWAwbPmaSRze66FretmaUB?=
 =?us-ascii?Q?PC3PDoQk1+JgN6Cp3cVpiVv8cy0FUuYLCTIdrKILUy/lI+1tS7JgtA9Go2ax?=
 =?us-ascii?Q?j604EItMeEWvoJD1SGmiDKuYvK0NUjuKv5N/g6pTyCi++/cnhR/GlMriMqUT?=
 =?us-ascii?Q?Zq/5IdYi8ZM52Sp5BvxtTLoU7h3pR9i3RxwZu30LTPSMDojqpUGmsJjCZZOo?=
 =?us-ascii?Q?VYeZLBh9gjmKr0VBSlhNgI9vd56Wnwc92G6qW+MqDf+vfG2BqkhpfyrY+ndp?=
 =?us-ascii?Q?Bc2xs3WI4g6uDUCJ+t8us4MWtLAGzj60PvoGioxRSEJpoHFaDS4rRu5r5miQ?=
 =?us-ascii?Q?dF85SLBWXOh+dSsy7S5iBJftqh9Nc0rNTZZG45ib+4FLHtRiJSOiqLAEKZmr?=
 =?us-ascii?Q?hAL1tu2Q3f6rY0I4LTks9gF6zYdfrqVcUIlsZ0QBLFF9H4EzJSxbap6R6Wfi?=
 =?us-ascii?Q?fHnmb8mBXtN1K4XIadJxeIsIZRgaAy2kX4IVxJTh9Dxqr1pjUjtDLS93Oryj?=
 =?us-ascii?Q?3YX6CCq2yfy7F5g+BS0mfaL/OlMxAbzT8jPpgiD/F+MI72s7Qb4TOAqZPJA1?=
 =?us-ascii?Q?/4G9LW782yis3VJiAVb9xNsNumWaSeyr2uGneCSfxGYjGW+tm1lhfwQZukkY?=
 =?us-ascii?Q?hNBFKqh7zF9tim8VFh14psV+At/4iW2h1KQxMWyQwCfkEKPI4PSN4hZZqZNZ?=
 =?us-ascii?Q?xnvExYBUjVIh1zzCgu5DjIyJJoMOrJmbMm1LvAWaIBMaa/zO3eCmHbQab7aE?=
 =?us-ascii?Q?YkaLI+55KfgEHo+sRFa9NXjExx3fnKh5xwlr2WmnFWIakRBRwcPIZVXac5nS?=
 =?us-ascii?Q?yxjXiShLSbPggwbJZuSKkHOHZ/K3aK4HGX8AqBmDHRkv70XCIK1vR4CbUqsK?=
 =?us-ascii?Q?BR4ZQWXA8SR7rFPEUVf3s77TBB9vPlaUX1NJF2gG2roBSehEKRJciQv4LXy9?=
 =?us-ascii?Q?OKsg8/TXcAB8OSS6ukq16At423o41iyfaPM/Mjef039rZZ6mToWPL0eI+zT4?=
 =?us-ascii?Q?ThiphC/+QShoL9VsXZDoCa2vGLDvCf+O/5TsVvo1pF9fjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jmKqxIOakAN1XiQOaLw6ye+I9Nl3GSsLxxr4sYBl+Ut3w1L7VUacWbKRd3Lc?=
 =?us-ascii?Q?AXVZgBRHoR6x7r9aP7X6OxI7BdeP4/8Zs7pux/9fR3i9HfwnLA0PC/Je3o/x?=
 =?us-ascii?Q?YgB3njvJHs/qe7QHih6PntT37KjfNYiiReItkQXe+8PK14H7Ebxz7q0T/7Nn?=
 =?us-ascii?Q?GnGdprXi3qhNdHmUZ4Lw3rIAZPMlwSPo5aSTJknmkT40ky/OxZoN5Xi89DNd?=
 =?us-ascii?Q?bGrijxqNluY64nDVUIEYuGRdEs6O+5hFQs2N3wqOO57M9lsF0/eq/O186rZG?=
 =?us-ascii?Q?pBQwEQtyCVG9NJs8ELU7/3QeNf1lXcEaLQOFivCm6e1xU/00AOVNxmXzqW+2?=
 =?us-ascii?Q?jyX+TMAXfjpQZTQOhsYlrXpVOUW2E7Dpae8y2OKo36yRPPqim8vDxzUs666T?=
 =?us-ascii?Q?qb3TT4lsdap0EDV8ozzdctgQdUh3WC2hXZTxDnzXPxIGw2zJ3OQgiw6mn91K?=
 =?us-ascii?Q?K6wvo7zIxM0Kzk352IeEyNOnTRzX5X41Xvb5vdVKz/g0u/4zKnDpQ+WiMHxq?=
 =?us-ascii?Q?cHiH6LYSq03oQ+HPm7+bOJpJEbLH56DYwXIxeYzZh7RMej/9ldQc4lf0cc59?=
 =?us-ascii?Q?t+cyk++zEVDUKw5OwuZ08YvXredgO6pEyj9AHMcFD6RMQZ6AWdGWdNJXYQT1?=
 =?us-ascii?Q?7BV4DNvpocJtteC3XUtJzpJZ5zSDhzEKNMiSZ87aH88gAg87OS4FiA4yABkA?=
 =?us-ascii?Q?JrXlC46jOtNJets67XW0AW5JlqoI2MkAfSIZEIy+mexoqMyRKeU+whzkS7hQ?=
 =?us-ascii?Q?FyNo+zYUEvOY7AQWROjBkP04y4rDikGi+7V9bTDYghbI4km8edJTsO1vy6UB?=
 =?us-ascii?Q?FIdxBLl4z0LzeiSryXF2mKghXMLxiJSMf39xM41khKrI3YU59sZI+W1n/28S?=
 =?us-ascii?Q?9k1+YIiupJ3ZqRSUyjA0s+V5mDaZz+T2ZX8FbIzucVJP0XUXLMu89PBF72xr?=
 =?us-ascii?Q?KQ0yj8MplKTtjvjyn1SsGw2yDHP4bp5v4fxNTHzDI95wzYYOTLg9Aqvy+sTJ?=
 =?us-ascii?Q?vBHZIoIXWa6yZRCWn+jf9KI4fKPpYgTxRENCSLJV5XxsJyqZo30HGdzncIUa?=
 =?us-ascii?Q?Vxt2HpQKeGJwTtpR5Vm5QMSE/DN7pe5FC02J2hyY+E5qlVj6M3ti/QkXm1cT?=
 =?us-ascii?Q?Ff8QJI9YHRBD0K+lwUZG3U1vmcRTUcJrT4AHBkD/96uEHhAddNGEwbVQvzd5?=
 =?us-ascii?Q?S8Zo60ZANWrQTiWcNlfTt4ZnxoiRwqaWGfvF8K2whEolZUaXV6JE2hSsIIwi?=
 =?us-ascii?Q?nWl/MU8P+W0asU95hzUcJtq6lOI3n5MeYFy0nbrmO7J3ue0QzuiWgSxMIwGa?=
 =?us-ascii?Q?UXpp2yf/CKDQIq/8Z1datVgqT7Tmy4m1mal9r5+7UUxAwsOP+71sFqLWDR7C?=
 =?us-ascii?Q?uug9Zv12l6PfwVMMQ0Xx1OdWayMHd0X/AmE37S4NCLWBhuzPZLJM2h6rim/L?=
 =?us-ascii?Q?7b59vkcjvpNf1HifyodXmaNMfmOK4laQ4HEkB6EpMruPMycUJoYo+BuWqZ2f?=
 =?us-ascii?Q?9EDtdAg9fezOaJOCvmmMXHiTZH8ASblRcENBd9Y0PUBURK0ODJ9suRvSmzhy?=
 =?us-ascii?Q?7hHugabjKOPQAaTstsXx1pgzCTlTKi8O5orF+Je8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c8b8bb-47eb-4973-c211-08dce843543e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 09:18:25.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SA1RDrEk3tcFFnI9r1usGFJffXqZ6MyczCZzMJwX8Sv4DxNVguJ8wwWPF1Jcn5fqIzP3OkU0BD/22aPcgXqkTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9318

When testing the XDP_REDIRECT function on the LS1028A platform, we
found a very reproducible issue that the Tx frames can no longer be
sent out even if XDP_REDIRECT is turned off. Specifically, if there
is a lot of traffic on Rx direction, when XDP_REDIRECT is turned on,
the console may display some warnings like "timeout for tx ring #6
clear", and all redirected frames will be dropped, the detaild log
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

By analyzing the XDP_REDIRECT implementation of enetc driver, we
found two problems. First, enetc driver will reconfigure Tx and
Rx BD rings when a bpf program is installed or uninstalled, but
there is no mechanisms to block the redirected frames when enetc
driver reconfigures BD rings. So introduce ENETC_TX_DOWN flag to
prevent the redirected frames to be attached to Tx BD rings. This
is not only used to block XDP_REDIRECT frames, but also to block
XDP_TX frames.

Second, Tx BD rings are disabled first in enetc_stop() and then
wait for empty. This operation is not safe while the Tx BD ring
is actively transmitting frames, and will cause the ring to not
be empty and hardware exception. As described in the block guide
of LS1028A NETC, software should only disable an active ring after
all pending ring entries have been consumed (i.e. when PI = CI).
Disabling a transmit ring that is actively processing BDs risks
a HW-SW race hazard whereby a hardware resource becomes assigned
to work on one or more ring entries only to have those entries be
removed due to the ring becoming disabled. So the correct behavior
is that the software stops putting frames on the Tx BD rings (this
is what ENETC_TX_DOWN does), then waits for the Tx BD rings to be
empty, and finally disables the Tx BD rings.

Fixes: c33bfaf91c4c ("net: enetc: set up XDP program under enetc_reconfigure()")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
Remove a blank line from the end of enetc_disable_tx_bdrs().
v3 changes:
Block the XDP_TX frames when ENETC_TX_DOWN flag is set.
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 50 ++++++++++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h |  1 +
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 56e59721ec7d..52da10f62430 100644
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
@@ -2223,18 +2233,24 @@ static void enetc_enable_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
 	enetc_rxbdr_wr(hw, idx, ENETC_RBMR, rbmr);
 }
 
-static void enetc_enable_bdrs(struct enetc_ndev_priv *priv)
+static void enetc_enable_rx_bdrs(struct enetc_ndev_priv *priv)
 {
 	struct enetc_hw *hw = &priv->si->hw;
 	int i;
 
-	for (i = 0; i < priv->num_tx_rings; i++)
-		enetc_enable_txbdr(hw, priv->tx_ring[i]);
-
 	for (i = 0; i < priv->num_rx_rings; i++)
 		enetc_enable_rxbdr(hw, priv->rx_ring[i]);
 }
 
+static void enetc_enable_tx_bdrs(struct enetc_ndev_priv *priv)
+{
+	struct enetc_hw *hw = &priv->si->hw;
+	int i;
+
+	for (i = 0; i < priv->num_tx_rings; i++)
+		enetc_enable_txbdr(hw, priv->tx_ring[i]);
+}
+
 static void enetc_disable_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
 {
 	int idx = rx_ring->index;
@@ -2251,18 +2267,24 @@ static void enetc_disable_txbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
 	enetc_txbdr_wr(hw, idx, ENETC_TBMR, 0);
 }
 
-static void enetc_disable_bdrs(struct enetc_ndev_priv *priv)
+static void enetc_disable_rx_bdrs(struct enetc_ndev_priv *priv)
 {
 	struct enetc_hw *hw = &priv->si->hw;
 	int i;
 
-	for (i = 0; i < priv->num_tx_rings; i++)
-		enetc_disable_txbdr(hw, priv->tx_ring[i]);
-
 	for (i = 0; i < priv->num_rx_rings; i++)
 		enetc_disable_rxbdr(hw, priv->rx_ring[i]);
 }
 
+static void enetc_disable_tx_bdrs(struct enetc_ndev_priv *priv)
+{
+	struct enetc_hw *hw = &priv->si->hw;
+	int i;
+
+	for (i = 0; i < priv->num_tx_rings; i++)
+		enetc_disable_txbdr(hw, priv->tx_ring[i]);
+}
+
 static void enetc_wait_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 {
 	int delay = 8, timeout = 100;
@@ -2452,6 +2474,8 @@ void enetc_start(struct net_device *ndev)
 
 	enetc_setup_interrupts(priv);
 
+	enetc_enable_tx_bdrs(priv);
+
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		int irq = pci_irq_vector(priv->si->pdev,
 					 ENETC_BDR_INT_BASE_IDX + i);
@@ -2460,9 +2484,11 @@ void enetc_start(struct net_device *ndev)
 		enable_irq(irq);
 	}
 
-	enetc_enable_bdrs(priv);
+	enetc_enable_rx_bdrs(priv);
 
 	netif_tx_start_all_queues(ndev);
+
+	clear_bit(ENETC_TX_DOWN, &priv->flags);
 }
 EXPORT_SYMBOL_GPL(enetc_start);
 
@@ -2520,9 +2546,11 @@ void enetc_stop(struct net_device *ndev)
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int i;
 
+	set_bit(ENETC_TX_DOWN, &priv->flags);
+
 	netif_tx_stop_all_queues(ndev);
 
-	enetc_disable_bdrs(priv);
+	enetc_disable_rx_bdrs(priv);
 
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		int irq = pci_irq_vector(priv->si->pdev,
@@ -2535,6 +2563,8 @@ void enetc_stop(struct net_device *ndev)
 
 	enetc_wait_bdrs(priv);
 
+	enetc_disable_tx_bdrs(priv);
+
 	enetc_clear_interrupts(priv);
 }
 EXPORT_SYMBOL_GPL(enetc_stop);
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


