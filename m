Return-Path: <bpf+bounces-65320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5340B201F3
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 10:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2983BD9CE
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 08:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8EE2DC350;
	Mon, 11 Aug 2025 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="glSMtn4X"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674E52DC34D;
	Mon, 11 Aug 2025 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901482; cv=fail; b=ZsjF4QaTCw9kZH+Zjx6EPxkPn6wvMSfFnH439ADLDKVILK4OzEW9wr488fSDl5cQ3ZwULEMMKP0abjZIZsJ5Lui2Rtf2wJPR29ff91EYA3LyKSgBbewkrSSNaiqX3WZhLzYDHmNlOZzLlKaxo8m40D0PahF0fEpE8tKlkbhLdGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901482; c=relaxed/simple;
	bh=iKHlnywyvJCroPTe+jLLHE8FOjJMrB+oixSb6F/oZUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L4CzQthLMQHPIybYHqf2R5k3n13fD4sQb8cEK+eUds6NrY+o/aRHkGeQOO6N7fsPlPRMI3SBgB7iLUwjlHv4d/Pm/N24ohokOfUpkZLePybWU9DG3EB7RY0hulhosA75mtq/waPe3IDtaRkA6olGg+D3Lxa4UqVwldgxnb+Alco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=glSMtn4X; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTSYIKnF9cQemFHN6yQC8TzFkX2ZmoCpWhvWkFeRU7316sqYG0nsaQpghntlNGM2nvsDzjVrARoSYSyMtLJtQ7seNudweW1TlS0qUigWQ0t2voMUmikeEQiwn6kDgAJpqNJLAwbkWhXQc8CEEJd+EiHqItXZhRotx8lqYMH9J622mvh9HkPR0qMB3gQuHfqFdaT5w0O8krMOio7U4izk+i4vNG6XrX3ubn9tR0IxbucPIXqXOspzgLxexxgZpbpccg1IDvwXXdCt5RKwz2lxFZ5dfdp7KkZ6rOETJY1RlpOjz1L6bBoWziyoFH0arIlG01ih5jM6DnZi8jo0mIBaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKU2OoyQhjsTpX6T88qdxM2DanZX5xIU8gWnxajpDRY=;
 b=oN4V/uZJzywjLlrIRo99P1SW2nNA4iaIAmmk9VX8qcRgJTM6fNHVxSQutgr3ir541JeLtMj95bH9IuktZkVfdr8AGZ7s7SPx9VkLJ0p2shPP6DRLs47hBr1hFIxTHnI5K3czDUFo5ZkRYVu3meQuVHxqQ6tZLbWuDGfGxxIubSz538c2tzmek3SU/chosg6YxMGDxlC2eOhWqODAbEo7ishCPkbUnI16lSF1s7nWGFExCv0O4sTNFhuxTFmCXBEJJUoiaN+ft88UDaW4UPp8b81OOl+u5Spa+BM4yjpQLt6EXyAAa6OOlIkFsXVanT61bwKeWexfouoi+ia5wsBzJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKU2OoyQhjsTpX6T88qdxM2DanZX5xIU8gWnxajpDRY=;
 b=glSMtn4X29ZsSGucfsnOZaz9tdthuTEhTs9AkGx5wnLwq3HIChjvpWYZens3/yu3tEzT3H6lc8iBFyqey5xYX55+Wnir81N90bK4ph2D4+wWryA0WkVZIK1/jLUgCUzJ9WbG+VC1F+PQ+jCGwkInvZmvtqvLlcehn7rlIDglcGlxmyX+rpk31nvCSmKStCRkbF2K3bpmi8VI848/t5FJvasNFr0Dfjli5BGI3ooGT1Q/TnN6ZkVKceiG6sRXiYjZvG+Hunb5BG/ZfQw9i4TmYnb0AsRZTm7WWqqWaTUfq+cmIuojy+84gSgCot2BjC3I/DkOP/0xONV1/Pm9PGYlfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 08:37:58 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 08:37:58 +0000
