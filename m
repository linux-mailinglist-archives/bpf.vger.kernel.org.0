Return-Path: <bpf+bounces-3309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D771A73C083
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 22:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1486C1C21355
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1AF11C91;
	Fri, 23 Jun 2023 20:40:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EDA11C80
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 20:40:48 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFE42733
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so1518532e87.2
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687552807; x=1690144807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtWIy3BjZbuPvjxs0wNfYbArMuKCWd725e/ZK9Uzcis=;
        b=bOIbvao50Om841kGxtZYwlny/jN1rm6a1pMCypzKIS6bRiUqlAFj5y22FNyBXEKOgI
         jPjz+QScrzAFeh+/gifWynBfasPM+aNkij6w16pUrKZQCmqoYQMEafRnzJpKJYaRfgKV
         SPtNsOpf49AOrZd0f0VEbKzzWlbtJAI3ZxYkifJhR+2yOu2kIpnRL3J3b1Por8H5CcZM
         RyQY1p1ifn1MaH+sBHYxJ3LVAAgdxnqTTWP2HGFPAMFkN1elAtSVbu7kTYRc/zrEFGce
         IPwiGRFOOEQyXxiDaZRuigyNBsneKarx/O4OKb/XeLNyfcq/8VP0tVmyZQ6fIBQlu4UN
         yaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552807; x=1690144807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtWIy3BjZbuPvjxs0wNfYbArMuKCWd725e/ZK9Uzcis=;
        b=ggDXj6oumzlrrEv7ENjBLquBviFmsE+YHLF6FqTo8GWuXGZtxDL9IJ2lxdeQJus22B
         fRaymeA/6g5J5j1XksktB88Oq1AA4YsB3CweEq2K+wO2n+7P5jQKAI4jHGpMX8zi5Xau
         exBfPJMSHrWfpnxIFb/l8F1yv3oDgiJzwvtJ1aaNVubMCegjR95sifKru8PwF6AMm/Ng
         IQKfVpp6cr9WG0xoEoGIHBXSrATN+HPU9xPlL6DgRJgsp8KVtfPPF4x+/5GOjmdj8gzX
         DgM93tPL/iw/sQfBlvrUYjQtjnFzPjLjnHJnDlYKZ7xnAGxGGS7fIhfAUiwU06vWIHZb
         99FQ==
X-Gm-Message-State: AC+VfDx2vNMvybcdJ/0/mYRpWqxH4qxQuPzBvAziMAQjLwoV6BS1P6xx
	oOBUgruGN7+ZS1Ej8GNJqu1+PPjsGuKWjWUg29s=
X-Google-Smtp-Source: ACHHUZ74bz9LgVzPKSKuOPt6NpSH0Te+uZGCqcMiGrsATxxmCYuBEvDeOxhPORk5PHN2nLW37L1PJFGtO4C75v8JdMA=
X-Received: by 2002:a05:6512:33c8:b0:4f9:72a5:2b6b with SMTP id
 d8-20020a05651233c800b004f972a52b6bmr2068330lfg.49.1687552806651; Fri, 23 Jun
 2023 13:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-9-jolsa@kernel.org>
In-Reply-To: <20230620083550.690426-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 13:39:54 -0700
Message-ID: <CAEf4BzZFipgUhpaUY7-Cy9+jBOtBws5bdnFMh0FgWk_kh-z6pQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 08/24] libbpf: Add elf_find_multi_func_offset function
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

