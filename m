Return-Path: <bpf+bounces-44462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527AB9C32CA
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 15:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99EF8B209A3
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 14:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA7838DF9;
	Sun, 10 Nov 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S8nMxLU1"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30452D2FA;
	Sun, 10 Nov 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731248568; cv=fail; b=bjSgOIymmJNBeaLr8mBYe/lo5KeIMpPVZzvQq9gVdsaRArUXPYfn28Bq7GrSvkr4q+3HgEnkYMeox9HpKbjn8JTzystXrOZ5ypapbqpUiE7J+aJjOD+8EeISdQS26pr+f1N9QU+xzeKYVmCbBmlAbrD8m+v7LbcsZiHPdq3CooU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731248568; c=relaxed/simple;
	bh=4PIigbgKxUmyHdEglSBMRQxdcm6sNg56eDJ4sVc8+/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IG0jDHti74U38dZvX3r/B5LpZ/Q6sQsHqsNeAReWVtV4nZoTn7xYIq6TUw2BnrVKZlat4QFz6sWtx+kBz9iBQ0acX22OlJUIRrg3kpqyAbwjQ/Tomj7vhlzSolpG0SOy8yf4JHmVkdVC73xpH+gZMGCSd+YKCB/IjNTvWH9vifw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S8nMxLU1; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKuZVPByIPdjKClZ3TamxX0b1s1VATf/r3cmIQOwjwt4yjqhp+QBwT/z/TJXGUfdw7TIp6JCtiwIVnLU8ZT5jrmI6ykE+B5lJaMftmcA9L2qIFRT2N+CHf/tf5wsNFmYsVcnBn6CTEEOsJ6XYyuAMCCb2MC8OV2ZKunypsjX6eh//N/hJeXMDAy60gQ12L3uu4/cnwgwerYsGxSUTEVu3GqHi2Yhcw/HwdWMOUKgjlK/mkIzX/L2bD6NTSB26i+bnGk/5kjZ62XfLCvoMMMhXqg0u6FxmKVmuEaInezje0j0P4qL78wnDhOeyUsGeORB6KZFr0Ien6uJCrt2PNVcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3tVSLbo8GXw3bG3Zz14ReOoYx7cJEJbZYZ2eR6V0kc=;
 b=LZ0yL4vZwwTzQVG9SMbF5PA9HbIeRvI/zlMVj2Wn9L+YKnoezWDdrtCsVkt7rRfnXzGEhV8ZnrrPsX7dxoV/YKwZ1eVU19Gjpv3CZjRK5cWzaSam5DNqgDCHtDx5Kpjee/pdFwl8YH95p26qh/MxoOP5RbXVEZQXhfeE0vEXMOx4fvJRnd4LHgCaQ9a7V5tGQBIgn+2BHJcevJQ2SuX3RzEzO4dD/wcqqU97Ean1jEVA38y6ltkkVby61vMGgvIblmiDoaq12K7KHlrQbTuPP9aVilTDBMN4YQL+V0ezxUHuav/SNkDe2mSpWFCgD317srsSlEyBFTgDEUZO+txFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3tVSLbo8GXw3bG3Zz14ReOoYx7cJEJbZYZ2eR6V0kc=;
 b=S8nMxLU1SSIwBPHELQTVgUIWe3SEItHrPok7CJ77gUvYoFoAOMbOU+REWxHC4OdCP3TWklITqjo/Pj2NaiIPLxja2r5wLdcM4A9KIqN4zIidtAHH1akR1QV6QSpPXrLTOAz9AodXGPMHxM1I8VwwIvEt8bW6YpXFicWtcEc58FbHDSTu+Go7lCzZ2q75nJMHRIOAZP60NwK6/wY6gFkx+KKU3TKCK9FBEkpva/nhVslfiuxPVkZl9NOrPgQ7aRNG2v4N4tRHo4rAoS8fsUO9m/SK4evy4qm2ChUY5bpDfX4n6mpwVcXk5X8141c2t5ueZKnLhKF9Bl1TCAlZHrvEpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Sun, 10 Nov
 2024 14:22:43 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8137.027; Sun, 10 Nov 2024
 14:22:43 +0000
Date: Sun, 10 Nov 2024 16:22:34 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] bpf: lwtunnel: Prepare
 bpf_lwt_xmit_reroute() to future .flowi4_tos conversion.