Date: Mon, 11 Aug 2025 08:37:56 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Chris Arges <carges@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com, 
	saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Simon Horman <horms@kernel.org>, Andrew Rzeznik <arzeznik@cloudflare.com>, 
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
 <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
 <aIEuZy6fUj_4wtQ6@861G6M3>
 <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>
 <aJTYNG1AroAnvV31@861G6M3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJTYNG1AroAnvV31@861G6M3>
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: d9937156-15c6-422d-fa8e-08ddd8b25f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a4GECyGTdrnTjvfwT0+/VkBoccZJirusmOs2oRrZPmejPOgk4HBEZ9NPop/b?=
 =?us-ascii?Q?sxsvVadOnpPf+Wp4Enu7okoNQODIYDqVtyBZVpRY7GGt+ECC0rweKXEbx1fR?=
 =?us-ascii?Q?MWruXFYRUWY72BF7jAj2lOxmwjDhj8tFexu6k9z6HXzVZ0ZQdcGbvVcxYrYw?=
 =?us-ascii?Q?tz9TwKTtevxrSbXNRQDAbHqCpaqrBQ2sF7ftA6X2vbxNKeomcCDk0OewVaD8?=
 =?us-ascii?Q?wh7lmTMjs8Or+sjoxJico6IYlg8ZwOdKB2QnA79SBwlyzfSDktVZLhIq8x0M?=
 =?us-ascii?Q?3IbcnC4GKiZ30ECyhRxbyFXhXtLD2EdU3liLhqmwmd7QZA04ujcyNR8hH9/y?=
 =?us-ascii?Q?cneepfn9tbKbCI8hd+WMzNvq5ZAi7/2ITeHbQCBVqeWaCo8tfnqf7b5CQCAR?=
 =?us-ascii?Q?+Lsj8kUDCTc8SZ3C++uXh+cK5yBjtceHn65lGXyrFyWM/tcVZlGx8pZ0OszN?=
 =?us-ascii?Q?dtWlaU4HcpwtNdKrDciMn0dQviAkGohwiu5ZkwP+aXtCuToxhIae1JhBjlq3?=
 =?us-ascii?Q?S9fQ407hqEK2Uw848zBtp/hcjzHpJxZvFYux0TpwqxT0rRPGSFSRJsd70MH7?=
 =?us-ascii?Q?mapxV4pfIJgk7SjHjjh9GjXs8qtMRyDQrTmq64y5+xUKJ7eH6wWecr/ji0S9?=
 =?us-ascii?Q?NsF+XZ4A+Pfh3ZhJaxO/y+k0ZENeLl1tn3Nj3KztjCfF9vMXVFa81LwD+idO?=
 =?us-ascii?Q?nVfjC+szJxo3dtPqL9fEoBY3jemhf6DoIokjzEjbYfs3DwOO7vtMbPEzYqGP?=
 =?us-ascii?Q?i2IdyA7JB3EleOBMK1yPajLDOEomdQZMdcOndTXNLdLl64XVt+pojm4zeNiD?=
 =?us-ascii?Q?O2nOPae1G+kXccwuGFaH5ao49yDJPRrYEp+8kwzKOpENH1ueL9OAmpY9U+p8?=
 =?us-ascii?Q?riliucAjmudpEVqoc8OQkFq/mpw5DJWUoRjI3bW/nlX37cxYPdWKEPaJg21m?=
 =?us-ascii?Q?LlSVcPeT0+pA2ay683gSF1IWCfUNvk5s7OtyXCofvCEcKn31hWWbQ6qcUeBa?=
 =?us-ascii?Q?tbtQkvnStli8OeL0cE2QwfHH+meyCoSPEOjW7F8nkpWBLchCo7mumIKotOnn?=
 =?us-ascii?Q?SdwEpb4VddzrQU2CjYXmb9lUFgZI+HX8x4IaSwpbi/mf1fhgN2ETqCh0PZXx?=
 =?us-ascii?Q?EOXQfvhb0JGBkcJBDziDiTwaRyuxGEQzv0TKaNx3tehIPadjcLaVnCc8mSyf?=
 =?us-ascii?Q?Zfk25YmuDDuOSX8UWRvriU5GNocAdzTs4jzvPdKDilYXg2hv128EV/gdKdR/?=
 =?us-ascii?Q?Ss3EQNh0JJsN9GVn5hrn2Ys/ttX/zwWyPucDf9uyTsToU+nM/wdN3dmQTr3V?=
 =?us-ascii?Q?USxPY9t3W84i9TyIJ9ZUZCJCj5bWuqS6CxU8RtDHpL3SbkZ2TiGujfyHDmOb?=
 =?us-ascii?Q?S5JczHzgmKcHGCelDOEX6x90facYkZ93a2s3c+3TPcVFmRHCKhid604jE+d3?=
 =?us-ascii?Q?ENMFbTuqqTeyIN80GCHpJK0jbI4topF1SpkwkhjMdHwe/0ibU4SN8KmZucIT?=
 =?us-ascii?Q?NBMVu4/Rw6eniMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ay1qd7n+obFbE7LuwGHXm/vQty3uYrVKX4GGaFLSPmUEOXseIXd/N+A3jDnm?=
 =?us-ascii?Q?F/VM9sk0VnzhK3KBgKfGBsas5rqdpTOY/kpUPhB6eSQnC4k4SQ6U0EUnv0xI?=
 =?us-ascii?Q?UUgzUJCyzkCs8cc7K7JJ++0/B9jSaVHuSLg70J6rTpyGaAuVajE6GQp+9tCQ?=
 =?us-ascii?Q?FrWQtzHi+l5pPuSOCS1Aa0ecSJ8kFhwvtcBeXjOVnuvKqZhGyYPEDekcvwHr?=
 =?us-ascii?Q?rmG9iu9jfsHe+B6phAnolSYKn67fuWsOC7UYbIH5PxmeHNWlUSdzoZ3GYvAB?=
 =?us-ascii?Q?H27mJmgTlI0dYcea2TpPjmITCHurUu+L1A/c4u9tRpJGxXPCNVm1iU32bu75?=
 =?us-ascii?Q?x+X4wK6cUHNXjDI21tBWtCu37pxJOUH6jiUf91ZdtS/tbtLjAQ9iGd50L1L9?=
 =?us-ascii?Q?l/3C5UGU6FN+7J04EDRy8cTA51QAd5j6G2qnb64g5jBpt1ZAL47lRWkpT/DK?=
 =?us-ascii?Q?5YKpSN+WGk8jui7lwhg8U6ZGv2+HWJhVEcNuRsLxLlsQ/qF1ANFnrEF5yO6x?=
 =?us-ascii?Q?XS0pwtGNLKlRq60FLj91uYgtGgoLtKGW5dCH9wzkUEw8jNtPu/F9NXdrS+ZL?=
 =?us-ascii?Q?TQPVAohl7iScNylgNIJZHz5tlxD2czED/Qa0Atm29y4pngRvq9PFygpPsLfc?=
 =?us-ascii?Q?dHfEcHNO+rRXjEyJYIV1bIyeiFHaDQ/cUsMuMtLXBoQuPbN1E6xL8EeQr3QS?=
 =?us-ascii?Q?Vhh5ukEKb8dAl1gF+/TD7Q1kuByzzJKZESKOUBnqoljBmz3NnnO0vpdIfXTC?=
 =?us-ascii?Q?kLdcu1zAS7+as+WRDe3AasGi0turkhpWzbMdF0ZxgJhKqzjmIJMr7j1NG/pB?=
 =?us-ascii?Q?aKvOPXYAvPzZfihJoe7xw4XOrIYAMCBUzrMpDLFTHWu6VJ/5+qpcae+k6ER7?=
 =?us-ascii?Q?/FPkOKyuNtoVLk/Y/zvoJKJ/vI3w8ZiAjQFsAnj+QTFcbBo4qqm+It7c1wAe?=
 =?us-ascii?Q?gndMqui1unVRFSZyZNYqtSFn0ODd1lbBi85/Wzr4x8Y7J6zCPD7ePdLlRVNw?=
 =?us-ascii?Q?YjgmgNs97gW/C5e5PLjjiIGavkVhWf+C0fK8uIM9Lrs1GElZ4JDdI6n/5q6n?=
 =?us-ascii?Q?mQouCdERmcCnzRMTMk73opVtAtbf9R61sqUb6+BeRD95fvAn9cyFsdoSFfdj?=
 =?us-ascii?Q?3SCueYWM2ruJdvM0HaI8y7H0IRDyc3UP67viN+2V0ksW76vOTacpyb+/B+fB?=
 =?us-ascii?Q?6CZ1VNkK5fZwOvsuQ2fYpWjjUNmxDfcc/Os8Q/rfWCJwejL8scRYYlFFUMW6?=
 =?us-ascii?Q?elO8+XDzyr1XUZtq31vjNJ5JM5XMBGCaYPZOdcqqtAUgVz0j4HrnoNhCXYTq?=
 =?us-ascii?Q?dm2grZ0tcnaJpWLzLKo3TlgWYg7n1d+7XmZO+y9PXeSI95NA8Ee+Fw1RI9Pt?=
 =?us-ascii?Q?HvxTF/5EaklZuwRWhM0Ef+uG9FA5aVP0YGHfeX6l0H4wf4jIf2YHTR/tePXS?=
 =?us-ascii?Q?PmtGLhAZi6/P8KjhkJjVhAejgoGRGudtfVOeukm/SpQIdPBNFPxZl5+cbjqr?=
 =?us-ascii?Q?8ybmMCAmn4uVLoY6hlKVdYlqDlPyIAcIFeRChtRQqf6vHpBimtleLyTZzqrU?=
 =?us-ascii?Q?ugcnriRtPOErA7DyBNjeN6aq2lAohf3lBvANUVl0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9937156-15c6-422d-fa8e-08ddd8b25f9e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 08:37:57.9810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhmpqibLdJdIi3otZHymLopxcTw6yADvPz8NTQlksq7cUpVZ+lGOpMwr09fAubLpg2kB8ugNPUMALtwczvH0SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

