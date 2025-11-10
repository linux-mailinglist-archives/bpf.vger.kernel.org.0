Return-Path: <bpf+bounces-74095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB5EC48DF7
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 20:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 338D64F3470
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABDC3321D4;
	Mon, 10 Nov 2025 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVUjxjeK"
X-Original-To: bpf@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E1E29C321;
	Mon, 10 Nov 2025 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800716; cv=fail; b=Uhb3lMkPziV0AgGF/Qusj5bZjXq5SJAhbwUN1mq6wVOUQFASBSv+oEUgpuS/s/OwuWttLctAoZ8ge9Z54P6GHbGrfYiYrJ1yLE2IWrR1qusNkysdm77itYWSN/UdoJ795SovPogx4pfIFqUuDePYyZ+5Oyc+pq5/III/ItOA+zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800716; c=relaxed/simple;
	bh=66v2g31PK+GVDHlgREbZng+ycklLpsmWVG6rk4+giNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XRe2wpJtVkxcegIh71P5u6+s3gvH7MvvK+FzttnhAaT66+fTAHnQSwYNSSD+EeC6ka5z1tc1yi3pMOsYkmqM76VyORjNFBjshT4hlv0L6gxRiD00pCZA7JJ5UBSsrI4231CH1K5lsrD8cjsFHiFGPqwBP4lWjTJLj9/RELkZHUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PVUjxjeK; arc=fail smtp.client-ip=40.93.198.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZVuGduBIkMDM3EHar1BPbKbtMxxYz5V1HV4d8Yh3m965qaqjGyXDL8n7b7dghRAiNySsr8ajaTCRBU80/p7NWgxVEBW+Hh8A27B2skWxWPgQ8lnjhOVHWW48hiarkfXL4gh+6B4x4mSDf0RvPb8d/JVYk6PXXN5ST7Bgy+ETFJLfx0nSKXmadHBMMmg5qId9YogV+ls8XJ0l0hErHs3GHjBjwZ0Flck12J3ZaLfjkWud+xO2JUpLCRmYDt1BQ99Z6J0SUcUGgNXOdFAwEGs5Atu/+lJDCoZhy3fqSVvzZ5/R08aPgSYUz6jYKRjYbliXkU0LmE+XWbpvIZvBWuWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4AJ8Zb/1iX1HCn+87RCaQ4GCnLIcU89nbx9RnvyUms=;
 b=cJaGGdA7lzzkrjDNkO2ge4e42cIxUyTkrAdIfRI8yA5/m4MQ5kRQeV0TPurvmkmt9HXKUydrLEcuGKvpVn5vOnV7T5wyP+CjQ52Ewqhjtv/bthSM1AsErJBR/XY5ppe69SEmBhqjF5d8hT4WZd93iFS9f+oTSXVseDUeeBCkQBCG5D2YE0xYDnVaJpL64hdMlrHlFdlVS2sdVGsF3IDRLp3WmrdCAUkZGfz3R6NDncuMgj4856RDsnXTTAFoCZpGaT0ConNEpmrvZZvR1TtYbCNXT1arvPM1mx9Vsp2tu+Zalsd8/UmSfc2rHsWut4RCWQhMo04LffFPIoXTQq78Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4AJ8Zb/1iX1HCn+87RCaQ4GCnLIcU89nbx9RnvyUms=;
 b=PVUjxjeKIT6XIrqwA1KZUFwh0ctF9msr8dJbxiY0naDjI5f+r3N6sHckhMjbicPQxqg3ZunyK/xfnwFVaBGF5JaENlQ7vF5ftMAvhTuaFqyLzZYMDFRFeaoriZHGdWX49EBXNjckjw9mXcBL/7i16RpnbOTSb+Pyn76IYdEjRKkCO95d5FRmZRcxQnR7+oDPwrQGPTsMTVOdlXrsWiS1O0JXUerl3FpFEr7F4NB9jaRrlmd7eSbj4l9mcPCYe3wKZSW5JJMOYVn3lEqiUO9xdNHY21A2n7OfWkj5V/FYBXqh/ZUs5ckJUbXSfRsLiKJmRsNNG92IAT1Ri9uzj0SRuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 18:51:51 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 18:51:51 +0000
