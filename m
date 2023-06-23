Return-Path: <bpf+bounces-3221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F054273ADC1
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 02:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA51728181A
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 00:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F637A;
	Fri, 23 Jun 2023 00:32:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF8361
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 00:32:14 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89AD172D
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:32:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fa0253b9e7so1150875e9.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687480331; x=1690072331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZutpdR/iIK8edOSeARpwLRY3gbKH5SfEItAzVP5T2G0=;
        b=deLVv2v0H0CszG/y6xCDFd1vpZ4F6cMFGUZ6nbjgl805XHi/sxT0pfC87JvKSjeE4a
         Y5gYuKLMTkIqv6LoE/Rph7JXSUNSLs6roT5FOUrzjildydKH9BZHBGAA7TzTTR9/sybf
         ziZtMHPICUAiAwiXLryg7SwDRs7xIylMPRPG4jyLWkCzB3xDjdBCB9OQMeEdw9CN1vlo
         tr3tKwNmQo15jxehom5QP4KRPJyJ0fVyXdJhvjxG+M798Ink0wmr5zkIOYKYdqNSqRnC
         toB0t3TDwwW/DDfCti44I5R8wIzi/PubyvJMJsgsZFJ+o77YLbTMEzFr94mrXO3I9MgK
         xq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687480331; x=1690072331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZutpdR/iIK8edOSeARpwLRY3gbKH5SfEItAzVP5T2G0=;
        b=IgB2s2SDFhRzPZr6CbJ10Bu+AwFyn2otdxR2kaKbYo0yIAQHv0DymPHF0LN6ucyu6W
         C0fxAr+CN/QwNSY2jbPZhGV88eBYxm1Fo1DXBJCOCbTwS3WpUDdzmMh4XElCKgBk/SXc
         Lf8cBgm40l9jkXv1ZrMbk3w4pxdnvYwKuJ317EucPqcb2kMTcrPXwO5G7fVPLJ5F5RQL
         7QFu2wnzoLR66FAs/07iMldAJxYZBYl1VRkgCGmxIntCS4XwPJzKsNT7M01ickMEsBG9
         C03lP5eYuyg17/y8plI4/nWAz+g9ounZS1e5420JKFXggFjgXDLQ7JTZL8hjMEp1QcMz
         wraQ==
X-Gm-Message-State: AC+VfDyaalqjtYtIChItfM+Rcut+u1Cb09N/gly/56gwkDi/w+jIQiob
	CmaJ3wRXqj/dwqf6Z3fF0PFP746VefPsnSHO5gE=
X-Google-Smtp-Source: ACHHUZ6oSeUSNfmXrD93ohrLxrhlKGrpkfenDySkwxhQxg8S5kL7w0vabnXZMHxG2XTcDCy2cmGGangJZSrBKAOpYAo=
X-Received: by 2002:a05:600c:ad2:b0:3f9:bb86:bdd3 with SMTP id
 c18-20020a05600c0ad200b003f9bb86bdd3mr6623668wmr.7.1687480330940; Thu, 22 Jun
 2023 17:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-7-jolsa@kernel.org>
In-Reply-To: <20230620083550.690426-7-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 17:31:58 -0700
Message-ID: <CAEf4BzbVJ4y2-y8WFicA_iSkVUoieWWHbv_f1mLwoY3fSPeTRw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 06/24] libbpf: Add elf symbol iterator
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

On Tue, Jun 20, 2023 at 1:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding elf symbol iterator object (and some functions) that follow
> open-coded iterator pattern and some functions to ease up iterating
> elf object symbols.
>
> The idea is to iterate single symbol section with:
>
>   struct elf_symbol_iter iter;
>   struct elf_symbol *sym;
>
>   if (elf_symbol_iter_new(&iter, elf, binary_path, SHT_DYNSYM))
>         goto error;
>
>   while ((sym =3D elf_symbol_iter_next(&iter))) {
>         ...
>   }
>
> I considered opening the elf inside the iterator and iterate all symbol
> sections, but then it gets more complicated wrt user checks for when
> the next section is processed.
>
> Plus side is the we don't need 'exit' function, because caller/user is
> in charge of that.
>
> The returned iterated symbol object from elf_symbol_iter_next function
> is placed inside the struct elf_symbol_iter, so no extra allocation or
> argument is needed.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 179 ++++++++++++++++++++++++++---------------
>  1 file changed, 114 insertions(+), 65 deletions(-)
>

This is great. Left a few nits below. I'm thinkin maybe we should add
a separate elf.c file for all these ELF-related helpers and start
offloading code from libbpf.c, which got pretty big already. WDYT?


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index af52188daa80..cdac368c7ce1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10824,6 +10824,109 @@ static Elf_Scn *elf_find_next_scn_by_type(Elf *=
elf, int sh_type, Elf_Scn *scn)
>         return NULL;
>  }
>
> +struct elf_symbol {
> +       const char *name;
> +       unsigned long offset;
> +       int bind;
> +};
> +
> +struct elf_symbol_iter {

naming nits: elf_sym and elf_sym_iter? keep it short, keep it cool :)

