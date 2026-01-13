Return-Path: <bpf+bounces-78730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F65D1A089
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 172E43036591
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82D03451BB;
	Tue, 13 Jan 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IBdP9TQb"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B00A32C305;
	Tue, 13 Jan 2026 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319618; cv=fail; b=Kcp4fPGS1C+K9VFGkIeFQnVb/+MDum+zomN92/si1B73WvStbzDVqoKc0xnF7KsPzeXmg9xOUa4kIkqm09O5Zmm+aKga/csWvP8jm81NsBY+CrbVKznWHu424Ng8VgiSqledNTCw/62MZCL0mAJDI/p5KEq4rNKUI4oGigfWyN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319618; c=relaxed/simple;
	bh=InyjR5IjvI7cszE73gVanBEIzeM/X7vtXUua+GmfdF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NcscNXKeGN00BcCGTn7GBF4+vR1+iAx5RnCtjxxUYblvtlCq1Kj10tY6JrDjttCjSrA2HXEf0X5WXjWtmX59alfh9fwOr0LDkcP7z1UUI2sQhd7AM2Yn0Tbt18v380FuYZ7AMrWfngMbglTRGMM0erNqLRHbHCsUQLmYN2hRIaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IBdP9TQb; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdukG/YfJ8SdlqoYNl6Qd586WE1kKQ1iICkh6scL1nyW2OpB0yk9Cuql/gsYCyZmx2vlmiaMmRo/x2Otu+un7bZxPHoulIS5QE+kUa7grmZW2swNtSgT83oi3dGFUlXcXCobH9Mrjnb5AGMebeDBR03bt1PIJKu+xLYLfvmM2pWPnMss1M6A/6x37lggLnCQyMP6SfSW9Ch8uLmlAmKXFzdqwYDteScIeRp/ErAvs5p4atFxTIirEKvwIzcQ8DuKh0WVp5hsuZU21g5mcS51ID3YybLsBQCo+IVN0wMVtFeCOvTySUSie86XD8eT6RGW9GXZxtxXzOcHh08QM4QXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCUn30YgFf8DlRo68ojrdi4YOtrMhqfeN0FhWMQ0jQA=;
 b=ptTosa/6U6Ocv9zovL/9+cRi3OyvyJP98esESepkwPMo9TdGXycXfYeWpU0LnCPr7c23vhxLHzCSdXW/ue74z6/FoOJPBe6kfEGZB0CT0uS6A94xV6R8y0bSdrCeISOe6UYWshUlUxPcJ+ir8xqcfdixsqx9XOPYUbfv/V2xR1cIJ9JFlxl+sCPu1gDmGWr0ZOMkTe8Lo2xTRtFHO6qr8kH44evwXV1RXc0G/kMXs3x3+dZ4yPBgKbuveyZ3HQnSdvGzDoBJcy0avT8f5GkHa1gqkXOuPO5eys9LMMcGMgKon4qUmAs31wsfVMLzPA6CIIEaiK9vqwtyp2FvDOczFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCUn30YgFf8DlRo68ojrdi4YOtrMhqfeN0FhWMQ0jQA=;
 b=IBdP9TQb36HT5KQgmw6jv6hm8SKI0wi5GiEM4Y5Mm0RO8arO9aU4IUrEJC3CagKTEYRmshSGarWjWDUsDORbiTkrBQHRDX5PElhYuCFFRxNBwnvDkkdhXVAbwJ1ZPQKK1ZpjSZBs616/GkOuKPXl77I9uw5yLjx1vP3oN9Y2EO64XYBQ9YSFyjo8Ml1G2s3y3kk9g8WBpIW+4ZozGfJ07LcJRLmfkOy6cTt4t3KMZFsmdQstorYaxdv6NNzk7WDeEXA3lvOJ+gGij4xU77YuZTTvbtuSvm3aBSeTmv3k3aVoVKPIsi+Xb8Y8Dt29E+Qii4NMhscv9KgleMLjszOL3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by DU4PR04MB11411.eurprd04.prod.outlook.com (2603:10a6:10:5ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 15:53:30 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Tue, 13 Jan 2026
 15:53:29 +0000
Date: Tue, 13 Jan 2026 10:53:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 02/11] net: fec: add fec_rx_error_check() to
 check RX errors
Message-ID: <aWZqcULecGZK5nxS@lizhi-Precision-Tower-5810>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
 <20260113032939.3705137-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113032939.3705137-3-wei.fang@nxp.com>
