Return-Path: <bpf+bounces-66662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F8B383F0
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01515E11C2
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F3B3568EA;
	Wed, 27 Aug 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iiyw9ZWD"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74852ED16D;
	Wed, 27 Aug 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302349; cv=fail; b=lzv4K6ApE+RU6+aNbmJGFLmuMUTLQvQXau7jHiMMK2wTE5iN1EnregmKvk+Mxnv17RC9C28tOtw1vYLDyZ7vC/O0xF1mTTGmTxq28rl28qSGOPrTSCq+LuUBQiljlWcn5gd7CedCk5uRHSKmTzYUroLnqv+4niovoqZNEpMc2+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302349; c=relaxed/simple;
	bh=5vLrR3/MZrbFQyiEyASGMnvBwnUwDT/0GX+d1zZ5NtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X9U0BM+wuVVGXHpPHYH47+0qhZxaZWQU86egwpdTP8XiZ1pT6e51ToluxbJgUzBw94tqf7xLtlrYlC32s+4eL+bILLZ88hCaJIyvTIllx7hNOeJGU7JZSpSYHLG2VaZCVjDrcEDuEFXyZu6ttjse5z/8j8xqGlgsWl0huCZc6to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iiyw9ZWD; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANa0uxo7B0EOg9h+zuJ0teDQ0vrF1jriYWoZqr+rvaxXz1q7Eu9vwINPfistyfgWlqEEJhRKJosbKtuRmUcfLGcnTlUHaPEzqBKdDsPk9Hc+CIGmyRSmU091lbhaznnZR7VQ4LChWYzwjpxYxpnHaGtNq6BV8WmMkGfnW+CCz+OsXsMwNSOsFpiN48q6g5N36/CvwfPEg4CC/NplrX5gmNijXKm6YgY4fOmSn4P/bc/Sb/yGAMg2BJh6qOE72V8vXnSZhv1aNInK3kav9lAjMBjEVcI4QW8ctg+PH3mV3tokJHDqcGh15n9IWwmaNHsDl3b5Sgeg0kkXBPxQc4sp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pefYaHsQGUGm3q4R39W8D4KILG5uJajtGTVfeZ9e/n8=;
 b=FoKyJP1WAPHBsWThwzUXU9CUbT3nb3ttwLkWcZMV+ZC8X1ezn3wvoyWdDPsBKiGRRsiA3g8zgIdrkFI+Bx6t+9mMYOOm+jvnWo1YruboveOkwdrflsegwIjZqEaf048RtGbHa0GRqf4mQJY79HTw1oQtVGSGsOBEGmfKDWOtvayO5d4uqdYP0MG/OL3FBaCD0orboXM3ZMn/37N0A8eKfDbK8oPyx+aq2wXQ0ifpS4/Xh3mEPFt2sqZbYlQfxcmfJcMhNIbtLkXPv1K4iuzA4nUvm0iFTsGcZW9+ChncXZl7+UI/eFxPsCAg2oZ3/Tj3xAXT9e7Dpg/+XNuMtysS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pefYaHsQGUGm3q4R39W8D4KILG5uJajtGTVfeZ9e/n8=;
 b=iiyw9ZWDamQroHdaXeRamTGL86ZQ/+gcceHFG2gVG8KP5tpe0a+c41cICBKUJPJ9WT+LlGgQii6u/8/j61qMbrrz+2voJSMDleTBZEtz0XcxZ4+Mz4ekxaylrp5v2LsuFvAu1LJST23ks97PnVXlhrFxqlxpJv28Psom1B/hCYgAbjDnFY9dDqIJs2oXO9D4ZEpPY/kz8QFJT9v8GSQyQ+GQfqcKXLKgIbKIVQt6zjDDX9AFhRsgJw8q0n+T9sDNVPKkqJoR63owg6gCpPQEoBHOAUdK+WPfwO2rN/fHseRjbxj3laabyC2OAfoBpOdJhjRSS0fjw8HvsUflQOfoyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.16; Wed, 27 Aug 2025 13:45:43 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 13:45:42 +0000
Date: Wed, 27 Aug 2025 13:45:30 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kuba@kernel.org, martin.lau@kernel.org, 
	mohsin.bashr@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	maciej.fijalkowski@intel.com, kernel-team@meta.com, noren@nvidia.com
Subject: Re: [RFC bpf-next v1 1/7] net/mlx5e: Fix generating skb from
 nonlinear xdp_buff
