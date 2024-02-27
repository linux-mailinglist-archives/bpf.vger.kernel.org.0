Return-Path: <bpf+bounces-22800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63E786A1D6
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBCE28835A
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F3914830F;
	Tue, 27 Feb 2024 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IDqXtw/G"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEF14EFFB;
	Tue, 27 Feb 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070459; cv=fail; b=pqV5T90GZnI/w6PXT4HETtuSyp22RtqIyY5ehxbDSAGZhzWyp5qooiv+2x9mPE63JNpfuoBoqPw89qaA2lIW5njo54hOM0pWRqHupeVByMk6emUKwzPZysDsU3ncSOv4T7krnsaNdkH0w7KsgKvpDl+jfMD0cYFDPByimofSjiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070459; c=relaxed/simple;
	bh=BUvBpo74+DLhrF8mimLHw09RlH+/kIlxHOLLFJNqLW0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=f03RHi7JAFwAt+GRPmmyPffc7DH4HX9IHfn6MTku4zEGiCxDsrvZW9didE3blxssvbEjcmO2F0pjmzrs3Hflt0Q1Pc5kHP2/rSHgrywFRo4aYSm5vlRGWg9Npah//TEtxDrxwiazvsepHDK7KdUibstqnXhF56rDrfGIlwy0Fbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IDqXtw/G; arc=fail smtp.client-ip=40.107.241.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0tGejxqAXRto4ihJFLOiI0O6O5o8GSJ1Vk6xP5hJ31Mk2YJ2rbWwceEhCpJFhnL8hMGhxu7qkdjlwa1P7jpt64p4DJOyhZuBI7xTU8dnIQSZih8vMYFZGSswJfmN1RTJIzIGakOtTayOXUBmzSk296c2/R3q+hVIhVcisYJTBWe3XS4a1QcyGtxmVZ8/z4U62Hp7KP3o4kgpzVH5bJ9ZMN66WVGfSMxgjfndbpjrwC0Dsj2l0Ivz9tm9VzyMtEdDfafe0cgx7rUPaeRkCs3G9G/+hbrTwK0i/IUCcaSAmIVz4HwTChemQ95l5IsnvqsBPan56Labf+wAhduOfWFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqoBmyQXcFBt8flbMZmAASgdohwNZKvW6qeZg1nT5N4=;
 b=dwuIlfHTkQmEMB9btsH0VXumFFs3AiM6cAsnSHdX0EGz3706EQRpUyi+QtBHICfG07+4gKmEeDsOnkVubNwDztNTjkUH5kxktKBmHghJIsYKFG+Qrty7jo4TDiLn9eV7fQK8uD+ah/VT12ZD1cRdoeEJi0Y8JIkEQewy9Zl2E1vRfMP2D9sBrt6O7cUHGe8fpovaewga7elpc4yPq7pB3x4LQby4Ynn8U6kpUPmgCrXlTYsUBSPvZ3/bMyGUcbyDiUa8LJZ5cwWw3xt8ofBbdl9+RpnRlYBHZG1KIXN+MgMl2vXxtvNPfUureBbazRPf9e5ujoyZXdEEtmcVDjbwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqoBmyQXcFBt8flbMZmAASgdohwNZKvW6qeZg1nT5N4=;
 b=IDqXtw/GsKGTlibOg5BkO7JS0Tk3bDoW/srH867V+gheZ2/Xfh7v8vg91YOTvGY2EcZ2Is1E7YkVYyz6Cwxex0T7h9RhzG7rIoldLAID4nAMmrO/CMcdS3ZPFfIA8eHIJ/jRK0NRue53vrc9O0p6AIOHIOlpypZnq6a4fubvlvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7893.eurprd04.prod.outlook.com (2603:10a6:20b:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 21:47:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 21:47:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/6] PCI: imx6: rename\clean up and add lut information for
 imx95