X-ClientProxiedBy: PH7PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:510:325::19) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|DU4PR04MB11411:EE_
X-MS-Office365-Filtering-Correlation-Id: adddbc1f-3453-49e0-01a1-08de52bbe58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rPibeMVzIWlTO6M36n94C9WNrmkdge0ZUn7Jh5vVnzrXb1uzqNKbAi5AODNm?=
 =?us-ascii?Q?oTg6wT81uC/F4Nkwljra2uYYpLlNaY6ipGIu2u43Jt6U9X2ZI2yYKU9++nJU?=
 =?us-ascii?Q?ajTgEMbD67pDNC8q3Yp8i5HvnmRlzRPP5+ZlKUoHqRLSNN5LFkxXrhUr3ZDE?=
 =?us-ascii?Q?2lKjP1iSqta8aovv+jHcP3PDlLS9hh6ebdLyYXkb9eJJCtmwRsKRqdCi99Nl?=
 =?us-ascii?Q?UP8sXkiIEfTgS4QpMJZjAwY3gQRuI6RQ46g2ipD32uKH4QjSjAK5tsz6A/65?=
 =?us-ascii?Q?1r45c8EmZsGyMJ1yV4ZyAtc1e05pk5hJGYMLHaCV7q9BKrP56gkhGt2zjQEO?=
 =?us-ascii?Q?NbaHldskzrdTubBBWaH8j98iCsxcgixv3i46kNBNwO/v6q1v/JdX0t7YPcyV?=
 =?us-ascii?Q?Fp8JZoJRU4PqBjHU30U0sTFifnGa5jy1tDWnszEhlyQQtO2QYqzNqys4JE6G?=
 =?us-ascii?Q?9J1NFkbT5TVR1V9UetJavTzIwOpiXtSEa/Wee+aC+fkYbqOmE4r2G96vpYPa?=
 =?us-ascii?Q?cYMuzc4kfB0OOSNl8UDbAWgy0tPJWFWx7xcacTQOta9bhilAJIImiv5q4lEz?=
 =?us-ascii?Q?qIaoLLgyTL+UgnwO8jNCD9u7X9vvqbFfftT7m3F3/IzG6rvNzdo+e1T3hxMP?=
 =?us-ascii?Q?ik7kAqyeYbVUdEaNtZXX6JlUOQAOSeQueXELL/jFt0BMn1tUzBT05w9pGwuR?=
 =?us-ascii?Q?3NgTK9JEuvEbpJb809VOfkKwz4vu8oWjtcyqiTVF7t76puxf/ypk/ccRWrzO?=
 =?us-ascii?Q?6RnoLAK6OEUB1FL1y+aiumyxe3CbrxX9k2fUMYOfHnorUuds8q1AY/YRpoTx?=
 =?us-ascii?Q?WibRwxM0bgkHmHjr2QHVP5F/y1bO5Ai2USl/okC0Yg6ygF4DGozo6ATo0KPE?=
 =?us-ascii?Q?aeUrmL3caeA6nkF7HrmadTS3btDXJWESlo22BCmBQ6mHRC1+Rx326IfRytsJ?=
 =?us-ascii?Q?V03SUkCOA/RWkHr2i/W/TthDm/52KXPo6vMmSyfUFYi+LoFnuGA5sXId0YJg?=
 =?us-ascii?Q?kms2NOSJnqeAcxDLLjfhj8sDToRDGHZLZK+XMZofEfD6lBItnWTnYKF2qVru?=
 =?us-ascii?Q?/fMcshVrXd3L27IiFE783MpnMzDs2doqPsQlUqxET2wbtkCDsj3QBzRnr1DG?=
 =?us-ascii?Q?kdVgj0/XrFgyEPAHp23j+ZR8iE038sd+Gs4dXdVVVryAYDHSyVHDsdaFP4wE?=
 =?us-ascii?Q?+Qg/BVJK3NC2GTKAk967KDLt8QgqfmPoWowVm9YR5vpbM9zQu6GepbD3XjFf?=
 =?us-ascii?Q?Nkho6fCEB5ns1hnch3zAdaiRm3xL08Ab0lN/0WotZicp2lvJnaXy/h5fQwTn?=
 =?us-ascii?Q?3eFXyxihMUHPpZBHPdZz9f0PP/SHCZGobSDiWmPJVAKKGHNvP9eAeazB0sdk?=
 =?us-ascii?Q?gEB8zVuyG2swXhtPW41Y4K5wRrF8LYDLVgqcW/N486GLEgV5hevWhesChZZN?=
 =?us-ascii?Q?EYtEM8fmsm+XS4CHGp30XPt/1AtzVGJ4HyrgBcBR8Iu4+OVF56JytEiNMOUy?=
 =?us-ascii?Q?6yg/8kmEbVGh/FYDaCE+ZktUtIBo2swOszop?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSOdzMltRjQI4rw8QUUjrBCUC83invQ+0dGRG7DVnLMBMm/0IfdqvF0Mw6/8?=
 =?us-ascii?Q?mxt1Rc/3qx9D+K0CkZWDrfYa+7cIY7dDSdxWmvqQbRThBpiIsDDJGzordGKy?=
 =?us-ascii?Q?fFpF6A33KlVOQ7mbX9XwQLQlTmXk+EWLkBXka1DE4FpIs46wGtUfufeP0y5j?=
 =?us-ascii?Q?+3JshakZJNiUvc2lZY5RgBC92DH/08afMnhnQhPmRFQq7gjjGn5Tcjhual1b?=
 =?us-ascii?Q?emd9k87eLwob/u/efctf2OIQ+nmfFokRT+k5uKf/uzXAY4WGiMu0wuehzp7V?=
 =?us-ascii?Q?RZF+LIDIiTA7WWqbnr7XB4WrJHYBVcWOKvSdiI11eFaJ5kiTXIltmDJ47QPY?=
 =?us-ascii?Q?HwVVp+beED10nc6cV3dYI+f4yP8qGWnBAOmCz8HZHxvzVZOK1CTfuEjUnOA8?=
 =?us-ascii?Q?h0DGv6nARBnlZsnxayBS2aHoB7TklBWJAki0tT4+Ng7Mz8lmjWsjmZh5zovA?=
 =?us-ascii?Q?EZd4mSLezRM7E5ukbI5VBsh1I2gRA14KJ5kGtQnQonOtXT9mTz4ui9LywGE2?=
 =?us-ascii?Q?2MyTBPcjs2xrjZMctWO3PrIUL5r3gdr4X53RLUalj14G/+TCEJBb1iw+LQxn?=
 =?us-ascii?Q?hFM7KEtIH8rtJWvE6dk1MsuhMKWVJQp0JVcK1I6JebyMe0JgoAimt4OfMQKX?=
 =?us-ascii?Q?Vud4k1E8iecilI+N3R35WB4kHcwVAQ1DOibvHzF5fg5ZoPIoJK6E76LEI0SV?=
 =?us-ascii?Q?UXhb1nktBTcZY3v2FjVr8dwm3BtP5XFxPNq1VuqdF5v+GYNvN2m2VmR1Y9Pd?=
 =?us-ascii?Q?b5sjc23zPaVKmmGP+2q6K1pUJrLF+eNbsOnLczhF2qThWbDc9lkdcIBtH1Zp?=
 =?us-ascii?Q?6eFYbN2lDpLnfO14AnOtNwYv5yXSQPRCXfPARjdWfk2jIv+ZNTgPLCdw1keC?=
 =?us-ascii?Q?/bzq1DHGx6zzGsYglARKDgEyT0kv+zIAgQbtblOZIfGQrdfn1WhoSonSoPt+?=
 =?us-ascii?Q?A5OWvbZR0O4A8vdgyoiY/0K6oQrMe+Mz9nI96tajU2Ch8ZIhJggXi/yvl2NR?=
 =?us-ascii?Q?IKn/Xa3p7abAfCSBKEhHcXy6o59YqjO/eoB6glsg6PSg62MAopmoCLOh5SUW?=
 =?us-ascii?Q?7pwEKXTQehiKVUeqPfb0HWQgQZhbghGa9FzK0RypDS+DmyDrKfzQ/1hnWIED?=
 =?us-ascii?Q?3cSfsQ3AyalrBfki2G0JkFjLcPRICI9MpDtBNLPajsLMhekrbpjSZ9sFHDDj?=
 =?us-ascii?Q?ZfwcCopA+zMXj2Gyt7M/dsMCXEZOfWdixhEDweaTHNhzsNHxccAHw1ZsEhJK?=
 =?us-ascii?Q?+1BRteAg/zeuYDU6u+Jsj8VMbOpxj+06hg/mZtRL4T5EAJOpEgn9Lv8kEir+?=
 =?us-ascii?Q?OmvyYTomCXH3J2qtFPqUDmm0N9yNAzhQX63LMQpbC4gqFNC/AX6EG/HRQ5Rk?=
 =?us-ascii?Q?yg4mjnxTQE4TMsUZw2600JJAd2zloYNSajqxiJbmAL3E0344dm7zBRrxh3lh?=
 =?us-ascii?Q?oCvb+HQbtO8UTEynLvGcRZiTklcewIkIWtga7Q7Z45fuW6QtFkFvODT8hPxu?=
 =?us-ascii?Q?BrbHfUP9uILoN3jfPffuCvlabwYrJyp9en2WEPyjfJ2tziFktpYHnz9hEeCf?=
 =?us-ascii?Q?44gopYIM6TOD4X5ITlJDq8oZt6gaMlwJOIcbIImSmydoZi6LFvoaOxoFENXp?=
 =?us-ascii?Q?Axryu1dCsG7MY16rP1J11Jvsc5H2uktc4u9mYB+jYyYrIwH083k3adKBcXTh?=
 =?us-ascii?Q?RNCosz8Ir6wOXbbj+pB8Ex5G4lG2upTOrYeR7iNI9yAqcp+v1PxM2rB1zyBx?=
 =?us-ascii?Q?DwuasD3cSQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adddbc1f-3453-49e0-01a1-08de52bbe58a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 15:53:29.8900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hGxatiRBdls5EcOQGs+EMmRZeFm6OR6NBMA9vhjDeKp0dAPJ1lrQTm+HHQSGo/MFjB8Aw5c3Now4sgudD6R0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11411

