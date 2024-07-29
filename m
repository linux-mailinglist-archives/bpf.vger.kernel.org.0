Return-Path: <bpf+bounces-35932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B721493FF10
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17353B22FC6
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E139318E74C;
	Mon, 29 Jul 2024 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d3M+Silf"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5918D4D4;
	Mon, 29 Jul 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284358; cv=fail; b=V3K5sy81BoTCZsp3cPUeeZUp7n+0UdXZrfWBPq8hq3EZawjf07DLyxnbdfpbroG/+ivPpg9iq+BivJQ2GuLsFAaz++3/mZbaeiu8aykBl4J+ErkDyPvzjXOHTPkA8Y/47Quxbp98NCeytvZCwrmNA3CN8EDb0ry29KtFWTK/CLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284358; c=relaxed/simple;
	bh=5Evp9ziK4xKXtiMCIUDV8Eu+6RTJQAatje71eLFFOgM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=p8l6VCrezzvZi4ZgVO6sMGSa8G+yUlQcMqNRAQR43Sfr0XArbozmBbb9dCF82sC2vKVmrkWLOdU7RoRS/OpKqqL/6KxRZJDmXRiV5OlDRO+C4YXrX+omW7kfMw28kaEmGxDqpNB304iFitipc3tM4oi+te5vMUWXNfgU7cyZP4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d3M+Silf; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU017VpOfcaIzgKfzUbHtNloKgimrFpeKPW1/GVhJTdXusOZ2pgy1YH4E5cM69ft4Pk/ur9xktRL2nWOLZe94qlN62dSA4BJ3xmhldKXcMiprdiE/f9ljPxV5tte9rXPjDqi/miRK8I4lqan0no9Gb4pHe/5YD/yWV+lsA9idllpSQPFmum8IJDUZb772z1e2V3P1PTVejJydspQFgZzx0F4p9ELMoFmRseaKNEg7MNUwkH+F9xG3sPXumSbz4tPKPgtjJLXYS/W3+8pvSL4jmqqnkeOMPmfhjagBMPBNth/4HSE4oVph5EryCQgrLuySoDLWCZUf2wHka/Hb3lEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsJJOmwynhIuDvRKjtQeHGM+tPXYlKvgSIKyn7vsea4=;
 b=wyDXPQVv/JLTSrYlc7r3ltDtFtEO8XYWXFCOqQgbFM+Lb4Rt5WcRdXe/Emil9s8RDPwbrNkZESJDcXOyUo46/v4HogQFOmRYRWxMuYNc5n/9zsNVuzyi0rnGDGJga6pVWvjWEXCzUv8Y48YRYtI8gaWecH5SYJxGDgdxJzoRDHG9ovBi0BD34Ddj1/m7hHU6ds0R6Ln56puDurh8s77mKZ07i6wE6E9Frq6e0/snpSx90YBuwR0sx2prCYEuQgm3+SNtLxWkEMYyOR8TYtTpTgczlkumXk808ZwiX7dmTkN6TnZFstLKXV26cQTw6MAFbJsKobzl7UBuiP1CDc3SYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsJJOmwynhIuDvRKjtQeHGM+tPXYlKvgSIKyn7vsea4=;
 b=d3M+SilfZunZYr+q/ak/IRy+Tq3LevbKm1VxYyu1onOIY7NbOlGoaayLS64ZT/kVL3f+wfF4R+1uNBii6c9Y1LDqKHKAwTZy+KQtXYexAJGNCLBDyUpF7DEl9G3XMLprP9angrr0f53ulv7BGxmjPOL41ymXx2cBSnMUMyDJ94AaB9G4wuaFfQVq0LkWNpZMFyomQuPoztluRZOe+DLU56ZIV/uzYhi9cZOEQCT27wdifu4C4WnYLolfC1ydzwOrkv6wVEyocY1ntO/N7ANDcf5zeAhSBru1WxjdD1iOD2hZdl5Q3Km1UGpybSPghYW0eIsng5PAUSzhBfjTgOMgtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 20:19:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 20:19:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 16:18:12 -0400
