Return-Path: <bpf+bounces-31541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645FC8FF6DA
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 23:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7732874A4
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 21:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840A5196DAB;
	Thu,  6 Jun 2024 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NnIcilgh"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0DC13BC02;
	Thu,  6 Jun 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709115; cv=fail; b=K5Od5S10PhtKyuGySdYU6DD62DHTKARw/wTxZhK67tUh+zu7swRqARmnKBMlFyRi6GUbJ0tPZ/e7ceKkvvZReCWSi6C+4HkO7ChCNOEKqMzzfi6SovEKAg3KLtb/40E4wumuJBBipxIumug5OY7KqiCd6gzRHYC+afwFje51U6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709115; c=relaxed/simple;
	bh=HmfdxGopgWDB60wy2mjFdkdQovhRBY2kxpfNvHUqe4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lZVIRKnqAIo1G4Y/RFONBUy7MMcrrRRE6BGf5rA/jNm2hP/5YR3OsYV46Rf2g56ye6yR99AFJr15mEEBfIRKhYaHC1MhoZUbhxfMrUD6nys8AnHPX+WAUdDLhiLpWJPwXJwAu5KR3gPd3kaarcjdlx9eL3T7oVzlA2OeMf1OQXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NnIcilgh; arc=fail smtp.client-ip=40.107.241.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrQILZc303gVNM4AOXs8lHafeFeYwtag/09x+BTWcCylhLU/bHtqxsvu1dPRTtAbKcBUy/YrvFinDtKmlF7SirRj0r5TNSOHN2leDc8oPuj22vMICYwCZFVB0Yaz2WwUYYIzI7PoIlJmmnRdXSJAqAItofyA4xVkV9adq5KJNlTsUXkNBKKvCkLI0SMphQ5AK+/9tIt0KUgNqsFSLzLGnIvRHlFDEpzO7lVpTo82RF6hnbyKoMzd4dyRfkyLPm21cWohcHkYvgzmAjfLcvuoqTXuIVntM5Bgy6fjnapSGm+lm7F1phpM1A1PEegIfHBjmrmqlORG65SJ+iskCUfLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ym67aj83xOqAGGtJMxPJEvtdQTLXLGaJyzz1q5CNVPs=;
 b=D3AwgDcp7ruQP96bP4RN7C11OdyBigBvNzQmoc0q8qLgyo4CBL5KUm03Xvcj3u1kVmpPsij6k88gsdUQ82/wiULDSBw1bHnNUtZgj2gZc9aEtijxoXWBUHcSxjXNA3uQaI+VeM9rgPyIgRjt5hpaigxjsuC9q27j/ymVowxpnHwck5yZG7rSCnLwKjTvL+TYPC/yu5KixzjUsWf2Oc2l08dlBeNuf3/ad7CJ8Ed3x0Y/cGWwePXORKaCUxvgEpx2F2s98H6vuBWCOogYWH/ITxrjZyuvht1S0v3mzQw5R2IW+xzohmglkzo2UVpeNPpC1++yWStYAmswApkp3emOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ym67aj83xOqAGGtJMxPJEvtdQTLXLGaJyzz1q5CNVPs=;
 b=NnIcilghv73LKWZDT2XvR7wVcad4jdrtdcbgDowXEEeiItIAB39FKmscESF1izlezdQgOLvwSoZvFnDtOTgKErIzenGuwNYyTuLy9Q5lpGgkQ1scNay4UY8XSl0Zhc52ndsO7sMn2KJjw4GM8G0MNplyrjWp68XwY781lFnSyvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:25:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 21:25:09 +0000
Date: Thu, 6 Jun 2024 17:24:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, devicetree@vger.kernel.org,
	Jason Liu <jason.hui.liu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 00/12] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <ZmIpK4l6fdZ9BZu/@lizhi-Precision-Tower-5810>
