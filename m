Return-Path: <bpf+bounces-64628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE1B14F29
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 16:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A5C3B4129
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9311B1DE4C9;
	Tue, 29 Jul 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ChnBxp4w"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15241760;
	Tue, 29 Jul 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798852; cv=fail; b=vGhOb2qgiXMiwvw8jKdk5KowZy6bbbo0KpUgRbM5US9Ixa34CW43cB1e4Y4xjqLgQNWBdK/Jx1WNNzTv7USxvRCwL38Kno+uTgtVKnNQ1o6q83cXPM/XOm3P8fJ7gwZWJEMJ2YyC1h281uVO3nM6i6oA0swbwE0wg1NWI8Jf2/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798852; c=relaxed/simple;
	bh=m3+jswGwY5Fi4tLVK7/mtc8GdWVQthV0uRuip6lkqB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ss7f2MKrotPbb6xdPHgE/txBm85Fe26CbAfV+eANPsJp63BA+vhaatug/+eT6BRJ/baONgcRHLEqioNClW7BnoFR3CIJRi8MzrNv6qEZ0SqvkDbcMdPAGd3u4S1mJTl6aJ1pyZUDuPy7H2HCJKWPjEzQ2hvOUGZVCbz8V2nQyqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ChnBxp4w; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSTDryfN7J1dQ1PceNU6iGaUsVrZAamgAF6nB7BnrV4cyAY2rqJtD6azxoIkrOFfmtwncRnOs5Td5MJr0m6Y1a5rYMRXeWV75fywYt9y/H0kdAakW3G/9OAOJsLDNyXJLt1Eqkc/LYdg+JW06sQ9Xd0IvMTxVDlGRo62J0HzrI6UgZ8hlf71Yj1wLgfXOywLu10IBg5XKT0hsWPk9L1PcrvvuKPBvGRoeLVVlj8+xbn7dwLsvrxiT8bY7p8Mm+pcfotnao1RAfIETGpA3PMA7SkIcxNygUSxWb/IKCJZDpGaPV3vruUPK4+lFasW4UrRsYHIGmY92PHr2gnhvQKWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYE7ct58X0Smp5OfRwpbUhsbcptrI0nm1gCaj/eVpw0=;
 b=UJbTpadqH+wLvsNDUFdlE4LQCrH9Ucg5Ql/UIL9+HNG4/yw66lc3VUGvQ/YU+hbxRuVomzyj8MoJywNKLS0m5LfRe6phVTUnm0l+C3vUv4FeXmS37g5j6O0ODCvtMFlcz135DwDyzeqyDEFtVhM6GUMATp1UxgkT+M6spK/h0/Xvp6iRD3ZN2qJIMAXSPhRoCQKCYXrcThM00eDB6vqgizAC/SiR/okH2LDhCH5NsyU6nrwQ7QbDSiNW4R1eVtOP9vZLKOP+IP42QTKgb9JIs5iMblXwKWifdHrAg0aGvx7Li0hraa8jM1FpHoUloMwjpTHC8cfPJG/aCObyb6ipfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYE7ct58X0Smp5OfRwpbUhsbcptrI0nm1gCaj/eVpw0=;
 b=ChnBxp4wfwPIil1M3r+zIkLFQ3YJvWfx09gWD+Q+8orCQ19AmM3jHkRec+iy2oXLjTPNsapxj02hJ1KT63WqdGv5OQERD2JP0PRVGHglPWaT2eYbWXPksnbfBMSj/UorE0/7aL0h4TPyvedcqzuneEdJ3vTixPsKfAkUazFnAGAbt5rdpg5Cj7fG+2Fn2NhiKeUaHZmhRPy0ThPFaeJ3cXGdd9s9OOGMbc6/dneUSUsNQh+55j7Uu7ppkzOLrV3tbQXbov89IqgfwOBqOMP1QFGQDrH++CqR0D7HUCz4doyetr3iV0Wz0CqGovu+WOj0OnqEmHa6VB6PQ+Hsq30f2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by SA5PPF530AE3851.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 29 Jul
 2025 14:20:38 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 14:20:37 +0000
