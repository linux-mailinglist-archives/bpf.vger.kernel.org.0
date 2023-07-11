Return-Path: <bpf+bounces-4781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE95574F63D
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036BE1C20D98
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DFC1DDD9;
	Tue, 11 Jul 2023 16:59:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E978B18C1C
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:59:18 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666BE75
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:59:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fba1288bbdso8818940e87.1
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689094755; x=1691686755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pm189Uq4EMkI5c/6hUa5iOyQiMbSDcgOBOK054VHgw=;
        b=m4Lr7XR1C9W8Mq1KDGU6SjOQaqO0B5+uL1WK7iBd8RqG9R8EEHwQLhwyCcuiMBZ2wT
         3knRNXUcecfSduGZUDyfxo4yGbIgojtquLHK/oHjX1HumYOqIoRAu6EvomAVSzUGo9Qr
         G28GOSgx9bPR/mVTaC6ANBY+Ws3NZlf4UxYPzutDyyiDNrGpWM7SHdnXyb2SJvWAsTKY
         HqJ3bOPW1AntpKiE7j8XCltDP95Claulob54mav8HeUAOre6oBTFwqk0ta9uJglrYpKv
         cyoq9vasA51a+nf3aWpAbKup+70bvTEYIDQX0YVVY8YfBdd85QI7WMo6yJp/MzvKtVQh
         J8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689094755; x=1691686755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pm189Uq4EMkI5c/6hUa5iOyQiMbSDcgOBOK054VHgw=;
        b=Ex9/jrzHAif6tG4TpGDZLv+aFUIRE9y87HzIXiHt0wcvSMESGyYUFtLpFQbOCVvm42
         lJrs9st3eXqYCcja39vhYOy7XCBcMmyru6st2m49z1VrBbQHJ61qzXDj8lSYMgqkwSY6
         fonZoFQIFLjeig8v0H43oc4/1KPEBgxLG+pSQgTvMxKIdZ48pd5RB68fC5uZb1rjeHlt
         BNGoE4hbc9twgEIXy6U73YgqqTtqjWQgp2vYpxrt8GT9IXUvwxt94xlFvpNHPHcyBk8O
         SJTFi3saUw18+GwKjtcJCxd9oQivpbrzYib5HPtfda4LrWGYn9C1zknEjaaxjToPs2FS
         t6fA==
X-Gm-Message-State: ABy/qLYakNnrSMKldvvyrCpcptijyH4NTNGRrhgkHu1sliU04wRj9M/M
	i25y9BgdjCEDAoKUzdsBr6q+MEtJNxm/Cps3LvUvSpzt
X-Google-Smtp-Source: APBJJlG1pBeIyp9vBr5aZ5vIROAsJUkcfFrJxpKfaHGfKD/19RWcmucDIr3xbi8aARGFD68ZxUlJzkvqcpAkrKCyPF8=
X-Received: by 2002:a05:6512:33ce:b0:4f9:596d:c803 with SMTP id
 d14-20020a05651233ce00b004f9596dc803mr17721197lfg.53.1689094754614; Tue, 11
 Jul 2023 09:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-10-jolsa@kernel.org>
 <CAEf4BzbeyXniXfYoE6e8=3wLJ+ikN+pMrByJqwjjTzkHwebp6w@mail.gmail.com> <ZK0azis5l/m+drtd@krava>
In-Reply-To: <ZK0azis5l/m+drtd@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Jul 2023 09:59:02 -0700
Message-ID: <CAEf4Bza=nOMBMXVS0fyn2rXJYK7i=90cj2eQ3JxeBeNpZ68H6Q@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 09/26] libbpf: Add elf symbol iterator
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 2:03=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jul 06, 2023 at 04:24:48PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/lib/bpf/elf.c | 178 +++++++++++++++++++++++++++++-------------=
--
> > >  1 file changed, 117 insertions(+), 61 deletions(-)
> > >
> >
> > A bunch of nits, but overall looks good. Please address nits, and add m=
y ack
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > > index 74e35071d22e..fcce4bd2478f 100644
> > > --- a/tools/lib/bpf/elf.c
> > > +++ b/tools/lib/bpf/elf.c
> > > @@ -59,6 +59,108 @@ static Elf_Scn *elf_find_next_scn_by_type(Elf *el=
f, int sh_type, Elf_Scn *scn)
> > >         return NULL;
> > >  }
> > >
> > > +struct elf_sym {
> > > +       const char *name;
> > > +       GElf_Sym sym;
> > > +       GElf_Shdr sh;
> > > +};
> > > +
> >
> > if we want to use elf_sym_iter outside of elf.c, this should be in
> > libbpf_internal.h?
>
> yes eventually, but all the helper functions using elf_sym_iter that
> I added later are in elf.c, so there's no need atm
>
> SNIP
>
> > > +
> > > +static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
> > > +{
> > > +       struct elf_sym *ret =3D &iter->sym;
> > > +       GElf_Sym *sym =3D &ret->sym;
> > > +       const char *name =3D NULL;
> > > +       Elf_Scn *sym_scn;
> > > +       size_t idx;
> > > +
> > > +       for (idx =3D iter->next_sym_idx; idx < iter->nr_syms; idx++) =
{
> > > +               if (!gelf_getsym(iter->syms, idx, sym))
> > > +                       continue;
> > > +               if (GELF_ST_TYPE(sym->st_info) !=3D iter->st_type)
> > > +                       continue;
> > > +               name =3D elf_strptr(iter->elf, iter->strtabidx, sym->=
st_name);
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
> >
> > this comment is misplaced? we don't do the translation here
>
> right, should be placed at the elf_sym_offset function
>
> >
> > > +               sym_scn =3D elf_getscn(iter->elf, sym->st_shndx);
> > > +               if (!sym_scn)
> > > +                       continue;
> > > +               if (!gelf_getshdr(sym_scn, &ret->sh))
> > > +                       continue;
> > > +
> > > +               iter->next_sym_idx =3D idx + 1;
> > > +               ret->name =3D name;
> > > +               return ret;
> > > +       }
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > > +static unsigned long elf_sym_offset(struct elf_sym *sym)
> > > +{
> > > +       return sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offse=
t;
> > > +}
> > > +
> > >  /* Find offset of function name in the provided ELF object. "binary_=
path" is
> > >   * the path to the ELF binary represented by "elf", and only used fo=
r error
> > >   * reporting matters. "name" matches symbol name or name@@LIB for li=
brary
> > > @@ -90,64 +192,36 @@ long elf_find_func_offset(Elf *elf, const char *=
binary_path, const char *name)
> > >          * reported as a warning/error.
> > >          */
> > >         for (i =3D 0; i < ARRAY_SIZE(sh_types); i++) {
> > > -               size_t nr_syms, strtabidx, idx;
> > > -               Elf_Data *symbols =3D NULL;
> > > -               Elf_Scn *scn =3D NULL;
> > > +               struct elf_sym_iter iter;
> > > +               struct elf_sym *sym;
> > >                 int last_bind =3D -1;
> > > -               const char *sname;
> > > -               GElf_Shdr sh;
> > > +               int curr_bind;
> >
> > OCD nit:
> >
> > $ rg 'curr(_|\b)' | wc -l
> > 8
> > $ rg 'cur(_|\b)' | wc -l
> > 148
> >
> > and those 8 I consider an unfortunate accident ;) let's standardize on
> > using "cur" consistently
>
> ok.. probably easier to make that change than treat ocd ;-)
>

