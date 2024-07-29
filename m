Return-Path: <bpf+bounces-35930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0329593FF09
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7720D1F2278D
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE63418D4B8;
	Mon, 29 Jul 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GYLbNRhv"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF94189F2B;
	Mon, 29 Jul 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284347; cv=fail; b=NkRqhSb4BLiVH1GRt/dMt8NuH9xqzxMstNkZVRa+XqPQ72vXvq51ELaYZCVBTu0y32jtkOBEp6IZck8OuSndQJDiSaZLff+JYnjbH2Y39MuPI6y6ViMiZRh2uVmV5gx2ht7ZBNhBisybDUnTZFSl/LbX6RtWsbuLhKeFHp+oQHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284347; c=relaxed/simple;
	bh=YJ3hjZthXXzphaK3hv8FaNx6snvHLN1pAh0ZRKuyMgY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=e1BTjebrxRYA8YAjGJ2s9aK1O3KppZkxNQXrZiIk+1Nl52eV6xtq8/UqI9tX2Q+s8tAQxFPr4HLEwBctXoKBveSmgKwq03M2c+ijGgSy3jnJrpqgjwwil3ackLsRzUOPy4YsnnJY7DFMzk8GKqWPctE8/8j1eIPJv0oW1cEMBBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GYLbNRhv; arc=fail smtp.client-ip=40.107.105.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTigqMGE2kJKAZ2EDGZnIcgCC8pOdeejKS5mr/DVDnAOJsT19rCsvK5fTvzxAYRjwNUdEeP3HVWQwiTTuaroRns0P4jff7UIupZdP4iBwhUklRdSj5VqtRDgVvU89YE6ME1rrsVRUpp+Z2QjFns3Xcyu2qJwM6ShNKSei//sIjyhxgoeJAGIhRO48lHM/9oCM0TmyzW+NQCy/sXxX5pvOBJedWyK42tjFx3afaAacl4QmI5zjCIM7awyu/Ya479I82F9+feIueCCQuXZ7iz+yEvWzhlBrjiB20aZdXdxjubgc29ij4SQ+wV5zJQim2LX9uVo+7T5JZfWc4Csu6mRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/ED5YZ2FyvpBvvH5Xw7f4z7V/rcD3E2Y6xkiZJeXxg=;
 b=lY2CN+T2kknzAMnC4BBet42lL/LZcK0w1lKHyzN8d4jWhtqoX+y8PcG8bGMEdgRwzegmknyqfizZtULHjzKG6X+wlTAHxGBAWQn6KQ7dEtgOGJQJops0fVgZSpVejxcML2BJ6p5MBZMIxxZsjal6lUlQprUVdulrAQXiG8X2M9eRlYmRLCDPzMVyIwgny1McSHo8a05gHhoUvFcaOTPX3fGoK1q2ZmnjszgLSycgxbGi80KZBEow+gCzOySX+yenQcxUT6cLpzH6zw8eu07XjFbGB7dTv/yQp77vvSPLUfUnS1HDcGwiEXVYMpeZIVIWW+UNZ3JwEkFuMVOiKWVGjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/ED5YZ2FyvpBvvH5Xw7f4z7V/rcD3E2Y6xkiZJeXxg=;
 b=GYLbNRhvIUfDH9vcyzzuT1Uwcw2jyqXRRL08PHsQsWVnH4XEjELDon0HndSeJaTL1rW9Zyxaro6MCB9F57HU3xBL/qfG/kcCZ4sQcGS42b/e/Uz8og4ttrN+r2PPWBCnDYU3S6G7AxOnpCkT9So2HsgoyqrhCe/5CUAoTR3lfScHoLiTZwX350JbVBCAL3bh+nblFIg3+Iy+66bNlVT9pCEei5jWK/j3e7G6btupkpU18ALy9Wytn6zb7A7009Y8BlLCLv+HzUKACnh9M3z9YX+K1xiHh13rsrEPCXD+S2yk9P2/oT5ta2qPBZzdkjsS8xB/FNaxI9X1lSuttMVTBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 20:19:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 20:19:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 16:18:10 -0400
Subject: [PATCH v8 03/11] PCI: imx6: Fix missing call to phy_power_off() in
 error handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-pci2_upstream-v8-3-b68ee5ef2b4d@nxp.com>
