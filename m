Return-Path: <bpf+bounces-79341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BB5D3883A
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 22:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25CE9305383E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 21:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B66B2EBB81;
	Fri, 16 Jan 2026 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqY8K49m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C091F9F70
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598204; cv=none; b=CWxVNwwyTCY2c4tH/sYV2cklggQ8m2729WNXeKsSPFla9fINyeHdVMh24GsT2/srNoJIedJS0kcVq2nx6RpOKK7ybBc0gdbI9UaNJtgaALXGvRltm6FJ+5uszi35IRYvnVJCFE/EeNzVE2qMcZB72XeuqIycXdjaA/K8Xv9p/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598204; c=relaxed/simple;
	bh=MrWUwHktw5H0MIxB1vFgSEiT1Tbr50Qrhx08/GcktXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rcb59WyUhCDyk3jmfFrGl4yCZzhzET1uyYL8TuOVNRr4cZMSyOYzZDEIr7wU4m9KtxN0TwFOlfT2SAotDpa03meCeDiLw4PXd8NCeaZds0r8U698Izt7PPSTtNuPC4Pv6UlkhG3gsCC3SqNzj5O4776jIVJf6lIagruXgpEcbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqY8K49m; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c708702dfso1298599a91.1
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 13:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598202; x=1769203002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNnkiv2IChNQsmuidWAckWPFRLbtBGzJAZWCVCJF3J0=;
        b=MqY8K49mHSNiowOkuHoMLoBfloj/6e0GkpBsOonkwXCPjoOyr961q/w1bSDH4pHK1T
         r+brYvGx81PDbJu7bHOVzxXCVJ6w9ZkDm8+xE6SnPb09a1WTeVgoECqkSEr5rHXO6DK5
         xjp/g61E9ToXaCCpUCgXqyRhzz6rJlF9x/lFEUGU4/XP3siNZmE822hqacOAu3V647v4
         qHpsDbuwl3R5HkyiIMxGkshTHmpKlAJ891rjSosL9yxGqjbT5uOepWOBitusntOYUJmE
         Kgwehafz1UjNgxJm+XAYa8ryG/cLmW087qHGpfrzS6RVWmL/5O5+eL1QSGohoQKcD7ui
         qdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598202; x=1769203002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gNnkiv2IChNQsmuidWAckWPFRLbtBGzJAZWCVCJF3J0=;
        b=icLBa0ELR+jMWfNKydx8C9sqCdkgrKjX0DWwFvJ5xo40mlT4w26BSdMTSII+Y9wfU8
         7GWrQhU5TCnhE68xy4TI/QRv+fedpo4KolDAFP0AqyE5bwz1ZRldtJvS6kUvhNnEE861
         xlhWx8Zw4Pti+QcIc/sg0CqH+qA6FTqA8Syw+gUEWFjSQZ0FQ/WsnQ/sG/9jO+t8RJ/9
         XnqdiJ9epGGyXLumf++w4m0/kMixYm8+riuSerkaw/rZonwpP0W1pQ3FGYPHM2FFoebR
         jz3DR1k0OG+BuiJpQ22MJzIRF9fOBJDaUN9ctN/Y3VMOf+U+8qSaWFTV8Lk+ySp7Z+/A
         yvyQ==
X-Gm-Message-State: AOJu0Yz7So+4O9gbaSDm22jd5WliMjFG8ebWw/rEf//mLWBjUWF13Tya
	whU+Q82UPu26XIKp0VaA6zEAxQMtwMnV7+KJ2V84MXvhs2Dt6vPoERPvB2VAZ91sGExmhra2p9s
	03U6NnO/QrLZLdBduOLDHxoHFpfGGQTQ=
X-Gm-Gg: AY/fxX4MEwKiAkw7mFSzUWJSQ3OD9b6yRRZaqgI/mM1P3M8lvears+FVXoK7B/urVbp
	TPSCdAWHBnwu9XD3+3JCimlQJTwc3jZmnaRNr83xrFio2tU+IVcacpFvQv1BcORIV1MFCT2Sw0D
	PfYRhzrNTR7Jw/SEmSoDEQZRCPE5V5na/UsCr1ISQ3OsFHSuDylPuVwlDXfbbkWz0F5uBuIfu+K
	T0OULk1DuZZjIy7VHpGdtnBgnlt4LmGcubPvCnqDexjul/8phm+Oy3okT9zdyHhlqYf6dbqVXSX
	aXfpuBfhtjA=
