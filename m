Return-Path: <bpf+bounces-3287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E387A73BC86
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 18:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2991C21288
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE91100B6;
	Fri, 23 Jun 2023 16:27:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41826100A6
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 16:27:33 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75B018B
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:27:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f9c0abc8b1so10339915e9.1
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687537650; x=1690129650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N4JlccHakKrLPQ1lY3+HAUHCI52VAp5ISn02l+oVFQ=;
        b=qrVgIJTR31MTSbWBLnCtyvPQvGTQ/HFnBWcJ0h92SoUAYO4NK0HzCPNTeavb5vjYe/
         NH4RsiNuo3Is2T5uwZRpUgzMQA6Zvvjr431CHdjzlT7K+gtwPM0H4mbPp/cJnoT56z1U
         9FgjJbyhWDAtYxe/kQ3Q5uTbyj4yQkWDxuItO06iwOcNkjQOi7ADAd4Cd8yR3VFfytja
         IPwf4sPEl3qPSkDo9wSIChhxHm6o2Ae5zVL9wZ0gL0aBrP6NlgU1ZbH8Ov4O3J2cnnGJ
         dCqbCrOTw6VSy4dy1I78mXRoaXPZVyDObOy8tCxjeMLmGo0TW4XhCpPZRerBrPhvQ7to
         pSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687537650; x=1690129650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+N4JlccHakKrLPQ1lY3+HAUHCI52VAp5ISn02l+oVFQ=;
        b=Rpb4317pXbEW0NucCSDDUasc1L+QOSCxRLNqThunq6v6K6ESn/s4Da3ORXQPb+Xtuo
         InAf+4dbBYvJjzSNRfaXaR+m+/avtUNQFcYtcvwtgRhxfEE73zY/xwXrPur7FeT2MvWi
         TRicHFMGdxRsChHf1pCNdXh+d3mBvIeCAmOzVeRdWFY1YYM4qLDXbJNVKJqqbmn0zedw
         Jqh0tGLtA4b0r4OWo96vHg71uUSIVqOUEhiFZihyi1gqxnYeV44UlRkOciiusERHAAW7
         S/cOlHqGI1QvFAvHCA+7ByzjGqSlWL1spnx01GitbM6bY4GhLnZyzPvsl3ZsnrgUT9Gq
         bVTg==
X-Gm-Message-State: AC+VfDyOAaLROzsVVLoUvbEAKmGEJN0DGQrnc0YT6fVE9W53VDU+aNtn
	nFoJHh1kSbRUkg0SuN49Ul1QmXKMrK8a0KdoSQ0=
X-Google-Smtp-Source: ACHHUZ6931IZ4XK6W7zyYnle+bB/elS4gq3gq0D2urKoAcDmwPM0m6KXyGGhEOeoscQbIcqvGUI+yFJEETiaaauxMaM=
X-Received: by 2002:a1c:4c0d:0:b0:3f8:ffc8:bb00 with SMTP id
 z13-20020a1c4c0d000000b003f8ffc8bb00mr18581514wmf.37.1687537650082; Fri, 23
 Jun 2023 09:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-7-jolsa@kernel.org>
 <CAEf4BzbVJ4y2-y8WFicA_iSkVUoieWWHbv_f1mLwoY3fSPeTRw@mail.gmail.com> <ZJVVf2Ml/gvUSF+I@krava>
In-Reply-To: <ZJVVf2Ml/gvUSF+I@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 09:27:18 -0700
Message-ID: <CAEf4BzZ-sUp3h5LTWTTz_VNKFFb1ns=hqno1x8=3FjD_u8m9jA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 06/24] libbpf: Add elf symbol iterator
To: Jiri Olsa <olsajiri@gmail.com>
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

