Return-Path: <bpf+bounces-55614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D653AA83651
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 04:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107763AFCE0
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 02:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385F1C863A;
	Thu, 10 Apr 2025 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="rbITTOos"
X-Original-To: bpf@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F291624FE;
	Thu, 10 Apr 2025 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251553; cv=fail; b=hVKxgvYP3D++vTfjObjlBo6r/gMJdhiSfW7pqk+vGf7KOgMQ/7+jqyHGihLeJyo+xDMsbXmE6NEwWRAbJvDOILMIaCX6IDnMkBQgjo9OS/ap+XyEhYDNn8H7C1IcMIpS3j/N6aVLflulWXeiBOabxRdSDzWsHO/Ts1a4EKqb9+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251553; c=relaxed/simple;
	bh=gjpwSvjvtw6bzHDTCs061gapvPyzUMzBAAp9zNL2tsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYEw+ojKviAgn5SiDCLCWa7eKAOTiAKz+AcSY9Cu5+Z5GRy08wpd/x1gWWzkHnLj1/wWmJ3t31UlzzfXG8/hpBJPrIHzAGKFvsff8Q9Ism5oF8qQ/YIadw2k3Coi7Zwz4W8QX5RyMu4YN1m5JMMUod73PoUjWI4qRQ+cAHUexug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=rbITTOos; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebtNhHRqZGFP18vKIaBOscx4mPn7ZmYs5Hw1/5EhJsUk6cJXUpCVDkfmp5cvZDYJtwLJ436bV8bZCVxdD1YFNKrbM3kj8vdGPYhsCkGrRHWg3RqYH/pefK/6QUqkuMYJzK95maJq4uS79b98yi41XJtwz7H7y0azgBJmj6fEprUrI1woLx/dkEcdSoEOjElb6pbRMRsGoczAxdmxOMhQSDvFCRPxUxEwx+2ZapcC/iJsei4KuKNyqO+dV9dFsGTEcnvbPYgD0SNXlDWaeAuvhK5CBSA2txgO1z+gbEGGeoWxbIoyEz/3BR+VXNVdDdl483TinFeUW9WbS5bV5xe/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtfzJOIwjioP6WuuoY0RZGkicn+G85Be3w4ub/T3KTg=;
 b=cG99Wdl5KxTVuQ41LaKOm0SBwyVoOeB8K7U5dR3SM9udTCEwDtqJuNg4NFzepl3AK7sqv73Wl/L543Ep5nWW21e6Qir6ku4Q8tnq1spsGoWlADWd3gI+OtlFxgBniD8RIUfLX+5qifAJiSkBtQipF4+pY/pmc2ra6fCzXp6u/6f9Wd0iE4x2r9M8p9Iwgp9qE2dgnnjrmqxO2sTqaAyY7mIA5O71nkeYVsTmV42L0hGadXuYYMr2gM26MNR/YYu/sRV6vvXu72sL25g37gDk6/1G+lGpa5ijr/hPAfsPGFVDb+O1AWvsnoGoLDVN+I0OULb+h/znfHqi1o6iNIeOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtfzJOIwjioP6WuuoY0RZGkicn+G85Be3w4ub/T3KTg=;
 b=rbITTOosghylXwbhlM1EK83Br7Zb9BcUWh8JNPk3FfpPJF5kfJJ7oYmWrSMKCZYKiQlUenyqHleJqaUHADOjoPI6CqMP9isCtE+/n9lqFDzxuPpmBcO6PEFy50ZP46EcxHrCidzGxFLsdoCiwGGBTIdlcg8g19AJjqde/YjbsPUZZsaDNJpq8QylcJiSR9+hGXcmtHLBHZOycJz5whMUE79XJ/1rWCFvbYAplF2uMDOKGNh9NJw6jxMfc5UcjFqE6G5XwP76i62vbYtWhsnSLZMXWC22WmsXNB2UKZ69xb6129vPJNXjhrJCkJz4UEPVWycSjAEn1ZDktkIWq/hdjQ==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by MN6PR03MB7622.namprd03.prod.outlook.com (2603:10b6:208:4fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 02:19:09 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 02:19:09 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Gerlach,
 Matthew" <matthew.gerlach@altera.com>, "Ang, Tien Sung"
	<tien.sung.ang@altera.com>, "Tham, Mun Yew" <mun.yew.tham@altera.com>, "G
 Thomas, Rohan" <rohan.g.thomas@altera.com>
Subject: RE: [PATCH net-next v3 2/2] net: stmmac: dwxgmac2: Add support for
 HW-accelerated VLAN stripping
Thread-Topic: [PATCH net-next v3 2/2] net: stmmac: dwxgmac2: Add support for
 HW-accelerated VLAN stripping
Thread-Index: AQHbqF58Bphr398kgkyddiIUmDLZn7OaIpwAgAB6UlCAAKF2gIAA49Ig
Date: Thu, 10 Apr 2025 02:19:09 +0000
Message-ID:
 <BN8PR03MB5073C08D52A17F9DAC37ADD9B4B72@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250408081354.25881-1-boon.khai.ng@altera.com>
 <20250408081354.25881-3-boon.khai.ng@altera.com>
 <c65bfe99-a6e1-4485-90ee-aee0b8e0984d@lunn.ch>
 <BN8PR03MB5073B710F5040EAC06595AE2B4B42@BN8PR03MB5073.namprd03.prod.outlook.com>
 <3eb3bb21-eee9-44b6-b680-4c629df29d34@lunn.ch>
In-Reply-To: <3eb3bb21-eee9-44b6-b680-4c629df29d34@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|MN6PR03MB7622:EE_
x-ms-office365-filtering-correlation-id: 7fa93960-c013-4723-5a43-08dd77d613c3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Khy/52v4J1jWzGuFsbqkUD+I+2jErsWNLk752M85vr8FGVRj9h7cnVTO61/7?=
 =?us-ascii?Q?c6OjkHoN7aTP4cW1Ox6pofYw0gHA1GFQvYMMGnM7EsPkJ82817Eot+kR8Ii/?=
 =?us-ascii?Q?wH8cGAlPM506RhThhzxABsPP3hAtJZ6c5GYGmjizO96WAoa8SFc0FM1UdB43?=
 =?us-ascii?Q?8rLifLt/CoPfHhEcfuiONthEyyq6qFpKUxyb1bD5YKa4pwtXMPS9/QC+uSpj?=
 =?us-ascii?Q?KmWIc9IxSQPOgSfAWgOIaTCNodTXInFayLebrb/D+SAFXqkJqfLusfTyn6NL?=
 =?us-ascii?Q?wZ+K1UPpMuLm8/lc+KfCnWsqVQgFV0ZcwFKVoOpy4URjbhyCQg4GBPc27WFi?=
 =?us-ascii?Q?XycoK1y1z+AfFlyfLpk6Qvj7dSDxEeQgKu+8Hyeiv2RsvG3eyInj6dFPVlGQ?=
 =?us-ascii?Q?gcRPHCwrJiiR4uOntnhZ19zLXtU/bgkEy6eaHAfR0IB3pPaKBm6/qjAUQhFB?=
 =?us-ascii?Q?yYn4Sr0vkSY+K7GixVkLsXXe0vv+K1E2lQ1ET6a/HCCn+GjQ2TQExK00W1sU?=
 =?us-ascii?Q?5LaQLZfuQ9CAAEQ4JNEFcx6Zt8ppZc/Ff9cCIK+o5TMAEeVwBVK1+ZtGMmlj?=
 =?us-ascii?Q?6vARo6EORl/TacJ0CMPDxp4p+vVWBj8A/CKTLhOWBRYHNAt44WkkATMpaTb+?=
 =?us-ascii?Q?xvSaatd35y5LgIKPx2m6OCVKiNIUL9/IzTL7SFOD7Wo5a7ofzTMVk8bj9oQi?=
 =?us-ascii?Q?Fcgd4bgintVXRrSHj1cjf8UZH1SvlXWiRJkGVFJGA331A0fPkNWk5upX91xr?=
 =?us-ascii?Q?gR86+iHBlvj5Wp0DINsNfi3CHXMbZdrcO3cCfGDJW+hbZ0RrN7QYg+sf/F7k?=
 =?us-ascii?Q?soHf9nkAQe8fF3DDCnQuuC9zGACZUX2O2t2fyknsWOK3Xx+VgIokwl0L9+Vl?=
 =?us-ascii?Q?6m63X1qc61ZfIAJ/eKG2Fx4lYPMy4oshgUPKY38JpK378plYIIQoJyJSOCE4?=
 =?us-ascii?Q?AXLIqMl/0+BijjU6gWwOkA9ybwsCLtkvOMAaGDT14EYsp9iP2eEXGK+yRkUn?=
 =?us-ascii?Q?AXFu8kwyEouz7vK9vpGOnSAPaHOQUFIFL7A1XbPzbs+jQJR7/Bb/KsV41AoO?=
 =?us-ascii?Q?LlHKBjzsE7773TWnLSdoVa0/ucoDP2BREHBR7C63aNCgKqQC6q8rzuCwONk0?=
 =?us-ascii?Q?aE/s04Fby4ydbHSPtsFqkxgVV5pSNcQ/bqWOohzBWKRPOgB7SFGlGLSjx6KD?=
 =?us-ascii?Q?Ibl6Q0D5Mb6wZkUIUi+3GHXKGDTqPmX1tuPNb5DG9ue2dIekmcuMZrcnbOds?=
 =?us-ascii?Q?qW7Ms99p4aoFgJFSTmqKSz1pBFDozbc1WUJoQXq3qaoE5cizWJKonusKoCL3?=
 =?us-ascii?Q?433Mw/H8Y8y9zAxWVkwQ6AMJV3n6KisDqafRLDvHSIlTAiegzb0y9RfA3VDg?=
 =?us-ascii?Q?rqASaGUkCz56IPVv9ezThIWsAesV1XNlWZ6zTw0/Ig7UDDurnh23J/rWginA?=
 =?us-ascii?Q?jkDXyU6lRyI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0gch7hk7nRJtRFSxF3WmJYhvVK3o8hkr4JcAFlph+uOnAa4zT5dlp30nQgpS?=
 =?us-ascii?Q?dEZ2Z2wbMKO+ehObHvyacEpDQNGlqjhUbfzFHRD5a2RreoISQG3XIZtAVp+o?=
 =?us-ascii?Q?yqnQpBNaR2+aHJVZzdLKOBfCAK4l7fJklN3yRPxlicG3EqhVjRA8aGNtlkNT?=
 =?us-ascii?Q?bhmSpnywyYI4vyhjRjnA1uSmjqpRVwa6qOww7FEsiWRXot048uzUY0jrxRBr?=
 =?us-ascii?Q?S3855eDlvlzcTvTi9Be2EXNmHE2UvdsvHRpn70xrtAWEBg7uQpY1tIAaPEiG?=
 =?us-ascii?Q?Ny3I1ogvHX6ewSAU5cUghPQ5C0GMB9cdiu9gPAJ3nlncZfE7wBIuNvhg6+dw?=
 =?us-ascii?Q?LGGR4BeIQifOM4e9iVGhYqGA2zamhTq3SX4c6M/WeY0YZJLsbVYb0djQTQ1j?=
 =?us-ascii?Q?hK+81YbgHr12wkpbdE/TBf/qqJrUwuwYNhpgT/0/TTWSReTuicEuDzBZqhrk?=
 =?us-ascii?Q?oiX/4C9tiEUc3RAnou6Ujls1/cze3XeBo7ICsNnBL+u9jKXZMJ/VTyW/dtSv?=
 =?us-ascii?Q?2KH+vwxwVXudv0V7rs2gvRT/OwOsChBBf72hUMVwChQeeYRezdA8PPxc/jb5?=
 =?us-ascii?Q?hnqj4ugHoMtEnc81ctIs0nNTKuy3v5UCk6W0jQAKR4ZYEh9mSmkbLRaTN+cL?=
 =?us-ascii?Q?wpKNwk5zTivV9q9UBdgPa0GGZK5luXFYcdgKIw9dYm76wZsfGZ2CmaGG3qyn?=
 =?us-ascii?Q?vsxPPdi5pdT0VRAbp+YFZf5IbaGPX3ws3vc/6ZI2ldNGGT6uAkc/l0z5uN8A?=
 =?us-ascii?Q?kWn7FG4ODgr3ezjars2r3cbC3wBa23zAOXxXSoUZE0CkrzkRwgtkX2A98FMC?=
 =?us-ascii?Q?L5Ii50HSv4pPwPLDz7Fn41kmWW3Fu3im1IMAr1J6aVIC7DhM+rTAww/pttQn?=
 =?us-ascii?Q?NWv83cPvXsHX7KCGgaORNB1VZwtvU+XsUtLDaLDlFLgqhW+wAej/H8veVuj6?=
 =?us-ascii?Q?t85sru/s3TwN4Nz1a599xKVIXPva/47CJVESCY+jArsSxmxe7psKNT9ZLP7W?=
 =?us-ascii?Q?HJVAznaS4c0/dSOnTwUNli28IzVOjem4TySozWtN2Y3DySfBecoBaEEhZ3vv?=
 =?us-ascii?Q?ANOlyBtyeZZHYK/B7AnLAfut0WwBz/FJk4JxrMR1NAk1hwnwYpBg3BUnNUal?=
 =?us-ascii?Q?EbyKEIHYjFpNeOjrbJVK5mnEUzOp5kjlbrvbnYrPAI9fZelNgaWr8Ee1xZMw?=
 =?us-ascii?Q?60wMem5fKlBXtUE/j9+DJxWbxw5mDs0hkZ84U/z97i7l9eQrwPRaH+pIAwtw?=
 =?us-ascii?Q?EVXKozp0LsJTwJYJQ5H2qU7wgr9hqhrStxs9s1x6VwanY8rD21g/u71P6Pq3?=
 =?us-ascii?Q?Oa62CkwCKNKJ0UlFy44+EZJutSOvRJq0cozvIYUiGDrbYM9XXQKtPPUaUsmH?=
 =?us-ascii?Q?4YCem4G8WpEZdoxFVGQSJ7LAWV4/GdFATABfjy0VKkVlX6m77EVig/1ZG1Ih?=
 =?us-ascii?Q?HevUd2g+JkDj2K/xlsbdKlNZ9u0tKdoK66Hoay/ZH2RTv3gPDDJd7W3NLbBa?=
 =?us-ascii?Q?T95FY/H8iWc5j3o9x2TFxFoc8+X3DgbaJywnUF8He4zOCWeiezBZVpkALlWC?=
 =?us-ascii?Q?HDyJpETFeD+SdeXAfem7Kwf5ce3eMyGvYpvVrn7JBcBawzrA6ULdScM2EEhT?=
 =?us-ascii?Q?lz5k0bJ9nRvQTpt+DHmr3SZofwwsnK5wNRsO4wFyxgUI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa93960-c013-4723-5a43-08dd77d613c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 02:19:09.4664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozrwQZ+IxBcQCn0CLh2p+fHW1c8QcEw4IF9+kV3/zjybBfi318QstG53WDTfhoOgZLOmhv8AOxtfH+GaijJ/aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7622

> >
> > While the logic for handling Tunneled Frame and Non-Tunneled Frame is
> > not yet implemented in the
> > dwxgmac2_wrback_get_rx_vlan_tci() function, I believe it is prudent to
> > maintain separate functions within their respective descriptor driver
> > files, (dwxgmac2_descs.c and dwmac4_descs.c)
>=20
> Please add a comment, or describe this in the commit message.
>=20
>         Andrew

Hi Adrew,=20

Thank you for your feedback, sure, I will include the description in the
commit message on v4.

Regarding the overall changes, I believe they effectively consolidated
while maintaining the necessary separation for descriptor function.

Please let me know if there are any additional areas you would like me
to address or further suggestion of improvement.

Thanks you for your guidance and support.

Regards,=20
Boon Khai

