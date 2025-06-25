Return-Path: <bpf+bounces-61509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB550AE806E
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 12:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724345A60B2
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651992BE7D2;
	Wed, 25 Jun 2025 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nAodhF0x"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476702222CC;
	Wed, 25 Jun 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849041; cv=fail; b=G7BFbnWfKNd1HwKsky+mei2YIUzudM213V6ecEzwPYktovabIgUmLdw98Tj6dieWlPSXpoSzrakikFQg3tus96PxSjl6ka2pyai3vvb11rHJOEKw3HKveCqV4KG5fYw/fBBI2FlcGpJma2EyZV5J1HaWJeEzs7LqwSb7NJbOkxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849041; c=relaxed/simple;
	bh=c9jhgg45SdHyrRsk3vvFRgnSuEpKJh4CFydUYSjap0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XqmEVQiJOXirlaSP4RGzvOQLIobd8hD7PZJfiSVk78RcBrxwcPojMHACSoSXhW/mly4mPWzAUPyt1/mqiSB3UveQMdoYOScT/Iana8BtHTfItArnG+rV/ivsZPrwlDzbfQwhEVhO3oATZ4AOAH6qHS+3kWz409OX7qpLkiwdDWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nAodhF0x; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEVIRyFLFfQ5p4/IpsCgAM5zNsf6dIzU2xUSLQRtXcqFR96lPdpyEyzgX50qYG++SxfuLNQgZPsQVAuxMTNnvYuvL/KvvabxD1PJC8nGmJ2RLKimGVgULSB05w3WwNgCkkwJcVceeT5QFE9btrF2D2FNsYkyrSZ4Ys55fbs9kH6vjMSZuqI9Lb7iFGpN9WcdH+O+iTgDS15TjJZAL/R0XkS0XBaIkF1HaorNr/jCvdtARy+VLvDrwOYCp6qEcHBuJe9oDBriroHhMus+MPt0qGh5i8081cCxhCB/b1ZUvAbp8p72p7Tjm8eEmjWB3bABjWX04cOCKEcr3nwXP4zkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tyn5iakM2qct1yBEPm+g0MiEI23E4wQYGlYe8wPQS4k=;
 b=o8E7J8GAc6wSKEae5Q6mW17KugUb/BK/xEOSgIPlOa8xe5ge6+ifViMdmY5x9a79Q8J1hmO/R839Z5yr66bRDU64hdV8JbTbmaxaetWKnDeQErasihmedPQDhSphiOgyUYMn3hRXheoCUFRWTdZlzYv2QYBkULjcCLNOTqVkSH+85hMGD2bvRDDti8zUP/yYWwxMfNzxFROhmIpCKJxYKZZdjHuX+0z5udXkLdlByg+bu7C0R2C4W4k7vtPPxTkq9Of3UrubCDGqySHoyU3ZHj2E/0RGkhVFa3GPCVPOy0U7byW3hp+X1zR1S5YzdN1DrP3XorhwdqREaxchnkk4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tyn5iakM2qct1yBEPm+g0MiEI23E4wQYGlYe8wPQS4k=;
 b=nAodhF0xkC18vlWsWiZp/KPI7piC0t5P3CCRMPze/KMhfY80T3Tn24bKj7YCUy+AIC4wGzV1MfFevL7LSXukylmvlM28n+wGQg5k+xTJ3paT7mtQT6GcslOj4dePCamZJvIDn5bMcCt3q4G3ghAJVBpRMyf8c2UCZewFqo3L4+w4GTkZz3TOj4rEGCPSqr4CBLxNTqO4dh8cALyZLG9lW5W95QZi3D5fRlYaJpP7cE+OE+Oi8GYMeQVmCCsbPshZ6tmDOMXx+cRZjzmR2cujjR4aTO6oM8WgR8TK2gx5YyaMnzFuMU3RkkxW97fVEndLA82bg6e+uAOY+quABLsVAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 10:57:14 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.027; Wed, 25 Jun 2025
 10:57:14 +0000
Date: Wed, 25 Jun 2025 10:57:02 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, 
	Mark Bloch <mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, 
	tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v6 12/12] net/mlx5e: Add TX support for netmems
