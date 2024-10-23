Return-Path: <bpf+bounces-42864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C36979ABC10
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 05:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A271F245A6
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 03:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08961FE9;
	Wed, 23 Oct 2024 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhXtc1te"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B18139E
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729653487; cv=none; b=tpCA53AD0RVrSYyijNFHTF1Z51f15RScyJ5agp/le6MpMmAVTmhetpjUq4Hk9oYKk2M8nQsNH2YRhNtd7khzZiV4dVunia53IMhtG06YhIomsYymyTMx2GXy5cBFb/kUc/Yg9SgfCPixzP8hzvNxurayQFdYXUoGPYJUoPvp4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729653487; c=relaxed/simple;
	bh=WSoEBa4E6F1PPGR84QmPQJk8SiKsSRe5wv5QUqcquGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlzBcZRMP/C4x8ESW7W8tMfzJsE7XH5WDAJcUj5pAjL7g9pHNdgXGvdS+o/NpAxiINoi3BYKR0b1LesXJM1E30LBSXE+kjgLX3ur/jW9ZFy01h6aSAtCNSn0Bt3WsrACtakijJFuQnvCBSkyWpaphsFOTprEFF4wLElCvKz3XKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhXtc1te; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbe9914487so39879986d6.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 20:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729653485; x=1730258285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZ4cNG0zN+5zn7IfrAYStLJZX9X1+StIRnP7Kud5xSI=;
        b=HhXtc1teBrQH209DpXDBXUm9Cu16U5jwRi2CJD/1xtMk7goYx1ifqhl8bkT3o/iqMd
         G8DDgd/DQh/DdXYWcjV3zBnTX3wvPTO/rG3mknsQu9j7Ml9Jp53mYc3Tb5HVeUhi2K4f
         zStJ419/+krkVMtoL8J3zOlSH/7AVKtGlIB+u5wt9rc9VjG7xEExmbijmyTrOAXu2Yxh
         vkj4uO9g1BVDl5kC3gS2omtevr0NzfVKLf94OaLn+g86AMFEdkNAOSdGVKhL4BO/csbi
         Gd/sJevTNBZx3DEDWtz53HctlcLq3sTrP+juPjIZ54NPeWlFmBXqtabla8Kff5kyetcZ
         TGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729653485; x=1730258285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZ4cNG0zN+5zn7IfrAYStLJZX9X1+StIRnP7Kud5xSI=;
        b=xDK0srmEkdfje9N42lQDOppbiIrYKGEqLlgyvWVqMsyF7ef2vrUKyDCy4AyDtzFInP
         1e+EffzDvcJSkrhWDVPHb1S6eSgkPyDQs5048QyI+IPR6rL5+31m1EIj2YAVv/2f/riR
         ehpGEZ8+YqeWxnz5W9JtclZWLb7hApXC9S2JW3aQdJ6bwC7JCIW5Jy1HR5rMDKR5ZUJR
         cNcZTvzAnIylX7ZYBEcQDqQEXHaaNGx7OLoCdX9PfA16kOGY6mKDMTfsMBoOMgUNd/8V
         f6VEx+1hdcNln3xeDUC6eBJDGCf5rQ8egxgxw5Xi60xLdFi4S/lAx6gVMHyZGkkZ81Ql
         wzvg==
X-Gm-Message-State: AOJu0Yy39SsnPYFwPuQ0qXh8XvWsBGPBVN1gdcIkhC5tusRpSGrwvRGR
	a3+gPOgJRfmJApPAwOYqkfoaY9AqdF9UM60+tNXgI3AsVobrd/a8emEAaXXSqp6xxiHvpBgTZ2m
	byynA8G602pxlLwFNCLDR0E1JYqM=
X-Google-Smtp-Source: AGHT+IEJ5kdz1TzIXQTQMCwa4XYEkPkCorJk9eZNylyFGqqj3wqu2O6RPpo6Y+XvgJx0mjYK+3YxXqo23Oed3A4eISw=
X-Received: by 2002:a05:6214:3a01:b0:6cd:ac54:7995 with SMTP id
 6a1803df08f44-6ce3426c4c4mr14909306d6.36.1729653484843; Tue, 22 Oct 2024
 20:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021014004.1647816-1-houtao@huaweicloud.com> <20241021014004.1647816-6-houtao@huaweicloud.com>
In-Reply-To: <20241021014004.1647816-6-houtao@huaweicloud.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 23 Oct 2024 11:17:28 +0800
Message-ID: <CALOAHbDq4R=Exe6cUEindutk8NuLKBdiMayR3=HGL4zwYDrWQQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 5/7] bpf: Check the validity of nr_words in bpf_iter_bits_new()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:28=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Check the validity of nr_words in bpf_iter_bits_new(). Without this
> check, when multiplication overflow occurs for nr_bits (e.g., when
> nr_words =3D 0x0400-0001, nr_bits becomes 64), stack corruption may occur
> due to bpf_probe_read_kernel_common(..., nr_bytes =3D 0x2000-0008).
>
> Fix it by limiting the max value of nr_words to 512.
>
> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/helpers.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 62349e206a29..c147f75e1b48 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
>         __u64 __opaque[2];
>  } __aligned(8);
>
> +#define BITS_ITER_NR_WORDS_MAX 512
> +
>  struct bpf_iter_bits_kern {
>         union {
>                 unsigned long *bits;
> @@ -2892,6 +2894,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u=
64 *unsafe_ptr__ign, u32 nr_w
>
>         if (!unsafe_ptr__ign || !nr_words)
>                 return -EINVAL;
> +       if (nr_words > BITS_ITER_NR_WORDS_MAX)
> +               return -E2BIG;

It is documented that nr_words cannot exceed 512, not due to overflow
concerns, but because of memory allocation limits. It might be better
to use 512 directly instead of BITS_ITER_NR_WORDS_MAX. Alternatively,
if we decide to keep using the macro, the documentation should be
updated accordingly.

>
>         /* Optimization for u64 mask */
>         if (nr_bits =3D=3D 64) {
> --
> 2.29.2
>


--
Regards
Yafang

