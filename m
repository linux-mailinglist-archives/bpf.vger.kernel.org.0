Return-Path: <bpf+bounces-13748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C27247DD63F
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DFAB20F4F
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E9A1DFCA;
	Tue, 31 Oct 2023 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rnk9si2u"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358719BB1
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:44:54 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9A98E;
	Tue, 31 Oct 2023 11:44:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso9418760a12.0;
        Tue, 31 Oct 2023 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698777891; x=1699382691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJHySsbqwM8LKerjskZv3P9RxcKDW9ve4iTD8zU8JSU=;
        b=Rnk9si2uWnU87JIwuJwLg6rqugyshUJ1L9+YhweqV2jRR4ZAj9e7jKSa4U2te9rZyQ
         tdV1kEkwGJZvSlINNHrLTtm8z3+gl7BpVs2nCX22dfnyydpWgA9fOQjV2dXM3fuluspe
         3j3bnN9Wkk6oKTeUKiPlgqQ0cXORhEfvnKSjb22risj3SIcRhbb1roTGlY+RLHe+0gMu
         Kx4YUag4Gdw7yzHNAyfqgXna8Nfr53UBz7RJR3BI6nq0iGrzXl7A0/iaIJ5kFD4Du1DR
         JBEw3AM8S32TY5w2s9Zi0bcG8J5eF2eZ7z2monzQXSrzovyNj4DJfF7tUtJbYMPavmy2
         0TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698777891; x=1699382691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJHySsbqwM8LKerjskZv3P9RxcKDW9ve4iTD8zU8JSU=;
        b=JrWdMPmZApiiaOofbEKYYC1Y5WombUApWspvku24ppC59Gee02U818lyXwXh1/LF6V
         1jfyO9H7tpezk4ebW9vCPhBqlsYgEkMMHIC3zEQM8OLhaTV6xeq+TIT85Yr6Ojgjb/xU
         E4Z9LT7UpKQ3r4aQaiLb9SqBIs4vmu1k7vdVUcWTKVUTjuP2+bfU6jHoMMIu3EO0E5Lt
         B21JuKLcw/9DzStdUFtpZn/9r1Bw8sY4fFFnWNVvl7cuhrGTC6EYGryQY1G4eRUng2So
         yC/C0CljX8hJUXRvw9Nk7OhVga8VSsV72OCFRBQDHoEvFHGNI2AYwNL/eBHkO03jZU7H
         fSAg==
X-Gm-Message-State: AOJu0YwLZMKVTbXfdKoTgMq1/G9IYNelPkPkEdOSqHtT4JLy94whoWY6
	oKwX310tYe2CQpgtrrZJm22xSW2mXLvXjnmeOmmj7wFGOA0=
X-Google-Smtp-Source: AGHT+IHtipnwAwzu+4HsAqAwDAaoWAWe7nbQTsCvLAjNQE9aIggOaz6Krqtua3zBz/6AQCNq8+leZmAUlzRAqFDvheo=
X-Received: by 2002:a17:907:720c:b0:9b7:292:85f6 with SMTP id
 dr12-20020a170907720c00b009b7029285f6mr157231ejc.12.1698777891225; Tue, 31
 Oct 2023 11:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018151950.205265-4-masahiroy@kernel.org> <ZTDlrkTXnkVN1cff@krava>
 <CAEf4BzZm4h4q6k9ZhuT5qiWC9PYA+c7XwVFd68iAq4mtMJ-qhw@mail.gmail.com>
 <CAK7LNAR2kKwbzdFxfVXDxsy8pfyQDCR-BN=zpbcZg0JS9RpsKQ@mail.gmail.com>
 <CAEf4BzbYwEFSNTFjJyhYmOOK5iwHjFAdcArkUbcQz5ntRvOOvA@mail.gmail.com>
 <CAK7LNAQxFgOpuCBYPSx5Z6aw5MtKzPL39XLUvZuUBSyRGnOZUg@mail.gmail.com>
 <CAEf4BzZqpqo3j33FkH3QJwezbJwarr1dXs4fCsp5So12_5MmTg@mail.gmail.com>
 <CAK7LNATAuLXCvN5=WiaKv9G4uF-cC2gNe5V-6G55b6fxGNZpeA@mail.gmail.com>
 <CAEf4BzbUqNW5UnhV9bzevtsUUeALca7CthBtzz7NjMCu2ZFmsw@mail.gmail.com>
 <CAK7LNATZJJG1yq1qX7xrvoy4akW2hSAcbrt3mnz=p6F7gMgh1Q@mail.gmail.com> <ZT0ORoEdTP7DYX6m@krava>
