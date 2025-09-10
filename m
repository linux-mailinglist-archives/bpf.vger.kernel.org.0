Return-Path: <bpf+bounces-68031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB0B51D90
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 18:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF59171B98
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26EE335BC5;
	Wed, 10 Sep 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C6EP4p06"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B5334383;
	Wed, 10 Sep 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521471; cv=fail; b=BRxio5eZQSxNZXDXS81cUwZ1eD/QeO9iKZJvRF1oajNE5Rz50zYSyeUKb51D5FuXUjWOQ+amnUgbkBedL+xlHeFFhp3MO1VF2ykKIn0sxqDSS+gjszQKgdteKZ0KWOB2DkxOpjUu/GfTMYmtJ5eqna0kDlTXxDkjXJIDz729EUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521471; c=relaxed/simple;
	bh=E0s3rl7V770k8mFVzgCsm6pwAO8we6LeZdqLNCmz5R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QNWsKCqIJKhcAIhCDJyKb1GJGnGBl8tEEs93k/aZJ9E+PnpBdBBdCvCS49267wt5rSCiz+Z/0IqJvZOoipD86hsbNwbdpQ5RHrcP+G9F7AsWQ3AWYs+FjyPJ2Rqqtt9Xasre3djkPZnrcA0fEhrLzJsot2jANmi+oLkfmYf8Cuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C6EP4p06; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neAR6T9s/293A5SNcpqMO3w1Pgnb1PM/BdksBYBVwVXoftex585LN6St/NlRWcF4FSvZRv8aGLQIlKaOKB1SeUv+nyHP0MxifA8s+vt0ah0Gvnz6VVmXk4ZSmuFXywhUmwHNYpq51+5aYflso/e2cEv1hByYIef2CC8e29By5cau3zj1GGvNL8+RDrpQH4SuD4vtr/TMDRvzpqmvgXrW+jno7RJ4QDlE3HMW9/utwVf+qjVEESAXCKcPDUFS/s2soKFV0btd5LNOK/an3BqGMG/2bw/3tehuS3wD8c4M/x0oyrH1T/JIDPuwLYS/T6Ivbs2XcM5s87yv7cZBncRYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3W9npK3djVla+Ad5wKOrlAVsX2c2qu/CSWnxi7FWes=;
 b=wpy96FInxuSE3+XBazVAyPClmh37sdNqUdaLtqmvvWCG77yaQsCv7QclNxzvU9tVuJrs4n823EsRkmNYOB9vzdw1Aga+3Q+sgWSaYZOeuAI9W5cR8igdfrLiZDWL0H28Xue2k1JF9hfV2Y+DNyCLkqvCdoHmRYnz+S7LXI7RtPov7iMnI9y04wkhHBPaaARyJ0veg0m5pKksbR8/sbjtYNloxMc3tf7XCoFnf9lMtg9xFXRYqicd59ET9Pq4MlVpE8rs8RCmVBmqxT59zLMy/t0QYqna7x/6dmZ49o/cVB9pBflbokLonAvTeitJFN9fQ07cTCBUvJS1+cEgb7316w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3W9npK3djVla+Ad5wKOrlAVsX2c2qu/CSWnxi7FWes=;
 b=C6EP4p060dtt7gZ2OuJMsOD/iBKV+jD9/uX6latRo1lKeugFmMBbXxQ7G3kVf8Dzmy8Vf09xa74hQJnlgfAgKPeksQZ4bwPcTIUr7IDpy1Aw6lvK8pjyMY8sd2BmUOmbg+nUpbu1UmhRw53XaPDlOxoXNz/NHtopIHnl7lzpj5hWvLXZhYoD+8nisYEqjHuLWv8U7zaR8pdmIIJZn0JxFGf3u/n3f9PCICImmsKlZfd47R8wpmImORELi0DkG464DGMqX4vr/cmPXPl99TSxj6xKmoWBWQrNdeIHd+xGw0Hgnfv4seD+EDadOEEjDdfoirMR2avNO+rhog35MEKT1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 16:24:27 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 16:24:27 +0000
