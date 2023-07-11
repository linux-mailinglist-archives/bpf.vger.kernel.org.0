Return-Path: <bpf+bounces-4737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB8274E9C3
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7612814A1
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A817745;
	Tue, 11 Jul 2023 09:03:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D017733
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:03:17 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B749794
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:03:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991ef0b464cso1314667266b.0
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066194; x=1691658194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ma2e/RCUYr5EiszcCzu46eQ5bR8ctgfsc6lXBqOaPN8=;
        b=Cd4S8RkrI+pY7p4Z6s2RhrRgTB6XatYLosSbW9sutfshKWfk58SMUhTSYTrpoYXSqV
         BD602100o++582XCVp5+ahf30UIMc946c//M/+ULaqKfKp/i8S95XY84D9Bt8nV/OrpL
         PCc52QnAwS4pG+iRVlW8HQ8ae0gE+T5HqCgPHRGHUqXxpmseEagnfujRDK6TDiYf/yIR
         DHOojGUrp+bQIeN5KiuqzwtEmFOwu3JfWMyG4lWSh774E/eXKx/pdJWqUVIifrQj3SPV
         HCxNhA9GPch4aYHKwjSW2CtZWLuZFv5omPsjZyPJ0mI9XyijhbpKfTQrTkEpxj4rT3j9
         bYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066194; x=1691658194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma2e/RCUYr5EiszcCzu46eQ5bR8ctgfsc6lXBqOaPN8=;
        b=Kr5m/5EvsXyJstm85K0ijhr3R1FIV26oRJiyTvXnkr3wk/Zhg4pdyb7SIyEV/FvvYE
         eF5NLG6JWjywmDcKfeMO+J3kkSpz7OLi3PgXteg2jqJpI6y7C02uNKJPbYeOodQwc+NM
         ZO0cqU4Jh8+rrTM2xlMPUZmivlsEHSSY93um0ub/gW6BZnque3ehq9/P8AkAqcS9EL2L
         mxKIPmgK44OB0AOVHDvBoCuKuEs7Le+VAud8XFnym+zWWr/YZyl0kb/f14+grJlTE3VX
         izSZ03Y5WxtDwbcGkQWWF0tZYsnj6YdnBXw/Y+TpSl9XrjfeDeJQ/xRKOIlFgiRu0gqB
         xFdw==
X-Gm-Message-State: ABy/qLY5JNwhSNrxrLsh++fUT4TbqdC5gCi1fdcwDPxh1Jy/7+uLkqEW
	RI1N4QCT30cARSXIym5GJqA=
X-Google-Smtp-Source: APBJJlEPesscJq6yYhS0VMVJALjZcx4avypVKUFxVX2XN/0xr1BGduOAUvdruRgiPKrQKkgp1mLqzA==
X-Received: by 2002:a17:906:6a1b:b0:98f:450e:fc20 with SMTP id qw27-20020a1709066a1b00b0098f450efc20mr22632823ejc.17.1689066194033;
        Tue, 11 Jul 2023 02:03:14 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id z3-20020a1709064e0300b00992afee724bsm873465eju.76.2023.07.11.02.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:03:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:03:10 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 09/26] libbpf: Add elf symbol iterator
Message-ID: <ZK0azis5l/m+drtd@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-10-jolsa@kernel.org>
 <CAEf4BzbeyXniXfYoE6e8=3wLJ+ikN+pMrByJqwjjTzkHwebp6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbeyXniXfYoE6e8=3wLJ+ikN+pMrByJqwjjTzkHwebp6w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 04:24:48PM -0700, Andrii Nakryiko wrote:

SNIP

> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/elf.c | 178 +++++++++++++++++++++++++++++---------------
> >  1 file changed, 117 insertions(+), 61 deletions(-)
> >
> 
> A bunch of nits, but overall looks good. Please address nits, and add my ack
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > index 74e35071d22e..fcce4bd2478f 100644
> > --- a/tools/lib/bpf/elf.c
> > +++ b/tools/lib/bpf/elf.c
> > @@ -59,6 +59,108 @@ static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
> >         return NULL;
> >  }
> >
> > +struct elf_sym {
> > +       const char *name;
> > +       GElf_Sym sym;
> > +       GElf_Shdr sh;
> > +};
> > +
> 
> if we want to use elf_sym_iter outside of elf.c, this should be in
> libbpf_internal.h?

yes eventually, but all the helper functions using elf_sym_iter that
I added later are in elf.c, so there's no need atm

SNIP

