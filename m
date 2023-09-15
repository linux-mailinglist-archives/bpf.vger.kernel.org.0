Return-Path: <bpf+bounces-10138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA80E7A1783
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 09:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70AC1C212A3
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E329D296;
	Fri, 15 Sep 2023 07:30:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB276D28C
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 07:30:40 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73177196
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 00:30:33 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-572a7141434so1000537eaf.2
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694763032; x=1695367832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nq1pnHo2zKSL55lOtrnPHYtZvupPN1H9Ghrkr3+cZ4=;
        b=dMrHTJU3k0V2YdiA47pc/IvQ8FB+4JUxjhmy+lpysIMt5ciZCLzNZKGqVdJ1XTMLvj
         sRIpiIu2R4DQZlmpHprW9heFQNVV9n29Prw30INMr3W/7xmh1uwZ8PQutC/3bieXLvlE
         NreyQUwNuL8RImShbX1XHVXzW8HsGKUJxpTVtVUlojO/Cih5/DQ5PpGgM2dRjz7TmfCn
         1uNBcfgpN4vZB2t7yD59TjNqnjVmrLoIGG9InpLJRQt9KDnZZ87Ke6wEHOazB3vu4JDd
         v5V8M/YRQvYE2LMhtiOM02eUFLEYr+pL5o2ryFYZnyLXVd/zx9bbRtKg88UJExxfETxP
         /Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694763032; x=1695367832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nq1pnHo2zKSL55lOtrnPHYtZvupPN1H9Ghrkr3+cZ4=;
        b=WE7UN7WQ+JQ78+24b4+yFrO9A4wcjD2EuVujzTflKcMMHmLupcT/RUXWe/F3iRmqYo
         3uEZ45O268ZTWSseRnyUrHuUyMS5r+duR6AadmN65i6n8O8yxqeSJnhYkzhj+fffOt2v
         e9JbJu/T7HXMxZM4Kw/2zbFzNyFUK6FedqMdjGW8RK7moXc24SqD8y+LMxVrp2vJTiNZ
         16N8g8AOU5vumyyVoY+6C5v62bCTmf5rs2gxrgpwIkXsaOoPQcAQsuDUl+LzJGMqJ62A
         GMFnZnzFnpN5BDwTHCjguWi0qwn4tVdiI0CnLgT0htnefR9oJ4ob4L/qLjXA6aoPzSwj
         Crpg==
X-Gm-Message-State: AOJu0YwpM8sj4xtrWkzQB8hNL44bpUwpJAhEgu5M2hqGxDXpNCNbYdwo
	z68sxJyO8yiMwXHkizEF/9qS6F2br0IEoGGZejw=
X-Google-Smtp-Source: AGHT+IGOTQ0cDzZfNLnuUtd/q/cpYhFm5LkxBs0DoPl63lcNNGRyhFr+7FjUifs67gQhuNcqQmaU3hc4/7lBnyPwv7c=
X-Received: by 2002:a05:6870:9a1c:b0:1be:ccce:7991 with SMTP id
 fo28-20020a0568709a1c00b001beccce7991mr1149529oab.13.1694763032477; Fri, 15
 Sep 2023 00:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911015052.72975-1-hengqi.chen@gmail.com> <20230911015052.72975-3-hengqi.chen@gmail.com>
 <CAEf4BzZxN52J1_Y03QBEL-wSucWZZ1ZGTMKho9FDudf=0X3xvQ@mail.gmail.com>
 <CAEyhmHRFD7KEJwV-CzRSwg4Cw-v=ZqSFrF4UXC-zSthH2OvJPA@mail.gmail.com> <CAEf4BzbJE-S71YLtbBGbdN_MiQNK21Dt6r7hfBxC5uHhWTJD-g@mail.gmail.com>