Message-ID: <76vmglojxf3yqysn5iwthctiacjy6xqcvrzzny74524djwhcf3@ejctdcty3cdz>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <20250825193918.3445531-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825193918.3445531-2-ameryhung@gmail.com>
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 49355b1f-ed51-48bb-369c-08dde57003ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7wruxM7zqv65X5ELmqys/vRucqe3r4/Nx41ybmQSxsgqkEe92fo7/bC8Mfi?=
 =?us-ascii?Q?I500WcD5Jcb1R9OgBIe4DxYrzxyjAjvMrrcFlW7DyWn2q5tVu3yJV9MFVF1o?=
 =?us-ascii?Q?Wi2Cu44QvK/yySwj176tzKtOzeizaKqCt0GpxhvKfNqAKTvbMe6c7FGIBJov?=
 =?us-ascii?Q?qOHadgcX0VgX5cqknUSJ1WQEGpF4JAwyZH71KMDTV+FLkGGWMapTy4kTEDjo?=
 =?us-ascii?Q?fGL5QOcWyni4FDaMnTsJNVv3bRxCo/CPz7DIzEcs/nLjl6V32CoWJVlOU9QE?=
 =?us-ascii?Q?vqmWjJvINRTn8g+fdw0m8po87p8vzBtDRN4idZ7SUlV5QuJzaIneQLVllfBE?=
 =?us-ascii?Q?6GknWZn7iitpGjEmPcvW3LZAU/s/nERmC0xCFoF2atx3Bxm9PDSm+oK5VZhb?=
 =?us-ascii?Q?nPmM5Ip3BJvO865zXZHcXX37S/2FVpG0HGQqY0bgZdR2LSxxPLl/xjKq5Eqt?=
 =?us-ascii?Q?kgfLCGVpzkxDg+IBrcPDgGxC95ATb6OjpG5I3mSNmTq7SDdYCQsRDJVOel35?=
 =?us-ascii?Q?94u6Ao5Zg6XN9U2IGZNF7gKuRR027DkibO3SXDp9lwDapE5iPcv7D+Zy408j?=
 =?us-ascii?Q?aHP59FcrWFn3vdE9yhn9A0WPZ/g7YRvmwH2znCfPJBt0EczAjsZ8m2aYCojT?=
 =?us-ascii?Q?bCZ1IyG7C4ckY/lwmxu4go3mw6j4DXEcEbRRIG/MqnJrvZSBSDWlwPdNxHIG?=
 =?us-ascii?Q?36Hgd/JBZWo4XWWvQ/63SKmEPoDju35Duxn0hPTDScEWdKaL+VkkBNXxPHLE?=
 =?us-ascii?Q?suC0RIWG6qrKt2HG6mAkuBoYGVoblbnhU2+iI5lhN796dV90QaFx5A9c9lNf?=
 =?us-ascii?Q?t9no5citheZ6aBi8/T5BjAI9fDLh7tt+pn/YXxpet11eIERGkKTVuakMXCLd?=
 =?us-ascii?Q?YUWu5DTjSKmU8Ys2ffnW3i2OmXObEpfHz9ooUA1v0UcJO+8mGn6owg4PdU7R?=
 =?us-ascii?Q?j95+MLQh+tmlHSaxe4uGLbo3yjXdnwbW9RiqwJwmg2C/EFxtM1se1p41WJ10?=
 =?us-ascii?Q?vEI3s16JDRlMsVrEBwIR824GgRCXun6chv+Qv3/NId1meaAq+j7oco0sbXfk?=
 =?us-ascii?Q?PcT7P+ShRlYcJce0dvoAjlIjroeqs1GeopFq+8shxyft42gCzQuPx7YK6M0a?=
 =?us-ascii?Q?EUT5KNc7BVK2VECGvqD53+UqVItBnJ0pKyLQgpqXdQnx6vLtuNhWTWm6dSPq?=
 =?us-ascii?Q?KnV5PGVDYM4xsUuN8pazaJu3VnXqjgdFqLExMbbVzU4XuUb+S9OAhfb5U4g6?=
 =?us-ascii?Q?nQ7nErd2yMnoXDvYGSZELXp0rQ+GaSh0dgLIpqIrElituoCTwDiQfYNdWgfb?=
 =?us-ascii?Q?+uo9GnHukTBGG1ELdZIV6iYP+h/c74t0m7UZjBGgZ8zy360LglR9+3tFTD50?=
 =?us-ascii?Q?eHiaZvxJyjqwQB6TjCv/fzukwD5QMYbOWmIrfTOCi0WphDKEgJyaZAG/EyeM?=
 =?us-ascii?Q?lB2dMLuLo+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d6c7+NaE1l6tYVBKT2zW7DEiMEqsaqTa2NBo+iYodWCtPwoGeJ5s+1pWCrBO?=
 =?us-ascii?Q?XT6aaV8dGzCW7oD70j3f68ZrKLs9M0GemQCKEjue/pFSoAlpva2Q2zI45/5e?=
 =?us-ascii?Q?v8YVr78qGwhXLQh0lkCaVTiq3WTv46MYGba+f5Cl0PDaaUMzb8Nap1MH70jR?=
 =?us-ascii?Q?R6zCH222cCy3nw8qdRSVUoj/TYzEC2BSWIjnLe66ZiV98V7OAt3b8G25gsE/?=
 =?us-ascii?Q?hP8mfIyVCGmnIPBqeaibxQFZ9EDM1CuNVuKMSEOmQkeOEoL+uqnxBG65xLuU?=
 =?us-ascii?Q?5iIkpmqp8mVCuMh4kde//ytaEKKzbwluBKIBumLlNlMc7Dms+OpKqWqgT7oz?=
 =?us-ascii?Q?woW1fdNDSStZABms+SgfWv/5VOxq2ir19TawIi8yptGDzZI0j9xVsyVtg5Lm?=
 =?us-ascii?Q?FJ0XZ+f4anZTECDH03r+iBJVrEWsjRcRileMBzi7aGNT5nzaLLY1g+PjBtmP?=
 =?us-ascii?Q?5TsxuABpa3o/twpws7WENsjlee7ryUzTjQCkxaG7mgLy5/LrgD1qZNWq5MWb?=
 =?us-ascii?Q?31e+Mo3WzSfcltlpHLNstkCN7Ct3Lj8AayAcTEsFhepE08bhMbU+lHr16Ppl?=
 =?us-ascii?Q?3LmH8uOYldFwIj54Hu9FZNju5uqI4DX553Evw131CbZ8g0npk0TpAbGSPmr6?=
 =?us-ascii?Q?CWlL3ilZ+oVdgl61+gNJC1v6PSWlBxOSqEzVDDR67kYEf2c6z1S7aZ9ffW03?=
 =?us-ascii?Q?ihEbOsUjw8Rh+FRqvbwN66OmlXMWWcjM1jNa69AMhrKXgaCI9n99MyS+AiCb?=
 =?us-ascii?Q?oicifBKbGYTuKTjK0DyEkvkl58AFU3np+i/gCKg4U2QaTgWyhExI8DUqASCa?=
 =?us-ascii?Q?pAwaUvAwIosiauQsnZ3T9vuKOaA5zSkTnvTigS+0Mdt3jf/c9/VpBVdMqrqd?=
 =?us-ascii?Q?9W4kbqVj1dnN6FD8OjS1DskLtwGC+8Sy/WiP+Rhc/O4BObo7Mh73OwAOsqNM?=
 =?us-ascii?Q?rF8gHIJe92M+EI0noRfqpd23pTpIU2WMnj4PH9+VTIp3/RQLKZjbdpwZoSmr?=
 =?us-ascii?Q?Y2wL9jkFcCpOWDB5DkvjzPDXoQgQH6YYbVDjW/bwlsGG7/3qgtPsgBoeROUe?=
 =?us-ascii?Q?5GsahZJ/ZO2mXQtOxWcaFzG3jMMbrhyIkmSWK/54sieQCJnTF8HoCjQ3EfWg?=
 =?us-ascii?Q?zKp74ZJQwCHG/LaWaPPM8ZxbNZELdP0BiArxkRTzDc6umW0WoLF3IWiyz5OZ?=
 =?us-ascii?Q?MhpsZ5/a2qvtsn2eOcEAr5bsYo8aJ3Mb5b5cqJ3JEVgYyjPMI/GxHguZsDU4?=
 =?us-ascii?Q?M9/r2LbzszcIz4xv8sXjq2UIk441FiS/Lgm6AZ/xhUapLssN8jLeo9TbAIjs?=
 =?us-ascii?Q?GldaH9jQeoUdHjm5X1HUp04QtA6JUnFAPpaVqNDCBy3BgA2H7pbJYgMmfaRu?=
 =?us-ascii?Q?LfXSVzPDCPdW43RSWxMQzE2zEIzXkPyLBfR8kGDOCu6cEUhLqHgZ2YMDAOTT?=
 =?us-ascii?Q?QJQ26NYsJGNCPpvJgOJUiOc1iI/s5Q9XVb5I+3FW7wm8LgaJoZNDtMJN4T2G?=
 =?us-ascii?Q?AwuQ1UzmUgqrzK1mLq3g1PWVWYmtmu5yIb2NhG2qLbL1SligLy1xc62LW+Fy?=
 =?us-ascii?Q?lfMUPqg8JFpixk4u7xe6oYoFk1V6XEXScwS71eH+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49355b1f-ed51-48bb-369c-08dde57003ef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 13:45:42.6042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zrSEK1LRnRkmZYLkpL7dGiWF0trXlhTY+3JMBI82qUpXu9Rl+JYuXPP7k/5QLMUe8nyUhRViNwz9pzoo/5pPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272