X-Received: by 2002:a17:90b:5603:b0:340:2a16:94be with SMTP id
 98e67ed59e1d1-35272ef6716mr3302605a91.4.1768598202432; Fri, 16 Jan 2026
 13:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
 <20260115-timer_nolock-v5-5-15e3aef2703d@meta.com> <CAEf4BzbFdmKzxe_qaNW5iWFXL9b1dKHEw3EbR+g_hHNqd5fhSQ@mail.gmail.com>
 <2fd041f2-fa8d-48c9-8b11-ec99293a7f98@gmail.com>
In-Reply-To: <2fd041f2-fa8d-48c9-8b11-ec99293a7f98@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 13:16:29 -0800
X-Gm-Features: AZwV_QhF9L1VE5PCvA_bQRCG-ufqufNJKD6Jic_rx45lTLIt4hqP6uAh2FikAJQ
Message-ID: <CAEf4BzaGKP3ZbfY2pC5H5Ro1S0t45sp6-p4rFzg0xCuqkndqmA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 05/10] bpf: Enable bpf timer and workqueue use in NMI
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 3:33=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 1/16/26 00:01, Andrii Nakryiko wrote:
> > On Thu, Jan 15, 2026 at 10:29=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Refactor bpf timer and workqueue helpers to allow calling them from NM=
I
> >> context by making all operations lock-free and deferring NMI-unsafe
> >> work to irq_work.
> >>
> >> Previously, bpf_timer_start(), and bpf_wq_start()
> >> could not be called from NMI context because they acquired
> >> bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
> >> patch removes these limitations.
> >>
> >> Key changes:
> >>   * Remove bpf_spin_lock from struct bpf_async_kern. Replace locked
> >>     operations with atomic cmpxchg() for initialization and xchg() for
> >>     cancel and free.
> >>   * Add per-async irq_work to defer NMI-unsafe operations (hrtimer_sta=
rt,
> >>     hrtimer_try_to_cancel, schedule_work) from NMI to softirq context.
> >>   * Use the lock-free seqcount_latch_t to pass operation
> >>     commands (start/cancel/free) along with their parameters
> >>     (nsec, mode) from NMI-safe callers to the irq_work handler.
> >>   * Add reference counting to bpf_async_cb to ensure the object stays
> >>     alive until all scheduled irq_work completes and the timer/work
> >>     callback finishes.
> >>   * Move bpf_prog_put() to RCU callback to handle races between
> >>     set_callback() and cancel_and_free().
> >>   * Refactor __bpf_async_set_callback() getting rid of locks.
> >>     Each iteration acquires a new reference and stores it
> >>     in cb->prog via xchg. The previous value is retrieved and released=
.
> >>     The loop condition checks if both cb->prog and cb->callback_fn mat=
ch
> >>     what we just wrote. If either differs, a concurrent writer overwro=
te
> >>     our value, and we must retry.
> >>     When we retry, our previously-stored prog was already put() by the
> >>     concurrent writer or we put() it after xchg().
> > you already described that in earlier patch, no need to repeat that her=
e, IMO
> >
> >> This enables BPF programs attached to NMI-context hooks (perf
> >> events) to use timers and workqueues for deferred processing.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   kernel/bpf/helpers.c | 335 ++++++++++++++++++++++++++++++++++-------=
----------
> >>   1 file changed, 225 insertions(+), 110 deletions(-)
> >>

[...]

