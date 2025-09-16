Return-Path: <bpf+bounces-68542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB9B5A0C3
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 20:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17549160E1D
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B826E6FB;
	Tue, 16 Sep 2025 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzioAlE2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00754747F
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048382; cv=none; b=YWCcHd/ocgUrDmsvdUn6L9vYgSmxWao5QTSmIJCSV0cmGGKsaQNvm+3PBcLcTmI3mrdBbJ7mbNZqX68tGIduUyQFejKiDuelYbpNUdrWTMrEt+L42uBAJ/uyR2HosFcJc1T8uDtmuttchp1VP+po2Vibat0qQqdhAYsB7+Wntao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048382; c=relaxed/simple;
	bh=7P4SXyZE0IKlcAmJVk0GzpewntbnHNFqLg2J735Pa3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNSTn7Msxpx1UvaZxc900b0bzNQot913zY/AywGGRWusDDalWNIy2jIEOZMkybfbhj5KrgI5GR+RYhwkw88HkGunPDfa7OudWyKQhgimqi3lWjLePMFH47mffVv+vS1UpUd94y7acehPVgO2V6U1pxCouGOybNpVAqu0stPeCmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzioAlE2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45f2cf99bbbso17096155e9.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758048377; x=1758653177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIfHkkN0KymLLDe2RxUNHtpRmvEkAgg1GpcLf9403Ls=;
        b=KzioAlE2Xkp5sD8qohmr6ZzzAiI7uQNdDOAR0C2FJjH0iUSRWxbfKpotzfOUUOntVa
         /Tbkj8A7z6u4taTXNST7N74jgu4QCiNuVudrgZC/tF3ECVoEpxwFtS1Efy9mxsXyRoSz
         ZB80ynDQumimUV7kQt1agqppR2VGYrrrBA+kN7wUU4kvx2XwJMqHdDATtraSNgxflcql
         j4GdhJ/M/2MZDeri8cr4cVqJPSVWRlnRcxzJzf2omu70O2KRDReE0U9HzviPGt1ZMFuw
         +Rt/ZLnQXCsA4NZYghI5gBEvTj0Y73nRDnT/iwyAGRu/mBodFwc2ND1WkcDhWcJCJKFK
         mnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758048377; x=1758653177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIfHkkN0KymLLDe2RxUNHtpRmvEkAgg1GpcLf9403Ls=;
        b=Q9o2WNODw8nTLCVjqvfwwvCCQXJVo/2VyOYDRGxyX891HO8jM/4W6D0R6wgFGwNzvQ
         a7+bBU33FXYLNYgN+XaPK+blTYmw5d/sZq5CEzbjvHQ0rJXab0JB3CFuKhk5noQDlsvI
         yv1HpqfWJDgP/8anirMZHxCUwREVxh/uFOL1u3Cb8q4523letRCvrkw142h/kTpiXm6F
         3RRBWwJUgHjfeMJ7ODP+KmyLritIGU0WAI8MWQnlxz811pQnHHU9Eazewd/NX6NAInEL
         gDfMzF4lbQkr7gxKTtSbqsyYtUoTTUh2P+YvHPCJZwRznLOqbE6MZHKs+eww81PNJubf
         JRQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm7TUuNisl+BrhjPIhot8SI7RHb0MATHhI0fT1ulMnVhvhVzd2YjZWi3BZghD2UoZR5Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpxBGmho1keUU8GDkGrI91fHDLhLR1gctUmQ2fBy81Tx48Pp0x
	5IvNdBaULUrP+Rpw2IhzbS7lePqxRAMy+XsxzKa3ZOfTZ1cGHeHK56J7xlRWnYLQPriI+gARAKF
	eQ2kKGEnn+e6J6yRJnftf4RqYSFTAu7s=
X-Gm-Gg: ASbGncv8+clHPciWCQ4EI0RjRBVtczyql4kK3ZFTVYP0wzv/5WaxndlAv17Nll5Uo/R
	sEq6RE8IBy3DEkCWA2o9Ptmy4cTFgraFDtfFdSkeOxhQhvmfy3cvMGu/ezK3NOJ58qyu1mBaaJc
	IbKlGmt8Wp0vkRI9AzAnbEwwe1zifSlqtjTE0x+e5E5WvmPjZWQxVe29AWXGX978poz2yURv734
	2+Ldln4Y6+zWsVNJd4isg==
X-Google-Smtp-Source: AGHT+IG33XVggnQTCWyt+uISmmOdR25xYnNt8+Yi6eqJTmHqOpfm4zbSvcmiDKC06vULGm1Y1ykX5yVSimFu6NJYlIY=
X-Received: by 2002:a05:600c:1552:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-45f314c15d6mr62874075e9.31.1758048376981; Tue, 16 Sep 2025
 11:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916022140.60269-1-alexei.starovoitov@gmail.com>
 <47aca3ca-a65b-4c0b-aaff-3a7bb6e484fe@suse.cz> <aMlZ8Au2MBikJgta@hyeyoo>
 <e7d1c20c-7164-4319-ac7e-9df0072a12ad@suse.cz> <CAADnVQLNm+0ZwX2MN_JK3ookGxpOGxEdwaaroQk+rGB401E8Jg@mail.gmail.com>
 <0beac436-1905-4542-aebe-92074aaea54f@suse.cz>
