Return-Path: <bpf+bounces-35053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1836F937326
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 07:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D1C1F21EA1
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 05:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F380B2CCB7;
	Fri, 19 Jul 2024 05:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c76CAXRU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9710E5
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 05:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721365342; cv=none; b=bHpqADaew7g+aVTHPjrKwBP4CuUFPJVaDYt6IKJoxL3r3TTx5b9qGyuzLFSTlCW9nQyKBJLyVe2DiFCt//iSJ6yjLUKWr/J7AQXB9f0OPRjWFKdhHTgi7cgptmRfPVbektw8STAISBrm/QCxxQc6dD3bCG05TLaYEym291LU4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721365342; c=relaxed/simple;
	bh=1zAnjjxwlHrSqEivofLHUkkA7NVmBtF+UALomTNeb2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxbjpgjySDGm/8EIFA03w8iz58Vw6S1TBPzYYJKgtJ2HJkX0fougW1lg4GUr5mZzujl3dlZzBrWhaTq3tVHlHLsRQKZ0L7CzqLbDwby/pSfjJP0EKRBVxlM5fGLqHhKwGMa7e15L2fqj4Te5mEFWs5MtTywhH4xaWOl9FIEfRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c76CAXRU; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-79b530ba612so944740a12.2
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 22:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721365340; x=1721970140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIADAEWkzVb2tBwFrLdVxSI83Xu7uaIbQ5gQh9K1Vgo=;
        b=c76CAXRUB9gaumFnMYIVEIIugqL0SOqJM78Bz9Diap4xfwikPyHLgs+t9oOUwKGMaf
         C/SBnzPm+o8RoSkBpTs+bzVAOag/y0OwqL0VrAmNq5tTbO82S5UuEZKMLJeW/Y8rg+XJ
         X2gYxiRSrx8uwoIwx3bcxgdwDlD1Fv1v89imaWdDfulh6hn5/Pw88txwS99PMub8zptF
         k83aOLjyWzO/ufrIehZseegisx1UyZu1seXjGLQxlQHmi0Nb76IBR7q04VBk4wZucXoT
         9kuvBtTpfJ2hfi7M8+JEhKSrNHfcevksG+fYJTCgtjNtX7qcFQwXo6hAApVblbhdNl2w
         tvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721365340; x=1721970140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIADAEWkzVb2tBwFrLdVxSI83Xu7uaIbQ5gQh9K1Vgo=;
        b=VZbJwOfJG5fjBR4qGo/N1/wb2iy5PBSZ6aDHbRPfjjPwAAJOD8E/FvALq9oHgl+TMe
         462e+B4yZ3xgT2FsZldpxEFNbR4O/b5W1xrZwpOeeyMfyMkLwT3qfiJ5JeVr1H0TImqc
         zjO+I3IahkEqnm7Jy/2jdx3kRdva7JiFWHdKm/GwzyhOgsiAcuz0hPqKOx4cE/Xh78Yt
         iQccOJERLTooqimDU76ltCZG1v4J3eYb2REvT4ioMRzZx935sgmauYTq15u+7nuPAX1d
         7cBhyial4MkGBAD0jkAvjV+H5QqfusTTamaqAx4g9HxErfRcKYGliRmfcjTZCfLmztYg
         m6QA==
X-Forwarded-Encrypted: i=1; AJvYcCXWKB0iPbpDNVz98UDWD2nupdPxmdJy9ZtvOxMw4uI1LP+0eFH4CvinIEurV3WH6iSSz/OaJWSiMX7HS15dGE/05vz4
X-Gm-Message-State: AOJu0Yzp3yt9uSwUuq0NKDVno1Imtz0nPUrbdeGmtoqp62u9mrl66Pnv
	FtXK2qVKR2HTvQxQh8AnS25mLOvbR++qwyPmpCQ+XOOfDHBXlnOEOK+xmKcxyIQBwu4lBZGvqLJ
	/5HPwOPoUrCaN0VzTtLteLg2D5Dw=
