Return-Path: <bpf+bounces-78977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE86D221EA
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 03:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4111303D15D
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 02:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09289274B5F;
	Thu, 15 Jan 2026 02:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ryy7Ap7H"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2210F20C488;
	Thu, 15 Jan 2026 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768444040; cv=fail; b=BblJPgJZPycokKLaHEpr1yOR+d6ATBB2FAR1eH9FvUtzMFoEmbM6uTlVmUyDaUcm8QDdfXoMfe3GvduKsBYS9sqSVjLMbP43OnbzufRJT2mWIWeoWMmLoGD0ptOW4pn5eoO48xsf6JNbuwvHHKvXxavtdExVyjI8utl45AxFaHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768444040; c=relaxed/simple;
	bh=U4BZ2kdCgrJVE1dDdrwZUfXSrZe6PTxkBV9/Z369pEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=to+ep0jBMs9y6TfYzyHDUnnX5lB7iJ/rHjUT8fzvT7aIB4RouaZBSB62OCCvoZnmH8APm0Nivun93hP97+fQ47rRsVVYVz38Lh/UGh3hrNX2tgB7UJ5+JNGBMYQLmOuljAXxLE5GaiAky4glK07nmL6D6N2D+VZwau3g7bfiph4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ryy7Ap7H; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kU1EjWN5R7W3xiDVFcE+IyYKfF4lQgAvUWDXfPuBVNvMsiVWmlQljfPBExhMEOJ+rmcNm2EEi284b96aIhDhIf7ocJmlZ8Nhperbujgdq3boZxqaFdhWGOObZbHqwtQYiIgnP6Ddafcc/uno7hJ2LW7SbDMu2JDt9MP21VMu2RLb6t/FbL2NWh3eIlskiPRvpEfouU5e6ZL/ga+DKrL/YShiX6TvFKIwo4G8X7NKIlR+t0HEO+cy3tQiPslFw+lZxLV+U7Tn2poD53qdUC9nZSSxBwdeOMz8k6sO8XWO8u8hxDfn2q3ex2IW+9sJZqoJuVVo0BtK0QdpJjtv0N91/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYBKzn3rHbxPKx3X5NiGDYq21uNZEDIGbYgFQJ4T4Cw=;
 b=I04gk8JAY3i8znUI/1b7SAfhjY33mR+jACBI7Osrh2g6NgOhB/y1OjDxGRnVoGrAMklKtdfIQXIst8t3DMyJF5KGEpFlKSnKpcg0bYpdoqNBh0G/KNBb/6CBG0vnvfoJd1GPipwJvpmWc+1GqbcfhooGyna/wBce/Fn3XHfKmSj5E+aBzXRIM9D5VuzWO+gIKpgwLI38EhK+m+YQT3CfbJUPJBo37110r0R4TKUYNtsajDdqsHHHSpnPFgSkUoHd36xhI4uV0AdIP3wFnN1X0ng6GvyTcj4iRW0HjXM986JJpNVqXumETXJCzFxzSHKQ6Jhe9RxAd1/oMwvc75MKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYBKzn3rHbxPKx3X5NiGDYq21uNZEDIGbYgFQJ4T4Cw=;
 b=Ryy7Ap7H1UNd6rj+wZea2x7UhmXo6g4d0EqLYiCwFCx410u0yKoVPkUnkp6euiZlTt6Qflm4wMBydEOGa5oqgePdUdIK5WxJxFsQoXZ9lq9YMEnShy4fHgBwdxJdu0GxhGumHgc1S96wBYbrl1/J3iZ1Cn84ntfqs9MZAYpa77tHbeu+BwIYNLxJNPDIOtwmxqPamJH6lT8VI8DxdyZD5qVIMI3VRIaKL5oI86SR2qzIBsYchRMQE0UcEitNTPkyvpq8ucscboYVmOP+r7OMUexEjRymcnY73O5VwTlm29qnrAN8B0UxlOXaq8DO294e5GP9wZ6G+/GgkEO4ToUwvQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB9347.eurprd04.prod.outlook.com (2603:10a6:10:357::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 02:27:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Thu, 15 Jan 2026
 02:27:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: David Laight <david.laight.linux@gmail.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Frank Li <frank.li@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net-next 07/11] net: fec: use switch statement to check
 the type of tx_buf
