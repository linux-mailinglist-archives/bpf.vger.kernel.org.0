Return-Path: <bpf+bounces-32343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D2590BC06
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFEF1F21E7D
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6760C199255;
	Mon, 17 Jun 2024 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WPb0E5Bi"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2059.outbound.protection.outlook.com [40.107.103.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6F19D095;
	Mon, 17 Jun 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655496; cv=fail; b=A1TqgXdLkj+GSkkqEFu21+R5pXHdvsXBM6BleY61/Xj+f4OCzS74dVNOoqBnjlYVSpTW3vvbXjtdHyhOFQic/0eNpSDwmsruAyThG3LIL48c+G38xB+SB+J5ACg4f3osWXQBfCWpjQZ2wqEFBM5mLjTeSon+F0tVC9vp//m70CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655496; c=relaxed/simple;
	bh=oUE4Xraffo59G2Cwd8H4tTqx6L0ogBtrTELPu1EChAY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YrPVMoLbhecbhtutGCATCJ09QgtN1WcVEXZNtjEF7uXU/iK9gpt+QO66EmwdRRSq4Th3F60eqzeOr1xpPKhfueI1AUI5a4vB1+4QrHN2Zpjjzt8UhO/6uPmysprH2w6V+YaL/gV6Q2WH9jgAd+9Mx/5xI/ZzdRTuDPZdi2QEtaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WPb0E5Bi; arc=fail smtp.client-ip=40.107.103.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miUfPUbOgaE+M0Jd9mJ1tQFsR7bzG30M1FN1DdZusX1S3x5capQWeSi3Dzgm+/158HsKqEqmsGLWMGYBWicjcfAJgc/v1l3gAgJX0eLEEiAfoKo3f2RQYMit7UkuhavFu56+DkDo8/xp9m/8lYNReYoU+7KLu0hd5rX5uif1gOlwBLN7ZT6E+Ef0ckzZli3cdQFjVoArkpbggl4++RgpvGCxvQdNWp6K+uRsypEJTIv7xXPm6lalwAU66Hfo5gn4hW62v1zBBKHjY818jjW5kQuOrCm1p82Bmbv5TENlBa1hvPVGOfmmdGwsyq9xfwSnE5+3ri2SLhfdSs6BlzhE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC7y+lP9FT72dkYcb1wFYmrUmi+o7+nTwO+CyeeNizk=;
 b=B++CxYH84rmCcUwULqCEN0vfOAYM54VfkOPvyz2Trjwoai2uCRP7PIEZvssQYwv3XE2MySRc2K8szItNDrTPP1P91YB0yvFokBw3kA+jWSFfQMjdgpSQZMIdSUqq8jB3cORFYPme4Pvp3/CING8lTHOpJ8daCmjv7KTdPkA7OpZdu3oeA2FamGk0Lfn/xA0IVja6uBn2Q1OH6fMCtWj066kGT1AHHilohNR0ETZ+V3wqTmDSQkH2hs1Ihicbr6/GeeIHlohRPhdUi0nMapfIFNvTSyB7fO5IeTMzUEpDImx4+c5Zsz/oo38UyiefZBwuki9HlHoYzSBv6uKc1djBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC7y+lP9FT72dkYcb1wFYmrUmi+o7+nTwO+CyeeNizk=;
 b=WPb0E5BiAC+nF8acv7WB/lLnlNE4X1D1mBpIUgL7cMyjL0bSnY+8A6pRHCJjIBar9cKpVSdsIAnSK3fLGi85mrXzK324qm/YHodl9EMOvj8146/DcX5XL+gydjVK/Wp+xarYFqUTti8sjFhDzCyWiofooqaTxyZpCFhX0Q3Rk2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:18:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 20:18:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 17 Jun 2024 16:16:46 -0400
