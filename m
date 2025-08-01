Return-Path: <bpf+bounces-64865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430FCB17AE7
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 03:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 685907B571B
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 01:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218177FBA2;
	Fri,  1 Aug 2025 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl2CgTJu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F183C17;
	Fri,  1 Aug 2025 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754012590; cv=none; b=ov5wGKth+uArVSkQUCPaeB1H4GC6v2FOyEK22OGBuEI88Dp/Svgz+cg9RkNL2faFXLl08cNaSV2WyOzFIiUzrl4snXAcCSdcTUTHihhTXN3+xVTssgIjPtr6iGsyY8q7H+nx5iB22vaXUiL7UHbyO8mbYTK2WZlRoSuz/uh2JeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754012590; c=relaxed/simple;
	bh=N4Q5miAGpxlGfSXr83VjddicIT/BiIK7HPIuYbDoGvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4iqF1TQytlFfXQwJOIb/pmY2WMnwOJMw8BgGDe5RUGWt5euK9oG3u3qsv+vrj1YkTojWsYWBt2joqsgKOo1qdDE2D2CFJLbL4vuPwLVVsDOPtrkTmmtfMjMpBLz5spcUHhqRdB/JJFNAMoYcndsLPn7PwE/NNSV4FwnlcynIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl2CgTJu; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-71a3f7f0addso15722957b3.2;
        Thu, 31 Jul 2025 18:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754012588; x=1754617388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg54mcNOWV4pT7SvP9l1EEus3Ufwp4XwJcmkPSo2fik=;
        b=Cl2CgTJuLD5lXQ5yoziJwyccymk4NhKcRRFOuVmlp7IElmMI7ocYNUL9YDhhkzhIAF
         Rh3AohvErLwHd61icpBpCNb8pDrsT93TPzvRUpTrqBYhJR8zt6BpSdkTV9qDurVWsL/B
         YUoDIP9S09mpDcQX0oHLuS2Zykc2+v3XN4Jv2l6G3rATJrlh93vzA421QjT8fvDHFMzQ
         Ufi826zbsU/m0PONpPxX7pVEjlSWMCGdTjfSej+vKDBY6U8ok63b26ugihmUXHQ+8z3Q
         jya5HAKIcQ3jdFYKpOEeAksK1Tu2Mrn+rANNKNVVtjiDqlonBlsjhw21R4MRz63SEbF6
         cYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754012588; x=1754617388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg54mcNOWV4pT7SvP9l1EEus3Ufwp4XwJcmkPSo2fik=;
        b=dGt2us2/oLke63ddoDm7HVrPxkzZH/A+nN9kg73OEFQSHrRLDRRlVhdsO1imwweKry
         JF7AWcAzo4vHjuelczHvZbPojH2BfCk1JldbW4YH7ctCFsmaJEdm7RgNSHbTF9K5isUT
         EfKW0aFyP5nPclPStvYc2cAqWzsg7Bfff30Y+YW34tyrkaz9x04OGhGMdzQ3QdiLK8JA
         K3hnWNs4wCTXrtiTBKlDwfmDKIVwRWCB6WwnZpaMdzqNbVfj9ivhf6lT/4smNaS1yLwO
         h1t/6vslQHLBnyzH0D3aIBtF6oyIHZC0wGN1LO8bRS6IBdIpw8/SKk8tKRlGzkP9Uf+O
         /jiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrJcJ//hR5OlCikm2RVqsWkf5yd2IbQl9z39Tk/hoHnnPRj+ztR4QsEM5y75q/juQr0bEOpcCl@vger.kernel.org, AJvYcCVpzisn1qDTpIVnZcK64O4Q+p7LRPm2K1A/HJ51yvUwdxj2LmqCNbvAReafc0F7nFqt+Y3hDsQ94BeIvzaN@vger.kernel.org, AJvYcCWmkZ/RE3f7xlXsue0WU86nrzNmJ9kJFOOiFFFQvqbFyrewIT8DAFVxi78tRIFj8TfgO8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZXIPBQ/zcsCNMglSAJUG+8phz/kmX4AOYPqdSbeAsbWZdLoa
	pfC8+wkHGHeJsRaH2hQXqcyvgmZzIUybcU4XoxJuB7rGf2F7wC8AKeNijpax9Pktt4PcI281ltB
	43W+DWYWHyCrihyjfhyCY/yD8ARvzTJkMZ64NZ/4=
X-Gm-Gg: ASbGnctmlqes9SJngRpaM35LYHtRUwtBb/gyYvn84p0IX4VjgrEiftLo1ks4TvsBTD4
	UZEZEgbkW6o97jIKLETFVzAxvwpn7k02Wq13610K2fN8nLOI2OVilG8QAYK4W2exeQVbqDHOf5Z
	ygmh8aOj92q9bkhPOvI/YVEYPpFwkEbyK0ueBWN7ynJzHT1ntBxoQN945ZWc2LE+tvpIGimF2yG
	kh9c0c=
