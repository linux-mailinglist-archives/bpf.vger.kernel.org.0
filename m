Return-Path: <bpf+bounces-16931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2701807A3B
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 22:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D681282475
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 21:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5092B6F625;
	Wed,  6 Dec 2023 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlYB5Bh3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F56E5B8
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 21:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB12C433C9
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 21:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701897530;
	bh=TB6hLv+a++QLL9DFXZYntMR/Yd1DaUlsnFMkda6Hlrs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HlYB5Bh3DshgGbvDsDgzw/oEUowdvTei6ATFW/O1GpohB6avelFra1vYYsJU7oYIo
	 OsFDm5o6YV36bJMSRw8B8SzxxDAAqwTwJDxpPIBjd+HNlkr1C33rra1FOCgnz4SUfY
	 ij2ZvyZy+FfioBtY/p2oMl/jVx+ezX5JI4p7ugVt7mCA+siVhcyNYnE9SZrIfQuwFm
	 PvI+Fu4ApxcX8oNs9PeuyC2fQ4QP/u9bXXWIqvwoxbDcwf5gwFPBjVOvXeLdtRrB8G
	 UjNkyFmQicwS1t7lEgG6bDuiLsxbevmC92hg97ygV7ayhVLYP7/HtNIuIsdcyLZ8UY
	 urtHgkJSGBMBA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c9fbb846b7so2761971fa.2
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 13:18:50 -0800 (PST)
X-Gm-Message-State: AOJu0YxS0d3SzH94fCpEfzeoxLQjx/7Tqh8AKrHJS7WejE3HfSsIJErI
	UilTstSJQ1vkhW/g82eJZ89ubXtB6Jd0pE99J6Y=
X-Google-Smtp-Source: AGHT+IEntR+vupdupG7AAhyDJTKGtyROdCQqBwncVN6uDe/V9y64EezVh3luAVjtVVAfkkex+cBrZ6Q1anfHxeKKQoY=
X-Received: by 2002:a2e:9593:0:b0:2ca:129c:ecf1 with SMTP id
 w19-20020a2e9593000000b002ca129cecf1mr911199ljh.38.1701897528563; Wed, 06 Dec
 2023 13:18:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201190654.1233153-1-song@kernel.org> <20231201190654.1233153-6-song@kernel.org>
 <CAADnVQ+_XZMVegPSN_xmA6C9Tx9UTQ0J-q=N6pv6RzbkVwBCEg@mail.gmail.com>
In-Reply-To: <CAADnVQ+_XZMVegPSN_xmA6C9Tx9UTQ0J-q=N6pv6RzbkVwBCEg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 6 Dec 2023 13:18:36 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7LYiytwCq8rpM9xC98AO8YCJ2Siy4JKoQJx7=LwjDb3Q@mail.gmail.com>
Message-ID: <CAPhsuW7LYiytwCq8rpM9xC98AO8YCJ2Siy4JKoQJx7=LwjDb3Q@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 5/7] bpf: Add arch_bpf_trampoline_size()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@meta.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 11:34=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 01, 2023 at 11:06:52AM -0800, Song Liu wrote:
> > +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags=
,
> > +                          struct bpf_tramp_links *tlinks, void *func_a=
ddr)
> > +{
> > +     struct bpf_tramp_image im;
> > +     void *image;
> > +     int ret;
> > +
> > +     /* Allocate a temporary buffer for __arch_prepare_bpf_trampoline(=
).
> > +      * This will NOT cause fragmentation in direct map, as we do not
> > +      * call set_memory_*() on this buffer.
> > +      */
> > +     image =3D bpf_jit_alloc_exec(PAGE_SIZE);
> > +     if (!image)
> > +             return -ENOMEM;
> > +
> > +     ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SI=
ZE, m, flags,
> > +                                         tlinks, func_addr);
> > +     bpf_jit_free_exec(image);
> > +     return ret;
> > +}
>
> There is no need to allocate an executable page just to compute the size,=
 right?
> Instead of bpf_jit_alloc_exec() it should work with alloc_page() ?

We can use kvmalloc in patch 7. But we need bpf_jit_alloc_exec(). The reaso=
n is
__arch_prepare_bpf_trampoline() assumes "image" falls in certain memory ran=
ges.
If we use kvmalloc here, we may fail those checks, for example is_simm32() =
in
emit_patch().

In patch 7, we separate rw_image from image, so rw_image do not need to be =
in
the range.

Thanks,
Song


>
> Similar in patch 7:
> int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void
> *image, void *image_end,
>                                 const struct btf_func_model *m, u32 flags=
,
>                                 struct bpf_tramp_links *tlinks,
>                                 void *func_addr)
>  {
> -       return __arch_prepare_bpf_trampoline(im, image, image_end, m,
> flags, tlinks, func_addr);
> +       void *rw_image, *tmp;
> +       int ret;
> +       u32 size =3D image_end - image;
> +
> +       rw_image =3D bpf_jit_alloc_exec(size);
> +       if (!rw_image)
> +               return -ENOMEM;
> +
> +       ret =3D __arch_prepare_bpf_trampoline(im, rw_image, rw_image +
> size, image, m,
> +                                           flags, tlinks, func_addr);
> +       if (ret < 0)
> +               goto out;
> +
> +       tmp =3D bpf_arch_text_copy(image, rw_image, size);
> +       if (IS_ERR(tmp))
> +               ret =3D PTR_ERR(tmp);
> +out:
> +       bpf_jit_free_exec(rw_image);
> +       return ret;
>  }
>
> In the above only 'image' has to be ROX. rw_image can be allocated
> with kvmalloc().
> Just like it's done in the main loop of JIT via
> bpf_jit_binary_pack_alloc() -> kvmalloc() -> rw_header.
>
> pw-bot: cr

