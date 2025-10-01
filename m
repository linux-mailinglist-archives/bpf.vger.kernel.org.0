Return-Path: <bpf+bounces-70112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF88BB13B7
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 18:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30BBC4E0F43
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 16:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3356827F749;
	Wed,  1 Oct 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGtgjvuR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4826A0A7
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759335478; cv=none; b=jUV8gSwbcQ13uapuEldNA8vvX2Io/9cQzPDJY7mGIvWji1FnCvwcwnfuGmHdODIYyUWsX/CZnqdQM8csLYkh7OJJExZixRAhNVzHWmgSkcnAp8uFx0D2oTTzJ4e7AZmtPBNNvrNpxtz5/2f25QvWxUEAacpY99GpWzj65BVsY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759335478; c=relaxed/simple;
	bh=q77XO0AdoGK9q2/TqDipGho1zshZHwEISxFv/1C74sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0OzgBTFGpH2S/ilDHGthunqM5pU7M/vOY1TArXorMyN9JpNHJe9ouu5zDST6dFbB1qIzwrYunCVzLSEfZvF/WXpDIudLWTtLdyK6iSz2sL9lKjf8GhFiH6PjJ66z4pyMFRyzK+NVq3Ldn9vkj90I8C4syYdaDpDcLonuHQ7Eg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGtgjvuR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d605c6501so591097b3.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759335476; x=1759940276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oEROZAz2I0OYqkcsNhFOW3jplcG9FHMfFs+GsBTpT3k=;
        b=KGtgjvuRC1Fbiw1Irla2xXM4Df1vEoaSBYIyBpU0TrUc1txL9TsJWW29sYl33ilTHO
         4ugSfWAN49F9nGfNapQ+fLRDsYsaLeaqM0m4feEJ6+FtHmFyP3veU9gq+8tN+0VtKsyQ
         4g5kxI2JYBZAwGSLYRKTiSHSWSTljXbMwwhxChzDWdo6LAZNzaHXnugmFjmMmdEf7DgX
         YGNLFd5S2eoJXmx+GLsJcU2dUZEEqdrq9NDwQ3YYe0n25nTCn1xomx/4zuOApFGDfWL+
         E2z5ayx7pM36BMolK+grqfdtJHe1bSL7T+osLg2vHqvbONNCYcX5FTBcmBs/PN6kRQp7
         U07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759335476; x=1759940276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEROZAz2I0OYqkcsNhFOW3jplcG9FHMfFs+GsBTpT3k=;
        b=JA+oDLDiup2DMpQ51c6xQsrO6ei9TIPTwxIqhmmrr80kHEGPh5L9QFW3mi/zLDykY9
         zZ4iYKh1Wt7LxhfUs6QSW7Jr2wEkr+DxGgasibNE+/8v7+SvhZ1LgwO0tg5HLjgXJjuM
         uL94kMDPKyIJPHgAORJ+BnmqAM8xbhZSZA6O19SlfVYcY0+Iq+p+PZlD1/Qcro9FepvE
         ZQs/cJUaMjqRk6g25bXE2/7MeOhFWWopPj2DqdxDwMZ45mmM8462lWrdOFN70E4LToDh
         zdjMlxcxIIkGh928/9j8vHH3py+jzMS9wkE8jxw78DG4zmudBrDkgLoBi97cFdBy9MmE
         tPcQ==
X-Gm-Message-State: AOJu0YzhCLok6LzRTAbp8ue4Got/5ftueA8pnqkwvNeTDrukTSNVaxRQ
	E5JuQDNweivx2FeQIJZQBMVBLNGB8pr8YhNuvWLo6JwS1WZtXcHmBwEeUslT1MUcLQHaswey/uD
	SOQ3bp4nHfdDCr29rbwRX0B8QRea/wfs=
X-Gm-Gg: ASbGncuWmFNOalCxkTLjsHVwfWMUMsYxfSjuuVE7BczF3Io6qJx+svoiZnLoTS6VPf1
	lqQSKVpfKcADivGZFCSkGC7h+CP3KNKXbbPjXiu5B6WCTsY9CpnkqwhIsrb5PhzIPkwqu67Jrwd
	MNH/o1MC5kKb8Rq8o7pW0DlEdz0zFU4PuH2382vCnd0Fby8UakaZGCkD3U/KmvgkcB8jKFuhVeI
	OZmewWnd8be2pMHB879RMGqYwohdE+/etDywIlQR4n+vGI0DxLBbSvizGxTBqFn
