Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81AF312206
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 07:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhBGGlx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Feb 2021 01:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhBGGlv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Feb 2021 01:41:51 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0254C06174A;
        Sat,  6 Feb 2021 22:41:11 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id w204so11346818ybg.2;
        Sat, 06 Feb 2021 22:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlJNn2KKdJS8oq027oLGrRLJouoIItrT/vD2YNkGOHw=;
        b=mSHENQCgb41UykAZGTFrantO8YmWyku/0TFcPP5cqKruuq3ySSaw1VxSlo1HhKZs5N
         RIQwk13LT4y1g/LfcJW4Zz3o9nfYjq3YYuCWvCTeq/+hVVWxY3QutHvv0LEOVWKbT+Zj
         0kOr93qwW73DRx8wW6wKqfIZN03omJEYjOacbQdcpXQYkRu8KP3g7fzQTTdHILYZ8MlY
         Vx6StR0ksf1WiDm9T9Ht5w/wEwZMsX6c9wWqtjVK+G5HsdwDRoXcBFIL72pQv+YR1v+o
         rXbdTedtb8/ahxs13xAbuAAJ3PXqR3bFqoP68ljwQcClE6RFIUg0cY0f8/zBVAxS9izM
         S0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlJNn2KKdJS8oq027oLGrRLJouoIItrT/vD2YNkGOHw=;
        b=fx5fAQ88swo4myNvEPChENdxn45S5XcCV9z7eXS9U4k9K8GQTc7sVbijvfsuwCFcQ5
         Sbxh9O6PSZplt+ltqD6wXiryDx/KNGBUztF4JcKuYIrvDMQbhFaFmo2dfBx8bBdwq44c
         LT2iFFMKjjDEoMSGi8VtnX6ywqzsHP8aCgvLYZpt1NyWEHjrR6SmsGmBzd4W99hCCesH
         1amjBRmIDkYyj2vTs2dtTOnHk2oL0bGb0CoH5DHmBJUDXB0MBg43zKgQNSA1FiSx4mPL
         9XkKtR84o4maJnAlCqpBc+HkL4yHJ68NQoEwnT8r86ssa8NYpzyEr5pdmw9j+7x+cqIx
         exBQ==
X-Gm-Message-State: AOAM530ynwDoZHJza2ORY7aKIErLy28B4IPB8sUyHbZw5iq8abIBJPuh
        mEkph2iUzHcdY9XNPG+z50MBkNzsVoGYlR/Nono=
X-Google-Smtp-Source: ABdhPJzE1xTH5PozAEBY0r5mGiy0fZrjxpP2a8GHCj9ay+QL39CfBM2X9k60FuKTIQ/iXxPIHgAk9bOEdlMrSQax370=
X-Received: by 2002:a5b:3c4:: with SMTP id t4mr15921211ybp.510.1612680070753;
 Sat, 06 Feb 2021 22:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CAEf4BzY-RbXXW-Ajcvq4fziOJ=tMtT7O76SUboHQyULNDkhthw@mail.gmail.com>
 <C359F19F-29BC-4F6D-961A-79BFA47F36A7@gmail.com> <CAEf4BzZf_1g13dA1t6rbi1TFttufyGNaU14pPxo9uK-FVArCbQ@mail.gmail.com>
 <BFDC3C1D-F87D-4F82-BDB0-444629C484CE@gmail.com> <20210205162523.GF920417@kernel.org>
 <CAEf4BzaXAxOnzkuiOpdMKjQyYHjAN6Td35hDGwbYc9i9aGuj0A@mail.gmail.com> <20210205235537.GE106434@kernel.org>
