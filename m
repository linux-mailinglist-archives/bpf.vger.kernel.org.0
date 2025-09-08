Return-Path: <bpf+bounces-67723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D273CB491ED
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DADA16B8D4
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4CB30B500;
	Mon,  8 Sep 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jZv3+J17"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B75259C9A;
	Mon,  8 Sep 2025 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342533; cv=fail; b=SVWhaKK6LhucaAqrR+PKXUb4X0avCr6b1h0LIs7xOfKtzAbvgN8Whyfv8OaMhBRBuk80pcYzbZpDuGQN8s2WWRwQYDN6n3kPuHGUEkI1CUMt+TNd0eLQsxcc7DnmulPyE6SPJxSFO7kaKbHQchFzSb4NRU1vY0/0rF8SHOECu90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342533; c=relaxed/simple;
	bh=4eLfiSiiDu2G7/vCpGjdq3s2TqWiIcFZ3CeYF1fmUls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E1tT7D0qQQ5s+fGCypqvVz84GjB9sEo/GVJh0aWOzHG56QppuXJxLHbw0X4IjcPr+/fRoXsV/ve9UCLCoy3xB1GWpPygTuRI5Kaw6Y4j/zzV51TX0S+NQG7aqUXtS/Qs1FlRN1OIsj/3GM65SGu9zBYgYOmbsjFuZYz5A3rW26U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jZv3+J17; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hd5zqgFkPKuYn5KI4YusuiGMKB07zSYyX9z+ASd+r0ObU9f+cd/6axuC1oqK5wETr6fGvhEpuG2j0sNvkhdm3HLbuEo1ksqdTe1pHR2J6moWuEj54ctydPFq/4bZ90loOp/JVWHfbPHPgA5QSNYgxxxeE4nE6kl2HyV8y7Vf0M30SZq8ru5t67L9gL1V0vcXDudnwt3O5wmD5t+8C8aZdnII7ZXxcyX198YHj7PT/gpRslUmpTOJyS5Z7M3FzYBKHYgkQM9iLbuKY7/AV2VL4IM9aAVXUq/RVJzEmXXz7UVWekR2OLJeD+eV8Sj3W24IeHhHcG0jZX9rHGECkhs2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzpozHgLCHflC5/QuuI1fivZF+Of8QMUkNsMsENk9ws=;
 b=e0wCsEkcCUJQFFLi0d3n4jknv2/ASdtTeSKgFGh9z+24+vW7Wq7HwyQ6dePxJr8CRUt44zabNXGRy3gsbxJQOaWiM6nOk2WSiHseAA9ljEvX9aq48Cs13qHmcTiMakUNsO8Wbva+H2V+pQ4ReErPSY/jTtJMhsnUZqEiwJlUT7CeWbRpFRgJsjqwFsuKvz5D1Affw4Hz5+HsvAerqPh6+n7AS301B2cghS6bpAfbrDPC5IC9uSUXBl8im7AyIermTVoMVraBiZM3Bu73sAi6Oke5kcKOEr3cShl+ekQxbm/9qCGnA67aaRRjvPMp/hdeIMKIvld2n9sIn83LZx4Sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzpozHgLCHflC5/QuuI1fivZF+Of8QMUkNsMsENk9ws=;
 b=jZv3+J17Tl+bU3IdXPQ4xllJTDM65UhP6LV7evTEOcRkrWFrwW/npunUDR0AQeqvi+61/ByshHWfS6/anYtleKPO1ob4k1FVoOFJr5HoannCyHwr90pcw++MCS/UMwM5MaJk340S6bUCk7RKktNfOPmyHayg1AoU49Ltb40oISX0lIU6PIPSYLMoQyGDIPBaWB9yUoUOzz2t+7g658SBiwIQGp3/HyEZRMuS8vePba7VJtnff7hbiay+auSVn72R2zTPybostd8hBdWnrOUxM5J6SvWppaE/ULk5fygTULN7oowx6S8pTkJbOzs4S5hT54YvaYG1vJoBEC+oHpG0Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 14:42:08 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 14:42:07 +0000
