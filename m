Return-Path: <bpf+bounces-54775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C01A71E3D
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 19:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330847A4348
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7941253B75;
	Wed, 26 Mar 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HMgfMUoe"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E0A251791;
	Wed, 26 Mar 2025 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013357; cv=fail; b=VY+sM38BO/5a/ZTeACMRFxhiyboF0hXEkXFUYPKg5QixTC2uUU1ALEE2Mr/qHNswRL8XYmsmPNePdOMgP5vJ+tXXn5cbntEokU5MdELT2whAvcFE73J5wLu1wjsEX+IAHwjjTQqowVF+kglf46b4YC4PQ4juAmiKtIeuPnmbh6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013357; c=relaxed/simple;
	bh=TG9R1s/pH4qdjTwel/UpiKSrwAzpoi0dd4UBvflO/hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DlKR+98iwGw9qLLq0vpCKRUhBzbbjkArmQjKFStGRhDw43uShqyA8UH1v7WTThqgs1A1hEVH7RsYYjeB+QaS6cirLCS2GGs/pVZBNSlZFTMS5avtE7ox4IRr+DmVZi3gQrrZpKHGh20I9Mgqec7ycltktUq5EFkHSmAQtRcv3P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HMgfMUoe reason="signature verification failed"; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlFJynRFC/RIeS5TaeHwm/zwRwvgWwG1KBJ4B8ijIsrDS3JmW7XUNQzumAxeSfUdNnEBdzLv3+kDbB48ZzVtrTWz28BXSBdhoHe/P6iT0OGG+sBnFZzP145Ib9mgIlHyxVG5irUbSm3KfnEX+fJTtCCFCr9v+PInwShA1Kfwl/o4Qe+jVquHl1ECFvs6MTbH46DQhbx0HmXgW3mU3BuGFlC2JbfAwuns90D6Rojit1bUy8NyZI1x579CKuOzISa659ge31El5lcMh8e5z8+p+6ZgL1MX+fNRhKD/ube1yAUH5J98DDX7mwT2X/HeA7RK9z66rALMQLZWAxNm8wL88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnVvm3mFYswwGr0G/CwUwP2sHAD2leHjfB8UWpwM+Cw=;
 b=qLQynUL+1/k7kKYpo/i5/1BF4B5vGT9Vod8T5JJSkeI+ha5+fH7aLfa3n0Rn4L/gmeS8i/lM7H+d7H5sw6BvhryGlMONKQe3BjdykfHYrX3NawfapAsW7/364030oNdFYEWmrt312oTjhPkVTJJOpHwPx1fpJJQFupm+smUsDTB7Sn/f/SlOmZiccdmKPR8JMTcZXel5qYGJzXs47wURk91a0j9ajqNm4LBrBk7IVCRrsGxwbdbvSipPOGRH6Mh89t2yQU7nOO+g/lOgKgwDO7cG4hf2vkRsk1ucFHAR7BxLA3/HZ4o0t3+JNJ4Cl7AKbGA6/W74qdd0a0GH7mSaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnVvm3mFYswwGr0G/CwUwP2sHAD2leHjfB8UWpwM+Cw=;
 b=HMgfMUoe6s0LxhsubpF3JJy6G5MKZg2s0anEdYpylAILsfsRLc2SEeNGHkYqFGJbA6PODdrar4guVLnKrnm5jyP1ZmuolelDZwaM+9yG2LLa5mzgysfCbQlj48xM6LHE7uaTcJBCAf9phwc+sThLqnWqZXzajcguacuJL6VbT7079101eIdNCHEq2TJSGjPwIpasTDimOaNLn8pkhNQvzPkhrZZ0g092hf82al01nW1Z/iwhBJ8jAGR28H2giKBu52uJn9yZgY1lXQPSoTZQ4zi61DO3eNf8cq/U3uhW2lSCc3KfsB9i+7HlD+eNLpFCDQJoUhyp0mG8hoW5p43jyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 by SJ5PPFD525C5379.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 18:22:29 +0000