X-Google-Smtp-Source: AGHT+IE9mKMLiG17AMpT8t17LGbad9/IQkQWJqBLLQCUFSu+zILQ9ICa5fxaZKqwDThkF5pghfxqrYAv15y+WEVcAUU=
X-Received: by 2002:a05:6a20:734f:b0:1c2:8b95:de15 with SMTP id
 adf61e73a8af0-1c3fddd1be9mr8804022637.53.1721365340165; Thu, 18 Jul 2024
 22:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
 <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com>
 <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com>
 <k7SpuAM7weZyfgdgXEHzOiDkk8iBsBrl7ZsTpvhKQNvijS8cWjJrBN9DVOxF45edRXxA2POvIu9cZce3bF2FmoFOEbfevr09X-1c1pKgZrw=@pm.me>
 <CAEf4Bzatg_CsKf7HeekaO3ZroXWg1ceJBgZ9KPWf2VkK1yKQ6Q@mail.gmail.com>
 <bcee1451ef43fd08675e1296b1ce82058cd29d94.camel@gmail.com>
 <CAEf4BzaLatHkXGZ5pmNSC+b5_iZKBeeGqkS-VE8SwXQySviUHg@mail.gmail.com>
 <e33b186a5f728a96987347964a622cab64543189.camel@gmail.com>
 <CAEf4BzZ+eDUAN8LE4duRqY+W4BkXoVx_TZbWj6fVLNzm9EeVsg@mail.gmail.com> <qPy-7H7OLM_5N6g_SybDgMR7qG82-h_mvpJ6zx6r9hpvtTOpxT3qKYbK8PbvkVACTLVcP-REWGKXcPDGIVjuYi1EBEVPIiJeSgzAIcw1Llc=@pm.me>
