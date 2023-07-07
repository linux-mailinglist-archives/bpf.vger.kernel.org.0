Return-Path: <bpf+bounces-4389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C2874A97B
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 05:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D73F28160B
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 03:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278E91C37;
	Fri,  7 Jul 2023 03:52:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59A1876
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 03:52:40 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C541FC9
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 20:52:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc587febfso14510675e9.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 20:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688701945; x=1691293945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7FEKjZbrpQeS4wm2f+5jvVSkxWn/bUJ/cNzpZ9OEg8=;
        b=K9HnMIJ4zlSDHHlErNZ+7c2BxywYSPSwkrxvm5lKQ0b8CHW3dX0MyiiPGk+xuvX3lS
         x+xvjF9kresV/5EQHX4bDzJYWutazUc7vzanl05ac4dD0i0fxvOHGUCexKNFYjvMPx59
         los3dc7RCrnPgNAgHrJo0ueTgjbP+v5jhnM2M7XtZ9N62guHUI1lQYBzahViNQQad7Lq
         8hlxGLP2qSL8RcmGkyZ9xaN+IzYqfMwm2DxdhWj6MGVPUvnVD4kv1teCFFF8yDiD9lop
         /sTDBz7EXP3jYOV+Dr9BnqYTlzhq3UoRnpnhcRexdk9r4Gs3JW9n0p9zyNm8p0oIdvYl
         uzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688701945; x=1691293945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7FEKjZbrpQeS4wm2f+5jvVSkxWn/bUJ/cNzpZ9OEg8=;
        b=Cx9/EOJwHMBXmCgNDsxiyijOgPrax68mLVv2B+KEpFQGcwpB4p6Sap+vPrLgy/99ev
         JLAix3NnvFu3MtyJua9BoqtAB6Ohd9mKZjg1E9cgxSCzoKz3jaFlqeeejTkvDc5MnJN1
         wqAx5r46QyyTydLI8owBYpuC84Fb8CVSeUjhMwd4S/FVfJwt99BUTIqNRO7xKARtZUsa
         lZOKAGc4728fdrdrGXtjzIym9grXPhDF1Eb894YmoJUc7BS7yMp02yk5Zdv7wo4KfJ9g
         qZyOtELw5au653lB0m9WKG/C+H181ImH7faTZlSTHMxIrsGhwd0v+dsJGr5JRTCnleNO
         thWQ==
X-Gm-Message-State: ABy/qLYgvdOqFuR6WexK+YHdVKI+/y2h03VZIBJsm5zUNb1LhLNDeUqM
	X0uXF/2eSgmz/JxUWpIPQYX/U5nU6uHKzKU1UcTjvDs7ujc=
X-Google-Smtp-Source: APBJJlEJL/OORsHyvAfMgiFcYAOs8fPBFasaBAbiv3vWYqb+BuIctZLYdQC668autMt682579Bp6kKcRwQzC7LLSkCs=
X-Received: by 2002:a05:600c:22c1:b0:3f7:f45d:5e44 with SMTP id
 1-20020a05600c22c100b003f7f45d5e44mr2638824wmg.32.1688701945470; Thu, 06 Jul
 2023 20:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-12-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-12-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 20:52:13 -0700
