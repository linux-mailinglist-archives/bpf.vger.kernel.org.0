Return-Path: <bpf+bounces-58997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B204AC525D
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 17:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF4C173E27
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 15:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0AD27C877;
	Tue, 27 May 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iysRj7Mx"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34727A92C;
	Tue, 27 May 2025 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361208; cv=fail; b=uJOQwA8br9GPs1lY204runSlHhh0HgxvG5E4o0+ga5sUSJ+eB34QoqBZSaocym6TP3ynuv6lUYsnOoe3GQJBD7a92Nwwx3MwO6XSj0QrJTwbFznmFvosg6+SZ8z12CZDYxcD2ECNNUWJxoJGO4o+q2xO0FMz05ZQL251IOo6drM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361208; c=relaxed/simple;
	bh=/TV9BBFyfRZPojpOR2Txl3G1+KduyovqO20YbWmypUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nQh5OFWFFb/KvkmKOI16A8rIhmYrUisP6yQNw9GyRtTDdT2oalqH96WwrbqqjwhyQw1AejvE0A6DUDKnYMrvdm0iQaLRJW8EnNOafuCQKZhNSGiqAJTibqzc047whklRS+hDosP7UMeKAYDdU+kYLFoZuwMQb8IZ2VcMCKXq/GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iysRj7Mx; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXC0g6biwkuzbexisNj4FRoJN35apFz5FqJPQ73EdvFJ6oicBhulnEEAjF9nFMqzzpVk0q5YMsLaTYXZJumsyQAcGfFgUMYN1bW8G/FTVvun93yeZuuEFGlX8u8MQpJ41i4VSGFotjWX7dI6Xor+1VcwaKv3/+tIGKvefDywIgFx5yw9OSDMTIOOmlAJaQjLXrCmht9l1qfzN48dtok/RTv09OTJZGRuZrjib8KTI0ICnhYEpOC5jp+Do/ZFbw7gww7jyYDALedEZEcs0KVrnjKnSnihokI3uuo1fXuLwQVazP1JN2IbauSGvOssZvPGENF1H+I8zn1tUhh4blne6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KPNIPealMPs8LgVZ18Ysgbm8CGEB4EgA2tn5OE2xQw=;
 b=jhkfwn5sUPn7Ef/DuCTo7jcXwdkv5uPm6WyOsEJc6UnMnoMcWVoFh12sQcjDMA8UFmHjNVvYRYCNiac1ynW4Ly19c53sC+BxEOIk5i2UPiwY019st0db93CuEfqZPmDT5c7JSMkGLGZGAlFS/3M//h346ZnFPaPXotGti47cLEtM4yCg5L+lTElYgXliiT0T+Xy8HfgyiSyhBDCODP5Y/zyVqX4A96wf2TgXHBbWwLxiBGgtBZtwCfS8Mh0q58WXG2njV6xvBXWErkyHDbgMNKuTBz3kxRis5Y3o3uFEZvP/4i5WRFkDA6P8TOo6EvaRUOnFeFEsexkDoZDv2Zilcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KPNIPealMPs8LgVZ18Ysgbm8CGEB4EgA2tn5OE2xQw=;
 b=iysRj7MxLxuC/Asb4cFSYQfl/zzHs0vbIsUFFQWxwS5BERifuwakjL+5OyZ8L73cD4AUFMMK+11KOhdIibYYg7r38IhZZbs5SDsUlityWi60QE1vrRbdzcys2BA9LVzukudRVcSc3ZEH91Z5wfn/SnleFYlg28TIKKO42/lqYN1sU694WpeTpHrPhJxDtbKMeesx5x/rswFXLeXqw9lwquKgzGNfKxia+eltlq5cQ5zIPnvz3uk2TV987jb9ivHwpznnbeu9iFEtJYyCYJhXwInTqEjfRUqJ9LfxO8mGnLN1N1BhgezHCIt8kmkr04s7CMOuSX67D8YGvwzsbHYBwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 15:53:23 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 15:53:23 +0000
