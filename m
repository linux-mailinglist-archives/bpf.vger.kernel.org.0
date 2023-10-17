Return-Path: <bpf+bounces-12378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A157CBA1C
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 07:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E521F22AB5
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 05:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5D5C130;
	Tue, 17 Oct 2023 05:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3kdTExo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B161BE58
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:26:44 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C3D1A2
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 22:26:38 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c4b9e09528so3604494a34.3
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 22:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697520398; x=1698125198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxldCq1oGvlr0lO08zzJrwJrqhPtlOadnmwmIrqUd5Y=;
        b=Y3kdTExo2YrDMwEPu1JPKJ5w05zSxgb7tqwQWd0I//QZWPvxKDArPeNKsJx8h5BcZN
         a2+iCO3IpOVQzuj5qs9jyzdwgAgJn28TUcHCxTSS7JSYuAnpRH4ATbt2iDVlmQ4vvsJs
         MaKddtXNsyjuHIFognEJSJXqHaZtXsO5s7dzG+KUgxicmluPeJb92GCRm+i4O9iLoUzr
         vciNkmc1YHV8WUHcOYf5iG0ekV6JfNG9lB3hh6Une9anwV0IY2w05VM5i/f2I9eVXOtG
         YbC4t1rwLZs5ghC4fk4dtdl2duybHkuYVz1RJ/FwSfeQcBSVvvV6HTutP0v017iHdag5
         dmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697520398; x=1698125198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxldCq1oGvlr0lO08zzJrwJrqhPtlOadnmwmIrqUd5Y=;
        b=cXLaNzbEl/VveH2lKgV0B8AjEI0DicmjaziaYXvmeOrwTSFoQTaspbhpJ94yiBjdi1
         Pqur1N8LIkTA3uOJyWtxpjSGCRRtiIOJ3xz4vRnUE0y/Ee+OK5pRtDzF8GlWvAUqNuNP
         oKFhiKye5/8H/tmjU5LQIkpWim3vUEywiY5utmQ6EUhPIR9R2RH+0nmAlPAZpCvVKP3E
         pFJfC/nNga5G/tPf3qMV+KLkcVmdm9PG7cYLZ7z66eNTwLnFuaO7IJXtDxaXSEriRZgj
         1SEWXY+g8yE8ZJNcCMsaYcZcbZ8aDt4MLaYUFcBxK7LBscV1S7G+nlPhxp9I82wjFDWs
         5gxQ==
X-Gm-Message-State: AOJu0YyUBiuSDIj8xYx39Sq8JYg97Q7qjIkNpUeGgPCTo4Too13y5PMp
	bhDPFUZGycIcK1RCoWIG2q04Kivm+wGq4/RKYPOOvKqUkEo=
X-Google-Smtp-Source: AGHT+IEwUMdHyEU5/39oj9CHUCyWzev1ZVPfCtgb6/SK2Z1iZ6gAfchBj2XD0e0d7LQjHQ7IYjWpx8EEgHuwKb/HHOY=
X-Received: by 2002:a05:6870:6c02:b0:1e9:c10e:401f with SMTP id
 na2-20020a0568706c0200b001e9c10e401fmr1550670oab.12.1697520397815; Mon, 16
 Oct 2023 22:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016182840.4033346-1-andrii@kernel.org> <CAEf4BzZopGdv=cfQCryvaw_duK_BD1oFgTXXZ6w25X0xxXLWJw@mail.gmail.com>
 <CAEyhmHSHJgQrgtRZotmm3yQOSekjjZjqaHAF58iQeu0WYPNcYA@mail.gmail.com> <20231017040600.z3k5nqfpblt6zwhe@google.com>
In-Reply-To: <20231017040600.z3k5nqfpblt6zwhe@google.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 17 Oct 2023 13:26:26 +0800
Message-ID: <CAEyhmHRyY6s50niYbJgstDVjPX7aMoOXQVhz1CaCvcpJt+Weqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: don't assume SHT_GNU_verdef presence for
 SHT_GNU_versym section
To: Fangrui Song <maskray@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com, Liam Wisehart <liamwisehart@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 12:06=E2=80=AFPM Fangrui Song <maskray@google.com> =
wrote:
>
> On 2023-10-17, Hengqi Chen wrote:
> >+ Fangrui
>
> Thanks for CCing me. I have spent countless hours studying symbol
> versioning...
> https://maskray.me/blog/2020-11-26-all-about-symbol-versioning
>
> >On Tue, Oct 17, 2023 at 4:10=E2=80=AFAM Andrii Nakryiko
> ><andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Mon, Oct 16, 2023 at 11:28=E2=80=AFAM Andrii Nakryiko <andrii@kerne=
l.org> wrote:
> >> >
> >> > Fix too eager assumption that SHT_GNU_verdef ELF section is going to=
 be
