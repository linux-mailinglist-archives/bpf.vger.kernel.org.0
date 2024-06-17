Return-Path: <bpf+bounces-32336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC07890BBE4
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564441F21FF1
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9027F19A290;
	Mon, 17 Jun 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LRBotwml"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C51993BF;
	Mon, 17 Jun 2024 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655460; cv=fail; b=GWeolESqcS/8eVdLOKOBqYpRYUUrKFLn3ESGGkoyWFQx1hLA+i8dlfT2/1ZCq0gAsJfLjhqFNyrPXmbaT3x9w8j0OLgfbCtQWiCB75kShIjuWUEOvSwCklCnY+g8Y8yalRkqWBKj7/0Ftqe1ozketRT/kB21d/QoJtToK4GX46E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655460; c=relaxed/simple;
	bh=AfTVrCLrEti1105wDAcVWo6jI2pjgIWKJzNX5Ep+/9w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RfA6r8MfxspUSIqcZxRWX3vieZl/NFBVWjM/7AoPO/mxW8Ei/OI4USTAmnYeHvvelygDoC2izloqPrxozGFdNoIcZYhblUvoZ9UYv68gG18xoAPVqt5LF+mPzxu+NXabii3uTPKdfvh9b77u2EZqm6QSWMGjVJzbsg8/29pQemo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LRBotwml; arc=fail smtp.client-ip=40.107.103.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hedIVkg2El+B0dZN6ylBwMn4jMFw7MZYdvKR6t8CTk7mIzL45MUdBfqT3W4Odg6CXgWnpQNcz4JAIe+1hPbe2RKznTBZb/rm5Gq9Ima4CkL5L2ImyrFZlu0ZTj3wNJA2tVPFkZi1jtbMTe/T6voi2tZTzJIxzvqzjo2+n8EPGcijp0FUo0IGlWXm1bU/gz7BinJ09AaJPPQX5xfSAIML1tv8DFjrsdnyBtzlnGh11SlnaFo8h1UvsUQmjNtgULJjHILxD1Tk7fPxHpDVGtRxpt9LgkNk/feht86Yo26biGBbPmvXI4cuYuxHGHr7LtZsJqS9Ek5H35rxjVIvCgRqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFZ9y59NHvkPdCbZdfCtsYWQoubEyRTUZZdNbOF+uvs=;
 b=iYK9MImEKSyDpboKcRFA/PCszi4Izq7NCBOmR+1xorUMjmLv3vT5KcVn/O8BPIbiW0RfaBeRmU2Gm02snZLu+X3M9zT6P15hDG8Xpx831Lfjy8hW8VR+JPYCL6ZGPh+5FEH0/KTD0vP2TzzXLEsazlifxL5tG4M+yp2U7VzAlOtRq0vlXAu+IbrNTgsCuVGwFMzF3HhuED3CCOIr9gLea/E+qyIEEHUCyHjWHc7qLWNICcJ4drd+ukXf8RVgOoEgDrIgzaILprDwG9kSyfbULr2sdcqAJezIOHDxNh0zE0wNI1diLVpHcv/kV3TmNELYc+sKEUGoHkXyntJo0Qv5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFZ9y59NHvkPdCbZdfCtsYWQoubEyRTUZZdNbOF+uvs=;
 b=LRBotwmlZHkreOaahvdfj3XurXFdMiWHK7MufhY41XsMcjrshT01rT9++7LKdewI9nEearDil1qHrDsEy29E8diPkX5C5zhIxRIaZ+16Ln0XuyOTmm7J2XBAu5QDkmOUH7tVj7ghKbA4g7qkjFosOnEkyKMUcAvLu7ADbRxlNVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:17:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 20:17:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 17 Jun 2024 16:16:40 -0400
Subject: [PATCH v6 04/10] PCI: imx6: Introduce SoC specific callbacks for
 controlling REFCLK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-pci2_upstream-v6-4-e0821238f997@nxp.com>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
