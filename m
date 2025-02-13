Return-Path: <bpf+bounces-51421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477ABA34707
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9E218920A5
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97D15A856;
	Thu, 13 Feb 2025 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVsbdOiu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9263335BA
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460198; cv=none; b=jqFYj0Rno352CfZiR+OKHSMqQ4EcEvX+S+0y//V+oVXOh7IrokNU0DXYduHB6v/7Ln28exeK73pldxKsk6btVUHFEc3wPhY+HhN2cL0mbhmEWFP5TiYi7/Q4scDK3K5vqhu8WqTGrBqtzGFCGEBJJFcp5Ykm4WF1VbNhves84EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460198; c=relaxed/simple;
	bh=PdTGN2abm+tt1Ds6cA7t1KfKC8uepdj/pp4ek+R8Llg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEMEPKU070iF82i0d3WspuD7Vkfnp6eB7yvUu5JPyI/UWLdK2BiT1vrxNXcc/g77VVgsdqH86qxNZkF4Gz5kZLamVrzXoPrs4F6prAklX1QtD9JKezltIcti5vTDuD2s0Lojl3r+q3/3Dnfjxm4dxxNGtXEjcn3p34CxkIZI5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVsbdOiu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38dc73cc5acso645836f8f.0
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 07:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739460194; x=1740064994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNgGb6l5tYjsIuQBPp0l3fcq090lnq3JNho4P21Atgw=;
        b=YVsbdOiu1JOrXl/BcR2zoIhTjUnQlWitTLDHYai5hzmslhV3hhUsrIy7VJftpYTgD4
         d7J8zkqnmUESBacQq7zMBiDHXdyvQieqFllleoHDN9Z29FZZ3kdnSLbFEXDqgqGL669Y
         Rht7UAXvW8dl/r55dqI8WNcXDuFsOwtIqaqq7iWKIUsqxyhUYz8n6lkcw4/1zSIwffXo
         ke4dfE/TYjoj3HU6dEfG41f/xbZJdUUJ2J9l0BtUjAiNuKgY3PfhCvKMUFy2Ufo9fdeQ
         XG4jTZICCWzq3qAMGvRf0D1/MctwWC8IpV5fK8moy5vM53gjagYV/MhXZJg6OX+pkasB
         8SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460194; x=1740064994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNgGb6l5tYjsIuQBPp0l3fcq090lnq3JNho4P21Atgw=;
        b=EC/cUKuorbZ65bEDbNpvXp1VPaAP26jSFaBF1RWERHhssy5Y7pDU5Z1LYsFD4Q6P1l
         qFXlPlsZiZgtKve85o7wVwS9bTSymvjG0xNIsn8/qQlkzxH2wzRoxUxN6m5mLTRRQ/Ja
         k1ypvlhG6M0ipG4NP/9kYYPEJMzZVpKuAxyyX3zVVYVCyzo1GpNHQMeOXAfIwNXmE42Z
         iWb+8LBx781775rSG8iposXPELRwfuiyx8UKt1N9vQy8+iTTUwiifylftPSSgB2fJPrZ
         ljGmanbiJ4KKJI3nwqdDMLlCN57kkDdmQZ4kgnT3rm4EsnFtrbfvZ5sEWRWWbaZC7Zli
         I6vA==
X-Gm-Message-State: AOJu0YwU13VJBBGvMZ8Ue/7fh/nlwxjZ8zwC+iqknq/fKBm3F/1HlpSH
	FEhc2zpXkNPigtqlJuXoUfQrUE+ZwK8v0afol1ElgHxW1vtfW3Cl2gfjxGeJqhPVEM9lkBGM7le
	yHw81B1DwF4xPaLSYH2A8cCeOORM=
X-Gm-Gg: ASbGncvEWlfhIRCnf2gMMb4+cq2Qlh7GIFb0xducGQoP4BKqqZoXySPxOVPifOCg1bG
	uodxzg1jPdrgROvSmIqsjA5RrI5uXZQ+vBdUZALE1452kb0qEVrSHPOdDYgi1s0Bi1e9T0rCwNG
	cWtYWbiXCfK5CdhjauunElqs7CIfFf
X-Google-Smtp-Source: AGHT+IFcUtfVqwEaTPMb8xVdl8fitubOSxsfQpzrIL9HpGgE925Pq++6b3ZPtIiHMKM/uN8S/l+OPSwBotnObY0oBb4=
X-Received: by 2002:a05:6000:41e4:b0:38f:232e:dd5e with SMTP id
 ffacd0b85a97d-38f24d7417emr4521607f8f.22.1739460193717; Thu, 13 Feb 2025
 07:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
 <20250213033556.9534-4-alexei.starovoitov@gmail.com> <1fda7391-228d-4e10-8449-189be36eb27c@suse.cz>
