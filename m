Return-Path: <bpf+bounces-12949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE737D25D9
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 22:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9BD1C208C5
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 20:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFECC134C2;
	Sun, 22 Oct 2023 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kka305MK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61828F2
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 20:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB650C433CA;
	Sun, 22 Oct 2023 20:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698006267;
	bh=6qgQxgug/GRhYLwOdrfRf4/6nff3lEa2fYfGDPOlolE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kka305MK0cVIsuCQnHTA5rPP6Yr2Ftzos5kG7TMqOSN/KPDmbIyuMrl+f6s6LsjqY
	 7NOkSJBCv6foeMZC3q0N/s5u44E3tJHPEoAFGDfOj8N7m1WFzMDZns0LR1amUf/67E
	 VSh59IRpmExmqlm5T4pie96Z0BIWCKGtD/KlXApDPRX5bjXeiiufSjKiN67BAayPAc
	 46Ol0AYyVj7HgoxGEY43GBkhZTnAEBK6fhtWEW2FXPnbALEBHJt+oUsx5HxarWFgKw
	 GH87eRuleYI4yhCS+X8LDPxUJBYJL8/vC+HSZpFIQKGK+xjl/GfVRuyxL5Jd0a4thQ
	 NE4d9f2Bbv6hA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3af64a4c97eso1488404b6e.2;
        Sun, 22 Oct 2023 13:24:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YwAkXv/dNcjsDtGp0HZo9phEjalzkHLBq2Q59Rqs4/eTTQaoyYJ
	NczQ+oZIFSndRD0+sDY+JAvASWuHkuYR9q5cOyI=
X-Google-Smtp-Source: AGHT+IHX9aSSseK6AWVzLnXOWbTd5z3dZTAuF70TxtZEgT/qlT7Z5nOtEQ9DXPUnykUWNqgRHyk1LpqpB2JrXF2gfKA=
X-Received: by 2002:a05:6870:a10e:b0:1e9:9c3d:ab89 with SMTP id
 m14-20020a056870a10e00b001e99c3dab89mr7231908oae.32.1698006267013; Sun, 22
 Oct 2023 13:24:27 -0700 (PDT)
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
 <CAK7LNAQxFgOpuCBYPSx5Z6aw5MtKzPL39XLUvZuUBSyRGnOZUg@mail.gmail.com> <CAEf4BzZqpqo3j33FkH3QJwezbJwarr1dXs4fCsp5So12_5MmTg@mail.gmail.com>
In-Reply-To: <CAEf4BzZqpqo3j33FkH3QJwezbJwarr1dXs4fCsp5So12_5MmTg@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 23 Oct 2023 05:23:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAuLXCvN5=WiaKv9G4uF-cC2gNe5V-6G55b6fxGNZpeA@mail.gmail.com>
Message-ID: <CAK7LNATAuLXCvN5=WiaKv9G4uF-cC2gNe5V-6G55b6fxGNZpeA@mail.gmail.com>
Subject: Re: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 4:33=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Oct 21, 2023 at 4:38=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Sat, Oct 21, 2023 at 5:52=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Oct 20, 2023 at 12:03=E2=80=AFAM Masahiro Yamada <masahiroy@k=
ernel.org> wrote:
> > > >
> > > > On Fri, Oct 20, 2023 at 7:55=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Thu, Oct 19, 2023 at 1:15=E2=80=AFAM Jiri Olsa <olsajiri@gmail=
.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 19, 2023 at 12:19:50AM +0900, Masahiro Yamada wrote=
:
> > > > > > > newer_prereqs_except and if_changed_except are ugly hacks of =
the
> > > > > > > newer-prereqs and if_changed in scripts/Kbuild.include.
> > > > > > >
> > > > > > > Remove.
> > > > > > >
> > > > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > >   - Fix if_changed_except to if_changed
> > > > > > >
> > > > > > >  scripts/Makefile.modfinal | 25 ++++++-------------------
> > > > > > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > > > > >
> > > > > > > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.mod=
final
> > > > > > > index 9fd7a26e4fe9..fc07854bb7b9 100644
> > > > > > > --- a/scripts/Makefile.modfinal
> > > > > > > +++ b/scripts/Makefile.modfinal
> > > > > > > @@ -19,6 +19,9 @@ vmlinux :=3D
> > > > > > >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > > > > > >  ifneq ($(wildcard vmlinux),)
> > > > > > >  vmlinux :=3D vmlinux
> > > > > > > +cmd_btf =3D ; \
> > > > > > > +     LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS=
) --btf_base vmlinux $@; \
> > > > > > > +     $(RESOLVE_BTFIDS) -b vmlinux $@
> > > > > > >  else
> > > > > > >  $(warning Skipping BTF generation due to unavailability of v=
mlinux)
> > > > > > >  endif
> > > > > > > @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o =3D LD [M]  $@
> > > > > > >        cmd_ld_ko_o +=3D                                      =
           \
> > > > > > >       $(LD) -r $(KBUILD_LDFLAGS)                             =
         \
> > > > > > >               $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)     =
         \
> > > > > > > -             -T scripts/module.lds -o $@ $(filter %.o, $^)
> > > > > > > +             -T scripts/module.lds -o $@ $(filter %.o, $^)  =
         \
> > > > > > > +     $(cmd_btf)
> > > > > > >
> > > > > > > -quiet_cmd_btf_ko =3D BTF [M] $@
> > > > > >
> > > > > > nit not sure it's intentional but we no longer display 'BTF [M]=
 ...ko' lines,
> > > > > > I don't mind not displaying that, but we should mention that in=
 changelog
> > > > > >
> > > > >
> > > > > Thanks for spotting this! I think those messages are useful and
> > > > > important to keep. Masahiro, is it possible to preserve them?
> > > >
> > > >
> > > >
> > > > No, I do not think so.
> > > >
> > >
> > > That's too bad, I think it's a useful one.
> >
> >
> >
> > I prioritize that the code is correct.
> >
>
> Could you please also prioritize not regressing informativeness of a
> build log? With your changes it's not clear now if BTF was generated
> or not for a kernel module, while previously it was obvious and was
> easy to spot if for some reason BTF was not generated. I'd like to
> preserve this
> property, thank you.
>
> E.g, can we still have BTF generation as a separate command and do a
> separate $(call if_changed,btf_ko)? Or something along those lines.
> Would that work?

If we have an intermediate file (say, *.no-btf.ko),
it would make sense to have separate
$(call if_changed,ld_ko_o) and $(call if_changed,btf_ko).


           LD                 RESOLVE_BTFIDS
 *.mod.o  ------> *.no-btf.ko ------------> *.ko


When vmlinux is changed, only the second step would
be re-run, but that would require extra file copy.

Is this what you want to see?





>
> >
> >
> > >
> > > > Your code is wrong.
> > > >
> > >
> > > Could be, but note the comment you are removing:
> > >
> > > # Re-generate module BTFs if either module's .ko or vmlinux changed
> > >
> > > BTF has to be re-generated not just when module .ko is regenerated,
> > > but also when the vmlinux image itself changes.
> > >
> > > I don't see where this is done with your changes. Can you please poin=
t
> > > it out explicitly?
> >
> >
> >
> > That is too obvious; %.ko depends on $(vmlinux).
>
> Thank you for your gracious answer. We used to not rebuild module's
> .ko's when vmlinux didn't change (but we did regen BTFs), and that's
> why I was confused. Now we forcefully recompile modules, which is a
> change in behavior which would be nice to call out in the commit
> message.
>
>
> >
> >
> >
> > %.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE
> >
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada



--=20
Best Regards
Masahiro Yamada