Message-ID: <ZzDBqgSOfPk1LMQ3@shredder>
References: <cover.1731064982.git.gnault@redhat.com>
 <8338a12377c44f698a651d1ce357dd92bdf18120.1731064982.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8338a12377c44f698a651d1ce357dd92bdf18120.1731064982.git.gnault@redhat.com>
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 227e0770-a658-42c8-9e7c-08dd01932452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SH3dI7J69Fnk0iIIYnNJ9hBMng+cxeUuoXIh8M0YohcC49qLHGZJP52l7siN?=
 =?us-ascii?Q?+QOGxpNlRS4PDOltDKfk8R6jjSdSpj2QBmR55gLu4L51lIOIQJnS7h+0+qPK?=
 =?us-ascii?Q?z8bIswRLk3+K9dLbQPfe9oZht35Y+xrAVyJYk7G6auTUYIWRZIfKl7lz1yyG?=
 =?us-ascii?Q?QEuiKI2okcxNKCCleJyMy7xl/U2U2gZKz5zXYxOPwh0PfrsdGBHCkHPZmHr7?=
 =?us-ascii?Q?YmyF2tcVbgbeHjn5KuS2cSP5JNh49c7/fu7ibv2daghmYRNkEFIAD3xJXgpR?=
 =?us-ascii?Q?7Z52mMbBYM5GYq1ZxyNPnuy8MDNolCUNTGtcnV47BkVfMaQAG8mMfj1OIAYC?=
 =?us-ascii?Q?yeyBeXbUKRk9jVzl8E9FpLR05k3MlGSdJqP6HGffcu9a8pemh/2IqjMeGEF+?=
 =?us-ascii?Q?QBJYBTJU3ECxES4HJHT4YuFXoXUJPIEoa0l5211rUvCVoSsoFfnv5OzDF/hI?=
 =?us-ascii?Q?W7H2tl9Nhl4U2ZRBAOPkSU45Y9FnTiGENdTy8UrOxCpTqJDYvJ+YSvX/xwtq?=
 =?us-ascii?Q?8ClZMVq0mF/GXnwSgY6j/YYAIUhLDeK9HIVJ6m6hNUmY3H6WpXGTXNXTdYaG?=
 =?us-ascii?Q?uJ9D5bnSZYulT9p0cQ7j4cE70k4gxlE39zISEAKIMeMCGXGxXz4KwPPtsVGZ?=
 =?us-ascii?Q?Pep3eFl75Ls36fAbwV4MMU3SFRmmTrm+1uuuT5AXSVEwgswEmL00SqviRRWS?=
 =?us-ascii?Q?kNbivey31Y+Lssc/nTBDIzupbhKZl/UdRWQs0rpV0STBafsIJ1jclTciBwun?=
 =?us-ascii?Q?3+qfQlywq1DDSvaifwUWi65wwth7GcD4Ga2dy5IQVFJmD6End7PEUgpzggg+?=
 =?us-ascii?Q?p4GaLc5DATMHTCHIyiGbalX0xe7IE2cLgcn1gmeXiakfEhQd0PvI2UhUmrE7?=
 =?us-ascii?Q?gKmrh8Cx80TK3z/NfrN5IzufavCRoXtqNuiD8n9AbPk4pyj3hY7Y+1u4+0cu?=
 =?us-ascii?Q?VbZMz5IAEHNnZEFYnd/dbuXtjI1x2swC0WcfgZYDhSxdw7jBOfir/xu1qNfR?=
 =?us-ascii?Q?5u5NBQd1w6ZZC6zPrCma5K3l/3avG6Ra7dFv3whGYjbIsCm511eDUSoXFfnZ?=
 =?us-ascii?Q?NpE2V+38AwplIqwIsrP1Zfvuf1MoYj8JsjQ1gdv2T+sqH6yV/Vd4/EmP46Eq?=
 =?us-ascii?Q?AsHMwYg6KINBqGxHZ+kFaLwqsfADxCKOjsKcKtpercRRcIbUr8SwnYdS5mnv?=
 =?us-ascii?Q?wbnJwH1xOcSxtQWOO0VBTTx525NIQQTxjiw/qUxZTqMWeKVIOfvsaESkyqhO?=
 =?us-ascii?Q?xVzL/14uUVbBXsgNR6yjA5zW91Y+b34t6p/WlwhHgSUqhZPztzblJOZySlN4?=
 =?us-ascii?Q?0VUlaicQSJZ9G/UWxJqj/024?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x9YeDhd8Moph064I/oQwBkw/R/t3Jtrj8uJtBdcPAYgbnxq6rbJ0/EH1krCn?=
 =?us-ascii?Q?D2IM7uwjENyQ6xq8yXgQzJX6dldfDiye42Pn0uwxuViEcmxdo51sB+LGLaVT?=
 =?us-ascii?Q?OBSsOlDB9D4VQq7Wphy1cnbcZZGqt1j2XGjwNuSDDgoQepkFjVvUzyconIHA?=
 =?us-ascii?Q?nVB6e0+bL31U7msGWSXoAbjRBuzu7HH96ncf2uj8K912N1nU98P9/HBDCdDJ?=
 =?us-ascii?Q?8sSQoXtxEVdUNGTMpWmsPPY16Sc8m9oyPPAOoO0IXy+PklvInKSPBEM2z9tp?=
 =?us-ascii?Q?m828LPykRcFzoa4QjF+2YiOosEB75v1vAPf15DCCqM9hz5D3Rd2TCvIrI6Ai?=
 =?us-ascii?Q?NDWdtUTDwjB2zsH/PVBE5iSmn02X8UAiWdarrluZOH+abUCxkYMV7Lb+5fd2?=
 =?us-ascii?Q?+1aN/QzQ7jiHhzmnRFVIQ66hvP4Nkj2Rin7H54UGWRP2D6fg6zfhrTShLzc4?=
 =?us-ascii?Q?bJh+jcttCeSfLgS1kcOHbsAs0LcX+iwfn2yz6s1AzIYVyOky0D/MiyH0Nsfs?=
 =?us-ascii?Q?JuZCYTW+TM/aJWmsEmF2icgqroXtKyAofSsUybE6Wu1cAxtodD5bGoDM3BuP?=
 =?us-ascii?Q?JhhVoau5nMV5UfKaNaw13BlMIZAr54XmcURFW87poe7sfD8DcRvxSCRkU8wL?=
 =?us-ascii?Q?YXscPN6Xc/JthIAI8hdv22w3T0QOXMsJIpOx4FJVEl48F5HRJQxr+4Bkk1qG?=
 =?us-ascii?Q?lTGRwAlIBLdf1pUCAr91ZNcqpmGFyu9wL4Nb0odTzexaQVAgVJP5JIHonabx?=
 =?us-ascii?Q?Be7eGbKJfbEiJhKlvwudJ1u8pjC7RUesaFXPnIQUj3MYlnHtGIDpAdxoHzCN?=
 =?us-ascii?Q?YHNZX1+9GlRez6dLPcMnXeT5rFQAkmIJb65+CN8cecPmrZ0wT2OwBFFALtlE?=
 =?us-ascii?Q?0kgoQYVa2vSRAUYpt836P9mBx+jQqU/urkotw/T7aPV8RFyESwgH1Tqjq1+X?=
 =?us-ascii?Q?v/5pIrlrlx8HgmCyapuTZ2DuDwx8MBU4PW9GlqwzVC8xh1ZT+PJ9P/r9eGN9?=
 =?us-ascii?Q?dmTO9V+RtAjIq5sO/loadvfuZ2qJa7jY1C6rf27CsuWdQGuXCuYxyZsfdS//?=
 =?us-ascii?Q?wqzGkmJVb7boZruDUIGDXl70u6nxQ314+5VIKx6HRhaH44RvtNLk17oANm1p?=
 =?us-ascii?Q?db4vSwhrVCuDkQFuVMWs9UP9xWgmczDJpyyHRWHj30I9+QoqE5BegaDmvLzg?=
 =?us-ascii?Q?p8OSQev6DqegI+KVovTy2gLPsYs6rpOtC40O8vJrtXr+y7tDQ109RiUQlbNd?=
 =?us-ascii?Q?9DGxKtUWvmVD01nSXs0PmrYNg0MN3zLRZycST76XCUEMPRV9YFCYCVSR9Yv+?=
 =?us-ascii?Q?KVkgscMtg/WRrNOXQgqv0qezipzD25LPLZ6Hq/agkvI6sWUQvpu34ROp4z/a?=
 =?us-ascii?Q?A47LxuWuNlFbLnuni2gqGvhxA7JO5Gfj7Qs5M/b3eK/syhAMeialtDyQMFhV?=
 =?us-ascii?Q?AaFKF4r5ykr+g13cEeB6Q8bY4PUwh+qRpouEFovPwPMs24p2JA6zmGD5NaQ7?=
 =?us-ascii?Q?0EGN9AqYIDpNMRa7Bquyl6sT39n9ZqR6QaAQRzIALGVdZBqwAjUBozJuvkEr?=
 =?us-ascii?Q?x+aQzkZ4Tzhfd3PHyrRtKkshO1JraZaYb41r+q7O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227e0770-a658-42c8-9e7c-08dd01932452
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 14:22:43.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDqUeMPfrYcxRGOKL4adCJGyjZdQGujKaY4RFD1fYG2nf+jqQ/xxBwG4BP69XiKnCXb73rWgNIqAkWyHoNMM0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

On Fri, Nov 08, 2024 at 05:47:15PM +0100, Guillaume Nault wrote:
> Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
> dscp_t value to __u8 with inet_dscp_to_dsfield().
> 
> Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
> the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