In-Reply-To: <CAEf4BzbJE-S71YLtbBGbdN_MiQNK21Dt6r7hfBxC5uHhWTJD-g@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Fri, 15 Sep 2023 15:30:21 +0800
Message-ID: <CAEyhmHQcDYvnUkE2EAbhenMYoXai7cC=q5xNgMC3X-+hfx6agw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] libbpf: Support symbol versioning for uprobe
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alan.maguire@oracle.com, olsajiri@gmail.com, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 1:12=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 14, 2023 at 5:37=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.co=
m> wrote:
> >
> > On Wed, Sep 13, 2023 at 7:14=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sun, Sep 10, 2023 at 6:51=E2=80=AFPM Hengqi Chen <hengqi.chen@gmai=
l.com> wrote:
> > > >
> > > > In current implementation, we assume that symbol found in .dynsym s=
ection
> > > > would have a version suffix and use it to compare with symbol user =
supplied.
> > > > According to the spec ([0]), this assumption is incorrect, the vers=
ion info
> > > > of dynamic symbols are stored in .gnu.version and .gnu.version_d se=
ctions
> > > > of ELF objects. For example:
> > > >
> > > >     $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
> > > >     000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
> > > >     000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
> > > >     000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5
> > > >
> > > >     $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep =
rwlock_wrlock
> > > >       706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pth=
read_rwlock_wrlock@GLIBC_2.2.5
> > > >       2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthr=
ead_rwlock_wrlock@@GLIBC_2.34
> > > >       2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthr=
ead_rwlock_wrlock@GLIBC_2.2.5
> > > >
> > > > In this case, specify pthread_rwlock_wrlock@@GLIBC_2.34 or
> > > > pthread_rwlock_wrlock@GLIBC_2.2.5 in bpf_uprobe_opts::func_name won=
't work.
> > > > Because the qualified name does NOT match `pthread_rwlock_wrlock` (=
without
> > > > version suffix) in .dynsym sections.
> > > >
> > > > This commit implements the symbol versioning for dynsym and allows =
user to
> > > > specify symbol in the following forms:
> > > >   - func
> > > >   - func@LIB_VERSION
> > > >   - func@@LIB_VERSION
> > > >
> > > > In case of symbol conflicts, error out and users should resolve it =
by
> > > > specifying a qualified name.
> > > >
> > > >   [0]: https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-gene=
ric/LSB-Core-generic/symversion.html
> > > >
> > > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > ---
> > > >  tools/lib/bpf/elf.c    | 146 +++++++++++++++++++++++++++++++++++++=
----
> > > >  tools/lib/bpf/libbpf.c |   2 +-
> > > >  2 files changed, 134 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > > > index 5c9e588b17da..825da903a34c 100644
> > > > --- a/tools/lib/bpf/elf.c
> > > > +++ b/tools/lib/bpf/elf.c
> > > > @@ -1,5 +1,8 @@
> > > >  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > > >
> > > > +#ifndef _GNU_SOURCE
> > > > +#define _GNU_SOURCE
> > > > +#endif
> > > >  #include <libelf.h>
> > > >  #include <gelf.h>
> > > >  #include <fcntl.h>
> > > > @@ -10,6 +13,17 @@
> > > >
> > > >  #define STRERR_BUFSIZE  128
> > > >
> > > > +/* A SHT_GNU_versym section holds 16-bit words. This bit is set if
> > > > + * the symbol is hidden and can only be seen when referenced using=
 an
> > > > + * explicit version number. This is a GNU extension.
> > > > + */
> > > > +#define VERSYM_HIDDEN  0x8000
> > > > +
> > > > +/* This is the mask for the rest of the data in a word read from a
> > > > + * SHT_GNU_versym section.
> > > > + */
> > > > +#define VERSYM_VERSION 0x7fff
> > > > +
> > > >  int elf_open(const char *binary_path, struct elf_fd *elf_fd)
> > > >  {
> > > >         char errmsg[STRERR_BUFSIZE];
> > > > @@ -64,11 +78,14 @@ struct elf_sym {
> > > >         const char *name;
> > > >         GElf_Sym sym;
> > > >         GElf_Shdr sh;
> > > > +       int ver;
> > > > +       bool hidden;
> > > >  };
> > > >
> > > >  struct elf_sym_iter {
> > > >         Elf *elf;
> > > >         Elf_Data *syms;
> > > > +       Elf_Data *versyms;
> > > >         size_t nr_syms;
> > > >         size_t strtabidx;
> > > >         size_t next_sym_idx;
> > > > @@ -111,6 +128,18 @@ static int elf_sym_iter_new(struct elf_sym_ite=
r *iter,
> > > >         iter->nr_syms =3D iter->syms->d_size / sh.sh_entsize;
> > > >         iter->elf =3D elf;
> > > >         iter->st_type =3D st_type;
> > > > +
> > > > +       /* Version symbol table is meaningful to dynsym only */
> > > > +       if (sh_type !=3D SHT_DYNSYM)
> > > > +               return 0;
> > > > +
> > > > +       scn =3D elf_find_next_scn_by_type(elf, SHT_GNU_versym, NULL=
);
> > > > +       if (!scn)
> > > > +               return 0;
> > > > +       if (!gelf_getshdr(scn, &sh))
> > > > +               return -EINVAL;
> > > > +       iter->versyms =3D elf_getdata(scn, 0);
> > > > +
> > > >         return 0;
> > > >  }
> > > >
> > > > @@ -119,6 +148,7 @@ static struct elf_sym *elf_sym_iter_next(struct=
 elf_sym_iter *iter)
> > > >         struct elf_sym *ret =3D &iter->sym;
> > > >         GElf_Sym *sym =3D &ret->sym;
> > > >         const char *name =3D NULL;
> > > > +       GElf_Versym versym;
> > > >         Elf_Scn *sym_scn;
> > > >         size_t idx;
> > > >
> > > > @@ -138,12 +168,113 @@ static struct elf_sym *elf_sym_iter_next(str=
uct elf_sym_iter *iter)
> > > >
> > > >                 iter->next_sym_idx =3D idx + 1;
> > > >                 ret->name =3D name;
> > > > +               ret->ver =3D 0;
> > > > +               ret->hidden =3D false;
> > > > +
> > > > +               if (iter->versyms) {
> > > > +                       if (!gelf_getversym(iter->versyms, idx, &ve=
rsym))
> > > > +                               continue;
> > > > +                       ret->ver =3D versym & VERSYM_VERSION;
> > > > +                       ret->hidden =3D versym & VERSYM_HIDDEN;
> > > > +               }
> > > >                 return ret;
> > > >         }
> > > >
> > > >         return NULL;
> > > >  }
> > > >
> > > > +static const char *elf_get_vername(Elf *elf, int ver)
> > > > +{
> > > > +       GElf_Verdaux verdaux;
> > > > +       GElf_Verdef verdef;
> > > > +       Elf_Data *verdefs;
> > > > +       size_t strtabidx;
> > > > +       GElf_Shdr sh;
> > > > +       Elf_Scn *scn;
> > > > +       int offset;
> > > > +
> > > > +       scn =3D elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL=
);
> > >
> > > so this is a linear search, right? And we'll be doing it for every
> > > .dynsym symbol. Let's do this once at the creation time and remember =
a
> > > pointer inside struct Elf?
> > >
> >
> > We reach here only when the symbol part match, and likely we get the
> > desired one.
>
> sure, but you can have multiple versions, so multiple hits of this.
> And the ELF itself could be pretty big with lots of sections. So I
> think we should try to minimize number of linear searches over ELF
> sections, if possible.
>
> > if we store the pointers in struct Elf, then we have to involve
> > dynamic allocations.
>
> I'm not sure why dynamic allocations are needed?
>

