Return-Path: <bpf+bounces-56225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE60A9336A
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 09:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926A3465530
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 07:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D664B2686B3;
	Fri, 18 Apr 2025 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ptm3xTbY"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F835280;
	Fri, 18 Apr 2025 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744961195; cv=fail; b=GEX0sUf6Htvgf0N/LmwnDr4FbxYBuRmdSvGlaFc25MzJlzUXP0ERZhVGHut7dVMgju+nEqqrLaY2PyavC8kfuGiC2NlfhOroe+FR+U9XtwNlMtpZetEplthQowFKx+NTo7zHcg+PEaTmtKRoFhWJu9N/3QIfsFWzmSUPdWQrL6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744961195; c=relaxed/simple;
	bh=BUwS+jv6+jsKFcZKKKfxl7RPNA2+MKCpmVt3//kc3Bo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DNyLuYC5NTy/rpIGp2p26q/o1aaqoIIEj71OyKkZ+yQ5No5pDjnQzdvznNMAslk7DKIW5nApxv0cqT+hSX69/5Bl0z30lrdpiQMoXnBmrema9lHG4p7KzQCez83EgKhxiFAB9h5i6E/NEHIhuJNoCwTdVgu1RlfJI2bBr78LzUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ptm3xTbY; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOl8Kbj8qLMP735Y7X8vg8Zxo8JxJQZm4i4rbBB8Y5c9rf0oeYUBtMtY/13u/UzueGS5wOcZk7Cy/2XRPJ4Ec+pTEuXdjWVOaK6JJk8SUI0fVWusm/m5c7d8RarX9KH/o9e/5D+a6wzni9VRn88P3lLVhej6gCD+oRNLBq6vMFQjtBBVPCE+R638paVQ3+JjmySfpQ9TT3wBdBkiUzqSi3PSsr671Mf0bLYcJQZ8nr1z3WozAKNQKCBpCouc0bgT7f8WYRjI6GwSg3hydxzm58lGaWYqI7p43G5ajM1MY3u9xr652i9Y2+Nlwu1pxqddgpnP+THu6FGRZ70UGiAcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihTzWP8F+YcjX74TauX4ZWq3/lVt9Yf4Hi5+dXtv0lU=;
 b=XaQgM6CjirvOOtiJ0vxK0hemD5mVSMKSvRXB7ggQ4gEOuI5iRMD+PtI5Mu5hYklLq373NpUcmZlKxATEjXML5ZYk+Iy2SekGgWrk9vlg0xCUqvOcbAf9NmVPSwhvo+mA9bWFIkEgHdIDTI397Afdw675h5Kzg9hsTO+YsVHryPo28XU92VqLBqecWmJRCc0nZiqhi3/rwmKzUKP8/MPiiZnlCWDAxuoebFcx5LASh9jv52S3MeTtOdLNuKDlx2f8PYcYybSGfkDUiUIM2hOh2PjVGPOe9iq2PcrSKicOzLor/FxV7KRxLz8aYdwFLjifDzLNhQFWrJBWF9en57Ynqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihTzWP8F+YcjX74TauX4ZWq3/lVt9Yf4Hi5+dXtv0lU=;
 b=Ptm3xTbYTMp4xti1K71Ag4gMaIIYizxzBhgkmC9V0xXFHvRPh81AyxeyEFHkHIhTeWGRhMmpX69/Cj4iNIBkTJehLIazjg5UKeAxlBZgR1voYIcAMP2YGcWzu4OAwV8FyFHkV/BRJ17gJPQgaYEBSYDd+r40K2O/IbAezD2vTCFcxzeqaR0m01PzdA1s7U4xWw76GJmIze8VsZhFfxm4sb0MvfvnQhV5lWMWlaR6RNgBk0u8oXtbFeDt/Ga5onzjNBx5yOEIXZmGtmr7LxSnokJ51XtjNYoV92JDaKXB87RkBiTqKxookg+1bIbtkCFrb7LRdRccd0hU4hAz0kAZjA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7853.eurprd04.prod.outlook.com (2603:10a6:102:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 07:26:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 07:26:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Vlatko Markovikj <vlatko.markovikj@etas.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net 1/3] net: enetc: register XDP RX queues with frag_size
