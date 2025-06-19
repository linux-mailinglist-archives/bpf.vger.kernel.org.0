Return-Path: <bpf+bounces-61098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1073AE0B18
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 18:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB455A4EC3
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3241428BA8D;
	Thu, 19 Jun 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F6/kxMgl"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DDD21CC6C;
	Thu, 19 Jun 2025 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750349264; cv=fail; b=M8RxpLXZAIW0vKJ0zKHvh97OBs8jDbyHImQZGkyiKaAFNY48WQEafbFti6wISPC8M0iIj2/m6RD0aZUjivFQ8YoZJeCQ9wOGxFseiChnATt3tYtKaXPcoVwWneJuluc/YJ3UdUkoDxNNUCeqxnCwIJYnVyWYiJthfLDsOrXx/l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750349264; c=relaxed/simple;
	bh=dv72YE/ZAsuzCPa3DTu6pMMvrCrSViUIrYV4Y/tkgfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tHXzEk75E2nePx+X2bpqKPxsCW9Ok6fDxVDI8nYrO4DDXgeodjMpBISEkRYQ2dLQM3zxNr7DOg5iWhUzCeVYkdA+dS16xMJVKR5w9go7prFE/7g33ggI5fj9ZnDNc4lpkJYlNhOnf6D7O4B/4QczdEHOfmXILY1ZehWONiFtBRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F6/kxMgl; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wC7/6HQZil4JvJZb3jS/Wd05QgS5U/ve9vmMk/g89jiXN80OIW3VGvvyrixWj91Mw5x2pqcKgh/OR0x400n4KZ2QVSz00pTKNUstMd7VFY9i2TVWad90jDu3WYHy3HsepQim6c0Q5oaVt8BVauUkLJsMKVZDfEr4PpcJ8Ymwxk+a+k9+P4Ue/1wwaCMXaxa+72UaegPNe8dQii1FdzrFVB+UlwZwgEO/5r/iWCWyiXDTDRhzg713DYxgTIv1C7r+4aZ/MOdID+tdN4rP8qUAu/Jvg0s89kEQCi/fNyzphlLpvG8fsBIB+OohToaOvKANQ5t+8ibUsuWnw9c9er5Quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCtzGvBVhaHdyjyoGQDVpIPLlv0i4Q49Dkf5iCBP0sA=;
 b=tzgJc/Har0RH5MaRie2nhnyXHPWPo7ZF84SkXWQerEEwj1/EoTk9Rrp7qjhxxITdwJU1pCgUI1R4PWdowJM+v8e3CmPKEHhEygSr3VkMSKbPPEqOPAZHL9Zm9EUCsIhS8sBmPI2lcDlXoDee8CIzzwCAk4cAcqi4TuK9x4PjuXbnlaqV93g6GcPRi2yVKSeaA5llej8zBcBGB5Z/rv3Jkp+p8t2wjEMtZlxEtjMCzS341Szz18FB1uCsTo3+0EOXb2iQk5Fi7ztZjJ6N+vRnKKxbHGX4Zh5rZLc8mVv02fWcWK0nao0CQ26I94kO6cHpFQZSUU3oZOKvT36kFnvRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCtzGvBVhaHdyjyoGQDVpIPLlv0i4Q49Dkf5iCBP0sA=;
 b=F6/kxMgliDX4LJgNz+5Kv7ZAMva0jxJ0ZBlUS3gsELIite5WmeObJHlaKczmhhxEIyab9g4jYLWKq95dKjT7uHIbCjFl+tQm1RSUQVxO0tce2qRCkiDDdfZ864hS+ti03wk+O7I5w+hFtaS+DOa5M2L9+B7ogWTgp0LbUFhKNxF6uzUxfs46kfLDfwyHH2Dkk0cDbq19xFzFxkvWnHssh69LlBPyGk+Z6yL3qfDYBMLNe2rhWlbCdRsSa3LCA7X/1up8D/bZcHT4KnC/YHLzNMst2WRJeMd21q3WDgFcvk69CGiI7au+6VUawR2bLtiUPhQ/Fgp/QgfLmxaEsRyCMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 16:07:39 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 16:07:39 +0000
