Return-Path: <bpf+bounces-67340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6D2B42A5F
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 21:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACC83B24C7
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75C036998D;
	Wed,  3 Sep 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJtPwOd5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDE2D6E6C;
	Wed,  3 Sep 2025 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929463; cv=none; b=JuFNFqpnwX01du/kPln4r1dXUgFZ8OCWuHnSIx//HAzraDw654zOCjLH8mJJmWVpWDzN+pOPvw3QVOrNpJQmNycBD/4jmplfK+Wef2cHgtE/bju/B9b95e57BUieTYwGLTRW5TT1Ru4Ik5v3+KOE+RBEvoOPtb1cKT2x0TaKr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929463; c=relaxed/simple;
	bh=NQOh6CPJRu8MO+MPKo+ElHzrE43y4ifxJ4cqcm58V1M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/+0BWKBF8dTM8cC3Eq+6eE9IwdeXNjy9YXCyqzvbVs5DI3PUeQtGplFv417JeMUQZV8kPFfD4HUqkJMN1BcLBD8uPx8MNT41ItdYVN0bxLJKYsrqem4AJea+ezi45lUnjOHBJHRuFyZB6o6+6N8pAMNBAIMXg5mYv2Vcend6r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJtPwOd5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61ded2712f4so328875a12.1;
        Wed, 03 Sep 2025 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756929459; x=1757534259; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=57f6UrxKZVi5P3iZAoNMgVEmRpxNaCoeH2w/+gFeGeA=;
        b=XJtPwOd5USnHMVUIEOFWvwRKGO6fyNeqgcknNvYZE5fgOVxSuN+Uz76cxCqc5hsqiS
         DMQiqray+/rKsDd9m4Yl2HzjzGJkVnIitwEB5D2uQpRp769PqBjy3G5qUTk+g6nBJUkI
         2wms82+8azFEqgwFeV2ZU2vYhOH2V8vU0qP5q6ULrSPUzb9BkzkUApD69bO28+Lftq5g
         K/iLT7teagOQSJS973l2Crnq0vGPBnl1spMicS+QMZBAaG1cZJLHKSBVBpVAzorIeT1G
         j4lKUZERJyuV2k6nvQZvx6Z7UoxyL5ld/s8epazDUG14n1Wx2AL/auT+f75kpISYJbN5
         5Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756929459; x=1757534259;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57f6UrxKZVi5P3iZAoNMgVEmRpxNaCoeH2w/+gFeGeA=;
        b=V5QbnjHArAPWwOFZBBUQkhKopjAGxgtsj93qM4ZNzlxVkugKNHf8sGf57U7tXi0YME
         ZUUkKpXYy+/bEWA3vq4vlrajSESlDyh2wFoXRdBWkOwsr4ZEWsSLd6TjGfaiyNzQM3T4
         ZWVyStMXJwe/CMTp3naSlMTa0Na8j36A+cb7gX7E+BfWnjk1WK6eIw8thRRFOx19oXeL
         vgHDGIgSKvoHOcOc+mJZDvObiMVZVvtjLxhhGJYcc0a8QNRvlSidJLVLHjORKd/pqMq7
         sFFa9fd7wqgz7tYOy7ruh+gavQTAIgODE8fKxi9ggyoXgr50hFKObZFSEnZD2F85Ncc/
         q5WA==
X-Forwarded-Encrypted: i=1; AJvYcCW6EsmFfYJaJQ2p4kRqdnfUaI8NiQcy4pMP3EyL2JDspYqe4466lMbJlznzp82FbHfDXvFeJGWotqs90sPaJIcW99l+@vger.kernel.org, AJvYcCXILHJydWNI0KjdmSOKGCQtLIIn9hEumy/jkU242JJD7TymC8rajR5MK0OFuGNvaWZVvMHC1lz8WH1Msuam@vger.kernel.org, AJvYcCXk1w8gCSOglr4i84n24JZHd2/uT0RfHkr+SfZNRf/928pR2kL7My2MRrgKQx59SMFIsXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mf4hZrEsRSl1gpOqvW9ANWkWr42JPf72gY8vVON7e7qAZ5im
	qu3lbOJZBhgU97lJquxflQ+Q4Zc4axCMYlHDRs3pTMV3Gx3bbKIbCYQa
X-Gm-Gg: ASbGnctItjDzMczwjj0/VZ6N+G9+/xnDWr7oSGWMJz/jwlMbSCp/GCbn4AuLDNwkIm7
	lKNisMzgrk6TCs3dBfA10LLu5net6SKLvr81hOfLN7T4zhPts+oiVb0lQ31OhRX9Tg9lPpELsM7
	fCe9j4Z1wn2gfJAq8i5Gtsr7GtT3fxqi7yXVNaS+lq3O5vAfkfin2rGF6dXh3LeR1vdHhqAfjsI
	aegSKZfXOsLqQhI7RsNiS7ykUN3EXJokpz/FGpdpskDq64PEKPLVWU7o9jz2SvCSWsQQqcnkKRM
	D212T9ArKlKzqBD7VnN3O1z5L/fkaEC3a9Delb4nNA0NCCizCYXMypJmeIoAS0tag0ruEoNtmmU
	+1a5NV72ncDLY8y0ZYBEJbA==
