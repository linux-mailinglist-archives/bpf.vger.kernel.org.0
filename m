Return-Path: <bpf+bounces-38825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6BB96A72D
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 21:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30BA1B217E6
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 19:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D971D5CFA;
	Tue,  3 Sep 2024 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3J4PAwf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48A1D5CC8;
	Tue,  3 Sep 2024 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390965; cv=none; b=OioUZwYenJNvnKVOhVWepQ2rtSOTAjQNC+QzIB5HBZuGRaeHqt3WwJXkmBCSEOiDEHx/TLaFyCYPY6wrKs4ehcrVISopYFv0t94TdM8EaI2JwckJo2KqPyztiNeTSmMXY3hRNdfOeZfSuT52NO8rTotpbnQGQ8cGyk85KEphChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390965; c=relaxed/simple;
	bh=pc4D2rTYe3uDu4gL5RzbeVO+XN6Y90tHrqkY1CQHZ8M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCOgi3bbJqJsCF36vorgBF0i6ZjvlXM5a7QJC+AQr0VpcDkBk0HRgBBrn8cclEV43cDKNEmU90XHeoMsgnRoIbGlw8UBbYcepkTYC57tFgUEJ7o7Qwp6HhfxWQkrDamZJlH+5bnQaRyQjoo3sWDIHfDuIDcwRsef7CQtLN18kGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3J4PAwf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c4d4f219so1917036f8f.1;
        Tue, 03 Sep 2024 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725390962; x=1725995762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIKMnKHHdmH0tgNR7Q0mOb34yahsFaU+l95FDBvyAEo=;
        b=E3J4PAwf9iQNvuarBVXBF/5etkiUbOvE5AEmZwMKkcQz/CVKXX2fw956xZO1iWxJUh
         61R4eQfdcQyHing1jTO3MyO9t2GCQYlvBI6E+Qa/C+TxmAW5gV6t4C75wjccOguB8twU
         YOKSS+ZFpLF/z0UC1OiNFNB9Z9FPalWSNI69Sgr1nu9mSob62i53mZO5PHYrZQXAHOf5
         5+fOjhoy5cxzW4Ndi6S4WhRuqRkdrniZ0BGYL4TLTUYg17kVFT2FJp5nhmn2CRp8yBbl
         Cco10aM0McYvlT5Q7KBAgxeWwK3YtWr+SuuH7BgeWjV5e/iqZw+Qfcg3hekf95Oubu7J
         ghJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725390962; x=1725995762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIKMnKHHdmH0tgNR7Q0mOb34yahsFaU+l95FDBvyAEo=;
        b=UINGdxbAC5phovkfUtU/IVtWOAJLgG+nvTsg1yyhQYSf/RG0p2tFw4P9aMnk1f47du
         hEit63+WZU0U0wREkEPvhoYYTYq/rd7ozoKeETNaNIDCMBAStEW8E+yHqgoHFWaXRrzD
         4FOgFt3xXdOEcsELlMMT2LtVH2Rju+t0SqNUv7t6o5N7UZhu4noOreTesLjL1ndFJXvS
         fzpPuSvxS/lzGVyD0w07sonh8GNiiQjnyWoEpC7tI4zfK6dY61G+/JvpIGDbEqWQQgvh
         xy09ePVMauJkh5Q7MWBwSxcJOhmhrzfk0r8gBMGOMefw8ubfqMsohhcFzRReBB5Kuh1p
         V++A==
X-Forwarded-Encrypted: i=1; AJvYcCVSzYME2hpebMIxpyBWhrtFxvukSHpdhOW5wQlEiRsBtbI1F+0Wm+knphTRD/EtO8VF7wBXfYCiBGtjYJ6z7FbheBjz@vger.kernel.org, AJvYcCVpmdexVz4TnM+w0NPvwQFIyf0qvr8ljiUCVF579PUpTWrsD9DvQv0gxWcPu0yUcHzONVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGUCUpoBbUgRdOa40sAD6ALtKUKqwbUSi7KNZmmn9lxnEpinAJ
	bK43KhHFrdXdu35Q+A/0KQTEG6xJuPl+8lF9EZWN9yPaZjafOBc9