In-Reply-To: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718655424; l=8294;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AfTVrCLrEti1105wDAcVWo6jI2pjgIWKJzNX5Ep+/9w=;
 b=1Jmd0QbXMPxXo3v3/vatM08XLdpHfMiGbqmJnhHDVAXFbCE2KLER23dNPPZDb0nCj74uRnziJ
 VBowt2kmJrdD60z5T8ImK/30Qg7gxFz4YFzfeOge6jJtzkg98mKWqNX
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f2cad9-2e60-45f0-f5e3-08dc8f0a86b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djBERzNBWXVJSnZjVnBBMGZvYlBOTC9mM3B4NHROUThJZVc5VU1XS20xa0kz?=
 =?utf-8?B?VFZHemFWMng3OFNwZnNJSDRNbVg0SU5qdk9CMStPeHZSZlppMTJoVCtCVW8w?=
 =?utf-8?B?VjZIYldxN1dENlJhNkFKSXRVKzVJbzdpaTdoYnR5bHJmejFKRmFLcWRyUHlt?=
 =?utf-8?B?S1h0YWliS3VGT3lTL3djd1BYWVlmN1BkNSsvQ01PdXVYeEN3U0NKT1NwOHhF?=
 =?utf-8?B?SW1hdWJ3Uzc0bWFUZVFIbTlaNlhOMURoRyt1VGY5V2d3Z2FoK2pDNy9Pa0xa?=
 =?utf-8?B?NkIzb3Q0L2xnR3oxRlQyaDdVSnRyanpRbklMSHJHTk16SVZjM1N4NjFnSklQ?=
 =?utf-8?B?RkJ0U3RDTzNZcnhxRFptQTNDZDVNM2NLdlF3Y2ZPTzlPekJJZmZHUTlOOFNm?=
 =?utf-8?B?L25BT1UyRGJZR1RtMzV5Um9CQzlKRFdYSHB2S09RZFBCSnVndFpoV3NaN3BM?=
 =?utf-8?B?Z0RYYlhZUUlibSszbGxHQXdpSHFkdnVNRUl3OGNCQjZ0Rk9pbnZjOUs5SmFZ?=
 =?utf-8?B?UkRid0NoU3ZjTG1FQk5ZSmRTMEhkWlh3U3ZSTUE4Q2kyamY4elFDMTJDWEhC?=
 =?utf-8?B?SDhVK0g2SVk2R2QzTzdURzNKdzJFQXV4c1AyamtkbjlxYkRlMk5WNGtvZmo0?=
 =?utf-8?B?dytwOXk1SDhqWGNiZ1ZkR3BIMmRUVngwOUdjT0ZNSFdhM0pmUkkyNGozS1Fm?=
 =?utf-8?B?TElWbGllTStUL1crSTBpZk1zTDMyUWZRQ3VhcG9XV2orYTlXL1pUNjFPZ3ph?=
 =?utf-8?B?bWgwQ0FrL091dEkwWDg1MXQ1dlpBRmVyd1ZwSGdRcFZjUEtYU1I0QU8xTWVG?=
 =?utf-8?B?TVpNVFZVa1dFaHhqNU9pSGhYSTY5L0tLV0NtSFBlYXg4dHhvZEM1K1R0bU44?=
 =?utf-8?B?RkFlYnM0L3VwL09vTXIrbDYvSUV1Wk5HeDVXQkxqU3VqN2NWSEg3UUFGQVhm?=
 =?utf-8?B?V2ZVZi84NU5WRVh2cEYyV0NVc2VZQUN1TStPZmFycXBqbEs4OFpGNWdzT0s2?=
 =?utf-8?B?ZFgvdDhDL2FWZFJ6eTgvVXU2Z2EwaEdMYVo3bHJNcW5TaFcyaXJ0dlZzL1hQ?=
 =?utf-8?B?UzlDQ3B0R21VcUhaa1F3RlJVWVdOdE4wRTB4Tnh5U0djYVF1VFVJS2dSNE55?=
 =?utf-8?B?Yk5aMCtDaXhVaUVhb1JmOHZibkZCc2ZQZWpMS0VLSFIxTU1kbEFQU2JBOTlF?=
 =?utf-8?B?a1doZUU4VEltSmc0VHhRL3B1d1l5eU13S0VKdTF1Nko3Uy9TMUw2a3dLR3FK?=
 =?utf-8?B?QXBweldIY1N2T3lRREJMUlFFclVBMERGL09tN2x0R2xZOE9YWnNzcSsrZVVT?=
 =?utf-8?B?bEkwUEVFYXNCUENsYkY1OWFVeDl3QXBoOGpaN2taVVFRclNCWG9wVFpkNSsz?=
 =?utf-8?B?TDdoUEd4bEY5U3ZFdm94ckVXZWVSWklzUGRzVVY3STh2Nm9RVEdXb3cxaVlU?=
 =?utf-8?B?WElIL1dJMW5QK2ZOVkZ1U3Bmc1NHTHcwQkZwNGpFNkREbVVWWWdqS1QxSkhR?=
 =?utf-8?B?bkpRMTZLTGtDUFpuaVNwT0JuZFM0SjVMZEZKYkFFWXdJV0xaMG5YS1NpQzZ1?=
 =?utf-8?B?NTRoNFJhYTJFRHNKeVJjVmJSQWdDa1ZYRVZLRHlmRVJ1SExEM0dnVWdqaEh5?=
 =?utf-8?B?d2hXSk5nRmJwdTExWFU3SWh2L0tZbmt1cjdrWkRCVTFzTXdPZDBQeWY1SmMx?=
 =?utf-8?B?T0p1d1VnYjlaMGd0WHpDb1k2ZEdUUm5EOFJUK1dDT3BFdFFjaTUxMDdpUURL?=
 =?utf-8?B?Yjc5WG0wVTRyeFdHMy9KcEt5R21pbHlIL1hyUEV1azRHYUk5UUhvRzhOK0NJ?=
 =?utf-8?B?Y29aSXJpc29naEdBdm02akhnQU1XcFNZVERNblVGYXh5R01PbHc2cURudldM?=
 =?utf-8?Q?qf0tzeotvEeS4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlhBOGhZVmNrQTFNenFNNWtBN1JhR2N3SjJpRVdHVWxOMi9PZGltUVo5T1hK?=
 =?utf-8?B?VXU1cmxRVHhqWUFsUFdpMWxXeUl1aHdTaU5PVWxPb3hDU1dLSUhidFczUTh4?=
 =?utf-8?B?eFYrTW9hTmRSUERReEJiTWNFRXJOTGNDSlZGdFVLSlp4VFErRWw1b2k4VjVE?=
 =?utf-8?B?dzJtL0txek56Q2JtUkE3TWM4YklsMzlsVDdtQTBybjIxa1pqWGUwMi9JUkw1?=
 =?utf-8?B?UEFWaWNvbFJCbklDYkh0cWdmZlNXMkI0YnNVQlBWdmNkdlBlZTdnTlhERzU0?=
 =?utf-8?B?VzJoalpKSWk4SERXMUtTMXZoMGxQakNpVjZQUndhcDlWYzRLUDV5TWFmWm9C?=
 =?utf-8?B?SkY4djdxTmQrNE1PZUZ5SXNTdzVRUXVpL3JLVnJXMFh5bTBpZ0RHamthWlZ6?=
 =?utf-8?B?cnRCbXUyQ1R1eVZJM0FsZGRJUWpWT040TTFiMHNZaWw3dDkvbHYvdzZ3VTRo?=
 =?utf-8?B?SGJFN29DZmEvb1ZWbXg4OUQxdVpzNUVBYUNpR05sY0pLVFJ3dUdqZVd2NlJE?=
 =?utf-8?B?aVpHNnhBWi9lUnp3NlNvS2l3RGlzVCt2eUZxNVpDb0d4VGkxVytjM0JJUUxa?=
 =?utf-8?B?SUV0M2V5MG1UcnJaSUoxaHhWZ0N2K3VHbWRuZlcyendTdURaV2pMaDBvM3VP?=
 =?utf-8?B?MmVrQmNtSUJ4dTBOeWFCcjFQRFpIMTR5TFE3ck93UGRvb0tLdnppMEliZUdQ?=
 =?utf-8?B?NjFqRUNLQS83Y0d6aVBWenAyNEYxb2dIY1RIVHRtdWVnbXRuV2RvRTVCY0Fk?=
 =?utf-8?B?RHdnYUxEWVc4d2Z2K281OHFKUEVGMEsvOUtLcnRQeFRrMGh3SWNaYnhkMExE?=
 =?utf-8?B?M2NUUGhNMmZQdU9IMTQxdVJpNURDUEJIR2tZZmVUbUgxOEE2RDZnUkY0NDkv?=
 =?utf-8?B?WVgvbEloQnNHTUxBb3pibFM5WW1jRWZrQlAxcm1XTFNlNFhGR2tOd2JSMmVl?=
 =?utf-8?B?SitZR0RQVlYzaDM1ZEhqNWZRRGQvVDFkWUZGSllzanpQY1FlTm40ejlUN3A2?=
 =?utf-8?B?ZlluWVJJWmhoQlBaUTBqczRVM1hLcmlPMzJ2TXBadGdLUDV0aGt0Sk1ZbStQ?=
 =?utf-8?B?cVRsUVZVcy95OGFielJMZFVxejNhQkU4emordlRsRkpNWkJMMHRBQWNoZmlv?=
 =?utf-8?B?YnFaQXdsZ1FhcGx6V216ZmtPRmZ6Yi9JUXl0cmlRRWNrYUxkWTFsQVl0T1dl?=
 =?utf-8?B?QmFzZURNcG1YTXNwYXJLMlZwUG9KRVE2clhPNFJIOEJuc21nVG41WklHQXEr?=
 =?utf-8?B?aDc5aysza2Y4RU05ekh0dmx2cHlGVXRDL0Q4YWJMZGkzM2F1M2NUbTNFS09w?=
 =?utf-8?B?YlRROWljZDNrNnBTRU5naXpvZ3lOb2FES3FrODN2Um5OKy94MU9TOGU3aDNI?=
 =?utf-8?B?VldQcUZwU052L25aMVVMSlZ6REVhcENvOFlOMFNYRERZeWVhK3ZMZjdJQVNE?=
 =?utf-8?B?d3UxV3JUeG80WnlJcFlsVUFacVZEN2VOZ0Z0SmY1ZFlVYzhMRzREWVhUNmxZ?=
 =?utf-8?B?c042dXZlUXM4dmhaenJSNFZUTVgxVThyOUNWRW40OHQ2RVU3emx4N2ZlY29H?=
 =?utf-8?B?ZzZabGR3eURjTmNJTGpOZW9aNlIwZ1FnRXJMaFpBQ2VJbzE4TEdjWDlBSml6?=
 =?utf-8?B?ZUkyNzRqYUNNTGNCb3p0TGlHd0s2Q0FpUGE4MkpJeXlCbUltYjVtVTd0aVIw?=
 =?utf-8?B?YkNad011VDJWRVdzRXcremtlaW5SaGxydkdzTWpXRFhSZkttK2tNTmoxZ0I3?=
 =?utf-8?B?NENZRHRBQW1WVHMxTlc5YVJ0bGpialJnSkdCUFJqSENFeDhxSTVlK2lWL3RZ?=
 =?utf-8?B?bGV2NVpQTlRRRjlyNTZqbTJXd09WQVNONnJUVmVHV0NwL3lXTmRaUjlmT1Yw?=
 =?utf-8?B?aHl3dkJLSG9GeGtDMDZjbVhzNkNNZVE1bk9IcW1wdkFyTE5yTWNJNkdHVkxZ?=
 =?utf-8?B?WFdtcDV1K1gyR3p2a21Jc0xpQUVyamdZcXNuTVpXa2hYRnBuVi9HRkNFQnFX?=
 =?utf-8?B?eDF6TGVzQTlkZllsMmlIZDFxcThZcHRsU1V6Z1hKQkYwWjl3UFQzS1dsOHFD?=
 =?utf-8?B?Z3drM3J5MUhjSS9vL1RiL2x2TjBXLzQrQ0szWXNxKzNudHpGc2xuSDVpYU1B?=
 =?utf-8?Q?yVXIRRQiTgf+EN+pIrJhpVUqw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f2cad9-2e60-45f0-f5e3-08dc8f0a86b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:17:35.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzm01p0+tQuhhHiE5K5vT8eYvPR86iAPH/n9AGoPct2rK1bvLgIqtcavIRTvoCHalQFKYYN4Nar3BNrtDTMf6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997

