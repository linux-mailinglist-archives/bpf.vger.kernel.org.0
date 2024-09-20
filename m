Return-Path: <bpf+bounces-40112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2D97D01E
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 05:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683B11F24E03
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 03:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEED1C69D;
	Fri, 20 Sep 2024 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BrJ90cQ7"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D07179BD;
	Fri, 20 Sep 2024 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726801932; cv=fail; b=JudtbR6HPJjun6zb7maOec2eNkoWHuDSrNkO5EgAZUbBP/4nxaXZzqzj2AZnvO+M9zJwgamnYJPymsxuOjIaB2Ex/5nVcd2IKtD6/m90HBBFYZIA9CqmT1AFGX9pEGXjtflJCTnQfxf2IcRZJ2Bk16VSc6DjaN8oqwH39Y7snyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726801932; c=relaxed/simple;
	bh=Sljh7EgZJILCQTBCMQqV5Al7/HvyII2Q6vfTMTiiM7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uNRJLUoO2Gf4DvvTdk8cuZKEl0Wd7xFwCywtbS3DUkjADtzv69X9H2Ouwco6NmJMN8cQ8HNNyBk0W3+gvdL+icpcnEoz4fy8MX6sdkWg33f+tIXbmxQ7Do8E0YWJKGf4k1N6zrpc9WcHv/hv7I5MJAcNH1Z6HYyLj6dNXLTclng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BrJ90cQ7; arc=fail smtp.client-ip=52.101.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjVLvSDWDsXadOWFrP1/B7P6hVaEPwWcSoZqjitUhtUAPc/x+yUTZPcH0mr3tMRdCEXhVQ3yjREJDKlJamm9FnBgBZsvFavOGrkiOGt1MBrDQf+TCulJ2HVyZXeK+jezFui8pQNg3xR0zPto4gubzhdCEp1XZeuvPlwc2cxLxLTexSGL5RelaS53QYbosVx2uzszegsncGmnAoBu6fnLbPAkZK3yA83tF66eBZIbjuyf1TcHyPFJCug6VnmV+tg9h7bLjbXSqrd97EPuA5zMjy3HBYviGwvvMTmPxBlOfkNs+FCIXuVVEUAI9YDuabz7ZpPRx5TXE/bwqkuFP2nfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sljh7EgZJILCQTBCMQqV5Al7/HvyII2Q6vfTMTiiM7A=;
 b=HQ5YyjtzeqEHbmpTqPZgMY6f3QqDQqq9Ogso/oGWSh2U3ze4neWSUbegjNet53rSYmwzKJOh8F7HZZDQ2TXKPgNz/jq2mPO5qXPtwXek1TzGO6QKqbsQHjuT1XJYAlZ5ZpOvjhzEbXajwd/34JjR9Lv9Iz/SiBP9ysJNoMtX3OTXEcXFQtxgTMB6ss5exB+ddwfZU+Hfzw7nVZ2fxr/UkAvM2qRr+/C2/DXi1Cs+So1hkauiXXIY+CMJOz40zLjue8bp/REXy1zmtepHt5Q/TTh3WSweQYHvWZsN4/1wxRMcjUXIq2xvEDaUaTZivOTdZGfeYaaHqldYaRsvR1APZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sljh7EgZJILCQTBCMQqV5Al7/HvyII2Q6vfTMTiiM7A=;
 b=BrJ90cQ7yMp7JWv90YL2soQ3VvFshkDCB+P45m0vL3Qr/veDjTUESYsvvDiDSbbzPkHzEWdRLlsEeUdZYM44k0pK1olVMa7fCne3x+UuNo2hM4seN1CZ3uD8+jJwJw87RAzeAcn97+G/TYqTq3+5EE8QsFRxZ3iY30XYOpxf8nZcvj26iNjPB3VpMIdM5VCbWW+zgn3dmGVICt7fZcmPWT4DuH7QOo77b9J4Y205VEjpb8v82z32fv9unBl/0+FD08GfI8QcrpYAxfBvd5tG4J+OWug3D2TpeuRrXwaCA0rgD2hz3KU632dB1iayL4tmUCR7yZSk9YKYJ8DdWTPudQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7871.eurprd04.prod.outlook.com (2603:10a6:102:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 03:12:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Fri, 20 Sep 2024
 03:12:06 +0000
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
Subject: RE: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Thread-Topic: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Thread-Index: AQHbCnHT295KDDvRD0aXaVmRMCCprrJfGOYAgADMJXA=
Date: Fri, 20 Sep 2024 03:12:06 +0000
Message-ID:
 <PAXPR04MB8510727BD7B77261491B4D31886C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-4-wei.fang@nxp.com>
 <20240919132154.czugz52nirmijohe@skbuf>
In-Reply-To: <20240919132154.czugz52nirmijohe@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7871:EE_
x-ms-office365-filtering-correlation-id: 35c82958-d937-42c0-3fff-08dcd92201ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cWVaTEhTNVV1SkNLdlZIeURFcHI5WFNWSkdzV1dURGw3OUR5U21Na2h1ZWxQ?=
 =?gb2312?B?dmpNSXBhTmtaaGtCWGxUUEJEdzNJY1FRczZZdWE4cWhBRTFXZTNxWkY5Znh6?=
 =?gb2312?B?dkZ5M0hzVVQ2V0t0OThQc2ZKZWxaTktmVnpyWlRpZ1pDU01UMFRJeCs5UnVK?=
 =?gb2312?B?NjlvSXZENEtKWFNBejF1SWRnQVQyZmZjaG9JMTNSSWlMay9MN1UxU2FGc3JJ?=
 =?gb2312?B?ejVpK21wUlp5T2ZmcCt5K052SFg3M0M3Mjh5MGZBTXhZZUlraWRKdFhaMkFX?=
 =?gb2312?B?T2FaOWdlOExwY3dpTVJpNEEzNmN4ZGppV0FabkRjaFZXU0FlTmhTbHg0Rjlz?=
 =?gb2312?B?c1JLcDh6U2ZDNjZjNWlpVHRCMmlOQ0pSdWFoMHhITW51cCtZTndJNGJyelBp?=
 =?gb2312?B?RnlhVEFGakxPUy9mSER0eWprS2ZUMWJXVFhUd0tCOW9XK1dwdFM5MlNvOE1M?=
 =?gb2312?B?bGNnR1Y1YUczbTlxTzk2dEI3RVFZVXU4N2E3TEVWSDF2TVZTVXFLNVN4aUlV?=
 =?gb2312?B?YlVjeWVmZEJvdUtsWW10d0VhU0Q0c1VIdHQwT3RHMy82UDhKYVdXdmxqdTZL?=
 =?gb2312?B?WCtjT1kwVDFZY0xoNkdUTXRXcHRTeXZFeS9qSUtRTGp0MUxYM0RjU1N6OFlL?=
 =?gb2312?B?TmVpWFkwNEo5Y3JXS1NTemIxOEFTaGRFL3kyOTZPek0zenFwQnh2ZTFUSGlv?=
 =?gb2312?B?emwyVkQ2S1VTbG9zR0Q0L3hmMjZHdWgzYnlHbXU4UkhpTGR3QlphSUwyQ3M2?=
 =?gb2312?B?U0ZFTjQzNFVoRWdCbUNLTUlDTy8zZWtYZ3cxY0RsQnMyZVZ4SHNMMmZSNDdi?=
 =?gb2312?B?OENNdmRCME1RN1JtY1BwN0dNUndOVmtBYU5vWTVmSERkT3ppditsRFRObXN6?=
 =?gb2312?B?bDMxcjU5YW1vb21rY3RIRlZxZ01HK2NnQ2U0dnJpdE1DcDdEWDE5UUoyeVdS?=
 =?gb2312?B?Z0tFWThqRFQraDBCaERlbUd1TFJwNmhGK21LT1R3eTRQVVdkQitEVkFPa25O?=
 =?gb2312?B?ZWF1cU54ckxtTGEvOEJiUlo4bWMxbk12SWxXNDc3M3B6d0EzeG5wMW1ZN0kv?=
 =?gb2312?B?eEVnWjU0SHZHbXdaM1A5REZVdUlrY1Jhc0tsZlZyTmVtK1dkQnUxQS9lNXli?=
 =?gb2312?B?SXBFT1VUcHhESHNoK281VjZXdS9sMHZEcHFtWitWb0p6enBQek1QMDJFckxQ?=
 =?gb2312?B?MkVmekxiZHhURnI0cGlkMnNaUkNxakNkdWVBbkxzUGpxZTVnZmlkSHdEV0ZO?=
 =?gb2312?B?VFQ1d0t5NitVcWpTMVZKMlRXQ1pYcDVVaHVyYnVsNzFzcEI1YThKSlNaMW56?=
 =?gb2312?B?S0lrY0Q0bmI3Q3FtblJCQm9zMTA0U3RvMzRDKzZXY2k4UHlOQVB1TmdCVGlX?=
 =?gb2312?B?YlZBQXpubEhUWjJCUXZXM045ZVViTVpQdTFCemdaYkt6MzhKd20vMFF6RjJ6?=
 =?gb2312?B?VW1RWlpGejljOXZBTUs4YzBycXRHaHM0K2NYcDlTVElRcTZZV2FCQ2VsQ0dW?=
 =?gb2312?B?L0VpVW1MNlY5VkUrUGFNTnlXRWhDY3BHRHE2emVLRkxHT3pLNThDY0g3QzFS?=
 =?gb2312?B?b2JEclRQNmhuNkY3Wm1mRlZpQks5RktvQy9ScllOYjJsL1VsQmdwVVZPR293?=
 =?gb2312?B?ek1iNGEvUGkxUG1RcEtTeWNobE8rWHFsV1dubUlQaGo0VnlMbWJVd1hoakpj?=
 =?gb2312?B?ZE1JcnRESHJ4S1g2MU9qbFcrVWZjTU10d3NRZUlIU3VWdTM0bE9IWEVoKy84?=
 =?gb2312?B?RlREb0Y2SG53dFJWeExJKzFWeS9hSldHRFFqU0VZWnAyREZ1djh4ZlF3MXVQ?=
 =?gb2312?B?ajYxVkZqSmZISDhQMEtaY1MzM1BDWWRpZEtsMXM2b3lEejJzNFVpa2g3V0ZI?=
 =?gb2312?B?RGtOWE5ka2Y5T0hQQW4waHc0cHh5N2dTdVJXcDN1azBHT2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dXV1WFdrMkdWSXlrdHhRamE1M09wWmRyU0Z4cDM1T3YvMEhxL0V6Q3hZa2dQ?=
 =?gb2312?B?aVNuWmY0NCtSaUpza25uNmZyNjAxV01uOEx6QklacGROdkxqSUl3d3IzL1By?=
 =?gb2312?B?WnhsS2Evc1VLc0ZaeFpRSXBxenF5UTFPd3BWUXN5Y3lZSGxTcUVVaFo5SmN2?=
 =?gb2312?B?MmJqOVM2OXpKNUNNTTRrNkduN2pRNjZ1NFNBejErR201RnBrV3NTaHRDV1Rz?=
 =?gb2312?B?MzJTQ1FaQStCZkFMNGxQak9IVkc4SjNUMUxPN2QzTnB4MWN1cmlvdVRaTTQx?=
 =?gb2312?B?UTVvUFN1VHpONUZlU2JZZ1VuV08zcW80NjNjc1RsZWFaSmVDc2ZmRXpBb2Fu?=
 =?gb2312?B?V2NNSHI1NkdTSytpUi9GTGRkOWNtdGNpR09LRFlpKzZoYVFnaEkrN1BlTU11?=
 =?gb2312?B?UkNCcGcvUnhMT25yb3FQMmg1bTI1VEpUZFVHZHNSWjJ4RXFTbU9SSVJadjJT?=
 =?gb2312?B?TTdUbTBjSzU2WEIvYVNxczZMSUF1VU1zdnhNUElJSTlXK0ZGTXRncFVjZEJ3?=
 =?gb2312?B?aVZJYlhYcnRqK1pBQVFDUTVuM0dQdmF3WFNlUzFpbWpuUnlvQnU0VFN4TGh2?=
 =?gb2312?B?ZDAydzVrSXJBcHFKUXdjZmE3bUFyR0NCd2h1a2FzUWNWb0hIeXlUTDNKTWhU?=
 =?gb2312?B?cHFRK2hGdnl5L3lxbXZhZkpGYkJXa0swZWpnWGxqb1NFT2lOMHBKVnR1b3N4?=
 =?gb2312?B?Nlg1bjZ3cVJTSkJDQnFqK3IzWWtZN1d1bUVoaUEyYm9OU0RxdEo5ZGRTNC9D?=
 =?gb2312?B?RDNqTWlrNHRiZitzQm1LR05nZmlLOXFIdkVYUGRQLzVULzQ2VUFMT2xmeGhn?=
 =?gb2312?B?VzNQRlVIaDdKbmthUmZBdmlRc3FuMmtrSEdhL0JTcUx2OGxmUmN5TEgzLzJi?=
 =?gb2312?B?THBndHJJSStOWFhpR1BTZXB6ZHhGUkx6Z05KMURodWdZSkttanZjbjhOWHI3?=
 =?gb2312?B?Q0ZRV3ZsMG1mSS9wbENDR09TeW9PY0xleHpGTHdRa0tuS1pEeHRqZzlkY2ha?=
 =?gb2312?B?Y2svajJib1NJd2hwNXBEZEg1WVVmaDRseTc5cHUrcE5RcVNjeGVNSDdxZGRS?=
 =?gb2312?B?WDBGcVdCeS9DL1kvRkdReTJLS2djVlNKa2RnQU5XOW5XTFBkWlV4OW5zeEty?=
 =?gb2312?B?NnJVOWxQckZsRWloeFFTMlFnQWo2OFlOZGR0S2t3MmtFY3RabVNJbUFYdEgw?=
 =?gb2312?B?VXdsQ0o2eU5hUVEvdktOS0dndU9pN0U4aFc5anluVjJyR2w3dGlQaklIbjIw?=
 =?gb2312?B?enhEVzFZSkR0Q1IyZmo2am5vYzFWY281NElTMnVKc0RQNXR4SDFNUEdBdG1P?=
 =?gb2312?B?TlBnZFAyQUVQSTk0QUxFSGxTbkNuVFRYdmFIZ0RiODljYndWd3hManRFNTJt?=
 =?gb2312?B?UzhEWllqeTN0amtqNWdyeUpzWVkrTjVvSjRZYkZLTHNmMWR5QVEvUkt5Z0xJ?=
 =?gb2312?B?a3FiVFhFcnFyWjlFdWxVWCtmZGpnVDVySStlYjZmSUJyUG1sdG5veS9qS1g4?=
 =?gb2312?B?Uy90dWtWTEpzQWpESjdZTVk4WmtGbmxPVzg1bTFuM3gyRTU3NFpkVXFsWmJR?=
 =?gb2312?B?SkNpNkRrRHNGSkpxTGhVV3ZYUDhtamRFSi9Ib1BaM3Y5ckJ6bnZUVDkyUDg4?=
 =?gb2312?B?bGVjMnBKeG9MOE5BTmdDRXVaTnZjRk1zWjFOdXowdDBST2xEY3hZR00zVUp4?=
 =?gb2312?B?QkVXd0N6TXN5cm5wMHdEcWRKdTh1d0MvUTVFZHFpWWhhNjV3UjFjeWRHWVdh?=
 =?gb2312?B?SFVOamZhYkdDY1pjNWI4QnF6a3dKUk5VOGhBSWdXRmNmbmRQbEIzb3U2QkJm?=
 =?gb2312?B?c1ZSSjFtdmViRTV4OXVDR0pENHZ2VUIxRkh1WVVvSUJGbnlhbnNuY0p1L3Ax?=
 =?gb2312?B?eXVmNnBYd2tXdmhySmV2M202MWZseVIwejMzQkU3TklYZXBSMkVKekUzbWVp?=
 =?gb2312?B?MVZkUHhZVnZmNWRYblNJeWVIQm5CK2ZLSGJCNFNydlNxRDR2cUdRLzE5SzRP?=
 =?gb2312?B?NjBKdzFMcG80QnRqbmhwWk5DSHUvZTBLUys2bDczU29CM3AyTnUvUnpEeDc4?=
 =?gb2312?B?MVlhaXI2T09Dc29qc3NuVEhYWXErV2VtZHF4T2ZXOG1ITkdVdWZCTmMrSHZW?=
 =?gb2312?Q?mOck=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c82958-d937-42c0-3fff-08dcd92201ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 03:12:06.5061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3GA2JhEM49H3iSQ70ZiSHMaBar472xyV16XpkdyGISx1SzAtBaa/9wjOIA6nGTWINNly61zrb29zCgRM9BPGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7871

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiBTZW50OiAyMDI0xOo51MIxOcjVIDIxOjIyDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5j
b207IENsYXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsNCj4gYXN0QGtlcm5l
bC5vcmc7IGRhbmllbEBpb2dlYXJib3gubmV0OyBoYXdrQGtlcm5lbC5vcmc7DQo+IGpvaG4uZmFz
dGFiZW5kQGdtYWlsLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVs
Lm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCAz
LzNdIG5ldDogZW5ldGM6IHJlc2V0IHhkcF90eF9pbl9mbGlnaHQgd2hlbiB1cGRhdGluZw0KPiBi
cGYgcHJvZ3JhbQ0KPiANCj4gT24gVGh1LCBTZXAgMTksIDIwMjQgYXQgMDQ6NDE6MDRQTSArMDgw
MCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gV2hlbiBydW5uaW5nICJ4ZHAtYmVuY2ggdHggZW5vMCIg
dG8gdGVzdCB0aGUgWERQX1RYIGZlYXR1cmUgb2YgRU5FVEMNCj4gPiBvbiBMUzEwMjhBLCBpdCB3
YXMgZm91bmQgdGhhdCBpZiB0aGUgY29tbWFuZCB3YXMgcmUtcnVuIG11bHRpcGxlDQo+ID4gdGlt
ZXMsIFJ4IGNvdWxkIG5vdCByZWNlaXZlIHRoZSBmcmFtZXMsIGFuZCB0aGUgcmVzdWx0IG9mIHhk
by1iZW5jaA0KPiA+IHNob3dlZCB0aGF0IHRoZSByeCByYXRlIHdhcyAwLg0KPiA+DQo+ID4gcm9v
dEBsczEwMjhhcmRiOn4jIC4veGRwLWJlbmNoIHR4IGVubzAgSGFpcnBpbm5pbmcgKFhEUF9UWCkg
cGFja2V0cyBvbg0KPiA+IGVubzAgKGlmaW5kZXggMzsgZHJpdmVyIGZzbF9lbmV0YykNCj4gPiBT
dW1tYXJ5ICAgICAgICAgICAgICAgICAgICAgIDIwNDYgcngvcyAgICAgICAgICAgICAgICAgIDAN
Cj4gZXJyLGRyb3Avcw0KPiA+IFN1bW1hcnkgICAgICAgICAgICAgICAgICAgICAgICAgMCByeC9z
ICAgICAgICAgICAgICAgICAgMA0KPiBlcnIsZHJvcC9zDQo+ID4gU3VtbWFyeSAgICAgICAgICAg
ICAgICAgICAgICAgICAwIHJ4L3MgICAgICAgICAgICAgICAgICAwDQo+IGVycixkcm9wL3MNCj4g
PiBTdW1tYXJ5ICAgICAgICAgICAgICAgICAgICAgICAgIDAgcngvcyAgICAgICAgICAgICAgICAg
IDANCj4gZXJyLGRyb3Avcw0KPiA+DQo+ID4gQnkgb2JzZXJ2aW5nIHRoZSBSeCBQSVIgYW5kIENJ
UiByZWdpc3RlcnMsIHdlIGZvdW5kIHRoYXQgQ0lSIGlzIGFsd2F5cw0KPiA+IGVxdWFsIHRvIDB4
N0ZGIGFuZCBQSVIgaXMgYWx3YXlzIDB4N0ZFLCB3aGljaCBtZWFucyB0aGF0IHRoZSBSeCByaW5n
DQo+ID4gaXMgZnVsbCBhbmQgY2FuIG5vIGxvbmdlciBhY2NvbW1vZGF0ZSBvdGhlciBSeCBmcmFt
ZXMuIFRoZXJlZm9yZSwgaXQNCj4gPiBpcyBvYnZpb3VzIHRoYXQgdGhlIFJYIEJEIHJpbmcgaGFz
IG5vdCBiZWVuIGNsZWFuZWQgdXAuDQo+ID4NCj4gPiBGdXJ0aGVyIGFuYWx5c2lzIG9mIHRoZSBj
b2RlIHJldmVhbGVkIHRoYXQgdGhlIFJ4IEJEIHJpbmcgd2lsbCBvbmx5IGJlDQo+ID4gY2xlYW5l
ZCBpZiB0aGUgImNsZWFuZWRfY250ID4geGRwX3R4X2luX2ZsaWdodCIgY29uZGl0aW9uIGlzIG1l
dC4NCj4gPiBUaGVyZWZvcmUsIHNvbWUgZGVidWcgbG9ncyB3ZXJlIGFkZGVkIHRvIHRoZSBkcml2
ZXIgYW5kIHRoZSBjdXJyZW50DQo+ID4gdmFsdWVzIG9mIGNsZWFuZWRfY250IGFuZCB4ZHBfdHhf
aW5fZmxpZ2h0IHdlcmUgcHJpbnRlZCB3aGVuIHRoZSBSeCBCRA0KPiA+IHJpbmcgd2FzIGZ1bGwu
IFRoZSBsb2dzIGFyZSBhcyBmb2xsb3dzLg0KPiA+DQo+ID4gWyAgMTc4Ljc2MjQxOV0gW1hEUCBU
WF0gPj4gY2xlYW5lZF9jbnQ6MTcyOCwgeGRwX3R4X2luX2ZsaWdodDoyMTQwIFsNCj4gPiAxNzgu
NzcxMzg3XSBbWERQIFRYXSA+PiBjbGVhbmVkX2NudDoxOTQxLCB4ZHBfdHhfaW5fZmxpZ2h0OjIx
MTAgWw0KPiA+IDE3OC43NzYwNThdIFtYRFAgVFhdID4+IGNsZWFuZWRfY250OjE3OTIsIHhkcF90
eF9pbl9mbGlnaHQ6MjExMA0KPiA+DQo+ID4gRnJvbSB0aGUgcmVzdWx0cywgd2UgY2FuIHNlZSB0
aGF0IHRoZSBtYXhpbXVtIHZhbHVlIG9mDQo+ID4geGRwX3R4X2luX2ZsaWdodCBoYXMgcmVhY2hl
ZCAyMTQwLiBIb3dldmVyLCB0aGUgc2l6ZSBvZiB0aGUgUnggQkQgcmluZw0KPiA+IGlzIG9ubHkg
MjA0OC4gVGhpcyBpcyBpbmNyZWRpYmxlLCBzbyBjaGVja2VkIHRoZSBjb2RlIGFnYWluIGFuZCBm
b3VuZA0KPiA+IHRoYXQgdGhlIGRyaXZlciBkaWQgbm90IHJlc2V0IHhkcF90eF9pbl9mbGlnaHQg
d2hlbiBpbnN0YWxsaW5nIG9yDQo+ID4gdW5pbnN0YWxsaW5nIGJwZiBwcm9ncmFtLCByZXN1bHRp
bmcgaW4geGRwX3R4X2luX2ZsaWdodCBzdGlsbA0KPiA+IHJldGFpbmluZyB0aGUgdmFsdWUgYWZ0
ZXIgdGhlIGxhc3QgY29tbWFuZCB3YXMgcnVuLg0KPiA+DQo+ID4gRml4ZXM6IGMzM2JmYWY5MWM0
YyAoIm5ldDogZW5ldGM6IHNldCB1cCBYRFAgcHJvZ3JhbSB1bmRlcg0KPiA+IGVuZXRjX3JlY29u
ZmlndXJlKCkiKQ0KPiANCj4gVGhpcyBkb2VzIG5vdCBleHBsYWluIHdoeSBlbmV0Y19yZWN5Y2xl
X3hkcF90eF9idWZmKCksIHdoaWNoIGRlY3JlYXNlcw0KPiB4ZHBfdHhfaW5fZmxpZ2h0LCBkb2Vz
IG5vdCBnZXQgY2FsbGVkPw0KPiANCj4gSW4gcGF0Y2ggMi8zIHlvdSB3cm90ZToNCj4gDQo+IHwg
VHggQkQgcmluZ3MgYXJlIGRpc2FibGVkIGZpcnN0IGluIGVuZXRjX3N0b3AoKSBhbmQgdGhlbiB3
YWl0IGZvcg0KPiB8IGVtcHR5LiBUaGlzIG9wZXJhdGlvbiBpcyBub3Qgc2FmZSB3aGlsZSB0aGUg
VHggQkQgcmluZyBpcyBhY3RpdmVseQ0KPiB8IHRyYW5zbWl0dGluZyBmcmFtZXMsIGFuZCB3aWxs
IGNhdXNlIHRoZSByaW5nIHRvIG5vdCBiZSBlbXB0eSBhbmQNCj4gfCBoYXJkd2FyZSBleGNlcHRp
b24uIEFzIGRlc2NyaWJlZCBpbiB0aGUgYmxvY2sgZ3VpZGUgb2YgTFMxMDI4QSBORVRDLA0KPiB8
IHNvZnR3YXJlIHNob3VsZCBvbmx5IGRpc2FibGUgYW4gYWN0aXZlIHJpbmcgYWZ0ZXIgYWxsIHBl
bmRpbmcgcmluZw0KPiB8IGVudHJpZXMgaGF2ZSBiZWVuIGNvbnN1bWVkIChpLmUuIHdoZW4gUEkg
PSBDSSkuDQo+IHwgRGlzYWJsaW5nIGEgdHJhbnNtaXQgcmluZyB0aGF0IGlzIGFjdGl2ZWx5IHBy
b2Nlc3NpbmcgQkRzIHJpc2tzIGENCj4gfCBIVy1TVyByYWNlIGhhemFyZCB3aGVyZWJ5IGEgaGFy
ZHdhcmUgcmVzb3VyY2UgYmVjb21lcyBhc3NpZ25lZCB0byB3b3JrDQo+IHwgb24gb25lIG9yIG1v
cmUgcmluZyBlbnRyaWVzIG9ubHkgdG8gaGF2ZSB0aG9zZSBlbnRyaWVzIGJlIHJlbW92ZWQgZHVl
DQo+IHwgdG8gdGhlIHJpbmcgYmVjb21pbmcgZGlzYWJsZWQuIFNvIHRoZSBjb3JyZWN0IGJlaGF2
aW9yIGlzIHRoYXQgdGhlDQo+IHwgc29mdHdhcmUgc3RvcHMgcHV0dGluZyBmcmFtZXMgb24gdGhl
IFR4IEJEIHJpbmdzICh0aGlzIGlzIHdoYXQNCj4gfCBFTkVUQ19UWF9ET1dOIGRvZXMpLCB0aGVu
IHdhaXRzIGZvciB0aGUgVHggQkQgcmluZ3MgdG8gYmUgZW1wdHksIGFuZA0KPiB8IGZpbmFsbHkg
ZGlzYWJsZXMgdGhlIFR4IEJEIHJpbmdzLg0KPiANCj4gSSdtIHN1cnByaXNlZCB0aGF0IGFmdGVy
IGZpeGluZyB0aGF0LCB0aGlzIGNoYW5nZSB3b3VsZCBzdGlsbCBiZSBuZWVkZWQsIHJhdGhlcg0K
PiB0aGFuIHhkcF90eF9pbl9mbGlnaHQgbmF0dXJhbGx5IGRyb3BwaW5nIGRvd24gdG8gMCB3aGVu
IHN0b3BwaW5nIE5BUEkuIFdoeQ0KPiBkb2Vzbid0IHRoYXQgaGFwcGVuLCBhbmQgd2hhdCBoYXBw
ZW5zIHRvIHRoZSBwZW5kaW5nIFhEUF9UWCBidWZmZXJzPw0KDQpUaGUgcmVhc29uIGlzIHRoYXQg
aW50ZXJydXB0IGlzIGRpc2FibGVkIChkaXNhYmxlX2lycSgpIGlzIGNhbGxlZCBpbiBlbmV0Y19z
dG9wKCkpIHNvDQplbmV0Y19yZWN5Y2xlX3hkcF90eF9idWZmKCkgd2lsbCBub3QgYmUgY2FsbGVk
LiBBY3R1YWxseSBhbGwgWERQX1RYIGZyYW1lcyBhcmUNCnNlbnQgb3V0IGFuZCBYRFBfVFggYnVm
ZmVycyB3aWxsIGJlIGZyZWVkIGJ5IGVuZXRjX2ZyZWVfcnh0eF9yaW5ncygpLiBTbyB0aGVyZSBp
cw0Kbm8gbm90aWNlYWJsZSBpbXBhY3QuDQoNCkFub3RoZXIgc29sdXRpb24gaXMgdGhhdCBtb3Zl
IGRpc2FibGVfaXJxKCkgdG8gdGhlIGVuZCBvZiBlbmV0Y19zdG9wKCksIHNvIHRoYXQNCnRoZSBJ
UlEgaXMgc3RpbGwgYWN0aXZlIHVudGlsIHRoZSBUeCBpcyBmaW5pc2hlZC4gSW4gdGhpcyBjYXNl
LCB0aGUgeGRwX3R4X2luX2ZsaWdodCB3aWxsDQpuYXR1cmFsbHkgZHJvcCBkb3duIHRvIDAgYXMg
eW91IGV4cGVjdC4NCg==

