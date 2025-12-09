Return-Path: <bpf+bounces-76360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB052CAF9A9
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 11:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15E913091A38
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 10:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB52D5C83;
	Tue,  9 Dec 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cykGpypk"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4C26ED4F;
	Tue,  9 Dec 2025 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765275317; cv=fail; b=EvV6sgRfbyYAdE8We8ZgOcjvFNs2nkeJQQCZmCg3TjAUiiYTHCJHWdj/GVQPfUF5xpg3h34TLifeXJ6KlfKXDvi7feWQafnddUAii2ncXLn7lB6gXGK6As3wXL0CWULkiHhZhjeHM4/91kCl8HdeQAuZnjqTS2bDsGaSpEXe+wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765275317; c=relaxed/simple;
	bh=Vs1+VtRntuaZdGVZUE/dX3d2pWTQp7+OUXRmrYprRnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t/75RGxpNDQQWYBDbv2a7hINTZJOeN/a0sRFBBdyNGN2owbl6Uiu56uKOTtZDz+BHchru/wZoz5/BP+auHXeq49w9WOqveG5nInO2587ACICvrj8jIOFHADde3iF35y9cLe2we18OgB2Tb0Js7v2mU7Au+11/X15m2qmnHldDrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cykGpypk; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9kEy3fw8yaerdEYf8D9DmCA+/uDq6/Vf+zbtGS805a5K8nuZZY284lt6YjJFlMUavLw9ibkfDb62RblZt0O1bXdWCIynGzpsq5nUp9++2fZcZK0NhaenwO6+vrdlbzvYBWP1ZgiWdkNLF5zUvsas5TU+Av65aDHH3CobAZJikWAwidsCUZFISbG/KkOGuTmlhEcj7cbDtGs9F9jh7/snIZVzIcKj0d3z2ngR1UPUfgbww6/NtwvxMiZR3EUO3InPQ637tTRWBVF/6IlLVinKTQBPY3di5uYvDEBkVdzlfz/ewcmzHg6QM9S8ptAUMAbjU6qRwpLd23tRvxdMvNqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vs1+VtRntuaZdGVZUE/dX3d2pWTQp7+OUXRmrYprRnw=;
 b=Q/VMNCApI0VkWQZhcSavK7lIAOJPuPLxbZMQxuXBxBGvXDiS4CNIMr/t9V27r2314peBbSnzPkbDxw7OEt1ecz7R1r9s9lg9Vm0q1V+GBrg+DDAdqJD360hWbMEX7iT56xIpy8PtY98pUgUERZhz2/DRn2flnSIhEShEUAUWX5sJywZIPV8WHcWnDnVTNaH+Ld2/7fLT+iTTS3sZeHMMVa9jLnC5L3Fj9sMEeuuupI3zse1aFWYvdlyxEyUNV+lEl7ukVRd58R/n71J04m+NGsvH5aaLT0rDwoHKo4PKKYl8T7jGLjdhLrB3o3Nzq8SksVr3WUlztcVhQMX1Ek6ozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs1+VtRntuaZdGVZUE/dX3d2pWTQp7+OUXRmrYprRnw=;
 b=cykGpypkAOhUeUhO7oMYSJtWS/IJ0uYljm0aQnccx0QXRx2Yz3T5279nhceaovOCHsC0FwHHnlYfDSyRgjj0X9ci0TkjaspxeFAubIkqLGfvkEj+YPati+GHuuj8/iD3CVDvRRlDoItw8MCCEmDmbjxHL5xNCu5vxuHMpYJU0BAsLYSuqmxi6n0Vfyqbz77Y4IH4ACBOvFuzNnZmFbiccG6cDIaCKC6XzuFH7Xtp5ZJsTy4ymBW7sfxW/UGzmOPunWEWbcoeIKlBwIWIaacwLM+lPOhSND70jI4KxmWQXcJukHeQvrexSpA+xwjR1YKcgHGqBxFiFFqHb7S9hbM8kg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9836.eurprd04.prod.outlook.com (2603:10a6:800:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 10:15:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 10:15:10 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net] net: enetc: do not transmit redirected XDP frames
 when the link is down
Thread-Topic: [PATCH net] net: enetc: do not transmit redirected XDP frames
 when the link is down
Thread-Index: AQHcZdVIqiLJYvST9kiEq+ceAUspCLUZAeslgAAB3OCAABB/gIAACI6w
Date: Tue, 9 Dec 2025 10:15:09 +0000
Message-ID:
 <PAXPR04MB85101D7D109F9128D2EA714E88A3A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251205105307.2756994-1-wei.fang@nxp.com>
 <20251205105307.2756994-1-wei.fang@nxp.com>
 <20251209083531.2yk2lv2rahouytv2@skbuf>
 <PAXPR04MB85103577C97139DE324AAC3788A3A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20251209094119.5rv4af4te6w237li@skbuf>
