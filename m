Return-Path: <bpf+bounces-43187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE59E9B0FAC
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 22:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBDE1C217A9
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE6120F3E3;
	Fri, 25 Oct 2024 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrOBkTgu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8917C9E8;
	Fri, 25 Oct 2024 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887511; cv=none; b=ofmEonSj2wTAJ9F0J9tZDZCqx4Kw03X/h7SqEA5HzeucKKSLa4s4mvlw1ofosx0GBvPTuodQGNMa9fmBqWShVSfvyPXyGKA1eqNrKVJ2kPvX/tOzSevkHVxjC1+m/EwF/Qu73GWpEuHXELnnSoKd8B/Zl93OgkK8jgwnOCuiTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887511; c=relaxed/simple;
	bh=4Sg16lS0vqgYgvdzfHVluoPZh/2tlPzhnGSDoB8ocdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iR8BrbXxyKcDXiV/r/9FcjkANLnQPcDgIUiXD7lv/t2VovWCvhQ0to29ZNpVe9ucLP6aknGUAIhZQW4S1jzLHKyKBylibBydaVU0Iy66zaq9aqoDeZqIJ7p24XekC3sBV46+gSdAF2+eMEu7iW/j3Ueh41ptZhLZ3ePpTfY7wNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrOBkTgu; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7eae96e6624so1658099a12.2;
        Fri, 25 Oct 2024 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729887507; x=1730492307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+nnzXv+7xaoO3Akcee6HVqKTK7vrEnFw5QnwzvcwYA=;
        b=hrOBkTgugaI4CyS1tEFqT9WAPctLEYM+AQ7Bi5crDqvHYSuNWWnAWEIK359h+mqJ5x
         bj4uqQH6CJK8BCuWHpGX0FV76BDVfrf7FDtJLJvsah3kk/0g4t+ItYhQqdDg11dEyger
         8RhK5LGbHcrVco8tHfyRxIe/HsahtCo5ieI1MItqp+ifnGGb3tXL3/GN5zu8xHyUa1IL
         /8seFLTI10yh0Xf+nFaIyb6Mj+RS4Zw+hkvhZcGGWHC3aaKPF5xFcrM8OuqeLJu658De
         ZtYCQAucW858KYsX6dj/zRNXZ1wyZyX3yA7jjEXSOX1ioK8VDR9S3WZs8szRYNDYJYjd
         028w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729887507; x=1730492307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+nnzXv+7xaoO3Akcee6HVqKTK7vrEnFw5QnwzvcwYA=;
        b=VsGQJEnyaDuTTdIMPGj8dzvG03EgofFT3A2NvqM7KGoi0XunmLkBxscJRX27BifPKG
         2TdD5LCt1xBC1YJrenFFIipPZvrRD8C9HIi23AZ/x8DK+OUhBqv8PqOwREKVCn6EWvcp
         WvkEwaO17SRi9A3RQHmLCAoWgTryFFYkp1PWA1uoWghDypn8goayGtbeTe4DELeVqzIB
         +HyBKYloTc8Ibsyap0PdVC6pMQm1mJ0YZbxfpaEHsT9HLYHoRgD71SfRGfmdYxES08d8
         KwRQ1fL3GTPpV0DnmZFaMYYLthK4fpCWK97e9OITmIb7UE4QzOMOcmGvWiiAJelvcmcu
         b8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUOK2ecPq1St75wbSqklvSmYw21nCLS8MUX7ZcnV+1zO6SX5X/EZFS2bap90BBIYrz1T/QMqa8ykD6r/+86@vger.kernel.org, AJvYcCUuR7Q5IDbvdNJBfPzAZXsj17BL0oeoUQd89laB4csi/RbDIsSg6GxqUhbT5zAFvGZtKAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWz63ucVoZCO7X57ia1xM+Xe9QyY9Na9cGlQcpUv1BQrCNauWJ
	Yb5JiKEnHI3BtH6LMNGOI+//RRHV3Ri230YihpK4hqPvWITl/i6lnRboremvzfimGHivaPOJnZM
	x7N503kieevRPuZ98gUX3L7p5YIyUlr5H
X-Google-Smtp-Source: AGHT+IEqHMbi2j0fRP2QPxxTAJGNwDx4627OAMqq9r/2qhEQfv8gjDfI5/ZhPDaoflmeQ/q+QRn4eS15ONjZoAHe/zA=
X-Received: by 2002:a05:6a21:58d:b0:1d6:e6b1:120f with SMTP id
 adf61e73a8af0-1d9a83d0b04mr586516637.11.1729887506639; Fri, 25 Oct 2024
 13:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025194010.515253-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241025194010.515253-1-mathieu.desnoyers@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Oct 2024 13:18:14 -0700
