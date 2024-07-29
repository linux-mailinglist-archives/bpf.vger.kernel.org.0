Return-Path: <bpf+bounces-35927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2088593FEFD
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E461C210CA
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B41891AA;
	Mon, 29 Jul 2024 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YUYrhZva"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013052.outbound.protection.outlook.com [52.101.67.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7E37708;
	Mon, 29 Jul 2024 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284330; cv=fail; b=Z3imQVqVzAxPuGVIF2tsYme6/GNZWRYUWlovfH2hASLm/QbtalVrNviC4j2KJTuVPPk6IClfqhra3PiMxJpIRn41SrIZ8Ah7Qh4MA41svNXmxI6zy09QmR/H5PJPenv89ukfNg1mT0mVxW/TrYlQfbovO5EuQl7+E7Ukekc4Q1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284330; c=relaxed/simple;
	bh=Ffs1+RB8zVSXRpBvSqedgow8kXkvN9nVsdLWI+U0kAU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=fJu5UjQjg8xRuSTbCmGr0o5+2UxodI0Rl0YWDInGENSWm2uVURPNObEM3ieJleSCO67bQezvxTYPdFYzgeE6SXVxy0U8B7VVcvxzKqtYAQgHQZ0NB8J+BIuU8a01LqfmHQ2IrkEquwmW9WelPI8Zsh+T6UQKUCSOf2Ct9eZSGTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YUYrhZva; arc=fail smtp.client-ip=52.101.67.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ly4d6JDBOhmmRkvBxCw3SL3mFdQecmnoYZ0mqtdSmSKSi9rOnY/9oEfiVa3ePMwLKmCrIgAAELMChicQDszkkqYSdxkde0PHq6D8Qu3YoAwENPhn2KWK2VWUjDj+Nu4nhz/+HK+LTK+XTEmU5dYSP2vBZbB0c2IzxzljJpNsNz/tp3w+eNsqx2Df7C5F9UsODmiikG3jeqHY4JxXeq/ay2Q57EgdPiW6zAYV3wHuDjrDHZJtexpqIGnuk3N9Ryl5RZxgLZP46BZTKxDGgcvgje825NStHw9UcXhQZHTtUgHkyftA/DiJ5lO23HcLikqHysPQtI36lALV4cf5s4QQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgF23gu8zop/1zsRCishfLSSZV7ex2erAzBR3fsZWJ0=;
 b=QELfBnee9vA04SDm3nDoUyCwCZpDyjkc66iZleHJaDa/QCz4h7zk1z/pxOq6gFZLnUJAzEOdCfuOWsahFbbFo7sHjt7ZmzJIPsdz7loJDrf/F+EVPf2fdCe2F1nBYffP6vS9feIQ4bb2O1B7+secqe5lDLRHVOUvm1f8K/YPPAOHhBAyuSYhB5UsZ2Z009YSpSGE408N5w88vlsQ35/TlN08TUcR8N1frNEixrA3ZBT2r4wqlXuPutsc7r+0Qq8WdbT/FYv8GggSKU3Nvg9ukzT373wF4QpeMazbNOiY3I0uG06GQcvkwzg6lI0fM1Rz8QSq6u7ZuQE9qPgO0rc4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgF23gu8zop/1zsRCishfLSSZV7ex2erAzBR3fsZWJ0=;
 b=YUYrhZva376K531UJ0XqxPYo1uzvOYdqnpXm/eyjbupXrLfvpqOxUEH1IFlJxv6GY28exEEQQBX5ViikuPVr3evoc9omqUE2J2eZVg+p81vFnYL4BGRVJrZP3Z+53JbA8t9fOotBK2QcxjlkG9KHBSS5OumHmR96xSmIMRV98Un2yK0s/Fqo2b26WQu6IyaE02AGxaVbKHzfDsX20XKbmep7UKSSqMS5tPSuu/k8aVC2V5adP1yCLdBVGTUy0KDWMquqWyj0cOHLjXrttRoPQl9OH2//doUNYx3cXCgBIhzy7QIMeh+nbwxbeK+i6jo0Fojb+prAr34AW52tdE1Paw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10240.eurprd04.prod.outlook.com (2603:10a6:102:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 20:18:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 20:18:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v8 00/11] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Date: Mon, 29 Jul 2024 16:18:07 -0400