Date: Mon, 10 Nov 2025 18:51:40 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Simon Horman <horms@kernel.org>, Toshiaki Makita <toshiaki.makita1@gmail.com>, 
	David Ahern <dsahern@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	KP Singh <kpsingh@kernel.org>
Subject: Re: [RFC 2/2] xdp: Delegate fast path return decision to page_pool
Message-ID: <4eusyirzvomxwkzib5tqfyrcgjcxoplrsf7jctytvyvrfvi5fr@f3lvd5h2kb2p>
References: <20251107102853.1082118-2-dtatulea@nvidia.com>
 <20251107102853.1082118-5-dtatulea@nvidia.com>
 <d0fc4c6a-c4d7-4d62-9e6f-6c05c96a51de@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0fc4c6a-c4d7-4d62-9e6f-6c05c96a51de@kernel.org>
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
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 47be57c3-ba4d-498a-2102-08de208a3580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TFwnIyRdcgS+N7F1wlvtefAXl1ftFyrFL66FDUIM/OMYs830a741CUPfmcD+?=
 =?us-ascii?Q?ZdQf/ww/ozTBKp+UIQrecVdoan8XArKlHPkrmsusKDZ2x1UhBGBkO+uex/pE?=
 =?us-ascii?Q?WOMIsUhwUiNYzmHiWubbfC8TASav0jmiNGxZAqNpobKNzs0KGEVCO3ddTE/b?=
 =?us-ascii?Q?pJMVHY9Fd3LWK8twLvMZpK8FZleXG627eEaXFVUVZARgoh1fKtT+uXewMoMY?=
 =?us-ascii?Q?GR/1IvGvJhTkEggHJVWVJO4OCZxddiKVykEVTFFApdb8lY2Cf+m+Hr9zK0ro?=
 =?us-ascii?Q?QrdVCSOSzLNKucKDDyH2qa72ac58MFhYK0ohrKWjXdGJOcRnKdVnEeffZbrX?=
 =?us-ascii?Q?Wz25r/ROt04hbH9xpvxww0ZIzjpsvHIjXftC1eZAewqHU1jWFdYDa4aiqK1j?=
 =?us-ascii?Q?CplMKWAc/C1T55jKFG2tAupJ0U5z+FBwz4JHCz9S1X29nx5bMWTypeOpfjE0?=
 =?us-ascii?Q?i63/8aoZEBJcPmHuoT4BR6VegDk42IY1CVVmIxC5pFNaYvq0oL7P1KMZ2J9q?=
 =?us-ascii?Q?j0P7xlz3mjhH3omgEVgZH0hbnXi3zBGrmUG5HnTsaHtYgJAz8l86k3Hj6jir?=
 =?us-ascii?Q?rT/oXN4aH9rfKeeHTk2OcJA8KOCUqZwJoNUeLINbWrfYOVsBrVi9w7+r98rS?=
 =?us-ascii?Q?Zupo7xw6wCzImnr7wYyGYjLCP3whGFidKuQk3aYzmZ6qgyXjjJbOIaoM4rGl?=
 =?us-ascii?Q?8Q51TXN0d4l9kLYS9ur3MqFjwhO/WFWuPt7+qt14w6mSsiS8UJ8T8e9uTJ3e?=
 =?us-ascii?Q?bH8ToPtP1PmcoacZ4D+PDr79wfTQpehyKZ4McQt6Flrc1lwlGx1/QNIBe5IU?=
 =?us-ascii?Q?S0dqusgrQBjosGm9lZ/YlQSZtCh77z7UbkaepWaCY1SdjjunKTgTjz9xJt4O?=
 =?us-ascii?Q?rgI/3skTGtwyOQffDKdlnsVZ+WpLXWrb5Z6DB1XZmr4yrnDnA2Z7E/phvfS8?=
 =?us-ascii?Q?QQAxicTMRthOjmCkutgSU0BWehy77Z6MyZqgTCGjP3fdssErMFid0huPtHEm?=
 =?us-ascii?Q?osnSAevhVtY5ErF/t7Xk3t+dGbRCqOWGhZRofJRizGG1ce2Orr8mxEZjOsXr?=
 =?us-ascii?Q?/7ljoZCBttz5SIC70vNUGs3UJRxxFhL84uxb+e958uKqZUTzrYSKALX4LJrt?=
 =?us-ascii?Q?bTJ7410jWnCPcnO/mmdndKQexRe9QK40+RlGONA2C+/OBXWXOhHZMQJ7f5Cx?=
 =?us-ascii?Q?I6IK4R95RBvSACz8tcK/CJFz/Fyy03qm/UePgnEts+Unn1PJf1W8mSKuFcUR?=
 =?us-ascii?Q?G8qKpkaHYDDDfGrnePiOOuTycmPEcX/dwqeTFYnPJMt+Dgl3dY+tJ8HQ0abw?=
 =?us-ascii?Q?bdKHPfxzPveGJhyEyaZQclGp5B5iEYl90+jp16AnCX5cHG0ik8mOgRf1eZcR?=
 =?us-ascii?Q?jOqcxIe9xkML2xjeMvoBO+fqe9Zm+vmXN8vYRare+429Qgo+pnHCo6Zrrpdp?=
 =?us-ascii?Q?pwVbyCxcHdvyTQgUeKAcOe/GLRxZuwwYEi7WfBzoe3tk9A1MVx4BSmNzNw0l?=
 =?us-ascii?Q?KPcZaFfhsqnhg2w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TW4U2tE4zX7pLNLu8ul6q8GST3xhEWmN7Aptrpqu/YaCT+LnjkSMhAO1UqtP?=
 =?us-ascii?Q?zOupdDfpNxQm4S092hOkBV1nv91mYF/2B0t2W8Tn26Z6qncN5ce9LsrDKyx8?=
 =?us-ascii?Q?Eh0FgtYHG5/WPKEa9yNemNVV9WiC9jXAEXD5DT881LLsjOfSj8FFn2zNpRfC?=
 =?us-ascii?Q?+tswYs0CDwrB3rqWXsZq8VoBul7QyQ3f461fS80QX5Kd3dllLq+GN3eVX/bY?=
 =?us-ascii?Q?b7sseluF6ZNwjBiQ7gP9fFfEsVIl3iXOJYcnDhh8D1IN/JremUTYb4cRvCBg?=
 =?us-ascii?Q?x2Z5SfVjHOjEr5TyfRDOpM/p57wWXqYjm0ZWMNO3Uzx9I7WXc9JtUxXrDcAL?=
 =?us-ascii?Q?YVCFwlyfS3MSsj0lTzwgs0zaRuT/o87UdUa3PTxpwm+cD2KnkPqQgbdkjztq?=
 =?us-ascii?Q?AtZEK8wJ1YP/92pVFG4F7kQm9tX+q8TA6ND2EAJ6mHeBFVVoMsWqUSC6Yqhz?=
 =?us-ascii?Q?eEhBhlt9xpDfMTOrf1P3wk2V5TVceGkX/tsXoX6HKqNprIHvxJ7RwGwGBC7e?=
 =?us-ascii?Q?xxP5/VEDFVELcr9VW2p9PRCQGNE0I3wAAco3wo9IM4VuRbpsTthxIKy/hcmG?=
 =?us-ascii?Q?RRV8qQc0LGmKWJfMvZCITgyXgD7JJZm+DuEMAXRd+yTu0WxLwqdr/Zbu0hvB?=
 =?us-ascii?Q?AXP/Z3bHkApgREPlp1PbdCruto2CULP/twMngYr3/gB27ZLXJfEsy3SnUNea?=
 =?us-ascii?Q?IVDgUomBF95o8LrxiOLKY2H4TtGVwws2UMGQop23RV0C+b2WjtU29TZn+Fey?=
 =?us-ascii?Q?G6nwfg4h8RtW/D7hwTRY95poJeGl4Zb0rADTheSDJSqQYlMCGm/ytfmG06BI?=
 =?us-ascii?Q?3j3KfGAEf7LlcSQ2/EXx8VXu7ug50ygUtrW8s7SN5d/0eKkNbioilRGxeTYu?=
 =?us-ascii?Q?gyowEaN5TR8pSAi/xKOvkSp2xjGFJ27tut9rYjbAG92IHTLCjakAxaCy0WP+?=
 =?us-ascii?Q?CKkCQ3CLusYOp7PAPRJY3bGWoycsyG8GnZvbPdU3G21s4YNzrHgQa4BDb4yf?=
 =?us-ascii?Q?TFeUcD2kMGB/Fba34aFSgIpb/FpuzkMXR2itJEOhUWYgWZPf2bsLMURzqD61?=
 =?us-ascii?Q?0pRRlpGuvD7V33FloqTm9cVMDUc2+carJkldf6Q3OYJO9QozcDhtEhBJFCs1?=
 =?us-ascii?Q?xG528+zgJTrLlZ9kqKzjK/K9aI7QYV4LgNo9bN7huBOqqBOlxcTdBSBvKIZ0?=
 =?us-ascii?Q?SyPwjt/68lT5zURLY2r5MAYtrBNJQ2ln4qSXjLBJBWAGIa4IOJyDmz+V08+P?=
 =?us-ascii?Q?6evNF1KoR8F1nARonuvraygisQ3XgHJfkmqxgv60ZAY8Tfw7kZb/hZ4a3Kt7?=
 =?us-ascii?Q?YZOIm6d0KL6RdiVr9v8ddiaVUlkQe44A7Y2orr25RhUxRgmMdEV/yL3RWN+p?=
 =?us-ascii?Q?Q8BLcLLcurlPjVihnH5pazzPYyhc0oEhZZ8D5QplvKiO1CrHAjD0IDVfyEGG?=
 =?us-ascii?Q?GQE/0YjPXACVrPnB1r7VN7T1LyYKLSepAn46WpPQr+BzO2epdWFOjtxXvQ0U?=
 =?us-ascii?Q?99wxCEVBoBlTzlrY2tIB+dUFF1H1c5YMoeJTKOxyyENIStT3u67F/PSEgXLH?=
 =?us-ascii?Q?4LVmfW+yTyQp89a020yYqFEVQSahXqTKHzBXJ8ST?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47be57c3-ba4d-498a-2102-08de208a3580
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 18:51:51.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZynLY9LKJYZAh+I+3d5+lyBXm4CKOcFJ0lIFBkMQOPXfKYKpKIeo8yWpAWud8AcJInoiAoHpVjLA+hgkN2ELHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463

