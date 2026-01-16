Return-Path: <bpf+bounces-79263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FCFD3293C
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2F49303AADC
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FB6337107;
	Fri, 16 Jan 2026 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iSuTtSm5"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6A22FE11;
	Fri, 16 Jan 2026 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573622; cv=fail; b=cA3ClkYVyBQUSz3hFWcOwRnXS+R/x6o8g0dGioWJjnHr+kdBKBGZcILa2pSEZXk3f/sDbWNDy5VqxqZLwiB5wQW2+IA/1iWPMIxgR1QtENRwSww4q3COm1zrrBfEAbbLBcbVFWBunuOzdvBXocWXdG3H15WGBfR4z3AkBhYzWMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573622; c=relaxed/simple;
	bh=AzHSIJDEsdkqPWhYxwz/Lpu/OQ6gWZayhMmkVAXlV2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r/K73RZm/9QGXAIFuNvPXVs1ydoyztcdp6Owdm1/ft4gLDlqnheyuTBCNe1z7NSnnCmX4lOfo6G+/Axb4drJgQO7MKwWNIiSb2v2km6gm/xdOtqYtLZUve8apjojckOWZhWH7aDO8cdG4WYkBPNm41Eywsmtt3MFC/6guXnk+bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iSuTtSm5; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBBBwxCbbLqB4k5eQC4cw24Mh+nD7mOJJ5+p79rasDCPxXlW7TTeyvuNvbL+Bu7A/BkhBf61r2DAGh6CM7D9Q1kk0LBJnBKgdKXaodlRd29OOyKIaJnOnxElOiVrJgvQzf3BXH0iYqCi0UyxfUxeW6MNI5tNdMPfxMhzsekL59Ge58X40Rtul9T1Poa5KDKnEO208K8o5mSxczqFEezvbz5KuryyX9lCnlLKGEmekzxutjpmyqFzTgJK5oZevvQe28oYY4bhwgLLybTxthLNJzNOPiKg/Sj3SGS5/mMmQg59lSvF8Paj0HQ9BNZa6pHMevbOa5Z4A+Xl6rCeJnq51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57jxXIF3IXR5xSMWiRuSjHG83EK210n3TiOW/HOr9X8=;
 b=biNq7HQLVlUuQ5C8M45pXtnSsxUDcOZDV60Z7qKirfIScD/cjkoobsDsezSOyMkVd+WdA7uzR1AtnsVpWV+OKOTagKA9yqbqqvdWHQE/yGIr5EgspkgJSDNkQpNAhuiJ/nqaKRj5BM6OIZi6mvOuUaNC1QnvhLw3BQT8QkvsJVBsUY5L2qYOV5L0rVN3kI8UMUjyuX5JR7lqlmDZNo4Sne7ffpCJqGU1/M5dvYG1/To6eJ9SYQoQheTBbboG1Lolf5UVUu3BSkCY2JdQ1Betqpm9ZUptvVS61iX5OLfxvYyf9I0vOwXTA+1feUYApLbTBqvE0iJlC9JeP9o7G4VPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57jxXIF3IXR5xSMWiRuSjHG83EK210n3TiOW/HOr9X8=;
 b=iSuTtSm5DwlDUQ5izT5lQzKRy8vrIPaUyEVgvj4yV5D6XBMKr0zBAIKtEwUq5fAPBpNoS19KXOrsx4sgGPHzGwBG8vRBz1HopNkgl09PSmndceOOysJJedqZSvKXvHCtMFbJTCAaISnkQib12pjJuY7prE7RXFqSqN3OICnrL3pJzJAXUw4cqMpu6I4n6pmVSFIdI4CHpRiSBwWxh/Xm44QT8E6/vo0oQFbuOyI2/lUvwX9/iZ0fcjt6NaWegC4patXQ2BQRHgxhGv3pg7UzQh8YA9mRTPm5c9tFhmVBQ3CvQw3ya9CwdH+SQvAm9iyFxRQ/BA2Df45RVCXyi9FMhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV2PR04MB11882.eurprd04.prod.outlook.com (2603:10a6:150:2f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 14:26:57 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 14:26:57 +0000
Date: Fri, 16 Jan 2026 09:26:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 10/14] net: fec: remove the size parameter
 from fec_enet_create_page_pool()
