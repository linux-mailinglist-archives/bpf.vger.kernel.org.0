Return-Path: <bpf+bounces-42883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022979AC6B5
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 11:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26BD1F21FF6
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 09:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA615CD52;
	Wed, 23 Oct 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9rejubA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B4A14F9ED
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676088; cv=none; b=JpOQ9TCA7L/2arUiWaa8mQ6VbaQicRncbiro6BTUQREW0FJgsxk9mBIPWI2YiivCxX7dDvgSYe1v3mfDHys3ECBkGDOEryp8ZiFzFLlqqvz6U9So8xX/hv5pGtSwkfEHkIQVCVO49YUHsufh8V8QpA58MZlI32z7t1r7VRlS9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676088; c=relaxed/simple;
	bh=wZmCBMkyNo1DmNK4Pf7hno/tHLIntPL+VHusl7jgEbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtE5vXDJxu3cZ10jHSweXAtfylHsmGBTTxW5iQVVMoL48ZMVWiU/fF7dYfnhNmtuNTXUvYxGPMlNKPjMfMDBtaPHmOPsuvHOpYkeK3AeJen7x4HIvD7ZNrfIzAi+RqNie6pZx3cD1ZXVGN7uuftkCJfr7jlD2pGa+FTEpNu84Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9rejubA; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso5512356d6.1
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729676086; x=1730280886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcwybXDJ272AhxQHu8hmzW/1eiHA4GL91+m8N5PynKU=;
        b=U9rejubAJrTCqhx+XWFaVpkEcWBAQoXcb88n/fXyrFnCNOI2P2Gqy3U40e+Lgszgi6
         Bqazm09/8o5DEF2sn2FaGGQwY/nZsFoqB6Q8sWz7g+CwII1uOWPwXykj6W49lccpR/pp
         gRK4u+AsURgH4V12XuMQNcfUdN2oEjpj1ZfXmF4qUbfpXOVonQ9meux0RP0hvs6/LVGr
         UTkt4NufLB2fVD+mJol3mVMeg9C5ZzcMWEdRfSOqhfyaLMXG2/2mTEUYHB8+FtWM5h9g
         1LpYXojV7+fxsEPKAKIlvzCjIcDC1vFz0eIAgCN886HvnMyR8jhwtdKQwHOjNaxX9SrI
         tzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676086; x=1730280886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcwybXDJ272AhxQHu8hmzW/1eiHA4GL91+m8N5PynKU=;
        b=gf1P7alvMEbFBy3m52R4GjLaAM5M7Tz9BUM60WrnW/niuyurtJz2cZEwQ24LJ0ALak
         GfUcnruxj7RENARNS31otA5QjWf92rt8zG6iAb3DWOyaaVpzWSqDvTXzeAJ35xWWDOX7
         I+gtREC7jZv77ziaRDbq7buqp/GqP3LYsbn7Dp9Vr14pQFr2E7+DzImBRmmhCwjGIUKq
         YhfJwX6yzW+KHrMM5BhHdugRtQ1Hsv0FEZF407Gs/lrXl4O1U+7MMcF9sbcFTiThNSi4
         2YivJRcTVqfX4chb0S0bF1L0kX5el4E0AP3ubftkH3K4cnW3jHtviGflJ4H7Zqm6k+jt
         VZXA==
X-Gm-Message-State: AOJu0YxJfmO3AuubMmWMn4BVAo323DgmP7DlZ4PXZcRmk0xUfyhxhcgx
	0zDOeACRwujafId42DW7/Mayn7XvtzRXAfcJTRcmuK7LrELYzmDeVKvlQ9N+lXECm1bjqrKxKeM
	/6LUh95i/tfcYkThlP2ckn+875Eg=
