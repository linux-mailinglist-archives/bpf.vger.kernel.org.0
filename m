Return-Path: <bpf+bounces-65540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE73B2547E
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7926A4E0259
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE562F99A2;
	Wed, 13 Aug 2025 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uiu0T7zy"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260DB2D663D;
	Wed, 13 Aug 2025 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755116689; cv=fail; b=tH249raebYXZbsGH+N6+SnOjDwvQX8eQlGVEgXcmcrS7/axBrdiF7DjuhA6wsX5BpqeEFWwtrsY439zxD8Pu0no7WUIbOZ2Tab7nyY9XE8cgWRoYCYhE4QxOMQz77KaYvMzDpWsOUlKqhlKWFH5zv0VR5+2K6vVUHad9Sy4BwC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755116689; c=relaxed/simple;
	bh=MJesp1bqoy+f/S803nE1xfk8wzUAyByaIZwp8DNs3cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zk8U0Y8eS2hWXQ6TxDcHk6QvGj4rwaOxhzKgHfiM5CoUVnSF4R9zB6Y92+5he58BSiipYDkQ8uWI4phmZLipAoSNp1vY9UNQezKn7XGhj81knBdVd3qWJP7NMcB/kNHI6Op5Fyy2+qJNel1K67mvFxgYeDhtQd36c1XrZ+eg2oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uiu0T7zy; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKYjZ6vPOnNVMUMqHASq/OebJD1wiPodI14RNeyqdq5MLLQlTqjW8FQIxaRiedbtNaL8cj49OS/cP9feErs3px4ZUTrRshcmEUBRfpKEqoEG39V77W6m9dPTjkF/1rend95dWZzy5YfCs4t4jv7Bg6TFQSDwnFTts6Jqwnu6rzLiYjceplLUvZGqepL7OJJmmbPrbYlL2IH4lKonJ3jtqBnhZKcfR2cC0fBRwyZlSmoo8bpz4hB3t8GQwnZpriIfws4IJme8DbVx9vjOTJngvN9HZHCMYHWZYHYKyfDH7aMMRC+x8JCLHRCcEImVlD6GKYQBBjKhEpBJC54cWlM6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dvdcCl8JBgn3mGo481nkOElD2mUHuMmIg/JyrPuE1g=;
 b=Hx7bpUpOSlZ7n8GDYt65IjRCoORXXHBA6xJ/GJe9sZ/TRQI1qtQdlnM/bdNk95jUbZXh8QUc9516ATxjQNVbFsjr5sYss5lCkCG3PAwoAYlabzzBI3VwJi2d5hj7PSa304RzKef6F9Eh4GO7cF3+UoGoBToNZkdcldAtq5cBeJdIoeH0pShyt2qbUYMhsYsWt/cPqsUTQF7jXTxcXT51i47jM9CEQkqV8tQT11G4gN1IHH4QzLwYvxpc2aoDD7+l+2dQ+DWVwhccBdLrDKb0FeiI0m9uEzVGc9MOWV0Q7aoRakhL/luJ49RWqQZfZgylXflNCKIT9WgjuDJCgG0Npg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dvdcCl8JBgn3mGo481nkOElD2mUHuMmIg/JyrPuE1g=;
 b=uiu0T7zyfK0of4ueGTivQvuV/1OkKYhHlUydSgOiHive+QfPVpGNwKiK3lColB1bZg9EAM4SXvbhVU7KWbFraRUwjUrkOf7Q2+/TM8TCL1nH6y4N87rf4kSI5V8F6d7EzulAWhWnKPAWql9KihSTePcUAo3GX6k9N5hIfeZ8n4WSzuAlmJstWU86dw4R68LWjrBTcIzi+5r2zG0OYaSg2FfUl0fnIPu4ACAmK60GWYWyTs0An3dIIeSnJTpjGRyRAOEzAYRrHdH6GWagksuweWTH/RhYqBxWRmbsqOy4m3NtedTGSHCZ0QArclBeCaGO6l9hfHhDOyVYmoWoGVfnQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) by
 DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.22; Wed, 13 Aug 2025 20:24:44 +0000
