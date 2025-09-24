Return-Path: <bpf+bounces-69510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAEAB98652
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 08:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D193AD10A
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 06:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46834244661;
	Wed, 24 Sep 2025 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tvha1lEy"
X-Original-To: bpf@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC551F92E;
	Wed, 24 Sep 2025 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695580; cv=fail; b=mFI7+Vpq51YfUOjdeBtRqFc/B1cmTT94SOWr/2ixcuO/N6vbr9Id277ivE3RoUxv/rn26DFj4TAX3p0oscWdzgEWZXZH0NAG1vqJqnUI2HdjnQZknZw67layQzXp7YU9CicizHf9xLLIlcnnYAYsOjgzrzxmLLzhJ0v6rzxzRh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695580; c=relaxed/simple;
	bh=ph/KW8h0EaiN/oj/GFNm12eKncqwuUrk3jW85kMMB0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ImX30WaAbW18y1c3bYhSJaZBjsoU2lbYvY7CnL1KEinzSduqRwaEV30goBgf27ZM7Rstf9PCOFfVqcxHkE63BaR8YyblEEiMHg352qdLk6qjHJf9T+huGN6fr+q9QneNS7c7MV6mULXUFX98jL+OrEi62jB10A0BPxwnFwVXAxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tvha1lEy; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7MOeDlBRHX3hx4m2blUmql8Cx38vYnsYeAXGx96OVYFc8k4IqWosf3KgwlSartaMWvEWBj5BL7KmwyjnqS10N8/1nNeYX6ZBwinwW39Ps8ju1N2Bj1bV9a3D1LxDcVTL6b1KCnPrlP1ydH/LgaISrC/1a1yO8fpJB60Pj5d5oeauJgX8Qi8KCctZfgUpmPN3btvA+8t9LJcCxDyVka2Zq5wjFSSzjjOHpshHGmfK9CpUsTUarM4qoaUYOf1CvK2480DZ55b5k3zwrsNEMez49RSqb1kjhidhVn67dRu0jgKtf/AyLIWKqQzxbuDQnMUihP1S5FS3h+DKTj0E5WPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsmOMky2WQUvD8LzyXpIF87YautpPI7EzOYhwYRDBmI=;
 b=GQsjpfNxYWMhMZYYZb9O5YsV0tCfHXBJk9FSYJeIvvyMgiYN5Q1LfThCkoGeClQFE3l26SE1vHbRNMivsda1DnX/yc/C30E4Du3FG0FMrjB/jxlOIP31CSahv/Sizu6Ttmtc80QpQeSubMoyLBgq3Izp3S2wkqyDsR+5Birsl43jcDjjxlSeb++Q4AMeqM3qGrmGXbM6cWwuriawy8W1fr43MwX38gRkeDXxbM9UG+KuTdueZA3NLzHEs5zuM6hSP2ZWItiC5IlBx2EMABx29FawwsKEYjbTs7+ghqGYtM8piyIeY1dD6cZC74DnIqQprxtUuenFX/+MI96BA5vlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsmOMky2WQUvD8LzyXpIF87YautpPI7EzOYhwYRDBmI=;
 b=Tvha1lEy8CYhpEHM00tfR6i+hWYJiuCtW1jcKl86P55wMH7LD6MfxghLsURtp2jvyZ7I1HKJVnGq99QT6fGpyxcVoJ4MZ2NUxdCmQj0Rqv8v6oszSUJZeZDbvebjLiL4VOk8lvhuNYORJiapgpGRnwsPCuMtoEpO0dixOZ+ZshqlgP4ngV0npu7O9wFQq6j1JAwxtVwHgKgYtHNeVa6wHNNUMoxMq62gtGWWRDApFPdByXm7wuVqX5of/SM89/YnahZXK6qPSUf77wR3k4G2eplwRI1HZxi426L+ujgnBSzLSh4SuDDFF9w+QJ+QzEuQ5pZBmfyedEIRNdgaGx9feg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 06:32:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 06:32:56 +0000