Date: Wed, 10 Sep 2025 16:23:56 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, kuba@kernel.org, martin.lau@kernel.org, 
	noren@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	cpaasch@openai.com, kernel-team@meta.com
Subject: Re: [PATCH net v1 1/2] net/mlx5e: RX, Fix generating skb from
 non-linear xdp_buff for legacy RQ
Message-ID: <x4b26sfgbwuxodwbkk5gl5ohczmalycr3qxo2xwctiygzvvydh@fu26veserybx>
References: <20250910034103.650342-1-ameryhung@gmail.com>
 <20250910034103.650342-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910034103.650342-2-ameryhung@gmail.com>
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 518d50f6-6865-4a67-7405-08ddf0868303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d3mSEoEhim0bDmUYiXl504cgzVadFe3hoasLxEAhtkQWPzfj9ipFHU52/+Hi?=
 =?us-ascii?Q?FFzh9MZ+xRZyip9jO4kt3e1Gna4tF+1xWf+XDVQh563qzPYLh2IQ8pS6KuUv?=
 =?us-ascii?Q?yBWlGVsZAmAsSEBeCSXIdQEN07WfOWyLdhFlLiRn/0eE6/YkCDCtp8hzDmMI?=
 =?us-ascii?Q?q2caA4he4rNnQoi8s6DI9NS3LgIQDnqRenOGk1y117ky5SAIRHu2UDcd9hMg?=
 =?us-ascii?Q?kozH1L9vbdtgXF+d1HJpV0pWgkKpfoB9r86GNj/uoAi9ebyfW8QEBMifHVNn?=
 =?us-ascii?Q?bMfxoq/crW0BtwP+R7erIo/w7hzaFxDs+1fbBzVdhOA9xn029OFG5EhlAUP8?=
 =?us-ascii?Q?IXuLvfL+sU0zZf7QcaajkbEkYUHcR9Ggus49viIWjfhugtUq7jYwLUqpBt4x?=
 =?us-ascii?Q?3jOlGPZ+vjo9wgXC+MUzRA1AZpfI1ud/kY7q+RQOemw7bPpTsD1EUKfqhX2p?=
 =?us-ascii?Q?2T37ESdRA06mQ0ZOdAMZ4XSwY3KR/g7ff/g6VlxCrC7+3tynDW+iQ4vFMGtY?=
 =?us-ascii?Q?RaBR+i4/pY02Y3qTXup6dK21gv07ItvqJ8ATu53f6B2h+awLbkqrKiKicDUq?=
 =?us-ascii?Q?X3PbudqlM+ucApPmssJLZTqX3RrPwoLf+yBtU5bLJOyR13c2zXQQYIaN2rw+?=
 =?us-ascii?Q?SkyVNizenwAt+JRJz0I4EX9r7JTkBukM9y1xLEwmKszH5z6+g08fndIdY39v?=
 =?us-ascii?Q?v6Oz0VTdZfWAJfK9Mu0ODMmMbYqvt2VlvkALfl4RKAkPLZK79SxA40Q8P/pl?=
 =?us-ascii?Q?4OTuBCUsE7oRcLEiSa4VNvqKBadWURToxVJ4gUrivfzK/NLHLGCrWzSiEjK0?=
 =?us-ascii?Q?pa8ygGlDPoa2owEtzGhR7ZDdgGwuqsQbxrbPC81HvrxlkoIBt+IUaeb6qi5o?=
 =?us-ascii?Q?QnAvrRY1dw6t8f8vboOWkmg+B2JatYqlXGH3fC3fz/bLtGukp65jN+k4MpPT?=
 =?us-ascii?Q?0TLeR9P5FLVdcehCc1wAA1tgidD33+aoR+5GY2G/jPzkJgOJko8zakqsWtzE?=
 =?us-ascii?Q?P1mDJhR5oKDnbDGI/KZaFckR/wo2ZWcTezAic94FXUiyrCSmN6IN7hjIgohy?=
 =?us-ascii?Q?6XjMHVIhQvD4sSnVoBFSjgivHdtSwPBGkIpjukJlVUIRs+nE5RIFgvPXEf1R?=
 =?us-ascii?Q?9nDdVQrCsTpggYWgOn/8/Et4EnV2aEArbXK0Fk7/VhDoOZDIrSM/3AHQAiwf?=
 =?us-ascii?Q?DqEeU/823mF3dtJ1qQEsV172bZyFugKqvJ/KlQySebP3bLKgW4Fz5NzufqWf?=
 =?us-ascii?Q?Azuqqgd2FdkQ9iH95NliAEsCqrnL8ib1SGQfoPGZ9PpSmh8a+WwlGvafO9j2?=
 =?us-ascii?Q?X9LwptF5p++hPq9NO3AiBVjJo6ySqqjjRnO/hflDbAUoRbLj6nmgXePsPXUj?=
 =?us-ascii?Q?+tkQsSxFQI8jppzdEr+trw7/AWcVahYc1Hh3MJOSjjeqlBkXMk76UBUGSOxc?=
 =?us-ascii?Q?rC/j7U/smt8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IInPwQ7RCh8SULgxRVf7R6Q9D6FhEyIlL0w2fCEDHl68UnxvQywTDDNTFmnK?=
 =?us-ascii?Q?pJ9eccSUz4afRL5U/nzm4FJxHiVzbfykSGmiA9Xfgtk8FOyW5kW3ygUg8RxM?=
 =?us-ascii?Q?9ZbYHxmC0pJriv0h5CTli3psftVx6WNg/bvENBTHLm6lz08QiZub4NhrNK0N?=
 =?us-ascii?Q?PRw7RvNG0JB/j18n9/+sFrm+kk0zLKBaut3B3f8bUF63xxoQa2ekBvxNkfzU?=
 =?us-ascii?Q?NYR00lkSXjdYDX9VALkIBJ9eGaoJRsd09sJeybSi5vwciCBjO0sUsVJiPeTA?=
 =?us-ascii?Q?PJy1UrsYhDoVnt9JpL93NczMVCLVF41Z0byDnHFUW0trSs6WWkimCC8hswYh?=
 =?us-ascii?Q?Q7kXWaXx3NiCeYziP5pJjkcxNunsehiFyRgd/TNlIrrs43PB9+EmHpQlM7QJ?=
 =?us-ascii?Q?3dM5nbSI19Yuw4hkUxZF2hEsfUPwV1SseL3vA6s7I5OuchwhcetSKKszf9i4?=
 =?us-ascii?Q?GOqUDJkiFsSYoZzCE6OnwJavhlMmSsVKysCUt7ZxayihhMsqPVNDyS/dxvQt?=
 =?us-ascii?Q?Ib1mKLAaxSFBzYcCUIP/NuikWKwko570hp2Te5Oz/HnOYi+C3UrGXFRseWx8?=
 =?us-ascii?Q?ukKWe3ttxSbiFgjgFj8bd/vHGNx05q66biMS915Q1VRbCXEZbZptpHLhyvLo?=
 =?us-ascii?Q?d5+R6T7dZiMpMrCbe30bUPsUHFg9BGxH3EfOuSLgybu3nGRsrETX8jqJ1a6O?=
 =?us-ascii?Q?BSxCbafmQPRKjoKrs27RlPCUQxaaXUyQD7Ceg5sELYxDUbwWiAtLzf2Al+um?=
 =?us-ascii?Q?idhQpGEWeudWMoOBV5kk2LTaQ8jGxzX3ody/3Q2Pf/uRkH6v7UsAMs+20cZt?=
 =?us-ascii?Q?HecooUJRjOJPnTqCyqC/9QYPInpUp+VUPD5pUlYJlpXsTErdz7qbsSmnzBTW?=
 =?us-ascii?Q?jvO/P7ySXu1Y/ex6sCsY1G3Gm6B6JmoN4/FU2Y5wOgx/4MZE9RA9GZRdUDE3?=
 =?us-ascii?Q?PnKyM2aSEhbV4jHieGGrMoATr5RF/f3+jbmLZ4v7GbAsPNgcfI3A4op1Cc+9?=
 =?us-ascii?Q?gqgzZDrMnKA9NGNEsM8tpvqH61V+eORqa26rBhRwaXC7jFtMJI+3BGEOVj8R?=
 =?us-ascii?Q?2o6GQdjkdbhKQKJ/yBOl4Cm62G8iIgG6dBZUtbDJzVRKEXc4ZprlXuWBebei?=
 =?us-ascii?Q?b7Ut4pJ0x8KpYBrgXPra5J+tWVC/PhfkkIRXwsyz7ikSJWjhb0P6KjBFMETw?=
 =?us-ascii?Q?OudxyL+NyS5inf2owEul85L92Rp+l2FTZ8uBwt4MFCzYwzs/HMvvFQl3WbTz?=
 =?us-ascii?Q?asv3+nXzzgv4fya9mtPirDKKzAGVXLjCI1LqE6QoBylFc1T9m2kNtNXSYSmH?=
 =?us-ascii?Q?8/f7d7+XBhfsnNy18NhV38/OpNP+40X4mgRLb88mpCIhsDzUsoadl3ux3g6f?=
 =?us-ascii?Q?YxeLXosyW3+V70mcvJD7znVqKvflVYpjB1K01YDZbcxQTfOwp8wsTDDBKjq8?=
 =?us-ascii?Q?1wwif8upwyaNZccxdWhiInZP48fmfi6RP3Ede+/7MoeDXeGpWuQPMgTXn3Yq?=
 =?us-ascii?Q?PWOmb/+FtAe166q3CwOC/9zgd5mxFXbl90L1vqZZ5teHX1AfCflvblDFGhBB?=
 =?us-ascii?Q?1SqLPtqoWv+0OWeJCEh4oFFbjykH8DDXlQt9Pmr3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518d50f6-6865-4a67-7405-08ddf0868303
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 16:24:27.5549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CT2Ph9VS271IZ3Qt4ywNC6F2uullq6jsZllkqY8HJ/22T2cH+9znr01nC8mk3NPn6moigjoa05Jvj++aw6rpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