On Tue, Jun 20, 2023 at 1:37=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding elf_find_multi_func_offset function that looks up
> offsets for symbols specified in syms array argument.
>
> Offsets are returned in allocated array with the 'cnt' size,
> that needs to be released by the caller.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c          | 112 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf_internal.h |   2 +
>  2 files changed, 114 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 30d9e3b69114..1c310b718961 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11053,6 +11053,118 @@ static long elf_find_func_offset(Elf *elf, cons=
t char *binary_path, const char *
>         return ret;
>  }
>
> +struct elf_symbol_offset {
> +       const char *name;
> +       unsigned long offset;
> +       int bind;
> +       int idx;
> +};
> +
> +static int cmp_func_offset(const void *_a, const void *_b)
> +{
> +       const struct elf_symbol_offset *a =3D _a;
> +       const struct elf_symbol_offset *b =3D _b;
> +
> +       return strcmp(a->name, b->name);
> +}
> +
> +static int
> +__elf_find_multi_func_offset(Elf *elf, const char *binary_path, int cnt,
> +                            const char **syms, unsigned long **poffsets)
> +{
> +       int sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
> +       struct elf_symbol_offset *func_offs;
> +       int err =3D 0, i, idx, cnt_done =3D 0;
> +       unsigned long *offsets =3D NULL;
> +
> +       func_offs =3D calloc(cnt, sizeof(*func_offs));
> +       if (!func_offs)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < cnt; i++) {
> +               func_offs[i].name =3D syms[i];
> +               func_offs[i].idx =3D i;
> +       }
> +
> +       qsort(func_offs, cnt, sizeof(*func_offs), cmp_func_offset);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(sh_types); i++) {
> +               struct elf_symbol_iter iter;
> +               struct elf_symbol *sym;
> +
> +               if (elf_symbol_iter_new(&iter, elf, binary_path, sh_types=
[i]))

a bit lax handling of initialization errors here, let's be a bit more
strict here?

> +                       continue;
> +
> +               while ((sym =3D elf_symbol_iter_next(&iter))) {
> +                       struct elf_symbol_offset *fo, tmp =3D {
> +                               .name =3D sym->name,
> +                       };
> +
> +                       fo =3D bsearch(&tmp, func_offs, cnt, sizeof(*func=
_offs),
> +                                    cmp_func_offset);
> +                       if (!fo)
> +                               continue;
> +
> +                       if (fo->offset > 0) {
> +                               /* same offset, no problem */
> +                               if (fo->offset =3D=3D sym->offset)
> +                                       continue;
> +                               /* handle multiple matches */
> +                               if (fo->bind !=3D STB_WEAK && sym->bind !=
=3D STB_WEAK) {
> +                                       /* Only accept one non-weak bind.=
 */
> +                                       pr_warn("elf: ambiguous match for=
 '%s', '%s' in '%s'\n",
> +                                               sym->name, fo->name, bina=
ry_path);
> +                                       err =3D -LIBBPF_ERRNO__FORMAT;
> +                                       goto out;
> +                               } else if (sym->bind =3D=3D STB_WEAK) {
> +                                       /* already have a non-weak bind, =
and
> +                                        * this is a weak bind, so ignore=
.
> +                                        */
> +                                       continue;
> +                               }
> +                       }
> +                       if (!fo->offset)
> +                               cnt_done++;
> +                       fo->offset =3D sym->offset;
> +                       fo->bind =3D sym->bind;
> +               }
> +       }
> +
> +       if (cnt !=3D cnt_done) {
> +               err =3D -ENOENT;
> +               goto out;
> +       }
> +       offsets =3D calloc(cnt, sizeof(*offsets));

you can allocate it at the very beginning and fill it out based on
fo->idx, there is no need to store offset in elf_symbol_offset

> +       if (!offsets) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +       for (i =3D 0; i < cnt; i++) {
> +               idx =3D func_offs[i].idx;
> +               offsets[idx] =3D func_offs[i].offset;
> +       }
> +
> +out:
> +       *poffsets =3D offsets;
> +       free(func_offs);
> +       return err;
> +}
> +
> +int elf_find_multi_func_offset(const char *binary_path, int cnt,
> +                              const char **syms, unsigned long **poffset=
s)
> +{
> +       struct elf_fd elf_fd =3D {};

do you need to initialize this struct?

> +       long ret =3D -ENOENT;

same here, you always override ret, so no need to init it?

> +
> +       ret =3D open_elf(binary_path, &elf_fd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D __elf_find_multi_func_offset(elf_fd.elf, binary_path, cnt=
, syms, poffsets);

is there a point of having elf_find_multi_func_offset and
__elf_find_multi_func_offset separately? can you please combine?


> +       close_elf(&elf_fd);
> +       return ret;
> +}
> +
>  /* Find offset of function name in ELF object specified by path. "name" =
matches
>   * symbol name or name@@LIB for library functions.
>   */
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index e4d05662a96c..13d5c12fbd0b 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -577,4 +577,6 @@ static inline bool is_pow_of_2(size_t x)
>  #define PROG_LOAD_ATTEMPTS 5
>  int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attem=
pts);
>
> +int elf_find_multi_func_offset(const char *binary_path, int cnt,
> +                              const char **syms, unsigned long **poffset=
s);
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> --
> 2.41.0
>

