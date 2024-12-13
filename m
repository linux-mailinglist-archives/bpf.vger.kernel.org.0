Return-Path: <bpf+bounces-46884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F069F152C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 19:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAC028475C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A424F1E8841;
	Fri, 13 Dec 2024 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNmo/MpL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A41E47B6
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115481; cv=none; b=IYDkmZLAgRmhnacSXlRsORgQYxgzCpEFusOp2MGXTHFpqJJXx1Ohb5gP/3pUTMpmftSYhpmma2cLVpNKdenMm/CdpPKfH7rA4Da4c/VDJB+TrwqY/kgcnDCi8n/0oFt8ySULpKV54j6ACBKwz9omDHPzcdpS4bWoBE5EtlONUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115481; c=relaxed/simple;
	bh=JqNabldwuJWunVuHWHIn1MzjVhCi3LTH80zB2K6DqWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gnyfm7HVVS5fSEgnTqYy+dnpCo3yV9icV1UusOYQfqDt3lqU3NGZeOq0NFyEbWHZkO0BH7pzQosVlkwmc/qwHVcrrG/KwY3szyCyVSvNC5nqwTwW8HdqjqKF2blpqDE9l8LLIyoEFXnlqEJVn5d1HlEjkadi99IeKIcPxzFSiEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNmo/MpL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e3621518so1008653f8f.1
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 10:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734115478; x=1734720278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrSCJE+EGfJUskmDWEJ6FaLoRajg4WYRBr19oClqqVA=;
        b=mNmo/MpLuBVZ3nm2j+2l7Bpaia2/ZF6GlNG9eLqtCqvGZSA5pkDwfh6Xw4qld50GjC
         dAPuZPgrPmVPXqyXyBeK3hxsTetaLyuTIqX79e55nzdeX9qifagyXzBbZTX8nFvPo5Gu
         ZycyNVeU03rQqXSluz5/SFh42JHfPSEhadD1hpSz83CRVyH89yjA5vUhc+gwf+rPWqzv
         RK3nHr/tvKwdIitshk6IE+a4Qsk7mNuHWARz/pOaBTjWlujvqifHbetFAmuoaB2xdeu/
         CPfDEIDMBHP/PRyLjVgUDA/REMs7DELrYbu6Wz1RKJk6k51rgJ5A+iMiRpSd1UjSqDXB
         J2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734115478; x=1734720278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrSCJE+EGfJUskmDWEJ6FaLoRajg4WYRBr19oClqqVA=;
        b=HnElouE7spgO1B/mJrk6HS8KUziFn2fhV43FJKJ+tRACOgigTOZbwWwoFLRMSzvd+B
         TYK8NN7QREsDuNGuyrRQCX6fNt6Ih37uH0iyHh89b1H4MgqUBUtBJwWHUuiefR1GiciU
         kpRw8Vi6taDRADM/fh+1uMeTTcawofkHYd/CYud2EtOfvG4GEiyyINANBDcxRqvsQI7+
         cqCn/a1Z/Lf6vAE7Xc/oo8hviYlaQ5Z2cwBF3w60F0TM+gv762qpuiKe4zhhYZHiUO3A
         8M3RFajyPketk6+hwxEHZASMJEbjvmymPznxzpTM510BJi1W1DbtxONbsTxaXljX37OU
         9f/Q==
X-Forwarded-Encrypted: i=1; AJvYcCViqzptQrhs2jOyjg4eQj9fhh7lF8hoN0jVKMiYus1OUa0bWwPSmOA5R2JqkHD1c9L22kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+M8o4f7S5zos+sn/4qRpT3aO1/txtw9//XwavQ9TlCQdWgFBz
	Jb63RyTSxHgNUmEom2MM2a8tQiTTK9IzlSuHH0kKpRAJlbpTITeGppazeuyITDGP4gTQvYIf2M9
	yoY7aHbSyzh5FjWJIpjv3t49q/Zc=