Message-ID: <CAEf4BzZsF5jyVxETLTJ507CMx75HQxEUndoqbAVqakBXkJs5eQ@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 11/26] libbpf: Add elf_resolve_pattern_offsets function
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 1:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding elf_resolve_pattern_offsets function that looks up
> offsets for symbols specified by pattern argument.
>
> The 'pattern' argument allows wildcards (*?' supported).
>
> Offsets are returned in allocated array together with its
> size and needs to be released by the caller.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/elf.c             | 57 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c          |  2 +-
>  tools/lib/bpf/libbpf_elf.h      |  3 ++
>  tools/lib/bpf/libbpf_internal.h |  1 +
>  4 files changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 7e2f3b2e1fb6..f2d1a8cc2f9d 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -376,3 +376,60 @@ int elf_resolve_syms_offsets(const char *binary_path=
, int cnt,
>         elf_close(&elf_fd);
>         return err;
>  }
> +

same, leave comment that caller should free offsets on success?

> +int elf_resolve_pattern_offsets(const char *binary_path, const char *pat=
tern,
> +                               unsigned long **poffsets, size_t *pcnt)
> +{
> +       int sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
> +       unsigned long *offsets =3D NULL;
> +       size_t cap =3D 0, cnt =3D 0;
> +       struct elf_fd elf_fd;
> +       int err =3D 0, i;
> +
> +       err =3D elf_open(binary_path, &elf_fd);
> +       if (err)
> +               return err;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(sh_types); i++) {
> +               struct elf_sym_iter iter;
> +               struct elf_sym *sym;
> +
> +               err =3D elf_sym_iter_new(&iter, elf_fd.elf, binary_path, =
sh_types[i], STT_FUNC);
> +               if (err) {
> +                       if (err =3D=3D -ENOENT)
> +                               continue;
> +                       goto out;
> +               }

ditto, minimize nesting, please

> +
> +               while ((sym =3D elf_sym_iter_next(&iter))) {
> +                       if (!glob_match(sym->name, pattern))
> +                               continue;
> +
> +                       err =3D libbpf_ensure_mem((void **) &offsets, &ca=
p, sizeof(*offsets),
> +                                               cnt + 1);
> +                       if (err)
> +                               goto out;
> +
> +                       offsets[cnt++] =3D elf_sym_offset(sym);
> +               }
> +
> +               /* If we found anything in the first symbol section,
> +                * do not search others to avoid duplicates.

DYNSYM is going to have only exposed symbols, so for this pattern
matching, maybe it's best to start with SYMTAB and only fallback to
DYNSYM if we didn't find anything in SYMTAB (more realistically it
would be that SYMTAB section is missing, so we fallback to DYNSYM;
otherwise neither DYNSYM nor SYMTAB will have matching symbols, most
probably, but that's minor)

other than that, LGTM

> +                */
> +               if (cnt)
> +                       break;
> +       }
> +
> +       if (cnt) {
> +               *poffsets =3D offsets;
> +               *pcnt =3D cnt;
> +       } else {
> +               err =3D -ENOENT;
> +       }
> +
> +out:
> +       if (err)
> +               free(offsets);
> +       elf_close(&elf_fd);
> +       return err;
> +}
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 093add8124d8..f33ef7cb1adc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10509,7 +10509,7 @@ struct bpf_link *bpf_program__attach_ksyscall(con=
st struct bpf_program *prog,
>  }
>
>  /* Adapted from perf/util/string.c */
> -static bool glob_match(const char *str, const char *pat)
> +bool glob_match(const char *str, const char *pat)
>  {
>         while (*str && *pat && *pat !=3D '*') {
>                 if (*pat =3D=3D '?') {      /* Matches any single charact=
er */
> diff --git a/tools/lib/bpf/libbpf_elf.h b/tools/lib/bpf/libbpf_elf.h
> index 026c7b378727..0c75d3b2398b 100644
> --- a/tools/lib/bpf/libbpf_elf.h
> +++ b/tools/lib/bpf/libbpf_elf.h
> @@ -18,4 +18,7 @@ long elf_find_func_offset_from_file(const char *binary_=
path, const char *name);
>
>  int elf_resolve_syms_offsets(const char *binary_path, int cnt,
>                              const char **syms, unsigned long **poffsets)=
;
> +
> +int elf_resolve_pattern_offsets(const char *binary_path, const char *pat=
tern,
> +                                unsigned long **poffsets, size_t *pcnt);
>  #endif /* *__LIBBPF_LIBBPF_ELF_H */
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index e4d05662a96c..7d75b92e531a 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -577,4 +577,5 @@ static inline bool is_pow_of_2(size_t x)
>  #define PROG_LOAD_ATTEMPTS 5
>  int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attem=
pts);
>
> +bool glob_match(const char *str, const char *pat);
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> --
> 2.41.0
>

