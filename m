Return-Path: <bpf+bounces-76912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7F1CC9734
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 20:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FA1B304FB92
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F2C2FC893;
	Wed, 17 Dec 2025 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RtfndEgm"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31532FB0A3;
	Wed, 17 Dec 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001493; cv=fail; b=PT7ttZmNz1/Aqi0AgCkY7N1aLUeq42uk20duQRGqktbtwwJfXhd+NWpu+Oo5Fum7IrjPccWHtq2DLt8olOjlbWoALRVvTN+vBk5eHoA5KnVjIgvcm0oJNBp4xJAMM8grHtTZ7Kd7kWS9iLZ00a533IcC3oMBYnbO5gRw8gYRFPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001493; c=relaxed/simple;
	bh=ZIrCXgJYlJsnTkzpdj5A5mUvJAHERHQyGnNPREvLuvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vf5XeTwFDGOLrGsYtlO2xpoxAnfatxgAzBeQppG4MMJPgtx/UtJ3tbhTNy3jCnQQdN2HlTeW4N8+Hdk/CU9lGReks4/B3U1031KcUMPTw1Bt8sTbg07gav+ZMaD0UuKfM3CmDEVCMk7bLkyvLUSN78wWnJBDN9gjwVJvW5l8eM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RtfndEgm; arc=fail smtp.client-ip=52.101.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sf8X9Xjg+0bEds3yZR/ue5lj/LeUDbEr/rU92RegZvCBrSveDNsuM8yet3uqYKxrOQSXIGEyX2WNO0oXzaXOs0o25XP2QouI5DRuOOa4JE2qqtREUtj2SSfAr8tZS7ZFnljV9mvqX4fyNRXlwSqrw5OGJJZdruSVY+hcwZKmcegkmyARg0yRS54jRI47DKxuJli9Di23uXF5ZBoW2E0AV3GH2GTcaQs/62RKKvwlHcllnMXF0DdMeamJkofH9UigEnfbe7rTcEj0Dr+CnBhlAr04wvYGp8RvQut7qcHoEiYHJ737BzVO6FYWwnHdd9u5A6/l0ldcePrDDb18Lu9X8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nITZEm2C38F9RlpUbj5heIJM6wca/r/qAguViqFOmjQ=;
 b=DVwoDmt2AQzK+0wrkg4UHkDhzSOiLA0X/EDu4KMFtD1EyDTxV5NmIzSELTWwRQer0lJUrrpb6kDhcnD5AiS9yc/WrYOWtz3HnWY5kM2/aaWQ4TpnSyhYA79t/5FOjozTvUB+3VBH5bwMYtJRtAkGSBAhN9xsPQ2xcXpRJW7nk5wzz+uVQLxO9Z/TywiWmSrna+pUOug9wvpBuuPypUR91RzeFjptRb8bwszRxrj/FMI8tsjaRZzvO5YexPV3LTb9tsAi+GVOqZbg0WZ7Irar3OQZsKuqJcczB8wMjoihtqD4Z6OizBz1TmQIyct7Gl47xzAsj36rQbjWn8x+EOoq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nITZEm2C38F9RlpUbj5heIJM6wca/r/qAguViqFOmjQ=;
 b=RtfndEgmXnez+RE45Uz3G7mJXpfSuWEpAbbiNtdYY9nCRhFe8AxtEM8inYGx/lHCklspwB/LOEVq0ReieQWl9xuyl0TB1lFW9tW1LR9T/Y6NPxrkbDWknnyUJMMOJWxlhyeK3LBAV2ZJhXeOLAXIunAE0u737J29IN8OLSi1Xr/0UGTPkc6n4xQY1Nduuv7y8vtVc3BxlB6SUTOie0HxzVdA5sN46kszYXxpIJBhNyGdqizIAQO6Hwq+91CNfhqvoq+ex8I8zUKEo7eNBqLueEHckZbC06D7oCO+SAaqclcfVtBtifgk5fRo9bjq7Si49s/e5jvSJ4haHt5wfLZeRw==
