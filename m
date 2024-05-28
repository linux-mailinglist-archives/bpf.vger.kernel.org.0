Return-Path: <bpf+bounces-30776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F07E8D2513
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B809DB2A710
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C188C17DE14;
	Tue, 28 May 2024 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W/fU7AX1"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3B17DE03;
	Tue, 28 May 2024 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925213; cv=fail; b=m5058LykTXselhRgXfjUwjxhOl8/jNEDafY2ZE3zlJYrTab7MSj9ZsmGI6mjVnBDB8wkd7EbOHrFNXp+ORyjDSqUoDQurzT/wh+9Dj5VwS9MYpIdWc2ATwbM8+4+/ihi1nxUyvA+vcyPQFmSC7NEHAh+Xn2rK6i7tpvicFRgUqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925213; c=relaxed/simple;
	bh=xoXNJ0fJHAePQQUrByL1t4DV7f1MdI9LvJJHe/ZdxUE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TbzdeytQD6fgtpRdjtp5be2caKgkMAZZuHfvc4hhYzkRF1H9L24CkaN8HiWds/2AduOijnBmY2bRoE7CGZKC9BFnwxSJA1jOkbWarGT5rEmKcd2EuziBEihM7HqKvBlEbLlUK75cWRVOt2eaocUs0AjnqIDZKJ3NhTrQAh65/zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W/fU7AX1; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2yDaDXATXVcGLNyzT3ulkXB871m4a9mAWpvy26TnYKlPKBTFY/IH8JkzAl1AkJ74zY6E9M7L60A5Vm65IM/f8RqbOWYgZG4yEJmLpTK3sEtuyeK8WZd/VtOjV1N2/s6ax0PneiCxoGklku0quTD73ISzoZMqKRu910KtELWPMip2+WX3o2csSiPBApvUh1+vGL0dQwNr1e0gtaSVSxAg97UM99ZDVKzxrTOFsGlabXRggVNev3wADsBSA5tUe+Z3G7vUyJc1vm1Sd+GTcs3iO9EAl0XBG3zd8iFofbV94RevDp6FGByfE37fp9kTetz6BXJHJUMyf4Zr1qI2BHJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmy4S6QhQEeuj7lBEuawWfjth1Lb4DCHggXuxkqA3C4=;
 b=DE38Df9OjSrjbFAhilYyaxKSOR7igcu3PQPJ6QqCqwqGMbs8r+ws7j7g3Hgj+Iw5GkpYtYygQKCWWtWjealQ3DN6kaQTPZieKiNvkHzvsL2TBJpKuU5IRxq0SSR2KknAtZBp/wphP/UcjUdgvmY4lboNPUQVEnjfByOeXuFFtY56zCBbOZS03fl+ZxUUvC/dP0PYSBLhq0kF08cTWbVx4fBHTJcZXPVd0szH4oaDiUbuNLIIEcM/7Usod7LVGd3aADmkkEmR/LRsUBsT0WEZaVFAOLDXat++Nce3qeARVhbD1iALEsgej7j1vsAKkYarfYT+cCmCFeQg+hpn1qchRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmy4S6QhQEeuj7lBEuawWfjth1Lb4DCHggXuxkqA3C4=;
 b=W/fU7AX1ZzwaP4vuATHF2gmk49dJkhAVEk90R1LG/GnWwmQWufTqfsu5gTfYoT8k4ffpsr2b6Bf/Y4MngsX5yzhUOyWhbt0XyqA3g5zpymzi/rOI4uZL4m8fCrztUE2vd3AkL5z1hY9FL3ZybnCZ1cCBMEty6dfiLz9tM0EZH6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 19:40:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:40:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 May 2024 15:39:20 -0400
