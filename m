Return-Path: <bpf+bounces-58142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECFDAB5EB9
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 23:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997171B47287
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 21:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A4F1F4E57;
	Tue, 13 May 2025 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCzkIAbY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3722338
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173339; cv=none; b=StEkUf3RXm/k2R0XGjRM0nRbwc8BNTag2K0UGvhArqc7v1/Tro2bT/wP99OCj9ab08Y7sx/YJHiq2vCVNBGeIZ7GOVsCXzVxZeJEe++tETjyMyUiUuUomktaZNSbay1rsu6Y75nc6UD6UbO0cPSy1QssWLkiiBrPGxYjg5LDsi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173339; c=relaxed/simple;
	bh=7f0xOVkspKButZ6GItrLPRgN2PCi41M8qIZecA1l9gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVd215mV6d8Z2JefY+ylwnqWDruq/mp9AEHqiK8RV5r2MNB4Tmxg7THF2famHVjHSRqWUDW6ufu8pG1a2WdmLNQyJ5F3H8ROjMZr27tgRMiNlR8QTaSyQ1ypQMLFUHMvj5+RbWKuHyVW7c4WI/KDibuxRB9YgJirfbC5FpyKu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCzkIAbY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22e09f57ed4so3112825ad.0
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747173337; x=1747778137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f0rO3WP4XFL6zJ5Hg0f3J54m6c9RExWTkXri/bw1j1s=;
        b=JCzkIAbYRYyQsNQXugwpEjm2uy/cNU/o2lh69YOex/ILNPAN7LK5QbNJDNmuwGrIsG
         57ZXcG2pluVfmlPKXdEr7yt5swvaSduVh+T61kBFamfBBx9Gvz7InFZN2ByW5clzIdlJ
         dT6kOha0esSkKnn8cGohzAw6CftljjqoL6KpCCyxXFtJCLwOgPFnTQjARpHgjjBhklAm
         B/MEP9f5N4AcXVumgXKcuWaOl2oly3vkVwSmGzwp4UGzxyKcY+bDusjwedhJEF55pwx2
         12ZtEJm0u8rmxUqhSgbsdY2mFbAyUJdv5GMFj+JPivQoBj8GoCttxZylcAGNgez3WP2a
         4Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747173337; x=1747778137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0rO3WP4XFL6zJ5Hg0f3J54m6c9RExWTkXri/bw1j1s=;
        b=H1Esh/y4J8B2op0jxmimdd5CNdoSCjwPrPLt8iHAviUFVPxgdn+5FoQrXePL8LbUQv
         SozcoJVEhrbT4ipLU0q9mJXU1NS21t+a9P6P4m1lllFyhsmQQiUnWLjhcHGm5cErElpe
         8DZJXbeyfJq23BE1kiNoCFRWcPeXK9DUnlU2xyXwMwqt0ghc/A+INz9uN8pPcVjoaFsk
         hNQUI/s1jHPzrW9NtL/UFSOlMYEj9KdhOt5AsEqbNY8nV8AcQJmlaTjlGSFTQ8UyEjWE
         qnl+YiFVY/kiMDTNit2K4MZHYYyRgfBBZ/Bg5mwuvhpeN/I+0iSQj7ZITPAx7FIoF95Y
         NQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCWRxgnoKyMtzDEA5KA5hlR6NCoVJhUpno3mGeD6pPnN93yK9hDCVzY63VsINr08N6AXfqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh2KT07twK+SmtYAEk3LgKm1aZym2LPji0vnFc66eWADJqbgnW
	TBAFpL94HI7tEC7kJPIkJuYJO4KSYMFeqUFUMptaOqWkv9YU6vRN
