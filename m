Return-Path: <bpf+bounces-35933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E6593FF15
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B5DB21C42
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04E018E772;
	Mon, 29 Jul 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ADpsCdEh"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E318E75A;
	Mon, 29 Jul 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284363; cv=fail; b=cx1WIaDgEs7ozPwwaqKgKvBEfswQ+4iLutr5XhSimj/xvB16ystale50aDZ1slRssPsog2r7ojmv39qiIsAcBxgPLjoPhVS8ntRk2qh4zr8XeeAkM+voaqiqdpA6mRC5M5IS6i0Kqfs9ALzJrq8eWR93+dW+w4XlyDQTk3CyQRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284363; c=relaxed/simple;
	bh=l6u7V1/pCtBjFxMkz39fZGAw07dHKSYZdHO4bMuhkdo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BFpAyJrXJM5mRHHQUFQyiaqPCta158cj4a83qGbn/JOjmc9qB6BiA/JjQGnK04RBbxcQFyVVQHmISL2OPJ++UiEcfnSsih4vLGiEqXIaNQh7gxp+rfadnaxNHm47PoB8gm9iRc2/sa2/b/0xwZn0WL2rYoZDEBw23McQx7ysTow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ADpsCdEh; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUoYVuMzLeUeS8/wTLpFIjTj1c8Jh0gmEpoK3YuRYUoUnHzPgxER26lBZt7drN+VZRCU69DZ7QYBohEZflTINbF8zyhLIA1iEPh1N3oSzVlvrkTZhSu7qJQXB0F4ugOBOAoyQ3yH8OonTy//KHc81Sp9fv36buTE9JT3uvw7TXWRxaznXQXGblPtGrd1ysgksKSkOA1u48oeIiehsAEdCj/BweO6C0N0BVjO+0RIKfn8t5FUHxKsz5XkNg5GHM/KtPhIuSHTXn8sW5L3GkcwkUh1hr7TTLIhLoloNxR5s4o7TmE56Osqd+ZnhHbcLmsSuqxlbuGKSjGNhiM6N4+pBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/QA2uinC+ZPsfCdu0G7gGvjslyL0frrBFiMN/7ouRQ=;
 b=jH7OLSRiWm7hdopfZzEbvnxFBU3AoT4hSXmf/PnyIirNhXjAjS7npvCU20dW5xQK4QYhykjRZwOSIDmR8yrAHIzZSZkHTYcdHNO+Bb6KbGLdAaHklJReGeAtnV5xteeNYPrAZTEtcO8TiEbl8LxKP9gLBDJoNgEukaeE2eUCLHWj/yO/o4blujrkLuLOfiQm0fWcTG9WneL9sQ2RMFIgX5yl9uOOwZfb/FRebkb4y/ddaF6NZ8vBKA4ua3y74qqOmdDkdxJMo0jPJDCo06HRxNsDSsnU5PXNpOMQnVd53O4w+NzOjY81dlKnVgNdgV6plLT7ORZMCther1G9uoACDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/QA2uinC+ZPsfCdu0G7gGvjslyL0frrBFiMN/7ouRQ=;
 b=ADpsCdEhgeEgoK9xs6zg8CN3dafWFBc2Wx6WRWaJO8ftrugc4c0Sz0TsRZ0/73o+1eB3N7AEvk9ndfNeHDBHnJeK3NOTFlSE0hk7L4kiuc+aX9AxHb/OaDo9/i9y+dQ71Yi8Vutux2CSsd2M8cxtTP612Hb5x+eKFKV4SbfYQbp3dA1ePUfO93OQ2IU10N00bmDt9q8XRlpdp2tm2VWA3H6CA7xiyQZwPjZ+ckteEV/wDGbtNLLKdJb9PoGzF88rTp3UY8P/Qe5BzqMHjnhNhqoiUy+4BigrJMcuxgbeUU2YPd3ffiVIcTnTWp8dvDr0J1NR3ffGfOhZXHhW9lo3Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 20:19:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 20:19:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 16:18:13 -0400