From: Zi Yan <ziy@nvidia.com>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au
Subject: Re: [PATCH linux-next v3] mm, page_pool: introduce a new page type
 for page pool in page type
Date: Tue, 29 Jul 2025 10:20:22 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <951BA2D7-E220-4F41-BE16-C4C10318A627@nvidia.com>
In-Reply-To: <20250729110210.48313-1-byungchul@sk.com>
References: <20250729110210.48313-1-byungchul@sk.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::19) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: 313bb7fa-8144-4260-7dfc-08ddceab16db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AkX296tD2Y5wdAtjbafbXTPKOeVZsSFmcMgiWoflwwL1r5zlpF03Y6NPLmbA?=
 =?us-ascii?Q?fD2CB7PSe431EmYN1LuqOwfJvgzNvYgNj370CX+8//XDREKol7Mh4AbYvQRT?=
 =?us-ascii?Q?Wu65pL4f2nJmcZ2dz6TEanhXIx+/BYQTsTtEVDKie8hm4pf+GjvVn42C5EqC?=
 =?us-ascii?Q?VpfwBXVsGh2JDreNf8xHpqx4/MZ/m7g4HwEsC5PVJ+luFxcnGte5ZXCLA7yw?=
 =?us-ascii?Q?e/1t0yLFLzVQKStcXRi7vp5f7SqxuNid1FCdOBN9G7HlgD24A8TQiZe6MfdC?=
 =?us-ascii?Q?yY3M8WbkNtifi8gBHEWH5JP1YwMIy+gebhWc61qQvdJqzHnrh5eQcZDYVSWw?=
 =?us-ascii?Q?yLwVRIe0SPWaE/6pWNf9DBZCg6+UgV95D12vfEJYh650vU0udMf4MH45EBg/?=
 =?us-ascii?Q?RSty4FP9/50DWd6YE+rtkY8vvHhqVPm4UgEZbV3BSr93ufUQfaOcdEV8GlG7?=
 =?us-ascii?Q?fRRMDsz8MiPjIBryU8jgAhXz5UQAwHJ8c9xabA1bM7ELox7tG5ZmokMXx5KN?=
 =?us-ascii?Q?6BOr2iyGZeMVK1jSSiYguUfWagV7bOOiPQSJ0kEZC+ix7F2DG9V9t0QY9YrI?=
 =?us-ascii?Q?AFRddAY4GHT0D5cwTzF16j2Vtyi2z3e/z4oYLFWQbgsa2GQ44r+pzuMiAq/1?=
 =?us-ascii?Q?U7KHAc36wNdo+Iv61fAfnr86U3a0E6xt2MFvSTlC0TuQkehNF7UtcPbx7f5K?=
 =?us-ascii?Q?xvbpmHud8Mg8o5UtHEZF8QsGQIL5fRp2B4dOe66HZG53AxskqDq79NdLbsIT?=
 =?us-ascii?Q?P6xDjICH6Z6mn7mFk0h0biDOoR6hjmMigzaEjpfXU9rv2GhGpxkCM4R1jVp2?=
 =?us-ascii?Q?KzkP8B0pqkCMBGlHB16wIbnr+ACvs7K/bL5hv2UUxvsC1XU8BJetul4/XEe3?=
 =?us-ascii?Q?iAQF51d44k5QrJ4hHb0tATh6W4htgaIJhFDEtD3Z2dvMkxfGvp1uzquBMDww?=
 =?us-ascii?Q?1tJp8lEQ/zCWR6DBsQG5FcpxjeNZttAMM0E3ZB4fs9TAw1LKEpJhAXH7YnnY?=
 =?us-ascii?Q?K3lqQoISLxrAoOvI+mAasnBRP3azIUBOSotTRIvrgCVUBUqAeuE+bWt3SVjN?=
 =?us-ascii?Q?bQpRN2WJtkppdnbPS0hOodtRjMaVZNTlLQz1efZsqJKwKG5HbwOfbhtR/ZEN?=
 =?us-ascii?Q?+CTMJxn0pOES3jaXW4IzfXyPvPbfQ49sAt/wYvOglpBh1udzhwoJpRXS5IFn?=
 =?us-ascii?Q?wkQb3HEqMYQay/mm7OFzk+HWXoGZAratzQlP3sNs+RF691ILEwyTuZdWBl5v?=
 =?us-ascii?Q?zn27IHxzuIzDcE4jJtLAeLsTfOqXEMA3pBOvJEpIHGy9bGH3O1GGWS3rNjge?=
 =?us-ascii?Q?TrlnyRLZ5QTIX6qCRy1SQcs7XwnOqdrdTiwje/eW8egl7tFhykJR5CGwHP0y?=
 =?us-ascii?Q?k0AdvdS0TCZCz7p5UeP1xiv49ozmQfU6AuHYPpTZ46NYSLTToaC/tDb/Du0w?=
 =?us-ascii?Q?o7wOc9QNv+U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BrFkZz7efWdGhqyAdOwuZGXDcdDZKKejN6/OBLlLBaRFRvnBKs52DKVcgduC?=
 =?us-ascii?Q?8GIaOCu0+PbRAl2BaTP9UTkH2Wo7FWsk6d7OpyO+OGqjQiB0QdONKWQbS09R?=
 =?us-ascii?Q?WzzQlwsy2mz+UIcSa871cXM8tiLsVk65RGyEh4DUFUhweEA0o14gCDxEl8D6?=
 =?us-ascii?Q?B2Ud6HhQcQ0vuqaXteArTJHI9sIncTJdPCh5+P2Ygx/bQ41auPPyNrKghhJv?=
 =?us-ascii?Q?dqY3DJfjhKXHabHgM1rhbe4qvNsWzA4Ln4o52tgQ33jBGjiRFHBE+KHfbgWP?=
 =?us-ascii?Q?iW5+qt5vcfWofriDDKQfRfjZSqN/4gs2gNfJy8znXxeUSOEnOXboIntse+tQ?=
 =?us-ascii?Q?AYuIjGktiTy51idw8rByaWHCSv4XrJMYpPZCaagcI+853r6zsbwaw39Z/I4V?=
 =?us-ascii?Q?x+wTZxMJ8nPyxhxkp0QWvKDXREcyNYQZY6Qh1lqeguEuos97qzIQR4E6SKvW?=
 =?us-ascii?Q?HD343BOuVbGuRjlzscvXHj+KJRJrdhmrWxrlOIoNhj8lSngHmayH3MJUj/Oi?=
 =?us-ascii?Q?zjjXItY0t7YSU9shDHMKOy/NNUjFMVhw137PoyHebot4ahHaAPWmL/7z3x1X?=
 =?us-ascii?Q?ptgkrpDAYScdni02Z93ITuBA7yf4jZTkQID25Uo5xMsaW1Gji/kr8d+OSMss?=
 =?us-ascii?Q?dO7rKV8kOn1w0drlLtDbu8PsR3Zdv+qqhvsD9Ht+9QInQMOV/ACB5y37keAQ?=
 =?us-ascii?Q?hVSvO9Lt7oTT3TmYjAdM9jlMoLmrlaAputGyVN67orTV+KfHTO85gywizZMB?=
 =?us-ascii?Q?mnXlri8DX4nOozH0CppWle8yoKyzNXsdwVcL4VGGHCLkHY79C5bqK0Rgq2YB?=
 =?us-ascii?Q?Su0lFZ1LU+LcpeTNTi+BJQTqQNzBuUlwF1+TsaDbM3xiBwyBtavxVQsLIEid?=
 =?us-ascii?Q?yC9gcLkaq9DNSNYi95yKzEf34FxTirv3qixav00jMAfZV0BD1VhpbcosUkxy?=
 =?us-ascii?Q?b7R3UrIhXCHOcHoSi0FODrSky5OqebB9pdHleHixCp8Jt3lGP/W5EfEvVp40?=
 =?us-ascii?Q?rhicWazvZFOhSliUWciYULPiXncyeRWmfxT5NGrHvFhQ4jzofDatCQDxx83x?=
 =?us-ascii?Q?iXegzwlWgLd0OOpeIZzXpVqpzjHVAcVjesDX+olDVO0RTUMoBUE5V1uOlwFq?=
 =?us-ascii?Q?p+eD3AqN/8JVsY94iO820M0Ca7rN1UCakpstqK288cSKbRceD1Xkt38R59Gz?=
 =?us-ascii?Q?pl+9kUrzgOoQcLEAJnLEF5a0QJoNCOCzK3ComJIi0vMHN7D4EGk/ZSiblxKb?=
 =?us-ascii?Q?qrXwqA+vjf3js8EF9FQtCr/FGZ720H0xjzg8xRHQ6P1+LTKV7c2IjmQ7BQ4m?=
 =?us-ascii?Q?syp9DjGJ4Mb31mUzqXfB99tGiJ5l8nqw/NE68Oh63LdSb2B4t55So9XkXIt+?=
 =?us-ascii?Q?Wk6/4mCJq1juKKPOj8wUgQA3rNkJLX4y5y5TxAz2Pr7W0zHrJFCFNijQUpQ3?=
 =?us-ascii?Q?B9MLYceu2TOxp6Y1m6ghtfZAErj+kG4M+q2sKKIJOpLUfEGXJw8G5mvOkM+J?=
 =?us-ascii?Q?7fT0iUG6IVQg1cLPjxBO3+mozQLeF6GnscMZzLeFh19ks8asKBLHpdu83Mcq?=
 =?us-ascii?Q?o+55w/U12ZZKWp53m3s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313bb7fa-8144-4260-7dfc-08ddceab16db
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 14:20:37.6349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3Xg0U4L5jpzDOU9XQCP/FnYkytBziabkusMrcbnsqfWosQMM2Sl398dqVlcyCbb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851

