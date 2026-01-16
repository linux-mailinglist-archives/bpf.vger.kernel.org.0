Return-Path: <bpf+bounces-79265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4F4D32CD5
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C06E3143F71
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE87376BEB;
	Fri, 16 Jan 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SmPTt8X6"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787821ABD7;
	Fri, 16 Jan 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574337; cv=fail; b=c7QImqLqfgtmfYHzTNoiqkUFA9V6Gw5k6WgJaIFf7LtEY1KgVmuNpn/yc86xAMgiPBZqfX7bNQQS28q2+2omZ8QlqoxwXvmrvRXRJf426jyn5ahn49oSM4gqIxjrzaRVCdamz42JZJYwPyCOR3j8RHcBkafXqz3Plz6T1NKkEYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574337; c=relaxed/simple;
	bh=Hi2tZN1XHyawR6iVJdGEQI+f2LUTsdVCqv16wwExSCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EPkRGFJTUY4FSvAfeVrjxG/N123wnKN0/9512jOEfhQE5SA8R3CVIZ0+Y5h5FaJWPKnqOC8z/kCCBKRxwrvtEwhYrnBpmIec4xqayPnBUlTAJ/M5FpGJMIqKInaTmGvE/ZQ0YD2bqvxgVYZ3MlQ8K2p1wwp//rE0/wzSF/DW8+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SmPTt8X6; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avQK+UTCW4pR1CJ2+OTK03pnX6yqWT/sQS2b9pcg9tywXWUnFU8HVDP0jYh2HLvMdI8EWJIh2sEX8aZ13pgThDunsYM2nwV98zRr01RiE1jOBA5D51AYCE6I1SDF5aUltmAGJC+xuAUnfjeby8iN0OZ08u82a9VUIfYl4CPqthzI6LxFUoIFU60pH/Gc/JMD/fPgbBIIUcKXa27qyLj3HD8cXNOXH3R1Uv9/tcta65ft8TDxRztZyK8yrcONKdms6l5MjCNeM0baZI8kQsG72TSOEKhOUq9Dni9NHmwHXt/WLGO/5p9cWAGNpoPdtXk7I7rwjpmy+P84G5onRSlY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0Mlp13jXdKcnqN20BOFj/RwJAOEfQ7WSvS477OY24I=;
 b=Ccc0SEA/cC0hvR7SWXLx/jWt5Kz16PW+S7M6x5wea86mhb6Ac+L+WNnZjUTsxF+6hyruGE9LU1nr254euFE/1E/LM0+yNnGBtRzFqZ318gDTCuUKVCFYclmDooYKsPeRrQ0f7iiT4+DLEbdhDzwMeUhoR+qv2uqA3Rh/SIwz9sgqh4WbUPJVa3Mf8HBQQp7p4aCF1bmb7ZtvjUs0Wif4UBtyhRyNYKneCa6V07enFZ88pOQUNPsnfxbNxwdSRILRRLO2kZGfV7Hx5kYNX+RcrU8gjMK2vn1ufXPPfXsbKzGBEua68LJGVToZb4Bs860fq4G9jP9nk/jBweGJYfhF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0Mlp13jXdKcnqN20BOFj/RwJAOEfQ7WSvS477OY24I=;
 b=SmPTt8X63/T4nhiXOll8mrNyRS0JLsq2gsj6CWoPhDL74xGh3xnPCtZ/Y+faIrlFodUcjq+VXS/t0J+6U8ab91/DA2XQNvcO9fbDnXeCY2mcwxrFzpg+c0HHqd1Sz8LAaxNaYzcva7g4ZmlTZ9WJIMpCSzAnp1fTd7uA8gdqKSJDBfrTnCt0klnusB2W9ry2/kOMl8OkCPJyfreXsezW/l5ZadvYew0yySg1zltH0HuktOFiSit/I+vuEHZz3mOV7tNm7CX51vO8puA+gPSTod25KSKom8rx8qucrvc9e+k15aSYq+aU+YxXNsILz3og61ZSfEUOwVn16C9H17ODyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA2PR04MB10506.eurprd04.prod.outlook.com (2603:10a6:102:41e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 14:38:49 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 14:38:49 +0000
Date: Fri, 16 Jan 2026 09:38:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 12/14] net: fec: add
 fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