Received: from DS0PR12MB9038.namprd12.prod.outlook.com
 ([fe80::7106:f1be:4972:9438]) by DS0PR12MB9038.namprd12.prod.outlook.com
 ([fe80::7106:f1be:4972:9438%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 20:24:43 +0000
Date: Wed, 13 Aug 2025 20:24:37 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Chris Arges <carges@cloudflare.com>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com, saeedm@nvidia.com, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Rzeznik <arzeznik@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <4zkm7dmkxhfhf3cm7eniim26z6nbp3zsm4qttapg3xbvkrqhro@cvjnbr624m5h>
References: <aIEuZy6fUj_4wtQ6@861G6M3>
 <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>
 <aJTYNG1AroAnvV31@861G6M3>
 <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
 <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
 <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
 <72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>
 <aJuxY9oTtxSn4qZP@861G6M3>
 <aJzfPFCTlc35b2Bp@861G6M3>
 <5hinwlan55y6fl6ocilg7iccatuu5ftiyruf7wwfi44w5b4gpa@ainmdlgjtm5g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5hinwlan55y6fl6ocilg7iccatuu5ftiyruf7wwfi44w5b4gpa@ainmdlgjtm5g>
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB9038:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: f33287c7-2212-4f7f-1384-08dddaa76fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?57W2C74ozNctqKfmiwjiMi/Fct3/SvudloHrBTavnR/FC82Y9eVgI9+StfaA?=
 =?us-ascii?Q?T9nHUCPzAOWvpl3hNArFLR5Nb5M30T223BL+x7DP5ygEOyb8zQaGjbecOSvP?=
 =?us-ascii?Q?3DHUqMBvQ2q4QNaGpz5VToAnSW3oZCll0As3DUDeU69nMRMOKoJVTgj1wiPF?=
 =?us-ascii?Q?ksaPvwhE16ocE64Fq4cPe36W3Q8WNXZgjhI73twflS38St53t1FW7YvRFEH1?=
 =?us-ascii?Q?QQ/ZQKrTijW5oZ5jFn/6BrdYSF7QuTa/E1xoEViw4VRUy4m8s6JqD+t3i5eQ?=
 =?us-ascii?Q?ux3Usslm7WWDueNlcoTpmWr6d68kGdQgZRb5o7FOtaUngW+HXFqLMBIem7nT?=
 =?us-ascii?Q?qyFGSsZRih8oHtWopO9ZKmvbzF2TpFyvwhMMGUOJ5QIQkEtJA/gQrSHsgVbR?=
 =?us-ascii?Q?QNUYAFiV7RBcNZ7+anQLSgIF113b3qicbctFqYerenO4zomKBHl/acQYkvXm?=
 =?us-ascii?Q?csmk77jlW5TqFGpHA3rfqq44lpimIMrl7H2pwvabzyVAayimIH9bMetAtLNx?=
 =?us-ascii?Q?BUWjC6HvgL+1jkGamlh5WUhkP3bTZPLMsEVCTIo21pSh+TXBV8EXJVzsOt47?=
 =?us-ascii?Q?ZPMjYsRu/u0H/z4UZH+/Pz1+jq5Y+EjJfWHpyURJlJ0vBICkxK16GyMFVSFd?=
 =?us-ascii?Q?brjLGu+5iqLC45Sl+zRFyLMUDVnj2agdAiTFcHdKGABDfcu2SlNJy9OLdwPM?=
 =?us-ascii?Q?hq+iNYmuWlozd+hy48Dp2EgahrB+PD6bEm8rAoIQJwtyz2s/BFxQ+96LsxHf?=
 =?us-ascii?Q?vTh0rEYTK1avj7Hefsc5s7BPhgkq4VDhX4L4fbMH5Yt6fpFTUpyDeTpE7Y18?=
 =?us-ascii?Q?FL+emcYRI+NUM1vtOnd021Wwi+xbI4nqBrctByqDlAIG7RU6SguXRXqa9jZk?=
 =?us-ascii?Q?cXg6TYCwlyJvb5QoUGIs2KP8MuVXSj2zgc6svdfwNgP27Hpew7nd6/IAS9r+?=
 =?us-ascii?Q?haaJubUQgvrulbOMWJQaakyDzvrW7PcNDiBWpAej6NxJE9/EMPayx+CdzBXS?=
 =?us-ascii?Q?ZG8QKSK+oWL/+QDt0jpYcZ8pF3smPoZEr/ujuq0q6wdKUTmT6S7T1cjd9pPE?=
 =?us-ascii?Q?MbiGSLNU888Udo0xfqLdjMDlIRcNfINBS2MmC7xwC2xtP/e28Xr5Tf6nE5qZ?=
 =?us-ascii?Q?yP/KxddB0BijdBoXmuzwcKSnvRDL491WMPMiusEIqiXVQ2AqE0EjaafG7BeV?=
 =?us-ascii?Q?L50y7pU6RpH9wzqakyTux6o9OUTWEZF23I2SAfZ/u26nBhZPe8/Reoyr3SvO?=
 =?us-ascii?Q?0Ip9/jKdpX0vLy0EwbGchlppaC+AWkT3VzNDDA6oSufHKgKamzrCkkoKqKH6?=
 =?us-ascii?Q?kjHpHNa/pHnH6rzqV85fHseFsIDLjyU7OekF/HZMftG5v1+Uf09anjQvY7Gb?=
 =?us-ascii?Q?CvNbzHpn4lh/UF/gQmMTlpmwquRM2JLAwAlKPsrmT4N9ztt46/SpmFyJGcjZ?=
 =?us-ascii?Q?CIhE1VpXXPo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9038.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ol8jBQCmpf7Ps+Mr3qyoDQTU07BUAX9VXObqIyqyeOS2IR4vliL0ohEWGBDE?=
 =?us-ascii?Q?o1nCHWTT8WVS8XqVL069m/QiXftPp7JwZugslNPZwXa8fED/Mw48vwYA0hXT?=
 =?us-ascii?Q?nxcMrrb2IrPiJ2XjbJTyUY77h7BTbtAkOIbl47eQWjHr6MWSv0+8fqfdsVij?=
 =?us-ascii?Q?JzF3kQofSrx7NgJYM+FhJbigxjpIif3u1Z76/5AZN+gcEkbDQhDcKun+ex8f?=
 =?us-ascii?Q?EE6c5Co/5HMS+TBJuE+QnVdG7Bnj+o9ZGNwgF/JR5FMCuEjkD3ZcEhhWegpj?=
 =?us-ascii?Q?MaH1kZ1h+H5RAkxTPtRn3mQrWp83UUEHTJj1JjpK8F2KQ7JWryW16rusugLw?=
 =?us-ascii?Q?WE/A6AVCkyU9Yp8qq4/rvlIYlZm2WlurxwGdYdzM0pnQfiw2KtMuI4ElUznT?=
 =?us-ascii?Q?GkVNKjg9UupTXkxaE/ZRzkk6MYIX8GmVVZOso05PXrcx1cOhOLDeHiK+F++k?=
 =?us-ascii?Q?CmY3Z/synnBw2EEGZxEE5TVjiX9sAcBeRB4cF2yqndvzpIuTiXSPpl7GFagp?=
 =?us-ascii?Q?ZRASAv9xjm82YtHfnP/3e1ST4i4QtMgHXARCjoE1A/sGBHRcBX4pPseGJhPa?=
 =?us-ascii?Q?HdqjT1N3hTFiPrnVk6wonJQu+o78iSpb++UTku6PYeRgiMBRXbM73q0rNiUt?=
 =?us-ascii?Q?Zj+/t5XGdbQuk2C6LvmT+nBVvQ6KBPwQv5/y5cl3H2nhDZfwQiKCoUqGJ8t+?=
 =?us-ascii?Q?PD5N3/lxBrgbORNR7WMRNpBazUfvMBvbHMuiVZYgysH8iP/GJIUi95ze/L9X?=
 =?us-ascii?Q?tGu3pU6D+ZJLAKA0kojlhs5nxUjMz/Zl1rb4eSQjETLXyC4z9tlGUpvDRe7e?=
 =?us-ascii?Q?q9zVIHqEbNuNXvChyr6/Ig8TYhG0PMPCA0vX2uhyp/dr7HddLpb8otLa05GF?=
 =?us-ascii?Q?X/Z5dWta4kdOuFsXfTVsvGR1jCOXX18byiWbSQAdmXZwx0fcTQqOgpQF/HBE?=
 =?us-ascii?Q?W1ljfzXnl9oS6Vo9lfX68OFERCUr2d+NJNxhH7iCrXY0giZXHx428/zivEBG?=
 =?us-ascii?Q?5aJr+KPdereNA/dC/wGaekxLzdDWlAGB6qSZ09z/CgKhh0XJXQJzH5uyNLP8?=
 =?us-ascii?Q?aGCho1yi5MWmtpXWpMsmsR3AJIQl7BeGrNMKgFtD+MEClZHOh1y1eEVoJx6E?=
 =?us-ascii?Q?KMtdEnlNK7YDKuVLIQGih6eQNyaXJ27gI/zqKgUg0cO9eSk9rx7DfEcvmhrD?=
 =?us-ascii?Q?eHN9IDmKH0xSbB5fU7rlWTXTCdWEoAmSUAwL7dzDS4YJW4Sd89N4DPwRExmK?=
 =?us-ascii?Q?0jMem2kFeMnb//9HxUo84NWlkY3yd7Fz4PGZk2d8LrRU9dKWH5xwtFWKOBCW?=
 =?us-ascii?Q?Jxa9Fe8jGtu/Rxl3nqxWeyWVxtecrIfUmn3+oMut0jo2DmM+B3C/c2UrxnX0?=
 =?us-ascii?Q?l2fwyiptjsn+HN2lefmoCM3+hBRK2hrBnQV5Oz9huKfcsrFOVxp8M4HJ+sa3?=
 =?us-ascii?Q?Sqlf6ErsICd0zb7tXhruIQpznm5ts6A6/DXrd/lQvYnQlBWVZDm9Mng9XzK9?=
 =?us-ascii?Q?f8cN1hBjgiONT2dQhAUdXZyBjCsc+wTSL/kqN2lb47HDTlRezUgmmY96EoEs?=
 =?us-ascii?Q?ZC4XUQ48XemImRxZjKOJDMqYcWVBK2Daz67OkMO3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33287c7-2212-4f7f-1384-08dddaa76fe3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 20:24:43.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyl3dDz2oMdfIvzU0ngNvNfLvxTgSs9nv62uOj5iFfI1EGHSP0Xr91rRhrmjPxrQ8aJCn2dEJlxVH88Ie9rj5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

On Wed, Aug 13, 2025 at 07:26:49PM +0000, Dragos Tatulea wrote:
> On Wed, Aug 13, 2025 at 01:53:48PM -0500, Chris Arges wrote:
> > On 2025-08-12 16:25:58, Chris Arges wrote:
> > > On 2025-08-12 20:19:30, Dragos Tatulea wrote:
> > > > On Tue, Aug 12, 2025 at 11:55:39AM -0700, Jesse Brandeburg wrote:
> > > > > On 8/12/25 8:44 AM, 'Dragos Tatulea' via kernel-team wrote:
> > > > > 
> > > > > > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > > > > > index 482d284a1553..484216c7454d 100644
> > > > > > --- a/kernel/bpf/devmap.c
> > > > > > +++ b/kernel/bpf/devmap.c
> > > > > > @@ -408,8 +408,10 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> > > > > >          /* If not all frames have been transmitted, it is our
> > > > > >           * responsibility to free them
> > > > > >           */
> > > > > > +       xdp_set_return_frame_no_direct();
> > > > > >          for (i = sent; unlikely(i < to_send); i++)
> > > > > >                  xdp_return_frame_rx_napi(bq->q[i]);
> > > > > > +       xdp_clear_return_frame_no_direct();
> > > > > 
> > > > > Why can't this instead just be xdp_return_frame(bq->q[i]); with no
> > > > > "no_direct" fussing?
> > > > > 
> > > > > Wouldn't this be the safest way for this function to call frame completion?
> > > > > It seems like presuming the calling context is napi is wrong?
> > > > >
> > > > It would be better indeed. Thanks for removing my horse glasses!
> > > > 
> > > > Once Chris verifies that this works for him I can prepare a fix patch.
> > > >
> > > Working on that now, I'm testing a kernel with the following change:
> > > 
> > > ---
> > > 
> > > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > > index 3aa002a47..ef86d9e06 100644
> > > --- a/kernel/bpf/devmap.c
> > > +++ b/kernel/bpf/devmap.c
> > > @@ -409,7 +409,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> > >          * responsibility to free them
> > >          */
> > >         for (i = sent; unlikely(i < to_send); i++)
> > > -               xdp_return_frame_rx_napi(bq->q[i]);
> > > +               xdp_return_frame(bq->q[i]);
> > >  
> > >  out:
> > >         bq->count = 0;
> > 
> > This patch resolves the issue I was seeing and I am no longer able to
> > reproduce the issue. I tested for about 2 hours, when the reproducer usually
> > takes about 1-2 minutes.
> >
> Thanks! Will send a patch tomorrow and also add you in the Tested-by tag.
> 
> As follow up work it would be good to have a way to catch this family of
> issues. Something in the lines of the patch below.
> 
> Thanks,
> Dragos
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index f1373756cd0f..0c498fbd8df6 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -794,6 +794,10 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
>  {
>         lockdep_assert_no_hardirq();
>  
> +#ifdef CONFIG_PAGE_POOL_CACHEDEBUG
> +       WARN(page_pool_napi_local(pool), "Page pool cache access from non-direct napi context");
I meant to negate the condition here.

Thanks,
Dragos

