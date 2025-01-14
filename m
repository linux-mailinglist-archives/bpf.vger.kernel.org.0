Return-Path: <bpf+bounces-48835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCE4A1100D
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 19:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686A91611AA
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA781FA27F;
	Tue, 14 Jan 2025 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExNC60Ga"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B2E1F9AAB
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879361; cv=none; b=Bt8lCsgXpxipMIMTfLvvFiHZqaNQsJQrWVtgV4rH4PvKd6/terEu/x1VGED6xOn6npERY5FO4CZcE+2EAojqgV88Bpa21ZOR34yWdeJZi4lSABFXDomotcwkh0rRCEzpit50iojT9OFM1auuNMg3TbvXyHuOQJV0/uy9vhn0z9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879361; c=relaxed/simple;
	bh=kc8LVP1FdDWwB9aZUbKZBGv2GjOXolWt0+u6dPct1CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEDB5FNxjcdvjVVEgrH+mi8tpCzYHcl8lOoBbA+83NIPaxvJY55X+FykEAFwGPDkJrrSRie0IgcELo302t8GPu+rYyIlXeb/Jf/D2KxVLL97w661h+cMxygf5I88JzO5P+p5E6xT/WkEvdhvqhW5hvjSS8lFPR85wkLUrdYIa2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExNC60Ga; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385df53e559so4618946f8f.3
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 10:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736879356; x=1737484156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4B4h+GqI+a8SvIS5sye8hS5px9jGMW4hqMJvB4sEfG4=;
        b=ExNC60Ga4YJrt87nzrVkOk5CZcksc/YVb1ndM95c8MGtKGClwS6rbUpZx+5zJZ+qpQ
         PfqAqVWzRODtAp1yDDgp54DY/X/QRMGIazsUpxli1bq3BrvGxnvzPRM47Ox2Gl7eHmfc
         WFUC38QaHMg1BiBlj8s7jJ+wDuUG54VDEk7HsKtIJX4baNcgAnOVHbkwp3YzraVbJGHU
         dSnLCN9iDbM3fNDb30RoVkjNcGKhsJxXYlWq2O/H9XrFjuOZADGO6t9N7Sig/zEFOyr/
         8X7Hqct2wcyX4xgssej+bHFiJ7alWHaIyVMf7wW2Tn6I6k7I9egIpssbbGRR9z82x817
         +RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736879356; x=1737484156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4B4h+GqI+a8SvIS5sye8hS5px9jGMW4hqMJvB4sEfG4=;
        b=aPQmyLRdgLiI5Sec9i9TuGUlaJb7CcWbFmY1UzNRLMoY/H4XG9EILrNSY/KUhbzLCK
         JwkZluDZODnoPgLo0fOjcE80wihG2V44P/c9j3nCTUhitN1G7kwkJTu68VxlT1G5lL/J
         astOE20oNDh32zsaDIWeXC9wWPJeMzjMyzj1WIE4slZCcgKoKPczKDRDTabbCPTZa3yV
         l5iS9fX2J6nSPqT8TOYARtAv4+8bIyhcOleCHg5MxOhDZQ4x4UGaT9Oj0V0L8H/u1uc7
         GYHprUVsoyL6g8YuJOfFlVKXwgbWFCUtuAu4FnK7vLmRd3klhTMiF7oAZy4VkD6PQIpj
         V5cA==
X-Forwarded-Encrypted: i=1; AJvYcCXITqH2gqnGRg0wntTHDcC6NFjvWc/I0aRbfEAkG1SEAwxujOvz4aVnC+8oh6yizWTqGSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gqTYDJsgXvmCkOnVLnvdISqcTkqtkLC+A8hGQGfOSc4CTbh2
	iToIFRNuBZOWmd/JtPji6morC+btXV2JKACflQCjlZF8N6lpZt1tLV49iZcVxrEhRhh8lvmU8uS
	QKObZy/DLHWCQO6+vAYhvlZFahTQ=
X-Gm-Gg: ASbGncvpKIJ33HgBEJtrGYPjMpiuI90K71IXZtHtpwoUUxSvx02vprQYB2TZWwISCEH
	0r7n5ip1LSmczTjQjDTgHoN5YW6mhLVidfDdunOWMqiat5KSHI7HJrA==
