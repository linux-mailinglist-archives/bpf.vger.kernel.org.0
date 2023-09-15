Return-Path: <bpf+bounces-10182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D69AC7A27F8
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 22:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F841C20F4A
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7A1B27B;
	Fri, 15 Sep 2023 20:21:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786918E09
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 20:20:58 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31B33586
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 13:20:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2366188f8f.0
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 13:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694809215; x=1695414015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4O3JffxhKgOfvrINGNFbjXtPsgq7PwScJvi2qUbCcg=;
        b=ckGmwD3GH7J1F+3GRPCiCP+8OFZA80GEEGsTwA/j9Mv1coKYqdTcBsOLQM876JIRWV
         I8gm03iXxcWUk8K9w0oUtjqfA20vyuW/CBPHcivfS545MW/jY6JBoyeLdsCbHa/B1yy7
         W0DH1gsPBt4hk24qUwJZB7miQJtVM2XWAYkvpnViMN17ytjhK9kroXeDUoD4coELa5jw
         kRg30yaNK4b2dcYRZRomDdqvwZNGGkPO9BV/SP+5cz+RnHP3nk/kbpFzvNu8v4cClwUo
         HXjOKzhGbZUn5cj7NMxKEmIgj3Rn+Y6q18lDLddNPx5t/z88RYR3Ct+HNypjJ+RPjTxh
         XGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694809215; x=1695414015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4O3JffxhKgOfvrINGNFbjXtPsgq7PwScJvi2qUbCcg=;
        b=BAuEdodM1F2ad+LJ825KwMLEwwYxBxrCFuJ6oCGBJmmDcSQA9VGQcBZG35KqwEQblW
         WV/eRAAwpntQ3+/DremAg9f+kY9TglNuTnO5xm2wlyOsEOmjj3cAae0/Zv5cs1SC2eB3
         ldABUAeSljR8yb6JL9ZWW9xkBfwLeM6JBk11wxuw6ACvOoTPeJNKbmdRAfvcN/KAJz33
         aVGJzXAwTkCQXExmR5aJT7wJUQcaMsFlQLRobTp1UToja+v1DrZbMr6zjf6gowb6M1cc
         D5cvrpqXjEEffP3PhYwDFuEGqXI6htOO7pwJmLPTPQxDqnBId4Cm9gfk+vPQ5n2ew3H8
         4CNg==
X-Gm-Message-State: AOJu0Yw/bQy6f78vhBcV2SW44YqDFzkky7U3WQ01V5yHv/UUGeNnIyA+
	9NUrt3Wk8GkOcLQiloAP3KMkfjup3J2P/NdVxQA=
X-Google-Smtp-Source: AGHT+IFy1ywIdB7yAhq8Cpdqi3SQprowYNBMujA2fWd1239A73IpZ+5Mz4vyTW34vlVyiEbhaS5y2Fg5VLpk4/DBRoY=
X-Received: by 2002:a05:6000:70e:b0:31f:f94f:e13f with SMTP id
 bs14-20020a056000070e00b0031ff94fe13fmr1933632wrb.19.1694809214739; Fri, 15
 Sep 2023 13:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911015052.72975-1-hengqi.chen@gmail.com> <20230911015052.72975-3-hengqi.chen@gmail.com>
 <CAEf4BzZxN52J1_Y03QBEL-wSucWZZ1ZGTMKho9FDudf=0X3xvQ@mail.gmail.com>
 <CAEyhmHRFD7KEJwV-CzRSwg4Cw-v=ZqSFrF4UXC-zSthH2OvJPA@mail.gmail.com>
 <CAEf4BzbJE-S71YLtbBGbdN_MiQNK21Dt6r7hfBxC5uHhWTJD-g@mail.gmail.com> <CAEyhmHQcDYvnUkE2EAbhenMYoXai7cC=q5xNgMC3X-+hfx6agw@mail.gmail.com>
In-Reply-To: <CAEyhmHQcDYvnUkE2EAbhenMYoXai7cC=q5xNgMC3X-+hfx6agw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Sep 2023 13:20:03 -0700
Message-ID: <CAEf4BzZ=RoEQkVy6b4uW4Bi8xnx6TimJ8=hYLJVVq8reLkus4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] libbpf: Support symbol versioning for uprobe
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alan.maguire@oracle.com, olsajiri@gmail.com, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 12:30=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
>
> On Fri, Sep 15, 2023 at 1:12=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Sep 14, 2023 at 5:37=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.=
com> wrote:
> > >
> > > On Wed, Sep 13, 2023 at 7:14=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Sun, Sep 10, 2023 at 6:51=E2=80=AFPM Hengqi Chen <hengqi.chen@gm=
ail.com> wrote:
> > > > >
> > > > > In current implementation, we assume that symbol found in .dynsym=
 section