In-Reply-To: <ZT0ORoEdTP7DYX6m@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 11:44:39 -0700
Message-ID: <CAEf4BzYA8TSmcu+pUN89E4DJ_Um8Moaf=sPa012ZXEX28vOgxw@mail.gmail.com>
Subject: Re: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 6:36=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sat, Oct 28, 2023 at 09:00:11PM +0900, Masahiro Yamada wrote:
> > On Mon, Oct 23, 2023 at 12:19=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sun, Oct 22, 2023 at 1:24=E2=80=AFPM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > On Sun, Oct 22, 2023 at 4:33=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Sat, Oct 21, 2023 at 4:38=E2=80=AFAM Masahiro Yamada <masahiro=
y@kernel.org> wrote:
> > > > > >
> > > > > > On Sat, Oct 21, 2023 at 5:52=E2=80=AFAM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Oct 20, 2023 at 12:03=E2=80=AFAM Masahiro Yamada <mas=
ahiroy@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Oct 20, 2023 at 7:55=E2=80=AFAM Andrii Nakryiko
> > > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Oct 19, 2023 at 1:15=E2=80=AFAM Jiri Olsa <olsaji=
ri@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Oct 19, 2023 at 12:19:50AM +0900, Masahiro Yama=
da wrote:
> > > > > > > > > > > newer_prereqs_except and if_changed_except are ugly h=
acks of the
> > > > > > > > > > > newer-prereqs and if_changed in scripts/Kbuild.includ=
e.
> > > > > > > > > > >
> > > > > > > > > > > Remove.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > >   - Fix if_changed_except to if_changed
> > > > > > > > > > >
> > > > > > > > > > >  scripts/Makefile.modfinal | 25 ++++++---------------=
----
> > > > > > > > > > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/scripts/Makefile.modfinal b/scripts/Make=
file.modfinal
> > > > > > > > > > > index 9fd7a26e4fe9..fc07854bb7b9 100644
> > > > > > > > > > > --- a/scripts/Makefile.modfinal
> > > > > > > > > > > +++ b/scripts/Makefile.modfinal
> > > > > > > > > > > @@ -19,6 +19,9 @@ vmlinux :=3D
> > > > > > > > > > >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > > > > > > > > > >  ifneq ($(wildcard vmlinux),)
> > > > > > > > > > >  vmlinux :=3D vmlinux
> > > > > > > > > > > +cmd_btf =3D ; \
> > > > > > > > > > > +     LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHO=
LE_FLAGS) --btf_base vmlinux $@; \
> > > > > > > > > > > +     $(RESOLVE_BTFIDS) -b vmlinux $@
> > > > > > > > > > >  else
> > > > > > > > > > >  $(warning Skipping BTF generation due to unavailabil=
ity of vmlinux)
> > > > > > > > > > >  endif
> > > > > > > > > > > @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o =3D LD [M]  $@
> > > > > > > > > > >        cmd_ld_ko_o +=3D                              =
                   \
> > > > > > > > > > >       $(LD) -r $(KBUILD_LDFLAGS)                     =
                 \