Message-ID: <3j6v2krnzsu2neobjo2xka2bny6ee6aibpehpgnhwpfsgdxgei@375vg6k6abpd>
References: <20250616141441.1243044-1-mbloch@nvidia.com>
 <20250616141441.1243044-13-mbloch@nvidia.com>
 <aFM6r9kFHeTdj-25@mini-arch>
 <q7ed7rgg4uakhcc3wjxz3y6qzrvc3mhrdcpljlwfsa2a7u3sgn@6f2ronq35nee>
 <CAHS8izM-9vystQMRZrcCmjnT6N6KyqTU0QkFMJGU7GGLKKq87g@mail.gmail.com>
 <xguqgmau25gnejtfrgx3szhneacyg2cjj6vlsi5g7fouyn2s43@nemy5ewelqrh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xguqgmau25gnejtfrgx3szhneacyg2cjj6vlsi5g7fouyn2s43@nemy5ewelqrh>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd3960e-2106-4779-8ea0-08ddb3d70b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hjbwB0TeG1N5Nibefm6JzmBNGY/ymM6csE5kObEMw41Pf4HdutWWobjKd4ja?=
 =?us-ascii?Q?+rWmTBCfPCX0H6SWMxcOzwzWO/0qcoS7BKZRBmjfurL4MAoauifcJ6y/s0QB?=
 =?us-ascii?Q?F01wvqjMF036N/FdLyxjsJARa9fSABtdF9u8PLdumRAV+vN3/tWYZuWmNaZC?=
 =?us-ascii?Q?cyuw8a69AShj2Nspk5QqS66JBhG7317EjOl/UgcGIh3P1dDUqhK+fyPF9zUW?=
 =?us-ascii?Q?NbGKeumkIiRWkgidcCip+FCW36IqJGLB5/bIrhVl0JYS44ADynI7VEe5huIP?=
 =?us-ascii?Q?sRc0X/SbWRus+jTnAc0VAllKgyUJKQLMgVdzHStNkgIUT6FniK5KB8+9nRP3?=
 =?us-ascii?Q?oKOzvQyUtkbZ58p3YB41RoLAgEZn07guBDylbH7tGM4V9VMASMVdz14cAYW9?=
 =?us-ascii?Q?pjgJUfqJjGiDfcdH1/3mbWI//etqJHPehmCWi0s5HeyoIJ4gDfll0bvENRir?=
 =?us-ascii?Q?3W69PU6ddrWfpnNUzgVB5s0lxxDqSsuyrCEJIrfWqhM5uPNX7H4rwQntVA+k?=
 =?us-ascii?Q?TYqwUOVqOzxhapPS3WMzMQATIRpdnyd098P03zJghL9MNNiwkj8d1JRBhsfN?=
 =?us-ascii?Q?Fsqt/GVB2Vne8ONyLHqGIuvkkQ0RPUtzHXte+2fhbho92P3mYiEeAizhlUg4?=
 =?us-ascii?Q?17nH7GvjPstzZxfwN6ZzEP4Gt8O58IfwonKHYDgunLWGTLtyNqK2iwPj/GIn?=
 =?us-ascii?Q?xH8kineMdn2Kefg2Pw31AizJG1M+T2sdFldwfYvh0eUh9b9eNUDnmu0t99oF?=
 =?us-ascii?Q?Pr2FVYh3oqvrgKJmLs+GUN8zQ2qUQ3msrd0IO2o5zujlm9l5BGVXpRmXKISZ?=
 =?us-ascii?Q?j25Tt5/EhBHQoKrZ555aUIDIL43h0GmSwD0U74RZBqz/qOQ9QzfP2VeBjCJi?=
 =?us-ascii?Q?x5P6CM1cAZ1OY6nOHEb9J14YWo+xvYK64OHIOdMPn47zzFXDeEGl/1GIwLRe?=
 =?us-ascii?Q?O7FymDj+qWqkndOGjK+F+WJGml5Z4Q+LAe8U50XEu9vr4KP+5pBeZZlvwJAP?=
 =?us-ascii?Q?9M1UWZ0BRk1boU8AMyGENMtSP3Qnh76ckaIH2/Zsen51oshnK72hSkmb+99x?=
 =?us-ascii?Q?tCs9SkjHV+5gT3M1/ZZSUdh7ivMdXPfNEjzakTlf8uxaaX1wJwwpbH4O0OkE?=
 =?us-ascii?Q?9PO/RKbSISOffuMtPAZevvD9vQ4Iarx+vkyxL8YlA7iSpsuB6LI/iV5XaPj8?=
 =?us-ascii?Q?Q1w/BecuRddI+CJVH9BlgH3Im0C/5FVbnxnOnJFvJ3hnoxYZlVkox9cGZOyI?=
 =?us-ascii?Q?FdKmvwGQRohAs7of6VybeqFuexh6SFXMkr/umq2nmlGT6GwhvDKLWGV3iich?=
 =?us-ascii?Q?+sjBlKW1vZ24k4ykjwkcQVZdLLEzva/GX2AH6KVhhUaxALxr80F4KXFkRvpK?=
 =?us-ascii?Q?XiWzquR+b5miQqfN58f4M0B3Xd+8otS9HoJaV22DT5ZjdY4eIIKW5tLIzgof?=
 =?us-ascii?Q?wSA4nUF2AsY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?93dczzUN3Bw6HcEn2pMyScS8ke0DhKZYSRL8hpqu3lrd6D3QW+2Bhm0+08gT?=
 =?us-ascii?Q?p8apfcS8mK/tCQ+0R6ITYhofhDw6etoCwW+tGYaTUoy9nJ+mmtrWxyW8UWuS?=
 =?us-ascii?Q?kZF+ykC/L8AQxNhh+ZZEWCzogg4rHL+rZKxfQx5hyVXKI8BmbXBLX2fAUVuh?=
 =?us-ascii?Q?N9w39lzrIBBIMhNkQzxvbUn3MH/PhqFkaBcun5vsKFHQYnRyfCMAqLgE046X?=
 =?us-ascii?Q?l7HGnp5eEo5c4Pb69Wk1o6AGIIC+s8YeGUujdloQVEEY6Z/pCJqjjKgr+kcZ?=
 =?us-ascii?Q?oBzzccQctyQIRNOdfK0Fq/4OgKR2x9l076TkeHlEkYm/zQ2lsI7AcTOfyfhB?=
 =?us-ascii?Q?3Tq1uCSn71bh9AXGP2/24RkU9FLhMeE0jsDoL4HC026cN5XRl+NJe4e7kVMw?=
 =?us-ascii?Q?tcBFS7jPIoU7T8GxoRj/jXmYDuzXXbQmPPW1ID3dSRHQGV6eAsDnTsso1SVm?=
 =?us-ascii?Q?/9vg1QLcMTpPrO0pGNGVqeH5YBa/Ps/RHURRMoTkEAJgZh/fktok/vH96dKl?=
 =?us-ascii?Q?k4C0/mhpuRG3LqRlPbv7K1USK7gFtitlUm1/kimLljPnoO1N11gR05QfonBd?=
 =?us-ascii?Q?JXnl4oseHAoX3Sy1wq/tz92Z/vmb5Xho9dqq2yrwZ9D10DOwWkn2P77plF52?=
 =?us-ascii?Q?Ba6lv2/voZ3NxjwGDyiFVUOf0eLG8LAlIfxVoHqoV7a04JOqImcbasuYLfbQ?=
 =?us-ascii?Q?AokBphxRBtd7YS4FY2oUsR8erMHYDGG26HHYgdHuuvmKok4ljHVIQbp6vs/x?=
 =?us-ascii?Q?CokK1Y+USyQc1Pr/TUaAZLtyiPs3cAqVWvTqovmq9T9SMd5fS/ChtgPGYqen?=
 =?us-ascii?Q?ZRNsnTr9XmBzzuA9dbn411vGMdxfPEHe2d84KIjKKTPOmXQVEXrLXolneuzY?=
 =?us-ascii?Q?e0piP+psmn1NjZrCacLohSazGfehPTgWdlUKtOrPP9J3YEsuDLq9YInfA0Gf?=
 =?us-ascii?Q?TqpavSPOzKlROeFw74V4aYyRbB2nP2+AT/ljmm9k6UMdEWGHa5yA3kgBpkpc?=
 =?us-ascii?Q?0WiRvukmwoj+/50nQG5lMgI8Bx531tBkTt1la8x8KI2sTfnFts1fT3sToJC+?=
 =?us-ascii?Q?2ykLt412Zt/2xDCg99omlWptD5iZ5DPUjEYpeo4Hi5bacfbfbY2GrV4Vd//h?=
 =?us-ascii?Q?BtoHXEYTJFhW+AjaGJuAY3wIdxkFUDdi/JNfFh/ODpXwnKm4Kpg7p44csfRn?=
 =?us-ascii?Q?gLFdtwioRA9fWJbz1WNdxEcxw6pwT3tEBjJW/cSeQE0qP3GLGd+fYkMZh12r?=
 =?us-ascii?Q?SFFerLYHpiRZ/ZvVSMe1Z/1tRAxy6IPvfnXSkIl1bD3axMhbF6SVUkffef52?=
 =?us-ascii?Q?MN45W5m9Kg8pvrcPUjMTfxWJk9C86kFYXb82xeNM3HGVdXMbVvTzNs6vu1QO?=
 =?us-ascii?Q?GkXmJPK62ThTawgHTJ19i3q3xJyieBTDQfkJZ2RF5R8YDwSxLVPneYFAfV1y?=
 =?us-ascii?Q?U54pacAEqoqngvEDC8HyIYtnyoF6YahehbNFRyPAJ8l8L1+qIjqnNyN7zuY2?=
 =?us-ascii?Q?uu6yZTBsph1LieEd3WZnemkv/H8kDPYvdLL2fshLpKL+vEpE18ro3JMqcMfF?=
 =?us-ascii?Q?I7iP7mHdxhAi5whmdDFdJ8Y8zCdi+8HZB3Fu+vBk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd3960e-2106-4779-8ea0-08ddb3d70b17
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 10:57:14.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFqrV4XDisWP+pP66kgGG9QW0658sSeZK7S7KrzAkRrm8Zf0UQjA+oMGeDPvjfQmw1Tui9SRbMz4uhU2DkthWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679

> > If you can find a way to do this via netmem_dma_unmap_addr_set, I
> > think that would be better, so you're not relying on a manual
> > netmem_is_net_iov check.
> > 
> > The way you'd do that is you'd pass skb_frag_netmem(frag) to
> > mlx5e_dma_push, and then replace the `dma->addr = addr` with
> > netmem_dma_unmap_addr_set. But up to you.
> >
> Thanks for the suggestion. This would require some additional
> refactoring. I need to play with this to see if it requires a
> lot of rewiring or not.
>
Got around to this. Found a way to use netmem_dma_unmap_addr_set()
with a small refactoring that makes sense. We'll send a patch soon.

Thanks,
Dragos

