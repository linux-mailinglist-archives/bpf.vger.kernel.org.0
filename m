Return-Path: <bpf+bounces-65246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F680B1E009
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 02:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7208456694A
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 00:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC920322;
	Fri,  8 Aug 2025 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHcKY62j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EBF8C0B;
	Fri,  8 Aug 2025 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754614717; cv=none; b=fqe3UF79Npd80m31KM6MgSYeRcsgNBfj7py8OyC3QBtwJJ+uHVhXX/YPlHlrfNp6GyypXzc3TkDGwxa65C3BtwooIEW1et+FDBq1w2rGIJyEMMfQjmcnTfR4EUQCXyDRNm8npZgoL96Hu0fyqP+w8z1RnNXj02x6A2jbueYIA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754614717; c=relaxed/simple;
	bh=hBoBAvskSmcjQ67CfLMUbtOWTZ1XEhVuLPw7zBt35TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCzYOKMs6sEmr8w0HRjOX24ikBsOEoUdr83HUKc/hHWxkevw9tRKeW7/zU64H29KvrHEV82Hpv8SkazCxLtuQFN7in65a1y773VDOtF5CBh3RMAa8hOCvYVpdv8m3BD/cirQl1lj8IC3jVoFNnvLnp5h41ijRrI0wYE/UlmYT6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHcKY62j; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b7920354f9so1263989f8f.2;
        Thu, 07 Aug 2025 17:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754614713; x=1755219513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCpcSsvWggCmWV+pjJTm/zGntjd8zqwCYL2HsaYBhno=;
        b=DHcKY62jNEIe1FJV/Hzya+q9Bz0cpitWqG2AULVXqLrpZNZIicq6mTzFKxA17VJqBa
         AhMy0lf2oXG+FWhfDxuD4ByKSkUSJhkh4lUOk4ilsTSKtKDr3GHhGdse/Mn/EMuTwgI5
         pPgFC9iuNu+3IMtcNrN+XoU5y2sjMguU6P4JSmvZFDw3AAWS29q/sDKa6zTsIkD0WeUI
         iEFdu8UbwntJTvEkiRIv1k/Xk/lP0y1s8sjjZ4u/bmx+pEBSNStC85z8r/Tf2qT2ZJrh
         fDTBv7f2weEc8gRHhfovhjeWWKLxVmb4R98yZCZ6LWUJqEtkQFr/1r/O9EXe8P4QUJ+I
         cMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754614713; x=1755219513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCpcSsvWggCmWV+pjJTm/zGntjd8zqwCYL2HsaYBhno=;
        b=cKvqAoK6v++CUUoDxncRi+EGm10toj6pMdkg2iiHBJU5ttLYepYM+L/Pn1Hf+g3ZOU
         VtJNd767ieSNMWhNlkCnXz02u32q0dm0q36yla3FAHa2cMZMWgo5asU7aarvQ41TSZOU
         /d/f61s0t8sRlL2p9nVNlpe5avxyDzZRNZG0fmleWTtfUAyxlBwlWBawJsFB9+S0X8Ys
         YFWOz0F1wm5/St7k7AZKwPwKkzcOSHBevHMmFl3sO1ERR03mbZ7ulPIsCD4kA8qv+S0I
         9/YeBUB6Vpj7s3HiIkarGsi4OBEWQZBELn/O3XgBmkZ1oR4CT5P5fKVBs35qOcd8w1eC
         TUHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTXJ8TJ/eX/3whTwdheYWv5Dcg1+rXPj4IwrVOvjAlaJUPnADzF/17mpU/C0cab5zqmbiwSOTM@vger.kernel.org, AJvYcCVopOpuE1O2uNYHrxYb9SfaX3pq/MsAwBbUxlZaS8drg2mJQOESi1vTyiRHb+EAGfrTbtmnNKJ0E38g5XZL@vger.kernel.org, AJvYcCWEFR2d1/xChG+Bg8bh+A3r/RqcInvITHESk0I5+rzS0IoFkC6yJA9AJQdTkgdygYrsuvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmi0ToIFkxFL9sRzButLD4WmO/0d1c6tTz8cQtisEhgoIuQ1BU
	nnSGmB3StjO44Vc/2XUN8i4lAAQVH78wteqopZNd813vyxAU+JebCqsNrlWLBhZPPu2T/nOL/pp
	P+yER68lr/RxgxaKKZvesRCmmh9Sj/jjdgiOD
