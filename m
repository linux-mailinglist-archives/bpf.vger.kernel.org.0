Return-Path: <bpf+bounces-30954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA4D8D518C
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A421F23000
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 17:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC3495E5;
	Thu, 30 May 2024 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BP9f4pNS"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D9224D4;
	Thu, 30 May 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091818; cv=fail; b=DC0xpkieSlzYM4i0HBXowb8kp6Ckw/B1ZPZBoMyEfoe42dpds2DVhWe31bkt7tdOFe9ggMTWrODnbIF2/WcSYpNUThOgQoV83NFhP5KFpMgTvwTPVBhwejwqr98xpEFpA6WK5aP8VnSbxGl37g56fvdMs8DZJ0b7A0NydSfRjlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091818; c=relaxed/simple;
	bh=JNCFW3WxXlR4KU0Wkv1zxa95No14uBcLeptDSMb850o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dKmkurHSNAUDL3N/q+Tt1agA+cOcvFEe8y4GysmcmDeLEzmUAwn5eRERVEID4sLckVqRSvjmAzCYgGjeEx2uV6Cup6jQOlCIAR0QaBLqese8WCFUxkU7+pDnGR3VgzlJgYuL2/jmjBwuJ5iNbhEWP9jjAu2xgj5gK/uhYVt/A+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BP9f4pNS; arc=fail smtp.client-ip=40.107.20.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcuaR5v3lU0tzN44bX54Q4691GByAS40c0fYzQOCdPrfB2kED+qOksnPiBVWEowJnGmeX2I41XKj7qRN59cHEfVgi+Jj/ho2qfbm9WtDYui46pP2mqgy7NP3lLQudVsff2EpRab3tbRad7uOzxpWMdzM8br095nIEQkdri2Y7ryt+VDk51cJzYjWeLAb3L5PwMq3zfWlcoAj6Y2rnLHfNfTUE4AJRKAGs5txJux/llLWPB3sEtDPlG2dc3Kqfrn9ZBcn6SV52EjwkVGg2Xkja09XzE8yv0Bi5W0f7sxRhTSRAV9KD1mI6seL8jZk1VwJZcEa7pNSApn8fuflzSHXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DseiNip4D5B54oWWL6RtLNzuzXBCeMV1/J+T4hHt2E=;
 b=n9/E8N6psxg9Guj61B+XoDAEN/GX2Vy5TSHWefe7VkkxDka9rG2dlQyhRe1WNyDqZPnlZecJlE4YR/hwXTf7p0ueEQ3YZUe9EGkIgyB4PTDUANk7Mr0RWY84/vtJzQ/zOkFrlOVRZhxi60QzBH0ZPyhhGmrciZ7a7M+mvOSVw0/biK9e+nlAKTqYcWPfHXbNdSvktFap9O8+3vIrystkCnw/cmKBdA8d3fz/A9cS2e8soJ6i5zvNWymzoJuBE1KYV3Ryag1LnNzvvkskyfhGftvmfWPhXPfWNf68wQ9M+EmVbi0xLFUMdnp8lI5bFM2wTgOUEZRk9QwrVsPCGgB9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DseiNip4D5B54oWWL6RtLNzuzXBCeMV1/J+T4hHt2E=;
 b=BP9f4pNSLDSp00xBJnm1QPG/1M8M47fiJSdUzuHb7QmykNpvHBEhENIxVKV+29N7S3rnWRJJlZCBOOZ33KZYtXy8iwqrVyLVrntLax7tfK+P9YmNaxBwdRJrcP1YAFOpJ50L6QvcKs4Fe8Xk/dlR8t7cy8kXqrGjuL7Ck4Nw0pM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7133.eurprd04.prod.outlook.com (2603:10a6:800:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 17:56:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 17:56:52 +0000
Date: Thu, 30 May 2024 13:56:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 00/12] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <Zli92VLw6IEVg97b@lizhi-Precision-Tower-5810>
References: <ZldDIabPAa7NEmDQ@lizhi-Precision-Tower-5810>
 <20240530172749.GA552716@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530172749.GA552716@bhelgaas>