Date: Tue, 27 May 2025 15:53:18 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V2 06/11] net/mlx5e: SHAMPO: Separate pool for
 headers
Message-ID: <as33bglnquchl7phggfc6pllohkwfcqe7hetfiazt2rtzm3ema@6mx5sipb6afg>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-7-git-send-email-tariqt@nvidia.com>
 <20250522153013.62ac43be@kernel.org>
 <aC-ugDzGHB_WqKew@x130>
 <20250527082956.12e57fe5@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527082956.12e57fe5@kernel.org>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a5e01a-03bd-45af-9f2f-08dd9d369c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N+O5uxdK/Jba7639Ls+hb3nMokpMR8bKgTuwolwfv0sPtcWL1P5R/2DqhVQn?=
 =?us-ascii?Q?/ioUVVL8smYOL3WlkoO75C08784SoQmcMTkpopzCcj86iuQe45J5aqrcwo+Z?=
 =?us-ascii?Q?tq6EeqL4YQTrNQ0/gjGwlERl2FGhNqiySzx0xhPKI+AD8WTJxQa/AH7hFD1V?=
 =?us-ascii?Q?Wch0R9EzQAA5G43dntAU/SSiJPKmqWO9x0lVCQ9As5gh7TJErmtaTonvTDLn?=
 =?us-ascii?Q?tzfE4DGKfBt0vCQb3J7pggIV/0W0DbE81Fh3eSwh18T1FjHreXXiqlqRqi91?=
 =?us-ascii?Q?DdBUuO2Mp4/LM3eWL3Nst/yYBe/cGYhjPq7BhZoHv+P11OQir8CqyWfxfrDH?=
 =?us-ascii?Q?jdSWm605999HcO0IqOwLXUWDoTYr2r0j4/wNMPE+OgqTY+WRfPVzefkU3tCW?=
 =?us-ascii?Q?TqvcumH2PdMFp31oldYjLRT0ZO5kpYjPMGl6fULZ6MYJqOdlzc7LA3l3WwG/?=
 =?us-ascii?Q?yrd/Rt+M0MvC/rHMw5NbynAnqt0sqzMra76rnC2GFBULLXYhjjqmh6IqLQTo?=
 =?us-ascii?Q?tHG0ZLYcAs+FlWO9tuyy6DlFZP5H1CuubgiZ8UJEa85BJRwVbv9QprnJkjDP?=
 =?us-ascii?Q?XEhZyuVu9Ha+ptYIvpGoDxbcQokIYiw2oRoTumMiRxgFaE4N/or1tMC8Xwx7?=
 =?us-ascii?Q?fOKq4xURgPmQ7GzNfBHfS34OYVROu0Eu0ZhpjBbBnjtmuqv+2cBegJWlcj5L?=
 =?us-ascii?Q?Vl9RyEhSo+jJmmYRAGf35X+E83/hp5lBtbSw2VBPED1ivJupR9ST2p1wom+I?=
 =?us-ascii?Q?tcB6HBPb+qLy8yrlDm5EOZiYtqLH25WF7tZw9P+opmtWrNxAgA/K4EBLzTU1?=
 =?us-ascii?Q?nUBCDtFmx78+d4OTelFgtcswGcoquqvbEArLlDWM9a6Kia9/or2xZaQlY+Iy?=
 =?us-ascii?Q?HFmq8nkEeeV8bZ0wDD/ZoeOx0eN6nA83lMR/DeBwcmsxmPUecyi5FDi48ecy?=
 =?us-ascii?Q?Ly1eWPVP+lg22gO2WFKYwUMCNy41/tbtfKSe7QZnFS5jsOfQE7d6mhUKW6/b?=
 =?us-ascii?Q?C4m38EwvCtrWth/QVDXRC08oBbP6DPu26XnZtLvvGyMZvMOXsmKt2SaW161E?=
 =?us-ascii?Q?Tpb2nqn7aq+GgKUiaoFlhd7FbywVh8VunAqVXEBVDXyx1RgrsoiEqXR66P4N?=
 =?us-ascii?Q?W/1/hvOZDZjB8furXwdLtJ7+M4KqYoeN6iAC+lwGjAuRRGED3pwLTsLkF1kI?=
 =?us-ascii?Q?hshRg5cBFYyRZ8APd325bgw6PZqrTbNJdrXUGUTHL/A7DIo/Vr+14U8UC46u?=
 =?us-ascii?Q?djGly+FuKZ+tlTRUsYr3aLE65a2EINa+V2zWSAfbJ7cpMZHrm1ggs5KPfXBU?=
 =?us-ascii?Q?S0SN6KbElfA7W+TnkBJco0JfzTxgHowyaSsGXc5JJf4Y7wWz1UWZHyA3GsS0?=
 =?us-ascii?Q?jKsRQyp4xq9ltYkDwXslM1/B1qo+g/EjP/V1LyWPzA5G29VqUh8siSwR8uxV?=
 =?us-ascii?Q?jgUaESzdVCk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pjN40L5ab95D8uI4vT53EuQp44IIxN34fRO2sFGLWLvqDyXIVl572f+LNEOg?=
 =?us-ascii?Q?5N/1CYrhgwzAU4xHJ7iYUlhy1JCRcbUSoYeHfbdtJyr9jD0zIR+ZoDVYHJoY?=
 =?us-ascii?Q?YRRACcV4T3YGY5Z2lDKFsNCmvzunJlRivnATq3p5D6EBZrsJizvwCKbRaRBp?=
 =?us-ascii?Q?Mf8pRXeSJC44XhZcfCRmpylUp0PAucGFH2lSBFpL+GS1TlH8ZcfnhKtHBX1g?=
 =?us-ascii?Q?CMAVtb7gCriC5nNoEMTZ75E3tWISNCYoIAf3/C140AQqeepDayFn5q4gObDt?=
 =?us-ascii?Q?pvYTLlk6/mg5+cR9DpAdqonW0DIR4CYdTL7p4Vf/vTKTmkn0t/r0rBa1WYYk?=
 =?us-ascii?Q?SYa9uqQiR/DS6YZmfLldjUVITQMsHn52R1aElxZmM33gziSGA31J+sHchi+T?=
 =?us-ascii?Q?LX1K5PbuqXz9+LuWXjQvyXO4tpQsEXXJW7qlTxwAXl8JZTZiZDcZNjkOXYpv?=
 =?us-ascii?Q?uZaVxP6zZ0wISPEGgyfNGS2HbH7BhDfIoSiesN7DPIEhGcYSfv7+VRL6BShG?=
 =?us-ascii?Q?HwsrvPS9Gl0AU/hBLa7Y5jzm+EIl64UALumnpG3SIwftkLrjMrPG1o5iFOAW?=
 =?us-ascii?Q?SMIL7+c4xOUff8l7vICk0DbyesBn8KKYYhdii58Vv5QYsuDbMkBx0bDxFkMQ?=
 =?us-ascii?Q?zQSnjXH6BgSzmA2hQi87Gc8YAtKUYMVCgP2yn1lf7p0I9J9oQvcqS3WJ3jHe?=
 =?us-ascii?Q?8iT+fc1ZC0Ce6Ld0/XVKkO1u8+UyFEYRAA28FTjzD/3I5NKn+RJ1QJIJZ0N3?=
 =?us-ascii?Q?PpMkbmkGm/Dc0tbj6h6terCLYzKYv4cYFCdGXE4E7NCS3fp3R0pnyunlyK3x?=
 =?us-ascii?Q?abDO576xfwmuQwndBoNR+vu9tI/DFInhIcKrsXsWy3nTeUC2abZTuovGYeNZ?=
 =?us-ascii?Q?zxy2hW4k4HSAPhrKvsG+GGvPn7VUB8pUG8v9UTDA0zNqkXxa9HP2kAF2/AyT?=
 =?us-ascii?Q?dzbL7lhJmiyl8HJFKFm5tt2GzXJL+ky0rIKfdP5uFGxfExZzHau1yiHOsKEL?=
 =?us-ascii?Q?Vry2xG708QUF+guctklKlCS4ChBw/VcONV9oNlNuGWU7jdme0OpisH+gBtnx?=
 =?us-ascii?Q?aKd4g3nVZrgFMMnvJdDBDQxJWvd4DVV1wI2pZWaIX2x7c0/a16w5qJNySAss?=
 =?us-ascii?Q?PcAYTtpo//eBeND2zXwL+c1enmFFn07aUfNstofxK3KM3mbWWS8Fk1GMGr4Z?=
 =?us-ascii?Q?TsVbicm7MkFMdE8eZiBCRow3gvjryoOXkZE3cDO1tzAzMso8pU0KRs9qEdnl?=
 =?us-ascii?Q?8Ncf25dludE7/oU1uhCr/ZEUXDBrUMGmwZ7ciGvbe9q7Rgk9A8FbSyM97/Dk?=
 =?us-ascii?Q?h3P25GJQFoNVuuHxI7eE5nP/hYjMHubiGCLamXJPy/+Wr6wYbrOLD+G200Yk?=
 =?us-ascii?Q?zKjiYIybFC01dYJ8LKgTPPlC5Qav0+ULK92GhF9n/sFpwqxiGley4+KTnhDL?=
 =?us-ascii?Q?ECilDrWWkcALJsmDLky71G9hosRFXaerKYAFzJyJ9cN4RtwggxalzYAfAl/Y?=
 =?us-ascii?Q?Ivx/AEblNoK0uJafoyixJ3YJvRWrcUN0zlXPoFHupcE601QpDwPF5nUbGq7J?=
 =?us-ascii?Q?dhO4YtSUF1p5ibruA0kxg8H1BZZPLttFjcfZBjQq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a5e01a-03bd-45af-9f2f-08dd9d369c26
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 15:53:23.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UHa/+PlqiLeWyZk3jYlNFi0PrQLlX4rH1FrIQWjMi3muNn2ZuG9y943SA1yUZRdrOR9xoHkjEj7fYEZJ7oFew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619

