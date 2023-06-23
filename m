Return-Path: <bpf+bounces-3310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CE373C092
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 22:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868FC281DCF
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61211C9F;
	Fri, 23 Jun 2023 20:40:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F50811C80
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 20:40:53 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8803C2963
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fa798cf201so13186675e9.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687552811; x=1690144811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTbvOwrDDPA13zO7HLWQm+ClEKfxUjNyZXwq1qf31To=;
        b=M+DFigj5L69ejmKFyFOUOC1FGpfh77e5jPQqo4jkUcMdsHDwZzWVKMjDDNswttaTMn
         sLhxBrWMTHaG1x/impEeRbz2UPFoDBcSGbeGhebBytlqyFn83/kL1JaLLZRPmWf/WJ60
         PO3bxcJ4DC83ezLMhdBxHmW5ax8UFW7Gu4ULNzoXzmwqBpKek1BoK8z/06NbsLIVvvb1
         dDCNZCEucaKQJUo8PdwSMu5CuHPG0DFx15JXMpw3WvcjTcq7H+kpZhHc29moCQAQxXAU
         2pQzn8JBHr9bbqS1oZyYDlbXmHlKjJfv2fI0hGfbWPP55j7/0rTupg2yda69dxoaTX0d
         I/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552811; x=1690144811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTbvOwrDDPA13zO7HLWQm+ClEKfxUjNyZXwq1qf31To=;
        b=hsOCRZjsLHKrXIfSewMBbHGS0iYSbM9yKjvIP4ND9uosSUxot6qJT7OfZO+SbPPADk
         o23Z80ZeTTtc6yjvr12Yt3TJQn3OXBaXu0/Yc+s92S+o4cNMb3ayG1LTrPNgFXsZ5vdk
         ElnoMZuTo71PuqlLYLNfP1UknW3tCZJDOrVa7YikxFTQMWoHL4Y765AXsmxL5IVzBsM/
         G1o2omNFnuPH0Pumqjc7B3Pr5B8xEPtp/cG/QrFk7i/wLNZbImQmkS8APTcpctJS4/4S
         boXmH4u39rRPt7T8APO0592a+gjGiDrnbhoXFxO3JQVdwrOTnvYCzfBQeOz/70A8Dv5d
         sWEg==
X-Gm-Message-State: AC+VfDzLEZwaUSBnyQJan367kVRu4CYma3tPAE17eAKI6Hm4Fqyay94K
	5TRtR99HJofDTKqCY41MbaWca2M0WwGXI0XCKwI=
X-Google-Smtp-Source: ACHHUZ4jtrSDD9erNLdX3szBcQ2bF3ctA+YMTLMPX3b+ealkqM1TFjgkM9R7sUsmS81tYmjL4O4E9bDr77tgvSauCWA=
X-Received: by 2002:a7b:c7d5:0:b0:3fa:792c:9a66 with SMTP id
 z21-20020a7bc7d5000000b003fa792c9a66mr3051088wmk.28.1687552810665; Fri, 23
 Jun 2023 13:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-10-jolsa@kernel.org>
In-Reply-To: <20230620083550.690426-10-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 13:39:58 -0700
Message-ID: <CAEf4BzYq2LsFkJxGGxU1QG=t8dn3aAqTa4XRdKcFkKjf2n_kow@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 09/24] libbpf: Add elf_find_pattern_func_offset function
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
> Adding elf_find_pattern_func_offset function that looks up
> offsets for symbols specified by pattern argument.
>
> The 'pattern' argument allows wildcards (*?' supported).
>
> Offsets are returned in allocated array together with its
> size and needs to be released by the caller.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c          | 78 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf_internal.h |  3 ++
>  2 files changed, 81 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1c310b718961..3e5c88caf5d5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11165,6 +11165,84 @@ int elf_find_multi_func_offset(const char *binar=
y_path, int cnt,
>         return ret;
>  }
>
> +static int
> +__elf_find_pattern_func_offset(Elf *elf, const char *binary_path, const =
char *pattern,
> +                              const char ***pnames, unsigned long **poff=
sets, size_t *pcnt)
> +{
> +       int sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
> +       struct elf_symbol_offset *func_offs =3D NULL;
> +       unsigned long *offsets =3D NULL;
> +       const char **names =3D NULL;
> +       size_t func_offs_cnt =3D 0;
> +       size_t func_offs_cap =3D 0;
> +       int err =3D 0, i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(sh_types); i++) {
> +               struct elf_symbol_iter iter;
> +               struct elf_symbol *sym;
> +
> +               if (elf_symbol_iter_new(&iter, elf, binary_path, sh_types=
[i]))
> +                       continue;

same as in the previous patch, error handling?

> +
> +               while ((sym =3D elf_symbol_iter_next(&iter))) {
> +                       if (!glob_match(sym->name, pattern))
> +                               continue;
> +
> +                       err =3D libbpf_ensure_mem((void **) &func_offs, &=
func_offs_cap,
> +                                               sizeof(*func_offs), func_=
offs_cnt + 1);
> +                       if (err)
> +                               goto out;
> +
> +                       func_offs[func_offs_cnt].offset =3D sym->offset;
> +                       func_offs[func_offs_cnt].name =3D strdup(sym->nam=
e);

check for NULL?

and I'm actually unsure why you need to reuse elf_symbol_offset struct
here? You just need names and offsets in two separate array, so just
do that?..

> +                       func_offs_cnt++;
> +               }
> +
> +               /* If we found anything in the first symbol section,
> +                * do not search others to avoid duplicates.
> +                */
> +               if (func_offs_cnt)
> +                       break;
> +       }
> +
> +       offsets =3D calloc(func_offs_cnt, sizeof(*offsets));
> +       names =3D calloc(func_offs_cnt, sizeof(*names));
> +       if (!offsets || !names) {
> +               free(offsets);
> +               free(names);
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       for (i =3D 0; i < func_offs_cnt; i++) {
> +               offsets[i] =3D func_offs[i].offset;
> +               names[i] =3D func_offs[i].name;

see above, why not fill these out right away during elf symbols iteration?

> +       }
> +
> +       *pnames =3D names;
> +       *poffsets =3D offsets;
> +       *pcnt =3D func_offs_cnt;
> +out:
> +       free(func_offs);
> +       return err;
> +}
> +
> +int elf_find_pattern_func_offset(const char *binary_path, const char *pa=
ttern,
> +                                const char ***pnames, unsigned long **po=
ffsets,
> +                                size_t *pcnt)
> +{
> +       struct elf_fd elf_fd =3D {};
> +       long ret =3D -ENOENT;
> +
> +       ret =3D open_elf(binary_path, &elf_fd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D __elf_find_pattern_func_offset(elf_fd.elf, binary_path, p=
attern, pnames, poffsets, pcnt);

I don't really like these underscored functions,
elf_find_pattern_func_offset() already has to do goto out for clean
ups, this close_elf() thing is just another resource to clean up
there, I don't see much reason to separate open_elf/close_elf in this
case


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
> index 13d5c12fbd0b..22b0834e7fe1 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -579,4 +579,7 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned =
int size, int attempts);
>
>  int elf_find_multi_func_offset(const char *binary_path, int cnt,
>                                const char **syms, unsigned long **poffset=
s);
> +int elf_find_pattern_func_offset(const char *binary_path, const char *pa=
ttern,
> +                                const char ***pnames, unsigned long **po=
ffsets,
> +                                size_t *pcnt);
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> --
> 2.41.0
>

