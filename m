Return-Path: <bpf+bounces-3241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0B873B28D
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 10:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183C31C2103D
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEA82102;
	Fri, 23 Jun 2023 08:19:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EBB3D60
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 08:19:17 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7ECDC
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 01:19:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f9b258f3a2so5026305e9.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687508354; x=1690100354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YtkB1BGmhS9dQOL3x4V7Ki+pqpY6d9C7LkUdhnOQ/c4=;
        b=rC9e8PKPv3CLfMJQ+eVTTjb8qiLVT4ZNG70vmbMVdnw+blNedShOZ0jCl9IT6b+mlD
         3QH/oo+WvtDZNzeXA66N/cO2o587juSCmO8PPSnOcx+LXsaRTY3LXEhd8CSVs+5bMOnC
         mG6vy9RIvahYEJrS+Tl196mt5Ed/Phk1TdaIwcOFZB3Uxc1evTQZBM8DyuslCAxcOaZW
         tDUsUJTutto/JyN+5yN+PGhc6pvvj4IIGkHzVGqsLW7DlGV6Gg4ZGd1+4AvpgIAMoYzY
         xgKhenlvlPTipws+Mw5211384inmYXdAyZ6014j9c+2HahQQIZc4WG30W5uxaXVabqLd
         0JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687508354; x=1690100354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtkB1BGmhS9dQOL3x4V7Ki+pqpY6d9C7LkUdhnOQ/c4=;
        b=DQEkMlskIwTGvAiElDFAGVSy8p+o6LFNN6uBSmR/Xxf/8xsZOl/gUbchlfpnIioqG9
         +RwI/nk7zrqiDiJx2ykfX5bJ7ls5tu1/Pu0EB+HExgSkZLVbuqvN5ac1sInLKWsI/WQf
         jCvCJkGlkjisDawE4o9Mkgi7socfITRQg30ccqbWSSbAgikz3ritaccvtp4XY2cLI4Gf
         5YwTNZu4FkKsRsQbl3KRc6sLnFXB4wBeK/Nye5FNsqEP2e/alzMSXE32mcRPvGiCXUz3
         XcssJlXvNBeE/gtV8rwEDM6Sm+zOQqJ2TdUejjm8dEq4roY3XYoOB+Jn6lQ5beAAVBbk
         FlvQ==
X-Gm-Message-State: AC+VfDyr9vOI6vnmARlCu3B7t9FvxD02s+DtB/Oh23CB9rBG/CGqKD3a
	jxXcUvaAW8qRwDvIFucb7uM=
X-Google-Smtp-Source: ACHHUZ7Aoxp8BVL+wAZ/pazMNhKQSBZzb9i0Qi3NrElMoJfHfkmmd+nx/kts6X5+K1pj+vJ9wMBrZA==
X-Received: by 2002:a7b:c845:0:b0:3f9:bc32:ca64 with SMTP id c5-20020a7bc845000000b003f9bc32ca64mr5826175wml.19.1687508354199;
        Fri, 23 Jun 2023 01:19:14 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f90067880esm1589554wmk.47.2023.06.23.01.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 01:19:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 23 Jun 2023 10:19:11 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 06/24] libbpf: Add elf symbol iterator
Message-ID: <ZJVVf2Ml/gvUSF+I@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-7-jolsa@kernel.org>
 <CAEf4BzbVJ4y2-y8WFicA_iSkVUoieWWHbv_f1mLwoY3fSPeTRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbVJ4y2-y8WFicA_iSkVUoieWWHbv_f1mLwoY3fSPeTRw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 05:31:58PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 20, 2023 at 1:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding elf symbol iterator object (and some functions) that follow
> > open-coded iterator pattern and some functions to ease up iterating
> > elf object symbols.
> >
> > The idea is to iterate single symbol section with:
> >
> >   struct elf_symbol_iter iter;
> >   struct elf_symbol *sym;
> >
> >   if (elf_symbol_iter_new(&iter, elf, binary_path, SHT_DYNSYM))
> >         goto error;
> >
> >   while ((sym = elf_symbol_iter_next(&iter))) {
> >         ...
> >   }
> >
> > I considered opening the elf inside the iterator and iterate all symbol
> > sections, but then it gets more complicated wrt user checks for when
> > the next section is processed.
> >
> > Plus side is the we don't need 'exit' function, because caller/user is
> > in charge of that.
> >
> > The returned iterated symbol object from elf_symbol_iter_next function
> > is placed inside the struct elf_symbol_iter, so no extra allocation or
> > argument is needed.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 179 ++++++++++++++++++++++++++---------------
> >  1 file changed, 114 insertions(+), 65 deletions(-)
> >
> 
> This is great. Left a few nits below. I'm thinkin maybe we should add
> a separate elf.c file for all these ELF-related helpers and start
> offloading code from libbpf.c, which got pretty big already. WDYT?

yes, I thought doing the move after this is merged might be better,
because it's quite big already

> 
> 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index af52188daa80..cdac368c7ce1 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10824,6 +10824,109 @@ static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
> >         return NULL;
> >  }
> >
> > +struct elf_symbol {
> > +       const char *name;
> > +       unsigned long offset;
> > +       int bind;
> > +};
> > +
> > +struct elf_symbol_iter {
> 
> naming nits: elf_sym and elf_sym_iter? keep it short, keep it cool :)