Date: Thu, 19 Jun 2025 16:07:32 +0000
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
Message-ID: <xguqgmau25gnejtfrgx3szhneacyg2cjj6vlsi5g7fouyn2s43@nemy5ewelqrh>
References: <20250616141441.1243044-1-mbloch@nvidia.com>
 <20250616141441.1243044-13-mbloch@nvidia.com>
 <aFM6r9kFHeTdj-25@mini-arch>
 <q7ed7rgg4uakhcc3wjxz3y6qzrvc3mhrdcpljlwfsa2a7u3sgn@6f2ronq35nee>
 <CAHS8izM-9vystQMRZrcCmjnT6N6KyqTU0QkFMJGU7GGLKKq87g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM-9vystQMRZrcCmjnT6N6KyqTU0QkFMJGU7GGLKKq87g@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 8746f621-3c99-423a-a03c-08ddaf4b6a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFd4N1NSeG45Nm1wZUc2U0R0OTh1S1UxanVpVkZVTkZ2Nk9aOEVpbGNRRzZO?=
 =?utf-8?B?amVqZDNuRVR2cDNmZEEzTzBBQnl6alp2cDlYbTNpSFZENTFiQ2cxdG41RkFW?=
 =?utf-8?B?VzRtSmkxZ2NJN1pHdkVjZEdIVC9CVmxveS9VV2E5ZEZybk9HQTdTeHMvVlVq?=
 =?utf-8?B?T0xSdDRZR3RWOGV1V2ZNWGNRL3N4RTRuUlJWaEFyNC9CeVdSNVRqaW1KWmdn?=
 =?utf-8?B?Qjh0ZGxDT2NBNEhlOHQ3YS9ld1FkaHBsSkhNaHJxOVRmN3g5VW5mc09RNXdS?=
 =?utf-8?B?bDhDMkI5c1BHOURoODlNOXdWN2taTHowSlFINVdLa0tWYzlyajNIUVNIOE1t?=
 =?utf-8?B?a3JPVUd5SjNTZENRcFhWcWRnWEw0UWtob0psYi9DamtlZ055ZDlwNFozMkVY?=
 =?utf-8?B?YjNQSWtJUHF5NVppdldCeGNMU1ZtZHR6cEZBVmhoY3VSZytVTTBLcFJab2ZF?=
 =?utf-8?B?a2RwYzNsOFVjZHAxaFVrU0JNaGtUbnEvUkY4YTIwSVY5UlRKU2IzTzJabmFL?=
 =?utf-8?B?VmRqWlJUc0JBRm05QjcrUjNOa1pPb3hJTUs1dzVvOW5sQno5VEh0Z0NucHFy?=
 =?utf-8?B?ZHNwVDlYSmd1eTNic2tkV0lPRnFoV0ZsNEZhMUVXd2wrK2lrazZUd1hXMkJ2?=
 =?utf-8?B?NE93ei9ZeDB6bnB1SkJ6bGNzb0VhUFBON0NQWWJHNTBuQjdNZ1hmOUorR1l2?=
 =?utf-8?B?NUM4aUNnWGlPK2VFRGNyWHNmVlE3N2dhclFOMjcyOWhjSDlvOU9YTXNrMnZx?=
 =?utf-8?B?c0t1dFNKNFpoN1NiNEFYVUd4b09QZlE3QmdYSnJMeTg5NmlXemd1SlNJM1Iz?=
 =?utf-8?B?eVhZeVcvNVJlZEpuR0VZeUxsRXBNWWtNUThyTFZuZ21hUytseDhuZittNWo3?=
 =?utf-8?B?c2JhQThKVkF2ZlZBazAvbWFudEFINXVzQndIU3F0TThDdzVUV0czekQ4WWRN?=
 =?utf-8?B?L1RzOExpcE5uZjVGZzVnTlNubmpXTEJaMGNhWUp1MUNzTDIycFRaakcrOFBB?=
 =?utf-8?B?T1hwN0Q1RFlycWEzNkdJYUZuYnBCMmFlUnduQTVUWW4xOXNtTnQ4U0pBd3p3?=
 =?utf-8?B?QnVrUUwrb2M1bXpMK1BHdzhQZUtmcEZQK3JIQzZmU3V2ZDdqTGs0clV0RjJq?=
 =?utf-8?B?RmtBUis3YzNIaXRWd3ZHYlA4cDJKTFdrdHZpbERYS2ZieVZjT2NERmVEOFMw?=
 =?utf-8?B?Y2RQOGk0OVJxWG40enY1T29TQjR3RTJNdkNsWThvd3U4d1NUbUgzb3ZhU2h3?=
 =?utf-8?B?UWlHSi9TY3VxOGFKMGgxVGY1T1Vjb2NpSEZyZkxCU0ltK01nSVF6d2tSeDRS?=
 =?utf-8?B?cGZHYzkwdUEwdXM4dXUrMUJBdFRWODhvbjRmSXRlQ25hTkI0Z2ROZ2lmc2l5?=
 =?utf-8?B?dDZLTmphRzBUc05FUXUyWG5QUllrQktCb1U3UGEzZE44MDZ5TnNKZHJMOEYx?=
 =?utf-8?B?cnRyVnpNdmd0eTdHbHMzdFRsR0VpaUMwK0NVaEJ4cDYyTUxUUEh1SUtlK3JO?=
 =?utf-8?B?a21Qa1ROZmh3UEZReUUzK1BYSnJYODNPZmJXVzRGSDJFRjNXcVdiWTBFaE1a?=
 =?utf-8?B?enJvbkVnclk0YXU4a1ZFeHNDWGxYSklreHZ2VmtxeUZCRXRaTWpZRTN0RWY4?=
 =?utf-8?B?R0ROeWhqWEVoajJSTmVlcy9pdGhUOTdoQUZtUnZDaDlqSTEydE1qVXF0cjdQ?=
 =?utf-8?B?cm9PWTdGVkdJbG11U3ZqUHJaa200Q2VsaWY4TnA3K1VmdSthK1Nsa3FRNTg3?=
 =?utf-8?B?OFp2WkoybGVRcHMrWmJ1NW5rMWdvL2k0VDRlc3dvaGkyeUNRZThtci9KRmlL?=
 =?utf-8?B?NlFVY01Nb0Q5SmI2aEVCdHUxTmpScEkvWGpUSHB0YnhVUGIzTmJEbDQybGFG?=
 =?utf-8?B?VS9aS0FOMlVWTHUyWitVTHV3S0Y2TDZuN01yZmdtclJQTENnM0EyWVgwNzJa?=
 =?utf-8?Q?Qk4EJM2qMmU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE5DajUra1lLR0xUaE4ra2NReXNpLzNPRnZnT0ZzUVRUVG52SXU0S2pkMDRP?=
 =?utf-8?B?ZVFCTEtjTHZzMkltSnloYm4waGRQU3BjYm5LazYyMHlxb0FldVl3VEhSWXlM?=
 =?utf-8?B?VTl0c0Erc0xMaGZXOTdOWHIybXZiNkdDd1laWjBEeFcvYlNvdG5JbzdMbExo?=
 =?utf-8?B?M0lxMWxrS2gyNlBacis0c1A0ZkwzazNuMlY1R1ZQTEFuUjBTMnFjUks5bVJz?=
 =?utf-8?B?RTBtTVg4TWJDTDJaSngyT0orMEgrMHBzUThZaWVweVFDMU9TdTY3WExCajh2?=
 =?utf-8?B?b2szRlE2aEhjQUZCMS9nUlJhREVvYlU2UkZGOE16cmNrR3VORWJPNExua1VS?=
 =?utf-8?B?ZHZJdW1WS3ZMNVhUYk80S0ZEaWNCM2VZck50enF1cG5MWXdFSDNGNGdzOTJ5?=
 =?utf-8?B?SG10dm1PNkZldkNTZ3dhRklHRHFJL1V1NkpGRjNlM1pQa09WWWROQWJIZFF1?=
 =?utf-8?B?QUJhWFFWR2JyaXp4djNsZVUrVTJ2Z3RkcU8ybDBJQldRWFBGelZUdUE3YU0x?=
 =?utf-8?B?aERPL1djUFc4Q1kyOC8wM2xpbldiUXRTSHhiR08vaXZ3YU1FM1pkcXFCOVBq?=
 =?utf-8?B?WnVIZFRSdlNCZnhSTThnS2phY01tanhiSjJOQURhSTQvOURzRVd4bWd4TDJK?=
 =?utf-8?B?ZWhhNTBZNWw2dC9yck1qV3diVnY4K0pXbFhkNGxRaTVPS0xrWHpOQytMdlc0?=
 =?utf-8?B?ZEt3RVpCUXJ2NVNKOVU2RjNyRG5ybUtKNElLaWY2R2haZ3podXo5ODh3dWM1?=
 =?utf-8?B?dXVlZXBEeUYvNU1sNWhybCtyOXBrQ2VkNjlNU2lXNDFnTEluVjhRQlpGRUNr?=
 =?utf-8?B?RCtLNnF2Z2oyUk5YczNXYnQzNlBzOGpYaDUxYmR4L2hVb1p5d0pRTXl2MWhx?=
 =?utf-8?B?SnNzTFFtdWFrVmM5T3hZUGtuUjBWOGlnYU1nbDRZUFRRell5dWRLVXRDMzI3?=
 =?utf-8?B?RjlDTy9jeTJjcmYyck1Tb0tGSDFaaGEvczhONzBYbHFwOUxObkdNQ0V3SC94?=
 =?utf-8?B?RDB5UFRqazBMTXF5Zm1yaUNGSXpVV3JPajRCRkxVVUEzT1E1ZHk5bTROTXp3?=
 =?utf-8?B?ZHFVZmxRWEFOZEtVNCtYQ0dZc3pMOTVBMzBYWEpTVVl1Y2lnckRvNk0yY3lu?=
 =?utf-8?B?YVUzcmNDdmFuMDAwdWdFYWQrVDc2RXdVczZGRStlQ1FlNmo1ME16WGdwRFFj?=
 =?utf-8?B?aUtIcTdmZnFGay9GMkExRkV2Qi9MamxmRkNHS2luSUhQK1hUNU0zRDVleG8y?=
 =?utf-8?B?ZUdGVDFvOHRrYVhBd1BqalZkRFk1V1hIMzNBWjRVN1RzajFjUUJDT056SXc0?=
 =?utf-8?B?dGk3T0w2TUFPSUU2NnlDVm55RWFjbFdEMWFrS2NOeGdJNGU1MUU0cmZRVDFT?=
 =?utf-8?B?Yjd1VkdKZ1REcnB5VVpWTHdyNlJjbkMwYnRSbEl4MnlvV3dlbGFIUFdPbUFJ?=
 =?utf-8?B?QjhkOWcyVm5RbGZXTFNLUUlwRGFxUU92ODhlaWRmQWw5MTNSNkRXdFRmVndJ?=
 =?utf-8?B?U1NJWW9NcFJ6TTNyYlZvcVNsYXFXRDdJVjN5djhmMDZ3bnIzbG8xQjZ5bCtT?=
 =?utf-8?B?Wkh2VkVaQjB3aFNQWWUxYTJwdmJIZmJzbHRTU1EwRkJzZVhxdnc1TDF5WGNY?=
 =?utf-8?B?QTk0dDlLZVFtMGNhcEhwRCtjRzFmcDBFWmQ1OFlQbkNnSHh2T2xMa1ZWTmRy?=
 =?utf-8?B?WDRvRTlYaDVpSEdVT1JQbVZGeXRBV2owVkdtOEg2VUEveWMyUzJSeGlLdHNF?=
 =?utf-8?B?YlZ5OG9obW52eU5La2pvaWhESW96YkszeXg2bDdWcjdCMVBXL0FTMlcwSDd4?=
 =?utf-8?B?dHExUGVYU2hUYk9HbFFZVUxVNU10VTFIdUNrUWt5N0VCNUVnUVZGOU50SHBr?=
 =?utf-8?B?aWx6QmxHVnBqTk82MHRWbjlBWE9ZV2RpMjNtd2FFWDZOdmJoaDBmZS9MZy9n?=
 =?utf-8?B?SDY2ODRUcjh4NHJLTUE4UzJxUjJzVVE5cTZUcnhIcmYxQVg4c1lJZXNRY0R3?=
 =?utf-8?B?dUFRdHI0c2FPbFVpWCtuZTJLTXBpZXkybEUxSDMvZVZZd2ZscXBtN3BQUUR5?=
 =?utf-8?B?ZDBEalQ1MDhuNFNDeUVqRUxvVklUKzF0MFd4MXdydWFHOUFsbWl0NFJ5VER2?=
 =?utf-8?Q?lpKvDseGfwafF0ys1iLEA3CJ2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8746f621-3c99-423a-a03c-08ddaf4b6a0f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 16:07:39.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESmHuYOrJgT2f5I99G6Vqv2OsP1gtXImVEZCwic2oSQg5uf/CuA98oFvfjRB2H1IlFzcAf+lbDk6gAgrWD3yYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287

