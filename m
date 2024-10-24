Return-Path: <bpf+bounces-42990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D349AD933
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 03:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619CB1C21258
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BD638F83;
	Thu, 24 Oct 2024 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFXG0uzG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789814AA9;
	Thu, 24 Oct 2024 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733306; cv=none; b=UVeow7k83XGXu5ax/egciTZZ9E/nIlRGaybIpMxUyROs1c/eizqiFHGpB79w+WMQRRin07++zZxZFIB9VDk5mhr9bk1Bc2FxItGLJGi1chQldmxBzgqzb9+7cVd7tQVwO21ujHPoSATKCsWlyVcN0GQ4fPS3WP+qNlczAvBsU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733306; c=relaxed/simple;
	bh=e6haSwi0R42ens6XIKU+xyjQY++VsV+G3LOEucacoec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbU8VHTDHHsKfbaeZE3ikMKHomurId4IENgfH4zdLKUYHqRrN9Svsc9fvcXynYKs8VcwBxI4Et2c4K/vxOZCJbTpq8h42/e8Pj1RMxd/FWSwW1nmkXTMS0fS1zWCtYlhwVB6g27Ymk1QUEVc2JjjQE79U6hF3PFSpdkI1f3nXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFXG0uzG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d5689eea8so227535f8f.1;
        Wed, 23 Oct 2024 18:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729733302; x=1730338102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POSYRXIBWhYTrd2+8VrdiDgrrGfdKxZdbhJhHjvmbX0=;
        b=XFXG0uzGEoXzh8XtfP24Le8igfc36yuNpuAwB5h5vobiD+ro5AJnXNrupmwN87Zr5N
         +o61QER20Iw2g3/0d/PBtBS/FMk0StZTOV2J7wej144DpG6Zht0WwZEdI49kwNchG/0e
         iG7vPKbLh9dCrXINauDn7zlHcGz85q7JohFG22irlekF35MXjM7bqd0nQxVjuNzQ2dn+
         BQumzJ19rY/v1RaK3r+BcjIi3vvr5r6llFOG7pQBUTQ93l7r+RQCMVNuThLohpFmq8eX
         SSNC++K4FdEuJsV7PdtZcYwLh6oZqdtvMBVBcIjEti9JefmQ+oS8ve9ljOZFFRMJoxHJ
         iiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729733302; x=1730338102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POSYRXIBWhYTrd2+8VrdiDgrrGfdKxZdbhJhHjvmbX0=;
        b=QN9DHFD548TEaLu8Dtmjz8KV5CUGBDU+94y4bt2QbQ9AFewGZhk4wjEnzhAG1hx607
         /CnlauAL1a3ROmu3o/ApUxAOGsvNDq3c50Wi7qnh6mZbg5ogpn+1mk6bDqV4KgE4lVXB
         YI3AKGFELkQBRcpayNAFsn2t3IxhdBdLU5l6j9ZY356GcLD5Ljsoe7FKgDslQcEYUoBs
         ar+zYKCpVB3rhdQB9XSE0wuscQRd/co/yUeJ6Dpq7V4kgI3qX1HJv6TFxLITrwc08Wm5
         U8BriYLd+y2fZ/C6QS6R9Rcw4KwWIiV/W0iDF4yVQgi0N5atpaKOcbNhqos4AIqKKXCz
         VLiA==
X-Forwarded-Encrypted: i=1; AJvYcCUFWkhQ8wTo/xr/p5xSe/1K3Tsxb804W7xNTo9IJ0Xoiw3Nd0qtI3jQfzJhtLHQed1YW0k=@vger.kernel.org, AJvYcCUnwaQ2hYH8B6d/8+EhrfYNTZ8UfGS75qZOeVE8vJFuk+V8r2nuYnMJuBDPHMbMy1mLfmX3O/pUclISqOX6@vger.kernel.org
X-Gm-Message-State: AOJu0YyjiW8zziD/NQ2DkAPRSVOvUyv8iTkgMQTqrX5w13szr7yH7YLr
	OThka9ZLsBO4vvPgc7XpOGggbac82j7e2zBWvKbJrmJDdyUfzRS/sCachAdqWWvGPRgahvQirSe
	C29FsqgIudi8P4WlInaRlh3WdYKU=