Date: Mon, 8 Sep 2025 14:41:40 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kuba@kernel.org, stfomichev@gmail.com, 
	martin.lau@kernel.org, mohsin.bashr@gmail.com, noren@nvidia.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 1/7] net/mlx5e: Fix generating skb from
 nonlinear xdp_buff
Message-ID: <4hgasq7ibnulieu77b4bryhouggobgousci7z2i3pefv7ofysh@j3qeucyw5wv5>
References: <20250905173352.3759457-1-ameryhung@gmail.com>
 <20250905173352.3759457-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905173352.3759457-2-ameryhung@gmail.com>
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: e94202e2-8795-48e7-f198-08ddeee5e2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ulmZRxKfigZroOF6d1KytON5XD8Se1I380cXkFBr6bjIgM67XGCerePO1iCf?=
 =?us-ascii?Q?3KqIiixFZrHFpnHyaOd7RYW5TQo8JQj++mHpD4s83kMmZhEIfH1d7g3RoE8A?=
 =?us-ascii?Q?wZOnJnmlM44VbZl7pgvR5KzIiNVMkBa4xn7NSIze9ez/7ZdszK1ozZEol9xu?=
 =?us-ascii?Q?I4h3/MljSmda40mrzAWQCBkG2CGa82mwZpjV34U52/UCwoOewWfKdIkFeM1p?=
 =?us-ascii?Q?HOAgrMF8Hx2nhDHk6hR273PaUly1oirtK37ynK+nFQyZROJ0V9KLV4puvHQ2?=
 =?us-ascii?Q?iZ/wmazH3T8Evo6SRKknZ10+D7VpOWZEy+WiIBp/UPs5WkNAUn5S2zTsv2GD?=
 =?us-ascii?Q?KHk7cTrpKSKhDDIG3qwxD5zC2qNwKaOUpBgmi7jkc4AjceCsYpB9YKkqstZH?=
 =?us-ascii?Q?3ptG3AaTcprGHMANOpnWtyeEWKjTF66r9pm32wI/tyXFVcB4Ne9llS8yDRQO?=
 =?us-ascii?Q?ZZ7OXrcKpxwBHTy3UM3z81qFvC2YlOWzWxOaWdUdqkU3YCwwucuK4pFCWw2b?=
 =?us-ascii?Q?WDhMJ8XngaloOK5bHzIXZ7+wmlQrAwfyF4yY6mGSalNJ8YFUNmhcvxMbA9so?=
 =?us-ascii?Q?UglLQWlP8fjk0/7gYiMTyt+ZJoq2amdUHPJ9yNwT7f6VUxRnv1cNZHd4VA8A?=
 =?us-ascii?Q?1ojJz/VvB5eoxgn378dcRpnZMGk+gr6YkbqMNFrFYFFiE7W7dK0FhpVnEEii?=
 =?us-ascii?Q?sELRHcEadIJ7u+rxaMW00h+uyyX28wYVLEGWgYmgx+hZH1BTG5AUh+C+XJEy?=
 =?us-ascii?Q?Nzc7T5oqccjWHKe8T9FS5y5fYZ6wCTimx0Jw9eMcf4S3Uj76jTljmdSOo8tf?=
 =?us-ascii?Q?LPDpLeZdlcmKbLDEnaWkCrfnUF3JKTnuzkd5AUE0mHNCCd3zGdrNoRZENguB?=
 =?us-ascii?Q?VIaQGJaZkUBIwQ8JKICGDAddnY+Fl/cuSzecVvGbT0meTRJwG3M64knb6SZO?=
 =?us-ascii?Q?DeuNp2nrib5vgAT3jfM9o8FysXRCHP0oSFqOZoefAySE9iuJRAJIYVMEwf62?=
 =?us-ascii?Q?U2b4905fVUdilDNb+pRc5lnf8HBUfC63xOuKArjiV/BIkgtMg5zlFjp8a5Dl?=
 =?us-ascii?Q?D2jsW6wIJjFYQsMCnnZFSjDy5z1vkjEyBhHC0gjPftgqmuLrdWEKxXhQ/mEc?=
 =?us-ascii?Q?f424Ou1t7e6rXLZwo0JcAEuw0xKPL/4n/uG/tWhCViT1PwLUB/Oi9pGjt5tj?=
 =?us-ascii?Q?YgU1rMiZnBjDm/xcrFjSYCyJEGvP9mc9rWf+Av3Iqp+xPRtF5F7DpDzaBcmy?=
 =?us-ascii?Q?YGVtMKYGUftd6LcHYuGewv4ddu83g3cAF2h3w+cPUT6uO/VRDWIqUlm0NxJi?=
 =?us-ascii?Q?iRUMDtsOl09WgW8sfA4c1ycRyNEhOl5Q/dgUXnBSgD8nhBR6YtPWjBbeI1tM?=
 =?us-ascii?Q?7gJixDJJyBpDJ4nm91I64WBca6sTxLsrLWPkPiGwDa/IG7K3/duqP1NzbIKw?=
 =?us-ascii?Q?Wpm1xIt1BSU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zmSo7oVMk+O7BJxMkRoskOeCfI9GUBSo0FlDg4PjEjVLtf99IyZGQASYfz3V?=
 =?us-ascii?Q?JI2lwl5RYr6oFc4+RyV4eiqmKSRL2Z166ek3oWZRqQEBLjh6Fa6LcUYvH9/h?=
 =?us-ascii?Q?brrTwQzNicbPQ+Y5oR2cLEWAL/VNBvESsWO+FlAetkpYdMJmZE9o2YX2VN74?=
 =?us-ascii?Q?RaIYrxW6pndX9Z7/d2u05kvDJk4q7+6m3UIZ50DNcpYRRKm+D1OTV7S7ot6Y?=
 =?us-ascii?Q?6bs1PvErd9EzOQ6iZnFBlsSdv3w6SR9woZfkwhGYQ/w1EHp11YPqM0OEVXoY?=
 =?us-ascii?Q?8XpA4S1YCmaFMUmbYo2fRm2vVmUOKCQ/O6Y1eXwKahUR+/mmODKmmXpV8Ap/?=
 =?us-ascii?Q?dr0FQqbDKuBiu4FU1U6rniPSmvBb2Gr/pFWPG5QTuTtKrIA4ilBzZOlcbv1T?=
 =?us-ascii?Q?2Ztog8uPeyC/eNlXsQ9vvd9H/MYg1ZkYsbW+XeSmqpz63qTSahdQIsP4wRlz?=
 =?us-ascii?Q?hyGmrALTMG0p0CoZVLbjl/DSwVDn9/sZRH7eNNHyn6k60kL6gk1g9I+wvKak?=
 =?us-ascii?Q?+VT3Pl1Rp2Fb+oPL9SqwAy9+M1SyQjfXsOzXsF7zn03e0sn7oOHpSkY5FyUa?=
 =?us-ascii?Q?XZqAo4g+C7HajBus9OrLt1232Jnam+LodIxcWPx3xVc9vBQaDbtlHgT40M1d?=
 =?us-ascii?Q?oHmIDb4Ys5twBaf9y1Fq3Dz7Ka8fM0XwkxT6QL1WH7MFkMMw8W8wi8UvHjLY?=
 =?us-ascii?Q?fCSBaDcmxRfZlawBA31RZHZniCaaSf+OBNY9DoFB+rTRaKtMivx0MT2BOy2P?=
 =?us-ascii?Q?PSQ1R5c5z72V7hYCB3HYYwOPtJAzYper/QdzBMLL8W0x7h4PAW6eL/lVVnJ9?=
 =?us-ascii?Q?3D8CSVkIVUZ0UwzfaNwjJZr+KMQxCdTJKvjnWGPkkKivIBrc+9/vLMAsU6cc?=
 =?us-ascii?Q?WhzRYvXvQqe+IURWVOtE2VIo3Pfg5lL3g2p8OpID+D6ehDUkBu6jUym8tBWp?=
 =?us-ascii?Q?6DofsZOoTmucHgREO7x13GT0kmH5GonEMVi3oSS9M8uRey3lSrdEaYAn0dGL?=
 =?us-ascii?Q?Mr3XKJTc4QY2WunHGvXBmmnjHYL5YMoUH/cAdQZA9nOFM3MDEfIsZU4mA6VQ?=
 =?us-ascii?Q?/vt1KwXbuGAF8kj4cJO6s15nUVxQqH40ZNp+kUE1/4MugHgyeM5ariWPVhgk?=
 =?us-ascii?Q?gfO3r5XO3ll/2NpYq4icRmU0V9kzMesC/zp9j/V5FdUTE6YWgzsV/xtTJw7t?=
 =?us-ascii?Q?rB2iZaWsyXJiD3b/Zh24ZKb786eaZr7HSS+liZxMpSc1fJ/fODhkFIurmUEp?=
 =?us-ascii?Q?1JJ67SIs7aR2aULvMZSV9EPOAcqJexYoK2aLnvby/Jz8C4bGtaMm+ALk7vfw?=
 =?us-ascii?Q?gC24fUg3/XCH2dgLQ+y6uKRYpvIxICBlMwNrhFEZm+AJ1wvzrWjRdWGqk4gZ?=
 =?us-ascii?Q?tapr91nAr+8H0xXNKwX9kTMOcB+igX1ilwH3ioayBtHk3egTa7jztSuHyxDG?=
 =?us-ascii?Q?pPjJzAuSP+qzl2sOmst86QR+u+XBjL0glZcWA5Ho7odeQuJFB1NOTtlGZRWB?=
 =?us-ascii?Q?sxWlqbgjgBFO7jbuvVSPaYkrYyc6MZud16JNX5Nl0qVL0F9UN4z7AbnpDjRr?=
 =?us-ascii?Q?iIhlMHM9tbz+wVUoIvnAlxwZi+8kQys7R4MQwQPp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94202e2-8795-48e7-f198-08ddeee5e2d3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:42:07.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYbY3Lvir+lOB9VI+d8vx6Et5nfxWR4ezQQx2Fewbp0PGI6q1qpHSherBWLlShB+z0rVYHMz2LiK08ZWP+BrfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835