In-Reply-To: <20210205235537.GE106434@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 6 Feb 2021 22:40:59 -0800
Message-ID: <CAEf4BzYWSJiMcqz-8zR_nxFux427z_JiqLmsLY2cFwJppZD0gg@mail.gmail.com>
Subject: Re: ANNOUNCE: pahole v1.20 (gcc11 DWARF5's default, lots of ELF
 sections, BTF)
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 3:55 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Feb 05, 2021 at 02:11:44PM -0800, Andrii Nakryiko escreveu:
> > On Fri, Feb 5, 2021 at 8:25 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Fri, Feb 05, 2021 at 06:33:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > On February 5, 2021 4:39:47 AM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > >On Thu, Feb 4, 2021 at 8:34 PM Arnaldo Carvalho de Melo ><arnaldo.melo@gmail.com> wrote:
> > > > >> On February 4, 2021 9:01:51 PM GMT-03:00, Andrii Nakryiko
> > > > ><andrii.nakryiko@gmail.com> wrote:
> > > > >> >On Thu, Feb 4, 2021 at 2:09 PM Arnaldo Carvalho de
> > > > >Melo><acme@kernel.org> wrote:
> > > > >> >>         The v1.20 release of pahole and its friends is out, mostly
> > > > >> >> addressing problems related to gcc 11 defaulting to DWARF5 for -g,
> > > > >> >> available at the usual places:
> > >
> > > > >> >Great, thanks, Arnaldo! Do you plan to build RPMs soon as well?
> > >
> > > > >> It's in rawhide already, I'll do it for f33, f32 later,
> > >
> > > > >Do you have a link? I tried to find it, but only see 1.19 so far.
> > >
> > > > https://koji.fedoraproject.org/koji/buildinfo?buildID=1703678
> > >
> > > And now for Fedora 33, waiting for karma bumps at:
> > >
> > > https://bodhi.fedoraproject.org/updates/FEDORA-2021-804e7a572c
> > >
> > > fedpkg buidling for f32 now.
>
> > Ok, imported dwarves-1.20. Had to fix two dates in changelog (in
> > spec), day of week didn't match the date, tooling complained about
> > that. Also had to undo cmake_build and cmake_install fanciness,
> > because apparently we don't have them or the support for it is not
> > great. But otherwise everything else looks to be ok.
>
> Send patch please, I wasn't expecting this, if you could do some more
> and send me tooling bits to help me in the release process, if that is
> possible, I'd love to get it, otherwise I'll write it, don't want to go
> thru this one more time, sigh :-(
>

I just "reverted" some bits of spec file to what it used to be
pre-1.19, I think. There is also a work-around for lack of
ldconfig_scriptlets support in our platform, so I have to work around
that. Here's full diff:

diff -u sources/git/rpm/SPECS/dwarves.spec specfiles/dwarves.spec
--- sources/git/rpm/SPECS/dwarves.spec  2021-02-05 11:19:54.364938716 -0800
+++ specfiles/dwarves.spec      2021-02-05 13:26:52.502859609 -0800
@@ -3,12 +3,14 @@

 Name: dwarves
 Version: 1.20
-Release: 1%{?dist}
+Release: 1fb1%{?dist}
 License: GPLv2
 Summary: Debugging Information Manipulation Tools (pahole & friends)
 URL: http://acmel.wordpress.com
 Source: http://fedorapeople.org/~acme/dwarves/%{name}-%{version}.tar.xz
 Requires: %{libname}%{libver} = %{version}-%{release}
+Requires(post): /sbin/ldconfig
+Requires(postun): /sbin/ldconfig
 BuildRequires: gcc
 BuildRequires: cmake >= 2.8.12
 BuildRequires: zlib-devel
@@ -68,13 +70,14 @@

 %build
 %cmake -DCMAKE_BUILD_TYPE=Release .
-%cmake_build
+make VERBOSE=1 %{?_smp_mflags}

 %install
 rm -Rf %{buildroot}
-%cmake_install
+make install DESTDIR=%{buildroot}

-%ldconfig_scriptlets -n %{libname}%{libver}
+%post -p /sbin/ldconfig
+%postun -p /sbin/ldconfig

 %files
 %doc README.ctracer
@@ -295,7 +298,7 @@
 * Sat Nov 20 2010 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.9-1
 - New release

-* Tue Feb 08 2010 Fedora Release Engineering
<rel-eng@lists.fedoraproject.org> - 1.8-2
+* Mon Feb 08 2010 Fedora Release Engineering
<rel-eng@lists.fedoraproject.org> - 1.8-2
 - Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild

 * Fri Dec  4 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.8-1
@@ -446,7 +449,7 @@
 - Fix emission of arrays of structs, unions, etc
 - use sysconf for the default cacheline size

-* Wed Jan 18 2007 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
+* Thu Jan 18 2007 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
 - fab0db03ea9046893ca110bb2b7d71b764f61033
 - pdwtags added

>
> - Arnaldo