Message-Id: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAD5p2YC/3XQy26DMBAF0F+JvC7VePwasup/VFXlF40XAYRTl
 Cri32uycQF1eS2fey0/WI5TipmdTw82xTnlNPQl0MuJ+Yvtv2KTQskMASUgmmb0CT+/x3ybor0
 24EPgreWKa8GKGafYpfuz7/2j5EvKt2H6edbPfD39r2nmDTSuVdiREEKDfuvv46sfrmztmbFaA
 XJvsVgbwHgVnQ7abK2otizvrSiWQEguXXBSwNbKahUc3iyLjeQJAplyYber/likvVXFGgXWmhg
 cRdxaXa3mh1297gIhR0Fd2+52TbUGDrtm/SsP4Igb2VFb7bIsv3TABboQAgAA
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
 Frank Li <Frank.Li@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722284317; l=6156;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ffs1+RB8zVSXRpBvSqedgow8kXkvN9nVsdLWI+U0kAU=;
 b=F+I/R76AA9lkCiBJWjRITKL3DGltBqAYHnLCApRYj66IMAIi7IMFmEK1se6TwyZD6ZdQPvhKC
 aT6F9xKxK1CCWimEkmj9k8ag3d09kPCCFL0RBx/xcxzdQ8bCtF9UlPP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10240:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e97f76e-3b43-488f-999c-08dcb00ba4a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmdSVVZONzFicmxVaGh2dnRyUWp3MkNPZjdTYlZrOHBidzZNdStnVXk4cm5l?=
 =?utf-8?B?eFhNdDlmb0diaGdoU0p1dGwrMm5GakhaMFc1cENXTlAvRlBQY3kzL0RmeW5p?=
 =?utf-8?B?bFFpSWdqbm9IS2p1N1hySGRrOXgxT3RIcXd6b1R5VWNTMG5FSXVTWkpraXhz?=
 =?utf-8?B?WGNRL2RUSWVjVkxySWNKTW0xb1h0WnIyZ3BmQUsyWitZTVl2ZVkvQ3FqYlJh?=
 =?utf-8?B?ay9VWm1xOXVhL2xzdHp4enJBWGZXaTh2MDFDQ2lNY3h2RWVhSTNaSHcvSDFH?=
 =?utf-8?B?UGRCZWJyWDV2TDhDL3ZLYmZ0Y24vYUo2SEl3eDNBeW4rck5ZbHFyMVA5SUEy?=
 =?utf-8?B?Ri9xYkhrVzlCaG9hYmswanZPa2FGV3lsV1pGT3hPZU1KYmFwVkZELzhySHZI?=
 =?utf-8?B?SHBId2dMdy92NlVnWlJENmZhb3llLzh4dm9QT1FsWWp1LzA2VXlaSUZKSmYv?=
 =?utf-8?B?a0tHVjU0SG1BSlBhVER4aUxpRjRFakg1VnZVdk5zc2NLaW12MlN2OXoyalB1?=
 =?utf-8?B?OWdsZlpxTVQ5eldoMHRxdmNhYWk1ZWZtVzFibnd3ditMekQ3VjBoMmJBa0Y0?=
 =?utf-8?B?VGJUMTFtbklWb2paN1kxclR2ZHZvczYyRmFQd0Vrb3VxUkZzWEEyZnBsMUJD?=
 =?utf-8?B?cDhtb0x4dHlpUzNyTEwwNEY3d0lHWUF4Skt2Zkh3dE9kbUFIQXRwTUVxV1RS?=
 =?utf-8?B?aUE2N2dlZ3pZb25tbU82TUwzT1NIbHdvRFFrNWdxWTdWQWJidE1HOC9FK3ZC?=
 =?utf-8?B?dHlJY1RDYVZCRGhMS2pScHRuUHRTN21GeUo5eFhUTHR4YzQ4UjVEako4a3VD?=
 =?utf-8?B?akZLbFNUV3NPb0ovZkZhd0VzNG02ay9kZWFMSGNPSGNSVUd3SHRseHdrS24v?=
 =?utf-8?B?QXQxd3JIVlQ5QzY1VEswdGVTWUZpOCtPWHV0OTBzVVIwL1p0RGlWcjR3eWhj?=
 =?utf-8?B?ZlVBU0lCZmM0N3Y0WHl1ZFRHTjMxdk4wbFIyTW9nSjlUOE94a1JzVWlQdEF5?=
 =?utf-8?B?MGlpMktjUFg1TDRWZGZncWlveG9pQUdtdlRGeWo5a3JkMlh3SmRqYkJydHFT?=
 =?utf-8?B?cCs0ME1EbG9HNHRTRUE3cmF1ampldW9DWEd1N3BmMFFxK2tya0o1cTBXYlZp?=
 =?utf-8?B?cnJTWU9sbXlGNFd1VFJQNDVid0Q3emg2c25tbUg4QWIvbDZEM1M0Z2ZTQmhL?=
 =?utf-8?B?NzZOZFlaSjhFeTE0bnRBNzh3MVRvbVNlWG92Mmg5aVora1BtdElUa3NXSE1m?=
 =?utf-8?B?bGdXWTNqbEVNbHlYckZTNU9IWFNwcU1Ya2ZGSjhxYlUvbDh3Smgxb1ZkK1Zk?=
 =?utf-8?B?RnZoeW1rVHVadmx4Y1NhYjRWSzNkZnhac09kYWtsa0tYK2hhRTN5RFVQVm1V?=
 =?utf-8?B?eHJ5V1hkV0QxTll5MnRlRnRDc3BORG5DZGd5OFMxUGxSNEhoa05CQVJKMW10?=
 =?utf-8?B?M0d2RjBNeWtER1BOWG9ZWHRDMzVGYVBJYk54WTNWVm9lUGNvdW5HMC8yTmpW?=
 =?utf-8?B?VUxzMU9tTzBqZlQwUEVibHdjN3YySU1YdndUSXJOOFVrdFp2T1ZKV24xU1NJ?=
 =?utf-8?B?UW85ODNxWk5OYlJxcGN1MXZKejYwYmJDS0dWK2hPV1k4UGdXS2lORW9pOFIx?=
 =?utf-8?B?Vkx5WVVQaENRNElPcFl6RExYMWVaVUdUMDlXUmtLL3hqQkhic29SckxIUCtr?=
 =?utf-8?B?KzFzYTFWakIxR2RVQnlhWE1iZEhQWW1yQUM3L3MwNXd0YW5DRnVaSGdUQUV3?=
 =?utf-8?B?ZFdMUXFhVS82ajlWU1NGdlhCOTE2OW9JRGQ0ZUg4QmU0dkhHNDVyWW1NeDZS?=
 =?utf-8?B?NU03T3ZIRlNjcFFaNnZXVDFGcW1DTkdrSkVKWFd3Qlg2eFlLaUpXTTYwd0NH?=
 =?utf-8?Q?WVzBImqGQrElA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1hmaHVrVk1keGdZRWRhTmtqSUdTdGdhYjVwT0ZCZjlKVEdaQVE1MDhxbFZs?=
 =?utf-8?B?SThkeVVKaElUZkxhdEM5cy9oZjZ1RDAyMU5MWS9wcHFJVWQzMlB3UWlrUkQ0?=
 =?utf-8?B?TVhJOFRSM1Y3L0JZdmVpQlJWWFhEYllYUERHYUZRbUtLMlA3TGU5Y3o0S0tq?=
 =?utf-8?B?b2I0Vm1USFhld0NNcGJ2Q2YrOVlhMGNvRmtKNTNQWUliTXVZK1FNVGV6azBB?=
 =?utf-8?B?eFBzWE1CYkZiamlwdFhRWWpsV3JGeHJEMExTL1lYL3kzR2hiOWFmMnlIOTli?=
 =?utf-8?B?Uk9CTmZsSTcxN0R2OG5lZWh5R3dOeHg0S2prckdrZVR5bFA4Q3VON0RRL2RP?=
 =?utf-8?B?eUNjZHJoODhQOEYxWWhSbmFXeFNJRnVrQW81Q3Joa0RtODFKYk9yY0NxSUlU?=
 =?utf-8?B?MUhuNVBPN0VNaTNyMzdlaFRpQmQwVGhZT0dlL3FJU0NMSzNPRHUxdmQvOGNZ?=
 =?utf-8?B?a1lKZlJYMTBVQXRlY2RKQmtLQUZpV3VYQXBxVlRrRUZVNjVJTnhYSDVSaWVL?=
 =?utf-8?B?eXk1SkFieUJPOTdmTHdVckpUbytLaXpNYlU0azFoVzBzcVRzZGlSYjdjbXVh?=
 =?utf-8?B?TXZuellueVRTRTEzbGxKQUF5WGNYM3FBQmFSNkliZlVUS0pMTzY0OW1GdTZp?=
 =?utf-8?B?emk5UGV5L3pOQWphdll2L0xUZFhQUnNEOTlvMHh2ckxYZnpIZUlMajB5eXZC?=
 =?utf-8?B?VS9ZUW1TdlNIZ1pOaDc2TDc2UWwzYWt0dk5UTGlKMXZmUGU1TWduRGsxYUN3?=
 =?utf-8?B?aEIzcGJhTE04MC92VkpMU0htSnpzZDVndU1LdEVjNkw3aHg4Q29YSUFBZUdp?=
 =?utf-8?B?b1FjZEJWcVVuc0YrbTJOdWREeGlNWHhZL1BpcG9USlo1WlVkSUdXZHBBa3l4?=
 =?utf-8?B?cVpQc2NnZVMwcElsUERlK2tZTFhYWlpiN1MxMjNzbEtKMzZiamRhQ0kvTVpr?=
 =?utf-8?B?OHVHN2dLRG5wQU9uQmNxNjJNcHMra2tPQTRvT2lvWGdFeGdGOG1IUzI0Y0dY?=
 =?utf-8?B?SWRQUk1oWkgweFhxczJSSXppK2hJeDVTWU8zeEhjbTlUaFQrL0VzSEVFOHV2?=
 =?utf-8?B?UVFNT3dodDdwLytZeVVFaE0zUjlaLzIzY3haOXVGeStqZDNtQlNROFdPWVdp?=
 =?utf-8?B?bGc2ejNMc1duS3FlNXJDUTAzbmMzdXVPYXJFZjZoSWZKMVRQTE13UkpoNnZG?=
 =?utf-8?B?bGFFa1ovSUs0VlU2TlExWFZNUnVMNlVCMTVmbllhcTNBYk5QVEJiVjBxTnpq?=
 =?utf-8?B?SnlWaTFpRElHM0hyTGx3UnplTGUvbitiRzJjekFOcmdEUDJwYVBzWVRPNVQz?=
 =?utf-8?B?MkRtcnVNY0U1b3Q4Q1dwWTMzN003UzlVNXdaYk52Ym9TbloxeVlEYUI4SXNq?=
 =?utf-8?B?bWlpVVRDSU5YbHA2YjZORFlLemtMMlZLZWdpTE5vK0s5bFk3UHlScUZEZ3Rw?=
 =?utf-8?B?RkxhTEJ0NHVPbjJ2WWxaQkhlTHV6SEZZVDJBSWpNSXU5aDZUbEJCZzBiYWFi?=
 =?utf-8?B?VEMrK0Z1OVRQRWgrTEh0QkZCaFdmTDBtMWt5ZFVuN3IzaDFUR3NQMm8vRFkw?=
 =?utf-8?B?RnBiV01CQkREWE9tdkFFTU53Yk9wbmVzbFRLLzBnK1VaeXNoQmxnSmVDQkh2?=
 =?utf-8?B?T1lUQ0d1dGZMdW1LTG5ReDA3UDgzVFFQZUcyWEVPM1ZLbUM0Z0RmNFVqSkFY?=
 =?utf-8?B?Z0tHNU5aQVBEZjJxbVB6MlQzbDdmQWtBeEpZbHp0SW92L0dBK2FrL3ZJbWxw?=
 =?utf-8?B?QzZ6eldZOVNPNDhHY3BMWGZGVXRIemw3NlBzL20zSVJZRVMzNUxRMCtDSk1H?=
 =?utf-8?B?UXNyTlZJYjlZVVBCbEtlaTBtYUVUWmxoTHVCT0laWDRJeURxOVQ3cjNpM0lk?=
 =?utf-8?B?U1F0SEl6ZTVRU2JBZWJzQ2VoTExmWGhBVWZuSEs5YUVnMlhqWkFDejlZazMx?=
 =?utf-8?B?ckEyZGpUMng5SHJwNnRkNDV5TEpXWWF3bFJHa3l0cURFRkdiM2VzQlpwVXJ3?=
 =?utf-8?B?OUZOd0ZidWVxa3hzWDhjTWlLTU41eHFScWVYaGY5UjkrcksvMW9UNHVWRVdE?=
 =?utf-8?B?eXZaMVQ1WENlT1V4WHhUQTlncDhvT0Z5emtrTTJvUnZXQmlTNXgyYmplVlZ1?=
 =?utf-8?Q?swZX2O4lhrlKJt04vyJCnj9XM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e97f76e-3b43-488f-999c-08dcb00ba4a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:18:43.4587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynlqHsBAmwiqFjtLOXJcwlzBTUwfZXVv4YOIAhJpxMq+4tIJPnmYIeZeC0glBVY97W4dboPe66WAAdQB8ZNsPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10240