In-Reply-To: <0beac436-1905-4542-aebe-92074aaea54f@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Sep 2025 11:46:03 -0700
X-Gm-Features: AS18NWCSLewPB96ssRVHAm1hP_pc692yCwKaHpAAYlQc7dk2NoKof6uxKdPFMiU
Message-ID: <CAADnVQJbj3OqS9x6MOmnmHa=69ACVEKa=QX-KVAncyocjCn1AQ@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 11:12=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 9/16/25 18:18, Alexei Starovoitov wrote:
> > On Tue, Sep 16, 2025 at 6:13=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 9/16/25 14:58, Harry Yoo wrote:
> >> > On Tue, Sep 16, 2025 at 12:40:12PM +0200, Vlastimil Babka wrote:
> >> >> On 9/16/25 04:21, Alexei Starovoitov wrote:
> >> >> > From: Alexei Starovoitov <ast@kernel.org>
> >> >> >
> >> >> > Disallow kprobes in ___slab_alloc() to prevent reentrance:
> >> >> > kmalloc() -> ___slab_alloc() -> local_lock_irqsave() ->
> >> >> > kprobe -> bpf -> kmalloc_nolock().
> >> >> >
> >> >> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >> >>
> >> >> I wanted to fold this in "slab: Introduce kmalloc_nolock() and kfre=
e_nolock()."
> >> >> and update comments to explain the NOKPROBE_SYMBOL(___slab_alloc);
> >> >>
> >> >> But now I'm not sure if we still need to invent the lockdep classes=
 for PREEMPT_RT anymore:
> >> >>
> >> >> > /*
> >> >> >  * ___slab_alloc()'s caller is supposed to check if kmem_cache::k=
mem_cache_cpu::lock
> >> >> >  * can be acquired without a deadlock before invoking the functio=
n.
> >> >> >  *
> >> >> >  * Without LOCKDEP we trust the code to be correct. kmalloc_noloc=
k() is
> >> >> >  * using local_lock_is_locked() properly before calling local_loc=
k_cpu_slab(),
> >> >> >  * and kmalloc() is not used in an unsupported context.
> >> >> >  *
> >> >> >  * With LOCKDEP, on PREEMPT_RT lockdep does its checking in local=
_lock_irqsave().
> >> >> >  * On !PREEMPT_RT we use trylock to avoid false positives in NMI,=
 but
> >> >> >  * lockdep_assert() will catch a bug in case:
> >> >> >  * #1
> >> >> >  * kmalloc() -> ___slab_alloc() -> irqsave -> NMI -> bpf -> kmall=
oc_nolock()
> >> >> >  * or
> >> >> >  * #2
> >> >> >  * kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -=
> bpf -> kmalloc_nolock()
> >> >>
> >> >> AFAICS see we now eliminated this possibility.
> >> >
> >> > Right.
> >> >
> >> >> >  * On PREEMPT_RT an invocation is not possible from IRQ-off or pr=
eempt
> >> >> >  * disabled context. The lock will always be acquired and if need=
ed it
> >> >> >  * block and sleep until the lock is available.
> >> >> >  * #1 is possible in !PREEMPT_RT only.
> >> >>
> >> >> Yes because this in kmalloc_nolock_noprof()
> >> >>
> >> >>         if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardir=
q()))
> >> >>                 /* kmalloc_nolock() in PREEMPT_RT is not supported =
from irq */
> >> >>                 return NULL;
> >> >>
> >> >>
> >> >> >  * #2 is possible in both with a twist that irqsave is replaced w=
ith rt_spinlock:
> >> >> >  * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
> >> >> >  *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_loc=
k(kmem_cache_B)
> >> >> And this is no longer possible, so can we just remove these comment=
s and drop
> >> >> "slab: Make slub local_(try)lock more precise for LOCKDEP" now?
> >> >
> >> > Makes sense and sounds good to me.
> >> >
> >> > Also in the commit mesage should be adjusted too:
> >> >> kmalloc_nolock() can be called from any context and can re-enter
> >> >> into ___slab_alloc():
> >> >>  kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
> >> >>     kmalloc_nolock() -> ___slab_alloc(cache_B)
> >> >> or
> >> >>  kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprob=
e -> bpf ->
> >> >>    kmalloc_nolock() -> ___slab_alloc(cache_B)
> >> >
> >> > The lattter path is not possible anymore,
> >> >
> >> >> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when p=
er-cpu
> >> >> rt_spin_lock is locked by current _task_. In this case re-entrance =
into
> >> >> the same kmalloc bucket is unsafe, and kmalloc_nolock() tries a dif=
ferent
> >> >> bucket that is most likely is not locked by the current task.
> >> >> Though it may be locked by a different task it's safe to rt_spin_lo=
ck() and
> >> >> sleep on it.
> >> >
> >> > and this paragraph is no longer valid either?
> >>
> >> Thanks for confirming! Let's see if Alexei agrees or we both missed
> >> something.
> >
> > Not quite.
> > This patch prevents
> > kmalloc() -> ___slab_alloc() -> local_lock_irqsave() ->
> >     kprobe -> bpf
> >
> > to make sure kprobe cannot be inserted in the _middle_ of
> > freelist operations.
> > kprobe/tracepoint outside of freelist is not a concern,
> > and
> > malloc() -> ___slab_alloc() -> local_lock_irqsave() ->
> >    tracepoint -> bpf
> >
> > is still possible. Especially on RT.
>
> Hm I see. I wrongly reasoned as if NOKPROBE_SYMBOL(___slab_alloc) covers =
the
> whole scope of ___slab_alloc() but that's not the case. Thanks for cleari=
n
> that up.

