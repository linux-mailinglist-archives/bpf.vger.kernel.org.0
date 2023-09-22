Return-Path: <bpf+bounces-10657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2E77ABB37
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 23:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9071B281E08
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 21:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BF847C60;
	Fri, 22 Sep 2023 21:48:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694145F67
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 21:48:23 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA37CA
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 14:48:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so350102666b.0
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 14:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695419300; x=1696024100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT8AuVlklEhLgcHV5pvDbufuxzpjYAKhqdi/FYZkm0s=;
        b=lN+e+w2dqno3GcP9kb28/sFouHD69yC7JWRpq1idhYlrtRNVLSrtsGEF0Mpys9Py7I
         YdkD7Dhz4ul0T/hDKuNJqAmsK1wMayStg27JQWwjYRcOiINn8GuzSxAPHEJrSz+Lb4wV
         ciyerX4UJ9NEqfjyU5kvw4+jsn1SXMkFKsgP4TB7z3oWQrz0Too7f4RVtH1Snh0yUdD2
         adF3xp0Ac31SYnwou8OamfHasXxrmB6Z8rWa8QCIjP7NI0U2zlLrBYEQKpk5BwnI2tn6
         Ar1d40kVOXn0Exq9Y4AHQAbJ46K+LuwGEm8IbUumtdYZaBH76MlXd5SQavHjS9DaiFGq
         1MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695419300; x=1696024100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qT8AuVlklEhLgcHV5pvDbufuxzpjYAKhqdi/FYZkm0s=;
        b=sexgYH2r/qUPrAr4jztOUu0Rl2tCeeIQhNaiKENqkkbEKv0oUHPQGP7veP7G0xpgAW
         yki98jxqLNKYZbG8dSL4T/zLqyfNKgXBmT0aXsvnwTOkF7sTGQfyqIEsNhC1yDdI9p1o
         1nHNkdaTvXYZ7IOJOAHzkQCg7D+iBSz6Ab5G8JtsxMHk2xC8qFP0JNUPrrD7AHwqa9Sw
         mOtjDs/MJWgSE6I2FvUYia9Sd1MgP3sA3GvO5gHjbu2yXoUyLB/e++ZQHysqdc0w7h7Y
         GZrY7zuc/kvsGAWq+aXZFtTURp7gf9J4bBzBBr0le4wViq5nXYP5lOuwbKwFJH4sGl1Q
         cfTA==
X-Gm-Message-State: AOJu0YyMygJW9PzRPBMqjLSccR7KBfX7iFPZSzuE0wN3ZObq8h0VSjqQ
	/xDQM5sDDH7q8DIDz8YOEAqy4XkBeu7HwZldI2w=
X-Google-Smtp-Source: AGHT+IF62PZVLg9oM0GUfyCsXMwKHgXiYqFskzSSVPLCEeWXTRsv3IwoN+U3YQaF9YBIxS4vRNFgxP91RneaJpXvGTA=
X-Received: by 2002:a17:907:6d0f:b0:9a1:f3a6:b906 with SMTP id
 sa15-20020a1709076d0f00b009a1f3a6b906mr568798ejc.36.1695419299826; Fri, 22
 Sep 2023 14:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918024813.237475-1-hengqi.chen@gmail.com> <20230918024813.237475-3-hengqi.chen@gmail.com>