Fixed 8mp EP mode problem.

imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid
confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to
pci-imx.c to avoid confuse.

Using callback to reduce switch case for core reset and refclk.

Base on linux 6.11-rc1

To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: NXP Linux Team <linux-imx@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>

Changes in v8:                                                             
- Rebase to 6.11-rc1
- Add Mani's review tags for 2, 6, 8, 9, 10
- Add fix patch PCI: imx6: Fix missing call to phy_power_off() in error handling
- keep enable_ref_clk(), I will add more code to make disabe/enable symtric
- Link to v7: https://lore.kernel.org/r/20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com

Changes in v7:
- rework commit message for PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI 
- Add Mani's review tags for patch 1, 5
- Fix errata number in commit message for patch 6
- replace set_ref_clk with enable_ref_clk in patch 4
- using regmap_set(clear)_bits in patch 4
- Use exactly the same logic with original code at patch 4
- Add errata doc link for patch 6
- Fix miss "." at comment form patch 6.
- order include header for patch 9
- use cap register to set_speed for patch 9
- use PCIe in error msg for patch 9
- Remove reduntant ':' at patch 9' subject.
- Change range to ranges for patch 10.
- Change error code to -ENODEV for patch 10.
- Link to v6: https://lore.kernel.org/r/20240617-pci2_upstream-v6-0-e0821238f997@nxp.com

