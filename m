Return-Path: <bpf+bounces-54772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8FEA71DE7
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 19:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310613A6F32
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4BE241139;
	Wed, 26 Mar 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JAbX8V0o"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6E240611;
	Wed, 26 Mar 2025 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012022; cv=fail; b=u00Ph+Jf0KtJxFUnyABQHx7y/g9HM2vXO7JELi+Rw/y3iU/7WvnNNV/8EVjJIO1QoQ+aSXGEsw3AYrkhWyRs9ixOB1NJLvIKHs0WsC2xYGUIKvSFQUeocKdw5ucFRL5YZQi7k4kA4DAuK1bSa+RvCzFRkqjT8NPSv5IGstzbaOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012022; c=relaxed/simple;
	bh=CuMlcZjDhrWge2UpV+xZgIwfvQxKZhVFMwRvqibkCqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RtP4pdJIMFGTxH34ioodrYLFAAHah3oRkIabw3jhoea9d2MY8DMK5wiVwfgbKVNsR777GjkQ9YAsBlVAvbP8zX/TJSiZ8jERHrNcFVxzyL9mXzngGI2PEgGcSQbw5jDaJT+TZ7rGDvTunIQcwCzDK2rWaCUmUdhCYdGYrVvO3R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JAbX8V0o reason="signature verification failed"; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQCvTqU7T4HNSxMceKYEvs9X1yF/TD5J+r4/4sByJBgI2wiw33hnT5zbaVoYvW3b/pDc5nqir4IbYqIfm8tGfjD+Au7VpS41uQZ976ybFWTxPQ8g/dvYmKT/lwDUBAnlYerekOWqsi55prNnt5cMxODs6b0YqQ/utdBLprdP34i1lGKb8Ak4vOS/9gv14SyY4tbye1m/AZdYnh+2O17sLe2uVsOaw/If9u7P8s2uhtf+e5Znav+Xb8mVZm2PnvUnRlwxoXjmqgnk/B4REfLRituhn3NeMC/+GGu4SjrMpwD02KGykaW+KYvIA4tth9UHU6+qxBrg7ns+uwmbb6gqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6X/ooK0cnIPyqsPX1FqfPYjHZcU9fS0f/DGpCl1juY=;
 b=BFhm8ir+JHgLs3LzNWc5hU6sAi7QzN4SZYEmCqw9XBadKMmAEchp4pWa2wMwarbroboqDT8B91UwND0FXAZcGs9cYWkIRRBwP32m2/GVb25X4YWTMhUQJ2grlJ/LAZ2v06bswj3JkGVUK+S96Tjah1sWe8LCJL9xAMU+ED+bpwimkxoYknt2Z87m1DpFsjyRg5OeL5BjRpKhvIYHildZfcpwQAieDwNHq/WaMY4CxxVlSBT2cGTNbbROox5RCI/dzIqbICkSq0dK1KW4utJDKrIKggjd54P+L15VGNqOaJZnMnW6KR1phRISGHFk8MVpNhvZO1kk0adsRgLAHBUNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6X/ooK0cnIPyqsPX1FqfPYjHZcU9fS0f/DGpCl1juY=;
 b=JAbX8V0o+8Q2m7GGwCr1iqxSGWgwCPJIHZmOirf8uBWFzj7n4CsYNJYEV0eZTpToBa9TyQhOxlwf9yXucN/667548O9Z/gvr9ICJpTxPMBGqJUaTrTIk2cxu5iMNdh83mrPRVLteFMrU+Q5N/CGmwySghDQ0eB/jNlQvtQewFJCsQYBhIAYg5H1FiLzPVxhW594niYVnpjSUKCC7mqIZ4+ro8vEh8sFmrlYqFn8Nk32z5OqWbWwNxN+jkMHF4lCXrkiOmI2GX0obR+tml6WJNLuTag7uOiobi1hDktPVRC/BT9eDdVuPiJc9RBS8ORcMbE0EE2I5dNN6wSVeQ9eAXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 18:00:05 +0000