Message-ID: <aWpKqT/bJE8i9gDY@lizhi-Precision-Tower-5810>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-11-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074027.1603841-11-wei.fang@nxp.com>
X-ClientProxiedBy: PH8PR15CA0013.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::16) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV2PR04MB11882:EE_
X-MS-Office365-Filtering-Correlation-Id: e83de272-489c-4e4d-3c7e-08de550b4e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EI74B+xvaS7hFE79+enbAxXK5CmkcitVpZ3iosGcxUKCg6RkfoK/+ohHga0o?=
 =?us-ascii?Q?AtL01qVR395NvGAP9c2RqNsR9v1yEwumM3YBxI3YVJyipZ0s3fbao4b0C8/a?=
 =?us-ascii?Q?LYV4msNZ+NHssbXf6azVVWAOklAcjTjrH6LZ3eIkinkbICeEHXjGqssyrX7d?=
 =?us-ascii?Q?rkLi1rmxYjRG5yFcXDyH+Hr/20C1EYE/WJdyKFwEVFMbLyv0/oUAHlQmdfoJ?=
 =?us-ascii?Q?6fYHPJ0IwDvhSmLwzePcM384UZrZWPN2CH3os9rqBiZrZp0N7GeTBy+b7c7V?=
 =?us-ascii?Q?x7cOIZiK16qRoCWyJf9K0g592QCtapLysUmA6sX7zW6PbkJrogTtNVHG1Vk4?=
 =?us-ascii?Q?IauFwTkCeJJNHQJssTy5JzEva3G6iIsLplsO+hbX3S/KHb/dm0VgT83eaTiz?=
 =?us-ascii?Q?D5pbhmo+bQjs5+UEbLJ5/wz+/o5FTqDuAz2oFyvwcISGbbo51T+1PlPAXOkE?=
 =?us-ascii?Q?qMv51rzBk1zjlcApQ7myHk56PCCFDAzh1C5lDKXdA02wUJwFy+y6Q+l73XIc?=
 =?us-ascii?Q?l9SR2+KAYUct6rmGiy5F6+SgT2DvqAl34/TS6Nz9TGc9NFGeps/A8MvmAJ2M?=
 =?us-ascii?Q?zpZ1noIDmXkTQwySiXlUEh+QrTazilA+HB1/vqXXIKHGE/johiSqafvSHct2?=
 =?us-ascii?Q?KHxOrALeEWPdz6WQh5mbg+rSBE4Lt2jCkgoR7Ae0YxCZXSxzQG6rUUcg3+Yf?=
 =?us-ascii?Q?Rbt4H5mdnRF6T62Alq/Qegw/o9q40u+OGUCQtveZbRJ7inqfNyrmvNX6J7Ih?=
 =?us-ascii?Q?uWe7fYG0tAWxBe6CwS7mMTFoNMH3L7pjk7Dq9dnQzEVcWLJLxuPxHg8snRfd?=
 =?us-ascii?Q?1kaPLH12A5imz7fwcJDOk+ozh/SYAzu+B9XtTYcDMVJyLSsGkBaHU/pdhDiG?=
 =?us-ascii?Q?uwntsqjh4kyqBa62QGKljc7ECyyLaRDkRfmUk1pxKbhXfOmr7/edDdyNmSgU?=
 =?us-ascii?Q?X3Vr3s09RsSM968yCKjJlD8r6ql/rGz6c1pJmxxlDuQKWp950QyD56q4oFCf?=
 =?us-ascii?Q?QezukxF8OqCekqBCwKu3+P2j6P/7YKFkldyXmdeEtbS1wKfOxu8d+15UoV75?=
 =?us-ascii?Q?AgVOLg4eNvld8aAcxasZddD0XpDQV5tNMJop9jAkpldPjipAjkZ6FIBnE94Z?=
 =?us-ascii?Q?KHu5yJeET2T/tQk4T08VNxW4HWpTMI1aI7I3lnJL1zlQSQUH8o31QL/34Wfb?=
 =?us-ascii?Q?3tk99bnohWhePBJ4Q3sX0nPLK0MzSii00jmpaiJc++dAMkAXJ3rHqHciA1Mu?=
 =?us-ascii?Q?wjZQ2VtxEJnQI5lwiIkwaKoGOtog/QUZsUeKEJl1ggddxf3/wnuagpeAIBR7?=
 =?us-ascii?Q?z8lwIyaQIzHCLnuXkQU058URtWpvtCrduH4UFXXSKuUI7AmdjrlFcs5IwzeF?=
 =?us-ascii?Q?/BPJZFnUzz+vQSK4Z3M6paJx3KXMq+QEduwudaH4OLPZGxUoH2pkaP80By48?=
 =?us-ascii?Q?+aiGfVPYyTaJ3ik2pOycQGh+k8lJeRNggm3Jo9tnFvaafnM3RN1pINdaJnuD?=
 =?us-ascii?Q?GY4G29I2Te6bqWU5G5anflLYQHY3SmQAWSSFG58hn+CORKNQRa2j/4gx4lMU?=
 =?us-ascii?Q?NsqWLiLoHZVS5OagRdwjvh3hep4zUvbiBBteBGQTp8kgYmKHqqySf2ODqqJA?=
 =?us-ascii?Q?ySMPoWPKe8fSLgDdZYGABOs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XfzyfX1fEdYponQAgcd0g2JbPJfJLA6+MRNlpg0cPv3mC6K/ZLQpm1D8c4Ku?=
 =?us-ascii?Q?bJAXJZ9G9YWP8Rrf2knB0vqO9xSSIU4u3TQywHLf6RITijPFXe2XGPuLcI7j?=
 =?us-ascii?Q?7Z0omq4HXFPEJqTDToxwZD+k+XAeA900/lE9b6k0BGI0njHn4ZM+TNZKq0wo?=
 =?us-ascii?Q?D0EpeDPk4Gqxad8XaI16h12SaThf4NKeE0LWiMDCPFk0oxL07j6oFDzXw1R0?=
 =?us-ascii?Q?hNuBWWUgVurdi/RA3V35LdYcGYC6CnbYNMqnrkjMhshFFSeJ1lvICZHhtP5X?=
 =?us-ascii?Q?oKVeXYAEka4PojC0S/vb9QSGVDCNrfpXM1R0FghDeuIJOZhY5kOKFZPD4xV+?=
 =?us-ascii?Q?OFo29nYR3c60yzw99PnbcBGs96veFfX6M8lP54exg9jR0N2r1t+292xxxhij?=
 =?us-ascii?Q?/1UjnrAakTNFfs7ibRhykBGshXVVjvLCngQC4isewCuiwqMMQvKC81rvreXT?=
 =?us-ascii?Q?v7kDxzjOO4Xeyk0l8QaBooCvopCS/sMxw1WXd23WLpW6evm7juTuxY01MYXw?=
 =?us-ascii?Q?Vg0tV3czWm+klkejKM/g1puXX7sRdVeqAxekTtzuvuR/3t4ZmDd1baQy3o3D?=
 =?us-ascii?Q?kjNGQ4LIhLPZqEBaphmmcGvMysP7cw3EGGXBs83DpNQtOgDMjisGykYggfx3?=
 =?us-ascii?Q?UInTGP/yLCtP4b17dLjBIJp6Hl23OOIq9/JrUx6JqyCtg9CGgVw/Rf0k0JNd?=
 =?us-ascii?Q?dyj0qCZbTLeql8hn1PQFrBAjYXlPCA58opOPX8TYeB8H3gXD9bzdjBhPGBA8?=
 =?us-ascii?Q?x0HQ0KQnl8S5t8XYhtadcxvVcXFiTSjgTWxbsSWnUNcOiqCFXUSEb1ixN6m8?=
 =?us-ascii?Q?VS+72s5wDEDH92BOHaZSeZoDxHy/Y3mTtZXTLkREjgFCCBT4RMHW9o7StT0U?=
 =?us-ascii?Q?jSgMzG3bkTbrWHse27EULPQZOq6W176Jy+RrPW2ZWmTKzIyDZW7B+rW2ET+4?=
 =?us-ascii?Q?GZaCunEMcLT0SYPUh0//ACnLBrchyEwyRaHC36OGblWzt3IZ3QO5VsA1K+PP?=
 =?us-ascii?Q?DtV1jS06KA7SxAGCy3yyXEWuMOwVFsFiLjVWCDNV3NBj4lGK201LzxizYMq3?=
 =?us-ascii?Q?BU4PfImxKTZeIwhj5YmTuuti7t6q7jf7kZsAbnVlyf0yVH44FZGnfutuLaRm?=
 =?us-ascii?Q?ZQD+dLAru6Z8ZxKSxdjt/RyF3EmD6oLHTPl6gyzvQjUjzKaDjmSQ5UKNFFI4?=
 =?us-ascii?Q?eebzk/MvWkkiW+RpWQVBbL1FMDpqbbOVDmjfplV2JpQZY7437fHRkOge8mVk?=
 =?us-ascii?Q?YIzIoKLcWoJ5Cl6wRTfRLrmpuAZLpB1UbnZZ0kNqNUlymB/s+Ol5x6+Y3cnW?=
 =?us-ascii?Q?8Ae044WfiPK/5lwyOkDGe2NBxxAKLw1572VJYMGOT5pElwy3vXirTijiWKfd?=
 =?us-ascii?Q?+7/Gbv1Xbg6I27S1cBsuFwhENbPehMCJsD74TreSUeEcid2w8R6sUex13abn?=
 =?us-ascii?Q?PgIrfHvFGJvu5C/ft9Mh+tzbJTwfDo/I+W0BFOjI+F0hEnSazMrGSv0i+EgQ?=
 =?us-ascii?Q?jgSx88bdH3VcJwzEtpXVFg5t4DMVWemreo8yFNR2bFqXrz3AfSyi74bb7zIk?=
 =?us-ascii?Q?CyoxjTLx5qwd5gz0tCYcT6AFDfhqB7llBreXH5PRkmB38zRh5ZkByo8eoyYk?=
 =?us-ascii?Q?nYAOkupammz7yemn9pkHFTbLhcB3StBQ8b/898hzkihkyFWZxzAwCcZrBA0U?=
 =?us-ascii?Q?kJZcVinqteJ2vNj0CvtLyEMX4XhhCEGHIUPdjr+IjiTLWbAO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83de272-489c-4e4d-3c7e-08de550b4e19
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:26:57.7546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2d4r+baZ2JykeIYUhg2yM/OKuQX0BDsLN7EnQhMPTQmdsQHdEtrJQB/JZrmS7cqEyKFN4uaWhC/QBqrphFysHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11882

