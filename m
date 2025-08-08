Return-Path: <bpf+bounces-65254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3097DB1E1D7
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 07:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2C1566C98
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 05:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D81E5206;
	Fri,  8 Aug 2025 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tygq6F2H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6D1DDC00;
	Fri,  8 Aug 2025 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632115; cv=none; b=fYJVacXtWaAGSNs0TupZpn8c9t0pOxq8DGH5c3y6ZpwM5zwGdKuI+8WaS+ZIlO3f7+ir7pirFEO5V5G8suQEl5zLoE3eSeB2+CapgUWyySRXJM+LCmejN38MzivRXDjFF81PmPwEMwTB6JTfpFvBeK7CJ1LtESpRRnJxi22hWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632115; c=relaxed/simple;
	bh=BsKMVhW1RwdzzwaPHW+GINN4uXfjMnD9TVxoFvjWWXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTdgQarjExeyLk8XUNPbLjm3+deBjIPdwpJ5Cl9/qgL/DeMseSS2bLezq03cKMM9onnGlwQtL3j92TBRE0eps+O+rr47xBkhFraJP1UslMXRG9V665yPJ53BM9oH0fs4vB2YilMUpUukF5tVUWu8KKouwr/ohRtBGljyH4OfWbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tygq6F2H; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-71a39f93879so29919157b3.0;
        Thu, 07 Aug 2025 22:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754632113; x=1755236913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLqrzlrDfbEKtEKET8ucndG4ByXhyVlHtqjMtTWnHag=;
        b=Tygq6F2H2FSxlwKjTcP9GZhHdLcsZiKSOAJlZQd2le7k7G7uC7ZSPEoGNs+NBFNXNC
         aZKjCNTX2lQTdMzQC5esehOL8/D02au9b8fZDiOfJLsMorjcNEFjAgrqIun56b6dlk7G
         ZcnK2lKqodXKj3pCItCjDfzY8HvKGU1Nj+AKylPLtYQqnaUG30QYZUEUWznHOmli1+CO
         fOk01mdE1ynrwhVUHoDotTn9YCUu3c4YwYeSLa5+1wQ433I2iZNKuh+0QoWolXPw20pN
         tnzHcPF9RywY316CcPOGWZKVtatnNCxxjF0rHDbbgcGTDb1/IWvbvBkSZawre/HkwmLG
         wmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754632113; x=1755236913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLqrzlrDfbEKtEKET8ucndG4ByXhyVlHtqjMtTWnHag=;
        b=hjsYGDYEDmq/9OWHFFF5R6lKMf8ZK2SIDJBKGPSNzFVyO5KSDf8kYPNVZnMpaG8hRr
         WApKkB1um4p0HVFlF++0NbTj83thKUhsNcj5ARfN/abvZdhldHqRJYpfMpBLv9HASUx8
         eZBrDslBapVUwPeMwe3oylKM3UfoESObk9yS/8sY7D8vyGcs95Q3SMTnIiX4mftFnZkL
         SVakQAmDH5398jDR3zlPnxyv82Qj3sEXAzWFkzq1v6tsZW8ZuVgOqRF00mK+cI8hliaD
         wd39R01/r/CFFaFDZA3AiPEDU/luCk6LnVZ2EPcVn9BFuVftxlIC6ITJG8Q0JhEXYVEz
         2l9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtlxePx3xhZ3qLHNGeGsVOvh7y4d5S27QNlRQ6B11BVEiv7JfciRQST7CuElQ/T2qqMHW/MWEfr7tXZUsm@vger.kernel.org, AJvYcCV73VvG83Bjlrvl1Rjz+Qgv5e1vqfA3l8mShwvfFv6lGxC8WJ+SeXPEl+yUZVo/a2tpLTNTIfy2@vger.kernel.org, AJvYcCVoNTLzVhLaIuRSBRGIfAT8WY/6QAObxSE0dBbAAMGzwV27fkCsfWctPCPp0iPHA7VGk80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYmnTBLfda7qPZdpJjbSskYY7XkQjIYR1Q7OJBCVj/sYIVVY6s
	qrFHBgleyRMH3/KvsbLNr9uOTwlxFJMLDhrbdWdug1xDj3G1Q3ZLucYO39zbTIeraTxvb0ZqSqg
	EGKunC1DDUbJJz7Ig8v2bKVYbCxLurbBK1+LlBwbkog==