X-Google-Smtp-Source: AGHT+IGjtDMv4sRMFtnkQJDu6BOMll5ytnj5ME9ptwpzBEtiB7/XQSjzXF12+Ks2I5TlMVkBTHwTSEXKcC7A77PbIwo=
X-Received: by 2002:a53:bbc2:0:b0:63b:6290:d132 with SMTP id
 956f58d0204a3-63b6ff85207mr3512488d50.42.1759335475572; Wed, 01 Oct 2025
 09:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930022354.16248-1-sidchintamaneni@gmail.com> <CAP01T74CxRZEXQfySVda0JsQDA1dszB514bOZatG5d0SVmKaZw@mail.gmail.com>
In-Reply-To: <CAP01T74CxRZEXQfySVda0JsQDA1dszB514bOZatG5d0SVmKaZw@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Wed, 1 Oct 2025 09:17:44 -0700
X-Gm-Features: AS18NWDP6ElmCfwZO3ua51Hc0uV5ABqNrtzhR2M1TaYIYnmBXnrk1zqQn-kUoQw
Message-ID: <CAE5sdEjUpdU364B3jYOt8hsfYYSBOPsX-_Y=nRh2a6n6sRne+A@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf: Add deadlock check at the entry of slowpath
 for quick exit
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, rjsu26@gmail.com, 
	miloc@vt.edu, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 08:56, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Tue, 30 Sept 2025 at 04:24, Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> > A single deadlock check at the start of slowpath function
> > enables quick deadlock detection. This additional check don't
> > create any overhead because same check happens in both pending
> > and queuing cases during contention. Also cleaned up the unused
> > function args in check_deadlock* functions.
>
> What's the motivation? Are you trying to address the bug that the
> recent in_nmi() fix tried to work around?
> Note that I'm working on a proper fix; just doing deadlock detection
> on entry into non-head waiter slow path is not sufficient,
> as the table updates for held locks is racy and can populate a
> deadlock-signalling combination right after our check, so it needs to
> happen repeatedly.
>

I've seen the in_nmi() check that you've added to address this issue
for now. The main motivation is to quickly detect the deadlocks if it
is obvious with a single check.

> >
> > I've checked the resilient spinlocks cover letter for benchmarks
> > to run but I couldn't figure out the link to run those benchmarks.
> > Can you point me to those benchmarks so that I can run that with
> > this change?
>
> All benchmark scripts are here: https://github.com/kkdwivedi/rqspinlock
> But they can also be run manually. I ran will-it-scale and locktorture
> back then.
> The description of which locks contend for various cases
> (openN_threads, lockN_threads) is in the CNA paper. [0]
>
>   [0]: https://arxiv.org/pdf/1810.05600
>

Thanks for sharing this is helpful.

