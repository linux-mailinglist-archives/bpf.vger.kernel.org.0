Return-Path: <bpf+bounces-68533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 053B3B59D4C
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 18:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB7464E1B50
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6734AAEA;
	Tue, 16 Sep 2025 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez/S1J0p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E552957CD
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039550; cv=none; b=EXM88hWpjOByoN2ehKm44EXU+RkLe5qva0Tuc2j+tKgB78/iv17pmazqkvxM1Y90KQlV5LFU5k0Bp4wTyJnC0c/2Jj7ULq+DDGLCA4sNQm3bxopwWRwMLwlxeJThGtirBc49R2dqo/SJEdPgr+f5lLm1Z4/CR39iCWGwkDsmLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039550; c=relaxed/simple;
	bh=ipOi1csfdptFDrcZgZhE6C3P8UaUGEbhIvAg8xLG0o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0vRyqkoPoB/xNBfcX1HDgc3lmUKNJuQUd82LoTxRDWFNzvO780ORv/ZSIV8m1t1NsJfpBPHPO3No3NUax5536ctM/HWRjLkwRbQ9EA3R3SpTS140eGrEVjW336T3bfh4stpGQw6IGWKs4YDkgInwr8iWwTUPR/KyYpqdGeXMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez/S1J0p; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso4040564f8f.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758039547; x=1758644347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouS58sMvfoM+nXCDhUN11FIrTKtMJ3xUiuA35NMXazI=;
        b=Ez/S1J0ptdfaJ4lba2pnegJfVp+qieB5olCsTHomDj38BbyekcaYX79GoUODtksU7A
         Jto9gjssCIvLkvU6VMRdrRyQTrDZOK5LNFElQ0M9JHGgxP5fhhq6CiBPEyqZ3zyJdMtX
         lC+sbgaUttUUCjwqN0EyxZtPQ7eHvb+nA7CfHcUmadq3mNKChynTOAYRV8I3x6EKyTpg
         nNjOJi9UqQ6RZJIeE1BUKkZj3g3RLoBTYtvt/fcfpGUZ2LzaWWI89wXfhDgQsrrhMyA/
         k3Mbfd6nbH97ktQcatM4BsCf9j7EkQCROpCIJ1AUFXJV7Z6o9m0dF8k1P+ljWCEe+/yQ
         SoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039547; x=1758644347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouS58sMvfoM+nXCDhUN11FIrTKtMJ3xUiuA35NMXazI=;
        b=Gja60vBWRyuLieYHvjJ/IZv78CC7YXty0OvZ0tCD8XArBwaIGa+yJ3hfsW6gyA5rMD
         yU8gFo07t8rknW6ySZEc9ZAPoTOpJfF7BwbriwQ6doC8za31yb0FxB8ioF57Koi6pG6W
         +y/EV5naibGqxkreN13oWApstZko3Hts62fVWQirF9lBMfM6rt6lc1RAhMmdd9mLgIj7
         ijdV/t90l0h9cKy8+4zVYKDp+GSHkA7VDThBt7SYtdbj4a3MyApyIqRLn3YFlCbTvGNH
         Ww2XTWD6taGNR0JQEJ+bca6VlFYNcsjSNlrjO+o4g4Pnz57fOr/yHYyJPS5S0dextdjG
         mnxw==
X-Forwarded-Encrypted: i=1; AJvYcCWqoQZmBsCp6P0DnkhCIsKAKZCuET3I/2EW1gWRVcj705Dgz9YyVeGWtTzyLUxN8ExuO0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5QEq3hpMOdqEL6gfniLUOD+qtSk8N/8vUPQTkA7wK96SATgWb
	5LPKijvnbPbbMnwvynyN2P2pPdub8qAoaIhDLJPazBpZym9Mbs2vPiUDzflF3Ku6Tu4m79q4UTM
	n9kNOl5DB5o8Dt1ALJTmmbPOUx3NFNm8=
X-Gm-Gg: ASbGnctF0NLNH/D7HmFmTr/8NhYBv1n2kAPx5RupTXxvRx4k6m6Ot1H0FBGKQElscf+
	arWTwcu1ULM9IHRdBFHfCuw8HzODHU9LxXBfAQ4SCao5SKe+fjjFiJaAFOBVhNf/Fn6env9RHN2
	L2JIJlxDcFm1RDCbxrUyTDIXLo7bpetu5sdSt00HwRciPiHoqe6oP0LN/uy5wt/cdzA3QTVn2UW
	Ts937JfkOtIFSPFES8jEw==