Message-ID: <CAEf4BzYV2jOpbCrY8g=VQuMw8p+3An52YKo2-CyaXJ_xCS_SVw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] tracing: Fix syscall tracepoint use-after-free
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 12:41=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> The grace period used internally within tracepoint.c:release_probes()
> uses call_rcu() to batch waiting for quiescence of old probe arrays,
> rather than using the tracepoint_synchronize_unregister() which blocks
> while waiting for quiescence.
>
> With the introduction of faultable syscall tracepoints, this causes
> use-after-free issues reproduced with syzkaller.
>
> Fix this by introducing tracepoint_call_rcu(), which uses the
> appropriate call_rcu() or call_rcu_tasks_trace() before invoking the
> rcu_free_old_probes callback.
>
> Use tracepoint_call_rcu() in bpf_link_free() for raw tracepoints as
> well, which has the same problem for syscall tracepoints. Ditto for
> bpf_prog_put().
>
> Reported-by: syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
> Fixes: a363d27cdbc2 ("tracing: Allow system call tracepoints to handle pa=
ge faults")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Michael Jeanson <mjeanson@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Jordan Rife <jrife@google.com>
> ---
> Changes since v0:
> - Introduce tracepoint_call_rcu(),
> - Fix bpf_link_free() use of call_rcu as well.
>
> Changes since v1:
> - Use tracepoint_call_rcu() for bpf_prog_put as well.
> ---
>  include/linux/tracepoint.h |  9 +++++++++
>  kernel/bpf/syscall.c       | 36 +++++++++++++++++++++++++++---------
>  kernel/tracepoint.c        | 22 ++++++++++++++++++----
>  3 files changed, 54 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 0dc67fad706c..45025d6b2dd6 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -104,6 +104,8 @@ void for_each_tracepoint_in_module(struct module *mod=
,
>   * tracepoint_synchronize_unregister must be called between the last tra=
cepoint
>   * probe unregistration and the end of module exit to make sure there is=
 no
>   * caller executing a probe when it is freed.
> + * An alternative to tracepoint_synchronize_unregister() is to use
> + * tracepoint_call_rcu() for batched reclaim.
>   */
>  #ifdef CONFIG_TRACEPOINTS
>  static inline void tracepoint_synchronize_unregister(void)
> @@ -111,9 +113,16 @@ static inline void tracepoint_synchronize_unregister=
(void)
>         synchronize_rcu_tasks_trace();
>         synchronize_rcu();
>  }
> +
> +void tracepoint_call_rcu(struct tracepoint *tp, struct rcu_head *head,
> +                        void (*callback)(struct rcu_head *head));
> +
>  #else
>  static inline void tracepoint_synchronize_unregister(void)
>  { }
> +static inline void tracepoint_call_rcu(struct tracepoint *tp, struct rcu=
_head *head,
> +                                      void (*callback)(struct rcu_head *=
head))
> +{ }
>  #endif
>
>  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 59de664e580d..f21000f33a61 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2992,28 +2992,46 @@ static void bpf_link_defer_dealloc_mult_rcu_gp(st=
ruct rcu_head *rcu)
>                 call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
>  }
>
> +static void bpf_link_defer_bpf_prog_put(struct rcu_head *rcu)
> +{
> +       struct bpf_prog_aux *aux =3D container_of(rcu, struct bpf_prog_au=
x, rcu);
> +
> +       bpf_prog_put(aux->prog);
> +}
> +
>  /* bpf_link_free is guaranteed to be called from process context */
>  static void bpf_link_free(struct bpf_link *link)
>  {
>         const struct bpf_link_ops *ops =3D link->ops;
> +       struct bpf_raw_tp_link *raw_tp =3D NULL;
>         bool sleepable =3D false;
>
> +       if (link->type =3D=3D BPF_LINK_TYPE_RAW_TRACEPOINT)
> +               raw_tp =3D container_of(link, struct bpf_raw_tp_link, lin=
k);
>         bpf_link_free_id(link->id);
>         if (link->prog) {
>                 sleepable =3D link->prog->sleepable;
>                 /* detach BPF program, clean up used resources */
>                 ops->release(link);
> -               bpf_prog_put(link->prog);
> +               if (raw_tp)
> +                       tracepoint_call_rcu(raw_tp->btp->tp, &link->prog-=
>aux->rcu,
> +                                           bpf_link_defer_bpf_prog_put);
> +               else
> +                       bpf_prog_put(link->prog);

it seems like it's problematic to bpf_prog_put() here, probably best
to do it after the link itself goes through RCU grace period. I can
adjust that as well and it will just work.

>         }
>         if (ops->dealloc_deferred) {
> -               /* schedule BPF link deallocation; if underlying BPF prog=
ram
> -                * is sleepable, we need to first wait for RCU tasks trac=
e
> -                * sync, then go through "classic" RCU grace period
> -                */
> -               if (sleepable)
> -                       call_rcu_tasks_trace(&link->rcu, bpf_link_defer_d=
ealloc_mult_rcu_gp);
> -               else
> -                       call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_g=
p);
> +               if (raw_tp) {
> +                       tracepoint_call_rcu(raw_tp->btp->tp, &link->rcu, =
bpf_link_defer_dealloc_rcu_gp);

I don't like this. See below, I don't think we should hide sleepable
tracepoint distinction, but also I don't think generic bpf_link_free()
needs to know anything about tracepoint case. Too much abstraction
leaking.

I think the way to go is to generalize sleepable BPF link support in
general and not derive it just from prog->aux->sleepable, but rather
from whether the attachment point is sleepable.

Let me work on this next week at least on BPF side, it's going to be a
bit too much back and forth if you are doing this and trying to guess
what makes sense on BPF side. I'll just need a simple way to detect if
tracepoint target is sleepable (faultable) or not, and the rest we can
handle here, I think.

> +               } else {
> +                       /* schedule BPF link deallocation; if underlying =
BPF program
> +                        * is sleepable, we need to first wait for RCU ta=
sks trace
> +                        * sync, then go through "classic" RCU grace peri=
od
> +                        */
> +                       if (sleepable)
> +                               call_rcu_tasks_trace(&link->rcu, bpf_link=
_defer_dealloc_mult_rcu_gp);
> +                       else
> +                               call_rcu(&link->rcu, bpf_link_defer_deall=
oc_rcu_gp);
> +               }
>         } else if (ops->dealloc)
>                 ops->dealloc(link);
>  }
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 6474e2cf22c9..ef60c5484eda 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -106,13 +106,27 @@ static void rcu_free_old_probes(struct rcu_head *he=
ad)
>         kfree(container_of(head, struct tp_probes, rcu));
>  }
>
> -static inline void release_probes(struct tracepoint_func *old)
> +static bool tracepoint_is_syscall(struct tracepoint *tp)
> +{
> +       return !strcmp(tp->name, "sys_enter") || !strcmp(tp->name, "sys_e=
xit");

Is this really how we know that the tracepoint is sleepable? Based on
its name? Isn't there some flag or something? This is the part I'd
need help with, but hopefully it's not string comparison based.

> +}
> +
> +void tracepoint_call_rcu(struct tracepoint *tp, struct rcu_head *head,
> +                        void (*callback)(struct rcu_head *head))
> +{
> +       if (tracepoint_is_syscall(tp))
> +               call_rcu_tasks_trace(head, callback);
> +       else
> +               call_rcu(head, callback);
> +}

I'm leaning towards having the logic to handle sleepable tracepoints
in BPF link implementation (for raw tracepoint and maybe for classic
tracepoints as well) directly, instead of abstracting that behind
tracepoint_call_rcu(). We'll need to know whether tracepoint is
sleepable or not anyways, so no need to hide RCU calls, IMO.

pw-bot: cr

> +
> +static inline void release_probes(struct tracepoint *tp, struct tracepoi=
nt_func *old)
>  {
>         if (old) {
>                 struct tp_probes *tp_probes =3D container_of(old,
>                         struct tp_probes, probes[0]);
>
> -               call_rcu(&tp_probes->rcu, rcu_free_old_probes);
> +               tracepoint_call_rcu(tp, &tp_probes->rcu, rcu_free_old_pro=
bes);
>         }
>  }
>
> @@ -334,7 +348,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
>                 break;
>         }
>
> -       release_probes(old);
> +       release_probes(tp, old);
>         return 0;
>  }
>
> @@ -406,7 +420,7 @@ static int tracepoint_remove_func(struct tracepoint *=
tp,
>                 WARN_ON_ONCE(1);
>                 break;
>         }
> -       release_probes(old);
> +       release_probes(tp, old);
>         return 0;
>  }
>
> --
> 2.39.5
>

