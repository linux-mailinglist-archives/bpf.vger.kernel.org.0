Return-Path: <bpf+bounces-65671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D2EB26CE1
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 18:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A95A01799
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81631F4611;
	Thu, 14 Aug 2025 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BdkxD14g"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA617BA9;
	Thu, 14 Aug 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189913; cv=fail; b=OYTFY42RqA+yZENfxPpA9Ch3ilu6Y+heIw3i5Ajv0a7f40NhQPBtQDlYxp7Sb91yeWsHHwAoOeywp3ACR9B2oRXueZYOldMXjhBdoB31/XflOLfTSPk6Fn+GeVzoiR9uL7Xm/skZ3t0IOWHzp4VQKuinKvOlR6Xo+YWX3gMSJE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189913; c=relaxed/simple;
	bh=Ymia/gOQQnXsgVByknahaUhIzHTnSjrIEyGtf2sL9TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iW6/hxeJMwk9tz6vkpRmtYdkp2uVls2r3qlxR8qRVZQAszLGHPS9RKm0r/8HplmJRh41EoC5NuQeeUYmw7/ywtADcismGNdSBCeQoyQHHwnlEg4wEit+jsd4fEgnP5lB7rJ27dxF5H4Y5t+YpOlbgTj5nOiGP1YuljLTp3WzyUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BdkxD14g; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqPfQOuRf2zS6QMjbBUNFKPZodAULpl3vWG61FGQuTn79htfMP0xH7TYdhTp78uS1fSgGz0X5PH6oVOkB1NVfk5AnGxN2wE2ZHlwjUscrmUBkiJE1ju05LeDq8SQeJhUcdYx0yH+6ptoRF67IixJD/Yw96FXyTGSPwFz5TIsN8hauXe5ZA3sRIqQGcd0gPqlwywFiO9PdpaNNUjIQQ2sm7okeytB7cAy1rPStl83rnRnFBoVR9GEidRHp/lpBq0/EsSZcRM1/Et4EjI/H4lorO7zY3H7voOsCn3cSfcoX9ZCRVYkatkv/FQC9ngg6ifHvu0LDAwqk6Ix74DlaJKD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIgupj/AcREbfYYsQcvdrKj44J8v2rKRfhAW3auxaBM=;
 b=SOnmO5XJP1bBuTwL30Ai11KvQjFFdnjuNLnZDZ2mc66+Tdi/+22V+euUrIaeyIZBMz8D3IW7lnJN1YA089tw3yUWICg3jR1+UiATQa47O3diwrMrNFCQCai+25szfAnnfFU2iDjUh72miHrTj1tqXpWMBqC5p+KDF2N9EhFDcZEgowxtbl0krbC4XtbxpLnoyprCIXsI/fKoqvDBO7T+0Xhr3l/w4frDEoPz7/Jj1J3rp4gpcgw+0q7+TatEoarbK09oUTCc5Xu1Xndg+UPrsVgKw13nb3zF6rBQkGZLZCdbe+Dy4Rk/Sufa2Y+vPHBKjYeSofi+e0CizyOf7lxajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIgupj/AcREbfYYsQcvdrKj44J8v2rKRfhAW3auxaBM=;
 b=BdkxD14gJP6q6EtO01VuKnObLTschgVzSLXvossvAg8lo3rafE8NDbMdt1NxK+FI+nav2Om6E30GLYSzr/DZ/WMEmzaoH675Q0GYSc62S5vpCkEs1H2gBJ0aF9Aksia1BCZuIw/URPus2iSh37DXZapYjb1Ro3y2gPgY/u+093m/4wPp51Vgj+BqpzyJOxCeXjejZyYv62araw4wUzVgZ9QwzIpQskPv5dj+OauBpFUmuhINZWmR54vtCZ1YgNisLsc9BcyDsn1afl195taEvwu3J488DEuzdZInG7QSuMVseNK0F0maoSfTptKCDEhUfF+vroxIsD9TrDM3ux9doA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 14 Aug
 2025 16:45:07 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:45:07 +0000
Date: Thu, 14 Aug 2025 16:45:00 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, 
	Chris Arges <carges@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>, tariqt@nvidia.com, 
	saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Rzeznik <arzeznik@cloudflare.com>, Yan Zhai <yan@cloudflare.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <e7s3ydwozr6fhdqlhnl3qpvkhgjc3ufi3o7pzdqh5ajzgojsnr@x4nklwsqd35s>