X-Gm-Gg: ASbGncsLnm10f+37giXHM2kNg17v1pE6zJo19UzO2AUcuwhBJmmbRH3KBbvHb3BZPjB
	gu0R8PnJXH6X2zKUhxGa1PZfKuaXJp5Pq2lrSthhYeInsmNyA5Ct6Hz08txxnhJKW5YRSxSoNxI
	9SsJ1k2lFEcOlR5EqVocuOQyvN6jHdoc01Ww3G1VukRiYqXdrEWTfuFURdoXD9LEbPNb2DHTql1
	EaUw2cYz+2ndyok/idvLpnJ7YuQQPBELeG/
X-Google-Smtp-Source: AGHT+IHrxht32fXK9zjTFvGZioF3uoozbyWVSC0pQyTVKnFZsb08CGc9ixPPpSY8R6XhNvkt/eSx210uWTpUhIeA0S8=
X-Received: by 2002:a05:6000:25ca:b0:3b8:d32c:773e with SMTP id
 ffacd0b85a97d-3b900b7bd5dmr762647f8f.36.1754614713089; Thu, 07 Aug 2025
 17:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn> <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev> <3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
 <CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com>
 <20250716182414.GI4105545@noisy.programming.kicks-ass.net>
 <CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com>
 <CADxym3Za-zShEUyoVE7OoODKYXc1nghD63q2xv_wtHAyT2-Z-Q@mail.gmail.com>
 <CAADnVQ+XGYp=ORtA730u7WQKqSGGH6R4=9CtYOPP_uHuJrYAkQ@mail.gmail.com> <CADxym3YMaz8_YkOidJVbKYAXiFLKp4KvYopR3rJRYkiYJvenWw@mail.gmail.com>
In-Reply-To: <CADxym3YMaz8_YkOidJVbKYAXiFLKp4KvYopR3rJRYkiYJvenWw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Aug 2025 17:58:21 -0700
X-Gm-Features: Ac12FXy32hbb2uit3ZGIr9bzaMv_Ee2uVawdGVw6gyPjFnVazADyLeC_F7Dr9zo
Message-ID: <CAADnVQL_tMbi-xh_znjGwvvY1GkMTUm6EvOUU1x7rNPx53eePQ@mail.gmail.com>
Subject: Re: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 1:44=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> On Fri, Aug 1, 2025 at 12:15=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jul 28, 2025 at 2:20=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > On Thu, Jul 17, 2025 at 6:35=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Jul 16, 2025 at 11:24=E2=80=AFAM Peter Zijlstra <peterz@inf=
radead.org> wrote:
> > > > >
> > > > > On Wed, Jul 16, 2025 at 09:56:11AM -0700, Alexei Starovoitov wrot=
e:
> > > > >
> > > > > > Maybe Peter has better ideas ?
> > > > >
> > > > > Is it possible to express runqueues::nr_pinned as an alias?
> > > > >
> > > > > extern unsigned int __attribute__((alias("runqueues.nr_pinned")))=
 this_nr_pinned;