X-Gm-Gg: ASbGncsmDoWnl3QnOUoISmxi3jwF4ytoZ5mi/2gT0m73+Hb6MPAbeC8691m6m9YgXL7
	fw8vBvZel5X6XLVAWyNjMa8mgKpycndvBxxV8je7Fsf3cijEWNFyNIjVd03FjE3VwOppNzhXfcH
	NntZZDoRNj0wUvLBHiODw5eZu7KSj5Tn3fp5J6js9IGcJV8eJjOpwFXAytJSm2JCtpadlzHG2iA
	LsEmik=
X-Google-Smtp-Source: AGHT+IEj5zs3nnPi143lY/APy71L6pBO8WZRfMTjPDy/s9FFUdV2hEFO6nFNLxqlqM2ZPcfVfD7KsJWF7dONZ8jYgl4=
X-Received: by 2002:a05:690c:7482:b0:71b:6a28:8625 with SMTP id
 00721157ae682-71bdae79826mr88828227b3.4.1754632112419; Thu, 07 Aug 2025
 22:48:32 -0700 (PDT)
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
 <CAADnVQ+XGYp=ORtA730u7WQKqSGGH6R4=9CtYOPP_uHuJrYAkQ@mail.gmail.com>
 <CADxym3YMaz8_YkOidJVbKYAXiFLKp4KvYopR3rJRYkiYJvenWw@mail.gmail.com> <CAADnVQL_tMbi-xh_znjGwvvY1GkMTUm6EvOUU1x7rNPx53eePQ@mail.gmail.com>