Subject: [PATCH v8 06/11] PCI: imx6: Simplify switch-case logic by involve
 core_reset callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-pci2_upstream-v8-6-b68ee5ef2b4d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722284317; l=7122;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=l6u7V1/pCtBjFxMkz39fZGAw07dHKSYZdHO4bMuhkdo=;
 b=shKot/hisTnDMqzj/nvUxxC3nka7UotQLVSp9NCqGWdCD0iEENfuye2ecoH5KncI9ZHLCkcXp
 Ga72Mrepd+eDxdMWVnED9n845fcBwWNlzd1I7IiESWzWjM4sGU/CPZ1
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
X-MS-Office365-Filtering-Correlation-Id: 02e66897-25c3-4081-e513-08dcb00bb91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmJGNWFNRUlOWGdhNEZzejJPTWc4by9XOERJci9Oc3Z1aC90MVlJOG1aUTAv?=
 =?utf-8?B?ZnZnN3ZJZ0l4N0twNWk1ektIMjZpb3g2MFF4WE1TY1VQOGJPR0kzOGs3Ty9n?=
 =?utf-8?B?Nzc2V2FvZkFNUFM1bVNmRlJsVE9wV1NHTWpXczkraUw0NVdsbkF5SE92NE5m?=
 =?utf-8?B?QlkwWWZxNTA2WnVjYUZ4cndkMlBsSWorR0NUSGhwMzBsMEFnUkNrcTZMWEpk?=
 =?utf-8?B?ZFNRU1hkeW1aWStzbWdoSUM2TXNQNWdkK1UrdGFnNm54bHJ2ajM2QUExS3o2?=
 =?utf-8?B?L1IxZkplRzhPL3Qra3YxMlJLSzlSNEY0amZBWGV2QzlzY0Nqb05IUTFqZ0lq?=
 =?utf-8?B?Vzdwa0RkOEluWUNnL00rQWo4ODBhdHZUa3ZOVS9pMVB4UGdsZG94NXdCUmg4?=
 =?utf-8?B?czBNQkcyb2dTam9vbWNSWm5kbno2NTcvd1hjdUI5eVZ1UjVzNEppMDBNRVJz?=
 =?utf-8?B?SjZuM3ZIVythd0FQb1QyU1IwZlllK1dJTng1VEtFWFVWM1l3M2REbUlkZnRk?=
 =?utf-8?B?aFFab1RQUG9acDhwMndGQkZ3dW1JczZFdHg3alk1UVZHZzY2SU44V0dKM1FN?=
 =?utf-8?B?cWt6WTBrdHB4TTUweDZkWFIrd29HOFdlSFQ1R0RjWHRaMEN1c2FFVjArenJX?=
 =?utf-8?B?eUxLTkpodHc3aW8zUlJRKzJrVnFVVmh6TmhGaUs5TU5VclhVTUxLaTFwc3Js?=
 =?utf-8?B?aTFYOEkzY08xbkJ6VGJBbXFsWnNxSHNvS1huTjVmOHBZbjVzL1luTTJ3R05I?=
 =?utf-8?B?c1NYQ1VFcnVDMG9FbCtUMEVZTG56YjYrczJHSEhPWGlnZitxZGE5dUZ0MWx4?=
 =?utf-8?B?YnN5a2ZVSzJSWUZndVM4K0QrWEZpQ0hzQjkzVk1kaldxbVdZM1JPdlRzSkhP?=
 =?utf-8?B?K1E4Rmw2SnMvbmRvS2FLRmVOMlJybzFXZmNvak9kT0RETGZhU2tTMWFqVFgz?=
 =?utf-8?B?eDR3ZS84RlVsREdvVVZEQ2ppdGcyYXQvT3drNmUzdG1MSG5HSEtXbE5ZMUtP?=
 =?utf-8?B?ZzhZT3MvaHRZQzVJWGNPL1RMUU1QN3k2c3FZb251V1ZITEYwU0ZpYWtBMGxQ?=
 =?utf-8?B?YTRpRDJseS9aMFVVZ0ZmaTUxODhWVDBOT05jdGpnaDNBdWF0bEkvR3lGdnJx?=
 =?utf-8?B?L2NxZUxscldrYms0Uko0Q01NbUZpaE1CR1lJaXFpR1d4VXB2VXFzTWJ2SE1q?=
 =?utf-8?B?YTdwMXJBT09YR0FvaEFhNWJ3YnZBaEZnZFZoTXRFWXFDYW8zVndKd2JXc2ps?=
 =?utf-8?B?VlNJejVqQUFTMkdXTXJaUzV3eVVUdy91cTh0d1dyM016KzF5dUhRdmFiYWNM?=
 =?utf-8?B?N0pNcTVzenpWS1A3MXFiMllvZkdGMldGTUxnUFVhcXlScFlZWFNXa2RYU0Ri?=
 =?utf-8?B?SXpzWFAvTmJrcFNTd0ZKbnRRalpKRkRGYVNoRzhJNUd3SHNpekhkT1VSbGRB?=
 =?utf-8?B?QXBPL1M4NXg4ZUI3STNFdklOQ3JEaUVHQ0RycDBMMDB0ZFRJYjgzUWtFQmFh?=
 =?utf-8?B?UHRLcmM1bTRLYzlkOXc2RFpPMnB5ZExkVlZWZ3VockJzUUE4dU9QMVlPOVJJ?=
 =?utf-8?B?dnZUajZoUkRmdWQ5Rmw5bGt4UTh0TUFQZmNpd241blgyWG9EN3lOUzRzeGFp?=
 =?utf-8?B?amN2VHRZVEJoWUZLU1dHM0lWZ3RCY0FtK3dZck01d3hOeUZsQXpCLzZCakw5?=
 =?utf-8?B?UnI5YktDQVdIOG5mTzJlRDAzNWQ2eHMzZ1FqcjFlRnNZRy83andPSWxhVnJv?=
 =?utf-8?B?c1ZmSVZrRWVQbytNWTdkb1I0K1NuSzJuTTA4azJqbWNsRFRBbkpVOE9ERS9R?=
 =?utf-8?B?d3RLT2U5ak43Q1lIR1V5Y1BuUzVlTHBXVCtrdDFrOFFmMlppN1gwaVh1c2Vq?=
 =?utf-8?B?NFBIZk0vMVRLRE9KOFVzWFdUVldQUlhDbkhEN1VoNzNtV0NXRGZReHQ4ay9W?=
 =?utf-8?Q?YfxJVGf1658=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3hHaEdrQklSbWRQZ2VwUWJZcHhsQU50WXovdldjOWtIVG5zWVk2SHpwMVp6?=
 =?utf-8?B?dURTakVGUytKQUZoc0lPRWYwbVlUQ0Q2UEM5Wm1mb3dyZjNXTHlqUDNGTjZL?=
 =?utf-8?B?b2xKOWx6aDZVMkFwc3RKWUxNWlJtRmZ5eVpySmdaM3FTRU9kQmRCbWhUOUhK?=
 =?utf-8?B?b1RGbVBUbEx4N3UvdS9EV1F0bzFyZnVITS9CNVRaNjE1dlorZ1c3cGJjRmZC?=
 =?utf-8?B?MmZJTlVjMXZ4cmVyVFo1RnNyc2JKNDlUWU5QRzBpd00rWVB0ekVMVm12U1ZO?=
 =?utf-8?B?dE5ncWdGYldJODlsQzhDUXppcXBhSVBVV2FjVVJId1hYS3hZN0tnRlY1eWx3?=
 =?utf-8?B?TWYxUmtmUnQ4cUhRcUEvTmpLWHZBNG02OVVycGFtVHVUV2xMVHRyZk9NczJJ?=
 =?utf-8?B?eDQzK3E0amNZZUFwRHJBYzc0Q0gwS1N6c2cvTFpxUzdhaGV5MzRjNVlGWHdV?=
 =?utf-8?B?V0tObkVJbWRudWxJZVErMVZVOUZ4QVIySHV1WHNVMUR5OHZYcmdlejE5STY4?=
 =?utf-8?B?Mm9XQ0FtUVZHeWl6cHNuYXJsNm4vZkVSaHVSSC9HVzB4bFlCck5PZ1N4czdV?=
 =?utf-8?B?bTdzOFBoSFBuaGxKSUdYSjdaVlhpT2tUNExmc3hVUkliSHdTeDFlSzl1MldP?=
 =?utf-8?B?cXBScFlGV0xadGpON25BT2NlSWFUMUR2eFlVQ2pQSGpidU1lTTlCelNyV3dT?=
 =?utf-8?B?T28yNi92eHBnWGtoR1poTzUzZTk4MDJvZDZvUHZaaVBGaEZMeG1ZMGYxUG83?=
 =?utf-8?B?eURJOGpjcTU0aHR4V1dYZU53RllESFltVUVQRjFDNGZId2tnMmZEb2ZHM2xI?=
 =?utf-8?B?YnNUdTdFQXRpSXdsK1JQYVhZaTF0ZGhyM3dac29DbHRCOUNCS3lIU2dYd0tw?=
 =?utf-8?B?TnRQRmNRa1NwcDdpVzBvd3ArUDR4Y1o0aVdUL1k4NnFsd3ZrdUc0MGRZdkdT?=
 =?utf-8?B?dXZMVk9CUXZNVGdGdSt3ZGVSSDhGWVVnR29ySDdUWlVDRGdKNTVTZloyUlVL?=
 =?utf-8?B?N21iaTR5ZGZQRmRMbWlQZ0pLVW1jbnZrbXFsd1dsd2l5OXZXcUFLT0s1YUVS?=
 =?utf-8?B?NVVIQTZlYnZkdUJpamlRTzdlakhIcjUyd0ZNelpkUzdzYkZSZFBORUYyazV5?=
 =?utf-8?B?d1d4NEVjVy94QWs2cnA4L2E0d1N0aFQxVzJRVnAvM3BGaUxzcUVVNHFkeVY0?=
 =?utf-8?B?QnF3ekphcHhyQjZwcE9KbVlFZzBueTlHYUpKV0p1NjBubU10K21mUDU4ekgv?=
 =?utf-8?B?ZXdJb3RiWnNoTVM0R3VJSW84dk5kTmhOQmhkWFpuc0ZBUVBtMmtULzh1Z09m?=
 =?utf-8?B?VG5IVTk0anJzejdmWmhtWUpaWWxmWlM4MmZMQVJNS1Uyd3BKZExnbG5JRXZQ?=
 =?utf-8?B?ZGRVOGtQcC9waFllR0Y2dVA2cVh3YXVITnVGWlliSUd6SG40MmhuT1BBcWth?=
 =?utf-8?B?aE5uWnk5cHFYenRsVmk1QXRMaVhmd3FCc0IzZE8wY0NWWjN1VytyS0tTUFg5?=
 =?utf-8?B?a1JhZWIvYVVCbkp2NkozV0NhZEdhUDBMcDhvOWdlaVJLWXRWWDVIdVVTZVlw?=
 =?utf-8?B?SWl5NktmQ3AzcHlTZDlZUklSRjQ0Zng4R0YvUEZOcTl3WXhXczJ5a2pyMWNM?=
 =?utf-8?B?UytROHk5MGlBWVpwK21HQzhORzZPQVVPdjU2a0lmUXZkT3RRNmFOR3hQMEkr?=
 =?utf-8?B?SCtJVnh6TDI5ZVhqVS9JcThQWkFKcHhEVzl4UUJ4QndKSEgxZ2VTbnF6czJH?=
 =?utf-8?B?MFhPUzdqTzFiRTRrT3ZSTnRQdy9ITXRXcDZ5WXFDY2ZmZDFXa2szbytjYkdI?=
 =?utf-8?B?T0h2TmJ6QTVpalVDQXNFN0hjc0FrS29oQjZlQk1FZkxqYkFEVjF1T1lqZHBK?=
 =?utf-8?B?VGhrV2phOWpaZjBObWk3YjgxZWlBK1FlWFlOZ1plcy9ZWWJlZ2FFdWFZSFFl?=
 =?utf-8?B?SU1VblFzQjFxQ0M2OUVvbkd0WUhmOStzUGhac0k1U0RVbEErZWs4THQvSDZP?=
 =?utf-8?B?TnFxQThpcVE3WDFOK2Y2Y1dYdUY2N3lFcHQxM0dCYTM3dlgwdmV5M2V5ZCtu?=
 =?utf-8?B?b1d6MTRibmtsSUFGQnpwWWt2NTRHVjNxSmY1ZHFnelpuT2hla1lWMmtpekZI?=
 =?utf-8?Q?vJYsGApqhI0dj/m3V9m6l2S0/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e66897-25c3-4081-e513-08dcb00bb91f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:19:17.7571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWxpp4qvgSUqeio8xku9qDPoYWvIn0ylanWSLKy9/9uNmDtPQ9F+P1s3kWeUnsZd85c/fyMGV6sFu89jfdyPug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382