On Mon, Aug 25, 2025 at 12:39:12PM -0700, Amery Hung wrote:
> xdp programs can change the layout of an xdp_buff through
> bpf_xdp_adjust_tail(), bpf_xdp_adjust_head(). Therefore, the driver
> cannot assume the size of the linear data area nor fragments. Fix the
> bug in mlx5e driver by generating skb according to xdp_buff layout.
>
Good find! Thanks for tackling this Amery.

> Currently, when handling multi-buf xdp, the mlx5e driver assumes the
> layout of an xdp_buff to be unchanged. That is, the linear data area
> continues to be empty and the fragments remains the same.
This is true only for striding rq xdp. Legacy rq xdp puts the header
in the linear part.

> This may
> cause the driver to generate erroneous skb or triggering a kernel
> warning. When an xdp program added linear data through
> bpf_xdp_adjust_head() the linear data will be ignored as
> mlx5e_build_linear_skb() builds an skb with empty linear data and then
> pull data from fragments to fill the linear data area. When an xdp
> program has shrunk the nonlinear data through bpf_xdp_adjust_tail(),
> the delta passed to __pskb_pull_tail() may exceed the actual nonlinear
> data size and trigger the BUG_ON in it.
> 
> To fix the issue, first build the skb with linear data area matching
> the xdp_buff. Then, call __pskb_pull_tail() to fill the linear data for
> up to MLX5E_RX_MAX_HEAD bytes. In addition, recalculate nr_frags and
> truesize after xdp program runs.
>
The ordering here seems misleading. AFAIU recalculating nr_frags happens
first.

