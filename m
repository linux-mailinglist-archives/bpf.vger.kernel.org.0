Return-Path: <bpf+bounces-39329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 549AA971F96
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 18:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99009B21F85
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B416D4FF;
	Mon,  9 Sep 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNB3nAvh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321401CF9B;
	Mon,  9 Sep 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900801; cv=none; b=MOctLSOYqtzXEuIhIZclZoMMFyEXon72GVDM31l1uXmjEMnlD7g55NpTwk6PCWUPMJOKrJbA8gFPnNbV42uC+7WCoX7GzEuDKecB9G0P/Lgs/kXQ7i9u4i4K8XL0C9Jrx22vePKv7pvOpXOJYjkXSNkQW6nBzyfyXgncS3F68gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900801; c=relaxed/simple;
	bh=VDkzPRy5I1qvdpxBzls2MbJg4DGVB2pXXMELJsYvbz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9t/mdTWaABn27Bt2OloIOE6PPK0bV0Q0KMQiipmO41amKYhZYFsNzXcOcn0diCB+hhmoTJlxVvGhcwdhszQy7utm9yQftjM9GgR1FA4OSQcmcc+EEd8BXhpjb68Cj7Re/zXPLcQmfFTzteTIvqklxCc8p7SHUIAGO2c9G6A7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNB3nAvh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2068bee21d8so44674485ad.2;
        Mon, 09 Sep 2024 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725900799; x=1726505599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD3R3TULeqIaBp+sjXmxzVl0TysI/9YVQ2rnApbhLBQ=;
        b=BNB3nAvhZTS9no1LA3mN0AzRItCl10MKVmCZRR/Iw+7KDWhni6JcppzZT3yia+zNaF
         lYbmciHwfZZEONG0A8DkeTXLxQ1ij1CDTGs1agEISrCbYIlOKFsFtm8Z88TLGgO5PT1V
         cQomTTxtBb1mmo3CBV2xkRu6oZ5gDqAmeJikw23EGnZHZHRTaGKD1efkX40q+xRMkTuJ
         2RY+IXr/8vdDXILIq6hCsCWi9hZlmGwCMm8ZUgx3T5LbdxBYx6Y/uMBQ5HAsBoJs6XxL
         pcO2IrEPm++PG1qEY6Omg5ba/JAMRPHZl5Ccen8qs64MOrVkDwcAJDcAUrNWh+sG94vk
         UcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725900799; x=1726505599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bD3R3TULeqIaBp+sjXmxzVl0TysI/9YVQ2rnApbhLBQ=;
        b=JUuRGdJoczaQGK6aFF6rZXBjHa0+rJa7i6iydpR9luKjuX7ZDqlX8z1vSSMYv6doav
         nDIj5WiyXDt8qzpVOJ4FiPZay1xDh8twg5bafHhDsyqFzdM6dttsnVESdE11QZyRqCvm
         RqztzsLvDsNXU65lUuJa/jO7rwJOyah0vjM2ki3KzoyFMCcFXdoM5Bpbz7m6L27+f+Gp
         9H5MbwwlHN47gNkH5PyMI9trABvK0qu5upj5a1hpcKahyTzRPlUO/bh08lPkuVYuBpPx
         fGjj2DYyVcUSsd667NLp8zMUWZOCU3ozpKUAW5tMSjjytL/hAWD9Jg9T6qziNsooOCKT
         RlIg==
X-Forwarded-Encrypted: i=1; AJvYcCWTSOgORzX6eJMOtjBU5U/aQ7w0XBkIl0YJNgrsDiSQJcBSmgViU73rsV/YtrLzWO2C1BY=@vger.kernel.org, AJvYcCX+bT58trhjgvOlww11iSRXZ0ruRfUbNV9nQTc+xdzC9DAKMcXemy0uY1/6i0/bD6F0x2mdYXBCZc61fAKSl4LXYEu/@vger.kernel.org, AJvYcCXUHJkx/DyN03mVhGgJrRMHMOhI7baelqCdoeYtCTk37IFbB33MTeIN4SGozMjQnmS2zqKySUSWx5CC+Svx@vger.kernel.org
X-Gm-Message-State: AOJu0YxGy6+jiVsk58IMZzJpBk+RhttHUjt7CHD6RUD54iJAwSyGIoHC
	MVxphlTGFwI9MS79N2cP/HhVFJ+QdpF+9dOxwZv+C7BfbIA07swXROIvfuBXKUsGe2LkhQCcvGc
	dLVTA6vMAYqbrqj0DfsJOnAVYDwI=