Instead of using the switch case statement to assert/dassert the core reset
handled by this driver itself, let's introduce a new callback core_reset()
and define it for platforms that require it. This simplifies the code.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 134 ++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 63 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index b68a817ccc86b..e295c7bef732e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
+	int (*core_reset)(struct imx_pcie *pcie, bool assert);
 };
 
 struct imx_pcie {
@@ -669,35 +670,75 @@ static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
+static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	if (assert)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
+
+	/* Force PCIe PHY reset */
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5, IMX6SX_GPR5_PCIE_BTNRST_RESET,
+			   assert ? IMX6SX_GPR5_PCIE_BTNRST_RESET : 0);
+	return 0;
+}
+
+static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
+			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
+	if (!assert)
+		usleep_range(200, 500);
+
+	return 0;
+}
+
+static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	if (!assert)
+		return 0;
+
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+
+	return 0;
+}
+
+static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+
+	if (assert)
+		return 0;
+
+	/*
+	 * Workaround for ERR010728, failure of PCI-e PLL VCO to
+	 * oscillate, especially when cold. This turns off "Duty-cycle
+	 * Corrector" and other mysterious undocumented things.
+	 */
+
+	if (likely(imx_pcie->phy_base)) {
+		/* De-assert DCC_FB_EN */
+		writel(PCIE_PHY_CMN_REG4_DCC_FB_EN, imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
+		/* Assert RX_EQS and RX_EQS_SEL */
+		writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL | PCIE_PHY_CMN_REG24_RX_EQ,
+		       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
+		/* Assert ATT_MODE */
+		writel(PCIE_PHY_CMN_REG26_ATT_MODE, imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
+	} else {
+		dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
+	}
+	imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
+	return 0;
+}
+
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_assert(imx_pcie->pciephy_reset);
 	reset_control_assert(imx_pcie->apps_reset);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-		/* Force PCIe PHY reset */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
-		break;
-	case IMX6QP:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_SW_RST,
-				   IMX6Q_GPR1_PCIE_SW_RST);
-		break;
-	case IMX6Q:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
-		break;
-	default:
-		break;
-	}
+	if (imx_pcie->drvdata->core_reset)
+		imx_pcie->drvdata->core_reset(imx_pcie, true);
 
 	/* Some boards don't have PCIe reset GPIO. */
 	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
