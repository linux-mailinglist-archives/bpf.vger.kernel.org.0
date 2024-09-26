Return-Path: <bpf+bounces-40363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C56987AFE
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 00:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C1C1F244CC
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 22:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06C71898F4;
	Thu, 26 Sep 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WwpxerL5"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B92189532;
	Thu, 26 Sep 2024 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727388493; cv=fail; b=md5hwzPpRfYihBThkvVJcP8CRLvnZV/6wvsV9dNr/tGYY+9cgtlLWYVnfxjlUS7QJM7atIjeoLuNTbo3bnESAt3wf1Uf/OcdgDZ65Sa3SnhswG7GHkWRbENkoDZnyrF+C9N/S6hFBtAN0W5+DqWqSCwRxntr4h+FEF6OGNhuvHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727388493; c=relaxed/simple;
	bh=xQCHUDxSSFv2hklj7OTZlYrdQ4/ub50BGXZ7skDY9Gw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Wu5r1kyc3VoDPXC1aYMBW/mEurmedBQLMFbcFfZW54q1YBXrsrimy11xWsghlMwRE2A65yeCQ1uEcjonqapQQZfptcLK+7jnOOSG8UJI7bwaly0AjK5JGWqFN6kR9VhwkITdBwbbPxGlBl3PrF8wLOSB4ilPu/tUTf82yy0g3j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WwpxerL5; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTGivrSmue2XGkQ0RgX9XVirTf7t3jTFLfMHFvcUhfwPqYv9J/3zfDvHPwz0zqXDegGCrEO4WZflhPPsyPYfxJG/a1z6KIxtx9tcYUHE4Gm9Kc1stLxITs8X9L51RcCjNfBckey3t0qYU9yc6COsQBdlW2gNvxdVaercun3zjXmSmPAVGQEAVpcO0BD5ybDCfhKSgrkhwYYzDFlGxHcpPmo5aGo8tFQNW2hyEPZZl21aLy0b8HJ7oUJMfzkklTlWsPSky11YV3PczcWGwXFnHrR1/flSFW2UAzicA2rxc9599oh5jw414zZg70YO8/7W66/3DEpz6CB4TxHcv9vSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A+AHrCF8kz7jCU/DSOkIRbQdaBgnLw04miwDqH+Y2Q=;
 b=mvpcZ4+js7W1JOicIFkOv+Y2Llf8vSkJIZJipGB05dFOAyq4O6kqDhcTsaQI1WjulXGmhuj/Q05SRCtNYkb0cJ5zCiVEnHuMK/qcFDa0XtglTprPTUA1ONlPEfRqCmlaBJdoxU0Na+4zRc/QboyNR7q6EUjk95gRTNlOjnBskvpnL5QFeq988OdKyw/97plIuryT4S7Crdgl/zRy90P40zZA5eRBkcoOSggHFRSFuh4V0DhhG1aSuODlnoIc0radFzKnqJAu8BFPWbT7Kj5lRHofaoJhWltB9fTkYOw/uRp15NEV6ZVqfyxHUNbZNMvVT0BttnY9g3liw2q7ejS5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A+AHrCF8kz7jCU/DSOkIRbQdaBgnLw04miwDqH+Y2Q=;
 b=WwpxerL5zaqmM3dCJ2URHJcLuiBRKks/gVzoFrq6kDHbvcY88BNWobyL65i2bfahdVsufTek6fTBDRORThUcLMJy7H2rUL5dIH8r2i75gbCRSfbr70ZEnmKv5s6FWgbuXoYC4HB1wvsDgQd12jCOeszdIGpV1yVka2pJ/sUr3W3jREtyyXE40zRTIvYpx98TVScBcua/5HO9OKYg490BTKKUHur7L5ol0emUaBsYy5czguhtPLy8wEU2v933AHH33R1+jaLr5PT8zX69DuoypqcOPK2DDMH5BCzMInw4zkaKJYvh/SmM7x3exNfBJbaU/wXRDAjK6Udj3TUKGytybQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7408.eurprd04.prod.outlook.com (2603:10a6:800:1b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Thu, 26 Sep
 2024 22:08:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 22:08:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] PCI: add enabe(disable)_device() hook for bridge