On Fri, Jun 23, 2023 at 1:19=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jun 22, 2023 at 05:31:58PM -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 20, 2023 at 1:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding elf symbol iterator object (and some functions) that follow
> > > open-coded iterator pattern and some functions to ease up iterating
> > > elf object symbols.
> > >
> > > The idea is to iterate single symbol section with:
> > >
> > >   struct elf_symbol_iter iter;
> > >   struct elf_symbol *sym;
> > >
> > >   if (elf_symbol_iter_new(&iter, elf, binary_path, SHT_DYNSYM))
> > >         goto error;
> > >
> > >   while ((sym =3D elf_symbol_iter_next(&iter))) {
> > >         ...
> > >   }
> > >
> > > I considered opening the elf inside the iterator and iterate all symb=
ol
> > > sections, but then it gets more complicated wrt user checks for when
> > > the next section is processed.
> > >
> > > Plus side is the we don't need 'exit' function, because caller/user i=
s
> > > in charge of that.
> > >
> > > The returned iterated symbol object from elf_symbol_iter_next functio=
n
> > > is placed inside the struct elf_symbol_iter, so no extra allocation o=
r
> > > argument is needed.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 179 ++++++++++++++++++++++++++-------------=
--
> > >  1 file changed, 114 insertions(+), 65 deletions(-)
> > >
> >
> > This is great. Left a few nits below. I'm thinkin maybe we should add
> > a separate elf.c file for all these ELF-related helpers and start
> > offloading code from libbpf.c, which got pretty big already. WDYT?
>
> yes, I thought doing the move after this is merged might be better,
> because it's quite big already
>
> >
> >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index af52188daa80..cdac368c7ce1 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -10824,6 +10824,109 @@ static Elf_Scn *elf_find_next_scn_by_type(E=
lf *elf, int sh_type, Elf_Scn *scn)
> > >         return NULL;
> > >  }
> > >
> > > +struct elf_symbol {
> > > +       const char *name;
> > > +       unsigned long offset;
> > > +       int bind;
> > > +};
> > > +
> > > +struct elf_symbol_iter {
> >
> > naming nits: elf_sym and elf_sym_iter? keep it short, keep it cool :)
>
> ok
>
> >
> > > +       Elf *elf;
> > > +       Elf_Data *symbols;
> >
> > syms :-P
>
> ook ;-)
>
> >
> > > +       size_t nr_syms;
> > > +       size_t strtabidx;
> > > +       size_t idx;
> >
> > next_sym_idx?
>
> ok
>
> >
> > > +       struct elf_symbol sym;
> > > +};
> > > +
> > > +static int elf_symbol_iter_new(struct elf_symbol_iter *iter,
> > > +                              Elf *elf, const char *binary_path,
> > > +                              int sh_type)
> > > +{
> > > +       Elf_Scn *scn =3D NULL;
> > > +       GElf_Ehdr ehdr;
> > > +       GElf_Shdr sh;
> > > +
> > > +       memset(iter, 0, sizeof(*iter));
> > > +
> > > +       if (!gelf_getehdr(elf, &ehdr)) {
> > > +               pr_warn("elf: failed to get ehdr from %s: %s\n", bina=
ry_path, elf_errmsg(-1));
> > > +               return -LIBBPF_ERRNO__FORMAT;
> > > +       }
> > > +
> > > +       scn =3D elf_find_next_scn_by_type(elf, sh_type, NULL);
> > > +       if (!scn) {
> > > +               pr_debug("elf: failed to find symbol table ELF sectio=
ns in '%s'\n",
> > > +                        binary_path);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       if (!gelf_getshdr(scn, &sh))
> > > +               return -EINVAL;
> > > +
> > > +       iter->strtabidx =3D sh.sh_link;
> > > +       iter->symbols =3D elf_getdata(scn, 0);
> > > +       if (!iter->symbols) {
> > > +               pr_warn("elf: failed to get symbols for symtab sectio=
n in '%s': %s\n",
> > > +                       binary_path, elf_errmsg(-1));
> > > +               return -LIBBPF_ERRNO__FORMAT;
> > > +       }
> > > +       iter->nr_syms =3D iter->symbols->d_size / sh.sh_entsize;
> > > +       iter->elf =3D elf;
> > > +       return 0;
> > > +}
> > > +
> > > +static struct elf_symbol *elf_symbol_iter_next(struct elf_symbol_ite=
r *iter)
> > > +{
> > > +       struct elf_symbol *ret =3D &iter->sym;
> > > +       unsigned long offset =3D 0;
> > > +       const char *name =3D NULL;
> > > +       GElf_Shdr sym_sh;
> > > +       Elf_Scn *sym_scn;
> > > +       GElf_Sym sym;
> > > +       size_t idx;
> > > +
> > > +       for (idx =3D iter->idx; idx < iter->nr_syms; idx++) {
> > > +               if (!gelf_getsym(iter->symbols, idx, &sym))
> > > +                       continue;
> > > +               if (GELF_ST_TYPE(sym.st_info) !=3D STT_FUNC)
> > > +                       continue;
> >
> > it would be more generic if this symbol type filter was a parameter to
> > iterator, instead of hard-coding it?
>
> ok
>
> >
> > > +               name =3D elf_strptr(iter->elf, iter->strtabidx, sym.s=
t_name);
> > > +               if (!name)
> > > +                       continue;
> > > +
> > > +               /* Transform symbol's virtual address (absolute for
> > > +                * binaries and relative for shared libs) into file
> > > +                * offset, which is what kernel is expecting for
> > > +                * uprobe/uretprobe attachment.
> > > +                * See Documentation/trace/uprobetracer.rst for more
> > > +                * details.
> > > +                * This is done by looking up symbol's containing
> > > +                * section's header and using iter's virtual address
> > > +                * (sh_addr) and corresponding file offset (sh_offset=
)
> > > +                * to transform sym.st_value (virtual address) into
> > > +                * desired final file offset.
> > > +                */
> > > +               sym_scn =3D elf_getscn(iter->elf, sym.st_shndx);
> > > +               if (!sym_scn)
> > > +                       continue;
> > > +               if (!gelf_getshdr(sym_scn, &sym_sh))
> > > +                       continue;
> > > +
> > > +               offset =3D sym.st_value - sym_sh.sh_addr + sym_sh.sh_=
offset;
> >
> > I think this part is not really generic "let's iterate ELF symbols",
> > maybe let users of iterator do this? We can have a helper to do
> > translation if we need to do it in few different places.
>
> yes this will be called in all the places we use the iterator,
> I'll add the helper for it
>
> >
> > > +               break;
> > > +       }
> > > +
> > > +       /* we reached the last symbol */
> > > +       if (idx =3D=3D iter->nr_syms)
> > > +               return NULL;
> > > +       iter->idx =3D idx + 1;
> > > +       ret->name =3D name;
> > > +       ret->bind =3D GELF_ST_BIND(sym.st_info);
> > > +       ret->offset =3D offset;
> >
> > Why not just return entire GElf_Sym information and let user process
> > it as desired. So basically for each symbol you'll give back its name,
> > GElf_Sym info, and I'd return symbol index as well. That will keep
> > this very generic for future uses.
>
> ok, so you have other users of this iterator in mind already?

well, there is linker.c that also iterates ELF symbols, though that
one is assuming Elf64_Sym, so I wouldn't go updating it. So it's more
of a general feeling that "ELF symbol iterator" shouldn't assume
functions and func_offset translation, it should just return symbols.

>
> >
> > > +       return ret;
> >
> > I'd structure this a bit different. If we got out of loop, just return
> > NULL. Then inside the for loop, when we found the symbol, fill out ret
> > and return from inside the for loop. I think it's more
> > straightforward.
>
> ok, will change
>
> thanks,
> jirka
>
> >
> > > +}
> > > +
> > >  /* Find offset of function name in the provided ELF object. "binary_=
path" is
> > >   * the path to the ELF binary represented by "elf", and only used fo=
r error
> > >   * reporting matters. "name" matches symbol name or name@@LIB for li=
brary
> >
> > [...]

