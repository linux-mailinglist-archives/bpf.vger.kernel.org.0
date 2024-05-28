Return-Path: <bpf+bounces-30780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED898D2504
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D881F217DC
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D5D1802BF;
	Tue, 28 May 2024 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bKliTQbM"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4A1802AF;
	Tue, 28 May 2024 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925234; cv=fail; b=f2umooPj86q8p5tbd4yn36SFH1UpVEYILs7ZbCbBZ5rYSjRBHBV78aU1cFHBmKYGBpxFiJIAfAl5tK6Hqvmp/v6TWhdEHdhllQWlHAiQBnQUtskad0YMcQCUhRe7kioTg+4zSQhY62BJR/maAGpXApP2mDmip5HSbRzeCsBqceE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925234; c=relaxed/simple;
	bh=yaBb5frcbXHTqJflSEnujAuuV0Cuk9LQ2ZU996mjQOw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OIwk7cbWaxO89xrHPVrichq7qgC8rhldM/ofzuXlo5D1Ra0uBVQcnrnfZEt2J1c0wUaaZpyowBJt0Np/Mw0pY+9gN3LoVibS/RScyT1MD89faQWqnO/M3mf3qSIxwUOoNbIgcsn8/VvKiKu2DYkhc6zu+ywMkACv8BUqlAC8tyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bKliTQbM; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQLIDBdpoAia3qUGiDigeW7fO+Ayas2wXzCq/m9z7kN7gfDfy6rlYxZyImY6v1JTzGLbfbnsna0mG/3w5NMTpEVreB57aWj/mu3jiyxksEkzaHoTM4IuQSGO+Ncf9UGdbGxjfsvuMWSiGAlK1FxoqJDo3Po0PoVORVBYlyBrIBYMydl6Nx27qrHAYGBiaJkBLkkeYcObzudJkkbJp1v9dr6CqtSecMOsaog7CIbzpQvIlCrBy7CxX05Y7mYboglV5qDc3O0XdA3ud3FiXa+k8Amnv1yGAGNBJ4UiyiZU7+bCivibXS7h8zA9iSVVvZA2HZAb9SITRbu0BXPgE+6Ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cr8a2OtZJWrim4Vtd8B6aDZmDsKq+lJ4vIK5XEvazZc=;
 b=L0kiOB1BjAFFGWXBZ+o95NSQntxJg2gsLI3KLkO9JSM8XVqsYExxve7YeIFiaReQRvpa57v/oNCtSP4Q6bsHw35U0Sf0+cmEKi5zCv5UaJMUmWup5Il/KTj3zMNygT+TZASnYgYdzhY97sTliqLcn5OSTNC45Z3ATojHjfoora1l5Ck9OMjkS8fgNBPHJCg1pleHHfJ2VUlibyGsSbKtQYY8BQMjqVeCDtlPlRfj6Gv9P1IbQSTKkVzHsyAQOeh94tb2DVPGtQ8sjExYTJDo2nsM5XJ5K+yf4NhH7DCiNTcua4BtS1sLBikxkeNKs73wHuvtmzukvMKLyaPANIPS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr8a2OtZJWrim4Vtd8B6aDZmDsKq+lJ4vIK5XEvazZc=;
 b=bKliTQbMrikkrjbRNsm4p5jjeSpttim1LdCdJGqiKzQT2l1S9wsy/th33vh1aIT5BdFUWm/5tL1bWoIGMBnIx13Nx2DJCe9qLRonng6PZ1Oh9iS6wn8VmRo/xq5PZGm6fMTwvf6KuvpDv9dWCf51ufMGqEVVUuk4hEGT/KOANWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 19:40:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:40:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 May 2024 15:39:24 -0400
Subject: [PATCH v5 11/12] PCI: imx6: Call: Common PHY API to set mode,
 speed, and submode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pci2_upstream-v5-11-750aa7edb8e2@nxp.com>
