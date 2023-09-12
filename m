Return-Path: <bpf+bounces-9820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8744179DC84
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759E01C21271
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2B0C121;
	Tue, 12 Sep 2023 23:14:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9217C2
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:14:48 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627D110F7
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:14:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99de884ad25so806104966b.3
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694560486; x=1695165286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyE1OIosoPlNDf3rXHZeEZYmFFt+wi39r4eIHh+o+6Y=;
        b=anfPKiMtLXk/zRO9sRV7qGhFngRCc0Bvlk6/s9B1TsPFq0UiUecP4uY/jXd/QKnQcT
         Fb+ym8PD+nyy6W6M1g9BGXlxXCPDjRNGLFOXG6BY9Rh0ppOLATAYZ0AQa24+DSezxDdR
         11h7YNR3jcNvJMYgsQf+d95FybU0CpBk1UoVHt5v20AgvaC+HnZ9jUS0SMJvSQxNf4OV
         rie8k0ye/M8VDStFE7TLfrceIAE0jlm6r6qB8Dt+lb44NGx2YpPAc5S87yDM6xyYe94q
         YqGl0luiYVSPlyzjn9PVltp4Mbx8BhGdoIdQ/Oh74iq4V127bb57z9yvQjfW0ssnL1PC
         mgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694560486; x=1695165286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyE1OIosoPlNDf3rXHZeEZYmFFt+wi39r4eIHh+o+6Y=;
        b=Zyvn0GsvrCZinbfnrxglFF0Ife+Nf1nQPBxCha3kzK092a1KJKOK1lNSznkx73XqbS
         PidwamhB5Gy7lOHBjsgNsPLUBrf4oWszjfacS6IJNQrDbmsRzegTKjRsJLr2MJTRpCL2
         apNEsceEJeQow8Bs2cfu1bG6En5PWo6a4siTtWuEJOZAc0R4ax5X7qqk56qXxfc1vRcE
         V7EOtpPLgoQ7dQGPTzD2dP/tZpplM5Q9mO2DzSLXtoCsb2WlXy8JCU5teKtMFD+ia4h0
         fnVxHr5OP93qrxTS+hm3JiDKvjVlUkmIeJXWqu40Kt169F9wQ6xnMKIfGPFu09kdXIj8
         anJw==
X-Gm-Message-State: AOJu0Yyo59vBcYa4wsKL3Ypq+k0yN7uc3kn8tVf+fJmZ7taSwhQd2xMD
	NwMLUJ6auhNSW6C3cnVL/cDrKw9/CEE3QhAy+z4=
X-Google-Smtp-Source: AGHT+IEjWpCC4nfYSfJLJWSKR8EED1qRGn2abPM4cGLMtSTwnycjBA22H1dyP8hnnoviXEp0qBMJ/tiqIqDHYHK+jto=
X-Received: by 2002:a17:906:cd1:b0:9a1:f3a6:b906 with SMTP id
 l17-20020a1709060cd100b009a1f3a6b906mr466658ejh.36.1694560485487; Tue, 12 Sep
 2023 16:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911015052.72975-1-hengqi.chen@gmail.com> <20230911015052.72975-3-hengqi.chen@gmail.com>