X-ClientProxiedBy: BYAPR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 991ba564-fb26-42ba-e56b-08dc80d1e2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DHy4qUqBztE4hDC1j+uh/RVz0fIhxtkKpaqcptPo+D6hgIowHPpaM+VQyAIJ?=
 =?us-ascii?Q?w6lGRiGBff/ADEjuPh7aCgPqMBGmTH2pB+2ow95tHCdsYqv5rfRx6hdrqgrd?=
 =?us-ascii?Q?1fRbFKwiGh0wf62SCUyzQYijp97ffNFAz+Q09hxuAWfoqlEtwrCIoPpEni5S?=
 =?us-ascii?Q?6Dj6ADXYx3G+vXfThRqX8NpXf7kjnb/IrvD7aHNHUeOhvMLBs9a8AysSeazT?=
 =?us-ascii?Q?oY0u/8+pz7odx4shcKoeE8frkpStIzTQImd104GGlGA4j4EVBPttTs8ca7w7?=
 =?us-ascii?Q?6BOFTQMFU1jf3qDmjdwNNoBKphONGeEpoZyp46oVzzaVWNnUdnHlxdET35Io?=
 =?us-ascii?Q?c2tT59DvNvhXdWu1PZBixgUYN3HAE5GWfUkdCKtB2hTqM8k/PZ0UO8bAiG2d?=
 =?us-ascii?Q?eRhFDW0s4W+hYbyJwikaR4sa5tQuMm58C5rC1P0ZVnFBTUOkJhIwVBrLxcm/?=
 =?us-ascii?Q?UoQfiFiyhiMVXCS3FVMsySUXgLnalkLdE56Yr8yTV7WwUHojLIGvXZ9+xaol?=
 =?us-ascii?Q?hL6FsJQ683nT6P3e3myuLTJ/Xg0NnI1QbhFmw5n/Vqgnk+VlDUKlwkTpExqx?=
 =?us-ascii?Q?dsi/SSXx+0p4ppMGbuE6qg/d3vdQ3c966iQal0WJGysgmM9xtwsOGEZ707gs?=
 =?us-ascii?Q?atSXxPqW9bS+3XutZPLmDVs8/913lc7iMMqdwSEPfAkHsvlXNTLkF60Dx4b7?=
 =?us-ascii?Q?KMuuv2FY5lmYLLdzZAho1sNssqvDXhUSJEqFLeqROOotXnucH8uUi9OjlFyY?=
 =?us-ascii?Q?5sbOqjhL+jkjlLp1+bNh6xxrZIQ56XT0X2Co0Lfid64L8tMtYHzjHkfJhWZa?=
 =?us-ascii?Q?s49izeRx9DfM6UPGoBiGuEAb5PlCeo6xG6rI6x298WS+Zcibd7yYNDxgl2Wk?=
 =?us-ascii?Q?Vn9nXERbWrKBpiEsmjOvEpA+SfgCQ3iTJ/T66hSE2RLQ/jIbekgrfVUfZdHn?=
 =?us-ascii?Q?RhsyUC+xqINi8jWYsFXbamrpgSFKLg4Drq8ZOLQoDaDFG1h0cceHRhlKtgxu?=
 =?us-ascii?Q?AdCbIiHjiPBbiZ2LVsD6pZc4D9nP4K8g5coBHfYyN1vpA9mDa4cccCC8gVRv?=
 =?us-ascii?Q?rFwK0CgDRfsHSaLBTaPUpicufl4Q3ERjPQ/sNmGg2uQfI5UvDPoIq0BZELQg?=
 =?us-ascii?Q?d0igLVutuMssmE8TJdT9RhMipW1asqGMtNBAm08luHmt1fUTDLuoVczgbwPJ?=
 =?us-ascii?Q?8e7zPIJFCY4Z/ekZs4XlDAA7ILHjSUPqCVOr8Acegv5vZwd15MdHqIs0qWKc?=
 =?us-ascii?Q?h1ZINN2ihKiBxR1dMnq8n9w0SN2nUBQwKI+GGxtyvOWkj3QMwEn6FjnoYU9q?=
 =?us-ascii?Q?d8d50CS0Q0HVGCffqQt76x/ACSEBM8vlsH4Fcv+J3Sk9SQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?whFBwZZi3U7MXrKESQTai/Nt7vnR6gALmxniJK+JsmbI2cFZvFssV8TYousa?=
 =?us-ascii?Q?1P69sZRP5/sdqyg1n01xtjaVV6V6FoDyKrV1rs1/EwAskFzu2T8Didz0dfSw?=
 =?us-ascii?Q?di0lrmSQ0OzH9Ofpla5zSKvfNRaHF7NcHeJF5iBR+uiyJ3I/1ytEewRTMA/v?=
 =?us-ascii?Q?IZQDXE88XGMBO2YY1fSCsGuqAR0/nE4RNm0qrfuoyx11bK3kkjMJu+chVHHC?=
 =?us-ascii?Q?pF2YBnizGdH00FlYLFLr6arA6ggmeBHOhNMqwhbKtpmHotVhPbtuvDuyr3EZ?=
 =?us-ascii?Q?DykN87fx67bjA3t054oNzFpT6y2m1LBiolVjD0toYSQeO2z0iQE936iaSzY2?=
 =?us-ascii?Q?GxrpO3czk2XgxUMzPIapo3aBWxo2Bfx0VKd5krGGhemWE5t+EYnftly3nRq4?=
 =?us-ascii?Q?WGprPJTI4ehV06BuwqpO0i5rpU0wsJo8A8nLIsrx0R1VjqG7kUkrjWiyBt5K?=
 =?us-ascii?Q?hJ+MIIR/36AIPXFvAuy6JwoH2DmWgOotGSqSSuMp7Mb3vtusDOT9HUFrnjL8?=
 =?us-ascii?Q?Db6ky/j5M8fnGFk/qLgagG1+FNwC4M21n8k0JPHYRQNyqPKPa4AusHol3SWp?=
 =?us-ascii?Q?Zw4KCsPmCFKn73jaHsp4XBUNyiCcAl+GItAeCjsR9O/ELVTtw2LE5qV0WKVH?=
 =?us-ascii?Q?j+bOl5nTglBPG4eIz/CXM1WmJi26Dtr4FSRFzDn9SYPkU3H3QYzNyhtwy6qJ?=
 =?us-ascii?Q?Wu0yPJY754E/bfkna7ujLj553s5RuDvUI3PYq1CyP6LqcWyQSIhi+yVUEbQX?=
 =?us-ascii?Q?ivTdw/+q24izIybae2Jh7IF4CWT23Z+1p4Z/4AFJdSmYyQAUgLNgYG+mbzy7?=
 =?us-ascii?Q?+L7+XMAI+PdPdtzHTEYp7OjGDXQTmUhaudvn7VziXHH176VLfB67/LZ7daFH?=
 =?us-ascii?Q?Qn0ztHchMRJ14odJdBsxXnswm/YjZNGKQosLizu9IkrMJR8JeypX5/9dsMQ8?=
 =?us-ascii?Q?3xTRDg+u2t3vFRbUbft6gOoRxzCiUq/1EXghzKdqbgXTGofXPyazWyAK8RJY?=
 =?us-ascii?Q?LsMqwbWJkliy3FtqZxe7782I18+p4lFhIe0egpP4U1V7EgFdcZUqe6PtMO9V?=
 =?us-ascii?Q?QxvKBkcvtFuNA0+nX9mygx4hdNTm3firOzIUI7uWZDTQ/HbUO0tH+iznU5Ha?=
 =?us-ascii?Q?+uJjV+2QrrovXxHGmc0itmg9aFgXjJetPqcHWmzmLAjRIn+GaFVm3gvAZhfp?=
 =?us-ascii?Q?r57e6y2LyAR+oUuo3L7NSz/94nLp9StoSvy3zwyil3/ESHm+JNgBqnyzCk/m?=
 =?us-ascii?Q?8nmM8Lgi3+14FSZdB0P2JYf2An3BmEkWIsMffHbbzCmklOPM/tdYxiZJkOV4?=
 =?us-ascii?Q?lZXHlid3JyjOrizx5blHizErwW2M8yeshkE6pUWWMWnBJBIZgEkbVxHsamqo?=
 =?us-ascii?Q?wQFLNYGRPsr0t/Ys/i/Cyhaezbzz+zr6d6DsmKBt4AyLO2zq4P52C9ObzVHg?=
 =?us-ascii?Q?7lETSGZO2CUPQJa2Y43VDs6pHy1akxUO0Q1rtmliWTpetMpzB74rcuAX4oZD?=
 =?us-ascii?Q?QodB1hCd0Xolmsft9rurfr9QC+wcnEmVoF5z7mG/UZ7EtPsJeNrYGzaAwHJu?=
 =?us-ascii?Q?uYBBVIwGkOCAeZBnmyN5mMLcQcOrg5AsMgheOq0e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991ba564-fb26-42ba-e56b-08dc80d1e2f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 17:56:52.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jp3GnBH2RJR4cvezYUDK07+8V7/StYDsj0nT/4XjtqI4eG0T/3sxaeOcOolmB7JgZZTqSxmOqTBqCYlMqbH+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7133

