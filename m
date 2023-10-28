Return-Path: <bpf+bounces-13553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE517DA755
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E94282230
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFA2156C5;
	Sat, 28 Oct 2023 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgJ9+bWa"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1FA8F65
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 13:36:12 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89C6C0;
	Sat, 28 Oct 2023 06:36:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507bd644a96so4306385e87.3;
        Sat, 28 Oct 2023 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698500169; x=1699104969; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AHn8iBxAhpfsJ1tGpFmcP+H91hcjJA0+WNnhiH9LU48=;
        b=PgJ9+bWagXnWGzpjwDMfcEVaytBCj7iIdiLlLw7/hoKRzeZJCn4vOsfIchS/MobuVM
         SFvOF6KO73JyFPnAQ8nudaRp1F+fYHrrOMQEoLiZSXmqg2qnWhFvDAaV1nVdxIbQmP10
         x2u6o1lysyL90am5/HNwq8uITdENS1G7oxa8eP4SbVkTpCPRT0zUJtKo3RM0Y7QOWg48
         twp7mwZNmuGRCO4497CftP5FyIGVArhdWHJQ7I/a7sLFnN19ntOH8LZIu9EUJwk/zJ2c
         bmiG1qSRuTjqq/cbtoG6G0pRti2L+gP2XZPLFfsIvcvQ5Aym0RAlzHQFZp9aD8wPo2jk
         Cs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698500169; x=1699104969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHn8iBxAhpfsJ1tGpFmcP+H91hcjJA0+WNnhiH9LU48=;
        b=B3euwU8e9HBiHPRiiYMVtds4EbpHKPZzlNs42+hV4+nGSR+ckSJtm0KML3pXvTy3Bk
         nBeVGcKWfqJ1I+r6IcRDKBTrIL/m84pviwZEgAlLcd3jgpvTVewSOg++kMs9RWUIQBKg
         ZqOFYumvSlAcFD2eMK10hnjXzfRcelpr/MiIHX71vSb+PPF94yMU8/7qC2El7gQmPP/a
         p6XA3Gy+WejnJZ8RAWYXoVxXmb2vOLNS9S3rETrFC66qxngRmsBjuQFvRHooj7HZiJaN
         Ay94FSIGqSXA6NmsYFE9rymu6rTbS4oNr03Chi3NoLdteaajwDOAfQXKPwI84xpNTgR7
         rK4w==
X-Gm-Message-State: AOJu0YwbsY1Q4tIKgX5eO2Gh8qEkvuHgYrD9dqsP6Qe23IbPo9yEEbfP
	S5iDPYpKAGmo21QJSwV6elg=
X-Google-Smtp-Source: AGHT+IHmsoLQdHcXptq9dP2IARH0nCbjdWTuFJVGv/VB4z72AvQ1VBkpNms0j1/bnNmxE5+f6OnzvA==
X-Received: by 2002:a05:6512:2525:b0:507:b7b7:e740 with SMTP id be37-20020a056512252500b00507b7b7e740mr6506658lfb.43.1698500168527;
        Sat, 28 Oct 2023 06:36:08 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id t17-20020a50c251000000b0053eb69ca1bcsm2891517edf.92.2023.10.28.06.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 06:36:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 28 Oct 2023 15:36:06 +0200
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
Subject: Re: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
Message-ID: <ZT0ORoEdTP7DYX6m@krava>
References: <20231018151950.205265-4-masahiroy@kernel.org>
 <ZTDlrkTXnkVN1cff@krava>
 <CAEf4BzZm4h4q6k9ZhuT5qiWC9PYA+c7XwVFd68iAq4mtMJ-qhw@mail.gmail.com>
 <CAK7LNAR2kKwbzdFxfVXDxsy8pfyQDCR-BN=zpbcZg0JS9RpsKQ@mail.gmail.com>
 <CAEf4BzbYwEFSNTFjJyhYmOOK5iwHjFAdcArkUbcQz5ntRvOOvA@mail.gmail.com>
 <CAK7LNAQxFgOpuCBYPSx5Z6aw5MtKzPL39XLUvZuUBSyRGnOZUg@mail.gmail.com>
 <CAEf4BzZqpqo3j33FkH3QJwezbJwarr1dXs4fCsp5So12_5MmTg@mail.gmail.com>
 <CAK7LNATAuLXCvN5=WiaKv9G4uF-cC2gNe5V-6G55b6fxGNZpeA@mail.gmail.com>
 <CAEf4BzbUqNW5UnhV9bzevtsUUeALca7CthBtzz7NjMCu2ZFmsw@mail.gmail.com>
 <CAK7LNATZJJG1yq1qX7xrvoy4akW2hSAcbrt3mnz=p6F7gMgh1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATZJJG1yq1qX7xrvoy4akW2hSAcbrt3mnz=p6F7gMgh1Q@mail.gmail.com>