References: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
X-ClientProxiedBy: BYAPR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8154de-c5e9-4168-150c-08dc866f2490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|1800799015|7416005|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0hCckxha3dISmYyUldXNnhhZlhpNkVuRDE3dERyaGF4M0pGcXEyaFloTUtV?=
 =?utf-8?B?TEJ4ZnhSaDhqM1N3MFZBb294L05xbjQwQTh6dlZDK2tLT083OC8rSTNNaFlk?=
 =?utf-8?B?RS8xOSswaURmc091dHRTcWY0RExQR1BTSGE5M0ZGTHN2QXg0eWtpR2MwYnUx?=
 =?utf-8?B?K3FqV1c5cGlMcGU5RjVGTTN4bnZCbWpKUzdnN3U5WWVNdGdQZEJxdkg4YkRy?=
 =?utf-8?B?K3ZmTXZLLzlvQ3RDM3pCenZReElQMG5QRTNDamtDdXNIOE1wMS9ZREV0WjRj?=
 =?utf-8?B?T1hPc1JpVEFNMnRHTGEyK1haSGRibUV3b29oc0NuaWlaRFRQTkZWZnRjYXkr?=
 =?utf-8?B?Yms2cHZ3QUtDdVUrNGl2V3Q4czkvSWtUUWRrd1VuYjJCOGJzWGJVREMzK3BW?=
 =?utf-8?B?TVZUWCtJalQ0ODV6SFpYTmpQVnpjTW9YcVpvcERKR0oxWFdvc1pWbDFXcjAv?=
 =?utf-8?B?ek1vTEJseDVUVnJ1WnBGWXBWd3pZaU4rcnRUV0h6bFlmeFBEK3pVWEF5ckdr?=
 =?utf-8?B?RDAxdll5dWNrME02Znhocm00N0M0SkxBWllRS0NGdkg5MDFOSnhNSlZLQlpi?=
 =?utf-8?B?b3JSd2xpNjNaT3laZ2YzODBFZmRiU09PMFVtT2tyeGtHcW82cWZyaC9WczJ1?=
 =?utf-8?B?ajJVRDU3V2FrTVJ4TCtRWm1FWnBWUnVPTXZDQ0lucTR2OE12L1RTQlRlQVNJ?=
 =?utf-8?B?dG1VRWgyTGIwVUVMNFAyY1k1TnFOUmFPQ3pEdnZyK0U0RWg5clpzb3A4Ulho?=
 =?utf-8?B?UGJxeHAwYzkyRlRLbzArMmI1QkRZZVNSYlB6UElTSGJybisrRzFEZEpTeGgy?=
 =?utf-8?B?NXFuYzlLRXFyNzFCY1duT3A1eEY0NndVSENUQmdwNzdpYzdXckcrbDVnVVht?=
 =?utf-8?B?WFJrODFFYy9kTUN3L3ByUk1nbStkUU9TVS9XQUhaNVQ2ZlBKT3JFditJMEc1?=
 =?utf-8?B?NWE0c0N6ZTdnOE1LQU9lNHhFZ2JFV0hwVGVJMEJpT2M0NFFKZnBVTTVpeHZN?=
 =?utf-8?B?NmNJaUR0bW1wSDh2S0t6clo5Skc2OVYzNXNsS1dsY3NzK3NYVUJuT3o1clZW?=
 =?utf-8?B?VzBVQ0dWc0kwVDA4Zk5tUFBRNUs4RGd0c1ljTGhaWUtDZmczcWJrcWpxdGNl?=
 =?utf-8?B?ZVdnV1VSZFRQSFZzNWVCOEJFWDdzMkRoVXFvczVLUXBSbE5JZW93RUliQjdF?=
 =?utf-8?B?dGkzSUxwZEJPV3hSYzF2RXJnZFdsRHhoYThBSmlIaFYzTFBWOXJRYklpbDJv?=
 =?utf-8?B?WXVaUUJTWjAyMS9Rekdkd3FpOVU0bzhwZVJzdU9iL281TU1nbEMwV1JxNmVC?=
 =?utf-8?B?SkVKSmZRbEdJcS9ZNitxQlk4T0FoeFZUT2JoamJHR1hXQkY2MVFLVEpKS25R?=
 =?utf-8?B?UTlnZmhGYit3d1lLamhXV2hPUzlBY2JLQ2tyanYzbGJxWTBUTVlQRW5haHha?=
 =?utf-8?B?Q0RVdzhSdDlFM1A2TnprKzFha3dUWi8wSjNWbTRVQms1VGJhK2NmTlU1cFBV?=
 =?utf-8?B?bU8zRTErd20xeWNqSDZVSDlqNzhKdlI4K0tYVjBwdCtLV2xpQllNQ0RtOGw2?=
 =?utf-8?B?RER3bnhBUUdlNm9PVVpDNi8xWUs2ZGZUcmUxWnp3bnRWLzFIRUNzTjdRODJB?=
 =?utf-8?B?MXBFclRmbzBwdEIvWjZxUVFLanRPNkIrejJqT2VXODhKb29NYWVudHRPVkRk?=
 =?utf-8?B?eUpxS0VESXZJOEdPQnhvNDJwSU56a3ZTU001WHlEREhKL0NRTU1URC9sbDZN?=
 =?utf-8?B?QUtVVmZ2NVVXS0VxeGVaKzJLS1d1dEFIaWdUc2FlVjRsUERoaTEzSGh6aStj?=
 =?utf-8?B?R2pnT0VSSVFqVzl4OGY1VkxRekQ0ZDlDcDd4ZWQxM2N3QXFsait4M1YyQ1VJ?=
 =?utf-8?Q?hH1cQBUnrB57S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(7416005)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anFWcThVeXJpd2ZGNVFOeHZVTnZRUEgza1gzc0RVVDVVWVUxOG5ZbkpleVpj?=
 =?utf-8?B?WVRmWlBHU2oxR2JIMFlzeDRhMHp0aGhqWnFiOUhIRExodGNlV1NTYkZwRHRK?=
 =?utf-8?B?N3NmbFduUURSYUlvTFRqeFN4RExDYlB5T3NWSFMySUE2TkRycERJRGwxOGlT?=
 =?utf-8?B?MllrRXVOQjR2UHNxTVJlSEhCbkVZVDNlZStubjhWWTVwNGFoRzlESUVuYjB2?=
 =?utf-8?B?Q0NybDlpcmpuZExqVmtTYkxMNXdmSUlSS0h4Y3JYQzBBNzl2UC8vTnF4S0Fs?=
 =?utf-8?B?VVNQTzVBV0JybnV3UTNGK0twbHhrVEMxZ3UrUjFNUHI1eTNLdFB2RWFxa1pN?=
 =?utf-8?B?ZkQyMVdMNDJIYVdEbDVaTkxQWnJsTHZtbjBXc25VY3NmUDk2Ulk3RG5hMFVM?=
 =?utf-8?B?ZG5BSUJVK2tmRXJwQ2c2aHd3cHl3UTg1anNHeUt5dWE4Wnd2R1RXUWF5SytS?=
 =?utf-8?B?RU9hSnJJaTU0NExLK2gyR0UxTEx0YTJpbXE4bVFoaTRHMWkwd3oxc3c1Nitt?=
 =?utf-8?B?RFV3b3huem1kNkZ5L2JzbTN6TXVPcm1ieTd6VVUrN2RodW5sV0FZc3VFeTdN?=
 =?utf-8?B?U2pPM20vclNzTDAxUlM2bEp4alpVUHVrWTlFekJIbWdLTHJqeTI4ZStJdU5S?=
 =?utf-8?B?ZFdHeFhISjJyQnhpa2wrKzJXN050ck4waEp6ZkRyNWpLcFV6Nkk4bk14WXdx?=
 =?utf-8?B?ZWFvVGFxZ1JnN3czdnQ1SDdicm9OT1NOQlYvQ2V5TVBTcW5uMjdsWGljRVJI?=
 =?utf-8?B?dEJSWDFvOWNzbENibTdyMmIyUkhZTWZ6VzB2bnBTdVdremgyRHJjQXFQQ0xl?=
 =?utf-8?B?cWlTZzhjYXRlc09ydXJaVmQxNFZvdTloZ1NJVEJyaytaOVh6TVNkT1A3R2FQ?=
 =?utf-8?B?YlorWjhYc2NyWGx2WDJaOGxQREFjZmFlUGk0THpnTkV3Qmwza2t3cFA4bkpF?=
 =?utf-8?B?OEJvMTJycmwrTTB1c3AxNzh3ZjZ1U3JFT29MWkl5TjVncld4SU1Pb2VMMHho?=
 =?utf-8?B?RGs1bmJDWi9KLy9OU3hTZjVoejdNa210RWwvSXBSQ096bVgrVHZpZVNPWDV4?=
 =?utf-8?B?RlVkOEdRcFhZTktIdkpzNjZOQlNhYlpDeFBRL0tIc3FiY3NuRVlnYnRDbVJz?=
 =?utf-8?B?dHNybmtEeStlYUdqdDFDZXZJV2RVRU9mMWxKRk40QzVzM2czM2ZvU2RIUmdi?=
 =?utf-8?B?cVFUVUJQdFNERlpFZFlQaXF3RitTZWJSOGtJdUUzZWd4MVd4ZjBDQmJtY3Mz?=
 =?utf-8?B?OE1Ka3l4aWFLaVc1enR2S3B5TFEyemY2dHRiQ3c2cG1DQ1lVK0ZGUllnbVdk?=
 =?utf-8?B?QUlidmkwQTl0NzdRWEIrWlJPZzZiM1NVNElHU241UnNCc1pQMjhrUnJlNGRC?=
 =?utf-8?B?TnY5WFp1U09nbkRMQ2hlblNFdFI2cnpUdnJIemtZTzdKT2ljRW0yeVZiSVFX?=
 =?utf-8?B?T2JYQXQ4QlFSTk1VQkFLc1JVSFFMZFZOTHpxSExCekh2ZlZyb3BVQllxS2lL?=
 =?utf-8?B?SXJTQ01tRHlneXdId3QzS1Ntbk5jamhTanZGaHNNcHZPbGRHZHcrbnZ5NFAv?=
 =?utf-8?B?VFZqS2tsNjFEYjVYdVQzN1psSldCR2U1V0VtZXdQQ2Y5OXVWOTYvbUhPOU8y?=
 =?utf-8?B?SGJicnBXRzZOQ2lHK25iR0ZxTUtJZE82Vzc4djlYZUh4SzVzcFFhL0tncUdq?=
 =?utf-8?B?cVpIODRjTFdMT3NSYUFxMmIyeGNNMDlyNysrQmJDZ3BMOGo4dWI4WDNnbzR3?=
 =?utf-8?B?RFB3SmlxYmVkQ1IyNG5aQ0lVRGxtdFkySWhaRUxCT2M3TzdMZHRhZGllNld2?=
 =?utf-8?B?ekx0TVZrZmlwemlnNUc3QXYxQlo3UUE0a0czR0VoUzF1MllianNlWStvc3U1?=
 =?utf-8?B?Ti9rTW9obFNrVUIvNWViY0h1bTFxS3FBQmkvSG5ZNFlUS0ZqMjJKTW1jQ3dC?=
 =?utf-8?B?b0F4TWUwQ01JRm5jWlRYc2pOSm1mWXFJTFUvcHdoMGhLM1FvK2VEbkpyOHlD?=
 =?utf-8?B?WXBOZW1JcUtjeElDSFpjcTRXN05oWjZmdmJ6Mm0xSjVGYXYzdmlMVUJ2NFVC?=
 =?utf-8?B?aUJiOS9tOFFNWVNzN1pPZHBsVzh1S0ZaVXI0enl5YllqY2Z5Y1U4NEZYQWhv?=
 =?utf-8?Q?NTPw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8154de-c5e9-4168-150c-08dc866f2490
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:25:09.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iim0MBHXov983LWy7iAYq2FN2kvtJNAmVHbDirH+HMlAUnsVjIkaL8I1Eo/CLzmaDQa+cS/aDw8YyZ/1Oeatbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092