X-Gm-Gg: ASbGnct/WpQWrnKW7XYUM6unZv84wIky9Sj/1SwPsY2tqB4h2ystgWfWAzWR2kB9E50
	bgsafss1oZ1xI1tpg7x/XnnWlTL74AUtbbj1sBgk97UiEY4y5LV9UfMBxktGF4T/oXYSaf4Oqzg
	/RDZf9NqfDBkX49KhRjlww13ISmS4ib7uCrsqdq0Ad5wGz2fhYh60h2QuUxj0Ajtv7Ns1bNZ7N/
	9RplZY2Rol4m/SIPhFYZnqzidMECBUwyZsZ/7cMfk9IIWC8J+1RewoFrEpvN5OW1A/WEfvt7utU
	ZSIQ1MwoqMWnsCg3DVBJEPduPw/cuzT157maYBgmMAH3qtpkHdfYIk7n6tThGdPnptQkjW/3ATA
	T+jQ9byRkLHCp62qBTxaRMDuJYg==
X-Google-Smtp-Source: AGHT+IFslcIkZYaKWYt+R4dr+yTwjrGZc/XIPki7tcYG8vVxVX2d43zhrH9anQuoGgC+ul6/QNwfyw==
X-Received: by 2002:a17:902:ecc6:b0:220:ff82:1c60 with SMTP id d9443c01a7336-2317cb01e62mr75079715ad.14.1747173336509;
        Tue, 13 May 2025 14:55:36 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828c630sm85318685ad.177.2025.05.13.14.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 14:55:36 -0700 (PDT)
Date: Tue, 13 May 2025 14:55:34 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Harry Yoo <harry.yoo@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 4/6] locking/local_lock: Introduce
 local_lock_irqsave_check()
Message-ID: <r2jpdbvckbjm5l237ryesh45zpowhcqmevtp5dbcccmxiwyjzx@t74et4kymzhx>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-5-alexei.starovoitov@gmail.com>
 <20250512140359.CDEasCj3@linutronix.de>
 <CAADnVQLs009ZgcwHfo77zHA_NiGqsBpwvdG1kqc0cW6b02tXXw@mail.gmail.com>
 <737d8993-b3c7-4ed5-8872-20c62ab81572@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <737d8993-b3c7-4ed5-8872-20c62ab81572@suse.cz>