References: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
In-Reply-To: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716925161; l=2344;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yaBb5frcbXHTqJflSEnujAuuV0Cuk9LQ2ZU996mjQOw=;
 b=KPjigMZM/5Tck8+akEzRLrnGJhJjNlccMhb3gLqFSW8FURwFBzwVk7GH3yEkPCsvjMdX8eeJv
 gLunL1L8gxRA6LQECfgvgYoAT06G3txiz3oSuAIZ9+xbhHxzz9gJN1T
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fd5fe2-77b0-4cb4-8cb7-08dc7f4e07f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|7416005|1800799015|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjQwb2VkK3ZMV0JPNHp1Mm9NSVBRaDJaNTRkY3JyQ2tzUHRNWXZOMjV0VE43?=
 =?utf-8?B?eEZaMWk2VWZ0RXJWcXRHbFRwdnhiZUY4SDBiU2RzZUNjb1NjczRPa2E3N0R2?=
 =?utf-8?B?RHhJUEVwVXllQUM3WCtSdjVrVDc1WXBHbkJKWTBMaGo5YmloOStLdzFheG0w?=
 =?utf-8?B?MStibU9Ld05yMVhDQVdvWDFXckVxMEVjOUd3RGdFRHNvSjVuUTJEUG9Jd0pP?=
 =?utf-8?B?Sm9pcHpmL3pmYjVIWTBUam9nL2lXWkRQNGVxZzFqdHdwRkhGSlg0UzlaamRy?=
 =?utf-8?B?b0wwUmZUVTFsenRCVStXYjBLblV6b0g5bmtuSXZoVmp5eVRIK0RTSFRNQ3FD?=
 =?utf-8?B?OWpQVjd3RFN0dzNyZC9uYldVY1RMRGdKejVoN21kSHBmNE1UbTJFMXVBUzlI?=
 =?utf-8?B?SlM5WnN2bERUMTdCT2xnWDI3M0N2MFBhaGhNSkwxSkN2eTArUE54V0xIUlhl?=
 =?utf-8?B?Rkg1bjlJdkFsTlJranJiOGdnWmttaHQ0a011eTluMEJrMm1aZnhzbEx2bGF3?=
 =?utf-8?B?aHNjbXZsU2pGTUU1SGd3emxyMXVOTER5cTNueUZ1a2V6WkppYTRDdXpPbEVW?=
 =?utf-8?B?dlhLOWhyRDBKbHRoOHg4UXlwc2FjbjQ1cWxadmFZZE1uSXp1STVYZVUwd2NZ?=
 =?utf-8?B?aC94Z2RQNlRZUTJoV2dSU3dMMjFESEVuZW42RnZ6ZVZsYy8yVzRQUDJuUUNh?=
 =?utf-8?B?dHdLRkRBL2Zxa0h4TWhNTnJzbnhMOHIwaFFRQ0JBVEFhaDdIV2gxR2FVTmtE?=
 =?utf-8?B?dlp3M280eDNQVXY5VTIwNHluZHZpT2kyb0tpcTF2Zjk4Y0luMVdnU3d3ZjV1?=
 =?utf-8?B?dDN6ZnB3MXhXRHJ3di9CZGsxU0pTY04yblIwV1JyciswQ0dESlB6VitIVEE2?=
 =?utf-8?B?U0NYTkQ4aFBnZTFZRjJxNmNsS1hoelFnWFNTVTMrbFZLYzA1NnBlUTBXb0FB?=
 =?utf-8?B?YnR5MkNnWWFyMlEwSmZnN0lrRE8wd3JKZmUrUlRjWkNLbHlEM3d5aklNWVRq?=
 =?utf-8?B?bW5PUXNkUmhTQ3FlRWw5SnROaFpvZDhDamZFaGZxK0xpUFRJYk9DdUJxUmZp?=
 =?utf-8?B?L2x3WVBHYWlCQTBRNDA2eWx6QWNlMDhYSkdXZU8yMGhVSVdxMWllUEg4SEZD?=
 =?utf-8?B?VnkwSTQwTU5ScXREVUkyd3ZOMGU3R3ZlQzZkTjVURW5mOTlEbk5uWmczYXJQ?=
 =?utf-8?B?UUxFTzhCb2JTclZYanVKTTRVd3YwSTlqRzdicnU1MVdVL1ZrZnA4YXExb09V?=
 =?utf-8?B?ekhZaTg0dTAzakZwSmdkRDJWZGVOTHpmZFAvWmxXeGRYK0pqUDNBbUlLelM5?=
 =?utf-8?B?bS9MMVIvMU1acnkxcmZvaU4wd055L2R6TjhYamNDZHJQQ2FJK0RoMHpoSEcv?=
 =?utf-8?B?bW0yV1NwWDY5RDU4eG04UytuUFdqbHFmNU9UUGkxZmwzTThrMHNDYWNlV1Bo?=
 =?utf-8?B?bFJldm9peERQUEJ2VHkwUmVSeHZLU0ZVSkEzcDhQRWkybnV3ODBKNFFmM2R4?=
 =?utf-8?B?eTdlNTg4dkNnQ0ZmNGlmMFo3NGY5WCsydUpjWXA4U1FWU25GVHRHekZ3Q0pa?=
 =?utf-8?B?SzcyNDVRd3VXY01uc0xra3FUa2NQaTNOQTY3ekVVd25QMjZjYW13NHBURDRX?=
 =?utf-8?B?Tkx1eithN21JRUJSdHorYWRxcnRLajFRN29rcGRqT2I2NXJURnRpeGQ1ZlRD?=
 =?utf-8?B?eElzak5tSk4xc3hyRGUxeTRoR05hQVBneXlDUGJoMVZHYk9uMjVCLzB1WFMv?=
 =?utf-8?B?Tm5oSlczSW5QVElVUmRlMEpjTEhZMC9UNXEwM1lNdVpGaFlSdmZtQXFJb2tZ?=
 =?utf-8?Q?/P4zLQf84/ZE2SMVjkAfkCv4tg6SWElV/k11w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z01IdE96WGFVN1NRMDl4V2cwd0RiNThzaTl4T043eWtiWUZaQ0lTN1NwUnM4?=
 =?utf-8?B?SUFYYjJMdlp3ZHA2VEJYa09YKzNXSW0reDMxTFcxYUxpVjc0aGpqS3ZiaHJq?=
 =?utf-8?B?M2E5SXhHWkFoSktkQmdiWVlKNFlTSTB3VEdiRUhQc2FhN1g1SDdkUFBOMDJ0?=
 =?utf-8?B?VUFwU2NLaUpwektkMVJwSENBVFdYeGxJTE1ZamJEbk54N2dwQ0M2Tk1td0xD?=
 =?utf-8?B?SUZDVkdRa2lXR09JL3p5Mk5xekZDUm1XUzdtWTdJL3dLK2lTVlUwTUFFb0hh?=
 =?utf-8?B?UUJ2YTQ5djNid2V4SWNqN2lqbFdUSVBrTUJZM2oweDI0S0tZdWduNjFHZyt5?=
 =?utf-8?B?b1RJTDZveVoxbStyTy8zTkJ6SzNJUFdoeENiMWdWdTg4VFUzV0JNU2p6ZDVk?=
 =?utf-8?B?dzQxb282cXFRSTEvdjRtU21JR1Yvcy9Wb1J4dGNuVkYwcFdOUDBBa3l2RUhh?=
 =?utf-8?B?WXRrOGJqSmZGd2NmSlFjSzRtaFhMSjNlVkZoSXV5ZHRxRDdDV0tYbFY4b3hG?=
 =?utf-8?B?VTRUMHJEa2VBYjl6U2x5S2VYRlhaYnlhNTZrdnQ0Z1liUmMyM2NtU0FsaFVo?=
 =?utf-8?B?aS9wcGsvdytTeDZwRFprZWwvZDFSSk1uVHVsNllvRndtcVJ4bDlFanl6NVpG?=
 =?utf-8?B?M0Z1TGdxcjQwOHRXV1BFYUNJOVI3REJLdUQvN09udytKWkxQVXo0dDZQelo1?=
 =?utf-8?B?dGc1Yzc5dUZZTnpENml6eVRnYU91VUxrZVZTVmpGNVlCZm8vNXZCUkNycUp6?=
 =?utf-8?B?RjdnWDVudEpYVFhNbWhlNVUxVHBMMWhIaHkwUWp3Smp0Q245Z2pUd1l0TGJa?=
 =?utf-8?B?eWlSclVzSDFNTmJoUHd3QmN5NTB6RWt1Mm1KeDB4MXgzaWpXVTBWeFgyMFBV?=
 =?utf-8?B?YVpFVkJFcVVBdzhtMjVRV0kzYS9DME5Id1J2REsxZlcrNEIveG0weXdscy9h?=
 =?utf-8?B?M2pnRFNJU2tTMG02aW9HV1JyWUlEeXRtZTR0Q28zQ0xJU29IM2JWNm0vcEZB?=
 =?utf-8?B?L1BXTjZQVDFUcDJKWEN1Vlc2STVwTWMvZklLTmEvdWVzbEFydUJNVWlKdjU2?=
 =?utf-8?B?NWFaV3NBQlJJYU1lZHpPOEIxMzFiODl5WXNtQWVqTkVFbGdTUVFnWWtTWDlv?=
 =?utf-8?B?Z0tNSkN4ZHk5QmRNeWtBa09WbW1YMGlhcEFNWE1Hejd1OVRVZlovZ0ZuajB5?=
 =?utf-8?B?NktJYnlpU0tMdlFHRHRXanhmeXViaGRqamxibEFiWEVXSUN1MEsyV0dFTUEz?=
 =?utf-8?B?emcvaTRwaEVqZVBDMW9TQXBrcTAxcW1RaWM2QUlPVXJqWEhQTVNsdGRMMi9V?=
 =?utf-8?B?SFVNb0ppaXhlRVoreVlDZVoxUDdNRUhQSUswUlBOVGpHemhhcWFZdkRQdmNq?=
 =?utf-8?B?a245THpPWFZCQ0dQSUNSN1VzUDllaS9wOHdSZjJRRjhOV25WYkRNNU42WXpN?=
 =?utf-8?B?QkNqa0tOMVNmeFhSRnlobHdBek5HWWlSb1cwRGY3dXd6c0JQU1VvdU5Salo1?=
 =?utf-8?B?UHBmMUMzWDhmRzZkSjNBWDBMZWhJWml4QThmMkxPTkRUMEJDcVhPakpkZGdm?=
 =?utf-8?B?cWMyemU3SXJZaFNQenVEeXlYOVhmUTZPRS81b2Y4bnVnVXJObmlGcG9zU3px?=
 =?utf-8?B?VThUQmRtaCszcVhVMVhjYVdKOC9JR1JWR0E3d2dqZFlOemN3Y3VPekFqRGp1?=
 =?utf-8?B?SkVDL1BNN21tTUJRcktSRDZCTnI5cUc4MUF4MkRFdGpWQXBTUG1RU3pZeUhY?=
 =?utf-8?B?WkFNSEp4OHlCeThNZDZuK0JRaHUxcllHeXY2M3Z4S1hLNEY1RVdNU2hZNFBR?=
 =?utf-8?B?b2VCNllPSlVQZ05Fa240OFpYM3dZWHdObFd3Uk10TVhROEZBOE8wTGROSnE1?=
 =?utf-8?B?b3NDeTlGdkdEOEZiL3JvZldYUnRlZjdPQjFoNENXTWU4SG5RdFZxQ1g2QWlE?=
 =?utf-8?B?RVAxVTBoUFVkeUdYV0dHbUtYY3FGTmpHRitRalVDaWV6Y0k2QVlIb0p6bUlr?=
 =?utf-8?B?ZkoweXlIZFNFRzAvL0hZMDlMYXJRd3ZQUzF5amxGcUNYdXM2Q3RucDB2Rk5K?=
 =?utf-8?B?anZsZHRncmcwQjFycUtRK2FSZVhxVUlVQ1ljUEJ2RzhGdjFheXF2NzB0emdY?=
 =?utf-8?Q?rNV8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fd5fe2-77b0-4cb4-8cb7-08dc7f4e07f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:40:29.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1VQtrhDKX2cmpwiC2F3hAPmxFkyoyZNh71uU7qhoSny+UEVCah9BVIWqLzqIyPvYTF25eif5TC+J7r/GkkiJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655