X-Google-Smtp-Source: AGHT+IHezHNVuLGQvP4wox92NbugBNGjetEXToolzAiiFJ7VGU1GaqfBQoMyrmvpm9IbKt0igVfg/mrRILd+HX53blA=
X-Received: by 2002:a17:902:ce03:b0:205:6596:9dc7 with SMTP id
 d9443c01a7336-2070c1f3d85mr132482835ad.58.1725900799292; Mon, 09 Sep 2024
 09:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828144153.829582-1-mathieu.desnoyers@efficios.com>
 <20240828144153.829582-4-mathieu.desnoyers@efficios.com> <CAEf4BzZERq7qwf0TWYFaXzE6d+L+Y6UY+ahteikro_eugJGxWw@mail.gmail.com>
 <1f442f99-92cd-41d6-8dd2-1f4780f2e556@efficios.com>
In-Reply-To: <1f442f99-92cd-41d6-8dd2-1f4780f2e556@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 09:53:01 -0700
Message-ID: <CAEf4BzbS0TRN1vPzPtSZj+XN7oVUUwyoxHr5p7igH8X-nhZhGw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] tracing/bpf-trace: Add support for faultable tracepoints
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 8:11=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-09-04 21:21, Andrii Nakryiko wrote:
> > On Wed, Aug 28, 2024 at 7:42=E2=80=AFAM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> In preparation for converting system call enter/exit instrumentation
> >> into faultable tracepoints, make sure that bpf can handle registering =
to
> >> such tracepoints by explicitly disabling preemption within the bpf
> >> tracepoint probes to respect the current expectations within bpf traci=
ng
> >> code.
> >>
> >> This change does not yet allow bpf to take page faults per se within i=
ts
> >> probe, but allows its existing probes to connect to faultable
> >> tracepoints.
> >>
> >> Link: https://lore.kernel.org/lkml/20231002202531.3160-1-mathieu.desno=
yers@efficios.com/
> >> Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
> >> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> >> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >> Cc: Steven Rostedt <rostedt@goodmis.org>
> >> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Alexei Starovoitov <ast@kernel.org>
> >> Cc: Yonghong Song <yhs@fb.com>
> >> Cc: Paul E. McKenney <paulmck@kernel.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> Cc: bpf@vger.kernel.org
> >> Cc: Joel Fernandes <joel@joelfernandes.org>
> >> ---
> >> Changes since v4:
> >> - Use DEFINE_INACTIVE_GUARD.
> >> - Add brackets to multiline 'if' statements.
> >> Changes since v5:
> >> - Rebased on v6.11-rc5.
> >> - Pass the TRACEPOINT_MAY_FAULT flag directly to tracepoint_probe_regi=
ster_prio_flags.
> >> ---
> >>   include/trace/bpf_probe.h | 21 ++++++++++++++++-----
> >>   kernel/trace/bpf_trace.c  |  2 +-
> >>   2 files changed, 17 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> >> index a2ea11cc912e..cc96dd1e7c3d 100644
> >> --- a/include/trace/bpf_probe.h
> >> +++ b/include/trace/bpf_probe.h
> >> @@ -42,16 +42,27 @@
> >>   /* tracepoints with more than 12 arguments will hit build error */
> >>   #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__)=
)(__VA_ARGS__)
> >>
> >> -#define __BPF_DECLARE_TRACE(call, proto, args)                       =
  \
> >> +#define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)             =
  \
> >>   static notrace void                                                 =
   \
> >>   __bpf_trace_##call(void *__data, proto)                             =
           \
> >>   {                                                                   =
   \
> >> -       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U=
64(args));        \
> >> +       DEFINE_INACTIVE_GUARD(preempt_notrace, bpf_trace_guard);      =
  \
> >> +                                                                     =
  \
> >> +       if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                      =
  \
> >> +               might_fault();                                        =
  \
> >> +               activate_guard(preempt_notrace, bpf_trace_guard)();   =
  \