Instead of using the switch case statement to enable/disable the reference
clock handled by this driver itself, let's introduce a new callback
set_ref_clk() and define it for platforms that require it. This simplifies
the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 112 ++++++++++++++++------------------
 1 file changed, 52 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 47134e2dfecf2..ff9d0098294fa 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
+	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
 };
 
 struct imx_pcie {
@@ -585,21 +586,19 @@ static int imx_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx6sx_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	unsigned int offset;
-	int ret = 0;
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
-		break;
-	case IMX6QP:
-	case IMX6Q:
+	return 0;
+}
+
+static int imx6q_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	if (enable) {
 		/* power up core phy and enable ref clock */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD, 0);
 		/*
 		 * the async reset input need ref clock to sync internally,
 		 * when the ref clock comes after reset, internal synced
@@ -608,54 +607,34 @@ static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
 		 */
 		usleep_range(10, 100);
 		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
-		break;
-	case IMX7D:
-	case IMX95:
-	case IMX95_EP:
-		break;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		offset = imx_pcie_grp_offset(imx_pcie);
-		/*
-		 * Set the over ride low and enabled
-		 * make sure that REF_CLK is turned on.
-		 */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
-				   0);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
-		break;
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	} else {
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_TEST_PD, IMX6Q_GPR1_PCIE_TEST_PD);
 	}
 
