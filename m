Return-Path: <bpf+bounces-13552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2497DA6D1
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 14:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832FD282412
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 12:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2561428E;
	Sat, 28 Oct 2023 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxlCZaOm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41ACFC00
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 12:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1DCC433C7;
	Sat, 28 Oct 2023 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698494448;
	bh=NDYeMPRVIZz698JsT+R8LnMI83Zt/EWY2nxoFqm580c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rxlCZaOmJmY70MKRHjymf2B7cedbaw9IX9qFJSPtCk0aoWz8Ty5+APG/TH07kSU9z
	 VliVCxfQjJDI2O1M2j5uhx+vNxAU3X04lEfokPRhT2s2i+BAZ8QWDYMB8rSVzgHoUp
	 aK6XKdGYQp+ybnxwJAweKUifflgcODEEjaxPgsmvrU4ZTKhFKgttDPPi8SV6BjTvXB
	 gVHh+jswdeYnm5+89yA4yMIpZaL7udwJGsf0ZmNmiEagnXsfTygUTk2DJi0WuwcAHl
	 AFmLDjbqe3ZXkfrh5zVIih1O17/nkXNP+Dzia74MbBg1c0Vq1PNoksgo9kzhd5s9BE
	 Cd4v9LiVjIfOw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-581ed744114so1580543eaf.0;
        Sat, 28 Oct 2023 05:00:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YzoGjSiKwZnok3TdMir2S1wksCS11C758VXVC5/9um3OUS/qEsu
	TbbarzSRk/rQc1KkN53aJ/XDkSCkZri9Ij7o8/Q=
X-Google-Smtp-Source: AGHT+IG+2xU/Or55TAC3vgQMu5b2z0oZrGlRxgQwoIkOy4bOeE3S4CWNahsGeJWTR25wZIp8RhGB7o1L63jeZhgyr6M=
X-Received: by 2002:a05:6871:8198:b0:1e9:858e:ff23 with SMTP id
 so24-20020a056871819800b001e9858eff23mr4354359oab.55.1698494447492; Sat, 28
 Oct 2023 05:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018151950.205265-1-masahiroy@kernel.org> <20231018151950.205265-4-masahiroy@kernel.org>
 <ZTDlrkTXnkVN1cff@krava> <CAEf4BzZm4h4q6k9ZhuT5qiWC9PYA+c7XwVFd68iAq4mtMJ-qhw@mail.gmail.com>
 <CAK7LNAR2kKwbzdFxfVXDxsy8pfyQDCR-BN=zpbcZg0JS9RpsKQ@mail.gmail.com>
 <CAEf4BzbYwEFSNTFjJyhYmOOK5iwHjFAdcArkUbcQz5ntRvOOvA@mail.gmail.com>
 <CAK7LNAQxFgOpuCBYPSx5Z6aw5MtKzPL39XLUvZuUBSyRGnOZUg@mail.gmail.com>
 <CAEf4BzZqpqo3j33FkH3QJwezbJwarr1dXs4fCsp5So12_5MmTg@mail.gmail.com>
 <CAK7LNATAuLXCvN5=WiaKv9G4uF-cC2gNe5V-6G55b6fxGNZpeA@mail.gmail.com> <CAEf4BzbUqNW5UnhV9bzevtsUUeALca7CthBtzz7NjMCu2ZFmsw@mail.gmail.com>
In-Reply-To: <CAEf4BzbUqNW5UnhV9bzevtsUUeALca7CthBtzz7NjMCu2ZFmsw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 28 Oct 2023 21:00:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZJJG1yq1qX7xrvoy4akW2hSAcbrt3mnz=p6F7gMgh1Q@mail.gmail.com>
Message-ID: <CAK7LNATZJJG1yq1qX7xrvoy4akW2hSAcbrt3mnz=p6F7gMgh1Q@mail.gmail.com>
Subject: Re: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 12:19=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Oct 22, 2023 at 1:24=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Sun, Oct 22, 2023 at 4:33=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sat, Oct 21, 2023 at 4:38=E2=80=AFAM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > On Sat, Oct 21, 2023 at 5:52=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Fri, Oct 20, 2023 at 12:03=E2=80=AFAM Masahiro Yamada <masahir=
oy@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Oct 20, 2023 at 7:55=E2=80=AFAM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 19, 2023 at 1:15=E2=80=AFAM Jiri Olsa <olsajiri@g=
mail.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Oct 19, 2023 at 12:19:50AM +0900, Masahiro Yamada w=
rote:
> > > > > > > > > newer_prereqs_except and if_changed_except are ugly hacks=
 of the