> >> +       }                                                             =
  \
> >> +                                                                     =
  \
> >> +       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U=
64(args)); \
> >>   }
> >>
> >>   #undef DECLARE_EVENT_CLASS
> >>   #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, prin=
t) \
> >> -       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
> >> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0)
> >> +
> >> +#undef DECLARE_EVENT_CLASS_MAY_FAULT
> >> +#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, ass=
ign, print) \
> >> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), TRACEPO=
INT_MAY_FAULT)
> >>
> >>   /*
> >>    * This part is compiled out, it is only here as a build time check
> >> @@ -105,13 +116,13 @@ static inline void bpf_test_buffer_##call(void) =
                          \
> >>
> >>   #undef DECLARE_TRACE
> >>   #define DECLARE_TRACE(call, proto, args)                            =
   \
> >> -       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))        =
  \
> >> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0)     =
  \
> >>          __DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
> >>
> >>   #undef DECLARE_TRACE_WRITABLE
> >>   #define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
> >>          __CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), =
size) \
> >> -       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args)) \
> >> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0) \
> >>          __DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), size)
> >>
> >>   #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> index c77eb80cbd7f..ed07283d505b 100644
> >> --- a/kernel/trace/bpf_trace.c
> >> +++ b/kernel/trace/bpf_trace.c
> >> @@ -2473,7 +2473,7 @@ int bpf_probe_register(struct bpf_raw_event_map =
*btp, struct bpf_raw_tp_link *li
> >>
> >>          return tracepoint_probe_register_prio_flags(tp, (void *)btp->=
bpf_func,
> >>                                                      link, TRACEPOINT_=
DEFAULT_PRIO,
> >> -                                                   TRACEPOINT_MAY_EXI=
ST);
> >> +                                                   TRACEPOINT_MAY_EXI=
ST | (tp->flags & TRACEPOINT_MAY_FAULT));
> >>   }
> >>
> >>   int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_r=
aw_tp_link *link)
> >> --
> >> 2.39.2
> >>
> >>
> >
> > I wonder if it would be better to just do this, instead of that
> > preempt guard. I think we don't strictly need preemption to be
> > disabled, we just need to stay on the same CPU, just like we do that
> > for many other program types.
>
> I'm worried about introducing any kind of subtle synchronization
> change in this series, and moving from preempt-off to migrate-disable
> definitely falls under that umbrella.
>
> I would recommend auditing all uses of this_cpu_*() APIs to make sure
> accesses to per-cpu data structures are using atomics and not just using
> operations that expect use of preempt-off to prevent concurrent threads
> from updating to the per-cpu data concurrently.
>
> So what you are suggesting may be a good idea, but I prefer to leave
> this kind of change to a separate bpf-specific series, and I would
> leave this work to someone who knows more about ebpf than me.
>

Yeah, that's ok. migrate_disable() switch is probably going a bit too
far too fast, but I think we should just add
preempt_disable/preempt_enable inside __bpf_trace_run() instead of
leaving it inside those hard to find and follow tracepoint macros. So
maybe you can just pass a bool into __bpf_trace_run() and do preempt
guard (or explicit disable/enable) there?

> Thanks,
>
> Mathieu
>
> >
> > We'll need some more BPF-specific plumbing to fully support faultable
> > (sleepable) tracepoints, but this should unblock your work, unless I'm
> > missing something. And we can take it from there, once your patches
> > land, to take advantage of faultable tracepoints in the BPF ecosystem.
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index b69a39316c0c..415639b7c7a4 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2302,7 +2302,8 @@ void __bpf_trace_run(struct bpf_raw_tp_link
> > *link, u64 *args)
> >          struct bpf_run_ctx *old_run_ctx;
> >          struct bpf_trace_run_ctx run_ctx;
> >
> > -       cant_sleep();
> > +       migrate_disable();
> > +
> >          if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
> >                  bpf_prog_inc_misses_counter(prog);
> >                  goto out;
> > @@ -2318,6 +2319,8 @@ void __bpf_trace_run(struct bpf_raw_tp_link
> > *link, u64 *args)
> >          bpf_reset_run_ctx(old_run_ctx);
> >   out:
> >          this_cpu_dec(*(prog->active));
> > +
> > +       migrate_enable();
> >   }
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>