Message-ID: <aWpNcsoiQX7WESis@lizhi-Precision-Tower-5810>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-13-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074027.1603841-13-wei.fang@nxp.com>
X-ClientProxiedBy: PH7P220CA0119.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::6) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA2PR04MB10506:EE_
X-MS-Office365-Filtering-Correlation-Id: 5839df28-342e-4fdd-d758-08de550cf67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k7BnqBieEwsWEqB3U5eryl1OUIc+k5y8+Zfh//2z72Gv/5brr355/kjL+n8n?=
 =?us-ascii?Q?/6XdnQs/R1UxCqZJa0McJxwU0IoOyjBpgGVwKzevDDMUUKuy+bJlKIYy1sRS?=
 =?us-ascii?Q?nqsD7mk+lxpLyL3JXjsiEKLIrYSar8+tdpAymgGTUhSNL+qyv4j3LoVlIJwE?=
 =?us-ascii?Q?vzZ0AmTZS34TQ+IoGnyFKM+1SAq7zS65jhuvpXEfzUOop5o/fSA/VbnrbwJH?=
 =?us-ascii?Q?FC/jGoCAbfphpec8UgJeD1Kgbu0IwXVW8FRlh+UoovA5Q9gWkCy7T+XQ5PKk?=
 =?us-ascii?Q?lQZfSMgVmsvFmOht/sQYwb5I/3g00x0otiPuQHVkkQRLtNQ7tyCC7v+o09HD?=
 =?us-ascii?Q?e4uMAApARRK1vfQ2UhHablPOxpxbkNGoIyLy2h/howQUtltzsrh7vnEpBelC?=
 =?us-ascii?Q?viMkPNyl7DJ+xq35Pmw+/kE8hIJAGyEzKM53C4YM5f/sMQhpPkcniE+oY0SQ?=
 =?us-ascii?Q?K/QQBQVH9O26LwIB3rjh8Q+OsdtH81pweRsbm4ExwM4Sj29hpIwadt7AMdgm?=
 =?us-ascii?Q?WC7+p0shofs5TzgXMn9EgjXG7irsAFhpBL0uJkE0jdSecvdCVvCW2/58wWgt?=
 =?us-ascii?Q?2M3IFDWWNQLmCIECnkXzgseTyTXLWRfZA4WU4q5gJZRfxf662AZ5izJ2ChQW?=
 =?us-ascii?Q?NSklrGalttE8xS1OfGdpvO+0eA0bCaW2HEzRYhHKoFlYr3DC8ukPugMZB/y6?=
 =?us-ascii?Q?DdBYTkYRaSvj1Sw1n4G7BEW8kRpXy/V6T/a1tmTwXRomholuOK9FdR7v5N0A?=
 =?us-ascii?Q?PAbCdHE9sj/X0vAS4VwEpWp0CkfXlnk/C8wdHA2XrKvXcoaK2XZMoYDAILbj?=
 =?us-ascii?Q?UXHK43YgyUEiSRtw+3wqtQqMPt6ds2OOl+kfAHsNP7IO2GPV80JbZdsAe6TG?=
 =?us-ascii?Q?QBw0dtdh5gBC2c+10hp5z4thaqp5ksfs2TChuX4bL7kSLKNEd7zkerE0BFRd?=
 =?us-ascii?Q?Snrt7tJm2xKeqNZ+dODWLW9JcSthwaJxBMQr0X1CaVVgkh4WArL8veMg+LJz?=
 =?us-ascii?Q?V6/6fLrr5SKDsfZsnZLWH8pwMSMa7WzM5ZufYGvP7mEDDDx2gaQNTTp1OEDq?=
 =?us-ascii?Q?ndGkt/KalqwS0iUVRgcyXpYelap2ixngFfIJMmKo0HTWnAVVPYzaqZjMkwaQ?=
 =?us-ascii?Q?rH5isNVUdKKZCKUUYD+6nm2gxugIE+eScXtec6S/mQDF6KoOpc3gCWTah8mU?=
 =?us-ascii?Q?w6ZFRQP2e/2I0tNLwQwA2lgDyNl7SmZdcciZCZRZwHRxUzXIfF7Kp+Kqw+7r?=
 =?us-ascii?Q?wTD1XqyD6JGRp5kmQg1GC1qp8ip9pDyBTPEAyAai23du84fDde3lADP/wEJr?=
 =?us-ascii?Q?3St7LIycokGdf73UqNy4DOC+aTFkV7n7ziriZS3m73oBIXVB0lhryrJ2mQg2?=
 =?us-ascii?Q?D1EoG/ECCQGAMQHkAXNPpHk60wBQwuA0B0ZiXMtSRmlK6935KrPoH7HvFZWq?=
 =?us-ascii?Q?qX2sFAprhsPlMqx6plP/XQKFICqRhVgNXVE9UYG37k0Qe5mwB75TZZgPbrwJ?=
 =?us-ascii?Q?tNA4qXW66gh8dT5Pd1WYG+KoXJqe14bfw76KdbbxbIAEsbcCe9fZgYDpFZFl?=
 =?us-ascii?Q?DkplnbyD3V54r5lhkaBrvZ/b21CNvbBOZR93l61MiSXKJ7sa6kXAXWEBSEXb?=
 =?us-ascii?Q?GSePzWodMUIl6l/kMktFRIE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kXJnVFFZq9UiQyVCUV9TFv1kPkwwQ1+gjHmDqcSxMU4ja+cplvra6Yz8tONj?=
 =?us-ascii?Q?us/m4rjlTnnABCgMobOoaIvBz3bvCMNAPeBEsyFvIP6YsH6oZWw/vtZtp5ms?=
 =?us-ascii?Q?qWHaiHaI4qu04s0vhcV46vAsm99sT7Jv42Y687LjhvkXwu1UNex5hr/lWucZ?=
 =?us-ascii?Q?EFtX66XCm6TV71buk46ERaoxE1MCEoz32liIQwvt+gMf0cu3tW9NAOeeyq+7?=
 =?us-ascii?Q?wPiRzSxAcV7ZHWDz/Incz3NRNdq6p/6I240Vd0Id1IzHz2jZTiln9fHck0No?=
 =?us-ascii?Q?VoRTVq2uzBEkkKDm01RbOBNC5u+ElXz9WhacjWdOrD2vx7KFf0WzF3TDbhAu?=
 =?us-ascii?Q?WLigB72lMPwWP2/gK4fhH9EN6xAqF6Q08LyxZlW5R1A+164xQl9i3Bf0jJvu?=
 =?us-ascii?Q?GH4Tu/YXJphzlZpHdKK5bcZXD0mwkY7tu54WPdz6lc5mEsMkeewUNqN7Kskx?=
 =?us-ascii?Q?AfxEE9sjlQeC+QkQJ+joD+Aftz2CM9Xkrp9JuqvKmV93kV4pH+POESpBVyi1?=
 =?us-ascii?Q?LozmvBIr2knVWXymgxxeuUjzD9Fv2piqfoLjVJTe7RKrTCIgRGYjxzOJSsvo?=
 =?us-ascii?Q?Kbn6wI2yRQxZkpwylz115tNbceSshYBkNHNFqzAF3AvABewacjkB4XiAqiKw?=
 =?us-ascii?Q?6p1AflIZ4eDRDfb+cieJp+2D3b6iv3m2Z2wrxo6Nx0WQNcCCM+HpYv7xjXRx?=
 =?us-ascii?Q?LYFTfeHIEZsQVoq2aid6JpAuSfVJlyh9p31ECnUmW4Yb0W/X3wTfNaHdOuTi?=
 =?us-ascii?Q?Qth1RLuF9sbb3R6w6yfm76brRa/gnWyc168YF9DgZuv1z6Q4VvF+jBBub0oQ?=
 =?us-ascii?Q?EC3OrBp/GViit7buiaw9q5uu41vvjUqywsHvZxj4y4KWZaNsTmuWFzJcPyqW?=
 =?us-ascii?Q?CaTPNgRlgqgals0tfCfXXKkxzRoie5577x6VHeLY6CryMJI+5W8I+My5Lbtu?=
 =?us-ascii?Q?tTXAbTUCFV0EOJUXbEyaWWPOvSe6FTjEkxiPRcsZ9MRxGkIOIMsHhFtHdV8d?=
 =?us-ascii?Q?e2scJSBVs0TNiQM/G3EFsyrgQK767cI1goIG8mSYHPjDTkPq+xVyM56UzOZR?=
 =?us-ascii?Q?VVncEwNYL0B9/t7pJxKkO2ZxJOTx6Cueyqogd7+nilRO+XjenvXYXqAzycbU?=
 =?us-ascii?Q?q4y9nraHk9JWnKonHTMqnUxQ+G/4NpX0Zn3PNgpp7WM06MKQZcj1MYJyKwCH?=
 =?us-ascii?Q?7pqcr0EZudbgXE+oBo8T4F6/DYPr3OJG6MWhzj0+FTQ5+1Vum6n4B3Yb0Uud?=
 =?us-ascii?Q?X2UFplma6avDB3y8DmDMhVk9jCL8nhSCY7F1GfJi2FdDv1C51JjbiVoq7qjz?=
 =?us-ascii?Q?OaOmIakl8hiaKp3KDjNdlRwuMiKSMbc8ZvwEAeVWa+Dvrk2QuRZKZJV+QRkV?=
 =?us-ascii?Q?b56UXX3rgGtCYntC10uoq08gsAo9HHw6sZtARb/bYvypzNBEvrcPXC+CcFo2?=
 =?us-ascii?Q?VipCiWGrJ9SJ5nIIHsYKxzsOHG2kFzaeQnEIdVRvtKo6ex3x1bxkKdYpY7g5?=
 =?us-ascii?Q?zjRC9LCt8sHIPUor6ZKnKOWHzwLSqtcs7M/jsZ9S9n0Ix0UEzZkVnm5iqxSq?=
 =?us-ascii?Q?CtBik+bRT4ZwYOsnSzM6+iMYzbkEX1IVBfZ18UffDnZmM0+4MHx6zIKNpGG/?=
 =?us-ascii?Q?2Km3YTcjvwrTjOFwgHs3eAPECvSzy7Gma8wsgIzh5cR9NnrOjuixEbTRq321?=
 =?us-ascii?Q?0kN377OwwJQCHTplIP6F/Zq171sRoIE0uvqSN7slNyht+S+PeWxPh/828QF0?=
 =?us-ascii?Q?Jcfiul+okA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5839df28-342e-4fdd-d758-08de550cf67e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:38:49.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRPpYpbdRjlwOBBt30pkG7fIumnXQ+APBoqJIGA4WPYG6D202R1zdCM1jj1KfYDF60RVXYE9L9HAT/mXlIEexA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10506