In-Reply-To: <20230918024813.237475-3-hengqi.chen@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Sep 2023 14:48:08 -0700
Message-ID: <CAEf4BzbgtWdDj6EUJAn9oNohwzcEEbHyRy30sk9D6jCJGXdDCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] libbpf: Support symbol versioning for uprobe
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alan.maguire@oracle.com, olsajiri@gmail.com, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 17, 2023 at 10:50=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
>
> In current implementation, we assume that symbol found in .dynsym section
> would have a version suffix and use it to compare with symbol user suppli=
ed.
> According to the spec ([0]), this assumption is incorrect, the version in=
fo
> of dynamic symbols are stored in .gnu.version and .gnu.version_d sections
> of ELF objects. For example:
>
>     $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>     000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
>     000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
>     000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5
>
>     $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock=
_wrlock
>       706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread_r=
wlock_wrlock@GLIBC_2.2.5
>       2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rw=
lock_wrlock@@GLIBC_2.34
>       2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rw=
lock_wrlock@GLIBC_2.2.5
>
> In this case, specify pthread_rwlock_wrlock@@GLIBC_2.34 or
> pthread_rwlock_wrlock@GLIBC_2.2.5 in bpf_uprobe_opts::func_name won't wor=
k.
> Because the qualified name does NOT match `pthread_rwlock_wrlock` (withou=
t
> version suffix) in .dynsym sections.
>
> This commit implements the symbol versioning for dynsym and allows user t=
o
> specify symbol in the following forms:
>   - func
>   - func@LIB_VERSION
>   - func@@LIB_VERSION
>
> In case of symbol conflicts, error out and users should resolve it by
> specifying a qualified name.
>
>   [0]: https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-generic/LS=
B-Core-generic/symversion.html
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/elf.c    | 134 +++++++++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf.c |   2 +-
>  2 files changed, 124 insertions(+), 12 deletions(-)
>
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 5c9e588b17da..f7ad7a7acc29 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -1,5 +1,8 @@
>  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
>  #include <libelf.h>
>  #include <gelf.h>
>  #include <fcntl.h>
> @@ -10,6 +13,17 @@
>
>  #define STRERR_BUFSIZE  128
>
> +/* A SHT_GNU_versym section holds 16-bit words. This bit is set if
> + * the symbol is hidden and can only be seen when referenced using an
> + * explicit version number. This is a GNU extension.
> + */
> +#define VERSYM_HIDDEN  0x8000
> +
> +/* This is the mask for the rest of the data in a word read from a
> + * SHT_GNU_versym section.
> + */
> +#define VERSYM_VERSION 0x7fff
> +
>  int elf_open(const char *binary_path, struct elf_fd *elf_fd)
>  {
>         char errmsg[STRERR_BUFSIZE];
> @@ -64,13 +78,18 @@ struct elf_sym {
>         const char *name;
>         GElf_Sym sym;
>         GElf_Shdr sh;
> +       int ver;
> +       bool hidden;
>  };
>
>  struct elf_sym_iter {
>         Elf *elf;
>         Elf_Data *syms;
> +       Elf_Data *versyms;
> +       Elf_Data *verdefs;
>         size_t nr_syms;
>         size_t strtabidx;
> +       size_t verdef_strtabidx;
>         size_t next_sym_idx;
>         struct elf_sym sym;
>         int st_type;
> @@ -111,6 +130,29 @@ static int elf_sym_iter_new(struct elf_sym_iter *ite=
r,
>         iter->nr_syms =3D iter->syms->d_size / sh.sh_entsize;
>         iter->elf =3D elf;
>         iter->st_type =3D st_type;
> +
> +       /* Version symbol table is meaningful to dynsym only */
> +       if (sh_type !=3D SHT_DYNSYM)
> +               return 0;
> +
> +       scn =3D elf_find_next_scn_by_type(elf, SHT_GNU_versym, NULL);
> +       if (!scn)
> +               return 0;
> +       if (!gelf_getshdr(scn, &sh))
> +               return -EINVAL;

we don't seem to use sh, why are we calling gelf_getshdr? sanity check
or something? I dropped it for now, but let me know if I'm missing
something

> +       iter->versyms =3D elf_getdata(scn, 0);
> +
> +       scn =3D elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL);
> +       if (!scn) {
> +               pr_debug("elf: failed to find verdef ELF sections in '%s'=
\n",
> +                        binary_path);
> +               return -ENOENT;
> +       }
> +       if (!gelf_getshdr(scn, &sh))
> +               return -EINVAL;
> +       iter->verdef_strtabidx =3D sh.sh_link;
> +       iter->verdefs =3D elf_getdata(scn, 0);
> +
>         return 0;
>  }
>

[...]

>
>  /* Transform symbol's virtual address (absolute for binaries and relativ=
e
>   * for shared libs) into file offset, which is what kernel is expecting
> @@ -166,7 +277,8 @@ static unsigned long elf_sym_offset(struct elf_sym *s=
ym)
>  long elf_find_func_offset(Elf *elf, const char *binary_path, const char =
*name)
>  {
>         int i, sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
> -       bool is_shared_lib, is_name_qualified;
> +       const char *at_symbol, *lib_ver;
> +       bool is_shared_lib;
>         long ret =3D -ENOENT;
>         size_t name_len;
>         GElf_Ehdr ehdr;
> @@ -179,9 +291,15 @@ long elf_find_func_offset(Elf *elf, const char *bina=
ry_path, const char *name)
>         /* for shared lib case, we do not need to calculate relative offs=
et */
>         is_shared_lib =3D ehdr.e_type =3D=3D ET_DYN;
>
> -       name_len =3D strlen(name);
> -       /* Does name specify "@@LIB"? */
> -       is_name_qualified =3D strstr(name, "@@") !=3D NULL;
> +       /* Does name specify "@@LIB_VER" or "@LIB_VER" ? */
> +       at_symbol =3D strchr(name, '@');
> +       if (at_symbol) {
> +               name_len =3D at_symbol - name;
> +               lib_ver =3D strrchr(name, '@') + 1;

hm... this makes me a bit uneasy. We basically just need to skip extra
@ if it's there. Reverse searching from the end seems both unnecessary
and potentially error prone.

So why not

if (at_symbol[1] =3D=3D '@')
    at_symbol++;
lib_ver =3D at_symbol + 1;

?

This is what I changed it to while applying, but please do let me know
if it's problematic.


> +       } else {
> +               name_len =3D strlen(name);
> +               lib_ver =3D NULL;
> +       }
>
>         /* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is=
 used because if
>          * a binary is stripped, it may only have SHT_DYNSYM, and a fully=
-statically
> @@ -201,13 +319,7 @@ long elf_find_func_offset(Elf *elf, const char *bina=
ry_path, const char *name)
>                         goto out;
>
>                 while ((sym =3D elf_sym_iter_next(&iter))) {
> -                       /* User can specify func, func@@LIB or func@@LIB_=
VERSION. */
> -                       if (strncmp(sym->name, name, name_len) !=3D 0)
> -                               continue;
> -                       /* ...but we don't want a search for "foo" to mat=
ch 'foo2" also, so any
> -                        * additional characters in sname should be of th=
e form "@@LIB".
> -                        */
> -                       if (!is_name_qualified && sym->name[name_len] !=
=3D '\0' && sym->name[name_len] !=3D '@')
> +                       if (!symbol_match(&iter, sh_types[i], sym, name, =
name_len, lib_ver))
>                                 continue;
>
>                         cur_bind =3D GELF_ST_BIND(sym->sym.st_info);
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3a6108e3238b..b4758e54a815 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11630,7 +11630,7 @@ static int attach_uprobe(const struct bpf_program=
 *prog, long cookie, struct bpf
>
>         *link =3D NULL;
>
> -       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.]+%li",
> +       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li"=
,
>                    &probe_type, &binary_path, &func_name, &offset);
>         switch (n) {
>         case 1:
> --
> 2.34.1
>