> >>
> >> +/* Decrements bpf_async_cb refcnt, if it becomes 0 schedule cleanup i=
rq_work */
> >> +static void bpf_async_refcnt_dec_cleanup(struct bpf_async_cb *cb)
> >> +{
> >> +       if (!refcount_dec_and_test(&cb->refcnt))
> >> +               return;
> >> +
> >> +       /*
> >> +        * At this point we took the last reference
> >> +        * Try to schedule cleanup, either:
> >> +        *  - Set ref to 1 and succeed irq_work_queue
> >> +        *  - See non-zero refcnt after decrement - other irq_work is =
going to cleanup
> >> +        */
> >> +       do {
> >> +               refcount_set(&cb->refcnt, 1);
> >> +               if (irq_work_queue(&cb->worker))
> >> +                       break;
> >> +       } while (refcount_dec_and_test(&cb->refcnt));
> > I still don't understand why you think this hack is better than just
> > marking cb as "destined for destruction" through one-way flagging that
> > cannot be reset.
> >
> > What you have here is some unconventional partial resurrection scheme.
> > Where cb's refcount dropped to zero, but then we try to temporarily
> > revive it for that CANCEL_AND_FREE cleanup with *our* scheduled
> > irq_work callback (which *maybe* will happen), but meanwhile any BPF
> > program that still has reference to bpf_async_cb (there might be many
> > on different CPUs) can now suddenly succeed with inc_not_zero(cb)
> > again...
> >
> > Why so complicated?.. Refcount is supposed to make things simpler, but
> > you are managing to abuse it here.
> >
> > Let's do this:
> >
> > - make last_seq into u64 (so we can have special value designating
> > "this async is DONE, no more operations"), that value should not
> > overlap with valid latch counter values, use U32MAX + 1, for example.
> >
> > - in __bpf_async_cancel_and_free:
> >    1. cb =3D xchg(async->cb, BPF_PTR_POISON) (see my notes about poison=
ing below)
> >    2. if (cb && cb !=3D BPF_PTR_POISON) xchg(cb->last_seq,
> > WE_ARE_DONE_GAME_OVER =3D U32_MAX + 1)
> >    3. irq_work_queue() (doesn't matter if succeeds, someone will pick
> > up on WE_ARE_DONE_GAME_OVER)
> >
> > - in bpf_async_read_op:
> >      - read cb->last_seq with acquire semantics
> >      - if (seq =3D=3D WE_ARE_DONE_GAME_OVER)
> >          - cmpxchg(seq, WE_ARE_DONE_GAME_OVER, WE_ARE_DONE_GAME_OVER + =
1)
> >              - if we lost, bail, someone else already handled this
> >              - if we won, we are the only ones that will do clean up
> >          - bpf_async_process_op(cb, BPF_ASYNC_CANCEL_AND_FREE, 0, 0);
> > (but see below, I think currently we do too much here)
> >          - done, no more command processing
> >      - if (seq =3D=3D last_seq) -> out, someone got here first (just li=
ke
> > you have right now)
> >      - proceed as before, eventually dec_and_test(cb->refcnt), and if
> > it dropped to zero -> schedule freeing after
> > call_rcu_tasks_trace+call_rcu
> >
> > Let's leave refcount to just preserve the lifetime of cb while being
> > scheduled and processed by irq_work callbacks. And nothing more. And
> > then see comments later on about async->cb poisoning.
> >
> > But we still need to keep in mind that there might be active BPF
> > programs that still have access to this memory. But they won't be able
> > to schedule anything because a) async->cb is poisoned, b) if they
> > happen to already have cb, refcount is at zero, so inc_not_zero fails,
> > c) even if they got refcount, we are at GAME_OVER stage (or beyond
> > it), so whatever command we write will be ignored.
> >
> > And I think we can and should honor usercnt=3D=3D0 handling, just like
> > with task_work.
> >
> > Do I miss something in the above?
> Poisoning thing won't work, because for array maps we can do multiple
> cancel_and_free()/init() cycles for the same value, so right after
> cancel_and_free()
> we should be able to take over the cb pointer with init().

Yeah, and it's not just array maps, hashmaps can reuse same memory for
a different key/value while some BPF program still keeps the pointer
assuming that elevent is it's key's value. So yeah, you are right, we
can't poison, it's just inherent in how element deletion and memory
reuse is done in BPF.

>
> I think there is a small confusion, let me clarify few things:
>
>   - bpf_async_cancel_and_free() is called by the map synchronously, in ca=
se of array map
> we have to make map value available for the reuse immediately
> (that's why detach (xchg(NULL)) and schedule free for the detached cb).
>   - bpf_async_process_op(cb, BPF_ASYNC_CANCEL_AND_FREE, 0, 0) cancels tim=
er and schedules cb freeing,
> after calling it we can't access cb.

Just for others that follow. We chatted w/ Mykyta offline about all
this. One point of confusion was that bpf_async_cancel_and_free() has
to schedule memory freeing (though call_rcu). That's how it works
right now, but that's not how it should work with refcnt and this
whole irq_work workflow. Mykyta will rework this logic such that
bpf_async_cancel_and_free() only schedules cancellation and dropping
of that initial refcnt ("map's refcnt"). And orthogonally to that,
when cb's refcnt drops to zero (no matter who does that last and in
what context), that will trigger *only* RCU-delayed memory freeing. By
that time all the timer cancellation should have happened one way or
another.