References: <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
 <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
 <72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>
 <aJuxY9oTtxSn4qZP@861G6M3>
 <aJzfPFCTlc35b2Bp@861G6M3>
 <5hinwlan55y6fl6ocilg7iccatuu5ftiyruf7wwfi44w5b4gpa@ainmdlgjtm5g>
 <4zkm7dmkxhfhf3cm7eniim26z6nbp3zsm4qttapg3xbvkrqhro@cvjnbr624m5h>
 <e60404e2-4782-409f-8596-ae21ce7272c4@kernel.org>
 <tyioy6vj2os2lnlirqxdbiwdaquoxd64lf3j3quqmyz6qvryft@xrfztbgfk7td>
 <8d165026-1477-46cb-94d4-a01e1da40833@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d165026-1477-46cb-94d4-a01e1da40833@kernel.org>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: f69d8e80-0441-4501-fa80-08dddb51ecae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Es7vf/++yfRbD2oEfzNfYewSORcr/xQ6v3mEypSJssuqqifDhVWdHSXXjLWM?=
 =?us-ascii?Q?6f/fsQOvWud1YNQ0q8/kNe4a5ne5AcleCPx2LCDskmvbHmtrfSmr43VhoWak?=
 =?us-ascii?Q?BU8TsGifZEgqFwNhJcqj6H1qDipK+0kIPA56hmwBM/zVt0jtv1Pte4gJdCjV?=
 =?us-ascii?Q?wTCQJcfGG7RuLhbAvGIK6YKBeKSl0VEY3nwkT/+dpNe6rS5xmJt0OmnBRkmq?=
 =?us-ascii?Q?giFH5PMaQCHQQh7IRYdGNZTMM/pnDjj7Jz4oe7rm3fvy8O8aAyrzzl/zRD/p?=
 =?us-ascii?Q?qbU0/b24TWZaJ59Prn0+8yEk0qIoiBpdh9e0Fqf33jNM2uAFikSJFmv46MJx?=
 =?us-ascii?Q?Kb/bz2eAr20OzWdwJ/NevWyiZHbWq4GLHmu1GzT/+Q2fV3HkOqbabQQKWQrk?=
 =?us-ascii?Q?9e6n08mOo4AHYHc88PAL+viSOb+We08sL5Ps/boi2JcSA63pESe5ETc0GJVY?=
 =?us-ascii?Q?4JWcPgWHB7DlwMQ/5RKefAIOvK0bZPW93xreQ3jiXm3dyTRxibSyTRX5EtUZ?=
 =?us-ascii?Q?J2dzKe1r+slQ6R99T0TcYv1IfumuONCeIjaRwdtMovv6zvzAj8UwFI0LqUV7?=
 =?us-ascii?Q?Lxa8q+XKJd0ilI630abZdu/Xa+ubCIIdwgtu9d9zINDXB832dho6ONiNzP4a?=
 =?us-ascii?Q?z7gBo9xoBTAvNjbx2C3Hpsw94IiHQlnfBSBgu6b4NB/g1yQQs2kV2AL/Edyu?=
 =?us-ascii?Q?EoTjfAyafIwMekfCD733Nbg8rwAYaV7rMcW67tJYU59AQvufQj0xQynGJ+jV?=
 =?us-ascii?Q?SN5pUp/DFp7OhQiYKQmGkSOzoHvZADo8M5AHZJZ34GlqTF6vfX8tOLP173AW?=
 =?us-ascii?Q?PsPaZSuP9cT7GcV/AWIMeDu8QgRcaSEXczu5SNaESoJ8lwiMCIbiyHrr2dPQ?=
 =?us-ascii?Q?J80QvWdmsHRZpKOeI85PVIaUsrR62e5ockHrepgdMpaDVHilnD6CRNJm8mhT?=
 =?us-ascii?Q?/eGmkML/jx0cOeulphR/pJizP8clE/acLOElNjVaU9eNuUvi3X3T+35iw/oj?=
 =?us-ascii?Q?ZjrL3unULr/qop5TdDj8fzOYy/6NWKY5yhjQgV4Lutuxk6NCCjgvxFrbGSuF?=
 =?us-ascii?Q?0ZqV/ipll+xElsjeaUZqkVT1iWOypXwDnYMikHVpjO6m1nWKmbzvU+k+g4g2?=
 =?us-ascii?Q?oTXKxxkY00K+Wh+/C8clvYLQvLY43gw2JCEOLty23dDiGgez1aJwXuuEOV3k?=
 =?us-ascii?Q?B+R8yZBkmTwsJuaPTkeqv4vuFMgsb2S2+HtPO3jQsC9w7znYm840NpQmMOo2?=
 =?us-ascii?Q?bmwJNlA5zI+FUQIoKBXqqpLgbTNjJovHxkyceAy76oo9JLDGNDFKIFQT/0Y1?=
 =?us-ascii?Q?obFg4waDJf8srZ8t2twBvu4tzt0oswjYO+bJ80oUGr+jc/7eW/SEIkb+onW3?=
 =?us-ascii?Q?7o/6uOpAEksrl9yrscG9dcXiN/7ca3tYKTSU3Z9DysHvP3+YeqghN78AQmTv?=
 =?us-ascii?Q?MVxzeRgmzpM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NtE2XcAy6DekFMN+Btm4zwc0zf37TCt5pwJrSiBfISLIUM5sSGvv5mKyR/ot?=
 =?us-ascii?Q?qEvoK9kkjEKjrc6zr+zQsrUbdjzL3QHCoC/777ikSJ4bBgkBCt7E9KcRLTlx?=
 =?us-ascii?Q?wq81eJfYtcz9MOceY0dgzq28Fkn721ETujac6qGK5+7JoN1Q+M0nLdDu/zCZ?=
 =?us-ascii?Q?/HS3apISTn0GHiKvJKjPpZk5JVnxNTP5HFqaLqdqu/5reql5Z8JOBq6HdY8G?=
 =?us-ascii?Q?lZwMMUPghaVyxsyXpkx3HJng3Kp+q1qCCAe7q9edKC06TVU0/rI0q7uh/tyz?=
 =?us-ascii?Q?WMkuzCPZ5xzZxEwJ6LWpWs+n79htNSwywkCNGuj9fOJqAburhgJHQkxH8+jy?=
 =?us-ascii?Q?mKU4pN4zVcSXdTZFu8UM8wrBTaPNKoKIqaCTgppfOC3pwqCA0nLxWkR3bsFQ?=
 =?us-ascii?Q?Y7m+USe9W4tjUCtOjB9H/gvyXNwN9UFoJHPkLm1xtf71SHUPfKU6+ewbK5Bz?=
 =?us-ascii?Q?1HT15Ag0mk1xd5psNCTjN2C9Rohrid/2xzqDnTKYs+dtQXOTZYa0egBittYF?=
 =?us-ascii?Q?EV2akBukrH76tVg2OtlFN15uRYSHkROiKC+aqCPlmxwpU7OYbBuVVnlhbA1N?=
 =?us-ascii?Q?Y0sRv/tMx7+U4ji1o613TjN3l3jXPQ97TWqHTU7tT1q/yE3M0WJoXI6Hn5Hg?=
 =?us-ascii?Q?qWVw2QPfAYIFafcaDC8pRI8qsqtSOg0rWxjGlM/Gpd7cdOnlFatp59WwOMai?=
 =?us-ascii?Q?WjunbpyT2B2lXUmYvYXaxXwnlNnHZf+aJJili6R5bgiF9Lj+xxzrE2NMVyMw?=
 =?us-ascii?Q?EesSKsm2rOG7tbzeIUIUnWSxTCcg/W5tiK/wJs3G22v3PD3hjnf6tJsl/sRq?=
 =?us-ascii?Q?zTE+Ce1d7H2SK2hVNc0nvgMgvRRCsbENTtjxYnO+lblGfPaXfh+sLz7Wobgp?=
 =?us-ascii?Q?3YQImraaHHZNkz9HX74Xs1JQRBcO4mLvwps0wmbvBjIypMGe8HboYbUS48t+?=
 =?us-ascii?Q?NIRpkPgpCOamNgEbXi4H4JGOZSqU2UWoPROi7zVdxhhByGsLJdWSFisgbYZl?=
 =?us-ascii?Q?KhI6QOKWFPrpHUjZ78dviqeLXib9vGbWZUh2zR7Oh85TyDN+7xbp5Zc5sgCI?=
 =?us-ascii?Q?1RvRrxFfBg76BSYVFrMyz8Wys/IPdTEm1/g9fvmSy/T7wL+eMi1LmKI30fWW?=
 =?us-ascii?Q?rd+NzbMgn0hwFmiMyeQZmaYpdFB1ALHaSnC7yHREDSeg4yPhmmtaxzWIg1xX?=
 =?us-ascii?Q?IOs4AFAM4Bxrl8Wik9CZHU7JfH4bRMnrAV7CPlI/cJSW+FWucoCsjJkwmDb/?=
 =?us-ascii?Q?H/ttMjF/Hch/donM1QhluLkw1KHeMNnBJLaX6I/goA9Wzi05YyR5955+86Uh?=
 =?us-ascii?Q?wdgYE4j4xsl3ezlQc1YPMUB/SP8NDOPwJUIA/eZlp1KtP8uqngY2LIsQTctb?=
 =?us-ascii?Q?TqRWLnHPQZkSXRVgdFF7dBVHuL7ex41ActG7hZXw++8E6P1oVg9+vMKa7uqT?=
 =?us-ascii?Q?kw+GrlsAnM6l8eXtqJHlGjOX382STnJaysNWoeXdexrh5mQvwNpvZOnpiUJA?=
 =?us-ascii?Q?zw3AM7g2kf/ETs9Z4hu5spOulGFJFek6BK92egoBsZYbhagQkIC8AvnXeJoK?=
 =?us-ascii?Q?pZ5c4Hgw9j9F7nVBz4ttUHzRN7ZzQehY2mWIP7IU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69d8e80-0441-4501-fa80-08dddb51ecae
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:45:06.9504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kk7QAOw+Gvg5CzI9VHd9nV34fh/xXKIGxlWk6ZNQW3iGS4Xn/grt4Euot+yFhPAmYXIpD0lCv8X2Cs2U4HK4XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