In-Reply-To: <1fda7391-228d-4e10-8449-189be36eb27c@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 07:23:01 -0800
X-Gm-Features: AWEUYZlVB9dARHXXyb1nl84B3JYlu65sCgJAqmfDsTD6Tg5SvasEOn9sCJyAYKs
Message-ID: <CAADnVQLHRb8fu9J6Yd63ZDBtJFzZN1oWfwSDA_QXFqzXyr9F5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/6] locking/local_lock: Introduce localtry_lock_t
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 7:04=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/13/25 04:35, Alexei Starovoitov wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >
> > In !PREEMPT_RT local_lock_irqsave() disables interrupts to protect
> > critical section, but it doesn't prevent NMI, so the fully reentrant
> > code cannot use local_lock_irqsave() for exclusive access.
> >
> > Introduce localtry_lock_t and localtry_lock_irqsave() that
> > disables interrupts and sets acquired=3D1, so localtry_lock_irqsave()
> > from NMI attempting to acquire the same lock will return false.
> >
> > In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
> > Map localtry_lock_irqsave() to preemptible spin_trylock().
> > When in hard IRQ or NMI return false right away, since
> > spin_trylock() is not safe due to PI issues.
> >
> > Note there is no need to use local_inc for acquired variable,
> > since it's a percpu variable with strict nesting scopes.
> >
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/local_lock.h          |  59 +++++++++++++
> >  include/linux/local_lock_internal.h | 123 ++++++++++++++++++++++++++++
> >  2 files changed, 182 insertions(+)
> >
> > diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> > index 091dc0b6bdfb..05c254a5d7d3 100644
> > --- a/include/linux/local_lock.h
> > +++ b/include/linux/local_lock.h
> > @@ -51,6 +51,65 @@
> >  #define local_unlock_irqrestore(lock, flags)                 \
> >       __local_unlock_irqrestore(lock, flags)
> >
> > +/**
> > + * localtry_lock_init - Runtime initialize a lock instance
> > + */
> > +#define localtry_lock_init(lock)             __localtry_lock_init(lock=
)
> > +
> > +/**
> > + * localtry_lock - Acquire a per CPU local lock
> > + * @lock:    The lock variable
> > + */
> > +#define localtry_lock(lock)          __localtry_lock(lock)
> > +
> > +/**
> > + * localtry_lock_irq - Acquire a per CPU local lock and disable interr=
upts
> > + * @lock:    The lock variable
> > + */
> > +#define localtry_lock_irq(lock)              __localtry_lock_irq(lock)
> > +
> > +/**
> > + * localtry_lock_irqsave - Acquire a per CPU local lock, save and disa=
ble
> > + *                    interrupts
> > + * @lock:    The lock variable
> > + * @flags:   Storage for interrupt flags
> > + */
> > +#define localtry_lock_irqsave(lock, flags)                           \
> > +     __localtry_lock_irqsave(lock, flags)
> > +
> > +/**
> > + * localtry_trylock_irqsave - Try to acquire a per CPU local lock, sav=
e and disable
> > + *                         interrupts if acquired
> > + * @lock:    The lock variable
> > + * @flags:   Storage for interrupt flags
> > + *
> > + * The function can be used in any context such as NMI or HARDIRQ. Due=
 to
> > + * locking constrains it will _always_ fail to acquire the lock on PRE=
EMPT_RT.
>
> The "always fail" applies only to the NMI and HARDIRQ contexts, right? It=
's
> not entirely obvious so it sounds worse than it is.
>
> > +
> > +#define __localtry_trylock_irqsave(lock, flags)                      \
> > +     ({                                                      \
> > +             int __locked;                                   \
> > +                                                             \
> > +             typecheck(unsigned long, flags);                \
> > +             flags =3D 0;                                      \
> > +             if (in_nmi() | in_hardirq()) {                  \
> > +                     __locked =3D 0;                           \
>
> Because of this, IIUC?

Right.
It's part of commit log:
+ In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
+ Map localtry_lock_irqsave() to preemptible spin_trylock().
+ When in hard IRQ or NMI return false right away, since
+ spin_trylock() is not safe due to PI issues.

Steven explained it in detail in some earlier thread.

realtime is hard. bpf and realtime together are even harder.
Things got much better over the years, but plenty of work ahead.
I can go in detail, but offtopic for this thread.