X-Google-Smtp-Source: AGHT+IG3VYdBG5WRJkmwgqjcOvLij9zCubY0eTDbLYeCX5pOkIV0RjU1PUH4J+wlTs9cCnuBusTUnHpIPoKcXIdWeQ8=
X-Received: by 2002:a05:690c:7001:b0:71a:1c50:8898 with SMTP id
 00721157ae682-71a46659cd3mr132619967b3.20.1754012587918; Thu, 31 Jul 2025
 18:43:07 -0700 (PDT)
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
 <20250716182414.GI4105545@noisy.programming.kicks-ass.net>
 <CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com>
 <CADxym3Za-zShEUyoVE7OoODKYXc1nghD63q2xv_wtHAyT2-Z-Q@mail.gmail.com> <CAADnVQ+XGYp=ORtA730u7WQKqSGGH6R4=9CtYOPP_uHuJrYAkQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+XGYp=ORtA730u7WQKqSGGH6R4=9CtYOPP_uHuJrYAkQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 1 Aug 2025 09:42:57 +0800
X-Gm-Features: Ac12FXy-vpmSHlsvL-oIX1qMJ0s6c0XklwUy2mr9pJMFQsV90eCj8vUHSIkVBx0
Message-ID: <CADxym3arEsBB-b0Hr52pcwH7H+Lgg6-NKYczPn6W49WRND-UJg@mail.gmail.com>
Subject: Re: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 12:15=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 28, 2025 at 2:20=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > On Thu, Jul 17, 2025 at 6:35=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 11:24=E2=80=AFAM Peter Zijlstra <peterz@infra=
dead.org> wrote:
> > > >
> > > > On Wed, Jul 16, 2025 at 09:56:11AM -0700, Alexei Starovoitov wrote:
> > > >
> > > > > Maybe Peter has better ideas ?
> > > >
> > > > Is it possible to express runqueues::nr_pinned as an alias?
> > > >
> > > > extern unsigned int __attribute__((alias("runqueues.nr_pinned"))) t=
his_nr_pinned;
> > > >
> > > > And use:
> > > >
> > > >         __this_cpu_inc(&this_nr_pinned);
> > > >
> > > >
> > > > This syntax doesn't actually seem to work; but can we construct
> > > > something like that?
> > >
> > > Yeah. Iant is right. It's a string and not a pointer dereference.
> > > It never worked.
> > >
> > > Few options:
> > >
> > > 1.
> > >  struct rq {
> > > +#ifdef CONFIG_SMP
> > > +       unsigned int            nr_pinned;
> > > +#endif
> > >         /* runqueue lock: */
> > >         raw_spinlock_t          __lock;
> > >
> > > @@ -1271,9 +1274,6 @@ struct rq {
> > >         struct cpuidle_state    *idle_state;
> > >  #endif
> > >
> > > -#ifdef CONFIG_SMP
> > > -       unsigned int            nr_pinned;
> > > -#endif
> > >
> > > but ugly...
> > >
> > > 2.
> > > static unsigned int nr_pinned_offset __ro_after_init __used;
> > > RUNTIME_CONST(nr_pinned_offset, nr_pinned_offset)
> > >
> > > overkill for what's needed
> > >
> > > 3.
> > > OFFSET(RQ_nr_pinned, rq, nr_pinned);
> > > then
> > > #include <generated/asm-offsets.h>
> > >
> > > imo the best.
> >
> > I had a try. The struct rq is not visible to asm-offsets.c, so we
> > can't define it in arch/xx/kernel/asm-offsets.c. Do you mean
> > to define a similar rq-offsets.c in kernel/sched/ ? It will be more
> > complex than the way 2, and I think the second way 2 is
> > easier :/
>
> 2 maybe easier, but it's an overkill.
> I still think asm-offset is cleaner.
> arch/xx shouldn't be used, of course, since this nr_pinned should
> be generic for all archs.
> We can do something similar to drivers/memory/emif-asm-offsets.c

Great, I'll have a try on this way!

> and do that within kernel/sched/.
> rq-offsets.c as you said.
> It will generate rq-offsets.h in a build dir that can be #include-d.
>
> I thought about another alternative (as a derivative of 1):
> split nr_pinned from 'struct rq' into its own per-cpu variable,
> but I don't think that will work, since rq_has_pinned_tasks()
> doesn't always operate on this_rq().
> So the acceptable choices are realistically 1 and 3 and
> rq-offsets.c seems cleaner.
> Pls give it another try.