In-Reply-To: <20230911015052.72975-3-hengqi.chen@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Sep 2023 16:14:33 -0700
Message-ID: <CAEf4BzZxN52J1_Y03QBEL-wSucWZZ1ZGTMKho9FDudf=0X3xvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] libbpf: Support symbol versioning for uprobe
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alan.maguire@oracle.com, olsajiri@gmail.com, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 10, 2023 at 6:51=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
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
>  tools/lib/bpf/elf.c    | 146 +++++++++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf.c |   2 +-
>  2 files changed, 134 insertions(+), 14 deletions(-)
>
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 5c9e588b17da..825da903a34c 100644
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
> @@ -64,11 +78,14 @@ struct elf_sym {
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
>         size_t nr_syms;
>         size_t strtabidx;
>         size_t next_sym_idx;
> @@ -111,6 +128,18 @@ static int elf_sym_iter_new(struct elf_sym_iter *ite=
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
> +       iter->versyms =3D elf_getdata(scn, 0);
> +
>         return 0;
>  }
>
> @@ -119,6 +148,7 @@ static struct elf_sym *elf_sym_iter_next(struct elf_s=
ym_iter *iter)
>         struct elf_sym *ret =3D &iter->sym;
>         GElf_Sym *sym =3D &ret->sym;
>         const char *name =3D NULL;
> +       GElf_Versym versym;
>         Elf_Scn *sym_scn;
>         size_t idx;
>
> @@ -138,12 +168,113 @@ static struct elf_sym *elf_sym_iter_next(struct el=
f_sym_iter *iter)
>
>                 iter->next_sym_idx =3D idx + 1;
>                 ret->name =3D name;
> +               ret->ver =3D 0;
> +               ret->hidden =3D false;
> +
> +               if (iter->versyms) {
> +                       if (!gelf_getversym(iter->versyms, idx, &versym))
> +                               continue;
> +                       ret->ver =3D versym & VERSYM_VERSION;
> +                       ret->hidden =3D versym & VERSYM_HIDDEN;
> +               }
>                 return ret;
>         }
>
>         return NULL;
>  }
>
> +static const char *elf_get_vername(Elf *elf, int ver)
> +{
> +       GElf_Verdaux verdaux;
> +       GElf_Verdef verdef;
> +       Elf_Data *verdefs;
> +       size_t strtabidx;
> +       GElf_Shdr sh;
> +       Elf_Scn *scn;
> +       int offset;
> +
> +       scn =3D elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL);

so this is a linear search, right? And we'll be doing it for every
.dynsym symbol. Let's do this once at the creation time and remember a
pointer inside struct Elf?