X-Google-Smtp-Source: AGHT+IFRhXZ7KLAJ0znT8DioPYndt6WjqgNiXnghDtjXS3gFJpl4ymE/JUSDndcvRVmMnzwKZWOWLrEzSgzdaR3wlIM=
X-Received: by 2002:adf:9b9a:0:b0:38a:4575:5ffd with SMTP id
 ffacd0b85a97d-38a8730fbedmr18845761f8f.45.1736879355939; Tue, 14 Jan 2025
 10:29:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
 <20250114021922.92609-2-alexei.starovoitov@gmail.com> <20250114095355.GM5388@noisy.programming.kicks-ass.net>
 <Z4Y6PS3Nj8EMt9Mx@tiehlicka> <20250114103946.GC8362@noisy.programming.kicks-ass.net>
In-Reply-To: <20250114103946.GC8362@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Jan 2025 10:29:04 -0800
X-Gm-Features: AbW1kvYKbPAf1xVyn9_x3zxilLlIKkzAudqp-Kz34Sgg3trNLynhQN0gigkkqbY
Message-ID: <CAADnVQ+kGLtY0eWwaSL4To3z1KwgmsASvYHFkUXtyiVbvCNDbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 2:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Jan 14, 2025 at 11:19:41AM +0100, Michal Hocko wrote:
> > On Tue 14-01-25 10:53:55, Peter Zijlstra wrote:
> > > On Mon, Jan 13, 2025 at 06:19:17PM -0800, Alexei Starovoitov wrote:
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > Tracing BPF programs execute from tracepoints and kprobes where
> > > > running context is unknown, but they need to request additional
> > > > memory.
> > >
> > > > The prior workarounds were using pre-allocated memory and
> > > > BPF specific freelists to satisfy such allocation requests.
> > > > Instead, introduce gfpflags_allow_spinning() condition that signals
> > > > to the allocator that running context is unknown.
> > > > Then rely on percpu free list of pages to allocate a page.
> > > > The rmqueue_pcplist() should be able to pop the page from.
> > > > If it fails (due to IRQ re-entrancy or list being empty) then
> > > > try_alloc_pages() attempts to spin_trylock zone->lock
> > > > and refill percpu freelist as normal.
> > >
> > > > BPF program may execute with IRQs disabled and zone->lock is
> > > > sleeping in RT, so trylock is the only option.
> > >
> > > how is spin_trylock() from IRQ context not utterly broken in RT?
> >
> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> > +             return NULL;
> >
> > Deals with that, right?
>
> Changelog didn't really mention that, did it? -- it seems to imply quite
> the opposite :/

Hmm. Until you said it I didn't read it as "imply the opposite" :(

The cover letter is pretty clear...
"
- Since spin_trylock() is not safe in RT from hard IRQ and NMI
  disable such usage in lock_trylock and in try_alloc_pages().
"

and the patch 2 commit log is clear too...

"
Since spin_trylock() cannot be used in RT from hard IRQ or NMI
it uses lockless link list...
"

and further in patch 3 commit log...

"
Use spin_trylock in PREEMPT_RT when not in hard IRQ and not in NMI
and fail instantly otherwise, since spin_trylock is not safe from IRQ
due to PI issues.
"

I guess I can reword this particular sentence in patch 1 commit log,
but before jumping to an incorrect conclusion please read the
whole set.

> But maybe, I suppose any BPF program needs to expect failure due to this
> being trylock. I just worry some programs will malfunction due to never
> succeeding -- and RT getting blamed for this.
>
> Maybe I worry too much.

Humans will find a way to blame BPF and/or RT for all of their problems
anyway. Just days ago BPF was blamed in RT for causing IPIs during JIT.
Valentin's patches are going to address that but ain't noone has time
to explain that continuously.

Seriously, though, the number of things that still run in hard irq context
in RT is so small that if some tracing BPF prog is attached there
it should be using prealloc mode. Full prealloc is still
the default for bpf hash map.

