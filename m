Return-Path: <bpf+bounces-63610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD5AB08FF1
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0605256806C
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5DB2F85D1;
	Thu, 17 Jul 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICM5/suN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA791EF363;
	Thu, 17 Jul 2025 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764262; cv=none; b=AO1w2OZ5HtZOUSQ1g1APeX9Ix/XLvMNVnNKqlnrmxZh4dfxMe/p7bZeBqcZnTb8AFoJX4MMbeKZ9xFUTpYEmdQdYIcg50ZjgLQxarpg5QE0TEGBPDNSv6wkyBTxqugTYL5aQ7VMG3DfyePdqSZVYs6fx5aWpRUNbGjAjOrkBWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764262; c=relaxed/simple;
	bh=TjJPZjE7LvO6jqYIZfxsmaHsQ8zr8JbRj3GYZAqIXh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBbGYW/vu3cdlABH42JBGFM/a8L4hvTv9z7CiMCMGd2TCvNy0gU6T1WD9TlC+HvIkomTmG3wdY+hs78THUeSlmet8nvjQczuoiacLoNMAEJpXg2lOaFK2CqdGRsEzm+Ux8yQi8//Z9C1zkKnUK0cjJIBG8I46gG3G1hW69aMxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICM5/suN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45555e3317aso6665405e9.3;
        Thu, 17 Jul 2025 07:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752764259; x=1753369059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJgeoNdML9iq51bMxNPeinGnnB+OEInhGxDVHOGA/Qs=;
        b=ICM5/suNws9xUoun8BdR0hfUr8i7wvfPDAqOT5CMpnIUQEuDrKx4E5SGQBRxmXEkHH
         kdTO/DK/sV2QCB/+fuABVvhWTBV2FBdJA+ChuHChfKu1alBcxJ/VU1/Nc+VmwGRvAH3g
         9XyPnA4pcCkJlfW2jp2zDeLKAVyQTDWtbyFqDKOZW9OlCz5KJclT9YFxpieV4LZt4/YU
         UcsALsIXrAXGoffE7z3appohU77Mzb+pbiUVZj/FUDiCHEgnbdylz7SGUmY5NmD9uPGV
         SSTUsdtxB7fg3AI9Y8bvGex/WknPaeJJ1Q12f7E6qrhVzii0n67bDkAZKqkDqhTA3/Fz
         OKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764259; x=1753369059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJgeoNdML9iq51bMxNPeinGnnB+OEInhGxDVHOGA/Qs=;
        b=QVaIY8h2yGDHJQMcPj2LQkCK79lFOYWzIINzIAkbQHQAy2/3x1Vaq6V8BIGZNMRHpS
         qdVGqpKtoG/KYD6VyPtQtlkUjDsfJ5vQuNnyWApCncMkDITh3uQS/1cbMTT4ddA2WQ6+
         Plp23PxHGDCohRf4YAU55D04tQqTfwNfp3cJU36DkPdT1/672bWOy+x21L99xH0GYb8l
         A/PJOqV4+/zeAije4B5mXECPuDZr9eFboW+9wwPDSsIWL8m26JZ2hSv44NtFVFCTWQC6
         vkSw3MRySNLWl5jqCijG7+ykJTGtIHCEfyLt7aE5t0u4LqonSqx1MMCje6bat0QBlOOd
         0bTg==
X-Forwarded-Encrypted: i=1; AJvYcCVpdpDIK8xfhqRBGg5H86bYiHu4U/iC+qoOHzo5maQoMaTIEHmSjVgnGSNCxnCnv29pK4bd@vger.kernel.org, AJvYcCWoDFCRreMBsGZ+Bx+/SwzBAzKzwJUY0cPLKU3Fukly8yB2Rlh4/zzPkJFqGOhuBqwAEkE=@vger.kernel.org, AJvYcCX14rc4t5WzIJ9RhEdEiQSS/mMSx07tSYN0z4Z2s5nC/v1ZI0voY3+bAJj2bk0DbItNUJbgLaxiBK6vxSHeNO1Pv3CQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzCGFejml0D0CfK9w5RYIoEt7lgY4yis7nC5KYai5tRY5VtVBFr
	YD3oztzgJrtHn2/gzOWzsuvThxFTJIOzxlOFX9Cxipt7KN44mWk13EmeWr0PTZAS0Xs1Isy068v
	xkgKE9tmC80htkg1+Vd9xfJiAoBwC43o=
X-Gm-Gg: ASbGncvLzR0MIc89202YN+9sKYLZJbF+9JDivR9/DLT3/cE+yQYRnu/XEkuvIKNDdnu
	KTgAc0OVhOTd5k3I0W0aJcSG1eH+KmGeLr0AKUTgdXp+wBUCnwJ6KWIbYdS1HKoHDX+NtgOixcS
	TApexDITQ0rrEJHLlXbGaV/sAIe0iD+dvHhBUB4WlZj0MOfQfWenIKhwQovIjf+SqDcspWM+n/6
	VjwJs9trbEL+X1My+aWvegCg6YnOjL9Kg==
X-Google-Smtp-Source: AGHT+IFVOPWj5ugE6UY0h+KfdvbEFS7sthBRunlQl5uPPpmwXPciExUEPVS27TcOmmVOb9O1RSZY2960vCa1Erl09Dw=
X-Received: by 2002:a05:600c:4e4a:b0:456:28f4:a576 with SMTP id
 5b1f17b1804b1-4562e391fb0mr70054165e9.27.1752764258422; Thu, 17 Jul 2025
 07:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop> <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop> <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop> <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop> <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop> <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