Received: from IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12]) by IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 18:00:05 +0000
Date: Wed, 26 Mar 2025 11:00:04 -0700
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
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH net-next v2 2/3] page_pool: Turn dma_sync and
 dma_sync_cpu fields into a bitmap
Message-ID: <Z-RApGJCUUPP0-eO@x130>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-2-113ebc1946f3@redhat.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325-page-pool-track-dma-v2-2-113ebc1946f3@redhat.com>
X-ClientProxiedBy: BYAPR11CA0082.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::23) To IA1PR12MB7663.namprd12.prod.outlook.com
 (2603:10b6:208:424::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7663:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b51b30-a5ea-49a8-9697-08dd6c9009c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?rPmJhA9KlZNe/aPeyT+P9jjT3iVpfwNUmYpgiVlrSMr0736NwXfIvoOn7m?=
 =?iso-8859-1?Q?agoN0t6L9r1icw1Y/QvHdaoXTBsBf10FMVutpqoEgay5s859TaXXVKYRwM?=
 =?iso-8859-1?Q?+KbL1kk2fcAVfAHTGe1EjzadNungUMVZAgJovE+96nPAEa3QH0eak/zYgW?=
 =?iso-8859-1?Q?jMKipLpDDkwPJpvG5kOjGChZyXANpP2UBSKpSCM8ZUXtXJMgQa1yUsdCgK?=
 =?iso-8859-1?Q?XbOaQT3i32nxOY/XZUCeDzRxBM8AfPpyHpj/1MAJ8ixpM/GfJ/08mC7oE3?=
 =?iso-8859-1?Q?uJPvtfU8r0za9hMpUWS965Eac4Q2vFVAeDn3A7bZtnY3f+2QQ40ZZLuMaa?=
 =?iso-8859-1?Q?zx56JHmo7+4aipWuXfXoVV2hSourrYXPr+J731SsKGbW4sqigi9IbAw8wb?=
 =?iso-8859-1?Q?OfnCAwR9qZNK7rrQ1C+FL5xzWpJyrBtYPzXAB1JgAgb7etv8MoJdNCA2VT?=
 =?iso-8859-1?Q?rPBXUbBe5HATBpEgwbDAkjujl5GlimOnYZze4evocc+CMNSrRRxQZW17JW?=
 =?iso-8859-1?Q?e1FnvMLwEXI3TuSywGAFE0jTCZ5PJGuyjcDMxb3jrudguGZ2PBXN9MYUnW?=
 =?iso-8859-1?Q?wZqvediT3OUw1Ma9zvRdipCd6o/krOvj6H6oT49vxmgM54bVCxGR0QiJJh?=
 =?iso-8859-1?Q?oI3xtTz5r9sLRzybVVJT7ZE8OGrxaCDG2nVNFI4eiWiddtSK4BJtnl+pEW?=
 =?iso-8859-1?Q?Xu7oGbjQNDM/XFzM+Z6CO5Y+jlqXb1aNLZTz/wuT8vxk1Sju1JFr5eNNNB?=
 =?iso-8859-1?Q?FbsCUk68MuN5o6sPMTIO29oj0VQS4IY9YF96DPuaqUX1k7ziqxlLacZsc/?=
 =?iso-8859-1?Q?MqRJJ7iEvnAk/Noi89vB9aLFhAYFx+bkjiuPuwxSNUpQ9qOZt/LzNMdDNZ?=
 =?iso-8859-1?Q?g3DmcnNCBlLh7Etm7ySRX18yGTtOEAffEttlnIusrw2rE5jp9IlH6D/5u0?=
 =?iso-8859-1?Q?Q3BWtqj0zLc05InCRFvkdsrBIPS0jqJJ2GGmzLovwNp92PVB8vZooRukdC?=
 =?iso-8859-1?Q?k0eGJYrDJUxqr2xaJQr4cR+V59dkzoiTgCyg2oGnSg5MjrJz0xNY6LRlVW?=
 =?iso-8859-1?Q?VlUOFrW9xZ0uUCeaWf9WqNVkcIOAVJVBpTchxus5cedpSfTSln3prBGHBb?=
 =?iso-8859-1?Q?QnpTdt+rlj/Zh+bmGk6x3wMQxs/8Ku5yS/xd36pUroMfmYoscjNtjauk5I?=
 =?iso-8859-1?Q?RQbrf0CmJrjvgag9LZqQhbzW0Scp+FYhDkqkMk3tsjOXOqRYIy9aFH927l?=
 =?iso-8859-1?Q?2Ieamh87l3PSdty4saOKDFPXt1KK5hVy411UQ+3JYE8IymJ9AFOKKf/UcX?=
 =?iso-8859-1?Q?kjhpJgdpl+3790HBfm++5jKjf8bwIqJi1885+Ljgdf8t8LRlEzWqRHaJwG?=
 =?iso-8859-1?Q?YCqP2920PBAF2XGhSS96KRMoQ8rqXnqedgcx3R5dtVRk1o5VmqRxZWHb4L?=
 =?iso-8859-1?Q?ticbywd64m6TxFId?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?UQmF3kmLbNYlMCFz5hVWG3PA6eGHii5pmq48+nvuRxmNZ4mrTTCgAWTggn?=
 =?iso-8859-1?Q?zeQp8uAh4DFEuGAXyowZ98gqlL5i4gO5roJLgdSwdGOmgTs6SC4aL0vTF8?=
 =?iso-8859-1?Q?mo9WOw+439xORsaYBjZPL7NcWk5g/YGWkNL4nBixpJcYOFXrIigXrAEINl?=
 =?iso-8859-1?Q?sipbhPFZ5h4NcNFfrZ++5JnTer0/Bzg8e6j2suQxTi4oiwAmNMfA7dlYQf?=
 =?iso-8859-1?Q?hlsFNWHEqN4g/voVKH8HfsBs5yHp2orLZwKuvYIl4tGA2nUwePthuBwhmC?=
 =?iso-8859-1?Q?cnvcuT6u2rzyLF5nl4+NkOWKhfnRkpSXr+GuEg3Bf+6CQBnXL5c+PGwehl?=
 =?iso-8859-1?Q?F2xS+5SetVICxPdx4AfJTT9FAnhuRINvsreJ/dgYu9GOSJvuBiwNOva1a3?=
 =?iso-8859-1?Q?4ZkDesmg65j4YPIInVXDyIJ8n+iJnDbrKcNOUtNK+BsY53+iAcU2JzUNmN?=
 =?iso-8859-1?Q?dDb+Klt0DTYaHgfaKWXtmMyZT8DZjKPJbRwdspsNTjbeWPYOmwnRXNJ4n+?=
 =?iso-8859-1?Q?zFDhK1aa1CA0DYTvlBbZygv2AaWijBvHV9ZeaAVOYETuu5DWKiQsgG8I+V?=
 =?iso-8859-1?Q?1zuMwozzHrDyq/ncXCDcY3mTIxxWCEPusoy5rnOi65IbwR90c/IPWPzJB5?=
 =?iso-8859-1?Q?r6RQ2EuItvlce9RCJITn46u82nQ7Nt2ecKpQRC0RCRwHnpT5SZwZMdrutG?=
 =?iso-8859-1?Q?alcdecqmr5AJKH5E6DXHtpskBqjafFIdY0/q5EXMlSZA71tT1DGe3dLMmV?=
 =?iso-8859-1?Q?WNO2f6hC5s6UbmqitRIk3yeUbitH7vlkOe0Qm5r+oXmTII8590rx1yzljv?=
 =?iso-8859-1?Q?ayJRJ8ynVeit4apW7CXeG5QI2e6NmUb5VsINKflomBw0WkGnAWPp6/m/rm?=
 =?iso-8859-1?Q?DpzUP7VxRmW/QoxVGYbg0RZ/2Mi+h6Fc5cusTZTlAG0cQnytFWLoMIbQ0v?=
 =?iso-8859-1?Q?+UZkqTOwWs5UuiQQHiB8nyTZw45ioMI3nTi7hW8G5x9N0EektBcwa5bSB2?=
 =?iso-8859-1?Q?c1nYeRoZWSpRzL98TVvkmzjpBo6SVtHCrC6JXQbkdjj4LVwwqkA1MFO2ww?=
 =?iso-8859-1?Q?LUMaiorCGa76LHQApyRtGNUrFRhe5sT+PcDwz/btoRno/e7hzcvaomr+cc?=
 =?iso-8859-1?Q?rVAdKwgxLP/H9MJiG1r74i/Rh4vhaZ7SEOqYRjRLaZ2lHCz4IF3/KuxNbL?=
 =?iso-8859-1?Q?pvEmYUS+2xnejcoxgSw/Yy3Ys5qb65t6uDsYnkEiaitQDBCU0mdHz36g+X?=
 =?iso-8859-1?Q?IB0ega0jRyyQniUUN+brr0FUpy4/bUeo9FDsmW9qMZNf0xpT2MnHtylchu?=
 =?iso-8859-1?Q?MnmU2Cp06j4cy4SI10RRz56LKMJrr6w/8JoehtaN38zTtrWNoFfE5KOADQ?=
 =?iso-8859-1?Q?TaY3h8AmYvQsGcPYUD3xPI2sYpfLTtcKjkSg1lciI/gXmzAtIkU6e+Cle3?=
 =?iso-8859-1?Q?48LmX+GKIsElV9jNwXwY3ubxCeq+90obmpk9MwnpmKtCr2PHw3NNP8Z98J?=
 =?iso-8859-1?Q?z7C3FfCVwQXbUpiLeF1MYusBN2zxkytnMlBiUfjXgcKrf2RY1FtiM4WDuI?=
 =?iso-8859-1?Q?Q9QwwKpwqfnbCxYHXJTSZFfaWEPhounwHx+ftuUE5qWz8euhwUc/NdrPFr?=
 =?iso-8859-1?Q?hYmOmHhz7rvonJYvx1n4pxVnZelNkxonYi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b51b30-a5ea-49a8-9697-08dd6c9009c5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 18:00:05.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZlR3B5+aLKNSy2oRWteVaWGCVV0CdcxevA6BNxKH+YsxvBeIf3JO0s1g1kB512vlpTG7jpemtsNH3jw5JXARw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101

On 25 Mar 16:45, Toke Høiland-Jørgensen wrote:
>Change the single-bit booleans for dma_sync into an unsigned long with
>BIT() definitions so that a subsequent patch can write them both with a
>singe WRITE_ONCE() on teardown. Also move the check for the sync_cpu
>side into __page_pool_dma_sync_for_cpu() so it can be disabled for
>non-netmem providers as well.
>
>Reviewed-by: Mina Almasry <almasrymina@google.com>
>Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>---
> include/net/page_pool/helpers.h | 6 +++---
> include/net/page_pool/types.h   | 8 ++++++--
> net/core/devmem.c               | 3 +--
> net/core/page_pool.c            | 9 +++++----
> 4 files changed, 15 insertions(+), 11 deletions(-)
>
>diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
>index 582a3d00cbe2315edeb92850b6a42ab21e509e45..7ed32bde4b8944deb7fb22e291e95b8487be681a 100644
>--- a/include/net/page_pool/helpers.h
>+++ b/include/net/page_pool/helpers.h
>@@ -443,6 +443,9 @@ static inline void __page_pool_dma_sync_for_cpu(const struct page_pool *pool,
> 						const dma_addr_t dma_addr,
> 						u32 offset, u32 dma_sync_size)
> {
>+	if (!(READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_CPU))
>+		return;
>+

page_pool_dma_sync_for_cpu() is a wrapper for this function, and it assumes
pages were created with DMA flag, so you are adding this unnecessary check
for that path.

Just change page_pool_dma_sync_for_cpu() to directly call 
dma_sync_single_range_for_cpu(...) as part of this patch.

> 	dma_sync_single_range_for_cpu(pool->p.dev, dma_addr,
> 				      offset + pool->p.offset, dma_sync_size,
> 				      page_pool_get_dma_dir(pool));
>@@ -473,9 +476,6 @@ page_pool_dma_sync_netmem_for_cpu(const struct page_pool *pool,
> 				  const netmem_ref netmem, u32 offset,
> 				  u32 dma_sync_size)
> {
>-	if (!pool->dma_sync_for_cpu)
>-		return;
>-
> 	__page_pool_dma_sync_for_cpu(pool,
> 				     page_pool_get_dma_addr_netmem(netmem),
> 				     offset, dma_sync_size);
>diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
>index df0d3c1608929605224feb26173135ff37951ef8..fbe34024b20061e8bcd1d4474f6ebfc70992f1eb 100644
>--- a/include/net/page_pool/types.h
>+++ b/include/net/page_pool/types.h
>@@ -33,6 +33,10 @@
> #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
> 				 PP_FLAG_SYSTEM_POOL | PP_FLAG_ALLOW_UNREADABLE_NETMEM)
>
>+/* bit values used in pp->dma_sync */
>+#define PP_DMA_SYNC_DEV	BIT(0)
>+#define PP_DMA_SYNC_CPU	BIT(1)
>+
> /*
>  * Fast allocation side cache array/stack
>  *
>@@ -175,12 +179,12 @@ struct page_pool {
>
> 	bool has_init_callback:1;	/* slow::init_callback is set */
> 	bool dma_map:1;			/* Perform DMA mapping */
>-	bool dma_sync:1;		/* Perform DMA sync for device */
>-	bool dma_sync_for_cpu:1;	/* Perform DMA sync for cpu */
> #ifdef CONFIG_PAGE_POOL_STATS
> 	bool system:1;			/* This is a global percpu pool */
> #endif
>
>+	unsigned long dma_sync;
>+
> 	__cacheline_group_begin_aligned(frag, PAGE_POOL_FRAG_GROUP_ALIGN);
> 	long frag_users;
> 	netmem_ref frag_page;
>diff --git a/net/core/devmem.c b/net/core/devmem.c
>index 6802e82a4d03b6030f6df50ae3661f81e40bc101..955d392d707b12fe784747aa2040ce1a882a64db 100644
>--- a/net/core/devmem.c
>+++ b/net/core/devmem.c
>@@ -340,8 +340,7 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
> 	/* dma-buf dma addresses do not need and should not be used with
> 	 * dma_sync_for_cpu/device. Force disable dma_sync.
> 	 */
>-	pool->dma_sync = false;
>-	pool->dma_sync_for_cpu = false;
>+	pool->dma_sync = 0;
>
> 	if (pool->p.order != 0)
> 		return -E2BIG;
>diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>index acef1fcd8ddcfd1853a6f2055c1f1820ab248e8d..d51ca4389dd62d8bc266a9a2b792838257173535 100644
>--- a/net/core/page_pool.c
>+++ b/net/core/page_pool.c
>@@ -203,7 +203,7 @@ static int page_pool_init(struct page_pool *pool,
> 	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
>
> 	pool->cpuid = cpuid;
>-	pool->dma_sync_for_cpu = true;
>+	pool->dma_sync = PP_DMA_SYNC_CPU;
>
> 	/* Validate only known flags were used */
> 	if (pool->slow.flags & ~PP_FLAG_ALL)
>@@ -238,7 +238,7 @@ static int page_pool_init(struct page_pool *pool,
> 		if (!pool->p.max_len)
> 			return -EINVAL;
>
>-		pool->dma_sync = true;
>+		pool->dma_sync |= PP_DMA_SYNC_DEV;
>
> 		/* pool->p.offset has to be set according to the address
> 		 * offset used by the DMA engine to start copying rx data
>@@ -291,7 +291,7 @@ static int page_pool_init(struct page_pool *pool,
> 	}
>
> 	if (pool->mp_ops) {
>-		if (!pool->dma_map || !pool->dma_sync)
>+		if (!pool->dma_map || !(pool->dma_sync & PP_DMA_SYNC_DEV))
> 			return -EOPNOTSUPP;
>
> 		if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops))) {
>@@ -466,7 +466,8 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
> 			      netmem_ref netmem,
> 			      u32 dma_sync_size)
> {
>-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
>+	if ((READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_DEV) &&
>+	    dma_dev_need_sync(pool->p.dev))
> 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
> }
>
>
>-- 
>2.48.1
>