> > > > > > > > > newer-prereqs and if_changed in scripts/Kbuild.include.
> > > > > > > > >
> > > > > > > > > Remove.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Changes in v2:
> > > > > > > > >   - Fix if_changed_except to if_changed
> > > > > > > > >
> > > > > > > > >  scripts/Makefile.modfinal | 25 ++++++-------------------
> > > > > > > > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile=
.modfinal
> > > > > > > > > index 9fd7a26e4fe9..fc07854bb7b9 100644
> > > > > > > > > --- a/scripts/Makefile.modfinal
> > > > > > > > > +++ b/scripts/Makefile.modfinal
> > > > > > > > > @@ -19,6 +19,9 @@ vmlinux :=3D
> > > > > > > > >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > > > > > > > >  ifneq ($(wildcard vmlinux),)
> > > > > > > > >  vmlinux :=3D vmlinux
> > > > > > > > > +cmd_btf =3D ; \
> > > > > > > > > +     LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_F=
LAGS) --btf_base vmlinux $@; \
> > > > > > > > > +     $(RESOLVE_BTFIDS) -b vmlinux $@
> > > > > > > > >  else
> > > > > > > > >  $(warning Skipping BTF generation due to unavailability =
of vmlinux)
> > > > > > > > >  endif
> > > > > > > > > @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o =3D LD [M]  $@
> > > > > > > > >        cmd_ld_ko_o +=3D                                  =
               \
> > > > > > > > >       $(LD) -r $(KBUILD_LDFLAGS)                         =
             \
> > > > > > > > >               $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE) =
             \
> > > > > > > > > -             -T scripts/module.lds -o $@ $(filter %.o, $=
^)
> > > > > > > > > +             -T scripts/module.lds -o $@ $(filter %.o, $=
^)           \
> > > > > > > > > +     $(cmd_btf)
> > > > > > > > >
> > > > > > > > > -quiet_cmd_btf_ko =3D BTF [M] $@
> > > > > > > >
> > > > > > > > nit not sure it's intentional but we no longer display 'BTF=
 [M] ...ko' lines,
> > > > > > > > I don't mind not displaying that, but we should mention tha=
t in changelog
> > > > > > > >
> > > > > > >
> > > > > > > Thanks for spotting this! I think those messages are useful a=
nd
> > > > > > > important to keep. Masahiro, is it possible to preserve them?
> > > > > >
> > > > > >
> > > > > >
> > > > > > No, I do not think so.
> > > > > >
> > > > >
> > > > > That's too bad, I think it's a useful one.
> > > >
> > > >
> > > >
> > > > I prioritize that the code is correct.
> > > >
> > >
> > > Could you please also prioritize not regressing informativeness of a
> > > build log? With your changes it's not clear now if BTF was generated
> > > or not for a kernel module, while previously it was obvious and was
> > > easy to spot if for some reason BTF was not generated. I'd like to
> > > preserve this
> > > property, thank you.
> > >
> > > E.g, can we still have BTF generation as a separate command and do a
> > > separate $(call if_changed,btf_ko)? Or something along those lines.
> > > Would that work?
> >
> > If we have an intermediate file (say, *.no-btf.ko),
> > it would make sense to have separate
> > $(call if_changed,ld_ko_o) and $(call if_changed,btf_ko).
>
> Currently we don't generate intermediate files, but we do rewrite
> original .ko file as a post-processing step.
>
> And that rewriting step might not happen depending on Kconfig and
> toolchain (e.g., too old pahole makes it impossible to generate kernel
> module BTF). And that's why having a separate BTF [M] message in the
> build log is important.
>
> >
> >
> >            LD                 RESOLVE_BTFIDS
> >  *.mod.o  ------> *.no-btf.ko ------------> *.ko
> >
> >
> > When vmlinux is changed, only the second step would
> > be re-run, but that would require extra file copy.
>
> Today we rewrite .ko with a new .ko ELF file which gains a new ELF
> section (.BTF), so we already pay this price when BTF is enabled (if
> that's your concern).
>
> >
> > Is this what you want to see?
>
> I don't have strong preferences for exact implementation, but what you
> propose will work, I think. What I'd like to avoid is unnecessarily
> relinking .ko files if all we need to do is regenerate BTF.




Is there any way to make pahole/resolve_btfids
take separate input and output files
instead of in-place modification?

Otherwise, explicit "cp *.no-btf.ko *.ko" would be needed.





--
Best Regards
Masahiro Yamada