Received: from AS8PR04MB8497.eurprd04.prod.outlook.com (2603:10a6:20b:340::17)
 by AS8PR04MB9047.eurprd04.prod.outlook.com (2603:10a6:20b:442::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 12:49:19 +0000
Received: from AS8PR04MB8497.eurprd04.prod.outlook.com
 ([fe80::24f6:444b:9e8d:6aec]) by AS8PR04MB8497.eurprd04.prod.outlook.com
 ([fe80::24f6:444b:9e8d:6aec%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 12:49:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Hariprasad Kelam <hkelam@marvell.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"0x1207@gmail.com" <0x1207@gmail.com>, "hayashi.kunihiko@socionext.com"
	<hayashi.kunihiko@socionext.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	"boon.leong.ong@intel.com" <boon.leong.ong@intel.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: RE: [PATCH net] net: stmmac: fix the crash issue for zero copy XDP_TX
 action
Thread-Topic: [PATCH net] net: stmmac: fix the crash issue for zero copy
 XDP_TX action
Thread-Index: AQHcZO1pj0nep9pNq02KfA412DHJhbUlwQSAgAAYKSA=
Date: Wed, 17 Dec 2025 12:49:19 +0000
Message-ID:
 <AS8PR04MB849779A6392D543049A3F5BE88ABA@AS8PR04MB8497.eurprd04.prod.outlook.com>
References: <20251204071332.1907111-1-wei.fang@nxp.com>
 <aUKPHdtAPDnMqB7X@test-OptiPlex-Tower-Plus-7010>
In-Reply-To: <aUKPHdtAPDnMqB7X@test-OptiPlex-Tower-Plus-7010>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8497:EE_|AS8PR04MB9047:EE_
x-ms-office365-filtering-correlation-id: 2d28fd59-dbf2-4ff3-10fa-08de3d6ab1c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1oEyNV8Hqr70br3qJUc5xPlIe6i4ZWR8SngtfRf3aF+uoHdGXQLLOEN4EPTn?=
 =?us-ascii?Q?Y1FTEVmZA6kSl87Mi5D6W1TK4QozZcPixhjZOcELZ8xwG1Kpt0BCv0d9eR0H?=
 =?us-ascii?Q?NNZRpjs55rN6VHAaSTtS7QE0vNEUMStMUX799iO0C1RYLBSgDDibfEaw5pFz?=
 =?us-ascii?Q?mYhfhhPuQBHxjnsO8ELAj5kCFnZUTtK12fYSg2ldaUpZx2iWGjeSDxPhHZYe?=
 =?us-ascii?Q?e7v3cc0TUEQm0xZuot9hJSQgSt+5dFOp4fAT8e65Vc6O7MQSJ9Pb9DWAZ+Pk?=
 =?us-ascii?Q?2NT646iuz4dBoSmxPkp111QRnu2C35Eu14koIsJKfjIZ/Y5RF1w2MxVLkPuk?=
 =?us-ascii?Q?w9JfXg87qvH00V/VBzy2KtrbPI2AY0cMjcLxDuDNO49b+/0SRpNegzPTb2qd?=
 =?us-ascii?Q?8eNKm0mUTSoX7QMCqPLqzkYQV+ZIaVb8g42P8IsbDZGZy31F24OmoKJw+KjB?=
 =?us-ascii?Q?ObEwg7zcybK8DjGFggD3R93zDveoui2xhB+BffoszZFrRl1OhoK/Grn1DIme?=
 =?us-ascii?Q?tWthE1QqimJXDQMDQiGkyRCe5BykvCnQdOtJ/LJkKEijXmvoiX/1ohXNDb/Z?=
 =?us-ascii?Q?Z5fw6LlgYXEHKGpjaEIXaWZuiaqTGnXWQVbtQU7Omu7YToSilA83OLoMDfpm?=
 =?us-ascii?Q?YQfTETEGSCzp1qwuTuYGyxWjp3+P7RQrm7AJ085n6fh8k0iLvBOEafwkY8zH?=
 =?us-ascii?Q?7/BCYDpGsiaD7YofrGStNOx6bNtfxZ9QwHst+M/I14shUP+zpEbxoQ5rnv5T?=
 =?us-ascii?Q?l46oCId9xplZXYv23HOwpRBiFikKIIGnJAIl5WJnR2XoHHnEWDV+KrEKs3B5?=
 =?us-ascii?Q?PWuoCYowq380XPd+SruVd+K5gOemh6Qxt/glOznDv6fmwg4OXENAGbkYCwSx?=
 =?us-ascii?Q?dbLJTeZq2WzlnJZtd/ghka/w+NO60ZxYakNL9Mmv71MWBA15lAbLNF2bkawf?=
 =?us-ascii?Q?9HsxfWSAWg2KillxVL8jSQRs1Zaq5+IPYXyVVo9eeuOEqnE6ydEUrAGLmZlz?=
 =?us-ascii?Q?sqFVEfvbnMeB3a9m3Cm70B0LwBPt6MeeyL472xd/tEclLv61fp3DpXckEPMZ?=
 =?us-ascii?Q?o34m1uKCXO5KkJmy5JOaG1vwVz7JTjxps4xl2DvMXa8UayaIVgGXkZdQVkdP?=
 =?us-ascii?Q?8HHKWtI3hkBaYS23ZGYXTGUdtZ9945pFLVpCjgL7nFVqnri3BliURf/hi4br?=
 =?us-ascii?Q?EnCKrp/o9mTaaxFFzgyZZALHrNLXOTTFaGhnVu7SZ47fb7brXxGhX47IS+ta?=
 =?us-ascii?Q?Z8T09lFvNxO6KeTr12oVjM/f+sJZqzSu4bu7Ytd8XUNhCAWmdMOyUTEGn6AB?=
 =?us-ascii?Q?kVfwl+2qw54HR5bjwh9O3xo8oI/mWyVIJkw8jC2YVzI8eIFDpJq9JIjP5pR4?=
 =?us-ascii?Q?Z/JpevLTIiJaRGXjdD6brFI7HJOe59W0L46foO4cAB1n1DLAf3dJVyAghypP?=
 =?us-ascii?Q?kQ4bOdRmAMAxL2F9LNa7KoeUYYXtmKkVOPtvGdb9BlSvpnO/wmkRyIAv4PdG?=
 =?us-ascii?Q?PmSio8xyl/i17VhIeL5Po3Hsj941woN+/n1u?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j/UCb50zDNTtGKY+QiqxyN7Qlte/MGcW1RVIsy9I/UMQbALdJ07c9G56Il7Z?=
 =?us-ascii?Q?1+xr+0rKxF1waA0bmIe56R9aR1x+VK3c8V+Qw7HxOSpZARbn1alkONJOy7c3?=
 =?us-ascii?Q?cs5Nl38E15srI4c1efQSNof7UUiUB9xKz9QFW4+5+8pKgfXjC0PCkw72gi1o?=
 =?us-ascii?Q?fXc9/diIqECtPbqdx+cGGf8ulLrOCCKFZ9LHJ0mVMv28wbenImW+8a0pw+YQ?=
 =?us-ascii?Q?rIH9WLA0Jf/a96P+iqU+inSR/pahlFJj+C30HV4KI52tjTWOPQvktZ8Y5On1?=
 =?us-ascii?Q?Xh50E7Se19z6QYaOWkhun5fGZbtGS+MkIX/HUYvz3VOKwYzfEb0FhentHccj?=
 =?us-ascii?Q?LrQ2X0nMJTSCiy8KKH+6URVUIx5Ze9Zz5C1sC49SefiCLGHCHKc/EkPl34Ar?=
 =?us-ascii?Q?M+xmNmXCo5T2S/Fgg1ejR5Cnv7Ag8lp3QsLF769J8nq67fYZSrJhtdzQAHw0?=
 =?us-ascii?Q?Zg129Takh9M+M/+oSadAHfcB9o2lSe2jny6K5UnvdxfVBPYGvqAneVHwTfot?=
 =?us-ascii?Q?ZKUouDrwdYIck3bcZKYY349YAhE8vkypIvlScjMF6mDxCBkiVDnRxZdJNiNT?=
 =?us-ascii?Q?Z0ZC9Jy47keZ1for9Tevb/knZvw4Bj1TkuHccZCwU5T8/sFe9rzn+O0gXrMX?=
 =?us-ascii?Q?Bm8oTasuvTImhg7xEm3ace4a6Fk904FcwrFv2Ye8fItTcYci1PgdiO6eCmme?=
 =?us-ascii?Q?zgavDbGFV3FJG4RzHeA07SXdznhxZ1QFhzzzdCJWF1zllzi04HbzymehNp8K?=
 =?us-ascii?Q?fAD60xBKLuTGlIkVyw3tvsWziDWU2phA7Q6ZEozG4KjDhq5/HMTiCKPXW+81?=
 =?us-ascii?Q?4IM7Oxivn3IT3FTDklA/jX4Q5FT2AXl8NMSYHEtZxFicYJqurbjaeUoD+ezP?=
 =?us-ascii?Q?WIszMrSo6YcbYH2yYo65a6/VCqiVfS1TpeKJQVNIuaew8uCABKS63C4P0g0j?=
 =?us-ascii?Q?7wxIsTGif2jdE3CVp9wQ3jdoV/lJVzoj3XC5P+b8zcQ7JM8hb4vnaam4PIlt?=
 =?us-ascii?Q?LF/6UhFrg19NkneMgg8JnYjLPjoBIp8dbTVXUtIO+sHfpQShe2g+FawfDzdu?=
 =?us-ascii?Q?GXVxpssarjoy18aMm/oVPZgzmAiab5rzy5aWAIlnIfzwc91SFEPAIBs8M8qn?=
 =?us-ascii?Q?lLoDOeUUgU2PTSH1eVzmPLg7q5Ha1TreXauvNmkj/MLQCjamUrusnZC5C9uK?=
 =?us-ascii?Q?m/4XwzpC/9kA13Eq3ujh99wsKVrfM1UwmXXxqiv4Jaxphm5l1R98xwBh2MZi?=
 =?us-ascii?Q?ft0ZDHBsRqFI5X+Ik6xw0lb7hpTRWI8mynOlvb5b3CDKJ2lgCpeUvXFY5eDC?=
 =?us-ascii?Q?243PWR6iT8JADWZSjd+ZOvooFbUYn7FK9kST7g+3s8Of2Hnfg4JC0IuQEzag?=
 =?us-ascii?Q?D8lUsoRMcl7vcXHpLlbk0rlrIkRmSFes9WwD9n9b/tYSPaJ6RJc1vF5ushnZ?=
 =?us-ascii?Q?6p5uMJh+QJRrwe4hwX2xaJ4p+lHpi7HlGyh5ENkqHp6O5N/5BPMcnZ3xYNMB?=
 =?us-ascii?Q?hS+mhWRWyom65b9fhcg8lyKO0luttaLYnVQAQ/j4CKmshR+k6EndqXfxyweD?=
 =?us-ascii?Q?HnwOSr63LYx2AlFspkE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d28fd59-dbf2-4ff3-10fa-08de3d6ab1c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 12:49:19.0763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0o4eLK4mKQ5f63h7SUK8pxRImmMQht2omYOEBpAawhaURyLfKZteIAh4NS/UANtRfUTjhs4sAmqp27/so43kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9047

> > -	res =3D stmmac_xdp_xmit_xdpf(priv, queue, xdpf, false);
> > -	if (res =3D=3D STMMAC_XDP_TX)
> > +	/* For zero copy XDP_TX action, dma_map is true */
> > +	res =3D stmmac_xdp_xmit_xdpf(priv, queue, xdpf, zc);
> 	Seems stmmac_xdp_xmit_xdpf is using dma_map_single if we pass zc is
> true.
>         Ideally in case of zc, driver can use page_pool_get_dma_addr, may=
 be
> you
>         need pass zc param as false. Please check
>=20

No, the memory type of xdpf->data is MEM_TYPE_PAGE_ORDER0 rather
than MEM_TYPE_PAGE_POOL, so we should use dma_map_single().
Otherwise, it will lead to invalid mappings and cause the crash.


