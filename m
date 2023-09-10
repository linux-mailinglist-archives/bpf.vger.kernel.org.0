Return-Path: <bpf+bounces-9611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98759799E3C
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 14:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919701C20897
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 12:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1EE53AA;
	Sun, 10 Sep 2023 12:39:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19B1C3F
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 12:39:24 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7771B9
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 05:39:22 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1c0fcbf7ae4so2808902fac.0
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694349562; x=1694954362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0IXfQICw5W1MyL0r8V9d2pSnjwcaRvRIly/pt/Kw7A=;
        b=nLKWxTNxRavb10FXdoxzIEgugqkUw6JQRSwj8R6W4Q3bfGnJ4NHNi0Bj+Pw3JEA/BG
         2DNmbkzZRJR6ekMCLciADTu7pP5HDKNHxxRJZGd1ajlOex643vXJvFa/Vb8efPDgC36Z
         yUNPlhuRNiIlx575nGLjCsVw/nl74kvUUKiYU2QzdaCMLE1abGu6eq3EcFnHBA786yVx
         OeTfcQqQNeER5PUfYRY5vUcujB3lRP+7ehDaLRl11ThLgUCTcTOKBQEvJN6IKw6I+ud2
         JuVd/XzgevQuA2Kr1S/DqXIMG4eQx2d+xZBatnyt7jQe8He3moToNl82VssowqVSEnza
         sixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694349562; x=1694954362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0IXfQICw5W1MyL0r8V9d2pSnjwcaRvRIly/pt/Kw7A=;
        b=eM3wrdFcmuolyzw0rKBSo9ZeiQdcNhADWi/LDl6+P9OkcnRXbJaVeDKoMvm/C7IKxw
         w1HAlFyo1dFX/1wEbS62pCCcLPgJUihsPTCplIWOPj9/+s63Y4J9vz1q3xMo20hQP3Tj
         /HdZwO2danNgXpoWBTBGAQ3571Evn5qFtjaBT0clmXIpz8z1UgKb60HD+ErvGJR9s7K7
         1bmxRwStQs/gcqa1l2YU7iUDC3cdPDUUpTGSu3j0oX3zI+zJp8SXbgnNgqhvOb46LXdL
         KiTcD4inRC7lPezIPBTRpcmuzZck46CW153ZDsS3WXa2Fj/CR7lyMFDahBjUpzju2n0Q
         Vvfw==
X-Gm-Message-State: AOJu0YydfYnlqjE9cyP7/qcFC/KBh88w+p9fLBnk0atS+wUR39eRjSyZ
	aQsvAph77grYIinziv2rJV7zANkYrCh1CnOHbuY=
X-Google-Smtp-Source: AGHT+IEonJlXZDw6qAWOoi2wi4gyNQly7gr89W49C4cZ69z/uESMELn9X09qmyFL98y9q+AITzuysTExLkPiPEIxcY0=
X-Received: by 2002:a05:6870:238d:b0:1bf:1346:63e with SMTP id
 e13-20020a056870238d00b001bf1346063emr9160022oap.49.1694349561949; Sun, 10
 Sep 2023 05:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230905151257.729192-1-hengqi.chen@gmail.com>
 <20230905151257.729192-3-hengqi.chen@gmail.com> <a219fa4f-1b25-e6c2-bd73-59b475118999@oracle.com>
In-Reply-To: <a219fa4f-1b25-e6c2-bd73-59b475118999@oracle.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Sun, 10 Sep 2023 20:39:10 +0800
Message-ID: <CAEyhmHQUdy03=v-1T-uh20_bSZ0EaVY8rqNXKu9awdO4XZdRLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] libbpf: Support symbol versioning for uprobe
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 8, 2023 at 11:07=E2=80=AFPM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 05/09/2023 16:12, Hengqi Chen wrote:
> > In current implementation, we assume that symbol found in .dynsym secti=
on
> > would have a version suffix and use it to compare with symbol user supp=
lied.
> > According to the spec ([0]), this assumption is incorrect, the version =
info
> > of dynamic symbols are stored in .gnu.version and .gnu.version_d sectio=
ns
> > of ELF objects. For example:
> >
> >     $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
> >     000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
> >     000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
> >     000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5
> >
> >     $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlo=
ck_wrlock
> >       706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread=
_rwlock_wrlock@GLIBC_2.2.5
> >       2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_=
rwlock_wrlock@@GLIBC_2.34
> >       2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_=
rwlock_wrlock@GLIBC_2.2.5
> >
> > In this case, specify pthread_rwlock_wrlock@@GLIBC_2.34 or
> > pthread_rwlock_wrlock@GLIBC_2.2.5 in bpf_uprobe_opts::func_name won't w=
ork.
> > Because the qualified name does NOT match `pthread_rwlock_wrlock` (with=
out
> > version suffix) in .dynsym sections.
> >
> > This commit implements the symbol versioning for dynsym and allows user=
 to
> > specify symbol in the following forms:
> >   - func
> >   - func@LIB_VERSION
> >   - func@@LIB_VERSION
> >
> > In case of symbol conflicts, error out and users should resolve it by
> > specifying a qualified name.
> >
> >   [0]: https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-generic/=
LSB-Core-generic/symversion.html
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>
> One question below, but
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>

Thanks.

> > ---
> >  tools/lib/bpf/elf.c    | 145 +++++++++++++++++++++++++++++++++++++----

