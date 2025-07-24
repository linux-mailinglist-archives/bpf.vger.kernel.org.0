Return-Path: <bpf+bounces-64287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345D1B1101A
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 19:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129BF3AD4DE
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D06D1F7586;
	Thu, 24 Jul 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JBnWSJWY"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA522083;
	Thu, 24 Jul 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376489; cv=fail; b=mdB4O0zfSA+McrFJtRWy+Rsn106SDprxs+ucGKdAHaqIf1aP1QOrwzetzhYtNvD9Sm4Y9l1DX+gpoxtiCGzsel37rXAMSZdRmtqqV1S1w62H3AgFaiSO3Fifsn19E3anxhl8iqezITrVKbalabxcK2fFS2L6YgMYAcin+TqzA3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376489; c=relaxed/simple;
	bh=F8VYGCHI1ELS/E2LhzFc8bJWy1y5LcFCuZB0l18b7Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R200kdjH3+NOVn2sRDj31y71FpUvKXODoA3EK8ULI2ejnY4GL3xcN3A7aZvR8vI2EAixIzd6oumUzO7wz/VEmdXM9eFNFAbOebajNFgZPUjCQrUrauRe3DiELdv/kPcCo97wdE0Sq3rIjddFYiUDETGfaxiPDioKw5a6mj+ZLaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JBnWSJWY; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MklEMvygImgRKBylwdKGpa0ZBFQM+47Z0Z7hetalejkVHPP5esfna11YT6WVpIDfbwq6D8FevOdlog0wXCRfvlaZSTyEOEzudBMeB+brtofKm04H+bzpui1sfbch84JQMCodnMPE6So6jzinCOLzgXcMX6yRKRe9LM/QyYe5wignf401wpZwEREQc2ET1G24ATBjyJH+6ELgJkI2re3WPaC/w8JZjGJKQYqVzPpOTw9Yrp6xDXhQqq5j919RDKIJAwRztnF6WEXx5yOhS7ElAVFHnw6MkYWXJzKlfrtziMz0qTLlg3Tx4n/PB7DKrIu5qPbt/MDipsaUpjK5L8Bm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paILZpNySVG+Z6rmeNTsDxN+ACvrvz2mkxcG5LJYY9M=;
 b=DCLkYM21ZL3LPzwfhIya6P3wNk6XTp/dpGIPP2QeF/7HAYPWkc9zb8riuYIJ7IgsTy/a2E3pzPLuFos0lkIl2b/BmLBszA55nuzXHeDYWpw+98lCoqfQCawFlJCWSnlYNkfJAo5qoahqRg7PhMh8/VRGwgS5Nw7sNO5npQ46/Ox6UqR0LebhqxeK8XOhlp7cf/XxL3omHxn6PnzDuqUN++hYhR9qag/GV3YsXpdWA7Zv6eZ7RQksxgVsHuvGTlxWCdgIff3ydWOkjEMlZcwiw0kFT757joXvmIpKvSjt4y+2Kc5xI/nzYIbtY5q5SdcvU8V/d070zt/fYIojAVSrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paILZpNySVG+Z6rmeNTsDxN+ACvrvz2mkxcG5LJYY9M=;
 b=JBnWSJWYCWO0WhjxKKZPxB69+oQElnAO0LB7Y17tCUrGnZoqXT1rwI3ZqKIYrUAuF+0JNCfFleM+UxX4nKZn7iailSss/SVEHxbhsCzgmcCtH1tM2zQCOIwiJuK14mMp3jBIfiJPmHf6nzQZriS1nyyc2ekkX7Kf8YnT8GeawkwSBx3Gj2vBnPmvlLFjZFKTTOFYiqQ95nvoItAotBATDxnbHNWV+wjA40iqJ6KLcgL2HKEK6obGVZdepoZfFkG5ARH0sys4N0Q3c/r7wd8s3vLCSOmdK0X6niCADzmwUH0eDnZ6L0gQI7qH8Ve5B5mEeWnGxsrNLVfedwdSsatGAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Thu, 24 Jul
 2025 17:01:25 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 17:01:24 +0000