In-Reply-To: <CAADnVQL_tMbi-xh_znjGwvvY1GkMTUm6EvOUU1x7rNPx53eePQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 8 Aug 2025 13:48:21 +0800
X-Gm-Features: Ac12FXzHIGJ8Ws_t1eKyFpKJcyamwUGDGfRZi6GT3IcZp0wuDlgQ2aeguNrAJWE
Message-ID: <CADxym3bHLSHY0Q1rPd4i44HVWJAtTKMzRhbb814yZHZQNfQPpw@mail.gmail.com>
Subject: Re: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 8:58=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 6, 2025 at 1:44=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > On Fri, Aug 1, 2025 at 12:15=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jul 28, 2025 at 2:20=E2=80=AFAM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > > > On Thu, Jul 17, 2025 at 6:35=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Jul 16, 2025 at 11:24=E2=80=AFAM Peter Zijlstra <peterz@i=
nfradead.org> wrote:
> > > > > >
> > > > > > On Wed, Jul 16, 2025 at 09:56:11AM -0700, Alexei Starovoitov wr=
ote:
> > > > > >
> > > > > > > Maybe Peter has better ideas ?
> > > > > >
> > > > > > Is it possible to express runqueues::nr_pinned as an alias?
> > > > > >
> > > > > > extern unsigned int __attribute__((alias("runqueues.nr_pinned")=
)) this_nr_pinned;
> > > > > >
> > > > > > And use:
> > > > > >
> > > > > >         __this_cpu_inc(&this_nr_pinned);
> > > > > >
> > > > > >
> > > > > > This syntax doesn't actually seem to work; but can we construct
> > > > > > something like that?
> > > > >
> > > > > Yeah. Iant is right. It's a string and not a pointer dereference.
> > > > > It never worked.
> > > > >
> > > > > Few options:
> > > > >
> > > > > 1.
> > > > >  struct rq {
> > > > > +#ifdef CONFIG_SMP
> > > > > +       unsigned int            nr_pinned;
> > > > > +#endif
> > > > >         /* runqueue lock: */
> > > > >         raw_spinlock_t          __lock;
> > > > >
> > > > > @@ -1271,9 +1274,6 @@ struct rq {
> > > > >         struct cpuidle_state    *idle_state;
> > > > >  #endif
> > > > >
> > > > > -#ifdef CONFIG_SMP
> > > > > -       unsigned int            nr_pinned;
> > > > > -#endif
> > > > >
> > > > > but ugly...
> > > > >
> > > > > 2.
> > > > > static unsigned int nr_pinned_offset __ro_after_init __used;
> > > > > RUNTIME_CONST(nr_pinned_offset, nr_pinned_offset)
> > > > >
> > > > > overkill for what's needed
> > > > >
> > > > > 3.
> > > > > OFFSET(RQ_nr_pinned, rq, nr_pinned);
> > > > > then
> > > > > #include <generated/asm-offsets.h>
> > > > >
> > > > > imo the best.
> > > >
> > > > I had a try. The struct rq is not visible to asm-offsets.c, so we
> > > > can't define it in arch/xx/kernel/asm-offsets.c. Do you mean
> > > > to define a similar rq-offsets.c in kernel/sched/ ? It will be more
> > > > complex than the way 2, and I think the second way 2 is
> > > > easier :/
> > >
> > > 2 maybe easier, but it's an overkill.
> > > I still think asm-offset is cleaner.
> > > arch/xx shouldn't be used, of course, since this nr_pinned should
> > > be generic for all archs.
> > > We can do something similar to drivers/memory/emif-asm-offsets.c
> > > and do that within kernel/sched/.
> > > rq-offsets.c as you said.
> > > It will generate rq-offsets.h in a build dir that can be #include-d.
> > >
> > > I thought about another alternative (as a derivative of 1):
> > > split nr_pinned from 'struct rq' into its own per-cpu variable,
> > > but I don't think that will work, since rq_has_pinned_tasks()
> > > doesn't always operate on this_rq().
> > > So the acceptable choices are realistically 1 and 3 and
> > > rq-offsets.c seems cleaner.
> > > Pls give it another try.
> >
> > Generally speaking, the way 3 works. The only problem is how
> > we handle this_rq(). I introduced following code in
> > include/linux/sched.h:
> >
> > struct rq;
> > DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > #define this_rq_ptr() arch_raw_cpu_ptr(&runqueues)
> >
> > The this_rq_ptr() is used in migrate_enable(). I have to use the
> > arch_raw_cpu_ptr() for it. this_cpu_ptr() can't be used here, as
> > it will fail on this_cpu_ptr -> raw_cpu_ptr -> __verify_pcpu_ptr:
> >
> > #define __verify_pcpu_ptr(ptr)                        \
> > do {                                    \
> >     const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL;    \
> >     (void)__vpp_verify;                        \
> > } while (0)
> >
> > The struct rq is not available here, which makes the typeof((ptr) + 0)
> > fail during compiling. What can we do here?
>
> Interesting.
> The comment says:
>  * + 0 is required in order to convert the pointer type from a
>  * potential array type to a pointer to a single item of the array.
>
> so maybe we can do some macro magic to avoid '+ 0'
> when type is already pointer,
> but for now let's proceed with arch_raw_cpu_ptr().

OK

>
> > According to my testing, the performance of fentry increased from
> > 111M/s to 121M/s with migrate_enable/disable inlined.
>
> Very nice.
>
> > Following is the whole patch:
> > -----------------------------------------------------------------------=
--------------------
> > diff --git a/Kbuild b/Kbuild
> > index f327ca86990c..13324b4bbe23 100644
> > --- a/Kbuild
> > +++ b/Kbuild
> > @@ -34,13 +34,24 @@ arch/$(SRCARCH)/kernel/asm-offsets.s:
> > $(timeconst-file) $(bounds-file)
> >  $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
> >      $(call filechk,offsets,__ASM_OFFSETS_H__)
> >
> > +# Generate rq-offsets.h
> > +
> > +rq-offsets-file :=3D include/generated/rq-offsets.h
> > +
> > +targets +=3D kernel/sched/rq-offsets.s
> > +
> > +kernel/sched/rq-offsets.s: $(offsets-file)
> > +
> > +$(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
> > +    $(call filechk,offsets,__RQ_OFFSETS_H__)
> > +
> >  # Check for missing system calls
> >
> >  quiet_cmd_syscalls =3D CALL    $<
> >        cmd_syscalls =3D $(CONFIG_SHELL) $< $(CC) $(c_flags)
> > $(missing_syscalls_flags)
> >
> >  PHONY +=3D missing-syscalls
> > -missing-syscalls: scripts/checksyscalls.sh $(offsets-file)
> > +missing-syscalls: scripts/checksyscalls.sh $(rq-offsets-file)
> >      $(call cmd,syscalls)
> >
> >  # Check the manual modification of atomic headers
> > diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> > index 1fad1c8a4c76..3a1c08a75c09 100644
> > --- a/include/linux/preempt.h
> > +++ b/include/linux/preempt.h
> > @@ -369,64 +369,6 @@ static inline void preempt_notifier_init(struct
> > preempt_notifier *notifier,
> >
> >  #endif
> >
> > -/*
> > - * Migrate-Disable and why it is undesired.
>
> Keep the comment where it is. It will keep the diff smaller.
> There is really no need to move it.

OK

>
> > - *
> > - * When a preempted task becomes elegible to run under the ideal model=
 (IOW it
>
> but fix the typos.

OK

>
> > - * becomes one of the M highest priority tasks), it might still have t=
o wait
> > - * for the preemptee's migrate_disable() section to complete. Thereby =
suffering
> > - * a reduction in bandwidth in the exact duration of the migrate_disab=
le()
> > - * section.
> > - *
> > - * Per this argument, the change from preempt_disable() to migrate_dis=
able()
> > - * gets us:
> > - *
> > - * - a higher priority tasks gains reduced wake-up latency; with
> > preempt_disable()
> > - *   it would have had to wait for the lower priority task.
> > - *
> > - * - a lower priority tasks; which under preempt_disable() could've in=
stantly
> > - *   migrated away when another CPU becomes available, is now constrai=
ned
> > - *   by the ability to push the higher priority task away, which
> > might itself be
> > - *   in a migrate_disable() section, reducing it's available bandwidth=
.
> > - *
> > - * IOW it trades latency / moves the interference term, but it stays i=
n the
> > - * system, and as long as it remains unbounded, the system is not full=
y
> > - * deterministic.
> > - *
> > - *
> > - * The reason we have it anyway.
> > - *
> > - * PREEMPT_RT breaks a number of assumptions traditionally held. By fo=
rcing a
> > - * number of primitives into becoming preemptible, they would also all=
ow
> > - * migration. This turns out to break a bunch of per-cpu usage. To thi=
s end,
> > - * all these primitives employ migirate_disable() to restore this impl=
icit
> > - * assumption.
> > - *
> > - * This is a 'temporary' work-around at best. The correct solution is =
getting
> > - * rid of the above assumptions and reworking the code to employ expli=
cit
> > - * per-cpu locking or short preempt-disable regions.
> > - *
> > - * The end goal must be to get rid of migrate_disable(), alternatively=
 we need
> > - * a schedulability theory that does not depend on abritrary migration=
.
>
> and this one.

OK

>
> > - *
> > - *
> > - * Notes on the implementation.
> > - *
> > - * The implementation is particularly tricky since existing code patte=
rns
> > - * dictate neither migrate_disable() nor migrate_enable() is allowed t=
o block.
> > - * This means that it cannot use cpus_read_lock() to serialize against=
 hotplug,
> > - * nor can it easily migrate itself into a pending affinity mask chang=
e on
> > - * migrate_enable().
> > - *
> > - *
> > - * Note: even non-work-conserving schedulers like semi-partitioned dep=
ends on
> > - *       migration, so migrate_disable() is not only a problem for
> > - *       work-conserving schedulers.
> > - *
> > - */
> > -extern void migrate_disable(void);
> > -extern void migrate_enable(void);
> > -
> >  /**
> >   * preempt_disable_nested - Disable preemption inside a normally
> > preempt disabled section
> >   *
> > @@ -471,7 +413,6 @@ static __always_inline void preempt_enable_nested(v=
oid)
> >
> >  DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
> >  DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(),
> > preempt_enable_notrace())
> > -DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
>
> hmm. why?

Because we moved migrate_disable and migrate_enable to
include/linux/sched.h, which makes them not available in
include/linux/preempt.h, so we need to move this line to
include/linux/sched.h too.

>
> >  #ifdef CONFIG_PREEMPT_DYNAMIC
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 40d2fa90df42..365ac6d17504 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -48,6 +48,9 @@
> >  #include <linux/uidgid_types.h>
> >  #include <linux/tracepoint-defs.h>
> >  #include <asm/kmap_size.h>
> > +#ifndef COMPILE_OFFSETS
> > +#include <generated/rq-offsets.h>
> > +#endif
> >
> >  /* task_struct member predeclarations (sorted alphabetically): */
> >  struct audit_context;
> > @@ -2299,4 +2302,127 @@ static __always_inline void
> > alloc_tag_restore(struct alloc_tag *tag, struct allo
> >  #define alloc_tag_restore(_tag, _old)        do {} while (0)
> >  #endif
> >
> > +#if defined(CONFIG_SMP) && !defined(COMPILE_OFFSETS)
> > +
> > +extern void __migrate_enable(void);
> > +
> > +struct rq;
> > +DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > +#define this_rq_ptr() arch_raw_cpu_ptr(&runqueues)
> > +
> > +/*
> > + * Migrate-Disable and why it is undesired.
> > + *
> > + * When a preempted task becomes elegible to run under the ideal model=
 (IOW it
> > + * becomes one of the M highest priority tasks), it might still have t=
o wait
> > + * for the preemptee's migrate_disable() section to complete. Thereby =
suffering
> > + * a reduction in bandwidth in the exact duration of the migrate_disab=
le()
> > + * section.
> > + *
> > + * Per this argument, the change from preempt_disable() to migrate_dis=
able()
> > + * gets us:
> > + *
> > + * - a higher priority tasks gains reduced wake-up latency; with
> > preempt_disable()
> > + *   it would have had to wait for the lower priority task.
> > + *
> > + * - a lower priority tasks; which under preempt_disable() could've in=
stantly
> > + *   migrated away when another CPU becomes available, is now constrai=
ned
> > + *   by the ability to push the higher priority task away, which
> > might itself be
> > + *   in a migrate_disable() section, reducing it's available bandwidth=
.
> > + *
> > + * IOW it trades latency / moves the interference term, but it stays i=
n the
> > + * system, and as long as it remains unbounded, the system is not full=
y
> > + * deterministic.
> > + *
> > + *
> > + * The reason we have it anyway.
> > + *
> > + * PREEMPT_RT breaks a number of assumptions traditionally held. By fo=
rcing a
> > + * number of primitives into becoming preemptible, they would also all=
ow
> > + * migration. This turns out to break a bunch of per-cpu usage. To thi=
s end,
> > + * all these primitives employ migirate_disable() to restore this impl=
icit
> > + * assumption.
> > + *
> > + * This is a 'temporary' work-around at best. The correct solution is =
getting
> > + * rid of the above assumptions and reworking the code to employ expli=
cit
> > + * per-cpu locking or short preempt-disable regions.
> > + *
> > + * The end goal must be to get rid of migrate_disable(), alternatively=
 we need
> > + * a schedulability theory that does not depend on abritrary migration=
.
> > + *
> > + *
> > + * Notes on the implementation.
> > + *
> > + * The implementation is particularly tricky since existing code patte=
rns
> > + * dictate neither migrate_disable() nor migrate_enable() is allowed t=
o block.
> > + * This means that it cannot use cpus_read_lock() to serialize against=
 hotplug,
> > + * nor can it easily migrate itself into a pending affinity mask chang=
e on
> > + * migrate_enable().
> > + *
> > + *
> > + * Note: even non-work-conserving schedulers like semi-partitioned dep=
ends on
> > + *       migration, so migrate_disable() is not only a problem for
> > + *       work-conserving schedulers.
> > + *
> > + */
> > +static inline void migrate_enable(void)
> > +{
> > +    struct task_struct *p =3D current;
> > +
> > +#ifdef CONFIG_DEBUG_PREEMPT
> > +    /*
> > +     * Check both overflow from migrate_disable() and superfluous
> > +     * migrate_enable().
> > +     */
> > +    if (WARN_ON_ONCE((s16)p->migration_disabled <=3D 0))
> > +        return;
> > +#endif
> > +
> > +    if (p->migration_disabled > 1) {
> > +        p->migration_disabled--;
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Ensure stop_task runs either before or after this, and that
> > +     * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
> > +     */
> > +    guard(preempt)();
> > +    __migrate_enable();
>
> You're leaving performance on the table.
> In many case bpf is one and only user of migrate_enable/disable
> and it's not nested.
> So this call is likely hot.
> Move 'if (p->cpus_ptr !=3D &p->cpus_mask)' check into .h
> and only keep slow path of __set_cpus_allowed_ptr() in .c

Oops, my mistake, I should do it this way :/

>
> Can probably wrap it with likely() too.
>
> > +    /*
> > +     * Mustn't clear migration_disabled() until cpus_ptr points back a=
t the
> > +     * regular cpus_mask, otherwise things that race (eg.
> > +     * select_fallback_rq) get confused.
> > +     */
> > +    barrier();
> > +    p->migration_disabled =3D 0;
> > +    (*(unsigned int *)((void *)this_rq_ptr() + RQ_nr_pinned))--;
> > +}
> > +
> > +static inline void migrate_disable(void)
> > +{
> > +    struct task_struct *p =3D current;
> > +
> > +    if (p->migration_disabled) {
> > +#ifdef CONFIG_DEBUG_PREEMPT
> > +        /*
> > +         *Warn about overflow half-way through the range.
> > +         */
> > +        WARN_ON_ONCE((s16)p->migration_disabled < 0);
> > +#endif
> > +        p->migration_disabled++;
> > +        return;
> > +    }
> > +
> > +    guard(preempt)();
> > +    (*(unsigned int *)((void *)this_rq_ptr() + RQ_nr_pinned))++;
> > +    p->migration_disabled =3D 1;
> > +}
> > +#else
> > +static inline void migrate_disable(void) { }
> > +static inline void migrate_enable(void) { }
> > +#endif
> > +
> > +DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
> > +
> >  #endif
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 399f03e62508..75d5f145ca60 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23853,8 +23853,7 @@ int bpf_check_attach_target(struct
> > bpf_verifier_log *log,
> >  BTF_SET_START(btf_id_deny)
> >  BTF_ID_UNUSED
> >  #ifdef CONFIG_SMP
> > -BTF_ID(func, migrate_disable)
> > -BTF_ID(func, migrate_enable)
> > +BTF_ID(func, __migrate_enable)
> >  #endif
> >  #if !defined CONFIG_PREEMPT_RCU && !defined CONFIG_TINY_RCU
> >  BTF_ID(func, rcu_read_unlock_strict)
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3ec00d08d46a..b521024c99ed 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -119,6 +119,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_runnin=
g_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
> >
> >  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > +EXPORT_SYMBOL_GPL(runqueues);
>
> why?

Because the runqueues referenced in migrate_enable/migrate_disable
directly, and they can be used in modules, we need to export
the runqueues. Isn't it?

>
> >
> >  #ifdef CONFIG_SCHED_PROXY_EXEC
> >  DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
> > @@ -2375,28 +2376,7 @@ static void migrate_disable_switch(struct rq
> > *rq, struct task_struct *p)
> >      __do_set_cpus_allowed(p, &ac);
> >  }
> >
> > -void migrate_disable(void)
> > -{
> > -    struct task_struct *p =3D current;
> > -
> > -    if (p->migration_disabled) {
> > -#ifdef CONFIG_DEBUG_PREEMPT
> > -        /*
> > -         *Warn about overflow half-way through the range.
> > -         */
> > -        WARN_ON_ONCE((s16)p->migration_disabled < 0);
> > -#endif
> > -        p->migration_disabled++;
> > -        return;
> > -    }
> > -
> > -    guard(preempt)();
> > -    this_rq()->nr_pinned++;
> > -    p->migration_disabled =3D 1;
> > -}
> > -EXPORT_SYMBOL_GPL(migrate_disable);
> > -
> > -void migrate_enable(void)
> > +void __migrate_enable(void)
> >  {
> >      struct task_struct *p =3D current;
> >      struct affinity_context ac =3D {
> > @@ -2404,37 +2384,10 @@ void migrate_enable(void)
> >          .flags     =3D SCA_MIGRATE_ENABLE,
> >      };
> >
> > -#ifdef CONFIG_DEBUG_PREEMPT
> > -    /*
> > -     * Check both overflow from migrate_disable() and superfluous
> > -     * migrate_enable().
> > -     */
> > -    if (WARN_ON_ONCE((s16)p->migration_disabled <=3D 0))
> > -        return;
> > -#endif
> > -
> > -    if (p->migration_disabled > 1) {
> > -        p->migration_disabled--;
> > -        return;
> > -    }
> > -
> > -    /*
> > -     * Ensure stop_task runs either before or after this, and that
> > -     * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
> > -     */
> > -    guard(preempt)();
> >      if (p->cpus_ptr !=3D &p->cpus_mask)
> >          __set_cpus_allowed_ptr(p, &ac);
> > -    /*
> > -     * Mustn't clear migration_disabled() until cpus_ptr points back a=
t the
> > -     * regular cpus_mask, otherwise things that race (eg.
> > -     * select_fallback_rq) get confused.
> > -     */
> > -    barrier();
> > -    p->migration_disabled =3D 0;
> > -    this_rq()->nr_pinned--;
> >  }
> > -EXPORT_SYMBOL_GPL(migrate_enable);
> > +EXPORT_SYMBOL_GPL(__migrate_enable);
> >
> >  static inline bool rq_has_pinned_tasks(struct rq *rq)
> >  {
> > diff --git a/kernel/sched/rq-offsets.c b/kernel/sched/rq-offsets.c
> > new file mode 100644
> > index 000000000000..a23747bbe25b
> > --- /dev/null
> > +++ b/kernel/sched/rq-offsets.c
> > @@ -0,0 +1,12 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define COMPILE_OFFSETS
> > +#include <linux/kbuild.h>
> > +#include <linux/types.h>
> > +#include "sched.h"
> > +
> > +int main(void)
> > +{
> > +    DEFINE(RQ_nr_pinned, offsetof(struct rq, nr_pinned));
>
> This part looks nice and sweet. Not sure what you were concerned about.

The usage of arch_raw_cpu_ptr() looks ugly and there is
no such usage existing, which made me concerned.

>
> Respin it as a proper patch targeting tip tree.
>
> And explain the motivation in commit log with detailed
> 'perf report' before/after along with 111M/s to 121M/s speed up,
>
> I suspect with my other __set_cpus_allowed_ptr() suggestion
> the speed up should be even bigger.

It should be. I'll respin this patch and send it to the tip tree.

Thanks!
Menglong Dong

>
> > +    return 0;
> > +}