Thread-Topic: [PATCH net 1/3] net: enetc: register XDP RX queues with
 frag_size
Thread-Index: AQHbr5BVYUCo9x51mEajxafZZLb5V7OpBRVQ
Date: Fri, 18 Apr 2025 07:26:29 +0000
Message-ID:
 <PAXPR04MB8510579F89CB31A054FDFB9188BF2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250417120005.3288549-1-vladimir.oltean@nxp.com>
 <20250417120005.3288549-2-vladimir.oltean@nxp.com>
In-Reply-To: <20250417120005.3288549-2-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7853:EE_
x-ms-office365-filtering-correlation-id: 15abea8a-8a84-40b8-f951-08dd7e4a55fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zd3we5yD0sG4GPqywWHcgFfrA1CjmIXD1Qd0Fe2DDRePTOSKKjZNhFYg5OZM?=
 =?us-ascii?Q?gsRCfxflugk3ZvxtcqduTPmJOxivTQHCvChOxb8zk9L6JoaowvCNGIwKE9AN?=
 =?us-ascii?Q?sq5d1aBPm1JR0FxriSwJuzpR+OnYSx6oNvLdNU+SXBlkEVCOmeLs2xEv215h?=
 =?us-ascii?Q?3Lzskjf11jR705XLKS6bZZ8unARBg7HFexZemQ6XaGinBszz23XRXvbqha15?=
 =?us-ascii?Q?Cyf95f7ocPxqn+6jrzkfHJ+cV4UcRy1U/YsEn/8b6WgB7F5VzglIZ2BH5xBY?=
 =?us-ascii?Q?yXh16ErlQ25DUvFN9OlwTizCnYzHOb+kZPwD5TX0O381MYImlt//A4XW9N91?=
 =?us-ascii?Q?TsEV8MeNnYW+re3/5SVvP3/a4rT+xxHfOH1CeLNJyXVAZu3lj3HrFHYvMA/Z?=
 =?us-ascii?Q?AnxIobv/+7d7s1l1vDbrezg0vJiDQE8DpCqGzqW9hFYVr58dlH+oU2PLAHJI?=
 =?us-ascii?Q?Rpl0JLfWsvCJ8tkXKfGfvwuo6cTxOxPX8KRTK7rH3/i8IMnAZfXNqdYMGXL+?=
 =?us-ascii?Q?+tyg2NmJRQ8VnIQBAlk91IV1kf+XSd34IgjDU3xtrD+G+7FmxkCKoqsANMAN?=
 =?us-ascii?Q?yCXFtHMeIwXStKLZBgCltcErlRy3/H+REsOww2ctflR1SRS54Svz8s2T8ly9?=
 =?us-ascii?Q?69DG/YtqMpKeWMp8d5W3rVQS8cmHdmom1g2+xBRqHnLVvn5MRScFxQ3U1qrb?=
 =?us-ascii?Q?3fhswxP8PH3OrKYYEHIdehJynyVLgck/Kd+8Pp4exI3aMoNyL3b28PMvXvnz?=
 =?us-ascii?Q?EJCdUy2BjaQ/+3g7eP8/mI1aO5kWQGqWO5vDNo8Ufw4AGN72735PG92+0nyR?=
 =?us-ascii?Q?0aRNyLWlEbdwoHIIUjjdVVCibRw00XsNYRpDyV7hnc4g+3fiOGqBfqE7usTP?=
 =?us-ascii?Q?RVQordOrqcFHs5+f12o/gkqmji3b4D00hknv2q7CZXKQlLCCX3Y+p5WSvALU?=
 =?us-ascii?Q?XOBgd/ek+SrCzzyBvuCF4tLd7fmfMYyRMUywXexkDyBgAzBSvR4Ybf49MW1m?=
 =?us-ascii?Q?OHZV6Ho5LgQl2kDMJ7KC3wrwkcLBMjbs3uYPheeN+qi1Rhj8eSFZvXtXb/Z7?=
 =?us-ascii?Q?c7Mv4RUEbkV7/7ZLqt7ndVprmsJQqsHpi1MWlD/B+3ixKwIFkiDQ6j1Jf3c7?=
 =?us-ascii?Q?ohtX7KEcDCKitiWu/0gcPu5RowgYygefErikxluuD1DqOrgj1EKrVIiKYJDM?=
 =?us-ascii?Q?asH1VUpTqS0J67WpMVqTI2LfeUQ3J4ri+hT7p+VThm0PX3Q3EXuBTDXG/OPB?=
 =?us-ascii?Q?52VwhVBVPP+BQI2zp3NLgpLY/UrBCYZajm5oGgrrF1W7u9ivoopk2aOmbriU?=
 =?us-ascii?Q?bOi+sTZiLBYk7bxSuJ4PidBNa30QtKy6orGFisght76fGEAnCWx5L5+YBHOo?=
 =?us-ascii?Q?OrF3iwEWr4l2FTrv8EaUrT8IpY3S59MxZZFnKKdEgPGaQRePo9v/9gksdoKw?=
 =?us-ascii?Q?WHir628j1tt0bhQ0y00rir6i51/oRRUaxVlr8WynPTP7JsIyKc1Oc29LLByo?=
 =?us-ascii?Q?jdP1VAKADc2TC44=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y6b3YxlBLuAzrjGNboJa5+qbvEGux9fdU+V1/PMrH9F+QmjLtyel+FDkY9ka?=
 =?us-ascii?Q?EWPqw0pSXlhBvc2CEy/WO6f/LOLu0mxM7dFAwTWYg+JfEK6wIaff4eQ7Ayq+?=
 =?us-ascii?Q?NheJoA8YBuUm0LHA/EQqWnlZkV1g/6/f8eN4D4W+xuH95lVhkEP0F5E4Gecg?=
 =?us-ascii?Q?8EWZqT2LKiUej27/bgtzarbTj9js6YvZdHAaVTZ8/fSvPWYl5m7QoKO0BpA0?=
 =?us-ascii?Q?qpUMedUlVwu7zVKDbU+EofoKm7yuNQeQ30lhW59nUNWYeMD07c9BH/NudP4k?=
 =?us-ascii?Q?UlEc28CEJM75/AKkjMjdk0Bo2FBGUf1ZJ275HKqLuj2jQt1SZbj3XZCtPLQr?=
 =?us-ascii?Q?FHQh4NfuguqojAAnoQEsvWFgjwcu+vpSPrh9U95eGzmHpxL4pPAoK7FBWQrI?=
 =?us-ascii?Q?Gb++kTeSFwlr/0nWRx60PbnPTAO6jwN5nXPFmNIYvnNeb4/5jC/2fPx6KpzG?=
 =?us-ascii?Q?kiDCU+IOMtS85a740Ktctlhvnc0mdGaGvIvgZay5PFZSO5/CAz8BaptIlYjr?=
 =?us-ascii?Q?nA1+kQzAvtH9AqL3eqHhE6CDWrfAzobrOcTxp1Z3smuab8xQqgdaXgP/XaFA?=
 =?us-ascii?Q?7L9Tmpcg1aNYa3IrxlUn7xKp/cjiwAKqHcub8uiNVPmXeBQD453VmLNxpUBI?=
 =?us-ascii?Q?fzhGaiOJ3lozGQjkHguagEkTI98Nd1a6+regEipINK1HpqoXaivYTTWySChb?=
 =?us-ascii?Q?zqfFYwfOYVcmArGddA28c5hPwfovrquf0a67knpK9QcS9cxST8kg5/XcLS0q?=
 =?us-ascii?Q?399llN9dOa3o3DNvOssMT8SzyfAhZFSp3mGnELO2OCwEs8BkwFgd9o+UPvv8?=
 =?us-ascii?Q?3zRfGXqT3njlEY0fNF0c1aIPR55Oh0ZEoRCrCmgbEHvRjUIkiqXtyiHWsGPR?=
 =?us-ascii?Q?7+4XYZys9PfC0wfDZyu+tXFVkcIemf5MD+cU8B6Jh6lmOMr9EuUrosbaiHBJ?=
 =?us-ascii?Q?ogvaop1Kb1gcN6i7hO7oj+19cGwLleofy5qhl7/YU0subcVxCzCHz27caBiF?=
 =?us-ascii?Q?KvxjKgEVJB2HMJXDieatx/mWXkquvDy5lnHj5S3NLlASO/eFKGGzmZ0/rgu7?=
 =?us-ascii?Q?pg2OT+oUK2nAlfd/sAykL6fz1m6qxsv/niD5r2IjRFaDMuyX2+ossMw8bUhT?=
 =?us-ascii?Q?FQKZVJwKIlNIyc0gEaPIZH8cbJ/Y4jgqfIdB3jITdWG5rdJxkaZeh5Mm+sYd?=
 =?us-ascii?Q?hhByJyvLb0/7uk8W31d5WiM/5E9xh5CLmnaGNMSHzQLcCpWO/55/OkNTS+oM?=
 =?us-ascii?Q?SkyD/zGpJDBDm50xCf1nsIfqud8XAmubE74BTHIHXEuDDJxc5yLMMzPUExVE?=
 =?us-ascii?Q?dE2zQR5FO2LuYLHg4R+8/HmCllPIHL6P1MTJ4+YWOuBv4lBpVzNF0gieX7GN?=
 =?us-ascii?Q?M1kdxdvpNdbCqo7EdTB0iF6N17ijOuh9nPM/ae/WIOiOvCVLSdwh0OCBu8RX?=
 =?us-ascii?Q?mzRYNKYCS/fZEkT97TnO/K9gn1tulhvK+iByAjobE2U0JF0u+0feVcBLeldM?=
 =?us-ascii?Q?fYuyo2Dsv8YmaWH4QC85ZfwT8duBJFgJMK79Xcjxn+pXdDUc1XjBjZWEa3dU?=
 =?us-ascii?Q?Be7srKAMnu0nfm/V3zQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15abea8a-8a84-40b8-f951-08dd7e4a55fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 07:26:29.1589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0zw0aHURBcVaxbbRDs9WYack+UBX5IgKLC9vXLKkfL5fSDAZRWbfrMxhUOXiDsszaB6hIsJSzJRtZ6wfAZilQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7853

> At the time when bpf_xdp_adjust_tail() gained support for non-linear
> buffers, ENETC was already generating this kind of geometry on RX, due
> to its use of 2K half page buffers. Frames larger than 1472 bytes
> (without FCS) are stored as multi-buffer, presenting a need for multi
> buffer support to work properly even in standard MTU circumstances.
>=20
> Allow bpf_xdp_frags_increase_tail() to know the allocation size of paged
> data, so it can safely permit growing the tailroom of the buffer from
> XDP programs.
>=20
> Fixes: bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_tail()=
 API")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 2106861463e4..9b333254c73e 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -3362,7 +3362,8 @@ static int enetc_int_vector_init(struct enetc_ndev_=
priv
> *priv, int i,
>  	bdr->buffer_offset =3D ENETC_RXB_PAD;
>  	priv->rx_ring[i] =3D bdr;
>=20
> -	err =3D xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
> +	err =3D __xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0,
> +				 ENETC_RXB_DMA_SIZE_XDP);
>  	if (err)
>  		goto free_vector;
>=20
> --
> 2.34.1

Thanks for this fix.

Reviewed-by: Wei Fang <wei.fang@nxp.com>