On 29 Jul 2025, at 7:02, Byungchul Park wrote:

> Changes from v2:
> 	1. Rebase on linux-next as of Jul 29.
> 	2. Skip 'niov->pp =3D NULL' when it's allocated using __GFP_ZERO.
> 	3. Change trivial coding style. (feedbacked by Mina)
> 	4. Add Co-developed-by, Acked-by, and Reviewed-by properly.
> 	   Thanks to all.
>
> Changes from v1:
> 	1. Rebase on linux-next.
> 	2. Initialize net_iov->pp =3D NULL when allocating net_iov in
> 	   net_devmem_bind_dmabuf() and io_zcrx_create_area().
> 	3. Use ->pp for net_iov to identify if it's pp rather than
> 	   always consider net_iov as pp.
> 	4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
>
> ---8<---
> From 88bcb9907a0cef65a9c0adf35e144f9eb67e0542 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Tue, 29 Jul 2025 19:49:44 +0900
> Subject: [PATCH linux-next v3] mm, page_pool: introduce a new page type=
 for page pool in page type
>
> ->pp_magic field in struct page is current used to identify if a page
> belongs to a page pool.  However, ->pp_magic will be removed and page
> type bit in struct page e.i. PGTY_netpp can be used for that purpose.
>
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp()=
,
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
>
> For net_iov, use ->pp to identify if it's pp, with making sure that ->p=
p
> is NULL for non-pp net_iov.
>
> This work was inspired by the following link:
>
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gm=
ail.com/
>
> While at it, move the sanity check for page pool to on free.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
>  include/linux/mm.h                            | 27 +++----------------=