>
> So in the above approach, the action you do on winning
> "cmpxchg(seq, WE_ARE_DONE_GAME_OVER, WE_ARE_DONE_GAME_OVER + 1)"
> and
> "dec_and_test(cb->refcnt) dropped to zero"
> is the same -  cancel and free the cb.
>

[...]

> >> +       /* Make sure bpf_async_cb_rcu_free() is not called while here =
*/
> >> +       guard(rcu)();
> >> +
> >> +       cb =3D READ_ONCE(async->cb);
> >> +       if (!cb)
> >> +               return -EINVAL;
> >> +
> >> +       return bpf_async_update_prog_callback(cb, callback_fn, prog);
> > shouldn't we do map->usercnt check after successful
> > bpf_async_update_prog_callback(), and if usercnt dropped to zero, we
> > just basically request cancle_and_free. We do something like that for
> > task_work, no?
> I don't think map->usercnt check is needed here.

We chatted about this as well. Indeed, this is set_callback's usercnt
check, which actually seems redundant either with current
implementation or with the new nmi-compatible one. One way or another
cancel_and_free will put whatever program reference we might still
have set. usercnt check is only necessary in bpf_timer_init(), because
we should not be able to successfully initialize timer after
map->usercnt drops to zero, and with no timer initialized, we can't
set_callback.


> The risks here are:
>   * bpf_prog refcnt leak
>   * UAF for cb
> Both are mitigated by the rcu lock:
>   * bpf_prog refcnt: last refcnt is put() in the rcu callback.
>   * cb is freed in rcu callback.
> So even if cancel_and_free() is called  concurrently and this function
> operate on
> the detached cb, it should be safe, as far as I understand.
> >
> >>   }
> >>

[...]

> >> -static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_as=
ync_kern *async)
> >> +static void __bpf_async_cancel_and_free(struct bpf_async_kern *async)
> >>   {
> >>          struct bpf_async_cb *cb;
> >>
> >> -       /* Performance optimization: read async->cb without lock first=
. */
> >> -       if (!READ_ONCE(async->cb))
> >> -               return NULL;
> >> -
> >> -       __bpf_spin_lock_irqsave(&async->lock);
> >> -       /* re-read it under lock */
> >> -       cb =3D async->cb;
> >> +       cb =3D xchg(&async->cb, NULL);
> > What prevents bpf_timer_init() from recreating async->cb? Should we
> > "poison" this pointer here (i.e., xchg() to BPF_PTR_POISON and handle
> > that in timer_init properly)?
> This is by design, on update element, array map does cancel_and_free()
> and the value should be ready for reuse immediately.

yep, you are right, we shouldn't poison

[...]

> >> +               case BPF_ASYNC_CANCEL_AND_FREE:
> >> +                       bpf_timer_delete(t);
> > make sure bpf_timer_delete() doesn't do anything stupid and
> > unnecessary. It shouldn't free any memory, just cancel timer. Let's
> > analyze whether we need all that queue_work stuff we have there right
> > now. We will be calling this from a well-defined irq_work context, so
> > maybe it's good enough to just perform hrtimer_cancel() directly? In
> > any case we should not do call_rcu(&w->cb.rcu,
> > bpf_async_cb_rcu_free);, that will be done when cb->refcnt drops to
> > zero afterwards.
>
> bpf_timer_delete() does freeing, that's the point of it,
> pure cancel is done on the BPF_ASYNC_CANCEL above.

that was the biggest confusion we clarified, bpf_timer_delete() will
basically be replaced by BPF_ASYNC_CANCEL and that GAME_OVER one-way
transition, plus dropping cb's "map's refcnt", as described above. We
think that entire bpf_timer_delete() complication with work queues can
be just removed because we now have irq_work doing all the work, so
there shouldn't be any waiting (and thus deadlocking) involved.

>
> >
> > Similar points for wq's CANCEL_AND_FREE, it should only ensure
> > workqueue is canceled. There is no point in doing cancel_work_sync(),
> > no one is waiting for irq_work to be done, so just cancel_work()?
> >
> >> +                       break;
> >> +               default:
> >> +                       break;
> >> +               }
> >> +               break;
> >> +       }
> > [...]
>

