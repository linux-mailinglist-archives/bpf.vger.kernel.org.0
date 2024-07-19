Return-Path: <bpf+bounces-35121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D08A937DD2
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 00:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23791F22302
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 22:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710C914882E;
	Fri, 19 Jul 2024 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcdd3tYq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E040137E
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721427955; cv=none; b=FVYOYCcc6/1xD057bKuQ3CdHItv7q4S5hG6AZuJcjEqd0u09Pi9HKixnPgYlAFHSydJR9NzsN8ag+IQZI+qpMx2snNBgT1yeILy3BV4yp1titcqXOGdSnfgSLFpUylIHaeYnR+X51xM2mTUWB7bhIAlRhnCjDgzdmsOGlLHnVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721427955; c=relaxed/simple;
	bh=C8+EEEks87s/7pcISEuYw/sbnzmDWrm2cwXDGHYRde8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHX2ddFZCz3Lq9jA8nHJEDX8btbXjEgcRrzHkodJiYqeTWhOI5rq2Ap5Yh+3dQ9PgWLHjD7Y64Z8q/CSrcUTXSIrkJ4rSNHvMNqfMwoYg/zq563akS5IRXxz4oxgrhfpCf73l/Pto1IWjHk9BlvIOyUic0fMHg0LiJBcFyJdIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zcdd3tYq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb53da06a9so1379692a91.0
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721427953; x=1722032753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lAJRG6b/ofFMhwgsR/o/jJuUy8Jdzq03EazxpfnO8c=;
        b=Zcdd3tYqfbASl2gkQOZhAh5xDc5uiCEQBdeMipfGs2NP9bCbdxEaV2EDtVrUs+ohJD
         18lMGIqb+FUbWy5c5n/RDaZPq2bxBqKhC9iDm50Bm5ZUDd1xJ3AdFLUa7TGdIiPlIZLr
         rFSmNuwo4QwNXNwseo00jOl9yDbVG+TDGqa7+zRNNplrruN9ZM1ErXnzSU5TOTEKGYJa
         m50Vl9cltMja6NdjENjphc9s64/ITepR9Z5D1E8HdBh8wpeQYptoUviaPI22iP/LWVDr
         RkesqV0Iy2yzS9McgSxEFJEyE4BG9j7G6E/BVSOkgD1dpfpz3c1fGrw0/guRd+vzhfjE
         flYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721427953; x=1722032753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lAJRG6b/ofFMhwgsR/o/jJuUy8Jdzq03EazxpfnO8c=;
        b=NvawjJPiIODPHU3IpTgfTFNJBD4OlEK1Pza19LkpHr3rFTpPMu5wnRg3pGOKJI99Ao
         hF5TKAeyxb8dqmJQq3JgGrUy2GVPQmMS32p97UUs1RQxwxVG1Hhg5nHc9g5FNcX5OEkT
         aIPJi7iigPv+ETtV8hWo9GnExCyOX20AkmbOmQGvsgi7cTnJC4SnyZcvMbt0Ujy6aYgW
         ppkg0KbVpaiXePbKprV8GlzxQCTYmIi6RD3RwlQfvug/G/QsKgIcQzAZU45q9lkDBpGb
         mHYUbQgK1DDeKpLIHkODB6QAOH9qzH8FMAcuaoNczNRvcYLDwAQq0prZ//wyD4pW7L43
         wcLg==
X-Forwarded-Encrypted: i=1; AJvYcCUXQU4UK2QzhI5MftUrKLrzdc/v5LUnkdSXjFOykVa6GuLxy+F1gf3S5lEfD1mUYnet8ItHAc+GcSRj3oNihS8n5w39
X-Gm-Message-State: AOJu0Yy88EDhT1yqdXb9ty8cFGFE0zoISZsQpzn0Shcqi6XQj5blG6J4
	RvIM/sC7rXyjvxwZ62gYIoLdukWQh96v2BGthRrNV7Jx84cB+bat+n9b4x8KJ1RccF0U5O2UC4j
	l3WW/h1KC6xlxQly9/4pUvkafpAXWcg==