Subject: [PATCH v8 05/11] PCI: imx6: Introduce SoC specific callbacks for
 controlling REFCLK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-pci2_upstream-v8-5-b68ee5ef2b4d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722284317; l=8140;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5Evp9ziK4xKXtiMCIUDV8Eu+6RTJQAatje71eLFFOgM=;
 b=oMuCrSj1c6X64c6fycFt1hs9EWif3NHWbQGySfIbz8otS19MrLFWamFei1nWPmeHjz+0F/CMA
 D8kJTLl8n+FD3slBN6r+NR/jhs9yzhgWg+m3fYJDKcyjKIbaCVyYYhC
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
X-MS-Office365-Filtering-Correlation-Id: fa3f4afd-7fb4-4451-b7fc-08dcb00bb5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkFlTS9XV0lUTDgwUUlzKzdTK29nZFVTVCs5WnJJcXlTazZkQytXQ2xTeWov?=
 =?utf-8?B?Sk1xT1NyN1N4dDhXZllmSEhNa2RvdzFKQkVZM0w5akExSW5NaWVReWVzd3JX?=
 =?utf-8?B?UzE3eFk0TGkzSjVvNWRhU1NIRUU3blJ5ekVTZUxtK2xyR2g2MFJ4TVRScWxs?=
 =?utf-8?B?OTFMRCt1dmRBaERzaEdIMnVBWkxnWEo3ejR5NFVhQ2tnSW5CY2Jsdm5Xd0xZ?=
 =?utf-8?B?bVdiWlFrb3BCRjJwRU5Sc003NFlUSFNkd2N0Yy9ERzNnMFFsalE0MW8zeTA3?=
 =?utf-8?B?ZGZyWGliVVp0V1lFR2tML2xScFhCRmh3UVN6THpXNThYR2lqK1hmTTh2VTdM?=
 =?utf-8?B?ZXpNMmFaK09mejJaaEZtWTRMWjN0UWlLN1FFcmYyZDZjR3lZUlJVbzhRY3Vx?=
 =?utf-8?B?a1JDZUNpVXRsU2xNaEM1cGxkVzJFYWpITlVVRnpRSVpxSDdpUFV5OXZUTVBY?=
 =?utf-8?B?Nk9hL1dwemlBbDM4a3pNTkpFclVaajFIckdpMG5iZ0t3clp5NXJhYStkVUxD?=
 =?utf-8?B?SVh1eDRSYWppVkJGdWFCWGd4WjROU01rTVdYeG95MktQYTlNd0hyeVl5VUx4?=
 =?utf-8?B?UmNaQ1Y2ZGdQSTl1cnViR3Z6UmJKTzZHS01JeC9IYncxSFJvc0hEaUpTa1F2?=
 =?utf-8?B?c0xrWSt5MlZ1ekFraTYzLzF3TXAzWkdiSUJZNHJBU2FkOWtmbUk2dXhwc0NL?=
 =?utf-8?B?eTNrbkltK0IzajN1Y1BxRXMrbkZyTmdEVVFqYTFsbWt2ekFzc0Y1R1FnZ1BY?=
 =?utf-8?B?NmlkeFJGbE1NMVdzV0dwWTF1TTU2aTBSMUpocVUzV1RIekR4Qy9jR3F1ZWIz?=
 =?utf-8?B?dDIwOXp2bWtCVWl6RldtQ2g0SEF4M3Y0U25QZE8yTUlnbk9icGUzOHA5aTYv?=
 =?utf-8?B?TnB5WC96UEFhUTVPdFBNd1I2emZEZEJSdThTOEtMbFN6Vi9kK0tZanFFd0Zk?=
 =?utf-8?B?b2VsbHlhK0wvaFJmRHl1N3hwZURNYkRDemUxUVZqQTM0RmE1OVZuWXdkUEN1?=
 =?utf-8?B?Y1hydUVOUk42MzExSFJrdHFGMzJyNnRDR1h1SlYvMklTT3FwMXJKTVphT2x0?=
 =?utf-8?B?YjRudHl0Y2Fxckp3cmlJQTlVWHpSUFZEbDBUbWlYSWlnRlpUMi9Bb2FuaHRF?=
 =?utf-8?B?WVE5Zngzd3pYU1AxRXJ3emZLc3BrMC8yL2ZKK3hjbEZCZ3BxM01LNC9oMGFO?=
 =?utf-8?B?OGhiQnYxbmRWZjUrYmVqalJJd0pBd3A3SDJYRkFPZUtzNnZlK0VkK21iRk1M?=
 =?utf-8?B?YUs5NXNYZWJ4NDhQUW55L3Z6RlhwWW05N3RlRGJEbEF4K05lRFFxWkg3M2t5?=
 =?utf-8?B?bmhUTzJmbURZV1FJSEo2YlFtcE1TdE1QWmtOcU5RTFVhbDJGM2JXOVNySnpa?=
 =?utf-8?B?VktOd3AzSHNnRWhDMlpjY0dwTnJWLzJ6ZXBGZEdmY016ZXV3b2hPMlRKQk1Q?=
 =?utf-8?B?VHUvVnhLeVJWZm1kaE1Vbm5xM3J2MVRLeEV1Y0xVWEsvc25wNExxWjR3ZEpR?=
 =?utf-8?B?M3JTOXJTVmFKTU5IR1MvdXZiNkt1eldWM3psTVM5MEx5NTFJNHJ6NUtDRzYw?=
 =?utf-8?B?WDJlR3JPMEhkRWZMZm9oSDlJYzk0ZVZIMXFadHYrdXFoYi81bURZOUJRd0k0?=
 =?utf-8?B?SkFMUHI4SlJTSnBRRjRERFJGMXlqa1hNODlIdUVJSThVanVnL0lRUy81VEUw?=
 =?utf-8?B?T1lxdUhTYVlLdUlCb3gwZllyY2k5STZxbTNJQ25wS0F4RFJSclk0cEVnYkNG?=
 =?utf-8?B?VERvWnlrUEN3aWc0M0tZUnBuQ0hHeFh3SkRDSG9WTXRSSVZhV3RBTm45dFJM?=
 =?utf-8?B?OWExN1I3VHJqOExXeGtkWFYyNEsyaExnWkZIQUNMc25CMkFZTTlWVERScmtu?=
 =?utf-8?B?d000RWJOMU9lY0o3R3lYSGhFZ3NZRitSQS9vTHZCOUg4NVBTeHRsZ01Hd3FW?=
 =?utf-8?Q?ZPADXwaJKxk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlQ0ejVVakhMdDYzWlFpWlRQY3czNkd6RmRMZVAzaFFlbmJoMmdmMGp3S3Rt?=
 =?utf-8?B?aDNScHNoenZjZ2YvcmpzUWgzTDBsS25CYXJJSmtiemYwQ1BncU9WR2xmVytZ?=
 =?utf-8?B?djU1K0VJY2tzU0FFa3RoTXg3bDdaOWRteTlVSlpaV3hBT1ZuTUJwVHkybEhH?=
 =?utf-8?B?ak9yb0dCZVlUdk1xazl0ek05WCthdFQ0eFg3TUJVaE1ISTJVNklNeTFNRkh6?=
 =?utf-8?B?S0NoR0dMSkFLVXVKNXNJeHlFQ2JzNWlSZTNmV2MvN1JDOE0rQlVWaUlQcjBK?=
 =?utf-8?B?bDhUTDVzSWxIL3g0THFRa2xVU1BtRUE0SnYyOFhOYkljdk5GcjBEUEx2MFZh?=
 =?utf-8?B?cHhpMHZ6Z09mZ0IxaWNXcDlYTHArZ2g1UjdXYWkrNGRXRzhzNEhmMWVWdUFV?=
 =?utf-8?B?RURuM250WDRZSGZDVG94bGV6Q0VBaE5VS1YzY1FkbHM5K3lTeURNRmJuNTVY?=
 =?utf-8?B?YkxDejJXTWhLMjc4aVQ2SkdzT08xV2EvVDMxL3htZGJEK2t5VDFQT2J3ZUw1?=
 =?utf-8?B?MUkrZjFFNGpyVzlKMy9wekhzNk90RmtWNUhNTGx5d0dOS0xXZXVyRHlDUGl1?=
 =?utf-8?B?Uy9WR1dKRmhSRG56ajRmUGdqT2h1Qzk0NE9WWUQ4Rm1jc3VJNnU2YXhLRHNI?=
 =?utf-8?B?dlNOY0UxWkNxVVlsYlEvUEV6U2hXcHdRUkZjQ0VuN0pleUlqZTRjWWlqMlJL?=
 =?utf-8?B?NG1KUTNaa21vem5xWEFib2hZbkpqRFJHK2FNNjgvM3RvdXdjTWxFdGdtd1M2?=
 =?utf-8?B?NHlVdG9zdzUrMVlNZ1hKajJ0MEpwQU9SejlScTAzWXpOU1dZMys5MTkwVmlF?=
 =?utf-8?B?QXRiRzhvS0hHUEVYS2FTWGRjZFFKdDlOVG4xWjBmRXRTVmI4UUFOc1Z6U1Ur?=
 =?utf-8?B?OXlnSnB4U2hBUStGcUZkVTZLRUs0b2M5Q21wTllZMkJpWi9Ta2R5WDQ1Z0VB?=
 =?utf-8?B?VS90YVh0dDltR3VrUUNkUU1vSlcvc0E3UFZTRVQyU3BLaGZQZ2dySWJzNndw?=
 =?utf-8?B?Tks4MndLK09PTlRxcStTUHR2K2owOFNDUTNBS3djVVdMWE9zS0ZLdTJoVlZK?=
 =?utf-8?B?VTNsNG8xVEQvVndyUmJUcHJwSXVhU01SMEJWSUtrc1Q0d1RhUjNZTngvUkhy?=
 =?utf-8?B?MWJDYlNLL29yM0wzYnhpOUtKeThNQndydFkzanVpazhNeG41OWdHS29nWGxz?=
 =?utf-8?B?VGVSWlJ2NTJKNzh2MHkzWnU3MnVTbFJibHkwUkVXU2lTcTNQaUR5TVhHSXFw?=
 =?utf-8?B?TkZycUd0UVdtOW11bzRRejk4VG5CRDE3bU5CVzlSWmJ3cWtqdU5tclRXYzlu?=
 =?utf-8?B?eUFvbFJ5U0FsM0NDN2NGR0Q1cXNsdUJuak5xV1FOaU5ydmZieGxId1M5Mkk2?=
 =?utf-8?B?RFRkeXBrVTZscDZOcDJ2MHBmZkYrNWZodUNpZGxEMWRoOG5CUlpFRFlkU1g0?=
 =?utf-8?B?Sm5aR3hnWkVGODMvNDRSTnJCVUJHSUJEWW9lb0FsT1dhTVVTTEliSXJCOURL?=
 =?utf-8?B?OGx4elp5TkJIWm5WckVsYXJLenVyR25lTi8vMzMwYXgrUVFyY2s0dWlqclhR?=
 =?utf-8?B?UWltRE1Ba2FPNXgxSUJzWG0rQ25qUHN2N2hjRnN6R2EyQ0xXKzZVQ3JNcDdW?=
 =?utf-8?B?VGFyZElsRU5wYitKa1lidnBDZ0RyMW9xOTNVZ0ZWMHdqdDVuZkFobzlBUmg3?=
 =?utf-8?B?V3BuTUI0ai9mVkR3aWZxdFJNeGlyYnhWS3Zjb09OQWlCNXNEWHNPZHhHbkgv?=
 =?utf-8?B?QmRzdjczblQxMXZUU0ttQkFPaEo0R3owMGE4MjUzcFJVUTBLYTFwa0Z1MFdY?=
 =?utf-8?B?TU1PRGRwRVhZRXJ2WktkeFhRdW1vZkdvampvYlgzb0tVWWRPTS9pYWxHTEFE?=
 =?utf-8?B?MVlJaElYdXdiK1JBZWpkajlTazM1ay9ET2pCYk5QUE0wQjF1Y0N4YXJaWDJH?=
 =?utf-8?B?dUlkMnZSVGk1OWI2SVN1WkNIS2tSSzk0QUJWd2xJQTYxczZYU2FHT1RVd0J2?=
 =?utf-8?B?RmlacWZzZ2VxS3M1MWxZWU84ZC9remcybXNOcU02ZkplOGZZd3dqRU5aTm82?=
 =?utf-8?B?ZWxlNXpxU0h5LzlTaVA5bklRK3JtUWxhbXJXNkFpaVhhbVBUSVFwdzhZb3Yv?=
 =?utf-8?Q?FawvUvXdRe1v213ZZbW3yLn2t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3f4afd-7fb4-4451-b7fc-08dcb00bb5d1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:19:12.2021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heAMAOzR/MBjS08ZSPg6Q8QoUS1+HQoXFVwqqViTESu1DSf8SQr/lwAtbzHWLtcEz3W9ieo6kF7beoy247CN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382