> > > > > would have a version suffix and use it to compare with symbol use=
r supplied.
> > > > > According to the spec ([0]), this assumption is incorrect, the ve=
rsion info
> > > > > of dynamic symbols are stored in .gnu.version and .gnu.version_d =
sections
> > > > > of ELF objects. For example:
> > > > >
> > > > >     $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
> > > > >     000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
> > > > >     000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
> > > > >     000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5
> > > > >
> > > > >     $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | gre=
p rwlock_wrlock
> > > > >       706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __p=
thread_rwlock_wrlock@GLIBC_2.2.5
> > > > >       2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pt=
hread_rwlock_wrlock@@GLIBC_2.34
> > > > >       2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pt=
hread_rwlock_wrlock@GLIBC_2.2.5
> > > > >
> > > > > In this case, specify pthread_rwlock_wrlock@@GLIBC_2.34 or
> > > > > pthread_rwlock_wrlock@GLIBC_2.2.5 in bpf_uprobe_opts::func_name w=
on't work.
> > > > > Because the qualified name does NOT match `pthread_rwlock_wrlock`=
 (without
> > > > > version suffix) in .dynsym sections.
> > > > >
> > > > > This commit implements the symbol versioning for dynsym and allow=
s user to
> > > > > specify symbol in the following forms:
> > > > >   - func
> > > > >   - func@LIB_VERSION
> > > > >   - func@@LIB_VERSION
> > > > >
> > > > > In case of symbol conflicts, error out and users should resolve i=
t by
> > > > > specifying a qualified name.
> > > > >
> > > > >   [0]: https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-ge=
neric/LSB-Core-generic/symversion.html
> > > > >
> > > > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > > > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > > ---
> > > > >  tools/lib/bpf/elf.c    | 146 +++++++++++++++++++++++++++++++++++=
++----
> > > > >  tools/lib/bpf/libbpf.c |   2 +-
> > > > >  2 files changed, 134 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > > > > index 5c9e588b17da..825da903a34c 100644
> > > > > --- a/tools/lib/bpf/elf.c
> > > > > +++ b/tools/lib/bpf/elf.c
> > > > > @@ -1,5 +1,8 @@
> > > > >  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > > > >
> > > > > +#ifndef _GNU_SOURCE
> > > > > +#define _GNU_SOURCE
> > > > > +#endif
> > > > >  #include <libelf.h>
> > > > >  #include <gelf.h>
> > > > >  #include <fcntl.h>
> > > > > @@ -10,6 +13,17 @@
> > > > >
> > > > >  #define STRERR_BUFSIZE  128
> > > > >
> > > > > +/* A SHT_GNU_versym section holds 16-bit words. This bit is set =
if
> > > > > + * the symbol is hidden and can only be seen when referenced usi=
ng an
> > > > > + * explicit version number. This is a GNU extension.
> > > > > + */
> > > > > +#define VERSYM_HIDDEN  0x8000
> > > > > +
> > > > > +/* This is the mask for the rest of the data in a word read from=
 a
> > > > > + * SHT_GNU_versym section.
> > > > > + */
> > > > > +#define VERSYM_VERSION 0x7fff
> > > > > +
> > > > >  int elf_open(const char *binary_path, struct elf_fd *elf_fd)
> > > > >  {
> > > > >         char errmsg[STRERR_BUFSIZE];
> > > > > @@ -64,11 +78,14 @@ struct elf_sym {
> > > > >         const char *name;
> > > > >         GElf_Sym sym;
> > > > >         GElf_Shdr sh;
> > > > > +       int ver;
> > > > > +       bool hidden;
> > > > >  };
> > > > >
> > > > >  struct elf_sym_iter {
> > > > >         Elf *elf;
> > > > >         Elf_Data *syms;
> > > > > +       Elf_Data *versyms;
> > > > >         size_t nr_syms;
> > > > >         size_t strtabidx;
> > > > >         size_t next_sym_idx;
> > > > > @@ -111,6 +128,18 @@ static int elf_sym_iter_new(struct elf_sym_i=
ter *iter,
> > > > >         iter->nr_syms =3D iter->syms->d_size / sh.sh_entsize;
> > > > >         iter->elf =3D elf;
> > > > >         iter->st_type =3D st_type;
> > > > > +
> > > > > +       /* Version symbol table is meaningful to dynsym only */
> > > > > +       if (sh_type !=3D SHT_DYNSYM)
> > > > > +               return 0;
> > > > > +
> > > > > +       scn =3D elf_find_next_scn_by_type(elf, SHT_GNU_versym, NU=
LL);
> > > > > +       if (!scn)
> > > > > +               return 0;
> > > > > +       if (!gelf_getshdr(scn, &sh))
> > > > > +               return -EINVAL;
> > > > > +       iter->versyms =3D elf_getdata(scn, 0);
> > > > > +
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > @@ -119,6 +148,7 @@ static struct elf_sym *elf_sym_iter_next(stru=
ct elf_sym_iter *iter)
> > > > >         struct elf_sym *ret =3D &iter->sym;
> > > > >         GElf_Sym *sym =3D &ret->sym;
> > > > >         const char *name =3D NULL;
> > > > > +       GElf_Versym versym;
> > > > >         Elf_Scn *sym_scn;
> > > > >         size_t idx;
> > > > >
> > > > > @@ -138,12 +168,113 @@ static struct elf_sym *elf_sym_iter_next(s=
truct elf_sym_iter *iter)
> > > > >
> > > > >                 iter->next_sym_idx =3D idx + 1;
> > > > >                 ret->name =3D name;
> > > > > +               ret->ver =3D 0;
> > > > > +               ret->hidden =3D false;
> > > > > +
> > > > > +               if (iter->versyms) {
> > > > > +                       if (!gelf_getversym(iter->versyms, idx, &=
versym))
> > > > > +                               continue;
> > > > > +                       ret->ver =3D versym & VERSYM_VERSION;
> > > > > +                       ret->hidden =3D versym & VERSYM_HIDDEN;
> > > > > +               }
> > > > >                 return ret;
> > > > >         }
> > > > >
> > > > >         return NULL;
> > > > >  }
> > > > >
> > > > > +static const char *elf_get_vername(Elf *elf, int ver)
> > > > > +{
> > > > > +       GElf_Verdaux verdaux;
> > > > > +       GElf_Verdef verdef;
> > > > > +       Elf_Data *verdefs;
> > > > > +       size_t strtabidx;
> > > > > +       GElf_Shdr sh;
> > > > > +       Elf_Scn *scn;
> > > > > +       int offset;
> > > > > +
> > > > > +       scn =3D elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NU=
LL);
> > > >
> > > > so this is a linear search, right? And we'll be doing it for every
> > > > .dynsym symbol. Let's do this once at the creation time and remembe=
r a
> > > > pointer inside struct Elf?
> > > >
> > >
> > > We reach here only when the symbol part match, and likely we get the
> > > desired one.
> >
> > sure, but you can have multiple versions, so multiple hits of this.
> > And the ELF itself could be pretty big with lots of sections. So I
> > think we should try to minimize number of linear searches over ELF
> > sections, if possible.
> >
> > > if we store the pointers in struct Elf, then we have to involve
> > > dynamic allocations.
> >
> > I'm not sure why dynamic allocations are needed?
> >
>
> Your last comment says remember those version name pointer in struct Elf,
> I thought this would be allocate an array and save those pointers
> (i.e. store a mapping from version index to version name)
>
> > But also I had struct elf_sym_iter in mind, where we already cache
> > Elf_Data *versyms, so why not do that with verdefs as well? I think
>
> verdef is not per symbol.

I meant to just not do elf_find_next_scn_by_type() search every time,
and just store Elf_Scn * pointer for SHT_GNU_verdef in iter state.


>
> > all these helpers (symbol_match and elf_get_vername) are called only
> > from elf_sym_iter stuff right now, right?
> >
> >
> > >
> > > > > +       if (!scn)
> > > > > +               return NULL;
> > > > > +       if (!gelf_getshdr(scn, &sh))
> > > > > +               return NULL;
> > > > > +       strtabidx =3D sh.sh_link;
> > > > > +       verdefs =3D  elf_getdata(scn, 0);
> > > > > +
> > > > > +       offset =3D 0;
> > > > > +       while (gelf_getverdef(verdefs, offset, &verdef)) {
> > > > > +               if (verdef.vd_ndx !=3D ver) {
> > > > > +                       if (!verdef.vd_next)
> > > > > +                               break;
> > > > > +
> > > > > +                       offset +=3D verdef.vd_next;
> > > > > +                       continue;
> > > > > +               }
> > > > > +
> > > > > +               if (!gelf_getverdaux(verdefs, offset + verdef.vd_=
aux, &verdaux))
> > > > > +                       break;
> > > > > +
> > > > > +               return elf_strptr(elf, strtabidx, verdaux.vda_nam=
e);
> > > > > +
> > > > > +       }
> > > > > +       return NULL;
> > > > > +}

[...]

