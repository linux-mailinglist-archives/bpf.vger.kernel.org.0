Return-Path: <bpf+bounces-79259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91CD32844
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A8E0300F6AB
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9A3358B5;
	Fri, 16 Jan 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F5W6t9bF"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB082D77FF;
	Fri, 16 Jan 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573324; cv=fail; b=JOahBe5j/+IzbdG+V3NuoSsoN855tduFafqmJb1h+8TNvwG+jVxTawSuU5hA3fesrgVSQ/H6GrkDjnShuJmvUfuO+kapMAzW9T+Kl0XIZ4WkfgHiSZDcIf0gS9s8WrN+HRAYhMZdPl8h6+n/etwwNqd0kgdvNDRt/Ex54NhWNN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573324; c=relaxed/simple;
	bh=aI+5IaOJBuFjpbCpm5Tg27Fh0YsKYU5Iq3NLNsdqTGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z7iOzPl/2r+KihCmIY7KMNlhvCm8pNmm4SuXbKUbXQHU+c0x6B847qlLMteVQvgAus5MpF1nTlS3hgANT/8NPdCwjC1eiHyHqE7rEDzNd/0MGZ5V9u8JQK4kA56NkA8uyJGVrMTWJjRdPJFWDX3awmotB3u21CW2HVLMsDVXZsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F5W6t9bF; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0hJ6XGd3ChZcHjpmX3MPQfHOtcxIfCtkzWWNIOEyiP+NliKuJQnSHmyua8qHkoE8S6YZqOsDCi8DQSF7gNjQsJEo2Fhn0A0Zysm6/IQoq4oZMiBU8si+kiwyXeTrfoXlqdOHhMkqo2YPPX3TRpjx33crqjy5xcnhanpP5fuoxcBjREPezEFDUPZskXIoSpVVQ9YoRj3mkDGuVYLe23Z8C3CbkYesH3PsmGQ1LWU8EzR3s3Ndx730mU8fXutHe5m/67EzbA+vqT9yiu9e6wgkEHC+cPappdXP6HWXcGqunBdSCrjwm32DnCkBW3HhMVrwdbh62ntoAXvXbly44SUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jbjiNtOUL82mFmkcmWGP5f2N6w9SJ3Heg8Rtqblquc=;
 b=YvqwIf2KLFXtLdhn/LHIxs1Uq8OCdq+szbHV3l4vbLbUQjcZZIgcw2SnBOPpN8KLDeK4sMg/UseOT0EKfS2LDPHmEql44gVp7dpVyG6M3uYm9lpRXII5TAM+3NJ6zBMZk1bxorsnYG80XxC5tN3OnEGgtRoTB/BW1dpXGygOgwT/XgZsKHpcsb/ZbBi629fXhxxMuNIHF/XfSz0524ZZJZa94UrEQ4sNKGKIiy7XK3nEPLL+1N/TpjWoNsdKmhYuxwOfcWyklK00q+w5K5ujki57+cJc/VxS4NzU8sGNTVGIohmvjEDHN1TxE6hG5Fvv059G3+91jmpF71ff18vitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jbjiNtOUL82mFmkcmWGP5f2N6w9SJ3Heg8Rtqblquc=;
 b=F5W6t9bFcKB7oPAKMvTZsjVA860Z3M2+nLcV6VKXTQOVtTQd6zP0cubUEvjUBtfmej2BcM2P5mqtEZ91iyhqpxvvgFpDIEUfBgLbgRGQZ1tPH4xOSH5DOBbTgAJCYDikcZANx78o7fsEK+eHAQHzeKm1ceuCZ6ec12MKt11Badj6eVU3WRWaTA+KQBMMiApprqL2WW6+nl5kIeG/NCTZu7+ditOJsgk5M/bNz7FMP1VdbJoBCEotvRfydgxt9itT21Q2GyVoGs7ef4FqvaPrPVOAhQzpsh23rlF7OI3BXlEn6JYpeVBjXfPOhWsVd7u5ka5a1xpvHn5Ne3veYMoW7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV2PR04MB11882.eurprd04.prod.outlook.com (2603:10a6:150:2f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 14:21:59 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 14:21:59 +0000
Date: Fri, 16 Jan 2026 09:21:51 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 08/14] net: fec: remove unnecessary NULL
 pointer check when clearing TX BD ring
Message-ID: <aWpJf59eGSWkhY+y@lizhi-Precision-Tower-5810>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-9-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074027.1603841-9-wei.fang@nxp.com>
X-ClientProxiedBy: PH0PR07CA0088.namprd07.prod.outlook.com
 (2603:10b6:510:f::33) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV2PR04MB11882:EE_