Thread-Topic: [PATCH net-next 07/11] net: fec: use switch statement to check
 the type of tx_buf
Thread-Index: AQHchDz94JEEe8B96kSUW261P6sEvLVRsBiAgADJlEA=
Date: Thu, 15 Jan 2026 02:27:14 +0000
Message-ID:
 <PAXPR04MB85108330035756EDEE55D943888CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
	<20260113032939.3705137-8-wei.fang@nxp.com> <20260114134713.565f2b3c@pumpkin>
In-Reply-To: <20260114134713.565f2b3c@pumpkin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU0PR04MB9347:EE_
x-ms-office365-filtering-correlation-id: 66bbef33-7cb1-4145-5042-08de53dd98c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wjCXbbSNzm8Ut3ijD+mSvOW6AGgIgN3DZWlcw65y8Ujl7lDBAzsRG3BTthWF?=
 =?us-ascii?Q?rmSaYjvkqRCSa+C0nmpbuh5xR6pDaPSp+x6BNY3xcg2fOn0E5E1X+T2+I5R3?=
 =?us-ascii?Q?uz2IVChZDLudglnuhUyYgyluya8U86HJyf6r8Ukn9Hxo91TAWNyBb3wG+Dm7?=
 =?us-ascii?Q?sxxcfFunc5LiJB81c2J5ukhcRVzj6sJ/YFVwgDU3ZOTrdb8GUtjnQQpIhjOQ?=
 =?us-ascii?Q?zBMRzYF75qSH9NOAF3GAgJOXtmEj7usDxJdiKzDO88eQJwt1xP9O8QsSmcmE?=
 =?us-ascii?Q?p09vIlRs7CQQuS2Mpc/BGxafDKHQskDoL1VjZOGJzooX1VjiEb5LnXS63pEg?=
 =?us-ascii?Q?dWPv/CWrZLIN3hvMIdwSLg0ozf9Ztsnd8rJvtmLpJmMifADJkO8Xxk68oyUI?=
 =?us-ascii?Q?iEwjioKNq2VUpiNCHTnbosDN1U602oC7bsA2MwJG7LLbPZ6AIVBF/Qh+3aNt?=
 =?us-ascii?Q?LdI6NyvhIvoIeyldYzO+9Jl/oYpFsMFFTpEoU7BqJZXqGUgMSn1Z1dF8CaoJ?=
 =?us-ascii?Q?jo0WAignGgJ5bqgfH1ca7McmxamkeTKUy3hpDiS7y1FjWXhFPACFYD9Vf6h9?=
 =?us-ascii?Q?tZXPEz15hzxnnLJ4oMBbi+2261fjRkiEQCeW7oZyzdH12RIif0o/W6iIyy4O?=
 =?us-ascii?Q?uF4H8i8G9Q4xpb9t3RqLE4TLvyeibCCuBzg6zHBZWdFEE5SmYT2imQ0bEYa4?=
 =?us-ascii?Q?ZrbDTOgvUj2D+HLGsLh5aVo/WXNDRyErfPUwEEHoVCwlixhwYkqDEMUxJ5sa?=
 =?us-ascii?Q?iEp4BdSJoW9EEfybyY796UdJ84nhogR7UA0Gq3KkKwNcsMCs+yWRI11RbIvY?=
 =?us-ascii?Q?kApi9IIgXsJtNo6XYEqvrANrfLwk0pY5S9/cEfCosmBVsckzOQ3V+6A5R8ZU?=
 =?us-ascii?Q?9m8zW3CTb7lPEVgUKIkqOqjEzNJm9Es0wmhFBRrXhf1td/bplyvxMrJflUNa?=
 =?us-ascii?Q?F9TSxxetfR2G6mJgqa6c9Xu2GkqGtvCqPcB27Q5Dw+g/hcLAaqo7xWyyUPmB?=
 =?us-ascii?Q?fwW9qAuqx52eREKOoUstwUzr4BkJjJt4Tr0VVNgATjoN/znOII7faxYK+p5B?=
 =?us-ascii?Q?Dzz8B2mkBIrgpN4lraA+PKGuGhBNmRXTSMvXPlBnG3qhJo9qWbXTWf8ntHPb?=
 =?us-ascii?Q?rAIDSVKteaeQJr1xYTTPYhpN1ZJa5rEURlwEn3Bo0jH8oX9vhMpJPmjOyMLE?=
 =?us-ascii?Q?LMqL9AfgX0xxHls0TkA0g3M/nmxKNWc9ntPuGOsycRET41Gy5fTXmmf5X+Aw?=
 =?us-ascii?Q?7ucciTQp8DzY2OAtsfzEtwpJATk2blmpiYxpDWSxni6wJp2ekG89a4QtUy35?=
 =?us-ascii?Q?qxv6d+sjOPjj1raDsAG755gPTZHfan92F8ChEkyhwDn+pEkFMtclpFx3wWQf?=
 =?us-ascii?Q?rH7/46bAbar9rr9HrIfIxU+ZIvK79b69Yv2gdpdfOudo4AqliejJPXTUr8uC?=
 =?us-ascii?Q?ZR9ZS8AM/wOW2nrMRME4AQpC3eInaQfXhWzEqNBTQcbdB58BtTR/NmDeLkXE?=
 =?us-ascii?Q?zxZd6+pJCroOh5BcXrSzKNtSf/ExmYAz1LgD5PEs8luQEosIOB41FZkFVl4h?=
 =?us-ascii?Q?2YkiQKUFFmEPNbgblT/vMp1DOsciW9rkZOVTGOJeHYq4pL0k7HPSZklsqRPL?=
 =?us-ascii?Q?obhM0Sj1Exx/yoMomGjt01A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/3st0zk+UHuzBwEc2pTJtTMj8XkhZ1b0uwH4x+PDpZ2WmHcL7GxoWdaE63Nf?=
 =?us-ascii?Q?uVqd8NgmvDN8x2gnVD9F5wjaAjskaspdz/JN+Ym5fmSNV/A3rfIgoFZuJHcR?=
 =?us-ascii?Q?1DlGCWfiGutRneYpZhXxoNrOkWRdEFO5XyU0amSZJva879BiDdJgSxcYuDVQ?=
 =?us-ascii?Q?6QUI0icSkhRakJ/rvBn8PDY0MTDMAkh/tXE+RCT/nK7c8e0yobLcRm3cWPyN?=
 =?us-ascii?Q?AouPRqryV1X6TWoh1TrsWykTiD9p5DS08rGFR2363sc/bWfr0xjoEkdPFphH?=
 =?us-ascii?Q?V+cl+mNn6uig76nzKJTEWzY1OpC30PzDyX9nm6tucunAZaEQxjqt4NeqyzT5?=
 =?us-ascii?Q?0QtaHHGz9Y1ofP4XBp4uoRoer8eQBz0w3AcBMeJOrlVQHMZZ2ja1pewA3WNQ?=
 =?us-ascii?Q?3NMj7IglW3/XXAZBhfHNPLq83W2C+dDxrblRnHNa8j0FGFG2pEr7/f7+gjju?=
 =?us-ascii?Q?/RLvvydpzGaUgFFul5gqKb5bQ5x5NvM+paW99jgsZcWWIACJc+JLpTU81DCc?=
 =?us-ascii?Q?2w29f9eV/b8xoJPscYDYaKrHBDyST/PWyvpSxUiT4LkGWea1S06t+9ley0aV?=
 =?us-ascii?Q?cUkjFWPPksSFIn0EUkvTRbDbC2FOKhVZq88eLPMF9712AQ1t3XUjmKbz+ue0?=
 =?us-ascii?Q?JmRLSETxWz99ObwG7rq+AmfVNZyl1OLe+m9XXAfqdJxlVCKi90nzQrl7M6pq?=
 =?us-ascii?Q?uk09VQoE3wjVvcQcqkiYFcS9u1xXU5Zhrnr5wUgH07l6ElyXseW1NPYMLzOU?=
 =?us-ascii?Q?ViN2efcvecpgPLCXgp5xMbeOHk54L+awXWVqLsCPDljuRgH8qGcMZ4pOwzwv?=
 =?us-ascii?Q?Xhd7/WIFp4kPF8YHkLOQtllQ4gh/jpGYgDBmXvtYSK23eEqkupXEHT9PsKYD?=
 =?us-ascii?Q?PdiOqCYFUq4IcO6Xa+O9pFgV/LUFdVZtDM/crPtcUu/Tr91j2UCvJl0vNIz9?=
 =?us-ascii?Q?rXtrUKLub3jiuQ7+4v6xX/NplwhZaMarEXWkcUCkdfU9oMx5IXuR3eIW2Ysw?=
 =?us-ascii?Q?GRA+7VRoeGE4gXCYC+bA8vQWTBwkZsClIM7P9PR0ozNho31mavZrU174XmnO?=
 =?us-ascii?Q?rjs68cytBWxcPNciz1LsJLaYA67R4WL4Of92eqVFHheCxq1jFoqj6gli1ogj?=
 =?us-ascii?Q?wm0SJU0I3YBo1O2utWyyxrK309QOnwusdK3mJykyutfhyxq1gHgtTkoORmmx?=
 =?us-ascii?Q?2gtvShm25AzfvM2tb375njVSF6WSllCx6ZsPGEYQxrAknngBIj20Znk8O2M9?=
 =?us-ascii?Q?KLAVbPPrLAFLBFBzmOpMUXZhejtt5GCMCbWGMFVfghyY0jpQx6xUcEfvAXZG?=
 =?us-ascii?Q?ZRaLPMI4Xs/3yynTKoS/e3E5H5gZntNDHnVMRjpEoisiN/AazZ50mQyBlr2a?=
 =?us-ascii?Q?a56+pBwNuuMcVycm9KjghI2rdk3hetkzK3YLRr8OTQzNVvo8LdYhGBCd4nUt?=
 =?us-ascii?Q?FXCUj1C7Ya4B/QKJMnNYAQXJ4aZdOnq+GCJ+x32cgBseDHmCnSZqQsYqecVo?=
 =?us-ascii?Q?83mFd5MQcdXHA92jNSUwofgZzE3NdUotgWtxUoWHZ7MSMBPOtQhUFF1RCUJi?=
 =?us-ascii?Q?/OZ1fcwvm45G1iTr/KrhYWgQjJpXDDhvm5v7z8QTvorfxeQQU7p68DxiGrQ2?=
 =?us-ascii?Q?xLqoXd1+pMgtUbpJ+VK2x0vVq6ypQuNsDdrlic7EjbS7aMmzYU8RNse5rLAv?=
 =?us-ascii?Q?77iwp2ngXZjR9kxFaIfAVIMk/vCpmhumxHUV6futAQ92YcIH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bbef33-7cb1-4145-5042-08de53dd98c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 02:27:14.8957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yM6QzTPBzkfni+auhTIOjlTtazJFGy8rWVvS7+uhIxVkaeC6t/Kt5vS7j3XHKBYavkEfhGhqIV99m76JmwU9nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9347