Invoke the common PHY API to configure mode, speed, and submode. While
these functions are optional in the PHY interface, they are necessary for
certain PHY drivers. Lack of support for these functions in a PHY driver
does not cause harm.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c8d58481f80dc..5a725ef6ed0cb 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/reset.h>
 #include <linux/phy/phy.h>
+#include <linux/phy/pcie.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
@@ -306,6 +307,10 @@ static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 
 	id = imx_pcie->controller_id;
 
+	/* If mode_mask[0] is 0, means use phy driver to set mode */
+	if (!drvdata->mode_mask[0])
+		return;
+
 	/* If mode_mask[id] is zero, means each controller have its individual gpr */
 	if (!drvdata->mode_mask[id])
 		id = 0;
@@ -882,6 +887,7 @@ static void imx_pcie_ltssm_enable(struct device *dev)
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
+	phy_set_speed(imx_pcie->phy, PCI_EXP_LNKCAP_SLS_2_5GB);
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
 				   drvdata->ltssm_mask);
@@ -894,6 +900,7 @@ static void imx_pcie_ltssm_disable(struct device *dev)
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
+	phy_set_speed(imx_pcie->phy, 0);
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off,
 				   drvdata->ltssm_mask, 0);
@@ -1029,6 +1036,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		if (ret) {
+			dev_err(dev, "unable to set pcie PHY mode\n");
+			goto err_phy_off;
+		}
+
 		ret = phy_power_on(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");

-- 
2.34.1