X-Google-Smtp-Source: AGHT+IFbSqcghwg20PclUzSC55sPzfzZOVKAiQJdo5k+zPzjlYzFO1Idmqk7QmwROtx6CfIxX2Bb608DGKedAV+yrcc=
X-Received: by 2002:a05:6000:26c9:b0:3ec:a019:393a with SMTP id
 ffacd0b85a97d-3eca0193af4mr2753349f8f.18.1758039546469; Tue, 16 Sep 2025
 09:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916022140.60269-1-alexei.starovoitov@gmail.com>
 <47aca3ca-a65b-4c0b-aaff-3a7bb6e484fe@suse.cz> <aMlZ8Au2MBikJgta@hyeyoo> <e7d1c20c-7164-4319-ac7e-9df0072a12ad@suse.cz>
In-Reply-To: <e7d1c20c-7164-4319-ac7e-9df0072a12ad@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Sep 2025 09:18:52 -0700
X-Gm-Features: AS18NWAVwzfTfIA1ia83p45aX2WthP-MAQG-ap9soO4nTXDDqIGs2hVvFhykNdo
Message-ID: <CAADnVQLNm+0ZwX2MN_JK3ookGxpOGxEdwaaroQk+rGB401E8Jg@mail.gmail.com>
Subject: Re: [PATCH slab] slab: Disallow kprobes in ___slab_alloc()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:13=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/16/25 14:58, Harry Yoo wrote:
> > On Tue, Sep 16, 2025 at 12:40:12PM +0200, Vlastimil Babka wrote:
> >> On 9/16/25 04:21, Alexei Starovoitov wrote:
> >> > From: Alexei Starovoitov <ast@kernel.org>
> >> >
> >> > Disallow kprobes in ___slab_alloc() to prevent reentrance:
> >> > kmalloc() -> ___slab_alloc() -> local_lock_irqsave() ->
> >> > kprobe -> bpf -> kmalloc_nolock().
> >> >
> >> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >>
> >> I wanted to fold this in "slab: Introduce kmalloc_nolock() and kfree_n=
olock()."
> >> and update comments to explain the NOKPROBE_SYMBOL(___slab_alloc);
> >>
> >> But now I'm not sure if we still need to invent the lockdep classes fo=
r PREEMPT_RT anymore:
> >>
> >> > /*
> >> >  * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem=
_cache_cpu::lock
> >> >  * can be acquired without a deadlock before invoking the function.
> >> >  *
> >> >  * Without LOCKDEP we trust the code to be correct. kmalloc_nolock()=
 is
> >> >  * using local_lock_is_locked() properly before calling local_lock_c=
pu_slab(),
> >> >  * and kmalloc() is not used in an unsupported context.
> >> >  *
> >> >  * With LOCKDEP, on PREEMPT_RT lockdep does its checking in local_lo=
ck_irqsave().
> >> >  * On !PREEMPT_RT we use trylock to avoid false positives in NMI, bu=
t
> >> >  * lockdep_assert() will catch a bug in case:
> >> >  * #1
> >> >  * kmalloc() -> ___slab_alloc() -> irqsave -> NMI -> bpf -> kmalloc_=
nolock()
> >> >  * or
> >> >  * #2
> >> >  * kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> b=
pf -> kmalloc_nolock()
> >>
> >> AFAICS see we now eliminated this possibility.
> >
> > Right.
> >
> >> >  * On PREEMPT_RT an invocation is not possible from IRQ-off or preem=
pt
> >> >  * disabled context. The lock will always be acquired and if needed =
it
> >> >  * block and sleep until the lock is available.
> >> >  * #1 is possible in !PREEMPT_RT only.
> >>
> >> Yes because this in kmalloc_nolock_noprof()
> >>
> >>         if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()=
))
> >>                 /* kmalloc_nolock() in PREEMPT_RT is not supported fro=
m irq */
> >>                 return NULL;
> >>
> >>
> >> >  * #2 is possible in both with a twist that irqsave is replaced with=
 rt_spinlock:
> >> >  * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
> >> >  *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_lock(k=
mem_cache_B)
> >> And this is no longer possible, so can we just remove these comments a=
nd drop
> >> "slab: Make slub local_(try)lock more precise for LOCKDEP" now?
> >
> > Makes sense and sounds good to me.
> >
> > Also in the commit mesage should be adjusted too:
> >> kmalloc_nolock() can be called from any context and can re-enter
> >> into ___slab_alloc():
> >>  kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
> >>     kmalloc_nolock() -> ___slab_alloc(cache_B)
> >> or
> >>  kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe -=
> bpf ->
> >>    kmalloc_nolock() -> ___slab_alloc(cache_B)
> >
> > The lattter path is not possible anymore,
> >
> >> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when per-=
cpu
> >> rt_spin_lock is locked by current _task_. In this case re-entrance int=
o
> >> the same kmalloc bucket is unsafe, and kmalloc_nolock() tries a differ=
ent
> >> bucket that is most likely is not locked by the current task.
> >> Though it may be locked by a different task it's safe to rt_spin_lock(=
) and
> >> sleep on it.
> >
> > and this paragraph is no longer valid either?
>
> Thanks for confirming! Let's see if Alexei agrees or we both missed
> something.

Not quite.
This patch prevents
kmalloc() -> ___slab_alloc() -> local_lock_irqsave() ->
    kprobe -> bpf

to make sure kprobe cannot be inserted in the _middle_ of
freelist operations.
kprobe/tracepoint outside of freelist is not a concern,
and
malloc() -> ___slab_alloc() -> local_lock_irqsave() ->
   tracepoint -> bpf

is still possible. Especially on RT.

For example, there are trace_contention_begin/end in spinlocks
and mutexes, so on RT it's easy to construct such reentrance
because local_lock_irqsave() is an rtmutex.
On !RT it's just irqsave and as far as I could analyze
the code there are no tracepoints in
local_lock_cpu_slab()/unlock critical sections.

But it would be fine to add a tracepoint (though silly)
if it is not splitting freelist operation.
Like, local_lock_cpu_slab() is used in put_cpu_partial().
There is no need to mark it as NOKPROBE,
since it doesn't conflict with __update_cpu_freelist_fast().
and it's ok to add a tracepoint _anywhere_ in put_cpu_partial().
It's also fine to add a tracepoint right after
local_lock_cpu_slab() in ___slab_alloc(),
but not within freelist manipulations.
rtmutex's trace_contention tracepoint is such
safe tracepoint within a critical section.

So "more precise for LOCKDEP" patch is still needed.

I thought about whether do_slab_free() should be marked as NOKPROBE,
but that's not necessary. There is freelist manipulation
there under local_lock_cpu_slab(), but it's RT only,
and there is no fast path there.

>
> >> >  * local_lock_is_locked() prevents the case kmem_cache_A =3D=3D kmem=
_cache_B
> >> >  */
> >>
> >> However, what about the freeing path?
> >> Shouldn't we do the same with __slab_free() to prevent fast path messi=
ng up
> >> an interrupted slow path?
> >
> > Hmm right, but we have:
> >
> > (in_nmi() || !USE_LOCKLESS_FAST_PATH()) && local_lock_is_locked()
>
> Yes, but like in the alloc case, this doesn't trigger in the
> !in_nmi() && !PREEMPT_RT case, i.e. a kprobe handler on !PREEMPT_RT, righ=
t?
>
> But now I think I see another solution here. Since we're already under
> "if (!allow_spin)" we could stick a very ugly goto there to skip the
> fastpath if we don't defer_free()?
> (apparently declaration under a goto label is a C23 extension)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 6e858a6e397c..212c0e3e5007 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6450,6 +6450,7 @@ static __always_inline void do_slab_free(struct kme=
m_cache *s,
>  {
>         /* cnt =3D=3D 0 signals that it's called from kfree_nolock() */
>         bool allow_spin =3D cnt;
> +       __maybe_unused unsigned long flags;
>         struct kmem_cache_cpu *c;
>         unsigned long tid;
>         void **freelist;
> @@ -6489,6 +6490,9 @@ static __always_inline void do_slab_free(struct kme=
m_cache *s,
>                         return;
>                 }
>                 cnt =3D 1; /* restore cnt. kfree_nolock() frees one objec=
t at a time */
> +
> +               /* prevent a fastpath interrupting a slowpath */
> +               goto no_lockless;

I'm missing why this is needed.

do_slab_free() does:
                if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
                    local_lock_is_locked(&s->cpu_slab->lock)) {
                        defer_free(s, head); return;

It's the same check as in kmalloc_nolock() to avoid invalid:
freelist ops -> nmi -> bpf -> __update_cpu_freelist_fast.

The big comment in kmalloc_nolock() applies here too.
I didn't copy paste it.
Maybe worth adding a reference like:
/* See comment in kmalloc_nolock() why fast path should be skipped
in_nmi() && lock_is_locked() */

So this patch with NOKPROBE_SYMBOL(___slab_alloc)
is enough, afaict.
Maybe expand a comment with the above details while folding?