Your last comment says remember those version name pointer in struct Elf,
I thought this would be allocate an array and save those pointers
(i.e. store a mapping from version index to version name)

> But also I had struct elf_sym_iter in mind, where we already cache
> Elf_Data *versyms, so why not do that with verdefs as well? I think

verdef is not per symbol.

> all these helpers (symbol_match and elf_get_vername) are called only
> from elf_sym_iter stuff right now, right?
>
>
> >
> > > > +       if (!scn)
> > > > +               return NULL;
> > > > +       if (!gelf_getshdr(scn, &sh))
> > > > +               return NULL;
> > > > +       strtabidx =3D sh.sh_link;
> > > > +       verdefs =3D  elf_getdata(scn, 0);
> > > > +
> > > > +       offset =3D 0;
> > > > +       while (gelf_getverdef(verdefs, offset, &verdef)) {
> > > > +               if (verdef.vd_ndx !=3D ver) {
> > > > +                       if (!verdef.vd_next)
> > > > +                               break;
> > > > +
> > > > +                       offset +=3D verdef.vd_next;
> > > > +                       continue;
> > > > +               }
> > > > +
> > > > +               if (!gelf_getverdaux(verdefs, offset + verdef.vd_au=
x, &verdaux))
> > > > +                       break;
> > > > +
> > > > +               return elf_strptr(elf, strtabidx, verdaux.vda_name)=
;
> > > > +
> > > > +       }
> > > > +       return NULL;
> > > > +}
> > > > +
> > > > +static bool symbol_match(Elf *elf, int sh_type, struct elf_sym *sy=
m, const char *name)
> > > > +{
> > > > +       size_t name_len, sname_len;
> > > > +       bool is_name_qualified;
> > > > +       const char *ver;
> > > > +       char *sname;
> > > > +       int ret;
> > > > +
> > > > +       name_len =3D strlen(name);
> > > > +       /* Does name specify "@LIB" or "@@LIB" ? */
> > > > +       is_name_qualified =3D strstr(name, "@") !=3D NULL;
> > > > +
> > > > +       /* If user specify a qualified name, for dynamic symbol,
> > > > +        * it is in form of func, NOT func@LIB_VER or func@@LIB_VER=
.
> > > > +        * So construct a full quailified symbol name using versym =
info
> > >
> > > gmail points out typo: qualified
> > >
> > > > +        * for comparison.
> > > > +        */
> > > > +       if (is_name_qualified && sh_type =3D=3D SHT_DYNSYM) {
> > > > +               /* Make sure func match func@LIB_VER */
> > > > +               sname_len =3D strlen(sym->name);
> > > > +               if (strncmp(sym->name, name, sname_len) !=3D 0)
> > > > +                       return false;
> > > > +
> > > > +               /* But not func2@LIB_VER */
> > > > +               if (name[sname_len] !=3D '@')
> > > > +                       return false;
> > > > +
> > > > +               ver =3D elf_get_vername(elf, sym->ver);
> > > > +               if (!ver)
> > > > +                       return false;
> > > > +
> > > > +               ret =3D asprintf(&sname, "%s%s%s", sym->name,
> > > > +                              sym->hidden ? "@" : "@@", ver);
> > > > +               if (ret =3D=3D -1)
> > >
> > > nit: ret < 0, I've spent enough time switching all users of libbpf to
> > > not rely on exact -1 return, let's not show a bad example ;)
> > >
> > > > +                       return false;
> > > > +
> > > > +               sname_len =3D ret;
> > > > +               ret =3D strncmp(sname, name, sname_len);
> > >
> > > why is this strncmp? shouldn't the match be exact? both name is
> > > version-qualified, and current ELF symbol is version-qualified. They
> > > have to exactly match, no?
> > >
> > > > +               free(sname);
> > > > +               return ret =3D=3D 0;
> > > > +       }
> > > > +
> > > > +       /* Otherwise, for normal symbols or non-qualified names
> > > > +        * User can specify func, func@@LIB or func@@LIB_VERSION.
> > > > +        */
> > > > +       if (strncmp(sym->name, name, name_len) !=3D 0)
> > > > +               return false;
> > > > +       /* ...but we don't want a search for "foo" to match 'foo2" =
also, so any
> > > > +        * additional characters in sname should be of the form "@L=
IB" or "@@LIB".
> > > > +        */
> > > > +       if (!is_name_qualified && sym->name[name_len] !=3D '\0' && =
sym->name[name_len] !=3D '@')
> > > > +               return false;
> > > > +
> > > > +       return true;
> > > > +}
> > > >
> > > >  /* Transform symbol's virtual address (absolute for binaries and r=
elative
> > > >   * for shared libs) into file offset, which is what kernel is expe=
cting
> > > > @@ -166,9 +297,8 @@ static unsigned long elf_sym_offset(struct elf_=
sym *sym)
> > > >  long elf_find_func_offset(Elf *elf, const char *binary_path, const=
 char *name)
> > > >  {
> > > >         int i, sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
> > > > -       bool is_shared_lib, is_name_qualified;
> > > > +       bool is_shared_lib;
> > > >         long ret =3D -ENOENT;
> > > > -       size_t name_len;
> > > >         GElf_Ehdr ehdr;
> > > >
> > > >         if (!gelf_getehdr(elf, &ehdr)) {
> > > > @@ -179,10 +309,6 @@ long elf_find_func_offset(Elf *elf, const char=
 *binary_path, const char *name)
> > > >         /* for shared lib case, we do not need to calculate relativ=
e offset */
> > > >         is_shared_lib =3D ehdr.e_type =3D=3D ET_DYN;
> > > >
> > > > -       name_len =3D strlen(name);
> > > > -       /* Does name specify "@@LIB"? */
> > > > -       is_name_qualified =3D strstr(name, "@@") !=3D NULL;
> > > > -
> > > >         /* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search or=
der is used because if
> > > >          * a binary is stripped, it may only have SHT_DYNSYM, and a=
 fully-statically
> > > >          * linked binary may not have SHT_DYMSYM, so absence of a s=
ection should not be
> > > > @@ -201,13 +327,7 @@ long elf_find_func_offset(Elf *elf, const char=
 *binary_path, const char *name)
> > > >                         goto out;
> > > >
> > > >                 while ((sym =3D elf_sym_iter_next(&iter))) {
> > > > -                       /* User can specify func, func@@LIB or func=
@@LIB_VERSION. */
> > > > -                       if (strncmp(sym->name, name, name_len) !=3D=
 0)
