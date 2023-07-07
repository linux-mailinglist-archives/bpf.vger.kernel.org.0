Return-Path: <bpf+bounces-4388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855EF74A972
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 05:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F16281608
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 03:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942931C37;
	Fri,  7 Jul 2023 03:48:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA61876
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 03:48:29 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0E71FC9
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 20:48:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso2220855e87.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 20:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688701706; x=1691293706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRijrwql2x5unikpBsPn1ASMojUB0P1cP9zO4QAmkVA=;
        b=VkR4rOFkg2zGoajyNd2epnVS7563m6W+O8S3yGNn8E1YNvjRm25Y4UDdM1kydSOr7s
         7pxczyYANTucRMIVFKy+e9hzNJJh78wKOy5Lo2FXDecehwTZU4nGcwWzLYF1rIH8+Y6c
         dtjLxOCY+s7G1zfuSSDIHo03EJkSX3tXzYbcMvSivp7AdZEvQCdsKshOWwLEqRKZ5krI
         8phlhVn/tVm5v3J4XjHw9fZlF32PMPMqhm7XX2eqtkG+EWZlvbQ/kSIwYOdIDGgvbyow
         YSwnObii0EtMnMtKRyl7YbwSJi9pe8Zjhq0msu5hq9F734xU5RIWgR86agW2WdJoVKtq
         tCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688701706; x=1691293706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRijrwql2x5unikpBsPn1ASMojUB0P1cP9zO4QAmkVA=;
        b=Qby7kFBiRXWOnwgU6j1ARiS6xvRlXN8czsJNWtt0sqLwGRCBB/WhRlmS2X6etAGvfq
         CIr52ZfDZpgXRg5bz8nnp1X6cis7iUMSAsqKUsDvfK6+f5OGVsjOUPcgHal6GdNPTiX4
         27ktqBqgV+a4hccK/4MVaaQNjuaHO8oeyiiZT2el7eqmIwZLdGM/YAxVTobV+rmNJ3ED
         vvSX4hUaf8cRqTKTwI4XzLh0fB7r2nZdYJUA1vH9I9MUqWuZ3MU7SEVkzzghrmzWEgiF
         +rI+JeKHhKDNJvgV3CrwdAadzuEACMVxK3y+hd0haUFbf1O5bDjhIqll0K1nsHqmrxHa
         23FA==
X-Gm-Message-State: ABy/qLZ1aD3GSVIbBNgPP2u9A04UPeYNqVrkVu15JAN4AwcLGRGbupIs
	tDHwiQPEvkvucnXkS9n/1PjfhMlQ1FkfGRqF4/c=
X-Google-Smtp-Source: APBJJlHQPx2ym6naqDMYlMFwACaCfkvumlwa7pwH3K9hu5P5mXUF971XGCQfyglN+JkhYk6/Y4QO7Liw3TohMI5klVo=
X-Received: by 2002:ac2:5b1d:0:b0:4f7:6976:2070 with SMTP id
 v29-20020ac25b1d000000b004f769762070mr2776618lfn.40.1688701705390; Thu, 06
 Jul 2023 20:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-11-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-11-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 20:48:13 -0700
Message-ID: <CAEf4Bza0sDmQgcPMh3S5rRHdw9n3Cx_KwCLvP7y__xkR1vOL8A@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 10/26] libbpf: Add elf_resolve_syms_offsets function
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

On Fri, Jun 30, 2023 at 1:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding elf_resolve_syms_offsets function that looks up
> offsets for symbols specified in syms array argument.
>
> Offsets are returned in allocated array with the 'cnt' size,
> that needs to be released by the caller.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/elf.c        | 105 +++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf_elf.h |   2 +
>  2 files changed, 107 insertions(+)
>
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index fcce4bd2478f..7e2f3b2e1fb6 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -271,3 +271,108 @@ long elf_find_func_offset_from_file(const char *bin=
ary_path, const char *name)
>         elf_close(&elf_fd);
>         return ret;
>  }
> +
> +struct symbol {
> +       const char *name;
> +       int bind;
> +       int idx;
> +};
> +
> +static int symbol_cmp(const void *_a, const void *_b)
> +{
> +       const struct symbol *a =3D _a;
> +       const struct symbol *b =3D _b;

please, let's not (over)use leading underscores, x/y, s1/s2, whatever

> +
> +       return strcmp(a->name, b->name);
> +}
> +