ok

> 
> > +       Elf *elf;
> > +       Elf_Data *symbols;
> 
> syms :-P

ook ;-)

> 
> > +       size_t nr_syms;
> > +       size_t strtabidx;
> > +       size_t idx;
> 
> next_sym_idx?

ok

> 
> > +       struct elf_symbol sym;
> > +};
> > +
> > +static int elf_symbol_iter_new(struct elf_symbol_iter *iter,
> > +                              Elf *elf, const char *binary_path,
> > +                              int sh_type)
> > +{
> > +       Elf_Scn *scn = NULL;
> > +       GElf_Ehdr ehdr;
> > +       GElf_Shdr sh;
> > +
> > +       memset(iter, 0, sizeof(*iter));
> > +
> > +       if (!gelf_getehdr(elf, &ehdr)) {
> > +               pr_warn("elf: failed to get ehdr from %s: %s\n", binary_path, elf_errmsg(-1));
> > +               return -LIBBPF_ERRNO__FORMAT;
> > +       }
> > +
> > +       scn = elf_find_next_scn_by_type(elf, sh_type, NULL);
> > +       if (!scn) {
> > +               pr_debug("elf: failed to find symbol table ELF sections in '%s'\n",
> > +                        binary_path);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (!gelf_getshdr(scn, &sh))
> > +               return -EINVAL;
> > +
> > +       iter->strtabidx = sh.sh_link;
> > +       iter->symbols = elf_getdata(scn, 0);
> > +       if (!iter->symbols) {
> > +               pr_warn("elf: failed to get symbols for symtab section in '%s': %s\n",
> > +                       binary_path, elf_errmsg(-1));
> > +               return -LIBBPF_ERRNO__FORMAT;
> > +       }
> > +       iter->nr_syms = iter->symbols->d_size / sh.sh_entsize;
> > +       iter->elf = elf;
> > +       return 0;
> > +}
> > +
> > +static struct elf_symbol *elf_symbol_iter_next(struct elf_symbol_iter *iter)
> > +{
> > +       struct elf_symbol *ret = &iter->sym;
> > +       unsigned long offset = 0;
> > +       const char *name = NULL;
> > +       GElf_Shdr sym_sh;
> > +       Elf_Scn *sym_scn;
> > +       GElf_Sym sym;
> > +       size_t idx;
> > +
> > +       for (idx = iter->idx; idx < iter->nr_syms; idx++) {
> > +               if (!gelf_getsym(iter->symbols, idx, &sym))
> > +                       continue;
> > +               if (GELF_ST_TYPE(sym.st_info) != STT_FUNC)
> > +                       continue;
> 
> it would be more generic if this symbol type filter was a parameter to
> iterator, instead of hard-coding it?

ok

> 
> > +               name = elf_strptr(iter->elf, iter->strtabidx, sym.st_name);
> > +               if (!name)
> > +                       continue;
> > +
> > +               /* Transform symbol's virtual address (absolute for
> > +                * binaries and relative for shared libs) into file
> > +                * offset, which is what kernel is expecting for
> > +                * uprobe/uretprobe attachment.
> > +                * See Documentation/trace/uprobetracer.rst for more
> > +                * details.
> > +                * This is done by looking up symbol's containing
> > +                * section's header and using iter's virtual address
> > +                * (sh_addr) and corresponding file offset (sh_offset)
> > +                * to transform sym.st_value (virtual address) into
> > +                * desired final file offset.
> > +                */
> > +               sym_scn = elf_getscn(iter->elf, sym.st_shndx);
> > +               if (!sym_scn)
> > +                       continue;
> > +               if (!gelf_getshdr(sym_scn, &sym_sh))
> > +                       continue;
> > +
> > +               offset = sym.st_value - sym_sh.sh_addr + sym_sh.sh_offset;
> 
> I think this part is not really generic "let's iterate ELF symbols",
> maybe let users of iterator do this? We can have a helper to do
> translation if we need to do it in few different places.

yes this will be called in all the places we use the iterator,
I'll add the helper for it

> 
> > +               break;
> > +       }
> > +
> > +       /* we reached the last symbol */
> > +       if (idx == iter->nr_syms)
> > +               return NULL;
> > +       iter->idx = idx + 1;
> > +       ret->name = name;
> > +       ret->bind = GELF_ST_BIND(sym.st_info);
> > +       ret->offset = offset;
> 
> Why not just return entire GElf_Sym information and let user process
> it as desired. So basically for each symbol you'll give back its name,
> GElf_Sym info, and I'd return symbol index as well. That will keep
> this very generic for future uses.

ok, so you have other users of this iterator in mind already?

> 
> > +       return ret;
> 
> I'd structure this a bit different. If we got out of loop, just return
> NULL. Then inside the for loop, when we found the symbol, fill out ret
> and return from inside the for loop. I think it's more
> straightforward.

ok, will change

thanks,
jirka

> 
> > +}
> > +
> >  /* Find offset of function name in the provided ELF object. "binary_path" is
> >   * the path to the ELF binary represented by "elf", and only used for error
> >   * reporting matters. "name" matches symbol name or name@@LIB for library
> 
> [...]