On Thu, Jun 19, 2025 at 08:32:48AM -0700, Mina Almasry wrote:
> On Thu, Jun 19, 2025 at 12:20 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > On Wed, Jun 18, 2025 at 03:16:15PM -0700, Stanislav Fomichev wrote:
> > > On 06/16, Mark Bloch wrote:
> > > > From: Dragos Tatulea <dtatulea@nvidia.com>
> > > >
> > > > Declare netmem TX support in netdev.
> > > >
> > > > As required, use the netmem aware dma unmapping APIs
> > > > for unmapping netmems in tx completion path.
> > > >
> > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> > > > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > > > Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> > > > ---
> > > >  drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 3 ++-
> > > >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
> > > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > > index e837c21d3d21..6501252359b0 100644
> > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > > @@ -362,7 +362,8 @@ mlx5e_tx_dma_unmap(struct device *pdev, struct mlx5e_sq_dma *dma)
> > > >             dma_unmap_single(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
> > > >             break;
> > > >     case MLX5E_DMA_MAP_PAGE:
> > > > -           dma_unmap_page(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
> > > > +           netmem_dma_unmap_page_attrs(pdev, dma->addr, dma->size,
> > > > +                                       DMA_TO_DEVICE, 0);
> > >
> > > For this to work, the dma->addr needs to be 0, so the callers of the
> > > dma_map() need to be adjusted as well, or am I missing something?
> > > There is netmem_dma_unmap_addr_set to handle that, but I don't see
> > > anybody calling it. Do we need to add the following (untested)?
> > >
> > Hmmmm... yes. I figured that skb_frag_dma_map() would do the work
> > but I was wrong, it is not enough.
> >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > > index 55a8629f0792..fb6465210aed 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > > @@ -210,7 +210,9 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
> > >               if (unlikely(dma_mapping_error(sq->pdev, dma_addr)))
> > >                       goto dma_unmap_wqe_err;
> > >
> > > -             dseg->addr       = cpu_to_be64(dma_addr);
> > > +             dseg->addr = 0;
> > > +             if (!netmem_is_net_iov(skb_frag_netmem(frag)))
> > > +                     dseg->addr = cpu_to_be64(dma_addr);
> > AFAIU we still want to pass the computed dma_address to the data segment
> > to the HW. We only need to make sure in mlx5e_dma_push() to set dma_addr
> > to 0,
> 
> yes
> 
> > to avoid calling netmem_dma_unmap_page_attrs() with dma->addr 0.
> > Like in the snippet below. Do you agree?
> >
> 
> the opposite. You want netmem_dma_unmap_page_attrs() to be called with
> dma->addr == 0, so that is will skip the dma unmapping.
>
Yes sorry, that's what I meant to say.

> > We will send a fix patch once the above question is answered. Also, is
> > there a way to test this with more confidence? The ncdevmem tx test
> > passed just fine.
> >
> 
> You have to test ncdevmem tx on a platform with iommu enabled. Only in
> this case the netmem_dma_unmap_page_attrs() may cause a problem, and
> even then it's not a sure thing. It depends on the type of iommu and
> type of dmabuf i think.
> 
Is it worth adding a WARN_ON_ONCE(netmem_is_net_iov())
in netmem_dma_unmap_page_attrs() after addr check to catch these kinds
of misuse?

> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > index 55a8629f0792..ecee2e4f678b 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > @@ -214,6 +214,9 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
> >                 dseg->lkey       = sq->mkey_be;
> >                 dseg->byte_count = cpu_to_be32(fsz);
> >
> > +               if (!netmem_is_net_iov(skb_frag_netmem(frag)))
> > +                       dma_addr = 0;
> > +
> >                 mlx5e_dma_push(sq, dma_addr, fsz, MLX5E_DMA_MAP_PAGE);
> >                 num_dma++;
> 
> If you can find a way to do this via netmem_dma_unmap_addr_set, I
> think that would be better, so you're not relying on a manual
> netmem_is_net_iov check.
> 
> The way you'd do that is you'd pass skb_frag_netmem(frag) to
> mlx5e_dma_push, and then replace the `dma->addr = addr` with
> netmem_dma_unmap_addr_set. But up to you.
>
Thanks for the suggestion. This would require some additional
refactoring. I need to play with this to see if it requires a
lot of rewiring or not.

> If you decide to do a net_iov check and dma_addr = 0, add a comment please.
> 
Ack.

Thanks,
Dragos