On Tue, May 28, 2024 at 03:39:13PM -0400, Frank Li wrote:
> Fixed 8mp EP mode problem.


hi Manivannan:

	Do you have any additional comments except for the patch
Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95?


Frank Li

> 
> imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
> confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
> pci-imx.c to avoid confuse.                                                
> 
> Using callback to reduce switch case for core reset and refclk.            
> 
> Add imx95 iommux and its stream id information.                            
> 
> Base on linux-pci/controller/imx
> 
> To: Richard Zhu <hongxing.zhu@nxp.com>
> To: Lucas Stach <l.stach@pengutronix.de>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Krzysztof Wilczyński <kw@linux.com>
> To: Rob Herring <robh@kernel.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: NXP Linux Team <linux-imx@nxp.com>
> To: Philipp Zabel <p.zabel@pengutronix.de>
> To: Liam Girdwood <lgirdwood@gmail.com>
> To: Mark Brown <broonie@kernel.org>
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Changes in v5:                                                             
> - Rebase to linux-pci next. fix conflict with gpiod change                    
> - Add rob and cornor's review tag                         
> - Link to v4: https://lore.kernel.org/r/20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com
> 
> Changes in v4:                                                             
> - Improve comment message for patch 1 and 2.
> - Rework commit message for patch 3 and add mani's review tag
> - Remove file rename patch and update maintainer patch
> - [PATCH v3 06/11] PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
> 	remove extra space.
> 	keep original comments format (wrap at 80 column width)
> 	update error message "'Failed to enable PCIe REFCLK'"
> - PATCH v3 07/11] PCI: imx: Simplify switch-case logic by involve core_reset callback
> 	keep exact the logic as original code
> - Add patch to update comment about workaround ERR010728
> - Add patch about help function imx_pcie_match_device()
> - Using bus device notify to update LUT information for imx95 to avoid
> parse iommu-map and msi-map in driver code.  Bus notify will better and
> only update lut when device added.
> - split patch call PHY interface function.
> - Improve commit message for imx8q. remove local-address dts proptery. and
> use standard "range" to convert cpu address to bus address.             
> - Check entry in cpu_fix function is too late. Check it at probe
> - Link to v3: https://lore.kernel.org/r/20240402-pci2_upstream-v3-0-803414bdb430@nxp.com
> 
> Changes in v3:
> - Add an EP fixed patch
>   PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
>   PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
> - Add 8qxp rc support
> dt-bing yaml pass binding check
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx6q-pcie.yaml
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dtb
> 
> - Link to v2: https://lore.kernel.org/r/20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com
> 
> Changes in v2:
> - remove file to 'pcie-imx.c'
> - keep CONFIG unchange.
> - Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com
> 
> ---
> Frank Li (8):
>       PCI: imx6: Rename imx6_* with imx_*
>       PCI: imx6: Introduce SoC specific callbacks for controlling REFCLK
>       PCI: imx6: Simplify switch-case logic by involve core_reset callback
>       PCI: imx6: Improve comment for workaround ERR010728
>       PCI: imx6: Add help function imx_pcie_match_device()
>       PCI: imx6: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95
>       PCI: imx6: Consolidate redundant if-checks
>       PCI: imx6: Call: Common PHY API to set mode, speed, and submode
> 
> Richard Zhu (4):
>       PCI: imx6: Fix establish link failure in EP mode for iMX8MM and iMX8MP
>       PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI
>       dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
>       PCI: imx6: Add i.MX8Q PCIe root complex (RC) support
> 
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   16 +
>  drivers/pci/controller/dwc/pci-imx6.c              | 1181 ++++++++++++--------
>  2 files changed, 730 insertions(+), 467 deletions(-)
> ---
> base-commit: 50d96936b7b1be01bcc7b9ff898191214ee72697
> change-id: 20240227-pci2_upstream-0cdd19a15163
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 