> > > > -                               continue;
> > > > -                       /* ...but we don't want a search for "foo" =
to match 'foo2" also, so any
> > > > -                        * additional characters in sname should be=
 of the form "@@LIB".
> > > > -                        */
> > > > -                       if (!is_name_qualified && sym->name[name_le=
n] !=3D '\0' && sym->name[name_len] !=3D '@')
> > > > +                       if (!symbol_match(elf, sh_types[i], sym, na=
me))
> > >
> > > ok, so let's consider what we are doing here. While previously we did
> > > a relatively expensive strstr() operation once, now we are doing it
> > > for every symbol in ELF. This might add up.
> > >
> > > Plus, we then do dynamic allocations with asprintf, which also is kin=
d
> > > of unfortunate.
> > >
> > > But let's take a step back. Why we don't determine if the name is
> > > qualified once. Remember what is the length of unqualified name, wher=
e
> > > does the version part starts, and pass all that to symbol_match in a
> > > prepared form. Then we don't need to construct "fully qualified" form
> > > of an ELF symbol. We can compare unqual name and version name
> > > separately.
> > >
> > > No allocation, no wasted work.
> > >
> > > Not sure if we need to care whether we had "@" or "@@" in the
> > > requested symbol, but that's a detail.
> > >
> >
> > Sounds good, will do.
> >
> > > >                                 continue;
> > > >
> > > >                         cur_bind =3D GELF_ST_BIND(sym->sym.st_info)=
;
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index 96ff1aa4bf6a..30b8f96820a7 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -11512,7 +11512,7 @@ static int attach_uprobe(const struct bpf_p=
rogram *prog, long cookie, struct bpf
> > > >
> > > >         *link =3D NULL;
> > > >
> > > > -       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.]=
+%li",
> > > > +       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@=
]+%li",
> > >
> > > BTW, while you are at it. Arnaldo was trying to use this SEC("uprobe"=
)
> > > stuff for tracing Go functions. Go doesn't seem to do any mangling, s=
o
> > > function names can have lots of "interesting" symbols ([], @, etc).
> > >
> >
> > Go symbols are complicated, I will try in another patch.
>
> indeed, thanks!
>
> >
> > > If you get a chance, would you mind updating this partsing logic to b=
e
> > > able to accommodate such crazy function names as well? Thanks!
> > >
> > > >                    &probe_type, &binary_path, &func_name, &offset);
> > > >         switch (n) {
> > > >         case 1:
> > > > --
> > > > 2.34.1
> > > >
> >
> > Cheers,
> > ---
> > Hengqi

