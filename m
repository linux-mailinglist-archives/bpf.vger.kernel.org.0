Return-Path: <bpf+bounces-76964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA009CCAC82
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 09:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A6F330270E9
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD0B2ED151;
	Thu, 18 Dec 2025 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iqf7ShUC"
X-Original-To: bpf@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB922EA482;
	Thu, 18 Dec 2025 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045355; cv=fail; b=Qwq2q1Yf/XP/Ao+LmDcSLiI1Ede6TTzBv9pN9poJralPLU4FYgC/W/WltF7/TeNJlyq8gAJ51+Em340WR7oMO6bqb792nWRTCQvUiZhddxiLW4IyCbu22JGdHY4xczRnbel/LZl1t6pN3lr/ilKzbzIWcNlZqmSoqOCHFWcDpaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045355; c=relaxed/simple;
	bh=E1Hao6hg2dQQ5rYvaRU2FrNipY4bZ9cIEOmB2LkOwbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VrNROU/Kctgyqk1swGnrRj/Hl992EQVZQvnJaEZFgXDDzqNM70YaeGvXvT4GkODsodfhBbmpmwfxXX0O6VZdXJoempT+DQuMfoDKatfb6u02dPxcYzDWi8znfjDg16ijioqe9DI45HG975ItKDfFCajRgzq6+gDVohnfoPvS1kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iqf7ShUC; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TocrHCwqNzvLW7EQPKNm3doBDiVLywrxXXFhfKLfDJBSYyPDl2dsQOiS/4Z6j7XhIPt/dVagVXBNTIB7IHbYkrmQxOJoUdC9I4CLOGMHOng2/HaMm1tVnA1E97/mtcqkQPJA2lgQ3S1l9IZPYHQ5N98aJwkMcPJRFlmsuk68otHO0zX1na1X8kRV9yCxZyAb55OGcabWHMJoyahO732k5+SRjeP41BJqMOcPmFfMASMG2vT3sf+xeGu50Qcuw6De9f6hneh47LeCVXkYoF4ufadXTjtKodopIm5+PYXypTEvudvJ9W3+ZyNgwAfEnw3DWu2ZsLTF6qOQWV/UA+oDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0Xu6Mnuva8+4egBGd5O5HWoVJIG1mp7Oqj8L0poM68=;
 b=rGuMX1wQxePsNHBKXQnBUsBETS04S6N4+QpsONpuF0lojZzfUAp+uaPy4Ga9cINDjBP2e/nfPn4FBPE9ib1zq1rIUmvn/KGtVEQOV3kMeAei/3jruk2YWlsIqmXI+V/wJsE/CNiKjnBOpzn70dfLL9qdFLz6zz2N/RbRvHGPzhDToLMnyQQ+YeDDgVcwetBK3C6pj2v3cI+edoY8f0anYfb1cH88GmZsDq8SPFb5rqU3mTmynxDG0/nMAxOLL2eQ59m4ufFSmFm7rnhY9NNmDlYo7V9F6lLqZUj7+LKpBqQXt9AvUyjeWfktMJYFaeCYc0voRqM19IkOBPHMBVjpmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0Xu6Mnuva8+4egBGd5O5HWoVJIG1mp7Oqj8L0poM68=;
 b=Iqf7ShUCasIAWUfwBp8xWrxiPh/17ik+JNo1e+5VlgOfzYI1e5/QHQcjeE3nL24Aed/QXemtoRdFdAl7HeShyVob2RMlG2HDInhY7SiiYdcwBlrHIAZQMvzXi24pazAOCezLisqaaLcXIRLVFLLz1TOF4I8IwgSUrE9NB/9a1Xhea9EHDoONvY8iMXtKk7IwZ6ryDdY2pdInkrBlG/uU2LX3gfwr0Hmp+NlQH3NJ201bmRREHJoIbTdJEw9Qooj2KhGCXNOKn4N/zSSo/cK8jNqsc4q3q5p9gZiiGoRrFVplzKeLWJ3MdCVbdVY4us2bfkzoSU0D3OuSXdXaNbKBng==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8841.eurprd04.prod.outlook.com (2603:10a6:20b:408::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 06:36:48 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 06:36:48 +0000
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
Thread-Index: AQHcZO1pj0nep9pNq02KfA412DHJhbUlwQSAgAAYKSCAASoeAIAAAiJQ
Date: Thu, 18 Dec 2025 06:36:47 +0000
Message-ID:
 <PAXPR04MB8510499B65301187736D511088A8A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251204071332.1907111-1-wei.fang@nxp.com>
 <aUKPHdtAPDnMqB7X@test-OptiPlex-Tower-Plus-7010>
 <AS8PR04MB849779A6392D543049A3F5BE88ABA@AS8PR04MB8497.eurprd04.prod.outlook.com>
 <aUOddielBMkrmwhd@test-OptiPlex-Tower-Plus-7010>
In-Reply-To: <aUOddielBMkrmwhd@test-OptiPlex-Tower-Plus-7010>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8841:EE_
x-ms-office365-filtering-correlation-id: 9c28990b-332e-4817-bc6c-08de3dffd203
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?by14MXCa2MI6qkz3I19kVD6A/EZnkWphJJ8c2vrxSc+vEktlHklnVtVqEr6m?=
 =?us-ascii?Q?K44AJ1FWZ1VXi7yBHDZfJamlYORikmjThqm1DTSKwts0U7c/2GzpYxMQeuMi?=
 =?us-ascii?Q?qZZo/H9UcHfyoyCiXlwAvef8kabKEbErVqitqzKzCn2p6ByBVk0HKu7WwSUj?=
 =?us-ascii?Q?oiu9xCwUIh5n4eqVDphvH+q6pRo2CXWY0cUbC1kaQSfFopKGPVa5gcl7ffBe?=
 =?us-ascii?Q?1tGZbFtOm8beiImuAh/DKTaVyIHhKHiLPMhJh5RajZUoEzspj8zMcLnbDSr+?=
 =?us-ascii?Q?JeGL5eI8LB/gGC3g1na8hZ12GRu+tyENqX+Lp/9IDsFiiHqqEzN7C0AEDxhT?=
 =?us-ascii?Q?xe6pcwOB+Okz1ifJX/hzND/6dEi8KDkHjlYk91y5A79YBY8jbpuI90YX5gQO?=
 =?us-ascii?Q?P5c587Kjv4WFuhL7rdpgDU1MLuAOL3/seVlybqsivz3X28Ijj0BuC1gg8tIG?=
 =?us-ascii?Q?N1YvV7wV4hQpMM76i7plYBxDuDLSc/s8tYiCCUC6ruhYgJHad7r84wc/EJ1s?=
 =?us-ascii?Q?on28VeQOVMBMaQ3MDci64WeW5M6RaiD0m5RuOAQEYwWRecPGgoCbP7tpN3z8?=
 =?us-ascii?Q?ysapQLv9b0jGKf8qWQEb9uX5DEicpPkZ3vfV/MCU0DjPhbCibbfdm5yh5NUL?=
 =?us-ascii?Q?QSPSNhIgakGjmdSSP623ml6QL8+Fe2Q59k51k+l73BT6SFq1WZ5Ud1Rsjhow?=
 =?us-ascii?Q?4OH78IQI8a3M7JRHIEgN+oDGhJ/ISwegGoKBLlg2VbsUbB122ZViGTDl6UOb?=
 =?us-ascii?Q?0AYXglKXnDN1tRd9bVBposWKWlw9CliBbIrhGuVp9+N+Tdp2AbBN+J5A6CxE?=
 =?us-ascii?Q?3YOe3/PG/ECxd9b377YSX6Hc17DIoWxOcUyCnmrTwpqKWI2nyhYPiZmesd9Z?=
 =?us-ascii?Q?BABgqkSRS4E3VGQVaK4hZfGd8C8//yxSC7O4LzSuL29hBmf1jk1WwwclQ9Kj?=
 =?us-ascii?Q?RGZvEv9n65MIwsDQglZGLPs1wXPTuzguZVNATBZA6BWnor1/H6m+h05XtEyy?=
 =?us-ascii?Q?BcCDHUcqIvwGrNKit0SKD0U4nTm/pMlPjB07wJrxBEn0tYY75R4yga+3VQzz?=
 =?us-ascii?Q?20uqLUoftJZJuMRVy+IM0cTLEYnIjQOaF0IzY3xoynCBL8+PqrnIpIvVI8lh?=
 =?us-ascii?Q?yu7MHc3+AtMqEgrCddVJQfRV2pCvxvxd9eITYpzHWi+MtbpzM38menJOUSLV?=
 =?us-ascii?Q?3XOFZH8ns7w01PtpRt06Zxpe9Yfd0ccFvOV1yGgZV7FCg7FEJNDkDyA0XmLd?=
 =?us-ascii?Q?L+yZBgYnyDROKZ65860TxHOkp5zTB+X6nxn68EIy58HMGvUnd0tzRkPjqf+D?=
 =?us-ascii?Q?gE/FxIg7EFTEuW6Wk9pabC/lbGfwLyZ4ZgVNOiec3iAXozd5BzpY/hBsZJ9x?=
 =?us-ascii?Q?BuSaT00yfBtKWGDXZylcdqk+UyfsuZcYH6FaWucxCan+FXSM7VBLxK7wIrGw?=
 =?us-ascii?Q?5qqU4LUPbs2V+O/TmH/dDEOpe/0FKGj9Uq0+3krmJ2yB1z8r5iJygfVz8wuH?=
 =?us-ascii?Q?FTm3aHY2pC7uVGAID04y3AN3qYI/CKWcgB2L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YC2sNxA7PQfuAvaJiRvLYCY8xbLBGz/qvKu54f+bDq6SPzdMXRjcVNwWbO2W?=
 =?us-ascii?Q?kPp+OU5IdEPx/Ydm2SNTCJKRYWRqkeLKRghDOh8d7Q1uuQXeCiWKewL3knHO?=
 =?us-ascii?Q?SWuOMzwXI2PryWLPuYhzqZaQoSf7KdujyeOu7oRAHAfkDAu6Hj66bk6IjHdp?=
 =?us-ascii?Q?e0jdDsc8DCG9o7Yxf2X2wvP5TbCnXQff1JjdGi62SQDX+P8Vid5EWHIHBLDA?=
 =?us-ascii?Q?yQCdH9wUN0yiUnilfVvV2d5thyeBoP/pq4u8wYi1dDkM4gZKbJOadSxaL4u9?=
 =?us-ascii?Q?EKuPz5KbuFalSM1KT5eE0CWr9uan+eWlU3LBwCCv/ZaMRp3FB1nTF1M0HSRd?=
 =?us-ascii?Q?db+9KcfQcm28mCqge3ZSkCIldmz/NTsBLf870ZbsFNLdP8S/epNX8xcXU7i6?=
 =?us-ascii?Q?yTKxfmyJAgzCs6vo4l4f0AesUeHxAk+q+Nr/ImKN/XLFyAAi48EEpyKXB8cy?=
 =?us-ascii?Q?/xtvO+UpdnsQpDml4aOqhwO35lcdOeMbTknQhdRZ85kgpIgxlUEodt3xqPkv?=
 =?us-ascii?Q?1tVqjY0qCUV2GytMhexJMMxBKdxsTP+qaGkS6QsWPOjvS5by+7IVLNdqdNSJ?=
 =?us-ascii?Q?7zwDI3P2ZecyC2JwRZyBrwtMhLVsZOoeYYgZNbAVmV5vyu8zuxIukDlnxoah?=
 =?us-ascii?Q?pGFk95G+pRcNWY1I+6ORhG7Xp9iA66vQSzRvPqoXsKmQJnonKMjhHIAYQWco?=
 =?us-ascii?Q?AqBiYPlr0Pa8joCBxeiP8Ecqh+o0vWi3z3einUlHnepM/wtsA0k04uX8T/oe?=
 =?us-ascii?Q?62hHrNmHR2iwEhypUtUPbvGzOI1JE9kssO6O3kRkONTH5MIBUs5lVpgiR7Ei?=
 =?us-ascii?Q?s28CmTh4nW2wcWEpRo1+UYQKsTrbHkxsPmrcyal/PEO6Qc5XxcjcROjdSgny?=
 =?us-ascii?Q?NLinBMbXcKc8cvGTtF7YM7IDMJymOZSEdlomAFtzUQvguW85JAx2xGMYvR/2?=
 =?us-ascii?Q?+W23CuqQbkGyVsfZ9PK1RH29ps57yfraGCAl+QaCIO/oWiDFL139L8FUGP0r?=
 =?us-ascii?Q?aJ31J1ZegcPUkAgbQrC56n/VGb7/ISeFunHSyxXsGtpJ4JrZtZMSXm8dFLfk?=
 =?us-ascii?Q?GLtNDSAhSwDJNdsnVAbSH3+Ak9A/Cf5CPp8fnn80MniTNvG3myMgHeqwcn2B?=
 =?us-ascii?Q?k81JD1JuVl7hAVwcLXuAF1ye/BLGPlKQ22y5/Knut+bwjUjsvSk59I0l8nkA?=
 =?us-ascii?Q?LHF6IzqyINn8lepUv3r9j3z2vF+url0qnmiQ0t9LGok7oF+2Q4wjTKS0muzw?=
 =?us-ascii?Q?/1N5tSWEUCEn5jJKxY8jfbESn+wT8yX3SHKs/OZFuCU+GGv9jtBIeGb46axt?=
 =?us-ascii?Q?dLrmRFOn0vZj4GOBi5HR10KkaFpzxPAOGJWUNa0cAa2EV7LMqGRHTadAUisZ?=
 =?us-ascii?Q?LB1EGdVgefPuJJMDze6zs84qIawxIdnIjkYqJrHF6KIr3DbF5USB0NTzub+n?=
 =?us-ascii?Q?7gXPc8y9cbaDcqpBghLV+22k2eeNo3kv28G5ZTUB6QU/Wnx7OdGJcXe6saoV?=
 =?us-ascii?Q?1i4bsfLBcY3e8MVML9sDRQPDG6OiSbLblkP9LXHGEmBc1Kc/G5kPAnUH8NuU?=
 =?us-ascii?Q?J7iIcW4oEHs6PzGKUGw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c28990b-332e-4817-bc6c-08de3dffd203
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 06:36:48.2144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FamsfAiK+l5rRaczDaT6hzEcYhXvg/9YR7aecxII3uRcK7foHHAQTh9bW2UHiR3mke0OGG6T6fDmc+dpR2qGog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8841

> On 2025-12-17 at 18:19:19, Wei Fang (wei.fang@nxp.com) wrote:
> > > > -	res =3D stmmac_xdp_xmit_xdpf(priv, queue, xdpf, false);
> > > > -	if (res =3D=3D STMMAC_XDP_TX)
> > > > +	/* For zero copy XDP_TX action, dma_map is true */
> > > > +	res =3D stmmac_xdp_xmit_xdpf(priv, queue, xdpf, zc);
> > > 	Seems stmmac_xdp_xmit_xdpf is using dma_map_single if we pass zc is
> > > true.
> > >         Ideally in case of zc, driver can use
> > > page_pool_get_dma_addr, may be you
> > >         need pass zc param as false. Please check
> > >
> >
> > No, the memory type of xdpf->data is MEM_TYPE_PAGE_ORDER0 rather than
> > MEM_TYPE_PAGE_POOL, so we should use dma_map_single().
> > Otherwise, it will lead to invalid mappings and cause the crash.
> >
> >
>  ACK, found below code bit confusing
> 		case STMMAC_XDP_CONSUMED:
>  			xsk_buff_free(buf->xdp);
> +			fallthrough;
> +		case STMMAC_XSK_CONSUMED:
>  			rx_dropped++;
>=20
>      Ideally in case of STMMAC_XSK_CONSUMED, driver needs to call
> xsk_buff_free.
>      And in case of STMMAC_XDP_CONSUMED, driver needs to call
> xdp_return_frame.
>      May be you can move all buffer free logic to stmmac_rx_zc with above
> suggested
>      changes.

For zero copy, the xdp_buff is freed by xdp_convert_buff_to_frame()
when converting the xdp_xdp to xdp_frame. So STMMAC_XSK_CONSUMED
means the xdp_buff has been freed, it tells stmmac_rx_zc() no to free a
xdp_buff that has been freed.

I have added a comment for STMMAC_XSK_CONSUMED, see

+       } else if (res =3D=3D STMMAC_XDP_CONSUMED && zc) {
+               /* xdp has been freed by xdp_convert_buff_to_frame(),
+                * no need to call xsk_buff_free() again, so return
+                * STMMAC_XSK_CONSUMED.
+                */
+               res =3D STMMAC_XSK_CONSUMED;
+               xdp_return_frame(xdpf);
+       }