thanks :)


> >
> > >
> > > -               scn =3D elf_find_next_scn_by_type(elf, sh_types[i], N=
ULL);
> > > -               if (!scn) {
> > > -                       pr_debug("elf: failed to find symbol table EL=
F sections in '%s'\n",
> > > -                                binary_path);
> > > -                       continue;
> > > -               }
> > > -               if (!gelf_getshdr(scn, &sh))
> > > -                       continue;
> > > -               strtabidx =3D sh.sh_link;
> > > -               symbols =3D elf_getdata(scn, 0);
> > > -               if (!symbols) {
> > > -                       pr_warn("elf: failed to get symbols for symta=
b section in '%s': %s\n",
> > > -                               binary_path, elf_errmsg(-1));
> > > -                       ret =3D -LIBBPF_ERRNO__FORMAT;
> > > +               ret =3D elf_sym_iter_new(&iter, elf, binary_path, sh_=
types[i], STT_FUNC);
> > > +               if (ret) {
> > > +                       if (ret =3D=3D -ENOENT)
> > > +                               continue;
> > >                         goto out;
> >
> > another styling nit: let's avoid unnecessary nesting of ifs:
> >
> > if (ret =3D=3D -ENOENT)
> >     continue;
> > if (ret)
> >     goto out;
> >
> > simple and clean
>
> ok
>
> >
> >
> > >                 }
> > > -               nr_syms =3D symbols->d_size / sh.sh_entsize;
> > > -
> > > -               for (idx =3D 0; idx < nr_syms; idx++) {
> > > -                       int curr_bind;
> > > -                       GElf_Sym sym;
> > > -                       Elf_Scn *sym_scn;
> > > -                       GElf_Shdr sym_sh;
> > > -
> > > -                       if (!gelf_getsym(symbols, idx, &sym))
> > > -                               continue;
> > > -
> > > -                       if (GELF_ST_TYPE(sym.st_info) !=3D STT_FUNC)
> > > -                               continue;
> > > -
> > > -                       sname =3D elf_strptr(elf, strtabidx, sym.st_n=
ame);
> > > -                       if (!sname)
> > > -                               continue;
> > > -
> > > -                       curr_bind =3D GELF_ST_BIND(sym.st_info);
> > >
> > > +               while ((sym =3D elf_sym_iter_next(&iter))) {
> > >                         /* User can specify func, func@@LIB or func@@=
LIB_VERSION. */
> > > -                       if (strncmp(sname, name, name_len) !=3D 0)
> > > +                       if (strncmp(sym->name, name, name_len) !=3D 0=
)
> > >                                 continue;
> > >                         /* ...but we don't want a search for "foo" to=
 match 'foo2" also, so any
> > >                          * additional characters in sname should be o=
f the form "@@LIB".
> > >                          */
> > > -                       if (!is_name_qualified && sname[name_len] !=
=3D '\0' && sname[name_len] !=3D '@')
> > > +                       if (!is_name_qualified && sym->name[name_len]=
 !=3D '\0' && sym->name[name_len] !=3D '@')
> > >                                 continue;
> > >
> > > -                       if (ret >=3D 0) {
> > > +                       curr_bind =3D GELF_ST_BIND(sym->sym.st_info);
> > > +
> > > +                       if (ret > 0) {
> >
> > used to be >=3D, why the change?
>
> the original code initialized ret with -ENOENT and did not change
> its value till this point, so the condition never triggered for
> the first loop, but it did for the new code because we now use ret
> earlier in:
>
>         ret =3D elf_sym_iter_new(&iter, elf, binary_path, sh_types[i], ST=
T_FUNC);
>
> also the check makes sense to me only if ret > 0 .. when we find
> a duplicate value for symbol

there is a subtle difference if we have some unresolved func with addr
0 or something. But you are right, it's probably not very sensical, we
can keep it as > 0.

>
> jirka

