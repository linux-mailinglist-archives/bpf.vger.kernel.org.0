Return-Path: <bpf+bounces-40470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6F798927E
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 03:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFC8B23A6E
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 01:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17410A0E;
	Sun, 29 Sep 2024 01:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AqzmDBLt"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61C14A91;
	Sun, 29 Sep 2024 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727573743; cv=fail; b=C3Pb8F6NQrgocRTg1QH3XrhUCOHBkVPBng9Ka8Vx9YaTS/JXMYnUlb31fKUhYweLWA7C/Ns9qs5h5bzyE8PmFDn2th4N5RUL1Pk4/LafR4oDy7sJ+xZF3Z8aLPTwZgIA8xvwHL7fL5Yw7KWmB+DwjXrQN6z2wX8WXLmK7CrxSmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727573743; c=relaxed/simple;
	bh=F4uhSzBRqmfpTNWE6j4K7fr3FFMXYgSz31C8wUyMr5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l99WB406DGwcJjFrDgpkvQzzMylVEQE/FiGLwyhHad7u9VOvb2RCR+7UwU+DXkgNYAyPUd0DeZ8z4nYXfvkfWDWC3L9WJ+4GbeGGUH/tbAt4fYmcHztycsF2OzJ3TxWX3qUDbCTKCO/HV+pNhvKMRZlk1idBD0TTMj8asb2UhG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AqzmDBLt; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQzLdoRavV00+yAODT+29/ZQZ0jiYrGaMt80McEaRc1OnAyS8amDtNGlhqyy8jFAsy5CL4rmyqA2kEtQlA0y6VgNUqBNl/CG+L/RBjL6HQV8/ehzlfXxlzSXhuKj/tk/OzdjzpvFfXLu22/tp4FKyX3nvf4HckROgQNHZRHnzmjLMTlQEpoorS9Ir2CyTurr79DZgxzgxiyV7cNQvJQ/Wm7LJQ4w8VvulQ5e8sDnk9h+y6EKGIh3RvVaXXDeu/yZfWLiZGAKS7rX9j+t5dYz5B8Lqu6K/cpeddacIglXO+nQr+P7pXPHOiw3IdT611FuyCKzUlYWmdZD4QqJd87RxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4uhSzBRqmfpTNWE6j4K7fr3FFMXYgSz31C8wUyMr5A=;
 b=eC8yujpHj8Kmd10ohd4ze5F+36aqxKWcW9BNvT5SQ81FJGKV0DEu1M+kqZmEF2KvIYgVCI5wHY9/rkvIMArKh/xsarSO8QcpV676ZqE/SgNKrO2N1ETeUDhtvlMHcohGCIRZi4rN8ht9SYaEXyOk8W+0XEHUOev+OA0awbV7eFUCxUAW8knB5NbA1iLjOpayMU563HDnvTWk88i/2Y3FolKexRyAQoHWLfIU6ZC6EaC4i7ZP3nukDSUN8lxmT3NcYqA6jiBpMVVEK2bznbMUvLUJ9tCtlACJ3q5sfPLk5wDpxPLQqkxxPKbwfHLz/lWLA1+O8aNLF3tYSuWBvPh88g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4uhSzBRqmfpTNWE6j4K7fr3FFMXYgSz31C8wUyMr5A=;
 b=AqzmDBLte7/ZtS6zSAUpIIMTqEiYuEtFHormJ++PqBjMncwzvoGHtYJrwX4zURsFckmZOfMLirTDruxAb/5H/IkScFb0X4Ca+UQQChT9sRJxzPohIkaoFeRlJC4RETrA1Z0Zkdqe5vAHg1id366gAcZlJb3vkJPZEIpyc9j3xxvg3ePPy2lRSphOADuBpuZCWoK2rETjQM4dhFRnNpcqSXt9FuqFq76aQtCfnqY8Dvtdvg+KU/cKLO6R9lufEHK8ntZ/EkmdO1JBI7A1lJmejWoHYSrlqxIFu+eukjC2dAwci8rbibO1p0ksXJImysrKoyUYIsJe7dr65MgGYlPtzA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sun, 29 Sep
 2024 01:35:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Sun, 29 Sep 2024
 01:35:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net 2/3] net: enetc: fix the issues of XDP_REDIRECT
 feature