References: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
In-Reply-To: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722284317; l=1233;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YJ3hjZthXXzphaK3hv8FaNx6snvHLN1pAh0ZRKuyMgY=;
 b=McwapCnzcWGzLgj5Jo+5YVQ87aDIGv5Xv81/R+RT9HUykd0aR7XfeS2pm+/JR92l0g7J5y+jb
 CTKd58TtbD0Cr9MMJsrdTZ6PXgb8DFMzEVhb4WxJs62ox596YOHOMH/
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 3434539e-b732-4c7c-aead-08dcb00baf03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmtjOHBNOVoyT1V4K2xNbDdWc0FaUkNRNyt2YWVtTFhiUHVKSnFLTGF5QlR0?=
 =?utf-8?B?MGhsN2Vac2c1N0Jmd0lURTA0MHJLeFpqUGUrZjJIemQ2TkxldTluRGxJbm5H?=
 =?utf-8?B?VUZHS2RxUWtkamVzaTNDZTRuUDcyZUxHWW9vN3Bha0ZvRjg5dTdHNlZCUVJH?=
 =?utf-8?B?cUJKMXcvb0s3TkIzcVBmQmZhNnhXL3l2dGRSSk9HSVF2MXJVUUdNVEgwWXpr?=
 =?utf-8?B?SUppbU9yczRYcGdSY05kRTRiMzlrSVFkTVRpa1RVS204ekhpbmhLUWRScUtM?=
 =?utf-8?B?dVBiT1pKRXdYbWhlWEw3TWNkT3VHUlNxV0ZMMnZlSVY3SXVHTjFFVk9ScWU1?=
 =?utf-8?B?eXladVp1WmFIYXRZbVhyaldDY2ZQajNra3VwbkNqRFFyQXozN0dJOXd2a2Q5?=
 =?utf-8?B?ZHlvVk56d3FjaXhQZ0x6cVZhcWdhc0NTYlJuc1pqMHQzWWwvc25PY3BKWC9S?=
 =?utf-8?B?MWZDL2J3ZWRQTVY3VmJOc1RuOVVXbjgvcGZMSytjUXdqZmM3QllmRXU2RUhs?=
 =?utf-8?B?NzNzVi9rTHluYTF5R3Z0eVRZZzBIYWd0d01menJ6Rk9XYUd0dWZWL2JYbk5H?=
 =?utf-8?B?Z3NsSER6aWVaMm1GN1lFQ3pKcDFDS25KTStaV3R6dXZlNDhNL1puU3I2a1lq?=
 =?utf-8?B?VHFJWXhtblBwazQrcllRbTEwM3ArU3VSUlEwTlBFTUo4bFZ2bm1MWXE5WllX?=
 =?utf-8?B?TDhQaFlSVDg5SWFHWk9xaHBSTUUrWWlLMlV0b3g5Tlc1Y2l3M3RrY2hjcHlQ?=
 =?utf-8?B?bjlLZlBKaWI1QWt5L0JRSmVaNFpDS05RYmttR3R3WDM5MkpnTGRTRDIrRWNI?=
 =?utf-8?B?VWRwREdKSnVteUNBbjZNdzVVZWNxa25VdW1BcEFTSG04cDRsYzEvMXI2MWgy?=
 =?utf-8?B?RlNqNmd4aUxTM29vQlh1NSsyUm9mSkhQQ1MrdHhvVWRPN3Q1QkM2RHlmQXU4?=
 =?utf-8?B?aHh5cXRwNXpReXR6WE1PMEw2WGlCdC9NMWZaRnBEVGRxRnhIUzJTME4zSnBw?=
 =?utf-8?B?RkFJRHYxck05TnA3VmNrMXU1WndMUmJYT0hPbmdhUE54UHdqRU80S1hrREV0?=
 =?utf-8?B?MWdYaXgreDRNSElRbDBncGNJa095OVVxdC9zeTlWS3pFSlZCS2RTeUNiS28x?=
 =?utf-8?B?a1puZ3RoY1hnWHVtUTJVT21obzVPQWY4UmJoaFFtbHNacm9hOC9oWGFZY0Vk?=
 =?utf-8?B?eXZLbnF2YW5xVnRuTEZlbkVZTDhrdURNM2lSaWFUM0YxZVhjYXpuYWVsUDlE?=
 =?utf-8?B?c05aTEU5YndPSFAvakZlTTJXU2EwcGRZTkJTWnFOSTIrMHQzU1RoK1p0MjUy?=
 =?utf-8?B?czhwTFVic0IyQ3M5bVRUUVJSS0dEUGtoVWMzd1c2Q2hSZXZoS0crRGU3OThS?=
 =?utf-8?B?Nmp0Mk9oWDN3RWlKS0M1OVZTSlRsTkFHWm5wZUxLWDUyM1dEeW9oeDREWE84?=
 =?utf-8?B?bEN2Nk1QWDNOVTFqa1R6TUtQK3dBWlhPZGRVY1g2NTg4NXY3bTAyVk1Mb0Nm?=
 =?utf-8?B?djF0d1poeVlyOEtXcHBZVG9QWURQSWpXMEFjZ3NXWllRUkdHRDdneElYeDVP?=
 =?utf-8?B?SlJES3lDL1FKblN5QUdUdkM1cXJUbFp3ZWV0RUNjdnYxcEsxSDlOV2lmWklw?=
 =?utf-8?B?MFBiRU14TE1PNWRjSkZYK2xEY05jSFd0bk14V1hhTll4R29yaG1wSmpucDdS?=
 =?utf-8?B?ZFNORDRBRHMxZG5mS2RtOG5oRUlVRUpsMVdyL2NXZFVVU0xDbUExR1VjbHN1?=
 =?utf-8?B?eHRDbzhpdU9hTjBIcW1SeU94dVZUdEJ6N2E3cThxWm5yaTlXQVVRUm9XekV1?=
 =?utf-8?B?eGZNQVY4cVBrc3o5MVdta2FwWmdwK3I4b0J6S3J5R1htbWdqdVN0NFBCOFl2?=
 =?utf-8?B?MTg4NE1yZEllWlNRVlhJaHU3RjhCVTh0NWtFaTVnZ3d6T3M1UVo2NTEya0FE?=
 =?utf-8?Q?Qk7IU7p5pjs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEdIN2ZlL2kzZEhqUSszeFJtMjVJTkZaZ0czRFJUVEtXbkczYWJDZ1Y5NDhM?=
 =?utf-8?B?bTRleHpYVzQ2ZGVOZHVKdHd2TW83d1JyaDJlNVFUcW8zTTE3ZGR6MmRhY3Bz?=
 =?utf-8?B?d3p1eURrR1JESlNPU05OblFrZnhYeWMvczJCeXJYT3hGSFlCLzZkVnlOTWxw?=
 =?utf-8?B?NFRMNWVia1owRnBmbEFSbVQ0SkJyVEowY2d2LzJIZURrS2pEZFZ0eFVuKzVl?=
 =?utf-8?B?RWRYKzYxRFhjbDRXTnR2Unp0cEI0WkFBUnpzZm1mZXJlcUowdXBIQlE3YWxJ?=
 =?utf-8?B?bmNGclZRWU5yS3VOOVJaN0hpb1k1cDZ3c29mK1ZHTmwzZUZDQmpSczJ3ejJR?=
 =?utf-8?B?Sk9vWGs5aHZIOE5YMGhOVWNTMXpSWWw3S2tGdlV5NUtrT1pwZzROb1h5M2R4?=
 =?utf-8?B?bWFVZlF1R3cxZFROU1dDQVhydENuUTVWVElZYWRpdXFLdzRYMDBUTWNuQ2Ry?=
 =?utf-8?B?SEgwZFNyZmVlam5GMlhGcFdVdmpCUmhwNWZsYW4yQVhmeklWME5INXdMdXpv?=
 =?utf-8?B?b292OTMwSnpWMkdYTGErRmpremNJSTllWWNxVDlDWXRMeWtIaDcwVVRWd2VJ?=
 =?utf-8?B?ZmRKdzVuQXQ1dmFvcEdoYjBvRXVqNmpHK1VTcnVIK29pbWRqbGdqUS8wRlh3?=
 =?utf-8?B?czN1K1dxOTBDc2U4aWRzVlQzcWFrbldxTWRCTUcvZ1VjR05kMzlncjZNUEtj?=
 =?utf-8?B?ZlBwUjdsSURubU1pWGFpYUwyNVRONVBNWXNGYk1zdzhLVE8vaDBjWVFsSFBW?=
 =?utf-8?B?V3FVSFpZT1lPY1pHREdacGpBRUN1N3oxeGxvSlVPdmtxekJ4dDhKUTBxT1FI?=
 =?utf-8?B?TWFJNC9xYTZvN0hNcjF4K2pCMnhtY0NqSDFhSlFiYTJJSEtBSEdib2luSmlQ?=
 =?utf-8?B?Uk1leXFDbExLUkx0WmgyWFF3NDVRSmkxcmpJeGR1V0FlMnhyVXZvS2NJTXcy?=
 =?utf-8?B?WEN0OW5mN1loMWc4VmkxclBBUi9vQVVIYXFyWlJvdld0T3lZclQ4Q1dQU0lE?=
 =?utf-8?B?dmhmUDZ6QzJsa3cvYkFhZVZweis0OVdoc0JKeVJOUFpJOGhjTVJtd1pUUW10?=
 =?utf-8?B?TCtNRnQzM2NSTExVMEwxdnFVQUxrNUdaZVRrZmx2aE5xejR2aHpXbnNwUXRZ?=
 =?utf-8?B?bHRMQk1VNUJtV1FCVkZ3TGdUb0ZyU0FsNVYzZmhCb2pNN1h6NWd0d2hZYms5?=
 =?utf-8?B?WUhXOUpWdjJzcERTRHh3ZFQrYlJDS0YvL1FKOUd0NHJRT3pvRWZwRzdVenlE?=
 =?utf-8?B?UURUdWtPNmVJNDRlWk84Y2JCcXIxaTUzYzlNbU9Hc2lqZGljSXpRL1RTUFdE?=
 =?utf-8?B?dkNHdVV3Rmp4RlU0TlpxdzJOa05aMEZBSUxLVTgyL2pEclRWSmhsV09oaXdh?=
 =?utf-8?B?anBlVDJKenduOFQ4NDExaEhXRjJlZmRhR2daQjBBQ2k3U3ZJOWRaVUdtTjlo?=
 =?utf-8?B?aElZK1VaNXd3cmh6QVllQVZVT2plRmM5UGtZTk1xYXVVRzVMQy9jaVJlRFps?=
 =?utf-8?B?TjJ1S2NYRjBKTTB6VElQYklsclBPR2ZuWlp4VjArbFd3MzBlTWQrandiT2VR?=
 =?utf-8?B?M0x0dlNpdzdWWVpreXlkQ0dBZXNzU0cxd1I1YXpseHNpUkIxTzErOGtaWHFi?=
 =?utf-8?B?ZWtwQm1mMXlWNmRzTnVNQy95NmNtamV1NlUyZTBvQUJkbURZdDZkS3Z5TjVL?=
 =?utf-8?B?d2FFYTFqR1NYc1ZCSmgvUjA3ZE5VYmh1dVNnVk5rVlZpeVFaZkZmazRBY3pk?=
 =?utf-8?B?MzNtcTZtNDBZZFNlM0Z0WVJGK0pyYWlFTFQ5SkM1NFlpM3ZlZE1Mc3pqeHJZ?=
 =?utf-8?B?SW5DeGwwOEc0YlRLdzNFZ0poVGNOSzdvcThwcEJLaVBwQ2o2eDA3eXVaNkFj?=
 =?utf-8?B?V2hBcnNpditndTM5RWp3dTBJNys1dFNUMlozaTBWcnhLNXVMaEIzb1FnN0lm?=
 =?utf-8?B?ek4xV0ljN1IzK1hka25USHFZb1JhdkJ5Z2RTa1V5dU9IY2xDYlJ3YitEWkww?=
 =?utf-8?B?L01PY1AyaUNYY01HVk9rdW80YzhNU3paaHJqMjU4SDFUbm9tNUxUZlRTZnlF?=
 =?utf-8?B?SXJGME9PaC9Ba295T2EvWGNpUEc1TnVPS05MakpqLzBwYVlsZmtFYkJsK0Vy?=
 =?utf-8?Q?5P2YDbf0OnCww7Ia/Ga3cADrq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3434539e-b732-4c7c-aead-08dcb00baf03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:19:00.7840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7lrulLe2I3WDatlV3ppcpSpUHxcEiV0np9iMSSJZ1NtHuqlmPPtWh0gKa5dpQvPp7dWszZ2jwd7+dYsjmqbHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382

Fix missing call to phy_power_off() in the error path of
imx6_pcie_host_init(). Remove unnecessary check for imx6_pcie->phy as the
PHY API already handles NULL pointers.

Fixes: cbcf8722b523 ("phy: freescale: imx8m-pcie: Fix the wrong order of phy_init() and phy_power_on()")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3b739aa7c5166..eaec471c46234 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -953,7 +953,7 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 		ret = phy_power_on(imx6_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");
-			goto err_phy_off;
+			goto err_phy_exit;
 		}
 	}
 
@@ -968,8 +968,9 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 
 err_phy_off:
-	if (imx6_pcie->phy)
-		phy_exit(imx6_pcie->phy);
+	phy_power_off(imx6_pcie->phy);
+err_phy_exit:
+	phy_exit(imx6_pcie->phy);
 err_clk_disable:
 	imx6_pcie_clk_disable(imx6_pcie);
 err_reg_disable:

-- 
2.34.1