On Fri, Jan 16, 2026 at 03:40:25PM +0800, Wei Fang wrote:
> Currently, the buffers of RX queue are allocated from the page pool. In
> the subsequent patches to support XDP zero copy, the RX buffers will be
> allocated from the UMEM. Therefore, extract fec_alloc_rxq_buffers_pp()
> from fec_enet_alloc_rxq_buffers() and we will add another helper to
> allocate RX buffers from UMEM for the XDP zero copy mode.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 78 ++++++++++++++++-------
>  1 file changed, 54 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index a418f0153d43..68aa94dd9487 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -3435,6 +3435,24 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
>  	}
>  }
>
> +static void fec_free_rxq_buffers(struct fec_enet_priv_rx_q *rxq)
> +{
> +	int i;
> +
> +	for (i = 0; i < rxq->bd.ring_size; i++) {
> +		struct page *page = rxq->rx_buf[i];
> +
> +		if (!page)
> +			continue;
> +
> +		page_pool_put_full_page(rxq->page_pool, page, false);
> +		rxq->rx_buf[i] = NULL;
> +	}
> +
> +	page_pool_destroy(rxq->page_pool);
> +	rxq->page_pool = NULL;
> +}
> +
>  static void fec_enet_free_buffers(struct net_device *ndev)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> @@ -3448,16 +3466,10 @@ static void fec_enet_free_buffers(struct net_device *ndev)
>  		rxq = fep->rx_queue[q];
>
>  		fec_xdp_rxq_info_unreg(rxq);
> -
> -		for (i = 0; i < rxq->bd.ring_size; i++)
> -			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
> -						false);
> +		fec_free_rxq_buffers(rxq);
>
>  		for (i = 0; i < XDP_STATS_TOTAL; i++)
>  			rxq->stats[i] = 0;
> -
> -		page_pool_destroy(rxq->page_pool);
> -		rxq->page_pool = NULL;
>  	}
>
>  	for (q = 0; q < fep->num_tx_queues; q++) {
> @@ -3556,22 +3568,18 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
>  	return ret;
>  }
>
> -static int
> -fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
> +static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
> +				    struct fec_enet_priv_rx_q *rxq)
>  {
> -	struct fec_enet_private *fep = netdev_priv(ndev);
> -	struct fec_enet_priv_rx_q *rxq;
> +	struct bufdesc *bdp = rxq->bd.base;
>  	dma_addr_t phys_addr;
> -	struct bufdesc	*bdp;
>  	struct page *page;
>  	int i, err;
>
> -	rxq = fep->rx_queue[queue];
> -	bdp = rxq->bd.base;
> -
>  	err = fec_enet_create_page_pool(fep, rxq);
>  	if (err < 0) {
> -		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
> +		netdev_err(fep->netdev, "%s failed queue %d (%d)\n",
> +			   __func__, rxq->bd.qid, err);
>  		return err;
>  	}
>
> @@ -3590,8 +3598,10 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
>
>  	for (i = 0; i < rxq->bd.ring_size; i++) {
>  		page = page_pool_dev_alloc_pages(rxq->page_pool);
> -		if (!page)
> -			goto err_alloc;
> +		if (!page) {
> +			err = -ENOMEM;
> +			goto free_rx_buffers;

look like this part is bug fix, miss set err to -ENOMEM

> +		}
>
>  		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
>  		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
> @@ -3601,6 +3611,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
>
>  		if (fep->bufdesc_ex) {
>  			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
> +

uneccesary change

Frank
>  			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
>  		}
>
> @@ -3611,15 +3622,34 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
>  	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
>  	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
>
> -	err = fec_xdp_rxq_info_reg(fep, rxq);
> +	return 0;
> +
> +free_rx_buffers:
> +	fec_free_rxq_buffers(rxq);
> +
> +	return err;
> +}
> +
> +static int
> +fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct fec_enet_priv_rx_q *rxq;
> +	int err;
> +
> +	rxq = fep->rx_queue[queue];
> +	err = fec_alloc_rxq_buffers_pp(fep, rxq);
>  	if (err)
> -		goto err_alloc;
> +		return err;
>
> -	return 0;
> +	err = fec_xdp_rxq_info_reg(fep, rxq);
> +	if (err) {
> +		fec_free_rxq_buffers(rxq);
>
> - err_alloc:
> -	fec_enet_free_buffers(ndev);
> -	return -ENOMEM;
> +		return err;
> +	}
> +
> +	return 0;
>  }
>
>  static int
> --
> 2.34.1
>