X-Google-Smtp-Source: AGHT+IER9d9Xosapr54QAmKnznwKHyInJ9CmsDaeSnGGIUOOuBtgO9sgpaFo8vkSqtwDhh/Ig+lp/EqI5TGvm26b41k=
X-Received: by 2002:a17:90a:fb42:b0:2c9:7f8b:f7d8 with SMTP id
 98e67ed59e1d1-2cd16d423b9mr1558183a91.6.1721427952688; Fri, 19 Jul 2024
 15:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
 <CAEf4BzYX=sfVGcEYq=KSmnC28cqUsRpN=fCwRuUpOMrYAfzzHg@mail.gmail.com> <Zprglznwj5h1/Wps@kodidev-ubuntu>
In-Reply-To: <Zprglznwj5h1/Wps@kodidev-ubuntu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 15:25:40 -0700
Message-ID: <CAEf4BzarKiUZqNcq1E+6SaeG8oP5+SfSLLoTNKF3_+7MS6CtyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for test objects
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"ast@kernel.org" <ast@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, "mykolal@fb.com" <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 2:54=E2=80=AFPM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> On Fri, Jul 19, 2024 at 11:18:16AM -0700, Andrii Nakryiko wrote:
> > On Thu, Jul 18, 2024 at 3:57=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm=
.me> wrote:
> > >
> > > Make use of -M compiler options when building .test.o objects to
> > > generate .d files and avoid re-building all tests every time.
> > >
> > > Previously, if a single test bpf program under selftests/bpf/progs/*.=
c
> > > has changed, make would rebuild all the *.bpf.o, *.skel.h and *.test.=
o
> > > objects, which is a lot of unnecessary work.
> > >
> > > A typical dependency chain is:
> > > progs/x.c -> x.bpf.o -> x.skel.h -> x.test.o -> trunner_binary
> > >
> > > However for many tests it's not a 1:1 mapping by name, and so far
> > > %.test.o have been simply dependent on all %.skel.h files, and
> > > %.skel.h files on all %.bpf.o objects.
> > >
> > > Avoid full rebuilds by instructing the compiler (via -MMD) to
> > > produce *.d files with real dependencies, and appropriately including
> > > them. Exploit make feature that rebuilds included makefiles if they
> > > were changed by setting %.test.d as prerequisite for %.test.o files.
> > >
> > > A couple of examples of compilation time speedup (after the first
> > > clean build):
> > >
> > > $ touch progs/verifier_and.c && time make -j8
> > > Before: real    0m16.651s
> > > After:  real    0m2.245s
> > > $ touch progs/read_vsyscall.c && time make -j8
> > > Before: real    0m15.743s
> > > After:  real    0m1.575s
> > >
> > > A drawback of this change is that now there is an overhead due to mak=
e
> > > processing lots of .d files, which potentially may slow down unrelate=
d
> > > targets. However a time to make all from scratch hasn't changed
> > > significantly:
> > >
> > > $ make clean && time make -j8
> > > Before: real    1m31.148s
> > > After:  real    1m30.309s
> > >
> > > Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> > >
> > > ---
> > > v3 -> v4: Make $(TRUNNER_BPF_OBJS) order only prereq of trunner binar=
y
> > > v2 -> v3: Restore dependency on $(TRUNNER_BPF_OBJS)
> > > v1 -> v2: Make %.test.d prerequisite order only
> > > ---
> > >  tools/testing/selftests/bpf/.gitignore |  1 +
> > >  tools/testing/selftests/bpf/Makefile   | 44 +++++++++++++++++++-----=
--
> > >  2 files changed, 34 insertions(+), 11 deletions(-)
> > >
> >
> > It seems to behave correctly, but it reports wrong flavor when
> > building .bpf.o, e.g.,:
> >
> Hi Andrii,
>
> This is actually an old, confusing bug unrelated to the current (very
> nice) improvements. I have a fix as part of a larger series
> targeting libc portability and MIPS support which I'll post shortly.  Or
> I can send separately if you like?

Please send it separately, having small targeted Makefile changes
makes it much easier to test, review, and land them quickly.

>
> Thanks,
> Tony
>
> > $ touch progs/test_vmlinux.c
> > $ make -j90
> >   CLNG-BPF [test_maps] test_vmlinux.bpf.o
> >   CLNG-BPF [test_maps] test_vmlinux.bpf.o
> >   CLNG-BPF [test_maps] test_vmlinux.bpf.o
> >   GEN-SKEL [test_progs] test_vmlinux.skel.h
> >   GEN-SKEL [test_progs-cpuv4] test_vmlinux.skel.h
> >   GEN-SKEL [test_progs-no_alu32] test_vmlinux.skel.h
> >   TEST-OBJ [test_progs] vmlinux.test.o
> >   TEST-OBJ [test_progs-no_alu32] vmlinux.test.o
> >   EXT-COPY [test_progs-no_alu32] urandom_read bpf_testmod.ko
> > bpf_test_no_cfi.ko liburandom_read.so xdp_synproxy sign-file
> > uprobe_multi ima_setup.sh verify_sig_setup.sh
> > btf_dump_test_case_bitfields.c btf_dump_test_case_multidim.c
> > btf_dump_test_case_namespacing.c btf_dump_test_case_ordering.c
> > btf_dump_test_case_packing.c btf_dump_test_case_padding.c
> > btf_dump_test_case_syntax.c
> >   TEST-OBJ [test_progs-cpuv4] vmlinux.test.o
> >   EXT-COPY [test_progs-cpuv4] urandom_read bpf_testmod.ko
> > bpf_test_no_cfi.ko liburandom_read.so xdp_synproxy sign-file
> > uprobe_multi ima_setup.sh verify_sig_setup.sh
> > btf_dump_test_case_bitfields.c btf_dump_test_case_multidim.c
> > btf_dump_test_case_namespacing.c btf_dump_test_case_ordering.c
> > btf_dump_test_case_packing.c btf_dump_test_case_padding.c
> > btf_dump_test_case_syntax.c
> > make[1]: Nothing to be done for 'docs'.
> >   BINARY   test_progs
> >   BINARY   test_progs-no_alu32
> >   BINARY   test_progs-cpuv4
> > $ ls -la test_vmlinux.bpf.o no_alu32/test_vmlinux.bpf.o cpuv4/test_vmli=
nux.bpf.o
> > -rw-r--r-- 1 andriin users 21344 Jul 19 11:08 cpuv4/test_vmlinux.bpf.o
> > -rw-r--r-- 1 andriin users 21408 Jul 19 11:08 no_alu32/test_vmlinux.bpf=
.o
> > -rw-r--r-- 1 andriin users 21408 Jul 19 11:08 test_vmlinux.bpf.o
> >
> >
> > Note [test_maps] for all three variants (I expected
> > test_maps/test_progs + no_alu32 + cpuv4, just like we see for skel.h).
> > Can you please double check what's going on? Looking at timestamps it
> > seems like they are actually regenerated, though.
> >
> >
> > BTW, if you get a chance, see if you can avoid unnecessary EXT-COPY as
> > well (probably a bit smarter rule dependency should be set up, e.g.,
> > phony target that then depends on actual files or something like
> > that).
> >
> > Regardless, this is a massive improvement and seems to work correctly,
> > so I've applied this and will wait for follow ups. Thanks a lot!
> >
> > BTW, are you planning to look into vmlinux.h optimization as well?
> >
> > > diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/s=
elftests/bpf/.gitignore
> > > index 5025401323af..4e4aae8aa7ec 100644
> > > --- a/tools/testing/selftests/bpf/.gitignore
> > > +++ b/tools/testing/selftests/bpf/.gitignore
> > > @@ -31,6 +31,7 @@ test_tcp_check_syncookie_user
> > >  test_sysctl
> > >  xdping
> > >  test_cpp
> > > +*.d
> > >  *.subskel.h
> > >  *.skel.h
> > >  *.lskel.h
> >
> > [...]

