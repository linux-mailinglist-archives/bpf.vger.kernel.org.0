Return-Path: <bpf+bounces-34108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BA892A806
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FC81F21D44
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402514A4F0;
	Mon,  8 Jul 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sMRj1QS9"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428115216A;
	Mon,  8 Jul 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458558; cv=fail; b=BCW6UAz9eXwxXyz/ZDGzYyGXZYt0URXDJtNlxchzntIP6fV3RGOOURJ/n+eJvikzb310zeozqOMMWPvstY9+QA4V5vzeTHR+G9hBNN0qhgkwN1IDAndyx1ZNc35nB33v6S80IKqtzLRfSDG8YDD+f3jr/4GqTh4N8CxSVk4YVe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458558; c=relaxed/simple;
	bh=3aNGqHlOMNr6i4SFVYb1me/IgqHGDiN1jvYfErB5JwM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YTHejI+8gDmdgE1Nq1EBrlbdjqYQXb8gFyr0a0EydFWM3PYx7Mx4rR6BNZ2kkGmMVit71KxPEuU+vSbkAfbKR66zC/nzazsTE50UE3K7Vg7C5qP1UltewDrCDnRUZSavE+ezuMtq+HJnsLOEnQ1Jxah6eLhafd+g0272j8o4BaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sMRj1QS9; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVH5yf0SW+0NXDKUUZFX3/FRhhVYUmj9qKJlBhuSLPIa5D0yGD8DmJFWdQ94PmdKvVscub7Wkul7+7jE9uO7IidfVErvEBDtwf6CTu/ucZid73F72OxZ++isdLpLQCkrIalXRiHfVK39xFqWmVt9n+GyBGz9uDVbJrXMqUHTx+40K42U/FkTP8RYTrqc/5tLyxocfSenCEYzYQ4YIfJeUzR0sYWtV/FHAyILqy+Z2be9jzFv0WTZ8RWkC/yHndu3Y0jl57xUJb1zt1d08UC/1L/kwvmBPRbtrFbcrgLswMHVsi87d3lA3Dld5+pOfkslpe0QKMgKyn9ZRVKY3KBAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUsi8PtQ6ZoYIQbcE1/BBFOJeawxB66B13RTY3Vv2Ec=;
 b=CvqIE4bWtdBgEMftMw3d5Ye32TMXkJXfsvkYdtF7lgfyePNUcK7HSWh1cBTgTmtyuYQZQzXMKMwaNQ2nPfkP/SRxMDYEn/7+ahkPuyAH16NGoHVgUM71ERJQMgmcVcf1UIqmxLdPVRvLUn9pFpIlArAF57AoHG4BCXondYjPrxC0tYVJaTuFR6xc+NDbGQ0jIa9a0hhWa0hI4AxJ0owtcczdBbfSdTlACdHpeFpXf9bxjFO2VHRecM8qUSX/xJnEO78ahsGVNQEeLdFGUMNtH7MeBaLX+zNO68BgtRouX9ltnhoRapeVN58aqTnZqeB8kEQePqTx5umTRfZIoqi+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUsi8PtQ6ZoYIQbcE1/BBFOJeawxB66B13RTY3Vv2Ec=;
 b=sMRj1QS9eJNElOKKSCKx6S9Np/Vwo0taUMZ03VTvBO0GOtyyHyOYy0PtoopWlRnnvcjYvxqi0QK9/0l0H/1dSGCLK/Vym2QsM3kEf6os96HyD0j7yM8RRG1cp+5yK/vHgnCXt7HJz4laXLywXCuk3xvvfvPdYyrRcn0D7/VWnJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 17:09:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:09:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Jul 2024 13:08:13 -0400
Subject: [PATCH v7 09/10] PCI: imx6: Call common PHY API to set mode,
 speed, and submode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-pci2_upstream-v7-9-ac00b8174f89@nxp.com>