> +       Elf *elf;
> +       Elf_Data *symbols;

syms :-P

> +       size_t nr_syms;
> +       size_t strtabidx;
> +       size_t idx;

next_sym_idx?

> +       struct elf_symbol sym;
> +};
> +
> +static int elf_symbol_iter_new(struct elf_symbol_iter *iter,
> +                              Elf *elf, const char *binary_path,
> +                              int sh_type)
> +{
> +       Elf_Scn *scn =3D NULL;
> +       GElf_Ehdr ehdr;
> +       GElf_Shdr sh;
> +
> +       memset(iter, 0, sizeof(*iter));
> +
> +       if (!gelf_getehdr(elf, &ehdr)) {
> +               pr_warn("elf: failed to get ehdr from %s: %s\n", binary_p=
ath, elf_errmsg(-1));
> +               return -LIBBPF_ERRNO__FORMAT;
> +       }
> +
> +       scn =3D elf_find_next_scn_by_type(elf, sh_type, NULL);
> +       if (!scn) {
> +               pr_debug("elf: failed to find symbol table ELF sections i=
n '%s'\n",
> +                        binary_path);
> +               return -EINVAL;
> +       }
> +
> +       if (!gelf_getshdr(scn, &sh))
> +               return -EINVAL;
> +
> +       iter->strtabidx =3D sh.sh_link;
> +       iter->symbols =3D elf_getdata(scn, 0);
> +       if (!iter->symbols) {
> +               pr_warn("elf: failed to get symbols for symtab section in=
 '%s': %s\n",
> +                       binary_path, elf_errmsg(-1));
> +               return -LIBBPF_ERRNO__FORMAT;
> +       }
> +       iter->nr_syms =3D iter->symbols->d_size / sh.sh_entsize;
> +       iter->elf =3D elf;
> +       return 0;
> +}
> +
> +static struct elf_symbol *elf_symbol_iter_next(struct elf_symbol_iter *i=
ter)
> +{
> +       struct elf_symbol *ret =3D &iter->sym;
> +       unsigned long offset =3D 0;
> +       const char *name =3D NULL;
> +       GElf_Shdr sym_sh;
> +       Elf_Scn *sym_scn;
> +       GElf_Sym sym;
> +       size_t idx;
> +
> +       for (idx =3D iter->idx; idx < iter->nr_syms; idx++) {
> +               if (!gelf_getsym(iter->symbols, idx, &sym))
> +                       continue;
> +               if (GELF_ST_TYPE(sym.st_info) !=3D STT_FUNC)
> +                       continue;

it would be more generic if this symbol type filter was a parameter to
iterator, instead of hard-coding it?

> +               name =3D elf_strptr(iter->elf, iter->strtabidx, sym.st_na=
me);
> +               if (!name)
> +                       continue;
> +
> +               /* Transform symbol's virtual address (absolute for
> +                * binaries and relative for shared libs) into file
> +                * offset, which is what kernel is expecting for
> +                * uprobe/uretprobe attachment.
> +                * See Documentation/trace/uprobetracer.rst for more
> +                * details.
> +                * This is done by looking up symbol's containing
> +                * section's header and using iter's virtual address
> +                * (sh_addr) and corresponding file offset (sh_offset)
> +                * to transform sym.st_value (virtual address) into
> +                * desired final file offset.
> +                */
> +               sym_scn =3D elf_getscn(iter->elf, sym.st_shndx);
> +               if (!sym_scn)
> +                       continue;
> +               if (!gelf_getshdr(sym_scn, &sym_sh))
> +                       continue;
> +
> +               offset =3D sym.st_value - sym_sh.sh_addr + sym_sh.sh_offs=
et;

I think this part is not really generic "let's iterate ELF symbols",
maybe let users of iterator do this? We can have a helper to do
translation if we need to do it in few different places.

> +               break;
> +       }
> +
> +       /* we reached the last symbol */
> +       if (idx =3D=3D iter->nr_syms)
> +               return NULL;
> +       iter->idx =3D idx + 1;
> +       ret->name =3D name;
> +       ret->bind =3D GELF_ST_BIND(sym.st_info);
> +       ret->offset =3D offset;

Why not just return entire GElf_Sym information and let user process
it as desired. So basically for each symbol you'll give back its name,
GElf_Sym info, and I'd return symbol index as well. That will keep
this very generic for future uses.

> +       return ret;

I'd structure this a bit different. If we got out of loop, just return
NULL. Then inside the for loop, when we found the symbol, fill out ret
and return from inside the for loop. I think it's more
straightforward.

> +}
> +
>  /* Find offset of function name in the provided ELF object. "binary_path=
" is
>   * the path to the ELF binary represented by "elf", and only used for er=
ror
>   * reporting matters. "name" matches symbol name or name@@LIB for librar=
y

[...]