Date: Thu, 26 Sep 2024 18:07:46 -0400
Message-Id: <20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADLb9WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyMz3czcCkvT+JzSEl3DZDMLIyOjVANLExMloPqCotS0zAqwWdGxtbU
 AQFnrRVsAAAA=
To: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Frank.li@nxp.com, 
 alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org, jgg@ziepe.ca, 
 joro@8bytes.org, l.stach@pengutronix.de, lgirdwood@gmail.com, 
 maz@kernel.org, p.zabel@pengutronix.de, robin.murphy@arm.com, 
 will@kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727388480; l=3079;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xQCHUDxSSFv2hklj7OTZlYrdQ4/ub50BGXZ7skDY9Gw=;
 b=uuB4rSEkqHP6P7qi1VGEObt5/g4it03QiRazEvtIZy9+rdl9zoOoxgh7EHQL3VCDQ6gZF6JcR
 rlbOXnCCsIhAzsEG3vcLAesB8AaNBSekgvc8dWyZyT01wyWCLJrX7Cz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f420cd-5955-4720-4f81-08dcde77b296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmlSWGMxZlJXUVFIL2lCUmtuMXBoc1lYWmUyZW5tVC9JYnFNdTd5NHlkM2h1?=
 =?utf-8?B?SU9idjI5QWl3RGtiMG9VUmJidWJycDBtTUFMSlBRY3JjaDB1RDBOK1lKaFMz?=
 =?utf-8?B?MW03RWFLUHFPNFZZbVVqUkNaVk5rTGNRdEh4ay9QNlBwL2RoRFh0ODRlaU9r?=
 =?utf-8?B?Q082ZEpzYWRJbllsREZnL1NyclY0UlhkNThjVHFDZ25LU0NrS2VtODB6WW5U?=
 =?utf-8?B?WFFLYmtJQXpFWGRGZHhtV3RXZXF5dkRLQ25FMlpUQytkUnZLSHltNldQRnJl?=
 =?utf-8?B?Y3RoUUQ0NVlWUW42MG5wN0lnSFNjOTNPTGxoOTNha0tqeWNHS0s0M1ZrQnlO?=
 =?utf-8?B?dVlUK0x5QXEwMkxTeEpvcGN1YVhOSHlDVFc5UTdpMndWN2pTQ3FhMDVTQWZj?=
 =?utf-8?B?K1BWelJsT1UzdlVtYk9TNzJHK2hCdkFVUVhwUjN4MTdHNFM1anU0c1dyMUg4?=
 =?utf-8?B?b1Y1N0dMeVlnZWhrRDFPU0JqZ2FCVjMzZkFLSGRVV2Q5WHdpdzlCMG9MRkdp?=
 =?utf-8?B?dy96VlQxM1RnbHpVQW1JNjhJcWpESmtKdFV3ODJVYUdsOS9SZDgzYVdPdnN4?=
 =?utf-8?B?TzRHK3pycGFpbmJtK2N5TkF5dC9zM3F2T0l4dmJRdEJMMjREZVB1TEtrcS9j?=
 =?utf-8?B?b3FLeGh1Qk5DMWNPcmNnUnJVL3dXQzFKM3ZhNFBWZkUzU0Uyc2ZxWFFUTU5T?=
 =?utf-8?B?a2tUd1dTUzVFYzhTemxKUVJkMVJoNkVlWVp6d3RWaTMxRlZ1aEpiVzhzK3Fn?=
 =?utf-8?B?Zm5yTDNDUU50TDA0NmU1WVBWbWF6TFdxUjB6U1o2T2Z4TEdEdWJnVEg0WTlx?=
 =?utf-8?B?VUpPVjBBRzVGVmNWdXdKYmMySkhZR2dVSW5ueG1VVHZ0Y0lra1prS2RiRWdv?=
 =?utf-8?B?Vjc2OWFrQVBvU1Q1VUN2VnBLNmpSZXpmc2lpL2FHTlRTQ0RqeHJkaUh2KzA2?=
 =?utf-8?B?ZS80ME9lcVBtUHpneHR1UEhTUUQ4YW95WkFRbUkwMVNabzdCSEVSa3R5cVJ0?=
 =?utf-8?B?bVQzakhiUGZOa3R4U3Nndkc4Y2NYV3E2ZlFWV2hWMHlEYnE3M1BTSjVQRWpR?=
 =?utf-8?B?Q0RvWkJmcWF5clIwZnozMnZnVkw1ek1hVC9DTVFSS2dpT1NQK3pkK3NWeFFK?=
 =?utf-8?B?WmpKZnVReVg1RFdoSndLdXhHUHlaUlRlQTkzcHJWMDlLTDJuaHZJbWJ4eFRk?=
 =?utf-8?B?Zk5ueFZjNWtXREFZeUduQ25pWFlvOE8yVkplUzY5T1dSSFJzdUlyMGdGL1hK?=
 =?utf-8?B?anZGYU80M3VjMDEvSlRJbFYrTDY5T1VPUmt4T3Fwa0hLVi9sblZLa1dseHgv?=
 =?utf-8?B?V0NRNzcyTzVJOHpaSERKMnd4Mncvdm5jTHRhSzZQNzdDMVhRRHpFQkR6MFFL?=
 =?utf-8?B?NTNNOFR2bDFFY2RuY0hFWHUxUUdaOGR0RVV1OGZYZ3gvNEFINVJCL0xkeUx3?=
 =?utf-8?B?V2dTZUpaalI5V2ZORG5tc0d3eVRkUjllcmx3UjZKZEFTSWdoeUlFelR0Tzho?=
 =?utf-8?B?NzYrK2ptQm8wd09pM1d2QVBuRm84YlNpVW9od2wyY3ErSzVPdGNISUlBelEy?=
 =?utf-8?B?RVZyS0tTcXBVWXY2REw4a3hEN1B1SUplV1FmNE1DQTlmTDBGdy8vcDN3L0Rh?=
 =?utf-8?B?WmlQenlrNjR6aFhNMzdlUXZSWFJLRmV5SmE2RmQ3aUtSLzE0WlFKcCs3dzJ6?=
 =?utf-8?B?RzZJVy81c0VPTm0vTWszcThyZjZPSnFvWXpLZDJHZjAyZDE1YWhMMkt3ZC9U?=
 =?utf-8?B?MDRRYnBtdnp5TkExUDFURGNtZ3dxbEVIWXMxaC9EUUdzWDIyaWxoZWZzdTRv?=
 =?utf-8?B?UjZCOEUyZjNBRXpUaUVWcTIxWUIxMWdNUkpsVUEzT2NyM2MzdVJ3Tnk3a0p0?=
 =?utf-8?B?YytrODVWOGdnS0Rkb2hsbURaVnMvbUloWHZHdnM3ZWliV2YzRXVUQ2ErVXI3?=
 =?utf-8?Q?+Ox0nwqwM54=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3M3bjZkWFFtT3dOeUtINmZsVXZBaGU4OHNUOElhQVkvRU5ZT2Z2VGVSNmZM?=
 =?utf-8?B?WUZ0WjJCOUt3OEhwM2N2S3RMdlRIemtJYllLVnB4eUNLVlF4ZGRybzdTQVky?=
 =?utf-8?B?WWRkS0hWakVieE9IV1RIN2VRS09nNHlNTXQ3TXgzRW8wby9WcUVMUzJVM3hS?=
 =?utf-8?B?NXFhZTE0Y204eUtGYUlGSmIvTWpsRng0SmhtcHMvQVlJeWhZcGIvc0dVaXNz?=
 =?utf-8?B?UXd2ekRSNUJaV01mbkV1cEhGNlQvNUpuYkR2d3RBc3dlNDJKdlpXZ0w3WktZ?=
 =?utf-8?B?TG50U21IZi9KOEdLSWhGei80cFR5aUp6ejFIM3ZBN0VWN3liT2liVXozK05a?=
 =?utf-8?B?YXF5QXE4a01mejIwbnhjeU02dmR6Wm8xUEZlb1VvNTlPcERGTUV0SHRYWmI1?=
 =?utf-8?B?UG9DMnNFTUh5Y05kb0ZqVjZEeFdWSWMzTTdNYzdWRlNvbDdJWXMzdkhPUEdh?=
 =?utf-8?B?NXZ4a01hb0VqM1h6M2p3Q3N3TzNRRW9NTVFyVVI0MVFHUjBmeUhqRHh0STZR?=
 =?utf-8?B?OUxtZU9uSlBVMU1wcTFGVHo5Y09aaGRSbC9zWUcrQTdVOW9ySU5YcjhYQ3c3?=
 =?utf-8?B?aDVhZUJ2RlFrU2F4dDFSQ0dxYTIzajVXUEtmazA0QmI0ZmxJS25yTEprRExJ?=
 =?utf-8?B?R0ROUjB0eENzcGpYNTlNNzdBdmlzT1B3K2RTaUVYWHorTUVkemNpTHlqOEQw?=
 =?utf-8?B?eFRNWC82ZXpmNXlDaEVFRE1UK3VYdjlMd3dIdFRRQWpOYUJXSUpWYlZvVFhE?=
 =?utf-8?B?QXI0RGQzbUdYOGdnQTc2WU9lL0xTdkZnM2pybWFrclJ1OTFCTHVLZnlkQUMr?=
 =?utf-8?B?Ny9MZGFwMlNvQUdySHZoelN3WHlSVDE4VXJ1K2VEcWMrVUZqcWY0SnBsL0t4?=
 =?utf-8?B?eXc5MkYrSGFlYUFwUW5zaUV4RmpjZDlGUnJKZzVneHdYTVNhbEdJelZKNGJT?=
 =?utf-8?B?VzBWZmJtdVRnM2Y2UXpyY3RHckx0MldaSGdDQm1oVTgvRjZ1ZnJMRDNlUThL?=
 =?utf-8?B?ZEFhMXhGOU85RkNhSENSN1ErOUI4Y2RDK1lDL0NPZjJxemo0aWlMT2J3c2hR?=
 =?utf-8?B?K3pEWmsrQitta25HSTMrLzVCMTlITFB5dVYxVXhLazlEZzU5NElLVXRkdGhU?=
 =?utf-8?B?YlFOWnVSVmpORm1KSVBNRjd0T01JeG9TUGsyN1doV1NZQUczbzRybHhTNWdL?=
 =?utf-8?B?WlUxRzN2TCt2QmcyS3FQR1NOenZtUVB5Y2lacCtkcG5QSCtudHVPSEp3MWcv?=
 =?utf-8?B?Z3ZWVDJCSmN2OFhSOGo3REZBTkEzSkpRanRJaFFLb2ZuOE9wanlEdzBVQlZj?=
 =?utf-8?B?MUNUUkVGKzZ1QzBGWnJBWkxMSTVFUG8rYmNOb2NvZ3F5dFoyN1k4TlNYU3JW?=
 =?utf-8?B?MUo4TjgzaUlER1Fab2ZoQkYxc3ltc1U4QVlmMU9jbHFXclR2V3AzdlVCeVdk?=
 =?utf-8?B?d00yQ1k4aHp3ZFlQUlhqNVpYaEFnWnY2bnZhTXQvdnVSczQxTVFpRDJGT1hj?=
 =?utf-8?B?eU5tTFNDS3VXaWZhTm5jL3JQcnNPV1M0WE1PUitlMXFidjduTUVCQ2FXSTZK?=
 =?utf-8?B?YlZPVm1uWVI5a2l4U2tZc0ZsVWxycFR5RlNaclBKVUdtUHEvbUtjVmRqTXpR?=
 =?utf-8?B?V2wwdjBJOGY1ZDNMeFVvUnZaMGpNNlphUEdIcTRXaGNqa3R5cWlMS0lWdWxk?=
 =?utf-8?B?TGUwbXlLLzM5Z3p6RnRITjdzcGZvU2h5WEpseVprTG1kZ0dqZldtdHRIY0t1?=
 =?utf-8?B?S0tjQTRVT0RzZWw5UmRlQlpzZDIybDBCQkpScmprM2hpL1lXUzJJL2VFUnBh?=
 =?utf-8?B?eGdMQ2Rkb0lQRU1kQnNqS2dvaFV4RnN0cEZYajFJWmVxS3J2dnBQeUVUZEZl?=
 =?utf-8?B?dDh3SFZiRGhCWFFhUFRmSjRQb1lHOXk3SUN4VGpRVWhDaDVhWnZwNytyZW1T?=
 =?utf-8?B?VGJkY1o5WTVnVXgwRVNZbkNGaDA0U2N4cGIzZEI1KzNILzRIeldodGIwMlox?=
 =?utf-8?B?RTBsU1hCMkRhWWdzZDJudFk1OUJCNjBJb0t1cDJaLzlaRmVKa1ZTOHRDWmhN?=
 =?utf-8?B?KzM0N0VxQ25oNDZocFkwclJTQ2NCMUNHbkFDejZ2ODEzbHhxTEphOE9TVEIy?=
 =?utf-8?Q?2pJw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f420cd-5955-4720-4f81-08dcde77b296
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 22:08:05.9843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdFz1IWsMgr6Vvpw4bolxfqrHTY5aQOAqfAz1DRjWdoRGDEgWrveo5ssroIlSt/WblF+I1OJBsXuKLcqId+qAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7408

