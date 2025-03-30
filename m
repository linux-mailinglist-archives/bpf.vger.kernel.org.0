Return-Path: <bpf+bounces-54906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADB7A75CBC
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 23:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9515F7A39BD
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15911BEF8A;
	Sun, 30 Mar 2025 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPWrbCi3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE0BE67;
	Sun, 30 Mar 2025 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743370230; cv=none; b=md5A0BFSu3I2dm0vIjhzaRGf1xoRZQac53yedE3GLoX4BDJPMjA2GwMgU5F4SyCRHtv5LjZUZ+kajmE804LbkkVBsosOhzAss6YUOyEV/laymQHs2dOXr0B5DX7KEJgSFfL8xQI0Bj3phMmNVuXnLKzJ7NGyRzJJtJNPZ+650Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743370230; c=relaxed/simple;
	bh=rwPm/b9mN0zAn8FYFaggPzfpON9La4aWZ1wDAZv7GmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlaC8Lm9RhgXXa0wMa8QqNrfBzu5sskfqnin9R6GKT600dO2F1vEp4EXJQ3tgN+KKJHzbRYlWkB/2YzUA90qF3Jbzzpq575QqFsHfxf3ly+xMQYYah21qIAXvbrs4+fr8F9xfolYQ7JhW7KPuw/pm192QSjT7AMxoXIVewvC7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPWrbCi3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso3661605f8f.0;
        Sun, 30 Mar 2025 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743370227; x=1743975027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOOpYDacP3qw4CicXaURsjZhalE+xbMRn+milGOOg5E=;
        b=ZPWrbCi3d9YJabEwAIh77/4Geo6+e3193HJeNZErD/DnDJGTGCWVmAn4iqMGI3PSxs
         2c95kbKyTpCGjoXZ3BY219oRa/KSpQ3hqIBFfXQ2xG8LxdQ+3LRyomDTgqmeQ3pn1m6D
         r+SwkPlIXl51oDrksjAqYKH3A/Q9lYnnNu9XyXtfIWVHiDRHya3cz4Dqe/AQVeJR8L4D
         gS7u6U8ABPY0HfnCC6VaGj1p/GtGupfND1RjzWhnSiIEGurT+sNgcEo77//l3Vw/oP8i
         oVoQ1jdFgfipmASCLkFD8vLuQCu4caMl80atkGVW95XvAdYd28ZLfYD5/7yMNJpRt3z3
         dbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743370227; x=1743975027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOOpYDacP3qw4CicXaURsjZhalE+xbMRn+milGOOg5E=;
        b=SNw6ntTksKgNabECkE+wQBXn8Rxx376V4UemkKlMHaKk0Fv4oYgN9bIxWbK7flpBmm
         iXww8EA2TNvzyTwFWqLDxWrLt3Br15IUzEeUsZlSYqvgQfSD+L0X4ka4nz97pKT9xNbD
         Y7E+5Zj+TboFMar9+0Tfu3yNYDgpitKpX/eYnKj8gYEjtp05V9K1FUXan/uddEIx2sEN
         qdt4eKM/7ei2dhpracUGUVHYBTlTV/MtnSNt4SOqEj+4wOCSnU0ZuKxRe+ppqrgQ9F8V
         gX1WzSf/ulCMdswksujkkT73Et3W5f4N3H4PHkAAX0AV95CYu06DYikITHWCnOUHIlVl
         89wg==
X-Forwarded-Encrypted: i=1; AJvYcCVLGAtdjWr+xjxpe1AQYlRpCu0BtqQYlIsT92UyRxrITyYsRBv2HKeZZixN4fORBf0Ed9rumGP1Bc7GGMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7fpRjPCTI5/OIyVJ+JQYMfyQ97di2fCYANd9UKDy9/MEgjPj
	O3rxtxnicshok1qS23Exgw5zh4PCEhjjDnmcBXCkMxNzLIamQQPntj8oq20Zo0ZKvbqyPcA7RD5
	vLQj3KDrJgMW/hcA61Na9aUb1aDQ=
