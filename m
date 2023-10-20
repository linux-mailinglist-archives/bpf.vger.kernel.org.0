Return-Path: <bpf+bounces-12868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 533957D1790
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 22:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A981C2103F
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059BB23744;
	Fri, 20 Oct 2023 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzrwJJd3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116C1EA90
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 20:52:15 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1149D6A;
	Fri, 20 Oct 2023 13:52:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so1737790a12.2;
        Fri, 20 Oct 2023 13:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697835127; x=1698439927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unUnfck8/CKTv+VT7tj7RrTNM5dM2fjAuO4rpf2gviw=;
        b=dzrwJJd3StIlRKXc6DpRg7hMKFSLOZqYaJacr8OzMdTMnYc1KoglIr7lhc3m6usNZs
         swv/NmJURQ7FlxVdFPmM4Gst8nR/c/Q4VrkCpMIASdMPkmODByFdlRjtjVUo6ANUSJHP
         hczRzMwHEBgoM9Eole3R+/+iVUcm1FpxvnSuDFzNqaUctM9c9RPNM/uMh2N48UMrOVT2
         u591hEl+EcUsssYOPji35I3nw56ZzXWjCGEdhvGlU4TsTy0mBUtEf+lrl25w08VPsjc+
         3aMN1K18dq5hSb3D2je1SK33u+Glff1W41/+sMwmWMWTY1THPDhHcerv/X9ZgKe/2zyg
         C+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697835127; x=1698439927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unUnfck8/CKTv+VT7tj7RrTNM5dM2fjAuO4rpf2gviw=;
        b=tZF1kZlB5Rim+9GfHaMo2WdAVZ4zqJmaitA+RUkOJsOM0804xw/PZZhKXNBvh0y0mW
         OJW75+1DiUabe4DQKeygstassjZHM75LleJX4Mo/fStDLvfiTgb4r5O1lJznFrWCZjiZ
         6ZSmpwrHAfo+3bBy/Pg0IIcod+4YOJffPcpT/aqOX0sFViKiDbf35pV6ixZ7cfoePuFA
         U/IDT2HERMRsZ6oU9kopkjeRf6wO+M8XdFcCQCh9S1J+wvGpLO2zU2aTjwlaHmPHztt0
         BV56/aoBLaWbAukyA3N+RSyLKMlwDgXwP+4PvkocZcWThZqCTfQ7o6HOfRpSnwXAAPrL
         U2Dw==
X-Gm-Message-State: AOJu0Yzs4rRkAOsIeS1OOnJFRzLIyOTliHzHqQGxc2D35WQgQptFpFe5
	RmkIMofd8c7/RI2P4LmX0QiezH5SfvJQAcf0V3Q=
X-Google-Smtp-Source: AGHT+IG4d9h2Ohq91pO5Y0biBu5YbdFQMD6S1GEmWuOw7zaPsAJo5Zi3zpI3YrJb68aQYXmYDgNRqRCVAmBgCEE3Hjg=
X-Received: by 2002:a05:6402:2787:b0:53e:fc60:85bd with SMTP id
 b7-20020a056402278700b0053efc6085bdmr3033561ede.24.1697835126812; Fri, 20 Oct
 2023 13:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018151950.205265-1-masahiroy@kernel.org> <20231018151950.205265-4-masahiroy@kernel.org>
 <ZTDlrkTXnkVN1cff@krava> <CAEf4BzZm4h4q6k9ZhuT5qiWC9PYA+c7XwVFd68iAq4mtMJ-qhw@mail.gmail.com>
 <CAK7LNAR2kKwbzdFxfVXDxsy8pfyQDCR-BN=zpbcZg0JS9RpsKQ@mail.gmail.com>
In-Reply-To: <CAK7LNAR2kKwbzdFxfVXDxsy8pfyQDCR-BN=zpbcZg0JS9RpsKQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 20 Oct 2023 13:51:54 -0700
Message-ID: <CAEf4BzbYwEFSNTFjJyhYmOOK5iwHjFAdcArkUbcQz5ntRvOOvA@mail.gmail.com>
Subject: Re: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 12:03=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Fri, Oct 20, 2023 at 7:55=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Oct 19, 2023 at 1:15=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Oct 19, 2023 at 12:19:50AM +0900, Masahiro Yamada wrote:
> > > > newer_prereqs_except and if_changed_except are ugly hacks of the
> > > > newer-prereqs and if_changed in scripts/Kbuild.include.
> > > >
> > > > Remove.
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > >   - Fix if_changed_except to if_changed
> > > >
> > > >  scripts/Makefile.modfinal | 25 ++++++-------------------
> > > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > > > index 9fd7a26e4fe9..fc07854bb7b9 100644
> > > > --- a/scripts/Makefile.modfinal
> > > > +++ b/scripts/Makefile.modfinal
> > > > @@ -19,6 +19,9 @@ vmlinux :=3D
> > > >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > > >  ifneq ($(wildcard vmlinux),)
> > > >  vmlinux :=3D vmlinux
> > > > +cmd_btf =3D ; \
> > > > +     LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --bt=
f_base vmlinux $@; \
> > > > +     $(RESOLVE_BTFIDS) -b vmlinux $@
> > > >  else
> > > >  $(warning Skipping BTF generation due to unavailability of vmlinux=
)
> > > >  endif
> > > > @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o =3D LD [M]  $@
> > > >        cmd_ld_ko_o +=3D                                            =
     \
> > > >       $(LD) -r $(KBUILD_LDFLAGS)                                   =
   \
> > > >               $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)           =
   \
> > > > -             -T scripts/module.lds -o $@ $(filter %.o, $^)
> > > > +             -T scripts/module.lds -o $@ $(filter %.o, $^)        =
   \
> > > > +     $(cmd_btf)
> > > >
> > > > -quiet_cmd_btf_ko =3D BTF [M] $@
> > >
> > > nit not sure it's intentional but we no longer display 'BTF [M] ...ko=
' lines,
> > > I don't mind not displaying that, but we should mention that in chang=
elog
> > >
> >
> > Thanks for spotting this! I think those messages are useful and
> > important to keep. Masahiro, is it possible to preserve them?
>
>
>
> No, I do not think so.
>

That's too bad, I think it's a useful one.

> Your code is wrong.
>

Could be, but note the comment you are removing:

# Re-generate module BTFs if either module's .ko or vmlinux changed

BTF has to be re-generated not just when module .ko is regenerated,
but also when the vmlinux image itself changes.

I don't see where this is done with your changes. Can you please point
it out explicitly?

>
> To clarify this is a fix,
> I will replace the commit as follows:
>
>
>
>
> ------------------->8----------------------
> kbuild: detect btf command change for modules
>
> Currently, the command change in cmd_btf_ko does not cause to rebuild
> the modules because it is not passed to if_changed.
>
> Pass everything to if_change so that the btf command is also recorded
> in the .*.cmd files. This removes the hacky newer_prereqs_except and
> if_changed_except macros too.
> ------------------->8----------------------
>
>
>
>
> --
> Best Regards
>
> Masahiro Yamada