> +       if (!scn)
> +               return NULL;
> +       if (!gelf_getshdr(scn, &sh))
> +               return NULL;
> +       strtabidx =3D sh.sh_link;
> +       verdefs =3D  elf_getdata(scn, 0);
> +
> +       offset =3D 0;
> +       while (gelf_getverdef(verdefs, offset, &verdef)) {
> +               if (verdef.vd_ndx !=3D ver) {
> +                       if (!verdef.vd_next)
> +                               break;
> +
> +                       offset +=3D verdef.vd_next;
> +                       continue;
> +               }
> +
> +               if (!gelf_getverdaux(verdefs, offset + verdef.vd_aux, &ve=
rdaux))
> +                       break;
> +
> +               return elf_strptr(elf, strtabidx, verdaux.vda_name);
> +
> +       }
> +       return NULL;
> +}
> +
> +static bool symbol_match(Elf *elf, int sh_type, struct elf_sym *sym, con=
st char *name)
> +{
> +       size_t name_len, sname_len;
> +       bool is_name_qualified;
> +       const char *ver;
> +       char *sname;
> +       int ret;
> +
> +       name_len =3D strlen(name);
> +       /* Does name specify "@LIB" or "@@LIB" ? */
> +       is_name_qualified =3D strstr(name, "@") !=3D NULL;
> +
> +       /* If user specify a qualified name, for dynamic symbol,
> +        * it is in form of func, NOT func@LIB_VER or func@@LIB_VER.
> +        * So construct a full quailified symbol name using versym info

gmail points out typo: qualified

> +        * for comparison.
> +        */
> +       if (is_name_qualified && sh_type =3D=3D SHT_DYNSYM) {
> +               /* Make sure func match func@LIB_VER */
> +               sname_len =3D strlen(sym->name);
> +               if (strncmp(sym->name, name, sname_len) !=3D 0)
> +                       return false;
> +
> +               /* But not func2@LIB_VER */
> +               if (name[sname_len] !=3D '@')
> +                       return false;
> +
> +               ver =3D elf_get_vername(elf, sym->ver);
> +               if (!ver)
> +                       return false;
> +
> +               ret =3D asprintf(&sname, "%s%s%s", sym->name,
> +                              sym->hidden ? "@" : "@@", ver);
> +               if (ret =3D=3D -1)

nit: ret < 0, I've spent enough time switching all users of libbpf to
not rely on exact -1 return, let's not show a bad example ;)

> +                       return false;
> +
> +               sname_len =3D ret;
> +               ret =3D strncmp(sname, name, sname_len);

why is this strncmp? shouldn't the match be exact? both name is
version-qualified, and current ELF symbol is version-qualified. They
have to exactly match, no?

> +               free(sname);
> +               return ret =3D=3D 0;
> +       }
> +
> +       /* Otherwise, for normal symbols or non-qualified names
> +        * User can specify func, func@@LIB or func@@LIB_VERSION.
> +        */
> +       if (strncmp(sym->name, name, name_len) !=3D 0)
> +               return false;
> +       /* ...but we don't want a search for "foo" to match 'foo2" also, =
so any
> +        * additional characters in sname should be of the form "@LIB" or=
 "@@LIB".
> +        */
> +       if (!is_name_qualified && sym->name[name_len] !=3D '\0' && sym->n=
ame[name_len] !=3D '@')
> +               return false;
> +
> +       return true;
> +}
>
>  /* Transform symbol's virtual address (absolute for binaries and relativ=
e
>   * for shared libs) into file offset, which is what kernel is expecting
> @@ -166,9 +297,8 @@ static unsigned long elf_sym_offset(struct elf_sym *s=
ym)
>  long elf_find_func_offset(Elf *elf, const char *binary_path, const char =
*name)
>  {
>         int i, sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
> -       bool is_shared_lib, is_name_qualified;
> +       bool is_shared_lib;
>         long ret =3D -ENOENT;
> -       size_t name_len;
>         GElf_Ehdr ehdr;
>
>         if (!gelf_getehdr(elf, &ehdr)) {
> @@ -179,10 +309,6 @@ long elf_find_func_offset(Elf *elf, const char *bina=
ry_path, const char *name)
>         /* for shared lib case, we do not need to calculate relative offs=
et */
>         is_shared_lib =3D ehdr.e_type =3D=3D ET_DYN;
>
> -       name_len =3D strlen(name);
> -       /* Does name specify "@@LIB"? */
> -       is_name_qualified =3D strstr(name, "@@") !=3D NULL;
> -
>         /* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is=
 used because if
>          * a binary is stripped, it may only have SHT_DYNSYM, and a fully=
-statically
>          * linked binary may not have SHT_DYMSYM, so absence of a section=
 should not be
> @@ -201,13 +327,7 @@ long elf_find_func_offset(Elf *elf, const char *bina=
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
> +                       if (!symbol_match(elf, sh_types[i], sym, name))

ok, so let's consider what we are doing here. While previously we did
a relatively expensive strstr() operation once, now we are doing it
for every symbol in ELF. This might add up.

Plus, we then do dynamic allocations with asprintf, which also is kind
of unfortunate.

But let's take a step back. Why we don't determine if the name is
qualified once. Remember what is the length of unqualified name, where
does the version part starts, and pass all that to symbol_match in a
prepared form. Then we don't need to construct "fully qualified" form
of an ELF symbol. We can compare unqual name and version name
separately.

No allocation, no wasted work.

Not sure if we need to care whether we had "@" or "@@" in the
requested symbol, but that's a detail.

>                                 continue;
>
>                         cur_bind =3D GELF_ST_BIND(sym->sym.st_info);
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 96ff1aa4bf6a..30b8f96820a7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11512,7 +11512,7 @@ static int attach_uprobe(const struct bpf_program=
 *prog, long cookie, struct bpf
>
>         *link =3D NULL;
>
> -       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.]+%li",
> +       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li"=
,

BTW, while you are at it. Arnaldo was trying to use this SEC("uprobe")
stuff for tracing Go functions. Go doesn't seem to do any mangling, so
function names can have lots of "interesting" symbols ([], @, etc).

If you get a chance, would you mind updating this partsing logic to be
able to accommodate such crazy function names as well? Thanks!

>                    &probe_type, &binary_path, &func_name, &offset);
>         switch (n) {
>         case 1:
> --
> 2.34.1
>

