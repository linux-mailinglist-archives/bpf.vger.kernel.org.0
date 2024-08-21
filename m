Return-Path: <bpf+bounces-37695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE7795994E
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 13:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D259283C85
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443C71E9162;
	Wed, 21 Aug 2024 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="iV+eG0rO"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2091.outbound.protection.outlook.com [40.107.223.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C72205A9F;
	Wed, 21 Aug 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233806; cv=fail; b=gjCLzc6gwrvgy6N8bpZAcNcehjA4hBH+onzr1h5io1Jq2/ZlEBMiAWmfwm8DluUW8L1zvGeanASRF7OUEc/hG1lVni8eoMYXnWvYn//3o39h/cl+w4Usi/OZfWS6OlRBz7/6e0B3TYOGcytFmp4KzgJs+gZeyHTPDfTpoxn5bMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233806; c=relaxed/simple;
	bh=pCVNYXouD+F5Wc0arB+7jXFK6R09nqRxWq9XjOpTR3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hJR2Aj8/NvPGN9SZu4da6Mia51gmZO/1jJZF+lnLZpZ0DOkMX6DutrRa3ODy/j/rLel7e8YzWiOFVkK7lKQCipvk6WsTqg6Wvmn70UJYtuiloTC7kxoar8eT2mUDBg7VdPxzNUTKo+9O6NlQ2yAmUyaUO4r6oTo8zs8GE4m4xcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=iV+eG0rO; arc=fail smtp.client-ip=40.107.223.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIr9NOIst9ML3JD9/Fz/JTU41ZzVq5r/y9Ra86k3G65yNutDgMCI+xoAfA+ElOCHET0M8vmg0qLApvHTshC2PyMHZBtvJ+YzjGEGLWwhhaWVnzPVOk+2tQgqr1lOJ7ZXUv/CJ90aEd92rCoOVNmfA+LY35EylTLwzGktcr5WB0Lm64t0ZGTIXlqulBEsMQuWUXvM79ujH+1tgHkr+iE+spUPZPXeiJnv/IzALObCTywU1YMgXC/1IxjJ2Vsz5Zaf0gVnm3IUtLP9yGSGP8u6du3W9W/BCh8FlT9B+4dDSESw+xyY2JEYNRU7WLPwSxM7l2zJhN9bq0tpUNyZx3MOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk3vS0a3g0qnRWAzrM2+RXVdvBRcgNvVcDz426T1tKU=;
 b=qpcgaXdGqRZ0lK1habk0hfBWO7PWyFnYhCiFhfHIoY1PSgr0r1Ynp4J+frylHseJbIJ+spP6zbr5erf67C4aQJMJC0rkmlTcySXei34hJhd225mreDzrYDipTeeXdP5VXcIvpQs1NezsliCvrMqf84t8T+tnKaEaQZW1CgVw1TMhAJSo2UezawNEKcEv4LSHTSbAbQFS7kTKIoBsaa9QumZjj7AWfsDsppOi5ZgBCOP92yuKcC7d4vSEtSXLsNWO9eePtQBMXrDSY27TFWmtWm9f7nZhQ5iJZXjjc1TQofCR17oFMEXIwrYVkd/66LyHoZDtInam94LwqbUYW3stdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dk3vS0a3g0qnRWAzrM2+RXVdvBRcgNvVcDz426T1tKU=;
 b=iV+eG0rOA1aCWp6a6L05BiwFcjqEE7tQvATe8/OJ5kePlNNnI71tZRZUB1W0ktJBArM7OZwEaVWNhtG6obOzA0KfqyBV1loo6HUCTE2ldhCXiRgwuJRtjhPgOQPGNBE+LfemsDabOKumkrCO9sgCbMJil/jgbHgE6Gw9GK3zcmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by SJ0PR13MB5452.namprd13.prod.outlook.com (2603:10b6:a03:421::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 09:50:02 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%4]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 09:50:01 +0000
Date: Wed, 21 Aug 2024 11:49:51 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org, oss-drivers@corigine.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] nfp: bpf: Use kmemdup_array instead of kmemdup for
 multiple allocation