Subject: [PATCH v5 07/12] PCI: imx6: Add help function
 imx_pcie_match_device()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pci2_upstream-v5-7-750aa7edb8e2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716925161; l=1526;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xoXNJ0fJHAePQQUrByL1t4DV7f1MdI9LvJJHe/ZdxUE=;
 b=iUXNXi/woPUDP+oGO6Q9Pn1+lQPpcpgZwDats1iRa5nh59rW4giMit0kwn+KvaOrg6XL1wpI9
 f+ohjdOSOCFAVTEGj2uWtQINpzpRAjeZPz2Phtrt2y0bNHh0/sGVOSB
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
X-MS-Office365-Filtering-Correlation-Id: baf21619-a6ec-4473-9924-08dc7f4dfa4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|7416005|1800799015|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?di82QVdNOWJFQXlqbjU0RkpWTjM3dUxzbDdERGVVdjRkTWNkU1YvcjZWWHpL?=
 =?utf-8?B?MHJlTWNCK04rK0pWZnZ6SC82TmtwSHkwbStVNjdodWQvMENIaENJMU5pTVF5?=
 =?utf-8?B?UUNTcENkbUFqcENsWitxRDNNaUVlNUlUM0c4VGxLRU1WYnp0NW44N3l6TXdZ?=
 =?utf-8?B?YjEyVk9OOFIxMUQyZmhFY1dsWWluaDJ6UEhoQWpPRk9Ba1ErdzBBUnNOWEJM?=
 =?utf-8?B?V1hvblFGUEJCZmkrV1pRd0pMZTdMMFlkSGRLSStwK2hhRjBCemdtVXk3WTYv?=
 =?utf-8?B?U1VnN1kyR2dWcGlLZnU0dTdTbTV0NUVRc09FQTZ4OEZpTkJQTU1xOXpxYS9a?=
 =?utf-8?B?QWVVandxT3YwMS9hMXpLK3MrK21hUis0ak1qN3FBR1lGTE96cDIrcmJ0WCt2?=
 =?utf-8?B?LzBBR0I0R3Y1QTJPWjRQcStMSnd5UFdOUms1Tnc4SVRwdUVKWHdMcEZVbUxW?=
 =?utf-8?B?bDR0bnZ5aTA0b3UwdkdrTk9TaTJTenYydVlKL1paaVNwUnhWM29HdDFrUzlM?=
 =?utf-8?B?a04zVmVNVmFiTDAvVGFjMXEyd2xKMUtBeGNuZ1hqQkF4NVJjSVMrcy9TOUJI?=
 =?utf-8?B?NlNDYnE0R0JBeXZDYnBXOWlhTVQvSkVWRy81aVVOMnUrdURMMXlhS3ozc1hH?=
 =?utf-8?B?TzhHa1BlRzhxODJHbTAyUndpWnJ3dWp5THZTZnFsdFdYdFhvdTNXa1A0di8w?=
 =?utf-8?B?OG5hNlJPdW44anlUVkVmVTFGdEJnU0VMbVhCMmZpUGs1Q0kwM3RveTZENEhV?=
 =?utf-8?B?Z09YWjVxMGVTZUFYKzcrVzhwK0xzSlEzK01FTWk4THVOYWR5R0pZbmRaSGd1?=
 =?utf-8?B?QURmTkk5SldoR0JsRGt4YlVEWktHa1RBdXlhTkJFd1RzM0RUWmozZVAxT1ly?=
 =?utf-8?B?N01yeHZJMy8rQitxQ0JZWGJqY056emN5SDVIZWl5WmFaVXozcU5DM0lFN1Bi?=
 =?utf-8?B?R2xzSm9mMnZyMzN4WkpsNHVqdG5ENHQ5RUduVVdDL1pHTkJaT1BRRjYvV3pK?=
 =?utf-8?B?YjBhY25QaEZick95VUNWYnlCTzlGUWwvanhIc2dHS1JvN1hHYXY0RXlwblNh?=
 =?utf-8?B?cHRPYW5NdVhzVTc0YXI0K2ljSFdGekwwS3BBR2t4TnlnOWRDZmdReUhhUEhF?=
 =?utf-8?B?VzZmSjJlVnQyVGVtcy9wYmJhOTBvYlBtNGRremUvUmhwQ3pwS0xXL3VPSmx1?=
 =?utf-8?B?ZzFjQTczUFoyK2Q0Y3d2MTQwdlpnQi9lRnI2RDJ2VUJCZjFtWDNLb0YxWm1V?=
 =?utf-8?B?T2wyQmtoK25qWENIcmRXMHpvUzlFMU1XdG9wVHNMdEI3U3pHUGRiRzl0cmJ4?=
 =?utf-8?B?V0pTMEM2QklWMmx1RjhsUFp5TXVmRWlhVzVaQnVKYVd0RElkKzlYcVltMXVJ?=
 =?utf-8?B?aVF2aXFsK2tlMzhFUmVlaEh2d1YzMGVpd3BEZUpXUkxjbU0rYjdTcTZkNlhP?=
 =?utf-8?B?TURRL1RNNFM5ZUJjQUtGTmx6MEpkTW40eGZDMXFBOVh0RDNpNHNHbTdYMDZE?=
 =?utf-8?B?QjlRZTlDTFMxUzRjamVmQU1SbGJkVEgrbTFmUWRoQ1pqVGdsd1RyeG11MnlX?=
 =?utf-8?B?V1pxdGhaRERLaWFZSlZ4aXdPbEJUbWtueUEwL09jWDQzdmxkRGtpWTkrM2oz?=
 =?utf-8?B?d3RDMzhHb29LOSt6RWNGZWxHRXlob0hYTWtjRWhxR0xDdTBLb01sWTE2RFh5?=
 =?utf-8?B?ZEd1dk5xemxSSW84U0FlRms4ZVhGcGcrNExpRU92N084LzRnd1c2dGdUbEhu?=
 =?utf-8?B?dnYvazFTNCtBTWR6eUZ5RHdjQ1M3cVhlNFd6NXc4WnhMMDhXbU1od2pXTkxJ?=
 =?utf-8?Q?4LAE0JJHAi2K5EYesQxOx7lhQnE1Hz7G1c8u0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2hUcERYenJzbUlOalRTWkh2dDNuUEZnZUI5di9rZHVSTXhzc3B1b0tMY0Ur?=
 =?utf-8?B?RCtkYXBYTkhWclpDZUVzWVBuNDVSNEUrbG1lQjZqM25VVWc3RGwzNk1ySURP?=
 =?utf-8?B?YlN1L2NCMFQ5MGU1QWJUMkN4azFaekx1MlIwK21UY0lnelUvamZvK20xTHFC?=
 =?utf-8?B?aWZxTTg2N1lSRi85YWxyQTdKaW0rRVhHeWZNM05EWWV3MUhDMzFkaGRpNXBW?=
 =?utf-8?B?dHZwY1BXb1d1Tmc5dWVNNlBlYUN2QjFEUlZaSlR6eEoxcFh4RFpFd01CaEtu?=
 =?utf-8?B?eVg4RkpPQnd4YjNVSWQ4TC9mM1pMSEhzRDdMMGJKWnRRekowbFVqSm41dTVU?=
 =?utf-8?B?OXc0Q0dKSnhyS2JNZDN0aVVqYjQyZ0FsZFF4SnlLNHg5c1R2c2ljREFSY0xF?=
 =?utf-8?B?b054cyswc3RKbFk3TTBMRndJZFIzajhackNpbnljaTJmSzJ3NmVnVkJ2Qzl4?=
 =?utf-8?B?MFBBejNiaGJzZHZmbDNBZlVXd1FQc3ROZDduLzFzOXNPdzRFc3hYYjFVT3Mv?=
 =?utf-8?B?eml5N0lZeHl3eGR4QkdrME1WVWhEMlRPbGJITVVMYkhQQ0VGMDlKUUMwODlD?=
 =?utf-8?B?UFNUTXdWb3RaSjVNN2tuYlZsdk9talpjVHgxSVg4cWRxbDB4UCtKbm1UYjdM?=
 =?utf-8?B?V3Y5WVNZMXhsZEdDUCtRM1BhK0JMRHFQeVFsTzg5MVJkM1dLSjIxODdTWUV6?=
 =?utf-8?B?MERGdVFTeTNtMXpObVpOUU52blVJZ2xXT210bkFNQlJnVFVhbGJndWZGQTM0?=
 =?utf-8?B?OU9SWHRHM2lKclBzNVpxaXkxaHY4WHZmUldydGMyRW1wMnN6WTdCYUVWN00r?=
 =?utf-8?B?a2oyZjJOSE9vQ0drWXJVeTRmR0xGS2ppN3JUU0dRbjJEWmNZaGU5WVU1bHIy?=
 =?utf-8?B?b0hKRnRBNUJubTJPbmVBOXl2dk1PUndZK2l3aSt4eEt2VU96ZjJhN2gyV203?=
 =?utf-8?B?OG9jTW16cFNkSHpRdGNpV3U3TUNCMDBZZmd2dlNrODlRSlZjOHZnUUFyZ2Fo?=
 =?utf-8?B?V0x2MWZ3QnRQcThIMGRQWkVzTkpoTnlrV0hzL2xzR0lTL2JzSmczR1JXYllP?=
 =?utf-8?B?ek5JVWNUamhxTmYvSnQxUkdkOWNCZHpOYlgzQkZoRHp5KzArckNGMDVPTVhZ?=
 =?utf-8?B?NDFib3YzdWdUY3BBeEdNR2VkaFgxVHhyV1d4cDVlK1RJNDFPZUVST3B3QlY1?=
 =?utf-8?B?cUFhZjNZUm43NTJ4Q0FZUy9TdXZ3MFFJcEZFSDVRaDBYZ0RHNGxHQU4zcGFW?=
 =?utf-8?B?UHNTYU8rNTJhVW0vRnN0dGNocHlXaUwrV29hTldDY2hqbTREbWIwZjNtWEpj?=
 =?utf-8?B?OWlhbitVVkRvRCt0aUNKMUxsaGY1WHhFQkRLVkQyNjhUMDNVN3lWZG5iWmlB?=
 =?utf-8?B?dUw5bmVwV2o0REVJVHNPbWhXYWV1aXBlMVZuckFmdHdLSFQyU0dwWE4zdVRD?=
 =?utf-8?B?cDZKVCtNenBkOTZWRXI4cVB5aVovYm1pSElaQkZDUHJUQ3BheW5DYXR0VFdi?=
 =?utf-8?B?K3FMQ093cVpKcW5xVnRkN2Nsb1o1Z1ZCUTVxQ1Z6LzBrcmNtQ3gvODAzQ0JS?=
 =?utf-8?B?NU50cDFramF1cFRveU41L2pJUGwwNjhpV3pGajdaSW9QUEpWUVRsdzRDSXVt?=
 =?utf-8?B?QTlDdk1ESDBwVnhWdEJJSVMrRCtYY3pUS1NKdmpwMkRLQXY5WFFPT091T3Q0?=
 =?utf-8?B?Y3dtVTBVeURROVFLaG1KNHQwWjNQZWQ2YnB6TjJFbzhwSW1XK1BuUUNvcVNu?=
 =?utf-8?B?U01HMHMyb3VLNFpWWlNiSTN1TTcwa0NyeUlzWmhkOWcvKzA3Z2M0YTBOQm5p?=
 =?utf-8?B?VlFXU1ZmaFY3TTVPTDVleWNWY0QxU2lsbWo1OThVWUNxU0tvM2sxalNUR2Ra?=
 =?utf-8?B?NGVCcnFvK0JOUkJXTzBzT1hCU2M2NEZPQ1YwMnEwN0dROWlXeGZnUVhCSEFV?=
 =?utf-8?B?TldLWDFvMDUzQlRTa0xuV05tTTV4TGdoWDUrTTRQR2liajBKTXkwNkdoVFkw?=
 =?utf-8?B?bkJvTUY2czY3ZWdITzZweTNTVW9OVXpBY2JzdnovbXNlMEYzSzJMQWx6WExp?=
 =?utf-8?B?SWF5S1V1bkpJZ0ZIb0xBU2FCZkFJbnJXY1FSSGFnODZpdjl6ZGF2Zi8wSFkw?=
 =?utf-8?Q?S/Ns=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf21619-a6ec-4473-9924-08dc7f4dfa4b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:40:06.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jL9DGuE8hboVwFs01ZdqUK2dz7MLzJhPNavv9vzpw7ewJsUP/DusJnwQXUCS2ogZaQppMAPKqegQLuM2KWrfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655