References: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
In-Reply-To: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720458497; l=2547;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3aNGqHlOMNr6i4SFVYb1me/IgqHGDiN1jvYfErB5JwM=;
 b=4zaUhTYSpwb0Zq0TEZaxqr/0QfUBioLO725+K0h/QUyguiRaqR9ovTiYk1zgxHjfReTWBrwy7
 oUR8hdGU1stBc08gSNTV/Oqc7XhbqxbvpzXogmuzP9PMZcxzHgnQBHT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edbb483-7aa0-40b6-6d53-08dc9f70b139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG1QSUJncXUyVXJMeC93dTN4eUp0b2hMbDhnSEpDTnpXVE1lOGx4YlU5Z2RW?=
 =?utf-8?B?czBQalZVTkt3RUdUR2QxeFI0Mzd0U3Y5elJvNi82RWQyWXZ4VXJSbTVvN0dt?=
 =?utf-8?B?Zi9EV21NNEROQXNYdUZhcW1QK25yYjludHhXV1BpUTVXK0dGdWlrMjlnejBS?=
 =?utf-8?B?ZkVyQWsxR1RmSXFRMEw0WXgwdDNabjNqMUhKV3VxeVo1d3FiVDJnT2pIUzRC?=
 =?utf-8?B?Y0lTKy84alVoU3lINVpVYW5GOVdrTnFEdnl3RHhaTlVQb2tMWmdZSW1FQlc5?=
 =?utf-8?B?dVIyTnJPMFBnTUFWNmtvdGxGazN6OEdlTDRzM3d2RXlHM3dFU2tpR2NwQk9j?=
 =?utf-8?B?Q3BhZStVKzhHMyttUVJJSDBVRkx5K1BTaUFzbjJ2VjV4ckdTQm45RGtDWTRQ?=
 =?utf-8?B?bC82OFhuVTMrM3dReWZ1clZOV2ZOMUlxYnBqMU9paWxFRWdtMnFyd1g4Vzcw?=
 =?utf-8?B?blI0VHZqSTgrL3ZzTUtYbUo3cVlScnVrdkNKeTgwN1lSb0hvQm04aDQ5ZGpM?=
 =?utf-8?B?VlAzVlBubTRmYmdjaENOVTNFN1RITUpPT0g5RUt0VEs1UHFLczl6QU5zSUh4?=
 =?utf-8?B?aWVhWEdtdEFyaUE0UjFNUWRzODkzTXFYUDFGWk9jbXdPM3ZRd2x5cGtSWkJU?=
 =?utf-8?B?UXo2cTJGMTg3MkZYdlViUm05T3Y2OGx1TUh0WlYxeVNobjhLcWY5WThGU0l5?=
 =?utf-8?B?L0w4Ym12N0FBZHp6dmdsbm9ERVlSeUViOS91czRCY2ZYQTBOcFFmTmt1bkFM?=
 =?utf-8?B?UzYrL1kzQWlHMEluYmZDZnhOaGhSRkErV3hmcW5ET2JYZU5aZXNSWWRreFpL?=
 =?utf-8?B?NFZiN1NvaXhsNWVobG52L0FkQnVDaHRCemJObE0yNzRvckdyOUhBTElZOGdP?=
 =?utf-8?B?R1VIVXlKOUdTbzdUWkVIRGVpeHBRSGplTEwrWGwxM3VhaUNieThjZjdLNEwr?=
 =?utf-8?B?dDEwTVFnZVYyQ1lzN1hRaTVyS2U0Y3JtOWhSdUZBbWw4QnJOZFh6Y1JzZUM4?=
 =?utf-8?B?RWNwbjFMQXdRWThxaVh2VFdwZUxaRzJYeTZSd0VraDZNV3JweWlhVGdUYXNO?=
 =?utf-8?B?N3Q5N3lNT3NPc2ZXYVN6RXF1SjVxV2tNSDhKSEhCQ1NkbXRROUNwYjhIZXdl?=
 =?utf-8?B?NEhqOWdxSTVHYVJjaGJEeVYzM09hZS9HQ3l3SmRhUVF2VDFtZmROeEU4UklT?=
 =?utf-8?B?M2psNEFxVGtrYUM1QUoxYVN5Z2ZWWk1FMmpYTjhoS2xBUGVMTWlUNWdmb0c3?=
 =?utf-8?B?VDE3SmVBay9zeUR6UnMzcXRjRzY3RHNmbXQrUDhIUlVSSm1JMFhxSEUweDdB?=
 =?utf-8?B?NDRzK21wUnpvRjFEYTk2V3pWQVdhcldHbHZ2NEJ5U3gvMVRjaXY1NWo4UFBp?=
 =?utf-8?B?MWM3M0xKbUtQRldFSTRnNGFhTVFXYXZzNHE2ZFRxZ1RyWDRJMlFYQStJdU0x?=
 =?utf-8?B?Z1VtK2swNzdqVVdDdnFiYXZGWGwyQitxTkFmT3dzMkNMMEhuK3g4ajR1SGNX?=
 =?utf-8?B?MkNidmo2Wms1QWUwK25wUnRBeGIrVUhnNXZDUkpNbTVEV1pLcGl6bWloY0pN?=
 =?utf-8?B?b0cweGR5Y05hU3lnRXk5RDdMa1UvNW9oWFJzVk9UVHpZc3E0cm40MEJlOTZr?=
 =?utf-8?B?VUpuME4rVVlXQVcvWmpBU1ZqdW1HWHNzSVY5aGRRZ21nQW90RXQraXJjQ016?=
 =?utf-8?B?aXVacWZIWVo2YVJYVExiT0s1TUJoYzQwRzhSajJTU3M5UUxPMnFQeWJqU2VK?=
 =?utf-8?B?Y1N6ZU0xSjBWeUhEdWZhVWFBeCtPOGFZRENZVmJyN3JMdDNHbDBkUG02U1FG?=
 =?utf-8?B?eWFOeVVQKzF1SkVhc1JqUzBGc3RwQ1NtMzJTN2s3ZTQ0ZmhLQnVVckVCZmFU?=
 =?utf-8?B?am5GNTJmZHZvS2NtL3VwK29wZ25KSm41UVR4Wm9oSVRoV1Q3TCttdnNIMldL?=
 =?utf-8?Q?czFkh7j9nDI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mlc0MlFkY09PTmxpWEtyUVlGUEMrS0RMZTNNMnEySHNqb01rV3EyNy8weHlC?=
 =?utf-8?B?V3FySTFmZW5yeHhWKzFaN3JMOElhSEJ4cmN3TWkyaEdrSmR1ZVROdGlQT1RP?=
 =?utf-8?B?ZTJDUHdWdHEySE9CNklkZmR5T0RkbzdJU3pkQzZNWHdPNEpTRVpORmJTUkxy?=
 =?utf-8?B?U3dTSWZlRUtKR3QzYWM4eXZKa0VrbDhCdVcwazFzM25UYjhKUWhVK3pUa05T?=
 =?utf-8?B?bEI4aFhiZk5TTmFKemRhU2psMzJ5cTRZeTNsVWRlcXVFKyt0Yk9TblpWN1RG?=
 =?utf-8?B?Sk50cDFkbllKZnVkOVlORy9PYU5ENEx0QURsWnFXMlZWR2pMditLcHNXSWRr?=
 =?utf-8?B?cDRsaGVnQVJOVVoyL1ZxS2c4a1RzWXNRZUhGMEduSFlCalBjbENPVlNMR2ZN?=
 =?utf-8?B?UEpjQVB6MUlkbHk5b0FvWDRJZk9kaHlNV2cxSm9JWVdyMnA3UHRaUHBvTmJZ?=
 =?utf-8?B?ZFZOdWVDc0pIcXNiS2h4ZUJudExCb1VNVmE1V3BBa1RCeUtPRVVZZE9DNWFU?=
 =?utf-8?B?OUVnV2pKT0U3MDRFS0N1cyt1QXRqLzlqUVBBa2lTekVPekpyK1pqUjhoTlNN?=
 =?utf-8?B?SGQ2YmNtRjR6K1F5SmFvWWlNOHgzK0xRemV5Q29nczBwelFpSHlkOUhETkpx?=
 =?utf-8?B?NG5iU3VpVVlmSG9Eajg5aFlhcHFPZ1Aya3NkblIwRzdDVzBQZU1BTlJXZWUy?=
 =?utf-8?B?eTlpM1FGKzJYa0U4SFZBdFUrYlppMDEwMHc1Z0FJNjJ6MmM4bGpwMVI0QXdu?=
 =?utf-8?B?QkVMQTg5cmp4eEhqOGZUdHU2M21RQ05xRFg4aEh1Wm9VMGgrb0pNVE9UNy9I?=
 =?utf-8?B?cHdWczg2SVk3SU1Sako2QUVRREhndmxxTzNWVFErNk03dllaUVY4VGNKb1p2?=
 =?utf-8?B?UldSY3ErYVEyaWVacjJSa3lRMklsK08vVzJkU0tzUXVIcXIxclFLK3pwY3FR?=
 =?utf-8?B?UFlHL1pieWtzc0NGNndTRjd3c0E3ZW1qNk9lcDZxd2dlNkdoWDB6RUxqeWZa?=
 =?utf-8?B?YWwwY3E2WnhUTHZHZ3hLWmxVOUIrSHVta21NVVUrOWNzZzVNNUVOOGFiRmE1?=
 =?utf-8?B?MnU5RkJDQWlhQU9ObWRnaDJNWnVqaVowUm54ZFBWSnNzVklXOHd0b2FDMVZk?=
 =?utf-8?B?QmQ0YldyMTVZZ0Z6MndST1pscEZVdjVNdXBqMEtIVURiL0pHcHVNNHYvWVMr?=
 =?utf-8?B?Y1ozZm01NWhESVhNM2ZMQ2ZibmU0a3J3cFdMZ1RiOG9EbWpZTTBwOC96R3Zw?=
 =?utf-8?B?eEYzbmhGOWJLRmY3TXhFdEM1c3VUaXN6Z0tERjRLT1cwSzdJdXpONkpyU281?=
 =?utf-8?B?S25XUUdXL1VNYjNCdUlRYVJUYWllS2xJRDFiV2oyMWZhMUduM0dGOGhNTEc4?=
 =?utf-8?B?b3I4emh1cCtmcEt2ODlYdDE0SnRSazltNVBNeEdFQkhGSWRRNUJCaUxja2lL?=
 =?utf-8?B?TmJJNmp2dnJGdExwb0c0UmozTWlOTkkrMUhXZUltU01qNXphdVRDeE00ZmJl?=
 =?utf-8?B?OUZUUVBGNE5mbWdBZGdYdTJqdlRwOVEzejlGWm9pUkRYZnJlL3loRHl6anIy?=
 =?utf-8?B?ZVlCUXgwY2Rkc3U3d2dkMVFqRmVjV1VSQjR5bEdsdVVQc0xEeU1WSDU3b0t6?=
 =?utf-8?B?R1g5M2NJemQvd2cxdG80Y1pRRk5CcVFQSUxwR09TbWZKeGtyTG5jdVIvM3Z6?=
 =?utf-8?B?OFdPb3BNTUdRM1RpNlprZDREM3l0WUE5My9ja053aFM1MTFxdkIwaEtMclZH?=
 =?utf-8?B?T3lCU2RuQzhZamFzZUJoa1dlOUtBY2RadXc5b1BFZlY1dGM0YVlmaytmenRu?=
 =?utf-8?B?aGdlaXB6dytpUS83M2IvU2Y0dDM3aGFZVXcxM0p6R044aWlFSmxkN2pDWkhL?=
 =?utf-8?B?bkVEWlBpT0pCK1hEV1ZjVUVOaXp2Z0lUSXNzZ1FrUldQZnphaGRlUGg1cWVG?=
 =?utf-8?B?R2tOOWJWVDZRU2M1SmRsNC9DSFdRQU9jRjB3R1VGVlpyVDBheHVFenFHMnVp?=
 =?utf-8?B?MFg5OVZ4RHc1c1didXBKdzNlYVh1emRvQXlLNWcrOXMrYmVyRnlTbFdlMlE5?=
 =?utf-8?B?U0M2Qmg2QzJ0OU56bm80UFlRRXBuRTFLK29NZmIrWTFsQ0tmeU5ZeCtWRlRJ?=
 =?utf-8?Q?lnyU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edbb483-7aa0-40b6-6d53-08dc9f70b139
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:09:13.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+ZrDtF/qpHHMuSa/UJcMzR8AU9L2n29bPVtwvTgeoEYjomoPJzWwLslT78+PdQ+Ey/aggb7yO1xuTj9smI3Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867