On Tue, May 27, 2025 at 08:29:56AM -0700, Jakub Kicinski wrote:
> On Thu, 22 May 2025 16:08:48 -0700 Saeed Mahameed wrote:
> > On 22 May 15:30, Jakub Kicinski wrote:
> > >On Fri, 23 May 2025 00:41:21 +0300 Tariq Toukan wrote:  
> > >> Allocate a separate page pool for headers when SHAMPO is enabled.
> > >> This will be useful for adding support to zc page pool, which has to be
> > >> different from the headers page pool.  
> > >
> > >Could you explain why always allocate a separate pool?  
> > 
> > Better flow management, 0 conditional code on data path to alloc/return
> > header buffers, since in mlx5 we already have separate paths to handle
> > header, we don't have/need bnxt_separate_head_pool() and
> > rxr->need_head_pool spread across the code.. 
> > 
> > Since we alloc and return pages in bulks, it makes more sense to manage
> > headers and data in separate pools if we are going to do it anyway for 
> > "undreadable_pools", and when there's no performance impact.
> 
> I think you need to look closer at the bnxt implementation.
> There is no conditional on the buffer alloc path. If the head and
> payload pools are identical we simply assign the same pointer to 
> (using mlx5 naming) page_pool and hd_page_pool.
> 
> Your arguments are not very convincing, TBH.
> The memory sitting in the recycling rings is very much not free.

I can add 2 more small argumens for always using 2 page pools:

- For large ring size + high MTU the page_pool size will go above the
  internal limit of the page_pool in HW GRO mode.

- Debugability (already mentioned by Saeed in the counters pach): if
  something goes wrong (page leaks for example) we can easily pinpoint
  to where the issue is.

Thanks,
Dragos