X-MS-Office365-Filtering-Correlation-Id: eb424ddd-eb39-41be-beb8-08de550a9c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HjVVs3vYLjOv7HheaewA4TIqfXSyIEZbkbFG2gnqg1hpb+0ObGSN/TOFJjoR?=
 =?us-ascii?Q?W8a3+0JYZagHyTH5YRd8WnYZNmxUTTU5NSbGYStULEqRK/dKlc90yUgiqS5B?=
 =?us-ascii?Q?jQIidgCcTYFpJiIzmsPk2KGV4p9/z64F+iHSH5ECiq+rZijyEaX7XcuuFNcI?=
 =?us-ascii?Q?b/y+0pXYH/y1ajg9AhuPKuiOo4r0m7Q+x+oNeNp1OpB6PiUpC0yOpNeppKrk?=
 =?us-ascii?Q?YPh/8sOORv5mfDVyIXG43HR9R2tIpZVztkJrqMk9nyTnoUrPwtMZylKl5HGo?=
 =?us-ascii?Q?zYTyLnH47RUdwHwkIjzf5Bjzdx8onLT9LhIq/fZJ+etXczJBSKYDuuTIg7Uq?=
 =?us-ascii?Q?FIydFqJ1JcTmwbgtHF9hs/SurG4ERBlh1oANzKaaFRm4tgMw3zE83xGlKkId?=
 =?us-ascii?Q?93K5sRzY9OjLKw5l3jxaVPzcbNEeX5rDszoYQzZATT4dfR1Thz0qZfGgVm6W?=
 =?us-ascii?Q?zWq1WAO8eAM2nyQy4qwTuhFj/SUAct6jr6qB6V72YpLNnePg4UIs5pB2OYuG?=
 =?us-ascii?Q?LyxFBsYU/BDypkzT8xyWB7VGJuobt8sMTNqynOQWPaN8Vhb6YNGKyUnDjD7G?=
 =?us-ascii?Q?UrAqWXWne6pCQ0voTaXs9URsWmKja3alVx/y3hRiNI7EQrWtXEUhypwRHCIK?=
 =?us-ascii?Q?qLN1+WkFZZo2oSIMZsBFlU6zPi+BmXwLHtYK9ab9U5gSqOcuIC02UZ5HRKc6?=
 =?us-ascii?Q?DDfT6Sm7vbOS4cVz9QQsBT0TeNvFHu763b1zAUTTJg9JO9vVfXLvvj68DhRY?=
 =?us-ascii?Q?ImMRDhK4jM/w5ogGbfa9Yz6Tw/ruDNYrXTfXCYe/RwwNbKeLzQcV83m14p2d?=
 =?us-ascii?Q?Yk+yY95kV0c3O76OG0H02SVQYZVxW8x62XsEzXvVZTO16skwff0GdCEgEQRT?=
 =?us-ascii?Q?m0yFEnhZuBPmTTdDTBuPNV8eRtMlRdjT/IZZn3hD2metJoIsDs5J6m0sG2GZ?=
 =?us-ascii?Q?G0XjHYt3sc05z4bR08X2FN3PXXN13T1yFXBI6cKKWHQYRUebaSgy/6G+HEAC?=
 =?us-ascii?Q?nW9TUyFdDGckB7BFn7pCqEUJzlCQOwrcsu8V43slUozBf6slUgEHJ/8gFk5r?=
 =?us-ascii?Q?95BgTFXWpnHNjvfZu+ga3QYm03RvFfmSNQOWLyF5FhNBpNKhxhU1a8OiRTc+?=
 =?us-ascii?Q?DGBIrJYm9L1UXAVNYKSMkFPJ4qHOYhvK9tD0ZqFDLCvc0cyleMDV5kSRsm6n?=
 =?us-ascii?Q?Dp9QAj1BdCvqbRxeIMd+uvh6JON+eE1v92SFxsJN9BMt2WGSK36tNYDexp/W?=
 =?us-ascii?Q?DUDnnMlDljfOLNZo5XvovenUaXTbDWzHvGntuD/irHXN9SVLGjf4Mr38IyLk?=
 =?us-ascii?Q?dSSRo2jgdQvCAn9YmGJIyoxBGTDmqLy/ftqmh+vH2KI5NvwsE2q67tWC7JuD?=
 =?us-ascii?Q?48pzYzlCq8QUYfSAnifNIUvt2j4GScTBLAmFzMtDMpHu3sh8kTvR4qw64kA+?=
 =?us-ascii?Q?M7by6Ttnjf9VswK2piovqm9dtVOBj9aJpvjnpVGqIi7a1F9Mc8RCPqxtEPwf?=
 =?us-ascii?Q?vUGDwhw9km+ZAXHxi/L0w/grrBpFxPa822bfaBZl+HceNK2SII+Aas+ccuHM?=
 =?us-ascii?Q?qKtt7gad6ez7xvt3dUHHRYlV5CHNH/SSzP4ejbl7lAjLeOSjpK2Uxd3gEq00?=
 =?us-ascii?Q?vsojSOHhtwALf8VINanNQ1c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7LH/yHs0M3Rd4F2ilu8sR4DNNsWuPWskQJgwhtHt0s6BfHeP/rjyV7V0kmki?=
 =?us-ascii?Q?nMHMAlWExpOz93tguWfa1ZgdWCg410HdofuZTZi4ffocYI4+nDJs6UzWsYgw?=
 =?us-ascii?Q?BNEPnv00v0ypEk6csAzHNufbCXCGI+u0EZZX0T0KYvV9yrLn0W7QQNCM7ar7?=
 =?us-ascii?Q?PFmToEWFtfoz7g8uMYK1pdk3+ilClwrYO1fHVJ0q/KPCRkC3XUtKX2XyzrX3?=
 =?us-ascii?Q?dr5TkJJ/3Vfbwy2G2bjLkeplO/Z0eo1npIBofvfXpyWChJDe1cwcL2RNZOCY?=
 =?us-ascii?Q?Q2w/G4XS9MfZouZ4sjhF/E1D/u0Ga14b/ThDpjAml8GtHgAY38+/p+MFvSaA?=
 =?us-ascii?Q?aLe6OLRavM2DtExBiDZD46CiSSeXGYVcY7YhnuIJ46j1v0JCIQ7TQrTAgzRL?=
 =?us-ascii?Q?6XEovLodUxANC8zxRqZohiTX1RC+OcFtmURdfeI8UoBncTngRNuk9rPqgD1r?=
 =?us-ascii?Q?KvYa74ETxsVBb4jSpGPEExJ8pVKgL6UGx51mzg9IDwOpA002TRN+PlzFIvS1?=
 =?us-ascii?Q?JUGIJK6nP4KIA9puJeXH/9943ru9uSZ9CfDfGdc4UqoNDYeHd7bR2uO7DKcG?=
 =?us-ascii?Q?wzheef5ESwhozF454QH+iXDc/1GiHoyzJ4brM1KUEcNUsn3VoY4Gibq+RzAE?=
 =?us-ascii?Q?3RC0jv0ZbpPC1vyE1fNA8iph6bOyvUc6VNlLAuLnoLyAdVNKr/oYQ7C2aIX6?=
 =?us-ascii?Q?Dl5wvlup3vni8S+lRUpZF1SGER8sIfNeHw/dyofu2PROvPWCGDzyDh0o87TW?=
 =?us-ascii?Q?M8gLvELE3oNgyXufZuvtDZCzAWL16SpzyN2p9EF4FzReQgkN0ru4+h3Y1Imo?=
 =?us-ascii?Q?ResB/gDG6gM+CM2EuTUVJKprt0GnTn9j7drlqIzzdENUJu2nc5SKp1ooj16i?=
 =?us-ascii?Q?mf8cTyLAAPIr6YcVI1ZOX9fyObLfvy7J32Y0cvCl0azMsYhsSR7xd7JyZMTy?=
 =?us-ascii?Q?1a5+CEmRew/dm4CumkFUYLuIb7TdbVIHSyrlQmS/P51dwVM0AGeqyrFigoAN?=
 =?us-ascii?Q?fHJCwowluTnbQDG6B401zfysrTS+kfGzfUgKnF0G746zDNWOhioSlwKIOy0k?=
 =?us-ascii?Q?TiBJHGchEsic4SkEq8P3RXEHPFdNo8xG7J0b1PDStEMvkEViIMkSveYBwaAG?=
 =?us-ascii?Q?gADgwK/HmJP7qgLjgHp6p225KpczmxIU5RWLFVDiFA80N4ptpOti3eDLIiVs?=
 =?us-ascii?Q?jYwhvaAQHgYkX3CsWL9UY+MJqGwd7++eRapx1u5ppx7LenMVL/KUOGd2S+FZ?=
 =?us-ascii?Q?QX6/z/3GjPpnMLcyzaewmGs2zuQxErak5mhzMyp5zqq7wGiRySh7x08muyXZ?=
 =?us-ascii?Q?ubKlNpQJMzxCfEK4lawOQ6LoZ0niE0Yz5oaKu5+NumyFJ8Y23hwwN+lEQqLx?=
 =?us-ascii?Q?M0ECBZpWWKIeiod8p7GT+MBHbkup6DJXZ7TnjsCN8TmR+5FdO6OY1sXpxYKB?=
 =?us-ascii?Q?N2SyOgF6ksV5+RcNXf83rBlKuATpr6bN5waEcw8LYXYLddn0JPRlQWmETSJ/?=
 =?us-ascii?Q?+JXNEL+ayb7+mpe9COna9HnguMGJuHWsto6wFYePTb+Umi76Pw0l03kWkTv6?=
 =?us-ascii?Q?0bKQ2vt71Y+ZXodP4RVaCoTRUhdP9/aQYwfq68pztGcg0tVSCNbqjLG7I7gI?=
 =?us-ascii?Q?cM71FmjqWTnCnXFiegUgz/C1yHirEtvqUwSqLRc+QmBiicgo3iz3w3Yi0sNa?=
 =?us-ascii?Q?RxKQDQqkov50Tl4qWmLV/F4s8/tfhSOHZMamJfnu8m9kAoCJLFplInjJ9Tc5?=
 =?us-ascii?Q?LT9E9chO7g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb424ddd-eb39-41be-beb8-08de550a9c4c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:21:59.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/xFFT1X7aGAN7Jj7jy53w87WrOMT1lrAMuYk/JUSdopqZxs+dOxFJ6HjAQS7ACEkcwKM5RW4lNjX9aBaIhCCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11882

