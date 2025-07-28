Return-Path: <bpf+bounces-64490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE743B13769
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465DF3AA244
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689F225785;
	Mon, 28 Jul 2025 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZavMuRA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E21F0E47;
	Mon, 28 Jul 2025 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694429; cv=none; b=d8zl+tOfZXsR8kO4mtnPbtvdWx0MvtlKms8kV2Qxka4GRywVR7vhLDqrNB7H8DtLHP2BbqgPuELgApn9MZ07kFq0hI4yk/+LPMJT6Y8HvM+BVEn2yHFxcvVc913Pw44uRWGlpAPaI7OTshjUR8uKpIjBzas4Btcsrx+Y5dUVhAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694429; c=relaxed/simple;
	bh=6vCk2EyVaBv/9r01qqNClUSQmahnoJP4cpHbsmxtMw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxwzoaxeX8Of2DgPBnUylVl+fAiPCW+jCrp1Nqs2JwcUzcgs6HMax9iRXET/aLftzPvL5ZhCuFyvGcYN0IP4xex3cOYqjXTq6pH9ZITJW996nOrY9PN6/r/gCsjW3nmdwJAK33iJrsztusf/J0P7Lp3u+/bRzOHRU2x8M8DE7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZavMuRA; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e8e19112e1cso418364276.1;
        Mon, 28 Jul 2025 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753694427; x=1754299227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOUndAjGbs9Z7mgqtt2C3hXEUs5zZBm7aglIt3WeNZM=;
        b=jZavMuRAsF1ujx6W2/Auzx+KhpNXZh783lVNfhNzRFzDvImLqo7SG10UVsb9PvktPI
         XB6YEBIyPCaNkICUIrd/Rndfb3oTl6QdlJrWIFs44VZTE4P40rQDlk1OfLoYitgdIyfs
         es3w13XYuf3qkqH/i51JJCp9vEBnr3141NyVGUbjmT0164dG4WxxJ4Kt560Za6snrxwY
         J4MOCSZYRDCOupDkZ4nb+CctVnAZELc9bPMd3RPgyDBIhiD9+DNloEZfWeU8XKXBnci/
         Yf85/X5fis7YRYU0c+KGDofJJSX4d/xigMl6OjuFb7ZL9vAtO47cXokAU7NGwjaAsXF0
         aFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753694427; x=1754299227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOUndAjGbs9Z7mgqtt2C3hXEUs5zZBm7aglIt3WeNZM=;
        b=OLcEo2uDS3kRPwqye7fIT2pZVWRj4PUD9Z39cEeJNST0shwLcHl++37QuESLv7e8gI
         ODmmFbnykvqaS9gWleojtbf+UN3EIVp+BoqjYG3CuhwrtULqqsKlC8hr+xeBL6WzS4ui
         c6o6Nba+Lx2gcajRNNnSSUsMEaET6If6GxtZAmm7TKJJik4MO43JaiNoAkRRagZz5ypQ
         Llv8HL3AXnQDNO5yHkT0HFmrkbqZqHkQxQ0jvnlUlJ4xDMuW0sKGxRQniNkAIN2UL+DV
         25JGcjl+Iq0LrI4ACqau2YfSwkkF5DkLPzjAmmUCvLNam6gNLVab4ZV58PEUav9jyTE/
         Uyyw==
X-Forwarded-Encrypted: i=1; AJvYcCUcToKnmdnWih3vAwjpZZ9tdJvqvp1v8k6QOTfNE/Ox31FNjLjH+f99d7ES5OvTT+iaY/s=@vger.kernel.org, AJvYcCUuL/RJyciq9GUsn8BfFvdPwFA3cLocYncVfXzjrqwNvxiW9SLgpy6qYFYuVp56PQmXlgtq16UAmygaNV9t@vger.kernel.org, AJvYcCVQxgnhkD6z4x4pnBNqzUyumbo5/9RgXlR808hYvmrzBuj2AiOz3WbeMtLZ3AyUyRTs30k/N5cI@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEr1ACT1bcJZOLzIZC1wMxay0LdlKGOF1Tc8IxUnpfrEPY/Ak
	APLSGN6+TPT9xengvG7FrHpq+2Hr+RChqZojK0D/mCc2GDWWBN1RMudYRnvNk83jdABbSL91um/
	obvFm9hNUFgjG8Dz+1EAsjSw/ycyCKs2nJPD5HVxzUg==