> Fixes: f52ac7028bec ("net/mlx5e: RX, Add XDP multi-buffer support in Striding RQ")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 59 ++++++++++++++-----
>  1 file changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index b8c609d91d11..c5173f1ccb4e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1725,16 +1725,17 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
>  			     struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
>  {
>  	struct mlx5e_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
> +	struct mlx5e_wqe_frag_info *pwi, *head_wi = wi;
>  	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
> -	struct mlx5e_wqe_frag_info *head_wi = wi;
>  	u16 rx_headroom = rq->buff.headroom;
>  	struct mlx5e_frag_page *frag_page;
>  	struct skb_shared_info *sinfo;
> -	u32 frag_consumed_bytes;
> +	u32 frag_consumed_bytes, i;
>  	struct bpf_prog *prog;
>  	struct sk_buff *skb;
>  	dma_addr_t addr;
>  	u32 truesize;
> +	u8 nr_frags;
>  	void *va;
>  
>  	frag_page = wi->frag_page;
> @@ -1775,14 +1776,26 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
>  	prog = rcu_dereference(rq->xdp_prog);
>  	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
>  		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
> -			struct mlx5e_wqe_frag_info *pwi;
> +			pwi = head_wi;
> +			while (pwi->frag_page->netmem != sinfo->frags[0].netmem && pwi < wi)
> +				pwi++;
>
Is this trying to skip counting the frags for the linear part? If yes,
don't understand the reasoning. If not, I don't follow the code.

AFAIU frags have to be counted for the linear part + sinfo->nr_frags.
Frags could be less after xdp program execution, but the linear part is
still there.

> -			for (pwi = head_wi; pwi < wi; pwi++)
> +			for (i = 0; i < sinfo->nr_frags; i++, pwi++)
>  				pwi->frag_page->frags++;
Why not:

	pwi = head_wi;
	for (int i = 0; i < (sinfo->nr_frags + 1); i++, pwi++)
		pwi->frag_page->frags++;

>  		}
>  		return NULL; /* page/packet was consumed by XDP */
>  	}
>  
> +	nr_frags = sinfo->nr_frags;
This makes sense. You are using this in xdp_update_skb_shared_info()
below.