On Thu, Aug 14, 2025 at 05:58:21PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 14/08/2025 16.42, Dragos Tatulea wrote:
> > On Thu, Aug 14, 2025 at 01:26:37PM +0200, Jesper Dangaard Brouer wrote:
> > > 
> > > 
> > > On 13/08/2025 22.24, Dragos Tatulea wrote:
> > > > On Wed, Aug 13, 2025 at 07:26:49PM +0000, Dragos Tatulea wrote:
> > > > > On Wed, Aug 13, 2025 at 01:53:48PM -0500, Chris Arges wrote:
> > > > > > On 2025-08-12 16:25:58, Chris Arges wrote:
> > > > > > > On 2025-08-12 20:19:30, Dragos Tatulea wrote:
> > > > > > > > On Tue, Aug 12, 2025 at 11:55:39AM -0700, Jesse Brandeburg wrote:
> > > > > > > > > On 8/12/25 8:44 AM, 'Dragos Tatulea' via kernel-team wrote:
> > > > > > > > > 
> > > > > > > > > > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > > > > > > > > > index 482d284a1553..484216c7454d 100644
> > > > > > > > > > --- a/kernel/bpf/devmap.c
> > > > > > > > > > +++ b/kernel/bpf/devmap.c
> > > > > > > > > > @@ -408,8 +408,10 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> > > > > > > > > >            /* If not all frames have been transmitted, it is our
> > > > > > > > > >             * responsibility to free them
> > > > > > > > > >             */
> > > > > > > > > > +       xdp_set_return_frame_no_direct();
> > > > > > > > > >            for (i = sent; unlikely(i < to_send); i++)
> > > > > > > > > >                    xdp_return_frame_rx_napi(bq->q[i]);
> > > > > > > > > > +       xdp_clear_return_frame_no_direct();
> > > > > > > > > 
> > > > > > > > > Why can't this instead just be xdp_return_frame(bq->q[i]); with no
> > > > > > > > > "no_direct" fussing?
> > > > > > > > > 
> > > > > > > > > Wouldn't this be the safest way for this function to call frame completion?
> > > > > > > > > It seems like presuming the calling context is napi is wrong?
> > > > > > > > > 
> > > > > > > > It would be better indeed. Thanks for removing my horse glasses!
> > > > > > > > 
> > > > > > > > Once Chris verifies that this works for him I can prepare a fix patch.
> > > > > > > > 
> > > > > > > Working on that now, I'm testing a kernel with the following change:
> > > > > > > 
> > > > > > > ---
> > > > > > > 
> > > > > > > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > > > > > > index 3aa002a47..ef86d9e06 100644
> > > > > > > --- a/kernel/bpf/devmap.c
> > > > > > > +++ b/kernel/bpf/devmap.c
> > > > > > > @@ -409,7 +409,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> > > > > > >            * responsibility to free them
> > > > > > >            */
> > > > > > >           for (i = sent; unlikely(i < to_send); i++)
> > > > > > > -               xdp_return_frame_rx_napi(bq->q[i]);
> > > > > > > +               xdp_return_frame(bq->q[i]);
> > > > > > >    out:
> > > > > > >           bq->count = 0;
> > > > > > 
> > > > > > This patch resolves the issue I was seeing and I am no longer able to
> > > > > > reproduce the issue. I tested for about 2 hours, when the reproducer usually
> > > > > > takes about 1-2 minutes.
> > > > > > 
> > > > > Thanks! Will send a patch tomorrow and also add you in the Tested-by tag.
> > > > > 
> > > 
> > > Looking at code ... there are more cases we need to deal with.
> > > If simply replacing xdp_return_frame_rx_napi() with xdp_return_frame.
> > > 
> > > The normal way to fix this is to use the helpers:
> > >   - xdp_set_return_frame_no_direct();
> > >   - xdp_clear_return_frame_no_direct()
> > > 
> > > Because __xdp_return() code[1] via xdp_return_frame_no_direct() will
> > > disable those napi_direct requests.
> > > 
> > >   [1] https://elixir.bootlin.com/linux/v6.16/source/net/core/xdp.c#L439
> > > 
> > > Something doesn't add-up, because the remote CPUMAP bpf-prog that redirects
> > > to veth is running in cpu_map_bpf_prog_run_xdp()[2] and that function
> > > already uses the xdp_set_return_frame_no_direct() helper.
> > > 
> > >   [2] https://elixir.bootlin.com/linux/v6.16/source/kernel/bpf/cpumap.c#L189
> > > 
> > > I see the bug now... attached a patch with the fix.
> > > The scope for the "no_direct" forgot to wrap the xdp_do_flush() call.
> > > 
> > > Looks like bug was introduced in 11941f8a8536 ("bpf: cpumap: Implement
> > > generic cpumap") v5.15.
> > > 
> > Nice! Thanks for looking at this! Will you send the patch separately?
> > 
> 
> Yes, I will send the patch as an official patch.
> 
> I want to give both of you credit, so I'm considering adding these tags
> to the patch description (WDYT):
> 
> Found-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reported-by: Chris Arges <carges@cloudflare.com>
>
Sure. Much appreciated.

> 
> > > > > As follow up work it would be good to have a way to catch this family of
> > > > > issues. Something in the lines of the patch below.
> > > > > 
> > > 
> > > Yes, please, we want something that can catch these kind of hard to find
> > > bugs.
> > > 
> > Will send a patch when I find some time.
> > 
> 
> Great! :-)
> 
> > > > > Thanks,
> > > > > Dragos
> > > > > 
> > > > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > > > index f1373756cd0f..0c498fbd8df6 100644
> > > > > --- a/net/core/page_pool.c
> > > > > +++ b/net/core/page_pool.c
> > > > > @@ -794,6 +794,10 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
> > > > >    {
> > > > >           lockdep_assert_no_hardirq();
> > > > > +#ifdef CONFIG_PAGE_POOL_CACHEDEBUG
> > > > > +       WARN(page_pool_napi_local(pool), "Page pool cache access from non-direct napi context");
> > > > I meant to negate the condition here.
> > > > 
> > > 
> > > The XDP code have evolved since the xdp_set_return_frame_no_direct()
> > > calls were added.  Now page_pool keeps track of pp->napi and
> > > pool-> cpuid.  Maybe the __xdp_return [1] checks should be updated?
> > > (and maybe it allows us to remove the no_direct helpers).
> > > 
> > So you mean to drop the napi_direct flag in __xdp_return and let
> > page_pool_put_unrefed_netmem() decide if direct should be used by
> > page_pool_napi_local()?
> 
> Yes, something like that, but I would like Kuba/Jakub's input, as IIRC
> he introduced the page_pool->cpuid and page_pool->napi.
> 
> There are some corner-cases we need to consider if they are valid.  If
> cpumap get redirected to the *same* CPU as "previous" NAPI instance,
> which then makes page_pool->cpuid match, is it then still valid to do
> "direct" return(?).
Understood. Let's see.

Thanks,
Dragos