Date: Wed, 24 Sep 2025 08:32:49 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
Message-ID: <aNOQkZjLNwQOlioo@gpd4>
References: <20250822140553.46273-1-arighi@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822140553.46273-1-arighi@nvidia.com>
X-ClientProxiedBy: PR0P264CA0250.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::22)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: b36dbef5-c950-45bc-332a-08ddfb3432bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CTfB3bV/TS1WQBl53i/tJjcE6q6kqEFtnGMHSnVqHc05YVx8MdUVNfw9cMu3?=
 =?us-ascii?Q?jPfW5GnKlX5QmizTlKK4lg4Zt8yXVENGGrYchbAbF1hnykWzRDxLSiQexPnG?=
 =?us-ascii?Q?tgYx1L9qa0vrx3VxUoche7JrXartudGGyYtPnc0tErhNhcxMF1N5Y5c63203?=
 =?us-ascii?Q?Lj+N3112iTC43lEv1gASdebCx88ms2R9jjRp4OsCnmtLcoQaLcMVLpve1iSg?=
 =?us-ascii?Q?PY6Dq7TAGjoKaHzSlnpb66EdMLZsH4rMGySsEJyT/BhhRxUysjQsAWJx6rZv?=
 =?us-ascii?Q?l9xv2UaWGw9FtMzIVg01OS4KA0a7jQoqqfIjEycmcMkomSMeUjxpEsyL5DaW?=
 =?us-ascii?Q?liiyEQr8RhLA9W6SRKvk0nvpqf2nqB0zYEfzUnOVon/3ZuIxx6P82DYVexX0?=
 =?us-ascii?Q?GJvMim/bZiIWepZLbxMuybUksCUKwNHaPYTpgGSPoPUpSmNyE9TcVePBVVf4?=
 =?us-ascii?Q?ZtHmNo7FcBWBjPEO/XZzWBMcGQMo6e4C2xzfyJWmsKEVyNY70JMAftqnpa0g?=
 =?us-ascii?Q?D251HUgnKBNU+pdCkHiavvRB2UEMmZopsx01dA7ZB3vZrjk+09ZY7TSNBHHo?=
 =?us-ascii?Q?yXPVp6KgPrgs8jQOUfNRALtZ3sNOLDsyrPyLkKeu933nljU/SpUlQrS8MzqX?=
 =?us-ascii?Q?+HkNndvXgBRCc6zVP1VO+t8WE1kG9BIVIrpNSbRpVVtTlnV7a0Tk6LrzuP8t?=
 =?us-ascii?Q?2sjHLfsa7cZPEtX2i3dyqGeo0ryxy8ylVN8oQyqKWQB0BC3YZWcdwRvKANmn?=
 =?us-ascii?Q?JUtNpq/sTiu//oW45lnBOKT4KKPVnPg6n5UksKWZBeO2pScwcVMtFdkEZ5EK?=
 =?us-ascii?Q?G6DqwAbZF6dTtjLDqMz88S6gDPkWgsTOP1165/L2cKT9E0uGM783uTbsUylk?=
 =?us-ascii?Q?Pfh6yaTMtlbSA5QCTPd/mYLWyboTbAR1d2KnWDkFkVnE65dvOnGXL+8GDsjx?=
 =?us-ascii?Q?II9clW1iCnYPrBztzbmeZHMZZbkoZvPjGQ0ab3aqHOiIctStqRr8lOjVWtK7?=
 =?us-ascii?Q?CmlhKtQKrn4Ac9oR+aDBdSEqVcSiaFCk0OFVmxEh0iiaaGjtJ13YuyJ6ouTo?=
 =?us-ascii?Q?FRInUsnm4nIYIknRqlyvgkI2B+j0Ql1TtGHcK3Rg8H+tGWYJoNeTTstHD0R2?=
 =?us-ascii?Q?TyN8BMxTC+QSY2wR38pHNYdv8K6os+dtV3omDg46VG84zWrdlNjT0q1Zjti3?=
 =?us-ascii?Q?DqfUL3Hivxq2zAOmSgBkp2+OkR7xeOF3GgRuDQlMoxnnFRqBXMPYYhyf2c08?=
 =?us-ascii?Q?EQUUcgHXfhC2vqYovyRQBTECWd5H6l/RhjtiPIdyw1U1m+eBjapppgFaeKpk?=
 =?us-ascii?Q?oyFlYQO0pZpQvKujAZbHbXp4n65iNOO2kAZgNtLnlNur+i2bXMQ7jWFMe6Au?=
 =?us-ascii?Q?urOnrdjLJR653ocNroURpjT5yb5Vy26okvjG5QseqWVXenubXfKkAx9Xqc1r?=
 =?us-ascii?Q?WBrxpgfns14=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LhcVo3yMM4q8O9rBhQ2d4l9UrUZDuj8D1JpnkLpNakfV9p63eP2vyeZYqsRR?=
 =?us-ascii?Q?WU3Z/CMfmJ5wlx7bTA2jm5EmkJQygs8t23cIZnvuqsxfSB0C3WZd612wTjkW?=
 =?us-ascii?Q?lbE0tcgDko/P9RqNawFgycq5NlFGvy7fBeosfwn/KuO4BX4YWj1HxbW00hTV?=
 =?us-ascii?Q?CtY/JVZENixXPQv/PF/yzKZ7T0b1FL3uv1NGcW1G4ghZxMxXZH8+o4BsyBzJ?=
 =?us-ascii?Q?g9gNM/LYHVWqKHdM2gwQtVaxsqB3eNJ7mAL3Lm8Da/gEHA/APDlB9y0QQgy8?=
 =?us-ascii?Q?HYNp51DTX14mODOdQ/GferDOQvXHDT5FNz06mxtgvFOJ/Br8WuNvoCGUBaNX?=
 =?us-ascii?Q?XbeXoYMJVe/znyW0zi16UXEqx2E4PbL2L9Sl+5MjANHdXqgtMV04Gh38J9IC?=
 =?us-ascii?Q?n/NsptnZf+Q7exnDANc6GIiIVcKGQRCQqAsWyyjMyJAqMAe7aGYEAy/itL6x?=
 =?us-ascii?Q?WaN7+gk7YE95XVMMifXHLnRLVt386AtP3Ub7PJBGy7uBke/MxOoTT+UKHjYc?=
 =?us-ascii?Q?sNcSKHn5cg2fI37p2+JHD+WIfY2P8RXPkFPNiQzAfiZ1DKgjzii+38B7olRw?=
 =?us-ascii?Q?Ed+96d5JQeoD1+fNAPIjQj2QYGUsgZ3JkUK/hkSpatL6YnJQCj/zlOwKGBaf?=
 =?us-ascii?Q?qRoWqQUSRDeKj1gMFrHCsVJ+kgx1wl/R+h3nd99dAI2HOO4jb9mSSviJeG6d?=
 =?us-ascii?Q?qNe4ygFX0irGIl7dRTtPAGbVpV4v8mZXRe5+rhW6p1V8fLG94kN1DVprF+/1?=
 =?us-ascii?Q?0qMegD5/9btcMCri1vBIk7m2xvjBls7VzIoQFGBjX6IP/ZvWQEVVrcMO69V0?=
 =?us-ascii?Q?FRrWClzI2gefN2gzX97lURyrsgXLeqLhBKckD7R3RIO5ATRjEuFd+F1vxD78?=
 =?us-ascii?Q?OZK2Ur6tN6Vc1MhhZw7thwkIb1OT7HtEDxgKIHOQ/QdTarcouCCQGOzfTioR?=
 =?us-ascii?Q?FtLt1Dg5r5Wagls9iNFXqQCxzBQNgYB0JrnhpAsnk6Iswlb7BYB1IbmVEGfU?=
 =?us-ascii?Q?aNj/dr46ffwnlfXrFuNMw0jzDAtzXFP4SYo8rrXN2QlAyPHyO9EksjAdFGps?=
 =?us-ascii?Q?Myg4HtuTMmKgQJc6vbdzAqXONXWNVjCA0+DVLwlKxbLr3eMVcDi0PaaEOQmT?=
 =?us-ascii?Q?erWQRIKKyAvkoZFGh0nV/2ggKRGNCDMe8a413Fbl0JQpJ0hO/QZBEpUl41Yl?=
 =?us-ascii?Q?e1ITU2zfBiq0stp1fubn4QTTYLSaYPbCVBrpFwwAcufs8DnCAkvfB+G19vsf?=
 =?us-ascii?Q?HmfwtHTICQkCd/ZANGfflcS7blJJYbZPQyr7p0hmbe32FBwNQjTywb9vMT3w?=
 =?us-ascii?Q?3pT8wVsqDdZN01Dr8qaeHS+5U1ZymKToR1mrCsnkeQg0j6R3Oof1tmD/seCI?=
 =?us-ascii?Q?CCf6dpRBGkY+JUWRerbV5s8I+aJZBgpeh/5LHzXH+lfogTL/JCe04KOPcliw?=
 =?us-ascii?Q?2LfTDFm5e5w/8YFcAboKxnKtGD31oxws3H9QSN42XhTBmdabCwNTfrLI9tR5?=
 =?us-ascii?Q?Z8L0GMUcrcpD/k8Y71u269UDDFIONHsUQGC2RVI6/N2um/0uEWoCcre1aSNk?=
 =?us-ascii?Q?0PsIOfdDoCKaRIA3ixRlS53rV0mdUyTRQUjt5Alz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36dbef5-c950-45bc-332a-08ddfb3432bb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 06:32:56.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWMWlUUCMvYvdT8lWcoyigeWTWxnGXGbPNtbFZDnuFCLMdrgAqhtrRPziBLUWhGFhJ6mj/QyXQ2hOwHVriCSmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001