Some system's IOMMU stream(master) ID bits(such as 6bits) less than
pci_device_id (16bit). It needs add hardware configuration to enable
pci_device_id to stream ID convert.

https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
This ways use pcie bus notifier (like apple pci controller), when new PCIe
device added, bus notifier will call register specific callback to handle
look up table (LUT) configuration.

https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
table (qcom use this way). This way is rejected by DT maintainer Rob.

Above ways can resolve LUT take or stream id out of usage the problem. If
there are not enough stream id resource, not error return, EP hardware
still issue DMA to do transfer, which may transfer to wrong possition.

Add enable(disable)_device() hook for bridge can return error when not
enough resource, and PCI device can't enabled.

Basicallly this version can match Bjorn's requirement:
1: simple, because it is rare that there are no LUT resource.
2: EP driver probe failure when no LUT, but lspci can see such device.

[    2.164415] nvme nvme0: pci function 0000:01:00.0
[    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
[    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12

> lspci
0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)

To: Bjorn Helgaas <bhelgaas@google.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: Frank.li@nxp.com \
Cc: alyssa@rosenzweig.io \
Cc: bpf@vger.kernel.org \
Cc: broonie@kernel.org \
Cc: jgg@ziepe.ca \
Cc: joro@8bytes.org \
Cc: l.stach@pengutronix.de \
Cc: lgirdwood@gmail.com \
Cc: maz@kernel.org \
Cc: p.zabel@pengutronix.de \
Cc: robin.murphy@arm.com \
Cc: will@kernel.org \

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      PCI: Add enable_device() and disable_device() callbacks for bridges
      PCI: imx6: Add IOMMU and ITS MSI support for i.MX95

 drivers/pci/controller/dwc/pci-imx6.c | 133 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c                     |  19 +++++
 include/linux/pci.h                   |   2 +
 3 files changed, 153 insertions(+), 1 deletion(-)
---
base-commit: 4de3972726b32b9f2a807cd415a15b09044f1911
change-id: 20240926-imx95_lut-1c68222e0944

Best regards,
---
Frank Li <Frank.Li@nxp.com>


