Return-Path: <bpf+bounces-54976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8981CA76A68
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 17:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4A07A1666
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F883218AA3;
	Mon, 31 Mar 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="VvKN2nlt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D542144CF
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433206; cv=none; b=qqG8ClhTrkiGyNaeREcIGudl5/i5xFKVnGx9clisPLNbpDQUhY0xdvOpwX31erWhVemUtKUHU3dO1F01qNcUTOd98co690CkxruPxzN6c4ViVxAMipEsKA2f8b7XYCf6CdkAl3qRknEshsn6VE5DUvbYrYioVrEKsxlbQBduwaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433206; c=relaxed/simple;
	bh=1EN/cIMgUtWr0qWN49ERSHoJ6jcvO58c2E3XnD9QX1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O//5BzukTUKCIo47/VhGdQghvA+zHyNNyXvhgB/NiR5013R7iTheVV8PjMWlBYhIhHtfbkD67BacqjOLtTpPh3gtFMqIKdvx+Sx+tCq/+dlx9pAuz1qe9EDE9X5hZ4lIcicSZtvo07Pu8+MCpQZpre3oI+ZSRDvluxQgbgq91fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=VvKN2nlt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c07cd527e4so426915285a.3
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1743433203; x=1744038003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/XP5iQdJ2sfX5iQDsDzT/UIhpAdSsTpMGtKs110k1o=;
        b=VvKN2nlt3tFyCTyT+cKUdfgSwQVwkP6ps/amL+FYl7nSq5S5noWmOp3e+UCPYSZs6K
         SPKddWdgvScKp4PfnOujme1iYrAgAbIFnNin4aFXrCeimA7ZMNL5R4yKpHD7l/awwD0u
         uPRevIz4sRx+qGuDNlbLnQ0A+uzESW1JUhyhrTdbgG7Vntb9G2lHp9+zTEma0gx2GXwa
         JlzWbr8r974q94aGwiIDTWcJ8IuJHpF/yWqJzY0kIKCVPt/c4JMo8AGh8ugYQZYLq+YB
         W83Iy/rQUELTUrrrTOIvwvQBQPWOAU5W2a9i7SUZzbBzQ7ZnM7/NhWQUatqTSyYxAPqA
         zHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433203; x=1744038003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/XP5iQdJ2sfX5iQDsDzT/UIhpAdSsTpMGtKs110k1o=;
        b=KYAfNdDn2mYOpyGGU3vPWGrvvnBT+ou9rl11jIPZU+/x32WqyhUzL5z9XUXs9P2/LM
         kkWmCzztxxCI9gON/+EFjlYDOy9m0+ozlEBCpUO8BjrCw/K7QcrAOnoq2tXq6DPMgk8X
         XqryOx0PxTi3JXHvcw7CyGaAHwBcxWhbDu9VgQ6X63BYJl28RY5sZF4pYf9g81x+SzYn
         b8p7ItgKTJYrPi7gUihxcrAq3YYel3pjLtshVvcSurgytsrCnaG/y7CFrdJfv23bEexh
         DXLvv525km3gr8dcHet8WhemPmbsZRCijrO6MZouNWulD1hzZi+/8VA41lIEcEX3gfaN
         sKRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGkgLIaLlfpJqcZ7GM4oC/ZFCx9firkFiI8ws3H54thWy0OfmC2TLnhBMrU216v2CjxMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQEb/k77bhxA5VYeT0F3KyskpqFgC5iC2zMMzIbHk394jPAGb0
	BcT+Z9RmDdDBEuqZ4DWHr1xmwkczu/oJoYz3o/TOe2KqZzdEgQTPP+rfesyfHIA=
X-Gm-Gg: ASbGncu+2kFvBW0JMxSNpO1ZqBb117kAEopWosDtXsn5MnfxjR/+PXrpD4MlU1YUDhc
	e6qH0byeVx8UK+xaAA/7z59EmfUZm/GZA2re8Cn3D4TCARioeIgn4WlJ8RqOZ3ZcvS5Twgn3LtE
	EIxfkZG1jjM/tuwvuDuhTAG3FAHfA+b5/MIIgTnrqR3cC+C+OrOsViqP1NrlrEUPPj49jmbyOph
	jYXIYKwbU8dfy+A3S3KG58gxzaTuAI5knHgXFtONV/EtcFsu54IqM9aHn5vwAAxzz/wZs+f1bMF
	3+EUA2dYHthpKgOM1dY4NHFwFnaeZSgLViDPcD6udyk=