X-Google-Smtp-Source: AGHT+IFj5cz+Tx9E3AoYVYXnNw1csMKb/uB4P1Kf9/gIv8Fb6O5+hjh0HyGj3cPNOcDWaR/MA6z2Yg==
X-Received: by 2002:a05:6402:5c8:b0:618:534:550a with SMTP id 4fb4d7f45d1cf-61d26c53c4amr15960860a12.24.1756929458960;
        Wed, 03 Sep 2025 12:57:38 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7a8fsm12538518a12.3.2025.09.03.12.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:57:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Sep 2025 21:57:37 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 02/11] uprobes: Skip emulate/sstep on unique
 uprobe when ip is changed
Message-ID: <aLidsd7DZ-eoJMvJ@krava>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-3-jolsa@kernel.org>
 <20250903112648.GC18799@redhat.com>
 <CAEf4BzZ87DAtQSKOOLjADP3C7_4FwNw6iZr_OKYtPNO=RqFAjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ87DAtQSKOOLjADP3C7_4FwNw6iZr_OKYtPNO=RqFAjQ@mail.gmail.com>

On Wed, Sep 03, 2025 at 11:20:01AM -0700, Andrii Nakryiko wrote:
> On Wed, Sep 3, 2025 at 4:28 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 09/02, Jiri Olsa wrote:
> > >
> > > If user decided to take execution elsewhere, it makes little sense
> > > to execute the original instruction, so let's skip it.
> >
> > Exactly.
> >
> > So why do we need all these "is_unique" complications? Only a single
> 
> I second this. This whole is_unique flag just seems like an
> unnecessary thing that spills all around (extra kernel and libbpf
> flags/APIs), and it's all just not to confuse the second uprobe
> attached? Let's just allow uprobes to override user registers and
> handle IP change on kernel side (as unlikely() check)?

yes! ;-) I'd just refresh rfc version then

thanks,
jirka



> 
> > is_unique/exclusive consumer can change regs->ip, so I guess handle_swbp()
> > can just do
> >
> >         handler_chain(uprobe, regs);
> >         if (instruction_pointer(regs) != bp_vaddr)
> >                 goto out;
> >
> >
> > > Allowing this
> > > behaviour only for uprobe with unique consumer attached.
> >
> > But if a non-exclusive consumer changes regs->ip, we have a problem
> > anyway, right?
> >
> > We can probably add something like
> >
> >                 rc = uc->handler(uc, regs, &cookie);
> >         +       WARN_ON(!uc->is_unique && instruction_pointer(regs) != bp_vaddr);
> >
> > into handler_chain(), although I don't think this is needed.
> >
> > Oleg.
> >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  kernel/events/uprobes.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index b9b088f7333a..da8291941c6b 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -2568,7 +2568,7 @@ static bool ignore_ret_handler(int rc)
> > >       return rc == UPROBE_HANDLER_REMOVE || rc == UPROBE_HANDLER_IGNORE;
> > >  }
> > >
> > > -static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> > > +static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs, bool *is_unique)
> > >  {
> > >       struct uprobe_consumer *uc;
> > >       bool has_consumers = false, remove = true;
> > > @@ -2582,6 +2582,9 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> > >               __u64 cookie = 0;
> > >               int rc = 0;
> > >
> > > +             if (is_unique)
> > > +                     *is_unique |= uc->is_unique;
> > > +
> > >               if (uc->handler) {
> > >                       rc = uc->handler(uc, regs, &cookie);
> > >                       WARN(rc < 0 || rc > 2,
> > > @@ -2735,6 +2738,7 @@ static void handle_swbp(struct pt_regs *regs)
> > >  {
> > >       struct uprobe *uprobe;
> > >       unsigned long bp_vaddr;
> > > +     bool is_unique = false;
> > >       int is_swbp;
> > >
> > >       bp_vaddr = uprobe_get_swbp_addr(regs);
> > > @@ -2789,7 +2793,10 @@ static void handle_swbp(struct pt_regs *regs)
> > >       if (arch_uprobe_ignore(&uprobe->arch, regs))
> > >               goto out;
> > >
> > > -     handler_chain(uprobe, regs);
> > > +     handler_chain(uprobe, regs, &is_unique);
> > > +
> > > +     if (is_unique && instruction_pointer(regs) != bp_vaddr)
> > > +             goto out;
> > >
> > >       /* Try to optimize after first hit. */
> > >       arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> > > @@ -2819,7 +2826,7 @@ void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr)
> > >               return;
> > >       if (arch_uprobe_ignore(&uprobe->arch, regs))
> > >               return;
> > > -     handler_chain(uprobe, regs);
> > > +     handler_chain(uprobe, regs, NULL);
> > >  }
> > >
> > >  /*
> > > --
> > > 2.51.0
> > >
> >

