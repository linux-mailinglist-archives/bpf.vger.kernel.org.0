Return-Path: <bpf+bounces-48136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A704A045A9
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 17:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248AF3A54F7
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2641B1F3D4F;
	Tue,  7 Jan 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPt3ebKd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409D1EE035
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266300; cv=none; b=pyjW1NGEILYnQD6MOBboWngs3+gOuh3lqjDKGEZTR98CgWwKI7HXo+MCN7avjZw9II5UrRfAUgYhl6J/1UDkeeiEPjbI/laxpuKlrzcK+bJsvCEjrtTVndRltmPqyKcMqnhOaLZi305U1La80S1gEzSds95QZdXdGaDakMM0acI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266300; c=relaxed/simple;
	bh=oe4rYLsJTSsMqz8kYPo07co6S2Ugvm2arY6rIL9BfrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aw8TIByq90lR0lZuJeGKayUu0oNaj+2FK0p0hk50sPX7xaICaC80Ka0rCSfKetofK8LwIjf+Nirv8OyznhG3adloPVVGehPO7Cfmz0pZ7rucukOFRwBv2ykOkY+JkwOxaO0uAY1floD5uwRtUhXi2x00Jjv/qQ2+Tr40vpoUgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yPt3ebKd; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so154235ab.0
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 08:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736266296; x=1736871096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovdIMwIwiZ14E4dfVfO4ghoVyZV5ri9bDMxCK8IFTAI=;
        b=yPt3ebKdNxIBfWrLby1RomYYDU1AwUTaLMOmp80bLrYRrE7BXIMQ0CerAWr4ziB2c9
         UK8eZaK63qo/zFFJWH7dscth41z3gfw2AxCvging7NmplAveit52bFC9x78MNRmoHcoM
         /QLmo12DhbMdU06+cJS0IDyoTSx2LcQgJLZin9PT8jI843PfBG705oLeTe1bvsZWWrUY
         PRSh0VGRy+j9Oi90eB9XyhNX+/FP1P5deyc9cyS5d0OIFegqgeIojU+O3zZADSjS1pF2
         mSF3KHc2LijPEposq6EyYWp9UXO45LnjdQbmchQ2eiKgPprHw5urfNJJgLz3ugpMrw8n
         dHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736266296; x=1736871096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovdIMwIwiZ14E4dfVfO4ghoVyZV5ri9bDMxCK8IFTAI=;
        b=Kf5CAntNg3ujGS3gViBOACIMc3HOw2xB8ZA9BbtVeDx8aK3Dn9CltHeN2q7Rl4UglG
         PxN47zKwrRPhfuL91I563NPYrHzQIPh4eOwItiUFJoaL5I//HQhR0k4WKSjur8fwqUMK
         3mTEk0hRfQNVxP94M5JLYMrku8Xd5aReJVr0BzgaJH5pFZPKKFMaoKCYz2FutVAo9o8b
         giJFj1toZLaX3wYRdpaCPo7KWMIljw7HQHK1pobgyxA6K7pzTuyV7t01AMgxPruH/8tZ
         U/oq45X7sEZlc+FYVAebZ8NiPpzqEz9p5zVeKETEnK/4FbNOmyIUL8EH1phL1ZgzDtfS
         QQvA==
X-Forwarded-Encrypted: i=1; AJvYcCWqBPNeeT+Wrz7ujLuiythjEQ15kqZcbd5jrNlCX+W0vnZMVmHGvGzQE3AE7OPGXwCBx38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc6QuPy6+0rrCdCVqglpwDoTwEVGNl8Vrzzt6myrKTIuPW+Va5
	AnNeRH6M3aZPrNIINQgF4sPd0VBDIei6CLyBiSy3lQWxS/kAewjgh6eJYwGUhIPgjwlL9uVOlQS
	cxvGbG/wf7e6XPXdQlF2j9q0YbCaLUMesbc4U
X-Gm-Gg: ASbGncswYcwvPBczdW81vMcEYXgkmX2pTzeDFvWnSabm0H61vWPX1j+W+wUp0L9hgJv
	4qLdVdvFbFzMYdv40q003tJyUmEzQEesLQoG4iG/jY/x8qCIxI/kO3HOcpeMCxIBRaE36tg==