On Mon, Nov 10, 2025 at 12:06:08PM +0100, Jesper Dangaard Brouer wrote:
> 
> 
> On 07/11/2025 11.28, Dragos Tatulea wrote:
> > XDP uses the BPF_RI_F_RF_NO_DIRECT flag to mark contexts where it is not
> > allowed to do direct recycling, even though the direct flag was set by
> > the caller. This is confusing and can lead to races which are hard to
> > detect [1].
> > 
> > Furthermore, the page_pool already contains an internal
> > mechanism which checks if it is safe to switch the direct
> > flag from off to on.
> > 
> > This patch drops the use of the BPF_RI_F_RF_NO_DIRECT flag and always
> > calls the page_pool release with the direct flag set to false. The
> > page_pool will decide if it is safe to do direct recycling. This
> > is not free but it is worth it to make the XDP code safer. The
> > next paragrapsh are discussing the performance impact.
> > 
> > Performance wise, there are 3 cases to consider. Looking from
> > __xdp_return() for MEM_TYPE_PAGE_POOL case:
> > 
> > 1) napi_direct == false:
> >    - Before: 1 comparison in __xdp_return() + call of
> >      page_pool_napi_local() from page_pool_put_unrefed_netmem().
> >    - After: Only one call to page_pool_napi_local().
> > 
> > 2) napi_direct == true && BPF_RI_F_RF_NO_DIRECT
> >    - Before: 2 comparisons in __xdp_return() + call of
> >      page_pool_napi_local() from page_pool_put_unrefed_netmem().
> >    - After: Only one call to page_pool_napi_local().
> > 
> > 3) napi_direct == true && !BPF_RI_F_RF_NO_DIRECT
> >    - Before: 2 comparisons in __xdp_return().
> >    - After: One call to page_pool_napi_local()
> > 
> > Case 1 & 2 are the slower paths and they only have to gain.
> > But they are slow anyway so the gain is small.
> > 
> > Case 3 is the fast path and is the one that has to be considered more
> > closely. The 2 comparisons from __xdp_return() are swapped for the more
> > expensive page_pool_napi_local() call.
> > 
> > Using the page_pool benchmark between the fast-path and the
> > newly-added NAPI aware mode to measure [2] how expensive
> > page_pool_napi_local() is:
> > 
> >    bench_page_pool: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
> >    bench_page_pool: Type:tasklet_page_pool01_fast_path Per elem: 15 cycles(tsc) 7.537 ns (step:0)
> > 
> >    bench_page_pool: time_bench_page_pool04_napi_aware(): in_serving_softirq fast-path
> >    bench_page_pool: Type:tasklet_page_pool04_napi_aware Per elem: 20 cycles(tsc) 10.490 ns (step:0)
> > 
> 
> IMHO fast-path slowdown is significant.  This fast-path is used for the
> XDP_DROP use-case in drivers.  The fast-path is competing with the speed
> of updating an (per-cpu) array and a function-call overhead. The
> performance target for XDP_DROP is NIC *wirespeed* which at 100Gbit/s is
> 148Mpps (or 6.72ns between packets).
>
> I still want to seriously entertain this idea, because (1) because the
> bug[1] was hard to find, and (2) this is mostly an XDP API optimization
> that isn't used by drivers (they call page_pool APIs directly for
> XDP_DROP case).
> Drivers can do this because they have access to the page_pool instance.
> 
> Thus, this isn't a XDP_DROP use-case.
>  - This is either XDP_REDIRECT or XDP_TX use-case.
> 
> The primary change in this patch is, changing the XDP API call
> xdp_return_frame_rx_napi() effectively to xdp_return_frame().
> 
> Looking at code users of this call:
>  (A) Seeing a number of drivers using this to speed up XDP_TX when
> *completing* packets from TX-ring.
>  (B) drivers/net/xen-netfront.c use looks incorrect.
>  (C) drivers/net/virtio_net.c use can easily be removed.
>  (D) cpumap.c and drivers/net/tun.c should not be using this call.
>  (E) devmap.c is the main user (with multiple calls)
> 
> The (A) user will see a performance drop for XDP_TX, but these driver
> should be able to instead call the page_pool APIs directly as they
> should have access to the page_pool instance.
> 
> Users (B)+(C)+(D) simply needs cleanup.
> 
> User (E): devmap is the most important+problematic user (IIRC this was
> the cause of bug[1]).  XDP redirecting into devmap and running a new
> XDP-prog (per target device) was a prime user of this call
> xdp_return_frame_rx_napi() as it gave us excellent (e.g. XDP_DROP)
> performance.
>
Thanks for the analysis Jesper.

> Perhaps we should simply measure the impact on devmap + 2nd XDP-prog
> doing XDP_DROP.  Then, we can see if overhead is acceptable... ?
>
Will try. Just to make sure we are on the same page, AFAIU the setup
would be:
XDP_REDIRECT NIC1 -> veth ingress side and XDP_DROP veth egress side?

> > ... and the slow path for reference:
> > 
> >    bench_page_pool: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
> >    bench_page_pool: Type:tasklet_page_pool02_ptr_ring Per elem: 30 cycles(tsc) 15.395 ns (step:0)
> 
> The devmap user will basically fallback to using this code path.
>
Yes, if the page_pool is not NAPI aware.

Thanks,
Dragos