X-Google-Smtp-Source: AGHT+IHlQkyOpufz7x/AQMvhA8sEw5Cq/FXXlpSLlS21HqKGXn7emmi/2SotzMe1MGIisdd46ltNcw==
X-Received: by 2002:a5d:59a4:0:b0:368:75:2702 with SMTP id ffacd0b85a97d-374ecc6774bmr4076569f8f.13.1725390962143;
        Tue, 03 Sep 2024 12:16:02 -0700 (PDT)
Received: from krava ([87.202.122.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c96a88ebsm7029092f8f.108.2024.09.03.12.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:16:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Sep 2024 22:15:55 +0300
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Tianyi Liu <i.pear@outlook.com>, Jordan Rome <linux@jordanrome.com>,
	ajor@meta.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, flaniel@linux.microsoft.com,
	albancrequy@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <Ztdga4chR8imIPZb@krava>
References: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240830101209.GA24733@redhat.com>
 <ZtHKTtn7sqaLeVxV@krava>
 <CAEf4BzZPGxuV38Kz3R387tANP3tLF7j9GLRd6tOYtaEWT9uqCw@mail.gmail.com>
 <ZtWBRgM3TyhdiwKw@krava>
 <CAEf4BzZJdmppN2=pt-0D+LDsfc6rW=Jg_7Q6kEJXpsuv52ATNQ@mail.gmail.com>
 <CAEf4BzazK83Lw24j-MLNZ6PYwhC6CYN11Hw00+FBRgJ9PuxW=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzazK83Lw24j-MLNZ6PYwhC6CYN11Hw00+FBRgJ9PuxW=Q@mail.gmail.com>

On Tue, Sep 03, 2024 at 11:11:06AM -0700, Andrii Nakryiko wrote:

SNIP

> > Aren't we conflating two things here? Yes, from what Oleg explained,
> > it's clear that using task->mm is wrong. So that is what I feel is the
> > main issue. We shouldn't use task->mm at all, only task->signal should
> > be used instead. We should fix that (in bpf tree, please).
> >
> > But I don't get the concern about linux->mm or linux->signal becoming
> 
> correction, we shouldn't worry about *linux->signal* becoming NULL.
> linux->mm can become NULL, but we don't care about that (once we fix
> filtering logic in multi-uprobe).
> 
> > NULL because of a task existing. Look at put_task_struct(), it WILL
> > NOT call __put_task_struct() (which then calls put_signal_struct()),
> > so task->signal at least will be there and valid until multi-uprobe is
> > detached and we call put_task().
> >
> > So. Can you please send fixes against the bpf tree, switching to
> > task->signal? And maybe also include the fix to prevent
> > UPROBE_HANDLER_REMOVE to be returned from the BPF program?

ok, it's uprobe-multi specific, let's discuss that over the change
itself, I'll try to send it soon

jirka


> >
> > This thread is almost 50 emails deep now, we should break out of it.
> > We can argue on your actual fixes. :)
> >
> > >
> > > Oleg suggested change below (in addition to same_thread_group change)
> > > to take that in account
> > >
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 98e395f1baae..9e6b390aa6da 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -3235,9 +3235,23 @@ uprobe_multi_link_filter(struct uprobe_consumer *con, enum uprobe_filter_ctx ctx
> > >                          struct mm_struct *mm)
> > >  {
> > >         struct bpf_uprobe *uprobe;
> > > +       struct task_struct *task, *t;
> > > +       bool ret = false;
> > >
> > >         uprobe = container_of(con, struct bpf_uprobe, consumer);
> > > -       return uprobe->link->task->mm == mm;
> > > +       task = uprobe->link->task;
> > > +
> > > +       rcu_read_lock();
> > > +       for_each_thread(task, t) {
> > > +               struct mm_struct *mm = READ_ONCE(t->mm);
> > > +               if (mm) {
> > > +                       ret = t->mm == mm;
> > > +                       break;
> > > +               }
> > > +       }
> > > +       rcu_read_unlock();
> > > +
> > > +       return ret;
> > >  }
> > >
> > >  static int