Date: Thu, 24 Jul 2025 17:01:16 +0000
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
Message-ID: <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
 <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
 <aIEuZy6fUj_4wtQ6@861G6M3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIEuZy6fUj_4wtQ6@861G6M3>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: faf73012-cadb-44cd-d7dc-08ddcad3b8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ihp2jhY4CJR2RR1TfQAaJbKS+AfzvAMYq9MGOar5O+Moupozb/5kmpdhmcAb?=
 =?us-ascii?Q?Yp1v2G58duZP81fEYD0tDRKObRySmLOGYliZItXFcmvBBdKxc49Hgmm0lcCe?=
 =?us-ascii?Q?O7RV0ZQQXBP8w9NO6vM+kNixpl8fawbhpvQ+4E5YCp/obnzaJyJwhq/Vfjps?=
 =?us-ascii?Q?aourd/yg/dcefj55ZOqA2uElSpiITvtppJXudp9i9y6jcUcyb6+8aYaE+rWi?=
 =?us-ascii?Q?86d8PcKIX1j7fKsUm/7qVuurU+PS9GW36/ozvQpcAkdlgsLK+QFqdnqmA18P?=
 =?us-ascii?Q?IMuR5zPvZ3xpfDVAfbGPJedFh2uXLFvG4xVAonJ+oAJ6xtgNRXmchU1xvAbP?=
 =?us-ascii?Q?eVUwNY/pwLeeIcecmPf8x2Ap4aNbn7qLPZ1uQOSynPTAX+j2h0ZTLSfy3D2m?=
 =?us-ascii?Q?aHq4LjTgOP+vjjgqK0Gq+pScPDVOqe5n7tsVCaLC81cAfq2Y9JspwxP4sBIU?=
 =?us-ascii?Q?gK9AkjVlPunLu0vdcjSDVR2GGDGli5EuqbIDQLUXsGLXSg/zYDkQKnLbVwgA?=
 =?us-ascii?Q?WgqLaEQ1AXb+AvSsHsGCCkedhfv6WlqdRlL7Fdm8o52IeLYojv16oxDovx42?=
 =?us-ascii?Q?OUIs1IpmVYbEtNvJzhkqSZuOiPL9MxVF4FiKIjE+dGws1E429JSlSnYHWhf/?=
 =?us-ascii?Q?Kf1USxufIV72HlKdvMXL1fSgJRxB7pxCme85200otpjPBLHUtL0LjQQD9J7P?=
 =?us-ascii?Q?soxE71Vwd5dWIMljiTnnQEqFRXXE30CJVNlIwW0fn2UmRsRHcdr0ZyFMffSr?=
 =?us-ascii?Q?arye5/q9N4644Q8PC+AAyIqyTbzMEkJwqmY3tJqInxKELbjk4J9lPOKSEsLs?=
 =?us-ascii?Q?UXUlXLlaFY5rr14bj2NuSWAyAfDdPmP7h/3usnoHX/B4W9C6ZhfsBeZ9KmDe?=
 =?us-ascii?Q?O2CzuWuft7xy6CVjHv2LoCcLfel4DBlJK+w/NBmAdojl1ej0EX9leyVbcW5X?=
 =?us-ascii?Q?/li8sfRA147lztI08X3WY1GG04U/ef/sMoi1B3HzVITj7zQFDpWUEJatAY8k?=
 =?us-ascii?Q?WqIguX3b3endM9DeGj0hqZfM/1DobPwaMszQ6vdH0FDvSbMdVELqnPdAvT7v?=
 =?us-ascii?Q?7pI/l6Q58D5zUL70vEZpXnYPczzvksD3PL+B4m7IfXBsYg434zxeBiaGOglL?=
 =?us-ascii?Q?ooTDJoxhSYXXCO+uLWRBKTJXmCBqQm7fMyk3vISh83ZiyB0pmB62tHMJqGOD?=
 =?us-ascii?Q?rlqVnoD/Ai0ReCeRwY5a3Rofx3yHZZ4ozKtD5jGozk/8pVA2JLbp4zrJrdMT?=
 =?us-ascii?Q?m8R+Oz+tgU9DtHL7FMzQVm9VwzEw7BPG5i1bq9Vlysq15exB7JbI6zLbT+m9?=
 =?us-ascii?Q?HxIXMaCwExUSEnAGAzzK9kxW3w6/nPaq1u6TdL8a3KbfrZSS9cIyyUezkdS3?=
 =?us-ascii?Q?Ff1PE9IiGY/rHVIgSv9hZhSRrSG+lXH67joAeU38ihX+QAyS+OZAz22tW8XH?=
 =?us-ascii?Q?USqSCdKlAqs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gPwnzTXEhoBnpS9c31IiUKrrdTNRAV3I++GA3z7qO/FXudRP9hCX66UxCd+p?=
 =?us-ascii?Q?goYvnVAAAU7UWIwA1QVp+XeDqKvizanM6ZslvwMR3Ncmcf1ewybRnPaiXsZX?=
 =?us-ascii?Q?EKyZzJCVk2+nJ9MwF08IlvgBUwLtec2gshmU/ayAlLdPjosHfXzd/zlzdtif?=
 =?us-ascii?Q?cJp80k40VUQjxfZezDwKiR3TvucDMtEBHl/7E/RGIuA7vbZlnkXymqdR8QWR?=
 =?us-ascii?Q?LKVCataNQqUAKYVI7pemAIsV4zx25Aq/Tv0Vky7uU8A3apHiGIQC8d0+H0AW?=
 =?us-ascii?Q?QF42dSU1cTrfeSRXGqdWika6EFWYr+1OMMdE47jDXqnjqcFFgX8UtVjvyXBq?=
 =?us-ascii?Q?sltT1qVBAOC48JkkdBmRCEh7j4bIMWlj2JbQdAmJogs88s5hkmYtGV2TyHMx?=
 =?us-ascii?Q?tCuEL8ATTUQJW7MV20v2sgUMmnUvrEgQtnXO1tcOv+chJGj+l/lgAYy8+VME?=
 =?us-ascii?Q?Phd1E3n9phDPSBbbQ3erYNhYXzAsbSuU6R3N2l8C4JzPQ2JiXwdCTOFv8Wmi?=
 =?us-ascii?Q?xi+8B0ogiF4IH2IjrKr6dzr6t6y+jIfdu228QZ7bvkbsB/ngxrK3waTgB4jg?=
 =?us-ascii?Q?qLcZrc+KoPb8oG47YswGQ6JxUq90AOhAl+jv2ERXFzNDeWyBgZ5+7JkGxg9X?=
 =?us-ascii?Q?BYhb05sggrGYyo+wuPsB9fewVSRoGRYPW6KGX8srDku6/7LSBR93CCvWsVx8?=
 =?us-ascii?Q?TwEdoFlFUdoRbPeQvNYIxmHtJgtzJ5fPs9gbynHgxehjpwr27foHdGPw05D6?=
 =?us-ascii?Q?b1O9V5O6e/vjC1rqDgxan3NjoPctgnrWdsDpbOdwRH/p3lrvYYZkJ+28TtYT?=
 =?us-ascii?Q?hwdOAWZXLLaCo8SZIlRyD/gAfjotLElOh5W0C5Wj5ZtYXfDvoN8sRpouVrDX?=
 =?us-ascii?Q?CrRC+q9G41iFx65Bayvdd/J3izf7IA9aG+HG5236D6IoxZ/pyM/56hnlU+jA?=
 =?us-ascii?Q?Zd3H4tnU+ESIH6/lrhRsD5Jl5nUeEcdZ2hKpZywIFDcYZg/kjjLFKETTlucN?=
 =?us-ascii?Q?ZCiIt6a69DIvyl7vBRM0MCR1VUkculgWbEjr+PnjCwo0qVWLRXLMb3FJJNGZ?=
 =?us-ascii?Q?wn8Dm1qKN9G3dlC5JfVqkuEFU1EDeEikZrTR8ZON5cdrQg259lkHZdcmsPB0?=
 =?us-ascii?Q?X1NaocYUvLEsxxTLkdZvN6dU33RU/BVJNSGsvRWSyRvmmIG44DbbimNKLzYN?=
 =?us-ascii?Q?fMgAhjS6AnweiqBtnf58PKGIm4eURK3ewlhIWDplu07aSMDid2Q7Gfzcy3zI?=
 =?us-ascii?Q?LkVeOUNVxFUPx8Wgj9KahdOdoF4hCUcOLLnqjuq8N/2t+TTK0KMjKCVD9PDa?=
 =?us-ascii?Q?W+gDxNsRH/RXjqsGYKjAgbjgFnM6yXO0s5rmLDjKSiLjSuKGRJfbyvs57Dtu?=
 =?us-ascii?Q?7tfa7A8T1g2aeE4d1KSbjQLP9HxDSWkFfvagNkVIZfnVCFUIDdtyYSU5tdrA?=
 =?us-ascii?Q?i/RP9QMSeJuC4k/aRfB+oNhbTeW6YE3vySBmvYYi7o5XtcdukBySvryHXkzf?=
 =?us-ascii?Q?wCKmLlVIGbm7gjFzYYi75TuetlNV5pbOVxf2/J5qnLAuI2lsicKgEDXswB7w?=
 =?us-ascii?Q?cPmY5DBE94PqKFM4nE6e4yPjZjt43KEyPhPC+79q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf73012-cadb-44cd-d7dc-08ddcad3b8c4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 17:01:24.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhM2F5G/v027FCKvKip8Lz0Qy8M+Cp3i7/v9sqagpCXLq8WrY6ScEZLqCu6/kzlAz8Ty+SGLLqzW6Vj5PnU81A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

