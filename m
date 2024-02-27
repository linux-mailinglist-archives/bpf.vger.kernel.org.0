Return-Path: <bpf+bounces-22803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E986A1DF
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27DE288D5A
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9442D1534F6;
	Tue, 27 Feb 2024 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CmYW+cV8"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8C151CC6;
	Tue, 27 Feb 2024 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070471; cv=fail; b=dM6ukQXFiD66QVjWWCEOzdsBMyKBBt9KS5485Ar/fXd96p/fnuAVpaYR76nWCgWHcliuZ+FleJ30kt/amnUGaZB8wTqYa7vcI46N1yoBUweSOyKr8OJLanza/WMLtHB1PV9F/pRAbrDWr+H1R5hM/6mBziD4cv1vvvcm+1poD4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070471; c=relaxed/simple;
	bh=7LEmma9asVcc2UpABKTIPCze0Rfq/WnOrCDirUI9M1s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=a+PRoYPo64l4XIHaspdFViTNJpakObY4tR9L9Aigw3NF7iwyxWVGX/TcB24OYCGzN2RNGPhwMsfGr7lJugzmPEQGaNBY1iGwGFFZjtr4gBtkBFSUZ8wUqBGTghT/XfjkoEdx9pX4OL/UZ1h/SCfK6gl1qyvWkIXmkzgCqqx8Wog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CmYW+cV8; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqcCW5RtrrA3AQXassvQ6NQra6Wkf1xylgcf3nnl6sjuqwJiANKt7j1XzfDCCmG7l9Yz4dsY4OPaeBsuTqhriw2yhyKUAglrqh9X/sjVSEfYr53jmU/UCmAElhNPzWAMa0R/yCWZxqiPTw2zsTDZuxsJCIdUGLZtQA6hf0rayIod0ClbF2+I7T+91cJQH7K3zg39mH7DVvdt7RyVyVO5OrjOGLEuwpP8hSMwJD50A3O/S+fIcNkCreI7W+3jMn2+GOOTREnkE2FJs0CGl2NU1vwjLU5M6ddi1HZqjuXuwZwtsLoIt8OVKjuuDL1HqkROKwb4yyeNomlVW2z+Ofd7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYoXCN2Cg7BevWD2QEgj8BjNP6h0jRB2sBiityVf9KU=;
 b=e+NbHbUsLzu+lEDC/gx8gmn0HydEiZuLoLoUtTx5U1CKO7AowVZd9ZIv6VgzA4JGXMsbLZYgxfoBNdG6iaHFW+Ipqdt3ajl3c5Yy0QKwYe85RDiMTmC31sEczwFAaeI4D5N1H961Kz7/qclNxZDfrTrnTZKFm8yr723rXg4Emig44irvjloTp8ZqVmjSj7ZNFZGL/KH6HcFUAwFEs5HbgYm7nMmFVQOXKceMomjjZJrPlObmz6lnJnT871arbyVgt2jt5m2acpnX6ZuFQ9dq2a08jmFgDyzOoSoWdl0x0IkZ+lpektYluhhfTYnI1NEgNXugpFuCQz039mgo6hLjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYoXCN2Cg7BevWD2QEgj8BjNP6h0jRB2sBiityVf9KU=;
 b=CmYW+cV8diCZj1cNn/QPkPMOf1c9WlrOiKZY+KZpbBAno6wX2139T7KSfIp3+byGUvEisWBOBNjYzngIn5LjYdb4o0A9eFrLskh4yuezS6dB5jQL1S6lEPycMLWkmDLXXO8bpYuzngytMVSlDF2cjypkIPuDhsCt5o9IGfHbQMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7056.eurprd04.prod.outlook.com (2603:10a6:800:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 21:47:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 21:47:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 16:47:10 -0500
Subject: [PATCH 3/6] MAINTAINERS: pci: imx: update imx6* to imx* since
 rename driver file
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-pci2_upstream-v1-3-b952f8333606@nxp.com>
References: <20240227-pci2_upstream-v1-0-b952f8333606@nxp.com>
In-Reply-To: <20240227-pci2_upstream-v1-0-b952f8333606@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709070448; l=1049;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7LEmma9asVcc2UpABKTIPCze0Rfq/WnOrCDirUI9M1s=;
 b=Rk++xqe9r92Mg398eUNTWOa2qxJF8YQE9bYILMC3hDK+0LF/wIVf48BF+tpwDYltFK16pOsRd
 kuT6kR+uRHPC1NNw9AL1ESb8H6/RAmph45zFA0HRmiuaK4SPvoNF+05
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:a03:80::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0516f2-d877-4714-a7b4-08dc37ddbc8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EMIa3RaDAEdsRk5Zjlw1e7Hk3v/0EGiXRQYdXtH9YSfY05CY2fldIYM66iejjs8Cya8qME+/BlC1ZweUHQsR1JlaZk9QMP7+5IlRmm8VAgeLHCf8CF6B6Hu0kX6v68R41Gso0S2d9CbnFerN0SHjrwmocLeEZKYyWayBy2qUY38fF4Knoa2YmdZJh0Nm1bjc1h9Awocpd6J34ArV+eE4fXWSkemHeMtlRDeyBT13f7CblXGYSaZ8peUoXwvWaIJsWTpN4rfwN7I+KcTs8vC9hLcEX1Gqg86w+OpZOosxlDtxIm5BcMjyxxP3iRqxqIJZfrh5wO09MCHB6Mc7ko9EPTeNQIo41krG3W3MDavSUpdyLtp2i+e2DgEO+yxNqgFRIjHiNApbvyo+GosI2yi6TQsOIzeO7SJs31JOf17+H2543qewc+qjZDR5635BEDC5z9BD//k9oZTxq74fXe3YCcw/Uc4gdDbRkWl7iyMvmSu1oCRyvm+NvQs8Bk125lZ7q/YoRU3iVGDCOXL2H/upAGAVpaWLBV83s734ApgtGuyOIxMffNsEu7qQgb3W41fc56FW42uAk7sraHcdM6HiNvhw8Z7ayMZkIkAU6EDccubEdDnDODqxrcxXgTjTB5eiiC/74ucxfO9sF5/+yPtOpMRdG+4Q/T8nbmZw7mFVwYv7kE2tpEC9oD8OlpvIo19mdFtYJSPDi0LCm6IuG1YLWWmDDVMyxakboRa0CAI8GGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTg2ZFBhUm1hbU5hV2c4OHpvTnBjdDBud2NGa1Nuejk4RG5BV1paTVpleUhw?=
 =?utf-8?B?aEdCVzNMU29ic0lLWXc3dUdyMTRDa3V5Z0diRWFkbXY5UkE2dlh5YTVqOFJF?=
 =?utf-8?B?QnVTRmI1ZGs3NXJkVWtLbVJjcC9TL3dMbmcvL3NWTy9PeTkrenc2SGdST05y?=
 =?utf-8?B?MlBISEtVcnE0Q3A0bmpYRTI0anN3aU8vdTh6Wklndys0VkVCeDhuc1V1MSsv?=
 =?utf-8?B?WmVDTDRYS1JpUUhrQlluOTg3V1J6bkpNR0NUNWlERnA3ZTVWbGdRYWppRVNC?=
 =?utf-8?B?OVVmTVVwQnRYNGt1MFhqbUhjTmdNcU9Yakl4WDh2RWRUNnVWMVdMRFZZcUht?=
 =?utf-8?B?MkdOVG11Q04ybGR0T29FZ0NKVXNFMk9IM3doMEw0eU1xZXRjcGxwcHZGYU10?=
 =?utf-8?B?L1JwcnN5WXJKZVhvYkJ2RUx4VjdSaWdTRW9kdndzUUl3UEIyNmI5R2h0OHJi?=
 =?utf-8?B?cmNFU1MydWFIeDduMjJtbE4rQ0ZlRDBwVzczcWU3SDRrQSs2OVFnVVRCWGE2?=
 =?utf-8?B?NStxa2NadzBHNDV0VUFpUjF3MjV1ZTJRbVFyVnM4OVJvQkdxUVdSelB4eW5W?=
 =?utf-8?B?ZXo5RmNHWnJURkRUQ3NrMEJuV0pGTDBPTEJtcWNrYmxMUTE0Uis5dEZJWjdM?=
 =?utf-8?B?ZFB2QzRSblk5S3R2ZUZlSStlYnRIempwbm93WmgxeXVrN0dJMDVnb2EzZlV0?=
 =?utf-8?B?ZTRNS0g4dlZWWUJlZk9TMjZEUE1VaW0xNHl5ZjFSK1QyUEJsdGx5eUR0clI5?=
 =?utf-8?B?VWFUODhZVkZNWnQyczlobGlCdDRRV1JXZTBhdUtHUHZiZFlhaHN0ZGJHNWF3?=
 =?utf-8?B?Q3R4QkkyVnk1SnB3SU9nSHBzWDMvaFVHUjNKVGpwQVdiRE9KeHNIRTBDOVp0?=
 =?utf-8?B?ZTZFVGdvWXVHVXdMSlU2eEJSZXFENkJKUU9kL1g4WXM1ZmgyZXUzNWFmUW4v?=
 =?utf-8?B?NkV1azZPWUtrTzJuUUtVNUpJV1lHSm5TYlZnNWdJN3F2a09kaGpTQUpHLy9a?=
 =?utf-8?B?RzVDdENCWVlPenVPQTE4NnR0a3M1WDFFVFBsd3dLQkhCRlFXSWNYeVNHQ0lU?=
 =?utf-8?B?V2oxMTYrR1pvN3JraE10MGtsYXZKUThhRENwSG5QV3oxL0p0S2lOZU9IbFpV?=
 =?utf-8?B?dk0yTjRmY2pJQ1l2clNrZXlZTXo1eGYvNmVZNGJZbjM3Wi9hNnF0QnZNZ0tK?=
 =?utf-8?B?N1VzRWx1SzNiWUFUNllZQURyWFN0a283b1hSbGxKYyswTjhIbVZuQlFnaFlX?=
 =?utf-8?B?L2FWY2tCdmV0VUU1TVlCZ1kzM2xEclRaallrMC9HZWRNLzEwTDYyQ0pxU3M3?=
 =?utf-8?B?bnRPWGMvMnR2Njh5WkplVUtpS1NkdFFrbi8vME5BTWVmRTRZVlJUK3Fad3lC?=
 =?utf-8?B?Ty9ZQmtiaGhnZ0N5NnVCNmpURDVIMmwyOFdFV0xrblBNd29vSHRaVzNHMFhQ?=
 =?utf-8?B?NnE0TEpyQmdJVlZxMkgzalVYQUJjSXQ1NjZDZE1iL3VsRjlxN2pyNjRJMVhS?=
 =?utf-8?B?cnZRN2VTazd4SXVndzNJNDRRejNIZ0ZkeHZQell2WVUrTGY4dSthRWtmWG56?=
 =?utf-8?B?VTBPN0xyWVZFYldNTVlNSlVaYm1Mc1gzSFZGWTQ5bGl6YTJEU200a0ZDRFRF?=
 =?utf-8?B?cEJzTk9UQTFjN1V4YWVZeTFTc2Z6Vks0eDNMRDN1WkYyMFZjZTBBM1pRbG1a?=
 =?utf-8?B?TlJaVjAvYlgxOEJlV1pjYXhjZlhtMmpvYXRrZzQvY3ZaSDE0dXF2UEJYYTBR?=
 =?utf-8?B?ZC91TVZadnpwV1lVOFBNQ0trOERneEtBQjBpMVNCVDdnaHV6SWpzMmZuQy9y?=
 =?utf-8?B?d1VsRy85WmkxRENJem9teGR6VlZjb0k3OUtMQlhhTEp6SlBldHQ4ZFhleDFQ?=
 =?utf-8?B?KzNZK2Y5czlSOGNRM2J1cE1mNW5jWS9lV0ZldzU3UFBPcDBLaFdsdFVpY2pV?=
 =?utf-8?B?dHNxR3BKZHBMZFZLcGJmWmVOS0lORnNCNTdiWHJNaVlyYVljdGtjMmpCYUpH?=
 =?utf-8?B?eUJ1b0dWUkZBVDlqM0VQNHpWMWhGa0lPTXlsMHBwUXlyaUMxR1BySXN1WWlp?=
 =?utf-8?B?ekhiZG9OWmZVOEg1VTBZazNZcFJFUFdjdGRmU3pNRk9MNm1zTlBEUytrZ0JC?=
 =?utf-8?Q?pzuj73dPBOXZWHHt1yvrumXJJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0516f2-d877-4714-a7b4-08dc37ddbc8c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 21:47:47.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naxqwn5NOeOCQuqHhZWfYZI6Q8saADflOT5zI+vtsgfJLdFPY5vrF8QFo+KwqbId9T2gqK2FtZWI5GthqMXfbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7056

Add me to imx pcie driver maintainer.
Add mail list imx@lists.linux.dev.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a692..59a409dd604d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16736,14 +16736,16 @@ F:	drivers/pci/controller/pci-host-generic.c
 
 PCI DRIVER FOR IMX6
 M:	Richard Zhu <hongxing.zhu@nxp.com>
+M:	Frank Li <Frank.Li@nxp.com>
 M:	Lucas Stach <l.stach@pengutronix.de>
 L:	linux-pci@vger.kernel.org
+L:	imx@lists.linux.dev
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
-F:	drivers/pci/controller/dwc/*imx6*
+F:	drivers/pci/controller/dwc/*imx*
 
 PCI DRIVER FOR INTEL IXP4XX
 M:	Linus Walleij <linus.walleij@linaro.org>

-- 
2.34.1