@@ -705,47 +746,10 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
-	struct dw_pcie *pci = imx_pcie->pci;
-	struct device *dev = pci->dev;
-
 	reset_control_deassert(imx_pcie->pciephy_reset);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX7D:
-		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
-		 * oscillate, especially when cold.  This turns off "Duty-cycle
-		 * Corrector" and other mysterious undocumented things.
-		 */
-		if (likely(imx_pcie->phy_base)) {
-			/* De-assert DCC_FB_EN */
-			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
-			       imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
-			/* Assert RX_EQS and RX_EQS_SEL */
-			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
-				| PCIE_PHY_CMN_REG24_RX_EQ,
-			       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
-			/* Assert ATT_MODE */
-			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
-			       imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
-		} else {
-			dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
-		}
-
-		imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
-		break;
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
-		break;
-	case IMX6QP:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_SW_RST, 0);
-
-		usleep_range(200, 500);
-		break;
-	default:
-		break;
-	}
+	if (imx_pcie->drvdata->core_reset)
+		imx_pcie->drvdata->core_reset(imx_pcie, false);
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (imx_pcie->reset_gpiod) {
@@ -1442,6 +1446,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
+		.core_reset = imx6q_pcie_core_reset,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1457,6 +1462,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
 		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
+		.core_reset = imx6sx_pcie_core_reset,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1473,6 +1479,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
+		.core_reset = imx6qp_pcie_core_reset,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1486,6 +1493,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
+		.core_reset = imx7d_pcie_core_reset,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,

-- 
2.34.1