X-Google-Smtp-Source: AGHT+IFfRcjdT+/kuSOJXXRC9OA4fnVxxiXPQgGhQ76YKcilsYfxRGwPyzGhCsqFn5kiGy+XqcNhdN8HmR8gwEjf1Ek=
X-Received: by 2002:a05:6000:124b:b0:37d:485b:b68d with SMTP id
 ffacd0b85a97d-3803ac848c0mr215122f8f.2.1729733302085; Wed, 23 Oct 2024
 18:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
 <20241023145640.1499722-1-jrife@google.com> <CAADnVQJupBceq2DAeChBvdjSG4zOpYsMP7_o7gREVmVCA0PUYQ@mail.gmail.com>
 <7bcea009-b58c-4a00-b7cd-f2fc06b90a02@efficios.com>
In-Reply-To: <7bcea009-b58c-4a00-b7cd-f2fc06b90a02@efficios.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Oct 2024 18:28:10 -0700
Message-ID: <CAADnVQKGJcS3mNc8i+dKjybMu0K7vTDVHmPQNqAtGc3X8hE6Hw@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jordan Rife <jrife@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, 
	Namhyung Kim <namhyung@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, 
	Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:21=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-10-23 11:14, Alexei Starovoitov wrote:
> > On Wed, Oct 23, 2024 at 7:56=E2=80=AFAM Jordan Rife <jrife@google.com> =
wrote:
> >>
> >> Mathieu's patch alone does not seem to be enough to prevent the
> >> use-after-free issue reported by syzbot.
> >>
> >> Link: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@go=
ogle.com/T/#u
> >>
> >> I reran the repro script with his patch applied to my tree and was
> >> still able to get the same KASAN crash to occur.
> >>
> >> In this case, when bpf_link_free is invoked it kicks off three instanc=
es
> >> of call_rcu*.
> >>
> >> bpf_link_free()
> >>    ops->release()
> >>       bpf_raw_tp_link_release()
> >>         bpf_probe_unregister()
> >>           tracepoint_probe_unregister()
> >>             tracepoint_remove_func()
> >>               release_probes()
> >>                 call_rcu()               [1]
> >>    bpf_prog_put()
> >>      __bpf_prog_put()
> >>        bpf_prog_put_deferred()
> >>          __bpf_prog_put_noref()
> >>             call_rcu()                   [2]
> >>    call_rcu()                            [3]
> >>
> >> With Mathieu's patch, [1] is chained with call_rcu_tasks_trace()
> >> making the grace period suffiently long to safely free the probe itsel=
f.
> >> The callback for [2] and [3] may be invoked before the
> >> call_rcu_tasks_trace() grace period has elapsed leading to the link or
> >> program itself being freed while still in use. I was able to prevent
> >> any crashes with the patch below which also chains
> >> call_rcu_tasks_trace() and call_rcu() at [2] and [3].
> >>
> >> ---
> >>   kernel/bpf/syscall.c | 24 ++++++++++--------------
> >>   1 file changed, 10 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 59de664e580d..5290eccb465e 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -2200,6 +2200,14 @@ static void __bpf_prog_put_rcu(struct rcu_head =
*rcu)
> >>          bpf_prog_free(aux->prog);
> >>   }
> >>
> >> +static void __bpf_prog_put_tasks_trace_rcu(struct rcu_head *rcu)
> >> +{
> >> +       if (rcu_trace_implies_rcu_gp())
> >> +               __bpf_prog_put_rcu(rcu);
> >> +       else
> >> +               call_rcu(rcu, __bpf_prog_put_rcu);
> >> +}
> >> +
> >>   static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferre=
d)
> >>   {
> >>          bpf_prog_kallsyms_del_all(prog);
> >> @@ -2212,10 +2220,7 @@ static void __bpf_prog_put_noref(struct bpf_pro=
g *prog, bool deferred)
> >>                  btf_put(prog->aux->attach_btf);
> >>
> >>          if (deferred) {
> >> -               if (prog->sleepable)
> >> -                       call_rcu_tasks_trace(&prog->aux->rcu, __bpf_pr=
og_put_rcu);
> >> -               else
> >> -                       call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
> >> +               call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_t=
asks_trace_rcu);
> >>          } else {
> >>                  __bpf_prog_put_rcu(&prog->aux->rcu);
> >>          }
> >> @@ -2996,24 +3001,15 @@ static void bpf_link_defer_dealloc_mult_rcu_gp=
(struct rcu_head *rcu)
> >>   static void bpf_link_free(struct bpf_link *link)
> >>   {
> >>          const struct bpf_link_ops *ops =3D link->ops;
> >> -       bool sleepable =3D false;
> >>
> >>          bpf_link_free_id(link->id);
> >>          if (link->prog) {
> >> -               sleepable =3D link->prog->sleepable;
> >>                  /* detach BPF program, clean up used resources */
> >>                  ops->release(link);
> >>                  bpf_prog_put(link->prog);
> >>          }
> >>          if (ops->dealloc_deferred) {
> >> -               /* schedule BPF link deallocation; if underlying BPF p=
rogram
> >> -                * is sleepable, we need to first wait for RCU tasks t=
race
> >> -                * sync, then go through "classic" RCU grace period
> >> -                */
> >> -               if (sleepable)
> >> -                       call_rcu_tasks_trace(&link->rcu, bpf_link_defe=
r_dealloc_mult_rcu_gp);
> >> -               else
> >> -                       call_rcu(&link->rcu, bpf_link_defer_dealloc_rc=
u_gp);
> >> +               call_rcu_tasks_trace(&link->rcu, bpf_link_defer_deallo=
c_mult_rcu_gp);
> >
> > This patch is completely wrong.
>
> Actually I suspect Jordan's patch works.

We're not going to penalize all bpf progs for that.
This patch is a non-starter.

> > Looks like Mathieu patch broke bpf program contract somewhere.
>
> My patch series introduced this in the probe:
>
> #define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args)                  \
> static notrace void                                                     \
> __bpf_trace_##call(void *__data, proto)                                 \
> {                                                                       \
>          might_fault();                                                  =
\
>          preempt_disable_notrace();                                      =
\
>          CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64=
(args));        \
>          preempt_enable_notrace();                                       =
\
> }
>
> To ensure we'd call the bpf program from preempt-off context.
>
> > The tracepoint type bpf programs must be called with rcu_read_lock held=
.
>
> Calling the bpf program with preempt off is equivalent. __DO_TRACE() call=
s
> the probes with preempt_disable_notrace() in the normal case.
>
> > Looks like it's not happening anymore.
>
> The issue here is not about the context in which the bpf program runs, th=
at's
> still preempt off. The problem is about expectations that a call_rcu grac=
e period
> is enough to delay reclaim after unregistration of the tracepoint. Now th=
at
> __DO_TRACE() uses rcu_read_lock_trace() to protect RCU dereference, it's =
not
> sufficient anymore, at least for syscall tracepoints.

I don't see how preempt_disable vs preempt_disable_notrace and
preemption in general are relevant here.

The prog dereference needs to happen under rcu_read_lock.

But since you've switched to use rcu_read_lock_trace,
so then this part:
> >> bpf_link_free()
> >>    ops->release()
> >>       bpf_raw_tp_link_release()
> >>         bpf_probe_unregister()
> >>           tracepoint_probe_unregister()
> >>             tracepoint_remove_func()
> >>               release_probes()
> >>                 call_rcu()               [1]

is probably incorrect. It should be call_rcu_tasks_trace ?

and in addition all tracepoints (both sleepable and not)
should deref __data under normal rcu_read_lock() before
passing that pointer into __bpf_trace_##call.
Because that's bpf link and prog are rcu protected.

I don't have patches in front of me, so I'm guessing a bit.
So pls remind me where all these patches are?
What tree/branch are we talking about?

