Return-Path: <bpf+bounces-4352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723BA74A78A
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0721C20EB5
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D30168A1;
	Thu,  6 Jul 2023 23:25:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A563BA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 23:25:04 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521CA1BC9
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 16:25:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso14145365e9.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 16:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688685901; x=1691277901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDieQayRjWDTLBouv2Kea+tZJ6HRN9976SIWKshktZg=;
        b=D1V/8OWnzRjRRXP1XtT8Nv+hNJpqcAZtnnozbDz2egw0D3W9YYVRVjo4wn2Y6EPCms
         K59s6NMhOWt4+GFDr6O5rAXTJUhiIJtIa2n/0UCt5aPLo1ZShkIca+kayLR78hWtsECU
         UyUIW2cWos9nouxqUgE3sEPWwF1p0oQnwKxjdiZx0CIZX0tVvMsbfqqK0nM85xG01Ifp
         quJJqtyd289I1Jckm7Pp6w5MlCT2nKp+G3DCnRM8ZAoiGUEVdxcyJwAqp69nPfumMxC6
         lVJ4lBrdwynB8MeB/bpeNfcKSDAKuzLH7kUXe4h7Z9IiW/eDx4vWG8BV1fquqcA3yr6h
         iTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688685901; x=1691277901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDieQayRjWDTLBouv2Kea+tZJ6HRN9976SIWKshktZg=;
        b=PjZ74beIzjj1WVD1aByToNjY4uj9pszVhwBsq0MlAv1bzXMZ2NH2yU8m9WgWQCR6fy
         JZbfEVgnaAa9b4sgtC8c5u64O/OjI9Py/AGtoAlR2wFn0uLnGjuXtBmJlh+Mqz0OMNj5
         vUrLBu3HK3nJtjzXjhE8/P4KFm+lSso7ek39gSQ4KUcZfZI7zNUGX4RDq9Gjqz3zxWRb
         wlWKz6yQ5L0ubbPlY5c26S9RT/Pspr6Ovy3rPO+1oCa/umzNvhBSACFuAQaK245m3f6e
         78VDQ3uuY1/NmmCxWBiUfgNSWJaEfOgbmNi8d8/yGOFNaPJl9FNrWw+vYx8gzLo1ZM71
         NnHQ==
X-Gm-Message-State: ABy/qLa3d/J40egdCB9tmFBcjqjm7kkTsZmqRI82tTGEZL2TZqBlak8E
	NCWAlbgh+czrj5SVphwzOOZc5dMg1/by6eNQ3Zg=
X-Google-Smtp-Source: APBJJlEmzu7ebXrwK0gfgDgkLHE07bzlIXAy3nvC20qtCwqxqOJOlHdSaNZDvzr+0JsyHnIfWwN4/xyTa6t1hV91KEA=
X-Received: by 2002:adf:e9d1:0:b0:313:e88d:e6cf with SMTP id
 l17-20020adfe9d1000000b00313e88de6cfmr2635353wrn.69.1688685900607; Thu, 06
 Jul 2023 16:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-10-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-10-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 16:24:48 -0700
Message-ID: <CAEf4BzbeyXniXfYoE6e8=3wLJ+ikN+pMrByJqwjjTzkHwebp6w@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 09/26] libbpf: Add elf symbol iterator
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 1:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding elf symbol iterator object (and some functions) that follow
> open-coded iterator pattern and some functions to ease up iterating
> elf object symbols.
>
> The idea is to iterate single symbol section with:
>
>   struct elf_sym_iter iter;
>   struct elf_sym *sym;
>
>   if (elf_sym_iter_new(&iter, elf, binary_path, SHT_DYNSYM))
>         goto error;
>
>   while ((sym =3D elf_sym_iter_next(&iter))) {
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
> The returned iterated symbol object from elf_sym_iter_next function
> is placed inside the struct elf_sym_iter, so no extra allocation or
> argument is needed.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/elf.c | 178 +++++++++++++++++++++++++++++---------------
>  1 file changed, 117 insertions(+), 61 deletions(-)
>

A bunch of nits, but overall looks good. Please address nits, and add my ac=
k

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 74e35071d22e..fcce4bd2478f 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -59,6 +59,108 @@ static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, i=
nt sh_type, Elf_Scn *scn)
>         return NULL;
>  }
>
> +struct elf_sym {
> +       const char *name;
> +       GElf_Sym sym;
> +       GElf_Shdr sh;
> +};
> +

