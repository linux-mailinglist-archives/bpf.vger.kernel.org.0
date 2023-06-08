Return-Path: <bpf+bounces-2128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812F57284F1
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 18:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCD228174C
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E24917728;
	Thu,  8 Jun 2023 16:28:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47E3B407
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 16:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C10C433A0;
	Thu,  8 Jun 2023 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686241719;
	bh=5zH08XUfq+18tqlmHVWvpEAsjeO5Ce/XxzLXbX4gVVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JfmL+BlSm6q41L0gLNUh+FbjT1O6SVwiKrCWfDK5VghY/IietAuCdGmVkGDKyc+CG
	 ecpOIKaMpvJnuiNhsBKzEBEjbvzJH/VuMpaXgoBGyX18dddWlw4/yGwEqlzbD13nkj
	 OQhYkpRm0nqGO1ab4Nr4rt0H9LDMwNyE42ZLM5C+WqcJ2VpJLrbluEOuNyA0aOE4RN
	 oV8afTD79QjLpzYe3AOyUvNlg+Ulxy+NQ7aIeHswbV7m12UMQ+OvQcQBR5CIW8fNVj
	 nSACJAYPj2pX+aCIoXHKCVUYkWHUt83FwCjYoZzVWGFZGerON2bm3iV9MozSok0Vko
	 kz5Fe4Zs+uEpA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b1b084620dso7989071fa.0;
        Thu, 08 Jun 2023 09:28:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDwCGZnHOtYXQ6x5tdGksK+Km5Ohz9CHLDox72UK6XLyYuehcP74
	2tzFK+/GfD5yq4fIU2AEiqbGl/wGYgucFK9lA3M=
X-Google-Smtp-Source: ACHHUZ4YX0Ne++b7K0Iz0nPYwgBxAk5ute7QPeyjEc/PvBcXTPrezWlpefSE0BZKqQyRuzaIQ6x+FLzllBH98pluu/c=
X-Received: by 2002:a2e:9cd1:0:b0:2b1:e943:8abe with SMTP id
 g17-20020a2e9cd1000000b002b1e9438abemr3393233ljj.47.1686241717897; Thu, 08
 Jun 2023 09:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607091814.46080-1-puranjay12@gmail.com> <20230607091814.46080-4-puranjay12@gmail.com>
In-Reply-To: <20230607091814.46080-4-puranjay12@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 8 Jun 2023 09:28:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7soOQasGw5fHB2qTeJnqR4ZrGBodyO87k=vg=TYqCsWA@mail.gmail.com>
Message-ID: <CAPhsuW7soOQasGw5fHB2qTeJnqR4ZrGBodyO87k=vg=TYqCsWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, catalin.marinas@arm.com, mark.rutland@arm.com, 
	bpf@vger.kernel.org, kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 7, 2023 at 2:18=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
[...]
> +
>  static inline int epilogue_offset(const struct jit_ctx *ctx)
>  {
>         int to =3D ctx->epilogue_offset;
> @@ -701,7 +716,8 @@ static int add_exception_handler(const struct bpf_ins=
n *insn,
>                                  struct jit_ctx *ctx,
>                                  int dst_reg)
>  {
> -       off_t offset;
> +       off_t ins_offset;
> +       off_t fixup_offset;

Please add some comments for these two offsets.

>         unsigned long pc;
>         struct exception_table_entry *ex;
>
> @@ -717,12 +733,11 @@ static int add_exception_handler(const struct bpf_i=
nsn *insn,
>                 return -EINVAL;
>
>         ex =3D &ctx->prog->aux->extable[ctx->exentry_idx];
> -       pc =3D (unsigned long)&ctx->image[ctx->idx - 1];
> +       pc =3D (unsigned long)&ctx->ro_image[ctx->idx - 1];
>
> -       offset =3D pc - (long)&ex->insn;
> -       if (WARN_ON_ONCE(offset >=3D 0 || offset < INT_MIN))
> +       ins_offset =3D pc - (long)&ex->insn;
> +       if (WARN_ON_ONCE(ins_offset >=3D 0 || ins_offset < INT_MIN))
>                 return -ERANGE;
> -       ex->insn =3D offset;
>
>         /*
>          * Since the extable follows the program, the fixup offset is alw=
ays
> @@ -732,11 +747,20 @@ static int add_exception_handler(const struct bpf_i=
nsn *insn,
>          * modifying the upper bits because the table is already sorted, =
and
>          * isn't part of the main exception table.
>          */
> -       offset =3D (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
> -       if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, offset))
> +       fixup_offset =3D (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
> +       if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, fixup_offset))
>                 return -ERANGE;
>
> -       ex->fixup =3D FIELD_PREP(BPF_FIXUP_OFFSET_MASK, offset) |
> +       /*
> +        * The offsets above have been calculated using the RO buffer but=
 we
> +        * need to use the R/W buffer for writes.
> +        * switch ex to rw buffer for writing.
> +        */
> +       ex =3D (void *)ctx->image + ((void *)ex - (void *)ctx->ro_image);
> +
> +       ex->insn =3D ins_offset;
> +
> +       ex->fixup =3D FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
>                     FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>
>         ex->type =3D EX_TYPE_BPF;
[...]
>         /* And we're done. */
>         if (bpf_jit_enable > 1)
>                 bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
>
> -       bpf_flush_icache(header, ctx.image + ctx.idx);
> +       bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);
>
>         if (!prog->is_func || extra_pass) {
>                 if (extra_pass && ctx.idx !=3D jit_data->ctx.idx) {
>                         pr_err_once("multi-func JIT bug %d !=3D %d\n",
>                                     ctx.idx, jit_data->ctx.idx);
> -                       bpf_jit_binary_free(header);
>                         prog->bpf_func =3D NULL;
>                         prog->jited =3D 0;
>                         prog->jited_len =3D 0;
> +                       goto out_free_hdr;
> +               }
> +               if (WARN_ON(bpf_jit_binary_pack_finalize(prog, ro_header,
> +                                                        header))) {
> +                       ro_header =3D NULL;

I think we need
       prog =3D orig_prog;
here.

Thanks,
Song

