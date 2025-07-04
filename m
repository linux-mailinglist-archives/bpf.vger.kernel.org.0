Return-Path: <bpf+bounces-62435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE3AF9B05
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 21:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4B07B5C9E
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6AA20AF67;
	Fri,  4 Jul 2025 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtpQH3+z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711A3596B
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751656288; cv=none; b=ADhc2tlzib12DDMDfbuSFwR24kWN7Bp+d8kFHlZe9drwJ9ksRPQmdpodbrxoPKC0X+JdAGoxuffbfdUw8o8MPxUZpBo30X5za4kRQgEczf9QmyB6OwaR5zg8/Rb1BE2hqX9Rke/6XU+FW+5UOiZ7Jqvs0EGEi5bHgQkiNl8ud6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751656288; c=relaxed/simple;
	bh=QySVB6sfy2Y4VVjwx0CxzfSS0TCpNAAw9ArkjlCttAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faAV5syWrEEnIwdvODPp7vQD54x8HN+AkcfZFA9FwO62OmPF/OSvL3Mm+PJL6NFT2qXDp/b+U8mPDTjoKW6SogB0Y+SVJbUOCavgJi+EZ6qrcRn1nzK6GOXe1Y+4RKKwK+8CXT92tKF17P4TXLTqc/d859Bvn8DUpvcFhOESq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtpQH3+z; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so249082966b.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 12:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751656284; x=1752261084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NwhVp0p2GKMBsp38ywtqWZ7vwimQGra8CH7R06kbb0M=;
        b=gtpQH3+zpkabrdsmcUxI1fcJ9iCnQaQ6iJ9wJ0ue7JbFTw4zo2476u7tnWvygvBsIg
         Fw8mfaiRB1+cRvF1ard1OlvvpFuqPTu32p2F7rAAfo8qBDHj67Pb7IJdbzlZPH3pWRQ0
         SS/bXeKApkK7+6nUs0zJS7sXKYYksmTZrqbgYTImVy9tug4YG16oLQjpaGX2Kku4/S6A
         gws0tm7HN2TA2WctlhKlm1b26+st6SjwZJCj8JXb0eOQ+49yJNeqhEGg4G10kvqcc4Sh
         PTldWCvjicKy6a2ATXHzCs7nX1hqXst4vVAE51jYYisNuuRpcjlGSNCvDY78jDaTTYRr
         rPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751656284; x=1752261084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwhVp0p2GKMBsp38ywtqWZ7vwimQGra8CH7R06kbb0M=;
        b=B4Kxk7DuC3tuJ5olyad7t7wMAA6qO0wr+bDs/S3DjmPx5ObeHrk+VqJGD6J7UpDwep
         jrNKOLUMrZbKb7LldiepneHo30e59frzr98mFxEhQOfBhMOzPK9qf/I7ucnBgd4fHiLj
         01jfEHdmkjknE5wJkoZNFDYY+y+kiShRwjeFtIujzv3PIi/+/cVMQA8AvSE1PqeSzmzf
         sGSqSRq/eo/ylKXhPvwh4eSlzSZXdJ3Bm9p5JiHJMxHnNhgGUZINuEWU9jBM/eBPuGOQ
         wtkb3Oj7T3EFePAymPdZrA0bYzfxBKIBKyXBMBPWQdXcrgpTUqqgh/DQPG5crkdYJ2Ny
         l5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVbQH0bMGSHNE8lWmhOgPWjeAsVF4niEzurV+i/jg0ZHE7QfLvAymJJQLM5efjaHkOAT5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0acDjOfzy/ATZ+hg3l42fs5/s/vnsoQbXJp5YUJIjkGY13+Mk
	7lHgmpErH1PxUES0NaLTGROLJVEN3jYRZE+0QtvCt+zqjA6TV2prdxvpggbidc5ycVp+AqDwsTd
	yX4qoVeLmJ0B1Ccwh64hEXELqQgV3b1E=
X-Gm-Gg: ASbGncvRXVOR2tGQOFxJg+ebbyl/JzGnvXaIZ83XutMCfaiYsbAipO3A0iC1fTZ8FN4
	OItGRUt+b5GISjD4AWAOghB0PMOk8ox4d39zKUJeOmFLCYBcP45Hghb05/GI50LfYZI5JDeBPoI
	KVH0CyvRSX2Gfm/98KfPrvsbhLWGupuciM5HNslsLKOk/B71vxmS0/+zxWjjlJeXCuBqVjXtCTs
	jg=