Message-ID: <ZsW4P-4c4dNSFBBP@LouisNoVo>
References: <20240821081447.12430-1-yujiaoliang@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821081447.12430-1-yujiaoliang@vivo.com>
X-ClientProxiedBy: JNAP275CA0066.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::10)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|SJ0PR13MB5452:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6508a3-af7a-4bc2-1fd0-08dcc1c6a04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hyz01z3TzCOVd1lLHbKWxC28KN2KWFxbnFwxEHitN3aLZiApKfx+5MM5pCLx?=
 =?us-ascii?Q?texV1ujlgZ25fe5QZY5Pv2xntJzEHGGpcKz92OtbfXqSHrSgYqyw7DMkjzLF?=
 =?us-ascii?Q?qE27H/RWni5QvMZfaKGu6SEqmkwcQeS4YUIma2OHs/Hlmy7Ow66sBvTEVF7T?=
 =?us-ascii?Q?cPLv3Cm1JE5v1wajXd4x6JRvfMxIkTWKYv8vkuEhUVfZOOdx2Ynuj2TnxZEx?=
 =?us-ascii?Q?IISYsjs0h62sBI/Vkw3GUag0M+P80rLjflkjzuA+Baxi4KkNGyuisJI5xXhH?=
 =?us-ascii?Q?mlctJJ7Z+cNSbJdgitmDPij0JNXojlCg4ezXNx3wKjniLS8J+YnMIfVPXUAJ?=
 =?us-ascii?Q?HuPRLTsinNf9gGLSxmTLNCsXs0AYxdsVVbiP0z28/LMbhMGT5+sQ/2u0yo5t?=
 =?us-ascii?Q?WYFxzJzJYy9PqRfr+VLxQ7Ck1gdhd3fmxUwCIFmIJzJcnS8GtEPkG/0rY09h?=
 =?us-ascii?Q?l2oeHnU/b9I2Sgc3gWla4k7mJ6k3BnYM2bBJogB7KO24xyReldP8NpU+9WRG?=
 =?us-ascii?Q?2chTk66f8DfCfq+VApOLsV76fwjSuceIsuRSLi1z4bhdOrg64dHEWRMdAMw2?=
 =?us-ascii?Q?HJU3mpjeVfFf6uJG0P38UQ6nouBJ9V9Xo1l1J/UOlL0Xg5Yc4BPZuM1wjMYs?=
 =?us-ascii?Q?lkXa4C/qQ4Pls1e5E8Yl9DPtU2qkiyVw0IHEeNTNjctOs+98TQL28ztoeDFo?=
 =?us-ascii?Q?omLTfzfhtTkQEo7lgM/sFAySth5eWY7Ko6ZIB88KyP0AlhPryYaAsybaykC0?=
 =?us-ascii?Q?meE1m4CNJKr1kZtENgX8q08gsFEJuf5JqtNMFj6ElNNmB9C09F/9gLV0wXNP?=
 =?us-ascii?Q?MSxbLEdtoKJU2oLqVvCUTUczcz4AN+B9c9UNYJpC4g4INaSzQ4+plaD1YWdp?=
 =?us-ascii?Q?a5PmUJ6jTQE6rC19xopg2Xkys4kOYdqIcJleJFrbVZEbn4QR96qtmkqNCTpl?=
 =?us-ascii?Q?8XojJ8Du7Njv+qOkWxBzkZ1SQo5OEjU0qtxkepmLEziFicK0sPfMPXLzQ+/l?=
 =?us-ascii?Q?88Sik4etofRZZKjI8hn7RyIOvD20qszEv7qpKGdU96UjbWDzQBVey6NKH0dn?=
 =?us-ascii?Q?LZtzoJcYBDsRaQUxt1bGiuMa9LiwPxRg1XL067eFMDSyYceCvdUZ4tlgC66u?=
 =?us-ascii?Q?/rtKxj0W/LTauzWdz1OGyA2K4o21rO4bzmFsb4ZTACi1QvAVoo+3fUOpemX2?=
 =?us-ascii?Q?9flmesGc0yTYjoCR6TOmLjrS+Z4DDQdFGV2QzbRIo6R7H0iLGef/CgjRYxdA?=
 =?us-ascii?Q?sL58ID9tXxiKSi/hRtkHpsdOFcyfoqiVDVGPFf8AZo8bNeejBWZj6XyhI2vU?=
 =?us-ascii?Q?msE2oZI5qCCfQO0yGXvk7PPQiE0NRhVKgnJNOvOK2gyfLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gDbghf84h6SuRcIz+awUTGYVGTdiSdjFzdspWQTL1acQKB5XLGVMXq8Th+ly?=
 =?us-ascii?Q?oXdR6u2Wln1NxkGNHmNz8ggO5ks6fEDVORrhI2jPd2DiP2+yZgPQKlXxQv1N?=
 =?us-ascii?Q?hRkrCsWLkSrgSmxD4m5H3Sv0aXDFqvXKKbK/tw0+3Ynjhi+fi5zesKfLtn0Y?=
 =?us-ascii?Q?Gx310UFlVYKg2jyu67JHgEZWSejlM9NNq24829dSs5Ti/dI/3Zo9ZjeIh83i?=
 =?us-ascii?Q?M5TSGX2QdQIVWElJ6O749liliVAu1P1lwCrX1aq3F4/2ev7KrYGt39ayLdJU?=
 =?us-ascii?Q?0yPQwCZqiBo8QYrGgJIyNrhEOoYP4gXJBZhwmeKeiT4XOTVhp+/8da0Adqyd?=
 =?us-ascii?Q?E+vW++/zMqxRCoTvWmypxF4Mg/BP/3n+aDgm/hHl178vDNK6ZhRDv1n/zrHy?=
 =?us-ascii?Q?AMVKmJTDDd+TnwWw8vc/kEfQW4YTGISY5Hb8X0PcGSbg7l8zBDm+Z0PHPM1A?=
 =?us-ascii?Q?hKLTShiBz58y2mfKXMhPAd0DQegsl4NRS7N+tIyxssFecN+bFhr7zIB6/LHo?=
 =?us-ascii?Q?I21EyUp37FDCSUidXLqJMz5dpaZMh6lkPCfKEwYfTMQ2lc9Zv0XHs8NW94jl?=
 =?us-ascii?Q?GKAWX45INwee03Mb/9LUWwiU9fPp0H76yQ4SYLFPir+8cUsqhIVSSd+MD100?=
 =?us-ascii?Q?5i2DooPSP38Ca/5fdFoxMahXMwfaNYJlCvZcXoP+dOfb3xhKSLaPUBxfXOns?=
 =?us-ascii?Q?UlSsKC/z+SCl3ES7VOpnfff8hbMStLBs2BWcPRGrnFie75DC8chL12h2f3lY?=
 =?us-ascii?Q?Z7xvdXjo2oR7E+hYS4bajkAj9FgNDXiCeKPx6AvFMkkTh9iEe3GF/WBhZ6Z9?=
 =?us-ascii?Q?thLuYTSZeyqkqqxVhyb+ADEtlCViHAscQzGr3F2W/LD7nrJXtedkcc/UTu11?=
 =?us-ascii?Q?vlso7TXGteCQ5NUz18laQzFpX0GDbppiscUWPkUhqlocJH7aGQkGXIV1kHpN?=
 =?us-ascii?Q?46YNBDRPt2LOt5rtPQqrIaBs2KhODU2vTkNlRTk9Wsm0IJsjOOGPm3As+ifv?=
 =?us-ascii?Q?5As3lKhuKxkTapxoIdeibyNoWdnlWORPJ2UtzvejzMEpoIX/UFgjFA3TrKv3?=
 =?us-ascii?Q?0VuybkpinriZVCgPWZhEK6r42d/kdKAM0fFVcsXFAeLWEooOw+YHWIk/s/dG?=
 =?us-ascii?Q?xUXAI5kcYUuGLbQGVD3U5m+Zml3Q5dvRlnW4+6khBYabtW0UPh4rQ4uGjViz?=
 =?us-ascii?Q?ZTHdCu9maOQmpQuKK627rIPxhgUeaHl1ecH96kznt6iTMIsSGlh4oYD4ZwvS?=
 =?us-ascii?Q?cicO9NS+X3TJ/5cTE7Uo6B5pv9ImwTRHt7uB/fLu1DHZ1rVI9Kbm7teLKIM5?=
 =?us-ascii?Q?IF/B+dAB2S21uQAMWzCPfx1/A8WgVG2stC1dcCJQI1AXypp2JbA/yy+KSE4C?=
 =?us-ascii?Q?c1etkrcWEe7FzfD61q/qrtoQOmVlmGeEFsS645GLcIrLDHiqGItj/h+xGDTV?=
 =?us-ascii?Q?R9q3HJAbvpsUBE5A1MgEEJTgIEdcQQu0Fptmoeucpfgnf/L8WS1lwqI0PmIv?=
 =?us-ascii?Q?2dYXjt38UpRGMBS8iLkwH2hdtPSPJ9LsPcxFmc4N313h0tXhIIEFZ74wgu4O?=
 =?us-ascii?Q?b5HPUxZxxtViM7t6PA32Zw7JYBhxVLx0cr91zpQDWx3KdwK+uA6IG3ssXfHn?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6508a3-af7a-4bc2-1fd0-08dcc1c6a04d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:50:01.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRHgKA6jgA2wfcf4qY3d3xd+bZKmMll8nZKKnprk9utrTd2zD/iAPxZC97f1txJP0FrIOvdG6meDMG+ESyzafYZGWklLB08qXcw3uo9Afm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5452

On Wed, Aug 21, 2024 at 04:14:45PM +0800, Yu Jiaoliang wrote:
> [Some people who received this message don't often get email from yujiaoliang@vivo.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> ---
>  drivers/net/ethernet/netronome/nfp/bpf/jit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> index df2ab5cbd49b..3a02eef58cc6 100644
> --- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> +++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> @@ -4537,8 +4537,8 @@ void *nfp_bpf_relo_for_vnic(struct nfp_prog *nfp_prog, struct nfp_bpf_vnic *bv)
>         u64 *prog;
>         int err;
> 
> -       prog = kmemdup(nfp_prog->prog, nfp_prog->prog_len * sizeof(u64),
> -                      GFP_KERNEL);
> +       prog = kmemdup_array(nfp_prog->prog, nfp_prog->prog_len, sizeof(u64),
> +                            GFP_KERNEL);
>         if (!prog)
>                 return ERR_PTR(-ENOMEM);
> 
> --
Hi, thanks for the cleanup, looks good to me.

Signed-off-by: Louis Peens <louis.peens@corigine.com>