X-Gm-Gg: ASbGncsUsbS1BFut+/0rf3KmFz4oz2hq7cBqZNS9QkZeMu2ToqFrHmmahllmhH2cWB9
	x8LC4/7eUaqbgXFvr50tOlAXTl7OuIjJQDuXnSpzVAjITru0N07gjTJaMdag3pcfennVT0g==
X-Google-Smtp-Source: AGHT+IFZcpiXKP/ZcONpx5vmGIX9lMq29yMBYpt8oS6CIF6nJKSM0r5W8OGVJ2YUpoiuuO1uWwmS0SPMb+X65HN6SlE=
X-Received: by 2002:a05:6000:4709:b0:386:3803:bbd8 with SMTP id
 ffacd0b85a97d-3888e0c4d35mr2989495f8f.59.1734115477492; Fri, 13 Dec 2024
 10:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com> <Z1fSMhHdSTpurYCW@casper.infradead.org>
 <Z1gEUmHkF1ikgbor@tiehlicka> <CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
 <20241212150744.dVyycFUJ@linutronix.de> <Z1r_eKGkJYMz-uwH@tiehlicka>
 <20241212153506.dT1MvukO@linutronix.de> <20241212104809.1c6cb0a1@batman.local.home>
 <20241212160009.O3lGzN95@linutronix.de> <20241213124411.105d0f33@gandalf.local.home>
In-Reply-To: <20241213124411.105d0f33@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Dec 2024 10:44:26 -0800
Message-ID: <CAADnVQ+R3ABHX2sdiTqjgZDgn0==cA3gryx9h_uDktU6P2s2aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 9:43=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 12 Dec 2024 17:00:09 +0100
> Sebastian Sewior <bigeasy@linutronix.de> wrote:
>
> >
> > The lockig of the raw_spinlock_t has irqsave. Correct. But not because
> > it expects to be called in interrupt disabled context or an actual
> > interrupt. It was _irq() but got changed because it is used in the earl=
y
> > init code and would unconditionally enable interrupts which should
> > remain disabled.
> >
>
> Yep, I understand that. My point was that because it does it this way, it
> should also work in hard interrupt context. But it doesn't!
>
> Looking deeper, I do not think this is safe from interrupt context!
>
> I'm looking at the rt_mutex_slowlock_block():
>
>
>                 if (waiter =3D=3D rt_mutex_top_waiter(lock))
>                         owner =3D rt_mutex_owner(lock);
>                 else
>                         owner =3D NULL;
>                 raw_spin_unlock_irq(&lock->wait_lock);
>
>                 if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner)=
)
>                         rt_mutex_schedule();
>
>
> If we take an interrupt right after the raw_spin_unlock_irq() and then do=
 a
> trylock on an rt_mutex in the interrupt and it gets the lock. The task is
> now both blocked on a lock and also holding a lock that's later in the
> chain. I'm not sure the PI logic can handle such a case. That is, we have
> in the chain of the task:
>
>  lock A (blocked-waiting-for-lock) -> lock B (taken in interrupt)
>
> If another task blocks on B, it will reverse order the lock logic. It wil=
l
> see the owner is the task, but the task is blocked on A, the PI logic
> assumes that for such a case, the lock order would be:
>
>   B -> A
>
> But this is not the case. I'm not sure what would happen here, but it is
> definitely out of scope of the requirements of the PI logic and thus,
> trylock must also not be used in hard interrupt context.

If hard-irq acquired rt_mutex B (spin_lock or spin_trylock doesn't
change the above analysis), the task won't schedule
and it has to release this rt_mutex B before reenabling irq.
The irqrestore without releasing the lock is a bug regardless.

What's the concern then? That PI may see an odd order of locks for this tas=
k ?
but it cannot do anything about it anyway, since the task won't schedule.
And before irq handler is over the B will be released and everything
will look normal again.