Instead of using the switch case statement to enable/disable the reference
clock handled by this driver itself, let's introduce a new callback
enable_ref_clk() and define it for platforms that require it. This
simplifies the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 111 ++++++++++++++++------------------
 1 file changed, 51 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 443c7c75f2842..b68a817ccc86b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -102,6 +102,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
+	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 };
 
 struct imx_pcie {
@@ -583,21 +584,20 @@ static int imx_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	unsigned int offset;
-	int ret = 0;
+	if (enable)
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 
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
+static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	if (enable) {
 		/* power up core phy and enable ref clock */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
 		/*
 		 * the async reset input need ref clock to sync internally,
 		 * when the ref clock comes after reset, internal synced
@@ -605,55 +605,33 @@ static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
 		 * add one ~10us delay here.
 		 */
 		usleep_range(10, 100);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
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
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	} else {
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
 	}
 
-	return ret;
+	return 0;
 }
 
-static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
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
+	int offset = imx_pcie_grp_offset(imx_pcie);
+
+	if (enable) {
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
+		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
 	}
+
+	return 0;
+}
+
+static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	if (!enable)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	return 0;
 }
 
 static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
@@ -666,10 +644,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 	if (ret)
 		return ret;
 
-	ret = imx_pcie_enable_ref_clk(imx_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie ref clock\n");
-		goto err_ref_clk;
+	if (imx_pcie->drvdata->enable_ref_clk) {
+		ret = imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
+		if (ret) {
+			dev_err(dev, "Failed to enable PCIe REFCLK\n");
+			goto err_ref_clk;
+		}
 	}
 
 	/* allow the clocks to stabilize */
@@ -684,7 +664,8 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 
 static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 {
-	imx_pcie_disable_ref_clk(imx_pcie);
+	if (imx_pcie->drvdata->enable_ref_clk)
+		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
@@ -1460,6 +1441,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1474,6 +1456,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
+		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1489,6 +1472,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1501,6 +1485,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
+		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1514,6 +1499,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
+		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1525,6 +1511,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1536,6 +1523,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
 	[IMX95] = {
 		.variant = IMX95,
@@ -1562,6 +1550,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
+		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1574,6 +1563,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1586,6 +1576,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,

-- 
2.34.1