>  include/linux/page-flags.h                    |  6 +++++
>  include/net/netmem.h                          |  2 +-
>  io_uring/zcrx.c                               |  4 +++
>  mm/page_alloc.c                               |  7 +++--
>  net/core/devmem.c                             |  1 +
>  net/core/netmem_priv.h                        | 23 +++++++---------
>  net/core/page_pool.c                          | 10 +++++--
>  9 files changed, 37 insertions(+), 45 deletions(-)
>

<snip>

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0d4ee569aa6b..d01b296e7184 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4171,10 +4171,9 @@ int arch_lock_shadow_stack_status(struct task_st=
ruct *t, unsigned long status);
>   * DMA mapping IDs for page_pool
>   *
>   * When DMA-mapping a page, page_pool allocates an ID (from an xarray)=
 and
> - * stashes it in the upper bits of page->pp_magic. We always want to b=
e able to
> - * unambiguously identify page pool pages (using page_pool_page_is_pp(=
)). Non-PP
> - * pages can have arbitrary kernel pointers stored in the same field a=
s pp_magic
> - * (since it overlaps with page->lru.next), so we must ensure that we =
cannot
> + * stashes it in the upper bits of page->pp_magic. Non-PP pages can ha=
ve
> + * arbitrary kernel pointers stored in the same field as pp_magic (sin=
ce
> + * it overlaps with page->lru.next), so we must ensure that we cannot
>   * mistake a valid kernel pointer with any of the values we write into=
 this