> > +
> > +static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
> > +{
> > +       struct elf_sym *ret = &iter->sym;
> > +       GElf_Sym *sym = &ret->sym;
> > +       const char *name = NULL;
> > +       Elf_Scn *sym_scn;
> > +       size_t idx;
> > +
> > +       for (idx = iter->next_sym_idx; idx < iter->nr_syms; idx++) {
> > +               if (!gelf_getsym(iter->syms, idx, sym))
> > +                       continue;
> > +               if (GELF_ST_TYPE(sym->st_info) != iter->st_type)
> > +                       continue;
> > +               name = elf_strptr(iter->elf, iter->strtabidx, sym->st_name);
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
> 
> this comment is misplaced? we don't do the translation here

right, should be placed at the elf_sym_offset function

> 
> > +               sym_scn = elf_getscn(iter->elf, sym->st_shndx);
> > +               if (!sym_scn)
> > +                       continue;
> > +               if (!gelf_getshdr(sym_scn, &ret->sh))
> > +                       continue;
> > +
> > +               iter->next_sym_idx = idx + 1;
> > +               ret->name = name;
> > +               return ret;
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> > +static unsigned long elf_sym_offset(struct elf_sym *sym)
> > +{
> > +       return sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset;
> > +}
> > +
> >  /* Find offset of function name in the provided ELF object. "binary_path" is
> >   * the path to the ELF binary represented by "elf", and only used for error
> >   * reporting matters. "name" matches symbol name or name@@LIB for library
> > @@ -90,64 +192,36 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
> >          * reported as a warning/error.
> >          */
> >         for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
> > -               size_t nr_syms, strtabidx, idx;
> > -               Elf_Data *symbols = NULL;
> > -               Elf_Scn *scn = NULL;
> > +               struct elf_sym_iter iter;
> > +               struct elf_sym *sym;
> >                 int last_bind = -1;
> > -               const char *sname;
> > -               GElf_Shdr sh;
> > +               int curr_bind;
> 
> OCD nit:
> 
> $ rg 'curr(_|\b)' | wc -l
> 8
> $ rg 'cur(_|\b)' | wc -l
> 148
> 
> and those 8 I consider an unfortunate accident ;) let's standardize on
> using "cur" consistently

ok.. probably easier to make that change than treat ocd ;-)

> 
> >
> > -               scn = elf_find_next_scn_by_type(elf, sh_types[i], NULL);
> > -               if (!scn) {
> > -                       pr_debug("elf: failed to find symbol table ELF sections in '%s'\n",
> > -                                binary_path);
> > -                       continue;
> > -               }
> > -               if (!gelf_getshdr(scn, &sh))
> > -                       continue;
> > -               strtabidx = sh.sh_link;
> > -               symbols = elf_getdata(scn, 0);
> > -               if (!symbols) {
> > -                       pr_warn("elf: failed to get symbols for symtab section in '%s': %s\n",
> > -                               binary_path, elf_errmsg(-1));
> > -                       ret = -LIBBPF_ERRNO__FORMAT;
> > +               ret = elf_sym_iter_new(&iter, elf, binary_path, sh_types[i], STT_FUNC);
> > +               if (ret) {
> > +                       if (ret == -ENOENT)
> > +                               continue;
> >                         goto out;
> 
> another styling nit: let's avoid unnecessary nesting of ifs:
> 
> if (ret == -ENOENT)
>     continue;
> if (ret)
>     goto out;
> 
> simple and clean

ok

> 
> 
> >                 }
> > -               nr_syms = symbols->d_size / sh.sh_entsize;
> > -
> > -               for (idx = 0; idx < nr_syms; idx++) {
> > -                       int curr_bind;
> > -                       GElf_Sym sym;
> > -                       Elf_Scn *sym_scn;
> > -                       GElf_Shdr sym_sh;
> > -
> > -                       if (!gelf_getsym(symbols, idx, &sym))
> > -                               continue;
> > -
> > -                       if (GELF_ST_TYPE(sym.st_info) != STT_FUNC)
> > -                               continue;
> > -
> > -                       sname = elf_strptr(elf, strtabidx, sym.st_name);
> > -                       if (!sname)
> > -                               continue;
> > -
> > -                       curr_bind = GELF_ST_BIND(sym.st_info);
> >
> > +               while ((sym = elf_sym_iter_next(&iter))) {
> >                         /* User can specify func, func@@LIB or func@@LIB_VERSION. */
> > -                       if (strncmp(sname, name, name_len) != 0)
> > +                       if (strncmp(sym->name, name, name_len) != 0)
> >                                 continue;
> >                         /* ...but we don't want a search for "foo" to match 'foo2" also, so any
> >                          * additional characters in sname should be of the form "@@LIB".
> >                          */
> > -                       if (!is_name_qualified && sname[name_len] != '\0' && sname[name_len] != '@')
> > +                       if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
> >                                 continue;
> >
> > -                       if (ret >= 0) {
> > +                       curr_bind = GELF_ST_BIND(sym->sym.st_info);
> > +
> > +                       if (ret > 0) {
> 
> used to be >=, why the change?

the original code initialized ret with -ENOENT and did not change
its value till this point, so the condition never triggered for
the first loop, but it did for the new code because we now use ret
earlier in:

	ret = elf_sym_iter_new(&iter, elf, binary_path, sh_types[i], STT_FUNC);

also the check makes sense to me only if ret > 0 .. when we find
a duplicate value for symbol

jirka

