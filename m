Return-Path: <bpf+bounces-12897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60E7D1CDF
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 13:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D002B215C9
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27698DF4F;
	Sat, 21 Oct 2023 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1RfshJf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD1D51D
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 11:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7323C433C8;
	Sat, 21 Oct 2023 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697888281;
	bh=CItNLUhgPKWprZgDhoE5AHbH/bbnD7boGHI0AXjLGCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K1RfshJfvG+iK1f5POzdM2+SCvqS01LqDm71qUBujpZCK0J9k5Epc0RxBLUn5QmNy
	 uENT3RhYdkA+ycQxIUPo7eAfTWbRJw3Z/pcKEtg/9OYibGvV1tOlzydDRM5UAdBdcB
	 pBBfgSs/1SorGnF4tBwLGCZqpi3QCbUwMvOVjnEJyt4jnaOlov0Pf9fE9IfmxIdIgq
	 UpwXWZYylq4UwrRpu1quekYcVjKP8FsNaERavFI6uYCutglsIRZ0AczpeW/qXZ2gP8
	 0HD4EScsNKpPEAXP/POpSPQDSkt1L3ntKcQ/PDNQDOi4nMy0Ci3wnVwlceX8p3z0Hy
	 awP9Y4K/dKmuw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso916386fac.0;
        Sat, 21 Oct 2023 04:38:01 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw+oDbnD3IIsXCttUb8bIDZJVMLGlJIRHV41hadFwNAGUyMxnLH
	31R0BOM9osM7qBsdkUFrcSJcCLMawne7v+MgWmA=
X-Google-Smtp-Source: AGHT+IGrABm4SR8tSQm9fY18WWVZBwn80V24irNVJmXvkmY/hGdMR4KZQw8iUGeT2hTqVr7lRaaqAYLvhGurv4IW+uc=
X-Received: by 2002:a05:6870:c087:b0:1e9:dfc3:1e6c with SMTP id
 c7-20020a056870c08700b001e9dfc31e6cmr4318161oad.28.1697888281221; Sat, 21 Oct
 2023 04:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018151950.205265-1-masahiroy@kernel.org> <20231018151950.205265-4-masahiroy@kernel.org>
 <ZTDlrkTXnkVN1cff@krava> <CAEf4BzZm4h4q6k9ZhuT5qiWC9PYA+c7XwVFd68iAq4mtMJ-qhw@mail.gmail.com>
 <CAK7LNAR2kKwbzdFxfVXDxsy8pfyQDCR-BN=zpbcZg0JS9RpsKQ@mail.gmail.com> <CAEf4BzbYwEFSNTFjJyhYmOOK5iwHjFAdcArkUbcQz5ntRvOOvA@mail.gmail.com>
In-Reply-To: <CAEf4BzbYwEFSNTFjJyhYmOOK5iwHjFAdcArkUbcQz5ntRvOOvA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 21 Oct 2023 20:37:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxFgOpuCBYPSx5Z6aw5MtKzPL39XLUvZuUBSyRGnOZUg@mail.gmail.com>
Message-ID: <CAK7LNAQxFgOpuCBYPSx5Z6aw5MtKzPL39XLUvZuUBSyRGnOZUg@mail.gmail.com>
Subject: Re: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 5:52=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 20, 2023 at 12:03=E2=80=AFAM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > On Fri, Oct 20, 2023 at 7:55=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Oct 19, 2023 at 1:15=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com=
> wrote:
> > > >
> > > > On Thu, Oct 19, 2023 at 12:19:50AM +0900, Masahiro Yamada wrote:
> > > > > newer_prereqs_except and if_changed_except are ugly hacks of the
> > > > > newer-prereqs and if_changed in scripts/Kbuild.include.
> > > > >
> > > > > Remove.
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > >   - Fix if_changed_except to if_changed
> > > > >
> > > > >  scripts/Makefile.modfinal | 25 ++++++-------------------
> > > > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > > >
> > > > > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfina=
l
> > > > > index 9fd7a26e4fe9..fc07854bb7b9 100644
> > > > > --- a/scripts/Makefile.modfinal
> > > > > +++ b/scripts/Makefile.modfinal
> > > > > @@ -19,6 +19,9 @@ vmlinux :=3D
> > > > >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > > > >  ifneq ($(wildcard vmlinux),)
> > > > >  vmlinux :=3D vmlinux
> > > > > +cmd_btf =3D ; \
> > > > > +     LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --=
btf_base vmlinux $@; \
> > > > > +     $(RESOLVE_BTFIDS) -b vmlinux $@
> > > > >  else
> > > > >  $(warning Skipping BTF generation due to unavailability of vmlin=
ux)
> > > > >  endif
> > > > > @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o =3D LD [M]  $@
> > > > >        cmd_ld_ko_o +=3D                                          =
       \
> > > > >       $(LD) -r $(KBUILD_LDFLAGS)                                 =
     \
> > > > >               $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)         =
     \
> > > > > -             -T scripts/module.lds -o $@ $(filter %.o, $^)
> > > > > +             -T scripts/module.lds -o $@ $(filter %.o, $^)      =
     \
> > > > > +     $(cmd_btf)
> > > > >
> > > > > -quiet_cmd_btf_ko =3D BTF [M] $@
> > > >
> > > > nit not sure it's intentional but we no longer display 'BTF [M] ...=
ko' lines,
> > > > I don't mind not displaying that, but we should mention that in cha=
ngelog
> > > >
> > >
> > > Thanks for spotting this! I think those messages are useful and
> > > important to keep. Masahiro, is it possible to preserve them?
> >
> >
> >
> > No, I do not think so.
> >
>
> That's too bad, I think it's a useful one.



I prioritize that the code is correct.



>
> > Your code is wrong.
> >
>
> Could be, but note the comment you are removing:
>
> # Re-generate module BTFs if either module's .ko or vmlinux changed
>
> BTF has to be re-generated not just when module .ko is regenerated,
> but also when the vmlinux image itself changes.
>
> I don't see where this is done with your changes. Can you please point
> it out explicitly?



That is too obvious; %.ko depends on $(vmlinux).



%.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE




--=20
Best Regards
Masahiro Yamada