Subject: [PATCH v6 10/10] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-pci2_upstream-v6-10-e0821238f997@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718655424; l=4310;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bs2t+q/XMnPn03SopOxTsr3xZ1eWXCjxU4EhUtgm1ZU=;
 b=nuwisvUxo56sAGjhNYVjrLNsb+zYdTaBYmKUjoGmQB0yr+t7sVHBh1P63o3bx5jILtqnq6GnK
 EKu48i1nnXRDd5Ma/6kCUh78xH0CuEA/BEy3MGTSznspk+PW3bnpA9W
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
X-MS-Office365-Filtering-Correlation-Id: eccbf4b9-5b6d-47b1-70fc-08dc8f0a9c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bi9NYjhra0ZpNkdXbnV5Sk9ScU5XQVlTTXJIV1A5S3ZjNnZYVE5TTGNBWGZH?=
 =?utf-8?B?VVJUQ214d1kzUWtqbVEzOG0vclVLWHJMMVhjVzZ2TUovaTZRd0dYVDF0dkJa?=
 =?utf-8?B?NElWZEJQUjNpckJqVFhOQ05oamMyTEZjWGNKN3JlOXNxV2lJcHNrQjJYZ3dJ?=
 =?utf-8?B?YWNVeVFrYUdxbFlTOGhjUUtRYnpwUnhCM3VRYTNtUE8wVlBkSnhRRmZNTitM?=
 =?utf-8?B?WnRjT0ZCcUFnQ2FjM2tPbTNkRmlnSlhLT3VtcWFCNis5ZjdUZUMvRmE2OUFB?=
 =?utf-8?B?ZnZYMTE3NGRzRmRGdWZnbSsyQ01TUFVwby9uaHdzOHhUbHRQNHFzemk0TWFJ?=
 =?utf-8?B?UjVPUXc1VXpob2dKNzJKR25tRWUvYUc4U3ptbm9zWmZHVkcwcVF2YkJWY2VC?=
 =?utf-8?B?LzVjOHVsd09NaXdwTlViaHRBTFN4ajhnclBWVkY0VGNxckJMWndndWRRbUor?=
 =?utf-8?B?bGQ3WDZKVitOb1diakxRak9iZ3N4YjFhb2c5QkpIdU9wN2cvNGNZTEVscWw3?=
 =?utf-8?B?bEVFM01BdWs0cDBrc0FCUHhSTGJ0bUYzSDJaVVZmZlVHREg5UHhZVWpBVDZS?=
 =?utf-8?B?SldvakNQamZRTWVxM0xLODRBVEhxZVNuQ1Q2K3lldXVwSEtxaUI1bStjdDB5?=
 =?utf-8?B?bGVnTW1UdDMzVFY0dTNhNFNzMEcvbEgzK2pEZUVmRlVvS3VDN1k0YXptN2hm?=
 =?utf-8?B?bGowVHRuR0V0MUVFUWpDZ2pTUjNISmxmcjEyaTFYc1FYaHBQTEdpNUVwUzFu?=
 =?utf-8?B?UEYvMENSUFVELzBTcTZyeUFVMzhIcXlzaTNMTndWbXNEcDdGOHEyZWdaUncv?=
 =?utf-8?B?S204NFVESkVJMURvL2xUQUlCdXpEaTVDb3FLSk50enpNRGM5bFdyemt0dUpr?=
 =?utf-8?B?MUFQL1l3UTNPa2wxS21wVmhJSkt2eTJ2TTRrQ3hQOHBHSjJ0SlgvYWdhK0Jv?=
 =?utf-8?B?amI1eWtTU1doWncrdlFkdzdqeHhyc3JvdUplSE5VV3dzYXJQZ1B0L1Jjbkor?=
 =?utf-8?B?Zk56U1cwVWNVTjF6SElmcmdPc1NkWEVqQ011VE52L0VUWExsdys2NjV5MmZj?=
 =?utf-8?B?YjJvVG92NlZNc0RyOS9IZktVWWJmZWRqWG83SEZZUm14QzQyTkZvUjdKZ1Za?=
 =?utf-8?B?T1JuODM4anE2dkd1THFaL1JHTTRMM3dISWswWDg5MjE2ZVgxdkREZm8zTGpQ?=
 =?utf-8?B?WVZqUzRHelZzWlRuWEhiT2V1K3d3YzBoN3QwOUtrbXEwK0J2YW1EQmJBamlO?=
 =?utf-8?B?Vy9EVVlUTEROV3lCWTkwRnJ4REZqQlF5Vlg4NHp0aVFFcmlXVWpCTVMxZGpr?=
 =?utf-8?B?dFdXb2kwR1h2cXlteWZMbzF5WEFzczhlektJdHhqU0JkTFNCbk1USlZLakwr?=
 =?utf-8?B?bE9qdlZrRk1NSnlETVhueXMwWUZka2hFVzBURnIyblF2WmFOQkN6TVg3bFpG?=
 =?utf-8?B?RFg5Tit5SFNHMzVGWVVRNkRKRFI1aGlYRXZZY1Nkb2xSNXRscUpqTUtVOGND?=
 =?utf-8?B?VTJhakRTYUpUV1JYT1I3eVRLMG5lSEwrUnJ4YjI3dTRranNYYmJYQjBwUzN0?=
 =?utf-8?B?bk53T2s0SEptTldubjZLZy9Eb09zT3V3SWJnWjV3VHFXYVZXQmFabDlvNnp6?=
 =?utf-8?B?SUN0ZHBnVEhhQ2pTMkMrc2JXZUY3WTJrazMrNmNwQ1RLek9seDZPNEhNRlg0?=
 =?utf-8?B?YWxVLzRQQTVRWjR6V1pNNVhiMzJUSnBxNnRZU0s0OVZlczlNd1BPU0ZQK2pn?=
 =?utf-8?B?NjduYW04ZzdNMkRrcGJySlJmRXg4TUFzdW80NUJRQjlFVVB6Y1RrZEp1VTZl?=
 =?utf-8?B?cDFNZnhFUkd2a0pVdFBJNm9XNytIRktrQzIxY0ZlWWxZZnAvZ0tUNS9TSU0r?=
 =?utf-8?Q?rL+soS9oaladL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGRKZGNiaWRsSGNheEhEblIzZWJwMmloa0hPdnFGKzF0MGxWQkVaaHJ3WnBI?=
 =?utf-8?B?WFZUVkhWNjVDa2RuVlUxL3BBck9mQWdUTi9FTVFTa0ZtM0VkU0lzYVV5V3lC?=
 =?utf-8?B?T3ZlK21JUG5mcXgyYzlWNm9mTlpTWDFROFVoY3drOE1xWFU3dFBrTHBmbkQx?=
 =?utf-8?B?NWZvMGdkNS83bnZyaGI0SW45d2hHVU5LWk5XU2NTbmptWUZ4R29ITlJnWXF5?=
 =?utf-8?B?QThGVjNId2NOemlDa0drSUZVbTFuUWcwcm56WlM0N2FKaTRUa1ZTSTNocHpy?=
 =?utf-8?B?VFZaK1cvSHM0M2sxcHovcHhrL2kwcXFSU25vU2dOWk5IRTZSMVhkNUJENVZs?=
 =?utf-8?B?cHVDNTZ2b0svMGRGVDZSd1VCRDNZYVhIYk9HL3dwYmdoVkU4QUU2K0FLeVlP?=
 =?utf-8?B?SzAzYzJ1WWVpYWEvTHI4Zm92anIrNVpwMUVtZ1BzK2kxSkY2SkpJelE3UlFW?=
 =?utf-8?B?STNPaUJFK2dhM1pCRW9ibWhsY0lCeEx0ZEJvcytLTWNlWWFSSVNqa0lVVmIx?=
 =?utf-8?B?VHJ2UW4xd2RENUJnUWgzM2dKcE15N1JCM2pXR3dYaXpnT0Y3SE1Wek8ycG10?=
 =?utf-8?B?dGFnSEZMcGZPT2tQN2JsczZSYmZrVWEwbU5uNXo0U2VoVGM1b29JZkdqOWJn?=
 =?utf-8?B?VzdXVWpjWlFWOS9MdENqVVA2aXA2UlRSNXBsQ1BoUHgrSC93L3ZpaUcvTVdk?=
 =?utf-8?B?Z2FlK2o4Tmd6T1pWY3krTWVKdFNZcFNvZ2lCamd3UndmVDF6cEh1bHpJeTdr?=
 =?utf-8?B?Wk1yUE55Y1YyQ21OMy9vSHZuQnJEWHN4Z0pNZG5wc3NWVFJJVVlkelJiekhM?=
 =?utf-8?B?Nml1Ukhwd1JNVDVVUXdkcU1QN0Q0dTh6ZkZLM0JwVVlPVm4xYW1uK2xJSTlw?=
 =?utf-8?B?MFZ3YzBWTWRTaUNIVE00dGJEN3JTWFo4NGpXVm5US044akg0YSt1S0xtbm1K?=
 =?utf-8?B?OE9hNm81VUhmRGJUTkRpZmtpRERXb25uOGdUekRCRWgvZ3AxNmd6S0xnN0l6?=
 =?utf-8?B?MnpSbXFqKzlEb05SUXUyc1JxejRTTjlzUXdWRGFrbCtGSlVXNEhQQTN6Tk5l?=
 =?utf-8?B?TXRzQkpEcUFXN29JRVRiSGFhYlU2NVdHNUwxbEJhd1FvSmZqRk9IMnRPemFo?=
 =?utf-8?B?U1ViN0RQZWU2Z2RVMkkvTzRxaWJYRVhCYmlqRUp1TzR3TzJYRTZCUHNRa2hq?=
 =?utf-8?B?V2pSdUtGWXIxQm1La2RGbW04RUhSZ1lqVWFVdHpjZ2NvR2NTdGJNaHhxcEtU?=
 =?utf-8?B?enE5cE8xT2hXZGdCTGl4bVg4eFc0OTNoTXEzT21LVk1Tc2pFSzc2c2Z5VjVz?=
 =?utf-8?B?eENEcERpRnZvZUpTWUdBQjNnS0VLbmlwV09IM0l4eUNZTTBDT3JkWWZZN1FC?=
 =?utf-8?B?ZlFJRUU0aG9lR1p6RDkwR3hvWUdGZGk3Z0VJZ1Nlc1ZiWis4aGlkbG1yOG1Z?=
 =?utf-8?B?QThBMjYwVjdncnBhL0RtVnNMWFpZeSt5RDRveEZzN2Q2U1pycUdWUlZRQXZV?=
 =?utf-8?B?eTBBZHM2SUZpZHdvdDRidGZaaVBPQVV0TmZkNVpZYWtKTjNDaFVvVWI3RXc2?=
 =?utf-8?B?SlEwTXdNaDlONDgvMUVNWDhWelhyeXpvUXdZMUFBb1dqTGtON0NjQVF3ODlx?=
 =?utf-8?B?aUo0ZU1qd2xZZyt3UytYQ2ZzaW51dGZPanc5S0YzSWM1dTcvR3ZVV3kzV0Y3?=
 =?utf-8?B?SEJ3NmhFNVhpdGRQZHZtWGIzYzVqcnJNN0JyOFcybEd2alRiZ1JmUkl1emhx?=
 =?utf-8?B?ZEV5YkJIMzN2ak1sbVVUUDdSV1NUVG5sNHZVbmdQQ1dWQXFIQzFSTTZMUDVj?=
 =?utf-8?B?SzNKMkR6RkhtdVowd1VkT3pKbVNNT1JHeGtaOU51S2ZkRm9zN09sM2doMDVr?=
 =?utf-8?B?emhQVUtMVXU0b0paVjlUclJkOE5nUDBobm4xbUZwdzZGWktseTdZS3k4VjVW?=
 =?utf-8?B?RVJnQnA1RjlLNWIxTGVhb0VYOG5JdWpRR28vY3NVOHI4Q0F1L1ZndnVwOXlu?=
 =?utf-8?B?WFZWZUg2NXIyZU9oalBkM1M3RnhmdTVtY1F1QVNCMy9Qak1ZUjZPN3g1bGxW?=
 =?utf-8?B?RStCdUlFd05jUXErZU5naUc3N1RLOTVpbFB0Z3FMcXg3YjdKK29TR05RdlVU?=
 =?utf-8?Q?vAxvhCv4WKqaYpgYtCnG8VX2r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccbf4b9-5b6d-47b1-70fc-08dc8f0a9c59
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:18:11.6111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYoAPJmAhOE+nh80Osf2Flp6pqX6UisglL8ceBL2re9iIkFsJqnb88h+hIGgPJxpcHsGui0z6t8XMnq/Fp+8Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997