> > > > > > > > > > >               $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODU=
LE)              \
> > > > > > > > > > > -             -T scripts/module.lds -o $@ $(filter %.=
o, $^)
> > > > > > > > > > > +             -T scripts/module.lds -o $@ $(filter %.=
o, $^)           \
> > > > > > > > > > > +     $(cmd_btf)
> > > > > > > > > > >
> > > > > > > > > > > -quiet_cmd_btf_ko =3D BTF [M] $@
> > > > > > > > > >
> > > > > > > > > > nit not sure it's intentional but we no longer display =
'BTF [M] ...ko' lines,
> > > > > > > > > > I don't mind not displaying that, but we should mention=
 that in changelog
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks for spotting this! I think those messages are usef=
ul and
> > > > > > > > > important to keep. Masahiro, is it possible to preserve t=
hem?
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > No, I do not think so.
> > > > > > > >
> > > > > > >
> > > > > > > That's too bad, I think it's a useful one.
> > > > > >
> > > > > >
> > > > > >
> > > > > > I prioritize that the code is correct.
> > > > > >
> > > > >
> > > > > Could you please also prioritize not regressing informativeness o=
f a
> > > > > build log? With your changes it's not clear now if BTF was genera=
ted
> > > > > or not for a kernel module, while previously it was obvious and w=
as
> > > > > easy to spot if for some reason BTF was not generated. I'd like t=
o
> > > > > preserve this
> > > > > property, thank you.
> > > > >
> > > > > E.g, can we still have BTF generation as a separate command and d=
o a
> > > > > separate $(call if_changed,btf_ko)? Or something along those line=
s.
> > > > > Would that work?
> > > >
> > > > If we have an intermediate file (say, *.no-btf.ko),
> > > > it would make sense to have separate
> > > > $(call if_changed,ld_ko_o) and $(call if_changed,btf_ko).
> > >
> > > Currently we don't generate intermediate files, but we do rewrite
> > > original .ko file as a post-processing step.
> > >
> > > And that rewriting step might not happen depending on Kconfig and
> > > toolchain (e.g., too old pahole makes it impossible to generate kerne=
l
> > > module BTF). And that's why having a separate BTF [M] message in the
> > > build log is important.
> > >
> > > >
> > > >
> > > >            LD                 RESOLVE_BTFIDS
> > > >  *.mod.o  ------> *.no-btf.ko ------------> *.ko
> > > >
> > > >
> > > > When vmlinux is changed, only the second step would
> > > > be re-run, but that would require extra file copy.
> > >
> > > Today we rewrite .ko with a new .ko ELF file which gains a new ELF
> > > section (.BTF), so we already pay this price when BTF is enabled (if
> > > that's your concern).
> > >
> > > >
> > > > Is this what you want to see?
> > >
> > > I don't have strong preferences for exact implementation, but what yo=
u
> > > propose will work, I think. What I'd like to avoid is unnecessarily
> > > relinking .ko files if all we need to do is regenerate BTF.
> >
> >
> >
> >
> > Is there any way to make pahole/resolve_btfids
> > take separate input and output files
> > instead of in-place modification?
>
> for pahole I think it'd be possible to get object file with .BTF section
> and just link it with other module objects (it's done like that for vmlin=
ux)
> but I'm not sure which module linking stage this could happen
>
> for resolve_btfids it's not possible at the moment, it just updates the
> .BTF_ids section in the object file
>
> I'm working on changing resolve_btfids to actually generate separate obje=
ct
> with .BTF_ids section, which is then link-ed with the final object, but w=
ill
> take more time.. especially because I'm not sure where to place this logi=
c
> in module linking ;-)

pahole also supports mode of generating BTF into a separate file
without modifying the original one. The option is called
--btf_encode_detached. It was added in v1.22 (currently the minimal
version is v1.16), though, so depending on whether we are willing to
bump the minimum pahole version, we might use that. That will allow us
to also simplify and clean up link-vmlinux.sh a bit, I think.

But I don't know if it's worth the trouble right now.


>
> jirka