> > +
> > +static bool symbol_match(Elf *elf, int sh_type, struct elf_sym *sym, c=
onst char *name)
> > +{
> > +     size_t name_len, sname_len;
> > +     bool is_name_qualified;
> > +     const char *ver;
> > +     char *sname;
> > +     int ret;
> > +
> > +     name_len =3D strlen(name);
> > +     /* Does name specify "@LIB" or "@@LIB" ? */
> > +     is_name_qualified =3D strstr(name, "@") !=3D NULL;
> > +
> > +     /* If user specify a qualified name, for dynamic symbol,
> > +      * it is in form of func, NOT func@LIB_VER or func@@LIB_VER.
> > +      * So construct a full quailified symbol name using versym info
> > +      * for comparison.
> > +      */
> > +     if (is_name_qualified && sh_type =3D=3D SHT_DYNSYM) {
> > +             /* Make sure func match func@LIB_VER */
> > +             sname_len =3D strlen(sym->name);
> > +             if (strncmp(sym->name, name, sname_len) !=3D 0)
> > +                     return false;
> > +
> > +             /* But not func2@LIB_VER */
> > +             if (name[sname_len] !=3D '@')
> > +                     return false;
> > +
> > +             ver =3D elf_get_vername(elf, sym->ver);
> > +             if (!ver)
> > +                     return false;
> > +
> > +             ret =3D asprintf(&sname, "%s%s%s", sym->name,
> > +                            sym->hidden ? "@" : "@@", ver);
> > +             if (ret =3D=3D -1)
> > +                     return false;
> > +
> > +             ret =3D strncmp(sname, name, name_len);
>
> I _think_ because we're using the length of the name we're searching for
> we'd end up matching pthread_rwlock_wrlock@@G and
> pthread_rwlock_wrlock@@GLIBC_2.34 ; should we use strlen(sname) to do
> an exact match here?
>

Good point, will do.

>
> > +             free(sname);
> > +             return ret =3D=3D 0;
> > +     }
> > +
> > +     /* Otherwise, for normal symbols or non-qualified names
> > +      * User can specify func, func@@LIB or func@@LIB_VERSION.
> > +      */
> > +     if (strncmp(sym->name, name, name_len) !=3D 0)
> > +             return false;
> > +     /* ...but we don't want a search for "foo" to match 'foo2" also, =
so any
> > +      * additional characters in sname should be of the form "@LIB" or=
 "@@LIB".
> > +      */
> > +     if (!is_name_qualified && sym->name[name_len] !=3D '\0' && sym->n=
ame[name_len] !=3D '@')
> > +             return false;
> > +
> > +     return true;
> > +}
> >
> >  /* Transform symbol's virtual address (absolute for binaries and relat=
ive
> >   * for shared libs) into file offset, which is what kernel is expectin=
g
> > @@ -166,9 +296,8 @@ static unsigned long elf_sym_offset(struct elf_sym =
*sym)
> >  long elf_find_func_offset(Elf *elf, const char *binary_path, const cha=
r *name)
> >  {
> >       int i, sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
> > -     bool is_shared_lib, is_name_qualified;
> > +     bool is_shared_lib;
> >       long ret =3D -ENOENT;
> > -     size_t name_len;
> >       GElf_Ehdr ehdr;
> >
> >       if (!gelf_getehdr(elf, &ehdr)) {
> > @@ -179,10 +308,6 @@ long elf_find_func_offset(Elf *elf, const char *bi=
nary_path, const char *name)
> >       /* for shared lib case, we do not need to calculate relative offs=
et */
> >       is_shared_lib =3D ehdr.e_type =3D=3D ET_DYN;
> >
> > -     name_len =3D strlen(name);
> > -     /* Does name specify "@@LIB"? */
> > -     is_name_qualified =3D strstr(name, "@@") !=3D NULL;
> > -
> >       /* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is=
 used because if
> >        * a binary is stripped, it may only have SHT_DYNSYM, and a fully=
-statically
> >        * linked binary may not have SHT_DYMSYM, so absence of a section=
 should not be
> > @@ -201,13 +326,7 @@ long elf_find_func_offset(Elf *elf, const char *bi=
nary_path, const char *name)
> >                       goto out;
> >
> >               while ((sym =3D elf_sym_iter_next(&iter))) {
> > -                     /* User can specify func, func@@LIB or func@@LIB_=
VERSION. */
> > -                     if (strncmp(sym->name, name, name_len) !=3D 0)
> > -                             continue;
> > -                     /* ...but we don't want a search for "foo" to mat=
ch 'foo2" also, so any
> > -                      * additional characters in sname should be of th=
e form "@@LIB".
> > -                      */
> > -                     if (!is_name_qualified && sym->name[name_len] !=
=3D '\0' && sym->name[name_len] !=3D '@')
> > +                     if (!symbol_match(elf, sh_types[i], sym, name))
> >                               continue;
> >
> >                       cur_bind =3D GELF_ST_BIND(sym->sym.st_info);
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 96ff1aa4bf6a..30b8f96820a7 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -11512,7 +11512,7 @@ static int attach_uprobe(const struct bpf_progr=
am *prog, long cookie, struct bpf
> >
> >       *link =3D NULL;
> >
> > -     n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.]+%li",
> > +     n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li"=
,
> >                  &probe_type, &binary_path, &func_name, &offset);
> >       switch (n) {
> >       case 1:
> > --
> > 2.34.1