X-Google-Smtp-Source: AGHT+IFMV20vs4AW1818cEV7btEaePAEHockigHPlDKXaBv3bm3CPs+GbMpfBJAoI4e+Uq6aZxO1RU3cBwZrnEBk1sA=
X-Received: by 2002:a17:907:2d0e:b0:ae0:e1ed:d1a0 with SMTP id
 a640c23a62f3a-ae3f9c05985mr486300066b.8.1751656283884; Fri, 04 Jul 2025
 12:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
 <20250614064056.237005-4-sidchintamaneni@gmail.com> <CAP01T77TBA3eEVoqGMVTpYsEzvg0f7Q95guH0SDQ3gZK=q+Tag@mail.gmail.com>
 <CAM6KYssFT35L5HN_Fes-2BdhEO6EmhF9Qa+WSWLML4qnZ0z1tA@mail.gmail.com>
In-Reply-To: <CAM6KYssFT35L5HN_Fes-2BdhEO6EmhF9Qa+WSWLML4qnZ0z1tA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 21:10:47 +0200
X-Gm-Features: Ac12FXz5-u8VKNWxJ2O1Rw4WLXy-nfVMwxFPTo91m3-bOwQdNvh0hk3b_J5KuLQ
Message-ID: <CAP01T76S4X4f=owz9D7dXfv15=vD8HB8dO_Ni2TmKfqTKCtuhA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 3/4] bpf: Runtime part of fast-path termination approach
To: Raj Sahu <rjsu26@gmail.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, miloc@vt.edu, 
	ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	jinghao7@illinois.edu, egor@vt.edu, sairoop10@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Jul 2025 at 19:29, Raj Sahu <rjsu26@gmail.com> wrote:
>
> > > Introduces watchdog based runtime mechanism to terminate
> > > a BPF program. When a BPF program is interrupted by
> > > an watchdog, its registers are are passed onto the bpf_die.
> > >
> > > Inside bpf_die we perform the text_poke and stack walk
> > > to stub helpers/kfunc replace bpf_loop helper if called
> > > inside bpf program.
> > >
> > > Current implementation doesn't handle the termination of
> > > tailcall programs.
> > >
> > > There is a known issue by calling text_poke inside interrupt
> > > context - https://elixir.bootlin.com/linux/v6.15.1/source/kernel/smp.c#L815.
> >
> > I don't have a good idea so far, maybe by deferring work to wq context?
> > Each CPU would need its own context and schedule work there.
> > The problem is that it may not be invoked immediately.
> We will give it a try using wq. We were a bit hesitant in pursuing wq
> earlier because to modify the return address on the stack we would
> want to interrupt the running BPF program and access its stack since
> that's a key part of the design.
>
> Will need some suggestions here on how to achieve that.