On Tue, Jan 13, 2026 at 11:29:30AM +0800, Wei Fang wrote:
> Extract fec_rx_error_check() from fec_enet_rx_queue(), this helper is
> used to check RX errors. And it will be used in XDP and XDP zero copy
> paths in subsequent patches.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++---------
>  1 file changed, 36 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 85bcca932fd2..0fa78ca9bc04 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1746,6 +1746,41 @@ static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
>  	}
>  }
>
> +static int fec_rx_error_check(struct net_device *ndev, u16 status)
> +{
> +	if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
> +		      BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
> +		      BD_ENET_RX_CL)) {
> +		ndev->stats.rx_errors++;
> +
> +		if (status & BD_ENET_RX_OV) {
> +			/* FIFO overrun */
> +			ndev->stats.rx_fifo_errors++;
> +			return -EIO;
> +		}
> +
> +		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH |
> +			      BD_ENET_RX_LAST)) {
> +			/* Frame too long or too short. */
> +			ndev->stats.rx_length_errors++;
> +			if ((status & BD_ENET_RX_LAST) && net_ratelimit())
> +				netdev_err(ndev, "rcv is not +last\n");
> +		}
> +
> +		/* CRC Error */
> +		if (status & BD_ENET_RX_CR)
> +			ndev->stats.rx_crc_errors++;
> +
> +		/* Report late collisions as a frame error. */
> +		if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
> +			ndev->stats.rx_frame_errors++;
> +
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
>  /* During a receive, the bd_rx.cur points to the current incoming buffer.
>   * When we update through the ring, if the next incoming buffer has
>   * not been given to the system, we just set the empty indicator,
> @@ -1806,29 +1841,8 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>
>  		/* Check for errors. */
>  		status ^= BD_ENET_RX_LAST;
> -		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
> -			   BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
> -			   BD_ENET_RX_CL)) {
> -			ndev->stats.rx_errors++;
> -			if (status & BD_ENET_RX_OV) {
> -				/* FIFO overrun */
> -				ndev->stats.rx_fifo_errors++;
> -				goto rx_processing_done;
> -			}
> -			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
> -						| BD_ENET_RX_LAST)) {
> -				/* Frame too long or too short. */
> -				ndev->stats.rx_length_errors++;
> -				if (status & BD_ENET_RX_LAST)
> -					netdev_err(ndev, "rcv is not +last\n");
> -			}
> -			if (status & BD_ENET_RX_CR)	/* CRC Error */
> -				ndev->stats.rx_crc_errors++;
> -			/* Report late collisions as a frame error. */
> -			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
> -				ndev->stats.rx_frame_errors++;
> +		if (unlikely(fec_rx_error_check(ndev, status)))
>  			goto rx_processing_done;
> -		}
>
>  		/* Process the incoming frame. */
>  		ndev->stats.rx_packets++;
> --
> 2.34.1
>