> >> > present whenever binary has SHT_GNU_versym section. It seems like ei=
ther
> >> > SHT_GNU_verdef or SHT_GNU_verneed can be used, so failing on missing
> >> > SHT_GNU_verdef actually breaks use cases in production.
> >> >
> >> > One specific reported issue, which was used to manually test this fi=
x,
> >> > was trying to attach to `readline` function in BASH binary.
> >> >
> >> > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> >> > Reported-by: Liam Wisehart <liamwisehart@meta.com>
> >> > Fixes: bb7fa09399b9 ("libbpf: Support symbol versioning for uprobe")
> >> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >> > ---
> >> >  tools/lib/bpf/elf.c | 16 ++++++++++------
> >> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >> >
> >>
> >> Hengqi,
> >>
> >> Please take a look when you get a chance. I'm not very familiar with
> >> symbol versioning details, but it seems like we made a too strong
> >> assumption about verdef always being present. In bash's case we have
> >> VERNEED, but not VERDEF, and that seems to be ok:
> >>
> >
> >Yes, both VERNEED and VERDEF are optional.
>
> Yes.
>
> The .gnu.version table assigns a version index to each .dynsym entry. An
> entry (version ID) corresponds to a Index: entry in .gnu.version_d or a
> Version: entry in .gnu.version_r.
>
> >>   [ 8] .gnu.version      VERSYM          000000000001c9ca 01c9ca
> >> 00130c 02   A  6   0  2
> >>   [ 9] .gnu.version_r    VERNEED         000000000001dcd8 01dcd8
> >> 0000b0 00   A  7   2  8
> >>
> >> So perhaps we need to complete the implementation to take VERNEED into
> >> account. And also let's add a test that can catch an issue like this
> >> going forward. Thanks!
> >>
> >
> >AFAIK, VERNEED contains version requirements for shared libraries.
>
> Yes.
>
> >> > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> >> > index 2a158e8a8b7c..2a62bf411bb3 100644
> >> > --- a/tools/lib/bpf/elf.c
> >> > +++ b/tools/lib/bpf/elf.c
> >> > @@ -141,14 +141,15 @@ static int elf_sym_iter_new(struct elf_sym_ite=
r *iter,
> >> >         iter->versyms =3D elf_getdata(scn, 0);
> >> >
> >> >         scn =3D elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL)=
;
> >> > -       if (!scn) {
> >> > -               pr_debug("elf: failed to find verdef ELF sections in=
 '%s'\n", binary_path);
> >> > -               return -ENOENT;
> >> > -       }
> >> > -       if (!gelf_getshdr(scn, &sh))
> >> > +       if (!scn)
> >> > +               return 0;
> >> > +
> >> > +       iter->verdefs =3D elf_getdata(scn, 0);
> >> > +       if (!iter->verdefs || !gelf_getshdr(scn, &sh)) {
> >> > +               pr_warn("elf: failed to get verdef ELF section in '%=
s'\n", binary_path);
> >> >                 return -EINVAL;
> >> > +       }
> >> >         iter->verdef_strtabidx =3D sh.sh_link;
> >> > -       iter->verdefs =3D elf_getdata(scn, 0);
> >> >
> >> >         return 0;
> >> >  }
> >> > @@ -199,6 +200,9 @@ static const char *elf_get_vername(struct elf_sy=
m_iter *iter, int ver)
> >> >         GElf_Verdef verdef;
> >> >         int offset;
> >> >
> >> > +       if (!iter->verdefs)
> >> > +               return NULL;
> >> > +
> >> >         offset =3D 0;
> >> >         while (gelf_getverdef(iter->verdefs, offset, &verdef)) {
> >> >                 if (verdef.vd_ndx !=3D ver) {
> >> > --
> >> > 2.34.1
> >> >
> >
> >Anyway, this change look good to me, so
> >
> >Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
>
> Looks good to me, too.
>
> Review Reviewed-by: Fangrui Song <maskray@google.com>
>
> ---
>
> I have a question about a previous patch
> "libbpf: Support symbol versioning for uprobe"
> (commit bb7fa09399b937cdc4432ac99f9748f5a7f69389 in next/master).
>
> In the function 'symbol_match',
>
>         /* If user specifies symbol version, for dynamic symbols,
>          * get version name from ELF verdef section for comparison.
>          */
>         if (sh_type =3D=3D SHT_DYNSYM) {
>                 ver_name =3D elf_get_vername(iter, sym->ver);
>                 if (!ver_name)
>                         return false;
>                 return strcmp(ver_name, lib_ver) =3D=3D 0;
>         }
>
> elf_get_vername only checks verdef, not verneed. Is this an issue?
> I am not familiar with tools/lib/bpf or how it is used for uprobe.
>
>

We are dealing with symbols defined in an ELF object,  not the shared libra=
ries
it refers to. So I guess we don't need to handle verneed.

> Is the function intended to match linker behavior?
> Then the rules described at https://maskray.me/blog/2020-11-26-all-about-=
symbol-versioning#linker-behavior
> apply.
> I think the current rules are quite good.
>
>
> >--
> >Hengqi