Hi Chris,

Sorry for the late reply, I was on holiday.

On Thu, Aug 07, 2025 at 11:45:40AM -0500, Chris Arges wrote:
> On 2025-07-24 17:01:16, Dragos Tatulea wrote:
> > On Wed, Jul 23, 2025 at 01:48:07PM -0500, Chris Arges wrote:
> > > 
> > > Ok, we can reproduce this problem!
> > > 
> > > I tried to simplify this reproducer, but it seems like what's needed is:
> > > - xdp program attached to mlx5 NIC
> > > - cpumap redirect
> > > - device redirect (map or just bpf_redirect)
> > > - frame gets turned into an skb
> > > Then from another machine send many flows of UDP traffic to trigger the problem.
> > > 
> > > I've put together a program that reproduces the issue here:
> > > - https://github.com/arges/xdp-redirector
> > >
> > Much appreciated! I fumbled around initially, not managing to get
> > traffic to the xdp_devmap stage. But further debugging revealed that GRO
> > needs to be enabled on the veth devices for XDP redir to work to the
> > xdp_devmap. After that I managed to reproduce your issue.
> > 
> > Now I can start looking into it.
> > 
> 
> Dragos,
> 
> There was a similar reference counting issue identified in:
> https://lore.kernel.org/all/20250801170754.2439577-1-kuba@kernel.org/
> 
> Part of the commit message mentioned:
> > Unfortunately for fbnic since commit f7dc3248dcfb ("skbuff: Optimization
> > of SKB coalescing for page pool") core _may_ actually take two extra
> > pp refcounts, if one of them is returned before driver gives up the bias
> > the ret < 0 check in page_pool_unref_netmem() will trigger.
> 
> In order to help debug the mlx5 issue caused by xdp redirection, I built a
> kernel with commit f7dc3248dcfb reverted, but unfortunately I was still able
> to reproduce the issue.
Thanks for trying this.

> 
> I am happy to try some other experiments, or if there are other ideas you have.
>
I am actively debugging the issue but progress is slow as it is not an
easy one. So far I have been able to trace it back to the fact that the
page_pool is returning the same page twice on allocation without having a
release in between. As this is quite weird, I think I still have to
trace it back a few more steps to find the actual issue.

Thanks,
Dragos