X-Gm-Gg: ASbGncsM9wt5wb8BO8V4k5SYkjD5EbQEaGpKSQ5MEBYkCeUY87Gj5k39lkUjAdLPIqC
	vmkakpt7N0I7G3f2pq5QVgqIiVEiSjT2ZBrSMt5Znx3CJbN8RFbTlxE8DtF1mK22kAtPNRDCCRy
	hsVidlCBKxZsfJyHmfBkqREN5VQZDzBds9PeIco+Q4iBezMcb0kHvXPyh8C6YcZJUIetPBrk5Lk
	rn9ht0=
X-Google-Smtp-Source: AGHT+IG2es838FVHjykNUDR0OPFBgYAw+vm8+pnEig657RreeNemn3dBFWB8CI3Dnmn4f+ahJgiFz+8M26Xh7wQmGTc=
X-Received: by 2002:a05:6902:2604:b0:e8e:16d9:8f07 with SMTP id
 3f1490d57ef6-e8e16d9ae8bmr2296112276.5.1753694426804; Mon, 28 Jul 2025
 02:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn> <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev> <3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
 <CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com>
 <20250716182414.GI4105545@noisy.programming.kicks-ass.net> <CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com>
In-Reply-To: <CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 28 Jul 2025 17:20:16 +0800
X-Gm-Features: Ac12FXx6Zs--JsOtIVFoIZTWj7Kzd6_oda5CUDIBxSriLRPGkki3kXKyjteYeu0
Message-ID: <CADxym3Za-zShEUyoVE7OoODKYXc1nghD63q2xv_wtHAyT2-Z-Q@mail.gmail.com>
Subject: Re: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 6:35=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jul 16, 2025 at 11:24=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> >
> > On Wed, Jul 16, 2025 at 09:56:11AM -0700, Alexei Starovoitov wrote:
> >
> > > Maybe Peter has better ideas ?
> >
> > Is it possible to express runqueues::nr_pinned as an alias?
> >
> > extern unsigned int __attribute__((alias("runqueues.nr_pinned"))) this_=
nr_pinned;
> >
> > And use:
> >
> >         __this_cpu_inc(&this_nr_pinned);
> >
> >
> > This syntax doesn't actually seem to work; but can we construct
> > something like that?
>
> Yeah. Iant is right. It's a string and not a pointer dereference.
> It never worked.
>
> Few options:
>
> 1.
>  struct rq {
> +#ifdef CONFIG_SMP
> +       unsigned int            nr_pinned;
> +#endif
>         /* runqueue lock: */
>         raw_spinlock_t          __lock;
>
> @@ -1271,9 +1274,6 @@ struct rq {
>         struct cpuidle_state    *idle_state;
>  #endif
>
> -#ifdef CONFIG_SMP
> -       unsigned int            nr_pinned;
> -#endif
>
> but ugly...
>
> 2.
> static unsigned int nr_pinned_offset __ro_after_init __used;
> RUNTIME_CONST(nr_pinned_offset, nr_pinned_offset)
>
> overkill for what's needed
>
> 3.
> OFFSET(RQ_nr_pinned, rq, nr_pinned);
> then
> #include <generated/asm-offsets.h>
>
> imo the best.

I had a try. The struct rq is not visible to asm-offsets.c, so we
can't define it in arch/xx/kernel/asm-offsets.c. Do you mean
to define a similar rq-offsets.c in kernel/sched/ ? It will be more
complex than the way 2, and I think the second way 2 is
easier :/

>
> 4.
> Maybe we should extend clang/gcc to support attr(preserve_access_index)
> on x86 and other architectures ;)
> We rely heavily on it in bpf backend.
> Then one can simply write:
>
> struct rq___my {
>   unsigned int nr_pinned;
> } __attribute__((preserve_access_index));
>
> struct rq___my *rq;
>
> rq =3D this_rq();
> rq->nr_pinned++;
>
> and the compiler will do its magic of offset adjustment.
> That's how BPF CORE works.