if we want to use elf_sym_iter outside of elf.c, this should be in
libbpf_internal.h?

> +struct elf_sym_iter {
> +       Elf *elf;
> +       Elf_Data *syms;
> +       size_t nr_syms;
> +       size_t strtabidx;
> +       size_t next_sym_idx;
> +       struct elf_sym sym;
> +       int st_type;
> +};
> +
> +static int elf_sym_iter_new(struct elf_sym_iter *iter,
> +                           Elf *elf, const char *binary_path,
> +                           int sh_type, int st_type)
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
> +               return -EINVAL;
> +       }
> +
> +       scn =3D elf_find_next_scn_by_type(elf, sh_type, NULL);
> +       if (!scn) {
> +               pr_debug("elf: failed to find symbol table ELF sections i=
n '%s'\n",
> +                        binary_path);
> +               return -ENOENT;
> +       }
> +
> +       if (!gelf_getshdr(scn, &sh))
> +               return -EINVAL;
> +
> +       iter->strtabidx =3D sh.sh_link;
> +       iter->syms =3D elf_getdata(scn, 0);
> +       if (!iter->syms) {
> +               pr_warn("elf: failed to get symbols for symtab section in=
 '%s': %s\n",
> +                       binary_path, elf_errmsg(-1));
> +               return -EINVAL;
> +       }
> +       iter->nr_syms =3D iter->syms->d_size / sh.sh_entsize;
> +       iter->elf =3D elf;
> +       iter->st_type =3D st_type;
> +       return 0;
> +}
> +
> +static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
> +{
> +       struct elf_sym *ret =3D &iter->sym;
> +       GElf_Sym *sym =3D &ret->sym;
> +       const char *name =3D NULL;
> +       Elf_Scn *sym_scn;
> +       size_t idx;
> +
> +       for (idx =3D iter->next_sym_idx; idx < iter->nr_syms; idx++) {
> +               if (!gelf_getsym(iter->syms, idx, sym))
> +                       continue;
> +               if (GELF_ST_TYPE(sym->st_info) !=3D iter->st_type)
> +                       continue;
> +               name =3D elf_strptr(iter->elf, iter->strtabidx, sym->st_n=
ame);
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

this comment is misplaced? we don't do the translation here

> +               sym_scn =3D elf_getscn(iter->elf, sym->st_shndx);
> +               if (!sym_scn)
> +                       continue;
> +               if (!gelf_getshdr(sym_scn, &ret->sh))
> +                       continue;
> +
> +               iter->next_sym_idx =3D idx + 1;
> +               ret->name =3D name;
> +               return ret;
> +       }
> +
> +       return NULL;
> +}
> +
> +static unsigned long elf_sym_offset(struct elf_sym *sym)
> +{
> +       return sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset;
> +}
> +
>  /* Find offset of function name in the provided ELF object. "binary_path=
" is
>   * the path to the ELF binary represented by "elf", and only used for er=
ror
>   * reporting matters. "name" matches symbol name or name@@LIB for librar=
y
> @@ -90,64 +192,36 @@ long elf_find_func_offset(Elf *elf, const char *bina=
ry_path, const char *name)
>          * reported as a warning/error.
>          */
>         for (i =3D 0; i < ARRAY_SIZE(sh_types); i++) {
> -               size_t nr_syms, strtabidx, idx;
> -               Elf_Data *symbols =3D NULL;
> -               Elf_Scn *scn =3D NULL;
> +               struct elf_sym_iter iter;
> +               struct elf_sym *sym;
>                 int last_bind =3D -1;
> -               const char *sname;
> -               GElf_Shdr sh;
> +               int curr_bind;

OCD nit:

$ rg 'curr(_|\b)' | wc -l
8
$ rg 'cur(_|\b)' | wc -l
148

and those 8 I consider an unfortunate accident ;) let's standardize on
using "cur" consistently