Changes in v6:
- Base on Linux 6.10-rc1 by Bjorn's required.
- Remove imx95 LUT patch because it need more time to work out the
solution. This patch add 8qxp and 8qm and support and some bug fixes.
- Link to v5: https://lore.kernel.org/r/20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com

Changes in v5:
- Rebase to linux-pci next. fix conflict with gpiod change
- Add rob and cornor's review tag
- Link to v4: https://lore.kernel.org/r/20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com

Changes in v4:
- Improve comment message for patch 1 and 2.
- Rework commit message for patch 3 and add mani's review tag
- Remove file rename patch and update maintainer patch
- [PATCH v3 06/11] PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
	remove extra space.
	keep original comments format (wrap at 80 column width)
	update error message "'Failed to enable PCIe REFCLK'"
- PATCH v3 07/11] PCI: imx: Simplify switch-case logic by involve core_reset callback
	keep exact the logic as original code
- Add patch to update comment about workaround ERR010728
- Add patch about help function imx_pcie_match_device()
- Using bus device notify to update LUT information for imx95 to avoid
parse iommu-map and msi-map in driver code.  Bus notify will better and
only update lut when device added.
- split patch call PHY interface function.
- Improve commit message for imx8q. remove local-address dts proptery. and
use standard "range" to convert cpu address to bus address.
- Check entry in cpu_fix function is too late. Check it at probe
- Link to v3: https://lore.kernel.org/r/20240402-pci2_upstream-v3-0-803414bdb430@nxp.com