X-Gm-Gg: ASbGnctIirJfqblIMx//t1XUtyMAF4Gdt4Q21myxpNUcwKquw1g7Wx7xid0FuceWzrD
	eUCQypp3DcpA6HMl1mgVewT5cr1eWHSVcdMUsL4VDHPcdUu7zaqerlIp5QbJTcIqA8cFlQKimNj
	ncEPK0chILVGL6KC1S+nyELV/UjZQfY2QQqzNYhFm6nncppmChpeIW
X-Google-Smtp-Source: AGHT+IGy6TYkwqWgmB4qVvUpl+hS3Hb0sVBnt8U2ZwjeeCa8mROOAVHVYBHFbL7WUn3u4+jOQRKGFypsVayyAIua8Uc=
X-Received: by 2002:a05:6000:2913:b0:39a:ca59:a626 with SMTP id
 ffacd0b85a97d-39c120e3e5cmr5650236f8f.28.1743370226631; Sun, 30 Mar 2025
 14:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com> <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
In-Reply-To: <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 30 Mar 2025 14:30:15 -0700
X-Gm-Features: AQ5f1JqKoFYJATW7xwoyQD92tAvSQWSre1BbHdyzNRzzGs11RJb--CavgF31AIQ
Message-ID: <CAADnVQJBHPbq6+TQhM2kmWNBTiPoB50_fnVcwC+yLOtpjUWujA@mail.gmail.com>
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 1:42=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 27 Mar 2025 at 07:52, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > The pull includes work from Sebastian, Vlastimil and myself
> > with a lot of help from Michal and Shakeel.
> > This is a first step towards making kmalloc reentrant to get rid
> > of slab wrappers: bpf_mem_alloc, kretprobe's objpool, etc.
> > These patches make page allocator safe from any context.
>
> So I've pulled this too, since it looked generally fine.

Thanks!

> The one reaction I had is that when you basically change
>
>         spin_lock_irqsave(&zone->lock, flags);
>
> into
>
>         if (!spin_trylock_irqsave(&zone->lock, flags)) {
>                 if (unlikely(alloc_flags & ALLOC_TRYLOCK))
>                         return NULL;
>                 spin_lock_irqsave(&zone->lock, flags);
>         }
>
> we've seen bad cache behavior for this kind of pattern in other
> situations: if the "try" fails, the subsequent "do the lock for real"
> case now does the wrong thing, in that it will immediately try again
> even if it's almost certainly just going to fail - causing extra write
> cache accesses.
>
> So typically, in places that can see contention, it's better to either do
>
>  (a) trylock followed by a slowpath that takes the fact that it was
> locked into account and does a read-only loop until it sees otherwise
>
>      This is, for example, what the mutex code does with that
> __mutex_trylock() -> mutex_optimistic_spin() pattern, but our
> spinlocks end up doing similar things (ie "trylock" followed by
> "release irq and do the 'relax loop' thing).

Right,
__mutex_trylock(lock) -> mutex_optimistic_spin() pattern is
equivalent to 'pending' bit spinning in qspinlock.

> or
>
>  (b) do the trylock and lock separately, ie
>
>         if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
>                 if (!spin_trylock_irqsave(&zone->lock, flags))
>                         return NULL;
>         } else
>                 spin_lock_irqsave(&zone->lock, flags);
>
> so that you don't end up doing two cache accesses for ownership that
> can cause extra bouncing.

Ok, I will switch to above.

> I'm not sure this matters at all in the allocation path - contention
> may simply not be enough of an issue, and the trylock is purely about
> "unlikely NMI worries", but I do worry that you might have made the
> normal case slower.

We actually did see zone->lock being contended in production.
Last time the culprit was an inadequate per-cpu caching and
these series in 6.11 fixed it:
https://lwn.net/Articles/947900/
I don't think we've seen it contended in the newer kernels.

Johannes, pls correct me if I'm wrong.

But to avoid being finger pointed, I'll switch to checking alloc_flags
first. It does seem a better trade off to avoid cache bouncing because
of 2nd cmpxchg. Though when I wrote it this way I convinced myself and
others that it's faster to do trylock first to avoid branch misprediction.

