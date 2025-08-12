Return-Path: <bpf+bounces-65435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC10B22BED
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 17:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D73503C4D
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF2302CBD;
	Tue, 12 Aug 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fhhy1Kwo"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8C302CAC;
	Tue, 12 Aug 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013454; cv=fail; b=OjswqHlwwzS4//spnqDh+2VqrW9vIKdpfL113WyUf3jkg5tR2OosTee7e4gkXbJ1h/3REmwpliPJcaCO7zRm2tslfAeFLkh2tuhV+vjwfBi0eGe6mdPd8M1B88EGK5w2Xu1XyoHPxhKyvfH0/UpM+SyGA1asnLv8GDUdC871Ke0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013454; c=relaxed/simple;
	bh=dJInMaU6uwHQkT7Y5dOpp3Ohzn3bFvfTKRpnkcL23wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NtvlQxv5SrRNZLa3W0vZ4PQTmdk2pLmfPnbSjKUzgt8BYCfataTKFlk/e5ZkmmI8L1Tt6yoMMQnRxLIV+MVFkNloJaD6qrOVcGaxJ3x87i7wksDpEQvRKd49ZE7vBBLXtCGDCFtj73Wt8pq67Q1L5GXn8z3Z7pUVHSo8UOaTGSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fhhy1Kwo; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/IZDLGwcxG79uAmzsw5o1Dr2vFQdgaBBNuXrB4cSmOg+z9NUCs1tPcRGlz7MVkBMwG096CbnmLlMz20Ez3igXsd/WXXPHbGulNi0a1PdDku9By5y3bUztwvVE8mJDOigXv3xXIqW9dR7AL1LlaNC9ojwxmCMqSjTElnC3nUSXA6aNXHiLUe2rbmWinkTRfTAF8rqnkYOM5E3RQKPhYtuC8M3doPoQVOApBWNtagFeneAGwievnIYKfgGmcTaB6gmk0coGTbIGjT2Io6O1mDQP7TLHp7yVpuwESy7v0rmcEFeFL9jmlsR7mVEvUJOAoNvo0xCY2ZFT50lo6cICGy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0ePAIyWSt7/LagP2OgB0w6UnkFWmQX0yxNh1gmgaaQ=;
 b=jSgjuVF7NvKrnhvcjaD+q7Qg/tzboVEuxVs6wVlAlmcKa9BT9RSNvANAi7P9qCzXseEBg+D3VHSGBkIRqkqtIW3zneaWvHW3SHmyCUEhCfXkKIv21zPunZqGigwBZEDGmksAqHbKORB2H3OrTmzK6gWucC4EvvO4ctPnIrmgLzbFHrn3QUcK0fApmmzXrtm7hEgxzkZ1EzC9i6cBF+QybULwUdRR2+sB1V2UIY+KeONHMg2L2mfqs2OHOic9heeNMvxh/X4CcvUAQtdGplYOhv4fkBogkqI5OeP9bQkxTjuPIRadiY2nh8zR2KPPGn3Blj3RXkWYaqFJEk7cHM6UIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0ePAIyWSt7/LagP2OgB0w6UnkFWmQX0yxNh1gmgaaQ=;
 b=Fhhy1KwonAAXg7uBVZu3NQJ6mjfLyGEAPmSK6JCbWj8IC/NPa3eLzeKzDNqNFdU4q2THzNWIaNxU+vEehAeGGWNK0wkX6ozucqSosBmo7AnbsHgFSwvub4/wKIHYsczjvUU+lkg3YTVBSHj0Q+VkwIH33/zt6UijOosjS+ovklT5VfgpP31gdMq4yE+YYqdZeRkTdARPyRZUTx3F5zMblV+EgX9rVdRyeLeup2s2jaGlj0krzje5OwHEhRSrzt/THaP7+Sz7A0R7FugTrbgc0JeHbvLoGBGNx0dp3Us11e/g3czZg9gfYlov35yiEgfpYIiQQp8m4n8XtKqNFcy21g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CY3PR12MB9607.namprd12.prod.outlook.com (2603:10b6:930:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Tue, 12 Aug
 2025 15:44:07 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 15:44:07 +0000
Date: Tue, 12 Aug 2025 15:44:04 +0000
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
Message-ID: <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
 <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
 <aIEuZy6fUj_4wtQ6@861G6M3>
 <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>
 <aJTYNG1AroAnvV31@861G6M3>
 <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CY3PR12MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ac1834-0fe8-4927-40b4-08ddd9b71276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FqYj1zwGINKfq9kRuQgwY5k5CuqTT+qfXkoxXnz+u+ppN84PraAAx7zdE2cn?=
 =?us-ascii?Q?6zRAIh1kXitKP/N9RNbcg6BBnyB4r+MFphXHSq1F9ETPFXmayiWEOB0YOH30?=
 =?us-ascii?Q?4kR4AbXB4JtETYRjOULtfxX78IEDHdM1v6CDjS9UVvHmxAApHO+LlkvNWhJy?=
 =?us-ascii?Q?nkdS2neEWZLT0yk8pPm5mLq/PRI/zr41IDy88vov9Iv5yB+D152TLLsVmxeR?=
 =?us-ascii?Q?e0Za/Ba7zGOv9/d//zzKvWgsrQmN+nR0M29SqjB2uZxtusLutZIdi6frA+PJ?=
 =?us-ascii?Q?PjfVQc0DflogjDgjEZLBTzwe3j6NVVlyP75XQ3iXVl/lm4q74NdLcKYvAsC6?=
 =?us-ascii?Q?3+WGNLxFQIq/UrB3uxfjwY5fPykT6Pq0F8LZa+TXB7sZMpn2OTAUu/8o2tyu?=
 =?us-ascii?Q?YS8IS3TRJkEIOAPGmNWB+yhNlSB9ge2OPpwg8SmKszQIpIpSpvTWQSAPd2D+?=
 =?us-ascii?Q?OjP8YGeiR3Jxe1n92TYujwfd18YwGF/pPJxq3DckVxT6QRSEASXEBlnv63fx?=
 =?us-ascii?Q?sbL8y3hK4e/HJWJ7a0p3jw1NdKl5+t1XBhlkhcbG24AXnuL8RAjXVVt7cqOm?=
 =?us-ascii?Q?W3IyfEQsRUbbXPEKdc0l0vziMC5E03KcbvyyytYuABk4el6BjiUFI+Ekgumf?=
 =?us-ascii?Q?tid/oQVPPQCkQcAcYRhacnQzh3O+rA0SfVSsPXdcJz9g1ku1IS700ALisr5j?=
 =?us-ascii?Q?P6RNhu+HOfm0VXqJxzzTi3nddAUe1X4HF4F5O0/rWRYKKrpd8Sw9nRYZDhV4?=
 =?us-ascii?Q?HW4IaYlkVHcXhkUz2Q21TCxTR1jJk3nfp9T1nCVGZo0LksKbUf5q4j5FtX4S?=
 =?us-ascii?Q?PLtxCEUIHREcgDs99KxtzRFeZlDIijh5JRroIGMH9p1X35BtVqsWJRBu1DKW?=
 =?us-ascii?Q?hPKHap6aA6kQsWR2ucqeixau/ZRwcHxUinQwtLiNG9JoV21X3S/ElD/fKG7H?=
 =?us-ascii?Q?poVW+tznr0WkEXmPK79ZiT79WZQnzPnEQaIct6/70xSHT5TafgVU0OgtD5s/?=
 =?us-ascii?Q?FZO5f63LjnQzeXQ/+6u2dZ0WSYl4oyfJ1BiC3FuC2AAfFEhp21Q2kq0WHkxp?=
 =?us-ascii?Q?+UIex7jdUa7wF5f9ud5xnUa9+2YKb9TXXKt8NniIyndqZkivoaxcLO8D4tnj?=
 =?us-ascii?Q?CllnpYl0n0jO/9HMd8uFwUTg0rKXAwJnxrRV9tBH2eEWN8ybnOEKOh+ctUDx?=
 =?us-ascii?Q?hoGLlxteGz0CIGotsuxxfLNP1pKKbUeHwoIRG0q2qFolEuABZc5hu1ajhSwO?=
 =?us-ascii?Q?x+E4gL/xsSgS9/9yRkWRaKb0wddovWFrMQQ6muQO/LKztSTDFZjEMdQc2QzU?=
 =?us-ascii?Q?E1L6rEOPfAZsqyU8Yn/HCX18KmkG78XdgPSGLUFUTenXEXzmtj7lntIvvCoI?=
 =?us-ascii?Q?YJ7KKu9G5w+fygTr7CjYNWqLWn2+Rrs+U5iKIpBM4cxKhrP0XVL+/KVnQ6EB?=
 =?us-ascii?Q?NAq33gXCcCs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZViNBBWYdM5V+GSgjGyfWoIpFuIpqIu2nUKPkDsliaypUcG/ynrzGQw+l9Hg?=
 =?us-ascii?Q?6dr0bUeSFeFN4zZBIOd3yCIpz9RsNaU3QEEaLTbyetHPqpWha76GQfv7A9Bc?=
 =?us-ascii?Q?8xJpnFL7cgADOjCxgGXWBHaWUdWFdhTTOYU10wdCPtt9/zhFbS2cKdGbJJi9?=
 =?us-ascii?Q?01MoousbVl9EomRG9paoqrgjYTjmPHxJyCM8yRKbitfbWgavgg7chnFfwFIv?=
 =?us-ascii?Q?e9JBXyF7UykGMY76JDdCEOyjgKi3DchBT7MuPoWMwlQxkNnc/X51V6i4iN1m?=
 =?us-ascii?Q?JUy6/uFczKBej1G6YCif4nyuvPKG8bQPxIB2s2yI5I3hUE8LVLwXCSudZRl5?=
 =?us-ascii?Q?1LIMVNIAdVkwqmFSHeQb0LHPbAcGNr/2q1ChvO/YLcd1zc+PiHJ+L2UeUUOx?=
 =?us-ascii?Q?c6zvMZm1A8Fknb6fDgvVOUP7YFBiztn6Ve0t3Orhgr+Y0W9mRvoK6bH4C9+p?=
 =?us-ascii?Q?3MOWYgNa4gNQJGOslbyX4RwLc8AHdWIcucpp6zYDcvPxKMii78gzSv5Uqxsz?=
 =?us-ascii?Q?TK25GZqoJwTUikKXcN8pKq2IPb4EZB7KN5VzK4M8nBDc9VFm7ljoJa4D2trU?=
 =?us-ascii?Q?yg37isMW5Ns1VoeFjtuGrxKOjazgNO/dw8ZorMpLXKHTzXZ5Hv++A4LeyfnN?=
 =?us-ascii?Q?OmwcXSIHHmA4u+Bk8EeCpU6dbeuCMGU+SgLsBUat5DF0E8mQe04Rf7b25ll4?=
 =?us-ascii?Q?JEWhsCN+eks7DXmB4iBvOHoM7Hc3R6wjoeJBM5KBnJT/7Y+r0RhjnDeEgU7p?=
 =?us-ascii?Q?uyQqE3J4CiPU2oOOmqZsO39JMztwjVa32Sz2OlmofB8l8xEBzhDR38h+KpX2?=
 =?us-ascii?Q?Ib9MS365GWD+o/U0otBnytL4TMaGjr32YgN8na1LS3Cv+/GyiXc6Q116Om3N?=
 =?us-ascii?Q?Ksf8GCdNa5ZAyw/MWUEoRkF+DnHKqNOmXk1zT4mWKFyuBXe3eVHXJC9tBKXP?=
 =?us-ascii?Q?sSieqBd6FoXLH3IYycW/l0mA66ABn8yXrjQ7y90rH3Lb2lpI7UM/zVgb+8q6?=
 =?us-ascii?Q?gF0DFuYF9O2vV5BX/HaFGh0ldUEXmg2JNuA00j44a72oFRGmLDvSRDHzxMod?=
 =?us-ascii?Q?KCCHWRyIHA3D6sl4nuZg7tkGNNY9jdp4O4mLwHzSNJaTgqOgCxl1DalNf6gy?=
 =?us-ascii?Q?kIbLfpjIYKKt0FTaXCqe6A9lVX6y8Id983D9UvgMbj7F8CqUZMM1B8EjAlaR?=
 =?us-ascii?Q?YGeMML5K2j4oljDsuGj2Us7U0iEbyaC4fgOb94i73Us42kQFZimKQYVHFCEd?=
 =?us-ascii?Q?RLJONj6NfGA7B7Ir8eCJbGdaVsr/mQkwble45dhBz9qtkA29IpveVlWR/0tn?=
 =?us-ascii?Q?9KMZ99ZVYNEzeyvsUQziazm0QAoybNHlCeJHcz1JRl+VDN9NqB9N0fo/81Pr?=
 =?us-ascii?Q?I2GK0YfTbLh7V4nXkf7e+IVqKG/DinhObN1kQamxzft5vnTsKaumSJzdhsFP?=
 =?us-ascii?Q?Zyn2BixLcxc3uUCvgkTkfo87c6FAlE5iM/6Eaf6qVSs8NgJLzREAGFrcrKr0?=
 =?us-ascii?Q?hFLbjQCl6hu9lU4YfatnTvD6oASLvBbgRxWEiFk1gQQ852FAUri+NveM1tH9?=
 =?us-ascii?Q?N3gSFdaF/lKHPjmIfVrUVcZPlhsBA3w3sKPL4rXA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ac1834-0fe8-4927-40b4-08ddd9b71276
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:44:07.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jx45rPUyXa8qr7shm7kIUcax8tUeZn/bqx3uLCNZoDn9fb9IqLQBJ/FOQb9uqpjguZL0X53Usi8oseZAfwPyBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9607

Hi Chris,

On Mon, Aug 11, 2025 at 08:37:56AM +0000, Dragos Tatulea wrote:
> Hi Chris,
> 
> Sorry for the late reply, I was on holiday.
> 
> On Thu, Aug 07, 2025 at 11:45:40AM -0500, Chris Arges wrote:
> > On 2025-07-24 17:01:16, Dragos Tatulea wrote:
> > > On Wed, Jul 23, 2025 at 01:48:07PM -0500, Chris Arges wrote:
> > > > 
> > > > Ok, we can reproduce this problem!
> > > > 
> > > > I tried to simplify this reproducer, but it seems like what's needed is:
> > > > - xdp program attached to mlx5 NIC
> > > > - cpumap redirect
> > > > - device redirect (map or just bpf_redirect)
> > > > - frame gets turned into an skb
> > > > Then from another machine send many flows of UDP traffic to trigger the problem.
> > > > 
> > > > I've put together a program that reproduces the issue here:
> > > > - https://github.com/arges/xdp-redirector
> > > >
> > > Much appreciated! I fumbled around initially, not managing to get
> > > traffic to the xdp_devmap stage. But further debugging revealed that GRO
> > > needs to be enabled on the veth devices for XDP redir to work to the
> > > xdp_devmap. After that I managed to reproduce your issue.
> > > 
> > > Now I can start looking into it.
> > > 
> > 
> > Dragos,
> > 
> > There was a similar reference counting issue identified in:
> > https://lore.kernel.org/all/20250801170754.2439577-1-kuba@kernel.org/
> > 
> > Part of the commit message mentioned:
> > > Unfortunately for fbnic since commit f7dc3248dcfb ("skbuff: Optimization
> > > of SKB coalescing for page pool") core _may_ actually take two extra
> > > pp refcounts, if one of them is returned before driver gives up the bias
> > > the ret < 0 check in page_pool_unref_netmem() will trigger.
> > 
> > In order to help debug the mlx5 issue caused by xdp redirection, I built a
> > kernel with commit f7dc3248dcfb reverted, but unfortunately I was still able
> > to reproduce the issue.
> Thanks for trying this.
> 
> > 
> > I am happy to try some other experiments, or if there are other ideas you have.
> >
> I am actively debugging the issue but progress is slow as it is not an
> easy one. So far I have been able to trace it back to the fact that the
> page_pool is returning the same page twice on allocation without having a
> release in between. As this is quite weird, I think I still have to
> trace it back a few more steps to find the actual issue.
>
Ok, so I think I've found the issue: there's some place which recycles
pages to the page_pool cache directly while running from a different CPU
than it should.

This happens when dropping frames during the __dev_flush() of the device
map from the cpumap cpu. Here's the call graph:
-> cpu_map_bpf_prog_run()
  -> xdp_do_flush (on redirects)
    -> __dev_flush()
      -> bq_xmit_all()
        -> xdp_return_frame_rx_napi() (called on drop)
          -> page_pool_put_full_netmem(pp, page, true) (always set to
	  true)

So normally xdp_do_flush() is called by the driver which happens from
the right NAPI context. But for cpumap + redirect it is called from the
cpumap CPU. So returning frames in this countext should be done with the
"no direct" flag set.

Could you try the below patch and check if you still get the crash? The
patch fixes specifically this flow, but I wonder if there are similar
places where this protection is missing.

Patch:

---
 kernel/bpf/devmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 482d284a1553..484216c7454d 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -408,8 +408,10 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
        /* If not all frames have been transmitted, it is our
         * responsibility to free them
         */
+       xdp_set_return_frame_no_direct();
        for (i = sent; unlikely(i < to_send); i++)
                xdp_return_frame_rx_napi(bq->q[i]);
+       xdp_clear_return_frame_no_direct();
 
 out:
        bq->count = 0;
-- 
2.50.1