> >
> > Fixes: a8fcf2a ("locking: Copy out qspinlock.c to kernel/bpf/rqspinlock.c")
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > ---
> >  kernel/bpf/rqspinlock.c | 45 ++++++++++++++++++++++-------------------
> >  1 file changed, 24 insertions(+), 21 deletions(-)
> >
> > diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> > index a00561b1d3e5..6ec4e97a73a2 100644
> > --- a/kernel/bpf/rqspinlock.c
> > +++ b/kernel/bpf/rqspinlock.c
> > @@ -89,15 +89,14 @@ struct rqspinlock_timeout {
> >  DEFINE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
> >  EXPORT_SYMBOL_GPL(rqspinlock_held_locks);
> >
> > -static bool is_lock_released(rqspinlock_t *lock, u32 mask, struct rqspinlock_timeout *ts)
> > +static bool is_lock_released(rqspinlock_t *lock, u32 mask)
> >  {
> >         if (!(atomic_read_acquire(&lock->val) & (mask)))
> >                 return true;
> >         return false;
> >  }
> >
> > -static noinline int check_deadlock_AA(rqspinlock_t *lock, u32 mask,
> > -                                     struct rqspinlock_timeout *ts)
> > +static noinline int check_deadlock_AA(rqspinlock_t *lock)
> >  {
> >         struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
> >         int cnt = min(RES_NR_HELD, rqh->cnt);
> > @@ -118,8 +117,7 @@ static noinline int check_deadlock_AA(rqspinlock_t *lock, u32 mask,
> >   * more locks, which reduce to ABBA). This is not exhaustive, and we rely on
> >   * timeouts as the final line of defense.
> >   */
> > -static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
> > -                                       struct rqspinlock_timeout *ts)
> > +static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
> >  {
> >         struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
> >         int rqh_cnt = min(RES_NR_HELD, rqh->cnt);
> > @@ -142,7 +140,7 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
> >                  * Let's ensure to break out of this loop if the lock is available for
> >                  * us to potentially acquire.
> >                  */
> > -               if (is_lock_released(lock, mask, ts))
> > +               if (is_lock_released(lock, mask))
> >                         return 0;
> >
> >                 /*
> > @@ -198,15 +196,14 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
> >         return 0;
> >  }
> >
> > -static noinline int check_deadlock(rqspinlock_t *lock, u32 mask,
> > -                                  struct rqspinlock_timeout *ts)
> > +static noinline int check_deadlock(rqspinlock_t *lock, u32 mask)
> >  {
> >         int ret;
> >
> > -       ret = check_deadlock_AA(lock, mask, ts);
> > +       ret = check_deadlock_AA(lock);
> >         if (ret)
> >                 return ret;
> > -       ret = check_deadlock_ABBA(lock, mask, ts);
> > +       ret = check_deadlock_ABBA(lock, mask);
> >         if (ret)
> >                 return ret;
> >
> > @@ -234,7 +231,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
> >          */
> >         if (prev + NSEC_PER_MSEC < time) {
> >                 ts->cur = time;
> > -               return check_deadlock(lock, mask, ts);
> > +               return check_deadlock(lock, mask);
>
> This removal of unused arguments still looks useful, please send it as
> a separate clean up.
>

Will do.

> >         }
> >
> >         return 0;
> > @@ -350,7 +347,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
> >         struct mcs_spinlock *prev, *next, *node;
> >         struct rqspinlock_timeout ts;
> >         int idx, ret = 0;
> > -       u32 old, tail;
> > +       u32 old, tail, mask = _Q_LOCKED_MASK;
> >
> >         BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
> >
> > @@ -359,6 +356,21 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
> >
> >         RES_INIT_TIMEOUT(ts);
> >
> > +       /*
> > +        * Grab an entry in the held locks array, to enable deadlock detection
> > +        */
> > +       grab_held_lock_entry(lock);
> > +
> > +       if (val & _Q_PENDING_VAL)
> > +               mask = _Q_LOCKED_PENDING_MASK;
> > +
> > +       /*
> > +        * Do a deadlock check on the entry of the slowpath
> > +        */
> > +       ret = check_deadlock(lock, mask);
> > +       if (ret)
> > +               goto err_release_entry;
>
> As I explained above, this won't be sufficient. Imagine that there is
> an ABBA case and we have A over B here,
> but B over A hasn't had its A populated in the other CPU's table right
> at this moment. Once you do the checks
> here and conclude there isn't a deadlock, the write can go through,
> and then you'd probably end up in a deadlock again.
>

The idea is not to declare that it is safe after this check because
resilient timeout checks will still happen during pending and queuing
state.

> Regardless, I think in general, it is not a good idea to add more
> overhead to the slow path to detect rare cases such as deadlocks.
> For correct code, they will never occur in practice, so all of this
> quick detection cost is simply overhead that slows everyone down.
> The ABBA checks are pretty expensive on big machines since the
> complexity is O(N).
>

Initially I've just added an AA check but later included ABBA as well
to get your thoughts. I am curious about the overhead.

> If you have time, please review patches that I plan to send improving
> all of this for non-head waiters later on.
> I will add you to the Cc list.
>

Will definitely check, Thanks!

> Thanks
>
> >
> >  [...]
> >