On Tue, May 13, 2025 at 08:58:43AM +0200, Vlastimil Babka wrote:
> On 5/12/25 19:16, Alexei Starovoitov wrote:
> > On Mon, May 12, 2025 at 7:04 AM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> >>
> >> On 2025-04-30 20:27:16 [-0700], Alexei Starovoitov wrote:
> >> > --- a/include/linux/local_lock_internal.h
> >> > +++ b/include/linux/local_lock_internal.h
> >> > @@ -168,6 +168,15 @@ do {                                                             \
> >> >  /* preemption or migration must be disabled before calling __local_lock_is_locked */
> >> >  #define __local_lock_is_locked(lock) READ_ONCE(this_cpu_ptr(lock)->acquired)
> >> >
> >> > +#define __local_lock_irqsave_check(lock, flags)                                      \
> >> > +     do {                                                                    \
> >> > +             if (IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&                      \
> >> > +                 (!__local_lock_is_locked(lock) || in_nmi()))                \
> >> > +                     WARN_ON_ONCE(!__local_trylock_irqsave(lock, flags));    \
> >> > +             else                                                            \
> >> > +                     __local_lock_irqsave(lock, flags);                      \
> >> > +     } while (0)
> >> > +
> >>
> >> Hmm. If I see this right in SLUB then this is called from preemptible
> >> context. Therefore the this_cpu_ptr() from __local_lock_is_locked()
> >> should trigger a warning here.
> > 
> > When preemptible the migration is disabled. So no warning.
> > 
> >> This check variant provides only additional debugging and otherwise
> >> behaves as local_lock_irqsave(). Therefore the in_nmi() should return
> >> immediately with a WARN_ON() regardless if the lock is available or not
> >> because the non-try variant should never be invoked from an NMI.
> > 
> > non-try variant can be invoked from NMI, because the earlier
> > __local_lock_is_locked() check tells us that the lock is not locked.
> > And it's safe to do.
> > And that's the main challenge here.
> > local_lock_irqsave_check() macro fights lockdep here.
> > 
> >> This looks like additional debug infrastructure that should be part of
> >> local_lock_irqsave() itself,
> > 
> > The pattern of
> > 
> > if (!__local_lock_is_locked(lock)) {
> >    .. lots of code..
> >    local_lock_irqsave(lock);
> > 
> > is foreign to lockdep.
> > 
> > Since it can be called from NMI the lockdep just hates it:
> > 
> > [ 1021.956825] inconsistent {INITIAL USE} -> {IN-NMI} usage.
> > ...
> > [ 1021.956888]   lock(per_cpu_ptr(&lock));
> > [ 1021.956890]   <Interrupt>
> > [ 1021.956891]     lock(per_cpu_ptr(&lock));
> > ..
> > 
> > and technically lockdep is correct.
> > For any normal lock it's a deadlock waiting to happen,
> > but not here.
> > 
> > Even without NMI the lockdep doesn't like it:
> > [   14.627331] page_alloc_kthr/1965 is trying to acquire lock:
> > [   14.627331] ffff8881f6ebe0f0 ((local_lock_t
> > *)&c->lock){-.-.}-{3:3}, at: ___slab_alloc+0x9a9/0x1ab0
> > [   14.627331]
> > [   14.627331] but task is already holding lock:
> > [   14.627331] ffff8881f6ebd490 ((local_lock_t
> > *)&c->lock){-.-.}-{3:3}, at: ___slab_alloc+0xc7/0x1ab0
> > [   14.627331]
> > [   14.627331] other info that might help us debug this:
> > [   14.627331]  Possible unsafe locking scenario:
> > [   14.627331]
> > [   14.627331]        CPU0
> > [   14.627331]        ----
> > [   14.627331]   lock((local_lock_t *)&c->lock);
> > [   14.627331]   lock((local_lock_t *)&c->lock);
> > 
> > When slub is holding lock ...bd490 we detect it with
> > __local_lock_is_locked(),
> > then we check that lock ..be0f0 is not locked,
> > and proceed to acquire it, but
> > lockdep will show the above splat.
> > 
> > So local_lock_irqsave_check() is a workaround to avoid
> > these two false positives from lockdep.
> > 
> > Yours and Vlastimil's observation is correct, that ideally
> > local_lock_irqsave() should just handle it,
> > but I don't see how to do it.
> > How can lockdep understand the if (!locked()) lock() pattern ?
> > Such usage is correct only for per-cpu local lock when migration
> > is disabled from check to acquire.
> 
> Thanks, I think I finally understand the issue and why a _check variant is
> necessary. As a general note as this is so tricky, having more details in
> comments and commit messages can't hurt so we can understand it sooner :)
> 
> Again this would be all simpler if we could just use trylock instead of
> _check(), but then we need to handle the fallbacks. And AFAIU on RT trylock
> can fail "spuriously", i.e. when we don't really preempt ourselves, as we
> discussed in that memcg thread.
> 
> > Hence the macro is doing:
> > if (IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&
> >    (!__local_lock_is_locked(lock) || in_nmi()))
> >          WARN_ON_ONCE(!__local_trylock_irqsave(lock, flags));
> > 
> > in_nmi() part is a workaround for the first lockdep splat
> > and __local_lock_is_locked() is a workaround for 2nd lockdep splat,
> > though the code did __local_lock_is_locked() check already.
> 
> So here's where this would be useful to have that info in a comment.
> However, I wonder about it, as the code uses __local_trylock_irqsave(), so
> lockdep should see it as an opportunistic attempt and not splat as that
> trylock alone should be avoiding deadlock - if not we might have a bug in
> the lockdep bits of trylock.

Point taken. The comments need to be more detailed.

I've been thinking of a way to avoid local_lock_irqsave_check() and
came up with the following:

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 94be15d574ad..58ac29f4ba9b 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -79,7 +79,7 @@ do {                                                          \
                                                                \
        debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
        lockdep_init_map_type(&(lock)->dep_map, #lock, &__key,  \
-                             0, LD_WAIT_CONFIG, LD_WAIT_INV,   \
+                             1, LD_WAIT_CONFIG, LD_WAIT_INV,   \
                              LD_LOCK_PERCPU);                  \
        local_lock_debug_init(lock);                            \
 } while (0)
@@ -166,11 +166,21 @@ do {                                                              \
        })

 /* preemption or migration must be disabled before calling __local_lock_is_locked */
-#define __local_lock_is_locked(lock) READ_ONCE(this_cpu_ptr(lock)->acquired)
+#define __local_lock_is_locked(lock)                                   \
+       ({                                                              \
+               bool ret = READ_ONCE(this_cpu_ptr(lock)->acquired);     \
+                                                                       \
+               if (!ret)                                               \
+                       this_cpu_ptr(lock)->dep_map.flags = LOCAL_LOCK_UNLOCKED;\
+               ret; \
+       })
+
+#define __local_lock_flags_clear(lock) \
+       do { this_cpu_ptr(lock)->dep_map.flags = 0; } while (0)

It would need to be wrapped into macroses for !LOCKDEP, of course.

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 9f361d3ab9d9..6c580081ace3 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -190,13 +190,15 @@ struct lockdep_map {
        u8                              wait_type_outer; /* can be taken in this context */
        u8                              wait_type_inner; /* presents this context */
        u8                              lock_type;
-       /* u8                           hole; */
+       u8                              flags;
 #ifdef CONFIG_LOCK_STAT
        int                             cpu;
        unsigned long                   ip;
 #endif
 };

+#define LOCAL_LOCK_UNLOCKED            1

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 58d78a33ac65..0eadee339e1f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4961,6 +4961,7 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
        lock->wait_type_outer = outer;
        lock->wait_type_inner = inner;
        lock->lock_type = lock_type;
+       lock->flags = 0;

        /*
         * No key, no joy, we need to hash something.
@@ -5101,6 +5102,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
                lockevent_inc(lockdep_nocheck);
        }

+       if (unlikely(lock->flags == LOCAL_LOCK_UNLOCKED))
+               subclass++;
+
        if (subclass < NR_LOCKDEP_CACHING_CLASSES)
                class = lock->class_cache[subclass];
        /*


and the usage from slub/memcg looks like this:

if (!!local_lock_is_locked(&s->cpu_slab->lock)) {
        ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);
        __local_lock_flags_clear(&s->cpu_slab->lock);
}

With that all normal local_lock_irqsave() automagically work.

High level the idea is to tell lockdep: "trust me, I know what I'm doing".
Since it's a per-cpu local lock the workaround tells lockdep to treat
such local_lock as nested, so lockdep allows second local_lock
while the same cpu (in !RT) or task (in RT) is holding another local_lock.

It addresses the 2nd false positive above:
[   14.627331]   lock((local_lock_t *)&c->lock);
[   14.627331]   lock((local_lock_t *)&c->lock);

but doesn't address the first false positive of:
[ 1021.956825] inconsistent {INITIAL USE} -> {IN-NMI} usage.

We can silence lockdep for this lock with:
@@ -5839,6 +5840,9 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
         */
        kasan_check_byte(lock);

+       if (unlikely(lock->flags == LOCAL_LOCK_UNLOCKED))
+               trylock = 1;
+
        if (unlikely(!lockdep_enabled())) {

Then all lockdep false positives are gone.
In other words the pair:
  local_lock_is_locked(&local_lock);
  __local_lock_flags_clear(&local_lock);

guards the region where local_lock can be taken multiple
times on that cpu/task from any context including nmi.
We know that the task won't migrate, so multiple lock/unlock
of unlocked lock is safe.

I think this is a lesser evil hack/workaround than local_lock_irqsave_check().
It gives clean start/end scope for such usage of local_lock.

Thoughts?