Invoke the common PHY API to configure mode, speed, and submode. While
these functions are optional in the PHY interface, they are necessary for
certain PHY drivers. Lack of support for these functions in a PHY driver
does not cause harm.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 57814a0cfab8c..c72c7a0b0e02d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
+#include <linux/phy/pcie.h>
 #include <linux/phy/phy.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -229,6 +230,10 @@ static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 
 	id = imx_pcie->controller_id;
 
+	/* If mode_mask is 0, then generic PHY driver is used to set the mode */
+	if (!drvdata->mode_mask[0])
+		return;
+
 	/* If mode_mask[id] is zero, means each controller have its individual gpr */
 	if (!drvdata->mode_mask[id])
 		id = 0;
@@ -807,7 +812,11 @@ static void imx_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
+	u8 offset = dw_pcie_find_capability(imx_pcie->pci, PCI_CAP_ID_EXP);
+	u32 tmp;
 
+	tmp = dw_pcie_readl_dbi(imx_pcie->pci, offset + PCI_EXP_LNKCAP);
+	phy_set_speed(imx_pcie->phy, FIELD_GET(PCI_EXP_LNKCAP_SLS, tmp));
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
 				   drvdata->ltssm_mask);
@@ -820,6 +829,7 @@ static void imx_pcie_ltssm_disable(struct device *dev)
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
+	phy_set_speed(imx_pcie->phy, 0);
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off,
 				   drvdata->ltssm_mask, 0);
@@ -955,6 +965,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		if (ret) {
+			dev_err(dev, "unable to set PCIe PHY mode\n");
+			goto err_phy_off;
+		}
+
 		ret = phy_power_on(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");

-- 
2.34.1