In-Reply-To: <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Jul 2025 07:57:27 -0700
X-Gm-Features: Ac12FXy5AFevRfwhfAmaQeo4LydVWcXQknsIDwZ-nKzOVg4wL8MqRTNLukqIhwQ
Message-ID: <CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 6:14=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-07-16 18:54, Paul E. McKenney wrote:
> > On Wed, Jul 16, 2025 at 01:35:48PM -0700, Paul E. McKenney wrote:
> >> On Wed, Jul 16, 2025 at 11:09:22AM -0400, Steven Rostedt wrote:
> >>> On Fri, 11 Jul 2025 10:05:26 -0700
> >>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >>>
> >>>> This trace point will invoke rcu_read_unlock{,_notrace}(), which wil=
l
> >>>> note that preemption is disabled.  If rcutree.use_softirq is set and
> >>>> this task is blocking an expedited RCU grace period, it will directl=
y
> >>>> invoke the non-notrace function raise_softirq_irqoff().  Otherwise,
> >>>> it will directly invoke the non-notrace function irq_work_queue_on()=
.
> >>>
> >>> Just to clarify some things; A function annotated by "notrace" simply
> >>> will not have the ftrace hook to that function, but that function may
> >>> very well have tracing triggered inside of it.
> >>>
> >>> Functions with "_notrace" in its name (like preempt_disable_notrace()=
)
> >>> should not have any tracing instrumentation (as Mathieu stated)
> >>> inside of it, so that it can be used in the tracing infrastructure.
> >>>
> >>> raise_softirq_irqoff() has a tracepoint inside of it. If we have the
> >>> tracing infrastructure call that, and we happen to enable that
> >>> tracepoint, we will have:
> >>>
> >>>    raise_softirq_irqoff()
> >>>       trace_softirq_raise()
> >>>         [..]
> >>>           raise_softirq_irqoff()
> >>>              trace_softirq_raise()
> >>>                 [..]
> >>>                   Ad infinitum!
> >>>
> >>> I'm not sure if that's what is being proposed or not, but I just want=
ed
> >>> to make sure everyone is aware of the above.
> >>
> >> OK, I *think* I might actually understand the problem.  Maybe.
> >>
> >> I am sure that the usual suspects will not be shy about correcting any
> >> misapprehensions in the following.  ;-)
> >>
> >> My guess is that some users of real-time Linux would like to use BPF
> >> programs while still getting decent latencies out of their systems.
> >> (Not something I would have predicted, but then again, I was surprised
> >> some years back to see people with a 4096-CPU system complaining about
> >> 200-microsecond latency blows from RCU.)  And the BPF guys (now CCed)
> >> made some changes some years back to support this, perhaps most notabl=
y
> >> replacing some uses of preempt_disable() with migrate_disable().
> >>
> >> Except that the current __DECLARE_TRACE() macro defeats this work
> >> for tracepoints by disabling preemption across the tracepoint call,
> >> which might well be a BPF program.  So we need to do something to
> >> __DECLARE_TRACE() to get the right sort of protection while still leav=
ing
> >> preemption enabled.
> >>
> >> One way of attacking this problem is to use preemptible RCU.  The prob=
lem
> >> with this is that although one could construct a trace-safe version
> >> of rcu_read_unlock(), these would negate some optimizations that Lai
> >> Jiangshan worked so hard to put in place.  Plus those optimizations
> >> also simplified the code quite a bit.  Which is why I was pushing back
> >> so hard, especially given that I did not realize that real-time system=
s
> >> would be running BPF programs concurrently with real-time applications=
.
> >> This meant that I was looking for a functional problem with the curren=
t
> >> disabling of preemption, and not finding it.
> >>
> >> So another way of dealing with this is to use SRCU-fast, which is
> >> like SRCU, but dispenses with the smp_mb() calls and the redundant
> >> read-side array indexing.  Plus it is easy to make _notrace variants
> >> srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace(),
> >> along with the requisite guards.
> >>
> >> Re-introducing SRCU requires reverting most of e53244e2c893 ("tracepoi=
nt:
> >> Remove SRCU protection"), and I have hacked together this and the
> >> prerequisites mentioned in the previous paragraph.
> >>
> >> These are passing ridiculously light testing, but probably have at
> >> least their share of bugs.
> >>
> >> But first, do I actually finally understand the problem?
> >
> > OK, they pass somewhat less ridiculously moderate testing, though I hav=
e
> > not yet hit them over the head with the ftrace selftests.
> >
> > So might as well post them.
> >
> > Thoughts?
>
> Your explanation of the problem context fits my understanding.
>
> Note that I've mostly been pulled into this by Sebastian who wanted
> to understand better the how we could make the tracepoint
> instrumentation work with bpf probes that need to sleep due to
> locking. Hence my original somewhat high-level desiderata.

I still don't understand what problem is being solved.
As current tracepoint code stands there is no issue with it at all
on PREEMPT_RT from bpf pov.
bpf progs that attach to tracepoints are not sleepable.
They don't call rt_spinlock either.
Recognizing tracepoints that can sleep/fault and allow
sleepable bpf progs there is on our to do list,
but afaik it doesn't need any changes to tracepoint infra.
There is no need to replace existing preempt_disable wrappers
with sleepable srcu_fast or anything else.