Date: Tue, 27 Feb 2024 16:47:07 -0500
Message-Id: <20240227-pci2_upstream-v1-0-b952f8333606@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFxY3mUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNz3YLkTKP40oLikqLUxFxdg+SUFEPLRENTQzNjJaCegqLUtMwKsHn
 RsbW1ANxHDhdfAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709070448; l=1386;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BUvBpo74+DLhrF8mimLHw09RlH+/kIlxHOLLFJNqLW0=;
 b=/COSutiSizDVukBnCL81SDZ05CpoeJpsKXZ4+iTRexpuwW9CgvIlths9zHOMqJtiE6iavHDVq
 XbJ8+/SnWJ4AG6oj+/SQD9QWjMw9k0ze9XfW30GHKsRaDLLyD0oAX5y
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d013cf-287e-4c92-b9f6-08dc37ddb41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	USATNL/js28UHJQn+MLtKempDCMgkw5AtUXJrJiym9TaWx7H0iLcYYdwzeQR8+uEn1Hge4aRZe4YEBrUVSi27FnbMVxAySOjs0O7uywBLvubZHkjqSF7D4MVilGyoy66UAfagRDsTJ2uVXAjEbMOl8e7siZ0Psa9LcvOSUOP3X9yVU6xVNB3f4gULge2/8hXNvO5fiGt1OC937JOTlQCAwZbSNmIjvplqvGCuXuvN0urzxgmOo36kgf+S0uFTIn2QTYTNAKXdqvPmSCCCZiVULkrC0Pyphz8MgxlgKc82YtSkj0lG4VviVvW6tuqeN7TvwWLqr0xWxZg4LwGDxDwaOBV0y/pU3ThkPdnV/RUqcpocWjz3kKuj4MecOKgG7eZB2v90C8wb0OmilstT+JM6hCyDr19BTUsS9aEmukoT4V+3tjvPj7zSVq2eRUF2a2cbtq+Tgl9eyZmankPHnFjq+mYrPy+50JyCX82oT6wTX3DLZpte1J+KHWI69aMzGP3LfEvUxLpZpxJu94DRnMhCdi8GiRRiKJn/iTjP4Kyog1USfY2VDY/JfEElabekYqL2BIj/rAwWTGFD119G9iW10ffW3QZPtA9gZTZ7ZDMl83W0/zLKGS5Qm9cPdbPRE4ySKwytOPI4d+kohv47/zeMyCSXLrj4HltVHyGLoUYMCCFZocwsk+DqS8GYxVkqdTJjXYpOAi3og1NMZAuO4NMI9g1zQL/pIDLrx3BZ5Khf0g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU5QUloreWdYR1EwN3RFdTgwMHExNjhVRTNSalkxdHhURWRUNXp3THFydXVS?=
 =?utf-8?B?c0ZtRzhXUkg0ZzNCM0FZQU9UMmxyZXdpbTMvcDV1RElVWG56Z2dpU2VlWlAv?=
 =?utf-8?B?c3ovZlFvNTRkdkoydDhmc0hwdHZnT0RxR0VKSnFXSGtSRk1JVnNNWkFiVE92?=
 =?utf-8?B?REl5Y0hPWVZGbWdoN29pdlYwV0dseHpIelhpYXNzTHFtbXpVczBBOXZuWlFV?=
 =?utf-8?B?OUt4b2lOSjQxYUxkL3FUUEo1Q2k0OUcwZHJ5akE5ME92VVFodkNRNVVCTndR?=
 =?utf-8?B?MjBZUXovM0xTaHFReDhaTDVHOUxWTkxBWWJSSXpBUCtPbDRqcWNjbFhDMjNN?=
 =?utf-8?B?Wk9hb3hGemZyOCtNd2lua0pETHRUejUyTXNQVnhVME9FWm5meFY1ckg0Z0FH?=
 =?utf-8?B?V1JtRE9VME1mU01Tb3RlUkFlaEVTT21rRk43enE5VkIwUnRuRjBUNkVUdnFS?=
 =?utf-8?B?K2dUK0FjQ1VDbHpQVzlFa0RmWmNZeUw2MXZYblIvOGltcXB0RW5LL1h6UEpF?=
 =?utf-8?B?UDhpMmhpcE5URnY4OEtobS9zWldDNktjY2ZnSFBqeG1YUGFZYkhOaFROSWE1?=
 =?utf-8?B?cTFJS0lUZHZSRkxMVXpPTXgrb29oSlV4TnBtRExIT0FRM0loMkQxSnBwQWc1?=
 =?utf-8?B?cDNhd0NaZisxazl0d0ZtL0pBTmo3MlRkN2ZITFBJSG82aXRGckVDUDVFYVZ3?=
 =?utf-8?B?M2VnS2p3NG1iK25hbnkxamZkQmlPSTJlTUoyY0VRVWluOUxtbVRORENrcWIz?=
 =?utf-8?B?eWNHT1dwbzFLT09ncDNNVHNIRC9NSWlYSS9OQVE3QWtmalcrT0ROQ2pVNWJw?=
 =?utf-8?B?ZnZIV2NZSW1mSDNCYk42STJpWXNNdDdvbStpVXNhL3REaXpFVkxTR1J1eDRT?=
 =?utf-8?B?dzM2amVyaFRFdDhaUGE2TWRybjlqbzM4OS9OckZBeWVrTm56RUhGaStPZlky?=
 =?utf-8?B?cVJKd0p5bUNzRXAyS0ZzbjIyUnVNWTdibXRmc2xCSWpudkhLcjJjak1aamZL?=
 =?utf-8?B?ZEVyYkZxTVc2RTFKK05JcjNsRWpJc0pxZkw2UHJKTWxraUEvS1p4ZUZqOEk2?=
 =?utf-8?B?SnVydmZTcXQwUTBhTWw1S0EyRktFVUowZDdqTEk1cU1aY1daVXQya2pva3NR?=
 =?utf-8?B?MFJJS1VnUWQ2ZlhLMzlWR0lRTFJCV1pWY2dKN3dxUFNQdHlFMUlHelp5Ynd2?=
 =?utf-8?B?Q0dITHRkcFk0TW85T2ppL2NaK2NWdHBkTm43UWlyVmoyYUUwVTJFQnQzcDRo?=
 =?utf-8?B?QUlqajFmak56Z01FdEQ5YUh2VzhWMDNEV25tTCtTR3Izb2lEKzkyNWVNbUxM?=
 =?utf-8?B?SjczbjhKN0l2SUFOVkcwOWIzRXpVeUxWNEMwMWp1ckhwNllhbWNELzNrd1lL?=
 =?utf-8?B?aEhTWllQcTdqTWtuLzZLNUFCbnoybnRHUllVd0Q5S3lyQVJES0RrVVFnSVFZ?=
 =?utf-8?B?RmJSblEzZFJTQXRWUFFjMGlydHRoOWNmZ3FTb0NmbkZTeU5EV0FoTUZXcXR1?=
 =?utf-8?B?SlFtYzZua2JDT1c3UjZDR2hPUVBQZm1yWlBlK3pMc2JmdWxtTmRxKzE3Z29F?=
 =?utf-8?B?YlFLVHZpR1R3RUtod054VEFzQ0RhR0ZwZFp3Zm5kdU55cmRJNklJblNabHZB?=
 =?utf-8?B?eXdxSFBHMjhVVkphUEN0eDlVOVJsVmo4ay9Ga2xwdW92QmFvSW4yRUJlK00y?=
 =?utf-8?B?bUtzUm50SFFJMWowNkpmUlVJR2wvTGFXaTZHUFA1YXdxQ1FiakUvSjUxMlh3?=
 =?utf-8?B?Yk9XREJlOFF1TlBqbVpIVmtEeXNUcHNESzUzNVZsQ0poL0RIM2JRbWNyRzRM?=
 =?utf-8?B?MGNlUVhUMUNmaEEzMy9wN1Y1bnlEZUxMNVVqWkdCc3lNSGhmVGNnYWZWMlNB?=
 =?utf-8?B?OE1DN2xpYk1qVXR5bUVLOVZDTVhpaDNzd3ZMYWNwSno5c0RGWjBFZHpLakt5?=
 =?utf-8?B?MWxnT00wU2c2WncxRmp1amFnUU5uYUIyZFdVRE9LVmVvRTdOY3QvT1E3bys2?=
 =?utf-8?B?NjJxWnMxaGEweFJEWC9wclBmVDM2TDJwR2c3N0xPa3BEV2Z3QXFleE9wUC9W?=
 =?utf-8?B?bFJNSHYreDVXYzRqZUR5aHA1MlM5SU5NWFhxd0VtcWhSa3RzNEh1SEdkVHNQ?=
 =?utf-8?Q?pY/hTRPf1owmPONapBbQ0vOig?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d013cf-287e-4c92-b9f6-08dc37ddb41b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 21:47:32.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+7IK6YZpw9T4qknB8mploLDh1zrdBPkK8ZqVq4xwhvZnIVQN3PqUX5CTihewgLEqSpwrzPQ2rqtwPGy27Q1+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7893

imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
pci-imx.c to avoid confuse.                                                

Using callback to reduce switch case for core reset and refclk.            

Add imx95 iommux and its stream id information.                            

Base on linux-pci/controller/imx

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (6):
      PCI: imx6: Rename imx6_* with imx_*
      PCI: imx6: Rename pci-imx6.c and PCI_IMX6 config
      MAINTAINERS: pci: imx: update imx6* to imx* since rename driver file
      PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
      PCI: imx: Simplify switch-case logic by involve core_reset callback
      PCI: imx: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95

 MAINTAINERS                                        |    4 +-
 drivers/pci/controller/dwc/Kconfig                 |   14 +-
 drivers/pci/controller/dwc/Makefile                |    2 +-
 .../pci/controller/dwc/{pci-imx6.c => pci-imx.c}   | 1115 +++++++++++---------
 4 files changed, 654 insertions(+), 481 deletions(-)
---
base-commit: b73259dcd67094e883104a0390852695caf3f999
change-id: 20240227-pci2_upstream-0cdd19a15163

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