On Fri, Aug 22, 2025 at 04:05:53PM +0200, Andrea Righi wrote:
> Some distributions (e.g., CachyOS) support building the kernel with -O3,
> but doing so may break kfuncs, resulting in their symbols not being
> properly exported.
> 
> In fact, with gcc -O3, some kfuncs may be optimized away despite being
> annotated as noinline. This happens because gcc can still clone the
> function during IPA optimizations, e.g., by duplicating or inlining it
> into callers, and then dropping the standalone symbol. This breaks BTF
> ID resolution since resolve_btfids relies on the presence of a global
> symbol for each kfunc.
> 
> Currently, this is not an issue for upstream, because we don't allow
> building the kernel with -O3, but it may be safer to address it anyway,
> to prevent potential issues in the future if compilers become more
> aggressive with optimizations.
> 
> Therefore, add __noclone to __bpf_kfunc to ensure kfuncs are never
> cloned and remain distinct, globally visible symbols, regardless of
> the optimization level.
> 
> Fixes: 57e7c169cd6af ("bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Gentle ping.

Anyone has any concerns with this? Do you think we can apply it (so we
don't have to keep carrying it out of tree)? :)

Thanks,
-Andrea

> ---
>  include/linux/btf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 9eda6b113f9b4..f06976ffb63f9 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -86,7 +86,7 @@
>   * as to avoid issues such as the compiler inlining or eliding either a static
>   * kfunc, or a global kfunc in an LTO build.
>   */
> -#define __bpf_kfunc __used __retain noinline
> +#define __bpf_kfunc __used __retain __noclone noinline
>  
>  #define __bpf_kfunc_start_defs()					       \
>  	__diag_push();							       \
> -- 
> 2.50.1
> 