Yeah, this is not trivial, now that I think more about it.
So keep the stack state untouched so you could synchronize with the
callback (spin until it signals us that it's done touching the stack).
I guess we can do it from another CPU, not too bad.

There's another problem though, wq execution not happening instantly
in time is not a big deal, but it getting interrupted by yet another
program that stalls can set up a cascading chain that leads to lock up
of the machine.
So let's say we have a program that stalls in NMI/IRQ. It might happen
that all CPUs that can service the wq enter this stall. The kthread is
ready to run the wq callback (or in the middle of it) but it may be
indefinitely interrupted.
It seems like this is a more fundamental problem with the non-cloning
approach. We can prevent program execution on the CPU where the wq
callback will be run, but we can also have a case where all CPUs lock
up simultaneously.

So the alternative is to do it locally, such that the program itself
enters the repair path and terminates.
Switching the return address to a patched clone seems much simpler in
comparison, even though it's added memory overhead.

>
> > > +static void bpf_terminate_timer_init(const struct bpf_prog *prog)
> > > +{
> > > +       ktime_t timeout = ktime_set(1, 0); // 1s, 0ns
> > > +
> > > +       /* Initialize timer on Monotonic clock, relative mode */
> > > +       hrtimer_setup(&prog->term_states->hrtimer, bpf_termination_wd_callback, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> >
> > Hmm, doesn't this need to be a per-CPU hrtimer? Otherwise all
> > concurrent invocations will race to set up and start it?
> > Doesn't even look thread safe, unless I'm missing something.
> Yes, this was an oversight. Thanks for pointing it out.
> > > +       /* Start watchdog */
> > > +       hrtimer_start(&prog->term_states->hrtimer, timeout, HRTIMER_MODE_REL);
> > > +}
> > > +
> > > +static void bpf_terminate_timer_cancel(const struct bpf_prog *prog)
> > > +{
> > > +       hrtimer_cancel(&prog->term_states->hrtimer);
> > > +}
> > > +
> > >  static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
> > >                                           const void *ctx,
> > >                                           bpf_dispatcher_fn dfunc)
> > > @@ -706,7 +735,11 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
> > >                 u64 duration, start = sched_clock();
> > >                 unsigned long flags;
> > >
> > > +               update_term_per_cpu_flag(prog, 1);
> > > +               bpf_terminate_timer_init(prog);
> > >                 ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> > > +               bpf_terminate_timer_cancel(prog);
> > > +               update_term_per_cpu_flag(prog, 0);
> > >
> > >                 duration = sched_clock() - start;
> > >                 stats = this_cpu_ptr(prog->stats);
> > > @@ -715,8 +748,11 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
> > >                 u64_stats_add(&stats->nsecs, duration);
> > >                 u64_stats_update_end_irqrestore(&stats->syncp, flags);
> > >         } else {
> > > +               update_term_per_cpu_flag(prog, 1);
> > > +               bpf_terminate_timer_init(prog);
> > >                 ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> > > -       }
> > > +               bpf_terminate_timer_cancel(prog);
> > > +               update_term_per_cpu_flag(prog, 0);}
> > >         return ret;
> > >  }
> >
> > Hmm, did you profile how much overhead this adds? It's not completely
> > free, right?
> > I guess the per_cpu flag's lock is uncontended, so there wouldn't be
> > too much overhead there (though it's still an extra atomic op on the
> > fast path).
> > hrtimer_setup() won't be that expensive either, but I think
> > hrtimer_start() can be.
> > Also, what about programs invoked from BPF trampoline? We would need
> > such "watchdog" protection for potentially every program, right?
> >
> > I'm more concerned about the implications of using an hrtimer around
> > every program invocation though.
> > Imagine that the program gets invoked in task context, the same
> > program then runs in interrupt context (let's say it's a tracing
> > program).
> > Even the simple hrtimer_cancel() when returning from interrupt context
> > can potentially deadlock the kernel if the task context program hit
> > its limit and was inside the timer callback.
> > Let alone the fact that we can have recursion on the same CPU as above
> > or by repeatedly invoking the same program, which reprograms the timer
> > again.
> >
> > I think we should piggy back on softlockup / hardlockup checks (that's
> > what I did long ago), but for simplicity I would just drop these time
> > based enforcement checks from the set for now.
> > They're incomplete, and potentially buggy. Instead you can invoke
> > bpf_die() when a program hits the loop's max count limit or something
> > similar, in order to test this.
> > We also need to account for sleepable programs, so a 1 second
> > hardcoded limit is probably not appropriate.
> > Enforcement is orthogonal to how a program is cleaned up, though as
> > important, but it can be revisited once we sort out the first part.
> ACK
> We can do some profiling eventually then if we decide to bring it back.
> The deadlock case is a good case to consider, however a program's
> recursion is not possible on a given CPU right?

It is possible, we have certain programs which need to recurse to
function correctly.

>
> Earlier we were thinking of enforcing performance based runtime
> policies for BPF programs. Looks like it is getting hard to implement
> it. So I think we will go ahead and rely on the kernel/ bpf mechanism
> to detect bad BPF programs (stalls, pf, etc).
>
> Adding an iteration based termination for bpf_loop won't be enough
> because an expensive callback won't need too many
> iterations,comparatively, to exceed runtime expectations.
>

We can do this as a follow up. As you see from the comments above,
it's already too complicated to think about and review :).

>
> [...]