X-Google-Smtp-Source: AGHT+IE9kLbI8h0rUyhUxntQ/fxPgI58b5Kb5NuIQENL4V46jZPC7rePLkR5c64cC1zxLsKy2I1Ivg==
X-Received: by 2002:ac8:7d08:0:b0:471:cdae:ac44 with SMTP id d75a77b69052e-477ed78e91cmr123041321cf.47.1743433202781;
        Mon, 31 Mar 2025 08:00:02 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47782a49facsm50913661cf.31.2025.03.31.08.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:00:01 -0700 (PDT)
Date: Mon, 31 Mar 2025 10:59:57 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Michal Hocko <mhocko@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
Message-ID: <20250331145957.GA2110528@cmpxchg.org>
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
 <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
 <CAADnVQJBHPbq6+TQhM2kmWNBTiPoB50_fnVcwC+yLOtpjUWujA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJBHPbq6+TQhM2kmWNBTiPoB50_fnVcwC+yLOtpjUWujA@mail.gmail.com>

On Sun, Mar 30, 2025 at 02:30:15PM -0700, Alexei Starovoitov wrote:
> On Sun, Mar 30, 2025 at 1:42 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 27 Mar 2025 at 07:52, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > The pull includes work from Sebastian, Vlastimil and myself
> > > with a lot of help from Michal and Shakeel.
> > > This is a first step towards making kmalloc reentrant to get rid
> > > of slab wrappers: bpf_mem_alloc, kretprobe's objpool, etc.
> > > These patches make page allocator safe from any context.
> >
> > So I've pulled this too, since it looked generally fine.
> 
> Thanks!
> 
> > The one reaction I had is that when you basically change
> >
> >         spin_lock_irqsave(&zone->lock, flags);
> >
> > into
> >
> >         if (!spin_trylock_irqsave(&zone->lock, flags)) {
> >                 if (unlikely(alloc_flags & ALLOC_TRYLOCK))
> >                         return NULL;
> >                 spin_lock_irqsave(&zone->lock, flags);
> >         }
> >
> > we've seen bad cache behavior for this kind of pattern in other
> > situations: if the "try" fails, the subsequent "do the lock for real"
> > case now does the wrong thing, in that it will immediately try again
> > even if it's almost certainly just going to fail - causing extra write
> > cache accesses.
> >
> > So typically, in places that can see contention, it's better to either do
> >
> >  (a) trylock followed by a slowpath that takes the fact that it was
> > locked into account and does a read-only loop until it sees otherwise
> >
> >      This is, for example, what the mutex code does with that
> > __mutex_trylock() -> mutex_optimistic_spin() pattern, but our
> > spinlocks end up doing similar things (ie "trylock" followed by
> > "release irq and do the 'relax loop' thing).
> 
> Right,
> __mutex_trylock(lock) -> mutex_optimistic_spin() pattern is
> equivalent to 'pending' bit spinning in qspinlock.
> 
> > or
> >
> >  (b) do the trylock and lock separately, ie
> >
> >         if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
> >                 if (!spin_trylock_irqsave(&zone->lock, flags))
> >                         return NULL;
> >         } else
> >                 spin_lock_irqsave(&zone->lock, flags);
> >
> > so that you don't end up doing two cache accesses for ownership that
> > can cause extra bouncing.
> 
> Ok, I will switch to above.
> 
> > I'm not sure this matters at all in the allocation path - contention
> > may simply not be enough of an issue, and the trylock is purely about
> > "unlikely NMI worries", but I do worry that you might have made the
> > normal case slower.
> 
> We actually did see zone->lock being contended in production.
> Last time the culprit was an inadequate per-cpu caching and
> these series in 6.11 fixed it:
> https://lwn.net/Articles/947900/
> I don't think we've seen it contended in the newer kernels.
>
> Johannes, pls correct me if I'm wrong.

Contention should indeed be rare in practice. This has become a very
coarse lock, with nowadays hundreds of HW threads hitting still only
one or two zones. A lot rides on the fastpath per-cpu caches, and it
becomes noticable very quickly if those are sized inappropriately.

> But to avoid being finger pointed, I'll switch to checking alloc_flags
> first. It does seem a better trade off to avoid cache bouncing because
> of 2nd cmpxchg. Though when I wrote it this way I convinced myself and
> others that it's faster to do trylock first to avoid branch misprediction.

If you haven't yet, it could be interesting to check if/where branches
are generated at all, given the proximity and the heavy inlining
between where you pass the flag and where it's tested.