On Wed, Jul 23, 2025 at 01:48:07PM -0500, Chris Arges wrote:
> 
> Ok, we can reproduce this problem!
> 
> I tried to simplify this reproducer, but it seems like what's needed is:
> - xdp program attached to mlx5 NIC
> - cpumap redirect
> - device redirect (map or just bpf_redirect)
> - frame gets turned into an skb
> Then from another machine send many flows of UDP traffic to trigger the problem.
> 
> I've put together a program that reproduces the issue here:
> - https://github.com/arges/xdp-redirector
>
Much appreciated! I fumbled around initially, not managing to get
traffic to the xdp_devmap stage. But further debugging revealed that GRO
needs to be enabled on the veth devices for XDP redir to work to the
xdp_devmap. After that I managed to reproduce your issue.

Now I can start looking into it.

> In general the failure manifests with many different WARNs such as:
> include/net/page_pool/helpers.h:277 mlx5e_page_release_fragmented.isra.0+0xf7/0x150 [mlx5_core]
> Then the machine crashes.
> 
> I was able to get a crashdump which shows:
> ```
> PID: 0        TASK: ffff8c0910134380  CPU: 76   COMMAND: "swapper/76"
>  #0 [fffffe10906d3ea8] crash_nmi_callback at ffffffffadc5c4fd
>  #1 [fffffe10906d3eb0] default_do_nmi at ffffffffae9524f0
>  #2 [fffffe10906d3ed0] exc_nmi at ffffffffae952733
>  #3 [fffffe10906d3ef0] end_repeat_nmi at ffffffffaea01bfd
>     [exception RIP: io_serial_in+25]
>     RIP: ffffffffae4cd489  RSP: ffffb3c60d6049e8  RFLAGS: 00000002
>     RAX: ffffffffae4cd400  RBX: 00000000000025d8  RCX: 0000000000000000
>     RDX: 00000000000002fd  RSI: 0000000000000005  RDI: ffffffffb10a9cb0
>     RBP: 0000000000000000   R8: 2d2d2d2d2d2d2d2d   R9: 656820747563205b
>     R10: 000000002d2d2d2d  R11: 000000002d2d2d2d  R12: ffffffffb0fa5610
>     R13: 0000000000000000  R14: 0000000000000000  R15: ffffffffb10a9cb0
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <NMI exception stack> ---
>  #4 [ffffb3c60d6049e8] io_serial_in at ffffffffae4cd489
>  #5 [ffffb3c60d6049e8] serial8250_console_write at ffffffffae4d2fcf
>  #6 [ffffb3c60d604a80] console_flush_all at ffffffffadd1cf26
>  #7 [ffffb3c60d604b00] console_unlock at ffffffffadd1d1df
>  #8 [ffffb3c60d604b48] vprintk_emit at ffffffffadd1dda1
>  #9 [ffffb3c60d604b98] _printk at ffffffffae90250c
> #10 [ffffb3c60d604bf8] report_bug.cold at ffffffffae95001d
> #11 [ffffb3c60d604c38] handle_bug at ffffffffae950e91
> #12 [ffffb3c60d604c58] exc_invalid_op at ffffffffae9512b7
> #13 [ffffb3c60d604c70] asm_exc_invalid_op at ffffffffaea0123a
>     [exception RIP: mlx5e_page_release_fragmented+85]
>     RIP: ffffffffc25f75c5  RSP: ffffb3c60d604d20  RFLAGS: 00010293
>     RAX: 000000000000003f  RBX: ffff8bfa8f059fd0  RCX: ffffe3bf1992a180
>     RDX: 000000000000003d  RSI: ffffe3bf1992a180  RDI: ffff8bf9b0784000
>     RBP: 0000000000000040   R8: 00000000000001d2   R9: 0000000000000006
>     R10: ffff8c06de22f380  R11: ffff8bfcfe6cd680  R12: 00000000000001d2
>     R13: 000000000000002b  R14: ffff8bf9b0784000  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> #14 [ffffb3c60d604d20] mlx5e_free_rx_wqes at ffffffffc25f7e2f [mlx5_core]
> #15 [ffffb3c60d604d58] mlx5e_post_rx_wqes at ffffffffc25f877c [mlx5_core]
> #16 [ffffb3c60d604dc0] mlx5e_napi_poll at ffffffffc25fdd27 [mlx5_core]
> #17 [ffffb3c60d604e20] __napi_poll at ffffffffae6a8ddb
> #18 [ffffb3c60d604e90] __napi_poll at ffffffffae6a8db5
> #19 [ffffb3c60d604e98] net_rx_action at ffffffffae6a95f1
> #20 [ffffb3c60d604f98] handle_softirqs at ffffffffadc9d4bf
> #21 [ffffb3c60d604fe8] irq_exit_rcu at ffffffffadc9e057
> #22 [ffffb3c60d604ff0] common_interrupt at ffffffffae952015
> --- <IRQ stack> ---
> #23 [ffffb3c60c837de8] asm_common_interrupt at ffffffffaea01466
>     [exception RIP: cpuidle_enter_state+184]
>     RIP: ffffffffae955c38  RSP: ffffb3c60c837e98  RFLAGS: 00000202
>     RAX: ffff8c0cffc00000  RBX: ffff8c0911002400  RCX: 0000000000000000
>     RDX: 00003c630b2d073a  RSI: ffffffe519600d10  RDI: 0000000000000000
>     RBP: 0000000000000001   R8: 0000000000000002   R9: 0000000000000001
>     R10: ffff8c0cffc330c4  R11: 071c71c71c71c71c  R12: ffffffffb05ff820
>     R13: 00003c630b2d073a  R14: 0000000000000001  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> #24 [ffffb3c60c837ed0] cpuidle_enter at ffffffffae64b4ad
> #25 [ffffb3c60c837ef0] do_idle at ffffffffadcfa7c6
> #26 [ffffb3c60c837f30] cpu_startup_entry at ffffffffadcfaa09
> #27 [ffffb3c60c837f40] start_secondary at ffffffffadc5ec77
> #28 [ffffb3c60c837f50] common_startup_64 at ffffffffadc24d5d
> ```
> 
> Assuming (this is x86_64):
> RDI=ffff8bf9b0784000 (rq)
> RSI=ffffe3bf1992a180 (frag_page)
> 
> ```
> static void mlx5e_page_release_fragmented(struct mlx5e_rq *rq,
>                                           struct mlx5e_frag_page *frag_page)
> {
>         u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
>         struct page *page = frag_page->page;
> 
>         if (page_pool_unref_page(page, drain_count) == 0)
>                 page_pool_put_unrefed_page(rq->page_pool, page, -1, true);
> }
> ```
> 
> crash> struct mlx5e_frag_page ffffe3bf1992a180
> struct mlx5e_frag_page {
>   page = 0x26ffff800000000,
>   frags = 49856
> }
>
Most incorrect fragment counting issues have a tendency to show up here.

Thanks,
Dragos