> > > > >
> > > > > And use:
> > > > >
> > > > >         __this_cpu_inc(&this_nr_pinned);
> > > > >
> > > > >
> > > > > This syntax doesn't actually seem to work; but can we construct
> > > > > something like that?
> > > >
> > > > Yeah. Iant is right. It's a string and not a pointer dereference.
> > > > It never worked.
> > > >
> > > > Few options:
> > > >
> > > > 1.
> > > >  struct rq {
> > > > +#ifdef CONFIG_SMP
> > > > +       unsigned int            nr_pinned;
> > > > +#endif
> > > >         /* runqueue lock: */
> > > >         raw_spinlock_t          __lock;
> > > >
> > > > @@ -1271,9 +1274,6 @@ struct rq {
> > > >         struct cpuidle_state    *idle_state;
> > > >  #endif
> > > >
> > > > -#ifdef CONFIG_SMP
> > > > -       unsigned int            nr_pinned;
> > > > -#endif
> > > >
> > > > but ugly...
> > > >
> > > > 2.
> > > > static unsigned int nr_pinned_offset __ro_after_init __used;
> > > > RUNTIME_CONST(nr_pinned_offset, nr_pinned_offset)
> > > >
> > > > overkill for what's needed
> > > >
> > > > 3.
> > > > OFFSET(RQ_nr_pinned, rq, nr_pinned);
> > > > then
> > > > #include <generated/asm-offsets.h>
> > > >
> > > > imo the best.
> > >
> > > I had a try. The struct rq is not visible to asm-offsets.c, so we
> > > can't define it in arch/xx/kernel/asm-offsets.c. Do you mean
> > > to define a similar rq-offsets.c in kernel/sched/ ? It will be more
> > > complex than the way 2, and I think the second way 2 is
> > > easier :/
> >
> > 2 maybe easier, but it's an overkill.
> > I still think asm-offset is cleaner.
> > arch/xx shouldn't be used, of course, since this nr_pinned should
> > be generic for all archs.
> > We can do something similar to drivers/memory/emif-asm-offsets.c
> > and do that within kernel/sched/.
> > rq-offsets.c as you said.
> > It will generate rq-offsets.h in a build dir that can be #include-d.
> >
> > I thought about another alternative (as a derivative of 1):
> > split nr_pinned from 'struct rq' into its own per-cpu variable,
> > but I don't think that will work, since rq_has_pinned_tasks()
> > doesn't always operate on this_rq().
> > So the acceptable choices are realistically 1 and 3 and
> > rq-offsets.c seems cleaner.
> > Pls give it another try.
>
> Generally speaking, the way 3 works. The only problem is how
> we handle this_rq(). I introduced following code in
> include/linux/sched.h:
>
> struct rq;
> DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> #define this_rq_ptr() arch_raw_cpu_ptr(&runqueues)
>
> The this_rq_ptr() is used in migrate_enable(). I have to use the
> arch_raw_cpu_ptr() for it. this_cpu_ptr() can't be used here, as
> it will fail on this_cpu_ptr -> raw_cpu_ptr -> __verify_pcpu_ptr:
>
> #define __verify_pcpu_ptr(ptr)                        \
> do {                                    \
>     const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL;    \
>     (void)__vpp_verify;                        \
> } while (0)
>
> The struct rq is not available here, which makes the typeof((ptr) + 0)
> fail during compiling. What can we do here?

Interesting.
The comment says:
 * + 0 is required in order to convert the pointer type from a
 * potential array type to a pointer to a single item of the array.

so maybe we can do some macro magic to avoid '+ 0'
when type is already pointer,
but for now let's proceed with arch_raw_cpu_ptr().

> According to my testing, the performance of fentry increased from
> 111M/s to 121M/s with migrate_enable/disable inlined.

Very nice.

> Following is the whole patch:
> -------------------------------------------------------------------------=
------------------
> diff --git a/Kbuild b/Kbuild
> index f327ca86990c..13324b4bbe23 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -34,13 +34,24 @@ arch/$(SRCARCH)/kernel/asm-offsets.s:
> $(timeconst-file) $(bounds-file)
>  $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
>      $(call filechk,offsets,__ASM_OFFSETS_H__)
>
> +# Generate rq-offsets.h
> +
> +rq-offsets-file :=3D include/generated/rq-offsets.h
> +
> +targets +=3D kernel/sched/rq-offsets.s
> +
> +kernel/sched/rq-offsets.s: $(offsets-file)
> +
> +$(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
> +    $(call filechk,offsets,__RQ_OFFSETS_H__)
> +
>  # Check for missing system calls
>
>  quiet_cmd_syscalls =3D CALL    $<
>        cmd_syscalls =3D $(CONFIG_SHELL) $< $(CC) $(c_flags)
> $(missing_syscalls_flags)
>
>  PHONY +=3D missing-syscalls
> -missing-syscalls: scripts/checksyscalls.sh $(offsets-file)
> +missing-syscalls: scripts/checksyscalls.sh $(rq-offsets-file)
>      $(call cmd,syscalls)
>
>  # Check the manual modification of atomic headers
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 1fad1c8a4c76..3a1c08a75c09 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -369,64 +369,6 @@ static inline void preempt_notifier_init(struct
> preempt_notifier *notifier,
>
>  #endif
>
> -/*
> - * Migrate-Disable and why it is undesired.

Keep the comment where it is. It will keep the diff smaller.
There is really no need to move it.

> - *
> - * When a preempted task becomes elegible to run under the ideal model (=
IOW it

but fix the typos.

> - * becomes one of the M highest priority tasks), it might still have to =
wait
> - * for the preemptee's migrate_disable() section to complete. Thereby su=
ffering
> - * a reduction in bandwidth in the exact duration of the migrate_disable=
()
> - * section.
> - *
> - * Per this argument, the change from preempt_disable() to migrate_disab=
le()
> - * gets us:
> - *
> - * - a higher priority tasks gains reduced wake-up latency; with
> preempt_disable()
> - *   it would have had to wait for the lower priority task.
> - *
> - * - a lower priority tasks; which under preempt_disable() could've inst=
antly
> - *   migrated away when another CPU becomes available, is now constraine=
d
> - *   by the ability to push the higher priority task away, which
> might itself be
> - *   in a migrate_disable() section, reducing it's available bandwidth.
> - *
> - * IOW it trades latency / moves the interference term, but it stays in =
the
> - * system, and as long as it remains unbounded, the system is not fully
> - * deterministic.
> - *
> - *
> - * The reason we have it anyway.
> - *
> - * PREEMPT_RT breaks a number of assumptions traditionally held. By forc=
ing a
> - * number of primitives into becoming preemptible, they would also allow
> - * migration. This turns out to break a bunch of per-cpu usage. To this =
end,
> - * all these primitives employ migirate_disable() to restore this implic=
it
> - * assumption.
> - *
> - * This is a 'temporary' work-around at best. The correct solution is ge=
tting
> - * rid of the above assumptions and reworking the code to employ explici=
t
> - * per-cpu locking or short preempt-disable regions.
> - *
> - * The end goal must be to get rid of migrate_disable(), alternatively w=
e need
> - * a schedulability theory that does not depend on abritrary migration.

and this one.

> - *
> - *
> - * Notes on the implementation.
> - *
> - * The implementation is particularly tricky since existing code pattern=
s
> - * dictate neither migrate_disable() nor migrate_enable() is allowed to =
block.
> - * This means that it cannot use cpus_read_lock() to serialize against h=
otplug,
> - * nor can it easily migrate itself into a pending affinity mask change =
on
> - * migrate_enable().
> - *
> - *
> - * Note: even non-work-conserving schedulers like semi-partitioned depen=
ds on
> - *       migration, so migrate_disable() is not only a problem for
> - *       work-conserving schedulers.
> - *
> - */
> -extern void migrate_disable(void);
> -extern void migrate_enable(void);
> -
>  /**
>   * preempt_disable_nested - Disable preemption inside a normally
> preempt disabled section
>   *
> @@ -471,7 +413,6 @@ static __always_inline void preempt_enable_nested(voi=
d)
>
>  DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
>  DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(),
> preempt_enable_notrace())
> -DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())

hmm. why?

>  #ifdef CONFIG_PREEMPT_DYNAMIC
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 40d2fa90df42..365ac6d17504 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -48,6 +48,9 @@
>  #include <linux/uidgid_types.h>
>  #include <linux/tracepoint-defs.h>
>  #include <asm/kmap_size.h>
> +#ifndef COMPILE_OFFSETS
> +#include <generated/rq-offsets.h>
> +#endif
>
>  /* task_struct member predeclarations (sorted alphabetically): */
>  struct audit_context;
> @@ -2299,4 +2302,127 @@ static __always_inline void
> alloc_tag_restore(struct alloc_tag *tag, struct allo
>  #define alloc_tag_restore(_tag, _old)        do {} while (0)
>  #endif
>
> +#if defined(CONFIG_SMP) && !defined(COMPILE_OFFSETS)
> +
> +extern void __migrate_enable(void);
> +
> +struct rq;
> +DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> +#define this_rq_ptr() arch_raw_cpu_ptr(&runqueues)
> +
> +/*
> + * Migrate-Disable and why it is undesired.
> + *
> + * When a preempted task becomes elegible to run under the ideal model (=
IOW it
> + * becomes one of the M highest priority tasks), it might still have to =
wait
> + * for the preemptee's migrate_disable() section to complete. Thereby su=
ffering
> + * a reduction in bandwidth in the exact duration of the migrate_disable=
()
> + * section.
> + *
> + * Per this argument, the change from preempt_disable() to migrate_disab=
le()
> + * gets us:
> + *
> + * - a higher priority tasks gains reduced wake-up latency; with
> preempt_disable()
> + *   it would have had to wait for the lower priority task.
> + *
> + * - a lower priority tasks; which under preempt_disable() could've inst=
antly
> + *   migrated away when another CPU becomes available, is now constraine=
d
> + *   by the ability to push the higher priority task away, which
> might itself be
> + *   in a migrate_disable() section, reducing it's available bandwidth.
> + *
> + * IOW it trades latency / moves the interference term, but it stays in =
the
> + * system, and as long as it remains unbounded, the system is not fully
> + * deterministic.
> + *
> + *
> + * The reason we have it anyway.
> + *
> + * PREEMPT_RT breaks a number of assumptions traditionally held. By forc=
ing a
> + * number of primitives into becoming preemptible, they would also allow
> + * migration. This turns out to break a bunch of per-cpu usage. To this =
end,
> + * all these primitives employ migirate_disable() to restore this implic=
it
> + * assumption.
> + *
> + * This is a 'temporary' work-around at best. The correct solution is ge=
tting
> + * rid of the above assumptions and reworking the code to employ explici=
t
> + * per-cpu locking or short preempt-disable regions.
> + *
> + * The end goal must be to get rid of migrate_disable(), alternatively w=
e need
> + * a schedulability theory that does not depend on abritrary migration.
> + *
> + *
> + * Notes on the implementation.
> + *
> + * The implementation is particularly tricky since existing code pattern=
s
> + * dictate neither migrate_disable() nor migrate_enable() is allowed to =
block.
> + * This means that it cannot use cpus_read_lock() to serialize against h=
otplug,
> + * nor can it easily migrate itself into a pending affinity mask change =
on
> + * migrate_enable().
> + *
> + *
> + * Note: even non-work-conserving schedulers like semi-partitioned depen=
ds on
> + *       migration, so migrate_disable() is not only a problem for
> + *       work-conserving schedulers.
> + *
> + */
> +static inline void migrate_enable(void)
> +{
> +    struct task_struct *p =3D current;
> +
> +#ifdef CONFIG_DEBUG_PREEMPT
> +    /*
> +     * Check both overflow from migrate_disable() and superfluous
> +     * migrate_enable().
> +     */
> +    if (WARN_ON_ONCE((s16)p->migration_disabled <=3D 0))
> +        return;
> +#endif
> +
> +    if (p->migration_disabled > 1) {
> +        p->migration_disabled--;
> +        return;
> +    }
> +
> +    /*
> +     * Ensure stop_task runs either before or after this, and that
> +     * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
> +     */
> +    guard(preempt)();
> +    __migrate_enable();

You're leaving performance on the table.
In many case bpf is one and only user of migrate_enable/disable
and it's not nested.
So this call is likely hot.
Move 'if (p->cpus_ptr !=3D &p->cpus_mask)' check into .h
and only keep slow path of __set_cpus_allowed_ptr() in .c

Can probably wrap it with likely() too.

> +    /*
> +     * Mustn't clear migration_disabled() until cpus_ptr points back at =
the
> +     * regular cpus_mask, otherwise things that race (eg.
> +     * select_fallback_rq) get confused.
> +     */
> +    barrier();
> +    p->migration_disabled =3D 0;
> +    (*(unsigned int *)((void *)this_rq_ptr() + RQ_nr_pinned))--;
> +}
> +
> +static inline void migrate_disable(void)
> +{
> +    struct task_struct *p =3D current;
> +
> +    if (p->migration_disabled) {
> +#ifdef CONFIG_DEBUG_PREEMPT
> +        /*
> +         *Warn about overflow half-way through the range.
> +         */
> +        WARN_ON_ONCE((s16)p->migration_disabled < 0);
> +#endif
> +        p->migration_disabled++;
> +        return;
> +    }
> +
> +    guard(preempt)();
> +    (*(unsigned int *)((void *)this_rq_ptr() + RQ_nr_pinned))++;
> +    p->migration_disabled =3D 1;
> +}
> +#else
> +static inline void migrate_disable(void) { }
> +static inline void migrate_enable(void) { }
> +#endif
> +
> +DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
> +
>  #endif
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 399f03e62508..75d5f145ca60 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23853,8 +23853,7 @@ int bpf_check_attach_target(struct
> bpf_verifier_log *log,
>  BTF_SET_START(btf_id_deny)
>  BTF_ID_UNUSED
>  #ifdef CONFIG_SMP
> -BTF_ID(func, migrate_disable)
> -BTF_ID(func, migrate_enable)
> +BTF_ID(func, __migrate_enable)
>  #endif
>  #if !defined CONFIG_PREEMPT_RCU && !defined CONFIG_TINY_RCU
>  BTF_ID(func, rcu_read_unlock_strict)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3ec00d08d46a..b521024c99ed 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -119,6 +119,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_=
tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> +EXPORT_SYMBOL_GPL(runqueues);

why?

>
>  #ifdef CONFIG_SCHED_PROXY_EXEC
>  DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
> @@ -2375,28 +2376,7 @@ static void migrate_disable_switch(struct rq
> *rq, struct task_struct *p)
>      __do_set_cpus_allowed(p, &ac);
>  }
>
> -void migrate_disable(void)
> -{
> -    struct task_struct *p =3D current;
> -
> -    if (p->migration_disabled) {
> -#ifdef CONFIG_DEBUG_PREEMPT
> -        /*
> -         *Warn about overflow half-way through the range.
> -         */
> -        WARN_ON_ONCE((s16)p->migration_disabled < 0);
> -#endif
> -        p->migration_disabled++;
> -        return;
> -    }
> -
> -    guard(preempt)();
> -    this_rq()->nr_pinned++;
> -    p->migration_disabled =3D 1;
> -}
> -EXPORT_SYMBOL_GPL(migrate_disable);
> -
> -void migrate_enable(void)
> +void __migrate_enable(void)
>  {
>      struct task_struct *p =3D current;
>      struct affinity_context ac =3D {
> @@ -2404,37 +2384,10 @@ void migrate_enable(void)
>          .flags     =3D SCA_MIGRATE_ENABLE,
>      };
>
> -#ifdef CONFIG_DEBUG_PREEMPT
> -    /*
> -     * Check both overflow from migrate_disable() and superfluous
> -     * migrate_enable().
> -     */
> -    if (WARN_ON_ONCE((s16)p->migration_disabled <=3D 0))
> -        return;
> -#endif
> -
> -    if (p->migration_disabled > 1) {
> -        p->migration_disabled--;
> -        return;
> -    }
> -
> -    /*
> -     * Ensure stop_task runs either before or after this, and that
> -     * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
> -     */
> -    guard(preempt)();
>      if (p->cpus_ptr !=3D &p->cpus_mask)
>          __set_cpus_allowed_ptr(p, &ac);
> -    /*
> -     * Mustn't clear migration_disabled() until cpus_ptr points back at =
the
> -     * regular cpus_mask, otherwise things that race (eg.
> -     * select_fallback_rq) get confused.
> -     */
> -    barrier();
> -    p->migration_disabled =3D 0;
> -    this_rq()->nr_pinned--;
>  }
> -EXPORT_SYMBOL_GPL(migrate_enable);
> +EXPORT_SYMBOL_GPL(__migrate_enable);
>
>  static inline bool rq_has_pinned_tasks(struct rq *rq)
>  {
> diff --git a/kernel/sched/rq-offsets.c b/kernel/sched/rq-offsets.c
> new file mode 100644
> index 000000000000..a23747bbe25b
> --- /dev/null
> +++ b/kernel/sched/rq-offsets.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define COMPILE_OFFSETS
> +#include <linux/kbuild.h>
> +#include <linux/types.h>
> +#include "sched.h"
> +
> +int main(void)
> +{
> +    DEFINE(RQ_nr_pinned, offsetof(struct rq, nr_pinned));

This part looks nice and sweet. Not sure what you were concerned about.

Respin it as a proper patch targeting tip tree.

And explain the motivation in commit log with detailed
'perf report' before/after along with 111M/s to 121M/s speed up,

I suspect with my other __set_cpus_allowed_ptr() suggestion
the speed up should be even bigger.

> +    return 0;
> +}