>   * field.
>   *
> @@ -4205,26 +4204,6 @@ int arch_lock_shadow_stack_status(struct task_st=
ruct *t, unsigned long status);
>  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHI=
FT - 1, \
>  				  PP_DMA_INDEX_SHIFT)
>
> -/* Mask used for checking in page_pool_page_is_pp() below. page->pp_ma=
gic is
> - * OR'ed with PP_SIGNATURE after the allocation in order to preserve b=
it 0 for
> - * the head page of compound page and bit 1 for pfmemalloc page, as we=
ll as the
> - * bits used for the DMA index. page_is_pfmemalloc() is checked in
> - * __page_pool_put_page() to avoid recycling the pfmemalloc page.
> - */
> -#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> -
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(const struct page *page)
> -{
> -	return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(const struct page *page)
> -{
> -	return false;
> -}
> -#endif
> -
>  #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
>  #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
>  #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 8d3fa3a91ce4..84247e39e9e7 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -933,6 +933,7 @@ enum pagetype {
>  	PGTY_zsmalloc		=3D 0xf6,
>  	PGTY_unaccepted		=3D 0xf7,
>  	PGTY_large_kmalloc	=3D 0xf8,
> +	PGTY_netpp		=3D 0xf9,
>
>  	PGTY_mapcount_underflow =3D 0xff
>  };
> @@ -1077,6 +1078,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
>  FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
>
> +/*
> + * Marks page_pool allocated pages.
> + */
> +PAGE_TYPE_OPS(Netpp, netpp, netpp)
> +
>  /**
>   * PageHuge - Determine if the page belongs to hugetlbfs
>   * @page: The page to test.

<snip>

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d1d037f97c5f..2f6a55fab942 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1042,7 +1042,6 @@ static inline bool page_expected_state(struct pag=
e *page,
>  #ifdef CONFIG_MEMCG
>  			page->memcg_data |
>  #endif
> -			page_pool_page_is_pp(page) |
>  			(page->flags & check_flags)))
>  		return false;
>
> @@ -1069,8 +1068,6 @@ static const char *page_bad_reason(struct page *p=
age, unsigned long flags)
>  	if (unlikely(page->memcg_data))
>  		bad_reason =3D "page still charged to cgroup";
>  #endif
> -	if (unlikely(page_pool_page_is_pp(page)))
> -		bad_reason =3D "page_pool leak";
>  	return bad_reason;
>  }
>
> @@ -1379,9 +1376,11 @@ __always_inline bool free_pages_prepare(struct p=
age *page,
>  		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>  		folio->mapping =3D NULL;
>  	}
> -	if (unlikely(page_has_type(page)))
> +	if (unlikely(page_has_type(page))) {
> +		WARN_ON_ONCE(PageNetpp(page));
>  		/* Reset the page_type (which overlays _mapcount) */
>  		page->page_type =3D UINT_MAX;
> +	}
>
>  	if (is_check_pages_enabled()) {
>  		if (free_page_is_bad(page))

The mm part looks good to me.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