On Tue, Sep 09, 2025 at 08:41:02PM -0700, Amery Hung wrote:
> XDP programs can release xdp_buff fragments when calling
> bpf_xdp_adjust_tail(). The driver currently assumes the number of
> fragments to be unchanged and may generate skb with wrong truesize or
> containing invalid frags. Fix the bug by generating skb according to
> xdp_buff after the XDP program runs.
> 
> Fixes: ea5d49bdae8b ("net/mlx5e: Add XDP multi buffer support to the non-linear legacy RQ")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index b8c609d91d11..1d3eacfd0325 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1729,6 +1729,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
>  	struct mlx5e_wqe_frag_info *head_wi = wi;
>  	u16 rx_headroom = rq->buff.headroom;
>  	struct mlx5e_frag_page *frag_page;
> +	u8 nr_frags_free, old_nr_frags;
>  	struct skb_shared_info *sinfo;
>  	u32 frag_consumed_bytes;
>  	struct bpf_prog *prog;
> @@ -1772,17 +1773,25 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
>  		wi++;
>  	}
>  
> +	old_nr_frags = sinfo->nr_frags;
> +
>  	prog = rcu_dereference(rq->xdp_prog);
>  	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
>  		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
>  			struct mlx5e_wqe_frag_info *pwi;
>  
> +			wi -= old_nr_frags - sinfo->nr_frags;
> +
>  			for (pwi = head_wi; pwi < wi; pwi++)
>  				pwi->frag_page->frags++;
>  		}
>  		return NULL; /* page/packet was consumed by XDP */
>  	}
>  
> +	nr_frags_free = old_nr_frags - sinfo->nr_frags;
Just double checking that my understanding is correct:
bpf_xdp_adjust_tail() can increase the tail only up to fragment limit,
right? So this operation can always be >= 0.

If yes:
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
 
Thanks,
Dragos