Thread-Topic: [PATCH net 2/3] net: enetc: fix the issues of XDP_REDIRECT
 feature
Thread-Index: AQHbCnHP3LBcIHim0k+ndq82WEz9VbJrweCrgAJIHSA=
Date: Sun, 29 Sep 2024 01:35:38 +0000
Message-ID:
 <PAXPR04MB8510FB983338827ABBE896F088752@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-3-wei.fang@nxp.com>
 <20240919084104.661180-3-wei.fang@nxp.com>
 <20240927144143.5ub4sqayqqdofscx@skbuf>
In-Reply-To: <20240927144143.5ub4sqayqqdofscx@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB8PR04MB6777:EE_
x-ms-office365-filtering-correlation-id: 25fa70d4-2d61-4b6c-439b-08dce02705d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?YndlU3NRak12RkFkMU43N215MlU5TS9VTnhuemhnalZkb05UcDZTejNaTjRE?=
 =?gb2312?B?bWUxbldHY1BaekcyLzhiaFZqWHY2dklhL2RsNzRoelFVdVp1WGpjZzdZa1lV?=
 =?gb2312?B?bFNuK3JnclBFeDdwam1MbXBFcjl4MjR0Y2J0Y2VUZmIzWXhnVWY5SVN1YXRW?=
 =?gb2312?B?WkhUTCtFa3lQcGwvc1NCaUtQTjZXVEtVb3pOYXZaWnAwQTdmcGJVMEJtT0JM?=
 =?gb2312?B?UUVZazA1ZGoyejhHdTAzUjZPYkhVeXZpbTI2S0owQWY0OGNMcUM4Zi95N3Fi?=
 =?gb2312?B?L1Jua0JWQjBCQVJlcXlWZlBLTGF0SWo3dDJyNFc5NDI2WTBsUjVsT3JBQ2Vm?=
 =?gb2312?B?aUU1UDBEVzZucXRkYmRLVjNsaUFtZW1aWTMxbzZ2a3hUb2VvZ2lVazM4QjJn?=
 =?gb2312?B?dTRTd3kySkROSTBmVFY4aDZ5OHV4Z3dhdk9xN2ZVTTdQa1BnZ0cyVXRTSVFE?=
 =?gb2312?B?L1hkWXJiSXZqcmNBWVE5N3RpTWZ5WjJjSFFmbndpSEluR0w4ZkJjenNzdUZR?=
 =?gb2312?B?TTlpNXhNajNmMm42Mnp2VmIzaFJPb0IxM2xYK3dwRm5SNkRXTnNYKzU0dkZY?=
 =?gb2312?B?ZHk3YVdFRWh5MWNLalNVQk1kRXVHaUpNTUk5cGNvNTArRWRCOFA2OER6Z0Fa?=
 =?gb2312?B?cHB2SFdJNnhNSVFDSHR6ZnJFQUtQK2lGcVZJeWhEMDVSV1RCMERlVDdvVmM1?=
 =?gb2312?B?V2pxNGhTUFJIT1pMSkNqTFNCSk14emZaQng0TVY1dzhJM1R3TlA2MEdmYzNL?=
 =?gb2312?B?eTNSbWlpVStpTERhR0hKUDQ3ZjBJWmJ3aFYvKzd3YmN2SG81L2ZpSmY0M0xo?=
 =?gb2312?B?RTVTcStyZ3Y4UjdBcmp3cnd0dE5pSkdiZGthUDBDR3duYTdsbE5nZkJTeHo2?=
 =?gb2312?B?aUJyTFp3OE9GejQrUlNldjg3SXVxeG1tMTFBZkRlSUVlU0o0SGJJVEdoNTA2?=
 =?gb2312?B?RDl4MjN6M0ppOGxGSExpSE5rcG1YK2dJV081amdrNXEwN09oczd0VVFkZ2ls?=
 =?gb2312?B?Yll5NTFWY2xuRUVkZG9RMytwb2lPMFN3c0U0d216UDVQTWNGREV5MGlRYlJ6?=
 =?gb2312?B?ZEVVQWNMM3ZzbVZBWDc2SGlQdldGK3RRRGsrRDQ1QnEvN3RldWM5akgvK0FQ?=
 =?gb2312?B?U2o1a2V6RGFLNnJjVVV5cmphT3RXZ0tLbmQ0Mzk2aHl5ckM0ZXcvUzdEbXJV?=
 =?gb2312?B?T0R4TXNhd3VPamVobWNDOVRQbjBwRU05aEp1SG5kMEt2OGpCOFcwODRFY1VR?=
 =?gb2312?B?UW5YOVFWL2FUckhMc2F2bVd0K1djbzVZQ0JPOGhjdUQ1ZXdWeEFna2EwbXhQ?=
 =?gb2312?B?UDdobjg5NnBHL1FLWlA5bjJKT1hpK09OL0FMOVZ2QW4yUnNFSGFTcExVZWI2?=
 =?gb2312?B?anErdHB2NjZQQlAvcUJCT1JrVklXc3FVWUhQdFVuVk9wUW1FRUVaNXQzVFBV?=
 =?gb2312?B?SUd5MnU5YTFTL1lxMlBuS2VQQTQ2N1piNjdKVFlEMFdVemlSTTFJc1ZzTjdS?=
 =?gb2312?B?QjNJQmZtbk1EVW9lbjB4bGhaMm5JcXVXSjFwTzF4L1VXOU5LWWY4N3VjNStT?=
 =?gb2312?B?MWlLNWtTYSs2N00xbk9NVTh6YXJacEpsUmdTYWtaZkllendKVUpmNlFDTml4?=
 =?gb2312?B?WURlcFlETWs2NnBvVDFwMUtPMjYvcjNWNmxQZUI2bE5yTTlDam1yWkdsclRh?=
 =?gb2312?B?djhFa3k2TzZrVHNCdThPdTR0OWQySi8yOGZVMUhNcmpFaEFmUFdEbk8vc3FK?=
 =?gb2312?B?bXpnZG1oTFViNFVmckJYOGZMczB6dGx6bzI0UDMvbDZ5WjhlNFc4cXFWVVdh?=
 =?gb2312?B?NjZveWdQK0RBM2FEOEVuNXd0ZFNsczZtVUpiL2NqdVUzS21aTVdsaEoyRGJv?=
 =?gb2312?B?cUNCMCtqZlZtT0l6Vyt5eFRNKzVJTUZlRi93bkNteGx1QlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Zll4NERxOUhwb3pvMnRTZHRTSmtGZGs1c2ZaL3NNM1gvRm5jRVRQMzRFY3Fa?=
 =?gb2312?B?akpyWEZBeVFUaTNxSGNQWmNSbThhVzFRWDM3RGRHR1VMRGdUYUNsd050dmdl?=
 =?gb2312?B?UWthdGU4R3RJZC9GcW9IS3Vwa1Y3Nzh2dmJ0Rks5T3lOUXhvS1BDSFBuOEFv?=
 =?gb2312?B?bUkzU0tJRm5HdEFmUUZoczZ1ZTdIZTI5Skt2SmttM1FnQ3huZ1NDS3lEYW5m?=
 =?gb2312?B?alF0UG9XR1c2STRGTFE2WVYyVThwWnZhdW1YSXkzNGdWS1daMThWeGdLc2Zr?=
 =?gb2312?B?MmlGdFVpNXpvRVVHUFlINDU5Z05kci9GNGJ3K0Y3bFBaQ2lWeXovd1VFWHFN?=
 =?gb2312?B?OFVZeE9OcHBMNWFtREZZNk9UTVpXM0RCa1JHUGhTRFl4M3lmNktYMEhLYitE?=
 =?gb2312?B?Y1pidEJXNUR4cnJpaDJmQmlQZVp2dnFuMHYwTjRIeXJCVkt4aTV5Nmc3VEtp?=
 =?gb2312?B?SVJRRHdEQVdMcHRnVSs0bFRaQ2QxZ2RZTXJzNGxzd1hORUFadis5ekNHcDlE?=
 =?gb2312?B?KzZleXlUdFB3WjhkL3VBNGhocGNSRkpKZmtVK2ZMRmgwdnR2QlpLcTRsUzhO?=
 =?gb2312?B?MGVmZkpvd3JCNW11cU5mandCMGVydHYyUUxDYmh0TTQ2T2ZxOFFMK0F6OHJP?=
 =?gb2312?B?SnBmc3ZLeTlDQXptWFptWjVEYlF6L3p4c0pKTjd5TFJ4WVhlSlVmRVVtSDdU?=
 =?gb2312?B?Znl0bkh5SHdEZWVwVWZSL2kzbVZKQzhBdGdiVDVhUTVWR0hwL1ppZjJtdHZz?=
 =?gb2312?B?UXZxQUJtWXlIdExyVkIwODlSRE94aEFaaC9QakF6V0RURFNnQVBtdWNPTFUx?=
 =?gb2312?B?U251S25lOWt5Um5zN3k1RDhsOHZzZm54U1lkZGNPcHhLbHM0WllwRkk0d0tC?=
 =?gb2312?B?eXlZVWpLRWo3Z1RvVitrTTVvVXJnbDQyeVdrMHR2TnBzVmlid2dlQVJ2c0x6?=
 =?gb2312?B?VitpdVQrN054aU9qQjRpOGZLVEU5OHpmanBtc29wNFBodlcwTldKaVNSQlpC?=
 =?gb2312?B?SFF0bHN2aW9xWmhaSWpCZ2lTbStrcVFiTldwYm5MU2VEckRuTGdnVk1GYUFL?=
 =?gb2312?B?NGZ5N3VxQXcwUFZFL2NsRUlLK3k3M2R5L2JQdXdxamJha1NuNE1jeUhvQzM0?=
 =?gb2312?B?eEg3UXZJdnFDemFsNmZMMTgyRE5sdHV5VDRZRmxNamRFMUFndndmRjdIWElE?=
 =?gb2312?B?eUEwL3F3dFZzbE5pMEJQRUlBa3pzUSthTlJKSmdhSktFNnc4b25UMGFRc2N3?=
 =?gb2312?B?WHFmQ0phcjF1WC9hZXZBS1NwZFpvNVI2OEFXUTdiT2VaTUhnY2V2UGFNcVBG?=
 =?gb2312?B?ZGZYUzZjYlZidkd4VW9kZHIxdStVdjRXZmhjalBwOExYN0xNKzR4OXEvZ3V0?=
 =?gb2312?B?cDNHZlFtaXppdnY0SXhlZ0xSU0x0R1ZpWWlLU1JrTlI2bFEzS2p2Uk1LYm4z?=
 =?gb2312?B?MDhSQ0pVa0pLMlhzei9zQzZFbkhlbHJsUFlGUGt2SE5oaXAvYVB5WW5pRjNs?=
 =?gb2312?B?SndXZzJ4V2hzbVhxZ0xmZWV0L2dDckhrSzc2VXplWVBzODJZWjlXSTlXdnp3?=
 =?gb2312?B?QzI1RG5WazB6c3BWTFFIVGRKUEdJT2lBRFlBcFlxaWR4UnRHWHg4K2xtWXd2?=
 =?gb2312?B?S0N2U3AxZUZzMDBzaXUyQzEwOHVDUUFyQUVXaE9MMWlXZ2NianhqSWYvR2dG?=
 =?gb2312?B?Snd6M2IrL1cxdkxSSkNVUytVditPVWkxREZqcDMyRm5qR0JHYVUxNktUNFVK?=
 =?gb2312?B?dXh0R2tHZUhXTEd2YVVINXhaR3JFb1dGdCtvNnc3VnJsRmc4Q0Q5dzExTU5S?=
 =?gb2312?B?S1FJL3dwYnl4d2EyN2s2aXNvRTRUVXVkcTRyVGdkMGJQVlFZc3QyeGRaNnRl?=
 =?gb2312?B?eWhyVTVCUFBIL1NkR083Q28rclpFY3N4WkF3QU00N2pyVmVBZ3R0U1lNdnk4?=
 =?gb2312?B?TGUzcmtkM1Q0MEd1SC9YR0J1YnlyYVlUSnJkTzR1dExXSHNXK1VyZUxlMi8x?=
 =?gb2312?B?SFNoM2VUMG9BSHhWeTRHM1JtbjdZbmZ0ZERXWTd6UEdwSWk5MVJ4MUZscUF5?=
 =?gb2312?B?dE1iTUpwSWFTUlAwOFN2NUZheEcyZCtsM3o3ZW0zaEhGZldYOGR4ZmkwckJt?=
 =?gb2312?Q?rHbQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fa70d4-2d61-4b6c-439b-08dce02705d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 01:35:38.5172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1M63ogz59Q8MuYfpe6d2J3KL3dlLkpTly0x4CnrmWkhJPHbROKgNzhJ2qEUwdzwhkQEdVvDiOAsRxZ3udM5jRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiBTZW50OiAyMDI0xOo51MIyN8jVIDIyOjQyDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5j