In-Reply-To: <qPy-7H7OLM_5N6g_SybDgMR7qG82-h_mvpJ6zx6r9hpvtTOpxT3qKYbK8PbvkVACTLVcP-REWGKXcPDGIVjuYi1EBEVPIiJeSgzAIcw1Llc=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Jul 2024 22:02:08 -0700
Message-ID: <CAEf4BzY1z5cC7BKye8=A8aTVxpsCzD=p1jdTfKC7i0XVuYoHUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test objects
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 3:42=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> On Thursday, July 18th, 2024 at 8:34 AM, Andrii Nakryiko <andrii.nakryiko=
@gmail.com> wrote:
>
> [...]
>
> > > > > - by adding a catch-all clause in the makefile, e.g. making test
> > > > > runner depend on all .bpf.o files.
> > > >
> > > > do we actually need to rebuild final binary if we are still just
> > > > loading .bpf.o from disk? We are not embedding such .bpf.o (embeddi=
ng
> > > > is what skeleton headers are adding), so why rebuild .bpf.o?
> > > >
> > > > Actually thinking about this again, I guess, if we don't want to ad=
d
> > > > skel.h to track precise dependencies, we don't really need to do
> > > > anything extra for those progs/*.c files that are not used through
> > > > skeletons. We just need to make sure that they are rebuilt if they =
are
> > > > changed. The rest will work as is because test runner binary will j=
ust
> > > > load them from disk at the next run (and user space part doesn't ha=
ve
> > > > to be rebuilt, unless it itself changed).
> > >
> > > Good point. This can be achieved by making $(OUTPUT)/$(TRUNNER_BINARY=
)
> > > dependency on $(TRUNNER_BPF_OBJS) order-only, e.g. here is a modified
> > > version of the v2: https://tinyurl.com/4wnhkt32
> >
> >
> > +1
>
> I agree. I'll submit v4 with this change.
>
>
> > > [...]
> > >
> > > > another side benefit of completely switching to .skel.h is that we =
can
> > > > stop copying all .bpf.o files into BPF CI, because test_progs will =
be
> > > > self-contained (thought that's not 100% true due to btf__* and mayb=
e a
> > > > few files more, which is sad and a bit different problem)
> > >
> > > Hm, this might make sense.
> > > There are 410Mb of .bpf.o files generated currently.
> > > On the other hand, as you note, one would still need a list of some
> > > .bpf.o files, because there are at-least several tests that verify
> > > operation on ELF files, not ELF bytes.
>
> This seems worthwhile to look into, although I think it's a task
> independent of this patch.
>
>
> > > [...]
> > >
> > > > keep in mind that we do want to rebuild .bpf.o if libbpf's BPF-side
> > > > headers changed, so let's make sure that stays (or happens, if we
> > > > don't do it already)
> > >
> > > Commands below cause full rebuild (.test.o, .bpf.o) on v2 of this
> > > patch-set:
> > > $ touch tools/lib/bpf/bpf.h
> > > $ touch tools/lib/bpf/libbpf.h
> >
> >
> > yeah, ideally they wouldn't cause bpf.o rebuilds... I think we should
> > tune .bpf.o to depend only on BPF-side headers (we'd need to hard-code
> > them, but they don't change often: usdt.bpf.h, bpf_tracing.h,
> > bpf_helpers.h, etc). I don't think we can get rid of BPF skeletons'
> > dependency on bpftool (which depends on any libbpf change), though,
> > so .skel.h will be regenerated due to any tiny libbpf change, but
> > that's still better, as bpf.o building is probably the slowest part.
>
> I tried a small experiment, and specifying particular lib/bpf headers
> didn't help because of vmlinux.h
>
> I grepped the list of headers with:
>
>     $ grep -rh 'include <bpf/' progs | sort -u
>
>     #include <bpf/bpf_core_read.h>
>     #include <bpf/bpf_endian.h>
>     #include <bpf/bpf_helpers.h>
>     #include <bpf/bpf_tracing.h>
>     #include <bpf/usdt.bpf.h>
>
> Then, changed $(TRUNNER_BPF_OBJS) dependencies like this:
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 66478446af9d..6fb03bb9b33a 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -480,6 +480,13 @@ xdp_features.skel.h-deps :=3D xdp_features.bpf.o
>  LINKED_BPF_OBJS :=3D $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
>
> +HEADERS_FOR_BPF_OBJS :=3D bpf_core_read.h        \
> +                       bpf_endian.h            \
> +                       bpf_helpers.h           \
> +                       bpf_tracing.h           \
> +                       usdt.bpf.h
> +HEADERS_FOR_BPF_OBJS :=3D $(addprefix $(BPFDIR)/,$(HEADERS_FOR_BPF_OBJS)=
)
> +
>  # Set up extra TRUNNER_XXX "temporary" variables in the environment (rel=
ies on
>  # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
>  # Parameters:
> @@ -530,14 +537,15 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:    =
                       \
>                      $(TRUNNER_BPF_PROGS_DIR)/%.c                       \
>                      $(TRUNNER_BPF_PROGS_DIR)/*.h                       \
>                      $$(INCLUDE_DIR)/vmlinux.h                          \
> -                    $(wildcard $(BPFDIR)/bpf_*.h)                      \
> -                    $(wildcard $(BPFDIR)/*.bpf.h)                      \
> +                    $(HEADERS_FOR_BPF_OBJS)                            \

I'd leave *.bpf.h as is, it's meant to be BPF-only header (going
forward, at least)

>                      | $(TRUNNER_OUTPUT) $$(BPFOBJ)
>         $$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,                      \
>                                           $(TRUNNER_BPF_CFLAGS)         \
>                                           $$($$<-CFLAGS)                \
>                                           $$($$<-$2-CFLAGS))
>
> This didn't help because
>
>      $ touch ~/work/kernel-clean/tools/lib/bpf/bpf.h
>
> triggers rebuild of vmlinux.h, which depends on $(BPFTOOL), and
> bpftool depends on $(HOST_BPFOBJ) or $(BPFOBJ), and they in turn
> depend on all files in lib/bpf.
>
> And there is a direct dependency of $(TRUNNER_BPF_OBJS) on vmlinux.h,
> which looks like a real dependency to me, but maybe I don't know
> something.
>

Yeah, we need to be smarter with vmlinux.h, I think. I think
dependencies are set up correct, though pessimistic. Any libbpf change
can cause bpftool change, which can cause different vmlinux.h
generation. All that probably has to stay. But we can generate
temporary vmlinux.h on the side, and compare it with pre-existing
vmlinux.h. If contents didn't change (and we shouldn't have any
timestamps in vmlinux.h or anything that just changes from run to
run), we shouldn't touch the original vmlinux.h.

This way will avoid .bpf.o regeneration. (vmlinux.h generation itself
is fast, so I wouldn't bother trying to avoid it)