Received: from IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12]) by IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 18:22:29 +0000
Date: Wed, 26 Mar 2025 11:22:27 -0700
From: Saeed Mahameed <saeedm@nvidia.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mina Almasry <almasrymina@google.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
	Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
Message-ID: <Z-RF4_yotcfvX0Xz@x130>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-3-113ebc1946f3@redhat.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325-page-pool-track-dma-v2-3-113ebc1946f3@redhat.com>
X-ClientProxiedBy: BYAPR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::21) To IA1PR12MB7663.namprd12.prod.outlook.com
 (2603:10b6:208:424::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7663:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: f58d8fac-6ff2-4082-ba39-08dd6c932ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?3IMEz4mk7C52qVFhMOelKHqcejhXrnmOvaOjZUfZ0pUMbXmY04nR/N8D6M?=
 =?iso-8859-1?Q?QizyPpGXUjSBy+iLMb6gBeK/rqK+sTzYuLZvw/Dwc8vQT+EfVWm38UDy56?=
 =?iso-8859-1?Q?mRAWNBhFb24VcDS2lgn4TZfyhW5g/bbY07FbHiMp1CwXivbcdYo2brMpzy?=
 =?iso-8859-1?Q?pvQ/D2ckpGVkdHUS2zN1vnvBir8oC/CSHKqpbW28+7OESsLcoXUIGIqAWU?=
 =?iso-8859-1?Q?YZ4VQJCf/Obsyo2MNizpBjmc3Y/hKf811qhZT7OPz4ZyvT7St/Si0UYRnQ?=
 =?iso-8859-1?Q?fIBfSLVgX1JulvBN5ZVkuFd6U5RNmqQuQxLRhnubB1pZ4EgoyOlqFdI+LY?=
 =?iso-8859-1?Q?Oy46olBVagVvNvbEuvnTdfLkmkMXEZEw0S4vPeZHma6yDbUsPpKgxIe8Re?=
 =?iso-8859-1?Q?i76PSX36eztiATmC89BgFDa56+JZSQuPO+ymYpgBnIOwoRWW4tlgFRQ0OJ?=
 =?iso-8859-1?Q?eJ8yVZdyI04WrBed3LBnnH8vfTECpxS9Ilqj26W8RqrA2WTb8sRCnq/Qmv?=
 =?iso-8859-1?Q?Gdv88QUq5WN9A1MOhS7uYKB1zcIxPgU1IoKiahJiUi3NCXeR/k7Ar2Z52x?=
 =?iso-8859-1?Q?KWDlogyg56GSgc0x6a9+B71P05Nc0cEA9H6S98UrgXq5M1sCMJrMYsRrwD?=
 =?iso-8859-1?Q?39ajer+Hc0pIZ//ouBvuaWLfn8MhEzB1GT1iCRxEoDEQjyLl7bhKvz1UvL?=
 =?iso-8859-1?Q?UeKfDhk2OULQpFChAFR9N2X4myygsm6FQ7ybsRZ6Sk0cH2GVmy6t1z0Gxc?=
 =?iso-8859-1?Q?GbNAJOKdgVIzv5qgR9VjysG1Ex6AJNtKt7fSSfIHaZJQWkjvpd8HrIHXEy?=
 =?iso-8859-1?Q?wLuQN6Pf08GwL4HTUG3ZffQH70hXbVn1Vq7InSdKoSzBAIvCxSzUIqJ243?=
 =?iso-8859-1?Q?47fG03km9fSDAHixvLJ1bOAzzfwiskPSEiZv0m8SE/d25ZLrzL5ANTTt55?=
 =?iso-8859-1?Q?rBmgUk//w5tWzrD9hMSgfBmmgyxnZ3nbQ3IrGu6xMe/m/BDBm4If/VFKsQ?=
 =?iso-8859-1?Q?RGBg63FEw5sT7z+3KpXfdXMoxhfs00oX1nj+bo+mhAz40evEkUvJZAeG+B?=
 =?iso-8859-1?Q?tn23xoL02sSEJxzUuT3PuvrQVeUepU1/GMNrrPcWhhgBQ/C25Wxi+2fpnp?=
 =?iso-8859-1?Q?37XvGIIUQ0a6YZCM6+lABGlcL9fQFpIM37yML+tdDfksoU0tao690veeI5?=
 =?iso-8859-1?Q?t/El/hzogf7WskGQqanu0n7hWV3JEl4CXJYAwYyOkXe+UvqZp7stKUAcfn?=
 =?iso-8859-1?Q?uAXiHpLd+rR1f4ilBcNv9s3EW7Oyemgapz5OzFFZtoVDbG8SYvYGlysmTX?=
 =?iso-8859-1?Q?HaJeLS+FQmZ8mpzkhrUA3Flwo5hnQ4ev0ahIazOm4mD4FScul7UoSIQ5y5?=
 =?iso-8859-1?Q?icFFiH27Vd01YjCg4SFuKMBbyYHDdanrh7bt5x2DiXV77QZb+WHrx8MkJk?=
 =?iso-8859-1?Q?It6LayzivhmdDnFp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?1cSgzcOYX8EQxU/ICfURmh1bmtmRL+22C0zkl6oTR1x2/x23UHTORrOX09?=
 =?iso-8859-1?Q?xUMCNYO+mYdnauuTyK6hkXc62VmZtfEKLJKUowZlx0AoeKCnMkFgCVzU1+?=
 =?iso-8859-1?Q?LpC289cIF5Fp6jRfe75lQQJNyVFau/eBzsJBxKmCrfdjHNZ3LZzAqoCjLs?=
 =?iso-8859-1?Q?uasiykyR2WpgKDXTxw7L1Eoj1fvKRU3xZ/kvoZ/6p1DnXikqqcOSwEpu8H?=
 =?iso-8859-1?Q?CIBTgL1IW7EmfEpl8N0sEmzvGYcXjVuWekAo0S29mJflnL9TKsAfvUg1B2?=
 =?iso-8859-1?Q?mHiQlW8KWn+riruj+rF7hf/TEwnpJMcPNalmfe5GM00hAAC4tYSYQw6okN?=
 =?iso-8859-1?Q?924v+YvXcHJSPjhY4XqpPwiEs9Fo/SrOY2T4kHTiC9g+hloWE/z4dzFuYt?=
 =?iso-8859-1?Q?4ZH8LLd/1ZwREfzPoHawUqXt/yeaImrkWDYHhQELW3ucbMkGAa4Hft1bJu?=
 =?iso-8859-1?Q?1drNSB/yWoofBU96fcIgVB7oDV32yFBZN9+OqeSdfsTHbTDDvw4VWJN2Y6?=
 =?iso-8859-1?Q?S4TUxoMmvsHc1Nqnt4/ZYOifSuOr3qQo12PXsnNmsjzOGJIhoFwxfXg6N3?=
 =?iso-8859-1?Q?A+5R/g0l9feLiLghxSKnOPbwO3tbZRMCsNPSnUqM5mD/UdDRysY4+Rz+8S?=
 =?iso-8859-1?Q?JQk+qfWpjd2AyIU7/iO2ehdWxobrWPWSHh+L9JjIvVPZm8D+CLf03LekZ+?=
 =?iso-8859-1?Q?3hYT0Q/tG/XySDuTpQzO2nvt/N4C8VPKL1RKV16t9E5a7lvArmVX7B/shL?=
 =?iso-8859-1?Q?Calc+cL5V5NEvOcf6nTAtEuEkWuQFXNz5+hvGRnpV6rZBrjuZFbT7FIdQH?=
 =?iso-8859-1?Q?ND36QCl3pcYvqWg66X9hOjiBp4oSMQ9byDAyIWtF48+cOGAGSo/2cAuAoh?=
 =?iso-8859-1?Q?Z4xsXbtsxVQiCohIeyTu2AvLCsscRDotnG7x37FMuAJD/xdhmb1Y0AdQhF?=
 =?iso-8859-1?Q?14iduKqsqYZb/DonI7x5w45Eb3zJuipJkp576ugq35dbbdH3MgXYz8moS9?=
 =?iso-8859-1?Q?yipQUd9uKRBT0triICGobyBqJ0qs5wFOzuDs2tiKWOLAOVVO+v04EY6OWb?=
 =?iso-8859-1?Q?ETNFZobuyj3lnDz/lm+oWn/V4JRCGTlsW1BrP3SI+f4nJSIheZDPLnweab?=
 =?iso-8859-1?Q?r65IJMGPTLmkblb9p+dQwHrv33qcJ4WiTQpg3IQYzv/Pld98Ads9II66kA?=
 =?iso-8859-1?Q?1dDKK3jcpgnS4bFKyzL3uDLMV+MSMSfjpZc1eRwzVRXEXVbmtRvWF/2o1W?=
 =?iso-8859-1?Q?wN7qq6M9Df8ZTRGF4OSiBcfUW2CXpkhGwxdA2YDmy/ma0nMHdFA9AYpgEe?=
 =?iso-8859-1?Q?4x+qWNsHuaVDOgn0NDJs192uB8DBIob3gaKnHz3UGHPbMrfADptxY7S/T+?=
 =?iso-8859-1?Q?lLbJ36s0QA1dYrI7kbZOusLkaGKVFCOKsXLrizRHsvPP8w/Kx1MMc6LBo+?=
 =?iso-8859-1?Q?1TsHuLAzSjc9CO0Ux0sWTJPzSm0QomfdecPl8IaGkaTDbHenND/SYw4nQV?=
 =?iso-8859-1?Q?aEB5IsWHD4AmvgYCMXo+Bvnj9bSzrGtaF+UHjXtm2ZNnZVijzLXpldwbP2?=
 =?iso-8859-1?Q?bYNw4CGsfCerQwtOSJ5CrYnXdWz7IacbTnFCKontZgOPU8Cre93yUgXare?=
 =?iso-8859-1?Q?bgfH2Hb67rXQyo2At+iR3OEeUik6bb2fRY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58d8fac-6ff2-4082-ba39-08dd6c932ae6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 18:22:29.4103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVsuILuRXLEMKjB0krNiu3iIJ6obOdWXLnAetRX56dBtXnsZXyqCO+Av+bgGa8yVBcjMyO1D69X4HGrEuKarEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379

On 25 Mar 16:45, Toke Høiland-Jørgensen wrote:
>When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>they are released from the pool, to avoid the overhead of re-mapping the
>pages every time they are used. This causes resource leaks and/or
>crashes when there are pages still outstanding while the device is torn
>down, because page_pool will attempt an unmap through a non-existent DMA
>device on the subsequent page return.
>

Why dynamically track when it is guaranteed the page_pool consumer (driver) 
will return all outstanding pages before disabling the DMA device.
When a page pool is destroyed by the driver, just mark it as "DMA-inactive",
and on page_pool_return_page() if DMA-inactive don't recycle those pages 
and immediately DMA unmap and release them. We can also track drivers if
they still have page_pools with outstanding DMA, and print a warning when
DMA is disabled.

I know there's an extra check on fast path, but looking below it seems
like slow path is becoming unnecessarily complicated, and we are sacrificing
slow path performance significantly for the sake of not touching fast path
at all. page_pool slow path should _not_ be significantly slower
than using the page allocator directly! In many production environments and
some workloads, page pool recycling can happen at a very low rate resulting
on performance relying solely on slow path.. 

>To fix this, implement a simple tracking of outstanding DMA-mapped pages
>in page pool using an xarray. This was first suggested by Mina[0], and
>turns out to be fairly straight forward: We simply store pointers to
>pages directly in the xarray with xa_alloc() when they are first DMA
>mapped, and remove them from the array on unmap. Then, when a page pool
>is torn down, it can simply walk the xarray and unmap all pages still
>present there before returning, which also allows us to get rid of the
>get/put_device() calls in page_pool. Using xa_cmpxchg(), no additional
>synchronisation is needed, as a page will only ever be unmapped once.
>
>To avoid having to walk the entire xarray on unmap to find the page
>reference, we stash the ID assigned by xa_alloc() into the page
>structure itself, using the upper bits of the pp_magic field. This
>requires a couple of defines to avoid conflicting with the
>POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
>so does not affect run-time performance. The bitmap calculations in this
>patch gives the following number of bits for different architectures:
>
>- 23 bits on 32-bit architectures
>- 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
>- 32 bits on other 64-bit architectures
>
>Stashing a value into the unused bits of pp_magic does have the effect
>that it can make the value stored there lie outside the unmappable
>range (as governed by the mmap_min_addr sysctl), for architectures that
>don't define ILLEGAL_POINTER_VALUE. This means that if one of the
>pointers that is aliased to the pp_magic field (such as page->lru.next)
>is dereferenced while the page is owned by page_pool, that could lead to
>a dereference into userspace, which is a security concern. The risk of
>this is mitigated by the fact that (a) we always clear pp_magic before
>releasing a page from page_pool, and (b) this would need a
>use-after-free bug for struct page, which can have many other risks
>since page->lru.next is used as a generic list pointer in multiple
>places in the kernel. As such, with this patch we take the position that
>this risk is negligible in practice. For more discussion, see[1].
>
>Since all the tracking added in this patch is performed on DMA
>map/unmap, no additional code is needed in the fast path, meaning the
>performance overhead of this tracking is negligible there. A
>micro-benchmark shows that the total overhead of the tracking itself is
>about 400 ns (39 cycles(tsc) 395.218 ns; sum for both map and unmap[2]).
>Since this cost is only paid on DMA map and unmap, it seems like an
>acceptable cost to fix the late unmap issue. Further optimisation can
>narrow the cases where this cost is paid (for instance by eliding the
>tracking when DMA map/unmap is a no-op).
>
What I am missing here, what is the added cost of those extra operations on
the slow path compared to before this patch? Total overhead being
acceptable doesn't justify the change, we need diff before and after.

>The extra memory needed to track the pages is neatly encapsulated inside
>xarray, which uses the 'struct xa_node' structure to track items. This
>structure is 576 bytes long, with slots for 64 items, meaning that a
>full node occurs only 9 bytes of overhead per slot it tracks (in
>practice, it probably won't be this efficient, but in any case it should
>be an acceptable overhead).
>
>[0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/
>[1] https://lore.kernel.org/r/20250320023202.GA25514@openwall.com
>[2] https://lore.kernel.org/r/ae07144c-9295-4c9d-a400-153bb689fe9e@huawei.com
>
>Reported-by: Yonglong Liu <liuyonglong@huawei.com>
>Closes: https://lore.kernel.org/r/8743264a-9700-4227-a556-5f931c720211@huawei.com
>Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
>Suggested-by: Mina Almasry <almasrymina@google.com>
>Reviewed-by: Mina Almasry <almasrymina@google.com>
>Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
>Tested-by: Qiuling Ren <qren@redhat.com>
>Tested-by: Yuying Ma <yuma@redhat.com>
>Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>---
> include/linux/poison.h        |  4 +++
> include/net/page_pool/types.h | 49 +++++++++++++++++++++++---
> net/core/netmem_priv.h        | 28 ++++++++++++++-
> net/core/page_pool.c          | 82 ++++++++++++++++++++++++++++++++++++-------
> 4 files changed, 145 insertions(+), 18 deletions(-)
>
>diff --git a/include/linux/poison.h b/include/linux/poison.h
>index 331a9a996fa8746626afa63ea462b85ca3e5938b..5351efd710d5e21cc341f7bb533b1aeea4a0808a 100644
>--- a/include/linux/poison.h
>+++ b/include/linux/poison.h
>@@ -70,6 +70,10 @@
> #define KEY_DESTROY		0xbd
>
> /********** net/core/page_pool.c **********/
>+/*
>+ * page_pool uses additional free bits within this value to store data, see the
>+ * definition of PP_DMA_INDEX_MASK in include/net/page_pool/types.h
>+ */
> #define PP_SIGNATURE		(0x40 + POISON_POINTER_DELTA)
>
> /********** net/core/skbuff.c **********/
>diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
>index fbe34024b20061e8bcd1d4474f6ebfc70992f1eb..8f9ed92a4b2af6c136406c41b1a829c8e52ba3e2 100644
>--- a/include/net/page_pool/types.h
>+++ b/include/net/page_pool/types.h
>@@ -6,6 +6,7 @@
> #include <linux/dma-direction.h>
> #include <linux/ptr_ring.h>
> #include <linux/types.h>
>+#include <linux/xarray.h>
> #include <net/netmem.h>
>
> #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
>@@ -58,13 +59,51 @@ struct pp_alloc_cache {
> 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
> };
>
>+/*
>+ * DMA mapping IDs
>+ *
>+ * When DMA-mapping a page, we allocate an ID (from an xarray) and stash this in
>+ * the upper bits of page->pp_magic. We always want to be able to unambiguously
>+ * identify page pool pages (using page_pool_page_is_pp()). Non-PP pages can
>+ * have arbitrary kernel pointers stored in the same field as pp_magic (since it
>+ * overlaps with page->lru.next), so we must ensure that we cannot mistake a
>+ * valid kernel pointer with any of the values we write into this field.
>+ *
>+ * On architectures that set POISON_POINTER_DELTA, this is already ensured,
>+ * since this value becomes part of PP_SIGNATURE; meaning we can just use the
>+ * space between the PP_SIGNATURE value (without POISON_POINTER_DELTA), and the
>+ * lowest bits of POISON_POINTER_DELTA. On arches where POISON_POINTER_DELTA is
>+ * 0, we make sure that we leave the two topmost bits empty, as that guarantees
>+ * we won't mistake a valid kernel pointer for a value we set, regardless of the
>+ * VMSPLIT setting.
>+ *
>+ * Altogether, this means that the number of bits available is constrained by
>+ * the size of an unsigned long (at the upper end, subtracting two bits per the
>+ * above), and the definition of PP_SIGNATURE (with or without
>+ * POISON_POINTER_DELTA).
>+ */
>+#define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA))
>+#if POISON_POINTER_DELTA > 0
>+/* PP_SIGNATURE includes POISON_POINTER_DELTA, so limit the size of the DMA
>+ * index to not overlap with that if set
>+ */
>+#define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_INDEX_SHIFT)
>+#else
>+/* Always leave out the topmost two; see above. */
>+#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2)
>+#endif
>+
>+#define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
>+				  PP_DMA_INDEX_SHIFT)
>+#define PP_DMA_INDEX_LIMIT XA_LIMIT(1, BIT(PP_DMA_INDEX_BITS) - 1)
>+
> /* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
>  * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
>- * the head page of compound page and bit 1 for pfmemalloc page.
>- * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid recycling
>- * the pfmemalloc page.
>+ * the head page of compound page and bit 1 for pfmemalloc page, as well as the
>+ * bits used for the DMA index. page_is_pfmemalloc() is checked in
>+ * __page_pool_put_page() to avoid recycling the pfmemalloc page.
>  */
>-#define PP_MAGIC_MASK ~0x3UL
>+#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>
> /**
>  * struct page_pool_params - page pool parameters
>@@ -233,6 +272,8 @@ struct page_pool {
> 	void *mp_priv;
> 	const struct memory_provider_ops *mp_ops;
>
>+	struct xarray dma_mapped;
>+
> #ifdef CONFIG_PAGE_POOL_STATS
> 	/* recycle stats are per-cpu to avoid locking */
> 	struct page_pool_recycle_stats __percpu *recycle_stats;
>diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
>index f33162fd281c23e109273ba09950c5d0a2829bc9..cd95394399b40c3604934ba7898eeeeacb8aee99 100644
>--- a/net/core/netmem_priv.h
>+++ b/net/core/netmem_priv.h
>@@ -5,7 +5,7 @@
>
> static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
> {
>-	return __netmem_clear_lsb(netmem)->pp_magic;
>+	return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
> }
>
> static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
>@@ -15,6 +15,8 @@ static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
>
> static inline void netmem_clear_pp_magic(netmem_ref netmem)
> {
>+	WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
>+
> 	__netmem_clear_lsb(netmem)->pp_magic = 0;
> }
>
>@@ -33,4 +35,28 @@ static inline void netmem_set_dma_addr(netmem_ref netmem,
> {
> 	__netmem_clear_lsb(netmem)->dma_addr = dma_addr;
> }
>+
>+static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
>+{
>+	unsigned long magic;
>+
>+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
>+		return 0;
>+
>+	magic = __netmem_clear_lsb(netmem)->pp_magic;
>+
>+	return (magic & PP_DMA_INDEX_MASK) >> PP_DMA_INDEX_SHIFT;
>+}
>+
>+static inline void netmem_set_dma_index(netmem_ref netmem,
>+					unsigned long id)
>+{
>+	unsigned long magic;
>+
>+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
>+		return;
>+
>+	magic = netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
>+	__netmem_clear_lsb(netmem)->pp_magic = magic;
>+}
> #endif
>diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>index d51ca4389dd62d8bc266a9a2b792838257173535..55acb4bc2c57893486f222e9f39b48a09b0d78d0 100644
>--- a/net/core/page_pool.c
>+++ b/net/core/page_pool.c
>@@ -226,6 +226,8 @@ static int page_pool_init(struct page_pool *pool,
> 			return -EINVAL;
>
> 		pool->dma_map = true;
>+
>+		xa_init_flags(&pool->dma_mapped, XA_FLAGS_ALLOC1);
> 	}
>
> 	if (pool->slow.flags & PP_FLAG_DMA_SYNC_DEV) {
>@@ -275,9 +277,6 @@ static int page_pool_init(struct page_pool *pool,
> 	/* Driver calling page_pool_create() also call page_pool_destroy() */
> 	refcount_set(&pool->user_cnt, 1);
>
>-	if (pool->dma_map)
>-		get_device(pool->p.dev);
>-
> 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
> 		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
> 		 * configuration doesn't change while we're initializing
>@@ -325,7 +324,7 @@ static void page_pool_uninit(struct page_pool *pool)
> 	ptr_ring_cleanup(&pool->ring, NULL);
>
> 	if (pool->dma_map)
>-		put_device(pool->p.dev);
>+		xa_destroy(&pool->dma_mapped);
>
> #ifdef CONFIG_PAGE_POOL_STATS
> 	if (!pool->system)
>@@ -466,14 +465,20 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
> 			      netmem_ref netmem,
> 			      u32 dma_sync_size)
> {
>-	if ((READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_DEV) &&
>-	    dma_dev_need_sync(pool->p.dev))
>-		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
>+	if (dma_dev_need_sync(pool->p.dev)) {
>+		rcu_read_lock();
>+		if (READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_DEV)
>+			__page_pool_dma_sync_for_device(pool, netmem,
>+							dma_sync_size);
>+		rcu_read_unlock();
>+	}
> }
>
>-static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
>+static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)
> {
> 	dma_addr_t dma;
>+	int err;
>+	u32 id;
>
> 	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
> 	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
>@@ -487,15 +492,28 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
> 	if (dma_mapping_error(pool->p.dev, dma))
> 		return false;
>
>-	if (page_pool_set_dma_addr_netmem(netmem, dma))
>+	if (in_softirq())
>+		err = xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
>+			       PP_DMA_INDEX_LIMIT, gfp);
>+	else
>+		err = xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
>+				  PP_DMA_INDEX_LIMIT, gfp);
>+	if (err) {
>+		WARN_ONCE(1, "couldn't track DMA mapping, please report to netdev@");
> 		goto unmap_failed;
>+	}
>
>+	if (page_pool_set_dma_addr_netmem(netmem, dma)) {
>+		WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
>+		goto unmap_failed;
>+	}
>+
>+	netmem_set_dma_index(netmem, id);
> 	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
>
> 	return true;
>
> unmap_failed:
>-	WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
> 	dma_unmap_page_attrs(pool->p.dev, dma,
> 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
>@@ -512,7 +530,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
> 	if (unlikely(!page))
> 		return NULL;
>
>-	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page)))) {
>+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page), gfp))) {
> 		put_page(page);
> 		return NULL;
> 	}
>@@ -558,7 +576,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
> 	 */
> 	for (i = 0; i < nr_pages; i++) {
> 		netmem = pool->alloc.cache[i];
>-		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem))) {
>+		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem, gfp))) {
> 			put_page(netmem_to_page(netmem));
> 			continue;
> 		}
>@@ -660,6 +678,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
> static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
> 							 netmem_ref netmem)
> {
>+	struct page *old, *page = netmem_to_page(netmem);
>+	unsigned long id;
> 	dma_addr_t dma;
>
> 	if (!pool->dma_map)
>@@ -668,6 +688,17 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
> 		 */
> 		return;
>
>+	id = netmem_get_dma_index(netmem);
>+	if (!id)
>+		return;
>+
>+	if (in_softirq())
>+		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
>+	else
>+		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
>+	if (old != page)
>+		return;
>+
> 	dma = page_pool_get_dma_addr_netmem(netmem);
>
> 	/* When page is unmapped, it cannot be returned to our pool */
>@@ -675,6 +706,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
> 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> 	page_pool_set_dma_addr_netmem(netmem, 0);
>+	netmem_set_dma_index(netmem, 0);
> }
>
> /* Disconnects a page (from a page_pool).  API users can have a need
>@@ -1084,8 +1116,32 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
>
> static void page_pool_scrub(struct page_pool *pool)
> {
>+	unsigned long id;
>+	void *ptr;
>+
> 	page_pool_empty_alloc_cache_once(pool);
>-	pool->destroy_cnt++;
>+	if (!pool->destroy_cnt++ && pool->dma_map) {
>+		if (pool->dma_sync) {
>+			/* paired with READ_ONCE in
>+			 * page_pool_dma_sync_for_device() and
>+			 * __page_pool_dma_sync_for_cpu()
>+			 */
>+			WRITE_ONCE(pool->dma_sync, false);
>+
>+			/* Make sure all concurrent returns that may see the old
>+			 * value of dma_sync (and thus perform a sync) have
>+			 * finished before doing the unmapping below. Skip the
>+			 * wait if the device doesn't actually need syncing, or
>+			 * if there are no outstanding mapped pages.
>+			 */
>+			if (dma_dev_need_sync(pool->p.dev) &&
>+			    !xa_empty(&pool->dma_mapped))
>+				synchronize_net();
>+		}
>+
>+		xa_for_each(&pool->dma_mapped, id, ptr)
>+			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
>+	}
>
> 	/* No more consumers should exist, but producers could still
> 	 * be in-flight.
>
>-- 
>2.48.1
>