On Fri, Sep 05, 2025 at 10:33:45AM -0700, Amery Hung wrote:
> xdp programs can change the layout of an xdp_buff through
> bpf_xdp_adjust_tail() and bpf_xdp_adjust_head(). Therefore, the driver
> cannot assume the size of the linear data area nor fragments. Fix the
> bug in mlx5 by generating skb according to xdp_buff after xdp programs
> run.
>
Shouldn't this patch be a fix for net then?

> Currently, when handling multi-buf xdp, the mlx5 driver assumes the
> layout of an xdp_buff to be unchanged. That is, the linear data area
> continues to be empty and fragments remains the same. This may cause
> the driver to generate erroneous skb or triggering a kernel
> warning. When an xdp program added linear data through
> bpf_xdp_adjust_head(), the linear data will be ignored as
> mlx5e_build_linear_skb() builds an skb without linear data and then
> pull data from fragments to fill the linear data area. When an xdp
> program has shrunk the non-linear data through bpf_xdp_adjust_tail(),
> the delta passed to __pskb_pull_tail() may exceed the actual nonlinear
> data size and trigger the BUG_ON in it.
> 
> To fix the issue, first record the original number of fragments. If the
> number of fragments changes after the xdp program runs, rewind the end
> fragment pointer by the difference and recalculate the truesize. Then,
> build the skb with linear data area matching the xdp_buff. Finally, only
> pull data in if there is non-linear data and fill the linear part up to
> 256 bytes.
> 
> Fixes: f52ac7028bec ("net/mlx5e: RX, Add XDP multi-buffer support in Striding RQ")
Your fix covers both Legacy RQ and Striding RQ. So the tag is only 1/2
correct. Normally we have separate patches for each mode.


> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 38 +++++++++++++++++--
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index b8c609d91d11..6b6bb90cf003 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1729,6 +1729,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
>  	struct mlx5e_wqe_frag_info *head_wi = wi;
>  	u16 rx_headroom = rq->buff.headroom;
>  	struct mlx5e_frag_page *frag_page;
> +	u8 nr_frags_free, old_nr_frags;
>  	struct skb_shared_info *sinfo;
>  	u32 frag_consumed_bytes;
>  	struct bpf_prog *prog;
> @@ -1772,17 +1773,27 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
>  		wi++;
>  	}
>  
> +	old_nr_frags = sinfo->nr_frags;
> +
>  	prog = rcu_dereference(rq->xdp_prog);
>  	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
>  		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
>  			struct mlx5e_wqe_frag_info *pwi;
>  
> +			wi -= old_nr_frags - sinfo->nr_frags;
> +
>  			for (pwi = head_wi; pwi < wi; pwi++)
>  				pwi->frag_page->frags++;
>  		}
>  		return NULL; /* page/packet was consumed by XDP */
>  	}
>  
> +	nr_frags_free = old_nr_frags - sinfo->nr_frags;
> +	if (unlikely(nr_frags_free)) {
Even with with a branch prediction hint, is it really worth it?


> +		wi -= nr_frags_free;
> +		truesize -= nr_frags_free * frag_info->frag_stride;
> +	}
> +
>  	skb = mlx5e_build_linear_skb(
>  		rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
>  		mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
> @@ -2004,6 +2015,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  	u32 byte_cnt       = cqe_bcnt;
>  	struct skb_shared_info *sinfo;
>  	unsigned int truesize = 0;
> +	u32 pg_consumed_bytes;
>  	struct bpf_prog *prog;
>  	struct sk_buff *skb;
>  	u32 linear_frame_sz;
> @@ -2057,7 +2069,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  
>  	while (byte_cnt) {
>  		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
> -		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
> +		pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
>  
>  		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
>  			truesize += pg_consumed_bytes;
> @@ -2073,10 +2085,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  	}
>  
>  	if (prog) {
> +		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
> +		u32 len;
> +
>  		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
>  			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
>  				struct mlx5e_frag_page *pfp;
>  
> +				frag_page -= old_nr_frags - sinfo->nr_frags;
> +
>  				for (pfp = head_page; pfp < frag_page; pfp++)
>  					pfp->frags++;
>  
> @@ -2087,9 +2104,22 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  			return NULL; /* page/packet was consumed by XDP */
>  		}
>  
> +		len = mxbuf->xdp.data_end - mxbuf->xdp.data;
> +
> +		nr_frags_free = old_nr_frags - sinfo->nr_frags;
> +		if (unlikely(nr_frags_free)) {
Same question about the if.

> +			frag_page -= nr_frags_free;
> +
> +			/* the last frag is always freed first */
> +			truesize -= ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz));
> +			while (--nr_frags_free)
> +				truesize -= nr_frags_free *
> +					    ALIGN(PAGE_SIZE, BIT(rq->mpwqe.log_stride_sz));
> +		}
> +
This doesn't seem correct. It seems to remove too much from truesize
when nr_frags_free > 2. I think it should be:

truesize -= ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz)) -
	    (nr_frags_free - 1) * ALIGN(PAGE_SIZE, BIT(rq->mpwqe.log_stride_sz));

And PAGE_SIZE is aligned to stride size so you can shorted it to:

truesize -= ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz)) -
	    (nr_frags_free - 1) * PAGE_SIZE;

Thanks,
Dragos