-	return ret;
+	return 0;
 }
 
-static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx8mm_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6QP:
-	case IMX6Q:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				IMX6Q_GPR1_PCIE_TEST_PD,
-				IMX6Q_GPR1_PCIE_TEST_PD);
-		break;
-	case IMX7D:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
-		break;
-	default:
-		break;
-	}
+	int offset = imx_pcie_grp_offset(imx_pcie);
+
+	/* Set the over ride low and enabled make sure that REF_CLK is turned on.*/
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
+	return 0;
+}
+
+static int imx7d_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+			    enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	return 0;
 }
 
 static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
@@ -668,10 +647,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 	if (ret)
 		return ret;
 
-	ret = imx_pcie_enable_ref_clk(imx_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie ref clock\n");
-		goto err_ref_clk;
+	if (imx_pcie->drvdata->set_ref_clk) {
+		ret = imx_pcie->drvdata->set_ref_clk(imx_pcie, true);
+		if (ret) {
+			dev_err(dev, "Failed to enable PCIe REFCLK\n");
+			goto err_ref_clk;
+		}
 	}
 
 	/* allow the clocks to stabilize */
@@ -686,7 +667,8 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 
 static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 {
-	imx_pcie_disable_ref_clk(imx_pcie);
+	if (imx_pcie->drvdata->set_ref_clk)
+		imx_pcie->drvdata->set_ref_clk(imx_pcie, false);
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
@@ -1475,6 +1457,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.set_ref_clk = imx6q_pcie_set_ref_clk,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1489,6 +1472,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
+		.set_ref_clk = imx6sx_pcie_set_ref_clk,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1504,6 +1488,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.set_ref_clk = imx6q_pcie_set_ref_clk,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1516,6 +1501,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
+		.set_ref_clk = imx7d_pcie_set_ref_clk,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1529,6 +1515,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1540,6 +1527,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1551,6 +1539,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX95] = {
 		.variant = IMX95,
@@ -1577,6 +1566,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1589,6 +1579,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1601,6 +1592,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,

-- 
2.34.1