In-Reply-To: <20251209094119.5rv4af4te6w237li@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB9836:EE_
x-ms-office365-filtering-correlation-id: be1c0f6c-c7e9-4cf0-1cd4-08de370bd5a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r2LxoX4go3gyUT2La/FRvEzAIF34YFcfNNjQ12EzOOsnMMJdrpSJgSsS8RdG?=
 =?us-ascii?Q?w7I4TAnXkwMCxJCXXF5Tfe2gy/AnTztAS/3AzYMBBb2btGWxFzeWWQmKfvq9?=
 =?us-ascii?Q?WJg4ztWLSCk1ipe5NaLih4Umj23rfBLDY4Xce0F0ubA77F7YiRNdM5WS4jkF?=
 =?us-ascii?Q?sKWjpRlI2pv2lqda9L3PKQqP68vAAifjYEVSTLRyD7i8CWBcVbZOSNm8pxFL?=
 =?us-ascii?Q?rHr2Z2Fl5Np8DSZ7lXWx/gjdN8wFuHMxhSiKE3um+qRh+g0hic2AUFvv4rBI?=
 =?us-ascii?Q?FfLwc/7h9b9Q3ZHJ6dh0ycs+CWPVV7/NsXgf6p3/JqlYeA939Vc8QYHObdC+?=
 =?us-ascii?Q?Xq2wD012wc7oW1ID2MyUuCPDjNJtPz5xEiz1HNwIY85P04almJXBwLpZ4onG?=
 =?us-ascii?Q?nG6TSitA6+EFdM3GKPiLghyMc3ijuvUA9LDSu3B1Sr54QHhZYIJxJKhOA+Gj?=
 =?us-ascii?Q?755gDFnYH4AEuR9H9Yvvn0k81IRB7ifKiSBCQgjwHTaifui0WG+teAP3UaTL?=
 =?us-ascii?Q?KtLRBOzoyiPSOd3aBOEKPTTZfoZUYSjAjxyhyTfkPfk/DfN/wgnEAtmyAufA?=
 =?us-ascii?Q?EHoUf1XtHtcT7ynhBe54fTKIrbbCQ/64UPFBuGDI5IAV53v1hpild7Cnkczz?=
 =?us-ascii?Q?UWU12ktuksRtuzMoiZhdnF7swhKXdz+bOqAVqu4VUj15DZ1JjM0l3zDSMHWd?=
 =?us-ascii?Q?j41/ObfFPk+OBWLB+nvsKjCdnvvw5jRxdkoBGFcYPFP9VfWSBgbbXTF4RaCq?=
 =?us-ascii?Q?NqEmGWweyv4eujbkDolvdISLIHGbWvMzKNljcMaJAhJSMmuWT251E963B+QX?=
 =?us-ascii?Q?g2PWCXBf8Wf29dE2EyGL4gnrjAtipc+Kcte9IHkmfaAhJ/lOjeInQno/odOu?=
 =?us-ascii?Q?ogAtRj2DhPpZ6/S20INTTSLt+N+hDuL818vw4CMoK6VgmI+KkcThSwB6bQW4?=
 =?us-ascii?Q?tdll5YXJunu6M2ydfaAxm/XQ0JehSFM/zMHZyCdhyfRi9ZPCnNXsnwPwio+z?=
 =?us-ascii?Q?YrnFgJzqsux7lA+9wva0RFXcaDufBQly/+hHXhM1kr6lADjhYbBwqBF/X+LX?=
 =?us-ascii?Q?IO0mZ7gsYLAwGWu6rP0I4ikHBk63iQNMPm6C8TzoP8QMarYeHI6SAjq34f4y?=
 =?us-ascii?Q?5K4C7fhqHEJxtKPn2MrVZ+svWdBHff0eD+US9qwi43Tv2qgcPjuOMDzpaIIR?=
 =?us-ascii?Q?1Wvqll4Pj3kozsiRIK/X4drbI+PTkcdt3TBdaTes2PYBoCS8YAKFYZ7Y9R6t?=
 =?us-ascii?Q?N6JGkWnawDKNovcJSWVK116PvRH0EH6n2cbQQr4UdBLevz/ZUsDL4yKSg6Nk?=
 =?us-ascii?Q?41M16mXpWA60SHbc6Xc23xC9EW3sKIcr9afYcwOXAF8ezCu5ruJs+/sbTkef?=
 =?us-ascii?Q?aDXbOuVLDTIXBg6yY0H12RY0kgjgAq2EOfcfOI3KflMnEgfDkkq3uqKk1qGf?=
 =?us-ascii?Q?dXxuOO+x0bVv/HXLEF3onpfokWMOudqWK+ibe9VDBc7suJRR5bOpwWdigKfz?=
 =?us-ascii?Q?Js5o//WGHW7HPnwPPwHOsk+Do8vnqvD5vDQA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QjWLWBAuDUBjJ6s1WRnNzlnuh5jjTjiZrp6nlhizoB/aK/8pYqT+3g8/6r4p?=
 =?us-ascii?Q?3ZoA5O+hiONO1q4rxo9OTknG5ueTIrp1S3H5D32pPqgz/KiYyUQl2KpmeoNa?=
 =?us-ascii?Q?mcMEA8m7TDHr/SSFVUl0HLkvNRMcE5VoFHIs+AMX1Ft3bUO3GA0Z+xWeLQQC?=
 =?us-ascii?Q?739Sm3Kv4hYj9CBmrSU0awuk55FT68qMtYvhWbyLi6RFORW46uYHviigsKfA?=
 =?us-ascii?Q?LZsPI6E4ky29fto5KFIL4IBXNliQNkMGcU/K7U/cR7o/h8wWpd4FI7q5VDk0?=
 =?us-ascii?Q?LExCLCjdzVtWzTMkTzj+Ldb7CjrOEgrxYf0/ijBbi9vEmsU4BvrNA5AqD7Ss?=
 =?us-ascii?Q?LtvZ1shye2zu3Rw3UnuLdax0285b6Glct5CYO2Q90ZjbydRpEtH9aEtsepJK?=
 =?us-ascii?Q?/WWLuQ0PPqukp4c15C1muwk0+PlDxeITBWiGvbo8kmv9gt32RCV6mYzjCZJK?=
 =?us-ascii?Q?YwNyFt4nol7jemmJyt/ZuFDwYRQsfvBvwHgjqmZ+5WsVx79Rh8IEFYNlJuMB?=
 =?us-ascii?Q?y9YAq9cS1CFaEj33wFDKwRN+6A81RzPBwLflMWBMkXZ/K12QarWZY2mEQcvV?=
 =?us-ascii?Q?3FB6pziUTgsfmHaqc3/OKyMLqXEsRjrURwQk0XpS6Or6glQNfPcnIqmehh/B?=
 =?us-ascii?Q?A1vT7AFzm0ADR9qdn/o40intg7DxYUP08sXG1LtZhUO/6UAiHsJshKrOVGhI?=
 =?us-ascii?Q?8us7txfN3/5LmNyw++V5qbQGdHG2vUf7Edpu1blrsRHxj6l0BXFShfSJXYJ0?=
 =?us-ascii?Q?OlDKNUYS0damDC8YNIQAZFBiG0B7yx5Rob6DX44iSLOQHfVosj/TUKkyJybT?=
 =?us-ascii?Q?vlul4+I6eHZJuLX/XmFJiUDm+9kzZVfQ4Kg4RMcgBDKqNeKgxNdH65A4z53j?=
 =?us-ascii?Q?iIJZS6IV6LTdEOqm1jdTmSDyBAJ/OyKww3cHUhqZEBnLNvUhAJ4RQcYi1gn1?=
 =?us-ascii?Q?dcOCnsTkdW+x6UcM8wN79KLyIAQrTY2eVxpligmsYbrfUv7IEbkgQ81/sZek?=
 =?us-ascii?Q?bDxd57ngVuH9rrpJC5+X7blZ7A0Ih8GBRi1pqJmVBSl7ZppQkjOolnQGySy5?=
 =?us-ascii?Q?0NGNMJu+o5d0EZOvINJ3SejDi8YqNtMnmDecYj/Lw0M1lqWLz0MSxGMh7tuI?=
 =?us-ascii?Q?78SbbXzuWKYVK3bT/bkTihBPTH1QOsyWovO6p9Bi8TI9xvVg7MxN40Drrpcv?=
 =?us-ascii?Q?BxT2kSH3UBjTKEzCu9+TF0D9Q480kmu2Swzv9YeE46JvsfV3Vn+XBci1BUgY?=
 =?us-ascii?Q?w36+vQvh0zQCTlkDI3PGSwxhyObyLxWBT1rC5fsCgtzmKNOxhvblvin+uy4f?=
 =?us-ascii?Q?chnw/FeKiKriafMRlx5ZtFf9GKSY244J/5W1/tXiVFvN2vwsipEvtzsUpt5u?=
 =?us-ascii?Q?xQDTBWabddOCLEp++MNC0ikb/JzGaCon7kGxNDMW1VqEoi0nEdEFCqSKDHWa?=
 =?us-ascii?Q?Yp26xnKyLXPz13EzTqkEhU7xixYcO/1tbd/GFsIQFNYJCvR+HJ66YNLQnz/4?=
 =?us-ascii?Q?8CbyF90dU0AI4zAQ3CHLzTJFFoDeK+v8czeR8Om23Nhlb6ohTmg3hxRmbBRH?=
 =?us-ascii?Q?T7HsLgiU1MsYLXbphns=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be1c0f6c-c7e9-4cf0-1cd4-08de370bd5a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 10:15:10.1076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ye6e8Oi0kSHKkvISajQ6TRBt0rVAVLYs2ysqekwEWf0oHP2qSUszcE4wJBV1XNijQ3EBG+qNEJJF3nG8qOJdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9836

> searching, but there's nothing conclusive... I'll experiment with putting
> the MAC in loopback via COMMAND_CONFIG[XGLP] and then drop the received
> frames somehow.

That's great! I think this method is feasible. By sending the packets throu=
gh
loopback, the TX BD ring could be cleared.