On Fri, Jan 16, 2026 at 03:40:23PM +0800, Wei Fang wrote:
> Since the rxq is one of the parameters of fec_enet_create_page_pool(),
> so we can get the ring size from rxq->bd.ring_size, so it is safe to
> remove the size parameter from fec_enet_create_page_pool().

Remove the size parameter from fec_enet_create_page_pool(), since
rxq->bd.ring_size already contains this information.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 2f79ef195a9e..c1786ccf0443 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -467,13 +467,13 @@ fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
>
>  static int
>  fec_enet_create_page_pool(struct fec_enet_private *fep,
> -			  struct fec_enet_priv_rx_q *rxq, int size)
> +			  struct fec_enet_priv_rx_q *rxq)
>  {
>  	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
>  	struct page_pool_params pp_params = {
>  		.order = fep->pagepool_order,
>  		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> -		.pool_size = size,
> +		.pool_size = rxq->bd.ring_size,
>  		.nid = dev_to_node(&fep->pdev->dev),
>  		.dev = &fep->pdev->dev,
>  		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
> @@ -3552,7 +3552,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
>  	rxq = fep->rx_queue[queue];
>  	bdp = rxq->bd.base;
>
> -	err = fec_enet_create_page_pool(fep, rxq, rxq->bd.ring_size);
> +	err = fec_enet_create_page_pool(fep, rxq);
>  	if (err < 0) {
>  		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
>  		return err;
> --
> 2.34.1
>