Introduce the help function imx_pcie_match_device() to facilitate
imx_pcie_quirk() in verifying whether the device's bus driver corresponds
to the IMX6 PCI controller. This addition lays the groundwork for future
support of ITS and IOMMU in the IMX95.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5533b7ad0f092..29309ad0e352b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1646,17 +1646,25 @@ static struct platform_driver imx_pcie_driver = {
 	.shutdown = imx_pcie_shutdown,
 };
 
-static void imx_pcie_quirk(struct pci_dev *dev)
+static bool imx_pcie_match_device(struct pci_bus *bus)
 {
-	struct pci_bus *bus = dev->bus;
-	struct dw_pcie_rp *pp = bus->sysdata;
-
 	/* Bus parent is the PCI bridge, its parent is this platform driver */
 	if (!bus->dev.parent || !bus->dev.parent->parent)
-		return;
+		return false;
 
 	/* Make sure we only quirk devices associated with this driver */
 	if (bus->dev.parent->parent->driver != &imx_pcie_driver.driver)
+		return false;
+
+	return true;
+}
+
+static void imx_pcie_quirk(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	struct dw_pcie_rp *pp = bus->sysdata;
+
+	if (!imx_pcie_match_device(bus))
 		return;
 
 	if (pci_is_root_bus(bus)) {

-- 
2.34.1