X-Google-Smtp-Source: AGHT+IE1h7px1b/2M3NSf0qmu2LcA6Elbm8DAywhuYKIr9aPe5R/BSYC2W9SIAPqEPZlDBqmscMTm2c10du3gMkfdTQ=
X-Received: by 2002:ad4:576e:0:b0:6cb:9a1c:cfae with SMTP id
 6a1803df08f44-6ce219ad479mr115924246d6.6.1729676085896; Wed, 23 Oct 2024
 02:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-6-houtao@huaweicloud.com> <CALOAHbDq4R=Exe6cUEindutk8NuLKBdiMayR3=HGL4zwYDrWQQ@mail.gmail.com>
 <2368d81f-9356-b472-8a51-4fb2f88b4235@huaweicloud.com> <CALOAHbCD8QbowivtZu=CFN1Jajk1FOdNx6JVuGgnbYGzWzfwew@mail.gmail.com>
In-Reply-To: <CALOAHbCD8QbowivtZu=CFN1Jajk1FOdNx6JVuGgnbYGzWzfwew@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 23 Oct 2024 17:34:08 +0800
Message-ID: <CALOAHbCGUe0TdzwRFreNHrvY48kQOD5tbXho957amYX09tGjwg@mail.gmail.com>
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

On Wed, Oct 23, 2024 at 5:25=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Oct 23, 2024 at 4:29=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> >
> >
> > On 10/23/2024 11:17 AM, Yafang Shao wrote:
> > > On Mon, Oct 21, 2024 at 9:28=E2=80=AFAM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> > >> From: Hou Tao <houtao1@huawei.com>
> > >>
> > >> Check the validity of nr_words in bpf_iter_bits_new(). Without this
> > >> check, when multiplication overflow occurs for nr_bits (e.g., when
> > >> nr_words =3D 0x0400-0001, nr_bits becomes 64), stack corruption may =
occur
> > >> due to bpf_probe_read_kernel_common(..., nr_bytes =3D 0x2000-0008).
> > >>
> > >> Fix it by limiting the max value of nr_words to 512.
> > >>
> > >> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> > >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> > >> ---
> > >>  kernel/bpf/helpers.c | 4 ++++
> > >>  1 file changed, 4 insertions(+)
> > >>
> > >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > >> index 62349e206a29..c147f75e1b48 100644
> > >> --- a/kernel/bpf/helpers.c
> > >> +++ b/kernel/bpf/helpers.c
> > >> @@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
> > >>         __u64 __opaque[2];
> > >>  } __aligned(8);
> > >>
> > >> +#define BITS_ITER_NR_WORDS_MAX 512
> > >> +
> > >>  struct bpf_iter_bits_kern {
> > >>         union {
> > >>                 unsigned long *bits;
> > >> @@ -2892,6 +2894,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, co=
nst u64 *unsafe_ptr__ign, u32 nr_w
> > >>
> > >>         if (!unsafe_ptr__ign || !nr_words)
> > >>                 return -EINVAL;
> > >> +       if (nr_words > BITS_ITER_NR_WORDS_MAX)
> > >> +               return -E2BIG;
> > > It is documented that nr_words cannot exceed 512, not due to overflow
> > > concerns, but because of memory allocation limits. It might be better
> > > to use 512 directly instead of BITS_ITER_NR_WORDS_MAX. Alternatively,
> > > if we decide to keep using the macro, the documentation should be
> > > updated accordingly.
> >
> > Thanks for the explanation. Actually according to the limitation of bpf
> > memory allocator, the limitation should be (4096 - 8) / 8 =3D 511 due t=
o
> > the overhead of llist_head in the returned pointer.
>
> If that's the case, we should make the following code change, right ?
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 1a1b4458114c..64e73579c7d6 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -65,7 +65,7 @@ static u8 size_index[24] __ro_after_init =3D {
>
>  static int bpf_mem_cache_idx(size_t size)
>  {
> -       if (!size || size > 4096)
> +       if (!size || size > (4096 - 8))
>                 return -1;
>
>         if (size <=3D 192)
>
>
>
> --
> Regards
> Yafang

Please disregard my previous comment=E2=80=94I missed the !ma->percpu case.
You're right, the value cannot exceed 511.

--=20
Regards
Yafang

