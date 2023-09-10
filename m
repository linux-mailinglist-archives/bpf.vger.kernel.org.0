Return-Path: <bpf+bounces-9612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F006799E47
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 14:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D67281158
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5489C53AA;
	Sun, 10 Sep 2023 12:42:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA261C3F
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 12:42:38 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E4C1BD
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 05:42:37 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1ccb6a69b13so2667430fac.2
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694349756; x=1694954556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INCBlo+tQ+V+pgm4auPPwGAX4zV2yvk/+isqQgQr/0Y=;
        b=dt2AB97qULk0S5Ok4Gigelj0iAD19LWP2odzoYIWmSqrWrlAYsbJOmwq2ly/hrZU5I
         sPUDKCxORDu0NFCCn/VjDCH65zqcnwvzZtmAl+KIkMfal9shpqisJ3Vy1qH2wrlJku3O
         jAYY/KANdJU25Hx9RllK4Hjph99OF+kDTkoxAx2oJqWSCnpkbqG828UvjbFcf2DNUjUC
         rATBC9JElJGdWTiCqtPclpEOsmnhmKmeBIWRq4LgB45gn7EdMwAVK6RtJ4BDu4XmQLBZ
         b55c95UDpGZi2/YHBslDXkqJ8OyGAUPoDXYILGNJGJdrF5RDZ6E+DNOLzMz7QiVM4dsR
         KhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694349756; x=1694954556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INCBlo+tQ+V+pgm4auPPwGAX4zV2yvk/+isqQgQr/0Y=;
        b=sNDq1Md2WkEmZwQzFoYe8RvXebCkhEJOODErouxJ/qdbwH1yuC20DnGWtdZvymuxca
         bmrQ9wWQbaAVJp9lfzmOAeOUnEzFK8TUc3ypOPn+mJpPodglwiKgycG4Is5tQJ7bHj/K
         PFE7Bc1IF3lTOLbDZsg1QGHFkkluXdS8v3DAgDJcBJPDR2x5zwkYXqmyNPhinKSeKrQz
         q4JjdZPnC9/ipAxcW2o92AnDvGSPUXNsniPFQie9kuTNh78BRGpd67haP1kAVNST+P60
         Dc5YH1ihIw2vTJAPzVWFLZs/qNAZux9KDaUa5ii1xb8W7pNk1HXBKeBrWrhCElMgcYlT
         dkqw==
X-Gm-Message-State: AOJu0YzxR3rUYRR9Dex+c4sjdJXF0isGezuoJvnv4Z5D1GcJQc7NCYm4
	MRfAAewn/xtUk/b/OKNy98nr9O0Gae49CFB6T6w=
X-Google-Smtp-Source: AGHT+IEmc4Y78sjijhqFzAqLpArzq6e6hqGzHdknPd6qrTX6Oogtm+lXRrMsjV+WtiuOdyQDC+nRs/jwlqDsW4rGF7c=
X-Received: by 2002:a05:6870:c220:b0:1d5:21cd:7069 with SMTP id
 z32-20020a056870c22000b001d521cd7069mr8868566oae.8.1694349755649; Sun, 10 Sep
 2023 05:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230905151257.729192-1-hengqi.chen@gmail.com>
 <20230905151257.729192-3-hengqi.chen@gmail.com> <ZP2SEyyS5RFdZzaY@krava>
In-Reply-To: <ZP2SEyyS5RFdZzaY@krava>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Sun, 10 Sep 2023 20:42:24 +0800
Message-ID: <CAEyhmHQQ2CB6S0jbrZ86PGsQnc8XSrZ3v8goC3O5=tgAcn_T0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] libbpf: Support symbol versioning for uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 10, 2023 at 5:53=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Sep 05, 2023 at 03:12:56PM +0000, Hengqi Chen wrote:
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
> I have a question below, but other than that
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka
>
>
> SNIP
>
> > @@ -119,6 +148,7 @@ static struct elf_sym *elf_sym_iter_next(struct elf=
_sym_iter *iter)
> >       struct elf_sym *ret =3D &iter->sym;
> >       GElf_Sym *sym =3D &ret->sym;
> >       const char *name =3D NULL;
> > +     GElf_Versym versym;
> >       Elf_Scn *sym_scn;
> >       size_t idx;
> >
> > @@ -138,12 +168,112 @@ static struct elf_sym *elf_sym_iter_next(struct =
elf_sym_iter *iter)
> >
> >               iter->next_sym_idx =3D idx + 1;
> >               ret->name =3D name;
> > +             ret->ver =3D 0;
> > +             ret->hidden =3D false;
> > +
> > +             if (iter->versyms) {
> > +                     if (!gelf_getversym(iter->versyms, idx, &versym))
> > +                             continue;
> > +                     ret->ver =3D versym & VERSYM_VERSION;
> > +                     ret->hidden =3D versym & VERSYM_HIDDEN;
>
> the doc mentions value 1 being special, also I can see readelf
> code checking on that.. is that taken into account?
>

Yes. For value 1, there is a corresponding version def, so no difference.

> > +             }
> >               return ret;
> >       }
> >
> >       return NULL;
> >  }
> >
>
> SNIP

