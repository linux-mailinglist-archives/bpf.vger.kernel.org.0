Return-Path: <bpf+bounces-28933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091608BEBD5
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35F5284F32
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BAE16F8F6;
	Tue,  7 May 2024 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GGSHFOI+"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2616F85B;
	Tue,  7 May 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107635; cv=fail; b=SZUb10CNcFWHrvm1jhZUWCSUU/Wnf/7egexhE2KQ1BqnyeGbDJBHMEOyP7VDrnmsYUx32dUgsemtrEh0qcUK2feUNUQJoa0o0Dt0kWPOvkzoZdOvqXBr1Ib/dMA/8HeLk+C1EvnKFMwWcLDdDQEhV5EE9clpBEbhQKrCsez3AY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107635; c=relaxed/simple;
	bh=uRbYV+8P6VjCoxmSQ3mxj6dE+Tuv3Whv1pWoX9EvqFU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bmzSGevl6XEMygoInxhFnTAvVsIsnkqGoT+Wzf/Up9pJt9T9xlXGxwhCdm3In0gbKNygdXceKFqaXoepVrZsUprrLi6Kp5DFK/ZPbwZ8ro1UPYTkxCYjZqFFw08K0l5i0FbN5dATZAj77RXuaQEtxHVKZUnKp5mEqvpfN9m1S+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GGSHFOI+; arc=fail smtp.client-ip=40.107.8.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXpKnvREYuj7Y72Xc3NUtLx9JXn19fwMT1UQ2LcIHxnnzDZZoGGNLNyKYZBdgnofKeKWS0tqp621LfeMVy2ZBAE+Xke3ieDvv3P+WQmvuw78fyWiri5vZ4XcOMLS2cP5UTa5MUgz90wtAvdEaRygqIafHmbds53lYyJ491yHyf0YSdJ4+mtCC9Aajp0vPQBpexO1+ZoVQcK97VQkAR1eWle8BpvEJS6GG+gH0HXA/XD16oZam416EQgscVEA5+4bzJJB0KSM37zMPHaOOdjV4BtuSaYSr36KYhBgQPlzV7tOIxkAOyhYND2aTb4yA0x7ukoG1ULcwLkwvxytllIngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ8+34n6tB2srgggrSYc9JS7VpTWsMEFMzObdI2BDY4=;
 b=j2kGg+bhM42UI4jsKC4w+X9TS+jPOuND2TIWXAZVIEhK34X/vCuIuxLUMAmJRgw+hgTruC5mpBXjXoZHxZa1zwuPY1T52WMXCgIVR+m29UUOeNfohwoWEMIfGsmKRpjmQCyV/bbHwaQFDl6CZfvMAWwrX15md4h4CTXBpuf8ayIkomMuVpOlakhXWtTT8taYzQ44nsGx8lLijfuehLFCKUpvGsup08B/6tQ1KY70uHr4ymP2Ik4t2zn3fKOXvZnTUkFiE+6HXARSROG5RpuPnpAfRNMPAPmS8K/0gYuemh4hkdOaMA/NSsEAfIWdcK6MwLwd8//Bi8DYWjgyIvM6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ8+34n6tB2srgggrSYc9JS7VpTWsMEFMzObdI2BDY4=;
 b=GGSHFOI+41Fg8phLddLCnSE12xkidgN1GUVFW4VWlrjLuTN6QU1Lig/A6TEZoQohNKLs8Eeiaqjy/Vz3QgXxTfzQm5AvMHhecCp/j5FJazoY/VU9lw8dd7wYOUGiAU7PxfHb9gGq7tOesTY6JJPJpyj/4SpaYRG3e5JEhQs50Mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:47:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:47:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 May 2024 14:45:47 -0400