From: Richard Zhu <hongxing.zhu@nxp.com>

Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
the controller resembles that of iMX8MP, the PHY differs significantly.
Notably, there's a distinction between PCI bus addresses and CPU addresses.

Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
address conversion according to "range" property.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 18c133f5a56fc..d2533d889d120 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -66,6 +66,7 @@ enum imx_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MP,
+	IMX8Q,
 	IMX95,
 	IMX8MQ_EP,
 	IMX8MM_EP,
@@ -81,6 +82,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
+#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
 
 #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -1012,6 +1014,22 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
+	struct dw_pcie_rp *pp = &pcie->pp;
+	struct resource_entry *entry;
+	unsigned int offset;
+
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
+		return cpu_addr;
+
+	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+	offset = entry->offset;
+
+	return (cpu_addr - offset);
+}
+
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
@@ -1020,6 +1038,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
+	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1449,6 +1468,13 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
+		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_CPU_ADDR_FIXUP)) {
+			if (!resource_list_first_type(&pci->pp.bridge->windows, IORESOURCE_MEM)) {
+				dw_pcie_host_deinit(&pci->pp);
+				return dev_err_probe(dev, -EINVAL, "DTS Miss PCI memory range");
+			}
+		}
+
 		if (pci_msi_enabled()) {
 			u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
 
@@ -1473,6 +1499,7 @@ static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
 static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
 static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
 static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
+static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
 
 static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
@@ -1576,6 +1603,13 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
+	[IMX8Q] = {
+		.variant = IMX8Q,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
+			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES,
@@ -1653,6 +1687,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx8q-pcie", .data = &drvdata[IMX8Q], },
 	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },

-- 
2.34.1