On Sat, Oct 28, 2023 at 09:00:11PM +0900, Masahiro Yamada wrote:
> On Mon, Oct 23, 2023 at 12:19 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Oct 22, 2023 at 1:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Sun, Oct 22, 2023 at 4:33 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Sat, Oct 21, 2023 at 4:38 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > >
> > > > > On Sat, Oct 21, 2023 at 5:52 AM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 20, 2023 at 12:03 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > > >
> > > > > > > On Fri, Oct 20, 2023 at 7:55 AM Andrii Nakryiko
> > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Oct 19, 2023 at 1:15 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Oct 19, 2023 at 12:19:50AM +0900, Masahiro Yamada wrote:
> > > > > > > > > > newer_prereqs_except and if_changed_except are ugly hacks of the
> > > > > > > > > > newer-prereqs and if_changed in scripts/Kbuild.include.
> > > > > > > > > >
> > > > > > > > > > Remove.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Changes in v2:
> > > > > > > > > >   - Fix if_changed_except to if_changed
> > > > > > > > > >
> > > > > > > > > >  scripts/Makefile.modfinal | 25 ++++++-------------------
> > > > > > > > > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > > > > > > > > > index 9fd7a26e4fe9..fc07854bb7b9 100644
> > > > > > > > > > --- a/scripts/Makefile.modfinal
> > > > > > > > > > +++ b/scripts/Makefile.modfinal
> > > > > > > > > > @@ -19,6 +19,9 @@ vmlinux :=
> > > > > > > > > >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > > > > > > > > >  ifneq ($(wildcard vmlinux),)
> > > > > > > > > >  vmlinux := vmlinux
> > > > > > > > > > +cmd_btf = ; \
> > > > > > > > > > +     LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
> > > > > > > > > > +     $(RESOLVE_BTFIDS) -b vmlinux $@
> > > > > > > > > >  else
> > > > > > > > > >  $(warning Skipping BTF generation due to unavailability of vmlinux)
> > > > > > > > > >  endif
> > > > > > > > > > @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o = LD [M]  $@
> > > > > > > > > >        cmd_ld_ko_o +=                                                 \
> > > > > > > > > >       $(LD) -r $(KBUILD_LDFLAGS)                                      \
> > > > > > > > > >               $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)              \
> > > > > > > > > > -             -T scripts/module.lds -o $@ $(filter %.o, $^)
> > > > > > > > > > +             -T scripts/module.lds -o $@ $(filter %.o, $^)           \
> > > > > > > > > > +     $(cmd_btf)
> > > > > > > > > >
> > > > > > > > > > -quiet_cmd_btf_ko = BTF [M] $@
> > > > > > > > >
> > > > > > > > > nit not sure it's intentional but we no longer display 'BTF [M] ...ko' lines,
> > > > > > > > > I don't mind not displaying that, but we should mention that in changelog
> > > > > > > > >
> > > > > > > >
> > > > > > > > Thanks for spotting this! I think those messages are useful and
> > > > > > > > important to keep. Masahiro, is it possible to preserve them?
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > No, I do not think so.
> > > > > > >
> > > > > >
> > > > > > That's too bad, I think it's a useful one.
> > > > >
> > > > >
> > > > >
> > > > > I prioritize that the code is correct.
> > > > >
> > > >
> > > > Could you please also prioritize not regressing informativeness of a
> > > > build log? With your changes it's not clear now if BTF was generated
> > > > or not for a kernel module, while previously it was obvious and was
> > > > easy to spot if for some reason BTF was not generated. I'd like to
> > > > preserve this
> > > > property, thank you.
> > > >
> > > > E.g, can we still have BTF generation as a separate command and do a
> > > > separate $(call if_changed,btf_ko)? Or something along those lines.
> > > > Would that work?
> > >
> > > If we have an intermediate file (say, *.no-btf.ko),
> > > it would make sense to have separate
> > > $(call if_changed,ld_ko_o) and $(call if_changed,btf_ko).
> >
> > Currently we don't generate intermediate files, but we do rewrite
> > original .ko file as a post-processing step.
> >
> > And that rewriting step might not happen depending on Kconfig and
> > toolchain (e.g., too old pahole makes it impossible to generate kernel
> > module BTF). And that's why having a separate BTF [M] message in the
> > build log is important.
> >
> > >
> > >
> > >            LD                 RESOLVE_BTFIDS
> > >  *.mod.o  ------> *.no-btf.ko ------------> *.ko
> > >
> > >
> > > When vmlinux is changed, only the second step would
> > > be re-run, but that would require extra file copy.
> >
> > Today we rewrite .ko with a new .ko ELF file which gains a new ELF
> > section (.BTF), so we already pay this price when BTF is enabled (if
> > that's your concern).
> >
> > >
> > > Is this what you want to see?
> >
> > I don't have strong preferences for exact implementation, but what you
> > propose will work, I think. What I'd like to avoid is unnecessarily
> > relinking .ko files if all we need to do is regenerate BTF.
> 
> 
> 
> 
> Is there any way to make pahole/resolve_btfids
> take separate input and output files
> instead of in-place modification?

for pahole I think it'd be possible to get object file with .BTF section
and just link it with other module objects (it's done like that for vmlinux)
but I'm not sure which module linking stage this could happen

for resolve_btfids it's not possible at the moment, it just updates the
.BTF_ids section in the object file

I'm working on changing resolve_btfids to actually generate separate object
with .BTF_ids section, which is then link-ed with the final object, but will
take more time.. especially because I'm not sure where to place this logic
in module linking ;-)

jirka