Subject: [PATCH v4 09/12] PCI: imx6: Consolidate redundant if-checks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-pci2_upstream-v4-9-e8c80d874057@nxp.com>
References: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
In-Reply-To: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715107574; l=1050;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uRbYV+8P6VjCoxmSQ3mxj6dE+Tuv3Whv1pWoX9EvqFU=;
 b=3MmPWG8waR7Qnxd0N8fgyHKND+oBRxlIJRVKYtKS5OrYj7pKzRCJ52p106JvTjOIql/eVVDx6
 AvFjIssgrH3B9nSVsgDfpFHU5zj2Jdn0SILSp7uOAnm3aRSS6xeIY+n
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: e11fba36-25a4-4ffd-2581-08dc6ec61a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFErUS9sMEppZWhuRjJBQnc1YXRtMkdGYmRLdTJWU1dFTW9lU0EvYmtGa2NI?=
 =?utf-8?B?bEEyQ016ZC9UQ0ZoUy9KK3oxUndGYUtiR1FBRnFrZTRtZWVscFVmV0NmS0FY?=
 =?utf-8?B?bHBEdTdIc1ZocWFCdlJZZnlkMjdMTzNiV0srbVVEM0FmVHdFRitZVUw0eFVn?=
 =?utf-8?B?USthVmMwM2lUeFZ1QU81WENKNDJhOHp1RFZuc3Q0M09FWUxncFpINVV5M0Yw?=
 =?utf-8?B?aC9lR040R1NiTVBFelhWc2VmN0Zjdm8wTmU4bzJEYmV6SzB0VFcwbVlHZUNs?=
 =?utf-8?B?UUl5ZnBlOGJaSGZDRExkVWRHVll4VktUNHZaVWtMZEJraitBTFVhRlF6SlY1?=
 =?utf-8?B?ZDBrSzg4TTAvMzBIZktuaFRDdVNaVytlM0hHbENuUHZjTlZCQitTb0xDWVln?=
 =?utf-8?B?OFVBVjlJcGVQeU9VUnpqQ2x5Rmt6WEZEcnNLWlBkU3JTL3BhY2lJYjl0MTdE?=
 =?utf-8?B?Y1FIaUl0NVVidjVObHNTakJ3cm1JY3dMa25pY2UvbUNNRXp4YXBkM0MrdVdY?=
 =?utf-8?B?QVI2N3BjNFVCVlZUQzlzbjc5ZVpsRzB3N3Yzc205NjYvek9Uak5IcFpUcEt2?=
 =?utf-8?B?ZUJvRUQ4TlFLdWNQUmJKWlBmaXFBMjl5VU5ZQllDRTJvWW84c0JrZXVmaFhj?=
 =?utf-8?B?WTZKdFAyUVVLeU55OVVnNE84blp4QmZaYkhqZDN2MDhmQTNTV0tMelJCcldr?=
 =?utf-8?B?VndTQis2eHJQLzBqTzQvdTlWUiszYlAvMEF5ZkM0UXYyalByK2M0YUxXeC9j?=
 =?utf-8?B?QVBjeWpaQnFicDZXcHYwc2lIMFY4TlhFVWt2YUQ3NmZadzhzMmhYZW9EcUhO?=
 =?utf-8?B?aldSZWdmWlhrTm1LeHlZOWs1bllzYkdjRFVIVng4eWRheFkxQTlmWGNMaVVx?=
 =?utf-8?B?UVUzRjNkMFNUUE9MTUczNm9vQnY2ZGx3UFFFMDBETTVQZG1kMk91aVNyNXpp?=
 =?utf-8?B?aUE0bjdQVzZUTnd0MmVsbkFVRWh3OURwa0tMZHp5YjNzZGd6NWxtMThlaG41?=
 =?utf-8?B?dnZCRndBdllHdjlGa2Ixd1VIVWZDMXFWOEdNNlBnOURQUE55RGZ4ek9VVG50?=
 =?utf-8?B?ajlwNVNucFF1Wks0T2RmZVBzaFpQcExKUm92dlJYR1J2SzNHaVJxL2o0eFF4?=
 =?utf-8?B?cTZwYkVhZFhtOWVON3dMd3hXcHM3RDExK0pYcmM2Tm9SRWlnZUJGdTdOVHN2?=
 =?utf-8?B?UG9oVm5jM2FMR0JPcm5pbVpESE5lazdYSFNIZS96U1c1dmx1WE5IY0N5eWZK?=
 =?utf-8?B?NElMZ0d6dENXSnZOR3hhazRVeDUzRmhpSFFGOUE1RklHbUpjMGZ0RmxiVHFy?=
 =?utf-8?B?cFA2aGszTXhnNU9HN2F4QzVpeHY4TWh1ZEdDNmIyNEJLcGg3UU9sUDhTVE92?=
 =?utf-8?B?a2tCd1hJZzRUby9yRVh2Ym5PNHVWUzA4Kzd0Z1VJazhsVTM2QjZwK1hFQ0xB?=
 =?utf-8?B?RHRKeG5ZSUQyS1VRZktQVTRXT280Z2JCaVQ2ZVJXdyticDJoNFRWaXdJdDNk?=
 =?utf-8?B?WFp2dWo1Q1o2Vm1GNDRiWG9XQTYwQXA0YytsQnhOTjFDUURRVjVKR1dLVVgv?=
 =?utf-8?B?dlBOeTVacVYrZHdCbU9VcmRsQ0g3cE5pa0RYMldFTTQyangweVpTWFJOelNj?=
 =?utf-8?B?SWxFNTJKL1V4bzVzNk9TanAzdjh3WHVTcEVGbk1NUFVGNEJvcDZxSVFsdU5U?=
 =?utf-8?B?N1BieWpLYTVrN1NocjRRaldEUGtTc0dqU1Z4U2hCTG9nU1l0R0dPM2NDQXNy?=
 =?utf-8?B?ZEtnZHErWTVSLzNsbkpzdzJma25FbVhEd0JvUmhmeUlnTG5PVFAzdkp0WHJS?=
 =?utf-8?Q?5FvcWvBSzxke/E+AXgSq/ILjzz0SXabmCh7DA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW1SdyswZ0pFTmQ2SXU2Q3dOaHllNGR5WTNlRDRRbTdHOWMvN3JxeVRqTStU?=
 =?utf-8?B?dUdrOGIrSTlWcHdjYUFRc3Y2K1R1RjhnenFDQnRvTWhTRG1naUlwZGxER3g3?=
 =?utf-8?B?UmloY2tiNHREUG9NMEhUbThoeEpSeHFTT0dSNlBNQmlibFNyUDduUFNwaUY1?=
 =?utf-8?B?QjJjSU1VWEFtOGhJelBZd0Z5eDAwd25iYUsrRC8vOFFsVURmY3BQaWtKRC9F?=
 =?utf-8?B?dnQ2dEdjK1FQdGhudjdTOTNUQ3JKRStBRnBuZTVZM2hScWdDTGxCS3plUTVY?=
 =?utf-8?B?dzc2WllzRlRHLzFvVTdheEw2MGVuZkZham9JcVkySXlHRXNjcS9EQ3p2cGtI?=
 =?utf-8?B?ZVdCcEUvemQ1Mzg2UXRXSHRYVWVvZHk3TE1nWWNBNVEvNHdkSEZ2M2hLMGdw?=
 =?utf-8?B?RVVYRERBVWdxVERadndyWkpzb1hpSGl1MHFRSnlKZWc2Sm5tN2dvY0ZKVENL?=
 =?utf-8?B?QkZmR0I3bmhlTTYxYmxiUWQ3MjBXb1VLMW9GN0JJdWo0akVjWVloWDl3RFQ4?=
 =?utf-8?B?bmQrWFQxMFdXNzJIeGZYTmlnL3ZCWnJYRk81cGhtRDBUYTUvTW9iK2FwaHlw?=
 =?utf-8?B?eU5VUlNWaWNwbzNUdENzYmNoUlJqYkZBcm1VR1Btbjc2UndnYktGelBNcW9l?=
 =?utf-8?B?alE5cnNVTFhvMkZhZW1MbEZBWFRFWnlWdE9MZW40WTBpRWNpdGxNbnlxMWpj?=
 =?utf-8?B?UTNnbGxMbkw2M0NIM2pGL1BUR3lxVW1lZ1M1NEsvZk96dE9KdGFiNlZGcUZz?=
 =?utf-8?B?NUhpTkI3MXhESDFPbUZTSkZTU3FHMFBUT2ZzTktNR2poL2pJeFVzai9kSkJ4?=
 =?utf-8?B?VmxaRDNzdXFnclBoRzZsQitDcjF0QmRSS0JJZ3Vucko4Y014T1NKZUlXSUEz?=
 =?utf-8?B?NWF6c0RQeWVET0xrZUNDb2JNYm9KSE5ZTWszaHN5U3ZRcnJQWjJEQmNYSTNn?=
 =?utf-8?B?bjFIRkNhVnEwa094bTJTbXhiQ01BdjAwVll4R1ZrdFR5R2FjUzBiUkd1UThv?=
 =?utf-8?B?NWQzbFREeGR2NVBHRmlvenJObkFDY3pQQ3FYOUp6RHFPaDVBaERITHg2RWVL?=
 =?utf-8?B?SVJiMDlQRmQyV3NZUnI1N3h3bXpOYzNSWDl1OU9MdFMxQzJqZEg3OStUUWRP?=
 =?utf-8?B?MjNyVXlzc0dJd2l4anJWczFScm5hMnpHa0RDRkl3WDJZVjdlUHRSRlNMOVlG?=
 =?utf-8?B?eTVhZENUbUFaa0padFhqSmFac2tqdUJ0SzRmMzd2VVFQMjdrd2JUdlc5Y2VW?=
 =?utf-8?B?YTBEcTVWTUlldW92OG9ySVJ6ZHJmZXFYK0w0elhFTUY4ZVhmeDN0MURvWTdn?=
 =?utf-8?B?bUd0UUhVMEtZa3VGWGZIK21WQ25LQ1NRQ0J1cElHUm05S2Jya0Q5dDJjSlNB?=
 =?utf-8?B?NjRja1BrT0hFRi82UnJRVjlkL1BrOVdxWWhBdjJxVDRoVHVzVGFLcWdkcDY2?=
 =?utf-8?B?NlFaaEpjcHlnYXVHdVNMRFZTVVBYZ1g0RnJhYld5azVMNHVHNHlkL2lDUGlC?=
 =?utf-8?B?OENzNzduMkVGdlllTTZBUkcvWlgzNnA5NWIxU1phVGlEYlMvaSsyWkg3Q2Mz?=
 =?utf-8?B?SEdGNHdZT1BQZVdTZ2d0bG05bnpwWUpzcS8wejUxSDZFNUpjM05aa1JySk1r?=
 =?utf-8?B?RkVkd3Mwc3d5MkpSVEVkSUJZdlQrbUtNMUQ3OXJrbnpRQk4xMWN5b1JDOXpD?=
 =?utf-8?B?Vk53MlpRcTQ3NFRvZ3dmODVQNGRWdFk4ZmpXelJxWE5DazVXM212YnJIL0xC?=
 =?utf-8?B?MW9QR3ByVFBEY1dmdWJFZ0JIV3c0emJXQytUOEpvck9DbDBlZDl3SERIV1ZO?=
 =?utf-8?B?ZHR3LzJZeGttVGxCK3VINk9zZ0UrZmovSG1sS1lScUtUY0IxRzQ1RExYS0t4?=
 =?utf-8?B?LytuNE4zY3FKeU14NVlzZ3lqVEZXTmt4V1hTRUhMcldwdU1haEhpQ2FWV0dQ?=
 =?utf-8?B?ZnRBS1QyTkE5b0o3TmhVREluS0EyV3I2Y3E3L2d1VWQwNDlpam5aT0kvWWhz?=
 =?utf-8?B?N05VUzc0ZmNuV3E4NFp1aE5EVDU5N2puS09EZnc0a052a1YvenZWRkpSdjJ3?=
 =?utf-8?B?QVNic2JpdUJQem81MElMdkpxL1l4eDdLZWY3a096YlpiMHhNNnp4NFpUOEMr?=
 =?utf-8?Q?ryMwUkVti8cvsvxons0e6k8U8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11fba36-25a4-4ffd-2581-08dc6ec61a8e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:47:11.1642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouo/zVVN/tohMTENLt1VHAQkdQu0AsDS+fddF3hkweZvusMCxqI4Pqj9kS6zMGMAeluNFQU9+EvayFDzlFEbIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

Consolidated redundant if-checks pertaining to imx_pcie->phy. Instead of
two separate checks, merged them into one to improve code readability.

if (imx_pcie->phy) {
	... code 1
}

if (imx_pcie->phy) {
	... code 2
}

Merge into one if block.

if (imx_pcie->phy) {
	... code 1
	... code 2
}

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 66573ef7a002b..9d53b545540c6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1033,9 +1033,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			dev_err(dev, "pcie PHY power up failed\n");
 			goto err_clk_disable;
 		}
-	}
 
-	if (imx_pcie->phy) {
 		ret = phy_power_on(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");

-- 
2.34.1


