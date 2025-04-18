Return-Path: <bpf+bounces-56226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59568A933A4
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 09:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F781B60017
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 07:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C139726A0E0;
	Fri, 18 Apr 2025 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LWcFb1/d"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2B820FAB1;
	Fri, 18 Apr 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962251; cv=fail; b=Dy50ghyRUYc9Pf+2cGNuTeS/c/o3Xu31M4rQt7bWR/39aAziZlMl+CLJyvur+Mo2lzyj6Z5Ka9QhOanvqO3uRBKlA9zYswLW8ESToHrPG/EA/yqLw0Qzh4aX50eYFJ8UruRAQ0o6SHTUGY2LkoUP1sGQMtb1CjdN0+7XyAF0I3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962251; c=relaxed/simple;
	bh=OsZ7G4J8ePjBAWoghkgZPkUONGqIRq1hhHMWTeIWWT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lR/bIt3MXqwAxJ4vkFFhW9PSEmGsf+Fkwi0Kibe7/oSw/e0ijgI9BT+qp2+GIt9s8RX465Ou+J3qAtB1DtZnB+wjDq79vIYBCYEGNh//imxKocDD/RyCQKU26cB/6FOkW/S6y3Dl1+NbDK2gDg085zu4H9WrljadFjit2uL3JMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LWcFb1/d; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwurhV/YkMYYlGEuXqWFjFdNn0r2JRNFQ7MnGZU+w5jyT2Y/aPwb/nyo37+sElUffuf1si3vNXYYhyCx+m+Oo4A3Z6f/HGmB2i9UZ6YJh3GP30iDqCsXdpXzO4ESWxWbbJ1Wvdlu7scBBnGg7mazpXf4XAmFuAYGum1UVluWRSpOUbYd6Pem5z4vDpbS6r1rrC1JuOQA7cAX2lmU3bH1WO8StB47iOGPGy1i05U8ChLdSvYl6f88WQA+L6fLBl9hTIc6VlhjFvbloCsaM2hrEum6QRT/2xpYakmyNySQjul1n3F8aGaS8T65OAWjHRK/PuFJ4/rX2V3Vos2H/hPXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hi9o27P1iFNNHU5NoeIXFv/+c6nz5uRdcA/uu00yOTg=;
 b=vPJrWqyGWj6RymdDXkFvrU8RlxocaCjVePDm9kpJ93ozKQQzOVyphpyhfBB6i3jEJUZPcl6oEaMI3ptNK6UzyJDWxuMsWCJHV58l9netB+BjZHQCbAMfSrrw+z6Fwj/j7YBQHlPzxwIxHcjlKBGAFnl7r9ZMgqji65iLe24JFwE5p3e2czk3Yl4qAab0WnZ6HQIbXfpkVfYEfWQZsSEUFrw5cviBjaUe6KxluMdMNDlTbPRdDvKihe1ISCV6L3gJruYV/iJ/q3TD4OJVZP5G0+iBJCUfECkntT3gFJPw52BCgWrV8O5qV7H5npIsumqqybFNWpyABvArNcw/MmR0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi9o27P1iFNNHU5NoeIXFv/+c6nz5uRdcA/uu00yOTg=;
 b=LWcFb1/d6DLaSFCbqwt3pOhJv+aI1JPMZJUI2D1ydjl0ANro4IJKnBOk97TJNqGFc0uywRpWFxIyNXbX74PNULEUPLjZOq4hrxmYR6WBzgx5bBUJw20G1X/k7l0wC/HS3BTQHDs7qdCATYhpFu1vJvhjqrFOQ+c7IzinnZZYA2ZieRqk0CJ1/q9D0bOLY42uqo9ozESu5Hr2Tbhf0WOOl73DzOGkqg4zOv30zDUS92D+Y77UK8HT7kXw6LmQeVIgG2BnMVmquL+REiC3mCAJJjtcEPp9nD5fyQ6fG7pJrksMGy5YOeXSN+x7BgbPq4b4lKMlZOxBUsrXFA+5zCnlAw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7558.eurprd04.prod.outlook.com (2603:10a6:20b:23c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Fri, 18 Apr
 2025 07:44:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 07:44:06 +0000
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
Subject: RE: [PATCH net 2/3] net: enetc: refactor bulk flipping of RX buffers
 to separate function
Thread-Topic: [PATCH net 2/3] net: enetc: refactor bulk flipping of RX buffers
 to separate function
Thread-Index: AQHbr5BYx5jxLafhXEiFtCloQu2KLbOpDB2Q
Date: Fri, 18 Apr 2025 07:44:06 +0000
Message-ID:
 <PAXPR04MB851079583B566E942D4206EB88BF2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250417120005.3288549-1-vladimir.oltean@nxp.com>
 <20250417120005.3288549-3-vladimir.oltean@nxp.com>
In-Reply-To: <20250417120005.3288549-3-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB7558:EE_
x-ms-office365-filtering-correlation-id: 48af127d-7863-4540-1bfb-08dd7e4ccc58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7uf2p0VbgrlkgZ3rXVWZm1A3vI5+EtiSIGlLZtSZNEl2Ac6IJ+FLqexFIBHQ?=
 =?us-ascii?Q?Iu/P8OcMg9p3XzhR2OS2thDjqgJjhs2rzxX93xQyBzPT+odEOOTY6Zcwbprh?=
 =?us-ascii?Q?mEQo/enUBY7sU77VMsobIxJsDds5g4QPRVLuWVUYeh9Nsq/Ywh5gIHFZRL8F?=
 =?us-ascii?Q?t8A497bRJRmXq3pB21dIwPctKjQ2/3TAupl2Z42Lsx2KmWCnIuu+J/tuVUtQ?=
 =?us-ascii?Q?aJHFnX7ky3TZrMVHpSbUPri2IbYTyhGLSHiw5bwABGijlxzYG/TuoM2wFZlo?=
 =?us-ascii?Q?/p28JFGq+o9XtlYWGyLzzh6fMzKlq8j4mKsj7oZwuijjs7rsVzO4rrkCI0Px?=
 =?us-ascii?Q?fxyQwlw6jEvMtf+Xfp2VXUTZmet3yPO+PvMtkgZZifV1ivWCT1lxzaj1Xvpl?=
 =?us-ascii?Q?WIBtyjj9RcGMOHP+ckE0hkIOfxggFyKKk4KuzK9/JV3QmRegXxzk328ayvch?=
 =?us-ascii?Q?cIwEgqSQWzLrU4iJE/mgWN3VOpJtlMzpjKkLr4dK2YYNtv6Eo6VaMqTi7/mL?=
 =?us-ascii?Q?VPEX9Ai2Rfdz5/ZslcA1Xrlq5ueQrZTcKAtNp0APArkecns05gKZb4nbz070?=
 =?us-ascii?Q?YOGzabztKm2acCaETAxeE5xcNyyuv2DGN39e7h5gQK2UAkLCYpfcD2GyQP8O?=
 =?us-ascii?Q?bFxPX2HIW1mlJEXspOCo49GyXa3NyFcaUxORITMQ+DZdkPNcO6e5asLyslAE?=
 =?us-ascii?Q?kC40r5u4p7vOewMUVhvPU5xhju55/LXNlCSsyZwvCAbvLM2ei5DKkcZEPvOC?=
 =?us-ascii?Q?KlUvwhzd2r9Y9Zfrh6luucGqoKn5cZ+kpHysGg8xw92L8O8k0wQvV7W3HOlw?=
 =?us-ascii?Q?5RPS/zUMwPlUhgI0bU/idV3C5MWd1+XEuZHktE2n5RgGPAE04sTBxzyxyyj4?=
 =?us-ascii?Q?rALBvXf5s+baQSl+sTWOYUCZwrEQRkfCNT5+AN/GUF+Tn7H8SOt7x3yoKEPw?=
 =?us-ascii?Q?7v1c5WN3y/H+QNNmxPn8cJZgrv+P1Tnkimsbm3mc4URJtfXU0nTC6fWLr7fC?=
 =?us-ascii?Q?9QXheoSTD78udqcKN+Bx3qTTX/+wmp914cPL0yiIc/fCeDN3RGTCFRcFG08c?=
 =?us-ascii?Q?SrM4PKtI2AZhchU5O1uP4dYINbADhrF7y8aiEOff/GObT2+dUCFlG+x922TZ?=
 =?us-ascii?Q?H0RywYLYDO9dS5FY2+L0smxU3iMu+1aBWFvROcMJw0mUAGqDvyNjj3xCtTzv?=
 =?us-ascii?Q?h+3WEUnqYyDn7Nubsqt+8mRTwzTnLukj7J0duAAK1kjgwg02hK5LqqgIH8un?=
 =?us-ascii?Q?UG6VlaQpKmv7ohFnQSvhr9mUULDIBmQ574XnM5Fw1fmQbD5IfWgu0SwT/Nsv?=
 =?us-ascii?Q?AV8mAKPoTwwblrP42cRAg9UetT5r8/rkaO12ihdEfHodMDDHxdxjQfekRlEE?=
 =?us-ascii?Q?CXpCbrc2UqJ/2wKFFaOCUJp/IUh6cxDlPBQXZUYM7k6UrO4DYfjNwwJz62co?=
 =?us-ascii?Q?0qjc6C91rVZS83HdKmKskBiw0uN/RwHOGQiyM4fHwLdUU1RZxE15Fw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RzqbboXdfI1JxtJyFJkkPjclyDbeQPkU2N0Cs2jo1DwMwi1p9baHzuvVjcsc?=
 =?us-ascii?Q?cEKGoWi9D7IFaEk4BTioO4Ey9797LAm9QQ7W62m5UsCom3pqerRfQuTGrNjp?=
 =?us-ascii?Q?kAtGDnrWq0po4V96spuFIoJp/eOXJk+uFb5tBH2ec06qjuq6EpEAa4+4YDbu?=
 =?us-ascii?Q?4q4pHo1b8uMQnuOSDQuz7Si6zGbSmi2eg76d5hZSMI1T8lNibI1iIIA/E0q9?=
 =?us-ascii?Q?yPxs12NR59qDdPHVGjwdtcX0JI6xfShpc/zFg+8wKFFo9EkJEX/s3WSK/Ap+?=
 =?us-ascii?Q?I0Va2rwAlSWxzhY0x3FIMw+hCYgvoco/2iZ/kORFY3mur2X87vMOPS6Jn/jI?=
 =?us-ascii?Q?Eby0liY4EinnEM4AOO8IosZgI+ybyrLa3gTSa4TzrfgN+S0sXFW6S0FkyO2o?=
 =?us-ascii?Q?DQcCxvE9ismrmOGXtstO4OOS4GuWFPR1xGg5Hhow6c9XgRX6hi9DeBhQiydz?=
 =?us-ascii?Q?gTYBFn+8b6ZB6xsST6RDvs+8EE+eFB9vKs58dc2kTM585SW5HrDPkqPQuNzm?=
 =?us-ascii?Q?a6Db+kKRb05gldpQcVEse7vIJYI+oUQ7C2W/OCXDyfpjRRc50SXWpOTDRf/e?=
 =?us-ascii?Q?6GV4nTvklr5rRr1WtK5MR8ksBIcPgzaMPYenCUQqYLEu0bH1lqMOTFvhTI9H?=
 =?us-ascii?Q?F9MLWQC2UeQYvwyd6chO1qB3/0hLVYwAC0rexdDclZZWBBT90Gl//bRxspMt?=
 =?us-ascii?Q?FhbjXWILWnFPd5JPfj/VNidI7Nm9v9XYHx3erOZH75084obNht+1X0rqeUoT?=
 =?us-ascii?Q?kLzXY3TmngqlfAdz8QQriuq4RY4aLxIm0gRmnkBR0gPbUTtHx0F+Mt4IXwR/?=
 =?us-ascii?Q?/z5pknNoh7EY+4qsldNSLXBnjM/UlLZ197p2Tzs0uOO9u6Z7cjRcZSpFXQ5h?=
 =?us-ascii?Q?kO3Mu7RXmnBzhcYNt9iVK2xX4Y1AWIYs5tothp/PQZK6xhX3MXz8+e8+yLhH?=
 =?us-ascii?Q?FfyRhcb5JaAt1sH4JJNvpAYlzuizndux17gRkdUwM2P/3XAReDt/kRayTcR4?=
 =?us-ascii?Q?agaaxSHWihuPY6QTOFfm04NELlItNrJB2uRSiWvFJRhzdMHB1QBHjI0N2A2C?=
 =?us-ascii?Q?2z19KeQYDiJFt9PA7JvZJdTy9c5Ak+V0MaJ5MeYwHB6NZG1x8YQXXBB5UBWS?=
 =?us-ascii?Q?5WkTFMSqyqegnUn97JrwEppiBIq6euTR677AAfQ8Q2MVKl+WvFO7wSOaWeAk?=
 =?us-ascii?Q?nxlQtiklrHemfEjdL/PJHfuTzd6t+/pVDenV9TbXCI/ZqNw4lcAF/OI7ZMrX?=
 =?us-ascii?Q?AhA3ElBhah46okbNblUD9c2NH2ZiCbxo9HUc0z8dIrO+eW0a9H1QVDRwziva?=
 =?us-ascii?Q?DH9FhiFvSVDFPeAbuLeqpZuAfsdclMvwN6c9Lh9P+TF+alkL/+WU+w5GMdfx?=
 =?us-ascii?Q?7/cC0ibfJWyPrNCCiWGkdZ1ZgHM5jhbfClAqYqVgFhgvSDWuL1M8ElVUM1mL?=
 =?us-ascii?Q?QSQ1Vi13t0O52Bmw9pERHOVpNBkYfol0RFNToV45O2D/wY+85P0TBKgFc8KA?=
 =?us-ascii?Q?qFDYym9vhYkbplQ5FT/m1w1w5AwPkjjp9S3iuCj7JUOy/GBvH25yIqn3+WvG?=
 =?us-ascii?Q?8XmeXLXNgs47pEbGMcg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48af127d-7863-4540-1bfb-08dd7e4ccc58
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 07:44:06.6861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wdz7ExuwA5PEb29hPrTob2n2LbrzymFkDxVsyhWVktTdgew+omw+SDZKZ8X9nTvy1DUIwWdMTSTL0vDg84A0+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7558

> This small snippet of code ensures that we do something with the array
> of RX software buffer descriptor elements after passing the skb to the
> stack. In this case, we see if the other half of the page is reusable,
> and if so, we "turn around" the buffers, making them directly usable by
> enetc_refill_rx_ring() without going to enetc_new_page().
>=20
> We will need to perform this kind of buffer flipping from a new code
> path, i.e. from XDP_PASS. Currently, enetc_build_skb() does it there
> buffer by buffer, but in a subsequent change we will stop using
> enetc_build_skb() for XDP_PASS.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 9b333254c73e..74721995cb1f 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1850,6 +1850,16 @@ static void enetc_xdp_drop(struct enetc_bdr *rx_ri=
ng,
> int rx_ring_first,
>  	}
>  }
>=20
> +static void enetc_bulk_flip_buff(struct enetc_bdr *rx_ring, int rx_ring_=
first,
> +				 int rx_ring_last)
> +{
> +	while (rx_ring_first !=3D rx_ring_last) {
> +		enetc_flip_rx_buff(rx_ring,
> +				   &rx_ring->rx_swbd[rx_ring_first]);
> +		enetc_bdr_idx_inc(rx_ring, &rx_ring_first);
> +	}
> +}
> +
>  static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
>  				   struct napi_struct *napi, int work_limit,
>  				   struct bpf_prog *prog)
> @@ -1965,11 +1975,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bd=
r
> *rx_ring,
>  				enetc_xdp_drop(rx_ring, orig_i, i);
>  				rx_ring->stats.xdp_redirect_failures++;
>  			} else {
> -				while (orig_i !=3D i) {
> -					enetc_flip_rx_buff(rx_ring,
> -							   &rx_ring->rx_swbd[orig_i]);
> -					enetc_bdr_idx_inc(rx_ring, &orig_i);
> -				}
> +				enetc_bulk_flip_buff(rx_ring, orig_i, i);
>  				xdp_redirect_frm_cnt++;
>  				rx_ring->stats.xdp_redirect++;
>  			}
> --
> 2.34.1

Reviewed-by: Wei Fang <wei.fang@nxp.com>