X-Google-Smtp-Source: AGHT+IFRGMAI8grxoLwU2BMFOYBqhR5G/5+yRiXlsTISXSuvfb3Eb0aGg6zU69aqjzEvaVHXuJ/Tu/v7loLxxl0BAcI=
X-Received: by 2002:a05:6e02:1068:b0:3ce:3873:48d4 with SMTP id
 e9e14a558f8ab-3ce38734b0amr762905ab.4.1736266295512; Tue, 07 Jan 2025
 08:11:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106215443.198633-1-irogers@google.com> <576a50c8-9ca2-4e2f-9bd8-7d9be4862920@linaro.org>
In-Reply-To: <576a50c8-9ca2-4e2f-9bd8-7d9be4862920@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Jan 2025 08:11:23 -0800
Message-ID: <CAP-5=fUZ2QCocFKdLfBoNYC-CQfSAcdbA05OhegKmTt_PLR1WA@mail.gmail.com>
Subject: Re: [PATCH v1] tools build: Fix a number of Wconversion warnings
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 2:33=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> On 06/01/2025 9:54 pm, Ian Rogers wrote:
> > There's some expressed interest in having the compiler flag
> > -Wconversion detect at build time certain kinds of potential problems:
> > https://lore.kernel.org/lkml/20250103182532.GB781381@e132581.arm.com/
> >
> > As feature detection passes -Wconversion from CFLAGS when set, the
> > feature detection compile tests need to not fail because of
> > -Wconversion as the failure will be interpretted as a missing
> > feature. Switch various types to avoid the -Wconversion issue, the
> > exact meaning of the code is unimportant as it is typically looking
> > for header file definitions.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> What's the plan for errors in #includes that we can't modify? I noticed
> the Perl feature test fails with -Wconversion but can be fixed by
> disabling the warning:
>
>    #pragma GCC diagnostic push
>    #pragma GCC diagnostic ignored "-Wsign-conversion"
>    #pragma GCC diagnostic ignored "-Wconversion"
>    #include <EXTERN.h>
>    #include <perl.h>
>    #pragma GCC diagnostic pop
>
> Not sure why it needs both those things to be disabled when I only
> enabled -Wconversion, but it does.

This change lgtm, I'm not sure how others feel. I don't have a plan, I
was just following up on Leo's Wconversion comment to see what state
things were in. The feature tests without these changes pretty much
break the build (I can live without perl support :-) ) so I thought I
could move things forward there and then see the state of Wconversion
with the patch I was working on.

I'm not sure how others feel about fixing Wconversion in perf, the
errors are quite noisy imo. The biggest issue imo will be with headers
shared by tools and the kernel, where kernel people may be vocal on
the merits of Wconversion.

> > ---
> >   tools/build/feature/test-backtrace.c           | 2 +-
> >   tools/build/feature/test-bpf.c                 | 2 +-
> >   tools/build/feature/test-glibc.c               | 2 +-
> >   tools/build/feature/test-libdebuginfod.c       | 2 +-
> >   tools/build/feature/test-libdw.c               | 2 +-
> >   tools/build/feature/test-libelf-gelf_getnote.c | 2 +-
> >   tools/build/feature/test-libelf.c              | 2 +-
> >   tools/build/feature/test-lzma.c                | 2 +-
> >   8 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/build/feature/test-backtrace.c b/tools/build/feature=
/test-backtrace.c
> > index e9ddd27c69c3..7962fbad6401 100644
> > --- a/tools/build/feature/test-backtrace.c
> > +++ b/tools/build/feature/test-backtrace.c
> > @@ -5,7 +5,7 @@
> >   int main(void)
> >   {
> >       void *backtrace_fns[10];
> > -     size_t entries;
> > +     int entries;
> >
> >       entries =3D backtrace(backtrace_fns, 10);
> >       backtrace_symbols_fd(backtrace_fns, entries, 1);
> > diff --git a/tools/build/feature/test-bpf.c b/tools/build/feature/test-=
bpf.c
> > index 727d22e34a6e..e7a405f83af6 100644
> > --- a/tools/build/feature/test-bpf.c
> > +++ b/tools/build/feature/test-bpf.c
> > @@ -44,5 +44,5 @@ int main(void)
> >        * Test existence of __NR_bpf and BPF_PROG_LOAD.
> >        * This call should fail if we run the testcase.
> >        */
> > -     return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
> > +     return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr)) =3D=
=3D 0;
>
> Seems a bit weird to invert some of the return values rather than doing
> !=3D 0, but as you say, the actual values seem to be unimportant.
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Yeah it was arbitrary and I didn't want to add a stdlib.h dependency
in a bunch of places for the sake of a definition of NULL. I'm happy
for things to be done differently if people like.

Thanks,
Ian