> +	pwi = head_wi + 1;
> +
> +	if (prog) {
You could do here: if (unlikely(sinfo->nr_frags != nr_frags).

> +		truesize = sinfo->nr_frags * frag_info->frag_stride;
> +
Ack. Recalculating truesize.

> +		while (pwi->frag_page->netmem != sinfo->frags[0].netmem && pwi < wi)
> +			pwi++;
Why is this needed here?
> +	}

>  	skb = mlx5e_build_linear_skb(
>  		rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
>  		mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
> @@ -1796,12 +1809,12 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
>  
>  	if (xdp_buff_has_frags(&mxbuf->xdp)) {
>  		/* sinfo->nr_frags is reset by build_skb, calculate again. */
> -		xdp_update_skb_shared_info(skb, wi - head_wi - 1,
> +		xdp_update_skb_shared_info(skb, nr_frags,
>  					   sinfo->xdp_frags_size, truesize,
>  					   xdp_buff_is_frag_pfmemalloc(
>  						&mxbuf->xdp));
>  
> -		for (struct mlx5e_wqe_frag_info *pwi = head_wi + 1; pwi < wi; pwi++)
> +		for (i = 0; i < nr_frags; i++, pwi++)
>  			pwi->frag_page->frags++;
Why not pull the pwi assignmet to head_wi + 1 up from the for scope and use i
with i < nr_frags condition?

>  	}
>  
> @@ -2073,12 +2086,18 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  	}
>  
>  	if (prog) {
> +		u8 nr_frags;
> +		u32 len, i;
> +
>  		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
>  			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
> -				struct mlx5e_frag_page *pfp;
> +				struct mlx5e_frag_page *pagep = head_page;
> +
> +				while (pagep->netmem != sinfo->frags[0].netmem && pagep < frag_page)
> +					pagep++;
>
Why do you need this?

> -				for (pfp = head_page; pfp < frag_page; pfp++)
> -					pfp->frags++;
> +				for (i = 0; i < sinfo->nr_frags; i++)
> +					pagep->frags++;
This looks good here but with pfp = head_page. head_page should point to the first
frag. The linear part is in wi->linear_page.


>  				wi->linear_page.frags++;
>  			}
> @@ -2087,9 +2106,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  			return NULL; /* page/packet was consumed by XDP */
>  		}
>  
> +		len = mxbuf->xdp.data_end - mxbuf->xdp.data;
> +		nr_frags = sinfo->nr_frags;
> +
>  		skb = mlx5e_build_linear_skb(
>  			rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
> -			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
> +			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len,
>  			mxbuf->xdp.data - mxbuf->xdp.data_meta);
This makes sense.

>  		if (unlikely(!skb)) {
>  			mlx5e_page_release_fragmented(rq->page_pool,
> @@ -2102,20 +2124,25 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  		mlx5e_page_release_fragmented(rq->page_pool, &wi->linear_page);
>  
>  		if (xdp_buff_has_frags(&mxbuf->xdp)) {
> -			struct mlx5e_frag_page *pagep;
> +			struct mlx5e_frag_page *pagep = head_page;
> +
> +			truesize = nr_frags * PAGE_SIZE;
I am not sure that this is accurate. The last fragment might be smaller
than page size. It should be aligned to BIT(rq->mpwqe.log_stride_sz).

>  
>  			/* sinfo->nr_frags is reset by build_skb, calculate again. */
> -			xdp_update_skb_shared_info(skb, frag_page - head_page,
> +			xdp_update_skb_shared_info(skb, nr_frags,
>  						   sinfo->xdp_frags_size, truesize,
>  						   xdp_buff_is_frag_pfmemalloc(
>  							&mxbuf->xdp));
>  
> -			pagep = head_page;
> -			do
> +			while (pagep->netmem != sinfo->frags[0].netmem && pagep < frag_page)
> +				pagep++;
> +
> +			for (i = 0; i < nr_frags; i++, pagep++)
>  				pagep->frags++;
> -			while (++pagep < frag_page);
> +
> +			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len, sinfo->xdp_frags_size);
> +			__pskb_pull_tail(skb, headlen);
>  		}
> -		__pskb_pull_tail(skb, headlen);
What happens when there are no more frags? (bpf_xdp_frags_shrink_tail()
shrinked them out). Is that at all possible?

In general, I think the code would be nicer if it would do a rewind of
the end pointer based on the diff between the old and new nr_frags.

Thanks,
Dragos