hmm. NOKPROBE_SYMBOL(___slab_alloc) covers the whole function.
It disallows kprobes anywhere within the body,
but it doesn't make it 'notrace', so tracing the first nop5
is still ok.

> > I thought about whether do_slab_free() should be marked as NOKPROBE,
> > but that's not necessary. There is freelist manipulation
> > there under local_lock_cpu_slab(), but it's RT only,
> > and there is no fast path there.
>
> There's __update_cpu_freelist_fast() called from do_slab_free() for !RT?

yes.
do_slab_free() -> USE_LOCKLESS_FAST_PATH -> __update_cpu_freelist_fast.

> >>
> >> >> >  * local_lock_is_locked() prevents the case kmem_cache_A =3D=3D k=
mem_cache_B
> >> >> >  */
> >> >>
> >> >> However, what about the freeing path?
> >> >> Shouldn't we do the same with __slab_free() to prevent fast path me=
ssing up
> >> >> an interrupted slow path?
> >> >
> >> > Hmm right, but we have:
> >> >
> >> > (in_nmi() || !USE_LOCKLESS_FAST_PATH()) && local_lock_is_locked()
> >>
> >> Yes, but like in the alloc case, this doesn't trigger in the
> >> !in_nmi() && !PREEMPT_RT case, i.e. a kprobe handler on !PREEMPT_RT, r=
ight?
> >>
> >> But now I think I see another solution here. Since we're already under
> >> "if (!allow_spin)" we could stick a very ugly goto there to skip the
> >> fastpath if we don't defer_free()?
> >> (apparently declaration under a goto label is a C23 extension)
> >>
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 6e858a6e397c..212c0e3e5007 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -6450,6 +6450,7 @@ static __always_inline void do_slab_free(struct =
kmem_cache *s,
> >>  {
> >>         /* cnt =3D=3D 0 signals that it's called from kfree_nolock() *=
/
> >>         bool allow_spin =3D cnt;
> >> +       __maybe_unused unsigned long flags;
> >>         struct kmem_cache_cpu *c;
> >>         unsigned long tid;
> >>         void **freelist;
> >> @@ -6489,6 +6490,9 @@ static __always_inline void do_slab_free(struct =
kmem_cache *s,
> >>                         return;
> >>                 }
> >>                 cnt =3D 1; /* restore cnt. kfree_nolock() frees one ob=
ject at a time */
> >> +
> >> +               /* prevent a fastpath interrupting a slowpath */
> >> +               goto no_lockless;
> >
> > I'm missing why this is needed.
> >
> > do_slab_free() does:
> >                 if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
> >                     local_lock_is_locked(&s->cpu_slab->lock)) {
> >                         defer_free(s, head); return;
> >
> > It's the same check as in kmalloc_nolock() to avoid invalid:
> > freelist ops -> nmi -> bpf -> __update_cpu_freelist_fast.
> >
> > The big comment in kmalloc_nolock() applies here too.
>
> But with nmi that's variant of #1 of that comment.
>
> Like for ___slab_alloc() we need to prevent #2 with no nmi?
> example on !RT:
>
> kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf ->
> kfree_nolock() -> do_slab_free()
>
> in_nmi() || !USE_LOCKLESS_FAST_PATH()
> false || false, we proceed, no checking of local_lock_is_locked()
>
> if (USE_LOCKLESS_FAST_PATH()) { - true (!RT)
> -> __update_cpu_freelist_fast()
>
> Am I missing something?

It's ok to call __update_cpu_freelist_fast(). It won't break anything.
Because only nmi can make this cpu to be in the middle of freelist update.