> > The tx_buf has three types: FEC_TXBUF_T_SKB, FEC_TXBUF_T_XDP_NDO and
> > FEC_TXBUF_T_XDP_TX. Currently, the driver uses 'if...else...' statement=
s
> > to check the type and perform the corresponding processing. This is ver=
y
> > detrimental to future expansion. For example, if new types are added to
> > support XDP zero copy in the future, continuing to use 'if...else...'
> > would be a very bad coding style. So the 'if...else...' statements in
> > the current driver are replaced with switch statements to support XDP
> > zero copy in the future.
>=20
> The if...else... sequence has the advantage that the common 'cases'
> can be put first.

Yes, you are right. But for the current situation, we cannot determine whic=
h
is the common case. When XDP is not enabled, there is no doubt that TX
packets come from the traditional kernel network stack, so FEC_TXBUF_T_SKB
is the common case. However, the situation may be different when XDP copy
mode or XDP zero-copy mode is enabled. With AF_XDP support, there will be
five types of tx_buf. So there will be five branches, thus I think using a =
switch
statement is clearer and more readable.

> The compiler will use a branch tree for a switch statement (jumps tables
> are pretty much not allowed because of speculative execution issues) and
> limit the maximum number of branches.
> That is likely to be pessimal in many cases - especially if it generates
> mispredicted branches for the common cases.
>=20
> So not clear cut at all.
>=20
> 	David