probably worth leaving a comment that the caller should free offsets on suc=
cess?

> +int elf_resolve_syms_offsets(const char *binary_path, int cnt,
> +                            const char **syms, unsigned long **poffsets)
> +{
> +       int sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
> +       int err =3D 0, i, cnt_done =3D 0;
> +       unsigned long *offsets;
> +       struct symbol *symbols;
> +       struct elf_fd elf_fd;
> +
> +       err =3D elf_open(binary_path, &elf_fd);
> +       if (err)
> +               return err;
> +
> +       offsets =3D calloc(cnt, sizeof(*offsets));
> +       symbols =3D calloc(cnt, sizeof(*symbols));
> +
> +       if (!offsets || !symbols) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       for (i =3D 0; i < cnt; i++) {
> +               symbols[i].name =3D syms[i];
> +               symbols[i].idx =3D i;
> +       }
> +
> +       qsort(symbols, cnt, sizeof(*symbols), symbol_cmp);
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

same nit, no need for nested ifs
> +
> +               while ((sym =3D elf_sym_iter_next(&iter))) {
> +                       int bind =3D GELF_ST_BIND(sym->sym.st_info);
> +                       struct symbol *found, tmp =3D {
> +                               .name =3D sym->name,
> +                       };
> +                       unsigned long *offset;
> +
> +                       found =3D bsearch(&tmp, symbols, cnt, sizeof(*sym=
bols), symbol_cmp);
> +                       if (!found)
> +                               continue;
> +
> +                       offset =3D &offsets[found->idx];
> +                       if (*offset > 0) {
> +                               /* same offset, no problem */
> +                               if (*offset =3D=3D elf_sym_offset(sym))
> +                                       continue;
> +                               /* handle multiple matches */
> +                               if (found->bind !=3D STB_WEAK && bind !=
=3D STB_WEAK) {
> +                                       /* Only accept one non-weak bind.=
 */
> +                                       pr_warn("elf: ambiguous match fou=
ndr '%s', '%s' in '%s'\n",

typo: found

but also wouldn't sym->name and found->name be always the same? Maybe
log sym->name, previous *offset and newly calculated
elf_sym_offset(sym) instead?

> +                                               sym->name, found->name, b=
inary_path);
> +                                       err =3D -LIBBPF_ERRNO__FORMAT;

I'd minimize using those custom libbpf-only errors, why not -ESRCH here?

> +                                       goto out;
> +                               } else if (bind =3D=3D STB_WEAK) {
> +                                       /* already have a non-weak bind, =
and
> +                                        * this is a weak bind, so ignore=
.
> +                                        */
> +                                       continue;
> +                               }
> +                       } else {
> +                               cnt_done++;
> +                       }
> +                       *offset =3D elf_sym_offset(sym);

maybe remember elf_sym_offset() result in a variable? you are using it
in two (and with my suggestion above it will be three) places already

> +                       found->bind =3D bind;
> +               }
> +       }
> +
> +       if (cnt !=3D cnt_done) {
> +               err =3D -ENOENT;
> +               goto out;
> +       }
> +
> +       *poffsets =3D offsets;
> +
> +out:
> +       free(symbols);
> +       if (err)
> +               free(offsets);
> +       elf_close(&elf_fd);
> +       return err;
> +}
> diff --git a/tools/lib/bpf/libbpf_elf.h b/tools/lib/bpf/libbpf_elf.h
> index c763ac35a85e..026c7b378727 100644
> --- a/tools/lib/bpf/libbpf_elf.h
> +++ b/tools/lib/bpf/libbpf_elf.h
> @@ -16,4 +16,6 @@ void elf_close(struct elf_fd *elf_fd);
>  long elf_find_func_offset(Elf *elf, const char *binary_path, const char =
*name);
>  long elf_find_func_offset_from_file(const char *binary_path, const char =
*name);
>
> +int elf_resolve_syms_offsets(const char *binary_path, int cnt,
> +                            const char **syms, unsigned long **poffsets)=
;
>  #endif /* *__LIBBPF_LIBBPF_ELF_H */
> --
> 2.41.0
>