On Thu, May 30, 2024 at 12:27:49PM -0500, Bjorn Helgaas wrote:
> On Wed, May 29, 2024 at 11:00:49AM -0400, Frank Li wrote:
> > On Tue, May 28, 2024 at 05:31:36PM -0500, Bjorn Helgaas wrote:
> > > On Tue, May 28, 2024 at 03:39:13PM -0400, Frank Li wrote:
> > ...
> 
> > > > Base on linux-pci/controller/imx
> > > 
> > > This applies cleanly to the pci/controller/gpio branch, which has some
> > > minor rework in pci-imx6.c.
> > > 
> > > When we apply this, I think we should do it on a a pci/controller/imx6
> > > branch that is based on "main" (v6.10-rc1).
> > > 
> > > I can resolve the conflicts with pci/controller/gpio when building
> > > pci/next.
> > 
> > Sorry, I forget update this. It should be base on linux-pci/next
> > (e3fca37312892122d73f8c5293c0d1cc8c34500b). 
> 
> I prefer patches that are based on -rc1, i.e., the pci/main branch,
> not on the pci/next branch.
> 
> If a series *requires* functionality that is already on a topic
> branch, you can base it on that branch instead of on pci/main.
> 
> This series happens to touch some of the same code as
> pci/controller/gpio, but it doesn't require those gpio changes, so it
> does not need to be based on pci/controller/gpio.
> 
> Having this series based on pci/main means that if we update or drop
> the gpio branch for some reason, this series will still make sense.

v4 should cleanly apply to pci/main. It is not big deal. Do you have any
additional comments for this series?

We still have some other works (such as simply suspend/resume by using
common PME turn off method), which base on this series.

Frank

> 
> Bjorn

