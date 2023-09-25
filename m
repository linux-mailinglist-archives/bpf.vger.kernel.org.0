Return-Path: <bpf+bounces-10804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C07AE19B
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 34FCB1C203DD
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287A2511F;
	Mon, 25 Sep 2023 22:16:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFB250FF
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 22:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A082C433CD
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 22:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695680170;
	bh=ryuTVFj4vTtI4nTc6goek41txhkB/GD5qn2kjIqj4sA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xz5SefdyXNhGS2GjuBWmtBNMTHMxkZ4HkpIfQdM0u8U1cNhbhnCQzIjh4iwxcJ19A
	 IAs1JFaizbW4WPRL293o5SQeLxeKgEIch3MRQ2DRAgBMWIqO1D/+1cTjLzwnjujJUA
	 4xkYc1M5Q6DHiX49AOfagU5dn0pITOJVAVGNBtM4zWQrphYGRoBtsBnz7WTnVW/SZ5
	 jvIi+7AA6EFa9nnYw/qmWtB4eilYDMK2lXYXjxLQigX/edTkYbBbGxH59uYL8eYFHt
	 tjj4mKIGHciVQdgU34IBuntaprg4ZobQFJrMNaJCOc+Je3oWzl/n7JZhCYwfDvNWsp
	 b5i2ThdIfd2Jg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c131ddfc95so114844931fa.0
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 15:16:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YyCkFpM19P3q8oVqz8vI5m+XXIReXwDsWAw6GozMGzqJMk/k5Au
	KpAi2yWXOj+c1m45X14GkL4H2qllwXtCTKGqGKs=
X-Google-Smtp-Source: AGHT+IG07bX1hewVqeuIkJ8YDJl9RA+/Pc1SNtg/LytjZgYLyqfLTfJx2FVcJMWOfrpGFUS5CKrBynJkttw9xIZ3uU4=
X-Received: by 2002:a19:c204:0:b0:503:72c:50cb with SMTP id
 l4-20020a19c204000000b00503072c50cbmr6687962lfc.6.1695680168271; Mon, 25 Sep
 2023 15:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230908132740.718103-1-hbathini@linux.ibm.com> <20230908132740.718103-4-hbathini@linux.ibm.com>
In-Reply-To: <20230908132740.718103-4-hbathini@linux.ibm.com>
From: Song Liu <song@kernel.org>
Date: Mon, 25 Sep 2023 15:15:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7wDqJZcDezqZOvNvWw5CeCOesgy3SnuxYRzxsB=ZbKXA@mail.gmail.com>
Message-ID: <CAPhsuW7wDqJZcDezqZOvNvWw5CeCOesgy3SnuxYRzxsB=ZbKXA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|free]
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 8, 2023 at 6:28=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.com=
> wrote:
>
> Use bpf_jit_binary_pack_alloc in powerpc jit. The jit engine first
> writes the program to the rw buffer. When the jit is done, the program
> is copied to the final location with bpf_jit_binary_pack_finalize.
> With multiple jit_subprogs, bpf_jit_free is called on some subprograms
> that haven't got bpf_jit_binary_pack_finalize() yet. Implement custom
> bpf_jit_free() like in commit 1d5f82d9dd47 ("bpf, x86: fix freeing of
> not-finalized bpf_prog_pack") to call bpf_jit_binary_pack_finalize(),
> if necessary. While here, correct the misnomer powerpc64_jit_data to
> powerpc_jit_data as it is meant for both ppc32 and ppc64.

I would personally prefer to put the rename to a separate patch.

>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  arch/powerpc/net/bpf_jit.h        |  12 ++--
>  arch/powerpc/net/bpf_jit_comp.c   | 110 ++++++++++++++++++++++--------
>  arch/powerpc/net/bpf_jit_comp32.c |  13 ++--
>  arch/powerpc/net/bpf_jit_comp64.c |  10 +--
>  4 files changed, 98 insertions(+), 47 deletions(-)

[...]

> @@ -220,17 +237,19 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *fp)
>
>  #ifdef CONFIG_PPC64_ELF_ABI_V1
>         /* Function descriptor nastiness: Address + TOC */
> -       ((u64 *)image)[0] =3D (u64)code_base;
> +       ((u64 *)image)[0] =3D (u64)fcode_base;
>         ((u64 *)image)[1] =3D local_paca->kernel_toc;
>  #endif
>
> -       fp->bpf_func =3D (void *)image;
> +       fp->bpf_func =3D (void *)fimage;
>         fp->jited =3D 1;
>         fp->jited_len =3D proglen + FUNCTION_DESCR_SIZE;
>
> -       bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + bpf_hdr->size);

I guess we don't need bpf_flush_icache() any more? So can we remove it
from arch/powerpc/net/bpf_jit.h?

Thanks,
Song

>         if (!fp->is_func || extra_pass) {
> -               bpf_jit_binary_lock_ro(bpf_hdr);
> +               if (bpf_jit_binary_pack_finalize(fp, fhdr, hdr)) {
> +                       fp =3D org_fp;
> +                       goto out_addrs;
> +               }
>                 bpf_prog_fill_jited_linfo(fp, addrs);
>  out_addrs:
>                 kfree(addrs);
> @@ -240,8 +259,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog =
*fp)
>                 jit_data->addrs =3D addrs;
>                 jit_data->ctx =3D cgctx;
>                 jit_data->proglen =3D proglen;
> -               jit_data->image =3D image;
> -               jit_data->header =3D bpf_hdr;
> +               jit_data->fimage =3D fimage;
> +               jit_data->fhdr =3D fhdr;
> +               jit_data->hdr =3D hdr;
>         }
>
>  out:
[...]