>
> -               scn =3D elf_find_next_scn_by_type(elf, sh_types[i], NULL)=
;
> -               if (!scn) {
> -                       pr_debug("elf: failed to find symbol table ELF se=
ctions in '%s'\n",
> -                                binary_path);
> -                       continue;
> -               }
> -               if (!gelf_getshdr(scn, &sh))
> -                       continue;
> -               strtabidx =3D sh.sh_link;
> -               symbols =3D elf_getdata(scn, 0);
> -               if (!symbols) {
> -                       pr_warn("elf: failed to get symbols for symtab se=
ction in '%s': %s\n",
> -                               binary_path, elf_errmsg(-1));
> -                       ret =3D -LIBBPF_ERRNO__FORMAT;
> +               ret =3D elf_sym_iter_new(&iter, elf, binary_path, sh_type=
s[i], STT_FUNC);
> +               if (ret) {
> +                       if (ret =3D=3D -ENOENT)
> +                               continue;
>                         goto out;

another styling nit: let's avoid unnecessary nesting of ifs:

if (ret =3D=3D -ENOENT)
    continue;
if (ret)
    goto out;

simple and clean


>                 }
> -               nr_syms =3D symbols->d_size / sh.sh_entsize;
> -
> -               for (idx =3D 0; idx < nr_syms; idx++) {
> -                       int curr_bind;
> -                       GElf_Sym sym;
> -                       Elf_Scn *sym_scn;
> -                       GElf_Shdr sym_sh;
> -
> -                       if (!gelf_getsym(symbols, idx, &sym))
> -                               continue;
> -
> -                       if (GELF_ST_TYPE(sym.st_info) !=3D STT_FUNC)
> -                               continue;
> -
> -                       sname =3D elf_strptr(elf, strtabidx, sym.st_name)=
;
> -                       if (!sname)
> -                               continue;
> -
> -                       curr_bind =3D GELF_ST_BIND(sym.st_info);
>
> +               while ((sym =3D elf_sym_iter_next(&iter))) {
>                         /* User can specify func, func@@LIB or func@@LIB_=
VERSION. */
> -                       if (strncmp(sname, name, name_len) !=3D 0)
> +                       if (strncmp(sym->name, name, name_len) !=3D 0)
>                                 continue;
>                         /* ...but we don't want a search for "foo" to mat=
ch 'foo2" also, so any
>                          * additional characters in sname should be of th=
e form "@@LIB".
>                          */
> -                       if (!is_name_qualified && sname[name_len] !=3D '\=
0' && sname[name_len] !=3D '@')
> +                       if (!is_name_qualified && sym->name[name_len] !=
=3D '\0' && sym->name[name_len] !=3D '@')
>                                 continue;
>
> -                       if (ret >=3D 0) {
> +                       curr_bind =3D GELF_ST_BIND(sym->sym.st_info);
> +
> +                       if (ret > 0) {

used to be >=3D, why the change?

>                                 /* handle multiple matches */
>                                 if (last_bind !=3D STB_WEAK && curr_bind =
!=3D STB_WEAK) {
>                                         /* Only accept one non-weak bind.=
 */
>                                         pr_warn("elf: ambiguous match for=
 '%s', '%s' in '%s'\n",
> -                                               sname, name, binary_path)=
;
> +                                               sym->name, name, binary_p=
ath);
>                                         ret =3D -LIBBPF_ERRNO__FORMAT;
>                                         goto out;
>                                 } else if (curr_bind =3D=3D STB_WEAK) {
> @@ -158,25 +232,7 @@ long elf_find_func_offset(Elf *elf, const char *bina=
ry_path, const char *name)
>                                 }
>                         }
>
> -                       /* Transform symbol's virtual address (absolute f=
or
> -                        * binaries and relative for shared libs) into fi=
le
> -                        * offset, which is what kernel is expecting for
> -                        * uprobe/uretprobe attachment.
> -                        * See Documentation/trace/uprobetracer.rst for m=
ore
> -                        * details.
> -                        * This is done by looking up symbol's containing
> -                        * section's header and using it's virtual addres=
s
> -                        * (sh_addr) and corresponding file offset (sh_of=
fset)
> -                        * to transform sym.st_value (virtual address) in=
to
> -                        * desired final file offset.
> -                        */
> -                       sym_scn =3D elf_getscn(elf, sym.st_shndx);
> -                       if (!sym_scn)
> -                               continue;
> -                       if (!gelf_getshdr(sym_scn, &sym_sh))
> -                               continue;
> -
> -                       ret =3D sym.st_value - sym_sh.sh_addr + sym_sh.sh=
_offset;
> +                       ret =3D elf_sym_offset(sym);
>                         last_bind =3D curr_bind;
>                 }
>                 if (ret > 0)
> --
> 2.41.0
>