Changes in v3:
- Add an EP fixed patch
  PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
  PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
- Add 8qxp rc support
dt-bing yaml pass binding check
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx6q-pcie.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dtb

- Link to v2: https://lore.kernel.org/r/20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com

Changes in v2:
- remove file to 'pcie-imx.c'
- keep CONFIG unchange.
- Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com

---
Frank Li (7):
      PCI: imx6: Fix missing call to phy_power_off() in error handling
      PCI: imx6: Rename imx6_* with imx_*
      PCI: imx6: Introduce SoC specific callbacks for controlling REFCLK
      PCI: imx6: Simplify switch-case logic by involve core_reset callback
      PCI: imx6: Improve comment for workaround ERR010728
      PCI: imx6: Consolidate redundant if-checks
      PCI: imx6: Call common PHY API to set mode, speed, and submode

Richard Zhu (4):
      PCI: imx6: Fix establish link failure in EP mode for iMX8MM and iMX8MP
      PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI
      dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
      PCI: imx6: Add i.MX8Q PCIe root complex (RC) support

 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |  16 +
 drivers/pci/controller/dwc/pci-imx6.c              | 989 +++++++++++----------
 2 files changed, 542 insertions(+), 463 deletions(-)
---
base-commit: c428091cdcf7f368ad9884f8caa68b79cd6c333a
change-id: 20240227-pci2_upstream-0cdd19a15163

Best regards,
---
Frank Li <Frank.Li@nxp.com>