On Fri, Jan 16, 2026 at 03:40:21PM +0800, Wei Fang wrote:
> The tx_buf pointer will not NULL when its type is FEC_TXBUF_T_XDP_NDO or
> FEC_TXBUF_T_XDP_TX. If the type is FEC_TXBUF_T_SKB, dev_kfree_skb_any()
> will do NULL pointer check. So it is unnecessary to do NULL pointer check
> in fec_enet_bd_init() and fec_enet_tx_queue().
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++---------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 52abeeb50dda..0e8947f163a8 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1032,24 +1032,19 @@ static void fec_enet_bd_init(struct net_device *dev)
>  							 fec32_to_cpu(bdp->cbd_bufaddr),
>  							 fec16_to_cpu(bdp->cbd_datlen),
>  							 DMA_TO_DEVICE);
> -				if (txq->tx_buf[i].buf_p)
> -					dev_kfree_skb_any(txq->tx_buf[i].buf_p);
> +				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
>  			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
> -				if (bdp->cbd_bufaddr)
> -					dma_unmap_single(&fep->pdev->dev,
> -							 fec32_to_cpu(bdp->cbd_bufaddr),
> -							 fec16_to_cpu(bdp->cbd_datlen),
> -							 DMA_TO_DEVICE);
> +				dma_unmap_single(&fep->pdev->dev,
> +						 fec32_to_cpu(bdp->cbd_bufaddr),
> +						 fec16_to_cpu(bdp->cbd_datlen),
> +						 DMA_TO_DEVICE);
>
> -				if (txq->tx_buf[i].buf_p)
> -					xdp_return_frame(txq->tx_buf[i].buf_p);
> +				xdp_return_frame(txq->tx_buf[i].buf_p);
>  			} else {
>  				struct page *page = txq->tx_buf[i].buf_p;
>
> -				if (page)
> -					page_pool_put_page(pp_page_to_nmdesc(page)->pp,
> -							   page, 0,
> -							   false);
> +				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
> +						   page, 0, false);
>  			}
>
>  			txq->tx_buf[i].buf_p = NULL;
> @@ -1537,21 +1532,15 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>
>  			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
>  				xdpf = txq->tx_buf[index].buf_p;
> -				if (bdp->cbd_bufaddr)
> -					dma_unmap_single(&fep->pdev->dev,
> -							 fec32_to_cpu(bdp->cbd_bufaddr),
> -							 fec16_to_cpu(bdp->cbd_datlen),
> -							 DMA_TO_DEVICE);
> +				dma_unmap_single(&fep->pdev->dev,
> +						 fec32_to_cpu(bdp->cbd_bufaddr),
> +						 fec16_to_cpu(bdp->cbd_datlen),
> +						 DMA_TO_DEVICE);
>  			} else {
>  				page = txq->tx_buf[index].buf_p;
>  			}
>
>  			bdp->cbd_bufaddr = cpu_to_fec32(0);
> -			if (unlikely(!txq->tx_buf[index].buf_p)) {
> -				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
> -				goto tx_buf_done;
> -			}
> -
>  			frame_len = fec16_to_cpu(bdp->cbd_datlen);
>  		}
>
> --
> 2.34.1
>