b207IENsYXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsNCj4gYXN0QGtlcm5l
bC5vcmc7IGRhbmllbEBpb2dlYXJib3gubmV0OyBoYXdrQGtlcm5lbC5vcmc7DQo+IGpvaG4uZmFz
dGFiZW5kQGdtYWlsLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVs
Lm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCAy
LzNdIG5ldDogZW5ldGM6IGZpeCB0aGUgaXNzdWVzIG9mIFhEUF9SRURJUkVDVCBmZWF0dXJlDQo+
IA0KPiBPbiBUaHUsIFNlcCAxOSwgMjAyNCBhdCAwNDo0MTowM1BNICswODAwLCBXZWkgRmFuZyB3
cm90ZToNCj4gPiBAQCAtMjI1MSw3ICsyMjYxLDE2IEBAIHN0YXRpYyB2b2lkIGVuZXRjX2Rpc2Fi
bGVfdHhiZHIoc3RydWN0IGVuZXRjX2h3DQo+ICpodywgc3RydWN0IGVuZXRjX2JkciAqcnhfcmlu
ZykNCj4gPiAgCWVuZXRjX3R4YmRyX3dyKGh3LCBpZHgsIEVORVRDX1RCTVIsIDApOw0KPiA+ICB9
DQo+ID4NCj4gPiAtc3RhdGljIHZvaWQgZW5ldGNfZGlzYWJsZV9iZHJzKHN0cnVjdCBlbmV0Y19u
ZGV2X3ByaXYgKnByaXYpDQo+ID4gK3N0YXRpYyB2b2lkIGVuZXRjX2Rpc2FibGVfcnhfYmRycyhz
dHJ1Y3QgZW5ldGNfbmRldl9wcml2ICpwcml2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgZW5ldGNf
aHcgKmh3ID0gJnByaXYtPnNpLT5odzsNCj4gPiArCWludCBpOw0KPiA+ICsNCj4gPiArCWZvciAo
aSA9IDA7IGkgPCBwcml2LT5udW1fcnhfcmluZ3M7IGkrKykNCj4gPiArCQllbmV0Y19kaXNhYmxl
X3J4YmRyKGh3LCBwcml2LT5yeF9yaW5nW2ldKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGlj
IHZvaWQgZW5ldGNfZGlzYWJsZV90eF9iZHJzKHN0cnVjdCBlbmV0Y19uZGV2X3ByaXYgKnByaXYp
DQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBlbmV0Y19odyAqaHcgPSAmcHJpdi0+c2ktPmh3Ow0KPiA+
ICAJaW50IGk7DQo+ID4gQEAgLTIyNTksOCArMjI3OCw2IEBAIHN0YXRpYyB2b2lkIGVuZXRjX2Rp
c2FibGVfYmRycyhzdHJ1Y3QNCj4gZW5ldGNfbmRldl9wcml2ICpwcml2KQ0KPiA+ICAJZm9yIChp
ID0gMDsgaSA8IHByaXYtPm51bV90eF9yaW5nczsgaSsrKQ0KPiA+ICAJCWVuZXRjX2Rpc2FibGVf
dHhiZHIoaHcsIHByaXYtPnR4X3JpbmdbaV0pOw0KPiA+DQo+IA0KPiBQbGVhc2UgZG8gbm90IGxl
YXZlIGEgYmxhbmsgbGluZSBoZXJlLiBJbiB0aGUgZ2l0IHRyZWUgYWZ0ZXIgYXBwbHlpbmcNCj4g
dGhpcyBwYXRjaCwgdGhhdCBibGFuayBsaW5lIGFwcGVhcnMgYXQgdGhlIGVuZCBvZiBlbmV0Y19k
aXNhYmxlX3R4X2JkcnMoKS4NCj4gDQpUaGFua3MgZm9yIHJlbWluZGVyLCBpdCdzIHdlaXJkIHRo
YXQgdGhlIGNoZWNrcGF0Y2gucGwgZGlkIG5vdCByYWlzZSBhDQp3YXJuaW5nIGhlcmUuDQo=

